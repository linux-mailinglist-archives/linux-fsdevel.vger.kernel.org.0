Return-Path: <linux-fsdevel+bounces-32825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131619AF552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 00:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93690B21681
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA342178FC;
	Thu, 24 Oct 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ggam2N5w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tSXnaW5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AF922B66F;
	Thu, 24 Oct 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808636; cv=fail; b=Ie1z2GgrVo4lCSf3t1VvIMPvyv7OBtTzhQRln0IHKBPyr4ZT/ZzqcZiEoBU//oN7nU8AfjmM4cNomqg0V7uFnVshqaCitUbpK/LK92GxW+pnbbq5tfbrgl8RqnW9lyXViYyECmfJMtce5/pFKlp6egSue540cFP4cKccCGApZdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808636; c=relaxed/simple;
	bh=0ZWu9jQaMxqpPnYyNN1bcZlTuZ/BvLf/UeuNUwfnrFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ApyqIXJL5lLFMHuGcxen5qhmW5GecVsx/L1UOZWLp1OsVF4uBb1ZieFcyB27ItBw8a2Yyh1WW0mlMDUiS5Li3yZKYBrDc29R+h//Nvv+1yA49/ejssMNWaRr4eAPkQElp95KAGdgsm08c/u8ixBmmuV2XvYRhkqLw99ECrikIo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ggam2N5w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tSXnaW5b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OLMXn0032545;
	Thu, 24 Oct 2024 22:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=W20+Ef5uqQ+1XSTWt4yv1FIM+KZbmlAz1/BcqVoNmVo=; b=
	ggam2N5wt6N/qDn7psWRRI+4TYXxKV7UucfszX9OBKMOVC4taZ2CNETX4w77Cvg3
	2aNje95w5wohzErkhGKrQ5nXAx1MhGF36h0RqeijXz5styGNK0WsZa9SaOLeeWFK
	WsyngVao4pNju3wexMV2s1nqjRN1ZB2mnY/MM75jVIzDjY9X6Km+0mnlXxTTztDS
	yGjRZKOveG5VQ29ONfNtvt/9we3isRmybsqiopx62XNut+2polrh/GGpRVHXuLDR
	1z9cAuR9Zxl7xfhEGPmDcGDDGiwibCsm3bLwP7sGPBElIULwX+qvulLum86XCYXi
	ymTnvAM9w27R5B21pOGIUg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v3tb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 22:23:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OLHM32018362;
	Thu, 24 Oct 2024 22:23:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhmn89g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 22:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbHXvjk2Wp+oPCBfJnCY/zFaCuDE4t4Z9f4nJ56hB7S9V/srClapjz8I1loi6mINyS/pC5r/OWINt53Nz6I9fTx7icZ3FIVs+MvIMq6zjkvjZ8XuO9NfLnbztwD4NiVs6Uz4yQxyHGXJZ9w9mubd6citEHuIvyRvHCjdxBjSywLt63j8OXCl9SO2v7eDNPVSzMdcRrFkIY6m1C2MBhi6/KeRrFQM/sh3+7dAuIrftEh6JRvT/sid7kDtmMsUmdzXhLhyq8XH6CjDT3JI1PYUWPiqMn439z7/xWbFa06KqXgGC7LAawifUCSL7wVK/ulJslZGqhVKB6GHay8DlqG4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W20+Ef5uqQ+1XSTWt4yv1FIM+KZbmlAz1/BcqVoNmVo=;
 b=DTeJ5tboooxsGXJfyMO79qDkT0xowsC17hooygveEilMA3rfNBA83+EeGU7K6EvdqhrOvp2Haierl5Vyby6KK+tFy06lJaLNZuZWsWigx0OAFN4h+VqWspDYO3RR4gjGAm6TPvbwU1GiT599gMH8PkcgnJdTZg79tL41fGgTbk7DQIXmdvmkMiFeQX3m03tB8oTWj/YZQm0XLWoQKyn3WM0BZgNEjxgqpTVvklDQnLWpTb+sO3mlTe1ZSkWCWbgB1+Xt2IJuXGuYDUahdC9kcxVY9805ytIeA9YeDtZBqWV7uk6rGToEdPexpO/dzRHYM6h1S/TUWiIDY5UXzOPIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W20+Ef5uqQ+1XSTWt4yv1FIM+KZbmlAz1/BcqVoNmVo=;
 b=tSXnaW5bW7ZISFK0T6b4mWPsS1NwaPBH2r6dBdjWBynDpQmplv89NY7Z0GelcHsOD7dmgEik6egenoIvt0xsy24orqGGZq9u5N9YGFutxWZHSu5MXlwqCu28/ABW9xE1w7fq54ymCgufG9JYx5Gx3cmnhCEG+8NQeRJfd6dZ7Dg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 22:23:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 22:23:20 +0000
Message-ID: <b1defde9-0a14-44ac-9324-9631b6576584@oracle.com>
Date: Thu, 24 Oct 2024 23:23:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: v6.12-rc workqueue lockups
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org
References: <63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com>
 <20241023203951.unvxg2claww4s2x5@quack3>
 <df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com>
 <Zxq4cEVjcHmluc9O@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zxq4cEVjcHmluc9O@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb1fe75-3b15-4300-ad66-08dcf47a76eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3NlZ1hJajRpOE9yY0dyZ0JTVVdWZFVxbFM3aXRWdytBNmo0cmx1VnFkTEVZ?=
 =?utf-8?B?MHR1NnFpdlViV3JuM2w2eEhWSy9ydU00bGM2aU8wcmo2VExMdkNyNlVwb081?=
 =?utf-8?B?d0NkK09CUTczYTBXZG5MV1F2aEtRTG5pMmV0OCt4YTJpaC9USStDOGxDRWNu?=
 =?utf-8?B?MHdobFdhZHY4YVRPYVp3YkVRdkNMUmlGOXRXeGZ0ZERDdVg3Z2c3M3gyQUMw?=
 =?utf-8?B?S0xVanNxMzNySDVRS1A2ekdMOG83QWlQalExc3N1QW54Kzk4MTloYTVXOEw0?=
 =?utf-8?B?NUp0RmREeUNwYWxjQUZmNDMza0E3SlMxa3l3MCs3L0VWSFdTZnhVOGhqczYw?=
 =?utf-8?B?M0hOYm4xN0lxd1NEL2JyR3RETFNGSDNHVnlKS2tvMTFRYVpYakgzNGR6Y0Qz?=
 =?utf-8?B?cVIvQ2lZVmpHYnFjUHVvTWJieVRYUEl4QVV0Q2N3aFN4YmtJZjhOVnpIblVh?=
 =?utf-8?B?WHVFQk9Dd1ZVckppZ3BacTlNYnhER2l1NTZvTlExMEoyT2dNMnFIa2JBQ2Iz?=
 =?utf-8?B?N1NtZWlsbTh6VFFtekRPNzY1TGs4V1YraXFSZVBLRGt1SFVEVDhxREE1MEFS?=
 =?utf-8?B?blgrKzErVzlmQkFpMXc0NHdHYlVxUXhHaGhWQ3ZJWlZqamMvQmpzUW1SemI1?=
 =?utf-8?B?ZTZjcytNZm1vL1FNVERrb0dIM09JZmJLenJsVUlXb3FzeTNlV0ZYdXljb2Qy?=
 =?utf-8?B?eWFKYUg3WXF3N3o5dWg5MG51aVViZGNIdHA3MmF1MWxrdUlHckdBclJsY2lL?=
 =?utf-8?B?ZWFRTkRGalhTU05pRkJ2WVN0NVQwN0VIejFPbWtIcGp1eUxpTVFCdmgyVFhy?=
 =?utf-8?B?dFZSdFU0RXpRNXRQU1lDcmZjUWlQU2gydlF4SUNGc2R2UEljSkIzakpKc0l4?=
 =?utf-8?B?MWEvVy9MenZGbnFkM2V1N25iUERPY0M0V0xONHpSdTZmZHdMQmFCeEdUVVlW?=
 =?utf-8?B?Q1MxdUpmaEtTV0loai9Band2eVpGUEtKL25ibnhxZkFEeUR5aUpYUERhQ1d4?=
 =?utf-8?B?Q0pvWDFIbVFtdFNJYjlMdytMY0tWdWhlQ2x3dC9TeENZUWpoYlFPbEVpdDJm?=
 =?utf-8?B?QzFHOHFnSldTN0F5TW9TaVoxaldXbzkwd2U2VkM0ZHhMeHU2dW1qZktYSWRp?=
 =?utf-8?B?dEVHcUJZTko1eWpkaysrTFNZUmVKYkxDdW5QNlZUTUlsdFFWMC9tejlETFQy?=
 =?utf-8?B?dmt5Vm5uZzk2eGJpNmRxWjV1K3JKcVMzV01sbGI3cXVibzlaazdORWw4YklR?=
 =?utf-8?B?Z1g2RW16Mmt0eW9XaDc4R0NtV3RDQjlwREN0YUQ2RnNJR3pkaXlyUnRIVWxx?=
 =?utf-8?B?Q0h2dkpIbTVNNlNGUktVM0NYdjMzZ2w4VEJiQVhjcUkyVndjSVJmeGxPRGdL?=
 =?utf-8?B?Z0FuZ0FENUZOSkFhWlFRcXZmMTk4OXA2NEx0WS84a1BqWXFaT3BDUm1GWndv?=
 =?utf-8?B?d1k4dVF1bVh3bXZXclJPMVViVUI2L2M0SWx0L2hCSUwyQk0wOFMwNUJDcDZr?=
 =?utf-8?B?RHNvMk4vWkpsc1hnRGxqSW41UnZzRGtTZE1vNkY5LytJb0F4cUZ2ZzRqU0tM?=
 =?utf-8?B?Y0RkT3dULzFHVWlMQ1kvbVF5UWg4MitLUHZFbVloTVErNnVySGJ1b0JaNE84?=
 =?utf-8?B?YkxnVFJMUXVhSEpKQ3dzUWNsd2s2ajhUVGF6WWp5dUJJNzlleFJETlMrVG54?=
 =?utf-8?B?LzdGRGNobCthcEZaVDlVQzJXQlhaNnpQU21WOHptMmhXbFlSaGdhc1FoM2Fx?=
 =?utf-8?Q?HWEY4NBrjYU1txt56UDdripBiy9HAMiyQ9UIxnN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmRGK2Z5Y2FEcjJLejZTeExGbXR3V3BGSTI5L0NoQm9oWGdDcS8yRGcydXJK?=
 =?utf-8?B?RVVUOEYxWEdCMm5lNUJhRFpXeFdIUFlVWnF6VHFscE44LzliS2gyQVFsMG5p?=
 =?utf-8?B?N0FuaHd5VzlGVCs5SUN4V0cxaHR2WWUzYzNaR085Q1hoNDl6L0gwZXpkanVq?=
 =?utf-8?B?ZEVGQm42TGVuK0JOd2tYK0EvVGZFdDdua2tDU3BuUjVMeXU0Q0tsNFUyOU5E?=
 =?utf-8?B?UnIvRXBlR01EOEVTZ1pTL2lhc0IwN0YxaW1xOU53L0JtNWFOT0Z4MHpkM3Vk?=
 =?utf-8?B?Ty9rbGV3ZGZldXRGRnJVS0tiVVJ4YmlNdzVWalpWSk5WTlJVZUw1ZlBldE54?=
 =?utf-8?B?bmpiNEZTdm9kQzNjdFVEV0ZVK1dHY0FYQnRzeUQ3cUF6M2ZrN2hjKzQ5WGdm?=
 =?utf-8?B?MHV2OSsvWFBLcEtJMlFIWVNOYzBZYnVUUDRPWUt4T00vTEo0UFU2KzVtcmFM?=
 =?utf-8?B?R1FsRWdWS1JMZkIxYTloSUg3dTNMcmdIN2dzT2c5SjJ0aE9SZUcyRUQ4UVAz?=
 =?utf-8?B?WXZwcXJkSFNFUjNVR1lFd0J3VVozQUxjWG9lbldPQUlubmF4amFBdkxIRmg3?=
 =?utf-8?B?SGlkTFc0cS9LMGdnZStITUlFcXRSd0JVa3NwUTNvRG9HUGNLZldZcjh6UFBi?=
 =?utf-8?B?azlabmZIZDYydlZGbkJsYUtxYmUzNDh5c3VNb2NvbTJwdXFyTjZGZW1GL3BR?=
 =?utf-8?B?dTJ5YkJncGRBT3lJOXFDWUxpTUgzalIyZWcwNGlZYWRsNk9PK2xpZzZLQURT?=
 =?utf-8?B?YWthY0VFSGVGVGVCMHBYbUl3T2lTVHE4U0RrcUtJU0lWYy8wVmlYVDh2eGdz?=
 =?utf-8?B?SHFZWFhtSWNnVVVOU1ZXM2NqNHBIb3ozVWpZUUVXTnFrRDZPNm15RlA2U2dQ?=
 =?utf-8?B?ZERWcXloN2tLbmZSS2FhZXhndW90Z0tDMVBoRzdjc2NOTzFLT1o5bXN0UHY5?=
 =?utf-8?B?UzI3a2JlZDdOeVgyRTEzMkZRekRLQklmaEFRc3h2MGVDeDVHM0JsR1dlWnBM?=
 =?utf-8?B?MWhhY3dkMkI3RjdOOVljTjFOcU9pbUJMSXF0cXFPT01wNnQwUk16cVNzRk5C?=
 =?utf-8?B?Qmw1WXNYUGs1MkIwMnF5WGtuUVN2MlBxNDdtWTVHWlU0d1FsMUh2Y2tzc0tx?=
 =?utf-8?B?bFA3aUgvTSsrNy9tMWYwc1JoNWhpOGlRU3R6VHo3c0h3TStyODN1MFFoZEJS?=
 =?utf-8?B?M1R4MWpLaE50dEs1RUdUU2dRS01TbHZUblo5czRsbmtERW05M3JrTEVGSE5H?=
 =?utf-8?B?NG9CRzNlOEQwVVRUNytPZitsOFcreVMySGl5Y0VYbVRVOWlmZXFxUVNXVzhq?=
 =?utf-8?B?LzVBcWo5MXR4bFljTnZwaEM2MlhWMnZmc2JycGJ4eHRmNW5QRUNwd1NMeDJS?=
 =?utf-8?B?UGJub2ZPaWMvUlN3QytGRWlFVzYzZTBHOVlzeUhSRGNyUXdEcHdyeW1TWCsv?=
 =?utf-8?B?Qk5BYW1hdDA3V1lydTlDRG8xMk1KTlZDN09oREJ5OFJTU1pRWE1OaEFKNXMv?=
 =?utf-8?B?ZkluaEFPZVZ0d0dFMHQxd0ExVjdyNi8ySFJYSUs1Z2ZqSjR2dlJWWm1YQmND?=
 =?utf-8?B?eG4zTUR6MUF2UStzWGJvSDFPTEtLMDFFNDNVWjd0T0tWT2daOVVQSEhFU2pB?=
 =?utf-8?B?bFFPeGhOSXozVDhxLzEwQ2ZlckJvMldpeEZCS3lSbHRwYXBHZmcrWkF2Qnpk?=
 =?utf-8?B?SGZPc1JhdkhzWTFLc252UWNRYmVIQ09UKzRQbm1zakVpUUZ1NHNFRGJYVFBC?=
 =?utf-8?B?S0QrdHJCRWNoZW0xSXVmTXlCOTNSMkljbTBDR2d4M3hrc1hPY2RVTGlVeDRF?=
 =?utf-8?B?TVQ4ZDl4ak5HQXFtNFdlWUxBUTROcVU0dTJ3NkpsOUc0L2h5SVpLRHRUNXZl?=
 =?utf-8?B?TEZOS3BiVW9hdUY5eXgzZWZDZGhRdWR2NVg4WVZ2WU1PR05LRytiN0NaUWYw?=
 =?utf-8?B?VC9tNnpTUnl1cnVsQnplQzlmUElBbTk3KzhPcE4rOGVsVFVRUFoxeUJqS3c4?=
 =?utf-8?B?NWFidGV1VEwzMXM1QXoweUxhb3pNSHU5Y1FzOHN6TzIwUzcrQ1AxbXFZTGxo?=
 =?utf-8?B?RmZGSDh0K00vQUVNWU8zbXJGcysyRnRZZFJQR0g0dllxaGRTMkpkUVpucGwz?=
 =?utf-8?Q?J+SZ1J5f0+vxOcnF7PM1RTbWm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZZZqFgEpZTVNkzaWRaiGHXXCOl5rfjwybItdVFDYINHzHHfsws/pdkRKKZSGwpzjweh81rXABHFYc4YnMAW10qEJC7aS90pp/IrqmxHr9C6pqbKLIxinaZoR5QAelXWfcSFNP7sFndBBeCc65oHHqZPL7FDc7BJIB5h5/shm3/W5qXQuH8Kah2h/OmO2HJfC7WW5oxmAtbXieg7pN98i5V18WdNXiUaxm+rwrXGRLYJABnyxk2d9J9bICgu9XWhnq9B+pj1uBDHpkMigq5H+So4LoJCFYOfs60yREuVSPW4iAg9hXuRotWg/Of/KklBy0d4bE3ADMbZndvhS6jESvARbhgdRvOs26jQqMHluBfewbEVCzywYMxdw4W6nCtOQ+WUcXRBReOHgDGWZ3ynC++YStu7iHjI/BVxwprFvMbn9AAO5piwfijnplcZcLOvXOrN7JN2G02k/Wx/450Mcgth5cHD9+bhP25/BTBbSw5qqoLHUdusv8LadFdc9YiUlPPs77X3OGS/wts8Fy8/jqJLFFInFzBoayUSp0wanEmX8CNC4c3QAfJvIsbvCdMeAYck4d/0GdE5HkbiV9tzcWOAGIZX5UwSdON4ZuxdZUp4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb1fe75-3b15-4300-ad66-08dcf47a76eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:23:20.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28k8EeAUmhBVNJRl8DXy3UDlHptBhKJ8qX91eamANNkDxewCsHG6MSaQ1yd6QK7v84knqoqguKehFXVcYFcJiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_21,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240183
