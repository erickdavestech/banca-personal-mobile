import 'package:banca_movil_libs/models/retenidos_y_diferidos.dart';
import 'package:banca_movil_libs/services/product_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'diferidos_event.dart';
part 'diferidos_state.dart';

class DiferidosBloc extends Bloc<DiferidosEvent, DiferidosState> {
  final ProductsServices _productsServices;

  DiferidosBloc(this._productsServices) : super(DiferidosInitial()) {
    on<GetDiferidos>((event, emit) async {
      try {
        emit(DiferidosLoading());
        final diferidos = await _productsServices.getRetenidosYDiferidos(
          accountNumber: event.accountNumber,
        );

        emit(DiferidosLoaded(diferidos));
      } on Exception catch (e) {
        emit(DiferidosError(e.toString()));
      }
    });
  }
}
