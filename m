Return-Path: <linux-fsdevel+bounces-46498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45321A8A441
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3020C17CB72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98F29A3F7;
	Tue, 15 Apr 2025 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8qw5r8X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M9TbtH3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E541154C17;
	Tue, 15 Apr 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734976; cv=fail; b=mBdGM0FnYMruqzDwgDvECyDBHxTKmuFoX6utwnz/GhXam4OzXa+SkBh0wkt31aeBdbqOy+SH0Pvjrdt95euzbCJPJUIaVSCk9ULrPyfl0/a9CYcgZsS6Ri5Y9ldaehYZXSS3fHdrO5VxATwWDCx4f/ThwExFI7FnTjbLfQqiFKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734976; c=relaxed/simple;
	bh=y5uyUIhB2gTiSE2zyK6+wcDh4Xe4wFAWrN5/Q5/GPEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N3YyrT1em9QKf8CaKX7cX8P1q79lqLdrMeyujUmGsXMUg1NZ7/bHgB4y28gj0AEpzm2oBVcQAGTGG9mZ89s2d4QDFG6JtI4wScXew3l+NpgVu49l+vcscNT/Nbf+Y8iUDga/+KLeJj894yUjoViW44bK5d0uhc5uSAxHKRJYtU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8qw5r8X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M9TbtH3s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FFMenR028657;
	Tue, 15 Apr 2025 16:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LJCHGjOB79KD2roCsqtTUbmS0j9H7nZRO5M08zI6lZc=; b=
	m8qw5r8XWh1HZTSAiRHzRGb035lE3MzbjEVsfRMw12hrSwtNroszOLHPZRPcRU5S
	rHwVJQsEl8rCbl1hNhuiRkmbgRwc8/xFkFQEtXYyQLDiipOEzG4UUOoVF7Hu1ZJy
	PlJnUXnwLE/fZeA3pK3OeFBhvEx2zgKVTVJvxHL1he4ZtMpmFhhwPqh6aNSJUS34
	kO2YK7wVZ+Yp/hX3dr/A39OKQzKPXtZwhHhRPk88ExmHFPY9bBXzOjDDzOfAcqIB
	ghsUW4sl4kJ26b18jQsk3SnFu1tPXjsrROmNWw9hRUYaMUjk0sPD0UFDAlvVBxCu
	4hmBD+C+5n3ghCUFWzkiZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617jua75w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 16:35:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53FFALtK008529;
	Tue, 15 Apr 2025 16:35:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d2qc798-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 16:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrN3jQsFXdgmeKQoKwPTprZu4PVxOIOj1stV9JsWkVfb2JWEl1fpVO2jO+uGtJdBrpbtvdYwvOc/vGutiqS9KjsSeL8/40Q+8U0zXmgbIge8mHgOUt2f1AAFOeRoffVYMdr6Kpo6h1RgI9pylgogG3ipqiuwCBh5xN/+w2pksN0Yg05pMSpmMyuQ+MLKpxhxwpiYH6/G+Ls0LkdNG8bcoW1k8/H7khX0hcpmIionCr950nGxenXfVnCpiWZCcxu1y0PVf39JCD1vfk3CpnTsmY9supKqf4fZ0rqxV7BMldNtFDPF6F4DFmix4PEqEO0eT7CqbZ7+Cdgfh16anp+0Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJCHGjOB79KD2roCsqtTUbmS0j9H7nZRO5M08zI6lZc=;
 b=PqTe7T93HewNEfIt4a1YP4FN6ou5rbPI5TpVnSN5hbF5a+5hFJwPPjIIzlX4+9WwDhR/C/gZD7Jfoq7+9rAkrY0H6J4qPboXm+tSGZWZJN44ZhAR8pcZTbpi3Qge/WOhtA6guDHHpdfqlVx6Hva4eoLU0c3bGEgklIn1hSC8sx/WbyX7W0nsjubqYQz2fHidO0HWc8imHTOrp33+K+GDXlL1RTqMPXVDpJGjLhPe6JQQeLMgFQH0ak234URp6gfbK3NopbqzQakXi8Dw9TOrRPxnDw9F2jgOw+4F/rhwDmvZG4SpA6FrSL9YGBsvh9ngofHSUJfxkdhgFcLKoef7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJCHGjOB79KD2roCsqtTUbmS0j9H7nZRO5M08zI6lZc=;
 b=M9TbtH3s4fLLtEu3BawEOX9HkHXWoZmhvEmfG6/XNqIeZZCe/sJD0zWe1cqLsUmvBpmyxgxHFr64QkLoPgiGEzdHg5fZOeQbUQh6MB+RVOcL5zFV1RmFWHJlPeE2ZOj1JLs2FzyqLezNhrrBBQn/jtw3mVunfc9msPuctstnPVU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 16:35:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 16:35:37 +0000
