Return-Path: <linux-fsdevel+bounces-77323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PJhhAkGpk2kq7gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:33:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE014816B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF3963003734
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05532D061C;
	Mon, 16 Feb 2026 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2oMTVMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF643F9FB;
	Mon, 16 Feb 2026 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771284794; cv=fail; b=HdBXzAZgjZK5WDVv/dN5gFauqjOd4Hh+5cUecXhc7hd1P4AT1/g1tfsCyPpYTKy3vRkJffxurZkx7x2R9EjbMCyX1CTOJ5OK/GUSQbPAUQm9z8y/GLJgMxm+7SKrbiloGIVnRlbuYVmDmQ40E+RB9989QxYPXDL3RVL6KuSuxDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771284794; c=relaxed/simple;
	bh=97uROQ8Y6qj0oq+BwZhWvpTEvLgREDkwuRIOWnU3LXE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sh5ZGANanwXhS7JMGPbOiJoIDC/4AbqZo+wpUXsFR+23IzIqwW84kviYGNtgdj0Sl1AE86GFfwimbh/dGRc28WXzzQWfKKc9VDlh/0l/0eZLCICNFh0wv6SM4yCAP5LL0obDTo6C3wvuTV5dUhIfVqkF48qZJDH8Rb1sFediP1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2oMTVMl; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TidEDFKkogRsCdohSWZGPG7TV1icQrgmQ51yQohkd0AgpQI4QTVHZ12xEB6DdtAT1oYDpc4HG8BpS1NIhvtr2z8q/HOH1dJhvbyduEUWrLoCOc7dxz9J+ZpD+6CaduQDjvK+qxHSpuw2BhrhGuH3bQ1nrNPsHOLk+D6Ew1PloNI3Lb+IkyRsVQg6en/xos4XBmwZa+MGWc1AJBO/rkwsxQihAlNiWbh4oDK9aPG0hXGRpjUKrLWI9Wcn03hRH1thntI6scUSGdp1jnjIGaWSNandbi+sfrVzje4Tc5lRWKQ0XQGnwCOLASbuiNFRqescv1wBCyiCcqAdHUlTFAjWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G9gz7Ljfmc1VNZla3l7zPoahrJD3eH99MSZjoT3Ags=;
 b=k/CkvUuM3s+p520X2brb1lOFMNvu2ovc8Spba8t59iquoDTGU0rKJFPMYVVv38ZZe54mDp7SXAsAscXRwfTtG6YZMLOEkH2QBGmBt8aRJsPeJ9gFnUA0pUjDPOH/4a55de1EHlmLyGinzOFpUG4jcEiV0wY+2vfyYu5XSdVOmGeGgN6m19/9Jx61yILBbvbRyauV5M1GqRCqjiOpSkE8FH17ziP2JTvJ7YCPgLi6jWvFl2EhLmTNxCyRQm0RCYxsut7th4bxwE2cb+Bd+KhhhYTYwjgD3tNqO7aTVYZN6i9jYpvarvxHMjV2LlsMZ1IHo1lPrlpe0rRJH6Mb8/rvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G9gz7Ljfmc1VNZla3l7zPoahrJD3eH99MSZjoT3Ags=;
 b=h2oMTVMlixVLhr1T4+XIk+AXvMWWTDQngh8q0aM8wv2BVtr8Y9Dxj4cWTuUn9UZ5ClImJZ4zct2O2DB676t6HXLFlW0ULWAw288f8QZ0Kcf3h6EsdGvfV1I9oLEbPdC/iPUpoI4hsKKzYaqD9Qxv/4LhDJUrbLt6EhBTkwr5zmc=
