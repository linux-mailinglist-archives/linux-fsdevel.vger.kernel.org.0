Return-Path: <linux-fsdevel+bounces-77101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDgMKkjhjmluFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:31:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4F134101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A70E310A202
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2521A32C302;
	Fri, 13 Feb 2026 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aBdoxAgL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LMalVVGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C60D32B9AD;
	Fri, 13 Feb 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971372; cv=fail; b=KO3UgkMwAQC3myQGeZ73IuVte3wf1I7FXE29IRP5gARJmZJmq7VkFHsR1BqBuuxqM0SqxtYszGuIU0Q1Rscfb+t2D3N7KlWyiKX29H8CElVue5PLvxZ65Vtult+GRO9mWEPbutMNDLkj5MG8FQiqx+u5lGCf5Jt0BsmbpderYkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971372; c=relaxed/simple;
	bh=8/Qo0Or0RLzr1zKW+3NR/sViSbYOqZ40uaGSHxGgJoY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a1bERPptdqq62lRLNVZIaTRzD8X7co9pQHBcwC54gN4N+LgNVw3fiQpNjIbRtEuF+p0tkZqE2UHSFa6N2WCP4d5zMeE9oBaF0/trx3f58LeSg9yHrdhQNr7CbI56VCctr+hOJiMM294HiFW3R7GCXe5MwrhA8bR2NAFlrwzJCls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aBdoxAgL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LMalVVGx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D5AOW82001128;
	Fri, 13 Feb 2026 08:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f6gilADKyfhZ3K/hc2fgl/b4pGBf5CXndN7wTyoxjok=; b=
	aBdoxAgLt9kvZsMoFlqCEg6ALbO/CNWjvhM9BSgCalx7FQH8CXa+40dup10p9Xwt
	EqVRESb2O2bjJX4LWQUH7KXPchTKl9fzcrURpkLrEUJA/2BlsgECJTtth2iHr78V
	2xjDQ0XKamBXhoJFKGKURMdmHloPAFM7bydg3MozPvb20d/3uI0eTEWnY50gzBsv
	BazOCOAdQ+r9TYeSEr+jQrgoMSH5/J2Td/gxlNNIg4JWc6vzlUgtax0v+AmY7fMo
	XFBfg2icXV6WDDv6uGxiLkueoETKzMAszXbxfKJ4Kpx1e7DHGm+wuMUT/dZ1Ej+Q
	gneOHxKSmvdaysoXIZUw7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c88df4x4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 08:29:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61D85wfq008547;
	Fri, 13 Feb 2026 08:29:16 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c82389msv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 08:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6cmrbhQSyy8OdZ8hNEXL9sBF9Ah69VRKkt2cCcvp688GAIjKLEWx87vxsDi5GOT8QCkJB62VqIFqkimHM6b5tXdVtLGLVAb4ctviQcA6A4Q5oXugQisvFKGcL250Wr4P6Kwjsr3TKR+6xFEggqBrwYQVu4b5V6PPsrjhinR1XLGlcxW+uesPcLCmGpYUg4nIM9JgWyjH8mg3huW2Evq9g0tAouWaxAFsvm0DFKYxILjB+ihoDfEJdP0izNKFbLi07XYeIf6a8pIpHZPfceIw2uUET1vOJwNWJ1ofoyUHuv1VQRScfwAPMWpXVG7Nfqs7832ek7/vswSZhuVf8oxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6gilADKyfhZ3K/hc2fgl/b4pGBf5CXndN7wTyoxjok=;
 b=RXJ90M6LUW+UO8Isy6M7dBZ5d+BY3R2gVI4uVo8RcANYFlRtOaY8L62JXirxSQnAeAlllGf6ZwOB6qQcGf5a+wNQ67+WovNNeyKxhqDT8+1erpeylHEJrfQz1WcwDE30Z7ESeaX5ad/hqtHvouPMxAddpWWSebIiCtdueC8sluRYNG5AbrrRSqNUMv5KtjUziwNV0b8VQW+0ngYTpf0GEUJ5KLFarUz4egVpH06/PIaZ6mtKWBmSp9SUrXS4IDEzhXLqOeZz6j0bkNTclKlrNwLxBtpEIMbkzudfn+i4BPfBb0DyENE3qsI84KNHvgt/sNs6dfVAUlLKtaPx3OKjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6gilADKyfhZ3K/hc2fgl/b4pGBf5CXndN7wTyoxjok=;
 b=LMalVVGxUKc5gn+nkKRc8gU8aKYSuImLoRTqMFVSfFV4gfb7/tTm5oFzPgnqWl8UV/GJX8hQ3NRUM71hLH0jkMv0jhpMEmEf+wa1IJYwzsKIftahezijLG2nvI42tRjCvt6kskCnyklYUL16CTIyb151mMmemPFBveqf4dMx8iY=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by BL4PR10MB8231.namprd10.prod.outlook.com (2603:10b6:208:4e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 13 Feb
 2026 08:29:06 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 08:29:06 +0000
Message-ID: <3f466f3f-71c3-4581-98cb-08502712216c@oracle.com>
Date: Fri, 13 Feb 2026 00:29:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260212222403.3305141-1-dai.ngo@oracle.com>
Content-Language: en-US
In-Reply-To: <20260212222403.3305141-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:510:23d::19) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|BL4PR10MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8acd1b-a3f7-4b08-e453-08de6ad9f3c3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NHlKYzBGejFxV1N4QUJvVFVjNXJjdDVVRUVtWG9KeHNBZ2l1ZGp0UXU4VlBT?=
 =?utf-8?B?TGwzdFdVL1VsRGlqSDdxbVViNk9qaHZRbEU0MFQxOFlIN0VDZjV0cjFBaHEx?=
 =?utf-8?B?Ukh0amxXUEtYZVU4RlNNd0dvdGRYQy9Xcmw4VU1SZlpjcVhETEU3TmpaVlpN?=
 =?utf-8?B?bkRvTk5wSUY5RU1Ha010SFY4VkJkL3VkMW9iaFdBZkZ6aFRRSklqcVVoT1BR?=
 =?utf-8?B?UTJKRS9qK0lWUUtrWERsKzB3VGF0d3YrOFN6OGlrcEdIcGpVTmsxSEJiRzZi?=
 =?utf-8?B?VkZUeVYxLzVnQkIvNnRadFBjUERIekNQOVJXOHg4dDJLUGZyQ0RVaUxtUVRm?=
 =?utf-8?B?MHF1UDk1eUVqa2Z3Q1hMTUpVaUx0UTFZSnYyTW5ITzJNcWkxMDBoT2s3SDFj?=
 =?utf-8?B?TkY1dnRqd3FIQnBLTGhqOG1hOVp6cUkyWmxoaW5LVjR4V1oraG10NTNXUjRm?=
 =?utf-8?B?dms4ZHBnWGlQTzRaNlNZbFdHdFdnMjFTejNXV1ZUcDFHWmxxWHNKY01tREM1?=
 =?utf-8?B?Y3I5bHJmbDlsdGlBbS9KU1p0akVPOXBDRUNlcmxQRHpCLzV0ZUZUK0tXQVhu?=
 =?utf-8?B?OWdiaWN0Y3lIMXRCZW9QczR2N0Rud0l2QVZTeEd0MDBUdEJyQkhMa0cwOG5i?=
 =?utf-8?B?bjhIWnhuNmVqL0p6WVYwV2VNaWpGMkoySEM3OXVoREVPb3VzQlVJQVd3NjJS?=
 =?utf-8?B?VUcydTZFTE1MTTdJYlNhYVcwVUxWTXdqYklncmFCcUhIN0tlKzlwSjZTZVl1?=
 =?utf-8?B?TUkwb29MbkV1UFBFUU1lQlZLc2pYc25Nc0tIbDBMb3dOeDhNL2d6SkdYRW41?=
 =?utf-8?B?SlpWYTJYY3NHTEtTbDFqT2toMVZMQXlrMmpLdVdrQWNyRW81VXBWMGhzODNS?=
 =?utf-8?B?c2w1VHhuRFB6M3lUNnJTUVcyTVFCNjYyaWQxM3UzYWFDQjVBL2tqM1J1T3RS?=
 =?utf-8?B?dlJiNkFOZWxEWUJsVXU1UmxaakM0UUhYay9aZTVTNkEva0RIdDNmdHdBZzdZ?=
 =?utf-8?B?aUtqZ1pLbzJ3QmFwZVNRbW56SVI3ZmxXbU0yZ2VIRjNudUc5RVZkQnpNczR4?=
 =?utf-8?B?VFBXRUM3cWtXSEtQYlFOU2VjdHgzeVRFY2lXTTV2SnRpTU5XNVVYRjVxWWg1?=
 =?utf-8?B?aGlYaTdjNnBydEFzSlF3U0VsYWNhTC80azdodnBUZHFQeWl2MjVpUkhBaEdn?=
 =?utf-8?B?YWdabHJEQXdKTGR5Wk9pWWJycUdIWGd4K0EwVWh2RSs5QWZnZWtkTXZLOGtR?=
 =?utf-8?B?NUVXajNoVjhJaFJPOTgvWXdkR1N4MFZJUGNheHlkcUNWWkdWVHpqQ201Qmd6?=
 =?utf-8?B?bGhtZTdlNkszMUtyZWNkZ3VMMXYwZXR6d29RdVZDTXpCZ3lsMXB5dnp5aFdl?=
 =?utf-8?B?eFR5VFl5TEc5NVZaaEJWanVnTnlzQ0VIblVQNjBuZ3F4Q0RSOHdrTEdNRlB2?=
 =?utf-8?B?U25pbXY4bmtXbTA2NzBNMXd4SEN5WWxnRFp3Zlo3c0N0N3ZWd216cHRML0dm?=
 =?utf-8?B?cnFtUTJiRkZyOTZzTmtzTnE5TWZTWWpndzB4NlljK0FLTE5CaFZZdFh4NTlM?=
 =?utf-8?B?NnJrWmJMNHgyMk52djRvb0hxMHZva2t2K254aVR3dHpVTVA3bjd5SzhWakJD?=
 =?utf-8?B?K2ZKN1c1eUNjTXpZZHR2dElXdkgvSzVtNHdXQ1lpR05PQkcxOHJPc2d3cFI0?=
 =?utf-8?B?a0U5c013YzNTV2JQQTdyVU5HdTJPb0hvRWVQUGZZUzgvOVhLZkJsNlljcUZW?=
 =?utf-8?B?cVZBcGg4M1BiL1MzV0ZROUllK0FDb2JSU0ErMFhDTXU4dmVZelVwL0hoZ0V5?=
 =?utf-8?B?WGh6SFZXVnRwRWZpWXliQ3VWMVV1NUMxRXBuOWIyQzVBekF5Rk9jM05tWTV2?=
 =?utf-8?B?akx4NzVES0dtODA4THl5SHZxQlVxc0h0WEtNL1ptZnJzRnBlcU8vRkxMNExD?=
 =?utf-8?B?cjdrL3hZSzBVWENFRDY3SGJYT1NRbDFuYXBTNm9jU2NnQlREb1JQVkxndDhC?=
 =?utf-8?B?Ump3R3UyRlRFWkdPaFQ5S0pJcldnNFh3RWtERFJINDFxbXBDeXZmdVd5anhn?=
 =?utf-8?B?MXcycFJNa1JvcVNUZEduS3JPUVpsYXowQ1ZjMWt3dUdwb0FOOGdsQzlXcExu?=
 =?utf-8?B?UlVjOGhDVkx1YXljdkpoNVE2dDZPdURDRXR0WnRuZ3BWY3VuRzM1elhEOVA1?=
 =?utf-8?B?Q0E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y3o5UGpSUHhjbXVNc3liUFJvREpMOEdzOS9JNkxienk3TDdTREJPYURJNXJM?=
 =?utf-8?B?UHJCdUlCV2VhRDF5QU1RQ2t2T0d0dzB4VVF0SHgvYnFjb3N5eldzbW1QTW9F?=
 =?utf-8?B?NER5UTEwRXBqUzRDbFNmWnl4TElKUm9QMURPTWh3dlNaSlRyNTV5M2ppOEJv?=
 =?utf-8?B?THVMMFNTaG90ZG5YVnpQbDZVR0lXcy9vQk4yRGxQVlV3ditsTTJkV2g0ejEw?=
 =?utf-8?B?NmxiMUo1NndYek5vRFpXc3ZOQUZoVW85QUJDZnVGOXFvcXRwMTc1bGF5NzRp?=
 =?utf-8?B?c1JHTE9WakdjaWtndWJ6eHR1SHFxUGtmOGFoM25zcXlzZWlEN1cxRDlnL29H?=
 =?utf-8?B?YVowc0RjS2lRTGJRV0NKYjAwczR6SVBzNm1hUHhzNHlVMjFYVjBNK1MxbGlF?=
 =?utf-8?B?dWNYaElVSkFmWTAwcWFsSzMwSXRDL0h2eXNjY3drRCtxT21mbG15ZE1DUjFX?=
 =?utf-8?B?dkQ0S1JWa0krdTQrNm9UaG1JUVNoUE5nV2RDY3kvclNUNjNDMGxkUlJ1bG5o?=
 =?utf-8?B?OUxKZHBPQUhUaDErOGMrZWVURGQvSWZqc2tacGxkeFd4OXg5RGJsd0hCSU91?=
 =?utf-8?B?N0g4SGlnYldzMWxtKzdWeklCbnFzNUNkWmpZa21jNVo1ZGd5Q2NlZFJWWHE0?=
 =?utf-8?B?eExQMjhTZGNFZWpqWG5FWkFJTEVqaHFxcE9BWll3TE9HcnFwa0pQNGhuejln?=
 =?utf-8?B?MEUzZXloeTN5bTl4aUhvYnNZUm0zUU16UTYrdXQ3elRrUllMRGRrOXY0WE9l?=
 =?utf-8?B?WnpmNkhacjlCOVVBTlg4VVlBV1RINGZJd2dZOXFnRVhTTFd3NUZHSmhDaGNl?=
 =?utf-8?B?L1AyaytWRThiQWVWN1ExcE9XamtzZUdOajZVMVQyUHQzQ3p1NC9yZHYvMEsv?=
 =?utf-8?B?QUU0RVVmMXkvQi9lMjNKRzhCQVNYV012VnBEWDNpaEM3enN6L0o4VWxlZWxM?=
 =?utf-8?B?ekI5c3N5cFVmYUlrQUVKenR1TklUZityb2gyWWExM2dOZDZGQ1h3Uk82aXVZ?=
 =?utf-8?B?TS9HajNkc1crdlNaTXZjTEZXR1laN0pheTFiL1BFVjFWODYrRG01dWtTWWxz?=
 =?utf-8?B?TUpsT0NwVmpnaUl6MzhUQW52KytyNEV6WkkyTUdhSkhEcTA4b3h2NlpqQmdF?=
 =?utf-8?B?VWVJU05xL3FPVHM0eDZSVk5rczhKb2VxZHVVUkFHbkdiRFNMN0xOaU10MHZV?=
 =?utf-8?B?ZEhFVUlTeVREY0diRmhsWU9ES0ZyMHdqbkZSaGJkM0JlM3N0ZEUwQVB6bXBX?=
 =?utf-8?B?QXdrZEh0ZkFpaTZ5REUrdHhHQVpEcEdKZXp0UThjUy9Ta2dkbW91YTNxeldj?=
 =?utf-8?B?blFjSXNEc2VnMCtnbWlKemdiQnZkREhpcHRCamZIUVpSaXJrMjVvYXNNNFIv?=
 =?utf-8?B?dzJwWFZmZ1JmTFczSDlid3pwYTlTVGZwM25hYmpqT3JWZXNtKzVFR04zdmhY?=
 =?utf-8?B?WkJpeHdKRUtHc2J2dm83TzQ3ejNXdzR4UFdxblFaYVJXbXFRQ1Y5d000YmFZ?=
 =?utf-8?B?WnNHOTMwSnp6NXhjck5VTGwxY09RZjM4UVlZQVRBZUpkZzVhNEc5L0t2ZDBl?=
 =?utf-8?B?VDcrM1RDR1hQR0tyT3AwV2hsYXlsbm1WRVNScWlBNG90N21oQzdyRDFZZXZu?=
 =?utf-8?B?MkQzb0h5WVVYVm00UnJ1MmhoYjZzQ21JVmtrRlFwTDVRRm0wcmxxc3pJcVZX?=
 =?utf-8?B?Z1p5ME82bXNKaEZqYlc0TmY1RmtRcTVaSHV3andQZEVFakJGd1Y5UlkvY0R0?=
 =?utf-8?B?Mk1QRFJ5dFBXVHo3RXFndnA5Q0VsQktVKzJucEZjNTR5YTAzNkd2SG1TWG5X?=
 =?utf-8?B?aG02Sk5JUlJ5Z3JGWXNWV05xd05qYUNXYy9oQ1A2ZE1Hckthb0ZIMmlQNmR2?=
 =?utf-8?B?OWFuVGc2MWN0Nm1kaE9RME0zeHRtRGcvdjdpeDFkcUllMy9NK3orZmhWNGZ5?=
 =?utf-8?B?MjlMUHdndHhlNjF1bDRuMHZobm8rVVdHNDdza0owZmQ1YVkzakI4VmY0ZFYr?=
 =?utf-8?B?ajIzL2p4aFVMSTJYZDRYbXQrempSeTAyaHE1UE9FcUUydVZFanZOMUp6YkxC?=
 =?utf-8?B?Y2FadXlMTG04Q0YveTRkUHNyU1lXYVVMN3ByQzIzYW1nYml0b2RKa2xjdkdJ?=
 =?utf-8?B?a3luYzZMQjM4MmNWTEowN2Y5TXlrbWYrKzJ6RmVxODZJN1JHNXVXOVIwYlN1?=
 =?utf-8?B?dGpzbmt4RVhlR3l6aGJDalYrMStGeDEzTS9pc0xweGVXK1hhaHpUeXpJemZE?=
 =?utf-8?B?SFd5UUxseWxrazczZzhtWGVGeVowQWlybWRuK21kandJcjBoeW15RTNnL3hr?=
 =?utf-8?B?Q2ZyOHdrY3lYV2N0MjZkVlgwSnZyRWR1UXIzYnpNaWJJS3NyTGRoQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tzVOOfjezpF/v99ykIAJN7DoxRJky1BAPKOj408+1XnD2dfuL5NjdGRIqTozTVCRYwlmIt1zRuq/Xpt8CawWmWqxK1rXHzi4ivlJ9V+3qKQ/ZAn2+Fj9/NZZaTOXxMOxb8aS/EPt4Sea0F4C7DpPTxOSgcWe6Mk12mr2Dzyn0JdpDZu51DxY+d74d0antkpJLNs+DweocIiOVW1NTSMlDLaW3H2dNoQk+5rOsH/HJlr59UVc55KmRa2kBhopOUlnjFEJZ9yhtLPA0X2LD6Xt6ueG1zSKAd1klVOP6lnatG21wZQSgsh5cwLSb7TdqDxwyMqAQ6T6QJtvFFB9mucQaIEpLEuggpnqfruHFH4XskyLSvt1zyQB7Va9zKImMwDjM3adO18Mg+mCKtUTOsb/iYjwEfsTfPcfwsH6EynFqeOOXAjaZurLzMenbXemh6rl1UkjVt2n4oBLtlJe7pKl7VWi48Fz/2BAIa70LKkfQogI8GYLauEMUDsZVveesx0bSyxs1PiZfeSf/DKZP29Vz6Rp7AzJfy+FjnO7sFxFNUdSHRFB68avHvrvhgd74TjWpMRNWtpJJanxqDsilV0FWH5Scie+27PDe+bvUZrCSTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8acd1b-a3f7-4b08-e453-08de6ad9f3c3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:29:06.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6FYn8WWIgl/YWVoklj76sqzNCmyNkrV5xWxZUWC33nQgRWq8kpL24ypu7ewwdz6CdBD2Wp7L1cvVyrdNF9vtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR10MB8231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602130064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA2NCBTYWx0ZWRfX7xAHo8JlZF/l
 DUynglwyU/AQpMfLIinrWgez5f62HLT6V4PC0/uFK+hzAcrGgYPcvSYlFTIbcJUoZk8HPssZekN
 Iucypw4bJxKb113dUZCKpah+w8EZNNnY4jbTnukGOSmtX2qlDrdDb2kSu9g81y3Jx0ZHn8y7Yvt
 LWmCDPK83kJ/okJ2lFIbU56Yb6y/E8fjTnQgOaALy/yb2u7gbLyYOXewmIIqfQWFJPwNzLTZlCC
 0P8Vw+H3G84H/kEIegdgGkO9Hdc6a5rUyf6+4vMfJ7g2CJwhOnUJLF4eBlh+d+ksOiB2Au5caHU
 TuL2b9O9marH7fudFZFVzwtCiT8qXcuS3cXXZbx0YQ1RZPWTzUuY4VasQ5nFNuwQiBvxzROfW1/
 QUH7KPhyv6K4O1lks2TE75tb4L3cEhPrFUlFHle2jFnHaTYqJqYj2n74Hy3Gjl56KlkaQV8K4n3
 q59sj69hseE1hN3lhoA==