Message-ID: <2a34fd18-7975-4c6c-a220-9a5279f8d58a@oracle.com>
Date: Tue, 15 Apr 2025 17:35:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/14] xfs: add xfs_compute_atomic_write_unit_max()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-13-john.g.garry@oracle.com>
 <20250415162501.GP25675@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250415162501.GP25675@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef77991-d17f-40ae-d81a-08dd7c3b8d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVlFdGVKRXdyaktkVUZYNm5QYTc5MTJZREVpWUNxRGFkQ0JlYm9VVzIzS0pI?=
 =?utf-8?B?R0h2RDNpaUJsVmtaTEZmMDczVWw0dVk0SWpuekxSRDlUam04ZEJLYWpHa2VK?=
 =?utf-8?B?ZS9nV0VBMnhTdWlib3FIWDRvQ0ROSUtra0srQ3puWmNiQzJ5OWwrRjl0Mkhl?=
 =?utf-8?B?SzBvZmc0S1ZueXQ1aHhGd3gxOSt6RU12MlBwZmVmY3ZBVEg5WXhxWWJzZ2NP?=
 =?utf-8?B?N1ZXbkFsK05sdEg3c1F0cEtWVU8xenRsSDRwN0QrUllCSDI2RmUvaVZuc2lu?=
 =?utf-8?B?NFZMaGdMeGkvZDViZEdEeEtmUCtaUFlwM0V1RjV4U1FjRDMvVlNCTFl5aXpR?=
 =?utf-8?B?cnYyOWE5ZWpGdjVCMVlEV203WUIvSFRpOXBWTDRMMC9oWGtJcWhBQ29WS2cv?=
 =?utf-8?B?VEtneG9NL2R6REgvYUdiQnJSZjN4ZndWVmlmZmQrNytyMWpxcnZHQ1FYVmYr?=
 =?utf-8?B?cEJ5aFdJcmFhOHYvSDNkcU5tR0h0SHIyeDlaRUtnSWIwL2RPTmxYL1RuQTRq?=
 =?utf-8?B?UThhRjFvWWVkTnltcmQ5L0NzUlhDbUJuQnR3QVlNRkdVSXZNK1BlQ1BySFR6?=
 =?utf-8?B?RDNOUGVIV05EeDNuQmcvSFp4ekEwa3N0c2NVaTlHZWcyYXlkTFN5L3Q5aUNM?=
 =?utf-8?B?MEd4c0VRVWxLd2c0N2NXVjR1dEpjTTBOZXVjenR1SkYxUTRvZXNHM1N4eDA5?=
 =?utf-8?B?bzlKVnR6OGZzY1hBaTE1M3J1SG5CbTJFKzExVTZ2M09qRktwYXdYZVllMGhO?=
 =?utf-8?B?dXlDU0tIRG96OVNlSURpeXVMMUF1emZobG04Q0lNZEN2Y1ZQbS9UNXlLL1V0?=
 =?utf-8?B?WDdoVkkvNDNDVWpCOVhLN0d2cDFEeURrRWxuT2N2RElwRG5NbmYvZndqRnhS?=
 =?utf-8?B?dHVyTUpaUWxwdCtnSUJqRlVoaUpuUEw2d2VCR3hYZUR3eDUwWllNS2JNSGlK?=
 =?utf-8?B?a2RaWjJ3ZHZGaTF0R2MrTmhKQ2dublRXRVVjRFFvMUpOakFZS0U2aVUwcTBK?=
 =?utf-8?B?clltMk5PMys0SzJOblJPSG1XYnBiWFE1WDF5b3MrZngyU1hrbklnOWJiOXht?=
 =?utf-8?B?emlXd1A2WTJDRFh1clhYbjdYdmtpVlJ4UElaK1cwSyttVlZzb09qdHBpbFhO?=
 =?utf-8?B?dVIxNDZQYW5EcjZZOWdJcHdEMTliOUw2bFVaQkRuZE9IVXdHVXdISkFKVnVH?=
 =?utf-8?B?MWhOczBSSEVabm9rem5CRWMvZ2xXOG5oOWRQUjErZE1maG1KMFZUK0lLKzJs?=
 =?utf-8?B?NkoxUnRyTU9Sa1cweVJ3NXJrUWo4VUU1dmRPbW1DNXRtQVIxczNRaERvMCtQ?=
 =?utf-8?B?dndpbHZRUE50T3ZPdEloK0hjZ0g2OVQ4b3JCNHhXTFBJajZpQXZwc1RVd1M4?=
 =?utf-8?B?ZjJYblhrVFpScnFJMHV2VEZoNmw4WHY0SXpvdVdLZjJvU282SzdGZjUya0dD?=
 =?utf-8?B?djJGNVVkR01YaUNJcE5yWmxpejc0NHNUWFFXWVlIT2xFdStVVytzYmFCbGd4?=
 =?utf-8?B?NGtxVG9IU2ZLL3pVRVlZSHpKNnJsSE9Kc1lKajc1RWNsVUlKV0ExWThLWEtS?=
 =?utf-8?B?YlQvNjArQloxQkZodC84cmNramVSVWtqUnUySFFRUFJieUE5azV3ZExXNGor?=
 =?utf-8?B?WFk1L2d0Q3VJTXUvNFY1TUpJWE1EcEpnUHRUVFo1Q3c2dTArV2ZTbUhzMDg1?=
 =?utf-8?B?WTc5TlZ3czQzd3pHMHRxaGg1amlSNmFXNjJvSXhZRU9qZlM0OHl2TDhCVzlx?=
 =?utf-8?B?VEw1ZW9vVkpLd2oycm01TWkrU0FCUERKTjNYeTh6Um1pM005USswa1E0WHVi?=
 =?utf-8?B?WmVEMnZUMGNuSG84T0NGUHlaVTJQR092V0w3cUI4dzN5VkJVQ3UzUTVualVF?=
 =?utf-8?B?S0JJS1I3TmhRT0EwQmducTdHSGREODhkaTQwaDFRbEl3WnFtVjlkeVZ0b1A4?=
 =?utf-8?Q?XVlSneeHnVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU1HdVRXSmtnbjR1MzlBMTBXNnFRZ3ZTa1pzN0IraTRldUljUFBZQnhyNElR?=
 =?utf-8?B?c1EwZWNzK2NKM2pRS1B0c0VxTU9HZHRsNC8yWWV2bm0xbzFib0lxbDE4NXRK?=
 =?utf-8?B?ajJHWndwdm9sbEVTbCswbmdEN3hTbEdxWkpUYXFlZm0vTFI3M2JiWEMwZTdl?=
 =?utf-8?B?aC81ZUdSa1hkbzd2MHlNRlY1SjRTWFRvSW4wOGg0SGxYUVVxbU5IUWZxQTNt?=
 =?utf-8?B?UmNBSmlIOFgrTFA2Z1hTYWh5S1d2YXVXMDdFanI3aXZ3MVFGYmZOanFmRkFN?=
 =?utf-8?B?N0FYTHhvdnRNcWNOWGZpdzcxajFpQ1R6SkM1REllY2gzNGdIcFd1bkErbFli?=
 =?utf-8?B?ZkdRcjJxdCtPcENqWGVkZXNyN3JQeEp2b2REeE5YMi9ma295ZzlkMjV4d2NS?=
 =?utf-8?B?M2g5dWlycXoyTFVHTnRoeGxVWERpZGZvRG5lQjBUelo5U2VqVnRCT201K01Y?=
 =?utf-8?B?RFh3MGVJMkVubXRZRE01ZUlJUXNPL3FVb3AxSWZVdi93ZUROK2x4d1hRdW5P?=
 =?utf-8?B?YUFUbVplRzFZV1hZWCtJTitDRFZTYjhNRmx2TEltYnprMFprWUpEMENUd1JL?=
 =?utf-8?B?ZlduKzlxblBSWEYybmlISkcyUUJGWHN1NmxHcVUxZ2tMcGRqakRFRkQ4ZktB?=
 =?utf-8?B?dkRocklldmU5cVZ4T0taWmRMbFhkU1I5eUZpN010N3BKNStMU3BwOXpUU1V4?=
 =?utf-8?B?YVg0aGhPajhDN2hEeGZVYjZXT2ZCOHlaSlM2UmRmeG9qN2FwN1ZJamdRKzFx?=
 =?utf-8?B?WWxVMkFTREJ2dXBDem1FZThGYjZndXdGTHdNTEdkaElscm9Yc0hlN3FOY2J6?=
 =?utf-8?B?Rjh0Y1llT2Y4WGp5SGpGcUdoRElhZGxvZmlZc2paNVcxSTZxSWpXblNjN0Ra?=
 =?utf-8?B?NnRKcVVpTW5PNVJrUGpBa0ttQ2JkL3dIZmVWeXRsWVg5SEk0cWc1amZmWDNx?=
 =?utf-8?B?Z2NsMkFKZnoxUjl1bWp5UUQvWDZWa1BGR3I1c2tvVnQ0UlVYellDeHRSVnZt?=
 =?utf-8?B?RGMzMHVtd1p5UE5qZ0JZKzhPVno1c2FBaU1nZ056ZSs3U0VZTlduOXJsK1pV?=
 =?utf-8?B?MHc1ZGI4QmNVUDhwdHRqZ2lwUlMxN281Qks0RDlacEgwN0dmQ2tuZEs2TUlG?=
 =?utf-8?B?eGJCZUdDRHNBR1ZUajR5dXlzOGVtZXlyMnM2bndkYWlGTVl2ME05eXNSb0Fz?=
 =?utf-8?B?UTcrNFJ2Zm13ZzlzNnpsbDg1S0dPcUM3MWxDT0t0dlNYZmRhYVUzYlVxaXIx?=
 =?utf-8?B?NjFlTWFqMCtjMGFndGVBNktpMk02eHBWd2x4T3NVT3phOUdCTVJaTlNZZC82?=
 =?utf-8?B?NFdQTThtSml4c2VscUNuRkJxU2E4SnhDOE9jZ3hHa240bHFVK3F6V3lBaDdo?=
 =?utf-8?B?VkIySTFlWER6bEhjSGQ0cXUrbUdGcUxGZW93OEFHMnFBaU5LNE9LYVkwWC8w?=
 =?utf-8?B?THlTOVhnWi95ZXRYWHVyY043b0hvNjNBSzJWRlhxa3ZCSjFVRE8xRzkyS0ht?=
 =?utf-8?B?QTYrdmx4Wm4vUnoySXdjSkhuM1AwRWRxem0rcFZ2azdGSlFHQUo2VDRabXE0?=
 =?utf-8?B?cEN4VzBMOXIwcDVkMjVWVjBiaytMa2NQU1VweVRTTXk2c244U1RyclQxby9r?=
 =?utf-8?B?YWhjOVlDTFNMeFJwdWFmSkswTmxYNU5iNndYbU1DeExYeW5lS09nMjgybVYy?=
 =?utf-8?B?ZUdseGc3ZUgrSjhxRDIxY2xiWFU2M2lxdHBHNmtaZ0lYbkxuT3hYcGEyQ0dL?=
 =?utf-8?B?RGdDNW92M2ZUMm1NZG9FN2lTak9jNUNnSEU0Wk54eU4wcU1UYXhWK2JkNXBH?=
 =?utf-8?B?Tk9EV29MeFM0WTBzVnZHYTZ2dEVIN2haR1E1dUxBakFRWjBaMEp4VVJ0Z0Rn?=
 =?utf-8?B?aUJ5M3lKdEh5UyszWmJLdzlpbTNZdUlacnpxZ1JpTUlyNnBVUm45UnVNLytN?=
 =?utf-8?B?RzFVenhYSFZlV1A4akcvNHUyb2pYQ3RZUlVNMG5zU3plbWxiTit2WjZHRkRk?=
 =?utf-8?B?MVl2ZmNjMEVYclRsZG5RUzNSaHBRamtabCt3WC94ZFVvUCtTbC96SmxRVXMw?=
 =?utf-8?B?eTRGYzFTYklob2RiTGcwa3BORVprVGFrd3NHbm9KOFZIaE9ueWRYSUlGRzNm?=
 =?utf-8?B?UU5yUE9IbmxIM2Rsc21hVWJmQnoySnFUSlR3elpWSDhFODRZUkRpeWtBZ2hq?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oELMn+yDw0vS/EZv9ICuyVavIif5hQrrnKo0jKIBqPCRivb32GC8F9+i+yWl3d1UJt14wfKMFoWwf+fgSNnyQ9KPpATvK5HlH0k+6N/i06iDWo4t0oEw8EreG+YUbb7/6ME3XMunpCSFbDPkzPGUSl3xZ6iWg/niwSNKERAvTV47DzVC+cnL4PthqYpZ10ZKfqVZVIvvQn5yJW/3OKEsA1E8cSOSOISj1evn3ftPcpIlzI1Mo2a9+XcoSfnlTDXY9OMy82fYSCX/DXvYR1xUNOQUSqavWT7PNEKjgfMDxgw6T24Mk4OESAtIiS0VXMK4zllQBBaVPhFa/LoQWCDiLO1eJRo0kzAjEOpNAfA11HWIRpdAvD389iTafIlCu49URnpu32jkCXkm3o2e85qcXuO6X4jbwqGUdDWrxJRRgjVRU0BupXzgyjLVpupLXibSym+BtxZ6gVxJtx3bGNY+qBddnk9Gqjshfjsz1/GgLIXidTSqf8vsfoc9nyKqqQfWhcYIZSm8WV5FLpPOO6RUhKLY8nKkQvX73fagLeD9HuDpK8K89xX5yQzXsu7SzGsSY44gWrgpd/ydpJmIUOwOd5Mwq5oII3xoQPzaWn8Tz0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef77991-d17f-40ae-d81a-08dd7c3b8d7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 16:35:37.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQzNsU8pXA9sRnqDWdMQirI5byydLwDkG9P+bucntTk8Nxv0Z7qFnte4QkTFPMlfVQFqFghRBgMgH1uDeD2gXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150116
X-Proofpoint-GUID: dDqcD87BxiRE7R6_5Vi_H8QFPss5lMjB
X-Proofpoint-ORIG-GUID: dDqcD87BxiRE7R6_5Vi_H8QFPss5lMjB

On 15/04/2025 17:25, Darrick J. Wong wrote:
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> [djwong: use a new reservation type for atomic write ioends]
> There should be a
> Signed-off-by: "Darrick J. Wong"<djwong@kernel.org>
> underneath this line.

Fine, but then I think that I need to add my SoB tag again after that, 
since we have this history: I sent, you sent, I sent.

Maybe Co-developed may be better, but some don't like that tag...

thanks,
John

