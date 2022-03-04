Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7BF4CD85F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 16:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiCDP4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 10:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiCDP4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:56:32 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9781C1C57F7
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 07:55:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id w7so1231660lfd.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=+e6DxsGRSH2mhsXI7GeLvIZXX1m4MD4Ab6z6xzst2ho=;
        b=cQmN4vglxTabDg7a6n33BOXnhcnyKD1WMlTxaTWiaspcPdjwkiI+djzZpZImPFVja/
         JCPzZ5hgjTl2i9NHQWdzzkkSeSmgiHUr65ANmnoFhDA9L1T2l7WPP7tMFrm9Rd5TMa8Q
         Q7r1J5okm8TQdp2Ycf5Q3o1ztT4jXUHtETNV2cqGG7I0Cy4i1OXeklUAJ8a1ZS+YJv7r
         VHNdE6Pg+y+PSSLmLk0BycOsNwo5EJf6+9taZFjpcB3SfeDF8K2S5PgdZsHqbsCFBNG/
         +w3IQdnbiS9ujOVI3D/rwxPcSiRJGWgr8s5ykp36lZg31lrPHukfRzY1wrt+3h6hpWzK
         /R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=+e6DxsGRSH2mhsXI7GeLvIZXX1m4MD4Ab6z6xzst2ho=;
        b=hn0uiAj+UUSBcjCBfC3ShPv6bxuscplBSe4TxjATE4of8C9srYY/QcysFQlPPzk8Bq
         +4pnmtb0qk9ctLDMHfisP/4bK/ExVPwKQSCSHq2M6rYiT1V1r0gDUL5wBA/QT49OBsja
         CVwgBQ1cFL1CdSufipnwFKYZEswG4AEt/mBbt+42Q4zR8KrS7AyaECNok2or4veS7VtD
         bN2eGnepg+PCcwQw8vHa5rSYjTaNOq+tvU18/p8r+lK1L1VUdXLCOfZ73pe4lijKWxL9
         3f6diTPN3Dcsa/wung2cUR6SuOOW94AmSW+gck+Ty96ut0eJywkaGY11sPjzwoJBPtD/
         OWMA==
X-Gm-Message-State: AOAM531Da4ka1s6Z4wZefxIFcMQMjpcSmtloQF2AkMDeJlh5T0ecpedb
        bHkCOLc5aOFI4eQe+rn9HEiZF1viagKRG002Umc=
X-Google-Smtp-Source: ABdhPJxYrKdTMvIvJjLNlVlqXd18b6idtbEq5pMQ6kZE1vUCSG5a5NNEyzr3pkBI55qtplR2y5056YobJk2UAPbQjcA=
X-Received: by 2002:a05:6512:33d5:b0:446:41b9:7256 with SMTP id
 d21-20020a05651233d500b0044641b97256mr4472420lfg.659.1646409338778; Fri, 04
 Mar 2022 07:55:38 -0800 (PST)
MIME-Version: 1.0
Sender: jenniferoscar85@gmail.com
Received: by 2002:ab3:7546:0:0:0:0:0 with HTTP; Fri, 4 Mar 2022 07:55:38 -0800 (PST)
From:   Aisha Al-Qaddafi <aisha.gdaff21@gmail.com>
Date:   Fri, 4 Mar 2022 07:55:38 -0800
X-Google-Sender-Auth: gTjQpU_QLjqvQW_xXtlP_XogGew
Message-ID: <CADQEMHTBe2_71wvrekVbndz=vhDRFRMwdPGQeCdYKoY+vzKepQ@mail.gmail.com>
Subject: Your Urgent Reply Will Be Appreciated
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:132 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jenniferoscar85[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aisha.gdaff21[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.6 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh
I came across your e-mail contact prior a private search while in need
of your assistance. I am Aisha Al-Qaddafi, the only biological
Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a
single Mother and a Widow with three Children.
I have investment funds worth Twenty Seven Million Five Hundred
Thousand United State Dollar ($27.500.000.00 ) and i need a trusted
investment Manager/Partner because of my current refugee status,
however, I am interested in you for investment project assistance in
your country, may be from there, we can build business relationship in
the nearest future. I am willing to negotiate investment/business
profit sharing ratio
with you base on the future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgent to enable me provide you more information about the investment
funds.
