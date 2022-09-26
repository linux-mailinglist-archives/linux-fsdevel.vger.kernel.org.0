Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D75EAF46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIZSKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIZSKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:10:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9A69E2C1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 10:56:25 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c9so9397903ybf.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=C237qwozOvl8aPF+8xhmIlNpmWxUmRobeuzg2CJNr44=;
        b=ALWQv4LRMAvj0TUX9yAXxSCWFf0XfPGqKN9TaRD6JPDT2G307kUbVDtPPOmhQa1dsx
         DNwAXJ8fx8OPZU7w7Qhx2Z7AT7t3OY0K+S3MvMDCbrhn9eZm2z2hQfVfp3aB4w1NOFtG
         IBJQiB0xHTvXhFu+BB6DLRL5unb43b3vj1QglzmorNZlctUE4irassoRTSGZW/nbNb55
         nXiCPrgdbvB0yk9cO2rNHJn2KPhbEDvMztcoC718FvdTtDKP/ekKSgNhPZo7WFpirb7I
         C5wbbVHr0p1YBXBq/e55Udq0HBnKrc47FtIz1iyc6imej++SjMqr6guIy3EjppdLGd3m
         J+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C237qwozOvl8aPF+8xhmIlNpmWxUmRobeuzg2CJNr44=;
        b=jCGrG2ffbl54YJEb62nOFWY3/gw6axGKMu+zwx/l6rffr1MdSwXPTdiQNs6EZZFrPE
         3ODKsYsSunxzxhwRfZuk5O9RpBy9J84drHHOgni2cg0nUzM5f4T+zzszQShf+or/9CCP
         tSSjViwmU7papBxd+8REIOOTuRofXrQo5jkZiC3BRL5QWEUtxaJ9pSVFySSSJ/VL03GC
         ax0sHb68kTGCzTA17t6afTFI6oLBvHupbLm78/LHnf6FrJWVKIFcKTVPncnaVj53Xv/G
         7tOKFrwAfKrBiu06wVaUzAR5bf7sqQJay76krOslr93Ndj4giUojdtft5WuUxy7yvo60
         exjQ==
X-Gm-Message-State: ACrzQf37oKEevdKdly98d5tUEwaS/VkPJrMYjvQKYUqiF4F4KNxSTEWJ
        bI18o8PVvemLbge0f0PthW1xd4xLh5cGBzB0ML0=
X-Google-Smtp-Source: AMsMyM6ktQE3+d1Vwj4C6MTrT+pyTx/G3m4+0s39VUEEvZU9NMXvDZ7lm4m0RBAaJyS6z4xvnmVrpqzRoIF9unjWYJU=
X-Received: by 2002:a25:24d5:0:b0:6b4:cd06:dc38 with SMTP id
 k204-20020a2524d5000000b006b4cd06dc38mr21437413ybk.344.1664214983776; Mon, 26
 Sep 2022 10:56:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7150:0:0:0:0 with HTTP; Mon, 26 Sep 2022 10:56:23
 -0700 (PDT)
Reply-To: pointerscott009@gmail.com
From:   Abdulkareem Ademola <adeomoade123g@gmail.com>
Date:   Mon, 26 Sep 2022 18:56:23 +0100
Message-ID: <CALzsaxvWOpy-yYruzha0QT3tdg1-n+yBN5P_Qbk5MOh7h8rgew@mail.gmail.com>
Subject: =?UTF-8?Q?Bussines_offer_Gesch=C3=A4ftsangebot=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b34 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6758]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [pointerscott009[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adeomoade123g[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20

Hello, Do you have a projects that need urgent loan??
Granting out loans today in 10,000 / 500 Million to Interested
Investors, Companies & Private Individuals.
Revert back if you interested.


Hallo, haben Sie Projekte, die dringend einen Kredit ben=C3=B6tigen?
Vergeben Sie heute Kredite in H=C3=B6he von 10.000 / 500 Millionen an
interessierte Investoren, Unternehmen und Privatpersonen.
Kommen Sie zur=C3=BCck, wenn Sie interessiert sind.
