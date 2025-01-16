Return-Path: <linux-fsdevel+bounces-39416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619D1A13E25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 16:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6F416B338
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EE922CF3B;
	Thu, 16 Jan 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mJIS43nF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h6Uhu26p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA922CBCA;
	Thu, 16 Jan 2025 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042316; cv=fail; b=Nnc7hkQMFUp+JnsGivgc9mFg53+nXZzMObu+CFXYczRgJiR9bAtWPg2SnwNrjN7oJldmN7v45+O0BPAccVQjmvlbm7r5AXAwpm2ybTFkdCYV3MdsQKNbrwjuzNtuF0tN0lhXu2NBW9/hRbvoa9pPrgFpy9cFZq7fBET1We3l5Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042316; c=relaxed/simple;
	bh=Q3DEHmWpcaKkjLkJdekV7rh2Z3Jw6qmWITUCiHY4JOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2wQRHNjeg7yeEF8PgiGUMwWd7VT65KFvWLEXAnEJvGMWbnimdVSR7DZQjL5VjDgJom9HppmQpO5fqoLSRZdpV98G563Ngd+5EixKUp79sfCWXAbPD7JU7f97O37L+pQcjUk5bSOaVNnqFzH1prvBymPTq3Yhhd7mGpmiuE3BIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mJIS43nF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h6Uhu26p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEuXA1032441;
	Thu, 16 Jan 2025 15:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Tuc5rxZe1aZ2iYOv0FWUus/6OywZNDSob3GiJqNwhw0=; b=
	mJIS43nF77KGbUJDxFEVmlqJa0kC3sXmTy+0tju8haDYjMdvN25m05qYnPLSCuij
	FbVUCCX3/dVdzeB9mj1MdtoKMv4UAdrfLzR/qyaNQDlrhCKUjtuGbX2t0YonKtaW
	vy+4S0psIJIXPkvoXPDQzP0XaZ5Qso6XasTHa01IoASNdUiR9gNyFTK70QE6dCuq
	7FaCMfVjmXkPZWE8OcmVn+KldKVjeaJRj4c04M8MShXAv8/zRlYBzpb7tW1OKVeL
	n0a6gaBHlwnowmGqhEZM4sNimmYGGlRMCLdocEqsvTGoM6Ytmlvni/y0UCCGem4R
	gE6Qhj1KCU1KM1t0OZNPpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2jmtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:45:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GFEMoC033608;
	Thu, 16 Jan 2025 15:45:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3axwsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qb5D5+2Is3XOrouHHthbcEJ91EGZPflV6feMGaKMQeBMPJY2TWehRr1vWTTJi+P7bhv8NeZDJuaV7uP7vIMY+w1Ro0WFQU/snfei3h+uULzXZMzb5pxdZ3zNLjmfN+2248Wy7LCM3LW1aXUkOTsJFLDhS4UTdBrsQD4G3kZqybhiLQ5yVhP5+xlnYdFl33R0X93aIUp98fZua6bgnARXPFcgMuNhJ5EB1oECIX68AaMBeI7IGjBxJ/F26emEXplllIkRemK8RQkqPeDPLNE1DG4kQ9YEUYWxCl5gZcaMxi/PfhscFTQGv6fAbJLuLQsAm1BYuWH2GreX+0YNQ/eGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tuc5rxZe1aZ2iYOv0FWUus/6OywZNDSob3GiJqNwhw0=;
 b=IsNEXHUHtKu0W10LrioJKOuTKY7r72olEYsomn5BHqCe+NWblOUUKZP2LYSNHEGp3k4X5Tu3o9/LzTgLp6dx+j3j04O01AzJHWJsq2MvoTJEDJ9DSsVOAlCpbU+2GKZGyqoqeCSUyF5rgx9N1kgA/gk1D9s5vlMNhHMw+wM8K4fqd18N7L7FJ9jlc8JJRpeM8E9j0Fxf8yqeWMbBNr9lx4jXYjgRGJKIrT8HeE0QPV4ZRCn7nHTRPsE/ciaNYTsPmwDs8p37o+JkA4v5BZ4aJ4PVY2LZFUxCe18CNO/lTwMcCqA+laX3VsfpVAw1vnxHvRhDuOvVzbj+Vo2qxrAJ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tuc5rxZe1aZ2iYOv0FWUus/6OywZNDSob3GiJqNwhw0=;
 b=h6Uhu26pc25zrvgrReFekq++dCq8KVQJr+cxFQ11vLGt1qXCJ1sEe83liQz76th8TsWHWNXbtbho8SOSyxJBJkShoQ8TifbdBRwuefEo1s3tGTSowVLyFlZXkhC96BAa2Zdjkc4Uh3qpsS3MP3dRAVM66CNbQVTWaW24aWuFwg4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 15:45:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 15:45:02 +0000
