Return-Path: <linux-fsdevel+bounces-77322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMVOFmijk2kn7QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:08:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D9148057
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 00:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A229301C174
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 23:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626F52C11FE;
	Mon, 16 Feb 2026 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2oMTVMl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911E017993;
	Mon, 16 Feb 2026 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771283291; cv=fail; b=hJayB3h3EoDi6bVjFeOSxz8C9dj6ZcYpBVxhkDLX0LjVwh+ctagbx6CyyynJmG1zt+fmknwI7TkXbf/AcdMtlTUojfN6Z5Np/FfZ9giw+I6WN1lLuRlWpwiwn7+PkI70I0m8JrDISzyKreXrZ8k2WG6T/SJzuzpmHtxNQwiR484=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771283291; c=relaxed/simple;
	bh=97uROQ8Y6qj0oq+BwZhWvpTEvLgREDkwuRIOWnU3LXE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c43+o6J85hQSowetUWmkn3cVGWcmmJqs7SJgbdgn+dQBqHD1XEZyE+OR0xTawDhfWLylVrYmByJH3YY/J8VutXZ62wftlA+lEDmyjKvHN6M/i9Lfq6qg+ABwWAA9skbtUZdhCtFMbvSVDhodlM/Ju7y8i8w5I4ipZtaLfVGDepo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2oMTVMl; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak6/A+cfRCwXoMSbQa/8XGvmk3uWbMMLCTrCQkKwQXNUkge1xOPolMJIKSI3n9bKmV++zxQbHav3LLd2taXCR8a2nS3MNiChKtllSUJn/1/qIBYr1aryCw48x69l3U+ZIao/1x/fDBdEpVLfa22r4ZnhseFGxA9gllRJ5wxM5Ljw0Vf7CFsDv6rqmFys+sEHaYt+Qv2M5H3FSxPNV5pTRJZ0ySrbtMVKMb7n0tDwKGYOqvLsGi896FlD2P4jkppSn+u/IaUNdk65I3f/EQJhTEv2Oy/75ioLCNNpdcbJvr0Lv/T7nIBZiEzWymscWHhQZd7rkGP3I6lTwYV5efQyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G9gz7Ljfmc1VNZla3l7zPoahrJD3eH99MSZjoT3Ags=;
 b=OUfCiFT+hXGP4PCBvovBLAVgYVZvl4f4QvAiIXy55pPtRrmlV6br7r3j3vu+fDrfyNrOotuVkwiBHU9+sjT3i3r4SxCQXRv3rv3OApvYqGK1WllttJzWEAcF3HiEWJdkLPg2YFSPurINax2aMw8iUtsCs6S2woATZbOUK4ja9jZs2Zb/h1ZzbdlqzUSxjmoMOGkInt6uWH2IygRp3920+1KJ+2+mXJ3SzcFA5fsG3R4WqsMwNpYWt5nK6Q6NQyeKTlKtWVdVj93rjgCNID6UfDEd+liaDfYHgHBZCoYgg1FLrm9W/YikApN2fd3iH1dN0HW5A61dpLxB3X55epoQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G9gz7Ljfmc1VNZla3l7zPoahrJD3eH99MSZjoT3Ags=;
 b=h2oMTVMlixVLhr1T4+XIk+AXvMWWTDQngh8q0aM8wv2BVtr8Y9Dxj4cWTuUn9UZ5ClImJZ4zct2O2DB676t6HXLFlW0ULWAw288f8QZ0Kcf3h6EsdGvfV1I9oLEbPdC/iPUpoI4hsKKzYaqD9Qxv/4LhDJUrbLt6EhBTkwr5zmc=
