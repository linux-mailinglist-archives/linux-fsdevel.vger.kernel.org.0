Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E146C4B82CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 09:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiBPITk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 03:19:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBPITj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:19:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52602701A8
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 00:19:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n8so709191wms.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 00:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xXVRDSvKY3JqlCXZZtT2Wuc07JmWm1VtOicbQcZrRK8=;
        b=i1M9Bs3qZ88pnFOfgjQqdVMnQI/zuwiKN7v5YkTdg7ft3MsgsjrVVQz2F+b8Ufe5G2
         U0Rjx2u969/EuUoSoSHB7LKS0gzogP1q9eo1HqaxFd/Dw/cMx6nqKSKy2KDF+L+O/j9Y
         rsygo8BfK8nNkhVrohhuf4Y48w51E7kycY5FnKTES8cyzLczSsHZp11fTyJREeeda3cH
         b+IIn2ipGT5odF5XHFtepY3NVmvBJBYr4BVgu8qMyvNBQipCGvvTZVRx/+Qbew7ywhtT
         1EsZayqEl0lfZvGgv+UUFR4cFn+wJnbBP/VSL/DuPdNZ4H3Pc9Ptzv62DYLS7DCIx5DE
         syIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xXVRDSvKY3JqlCXZZtT2Wuc07JmWm1VtOicbQcZrRK8=;
        b=OCV4UYfXgqsZxpbfjIYGsu55iUXvP0EyxqizR31G3szmIO0tTCzp7TKeGjzfjloHGm
         wQiRLuc7W8MlXpeyIy2TiAAdYDziL1rNSIqt8/wuHP9G9c8soS/uHHEwKLBtUIjLG68k
         aBFAi7gnBpLm64+ALpCOBQ79nB9xB6u3E4CYd2qp/MTjI2Ar8r9afHHcMhzy9fFXePkD
         Rab5ciV4I7Wd1T5alpgz9dnDESZ/LH++C7aVwKPl+ACST0QtqvSHY3fWhZnkL5BrzVQ2
         CdOW45zjmNbOwB3THsYOqhyhDaFH09zHi+4Ua2t/YAHWLmFmXtZSSWPRv46Dolztaam2
         pqTQ==
X-Gm-Message-State: AOAM530/9fn4Zzey1DzFKrJgGur7yCZXl/PDkWj8tIhTwWjTD6ubW9HP
        69P/N81xcM+73XvYDq3a5aOE1C0jqT5MVia/F2g=
X-Google-Smtp-Source: ABdhPJyA69xfd6ivxpv4QUmyLUMhsBkF/DEG0BEKn9SfDnIig+YDxXNMuUdOCoFhrqiyWp8l18u5Vq90RuAk3VHl6S4=
X-Received: by 2002:a05:600c:220b:b0:37b:ec02:32c4 with SMTP id
 z11-20020a05600c220b00b0037bec0232c4mr456467wml.11.1644999566270; Wed, 16 Feb
 2022 00:19:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:eb0b:0:0:0:0:0 with HTTP; Wed, 16 Feb 2022 00:19:25
 -0800 (PST)
Reply-To: michelleongcheung41@gmail.com
From:   "Mrs. Michelle Ong-Cheung" <stevenjonesinvestment09@gmail.com>
Date:   Wed, 16 Feb 2022 02:19:25 -0600
Message-ID: <CAACQoCF3929UH9broriHOBM7G2qhZLR_CupFy_F0s2CxewHGGA@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michelleongcheung41[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [stevenjonesinvestment09[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [stevenjonesinvestment09[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20
Sch=C3=B6nen Tag,

   Ich bin Frau Michelle Ong-Cheung, Kredit- und Marketingdirektorin
bei der CITIBANK OF Hong Kong. Ich habe einen Gesch=C3=A4ftsvorschlag f=C3=
=BCr
Sie. F=C3=BCr weitere Informationen senden Sie mir bitte eine E-Mail
(michelleongcheung41@gmail.com)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::=
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Good day,

  I'm Mrs. Michelle Ong-Cheung, Director of Credit and Marketing at
CITIBANK OF Hong Kong. I have a business proposal for you. For more
information, please email me (michelleongcheung41@gmail.com)
