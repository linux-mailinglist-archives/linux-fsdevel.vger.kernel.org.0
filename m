Return-Path: <linux-fsdevel+bounces-47712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B585BAA4878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 12:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FB81881AFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E65252912;
	Wed, 30 Apr 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LwHNcWN7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dhqDyUVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB42367A6;
	Wed, 30 Apr 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009098; cv=fail; b=KU0Y7VO2vNLif/a/jj06l6XRA97HedTdFFQEyWbU2aCj88nT1GwyRk9pEi4rr94hXtC3YG/HpJHPvuh/eJMclpBy/lOlDqlLBPBaWztN4G4epA74YnyZLr9DPBqGT4J93pSmHkWGeunb9BTERSjnhDOtIFOSYknQi61d/iNA4U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009098; c=relaxed/simple;
	bh=QaRdmvPWsRFIk2mIi1Wolj5a1kYQQFuqYtVnKiTy6OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DLPw0PyBStvnwPs19QMgy1lJjkVu3Zuk/pBuPRnwAQxPi0hHHgBQmmjbjfFtHStfsOkRtI+oHdgp708zZMXFDjTAi8Dd71eO0iCHv8iuymqCfqG5myjZIr5UhY0hXmgFqUTqmfUcVhlStzMhrKhqTeOOQNKXtZMh+1INAZv7dI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LwHNcWN7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dhqDyUVS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U6QsXc008373;
	Wed, 30 Apr 2025 10:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9hml3it80/N6Ffyr0OhB1+c1bl5KhfNxsAjjraryYno=; b=
	LwHNcWN7JXwZ5o77nhj7yjxy+PxuHJrJGNBWr+LyQGwqwTweQwy078eXAfu+Hv3F
	3n0Pm8Sq9dt40kZqPQqb1Mnr/LGNAF2tQ38oN+FncBX+qmI5XTAGz3x32lP1Mr8z
	PmhipjZ0l8wE1X+Z94a0oLHvI/bbWgRsuepwkinZ84FJP6lr84fZhBpLfQS0jP/l
	oE7Igzt6wGlZAdDyEq+YoCzendCcAQRiepRgHpaFV7ksfJMaedi0bEL9tJSzGIwG
	PD0VYLu8KfHhGeVpuFvMlWX+707DXEzpYDs6rkAtp5RnTcwfO6uxoJ9Kcg+ZOjvC
	RxNfC3WfJvba2OYaOOmVZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usgv1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 10:30:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53U9WuIh013866;
	Wed, 30 Apr 2025 10:30:50 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxb4vkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 10:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6PjzHsQ9tew+xDAX1DKKVuNvO3MQWlSLGWgWFzkXlvL85YIfRLIpcIqxHeTO2qifrsHSQHoLrEnhyJqb2pdzFd+J/YD4uesbM+JcP9dOeuVIrnJiU8JZEQlSK+OgNH24N7rNkaIvpUbRWszT/19NoprEekI+X4cHF2rvFzch7KvfzMzYUQMR2pHG5uQFoizBK0abI97JBwNfab+yEYEhFvqABh+dtD0GkwTFJenQ96yhaaIyjdP1l6e+5WEwpxGVJBB5c6NozkBuE461b6b31ETKR1a1C84E5/M+oEvs2XGUvvsKsca6TsQpkElsPSaqGBtF2w+i60+wRMPJzzJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hml3it80/N6Ffyr0OhB1+c1bl5KhfNxsAjjraryYno=;
 b=NuFIRP520f2ZUzefb0YReZ3tm+AUsEKqg7PYTQUeEDXdPSYnScPizFgJWQ38wlyD+zydKRw3YtolPHiFtQYXqCu6nPgO+J8+mDEvNXhCIO0GWArw+XYiQu96iTBc97Bf4U6nJU0VTLhjXHgz3OiizupjTctcKKLah6ckLg9UdltM6cWY7WgPravvP6MnviqKbc1rPdnToPjIdPSAUFoWjOULu07zhS3q75DpRmDFg5/MD/dyURsXiREl368MVv/K3974mn93S19ZbGK+exDPm4gjczndibGBWruAKOnbuVcAxaCyHCoZMmCAZAlSJXQsZfY7cdXIoKhhlMXsY3zw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hml3it80/N6Ffyr0OhB1+c1bl5KhfNxsAjjraryYno=;
 b=dhqDyUVSFM3CSfhXVP5YOGnMb2yZCCHi7kg1Yt0mCJdUE2JEcHGPxJRC0Yzcn+6RE/sIgfUBqp8s18x024QdrWLC85mPLrPCnw8A6g18yLkywzuqWMqaVhShzGy6MCPv3FdyCLuQj3t4wvPmYIh2M1+yn53jD6hgE1wGBOnFjGQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPFB6B52B4A1.namprd10.prod.outlook.com (2603:10b6:f:fc00::d43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 10:30:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 10:30:47 +0000
Date: Wed, 30 Apr 2025 11:30:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jiadong Sun <sunjiadong.lff@bytedance.com>
Cc: luto@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        akpm@linux-foundation.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        yinhongbo@bytedance.com, dengliang.1214@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        songmuchun@bytedance.com, yuanzhu@bytedance.com
Subject: Re: [RFC] optimize cost of inter-process communication
Message-ID: <395a7300-67e5-4fec-aa95-baf52e0bda22@lucifer.local>
References: <CAP2HCOmAkRVTci0ObtyW=3v6GFOrt9zCn2NwLUbZ+Di49xkBiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP2HCOmAkRVTci0ObtyW=3v6GFOrt9zCn2NwLUbZ+Di49xkBiw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0619.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPFB6B52B4A1:EE_
X-MS-Office365-Filtering-Correlation-Id: aa20dc32-bb93-4387-a20d-08dd87d21245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NndJclJXaGV3V05pZHFpdzBlTkd6TDFGQ3FSRnFPTzFSZlQ3ckRRZElIVnUv?=
 =?utf-8?B?SFFMeGhtd2pGVjBLcnpsR3RJMTl1RTVDT2FNc1hvTWE1Nm9iMkVSeEk3QVhL?=
 =?utf-8?B?TFR2NFEwakcvVFNuNndrcjNuVjRFSG13VEIxMkhyOUh0aXRHd3Z1VHBYbmVh?=
 =?utf-8?B?cFQ1NXZRYVFYc1JCaHF5R1cvWXlDM2ZveFB3YUFieHlHU3YyYXlucyt6V2hZ?=
 =?utf-8?B?MTZXKzhSTHBPU1lOYXZPS3R4YUs5cUorKytqVE1BZ1R5Z3lSK3ZGYThTdjBi?=
 =?utf-8?B?cnBpWWszaUFRSnhKTFFGMFgrcHhQaWVHWHA5OWo0UjR5NWhtOHh5SEhnbndl?=
 =?utf-8?B?b1lxazVOZmVUT1ZnQXNCeFcxM1c3YU0zck1mcEtoV2x4a1dLbFlpK2FkV2lw?=
 =?utf-8?B?Tnkyai9TOTYwVXZrT1NpSC9US3NzVmVyQ0xuMHo3dTFneFh1UlI2aXRiZExQ?=
 =?utf-8?B?aU9rc01acUhxbkhoREYrTEYwTXBOMThCSGEyU1EzeG9CZkxrM3RscE83c1Fj?=
 =?utf-8?B?NlpYRHhjekNIUmpwYTZ0SkRtcy9VOWNxQTVnZndMVFRvQkJiVVpvbkNLeVdG?=
 =?utf-8?B?S0lRRjVsekJEd2U3NHFjQWZ4OUlLQkJCajBNSXFEWUp1Tm9DTzBIR3dHdmNy?=
 =?utf-8?B?SzF4QWYzaUhKVjlHNFhFaDdDSmVMMlk5M3JWVG5wQkFMT0hGc1RBQk9ab2c1?=
 =?utf-8?B?c21wbWdLNGd5c1FRMk5MQktGQWdsK2pCNlhJVnBrMGs4OXU5akVITEtOR2VE?=
 =?utf-8?B?ekU1TnZpa3BEbnhlWlBQRWlWZVdnaTJ1ZFlsVXljZUhGaW1TdC8ycUZITzFj?=
 =?utf-8?B?N3c4SVJhbWNJclF5TElLMGtEWS9vcTB6VHNTVitkT2NJR0pjY1c2UFp5NXpw?=
 =?utf-8?B?c0ZPQ0RYQ3cwK3hKeGFWRFNNMGkzdkJoSUM0b25TZjNhd2lmYVQyTHc5SEhq?=
 =?utf-8?B?dS96UXU3WnhEelZObWRxcjZVWmxCTzVYVDhLTjdmUGdFQTdXZWdaVERsOE5F?=
 =?utf-8?B?RnNXMThTSG5YeGNXSWJyMm5aK0Vrc3FOdDNvMGY3L1dQVCtqTEtmZ2RNWEVz?=
 =?utf-8?B?em5mbFUzQU91WmpYQnRjamg1ZVhYbXZZNkpGSEZUaHNXVDBlVU5ob1NyMTR2?=
 =?utf-8?B?N1A4Rko2VFlMdlJBbGJveDJWQUMrVElvNUczaWVMYy9WTXFmaTVQN25TcjVZ?=
 =?utf-8?B?aW9UWnZQQVo1dG5DamovSTZsaWhUalFKVkdPUGpRekhNaGVVU3ZoQkJCcVpQ?=
 =?utf-8?B?ZnRrK0prUE9NOGx2SWhWbFFBZXh6ZXBHM2hGaFcvcDlMU1VZSHRWdHUxUVRy?=
 =?utf-8?B?WlBMaWJxVkl4dTBRdzBBdC9CQnMxdjdWYWRqVWw4MG1XUnRTMGtYVmF1T2hi?=
 =?utf-8?B?WUZvZFFtdmQyelBBM00vTWIrK3lVTmNlWFl1QWlaWm5zdk8wRHM2RVlHektr?=
 =?utf-8?B?MEgwaVVMMzk3WDFLRmZxMDJBeGE4dlVPRzlucllrSEJLUlpFOFVFMEpMaXdm?=
 =?utf-8?B?ajRrcFhkS3RrRjV6RjI0UUdDY0JIN0NpUkR5VktZT1ZNdXFkRnpMTUFrVjFa?=
 =?utf-8?B?aDVRTzdlYVJZYy92QWEwTGF0N0hPdTFXRVhjaW5VbThHWjQ4MDBCSjdQT1hv?=
 =?utf-8?B?Kzc3OHFEVkhhdU16eUhPV1RKMkFCOWhhckpEUXBOMXgrcHBnMnczREdGbWFG?=
 =?utf-8?B?SVBmTHZBVElncjhTU0NoSUhhcjJydlZYUVpyMXVpZXlNZEV0L28yYlBiQ1R4?=
 =?utf-8?B?cmJicmUycDZNTjRhVVIyMFJIamNrSkQ5eWJWWERudWtLNGkrMkhSRWlIRjlu?=
 =?utf-8?B?TW9WNzhZTnlmb0JvQWZJV25KVm1rWFJocERFbnlGaUVyVlhyMUdXa254OENS?=
 =?utf-8?B?bk90OU1NdmR5UnFpVG5POXd3WHR3WmRMSEU3K21zQlF3SldmZlBQdlJ0Ym1x?=
 =?utf-8?Q?tKvx+r5OHv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDU4WG9LQ2xWTVpydEpkVGdWK2czNFVkSzZvSVQ2VlV4cjVzYWFMVkFtcDMz?=
 =?utf-8?B?dnJsTXZjOW1xajFBeU1ldndRcVRsckV4Q2dycS83Wm82RVN4TVRESy9rWjl0?=
 =?utf-8?B?Vm1BY1lXRW4wY3IyeDB3bUhYSmVydkFidVc5Y0xMa0hlakJja0VDdGh4RllR?=
 =?utf-8?B?TU5IdXdkZ1ZVYkp0RE1sS3BCTlVpWEVYN1lNekdSYVhDa1JnWmZpWVZuQnJV?=
 =?utf-8?B?UFdsa1VrM0FEZGxtaFoxYTF6Wk95WlRMRTNkcUFRcEFFL01GNHVtanZRRi9j?=
 =?utf-8?B?aXlQQTdXaERrUmRaMnJTYk9wY3lVcWE5YU45N0g3ZTZ1VjByUTVkLzQwQWRn?=
 =?utf-8?B?Z3QwRG13RS91V1I4ZUQ4NXc1MVppbExvcE13dS9OZG8xMkRZZXVRMVFWWnd5?=
 =?utf-8?B?T05xZFZ0VXViNDNubEIyUGI3MW5pM3BnOGZxK2pyODdnM2xZLzFaRGE3TUtG?=
 =?utf-8?B?bE1IZk1GRHdYbkViTG8xZHV3SlpHSEpzcUJZWENEcEMzQXdVWHlWajFBZk9Z?=
 =?utf-8?B?T1F1OVdlQXhlaitkWkRPYjVFNm1LNnQ1OXRiUHVFVTJQOWJLbXVhUGdRdE02?=
 =?utf-8?B?RUFydEVUZmdSY21ROWRvSU5XZ0lZS2lkZWhFUllROHkrUi8wandTeGx5Z1pn?=
 =?utf-8?B?dFkzcG5DKzZkVjMvT2JXRVp2MExIdHFnenlOQnowRXlua0o4ZHBLbmJDUzkw?=
 =?utf-8?B?UTJCSUpTTHZvNGVuNVdhMEc3UmZlYVZueXFubXBtSExiR0JqclZ1a09aZDBm?=
 =?utf-8?B?aityWnB1SXcwK1JsSkc5eVp1OEY1WnVaQnBrTUMxcXRBQWIrWjk4TGtHejF5?=
 =?utf-8?B?UmVkUkt4cUhiK1JITzZhMHhBUFZLTkkwVmYxTVBnT0xiM00zRkMzYitETHRj?=
 =?utf-8?B?Y0VVc0Zwa2ttTm1SdzFLcDJELzlzSTRTa3hzcUdqSmNTd1ZkNVIwbkZaQzZC?=
 =?utf-8?B?aEY1dEE2eDJvc0tjdmJ5cTM4ZXJqMVFPd24vekZhN1pMdU92anBtZXJIcFUr?=
 =?utf-8?B?a082aVdXQ2pFRlV0NklLdy9hckQwQ2VJUjdMZVBJSmV6UTZCRE5qSjdGSWc0?=
 =?utf-8?B?MmVYUjMxdFp6b09UZVozc1hWdlVaT3o5NFZCSWRJY3k0eTg0dXltM3FMcVRp?=
 =?utf-8?B?RjlnOW1BUEhSdW5kRWZQcmJ4UC9QNzFPcWo4RVJjK1F6cWQwMWlEei9MaEx5?=
 =?utf-8?B?KytDTWptRVZvYkxOTjhJbWREdlpTKzBjSWhlajkvUjgvZ3VaUmFFUFlCRGto?=
 =?utf-8?B?L1hINlVBMGo5WjIvUTNSbXpWVk5rKzU0Nmhnc05BcjB2UU5kVzVya1czc1VT?=
 =?utf-8?B?eGNpWTgvL1JsMDIxUlUwMEJlYkdQVmE0eGxmcXBRaU9aUUlocjlXSGFzNUtu?=
 =?utf-8?B?RkRNYVJuZWsvVllmdzBQNHpHT1A0UTUvS01aN0dpWlBUSlBjWUdLRFFFdXJv?=
 =?utf-8?B?OU5lZGFON1BqNGVpbmRSdkE5UmJ5ekRlUWF1MmYzdFJ1dGtHdVIxOFdvUTlM?=
 =?utf-8?B?ZjZOdXdyV3o3ZStuUzNpdm5oTGR0eUxrOFQ2cHpOeWFqbys5QjhSN3o3RFl3?=
 =?utf-8?B?NHphSlREZ0paWENUSmxTSnh4U2RZdlVSY3JKRjBtcjJjNUVGVmIvTVBGNDE3?=
 =?utf-8?B?aVg5OWI1UmM1ekprSEhEVlhnK0poa1VCL3BIY0VVWGtXNzVJZVFKU1JMd1Bk?=
 =?utf-8?B?VGRaYUZxR3YydVBERC82UFNUN0FkTjlGMmtNWEVHRDMvR0g0dDFiQzU2UjB6?=
 =?utf-8?B?UFhxM3c2V1NGR2hVMTdaS1pXdEl0c3hzL2pvQzREOEhqSnU1dS90Q0EyOHQw?=
 =?utf-8?B?K2RzMG8vSnRMMVFHbFZDbmc0MytRZDlXTkg4QXY2anJOaDF3NzhvK01DRTFk?=
 =?utf-8?B?NlQ3ME1jUzlKOTdKT0c3NFhDSVFwQ2xNdnFhamhpQlVTVlBxUGh2VnIvLy9H?=
 =?utf-8?B?aXlSNHhycDdtZzh4WGowektqbmdVQkVSQWpTUmRYOUh6M0Q4Y3lHYzUwMm5K?=
 =?utf-8?B?TmlGTHBuTi9JTjliOGFnVzRzN0RPdU1RZkYva2dmL29PVVpZNzlJUkZGa2Qz?=
 =?utf-8?B?czVVWUNiSk5mWFZvTkFTeXlrUTJHTHRBYVdkU0xXeXFMdnE1TWxIb2NaOHZE?=
 =?utf-8?B?T1ZvNkRGNURwMjFsYlJDY2JXaG0yaUNHUjdsZGdZbkZuejFMUEw3ZXNSc0Va?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AOBpkFj0YyVfzWYe2v15J0XVna7L2JDw6KFTypvcMKLgLncbCyndXwxUiU6WVpFhUJ9Z2yCfwlOeitEMnCV4KCcM8gUIvlEHuLiKE0SYud9DDCsU96/xH3D68Zx0IauBH0PttAggxlnQzdkmHWAwrXV/wP3dN+jrOMtT2BPbaqoaBfPHY2W9vVjUU/hxjDU8oCPnSexehCxPSD11ZEicvJkO4v+gbVcXl2SI8k9rteA5rt3pYxJ8630kDfOmuSaKdw76bC4YXgLDBaX6fMGV3luW1xxki3DiqWqJDxJHaP5coSY9taXNK55RNr5eGN7hdVKzGogXUcCAutu8XOfC6T/x7XR+PyOx3QO0fEoUHWdEk3EBZAUxHLMenZg8Xs8pHt4F2EE/Z4iyEcFGkU4q4ZoVr1sgex4RpKbH9Q0mrwrO6pJ7Eo76qUeyGwk0n1DLBDqoImqz7Xb4fuQ9SWotnZ9A0n/YA3eX7cuiIrGwGTv0HOWorkoqz2OKv3XMjdUI3TzxAYihMri7k/KopXkXvj2L4FNXvpBBVnXFzlEG4jjDvfANBLtO1LFiYx2dqqpoMc7kCjKnvVwZLIaPrRl8Gs4+utoBZ0UHHs6enmNxh7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa20dc32-bb93-4387-a20d-08dd87d21245
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:30:47.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4DFc2thV9oFczyaNuXfdrpQhD+jDWZ1ksljYe1EKlLebRvILBiVs52q3eGyhzy0nYKfLT0Kx2eH7e0ewsWjW/f/4Wbo972mj+5+iuDC+Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFB6B52B4A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504300074
X-Proofpoint-ORIG-GUID: dQdN0xY1ubK9cB0aqKCutwgFg64fyvb0
X-Proofpoint-GUID: dQdN0xY1ubK9cB0aqKCutwgFg64fyvb0
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=6811fbdb b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=NTjIJ9sFOxsser-EblYA:9 a=Tde3SKi7T6zTQ8Hw:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA3MyBTYWx0ZWRfX3QL8ZSLCYOP9 0g4b+GPVc/MV4YR8zEMSrVM0U3K3omAxHbpoXmkwRbRxI16HZrKAR+mCZVapRYQJkT+7SaNPFgJ AEdY4Rt+mTpRUHP22ri+J0vnQ2Eg9n5Yuccmfd1E8R7Oc3z5FbrmsUIFuxpcD9uiRJctMQOidtv
 c17jpYFUEOJkK2VgDYMPPop0hZI81RXIJHpAUkTH+QPjqyECqK7MT3piz1d8GjAGb4XThjYvsOQ r57ajr/Rnexi4DktWbo+TMP47//e2j1p7Ty7xKXWwDpmUR1Kp+mRbtcQ3YSAcmevzi+xxWZL1WJ dr2xeInVfJp8CtV+DvuQrbr1TPQSDJeLagQtkXfCBc7LEjuSNO3P10EkiJig382rvUQl0P5RENu
 wPvPKL0B4WZph9OnXIVBC1Gd5x2ZyS66Rphthp5lf6wfPwb69oCiGUcrtFXzxAeR0hWDqdey

Jiadong, I think this would be better as a [DISCUSSION] to avoid confusion:

"We are in the process of porting RPAL to the latest kernel version,
 which still requires substantial effort. We hope to firstly get some
 community discussions and feedback on RPAL's optimization approaches and
 architecture."

This looked at first glance like a cover letter, and so I was confused to see no
attached patches.

Also you've not run scripts/get_maintainers.pl on your changes, please make sure
to cc all relevant maintainers and reviewers.

Also note there are additional changes for rmap coming through -
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/MAINTAINERS?h=mm-hotfixes-unstable#n15555

Re: the proposal:

"Since processes using RPAL share the address space"

You're basically suggesting completely tearing up process isolation in linux?
This seems... unworkable? I'm really not hugely comfortable with the idea of
essentially - changing how linux works - to get (suggested) better ipc latency?

I will let experts in this area comment but this all instinctively makes me feel
uncomfortable, and it would require enormous care.

Also I'm really not sure about a 10,000 line patch series... I am already
feeling the strain finding the time to review series as-is, and I'm a maintainer
with a really quite light workload compared to others.

This seems unworkable in this form, frankly.

Thanks, Lorenzo

On Wed, Apr 30, 2025 at 04:16:28AM -0500, Jiadong Sun wrote:
> # Background
>
> In traditional inter-process communication (IPC) scenarios, Unix domain
> sockets are commonly used in conjunction with the epoll() family for
> event multiplexing. IPC operations involve system calls on both the data
> and control planes, thereby imposing a non-trivial overhead on the
> interacting processes. Even when shared memory is employed to optimize
> the data plane, two data copies still remain. Specifically, data is
> initially copied from a process's private memory space into the shared
> memory area, and then it is copied from the shared memory into the
> private memory of another process.
>
> This poses a question: Is it possible to reduce the overhead of IPC with
> only minimal modifications at the application level? To address this, we
> observed that the functionality of IPC, which encompasses data transfer
> and invocation of the target thread, is similar to a function call,
> where arguments are passed and the callee function is invoked to process
> them. Inspired by this analogy, we introduce RPAL (Run Process As
> Library), a framework designed to enable one process to invoke another
> as if making a local function call, all without going through the kernel.
>
> # Design
>
> First, let’s formalize RPAL’s core objectives:
>
> 1. Data-plane efficiency: Reduce the number of data copies from two (in
> the shared memory solution) to one.
> 2. Control-plane optimization: Eliminate the overhead of system calls
> and kernel's thread switches.
> 3. Application compatibility: Minimize the modifications to existing
> applications that utilize Unix domain sockets and the epoll() family.
>
> To attain the first objective, processes that use RPAL share the same
> virtual address space. So one process can access another's data directly
> via a data pointer. This means data can be transferred from one process
> to another with just one copy operation.
>
> To meet the second goal, RPAL relies on the shared address space to do
> lightweight context switching in user space, which we call an "RPAL
> call". This allows one process to execute another process's code just
> like a local function call.
>
> To achieve the third target, RPAL stays compatible with the epoll family
> of functions, like epoll_create(), epoll_wait(), and epoll_ctl(). If an
> application uses epoll for IPC, developers can switch to RPAL with just
> a few small changes. For instance, you can just replace epoll_wait()
> with rpal_epoll_wait(). The basic epoll procedure, where a process waits
> for another to write to a monitored descriptor using an epoll file
> descriptor, still works fine with RPAL.
>
> ## Address space sharing
>
> For address space sharing, RPAL partitions the entire userspace virtual
> address space and allocates non-overlapping memory ranges to each
> process. On x86_64 architectures, RPAL uses a memory range size covered
> by a single PUD (Page Upper Directory) entry, which is 512GB. This
> restricts each process’s virtual address space to 512GB on x86_64,
> sufficient for most applications in our scenario. The rationale is
> straightforward: address space sharing can be simply achieved by copying
> the PUD from one process’s page table to another’s. So one process can
> directly use the data pointer to access another's memory.
>
>
>   |------------| <- 0
>   |------------| <- 512 GB
>   |  Process A |
>   |------------| <- 2*512 GB
>   |------------| <- n*512 GB
>   |  Process B |
>   |------------| <- (n+1)*512 GB
>   |------------| <- STACK_TOP
>   |  Kernel    |
>   |------------|
>
> ## RPAL call
>
> We refer to the lightweight userspace context switching mechanism as
> RPAL call. It enables the caller (or sender) thread of one process to
> directly switch to the callee (or receiver) thread of another process.
>
> When Process A’s caller thread initiates an RPAL call to Process B’s
> callee thread, the CPU saves the caller’s context and loads the callee’s
> context. This enables direct userspace control flow transfer from the
> caller to the callee. After the callee finishes data processing, the CPU
> saves Process B’s callee context and switches back to Process A’s caller
> context, completing a full IPC cycle.
>
>
>   |------------|                |---------------------|
>   |  Process A |                |  Process B          |
>   | |-------|  |                | |-------|           |
>   | | caller| --- RPAL call --> | | callee|    handle |
>   | | thread| <------------------ | thread| -> event  |
>   | |-------|  |                | |-------|           |
>   |------------|                |---------------------|
>
> # Security and compatibility with kernel subsystems
>
> ## Memory protection between processes
>
> Since processes using RPAL share the address space, unintended
> cross-process memory access may occur and corrupt the data of another
> process. To mitigate this, we leverage Memory Protection Keys (MPK) on
> x86 architectures.
>
> MPK assigns 4 bits in each page table entry to a "protection key", which
> is paired with a userspace register (PKRU). The PKRU register defines
> access permissions for memory regions protected by specific keys (for
> detailed implementation, refer to the kernel documentation "Memory
> Protection Keys"). With MPK, even though the address space is shared
> among processes, cross-process access is restricted: a process can only
> access the memory protected by a key if its PKRU register is configured
> with the corresponding permission. This ensures that processes cannot
> access each other’s memory unless an explicit PKRU configuration is set.
>
> ## Page fault handling and TLB flushing
>
> Due to the shared address space architecture, both page fault handling
> and TLB flushing require careful consideration. For instance, when
> Process A accesses Process B’s memory, a page fault may occur in Process
> A's context, but the faulting address belongs to Process B. In this
> case, we must pass Process B's mm_struct to the page fault handler.
>
> TLB flushing is more complex. When a thread flushes the TLB, since the
> address space is shared, not only other threads in the current process
> but also other processes that share the address space may access the
> corresponding memory (related to the TLB flush). Therefore, the cpuset
> used for TLB flushing should be the union of the mm_cpumasks of all
> processes that share the address space.
>
> ## Lazy switch of kernel context
>
> In RPAL, a mismatch may arise between the user context and the kernel
> context. The RPAL call is designed solely to switch the user context,
> leaving the kernel context unchanged. For instance, when an RPAL call
> takes place, transitioning from caller thread to callee thread, and
> subsequently a system call is initiated within callee thread, the kernel
> will incorrectly utilize the caller's kernel context (such as the kernel
> stack) to process the system call.
>
> To resolve context mismatch issues, a kernel context switch is triggered
> at the kernel entry point when the callee initiates a syscall or an
> exception/interrupt occurs. This mechanism ensures context consistency
> before processing system calls, interrupts, or exceptions. We refer to
> this kernel context switch as a "lazy switch" because it defers the
> switching operation from the traditional thread switch point to the next
> kernel entry point.
>
> Lazy switch should be minimized as much as possible, as it significantly
> degrades performance. We currently utilize RPAL in an RPC framework, in
> which the RPC sender thread relies on the RPAL call to invoke the RPC
> receiver thread entirely in user space. In most cases, the receiver
> thread is free of system calls and the code execution time is relatively
> short. This characteristic effectively reduces the probability of a lazy
> switch occurring.
>
> ## Time slice correction
>
> After an RPAL call, the callee's user mode code executes. However, the
> kernel incorrectly attributes this CPU time to the caller due to the
> unchanged kernel context.
>
> To resolve this, we use the Time Stamp Counter (TSC) register to measure
> CPU time consumed by the callee thread in user space. The kernel then
> uses this user-reported timing data to adjust the CPU accounting for
> both the caller and callee thread, similar to how CPU steal time is
> implemented.
>
> ## Process recovery
>
> Since processes can access each other’s memory, there is a risk that the
> target process’s memory may become invalid at the access time (e.g., if
> the target process has exited unexpectedly). The kernel must handle such
> cases; otherwise, the accessing process could be terminated due to
> failures originating from another process.
>
> To address this issue, each thread of the process should pre-establish a
> recovery point when accessing the memory of other processes. When such
> an invalid access occurs, the thread traps into the kernel. Inside the
> page fault handler, the kernel restores the user context of the thread
> to the recovery point. This mechanism ensures that processes maintain
> mutual independence, preventing cascading failures caused by
> cross-process memory issues.
>
> # Performance
>
> To quantify the performance improvements driven by RPAL, we measured
> latency both before and after its deployment. Experiments were conducted
> on a server equipped with two Intel(R) Xeon(R) Platinum 8336C CPUs (2.30
> GHz) and 1 TB of memory. Latency was defined as the duration from when
> the client thread initiates a message to when the server thread is
> invoked and receives it.
>
> During testing, the client transmitted 1 million 32-byte messages, and
> we computed the per-message average latency. The results are as follows:
>
> *****************
> Without RPAL: Message length: 32 bytes, Total TSC cycles: 19616222534,
> Message count: 1000000, Average latency: 19616 cycles
> With RPAL: Message length: 32 bytes, Total TSC cycles: 1703459326,
> Message count: 1000000, Average latency: 1703 cycles
> *****************
>
> These results confirm that RPAL delivers substantial latency
> improvements over the current epoll implementation—achieving a
> 17,913-cycle reduction (an ~91.3% improvement) for 32-byte messages.
>
> We have applied RPAL to an RPC framework that is widely used in our data
> center. With RPAL, we have successfully achieved up to 15.5% reduction
> in the CPU utilization of processes in real-world microservice scenario.
> The gains primarily stem from minimizing control plane overhead through
> the utilization of userspace context switches. Additionally, by
> leveraging address space sharing, the number of memory copies is
> significantly reduced.
>
> # Future Work
>
> Currently, RPAL requires the MPK (Memory Protection Key) hardware
> feature, which is supported by a range of Intel CPUs. For AMD
> architectures, MPK is supported only on the latest processor,
> specifically, 4th Generation AMD EPYC™ Processors and subsequent
> generations. Patch sets that extend RPAL support to systems lacking MPK
> hardware will be provided later.
>
> RPAL is currently implemented on the Linux v5.15 kernel, which is
> publicly available at:
>
>              https://github.com/openvelinux/kernel/tree/5.15-rpal
>
> Accompanying test programs are also provided in the samples/rpal/
> directory. And the user-mode RPAL library, which realizes user-space
> RPAL call, is in the samples/rpal/librpal directory.
>
> We are in the process of porting RPAL to the latest kernel version,
> which still requires substantial effort. We hope to firstly get some
> community discussions and feedback on RPAL's optimization approaches and
> architecture.
>
> Look forward to your comments.
>
> Jiadong Sun (11):
>    rpal: enable rpal service registration
>    rpal: enable virtual address space partitions
>    rpal: add user interface for rpal service
>    rpal: introduce service level operations
>    rpal: introduce thread level operations
>    rpal: enable epoll functions support for rpal
>    rpal: enable lazy switch
>    rpal: enable pku memory protection
>    rpal: support page fault handling and tlb flushing
>    rpal: allow user to disable rpal
>    samples: add rpal samples
>
>   arch/x86/Kconfig                                 |    2 +
>   arch/x86/entry/entry_64.S                        |  140 +++++++++++
>   arch/x86/events/amd/core.c                       |   16 ++
>   arch/x86/include/asm/cpufeatures.h               |    3 +-
>   arch/x86/include/asm/pgtable.h                   |   13 +
>   arch/x86/include/asm/pgtable_types.h             |   11 +
>   arch/x86/include/asm/tlbflush.h                  |    5 +
>   arch/x86/kernel/Makefile                         |    2 +
>   arch/x86/kernel/asm-offsets.c                    |    4 +-
>   arch/x86/kernel/nmi.c                            |   21 ++
>   arch/x86/kernel/process.c                        |   19 ++
>   arch/x86/kernel/process_64.c                     |  106 ++++++++
>   arch/x86/kernel/rpal/Kconfig                     |   21 ++
>   arch/x86/kernel/rpal/Makefile                    |    4 +
>   arch/x86/kernel/rpal/core.c                      |  698
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/x86/kernel/rpal/internal.h                  |  130 ++++++++++
>   arch/x86/kernel/rpal/mm.c                        |  456
> ++++++++++++++++++++++++++++++++++
>   arch/x86/kernel/rpal/pku.c                       |  240 ++++++++++++++++++
>   arch/x86/kernel/rpal/proc.c                      |  208 ++++++++++++++++
>   arch/x86/kernel/rpal/service.c                   |  869
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   arch/x86/kernel/rpal/thread.c                    |  432
> ++++++++++++++++++++++++++++++++
>   arch/x86/mm/fault.c                              |  243 ++++++++++++++++++
>   arch/x86/mm/mmap.c                               |   10 +
>   arch/x86/mm/tlb.c                                |  170 ++++++++++++-
>   config.x86_64                                    |    2 +
>   fs/binfmt_elf.c                                  |  103 +++++++-
>   fs/eventpoll.c                                   |  306
> +++++++++++++++++++++++
>   fs/exec.c                                        |   11 +
>   fs/file_table.c                                  |   10 +
>   include/linux/file.h                             |   13 +
>   include/linux/mm_types.h                         |    3 +
>   include/linux/rpal.h                             |  529
> +++++++++++++++++++++++++++++++++++++++
>   include/linux/sched.h                            |   15 ++
>   init/init_task.c                                 |    8 +
>   kernel/entry/common.c                            |   29 +++
>   kernel/exit.c                                    |    5 +
>   kernel/fork.c                                    |   23 ++
>   kernel/sched/core.c                              |  749
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/fair.c                              |  128 ++++++++++
>   mm/memory.c                                      |   13 +
>   mm/mmap.c                                        |   35 +++
>   mm/mprotect.c                                    |  112 +++++++++
>   mm/rmap.c                                        |    5 +
>   samples/rpal/Makefile                            |   14 ++
>   samples/rpal/client.c                            |  182 ++++++++++++++
>   samples/rpal/librpal/asm_define.h                |    9 +
>   samples/rpal/librpal/asm_x86_64_rpal_call.S      |   57 +++++
>   samples/rpal/librpal/debug.h                     |   12 +
>   samples/rpal/librpal/fiber.c                     |  119 +++++++++
>   samples/rpal/librpal/fiber.h                     |   64 +++++
>   samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S  |   81 ++++++
>   samples/rpal/librpal/make_x86_64_sysv_elf_gas.S  |   82 ++++++
>   samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S |   84 +++++++
>   samples/rpal/librpal/private.h                   |  302
> ++++++++++++++++++++++
>   samples/rpal/librpal/rpal.c                      | 2560
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   samples/rpal/librpal/rpal.h                      |  155 ++++++++++++
>   samples/rpal/librpal/rpal_pkru.h                 |   78 ++++++
>   samples/rpal/librpal/rpal_queue.c                |  239 ++++++++++++++++++
>   samples/rpal/librpal/rpal_queue.h                |   55 ++++
>   samples/rpal/librpal/rpal_x86_64_call_ret.S      |   45 ++++
>   samples/rpal/server.c                            |  249
> +++++++++++++++++++
>   61 files changed, 10304 insertions(+), 5 deletions(-)
>   create mode 100644 arch/x86/kernel/rpal/Kconfig
>   create mode 100644 arch/x86/kernel/rpal/Makefile
>   create mode 100644 arch/x86/kernel/rpal/core.c
>   create mode 100644 arch/x86/kernel/rpal/internal.h
>   create mode 100644 arch/x86/kernel/rpal/mm.c
>   create mode 100644 arch/x86/kernel/rpal/pku.c
>   create mode 100644 arch/x86/kernel/rpal/proc.c
>   create mode 100644 arch/x86/kernel/rpal/service.c
>   create mode 100644 arch/x86/kernel/rpal/thread.c
>   create mode 100644 include/linux/rpal.h
>   create mode 100644 samples/rpal/Makefile
>   create mode 100644 samples/rpal/client.c
>   create mode 100644 samples/rpal/librpal/asm_define.h
>   create mode 100644 samples/rpal/librpal/asm_x86_64_rpal_call.S
>   create mode 100644 samples/rpal/librpal/debug.h
>   create mode 100644 samples/rpal/librpal/fiber.c
>   create mode 100644 samples/rpal/librpal/fiber.h
>   create mode 100644 samples/rpal/librpal/jump_x86_64_sysv_elf_gas.S
>   create mode 100644 samples/rpal/librpal/make_x86_64_sysv_elf_gas.S
>   create mode 100644 samples/rpal/librpal/ontop_x86_64_sysv_elf_gas.S
>   create mode 100644 samples/rpal/librpal/private.h
>   create mode 100644 samples/rpal/librpal/rpal.c
>   create mode 100644 samples/rpal/librpal/rpal.h
>   create mode 100644 samples/rpal/librpal/rpal_pkru.h
>   create mode 100644 samples/rpal/librpal/rpal_queue.c
>   create mode 100644 samples/rpal/librpal/rpal_queue.h
>   create mode 100644 samples/rpal/librpal/rpal_x86_64_call_ret.S
>   create mode 100644 samples/rpal/server.c
>
> --
> 2.20.1
>