Message-ID: <5fdc7575-aa3d-4b37-9848-77ecf8f0b7d6@oracle.com>
Date: Thu, 16 Jan 2025 10:45:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner
 <david@fromorbit.com>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4bv8FkvCn9zwgH0@dread.disaster.area> <Z4icRdIpG4v64QDR@infradead.org>
 <20250116133701.GB2446278@mit.edu>
 <21c7789f-2d59-42ce-8fcc-fd4c08bcb06f@oracle.com>
 <20250116153649.GC2446278@mit.edu>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250116153649.GC2446278@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:610:58::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9b10bc-4f0b-4487-769c-08dd3644bde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUYyYUcvc3JPYi9sNUpheXF6Z29NRGlZaCtOSU9WVEFtblJkYVcwU3ltbjRB?=
 =?utf-8?B?NzNZSENtTk9XTE9tQkl1VlYrUVhZcHRGQ2hzQWpWdmRldVJNeERZbXRzMEtZ?=
 =?utf-8?B?STFjRzh1QkY2TWZ2TmJNNWxZL2NhSzZ5MFM3YWJzeWdjMzRoSVhtSmlSeFF3?=
 =?utf-8?B?TkVtaFVlNmtUWldHNkZESEZPQ2VRVnRsK1N3YnZ6MjhObVBZVXVCcHNUaXdQ?=
 =?utf-8?B?cWI1YVBmd09nRytpNVBIMjRiSUZnK2NDOU10aTRtSDErTDZ6ck9yRjhlQW4w?=
 =?utf-8?B?UXplZXlUZXhJb0JabitFTEhZamIwaDlVV0w5eHJGWFU4eXY3S2lubTN0dm9k?=
 =?utf-8?B?Y2tOYkVaMVhIVUFaak01d0xGN0NxVllKWFVPck5TU0FpRWdQUVp5K2U4Z3hu?=
 =?utf-8?B?L0JBTDY5L2o1SlBVRkM5UitVaFp6K0FQV2RsbmRxM0NHQyt1a29HY0w0VkE0?=
 =?utf-8?B?S3FrbERLQm02WnBBYU5TM1ExcTlVR2w4aFZKdFR3WUJZY1I0Q3JOdlMydVkv?=
 =?utf-8?B?NHhpNWtaeEtCTCs4S2dTSmNYdVgvaUw1NHRKZHpnaW1HT0pFdnNQRUlXczFu?=
 =?utf-8?B?S1lIbkgrNTNBQWV3eGlqUnptU3FpWVV2c3pKMm1iZ01BOGoyLzR1azN4TzNL?=
 =?utf-8?B?bE5WbE9uYmorSko5bVNGdmFFeVR6cXdXNDIwdkhydHBKUnVWZnJLVFN6SXBr?=
 =?utf-8?B?c21YRmFNT01RaFQwcHpRRE45OFdJeldJWmFTcGppcmxxYkl1VmUyMjNHeCtt?=
 =?utf-8?B?M0paYzJPZWo1WktVWUlJYkd1aStFZDFiSjdKT3MycmVZZzhVK2VYbGVTVmta?=
 =?utf-8?B?djR6a0x0Wld1eGswZlBrWmJYeU5ZLzA2bVNyZ0tGbXBHMHNUckNJUTAxcURZ?=
 =?utf-8?B?M3FVVmtmckxGYkxrcTdnRnNrSDk0VjYwVWIxbmkvM3piak84eWs5ZGtDYzBu?=
 =?utf-8?B?ay90QkYycFUwRFB2RVViTTlGZVdGMXBud3FoMncwLy9Qc0hvZlhua3dxMDdq?=
 =?utf-8?B?SmdaQklZWXVpU3MyTlNZclArUk0xZHY4TzZxbmd5bXNQaW9VcGZ5eEFBS3U4?=
 =?utf-8?B?RkNiS3dCZG9rZ1VYTlBjMHQxNUx2L1BzQTdFWXIvSXRMZnpuK0NoTEVoWVRo?=
 =?utf-8?B?K1JIaDkzSVZkRnNkTEtVYmQxSU5QUDdxUEozWTMzWnd1c0x6bzVkb0l5bUhh?=
 =?utf-8?B?aVgzZy9LTWZERmNlYTV3VXNRYTk5V0h0UnVzRHJUL1BrZ3EySVVhWVhaeCtm?=
 =?utf-8?B?TDBmOGErVVJIdXFseTVmUjNLMkJzZmVQR01TL25oZnM0M3dpK2lraVEyWlhi?=
 =?utf-8?B?REFYRVhpdVVrTXI5VHRnRjdzTVI2c2JXNzQwdjVXRHMrUEsydUxFNlNzM0d5?=
 =?utf-8?B?OHhBTERvYkJyYmNidnR6bGtlcUJoVWhkQjJmMjJTazV4aGhXNGZUYUJWSUhI?=
 =?utf-8?B?cW4rTUZSOFNhOWNSdEV6VWxDRTQ1TVVOVkVpaHhRZXVnMEFxbm9nN28ybXlr?=
 =?utf-8?B?RXRhZ09XYXUzWnFVVk1xY0c2R3ZVVXZBck9vbmpQbWdIbHp5blQyTFVtdW9z?=
 =?utf-8?B?bENvWEpUR0RrcXhXL2UyR3F1UjVTNEJialVGYlNLWUJ6K3lnaEk1WjNpZG5o?=
 =?utf-8?B?RURmTUxEU0JyN3hNMm95NDBIQ0hDd0xQdGpGcHBUTXc0cGl4eUUwOVhqSmtG?=
 =?utf-8?B?K1ZDODkxWHNDckhwa2NpSW9xa0JVK3Uxb09vVythRHZXRmIvRjlCeEdYdENw?=
 =?utf-8?B?UzA2bFlSOFI3MVpwTXJqOWtrSkh3aVlBSVV5aG1QYVhDbEhJbTN0a2NMTDQr?=
 =?utf-8?B?VVZSZzFJUndmL25ML3RsTHBtNWkvcThXWGFhVkowM2VRSEMwb05ZVzliVlVw?=
 =?utf-8?Q?QMraidf+A0Ooc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXdNdVdSdlpZSEJncFRETFZoazlZWGR2LzRvcnpsOWJuZlg2RGdyWnRKM3lu?=
 =?utf-8?B?T0dha2hHeDNoZnF6VGxSY09xU1I1OE5ydmdrN1lkK1VMQ3BpaGRhMFZUazhU?=
 =?utf-8?B?clkxY2V2L3UzNlh6YmIrdUM0a2FkYzQ5VlVldkUwMlBKS1oyWE5CdEI4NHB2?=
 =?utf-8?B?WXBPZXhnNjRJWjNUVUJnWVY5RnJKNWJKMHptcy85VXNGRk9BcXByeW9WeDgx?=
 =?utf-8?B?N3NKRG12M0lkZWIvMnJsSUVGS0tzRkN5SE5jY254US9xc0F6dDYrd0t2UkIz?=
 =?utf-8?B?c2FJSmVFUjByRWpPQjlQcmIwUWRXLzQvdzZqdElrQmQ2dUcyd0tydHcvWmt4?=
 =?utf-8?B?a1lLdkdtMXQvRVlIYk5QamJIR1paZnlKbk04NnVsZy9OVmpaQzRtZk1pNWtS?=
 =?utf-8?B?YVphWGZxQnVpOVJWRXd6NjlKZFRuZ2Mrbzh1ZW5oNVpnRWZ4ejQ3NGRCN1FY?=
 =?utf-8?B?YU11UER0VkI5WmRaV1JJbGhnaXFTcnVxdmlSUnhjdDJQY2RGWHk1dEdjaVVH?=
 =?utf-8?B?S2w3Zk1nSEV6Z3IzcmtENUljdURyczRneGhGai9mTUUxSkQweWxwaEdYL1BB?=
 =?utf-8?B?RzhoU05MMEhPTkRlMUo3Q0d5OHIvcFBONFY0RDJMK1NBR05mSEt6UG1vc2ZL?=
 =?utf-8?B?YmdtcUc1cG02STRKc3B3WXZGV201eGZoemhLNXJjeTFhK1BNSnVMU3d5UGdn?=
 =?utf-8?B?bm9XS3laM0pTNklqbytEaXZhMFl1ajVpdlRHQThaOVJxK2gzbWNHYklBKzRi?=
 =?utf-8?B?L1FZT3NSV1YzREZGcmZ5V2daamNmOXcwMXhSOWJSTHpUaDNWTXVDV0pPbnNL?=
 =?utf-8?B?ZExVQkhYVzMrRi8wTVpPZEo5TEtYbmdLVHBVUlJxVW15T01pZGo5VktVVlRv?=
 =?utf-8?B?bTN4VWNkWGM3WDQwOFhHZUYwazlaVGJyc1E1UjF2bnpSSGFzcnVFZGJ4T0hw?=
 =?utf-8?B?dDBqOW5PZURGV1MvKzhLWXdJRTFLRFduZ0VDN0xZMlI2ZE94Qk1kZG9jQ0Yv?=
 =?utf-8?B?V1h2Q2k2WFh0OEh5WHNNNVZJTzY2dWt2WDVpOXpLYmJaaUxXSzgxSHpYaTF0?=
 =?utf-8?B?NXIycVY2U093S1JLKzViajhPUnZLK0swQS9SM21kRjlobmhoRVZoeUJUcWFI?=
 =?utf-8?B?cGJCNUt0S1NQd0dhMFVjZWlWMEdDMWMxdWhXMVhHSjVoOXlCbnh2ZFczeU1q?=
 =?utf-8?B?Z29nK3ltY083YXpXSWhrUzBSRWFXMFY2b0NZak9NM2gwT1lRMVJCdG90cWZN?=
 =?utf-8?B?OGprRkJHbU1UNmRNQ1RCaXZUcEZaMzd4NDlneDRpc1FXQUJETmxCaTAxUjRq?=
 =?utf-8?B?WFdhQ29rcGhIVWozaUlGS1pNWFRuRHoyakNxQ2UwaDFRYUMxYkNhU0RRM1Nu?=
 =?utf-8?B?M1JIcENNRGlDV2MvT0U5UUorTTVMSVlENFBFVDU0RDlvV3dDcEhjRTdFcVFL?=
 =?utf-8?B?NnF6M0NlQ0Rrc0dWS2N3eEtyZVN6Y05yUWUxR2F2WSs1NW1IQmNwTmxhcGMr?=
 =?utf-8?B?N2hQcis2b1N4L1hZcnRKS3Z4TE9qTnN2N0NaNTNnUCtOdVVHNSswVGg4Uy9u?=
 =?utf-8?B?VStJNy8vZExhM3dia0RRbEcxaUcxK3pZN1VvUjBlU25NM2ZVQ3VOb2VwWTVO?=
 =?utf-8?B?Y3RXa2VBMU1mNlNLSU1RaEdwNDNTeUhyMERRc2NZUUZwOHdWbW0zZXJRL2Vo?=
 =?utf-8?B?Zzc0RXZOMnhPSnV4TVdDU2g1YkpUa1p6MzVjcTgvZ09FeG51R0Z5U0txWEVQ?=
 =?utf-8?B?dkFoT0MyMlVuL2pqQkdXb3BVcUExakp0UG9mN2hsUW9yRlA4aWVobldwSUJE?=
 =?utf-8?B?WlpLTFo2R2RhQmRZellxbXF3bnJxcVFCdWUybW5vR3owMUN5MFFQT0xVRStq?=
 =?utf-8?B?SEFqbm1oUE05VVI4UGRBdGhkemxCY0pkZ3NhSnRQL0xJdUZDTktJZGQ1ZE1D?=
 =?utf-8?B?NE5yQ1FCWlJ2cVlOdStQU2RHL0MwcFBTNzhFSWZ0eE4xdVJlUlJqSElEVmxh?=
 =?utf-8?B?Z0VhTURwcTdrSHowc0tOVXNGTXhYZEhaQzZld3dhZUdINmtDZkxtOC9JNDBL?=
 =?utf-8?B?T1JJd01RMGdkYjdDR1pLeGIwZFBFZU1oeTFaVkc5dWVmdjBzbkdid09LTlJ4?=
 =?utf-8?B?UU5KSXliMUY0d0pPeURuaURHNkFqTDRTZmVMQW9Fd0wwVDVqVVdDdTJZVnFP?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NdUvfjrlwEvH4ghHSUTVf2kRNuJf2HKFM7JnXLtvntEL3AkcrYxXQk3iKCdF3fTKTLYThpdj4xJJEYgU3Xn4qvdLlTkxucj+yWFtoai6ni/+t2lxQ58mwFnj7Hmfrw8us5r7loZOonXR92D+kETHdS+na1uH/XnSZtoNMuiMPH5LXfc8vvFH+ZUCaZqoiRq1X3U8hCpkTLKCalyUUaIKVJdJx61BBB761ghalpSlZZ7mMJMAxNDamCrFfaNEJOATTBzmcAtPBbzdY/VQyUDoFLpcXTypKwKAVLf42s4Da5KDNzxBYQtHJ1oQlcfrI1Z5w/xtj+Du6ZNaGHSUUtEJY6yZNZlgAXQoXQ+TzZj8nYZwZpePVutIdF0QP7La4r59K6bllbWrWrBFLeA3rlC97vZ98G2gWRJp/aFu8qUcFXrJv3hnHemxr0cR2eQbnPz5HZKE4TNf2HR0eEb3iscgXFr09y+nx0paAM7dIfeJz50eFLxNPDpbStUJzniQtiABXY0zmNFqsX5BCmqC3dZFLsBmovY46krZq4HTPOe9gYX6pf3PKJdLJIBkZv/KEndqHaQFD2L9aPY6s2qzMkvuSugLqHHx4P1lBkRCwqoiEW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9b10bc-4f0b-4487-769c-08dd3644bde0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:45:02.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amYRsN5p79CtC0V2CaAFnD2AqNiWwbsrL7mSHwm0TYbS0edfBraJ+Y/VDvWppKpOZWmkpYGphPcLMBGEpvRLdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160119
