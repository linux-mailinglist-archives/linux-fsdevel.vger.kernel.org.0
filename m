Return-Path: <linux-fsdevel+bounces-64350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347CBE22A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391C45812C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BCD2FF14D;
	Thu, 16 Oct 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hyR1/O2U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yt+HF7IL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB8145348;
	Thu, 16 Oct 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603716; cv=fail; b=ZXVTrDgTWf2x/2TAuS8Igi+qn4psoTdN6iBPZ4zcqOR7+jfzhPnrZEODXQEpYeeDPcyfHhnrj/8n83tUn90TH/0GLFt0poGaTWj0SaNIxb/tcOWaRDhIIyEJHOwyOuWx68A88rLV3IruH5r9NtLkvQuMhE7FzOtTf7nrVJx3kwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603716; c=relaxed/simple;
	bh=35pH9KE0XULvNOScgoa0CQ+yWovxKjYbMk3h6bZb3sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZimlFjwsRHRZbJgKokGxmR6MWBJSXoUST7RMXKWH3bK+v3qBKlX1n0pCCp4f0UBB7nqr4XvQ82t2smvpVCPHMcKj78wNZQUwKSj+/0MhRljI1HYEIwpUZjQBsCQMUoWn1qoF6/hNdu8RMA5+1A/ZH6BMDkeFKW6GylvXPbZZpEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hyR1/O2U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yt+HF7IL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6gxer010695;
	Thu, 16 Oct 2025 08:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0/sd88coQ6lgIZsVSAWGs93BgI0y/tbo5viUxeeuwM0=; b=
	hyR1/O2UwMkdl0bsm1bbwerhWYqherzSrM+ePT0VGQRG4Nr3GsSx1eHu+rJfU2FZ
	RNC7oDcRpX2Oqq+J3AJz3bTqeGAOwQ5g/WsOLBFlce7/KAvsWhEUa17NRORVVdC5
	Y07FHMk2B+HeicFdomWBSPALCQVN52NDMci4caD2kcg8N/DVd4mvzQawwLy+jnOn
	xOCeNBxHHtegK5/xgKU80C/3zOKcWWuojcW7SHePMiQul06QW2x020ETD/eKqCKp
	ps0WzPXgQ/XtJfUFlMCoTFTjIbgFUL/HTIfZPXfApOQwd8w4NighPKkjF7LWbqen
	lzCt4qAvHyyGD1s2tBtH4w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc8csy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 08:34:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7mvsJ018074;
	Thu, 16 Oct 2025 08:34:25 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbd7fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 08:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do2BHFg9Sgq09CtPHUasHk14U4vBjNzpGAQaz6oawAOiq1nXvirZpjnlzdIN2BJB0gIxZfmrIUysEI4LgjKxLQo7u5DzpdUHMTdvnE7gA92WDrZ6NiOTotS6K1Xz4EEs9Ajd+RO4H4MV6t0A8s7x8cB/ghunsdUR8zY1VWSOqu4MHl2uqRHnl/n27o5Lh6ilKNnTu3cIlYo77cJakRyKwpndsUDp9Lt7D4Vrm1OYQxhHuyHCHa/0gMg8wbhGlnNjqi/W8uexGfLkh5IgkgUYwh5gzUfe3RBNU58mWRrSHCH9q7ip07RInUkYFsSTsxqY/X4PgszgzUT7FivZe/tgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/sd88coQ6lgIZsVSAWGs93BgI0y/tbo5viUxeeuwM0=;
 b=fFI7EIIkAIMfJDT9Cp4/A6l3aMCXtfkIa8jFCAPtbbHhfhTLg4E2LLi48yirK0B0bqdaq+mUdZZcCVqaZJ2ZFPiTUZXmTX6VlELthHUEFb0n/Kcl796QA+/Dhd6BVHkyk0LUovPwoQDPmBs3zy1rLGTC0wgLYGwql08DGt++XVKO0EkBTpjUnwY++VpUs2oHTrhqvMK34rYOxcJpBTOth1thBUlkQptvpm5R7n2UK7QklzIISb3Kq4bZVbltCk547BVXRr73AvBzrfYK8kf/hsnUA/uDHFW1DHIWJgfPNk6dQ88hvXG7aMj3SwbQgFrq/h4KAdV3G+IPsFz5VmQpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/sd88coQ6lgIZsVSAWGs93BgI0y/tbo5viUxeeuwM0=;
 b=yt+HF7ILaQJwYfxfBmnQC/w+xzsqbAxE3ZJ6faJGpNVGv+PRG9jyuvS/U2cBJLIUvPsBGiI6f1dNveIqB6y8YtogqJsjQnnnC8czHCKgFMQ6NM5MNr1C5ZNoFeww4LCTgOlNguHrLrjAyd5ppt50eHBv00OQrYsJcIlz9alEHyA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA3PR10MB6949.namprd10.prod.outlook.com (2603:10b6:806:319::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 08:34:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 08:34:18 +0000
Date: Thu, 16 Oct 2025 09:34:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
        kernel@pankajraghav.com,
        syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, nao.horiguchi@gmail.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <350b69d3-0680-41c9-8b3e-578504894372@lucifer.local>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
 <d7243ce2-2e32-4bc9-8a00-9e69d839d240@lucifer.local>
 <9F4FC13E-E353-4A4F-BEB7-767CF4164854@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9F4FC13E-E353-4A4F-BEB7-767CF4164854@nvidia.com>
X-ClientProxiedBy: LO4P123CA0225.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA3PR10MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fe22e7-1ae9-444a-0326-08de0c8ecc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b09LSThXZ1J1U28zdUJiKy9LY3BhZUFERmMzQmZMcFBFaWptclZCdDYxZGp3?=
 =?utf-8?B?akN3V011MmdHMnBRMFFKcHZVT09pTFY2dWhyZUtENTRGdHNWS1VtSkVQUUwx?=
 =?utf-8?B?LzB0YWR6eHR3K2VkSlJTVnU3aXNQL2p5NVozNVhiTEI4NWpML1dRTEJYbk9Q?=
 =?utf-8?B?cU1qN3dCQTQ1bE5lQVMxNDkrNC9TY3o4bGFHVUlrTmM5clQ1TVV2dmJ2Q2tj?=
 =?utf-8?B?Qnc3cmp3UW0yZ0FpMWpWYmdqVUhEcnlUZjBPZVlzbDlCLzVUOWxlZHB2QnhN?=
 =?utf-8?B?dFNXRklFSlFvM2EyWnBaVWdSc2F2dFRMdzVUMFllVkJjRW9sUXJPaUNib01v?=
 =?utf-8?B?b3IvN1QrL2d1Q2Z2aExkWi9mL3pkQVErZ09Wb2hrWmVzQTR3cjZXdmpWTFR3?=
 =?utf-8?B?VWRzSkNrYmVmQURxSms2a05VMnZ5SkVPUGc4eVJJSTZWTVUwWUMzVktEaUVY?=
 =?utf-8?B?QjErUS82WW5Qd3R6R21tTmd3RUUzQlk5VHI2a1lhbncwMk9YR3M1dVlMUDUz?=
 =?utf-8?B?KzBYOEpmdm5COC9janVuOVVVWTNDTTdQUUN2TldZak9walNKV2YvOFoxWkNO?=
 =?utf-8?B?OHhNayt0YWJoN25ldXdhb1dPbGNZUTl5OFc5cjBFWjEvemZNTXRjb0xYL1ZZ?=
 =?utf-8?B?bFZ5Umtnd052NzMrbm5xMlJYOUMxL0liT0lrTVRwR2NwZktYU0lIcE02Y2ZE?=
 =?utf-8?B?WHlJOFAvbVd0ejBHNkwxS2loc3VlbWJaYVRMOW5lc3dvSFF5NDFUQUd4UEp2?=
 =?utf-8?B?M2hQMVVleDBlL1hvQjVFRnBLeUJ1ZVB2ZWNGcFpXcThQenU5eVkyYUZPL2RL?=
 =?utf-8?B?aGdGRk44Y2Zjd0tqOEhUZGtVbnVhQ3FzTk9mNGVRUGRUbEtMTXdaWEh0a0l6?=
 =?utf-8?B?aGhaYUZGZ0FMa0krSVFQL1BWaDBxekJJOGI4ak9QeGF5c3ZLc25YSFJDckVm?=
 =?utf-8?B?UFZYWVZnaXBaZml5UzNsV2ZjSzJ0SW5wV1NpUVJKNlcwR1dkUWtTVkhhekdm?=
 =?utf-8?B?VCtGRFlxVzViSmhYMkZSOHc1ZE9WN3VzdU1IUG12V2Z5TVNndjdqbVo1L25k?=
 =?utf-8?B?a2x2WXRXVXVZSUk4c0pTTDhmK2duYTNCUEdlS0tVS21QcFhvVFY4RU81b2hU?=
 =?utf-8?B?SFRlYjZaNUhscHBxR3ZCV3FRdVI3bWcvNmpESm43MW5YOVNJRXVzUnJHUGIz?=
 =?utf-8?B?dGx0cWhkUXhIS1NvSHJMSGVYcGI3TXdKT2k3TGtwT0MzMXhjV3RscS90dHFK?=
 =?utf-8?B?eklJWUVBbnE5Q290ZU0zcXR5WldCMitKaUk1S3ptTktLQ0w5bWo2RUl1U1d2?=
 =?utf-8?B?Tk5LU1cwOXdtUzlLOWs2UzkvTUdKdGVnRnlBZ2xNK3hSM1lab2V3dDYxNlhK?=
 =?utf-8?B?ODRJY1U5WjRtWHdLbjFIdWV4UFJqMjcwQUR4RGR5MzZHYnlmWnM2bG1tcnNp?=
 =?utf-8?B?Umk1QTdlQmRjWGxrbFN4c01JTExockZKZHBBY1ZLZXBrUnVyLzRRTEpyV3RQ?=
 =?utf-8?B?QThUNVFBS1VOakJVZXhiSjhGWFE4azh3R25tTmVTMmp2ekd0eDdWQUVGRlRr?=
 =?utf-8?B?UDJZZzVGQU5XWmVIMEFBd1hRcXprZ2RWSEx3U3p0Y21iZDZHR0dDUzFJYVZr?=
 =?utf-8?B?UjdmV0l3blBvWEd1Ty9IYU9JMmRDcVpNN2lWWlpPOXpwSWF5cHllNjRRYWwr?=
 =?utf-8?B?T1VVQWhicDIyOUprbjlXMFpsNFJTOUFxUC9uVXFLaGZwRXlxOFlrZWFIa3ZD?=
 =?utf-8?B?bXBaV3pNZ3JnaWM2MUVrc0pDcWQ2TktoZnhGWmZibkIvMEptQTZUTnN3UktB?=
 =?utf-8?B?NWVaR2hYK1FvY0F1TzRqODBNaTF4TktGaGFQZCtBVko1WklOY0Nuakt4OUlx?=
 =?utf-8?B?cUpiYnBkcitWbWZJUkFUMFk0Q003OWgrUzFZWng5NDV1SWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVVPUmtkdVN0WTVRUGw3N25OTzBFU053eG1ZQjcrU2pyUEkrM1BEcDRSZnk4?=
 =?utf-8?B?OFl5VTM4MmQ5cHpvYVBVUkhrUUgrMW9wSW9OZjlZSkJjbUJjUnVJRE1oNTRw?=
 =?utf-8?B?OHhTMWptbWRKR0JZak5UNW1LWDlTNVB1OTBKZnE1VTN1Q0FGTmcxbEh0WVRC?=
 =?utf-8?B?SmhrS2RHVjJpV2o0RXRHK0NQa1hUYmR3R3dRTzZvWXg3U2FlV3g2YXFDUFNS?=
 =?utf-8?B?RjZlZ1ZWLzZoN2VzODQrOWk1UkFPY04ySE5FNnE2S2MzWkFuc21TcVJuTjM3?=
 =?utf-8?B?UytxaU95QURCdHRQR3dpNEN5T05PUmpqcnE0a2xVNHptWFg2bDd3K2hIOEdy?=
 =?utf-8?B?R25HdDk5VlAzS2RMaStuVFVDcHF6NHIzYmFGNlFtbndHOGM2TzZxL01SR3Nz?=
 =?utf-8?B?R0RpeUp5N0l6NERRTlB3N1JzUnN1ZldndG96RFpNcC9aQ3NCZGROOWQyNlJV?=
 =?utf-8?B?T0xsa3NzQm0xbXZaZkk0clNtK0dkWXVMOTdMeVN2bEIwRmZSVnp2aThQeTlC?=
 =?utf-8?B?MHR5cW9FcDFoOHAyRHVHV2pUTms0cnVuVGpnc3VQN0VGQ2g2NExkMDhPQTRt?=
 =?utf-8?B?T2RkRzE3K0pNSFJCR05rRlVsaW5rZ0pKYU5QMmZ6WnhNK0U1Q3AxN3Q3N2h0?=
 =?utf-8?B?VTNibnFwWkxvdERUTEZVeEwraXRMdTNnZ2ZSZEtzd3QyaEFQL096OEV0em9L?=
 =?utf-8?B?MkxhSmtvVnJUY0JRT1FwZk5WUTl1K1dsUkFFU21WdkcxcnY1aHJlYTFsZ0ox?=
 =?utf-8?B?T2tGTFIvOHRVZ3pxVVZmOEt2TzFleC84ei9zL3RQck94cFNnNnFhb2Ywdjgv?=
 =?utf-8?B?NXBUNDV2RDd4Z2Z4WUs4SnpTQWRKNDU3djRDOXhkdW9rajR4QVVjakJjZkFp?=
 =?utf-8?B?aE44VHA4c2REM2xIWXBTYk5VSk1YWTQvZ281Q0xhd2V5QnJocHEvVFJMbGtk?=
 =?utf-8?B?RmZ0cC9OZjF1YkszUnNtbFd2RTcxK0x6UzNvZGZHVFZkbTN6MVJxSkNXU3Bk?=
 =?utf-8?B?OXhUdzF3TlNuTnIrcU1lTnQzeG9pc0ZlNmZjaGhxc0lZWXEzakd1U2JVazE5?=
 =?utf-8?B?eFh5bUVQdEhWQ0xZQi9NVy9EWHQvMTRwemlacnJ2M0dzTGpaTjM1eDhxT0NQ?=
 =?utf-8?B?WFR1RlE2cXU0UjRBclltdnRyZzRGMWhSZHFJU2xIa3lGMjNjNzUwMm1VajBF?=
 =?utf-8?B?OG52d2JNb016SDZMN2Z6TFQxTXB0aWVBRnRsWFZXeFVSM0wrVnIrejJkUEls?=
 =?utf-8?B?b1JwOS80RzhZY1NOa0I1ZTJKbmZsaDB1ZDYraFlwSW9TSXQyN0hPcFVxZ0g3?=
 =?utf-8?B?b05RN3ByVVFtN2dLVGZJM2s1MXBNQ2dWcWxUVFZWeUEvOS92ZFhWS1dqd200?=
 =?utf-8?B?U3BaQjQwS1RvVy95amFyVStZS1BxZ21Ia3lGQUF3cFh1VnltVFZqRjdhSFpt?=
 =?utf-8?B?SHZETjRJMEpxallWRHFpWm9IRFBudnpJb1I0L0RaWGdwbEQrU0xzTHpQTU9r?=
 =?utf-8?B?ZlF1a2dNbm5nSWdFMXJCNngrT1ZPS0dMN1pmZE9NYnNPd09XR0tuY3ZrM2wy?=
 =?utf-8?B?MEpxQ3IvYUJ2ZjhrN2t0NitwRlpRUThEOWVhWVVWUU1lRkRncWtDRWFmOGNq?=
 =?utf-8?B?Ry9MbHpmc1pCSGk1ZTh4ei9lMEJ0dHJHdUNmV3lWUFo4dUthVGE5VUxDSWFL?=
 =?utf-8?B?NXJsdWw3b0toQTR4ai83MTZXWkJZM1RRcnpPd3h3VjhkWEw2WDdLbjJUZ1F6?=
 =?utf-8?B?UWNpSmNtZmVNMFZGNURZUGVnZjdDb3FjNEFsRFFRUDRKZ0RqWHp6VzRtLzM5?=
 =?utf-8?B?SDBwWGlMRVNlZlZiTmFNS3hxUXRZL0FUWEtiU1FhOG5tTDAzekluNE9FclM3?=
 =?utf-8?B?TnNyY3d2dE9SYjRlb3dHRGJmSDl6K0dWZlFvTGE3L2Z4Si9lTEVha2tJQXk3?=
 =?utf-8?B?WTZEWnBjRlJlM2s2VVlsdklyWE8wV0FPbGc1ZWJ1NTVkdmxZN3YwSWwybThh?=
 =?utf-8?B?ZmkrWE5zOVFMNnA3RERIRkI5WlZPVTRpUGY1MDE4ek00MnhQWWZGNDZQUjl1?=
 =?utf-8?B?ejBmZ0JidVZndE13ZGM1a2t2cmsyWHlZVXUzZGovNzZzNU9ZdE1tNHo2c2RF?=
 =?utf-8?B?YnZ5bU44Si9BSGE4UWtVNlkvZndWTmhVQU5aVDY5ZlpEaHQ3WGxHRlJQb3lM?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pd/3NPcnU5SwoWjEQOxZHUbUE0qeq14G2Ysw1LxdjQKEKKorB+PKk0KM6Lqrz84nGVC+lKppLKL3TNOxyqSLv2lSnP8LzG+uxbVTPUxl/eIjmR+fPjHbEPtiHwFzeOCKFI7ANOUavgbAm54XN0GD0QOPeHb4Rd1Z8on49kD7BxSf9KX31WfMiBvBG7eKrhTToTgAQ6ON/GIMYFdBxnagpTLyNEbpZvtZsVv3VybmyZMtSDIYnhrTC5AScoIKrQYq66BcxPpisxBhhGNNCQ363U4mVLaMtSNCImA8a1/WWM0fG3zSmp8neYAdNi+Bue6vtNMqdLD00mfvQieJRrgPwgupInE1aTBcitAW0y+vqxkmsC1oyfuduKQWT9CppHgAwj5oRyug6dRb9yKmNAi4KKlHxZ2STsPEzsI69VoH4fs8D5XrXuSkGKjBxlaSxdu8jVpjdkxiGhhNVVJNJDA+fAi7a0O5RQygeMa1U/cw+OC7cF17h2FoymoHgx4R4UDh8cov05S8ip6JvhriQYbHgUVkGc4wbF8d3P4bWhfGrRkFSDB9VXVy/eRjRgr+5KrxSzDwxx4Cg7rvu2b76I31/MZit9wKaRbx2n0LjbpH+78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fe22e7-1ae9-444a-0326-08de0c8ecc27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 08:34:18.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+Z1J8utVXn/w/T1A0pALEWEWj+9AnXbvRILit/Fu+myLb2qiFOqfo7X6R9l0Cz/6Fha0m+hsf4QBi0KRFwpvbddEH9af4GzjYiyaAF6E1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510160066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX9+2fArU5ka01
 VgRngPNnIiUHDvNpqBewJk7eK6qmTE46hZ/ULQDw8vPzASx3VREByHTnLh4iEnF3CjFbnU0afl5
 BBWCzX7eqPqX+d/Kvou4Si7eDhJ/0CA90gphFaU3bBbfEluRyF3tVt1pO4uRRg4uQA0q1qQFBWS
 uDJnQq0bnrzqGwu+F1MG927kij+5/eCpwKsOUWLqcONZ9Af6pKhx5rZrtkV0gvnPbzP0coY7TrM
 NMt0GQhws/seobdT7D4mm/UNxSga6Wz74LD7LG0yxmQQ5iEGN/N5AwnNcoaaYal2L+jANUN8Rlp
 P51ZXckoL/a2Qs6g9gAvhZRu6W7Kl0CLIVTsKKJhEg6G3Vthx5Fj4ltstnYdGXFAZqKa3TnghQM
 Eri72lvYtgcfOFBUNkoJ+FF/y2an3A==
X-Proofpoint-GUID: s0MfEy6C1NYzR3uCPEHKr1bLpvlVxR-8
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68f0ae12 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=Ikd4Dj_1AAAA:8
 a=jDO9k1tB2vECKtU-ZyMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pnI2m26_WTs5bHz79ivh:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: s0MfEy6C1NYzR3uCPEHKr1bLpvlVxR-8

On Wed, Oct 15, 2025 at 06:57:37PM -0400, Zi Yan wrote:
> On 15 Oct 2025, at 10:25, Lorenzo Stoakes wrote:
>
> > On Fri, Oct 10, 2025 at 01:39:05PM -0400, Zi Yan wrote:
> >> Page cache folios from a file system that support large block size (LBS)
> >> can have minimal folio order greater than 0, thus a high order folio might
> >> not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
> >> folio in minimum folio order chunks") bumps the target order of
> >> split_huge_page*() to the minimum allowed order when splitting a LBS folio.
> >> This causes confusion for some split_huge_page*() callers like memory
> >> failure handling code, since they expect after-split folios all have
> >> order-0 when split succeeds but in really get min_order_for_split() order
> >> folios.
> >>
> >> Fix it by failing a split if the folio cannot be split to the target order.
> >>
> >> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
> >> [The test poisons LBS folios, which cannot be split to order-0 folios, and
> >> also tries to poison all memory. The non split LBS folios take more memory
> >> than the test anticipated, leading to OOM. The patch fixed the kernel
> >> warning and the test needs some change to avoid OOM.]
> >> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
> >> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >
> > Generally ok with the patch in general but a bunch of comments below!
> >
> >> ---
> >>  include/linux/huge_mm.h | 28 +++++-----------------------
> >>  mm/huge_memory.c        |  9 +--------
> >>  mm/truncate.c           |  6 ++++--
> >>  3 files changed, 10 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 8eec7a2a977b..9950cda1526a 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -394,34 +394,16 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
> >>   * Return: 0: split is successful, otherwise split failed.
> >>   */
> >
> > You need to update the kdoc too.
>
> Done it locally.

Thanks!

>
> >
> > Also can you mention there this is the function you should use if you want
> > to specify an order?
>
> You mean min_order_for_split()? Sure.

No, I mean try_folio_split_to_order() :)