X-Proofpoint-GUID: CFXUcYROrM2ZFbM88irw--xK4JiyMMfx
X-Proofpoint-ORIG-GUID: CFXUcYROrM2ZFbM88irw--xK4JiyMMfx

On 24/10/2024 22:13, Dave Chinner wrote:
>>> BTW, can you please share logs which would contain full stacktraces that
>>> this softlockup reports produce? The attached dmesg is just from fresh
>>> boot...  Thanks!
>>>
>> thanks for getting back to me.
>>
>> So I think that enabling /proc/sys/kernel/softlockup_all_cpu_backtrace is
>> required there. Unfortunately my VM often just locks up without any sign of
>> life.
> Attach a "serial" console to the vm - add "console=ttyS0,115600" to
> the kernel command line and add "-serial pty" to the qemu command
> line. You can then attach something like minicom to the /dev/pts/X
> device that qemu creates for the console output and capture
> everything from initial boot right through to the softlockup traces
> that are emitted...

I am using an OCI instance, so I can't change the qemu command line (as 
far as I know).

For this issue, the Cloud Shell locks up also. There are other console 
connection methods, which I can try.

BTW, earlier today I got this once when trying to recreate this issue:

[ 1549.241972] ------------[ cut here ]------------
[ 1609.240236] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 1609.240243] rcu:     5-...!: (0 ticks this GP) 
idle=a8f4/1/0x4000000000000000 softirq=71287/71287 fqs=1
[ 1609.240249] rcu:     (detected by 2, t=60004 jiffies, g=168077, 
q=10823 ncpus=16)
[ 1609.240252] Sending NMI from CPU 2 to CPUs 5:
[ 1609.240277] NMI backtrace for cpu 5
[ 1609.240281] CPU: 5 UID: 1002 PID: 8250 Comm: mysqld Tainted: G 
W          6.12.0-rc4-g556c97f2ecbf #40
[ 1609.240286] Tainted: [W]=WARN
[ 1609.240288] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1609.240289] RIP: 0010:native_halt+0xe/0x20
[ 1609.240296] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 
f4 <e9> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[ 1609.240298] RSP: 0018:ffffc0c8c71dbd20 EFLAGS: 00000046
[ 1609.240301] RAX: 0000000000000003 RBX: ffff9ff73fab6580 RCX: 
0000000000000008
[ 1609.240303] RDX: ffff9ff7bffaf740 RSI: 0000000000000003 RDI: 
ffff9ff73fab6580
[ 1609.240304] RBP: ffff9ff73f8b7440 R08: 0000000000000008 R09: 
0000000000000074
[ 1609.240306] R10: 0000000000000002 R11: 0000000000000000 R12: 
0000000000000000
[ 1609.240307] R13: 0000000000000001 R14: 0000000000000100 R15: 
0000000000180000
[ 1609.240311] FS:  00007f9e12600700(0000) GS:ffff9ff73f880000(0000) 
knlGS:0000000000000000
[ 1609.240313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1609.240315] CR2: 00007f9d63e00004 CR3: 0000001a0bc04005 CR4: 
0000000000770ef0
[ 1609.240319] PKRU: 55555554
[ 1609.240320] Call Trace:
[ 1609.240322]  <NMI>
[ 1609.240325]  ? nmi_cpu_backtrace+0x98/0x110
[ 1609.240330]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1609.240334]  ? nmi_handle+0x5c/0x150
[ 1609.240339]  ? default_do_nmi+0x4e/0x120
[ 1609.240343]  ? exc_nmi+0x137/0x1d0
[ 1609.240347]  ? end_repeat_nmi+0xf/0x53
[ 1609.240354]  ? native_halt+0xe/0x20
[ 1609.240357]  ? native_halt+0xe/0x20
[ 1609.240360]  ? native_halt+0xe/0x20
[ 1609.240363]  </NMI>
[ 1609.240364]  <TASK>
[ 1609.240366]  kvm_wait+0x47/0x60
[ 1609.240368]  __pv_queued_spin_lock_slowpath+0x255/0x370
[ 1609.240373]  _raw_spin_lock+0x29/0x30
[ 1609.240376]  raw_spin_rq_lock_nested+0x1c/0x80
[ 1609.240381]  __task_rq_lock+0x3f/0xe0
[ 1609.240384]  try_to_wake_up+0x3cf/0x640
[ 1609.240387]  ? plist_del+0x63/0xc0
[ 1609.240391]  wake_up_q+0x4d/0x90
[ 1609.240394]  futex_wake+0x154/0x180
[ 1609.240400]  do_futex+0xf8/0x1d0
[ 1609.240404]  __x64_sys_futex+0x68/0x1c0
[ 1609.240407]  ? restore_fpregs_from_fpstate+0x3c/0xa0
[ 1609.240411]  do_syscall_64+0x62/0x170
[ 1609.240416]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1609.240419] RIP: 0033:0x7fa6a961191a
[ 1609.240422] Code: 00 00 b8 ca 00 00 00 0f 05 5a 5e c3 0f 1f 40 00 56 
52 c7 07 00 00 00 00 81 f6 81 00 00 00 ba 01 00 00 00 b8 ca 00 00 00 0f 
05 <5a> 5e c3 0f 1f 00 41 54 41 55 49 89 fc 49 89 f5 48 83 ec 18 48 89
[ 1609.240424] RSP: 002b:00007f9e125feee0 EFLAGS: 00000206 ORIG_RAX: 
00000000000000ca
[ 1609.240426] RAX: ffffffffffffffda RBX: 00007fa6a02ccb50 RCX: 
00007fa6a961191a
[ 1609.240428] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 
00007fa6a02ccb50
[ 1609.240429] RBP: 00007f9e125ff1a0 R08: 0000000000000000 R09: 
00007fa6a9d0c000
[ 1609.240431] R10: 00007fa6a9d0b080 R11: 0000000000000206 R12: 
00007fa6a9852830
[ 1609.240432] R13: 0f83e0f83e0f83e1 R14: 0000000000000008 R15: 
0000000000000100
[ 1609.240437]  </TASK>
[ 1609.241262] rcu: rcu_preempt kthread timer wakeup didn't happen for 
59997 jiffies! g168077 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[ 1609.241265] rcu:     Possible timer handling issue on cpu=5 
timer-softirq=15698
[ 1609.241267] rcu: rcu_preempt kthread starved for 60000 jiffies! 
g168077 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=5
[ 1609.241269] rcu:     Unless rcu_preempt kthread gets sufficient CPU 
time, OOM is now expected behavior.
[ 1609.241270] rcu: RCU grace-period kthread stack dump:
[ 1609.241271] task:rcu_preempt     state:I stack:0     pid:17 
tgid:17    ppid:2      flags:0x00004000
[ 1609.241275] Call Trace:
[ 1609.241277]  <TASK>
[ 1609.241279]  __schedule+0x334/0xba0
[ 1609.241286]  schedule+0x36/0xc0
[ 1609.241290]  schedule_timeout+0x1e0/0x2c0
[ 1609.241293]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1609.241296]  ? __pfx_process_timeout+0x10/0x10
[ 1609.241300]  rcu_gp_fqs_loop+0x336/0x500
[ 1609.241306]  ? __pfx_rcu_gp_kthread+0x10/0x10
[ 1609.241308]  rcu_gp_kthread+0xdf/0x190
[ 1609.241311]  kthread+0xd2/0x100
[ 1609.241315]  ? __pfx_kthread+0x10/0x10
[ 1609.241318]  ret_from_fork+0x34/0x40
[ 1609.241321]  ? __pfx_kthread+0x10/0x10
[ 1609.241324]  ret_from_fork_asm+0x1a/0x30
[ 1609.241331]  </TASK>
[ 1669.246372] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 1669.246379] rcu:     0-...0: (1 GPs behind) idle=dff4/0/0x1 
softirq=83650/83651 fqs=6001
[ 1669.246385] rcu:     1-...0: (1 GPs behind) idle=eb2c/0/0x1 
softirq=74528/74529 fqs=6001
[ 1669.246388] rcu:     4-...0: (1 GPs behind) idle=4b84/0/0x1 
softirq=78302/78303 fqs=6001
[ 1669.246391] rcu:     5-...0: (1 GPs behind) 
idle=a8f4/1/0x4000000000000000 softirq=71287/71287 fqs=6001
[ 1669.246394] rcu:     7-...0: (1 GPs behind) 
idle=1a3c/1/0x4000000000000000 softirq=71163/71164 fqs=6001
[ 1669.246396] rcu:     8-...0: (1 GPs behind) 
idle=a654/1/0x4000000000000000 softirq=78387/78388 fqs=6001
[ 1669.246398] rcu:     9-...0: (1 GPs behind) 
idle=8b0c/1/0x4000000000000000 softirq=91122/91123 fqs=6001
[ 1669.246401] rcu:     (detected by 13, t=60005 jiffies, g=168081, 
q=14788 ncpus=16)
[ 1669.246404] Sending NMI from CPU 13 to CPUs 0:
[ 1669.246431] NMI backtrace for cpu 0
[ 1669.246439] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G        W 
         6.12.0-rc4-g556c97f2ecbf #40
