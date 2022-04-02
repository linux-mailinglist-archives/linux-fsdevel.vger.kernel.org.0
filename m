Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45F4F05BA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 21:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbiDBTS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiDBTS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 15:18:27 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 12:16:33 PDT
Received: from pc232-3.mailgun.net (pc232-3.mailgun.net [143.55.232.3])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id E83BC12E74D
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Apr 2022 12:16:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=kemenpora.go.id; q=dns/txt;
 s=mailo; t=1648926993; h=Message-Id: Reply-To: Date: From: From: To:
 To: Subject: Subject: Content-Description: Content-Transfer-Encoding:
 MIME-Version: Content-Type: Sender: Sender;
 bh=Nt4Dj4Z9m99aZYP7veatwYClRlVhyjI59Ey2CH/1HYI=; b=JygbW+797fUllhH8UfUoWD6/Qu+SYg5EFQGxIfc0yXMfU2+NToVbv+sZvA5tr5KiK7R/0lYe
 6oQcCT21p21EPhQNwff8qZOYGIuKij+UzUd/YGgq7Z+aQaMgtWYwxgthwiCrqLLVRZHpD4aV
 j16qlMb3MjV8umAq0bIBLVhx9T4=
X-Mailgun-Sending-Ip: 143.55.232.3
X-Mailgun-Sid: WyJkZjgyNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJjZTc0ODAiXQ==
Received: from mta.kemenpora.go.id (mail.kemenpora.go.id [202.52.49.154]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 62489fe00418b8d3d702189a (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sat, 02 Apr 2022 19:11:28 GMT
Sender: sesdep2@kemenpora.go.id
Received: from localhost (localhost [127.0.0.1])
        by mta.kemenpora.go.id (Postfix) with ESMTP id B5D8B813B7;
        Sun,  3 Apr 2022 02:11:24 +0700 (WIB)
Received: from mta.kemenpora.go.id ([127.0.0.1])
        by localhost (mta.kemenpora.go.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4TwdSBmzJhyM; Sun,  3 Apr 2022 02:11:24 +0700 (WIB)
Received: from localhost (localhost [127.0.0.1])
        by mta.kemenpora.go.id (Postfix) with ESMTP id C6AD480437;
        Sun,  3 Apr 2022 00:08:50 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 mta.kemenpora.go.id C6AD480437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kemenpora.go.id;
        s=ADBEFE62-19FD-11EC-AADF-9C047DAC492B; t=1648919330;
        bh=Nt4Dj4Z9m99aZYP7veatwYClRlVhyjI59Ey2CH/1HYI=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=iWXaA58g9jipAL1Mav/V7+hXWuG6sMg46ebpXBiA34EYtDBCF9Ha5T9GO2QQvz03e
         ZWoTpyE//2fdyh2pVewOcCyLICNl84GzJFBp3fUnYFH++Crexj2rTUkap8k7mGVvDf
         MxHASktf1qGAjN+m6liuGZ+o6wyZQone//OOWi7I9hH5s+uxypGQQ7exBB39WMwruW
         8q6nfSVl4z/AwmeN2wu1byYfzvBbppoPhjThm3+hQfkwBwA9844WpWp9Et9vnpbs5F
         Zi7rwwNn98JFzPFF18F0FC4kVW5y4D/wX5O7O3z/XaTnG8hC1BJmLJovwefPd3lL0y
         /qMdJ7cz47lIA==
X-Virus-Scanned: amavisd-new at mta.kemenpora.go.id
Received: from mta.kemenpora.go.id ([127.0.0.1])
        by localhost (mta.kemenpora.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uL75DzPi_uqp; Sun,  3 Apr 2022 00:08:50 +0700 (WIB)
Received: from info.gfllum3nfugurne0j1ov0rswqa.zx.internal.cloudapp.net (unknown [51.140.35.89])
        by mta.kemenpora.go.id (Postfix) with ESMTPSA id EB80F82774;
        Sat,  2 Apr 2022 22:12:11 +0700 (WIB)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Information
To:     Recipients <sesdep2@kemenpora.go.id>
From:   "Mr. Alexei Navalny" <sesdep2@kemenpora.go.id>
Date:   Sat, 02 Apr 2022 15:11:54 +0000
Reply-To: wetttttwwttrttr@yandex.com
Message-Id: <20220402151211.EB80F82774@mta.kemenpora.go.id>
X-Spam-Status: Yes, score=6.8 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO,HK_NAME_MR_MRS,HK_RANDOM_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [143.55.232.3 listed in list.dnswl.org]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [143.55.232.3 listed in wl.mailspike.net]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 HK_NAME_MR_MRS No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.1 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My name is Alexei Navalny from Russia whom Vladimir Putin President of Russ=
ia the detects is jailing me because I'm against his evil war plans against=
 Ukraine, killing of Russia people and the world in general. =


You can read more with below links: =

https://www.bbc.com/news/world-europe-16057045 =

https://www.theguardian.com/world/2022/feb/15/alexei-navalny-faces-10-more-=
years-prison-focus-ukraine-crisis-russia =


I will be happy to serve the 15 years in jail imposed by Putin but I need t=
o assist Ukraine's displaced people around the world with the money I secre=
tly deposited in one of the Turkish private banks, now such money will be r=
eturned to Russian because d western world has blocked Russia . =


If you agreed to assist me 25% of the total sum will be for your assistance=
 and the 75% will be used to assist the Ukraine displaced by Putin war. If =
you agreed and are also willing to keep this transaction confidential, I wi=
ll send you all the details to approach the bank. =


I contacted you because I need somebody out of Russia to do this job. =

Please reply me here: reeninvestor111@kakao.com

Regards, =

Alexei Navalny