But ofc this applies to min_order_for_split() also

>
> >
> > Maybe we should rename this function to try_folio_split_to_order() to make
> > that completely explicit now that we're making other splitting logic always
> > split to order-0?
>
> Sure.

Thanks

> >
> >>  static inline int try_folio_split(struct folio *folio, struct page *page,
> >> -		struct list_head *list)
> >> +		struct list_head *list, unsigned int order)
> >
> > Is this target order? I see non_uniform_split_supported() calls this
> > new_order so maybe let's use the same naming so as not to confuse it with
> > the current folio order?
>
> Sure, will rename it to new_order.

Thanks

>
> >
> > Also - nitty one, but should we put the order as 3rd arg rather than 4th?
> >
> > As it seems it's normal to pass NULL list, and it's a bit weird to see a
> > NULL in the middle of the args.
>
> OK, will reorder the args.

Thanks

>
> >
> >>  {
> >> -	int ret = min_order_for_split(folio);
> >> -
> >> -	if (ret < 0)
> >> -		return ret;
> >
> > OK so the point of removing this is that we assume in truncate (the only
> > user) that we already have this information (i.e. from
> > mapping_min_folio_order()) right?
>
> Right.
>
> >
> >> -
> >> -	if (!non_uniform_split_supported(folio, 0, false))
> >> +	if (!non_uniform_split_supported(folio, order, false))
> >
> > While we're here can we make the mystery meat last param commented like:
> >
> > 	if (!non_uniform_split_supported(folio, order, /* warns= */false))
>
> Sure.

Thanks

>
> >
> >>  		return split_huge_page_to_list_to_order(&folio->page, list,
> >> -				ret);
> >> -	return folio_split(folio, ret, page, list);
> >> +				order);
> >> +	return folio_split(folio, order, page, list);
> >>  }
> >>  static inline int split_huge_page(struct page *page)
> >>  {
> >> -	struct folio *folio = page_folio(page);
> >> -	int ret = min_order_for_split(folio);
> >> -
> >> -	if (ret < 0)
> >> -		return ret;
> >> -
> >> -	/*
> >> -	 * split_huge_page() locks the page before splitting and
> >> -	 * expects the same page that has been split to be locked when
> >> -	 * returned. split_folio(page_folio(page)) cannot be used here
> >> -	 * because it converts the page to folio and passes the head
> >> -	 * page to be split.
> >> -	 */
> >> -	return split_huge_page_to_list_to_order(page, NULL, ret);
> >> +	return split_huge_page_to_list_to_order(page, NULL, 0);
> >
> > OK so the idea here is that callers would expect to split to 0 and the
> > specific instance where we would actually want this behaviour of splittnig
> > to a minimum order is now limited only to try_folio_split() (or
> > try_folio_split_to_order() if you rename)?
> >
>
> Before commit e220917fa507 (the one to be fixed), split_huge_page() always
> splits @page to order 0. It is just restoring the original behavior.
> If caller wants to split a different order, they should use
> split_huge_page_to_list_to_order() (current no such user except debugfs test
> code).

Yeah makes sense, though now they can also use try_folio_split_to_order() of
course!

>
> >>  }
> >>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 0fb4af604657..af06ee6d2206 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3829,8 +3829,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>
> >>  		min_order = mapping_min_folio_order(folio->mapping);
> >>  		if (new_order < min_order) {
> >> -			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
> >> -				     min_order);
> >
> > Why are we dropping this?
>
> This is used to catch “misuse” of split_huge_page_to_list_to_order(), when
> caller wants to split a LBS folio to an order smaller than
> mapping_min_folio_order(). It is based on the assumption that split code
> should never fail on a LBS folio. But that assumption is causing problems
> like the reported memory failure one. So it is removed to allow split code
> to fail without a warning if a LBS folio cannot be split to the new_order.

OK fair, we shouldn't be warning if this is something that can actually
reasonably happen.

Cheers, Lorenzo

