#include "headers/exchange.h"


Exchange::Exchange(QObject *parent) : QObject(parent),
    form(FormFactory::getInstance().CreateForm("Form")),
    db(&Data_base::get_instance())
{
    form->mform.insert("Result", "00.00");
    form->mform_edited.insert("Result", false );
}

QString Exchange::getresult(QString amount, double converter)
{
    QVariant res=amount.toDouble()*converter;
    return res.toString();
}
