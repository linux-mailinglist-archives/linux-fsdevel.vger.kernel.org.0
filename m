Return-Path: <linux-fsdevel+bounces-7524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41951826B6C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426911C21FF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A11914286;
	Mon,  8 Jan 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ao8yEmh7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA241401E;
	Mon,  8 Jan 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZPht+fzp9VnQqCJ6tgviLxr/aydtqP69wrByy6xpwuvsMFzSj2/qOPViqyZTqL10mfnsaREgevY+jaUNCx3f6Biedxv00AAhaTqPyYYeXPLL/FMB70CufMiZu0Xpr4L63GhTdP5XkwBjpUW2PityCZI811CTCwnGirCMkBlJ4yopqZ1AQPDeAvQjsRqci1sY7tJzOJKHvZSbcFuH+qgQ2rO7mq543+3oz5RJ9Uyl5607YlW1t7xmZXsuKF3k7v2i5GY1cM8QN2nCZTZXhrj9qX3dTZwUwlp8P83/qE2qeQQsEHmA0XVZFghvjgjW1hBhzhAhzXCWgsknv6BYYpUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JohBA6DYOYKkTLXlGBPW04fH858xBZ7w3Rv+duUVACE=;
 b=fjGhG5+u4b3NdPPJk43g/OkR3KEUz2FTklKfJt7rjTMiOFZQ9EAxFgsXxMKD37G+iA6LqY1HwOFK0HWh2cb7gdHuFbWH+nB4Wbk+/ZJvWlzMfxFVDzR4ItblhM1UftR1JQGypXWK53Rzt2RYAl1ZOm3JLv42TsqqVV7lLCdp0DvdfW88iub9jKD83QSoxuzKZXTPU4ay5r1BgU+d26D+XDEwpm+rwf6hixHFcfZvnbjZ0h1XSaTqhNcQcpkYN/jjYK735fCD67fWCWYB5OXZyxBKMadXELNFB7+OnJyWWVsof2pAaH4pkw7ZO7vDM2JmYO4vO2BAYSlcoqWst/xavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JohBA6DYOYKkTLXlGBPW04fH858xBZ7w3Rv+duUVACE=;
 b=ao8yEmh7jAX3bmwDSdyhAu9lmRM/DEnnePpIZRObpt0EMGk5NH8hKHDe3C81RnfU8/hfMmwrYvbshxmdy1LNBf4XcG+jhKQxomKXc8Vfzb24Liq3A7Z90AF8MyI/eoBWT0YHPO6B9HV9DX9bcYSUcGvV3j7p4ragFHOHg0YbHaoJ1kGow4/qhzrkjtfq6Qemu5ZiWKon6VJVmhtiiVYwBLtjFkziX7l9kRIBT/fZugS5NM1f3AFUCOqS6GrQCJc3fdEyMKfap2RfeMW5XzxVMKL07DiUw51x0jSxcqeA4blht3XoIgQyqxTEBDgGMEcH45ymmtoAta6s3ufqbqj3bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 PSAPR06MB4472.apcprd06.prod.outlook.com (2603:1096:301:79::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.21; Mon, 8 Jan 2024 10:14:38 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d%7]) with mapi id 15.20.7159.013; Mon, 8 Jan 2024
 10:14:38 +0000
From: Minjie Du <duminjie@vivo.com>
To: David Howells <dhowells@redhat.com>,
	linux-cachefs@redhat.com (moderated list:FILESYSTEMS [NETFS LIBRARY]),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS [NETFS LIBRARY]),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] netfs: use kfree_sensitive() instend of kfree() in fscache_free_volume()
