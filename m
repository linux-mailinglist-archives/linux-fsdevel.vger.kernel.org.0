Return-Path: <linux-fsdevel+bounces-43808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503AA5DF6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC1B1896B1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8922451C3;
	Wed, 12 Mar 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M8UmHflj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qbq9/gZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFDC17C219;
	Wed, 12 Mar 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790953; cv=fail; b=cpe7zKYtavseh86X0TDCQ0GTGlseQWGxTU3g97priA7UGHezHy5Yp6J3XFqVOsENngd8N4MFOslL2tCLncC2rW0uGkQzYxh1fNYG1vXq9gsNyW83J4wPm0a2/tCBiWLD4prkLiffN8IRAAXtf/ex3/3BuYTLNCRcy+miNlK813A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790953; c=relaxed/simple;
	bh=1MzhvgUg3e7VhaWO+TREUoRGjT4CU46LewqLudiXRxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J7+cCYv8YRPRpZbCTig1DpdCsOmq48VGppUdHH4LD67Upd7XXrYZ7agl1Dofn1NgV5r+luiANUeSRa5iJ3oLtL4B3wvU7cmmiBE8xpm/KHP3Uj3jCnRaH9mgeqBhHcUgOXw1IOCXk0YoSyl4SiCbv1XR3ZQtzMMI8oVRWsF8osk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M8UmHflj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qbq9/gZX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCHVDF030369;
	Wed, 12 Mar 2025 14:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XvfHw3r76NVOpoA4WDgvR0bexqFAqUlZux20HhnaLkM=; b=
	M8UmHfljPNExeIJPDmM2kPtr5sAYOV6wqNoyQ4HnOM0ezPQp77DZRz/Wu6Cg6hEn
	KChOjAD2HsCjcW3Ic5PLEuIur636paj2llXM4HAXES2FzC2jV8rLw4LyPchitzad
	UYcOTpOUg/828xE7v/cEhfjrB0iFgLXEbL7Wnk02B2JcxDUzmQh0vfu9CEvDB3BC
	Qb8zBnSt5+8xcwPvd0asNp9BRgcGhBdeQzsDEroaiyQ74Yu1MJcRNSA+l7Ifmwd+
	qQjEESpDBt9YxcDO/Ch7vhB5U2Hg9EwkyVMp4Azu+Xme76ottcw6uu0CQmjsb55w
	GM9NfZ7MT9fBNevoo6VTjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dhybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 14:49:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CDB2Nt022298;
	Wed, 12 Mar 2025 14:49:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmvbngy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 14:49:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmKL+/yEXLYwfSsxfsutIA5bU2uT7xbKtQS/4Ndz2+zhnkG/ox9HLN7S2kbwnGRdbdQU1bvBNrBHBDhbmHTVJH6gvwanUXWtqnPXyo4LM7YVg/tZiS+nAtCrxrzw9DUZyCs+0s3cwTLLmhbWwgxSfaNFFC6rAailrv1N3xw12ljtyy4P8KJB2UuuKkRWcHrtEGg5O+goxDgiXHXbSUUXRw3wIJyxxywXvzFaK5dF46WBwI49qZhCr2kBB1ArEObxK+XfZvym/VzumwS8aVff21LqYjeYIfO230zNHkm1QgRDbNfl7kmKh0UsNGiMOsGe+gA+TSE92aKgGqJkemPMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvfHw3r76NVOpoA4WDgvR0bexqFAqUlZux20HhnaLkM=;
 b=gQiQ7o4OjPByDa0x6ubBURAEDl7kzkBMQ2jr9EdMsHIn04sgPMmyi1FU1BLPJ9u1tIufKODoTo0IxANoeprqJSZEWBINFdb4GITdJAeX846WD+vSLEkuLnz89VaBHype3z6Xktkw+Du+uTGQ/JEeJYoX4eXY5VVC5GW5qJgPBW0JaKER7dXU9/mlQ3tYieKDAC44Yy6sPAWO0Hz3Zl/oEjL2aDUh/a8vbJy/tbf6YERx4HaDgszYyUr1Xsi9ptgQKA92RLjBRvM1z/nPGSik3dPnf8r8Lx7n6cYx4k7SxwhszW3nlgl3NL1Bhc1dz4QRu9JGdKveHl3J/OJ3vt0xLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvfHw3r76NVOpoA4WDgvR0bexqFAqUlZux20HhnaLkM=;
 b=qbq9/gZX95Ec1fLBrB8TGQF+tE6nOB8tsu8xMOYA9CppJc7yazU/GAupR2BCKW7TD6K6AkdVDhAXNG3wDBhnxldB3qQTToJtQSwtGWKNa1Xf1Oiar7JnFOtpg6DlbTnuZyGTvKpDJmu02aEA5vZm2CK62DZ3BRMnoN1NLwBsxsI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Wed, 12 Mar
 2025 14:48:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 14:48:59 +0000
