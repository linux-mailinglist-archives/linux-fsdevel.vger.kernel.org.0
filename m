Return-Path: <linux-fsdevel+bounces-43821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DEFA5E18A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE887AF1F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F207E1CAA6E;
	Wed, 12 Mar 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LWs1l5O0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NGsrVPTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DB1ADC98;
	Wed, 12 Mar 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795888; cv=fail; b=YBN1qt+B9MUUXPRLeBdbxDZjfu/1wJ02Wql0KTEVkbbKKN+1Rd8BgveLhEJWvX8zovFjyKNT+4RHy5s/POHnrZJ+fp6Y96rfFq4LF5ObIeztZj+fxnvQkYi0VlpJ1ZsAIspOnP10tnUA2lrapc+qFvghogP4OVg7N4xn79R9+KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795888; c=relaxed/simple;
	bh=vJC6CERCXRl/2GQrW0oCm7sl8SHvUXvRropY9z/fGBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WfmgujIB+vGBt6jmQTTBL8iQQJu2zWUNmbUM+0I2lS93JII0ANf4vQi8Wl7qXgbDoXPRhRvFwHgpzEglJHGCOJmmnOlWLcI6AqnqtDnV87lvetgf0KV4W7HrPZ0vg/gmphFP5KSpTEHiqqMgTGAGK4JgW+1MInHmQyWjr1js5Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LWs1l5O0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NGsrVPTm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CBxWRh022618;
	Wed, 12 Mar 2025 16:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Yreyj0xjekkyWQw7dVCYgGeLcctS61el4b1/8zAWdCk=; b=
	LWs1l5O0n1aZZcMiY4gnX8lqL46SK0axOlgpQXp1ApI4pO0dCGy+cU0CZcGM6QHE
	QgJ2IX6amh1oINyULWtDewqx1O4OklCgEiAcNzQZ+zf0/lsFYp8OUUNw1fnCGnlw
	EvF9KQhxVOSt6mjjLVOPJlfY0giH2cG59AbioRsXE4OxTdU28Uz1WSwdhVVysVK6
	LLjaYeYexbhiVOosIHEaJKHw3V6GsAkQhiJBp6KmVCvh4UJpWyFtPvhPcRUyRAX0
	JtNtiwEyRW27BQ05El29KnWmd95AFJvVywdTP3Z4tsR5CWyBnjc0RHyCq+C7I459
	8XLwm+zcd/GlgOZQgAsVrw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h25rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:11:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CG7wBu002143;
	Wed, 12 Mar 2025 16:11:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn7gbfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j106+63Iu/8aNRIToKdRIfrvVUw68Y/ftm5UJfyHOX4rGe8oBlRYnxjz7spv0dgisEyk3QAs0ecA+BDL6uHNeSu40ybGKxPMGlNVF/LLNRVaxEKLJN3OoTllcPFo8ndtx/xg7jmV7ZMzvae0HiR57Itw9FEgxgWC11oOg5djCeTNOjiS3FAxlOsCTGJXKTLO0iedvGqmJwW/puwg89+fFvggCzwa1utdzSND08vv6cOjTFFpsOguEfbBzvFgNgdcpgg6LDOks4UXy4uY0AdpzSTzVtZ+B2QkVNskjjz3nmQaYb0t6bi2W7QyKFmNSi16EeUI7m86CiKUyIkCh0oovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yreyj0xjekkyWQw7dVCYgGeLcctS61el4b1/8zAWdCk=;
 b=drjSkxcRDWD6S7VaVBuqFPuxwXxTrzy02Zsz1JmAWuXH3LFifHqiPFppTDxSST5mpzN6gUIscuNWLaOJ2gw5S83CX9C/VBwCVeU3HPqQSmRFeqlOc/cqsOmE5djU18CTg5pA95fGxrHFsPDnf1fxGa+QNcglXVzrPzlvuuDa1HVNlgevxKDvqEvF1xtqSwcl9A6a/Z/FbZeXhMwT6D1P5A0Pjb9JSTJtX6Xs01s/LIVJRgdN3d3kGkAe84w52soeKRmhu9Vb8Tjr63O5zwHtWGnmu5iNIsAPd9M3eryu/DXc0sqXj45vy/Y6QB4sLcZ5cpEFVzwbQFPdZF3hWAiPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yreyj0xjekkyWQw7dVCYgGeLcctS61el4b1/8zAWdCk=;
 b=NGsrVPTmL5ooSaUOMz0dZf7SwJtV4EEimmF8RwaEqAtzzGb+hF1Aw4mUIAI3tebROFWoBF+zkDBmGbq+PJuD0OKQtOG/M+lkVNaGSN2osboUgs8u6VprsKcd2KtLQL2acI5pS6JNO8ydd7iKlouuRKEu2UBPw8eQmahnYHYZb80=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6865.namprd10.prod.outlook.com (2603:10b6:208:435::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:11:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:11:06 +0000
Message-ID: <c9ebe7c7-69ea-44b9-872f-13755c59b9f3@oracle.com>
Date: Wed, 12 Mar 2025 16:11:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] xfs: Iomap SW-based atomic write support
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-6-john.g.garry@oracle.com>
 <Z9E5nDg3_cred1bH@infradead.org>
 <ea94c5cd-ebba-404f-ba14-d59f1baa6e16@oracle.com>
 <Z9GRg-X76T-7rshv@infradead.org>
 <9337105f-d35a-4985-ad21-bf0c36c8fd50@oracle.com>
 <Z9Guj3oZPhD2LLjt@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9Guj3oZPhD2LLjt@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0143.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 6517b56f-e655-4246-bd89-08dd61807e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejhHcDdTZ002YUlGSGFKTFdQL0hyM0FHdHoyTjhRdEVlOFlGajRoMTlhdXgz?=
 =?utf-8?B?elovTFVWbUVGYTRLU01KNXAySmYwTWJ5ZUQ3UnVETW9FS3ZOOUhOblNVMFFW?=
 =?utf-8?B?WTYrNHF4K0xEK2x1L25hU05BSXdpTHcxM2M5My8vdzZFRU8xVGxVK0ZxTUJB?=
 =?utf-8?B?S0NCTUw4dWhueUdLSlU5VktwNUNKbGJ0d2FLSjg5VFg2ZHlmTzBPbk9BejZX?=
 =?utf-8?B?bnRxaGJjTnExbkpKUk5BdmNIUklGMHFuMXZJcW1Ba2ttdG1uSFJKdzlENlhX?=
 =?utf-8?B?ZlJiTGNzaDFpczUwOGNYQytBaG1HT0pmbmJKeThubjFINTRrNG5xaWw2cmFS?=
 =?utf-8?B?Ry9RNnAra3luQ3lJNkVwUzRvRDY1VnRwM0ZTWGYyOFlhRDRaMW0xSkx5ay84?=
 =?utf-8?B?Zll6UGI2Q3FtOVJUOWtjWnp0L2RSZmlLZXQxdWtaWE91cExadnJjRGl6Wmwr?=
 =?utf-8?B?TFhiM00wMWZCSEhnOFpXRE4ySStHV0ZtbmtlSDJkeHFpQ2QvZncyWnB1bktk?=
 =?utf-8?B?R0tJUlZOQzI3VGdBTXZvZ2dPZFhBNzJma3RIWjZzRnh0clNpdW1vc01EdHZO?=
 =?utf-8?B?MUNJY21IM2dQcHBzUjlHNlN5UExldS9sTC8wUUp5bGcwTDRXd25xbEt0eE9a?=
 =?utf-8?B?R2RKVTIwYmVQZ2NFREN5aXB1SS84M1FaQzF4UGRnL2preWcvbVN2ZTF6SXZu?=
 =?utf-8?B?Mzc4c0dFM2pqcm5IaFlrWXg0dmZOOCtpOFlvY2Y1SFVGMGRkMVRrRWl3K0sx?=
 =?utf-8?B?RkxpL3ZKTDJyM0F5MFJpeTFTbUUyenlZemYzMVVFK1RQM1NPcCswSVhLY0cw?=
 =?utf-8?B?SUhuTzdoSDdXUEZYMWhYVUNDNmNOK1AxeWxGTllyUzBodmJtNmRaOEExMlZ3?=
 =?utf-8?B?dGdiYk9PcEV2ZUY3My9rV1ZEUGpsNEFDcHA1alVaNDdBdUlzL0FWVGl0S1Bn?=
 =?utf-8?B?dHRpUmxMcWJ5TVM3S1piQVg4WjNleVk2WlQwYjh4QndxV3cydDUrVG1BL0E3?=
 =?utf-8?B?RllKNFJiVklGVEJEOVd5a0Zmbm9TZkNOblJUQ3JyZXdodWFyM05jY2ZMeEVE?=
 =?utf-8?B?SlhGZlJpbFJmM3o4OFp3eSsvWXc0V2JyU0ttZHRCaFNYSDdZWENsNDB2dHk5?=
 =?utf-8?B?QU0zVVNCcUpUeURQM2pPWHppblNYcjFkZ2ZuQmpCREZuV0h4anJkQmZtK0Fl?=
 =?utf-8?B?c09PS3NPbnYxaEVsWkNqb21mQmIzU0RYQkZIaWpuUjlUa0R4VUxmcHhsUW43?=
 =?utf-8?B?YjdzQ1I0R3RxVEYxckhIS0RISm02K3RTUTJJZEpJQ3h4SXY1dDdGSWpyV3N4?=
 =?utf-8?B?VWp0b3dqWjBRT1NjL1c2di8xTXpvRmN6QjIyOVZJM3BwUE9mbnRlQ0dnM05C?=
 =?utf-8?B?NC9LY0h2VC9XWGF5bTY0YjdKZUtPeTFFUkNLMnlDbm1sKzh0N3FIWWgvTHF3?=
 =?utf-8?B?Q21MUUx6T3FhUXZpNmcyV3A0a1I0K05iVGFUQ1QvRTZqL3JJMVhBcmJ3b1dj?=
 =?utf-8?B?R1VTY0pJeHAxR0YyQU1aQllzVG5rQkI3Wk9iYnBPbmREeGtVV2lzcTlaQTQ2?=
 =?utf-8?B?Vzl0N3hhN043QmYzU3o1WGF0ek00WjR0aU1na1lQOE5xcXdibE4ycHZHd1Vr?=
 =?utf-8?B?bWl6eUdXRElsZkExQzlndTFDSTFGMEwyZnprRHlYY2tqS0k4UzNQWEdKZ1JN?=
 =?utf-8?B?M3FuVG9OMk9iQU96SHlkRTg5M2xSdFVjTGNKV3NSYkhuTG1DNzljc2Z2bE9E?=
 =?utf-8?B?bW0xbjZZbFNZU2JCeER2MzZVcmZPaEtYMjRDOUp1KzBwY1pzUnhTZ0h5L2dl?=
 =?utf-8?Q?6Y8MI3HyPB07gwJTCeVY4I1A1udOOCT/eorfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1ZFVEZ0VkJMM1o5c09STGk2VlJxSmdQZDVMOUhWa0R4TENUNjNiTm0vQndW?=
 =?utf-8?B?OU1FempsVmdHY202dmNkNFV3RHRIK3M2bVZXVlZ4WThkTFNGZjNJdEtsamYw?=
 =?utf-8?B?SFRib2ZQYlR4T2NTZEV1MS9zbWtGbWlldGpBTTh2QkQyRWhNNjhZdXMrMW54?=
 =?utf-8?B?anpjSWN2SmJVZXRuOUlFQndwb1J6ZUJtb3Y2OHpaVGtGeEdwTGJOSzVLa2d3?=
 =?utf-8?B?RVFRNnV5OEpxRzd2dlVtSXlyNzlhak1ZSCszMjQwMVRyd0tUSkVpRHo4Z0xs?=
 =?utf-8?B?enlsWUNCRjdkUkpRUnhrcW1wcXdzMFQ1V1QramtmSWlQNGVVNXVVcWtlRWlD?=
 =?utf-8?B?eVo4bldjZXd6NHhVdkF1YzVERG1CQlJBR25RUVEwcUwxL2k4MzhHZjJxbTUw?=
 =?utf-8?B?SVZHeTZhWTZyOTlsM0ZSS3htZFY1cDgyTW5DNXpmYmU5M3Rxc2h5ODArVXpI?=
 =?utf-8?B?dm5CUmlJWDBJcjRNdXR4eHd6d3dEWnkyTEU5cE1seGh6MThIR1NjL2k5cUxp?=
 =?utf-8?B?SVZDOWpIRFBNdzZhNUpKUGVlQ3Vsdjk4bmVGTUJQOE4vQ2J6OS9WTWpDRUo0?=
 =?utf-8?B?bE5ORnVIRDYvbXJ1R0lVbG9nOTJDeEJLd1lyZlVFNlRvWGRtOTVDVHgvd2s2?=
 =?utf-8?B?YThuMSsxTzRmam5QSXNzVW1vTXA4bHdDME4wd0RicndYMFM3TXVOeW1yR1lu?=
 =?utf-8?B?WVVjblBHZkFSWXlVTU5WK2N0NUxYOGxJZXhQU2RuMjFKajBveEhTeDJTdkJ2?=
 =?utf-8?B?YWlQNXhlQ2tLdzNKVFZUSjJNREVCWXBMU014VVJzaGxTZjZWTUE1SEhYNEVS?=
 =?utf-8?B?T1dBQWtFczdxMGZ6dUtxdWxHNjl5VmJ6VWl1UGg3MXVOdXg0MDB4VFJSOHpa?=
 =?utf-8?B?NHpzK20wOEx4Q1A2N21MclJxbkM2V0VrRUY0bVRJS2t1ZjczRUN3WXRyRG5l?=
 =?utf-8?B?c2FQbHF6NzZYMk1qTGdhTzF2akJGeFRMY2NmK2FzeWs3aFZQRTgxQXVSL05R?=
 =?utf-8?B?MEpvK1R6NU5jeTc5YzlBaWJJQVFzcXEvZGdNNlBjaXBKYTV4RVovWVJtdGVL?=
 =?utf-8?B?dDN3U1ROTU1sUW5vcWVkWnFIVDhJd2cybHlWdVdhNm1rNmtkNDNFZkdtbU1l?=
 =?utf-8?B?YmsxSFlScXZsYjhBSkExdnZmQVFtSlFFSXRFTFpTWSt6clI4Q0RpT3VXME1Y?=
 =?utf-8?B?WXVPQkMxMUlVc2VnUWxGQ09NdFk4TVdyYTNrKzNMNjgzY0pFU3Jka3BXNWcr?=
 =?utf-8?B?TDI5ZXBMcjc5dStza3hIQzVTOUpQZXdNYTk4U2ZQdFM0SXRQYXlaUGsvYmx2?=
 =?utf-8?B?WDRmdWJUWlhUdC8vSGJrRWVjSGduRTFHL3YxMlJCL0RyL3V4aWlmWlRVREJ3?=
 =?utf-8?B?TExlRlloTFpNRXFPdTd4SUNSZnBXMXB2ZjRXbGRsS1RhK2d0V1RsNy95M1hP?=
 =?utf-8?B?Y1NQZitwUS96YWdDZTkyaXA5SmhXZ1Zpa08vdkNqKzVhcXkyeHU5Zk13dlJt?=
 =?utf-8?B?S08vdW01ZVpaNU5xcG9kTjJHR1l5Rmo5UHhqbXN0K0dJQWplbHNGZEp5TGVD?=
 =?utf-8?B?UkNUWDJhbmhHRGl3N3lXMDh4OUhlWlNlSjBHMzl5dEhXUitGWU1uaTBvdWVr?=
 =?utf-8?B?QWJlemtEN1lGZys4c1A1QU5wVnFOb21zY0tVckhwVm1tSnN1NTJXbEtBMytG?=
 =?utf-8?B?dU4zcTZWZ0VHNERTcExZNFBVV3VhKzlLZnFrSlovbXUzR3FMMVU2TDV5Y21U?=
 =?utf-8?B?ODhZZ2paaGNHQUczTGNkVS9xbElNT3FyUDcwOVk5NEVzMlpkcXZxVjh1VE9Q?=
 =?utf-8?B?THJ2T1AxbUZjZ3Yxaks5dWRhUkpMNUk0ZHRtcFJoaFpvNUhUV3ZRRG9rZVJm?=
 =?utf-8?B?MkRKUERBbzB0TkJpQnhmeDFRcGtlSThranFoekwySjhVQUJmN1NnYTVzU3Ny?=
 =?utf-8?B?Y3N6SklNT2lySUw1S3JReWVySlE1d2RrOFZkWXBzcE8rMHoxZkhPVkJiMWVv?=
 =?utf-8?B?Z1NOQURya1FDZ2phRjdwTnljZm1EMUpzY01RbTVEMGR6SndyYXFLZmNBeXhu?=
 =?utf-8?B?VlExa0pxKzFxZ2F3OFRyM1BNaW5lTVpreUtwK0FCcWpBRE9LV1QrSW0rMFhj?=
 =?utf-8?B?OW42aG1lcjljV2JscUpUT0FhbVNrK0tjeWNuRDNrRVRIREV5cW41YjErNmJG?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HY5dG7po5Gse3IlzgubxS7Y/fYkfvpC+gAspd8FyutAjc15smTT7Os5M40Dmx9tnSaGT+vw5++4vKn2zvEkBwNKGQhL1C5AFHZ5n8/oyBv9zv74YR7fjf8NuVrKdo96tDZR/sIpDNA3xFUYfCmDnDWarIqKRZKDw0P0WjzF8MMEJr9ggcXVa/1ZAhigr8r0xtG6LcHy1MnKySgP24eI5hNzkO5KL2j0ilrsfmUdMPIFpsMs+3pC8XNVG7IeQ26kUwl3MiKH+Mr7ssUl4cDDGhoF1dTe59Zq0b01z71B54Ik0x+H06lhSyJ9YGPRkhMUTZN/hzYd+dQxX5rbV1nds4nHQx9FUVsm/WEWSIxEDcpDpV7kNHgbyJqInTs4NGv5GoPI3WmBs/hyv+cTGCzpYWX8OyDUDdws/hSvrqGL1f/l/mIblS8O9Gf5lCpyoOXcPqteMyuwLdxA4TO9pAXheiZpyaMFaiivaYHvpF6zj0niS8XGwJ4M39JQzvF18pEXuT7jz1O5wsNMW5lYc0Ne7FWy1eIj8uVQ9XFci080r108eJSvU4mIWhRpMviSF3PIe3KH/DY8sOMA9QZbgwECbS5JzCMugJYOEWx39/Hd0zx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6517b56f-e655-4246-bd89-08dd61807e27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 16:11:05.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUXjX27VbbPUysplXRKr0ACGkYu9zlUg+8ew0vl3CPIeuv6VEnNFsc9EqMAlJHr+toxjbDTUdiOX0oFCUTKO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=807 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120110
