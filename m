Return-Path: <linux-fsdevel+bounces-23470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AF692CED9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D28283C0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804B18FA33;
	Wed, 10 Jul 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bA1aUZPn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wh087JjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA51B86F3;
	Wed, 10 Jul 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606038; cv=fail; b=JOuzdlyics8RH/dV4XveJ3zKJXyEoisFzOJIgcU/uo1uS5YUKrBXg9p9Hky1ADWJpT5PhKlR4PNL7I0DuX7jIxtse4jj0ZIUP8bFIWR1hSxNUBZdJQryhv1vsptMINegEyIkNHbmv5y0/FGBuxVBZI8mCY3ed9g2SvfUD9GUFlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606038; c=relaxed/simple;
	bh=TkNPzPk/uq6zN4mx5+twDkVK21pdWkHhCG9D2bSV4kE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HoHRjVwE4w/Ue0wDPCFQESAZhyNLAQVO6w4M1XFG/p2+1JiPnAsGp7u+CzGmS/152k+HTvoNh/UHSGsZtKhKLDGWjV6cyFNVh2eCjVpufcxsdqil7QBBSnqjSlmSuF2l0t/qPu2G6vvGGBDGd/AqhQWpeasK644OzLhqyfKC9Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bA1aUZPn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wh087JjG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fX5f004054;
	Wed, 10 Jul 2024 10:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=2c44HGAUJlAdOnA+bMNgihZFiOdFL1laKynocJxjcL0=; b=
	bA1aUZPntJ6LY5+GuYKuwv0bwLCOISDM/V9vIF9JNniKXSysmn0REE179D39LbUH
	q5qOpiBDrpOwYenB4GIzKXJJFQQBODaJU9XA9FiR7srOQ0Ek5EUmcK4MsdqXrjyh
	3qxpKhCluHSm8za3CtwUkutWS5Tfp6pIWfl2MLc8jKQwpj3PeGJk3dlV9Apvbt9p
	/z+UzM1Tfuczc3BX9O1+Urwc6q68dliy3pRsz0Dk4RDbuRl4Y8POPbhfcIokZxGF
	wtKk5DqAibneE0i22OKUCnEjgn+lDHhy7DulFBmvjl0W29a7qXFXazVWiR7Zipos
	2IuZFU9/VeWkgc9IiqxF9Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfspwt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 10:07:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46A9sF2f005997;
	Wed, 10 Jul 2024 10:07:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tveyx5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 10:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCpbnBHmUqGUbxG2xxks2XYv1bCXXLHRf6SADPCUJ8iEmXC5+gxiMPzO1ZP5BcKSCQEzblIMKdyDJgLa5Mjgx2GpYO03V1pzVedhF8rZdK0Tk8OkxxYHi4Qj8jSXqUmWHixjq0vIaHGbmqeh2qfM6YE9pjTBWDCK9KhowzxM1ik2RvMt5lDQ48pgI5vJ5cf3o3hEckk2HyMAwMBL1HC3B+Mg4cnUqvKYRYi29CjHDCAdSDaJJKzz3hUYf9Rp8sf2LuyU5xJzHoQyl0/mjGPf0LIjOxXY77ulvknM7TTS8M/ZAOnwqBeXY6axlWmNEWcaglLwQrRo3DTrRPFdBLKdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c44HGAUJlAdOnA+bMNgihZFiOdFL1laKynocJxjcL0=;
 b=HK7RM4cxRidSlDxfOT+8kp5fS5iU/JxZfnXEqFkh0U2kIH/DGntLUy+dJPNjLmzkhB05Y4wy+wPPgeZFlONnoeuwA5Sep7p4uSa+R9tuALojlMEbpDqKQZqKPTHVRTuuzRDr6MLkuTdgeSeR4tAET2G5P30jCxE8uquyHrTRz78HD3Ejv7gh4e7sKUbYREfs42J72s65yB2NBSvmcYCoCWpAPKQMRY6+ZpRc41iPo2+EvEtmIhESrnnbpe2QE6btmkUMgPd6bedQFy1EnTQOeiw5uKTZ7Ixqj4cb88L4dLZ+GO8hVaUSgLG8HsmktM+XxKVdbEckW8hBvKg848MA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c44HGAUJlAdOnA+bMNgihZFiOdFL1laKynocJxjcL0=;
 b=Wh087JjGdKkt7SgpWIMNkRSCTGdimLSPx7LB/xTJy9vx+xK7Ayk8XR/qDHHuRcbdoHf/g31msA1BrlDiAjuQo1OKhRc6efb3o+I/yFPwdocl9DFYSlWWLcaexIE91V55zApFd0t+D4Sy4u52t7HYlRaSMMlS1SWEZ3/BZFYGI2g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 10:07:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 10:07:04 +0000
