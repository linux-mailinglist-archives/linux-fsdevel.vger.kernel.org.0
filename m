Return-Path: <linux-fsdevel+bounces-78363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBrQFv/vnmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:50:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC11979BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC74D30A12D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1A83A7827;
	Wed, 25 Feb 2026 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="NyVz2RTX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023103.outbound.protection.outlook.com [40.93.201.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956F23D291;
	Wed, 25 Feb 2026 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023737; cv=fail; b=emsxepCnIHG/kXY5KqXS7VYfZcDeGUw/0uVBrugmN3c9Vj883ibCHRvHvZ9KXz8NCX3nKLpH/eK+J4f/QoVJJUdjJWHE4eTZJZrDQkzVpm+BicuAz2I9z83LAuIFKAKHNm0RLPjKBVSA5sSCFpYGct1WGgDZr1b3rwkg3HRs2CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023737; c=relaxed/simple;
	bh=6OTdMCyGnlaRinr8Uo4fz6MoQ47xpMp8UPAgTLi+qi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qutGt+hSqFeyCQuiWg/jQ1a1VwgkX+vLSnu5Hx8oOXgud4U0HzhKFOXtnCsA5ucPuJiiZgXxKoVSePSsBnOFPZ5zAeNTnxq11bLIuUe0K/wZr7jtJVpXhU9sLI4+/IqaxtUxP9ocX13dKXHbu5FDE2dxccVz4Kkx0EOPvyP+5zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=NyVz2RTX; arc=fail smtp.client-ip=40.93.201.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4BXv36hCvyAD/2GXi/CqfnDlZ6UNiNF5PkfzPmJ0RBQXlqSHsYFP1ib8GZKY3luW0WcNxeD8vl8PkpQCPogJtJWllKQ8/IlG9owDXHZwgb7R+OZbVJwNqfV+Eve35HeQKh5xVX1iK35DFXxhIfnGhbxPPqUOs3Y3n2Ut1LREXr5ezM5e9ZMdsUpuGyePTKJB9lO+S0DOYpIbvhhcbaW27w6/fM7Hi0y4jko20ZurFAH1WcOab11CAdbUwF8di2YEnBspUV/D+CCl/3fd6ZMKusm1HSsF11TFzWnvVF+VhnL4BJvO57FC8qWQiyHsNLBljHNL3KeEqCm++e5dEMr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq9csyw0nqGlAp9ayeNqE0yXrBlVfEpLjl0FqqKMSNM=;
 b=JleO5wmbgqson5P9Y8Tm65CyXrOE8rVnWu6c/0grPJQjEsXWiIIhhNkcYWeZAjYa4SLHvufMB/q4yHeshEky6QvD2CkGvROk+mpd2DYj8PuL7GLNLU0VL4bIVcF94MlpvypB6cGMqqEM6PQNDWbY31kvdRHSzM39LzUgDxdk1QhlypWQkIV23xhx22rpdInWs6p2LaOowKDq3ykUsaZRgmBQZk5RrXnszvLdGUgb8OrrWmgEVXpAdle5PNVScIWSSVWwwVlk09Mbdaa+03jUo6KmV7pk/OPyeZEv9nttatQdy4wPUNyZlmSJdARke6q+qGFGDh/COpn1zUglBF9NOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq9csyw0nqGlAp9ayeNqE0yXrBlVfEpLjl0FqqKMSNM=;
 b=NyVz2RTXxeijeA2N2ui+72wGk6JY7BvEPz+6poYNFVmqry3tEgqlrjTMXgpOqwPo8/N6QC5S8uOwrUe508XfOE0VLnw4CvBktL4WzcLauWUmwGQRqdpT9kOd4gXu8WpRIHVkYTf8tisSRlH+TOvK6yVXy/mlkI3uLKrezHUvAGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5206.namprd13.prod.outlook.com (2603:10b6:8:1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 12:48:50 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:48:49 +0000
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
Subject: [PATCH v6 1/3] NFSD: Add a key for signing filehandles
Date: Wed, 25 Feb 2026 07:48:44 -0500
Message-ID: <add9277af86714de8ba1b848cdc3fdf61e114b5d.1770873427.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5eb10c33-ffda-4fcd-349a-08de746c3929
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	bFIZ4DF374T/godVzIsKjbCrD8y2zu01tHaZkBec3DgkubHwc7JgNtHaX8uo9KoD09qwMbY2NopEMs9eGU9ljzGwCCOoAIN1s8An6aXk5mXci0UcjM2TKZQptgx+Ss3YJhtS0rTlqfkNavUYs3/eZ5jnu8fS4PngrpYHghnHil/vdX31V/xjceW7+NqjodNxmtllaD/kOLbYR9LNzOhQYVFWoTTH6jh1RAi9mcfybukf/TpjmOrxhc2gmsk7JLwamTcNrC/T1kh3hmQrjG3b3qq0mq3Bjlm/ZcNxegZSnheir/jv3pL/vLzZDOo6gHId6x7FGgqRzQCni6EFsW71wnwXjo2vEHeZnHESQFd6wncs0ubLlcEHYH50TQv5MuHUDYxPS6NJASKN2Zjn2iXXRlhXktnJj9VpzUE9Cq8l8ztE0j9BgEc8Lo/jtuNYNtrCsJzv8pzenKYmFYFKLhSUAvJ6O/vsqqdC8PRfEnrX7BYy0u9AZQ5FrJhhTf7NIo41sUeguwwxZk4JOPmcjqXIkchLLddd9cepgiufiHRz27JWvLmubXi00c1LfMbGTXLQOWNDkCsF2/gq8MqcmbpGNEQEqusBv3dtm8KSIaDwHZwtVq3ZUV8dO6y8yabyHXg2nrsF4TiS0sTYjdc+XJsbZe9KGS3I1iwVmKrn1h4YG3Xeo7twRkUyYIC3agVSdxjQw5mqnY1Try3eI1eWqbpXItHP/ttVWIDWsopO4KKNSJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IONt5AcJ4yva/C7OXI9BgoyQLJAa0T7Xy3x0woPe1Z74hJuxBhIjZj+1o6Xz?=
 =?us-ascii?Q?IzWQFz9OO6IMT06ob99f6Sx7DScuCcTwehzDv00cIlQJOgmnmjDI3wc0vjZR?=
 =?us-ascii?Q?wBsHTaR7X8qQbVNo/WTiCIySquE2lWozJKl94dZDDOQPke6g0WWcZ7hQkEqV?=
 =?us-ascii?Q?mnKknZBCTYN+gvN8rrjoyTWOj9tuzEMaHIhemO7ymNE8+9KIZe64lB35Mizj?=
 =?us-ascii?Q?lkwTV2vvB3UK1o71RvDrwJM53InqTMjPPx3J9476L54/oRF4axkEtzv9RPxU?=
 =?us-ascii?Q?LU4s4yXkbajzt76ynD+mXMUZWx8Qr891vONcTPRU6PlO2K7FCqTmqFj4WU8Z?=
 =?us-ascii?Q?ZgP6YG2tgvXKEtm8wRzjMQgVZMIDoTnMaiSvHBxnLCW65ZPMhw2pvMXHf1gq?=
 =?us-ascii?Q?1FkiCzA8QCgQsDxhIJspEzY1bqP3/JWn7XYpEbt+KLwnNiV94zzKicMzOwLj?=
 =?us-ascii?Q?klAjQdirv/gufMpuvbbS4+oDRp4nA6/RZH6kPtfzotXjzOfvOZ7lYztl89B2?=
 =?us-ascii?Q?riOTBADWurjc28bzRbn+aanBaBWdV0jzMZor8lZJL9kmUdx++Esfl6IRz9ff?=
 =?us-ascii?Q?WlU8DFvqAdWlGRtKnMXUwzBUZJETp41D8TwXxNPRiKJGEpIoOX4j9bamHqgR?=
 =?us-ascii?Q?CrV7IZjupn26wMFDbFR8j1In/YxAgUcTfYbW9BimL1DGNxZsx5AnwakB4BdF?=
 =?us-ascii?Q?xY6iXPEaQeq1Me1CDm+6Zgvjs1cTvA1JCJUrZEeqXQ7TJBczootJEk7OLQ9W?=
 =?us-ascii?Q?2Ds8L8r30YJjM2ydqXJlsLmuAztQjWXWjEFP5V4rxWe+ZSm1627dhbRNcfg8?=
 =?us-ascii?Q?XCMrnuix8z7fwbyiVIQbGZGBvJdMVTY9uGknbnzQgkJhVOanJrnrGEEXcUY1?=
 =?us-ascii?Q?mO42vELLiE+Y34eM8UiRnq0+lIGw2sHDaaV5oPAVM4Hdl+9l2r1Vl2tG18sv?=
 =?us-ascii?Q?Uf9cvmKgfsC/JsymYsY8f6wBQ+tcsE3aGEoplOFvjyK6RjoRRAFTQlDezSX5?=
 =?us-ascii?Q?0Ru17sMtKo2gA/u5UGpHX8KkU8aO8+jIAxgYPqH+Dw/yzPnhSEinl/q94mKB?=
 =?us-ascii?Q?nALdgLScEqs9V5KJcqqinqFuHIvJx59Z9SnTaV0pFkJtTFgB0Cg71HyXA8DE?=
 =?us-ascii?Q?dEJFZlrzRPhNTumBxk6WSKrIEAfEQ/+qtT3WXhzeNjAtrlVs33dr05sNU+dE?=
 =?us-ascii?Q?gnHs1LCJkcSJa+2NpIe2B1QupHc+fP681xi4srnmK0WLWJ87jVuO/hNonb4J?=
 =?us-ascii?Q?XUmUyQXrG+eEElptiiYrS8nFvuUGqNchgRZG/92kPjcBEWgcZq1yUft5FDMU?=
 =?us-ascii?Q?0o6zs8MYJHS7dhdJOsnSBfEUjhvgjcQ95o3fmFeKRw7Nidrvzrn81gZYN5J3?=
 =?us-ascii?Q?HSGc9i6l85Io9mIOheVWfppQ6zbgMfhbKUblOajrYueCCLtyR/WWxHUerBVi?=
 =?us-ascii?Q?Ess3hbP2znRbu1pJ5QokZuSkSuh5Qfyr7Wzdf5aeeoU9wC5imIa3znl7WLF5?=
 =?us-ascii?Q?18hcwL/C7QmQWZ9eWirfSsWUjNNk3qRNY5oy8Au5UzdyPMVD4pLLr/OGOr4D?=
 =?us-ascii?Q?aU8w0bFyRFpE1foDw/vlipHTVG6H+z5lWm4dpppsW6d4eqkOoL18HgHEqOGw?=
 =?us-ascii?Q?nsEbvWkuGzFIU3wQaTdn0LRMhPmqLbtQhrqcEkmujutt+hKrqeEfagdD6G4Z?=
 =?us-ascii?Q?wODL8UQGOdtht1+nuOnHGKHFJtPqe3djf9l7k/DoOayAgjVazFIaXSbk8KC2?=
 =?us-ascii?Q?84YCkVig9ru3dodHc9tKjj13yArVVKE=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb10c33-ffda-4fcd-349a-08de746c3929
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:48:49.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNQZAYaTtycqpNee9ZvY05WAhD3fwjaqqPKySwKC2fv8XNDQnzMKBKK4O9lHlBYIjTzPBzizbnElaQWmxIEKsa3hniKAHiWlqacUvva4aoE=
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
	TAGGED_FROM(0.00)[bounces-78363-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bcodding@hammerspace.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email]
X-Rspamd-Queue-Id: C7AC11979BD
X-Rspamd-Action: no action

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key the netlink interface.

Link: https://lore.kernel.org/linux-nfs/8C67F451-980D-4739-B044-F8562B2A8B74@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  6 ++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  1 +
 fs/nfsd/nfsctl.c                      | 41 ++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 22 ++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index f87b5a05e5e9..8ab43c8253b2 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -81,6 +81,11 @@ attribute-sets:
       -
         name: min-threads
         type: u32
+      -
+        name: fh-key
+        type: binary
+        checks:
+            exact-len: 16
   -
     name: version
     attributes:
@@ -163,6 +168,7 @@ operations:
             - leasetime
             - scope
             - min-threads
+            - fh-key
     -
       name: threads-get
       doc: get the maximum number of running threads
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index 887525964451..4e08c1a6b394 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -24,12 +24,13 @@ const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + 1] = {
 };
 
 /* NFSD_CMD_THREADS_SET - do */
