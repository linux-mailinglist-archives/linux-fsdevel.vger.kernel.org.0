Return-Path: <linux-fsdevel+bounces-78365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DPrFtLvnmnqXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:49:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDF197991
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B8F53040035
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33113A9D83;
	Wed, 25 Feb 2026 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="NfuHBljp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023103.outbound.protection.outlook.com [40.93.201.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A663ACF1D;
	Wed, 25 Feb 2026 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023740; cv=fail; b=IcoZZbmtH1GdJd/sFTXDSQlby70bsiLwqqGX+MR6dxZ0uGLZ7laid15Fkf4xmtyCSLc6jn5HYY8oL/ILKnYNIZG4GW8YIurDAU+GLSE+2LdvhzzK8nexaKe4omMNWPz61BaELWli+j1gow2PI8usedfnxaWxLWO59Fg3HYx6QVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023740; c=relaxed/simple;
	bh=IBoi+vMj5+ZGPtz1OJgmGb7SmIgBxrK3TvWyXgqWggw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c+r/jt1Wassfjk6iJLIA5puzPpQS4wrw8dO5315oAMxQChNE7uNqb/KerqyLTq4rqJUo3XulXEUFQCw0dqrAdTT1brolYGIY9BN7XCgII+xmP6lyn80lTBGEUkZeIT+mrbKJhyuEQIx8VjxHluZKI/jbvNEkBnbfyIpPeBbJR2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=NfuHBljp; arc=fail smtp.client-ip=40.93.201.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJzRJBX2WgEQ+M/OaIUQHv2PhTRA/UK1n+TZpA97nQ5yrGMcql6JeIP3SuLieEePTFypWnFzfGz+V6uZZMWn0iCKWyCAufkDRvFIWrw0dK8UbUS4UdH5ksxRJfXr5O7e681rFCeU9BIGZgdctJIfQK6KuH222qh0lgvJnALTk074pnM1WCv+WOuB8PDeA6Ux7kW+7+eiGfLO49YWsTbdBpye77BcGaVfKHbbhu01Hi6vccuPOJTpIinBkdrxxzi/4lX5iNRFR4x1KnlTRZcJEn9R8JldGELlPMOy7JWHjQRQvGTTPz8mZzBwhNkNRGsjCO1QGvoVfE0S/bK0+fGQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhKNKiXaqlaWr8BJEf8/1Hc/a81odR55FFXEwebrcJA=;
 b=iph7iuVy59YjQa9lMX0MWGnqVP2pmlg8FlTwlMvb5RplH7fyGR9NGhPZCSn7XqBzX9aXIJrEnggNEe+6e2pCOSK8AeibouB4pu6Ucz681kMw03q0C6qg9+bcfZXzp9yjlg+6CTn3meLeZAzMU06HPdKnUVXeMtOIiE1hbez0cKvNsWRz/qTmzZd2/lZnSnhFYx9n3Zs5g5EmP+3/gAOQSzEFZT0C2UF/YmTuuUF4+hHrYnuu/gqK7UofAOiOrtMkV6aBo4mhYUMki0Vj1nKA/cLHH810RLyO4enBWVuZ9O7+rJYo5iwFDk+2x68XVhFYBdiE45sW67emf1VOJP7A6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhKNKiXaqlaWr8BJEf8/1Hc/a81odR55FFXEwebrcJA=;
 b=NfuHBljpN5yKktEyyzAxvNX6nS8qSx2VnFF9r/vwTslqnvfch2ISy0yM5XzgggbQQrYX5m54osKk5sZnRAql7VjO6JJm04YP9UEcah3i4zbBvzq5WjH2bTdOSVxqWizt6zekfH4U19wRaZ76aYidZ2Uy2Ia0z0RKWudXEbuw2YQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5206.namprd13.prod.outlook.com (2603:10b6:8:1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 12:48:52 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:48:52 +0000
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
Subject: [PATCH v6 3/3] NFSD: Sign filehandles
Date: Wed, 25 Feb 2026 07:48:46 -0500
Message-ID: <43379d1283567245c97a38eb00dfe79f9796df93.1770873427.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3d41c8f-d207-44bc-a894-08de746c3a7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	dPZlqQpoe4tRqPPrskTa9nE6ajmV1ZUiZPLJXbs97T1d4jmUQKEk2HETSA4aQGSgXLub5fJAx3TlxZnbRk5U2TTZTfD964kDqK+3jn4ENThtRcZqNWTh6v6Ujsf3q7uATAOwpUb8xe4vLLNq+sAeXxMOiI0nn5RvEv5Dokh9v3C00DebP73Tr1bJGbrOZRpijopfrNM7Ywq0v8rEsmlW4i4A4tTJ8z7sOMiqu9r7dY3p/PEemjikT4HhEe63pPEP/mZSUgMKXMkE6vsOQBLZ7YEmb4nGgeSycE6zeTRJF4pN3nt4FD1wSW8U+OMBSEjErCcDjbmOrYGfd56Z4zzXSHGL0RCjmKb4TmhjbY3bzXKNxTAVof10V/QWXy70g0dNQiS35WU4LeumaXi2sYCH2bY365GW7h+IbAlEEZ3fesIMq/bidPZeqtWi04g7hezQqErEXYdQyaqvSziAv75DFQOXb9ICRpKq+uQx68cXUi6GwJtEjw4TwKhzygi18JraqczmwilBXzQS/JQJwIKakO9KgmLcPkoHzfKxxS5iLzbLboto0RMZpr74suZqUAchqxaYNbpqA2NdYg26+1v7QdQ/N7Ll9ylCbM1p969N+dfp/CibumjaxU51rgqORIe8UVLUy7mAIhVhDXpB/XrPGNizzrCkcp9bPFmwaMypb56KCyQFFzSIafaf7iFfIgCD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sjRM7i0wJxLAXso5smU/ol8R5GinZ5aK0ldOROAr009ay3mRnp5uyMeBu2Yu?=
 =?us-ascii?Q?PgcxOTKMyjQ8epYxYoag4vu9qr2RwU1leEVitjOreVy7Zq0lY+bT9DN2Zevp?=
 =?us-ascii?Q?SahUFsOIDKo+agkRKRuQ18t7sD4c9uH8j78/11jXn5P2SR/YPdsMLEoZPJRS?=
 =?us-ascii?Q?vHtutEz1IAHd5YNQMMufvqWrEIPkDW5aexU/0dF2yfwncHZZlAcbpvy5CU+B?=
 =?us-ascii?Q?Iknc2eQ+Xj6yUKLM7Ba+JHSDJikmXu6NJEGeFIN25b5Zp5lSd8LztBb7ZJMd?=
 =?us-ascii?Q?Ny4m5aPrLmo+uFO9kv0qTbXYeuFtnHU9Rh8CE7XPG6gTLoA3jUukCo3jML9B?=
 =?us-ascii?Q?WBhfWaCpZSHtpW2rPIkkkt01c9l7AkIwca4+EysNezGWcfHJI89CjTVpFBmO?=
 =?us-ascii?Q?rR1mmqhcKV68WM8PUjrSA8atIa4BytzK+dmYt5ZBvFGvgVoowevNxUN3KYC5?=
 =?us-ascii?Q?BEjdstOyK5wksSnQ96337shO7qXQHz9ehpbVa17ac5vq+yAQLoajGevlLi8A?=
 =?us-ascii?Q?Cxkk+qJ5jPExCiSW9lQ27Z4ZP20d0C9PvrV3WZdBsfkNe2MYnZyidj64T67Q?=
 =?us-ascii?Q?hqxXockh75MpV0jcYK6fCEnR0bpZieF6TrPYT592fycOCNhkK2Dv1M0NzWGs?=
 =?us-ascii?Q?zS6G/TJ43WC2nhG9NteilvIyXJVZnKaBQXLh7ydpZJFV1CLsSl3EFyiNO2TK?=
 =?us-ascii?Q?EF7G/c0W3PCo+c1oryJIUugS35+CQJK1UKZMGyZAh2OrxSW3neREQhtx5g19?=
 =?us-ascii?Q?1kKCsGlru2TWGm+6fpwXy01yD8at26m2OInEx/UG9md1nirdsxyFdIc/I0Lr?=
 =?us-ascii?Q?NQP+WEiqKLk13g57PwW0Qv7Gxa9yLuO7ho4HWmnGogmPlTkm95WhJt66xA9h?=
 =?us-ascii?Q?j0vs3DdBrv7ZjSKef35rRwxR2YDtBPs/lUIpnA1+vm69h20mfYudorkNMEeK?=
 =?us-ascii?Q?IrC5z2y3zz8yE3YzhAPi+ilLLeTj3+FbrkICNLX8e6lNqvT0Bu81otTL82td?=
 =?us-ascii?Q?m533hZDdkxd0AxU0Gzg5AtIH9/cmWHwjsA5BhGobNLFkjxK4vAVw0ciVs31R?=
 =?us-ascii?Q?4Qj13CZ7zgSRmu+9eqfLftA4UrclK22KTd55OTpwww2fbCWMB7YvxAFTi9Z8?=
 =?us-ascii?Q?hCsJ6jMZmr4u4CNXDCdh+kGMtj2jIivk4x8lQh05LClZA1C+h7eYI5iD2/G2?=
 =?us-ascii?Q?uMXTcQ5t5Tkri+1ZLOGfzo0VrALHIx+pke9Zfh1IZAHntqcmyUK38gilkdKO?=
 =?us-ascii?Q?JoqJ3fFuMn+42k6i//csDGOyom0emMQ+G5eNRIjVOMxhnkigeER2gqPEDRRk?=
 =?us-ascii?Q?ABAlAYOLIegBVw8a1qit9X06agu8PL4yqIHhDIOyMO08iHLDaVefB+IJ/Gu9?=
 =?us-ascii?Q?msucLgJRZvpXketRPItDYhPwlTqYFCZ1HeNPZLEwN+N1K3Jzp/FdGsPFkKhm?=
 =?us-ascii?Q?awyvRFZucLIArFDrrD3urWU3ufeo9HHniqnqGXWe8BYBNa0UJ9RHp0yoRZvO?=
 =?us-ascii?Q?ZMlVcfWulODSG3RlyZhVO2S7ziiJf2r0N78MJlNxJF+UOlS4XcLO0lFAZi7S?=
 =?us-ascii?Q?1vkqMiYeOx0ictqg/0j/Va9stS9+LOHjrVAxSQ63SyHqs/lS2iJP/6vlvQqN?=
 =?us-ascii?Q?PAsRTb2C9DfTOfmMdWAlwbEDZe9f/y0U3ksccPxIrC285rHUIsYw7OI+kxnN?=
 =?us-ascii?Q?mhJIg4rWDBUkTIPIa2bSItenB0Ko/JzhzQTyIbxSfOmEvQrrO5/XqBr4StP7?=
 =?us-ascii?Q?Tv3lJq1bztezXppDlXBEC2aju+KgwAY=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d41c8f-d207-44bc-a894-08de746c3a7f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:48:52.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKfh/Ad4mx4qO+A7iUid9ju/MsBNHmgAv1ebDn5EKzDZL9/5boaXvFDvo+lvP14hO1FkgykU3GnYY/+kyojNsMh7yDbKqQ/TXi0YdfS5q0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5206
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,none];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-78365-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,yp.to:url]
X-Rspamd-Queue-Id: C7FDF197991
X-Rspamd-Action: no action