Message-ID: <807a74df-5d89-4260-821e-b3968d7d86d4@oracle.com>
Date: Wed, 10 Jul 2024 11:07:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] man2: Document RWF_ATOMIC
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <omql3s5mauqxjod5zknewdxjfdsihzv3fi2ypbrzrtkgtcm4yx@peqqpks36isb>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <omql3s5mauqxjod5zknewdxjfdsihzv3fi2ypbrzrtkgtcm4yx@peqqpks36isb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0394.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 93491853-b157-45e6-d9fa-08dca0c80c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SXpBK0Nua0c5UUVzbUtPWWgycHowcFd6cE1JUUtGUzl5QUEwZ3ozRlA2VnFP?=
 =?utf-8?B?TVFVN2FNbnIwdFJHWlNZTi9nT3N2MHJ1NUVtVXR1aDY3T2xqY2xNQXhldFQx?=
 =?utf-8?B?K1BZWjFWUTVDeDI3ZWVqei9KZE5kVU9NRHVzeEZRTXhNYXR1RzdabnBtZVpu?=
 =?utf-8?B?d1VOc3FDanpBNGtXZnhRNWxyK21FN2s5ZWV2UWw0YTRXMGJBdEpIOGlRQWc4?=
 =?utf-8?B?Mm14bmtBZ1JBWlkyTEtIOWtlUjNrOWxZcU1weXU1TnVVUkZQQ21LZXc1RzFE?=
 =?utf-8?B?TktoYngvNGh6dlREMGlpQ0lMVndFTFNqZE8yU05xeGNuazZuSmZQWVloaWta?=
 =?utf-8?B?NTJ1VmtOMjZTNm8rMDZUZ215WXcxbUdCK3JRdUhqSG9YSlNHMUFKenorSGFP?=
 =?utf-8?B?c2VnVXRpMUhsaWhhdEV4T09OQ3d5S2QybmVSeWZ3Zjc1T2dtLzdrV1RQMm8x?=
 =?utf-8?B?TitlbDVLV0p0ZW1GZGJkenh5ZVUyWG43SU14ZUNRNVN1QUR1WEh1dFlXQ1Fw?=
 =?utf-8?B?Y29xK2pHTmNxZFNqc2NKOHowS2w0ZGFLY3paZDJPUEZMV0k5Vk4vNUY4eE1y?=
 =?utf-8?B?aW1UQ1VUY0tOWDJoTW0xL1YxWGlMb1E1VFA4SkJWV3cvN1BGYVhsKzdDRUtP?=
 =?utf-8?B?MlNSbXd2T0kycFREMU5GaHlDMHJYRHN4bmU5RDdacm1ERXlld2dZNFpWd281?=
 =?utf-8?B?R0VIenRKWVU1REVOVmhHdW1uZ2tpTXhQYS9FeE5vSTYySVAvMFZlQUE4TWFv?=
 =?utf-8?B?V1hIck83T1Z6bVZGVVBDU0tMbGw1NHEzcWZ5ZXp0cnFpSUwrU3l3RVEwZFBN?=
 =?utf-8?B?aDdMOFdzVGRoM1BoRTJUMEQ1Wmt2SHB4WmdoOTdMV1FIdXVTaVcrZGJjeGNv?=
 =?utf-8?B?QlpxZ1R5b1h0dHFLUk11am0vV2UzY0R6Z1c4OEw1SVNmMkU1bmVhOHJOUHNJ?=
 =?utf-8?B?NVJMeUtYUGtWeEVsWkhvemlSNFNQWFBMSk1tSXBSRmJOK1laU2ozRjRXd3VI?=
 =?utf-8?B?REN3UjBxQmFtYm9Wd2ZoMzlFd1lISnJBZmRWMzVYMk5qeEcyMzlLTlhnbTRj?=
 =?utf-8?B?OVZIcHA3R1hQc1hoeVAxZlVZakxzb1B1QnBZcDB6Z1d5OGFzMUxoMkdZaDNn?=
 =?utf-8?B?dmJwajRHQTZtRWl0RDJvK1gvU0tDbEtUZ3JYWDFjUnhWQi9ORENRbkxJNnpD?=
 =?utf-8?B?K0ZrYUpJcW1ybFpzZ0lUbnVUZ3QyaTNtejVkMURUNDZGVjF6b3BvMTJpQzRT?=
 =?utf-8?B?Q1NRNDltUFlhNGhHNWxMZ1NRenNBYjg2YjlhQ05iWE5QM28zQ1VpcDdQUUlF?=
 =?utf-8?B?NXMwMnFKQ29SYkt0dThiRnNYOVJCYmhQVThjMHNzUFlTTkRHczduRTQ1VExl?=
 =?utf-8?B?YWpSQy80UDJGdUE1ZFV5SkpmZmxFSWtBNFZKdHBUOHhPUHNzVmlkZ2FTb2pz?=
 =?utf-8?B?bFRLaDhXOGw1UVdaTzM0N3dqMlBYOVZhRzBOc1NTNnZxcWMyc3NFQzJwdXh6?=
 =?utf-8?B?SFNQY096MnNPRDR6RmdzQ2M3aWRmMlhrVXAraDBmOVB1aTRPRmJJaS84RG9U?=
 =?utf-8?B?WHd3WkRHR1E5QUZYWnZhMnljTUlTS09ISmozbERJNEoxWlZRMmFVMmYyV2No?=
 =?utf-8?B?K3JZblBtY0llRDJpbmRUejNsVCtyRTNOOXY2NWlYdVo4VGFZcmZTeTBObCt6?=
 =?utf-8?B?TTUzQ29xMWNJaW5LcDYwbU1BZ3RLKysrdUtud0dPbXRnRlJRcjJ1UFYzbEVH?=
 =?utf-8?Q?NQmWohxLtkL1mbTQ2i12X43qcw2zCBORtWzUZgV?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZkNWOWlzMFJCVkFZdG92d0RHdklxSjEvV3BpQy9QMVZTWFZqVkNzL2N2dVVB?=
 =?utf-8?B?eXVCS3lKOFlGSzB1ZUZSS29mamJQN0syMVNiMDF5WmtCV0ZpU3cwLzVqQ2J6?=
 =?utf-8?B?VXFQU1h2amhSUXl5UGNnbTVPQWVzdGl0NzdEMEgzS0tDVEluVWhzWVM4c3Ju?=
 =?utf-8?B?aUsvek1YejZnNDlZa2k1Y1J3aURvWE9kSE8vTzFzMFRXZE9uNnBIdFlLdGl0?=
 =?utf-8?B?dlhIbmFDYXV5OFV6YmNmLytuUXRHUytwWW1sN0tUa0x4a0wxS3lxaVFSZmJI?=
 =?utf-8?B?cVpTU2wzaVRvK29IZE15KzFMNU5qTWM1TEt5L0N1Rm5XRmorR0JMU0pOcWNV?=
 =?utf-8?B?RlJKbFU4K2h1S2tuemhJOVZzRG0yUmRPc1IwUkZrT1QveUh3cFA3M291QUpK?=
 =?utf-8?B?N0ZSTFdaTmQ2RzZzMnpCVDRnSGduc3UrK0ZiZDRuWS9pUmZyeDdETVhuQS9k?=
 =?utf-8?B?R29RbEZXUkNoSjFBRlZxOFhvWjF0NVoxVkxCTiswWnBLb1JJNUZTeE5OdVhm?=
 =?utf-8?B?cE51dTM1czhqQ0RyNlNNeXJMU3JZVVNwR3RVbTJzakp2bUhiNEcyYVdoZm5p?=
 =?utf-8?B?REFYZTc4NU5LQnRZbGtlZm5ZR1lPbHlFeDJDbzI3cERUS2lDWStHejZGdGdM?=
 =?utf-8?B?ZDIrUzZteDRVU2lpT05STkJmZHpBaUJWc0ZaTDlsWnFLVGlrd2hWeW1pbmdK?=
 =?utf-8?B?cWtZQ0VMdmVheFFQdmt6YmhOTzV5c0JFa05OcGRnZlE1RVlpRjVSdXlXUzRD?=
 =?utf-8?B?dmw1dU9ZVkJyUFNybGVSUzZmckRCU3NTU3F1RXJ0NnAyK2lHblZ3MnVqeTlo?=
 =?utf-8?B?WU9hSytCZUtCY3RHR3JmU1A3RWtKcm44OGZOUXpjbjR2MU1VODV4T1Z0RDc5?=
 =?utf-8?B?UjFVRHVrNWVNUFI1SHNKcFY1MHJIYURwZFVPUlpVVVp1UU9ZL1pOOTJETExT?=
 =?utf-8?B?dXE2RUo5MW95bFRTUXJmRDVVdWpCa2ZZQ2dzSXkyb2ZFSUJkUXZ6U3BmZ001?=
 =?utf-8?B?Vm5NWmZqVVlPMGZQUjBBTXo1ZnpudFZUU1BTMllDQXVjRHR0eTlQUTZQNk96?=
 =?utf-8?B?ZWczK0M1Um1sbU9GN0lvYVdUTFNjT2pHZ1lWMHZGbEJFbkhnQjU3azlzcEpZ?=
 =?utf-8?B?UzRrWGlpTVgvNWFha1RMd0pYNDNkUkNkZ1dBaDI4UE1zWGVGZWJxamd1TFp5?=
 =?utf-8?B?bmZEZHVVNllzNE1NYU5qOXQ5Zk0vcjE1YjNRd0YrQ1BJNHZib241SkRzdS9v?=
 =?utf-8?B?RkI5dXp2RVFhdVlmbjBoSXJ6TEVQYWlKUGE2M0wrd0lJVzlYVDJwUnUxRjRq?=
 =?utf-8?B?R0Z5ZFpCNkVuNTVqTEtia2dnWkU5clVlZU80aVB6UFhaSGVFZ0pqeGhXdWlO?=
 =?utf-8?B?VlNYeklmRVJkUmVnUnd6THNnTS9HUWtSWlllZnVjRXM3ZmQ2QmtEYldYdmI5?=
 =?utf-8?B?dnVtWlVhOFppMzNRTjkwQmRGeEtQZnQyUXhtdTErK1FnNWhpZkV2Y2FuenRV?=
 =?utf-8?B?eHJPWHlwdUppT1BWSjBOTXpQbHAraVBXQ0R1VDh2Wno3VWxYaHpEd3pmT2F0?=
 =?utf-8?B?UXkweGQyVkpoTVZyQ3BiTUk3Q2pKTkdwRHh3YW5hMVY2VklDZmNXVEp4bmxG?=
 =?utf-8?B?VUtpZ2lmYkZDSER2RlNlSW5BVXRJWGcxT3pFR1lZaVhLeXdHQ1Jvc2VrVnU1?=
 =?utf-8?B?dlZEbjlhMWtoYWdQUzlBZDRZTFpZVCtIdHpWNVlpZW9wS21LQkZFaldJcHlI?=
 =?utf-8?B?cllxVmRkTUdMSk9ORW5KelV6cUlHb2V4TzlOUDdNMmF3UW1PWHFJYlRGZjNv?=
 =?utf-8?B?TWNjS3pPdTN0TUZ4VS9ZTXNhbStzbW1YdzJXQlhsYzc0bDJWeFdIQ1V2VTRZ?=
 =?utf-8?B?aExGVnQ2UFZVdzFIMkJQdkVNMlI4SlJKVm11U0l0VDFTZDZOVjlKdERsN3RU?=
 =?utf-8?B?a0hxeUQzWmdVOFVUNkgzTWNtOEIrMDlPQUxOMUdWcExweXBSclNwV1NPMjEv?=
 =?utf-8?B?d0lZMzk3WHMvYjIvdXgwYUJmbUhlZ2tyQWFYb0VLOEdsNldBN0dHbWFaNk1l?=
 =?utf-8?B?UWhjQWFvT3NGU2RwelI1ZFU2QStDMW0yN3FuZnRvRklXV3dhdGhGeStDWW9C?=
 =?utf-8?B?Snlya1lBVG43UUxGWXh2MFRNeHpBamZXTHdpL0Fkd2tyUVZ1NSs1bmJhUG5v?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n7WNeO7t//7f43jJAAByFtd8wsjTNFrYkTSSg672hBg1i4/TTGmPhxTFsznTzaLRIaK33itzzFSBjhdv7g47uHTh4v8vzRyceZGUVgd0ZQL4zGd05Q9R/0iRAb6lMTXqJK1cBqVblCXmy5u+4MqeqO/hzGyWIGxXfVxlvWiJxH1FVD03KT7IFF/thGqyOxl9C6vOkps0tVE/R8XowwGpMqVfKCpmQsK+wC4ImbgWsl+HIDaPunRkE5wzah+A3XsO1CwFH9SVLliSmDF8dazkWOZH/phkDTEMRhq9FzbSGWKadUqPJ9YdnoaEiQZbWJ6K0mUVvUi+BdLSkNtt2FQ58ZrORnfyIHcZg92epPlcJgXTtwf+kAEJNB8/4Ubkp/4hg/1jADcwzC22t9Lv+h56cd5PdfhOzhfz/bkCe8boFa/T5U9w1+hhsphgorr6UhYvBiicW7NACZp3eVJ6OQEMF28Kg6ICH+ddwxiHmkzRrlAaQMQsF1+SX6/0Ui1iKVUSZLdjREDYOog1jEv/KoOpnv12eZYYppHzA9BHgk1gkHFUnqDhblVFTMkoMEHFdwA2sLokmcNG12Jjjj2fnXxCdTq3l2Tq62qfdxAq56cUf7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93491853-b157-45e6-d9fa-08dca0c80c90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 10:07:04.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4PLS/1H8rCL2eG+VHROhHdUY8a7+5UZNkHMQnMKPks8ZfRa29RWekhuUCqaPhYm6j7STaIbVKUE+fcMHK7UIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100068
