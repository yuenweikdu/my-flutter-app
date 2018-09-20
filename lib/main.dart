import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';  // import the english_words package

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random(); // Add this line.
    return new MaterialApp(
      title: 'Start Up Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.pinkAccent
      ),
      home: new RandomWords(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have clicked the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final Set<WordPair> _saved = new Set<WordPair>();
  final List<WordPair> _suggestions = <WordPair>[];  //declares _suggestions
  final TextStyle _bigFont = const TextStyle(fontSize: 18.0);
  @override                                  // Add from this line ...
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
    title: new Text('Startup Name Generator'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list),onPressed : _pushSaved),
        ],
      ),
    body: _buildSuggestions(),


    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(
          (WordPair pair) {
            return new ListTile(
              title:new Text(
                pair.asPascalCase,
                style:_bigFont,
              ),
            );
        },

        );
        final List<Widget> divided = ListTile
          .divideTiles(
          context: context,
          tiles:tiles,
          )
          .toList();

        return new Scaffold(
          appBar: new AppBar (
            title: const Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
            );
          },
        ),
    );
  }

    Widget _buildSuggestions() {
      return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return new Divider();
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an
          // integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings
          // in the ListView,minus the divider widgets.
          final int index = i ~/ 2;
          // If you've reached the end of the available word
          // pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }
   Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _bigFont,
      ),
      trailing: new Icon (
        alreadySaved ? Icons.favorite :Icons.favorite_border,
        color: alreadySaved ? Colors.pink: null,
      ),
      onTap: () {         //calls build() method for state object
        setState(() {
          if (alreadySaved){
            _saved.remove(pair);
          }else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}