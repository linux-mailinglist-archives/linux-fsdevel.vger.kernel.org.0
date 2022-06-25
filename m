Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5D55ACA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiFYUlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 16:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiFYUlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:41:08 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8048213F3D
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jun 2022 13:41:07 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id q4so9555132qvq.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jun 2022 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=+8DDhZ2DvUUwsc7BBk/PCXx/FTX8nQeg+hQxTso4xHY=;
        b=L2o6V/8iOjVu+KKxtb8hlafn5VYtBb9mc+HkqStSFSiSlcop9SLfccUXyHmZVRsEeo
         4NTKrak0G+sA5vp0Rl8aQ+lP9IWT2+EX0+xqpu+XcvNuzjA4itij3abfA2xzhjehqUnN
         wkvFddzXuFAafuN8FBMw8rdaQFYrcaAMOeTSMGKj9ZGjtKRoI9MEYKc0NrqQ/T0AKyoz
         SAZVkM2YFZdr1a//3DwXAJPjP+x70oZ22jlGfAg6o3iU8y1FyOseicgWh9xo1okeOBeg
         hU4NsCNpvBQUK49tbyY8b4jO1h2tQMu99FX7XdkqOxr0l8LC5xVXiYNM6jfJqA7qvbtn
         yC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=+8DDhZ2DvUUwsc7BBk/PCXx/FTX8nQeg+hQxTso4xHY=;
        b=YhMyGSvY8iv0xiW22nNd6U+Q8aZsVt8BRqlAaupB+JWWA8bV1qayoA2mQlnCurbFt7
         QtcANW1PJGKzaJ3XkKPX5nizHC5to46GJStCT7D+iSZO9tUatEqhjPOMkGGyb0CMrW2Y
         EiAvXKtw/b3y1l0nMUq+DcvIovWx/rjIt58L6opAA55RF3Mk1/wzmr6ySaqOUxRpv09w
         hhpu25mnIdWzRFNeKeRju3eMVAAnb+L9+9xhZLISxr9wgjeNgcvXnN3H0NWVPmSLJ5ii
         i7omKLR4ec1uscPvhTNitVkLSeweZGlnO35M4Sn+lQ176lekpn1qdV9K1ZL4JJfnoij9
         faYQ==
X-Gm-Message-State: AJIora9ZHonywNdr0+5SXLtf5BUZE0mIKsnI2/TcB1vVke0gR5Jesk46
        QqIh7YpokI+k4Ll3j/Bptdk3w5UmLWIit42nKO4=
X-Google-Smtp-Source: AGRyM1sEw8CUMtSV90gVrlWG3uEeKUUHXEaGbzdvPYmsU75TuSU9+bw/zMchBsA6m7E1qw22PbR27pzcyOhNdTj4ydE=
X-Received: by 2002:ac8:5a49:0:b0:317:a417:65b5 with SMTP id
 o9-20020ac85a49000000b00317a41765b5mr4279756qta.214.1656189666603; Sat, 25
 Jun 2022 13:41:06 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsmelaniat@gmail.com
Received: by 2002:a05:620a:1a84:0:0:0:0 with HTTP; Sat, 25 Jun 2022 13:41:06
 -0700 (PDT)
From:   "Mrs.Candice Marie Benbow" <candicemariebenbow85@gmail.com>
Date:   Sat, 25 Jun 2022 20:41:06 +0000
X-Google-Sender-Auth: KbhjcFwYXqYP8-AwONSODcIVgbs
Message-ID: <CANL8XDux7ydFvkL=LF3rXzgr6+-+SXzVaePE4DfQDth0pqaJ6g@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5021]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsmelaniat[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Friend,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs.Candice Marie Benbow, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 Million Dollars) through I decided handover the money
in my account to you for help of the orphanage homes and the needy
once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs,Candice Marie Benbow.
