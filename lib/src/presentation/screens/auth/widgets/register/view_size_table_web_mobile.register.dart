
import 'package:clickbuy/src/presentation/screens/auth/widgets/register/bloc_consumer_widget.register.dart';
import 'package:flutter/material.dart';

class ViewTabletWeb extends StatelessWidget {
  const ViewTabletWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: _FromSection(),
            ),
            const SizedBox(width: 60),
            Flexible(
              flex: 1,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40.0),
                    child: BlocConsumerWidget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewMobile extends StatelessWidget {
  const ViewMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _FromSection(),
            SizedBox(height: 10,),
            BlocConsumerWidget()
          ],
        ),
      ),
    );
  }
}

class _FromSection extends StatelessWidget {
  const _FromSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.black12,
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.black12,
              child: Icon(
                Icons.person_add_alt_1,
                size: 90,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Crear cuenta",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Regístrate para comenzar tu experiencia.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}


