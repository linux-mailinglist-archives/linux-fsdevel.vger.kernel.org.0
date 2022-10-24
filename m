Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC260B3A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiJXRNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiJXRNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:13:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF52E5EFF
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 08:48:37 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w6-20020a056830110600b00665bf86f012so965037otq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/iMctEYzDqVFyWtokX9RjkdMXE5fE21zQtx6IEQqr8=;
        b=glK4hX4aiXZtgG7vR3/g+wQIcl5oc5xOoCxh+8I6O4Jin7KvGAX5/qw5JRX8X5r+qr
         p8ByGigCDQ7C84cZKs89yshdLSIeAjAu+d02+raEHGsoTTnn+4ARtWcaRn7NTEqRwrV6
         dJg1SEgaS2pRFnAFvGoAMgazMk9sf9/sA7FGoT9x8pnnfI+hHZFGIGEhDkH6T8zkr9gq
         Tb642OZwOTIZBFrr6fsNS5mGd5oyOUIWnnvjZDrlM2dcEtNmwTk7n1nDtNTp+44Nvomi
         jdjmftLrFJ+jQJiUWWGvqAAdT8KF3/WEJhuXnENUevRdicRgY7PRYqXNofBLZg2PT9YK
         i4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/iMctEYzDqVFyWtokX9RjkdMXE5fE21zQtx6IEQqr8=;
        b=i9jXSE33DpYJAvVyYiccjfgnEusZGkCmzj3+7SmGmjN++dAAEiBY54fk0Y+rsjmiTk
         66QpCwusnyd8ZoARjxSH8VjbTt9zF9jP5eGBaZVeAN/vaqyCuDQHJhdKQrXtBNNWzjFQ
         kApftMNiFHdzC0f7Za2Yls2xDLskdAP0vXrvrfUsNWbhm1qftDjURqLMqhcwlyYfSUzt
         Jl9k6ehGuzxCGugEF3V/XyQ23c4x9t5KFVw7lYL6ycV6HcWEZa8bfKty86A8J+BJY5X5
         yD9pJHA4VndGcY+ocygsdrtMvtDymdMHlO5unkQHBFG3pck35M45K5nxhw64cPe4luAF
         S2mQ==
X-Gm-Message-State: ACrzQf0U3cCXISbo6Q6sLpkbWEBfDDQKI19UZGZqPpikC8HHhsViczGk
        1cokq1w/d/RHNXQr7FHj4U/25D2r7JEUcfjCVFE9xRQ4ScY=
X-Google-Smtp-Source: AMsMyM7aN1sw/7u5361g4qokMlq6n3KNp7TEaAJxkygWx28+ZqUmobdpIzM9Dl3t1QapJGPxPBdZS8IwupYDfNnY0bQ=
X-Received: by 2002:a25:ca02:0:b0:6ca:79c4:dcc1 with SMTP id
 a2-20020a25ca02000000b006ca79c4dcc1mr14029603ybg.416.1666621754708; Mon, 24
 Oct 2022 07:29:14 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.dorisdavid5@gmail.com
Received: by 2002:a05:7000:5b02:b0:3c6:8b5:f403 with HTTP; Mon, 24 Oct 2022
 07:29:14 -0700 (PDT)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Mon, 24 Oct 2022 07:29:14 -0700
X-Google-Sender-Auth: PA_nnyHqYFT7Kc6hdGlAW6BHs70
Message-ID: <CA+=KUqzr3Ae4rENWUjAnkE23Y2-b=7ZEpaZv92BuEZWx9eoW6A@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.dorisdavid5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.dorisdavid5[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs.Doris David, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

may God Bless you,
Mrs.Doris David,
