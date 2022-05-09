Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD29520612
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 22:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiEIUoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiEIUoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 16:44:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A4B285EC2
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 13:40:16 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m25so16491565oih.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 May 2022 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=NjIe7CM4oEbAvSTD8XZiDKT+3TdwiFQlXyv3dANIpe8=;
        b=Jqqnv+AH3xynrme8afCCTvFHbSACsMxS+BfAG1fcKzPYyszUsuH7lSOR5yuRS6umNA
         KfeuXCN1B9tDG3KsuiT4FaF61J9lVQPYXhah3H1/7ahJvQJ6Fo4jGywJl3psYTMrop4G
         YvgNimiWvZWTQm5cmxVJCiYU3fWtVNR39inucJ7pgsZKZibQD+DtpHz7+4qZM/6qSgmF
         s8/kKDP/qQjjj6njSodpcvgI1M9yI11YUUkgmVRR1TWkx1ePQmlwSQZs7ZvvquBG/vD5
         ZeMGeUrQvkV1T1Ry9WSfzGdmaE7H6mr2eS8seQW1xdkFVAvAOS3ATNE/uzf6pAkNGmcr
         ZsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=NjIe7CM4oEbAvSTD8XZiDKT+3TdwiFQlXyv3dANIpe8=;
        b=GcAq9lclf3NOFLDC1tVf/xuhTutgKE1kXIN4XqLdaSvU2P+NaPuI/IxNY6iu5Ec+hX
         +gwS1nW/fxr6RqsOnopdbzTVNqlsBcG1Kj0tyctWVoMhG3fh+vjuC7BQ9UAIpsY+ZzGb
         gUo/wQ8AVZNJAKcf0SWzxMl32+ZWvuPooYU1aT0d+Eo96DdXUpHG2/yT9KDHSimLhQP9
         z0fldPo3jj65scIkKXB8y648dI0e9cdB0/mukhkEkR5tWWgQq8a2/rEMptoVzNjyjueY
         0adHHcRbScI4uUV8Y8Q2rh4HyhD9EYIIcpcQLuVhc5m6HIM6fUh67N0qJqM9itpkWYSF
         4spw==
X-Gm-Message-State: AOAM5321U5EFnqbF4Q+NJHDUa/t92kFUvhaWTpjwv5MwZ6pVuWA7W8NJ
        WHOGEr6fB3N6T/2rkDgAbAhCkx9OwNt0qH6nuNA=
X-Google-Smtp-Source: ABdhPJy2UxW98NVfMWMV4sUjyMGWuhJXQTAIfdPeFowgadLuwTeR/b0GiULSwgRK2bA1q3At0ns8Oy3dsv3V50TgNq4=
X-Received: by 2002:a05:6808:ec5:b0:2f7:4019:53be with SMTP id
 q5-20020a0568080ec500b002f7401953bemr8449021oiv.176.1652128815272; Mon, 09
 May 2022 13:40:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:c483:b0:a0:4fee:e9f6 with HTTP; Mon, 9 May 2022
 13:40:14 -0700 (PDT)
Reply-To: oiiamkjaa@gmail.com
From:   "Rev Sister Grace, Charity Foundation. " <yecaanwe@gmail.com>
Date:   Tue, 10 May 2022 02:10:14 +0530
Message-ID: <CAKjGjT-XO87cBaE20g-X=VTvkJ-uE9nmY8RkazPtxXfoxax9ZA@mail.gmail.com>
Subject: Rev Sis Grace Charity Work.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:244 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yecaanwe[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
My Name Is Rev Sister Grace, Contact me for a Charity donation of $2.2
MILLION Dollars to you for charity work. Send Your Full Name & Your
Phone No At: oiiamkjaa@gmail.com
