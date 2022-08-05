Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822F058AA54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiHELtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 07:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiHELtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:49:53 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B20D7754C
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Aug 2022 04:49:52 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-10cf9f5b500so2685774fac.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Aug 2022 04:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=cayK0H6IQy1d0QUC88HsF24/yaLJdFvFfYMkqrp9K4s=;
        b=lAQUUUiSJaho23wuyEUNeFJ4WDf9k2nRWVjq/sSps0bBKcZyZYPhbfPfcr00JQdiIe
         i5m9eMDCSZiVVmTJ/bdVXsPSCw7RGcMW7oXwzb7drn2ti8xd6soNHBMN0nRdlYxBz7Lz
         0FiRMjYOra1LuPdapDWGrnOHbzfwHPk1NG53jwX1v52Fi0hrQdOQpoKDDik+BpatF4IG
         L+tTDrFu2YU57tFJKwMBQX91zRGlRpuPeKGQ0SrvdnAY+8hElA3tDOl2nEWHsRekcdBy
         lwKyESca0wg70JdapzLykoiptWN3KtfNq4IfIrqWTTPRZmaMJhRnJTh45egukoTlmBzV
         dFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cayK0H6IQy1d0QUC88HsF24/yaLJdFvFfYMkqrp9K4s=;
        b=QtexrZy8BXDIV/4Dv0NDrb0S87MSxG0bpa31dsEUE5c8Ntka0c+QV71kYzxXAV9hg6
         EKs5tbA/F1pXhH3GmJK9W/27Q+kVrhKoLnISvhJKTetFxKq8i5fmbeW9mN+uv3UDw49x
         MEZ9mmYHP2vBguXItFhbGvz7OzkLo9gLm6A3fQME3R8T6OgVQXbUWm9UAl8B0pT57mwN
         mtaIRidMT4e4AjJufBNwzNqHQlWO1XnCCQUBsLsQs24HDA4vRUJ1m2ocFkGJLVi0Nmf3
         OByQ1AoLUgBjVQtZO3QFTb+dlp6HrOMnOf0BorKaAj3DK0GOIpIjeu2MqIi571CE0SGc
         ccJQ==
X-Gm-Message-State: ACgBeo3pVUxM3xl7Eo0b+LWnv02kVOBRcqzGcAejpIjvh/w4TnaDatuO
        IQd924wlLVZNubAa998j44viGzmibAqNu0pqO2c=
X-Google-Smtp-Source: AA6agR739wHgM2jfExZXyZKzvPEqDDyCDjg6o+jI7OVA463533TF2C50r4eZEZ6EnC1vybywlbAl3H5IlZp7oAfShQI=
X-Received: by 2002:a05:6870:f706:b0:113:665a:b15b with SMTP id
 ej6-20020a056870f70600b00113665ab15bmr283187oab.293.1659700191217; Fri, 05
 Aug 2022 04:49:51 -0700 (PDT)
MIME-Version: 1.0
Sender: mattwesst445@gmail.com
Received: by 2002:a05:6358:5412:b0:b2:4afe:463b with HTTP; Fri, 5 Aug 2022
 04:49:50 -0700 (PDT)
From:   Ibrahim idewu <ibrahimidewu4@gmail.com>
Date:   Fri, 5 Aug 2022 12:49:50 +0100
X-Google-Sender-Auth: cPNuA7jtgggFslc5Pp-bCPXkeSY
Message-ID: <CAEg6tVf4uLkZhsW2NjVUO90A6YR2CnJK1vUbPtcOntczLiKu7w@mail.gmail.com>
Subject: I Need Your Respond
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=ADVANCE_FEE_2_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FORM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5348]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mattwesst445[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimidewu4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.7 ADVANCE_FEE_2_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have a business proposal to the tune of $19.3m USD for you to handle
with me. I have opportunity to transfer this abandon fund to your bank
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information if you are interested
in this transaction for more details(ibrahimidewu4@gmail.com)

1. Your Full Name.....................
2. Your Address......................
3. Your Country of Origin.............
4. Your Age..........................
5. Your ID card copy and telephone number for easy communication...........=
....

Best regards,
Mr.Ibrahim Idewu.
