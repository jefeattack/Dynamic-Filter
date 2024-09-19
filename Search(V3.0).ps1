Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "AcroSearch(V3.0) Dynamic Acronym Search"
$form.Size = New-Object System.Drawing.Size(700, 400)
$form.StartPosition = "CenterScreen"

# Create a Panel for the ListBox
$panel = New-Object System.Windows.Forms.Panel
$panel.Dock = "Fill"
$panel.Padding = New-Object System.Windows.Forms.Padding(40)

# Create a TextBox for user input
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Dock = "Top"
$textBox.Height = 40
$textBox.Font = New-Object System.Drawing.Font("Arial", 14)

# Create a ListBox for Displaying Results
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Dock = "Fill"
$listBox.Font = New-Object System.Drawing.Font("Arial", 12)

# Create a Button for Google search
$btnGoogle = New-Object System.Windows.Forms.Button
$btnGoogle.Text = "Search Google"
$btnGoogle.Dock = "Bottom"
$btnGoogle.Height = 40

# Create a Label for Instructions
$instructionsLabel = New-Object System.Windows.Forms.Label
$instructionsLabel.Text = "PUT TEXT INSTRUCTIONS HERE"
$instructionsLabel.Dock = "Bottom"
$instructionsLabel.AutoSize = $true
$instructionsLabel.Padding = New-Object System.Windows.Forms.Padding(30)
$instructionsLabel.Font = New-Object System.Drawing.Font("Arial", 8)

# Add the ListBox to the Panel
$panel.Controls.Add($listBox)

# Add Controls to Form
$form.Controls.Add($textBox)
$form.Controls.Add($panel)
$form.Controls.Add($btnGoogle)
$form.Controls.Add($instructionsLabel)

# Define a self-contained list of items
$listitems = @("item one", "item two", "item three")

# Intitialize ListBox with full list
$listBox.Items.AddRange($listItems)

#Update ListBox based on TextBox input
$textBox.Add_TextChanged({
  $filterText = $textBox.Text.ToLower()
  $filteredItems = $listItems | Where-Object { $_.ToLower().Contains($filterText) }
  $listBox.Items.Clear()
  $listBox.Items.AddRange($filteredItems)
})

# Google Search Button Click Event
$btnGoogle.Add_Click({
  if ($listBox.Items.Count -gt 0) {
      $topItem = $listBox.Items[0]
      $query = [System.Uri]::EscapeDataString($topItem)
      $url = "https://www.google.com/search?q=$query"
  } else {
      [System.Windows.Forms.MesageBox]::Show("The ListBox is empty.")
  }
})

# Double-Click Event for ListBox
$listBox.Add_DoubleClick({
  if ($listBox.SelectedItem -ne $null) {
      $selectedItem = $listBox.SelectedItem
      $query = [System.Uri]::EscapeDataString($selectedItem)
      $url = "https://www.google.com/search?q=$query"
  } else {
      [System.Windows.Forms.MessageBox]::Show("No item selected.")
  }
})

# Show the Form
$form.ShowDialog()
