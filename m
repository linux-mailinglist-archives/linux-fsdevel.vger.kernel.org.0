Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7898564097E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 16:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiLBPjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 10:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiLBPjn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:39:43 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2049.outbound.protection.outlook.com [40.92.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D5C4609;
        Fri,  2 Dec 2022 07:39:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ0hCCzu6XvhrLBmo1AohcJwsSr2DEUAivDHu37fJxx9cTqtyEq6cUp4Mdo6oc+Sx0v90jWYlXEeod+ne9FUIfH1j8Y/dxSmtbOKPHZluGgJzydDs6QBgbKj+7qZxIfupwMQ0JH70NZtikttkETHZQejY6Xnl9zTguSUE5neYndS9eYgrO2Jl6QkraKU9GLdmyaA4iKOvnTqbFqxDRSlu65HTyGIsQOvj3xMxAT7kkMhcJTB6E4BPw2Cu746xaxVt60myleGKpGwQSif+DMw0aHTkAph9NKIh+AapnhhGY2Epancz8s9mlzf0PRVVn6b0iIyHR2KIvUIEUVcmg8kBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMShO0wb+udI2OuRox1Tjsmtmz2Vph9zoShFXdn8JTM=;
 b=EkYJ9T64lgHFFzDy1gu38hCsLhTffdqghI0/qmLS0j7EikG+RXcqlh4JuYeb4IGW6cySSuLHiuaMTIaF38rY+oUr6LYqFexEKwxPIUNATvY/ODTTjqS0zt2pAJx/LAsddwiLI53OwS/Z6Yk4nVXkBFdLUm+iTIOA3IHl6EzL1NBAzuKgcWnN2Yn/c3Iet+tgUTmk/2uBb+pZrLPtmdYxDRk4cAw1KIb2mwXuj0jIMb8Yb5xzOGvOZrlDCTM4IorswIWfFzICTxwyUtptQ6xBbseDOvhfFSJFscYTzzczV1XVrdNZAxNIc6qhIm/BKLvrFKFWSHS9YXb9QE3aMqYYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMShO0wb+udI2OuRox1Tjsmtmz2Vph9zoShFXdn8JTM=;
 b=AN9m3pFJNmww5HGfZdoc45s0n4wjAaudhuENqGhf91WsvhwVgbZF9DRg+hgVjFNmCWCmBHCa+TB0qijN+mX6L33skzD1z26I0Kpe3+EAwUMNfITG5P0nR45reY8eVb3QUQh9i41U8CaRgPMI/Q9CPmQsWlCuLcNLAhwb0hSAhv4WVQpqPEskS1rSVulXXzZRyC2AP9XEehFbEEai9VuZMiImoQlaC7d2upd30KFCA+iQQllCEMT5YZ6BOGgBBRQWJNyJlbBdj5QMFIbh4UvWtucE8JD/o2zzURrdJvJHFTTve60NyT6DT+dbvbSq7sjyKhZ9x9N230VWn4WaWiUvEg==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB5699.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.10; Fri, 2 Dec 2022 15:39:36 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::68ba:5320:b72:4b1%4]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 15:39:36 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable to
 be assigned with mount
Thread-Topic: [PATCH] hfsplus: Fix bug causing custom uid and gid being unable
 to be assigned with mount
