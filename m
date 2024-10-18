Return-Path: <linux-fsdevel+bounces-32354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE79A41A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 16:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382E1289539
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0CE202F6F;
	Fri, 18 Oct 2024 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NDsx0qJP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jgqTspVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EE20264C;
	Fri, 18 Oct 2024 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262944; cv=fail; b=t91iskxl9N19yU8hyq0q48PyWRpJ6mB29OAX/ubS3+FPDPKarDdG8e45NmmC8bdo0oEOctnhXMgsKGKbYMKdkv48lg4pN++9l2Xb7AzP7DzIdm2lWdqNmroQRPI1+7b4M+lImiDEsHuS0AwREUrdSqed5Vs8tpBkY/1vdvFQOdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262944; c=relaxed/simple;
	bh=cyYJZHmUqNA33WCEdKr7iUyiNf0jl0N8MIP2MgywFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SpZxtEqATD6I99ZI3C+4jezRfU05xSlEhbxdRI/HpPPBt2WZNWm6P3Jf6ED9sL98iR+br88NZMF5ocuQzcxL0sFvC9jXaqG1k1Ewp3zZzfrfoujALiLUgVGZZykfP+PCLIRnUH835WtZMBtbKeQGMPQL+nUnJWHaWtmL7MiFlxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NDsx0qJP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jgqTspVn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBcMq017041;
	Fri, 18 Oct 2024 14:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rgCfDZ7CBl6KlmFw4rLxVAEfXodU7DDfMmfDq1TwuR0=; b=
	NDsx0qJPGBKdi7vxpkOsz2OA4yYJVQWRJ765k/y/Jp+r2tGispWEWm6NIV1jr0yZ
	rIoV6omtTpany2+OvbbG6ZhcfZhXKfs8bkrnYwBk7ui2HFY+faBHVQv5hD6SC9F5
	4cwc1+dex/pTXOXCit/yADer/Y6MLZEXAtg9/9pqg5wds19GQfXnOsri9HkRQlRc
	oAeILZluzX64p4EAtiQROF8HBk6fyWmiZvX9z5I0i7VI6MiFjk5qevuCe0498Bsy
	Nlk93/4cTxvFvG+FjgC4mWcldDGbZ84eiLs4j2xW5XgrILDsIbW8kEA0mRIu+0lT
	RibUVRr/HjS8/6lOrzcrNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnth0gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:48:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IDBggZ036092;
	Fri, 18 Oct 2024 14:48:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjj83tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdXoaoYfDr/ZEvRAttwmOKGEZmOeNIIz/O6hDh9APf117oDGln9fylcOASHvcDwjxfwcley2M/0bvZS26a98tOz7+AbLL7aIV0C/p2oS87++jm834T0t+qCMADYBXg9UvChV4QQ6AVdQxJKLuPLXYDJNCc6zxGgOecNq1iM+FVRO1WeNIjH78ViuUL+nP8zcC9d3FbkfABYbfIp2bb4tBLVkAEDqJLwim6SV74L66Dyn0IDIbgqPaHsiJdONQe6Vugaz+jCEHYCNO1WUS25+KYUV8uu2IKA2Foi+R5emJG/GPpDTuYv54QDZUZFbA6T5FHSTVSH3ooXbV/hI4epMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgCfDZ7CBl6KlmFw4rLxVAEfXodU7DDfMmfDq1TwuR0=;
 b=gRTue4sorlwFeGpH7vpKlZhwI9YFgqTzZYJu2bh3Grya5SCDXYQgG1S2nqTMYDMvGqr+Fboyg6lA+Kv59Gu/fo7l9c7aoTt61hpxVUTOEpfM276HcAS/aHpY5R/1roW0onD6Xr+5LwmnR12qqdrySCppg0ij+6qsx7IyvwhkIExbTReiYBoSD36hiGU5F8owuyyFZAsWcv77TpmgFUQUiLZ8c0kFvxILlOK7C8B6Mr0BAxlrO0BApSRTIz5Wiy6xZ6SeA+0VdlLIdMCgdzljMTSavSFYFRoy4qm7LWCUuNaufx/7l9ES0NN+WkVuw6QyxTghbf1ObY5ADcOG73/WWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgCfDZ7CBl6KlmFw4rLxVAEfXodU7DDfMmfDq1TwuR0=;
 b=jgqTspVn68U2+whE+JYeYNxmavDRJCzGw3bmt/iTa30m4U3lLZF0SvSZN8uKCH/aPLnlEgUbKjPvealsuKlgnDiQhJF+eaNzEnmO0Pi8w3wwnS3SgB1pQOnIJg/ivUpNDmE+Es5H83OtevvASW3GVW+fg0gNGHFsfX1GatJygXc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 14:48:24 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 14:48:24 +0000
