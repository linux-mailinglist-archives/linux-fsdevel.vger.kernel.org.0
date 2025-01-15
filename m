Return-Path: <linux-fsdevel+bounces-39305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D7DA12794
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195D1160401
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA81662E9;
	Wed, 15 Jan 2025 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z7GuGFE0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e+6xYKZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E514B94B;
	Wed, 15 Jan 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736955126; cv=fail; b=AFks/U9R6dJrfiQFdaqBAzx5kPJ/LC5QPcoe7+eRd/AC20Vf2A8V4WtMHleY3yHE1o/Zrj1oP8Zn+N/4GEQ3RhNA2wuanHMyy1mvdiwb9np3heH/dvEsCiU/D+KpXYjhL6PXDSVlnLlSaUG5szKNdMcKijQWC3oZADM0Zb6CIeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736955126; c=relaxed/simple;
	bh=zBBlQPmZ7bFkICi8B8zQMnUqztsmLHMnjl/r7p+7YLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ruca+emr/FvCf3X3H95YqVCB+Vdco6OubOU4kTEUyR7eRpEYya20PfSa96dYEAeRxK5JKTDNqfloK/JzlM/3/YwCKFJXei5e6mPp8L0qKi9xyTwbJ0ewE8HayDJFJJcJZG4pqV6v+DU7tLYWp1qB7Vqmsy4cuUl37mAn/3cGcm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z7GuGFE0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e+6xYKZl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FCj3ll013375;
	Wed, 15 Jan 2025 15:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2mi2XkgnWXI0clNbtVemUNMVpTRi4SJKK3nwfGTviCo=; b=
	Z7GuGFE0GJ3/meXqL6FvIhuqkErCTUoieQFQ+y7MuK1GOG8JfuUqjSfXpKa24eKt
	7UoljOj68E8ozApnEBAGpz0zUqtn+cuTl/ZvKx/svM4+QLKLYBJzJTowY/MZBbqc
	1QDQ2Z16/LivzGEsX3me0AKxW+inqj5EnM/tq2hBUc7OkBuXMo5Z3Bbm8P7P7j5X
	J6auv0hS6NevIhVU8NqxSI6kh5YKpQYyXRBAFxPiy2HzeSmbrx/GM9oZbiX3Zzmk
	2ny3w6u3qdbkDFsURFOaOlnUD4C3PX5pRbDcIXrrBc30aD0+BEeFQX7sEShX+fEp
	7R2RsbAfCC9xyi8h9v+Z2w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcrfp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 15:31:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50FESjUe036336;
	Wed, 15 Jan 2025 15:31:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3a51bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 15:31:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aj+y/bpOPWaMjFTZs9Sd59s3NPJ94O8udalHllMv4ct83/KSrEsrQulVHlKOopLY5krMMcoqmBp2CYpOjdvliKfW+XXsLFHMLEn4J9QhXwYU51rIVO7VzatYJ/4TCSHk/7xVtcbHHdEMEitaLnyhodEZS9mdalcz/+BgHCG+NQ7D4fdFX+Lqj6K6A4W+a6AMizpJ7gBhTmGaf2QCL4rkfv2eOkIgwn4wanOPbUZ/Husx5CcMOvuNDxerNJzcpPhjggGZsCXhYRUI0RsPD6fuRcYHUWZr1733H4GhPvo9cdMmdGxLF93qLRQDjKOFaQB4nsJU5qvMxV4mLiQMCHS9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mi2XkgnWXI0clNbtVemUNMVpTRi4SJKK3nwfGTviCo=;
 b=o4sJkro9pKxwCTx2jc6FAQAgQiGX7J54nAbRrXcqzn7VUa/uPIFs2SmmsW9sD8aEInQB7J/MLUibYQr4+5rLFl6K8Z/Ypezm5Kno9xBTClhDNH4WHb8x0nTxbXs+DgMjP3ed7pGe0xE892EOdtaOhAyaeEWMrNfYo5TPTHtjtBh+ltDYrVdJkl/rYqcjuZyAPq9SpEi93wuyRc6bbIqabywvG7fDE5zU54xMgG/8jmIc8mAB9eJw9vBYDPyxleEm0LfFnYPoBU+k3Qni7BqEG7I6uxnuCdVbdwe7cMwMRaxLQwDNE5WYaSGe6ZjkqocgMEmM7DXLSTbihFdX5IjbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mi2XkgnWXI0clNbtVemUNMVpTRi4SJKK3nwfGTviCo=;
 b=e+6xYKZlAgzbdaJPHNtU1D4qkR0K7TMmUItX1sBTsYWFgJVDE+0dkPjXVCAIBOVnxcrs2irRGzhUkzpAmPtaphnCbV3QJoQ4wppJb73ROnhtM99r3mg5jTn7hBqtWJq9/i/edR+NpRYurMA3BUX4dLxf64UPeLuQWWgArzkt5+Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8121.namprd10.prod.outlook.com (2603:10b6:610:247::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 15:31:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 15:31:52 +0000
Message-ID: <4c59eb2d-132e-40d9-a2cc-1da65b661fd7@oracle.com>
Date: Wed, 15 Jan 2025 10:31:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Implementing the NFS v4.2 WRITE_SAME
 operation: VFS or NFS ioctl() ?
To: Matthew Wilcox <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
 <Z4fO2_WZEO39jupG@casper.infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z4fO2_WZEO39jupG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:610:4f::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 28716e6d-650d-44ea-0272-08dd3579bc69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TG1JTjNvaGprQnl0a0tXR3NjQ29sZEhLOERsUmVCMlowN1EvbHZaMXh2bEJO?=
 =?utf-8?B?ZUcrSVRkMmg1emZuTCt4eTVsWTBMeEhvaFJMbnpSQ0NjUjIxY3dsa013NDB6?=
 =?utf-8?B?ZGgrN2p5RXNkRlBtK081V1p0dGdjTzdYeDVuWEh1TTVZbGd1ZkQwOXhlWlhH?=
 =?utf-8?B?SFJTZHIvL21tSFFsVDd4VlE5RFQ0NndYc1ppeEl0cldvZHZvcE50ajJ1SVRS?=
 =?utf-8?B?VitrVG5NWTJ2TDBKamJld3FaelhrNG80bmtWQ05iVmcwenNjMTNRMXAzZkVn?=
 =?utf-8?B?V25DUzFIaSszSGx4OW5VOW95S2dOT3ArRFE1cnE0ZzRFL1RxL0xkenoxNzVq?=
 =?utf-8?B?VTVWblFhS2ozNkFaMDM4b3FrNW1EWnJmQUNvT3d3OFMvTEh3Smd0ek9GeFNi?=
 =?utf-8?B?azZWaFVLSHlVV0F5SlZlSzUraXR5WmhROE1PUHFiVjVLWDBSTmZjQ01vN0gz?=
 =?utf-8?B?SWpxMTRvWE0rUUtEeWZZNkxYTkk0TFRTYncwbHFKNWdIcFZ5NWtuNEpCK3kx?=
 =?utf-8?B?SWI5TjFaa3JCc3JDTkQ3blQvTkFzL2V0alJRUHRYZFlMbmsvSEdma0VCYXBD?=
 =?utf-8?B?TG5tejcwaUJ1YVV5VHVIMUpONkNKbzd0TjdrL1NUSkJGTXhsTnNRRnJZNEVC?=
 =?utf-8?B?M1pTRlFvS3hVSmlaTlo0citGQUV4OXFCNlpybW9SSWg4VkxERDZYREZnSjZv?=
 =?utf-8?B?VU9TU0pUaVFEQlFhcWYxbVRpaU1vOUpDcXFOeFpWdUdROCtpaHlXMFYyaTBm?=
 =?utf-8?B?UW9xM2N1Z3A0ckFRbWFQR3ZLeHF4RGxsMDA3R2hLRTkrQlVRVGN2bXlaaXMv?=
 =?utf-8?B?M05XMVEyL0RRd1U2eTAzV1picDBRRG1ldWNQNkJYaW9oaDZCVHdNVGI1TEdy?=
 =?utf-8?B?c29Uc3pqdWZPWWVLTnVIM2lPQWVMQzNBb2dTOWpLWUJMbWRBcVR3bUw5MXkz?=
 =?utf-8?B?VUNPUzF6dlk1YzVYbDBPdXBCZjhuZDZCaGp5UEZ5QzkzMTNuQkpMT0hDZXdG?=
 =?utf-8?B?R3FaaEk4dGVvbU16bEVlVldxYm1aQ0s5V011ZEZsVytQNTc0ZitBWE05SXkv?=
 =?utf-8?B?dE9sMncxelBtbmg1NFZxbmNicW5UNnoyZ0QwSHhIdXZqUTlqUDk4cndBN3Rz?=
 =?utf-8?B?bi9idkxRMEJXcG8wN2dOZlN5ZlF1UTFkR3lVUGtBZGVlRnpPWWhIZlF6NVR2?=
 =?utf-8?B?N1IwZjBsVFVudTBtSGVqNVFpQUhVK0FYM0xUaXduTnEyU0lDWmVienIwdmNu?=
 =?utf-8?B?Q1ZrV0d3UHIyNWlvQVJ1N2VwQzlDMnVCZVVaZ0JGVzlURWhBREFtRDlPWmc1?=
 =?utf-8?B?QWFvVWZmQVloSnNURDRGd1pXMnpGeWZheE5qUXpSend1UVdiRTFFYmR3OG5j?=
 =?utf-8?B?dXN3Zk4zOHVCc3U5eEgxbFAyb0ZqdW9OSFZNSytYVDNSVHJjTlJBa3Rvd1lY?=
 =?utf-8?B?NGRyb1dlZFJTbG1lbkpHSmhlakpBL3BQRjgzc0ZjOWIxeVlzWHQ0encxYjFT?=
 =?utf-8?B?Nk9LL05TTXBES2lLd0U2ZDZvZ2NQVUR4WjB6Y2FnUHBQVmZLUmloVzYyazVv?=
 =?utf-8?B?VWwzZU1QRUcvTXdwSE9TK1lsK2Nwbk9rUUw0QjRYSnhWRE5sTDBXcG9FSERi?=
 =?utf-8?B?aldNS2NONmd2ZFREN0pKQStpZy9jMUYwZzExMmQxdFQ0bHVBRjJ6ak1OWmRH?=
 =?utf-8?B?ODMzdDV3NkhnNnAzOWRRZWFGM3ZTbGtucG8rNnlTOUhWdW5DV3NSdVprOTQz?=
 =?utf-8?B?SVJWWTNydTJPTWVKTnNDb2dIOEtENUFvNzJzeWx6QStjWlkvaWFSL2sxUXM4?=
 =?utf-8?B?c0VZbWJLRFd3bHdVZ2o4bFdROW52Y2I5K0NFSDFQWnhxL3FpbWh6aFNEc2Iy?=
 =?utf-8?Q?jwVV8sj5E6ysx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0M2cFV5SnhoNEtNYjVBTXk0VGk4cW9vYUJHVHV0TTY3S3ZBWHg3TXkzODE3?=
 =?utf-8?B?UVAyOEJubmFCSWk4YjFiUUFybS9vbmlYZkd4ZmI3K0hDY1lGUklaZ2RhRHl5?=
 =?utf-8?B?UStZUlpwTXBBTWxLdlRhTnBMMmo4SWh5L1g3TTRSbnVTcXh0T1hlbjBkZlpv?=
 =?utf-8?B?NmcvSzh4Q1J3V1JFN2h4K1R6M3YzVThDdTRQZVZoZVhqS2VoUVFiWDJkOFE2?=
 =?utf-8?B?amJLUjQ5RTV2UDdhQ1NITVo0dENDL292ZUFxQ1VYenlmRWdTR0FCek03Q3lY?=
 =?utf-8?B?U0JaM1JTcXZOY0pra2hua1lKbDhBY29wQlIvbmZZVEZJZGFlbWVSNWpIeHdj?=
 =?utf-8?B?SnVPRmRJZmthN1YwU2pZb0dTSVRvRlQ3YmE5ZDd2RXVRSWV6LzVtYzdHWm1Q?=
 =?utf-8?B?SGJNTXRHL2ZhUGlGV0F2Si9ybEx4R292Z0VNK2lXK0tQR2VrSUJKYi9lbDhX?=
 =?utf-8?B?eFFqUEVLWHAreGY3eENZNVVYQkx0azNjek11YzVQTHBDRjY5TStYOVhBb1hL?=
 =?utf-8?B?MkNZVXRPaXFBK3FVTU40Y2FwSEc0OHZwSzQ4YnpacEpvQ2Raai9SRnpWRUFw?=
 =?utf-8?B?aGZyeDZjQXdCSTdVUFpiVzFJTlREUFp4M0NiR2MwQy9zSU9hNkJSV3NsNTJN?=
 =?utf-8?B?RzNEMTFscFJlbzNiRmZROFBiR09NeXF4Z0U0STR0ZUZpd2VaaHV1d254TUU5?=
 =?utf-8?B?YU0vNzBDc1dCZEVUanhLNnEwdGZ0MmhyNXBHVTJlVkRSVjZEeDVpRktNSlhz?=
 =?utf-8?B?aWdxSlJDSWRpYVhhdFZoQnhHM0k1UWdHYnB0bUN0VmZqc2dVejBoUWNoRWlh?=
 =?utf-8?B?RTYvVU0vd2pZNmVmdnF1YnJ2ZXdVWHpZYTZwVDR6VnZpTDllWCtReXF3Nklo?=
 =?utf-8?B?QUQrdm9XNzgxa3pBMWVpWTl1QTRjMGgwMHRQaUsxZFdPVUkxSU0weWtncWsz?=
 =?utf-8?B?MHd3RldhcFVQZlg1L3JpSVZ2TVgreVp4ei9SR1QzYzEwbWtnUGdFVmdXQ1FM?=
 =?utf-8?B?NHNOK1RUbTg5ZHoxdGpYRjAvQS9qTHFDQU5sVERlMzN6UXZLNWxRVURTaXlC?=
 =?utf-8?B?alUrTDZiSVpCbGJZSkYrQkhoVHJOTXZZRDVkays1TFlkVEVUSGY4bGpGUGF4?=
 =?utf-8?B?WXZuZVBnUnVVbFBuV1NYeE5EbWcrTk1vNXVsWjllWDU1UWRKd1hVVlhNQXhZ?=
 =?utf-8?B?SlMwZ20yMWk0a2t1a2tpdlJLaU5GVDY4NHdvTWIwLzFtT3U4Yjc1WWpHbE5a?=
 =?utf-8?B?UUdjQUhnYkJYVFBUWWVyUWUwenNmSUtwS2xxY1R2cmtYQkxKWGR6cUU0cXVT?=
 =?utf-8?B?M0xEYzFib05tRFN5ajEwbHhMT3pWa3QybGlPWmRDWDUzOTVrWnZEVURxWmNt?=
 =?utf-8?B?RDNYUGtlcGt0bTlpZVc3djNKSjArTm9vanorM3ZtTTRuRTBOZGkxU1V6UFov?=
 =?utf-8?B?OWFZb1R5bkFtSzF6a0hEQTFEZGg3dXliL3VFUXdnRldyOEtlUG80SzV6anY4?=
 =?utf-8?B?R0dpa2kzU2pqUnJpWTJ4VGNzNEVjczFUYjRBZG9GbnJVcjk2ckh4MnlDTWVt?=
 =?utf-8?B?b0pmNVJJYXlEK1JpSkFWMTNXMG10RXhMcHFYYjRUNEhiWDFLSFYxVHRWVnhE?=
 =?utf-8?B?ZGdvSitNTm5IVU1ZNlpRK3NhMkN5RTQ1RjZEVXJhc3hnNzZxTFhtbG1Id2Ns?=
 =?utf-8?B?VWJsSlBla0VQTlZ5SGNIZEtKWUdFcVVJMTZpai9kbXN4Vk1IVmdLYm1kbEpM?=
 =?utf-8?B?amhVQ213M3RtcWdJUnB2WHVqMDdnZFpHcWR3cEJmQngvTTJ1L2xyc2ZwWnlY?=
 =?utf-8?B?K2oxanB4RVZmcGV6TGp4NFdCNy9YT1lXeTRoYTNnN1dJWGlnMzNCOHNFS0pN?=
 =?utf-8?B?dnZpbHI2ZjU4T0pxTDFuSGs3UklWbVIzZXdzWG1RVVFCY2hZaTY3UWhUUHAv?=
 =?utf-8?B?aXdxaXVyRWUwTmtsbnFIaFBWcStSK3Y2TmxDM3g4OWg2cG5yWkJqbG83OWVw?=
 =?utf-8?B?ZzF3azV6M2RkN0IweWVDL0pzTzl2Z0dJR01JbSszYm5WM29xa0NMelRZS3la?=
 =?utf-8?B?c1l0Y2tIQ0dlT3p1NE01R0paTmFCSmF1WFFrcUNCNm8wZlZ6SjFXSFZFajBa?=
 =?utf-8?B?S2Q5LzJpZWM2aENrSXpQSjhwOGJHK0JEdEw1U0lVOWYvelV3OHRFRTJBUmU2?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GlXRDVedYLjjRDqiC3aalbuqRy+smVQY2pJya8nYSYQ9SYnPRFFT3fXS8+LKg5O/DoKHHhMdf2baZdO92GzpvpNi2OScMzqrqYGUmb3AdwzptMV4RLJHD+QrwNRiQJeiU50rvVHshAbK/AEj+gmnZhXBexoSnU/go3uUWX9gvdy74UBwF0eXnBf4HKj9NmMU0K9Zio0cUXeuALz4AEsuC10NV607c7xrM8Z0hG+cpJVL9lEi3P0luD/FvuOYuBNIU/QxRpFZFwzHL1co20FQ/lPKEx09s9n0r+GzBrd4L/kRR0diecDn8rfp70SQaWhrq7tQiAJ9BkWVaX76+0GkrIJEQZc+qwE9o5sKRZqg8p6qF23bFGjrEvj9VLhHx52v9PdJa+54FauI51b7+L14T+7d2lTXZnUCEbbg30luS0jNeu1AElWN5hk3k8EqkuquE8ZUwBrY73fXC/aGv2fsQLWrynkzVmmrctzzECHlxJwpuZX50ELJtZKGB7f/lof04TmOASJeEmTuKvmtwRLVqj8ax1l9Osph1tVHB7x2sYwS0hEarj68PRcFAOkuXH5AfasC/BUq+Zb14ZRRSzIb2OVxBgcWBQk5o7pCXd5qmT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28716e6d-650d-44ea-0272-08dd3579bc69
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 15:31:52.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pfUG50zmmQXeF9ttdlZlrVrmlKzGKSt7aEOxHevsXqofZSQk6fweJlawYTpAY3Ctt08/5Wyl4G32w4e0gbgzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_07,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150115
X-Proofpoint-GUID: oy1s69vFmq-wqQvBlp5x17Vwiujidq69
X-Proofpoint-ORIG-GUID: oy1s69vFmq-wqQvBlp5x17Vwiujidq69

On 1/15/25 10:06 AM, Matthew Wilcox wrote:
> On Tue, Jan 14, 2025 at 04:38:03PM -0500, Anna Schumaker wrote:
>> I've seen a few requests for implementing the NFS v4.2 WRITE_SAME [1] operation over the last few months [2][3] to accelerate writing patterns of data on the server, so it's been in the back of my mind for a future project. I'll need to write some code somewhere so NFS & NFSD can handle this request. I could keep any implementation internal to NFS / NFSD, but I'd like to find out if local filesystems would find this sort of feature useful and if I should put it in the VFS instead.
> 
> I think we need more information.  I read over the [2] and [3] threads
> and the spec.  It _seems like_ the intent in the spec is to expose the
> underlying SCSI WRITE SAME command over NFS, but at least one other
> response in this thread has been to design an all-singing, all-dancing
> superset that can write arbitrary sized blocks to arbitrary locations
> in every file on every filesystem, and I think we're going to design
> ourselves into an awful implementation if we do that.
> 
> Can we confirm with the people who actually want to use this that all
> they really want is to be able to do WRITE SAME as if they were on a
> local disc, and then we can implement that in a matter of weeks instead
> of taking a trip via Uranus.

IME it's been very difficult to get such requesters to provide the
detail we need to build to their requirements. Providing them with a
limited prototype and letting them comment is likely the fastest way to
converge on something useful. Press the Easy Button, then evolve.

Trond has suggested starting with clone_file_range, providing it with a
pattern and then have the VFS or file system fill exponentially larger
segments of the file by replicating that pattern. The question is
whether to let consumers simply use that API as it is, or shall we
provide some kind of generic infrastructure over that that provides
segment replication?

With my NFSD hat on, I would prefer to have the file version of "write
same" implemented outside of the NFS stack so that other consumers can
benefit from using the very same implementation. NFSD (and the NFS
client) should simply act as a conduit for these requests via the
NFSv4.2 WRITE_SAME operation.

I kinda like Dave's ideas too. Enabling offload will be critical to
making this feature efficient and thus valuable.


-- 
Chuck Lever