[ 1669.246445] Tainted: [W]=WARN
[ 1669.246446] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1669.246448] RIP: 0010:native_halt+0xe/0x20
[ 1669.246455] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 
f4 <e9> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[ 1669.246458] RSP: 0018:ffffc0c8c0003d58 EFLAGS: 00000046
[ 1669.246461] RAX: 0000000000000001 RBX: ffff9ff73fab6580 RCX: 
0000000000000001
[ 1669.246463] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
ffff9ff73f637454
[ 1669.246464] RBP: ffff9ff73f637440 R08: 0000000000000001 R09: 
0000000000000200
[ 1669.246466] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff9ff73f6b7440
[ 1669.246467] R13: ffff9ff73f637454 R14: 0000000000000001 R15: 
0000000000040000
[ 1669.246471] FS:  0000000000000000(0000) GS:ffff9ff73f600000(0000) 
knlGS:0000000000000000
[ 1669.246474] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.246476] CR2: 00007f8f73400004 CR3: 0000001a0bc04005 CR4: 
0000000000770ef0
[ 1669.246479] PKRU: 55555554
[ 1669.246481] Call Trace:
[ 1669.246484]  <NMI>
[ 1669.246487]  ? nmi_cpu_backtrace+0x98/0x110
[ 1669.246492]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1669.246496]  ? nmi_handle+0x5c/0x150
[ 1669.246501]  ? default_do_nmi+0x4e/0x120
[ 1669.246505]  ? exc_nmi+0x137/0x1d0
[ 1669.246509]  ? end_repeat_nmi+0xf/0x53
[ 1669.246516]  ? native_halt+0xe/0x20
[ 1669.246520]  ? native_halt+0xe/0x20
[ 1669.246523]  ? native_halt+0xe/0x20
[ 1669.246526]  </NMI>
[ 1669.246527]  <IRQ>
[ 1669.246528]  kvm_wait+0x47/0x60
[ 1669.246531]  __pv_queued_spin_lock_slowpath+0x307/0x370
[ 1669.246536]  _raw_spin_lock+0x29/0x30
[ 1669.246540]  raw_spin_rq_lock_nested+0x1c/0x80
[ 1669.246544]  _raw_spin_rq_lock_irqsave+0x17/0x20
[ 1669.246548]  sched_balance_rq+0xa4e/0xd70
[ 1669.246557]  sched_balance_domains+0x277/0x390
[ 1669.246561]  _nohz_idle_balance.isra.146+0x2bb/0x3a0
[ 1669.246566]  handle_softirqs+0xca/0x2c0
[ 1669.246572]  irq_exit_rcu+0xb0/0xd0
[ 1669.246575]  sysvec_call_function_single+0x71/0x90
[ 1669.246579]  </IRQ>
[ 1669.246580]  <TASK>
[ 1669.246581]  asm_sysvec_call_function_single+0x1a/0x20
[ 1669.246585] RIP: 0010:pv_native_safe_halt+0xf/0x20
[ 1669.246587] Code: 22 d7 e9 6f 48 2d 00 0f 1f 40 00 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 43 76 3f 00 fb 
f4 <e9> 47 48 2d 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[ 1669.246589] RSP: 0018:ffffffff95803e68 EFLAGS: 00000212
[ 1669.246591] RAX: 0000000000000000 RBX: ffffffff95810940 RCX: 
0000000000000000
[ 1669.246593] RDX: 4000000000000000 RSI: 0000000000000087 RDI: 
000000000129dfec
[ 1669.246594] RBP: 0000000000000000 R08: 0000000000000001 R09: 
ffff9ff7bfffffc0
[ 1669.246596] R10: 000000000003c540 R11: 0000000000000000 R12: 
ffffffff95db8be0
[ 1669.246597] R13: ffffffff95810940 R14: 0000000000000000 R15: 
0000000000000000
[ 1669.246603]  default_idle+0x9/0x20
[ 1669.246606]  default_idle_call+0x34/0xf0
[ 1669.246608]  do_idle+0x1f8/0x270
[ 1669.246613]  cpu_startup_entry+0x29/0x30
[ 1669.246616]  rest_init+0xcc/0xd0
[ 1669.246619]  start_kernel+0x459/0x6a0
[ 1669.246626]  x86_64_start_reservations+0x21/0x40
[ 1669.246631]  x86_64_start_kernel+0x91/0xa0
[ 1669.246635]  common_startup_64+0x13e/0x141
[ 1669.246641]  </TASK>
[ 1669.247412] Sending NMI from CPU 13 to CPUs 1:
[ 1669.247431] NMI backtrace for cpu 1
[ 1669.247435] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W 
         6.12.0-rc4-g556c97f2ecbf #40
[ 1669.247438] Tainted: [W]=WARN
[ 1669.247439] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1669.247440] RIP: 0010:native_halt+0xe/0x20
[ 1669.247442] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 
f4 <e9> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[ 1669.247444] RSP: 0018:ffffc0c8c02dcd58 EFLAGS: 00000046
[ 1669.247446] RAX: 0000000000000001 RBX: ffff9ff73fab6580 RCX: 
0000000000000001
[ 1669.247447] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
ffff9ff73f6b7454
[ 1669.247448] RBP: ffff9ff73f6b7440 R08: 0000000000000001 R09: 
0000000000000200
[ 1669.247449] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff9ff73f8b7440
[ 1669.247450] R13: ffff9ff73f6b7454 R14: 0000000000000001 R15: 
0000000000080000
[ 1669.247452] FS:  0000000000000000(0000) GS:ffff9ff73f680000(0000) 
knlGS:0000000000000000
[ 1669.247454] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.247455] CR2: 00007f9d22800004 CR3: 00000001095f2001 CR4: 
0000000000770ef0
[ 1669.247457] PKRU: 55555554
[ 1669.247458] Call Trace:
[ 1669.247459]  <NMI>
[ 1669.247460]  ? nmi_cpu_backtrace+0x98/0x110
[ 1669.247463]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1669.247465]  ? nmi_handle+0x5c/0x150
[ 1669.247469]  ? default_do_nmi+0x4e/0x120
[ 1669.247471]  ? exc_nmi+0x137/0x1d0
[ 1669.247474]  ? end_repeat_nmi+0xf/0x53
[ 1669.247479]  ? native_halt+0xe/0x20
[ 1669.247482]  ? native_halt+0xe/0x20
[ 1669.247485]  ? native_halt+0xe/0x20
[ 1669.247487]  </NMI>
[ 1669.247488]  <IRQ>
[ 1669.247489]  kvm_wait+0x47/0x60
[ 1669.247490]  __pv_queued_spin_lock_slowpath+0x307/0x370
[ 1669.247493]  _raw_spin_lock+0x29/0x30
[ 1669.247496]  raw_spin_rq_lock_nested+0x1c/0x80
[ 1669.247498]  _raw_spin_rq_lock_irqsave+0x17/0x20
[ 1669.247500]  sched_balance_rq+0xa4e/0xd70
[ 1669.247507]  sched_balance_domains+0x277/0x390
[ 1669.247511]  _nohz_idle_balance.isra.146+0x2bb/0x3a0
[ 1669.247514]  handle_softirqs+0xca/0x2c0
[ 1669.247518]  irq_exit_rcu+0xb0/0xd0
[ 1669.247520]  sysvec_call_function_single+0x71/0x90
[ 1669.247523]  </IRQ>
[ 1669.247524]  <TASK>
[ 1669.247525]  asm_sysvec_call_function_single+0x1a/0x20
[ 1669.247528] RIP: 0010:pv_native_safe_halt+0xf/0x20
[ 1669.247529] Code: 22 d7 e9 6f 48 2d 00 0f 1f 40 00 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 43 76 3f 00 fb 
f4 <e9> 47 48 2d 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[ 1669.247530] RSP: 0018:ffffc0c8c00c3ec8 EFLAGS: 00000202
[ 1669.247532] RAX: 0000000000000001 RBX: ffff9fd8809c8000 RCX: 
0000000000000001
[ 1669.247533] RDX: 4000000000000000 RSI: 0000000000000087 RDI: 
0000000000d4eb24
[ 1669.247534] RBP: 0000000000000001 R08: 0000000000000001 R09: 
0101010101010101
[ 1669.247535] R10: 00000000ffffffff R11: 0000000000000001 R12: 
ffffffff95db8be0
[ 1669.247536] R13: ffff9fd8809c8000 R14: 0000000000000000 R15: 
0000000000000000
[ 1669.247541]  default_idle+0x9/0x20
[ 1669.247543]  default_idle_call+0x34/0xf0
[ 1669.247545]  do_idle+0x1f8/0x270
[ 1669.247548]  cpu_startup_entry+0x29/0x30
[ 1669.247550]  start_secondary+0x11e/0x140
[ 1669.247554]  common_startup_64+0x13e/0x141
[ 1669.247559]  </TASK>
[ 1669.248416] Sending NMI from CPU 13 to CPUs 4:
[ 1669.248428] NMI backtrace for cpu 4
[ 1669.248431] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G        W 
         6.12.0-rc4-g556c97f2ecbf #40
