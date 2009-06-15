Radiant *Questionnaire* Extension
======================================

<table>
    <tr>
        <td>Author</td>
        <td>Pascal N&auml;f - <a href="http://www.screenconcept.ch">Screen Concept</a></td>
    </tr>
    <tr>
        <td>Contact:</td>
        <td>pascal.naef AT screenconcept DOT ch</td>
    </tr>
</table>

About *Questionnaire* Extension
------------------------------------
This extension allows you to do a questionnaire with Radiant. In the backend you can create a questionnaire very easily.
You can choose 4 type of questions:
  1. Freetext
  2. Singel-answer
  3. Multiple-answer
  4. Rating (1..4)

With simple radius tags (see usagae) you can display the questonnaire on the frontend.

Also in the backend you can clone a questionnaire (as example for multiple languages) and export the answers to Excel.


Installation
------------

1) Install the Questionnaire Extension

git clone git://github.com/screenconcept/radiant-questionnaire-extension.git vendor/extensions/questionnaire

2) run migration and update

rake radiant:extensions:questionnaire:migrate
rake radiant:extensions:questionnaire:update

3) Start (or restart) your server

Usage Example
-------------

  <r:questionnaire title="[questionnaire]">
    <r:questionnaire:form>
      <input id="questionnaire_redirect_to" name="questionnaire_redirect_to" type="hidden"
        value="<r:children><r:first><r:url/></r:first></r:children>" />
      <div class="name links">
        <label for="questionnaire_results[firstname]">First name</label>
        <div id="questionnaire-error-firstname">
          <r:questionnaire:results:firstname />
        </div>
      </div>
      <div class="name rechts">
        <label for="questionnaire_results[lastname]">Surname</label>
        <div id="questionnaire-error-lastname">
          <r:questionnaire:results:lastname />
        </div>
      </div>
      <div class="name">
        <label for="questionnaire_results[email]">E-Mail Address</label>
        <div id="questionnaire-error-email">
          <r:questionnaire:results:email />
        </div>
      </div>
      <div id="questionnaire-questions">
        <r:questionnaire:questions:each>
          <div class="questionnaire-question">
            <r:questionnaire:questions:question />
            <div class="questionnaire-question-answer">
              <r:questionnaire:questions:answers />
            </div>
          </div>
        </r:questionnaire:questions:each>
      </div>
      <div id="questionnaire-submit"><input value="Send" type="submit"></div>
    </r:questionnaire:form>
  </r:questionnaire>

Contributors
------------

* [Roman Simecek](http://www.screenconcept.ch/)

Sponsors
--------

Some work has been kindly sponsored by:

* [avaloq] (http://www.avaloq.ch)
* [Screen Concept](http://www.screenconcept.ch)

License
-------

This extension is released under the MIT license, see the [LICENSE](master/LICENSE) for more
information.