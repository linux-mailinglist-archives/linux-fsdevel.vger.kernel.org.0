Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000124C4F1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 20:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbiBYTtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 14:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiBYTtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:49:24 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D251E4F
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 11:48:51 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d641c31776so44773777b3.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NgpmE/FrJdf9CcvT7xDl9XiMKrb3fdOEAmKa9X+aiBg=;
        b=Pa4p3cJIKh0v8N7aPOC1FVWvD6OXnn14IXmYUiQm/En4c2HOc8w9NMIFxoQtBcLJwo
         yupwWVpgYjq5v3G1uGSTik9SpNHdPOy/ClEZ5az5yZgnH0VIEE4uc67WgmczAyKnt3uT
         RVZSFBKbAVYc5QXhFZhnBbwQa1vwbfJsXN2lZBUKJVB/x+uZJjb8UqYNFUHX6fg34Jx7
         KcTRUqGg25vNz6rL2WyMD9BCsjDyEHirHjcSrR9BMJResSkQxX32ywzqgAPPpsw5bWEj
         DmxsNss7BpwOQS82Uc0KdL957MDIJpZv74hlSCIs3vszqpLyfLr7alVbBQMSW5uk1YIc
         HN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=NgpmE/FrJdf9CcvT7xDl9XiMKrb3fdOEAmKa9X+aiBg=;
        b=PNx+jKhoTHMGVnmH6VShLAGNuwnS6zMwdTBM/hfVqYOfPWmI38SJ2ibYnc6BCofrvk
         ZCliheShB61hWIKCtH7AKtuXNtHiIhfahji5YtP4pMEkc+sdZPoooa5uVLfcD6EPyo5v
         KrM/9s1yJxrJ1YLzu97Fa+NGla2CC5sh1YTFWCpAjKSRAEbXbfjJocCJ2TJzCWegFZ74
         yx8MkAdcdwouA696RnlfcxUPXbaNk93zbeHVsr1FiMOPNIO2v9C0JMr5Pk5Af4q/TkLo
         M4lCcGjw/kBakwEMX8+aPcJDh1uozeyM7ZoXgur0ACZfLF9iQ11Euq/jW1s2OtmfmkfT
         VawA==
X-Gm-Message-State: AOAM5337rg83GOi0/ptzQBRZhBrjt9BOyoqQHo4iT9kTTIrv8VcvV8gs
        rl+oYk/aRD3ztu4pn3C9lG+nIJi33v00S/KPius=
X-Google-Smtp-Source: ABdhPJwdlUYG6L+K13NxqvK0KXlHB0ZYlcT1VLtsE1M30TOyKInEreGHuQdob28oOYfYivaQCwbVvkqFMkJOyGJ/5Uo=
X-Received: by 2002:a81:9d7:0:b0:2d6:34d1:e917 with SMTP id
 206-20020a8109d7000000b002d634d1e917mr9319256ywj.126.1645818531210; Fri, 25
 Feb 2022 11:48:51 -0800 (PST)
MIME-Version: 1.0
Sender: w9013938821@gmail.com
Received: by 2002:a05:7000:8b1b:0:0:0:0 with HTTP; Fri, 25 Feb 2022 11:48:50
 -0800 (PST)
From:   Agnes George <agnesmrsgeorge@gmail.com>
Date:   Fri, 25 Feb 2022 19:48:50 +0000
X-Google-Sender-Auth: tvHAV5m2Jrrph62XNsuILm--Mlk
Message-ID: <CANr-Pa4dtHGnHQqYEydCmP9EE3YqFhgqSM+hEGjJ4aw0Hx83Dg@mail.gmail.com>
Subject: Dearest beloved in the Lord,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FORM_SHORT,
        MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1134 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [w9013938821[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [agnesmrsgeorge[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  1.1 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20
Dearest beloved in the Lord,

I am Ms. Agnes George,  a 75 year old British woman. I was born an orphan
and GOD blessed me abundantly with riches but no children nor husband which
makes me an unhappy woman. Now I am affected with cancer of the lung and
breast with a partial stroke which has affected my speech. I can no longer
talk well and half of my body is paralyzed, I sent this email to you with
the help of my private female nurse.

My condition is really deteriorating day by day and it is really giving me
lots to think about.  This has prompted my decision to donate all I have
for charity; I have made numerous donations all over the world. After going
through your profile, I decided to make my last donation of Ten Million
Five Hundred Thousand United Kingdom Pounds  (UK=C2=A310.500, 000, 00) to y=
ou as
my investment manager. I want you to build an Orphanage home with my name (
Agnes George  ) in your country.

If you are willing and able to do this task for the sake of humanity then
send me below information for more details to receive the funds.

1. Name...................................................

2. Phone number...............................

3. Address.............................................

4. Country of Origin and residence

Ms. Agnes George.
