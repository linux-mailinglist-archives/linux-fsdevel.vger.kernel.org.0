Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF50B7330A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 14:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbjFPMBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 08:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbjFPMA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:00:58 -0400
X-Greylist: delayed 21478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jun 2023 05:00:53 PDT
Received: from mailgw.vast.vn (mail.vast.vn [210.86.230.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58217273F
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 05:00:52 -0700 (PDT)
Received: from mail.vast.vn ([10.18.2.60])
        by mailgw.vast.vn  with ESMTP id 35G62amk024736-35G62amm024736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 16 Jun 2023 13:02:36 +0700
Received: from localhost (localhost [127.0.0.1])
        by mail.vast.vn (Postfix) with ESMTP id 6E07CC676CB2F;
        Fri, 16 Jun 2023 13:01:02 +0700 (+07)
X-Virus-Scanned: amavisd-new at mail.vast.vn
Received: from mail.vast.vn ([127.0.0.1])
        by localhost (mail.vast.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VodtCzhjgtKI; Fri, 16 Jun 2023 13:01:02 +0700 (+07)
Received: from mail.vast.vn (mail.vast.vn [10.18.2.60])
        by mail.vast.vn (Postfix) with ESMTP id 838D9C676CB26;
        Fri, 16 Jun 2023 13:01:00 +0700 (+07)
Date:   Fri, 16 Jun 2023 13:01:00 +0700 (ICT)
From:   Mr Rowell <mthnguyen@sti.vast.vn>
Reply-To: rowellhambrick07@gmail.com
Message-ID: <723992395.7708755.1686895260485.JavaMail.zimbra@sti.vast.vn>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.2.60]
X-Mailer: Zimbra 8.7.11_GA_3865 (zclient/8.7.11_GA_3865)
Thread-Index: 4Yeq7vqDkSxLVdVrc70UrXDsl+Pzuw==
Thread-Topic: 
X-FE-Policy-ID: 2:1:0:SYSTEM
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_60,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_MR_MRS,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7434]
        * -2.3 RCVD_IN_DNSWL_MED RBL: Sender listed at https://www.dnswl.org/,
        *       medium trust
        *      [210.86.230.115 listed in list.dnswl.org]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [210.86.230.115 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rowellhambrick07[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 MISSING_HEADERS Missing To: header
        *  1.0 HK_NAME_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Did you get my last mail