Message-ID: <ed2dcd4d-9d9c-496b-b28c-8540c301139b@oracle.com>
Date: Wed, 12 Mar 2025 14:48:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] xfs: Reflink CoW-based atomic write support
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-5-john.g.garry@oracle.com>
 <Z9E3Sbh4AWm1C1IQ@infradead.org>
 <81247acc-f0fe-4d10-a0cd-bbd5b792267f@oracle.com>
 <Z9GQDhRn3klzmDpo@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9GQDhRn3klzmDpo@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 4482a9c3-6cb6-4612-0828-08dd617505bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnRpV0F0LzNzUTVSVlpaalVKQ05BQXgwNkd5R2ZCL0h4RSttVmQvbW9DTEFQ?=
 =?utf-8?B?NnFKQTcwOWhUV1p3RC8rTGlaRG5EVW14cTF3eW1VNnJBNWo4QjNVTFNoazFa?=
 =?utf-8?B?UmIxM1dUZWpZNmRpVGpRMnM2R2FTN2VpVkhQVVJGd2l4RmpnZTcvandYR1F4?=
 =?utf-8?B?NG1Ja3dveG16dExPQnB1RXQ1Qlo5b3Nnc2VvMEJibXBGMzI0Sko3dDE5Q0RT?=
 =?utf-8?B?TlVyWWNNV3dDeGtVdTNGNHBORkYrai9oUC81QWpEc1E2dzFaSzlIUWVCbnh6?=
 =?utf-8?B?OHBneGh6aENTTmxqbVoxYnZpK2dDL0dYYS80RTY0d3hpbmdOZUxaOHgybktj?=
 =?utf-8?B?eWxqMkxZNXB0U0ZqVGZLc2UyU1pZL2w2MXFpMm0zWVdmMmlDSWZkVWg2ZnAx?=
 =?utf-8?B?dTYwc08yMUxQWlFTZHhpRzJBSHV4MS9vK1NaU2xZMUMrQ0VOYm5yYXordVFJ?=
 =?utf-8?B?TjVZM3M4V1d2KzFDQ291Ym15UjJIY2JUZmYycFY1WHl0ZlM4Umx1S0pvVk1H?=
 =?utf-8?B?RmRGR2JQUW1QbWxpaWthVHZzbDAwMWFTQWozYi9MeDlRN3pwYlBHek96Ni9G?=
 =?utf-8?B?NVpkVUhKZXZoWjcrSGRhd0tDYWJ1U1VsMUFURE9SOUljdU1rTXJHNUxHd3da?=
 =?utf-8?B?SFY5cWFwNCtjZXBzVXRaY2RpSWVJTncxaXdxQ2IwMUU0V29RQlNJN2pRT1Jx?=
 =?utf-8?B?M0lRdWVVZy9mSTRHUmYvd1haQlAzRmtpSHFKdU9paEFtSHNhMU9qVFZ4aGl1?=
 =?utf-8?B?b1BhSWhIQnNKUU83aTJBVENLb2h4bWFOM1g5UTV1WExnMm9FdGphclVqcTV5?=
 =?utf-8?B?TEFMako1Q1pNZDR2QWgwZkIyRVRHdWxKeDJtOTVKR3ZOandPUDIxK01vSzRR?=
 =?utf-8?B?ZlRUYWRHbXR6b1dIU3VCZlVJTEhXOEhyNHBOQ1ZRd2RBcVdKSGhjaENhTjJ5?=
 =?utf-8?B?b1FjZmJhKzh2bGhLVTFQN2ZiWFp5bGFuc1YwNGFYOVBPSWJBWHc1bzM0akpa?=
 =?utf-8?B?Q2RoMHFHbGZ1NUdrNzcrRndyb3NtZTJHSlRMVnA2VmZWdEx1MXVraXJyVmtX?=
 =?utf-8?B?WUx5Uk5TSy9GTzBmM3JzSDVka2U2WVZ2dDVNbXVFSG9mbzJCSUliL21Oa2dQ?=
 =?utf-8?B?QUJYZmRxUWpRby9tbTVKL081dEVJc2N2TXdGTkRHZzMwZThmMHQ2dzZNaWE4?=
 =?utf-8?B?ZXFKaGt5MEh4Z3JxWjBLVEprMVFjdE5YcmNXR3pBR1ZDRWdGTEVDVGNjVXpN?=
 =?utf-8?B?UFJVaXZ1SFowMDJjcEkvMWRsUEZuQjgzUXR1SnVWb21oNExyWHVoVFZrVkNI?=
 =?utf-8?B?NDljdFFBSGk5elptQlZ0d1B2T2l3MmxQQWIrNlJLcWpoSkp1Z2lkYlA5YWo3?=
 =?utf-8?B?blZQSkg2MlRUYzRVb1JMaHVsYSt4cnk4Undpb0JtUWZnLzFYMnF5b0M3cTJz?=
 =?utf-8?B?eS84Q3Z1OElzczB1SWZSMUJIaWdHRzNvZEJFVlFieVVvSytuODlHTFpqM1BW?=
 =?utf-8?B?Mlp6bHlzR21tTUl5aUk0cjZzaUFjdVBqbmVjelpYbzRYdStHcnhFYTlJNWZy?=
 =?utf-8?B?Sk9pSG1JV1pCSVU3dEpPbS95eDN0QmdHWWlocUFGWWV3aVorc1AxOVZVQzJy?=
 =?utf-8?B?RFM3ZUR4T2EzNGthQnZ3NWNnV2RaMURkV0t3THRZRlVLMUp4QUVpKzFPSDdi?=
 =?utf-8?B?QjdaQWVxM3QxQThkaFZlWlNWRmJuUHp2am95cm91V2JDbXRoNHFuSlR3R1Nz?=
 =?utf-8?B?NkdJbFNjT0NCTWFTWHdhb1poK1I2S3FxZHgwYmdOWSsyTm9RNm1FeklLZ096?=
 =?utf-8?B?QXlBS05IbUFOczloWlB4c2M3dnE3OXFGMVhHb0ozTmVxa1VSekp3eTMraUU3?=
 =?utf-8?Q?5TxFG/lfNrLFP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWZuN0t2NWxwTEhZem4yWkxYNWpNOS9HMnhlUVVBNHdXVHhGWXZITlJwQmlP?=
 =?utf-8?B?R2FJd09Yb2hFYjJGdVViK3lMem5YaG1LaEtXYjNxWUlWUFFrK2pGeGxxWm9w?=
 =?utf-8?B?Y1FxUUFrbVdhNThwbmtDM0ZScDdORUc5bHNRRFRVeUN5QWI3THJwM0tYS3hF?=
 =?utf-8?B?R3JQVEFwczRuOE5oYjluRFgzVm0rdUdxeDBxRC91VU9uMzc5ZTBIN1NlcTJQ?=
 =?utf-8?B?NEpNako2RU0xTjZtdEVSUDFQMFhBMERiWUZVelJmNmdIbnpBOTNONU1XYjlq?=
 =?utf-8?B?Y25ocG9mVC9sK1JldEwzUkNDaGpZU0QzWGR6R1g3K2pON3hLOTNjSVNNc2s2?=
 =?utf-8?B?WFhYRTZQOXoxNmNML2NoNVFmM1RDOEhCbjVBcDdVSlc4L0QvRG55U3N3YWlq?=
 =?utf-8?B?ajJLUUJNNEJ4TGJQWnVDdE42Q0tmRkJjTkY5bXN2cWI0R2dISnlEaXJZTVhZ?=
 =?utf-8?B?MnZPb01CbVVQMnk0eTFlWlBibitXL2VJbzhzbEgzblJGNjFDWDlPVjltODNh?=
 =?utf-8?B?ekszb3crQmVHV0pEOVN2K2RYTXplbEg2UklVME1ubFBPcTRXeGVmU1k1WE5Z?=
 =?utf-8?B?RkFiRlRRMzNoWjRKczd2eUNIUEc4SlBralJzbXFFTS83SnJPRWdIdWM4dVVr?=
 =?utf-8?B?VUxtTXh5UVpnSUM4Q0lOZ1V5S3k4dnNCM2ZONjVPYWE5Zkh1emtCNHFwT253?=
 =?utf-8?B?K3AyeTJpZFpaNytsVUZXU1p6QTRrcGxTT1o4SmZ2YW1JMUVaU21qTDBHdGFl?=
 =?utf-8?B?Z0FIa25Va25JakdsR3hDdEJWdmphZVl6U0R6SjI3dHZQK0swMEpDTWppdStR?=
 =?utf-8?B?bkIxRlFkcmpZaC9TL3MycXpLbENLdnUwWi9jSmFPNW4wMWRESG1sQ3dJVnBz?=
 =?utf-8?B?Y2dNa0RlOVl0RW81WWJaUk4veHkvYjdUSlpMelBzWVRQL1JsN0pkT1hFMm9i?=
 =?utf-8?B?UG9xMjBuWGpOZWVWTVhRMldFY1kxYVplb21QMVFiNGNZcDhxR3MxVGtMSStr?=
 =?utf-8?B?OXRuUkFLZGJ1cDJGeWY0WitmME9QN1dUcEszU1FPcTBaRmxnSzRuOWdkQUc0?=
 =?utf-8?B?eXlRdmxYK01YQkt5NUtmVlB4WmVkbU8rWjNSU2NJcVcrZWJZeEJrdHpGemtR?=
 =?utf-8?B?MFlwVjIyWE95MUg4NjcxR3J5cWFQMktMOXFCVzZ2VDhqYWVIazBuV2M3VHBU?=
 =?utf-8?B?YlhHSjVBaXlDUmVSZ3dMcnc5RjBDZ0dMalIrRkZmRDYyaDVKYTdsNUMzakJi?=
 =?utf-8?B?MUkrUUdESXJLZTF5aDhRemkyb1dMcHcybm84OUQzUUdLUDhGclZSb3BnNEtP?=
 =?utf-8?B?TVE1cGxYWUJheUgwZjFia2pCcXZtSy9WVXBGYnBHTnZIME03bUcxQ1pscmsx?=
 =?utf-8?B?TFZRQmZCbVFCUW00NXQvUUxUV2V4K2l6WmV6SkVjaXE2QVJJRkdvMWhBbzgx?=
 =?utf-8?B?ZkkwdzBMRnFPRFBNVnB5ZWdZRmlQMWVwRlAvVmJTekk3cEJTSkhVVy9yUFc1?=
 =?utf-8?B?TUxTMHRXMGNqRUFiNU5uTndIL3VGclhsRFA0dW9xNUpSM2M5eUt0aGZzQW5h?=
 =?utf-8?B?VkF3bGRWM0xvamVESlBsZDlxZEFSeFFUa1U2QTJheUxqQXQ5cHB3Y01aaEZG?=
 =?utf-8?B?VnRGdXJoSkNRUTF6Z2dLSnpzRmN2OThQU3JPcjkrYmpyUVVYSXJBc2tCMkRF?=
 =?utf-8?B?K2txR1hoUlJTeTdCMk1uN3B4OWV6ZTVzbGQxaFJqOWRYNjVGRTBTMDMwTVFJ?=
 =?utf-8?B?aGR0Ukx2TVZpY3FZV21tOEpWREl1d3FEcUxJTjhQSThKbkhGa1VGUVViZ09w?=
 =?utf-8?B?OGwyNS9lSXIybFR6aFVUUWRTWGtoQzhZKzNQUXc0dkRXUldhcm9SaGM0MnFn?=
 =?utf-8?B?UGRFdU8zbWNwY0lMRGNkcE1XUDJqWjhaTklrZFN0cGVOcTRGT1B0Zi80MUEw?=
 =?utf-8?B?YzgxTVhPbHRLUkx0engwZGVJN3VFaStqdW9vVEd0K0N1SlcycDVoS29qRkVH?=
 =?utf-8?B?VWZ5TVlHd3pRd2swcndiRzNWUUZ1MWhBZGhHaTN0dGh2Y3B4R1IvYnlwRTZN?=
 =?utf-8?B?Um5hVTZQMFRtYm5reU4wOG5CNm1yNnpJL2xibGJBS0p4dmRGak1lU3hLUk1L?=
 =?utf-8?B?dVZWc2NFV2JEdEo1VGxvMDZCaS8rcFlwMXk3L1NONTBtVGZmMmFSQ0FJY2sy?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vExJpvztbsDizaatQeJw2FWSQmk27IYKHv3zuzLqkKmBJb91Ya17RgehMsBPZ50zoeuUOrCH+B76DL8aclqZs1DY58cs6SMBlHF5GUCVDFI3FJa+jsDd5V+nfgSDAeSSzc38VjR0ogCez/cutbCad+3o20i5oM1fMQgXV4wmgDapIUVKyzYpcxcYAnqjKGfVzmFQPA50vyXC/VXAAQRRfMCqiYRaKfwImTUiBSyESDDP7GL/9xXceRn10jEv40AA90VFeVPna0LVDHRetbNT6xP0fFHO6A1y3KqoTXNELMp+dsCcsd0M24GWS26e4CjL2aEF6k8G1a/qnc3WJ0M7VP2OWcoYP/h7B18w+0Cw69/o46R3vMakHcYQurU3nm0RUwz56WLjrUVoPS03UTFZNo15Hz/ekX3gV8NwFkC5bEeh7ZTbpxSat6psPO6cRfxtUX3M2tzvMmS52TSm5lCIWxBUS/rstJK7wGcSDVZcCq1ZUxVaeU72w2GiTNPttwxFoH2IvMHG2ge60mTyW+cerY+qeaNSjea6tuKkCbVaJ3Ipj16iKUPow+K61Ij/9GKUWB0JqSN3E2f8ANQdlGZfqngy1Y0cksDQ8CLrr47LCeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4482a9c3-6cb6-4612-0828-08dd617505bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:48:59.4592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wA1B5rJ0h+0Wj2wxSfU8nRa+IxnYZadir0bJcjALOWvFLV2xyO+otvC7q1CWurd2gSbYhuMMifM5YcB8TYL1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=961 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120102
X-Proofpoint-GUID: 8KNf1zZPGXNbF_cyxvjp937ezPrgBDdb
X-Proofpoint-ORIG-GUID: 8KNf1zZPGXNbF_cyxvjp937ezPrgBDdb

On 12/03/2025 13:45, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 09:13:45AM +0000, John Garry wrote:
>>>> +	if (error || (!*shared && !atomic_sw))
>>>
>>> And it's pnly used once.  Basically is is used to force COW, right?
>>
>> Yes, we force it. Indeed, I think that is term you used a long time ago in
>> your RFC for atomic file updates.
>>
>> But that flag is being used to set XFS_BMAPI_EXTSZALIGN, so feels like a bit
>> of a disconnect as why we would set XFS_BMAPI_EXTSZALIGN for "forced cow". I
>> would need to spell that out.
> 
> Maybe use two flags for that even if they currently are set together?

ok, fine. Then it makes explaining why we set XFS_BMAPI_EXTSZALIGN for 
"force cow" a lot simpler in the code.

> Note that this would go away if we'd always align extsize hinted
> allocations, which I suspect is a good idea (even if I'm not 100% sure
> about it).
> 

Sure

Cheers,
John

