Return-Path: <linux-fsdevel+bounces-37173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD659EE8A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A6F282BBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55242147E4;
	Thu, 12 Dec 2024 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BTH6jiyD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TFv+2pLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413D8837;
	Thu, 12 Dec 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013307; cv=fail; b=hEuq1Mo4hO2b/Y60ayzFg90Z1sR0kKK4xxgBmscmbAoM8wxpxX63RAAD1fOmGw8aiGozZT/dPnrxfshY85eHfnXRelbZzPZwk/+KJY8E1lGKQ+57VuDMhhajXOyhwTqgetep9lQU2QFY3gLhiR60jSRKSHBpCA4/vge9F3VtB58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013307; c=relaxed/simple;
	bh=e2ujVaUFWPlk4Y3k/2tHN2x7e1h9mG+w59F85jVoa0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=adfvdbO0s5H0JMP3OXNeb51Px1HRP7QOs1k8iSC89SXwKFsj85YfomuxRLq7QMwI8CyvKNNPcA7O47rZVsYPOMZxzGTyCQiYuYEjYa55JR+A1VAaQJiyYo4VdLbg/ISZz32P1hkLkIV7s5E3mqpDw9eezCiOkFo9QUzGbjM8DuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BTH6jiyD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TFv+2pLL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCB9n82026505;
	Thu, 12 Dec 2024 14:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SU2KmUEE/XwseZF0fGeqNby+wMx6Jxc8CWbmfvktxRQ=; b=
	BTH6jiyDtBxe1MQlHjgSxvyJ0F5I1nkAFiwZwYLR1J6oRzzrrpEIt5EcY9DrgTMp
	xHcK0iCpDYReGpms+Fou9Q48rrdItFzKy2jpnQJDXN6h7HQ1RPv32HxKr18KVT30
	IR0d5fpwjdxnP8WKYFrBac46nxGNUzAFRB8YJCkqljdjobSKF80yBxd9CsQSeWQw
	G+W5cIbeTxuYwiSs5atkY9DtmUpws+sdQ/c3FFE4xfQMeQCO1OhfYyp/lmF+2L1L
	ikIaK7wFfd/+CzLcOZEu5CWE0iKDBto8mCYDaFI6704ncJhH+8/jq6slL1DgbmUK
	JoI0kmTq3Fzsc/yBnTtHAg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cedcb8a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 14:21:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDQOwC019280;
	Thu, 12 Dec 2024 14:21:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctbe8ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 14:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpumQ4jYlatdYJ6l2glYoHmCyTuyXCzdRDXt2Pz8o4UtEd3LncY6QX3RIXIKA98ZOYPfIFfYElmzuSS9Y/YfWWtChiuM2M+MA8AoUdUZCVhANFgZNUJo7YyM66vrdFoHzv44w8VbIjAFkzzKOQpcu3i2c0P5m40Q9Bj0wBSQvvjoxmdCSgvkQF2Xkh0kgCiYm3Pjy8qEDDcii5HV/5mzor1Ah2FCVRPIMug9WsKcwj3Gcxjr0L0DBQapXCgM9cB552hIvWSzw37k6F26UgHCn/K1ZFU8/VH8ycK2e3HXCZi+b0cSnC7LlvmBghM8NL6S55RQCJOVi1z1Gxe2Fn0sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU2KmUEE/XwseZF0fGeqNby+wMx6Jxc8CWbmfvktxRQ=;
 b=so3/8txX/H+TyvdgszPGP6PsE+XOMNnEukMtky9+FVd1H6EC5AK7kouek0yGEJuvOljA+oIL0FA9kj3KUe1aiL3d0OY3lgggr3wxU8t4Vi/tMez5dIzJQUFRH+TFUG1sy6mis1nxyP0kUpm7HwJdAKOc5E54DVI2lCdjng9aLLGJW7yuRg6tNh/HLL+tyeixHiE2DHHhdEYxBoEHmh20yWBnwCL6woEdPzxEbCpabitiQk8QDR5e+6DBCx6B9O094h2DJ99DNrkYoiyQ/2ndY1jwfwgCrUgTeCp7tZJsW4pxeRbxVDHyagHVBOCbSWFDW6DsWFNWSSxdxVhUq2vXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU2KmUEE/XwseZF0fGeqNby+wMx6Jxc8CWbmfvktxRQ=;
 b=TFv+2pLLpj/iBkX3+sADAxm1N5O55zK2e3oBTBqrb3mLcW31BooIxvm/97sM5mmZedordPlWPzhzZ6k5qoy2eU+zliiZwqq1SemBastQ9HuEJ9SdPQXky277KeTJNDtnnEehY2jzFVD9r3pu50i2p7EHIm2tBfVoAxCxqj6PYAc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA6PR10MB8160.namprd10.prod.outlook.com (2603:10b6:806:43f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 14:21:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:21:35 +0000
Message-ID: <c84e84c2-7705-47e3-bb2a-35175bddadd6@oracle.com>
Date: Thu, 12 Dec 2024 14:21:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] iomap: split bios to zone append limits in the
 submission handlers
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-5-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241211085420.1380396-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0698.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA6PR10MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: faf7e091-1e5e-45a2-afeb-08dd1ab848b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmhYMUJhVFA2T1hoTlIwQkplRk42T2dzbTMvZHE3V1ZKK1dBVUlGYU0yNGRT?=
 =?utf-8?B?ZnVYQXJNaGJpTEFMcFgrSTFMU054K29tbmVRSDEwelo5TFRBUUlERC9FVUJB?=
 =?utf-8?B?T1RFWHJLdktFVnppeTg2Tk8yai96WnJiV1ZVK2NLS1VtOCtRbWxEVWZySUdJ?=
 =?utf-8?B?SXUzTEltdjFBSUxtYWtxUzV4RU1vdW80a29vdm9xN3FsM1RwaHJveDFVai9t?=
 =?utf-8?B?NDhTTExRSERXbU9vNWhFbm9BSGd4SHFsRmdkVm1rMmR5Nm5LcTRvOUVHVFlO?=
 =?utf-8?B?Lzd5ZlRQT3ZTRmJ0TDNIcHB2L2ovNjNxRzZDRTNUbk8vRCtYRUZHMmlhSjdJ?=
 =?utf-8?B?b0Q3QWJtUzU4RjBDR2V6VGVueW1tdzdwN1pLc1FwN0VOTUgyK1dzV2Rvb20z?=
 =?utf-8?B?WkxRL1NtSUFMT2RqRDBLVHJaOE1FRDZjd1EyMXFPcjhZRHFGQVdwVGJ6Y0oy?=
 =?utf-8?B?dkFiekJEZTJQYVNTWHdObENBWDMxTGZwbVJRZ1FLQy94K0FrUzNFVm1yM3RC?=
 =?utf-8?B?eDFBbWFJc2tLck1kRU52dXR4eTd3MThWSTljemlPMElwTWw0dmVueC91eDhN?=
 =?utf-8?B?WlpFdzBqc1hYUzdlZjAvNTRnUEtwSm1uL2VKK2FxWWVCWDJXaXdpNmpBVnht?=
 =?utf-8?B?WEdpakdYRGErYU04UkFjVGxvQ0RINmVoR1NDbFRKZHpyaHRheXhsODh0TmNE?=
 =?utf-8?B?Y1luVGdNTTVISksyRms5OEI5ekVSLy9XSTNJOTA4WlJhSTcyaWJoaG85cDlN?=
 =?utf-8?B?YWYzTjVRSnFwWGMyRlBPZi9IVlNxKzJ3eXRnRlMrQTNYdHVTb3o2ci9EdDN3?=
 =?utf-8?B?bGN2NC9XdFQzWmRiODdhR2FCVytJVllIdGRvZ1B2VlRlUHpQb21wb2lvbkFP?=
 =?utf-8?B?UENoU05EZXJiTHdDcFdDSXF4cUg5aUtIWFlNZy9RRE5qUW0rbUdvTk9ueVkr?=
 =?utf-8?B?bUV3UFMyNFVQV3pHK0VtczIrNWFUVzY5MVErUVVKb3h2ckthQitrcS9vWkIv?=
 =?utf-8?B?RUNpY01vUUY2cGNFSzBYcnFkbXU5clhvYmJhMzBwU1FrNkNlZ2J6SC81d2xp?=
 =?utf-8?B?VTNRSTF3a09WTHlvY2I3MU8rV1pZdXhLUzJXYWt5T1paWjJucVpWdVNiaGFN?=
 =?utf-8?B?STh6MTkwak54SjNaZE1wRjRyQkFvYk9nMHlRY1N0SzVtc2RyNkhGUlU0UHZZ?=
 =?utf-8?B?VTNFd3JzVE1qN000QmxmZ20vOGlZZUlVRnRxS3JlSllNcUlBTEgxTmFJNUtQ?=
 =?utf-8?B?dlhGcVhTS3JLNWN5bHNxQUlwMVJibFZjQzNqdFlsQUVNalFaM1ZoNEpLQzho?=
 =?utf-8?B?MlZmeWsrVVh3ZEd4NlNPZ2JOWmtjTWR0dkExMS90SU5iSjdscVV6STRQcysv?=
 =?utf-8?B?WjhOYWZtOERLUjJQQWpFQ0pqQWlNN3hlRkJBeFVCVzlXd3pUeVU0WCt1WWFX?=
 =?utf-8?B?dWFMUHJyU1QvaFd0UlF2ZDF0TjJOUGowcVIwYnB3RFFXY0JJc0Jmd2krUmUy?=
 =?utf-8?B?SVplRnh4UGJ6MkhkNzNibHN3LzNqS1BCSGFvb09Mb1lWM25YbWlzMTVZVitM?=
 =?utf-8?B?QWhFRHhSdHd1ODEvYXBiWWJjbzdVWlREM3hueFZyWXlncWRxSEZSaUpsTzVN?=
 =?utf-8?B?eGZMZU5WZ1ZkMnBvMVJOVWhOcUpmdG5nZmhUUU9MQkcvRCszTW5nVTlyM2ZG?=
 =?utf-8?B?TU1MZDVRNEVpemdlK1RQbG5Dblp5QU5nNTBQZ1F2Tmp3R01GWDhDTEtubFdC?=
 =?utf-8?B?Zmw4emxub2daYVVPSzZFZFEyRnllVk8yVHJqUHpvTFlsZkVjVnczcTdxeWZz?=
 =?utf-8?B?aUlKTmcxdnpnSHg2SVNNQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjZCeTR4RmVWUFFiNFFYcWRnNnJBR0M5Qlo2emtaMkhZdlJTZjVVc2Ird0Vv?=
 =?utf-8?B?S0FzTUZLQ3dVNk0zb2wwa2hKWDYvRUpZbTNkRWxBb1pCak84SGZKWXNkZkxS?=
 =?utf-8?B?WmZwcEx4L3VKcXZpbERsRldCMkVrOUxGSVF4MGNvZG01MEphR21ld3Vma2wx?=
 =?utf-8?B?UVo0aGNkTmV3VVNOYjh3TlEvRmVBUUp3dVB1bmFFTGozeGs0L3QrY1BQSWc3?=
 =?utf-8?B?QlUyZWdNZEc5eW5sdjBIelRGaHhmeW92TUJSSU56cFJsbVNMTVN4L0xrZkpG?=
 =?utf-8?B?VndXVnpSbHF4T0RWRkM5dXI1eGt2dUVsREM2a0ZEbVdNbHBiZnNKZFN1OWRB?=
 =?utf-8?B?bTdDVDZqVzk2cUxLZHk5THhPdHpmOFRQUExaTjVPUEVUdXphWW45YnR0UE5h?=
 =?utf-8?B?TitGRTBLN3NTNzhPeE9tWFFHSTZZcmhPaVA4OUd3OGNHOUFSUWpwM0RvRTlT?=
 =?utf-8?B?aGoyOVcyWXMyQXpQZm9nQ2RwSXpYUVkyWmtnamhHTEs1dnRsa3V1dXhVZHZm?=
 =?utf-8?B?VG5pY3E4OExVRE1yWFlVQ0ZybHN5Ull3U3poR3hCLzdkWWRSdk1mOCs3VExq?=
 =?utf-8?B?emJnb2c3M3QxUUdiOCtJR2VUeXNOOGJuWFNEVTRzVVNDN2laakdINnV5aUsr?=
 =?utf-8?B?VUpYcVNiS1padktwZGJCaFc0SjVubkpZN2s4UVQ2YkFiRFQ0YkxOOXJjS2Za?=
 =?utf-8?B?TWNkRktxbmlwNk5uWi90TE56b28rOFVLaEJ5K3lGakhwSTd4NVAxM1VkWnF0?=
 =?utf-8?B?RTd5SXl1cithMDlGUDA1QzgwMjhrM01MdXYySThmK3ZmRGhUdTdqVjFscUxZ?=
 =?utf-8?B?c1Q3dkF2UEUyV2NOMjZwTFV0VWtidXFmeGZTbDB0THc5VUZ6WmpnSFJ3djNH?=
 =?utf-8?B?NkNZcGhLR3JvRGZ3REd6eitHUVg4aFJESUV1a1JZNlJ0RytuUWdZbEhjeDBS?=
 =?utf-8?B?bDM2RWhNMXRRNkEwWC9qRHdZVXJwUFdrRXAyeUVCZDdFc091bVlRUS8rblBW?=
 =?utf-8?B?VzNZMUhaaDZLMmpySnk3N2lWSk5qZTYzcmtJODY2ZjZoNHJReHdvYWhBTnk0?=
 =?utf-8?B?NXdWQWJRTSszWGg0bE4xYUxIcHVGQmRQUTZ6RE1TMTM3MVJ4QjVUc2F5QVdI?=
 =?utf-8?B?NTE0R2wxSnZhbkZQakZmVHg3RVhhOTNBVENkRGJnN3Y2RTdxU3lCU3dmUDAx?=
 =?utf-8?B?N0syWDBsVnlSeGJsdEdFSmQ0bW9vMmlEeHRJRFZrNHBtSjBTOU0rb0c3Ully?=
 =?utf-8?B?TGNSZTZ0SDhIbHhDNGhqQnZEYkhQb2hBM0JpNHJ6MjFJY0NGWmZ3RjhiMkJa?=
 =?utf-8?B?bGFPa1crQTFYQ2krMldHUW1xekFmWmZ1bEZGNmQ0WmR2dG4zU244NGkzRDln?=
 =?utf-8?B?UG4ydFZ6SkRLWHoyQ0ZpeXlpcWdhS0JIWG42U01UOEV3d3dNV1g5a2RvMGZK?=
 =?utf-8?B?R3FXalNlaWpCMjl2RXNLQmkyZXlhQXQ5ZGhUYTZYKzQ0UHZFakpFa2Z5c2dm?=
 =?utf-8?B?MjF0bS9YZjJLelZ0UDdYSDE3Q3I2SFIrTHYwNGZ3TmYrVkhvQ2I5THZWb3pE?=
 =?utf-8?B?VGVZbk5pYXFxMlFqNWt2VDhPTlNXMmlxUmlqRHZ6MzlpeFlyd0svbXZoSUtC?=
 =?utf-8?B?Rmt3ZmkwRURwWnY2VENkQU5JdzZPRU9mSDVlZm1SbXBMazBaRlZoNlZnak5O?=
 =?utf-8?B?Ymg2TEtMUVpWYUVYeTJySVB6WTdTKzRQWFJXdFZRcEh2K3UrSFJzOXdmRnN5?=
 =?utf-8?B?TjlJMG1HamF0WTJOVW56YWNoRzZhRzhldmNSUFU0cUhrMFhxQ05rWTg0c1Vj?=
 =?utf-8?B?LzV5RlpsNEhPSm9oZzZQVzlMV2xtTFh2dDRIenU5eGJZNGJoZ2dWUHMxTzhx?=
 =?utf-8?B?b3NkajVGaGRXdFdjUEdSY0RrOXZHSkdnRXVybU91VFhvQW9zYmJESHNiY0Ju?=
 =?utf-8?B?dTVMRndSaHdyeGY2dEhDZTRxNTVoNldCRmhsWlpZRVkzbnNScnE4TXVTR1pj?=
 =?utf-8?B?UlVRcVI5VmMwNnVCb0pyQldvTTBnZ2MyMGNkenU1RVF1UkZGako3Q1FDc1g3?=
 =?utf-8?B?ZXUwVEpJb2ZzZXhBZy9UcGorN2hhc0VpQ09BLzJVR204SXhFYUc4c2dBaWxs?=
 =?utf-8?Q?YU2h75IJLB+k4isio/vJ8F/Bg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UI7fDg2IpM3z8W/bBDv3g0SeRS5+/0E7h9aHlXyTbjpdhlNC3xORkQcmCKbEoUq1yW5J0cuAgFnmKVhI4mtIu+uTNpMGO3hvHYvFFxgbgORFLdepk7Yg8s093nAA9N1UQiAp3PJwutg5R2mb4MB55Rj7hyGMs7d9NRfZ/C+m4MK1b+VzFngbQ4uSFYw3aSEw/LW+wvvYJwPFwjInQK9SAw79UPpK9UCjqY0x33TsoMWjhveexcyzX2kZjnuiNlKA+aeArMWOBpCd0HREiAE6cfSEIMXOJyv4bke9TaV5XIEXoNkWnBbO2gIuDu6FkthFjrlFP169kIfXyiC00H88w/xctijDtt1E08LmIPkcEbRIrYQtWlK5OBVBH1XD2MVR72XeTZMMUegKIo2sEm+kcZuy/goZZhp3ZkF/JG8R8UCVwHgHBu6rkTRtNrlQFGnWOI/DviUhKVSzmCatp10XJ8PfD6ynG/T/IdfNMEerztpOQ98xcRTxuaMyyjAT9tY2wtIe0gc4z495C128dC0E/32CfKeiBOntQm2naUEUFR5xvhZcwd4hxGakane8/3eSaQGIVk5xiRU+eViFpBszA+noqFcl7G2ym6fVRwj1TfM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf7e091-1e5e-45a2-afeb-08dd1ab848b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:21:35.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnvbuxOAo29+G6UQY+GavsSI1xSYjRBP1BqqPVRkX5wG8Tj0xnr3X7Yr1nTxHatXR5yuR2bRao0KhCFaed/EXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=960 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412120103
X-Proofpoint-ORIG-GUID: abq5xtPXghGambQgXhsB2Y3gR4mdnQgo
X-Proofpoint-GUID: abq5xtPXghGambQgXhsB2Y3gR4mdnQgo

On 11/12/2024 08:53, Christoph Hellwig wrote:
> +	if (is_append) {
> +		struct queue_limits *lim = bdev_limits(bio->bi_bdev);
> +
> +		sector_offset = bio_split_rw_at(bio, lim, &nr_segs,
> +			min(lim->max_zone_append_sectors << SECTOR_SHIFT,
> +			    *alloc_len));
> +		if (!sector_offset)

Should this be:

		if (sector_offset <= 0)

> +			return NULL;
> +	} else {
> +		if (bio->bi_iter.bi_size <= *alloc_len)
> +			return NULL;
> +		sector_offset = *alloc_len >> SECTOR_SHIFT;
> +	}
> +
> +	/* ensure the split ioend is still block size aligned */
> +	sector_offset = ALIGN_DOWN(sector_offset << SECTOR_SHIFT,
> +			i_blocksize(ioend->io_inode)) >> SECTOR_SHIFT;


