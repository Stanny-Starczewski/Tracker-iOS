# Specification of a mobile application for tracking habits

# Links

[Figma Design](https://www.figma.com/file/owAO4CAPTJdpM1BZU5JHv7/Tracker-(YP)?t=SZDLmkWeOPX4y6mp-0)

# Purpose and goals of the application

The application helps users form healthy habits and monitor their implementation.

Application goals:

- Control of habits by day of the week;
- View progress by habits;

# Brief description of the application

- The application consists of tracker cards that the user creates. He can specify the name, category and set the schedule. You can also choose an emoji and color to differentiate the cards from each other.
- Cards are sorted by category. The user can search for them using search and filter.
- Using the calendar, the user can see what habits he has planned for a specific day.
- The application has statistics that reflect the user's successful performance, progress and average values.

# Functional requirements

## Onboarding

When logging into the app for the first time, the user is taken to an onboarding screen.

**The onboarding screen contains:**

1. Screensaver;
2. Title and secondary text;
3. Page controls;
4. The “This is technology” button.

**Algorithms and available actions:**

1. By swiping right and left, the user can switch between pages. When switching pages, page controls change state;
2. When you click on the “This is technology” button, the user goes to the main screen.

## Creating a habit card

From the home screen, the user can create a tracker for a habit or irregular event. A habit is an event that repeats with a certain frequency. An irregular event is not tied to specific days.

**The habit tracker creation screen contains:**

1. Screen title;
2. Field for entering the name of the tracker;
3. Category section;
4. Schedule settings section;
5. Emoji section;
6. Section with the choice of tracker color;
7. “Cancel” button;
8. “Create” button.

**The screen for creating a tracker for an irregular event contains:**

1. Screen title;
2. Field for entering the name of the tracker;
3. Category section;
4. Emoji section;
5. Section with the choice of tracker color;
6. “Cancel” button;
7. “Create” button.

**Algorithms and available actions:**

1. The user can create a tracker for a habit or irregular event. The algorithm for creating trackers is similar, but the event does not have a schedule section.
2. The user can enter the name of the tracker;
     1. After entering one character, a cross icon appears. By clicking on the icon, the user can delete the entered text;
     2. The maximum number of characters is 38;
     3. If the user has exceeded the allowed quantity, an error text appears;
3. When you click on the “Category” section, the category selection screen opens;
     1. If the user has not previously added categories, then there is a stub;
     2. The last selected category is marked with a blue checkmark;
     3. By clicking on “Add category” the user can add a new one.
         1. A screen will open with a field for entering a name. The "Done" button is inactive;
         2. If at least 1 character is entered, the “Done” button becomes active;
         3. When you click on the “Done” button, the category selection screen opens. The created category is marked with a blue tick;
         4. Clicking on a category takes the user back to the habit creation screen. The selected category is displayed on the habit creation screen as secondary text under the “Category” heading;
4. In habit creation mode, there is a “Schedule” section. When you click on a section, a screen opens with a choice of days of the week. The user can toggle the switch to select the day the habit will be repeated;
     1. Clicking “Done” returns the user to the habit creation screen. The selected days are displayed on the habit creation screen as secondary text under the “Schedule” heading;
         1. If the user has selected all days, the text “Every day” is displayed;
5. The user can select an emoji. A background appears under the selected emoji;
6. The user can select the color of the tracker. A stroke appears on the selected color;
7. By clicking the “Cancel” button, the user can stop creating the habit;
8. The “Create” button is inactive until all sections are completed. When you press the button, the main screen opens. The created habit is displayed in the corresponding category;

## View the main screen

On the main screen, the user can view all created trackers for the selected date, edit them and view statistics.

**Home screen contains:**

1. “+” button to add a habit;
2. Heading “Trackers”;
3. Current date;
4. Field for searching for trackers;
5. Tracker cards by category. Cards contain:
     1. Emoji;
     2. Tracker name;
     3. Number of tracked days;
     4. Button to mark a completed habit;
6. “Filter” button;
7. Tab bar.

**Algorithms and available actions:**

1. When you click on “+”, a curtain pops up with the ability to create a habit or irregularity
