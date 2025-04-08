pub mod interaction_builder;
pub mod message_builder;
pub mod pact_builder;
pub mod request_builder;
pub mod response_builder;

#[macro_export]
macro_rules! impl_builder_nif {
    ($nif_name: literal, $builder: ident, $fn_name: ident ($($arg_name: ident: $arg_type: ident),*)) => {
        #[rustler::nif(name =  $nif_name)]
        pub fn $fn_name(
            builder: $builder,
            $($arg_name: $arg_type,)*
        ) -> rustler::NifResult<$builder> {
            builder.invoke(|b| {
                b.$fn_name($($arg_name),*);
                Ok(())
            })?;

            Ok(builder)
        }
    };
}