-static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_MIN_THREADS + 1] = {
+static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_FH_KEY + 1] = {
 	[NFSD_A_SERVER_THREADS] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_GRACETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_LEASETIME] = { .type = NLA_U32, },
 	[NFSD_A_SERVER_SCOPE] = { .type = NLA_NUL_STRING, },
 	[NFSD_A_SERVER_MIN_THREADS] = { .type = NLA_U32, },
+	[NFSD_A_SERVER_FH_KEY] = NLA_POLICY_EXACT_LEN(16),
 };
 
 /* NFSD_CMD_VERSION_SET - do */
@@ -58,7 +59,7 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.cmd		= NFSD_CMD_THREADS_SET,
 		.doit		= nfsd_nl_threads_set_doit,
 		.policy		= nfsd_threads_set_nl_policy,
-		.maxattr	= NFSD_A_SERVER_MIN_THREADS,
+		.maxattr	= NFSD_A_SERVER_MAX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..0071cc25fbc2 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -224,6 +224,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	siphash_key_t		*fh_key;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a58eb1adac0f..bdf7311041d6 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1571,6 +1571,35 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
+ * @attr: nlattr NFSD_A_SERVER_FH_KEY
+ * @nn: nfsd_net
+ *
+ * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
+ * Callers must ensure the server is shut down (sv_nrthreads == 0),
+ * userspace documentation asserts the key may only be set when the server
+ * is not running.
+ */
+static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
+{
+	siphash_key_t *fh_key = nn->fh_key;
+
+	if (nla_len(attr) != sizeof(siphash_key_t))
+		return -EINVAL;
+
+	if (!fh_key) {
+		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
+		if (!fh_key)
+			return -ENOMEM;
+		nn->fh_key = fh_key;
+	}
+
+	fh_key->key[0] = get_unaligned_le64(nla_data(attr));
+	fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);
+	return 0;
+}
+
 /**
  * nfsd_nl_threads_set_doit - set the number of running threads
  * @skb: reply buffer
@@ -1612,7 +1641,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
-	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+	    info->attrs[NFSD_A_SERVER_SCOPE] ||
+	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
 			goto out_unlock;
@@ -1641,6 +1671,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[NFSD_A_SERVER_SCOPE];
 		if (attr)
 			scope = nla_data(attr);
+
+		attr = info->attrs[NFSD_A_SERVER_FH_KEY];
+		if (attr) {
+			ret = nfsd_nl_fh_key_set(attr, nn);
+			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
+			if (ret)
+				goto out_unlock;
+		}
 	}
 
 	attr = info->attrs[NFSD_A_SERVER_MIN_THREADS];
@@ -2240,6 +2278,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	kfree_sensitive(nn->fh_key);
 	nfsd_proc_stat_shutdown(net);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1d0b0dd0545..185a998996a0 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2240,6 +2240,28 @@ TRACE_EVENT(nfsd_end_grace,
 	)
 );
 
+TRACE_EVENT(nfsd_ctl_fh_key_set,
+	TP_PROTO(
+		const char *key,
+		int result
+	),
+	TP_ARGS(key, result),
+	TP_STRUCT__entry(
+		__field(u32, key_hash)
+		__field(int, result)
+	),
+	TP_fast_assign(
+		if (key)
+			__entry->key_hash = ~crc32_le(0xFFFFFFFF, key, 16);
+		else
+			__entry->key_hash = 0;
+		__entry->result = result;
+	),
+	TP_printk("key=0x%08x result=%d",
+		__entry->key_hash, __entry->result
+	)
+);
+
 DECLARE_EVENT_CLASS(nfsd_copy_class,
 	TP_PROTO(
 		const struct nfsd4_copy *copy
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index e9efbc9e63d8..97c7447f4d14 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -36,6 +36,7 @@ enum {
 	NFSD_A_SERVER_LEASETIME,
 	NFSD_A_SERVER_SCOPE,
 	NFSD_A_SERVER_MIN_THREADS,
+	NFSD_A_SERVER_FH_KEY,
 
 	__NFSD_A_SERVER_MAX,
 	NFSD_A_SERVER_MAX = (__NFSD_A_SERVER_MAX - 1)
-- 
2.50.1


