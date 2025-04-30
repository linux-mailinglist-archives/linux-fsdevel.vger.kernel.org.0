Return-Path: <linux-fsdevel+bounces-47726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D7FAA4E34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 16:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3983D1C08007
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF925EF94;
	Wed, 30 Apr 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k2TEszTt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TS9yyAVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4E1E98E7;
	Wed, 30 Apr 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022468; cv=fail; b=dw00x9OQ/xWUeEbdbPOekBIok9k25GNxDtK6wP2SRiM7N0UKcizUxvIAbKglSWrF345bpyejU+K7kWhSle+woK+vaS4k55wZxEfyaPcq2eaaVLhOvsxGIveWlPHyOwZ8GWwlD566QTnv5klziBtLdhsTPTdCmlo7HqzpUaWjOgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022468; c=relaxed/simple;
	bh=Xfvb+pea+CF44kmQiWcxXmn00WeWqcqsgdNqP33PQpo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hw0WbE2uYPayPP5qpapu0iicAl4mg9HpfNnKuQNXPUob6kgce3p5KdJZ238WccBcUniHns9ot4gxCGrI4OjGY6vRRIV0XGDc1tngCuhAgDVDBwPqlhsJ0Bv8yeIbDyi/NQciL4skN5Do0DuSnal/CRsPcwdj7JdlNKd8P8TgbvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k2TEszTt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TS9yyAVg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDaidJ031897;
	Wed, 30 Apr 2025 14:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Xfvb+pea+CF44kmQiWcxXmn00WeWqcqsgdNqP33PQpo=; b=
	k2TEszTt6EI//SdGMU0Q/02o+KV0/WwFSxzl9UWyQqIyxDnUeS8IO6bj0qpQTC/B
	lYkO59mbBH3iiMJjc/T/ImU9Ptzh1ObT6fiO+Amdg2g2T5lVIhwRT2rXWnrqKA5X
	t9GhVXnQkMO1ujVNNn0yY2avd/i15fZKX+WUokUmHnRAEQs1uBWerkbMvmJ7Qi2c
	5i542aSk3bozqNkuZaQ8S9ocYc2cNbI6kUelK7X7z6YzVPWFjnBtbXl8WQ6VrYfd
	6RcTQx4B5ini8SXB+kWO2FMTc7CaUMA17luB+oxiAGzPcysp99CvsdgNltn0FAXv
	eh4/RidCdclhF95VV/dmzg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ush9eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:14:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UCZ9hb001443;
	Wed, 30 Apr 2025 14:14:11 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011025.outbound.protection.outlook.com [40.93.12.25])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbbyq2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:14:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6Ih/nLnmTi2wItSmKzWaKHmqCEPdX5/HSG3Lu3jlg3GogQyAoUaFiLlwdAkhoR1P4TFNhBS408kEsh+GJVoR7ABgop0Bius8NrMl9VnnS7N/JAmbEo9dE5AwSRA20sFb/vbgETcF1pQ0fbItvucRwP6v9ihPHleMJQzG/iW+bvDTp4CKRYeZ4ozzeaGd5vFrG3wFMdeBU8pLrh65SvT2nv+KqsPCmOGxhnCUKXM6uS423XIUjrZLROfbR2RWD8zFcJOLpcwBRO62lgqjC1gA8LUimzdsJM2uWaIgyJwYOFBwSKrpVSJ96Dk+VR5hX54gic2XVStrzZvNC6Y7rkoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xfvb+pea+CF44kmQiWcxXmn00WeWqcqsgdNqP33PQpo=;
 b=sUjC+DkMpCZLMdmxMguDQgTaivXNBprHes8zixF4Y7QiLKnYDtXNLEwaNNn5v8buc/pbzaUIPNjry6NBdK2dz9k2Nku4XgwAU5ULVHOkZkzToMxtjcMjW3jSzL48D0IblZUHt+ap9UCdz8VnRYPaQMAFmWC/mxbzI7Qt2Lp/38uTRev1e+FRTH22d/P9bwUqJbwyYpUjsvEq/vTrAPCdiaOnL0iQ23X5nXLYZcddWaVeGP5yPziRxNjQ2JgY5G6v1j8+UYLJo9gOolpCnHiZx4UUu5kSjFrW7vIA0S6xnTms33xR8LTFfqdcCXxV/6Yvxx/LFNFuwRlaCZKYgavJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfvb+pea+CF44kmQiWcxXmn00WeWqcqsgdNqP33PQpo=;
 b=TS9yyAVg/iGBJnyrkJyy8KD3R2AGVFGrt4ftDEJi/G+m3jMYYqpeGLn0YPk4lfjazPyanF3kPt9HSQOk7qajI/CsVNPp19Qv8Zgp7+3cHd9LgWriaaEcObyKnBkAYQ+Y/V9y1zWgafipjO36Mrypl8N8LQSp/JvXk5PgIZSOWtE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 14:14:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 14:14:08 +0000
