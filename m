Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE3C4A2AFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 02:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbiA2Be3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 20:34:29 -0500
Received: from mail-bn8nam11olkn2018.outbound.protection.outlook.com ([40.92.20.18]:35035
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352031AbiA2Be1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:34:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKRS9CtEX8rGEMND/Ht3l5MjXoB3gDQirJflWdKnC5WajYUBOfYm+QgJd4p9p/FO1kBMyFTZG676tDsh+AhjJooVTpDZ1XCxTlKue1P982o8/bB0BxyVkYOEcGwDUm7jDelp7IpAZ0ieQQH/VtCfsG7WSuP4Ria/z3z2vihL26XinMUFwLYjWNQR/PUSxC1Z32XgZgBhvUyIBfhcmoPafX5KKfOnTAxL0g6EpZfZzM+/j8VoqGqEfUlkeZAk1tknHPUPycdejpIgjB0svDc8Jh30+11PwqsAfz5v8L9SctNLM733BO47J7fTbJuBNaRoP4TI3xR15UDO7uSLquBk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5jaAtmQjZ/Kn0Og3XV159mm+f+g2LUhrb9k1hhXQkQ=;
 b=PNByYE416WkRDGb4FuZRmzvaIlwHxq8DrnkDOVQ+psgootz1EwYgmExePNCnZJ88IRrreKyFdGrjTBPlmiEw6lbtG8Rng499dohgAb2Zl75oxJTZfD12cMh1EckqHBXFO7jA0IJ1KPhFhzD+t6Gkok2CJmZVR74doM9EnNT/nPtSs0/6J2dWtJdsyaP9rqOlbdmbbnwLxJR04PuyB6KG9lJXSiFCFdG/mTCk9feTwp0Pxny3M4M3kealpavDyNJ2sObqd0ebAOJlUqFiqmYg7igHhedAXxWW+35zASjTqt1h7tfhvJgBvTLyw0bTkm40fsTVxZ17AnUGB3Rm3222/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR20MB2512.namprd20.prod.outlook.com (2603:10b6:208:130::24)
 by BYAPR20MB2261.namprd20.prod.outlook.com (2603:10b6:a03:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Sat, 29 Jan
 2022 01:34:25 +0000
Received: from MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::3401:d907:2f5a:1ef]) by MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::3401:d907:2f5a:1ef%6]) with mapi id 15.20.4930.019; Sat, 29 Jan 2022
 01:34:25 +0000
