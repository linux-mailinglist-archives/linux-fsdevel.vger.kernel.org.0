Return-Path: <linux-fsdevel+bounces-75965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DSGKEAifWnGQQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 22:27:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1423EBEC90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 22:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 625F1300E3C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D99350A38;
	Fri, 30 Jan 2026 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A6Dcx9+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55F30275E;
	Fri, 30 Jan 2026 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769808444; cv=fail; b=h+m9UDf2lbquaTrHJpF4VltfjBahPDRhKLnK41T5ngFq9KgquKJYrsLWmsb/DDTGoECeO7od/QlHWWDy8dLa7zGVcxuooBGcfoP/dvOn/JU9T5HeVJsmf75S8CkV5lY9FgbxcQBgYVtvhyD5MwWuiFL0q8gIGDL1YZ6CC8q3LL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769808444; c=relaxed/simple;
	bh=iHCt8ZDZEV+YhFzBwfAaDzEBhFF5AO3FydMjqrpF6rU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=tELu4P9XTjv69QsEwwjh0+PEKr75sDIbOrvwYXZr/5OYSnBEhorN978jj0sqpRS9AFYEF7v5detyfoA4iG4htW4AhL5Uj6Wv/fZal4iFVJ4CjSfIroTbmLbtPsYULgh8UAOUSXOGwLhScLjJGbnf42wh4/6hYunmMW9q8d+uJzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A6Dcx9+N; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzPRFlCclvSd4SiQLdNFKRG+BLSw8TY9kKI8jDgBXSLUh+36IZsmLP7qBLkuTCRGv3o0yAZBksnUovrYHFswDap1KPJgU2Ys7RvTNI42pZAOFjdghXzr3lYQDr6mTWbJWdsoK3Q81IHn1NK+Hw6ibxIdYG1HZJKi/E8i5pAbKGxUSFAF3Omu0eSl4qQa5o5Kc/6yMPHCkvtaluMBDJVOfXyNUKtXEp9GhT03oohht0By89MMXHOt+y5IeYvW6fhTn+vgdy7uOz+4tabcMdHE8WV38NXEYPUo5uBEpo3l+aDlUIRnTbbkVr+EUqbYVICp3mUSh8/0xJNEL0+j18QURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeE5xBdpqkvYUrIwUVkEr8YVjkH/UKlkvp2aSwkXq7s=;
 b=Y3C7rvsoazYT/HGeyKflbP/cgJya6FHPFhZLWzp8t3GHzLfiKQSgfjUmfimAClFhuoYyDycEf7ZLDdIB07hjdFiyJOq3Eoqrn1uYA8eJetCj/ty87hvhaFgPcgEY+nZerDlWlPGzIwl4DsjpBhdLAj20tk3BfGzLDq5WHBQ256gARQWruPjSE/3Au0DqnoDozkYX/aXGdfLjhXDM0lc5i8RFK8gwa6uxPYrL3nQcxRVJffHD2bUU0wV4H/NqA0fcW3qMOS6klNho6qDlYIC5j8bGsOGmGVVrCuAoZBNJZCblaEJhg7/5jjXJU/IXZTlzc+yl0igYhqtwZDHQgUIS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeE5xBdpqkvYUrIwUVkEr8YVjkH/UKlkvp2aSwkXq7s=;
 b=A6Dcx9+NMXmCUtYBi5M0xO8p0nXe1BmBuGqpcSjelageGOg4ymbKqfy+3CQoGFuJlD0bM4iPnCV2CBETUchXycw3DkKUuNMyPa/yB2pE4pF3+Xl1vvAf/OwcYBxYs5JPUmpGD6bm5ZQdOmd8hiiMdD/Gg+46Y6OBH260mabY4Us=
