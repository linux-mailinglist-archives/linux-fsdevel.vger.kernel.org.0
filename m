Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE150984A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385238AbiDUGyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 02:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385452AbiDUGwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:52:47 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A341B78B
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 23:46:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id t67so7046209ybi.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 23:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Yx7zUigSWc4B0VvKdonWuBTMrnYlWW26gWGUF4OHkss=;
        b=Jd1wHwh9vIQmgOotzRW9BWlLyie2kC7oo6SbLaQDE1CF6y0ciINrDw6FmD9949WlcA
         0lFuvezrAZpJhmVhlEfIN+pynPCdD0tGfrDigQVK7IHO8pD4/kTbedPesn3KDf8Z9T+3
         XprwGElWvg8nT9UGn3OdqjB7kGf9lS36CcAxlRHdOei05wEN+E04M9ifJdN6/RpC2pRl
         93hpwA/N4MJZ21hjigkLTk/G92UDqNUY/0PU/hpvf3BbvvMeGS6KAB7vY0rDcAWw7zrn
         /R+ZzB4cBgrY2Vz4igHo0NukJNCMlHZoC8Rm0h4SgFFPhi5/4H8PzbWAWndCYYcIEgs6
         j0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Yx7zUigSWc4B0VvKdonWuBTMrnYlWW26gWGUF4OHkss=;
        b=X+fjygSIrKz5bqy2KR1zMyTrPk4Sc7VaWV/8GkM77n75f/QnUDF73N9XNB/WdoNA6X
         L+/dsG9A3dqgT6UcZf6oz5RwPVTTHUz1/1zVxgXqKrDsqMR/Nq4ziCMcxWNltiLKkc1f
         WEn3eJ7YVD0DbG+R33Q1OYi3puy24+bDGN69CsJi24cBzl3YpvxSGpmavI15lFgKHm0N
         NLQRIeyI8scztCMP6FOacSRzvGZngH/GzfTO1Be4ibQucrJGLnwtpXT1Aecxpj8xpJM8
         E40U7HWG/3Y3pTuY3kcaHFLnh8a+GwjRewJTj82aVs/jc2itzLp6eMbLsDU7RzKKmBhE
         uEEQ==
X-Gm-Message-State: AOAM532+B/AVTYG8tOqWS7cZcaoZKF0zKVWDS4fqzmqlsSvuxFtdUiQT
        rlZB228ZyD5zqanJgY/UwNBDGWGxnewXIjFJpyI=
X-Google-Smtp-Source: ABdhPJxacVu3UQ+d6KqSoJfOWAdU9BAfc0a5sApgej+wXcMi3lsCHxz7I2xNPkocVuWRPKwsuLhmm+0gW6hep0lC/Jo=
X-Received: by 2002:a5b:c51:0:b0:641:15b5:40fc with SMTP id
 d17-20020a5b0c51000000b0064115b540fcmr22699100ybr.19.1650523617518; Wed, 20
 Apr 2022 23:46:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:4d8d:b0:20d:2b4e:508d with HTTP; Wed, 20 Apr 2022
 23:46:57 -0700 (PDT)
Reply-To: michelleongcheung41@gmail.com
From:   "Mrs. Michelle Ong-Cheung" <veljoes97@gmail.com>
Date:   Wed, 20 Apr 2022 23:46:57 -0700
Message-ID: <CAC_APpu3y=w2Xa4zPeto-HHDjEZRWdcCKcvmJZvf0WkcaqTCPA@mail.gmail.com>
Subject: business proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5688]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [veljoes97[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michelleongcheung41[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [veljoes97[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=20
Good day,

 I am Mrs. Michelle Ong-Cheung, Director of Credit and Marketing at
CITIBANK OF Hong Kong. I have a business proposal for you. For more
information, please email me (michelleongcheung41@gmail.com)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::=
:::::::::::::::::::::::::::::::::::::::::::::::::::::::
Guten Tag,

  Ich bin Frau Michelle Ong-Cheung, Direktorin f=C3=BCr Kredit und
Marketing bei der CITIBANK OF Hong Kong. Ich habe einen
Gesch=C3=A4ftsvorschlag f=C3=BCr Sie. F=C3=BCr weitere Informationen senden=
 Sie mir
bitte eine E-Mail (michelleongcheung41@gmail.com)
