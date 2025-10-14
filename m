Return-Path: <linux-fsdevel+bounces-64104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A48BD891C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 11:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B38224FD2C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CCC2E6CAA;
	Tue, 14 Oct 2025 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="tsyIoIXu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177A2EBDC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435426; cv=fail; b=tbvVKqHcHs8BhUMEResDf67N9n3ktPlYbArF6PlLm492M9f0tJVLuGulh049C2CtXwnB7Bjqm1PAx8SIqB5TsBtanwkvJqixSThElfFZkqvXMihvwrOFxlGtisOw2qys5BDHN2Lr2TgUYMIU39lMq2kiB7SCcGFHGS4C3XjbuY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435426; c=relaxed/simple;
	bh=dicHMKeENGvmJrk39OVHWoJee2HrlIiuXihOVEZIJg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=faZW+L6v252EZ0pc+I90CmQlR3ExpFI7wCfdoubreLQSRMQlanSTeNylJe0aiF7jph5NS9IStP+yfFWqupG9qyfFDVRfwB7B4XgaowEzFyvdcLfiNqfxRbsYPumBrI4NRfGs2+dmOqT1/Dk+gsPCQc5REbza9PlBumsHI18XQ7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=tsyIoIXu; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020127.outbound.protection.outlook.com [52.101.193.127]) by mx-outbound12-226.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 14 Oct 2025 09:49:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlKJU4P4sBPYFGvJ7+rr2JOa63LJnIbtfXvJraLJlnDBnYBDpZzFqXqFpTJCKTykscfKMgP8yEm63L6f6y/cZLdsraAtTWYJhcGW0ihUVuw4yVph4Ia4c9eefNe25tT+9NBhUBpWFKTIvDS6NhRhPlldx3U6oGw5PLfjfoPR4xB31DCwuwOw2Uui8Q2DdcU4o2bui0a4+k1/LOW6R/HNOMQvfCIiOdYbCegijZO0ppfoj4r91gB+ZD8YuY+ih+fTtR1JC6LUgtwW/9LSKA53tjXlEZZSv1RtdNhzJxUvfZykKKjxtT3lXi7iTEG09lBWMXofvpnwTgDbn9KdpDw4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcE6+gLH+7NGymqTnTsyjzD0hJn5BMyfetzHJ3OCcss=;
 b=B+S2Lndu5DJxDn37qz6xvftKXqXcsKJeP4m0GsvuK+dP5/bta4WIySuGkAeflMqBjvn4p+VMDjWLGG/Im+TN7RGzu6OEc5Q3BkNGUv/I5+W7rWr2JNtX7Alaub6R4pJbrcq8UD5ETl7xDAHIn0OYc2CO+zu+bt6KBkOsWM33LlwccWOyPi/ZeGqU/FueVUKkHojw2SDw4yU2relhLWgAbqlqi1ejM6iananzVwR/M1ZpJV7hL3Et8rfsw/uAYnZuvQf9lcjvRtbZ6RFI0RJKjbmxef86l+r6wsm8b2TmKvQr/55mFC2eeBpVCmPYALjwcuVuCfpGTsBk3BsvEPH+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=arm.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcE6+gLH+7NGymqTnTsyjzD0hJn5BMyfetzHJ3OCcss=;
 b=tsyIoIXuXnWzrzuDcXgn1deTnLDjh2XoEUzn7yrVKHX0QaGl3fwqre3meqLoIzFFOo8z8qEq5kHKRSg2H0Z15w3dPrIPMaC5INDxw2OQu4QEe84RlfIQGTz4Wf2b+O//RbGUOT4XXY7JzrDrpmHfQw9zTxS7uj5p3wsAgTabbdk=
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by DM4PR19MB6222.namprd19.prod.outlook.com (2603:10b6:8:ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 09:49:53 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::df) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 09:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Tue, 14 Oct 2025 09:49:51 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id B429563;
	Tue, 14 Oct 2025 09:49:50 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Tue, 14 Oct 2025 11:49:49 +0200
Subject: [PATCH v2] fuse: Wake requests on the same cpu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
X-B4-Tracking: v=1; b=H4sIALwc7mgC/3XMQQ6CMBCF4auQWTumRZHqynsYFm1nlImhkFZRQ
 3p3K3uX/0vet0DiKJzgVC0QeZYkYyhRbyrwvQ03RqHSUKu60Urv8GXvjMkOjH56omuJnHLqYAx
 D+UyRr/JevUtXupf0GONn5Wf9W/9Js0aN+4aMao6WiNszUdj6cYAu5/wFq+FLcqgAAAA=