Received: from BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Fri, 30 Jan
 2026 21:27:14 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::ed) by BY3PR05CA0013.outlook.office365.com
 (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 21:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 21:27:14 +0000
Received: from [10.236.189.18] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 15:27:13 -0600
Message-ID: <c1d7d137-b7c2-4713-8ca4-33b6bc2bea2b@amd.com>
Date: Fri, 30 Jan 2026 15:27:12 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 8/9] cxl/core: Add dax_kmem_region and sysram_region
 drivers
To: Gregory Price <gourry@gourry.net>, <linux-mm@kvack.org>
CC: <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <kernel-team@meta.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <willy@infradead.org>,
	<jack@suse.cz>, <terry.bowman@amd.com>, <john@jagalactic.com>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-9-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20260129210442.3951412-9-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c5cc20-89b4-4bb9-1d6b-08de60465631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG5DM1VLbzlWV0JJS3BuVFB1Z0czRjlCaTJyNjExYUNodTJRRmtWRzIvcmJk?=
 =?utf-8?B?NlNSK0RUNmI1aE8rdEhpOEo3VjM4TkRIaytOWnN5RFlPTm9kbHNYQ1lId21Y?=
 =?utf-8?B?VTR2REo3WjhqWGVuNzJ0K2kvSSs2Q3hVM01vS091aFU0MUhIQ2IvQmtmb2ZB?=
 =?utf-8?B?eVV0LzhTN2s0ZXdyeDd1by9KeWlkV3ZnSzVvSmtsMnRnRWxIanNNTDN6NFdz?=
 =?utf-8?B?ZXJib0R5Qmp2SkVRSVY1aW4xWnVDUW05dzV2N3JGbVFzUU1USmxLTjNaRlVl?=
 =?utf-8?B?WEUxY2JLYWZRYXVvNk8vbkUxNHRmNmZvTlhOLzdHSURDUnBxaTYvdXY0dVVa?=
 =?utf-8?B?NDlBVjM3cDhUUHNkMDE4bFpQQ25WbTdMLzhaekhuOGE3U3Vxckl0cGgrYWF1?=
 =?utf-8?B?VE5wWldITjFBK0cvQmZwS1hDN3BxSVdHRU9iTk9NaGp3c3l2RWI5dkpHMG9V?=
 =?utf-8?B?SngrWjRnNWZUSkVoSnh5cDRFcWVUd0NPVXAxZ3lORTZKdTNmdmlyRHduMmxl?=
 =?utf-8?B?dGFmVHpIZVBQdGFRdzlMVjNnc1FMS2lkajIwNVYwS1UxTHYzbjQrTXlQWi9M?=
 =?utf-8?B?c3FiQXhyMjh5aGdxbkZnUmluSVMwZkZ5ZWp1bWk3ZWpSZHJQQXYrMXpEMWpE?=
 =?utf-8?B?aW4zcm5JOWlOSUFWbXFiSEttbXYrakFyZTMvYTMvbmpWRjhpT3MwVFJubHR4?=
 =?utf-8?B?MmFEMzUydnlKMzJQMjJaUERPTC9YMG55dmpDRlorRG9PQ2FkS203Yi92SHll?=
 =?utf-8?B?dkpkSVA4c0FLclFGMXpNbTVWbHllVk1qWURuQzUzSmlEU0p6SHI3YXJsK29m?=
 =?utf-8?B?Um5ncEt3REZ6RGt2dXFJeXVtT0NlVW9kRWYySGoraERBSlIwdnhRMU0rUTRp?=
 =?utf-8?B?cmFnZE5ucENBRmRBZHBWV0VlbmU4OGdIZXVRUFp6UzNaV0x6ZVN6QWd6Qmd6?=
 =?utf-8?B?RlNhZnhKUHhPY0pLZE9mbVJFdWlPSXk2d2VLMmV4SS9CNVJQUkpNNFRHN254?=
 =?utf-8?B?NC9YSDZlalZXaDdSeVNCU3kvdU9ITUs3d1ZBOGpORXB3RWsybmNCUDg5TDJM?=
 =?utf-8?B?N1VKbFR4bEJpUGVnMElFdm1qOXk0aExQb1pRMDVHRXhHVnpTU1N1b0pHZi9D?=
 =?utf-8?B?V2RYRE05UVdLS0NrTFU2MDlITytUZDc4VWFLcksvRGpNYUp4NjdURVRCbUhy?=
 =?utf-8?B?QkRXbUloSUx3OW1GbW9RYktvZ1lReDIrendncDhkc25Na0UrbUNBbXptOWtD?=
 =?utf-8?B?RUhwWjF4bkNpZTg5T2ZQVUNwUElkUUV6eUdONWhQellMczZRWE5sZ2hSV2Fw?=
 =?utf-8?B?UXNxMC9KQ2lMSVVxa2laY2NZUFVaSlIwOUoySmIxOGpmeFltZk5ESkJ3Rm5H?=
 =?utf-8?B?bjVKb3FJTUtJYm92UHZTVTB1ckRrbC9ERjFZMEh0Q0kyYkxSTFRkT2NGbDdi?=
 =?utf-8?B?RlR2RWttMzBQejhqc3F2OVQ5dHlqQmU2SnJWeEJpMDMzYW5ld3dESVhRbEZ6?=
 =?utf-8?B?Y3pvb0pzdHlLQjVOZmtPVitRd3gwZGxNMWxLWmJ2MWV1b1d6S25EZnh3Y3RM?=
 =?utf-8?B?N0hFS3lkSm9HK3dHYTlmQ05jNVIva0pFb2FDUlJkOWV4TmVHbzhaNWFVN1VM?=
 =?utf-8?B?SVQ2bmdMbFFpK09mVUc1Q0grd2JlazNhK2pzdVBIaW9VNVg5bnZJUThwQkpw?=
 =?utf-8?B?SjNyNHc4RDJwTE5tNzZBcUpBSGtOSlFvQW54dzFJaHpYdDFuZ2p6QmRNeXF6?=
 =?utf-8?B?L2xpcDJoT0pRZEtleDVvMEhJWEJySmxiTmcrRE1uRmxJbnNPc3F4MnZyeDJC?=
 =?utf-8?B?bElRT1RKZ09xRTBma0o1SG5RM0liVll3N3FzY0Y0eUlsVXRWM25McUpKK3Bt?=
 =?utf-8?B?MEUreVo5d3M1alhwRTRvWHRCcFZ5MFFMb0ZZc1VWZUpwYVVpNnFmMmFqNnl5?=
 =?utf-8?B?c0pCNzZTLzZEZGpDTkZzL3lTODN6Qzl5Tjh2dnloMlVjVnhSellyNE1YMDli?=
 =?utf-8?B?VzRPZlNrd3AvTHY2RDFHd2Q4Q2lmNE5hWDYvY3RwWDV4WC9uQ3RYRnhhMllu?=
 =?utf-8?B?cEtFZEp3MEdpUjN6ODQ5USs4R1k1dk9Kc2VQVzU4U0VOU0I2MWhMU29XbVlI?=
 =?utf-8?B?a05Kd24vdXRzdWxHQ3VpM29wYk5nQkcwbVFZenpRTDNpdHNHbHg0UEpCUU53?=
 =?utf-8?B?Zm42NXAwSkw5WStqMjRSYTBmbTh1Y2xwek1tam9mRjNkZ1NnaVhHb1FWcXo2?=
 =?utf-8?B?Zzk0MitpK05XQ1hvcGNaVys5Mm9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7LGzZh3W7vcDDvHD6msv73PypWRz6XkDJEhE3TJ2IrTKn9vEM/0xPHgSz3R8gWBLCeTtOyz7gpsMRa0x+F1z7b/MiO3vsF4lMKQ+PGb9Y7jDQOl1zS4jaynrgxIpQYS8YVDQsM1hmKihU78/ynUcoW3A1BzX/g/wHJY2bbNY6G3F9/7iuQbXHmp493u0D4pKSisvve8XMfUi/n47toLPLhNz3+c7BQYBwbEL0YSMyniNBUR0mq+4zduNKyGhrxojQenau5GWXlD2Mce7HF/74Lv3HH81VTBYcsztesnZn+vmWrMsviWfu20fQYlOVMubPpFmLJ5EYEe6/w4PpZZLL5+pBPLj35vqiPQNNaEnErX/SxQ2nBxbGZ8EafBkSIBa2S2PvZD6s+O86Rr2G3XvCxzRjVA4rFAgQrEbK1Bg/FD2A5Tepfb4AuACWJQ8HzC6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 21:27:14.2413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c5cc20-89b4-4bb9-1d6b-08de60465631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75965-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 1423EBEC90
