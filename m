Return-Path: <linux-fsdevel+bounces-32878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C59B00E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 13:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5031F22245
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D21F80CB;
	Fri, 25 Oct 2024 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fNgBXDqA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gAZn9wV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C5C22B66D;
	Fri, 25 Oct 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854492; cv=fail; b=tliZ3/otyAjahrnipU2zUDQt9x0J4Rn5Bf+LbX9FvAKKOXzzHzhLi1bGywHKoJSxmQpIhwchgRg7w9ex/Nxp9TRVdKIybDRazfA+SyS+KIpEA7+T+qzV0tzPE6Zaq4Sy6I3tJatoVoBf3OdcPMIY5ivtbPMhLS6rQA81J7GDJi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854492; c=relaxed/simple;
	bh=8m60kmIb0kLIz+CZPnzFjrRmUbBe/0cpcTneQ3/eW1M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQBi6TOdn3eqjI1+kHNENMjObDHtP1MBaSf6+wAjJqHe4vimVgRPWKrDjhkHz1k2gVyVwCVUfYmtgyVLsXChcnTm2UJvnXfuwmclBsNsKqiQZY3nvPDnXTibwCSaHy39/PQ2UCzXZojV3z494WUgbd3VsgaubZYGdhAsrGpBYeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fNgBXDqA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gAZn9wV0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BcLe025061;
	Fri, 25 Oct 2024 11:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EqvT44jh965/4se5PcChwOEXrHgpOwIgA9WEfhMzMvA=; b=
	fNgBXDqAQQAk6h77laVQi63XB72aqJ7cvRmj8Kd0PVF0dZEsuCffg4/D94+P1mMq
	+z8JUz37FiElerOvlYTYrBNlj3FZ38Nn5knDN03PX014cQNEPkdIvpgQL9TWe0hF
	XBS2+FNULtvfSPK8vz0GQxjDXg4hFQXbUjhyIhksky4EebUvN6ZP7ricO3xmVuU6
	CmTcxfW/5WH68+sIv4yNvCpByilK27Ix2xGHwoBYs5WB1BI56qFB/txqy0Xtvmkv
	1ScX++cmjN5hSVWBXEeoAX27gyODhLwuy4zGsmu4qzCfoDqdopXZxgze3v/fswrH
	Ig5oJG9tJTjc2AoZqjr/XA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qmq27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 11:07:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAQW0O039741;
	Fri, 25 Oct 2024 11:07:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdqsrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 11:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilB2kx7JbklBjm/rIaf4OYkSso0ufFTkG73kykXFBMD0FYYtM0HxrqYWpkFtyn7ZUlXKIGK5brxLZ1DY+xpZtBuXPahQUTq3dUV8PPsnL7XBvnDD+DjNtsJ565pEk5jFbj1Mhq/mT3zPRbeaUSEpIJwuUFbRzIKbA1RFQ+6NOIixz+FH697+eD6mzwXowcd62Z/CZW9hiTlR6amST7bbh2ucwNZhglsLNZCzqzOD6Urzwg1dcMSMnmmFbBH5ZhY6fWRmly5HnyUNSn+w1WGZJC9CMazgxXywH3K9Q2OiWnBrcK1m3zym3LdxzI7OFCepgOw8oZsAnC38d3u5T88veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqvT44jh965/4se5PcChwOEXrHgpOwIgA9WEfhMzMvA=;
 b=qZhpNZXO1dLpQwmi5PK5T42bJecKl53lqncmraycIPRRk3ElU/lJfnInO4Rapych7j8yusEQOuMLX8GgC5VVaxwNE0zjDE0mJ0kzTr7rTjgBemaBcqwZQ9ETJufV8JftfOhQsIo8zvaG+Px+cqHee4NJuxfdhPctXN6b79MQqhEjfE3SKxAGBg0VDvgc6gQvdKd5+WQyj5cz7rHvBkzt28kxBEevC45xwpu5f5UuuSgK43FtLZR1dU30sHqjqerGgaV3p6c3eWI1y1lgDmRv5nrUEuiE6ifRfNYsiZ+DIgPkSMIqW0neLVKO9dRxKpUkJzgD4n0U1P0D3ASI/QI69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqvT44jh965/4se5PcChwOEXrHgpOwIgA9WEfhMzMvA=;
 b=gAZn9wV0BCGtDWINMgZD/vBxsQAAak6gkHTkBUMx+I+/RTMAMsakt9tgL9vkhhy+7ajDSv/HaBUJs+YJ2qMSoIU9DxuBFf6vS38Kjoa579EYWJc6+kW0fSBNcbNTnhS5yb7XAD51jaZdk5eU8OOXE+/WkNOjMz10w656RoYwVZo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 11:07:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 11:07:54 +0000