X-Proofpoint-ORIG-GUID: 8aho7ys2PVyEsS2QAaFyx0ohI6MPDndr
X-Proofpoint-GUID: 8aho7ys2PVyEsS2QAaFyx0ohI6MPDndr

On 12/03/2025 15:55, Christoph Hellwig wrote:
>>> would make the core iomap code set REQ_ATOMIC on the bio for that
>>> iteration.
>> but we still need to tell ->iomap_begin about IOCB_ATOMIC, hence
> Yeah, ->iomap_begin  can't directly look at the iocb.
> 
>> IOMAP_DIO_BIO_ATOMIC which sets IOMAP_BIO_ATOMIC.
>> We can't allow __iomap_dio_rw() check IOCB_ATOMIC only (and set
>> IOMAP_BIO_ATOMIC), as this is the common path for COW and regular atomic
>> write
> Well, I'd imagine __iomap_dio_rw just sets IOMAP_ATOMIC from IOCB_ATOMIC
> and then it's up to file system internal state if it wants to set
> IOMAP_F_REQ_ATOMIC based on that, i.e. the actual setting of
> IOMAP_F_REQ_ATOMIC is fully controlled by the file system and not
> by the iomap core.

ok, fine. But I will also need to change ext4 to do the same (in terms 
of setting IOMAP_F_REQ_ATOMIC).

And I am thinking of IOMAP_F_ATOMIC_BIO as the name, as we mentioned 
earlier that it is not so nice to with clash block layer names

Thanks,
John