NFS clients may bypass restrictive directory permissions by using
open_by_handle() (or other available OS system call) to guess the
filehandles for files below that directory.

In order to harden knfsd servers against this attack, create a method to
sign and verify filehandles using SipHash-2-4 as a MAC (Message
Authentication Code).  According to
https://cr.yp.to/siphash/siphash-20120918.pdf, SipHash can be used as a
MAC, and our use of SipHash-2-4 provides a low 1 in 2^64 chance of forgery.

Filehandles that have been signed cannot be tampered with, nor can
clients reasonably guess correct filehandles and hashes that may exist in
parts of the filesystem they cannot access due to directory permissions.

Append the 8 byte SipHash to encoded filehandles for exports that have set
the "sign_fh" export option.  Filehandles received from clients are
verified by comparing the appended hash to the expected hash.  If the MAC
does not match the server responds with NFS error _STALE.  If unsigned
filehandles are received for an export with "sign_fh" they are rejected
with NFS error _STALE.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/nfs/exporting.rst | 85 +++++++++++++++++++++
 fs/nfsd/nfsfh.c                             | 75 +++++++++++++++++-
 fs/nfsd/trace.h                             |  1 +
 3 files changed, 157 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index de64d2d002a2..54343f4cc4fd 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -238,3 +238,88 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
