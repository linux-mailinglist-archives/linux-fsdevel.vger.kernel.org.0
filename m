Return-Path: <linux-fsdevel+bounces-60773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E959EB5197E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BEEF56251C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BA32A3FB;
	Wed, 10 Sep 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dSwHHslQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CuZLbltI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089AF1DC9B1;
	Wed, 10 Sep 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514933; cv=fail; b=ra8XPP0fVoHXJIwKAUyWtJnj0wmECQKHIi2rMfXGBFkgaXtiDZmCYruq/uhSXq245yUVNmZxIGbC1wO2N/bdVvRD4tHP5MfxUvyBRS4jL5Un3CEtBsA9sss7EY2qTWnK2k6Uj1T951p7cfEzro7bK323psUO3RqgcnFxHxcrXJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514933; c=relaxed/simple;
	bh=Ah+sPJBqfssiWHI5L6jRrsrX+jlIDg0bCKXhthG4/Nw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SyU5zofliqrfk88tWB/toiHlv77qxzb6HsbrNl+CkcCruPqf8R/Y2lNR6UmkKPFZ9MbSbIpSfZVGnphbQXHja0InlGiZjVPSelppv82kJMBH9uXrFVZjZ2auh3fag+l7dO7Llnn150Z51jsP6ZqVVLULWlUG2oDJwSmgh/vdJYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dSwHHslQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CuZLbltI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADBp89027781;
	Wed, 10 Sep 2025 14:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kcGWct1NCwUHMi+yHPu9aCT/j7fxWHp6kyKxDemMyow=; b=
	dSwHHslQs1od6wbXMRK5xpXlJ4SUZyaqjVPB1fWKDNlJE7pp7WFqatnGH7wjZ0Xq
	+TmO5hr8WrS8KH6W1MrPNAn7psl9b2dgJWozCRwSd5DS21Ll6LKnDSDk4Znkdb6F
	DQzSOtviTOU0gzvMs8E1Vqf/OZ5FPyN9CDBm5VusUto8MXudsGMsyq1mJ+4Uz3Q6
	pt/GO7A695IZQ0nQ3q4nPVXRhEyH+5nPQA574WKJNg7q/PRWTvsalCFxW4+bkIzD
	6sZwKMRTo3mRO5rmTTiOVrYDZebgx1W04FmAJgQB1NCC4O/vPVlblDWS7XRfiuqY
	zQkwzCDq2Ah11hbt0hiV0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2van9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 14:35:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AEDV0U030667;
	Wed, 10 Sep 2025 14:35:25 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdb2rht-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 14:35:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Img+Q2XLWh5wu1d6fmDHKYFO+m/0xSOxFqxieGCu13t/w3rO0SJTBahOqgarPq4wPQDXjPuyjB18TNYAdNKlTJ0cZfRs000s6HElLApQxZBPXBY+2exRjRPww5/yTg2RQSFJO6TZiCT3YPiPSyysf+t3yMa4HLgJ9gmIH29Osk4suVmLD/anrpRA0jdmg0Z1+14tytVso59HbBwgqkFRMNtTZ8zDITR47aFK2C/IaA+PBtMsBHqEHtumo5SHmcxlzn53aVTl2iMNuyRz/7tWBGfFiM8VPVYHYhPtNux51zkNwRvH0pDD4LiV5d2ICNGfTZjJl4k3Ytch8dkVFhfPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcGWct1NCwUHMi+yHPu9aCT/j7fxWHp6kyKxDemMyow=;
 b=CU+fFTj9QvKPI/URgz7achEDRLnK/Jo5zGO2s0QDcCK0INOaP6RF6rQ+LcY8MXcHLyO0jkZyyx9erZnqgwvnY1xwA2VVf9YiInLnEWRF3t28wG8CwUZVhlaV5rghgb7t1xCKwNzVyjYLIM3XWxstT91x+aE+1BFm5zA8KTNcOtHHKcV65NWb+toExc8wXT7aHenr+vCHTNYI5hRpaircfcJ4NNa8/ZUJgzHlBoubHsygM39SL0vW6lZE9b386dLG1fDIJG9cucMe4zGebRryNxRmVBeB9WZ+yYOD/5vtA704L9BxfN0PoVIWkQonsYXhArNAc2rKHrHTGd1RezB6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcGWct1NCwUHMi+yHPu9aCT/j7fxWHp6kyKxDemMyow=;
 b=CuZLbltIe2r3x0wZc3ktOTdzmrd882Vkpoj+njgEggWjcqbUqkh2RIitJqL9KaEXJbEt7buXQZEkmWFTcbhfqJc2aTeAaISjlRXuda3DRynxTTzQR03Pcjw27akG4swOBmUrm3tp3HkStIAF/g2qULRe2i2OEpL7M3M5pEM1vVY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BL4PR10MB8231.namprd10.prod.outlook.com (2603:10b6:208:4e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 14:35:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 14:35:22 +0000
Message-ID: <118e8e22-39f8-4cb8-87c8-81637ca280e2@oracle.com>
Date: Wed, 10 Sep 2025 10:35:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: Jeff Layton <jlayton@kernel.org>,
        Cedric Blancher <cedric.blancher@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
 <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
 <236e7b3e86423b6cdacbce9a83d7a00e496e020a.camel@kernel.org>
 <11a66cd2-7ffb-4082-a8cd-ae34a48530af@oracle.com>
 <72dff4694962ff72dec90e4071ef993134dfae27.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <72dff4694962ff72dec90e4071ef993134dfae27.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BL4PR10MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 253bd490-8dcf-4b03-a389-08ddf07745d8
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SWo0VXg5VytReDFod2NtTHZPaXlkcS96WWJyeWJzL05vdzNYQmpQNzhSRlAw?=
 =?utf-8?B?RmE4WVZCS3F5bUdiTHFUTlRqN0FucC8rako3TE5QMFNSVUNBQW9SM0gyUjNE?=
 =?utf-8?B?dW9IMEFkWDVKR1pVdEwzaGx5Ky9KR1hYTDJic0owK0ZucVpIQkhoazFHNEtU?=
 =?utf-8?B?SUg4OU9EYVdLUXFXUnovVmRjcFRXMll2U2l3cVdTT2lHZzl0MVhoY3BZdFgz?=
 =?utf-8?B?ZTRqSmlGbmJ6YTNQMkJ3Z0U3dFJnRzcvaDhYTmZJUlp3NkxkazVXYjFyRTFs?=
 =?utf-8?B?WEsxOVdQTTIrUjdFLzM3RTQ5MkpTekVZL2FqM241b2phQnhYOVVLbUZyV3dK?=
 =?utf-8?B?MHV2cHIwR1JOVHY5c2xWMFVMMGdmNitodjZnWkswSnJBeW4xTEpEY2g1blhU?=
 =?utf-8?B?YncyU2s1RDRUVHlCeFgwaEVOWjc5S1k5ZTNsZGIrOUcwRDA4akNIcVF5QTJy?=
 =?utf-8?B?Yzd3RjZxT3RoaVNodTVqU0RFcnJrS0FVUUVsaXlMZW1EdFI3SkpGMXZYalBu?=
 =?utf-8?B?SUlhalVrUTRRRUtCUVRVOWFybWdvZ1psMytCbjI5ZEpVOVpNTUo5TXMvMWdM?=
 =?utf-8?B?K3NkYklvMkxQSmtjZU9lRFFDQXNza1l4YXJETEVlblkyNU1qcnArRHFsY2Rl?=
 =?utf-8?B?WHR0cDlpbzdPRjE1RUdDaEkrMXF1ZzI1NHVXS3Y1Q0ZTbHdxNCtuVXpORlhD?=
 =?utf-8?B?K0lJb01jMjltMU5uNkptYnh3MXdFWnlTUTBYNXhZRkJNRTlGOXJHbVJreWtm?=
 =?utf-8?B?U3ZoaXdEWWtTdEJSNXhZQmhwWGt2L2VOWDFCeEdneXRmazhmSGhRaWlKdGxi?=
 =?utf-8?B?aEw1SjlVNjd3UmF4dWFGemVhbEV1REs4RDRBUnROajhRb2dPb0hLOUtLRk5r?=
 =?utf-8?B?aEk5MG9YZDFYMDJlajc1U2JyZlE5UXJEMU1sbkd5Qk5WTWxScWNZbHlNNEFj?=
 =?utf-8?B?NHlhRnhsWWFIS1NncTBPS1U3Wll3dzgvbGhaSnQ0bzNXTENNcVVZM1FBR0ZU?=
 =?utf-8?B?cUQwMkdCOG9LcXVZKzhOcis2dWpETnBhTHNySnpydDJ0YXFaWnBKZENSNWhu?=
 =?utf-8?B?M1ZLbXFwT0Y3bTdad2dnaExKVUNZUzJuWHJ1ZUplcFhWTHFFaUY3dEpLY2pX?=
 =?utf-8?B?Ti9SZ3Rsc1pxWHdka2htcUZic29Qbk9IU1dWT3NteXFYUElsTmhselFoeWdN?=
 =?utf-8?B?N0pZV0hpSGFhOFV6QUpFRjA5QWxlQmxvVHAvSStTbkROdVFWR1pKYU5PTldX?=
 =?utf-8?B?aCtTR1l3NTVrWVh6V2pqTE83SXVDVy9BakxtYTRaT2R2NWg3Qk0xYXhTNzhG?=
 =?utf-8?B?T1NvZml4Zi82d3daazdkTjJuMDE5eSs1UmlKTDAvMGg5Sm5qS2x2SVdBZmlD?=
 =?utf-8?B?VTEvQ2lLTHI3S2VLbDE0Z01UUDB2a1M1Wm56cWIxTlo0SmpmcDVvWldDTWtX?=
 =?utf-8?B?TDFyWHdibitiSUZFSzdqbU9ZSTd2a2FVTnIxczZKSkpNMEZCRVhDQ2NqRW9R?=
 =?utf-8?B?UUJhdmFSWkp2VkpHSVVKUll4OEdIMnpQSVVqVS9DSEVjSkVNZW11VmVLM3Qz?=
 =?utf-8?B?SisvQndlZEJTaXh4T2VvRksvbDZTeWZJQlh5SE11Y3dJT0xJYkJFVnpSWHUw?=
 =?utf-8?B?eUlhbEE2bXZ6TVFCYzkraXR0MGJaSkxwS3dKN2o4Ym5ZUkh0SlVpN1orYUxp?=
 =?utf-8?B?YlFxdTB0Wk1Id0RLMTdTd0RKN04ranVUb25ac2tFNlV6azNBR0ZibmtWL1U0?=
 =?utf-8?B?UXB3R2ZpWWZxcjJOc1RSTzdLRkYvckphbjZGRTZ1MGxpYjlHZHJqZ3Q2MHV4?=
 =?utf-8?B?bUIxaUpWVWpzMXFETkpiY3pwTmdQTXdLeUxBdmhaMmZsZWErL3FVbllnU3Nq?=
 =?utf-8?B?QjJyeVl3WnE5UkY4RFlkTlVwbElxUHpuOHh0Nlh5bVRoOFFKeTRvSDFjR1Bl?=
 =?utf-8?Q?/XdINSxFh7k=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bW9qRFUyNm5TeHlUaUVjMWZha1dYYjZCSUtUeGplTng5ZFI2Y2lBZmhPT3cr?=
 =?utf-8?B?d0JCeVd6V1YrMWpraEpNQnBDS2NtcVZISVA2NjhkV1FDT1hYMmZiYm9sY2Nr?=
 =?utf-8?B?MU5zUnNFcEFENzJCWWFRaVJHVmEyYkxSV3VhN2hOc1R4T1lNOWUyaG45RVF6?=
 =?utf-8?B?STEvVWdxa0xCY2Rad2dYUWUvM3YrS2xvaUp0Wll0azJFYTh1UmF4TDl3UjNo?=
 =?utf-8?B?aS9CcXRHbThsaDlDUC9LV3U3TFNReFB5dWl4WWl6QzFNSXppdTZxaE1EK1hj?=
 =?utf-8?B?aGV5ZGljeC9tQlJxa0orMVlJZDU4YlpYRTRRY08rd2xjc0FFRm9ucVlQOUhE?=
 =?utf-8?B?NlhiNkp1MzdNdC9oaVJUOWIvT0d0NTYzQkVMWC9pUlJsK1kxbkFUa3E0dGJW?=
 =?utf-8?B?dU03dnlPdzhtc0UyM2JtN2FVcnlBUlF1NlBTcFEzRlpqMXJIVTIzdjRoUG0x?=
 =?utf-8?B?LzNwNS81T0xZR0JIRTdsU0h0ZGFoZTZ1SGFWRVpqMUhHMGU1MlJTSzdYT3Bk?=
 =?utf-8?B?eXpHNmZ5UTllRExuNnVoLy93SnVhOFNmQ1hyRmo0NnExS0dsdVcybDB2dVJn?=
 =?utf-8?B?ZHlleG15SThCOHo5alp5Y0RJTHpuVTdFK1dOSlV6eWFPUVAvWUNBanQwN3Ry?=
 =?utf-8?B?ZGpOMnFtaU5icGFNQkIwaVZtTnFkNGdCd0Q1alptVUJLUEFwbmFhSlRLUC9Y?=
 =?utf-8?B?cnpGQU1BR2RPM0x6QitjTnJZNVdnOEhHdzlWUnRtTFF4QjVST1BoZXNYNGlu?=
 =?utf-8?B?TE5EN2VKbXhvV1Fjd2xjdVp2UGl0R3F0U1dTT05TS2FOT2tZS2JacTJ0Z0Fs?=
 =?utf-8?B?Y3JaanUyKys5cUswcHBIMnNjQWQ2Q0tPZ09JbVViV084REh1dG9DTDZYNGgy?=
 =?utf-8?B?WjN1S2lDS3doQ2c5anROd1VaSzRoaG5tbW93TkZQMzhWK0FmS2t0bk9rMFBF?=
 =?utf-8?B?enJpNlFwSURNdFgvQXFXS0tCWFN1MDdHbjFUaE04TUZGcTIyb3ZlK0NLTThl?=
 =?utf-8?B?Ymc4dVB4SVViRy9ITU5OVFltQjdtUWcvbVVqT3o4RmFic3NKYnRjTWJWTjZv?=
 =?utf-8?B?a2orNUQydnNRTzY5MW1USlBXcFg4cnE0N2YrTGVtWUVXcWZzalc2V0Z3dmVa?=
 =?utf-8?B?Z1Vmb0FDK1NMVXNYbmw4M0VOSHdoU1F4TThxdVB0QTF3QldacGpxNDFoaXBq?=
 =?utf-8?B?TnVuRW90Wm44Y0dlM29iSTF5czJuNWR2Zk95RlJxMlZvMEVNZWFYUEFjYkl2?=
 =?utf-8?B?d0lZRWd5VXdReFJzc2UvK21pT2IrblVTaGVQQ01RRFE4ZG4rWmt6SE0wcGNF?=
 =?utf-8?B?NlJXY3VjTVZuVTY4bU1HOXloM2E0Z2t2UXlsSU1KT3FJRmdacXVHNXFtRThT?=
 =?utf-8?B?YjFYN1h4NERydDBoTk5tY1JsYzAybEJBUW4zUmtDdE1wRHNub2M1ZllDS29l?=
 =?utf-8?B?S0RpY1IySVlkaEZmOVRKQlh0Ykc2VGo4WnIyZitvK1R1eXZLNjk2K0RMU0Na?=
 =?utf-8?B?bjdKeU5nZzdpOHcvbm1zTE1vOUgyYjB4Vm1lZ0F4eXhrOXFZeFQva0RiUUxz?=
 =?utf-8?B?MVY3U0lIT1dZN1RTcFIrSUpyYlpnbVdGYUo1T21zMk1xc1VUVEpTeCtLYTBo?=
 =?utf-8?B?VTk0QWE2eW9yWDEraTlvdlM0QloybFNyZ01GUWQ2RGhCbC9rVi9QRjVtU3VI?=
 =?utf-8?B?ZkRYUlF0MWlmWWY2VGRkdTN0QTVnNHpnZHYxMkRzZHUwK2tFTUF6OHQzUHJN?=
 =?utf-8?B?K0V3WDNmR3hTNmszTTZ6a09UdlFUeUJISVA2ZEpiWjVWNkV1bmczeEd2Zith?=
 =?utf-8?B?T2RMN1JUTEN4bFNhNDRwZDRjalpDK3hzSGpLNjFLLy9IempVZjJGVXpOejR6?=
 =?utf-8?B?dG1iMi8vOHkwRnFrYWhhVnVIUThpSzNyVjlDTUVCc2hYS0FMRzNKdlBuTlFL?=
 =?utf-8?B?MTdXS1JnRGtjaGFkUGJyQ1IxK0wwQTJrK1FLTHExY0hlVk5jZ3JsQXhTVWNy?=
 =?utf-8?B?UUFBUEpaVjNJSmpWaGcwTitqYzBEWTdzc2l5OC9rYk5NZStjSGlLVjg3MmpI?=
 =?utf-8?B?NHNKTVJyVE9qa1NDMEtVWVVocjFJVW9PVU80QmowMlFSTmtUbEl1eHY1aEZN?=
 =?utf-8?Q?T24lOFpWSfm6JJdZ23oD6vEt0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sZmwz1Z/qJaSWFmXFWqbfcj44vfzPDghs2G28u2bRt2+nTL02vxwxVAgjAixP4LCK9qafeBOg1ieJqgWsuQwf6v+x9odtjY7DtqxGPb9uTc/pDKo/Moia3FoKVEn+Yep/n0Ec+K1JwToiRKFKGz97LzPnKtofdm7P/fyJMPHsZE4kXIiy5XQHASomrtZC7/ECHF/4xd714eb14X2Q1El0SvAG3WEYYFt5Z0UgKFtB4A1G6p6ffhif/KfSvmAt4pD96pOfAOXvdTxbU/boNI5IQajjN4LgTQqdLs6SQ7yndiPc/OJTNnFlewXw7ghaMYgkEdlj7WfLPZmHrlDfM64MwsTG1BqTXn0d+PBELpo3HEimqnxCEP63VCFQ31d4qDQRcs/2fs5DN2t9/lD2t3ZCHphNbhgoWZzVhShCU6d6sXP29Rgdp+XhCi0dZW7ECg3oEtBaWufmH2n5WF+c1XGQSMLa5G83q1P6Y2QXmbxsVeAaKLGVRxGBVZ5kmjg+deuztXz+VwDDyAhPPC6T5lFLQ1P3tiQevhkILK+KOeElF85ddgJ+e2M5q4EbTyJIWGTmA1hud5so8bZegCeRtfQjHb3XodEuAST62GgdP1bUEE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253bd490-8dcf-4b03-a389-08ddf07745d8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:35:22.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zmxnq91xDc18zDa4RgXL9ZULFZnuINYoroGBg5FsKk1Reh9uSTxd5s2Y2yMOmAZoMS4FiC3geqOZPjCbYyfjlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR10MB8231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100135
X-Proofpoint-GUID: qtnKZaOXwW4JOuwUmHim_MY3mFzOqNWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX871ZfNuJqFct
 x6qXiDqv5rZjeEVM27yG6hreQClCBeWAcdPiEkyDCPf8rtH/B3jungsXaqxWjLIeXx9lxiBfb8l
 N0/DPJZGUlulcURQZEhIR/x5/peBDGYBG5Uw/5Df8GtxW7n820w01xNDwNREllN7+L45Eo/B4a1
 FbCpUdGpqy66gaKlDs7KW5yfSI2IP3bPnVJtOpugmOn5ccPGu2416+nh7mIwXrChlycRiKIRT4G
 DYS5/tHZO7kNZPhpkJRYwLf6y9dJem8XT2DUTUvUNDzlZOlMI5sHczAtXaf6ZwBjVmH083rmran
 LP0Hvldrt1vKEKGsAolFJPQc+n5akgFVSBRj8sN6AJitnaJWDsswy8bTWq30fsxNmNkLbmq8CNY
 UAI93S4x
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c18cae cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=2nufze0emI9ouI3EEB8A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: qtnKZaOXwW4JOuwUmHim_MY3mFzOqNWn

On 9/10/25 10:30 AM, Jeff Layton wrote:
> On Wed, 2025-09-10 at 10:14 -0400, Chuck Lever wrote:
>> On 9/10/25 7:10 AM, Jeff Layton wrote:
>>> On Tue, 2025-09-09 at 18:06 +0200, Cedric Blancher wrote:
>>>> On Tue, 10 Jun 2025 at 07:34, Christoph Hellwig <hch@infradead.org> wrote:
>>>>>
>>>>> On Mon, Jun 09, 2025 at 10:16:24AM -0400, Chuck Lever wrote:
>>>>>>> Date:   Wed May 21 16:50:46 2008 +1000
>>>>>>>
>>>>>>>     dcache: Add case-insensitive support d_ci_add() routine
>>>>>>
>>>>>> My memory must be quite faulty then. I remember there being significant
>>>>>> controversy at the Park City LSF around some patches adding support for
>>>>>> case insensitivity. But so be it -- I must not have paid terribly close
>>>>>> attention due to lack of oxygen.
>>>>>
>>>>> Well, that is when the ext4 CI code landed, which added the unicode
>>>>> normalization, and with that another whole bunch of issues.
>>>>
>>>> Well, no one likes the Han unification, and the mess the Unicode
>>>> consortium made from that,
>>>> But the Chinese are working on a replacement standard for Unicode, so
>>>> that will be a lot of FUN =:-)
>>>>
>>>>>>> That being said no one ever intended any of these to be exported over
>>>>>>> NFS, and I also question the sanity of anyone wanting to use case
>>>>>>> insensitive file systems over NFS.
>>>>>>
>>>>>> My sense is that case insensitivity for NFS exports is for Windows-based
>>>>>> clients
>>>>>
>>>>> I still question the sanity of anyone using a Windows NFS client in
>>>>> general, but even more so on a case insensitive file system :)
>>>>
>>>> Well, if you want one and the same homedir on both Linux and Windows,
>>>> then you have the option between the SMB/CIFS and the Windows NFSv4.2
>>>> driver (I'm not counting the Windows NFSv3 driver due lack of ACL
>>>> support).
>>>> Both, as of September 2025, work fine for us for production usage.
>>>>
>>>>>> Does it, for example, make sense for NFSD to query the file system
>>>>>> on its case sensitivity when it prepares an NFSv3 PATHCONF response?
>>>>>> Or perhaps only for NFSv4, since NFSv4 pretends to have some recognition
>>>>>> of internationalized file names?
>>>>>
>>>>> Linus hates pathconf any anything like it with passion.  Altough we
>>>>> basically got it now with statx by tacking it onto a fast path
>>>>> interface instead, which he now obviously also hates.  But yes, nfsd
>>>>> not beeing able to query lots of attributes, including actual important
>>>>> ones is largely due to the lack of proper VFS interfaces.
>>>>
>>>> What does Linus recommend as an alternative to pathconf()?
>>>>
>>>> Also, AGAIN the question:
>>>> Due lack of a VFS interface and the urgend use case of needing to
>>>> export a case-insensitive filesystem via NFSv4.x, could we please get
>>>> two /etc/exports options, one setting the case-insensitive boolean
>>>> (true, false, get-default-from-fs) and one for case-preserving (true,
>>>> false, get-default-from-fs)?
>>>>
>>>> So far LInux nfsd does the WRONG thing here, and exports even
>>>> case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
>>>> server does it correctly.
>>>>
>>>> Ced
>>>
>>> I think you don't want an export option for this.
>>>
>>> It sounds like what we really need is a mechanism to determine whether
>>> the inode the client is doing a GETATTR against lies on a case-
>>> insensitive mount.
>>>
>>> Is there a way to detect that in the kernel?
>>
>> Agreed, I would prefer something automatic rather than an explicit
>> export option. The best approach is to set this behavior on the
>> underlying file system via its mount options or on-disk settings.
>> That way, remote and local users see the exact same CS behavior.
>>
>> An export option would enable NFSD to lie about case sensitivity.
>> Maybe that's what is needed? I don't really know. It seems like
>> a potential interoperability disaster.
>>
> 
> There is also the issue that exports can span filesystems. If you have
> one fs that is case-sensitive mounted on another that is not, and then
> you export the whole mess, the results sound sketchy.
> 
>> Moreover, as we determined the last time this thread was active,
>> ext4 has a per-directory case insensitivity setting. The NFS
>> protocol's CS attribute is per file system. That's a giant mismatch
>> in semantics, and I don't know what to do about that. An export
>> option would basically override all of that -- as a hack -- but
>> would get us moving forward. Again, perhaps there are some
>> significant risks to this approach.
>>
> 
> The spec is written such that case-sensitivity applies to the whole fs,
> but in practical terms, would there be any harm in allowing this to be
> set more granularly?
> 
> Existing servers would still work fine in that case, and I don't think
> it would be an issue for the Linux client at least.

Yep, the issue is how existing NFS client implementations treat
fattr4_case_insensitive and fattr4_case_preserving. Research is
needed.


-- 
Chuck Lever