X-Proofpoint-GUID: I3DSdZRZD1HdMD2_DbB7r8ufeSKD1Ilw
X-Authority-Analysis: v=2.4 cv=AqbjHe9P c=1 sm=1 tr=0 ts=698ee0dd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=u_AxpXIPR0vPo6yXoSsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: I3DSdZRZD1HdMD2_DbB7r8ufeSKD1Ilw
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77101-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 44C4F134101
X-Rspamd-Action: no action

Please ignore this version. I'll send out a replacement.

-Dai

On 2/12/26 2:23 PM, Dai Ngo wrote:
> When a layout conflict triggers a recall, enforcing a timeout is
> necessary to prevent excessive nfsd threads from being blocked in
> __break_lease ensuring the server continues servicing incoming
> requests efficiently.
>
> This patch introduces a new function to lease_manager_operations:
>
> lm_breaker_timedout: Invoked when a lease recall times out and is
> about to be disposed of. This function enables the lease manager
> to inform the caller whether the file_lease should remain on the
> flc_list or be disposed of.
>
> For the NFSD lease manager, this function now handles layout recall
> timeouts. If the layout type supports fencing and the client has not
> been fenced, a fence operation is triggered to prevent the client
> from accessing the block device.
>
> While the fencing operation is in progress, the conflicting file_lease
> remains on the flc_list until fencing is complete. This guarantees
> that no other clients can access the file, and the client with
> exclusive access is properly blocked before disposal.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>   .../admin-guide/nfs/pnfs-block-server.rst     |  29 ++++
>   .../admin-guide/nfs/pnfs-scsi-server.rst      |  30 ++++
>   Documentation/filesystems/locking.rst         |   2 +
>   fs/locks.c                                    |  24 ++-
>   fs/nfsd/blocklayout.c                         |  42 +++++-
>   fs/nfsd/nfs4layouts.c                         | 139 +++++++++++++++++-
>   fs/nfsd/nfs4state.c                           |   2 +
>   fs/nfsd/pnfs.h                                |   2 +-
>   fs/nfsd/state.h                               |   9 ++
>   include/linux/filelock.h                      |   1 +
>   10 files changed, 264 insertions(+), 16 deletions(-)
>
>
> v2:
>      . Update Subject line to include fencing operation.
>      . Allow conflicting lease to remain on flc_list until fencing
>        is complete.
>      . Use system worker to perform fencing operation asynchronously.
>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>        valid before starting the fencing operation, nfs4_stid.sc_count
>        is released after fencing operation is complete.
>      . Rework nfsd4_scsi_fence_client to:
>           . wait until fencing to complete before exiting.
>           . wait until fencing in progress to complete before
>             checking the NFSD_MDS_PR_FENCED flag.
>      . Remove lm_need_to_retry from lease_manager_operations.
> v3:
>      . correct locking requirement in locking.rst.
>      . add max retry count to fencing operation.
>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>      . remove special-casing of FL_LAYOUT in lease_modify.
>      . remove lease_want_dispose.
>      . move lm_breaker_timedout call to time_out_leases.
> v4:
>      . only increment ls_fence_retry_cnt after successfully
>        schedule new work in nfsd4_layout_lm_breaker_timedout.
> v5:
>      . take reference count on layout stateid before starting
>        fence worker.
>      . restore comments in nfsd4_scsi_fence_client and the
>        code that check for specific errors.
>      . cancel fence worker before freeing layout stateid.
>      . increase fence retry from 5 to 20.
>
> NOTE:
>      I experimented with having the fence worker handle lease
>      disposal after fencing the client. However, this requires
>      the lease code to export the lease_dispose_list function,
>      and for the fence worker to acquire the flc_lock in order
>      to perform the disposal. This approach adds unnecessary
>      complexity and reduces code clarity, as it exposes internal
>      lease code details to the nfsd worker, which should not
>      be the case.
>
>      Instead, the lm_breaker_timedout operation should simply
>      notify the lease code about how to handle a lease that
>      times out during a lease break, rather than directly
>      manipulating the lease list.
> v6:
>     . unlock the lease as soon as the fencing is done, so that
>       tasks waiting on it can proceed.
>
> v7:
>     . Change to retry fencing on error forever by default.
>     . add module parameter option to allow the admim to specify
>       the maximun number of retries before giving up.
>
> v8:
>     . reinitialize 'remove' inside the loop.
>     . remove knob to stop fence worker from retrying forever.
>     . use exponential back off when retrying fence operation.
>     . Fix nits.
>
> v9:
>     . limit fence worker max delay to 3 minutes.
>     . fix fence worker's delay argument from seconds to jiffies.
>     . move INIT_DELAYED_WORK to nfsd4_alloc_layout_stateid().
>     . remove ls_fence_inprogress, use delayed_work_pending() instead.
>
> v10:
>     . fix initial delay of fence worker from 1 jiffies to 1 second.
>
> v11:
>     . add recover procedure in pnfs-block-server.rst and
>       nfs-scsi-server.rst.
>     . include unique client identifier in fence log message.
>     . limit logging of message when fencing fail to once.
>     . add logging of successful fencing operation.
>     . handle expired of fl_break_time when retry in__break_time.
>     . removed unused 'dispose' list in nfsd4_layout_fence_worker.
>     . simplify compute for ls_fence_delay in nfsd4_layout_fence_worker.
>     . add description for MAX_FENCE_DELAY.
>
> diff --git a/Documentation/admin-guide/nfs/pnfs-block-server.rst b/Documentation/admin-guide/nfs/pnfs-block-server.rst
> index 20fe9f5117fe..bc8d4ce10c10 100644
> --- a/Documentation/admin-guide/nfs/pnfs-block-server.rst
> +++ b/Documentation/admin-guide/nfs/pnfs-block-server.rst
> @@ -40,3 +40,32 @@ how to translate the device into a serial number from SCSI EVPD 0x80::
>   
>   	echo "fencing client ${CLIENT} serial ${EVPD}" >> /var/log/pnfsd-fence.log
>   	EOF
> +
> +If the nfsd server needs to fence a non-responding client and the
> +fencing operation fails, the server logs a warning message in the
> +system log with the following format:
> +
> +    FENCE failed client[IP_address] clid[#n] device[dev_t]
> +
> +    Where:
> +
> +    IP_address: refers to the IP address of the affected client.
> +    clid[#n]: indicates the unique client identifier.
> +    device[dev_t]: specifies the device related to the fencing attempt.
> +
> +The server will repeatedly retry the operation indefinitely. During
> +this time, access to the affected file is restricted for all other
> +clients. This is to prevent potential data corruption if multiple
> +clients access the same file simultaneously.
> +
> +To restore access to the affected file for other clients, the admin
> +needs to take the following actions:
> +
> +    . shutdown or power off the client being fenced.
> +    . manually expire the client to release all its state on the server:
> +
> +      echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
> +
> +      Where:
> +
> +      clid: is the unique client identifier displayed in the system log.
> diff --git a/Documentation/admin-guide/nfs/pnfs-scsi-server.rst b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
> index b2eec2288329..b691a03e3d33 100644
> --- a/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
> +++ b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
> @@ -22,3 +22,33 @@ option and the underlying SCSI device support persistent reservations.
>   On the client make sure the kernel has the CONFIG_PNFS_BLOCK option
>   enabled, and the file system is mounted using the NFSv4.1 protocol
>   version (mount -o vers=4.1).
> +
> +If the nfsd server needs to fence a non-responding client and the
> +fencing operation fails, the server logs a warning message in the
> +system log with the following format:
> +
> +    FENCE failed client[IP_address] clid[#n] device[dev_t]
> +
> +    Where:
> +
> +    IP_address: refers to the IP address of the affected client.
> +    clid[#n]: indicates the unique client identifier.
> +    device[dev_t]: specifies the device related to the fencing attempt.
> +
> +The server will repeatedly retry the operation indefinitely. During
> +this time, access to the affected file is restricted for all other
> +clients. This is to prevent potential data corruption if multiple
> +clients access the same file simultaneously.
> +
> +To restore access to the affected file for other clients, the admin
> +needs to take the following actions:
> +
> +    . shutdown or power off the client being fenced.
> +    . manually expire the client to release all its state on the server:
> +
> +      echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
> +
> +      Where:
> +
> +      clid: is the unique client identifier displayed in the system log.
> +
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 04c7691e50e0..79bee9ae8bc3 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -403,6 +403,7 @@ prototypes::
>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>           bool (*lm_lock_expirable)(struct file_lock *);
>           void (*lm_expire_lock)(void);
> +        bool (*lm_breaker_timedout)(struct file_lease *);
>   
>   locking rules:
>   
> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>   lm_lock_expirable	yes		no			no
>   lm_expire_lock		no		no			yes
>   lm_open_conflict	yes		no			no
> +lm_breaker_timedout     yes             no                      no
>   ======================	=============	=================	=========
>   
>   buffer_head
> diff --git a/fs/locks.c b/fs/locks.c
> index 46f229f740c8..42ae59eda068 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>   {
>   	struct file_lock_context *ctx = inode->i_flctx;
>   	struct file_lease *fl, *tmp;
> +	bool remove;
>   
>   	lockdep_assert_held(&ctx->flc_lock);
>   
> @@ -1531,8 +1532,19 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>   		trace_time_out_leases(inode, fl);
>   		if (past_time(fl->fl_downgrade_time))
>   			lease_modify(fl, F_RDLCK, dispose);
> -		if (past_time(fl->fl_break_time))
> -			lease_modify(fl, F_UNLCK, dispose);
> +
> +		remove = true;
> +		if (past_time(fl->fl_break_time)) {
> +			/*
> +			 * Consult the lease manager when a lease break times
> +			 * out to determine whether the lease should be disposed
> +			 * of.
> +			 */
> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
> +			if (remove)
> +				lease_modify(fl, F_UNLCK, dispose);
> +		}
>   	}
>   }
>   
> @@ -1660,8 +1672,12 @@ int __break_lease(struct inode *inode, unsigned int flags)
>   restart:
>   	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>   	break_time = fl->fl_break_time;
> -	if (break_time != 0)
> -		break_time -= jiffies;
> +	if (break_time != 0) {
> +		if (time_after(jiffies, break_time))
> +			break_time = jiffies + lease_break_time * HZ;
> +		else
> +			break_time -= jiffies;
> +	}
>   	if (break_time == 0)
>   		break_time++;
>   	locks_insert_block(&fl->c, &new_fl->c, leases_conflict);
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 7ba9e2dd0875..5c52a90a0c7f 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -297,6 +297,7 @@ static inline int nfsd4_scsi_fence_insert(struct nfs4_client *clp,
>   		ret = 0;
>   	}
>   	xa_unlock(xa);
> +	clp->cl_fence_retry_warn = false;
>   	return ret;
>   }
>   
> @@ -443,15 +444,33 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>   }
>   
> -static void
> +/*
> + * Perform the fence operation to prevent the client from accessing the
> + * block device. If a fence operation is already in progress, wait for
> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
> + * update the layout stateid by setting the ls_fenced flag to indicate
> + * that the client has been fenced.
> + *
> + * The cl_fence_mutex ensures that the fence operation has been fully
> + * completed, rather than just in progress, when returning from this
> + * function.
> + *
> + * Return true if client was fenced otherwise return false.
> + */
> +static bool
>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>   {
>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>   	int status;
> +	bool ret;
>   
> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
> -		return;
> +	mutex_lock(&clp->cl_fence_mutex);
> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
> +		mutex_unlock(&clp->cl_fence_mutex);
> +		return true;
> +	}
>   
>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>   			nfsd4_scsi_pr_key(clp),
> @@ -470,13 +489,22 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>   	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>   	 * retry loop.
>   	 */
> -	if (status < 0 ||
> -	    status == PR_STS_PATH_FAILED ||
> -	    status == PR_STS_PATH_FAST_FAILED ||
> -	    status == PR_STS_RETRY_PATH_FAILURE)
> +	switch (status) {
> +	case 0:
> +	case PR_STS_IOERR:
> +	case PR_STS_RESERVATION_CONFLICT:
> +		ret = true;
> +		break;
> +	default:
> +		/* retry-able and other errors */
> +		ret = false;
>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
> +		break;
> +	}
> +	mutex_unlock(&clp->cl_fence_mutex);
>   
>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
> +	return ret;
>   }
>   
>   const struct nfsd4_layout_ops scsi_layout_ops = {
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index ad7af8cfcf1f..e21baa3cb42b 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -27,6 +27,8 @@ static struct kmem_cache *nfs4_layout_stateid_cache;
>   static const struct nfsd4_callback_ops nfsd4_cb_layout_ops;
>   static const struct lease_manager_operations nfsd4_layouts_lm_ops;
>   
> +static void nfsd4_layout_fence_worker(struct work_struct *work);
> +
>   const struct nfsd4_layout_ops *nfsd4_layout_ops[LAYOUT_TYPE_MAX] =  {
>   #ifdef CONFIG_NFSD_FLEXFILELAYOUT
>   	[LAYOUT_FLEX_FILES]	= &ff_layout_ops,
> @@ -177,6 +179,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>   
>   	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
>   
> +	spin_lock(&ls->ls_lock);
> +	if (delayed_work_pending(&ls->ls_fence_work)) {
> +		spin_unlock(&ls->ls_lock);
> +		cancel_delayed_work_sync(&ls->ls_fence_work);
> +	} else
> +		spin_unlock(&ls->ls_lock);
> +
>   	spin_lock(&clp->cl_lock);
>   	list_del_init(&ls->ls_perclnt);
>   	spin_unlock(&clp->cl_lock);
> @@ -271,6 +280,10 @@ nfsd4_alloc_layout_stateid(struct nfsd4_compound_state *cstate,
>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>   	spin_unlock(&fp->fi_lock);
>   
> +	ls->ls_fenced = false;
> +	ls->ls_fence_delay = 0;
> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
> +
>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>   	return ls;
>   }
> @@ -747,11 +760,9 @@ static bool
>   nfsd4_layout_lm_break(struct file_lease *fl)
>   {
>   	/*
> -	 * We don't want the locks code to timeout the lease for us;
> -	 * we'll remove it ourself if a layout isn't returned
> -	 * in time:
> +	 * Enforce break lease timeout to prevent NFSD
> +	 * thread from hanging in __break_lease.
>   	 */
> -	fl->fl_break_time = 0;
>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>   	return false;
>   }
> @@ -782,10 +793,130 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>   	return 0;
>   }
>   
> +static void
> +nfsd4_layout_fence_worker(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct nfs4_layout_stateid *ls = container_of(dwork,
> +			struct nfs4_layout_stateid, ls_fence_work);
> +	struct nfsd_file *nf;
> +	struct block_device *bdev;
> +	struct nfs4_client *clp;
> +	struct nfsd_net *nn;
> +	LIST_HEAD(dispose);
> +
> +	spin_lock(&ls->ls_lock);
> +	if (list_empty(&ls->ls_layouts)) {
> +		spin_unlock(&ls->ls_lock);
> +dispose:
> +		/* unlock the lease so that tasks waiting on it can proceed */
> +		nfsd4_close_layout(ls);
> +
> +		ls->ls_fenced = true;
> +		nfs4_put_stid(&ls->ls_stid);
> +		return;
> +	}
> +	spin_unlock(&ls->ls_lock);
> +
> +	rcu_read_lock();
> +	nf = nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
> +	if (!nf)
> +		goto dispose;
> +
> +	clp = ls->ls_stid.sc_client;
> +	net_generic(clp->net, nfsd_net_id);
> +	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
> +		/* fenced ok */
> +		nfsd_file_put(nf);
> +		pr_warn("%s: FENCED client[%pISpc] clid[%d] to device[0x%x]\n",
> +			__func__, (struct sockaddr *)&clp->cl_addr,
> +			clp->cl_clientid.cl_id - nn->clientid_base,
> +			bdev->bd_dev);
> +		goto dispose;
> +	}
> +	/* fence failed */
> +	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
> +	nfsd_file_put(nf);
> +
> +	if (!clp->cl_fence_retry_warn) {
> +		pr_warn("%s: FENCE failed client[%pISpc] clid[%d] device[0x%x]\n",
> +			__func__, (struct sockaddr *)&clp->cl_addr,
> +			clp->cl_clientid.cl_id - nn->clientid_base,
> +			bdev->bd_dev);
> +		clp->cl_fence_retry_warn = true;
> +	}
> +	/*
> +	 * The fence worker retries the fencing operation indefinitely to
> +	 * prevent data corruption. The admin needs to take the following
> +	 * actions to restore access to the file for other clients:
> +	 *
> +	 *  . shutdown or power off the client being fenced.
> +	 *  . manually expire the client to release all its state on the server;
> +	 *    echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
> +	 *
> +	 *    The value of 'clid' is displayed in the warning message above.
> +	 */
> +	if (!ls->ls_fence_delay)
> +		ls->ls_fence_delay = HZ;
> +	else if (ls->ls_fence_delay < MAX_FENCE_DELAY)
> +		ls->ls_fence_delay <<= 1;
> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_delay);
> +}
> +
> +/**
> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
> + * @fl: file to check
> + *
> + * If the layout type supports a fence operation, schedule a worker to
> + * fence the client from accessing the block device.
> + *
> + * This function runs under the protection of the spin_lock flc_lock.
> + * At this time, the file_lease associated with the layout stateid is
> + * on the flc_list. A reference count is incremented on the layout
> + * stateid to prevent it from being freed while the fence worker is
> + * executing. Once the fence worker finishes its operation, it releases
> + * this reference.
> + *
> + * The fence worker continues to run until either the client has been
> + * fenced or the layout becomes invalid. The layout can become invalid
> + * as a result of a LAYOUTRETURN or when the CB_LAYOUT recall callback
> + * has completed.
> + *
> + * Return true if the file_lease should be disposed of by the caller;
> + * otherwise, return false.
> + */
> +static bool
> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
> +{
> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
> +
> +	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
> +			ls->ls_fenced)
> +		return true;
> +	if (delayed_work_pending(&ls->ls_fence_work))
> +		return false;
> +	/*
> +	 * Make sure layout has not been returned yet before
> +	 * taking a reference count on the layout stateid.
> +	 */
> +	spin_lock(&ls->ls_lock);
> +	if (list_empty(&ls->ls_layouts)) {
> +		spin_unlock(&ls->ls_lock);
> +		return true;
> +	}
> +	refcount_inc(&ls->ls_stid.sc_count);
> +	spin_unlock(&ls->ls_lock);
> +
> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
> +	return false;
> +}
> +
>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>   	.lm_break		= nfsd4_layout_lm_break,
>   	.lm_change		= nfsd4_layout_lm_change,
>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>   };
>   
>   int
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 98da72fc6067..ec9c430813f2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2387,6 +2387,8 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
>   #endif
>   #ifdef CONFIG_NFSD_SCSILAYOUT
>   	xa_init(&clp->cl_dev_fences);
> +	mutex_init(&clp->cl_fence_mutex);
> +	clp->cl_fence_retry_warn = false;
>   #endif
>   	INIT_LIST_HEAD(&clp->async_copies);
>   	spin_lock_init(&clp->async_lock);
> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
> index db9af780438b..3a2f9e240e85 100644
> --- a/fs/nfsd/pnfs.h
> +++ b/fs/nfsd/pnfs.h
> @@ -38,7 +38,7 @@ struct nfsd4_layout_ops {
>   			struct svc_rqst *rqstp,
>   			struct nfsd4_layoutcommit *lcp);
>   
> -	void (*fence_client)(struct nfs4_layout_stateid *ls,
> +	bool (*fence_client)(struct nfs4_layout_stateid *ls,
>   			     struct nfsd_file *file);
>   };
>   
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 713f55ef6554..a607fe62671a 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -529,6 +529,8 @@ struct nfs4_client {
>   	time64_t		cl_ra_time;
>   #ifdef CONFIG_NFSD_SCSILAYOUT
>   	struct xarray		cl_dev_fences;
> +	struct mutex		cl_fence_mutex;
> +	bool			cl_fence_retry_warn;
>   #endif
>   };
>   
> @@ -738,8 +740,15 @@ struct nfs4_layout_stateid {
>   	stateid_t			ls_recall_sid;
>   	bool				ls_recalled;
>   	struct mutex			ls_mutex;
> +
> +	struct delayed_work		ls_fence_work;
> +	unsigned int			ls_fence_delay;
> +	bool				ls_fenced;
>   };
>   
> +/* Cap exponential backoff between fence retries at 3 minutes */
> +#define	MAX_FENCE_DELAY		(180 * HZ)
> +
>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>   {
>   	return container_of(s, struct nfs4_layout_stateid, ls_stid);
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index 2f5e5588ee07..13b9c9f04589 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>   	void (*lm_setup)(struct file_lease *, void **);
>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>   	int (*lm_open_conflict)(struct file *, int);
> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>   };
>   
>   struct lock_manager {