[ 1669.248434] Tainted: [W]=WARN
[ 1669.248435] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1669.248436] RIP: 0010:vprintk_emit+0x3a0/0x430
[ 1669.248440] Code: 6c 74 76 48 c7 c7 a8 0c 7f 96 c6 05 74 64 a8 02 01 
e8 a4 32 cd 00 0f b6 05 68 64 a8 02 48 c7 c2 9b 0c 7f 96 84 c0 74 09 f3 
90 <0f> b6 02 84 c0 75 f7 e8 04 1e 00 00 80 e7 02 74 06 fb 0f 1f 44 00
[ 1669.248442] RSP: 0018:ffffc0c8c01a4e18 EFLAGS: 00000002
[ 1669.248444] RAX: 0000000000000001 RBX: 0000000000000246 RCX: 
0000000000000000
[ 1669.248445] RDX: ffffffff967f0c9b RSI: 0000000000000002 RDI: 
ffffffff967f0ca8
[ 1669.248446] RBP: 0000000000000027 R08: 0000000000000000 R09: 
c0000000ffff7fff
[ 1669.248448] R10: 0000000000000001 R11: ffffc0c8c01a4c48 R12: 
0000000000000000
[ 1669.248449] R13: 0000000000000000 R14: ffffffff954639d9 R15: 
ffffc0c8c01a4e70
[ 1669.248451] FS:  0000000000000000(0000) GS:ffff9ff73f800000(0000) 
knlGS:0000000000000000
[ 1669.248453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.248454] CR2: 00007fa3de41be6c CR3: 0000000109516004 CR4: 
0000000000770ef0
[ 1669.248457] PKRU: 55555554
[ 1669.248458] Call Trace:
[ 1669.248459]  <NMI>
[ 1669.248461]  ? nmi_cpu_backtrace+0x98/0x110
[ 1669.248464]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1669.248466]  ? nmi_handle+0x5c/0x150
[ 1669.248470]  ? default_do_nmi+0x4e/0x120
[ 1669.248472]  ? exc_nmi+0x137/0x1d0
[ 1669.248475]  ? end_repeat_nmi+0xf/0x53
[ 1669.248480]  ? vprintk_emit+0x3a0/0x430
[ 1669.248482]  ? vprintk_emit+0x3a0/0x430
[ 1669.248485]  ? vprintk_emit+0x3a0/0x430
[ 1669.248487]  </NMI>
[ 1669.248488]  <IRQ>
[ 1669.248489]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.248491]  ? __pfx_workqueue_timedout+0x10/0x10
[ 1669.248494]  ? __pfx_workqueue_timedout+0x10/0x10
[ 1669.248496]  _printk+0x5c/0x80
[ 1669.248500]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.248502]  workqueue_timedout+0x23/0x60
[ 1669.248505]  call_timer_fn+0x27/0x130
[ 1669.248509]  __run_timer_base.part.35+0x1fe/0x230
[ 1669.248512]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.248513]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.248515]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.248516]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.248518]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.248519]  ? sched_clock_cpu+0x11/0x190
[ 1669.248524]  run_timer_softirq+0x51/0x90
[ 1669.248526]  handle_softirqs+0xca/0x2c0
[ 1669.248530]  irq_exit_rcu+0xb0/0xd0
[ 1669.248532]  sysvec_apic_timer_interrupt+0x71/0x90
[ 1669.248536]  </IRQ>
[ 1669.248537]  <TASK>
[ 1669.248538]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1669.248540] RIP: 0010:pv_native_safe_halt+0xf/0x20
[ 1669.248542] Code: 22 d7 e9 6f 48 2d 00 0f 1f 40 00 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 43 76 3f 00 fb 
f4 <e9> 47 48 2d 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[ 1669.248544] RSP: 0018:ffffc0c8c00dbec8 EFLAGS: 00000216
[ 1669.248545] RAX: 0000000000000004 RBX: ffff9fd8809e0000 RCX: 
ffff9fd884428e38
[ 1669.248546] RDX: 4000000000000000 RSI: 0000000000000004 RDI: 
0000000000b34b7c
[ 1669.248547] RBP: 0000000000000004 R08: 0000000000000001 R09: 
0000000000000004
[ 1669.248548] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffffffff95db8be0
[ 1669.248549] R13: ffff9fd8809e0000 R14: 0000000000000000 R15: 
0000000000000000
[ 1669.248554]  default_idle+0x9/0x20
[ 1669.248556]  default_idle_call+0x34/0xf0
[ 1669.248558]  do_idle+0x1f8/0x270
[ 1669.248561]  cpu_startup_entry+0x29/0x30
[ 1669.248564]  start_secondary+0x11e/0x140
[ 1669.248566]  common_startup_64+0x13e/0x141
[ 1669.248571]  </TASK>
[ 1669.249421] Sending NMI from CPU 13 to CPUs 5:
[ 1669.249444] NMI backtrace for cpu 5
[ 1669.249446] CPU: 5 UID: 1002 PID: 8250 Comm: mysqld Tainted: G 
W          6.12.0-rc4-g556c97f2ecbf #40
[ 1669.249450] Tainted: [W]=WARN
[ 1669.249451] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1669.249453] RIP: 0010:native_halt+0xe/0x20
[ 1669.249456] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 
f4 <e9> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[ 1669.249458] RSP: 0018:ffffc0c8c71dbd20 EFLAGS: 00000046
[ 1669.249460] RAX: 0000000000000003 RBX: ffff9ff73fab6580 RCX: 
0000000000000008
[ 1669.249462] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 
ffff9ff73fab6580
[ 1669.249463] RBP: ffff9ff73f8b7440 R08: 0000000000000008 R09: 
0000000000000074
[ 1669.249464] R10: 0000000000000002 R11: 0000000000000000 R12: 
0000000000000000
[ 1669.249466] R13: 0000000000000001 R14: 0000000000000100 R15: 
0000000000180000
[ 1669.249468] FS:  00007f9e12600700(0000) GS:ffff9ff73f880000(0000) 
knlGS:0000000000000000
[ 1669.249470] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.249472] CR2: 00007f9d63e00004 CR3: 0000001a0bc04005 CR4: 
0000000000770ef0
[ 1669.249475] PKRU: 55555554
[ 1669.249476] Call Trace:
[ 1669.249477]  <NMI>
[ 1669.249479]  ? nmi_cpu_backtrace+0x98/0x110
[ 1669.249482]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1669.249484]  ? nmi_handle+0x5c/0x150
[ 1669.249488]  ? default_do_nmi+0x4e/0x120
[ 1669.249491]  ? exc_nmi+0x137/0x1d0
[ 1669.249495]  ? end_repeat_nmi+0xf/0x53
[ 1669.249501]  ? native_halt+0xe/0x20
[ 1669.249504]  ? native_halt+0xe/0x20
[ 1669.249507]  ? native_halt+0xe/0x20
[ 1669.249511]  </NMI>
[ 1669.249511]  <TASK>
[ 1669.249512]  kvm_wait+0x47/0x60
[ 1669.249515]  __pv_queued_spin_lock_slowpath+0x255/0x370
[ 1669.249518]  _raw_spin_lock+0x29/0x30
[ 1669.249521]  raw_spin_rq_lock_nested+0x1c/0x80
[ 1669.249524]  __task_rq_lock+0x3f/0xe0
[ 1669.249528]  try_to_wake_up+0x3cf/0x640
[ 1669.249531]  ? plist_del+0x63/0xc0
[ 1669.249534]  wake_up_q+0x4d/0x90
[ 1669.249537]  futex_wake+0x154/0x180
[ 1669.249544]  do_futex+0xf8/0x1d0
[ 1669.249547]  __x64_sys_futex+0x68/0x1c0
[ 1669.249550]  ? restore_fpregs_from_fpstate+0x3c/0xa0
[ 1669.249554]  do_syscall_64+0x62/0x170
[ 1669.249558]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1669.249561] RIP: 0033:0x7fa6a961191a
[ 1669.249564] Code: 00 00 b8 ca 00 00 00 0f 05 5a 5e c3 0f 1f 40 00 56 
52 c7 07 00 00 00 00 81 f6 81 00 00 00 ba 01 00 00 00 b8 ca 00 00 00 0f 
05 <5a> 5e c3 0f 1f 00 41 54 41 55 49 89 fc 49 89 f5 48 83 ec 18 48 89
[ 1669.249566] RSP: 002b:00007f9e125feee0 EFLAGS: 00000206 ORIG_RAX: 
00000000000000ca
[ 1669.249568] RAX: ffffffffffffffda RBX: 00007fa6a02ccb50 RCX: 
00007fa6a961191a
[ 1669.249570] RDX: 0000000000000001 RSI: 0000000000000081 RDI: 
00007fa6a02ccb50
[ 1669.249571] RBP: 00007f9e125ff1a0 R08: 0000000000000000 R09: 
00007fa6a9d0c000
[ 1669.249572] R10: 00007fa6a9d0b080 R11: 0000000000000206 R12: 
00007fa6a9852830
[ 1669.249574] R13: 0f83e0f83e0f83e1 R14: 0000000000000008 R15: 
0000000000000100
[ 1669.249579]  </TASK>
[ 1669.250426] Sending NMI from CPU 13 to CPUs 7:
[ 1669.250443] NMI backtrace for cpu 7
[ 1669.250446] CPU: 7 UID: 0 PID: 9912 Comm: pidstat Tainted: G        W 
          6.12.0-rc4-g556c97f2ecbf #40
