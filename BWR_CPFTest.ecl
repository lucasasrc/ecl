IMPORT STD;

lInputDefault := RECORD
    STRING CPF;
    STRING NAME;
END;

lOutputDefault := RECORD
    STRING DATE;
    STRING CPF;
END;

dInputDefault := DATASET([{'448.221.778-66', 'Danilo'},{'184.715.875-72','Jose'}], lInputDefault);
dOutputNewLayout := PROJECT(dInputDefault, TRANSFORM(lOutputDefault, SELF.CPF := LEFT.CPF , SELF.DATE := '31012023'));

//Function to find and replace 
dDefaultCleaned := PROJECT(dOutputNewLayout, TRANSFORM(lOutputDefault, SELF.DATE := LEFT.DATE, SELF.CPF := STD.Str.FindReplace(LEFT.CPF,'.','')));
dOutputCleaned := PROJECT(dDefaultCleaned, TRANSFORM(lOutputDefault, SELF.DATE := LEFT.DATE, SELF.CPF := STD.Str.FindReplace(LEFT.CPF,'-','')));

OUTPUT(dInputDefault,named('DefaultBase'));
// OUTPUT(dOutputNewLayout, named('OutputWithNewLayout'));
OUTPUT(dOutputCleaned, named('CleanedCPFBaseFile'));