Received: from SA1P222CA0050.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::25)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 23:33:09 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::7a) by SA1P222CA0050.outlook.office365.com
 (2603:10b6:806:2d0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 23:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 23:33:09 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 17:33:09 -0600
Date: Mon, 16 Feb 2026 17:07:33 -0600
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <david@kernel.org>, <fvdl@google.com>, <ira.weiny@intel.com>,
	<jthoughton@google.com>, <pankaj.gupta@amd.com>,
	<rick.p.edgecombe@intel.com>, <seanjc@google.com>, <vannapurve@google.com>,
	<yan.y.zhao@intel.com>, <kalyazin@amazon.co.uk>
Subject: Re: [RFC PATCH v2 00/51] 1G page support for guest_memfd
Message-ID: <20260216230733.ejxtppfrbjaarftb@amd.com>
Reply-To: <CAEvNRgFmq8DP_=V7mrY8qza3i9h4-Bn0OWt72iDj6mELu+BiZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 68eea953-8518-47a9-c790-08de6db3be92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXhYUnI1SHpweStOUmVMblNnWFFNNkRUSWZwWGNybnZtZFlBWWQ0dElsQm1B?=
 =?utf-8?B?eURMdktha2lPVUhzaHA3Q0Y4UDJqS3NMOFphR3pwQm8vN0VPK012dGZTa0Fz?=
 =?utf-8?B?Mm85TDFETFV3RGcwbkJkUDRrWmowY2t1eTRLOXFJNFBQNmczVStuVExvTkFC?=
 =?utf-8?B?Zm1MUnBUVUR4aEs5NnBjeFF4b25PMWRxNzNhLzF6d3FxMzV0SDhjM2RCN0ls?=
 =?utf-8?B?RGRXYjJOQWhqZHk3UHcxS1FITmpOUDliN0d0Z2pjZG0rWFpVa0wvcHZ0WXdC?=
 =?utf-8?B?Tm5UNURsbVhxZ2FqQUJndXk5QURLRWNVeStGODM5SFBKN2hEYlB2RldFNVFi?=
 =?utf-8?B?RnlqWmwzWmFzaFluODRGQjNyRHZtRWZhT1d2M0pQOVRlMGNvWkRORnh0bUds?=
 =?utf-8?B?c1JMOWFVZld5SlIwUWQ5WGlwYUpqYUUzRFFtYmV5LzhleU5qamkraHlkOGVT?=
 =?utf-8?B?aVU5YVFVQmFDQW9oZWJZNHRzd2dlb2pMSlJzZDdTaEJBMW9za2NONnFYUnJY?=
 =?utf-8?B?bVIzdDY3a295N3p4S09tUFJ2Y2kwYWU5Ui9SUFZGWVcydFZ3ckZRRVQ2QmRO?=
 =?utf-8?B?RFZMMVk2cHYrbjExVWdaZk5GNFJ6dnY4amx0MFkrTlRTbW0yUnYzZm1PbFAz?=
 =?utf-8?B?VTNpVWsrUHhYMWxUaTdSem0zbHpybVZ1ZzlkWUlCL3VuZWdJcDBoSVFQYUZk?=
 =?utf-8?B?SXBWdU5uRWwydGVicWhZejRrSmo2WnZ4Z2lpbGFmUlozRnRLenJzYTB4RzUx?=
 =?utf-8?B?Uk81SHJpbkVHRW9MVjF5TkMxRGVoMzcyNzhGWGxzY2dPeHpYM2JLdUU3VkRv?=
 =?utf-8?B?MlZIN2ROR3dHNHg0YkpEVk5KV1Vud3dGMHp0d0VBbEp5Mlg5UzJOZER4SlZq?=
 =?utf-8?B?MUFTQ2lKb1p0ZnYzckcyTnFYbmFVQ0trM1A3NkR6RGlUSWZacjI3UE0zRSs2?=
 =?utf-8?B?RWRDTmFvaEx3S0JMb2ovdnhuQkdEMjhheFhZcXF0N3h3UkkrWEZIY1NWakxa?=
 =?utf-8?B?WDJJVi9hcjJSTXZnKzV5RmhHOVNONC85UC9DQmRrT3hxS1hUNStYZEp4bzM3?=
 =?utf-8?B?amZjN2VjMitTa3pUc0h6UjhSNnh2azUxcW1KWjIwd3VtSjVFeTFsUHB0TVpM?=
 =?utf-8?B?c2Jha1lTdzFHYktjaVdjQm5jUmEyb3J5ODFwc0d5Rkx3WUorNDJERWpTeWt4?=
 =?utf-8?B?MERReCtFcldDWkZoSUxUNWFsNkpMMTQ0dGYyakdMUTR2dUhKRVpCYTB4OSt0?=
 =?utf-8?B?M2g3OXdNWDlhdW50ZDc4OG1MNVJ5QzgwemZzUXNVL1I1MkpNVU9keVYwME0y?=
 =?utf-8?B?eEVBWEVlaVBEYVFUZitaRHcyZlhnYmtOUzVsOWs2eG8wMnJRbnFHYmlhTmJn?=
 =?utf-8?B?dFE0MzVrYUZEd3hHVGpRcnpmb3lYMWlNTzRJT0txTW5OMkZsbmlxUWhtYUhX?=
 =?utf-8?B?VTFkWmxiNngrMWFMRnhjd1A3cGhtZjhvaUo0Z3JiQS83c1pwV0ZXT3ZudlhS?=
 =?utf-8?B?eUJpaUw4Z0xBWStBYmF6bGtYbnJsOERQNDJwV0FkaTBpc1laWC9mNDdhVExE?=
 =?utf-8?B?OUJsRGNkOWxoN0lwd21reG9RWTNFZlNjem1lNG5QdnhYSWpvU2MwQWZIdFZi?=
 =?utf-8?B?K09VUEtyT09zallnT2l5c3lVbkNRQlVSV05oZnV1Sk9aK2prS05ZbE1NSkht?=
 =?utf-8?B?T3VZRVNLb1hMRC8weVR1VjhRcUVUUGZlejJuejk5am9ubjNqZ2tUT1hmdEIr?=
 =?utf-8?B?WmQzWlJTbUU2dFNEc2VVZHFZKzJQd1JxSFBSclVYdkdKVXZTN0Y3ZzZoMFlW?=
 =?utf-8?B?Z1NieUZNYkVFdkxxZGhBTEE4T0xGOW1NbjhValFYZkJLWko4VjJIN09IaXRX?=
 =?utf-8?B?ZU1YNTFUQnBSWUpGK3Z6YmVKVjhyeFoxWnRpNTNVbGtocGYvajZNZWEwQXlW?=
 =?utf-8?B?U0ZDR3AxM0grUkUyRVhnRzJQbE1NRSthRXhrTUtleFBaSGpwYmxMeUtFeTJW?=
 =?utf-8?B?RVVNeVo4UE5Xb2ZoUk5PUjErRnNzaWZldkcvNnhTRUNpazIyUmVjVEpJbVkw?=
 =?utf-8?B?QkdGanROUVZPdE5zODJnMkU4Tjk1anlTUVp3Z0JYSGpVdUJpbW1LTUQ4a0N2?=
 =?utf-8?B?c3Qza2N0cEIvVjZyaHhDUzQxUnhGMkRDTDZQME5PSXJVclowQzQwck0rWUhS?=
 =?utf-8?B?cFBxUnRGVWQyODErQlRpZWxjdS8vNHRRS0gxS21PejZKcVluQjI0T1BFeTB5?=
 =?utf-8?B?YnNSRWw0ajJDbTg5blJ4WXM2dVBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	05kgvl16sGx+NI1mN+zz4GcD8MMnPGoQivma/mPVzuyG3/97537wGkEyigDysmBWBJ2W8smtXl1OW54RrEZhBDCkCk7eLE1w2/7SkscjK/V5XjndcPEcIQUZtbdDRck1K8v/Rt8881O813ll5mcnnK1eOwRnflJ+1CzAhpybfgKqRIGrJQQSCAJF7vzEGS34nu+XkpHasP/QjJUgV93LTE04FXwo95s7ukvHHn4XYX+sTzh1OKrUlpm/6BXHVPJ9Kpu3kBNKyG+3K5GrpwpCZKSEJqZN0La2gCCNwKlEkOyrLSXKICjaQM4MpidmxWatFtIqtmBjQ7g60QEnClJ6bGB0UTam6XdMOkCoQ/9je30z8A1LYiNjUKl34opXvVabu4YaFMsPAP6TYrchsTmsR2LIydMl5S/q/h58PYhkQXZMbXNdghdo9FLFZK53oS5B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 23:33:09.6720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eea953-8518-47a9-c790-08de6db3be92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77323-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[CAEvNRgFmq8DP_=V7mrY8qza3i9h4-Bn0OWt72iDj6mELu+BiZg@mail.gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.roth@amd.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 12AE014816B
X-Rspamd-Action: no action

I'm not sure I'm hitting the same issue you were, but in order to fix
the race I was hitting I needed to grab the range look outside of the
kvm_gmem_get_folio() path so that it could provide mutual exclusion on
the allocation as well as the subsequent splitting of newly-allocation
hugepages.

Here's the patch I needed on top:

  https://github.com/mdroth/linux/commit/240e09e68fe61bb0dfad6a8e054a6aa9316a3660

I think this same issue exists for the THP implementation[1], where a
range lock built around filemap indicies instead of physical addresses
could maybe address both, but not sure it's worthwhile since THP has been
deemed non-upstreamable until general memory migration support is added
to gmem.

I'll dump the code below though for reference since I know some folks on
Cc have been asking about it, but it isn't yet in a state where it's
worth posting separately, but is at least relevant to this particular
discussion. For now, I've just piggy-backed off the filemap invalidate
write lock to serialize all allocations, but I've only hit the race
condition once for 2MB, it's a lot easier with 1GB using hugetlb.

[1]

The THP patches are currently on top of a snapshot of Ackerley’s hugetlb dev
tree. I’d originally planned to rebase on top of just the common
dependencies and posting upstream, but based on the latest guest_memfd/PUCK
calls, there is no chance of THP going upstream without first implementing
memory migration support for guest_memfd to deal with system-wide/cumulative
fragmentation. So I’m tabling that work, it’s just these 3 patches on top for
now:

  2ae099ef6977 KVM: guest_memfd: Serialize allocations when THP is enabled
  733f7a111699 [WIP] KVM: guest_memfd: Enable/fix hugepages for in-place conversion
  349aa261ac65 KVM: Add hugepage support for dedicated guest memory

The initial patch adds THP support for legacy/non-inplace, the remaining 2
enable it for inplace. There are various warnings/TODOs/debugs, I'm only
posting it for reference since I don't know when I'll get to a cleaned up
version since it's not clear it'll be useful in the near-term.

  Kernel:
    https://github.com/mdroth/linux/commits/snp-thp-rfc2-wip0

  QEMU:
    https://github.com/mdroth/qemu/commits/snp-hugetlb-v3wip0b

  To run QEMU with in-place conversion enabled you need the following option (SNP will default to legacy/non-inplace conversion otherwise):
    qemu ... -object sev-snp-guest,...,convert-in-place=true

  To enable hugepages when using either convert-in-place=false/true, a kvm module turns it on for now (flipping it on/off rapidly may help with simulating/testing low memory situations):

    echo 1 >/sys/module/kvm/gmem_2m_enabled

  This tree also supports SNP+hugetlbfs with the following in case you need it for comparison:

  For 2MB hugetlb:
    qemu ... \
      -object sev-snp-guest,...,convert-in-place=true,gmem-allocator=hugetlb,gmem-page-size=2097152

  For 1GB hugetlb:
    qemu ... \
      -object sev-snp-guest,...,convert-in-place=true,gmem-allocator=hugetlb,gmem-page-size=1073741824


