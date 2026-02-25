Return-Path: <linux-fsdevel+bounces-78368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AwWEprwnmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:52:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B5A197A61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 687FE306815F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE313B8BCC;
	Wed, 25 Feb 2026 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="epIntkV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021109.outbound.protection.outlook.com [52.101.62.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3E3A1D0F;
	Wed, 25 Feb 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023908; cv=fail; b=Y9D3+1jUQ+tm7jgwXcos6rcG70ggK6KpNsG/h3RclvWXLa87pE/hhqXXQ2+2HDJsqmTfWXHV+/axVH9VgappNhCoAz/T29VX2/t/tuWYMAzIBLvc9xzM306CLjlPfNkLFAr9u/eZQS4/kyOr0ff8Vij0X0UNP3ku8KR1RHonwV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023908; c=relaxed/simple;
	bh=zfK+acPOvQ9rVnnHqdLg88/pGkVd7xDaHpTuiCABNEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4LYnROYrwsau8CGXkbyRjhpYA9A9UfzOv4ordnYsBevzguqGbeuBanpxElK2wON1NK+U2K5P+AQS6EjwqopKyB2Sg87Rk/FTXjM+/7IhUjCRJNXBPaEVpw2jg1+/k8+JNysxteWmNOSDX8YvI7raEm27RsPRS4GLXR0G/z+3tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=epIntkV2; arc=fail smtp.client-ip=52.101.62.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHru9eCjQO6f46DWdyf7vf0G5LILu5mVqqwkqq1N+xWxKGYoJ54LQYZSJpYMT655VLUV2BcwFsnZwET0xsM13ioFcSoUs8hVmd0UPi3kkygXpU5Kgab81tJD9+B7ug4PxtigjWdNty2ifF9aJyxmWJV8vszZskGiBy8tepnrIl7NxhjgSvuBYoS6AyLVcNZxp2fVOVObhmOQuaI39/2NFtYZbphEXEM8Q203KjVgPThqdhPYF6xcXDGr1qUct9t0fotn3t39yzHiJwx2JnqUfEL8sR0Z9M+EtH5Xx+mWEXvWOmO4QXOpdXn/Zt1u5+R0mn6DgzbB8xv4WvuTSeXq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFCDBZZVwddIuNX73ngG8mYHC4VzCBrRR5A5XZKTkwE=;
 b=bbI//H3OVjVQ90oM/a/31KirrKxuQ5r8YNleLUJ7NLhAfjLlJvrFJmb00iAovvW6ATWHSaezZuYYUAJEl2QM29foU3HCnO3g/LPcRqSAREj1/J9ei1LO/bcYZGEaOJUWxqktlUJM0hMNeZoGDPIEleSQ8CX6OVF8wdbhUshZyzOA2D6GgIMnFGSK0nzeXAVoKrKuPj28TxZnsuoeAYwe/r4bZPWE17JVN3lC69Uq4m9jrx+Qtp+yE1Z/SK7vkZ5peNCwXMMqqhvHNwflrhB/Lep92O099TZqDCBetVIWCXxFFqMuRN9rhVkA5P7PAqxdCwjEli+hqCsvDf3lJV5XBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFCDBZZVwddIuNX73ngG8mYHC4VzCBrRR5A5XZKTkwE=;
 b=epIntkV22/izcqJL30geziOYgP8fLGBGXfx2LJHve93iZR5eZVvILYUq6TzDIAOJZLAkqtejVFFdNRD08p65WHT51uJ7RhK71bRcdeBiosBMXT8nIszKKzAxmu5IVQzL4WImo6W0y6CPyzs7oVQ2aTe1usWOzDPSecZINPQRs2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5206.namprd13.prod.outlook.com (2603:10b6:8:1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 12:51:43 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:51:43 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v7 2/3] NFSD/export: Add sign_fh export option
