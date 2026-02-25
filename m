Return-Path: <linux-fsdevel+bounces-78367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADz6KIfwnmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:52:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E5197A3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DA5B304DEAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7843AE70E;
	Wed, 25 Feb 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="JYqhqgrp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021109.outbound.protection.outlook.com [52.101.62.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15C3A1D0F;
	Wed, 25 Feb 2026 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023906; cv=fail; b=S3Km1VkVW/YBamTYWXaLNIiWcVh6S3l20krkhaWKGuLXkY1BYjaYfwFG4b9/Q2q6qw6NQ2/leXuDulMeFj+XExwjJg+COAXGjCeUl5MsOC4RIssDwo+ZnfUaGeTVj/wgxgFOFxkR0PzTzgru0TCsv7G6iyiS98UxF92Af+W2Xz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023906; c=relaxed/simple;
	bh=C6WaHhqiVpa/1iWUJ9JB0OBBHpB8ZO20exkAmi1BnDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uM0Si1YzWfOkmc9YhJzdmMD2NdHGMnHkRlBSIftTznd+xZPWRaciff3wq9q8qBebll+KeX+zAy59XtdJz7ey+T+5IaSiTTW+2lDii6IAjalcP9PKYyCSJD4vwc8NWo0fcwgdtl3h+NZSAq6S0Em5II7SizMDvzDpy0bet3CHP7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=JYqhqgrp; arc=fail smtp.client-ip=52.101.62.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTLcgwAdDBDnDayL1YgzTS0Itn7vzIi30oy4M8PJ6VB4CcLW8QHU4m5+F8nVAln8X72QwbMVUuNGdrS3JbJmLiGFwgWrnUrfUFLubpaXLlb6MqsNbAxVbCs3aTVHm+B+Q/TFFjiXrBDjsc02A+YCeBjUxnfcTPO7UDnIn9lMYlvfNyq0+Vv55S53eU0U8FAg0BFCS16bogVVuX5AHeVi7yRnLMPcJc0lmEc8B17UU/Sq9DSATTD5ApdGH19q3WRf8lhMaifIrPyf2UuLbfwZCsHBUaO372ia2eQmu31+Np+EBXu7aKT2jtxHJvFAc92ZanzlUtGHlRRH2Tcd6OWQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltDLP9O05JkjvgpiGN39yPDE7p+5jmg8VZ66F31AbLI=;
 b=YsHqWtv5fG1RlCoIqrwcRoP4CC25ugGR0z8Ob8gvMcdWMubXeTFc4MEYISzzsdjf+7n3hkunPO3S6vEkI1fDYb8msETdlsXq/cgDxhDxIyNAEgmqGOdZCBARWmaV083Cgmm0D6Mc/6jgLdAj3iygjuVHek+ilZ4HW50x6dA+H9BIBaaEz1qDQqLzqltmVLibBZH4pkMJjRPte9Qs+QG3IgHegtRfXFS+XwJseu6Ke7s4dJTdFXVyQYqdo9/WF3jZLI/GFVWUtVHMBaCWM9Ehjgt4Bfl3X91yx2E2bhgzaVbD8/ygQuIL5iOu2/TLV5jpfMn5OSyyIagj6tNgzdwlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltDLP9O05JkjvgpiGN39yPDE7p+5jmg8VZ66F31AbLI=;
 b=JYqhqgrpq6dss36/2/SrtVUeV1pMWua/PINVBBSraOYjZrD23r4VNj9AbHOYqLoEdez15OE5WiA3AAJMkkEMNXKZWtxscpAkiNxhrfbPgdWZMWGd36P/Zbfh3jyy7tYsMqCbiMzuEhJ2XzRYI5Ccj0QHBxJ0yc2fpTpuHxH1EdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 DM8PR13MB5206.namprd13.prod.outlook.com (2603:10b6:8:1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Wed, 25 Feb 2026 12:51:42 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 12:51:42 +0000
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
Subject: [PATCH v7 1/3] NFSD: Add a key for signing filehandles
Date: Wed, 25 Feb 2026 07:51:36 -0500
Message-ID: <2fa9ee81cca11046ba123d991dcd36997d8abc50.1772022373.git.bcodding@hammerspace.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddcd2e72-da64-4656-a447-08de746c9fe0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	aczpfqS7wbxddsp42nFMtdVUWN2fmrWPBqIVZ29+WdTSZcvv3p7g29CQ7r+mD+mBXKn6eSnQh3XExxbVVqb1ukf4G84+3aqB3YLm2gguK8ih/nEA8HYcpG1cl7F07njN/D8uz6z9Lw9Fj1zuskcJ9oS0/CyHjPTUWL5xux+tBI0yeBT0b/WRYzyzrEnCqMUocy1cIA3OmXuBitEBABjiFbOeHc9NJ1lzr0bm/ce0zn3LcA0ZX+LOBMnRS/h+JfPpzEiFZVUQp2BBT592+w3+d/+Q7mUvqXig4P53sIabztMCq0nd16c9dARnfdjvJJqPYbR4jlEcnp9i5brXqAVOS4s0nG9QX1cOGvcw7EGr9AK+wcePiako/mgFsEaQJ/IJypcZ7VxScWz8Pl67dcLSppRUJZxUqaLPiZwQAYRo2EkHBpi0/pbeke2YAvvPUsoXaxsqSs8YaYa9dcI8XgKAdzd4Zhm1jkG4aHqR//L9vbxwUdyeui6K24c+f0HPTfFHCT4ZrSJnjIKLW1TmsvftucnBsGlKwoJbnFerrDMIsWNhv2jW74qBctfOJTZomte16kSG8r1/eklFCubb+Lb+RMjJNRoaErq3GDrf+iGW80Eygqpkn6y2HBCE3T86zcwoXBA+xO2Vozvfn8VIEmE8zah1cHAru+ya3xpXa3ftDj4HjhIHQEb5oiKIcFCCK0hnldzDm81v7r7AXhqqVqP76f9e9nahMzKAPvP2fSuvzyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2r4u2nXgSHCmH//N97vEfy8fse/HnlqV6V9tvD6P5KU3c4YNfCeMuq8g9ctE?=
 =?us-ascii?Q?42zm9lWg3TqQ0m97hKBIWLR1JZwrUSryE9vJ6tGgZBBePEtAO85y2FJgT+Cz?=
 =?us-ascii?Q?pCdNrQLVsBLeV0b/5+me3iCb4m+siyk4OkZWyOmrKnLgVk74cI3nRDc90csf?=
 =?us-ascii?Q?zo8LyRaq4FRGsGqsP81Ry7dHRRYConBe/OBwiJ7qnmyVvVQDOdEgdXRNKPec?=
 =?us-ascii?Q?6No5ymZijkNmve736lj+uarO+51O1icFedQUB97AW8hTgteCJ34gMuyj2q1U?=
 =?us-ascii?Q?fysiBoST14c94vAAjxa7yT5lqDTwVYxYqep+L0e/xTZWUx/g4oWDQEMw637w?=
 =?us-ascii?Q?9ErHPnWwRZyISSQhcxsGAu4cO7xWlbqOQVicEwEJau1pPf+sP236Ee63lpaQ?=
 =?us-ascii?Q?QlFRsEY9IT35qe8TGPiQMFF2ZxdQYu4/zx7ZJQq9k6AlqZh1E45dULB5UWy4?=
 =?us-ascii?Q?3x8bk5l8n+zsUaKJuuHaCT+lAOMJig2ZSOqaKaADcWhiyA8NqIy54zRIX46O?=
 =?us-ascii?Q?V1TTMEdcEnCfNPH5lWQKXSmyXTQvxIwRz1GtU0bynQEuShCRn2HsnjCSwFWh?=
 =?us-ascii?Q?7MQIQKzLHvgE16ol4UHUAMy7lAf+GrfDZdM9N7nli8n7FMom8AIVvngcqLtm?=
 =?us-ascii?Q?lOag+qr6bB+zl3tG3kBHklkaQ6BLz1uh+MDt/vAtcNDVclHWfdc+850xHQWd?=
 =?us-ascii?Q?m9Rnq9ChLGPuJcRtae/cMnaksq15XnjqPQMDyf1tI9NWIA9QR8iHrsxhJqsr?=
 =?us-ascii?Q?rdcSw/89PnViY2JzjU8+uMGp6B8PxnwQElo2MSfqQXuvfV86j822TZ5iJuzs?=
 =?us-ascii?Q?KHgJwnQgRrWFmZphbMvIVN6YXFCPTn6SvatNS8/lAwg21elIlDcRP4+5J04k?=
 =?us-ascii?Q?gYszlqMh26WHUqUnNlXPOqNJ6IhvjqbtmkdAhtAlydc6JcwjmjnkPR6FjzMv?=
 =?us-ascii?Q?3h/MnXkCldF2yjbqHGqVOY6uoOfE6lvPDEh+cL/8HsYpROjUoZtx7STxRL8n?=
 =?us-ascii?Q?UlTkGD7k4V3+e+9FfZ6mM5W3YdlK/zSiqJEyO/eleTJyhf2pbPgc7rns2eM8?=
 =?us-ascii?Q?td82HStWlyZ0xDW8wsgiqAoTzzJBe0yBD7tXNaYA8DwmkKlNVqglxWbmuWcd?=
 =?us-ascii?Q?MzvFGAPnHiQqlY18s8Iw7irAwlB/KqM6Wf9CRyrxqJpF+tpVlaQbhLhy9uor?=
 =?us-ascii?Q?5knx+i4Q6BmubX7qbL8tGyM85BASA78+Cn1tFl5MBDfJHCKDfhn4WjjnlT6q?=
 =?us-ascii?Q?lESALV5IyXVBZgpnUONVD0hyJRJ54wfAQ+X9X/EmdliPvhtA34k5S+ykgotx?=
 =?us-ascii?Q?WE+PdGMa0mGnxKPIqOA/1I64niCTjWGxVa/ZO7nCrmDyq4dBuV74cxoUBQ0t?=
 =?us-ascii?Q?yPPrgUH4V0tKbY413aOjKv7eTS7FeF59RpfIu4GjVGUQiD+nYpIf3FdaAaW7?=
 =?us-ascii?Q?ZEFP5CVx7ZSw1k0aqafDROJQbpol03z7N7gXqSEkvIu/BrnMi7+VL6mQZrnS?=
 =?us-ascii?Q?PGJTP5aSTc3Hu2qy//yQ+N/x5/m+er2vmxr1sLb0ioHdtX0gSD0YQxYhA1KU?=
 =?us-ascii?Q?NsSWd5RhaRIIohans6ZTVnsFR4l3pLdizMpDcrJILwbKcgL/Xrc5Cvs4+8wC?=
 =?us-ascii?Q?GuZ8Zi0kl317NGSZxYXZqVb02l7tvYFfGgOZaXQhpPoQSjOuGNlv1xqLC8PT?=
 =?us-ascii?Q?KloaBRtLU2GjV9KJfvnDhnN9QFHzPJbDC6AOqJM0LbsskWNDYz+U5MEAXXCi?=
 =?us-ascii?Q?VdEtSQ7UeJVkiahL6gMU+o7jPS1O/k8=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcd2e72-da64-4656-a447-08de746c9fe0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:51:42.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FO4LNIwMqSGb7w3sYNj5p7XdzF727GaTJkvkJzOs0sunBqW5lY5U+N1qn+VCjruDrxifc5Htmfk6u56ANioSIp+wRUZ7IWLLWLMMFYBp18c=
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
	TAGGED_FROM(0.00)[bounces-78367-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:mid,hammerspace.com:dkim,hammerspace.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 102E5197A3A
X-Rspamd-Action: no action

A future patch will enable NFSD to sign filehandles by appending a Message
Authentication Code(MAC).  To do this, NFSD requires a secret 128-bit key
that can persist across reboots.  A persisted key allows the server to
accept filehandles after a restart.  Enable NFSD to be configured with this
key via the netlink interface.

Link: https://lore.kernel.org/linux-nfs/cover.1772022373.git.bcodding@hammerspace.com
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/netlink/specs/nfsd.yaml |  6 +++++
 fs/nfsd/netlink.c                     |  5 ++--
 fs/nfsd/netns.h                       |  1 +
 fs/nfsd/nfsctl.c                      | 38 ++++++++++++++++++++++++++-
 fs/nfsd/trace.h                       | 22 ++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 6 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index badb2fe57c98..d348648033d9 100644
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
       doc: get the number of running threads
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
index 3a89d4708e8a..6ad3fe5d7e12 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -227,6 +227,7 @@ struct nfsd_net {
 	spinlock_t              local_clients_lock;
 	struct list_head	local_clients;
 #endif
+	siphash_key_t		*fh_key;
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index a745b97b45fb..032ab44feb70 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1581,6 +1581,32 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
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
@@ -1622,7 +1648,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
 	    info->attrs[NFSD_A_SERVER_LEASETIME] ||
-	    info->attrs[NFSD_A_SERVER_SCOPE]) {
+	    info->attrs[NFSD_A_SERVER_SCOPE] ||
+	    info->attrs[NFSD_A_SERVER_FH_KEY]) {
 		ret = -EBUSY;
 		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
 			goto out_unlock;
@@ -1651,6 +1678,14 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -2250,6 +2285,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
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
2.53.0


