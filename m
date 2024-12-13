Return-Path: <linux-fsdevel+bounces-37341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D759F11B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3F828271A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B301E3769;
	Fri, 13 Dec 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="0raaWW5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EE1422D4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105728; cv=fail; b=ufaTRGAP83hFa6cn+cBIiiaOsl80JGOXUJtMko8fNPj3Kq1nuoCChEeFu/2kaUeMIdEQjk6VZE4yGmZC0cupes87B1jP/F36j0hD2jknB7D2Fz3r7d6yEgbSUwvxkdeADMOCWcWOC/rI6gU5aEUHwIY8d0EVAvo1Ild9VFKDwmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105728; c=relaxed/simple;
	bh=X6OIB2bYDd7oxNCztYJzfMCQe7eHrAwSQKRXsrPQ3aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QL4uMfzYrzcIROZexh9mOM+sD97UhVYcjXReQmneAtbk51K/P2GV4cAyNNG3r6AuogjuOM4DFWGl7PB+Aewm+TlB+Awb6pAuh7P3YNv20xWiHniVmpC+QQW2fVtkgOCZhHtw8it5D19r+fgBPQpx+VEZ1u3ISHLYEPbJTZzjBv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=0raaWW5M; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170]) by mx-outbound14-204.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 13 Dec 2024 16:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WusVqiNbUpAvk0RTiCPJIYYKopXpyfpPeTpfiI6uBfSNJ2pu02xizqQMoCgDD8Cbhy8rkDX1LqqjdCFOuhXvvO76Yecg8CIggI7lKR1/Kn8nk7RgGa4/1vbLaUo35U3ovnoPAEtwLRkdecLCNFwsx7qS/TRDl1C9EoA5JFf0/BMD5aVbv5FH6E+W92Dut0FRsrrWz6CzF6UqgeI5ZhZYKg/k5c7jwr7f4352Rlzd6myE4c5GeO4VvGaF5Lbndx2IDcdbuG5lTQXcNa1/VorunuGiG0w45hntGGJMRtugaWSEzvPeV7cG4Ye3eB4LkfA5HuPDHxe3/RMRpY9K07oF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5GgVXxbtgnZT6r6AEmIhQT7BL7NEhAkO/rs5iOHZgw=;
 b=zGWLCUSQKaybb3SeGOjtTThHCQ3seb3jmai/1k/9seuj5srF469HXECbrCFIPi+LnGpmcz3JxgrO6n+seK0u6g2qummCG8q487eVtcOIGuRMPaLdE6QKIsjCjKDLpQQUsqy87jc61tLv7/hiV57hYMGoCLvpffrFnRC9CnFGqGKwJlzkbXggQ5Xn54GglvHBBW/99ywU2EWsDX7tztK/QXgUlsu32G8C5HTchbA7P9rnEzOcscN/TZW6NefWUzzSuzYbtvj+YpKoWFA5plkbUs/HuMbE4Bh6ROJT+DqKv6ISTT6kNH5ACU0j6CFEdIJ6M5S5CVhgoiw2YqsRrjb+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5GgVXxbtgnZT6r6AEmIhQT7BL7NEhAkO/rs5iOHZgw=;
 b=0raaWW5Ma9e7JYISBllGIQhIRxaHbFHplT+PHMtLYcDE77UgkHqBb9bygWdm5eVdsqSfLWEMc0MQhvdI1Y6U2K+sndI7ET3+2gFFVolhrL1XEQlm97Ge3+kbtR+N+GJWUcVd++4zufTHBYT8QNMBm+VwjQfZKJ1RNZmkLEmKGkw=
