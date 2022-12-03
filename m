Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F896414A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Dec 2022 08:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiLCHLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Dec 2022 02:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCHLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Dec 2022 02:11:18 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2083.outbound.protection.outlook.com [40.92.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F77F892;
        Fri,  2 Dec 2022 23:11:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+GexYbov08ie+pOTm9ptIXGAHJwQnzOTmqcGUnn0m3mkW/1QV4o7r16H37cOiJ4LdQXwXk1vY+GPOH/ueYSoQEP6LCPmSWXmKR727VpxdWl+R8aaUS1gX5VGzXtU4lWLaxXRo2mG/4DQTa/VwXlQ9/d7WgWQ3PT8AKd3VZLldtMKDORQYqv9O0omDIytneRSEDwM3sdhvu1fFTlOxk1M81bsPX1V7/ZxGTX6qUQNVdK51TrFtLZQQ2oo4hhyq0PqTDAwoOX3LDBu+EwAOcRRxoGE8hS49Ap1u8zMU81uxQV3YHK3p11gx6edd/V9Qv+1U/TsK12N6pUVibZ6JSDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U5fkHI4TQuAxE2JZf+ItwbgrXEkHo+MR32tMV+2Y20=;
 b=jF6oicP7rw8PKdTvyM2A1PJZpGq8bhmmtTAvS1m9RXEFXwN/ey3A8G59PwM00KVIeLdOUfk1Agatv+NWK2SkYBeits5ZAW9QOsa3KGBJ2/jPoKSanAKrvXO6DHp0SZmeCfL4OISkyE/PkAFaUimM5xu+StBZizQqDbQxTtNvJy7q4OjxPr7XxF/Gr64uvWs7IpLGgwolCXI9zmdpWLDBxd67OnMx5kgX/HcqRveRe9s1IP4RV7wnq64mpPcqjbibJqRuS0ypNkhDlayjJ5M3u6cr6H0wfC8EJmxI4yFICUBoJ1uDFfT5C7euuvyS0QHJYWYlkyQzVcI/V06qg9PrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U5fkHI4TQuAxE2JZf+ItwbgrXEkHo+MR32tMV+2Y20=;
 b=SGd3vikKPp7o6XJPD2WGa5ly99Q2aKddZyd7QYJDj2S9P1pvdG79bLVKb/Wd0B/gHvYc3WoQ4bjENpO7Z5ZKEqQ+CG2jqgDV9Fzxqj63osv5kqOlGlF9BnncQvBR2HvQKIN4GZMtXEqgYr6znvscXLxh7gDEky3tYK9ojBfIolWHCYttkbrl9qR5n47qOaq8fcrHhS3ln17NxqEXVepXJiWVqNf1kvGvsPSyuNwsh7dv7dCZwae9O2v1YhrAofEw5R46f/lSXd0ga1FaNtMLjh1MJeKwJJBUQxTnB/tIhgDYSEISE2OWsPvzJ7gLdnb237ylmiFpVkrZsbFSRlVvLA==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAZPR01MB5639.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:62::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.11; Sat, 3 Dec 2022 07:11:08 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 07:11:08 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] hfsplus: Add module parameter to enable force writes
