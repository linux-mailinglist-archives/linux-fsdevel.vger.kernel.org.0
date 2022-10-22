Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077D6608F85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Oct 2022 22:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJVUIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Oct 2022 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJVUIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Oct 2022 16:08:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CAC11D9AD
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Oct 2022 13:08:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jo13so1627402plb.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Oct 2022 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX77rc0vrj36igQ8AQAnxVIF5BQ5MavwsWkZcQck8BA=;
        b=JfnY2eYwIUAa5lUK4vbmm1WNxjOKlzgWdeGdTZn6CTfa2z3DlMoJrqoVQVA9UzcBC7
         OXl7lR+/YILcWz7MsMiS0qrWbylDp19C31dxuY/5WUBplJsxIxnsr4zEdoVOqzpfbYm1
         Zo9tmW33Pr305BtFSbHnYsrxNghqcu09unbTMfnKuOiljF8RSPx1kq/Ae6gzjywnsmzb
         QS0CBnjIKBZjcoyU7S72kAazk6QNmJIfO343ykwJQFIBJ/iBvkg6rb9Y0zi8+H012jnT
         munMJCyHdwgC9sJ/1vdkwtbJXGhO35zugcgZZFYw74U62vL2XqR1moUehKrGk4e2R5Au
         8Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qX77rc0vrj36igQ8AQAnxVIF5BQ5MavwsWkZcQck8BA=;
        b=36YDEwYBFQWcwuaM6SHUDUA6/gviS3EVXhNzgmR5D4uMUgImfWUgX5nDgHhXhlTTAm
         /1m925YRWTv7n9fq2zyBRXXqyhuh+wyFGdkVa4YXjaLF5Vu4vl37rWQc7fFlXo7a746x
         AzgjdM0kgMqaxebEotyxGDXVH3zhQwo2J853V/vcbTuIbgOb+Kx12poUPcG8srhpGZmz
         3GZlD6dTAYKNeOVuX+RFqfOiClNAY9uZLEvgh531JegP0ERx/BRkV1LGAG72RcqmM4B9
         qgGoVlyM1qM/mGlUsX5chsX9ajfWRTfgk+UjmTdUs1Ijpz3FNj0dQDt+fmuIGceNmHdm
         AvHg==
X-Gm-Message-State: ACrzQf0MZsBzSbDyNjsJ2hfpuOkyZNCxXuolcpJUhY7j95OebJ/9YUDG
        YAnXSM1dKcLfIW5p90i0JNiqwCZUV8OhoxVXXbMtTR/0FeJLkA==
X-Google-Smtp-Source: AMsMyM4pUW1iPWHhd3EfNqOsyIiFbNstBYS34nQO+tguPdJCtzxeQNPFTQI1eacK61JXla+w27NcB41dOtb1LQe7cNw=
X-Received: by 2002:a17:903:248:b0:172:7520:db04 with SMTP id
 j8-20020a170903024800b001727520db04mr25974769plh.99.1666469285208; Sat, 22
 Oct 2022 13:08:05 -0700 (PDT)
MIME-Version: 1.0
Sender: alimahazem@gmail.com
Received: by 2002:a05:6a11:c6:b0:2fc:6a17:5b33 with HTTP; Sat, 22 Oct 2022
 13:08:04 -0700 (PDT)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Sat, 22 Oct 2022 13:08:04 -0700
X-Google-Sender-Auth: TOnfBVwwIEnht-OoNNRbYgM_ymM
Message-ID: <CAFfm26uU1PDF8nUp1ombKcV6=yY37poQRGhFe5Cu1CJDbZRUKg@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62c listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6831]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
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
Mrs.david doris, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of ($11,000 000
00) my Doctor told me recently that I have serious sickness which is a
cancer problem. What disturbs me most is my stroke sickness. Having
known my condition, I decided to donate this fund to a good person
that will utilize it the way I am going to instruct herein. I need a
very Honest God.

fearing a person who can claim this money and use it for charity
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

May God Bless you,
Mrs.david doris,