X-Rspamd-Action: no action

On 1/29/2026 3:04 PM, Gregory Price wrote:
> In the current kmem driver binding process, the only way for users
> to define hotplug policy is via a build-time option, or by not
> onlining memory by default and setting each individual memory block
> online after hotplug occurs.  We can solve this with a configuration
> step between region-probe and dax-probe.
> 
> Add the infrastructure for a two-stage driver binding for kmem-mode
> dax regions. The cxl_dax_kmem_region driver probes cxl_sysram_region
> devices and creates cxl_dax_region with dax_driver=kmem.
> 
> This creates an interposition step where users can configure policy.
> 
> Device hierarchy:
>   region0 -> sysram_region0 -> dax_region0 -> dax0.0

This technically comes up in the devdax_region driver patch first, but I noticed it here
so this is where I'm putting it:

I like the idea here, but the implementation is all off. Firstly, devm_cxl_add_sysram_region()
is never called outside of sysram_region_driver::probe(), so I'm not sure how they ever get
added to the system (same with devdax regions).

Second, there's this weird pattern of adding sub-region (sysram, devdax, etc.) devices being added
inside of the sub-region driver probe. I would expect the devices are added then the probe function
is called. What I think should be going on here (and correct me if I'm wrong) is:
	1. a cxl_region device is added to the system
	2. cxl_region::probe() is called on said device (one in cxl/core/region.c)
	3. Said probe function figures out the device is a dax_region or whatever else and creates that type of region device
	(i.e. cxl_region::probe() -> device_add(&cxl_sysram_device))
	4. if the device's dax driver type is DAXDRV_DEVICE_TYPE it gets sent to the daxdev_region driver
	5a. if the device's dax driver type is DAXDRV_KMEM_TYPE it gets sent to the sysram_region driver which holds it until
	the online_type is set
	5b. Once the online_type is set, the device is forwarded to the dax_kmem_region driver? Not sure on this part

What seems to be happening is that the cxl_region is added, all of these region drivers try
to bind to it since they all use the same device id (CXL_DEVICE_REGION) and the correct one is
figured out by magic? I'm somewhat confused at this point :/.

> 
> The sysram_region device exposes a sysfs 'online_type' attribute
> that allows users to configure the memory online type before the
> underlying dax_region is created and memory is hotplugged.
> 
>   sysram_region0/online_type:
>       invalid:        not configured, blocks probe
>       offline:        memory will not be onlined automatically
>       online:         memory will be onlined in ZONE_NORMAL
>       online_movable: memory will be onlined in ZONE_MMOVABLE
> 
> The device initializes with online_type=invalid which prevents the
> cxl_dax_kmem_region driver from binding until the user explicitly
> configures a valid online_type.
> 
> This enables a two-step binding process:
>   echo region0 > cxl_sysram_region/bind
>   echo online_movable > sysram_region0/online_type
>   echo sysram_region0 > cxl_dax_kmem_region/bind
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  21 +++
>  drivers/cxl/core/Makefile               |   1 +
>  drivers/cxl/core/core.h                 |   6 +
>  drivers/cxl/core/dax_region.c           |  50 +++++++
>  drivers/cxl/core/port.c                 |   2 +
>  drivers/cxl/core/region.c               |  14 ++
>  drivers/cxl/core/sysram_region.c        | 180 ++++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |  25 ++++
>  8 files changed, 299 insertions(+)
>  create mode 100644 drivers/cxl/core/sysram_region.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c80a1b5a03db..a051cb86bdfc 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -624,3 +624,24 @@ Description:
>  		The count is persistent across power loss and wraps back to 0
>  		upon overflow. If this file is not present, the device does not
>  		have the necessary support for dirty tracking.
> +
> +
> +What:		/sys/bus/cxl/devices/sysram_regionZ/online_type
> +Date:		January, 2026
> +KernelVersion:	v7.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RW) This attribute allows users to configure the memory online
> +		type before the underlying dax_region engages in hotplug.
> +
> +		Valid values:
> +		  'invalid': Not configured (default). Blocks probe.

