Return-Path: <linux-fsdevel+bounces-56960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7047B1D1FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 07:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777F53ABC33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 05:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDE20FA81;
	Thu,  7 Aug 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Al7J09Je";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AHtMlyhr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D243AA1;
	Thu,  7 Aug 2025 05:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544585; cv=fail; b=lBN7vU90NXDyVtyBbWtcqRdBa7OaMURWbPEK5pqI4hsWwbigfhhfE5edU+vxXFyQkKGl4+RYKkZydAKJ7ROjvPRMHc2g/3qqjMgO/PfRJ6yI/QmUz6B4vLROADcP3enNQCP/+/YDy4au0AXcCfnAkaEkLYJZqpUS3EKEMWAS60M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544585; c=relaxed/simple;
	bh=UCHj7OGGgD33Tk43JlghnoPDgkZumz4iAvdNxETspao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HLRgPFq90YbKWfS1I/It1d/oh0jl8OG/VLn93ma5LY2aRaBdAUsABAy/ZUMHIbtBFVDKHCKxV63yVDUBUKb4ERSM0DYKImYh0fghNduJVCYE1hjjbWyFBzxQLIUfXO9nZub+r+2SQ0qC2kgEi94xnOQo/xVbFaYsMDKd/DCmzqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Al7J09Je; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AHtMlyhr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5774S2jP027226;
	Thu, 7 Aug 2025 05:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BLW4D7r9LH8EcVtosv/wMQKJWrVK87AYIuY0ii3PNSA=; b=
	Al7J09JeL07NrfyP22dcts7hV31LY6g2VCT54oxqA3ThXTpdvtIO6pf+sJwrPV+s
	lwyxoMW4Hqzysi//mo2TJ+m/+C1hMo3qOzb6f9RzC1ZGCV4sOR1sXcm0blqJyupw
	1j0INqOXMMSrykxC8cb3Eye4GoWTAovQMcko8f2ffCI+xnHTwVgSltSodOiz3GVj
	lRYC7G1KkbRIy7tL+QjF+AfgyrUZB2OjS15L0z0PcHZ3s93uxFAMh3out4IcdoCo
	zlW2u09sfqaQ0uEYLADw0nzm+Lwzp+oBfWQrpUKgRCM7yJapH8sziCDCf+5sxhZV
	BE1fi92Iquig21VVkvyO/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf3769-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 05:29:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5774ODMG028172;
	Thu, 7 Aug 2025 05:29:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwn6jvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 05:29:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNHGf5TxTrckoHfujMT02rJl1l246m/EZ4odTq3a2L67gmMaIwRA4pontVFurtJnwMPczWWyZ4OQNI0HBzZPeXeU4G9rkUeKQynPwBPafYsUpt+AovXA2axaVIJ0jHEEH5N9kMj0T0kfdV4YxDJM8zxLfbpQ6VQa5ROFfh0I+XGuIQKD7VUeJzEEAZMfC3TM6koWlvw46dPX0fKIaOlQB6lo2+01Zizw6EoZKpS379vLF44ScorTCWsWP8gYoCfYp1xpKASJ/xtfZnu+V3aMPN10c5vMWjp7vPlLFkoWQV5K6DuLEWaUiODFfYvmfqg8PAs1/v4sBm5EFfVej6Puig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLW4D7r9LH8EcVtosv/wMQKJWrVK87AYIuY0ii3PNSA=;
 b=sDxZaMkFkEv7GDehrmRMOzYh45S6J+krDWdqFzQ+2OaBUZ5yvjZpRvgm+zHYx/w7Bzc17QWaR8T/M8yzKIfDQvWAsKxoR4mnbwJn8BnhUtEB4gghdZiq2QIybRuboOf4buhrlrAxA4uYoaC5EvLa7Uh+Je09Z7ekQVpS3AYz1Nr9oNBcTBrGprIhG88Cr3VlapjX/s4qG3iR5xIXYqhnPo5oAVikkbraURnWuY6QHRjuohEzg/w/7DBklkcQ/vGGk8GZDSAKxJBkV9YCLWpn4Rr2l9TAtrSYbaSC+YicscfdQfxUQU1IGMxj7Maclrndr6iTuQS6Ri74dVEaF7oVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLW4D7r9LH8EcVtosv/wMQKJWrVK87AYIuY0ii3PNSA=;
 b=AHtMlyhrB60v2i3tznQKebzpNd4TN1Z9sz46i6TH/kcFMUku+tAinnkuxQQSmHfVHcuhjElwUA1ub5D4EtCNgTURNuQGMZb+MMeVJThx3ozhh4FqljOprO4SEu/25Ub4+scuT2MU3E8EEBiuyEfhVMPFu1Ndxz4OdJ9VRlTqqr0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5734.namprd10.prod.outlook.com (2603:10b6:806:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 05:29:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 05:29:05 +0000
Date: Thu, 7 Aug 2025 06:29:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
Message-ID: <5aec892d-7bb7-4258-bd51-c3df60b5df9c@lucifer.local>
References: <20250806155905.824388-1-surenb@google.com>
 <20250806155905.824388-4-surenb@google.com>
 <8ddff47d-3059-42ea-b022-6151da513049@lucifer.local>
 <CAJuCfpEntig+s6GNSERvMJBY=LNWNd_9CraxG7-zkwK1KF882Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEntig+s6GNSERvMJBY=LNWNd_9CraxG7-zkwK1KF882Q@mail.gmail.com>
X-ClientProxiedBy: AM4PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:205:1::48) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: b367fb08-c96a-4611-149a-08ddd5735368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzFmUWZ3blFRdVBrTU1CdVFZK3ErY3loV1VLQXZ3VmFycFFmZjdiT3FNc0xO?=
 =?utf-8?B?amxiZWRGcjlLWGtReGFhZEVuakl5SHRLRTRrUHh2MlpuekwxOFhDOThoZnVC?=
 =?utf-8?B?bUVaREJSOHZkY25hNjM3dTNocno5SUIreHpkZWd6UnI3Y0VHZ3hjdlBZUUV3?=
 =?utf-8?B?L2E2OEpuOHh0YUZraVZ3S3BpRFdSdHRHcXVyQ25wU1ZCU1pJeElYR2o2Q1Bl?=
 =?utf-8?B?cU41UjRBMW1yMGRCM3JoaWpXRXpzRW1Uc2N1UUY3b1dEektNeG1CUE8vUzJT?=
 =?utf-8?B?cDdTNWpyc3hlMlBlVm4zN09hZGlkaVM5TVMzdWFOZWxJZ3VCY002T3RNc2o0?=
 =?utf-8?B?a3QzVkQ1K1oxOUplZU1VOGQzZm1rTzVvTDBnRjZPSEZkNHpMeTRFUXZLUndG?=
 =?utf-8?B?clc0Wnc0S2VFbG1DeUswMjNJcHA2T0w4aE1tMmFVTkxHM3orVFhJRm5yVEh3?=
 =?utf-8?B?ZkhSbENTbTFZUHR5M1FkRWk3eGdBc3c2bFU5anNZZFFMU0Rub21ycC9BSk55?=
 =?utf-8?B?UnhuaEMvSlZyMUV1Nk5haVV4bUVqV0Q0OENSN2FVNWFTa1RhTXFnQ1BEdHMz?=
 =?utf-8?B?NTVjNkU2cThjdnZEUUhaZ3ErTXhQTmdRMnRkSHRtbEIrUmtBbmhKTGsyaU53?=
 =?utf-8?B?SCtGc0tTYWdacHl6NU1Rb3NDRDc1bGI2VmRkTEt1SnBYYytZaFZXM0RjZE5i?=
 =?utf-8?B?VWVUTi9ZKzVQTi8zeDgySllOYkxmc1pCVGlpYS9tcDh5SzJvdGJkWXl0Zmdu?=
 =?utf-8?B?b3BsMjFYVjZQdHdrUWpzY20wVU9MN2N4c2tQMndmakxaSVBCY2d2cE43V2JO?=
 =?utf-8?B?R2VTTjVrSVA5YjZXVWtUaCt5MnZhRWk4SWw3NmFNVUI3cVhGN2V6bzByWnRm?=
 =?utf-8?B?R3NZbzNZTTVOb3lNZmREcTRMTzltczU4WTc1M1Y0VEZaT0N4b21zc2RBSkE1?=
 =?utf-8?B?TzFxZ25KK0ZRa01TVGg0eXdkelExcFdzUkFuYXpSVmZ4eTdMa25wZGJmbk5Z?=
 =?utf-8?B?WFVjY0lmRnZ3Zjg3M0RYUlo3ZjFJdUk2SGRraUZhT1ByQS9TTElMczh5dFNC?=
 =?utf-8?B?VTJVd2MzZ1pGRVZva0xwSWZ1N05yVGg4a3FQamJoai9iZTFjWWNLbkpHUHpK?=
 =?utf-8?B?Z1I4YmIzNS90djU5cGp2MzZsY3ptZ3lmbGtWdXlWcWVZMkhPL3FST01tTnNW?=
 =?utf-8?B?Uy9GeFEvWVF0TXMvRmZWYVlSaGN3OUN4Wm1WUFIwV3FLeGhBaVB6N01JbXNw?=
 =?utf-8?B?Q3NGRkVMU2lna3kzS0dkL0xXSFludWdwTjk1bGVhUUlpNVBvaEFObzlPNW0w?=
 =?utf-8?B?bzNxbDAzUjFUNnZRZ1JQWFhaNzM4QTYwY0RWM3dkZTdLeGg2TXNLVDhUbGlD?=
 =?utf-8?B?NXFZa3NIYURXU1prRkQ4T09kTS9Xb1FUZHJSVGNBL1QvWWlKcVZPU1J6NjR4?=
 =?utf-8?B?K2M5a3dhYk9CMEwzekFTUWN2MTlJd1NKQWpCS21HazVUZ1BRRFExQWZoRkFk?=
 =?utf-8?B?bHFTcjZPQmtPRmJ6N2JxU3JqZG9IN1R4MjM1UENDT0tJSDhiQ25jUlhHNjdR?=
 =?utf-8?B?aElXMW9VbEhRaFZEY01sU3BybGlHdXVWeUIzU1JVNzZsczNmT1lRMkJDK1FZ?=
 =?utf-8?B?M3EvQjlIMGFNbndOSVpLM3lNZnZQT3BjYnk4dDBZYlRJV1lvektkTU1kSzVE?=
 =?utf-8?B?d2gxMlRmcjNwQ0RNTGxDSHcrbEtUMXFUM3RGcFQ5ai9ETk1CVTE1U25PT3hz?=
 =?utf-8?B?S1pPRzh3Z3UrY3BtTVROTksxenJxVWh1UFpWeFJQWkVsZEJoV09LVERuNzF3?=
 =?utf-8?B?M29UZnp3djhHV2huSWFEOHdBUGtWNUdCRXAvcjRDR0hOY0c4Wm1HNEJ0dXQ1?=
 =?utf-8?B?RXFVWFlPVlFZMWtEaE1QVjdqVFpYWHNVb3dLbGh4cVNkUUFTbXpOb05TS2RQ?=
 =?utf-8?Q?R+4zGfbmzCA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGR0aGM5NlBmM2pma09mQnR3ckV0eGJ2Yzg5OEs1R2dCeGdpUHVtZUk2V0Rw?=
 =?utf-8?B?OGZXdG1HMmtteWJha0pVSGpvY0FoejFLbG54bVl0TnlHN3NSSU5HdnJhKzE4?=
 =?utf-8?B?cEdwR1BOamtnUHRJUUxMamVrVldrYy85ekk3OEFqR1lFR0paZDV6M2xTZHdV?=
 =?utf-8?B?MklNSm1qYUN2MmZXdnc3QTAwdVVUNDlwZGdXTWhCUUd2amNndXNER3pwUkF2?=
 =?utf-8?B?ZDBRQVlhVEZPaTc3YU1KSlNnVHNpMnZXaVVkaXFVb201U3Bpb2NWeGFUcjFL?=
 =?utf-8?B?Sm1WWitmeS9wYy9XSUxucUZ3a05DdTREdmNySW81SWEyMUQrN0xJOHFERW5U?=
 =?utf-8?B?NWVyQ3dhdFp0bGY4VGtVbW14OC9oNkZSTVQydWNNbXhoQTZIcENWYXIwYlgv?=
 =?utf-8?B?YktqTkw4MHgrcm1XKzVFc2xkRDlKTzU0V1RJeWxBV0kweitpU0RQSnd2V0xp?=
 =?utf-8?B?b2gyWGJ3dlU4R3YvZGZFVTMxM0hqNnlvQ2YvYzlxQzdZSGhPSmhjSzU4SnNz?=
 =?utf-8?B?cmdKZ1pNSFJza0VqRStGdDcrYlgyeDFvdXk0Q2pxNGJ2M05lUzNHdlAwWnRS?=
 =?utf-8?B?emxjcWZyYjRJVDBmek9sT2lIU0RyMFpzbFNTNnZ6aGQrTm1ZSzdxVmdFUStL?=
 =?utf-8?B?Z0NXL0lBUnlnNEZEdFZBc1lvMFkrdlRlTk53SkQzN0pLZTNCZFR5WmJDTDY2?=
 =?utf-8?B?VERvNlBBbTJpRktNYzFBMzN2WmlQdFR4Rm0xN25WZGY5NS9vbHI2aDA1MDl1?=
 =?utf-8?B?TzhqOG9ZUm4vNVU2VXE3NDZTL2FUaml0dFZiVUF1ODRqYSswVm5KVkdCaUVS?=
 =?utf-8?B?MnhFV3Nmb2N0MWhZekdWOGdRdlBGRy9VdEwrZHEzeXkrbEdFR3l4VEZjMDJp?=
 =?utf-8?B?RHdvMVNQTVI1T3NpdjBxcjdIUkZmdkpPSHRVUENyU2R4MS8zOEptTDB4ajRE?=
 =?utf-8?B?U0JxRDE2RVNnQ3dJREJ2U00vWklRcUJpVUZla3BOVXlyWmxvajVrbXRZbFVN?=
 =?utf-8?B?dHhOR2QzQnJqQnJmcG51cGlVUFR1d3FRYXAxQVJrUDZ0b3RlSDNiUDBXVytL?=
 =?utf-8?B?QzBZMXlFaThYU0ljTFEza1lhN0hmUXhEVG5tZm9vMEZXU3VvSDlYTWRrd0pt?=
 =?utf-8?B?UVRiZStGdWVBOHlBQ0F6b20rMEdsQ3FSei9WZHFRdDJSdmlzNUVrWHg2a0xZ?=
 =?utf-8?B?eVZ2cFo0WXBIR3ZYYmwyZ3dJanVpWnM5L25JOWJMUmdkaGlPYkkxdm9nbXFN?=
 =?utf-8?B?T0xnUHNtY25aWmU5RVZPWnl5Z2NzZE1MRFFnV0d1aHhSV0hTNXVOQjhYQ3Nh?=
 =?utf-8?B?MUtXWnFmN0NGdUd1WVZ1L2JzUTFJNHp1Mm0zSlF0eVpPQjRveThhNDMwc1F1?=
 =?utf-8?B?RE4vclpCRHBFR0RtUU1TbXFrYUpYcW52VFF0Nkw1eWN0cnpTa2NQbktNS1B2?=
 =?utf-8?B?VTVTeGRSdVdDbW9CcE9kTHp1TlNSMnBMYmVXbmh6dXNVKzNPVWpZSGV1V3ds?=
 =?utf-8?B?Rjdhb2NkZ3B1ekxXOCtGY3J2QThBY2Q5SjcvYjNtSHBXdTE3Ym5rcFR4eXRu?=
 =?utf-8?B?b3pIWWNXY1dSU09BQXExNE1jOUdwMzB2blU0OFQrOWhUaDlEOUVUU2FtNHBR?=
 =?utf-8?B?bDJTM0RkOUZwdkh2RnpQeU5palBMNFJVaC9rdGl2VjdDc0phSC9WZE1zL25t?=
 =?utf-8?B?MmlnZGdwUnFieHpZaXJPWHIvKzhQUFU1V2xVdFZheXMrK0pENEw5cW15TjMx?=
 =?utf-8?B?blA1U0Y5VnoxcUYzZ0NmM1hsK3ZJVmJEYmsvdVdpVFA5WXk2ZU1qUVArL2N1?=
 =?utf-8?B?Z21nTXp1bjZVRFJ0R2xMM0NxMGxTRzJkdVVkaUtJWWs0bEEyb2Z5V1FESkor?=
 =?utf-8?B?ZFk2eWpjeFhKZk9vNUxncHhnWVZSYW5Dd2tHZlFMRnh0MzJQTk9TWmZDZkZj?=
 =?utf-8?B?UWFmTXZrK2szWGRWd3gyN0F0eTVva3FNL3pxUUc1NGhQL2M4V3JSQWtqTlp2?=
 =?utf-8?B?aFBjS0N5VlY4TkxSUXIzeGo5dEJ4VkducE5NNlVWYzZPcVEwMWRQa1NxMFFm?=
 =?utf-8?B?WGNmTnp0bC9qYXlpalgvejhXK3FqY0YwL3E4akh1cmg3aG0wQ0I2aGtNdHVv?=
 =?utf-8?B?bDBrbThvM3dFRGpSVG4zREgwN1lxMGxqdmhUb3lqL3l6MzhSSStwWUVXUVVr?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IbQkv0RC1bMK/Z9H2+3DBtPn28+EJ4fiTfqccoZVqrgEV8bCOov2UCmtf/1Y5QPCUQOXr13jmzysiYJKRlazOFsqwW+vjJzlM3Xq0dpZoxZP2jD2b/REExfI+7JnWDZC115V1j2sHP1ZnzRuST48BSlKeLydxPfZzgPqMNKDgAHFR2HxqW5Tw4JGmdKMmsGwPXKYZmo0HuLttt+LZhNgCPCbDiS8fRzXmWir2EzE/fIgtnGAGn8553CnEej4Cj4Axr8tt45AEfZSHZtHCIERWmB3Gv1AHiKRWLN1YF+vW/Tzk3d1sEEOCWxaOgaCoHzCP7Lf1TiOK/p0clMIi2QQbj9G49BnKK8MEAXY0pEGI4Ab8r0OdPN4arrPJeUqTDIZ88GGghuSPbqtJX1HtcgAlXsw0//6H+QmhwI/dzB53skYHrtmBHRgsBOBgq8aK44MeBpayjEysVLHNz1UC/q+Xp5KOPE+K8WUSIr0jX5eqc1VBsSutK8Vt12cWg6Mk5ZVjyy9JVsDfsvYc9qgS9FD82czItVxzKMJd/oHD6slKihiEDNvc2IuZ5/ZincFPdIdFDZQNuF/cAaZX4oqS2HhFp2J3TiMD+eUTWiKdYR5Aao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b367fb08-c96a-4611-149a-08ddd5735368
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 05:29:05.7247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu+RJQdszqZfFu0IQ2jdYkvMMfOQLlILAE4Uh4KKlbMP5HcjhuhmeUWob10y5xhxl4+UXp9OzuYsFevnLefz/t/IJg6/WxyLu7X4HSRtfVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5734
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070039
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDAzOSBTYWx0ZWRfX8excfSOm6baY
 lGTU+BVzZEadkMD0GiMNlnHWScTUqP1LITGhodiuAxE7qR7nq/NuL0D5B+F6mkIC91hrH2uinTo
 1iwGjwhw7lTpzI6WI5ul9hiKCV4uCpXP6XPiN9SBI+JMwjlit0dElGo0/fhXv5i77x+3sxEZXD0
 z+Q52X0QZpJgcjUOX3vfUdgQtFTAOCOU44w79H0hZ0M0su35Xt6WdIX6c5u/LjLuBP6Hvf77LLA
 9QQFv+u0boWmv3X85JOMdZ3MhEbo3RXGWI5h/ZlZDxXuN2vYQi8ZKuWx5PrBR0JxnT/eokb1eMG
 2mBntJt4iguyQpqj941v1IP88gbEfCvdZ7Wwjp2logU/bjxTlR1dXmGyUQ4veiiI25AkqLPwvq0
 v+Hw4R9UUjbCKODWzc1cyweTCJFzBk73nohOHFCuWGaI4ukt3CGomGa56VxIZC8VWBgqd5k2
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=689439a6 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=yYloSVmlmldfYKNJvvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MEwMw0TrqgJ2qWt3WM3lRq2uSMCaXg5i
X-Proofpoint-GUID: MEwMw0TrqgJ2qWt3WM3lRq2uSMCaXg5i