Date: Fri, 18 Oct 2024 15:48:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>, ebpqwerty472123@gmail.com,
        kirill.shutemov@linux.intel.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
Message-ID: <5e288d07-5992-4ca4-8ec1-214d2fa6a326@lucifer.local>
References: <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
 <CAHC9VhQR2JbB7ni2yX_U8TWE0PcQQkm_pBCuG3nYN7qO15nNjg@mail.gmail.com>
 <7358f12d852964d9209492e337d33b8880234b74.camel@huaweicloud.com>
 <593282dbc9f48673c8f3b8e0f28e100f34141115.camel@huaweicloud.com>
 <15bb94a306d3432de55c0a12f29e7ed2b5fa3ba1.camel@huaweicloud.com>
 <c1e47882720fe45aa9d04d663f5a6fd39a046bcb.camel@huaweicloud.com>
 <b498e3b004bedc460991e167c154cc88d568f587.camel@huaweicloud.com>
 <ggvucjixgiuelt6vjz6oawgyobmzrhifaozqqvupwfso65ia7c@bauvfqtvq6lv>
 <e89f6b61-a57f-4848-87f1-8e2282bc5aea@lucifer.local>
 <CAG48ez0m4O5M8m4bLJ++gTZzsAyKgud++cBMBqAm74OLUKBFpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0m4O5M8m4bLJ++gTZzsAyKgud++cBMBqAm74OLUKBFpg@mail.gmail.com>
