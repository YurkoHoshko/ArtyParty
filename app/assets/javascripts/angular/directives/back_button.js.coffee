App.directive "backButton", ->
  restrict: "E"
  template: "<a class=\"btn btn-small\">{{back}}</a>"
  scope:
    back: "@back"
    icons: "@icons"

  link: (scope, element, attrs) ->
    $(element[0]).on "click", ->
      history.back()
      scope.$apply()