On Wed, Aug 06, 2025 at 02:46:00PM -0700, Suren Baghdasaryan wrote:
> On Wed, Aug 6, 2025 at 12:03 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Aug 06, 2025 at 08:59:04AM -0700, Suren Baghdasaryan wrote:
> > > Utilize per-vma locks to stabilize vma after lookup without taking
> > > mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
> > > contended, we fall back to mmap_lock but take it only momentarily
> > > to lock the vma and release the mmap_lock. In a very unlikely case
> > > of vm_refcnt overflow, this fall back path will fail and ioctl is
> > > done under mmap_lock protection.
> > >
> > > This change is designed to reduce mmap_lock contention and prevent
> > > PROCMAP_QUERY ioctl calls from blocking address space updates.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > A lot of nits but nothing's really standing out as broken, AFAICT...
> >
> > > ---
> > >  fs/proc/task_mmu.c | 84 +++++++++++++++++++++++++++++++++++++---------
> > >  1 file changed, 68 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 45134335e086..0396315dfaee 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -517,28 +517,81 @@ static int pid_maps_open(struct inode *inode, struct file *file)
> > >               PROCMAP_QUERY_VMA_FLAGS                         \
> > >  )
> > >
> > > -static int query_vma_setup(struct mm_struct *mm)
> > > +#ifdef CONFIG_PER_VMA_LOCK
> > > +
> > > +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> > >  {
> > > -     return mmap_read_lock_killable(mm);
> > > +     lock_ctx->locked_vma = NULL;
> > > +     lock_ctx->mmap_locked = false;
> >
> > We also do this in lock_vma_range(), seems sensible to factor out? E.g.:
> >
> > static void ctx_clear_vma(struct proc_maps_locking_ctx *lock_ctx)
>
> That name really confused me :) Maybe lock_vma_ctx_init() or something
> along these lines. If we can't think of a good name I would prefer to
> keep it as is, given it's only two lines and used only in two places.