Received: from SJ0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:2c0::16)
 by PH7PR19MB6063.namprd19.prod.outlook.com (2603:10b6:510:1de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 16:01:44 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::bb) by SJ0PR13CA0011.outlook.office365.com
 (2603:10b6:a03:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.5 via Frontend Transport; Fri,
 13 Dec 2024 16:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mrp-01.datadirectnet.com; pr=C
Received: from uww-mrp-01.datadirectnet.com (50.222.100.11) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 13 Dec 2024 16:01:44 +0000
Received: from localhost (unknown [10.68.0.8])
	by uww-mrp-01.datadirectnet.com (Postfix) with ESMTP id 76C854A;
	Fri, 13 Dec 2024 16:01:43 +0000 (UTC)
From: Bernd Schubert <bschubert@ddn.com>
Date: Fri, 13 Dec 2024 17:01:40 +0100
Subject: [PATCH v2 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-fuse_name_max-limit-6-13-v2-2-39fec5253632@ddn.com>
References: <20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com>
In-Reply-To: <20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Shachar Sharon <synarete@gmail.com>, 
 Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734105701; l=1356;
 i=bschubert@ddn.com; s=20240529; h=from:subject:message-id;
 bh=X6OIB2bYDd7oxNCztYJzfMCQe7eHrAwSQKRXsrPQ3aM=;
 b=OFx7d4QJB4ZvEUelY896yO1oW6mD0PaUWldOVqchVxpe1mYOpfkqjaQ4JxrEpapoZ3rV1Na2d
 mwSX0P47ss2B1sbQfXWXiVG4UNq3sdwR6TWiiepvazo+LXbl+ZePZPT
X-Developer-Key: i=bschubert@ddn.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH7PR19MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c127917-a025-4ec6-6e37-08dd1b8f70af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGdZYzJMcm9uTjhVQjNmaWFCaVM0S3E0enZxM0N2Q3pWUlRSQTFMQ2hqQ2VZ?=
 =?utf-8?B?aWkvSXFjZms4d2pZYWZwZ1F5cGNtNlFyendmTDc5UUZEWTh4cHp5aTQ5cHhl?=
 =?utf-8?B?dGZTN2JHWGFhRFFaTFpxRlpxaUJwZnVVNk1Ub0ZFeHNORUNUaGZEcWhMdnFo?=
 =?utf-8?B?VmxvSE91bHhPcWtoRkl1NER0Q2xENXB2bjF6ZDZjT1VHbFJQZDc3RlJpQW94?=
 =?utf-8?B?aXViVlpENEwva1crMnd6OWdWbkdUS1JUYVQ0bExYUjNQUldKYWRKQUovNE5I?=
 =?utf-8?B?QXhZVEVrZ0ZvNkwybUw3REFWcFBxZDNvNTVHaEI0NlFnZHRwV0VXdk9CSDRT?=
 =?utf-8?B?cnNWTXRNNXluWFFLd252RXdXMWtxSzAxK3NONWJDc2M0QWx5T09TVzJZTzJm?=
 =?utf-8?B?OEJGbzU0dlRLMC9KczI4b2xlQUhWdEx5WjhiOUJxdnU2S2RIVS9yeXVNTHVH?=
 =?utf-8?B?NStFb3M0S0V1NTlmWDUvZ3VQeEZSSFpLUHh0OUtlTDVmaTFCT0VMbUtWU2Jr?=
 =?utf-8?B?OHY2UzA1VzJRc0FDZDd1Y2FCZkhIMDNuejYxQWkxTFhRYW0yZmxmMDFjbHFV?=
 =?utf-8?B?NjhRR2tDNkg3aldlSjRrckhTRFRtZzc1VzBRaU1OM0lubjhsTUdhZzRwZm9I?=
 =?utf-8?B?bStxN0NuUHZwcVJkakJoWFpVWVpKcm5NWHdSM3R3NGE2bzFsNmlwVDBCUFY0?=
 =?utf-8?B?QlFIVWVIcnZCemNjV3d6VlJvMVQyeUxGSUhQYzFLSTV5aWN0eXNsMWV1elg2?=
 =?utf-8?B?MSt5em5WZnhtTS94Ni9CaEpWZnV6dXJ2YmJBSEZrRW1lWXYzdWRIMkpBSlVs?=
 =?utf-8?B?K25qd2ZDUHRucDh2UzFyMnZBMUlFWkoxeW5XOXQ2UGhhcXo1dGxkR1g4cHJK?=
 =?utf-8?B?VjluSXNxWUI3WUNNNCttZlFGcVhRQW9KOWQ5d1luVGdLTEZ0LytZejFDakhY?=
 =?utf-8?B?blZNU3lkRjFUd1ZZZEpTZGZzQUtqTzBRL29qL1lScjVNRXpTS1FpT0VmSnYx?=
 =?utf-8?B?Y1pEM0lsazgvUko1dENEd1V4eW9kUC9Ra0lrZ3BEaW1nL0J2SmE2MEtjMldK?=
 =?utf-8?B?VGJ0YXhERXZOZUx3UEsrdlNNLzFPVWlRd01hbjdSMzg1RTBkNVVlaGpoRVkx?=
 =?utf-8?B?QllSN2kwL3dxVWlCMnRlYkNxdEU5VjBLSW1Fd0FPa0tuT1N3S0c0ckViNjQw?=
 =?utf-8?B?SE9CYk1wS1hiZlA4YXZWSytIYlVCejFBNGlSK3JVYlp1a0ozTHVzczN0TEpl?=
 =?utf-8?B?UWpvUXVRZ3R5UHF4TW80eWZzOVpGNldoWko0UUVXU293MUxmOTBNNGZFdmIr?=
 =?utf-8?B?R0F2UzB0a0s0bzZnYnFMZ3BBVWR2YS9qNlJvN3VTQWdzWTVFNXNEeHBzSmRw?=
 =?utf-8?B?OHFVNVl2QytYZEZZWlByeng1MWFzL0lFL0RYNnAwVXArWE5LZloycmYyZitv?=
 =?utf-8?B?WHUwMkw4N1lPdEI5Z2p5SVl2engxVkFJWGpOQmk3SjZyaWlNZk9qWkhKNS9J?=
 =?utf-8?B?MHpaY2U3OVg5WXF5b0dJSnY2c1V1SGMxVUdoRnhlVURKZmpwL252ZVhTY24z?=
 =?utf-8?B?L0RHQXlGZ3hEVW1LSllqamhzYVJjLzFQaFZjRTdVYnhSWmhOTFk4YkZjbGZq?=
 =?utf-8?B?RTVsVlIvOGtRUXlXUXM4N0RsWS92dVdGemxyQ05WODl4bkY1ZTFFcWxXdS9E?=
 =?utf-8?B?L053dm5UbHZ2Z1ZleXp6RzM3b3NGNmhTeDJ3M1VTaDZtNmRwbDIzek9MYkt6?=
 =?utf-8?B?RlE1Z3NMKzJ2QklBVXVEQWFtMzJGaC9IUXFxMUJ6d08yU3FjZHJwQ1BxNWJN?=
 =?utf-8?B?TlpSd3RzSzhJVi9ZdDkxMHRqWEwzTWY5TnpTV2t0eGdPMUhRYllVSEJlZUpZ?=
 =?utf-8?B?dmx3OVFVOU5xVVNRNzVtZ011cWsxMDZlWjdDamIxeDFuYWJWZElSclcrRDBS?=
 =?utf-8?Q?NljhNRNCjll+/C7FeTm9l5tZeKKSlNwv?=
X-Forefront-Antispam-Report:
	CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mrp-01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cDmY0DeCP0CGBiIS2qnfdBGG1EvdXl5uhXlD+UuqQJeihDSsS/EKuDOclP5WsCmaETXioEK+X2IPLLh8A8v+dTMgcVMtWyioVJF83B08iHwCaTsjaegA/4jl7UndCO9evtKGx+CEzK8iP2xeqqg02dxGW9idex/FFLk2n0EIUMMm9NgVsryKx0Sb4hiyaXXcadltOBA+GfQXllun6LovtfLVCL4hNePeGnqfHmtDHSOyOegCPEeexP0WXv0OcCSaykZgI0B94eAjebHx9m1rC0hvoGRdc89o+hQQrDL6s2zKwpwy83AueH62w7aGZbUIkgB+r9Yk8WH8b04HkbyOnf2yGJsqJsys1WxEzVuzXVJYpw5njO9HuO4LXe9R58c6ueTUAdpDdIDzegpS6ZJBXEHv8boLBx+k0T8L4VcKs9bZ5/3CbZX4z917hIfYwcX+XJ520BwnJect/pa9+ltYT8u4oicnCR4nhfY1i+gyPPxFaL7gKX2yMfeqLSLoS8UcUDSQ4SoindZzPCPxkWG8CBeqVybchQTh/BzLmOW61gyglMRu39/pHSlRQ2lXrQhO+aYNodQe4b5/bILbDUOvu6p1B0DxHmpe7p6V9nnczsRuAjvqMeVUCqMPPdIQyMh5CZsWjJFxgdVVFJ+1YnFDNw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:01:44.0203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c127917-a025-4ec6-6e37-08dd1b8f70af
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mrp-01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6063
X-BESS-ID: 1734105707-103788-13490-6909-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.59.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGRoZAVgZQ0CzFNDnNyMQkKd
	EwOS3NKNnQ0Ngw0cDcPMkkLSXJNClRqTYWAJz6aMFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261086 [from 
	cloudscan18-105.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Our file system has a translation capability for S3-to-posix.
The current value of 1kiB is enough to cover S3 keys, but
does not allow encoding of %xx escape characters.
The limit is increased to (PATH_MAX - 1), as we need
3 x 1024 and that is close to PATH_MAX (4kB) already.
-1 is used as the terminating null is not included in the
length calculation.

Testing large file names was hard with libfuse/example file systems,
so I created a new memfs that does not have a 255 file name length
limitation.
https://github.com/libfuse/libfuse/pull/1077

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/fuse_i.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f286003251564d1235f4d2ca8654d661b..a47a0ba3ccad7d9cbf105fcae728712d5721850c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -38,8 +38,8 @@
 /** Bias for fi->writectr, meaning new writepages must not be sent */
 #define FUSE_NOWRITE INT_MIN
 
-/** It could be as large as PATH_MAX, but would that have any uses? */
-#define FUSE_NAME_MAX 1024
+/** Maximum length of a filename, not including terminating null */
+#define FUSE_NAME_MAX (PATH_MAX - 1)
 
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5

-- 
2.43.0