Message-ID: <972bd2fc-4dc9-42d5-ab05-dab29fd0e444@oracle.com>
Date: Wed, 30 Apr 2025 15:14:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/15] large atomic writes for xfs
To: djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4614:EE_
X-MS-Office365-Filtering-Correlation-Id: b59ef844-514f-4446-d6bd-08dd87f1457e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVRiNDZMam91akszTkl4RUpUb09RMVJ6UEtoeVp3Z0g4ZHNMNGdEME50dFlj?=
 =?utf-8?B?ZkIrMjVFMUd3TFRTZzFzSVpaajBJNUV2RGxiLys5Y3lKUCsrL0xrL1M5ZnMx?=
 =?utf-8?B?L25HUjI3SUtrZCt1SEJNQ1hYbGkvTWorRTR2UjRLVXhuaFliZ1BsOGZHR1Ir?=
 =?utf-8?B?U0txK2w5Y25BRE5qcllPVzFrQnNrNTM1TGp5ODVWVDEyS3NUeng4emVGOEcv?=
 =?utf-8?B?cnBtNlZEbmhncTdqeHRTNmwvZXJkQmlrRGtYMnFnSG8wS0FIUlNsOGxMUWJm?=
 =?utf-8?B?UjZNL3QzaS9TRkRaUHBkVnN1UVN3ZTVVVlB2cnBkYkhXWDBsY0VzbUFvQnlJ?=
 =?utf-8?B?cG9Dek1aOHZJYWsrVUg5OTcvSm1YMkRnR0NhQmFUQ05aaUcrWWozN3UrdEhy?=
 =?utf-8?B?NDFtdzFYYnM1c3J2V0VKZDhoZGQ3cmpodVBLUGc1Uy80QjlkWkFBL2Z6OVJi?=
 =?utf-8?B?WTc4dm1LTjlkaTRQWUpGQVFtSmZjTEpseUN6MjQ3S0prcmtrbWt6QW0ybnBU?=
 =?utf-8?B?MFEwQ2t0NXUyUFh3ZktveHhzc2lSS2dWQ3NxMlpDQVhjYlFFV2xjdGM5eFhh?=
 =?utf-8?B?NDFJM25GNnpLRmVOSGcycUlvT3JnU1FvQXpEbVBlaTZmSHRaUUx2ZzMwRlhU?=
 =?utf-8?B?ZElmcTNVaW9RRk4vVE5kSWM3ZDdteFJXblZJd25mZkE1cWhHQm1ydVhDNDFw?=
 =?utf-8?B?UjF4SUVJQkFyUUtsNExQeE5QS2x6em9hcmpMMkJQeVB4UkxzbEZ2YWdpMDVw?=
 =?utf-8?B?OVlPdlJRbHpYM1MrUGxDemt3Q2hCOVJJV3JRU0NEMmRQMFYvdmxId3hEQXRY?=
 =?utf-8?B?Lys1NWpzcDE0bjl6Y2dmcWxON0loSjV3bmdQT2dHT1cvdGZjM3MvNVc0Zkd1?=
 =?utf-8?B?dTBkZFdHekRWajR5UkwvUHk0bXpIOTdSekwxSzk1UUlhT0czTk4wVjhGY2F5?=
 =?utf-8?B?Z0JNZVhiU0FXSTM1K2loWm9mY2x1RC9vbVhEdUUzMnhuUnE3S2lmNjFTRzha?=
 =?utf-8?B?R05WN2wrVU5ZTGs1dU43V2Rqd3E1Yjk0MXlGM1RQUkRCeXpGRVBpMVdGK2hX?=
 =?utf-8?B?K2JhTHA5L3IxTG8xb1p1VzJEcS9yMkpJUElGT0hRT280TUw0bDAwMGc3N282?=
 =?utf-8?B?c1ZMd01MVFBNZ3dMdFF4eDZnRGd3MjFHQVdwUFozRk44ODNiWUwraUVRU2tC?=
 =?utf-8?B?TzZnY3ovUm1TbDZQQkZDeDVaR1llNER2TzM2OWg1Q0RwV1RERzBUSGUvT05V?=
 =?utf-8?B?b3NuVGFmeFQ3V2pnR1YwN3RRTlFkYjdZSjJKRmIzZGwvamwzaStiNHNOWXhZ?=
 =?utf-8?B?VG0wYVQwQStyOHhjd2pGdVRZREJqRW8waXd5UTBLVWcwbHFUVGZrTzFrZ3NP?=
 =?utf-8?B?WjZCZzRHSGJIenduSHNzOUZVWVJzMEJQZFEyMkNaYUxyU3pXNTZ0cUI0NURh?=
 =?utf-8?B?OUlyYmNteDNlUzEySnNkYkhBUFNqalhGTUtLMVY3cEQvWEVoT0dLWWo5QVEr?=
 =?utf-8?B?OVlqTFU3MUdRN0JYQWxGaTU1VVIrR0pwNDFRanJQS3Q1UnVleEFwK3M2Z0Rw?=
 =?utf-8?B?VWtjbFRiWkV6NGVCcFE1TFU4a21iekJMOVljcDNGMzBPU0l3NVo0M1hoZXVO?=
 =?utf-8?B?MGlpQ0NiT3BNNk44S05ubi9TUkRQR3dOYXFGYjg5R3BuQ2FpOXhiUk5xSDVn?=
 =?utf-8?B?VTQ1Z2JtcVVxeDNiRW51Q0hGOHZEM3hyZTd2Tkw2d3ZGTC9Pb3cvVk1hZ3V4?=
 =?utf-8?B?dWxsNkZDVjkvZ0RzVkpvc3RueDZGRDR1aEdHT0ZVV2tMalhrTGlYVnlDRWVi?=
 =?utf-8?B?NU1tY2pOOXJlZXhKUzNXZ2RJSjBDZGQ2L2pSSWx3Z3FOQks0MjFnK1kwR003?=
 =?utf-8?B?RnFGRWRTTnNodVgrWkVKRjN5QmoxSDRuNjF5K0R2MG44MWs1S0hnVTZrK3hz?=
 =?utf-8?Q?8Z9GuJD92kY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGtLQVp5amhGSnhYUWZHenVQRGF5Tis0eGFDdkZzeXRISGNhV2MxTXBlZUxR?=
 =?utf-8?B?NVdzZjA1Mnptc0F6ZCt5VTVORVRmNzhkc0M5VlNSU3JYMGd4RkRWNXdTVStq?=
 =?utf-8?B?WWdLVnc3SmZ3VWtKZ1daK3dwcHVvTDlpclNDRzZBSEsrdTduU294dmR3QWRM?=
 =?utf-8?B?ZFJrenFTM3hsekt2cHR1YURUV254UlBKdExwNVZKWlp3SXZyMERldXhiaW1U?=
 =?utf-8?B?K0lQOW12Smg0RHVFZVJYUTR1dnc0M1FxcHlPQmNJTFl4N0JtRW9rVEZpemxJ?=
 =?utf-8?B?MzhFa1RlUkhqM1RzU2U1UjJ0aFRKWllDUzgybzlFVUcwdWMzNitVa20rWDZk?=
 =?utf-8?B?MnFpcUxmUnJadVpCRll6STM4UENRdTJqYmIyR3FPaG9IUUpRajF1ODZqR1BF?=
 =?utf-8?B?NzZqMGxpeUNzL2RTcXJEK0xnYkx3ZkJaeC8rTitkcVovQmxWeXh6MlBnT1o5?=
 =?utf-8?B?byt5eTBGaTVJWXh2S3RJNzAzTE5ydisyTlZJTXROUVZGUnNudlJ5L0gvVlNo?=
 =?utf-8?B?cDg4UkNWbUNObkx6WnloSUNKQTZXTWVTOGFjaVlKTUk3SmFhcWozWGJ2MU1o?=
 =?utf-8?B?Q1F5bnppUUZWS1RMSlRJWGJaWVlEYWlNeGNLYXRYNEZNZXgxOGVhV0hjdGNC?=
 =?utf-8?B?TU1vN2pXZ2ovSm9vSmh6YWdSTkhiTHhiT2RMR0hJT1FMZlRWbU1tNWFWQVJI?=
 =?utf-8?B?dmo3TERZWXRmdkZIZlRBb1l0N01CODJxcTNJY0poNUNBenZCYkdnMkw1cVRu?=
 =?utf-8?B?Q3c0MFFDUHEzajcyWkVseUo0eW8vNHl1NDhEalNGb1lMbHhVcUxDTzgyQjl4?=
 =?utf-8?B?Ykpjc1pHT3lERzY1VTBwODNHNm5FbnllYjRaTFhUa1ZDRU91UFNYc1g3a3R1?=
 =?utf-8?B?WUE2V0ZpZzgzcDVPcWFsRkVQMUtCczZMSDA2RXFjQll1cEUwdjZ0QTA5U25Y?=
 =?utf-8?B?K0J6RkgyV1FIUXplTS8zeG45RjFNclZybkRDRkxNem9yRzFkWVQ3ODVpRHh5?=
 =?utf-8?B?bUd4R2xnSXNLTEtGeS9RRnk0VHhacEZhZDUrL0FVNm1xc2dFbzN4ZWFpTXhv?=
 =?utf-8?B?U0h0Y0FxVmJaYXVFQS9LRXpOa2k2dERFRU5RRmhXNXQzQVZreC9zTE9LTFU5?=
 =?utf-8?B?akJ5Z0JoQnF2V3VmN2taOTBmZUM1SVpGR1gyL3JkREw4eThpQXZoTUhyTEdE?=
 =?utf-8?B?OExZMnk3WjkxaEpDOFovUGVvdHhZSWFaRC9zbElxM2wveTAzc3Mzeno4N04x?=
 =?utf-8?B?cjg5ekw3RDlCZkQyaHRNZEsvVERnWnQxN3gvck9qN20zQm43MEtvWkIyUzlE?=
 =?utf-8?B?bmhQSzJqQWQvY3AzTGRmWmRZV0FWL3ZGRTB4b1ROZE41S3RvQjFUNndDMHR1?=
 =?utf-8?B?WUxhYWtTT2NJdmRwRlpkL2FxRlZUZVNBS01ST1lpVUZ1NjhZVzRLTlUyN2h4?=
 =?utf-8?B?MERackNmS1ZhQllFVk9SQ3B0WG9jWHVBTXpRY3RkOTFtK3hVRVkwS3FOMTlu?=
 =?utf-8?B?T1dJd2toQzQ1OThGcDl0aGxMb1dZZEQ5aCs2ZDZXck5ML01QcmlpSTV0OFli?=
 =?utf-8?B?eEhqTmJaeWlXcGxqZHUycWM4bXpta1I1K2UzY0QwTDZqOXhKcWVwQ2pURXFs?=
 =?utf-8?B?SUxoRDE1eC80WGVtRi9KRnlXK2d6Q0w5cEc2MlZjT1dDeTFGZ1JxUW1rSUtD?=
 =?utf-8?B?ak1nZWYzTzRPTzhBK2ZWejZvUzRMdHg1UGNIWjRtakFRZnBSZGtJbEovWURX?=
 =?utf-8?B?Umg0VVZaMUlMb0paY1NVTDgrSXVPWWdtSlF1endMZWhUYmlsSCtqUmdjNFBo?=
 =?utf-8?B?YWk3VG1JQ1lPM2toZjBHMHhtQ0JJUkc5VzVPUy96d2k4aXJKTzQyKzlRWXR0?=
 =?utf-8?B?Mk9YUGZjcFRlT2htSlIrWVZPSkd2WWl3QTVMRVVJNC82a3RZWkQvMFNGdGJ1?=
 =?utf-8?B?M3lPWFRzcmdWZzl1L1ZJKytZZmxXQTNQRmJ4K2gzQzJiUUdiRDlHK28wQ3Ru?=
 =?utf-8?B?QUhuMlQrenJuQXlPVGt2enVlSVZaMDZONEpBNXhJVDVFeFZKZUhoTUx0aXB3?=
 =?utf-8?B?ZStwQzgxV2tRdS9kWWk4TkI1eURqUkM3VlNZdlVqWGRKQ3A2dkVvYUpBdkk1?=
 =?utf-8?Q?C6DImowZPduMRbfRS6qfiXVNf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sD/m9pNK7Pbm85PFjAg7xFVZXj4nGDAcEYVYx2lFPYv/+npap4VI/LURWONFAgtbrAztf3kE1cwfGNecHvN4l4p0ZQ8IR8WVh5zGWAfsOCR+Hj6Z4XaJ6Fv5WcRMmEHS5mnCAZdIOFDqvjJ9QoaGHsCz4ggFvLSFCULj7KMt76JXYvYswNozkMLVtYs/KXdtyGi+aiqoUlMEQcyjU99YFk8NbjDigupvVRlPDrkTCptNnT/pm2IwcpPLIlxY8hbeMZBq32vt1yJj8Pa8kwlqPLg7aUotJty0I/jrQfEKshZaFE5Q5uROF/a9akiOSLUaJ9Hoki1ccXMHo6LTKdXtZ+fLGlCtLgt4sRpTrY0BxEF7TlkNopDv4nskGVb2rbT8mAohD6FQFc1Dgb41vZBSfGT2L1Pc8Af8PRhLX8/F9oxFSmemaj0Up0KFbPKlIRQlXJrvjDM7SOrHycayFCqqJcpVEkJlnSkj0/Sa54Gyvvrx7L0S5N55MDFUKPCD9RQvdlEOXVtr99VziYmd4je48JKAgoNpLoHvD+/swTXk6ZVlEUlruFXKWIxQOI36DRlr56P8bbutYiRwZx1d00V2DTKvTQJdMubmTlpZHPmKo20=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59ef844-514f-4446-d6bd-08dd87f1457e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 14:14:08.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TbSaaltCdggWZI3HQioilDCTEPJ6AQb+ydGVeUkTv2qmYP61NQ8lOQXwFXQWV3lgrIX1zlLvKEUK197lIJzJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300101