Date: Mon,  8 Jan 2024 18:14:02 +0800
Message-Id: <20240108101404.19818-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|PSAPR06MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: fdae1834-906a-4e01-2904-08dc10329f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q/qQ0cOyMXA68dMM9I9EVDKdf/T4SogOjMg56oXL7Sx18w+9/rw0SVmRY9hqtsfOzPHlBNDj/aRPO/TYuaCcxZ0zAwG9kQ6M1sflXDVLIElFRUTq7I+0LyZiY/+oDz8lo7Y83g6HqMmqVKzjmS9gQPsh9wuw4N1kh3oHCR4oqRFhUpijZHPKp2u08nBMz50XvxhpBQX7EYUjA3EY7uvWmA7j0NIS1cX/ZctjBQ+8QJSCEqKDZlI1Y9Zh3rZqSYtGkn4Jvrzt6YSvy21aRVVykm4UyJu5RTaxdbY8dnZMU5aG9GDXWX8k2lVvgJHgxU7Qm1f/H3dPg2wiQdr60Uk/y//6Mc/EgTX9caB9Oi8fNrvwG/1V/jZ8HO+QYM9RKEyMcYGZ98OfzmkcXYq4uEqY4KjE9DrjL0oNUsefsnE6rZNBDTlkWZrzRcx5q1q5r0xv3WpYPIMIriuE55pnOB52Y7u0NwyUJzjIobYxZmNtrv5XkgDg/R3j/fW1EKLLfhuxDz4xJ1w8ANB6p5Q9h8c3m6YOmEGpCZzDZf7RF6aPVu639wPAs2UPcjpNiKO76mLL0VhPpK1F1zo3lLGc7rVjNHFQ936gkqIczRfkx5/UZhd7EmLaUy6xqHZKv9Ly9xrq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(366004)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(107886003)(26005)(2616005)(6512007)(6506007)(1076003)(83380400001)(8676002)(4326008)(86362001)(316002)(478600001)(52116002)(66476007)(6666004)(66946007)(6486002)(66556008)(38100700002)(38350700005)(2906002)(5660300002)(4744005)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KT/Lb5yY08qub8s0Hvc5qWOi8M0NdUM/PoLhhO6ASyvCrVOoXauzjSOlSPFz?=
 =?us-ascii?Q?U4KDqEJbscDbECz3uXwqltfibYrqIm0N3j3kyzUnulYA1rOthHnRKhlQ6mIn?=
 =?us-ascii?Q?nWNNfbfrD1IllcaP3ik/blHg7JCO1lGsi7tGloR9Bam1/o3TGVQuAK8dcTMj?=
 =?us-ascii?Q?N0xO7spCIRAIXI9K2aW+pdMmLepzuIAGfdRuwy6qWUv8ERY8JatAyGOmHzMX?=
 =?us-ascii?Q?57wfCiM9UhDiiSLqBQOVqaRSUGMVU1kPqJrewOpE/K1JGPTL5D3HTJI/BY1V?=
 =?us-ascii?Q?arMPRxOcSauVv6OETo0EmzMaj29NGjuVP0zWOTGscSbN/viinH1cQudFkP9Y?=
 =?us-ascii?Q?iJXy27UllWSJachKVbOVnqHteoBWsZceSGaJ7CidEz1T31BST2IS80om7POl?=
 =?us-ascii?Q?ZAjiKvRV0pL51fJ+ujGmpUjQ8o1ayJzCYgfZfPQLb8b6EttZgfO7/9syuWyz?=
 =?us-ascii?Q?gKVMEKmQmw7GhSasQ4uZ5kctVARqM8oobPoZnQ3K2w9gLFmSsEJ76yasw2Xw?=
 =?us-ascii?Q?Ao5AhYGNVyOLfPyzZz7kk6VjaHLQGSdNx2QxQEFzu3q1wQvAxoNLjDWgpdF/?=
 =?us-ascii?Q?AkiNZG7CIbB2x/XpW21LD7xctkGGM0Rl4Te6wCdEXNq9dkKrT3JzwGQWTZSB?=
 =?us-ascii?Q?Prs9BceVkdjpSUzZFxZt+zmWuC0tbPyA/C37vo6Silm11ghV7HDXfI2zaltI?=
 =?us-ascii?Q?4iQZYNR3u8MxOkob0VttzKip046ASwzoYs/rZPCyFa8fCFjBqQd2zcXnBtmo?=
 =?us-ascii?Q?nNpQMoDr6IFsPBfIVmEzvlr1vjLVnvk6oy6NhrvkMRCqt01G09TgSlhsvX4Q?=
 =?us-ascii?Q?/iu6OirfMXFuzkoZAAMVFBmEF6Dsyl+6/9ecJyb8phVp4znUlCSZYSYZy5jm?=
 =?us-ascii?Q?IJUPIDeTWTUFzIti+r+UXixiJS6Q/ZVy+k10a2PQejPYICzp7FfpC0Ltpz50?=
 =?us-ascii?Q?v2MiMqGFFqTdCGJvWcye30C3L2iBD8ol8XGNksawuaLqq3fS1bPKNLoIODVE?=
 =?us-ascii?Q?Rwf74FaPZFJqKT1svfBaYDM7sCMbgSDk14Cx5y9hzgcJsQED0p2xs9e5Z23l?=
 =?us-ascii?Q?OuBVh8VZz0J7ohvV2JcIiCeUr1X2UBpu8MhQCFawFi9ZuUHPrzVRz2OgCpg1?=
 =?us-ascii?Q?fDVwgKMSHmLR7ISXKKa+MAss8gEuHAkvy1C8bjV1lCgTtgCBJf5QsbQQ+NtT?=
 =?us-ascii?Q?b2D9KQqqaWjQgbes8WmGJL1klnOEZ+CdkM6sxn1diKJ7OmgljO7MCkbBSibV?=
 =?us-ascii?Q?8zUpdwqEyt+T0BsaAhJepMz5cqTarrPf+YZbqPJRI5+F9J/a7twNoUppRiqX?=
 =?us-ascii?Q?P7hUJ9qV9i8hOi7WOJ0O5oYAj0M0L+axnWVxQEW/0oiO1KnWQ9gIn3Kwb9do?=
 =?us-ascii?Q?mppU5EaCBRy5CpUAOSEo6prozp8vFeHzIKlriKWm0+z28PQnJl/B3gl0ChyK?=
 =?us-ascii?Q?8Yr/Ibu4acm4GQ5E7R6uPr+aqlNI3VEtazwzkP1G4HsyYJ2bK2Awb97O/CBc?=
 =?us-ascii?Q?850UyrDq8qnH4auIZG2d/mPiKP3Z2BZjpPnBYToRnT/sU4k3tMN8tss/W2Rr?=
 =?us-ascii?Q?RXfk4VmS+bkkgbEGGqxzOzs1BjjWODV1N2UA3y/F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdae1834-906a-4e01-2904-08dc10329f23
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:14:38.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2myP9xiKq70v5ijBZQ6S0oKS4QIDe1H8nUDBZqnbSkU1ZJXtSdAuKaZIJirWl2AwYWUx3UrHrgePwM5+x+jlpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4472

key might contain private information, so use kfree_sensitive to free it.
In fscache_free_volume() use kfree_sensitive().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 fs/netfs/fscache_volume.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index cdf991bdd9de..648a7d6eaa6a 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -397,7 +397,7 @@ static void fscache_free_volume(struct fscache_volume *volume)
 		fscache_unhash_volume(volume);
 
 	trace_fscache_volume(volume->debug_id, 0, fscache_volume_free);
-	kfree(volume->key);
+	kfree_sensitive(volume->key);
 	kfree(volume);
 	fscache_stat_d(&fscache_n_volumes);
 	fscache_put_cache(cache, fscache_cache_put_volume);
-- 
2.39.0


