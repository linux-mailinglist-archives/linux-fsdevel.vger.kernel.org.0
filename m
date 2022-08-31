Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C106A5A890F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 00:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiHaWjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiHaWjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:39:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8AC26C3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 15:29:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so670109pji.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=bHtvVuvZrK8uzIZMh2KLQe7LmhlFcgk20dbkjCziIhU=;
        b=UujTcPiytEqz/lRM9JcJw8NJZzj7JEcJ1gGB1a/qYK8hxpCG6Pu0bXfu620959jFrI
         kY72530+IhLv5yfIDb+XQF6Ih2KxEU20OgsJmC9qdLIMty/NchxGO9VGgMTiJiXjwG7e
         B4IK6cMrovMSAP2qURHjAxGM2Iskee3yDo81IEpZ8trguATrvn7JMV4bP07u0F8if8cE
         7etDwYT2hrfxp10YhjhC/I8L0KGaDgNqhTuVRdFBHs8vIIhJAnQL29ub6ur6gQKBd+Fu
         ePwJUiEbb+OY2w3YB2VwXenrxfLUKVG0a2mqciYmesIlCPfAY60ljjQ8sZolIIIwH4Tv
         pbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=bHtvVuvZrK8uzIZMh2KLQe7LmhlFcgk20dbkjCziIhU=;
        b=w0C/UgTs92uWUuAue9ngb058TffxkHU1qaUm7RqLHbZtmNErOQaf2+7HVzG5nR1Wl8
         7acMS1iwmDy1cj8HMwK2CTr6Aqo/+AtvFg6zGDd3RB2sQFNnEZwLFM37Zhov2DxNLnkI
         Qsm3dD5I6Rpnt+Dqvj7wSbRSHQf48DDcNUl4K86UTvY0CWsTunjuf1gRocABLvE+YpiC
         csiIs3+cfYaRJyqEhAoyxqg5k7//kOm2SyiP/2De87RlQkUULoJZ0xvZCvuAfBGZxI3x
         Ndp0n/E4bedsU73M+R3cqdMZ8TJgBjSJoRGtUMQyDchktzoKRDxddmptLn9OpzAe/mks
         ucQw==
X-Gm-Message-State: ACgBeo1LkV1Ra/5NzWTPR3aDIjiTc141m9A/Nsvcst/c7kBNz5oz6qG0
        qDRuMi+t+fqNUL1Ub/LgW6bJ+RtgjTgrgV0Navw=
X-Google-Smtp-Source: AA6agR7P2B2Sedj11nzku8+Ije2fDnytUPjYIsSG6EPgljIlhNK78SlMpKjyy4YFH2CZF5oUl7sksSQ0vN1APyEI2t8=
X-Received: by 2002:a17:902:70c8:b0:175:368b:1255 with SMTP id
 l8-20020a17090270c800b00175368b1255mr7492555plt.83.1661984990002; Wed, 31 Aug
 2022 15:29:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:252b:b0:43:8b67:16a0 with HTTP; Wed, 31 Aug 2022
 15:29:49 -0700 (PDT)
Reply-To: Illuminatilord1945@gmail.com
From:   Gomez Sanana <gomezsanana21@gmail.com>
Date:   Wed, 31 Aug 2022 23:29:49 +0100
Message-ID: <CAHa5-kSYxaqYTZhgvP8s6mqaUNwQETrC97++BTpbq8_FzKvq8Q@mail.gmail.com>
Subject: WELCOME TO THE ILLUMINATI..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5713]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [illuminatilord1945[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gomezsanana21[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gomezsanana21[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

-- 
WELCOME TO THE WORLD OF THE ILLUMINATI...

Congratulations To You...
You have been selected among those given the Opportunity of coming
rich and famous by joining the Illuminati Society this week, Kindly
get the below informations to the below Illuminati email.

Full Names:
Country:
Age:
Occupation:
Monthly Income:
Marital Status:
Whatsapp Number

EMAIL: Illuminatilord1945@gmail.com
