Return-Path: <linux-fsdevel+bounces-23273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D2C929DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 09:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E21C203A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB03BBFB;
	Mon,  8 Jul 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AKKGj2g9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CSShP/+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E23BB22;
	Mon,  8 Jul 2024 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424922; cv=fail; b=nKqy99cxw9gq+8YUE8AcZfq7jkYJ0qgI19a9x4J2tNoduGQZU0Ttv+O6fdVT36nRz2RVTTlVmi37bs5x65U2eXg3Z/RKyR0VYW6ncYhuSnMTbIbo6M/kPVlJXKX/tpfZEEar5mqdoGs8qtDSj4iCsS0/TZk2Rr6aTAFdkYxJvCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424922; c=relaxed/simple;
	bh=e0I+z7yL1lZgq8TmLw2wzW3ENKQZ+pvTxZNHr3Ocx0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oC7gv9tHtSEFlj1wkeyQrpuDUPjMpGzWmMQmtnqb1lMJ83vd2XyLInrRG0vpbmYwpWx7uortFnVrcv6vQsOFonCFnU5gOLfaYSm5kg5XegXjnEFIpQamNtNzrgnu3vPWmbwAXLCC3QNjx9WISNw8ZqSQqmw6r5TVnwXBrW4aCBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AKKGj2g9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CSShP/+n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fXIX016786;
	Mon, 8 Jul 2024 07:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=/twAviXBzuGMehFWIwEx0EeHK0drtR655/LHbHw981o=; b=
	AKKGj2g9AebhCgkyZV0LuK2eny+gndzoKCM64VOASTDodKocWU9l4qVZsal0NCz8
	u8JQXi6LEWp9Kg8ItIuR5UhnsS2RM0MAUlXllQ23k3S1K0nJZw9eFXnJ8rAPqV8K
	sIREy8tHm7gUc9Lp9BkXDx8Gh/lpPnzyw8kfPOVh4J5iK9edewuAo1y9tPY2R0Dt
	VLE1HVim3RliE6wfuiq8x33E+wa2MirMBFeg74wy/+NtX1IUJjmxB9/Qn/DthtGP
	FTewT4j+TDiDVo1rCXsJjkPRqmNglSSazdQ2ADKHOZ+KmZvbVCJ9CRtn0wPWSuH2
	BH2bFlQQTZESOH5PKQlk6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky20x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 07:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4686u6tR029822;
	Mon, 8 Jul 2024 07:48:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407ttrsxa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 07:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL4wxjdl4ExyiOfPxG6gKW0zX7pBPW++1YHN+4VVfDgdq4MEFsRxI1Cyp9mTqYueuV+Q5zigyiBch41Q8ap7J/0xMJxQ1d+ndf5agkLMMss2O6/tp3NT66RVlnUCdQFT0unL5oRuF65yXQSpoEFuCFfDBSdgGOoNb56rWBcn5dFRY8N747vyyRBO9xVHqql6TKSYjcYpYG8h+wAWQzK16HjPrWr/7OoQ8FidNTr64uYDyEkZQntPrZVrsLkvYFiRC9YhcahzWYdum8wewFTw/sdw0XyQ1HDBtP2Fp16pnsyEoF911kC+DMiNt8MUG4MixSWbWJxXAmrasktQ3/myVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/twAviXBzuGMehFWIwEx0EeHK0drtR655/LHbHw981o=;
 b=JzaE21AhkGLYR/DGbx3jWq2auZpHHK1ConJkMT8QOmV5WSs1zFacPw7zEwY+x2gl3ENP8aPIvOw9yIwLhwlnOKYjBKLXadl/BzQlE2/Qh36ltIqqWZ07ZpaJBdiXHU0stZgYYjQqtrGYQluGVgV+gGiYgO7osrVDc2LPbzEO0z7HaT+nZI9ydmiV1EE5aMiTt/z28JXQ1YfbwqBx1VU1L++MOXsw5M0Cp8+PaOUiJtxJJWj0er0Y6Tf8K4zyX+hmTqxU5bQOZh4VYqjUHKu01sMqH19ncNSQ8vW4wfvE9xZdoTrwA7LrGTkCcZPAbrTcZYGEnigOOrcP402xaD2lgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/twAviXBzuGMehFWIwEx0EeHK0drtR655/LHbHw981o=;
 b=CSShP/+nHYyw0m+wZ11waRmgzGwyGc24AS7R8yflLEdA1DTKb2rldS5aslRMB76kyUGamS8+4bf+g5KB7RNFS9Kjw9j2Y8emLaOn2SqZWq2v1cnCtA072j0Ax+1y+KTql8GPNytamxFTBauxSZJd9LWeXZrF6w8E/GelKD90Lbs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8091.namprd10.prod.outlook.com (2603:10b6:208:510::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 07:48:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:48:27 +0000
Message-ID: <e2799d3e-734e-4909-ba90-931799ef486a@oracle.com>
Date: Mon, 8 Jul 2024 08:48:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] forcealign for xfs
To: Christoph Hellwig <hch@lst.de>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240706075353.GA15212@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240706075353.GA15212@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0025.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: 71aac632-253f-4e1c-93f9-08dc9f225a02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUQ5SzZaMENMRlArb3diRkMwZXZEZnlrdnYyQ1IvQW56MDNXNkNyWE9XajJK?=
 =?utf-8?B?NTdiWFM0VVBFR01qeGUxdVI1ZmRML3ZEWUJFMUYzK2k2Y1QvR3hqdFV4b1dM?=
 =?utf-8?B?ZWlpOTdVRzJEYW11YmdyQm43NTdHejdZdzNTOFZGWEZNNVJMMEpLcXM4VDRv?=
 =?utf-8?B?cWdJZzlOUkt5OEdCOXY1eFFEUEJnNDR3d0k5aHdQVEF2ZkFFMGdMNVlwbzd1?=
 =?utf-8?B?Q3VrTlJuWDB6U2x5S0JLVXlJUU91cXBlU1BPREhMT0U1R3pid04rVndOaTFp?=
 =?utf-8?B?TmtydTZPS1ZGS3Y1SWdLTWlqSk1vZDdpbHlWSWJHb2tYK2VHOENacUtVSTNm?=
 =?utf-8?B?Q0VpallVMG5mbWJ3aVg0dDBPOHpGOXlvRG8zcFRRajNGRG5IS1Uvb1FQVkZy?=
 =?utf-8?B?Y3ZyYjFBSlBTalovSktlNWJxNWNkRW5uR3EybDlNZmczL25mWnE5T0RVUlFt?=
 =?utf-8?B?aDVvTTl3c3Z1VGpidmVzekNOTXZLZm1xR0NaeG0xS0pkYW95a08zNTRQTjVx?=
 =?utf-8?B?OHpkYkgva0ZZT3JGamRVOWhPRWpkajRVY0tIYU1ZME5UbVFOU2FML2hZTWVu?=
 =?utf-8?B?dkpxZ1d3SkFEMGduRTM5cnM3Mm1SZnFEVFBrWVU3blJFaml5RVo1SnAxWXU4?=
 =?utf-8?B?ek8wSWd1d1FpR2RGVU9Za0Z4eElXekIxYlFSVUZ0ckIzMzVkVkRXSUxTNkt0?=
 =?utf-8?B?cHEzVkxGajlXOGRZNmd5UkZFRXdLRlkzV0wxNmhEdnd6YVBydCtPKzNyOC82?=
 =?utf-8?B?VXljQXduK01jcWhrKzJBQXpkQkFYOWFzall3NTUrcTRrTHdrckFMZVpIbW5r?=
 =?utf-8?B?N0ZoMlJSck5sMjF0V0ZwUVJaajdieEJMNE9aQUxNbTJwbnRTa3NtNmZVMTZx?=
 =?utf-8?B?VU0zZ0EyWWp0OUFmeTB4MjlhZDBXbEtidTRjajdpS0VkOUQyUWRkcmNGNDFh?=
 =?utf-8?B?MDVjeG9pdWt3ZGdhQm16U0E4RzV1TitDY0J2WmtMOFhuVW53ai8rNWZuakU5?=
 =?utf-8?B?K2tqbS9zU1o1T01FK08xTEU1RGx5R0lScmJ5MXoxb0JLci8vWmk1Nm9HcTBN?=
 =?utf-8?B?V1FoMHhyZ1VWOERYRWowOGVDZG9FR3pmcUdKekVCT2l5L254Wk1nM2hmSkpi?=
 =?utf-8?B?RzB2QzA2WFRWcFBYdStsYjZWeFowWmZ6YmNjVW1adld3cTNOQ01vSTVNZ0l3?=
 =?utf-8?B?UEhlbkIyNFNkbjlDZk5CdGlERHA1U1VZcnVHb28rNWs1cXhIN2EwZlozSzFa?=
 =?utf-8?B?TjkwejlSOS9RcGROV01maHJmQUdnc1pWZGNjTU1rTDVIUnJJMldFUEdwRitZ?=
 =?utf-8?B?N081S1pEY2w1OEZVcnFiWFRTa293K2kzM2JZK2NpN1RFZVZFWHVObjBtUG5B?=
 =?utf-8?B?cmNzOGRLZlhxUmdGdWJ2WTE2YzN6N3VnNksydGFnR24reDVXMXAyN1VwWjRa?=
 =?utf-8?B?cnNKc0hXSGNVeVVpcS9RcGV3VUM2N3Y5VHFuOEhVQklHV1NJQmtOL1NVZ3F6?=
 =?utf-8?B?T3VrNzNXcjNCZkFVTWQvQ1F2b3J4T1ZVU0xPRkgxcy85MDdDcjBZNWpuMEhB?=
 =?utf-8?B?cm1qTHNBSWFZK2w4UllCZUxGaFZxdlBlWTU3aVFKa0haYXkxYkRNOUFTMlBN?=
 =?utf-8?B?ZzJKb1lYTHhWQW85WEYrQkVPZGhJYWtUdG5pRzZEZ2k2N2tLY3NHc0tkNVNx?=
 =?utf-8?B?WnF4KzZqcVVFWmd2UGRyQTN5bk9OMENsb0g3bUJabDRwVjJsbzRRWUNscXNk?=
 =?utf-8?B?REZmR2ZXRFNtb3VPd1BJKzhNaGpBQXcxQmxHU3pkU2hZWEVpSWpLcHBEOXNk?=
 =?utf-8?B?ZHJ2U3doMGZ6TG1JNzBXZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Mzdva3M4MS9iMkxjZnI1QWpNSnFXeStHTDdrdkhveDJLdlh2dGsyK1FGL0Nz?=
 =?utf-8?B?SEJiS2krM3NsdkVOZjROZzNTeDFtdHRJMFV0UXNWc00zYlgzNitPd0xSV0x4?=
 =?utf-8?B?a2hwMEdEcW5sbXR6cDhkdW1jZnJhcTJCY0h6MmY4VzQwK0t1aldEYVpUR0tm?=
 =?utf-8?B?REFqUVRRSzFWeGVHODZEcHFxTytNNWlBVU1oL0NuN1luVGdXbGhwOGdmdTZF?=
 =?utf-8?B?eEtuekFQRkJ0U1JiSHlsQTZLRnNNV0d5R0MxSTZwQnNXYUlpRE84YlRENlZ6?=
 =?utf-8?B?MjZ2TWlSMlhqaVlja1M5bFZjQTF2eFdOZTJOUTl1Yi9DQktvenlpRWx6NUpv?=
 =?utf-8?B?clB0K3pCWmg5c2crMko3UGFYUzd0RTdEOVRUNG9yOUdzT0piMzdUZDl4ZW03?=
 =?utf-8?B?QnczQkYxMG96UVJmK3d1czUzOVJnS0pPSWIzV0dFdE5sNEpPdSs5NjNFWHBZ?=
 =?utf-8?B?ZUpXemcvSFkyeVVnaCs1TDBrZnplbUMvS2VBQmc4UEhUcGxjYkJSY2o5Q2dF?=
 =?utf-8?B?SUV0MklPL0Z4Sy8zYnRTMjg0aWNWZjdZWGVBYzRwcmlKR2xjNXQ5ZUg5R3Mr?=
 =?utf-8?B?bGVEelQxZHc0WEV6UUpRZFpjQWRWWU9Pb0ZZVm4reFBud3NBdU1IcCt2alJB?=
 =?utf-8?B?UEVaTTVMWVphMm4zLzFraEtpcG9BQm9uZXAzUTdTeTdBSW54RW1KSEFHVStq?=
 =?utf-8?B?UDNQWnhNaVNXRHU1UE9tUGxvZkpZajVnNzhNOE5neUFoOFdRbUg1YmlEV2d6?=
 =?utf-8?B?dWx5MHJMWFYxbGx2Tm5nck9xSWhQR0JIcHdiMjZ3Zk1POUdqNXFHdUtVaWcr?=
 =?utf-8?B?djRxdml6SjlpTnQvQTFzNit3bi8yWHZmK0ZWcG1GWHRLcXdHcEIxNDlHNTF2?=
 =?utf-8?B?MHpZTmc0K0hwRWdoT2Q1UDRSalF4TktlcXdpUmdsOUIwQTNMTjdSaEE1eUc5?=
 =?utf-8?B?blNpR3VWNnlNTzJLdUpydHVYVVpMTzlkajdxeFZSaU1FVGFkN3VVbHRqNU1n?=
 =?utf-8?B?ZUJ0RTlwY040cnRkY1JXdUlncmlMM3Y3VkhqNzFET292TUdHTHU3RURsaVZS?=
 =?utf-8?B?Y096VURGOUltQTMwOHErWitQc01hS0pmcDhRdHl2NGRjYUtOTjBDenk0YkdN?=
 =?utf-8?B?UUY1aVY5RC9pT2Q0cGt4TnplMGpZUk5GSTdndDVXd2o5M25RQXhJNm5IcUU3?=
 =?utf-8?B?d2RpcGw4cFI5WUlTMTRFZjVSbWkzZHZJK2h0RDg5aVJvL3d0L2NhVStDcWUz?=
 =?utf-8?B?aXZkVWFFWDlZeHcvdEdhNHZIRHd1cVYrNG85VUc3NUdTaDVuWXdCSHR6NTBF?=
 =?utf-8?B?dGxXamhmci83NHpXU1p6bXU1eVNqTWVZc0Q3TjJUTlpJNVB3a0pZY1kwV1d5?=
 =?utf-8?B?TStxaTQwTnZTNDlSMTEwMElyWWJkV1U1dXZmMFhxZFE5bGs0UEVMNFhoalRB?=
 =?utf-8?B?MGdpYXJWYWFnOG1SanVvbUlaU1YwNnVKeDRwTUZZVnV5azZIcEdDUGdLZnlk?=
 =?utf-8?B?SEVkQlhWbkZESGFYYjV0NlI3cDdvZnA2T2Zqb2ZpMVVUd0tBWHA2WDd3TjNi?=
 =?utf-8?B?ekFhYTF5dC9Edjg0V3dhSGNXL21OTTZQVDNMbDVWUy9aekZJUGhpd0N0dFB3?=
 =?utf-8?B?NHhGYnJ3VzhsRjRlcWFEU0kzQ29hSHdYc2h0emlROGkwdkhpZWs3ZGVRbGRu?=
 =?utf-8?B?Y25DL0ZzSzJoMy8rUGJENks0WGN1ZGRFNkl3cWdQV0I0YUpLQjJwbmJscmZ2?=
 =?utf-8?B?Wi9qQ2tLaFg2UVBRYTJOLzh2ajQvOXBsWXZzQWVtbUxmQUlZd3BaUG1KTHRn?=
 =?utf-8?B?Z0dkODNFUm5pbWprc0NGb3p4MmMwRllPbGh0SEN5bDZrTmFNWDE3RE55bXM5?=
 =?utf-8?B?WHB4cGs5S3ZMZis0UUxpS1phOEhVUUk0RnNkTXRjQ1VLcDVlbGhta1BxcXUz?=
 =?utf-8?B?NDI1bk1zZ2U1d1kxWHJHVzVnTHdPTGNOYXloSTJGMHRRZnZDcXM1Yks5bTdY?=
 =?utf-8?B?cXFEQVA0MndBOW1GOGlLZzBibldOdjRKNFdWbnFBZWt1RmF0ZExMRW5yL2Qw?=
 =?utf-8?B?a1UxaHlBT29TME5tNW84c25yU21sRXU0RUhQMEdOK04xRDJ5WGtXT0V1ZGl0?=
 =?utf-8?B?U3Vwd1F3d2VJczVtb3VFeTNseHJ0UWhlTkZ2aFBCVE5kQk9iaTBWckY0Snht?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6IpSeZNWTefAYJ4k9sqE7ABYpG8jcp4YIaByYlb9thaF/bX9WoWlPGSV8hzsDqgu6GO9+3kAB6tHGiaeSwOubUSpdIC3WG7CVrgWVCnm59dgbfFuEhTHWljkpC/pw/xwy8eWKesJlRBsGeCQWAfbg0HHmDkitt6AHBe35ybIJMwOT9gDhroom2EEEpxSgt98nslh5SeFGVa5zEr4Uvds4ClZSAoQeIvxwE2RKVXnmWW3DqkqD9E+iIViG5EDB2814sfN4rRyPkUshEAFZlVG/BNCdQuXCN6Ox8X+4EYkOKQ57pjduyu6Mpi9o2WJeySfebPZzVCZJ3b8BsVIlbbJKWo+5z/qlgIFmGlBYR4LBu3i0EDuOT2EYvii7SwybyBelP+0Sx5i8zNE7dOuIhxJmbtzq8CHtQHLpunVm3Q7rlDvjscFLyoT0C0DHowL1xL+gxN/FTkgi9ZO3z1oa53i5rUfCk0sCRUXjrZrNY9W/HNhr95lB2CLQfc2VyvYHLxROXMANGP1mCp3lrstwsGcw9HdTtdqvTew8c6FBT1mRJG3Bihf5B8uajYzm5YzmLunxlJs1qV6fOz4dn8yvC8LG1s+aAokyC2YsxxkIiYzDLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aac632-253f-4e1c-93f9-08dc9f225a02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:48:26.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 411vPRkCvgHkvJCwWU4tNDfTo6e1/y97YGWQxfxHT+nbSDJwiQgaKCVQWg6zssocZW80dX0p5zL6NnXGviDR2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=867 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080060