Date: Wed, 25 Feb 2026 07:51:37 -0500
Message-ID: <1b3ba6ddb66cdcd2f63db2961f52894bfa3f1fd3.1772022373.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772022373.git.bcodding@hammerspace.com>
References: <cover.1772022373.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:208:e8::32) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM8PR13MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b285195-4dac-477d-765e-08de746ca062
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	qBVf2JoirTo01J5RQDK9lUqa/LP+3VWOnXjRUlKZKXJiFVpby7DeF23doqjdt8qrevz4ngCmS6PxvG6/MygiJ/orTZS1cKkeS0h/IoaTmXqZkb836BBdZOnoiF0ICR2SuYD49s12ztXBj8OVVGtUhF3qGOFcWsJsZ8DEZmfPV8Dq08RDRS37rI3JVKtUaH09kUDaxH524AtfAprJH0l9hfALvAjxVeN7OVCBMRLZa+t/koOu8FGc1p6MP5ySVWgjfC0Yk8DKdn6fxz1PtO82lq6tJAu+DcP21z5VcpLZThJHqpfr4O0QNod7XmHuCzeyGf5xCmY0NJfcCViKk+o1id5z8gD1Jr2YTV0Klcq9P6Myk1hJEFVfdn6pRyG4J4PlOZ3/yyfzwz7xO3XOCxdMtB4VvZiQLwcgF5LrTH0a/r7SCzjgEdxAJRF+Ky9sWlEBYEg8DS9eantnJuaw2Ht1x2cNYZopbg24SereZe1wKeFyj7hYicDj5JS5nQ2U8nQZXtX9GX59QqBCdeJkT3aM27nQHHbhuSi76Tr9t/BK0qatjkwAgI6f+pXdQRnit81j/p06WkszC93b6QKfmkx/GmRQqfba6T7dde7PyfBuvp4yvX8HQ4n2WP9bN1nykxr8F83k4Htwmq0obEnL2svSoX/wj299b3NBcS9GK7zUsQ0iaWUwcNfyqpKCa7fei6DosEcwOaEnzDpFBbjoNm4a2JN5szO9XJ2zF7r6i3sT9Qo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u0vmEMBLeVbzdtz3lijUn7JYI2x94iizv2dIy/QAWOQovRgkNG1XjDDP4zrd?=
 =?us-ascii?Q?Et7WkVCyeAs7gNN92X9CTLGYrQ6RtY0JZ40y6PbPch+ioOAGS8Qckk2yxxhE?=
 =?us-ascii?Q?wCLfK5SH9WCjD87BlYbumDVrQchCn1hnOjx8pwSX60xcy1GzeXwTpAULWdxw?=
 =?us-ascii?Q?OzK04f+88Rs23VCVV69370GLZX1Brlfkb3G+2ysCwqsaBl+y/+PJh2IR5DuU?=
 =?us-ascii?Q?Xqdop9j4l4DWxkzFJy5DPODKYm9Faf/mIbkZL7l8wvKKtAt/fnmuzgXyTale?=
 =?us-ascii?Q?mNkPFVY14XNkPAZtN2IUpKSAh34ZZNKpRtJVdhAHcAdQyoE3cBZhOUggJnAY?=
 =?us-ascii?Q?yCkQLdTyNi7+BSr4G1h8MwxWafT4DXqfE3keLZSeIqwhdzVSPnUadnHN44oQ?=
 =?us-ascii?Q?YaRIM4d+Y8PlXwI+idmrMd5MQ2ux9M4ONKpnd8bVScLTZby1oSPTGfKh7u7Q?=
 =?us-ascii?Q?JV/i/yXVLqayljWyxZ6+El3e9gEn3RjlncNKEPcRe+hJfzfnNldsXeIXTpCT?=
 =?us-ascii?Q?EFfSQi5wqHOeWbp5H7QuDqxMyZ5vZmuwe3i9H9dGehSgFS+uNNvi5/eJfZkv?=
 =?us-ascii?Q?fyvchy4TJT+vF5oJl8vKJNyRxfjDE5Wdu3zlGfdpCn4kKmBNv/PKBiSScqbh?=
 =?us-ascii?Q?x6JX5+1d8ltyOTlgP23WQzHEGpRkDjUNPvmCvZknHLzUQhC42pI2Xac/mVh7?=
 =?us-ascii?Q?Y8U354s9CZT7wQTYbQohpvuYcNEULIeY7g2WwMGcs8immrXIkt914FjbEJB4?=
 =?us-ascii?Q?yRNWIoG31WD8ChNEzcFNhPOf7TDyMR4ItnELBAbTFIF/QgQ4f7xmCpuz68y7?=
 =?us-ascii?Q?OFOWMKpNMpLLyjNI23UyCtwKFJ1/nhym6yqxIPc9Oop0Vfdsj4e5Ky3qObJq?=
 =?us-ascii?Q?mUTflCVRA3SN1g5D92OFcBZCNrpHY+QeuB3TvnBkQdbfJH+vC73fhx+rGqax?=
 =?us-ascii?Q?J2tFiwnr9TGKrHhLn4z3VJuFFCOcTGZxP+t7ikgfFaPLsVet6bG5TJ40XYR+?=
 =?us-ascii?Q?nMcnUNCxbabYvmNsCVWnys8gagcKfdpkX6uM0PE62vyvzR47+3NL31VX46kc?=
 =?us-ascii?Q?bt9h23ihZx/OitTErSYBYlPY2Qy1doEFzhrvz124Fpt9+6Kak941nwE8cJ4h?=
 =?us-ascii?Q?zKPURpxxl9O3eNkFCP8xk5P8q2/KfNLuSH1MKvHyK5Xc0X0cYkT0/FTflFex?=
 =?us-ascii?Q?OkWqcJMIAVV63PbaYQ1loTfKc9Jpnabl82WyJxqMgiIC8dThrj8TNIdfPsED?=
 =?us-ascii?Q?iaD2agjBUzw/s77VV6ZB87kqPXCCmZsAOPXX5f0EzbzifG5Zy/OlsWb4r6rL?=
 =?us-ascii?Q?ZkyadbrYYez49NiKOAnj/rxepS8GPhL4tCWquOnq9Tq0jGFLCuMvrDgSRG7/?=
 =?us-ascii?Q?hViF28kR4+XWRbFkCJvmP2QFRcdUF+ntw2QnAMNccYoVWk+b2EonJ4NH/olf?=
 =?us-ascii?Q?7Xl32erkYOTGC4RzP/pdQtq/fdnJ/juD4U66AKc15tXNoZwojvo83BPQyCXK?=
 =?us-ascii?Q?pD59tbadhaDtKXBh4deBgZz0oUHixO+QmrKsOrUPJ5yvsmqBcOI9xJiDloze?=
 =?us-ascii?Q?Z+58zdmMpaZu6fNP8Lb8pHOm5Bzp0zZKUEXn+JJip74TcFhHth0rg2ENV4Xw?=
 =?us-ascii?Q?uw836pDuDDIzkgzI4jvokAHStIVRokT7zolUVKVLDnVIziotGDoUjJW5sGpz?=
 =?us-ascii?Q?IEKO1OgYtyCsL4XISyoRVsE5C3EL5HXfot8UKxml0d+c1vSAWJC+mrwUA8J4?=
 =?us-ascii?Q?NZDWyJ55flGat68wem6CrfHfo/9E7xg=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b285195-4dac-477d-765e-08de746ca062
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:51:43.0311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlQoem5/vJby2bvyRKct1kFpEuGiwQWV6kr0y2qj3qtUdSK4gEm3DVCfO1qL1aD9uICpW0uxxa8kTSe8AqC12i8ncvPiKc+xOzZbot+J0L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5206
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-78368-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: D1B5A197A61
X-Rspamd-Action: no action

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/cover.1772022373.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 8e8a76a44ff0..7f4a51b832ef 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1362,13 +1362,14 @@ static struct flags {
 	{ NFSEXP_ASYNC, {"async", "sync"}},
 	{ NFSEXP_GATHERED_WRITES, {"wdelay", "no_wdelay"}},
 	{ NFSEXP_NOREADDIRPLUS, {"nordirplus", ""}},
+	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
+	{ NFSEXP_SIGN_FH, {"sign_fh", ""}},
 	{ NFSEXP_NOHIDE, {"nohide", ""}},
-	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_NOSUBTREECHECK, {"no_subtree_check", ""}},
 	{ NFSEXP_NOAUTHNLM, {"insecure_locks", ""}},
