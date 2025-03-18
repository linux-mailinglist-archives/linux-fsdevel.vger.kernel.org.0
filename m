Return-Path: <linux-fsdevel+bounces-44291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C5A66E14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13897A75CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5901F8729;
	Tue, 18 Mar 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A1RRU6Vr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jRTWkEAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3947346F;
	Tue, 18 Mar 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286226; cv=fail; b=LWu4MAQPprmXVNwMtTRd880D8dE6CkwvzyBq89SatpFW5EvvUfs6mciW3x1WLtpmxMX1Tz2vf5PEgMmPJINQT+CUGoWEL65SY8HbcaNVmIMomE5qjXSyuiFe0TKNr+cmjSuwG9iags8NnnKjyRbLVv5djqq/uCSuCLtW9OGW28Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286226; c=relaxed/simple;
	bh=g1pufprZlV59NckdRbFgje+/Z3/BEedamiojJGqXzcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hF0VDl4ikj4Q0PAWFsmtpM/tqBqBmnSZOEBM25teGizo1q3ldSpr4WWaUwlclBByceo1pNhOIM6WDS+61zsAiVVHT1+lAvco+BaRtWwo5t6rMQi/KWICZvcIrh5c+B5h7tWrC0GHzKygDzBIOZbt+E6YGEPB9UcmzpoFN8Bcv/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A1RRU6Vr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jRTWkEAJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7tnWt030620;
	Tue, 18 Mar 2025 08:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iXWz4Lts50U3LuWc5iyTQ92lvh8mhc3jbMscY5SLXs8=; b=
	A1RRU6VrqSLmJQd1AcS4RDAzPytRy7dFt/2spToQ2SiPlxDGNrqk283DwnpjSYMA
	KmsQhr4xoIWTRwi8I9ZNiYRrecy0kp2z2lpuVJtEYSW6gP+q198TKJf6rdK6/Hxa
	NKl6caq4nmCuMV8iM5Jj6gxmKl/vJndi75jQIg6TRSGGz/7DnKRdccvPoAk7t33A
	0y94vrCqr4rjYD6jNHMddG3w6z4qIhC/AA84W7xCzvwMxcWSbliv/a45IuU/lBa8
	sQj0r2Mk7Z84ApSqhLWteNX4FnctqlqOkWpTcNmu0avm/pECQr8EnZ8VaWt6U+6x
	zCcwXkYwFNIwPZwghuU/bg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1k9vkx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:23:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8A6wU022358;
	Tue, 18 Mar 2025 08:23:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc58w3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlmbpKnJE3IWu7JgaGev4/70+yLl70QaWthsjH62EQEG3T3KpU9RRO6duVz7wFxvEENR5iD1mxwJCF5jhKGUm8rNGp/AptpxzsuvjBRsoCMjiGRagXSzvPNROEtMyozEomiF0yLoNApuygUpng91wUEK7SlW9cLokDx2Tj9OEWKPW0pcBQa5HRMSl2G5hO7jZKvN92DImeNy3TDVpOIEp8HcMGX3LgLtv+Fe52Ir/My9GPrWOkwKjxl3XsVh2fGr4nhkwhNv2qxEiMLnVrzzqWuWLoQqIsX2/CQJ/SMuUTefQctVVz1h3n2aDuKArG/c70o1vnEp+y7BKDgdHRyi1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXWz4Lts50U3LuWc5iyTQ92lvh8mhc3jbMscY5SLXs8=;
 b=XAXJ1s63Z+6w0RiS7LsNxoEGz04zV8LvosxPtC/PQ2RWDhwqEWS1HuYKz7Qbz3kPjpGUXYnD10T9IfuFTyRMVLgAUoQQeIKkYpNgcGN5hfKNPW6N2jF/qLZ3rxE4kjNrs7HOeZ1X8n+wELnURLkMVWT70ZsLifwgHD0iQYeDEujeblKjWw/md2zYlBj2Cmkq3PdaIHSafYgIdIxb7b/GJc0uNbVAPC6DLa/9Z7uy+YSopoWqHPqhfpS0R0hWDPokubtwJxs1Y/L24wVNjEB9WQlImIAlMU7QV0i15qQEa2B397x0/HsF6K+lnLdeazEDPTJuwR5inwWfAO+AZqZfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXWz4Lts50U3LuWc5iyTQ92lvh8mhc3jbMscY5SLXs8=;
 b=jRTWkEAJUBc5qyRlWf7GrlIArCu5cduHWg4YAOWm9lFt7IkGM7TGpkQ7WQDgvWsPuQRcu7TCLQHa3rfzPOEnafnXrcZOOpvc2nXe9CJRxD7fDXMMCb/bQ3Zkb3jp3h+Fzhps4lYGUuqtCbOLnqZhOt97FkCIFO8LSs5ZRyUObs4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:22:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:22:55 +0000