Thread-Index: AQHZBmRIDbExT15kfkG02K9S1mwlSg==
Date:   Fri, 2 Dec 2022 15:39:36 +0000
Message-ID: <93F5197D-2B61-4129-B5D4-771934F70577@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qGIcFsK2jAfZEIJCdv6HbjZ2pJiz5h5vkEt+XfEQqHNrEaoAE7QLvsB2bKXt36Fm]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB5699:EE_
x-ms-office365-filtering-correlation-id: 10179672-6efe-4560-80d1-08dad47b6acc
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YynlAkdcoBt80rcsAoVg2cSDxl++TfMReX3Pyuuf/YYaK9XrBHvGXDG2DNA1VL54nkTjP9ZeqZL/3OqYk+bOeZitf+Y5Nw8O0yShEKXY60vkqFc5XHs1ZokoSCKxEkGaPjVleGaW+xFzk7sWrz61nvKivijkYqck4Ti5lUY6uVD6jCInd0eAIL0uJ6O+pT4G4PUN6UUQtFoW8aPn5uESKQn0WfIuZ45bIk3TUVwiybupocN0pGyQkgI8Y4l/J9Rr3eQ9hfUJpko7LRCIlmf0BIHkTHsUYqz3zacl76oYrMtjfjoGQCqAudx3gX6+XsxVEHRDRwD+iLfcQrRUiAUMaIysUBS7CFkI+hqx/JES+EVfaLHuvArxIqHqrJz4mTUbPVTCK75JKEDA/6/qBjFuQRCAy4rEjk/Tcr5+rTXQukSKdd88896As1fpR4Bgg7Tj5GmzuyPb46S4Ycd+E1y5qPRiYsZ0ocqeDJsbdkeHSdWRTnE9Xyt5N0ZcpvWn0RUEYNEMh4fN0vcBBZffAkD+TIcF+2InJCL4uKi0zjClezG5i0RiZw89W1ERBzJn0yo8qk8m9Irf7HhgI8vqf+BY+48nqT8qRZBYIYPdH1zW4ow=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b1xeTkTd0FJ+eAu7N2QdH+AjlCHO+nNRg1nSFHfIBd8Car5CJmBXMuhv0i+X?=
 =?us-ascii?Q?Webm0J5dpwFHZA6A+anbS/GiQs/8SV+jOr+CNLw4mLlhUIddCeeQb05i1vAO?=
 =?us-ascii?Q?TRlSVnqOB2r4hyjnsoAxTNIuLMlQ6TwjLdPgqhyDaS84hPjdDRmpmDoVHS9K?=
 =?us-ascii?Q?p5cdx2YPdfIqrIiNe3OS7UsJJ7nLAbo8kqG+slH2XtsfLDS/mQKvhIB+Bwku?=
 =?us-ascii?Q?ufoz4+3huvXh8vHu9cwVAzEK2354gCa5xVHJssYfkKwNYv/iJiyhj/WPScrW?=
 =?us-ascii?Q?JUY8wJ4eHQR/u5LEefeizSiMQrr1vNYkMjwxHJrcikjiB91rtykt1m1VfqmZ?=
 =?us-ascii?Q?zyMzSdxmqR26OAMrrjl2O8MyGCJ9Ru/0ZyS93yxJJKz3ZryaArNMmJlbjv9d?=
 =?us-ascii?Q?FhWozBoojijiy46CmTp23dU3Cie4Iur465zSejD5wvOYt3N/egrcLJz6MqhG?=
 =?us-ascii?Q?8LAv/zGNiWvmCftN2ZtNkcFqLB7ju0/KmNlFHcVZ0vnEMpWz/1KfDHISpb47?=
 =?us-ascii?Q?trcBhhu3mco8IG8er/BtLUtn85d4NHUILQFejfxd+edd1DO/QwW+/1CZsMzo?=
 =?us-ascii?Q?6oLKF8mW6ydK39U/olL/B/D6FAcsu9q49wP+Ipn6dw4vZMyNMPMcoUVQ7hEr?=
 =?us-ascii?Q?SgIev4GBc9/FmLEJkhyykiEqMI71WYHKRWaTpRy4GHlZI3FYkNvEBd4JNEiS?=
 =?us-ascii?Q?R9kvTT+25ncJ2GfN3Yx08qInG9f9AV4rJ+vnFmRie+vUV4L3Mx8BRN6PRpE1?=
 =?us-ascii?Q?f368Mw0C1ikrfAXmBhXXy6b85tj/YehE0yj5IY1h5rnsdMZrCgb0HchfjKvj?=
 =?us-ascii?Q?zfkfnpPQZhkcVKXpWSNrXuJHPu+45/bTcQAHlp8q0Oj3OL30pYzcaezBO5w+?=
 =?us-ascii?Q?LdE3nRAM5LcYXyBWCUeSpc/rmNCtnLlVECWGP2cFRxpgWsiNSvuPxC965juE?=
 =?us-ascii?Q?ofl6D2DJD/I8FMks/Tpmuzi+nPezPodsX2cE9WFngd+VUda078Lpl8DumE9d?=
 =?us-ascii?Q?bkBVXbNz+MyHduFhMsRjxe9pB2Ab4oq52+YD+/EVVDugk/bbQH9VBzDS+fwY?=
 =?us-ascii?Q?Hk5QUJCrT51sp/kGdT3p95OTgw/eqErSzb9khqTLB6xwAfCdCZoSDFsmuuKx?=
 =?us-ascii?Q?2DxEupHr5n1Wo7lFiuccopN3a+nlA1G6SBvxtA5ZJPUCVlFXTQey1NRYOHNx?=
 =?us-ascii?Q?fG/t0F0ZuBl5pIIB9g+QwK55MPhR+Ltudm4x3VTo+xb5Vu0ImZzaSW88z7b4?=
 =?us-ascii?Q?otUsdoKcqTr7b4W+NDHfnGHdB5aZChg3zITwD4ZOcMjo8nz8v5quNiL4V3Vv?=
 =?us-ascii?Q?IAv/hFR2HKm5hwolUTYrZ7EPokSQH66xogHNT6Dn+TeSDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC3588D4EC5A6146B45E333C6E927F49@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 10179672-6efe-4560-80d1-08dad47b6acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 15:39:36.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5699
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

