Return-Path: <linux-fsdevel+bounces-78369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJYtOavwnmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:52:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC74197A78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAD3D3089781
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C603ACF0B;
	Wed, 25 Feb 2026 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="QqsAAdDp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021109.outbound.protection.outlook.com [52.101.62.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37573B5319;
	Wed, 25 Feb 2026 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023910; cv=fail; b=rBtX+KwKPadg2DWxuRASRFKOR/+ZTN8nX8wnuFyZqmN05uawZGkYeMg7WFSkUZ8on+gA+0qmYp9V15O8j9i1yQWjMlKbtlb1bmgyWqL/RR9NpgmeDE0YeHPZOsSEHU6HgnE9kI7gfXY4mH35T7chFklvCAghgJhUdr4lNMYanoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023910; c=relaxed/simple;
	bh=IWbGI5Q/2ty2avfPjROoG2mnqpEXfLHykhW1EeQHwY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QA82kEaesQ5ZmL62qdg3UgQ93DIUQ4i7nDjYtKx/4AgPWN5/U/Ain4lydrhuh3KIyQBxp5RjvgHc9bulFpDYSoMTfFHX8E6+rGtGPWxZz8eVg3lgR9VTsufbOYNOxaEzPsDjEH+uxJBpoR2yfC7qpgl2ClV0I92h0e1dlsbQlOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=QqsAAdDp; arc=fail smtp.client-ip=52.101.62.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SctXB4IFDr09K+iTGFQGFrfoiKE8PxK2CWevmdaN4EYpYS/8QE/BKFnHM5ODyLsCO0YdGW6EMVURcdRfBMkgGRCW9J0K5EeVG3ppVpwvC3JntWJxSBDvkzj4mJMQ/zby1QcPZPcIbORiAaqOFcm7vbECxXufLcmHiM5XLzDn4Zp0qTOUvV2Wf9/8JOdsbDv1imstlLAibVKKdQZ1O4l8U6pGB0gYka4bXpBrAD1hRskxlXpyRcYg4VrcyXH6VED/vzfb4xUlOaelihoZEPXX20b1qCeEMw/1hKtNedKqP/aVolaoM8xGIkD9fCzJnTDG6aAIr//gDHsaGlaITz0eVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZFaY1XFEbUOml+OQLoJ53cILU7uaFVqB+13q7jOQPo=;
 b=Pzw9BbzBOH8os6P5M6GF/A4C62/0sFbBiO7mHW7zW1z9dytIgVao3y4jdOCuL0h82p2ms2wP8DWUDwkFN8mslVup8rV/b5jxs8JL3mHkRbEjG7j7Jp1fF6ADmPEf7cu+wWCLUGPHmLKNmQLzjrdMaatGhTlFi4lrGA+SjQWhUtgTZhjU1txmOzC27eDzE9nymLXevt774NHVXAyPZlVIRfOlRuyTHqUIkrQWSv8ySZXieeO32vb4Wj/Vsbtm2P92KsjzBgCVa2UHUfvD77OzjjuYqkYvWxjpSMeJHpigElhib2vR8y85ZqR6U0WNjpaYlte9IQO4QL1c0OUjVzk43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZFaY1XFEbUOml+OQLoJ53cILU7uaFVqB+13q7jOQPo=;
 b=QqsAAdDpp8gWDTQR03wq6ZGLv6pXW2EpRkDsYeaoOaWXPGENasp0anotbv7WAlfLEEN8QqE5XwedRosU/+aV1o7XeC5ne8x+21t939FxaPAv47MrVs4TqlaHBWA3wiVJJISPWrb6/Woc7m1a+rYsHgvFEmlaPR950RfXuwf6H7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5206.namprd13.prod.outlook.com (2603:10b6:8:1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 12:51:44 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:51:44 +0000
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
Subject: [PATCH v7 3/3] NFSD: Sign filehandles
Date: Wed, 25 Feb 2026 07:51:38 -0500
Message-ID: <522524c4b87f7366f6c090c9eb677e88326440b7.1772022373.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c70c3ce-6c58-4e31-e4f2-08de746ca0ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	9YJdXoYZ+5rj+U9/dFGb5/866hzIB7zG/Afu7PgMFHYxKNdWXipbAuiI7Ggcle8zM5j5EhrcGPFcY99wCpIaCWkSBmajIsh62YOZtNmOrl+Q/2zNuwVVwbB7L7nX33g6ztSfRDv7A46x8YYnSy1TUXd51J7Wh0zpt3xNRUEJlaPRkLyGpL2kA4ylhUreiqKn8D58n7T3R499wE1v5HPGLqH1TmqCIsefnLZhuQk6f+G2aC74//AyXQtORW2KEpiahxA0xzmx6daVSQ+WuV3O+mKZeUcqpViHZC/y1YqTJDO7fgEQxrCwzC0XT216vCLmQJFho81NX0REMptkOfwl3nkyxkGsEaFgNPj2jw3s4m7+ti+3+9Vboh9D2EgUfvvfn3New6VlzcyoIGIPEq2aTByU9zdJcUNRCq1MYU8J/SvTeLYfr7Rgnd2MURK3s2NeyFh+mLYtwC32FmvwcMe0tHt7CMDZGz9wDqTlK1rWpWIVP/NNN5TR9CrJSafwIv4v3V3HnEoPeD2yT3sm8hdTJQkcMLJmIzXeahWVW8sPKvKjaRxNS3q/xnzUHWN4rsxF/2WPgGzakHYX/5ZsMEBi4xhCHSVeePuRifdE08ZakMz6ZEfbydDPVuYJ1Pbxn+S8yP1EdmDu0JxykycrLgqdZpH6nAQV3GucPyNJF98tzU9IvcMIrNFgZXjLIhw2X38T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hw7m2f24jHpC2WppKc3XsWLJLHoMs6BvwT8W3AgCbWEI775wNMlrtXOq4d5g?=
 =?us-ascii?Q?z7ErRwgYlMfJSy7sIPVYpNMnW07QwJ2x+fRyYlvDFf1pnFOlc4PUn8/RFAdt?=
 =?us-ascii?Q?MewjVY0AaxBDx0z9CDqnaGwhQt1YyM7GXfv0ZuEJDrdVEPfpNwGpm+DBPcCB?=
 =?us-ascii?Q?rqe4CBca0UKiq1eYUjBtyGMsCXdIG/XULSQLSzN5rLyBBqnODtREdZp6TsUL?=
 =?us-ascii?Q?rOKy3dRISxgb4Ges/gHNdHnqKxQiOUid2uBHfW06z2BkLRkofjbeKkkZZ0wq?=
 =?us-ascii?Q?4nuLR1MSaKOapOxkSFrWE9GSs0ICPR/2OviLwBDkCeRyiy6by8eFebkSuDzn?=
 =?us-ascii?Q?C+nft4z2nxrB6MVCM+rNRyTssr0MH2u/p/FeG9gXVmC5Q27hNy3JSLFm4s8b?=
 =?us-ascii?Q?Wf6ofInTBCaigvKUR6WB3C+MPhkF4BUTmG7p0x/9neTUBCr7a04i+P1UttCf?=
 =?us-ascii?Q?wiaWxk8HOKbjSw9X7R7BZSn71heM/aKo2tlO7e7+VjiA4IG7pfDrkUZ8HRoF?=
 =?us-ascii?Q?+mSYYbd/LUydrCnUcxe3Qjozy2adJQvgebt7GmNS9jYrToG8fOmTgpC8/ViU?=
 =?us-ascii?Q?pIboXczA7O9lYj7oY5tRXJEk4GWTNLwSU/Ps2HiixfBdaSvekC30hIu3uNg6?=
 =?us-ascii?Q?ryNepz5YHi0hYoTQ1Cy5O3zkdWKMYiYY32WC345kiWxQNAI9M8QEgSXeWo3i?=
 =?us-ascii?Q?KyLsL2lVxlUijrMAxPXkZoY4N+DaA+kg4gFVpERq/NiBsP+U0+txHC+W2UCf?=
 =?us-ascii?Q?e4r2mMq+Smijz84w7edeL9R8SiBBKenwQn7PRNuMeMUAGbXi3RU7bX/Gq9Wg?=
 =?us-ascii?Q?kHh0q3ukuszuqISp/jAmBCIUVU9HzLxusACxIJYHxDHFLki6nc56BWR+eMbV?=
 =?us-ascii?Q?qvn1x8E8L6oTbAEZenFnoOtf612MKSDnROxkn9BbBukuJacX7McekDyUZliU?=
 =?us-ascii?Q?C4BCMxWm2ezR3GZgrdvlMRbJ5lyoQ76U9hW2jZGTJjOVRTHlzBFAdfgmc/CI?=
 =?us-ascii?Q?eKZ4CuGg7PvoKwxy/LUsZEBU1OFE4lJksH9iRoKgt5lJWzoJa7aiMzFclMj5?=
 =?us-ascii?Q?Gu0K17BJbnbAlEhDopq+7ulRtEHErT5Pcp9Wko7IL1bqr6DkKgfb34mR3Zij?=
 =?us-ascii?Q?ZKSdXtPZy/haNN30b8Kr1GbAnrw2+jYu7esQrd59lD51pw8A+9BFrMKNKa6Q?=
 =?us-ascii?Q?t1Mhnn4jhw5q4qaEXvWgtfBpgiW+nnpYCVu1hDa1TOfSnPdo16qt8VTYd1cS?=
 =?us-ascii?Q?etBDEQ4EV1wAm5w9v2msQKzSFMhDLpB4urxQ2ksfm1JpsbGEo8cU+tm4I1RT?=
 =?us-ascii?Q?96s+4aJF3HGr71Yaej4VK9RZIzR2u16L3s6YcOQzvnk73WffmGNUYQs7j7zh?=
 =?us-ascii?Q?PcIuKx+gPNRdgMnankZPl/DdPFXNJvQajsIuOAPjpieuBsXB2ZUkrVDplNkE?=
 =?us-ascii?Q?E0eL/5FHgtjadqXJtWC76+q6Eqc0l8vZ9kWZgg4e/E7z2CnJXp29x+CDFcwO?=
 =?us-ascii?Q?KRhcr/tM7fkWz4md3tQFhzBkqdxdHXiMZ8kynJfmJw4vpI0YOHOawebhaatv?=
 =?us-ascii?Q?7I7vgLHnm1y8x4eXZcyotGEEyB2EfZb2p8Dh4dEqNFAvJKPlLMqikZaS3zj0?=
 =?us-ascii?Q?5+LoAH6pz6bJREhrmVeM9vkaCpbtMb3GqInd///3iaUN7ux5vDwZVk4D0u4+?=
 =?us-ascii?Q?WSDk36Lhh/WewR4xQ8RPLTv3lRcByr2lqI8oBxrJQ54+HTlfVksygCnnou1r?=
 =?us-ascii?Q?BU4LS+sxYUoKPZDYrqqn7yhuCfQnQaU=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c70c3ce-6c58-4e31-e4f2-08de746ca0ee
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:51:43.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDKG0NA6I8QpiHFh8l7ChRptOfAfHFp//nc6Q1DJIsOlV1CotK1jh8qCQWefCqqRoRWPoPykMrJLr29B/GUb5k5vhJ6r6FE/Vrb8K1G1nyI=
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
	TAGGED_FROM(0.00)[bounces-78369-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yp.to:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: 4EC74197A78
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
 fs/nfsd/Kconfig                             |  2 +-
 fs/nfsd/nfsfh.c                             | 74 +++++++++++++++++-
 fs/nfsd/trace.h                             |  1 +
 4 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index a01d9b9b5bc3..4aa59b0bf253 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -206,3 +206,88 @@ following flags are defined:
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
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index fc0e87eaa257..ffb76761d6a8 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -7,6 +7,7 @@ config NFSD
 	select CRC32
 	select CRYPTO_LIB_MD5 if NFSD_LEGACY_CLIENT_TRACKING
 	select CRYPTO_LIB_SHA256 if NFSD_V4
+	select CRYPTO # required by RPCSEC_GSS_KRB5 and signed filehandles
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
@@ -78,7 +79,6 @@ config NFSD_V4
 	depends on NFSD && PROC_FS
 	select FS_POSIX_ACL
 	select RPCSEC_GSS_KRB5
-	select CRYPTO # required by RPCSEC_GSS_KRB5
 	select GRACE_PERIOD
 	select NFS_V4_2_SSC_HELPER if NFS_V4_2
 	help
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 68b629fbaaeb..bce8784aa92e 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <crypto/utils.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -140,6 +141,57 @@ static inline __be32 check_pseudo_root(struct dentry *dentry,
 	return nfs_ok;
 }
 
+/* Size of a file handle MAC, in 4-octet words */
+#define FH_MAC_WORDS (sizeof(__le64) / 4)
+
+static bool fh_append_mac(struct svc_fh *fhp, struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct knfsd_fh *fh = &fhp->fh_handle;
+	siphash_key_t *fh_key = nn->fh_key;
+	__le64 hash;
+
+	if (!fh_key)
+		goto out_no_key;
+	if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize)
+		goto out_no_space;
+
+	hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
+	memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
+	fh->fh_size += sizeof(hash);
+	return true;
+
+out_no_key:
+	pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
+	return false;
+
+out_no_space:
+	pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %zu would be greater than fh_maxsize %d.\n",
+			    fh->fh_size + sizeof(hash), fhp->fh_maxsize);
+	return false;
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
@@ -236,13 +288,21 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
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
@@ -258,6 +318,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct net *net,
 			}
 		}
 	}
+
+	error = nfserr_badhandle;
 	if (dentry == NULL)
 		goto out;
 	if (IS_ERR(dentry)) {
@@ -498,6 +560,10 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		fhp->fh_handle.fh_fileid_type =
 			fileid_type > 0 ? fileid_type : FILEID_INVALID;
 		fhp->fh_handle.fh_size += maxsize * 4;
+
+		if (exp->ex_flags & NFSEXP_SIGN_FH)
+			if (!fh_append_mac(fhp, exp->cd->net))
+				fhp->fh_handle.fh_fileid_type = FILEID_INVALID;
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
2.53.0