Message-ID: <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com>
Date: Tue, 18 Mar 2025 08:22:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
        djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-11-john.g.garry@oracle.com>
 <Z9fOoE3LxcLNcddh@infradead.org>
 <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com>
 <20250318053906.GD14470@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250318053906.GD14470@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0690.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 517d9fde-8e11-4559-18bf-08dd65f61565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1IvdjFBWWtINW5LS1UxZkV2TnZDcXVMY2tUTWJYS0RIMW5Hd1JuRnN4UGpq?=
 =?utf-8?B?aUovZWJ5QUNFNkNKVWpWZWNtWVljK3JhY0hndzMvb1ZEUnA5OVNzN3BOMUhM?=
 =?utf-8?B?N25rYTdmd3NkTzNFUkhDcnNzekFOMjB4OG5zM3k5cmF0VzhXa3lyMmNOTVRZ?=
 =?utf-8?B?dk5BUkJhTzB1cjcxUXV2RnY5djQvUURsZDltVlV3TzgrOTMwa09SRkhKdkJn?=
 =?utf-8?B?N0pURFZsaFUxRHREVzlGQTFabjBzUGFLZXNSekJTSzNZUnZlNzJZdHNoeXl5?=
 =?utf-8?B?TThPOE5xUi82c21SSjV6c2hrT2p2cVVFYVJkeG5GMTlDQnJUS0Q0VmtMOGgv?=
 =?utf-8?B?akZMRHVBNVlSWVVWWDM1WmVEUklBdEt0QThTTGloSVRKcG9oZ1dtNmtuYStQ?=
 =?utf-8?B?a05FeEFUZzlOV3RHdEJFcllRRkZUY0Z2dUZlbGRwbmROL3A1bjRTeFAzRWRU?=
 =?utf-8?B?NHhxNk1XQnh2emZ5SGUxc3RTMFBnNWorVkxQYUVvZWZJUStBWUxqZEJGYllw?=
 =?utf-8?B?WVAwQUpmTzVtbjZVT2dYQ1BWL29uNDJDRk9DOGNGNFhmV01rYlZBL3ZSQTVX?=
 =?utf-8?B?aHlOVUJIR1F5SFk5V3VGcmQ5cW5qbHVTcklrcmcrdjZQOW1oc2VIUmp6N1Nj?=
 =?utf-8?B?NGtuVUFlTkdqUmZxWm5UWkJKald1QXZmVkNrVGU0azR2ZmNVWEwzL21rZnlL?=
 =?utf-8?B?SW5jTlJ6RVBFYVNRUlY5UGtGamhERnZpRkxUNzhEQXpSMzg4dDdJQ3YrUWM0?=
 =?utf-8?B?Q0I1S2p1bFcrVTFCdGgySnJIN1N5bEt6Ty94dSsvK010UEs0dVJqM1k1M3JL?=
 =?utf-8?B?S1AvU3d1dFFmMjlYcjd3V0M0M1Zzcm1NTDFsSUhOR2FkQ0lYeEdBS0V0Nis5?=
 =?utf-8?B?aWxIbXpublVXSlNCd25FbTNnR2cwb1E5NGhlQlFMV081b1FDUk9mRCtNUGJ0?=
 =?utf-8?B?QnJzYWIzK2hkb3hxNnlFdjRtVE9zem1TNXpCa2hQRlE4QldmL0xuOVdBQUtn?=
 =?utf-8?B?ekdKTEZ6a25mclVmVmJOcXlqNlZ3YllNMHlIYmlXR2NlblcyYUYrK2pJdDhz?=
 =?utf-8?B?UEhUdklJdXJ6bURRNXVmWnVqNlh4cjByWkVqT0JHWTJjSlNKdGIwN0VDdFRV?=
 =?utf-8?B?WU1ZTXFFTFJqZ2Z4Q21HMUt3b3dINy9seU9VUW5ZcWx0Wm1mMFdMOXUyZ2RE?=
 =?utf-8?B?dWNha3pYaE9Xa1BIMlVEbkhTbHpoQjh2cXA2UFhxQWlZZTByRGVaVGNIQWxG?=
 =?utf-8?B?MUVqMkNsdmFKTFBJNy9iazNnZ0k5WjdrUkh6NGZtbE03aHNTS0NnZGpvTzJU?=
 =?utf-8?B?VVZncFpXa01YbEtONVpCTXltR081K0NjRGloYWlEL3NiVmppZ1p4WGJIdVQv?=
 =?utf-8?B?Y3VjcmhvbEM2NkJtSFkwcTBOL1E0L1oxSEI3OHh0YjMzcTB3V29BaGpHYVhq?=
 =?utf-8?B?bDErdXlkMWdiUHBBeXBoTDJobXQxZHJUZjJKOWhxTEV3ZEdYWXFkMSs3ZkhJ?=
 =?utf-8?B?bjZWMnRNMXAvUFNWMlhxNWkvSERMNXhrSUVPaWp2Z3dYWnkzdEQ1RERVMmda?=
 =?utf-8?B?S1ZNTWtFMFdDNEluUlRvUCs1aWJnWEE1Y0pzekRJNnhPSm9NZCtlRi9KOVY1?=
 =?utf-8?B?MytHVnJFRG9jd1c2YzM1WlpiandQYXQ2TEd1WHN1NkVUTi8veGo1dmVkcVNZ?=
 =?utf-8?B?NnpXbndSeHNUOWFVT3dsWUF4d0J4ekJlN01PWTZRbnEydTJwSkVWUjd1b3dZ?=
 =?utf-8?B?RklnOERDUDNrS2FBczFkOFB0VnBpYURRc3ZiYyttQ2NyejkvTkdkL2lZWXR1?=
 =?utf-8?B?eHVyWHhQZ3lxVit6SXdiUndRclh3clVnL2RTRXR0SEQ4NzFSMmYzTmxkMWxF?=
 =?utf-8?Q?mIa/efP3DKMkm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTFha2JGUzVuREgyTjhmdzU3b1NXQmdwMXlpTVdzazhwVUFwTnZwakM2ZEZm?=
 =?utf-8?B?YXVBNnFneWQzT1kza2libHZ6bXoxQTlKVjcxUlhHY3VNc3U3ZnB6ckNudDBC?=
 =?utf-8?B?dFFpdjUreTFadkE4S3Zpa2N5OVVYVkZ4cmZnWUdLak9qNGc5ZHR5a0I1Y0hT?=
 =?utf-8?B?UXpxZElVYjJDTlc1UEtVcm9DeElHeE13UDhabCtUUm04cUcybHplR29ya1Nj?=
 =?utf-8?B?a0dtUjJwNWsrVkc2UGxqVkVtWmsvdFhVZFBnc2tSTnl1ZVlyekxVdDhsV1BF?=
 =?utf-8?B?VkRuNm5pK3NFclM4L0JJQlZFVndIMzBlcTh4TDAvZThtNmVKaGFwWlAxRXJQ?=
 =?utf-8?B?WC9jQnA3UWJtS1BNNUo1Uk5jbFhORlJUV0hxSjE1d1FPL2hVdG1LWkt6TG9M?=
 =?utf-8?B?dHRjcUptR3ZWRTkxY2taUXU3bWJ4cm8zOHozNURIUklrZmlUWmRieFA3L1pE?=
 =?utf-8?B?M0dLdWQ1TkVMSXJoR21URmlPL25oa0ZWd3VGZzhUQnF2Mm1xNWhWT2ptMU42?=
 =?utf-8?B?TjFzdjdDdzd3WFFlUnY2aE5hbkRQTHQwS25LSTErUjM3ZlN3dC9qSUF2OEtO?=
 =?utf-8?B?aFFsZFBRMGhjVEM1STlSZmdHM2ppK0R0Mi85ZWxMQytjdkx4SUxrL3NRcjBL?=
 =?utf-8?B?QUs5bTNaSmNzanAvbDczeFdRWFlRL05XZ2xwczFHOUh1WTJUeUJGWWNEdm81?=
 =?utf-8?B?d2x3MVpjQlNsT205T0ZzbVkraHlMZjE5bFB6QjUxNmk5VitobG9CVHhud25y?=
 =?utf-8?B?eU03OTltc0I4QjJEeEgzd2Q1VWN4dUY4Nk5wRWcvVTc0SkVlRTdPNVB0c0J6?=
 =?utf-8?B?a0Fua0I2b3RTY2NCSlp5MlJ4bnlLdHE1NFZRN3FGYVB2SFBIRklBaEd0R3Bh?=
 =?utf-8?B?ZzlOM1hjMGQ4NDVCYzhwQnhjMkVzaFZYZjI5WDNJRGlpdzlMQkR4M1U1QVM4?=
 =?utf-8?B?UmZtNm9qQjZIMXpJOXhmVEEySWNOQ3N4Y1ZKZ3hzNU1jbHBhRllDYkNvaFZh?=
 =?utf-8?B?SW1ZNzFYcWhuVGhPekcyR2pBbE1Zb3RFTHVpMm1JN2xuUlpQUFM4bVQyUjR4?=
 =?utf-8?B?WDNRbDlXTjFibDdlbks1bUJmK25rSGJOV1k4ZGhMdFc0MFR1T1RtWWlscGdz?=
 =?utf-8?B?ZGpESkUxK0MrQURsT1h0UFpTNHFyMjMwZFRZanJONXFaRXpOb3I0Z01pK056?=
 =?utf-8?B?QitDYVoyYnptaithWmh2SU1kQWRHM09Fa3ZUckZDVFRWYzdpcmhDSGRUYTBp?=
 =?utf-8?B?WjlJY0hrZHpxTVA1UmxwalVZYXR6aXYvWFo4WVJScUFQMU9aaTRVMmtpOXR1?=
 =?utf-8?B?TGJYSVd0c2ZJeHhrZGxJQkhsWFgxdURtVHVMaW45cWxXM1BObWtLM0kydkpE?=
 =?utf-8?B?WVBGRGt5UHNza1UzMCtEWUxtcFZmZkdZdTJHNzVZbmdBU2NIVWRJbHAxRlY5?=
 =?utf-8?B?dXhuQnplQjNaeG9kb1BETTVsKzRuZGFsV2xsWWJqOUxkZXcxcFRVcnF6VHBR?=
 =?utf-8?B?cDdSNU84OGRIQTlXakVUSFdKUjRqODZldXIydFNSWFZOeU4rbWpZQWlWQm5m?=
 =?utf-8?B?b2w4WXZ4cVRWZXhyRWQ3L0JzZ1NEdWlJVngxQUtTUjhUb1dSYTB4Tm40b0s0?=
 =?utf-8?B?YTBZbDUzYzBFdWxKN3J2M2trL01JV1JONVArUTViN3Rpc29lWWtqY1VFbEh5?=
 =?utf-8?B?SEFuVmlRaXd5ZUJrM2g2REN2dkgyS2RnUWEwbk5zZFBSejV3UDYrd3FIOUg1?=
 =?utf-8?B?WmlXRVltZjVVNEpuTnBkeGEvWkVQbDRQWjYrWDFPQlhwQVJpSGRjdWVxK1Fq?=
 =?utf-8?B?VEtiSnlVZ0Y5RHQ1VzVvQk5oL1BjSVpoSWE2QmdZZXpneWYrOTVHUldTam5p?=
 =?utf-8?B?RTdsSXJSVDEyd3Z5V0UxVld1QVQwMjhHc1k4TnJWaHFtdjVMRFlvSXVENUE3?=
 =?utf-8?B?WEgza3dFV1I5clVJS0N0T1R4blplUytPdnNLVWFNUWVPVFJ4NkFldTJxNEIr?=
 =?utf-8?B?bWZBeERjT0Z5QWhHZkMwSXZtL3BvNFUwUW1vbU9ydUk1V1BycHAxY0dJNWFS?=
 =?utf-8?B?cFpVTDloY3RzOVNQdms1ZTJ6bktSR2VSQXMzQy9ZSGZ4Y2FqSFpmSXd4bGty?=
 =?utf-8?B?eUFRYmRHU0E4emRsQUlsbGhUaHNsVENac3lDOWFZc204SXMzek1oWk1BZldz?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NVZ4b9Lh99XOKfff93GopaYnBLc0H5iAjG5SGucYYyMruvyWf/5KiRzudqJVhq50z3f69Rjizo3P1ay2wEE7X5yWfFaEfFQRiOmoaBjjQlpngUP+bqKI0ZOpmffmbAthxZBMzRzaf2kAB3VtMncrgdUSwu/QuC8cmvK3Uboh+K8qBwvUh1Oqbz08vz+p4PyVPOcQhe2lGx6OkZv+M+pK5f5f4dxVJEUJvIRujpLt7LtaoV3jEeenYI8fXGv+hBR+uoWrxSw7SeADX00uwrSsD5AREvk/F1oQghs63r+ZRgO6OWb8jBGqMofr5ibhZ+g33jicjfZAESObpTgBSmJNAYz+6yzgz10bmGZDgvZHy8z52fu96QmHoAcmrLgJ/3g3bvGuGsDVlwLXjYy9Ig7eY8VoBjlGqZxGsfbCiDb+qBqCmlzE+xPceKzBIxD0PRN2WVd97yIP+hSYeWcuGdsJ6hQ8kwLUeiED8V1WKLpPZp5qlVq31fB88MXDF07+CEn0mCVpqOLRK4WDz8HbZyazkbHDQC3+xmDPXMHW5n8P4VQvvqnvbNQaj2cbWr9wdZXJ01ovaJkyAXErCPWKZfZSi+q40L+pzyB5LJhohBCg60Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517d9fde-8e11-4559-18bf-08dd65f61565
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:22:55.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhTqrJueE2tMgPSdSIkxjuuumUAtrps+IrhbDNOWvaQNIj/LMXpqG9GGCXz1AFGm1VXJLuitD2tOuWiC6/DpcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=825
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180059
X-Proofpoint-GUID: FPJBphhUmsjlNwgGMwwm2lu1jgkS-85f
X-Proofpoint-ORIG-GUID: FPJBphhUmsjlNwgGMwwm2lu1jgkS-85f