X-Proofpoint-ORIG-GUID: wEDr4pObHOM5eBNckvkvYH0JhTCHZzzZ
X-Proofpoint-GUID: wEDr4pObHOM5eBNckvkvYH0JhTCHZzzZ
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68123035 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=rwFYekU71rPJ9pxupQYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwMSBTYWx0ZWRfXxNMXsyCfr4hf c8PjpAJPlYVOUC6tr0hRee0+qEMo6YYu7hqajmocdZTizCF9z5FmVgzN0/gKoOt1t22cQSo7cbh WkryqqhmFHlwKCGyuZpyDysuFQQZtUNU4OwW9SDX++HY9CTjfTiCVDYMfTZW2mFXONbr2ohT5jz
 /rVtaz8AJI6uNFsvC4ZX0/TXnJ0FjRqy5AsBLQQffnFGF47liVboWIgOjSnAzg8luNLcpAOEwFB HU0pq7U9I8Bg+2iBFchNn9CF7bNCbPzvBHY9flDEqUY68ownHtFM2k9l5L7cjMev8oIqETkUgbm 5CT/Fb76b4HNDKgPXDpNfOf/CDLPIUWtNKmBkw+pOvLs8EPMluf/78H6FuEnjTX0usyFjm0DE0M
 MIAisgE3EetplXfT6EjpQBJts3Mt/iqH9vUR5OjnDC25cQiIrXQoOQiS5HvBYt0mJuPy6j3h

Hi Christoph,

At this point, is your only issue now with
05/15 xfs: ignore HW which cannot atomic write a single block
?

I am not sure on 15/15...

Thanks,
John