Inspite of specifying UID and GID in mount command, the specified UID and
GID was not being assigned. This patch fixes this issue.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 fs/hfsplus/hfsplus_fs.h | 2 ++
 fs/hfsplus/inode.c      | 4 ++--
 fs/hfsplus/options.c    | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index a5db2e3b2..6aa919e59 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -198,6 +198,8 @@ struct hfsplus_sb_info {
 #define HFSPLUS_SB_HFSX		3
 #define HFSPLUS_SB_CASEFOLD	4
 #define HFSPLUS_SB_NOBARRIER	5
+#define HFSPLUS_SB_UID		6
+#define HFSPLUS_SB_GID		7
=20
 static inline struct hfsplus_sb_info *HFSPLUS_SB(struct super_block *sb)
 {
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index aeab83ed1..4d1077db8 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -192,11 +192,11 @@ static void hfsplus_get_perms(struct inode *inode,
 	mode =3D be16_to_cpu(perms->mode);
=20
 	i_uid_write(inode, be32_to_cpu(perms->owner));
-	if (!i_uid_read(inode) && !mode)
+	if (test_bit(HFSPLUS_SB_UID, &sbi->flags))
 		inode->i_uid =3D sbi->uid;
=20
 	i_gid_write(inode, be32_to_cpu(perms->group));
-	if (!i_gid_read(inode) && !mode)
+	if (test_bit(HFSPLUS_SB_GID, &sbi->flags))
 		inode->i_gid =3D sbi->gid;
=20
 	if (dir) {
diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index 047e05c57..10a0bdacb 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -137,6 +137,7 @@ int hfsplus_parse_options(char *input, struct hfsplus_s=
b_info *sbi)
 				return 0;
 			}
 			sbi->uid =3D make_kuid(current_user_ns(), (uid_t)tmp);
+			set_bit(HFSPLUS_SB_UID, &sbi->flags);
 			if (!uid_valid(sbi->uid)) {
 				pr_err("invalid uid specified\n");
 				return 0;
@@ -148,6 +149,7 @@ int hfsplus_parse_options(char *input, struct hfsplus_s=
b_info *sbi)
 				return 0;
 			}
 			sbi->gid =3D make_kgid(current_user_ns(), (gid_t)tmp);
+			set_bit(HFSPLUS_SB_GID, &sbi->flags);
 			if (!gid_valid(sbi->gid)) {
 				pr_err("invalid gid specified\n");
 				return 0;
--=20
2.38.1