From:   Bruno Damasceno Freire <bdamasceno@hotmail.com.br>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Topic: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Index: AQHYFK62qktZ5+857UCjjik6g1f/Dw==
Date:   Sat, 29 Jan 2022 01:34:25 +0000
Message-ID: <MN2PR20MB25127C2E50B7C7102B2A2E91D2239@MN2PR20MB2512.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: f3fd9804-6885-b2e4-6559-22c71d7c7ea2
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [XME6zyP0I7Bm6db7+o9L7ctznfpNIQen]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc7f22d5-c91c-431e-c828-08d9e2c77c01
x-ms-traffictypediagnostic: BYAPR20MB2261:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iROfcssJ43wuhD3PxSu98feF29414em0g4G5xF509aWm+C2398wXIZcXFMBnRODunyaMOOUkEAOUsUmr4TbljWELXw/pX91luc2V9Pl8iQyT0L2PiHnCud8qkC4v3e87loTrUaXggPklHX5r7c4kezzYiVgOyDRMlrgjzxlNT3THPwgR68VU+oIIq51TlPm/58V/F+lnVX3XJLm1tKiQ+vduCjJtH0tP79SiQEyFJxpFW7j2W/rDrhTvhCWMwTrvZGgrMnK84VFHIQb6FYpF1PtJZOO8X535oSvQ1xXblOQhl41Ub8zsJsIjtbST+t/lEXpX/cAL8gHG55g10eFXfbDkABtyAFL+l7ScW60mi7RBewrAkZuo9ghpG4BHw58mISAGIbyBclMDH0wDeeByqx22BgXaNv+zUam7v7gGpf5eidCcbovRpaQkwqP6KAK8Uiq59u2tGAbsQHf2YVODQgrEYB8ApJU8dIGwanGRP4dbeJecg12G71dX2ouwc510gp6jslcSyM63tc5PrafQgezkIOJsLjT21pqlK3zevnZkLYNqwvq/Xu6ncpYGL1jhewGYp1KQkfFs7dahkraszkAN6qM0GDp4DmJX1WOL/jH9zmS+I6bjDZurRzkJFlB
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: HkmXcrBAJ++cK+G1OKkYHAc392IRdHT38XhyMQMdRM/ptciAokhzq91AIHLMIt8OyyyEb/HRWSSX37JtKT9KOzrGAz5kgyyOvAq8z98LXdOhMjxhumPdQmItw329/d06XSaeSVJWztS7pdo+XAdrRz9t0xzfBBAJYZbOD/v2wivz9c4SlhW+xPyTdMDIM4wkdZeOBSotxSQqlcw6F6TJIdd2ltReczA31B3HqaBk9hQNUipTdiBuCB/YnvUJPi3WtE/RgYOPi7L/FVFeTB3nQ3mIYVkoUjl/nWYY01X9XjjyTEvSkFBJ+bLRsnccestGj5Wb7aKthzuzLCIYsJJLT1+7GJlAYSUbLJ+uxG8AxNAXovQAukIJ1IeZ3ER/SG8yHYhm1/zmxS8eqnSbcFIP9BUjziyGjlZ15U8r14aBVfaRHfzzGeNbtUflMiv8wuKvPeLbWbesSh+nYHenYQZL319nMv02tMZlsn1GVYy/eh+HdkNJWed73zSHLADE3T1jQL4iF/v4vuRsButhu0c0cDHKxrRW56SPoMjYAe8NLOvJY/ZA5E2eN7FYqzx5xv0DKLnq35NNMFRQU8YXTVED2ndOToxFZodnNM6G+GGh3l7tlJcQ5GA7B/1Wj/s6RrDs+2l/lxcyHnttfOQeRYIBwL0LsVqJycn39K6eCSlou0rUZjjcDCULjVgMGxmk3IxHcw/bMSv3JcW48Qzt76bbC21IEG/Qdl0DNbmLVadtSFp5B0Mnuv50CzI/+cso/k46zGsQpb70v0O2JA01Af6l/G8DufsaJBe1Vc2TGNDMtNAFafzyHPsTWYGRmquIrZqqmrkaQ9IFLmwI4gP7yCN4/Ygz+CnBTcaDEqgfT0+lnSAjsf9E3Ajma2RcIMYCDypvTHZjvNOcZ1DPZGrHp/szao4UNNS6WX3IvcfX7IJY19BB9YVUpbM649/djqey5cOr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR20MB2512.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7f22d5-c91c-431e-c828-08d9e2c77c01
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 01:34:25.5404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR20MB2261
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everybody;

I'd like to publicize again [1] the following bug that I reported for opensuse:
https://bugzilla.opensuse.org/show_bug.cgi?id=1193549