Thread-Topic: [PATCH v2] hfsplus: Add module parameter to enable force writes
Thread-Index: AQHZBuZqqiAp/Y+oEE6UMaTrbebMmQ==
Date:   Sat, 3 Dec 2022 07:11:07 +0000
Message-ID: <79C58B25-8ECF-432B-AE90-2194921DB797@live.com>
References: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
In-Reply-To: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [PUYnsE624PIMRn3+XQbHAKLNEfZcWrwD]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAZPR01MB5639:EE_
x-ms-office365-filtering-correlation-id: 54a63288-d88b-4479-ad3c-08dad4fd8cbe
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sIoX3RkA8mHjJfKV/xLAFv8ZyywbI+HDqj0xj00788XTCQxSB9+/0sRSvtwNZj0dqbmjv/Zo3JglQHd4efGnRYS8pOT/VbpQEQVbHjFAKupglfrNAei1zwbif3mX2OQsWIsOhtfAS7CF1CjT3nZ/mfZYAqbX3whmRI2byX+hlD+pydVyLC2gAI+rfCDxmqJsB/cH/f8Wmvanhvq9B5oqXTklNxQOQoWmft9A4gKiweyZp/DVHI/foWwcfHxfHKLRvDGtsby85ppB4bySvd98xZKWBNxZpUQetErXH4/9vzL3a10yFE6SENOnx9cPhiqM7xd37UNgG3qO5/PoJA1ffjEwY8IQz6XNUInXbHsTFpJ1AkIMI5qAosqceYUvrBQDuIEFElcnXlf/z13JRspLpSNaIOjUJFLRdRtBM4ZLRtZPp0jb2aMLf8amnUJtU8/hLqQWBcRvSMl4FR/treW2vRV5F3gfeXeOlf/+FqQwM5G15/NLyqy0SDb+5h7qtzVxH0uck5ZUZMVx0iv9Fqv7KGDC2eBNPyS3Fjjqd+P/KEjw9owDuXWsLIU9vGtJvjf2LHMspv/GgOZuq7hIVkN53+r9YJjzXQSluNb/lozbg1I=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k2e0XGXipVuYXi/RBTRUttKccvjNcHrP7bkw7HhiBZH3LkzPoht04gDSSq0q?=
 =?us-ascii?Q?UQPShl+tcv5pyrdBTuPHbVy95gpvHfjJwap0p6PRWE0nMxKMbt6D8s6Vb9sp?=
 =?us-ascii?Q?0mUl3vbSi7pmxdKT6TvqFA8myLLMk51FgLYaPUt34NiNZTfpReqLiIZuz/Ma?=
 =?us-ascii?Q?kb8JCNWlbPGv7FAwVo7TXtR/XK/CYlbleIXtSrmmY7dR7uaEdaDZyIJXhQfo?=
 =?us-ascii?Q?kDB5wKuHFC3qFTFQ85tjIEbVraJRsZoXaPSpdPHlgp1OOwS0ABkH90sSAObb?=
 =?us-ascii?Q?9VfAxvegmbZvSq5yS0i4jGx7Oz4lzY0OaBzMA04Y4qoHPDeYn4+5bMWOyMPz?=
 =?us-ascii?Q?xETkPFQPEO+424dyLn0KLdermdEYytTGKm7eM6krvCYNOIZJqO+L3No4ryNg?=
 =?us-ascii?Q?66mi/OweP9jOdlIQXmJhyRBk+YKcOsnoJMFNISe9CgHfif7AUNyQTeQOGEge?=
 =?us-ascii?Q?d3Pkoi9PHXmvupGAlJPx1R+6YUvFmqibbt32y2uQkAYUy5R99ptQF9ceNrne?=
 =?us-ascii?Q?dT3zT/Fjfd7eA/iIqFuxIiijyqwGvGcU//1bLQa4u64j9K55W/6lhmfTicF4?=
 =?us-ascii?Q?ptLdmrc0/kfnivY62iH67mJctGnsDn3pG/x6+WIvPQB4E7rNh1e8AEuIrya1?=
 =?us-ascii?Q?WTrtXDBMAk6CY2GNvMIS8q7bxeRo9QX9+JVksdlA2+r2q8ALWErpSooe6D8T?=
 =?us-ascii?Q?Ygh0hJLISbzZQP9rsWNW5R5IEb2hC0FYXrnJ/XT+C/yiCaPFFp5Wf5wYdbxd?=
 =?us-ascii?Q?MN+tqcev7+G3IYbuhY5O3pD7LBlU056MyhOEoHHHZUfiN7QHiNZHF/zQ1/Ii?=
 =?us-ascii?Q?GZ+u629XbF+8CpEaRKvb+37rSSPHTNmHkNnjMNhlWgGEmGSm1LzMmm0cki+Q?=
 =?us-ascii?Q?ACr+g6ew9BQmJ8IgZXMcu5OHMP2Nga0IhHGUHddldhs4fzLXPmJavIDi8K9E?=
 =?us-ascii?Q?Lq+xSzSjPOZzAsANvhpkLwBZfY3ixgh7cdZksYt47DM4YnTULOxBvFABovpf?=
 =?us-ascii?Q?f2wNRLTOeNZH8JpiqseGxU8PYqLl84pXWcqFAlD8mosHxiiHgWdIyq+GKAZ4?=
 =?us-ascii?Q?vnQYx7TNHAl0FUhmmfgeHbpKWeZrXxCW3e7UigDqsXZv2GwapjELRI5D0oEO?=
 =?us-ascii?Q?Qt4809aB/SEU7cpUHbTmYp19FqYDOGzKPZqRMZNjDkjPEfCGKjnRSICoSrAr?=
 =?us-ascii?Q?Iy6DJ4+5gfS9m8VKMtVhqB7Q5hqsAMrOrgRX8v0Mbq7JqCOQQmPyGd7MJYoW?=
 =?us-ascii?Q?Qumv03hCLn1EPmo5+S7z5Vkim6EqRlROGMzOBcKuWw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20448BA4EDBDB84491D409D3550DCC7D@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a63288-d88b-4479-ad3c-08dad4fd8cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2022 07:11:07.8998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5639
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

This patch enables users to permanently enable writes of HFS+ locked
and/or journaled volumes using a module parameter.

Why module parameter?
Reason being, its not convenient to manually mount the volume with force
everytime. There are use cases which are fine with force enabling writes
on journaled volumes. I've seen many on various online forums and I am one
of them as well.

