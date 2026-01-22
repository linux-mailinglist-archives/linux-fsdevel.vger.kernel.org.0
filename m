Return-Path: <linux-fsdevel+bounces-74973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hb6MYOucWlmLQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:58:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F161D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 05:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BBDD3E8C54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85E47279E;
	Thu, 22 Jan 2026 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o3aTXLU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3430F922;
	Thu, 22 Jan 2026 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057771; cv=fail; b=JrxxB8coNfOx7ecIHF2N4kXWR7ZbXN+RcWdNGAAT0WhiaqZgGlD8reNNDHM/cOmlrF682ri3bd6CADnplEmQ2El0E00ykGKHblCian/BCuQjXG+2lJVuKjoxRnlEY5KamglmMIGoHKBqLv0cVieMvQi+xl5lCTTW7Gz9wC8xxVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057771; c=relaxed/simple;
	bh=2PyM1awEaKxz7R774FtZv9+CXAsJdoMXuvnWMc7acTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmSGJnvDbOsQITYD+gUP/80HlW4tqtpeKUKY+9IvKOhkFVhQCcmzrnbwR1yZD4DpemEGXAanVd7oFoiQNQbzggdWXaNEm1EmJz5j5/3yt86ymMiasQoRUY4iewtLGIolSiydBJMjwdkDAyWPqR0dY5Omt69S8S7xXK6uaPqgGI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o3aTXLU7; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+8jyMe4o4K4CdtTY7dbBEpaKTN0VGCiaVfiJJbrqK6wT90AP5CDxqke2O7k4lUVQ8/GZELyBxTbWBP9cZf61232khy9p3CWB4j5n/HtiKc0NKW9fDmEPTSFBmvQp+LHa1kjmfnK1Gblrn9BVzUqIMrAbGDUke3PsremfDHE4Uxh0mm+6nxYEIHill0NcfxKTEPwILmaQTIJ4XU7gD6MKeOPuomFOA3jFT4rPFt8lzXA6FpjuDJtcRHm8etNZJLtRhr6wDNcu7jN7miBxO8bnFC/M8ArLSmc82TFeKIsBKrWlSAzAX716LRFyAVGQhndioVSvCxX3Bz+tFvxzWjI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/gzvrGCCQmtZIP2r/blux33loZCzx5CG43D/3TOR/s=;
 b=AibBSQ2Q+Is5+jX7U0/c1Kddkds70AdNEvSOsoPmS/7439d8VBN+z6/7PF/54FKUtrepSbIBWO7DhnJe9b/Kk5yI1rbUhl7BWPFScKnHYItdbkOqDhVVo0qs+0gGsyiJCVtiyiAh3QIlgV4eLoEdpFDUW9XjPwDmOLSzMGaHi7FHSjbMizfWiJEKSUumej7h4UNfGMX+MbIMbyB3Qr+LgBggijCq4hxf97EEp0mK7lgq74Gi8Xqgwks1m+DlAdZDw98MGurCfN76VtFNNJRK/vb1VMk7KrCKeMI8KdHbAX0klriLzDg4ZwhZxFzdHmrsmtRY4lGsSrF4A259sPrzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/gzvrGCCQmtZIP2r/blux33loZCzx5CG43D/3TOR/s=;
 b=o3aTXLU7UjJJqZWLmNJdlyHM2LRlNmv6huXlQiJqD1X2xcht7FIVf74e1IPcAl2mnJ0LPLzCbNga9ae2fou9mB1FBFxnvS3htYxUIP7+3O+ZSqXSwDcF42tJDEVWwBlAouOgmLRH0u37lrbfhNOxaaeraQ6wGEmNXfJJzG80NFk=
