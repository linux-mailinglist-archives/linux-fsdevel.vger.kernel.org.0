Return-Path: <linux-fsdevel+bounces-33106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A845B9B450F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 09:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEE61C20C9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634120409F;
	Tue, 29 Oct 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oh9CKI2P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PDN2ckhg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D03204033;
	Tue, 29 Oct 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192204; cv=fail; b=CUwUeC1RZOoa6nDhjdwDhMh8ZjBfiFRVX0hP0dhRwGujto/N2wlRzWRgAqksbvrqG5VWWYjc2V2G6/M2cBute3sDX6hGaXGX5P8+SzoLxHPuMMYZL7fiUDGmp8qLPuLA8WgLTRrwnFuP5v7wxPg5UVqJqcuS8GofAjOr+xTkhu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192204; c=relaxed/simple;
	bh=jUMC1tUubuTyxXkVHuUa9yCLd4g8iHngAIp8J4E8Yak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnVXH1fEORs/IGSXsbEvHcAw1k8cK+WRir4GrNcQMwyL7RAv17CT03AaDs2F9zwXoV6aeP6dn48CRha/3e3RZ1uV+y64SYaNyGo1aFIxHU/55AKjafOwq9lkKBXPgxdXbKHWzq9ZO0LbiVproUR/sJe3P1vyxOHlzCyH5TTqIm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oh9CKI2P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PDN2ckhg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7tc6l009055;
	Tue, 29 Oct 2024 08:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ucVuvrTOQY+vxSOa8by3hEf7EJkAB663AFrAvbslVZg=; b=
	Oh9CKI2PHNzpoEjYGuEQrgj2fSetQd95olBBUgtqKR08dVzbt37Ic9MjH7cLH3iD
	VQ+CgMtsHtXgt/AMAd5mq1ymS6SKTN1gBbShWhb+D82s6Vue+jiM0O5KamuBkfxg
	kpTBoNwZNtbMi52TAVmsOr2C6erqtjGEcxOAg0bS/qP37pSRQ/A20KjWwlyW5vuE
	CDnJGProYzqP8B7dBsusN0Rij2U23T2cHg03jW6u93faxtW3ztENpHswLluAaLzR
	J7jSD3fJuqm6l1yjbNdZUMirxAXQV9Nckzb8hRRBcZvkDA3vGi7s50tFGkmxgumM
	z28xknRAE1u6iTLVVNhtbA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp4ua3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:56:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49T8cqWU008350;
	Tue, 29 Oct 2024 08:56:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne9bvaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOjugK5E9yHea24f2WvE87vKcGroZX7dD+DSSYcYm5Edjss1YXMh7c5HlN9HDCbN/Bc+G/yDT0IE4pQSHcXqa9GcsG4gJdZLzk1t4HgKzRg/lqvnbxZlkhnMPIuf+RvosSV4Srn6L15XuJPZN31Z0Bj2jUHyIKakGtWnvbuzlImrKs2wSO4iBTHYHUGzjIM2HTlkHfnpxrm7WD9L6Hqp969bmU7DQ/rE5aFJ+eanAsoh6hHvGa1mQCkmhhDD8SKwb3lgcfGd1CsiaqvmSZL1YH2gxgaa601azE/t16ZLnXIAMESWYTMOMtoer8RdAGYoWcxozFx9k3MbYHJrTwkj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucVuvrTOQY+vxSOa8by3hEf7EJkAB663AFrAvbslVZg=;
 b=Akzyl58Gv1cJTarRCm0p6GtGwX7AjP3YpNgAhf3ImAHpoH3pYDHulgwVMc7+9BCIEPd2KpcqcEFw6h1KKVhpO2CFfAO1fmZGqtcN/Sl82qXPj7DK5EmS/50KDf/5av2b1ZXzOsUqkoGHzfAHGBMMJ7psrlFXNyA1hnCuCljiuCOiguerJomRPdjJnReDYYNTxmuBGbWcwCRjUvU57JzFfbucPqW71P5/864+JB3d9L8w4923kmD9DkLFiT4bpwkyUEb59t9oH8uFUUVbEbznRn7tK/8uuaV1eAaxzIQ1G3NQPcIh399wdTo0UYiGmOTc5gKlpV15RcPcSmbXZ2Jzgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucVuvrTOQY+vxSOa8by3hEf7EJkAB663AFrAvbslVZg=;
 b=PDN2ckhgfzAA3n0BkGlI1Xe5pDW7+91Kf+dgOeiaxzIZ/0OX2XA9QdH8VynX8e8YlGSshZJfzd/mN1SG0BV/wWwOmxyCxfEQx06jKMVgvIB8MCcHeQmGjizsy+p2FBX6cv8jE2z+bBa8NHDK0r4h8ySxb0qf8519A9yaakjb62s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Tue, 29 Oct 2024 08:56:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 08:56:23 +0000
