Return-Path: <linux-fsdevel+bounces-44190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F74FA647D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8E23AFD92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D235191499;
	Mon, 17 Mar 2025 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxDSGea7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gGrAkJS3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EC133987;
	Mon, 17 Mar 2025 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204633; cv=fail; b=cdKXrEGR2iwgh9JtMNCGAJqR8pvz0LrnNtyxbuNndXg2IgdbAdrZMs/W3rXoeW6dbaMiIh5Cnnc2JEFTHzDEx4SIWATyHF+zkf2xSwvNuQ3Wc4FPENn2er+lq+LM4NVpWwE049+Ae6GPrZNi46ARIX2iguaDQf7p65w3HCF1ngQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204633; c=relaxed/simple;
	bh=fwcz8ZwicLbH8U5yZSpMOPYi78LGUSfSU+TxdvSEnO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=seUtPbCtFOeE72Eyj1bSnXFE+7xuFQwyZPpXSHl2r3+X0Yjvnt/BOdqB/RWy9HUzOG+TkO70asML7MJvEtxuTAX+jHfeAWTwNKX5ya1xnUepuxQx1C8/QZwt0LAQfnDXLkotJwAuvz8jXKZEX1+PPQaRwD1uI2KiAY0BTP5Zri4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SxDSGea7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gGrAkJS3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7Qrhh032187;
	Mon, 17 Mar 2025 09:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NM8RqQ3zI7TG3ugEM6OB+ms5aI6Ng9WwgRHHpxgtgMs=; b=
	SxDSGea7J946ltBgBOsIlOJFB6fsnExKmPHWonfetoOU8WzOpqPTs4Chr37/OEIq
	Bow7zgmfhQZ/DRrt8JgbVfpSSjMqpcHMQb9uU/dK846suS0FIESupQfn4QxRkzT+
	QCRCEjRRnVXI8eabD9U2sAks4SvLvaU6QE7vNVje5gK7thNo8/htPsOz2T/Wo7HV
	N3rj9T6IlUGxoJD5RlwMm8QiEgv+ZDlbRbotBHThIbrTcNGtpePAcxFngK4uMWvb
	hn8+zdfu/rHaDg9fV6Sde+lO732XUHn3+AED5xXqMxF//xQfn6UChqGNxwasZamf
	ESuhz7JUexjRgrVANI0/5g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8jbv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:43:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9QHNU009749;
	Mon, 17 Mar 2025 09:43:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxkwxwmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jsph22afpYtqszof36JCDIzkwEK+jsvUY50t/ru6Vtpe/l/ZPodJPwkERilzmho5oXsuowp+i1URpgLMIaTM/u2pNVONEBdToVCeUXmLkIpW9PxgmstEaHppDGTKgFn1Tm/rctHGWg1GNmovdyJuDXy8Ym0eXNWRzc6EZ7YRcthH7JFDFUl49S6grgXza4yi5ijQlBwBwnS9PHsWLAoV5btCQaQ/fWUnnKMF7uEQDJQCosu+tuPpMPPRDpk69nKyg+RH9BaCtyTopE42opV65dw0LUlsGto/otQG6fu+uI7DpPBUDClWFGTvsTkrYao5bUz9wSmT/iwqezk5Vz8JGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NM8RqQ3zI7TG3ugEM6OB+ms5aI6Ng9WwgRHHpxgtgMs=;
 b=MuhGjaEhDLZpXXPnG2fZZapS6WCGOFVZl8vmqdc5MapjH/h5zKYQD1eybgXTcxJvL05lYpS5Y8udzpNJ7m59xY7qhYUKQbo+YyzstMw2c0Xn2KBTHJaFdtxhcaVOh6PAicIbXPyedoG+VOksFB5PP8AVs4PnODUFNblWhgVQ62rcjEWFy28zk1G0pbTj8Mvf7hCMyywBBBk30S8MtWbEnrBNycBpb/wyobSytNxlilAZcWrOa7B9dnm9G02hcpc+tTh4RUDTrYbmhKcKLO4A03tK1FDNJ/D93zyDaq6uFCDY12Qdx2mR2jf+qogwWeLspFTO6GiG31h/OZBLQrHCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NM8RqQ3zI7TG3ugEM6OB+ms5aI6Ng9WwgRHHpxgtgMs=;
 b=gGrAkJS3THeeM28mWlx0q0UwlWZFA9jLXPrgsAqIGlRhHVSS+svuqHxPqbaebnpweGOeeRKSI4nculxoBPR40a5bik8ARL9lfDDE2/63seCVkFEXB1w68gpCxjN8+5ImdWaX3oU5zc+K46McPzwUMlJ2NMIUu0f14n/y8EoxTa0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 09:43:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:43:36 +0000