On 18/03/2025 05:39, Christoph Hellwig wrote:
> On Mon, Mar 17, 2025 at 10:18:58AM +0000, John Garry wrote:
>> On 17/03/2025 07:26, Christoph Hellwig wrote:
>>>> +static bool
>>>> +xfs_bmap_valid_for_atomic_write(
>>>
>>> This is misnamed.  It checks if the hardware offload an be used.
>>
>> ok, so maybe:
>>
>> xfs_bmap_atomic_write_hw_possible()?
> 
> That does sound better.
> 
>> Fine, so it will be something like "atomic writes are required to be
>> naturally aligned for disk blocks, which is a block layer rule to ensure
>> that we won't straddle any boundary or violate write alignment
>> requirement".
> 
> Much better! 

good

> Maybe spell out the actual block layer rule, though?

ok, fine, so that will be something like "writes need to be naturally 
aligned to ensure that we don't straddle any bdev atomic boundary".

> 
>>>
>>> Should the atomic and cow be together for coherent naming?
>>> But even if the naming is coherent it isn't really
>>> self-explanatory, so please add a little top of the function
>>> comment introducing it.
>>
>> I can add a comment, but please let me know of any name suggestion
> 
> /*
>   * Handler for atomic writes implemented by writing out of place through
>   * the COW fork.  If possible we try to use hardware provided atomicy
>   * instead, which is handled directly in xfs_direct_write_iomap_begin.
>   */

ok, fine

> 
>>
>>>
>>>> +	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>>>> +			&nimaps, 0);
>>>> +	if (error)
>>>> +		goto out_unlock;
>>>
>>> Why does this need to read the existing data for mapping?  You'll
>>> overwrite everything through the COW fork anyway.
>>>
>>
>> We next call xfs_reflink_allocate_cow(), which uses the imap as the basis
>> to carry the offset and count.
> 
> Is xfs_reflink_allocate_cow even the right helper to use?  We know we
> absolutely want a a COW fork extent, we know there can't be delalloc
> extent to convert as we flushed dirty data, so most of the logic in it
> is pointless.

Well xfs_reflink_allocate_cow gives us what we want when we set some 
flag (XFS_REFLINK_FORCE_COW).

Are you hinting at a dedicated helper? Note that 
xfs_reflink_fill_cow_hole() also handles the XFS_REFLINK_FORCE_COW flag.

> 