X-Proofpoint-ORIG-GUID: 98zF9z-ZnpfGSkc2vy_XwnCIhbMw1eOY
X-Proofpoint-GUID: 98zF9z-ZnpfGSkc2vy_XwnCIhbMw1eOY

On 09/07/2024 17:43, Alejandro Colomar wrote:
> Hi John,
> 
> On Mon, Jul 08, 2024 at 11:42:24AM GMT, John Garry wrote:
>> Document RWF_ATOMIC flag for pwritev2().
>>
>> RWF_ATOMIC atomic is used for enabling torn-write protection.
>>
>> We use RWF_ATOMIC as this is legacy name for similar feature proposed in
>> the past.
>>
>> Kernel support has now been queued in
>> https://lore.kernel.org/linux-block/20240620125359.2684798-1-john.g.garry@oracle.com/
>>
>> Differences to v2:
>> - rebase
>>
>> Differences to v1:
>> - Add statx max segments param
>> - Expand readv.2 description
>> - Document EINVAL
> 
> I don't remember having seen v1 or v2.  This is the first iteration sent
> to linux-man@, right?  (No problem with that; just to confirm.)

Yes, first for linux-man@. An oversight on my part (not to include for 
previous iterations), sorry. Please see v1 and v2 at:

https://lore.kernel.org/linux-api/20230929093717.2972367-1-john.g.garry@oracle.com/
https://lore.kernel.org/linux-api/20240124112731.28579-1-john.g.garry@oracle.com/

Thanks,
John

> 
>>
>> Himanshu Madhani (2):
>>    statx.2: Document STATX_WRITE_ATOMIC
>>    readv.2: Document RWF_ATOMIC flag
>>
>> John Garry (1):
>>    io_submit.2: Document RWF_ATOMIC
>>
>>   man/man2/io_submit.2 | 17 +++++++++++
>>   man/man2/readv.2     | 73 +++++++++++++++++++++++++++++++++++++++++++-
>>   man/man2/statx.2     | 29 ++++++++++++++++++
>>   3 files changed, 118 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.31.1
>>
> 


