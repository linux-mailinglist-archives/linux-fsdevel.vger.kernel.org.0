Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF96394BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 10:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiKZJAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Nov 2022 04:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKZJAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Nov 2022 04:00:10 -0500
X-Greylist: delayed 1290 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Nov 2022 01:00:05 PST
Received: from sp13.canonet.ne.jp (sp13.canonet.ne.jp [210.134.168.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBC802098C;
        Sat, 26 Nov 2022 01:00:05 -0800 (PST)
Received: from csp13.canonet.ne.jp (unknown [172.21.160.133])
        by sp13.canonet.ne.jp (Postfix) with ESMTP id 099161E03D3;
        Sat, 26 Nov 2022 17:17:37 +0900 (JST)
Received: from echeck13.canonet.ne.jp ([172.21.160.123])
        by csp3 with ESMTP
        id yqNVovGVhxJr5yqNVocUA4; Sat, 26 Nov 2022 17:17:37 +0900
X-CNT-CMCheck-Reason: "undefined", "v=2.4 cv=S49nfKgP c=1 sm=1 tr=0
 ts=6381cba1 cx=g_jp:t_eml p=JJaDG7uySNsA:10 p=Ik1pXvdftEAPl7FGfynI:22
 a=c8wCX2VJ6RehaN9m5YqYzw==:117 a=yr9NA9NbXb0B05yJHQEWeQ==:17
 a=PlGk70OYzacA:10 a=kj9zAlcOel0A:10 a=9xFQ1JgjjksA:10 a=x7bEGLp0ZPQA:10
 a=JQiPw2jszkcqZPIXoVMA:9 a=CjuIK1q_8ugA:10"
X-CNT-CMCheck-Score: 100.00
Received: from echeck13.canonet.ne.jp (localhost [127.0.0.1])
        by esets.canonet.ne.jp (Postfix) with ESMTP id 9B11A1C0251;
        Sat, 26 Nov 2022 17:17:37 +0900 (JST)
X-Virus-Scanner: This message was checked by ESET Mail Security
        for Linux/BSD. For more information on ESET Mail Security,
        please, visit our website: http://www.eset.com/.
Received: from smtp13.canonet.ne.jp (unknown [172.21.160.103])
        by echeck13.canonet.ne.jp (Postfix) with ESMTP id 6BA4E1C0263;
        Sat, 26 Nov 2022 17:17:37 +0900 (JST)
Received: from eikohnet.co.jp (webmail.canonet.ne.jp [210.134.169.250])
        by smtp13.canonet.ne.jp (Postfix) with ESMTPA id A506115F964;
        Sat, 26 Nov 2022 17:17:36 +0900 (JST)
MIME-Version: 1.0
Message-ID: <20221126081736.00001C7B.0156@eikohnet.co.jp>
Date:   Sat, 26 Nov 2022 17:17:36 +0900
From:   "Mrs Zainab Abbas" <toda@eikohnet.co.jp>
To:     <Inbox@eikohnet.co.jp>
Reply-To: <mrs.zainababbas75@gmail.com>
Subject: Hi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Priority: 3
ORGANIZATION: Mrs Zainab Abbas
X-MAILER: Active! mail
X-EsetResult: clean, %VIRUSNAME%
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1669450657;VERSION=7940;MC=3218539519;TRN=0;CRV=0;IPC=210.134.169.250;SP=4;SIPS=1;PI=5;F=0
X-I-ESET-AS: RN=0;RNP=
X-ESET-Antispam: OK
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_MR_MRS,
        SPF_HELO_NONE,SPF_PASS,UNRESOLVED_TEMPLATE,XPRIO_SHORT_SUBJ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5018]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.3 UNRESOLVED_TEMPLATE Headers contain an unresolved template
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.zainababbas75[at]gmail.com]
        *  1.0 HK_NAME_MR_MRS No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.4 XPRIO_SHORT_SUBJ Has X Priority header + short subject
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello,
Good day, I am still waiting for your reply to my previous email, hope you see the email?

Regards
Mrs Zainab Abbas