[ 1669.250450] Tainted: [W]=WARN
[ 1669.250451] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1669.250452] RIP: 0010:native_halt+0xe/0x20
[ 1669.250456] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 
f4 <e9> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[ 1669.250458] RSP: 0018:ffffc0c8c8a4bb18 EFLAGS: 00000046
[ 1669.250460] RAX: 0000000000000003 RBX: ffff9ff73fab58c0 RCX: 
0000000000000008
[ 1669.250461] RDX: ffff9ff7bffafb40 RSI: 0000000000000003 RDI: 
ffff9ff73fab58c0
[ 1669.250462] RBP: ffff9ff73f9b7440 R08: 0000000000000008 R09: 
00000000000000b4
[ 1669.250464] R10: ffffc0c8c8a4bbe0 R11: 0000000000000000 R12: 
0000000000000000
[ 1669.250465] R13: 0000000000000001 R14: 0000000000000100 R15: 
0000000000200000
[ 1669.250467] FS:  00007f461edcb580(0000) GS:ffff9ff73f980000(0000) 
knlGS:0000000000000000
[ 1669.250469] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.250470] CR2: 000055b6651fe000 CR3: 00000001082de002 CR4: 
0000000000770ef0
[ 1669.250473] PKRU: 55555554
[ 1669.250474] Call Trace:
[ 1669.250475]  <NMI>
[ 1669.250477]  ? nmi_cpu_backtrace+0x98/0x110
[ 1669.250481]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1669.250483]  ? nmi_handle+0x5c/0x150
[ 1669.250486]  ? default_do_nmi+0x4e/0x120
[ 1669.250489]  ? exc_nmi+0x137/0x1d0
[ 1669.250492]  ? end_repeat_nmi+0xf/0x53
[ 1669.250497]  ? native_halt+0xe/0x20
[ 1669.250499]  ? native_halt+0xe/0x20
[ 1669.250502]  ? native_halt+0xe/0x20
[ 1669.250505]  </NMI>
[ 1669.250506]  <TASK>
[ 1669.250506]  kvm_wait+0x47/0x60
[ 1669.250508]  __pv_queued_spin_lock_slowpath+0x255/0x370
[ 1669.250512]  _raw_spin_lock_irq+0x2f/0x40
[ 1669.250513]  wq_worker_comm+0xbb/0x120
[ 1669.250517]  proc_task_name+0xbb/0xf0
[ 1669.250522]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.250525]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.250527]  do_task_stat+0x47f/0xec0
[ 1669.250535]  proc_single_show+0x59/0xd0
[ 1669.250539]  seq_read_iter+0x19f/0x410
[ 1669.250544]  seq_read+0x109/0x150
[ 1669.250549]  vfs_read+0xc2/0x350
[ 1669.250552]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.250554]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.250557]  ksys_read+0x63/0xe0
[ 1669.250560]  do_syscall_64+0x62/0x170
[ 1669.250563]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1669.250566] RIP: 0033:0x7f461e71fdf5
[ 1669.250568] Code: fe ff ff 50 48 8d 3d a2 8d 06 00 e8 35 ee 01 00 0f 
1f 44 00 00 f3 0f 1e fa 48 8d 05 45 49 2a 00 8b 00 85 c0 75 0f 31 c0 0f 
05 <48> 3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89
[ 1669.250570] RSP: 002b:00007ffc727410d8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[ 1669.250572] RAX: ffffffffffffffda RBX: 00007f461e3559b0 RCX: 
00007f461e71fdf5
[ 1669.250573] RDX: 0000000000000400 RSI: 000055b64c60f5c0 RDI: 
0000000000000004
[ 1669.250574] RBP: 0000000000000004 R08: 0000000000000000 R09: 
0000000000000000
[ 1669.250575] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
[ 1669.250576] R13: 00000000000002a7 R14: 00007ffc727411f4 R15: 
000055b64c60f130
[ 1669.250580]  </TASK>
[ 1669.251430] Sending NMI from CPU 13 to CPUs 8:
[ 1669.251457] NMI backtrace for cpu 8
[ 1669.251461] CPU: 8 UID: 1002 PID: 8288 Comm: mysqld Tainted: G 
W          6.12.0-rc4-g556c97f2ecbf #40
[ 1669.251467] Tainted: [W]=WARN
[ 1669.251468] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1669.251470] RIP: 0010:native_halt+0xe/0x20
[ 1669.251478] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 
f4 <e9> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[ 1669.251480] RSP: 0018:ffffc0c8c72cba20 EFLAGS: 00000046
[ 1669.251483] RAX: 0000000000000001 RBX: ffff9ff73fab6580 RCX: 
0000000000000001
[ 1669.251485] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff9ff73fa37454
[ 1669.251487] RBP: ffff9ff73fa37440 R08: 0000000000000001 R09: 
0000000000000200
[ 1669.251488] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff9ff73f637440
[ 1669.251489] R13: ffff9ff73fa37454 R14: 0000000000000001 R15: 
0000000000240000
[ 1669.251494] FS:  00007f9187200700(0000) GS:ffff9ff73fa00000(0000) 
knlGS:0000000000000000
[ 1669.251496] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.251498] CR2: 00007f8ff7800004 CR3: 0000001a0bc04002 CR4: 
0000000000770ef0
[ 1669.251501] PKRU: 55555554
[ 1669.251502] Call Trace:
[ 1669.251505]  <NMI>
[ 1669.251508]  ? nmi_cpu_backtrace+0x98/0x110
[ 1669.251514]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1669.251518]  ? nmi_handle+0x5c/0x150
[ 1669.251523]  ? default_do_nmi+0x4e/0x120
[ 1669.251527]  ? exc_nmi+0x137/0x1d0
[ 1669.251531]  ? end_repeat_nmi+0xf/0x53
[ 1669.251540]  ? native_halt+0xe/0x20
[ 1669.251543]  ? native_halt+0xe/0x20
[ 1669.251547]  ? native_halt+0xe/0x20
[ 1669.251550]  </NMI>
[ 1669.251551]  <TASK>
[ 1669.251552]  kvm_wait+0x47/0x60
[ 1669.251555]  __pv_queued_spin_lock_slowpath+0x307/0x370
[ 1669.251560]  _raw_spin_lock+0x29/0x30
[ 1669.251564]  raw_spin_rq_lock_nested+0x1c/0x80
[ 1669.251568]  _raw_spin_rq_lock_irqsave+0x17/0x20
[ 1669.251572]  sched_balance_rq+0xa4e/0xd70
[ 1669.251581]  sched_balance_newidle+0x1c3/0x430
[ 1669.251585]  pick_next_task_fair+0x36/0x370
[ 1669.251588]  ? dl_server_stop+0x2c/0x40
[ 1669.251592]  pick_next_task+0x6b/0xc00
[ 1669.251595]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.251597]  ? dequeue_task_fair+0xa1/0x2b0
[ 1669.251601]  __schedule+0x155/0xba0
[ 1669.251606]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.251609]  schedule+0x36/0xc0
[ 1669.251613]  futex_wait_queue+0x66/0xa0
[ 1669.251619]  __futex_wait+0x13d/0x1b0
[ 1669.251623]  ? __pfx_futex_wake_mark+0x10/0x10
[ 1669.251629]  futex_wait+0x6e/0x110
[ 1669.251632]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.251634]  ? futex_wake+0x85/0x180
[ 1669.251639]  do_futex+0x11a/0x1d0
[ 1669.251642]  __x64_sys_futex+0x68/0x1c0
[ 1669.251645]  ? restore_fpregs_from_fpstate+0x3c/0xa0
[ 1669.251650]  do_syscall_64+0x62/0x170
[ 1669.251655]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1669.251658] RIP: 0033:0x7fa6a960e4ac
[ 1669.251662] Code: 68 4c 89 64 24 70 89 6c 24 78 e8 ef 2e 00 00 e8 da 
32 00 00 45 31 d2 31 d2 8b 74 24 34 41 89 c0 4c 89 ff b8 ca 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 54 44 89 c7 e8 14 33 00 00 48 8b 7c 24 10 31
[ 1669.251664] RSP: 002b:00007f91871ff9f0 EFLAGS: 00000246 ORIG_RAX: 
00000000000000ca
[ 1669.251667] RAX: ffffffffffffffda RBX: 00007fa6a001d518 RCX: 
00007fa6a960e4ac
[ 1669.251668] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
00007fa6a001d540
[ 1669.251669] RBP: 0000000000000000 R08: 0000000000000000 R09: 
00007fa6a9d0c000
[ 1669.251671] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007fa6a001d4f0
[ 1669.251672] R13: 0000000000001eec R14: 0000000000000000 R15: 
00007fa6a001d540
[ 1669.251677]  </TASK>
[ 1669.252438] Sending NMI from CPU 13 to CPUs 9:
[ 1669.252457] NMI backtrace for cpu 9
[ 1669.252459] CPU: 9 UID: 1002 PID: 8255 Comm: mysqld Tainted: G 
W          6.12.0-rc4-g556c97f2ecbf #40
[ 1669.252462] Tainted: [W]=WARN
[ 1669.252462] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1669.252463] RIP: 0010:native_halt+0xe/0x20
[ 1669.252466] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 
f4 <e9> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[ 1669.252468] RSP: 0018:ffffc0c8c7203718 EFLAGS: 00000046
[ 1669.252469] RAX: 0000000000000001 RBX: ffff9ff73fab6580 RCX: 
0000000000000001
[ 1669.252470] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 
ffff9ff73fab7454
[ 1669.252471] RBP: ffff9ff73fab7440 R08: ffff9ff73fab58e8 R09: 
ffff9fd880401ff0
[ 1669.252473] R10: 0000000000000000 R11: ffffffff95869448 R12: 
ffff9ff73fa37440
[ 1669.252474] R13: ffff9ff73fab7454 R14: 0000000000000001 R15: 
0000000000280000
[ 1669.252476] FS:  00007f9e0a600700(0000) GS:ffff9ff73fa80000(0000) 
knlGS:0000000000000000
[ 1669.252478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.252479] CR2: 00007f8fb5e00004 CR3: 0000001a0bc04004 CR4: 
0000000000770ef0
[ 1669.252481] PKRU: 55555554
[ 1669.252482] Call Trace:
[ 1669.252483]  <NMI>
[ 1669.252484]  ? nmi_cpu_backtrace+0x98/0x110
[ 1669.252487]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1669.252489]  ? nmi_handle+0x5c/0x150
[ 1669.252493]  ? default_do_nmi+0x4e/0x120
[ 1669.252495]  ? exc_nmi+0x137/0x1d0
[ 1669.252498]  ? end_repeat_nmi+0xf/0x53
[ 1669.252503]  ? native_halt+0xe/0x20
[ 1669.252506]  ? native_halt+0xe/0x20
[ 1669.252509]  ? native_halt+0xe/0x20
[ 1669.252511]  </NMI>
[ 1669.252512]  <TASK>
[ 1669.252513]  kvm_wait+0x47/0x60
[ 1669.252514]  __pv_queued_spin_lock_slowpath+0x307/0x370
[ 1669.252518]  _raw_spin_lock+0x29/0x30
[ 1669.252520]  raw_spin_rq_lock_nested+0x1c/0x80
[ 1669.252523]  try_to_wake_up+0x187/0x640
[ 1669.252526]  kick_pool+0x65/0x140
[ 1669.252531]  __queue_work+0x1ae/0x400
[ 1669.252535]  queue_work_on+0x66/0x70
[ 1669.252538]  soft_cursor+0x198/0x230
[ 1669.252542]  bit_cursor+0x355/0x610
[ 1669.252546]  ? __entry_text_end+0x101ec6/0x101ec9
[ 1669.252548]  ? get_color+0x26/0x120
[ 1669.252552]  ? __pfx_bit_cursor+0x10/0x10
[ 1669.252553]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.252556]  hide_cursor+0x27/0x90
[ 1669.252559]  vt_console_print+0x3e9/0x400
[ 1669.252564]  console_flush_all+0x2df/0x500
[ 1669.252569]  console_unlock+0x10b/0x1f0
[ 1669.252572]  vprintk_emit+0x3c6/0x430
[ 1669.252575]  _printk+0x5c/0x80
[ 1669.252580]  __warn_printk+0xe3/0x120
[ 1669.252583]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.252587]  pick_task_fair+0x103/0x160
[ 1669.252590]  pick_next_task_fair+0x4c/0x370
[ 1669.252593]  pick_next_task+0x6b/0xc00
[ 1669.252595]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.252597]  ? dequeue_task_fair+0x4b/0x2b0
[ 1669.252599]  __schedule+0x155/0xba0
[ 1669.252603]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.252605]  schedule+0x36/0xc0
[ 1669.252608]  futex_wait_queue+0x66/0xa0
[ 1669.252611]  __futex_wait+0x13d/0x1b0
[ 1669.252615]  ? __pfx_futex_wake_mark+0x10/0x10
[ 1669.252619]  futex_wait+0x6e/0x110
[ 1669.252622]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.252623]  ? futex_wake+0x85/0x180
[ 1669.252627]  do_futex+0x11a/0x1d0
[ 1669.252630]  __x64_sys_futex+0x68/0x1c0
[ 1669.252632]  ? restore_fpregs_from_fpstate+0x3c/0xa0
[ 1669.252635]  do_syscall_64+0x62/0x170
[ 1669.252638]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1669.252641] RIP: 0033:0x7fa6a961187d
[ 1669.252643] Code: f0 5a 41 5a c3 0f 1f 84 00 00 00 00 00 41 52 52 4d 
31 d2 ba 02 00 00 00 81 f6 80 00 00 00 39 d0 75 08 90 b8 ca 00 00 00 0f 
05 <89> d0 87 07 85 c0 75 f0 5a 41 5a c3 0f 1f 80 00 00 00 00 48 83 3a
[ 1669.252644] RSP: 002b:00007f9e0a5fee88 EFLAGS: 00000202 ORIG_RAX: 
00000000000000ca
[ 1669.252646] RAX: ffffffffffffffda RBX: 00007fa6a02ccb50 RCX: 
00007fa6a961187d
[ 1669.252647] RDX: 0000000000000002 RSI: 0000000000000080 RDI: 
00007fa6a02ccb50
[ 1669.252648] RBP: 00007f9e0a5fef70 R08: 00007fa6a02ccb50 R09: 
0000000000000028
[ 1669.252649] R10: 0000000000000000 R11: 0000000000000202 R12: 
00007fa6a988c010
[ 1669.252650] R13: 0f83e0f83e0f83e1 R14: 0000000000000004 R15: 
00007fa6a984a010
[ 1669.252654]  </TASK>
[ 1669.253446] rcu: rcu_preempt kthread starved for 30005 jiffies! 
g168081 f0x0 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=2
[ 1669.253449] rcu:     Unless rcu_preempt kthread gets sufficient CPU 
time, OOM is now expected behavior.
[ 1669.253451] rcu: RCU grace-period kthread stack dump:
[ 1669.253452] task:rcu_preempt     state:R  running task     stack:0 
  pid:17    tgid:17    ppid:2      flags:0x00004008