Message-ID: <99d18591-39b7-4b2a-9f8c-7ebcbe4e286e@oracle.com>
Date: Mon, 17 Mar 2025 09:43:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/13] xfs: commit CoW-based atomic writes atomically
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-13-john.g.garry@oracle.com>
 <20250317065651.GA28079@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250317065651.GA28079@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0076.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: b401773a-80f5-43f3-0341-08dd6538306b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzYzZTFmaWVObGdOZEpqL2l3TXBZbnZhcllzckE4NEZOd2tYenlKM005a2dR?=
 =?utf-8?B?ZzkzUTNlYmFjSkJGUDQ1d3RWZ0t0OTRrZFBsbmo0Nkk3YmxyOTlDaDZNSzRI?=
 =?utf-8?B?VG0zNVlmdGlmd2lMY1RGOXNiMmZxS2EzSFRyTU8ycEZYczJjWHRaZGg2bHJm?=
 =?utf-8?B?c2pueG1HNEduOEFRM1ZVTWdYRERvRFVUUDIrTmxvVFMrVkdtL3dJb1FROThx?=
 =?utf-8?B?Z3ZVZ0EveTJTQlVFaXJVT09EUlB2OWl5UWV0YkNRRXlZV3lSQkxPdngxM1Mw?=
 =?utf-8?B?RGRnNi85K2ZScnJ1ekZ0VmlYN3JUQ0toWjlCclVGSWdyQkVGUkpReTZLMVdq?=
 =?utf-8?B?OFpZd0phamV5SzR4SzdiMzhKaDk5SjMwczJmVFdLMW9VUHRTZnJDako2cFNm?=
 =?utf-8?B?NlczTFhIazdDaTJKQUdSbDJnSGhVb0pOclZkYXRUY1NXSWlCdUVrazVnWDlh?=
 =?utf-8?B?WXlxamh0VjBuWVBHNkpiV2daZVltUU1EZ3FpbWJidEgzZnNCdE8rQllONWR4?=
 =?utf-8?B?OTdRTHZ1VExVM1pIaW9YbDRsT05oVlB4TjJMRk1ITnNGSWhXNHp3YXdxZGxt?=
 =?utf-8?B?YmZ0bjlRUmo5bXRPa0N0MlE5ZVNETEpaWkQ2WWsrakxVNFdFLzBZK1RyVFJZ?=
 =?utf-8?B?UURoOWhWWlVjQS9QVjA2YU1xVzcrNlhBbzNDczlBWTBIMFpOVlY2QXRwSStX?=
 =?utf-8?B?NkFjbU4vWWd1bDlVK0JxeVBaeEtTb0hHMVIvQTNadnVUUkVnUmhiRDlQbngr?=
 =?utf-8?B?OG5GUEhWcDZkbktNRXlTdWEybFdubmY2MXZVS1lPcHVhdzhlVGdOQkhDSWNl?=
 =?utf-8?B?aWlVa2gyWFpieFFiVnQ3dTB2SFVHN0xzQ1ZVek9EU0Z5OThmY1A0T2p5d0s1?=
 =?utf-8?B?VlJ5SmpieWJXSlNOOXVaam1ueTFuQTlvck41Rmd5M0tNYTc1Z2tTUVMzY0Za?=
 =?utf-8?B?cVJzMUtxRXJnZEt6N3ViaVRMSFUxdDN2RHhrMDVnUHd2dHh4OWFINmpOYTJa?=
 =?utf-8?B?SllGQy9qTkl0a0hTcWtoRTVFS3BZZ0VMT2h1UndDLzk5Q0xrNUIyQ1dWck5m?=
 =?utf-8?B?NjVyWnN2Z2VkdUJ2OWtLUUZZbld0MVVqb1hDcWlrc3cvc2VIUXBMdlZobG9h?=
 =?utf-8?B?U0xQNHc0ZXVyZkg2b1lBR2RpOFdJYXVIWXBMVURGSDB2Qms3RTkybnZuR3RD?=
 =?utf-8?B?QmJEY0Y5T2FYWnNEUWFYc25FdWFmQTJUT0dQaWYzQjRpOXZxU3FtSEJkTUF1?=
 =?utf-8?B?WDhSZTJVWUFDT3JGZ3ZTMG1FajFQam1BeFgxRnRYOUNxRCtOQllJM2l1Ri9P?=
 =?utf-8?B?Z0RRNUJlQ1FqZFl6bHZoU1pvaVdsWEZGeGMxL3NrTGh6K1lwb0dxYnU2bjBn?=
 =?utf-8?B?dkwxZGd2WXhDS2k5RnF1TE1UUVVGYmxRSWdjYm5keUxWN2Q2OXhYSlEyUnp0?=
 =?utf-8?B?a0hoYmtJbFFzWWhqWk1ZajNXd0FoVzhXbjdPS21uUFhuaW1keWhTSHZKMkJv?=
 =?utf-8?B?SUdjWXJXVFdYMkxyRFFPSXZBZ05VVFlMTmgrYzdjdnVETmEzZ3J3bUdQMWN3?=
 =?utf-8?B?dFYvMEZRTEJ1Nm9FdXhnNHlpY3E0QmR6SktHdnVwTUtnSU9Fbm5PaEw4ZVRK?=
 =?utf-8?B?ZzY4OHEwMVJ4THZRbEZva2x6OTlwZk9ocjc2VUcyTFFGK3lhbTZURVl6b01R?=
 =?utf-8?B?Y0JBV3N3OC9wcWpBT3JYRHdDbkliVklhcThVT2l3YXhXdHlQdUE1dU1wSWVx?=
 =?utf-8?B?TFpRZVo2alFRU1YvRnM1TDM0MVUzaDlGcnpDbHRJUDZxR3o4Nyt6NjhpL2Vt?=
 =?utf-8?B?SUtzeTRYWnI4NUFqZVM3eWJZWFZmL3VQMVN3VlRRNVNKL2VnZDFqZW53TC90?=
 =?utf-8?Q?qbCnos+OvEvrl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Snl3K004QXdGWXJYdjFRUXBQZW1NMDluUTd0Q1puNkVISWk5cStiL2RlWGMw?=
 =?utf-8?B?MjZVeGtra1pzWm9keXo2aVg0Q21jbUV4UDRmRG9tc0lGRU8xMTN5ZjRWUXQx?=
 =?utf-8?B?YWtnZHN2YXN5UDZuVWtvejFNcFA0QVFUaDE0NlZvTkUrcEY5OWIrUWFpcStX?=
 =?utf-8?B?UXZpQnlhMDdnVlh5T1JYRzBHT0hvUmZSdG5nOS8xdWNaOFJmM2RsZ0VhbUdl?=
 =?utf-8?B?MW0wVkFYcjdaM2V6Mm5lWnR2bGYrSHVZMHVaR0k3U0ZwN045RWNPaUJybTdk?=
 =?utf-8?B?NXQ4dk1GNkFLeDFXTmVqdHhZeCtid1podTlsZUxnT0p0M1NHT2lhZUZFZkg1?=
 =?utf-8?B?c3lmYlZaUUlpVm5zT05raWRhNjJQYUxzWmJRdis5RnNvS2dsTWRqRklnWTRI?=
 =?utf-8?B?Z2Q4aWI3dXhhdCtHUkQycU9tVzJwVlBTZFhQZG1yUDhXODFuNS80Qm9sa2dp?=
 =?utf-8?B?OW92NVZERkNMSFpCN1R5SnpDOHZPcmFWQ05IVk1ZOFYzS242L29zUFdmM21x?=
 =?utf-8?B?ZEUrTGFUSXRNc0FSaGt0WFdueENIKzY5NUxzWGhJcWdRNWEwN29Wd1FmT0Ft?=
 =?utf-8?B?b3FiVUlmQ1pEOXB6ZER6dmJpSXIvaUh0cHlFV2ZwdmJWU1RScEo0SmtNOVhK?=
 =?utf-8?B?eHN6V0l1SzJyRUc0Ym9ER1RrbHJJY2ZWR0NlSnA3bjNEVWIzZFhkQ21aVDRG?=
 =?utf-8?B?SjNXM3Y5NStaR3c2VWFaL3FhSUh5b01DV05NQWw0Qzk5dTVHMFY1ZERzdnVS?=
 =?utf-8?B?SURZRlgvK01LZjZUQk53NTYzVzVYTFNGNDhPZzJHMXhiYUVsazgrRWNrVFpz?=
 =?utf-8?B?dUQ1YU0wSDJ0aEF2U1czSjNHK29haW4xOHVWeSthM3VZeGJ0SkJxWmZyUWpo?=
 =?utf-8?B?QVdWekRVZkdaVlMxd0FINWwxaW83cmo5ZmRoVjk1ei9oOXNNbVJKN1JWKzRh?=
 =?utf-8?B?MXlCaGlIdU96bXRKakI3Ty96Y0dwTnVwWXpSenIvTnZ2b08xM1grbjhsK3Zh?=
 =?utf-8?B?KzJJc09nT3BMVjNmbys5b2w5UUFzc0w5QkhqQ0ZqelpoWWptckFIVlJHait6?=
 =?utf-8?B?Y3ZKaFdYNlZPTGpXaVI2ZEc4MHoySWsyb3oxeWp4OFl4dU44Yk9lTjdoZCsv?=
 =?utf-8?B?Tk5kb2FZTkFoSUJRWkdQUGViS2RvOWtYZnFhemVsN1N2Z3h4N1RpNWVBS1Ni?=
 =?utf-8?B?MUVEdjJjRVJ6V0NVajJGNW5MRDRhL0JDVGlRVHRTdk0xYU1ZQW9zMzRBSDk3?=
 =?utf-8?B?cWYyL1daQW1VcFlkblJrNmJXTkdsYkF5OWhMOFlPNTFRYUlwcXFXSlR4SWtF?=
 =?utf-8?B?ZDVYdTRpZTErTE5La0swYXd3STlBTmt2VmI2NGdaMXJmQ2xtVys0V2RZaXp0?=
 =?utf-8?B?dlRZS2U5dnRSWjdDWHl3QVRyN1duUGtQdWY3YkV6WkxBbC9MSkxvNERodzRP?=
 =?utf-8?B?aFNWWGhibGxDaHZPSU40WW5lUTVjeWZxeURkb3lreUZaNWllOWQwNG1ZT2V5?=
 =?utf-8?B?bXJhNmVGZHBheEhqTmhsREJuR1FWWElwLzJUZVp0T3Nhb3A5QXNTcUpkODB3?=
 =?utf-8?B?WXIyenM0SDRIeFRiU1BsQkErM1FldmE4bzZIMXc2eUIvd0NQSk16bE0xd3Ni?=
 =?utf-8?B?VkNqbDZDb2RPNk9TbDlBQVpRWk1JdjFQQ3dLN3Qzb2lOMXg4QVVGN2JYMVVt?=
 =?utf-8?B?Q1dpT1VKbnhKN1NvRGlmU2dXWE9xL2pjbzA1enJSeWlKcXVVT2hlUGhMREZ0?=
 =?utf-8?B?T1ViNG9jY25aSXBKcVNsejBQNWZIajdVYURvSFM4ZUd5T2R4YlBHWm8xdmxG?=
 =?utf-8?B?R1N3cEl4UEg3cU1tV3NCKzFwZEgvUUxEZEt2THFucWhTYkpDZGxwM1ZzYngw?=
 =?utf-8?B?Y3BpOENtaVpWWmFqeGNKV1NUYlVpaGxnME9PZ2dHUEhIdlRSNVJaemt3eFJJ?=
 =?utf-8?B?ZzFabU15UXd4RFZmOEtVUEJCcFV6UnlwWkZudW1yekwxWHNPL0FHb2xFdTE1?=
 =?utf-8?B?TjJpenBSRlJ5WnJYZStoTk5SbVFIdmR6WmZ4UmlZYk92WGw3R2JYa290ZWMr?=
 =?utf-8?B?VGJ4NDBhcUFoallnK2hLdDF6ZjNwQlVWVjNDZXlJYkhtcFhqNGJhU0Z0VjZm?=
 =?utf-8?B?ZUUwbktlemgxMW02cDl4ejE0MWt0NFNhdzFiYzBQQ0JXeHpKYmdRR0JneUZ2?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XzE9QZ2I/6V1xw9t6f2kZr12pfBpk3Jg6yjS1u2m5AZUU/CUtIjvqpn4CsbbOHkDEbqlY/NLYCm8LP1Q10tWQkvz+XCcUAvg6D4A8P10eHbeEdVdxmvs2OkcdTn3ySkaX4/Lq53PYdEnwkqgZW6E2NNY+mIEfw2yvQjwENq4kYsdJ1UxiDF+Ci0h5qjy/oQ55m+6ASGwmGd8MJIFZuVZ3iCbmg0f0mZEBnkZpeuDNXuHRW30Upf1LcDBejVeFVdapW/k5uTsfN56/V+z8SENt392CRXt7Xwi+R5hika+BgZUfBZwjYvB4i2rr7JmGMOBviZiKYJXtKGlTOZgvIO/zfxpyuPLbtXGMM0LDO0mN2IoH6FfXvOjpGOiFGYuwexpV+XYJCL+uY1AJ0DYLl1TUTzves35aRr9QimJOkEBEeC5qNuf+1Brwim0Kc/QzxxKn9tKwTPRqLwaX7564XyVNdZoHX54ZOnWVXo97i5KY7hWHva8cu+qivZX0X/BlE2eaFvp3JFdiEZaKVTktHc1hAxk01qnTztiiorbRQck1zHA6ZJGOsUDZYRb2OBXrtR6Z2DWP1TYrK+rlvWMPl7ArgZs/uZXlY879WzWyWZS0Bo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b401773a-80f5-43f3-0341-08dd6538306b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:43:36.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmkdMUxld5BSz+wbOkGWO0T1kSbUiq7uOZx5GnUkr/0dvTOasgZeSAakJtxD6vLjuZvH1KOII1ytGke+wVaDSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503170071
X-Proofpoint-ORIG-GUID: 0F_TlLEYcJMhtMqMz39o3I0YiWaVKTNP
X-Proofpoint-GUID: 0F_TlLEYcJMhtMqMz39o3I0YiWaVKTNP

On 17/03/2025 06:56, Christoph Hellwig wrote:
>>   		trace_xfs_reflink_end_cow_error(ip, error,_RET_IP_);
>>   	return error;
>>   }
>> +int
> Still a missing empty line after the previous function. 


Will fix.

>  Also
> please add a comment what is atomic about this function and why
> the regular path doesn't use it.

ok, fine

