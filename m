Return-Path: <linux-fsdevel+bounces-78364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFmSGxDwnmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:50:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0DF1979CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23FF30B8E41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186153AE718;
	Wed, 25 Feb 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="eu+/fcZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023103.outbound.protection.outlook.com [40.93.201.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C4395260;
	Wed, 25 Feb 2026 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023738; cv=fail; b=SnCpFQG8JFVgNvPehjubAmTUz5N+Fm52P9RJcT3BKQnl94sRatDyRiw6EDXYJDbMPebChkCrWhAXjhAIuhRcUVcqou2WayBB8ozlZ5KlxZODM2FyG/YELh4pl59JBgvL39HOQgAojFTkbiwqBPjguCbyApv+qvQ+3R5g0akDBiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023738; c=relaxed/simple;
	bh=uFSAJcFXhjUOxZ/oLJiBln7ZJIlDoKKDxjxgHoXPBQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R/IXfm8/6IH2woFvJCves6g1KQV68wtafIU3KUj+WS3SekM9yRJPaRQyi6cyiuI04CMVe8vrlrkJJ0+0dRfhwuea5cqm3QixZuUzwgYvYN/fOKILgrcwYuss7FURAzPjDRCzPjSova5pO3PrAYe6cQ5Ob62hJ3M4p9ya8L7LIYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=eu+/fcZw; arc=fail smtp.client-ip=40.93.201.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvAMtcdhjl09bYLMPf/Zk5cZqfwm6aBp/1h4Dmz2xUN0rxigq1Y0a6taGrVIxO+MXZuVMyEIDGPYQUDVOQ6Zl4B9rQ56LbSsflv6K4umMvvByZc5zPQjYMm6+E+OCGvesmTl6Shjv+aP1YR05GHg8SDaImT/JGNqN8aZU6FZcjncwjW17xkZvPxfCSMZ2uQu0DU8RKr88IdPJQNffvcI3YKw7mNF3c24NrmFl5azBZi61pUihA52ktaROaGv2R3YBunNWrfvNrLiKYfXCAMzfj8KUQqUC0m0FwqhzfGMBpf1aGvMNX3/tf10j+8j6JlP+Yjsz7lXuo6LRHeiYQDrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dooO3FPDJYOgTxQo+KLSLGuDRjQieYIT/VT+wyA4NSM=;
 b=vMyW4fTnIT4BILp21i7RM1ljVeq2qOZBTvA21nKhywwJ+FlZd6pSQYli4DtkM0Oep/V+Bm2ZcbEJtwILS8WrfVijW257iESkVQ+X6pV0ij7mRwJqeLtSUslA3IaqM+piqx0vybWL8tYz4MjZJIDKuXTSRYMHZwljUZl/Vc3Fr8qD4AUyMkqqru60qhcozf+WyAWCfNEMC44nXU/VklG+ul95slPvduWne42C0Pj2LAU5sZ5doqa6mZbO0DwPJlTGla6/6j6EJkgsVRsIh5U9R/nLtU87KQtw7gkf7aUNKQBA8tYxJOkTG1aN783leC9xEUAFxRdYseGKlenBVN5I6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dooO3FPDJYOgTxQo+KLSLGuDRjQieYIT/VT+wyA4NSM=;
 b=eu+/fcZw0HF7KLMh4DdSHaBq7TczaTuXq3ssREwSEBPWBcHcTMByZXNaBP3oEnOxH5EItHnwTaOcw65KK2Qto7SygIUa0WgPJnu1IfRniTkRebXVR5vSxyUHbWuiT/F9p1/Oa3S5CJAn5o/DyldXjQdRaGxxGmArTXN6G1M6kVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5206.namprd13.prod.outlook.com (2603:10b6:8:1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 12:48:51 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:48:51 +0000
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
Subject: [PATCH v6 2/3] NFSD/export: Add sign_fh export option
Date: Wed, 25 Feb 2026 07:48:45 -0500
Message-ID: <e10c9b71fe3a430d171ed184a22fa186b28894c4.1770873427.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770873427.git.bcodding@hammerspace.com>
References: <cover.1770873427.git.bcodding@hammerspace.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::13) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|DM8PR13MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 868858e7-5e18-485b-094a-08de746c39cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	M/Z0Wvw6xU0UWH2XDSlAaFa7TEfJIeGLv987/jj3v7KeeLudFad2O0YGhIcQnk/UofLF7R5CKSGM7yXDPU4mr342CLa16GAYipqLYN9AIfPmwg+vFA3uM15cksuKGgy9JOs2/VY2dambI2iEr3WbKszkAnTKiqkDzkehUgxCUtBntMsZJIdMEZcH17qKOrTZUQ2d5tGzF/SsZRZv+1QW6s+hAst9szpKxT5BmkKUrj9WH7Jz6qiVlj5r1gUurqypEH47eeJQBPeePylqJN86dj7zee1X08tOI1+i7rHfiE7K6cttdiikAJwfKcbt8hl1UE9/cmVztPOTqedDiX7YNnsNp8enL7b3kI7kt+nGKIbtxSwGL6G0mBfvWzenLfSE5YfVfJmXmEUTBzDn0uI54t5e0PtY8Xhzrlo53CE48YJC0zENkEHNj1IjcWXn27vCtJsO/JUuUsjpBOst32FKCsxw77TZcrwzZHgFHHjRArh+xExpWfCw/1RyQuQJ90sihturCa1Q7mrPgSGodzSY64VNj+TAS52NWKGBMi9XGqUEtNL7Wyji5OtlgAPxltFtPLXqRHYV0A0X3C+p2qtf/XTmdSbbWJuUWEEOV4COHnPKO77n/DisDMljku9qFyag5qT0vcCUszncRU93Ka/CWXf220EBaJwbmB+k+DYybmUHpmcCYrS3SB7u8B0i4ebTLAsJBZTTveVNt8qPybxVZ6aOYG1sPBGxqVX43y8BeH8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0NIH4PzETDfZbx/XGDSqR1I7502zH1BVj2USIF0zRP9KGa2M8L+rF8yS2BPv?=
 =?us-ascii?Q?F/Vji2Gwzp07sa4e15pa1dsfPaZEqoXa7MIrdkxJ7dcWDUVzXAkeLUMffN01?=
 =?us-ascii?Q?1NPDiMUubqrQBJxgmU3S/4cDrxxYN7/m2GIztlKKmQKsYQpyEDjzuKnu4tgl?=
 =?us-ascii?Q?5ze/v8dmkkvCw6fiBQeoxHq+MQURB9Rwe1lAbk+GDipA1DtY55+yH3RK3xpi?=
 =?us-ascii?Q?szT+SFYsNzXEypZnecHjOY6oppH7AmyaS9NuaG9jeKtGIHBCxCK/cExskd1N?=
 =?us-ascii?Q?3BTeR/p5mqMCgmq/ENMjEvmUFe2HbaV7nndehQ+am7UT2agId20pGXkVRaew?=
 =?us-ascii?Q?fo1u/Ww5a2LJjOoPJri6xcDNaxzd1sg+28vzb68i/cvD3gGytEu/KNFRSdRO?=
 =?us-ascii?Q?L+TjT7IGuYRm1X9pG5t92RJ/Ro02j9uazmtqKs0PyeUIvi1v0xN/S3YG1rfM?=
 =?us-ascii?Q?Aq2jNWq1LpQBsl2x3vwD73rTLqU6Inh4qrCcOi40og25lv+wUwcx+vCUm2vc?=
 =?us-ascii?Q?ULDYDpjJvInB6fGNFXKJ5y7ouDmPjinHdlSWX713xWT7AVjZoVVmhklg//nX?=
 =?us-ascii?Q?y8QkiVe8CjJv4FbF2n8EFeYYoc7Fh4hv6Rmauaqkitnh7dPMqjOC3ZMPy6nI?=
 =?us-ascii?Q?oBdOqNjmE5kB+ZOqyLNW14fGWGkfqc62FCP2GgUfyWEX2VPoWHA4rNVi0syx?=
 =?us-ascii?Q?8N4COrVBUbkp701aWjq4UeRXUL3kCSxLa8j55rLTLYx3+qMNyk19+shgSZy1?=
 =?us-ascii?Q?yan1laSR9504lA+cZKu0salQDIciMiT+N6G7xdOtcKFe85nj8YBBkVFE2/+f?=
 =?us-ascii?Q?DrFidwp6Fk+jP9uZ0c9LjCxWSomfoQrcL4o/PV0QdsegrFNNk9yt96ZuevoN?=
 =?us-ascii?Q?AEiCgUB/lL9AuAGGP4yIApvY9gCK+yKK44UvN/YUEq09GMSHqpW/xlv0uY4z?=
 =?us-ascii?Q?RK3rkN/8mvIo3FyBoUnuyS52RqIRuo3ofX1MukenqEq5DfJQNEAHHs1R1e+H?=
 =?us-ascii?Q?iQMLe8yBEBdjrvSHWcovDiRVLwgYaNo69HY+NDVSvchQpMVRJy1hmsjC92wu?=
 =?us-ascii?Q?HCyCI2/NfEZX0MPRLaZw5Al+vCFExSgUVwuVbKyYbzFSRYzi/FwHM9Te/n/G?=
 =?us-ascii?Q?r1nhlHPCiVoesJpz9X6BDVW1v1wHo3Mg0Ux5OukdKclsVXH2xEHztcoqWLbp?=
 =?us-ascii?Q?ETVA563MMGDk9T2+0DNgb+DUk3fsb9ONjruxK0iHRX2u981i0qMCeLK6OZxi?=
 =?us-ascii?Q?2JquxBQJHR6im7vF9U1M87zYyKLrS4m89YMS2HaNzuY0PAHnOZ2agHy3mj8L?=
 =?us-ascii?Q?tedgYP5OJDqyJggxVdOSWn4zoXfOkJ8wnnTNi1jGpH4ybkWJIsqc9oSR/9NU?=
 =?us-ascii?Q?AFHfpetIiqTf5BRKR4Wsxnv8lZKrzQdxkfoRAFulMFfUHuWM+QDSuFipCm3m?=
 =?us-ascii?Q?lYNKqoz60u0U3wZZaOYHrIdh5rP23RBorRWRdtdUGyfWDVQHUy2uwjQmJd8L?=
 =?us-ascii?Q?Y3iU0/+oX5it2us7u4ERlucD744EKUVcqScUXaPobirhUNghplSPBzaeGrUQ?=
 =?us-ascii?Q?Odctjv/bdUDGzJookh2cBN5ZxnNcu+aAPQv95AwjOIH3C8ActHC0tZm4iaRw?=
 =?us-ascii?Q?gPcsaBFPpsw/aUrCBE5SLDmgAUjGtAW5cwKzh0h/XayKXlEm1PmJwYN/Mqyx?=
 =?us-ascii?Q?lpGgmhg9gQPg42VQNp2wMV0DiAgjymDXDFnWCMYtRxTaoxBQljK+lsHD3M4g?=
 =?us-ascii?Q?+7a1baLLtcXog2Y+O1h7RQN7oo/1l4k=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868858e7-5e18-485b-094a-08de746c39cc
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:48:50.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0I8n072xxW3wcKf+aBw3YAL5ukmzkbteHZ1truxHGtzBzv8L/Sv8dw+IkQAzDVN87ZHoufK3Y0kruqiQbD96yj9G1WkGZluQmWDd1an7DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5206
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-78364-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: BA0DF1979CB
X-Rspamd-Action: no action

In order to signal that filehandles on this export should be signed, add a
"sign_fh" export option.  Filehandle signing can help the server defend
against certain filehandle guessing attacks.

Setting the "sign_fh" export option sets NFSEXP_SIGN_FH.  In a future patch
NFSD uses this signal to append a MAC onto filehandles for that export.

While we're in here, tidy a few stray expflags to more closely align to the
export flag order.

Link: https://lore.kernel.org/linux-nfs/8C67F451-980D-4739-B044-F8562B2A8B74@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c                 | 5 +++--
 include/uapi/linux/nfsd/export.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad19..19c7a91c5373 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1349,13 +1349,14 @@ static struct flags {
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
2.50.1