X-Change-ID: 20251013-wake-same-cpu-b7ddb0b0688e
To: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, 
 linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760435390; l=5486;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=dicHMKeENGvmJrk39OVHWoJee2HrlIiuXihOVEZIJg8=;
 b=PO93hKLi+deuIUTs82VPlOKhCi3mmiQ8IusvOJGVDqBTjZ9kzPqIJ4XFsycf+XcCqu49I//RH
 TIyQd98NVXyAIBBIinnr4emSHGRqurMiXLFYyu6HdNgMnN1oZe0AxRM
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DM4PR19MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e581410-b6ce-4c47-7806-08de0b070584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTBRME5ieG84c0VHRzgrRG10KzdOL0VOdnRwTUtMWFkxSHZjZ1ptUFN4WURD?=
 =?utf-8?B?OUVaY2I1WE9XQXdNOGx1eGw3RVJ6Ujh6SVd5eWlhN1BrT240eHBzYVJEcEQ4?=
 =?utf-8?B?R1FXY2dkenRKVTdxemFEUVlxZ0Zib1ZsQkVsWWZURVB6L3VWV054TWF1dmha?=
 =?utf-8?B?ZFVzYi9VK21rRWdZTG15YnBleDZ1amYveDJZa1dTdmxiaTFXSlcwWUF5Z0Fi?=
 =?utf-8?B?bTM1Z2ZWSk9UMTQ1VXlWZWVlNERsRjJEVjQxRkw1VkVpL0YwL1drWUkzckp3?=
 =?utf-8?B?djdGSGRNank3V3BWb3V1VDY1Z2RwRHZ3Qm5vM3JQdzhPZ3pNZ3RwR0ZUUmVW?=
 =?utf-8?B?YmpVK2RTNTlhS2I5azRCZ243bzRTRHZRT1liUWJ6S05nMFdjZUJpWjlyVDlR?=
 =?utf-8?B?SWsxOW5tT3J5MlY1Rlg2bnExeCttQTZGcStkWDhQL0Vkd1lERVN3UDRpU0tD?=
 =?utf-8?B?RjlYUWttakFvVGcrc0t6WmdsUVZydTQ2SFc4U2RKQXJLZjB5VGV0dENFS0lv?=
 =?utf-8?B?RDJkRURueFk5S1JVcHNqdXBUNEczQXpiUGJ0R2l1a0FwR2t2MHMvZGF1SHBE?=
 =?utf-8?B?dXZDUHNNWXE0bUJCeUpqZU5rWGFMYXNTa0owZFpjTlU2Q3htbHZyUHdXSFRq?=
 =?utf-8?B?MFpmMkRQelhpOXlzMXBMc3g2N200WUJuZ0E3Y2Z6NTdJYm9HNi9UcDdrTERr?=
 =?utf-8?B?RjlpbjhBcDBlOXJoTmkzVFdoWmoxUFlnTzhoVmN3SVhQQU9KanptNXIzOXZ1?=
 =?utf-8?B?Y0xmT2VjYzZUc3oxNmZ3TEpaNUsrVFVqc0lYa3JpbEw3REtyQU9yZEVHVDFU?=
 =?utf-8?B?VWNMMitFdnRybHUyMXVJQURRNEQ4V0w4dE5WV2RQUnNXaHlxMTRZZlk0OTZI?=
 =?utf-8?B?dU55RTlMREl2alF2ZzlOUjNZYjZ4Z21XT2NxclUwUTVHa1cyaDM3TTVsZU50?=
 =?utf-8?B?NGhVNTZocFd6V1VPUWplbVB1bVVuZzY3VzhaZVFUSGFTYWoyZE5FbUNuZldy?=
 =?utf-8?B?WnhBMC82VTB0WkVFaWZTTzRZdTNoU3hqR3J5Wk02YjBDUXFJai9LbjhQTlJH?=
 =?utf-8?B?c2RtK0k0YU9GSk5TeWlJUWJrczRhc0tsT2x4dmxZdERXZFBXRUV0NzE0ellP?=
 =?utf-8?B?TVVqMit4dnlZVml0c09RbGhVOHpSaWVoa2pBQVdOY1NjeE1PZzk5SlAvOUVL?=
 =?utf-8?B?M3NYaXZpSTZsUUd4V0h3SG5XWEc5MmNLRktqOEpQWVlSak40SHFjUWVxYVpm?=
 =?utf-8?B?NFZrODlGQjdhWW9iYkdqRGhMOTVkamlCVlhwMUltbmFQZllIVEhqK3BWZVc5?=
 =?utf-8?B?M1ZQRURQaHhDR0VFTVBjU3BRNFpOamhUZDdoSEpLUkg2Y1JiNDZ3cnZtRTZ4?=
 =?utf-8?B?VkZSREE3Z3lhOGh0Y1BkMFRVTkNOYVFQbFEyVDdkelBsa092UWoyOXBVd1Jm?=
 =?utf-8?B?MHBBalFCWUc2a1V3SCtXSnU2Q3dBTUpMM2RuYVB1b3JjVm9VcFdlcnZWRFc4?=
 =?utf-8?B?UzdKL1o0YWpiWjRjYmJRT1VIOUEvZThIQ0RlQ3psS0lhRVhVbnlNUGZZWkwr?=
 =?utf-8?B?NkZLbG5lM1FyQTZEWkRaWmo2NDI4Sm9KclhPczFTRVZuTnAzYXRrUXJhSGl3?=
 =?utf-8?B?QVRkVGJWdTlMTUJUSjAxL2tyUDVDQnYwZzBubVdFcXV2eFF6Ynh3bjUxVEQz?=
 =?utf-8?B?dHYyeWF2eWtaVjhabG15YkhXeVBKVy9iM0ZsQmpUNTFlVmdkbE1NWjducWh4?=
 =?utf-8?B?RTBqVVBDZWJQTXFCYWE4UDMxdWt4a0VPaFUzeEdVQnpUZXVvTStpZjh3citE?=
 =?utf-8?B?Wmx5Z2FTVi9MTXhLUDBSZXJLVnpTaVduL1pyaG00cDk2VHV6c2Q4OVRLNkdj?=
 =?utf-8?B?K25QaGpPSFFvL0oxc28xQVlFeXRQOFl0SmcvVzllcUQ5SXpKVGdyYVE4QlRt?=
 =?utf-8?B?aTIvT1F6TGtyaHoxMld6aVorRFhBalBRdjM1M281MFJvL3lOQUZHRFlKVlJo?=
 =?utf-8?B?RzRSK0s2NmJEYUhydVNpdk9renhWL3ZTUkdIeTBacjlmd1UyOER4Rmo4UjlS?=
 =?utf-8?B?QUpJQ1JvWXVEN01xd1NnVWVCc0VsdXlEa0t2UU5HODlIWFRqME10WS9RNjE2?=
 =?utf-8?Q?Nos0ROvwdxpWQPYA8scd4XD62?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7PcIoCTSzpXZqAmbOALvzfxNVB95KQRv+r8HCaEclCLrbbM+IlVzXovmCITmHk/uHJyd2A7i/uHAx8HmOgu/Rk25cPMnBcwr0QNMKVg+7eAuH/mhMwnMhhcMh8YP5G3itwtFgWFK7qFeB/EDBqsd7+Wo70k382HmMn66HAQprlnnoQTI/F45NqpJJGcgyyQr65J3EH9Hnra/w26/DfpKHW+WDIKnQS8meo7iK42stse+aTvV3bc20jpSi3AZJv3uZg/RpuKKlCH4JuvFWOjQJGStCx0U8Sp8IxGz5ISB+cSK0bwCPl27UU9Ix08YUOciPKdWY16f8eFowwQyn5lNnQUf10UUniE/nvAzJX6F4cBZ13BP0tk2xzl5bZ5eIEILYgIEUrrLbKt7+HYruiqZzhZ7go3tmzQNZDf1c8PpRpQPU4g5NlCXhzrsvT3L+/rAgAuffCieMdxWAob3kzZQjGYMuCHpiNYLN+wVR6efbC8r041yiZvpj7bkozM/aQ9wu+NQowRzCp6Y5rmQ6n4T9NiPaHYbZiJSVer037mHUG+hUGYsebO9omSR0U2ueOG2J0tF+KPoqNQ/HaNY1yUD+TZJbczkxzNifclnATa5kgMSu9C65pIpcIBnTiDjX/ziU0/vg1i0/p3mviffZzTLnQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:49:51.7436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e581410-b6ce-4c47-7806-08de0b070584
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB6222
X-BESS-ID: 1760435399-103298-7679-5853-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.193.127
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbGJqZAVgZQMMkoxdgwJc3E3N
	I8LcU4KTklySIl0cAyxdDE3NTYOC1NqTYWAGvlPWJBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268198 [from 
	cloudscan23-11.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

For io-uring it makes sense to wake the waiting application (synchronous
IO) on the same core.

With queue-per-pore

fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread --bs=4k \
    --size=1G --numjobs=1 --iodepth=1 --time_based --runtime=30s
    \ --group_reporting --ioengine=psync --direct=1

no-io-uring
   READ: bw=116MiB/s (122MB/s), 116MiB/s-116MiB/s
no-io-uring wake on the same core (not part of this patch)
   READ: bw=115MiB/s (120MB/s), 115MiB/s-115MiB/s
unpatched
   READ: bw=260MiB/s (273MB/s), 260MiB/s-260MiB/s
patched
   READ: bw=345MiB/s (362MB/s), 345MiB/s-345MiB/s

Without io-uring and core bound fuse-server queues there is almost
not difference. In fact, fio results are very fluctuating, in
between 85MB/s and 205MB/s during the run.

With --numjobs=8

unpatched
   READ: bw=2378MiB/s (2493MB/s), 2378MiB/s-2378MiB/s
patched
   READ: bw=2402MiB/s (2518MB/s), 2402MiB/s-2402MiB/s
(differences within the confidence interval)

'-o io_uring_q_mask=0-3:8-11' (16 core / 32 SMT core system) and

unpatched
   READ: bw=1286MiB/s (1348MB/s), 1286MiB/s-1286MiB/s
patched
   READ: bw=1561MiB/s (1637MB/s), 1561MiB/s-1561MiB/s

I.e. no differences with many application threads and queue-per-core,
but perf gain with overloaded queues - a bit surprising.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
This was already part of the RFC series and was then removed on
request to keep out optimizations from the main fuse-io-uring
series.
Later I was hesitating to add it back, as I was working on reducing the
required number of queues/rings and initially thought
wake-on-current-cpu needs to be a conditional if queue-per-core or
a reduced number of queues is used.
After testing with reduced number of queues, there is still a measurable
benefit with reduced number of queues - no condition on that needed
and the patch can be handled independently of queue size reduction.
---
Changes in v2:
- Fix the doxygen comment for __wake_up_on_current_cpu
- Move up the ' Wake up waiter sleeping in
  request_wait_answer()' comment in fuse_request_end()
- Link to v1: https://lore.kernel.org/r/20251013-wake-same-cpu-v1-1-45d8059adde7@ddn.com
---
 fs/fuse/dev.c        |  5 ++++-
 include/linux/wait.h |  6 +++---
 kernel/sched/wait.c  | 16 +++++++++++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 132f38619d70720ce74eedc002a7b8f31e760a61..3a3d88e60e48df3ac57cff3be8df12c4f20ace9a 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -500,7 +500,10 @@ void fuse_request_end(struct fuse_req *req)
 		spin_unlock(&fc->bg_lock);
 	} else {
 		/* Wake up waiter sleeping in request_wait_answer() */
-		wake_up(&req->waitq);
+		if (test_bit(FR_URING, &req->flags))
+			wake_up_on_current_cpu(&req->waitq);
+		else
+			wake_up(&req->waitq);
 	}
 
 	if (test_bit(FR_ASYNC, &req->flags))