+
+Signed Filehandles
+------------------
+
+To protect against filehandle guessing attacks, the Linux NFS server can be
+configured to sign filehandles with a Message Authentication Code (MAC).
+
+Standard NFS filehandles are often predictable. If an attacker can guess
+a valid filehandle for a file they do not have permission to access via
+directory traversal, they may be able to bypass path-based permissions
+(though they still remain subject to inode-level permissions).
+
+Signed filehandles prevent this by appending a MAC to the filehandle
+before it is sent to the client. Upon receiving a filehandle back from a
+client, the server re-calculates the MAC using its internal key and
+verifies it against the one provided. If the signatures do not match,
+the server treats the filehandle as invalid (returning NFS[34]ERR_STALE).
+
+Note that signing filehandles provides integrity and authenticity but
+not confidentiality. The contents of the filehandle remain visible to
+the client; they simply cannot be forged or modified.
+
+Configuration
+~~~~~~~~~~~~~
+
+To enable signed filehandles, the administrator must provide a signing
+key to the kernel and enable the "sign_fh" export option.
+
+1. Providing a Key
+   The signing key is managed via the nfsd netlink interface. This key
+   is per-network-namespace and must be set before any exports using
+   "sign_fh" become active.
+
+2. Export Options
+   The feature is controlled on a per-export basis in /etc/exports:
+
+   sign_fh
+     Enables signing for all filehandles generated under this export.
+
+   no_sign_fh
+     (Default) Disables signing.
+
+Key Management and Rotation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The security of this mechanism relies entirely on the secrecy of the
+signing key.
+
+Initial Setup:
+  The key should be generated using a high-quality random source and
+  loaded early in the boot process or during the nfs-server startup
+  sequence.
+
+Changing Keys:
+  If a key is changed while clients have active mounts, existing
+  filehandles held by those clients will become invalid, resulting in
+  "Stale file handle" errors on the client side.
+
+Safe Rotation:
+  Currently, there is no mechanism for "graceful" key rotation
+  (maintaining multiple valid keys). Changing the key is an atomic
+  operation that immediately invalidates all previous signatures.
+
+Transitioning Exports
+~~~~~~~~~~~~~~~~~~~~~
+
+When adding or removing the "sign_fh" flag from an active export, the
+following behaviors should be expected:
+
++-------------------+---------------------------------------------------+
+| Change            | Result for Existing Clients                       |
++===================+===================================================+
+| Adding sign_fh    | Clients holding unsigned filehandles will find    |
+|                   | them rejected, as the server now expects a        |
+|                   | signature.                                        |
++-------------------+---------------------------------------------------+
+| Removing sign_fh  | Clients holding signed filehandles will find them |
+|                   | rejected, as the server now expects the           |
+|                   | filehandle to end at its traditional boundary     |
+|                   | without a MAC.                                    |
++-------------------+---------------------------------------------------+
+
+Because filehandles are often cached persistently by clients, adding or
+removing this option should generally be done during a scheduled maintenance
+window involving a NFS client unmount/remount.
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 68b629fbaaeb..36e32c3d2920 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/utils.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -140,6 +141,59 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+/*
+ * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
+ */
+#define FH_MAC_WORDS sizeof(__le64)/4
+static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
+		return true;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
+		return false;
+	}
+
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
+		pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
+			" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
+		return false;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+
+	return true;
+}
+
+/*
+ * Verify that the filehandle's MAC was hashed from this filehandle
+ * given the server's fh_key:
+ */
+static bool fh_verify_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!fh_key) {
+		pr_warn_ratelimited("NFSD: unable to verify signed filehandles, fh_key not set.\n");
+		return false;
+	}
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size - sizeof(hash),  fh_key));
+	return crypto_memneq(&fh->fh_raw[fh->fh_size - sizeof(hash)],
+					&hash, sizeof(hash)) == 0;
+}
+
 /*
  * Use the given filehandle to look up the corresponding export and
  * dentry.  On success, the results are used to set fh_export and
@@ -236,13 +290,21 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 	/*
 	 * Look up the dentry using the NFS file handle.
 	 */
