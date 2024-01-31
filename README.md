# API_Python_Behave
1) A user can have as many accounts as they want.2) A user can create and delete accounts.3) A user can deposit and withdraw from accounts.4) An account cannot have less than $100 at any time in an account.5) A user cannot withdraw more than 90% of their total balance from an account in a single transaction.6)cannot deposit more than $10,000

# Installation

1. Download or clone the repository 
2. Open a terminal
3. Go to the project root directory.
4. Create a virtual environment: python3 -m venv virtualenv
5. Activate the virtual environment executing the following script: source virtualenv/bin/activate
6. Execute the following command to download the necessary libraries: pip install -r requirements.txt

# Configuration

1. Setup the OAuth Token in the "token" variable in "/features/steps/request_steps.py" file.

# Test Execution

1. Open a terminal
2. From the project root directory run: `behave -f html -o results/behave-report.html`

# Results

1. A result file (behave-report.html) will be generated in the "/results" folder