X-ClientProxiedBy: LO3P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 367b9f4e-3166-4016-5ae1-08dcef83eb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHNCY1Z1RXJsOC9uVnpKb3pTLzVQU3R0WFpwbHdsYXpuaG5tYVJscEs0NDU3?=
 =?utf-8?B?Ykc3Q0pZaEFxNStJU1VkaDE2Zkh2Z0Zodkw2dW1IK0xKSW9yUlRIMk9aMW1q?=
 =?utf-8?B?c1Mwa0c2cWxhNnhKYUZGNGNNaUk2bVNwTmVpYjNDaXpXMzd6K0VYYjhBVlBi?=
 =?utf-8?B?S284d3hUTDhUdWhNMHpKSVZHakVDSTNGREEyeDNUYXh3NFdhblRackRYV0FH?=
 =?utf-8?B?SkRKMzltdkRXbm9ibXpVcFBHcWcwclNpNXdtell1VE44SUh5OGdFN0UyRkhw?=
 =?utf-8?B?OXJsVmhjc0t4eldobDVkTDNobVdabFhwZ0lmWTFIZGhlYnRnR21GcE5nQVZU?=
 =?utf-8?B?RERTVmJBY2NaNzJVaUFnNmdjZnRFRE4ra0xDczRSYnNXUlk4N291RG1LYWY3?=
 =?utf-8?B?TE1zV3dRWVJ0VWpYWXM5RmwvSlhUTDUxRDdqNk1WWXhOb1ZGMVRxc0RZSUVM?=
 =?utf-8?B?dXhKSlQ5aVRXNU5vQ1JpZFdQdTJVZHR6NmYyRkp0M2d0TWIwK0I3QWsvT2pL?=
 =?utf-8?B?QXBrQzBTSU0xa2wydEd1V1NEdmFUVkdJUy9NZTF6eUFtK0k0S1llV2hvVGYz?=
 =?utf-8?B?UFIyakxTc09wS2YyNDVTY3B6dktzdlYySGlOczdEeURCWll5NnFDYTBhcC9C?=
 =?utf-8?B?dXNyMmY1aDFHKy83MVpTUGtPeERVeEtMaEpDVFliYlV4N0JLNEQ5aEozWkRD?=
 =?utf-8?B?eENiSkF2SmFmNlZ3S1piNlFGKzQxbC9GbUFURmRaeXhtbWVmYU1wMjBxWVV1?=
 =?utf-8?B?Rmd1b3FxdzhPb1RXeERoNEUwY2xsT2ExYTBLenJEOHB6S2w3NGtXTklJWlJu?=
 =?utf-8?B?SXFpeFRwVjhjRkJPYUlTbC9pM0ttM29Gb3dqQVNEYzJoK3hNOUt5RHRZeWRV?=
 =?utf-8?B?Zjk5NGdkcVZhcEF2K0NIa2NLeDE1WU9OWDNxQ2FlU2V3QnMxUS9pRlVrUHBW?=
 =?utf-8?B?a0x1ZUVjY0ZKM0hEa0wvdC9qNkdVVmxBcmxweldTWHE0M1lHTHR3ZnlXbGs1?=
 =?utf-8?B?NjBDTzdReHpBSE11dm5TVmo0OTN6ZjRTWEs3VjUvRTJEMDc2Z0pHUXZ4YXAv?=
 =?utf-8?B?TEIwTU1rMGZiRUI0eHRCSzdweUI1eEdyQk51cDRMNDJFN2JYZFRBd005WlRr?=
 =?utf-8?B?TnBqWGg2cGRYZDVkY1U5bHBiemRoMXp4a2kxMDFqTm5VS1NFcWtBOC9IWUdC?=
 =?utf-8?B?R0RrZ0svNytTdzJrbjJLR0NKTnI1cFlYSzBOQWdsdzNIejg5azRkTWZ2UGEx?=
 =?utf-8?B?d1VKbjlLZ3dZSlZIYjVXSWx5cENoQzdoMlVscldwdm9SdG9ZZ3JIUElBeDNR?=
 =?utf-8?B?NERvRk15YjBEc2t4UFhJd1hvekpJbkdsSG1BY2hvZjI4Z1V6eHpuV2Y5bHpo?=
 =?utf-8?B?ZGZUaVMxa052aElleTBTTHlLZS80WUFHaHlSS0FjS1N5TnFjdDRJdlZOYU1X?=
 =?utf-8?B?OGVjQStXOWNXcWI2U0dnR2NzWU1KMnRoaTBpYnhSTEtxWkJjdjIvMWQrS2o2?=
 =?utf-8?B?UW9jekpzUjNBbmh4UnFFVy90YWtxMTlZOUEwWWk2L0JLdjZ3cHJjN3dxQUg1?=
 =?utf-8?B?Nm1WM2NCM0RNQ05ZQkx3blhIbGtHdm1ZR0hnaDZGNkYyWGpCQ2duUWx5UzNj?=
 =?utf-8?B?djhFKzFqcU5HR2YxY0x3bmQ4TkNkUUJnRkd5S2xCeFZuZWtReXBEUlJEdUJq?=
 =?utf-8?B?NGpNV2hqOStvRENDbzBLOHBYZHhyaExtaTF2Vm9iZjBJbnVHYnF2Q1ExOThs?=
 =?utf-8?Q?wPvO9WsOv55oBcV45mix+48rFGZs2G3x76ruI/9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJmS2hxUjJhZlIvblR5K080cnozeFBaL3hxRStsUC9leUR1RmxHY0VmOThR?=
 =?utf-8?B?bGh6YlBaVUtPMTg3cm9wTG5tVWJsNzlMT3BqNTlkVm94dkZleElVS0I2YXp6?=
 =?utf-8?B?dE15Nmw2T2RUdnQzWTJQVExqVjNtcjlFeU01cDlZZW9iT2dTNFJFZ1JUalcr?=
 =?utf-8?B?dWNlaTRZVlFPVnhuSFlVemVIZksvMHV1TFBKaVBxZlNlc3k0L3RXQmQxSUlF?=
 =?utf-8?B?aThDME5Ja2RzdnhNbTJmSlZnOHJkRmNIcWQ3dHNMTnJpYStscXRJN3VVOGRW?=
 =?utf-8?B?Z3Bvbm42VVA2Y3lTR1JmR0d5THVuclNiRS96R0FlcjdEbkQ0dk9RSlFWajZ4?=
 =?utf-8?B?T1lTTzQvdG8yNXpycUtJVDVCU0FIOHVPRTRjVm9RUi9WaG1GeWg2aWo5c1R4?=
 =?utf-8?B?alIraVZDTEpIL25YY1JtTGhBaW9ZZ2drVVYzVUFleWFkVjlSYi93ZnR5TFg5?=
 =?utf-8?B?MkliZFBKdEdGTFp3YlpMWkdkeUdnWVdhZ05mSFJhR1B5QWwyMUIyLzJRbWRz?=
 =?utf-8?B?NFRYQ0NWN2EzUXJjZFMyK0NpeHh0Y2xOYkc5aFNTOGI0UnB2SWFKZDRxY1Bj?=
 =?utf-8?B?aC9Zdm9BQ1lpY3ptVmlZTWRENFJhWHlNUDd6UW1GZHdybmdveVI0WEJCK3pv?=
 =?utf-8?B?bjk2OVJhYTM1ZW91dHVnd2swTlFVN2Z4bXgxUWRJcDRNMFlwUW9TdW9ZbXUx?=
 =?utf-8?B?RUVuTElZSndDbHltQXJWWkN4WVBPS0JWSFNYdXRkOFhLM1RkUGhxK0pHUDUz?=
 =?utf-8?B?cUNvbThJZklzQStlcTFDN3diazVEVmN0UnpMUy9tQXlzazlBT2ZPb1FUb3VQ?=
 =?utf-8?B?YWNUMTBUSzQwTTJ0bGJnMTZlR1pvZERjNVRLcW5NTFVhZ2oyN2w0Q2VHNWtT?=
 =?utf-8?B?NVJwVDhSOXB3enBhVnpoakxPR3Uyc2Q1T3o3WTZOOElvTHBILzU3eGttcmsw?=
 =?utf-8?B?TmthQ3R5bUtPOHRmMFBYalBJaEdMRkJPeVlZcG9EaVFDNHM0ODBZOG5yZHk1?=
 =?utf-8?B?YW81OGVZSDdCVlBOdmxHOHdZTFVnNGo2VkR4OEJKVHRDQ0I5OHJVMjEyQlY1?=
 =?utf-8?B?SFFaWUVaQ1JHN2xaQVpEN0RpNjJrdDRKc3RsQjh3ekZQUFhGTHA2S2VWRlRP?=
 =?utf-8?B?RDlDZEFjeThlVUx2RHNyWjladW10b1AwT3hCaHVlU28veTQ1V3VTdDJrenJE?=
 =?utf-8?B?UnBDNi8ybDV6OUVvdkZQOWduMzcyTkJSZFJpWmJ0MTZoWk8rWUNTN3MyNkE1?=
 =?utf-8?B?QXppTkxEQVg2cUlsNHNGNDBSc056NGZtaGlrZzhib1g2TkVYU3hTZFBlOWpw?=
 =?utf-8?B?OFhBaWNvaktWRjlXR0l1cDBDL0cxQ1dlYXVPVk5hL1ZoU2R2WVJqTXVqSEEx?=
 =?utf-8?B?K0x4YklnNFlQNVRSN0tyeFdSTmg1UndIMjdITi9VaGVkUVRvMFQ0QXB4c004?=
 =?utf-8?B?WkxFdTlLVkduQXprdXVlSHBYL3hpVlJFS1JZSDlXZnk4Uzc1NEFUejdTQ1Mx?=
 =?utf-8?B?bzZFSmloRmhyYklwcnZCODFCbHBCelFXZkovOU5iaWVTejR3dm5tc2phRWhu?=
 =?utf-8?B?alZ0Y0FyNit6dVFCbHR1ZzBCZS9sbHJUOElpVDZ2UE44aGhIcUdiRVRlUE9R?=
 =?utf-8?B?ODJIR3RIdlh6ZkpEaGFJZHo5amowcngxVEs0OWxJU2NJUHU3dGE1K1dtalJY?=
 =?utf-8?B?WnJxY3R5NEIwdVlRL1l1V2hRd01vbndpS2NhU3VpYkkwbTc3U1JuaHJLRXdX?=
 =?utf-8?B?bzV6WjEwZmdIVWthNVJPbGJIa21CSnNERzQ3ditocDdLTUVCYytYVU1YT2Ra?=
 =?utf-8?B?R2VQbkE3MVVvMDVEMHgvUHpFbnQwaU5FMW4zMGFoS2Q5eXdsSXdvODBpQ0xn?=
 =?utf-8?B?WEJJVzJMN1hHc2FjN2lMSWlGUnU1Rm1yWXkyTzgweVgrb0Z4Q0luaUhEaEk0?=
 =?utf-8?B?d294R01iNDY3TUZUTWJOZmdBQW9RUlJCUlUzbTdyY0xnSE5GYVdPSlorS1hO?=
 =?utf-8?B?ekFPdUVFeWtpNHFpbk1oY09zZDh1RTVXcEgwVmdWWTVIaUFjR3ZjbWJuQVNp?=
 =?utf-8?B?VUo2aG4rMlpSeTV2VUNkQzhoV3ovQldmWFhzRko1L2lUQkhLQll6QnhMcHJk?=
 =?utf-8?B?a2tPbW5TOTAvSXFQQUxMZHF1ckRrSFdISmdZcm5zRUpkUjluY052UWZJR3cz?=
 =?utf-8?B?ZTRMMUhTU2pWc1UyQTM0ZHVJaGxPL2NqVDI5dGtoSjEybUxNZTRFQ2Z5V2hB?=
 =?utf-8?B?NTMreXBZbWVBMUd5U2ZNNzFtV3ZnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BZAMB1fyAvBFDwCQtpnF2vVKuVBSQmMX+z14bYNbPw2BKQXjJGgzyf9+H/ZtEvH6s7cpvh6oiCPHxm96c2IViBsUoGU+ySiwDOKD9sppfi2oXo04Vfz00Yputvz84g8GSpMyf1y14AdmnYIpJFzTukAflt7x/hLlilOt41hOWfrbiPxEvVATWJ/7i+vnnhy/8Eb//MigsaRz75rtm+ChUqm/+NWjIE5C8Lyr3VHR7rHoKh5ukNY7zJ/w63hKbEXawicSOEtzvg6meUF6vBVYpkD0Lm4vlsgUElZeTC/SxdosXWFDoPs6vTGToa4q2YDOittfYyEE1EFMljE+gLhhHLayD+Ak71kBG8PDdVYSCZuZj4qqe6C+WPzVJV/XVO+p5KqvGChR7uPLYXwxG5mY1MBESci+yzjobMfLBPZyo4ylqTPcrUaPs9VQztoiegT5lETTHItvy05xBSEJH567Uy9HpegxEyw1VH8YlkjVN3NHPDYJQjUj4SlhlgzLpZKm4NaBDT9uUOMwRgkw5SIJUj98iItB4h7jttSukLWGNBE/doJ2Z1u4sxr05mmbosLwBWApmbcen+GmsDneD0bm2RTcQds6457XLvqe6b7AqUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367b9f4e-3166-4016-5ae1-08dcef83eb0f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:48:24.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zJ4KmQ5Muh8M9gCxS97BMhygzY64ob9/FMr3vRRscm1BurWcyxe/4eSHM5or1jdluw4UgjpntuENL0oZykVYX8VD8KK5TUsgr9KQS0tZFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_10,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180094