[ 1669.253457] Call Trace:
[ 1669.253458]  <TASK>
[ 1669.253461]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.253464]  ? sysvec_call_function_single+0xe/0x90
[ 1669.253467]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1669.253469]  ? asm_sysvec_call_function_single+0x1a/0x20
[ 1669.253473]  ? kvm_wait+0x47/0x60
[ 1669.253475]  ? __pv_queued_spin_lock_slowpath+0x307/0x370
[ 1669.253478]  ? _raw_spin_lock+0x29/0x30
[ 1669.253481]  ? raw_spin_rq_lock_nested+0x1c/0x80
[ 1669.253484]  ? resched_cpu+0x3e/0x80
[ 1669.253486]  ? force_qs_rnp+0x239/0x2c0
[ 1669.253490]  ? __pfx_rcu_watching_snap_recheck+0x10/0x10
[ 1669.253493]  ? rcu_gp_fqs_loop+0x384/0x500
[ 1669.253497]  ? __pfx_rcu_gp_kthread+0x10/0x10
[ 1669.253499]  ? rcu_gp_kthread+0xdf/0x190
[ 1669.253502]  ? kthread+0xd2/0x100
[ 1669.253506]  ? __pfx_kthread+0x10/0x10
[ 1669.253509]  ? ret_from_fork+0x34/0x40
[ 1669.253512]  ? __pfx_kthread+0x10/0x10
[ 1669.253515]  ? ret_from_fork_asm+0x1a/0x30
[ 1669.253521]  </TASK>
[ 1669.253522] rcu: Stack dump where RCU GP kthread last ran:
[ 1669.253523] Sending NMI from CPU 13 to CPUs 2:
[ 1669.253539] NMI backtrace for cpu 2
[ 1669.253542] CPU: 2 UID: 0 PID: 17 Comm: rcu_preempt Tainted: G 
W          6.12.0-rc4-g556c97f2ecbf #40
[ 1669.253546] Tainted: [W]=WARN
[ 1669.253547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1669.253548] RIP: 0010:native_halt+0xe/0x20
[ 1669.253553] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 23 f1 17 01 
f4 <e9> 28 c3 05 01 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90
[ 1669.253555] RSP: 0018:ffffc0c8c009bd88 EFLAGS: 00000046
[ 1669.253557] RAX: 0000000000000001 RBX: ffff9ff73fab6580 RCX: 
0000000000000001
[ 1669.253559] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff9ff73f737454
[ 1669.253560] RBP: ffff9ff73f737440 R08: ffff9ff73f7370f0 R09: 
0000000000000377
[ 1669.253562] R10: 0000000000000001 R11: 0000000000000001 R12: 
ffff9ff73fab7440
[ 1669.253563] R13: ffff9ff73f737454 R14: 0000000000000001 R15: 
00000000000c0000
[ 1669.253566] FS:  0000000000000000(0000) GS:ffff9ff73f700000(0000) 
knlGS:0000000000000000
[ 1669.253567] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.253569] CR2: 00007f6d7d6f9890 CR3: 0000001a0bc04005 CR4: 
0000000000770ef0
[ 1669.253572] PKRU: 55555554
[ 1669.253572] Call Trace:
[ 1669.253574]  <NMI>
[ 1669.253575]  ? nmi_cpu_backtrace+0x98/0x110
[ 1669.253579]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1669.253581]  ? nmi_handle+0x5c/0x150
[ 1669.253585]  ? default_do_nmi+0x4e/0x120
[ 1669.253587]  ? exc_nmi+0x137/0x1d0
[ 1669.253590]  ? end_repeat_nmi+0xf/0x53
[ 1669.253595]  ? native_halt+0xe/0x20
[ 1669.253598]  ? native_halt+0xe/0x20
[ 1669.253601]  ? native_halt+0xe/0x20
[ 1669.253603]  </NMI>
[ 1669.253604]  <TASK>
[ 1669.253605]  kvm_wait+0x47/0x60
[ 1669.253607]  __pv_queued_spin_lock_slowpath+0x307/0x370
[ 1669.253610]  _raw_spin_lock+0x29/0x30
[ 1669.253612]  raw_spin_rq_lock_nested+0x1c/0x80
[ 1669.253615]  resched_cpu+0x3e/0x80
[ 1669.253618]  force_qs_rnp+0x239/0x2c0
[ 1669.253621]  ? __pfx_rcu_watching_snap_recheck+0x10/0x10
[ 1669.253624]  rcu_gp_fqs_loop+0x384/0x500
[ 1669.253628]  ? __pfx_rcu_gp_kthread+0x10/0x10
[ 1669.253631]  rcu_gp_kthread+0xdf/0x190
[ 1669.253633]  kthread+0xd2/0x100
[ 1669.253637]  ? __pfx_kthread+0x10/0x10
[ 1669.253640]  ret_from_fork+0x34/0x40
[ 1669.253643]  ? __pfx_kthread+0x10/0x10
[ 1669.253646]  ret_from_fork_asm+0x1a/0x30
[ 1669.253652]  </TASK>
[ 1721.537374] INFO: task kworker/u66:13:128 blocked for more than 122 
seconds.
[ 1721.537380]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.537382] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.537383] task:kworker/u66:13  state:D stack:0     pid:128 
tgid:128   ppid:2      flags:0x00004000
[ 1721.537388] Workqueue: events_unbound idle_cull_fn
[ 1721.537395] Call Trace:
[ 1721.537397]  <TASK>
[ 1721.537401]  __schedule+0x334/0xba0
[ 1721.537409]  schedule+0x36/0xc0
[ 1721.537412]  schedule_preempt_disabled+0x15/0x30
[ 1721.537415]  __mutex_lock.isra.14+0x431/0x690
[ 1721.537418]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.537421]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.537424]  idle_cull_fn+0x3b/0xe0
[ 1721.537428]  process_scheduled_works+0x109/0x4e0
[ 1721.537431]  ? __pfx_workqueue_timedout+0x10/0x10
[ 1721.537434]  ? __pfx_idle_cull_fn+0x10/0x10
[ 1721.537437]  worker_thread+0x117/0x240
[ 1721.537440]  ? __pfx_worker_thread+0x10/0x10
[ 1721.537442]  kthread+0xd2/0x100
[ 1721.537446]  ? __pfx_kthread+0x10/0x10
[ 1721.537449]  ret_from_fork+0x34/0x40
[ 1721.537453]  ? __pfx_kthread+0x10/0x10
[ 1721.537456]  ret_from_fork_asm+0x1a/0x30
[ 1721.537462]  </TASK>
[ 1721.537469] INFO: task kworker/u65:4:229 blocked for more than 122 
seconds.
[ 1721.537471]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.537472] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.537473] task:kworker/u65:4   state:D stack:0     pid:229 
tgid:229   ppid:2      flags:0x00004000
[ 1721.537477] Workqueue: events_unbound idle_cull_fn
[ 1721.537479] Call Trace:
[ 1721.537481]  <TASK>
[ 1721.537483]  __schedule+0x334/0xba0
[ 1721.537488]  schedule+0x36/0xc0
[ 1721.537491]  schedule_preempt_disabled+0x15/0x30
[ 1721.537493]  __mutex_lock.isra.14+0x431/0x690
[ 1721.537496]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.537498]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.537501]  idle_cull_fn+0x3b/0xe0
[ 1721.537504]  process_scheduled_works+0x109/0x4e0
[ 1721.537507]  ? __pfx_workqueue_timedout+0x10/0x10
[ 1721.537509]  ? __pfx_idle_cull_fn+0x10/0x10
[ 1721.537512]  worker_thread+0x117/0x240
[ 1721.537515]  ? __pfx_worker_thread+0x10/0x10
[ 1721.537517]  kthread+0xd2/0x100
[ 1721.537520]  ? __pfx_kthread+0x10/0x10
[ 1721.537523]  ret_from_fork+0x34/0x40
[ 1721.537525]  ? __pfx_kthread+0x10/0x10
[ 1721.537528]  ret_from_fork_asm+0x1a/0x30
[ 1721.537533]  </TASK>
[ 1721.537538] INFO: task kworker/11:1H:659 blocked for more than 122 
seconds.
[ 1721.537540]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.537541] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.537542] task:kworker/11:1H   state:D stack:0     pid:659 
tgid:659   ppid:2      flags:0x00004000
[ 1721.537546] Workqueue: kblockd blk_mq_timeout_work
[ 1721.537550] Call Trace:
[ 1721.537552]  <TASK>
[ 1721.537554]  __schedule+0x334/0xba0
[ 1721.537559]  schedule+0x36/0xc0
[ 1721.537562]  schedule_timeout+0x283/0x2c0
[ 1721.537565]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.537567]  ? scsi_queue_rq+0x2b6/0xbe0
[ 1721.537571]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.537573]  ? __prepare_to_swait+0x52/0x80
[ 1721.537577]  wait_for_completion_state+0x173/0x1d0
[ 1721.537581]  __wait_rcu_gp+0x121/0x150
[ 1721.537585]  synchronize_rcu_normal.part.63+0x3a/0x60
[ 1721.537589]  ? __pfx_call_rcu_hurry+0x10/0x10
[ 1721.537592]  ? __pfx_wakeme_after_rcu+0x10/0x10
[ 1721.537594]  synchronize_rcu_normal+0x9a/0xb0
[ 1721.537597]  ? __pfx_blk_mq_check_expired+0x10/0x10
[ 1721.537601]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.537603]  blk_mq_timeout_work+0x142/0x1a0
[ 1721.537605]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.537608]  process_scheduled_works+0x109/0x4e0
[ 1721.537611]  ? __pfx_workqueue_timedout+0x10/0x10
[ 1721.537614]  ? __pfx_blk_mq_timeout_work+0x10/0x10
[ 1721.537617]  worker_thread+0x117/0x240
[ 1721.537619]  ? __pfx_worker_thread+0x10/0x10
[ 1721.537622]  kthread+0xd2/0x100
[ 1721.537624]  ? __pfx_kthread+0x10/0x10
[ 1721.537627]  ret_from_fork+0x34/0x40
[ 1721.537630]  ? __pfx_kthread+0x10/0x10
[ 1721.537633]  ret_from_fork_asm+0x1a/0x30
[ 1721.537638]  </TASK>
[ 1721.537697] INFO: task mysqld:8329 blocked for more than 122 seconds.
[ 1721.537699]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.537700] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.537701] task:mysqld          state:D stack:0     pid:8329 
tgid:8190  ppid:8021   flags:0x00000000
[ 1721.537704] Call Trace:
[ 1721.537705]  <TASK>
[ 1721.537707]  __schedule+0x334/0xba0
[ 1721.537712]  schedule+0x36/0xc0
[ 1721.537716]  inode_dio_wait+0x7b/0xb0
[ 1721.537720]  ? __pfx_var_wake_function+0x10/0x10
[ 1721.537726]  xfs_file_fallocate+0xca/0x440 [xfs]
[ 1721.537873]  vfs_fallocate+0x124/0x310
[ 1721.537878]  ksys_fallocate+0x40/0x80
[ 1721.537881]  __x64_sys_fallocate+0x1e/0x30
[ 1721.537884]  do_syscall_64+0x62/0x170
[ 1721.537889]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1721.537892] RIP: 0033:0x7fa6a6d2499a
[ 1721.537895] RSP: 002b:00007fa6a43f5bd0 EFLAGS: 00000246 ORIG_RAX: 
000000000000011d
[ 1721.537898] RAX: ffffffffffffffda RBX: 0000000004000000 RCX: 
00007fa6a6d2499a
[ 1721.537899] RDX: 0000000250000000 RSI: 0000000000000000 RDI: 
0000000000000029
[ 1721.537901] RBP: 00007fa6a43f6120 R08: 0000000000001000 R09: 
0000000250000000
[ 1721.537902] R10: 0000000004000000 R11: 0000000000000246 R12: 
00007fa6a02c1e10
[ 1721.537904] R13: 00007fa6a02c1ed8 R14: 00007f8bd8012f70 R15: 
00007f8bd809a0d0
[ 1721.537908]  </TASK>
[ 1721.537910] INFO: task mysqld:8331 blocked for more than 122 seconds.
[ 1721.537911]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.537913] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.537914] task:mysqld          state:D stack:0     pid:8331 
tgid:8190  ppid:8021   flags:0x00000000
[ 1721.537916] Call Trace:
[ 1721.537926]  <TASK>
[ 1721.537928]  __schedule+0x334/0xba0
[ 1721.537933]  schedule+0x36/0xc0
[ 1721.537937]  inode_dio_wait+0x7b/0xb0
[ 1721.537940]  ? __pfx_var_wake_function+0x10/0x10
[ 1721.537943]  xfs_file_fallocate+0xca/0x440 [xfs]
[ 1721.538078]  vfs_fallocate+0x124/0x310
[ 1721.538081]  ksys_fallocate+0x40/0x80
[ 1721.538085]  __x64_sys_fallocate+0x1e/0x30
[ 1721.538087]  do_syscall_64+0x62/0x170
[ 1721.538091]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1721.538093] RIP: 0033:0x7fa6a6d2499a
[ 1721.538095] RSP: 002b:00007fa6a41f1bd0 EFLAGS: 00000246 ORIG_RAX: 
000000000000011d
[ 1721.538097] RAX: ffffffffffffffda RBX: 0000000004000000 RCX: 
00007fa6a6d2499a
[ 1721.538099] RDX: 000000024c000000 RSI: 0000000000000000 RDI: 
0000000000000027
[ 1721.538100] RBP: 00007fa6a41f2120 R08: 0000000000001000 R09: 
000000024c000000
[ 1721.538101] R10: 0000000004000000 R11: 0000000000000246 R12: 
00007fa6a02c1fe0
[ 1721.538103] R13: 00007fa6a02c20a8 R14: 00007f8bcc012f80 R15: 
00007f8bcc099f80
[ 1721.538107]  </TASK>
[ 1721.538108] INFO: task mysqld:8332 blocked for more than 122 seconds.
[ 1721.538110]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.538111] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.538112] task:mysqld          state:D stack:0     pid:8332 
tgid:8190  ppid:8021   flags:0x00000000
[ 1721.538115] Call Trace:
[ 1721.538116]  <TASK>
[ 1721.538118]  __schedule+0x334/0xba0
[ 1721.538122]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.538125]  schedule+0x36/0xc0
[ 1721.538129]  schedule_timeout+0x1e0/0x2c0
[ 1721.538132]  ? __pfx_process_timeout+0x10/0x10
[ 1721.538137]  io_schedule_timeout+0x51/0x70
[ 1721.538140]  __iomap_dio_rw+0x5ca/0x840
[ 1721.538145]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.538152]  iomap_dio_rw+0x12/0x40
[ 1721.538155]  xfs_file_dio_write_aligned+0xa6/0x130 [xfs]
[ 1721.538283]  xfs_file_write_iter+0xcc/0x120 [xfs]
[ 1721.538427]  vfs_write+0x2fc/0x430
[ 1721.538433]  ksys_pwrite64+0x69/0xa0
[ 1721.538436]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.538439]  do_syscall_64+0x62/0x170
[ 1721.538442]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1721.538445] RIP: 0033:0x7fa6a96124d7
[ 1721.538447] RSP: 002b:00007fa69fff65a0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000012
[ 1721.538449] RAX: ffffffffffffffda RBX: 000000000000002b RCX: 
00007fa6a96124d7
[ 1721.538450] RDX: 0000000000100000 RSI: 00007f8bc491c000 RDI: 
000000000000002b
[ 1721.538452] RBP: 00007f8bc491c000 R08: 0000000000000000 R09: 
00007fa69fff88ec
[ 1721.538453] R10: 0000000248400000 R11: 0000000000000293 R12: 
0000000000100000
[ 1721.538454] R13: 0000000248400000 R14: 00000000042ae5f8 R15: 
00007f8bc409a270
[ 1721.538459]  </TASK>
[ 1721.538460] INFO: task mysqld:8333 blocked for more than 122 seconds.
[ 1721.538462]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.538463] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.538464] task:mysqld          state:D stack:0     pid:8333 
tgid:8190  ppid:8021   flags:0x00000000
[ 1721.538467] Call Trace:
[ 1721.538468]  <TASK>
[ 1721.538470]  __schedule+0x334/0xba0
[ 1721.538475]  schedule+0x36/0xc0
[ 1721.538478]  inode_dio_wait+0x7b/0xb0
[ 1721.538482]  ? __pfx_var_wake_function+0x10/0x10
[ 1721.538485]  xfs_file_fallocate+0xca/0x440 [xfs]
[ 1721.538610]  vfs_fallocate+0x124/0x310
[ 1721.538613]  ksys_fallocate+0x40/0x80
[ 1721.538616]  __x64_sys_fallocate+0x1e/0x30
[ 1721.538618]  do_syscall_64+0x62/0x170
[ 1721.538622]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1721.538625] RIP: 0033:0x7fa6a6d2499a
[ 1721.538626] RSP: 002b:00007fa69f9f8bd0 EFLAGS: 00000246 ORIG_RAX: 
000000000000011d
[ 1721.538628] RAX: ffffffffffffffda RBX: 0000000004000000 RCX: 
00007fa6a6d2499a
[ 1721.538630] RDX: 0000000250000000 RSI: 0000000000000000 RDI: 
0000000000000028
[ 1721.538631] RBP: 00007fa69f9f9120 R08: 0000000000001000 R09: 
0000000250000000
[ 1721.538632] R10: 0000000004000000 R11: 0000000000000246 R12: 
00007fa6a02c1bf0
[ 1721.538634] R13: 00007fa6a02c1cb8 R14: 00007f8bc0076090 R15: 
00007f8bc009a880
[ 1721.538638]  </TASK>
[ 1721.538639] INFO: task mysqld:8335 blocked for more than 122 seconds.
[ 1721.538641]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.538642] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.538643] task:mysqld          state:D stack:0     pid:8335 
tgid:8190  ppid:8021   flags:0x00000000
[ 1721.538645] Call Trace:
[ 1721.538647]  <TASK>
[ 1721.538649]  __schedule+0x334/0xba0
[ 1721.538654]  schedule+0x36/0xc0
[ 1721.538657]  inode_dio_wait+0x7b/0xb0
[ 1721.538660]  ? __pfx_var_wake_function+0x10/0x10
[ 1721.538664]  xfs_file_fallocate+0xca/0x440 [xfs]
[ 1721.538788]  vfs_fallocate+0x124/0x310
[ 1721.538792]  ksys_fallocate+0x40/0x80
[ 1721.538795]  __x64_sys_fallocate+0x1e/0x30
[ 1721.538797]  do_syscall_64+0x62/0x170
[ 1721.538801]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1721.538803] RIP: 0033:0x7fa6a6d2499a
[ 1721.538805] RSP: 002b:00007fa69e9f8bd0 EFLAGS: 00000246 ORIG_RAX: 
000000000000011d
[ 1721.538807] RAX: ffffffffffffffda RBX: 0000000004000000 RCX: 
00007fa6a6d2499a
[ 1721.538808] RDX: 0000000250000000 RSI: 0000000000000000 RDI: 
0000000000000026
[ 1721.538810] RBP: 00007fa69e9f9120 R08: 0000000000001000 R09: 
0000000250000000
[ 1721.538811] R10: 0000000004000000 R11: 0000000000000246 R12: 
00007fa6a02c21b0
[ 1721.538812] R13: 00007fa6a02c2278 R14: 00007f8bb4056cb0 R15: 
00007f8bb4099de0
[ 1721.538817]  </TASK>
[ 1721.538819] INFO: task mysqld:8341 blocked for more than 122 seconds.
[ 1721.538820]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.538821] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.538822] task:mysqld          state:D stack:0     pid:8341 
tgid:8190  ppid:8021   flags:0x00000000
[ 1721.538825] Call Trace:
[ 1721.538827]  <TASK>
[ 1721.538829]  __schedule+0x334/0xba0
[ 1721.538833]  schedule+0x36/0xc0
[ 1721.538837]  inode_dio_wait+0x7b/0xb0
[ 1721.538840]  ? __pfx_var_wake_function+0x10/0x10
[ 1721.538843]  xfs_file_fallocate+0xca/0x440 [xfs]
[ 1721.538974]  vfs_fallocate+0x124/0x310
[ 1721.538977]  ksys_fallocate+0x40/0x80
[ 1721.538980]  __x64_sys_fallocate+0x1e/0x30
[ 1721.538983]  do_syscall_64+0x62/0x170
[ 1721.538986]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1721.538989] RIP: 0033:0x7fa6a6d2499a
[ 1721.538991] RSP: 002b:00007fa697ff8bd0 EFLAGS: 00000246 ORIG_RAX: 
000000000000011d
[ 1721.538993] RAX: ffffffffffffffda RBX: 0000000004000000 RCX: 
00007fa6a6d2499a
[ 1721.538994] RDX: 000000024c000000 RSI: 0000000000000000 RDI: 
000000000000002c
[ 1721.538995] RBP: 00007fa697ff9120 R08: 0000000000001000 R09: 
000000024c000000
[ 1721.538997] R10: 0000000004000000 R11: 0000000000000246 R12: 
00007fa6a02c1850
[ 1721.538998] R13: 00007fa6a02c1918 R14: 00007f8b9001a950 R15: 
00007f8b9003b5b0
[ 1721.539002]  </TASK>
[ 1721.539006] INFO: task top:9931 blocked for more than 122 seconds.
[ 1721.539008]       Tainted: G        W 
6.12.0-rc4-g556c97f2ecbf #40
[ 1721.539009] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1721.539010] task:top             state:D stack:0     pid:9931 
tgid:9931  ppid:9915   flags:0x00004002
[ 1721.539013] Call Trace:
[ 1721.539015]  <TASK>
[ 1721.539017]  __schedule+0x334/0xba0
[ 1721.539022]  schedule+0x36/0xc0
[ 1721.539025]  schedule_preempt_disabled+0x15/0x30
[ 1721.539027]  __mutex_lock.isra.14+0x431/0x690
[ 1721.539029]  ? prep_new_page+0x1b/0x50
[ 1721.539033]  ? get_page_from_freelist+0x11b2/0x22a0
[ 1721.539037]  wq_worker_comm+0x26/0x120
[ 1721.539041]  proc_task_name+0xbb/0xf0
[ 1721.539045]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.539047]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.539050]  do_task_stat+0x47f/0xec0
[ 1721.539058]  proc_single_show+0x59/0xd0
[ 1721.539063]  seq_read_iter+0x19f/0x410
[ 1721.539068]  seq_read+0x109/0x150
[ 1721.539073]  vfs_read+0xc2/0x350
[ 1721.539075]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.539077]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1721.539081]  ksys_read+0x63/0xe0
[ 1721.539084]  do_syscall_64+0x62/0x170
[ 1721.539088]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1721.539090] RIP: 0033:0x7f2fc4d1fdf5
[ 1721.539092] RSP: 002b:00007ffc726f6dc8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[ 1721.539094] RAX: ffffffffffffffda RBX: 00007f2fc6213678 RCX: 
00007f2fc4d1fdf5
[ 1721.539095] RDX: 0000000000000400 RSI: 000055955b781a10 RDI: 
0000000000000007
[ 1721.539096] RBP: 00007f2fc6213670 R08: 0000000000000000 R09: 
00007f2fc4d80060
[ 1721.539098] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000007
[ 1721.539099] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000000
[ 1721.539103]  </TASK>
[ 1721.539104] Future hung task reports are suppressed, see sysctl 
kernel.hung_task_warnings
[ 1776.268834] watchdog: BUG: soft lockup - CPU#10 stuck for 23s! 
[osms-agent:3184]
[ 1776.268839] Modules linked in: binfmt_misc ip6t_REJECT ipt_REJECT 
xt_comment xt_owner nft_compat nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
rfkill nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
ip_set cuse fuse vfat fat intel_rapl_msr intel_rapl_common raid0 kvm_amd 
mlx5_ib bochs ccp drm_vram_helper drm_ttm_helper ib_uverbs mlx5_vdpa ttm 
vringh drm_kms_helper kvm vhost_iotlb ib_core vdpa drm joydev pcspkr 
i2c_piix4 pvpanic_mmio pvpanic i2c_smbus xfs iscsi_tcp libiscsi_tcp 
libiscsi nvme_tcp nvme_fabrics nvme nvme_core sd_mod sg virtio_scsi 
mlx5_core ata_generic pata_acpi crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel sha512_ssse3 ata_piix mlxfw sha256_ssse3 sha1_ssse3 
psample libata virtio_pci tls serio_raw virtio_pci_legacy_dev 
virtio_pci_modern_dev pci_hyperv_intf qemu_fw_cfg dm_multipath sunrpc 
dm_mirror dm_region_hash dm_log dm_mod scsi_transport_iscsi aesni_intel 
crypto_simd cryptd
[ 1776.268933] CPU: 10 UID: 0 PID: 3184 Comm: osms-agent Tainted: G 
   W          6.12.0-rc4-g556c97f2ecbf #40