Yeah you're right, that name isn't great (it's hard to get naming right
isn't it? :P)

I think it's worth separating out just because I find this:

helper_struct->field1 = X;
helper_struct->field2 = Y;

Open-coding fiddly and prone to error, what if you add a new field later
etc.

It's also semantically useful to know that updating one field impliles the
update of another.

>
> > {
> >         lock_ctx->locked_vma = NULL;
> >         lock_ctx->mmap_locked = false;
> > }
> >
> > > +
> > > +     return 0;
> > >  }
> > >
> > > -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
> > > +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> > >  {
> > > -     mmap_read_unlock(mm);
> > > +     if (lock_ctx->mmap_locked)
> > > +             mmap_read_unlock(lock_ctx->mm);
> >
> > Maybe worth a comment as to why we leave lock_ctx->mmap_locked set here?
>
> Sure. The reason is that this is a teardown stage and lock_ctx won't
> be used anymore. I guess I could reset it just to leave lock_ctx
> consistent instead of adding a comment. Will do that.

Thanks makes sense.

>
> >
> > > +     else
> > > +             unlock_vma(lock_ctx);
> >
> > Should have said on 2/3, but I wonder if we should prefix with ctx_, as
> > 'unlock_vma()' and 'lock_vma()' seem like core functions... esp. since we
> > have vma_start_read/write() rather than functions that reference locking.
> >
> > So - ctx_unlock_vma() and ctx_lock_vma() or unlock_ctx_vma() /
> > lock_ctx_vma()?
>
> unlock_ctx_vma() / lock_ctx_vma() sounds good to me.
>
> >
> > > +}
> > > +
> > > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
> > > +                                                  unsigned long addr)
> > > +{
> > > +     struct vm_area_struct *vma;
> > > +     struct vma_iterator vmi;
> > > +
> > > +     if (lock_ctx->mmap_locked)
> > > +             return find_vma(lock_ctx->mm, addr);
> > > +
> > > +     unlock_vma(lock_ctx);
> > > +     rcu_read_lock();
> > > +     vma_iter_init(&vmi, lock_ctx->mm, addr);
> > > +     vma = lock_next_vma(lock_ctx->mm, &vmi, addr);
> > > +     rcu_read_unlock();
> >
> > I think a comment at the top of this block would be useful, something like
> > 'We unlock any previously locked VMA and find the next under RCU'.
>
> Ack.
>
> >
> > > +
> > > +     if (!IS_ERR_OR_NULL(vma)) {
> >
> > Is the NULL bit here really necessary? presumably lock_ctx->locked_vma is
> > expected to be NULL already, so we're not overwriting anything here.
> >
> > In fact we could get rid of the horrid if/else here with a guard clause like:
> >
> >         if (!IS_ERR(vma) || PTR_ERR(vma) != -EAGAIN)
> >                 return vma;
>
> We still need to assign lock_ctx->locked_vma when !IS_ERR(vma) before
> we return the vma, so the lines about would not be correct. I can
> change it to:
>
> if (!vma)
>     return NULL;
>
> if (!IS_ERR(vma)) {
>     lock_ctx->locked_vma = vma;
>     return vma;
> }
>
> if (PTR_ERR(vma) == -EAGAIN) {
>     /* Fallback to mmap_lock on vma->vm_refcnt overflow */
>     ...
> }
> return vma;
>
> I think that would be the equivalent of what I currently have. Would
> you prefer that?

Yeah sorry, sort of sketching this out quickly here.

Yeah what you suggest looks good thanks!

>
> >
> > (the !IS_ERR() bit is probably a bit redundant but makes things clearer
> > vs. just the PTR_ERR() thing)
> >
> > Then do the rest below.
> >
> >
> > > +             lock_ctx->locked_vma = vma;
> > > +     } else if (PTR_ERR(vma) == -EAGAIN) {
> > > +             /* Fallback to mmap_lock on vma->vm_refcnt overflow */
> > > +             mmap_read_lock(lock_ctx->mm);
> > > +             vma = find_vma(lock_ctx->mm, addr);
> > > +             lock_ctx->mmap_locked = true;
> >
> > Kinda sucks we have two separate ways of doing fallback now, this
> > open-coded thing and fallback_to_mmap_lock().
> >
> > Sort of hard to combine since we have subtly diffrent semantics - the RCU
> > read lock is being held in the /proc/$pid/maps case, but here we've
> > released it already.
>
> Yeah, plus that one uses iterators and this one doesn't... I don't
> think it's worth trying to shoehorn them together given that the code
> is quite short.

Yeah right.

I sort of wish we could have things be a little more consistent across the
two, but I think that would need to be part of a refactoring of this code
in general, so is not really relevant here.

So leave it as-is for now that's fine!

>
> >
> > > +     }
> > > +
> > > +     return vma;
> > > +}
> > > +
> > > +#else /* CONFIG_PER_VMA_LOCK */
> > > +
> > > +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> > > +{
> > > +     return mmap_read_lock_killable(lock_ctx->mm);
> > >  }
> > >
> > > -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
> > > +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> > >  {
> > > -     return find_vma(mm, addr);
> > > +     mmap_read_unlock(lock_ctx->mm);
> > >  }
> > >
> > > -static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> > > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
> > > +                                                  unsigned long addr)
> > > +{
> > > +     return find_vma(lock_ctx->mm, addr);
> > > +}
> > > +
> > > +#endif  /* CONFIG_PER_VMA_LOCK */
> > > +
> > > +static struct vm_area_struct *query_matching_vma(struct proc_maps_locking_ctx *lock_ctx,
> > >                                                unsigned long addr, u32 flags)
> > >  {
> > >       struct vm_area_struct *vma;
> > >
> > >  next_vma:
> > > -     vma = query_vma_find_by_addr(mm, addr);
> > > +     vma = query_vma_find_by_addr(lock_ctx, addr);
> > > +     if (IS_ERR(vma))
> > > +             return vma;
> > > +
> > >       if (!vma)
> > >               goto no_vma;
> > >
> > > @@ -579,11 +632,11 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> > >       return ERR_PTR(-ENOENT);
> > >  }
> > >
> > > -static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> > > +static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
> > >  {
> > > +     struct proc_maps_locking_ctx lock_ctx = { .mm = mm };
> >
> > >       struct procmap_query karg;
> > >       struct vm_area_struct *vma;
> > > -     struct mm_struct *mm;
> > >       const char *name = NULL;
> > >       char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
> > >       __u64 usize;
> > > @@ -610,17 +663,16 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> > >       if (!!karg.build_id_size != !!karg.build_id_addr)
> > >               return -EINVAL;
> > >
> > > -     mm = priv->lock_ctx.mm;
> > >       if (!mm || !mmget_not_zero(mm))
> > >               return -ESRCH;
> > >
> > > -     err = query_vma_setup(mm);
> > > +     err = query_vma_setup(&lock_ctx);
> > >       if (err) {
> > >               mmput(mm);
> > >               return err;
> > >       }
> > >
> > > -     vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
> > > +     vma = query_matching_vma(&lock_ctx, karg.query_addr, karg.query_flags);
> > >       if (IS_ERR(vma)) {
> > >               err = PTR_ERR(vma);
> > >               vma = NULL;
> > > @@ -705,7 +757,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> > >       }
> > >
> > >       /* unlock vma or mmap_lock, and put mm_struct before copying data to user */
> > > -     query_vma_teardown(mm, vma);
> > > +     query_vma_teardown(&lock_ctx);
> > >       mmput(mm);
> > >
> > >       if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
> > > @@ -725,7 +777,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> > >       return 0;
> > >
> > >  out:
> > > -     query_vma_teardown(mm, vma);
> > > +     query_vma_teardown(&lock_ctx);
> > >       mmput(mm);
> > >       kfree(name_buf);
> > >       return err;
> > > @@ -738,7 +790,7 @@ static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned l
> > >
> > >       switch (cmd) {
> > >       case PROCMAP_QUERY:
> > > -             return do_procmap_query(priv, (void __user *)arg);
> > > +             return do_procmap_query(priv->lock_ctx.mm, (void __user *)arg);
> >
> > OK this confused me until I worked it through.
> >
> > We set priv->lock_ctx.mm in:
> >
> > pid_maps_open() -> do_maps_open() -> proc_maps_open()
> >
> > Which it gets from proc_mem_open() which figures out the mm.
> >
> > Maybe one for 2/3, but it'd be nice to have a comment saying something
> > about how this is set, since it being part of lock_ctx makes it seem like
> > it's something that would be set elsewhere.
> >
> > Since we have fallback stuff and want to thread through this new lokc
> > context type I guess it makes sense to put it here but given that's the
> > case, let's maybe just add a comment here to clarify.
>
> Ok, something like "lock_ctx.mm is set during file open operation" ?

Yeah that's fine thanks!

>
> >
> > >       default:
> > >               return -ENOIOCTLCMD;
> > >       }
> > > --
> > > 2.50.1.565.gc32cd1483b-goog
> > >
> >
> > Cheers, Lorenzo

