Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49B933EFD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 12:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhCQLxd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 07:53:33 -0400
Received: from smtp.econet.co.zw ([77.246.51.158]:14129 "EHLO
        ironportDMZ.econet.co.zw" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231506AbhCQLxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:53:08 -0400
IronPort-SDR: lcR7rzMPMna261jvNN7DlegkSE7vKDbnHtkUBVdYHRq6AQqZbPcESKHoXAPWEwjaxdA2kcWm99
 BqcaQUAKdEWyjb8MVy01TsHfS3RA/Z7nAE8zYFL+FxHRT6buxKRSZeGMwXgyQXuQEv8I2xZjpm
 QGJVzk/qFAQOdlSdr5GsGzBMSglh4HyQYd08lleuns89v5Exo4WMxh2GcmUQ3HnWB8aiu+pqYH
 MlW55eSu0Wbt9O0Q9R/BJggblWwhusc7Q3Px7wMgbUGJeMIKmdWWpcdDDFOUSJuei7xTtDpdxd
 tQk=
X-IronPort-AV: E=Sophos;i="5.81,256,1610402400"; 
   d="scan'208";a="6585147"
X-IPAS-Result: =?us-ascii?q?A2D4/wDZ51Fg/yNlqMADgX2DL4Elk1mDcZR7hXeCOYUdD?=
 =?us-ascii?q?AEBAQEFgg4VBwMGBAGGJAeCEEgBAQEcAQUCAgIBAgMBAQwBhFdQEk2DG7B1m?=
 =?us-ascii?q?10mgmKFXA0FARECAV+DJ4NfDzdgEyMbFikTRSsVTxEJMAFCA5AhJS+Ke6kfi?=
 =?us-ascii?q?2+KAYI0imDISYgmjWWHbAECnUEBBQWBQg?=
IronPort-PHdr: A9a23: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
IronPort-HdrOrdr: A9a23:ApZ9va8Mxuoie/CQMBRuk+BqI+orLtY04lQ7vn1ZYxpTb8Ceio
 SSjO0WvCWE6go5dXk8lbm7WJWobmjb8fdOjrU5GZeHcE3YtHCzLIdkhLGP/xTFFzfl/uBQkY
 dMGpIObeHYNlRxgcbk7ATQKb9JqrS62ZulnOLPi0pqJDsKV4ha4xpkEQHeK0VqRWB9dP4EPa
 CB7clKrSfIQwV1Uu2HABA+MdTrlpngj5T9eyccCxom8gWVrD+h5bLgCTeZ2woTSD9D6qcZ/W
 /JuQr/4amorvehoyW260bjq7JMltPnyshKGcyLjekYIjjhkRyQf4h6V6acsD1dmpDJ1GoX
Received: from unknown (HELO wvale-mb-svr-06.econetzw.local) ([192.168.101.174])
  by ironportLAN.econet.co.zw with ESMTP; 16 Mar 2021 13:06:59 +0200
Received: from WVALE-CAS-SVR-9.econetzw.local (192.168.101.184) by
 wvale-mb-svr-06.econetzw.local (192.168.101.174) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 16 Mar 2021 13:01:00 +0200
Received: from User (165.231.148.189) by WVALE-CAS-SVR-9.econetzw.local
 (10.10.11.230) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 13:05:15 +0200
Reply-To: <r19772744@daum.net>
From:   "Reem E. A" <ecosureoperations@econet.co.zw>
Subject: OKKEH
Date:   Tue, 16 Mar 2021 12:04:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <5749848fa2a54a738cb73039bed68c32@WVALE-CAS-SVR-9.econetzw.local>
To:     Undisclosed recipients:;
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Friend

My name is Ms. Reem Ebrahim Al-Hashimi, I am the "Minister of state
for International Cooperation" in UAE. I write to you on behalf of
my other "two (2) colleagues" who has Authorized me to solicit for
your "partnership in claiming of {us$47=Million}" from a Financial
Home on their behalf and for our "Mutual Benefits".

The said Fund {us$47=Million} is our share from the (over-invoiced) Oil/Gas
deal with Turkish Government within 2013/2014. Because of the nature of the
deal we don't want our government to know about the fund that is why we
decided to contact you. If this proposal interests you, let me know, by
sending me an email and I will send to you detailed information on how this
business would be successfully transacted. Be informed that nobody knows about
the secret of this fund except us, and we know how to carry out the entire
transaction. So I am compelled to ask, that you will stand on our behalf and
receive this fund into any account that is solely controlled by you.

We will compensate you with 15% of the total amount involved as
gratification for being our partner in this transaction. Reply to:
 reem.alhashimi@yandex.com

Regards,
Ms. Reem.
This mail was sent through Econet Wireless, a Global telecoms leader.

DISCLAIMER

The information in this message is confidential and is legally privileged. It is intended solely for the addressee. Access to this message by anyone else is unauthorized. If received in error please accept our apologies and notify the sender immediately. You must also delete the original message from your machine. If you are not the intended recipient, any use, disclosure, copying, distribution or action taken in reliance of it, is prohibited and may be unlawful. The information, attachments, opinions or advice contained in this email are not the views or opinions of Econet Wireless, its subsidiaries or affiliates. Econet Wireless therefore accepts no liability for claims, losses, or damages arising from the inaccuracy, incorrectness, or lack of integrity of such information.
[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/AgileBanner.png]
WORK ISN'T A PLACE
IT'S WHAT WE DO
________________________________

EcoSure Operations



[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/telephone.png]




[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/email.png]

ecosureoperations@econet.co.zw<mailto:ecosureoperations@econet.co.zw>


[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/location.png]




[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/website.png]

www.econet.co.zw<https://www.econet.co.zw>


[https://mail.econet.co.zw/OWA/auth/current/themes/resources/Agile/inspired.jpg]