[ 1776.268937] Tainted: [W]=WARN
[ 1776.268939] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1776.268940] RIP: 0010:smp_call_function_many_cond+0x312/0x4e0
[ 1776.268947] Code: 48 00 39 05 f0 74 fe 01 48 89 c5 0f 86 79 ff ff ff 
48 63 c5 48 8b 3b 48 03 3c c5 00 8e 5a 95 66 90 8b 47 08 a8 01 74 09 f3 
90 <8b> 47 08 a8 01 75 f7 83 c5 01 eb ba e8 cd f6 ff ff eb f4 83 7c 24
[ 1776.268949] RSP: 0018:ffffc0c8c2d9fc38 EFLAGS: 00000202
[ 1776.268951] RAX: 0000000000000011 RBX: ffff9ff73fb37900 RCX: 
0000000000000000
[ 1776.268953] RDX: 0000000000000001 RSI: 0000000000000010 RDI: 
ffff9ff73f6bd340
[ 1776.268954] RBP: 0000000000000001 R08: 0000000000000001 R09: 
ffff9ff73f6bd340
[ 1776.268956] R10: 0000000000000002 R11: 0000000000000000 R12: 
0000000000000001
[ 1776.268957] R13: 0000000000000001 R14: 0000000000000010 R15: 
ffff9ff73f6bd340
[ 1776.268969] FS:  00007fdbcd600700(0000) GS:ffff9ff73fb00000(0000) 
knlGS:0000000000000000
[ 1776.268971] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1776.268973] CR2: 00007fdbea983560 CR3: 00000001095f2005 CR4: 
0000000000770ef0
[ 1776.268976] PKRU: 55555554
[ 1776.268977] Call Trace:
[ 1776.268980]  <IRQ>
[ 1776.268982]  ? watchdog_timer_fn+0x1e2/0x260
[ 1776.268987]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 1776.268989]  ? __hrtimer_run_queues+0x10c/0x270
[ 1776.268995]  ? hrtimer_interrupt+0x109/0x250
[ 1776.268997]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1776.269002]  ? __sysvec_apic_timer_interrupt+0x55/0x120
[ 1776.269006]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[ 1776.269010]  </IRQ>
[ 1776.269012]  <TASK>
[ 1776.269013]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1776.269019]  ? smp_call_function_many_cond+0x312/0x4e0
[ 1776.269021]  ? smp_call_function_many_cond+0x2ea/0x4e0
[ 1776.269023]  ? __pfx_flush_tlb_func+0x10/0x10
[ 1776.269029]  on_each_cpu_cond_mask+0x29/0x50
[ 1776.269031]  flush_tlb_mm_range+0x13f/0x160
[ 1776.269035]  dup_mmap+0x2ea/0x740
[ 1776.269042]  copy_process+0x12b2/0x1d20
[ 1776.269047]  kernel_clone+0x9e/0x390
[ 1776.269050]  __do_sys_clone+0x66/0x90
[ 1776.269055]  do_syscall_64+0x62/0x170
[ 1776.269059]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1776.269063] RIP: 0033:0x7fdbeb4f9a73
[ 1776.269066] Code: db 0f 85 28 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 
31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 0f 87 b9 00 00 00 41 89 c5 85 c0 0f 85 c6 00 00
[ 1776.269067] RSP: 002b:00007fdbcd5fe660 EFLAGS: 00000246 ORIG_RAX: 
0000000000000038
[ 1776.269070] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
00007fdbeb4f9a73
[ 1776.269071] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000001200011
[ 1776.269072] RBP: 0000000000000001 R08: 0000000000000000 R09: 
00007fdbcd600700
[ 1776.269074] R10: 00007fdbcd6009d0 R11: 0000000000000246 R12: 
0000000000000004
[ 1776.269075] R13: 00007fdbeb309b70 R14: 00007fdbcd5fe768 R15: 
00007fdbd7cad2e8
[ 1776.269079]  </TASK>
[ 1776.269081] Kernel panic - not syncing: softlockup: hung tasks
[ 1776.269083] CPU: 10 UID: 0 PID: 3184 Comm: osms-agent Tainted: G 
   W    L     6.12.0-rc4-g556c97f2ecbf #40
