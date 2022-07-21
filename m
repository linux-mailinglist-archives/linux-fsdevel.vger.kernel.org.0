Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2984857CEC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 17:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiGUPUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGUPUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:20:19 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75731A394
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 08:20:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id l11so3258313ybu.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ecd1Q2yPx0A7W7K7jCuZP1F8wCmAYdVKX1aCc8pJ7gM=;
        b=F7ujndKGfaviF0KU3h8f6EBukO+Lt0lE1ptQWtJGIX5Vz/Yb23W9PaQkNkvIAfgoNB
         Mxa+PHsg25Wq63enbDq9kZZDAEtP+tfaQxoAiusKcP3qYmNXD3kihtv2XzqBXBIpzh8P
         z5kQhTzA/4aRGenRT2YcsPPtrpyckTOMgdP5Lr38XcL24ZYatmKlbCBC2Rs9FF/zj68S
         YUOU0goulUfFN4skKCnm7H82V5B+4iib7a97WHt+m2FbqVvl/WAHDYEwFEG1nPtozOgW
         YPm8gP4sM92C2oyQ1jnMkA0HHUZXRFbXpFCyqSzOQChP7fa3zzRIy3lZmbRnGrd4M+Wx
         Zfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ecd1Q2yPx0A7W7K7jCuZP1F8wCmAYdVKX1aCc8pJ7gM=;
        b=sZ73/09ml4Z8/FT1dSb/ygy411BTGpzcqFUKcJNU80Yk2nwRBGoS2/0ry9b+ArJqPy
         sXxSTkHUIvr9GfbvLiEw7BR+Kaxq3qGNr+FQ0IxsPg4A5tIhkOToRcRKZKG7/Nj320Sg
         r2507wBJ/GoX77or12WosF2zEwqsiaeIODje7uckGGCMiKExEMzF/CUFkJaHuoiaxg8I
         i4Y0G6V9axFiEFrRCD3S10TjmTUTm8p7/srrGTlnScsNZRWo22+nejcys8pZHwAnh4JF
         rRPSRocqXeb8R2RXYjXsGy/XKILLhzP9ha94s9IFSQa08FJQN3eMUlaxy7xMPXIFJGpy
         QruA==
X-Gm-Message-State: AJIora/beSNTGbmpf1gBprwSb0cXKEySHTV5WAEoGa7EpeoWlgmn+Adw
        9ruhZHGCMIlMdxR2AB4W4mVpT1SmO6+/tK1p0LU=
X-Google-Smtp-Source: AGRyM1scsOwxVDMVhannZEjPdAUSh0lvRukz5IAfDPaDscOGgDabRvzRfzeXyWVhbdhc+bIUr7LxcgmySimy32FPLe8=
X-Received: by 2002:a25:824a:0:b0:670:8d20:7e96 with SMTP id
 d10-20020a25824a000000b006708d207e96mr10543181ybn.157.1658416817812; Thu, 21
 Jul 2022 08:20:17 -0700 (PDT)
MIME-Version: 1.0
Sender: davidscottdavid21@gmail.com
Received: by 2002:a05:7110:3214:b0:18a:76e2:aa9b with HTTP; Thu, 21 Jul 2022
 08:20:17 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Thu, 21 Jul 2022 18:20:17 +0300
X-Google-Sender-Auth: pD_j18LqzYLTZE3wUb3VbOCH31I
Message-ID: <CAC65ENQog43p+MXAcVVcb6GpwcfjPPdKHRfBpTUuFrEmnddbDw@mail.gmail.com>
Subject: UNITED NATIONS COVID-19 COMPENSATION FUNDS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,LOTTO_DEPT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b43 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6464]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidscottdavid21[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidscottdavid21[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 LOTTO_DEPT Claims Department
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT:$3.5 MILLION USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with the UN, IRS, and IMF that your total fund worth $3.5
Million Dollars of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$12,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $12,000 levy after you
have received your Covid-19 Compensation total sum of $3.5 Million. We
shall proceed with the payment of your bailout grant only if you agree
to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email at: (
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Regards,
Mr. Jimmy Moore.
Undersecretary-General United Nations
Office of Internal Oversight-UNIOS.