Message-ID: <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com>
Date: Fri, 25 Oct 2024 12:07:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com>
 <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com>
 <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com> <87v7xgmpwo.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87v7xgmpwo.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 64929c22-fe4a-4f6a-c97c-08dcf4e54611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTRQRE84UDc3V2ZxeS9RM2JVTUx6UWFOU2szNEtvVTIyTnNQYXplS2VpcFBu?=
 =?utf-8?B?TGU1clNuVU00L1hzSENmdXNPSHArN1c2aVVvaWkybTl1WUhHbm9NUzR2R1Er?=
 =?utf-8?B?bTdVbFRETFF5am1vNFpEWmZveHptME80SlVLOU42Q2syTDJEMmdPZzlTNVdt?=
 =?utf-8?B?NkdHcGMyTEREQjk3aERvVENhbEFJcE9RV2NjckljU3VCSTN1SUxPVmpYY0Rs?=
 =?utf-8?B?MUVYSTlDS3BidVY1QWRNNjhsSkJsM3JIQmVwcXM5VE9JSVBDcGtmZ3ZHaFhz?=
 =?utf-8?B?YmxCNXp2bHY2NFhjYjdhMDlGbU9OS3docmtLd3RqM0RGNEF1U0ZmWVlqa2Nz?=
 =?utf-8?B?RlZmTDQ5T2VsQ0RVSkNhUHcreTBkUHVCblR6SnVqOFRJSkI0Ym5nVlNIUWpC?=
 =?utf-8?B?Ym5ZYTRQb2ZSTjBvM3BKUGU2RUlCLy9tK2NGamczWTNDRTZYU3RnRHV5UDlD?=
 =?utf-8?B?eUQ2MDNQNGZ0dVdFWlZudXJKUStlRUhmN2ZTNkVHcEYrY1htU3JQY0tQQm04?=
 =?utf-8?B?MEpqNXd6YXZ2bHF4ZXl3NFZLczM2azlPOUlxRE1neVNpY2tidmkvWHA4WUxU?=
 =?utf-8?B?RzRTWDYySE9tTXhDOUV0Nk4rK1ZGQzlpVmY0ZjFPMVdqa1RaK0RLNk1QRDUy?=
 =?utf-8?B?d2VvRHlWNVVRM3d0L2d2ZndiaVdKK25xdkFlU1FGc1F5dXNFdkV3Q0J2bWV6?=
 =?utf-8?B?eC9xK1hYUmw4RjhybTRxYTlsdU96YThYK3ZST3FKN2Nmc3prZzIrUUh3YkNl?=
 =?utf-8?B?bDZ2dW02N0VyMFEzSXA3ZnNoV29vWVhDRnViaVd4Nk9VUmdITXExOFc0dDJV?=
 =?utf-8?B?aCtCTVFocmt6bkp3L1oxdkNkc1NtRkdOcExNODdub25lT3IzUXZpV0F0NnI1?=
 =?utf-8?B?SXhQRW5CNmFjWDZEOExMbm5CblRnWkd4Szd3Ni91T1FHcy8wSVVSSkFBbEho?=
 =?utf-8?B?YmR3QTFDWE1vRWJIM0xEYlhEeVFCU2lmMGZhcG1BTFYzbExyRG1tZnZLUVNH?=
 =?utf-8?B?Ry8yb29ZZFJDT1E2MU9KazJhTkwxb1hHd1hITzhBeXBHTmFRSWtrWWhQMmlR?=
 =?utf-8?B?M3c1aG5xS3M5bWdDNHAveDdGdmxDN0g0Z1JSVERyeVltSU5zcmhqVlhmYlZ4?=
 =?utf-8?B?cHZRaWdFZXp2VG1ZL3dVVXl3ODhMakluSUVSZEROcHVYV1d2UHd5VkUzOGtX?=
 =?utf-8?B?WW1ETTRrWHdkL01sZE9VMEo5MUJuWVExZXMzN1J1cjMxYWt5NWNxdks1TDMw?=
 =?utf-8?B?YXRnbXp4L1NpZlY5ak55NWgzdzVSVFowRy9vR2h5NVJpdEZkNmVkaUFMOG5M?=
 =?utf-8?B?TFJ4b1JPN1gzenlZUnFsUHd6eVdVUTFXTXRqeXpDNkRLaG0yNjFhb0VPZnRN?=
 =?utf-8?B?MzhMemxSK3dBREtpdTJ6VkxQQ1hvMm5iNHo1ZlNnNlEvTnYxM1pBZjFXL0Qx?=
 =?utf-8?B?eThUM2FKcWhnZk5GdlpvUVg5Vzh5SXFGdGhpc0p1U2FyNHo5dHNZTW1DbnVM?=
 =?utf-8?B?MVBJZnpJR1NhSDFaNC8wQnFoRjNONlgvTnhKeHlkMzVLS0RwUnIxSXR4Vmt5?=
 =?utf-8?B?WGd4T3FIVzBkR2w2K3l3dEpTV1FKTDNiNTBRMGpCWk1vbFlQaVRYRjBHMjdS?=
 =?utf-8?B?WkZBRWQ3Yzh4dXcwdzUvUzVwbnJRK0xxQURHODhsYzIyR3ZVcFU2bmJ5Z0Jq?=
 =?utf-8?B?VnRQQnA3VVJpdmdDcHd1c2JuS3VJVDZCejRpVUxLTHdQOE0waWpvRnpXRFBO?=
 =?utf-8?Q?fBvylgD5Z71xilRlHcNXWwagQ+JUMPz+RbFNXVe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmlsRy9qSytxcmpWOVdKTlNjbW9WQjlPWXNwd0VFY05HZTQ2M1hGaUpnT1kz?=
 =?utf-8?B?aXo2MlE0K0toYVVPNFpQdFVFY1RIbWhlVlJuQWQ0bjBORlZEMFB4MlAzVGNL?=
 =?utf-8?B?K3JkcmYwM1o4dEMrWDhlNnJSbUZGNlRpOHdqM3BlTnlVWWt5Z0Q2YlJxbWs2?=
 =?utf-8?B?MnViNk1TazM2WCtOTGZPRmpFc29oMXVJTGQ3aGJsTXZaVGVQUk91ZDdYWndm?=
 =?utf-8?B?b0JhQWtwbHd3SThQUmpoblB6eHc4Rm16S3JVdkNHZXJEWkVhcTBsTDVEY0hx?=
 =?utf-8?B?K0xrTFV3MlRERVIyOGFPWGtnMzI3dU9jQnFubXpneHM5V25LeUZZdHBndW9S?=
 =?utf-8?B?bnJEYlFTWjlJSnVST0JPUlZxUVhiNjVVVHljQ2Z4RDgwUFNKbWlsUEVWV2Y1?=
 =?utf-8?B?UDUzNzRXT3B4cnhnZzhRSUUxcGhndXhpeDNhOHN6UG1ROHhDaWczRDU4SWVs?=
 =?utf-8?B?RGxMMm4vbDFZRVVXdkYzTWg0NzBpSHAzOXR3ZmZVMk84dFAxYUgxSUdYTTND?=
 =?utf-8?B?clBuOTBqck12UDFpdkJLVWlBUng4THNxcnM3eVpaeGZzSmZra1ZyZGJxTnpa?=
 =?utf-8?B?WEFrNlRvZkVMQ3BFSE1mOE56QkNmMlh2UjhYZllmckttMk01MFpkZTREenlo?=
 =?utf-8?B?S3FYSkdSWTNJbFdTeFBnV1cxNmtsN0pqaVd5MzdsVmt5V0FWeFBFdXFTZVN5?=
 =?utf-8?B?VGpSSXVwbTNvOVEzQW95R3VhNXFqeUpBeUJpNU5TRTRtWjNTZVUzSHJBNW1n?=
 =?utf-8?B?aERmZDFCNTFTY0lCaHJiNy9waTlPN24zaHhSRlBaNWtqbTBwZm5nUG0rQWxw?=
 =?utf-8?B?L3J0Ykh4MnR1Y0NGTys1Y0FPZmlFV1BuU0cxUU1za0RJU3hvTkZ5QlFSUnRE?=
 =?utf-8?B?VDgxeVY5MXQvZ2huZEJHdkdWOCsrUGE1WFhYNkE5VnlPbnlYNzQ4Vjg1WUR4?=
 =?utf-8?B?STdJQkFkQ1JUTENuUmJKa3VnVmNGOW5KWGFYeWFlV1dtaVR3cFZsVWI0VENL?=
 =?utf-8?B?K1VSMnVoTnhzSVRmejY3Z0J0QkV4d2MvekhiNmR3bFhYcUF4MThzVy85REtG?=
 =?utf-8?B?d0h3TG9NM0pMaWUycmpKd0JtQmRHbHdJOWNad1lHRlpXNXhTTXN6TzFDQk5y?=
 =?utf-8?B?ckkwaGhuUHJwdEo3clhsWm5kaHRxSGhDT0VhWFNCTjRIKzNYM256ZDBFd3Yx?=
 =?utf-8?B?Z3dGYllIRFlBdHRlSEEveDJJODg5S3lzY3Z4cDNXTlpZSjB4RUNodXN3VDBs?=
 =?utf-8?B?YmxKWG9xTCtXb3B2TitaYkFyZE1uL1NNK0JUOFFWeHUwak90enpYUk42UEdz?=
 =?utf-8?B?djJQVStxZjJ5UHdtNStkREF1YVhBV2FLZHBrZjNxMGtlSjN0b2UxTFVzN29G?=
 =?utf-8?B?cTJocUgyQzlTWmZwR0xIRXRibGEyaExQa213ZlZiZndENi9nSjNmU0VGM3pa?=
 =?utf-8?B?dThoN3RBQWU5Z2w5ajQzOXVVUVZMT1RSUkRYRldEQTBaY2liVDVUYnc5UVRz?=
 =?utf-8?B?QzNSUWo5dEYvd0QyOVh6eEZYdTRFQ09SdW5PTHJoazdFR2wzUjkrb2hIZmh3?=
 =?utf-8?B?dW0rdjR5Wkw1NGlmMHpzRDhBakUrZHVQZWZaaWVIcmV1UkpqUHZvTTVGb1Ux?=
 =?utf-8?B?elBGQU0wdlp5TlFyN3V3dEgxOEZlYlpjU2NDN0ZxN1BtZ3VnT0JkQWhJVnFL?=
 =?utf-8?B?cDVhdEFndWVjZFFLSjd3TmtNQWlKWGhJRmx2OHFoYUtUbjJRVXo5ZWVNMWJw?=
 =?utf-8?B?S2N5R1BRc1ZCNDdLTjdQZFVjbklsUk1MVEIwdjdmTUYwcmgxOWJWYkF4UWdx?=
 =?utf-8?B?WnVSSS9RN2toa08zNDJZZ25HcjZ1NzJRRXRPSk1xazhla21iZW4valNyVkVK?=
 =?utf-8?B?bWh0NzlKU2FNQWwvZEQxa3A3OTlrWUdsa2M1dEpzczBUY3B6TXgxU3VUTGx2?=
 =?utf-8?B?UE5ZM2ltR2lYV3duVmtFd3o1S01PSDhDWGx1aXhFUlR3WHpPdFNudWpPclRv?=
 =?utf-8?B?bWdkYkhsbHAva3Q0RjhqT0xsdTdBVXA5d3NQRHcwdjJlVFZYT0JKVVIrZHB3?=
 =?utf-8?B?bzZHYlk1UGJxVnp2QkdRU3p0bGhpaFk5ZzM0YkxaRmhic2xoRkNtaENrRXpl?=
 =?utf-8?B?d2RRaEdQVEc4OEtsMnpzN1M5TGFSemU1WnA0UGxrZFpXYTZLZUtlNFYvMzZQ?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sjD4vj+3oR6+Vu3xnA1JKQSm8zKVHfBiMb5NDDhpn9YmvvdMwaNYzU44STCORXxeTYIfHfOJNXvNaHP1CJvQVGPnR7lpRZ7nzl4+3POW6LRHU7dF1jRPh/CUhK5eCQnkIVrTkP9po5y1y5PF1K15tvcrl929v0vnpvDOOJMwD0hjm76rTWJyVkrcdm3sWQzuKI34eRFk4si9Ojwq2jM85+KL/v8Juc0xhOje0YmvxeE4V49pfHUsq19QnP4kvahw1nxb3JTdXSVMNgbuX2ShQsc3B1P85q5m1HtVu9+iFiiU7x7iJ7Ck6AsocvASYRHK66rgfOrswjy/r4LX/6DvFopxPSWOFDgPgAYX8Ad5IAbL9WBDCkwvvn+6d5nfLyCvpHKAsmZPY5HkGQaBrAXulXT12xbpHLgR8Q60tgsHTvhcgTndHxPE4Y6Bctfst8ggp/t8P+02ErsJBJk6+lS4DJHccUcr/2Jd8nbYcpJXD5+JMpGwvLimBVn0eA+JyuAMisNl2TD7OYQisg4DyuWgYVvwvg1B5p1Q6YpHbHUBkSAk/A8XCt9+7cTYCmxTkqj6eWgbzoMKti21XGhCwwbsl4gbYh184hrRUbDv4Dj5WDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64929c22-fe4a-4f6a-c97c-08dcf4e54611
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:07:54.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnP2yw8/JA7HLJh9owAKHCcU77AiyqPaxo0LTbf5Tv+YIAWc/nsMRKBRGbFtXWQmUJnsBvFSQfQYCdW9SVON3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_08,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250083
X-Proofpoint-ORIG-GUID: GDsfojls_WvwB9MQ59ug3FA6NY_ZtbLj
X-Proofpoint-GUID: GDsfojls_WvwB9MQ59ug3FA6NY_ZtbLj