X-Proofpoint-ORIG-GUID: _-jSmq9esgSoFAyzzRkaVQ3T0au8KX3s
X-Proofpoint-GUID: _-jSmq9esgSoFAyzzRkaVQ3T0au8KX3s

On 06/07/2024 08:53, Christoph Hellwig wrote:
> On Fri, Jul 05, 2024 at 04:24:37PM +0000, John Garry wrote:
>> The actual forcealign patches are the same in this series, modulo an
>> attempt for a fix in xfs_bunmapi_align().
>>
>> Why forcealign?
>> In some scenarios to may be required to guarantee extent alignment and
>> granularity.
>>
>> For example, for atomic writes, the maximum atomic write unit size would
>> be limited at the extent alignment and granularity, guaranteeing that an
>> atomic write would not span data present in multiple extents.
>>
>> forcealign may be useful as a performance tuning optimization in other
>> scenarios.
> 
>  From previous side discussion I know Dave disagrees, but given how
> much pain the larger than FSB rtextents have caused I'm very skeptical
> if taking this on is the right tradeoff.
> 

I am not sure what that pain is, but I guess it's the maintainability 
and scalability of the scattered "if RT" checks for rounding up and down 
to larger extent size, right?

For forcealign, at least we can factor that stuff mostly into common 
forcealign+RT helpers, to keep the checks common. That is apart from the 
block allocator code.
> 


