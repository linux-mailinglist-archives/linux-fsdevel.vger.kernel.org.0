Return-Path: <linux-fsdevel+bounces-7527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1476826CC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AE51F220D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688914AB8;
	Mon,  8 Jan 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RGWF4U9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087014A99;
	Mon,  8 Jan 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNFSBFEVN+CeIFa31+9pjwr6jCOwBcZomdxVKkPgTJ59NzVBBQwKJLKZGjifab1tyOwwiU7Bm0dzz+xWENdu/L7xq7lddI5nsqBmjLDoQznXq3Agu9JxAwnE6Okh1y2sPwqzR3odTzg8Exo/5sIFCp7thtqYWlKCbYSDpxZWY6V56VeTd1zr2nUceeXRtLdMycaQLjbP6ISnw6YsuVKERn7P1Xr7SNtEJc5KCuFxxU8YhZVJusYQ8rCB0JjnGTQUvapBRVVcHrsfPFUPOUGbMHklTa+QZmehHVJsBkkQtQcoMkPzQl4s3+/Y9V0/Ny882iZ6EnFpNFHPgV0AWmhxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTVGxw/cJ0qi/Nr/f6WSdqDx0ok/w9CTXRDs/FMi3Sg=;
 b=OjGZ7mGFrFdH4KPR7ySj8nmnVYkdyEqr4eqn2xe9LhJ4553yRnfjbII2OC1s5Pa1KuO+xvSPNX3ymiMEknrFiqwb6wRw3ldo9IZM4UElXbz9P386JR+gLBaxOdO/KOIqa2+HlJ0mtIMELOYNzDMoA9Gb/qgklI8K8cNyGWVeHLvpfHIpPIcXCQ9lOfMA2G5FRRyke5eXgBvEtcNHi4fJHycBJZF3ywEtH5dE1blWQqAls149zBtmw9SlsfPF5cqduy+xv6Rrs/Nj+/uDZb7fIrNRb4rejwSmqIMW/oM172ofv1ZnExwfE85LVWaQtcAEgIv2xMHZLA1hQ1XkLjUqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTVGxw/cJ0qi/Nr/f6WSdqDx0ok/w9CTXRDs/FMi3Sg=;
 b=RGWF4U9A9t6amScVrTNFYkU75wbseP7nITXW+0ss0hbsCt6MChHc74gfnR7bEY0N4kPtX2QastHF5kg02esfuschlSyQLb1SA23ucSugvi7cQa90PfIV8OLtcWSwDhiN7uUyHYKsoZdUh3Hr9HZ4BPxsgEtQ6tlho7oI4s+swIt0FRQtVIsp6VyM3LEZ52UKTC880rvNKbTW7W1LAyGWEJ3nuui2lORmwkA19gBAgRQ0C5uotaqhnvbpN6APGHhaXzlEUJE+ljEOgeOF7Gx3L/1PoKsHpEH4QUGL174Gr3i5x3Cfa/93r88i3vp0K1qAsV1e0zXLu2DhpMETQZRagA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TY0PR06MB5660.apcprd06.prod.outlook.com (2603:1096:400:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 11:28:06 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f3c:e509:94c2:122d%7]) with mapi id 15.20.7159.013; Mon, 8 Jan 2024
 11:28:06 +0000
From: Minjie Du <duminjie@vivo.com>
To: David Howells <dhowells@redhat.com>,
	linux-cachefs@redhat.com (moderated list:FILESYSTEMS [NETFS LIBRARY]),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS [NETFS LIBRARY]),
	linux-kernel@vger.kernel.org (open list)
Cc: opensource.kernel@vivo.com,
	Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] netfs: use kfree_sensitive() instend of kfree() in fscache_free_cookie()