X-Proofpoint-ORIG-GUID: WLFDi5pVVJQwXz-Mwjseff669ZiIVOUt
X-Proofpoint-GUID: WLFDi5pVVJQwXz-Mwjseff669ZiIVOUt

On 1/16/25 10:36 AM, Theodore Ts'o wrote:
> On Thu, Jan 16, 2025 at 08:59:19AM -0500, Chuck Lever wrote:
>>
>> See my previous reply in this thread: WRITE_SAME has a long-standing
>> existing use case in the database world. The NFSv4.2 WRITE_SAME
>> operation was designed around this use case.
>>
>> You remember database workloads, right? ;-)
> 
> My understanding is that the database use case maps onto BLKZEROOUT
> --- specifically, databases want to be able to extend a tablespace
> file, and what they want to be able to do is to allocate a contiguous
> range using fallocate(2), but then want to make sure that the blocks
> in the block are marked as initialized so that future writes to the
> file do not require metadata updates when fsync(2) is called.
> Enterprise databases like Oracle and db2 have been doing this for
> decades; and just in the past two months recently I've had
> representatives from certain open source databases ask for something
> like the FALLOC_FL_WRITE_ZEROES.
> 
> So yes, I'm very much aware of database workloads --- but all they
> need is to write zeros to mark a file range that was freshly allocated
> using fallocate to be initialized.  They do not need the more
> expansive features which as defined by the SCSI or NFSv4.2.  All of
> the use cases done by enterprise Oracle, db2, and various open source
> databases which have approached me are typically allocating a chunk
> of aligned space (say, 32MiB) and then they want to initalize this
> range of blocks.
> 
> This then doesn't require poison sentinals, since it's strictly
> speaking an optimization.  The extent tree doesn't get marked as
> initalized until the zero-write has been commited to the block device
> via a CACHE FLUSH.  If we crash before this happens, reads from the
> file will get zeros, and writes to the blocks that didn't get
> initialized will still work, but the fsync(2) might trigger a
> filesystem-level journal commit.  This isn't a disaster....
> 
> Now, there might be some database that needs something more
> complicated, but I'm not aware of them.  If you know of any, is that
> something that you are able to share?

Any database that uses a block size that is larger than the block
size of the underlying storage media is at risk of a torn write.
The purpose of WRITE_SAME is to demark the database blocks with
sentinels on each end of the database block containing a time
stamp or hash.

If, when read back, the sentinels match, the whole database
block is good to go. If they do not, then the block is torn
and recovery is necessary.


-- 
Chuck Lever

