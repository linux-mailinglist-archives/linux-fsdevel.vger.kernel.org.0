Return-Path: <linux-fsdevel+bounces-36617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B59E6AE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CEE1882FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A911FA24F;
	Fri,  6 Dec 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cyLuGRGB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iy5+BpOG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372901FA164;
	Fri,  6 Dec 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478205; cv=fail; b=uV5LMPosJ3+6t5xtVz6t4LJOSPmDAW6QbYZvogeHp9nHVBrvdfSMq2BdXZ2qoXCKJhape8RP3la5SP9NHt6J2q/Zn2JobNn5YLOVvj4sgTRbvs8unp84rbpgf4wGIr3tHRPv94lNeiVco8SKC3iERz7nyKsD8gm7twM8JwDOG4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478205; c=relaxed/simple;
	bh=jTtrwM2os9y6CpCNiE74KnY+9yLW5jRlgu3419+XlF4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qKFRry/tSzzc8YiikWPu0p/Y83bg+qBKFFloQTvtkOq1T8BkdX+m+GEuFrS9pbF8PnrMOIS/i+kfgBlCkYWUTAB11dVp1dIrHt7YNkm5x+A4O8NxdW85VVHC9pTnmqF/sfrgJOOAou2KnsipiGLtOIWeqTtauEk1+4i11lHJalI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cyLuGRGB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iy5+BpOG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B66s4Er020813;
	Fri, 6 Dec 2024 09:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=U7Xa/Wpu+cN34nhFVk73SbLA9QZHdrtv6L/+PPU/QCQ=; b=
	cyLuGRGBaAW+qye8KH0KaDle/gEnjDtYxMegdXPRZknGFxYYnNcM/ls6+9Q0nCIy
	DweOl+79Q+GtD8t+H4mW5xJ0gQtjO9rlqo5SUpcZn21N340si/LXSmjbW0o9lKfn
	8hNTsQ7cVgSr14Cr3gFYvmzD8WTQxvNcpZ0sH5lHG+QjRa/yKQk+HtXuJyD694rK
	yEB/ccKfW2Efdso/ABygThdxx2HQuElbheYQRf0At1+SlT44rd62oBl7PT+G7mME
	nfINLHSw5AaykGJ/OFhz4ZQhW4qUs3ZT8dKsXPgTeQHNxB48VSZNvedFICwabDBM
	58k7DO61LLO12b9AWlHy7A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbw6d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 09:43:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67j9aX036791;
	Fri, 6 Dec 2024 09:43:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5cmp09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 09:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWua55hXL77iZxH0mUfxlkhcV4KDOlAzInPswuMeGkMyDhhHvWnKHn2HDafaS1IQdmVWRfMpbn8o0vABUIrSpfCcJgOh3JqxiE4Yam4SKjRJ7oGn6n/6W0RR3DQ70AZdQrkPz+J8ZB9eb5R1Fi5issyKzDE4w+jUmNU6Sn19Gxc0TagPqk7GCBo56KQ51rhDMpLl/HsHFLwOGlJUc+G669wNBN8PXxnHZhjasDiRDiWBvQs/rK5zi4cA4gmiWahtMC+OMMfFcNtc+YoFwYogyJ4J1Iyp5hQt6nmqVVvTnzfY2FnIkisDHcsKGBsIEzkSzCGARYv0BMUJfc5zBKncAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7Xa/Wpu+cN34nhFVk73SbLA9QZHdrtv6L/+PPU/QCQ=;
 b=HLXOtVjHNrzwvq/2DcK3StqLflN+8XdqpR3dULU7OOp/pRMWpd1CzzyJ3CkAImN2dKH6V5gwLRWTzOawBF+QT3Qnr5+3BBKf4MWLf2/oZD78ysLPMCc/VmNtFBLPnttPoSKrtsmpna8+g2co2UD/A3CGbqHRFJ6Cu3ROZRtLHbIlwubTGVZVWrl/sBn6bA74tGfPfyt4fxUIrZ9F0FnqAh0GlB4IJ3XtMIDFKeM9Kivo3aVszht+qXCr/HvG9LrizfrUxgzqUKsY4C0moxoeDpHYxr/4SBtbZO+x2vb7zj2ZQcGL1pM6dRIBLagGPVnBDPsQRd+cHd/joiTR5adgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7Xa/Wpu+cN34nhFVk73SbLA9QZHdrtv6L/+PPU/QCQ=;
 b=Iy5+BpOGW+O5WdhHFULvNFxKyCa1Xt7Cy64mVLxoDm3qt/v95WtsGt9GPBG5I0Vs500PH5boEpijfUbGLP8eCGt+JC/HWcCF6IGHu0LmIE9e/k86HbFOrkak07XXBa97/jri2hJGeGbeaKj0LPeuhblqe9DhSnMZgdvpneQuSBw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4800.namprd10.prod.outlook.com (2603:10b6:a03:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 09:43:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 09:43:09 +0000
Message-ID: <956e081a-2f1c-4a8e-a5fa-49eb91778eee@oracle.com>
Date: Fri, 6 Dec 2024 09:43:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
 <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
 <Z1IX2dFida3coOxe@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z1IX2dFida3coOxe@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0026.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: e4adba49-9ac7-441f-7e84-08dd15da6461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2pXeVNuMGxuVTd5NXhjeXpPSVRqNmNvMUlMYVRleDBsb3huWjRqbzc2L2Z6?=
 =?utf-8?B?R3RuWnlJYUdzcUkwWThwQ0N5TDc0VllhRDZWdmJnd1MydllveTlPTnZOdTVX?=
 =?utf-8?B?YUdVUUNDOFR2VjNhek5aU0M0eHlscW91MnJHOFE0dGRqaER0MGk0U2FwaVhH?=
 =?utf-8?B?RGUvaHhlQk4vNWxwZ1BKZFJhTVVBSFlYMWNIRC96RE5LbXlCMnJsa2dNZERp?=
 =?utf-8?B?Q2ppNHpGZVplS1NFWERmdkt4WnNmcDdGWkJBZy9DaEhtWkZUb1F2UmhzY1FV?=
 =?utf-8?B?L0hQRnFxbmp2Mkw4QnRqM0xJeC9haTBwUE0ybWtCMTFWK2VNVXhOQkcrQnVU?=
 =?utf-8?B?cDFEYUFqQXE1c25UeTFEN2FGU0hVRXRjTC9zOUlwTHlpdElueWV6OHZTcDBS?=
 =?utf-8?B?ZGhEU3g3Z0grS2wrNTRHcTNuM2dpandZZzQxRUZXZXMySnhhR2RDekVNSnR3?=
 =?utf-8?B?MDdDWE9RV1NKZGlLSXB6dnVsbFp0dkw1K3ExeFNMNmNTUW9nSGdDQ3dsK3VW?=
 =?utf-8?B?TGlCU1hXMklEZm80RWFTS2V1SWp1dVBoOTkrNGZQT2ZFQWdBaVBuRUNVWTc4?=
 =?utf-8?B?dWNHZzJNMS91dWZTQU82S1ZRdXNlRTdvdnlhYzgwTWUyc2QvVTVXVlEyRGpp?=
 =?utf-8?B?QloyZ2h6Wk95MGs4QnJScHJqSFgwYWtnSlUyTERhV3UyL29SZUpHR0dOVk9U?=
 =?utf-8?B?SmZ5VjFEaEFMT01PN2VaWlQzZytHRWNYRDErRDdJdFhDdUNuaTFjY2ZpenBy?=
 =?utf-8?B?eUExUjl0a1NpNUVYbWcyTTROK0NSK3BmTzNHcEtNUlk1dUt4R0VaVW5ieVVX?=
 =?utf-8?B?UTQ1eFkvbWhTSDBpb3F2aDlrNDlndUdacmdJKzUxMithVFhGTWdjUjYwZEdM?=
 =?utf-8?B?S29uSVJzWVF3UmRUVkRQdVMwbWdJV0E1SG4rSURteCs4ZjB2RVVnTjh5bHNZ?=
 =?utf-8?B?cTA5cFh2eE8za2NwRjZYTzVrQ3VKMENXcnZEVm5GY005MWJzS001MDQwNHIx?=
 =?utf-8?B?a2VBR3NXa1NnWWFmSVRxU2xZZWFuZVVWcEdmeStpOG5YZU45RmNNRVNRVk9G?=
 =?utf-8?B?dUhjcDhlWWJ0NVZNZDJQUVRtUzlnU2pRZGNlU0hSVGlOc3k5M0tZd1hkemtv?=
 =?utf-8?B?VHZjenlHbUp4emM3SnRveFlrTkc5TnU3TGJvb2dJTW1kRyt4V0JJeHB6NnhF?=
 =?utf-8?B?cjRCOHJGcy9XNDZ5cmxGYldFeVFsOGJ6a3dTS0FVY2ttcy9wVjFOUERFTjk3?=
 =?utf-8?B?NG41eEdOZHdjYjR2NFEzU1EzZng5bkZPTnlzMlp2UEFWNjltQXV4cmV3ei9s?=
 =?utf-8?B?dUxzcGEvY1hoSEdOTVhPZmJYSHUxQkxVcmovWWE4THFiZDl5K0RXSWhIWmVR?=
 =?utf-8?B?TGZXcjlEZDNXazlHOTcvM1lnZ1A5V3c0ZGJYbVNuZ2gzMWVsd2xma0wrK2E5?=
 =?utf-8?B?ZzN6c3k3b1YzcEVKSFdQeVVhcjdiS1ErNG9iRE1VK240cXRnTnNteklHR3RI?=
 =?utf-8?B?Y0RDbTMzbWxJNXJ3a3NDTkRZWlpvNFBuNXRhRnozZGJXdmVQMmpKSEZBY1RT?=
 =?utf-8?B?aVVKVjQzcDJMVzFMdTRGNlRTcXdiakNuOTBLQVMwM1BUeHJYVkJ0elN6d0tE?=
 =?utf-8?B?TkJvaERXU2xTQlNBT3Y5RUwyQ0EwWU5yWWp6Und4cXMxUGJBTWo3UnZHSUNq?=
 =?utf-8?B?MWVxRlVFdS8rbkYrRnRaY1VDVnlZYVdPdFlMZ2VHWGlWeDZ1MURPV3pzbjFv?=
 =?utf-8?B?OE5BeTkxRVdGcVc0WFJQYWlBbUpySjc2U0NZbjFqMFUxTGd3dGxHdURNdTJJ?=
 =?utf-8?Q?ZyZjyMazKzOa8SPZq87nvpadKrgeSvAP7CZx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG9vbjhOQit3MmpIWGFwZ2NGdU54b1BvNjRQNjIwVVl4U25uQlNOWDdpM2Ri?=
 =?utf-8?B?cWh2ZHFKeFNjeThXKzdrdjBaejUzejJOUWx3MWcwaDlCQ0U3Tzh5Y3ZKSzZ3?=
 =?utf-8?B?ZEE1WU5OcU8zdk0zeE04ZHA1OGl5K2twN0Y0OC8wR0ZpSEl6eWkwTmZIUm5M?=
 =?utf-8?B?TEFoOURRTERIK05JT2xIUXdtZUNSWVU3Y245a0YwaUVkTU81bmJ6dFBWTDAr?=
 =?utf-8?B?VDdMTTRsK1JTYjhvRXg2UjlXa0RiQjBuVWhWQVlHZXl2OFVVOHZ1ak5POEJm?=
 =?utf-8?B?WTR0cmhBOXNzREU3dVh3aExFL1hQWE5aeFQyN25pSENZaFBqV2o3MVJSODZk?=
 =?utf-8?B?b3BoWTVHc1BxWTZZSlB3WjRrNW8ybS9DWm5YSmZ2NXFJNGgvNTJnUGwveFpw?=
 =?utf-8?B?RzFaRlBsMEE0NTB6WjBiNXA3c3UvRUtCckdFQXFDKzVBMVJEeHVqdWczL25q?=
 =?utf-8?B?Mk01WXB6bDgvWVpUZHFRLzZHZWk4eU54VGcxeld4YkwyWGVwb0dWM2JNL0xp?=
 =?utf-8?B?OGlKb2dpQnV3U2p3aHBvd2R2ZUR4UkRyMjdjdmRmRHM3bU52eTJqQ2s5akVa?=
 =?utf-8?B?MUk3VDduc0Q1WFl4eW9PNUMwK0hoS2dmS2tTNWNMdGJPWmNZN2RwdDBRd2hm?=
 =?utf-8?B?Mi9tOVExSWxFcFNBSWgyQkZ0dGRHa0JiTkZrcDdCN3NjNHJXSE4zYUtMNHB4?=
 =?utf-8?B?NGlvN21BaVRQTVlDZ2xjb2Q5aVU0dVh5WE5oWVFTN25MVzdBZlBGTFROdDRq?=
 =?utf-8?B?V3BrQ1MyNHZ2dTZNV1F1Wit1WjJpZnFobjBLSHVwZjVYTS9vSnk0VmFkUE9j?=
 =?utf-8?B?MERHMG5NZzVtYUJsYzVsSUJmODBrbzk5ZmZuVHpEa3ltN0pBaG1GN2I0MWpW?=
 =?utf-8?B?YlM3ZTBzVkE0clRLMzE3OFBDK1ltR3FVZ2NWWE56MkpKclVib1FCTmlWb21a?=
 =?utf-8?B?aGVoYkd3VFh6U0Z4bVVWeFFhQ01qZUo3WHpIRkF1M0xROXozanRDRURwQWxp?=
 =?utf-8?B?aVR3NXUzU3NkZy85bm8zYVBqeExMV3dMSlNza0N2K0l2VDRLVURXcnQzNk00?=
 =?utf-8?B?NkN3dzlUQXcyUThaUEMvUEJyelJ2Ri9STUN2U3dVU3RBbDFCck1qSm80Z0NX?=
 =?utf-8?B?ZWM2b29oaTFpM0ovc2JjWDRzQ1VPSEduMWZHcVU3QThIMXNXYk4vY1ovWXlI?=
 =?utf-8?B?RXgyaXZ5a2RRdkhjM0hxdDZsZWdqMGpGSFllSmZmcmpkZG5FWmcwblpPWWZD?=
 =?utf-8?B?UnRnZ0lqY2MvTTdkWFJDNjY3OHFIMXVLMVZseVV1MDBFNkhPL0gvUHdzc3N0?=
 =?utf-8?B?aU5iVkZubTdYTkJadWU5NGVnb0R0T1kyaTJvUTBwTG5tWXhZcnlYZElISnpn?=
 =?utf-8?B?N2IydXdqREt4RDdQd3NXY3pyT2Vadk9mbjQwcWU4RW5COXJwQWM4aU5WaVl1?=
 =?utf-8?B?TWpYNmg5eU1Lb3R5RGJleGxNNmpyb3MwQmdKbUg5amljWERRTHV3ckZpQVZL?=
 =?utf-8?B?MGxZWHRINEpDdnd5WS9qTWEwdmVQTkVkUWFyZGVqRGpqQVJIMm5USzNOTGlH?=
 =?utf-8?B?S1p4dzBWakZUREJ0T3lrY2w4cm1sSWQ3V1dhWG4wdkRINXlCekg0ejAzRW1t?=
 =?utf-8?B?OGdqRFdGbHMvdG5xOHh5M25Hcy9OdWllMC90YWtUWWdWK1JRdzdsQ2hxSStm?=
 =?utf-8?B?R0c1aHVWQU5YeVR3SjlpNzJITHB4Z2VZdkZRb0Z6T3VIelQ3VUJJWEdRQ0lw?=
 =?utf-8?B?dGlWK21GVjNEZkdFTldDYVhWQXJoM3Z0eEh5RzJoTHpHRzV0R0kwQ1NRM0Ev?=
 =?utf-8?B?V0xMQVp4QnBIZUFsVWRBc3VBME0vQUVFZ0ZSM3k0VG9OQ3g5Mm1leUFjdGkx?=
 =?utf-8?B?YlZuQ3BpdVNzSUkrT3REdjRUUUl5eGMzamwyOWNGanpiYzRmZkJjL2VucUk5?=
 =?utf-8?B?MWZCcUp6RGg3dmNpSWZVeXgyRVU4dHhRNFpuSURKZXp4S0YvK010dzBYOXc3?=
 =?utf-8?B?VGpVVnYwcVBJYlBwZ0kwY3U4QzM5ZW9NTnRpMWF1NlZRdjcvdG5jcjBEL2NK?=
 =?utf-8?B?c2g1a2dBUEVZWU9kQTkvdTdEMWZqVU9yRVdHRVZZTWtEWXp3bTJ6VzJTeHBT?=
 =?utf-8?B?UGx4dmdTR3FGc1lLc3VNb3FWeXkzbFdONEp3SzROd0dZUmFKckZyR256cS9T?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1cn/CHANYfiKe01iYMtlGtGYgzLmiWjyHd9m5hpJzFPgd7b/HpLcZzHd7wztDekE3gtlNH+Z4BlXD4WxoXfY/824IzuIbD3ym5InWbc538lRCsQvPDJlfFW2iTcWOTeNTrg5z9zmb7Jo+Vje3KAy1d0P2y1FUhHXPa3seyg6VLtJgz0p1bjdZyXsi2CSUxSw6/YIH4FDb6XNVoCYcfzfznV1xCzDpmfpu0yDjxlluewXKwv+DMMmWHXdc/aNRT50t1xL938uK9jjeHMP0Sgbcm8zooUVuH8TMLWFwO/8n5VPy7a5L6yWXBmMhS6b1EzCUwZAEfCZK5N5SSUiJtK2BTKter50qIEFOsPMcoFjF8QYlotfvFj32jxWqGHsYUszk6DiAfn+ZYaxDR3eertUtuGf915HyjoQbGFqu89e2rRWzHdBmJsoWJpzRBluUOBq9rmwXOB9Fd7xd50Ed1zOBw6+i7OidD4xEFIVLYcJufeNUcq11Q0L3xPtbYxzVYMoKGE/5lhOytUAG12kHSlmoe3/i02yLJKRlU2tFLvFSc5ZYKmqstN2uvq5hXS4De6xLeMwC4D3Ui9nkV2adQDq72RLgQU5vMnze4nUN09OuiI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4adba49-9ac7-441f-7e84-08dd15da6461
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:43:09.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WOf6C3eJHVYiH0lXkJm4n51GQZEWhAEaSgbloAQTZ+AJE5HZ6zkCpq4+Txaye9be9T6y/pxfteyWtodonwzKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_05,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060069
X-Proofpoint-GUID: eu76VH7qhrS2Z5H3Z9txl053XUpE5tUr
X-Proofpoint-ORIG-GUID: eu76VH7qhrS2Z5H3Z9txl053XUpE5tUr


>>> Where's the documentation that outlines all the restrictions on
>>> userspace behaviour to prevent this sort of problem being triggered?
>>
>> I would provide a man page update.
> 
> I think, at this point, we need an better way of documenting all the
> atomic write stuff in one place. Not just the user interface and
> what is expected of userspace, but also all the things the
> filesystems need to do to ensure atomic writes work correctly. I was
> thinking that a document somewhere in the Documentation/ directory,
> rather than random pieces of information splattered across random man pages
> would be a much better way of explaining all this.
> 
> Don't get me wrong - man pages explaining the programmatic API are
> necessary, but there's a whole lot more to understanding and making
> effective use of atomic writes than what has been added to the man
> pages so far.

Sure, maybe that would be useful. I think that the final piece of the 
jigsaw is large atomic write support, and then any kernel documentation 
can be further considered.

> 
>>> Common operations such as truncate, hole punch,
>>
>> So how would punch hole be a problem? The atomic write unit max is limited
>> by the alloc unit, and we can only punch out full alloc units.
> 
> I was under the impression that this was a feature of the
> force-align code, not a feature of atomic writes. i.e. force-align
> is what ensures the BMBT aligns correctly with the underlying
> extents.
> 
> Or did I miss the fact that some of the force-align semantics bleed
> back into the original atomic write patch set?

Not really.

As I mentioned, if we can only punch out a full allocation unit and 
atomic write unit max is limited by the allocation unit size, then 
punching out a hole should not create a new range of mixed extents that 
we can legally attempt to atomic write.

> 
>>> buffered writes,
>>> reflinks, etc will trip over this, so application developers, users
>>> and admins really need to know what they should be doing to avoid
>>> stepping on this landmine...
>>
>> If this is not a real-life scenario which we expect to see, then I don't see
>> why we would add the complexity to the kernel for this.
> 
> I gave you one above - restoring a data set as a result of disaster
> recovery.

ack

> 
>> My motivation for atomic writes support is to support atomically writing
>> large database internal page size. If the database only writes at a fixed
>> internal page size, then we should not see mixed mappings.
> 
> Yup, that's the problem here. Once atomic writes are supported by
> the kernel and userspace, all sorts of applications are going to
> start using them for in all sorts of ways you didn't think of.
> 
>> But you see potential problems elsewhere ..
> 
> That's my job as a senior engineer with 20+ years of experience in
> filesystems and storage related applications. I see far because I
> stand on the shoulders of giants - I don't try to be a giant myself.
> 
> Other people become giants by implementing ground-breaking features
> (e.g. like atomic writes), but without the people who can see far
> enough ahead just adding features ends up with an incoherent mess of
> special interest niche features rather than a neatly integrated set
> of widely usable generic features.

yes

> 
> e.g. look at MySQL's use of fallocate(hole punch) for transparent
> data compression - nobody had forseen that hole punching would be
> used like this, but it's a massive win for the applications which
> store bulk compressible data in the database even though it does bad
> things to the filesystem.
> 
> Spend some time looking outside the proprietary database application
> box and think a little harder about the implications of atomic write
> functionality.  i.e. what happens when we have ubiquitous support
> for guaranteeing only the old or the new data will be seen after
> a crash *without the need for using fsync*.
> 
> Think about the implications of that for a minute - for any full
> file overwrite up to the hardware atomic limits, we won't need fsync
> to guarantee the integrity of overwritten data anymore. We only need
> a mechanism to flush the journal and device caches once all the data
> has been written (e.g. syncfs)...
> 
> Want to overwrite a bunch of small files safely?  Atomic write the
> new data, then syncfs(). There's no need to run fdatasync after each
> write to ensure individual files are not corrupted if we crash in
> the middle of the operation. Indeed, atomic writes actually provide
> better overwrite integrity semantics that fdatasync as it will be
> all or nothing. fdatasync does not provide that guarantee if we
> crash during the fdatasync operation.
> 
> Further, with COW data filesystems like XFS, btrfs and bcachefs, we
> can emulate atomic writes for any size larger than what the hardware
> supports.
> 
> At this point we actually provide app developers with what they've
> been repeatedly asking kernel filesystem engineers to provide them
> for the past 20 years: a way of overwriting arbitrary file data
> safely without needing an expensive fdatasync operation on every
> file that gets modified.

Understood, you see that there are many applications of atomic writes 
beyond the scope of DBs.

> 
> Put simply: atomic writes have a huge potential to fundamentally
> change the way applications interact with Linux filesystems and to
> make it *much* simpler for applications to safely overwrite user
> data.  Hence there is an imperitive here to make the foundational
> support for this technology solid and robust because atomic writes
> are going to be with us for the next few decades...
> 

Thanks for going further in describing the possible use cases.

Now let's talk again about the implementation of kernel extent zeroing 
for atomic writes.

Firstly I will mention the obvious and that is we so far can 
automatically atomically write a single FS block and there was no 
FS_XFLAG_ATOMICWRITES flag introduced for enabling this. Furthermore, 
the range of data does not need to be in mapped state.

Then we need to consider how to decide to do the extent zeroing for the 
following scenarios for atomic writes:
a. For forcealign, we can decide to always zero the full alloc unit, 
same as [0]. So that is good for atomic writes. But that does involve 
further work to zero extents for buffered IO.
b. For rtvol without forcealign, we will not start to always zero the 
full alloc unit as that would be major regression in performance.
c. For rtvol with forcealign, we can do the same as a.

I can suggest 2x options for solving b:
1. Introduce FS_XFLAG_LARGE_ATOMICWRITES to control whether we do the 
same as a.
2. Introduce a method to pre-zero extents for atomic writes only

Option 2. would work like this:
- when we find that the atomic write covers a mix of unwritten and 
mapped extent mappings, we have 2x phases of the atomic write:
- phase 1. will pre-zero the unwritten extents and update the extent 
mappings
- phase 2. will retry the atomic write, and we should find a single mapping

Option 2. could also be leveraged for a. and c., above.

Please let me know your thoughts on this.

[0] 
https://lore.kernel.org/linux-xfs/20240607143919.2622319-3-john.g.garry@oracle.com/

John


