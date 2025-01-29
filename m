Return-Path: <linux-fsdevel+bounces-40299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD49A22005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CA63A65D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F031DB92E;
	Wed, 29 Jan 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODPPthBh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sIQIAO7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D314C83;
	Wed, 29 Jan 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738163540; cv=fail; b=mTCweFp0AQavDYD/80zihMDqdr00ecw+9p2jmJonTw4E5Cl2S2y2YnvzQMR64E43ZWhKrq5fvOChkT9VwrsdLSF8G0gV3uQFmKZCiJpm2nWmoPSisFW0TelQRK9NQN1bwCt+rpGppxZY8HILGlQWXRMXBEC352E8cxfFcpqv+Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738163540; c=relaxed/simple;
	bh=y3gX+MoyDCijK9e9A7Bvfu69aGfPqwT30xpeIO1jWtM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cvEEE0r7rODrUEsj3OsOwaR9P2C/LmBNJyURa2xgo3nUhUAPS3mzDJst5fzltpmfrRc08BmHUkr6dPs8ZERwRV5OsvegZrf46SkuK/CDc1IuS72yjdDDbvweEzF2ZYJj6R/318XobEwoRWwe36v7iRwdOMfsR9+5YsiiPfljd+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ODPPthBh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sIQIAO7K; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXwFH030043;
	Wed, 29 Jan 2025 15:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OpIjOl1yYm43dRSoNmH61wvIq+hEj7UYtU+DGHhD3fA=; b=
	ODPPthBhQX47dhIPbkOeQlURaXd++h+nQVk1VSFdJ/Mc93/XjyVrNTl0ZEJIQYBt
	2Wjj3JCeIIpXjjgQt27lrwQP/ELg0A7BtgMDEBzQE8UN7caCLWvH9pRVFOjavEII
	3smsV6/y9yCUSWRkbJEb1JKiu+VkiSeaIoR0smVAILzQGGRMU0ZETRFbWpnRObrf
	flOO9nz+GEnv67DBb0ugUk0mWAFrf5VL45H0U54R3r1H9XfuXf8WONtEhN7MNjSu
	lFWNwsGA2HUHW0Pzsur+bTOzdu+YFAHbZxNCENg32poQ8mAlwSvaLMfsr9SRPTul
	d2r69O+GehXgzT0H5ErvtQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fn2ug7t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:06:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TF3LGE036137;
	Wed, 29 Jan 2025 15:06:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9tguy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3g4SrHo6N4NWx0vQcJXmr6StwulC/7cjGo5QkpeuhGEIJndzEsPRZtaEkSes6LoexzcF6aHY3eSu+OeZ2pCCmOrM5f9B6RnTZ/aOE7KKAiziY95ZCPnEGIEBSP0zhDQM38A71GyMDINZbQb9WCIM8iVsglLDLGzRihk3kB7onjh4d98BcF67aBY/N6mi9TSAAbnfIiGdtp8ifTPjqmhZt3wnSX1HF6OoVa8Y704ZYG7sneZiyzzifkv9m4pxNAQ/06g0PgtqhiRCIGs+knoRRBfjOqZFjccIb4xu0VojOqofi2IE0Ut27u3TtEDPkCh1tG1RFryXszkV9Ss752NPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpIjOl1yYm43dRSoNmH61wvIq+hEj7UYtU+DGHhD3fA=;
 b=J5cyL/RGXFTafJPzMVPRZUOWvmUUiI3dqxpCoELoB/JShQaNQmokf0V2jec/qpMVxfQoB/QH8RMJ0USUW79zSxKBN6YrUQb3RRap+YgkjI7yHuWTc6SIzwiD0m9L7SG7Tetj4rtIScuqfCTgAx9/aHwdbJIEfQmk4gljK0clUe0NS5ucXst7bXZKtZzZAtbNoToZzhB0fE/ac6mS4DM5U0OUmC9RgF65cENWnG0poc/r52Dl6xD+n9W6Xs/ur2s0nTsJdULBwKY7vNzHRwEGkeJ0XHhU7XL/DWgQR0m6FY9Aj7H5Pn81JcUO4QcsYS/C1pMTCD4LfcJPetkYixGnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpIjOl1yYm43dRSoNmH61wvIq+hEj7UYtU+DGHhD3fA=;
 b=sIQIAO7KxxB3sJqOtH+MigkP63V/ss5TxA1FLGN8lugT6yGgEZh63Cg60AGKQ6BDtsfHaCrCS6jHMOezcSwdtVycHra1SBZYbKSkgeTm36C7crnueaJRQQERioyEBVu8G3vJLCf/b1ge2luj7JrGsOyDU4CMJeXElG/YvnfmN3k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB6003.namprd10.prod.outlook.com (2603:10b6:a03:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 15:06:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 15:06:51 +0000
Message-ID: <69d8e9dd-59d1-4eb2-be93-1402dba12f34@oracle.com>
Date: Wed, 29 Jan 2025 10:06:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6.6 00/10] Address CVE-2024-46701
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>,
        Andrew Morten
 <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250124191946.22308-1-cel@kernel.org>
 <50585d23-a0c1-4810-9e94-09506245f413@oracle.com>
 <2025012937-unsaddle-movable-4dae@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025012937-unsaddle-movable-4dae@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:610:b3::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b66be66-7d00-42c6-4c41-08dd40768fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UElvMFZUQlpTMndHdjNucVlZZ1J2VmF0OGRDUHBRb1ZTNTgzbTh1R3FKSEw4?=
 =?utf-8?B?RktQVWJBTDYrUnhuanJoYlNJSjZNUXN4aWp1UXBXd3RFQnhsVk11alZiWDdD?=
 =?utf-8?B?ZTQ2ZXJzVzd5MkNJcWNUUFE5NUhqY204eDlJei90VkVudFRyVFBua3B3UC9G?=
 =?utf-8?B?QjlsWWMwUHpiNGpJV2o4QWNyS05wUGIyd2w5MzhSZ2xUU0NvZ2NVNGhyU2RQ?=
 =?utf-8?B?a004Q2JtM2d0NVAzbnZJZG9ucm02ZFZKdTZXZDdvbHh3M25lQlRkdlZvNTAy?=
 =?utf-8?B?azh2dnVmbHkwbkVjd3dmYkJnVXd3VXE3NUZwSDUvbXBZaVZmd1F5MENIUldG?=
 =?utf-8?B?RlEvWUVsVHJLV0hGdUxIMVZJZ3AxMFh3eFJlVGRBcnpOVFFCeGFFTXFkbEJh?=
 =?utf-8?B?bEU2RTZxNnJ6dXN2b0c4TDFKNk93YjlVdThMeWtZZEF2eGtTZk9LU2JnZzYr?=
 =?utf-8?B?di9EWEVGVHl6T0p2ZWNIUHlJMTFzU2R1Nk1RcmNzWDZURFR5NGJQYTY4VHJa?=
 =?utf-8?B?L1g2MHRVeEF1bCs4MUVBRlM1QThUY3VuYkJXZHczWWk5VkxuOG83WFJ1Unpn?=
 =?utf-8?B?WktSTS9iNm02MFFZMStaSzB2WFNTaG1Lck9iSnFsVHpPYnAwYW9QZ0RKZGEz?=
 =?utf-8?B?ZEFhZ0VidW5GcTYyb0VKQjBSOUlCQmRWdjRjYUc0cmI1cVJUMGI2ZlBMTnpn?=
 =?utf-8?B?K3RwWWFhMFZybkdCYnI0TEJMZmxHQ3c1UXFObHlBZXJyWm1GK0FzYVpHZU93?=
 =?utf-8?B?c2llcSs0dUVadm9TcTJ6NGVsSkxNZExhdW54dEczUldtRjkzVUxvNHV1QnA5?=
 =?utf-8?B?Q0h5dnhISkxFdVBORGdPYy9PbXlXNURyNXJLWDN3dFQ3dkFVNlpDN1lmNDhE?=
 =?utf-8?B?LzJQWnNjam5EdTVCM1NwL2t4RU1rMXhDdVRKck5CYXE2Z2hCWXdSTVhKNEhO?=
 =?utf-8?B?TVZyWlVxR0VvOGJySWJkVmtKcmp0RkRMSDF6dlBBdkIwR3BmRWdpQVBBTERl?=
 =?utf-8?B?MGkzTk5UMDNWSnpoRHZEQ1pIb056OUdiNzVNbGJGYzZEbTJvZklMSUhDYjlw?=
 =?utf-8?B?QlZjNXl2ZTFBN0hDRldsQWFZVGppdTV0UEtGcnBYclJFR0gzZzZBNHQ3RGRC?=
 =?utf-8?B?dC8xT0R2WXZ4QmtpTS93MzF6dnp4SjhFdVozZnVNQVFmS1BKQUdEV284VVFF?=
 =?utf-8?B?ZERHV1o1a05VV2Z0WU0wVHRiTlF4aEoxd2ZrWUg3cVBDVEhYK2NkMzNJVnJ1?=
 =?utf-8?B?RjNGRVFIWFFMR2N2MlRGV3oxU29Calo1K2tiS0piN1BKK25uOTd5UWxxd2tq?=
 =?utf-8?B?dkQ2VkRUYjk4NkFuSmZ3dkVtMkxnM3VHT05aVGZWVlUxZXpWbHkvc1B4QU9w?=
 =?utf-8?B?TGFTaWhqcDlsNUgrTTBIWUd2V0l3ZC9NQ1NTU2VSVTgwMXlXN0I3blN2SW45?=
 =?utf-8?B?WHRxV3JIMU52ZjhhSzF1a1cxdEt0OEEyanhSMThibHpBcHFYbFZwOXArOHBn?=
 =?utf-8?B?UXdaOFFhekliYmVpWWRCN3BoV2xhZXZOV2xMQzhob05nMDk3RVR0bllKQjV3?=
 =?utf-8?B?OFRjajZnWXQ3cCt0cko2QWtLaG91cGtUc2JoK1ZOZEY5RUZESGZ1Tit6SkF1?=
 =?utf-8?B?eHdSazNybDhyLytoS2UyQlJSN3lFUUpSRFJ4cFA1RVVIK2U2UnVjMjk4dEV0?=
 =?utf-8?B?ZDNPRmlYRW9VMjRZOTIxbDdaQWZNRjZScWR5ZHA4OE5YTDh5ZnEyTlpJcC92?=
 =?utf-8?B?K1dnd2R3RE1YcDF6WUQyME9WS1I2U3I5ZytPTXVhQVVxZllSZmZPM2JvdFRG?=
 =?utf-8?B?azBEeG1LTlVLMzdUTXE0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnFtWS9ZUkw3Wkg4cTVjYkxYaG44Tm5LUmxkWkJuWS9va0ZTNUpGZHpPNWd5?=
 =?utf-8?B?ZjBWUEJCRG1hWWlSZ3RWZjJaT0dEaXlXK3BnaEpLQXBkRzJuemI0Q3VCckts?=
 =?utf-8?B?Q2dLclFiRUozMWVvc1czMHRHRHVOWkxHTTYxZGRYUS9zTGo3TzQ3Y0N6RGtF?=
 =?utf-8?B?UUswSGFLNjlWckYvTXpJcGczMHo2YjFQTEd2SlVWcm54UldFRkJJdUxpR21T?=
 =?utf-8?B?ODZ4ZGJxMjdOVmlPMDdkblU2d3VGbFhZbEt6c3REQkZNSXN5MXd5bXo2SHFE?=
 =?utf-8?B?Yk9sRmtLTU8zTWxWU3J0UWFSTHlWYTlQY0ZZcXJOMjBQZVBDZDFSZHYyM0Iv?=
 =?utf-8?B?clAwaU5sZkM5aEc4VzhRTFFCVnFXQnk3czdya2pHYTJBck41TzhvdmVhSE4z?=
 =?utf-8?B?Sy9pbFRmYVZ5MTF1dDkxS1BMVkxOaDJNb2NKanB0ckZwakJoU1lDOVlwT2Va?=
 =?utf-8?B?bzVpZFFsUmNWcTNrZnJOZ2EvWkFJTXlENkhJVEZGdnlMblI0dEQzZVlNZ0hP?=
 =?utf-8?B?WnNsMTdPM3lyeXdsMTFvSTJ5aHJaOUlaOXZVVGpIRkV4eldhKzN4LzNRZjFj?=
 =?utf-8?B?UVRCb1o3cXJxbXhOWHY0dEs2MTdOVlVZZHRERmc0d1hIUnRUc1dsa1g1dEx6?=
 =?utf-8?B?a3JMUHhlT3g5M1VrQmVMVUUweHRkS2RtOVlCdU4wbnp4UmJ4WnNHZUNONGIx?=
 =?utf-8?B?VGV6ZDBJUXFQbUJScTdidi9nc0hQWmZxeHdNeHFsalFkN0FqNVVpNWVxNGhW?=
 =?utf-8?B?TGx1SDFyMitJRDlkRisrdDd4aEQxa1AvbHJpaytRR3I0NVNFczBtWXc5dmdm?=
 =?utf-8?B?QWU3Y1lKSVo4RWlsdWlvMm1GM2xZU1o5UGY1bEREenFkdzRseHFjMXE0aDZC?=
 =?utf-8?B?UUthcG8yVDk4QldhZnVLVitIZkNZWXgxK3FMY29xZUNDSXNqYnZ0dnEwMnYw?=
 =?utf-8?B?ZUJuRXZHRUROWm9qekZjWE90dzh1Vjhpd1E2RHhsZjFRS1k5WWphcmNYckhu?=
 =?utf-8?B?YmpMTllZbnNqN0JMOWdGMXRNMDRDeDlQb3YzRG1TMVJvVmdxbVFDbjE1RDUx?=
 =?utf-8?B?Mkl5bWF4Tmw0Mmw3SWRtRUNQT3V3a2l2ZVZFZzdkUVRZVzhyNEhGbVZOSmxM?=
 =?utf-8?B?MXBiZlFNY2xvQ0hsYThZd2JXNlloeFQ3R3hyekxkS0x2WkF2ODlYcTQ4QVVp?=
 =?utf-8?B?dFFLUHVWNCtuS28yK0dGcG9VS1E5Ykw3Q2FadDdNYlN3Y0NLU3hRWkxoNEp2?=
 =?utf-8?B?RHVJVFA2RHc4S1VmQ1FRY1lPbW9mcmxLZmIwYjJTYnplZmhSbk9wSXc3MlFp?=
 =?utf-8?B?RkNzZVZpRy9KUW8xWlk4cDdBYTcxUTVmZ09UWHRPcUtXTmJQT3JkcHovKzhM?=
 =?utf-8?B?SmhkUjRkU0l6cjNwbC9sT0RYOVRKVmtIV0tZRnVLQTA2Mlh2bHdsemtWL1dw?=
 =?utf-8?B?RVN4Z1cyTWZuajJjUFVaNkFWaCtOdUJBaDZrcHkraFVla1llN0tld1ZubU0y?=
 =?utf-8?B?ZVhTWkdmSStSbmVrY3ozV2pZTWNiNzJ4TkRONVNvNFd0MFp4dThRS3FIVExG?=
 =?utf-8?B?YWw4bkJmRzV1elNoTVplOTlTOEowVUxKejFqSXRtU2R2TjNadlN5YSsraDJ6?=
 =?utf-8?B?Y2d4VHhQZXNHSThwNDVwNmFwRGpwajJLcVhyT3NvSXIxdERkclNnZ2x6Njkx?=
 =?utf-8?B?bU02akZXbWJ2RnRoKzlvVTVxQ1pPZk5FRFAyT2txU2dZakJoaGhVQzRoajRq?=
 =?utf-8?B?TkVEL1BiSmhaemc4V3ZwR2xEZEg3Qmt0TXRjUWZtVE92L1UzQy9GejZzVmZB?=
 =?utf-8?B?aXNobjJwNWxRK0NWcWM0VHZvY2dMVzdRTFNYL1Q1a0RTcVZmdHZLZ2dBUDQy?=
 =?utf-8?B?WnVXNVdEdHlTMzVGd1VnRDF1SmtwYktJQWhSWnNaU2RCUjNBb0hsN25Lekl2?=
 =?utf-8?B?MkM4ZlpETER0NWw2Q0V6WnUwbSswMzZZTWJQYW9CZUpVZUNDczhRRTlEY0hv?=
 =?utf-8?B?YXdRcjVNWi9yRHVmK0ZTYUJNTVE0YzRRNjl3M3g1eFNncmV3Q2FvajVrN3o0?=
 =?utf-8?B?UmV5UklOaWg0RDdmMnZjMkhibnRzeE54YVNnQUErSnIyTldkSUI3QUNlTHBK?=
 =?utf-8?B?YUJZN3IyaHVxRzVDQ1YyM3ZVcmIxRCtUb1QxbmRoWjRnVjNKa2s0THhyZ2Rw?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BXg1Wrv/aWwMT1XiayGInbAHOojqY/xtJWTt6CIVIVOva7lMdYCmPHVM9En2hwCOKbZmfI4XK/FedTNh4ErD23gA8Hx5/gUhH9cZSIXqsB66QhCn4YlkdHl6iCr8ucLOJ3wf66P4IIvaqRTwVw+c19dxibuTbAlv/SX7xP5eJyRrP61kODKUAoGOrr5M41iUIZAIefcjS/P8kX4tpD6W2tAAh7Clmx5ZvyzyABeRoSExFyXEtHD+bUKmxDB3nfMT0Bo1Fol4btDgxS6ddhMX85aL8syRBAXyfQQ02159A14hhAUPc7o4AIJwjE64EbK4U6G63zlRKDvjJAif4EzDDDYdZ6ByKKJMM/218SkgJuYhuaEe2KNuEAM78A7QpMr1wzzXm2sEDGWX2A3fERfPSJGIcizuqN1dT9LboaCcN6Mu+vZlZd/99F5j8Uv5XlwY8AsPrqEx9wk9pdtdcfH15+yjXFg02WPsW4M8ksO//f7mKXNem5HfuEvK2uhQQRWpFMdPnvod6uE4JHblEUhWXAG/E3jMnEiIQNs/GM9nV8LhMyoq4ZVmZHc2mYYuK79oMiAzT43QVrpenFhAmWGiS8DcXFpaTod6v2/fqVkJoJ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b66be66-7d00-42c6-4c41-08dd40768fb2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:06:51.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bvzapAzEJFWTJaIpF/kdoscgtIXFl74d0WusR0Oh1lv6RKgPzzGLoSxlULuYdHLKXasuSgorSa1QYGcTZiaEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290122