Received: from MN2PR16CA0066.namprd16.prod.outlook.com (2603:10b6:208:234::35)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 23:08:07 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::26) by MN2PR16CA0066.outlook.office365.com
 (2603:10b6:208:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 23:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 23:08:06 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 17:07:48 -0600
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c8907e-7de4-494e-36d6-08de6db03eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|30052699003|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a212MUhFaHp2VWtDWUtobytTaDFyWDcyOTluaFpMaEl2cDA2czJIY05CWVND?=
 =?utf-8?B?ODN6TUZ1TzNjMGRaT0tFV3ZMZDRDWnZwY1ZRTUZORkxBZDdzQm5VMGlKeklW?=
 =?utf-8?B?SVFBTWFIakljMEZ2VS90bDgyT1hxZGJmNGdxL2FIeXlTamdlZG5ST1Y2Zmtr?=
 =?utf-8?B?YjJ2VVFhNmhlb2JzMnJCSjgwVjdtY3gwbk4xTmE5ak15RERKRWRzQURHTEdR?=
 =?utf-8?B?S09PL051d2pmVTZSdXNjTFNhcEZlalM1RFZSZUZDM1NRemltRW9NSEVZY0JQ?=
 =?utf-8?B?SzNDK3kzbStLcTJyZlArTytXNjdMdSsrOGV1TE1PNXJLVFJOYTdueEVLQTJY?=
 =?utf-8?B?bHQ4aFhaS1VuK1Fod3duSXR0eWRwZUhKNWQyTnBWSktjNXhaUVdtTUdDQldB?=
 =?utf-8?B?RkJoNmQrMEE1ZVIybXVTU2FkRmMyeWJMaEc1T1UrWlA1SEhmTTJQNkZJdldz?=
 =?utf-8?B?ckZMRkVNRHRETmU3UE5sUGs0b2dmbktERE10a3RQR2hWSWR2NHRNSUdRUnk1?=
 =?utf-8?B?NTFUOXFtRDltd2twcGpHMUpIRTFGU1ZiRm5XOCtSMWhRdGorbG1DUUdsODRM?=
 =?utf-8?B?VEp6ZDZBQXoyd29HVXNzcU56aFJWVzk0enIrazVMU3RZYTd1ZmkrVnJ1bVp1?=
 =?utf-8?B?OGdCVGRIUWV3OCtCZDdDOVozenliT0ZFM0E3OFdlRDFrbkFEb1ZlM2lhZ0NI?=
 =?utf-8?B?bmVvRWtFZWZPdWlmbmxmR3JBVUxhcE1HSkpVZWN3NTV6eWdWdmw5bGE3eUNz?=
 =?utf-8?B?RDJoUENiZmIwOGVFVHlHdkh6NUVUOU93cThWTmNkRGYzck0yekRGcVFVZ21m?=
 =?utf-8?B?aktzNWU5NkVLM3U2djEzbHBqOHJBd0pjakl4cTUrNE10Yk9uS0YzZkNhNk1w?=
 =?utf-8?B?Ung3WGRwbjhLVzRRcWNUYXhXcEZoNWZIM21ZQ1kvbkFheWM3NzNCWFNrMlFq?=
 =?utf-8?B?eWFMMEdneFQ0ajBRK0h5cWN5a0poSlk2ZS81QThYUy96TnRyRFhZYkdDQ3hB?=
 =?utf-8?B?T0x1NXlDa0NQOUVhM0czZ2hDK2dxd2RKK25aTFVhVmFld1BOVGlKMzltV0hH?=
 =?utf-8?B?Z2lKcGZhcC9Wa1QwZ05iRml5S3lqNS9TeEtLZVc5ai9UWmQrdVpjN1licVhl?=
 =?utf-8?B?RlFrS1NTVEsvSUs5ZE5Zc3lYZ3duOVNwVkpDYzdXSGNxb0V0Ulh3d2lrY25G?=
 =?utf-8?B?VU5Ra0pMZklGOTh5bmh6UTNVWUwwbm1WdEFGNnJuL0F5MXZQSXVXeFljNVB1?=
 =?utf-8?B?cmF4eitYN1RlNFlPKzMvU0FVaUE0NnpMVjVkMEJVblhlVWtpNENycGxoK3lx?=
 =?utf-8?B?b0ZEM1Y1WHFIMm9ENUg0MUZDWGcwQmpYUXhkR09KZTQzMUszb1FGWE9malFs?=
 =?utf-8?B?NjdnNzdkUlFCVDB1Z2NhTlovMldHMWMrQjdHT2RDZ0hOYk41eHdCTytvcERI?=
 =?utf-8?B?U3I0VTNFbXNGdGVjVDI0a1JQSWw4SERYRG5FWnB2YlNRQ05YVnBpbWtKYU93?=
 =?utf-8?B?clFzWW01Y0xzSjNBR2VqbVZuekd3U3pQVUJXNWN6eEZzeGJWT1M4OE1MOVp4?=
 =?utf-8?B?ZFRrMTYvVE80bWdUalNtODlRcTY5RnVLTHhIT1dYUHVmWEJvaEovSGQ5b1RR?=
 =?utf-8?B?c1p6cmhtUEQvZ3pKQTFwaWdiMjBxWjRoZmhIdnRIY0E1b0FNdkFuR0g1cTIw?=
 =?utf-8?B?ZzJkQm90ODczSVIwckMzQXhEa2JGSnNMZUc0bHRKSXBDR1cwT2tJcGxYNUx3?=
 =?utf-8?B?SlIwTXpNU0J2TDNNQk0yMkN5YjJPZzFCZ1ZocUFJNmZkYWd5UWZmWFk0NWIr?=
 =?utf-8?B?bmsxSTltbERuaG90bkdRdmV6bU9PY3VlSTRNR3pZamV6U2QzWFkrVDg3QXdU?=
 =?utf-8?B?M0NFSWhRaUorMHI2U0lINGRyTW8yU0h6dEczTWxHNTNrK0JhdG5hdmNTeG9u?=
 =?utf-8?B?Vk9QQmx0RFNuWXVpY0hWVFlscnhtU1RDVHhmcHJKeWJtM3ltVnJsRXZjTXlu?=
 =?utf-8?B?THViVU84NTEwVVRzTXhqakRZMTFYUCsyeFY1bEtqTHlYQXVTclVLYjArZ0Rq?=
 =?utf-8?B?WFh6ZEtmVm1FNVc5Wmp4a2hacUYrQ0tqN3lScmdFQVRYRXNLQkFjMjc0Z3lq?=
 =?utf-8?B?NVZzYmdoMStETWdvNkE3VkZsemR2VFdlUVBMamVQY0ZaUkdjRUxvUTF6bVRH?=
 =?utf-8?B?YVNEazA0WVI1clpkeDdWc2JpT3lVbUVVdUVPZUxSc3ZUK1RLWTRKd0dxdXVY?=
 =?utf-8?B?RnRPRms4UlphcmR3bUR0RS9QcGhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(30052699003)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ADu8qfkSJkjT+82bA94PIR3m5qKrLYeTrY2WGZwV8qvojldupWDSWgzdLhAFScBKdViE7djms5qu3ro4QUMe9BLog/97RMOuxQ1DDWhsR5pwzHabUFuT8MwAD3dvIDdyEg9m8GPUnBoKj5AIFeFWe/8f9TlQpr2KG4o1DG2rrKIxs0ojqeGUjMPcPg2jEw/Zsnuxy7ItG7W7mvepET4raFqQeUsWmJuz56ZJ74qX9lVVpWGvWeT8be59wlr9hgbfzksZJtOMGwutL7NK84W7EeypUG1rIbH4qyQYxFYKnIcQYbg0x104u04Mus6FB4LLZK7x05Sb630fiTGfUFI0t8s961AcIIEOxSk5SVg+GTM+R7hXc+KFrQWE5pS11Kg92x84kQ6OTC8Lmw2dmcR2zGUhAiD63r/R2hpiCnkViWdBp/iKQRpqnc1GrJgRc6tH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 23:08:06.8885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c8907e-7de4-494e-36d6-08de6db03eda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77322-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[CAEvNRgFmq8DP_=V7mrY8qza3i9h4-Bn0OWt72iDj6mELu+BiZg@mail.gmail.com];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.roth@amd.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B61D9148057
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


