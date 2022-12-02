Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D0A640017
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 07:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiLBGB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 01:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLBGBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:01:23 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2032.outbound.protection.outlook.com [40.92.103.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173897B57F;
        Thu,  1 Dec 2022 22:01:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1MRFFEBaOlnKpgZdRI9mfN0UPZ+1Q5+6X2j2UDEzqHSpHDuTf4z1Kcrs489XJtTkvh8IyDDq4XhcjvzCxW3mI8m3lYx+lbrXyGkxdreb7c2nSqsY68khZm5G+wb+68k3uVWdQ7TPCbdLHLoSFM5KrCTR+O/2t/7LzJZNuyLfKo32dso+AR2WL3j9hj/43pWfRlAP9yiJnseBylfIWFYTMDO5Ivz6Z/FPSpQe8cIYgsfMUsdKVReCZVLpAQm01lPeyWzwYSwGJiZapJtCpKHqyZeGhVU55ZKrWK1omrFu+FuA5W3ZMP+4rZo5Yb2kqZ02zhPO7o2NINzTBvG4Ee/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV6Pvff4GuBymTgIIBw/Ps3ArFxz1+1GoeMc/bsJq8A=;
 b=lHcmI/GIbpcf1LZHmXKshYvhWylw9O2aOM5H8qLu9LzpNRyrbt2y77FZG/s6Qe5d4CICRuFGYVXlP8Ib4r1wQASvWMmSAMaoxK5tJ6+Qo0Hfs5Yf6mN/LvljRMTZoq6dQex0eE2WgVDs7NO7pN534zpoXeEozxjuXKDejnhNNDIwLQkMXJSQS+bqqSygIVPagK8ZK1aFtBmWKzA43CvCvw04agFF4CjZYe7xowvGXUgDq7OPTyND//xaVsKIMqwSABAIj/YfYszaPFjguUlSWcxQrI/KAY3dn72oEDqc1Jm5Do+d0hGNr4c1svDHtG+R1YvwLYJ1JqySHFrZgKWazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV6Pvff4GuBymTgIIBw/Ps3ArFxz1+1GoeMc/bsJq8A=;
 b=o/aykkAP72ZCrVg5rVQkpadD3omK1XYsTp5T4Otq/Nt04xMUvVfznXSPoaKrn2/JqA3Es0WEs+sNcvAWsFhP/HXvnrxqXEKvkJ+h80APOhbXBNjj7kpZfJSOt1y0M0ZzQD8O9s6Hth3SB5xw6T3DELHn2CGHTNcqPXeTRKdxrv92ItyifacUccpouUIy41o9pRV+pumXMtAu44Esq6Y1UI4Jee3rTcipBt1azUrv7BmuP1mKzIIJAAk11GOM1eg2G0zuD6uhXMe1qBDSNR1QgywB4i/KKcan3/LwvKtPtPgmIS6L3X5xYfrEQd3ARtM832frm+h6VWRnmq4PK+B4sw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA1PR01MB4242.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:15::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8; Fri, 2 Dec 2022 06:01:16 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 06:01:16 +0000
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
Subject: [PATCH] hfsplus: Add module parameter to enable force writes
Thread-Topic: [PATCH] hfsplus: Add module parameter to enable force writes
Thread-Index: AQHZBhN9MNP94cgWt0ywcFHXTOJUWg==
Date:   Fri, 2 Dec 2022 06:01:16 +0000
Message-ID: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [IfNeKhMxLx8eMsXb+qLYm2qBYioAwsh5I/maREVBl9qM+kijCPbB+3SA7iA5FfLx]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA1PR01MB4242:EE_
x-ms-office365-filtering-correlation-id: 9e9d8063-ca8a-4233-7606-08dad42a9fd4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IayyXXUM/sLhnuq8/SaaFbQUcKFwFGPBHZV8oEhc1lPjteZpTcLa8I9Rt6feXVu0gO+tVt5H34gpp+hj0dbuRvxrAX+DhME/ekZU0C9IBGmEcAaetgnyb4E6HhYStoVYln1tE7+SuIr6FBq5+Ks3QWXpAd0olJpsfYUBpKib58jn6EGvJDyAv/NNMX/knTdcivN77FxGPlnPEhmT+pexP1LLkMUiNgcIMI5eS3nJQxBj8xMMC8dlEegYMlF+p4YtREuFi4pAXjGod0HiWdYgtNH1+V/MwuGkf/12eVgRGGk25dZFtQkoY4kApgo7fIpQjWewq+exiI8Px68in7M/wrER5jl1oYOPMSza1vaMJwqfNo6fNStu2cDLKx3ZOdNjVwV9WVAd0T4FMOvnCPI0foSGFsRk8VgYz1gX8Fr6xIV5wkhONSr7Jc1q+gXkZJBBpuYWAdpIB1Uurxrt2jUcVtsq8IPiEIfUQEAVEhD+Z8jXeWE/fCqA6vhVfZ91gMBdej9+NYyvdzrRPMnTHX5yw5gpdnVQFAwBPyLFwiLS+NB3IzOQSt+H8sD6D2VoG/nmXeg1/hAUp/hvIE6k0XUBTHfZKpUs/ZvbI2MZABCqsEA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?80oa2n1amOZByGpdo6WN1R0miPgkSr9BkyHOCI/uRvySnmAQRmzpSPtPOWKx?=
 =?us-ascii?Q?ok1ckxw19P6W6Tqe76i1L5KEJg7lDMmQahZKxNIK7TMFAPJTV5AflrbcevXB?=
 =?us-ascii?Q?wKE3UUqjlzcU2Xw4QrnCsin+YT8tmxw7FLPQuG2i4oL5vjnWjlPizBfU73yg?=
 =?us-ascii?Q?3Sx0KEfI6H/aK17HbVaTgGvJ3rGQDGiw6M8ehUheiFK/Z7hJB10DHJbi/zIN?=
 =?us-ascii?Q?+XXMHYoh0GUS/RiWklk2vo4d7CesTr4FYbniqQVypO55oenPNgKatfAPTkkG?=
 =?us-ascii?Q?U78eNSPe+G8i7KdpI2SHYFOKoy06Sgftn1UqSmuG2O9Ns4rZT9BESXTMDboU?=
 =?us-ascii?Q?mpUKOybpcwfV2NahXBmj/7FzaHbVvwW8n4+OMx6XMD+W1E40nux5cAZgA9y/?=
 =?us-ascii?Q?MerCs21dmf70l79krRHwIeGuZwbTCK4dZAFdDgTyeSJ0eBVbq9iWegPsotu/?=
 =?us-ascii?Q?KOBJwswN4IZpkT0mJh890JCJJVzEd8XpUCgL5xMpXnhcghbwtDFQEyKRgvTV?=
 =?us-ascii?Q?Kw7ww1haHuCqrlTC/0EkqqplYxNwNzKg89YLrwasDZnwQb12gwzgXwPdTH2Q?=
 =?us-ascii?Q?eQowz9e+TIrrbZG8UgM+KILG3Xm7jrKu0GOR6YItWIZsWiy4XLP1D26Nsam0?=
 =?us-ascii?Q?Zya8qKdmDEAmzGWub7LZMXA3J2UuqUdDtW9WDVaH6a7C0sXf04ga9z4uA7ol?=
 =?us-ascii?Q?ltxrKlgpB5FtCizvAXK4zU3Ip9sR6eeBclJz/04lfS47zhU57m8qryK8WTeY?=
 =?us-ascii?Q?Rv28qYDsnJeReYx1SEEaw9rhjBvK4NRhchCJVYwPNwOiVZxK4DbXb7ELbjBS?=
 =?us-ascii?Q?HFt6c9e3G8gpWi5euGtLJScIZMEbCC3gpC2MNypn9f4+uI+5Hmc8X0DpLcMA?=
 =?us-ascii?Q?x4xgyQB+q2E2fn4bUWs2YSYbz0RQzyurGRhYT6TR+kNXc06UkIcm/hhENIFu?=
 =?us-ascii?Q?7QmaA4wh/E+xDKhuE/+V/Px69ZmJkimj8UEU6k+JkeWoUZycJTEm+XhurfWr?=
 =?us-ascii?Q?vFfAh4huWL2UI5jKBl1zZb/1UKU2tcq7yd8YS2CQsjWuqlWGU9YOmgQQhmqb?=
 =?us-ascii?Q?EOdnkmZAEZL0oOsvo4018eDLz3w9RmWK5TtTTtiZLpmwk2GD0vS2VCGPGAdc?=
 =?us-ascii?Q?XtWqJrasFEUzaZxJz3iAYdLT+zB1acZBRXbJwOVNbi6DXS1a4Tmzt7iZmVLv?=
 =?us-ascii?Q?18DH/F/WkOMInGYUovlE8O0Z2mYhMTnXG/7LnKKxc/VzfNJqHgs/w7/OFCqG?=
 =?us-ascii?Q?OfH/9/uxUaVql90YSZtWHd7RRYAPaCHKruXVugmIC83pctBO5BpBhi4/O89m?=
 =?us-ascii?Q?N4kVB2XuHIg8BDwwqU9N/C8GBZW+L5a4zBf/Wo4goxULvQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B621F8D5A9EEA41849DEF499AB7DB19@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9d8063-ca8a-4233-7606-08dad42a9fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 06:01:16.1250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4242
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
 fs/hfsplus/super.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 122ed89eb..2367a2407 100644
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
@@ -459,12 +477,20 @@ static int hfsplus_fill_super(struct super_block *sb,=
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
+			pr_warn("write access to a journaled filesystem is not supported, but h=
as been force enabled.\n");
+		} else {
+			pr_warn("write access to a journaled filesystem is not supported, use t=
he force option at your own risk, mounting read-only.\n");
+			sb->s_flags |=3D SB_RDONLY;
+		}
 	}
=20
 	err =3D -EINVAL;
--=20
2.38.1

