Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7ED63E248
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 21:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiK3Uoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 15:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK3Uob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:44:31 -0500
X-Greylist: delayed 725 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 12:44:30 PST
Received: from sp12.canonet.ne.jp (sp12.canonet.ne.jp [210.134.168.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C19DF7B620
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 12:44:30 -0800 (PST)
Received: from csp12.canonet.ne.jp (unknown [172.21.160.132])
        by sp12.canonet.ne.jp (Postfix) with ESMTP id DAC2C1E059C;
        Thu,  1 Dec 2022 05:32:23 +0900 (JST)
Received: from echeck12.canonet.ne.jp ([172.21.160.122])
        by csp2 with ESMTP
        id 0Tklp8gw5yh2r0Tklp6qNj; Thu, 01 Dec 2022 05:32:23 +0900
X-CNT-CMCheck-Reason: "undefined", "v=2.4 cv=HvXIp2fS c=1 sm=1 tr=0
 ts=6387bdd7 cx=g_jp:t_eml p=ZMph9Jy3UboA:10 p=et4T4aBE6iSmLst72HwA:9
 p=pOQp6VyLxH7D_L77S6qH:22 a=5J8QHEf9WaWkijFsPIoXCQ==:117
 a=yr9NA9NbXb0B05yJHQEWeQ==:17 a=PlGk70OYzacA:10 a=kj9zAlcOel0A:10
 a=sHyYjHe8cH0A:10 a=x7bEGLp0ZPQA:10 a=CjuIK1q_8ugA:10 a=0iaRBTTaEecA:10
 a=xo5jKAKm-U-Zyk2_beg_:22"
X-CNT-CMCheck-Score: 100.00
Received: from echeck12.canonet.ne.jp (localhost [127.0.0.1])
        by esets.canonet.ne.jp (Postfix) with ESMTP id 955481C01F5;
        Thu,  1 Dec 2022 05:32:23 +0900 (JST)
X-Virus-Scanner: This message was checked by ESET Mail Security
        for Linux/BSD. For more information on ESET Mail Security,
        please, visit our website: http://www.eset.com/.
Received: from smtp12.canonet.ne.jp (unknown [172.21.160.102])
        by echeck12.canonet.ne.jp (Postfix) with ESMTP id 6A37F1C0249;
        Thu,  1 Dec 2022 05:32:23 +0900 (JST)
Received: from kanesaki-kawara.co.jp (webmail.canonet.ne.jp [210.134.169.250])
        by smtp12.canonet.ne.jp (Postfix) with ESMTPA id A075E15F966;
        Thu,  1 Dec 2022 05:32:22 +0900 (JST)
MIME-Version: 1.0
Message-ID: <20221130203222.00007146.0649@kanesaki-kawara.co.jp>
Date:   Thu, 01 Dec 2022 05:32:22 +0900
From:   "Richard Lee" <junko@kanesaki-kawara.co.jp>
To:     <INBOX@kanesaki-kawara.co.jp>
Reply-To: <richardeeoo@gmail.com>
Subject: INQUIRY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Priority: 3
ORGANIZATION: Richard Lee
X-MAILER: Active! mail
X-EsetResult: clean, %VIRUSNAME%
X-ESET-AS: R=SPAM;S=100;OP=CALC;TIME=1669840343;VERSION=7941;MC=3141234356;TRN=15;CRV=0;IPC=210.134.169.250;SP=4;SIPS=1;PI=5;F=0
X-I-ESET-AS: RN=442,624:0;RNP=richardeeoo@gmail.com
X-ESET-Antispam: SPAM
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,UNRESOLVED_TEMPLATE,XPRIO_SHORT_SUBJ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [210.134.168.89 listed in bl.score.senderscore.com]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [210.134.168.89 listed in wl.mailspike.net]
        *  1.3 UNRESOLVED_TEMPLATE Headers contain an unresolved template
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.0 XPRIO_SHORT_SUBJ Has X Priority header + short subject
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Greetings,

I trust you are well. I sent you an email yesterday,
I just want to confirm if you received it.
Please let me know as soon as possible,

Thank you.