X-Proofpoint-ORIG-GUID: CjYU5YT9lxAOn73EIJky7tePAz_cUTXX
X-Proofpoint-GUID: CjYU5YT9lxAOn73EIJky7tePAz_cUTXX

On Fri, Oct 18, 2024 at 04:36:16PM +0200, Jann Horn wrote:
> On Fri, Oct 18, 2024 at 1:00 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Fri, Oct 18, 2024 at 01:49:06PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Oct 18, 2024 at 11:24:06AM +0200, Roberto Sassu wrote:
> > > > Probably it is hard, @Kirill would there be any way to safely move
> > > > security_mmap_file() out of the mmap_lock lock?
> > >
> > > What about something like this (untested):
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index dd4b35a25aeb..03473e77d356 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1646,6 +1646,26 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
> > >       if (pgoff + (size >> PAGE_SHIFT) < pgoff)
> > >               return ret;
> > >
> > > +     if (mmap_read_lock_killable(mm))
> > > +             return -EINTR;
> > > +
> > > +     vma = vma_lookup(mm, start);
> > > +
> > > +     if (!vma || !(vma->vm_flags & VM_SHARED)) {
> > > +             mmap_read_unlock(mm);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     file = get_file(vma->vm_file);
> > > +
> > > +     mmap_read_unlock(mm);
> > > +
> > > +     ret = security_mmap_file(vma->vm_file, prot, flags);
> >
> > Accessing VMA fields without any kind of lock is... very much not advised.
> >
> > I'm guessing you meant to say:
> >
> >         ret = security_mmap_file(file, prot, flags);
> >
> > Here? :)
> >
> > I see the original code did this, but obviously was under an mmap lock.
> >
> > I guess given you check that the file is the same below this.... should be
> > fine? Assuming nothing can come in and invalidate the security_mmap_file()
> > check in the mean time somehow?
> >
> > Jann any thoughts?
>
> The overall approach seems reasonable to me - it aligns this path with
> the other security_mmap_file() checks, which also don't happen under
> the lock.

Yeah equally I find this pattern fine as we check that the file is the same
after we reacquire the lock (a common pattern in mm), so if there's no
objections on security side I don't really see any issue myself - Roberto
if you want to go ahead and post the patch (separately perhaps?) we can
toss some tags your way :)