X-Proofpoint-ORIG-GUID: nsV9PFCM35I3N3H4Bc2NU8vb5RhOaDOL
X-Proofpoint-GUID: nsV9PFCM35I3N3H4Bc2NU8vb5RhOaDOL

On 1/29/25 9:50 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 29, 2025 at 08:55:15AM -0500, Chuck Lever wrote:
>> On 1/24/25 2:19 PM, cel@kernel.org wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> This series backports several upstream fixes to origin/linux-6.6.y
>>> in order to address CVE-2024-46701:
>>>
>>>     https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>
>>> As applied to origin/linux-6.6.y, this series passes fstests and the
>>> git regression suite.
>>>
>>> Before officially requesting that stable@ merge this series, I'd
>>> like to provide an opportunity for community review of the backport
>>> patches.
>>>
>>> You can also find them them in the "nfsd-6.6.y" branch in
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>
>>> Chuck Lever (10):
>>>     libfs: Re-arrange locking in offset_iterate_dir()
>>>     libfs: Define a minimum directory offset
>>>     libfs: Add simple_offset_empty()
>>>     libfs: Fix simple_offset_rename_exchange()
>>>     libfs: Add simple_offset_rename() API
>>>     shmem: Fix shmem_rename2()
>>>     libfs: Return ENOSPC when the directory offset range is exhausted
>>>     Revert "libfs: Add simple_offset_empty()"
>>>     libfs: Replace simple_offset end-of-directory detection
>>>     libfs: Use d_children list to iterate simple_offset directories
>>>
>>>    fs/libfs.c         | 177 +++++++++++++++++++++++++++++++++------------
>>>    include/linux/fs.h |   2 +
>>>    mm/shmem.c         |   3 +-
>>>    3 files changed, 134 insertions(+), 48 deletions(-)
>>>
>>
>> I've heard no objections or other comments. Greg, Sasha, shall we
>> proceed with merging this patch series into v6.6 ?
> 
> Um, but not all of these are in a released kernel yet, so we can't take
> them all yet.

Hi Greg -

The new patches are in v6.14 now. I'm asking stable to take these
whenever you are ready. Would that be v6.14-rc1? I can send a reminder
if you like.


> Also what about 6.12.y and 6.13.y for those commits that
> will be showing up in 6.14-rc1?  We can't have regressions for people
> moving to those releases from 6.6.y, right?

The upstream commits have Fixes tags. I assumed that your automation
will find those and apply them to those kernels -- the upstream versions
of these patches I expect will apply cleanly to recent LTS.


-- 
Chuck Lever

