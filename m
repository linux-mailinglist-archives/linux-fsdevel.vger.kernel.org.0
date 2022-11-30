Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9936963D307
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 11:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiK3KRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 05:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiK3KRR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:17:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1763FC42
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 02:17:17 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso1014707wmo.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 02:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Th+G2QFbGAX06mg1aIwvVRiXrgkLj2KZ0HoeEj27hRA=;
        b=IHMKiRifX69U6VmNR7uTj7+/25rkD6+kBYzyHgaleFHg4tYr7tH5K6Ry/6xPEhj469
         qLBlM6aRg5gB45Y6qgNzvvKg14q60WtnDXNhQXBOHZMfm9pZ9v7TvpBvSSjTEa2zJ+vy
         GfFkAO9FN1+16fr3+KKDh21voaC4sYU2/L2bODVHxClr4BB6a14atm8J827VSHUpas8q
         sDCPOftzCMsB3K9U2hxJoRkO1MuGgTnHcjvMOvFbx3JRQAlWgSYJGXJkeRygMv8FbZtc
         2IB/SQmDa+/7WubfOMi85uU8x+jFB5Em1DQIrcQ6OPMbETo6apoXr9fU4TX1BOiuAMD9
         vqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th+G2QFbGAX06mg1aIwvVRiXrgkLj2KZ0HoeEj27hRA=;
        b=w6gaD+YGMZMRxhjif82EqhuEhWnx0T7VIuUxrpBkhYSiHbfI3+3pPltnSD1LBKxy2O
         UN3BQ6mn2uwkwqDlMwW+NP6WKePvToP/P1ilKs1CD52shjjEv6rYtqMdKURvIT8HGqog
         YTyqZXIgGb5ZbcwfaoGXK/XwHYqktICKl5GA+rqPvernVHJB/ZbJhmBNni8A/kLQeBXC
         /5yv8ZusAp/7ytdnsZnnTPA7kXS7YWVE+J6FFjsCOynoSVzpYIuf8lcf1QRZ4qUIaZ4c
         FNd3Wrv+UnFDwL4A3uK5Qe7uS+iqlYfhgmZVFGhcOhxzMEIiFAE/vsXWCyTn5BZOIW2d
         rdUQ==
X-Gm-Message-State: ANoB5pkSm/NgsU4VQ/1/3f94TUIxumP/tN79+b8eO7LL4tQH1ooSnG4o
        2h5zNniHJRLjbTDyKCL2pcNC0Vcs0pH27XXJ6Ik=
X-Google-Smtp-Source: AA0mqf5yzpCOTcTsQ+Zz/KbM4XpaaeVqQFAAFBxNmQgW6QjT/InOFGUlU9DGHKjz7ViGpjrJ6eah+YGSLGIMDipcNbU=
X-Received: by 2002:a05:600c:4f12:b0:3cf:e7bd:303a with SMTP id
 l18-20020a05600c4f1200b003cfe7bd303amr32310567wmq.151.1669803435636; Wed, 30
 Nov 2022 02:17:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1366:0:0:0:0 with HTTP; Wed, 30 Nov 2022 02:17:15
 -0800 (PST)
From:   David Alex <davidalexman56@gmail.com>
Date:   Wed, 30 Nov 2022 02:17:15 -0800
Message-ID: <CABYJXBYMGHEpyZcORdjCy-QRiN+WMf9CPLk8ctoV+zB-bLx98A@mail.gmail.com>
Subject: Re: I give you this money due to my health
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,
        XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:333 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidalexman56[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidalexman56[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 XFER_LOTSA_MONEY Transfer a lot of money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello my name is David Alex I am sick ischemic heart disease I read
about you on a website. I have a few days to live I want to send you
my money I know you will need it $5,000,000 I do not have a wife or
children I lost my wife 4 years ago..I want you to take this money and
use it well and also help orphan children.. If you accept my offer
please reply me now.
May the lord bless you as you do this
