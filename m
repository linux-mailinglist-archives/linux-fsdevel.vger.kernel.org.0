Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8BCCC1FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfJDRun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 13:50:43 -0400
Received: from sonic306-2.consmr.mail.bf2.yahoo.com ([74.6.132.41]:44240 "EHLO
        sonic306-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387996AbfJDRun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570211441; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=mjgQr4HZ6jG6KiN1mBbop02WQWj5wNOw3waP4mtaAaRCzLiSgMn/0Nm00CLrNH47AnVr168yTNSwyBBTl40Ao27MQPS440PowPQCVPGyfoEs6qiWiE5weLoOtFtif4/AYRqxTZANNZn/CZ0PL/ob12XvXCZAqYp1oKv+O04pYaqVxi5HOFDsonwzyFtxeUKSsfeWsNl51Y6a+H/v4pSJJBCHbnff+ieo6nXtSuoi7A/V7ZZcP4dDcOBFKW2RQ71xm0ohtGttKoE4fHoHkB1dgTRaLqSDZxeGMHdW/pcXDKvN6RPyfYYfnNWwf6WrORExoIkJKwYxONf42Fo45tr5iw==
X-YMail-OSG: RVtGigQVM1nGWR9VfDhDGgmWlwx70OZk8.U1CnottfNBEBKF227fifeV5zJa2yM
 diKp1P71TAUI0InEYvscPMPEhscQqL2i.mdz7zLE3VwDTEx2wnlw639qB.UkA5FHmLTaKEN8kQTc
 Ib.9q43l0WDNt304lTWQV5f.JJhbIdSP8kbgOjnX5sexy_HiyPS38gPQSeeKrsxze76xBrR8xZG9
 YkK1k9xqcPbN5iBBZRegvDZkdzyy9nGATQFg4Nh2YVB30cWIWepa1FVElL.qGzMQDCx99Eer_3AU
 0jYNGaz39Hj3ZispRCnKmDzj5Zj2LU5Pz4NAaIauf0u_AyN2wefE9zYJQxV8Yi8zFRQXOdfdKhQ.
 Jo6kAQa3oKYIX0OmVMNjtVZVq_ubnTl.a29Qz1pg5sUSJnUPinoMqQtLkhYxQsDOLmmf2hHX3IVZ
 AvhX40Qu8jdj.jifAzfgQc8E.lKFmGKXAiNNrzp5P8KJ1qESG1QFtqkAdlkOnm9Api0_HTL0HpxU
 JgSfG4iVbhF2l0mKmwoN6FeLpHCys_jrZjpYN5be6Se.S.i0IBeQZBtCfBdQ1FXayCGXR0dj5ziG
 fMTVaAkB57txWNVTp.ReJ_.ZSDlv6vDPkP29gBrcV8LYb1ql2F2kPfEdNOlLyokt5D5C4aaqNiNt
 OojtM4mdzYW3ZD8OownbX0RcVH06DhO3yd2n_YAHZ9OjZM56S1foP.IbKlqLJbDiTpgsat0no1TK
 czOkHGwoBouimExw.VN_hzlz2_GgmJLx._1Twz3IVrVt46YTpK1QgITxExkaDm1wgKvzkFCgsbNe
 cW8LgXerwlbHEbFLl3wQbRIR1h2uMp1CGtHjiYUNllK62UJStxlqOQ_mILCi8I0qpnNgnZS6NS0q
 a6HvWxHLYCrrzJMAuSZidHLZ3heIGWXHg9nJ4EDv8PnSCUYejTAQdCWE.erjR8lbsKc1jPlWucyK
 DjL0iTCaNTzBUZF.raPxqlQe2kAxzJu90uQEce3HiJRa0FfzirM058WhbciyOC5AWSTr0zhueytm
 tdJs7xqtdc0hP9Wltzsj28zeMhdC5_eKQ5zSDsPVLLCT2N4z6DrgEufCGpgg9fxViN5El4if3ngh
 UUUk5J56oyFFfItCF4Tq0_55oQR.lgK4i6k.Sy69Q_deGtdKWWoCVoZti.feAJHmSKvK7sSz1lSF
 AiaZ1GzJaQpty9hwDcfEkVCyXV3k.SblKBY7rZIfU1V75cmLCjbwIQUX.0oBjin3ZoHFLSS9Pves
 Fqiz69CHkJVGN.AcxdcNbietlJNzPhoqQCrH.IM.RO0PZpnii0_XHijLYXcF9Cfnhdfk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 4 Oct 2019 17:50:41 +0000
Date:   Fri, 4 Oct 2019 17:50:37 +0000 (UTC)
From:   Aisha Gaddafi <aishag044444@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <673950956.2419034.1570211437305@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
