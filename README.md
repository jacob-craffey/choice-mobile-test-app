# Choice Mobile Test

## Notes

In addition to the core functionality of the app, which consists of grabbing a collection of posts and individual instances of posts. The following features have been implemented to further enhance its UX:

- Gesture support for pulling to refresh on both Post List page & Post Detail page.
- Gesture support for long press on Post Detail to copy Post to clipboard.
  - Snackbar & vibration integration to notify user of copied Post
- Responsive design for web browser
- Scrollbar integration on Post List page
- Custom page navigation animation

### Additional Side Note Regarding API

The individual getPost call is rather superfluous on the Post Detail screen. I could have just passed the selected Post from the List to the Post Detail page and everything would have been fully functional. However, I've made the call anyways to simulate the scenario that we're expecting additional details about the Post that did not exist in the initial List payload.