Isn't it risky?
Yes obviously it is, as the driver itself warns users for the same. But
any user using the parameter obviously shall be well aware of the risks
involved. To be honest, I've been writing on a 100Gb journaled volume for
a few days, including both large and small files, and haven't faced any
corruption yet.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2 :- Add Documentation and split long lines across multiple lines.
 Documentation/filesystems/hfsplus.rst | 15 +++++++-
 fs/hfsplus/super.c                    | 49 +++++++++++++++++++++------
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/hfsplus.rst b/Documentation/filesyst=
ems/hfsplus.rst
index f02f4f5fc..85feca0b0 100644
--- a/Documentation/filesystems/hfsplus.rst
+++ b/Documentation/filesystems/hfsplus.rst
@@ -46,13 +46,26 @@ When mounting an HFSPlus filesystem, the following opti=
ons are accepted:
 	Do not decompose file name characters.
=20
   force
-	Used to force write access to volumes that are marked as journalled
+	Used to force write access to volumes that are marked as journaled
 	or locked.  Use at your own risk.
=20
   nls=3Dcccc
 	Encoding to use when presenting file names.
=20
=20
+Module Parameters
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The HFSPlus module supports the following module parameters:
+
+  force_journaled_rw=3Dn, force_locked_rw=3Dn
+	Used to force enable writes on volumes marked as journaled/locked.
+	Its risky to use them as they may cause data corruption.
+	Accepted values:
+		0 (default): Disables writes
+		1: Enables writes
+
+
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 122ed89eb..91812c4c3 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -24,6 +24,16 @@ static void hfsplus_free_inode(struct inode *inode);
 #include "hfsplus_fs.h"
 #include "xattr.h"
=20
+static unsigned int force_journaled_rw;
+module_param(force_journaled_rw, uint, 0644);
+MODULE_PARM_DESC(force_journaled_rw, "Force enable writes on Journaled HFS=
+ volumes. "
+		"([0] =3D disabled, 1 =3D enabled)");
+
+static unsigned int force_locked_rw;
+module_param(force_locked_rw, uint, 0644);
+MODULE_PARM_DESC(force_locked_rw, "Force enable writes on locked HFS+ volu=
mes. "
+		"([0] =3D disabled, 1 =3D enabled)");
+
 static int hfsplus_system_read_inode(struct inode *inode)
 {
 	struct hfsplus_vh *vhdr =3D HFSPLUS_SB(inode->i_sb)->s_vhdr;
@@ -346,14 +356,22 @@ static int hfsplus_remount(struct super_block *sb, in=
t *flags, char *data)
 			/* nothing */
 		} else if (vhdr->attributes &
 				cpu_to_be32(HFSPLUS_VOL_SOFTLOCK)) {
-			pr_warn("filesystem is marked locked, leaving read-only.\n");
-			sb->s_flags |=3D SB_RDONLY;
-			*flags |=3D SB_RDONLY;
+			if (force_locked_rw) {
+				pr_warn("filesystem is marked locked, but writes have been force enabl=
ed.\n");
+			} else {
+				pr_warn("filesystem is marked locked, leaving read-only.\n");
+				sb->s_flags |=3D SB_RDONLY;
+				*flags |=3D SB_RDONLY;
+			}
 		} else if (vhdr->attributes &
 				cpu_to_be32(HFSPLUS_VOL_JOURNALED)) {
-			pr_warn("filesystem is marked journaled, leaving read-only.\n");
-			sb->s_flags |=3D SB_RDONLY;
-			*flags |=3D SB_RDONLY;
+			if (force_journaled_rw) {
+				pr_warn("filesystem is marked journaled, but writes have been force en=
abled.\n");
+			} else {
+				pr_warn("filesystem is marked journaled, leaving read-only.\n");
+				sb->s_flags |=3D SB_RDONLY;
+				*flags |=3D SB_RDONLY;
+			}
 		}
 	}
 	return 0;
@@ -459,12 +477,23 @@ static int hfsplus_fill_super(struct super_block *sb,=
 void *data, int silent)
 	} else if (test_and_clear_bit(HFSPLUS_SB_FORCE, &sbi->flags)) {
 		/* nothing */
 	} else if (vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_SOFTLOCK)) {
-		pr_warn("Filesystem is marked locked, mounting read-only.\n");
-		sb->s_flags |=3D SB_RDONLY;
+		if (force_locked_rw) {
+			pr_warn("Filesystem is marked locked, but writes have been force enable=
d.\n");
+		} else {
+			pr_warn("Filesystem is marked locked, mounting read-only.\n");
+			sb->s_flags |=3D SB_RDONLY;
+		}
 	} else if ((vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_JOURNALED)) &&
 			!sb_rdonly(sb)) {
-		pr_warn("write access to a journaled filesystem is not supported, use th=
e force option at your own risk, mounting read-only.\n");
-		sb->s_flags |=3D SB_RDONLY;
+		if (force_journaled_rw) {
+			pr_warn("write access to a journaled filesystem is "
+				"not supported, but has been force enabled.\n");
+		} else {
+			pr_warn("write access to a journaled filesystem is "
+				"not supported, use the force option at your "
+				"own risk, mounting read-only.\n");
+			sb->s_flags |=3D SB_RDONLY;
+		}
 	}
=20
 	err =3D -EINVAL;
--=20
2.34.1