Date: Mon,  8 Jan 2024 19:27:11 +0800
Message-Id: <20240108112713.20533-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TY0PR06MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f8caf0-2aa7-4989-ee4c-08dc103ce21e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cJ7MW7Wx93a8ybi2GWQUpegXwWC3bCnT41X7ucZ5cFCjMA1rBBfpGulafkxUfVNia8A/+9KBj0wDAFIm0QhxmRll60ZqtHKzGYHTbHI4+f2FSIRKyrQbJy3+JdbwFQL+pSRNVrlREOE7icZxx4ghVXYqgKhFelNRuSDagvurkVpiBJUfpZNONf8YioZHKVSIN09e1nrVWpesuCQYqepo3lEJGYpPZ6RXys0SyDcq6B5ikuzjKZexzrRKdnYo87vlZks0w0Ww6rftK/j486/RzKkv5Fs7Hp0JjzfjbvUSlrZGQgoyplmgQarbxCtT+eXCivswIF+wfWZiG0EgZwnLdUl4f5dU5guHy+ID441eXjBhEV0Wm7xZ23Lb5POykNbLvKH711qd5Cqm3sqhmmaYBlFLjgZ3J/p4r9pYZT0r82vnuNyVxrZbQBpCm0p63+O2PePako2tJRJBvZ+0JJqEFXkFHYI0saolHSHxm4HUh+1ShkFhhCbWgOj7Viaot+O4xLzAxU0vDSQAuNlPQpLSuZQbVo7MugHldj4LLUODdGA8LQiKSpcHzgrqhf/TvKNIb8uS9sOneyKCe5qdTT6KOOXCdvNxiUues1sO3NV4rc02Nth1l3V06CkbPf6pS+Tn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(1076003)(52116002)(2616005)(6666004)(6512007)(6506007)(478600001)(6486002)(38100700002)(38350700005)(86362001)(36756003)(2906002)(4744005)(41300700001)(5660300002)(107886003)(83380400001)(4326008)(66946007)(66556008)(66476007)(316002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJurjfYxYwgaqVTlCg6LEdB4pePsW7umhuw+v61dp4jdFtomGbiPEwluCEJw?=
 =?us-ascii?Q?MSW0gjvRlYFCMXWK+EtLx4aqWeg1e/Qx7mGFxagZ8Y+8d1Xr5iTXMeOSKs9I?=
 =?us-ascii?Q?ERy/FsM3bj3OFRmCbCYBVOQrQEVD9xCYMfuJrpfhXIwW2zoU0nKxMJMMSqKQ?=
 =?us-ascii?Q?kErlDv8Sb48t+pluTFwUB8cbfM0DAfNkH0c0wJQGI7gUKb7m+PzrKhEYTJ5w?=
 =?us-ascii?Q?YfbMVncyQu4ShbXa4uVwB1nNqJMSrGzb+t2lyBz7jZltVjX9u1/BbHCemTST?=
 =?us-ascii?Q?Nj4jQFs13fcbGKdzkq9jlq02x/CmzGLXi3sMyzP5VTfoAX2ZlE/Pn2344JOV?=
 =?us-ascii?Q?OAhJDbr1xy9ohIMg7+MV3fcKqxssdUZ2b0uXIES7YHFmyv/FhhTOgT1W+Sw1?=
 =?us-ascii?Q?WMg8ULrreJIIiUZ27MvYdNfeFlymUmL70qKuawRMCoLfa1k2IbjEYEKulA4D?=
 =?us-ascii?Q?QewceNitz7SepifLapEr102LBk9SdOs7Tt3JOT/tuQNhodYflirKzF+KIsZT?=
 =?us-ascii?Q?tAWZD4h/PvN1anIJ9WMpAtETPz4mdt549a4S2/prI8VIuWgDLkEADjp4TKVN?=
 =?us-ascii?Q?4UcailqoyPWw0hTeNcR2mGS5i32o+VFASPl+GIxuooygIYsHSjL4NM6oVU8f?=
 =?us-ascii?Q?6NZwfbq4MQ/a5zYnv8ecloIEvjTD/YC/7dZyRzx7mbguJgL20ZSh87JDdQLR?=
 =?us-ascii?Q?97pdAJFndr869XXdh0SxH2Da9UL1E1nBwajJ3R8p6b80z8+/spmhJExj4QMp?=
 =?us-ascii?Q?HQLQdLHg5Td9kuPW+ggRt0W1s5cvKmtPf8GUeFo6Uz5CCACC5XqIPer6+L9R?=
 =?us-ascii?Q?mAb39xpDzQYmW1VM1OoqV11QLB/jNB3pRxLWOzjzep2FPiJQ/jYvycEdwLF4?=
 =?us-ascii?Q?UL4/zxwDUeq8H3K2DJQbMMKvV/EK8ZhJWVjloOthq/8GuJzR5zUy0IDmc7BI?=
 =?us-ascii?Q?bFql5SKSgL+NpkK+uV82u8+PhSVDOvZzX9qxuP1sIVnYwQvtnwJTW+TZI6F4?=
 =?us-ascii?Q?r0t1OUfjATyAkqQ/IQoloql9Icr5Bkt8J7u81/OCkB0LS5pnLUtGtNLW1v2X?=
 =?us-ascii?Q?4kXKnxXD7VnCPw3w8mdRrvdYwHfyMLSXsdj8ohwvTga470T8X39ywVX5SoS1?=
 =?us-ascii?Q?mumSc7jhwaQtNCAaG1Ul95oavCdQQK+B+JhExWswoLbwpCVTjwJqlNIlznfi?=
 =?us-ascii?Q?M/xV6/7rEK8LRgnY4P3R/I4E60nsnFnR5kYycDI31erPnBjDQhALE2z5FTVM?=
 =?us-ascii?Q?0Jv/WXyMb8C92SQnsNBDEzLRtU//Yi+NKhRi4eLyFb00NEKDZrFR6DpAP8Ey?=
 =?us-ascii?Q?IzPI1UFC/exvb9SK14wUrdMGqmRxBeix9PNnRRAf1EdBvczkrJtwGsG5dbKl?=
 =?us-ascii?Q?otZL1RZSCFm+lpHfe4D2wSvUhFVAE4AXf0xZKS7JLZ2bbIACkmdCSPaTxh/t?=
 =?us-ascii?Q?ZQiPgBlozQA1C9Pw4nZtQUakofRV6xCLqyhFSRSNaXlpQ6CGEyYB09jB8xLU?=
 =?us-ascii?Q?M/mnh8h9pdgetUzSo49zJnzEbp7qpX1Gz8HINAA6G0xXIt88j/ib/TPEjexV?=
 =?us-ascii?Q?MvFz8z9Z3SCOmBpJO5noUmXyvpqXhxe199XiEece?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f8caf0-2aa7-4989-ee4c-08dc103ce21e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:28:05.9587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zng9zVv04LAcO0c0+ddjeSMdgnsFhqnpm8vOefEeCGVa0L4CNrefDuB9DrZg/gDVh0BA0Jg7CVmpjYBrYQlAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5660

key might contain private information, so use kfree_sensitive to free it.
In fscache_free_cookie() use kfree_sensitive().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 fs/netfs/fscache_cookie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index bce2492186d0..5c917d87f281 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -74,7 +74,7 @@ static void fscache_free_cookie(struct fscache_cookie *cookie)
 	if (cookie->aux_len > sizeof(cookie->inline_aux))
 		kfree(cookie->aux);
 	if (cookie->key_len > sizeof(cookie->inline_key))
-		kfree(cookie->key);
+		kfree_sensitive(cookie->key);
 	fscache_stat_d(&fscache_n_cookies);
 	kmem_cache_free(fscache_cookie_jar, cookie);
 }
-- 
2.39.0