Message-ID: <51980575-713a-4693-a779-0e34dc5f7f2f@oracle.com>
Date: Tue, 29 Oct 2024 08:56:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ext4: Support setting FMODE_CAN_ATOMIC_WRITE
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729944406.git.ritesh.list@gmail.com>
 <ff8a6b81109e4a81ef304eb5b523ed777d62e2a2.1729944406.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ff8a6b81109e4a81ef304eb5b523ed777d62e2a2.1729944406.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0567.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c2319c-90fe-4b86-6875-08dcf7f7907c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aS9SOE53SXNoVFM1WUZ0VW5qT2FEVStaV3RwdWpvclpXQkVpVlh3UXJuc3VE?=
 =?utf-8?B?TVErajg1Z2JFTnR2ekhZKzY0aU1BRGJkWDFuaTFvbGFVaDc3Tk91UGNzNzFk?=
 =?utf-8?B?cGZTWUd0ay9HNmsrdS9VZFFkb3QySENENGgya2RtU2NLS0wwdEtvVXVsNXRm?=
 =?utf-8?B?N0VTWjJkKzJmdmhuWnBXK251UnM5dVRHd1d3QytmWUZicElNZWlwT0lsMmJt?=
 =?utf-8?B?bk1sN1N2YTB3MFE2ZzMvQ1k1cWt3MmFPOERSendJeW1admk1MmZaQlFQc2dY?=
 =?utf-8?B?akhMam81YWIvTm1lNUFyYU1aSmxPUm1OWWtZZ1VhNk5LWEpkTWJYN3BCZ1BJ?=
 =?utf-8?B?bWo2TGlIdjZWK1VDc29MNzg3dW40OHZpdENTNzJBQ29TdGFVSElkL0NheTRs?=
 =?utf-8?B?M2ROMk1iTnZISzFFWCttTlpNTVdPMmRPTVlBYmZJNmNEdTBPV2UzTmFVWi9B?=
 =?utf-8?B?bGVzb2REbzBIZis1Q29KakEvY2RDQjRhckF5Qkg2ekVYVldxdUNRV2t6RUFK?=
 =?utf-8?B?eFArcEowTFIrMGlLMmgwUDJweGk3TCtjWU9mdkRBN1U5Rmt1UEp5b0lHaVd2?=
 =?utf-8?B?dlNlT2I4MWVENFV6aG9TbWVOamdUb0xiM2JJeVhsZmNySS9TV3Rld3JpY1hK?=
 =?utf-8?B?RWt2d2lZeXk1U2hqd0ZpcnRoQ1p0WjF4bC9WcUU3UlF5MVYvWGZ1Z1ZMWW9H?=
 =?utf-8?B?ZWsxS21DK3RpWEw3WVNJUUtOaUVaUFZ1eDBlT3YvRlpzUHhBTnBSZXBJRlVo?=
 =?utf-8?B?Q1F0RWxTbE1IQ3dvYzZCa1hEd3Y3VHVLZTFVcldFeDBlVGo4blpBTitPaFRS?=
 =?utf-8?B?YW80dHZNVmI4cjladTY4dDZ0cG5HWnpCRU8zRzZNTkRnY3IrVnNVMnJ2VEtP?=
 =?utf-8?B?RmNHcklUaFlrY1M1ejA4OUUxc1Y2cUxJaW9DaHJtTTd0c3B6R0ZPbGtPa01T?=
 =?utf-8?B?UFhkUjNCS0RYYVkzMldnWTA4eXR3eVc5cEVyK0RaTCsrREFTUE9hajI1U2Zt?=
 =?utf-8?B?REJSRG5PYmU0NVJNZS82V2lKQi8reEdDNDJLcFh3THU0Y0d1MmwwTVZ2Wkho?=
 =?utf-8?B?YlNJTDZsMUMxd1dET04xaGc3MGlXNnRhSm9BcHhaNnh5bEZlVkZNUjdYV01K?=
 =?utf-8?B?cXJ1U3U5YmVFd09ad3VPbkp5TmVPc25pRVlnQThNK0I1UjVVUy9Gb3U1aDlp?=
 =?utf-8?B?aHpnRDMwVXVqRGVTNVg5TVFqRUJIYzQzNUlMaFJKdnVKWUpOYjVoVU1mRUt1?=
 =?utf-8?B?cG9FWi9haVA4eVNOaUVneTZZV1ZKLzBrYlNJTWdUS0g2UHFTTDlHQnpRRG5B?=
 =?utf-8?B?dGlCSW1jZ2dPcVNFVGlxalBMQUlKMCtSSkR4eHFLcXVGQmNYcGNVMmJlYmpK?=
 =?utf-8?B?SHJCMVRCTkxjQkxvMVpFdWE3VFVBNCttQkR3NVppbWhwWXJ6N3BISzNGVDJH?=
 =?utf-8?B?QS94Y3ZvOHhJd0cvbHlvYmxKV1pRczhCS2VsZjlITk90b1NjWFcvZkNkYnRq?=
 =?utf-8?B?MzRMYWFHc0x4VHVGRTNKZzRxbmgwOGZ2MGFlZCtYT3BFUjJwNGxSUElBSTZJ?=
 =?utf-8?B?SXlOLzVrRFJKNXM2cWFyNExYc2NKaGE4Tm1MWTR5WTZ0dnU4U0Y0T2hkWnVL?=
 =?utf-8?B?SHRUQWR3M0hZU0lTSW4zeHkyTXRnNytTK2o1SFlIZ0dMUjlPRzNyMnFhb0V4?=
 =?utf-8?B?c2JscFpkeXFsdGJvT2xoOUY2aElVOUl1UkZrQlVnak1rek91QVNWczJiWFVT?=
 =?utf-8?Q?h7SRTpX+H9qFUurcUZ1CvSycmVTQ1FghQlAKhl9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlpVUGhtWVVLNlpTVFhCL244dXhpZGhvMldPY2I0a1NyVllVQVZqSVdhRlZU?=
 =?utf-8?B?U3lEeU9JVFFtS3BScG5oWU9HSjE5Tk5tWmNIQUlZQnVmUmF5c0x2WmZ4Qlo1?=
 =?utf-8?B?SGlLclNJdHNxTDljd2dnbWRKekR4cWJMQVhuZm56Rk5ySk1vTGw5ellUTkg0?=
 =?utf-8?B?VjNWRnF4ZkdjNGZMWVM2NXhGK1ZEd3MzblBubGpoTHc5eXdHRUVMMzVTWUpu?=
 =?utf-8?B?NndlbEkxdW10bXA3dXNjTHZROFU0ejExRDhpb3Z5TGFvRmw3YmE2Slg3ak44?=
 =?utf-8?B?RFBzZWRnWG82Y2tzWGRTdnk1SzNqNFNuNVZGekgxcFBldDlCRXNSTTlWaG9p?=
 =?utf-8?B?TS9PWWlnT2lyY1lzbGlIVVYrSGplOVBkU28xeFlXQjNKT0Njd3lhbXRseE1S?=
 =?utf-8?B?NHRlU2VRcXg1c2VSWnF3dnRhalZNTnN2b1g1Q1RKdUVLdDhqb1o0aUN2dTJv?=
 =?utf-8?B?ZEtlL3pJNThTTlN0aVFzQUdhUUdsMWFjZlU0MGhwcVREaktUVWxiNzNKWkhm?=
 =?utf-8?B?N24xSUtscUN2aCs4WDJPZUI5ejdiZFVCUVBJblZrS0hLNXR2b1AvUC9VZ29B?=
 =?utf-8?B?eStSQlltbVVTc3hGaUxQUjk0UzkxQXpmUlNpVXFSQ0JZd2FSK0tNRFJEc25q?=
 =?utf-8?B?eU1WS2tvbkQvUGxRandycyt1SzdZM29JRmtrZ0x0ckJzdWwrSHdabVF2bmpo?=
 =?utf-8?B?M3Y3bUVMUUQzQ0ZIRE5NR0MxWEpGNkQvejgvMmNza2xxdDliWDdwYndaSitq?=
 =?utf-8?B?MmdWVWxqbkxJZGlrT2RUYndkdXRRY2p5V3MxQmFHeUh5N2FtcGhsQW1QS2Vp?=
 =?utf-8?B?QnlzNFdCcWw4VWtXcFNiWEEyY1lZMDY4U1NDYXZqcnhpVG42aEJhYXdmRnAr?=
 =?utf-8?B?UGNkL01FV0xtaHRDempvcGdXOGtWWHU4ZFR6RWJXWkZxSENrWm1kMmt4QVpK?=
 =?utf-8?B?MFZ5Q2prVE5vV0I2Nzl6WDRRRlRqcU1NQjY2Q01kNkg0YmtFMHQvOS84eVRO?=
 =?utf-8?B?dVFEMFdIVlYyd2Fod0M1cVVqUUhNeUpxeXZoa3dGMW01YUZpTzVIajJXdDRh?=
 =?utf-8?B?V25OSW5LMXNRNWgrZk0ya2s5dU50V29JNzF6dlhhZ2tCZ0xEVXlOait1dTM0?=
 =?utf-8?B?Q2Z6VzA5NnMyVUFPV2ZTVHdvTUYwSnc2QVpDQ0tvUjlDOEQxWFhVWFFrbm1P?=
 =?utf-8?B?RjBySHdjb2JZYlJJNFVtRzBLUVpFbzB6L1VkWGRXU2NmQ25ra0hhUzVoTFVB?=
 =?utf-8?B?S052RXVvODNIcXRnRS9hQ0JUd2lvaGlhR3RSRTJrb2I4WkRLL1FDUkhRUFlt?=
 =?utf-8?B?RVRZWWo5c2EyNzVYZ1dHS0Zsbkc3VFhSTlNjcDFOMXdKcWJXd3Y0Q01YWWlm?=
 =?utf-8?B?U2dYYU1jdEhGQTNNcFM0S1FlUnYyeEZpNzB6ZWdPS0h5TzNqNTV6T2hUMHg5?=
 =?utf-8?B?WTM1YlhjYUNhNTVjOHNVUi9yWlE5OUhwRnJ2anNwSWlnSEd2YVUrM0oxVHhT?=
 =?utf-8?B?ZlVPazFYZkdGd2Fqa3lRVlFiQ1IzM1JDSHR1UGJBUStMM3hmUzZhN2gvckRP?=
 =?utf-8?B?QTN1UmlxYkpCQlRJblFUR0pNU0pJMUVQdmlZSXFQYXB0SC92T3J4dSs5OXQw?=
 =?utf-8?B?b0lhQ2pLY3BFYmR4dHVTSUwvYll6RGJEdnJicG1UcjlvRm1WaGk1TmV0ZWFT?=
 =?utf-8?B?QWVXNE5BZFBKZlh2MzczVW81NmZSc3Fud2xhbkJyU013dFBKSnpsOGZNK08z?=
 =?utf-8?B?Z0RmZ25RekJvVlBFZ1RxMEp1K1VyZmdTZkRmNngyaFQ4a05QV0cvcVVYbW4y?=
 =?utf-8?B?SDY3NVdRWmhBMGN2L0M1RHRYemtmazBtdEJ5V0pDekpXTVY4QnQxUHlLOUlK?=
 =?utf-8?B?cUFnc2o2UkhEYktqK2V4MmpsUmxrTDZleXNnZDREV0ErakN4TXhyTVVFOFZ4?=
 =?utf-8?B?b0tNVFc3NWlzWHlxWFdEQXBnamgwREszN3BFVlUyM293Z202NXlvT2toZkpa?=
 =?utf-8?B?YzU2WmpNS2N4dUxXWDZ0b0JVb1A5dzVCYjFXQ0RrSmtuN1JrU012UjdJbU9B?=
 =?utf-8?B?RC9ia05BbVZmRkRPbldDUWpiRVUxUGwwKzh4YnM2S3pDMHVBd2N1MXdEMFEw?=
 =?utf-8?B?NzZ2UHVoOTNEMVNpTVdxNFRVZTdNdzFETjhJVitFbjFrZlRrRUNRNE9yZHY2?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I+yvaxQMJtR1HcsC5NSb1WaXhuRFppXlxPa3G2OhXAwGaTcH50WxPm7BtfrZBfM1PHmNHjUXh4sptVd5+mGK3mrsaV1OC99BESMJMS4XT7J9ZexL8Z9+osw5+mm3by9Xam0TuxDx7qFsgjARMXitBAQbVThLliuClCErO8/pAt9U6wAxrQrJi6vIsXaFDpW8GBGz8P5AKLRQ5yK0jaXCFLHHMfkWMKtvyKUcSJZOBT3Cv+MybPGJtVWyhYsSZbTJOgivWfUl13mVuVjYEUYXHfgiWjHzSAHpb5sAYNLQIG/8pFMDsDcG4+s8g33Fmzv4xyA/EKHj+suuSt9GNNdAHewHbKyZCsKU8QP670OjZVzDUHK0LksL8/bkOUsrKoteXzRujA63N0spCW8Nro1WblmAP5tQAECjm6dhk0ohlirQcCBJYVIuEc0+kHTdvTa88DluT0i0AX8GooU+2UQJnfb2SMj0uc+nL8YDTGNbDGXKugqwxrCIObAENIgdLMbMwhq0kV2fDG1E1moM8tPdt2Uprlu5Ay7Y+rqkMs3iMq9LaxBl/k1BuKv7UYHQ+D0mn70qNKT7XHAXAQ4nhlhTb97osfJyB4JoB+A4Fczsyh8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c2319c-90fe-4b86-6875-08dcf7f7907c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:56:23.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23/JyvWgaAo4qmjM3s4aR1K9qEbqjHmbDtMLulbihN+2JOEBwpJsB+sSCcD5Y3JOLj5Mic3riyZZ+kkUMGzl0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290069
X-Proofpoint-ORIG-GUID: rD7egDS4-nCLEqKEPkMtmMxDw7yICsVy
X-Proofpoint-GUID: rD7egDS4-nCLEqKEPkMtmMxDw7yICsVy

On 27/10/2024 18:17, Ritesh Harjani (IBM) wrote:
> FS needs to add the fmode capability in order to support atomic writes
> during file open (refer kiocb_set_rw_flags()). Set this capability on
> a regular file if ext4 can do atomic write.
> 
> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