On 25/10/2024 11:35, Ritesh Harjani (IBM) wrote:
>>> Same as mentioned above. We can't have atomic writes to get split.
>>> This patch is just lifting the restriction of iomap to allow more than
>>> blocksize but the mapped length should still meet iter->len, as
>>> otherwise the writes can get split.
>> Sure, I get this. But I wonder why would we be getting multiple
>> mappings? Why cannot the FS always provide a single mapping?
> FS can decide to split the mappings when it couldn't allocate a single
> large mapping of the requested length. Could be due to -
> - already allocated extent followed by EOF,
> - already allocated extent followed by a hole
> - already mapped extent followed by an extent of different type (e.g. written followed by unwritten or unwritten followed by written)

This is the sort of scenario which I am concerned with. This issue has 
been discussed at length for XFS forcealign support for atomic writes.

So far, the user can atomic write a single FS block regardless of 
whether the extent in which it would be part of is in written or 
unwritten state.

Now the rule will be to write multiple FS blocks atomically, all blocks 
need to be in same written or unwritten state.

This oddity at least needs to be documented.

Better yet would be to not have this restriction.

> - delalloc (not delalloc since we invalidate respective page cache pages before doing DIO).
> - fragmentation or ENOSPC - For ext4 bigalloc this will not happen since
> we reserve the entire cluster. So we know there should be space. But I
> am not sure how other filesystems might end up implementing this functionality.

Thanks,
John


