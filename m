Return-Path: <linux-fsdevel+bounces-47348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4835DA9C61D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2930E3A2577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF524729D;
	Fri, 25 Apr 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DBSzamqu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pEle41eB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A4241CB0;
	Fri, 25 Apr 2025 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577947; cv=fail; b=Prz+SxixpZFmSZFIzlt5KNFN6u5Immz6GN9krX7xp5/gdPzna5tilyZ+lIJFf2/Fc3F3CVdI0W6IcKla/T7VcWI0yjys3ThbYE38xrGwJ0Exs4h5PukN6erhf//vBAvUitp3O5VUjc7Q7YAMOpCXRW1/lqMpPmGSUoGPpf9khgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577947; c=relaxed/simple;
	bh=/+Sb4pdRdrtf1BxenBkZYKwTdiGTDauxANvQ6UjK2JQ=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rYAQkewk6oXoivfcMYJ/24Lx9J6f/KODrzFR5Ew6tDNVvAwoYcgpDOys4s2SRiHsUPICtx8z9PoLZtE8NLeDK+xtdUtStYJXQRxGx4015XxXD8ooqUgVTdLlC8qMeHpNR5WUCcHwjBrRLwLmyoeEP4mYOiXOpMLgbBjvUxEVxlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DBSzamqu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pEle41eB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAHlrx018697;
	Fri, 25 Apr 2025 10:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wnDoRO9W/uJK83C17R+zmnDUwtQrg0MMefXUm/fanxs=; b=
	DBSzamqu/N7xVld7zfZdYI94HtfA0ZoIaXF7k/x3d+Qg1bhck7xmCNV+06ZYllBI
	EBnGJ25MYRUW3yydBlPTL1Vnb2PEaCRSLflsPOM4RXtcuCiDA2IynjyMqCDgcyqW
	JgfVOdVhcrf14lrs5wxjL2o3xaAlxYFJr1bzVKWRlc48tm9TohXWcqCYhG8Zzr8p
	beOfvipyllHPpzFTwlPgI9ybtM/IjdlQsUe2Icfwu9m58DNxdpja13BmWjNRu+65
	+MtzNenNZrQIFIXdlVCEUugx+W9sApY3rx3It3hnB319uL4TAJmeKdYnX+8Ck9If
	ec1WLPnfc4b/B1nhZBWT4Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46878r85vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:45:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAEE8V025069;
	Fri, 25 Apr 2025 10:45:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013076.outbound.protection.outlook.com [40.93.6.76])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbt8be7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9tq6comQvXgHlcqnbF56t+achDVRy50NWtQoOBiLFeXbW0lqfMxOEgdLw5Hf+Y4bn6vhbEFq/X/OdW6VOoLvF6M94d2/eTwhXtZoGwFdrodn7f5dL4FOr69mtMB358WJXnez+AFAAO00xviOfMcIx4t7QW2epWOitwhFC2FVzIfwdv7Tg3LV7ImFj9P8/HbLBNgIVYCo+iiEpdKUFxRvSGLyvx9BGHH0XYmbMLXvBgkVFxzW9a4WEf+V0g0uUAnPQOF8TIYHvNny2V8MW2+Y6ovS+14fcFIf8Sj1fE6mZg0dcSGMRZKWKPctm38CiP0+zwFkPTXWi/zSjCoC0y6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnDoRO9W/uJK83C17R+zmnDUwtQrg0MMefXUm/fanxs=;
 b=FPnXoLpr78oHMfYAhAXrztppogB4L2NnpK6FjEveezgDVh1r3s4tb+N/OQarsl28k/tppumKCNcr3GBM7jX1OJcaOaFZYvsoD+U+HfI2rI96k91f95Pra4jDFciSqS2Ldj25pkkcCF71XDXSSMAJ1ItrxtFThi/zZy1jxsQHA+KUl5smfivB1U/Cu+e3QELQsH/TqWkpmbzeQj4HGYyTmMmUqqEpY1avU6SZ5lmEdpfUdZXZu4bYcEMIiBQynoXIMBJTK6bPU/oNKBbtSC9Fiv2vaT/jxGbJhAFstAz3IFrKYtylWE3zFtZwIHkmCyJDGyWsoIh+F1JKval5jvR0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnDoRO9W/uJK83C17R+zmnDUwtQrg0MMefXUm/fanxs=;
 b=pEle41eBLi1xBfWh5omYDinsj/naii3pzBgvcVpfy9iY+KYBUU7WF3zI1SP3ETDF9AY7XUF8lEf8CcmIz5hZuWcq3b9y80OD2mrykEYOIspAuGi2iNDxMwlEbi2644ii/5y4nTBjzMJod5aoArxUMU0S1AHr9PQTi5bwjFZm3JE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB7425.namprd10.prod.outlook.com (2603:10b6:8:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:45:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:45:25 +0000
Date: Fri, 25 Apr 2025 11:45:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <80c17a17-e462-4e4c-8736-3d8f1eecf70f@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
 <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
 <7b176eaa-3137-42b9-9764-ca4b2b5f6f6b@lucifer.local>
 <ydldfi2bx2zyzi72bmbfu5eadt6xtbxee3fgrdwlituf66vvb4@5mc3jaqlicle>
 <14616df5-319c-4602-b7a4-f74f988b91c0@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14616df5-319c-4602-b7a4-f74f988b91c0@lucifer.local>
X-ClientProxiedBy: LO2P265CA0123.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: db6a9f1a-6321-4ab9-1511-08dd83e649a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTgraFBDMFFZRXdMVjdGcm9ZRXdKbHh6UUpWMEwzckZhK3I4cyt6bkxLRzlu?=
 =?utf-8?B?YVFZL1RDcVlNMGNLdVljQzJKTzFNcVpPb0ZReDVBZVhRWElmSVFPM0o5YUc1?=
 =?utf-8?B?UEs5aVV0LzNhUUV2eml1Ulp2Tm9tSXpUa01CdnJKbU4yelJ3cnBkNzdVYTJS?=
 =?utf-8?B?MkRRUWVpUHAwVHYvc3FnVTFKTTIvZC9KeHJualVtUTZ2b2NpZk9qODJ2TjhM?=
 =?utf-8?B?VXBBd2pLVVZNaUVJbEFJdEg3Z24vNkY0ZFlEWm1SRFF4dThPdFY2aXo5dTFY?=
 =?utf-8?B?RnU2QlFZWWlST0Yrb0pOMWs5dGozeTlmSmZlclNjMmE1M0JWVUh3YjZsVERq?=
 =?utf-8?B?OUlJYjl6bVNkbWJHWGZvSDF6d3IvNmtHaXFwcWh6bzRyTC9RNmQ5YnZGanhR?=
 =?utf-8?B?eVErUXNQOFYyZlRHcStqV21Xb1BwUW1MSEk3NTVmaFlneHdNcUxjNDRUYmo1?=
 =?utf-8?B?UXgrNkhISmoxNDRFZnpmMWZTTmxNUXBoRm02bG9EalVpV0lPNzRlZFU4aWpB?=
 =?utf-8?B?U2wzYVFpSng3QmpzaENxR1BPRUV0Znh2Wnp1STh1MTErOFdvUlRPcStsU3dL?=
 =?utf-8?B?SkxLZTFWVjQ0RTZPMnNvV3JhVVRSWWppM0FSZ1FVMU12dkVpZXRwbjgrbUFS?=
 =?utf-8?B?T1IrdUZFQ25Wem51am1nb0RyQ0lieVhWOHFiNlB6RkFwbkZ3THNlUFZScXBC?=
 =?utf-8?B?SytFWTlmb3NPdDBxSklXa2Jja1VzdEh1V1ZIYjVUL1BEbEN6dkpJVHJJN2Fq?=
 =?utf-8?B?RVdIYzB0SmNMaEVLYlhVdEhDcHBWUUY1L1VKUzlaRjhYUkwzU1NrcWRrRXZS?=
 =?utf-8?B?TWdobGQzNFB0U1RwNXpTSGs3QksvRnRPaGNhK2FRczVVWjRLSkgzQmJLUko4?=
 =?utf-8?B?L202M0dvRjF5d2FZQzFPbXJOTUZ1bUIwN28rQmk5b051S3oxR2JSd05mZHQ1?=
 =?utf-8?B?K3dTcUhiZUVUT0NteHcyMFJtWWFHWTVZTkFxUi9aYWM3by8vY1N6bFVqclpW?=
 =?utf-8?B?V0JKbGpOQUVXWmRRM1BEQkNCQ2p2bnZxNlZWaGRBWkFtc0R4ajJNVGt3a0pO?=
 =?utf-8?B?bUd5SnR1V1BsUlFwdEUvcGpBcnJuT1NqSnJHamUvYUdXN0JjbEtUTnI2RnZV?=
 =?utf-8?B?SWhYRlFoVVRBRmJRK05QK2VaTkhYak9YbnRDSWQ2aEloUlNYNVpYN2o0bmFR?=
 =?utf-8?B?RmJzcTlrb1pxM0NFUDJ5YnNJQmIwR09vNjRYd1pTL2tFQUZhcU9LbjhiTnFI?=
 =?utf-8?B?b21xNXFrYVlYQnRNcFR2NXBYVzUzT25QVnNsc3lua05YUnhvZGhPdzVVNk0v?=
 =?utf-8?B?Witma2NFeW9iNHhnMnMwMWkvcFhUVFFEcWdUcWJFSUhuNElxY2Z1YUI3WFFB?=
 =?utf-8?B?Qmx6NG1YWVR6Qml5SWdSOFdyTklOOUxKTVlmNGxEWGtRVjMrdlpBMStxVS80?=
 =?utf-8?B?RFNYc0wxWURoZGg4dXEzWjJ6NkJrYVNUSjN2RHJSelUzekdGWEVyTFNONkxp?=
 =?utf-8?B?a01SNFNjeU84d0phZG5yd2RCdlN5WGhiSjh3Q1hHd0cxK21qaG05Qkp2WDB1?=
 =?utf-8?B?eWhyVTRQYVdOcVloajg4SEVxc01MTHpPWjhxd1A4YjJnU1pLL3grSTh3Z3lw?=
 =?utf-8?B?VThkQnViUDZHd3U2UmFGQWFqaFNxa3NLMWl4SW5jOWtrSXI5TmhiUlh3czl5?=
 =?utf-8?B?NlZKYTN5WndHcmhiWklZa0ZJQi9XKzcxbGw5UWJGMFFURy9aMzBsNTNOU0lw?=
 =?utf-8?B?SmtzbnRvTVFNNUhkSjZTL2RWRTJ0SzJOZit0eWdaTTgvS3c0ZHNmQjdCZmRq?=
 =?utf-8?B?eTJNSVhNUCt3THVGdXYxNk9qV3dRemVSTTZqeTQ4ZmdoZjFnRGN6a0dPYW1Y?=
 =?utf-8?B?bGdzZmNySmQvRWJvYjlESkJCd3ErSWthamdmcGlVQXQwckduT3UycnpVR1Zl?=
 =?utf-8?B?dVd5SFYxWUdmTWtTQnhwUW1TdFBNaEwyc3lMcCtyeW84Yjg0UUMzdnBxSFZD?=
 =?utf-8?B?d1FjN2VPanl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjNJb1RIeWFFQS9wZ216SThvNk5uM2EybGZCampWUWtuamlGVnBOMk5NN0My?=
 =?utf-8?B?RFljejltYm10akFjTXBoWGplejF0djY0ZkpyeGNEY2IycDdCS2k1azluMlFL?=
 =?utf-8?B?TSs0Z2pQSk5EN2VtUnMvejJ2ZFNKNWN1alhxRVBsWHR4M1lERjhId0FRNEd0?=
 =?utf-8?B?bmhaM3FFbXdURkF3MXpyTW1qYlN3TlZQRFdscjhjMEo5OGlmbm8wVVQ0QjBr?=
 =?utf-8?B?OXI2aEpIT1pReVgwWUtsWkYrZlNCK2JqQkU2WDYwL3hYK1F4UGR2ZnhyMlk3?=
 =?utf-8?B?RXlZcU5aazh4dkZyY1lHb2QyMTN0VWZFQzQ3TzFiYXhtbkc2cE9mL3p6bDJK?=
 =?utf-8?B?by9zY0IrUlpkTDdvSWYrLzBkNWRabkc0Rml3dWRnWld6a3hXbThYMjNJaG1T?=
 =?utf-8?B?U2I3TERabHdmUlAzaDRWRGtKMFJIenRpb2dqZEJDaVdzVEdWY1NoaWowb28r?=
 =?utf-8?B?RWtVTzdwRFV5N2RoTGpURG05STdDTFZocllMaTlIaHIyaUkyQ1F6bmFGSlB3?=
 =?utf-8?B?YmRaS1JSZUNMcTh2YXVpNDJwK3pWRnhuUkRuWmxHZjZHNk9tME9QUjRaR2Rn?=
 =?utf-8?B?WGZ3VUUvN25sWnVTbzhjUEN3MUZuZForejZXVUtrY2x3ZWp3TG16cjhkaVNT?=
 =?utf-8?B?WWJmUWhDRnJDMHd1UzI3bUgzN3NVckFKSitEeWY4UGVNcWJHZ1V6cmhZWi80?=
 =?utf-8?B?ZFp3bDJzNUl0OUdLbklRR2VuQUF2dU1IN1BhQ0ljYzdxWjhDNGlWSmpPcHQx?=
 =?utf-8?B?MFMyYXhpS0ZydTN4Z21kRkNUL2pNQ0I1Tjh4N2s1bnU2cnBmVDFESHkvL2tl?=
 =?utf-8?B?aTlWR2tYUlMrUUg3UXlubmdnWWVaeitqN2xVVTZiaWorREN6WTkzM1FXNm1Y?=
 =?utf-8?B?MVRpNW5HRzQ0UlVRTW0vUy9qQlBLOE1ocVlKMGJiRU4wdjJWazM5THZHdFh5?=
 =?utf-8?B?azU4WVNPdklGY2s4eVF0YlhwR0xaeTlMUW9XVHhqeVY3WlpjbXQwUDlSZ1l4?=
 =?utf-8?B?U2ZtVHREQmxyaUVPazBpQ2M0STZmb2tTYTk4SEFvYmxVeFIxdi9aSEd2RkpF?=
 =?utf-8?B?Ujhwdk1FZG5vWjVzQmp5cDlYMG1FRm5HVWNMNTVLWE1oMHE2K0wwUXpmTjc3?=
 =?utf-8?B?QXFPbEdwTDgzMDI5cXFILzN3bW1DRTNhY29TRkNpakV4SHJQdHFCWnJuNGE3?=
 =?utf-8?B?Y1BsUWMwVGdNT0xid1pvUko2R2RYWE9PM1BHSFI1ZjlIT3V4cEdEM3B0WDFB?=
 =?utf-8?B?UUN1OFQ1Nlk0QkhJVXRqYWQ3S2NkL0NCOXVVNUdhc05sU041SEtsZW5WS21W?=
 =?utf-8?B?S0ZrWi9oSzVIRk9taGl2Y3FjWDJaVjVteVpTYjJoakg1aWRNcGhkdjNNZ3FC?=
 =?utf-8?B?dEJ3b3AwR3dLQWRpVHhCMExvdXJaQWZhWS92TzV4K3Zvc3owQ3pmRWFaYnp6?=
 =?utf-8?B?NnhIcks0Y09oRkFHdzlmZmVESTVPMFpGeEZCaHM4dU9aWmw5dEpIbVB2UHVS?=
 =?utf-8?B?bVByTzZYUm5UTFlOcUpVWHJYZS9FR0p0SWFRL3VkMkNGNzRydzV5cUd0WXc3?=
 =?utf-8?B?eXVvN0RodXF4UzV0M2lUbTIzK2t0UEpxR1gyREJoMzU2OFd1aTZGODdNQVJH?=
 =?utf-8?B?TU5QMStoSXY3TGVCMHRuQVoxRXdyUkFxWFhKQ2Q5ak85N1pheUZuMnB1UnU0?=
 =?utf-8?B?bU9xci9Qc1d3dG5ENlQ3R252TDZhNDJrN3V3dHgvRSt0R0RSc0dudGJrNWJY?=
 =?utf-8?B?dEpsUUlqdXhrMU81NEhQd0pYdjN3aWFNM3JyS29FT0tTVjIwRkw5R1p0d2FB?=
 =?utf-8?B?Ly9BRkpXTzJ5a1JnS1RQRWJISFJoSENvS1NCZjNaSDUvZGp2Wi9mdkZyenBi?=
 =?utf-8?B?NWlyb1hYMjFIMFVyM25YdUJoNFpvVWpoR1UrS2t0dDMxRkN4bGZpWFZkam1h?=
 =?utf-8?B?ZjBQdU5XN0pIdDM5NVJidGVjODlkSitnbVRjWHA1czZkZHYzWEQ0N0Q3YmtC?=
 =?utf-8?B?SmZqOUhHc3dzUnlFSVdqS0pQekZneUNqcUlrdXZueE1LSy8wSkY1Y3g4MmxV?=
 =?utf-8?B?Kys2ZFhkSGpNU0JNanROZjdNQjI5NHNYOFhjZzVaZG9oby9tSms5c01HYmQx?=
 =?utf-8?B?Rkx2L0ZjVkEvQ3hEQXp0ci9lZmVnVlMvLytkWmovQTJkblJkTHlpQXQ2TXVV?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ILl8cEV8LV08TrSQNL4rE9SQRxgFOd5EUqzARosMndbVfAVMMOpVecFLgCK33rjbLZ+zFqJ4NxIYWWcbHcjdX64mbDoY4JqSabnNbN/jBmnq/t92cjatHyAZjdyjR5UIzBTvwXemdGGVjrZ3Mo0WJB7B3I+brcdBG2z/KSHWlIcy5HWVnjbgcZrPUFIMi+UitSpQkJucfBgHs37xzdjXkbIFTukd0Ko/EIMShv/oe8Lfr60rzJVXjbz7yGr65ZzxLyfqNvwi2CZtPg8i/fpBnaW6kPwquUpOEZ0hIPpyW5MRRvdjLT7SLEWgzlVoqX65bXD50mz01SR/9NHUEVEjPhYTvNAvigYH+xNkhsRNdiZn0ENywXx00hI2qSy3NPBQd8SU2y87wQy4qpXjQdl3KxquMTxT6KWIMJaqt4PnmH4pKMgzVX50z7O4yd9cNkyGNEGNaglzzc48s5tyCAmTeUAT/vNqKSl5HVoekjM7C+yIzo2Cj43bdSvUQXBBzkKXjdwJDbslF7rEz6N0RsM0T9bVuRDT/pjiN6zTBDonuYYtXeVyCpB/8ELng7LsZ6wsrkZLZWU5Ksom4bjBC2XghyYK+hfk+dRKN3CxjzSbjEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6a9f1a-6321-4ab9-1511-08dd83e649a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:45:25.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B32V1XPY+vP5EsvH7s6FqVfDK3M64QbuTgTWVf8+e9LNrWpZok40E2O/cqRwBXS01AdtVrHP6Urvhzx4qao01ATeyyc3x4nqQSduKRxIMGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NyBTYWx0ZWRfX0PXoFdZJ1lkD Bp2Skbe/uyQyzzLHwLrg+E7NrIVDUlTgosgkXqS2tlkXNO4bA4A8M+eVhJbIXACKYCZiGvZ2HAa uKUbBIWsk/pwJx4fED56yzf9sYxCWK605OlDEC7iWMR6dCFPWNFXHH0ha7bZojUXQ4AfUCF4kLu
 LQxsRs5ZMoXSNNDNBfTkDstxICv1jGLhb7mMb4B+xjBzdaSVfmLguxw93Yz4+WeLWq3EF705vxc hg1zBgkoczi6jSbKkujPX6Pr6DzJkTco4DFNE5a0tYvrzoArJqUbG+arXqsLZlG6Liz38koD0/i sMqDwuuiCfC9alm+d79GyqWuaK3RyGSTrqzWLnfWqfP3GzRJwsjknzJKe8aRRmVBQugQoGUcsL1 i74acOru
X-Proofpoint-ORIG-GUID: sKkL1tQx0wDXEm8ivCCefR9J243JSVfj
X-Proofpoint-GUID: sKkL1tQx0wDXEm8ivCCefR9J243JSVfj

On Fri, Apr 25, 2025 at 11:31:12AM +0100, Lorenzo Stoakes wrote:
> On Fri, Apr 25, 2025 at 06:26:00AM -0400, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250425 06:09]:
> > > On Thu, Apr 24, 2025 at 06:22:30PM -0700, Suren Baghdasaryan wrote:
> > > > On Thu, Apr 24, 2025 at 2:22 PM David Hildenbrand <david@redhat.com> wrote:
> > > > >
> > > > > On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > > > > > Right now these are performed in kernel/fork.c which is odd and a violation
> > > > > > of separation of concerns, as well as preventing us from integrating this
> > > > > > and related logic into userland VMA testing going forward, and perhaps more
> > > > > > importantly - enabling us to, in a subsequent commit, make VMA
> > > > > > allocation/freeing a purely internal mm operation.
> > > > > >
> > > > > > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > > > > > CONFIG_MMU is not set, and there is no sensible place to put these outside
> > > > > > of that, so we are put in the position of having to duplication some logic
> > > >
> > > > s/to duplication/to duplicate
> > >
> > > Ack will fix!
> > >
> > > >
> > > > > > here.
> > > > > >
> > > > > > This isn't ideal, but since nommu is a niche use-case, already duplicates a
> > > > > > great deal of mmu logic by its nature and we can eliminate code that is not
> > > > > > applicable to nommu, it seems a worthwhile trade-off.
> > > > > >
> > > > > > The intent is to move all this logic to vma.c in a subsequent commit,
> > > > > > rendering VMA allocation, freeing and duplication mm-internal-only and
> > > > > > userland testable.
> > > > >
> > > > > I'm pretty sure you tried it, but what's the big blocker to have patch
> > > > > #3 first, so we can avoid the temporary move of the code to mmap.c ?
> > > >
> > > > Completely agree with David.
> > >
> > > Ack! Yes this was a little bit of a silly one :P
> > >
> > > > I peeked into 4/4 and it seems you want to keep vma.c completely
> > > > CONFIG_MMU-centric. I know we treat NOMMU as an unwanted child but
> > > > IMHO it would be much cleaner to move these functions into vma.c from
> > > > the beginning and have an #ifdef CONFIG_MMU there like this:
> > > >
> > > > mm/vma.c
> > >
> > > This isn't really workable, as the _entire file_ basically contains
> > > CONFIG_MMU-specific stuff. so it'd be one huge #ifdef CONFIG_MMU block with
> > > one small #else block. It'd also be asking for bugs and issues in nommu.
> > >
> > > I think doing it this way fits the patterns we have established for
> > > nommu/mmap separation, and I would say nommu is enough of a niche edge case
> > > for us to really not want to have to go to great lengths to find ways of
> > > sharing code.
> > >
> > > I am quite concerned about us having to consider it and deal with issues
> > > around it so often, so want to try to avoid that as much as we can,
> > > ideally.
> >
> > I think you're asking for more issues the way you have it now.  It could
> > be a very long time until someone sees that nommu isn't working,
> > probably an entire stable kernel cycle.  Basically the longest time it
> > can go before being deemed unnecessary to fix.
> >
> > It could also be worse, it could end up like the arch code with bugs
> > over a decade old not being noticed because it was forked off into
> > another file.
> >
> > Could we create another file for the small section of common code and
> > achieve your goals?
>
> That'd completely defeat the purpose of isolating core functions to vma.c.
>
> Again, I don't believe that bending over backwards to support this niche
> use is appropriate.
>
> And if you're making a change to vm_area_alloc(), vm_area_free(),
> vm_area_init_from(), vm_area_dup() it'd seem like an oversight not to check
> nommu right?
>
> There's already a large amount of duplicated logic there specific to nommu
> for which precisely the same could be said, including entirely parallel
> brk(), mmap() implementations.
>
> So this isn't a change in how we handle nommu.

I guess an alternative is to introduce a new vma_shared.c, vma_shared.h
pair of files here, that we try to allow userland isolation for so vma.c
can still use for userland testing.

This then aligns with your requirement, and keeps it vma-centric like
Suren's suggestion.

Or perhaps it could even be vma_init.c, vma_init.h? To denote that it
references the initialisation and allocation, etc. of VMAs?

Anyway we do that, we share it across all, and it solves all
problems... gives us the isolation for userland testing and also isolation
in mm, while also ensuring no code duplication with nommu.

That work?


>
> >
> > Thanks,
> > Liam
> >
> >