TLDR:
comment #46
Filipe Manana 2022-01-05 10:54:16 UTC
(In reply to Bruno Damasceno Freire from comment #45)
> k5.14.14-3 : @inode_evictions: 1715
> k5.15.12-1 : @inode_evictions: 166106
> k5.16~rc8  : @inode_evictions: 1715
That confirms the hypothesis. Somehow a 5.15 is triggering ~100x inode evictions, which will result in renames doing unnecessary inode logging.
As to why that is happening, I have no idea if anything in mm or vfs changed in some 5.15 release that results in triggering a lot more evictions.


Why am I doing this?
I got support from the btrfs developer Filipe Manana.
He saw some improvements opportunities and they are on the way for future releases of this filesystem.
The problem is that the regression is outside the btrfs code and the root cause wasn't found.
Filipe was guessing that the regression could be in the MM or VFS kernel subsystems.
I'm sending this to the linux-fsdevel mailing list first.
Tumbleweed isn't using the 5.15 kernel anymore but lots of distros are [2].
Until this issue is further evaluated, anyone using the combination of a 5.15 kernel + btrfs compression property can be caught by this regression.
Please tell if you think this subject would be of interest of another kernel subsystem.


How to reproduce:
I am an opensuse user, so I'm not sure on how to reproduce the issue on other distros.
Here are some updated instructions to reproduce it on tumbleweed:

--SETUP--------------------------------------------
1 get the installation image
  wget http://download.opensuse.org/tumbleweed/iso/openSUSE-Tumbleweed-NET-x86_64-Current.iso
2 create a basic VM
  11GB storage should be enought for the tumbleweed installer
3 install a server or a desktop version with btrfs
  no btrfs snapshots needed
4 downgrade the kernel (5.15.12-1.3 is the last version built for tumbleweed)
  wget http://download.opensuse.org/history/20220114/tumbleweed/repo/oss/x86_64/kernel-default-5.15.12-1.3.x86_64.rpm
  wget http://opensuse.zq1.de/history/20220107/tumbleweed/repo/oss/x86_64/kernel-default-5.15.12-1.3.x86_64.rpm
  zypper in --force ./kernel-default-5.15.12-1.3.x86_64.rpm
  boot the 5.15 kernel
5 get the affected package: libKF5Emoticons5 (4 minutes), gutenprint (32 minutes)...
  env LANGUAGE=eng zypper info libKF5Emoticons5 | grep Version
  wget http://download.opensuse.org/tumbleweed/repo/oss/x86_64/libKF5Emoticons5-(version).x86_64.rpm

--TEST---------------------------------------------
6 install the package: it should take a few seconds
  rpm --force -U -nodeps ./libKF5Emoticons5-(version).x86_64.rpm
7 enable any compression (zlib, lzo, zstd) on the package's destination folder with most files
  optional: rpm -ql libKF5Emoticons5 | less
  btrfs property set /usr/share/emoticons/EmojiOne compression zstd:1
8 retry to install: it should take much longer now !!!
  rpm --force -U -nodeps ./libKF5Emoticons5-(version).x86_64.rpm
9 disable compression
  btrfs property set /usr/share/emoticons/EmojiOne compression ""
10 retry to install: it should take a few secons again
   rpm --force -U -nodeps ./libKF5Emoticons5-(version).x86_64.rpm


TIA, Bruno


[1] https://lore.kernel.org/linux-fsdevel/MN2PR20MB251235DDB741CD46A9DD5FAAD24E9@MN2PR20MB2512.namprd20.prod.outlook.com/T/#u

[2] http://distrowatch.org/search.php?pkg=linux&relation=similar&pkgver=5.15&distrorange=InAny#pkgsearch
EndeavourOS (2), Manjaro Linux (3), Pop!_OS (5), Ubuntu (6), Debian (7), Garuda Linux (8), Slackware Linux (15), PCLinuxOS (18), ArcoLinux (21), SparkyLinux (24), Alpine Linux (30), Bluestar Linux (40), Mageia (43), Linux Kodachi (47), Gentoo Linux (48), deepin (49), Kaisen Linux (52), Mabox Linux (55), Absolute Linux (56), GeckoLinux (67), siduction (75), Snal Linux (78), SystemRescue (85), NuTyX (88), Calculate Linux (101), IPFire (110), Clonezilla Live (114), Linux From Scratch (121), Slackel (123), Regata OS (129), Parted Magic (143), paldo GNU/Linux (255), AUSTRUMI (not active).
