Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77F4B9F65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiBQLwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 06:52:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiBQLwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:52:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E23B033
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 03:51:53 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a23so6648814eju.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 03:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DNlgyVaU8TjCWNLA871jCHNl9EtR9BXdeye9SGukbxg=;
        b=JEyf9l+iKVHC82F5+bq9xUyMvPgl06zquJ7vcpPbGjI63yb/M6w87gDpx+6If61v/z
         EeROjDHanaU/8hOcfrDH+KszfTT4wxJZjo8xFEmBPdafAompuk6DmlRJ1X5/JFNIttZB
         11t1fDCeI9aGUu5UvJpfTmZxnDcXa05P7Q32pAZn4lZPBMbo0kXAB7Uu7hhdQfaw4UC3
         c4Jxc3hQsbBelHarbf566umXKq9vSB2uWZtS1UxMQ6+UtLXPBn0zAHAefJyBe1+C4TGu
         7yOTdZkR+S0ysHMacRU1C3bDL/FPKFCpdBxKQ6khSx2h3nF6uEc9e5yGoZBflgfQKoow
         OYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=DNlgyVaU8TjCWNLA871jCHNl9EtR9BXdeye9SGukbxg=;
        b=XEjdnE+rRxcEd9Tkyn23j/Jk9WpOKHG7VGqsX2KE471n7b0nzi4Tgs/8xdMjbA+8x+
         IoC0okMNf9KmBfSYQ6KEEG1TKW7YjZZ+0hner0U7BI7BfxQxf01ZOCRKKhDIU6Ce4NNH
         CiNj0m1RNsiqEo3+Q+eCyUASls6YYRxS0iIwtAyRd6HPjStsbQzE4i/P70Zz44BiYqOs
         cWNhgRqzjPmfEZlHXmzScuUmseW9WDwJ26WrfcPYWDepcwJZCJoSAdslLyPipE+a9wA5
         BblYxdyA/C/jrXd53E4pzYOlgznk8j494Nk/NIiqyWCSrnDJ9Y21LIYtDgPQOQlGxZFg
         9m/w==
X-Gm-Message-State: AOAM533txoxGv5aD/atCM0MtOy31oRG9F0UjEu+kkuHmEaz1G1tdzChO
        q+yKYp6zKCfNjuMo0cb3mOfZKHXhWOjFTZmh7as=
X-Google-Smtp-Source: ABdhPJxTyZOuphkKVffBUDmyeRJWF63D9jkCoXnw2QGsVnbinV5lD4Dcw9fWnUxDsM98yxePfL1e0r/tJY2V4357wlY=
X-Received: by 2002:a17:906:7fc9:b0:6cf:d288:c9ef with SMTP id
 r9-20020a1709067fc900b006cfd288c9efmr2102237ejs.751.1645098711380; Thu, 17
 Feb 2022 03:51:51 -0800 (PST)
MIME-Version: 1.0
Sender: sticozzy@gmail.com
Received: by 2002:a55:948c:0:b0:149:1a94:a947 with HTTP; Thu, 17 Feb 2022
 03:51:50 -0800 (PST)
From:   Ibrahim idewu <ibrahimidewu4@gmail.com>
Date:   Thu, 17 Feb 2022 12:51:50 +0100
X-Google-Sender-Auth: Z422B6j81Q62Dnl2Uek-w6kieKE
Message-ID: <CAEx9+XofV3hfcbbfpw+BmZQUaT3UnKpMsbGdw5jAtVpK0OixjA@mail.gmail.com>
Subject: GREETINGS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_2_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:631 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ibrahimidewu4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.4 ADVANCE_FEE_2_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I have a business proposal in the tune of $19.3m USD for you to handle
with me. I have opportunity to transfer this abandon fund to your bank
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information's if you are interested
in this tranasction for more details(ibrahimidewu4@gmail.com)

1. Your Full Name.....................
2. Your Address......................
3. Your Country of Origin.............
4. Your Age..........................
5. Your ID card copy and telephone number for easy communication...........=
....

Best regards,
Mr.Ibrahim Idewu.