-	error = nfserr_badhandle;
-
 	fileid_type = fh->fh_fileid_type;
+	error = nfserr_stale;
 
-	if (fileid_type == FILEID_ROOT)
+	if (fileid_type == FILEID_ROOT) {
+		/* We don't sign or verify the root, no per-file identity */
 		dentry = dget(exp->ex_path.dentry);
-	else {
+	} else {
+		if (exp->ex_flags & NFSEXP_SIGN_FH) {
+			if (!fh_verify_mac(fhp, net)) {
+				trace_nfsd_set_fh_dentry_badmac(rqstp, fhp, -ESTALE);
+				goto out;
+			}
+			data_left -= FH_MAC_WORDS;
+		}
+
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
@@ -258,6 +320,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			}
 		}
 	}
+
+	error = nfserr_badhandle;
 	if (dentry == NULL)
 		goto out;
 	if (IS_ERR(dentry)) {
@@ -498,6 +562,9 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (!fh_append_mac(fhp, exp->cd->net))
+			fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
 	}
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 185a998996a0..5ad38f50836d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -373,6 +373,7 @@ DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
 
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
+DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badmac);
 
 TRACE_EVENT(nfsd_exp_find_key,
 	TP_PROTO(const struct svc_expkey *key,
-- 
2.50.1


