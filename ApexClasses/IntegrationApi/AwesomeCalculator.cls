/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-28-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class AwesomeCalculator {

    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calculator = new calculatorServices.CalculatorImplPort();
        return calculator.doAdd(x, y);
    }
}