[ 1776.269086] Tainted: [W]=WARN, [L]=SOFTLOCKUP
[ 1776.269087] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.5.1 06/16/2021
[ 1776.269088] Call Trace:
[ 1776.269090]  <IRQ>
[ 1776.269091]  panic+0x34f/0x380
[ 1776.269095]  watchdog_timer_fn+0x220/0x260
[ 1776.269098]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 1776.269100]  __hrtimer_run_queues+0x10c/0x270
[ 1776.269104]  hrtimer_interrupt+0x109/0x250
[ 1776.269106]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1776.269109]  __sysvec_apic_timer_interrupt+0x55/0x120
[ 1776.269112]  sysvec_apic_timer_interrupt+0x6c/0x90
[ 1776.269115]  </IRQ>
[ 1776.269116]  <TASK>
[ 1776.269118]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1776.269120] RIP: 0010:smp_call_function_many_cond+0x312/0x4e0
[ 1776.269122] Code: 48 00 39 05 f0 74 fe 01 48 89 c5 0f 86 79 ff ff ff 
48 63 c5 48 8b 3b 48 03 3c c5 00 8e 5a 95 66 90 8b 47 08 a8 01 74 09 f3 
90 <8b> 47 08 a8 01 75 f7 83 c5 01 eb ba e8 cd f6 ff ff eb f4 83 7c 24
[ 1776.269124] RSP: 0018:ffffc0c8c2d9fc38 EFLAGS: 00000202
[ 1776.269126] RAX: 0000000000000011 RBX: ffff9ff73fb37900 RCX: 
0000000000000000
[ 1776.269127] RDX: 0000000000000001 RSI: 0000000000000010 RDI: 
ffff9ff73f6bd340
[ 1776.269128] RBP: 0000000000000001 R08: 0000000000000001 R09: 
ffff9ff73f6bd340
[ 1776.269129] R10: 0000000000000002 R11: 0000000000000000 R12: 
0000000000000001
[ 1776.269130] R13: 0000000000000001 R14: 0000000000000010 R15: 
ffff9ff73f6bd340
[ 1776.269135]  ? smp_call_function_many_cond+0x2ea/0x4e0
[ 1776.269137]  ? __pfx_flush_tlb_func+0x10/0x10
[ 1776.269141]  on_each_cpu_cond_mask+0x29/0x50
[ 1776.269143]  flush_tlb_mm_range+0x13f/0x160
[ 1776.269146]  dup_mmap+0x2ea/0x740
[ 1776.269152]  copy_process+0x12b2/0x1d20
[ 1776.269156]  kernel_clone+0x9e/0x390
[ 1776.269160]  __do_sys_clone+0x66/0x90
[ 1776.269164]  do_syscall_64+0x62/0x170
[ 1776.269167]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1776.269169] RIP: 0033:0x7fdbeb4f9a73
[ 1776.269171] Code: db 0f 85 28 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 
31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 0f 87 b9 00 00 00 41 89 c5 85 c0 0f 85 c6 00 00
[ 1776.269172] RSP: 002b:00007fdbcd5fe660 EFLAGS: 00000246 ORIG_RAX: 
0000000000000038
[ 1776.269174] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
00007fdbeb4f9a73
[ 1776.269175] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
0000000001200011
[ 1776.269177] RBP: 0000000000000001 R08: 0000000000000000 R09: 
00007fdbcd600700
[ 1776.269178] R10: 00007fdbcd6009d0 R11: 0000000000000246 R12: 
0000000000000004
[ 1776.269179] R13: 00007fdbeb309b70 R14: 00007fdbcd5fe768 R15: 
00007fdbd7cad2e8
[ 1776.269183]  </TASK>
[ 1776.272383] Kernel Offset: 0x12c00000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1776.712795] ---[ end Kernel panic - not syncing: softlockup: hung 
tasks ]---

