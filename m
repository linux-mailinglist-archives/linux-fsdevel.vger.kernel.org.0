Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74133210B55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 14:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgGAMwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 08:52:30 -0400
Received: from sonic301-21.consmr.mail.ir2.yahoo.com ([77.238.176.98]:43197
        "EHLO sonic301-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730520AbgGAMwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593607940; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ivn5INaav5fDBV26PJ4m+Q/SwckhjnOM4LycuuKoNJPJx+vU8yWf49n2M+FV73nnZf7VycbJu0QP92H1yJ4ciPQ3JlbW0d18NwljxuS0R/IgnmYnpKNvrW7bgDcK8a3xFpa3ALLToquMGgGOmsasURkfUPxzP+rqOB7BOByU1UZfzjaI9DmC1Q/lWapDKpi7L7xgotDKNKHD9hkrg/0SeqlIP5Z/kCTSHRHPhBOY9ey5JvXrlUGDs7uN/Y9pH1V5kp4EgyAGQqJHLWIUviCNvx3xvB7GkcwT/tdeCSoGllTJSCHjKaMUIPLn7mU/U+D0ZYrus61jRRmdZhPl39mnfg==
X-YMail-OSG: VhITZaQVM1mCJNF0t_95AJqvoLTZPSVGjv5RZnZA9yndq4zrX8vb9.16yGk.EH8
 QnY90bEZtlXz.79NhJC.aJrMaJr0eVGFRFSKrvSwlYXJL0vhJ2T8HXqfQr2UE2xCjmg1.2ySUmcn
 P3JX1dqNT6iQ4dxGHVKlJ4XAdZ93KDKObqXCKVfGgMRgbjqu6GwqCOYm..SzkT2l79A6mvbLb0FZ
 XF1Ph35iw6eqRRBR7tP39oj_47kAPRpdQISSGQlQVCLDGNamODuXmgy0QiVAnUhw2Xz5e_nxJZKR
 jgxrSgL4GFtKVTJgoy9A8gDCt6w2MtqVCBQEQK_X9hSkvZDVtzb8QSRJDmLxB__1z3Fy1QnIoWc2
 8HJbxCs33bfLXYq5.MLhnRFgi2tS.lZZ1g8FgB9CJ6SnoCYf1MStGaSAcmXlF4AImlMfG3IRIqh_
 qC2tYfV0B9uHJWf9HVhl1EzzJ6yPUPFlThv2uSIqn2dDwTQQWecYLP7FvqMXaDNsaoUg4Bd7rISA
 BSzebT24YiXjRkkcNKXRbTJ0LgpbcZ1DuvbVIV9Egk_pT6Um1FK7PHm_H3TWWzUcBOeAgCIWRTQw
 2yVZbfp5km2iXwcibko5.gx8N1A3r4R5P2e5IGpUcF.bUaVVPjzmizJqwAlOEZBuJ4W7NcmMHpHA
 vBLUgBCTuDRshu6WJs0DZISf4TYlX07VkT6hhgrjYU0BZ.cENKFaotyNHOuGWEa_2o8DwAHHjLCv
 vKxrY.wViCV03YvJGhAlJfrx.xqivOKFKCM8LNGRMz5.7boA7dLRX2TZTdBz19ggiWh72PuqzQyE
 Zti0ps7WtNOf7j8i1.zZxN4xgVcYcYkizEzboAc2IUbUnEEYZrM6LPCYoi_YfhWbUUDh9rRrNWxd
 AzonYl_o0jA1SstMIFYngEC4TQnXTAXAUc0TGQq8z9L_NdPe6v.TAO9W6a4tuUq_VB4Apfhvpd5s
 getU07tOhsW2KdWpqG09DrOYviXjSICtsLWC3mfT8HvC8qw6VvIH1amwRNTXFI_bZon7trmwjwMV
 ZoR4iMNR7N5Wqz8Vr76ljEJ72Fxf_9nz7xhVoVgXr4STK7FNl1hlcti_FmrdLIvOrqXEmjZlPwvS
 OIXsLsCH84FCkRnKKerkTLC72kYvfBR3dvtWNFjjuVjQKQxdzwisQE7vvKhRYSy8lowYmbvmy05V
 I3hkhgrfNnyhwvHJsEjoQsRzVpQvg4ahVSzrzBHFH5PRAxAgOCj2jjJrwwSqA4taPTDwicLjcoTM
 uvoq1vR6aSMc8SDcrVrfujXYhItMPLlLoU70Ekgfd0IGmeVWPngPTsyJfSqK3PHXM3Iz73_Qb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Wed, 1 Jul 2020 12:52:20 +0000
Date:   Wed, 1 Jul 2020 12:52:14 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <1131776321.1594178.1593607934859@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1131776321.1594178.1593607934859.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