diff --git a/include/linux/wait.h b/include/linux/wait.h
index f648044466d5f55f2d65a3aa153b4dfe39f0b6dc..831a187b3f68f0707c75ceee919fec338db410b3 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -219,6 +219,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
 void __wake_up_pollfree(struct wait_queue_head *wq_head);
 
 #define wake_up(x)			__wake_up(x, TASK_NORMAL, 1, NULL)
+#define wake_up_on_current_cpu(x)	__wake_up_on_current_cpu(x, TASK_NORMAL, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_NORMAL, nr, NULL)
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
@@ -479,9 +480,8 @@ do {										\
 	__wait_event_cmd(wq_head, condition, cmd1, cmd2);			\
 } while (0)
 
-#define __wait_event_interruptible(wq_head, condition)				\
-	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,		\
-		      schedule())
+#define __wait_event_interruptible(wq_head, condition) \
+	___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0, schedule())
 
 /**
  * wait_event_interruptible - sleep until a condition gets true
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 20f27e2cf7aec691af040fcf2236a20374ec66bf..94120076bc1ae465735843cc5821ca532d9c398a 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -147,10 +147,24 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
 }
 EXPORT_SYMBOL(__wake_up);
 
-void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
+/**
+ * __wake_up_on_current_cpu - wake up threads blocked on a waitqueue, on the
+ * current cpu
+ * @wq_head: the waitqueue
+ * @mode: which threads
+ * @nr_exclusive: how many wake-one or wake-many threads to wake up
+ * @key: is directly passed to the wakeup function
+ *
+ * If this function wakes up a task, it executes a full memory barrier
+ * before accessing the task state.  Returns the number of exclusive
+ * tasks that were awaken.
+ */
+void __wake_up_on_current_cpu(struct wait_queue_head *wq_head,
+			      unsigned int mode, void *key)
 {
 	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
 }
+EXPORT_SYMBOL_GPL(__wake_up_on_current_cpu);
 
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.

---
base-commit: ec714e371f22f716a04e6ecb2a24988c92b26911
change-id: 20251013-wake-same-cpu-b7ddb0b0688e

Best regards,
-- 
Bernd Schubert <bschubert@ddn.com>