+	{ NFSEXP_CROSSMOUNT, {"crossmnt", ""}},
 	{ NFSEXP_V4ROOT, {"v4root", ""}},
 	{ NFSEXP_PNFS, {"pnfs", ""}},
-	{ NFSEXP_SECURITY_LABEL, {"security_label", ""}},
 	{ 0, {"", ""}}
 };
 
diff --git a/include/uapi/linux/nfsd/export.h b/include/uapi/linux/nfsd/export.h
index a73ca3703abb..de647cf166c3 100644
--- a/include/uapi/linux/nfsd/export.h
+++ b/include/uapi/linux/nfsd/export.h
@@ -34,7 +34,7 @@
 #define NFSEXP_GATHERED_WRITES	0x0020
 #define NFSEXP_NOREADDIRPLUS    0x0040
 #define NFSEXP_SECURITY_LABEL	0x0080
-/* 0x100 currently unused */
+#define NFSEXP_SIGN_FH		0x0100
 #define NFSEXP_NOHIDE		0x0200
 #define NFSEXP_NOSUBTREECHECK	0x0400
 #define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests - just trust */
@@ -55,7 +55,7 @@
 #define NFSEXP_PNFS		0x20000
 
 /* All flags that we claim to support.  (Note we don't support NOACL.) */
-#define NFSEXP_ALLFLAGS		0x3FEFF
+#define NFSEXP_ALLFLAGS		0x3FFFF
 
 /* The flags that may vary depending on security flavor: */
 #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
-- 
2.53.0