This should be removed from the valid values section since it's not a valid value
to write to the attribute. The mention of the default in the paragraph below should
be enough.

> +		  'offline': Memory will not be onlined automatically.
> +		  'online' : Memory will be onlined in ZONE_NORMAL.
> +		  'online_movable': Memory will be onlined in ZONE_MOVABLE.
> +
> +		The device initializes with online_type='invalid' which prevents
> +		the cxl_dax_kmem_region driver from binding until the user
> +		explicitly configures a valid online_type. This enables a
> +		two-step binding process that gives users control over memory
> +		hotplug policy before memory is added to the system.
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 36f284d7c500..faf662c7d88b 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -18,6 +18,7 @@ cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_REGION) += dax_region.o
> +cxl_core-$(CONFIG_CXL_REGION) += sysram_region.o
>  cxl_core-$(CONFIG_CXL_REGION) += pmem_region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index ea4df8abc2ad..04b32015e9b1 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -26,6 +26,7 @@ extern struct device_attribute dev_attr_delete_region;
>  extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
>  extern const struct device_type cxl_dax_region_type;
> +extern const struct device_type cxl_sysram_region_type;
>  extern const struct device_type cxl_region_type;
>  
>  int cxl_decoder_detach(struct cxl_region *cxlr,
> @@ -37,6 +38,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
>  #define CXL_PMEM_REGION_TYPE(x) (&cxl_pmem_region_type)
>  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
> +#define CXL_SYSRAM_REGION_TYPE(x) (&cxl_sysram_region_type)
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
>  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> @@ -44,9 +46,12 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
>  int devm_cxl_add_dax_region(struct cxl_region *cxlr, enum dax_driver_type);
> +int devm_cxl_add_sysram_region(struct cxl_region *cxlr);
>  int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
>  
>  extern struct cxl_driver cxl_devdax_region_driver;
> +extern struct cxl_driver cxl_dax_kmem_region_driver;
> +extern struct cxl_driver cxl_sysram_region_driver;
>  
>  #else
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> @@ -81,6 +86,7 @@ static inline void cxl_region_exit(void)
>  #define SET_CXL_REGION_ATTR(x)
>  #define CXL_PMEM_REGION_TYPE(x) NULL
>  #define CXL_DAX_REGION_TYPE(x) NULL
> +#define CXL_SYSRAM_REGION_TYPE(x) NULL
>  #endif
>  
>  struct cxl_send_command;
> diff --git a/drivers/cxl/core/dax_region.c b/drivers/cxl/core/dax_region.c
> index 391d51e5ec37..a379f5b85e3d 100644
> --- a/drivers/cxl/core/dax_region.c
> +++ b/drivers/cxl/core/dax_region.c
> @@ -127,3 +127,53 @@ struct cxl_driver cxl_devdax_region_driver = {
>  	.probe = cxl_devdax_region_driver_probe,
>  	.id = CXL_DEVICE_REGION,
>  };
> +
> +static int cxl_dax_kmem_region_driver_probe(struct device *dev)
> +{
> +	struct cxl_sysram_region *cxlr_sysram = to_cxl_sysram_region(dev);
> +	struct cxl_dax_region *cxlr_dax;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	if (!cxlr_sysram)
> +		return -ENODEV;
> +
> +	/* Require explicit online_type configuration before binding */
> +	if (cxlr_sysram->online_type == -1)
> +		return -ENODEV;
> +
> +	cxlr = cxlr_sysram->cxlr;
> +
> +	cxlr_dax = cxl_dax_region_alloc(cxlr);
> +	if (IS_ERR(cxlr_dax))
> +		return PTR_ERR(cxlr_dax);

You can use cleanup.h here to remove the goto's (I think). Following should work:

#DEFINE_FREE(cxlr_dax_region_put, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&cxlr_dax->dev))
static int cxl_dax_kmem_region_driver_probe(struct device *dev)
{
	...

	struct cxl_dax_region *cxlr_dax __free(cxlr_dax_region_put) = cxl_dax_region_alloc(cxlr);
	if (IS_ERR(cxlr_dax))
		return PTR_ERR(cxlr_dax);

	...

	rc = dev_set_name(&cxlr_dax->dev, "dax_region%d", cxlr->id);
	if (rc)
		return rc;

	rc = device_add(&cxlr_dax->dev);
	if (rc)
		return rc;

	dev_dbg(dev, "%s: register %s\n", dev_name(dev), dev_name(&cxlr_dax->dev));

	return devm_add_action_or_reset(dev, cxlr_dax_unregister, no_free_ptr(cxlr_dax));
}
> +
> +	/* Inherit online_type from parent sysram_region */
> +	cxlr_dax->online_type = cxlr_sysram->online_type;
> +	cxlr_dax->dax_driver = DAXDRV_KMEM_TYPE;
> +
> +	/* Parent is the sysram_region device */
> +	cxlr_dax->dev.parent = dev;
> +
> +	rc = dev_set_name(&cxlr_dax->dev, "dax_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(&cxlr_dax->dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(dev, "%s: register %s\n", dev_name(dev),
> +		dev_name(&cxlr_dax->dev));
> +
> +	return devm_add_action_or_reset(dev, cxlr_dax_unregister, cxlr_dax);
> +err:
> +	put_device(&cxlr_dax->dev);
> +	return rc;
> +}
> +
> +struct cxl_driver cxl_dax_kmem_region_driver = {
> +	.name = "cxl_dax_kmem_region",
> +	.probe = cxl_dax_kmem_region_driver_probe,
> +	.id = CXL_DEVICE_SYSRAM_REGION,
> +};
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 3310dbfae9d6..dc7262a5efd6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -66,6 +66,8 @@ static int cxl_device_id(const struct device *dev)
>  		return CXL_DEVICE_PMEM_REGION;
>  	if (dev->type == CXL_DAX_REGION_TYPE())
>  		return CXL_DEVICE_DAX_REGION;
> +	if (dev->type == CXL_SYSRAM_REGION_TYPE())
> +		return CXL_DEVICE_SYSRAM_REGION;
>  	if (is_cxl_port(dev)) {
>  		if (is_cxl_root(to_cxl_port(dev)))
>  			return CXL_DEVICE_ROOT;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6200ca1cc2dd..8bef91dc726c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3734,8 +3734,20 @@ int cxl_region_init(void)
>  	if (rc)
>  		goto err_dax;
>  
> +	rc = cxl_driver_register(&cxl_sysram_region_driver);
> +	if (rc)
> +		goto err_sysram;
> +
> +	rc = cxl_driver_register(&cxl_dax_kmem_region_driver);
> +	if (rc)
> +		goto err_dax_kmem;
> +
>  	return 0;
>  
> +err_dax_kmem:
> +	cxl_driver_unregister(&cxl_sysram_region_driver);
> +err_sysram:
> +	cxl_driver_unregister(&cxl_devdax_region_driver);
>  err_dax:
>  	cxl_driver_unregister(&cxl_region_driver);
>  	return rc;
> @@ -3743,6 +3755,8 @@ int cxl_region_init(void)
>  
>  void cxl_region_exit(void)
>  {
> +	cxl_driver_unregister(&cxl_dax_kmem_region_driver);
> +	cxl_driver_unregister(&cxl_sysram_region_driver);
>  	cxl_driver_unregister(&cxl_devdax_region_driver);
>  	cxl_driver_unregister(&cxl_region_driver);
>  }
> diff --git a/drivers/cxl/core/sysram_region.c b/drivers/cxl/core/sysram_region.c
> new file mode 100644
> index 000000000000..5665db238d0f
> --- /dev/null
> +++ b/drivers/cxl/core/sysram_region.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 Meta Platforms, Inc. All rights reserved. */
> +/*
> + * CXL Sysram Region - Intermediate device for kmem hotplug configuration
> + *
> + * This provides an intermediate device between cxl_region and cxl_dax_region
> + * that allows users to configure memory hotplug parameters (like online_type)
> + * before the underlying dax_region is created and memory is hotplugged.
> + */
> +
> +#include <linux/memory_hotplug.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_sysram_region_release(struct device *dev)
> +{
> +	struct cxl_sysram_region *cxlr_sysram = to_cxl_sysram_region(dev);
> +
> +	kfree(cxlr_sysram);
> +}
> +
> +static ssize_t online_type_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_sysram_region *cxlr_sysram = to_cxl_sysram_region(dev);
> +
> +	switch (cxlr_sysram->online_type) {
> +	case MMOP_OFFLINE:
> +		return sysfs_emit(buf, "offline\n");
> +	case MMOP_ONLINE:
> +		return sysfs_emit(buf, "online\n");
> +	case MMOP_ONLINE_MOVABLE:
> +		return sysfs_emit(buf, "online_movable\n");
> +	default:
> +		return sysfs_emit(buf, "invalid\n");
> +	}
> +}
> +
> +static ssize_t online_type_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t len)
> +{
> +	struct cxl_sysram_region *cxlr_sysram = to_cxl_sysram_region(dev);
> +
> +	if (sysfs_streq(buf, "offline"))
> +		cxlr_sysram->online_type = MMOP_OFFLINE;
> +	else if (sysfs_streq(buf, "online"))
> +		cxlr_sysram->online_type = MMOP_ONLINE;
> +	else if (sysfs_streq(buf, "online_movable"))
> +		cxlr_sysram->online_type = MMOP_ONLINE_MOVABLE;
> +	else
> +		return -EINVAL;
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(online_type);
> +
> +static struct attribute *cxl_sysram_region_attrs[] = {
> +	&dev_attr_online_type.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group cxl_sysram_region_attribute_group = {
> +	.attrs = cxl_sysram_region_attrs,
> +};
> +
> +static const struct attribute_group *cxl_sysram_region_attribute_groups[] = {
> +	&cxl_base_attribute_group,
> +	&cxl_sysram_region_attribute_group,
> +	NULL,
> +};
> +
> +const struct device_type cxl_sysram_region_type = {
> +	.name = "cxl_sysram_region",
> +	.release = cxl_sysram_region_release,
> +	.groups = cxl_sysram_region_attribute_groups,
> +};
> +
> +static bool is_cxl_sysram_region(struct device *dev)
> +{
> +	return dev->type == &cxl_sysram_region_type;
> +}
> +
> +struct cxl_sysram_region *to_cxl_sysram_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_cxl_sysram_region(dev),
> +			  "not a cxl_sysram_region device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_sysram_region, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(to_cxl_sysram_region, "CXL");
> +
> +static struct lock_class_key cxl_sysram_region_key;
> +
> +static struct cxl_sysram_region *cxl_sysram_region_alloc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_sysram_region *cxlr_sysram;
> +	struct device *dev;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return ERR_PTR(-ENXIO);
> +
> +	cxlr_sysram = kzalloc(sizeof(*cxlr_sysram), GFP_KERNEL);
> +	if (!cxlr_sysram)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlr_sysram->hpa_range.start = p->res->start;
> +	cxlr_sysram->hpa_range.end = p->res->end;
> +	cxlr_sysram->online_type = -1;  /* Require explicit configuration */
> +
> +	dev = &cxlr_sysram->dev;
> +	cxlr_sysram->cxlr = cxlr;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_sysram_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_sysram_region_type;
> +
> +	return cxlr_sysram;
> +}
> +
> +static void cxlr_sysram_unregister(void *_cxlr_sysram)
> +{
> +	struct cxl_sysram_region *cxlr_sysram = _cxlr_sysram;
> +
> +	device_unregister(&cxlr_sysram->dev);
> +}
> +
> +int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_sysram_region *cxlr_sysram;
> +	struct device *dev;
> +	int rc;
> +
> +	cxlr_sysram = cxl_sysram_region_alloc(cxlr);
> +	if (IS_ERR(cxlr_sysram))
> +		return PTR_ERR(cxlr_sysram);

Same thing as above

Thanks,
Ben

> +
> +	dev = &cxlr_sysram->dev;
> +	rc = dev_set_name(dev, "sysram_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +		dev_name(dev));
> +
> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_sysram_unregister,
> +					cxlr_sysram);
> +err:
> +	put_device(dev);
> +	return rc;
> +}
> +
> +static int cxl_sysram_region_driver_probe(struct device *dev)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +	/* Only handle RAM regions */
> +	if (cxlr->mode != CXL_PARTMODE_RAM)
> +		return -ENODEV;
> +
> +	return devm_cxl_add_sysram_region(cxlr);
> +}
> +
> +struct cxl_driver cxl_sysram_region_driver = {
> +	.name = "cxl_sysram_region",
> +	.probe = cxl_sysram_region_driver_probe,
> +	.id = CXL_DEVICE_REGION,
> +};
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 674d5f870c70..1544c27e9c89 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -596,6 +596,25 @@ struct cxl_dax_region {
>  	enum dax_driver_type dax_driver;
>  };
>  
> +/**
> + * struct cxl_sysram_region - CXL RAM region for system memory hotplug
> + * @dev: device for this sysram_region
> + * @cxlr: parent cxl_region
> + * @hpa_range: Host physical address range for the region
> + * @online_type: Memory online type (MMOP_* 0-3, or -1 if not configured)
> + *
> + * Intermediate device that allows configuration of memory hotplug
> + * parameters before the underlying dax_region is created. The device
> + * starts with online_type=-1 which prevents the cxl_dax_kmem_region
> + * driver from binding until the user explicitly sets online_type.
> + */
> +struct cxl_sysram_region {
> +	struct device dev;
> +	struct cxl_region *cxlr;
> +	struct range hpa_range;
> +	int online_type;
> +};
> +
>  /**
>   * struct cxl_port - logical collection of upstream port devices and
>   *		     downstream port devices to construct a CXL memory
> @@ -890,6 +909,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  #define CXL_DEVICE_PMEM_REGION		7
>  #define CXL_DEVICE_DAX_REGION		8
>  #define CXL_DEVICE_PMU			9
> +#define CXL_DEVICE_SYSRAM_REGION	10
>  
>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>  #define CXL_MODALIAS_FMT "cxl:t%d"
> @@ -907,6 +927,7 @@ bool is_cxl_pmem_region(struct device *dev);
>  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
> +struct cxl_sysram_region *to_cxl_sysram_region(struct device *dev);
>  u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
> @@ -925,6 +946,10 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>  {
>  	return NULL;
>  }
> +static inline struct cxl_sysram_region *to_cxl_sysram_region(struct device *dev)
> +{
> +	return NULL;
> +}
>  static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
>  					       u64 spa)
>  {