Received: from DS7PR05CA0100.namprd05.prod.outlook.com (2603:10b6:8:56::23) by
 MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Thu, 22 Jan 2026 04:56:00 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::a8) by DS7PR05CA0100.outlook.office365.com
 (2603:10b6:8:56::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Thu,
 22 Jan 2026 04:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 04:55:59 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 21 Jan
 2026 22:55:58 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Matthew Wilcox <willy@infradead.org>, Jan Kara
	<jack@suse.cz>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown
	<len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Li Ming
	<ming.li@zohomail.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, "Ying
 Huang" <huang.ying.caritas@gmail.com>, Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Tomasz Wolski
	<tomasz.wolski@fujitsu.com>
Subject: [PATCH v5 5/7] dax: Introduce dax_cxl_mode for CXL coordination
Date: Thu, 22 Jan 2026 04:55:41 +0000
Message-ID: <20260122045543.218194-6-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20260122045543.218194-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7a8fb5-3935-4ba2-a5c8-08de59728971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wVbu3DPjKiXKwfBjSf6MlDcSlHb/Ds69RB/zMwbD/toTOZQXCbPA4tpetXG?=
 =?us-ascii?Q?e46p1PO7xKHXWWJRyDCN0afWjLKDm9nMNGV9xCp+dDvBIQlMIXKskXAVVhIF?=
 =?us-ascii?Q?5pTZe7CHff+t9LNw0fnTMf8UjepItoKtQCZveLgwaPKEAYrMV1f7LZKqMtUd?=
 =?us-ascii?Q?s+MKMWfF0mNEycPwqSYO2VuMIaqqf7qbY+iqkpG2zNeQRjn9/6dFuEKv4zI0?=
 =?us-ascii?Q?e0+X7WJFus8OTYoH4oNoUFjYLXZzNMuoicKOKMZefVW2r3tDX1hyHjHXZGeC?=
 =?us-ascii?Q?KtEyCL7rP4euI5vVVEfYWyPrdmXXkeo0SES18t/j2Uds3esBielzG8Y3K4UC?=
 =?us-ascii?Q?RdmEzC+OWJedCgdwBGwxcKXK+kC6F15gGPMQYOFwtvZRUP0R9m7fO6wQKmhS?=
 =?us-ascii?Q?wLNxB6+/sUW1U1I8I0jFSt1iPkEWwN3/gNXqJKmDttm9dVlKcy6kLrSshbN3?=
 =?us-ascii?Q?f32TQ+NHyOphgXoQa82RlBBWlyx1Foq+mO0BdZuQ6t6zizYUb+KFVdXYPSNS?=
 =?us-ascii?Q?226j92G720fJcp0uA4Ul9oo3G8Of1hvDygcOXf2YF2Wn6GSBb2K28gIuXvAn?=
 =?us-ascii?Q?AeLMvXn8HqZSR59unzrhZ92LcCla/DYajSXjQR6nEeJef5iy5B2H7xVO8ZwX?=
 =?us-ascii?Q?USrgTu4a/QauYt/WI0JCgnFUO3XHl+//wkSCEm0IeWaMcUKrSEx3WpVbogYZ?=
 =?us-ascii?Q?ht8tnnP0yVixNJuMl3sih0Zg/oU8Qj09pzqD0agNDrRV3P0/gbBOfRaZwgvs?=
 =?us-ascii?Q?QCb8WEhsxFrFleo3x5NjexDoLqO7Z7eOwAXfgB2Lwp8Iwf/joAuYg9XPG16I?=
 =?us-ascii?Q?NlKrWjX0Q/1cfWVfR+WO7UfNy+PEg2Kbfugbn2ZfXf56EC0MtEB3Fw/u0V7p?=
 =?us-ascii?Q?u/pbtYZ7dCdEWAm3wNmW+dVWYkRl5OxXy2UqcRPKiiLPwQyLEHFJncl1x5GG?=
 =?us-ascii?Q?W9vZWKLk9O3kKVq8YoJ0yVuhHL2q15cVknv1vqY1pZRok9J1wOJvmQtwYF3E?=
 =?us-ascii?Q?fPsQUaY+V4igzc1AapYOJ5knHPrpdG35cVfPbxlPfaxAuAF2jHZBZUMJsHpO?=
 =?us-ascii?Q?QDQEjDI/vM3SgcmohwYKjSve8tL2Bo6RELUhwVye0zjNF/Cx+HmQeUq0MAxY?=
 =?us-ascii?Q?mwNKiq+iI/DtwtC7DouxlskzLA+dJC7xU3y9nwNAjbe3IU38nep6QUSxDG/2?=
 =?us-ascii?Q?SkFS8bY4YyQkcXKSK5r6pvbGCxoQFTydgUOSh4IOExmJVqbOoGK2btaqG41Z?=
 =?us-ascii?Q?wyyTLYAINbxNCZUWXtNHrukgaEe4J8MDa2O/RxDqFpTmqVtGgYzLrAtYqHrz?=
 =?us-ascii?Q?EScKSLeAWm365aZvZ8WYt1BM4wjziSsH9nDDLXs7gavg6hIGNLqSTskUUpU8?=
 =?us-ascii?Q?P6KWZhpJGK9UDx9NK5qdyCMLEg8XB0few8rNkIEIBpfO0nGJ7/XL1PtuE7J5?=
 =?us-ascii?Q?IGFeYG+VHRUGi8CJGz8iuYrlQ9FEjUJrRtd5k8JM2TyeDZnTtmnMSRmGYQF1?=
 =?us-ascii?Q?KNDubSHqrE06MM4tjpril0uh3SO4Zkh2W5iuBnIiKL4CPUGhctYYbkq4iRiu?=
 =?us-ascii?Q?3w4ucN8xcueMSwqVixkpwn2toen33dK6NRNohxtIwC+usCEYb/YxBvX9r0D7?=
 =?us-ascii?Q?ZfVfqZX1sikpSdkRzUM/oqmJgy9WjHfOq3MR8FbuBTAFDp8auYCpNetok1Ul?=
 =?us-ascii?Q?xNujrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:55:59.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7a8fb5-3935-4ba2-a5c8-08de59728971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-74973-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Smita.KoralahalliChannabasappa@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9C8F161D8C
X-Rspamd-Action: no action

Introduce dax_cxl_mode to coordinate between dax_cxl and dax_hmem when
handling CXL tagged memory ranges.

This patch defines the dax_cxl_mode enum and establishes a default policy.
Subsequent patches will wire this into dax_cxl and dax_hmem to decide
whether CXL tagged memory ranges should be deferred, registered or
dropped.

No functional changes.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/dax/bus.c | 3 +++
 drivers/dax/bus.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..72bc5b76f061 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -24,6 +24,9 @@ DECLARE_RWSEM(dax_region_rwsem);
  */
 DECLARE_RWSEM(dax_dev_rwsem);
 
+enum dax_cxl_mode dax_cxl_mode = DAX_CXL_MODE_DEFER;
+EXPORT_SYMBOL_GPL(dax_cxl_mode);
+
 #define DAX_NAME_LEN 30
 struct dax_id {
 	struct list_head list;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index cbbf64443098..a40cbbf1e26b 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -41,6 +41,14 @@ struct dax_device_driver {
 	void (*remove)(struct dev_dax *dev);
 };
 
+enum dax_cxl_mode {
+	DAX_CXL_MODE_DEFER,
+	DAX_CXL_MODE_REGISTER,
+	DAX_CXL_MODE_DROP,
+};
+
+extern enum dax_cxl_mode dax_cxl_mode;
+
 int __dax_driver_register(struct dax_device_driver *dax_drv,
 		struct module *module, const char *mod_name);
 #define dax_driver_register(driver) \
-- 
2.17.1


