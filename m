Return-Path: <linux-fsdevel+bounces-65879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E38C13397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DB81AA6EBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E60919E96D;
	Tue, 28 Oct 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BPIHnzXU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OAuA2K/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3B17BA6;
	Tue, 28 Oct 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634949; cv=fail; b=HJGilRSHNvROUPlXdvbx6xlljR7u5GsTDeNmv7QdXFa76v6EBqRpg/rw+2eSrJq7Oe61Uhi/sCYJVVH7rHbI5JsOl8KRo9eP0GHmjYWuLYkYSbcfW2DCXH7lHIr7XSQ9i8w4kU5n/AzSZZO34MS+h5HMwGOwvKXw2faB/2gjlr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634949; c=relaxed/simple;
	bh=klabgzNw5vCFGp2lw0/oilLnT6bJb4vUk+4xXuc3It0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CpUzHXCxteQ1kXgPnzEbuOPWEkndxvT9m9yMTc2rrky6i9URZ9EhyPfukJ5vkfbeT/TC7Rys1SFhotTfi1/wq251k9P/UZyCZHY4cF1FVLwWydVNL4MklsRjEDWn+G87HV+DYHaT/aEJScYGHuygx/UFwt8kNZIEb6m9EMZ8RJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BPIHnzXU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OAuA2K/e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NHGC022575;
	Tue, 28 Oct 2025 07:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yu+Qi/X5AZuYjEFqg8zKafB3KpSAwqUk1u9X+DDQh4g=; b=
	BPIHnzXU2KTGhR95O+pycEdPOmZBup30syo5pqE41MrwFcKLtQq45DF2qC+IXRqC
	vMJPJl1UvM5skgC3Ftn+/nyVXdABQkhzC8t6Zn/crFJpDJ0nATEZpz+K9aYFozW/
	qtTZw8rWuO3KIGw8yjCvt/1dknwzjl1BPi03ySdKtMtlu5QUtsumwKntM1iPr1um
	UrBgHGV2/VnOPtCEn0zEmeuGgY3kWSMust4h4fKg8nQHjZ44j1mhyGdM3eGfbeqz
	yiQ2M4JzrgNwMQqdRTv+QBYzCuAcU6S0iu6JDSYf/ZVQhc93jVK5h/j3Ars+v6qH
	3w/FJptmAn1y+NGk67W1NA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ynctj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 07:00:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S60BaF037500;
	Tue, 28 Oct 2025 07:00:56 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n07t116-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 07:00:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWZbmRTqzJGsU8sxZboGG8LvtzgBnLSac2ic3vgNOYGZ+nkL8CakXyTYzrafmklGd8i8vrRtnAx/FekE0zcJafX+6HkeJiJelbEu79DDQmjJ7osKTsCGAQ/YLG5e2H9KlFxhhCXSlNMxZy258mraeuRhL0yaY3Ufa+K6ieDEB3XevSAMymtStbncZOMrp8B406zW0BRCLAxuJdD2uXDgk0L48I2yVXR63mdx1FHl3AtDw1iabHjrUx4BWke63F9Y6huZbKXZABIfHJ5TbVNXY2glHxyMVhDJFN7MbSjKBrM8z84aowtLAvzMZhzCaU0WZY6BqIIQ1IB2I5yqnnkYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yu+Qi/X5AZuYjEFqg8zKafB3KpSAwqUk1u9X+DDQh4g=;
 b=tq4GOEwhHJkDhlyraNTv+oUoICxlbBmwMofYLWskwO7JBpqRgbV0mMOL841eWitGVUW7mJgF9fOpWjizqXaIxkkrQVEsC9OI5nZOjkMssQxwH7rEjNcYG6VWQ/4+yxbfDDCFx161zfXiXfrDSJM1MvhaLtcbsFwiVwBiMHsYns2B2+cDCHgrAHEwTQCKzD3Gbxqru+O69l0f6RjjGSgvhAz9PWHS85ZXjahg2GNvD00y7xDminJJj8qAFTf/X4PIsrOFlufCsWU8sSo8lExOiIgrvqP47sTXgkxw6OO1NcrX5+PMhTIdQc3LIhwuY400i9pEcHEvuv9hAzBlLZvziQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu+Qi/X5AZuYjEFqg8zKafB3KpSAwqUk1u9X+DDQh4g=;
 b=OAuA2K/er+CnNvsICO9hS88dfqyDBoNSLIsdasLUtaRIrpaCjmPyxjOxyw+Ymdtq27yZnKKaS1krfV9lU8W6pqel9v5dtUFHL5268hSgwF+4xbzT6UB6497Cukj7ybenJtncOLEGG+5xMYBK7A99ncZ/mH7ytnT0/qpnQVegZd0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 07:00:53 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 07:00:53 +0000
Date: Tue, 28 Oct 2025 16:00:42 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>,
        Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com,
        akpm@linux-foundation.org, ankita@nvidia.com,
        dave.hansen@linux.intel.com, david@redhat.com, duenwen@google.com,
        jane.chu@oracle.com, jthoughton@google.com, linmiaohe@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, peterx@redhat.com, rientjes@google.com,
        sidhartha.kumar@oracle.com, tony.luck@intel.com,
        wangkefeng.wang@huawei.com, willy@infradead.org
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
Message-ID: <aQBqGupCN_v8ysMX@hyeyoo>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
 <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo>
 <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
X-ClientProxiedBy: SL2P216CA0210.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e555ee-0fd7-4ed0-02ab-08de15efbbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnRUTEloZGNWbHlRR3BZU2Y0R1ZEVkVRNVRpQ3JCd3NkRm5YTi9UaUVCQURE?=
 =?utf-8?B?MDZJaDFocEFwVTIyUUVtN3FOU0tScEtEZzFTVlVDc043cVBuKzNwenRvQWcw?=
 =?utf-8?B?ZXAwTHQxMnRZTnAzdTNyS3pJWFZJb1FVZW10ckZmVVUwbGFuUFpYUEtEOEdl?=
 =?utf-8?B?MTQzSFErNHhaYVRxRGxJQnRsK0pjczhFdEs1K1IxR0pSbHpZR0FOU1dtTzZh?=
 =?utf-8?B?TkE3aFNTVnkzZ2xjZ3UyU3NUS1h6TzJSVm9hZnJMYjJFYTh6NmhzSG1nRzZq?=
 =?utf-8?B?WVpoKzRHUlBSNUQrRW4yZExtUzcyZ2tDTE5nMXdHeXZjZ2lhbC9URGhtM0pC?=
 =?utf-8?B?VXFKdEdDRjZMb0p3anNKSU1uV3FzVjdLWHZkQldTY0kxaFppbFJPWm0zS1V4?=
 =?utf-8?B?Mkl0Vnc2QkxZSk0rWXJCQTBvdGxKQXFGdG9VU0EvdzFxN0N3OUM4RDh1VUdJ?=
 =?utf-8?B?UjlEMTVFaFRLUTUydXlybUlIY1BJMDlEcmk3djdERWd0Tmk3Y1ZuNzBISjRw?=
 =?utf-8?B?dWEzV1NwcXg4NWcwZzNyZXZNczFLaUVpdzhRVSs4SGFmVHM4OWk5L0t1Wkwr?=
 =?utf-8?B?WDRPSkI3djRjYVUwczlaNEE3Q002bmdtV2ZucHpRL1Rtb240dkllTEp3alV0?=
 =?utf-8?B?T0RNWG51Q1RsQ2RqVFgzd0hjVWVtSmkzVzA1cVEreER0ZnUzbXdjYnhOSUxy?=
 =?utf-8?B?dGJzY0Ird3ZSZXZSekpQNW91Qi9LdjRkWUt0dStUdjZWWXg1YVROQXlKaitt?=
 =?utf-8?B?TWkrME4xbVJaRkpXV0U5akNFT0JJYmJlSGlWS3RxL1ZpZ1dTMElhOW1kcHFZ?=
 =?utf-8?B?WVpkUjhTMEg1SWlqOHNnZGFTNFZxNTZtaHMzd3AvdkxqTjE5Q1E0L0hDeE0w?=
 =?utf-8?B?eDVvWVAwSWs3SE5WRVltYllGTElvQ2I1SmxHSDJKSlhLOXh3U3ZybmVhN1d6?=
 =?utf-8?B?bnhRNCtPRUpYMFdhY1lWZFFVak9EY3RrMVdJWjhNamtIWFdQcWlhWCswYWpP?=
 =?utf-8?B?WFlKQ3NjQW5oZDJZUVFpaUcvcUFUQTNEYWdBYmc5allydVpxU1hMRjY0eG5x?=
 =?utf-8?B?QkNoUWtISHhCT1NCWWNMcFdibXRWYW9RaHlYRndYcHQxTFA4L04wNDBQSEUx?=
 =?utf-8?B?cjFVbUVZczNxVWlwajhQL2RFMVJSbEJZUytEYnJ2SkV3cGJwRDgwSCtGMGhP?=
 =?utf-8?B?TTlwdjk2aDU5OUl1dTQ0d3lXa3g5djUrKzVKWUt4a0swVGhYRUlWTmRLRXZj?=
 =?utf-8?B?UzQyT2QyRVpSVVF6U3lNY0E1WmRabFFPZmdITkpwY0VLS1plcFY3RW9FWVBo?=
 =?utf-8?B?cDc2UDM3VG1KdWw4aWtnaGZQazB3MnM2cllIUGJpVmhwcmJMZ0RlVHdBZHJh?=
 =?utf-8?B?OTQxR1NMSmZ1Rzk1YitNUWJ4Qjc3R0JjSVRNRFJrZkxjWG5lOGpvQ3RseXBq?=
 =?utf-8?B?ZTQ3Q1EyQUhuZGttRlo1WUp5ZmhaSEYzaCtieURJMGxTRVRya2JCWTcxRktV?=
 =?utf-8?B?Y054RVh2RXhSR0dGbTMvWDhuN2IrL1U1Qm1tV0FqMHFUMG0yREtlT0ZxNkQw?=
 =?utf-8?B?OGg3aTd2ZUExcXM4WkVZVkpGS1NpUXU2anpuMjd2UjV4SFdPQnpFTXprc01P?=
 =?utf-8?B?Z2VEVVVROGRGN3JvLysyTWo3WDhqR1ZnMlBTQzBaN2xCQ1pEMnZpR1A1b0Jh?=
 =?utf-8?B?UFR0bGUrUWVLM0V5azB4MnlZTDRYYWpKK3BpS0VkcWRhNEczR0tERTdtdXFQ?=
 =?utf-8?B?SS91eVBveUZtVzA3ajRuNktKZ3h0aFZjd0ZTbFFZUjZOOEJEOEtlVmhLVjJ4?=
 =?utf-8?B?NG9lQ1RZU2NNUEFuT3l2Y0RhUnA4aFdveko4R3hWc2xObWR2L044ckpvcXBa?=
 =?utf-8?B?emJwVytlbkxNNW1qUVBGdDdhTjFQZnZlNldwd0I5amVnSmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3IySkxjbHZicVhVcnNvRFRxZTg2dHZLQ1ZsSlZjSGVIMVJxQ0xNYU0zWURw?=
 =?utf-8?B?RTEyVFdBNmZ3SktqMkVISG1BT25TT1NHMCt1UU1ZV3M5aVl5K1k0K29tM0o3?=
 =?utf-8?B?TEcyTzVyTUN1L3BYcXFCeitxMjNYOEZhdTdVYW1QbXJwMTl6eU9BR3JFQXE2?=
 =?utf-8?B?RWJuRUpzL1VxSTVSNGk5NlEvTWhkSHJXSDRPaWw4T1E1aTE4MGZTRFZEZWQw?=
 =?utf-8?B?UXFTTWZnU0s5NVNXaGk3QS9Gb1JFRWFxeFFwTGxQY0xFa0U5OUZta2tnMmtn?=
 =?utf-8?B?Z1FaOUYyV1V5MTJrOHZpWlNoV1liWisyZFZxRXRVWU5xNUtXYkhQSGFCT3Fm?=
 =?utf-8?B?TVFjeTRjR3Z0QW82ZUpIR1lEYWpiaHEydFlWQmJOczVYTVhoZ2FSbUo0Q2x2?=
 =?utf-8?B?cE1lMWFwbFpEbkNHcWJkUk5jUlRnNFpOT2VsYWZzYjVBdGx1MlAveHVCc0ZK?=
 =?utf-8?B?M3BJcklqSkNqcDA4SXQwSk8zQnJEQitNakcydGtLTFlEMzlZU1VJOEhWb1ZM?=
 =?utf-8?B?bWNaU0U4N2ZoRjFuQ21CWmlhd2Z1MlVlNUdhLyswVXZiUDlBZ3pMUmMrb2NB?=
 =?utf-8?B?eUV6bDY2akZWQS85Y2t1MnN6bzRrMncwblhva0lHbERGdHNOVU9yczdEUm1o?=
 =?utf-8?B?enhXTFRhc2VPRUc4Zi9ZWmhoV0hTOElXSGY2MEhEUkErZEZOeHY4bXdXdUQx?=
 =?utf-8?B?U1ZSbkhxa0F2WWRrN0MrTzZ2dk5CekY4V2VZMy96Y0E0QkFrRXZ0YXlkbUpQ?=
 =?utf-8?B?Q0Fhek45NENsWGluZEFoUitWa1FwRmp6WSsxcnVnQzhoTktZcmxyazFoMXhW?=
 =?utf-8?B?Mmo5QWc2K3VKUVI2c1E5WVRkMi9NUCtvRDZraWZhWWJQby9UMTdDMVlFSXdk?=
 =?utf-8?B?K29UYW1RbjNDSFJOTVYxTDJkSjNud1NlY0NhYTMwOVFyeDNVdW9BbzhJaDZs?=
 =?utf-8?B?VUlrV283dFJHZmF4VGFzcHU5OE5lOUVwSVBMdk9KaTVxUUNYTThaa2VsWTBN?=
 =?utf-8?B?emhRM1hpc3gvblNOc3hGT1BidnVhZ0NrODk2cktWWDM2S1hxL1RiTFdwSGpU?=
 =?utf-8?B?eThFMzhuajZKSEk4MlpKQ1RGSktoZzk0K3ZSNmNSTEpXc2IxVDFkUGdnaDZ1?=
 =?utf-8?B?ZlkrTlpPTi9SQ2ViTjJLb0pnNDBUL3BjUjJramdWb09QbEdXdnZCSTU3dzZG?=
 =?utf-8?B?OVo1K0dqZURadkRrdTdZc0tzUHdYeTJmK3Jqd3BwVlFyaWMxV2R0NTFkQzZN?=
 =?utf-8?B?V0g4T0FBSFVzUTMxY0hDcTVZTXZBaVRaTkIwMWJQeHBxNVBTLzZlNEJiMGxV?=
 =?utf-8?B?Wk5Gd1V0V1FTTWhobW5oMkxsRmlXQWU0NWVrSWRmczlVRjRRb1JxK1ZRWm4x?=
 =?utf-8?B?VHRlanRnK0lIU3RUNUdzcGc4YXpVUGN6aWlSa0lKdjNhWG1telE5Y2YwU09p?=
 =?utf-8?B?R2ZWSXl4RDVaWWgrZjk1L1lSaXBmUlFnUlF5MXpJSURWS1VEdVVncHpEUHU0?=
 =?utf-8?B?VTNhK2E3VU45Q3AxUE9xQlVpcDgzQVp5enM3TkJHNVlhM3RxMnBpWVZsbUVN?=
 =?utf-8?B?a2VXY3JDeWs3VGIzaHFNdzd2ZEtSaEN4L2NFK1J5cmdXUlF6T1p0TUJVUk8z?=
 =?utf-8?B?dWdHVkNYTlY5V09MakRWaTYySk11Z1FiNzlId1FML2NCU3JkTFVQRU1mZWIv?=
 =?utf-8?B?T0FXNFVnOEV2NVlNZ1Y1Y2VJTmtadVhTMnA3cDZKU0tVZ3VkejEyMGRuRC9B?=
 =?utf-8?B?NDViY1FwRWszK215aUxFYmtaM0ZmV3F5dHErZ3hRTi9XUjRSYUsxR2FtTWlI?=
 =?utf-8?B?ajJGYzZibEhrMFREQjB0ZzVvd0tRS0g0d1hIYWFNL1g5bCtvSmErWHJHVGgx?=
 =?utf-8?B?eU9vWGY5NGdjUzcwUzViTks4ekVXdmpmL0lFNlhRejM5b00xeUdPWUtHUysx?=
 =?utf-8?B?QUo4WExpQzlwTWVrNU5VWFNQQVp1SDk1eVR3N1lJd3lmamt5OFRoTnVNK0VF?=
 =?utf-8?B?TjJncGhGNjFIeTMxOHdpVnMxbzNQQ0xuOHFteDZrSjN6YjltQTJvdXFNRlla?=
 =?utf-8?B?ZXVPclh6dmZlcmhaS3FES0Y5SHgvNld4RnhIWkJEVEoyQXBQMHdHQWRaSEZV?=
 =?utf-8?Q?hjxy/GKGspqWpDq2mAIy6/Wq6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Hj2gjihplLtJyX8afqZV0y/J/KIN1uoddEr9GJt5PaEEOIR0G3BATAflwAVoZmib7xAAZYflfi3d0xLK4MFSo2GhdhvKFBPj/GVozcQ5x48b8NKjuuu5XAFRacHgkrL5sI1DW1WTkxc+yaIHy+nf5gceYvEnscrXpzrY0bOxh++S8Yz5MGr89lC8PKlvUwa3EFtO/2uVf4+36ZAh85Lr4jHSTUhPh+H6HbZm7pOnNupOayjYpmQIybz7JUyN72Yj3E0cCBFrFxLrtLgBFPgLYQvswWL2q/L0hjempLCpW6XGYq+AI9bXLxEFnGuHIsfy6ieJ5yV2RC2Ai3qn34iZSvFmPlmu6L4BNFKJR4vuU6BBQWC14JdpC10w2t0RnI/QFhCP7h1lTRT7mozE8PJefY9gK6rBqFZkU2/ijw2DT+rFWziLlQq/fv2B+ahmsbGy9Hrbw2IdOyJfsPEbFr7p89Zeik5E6gXxWkgSxdoshGOfC5swS7vhyROFnDWHAiPwOInkTRnYmobfM+vCMtvK2+b6QE20F1PdKAxztKPIZvDY+LyenJmSndaVsfuHhTNSK2+g0NMdfIxtfcPEAZQA4+sF5O8RnKbFh7YV3iwOZM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e555ee-0fd7-4ed0-02ab-08de15efbbea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 07:00:53.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEg2L6lnuOaDaq5csmmRAMrM3rAV7PL1e5Fjx0SbcZ8U58bfRrqFwo5vZ8Epg5JxFtqHAR2oIdfYKaBvmtL01w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX2frPXlbGtedF
 cDinjJD7UNoxS7RqAghNpnGoygZPfvVEKgg9MvXHd6zUEtvjJWFZ6+fuwaz451kvtGhCIpfNUOZ
 3bOFTgsq4jTmSkYRbbKor+QUb7H7qgoYi2EE6Qc5Xf/cnqL7AkpcOcP/8QGvzfbnyTBOn0QQq3p
 u72ZbgIFkdJbp9uSogFRu8cZd2N4dxbjja8rx+63+xtyGQpAgtJXsrBHGANTvVFA4P7xowfIg4A
 FlR8VRmPsWVNPFs5kxMwkjdJ85ruQ8gQaThYY52wltLxGUgYQJh+uxcHrrlsnSUp9vrWc0F2gHE
 J5alxIYgfQee0HwJq3kICsc5t395CM8VWmsiV6xqEmQyLCKdZiHQ+7G3GhOIkm/9QWSrj4thQxN
 7sGZScOIWTe4z/FIM/9QQHqqvWZv5Q==
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=69006a29 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=qCB-ZoofDaTn7ULJGZIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-ORIG-GUID: Bv0-HvOFpmyPQkzPuhXWrR7kReEiDt_B
X-Proofpoint-GUID: Bv0-HvOFpmyPQkzPuhXWrR7kReEiDt_B

On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
> On Wed, Oct 22, 2025 at 6:09 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> > > On Fri, Sep 19, 2025 at 8:58 AM “William Roche <william.roche@oracle.com> wrote:
> > > >
> > > > From: William Roche <william.roche@oracle.com>
> > > >
> > > > Hello,
> > > >
> > > > The possibility to keep a VM using large hugetlbfs pages running after a memory
> > > > error is very important, and the possibility described here could be a good
> > > > candidate to address this issue.
> > >
> > > Thanks for expressing interest, William, and sorry for getting back to
> > > you so late.
> > >
> > > >
> > > > So I would like to provide my feedback after testing this code with the
> > > > introduction of persistent errors in the address space: My tests used a VM
> > > > running a kernel able to provide MFD_MF_KEEP_UE_MAPPED memfd segments to the
> > > > test program provided with this project. But instead of injecting the errors
> > > > with madvise calls from this program, I get the guest physical address of a
> > > > location and inject the error from the hypervisor into the VM, so that any
> > > > subsequent access to the location is prevented directly from the hypervisor
> > > > level.
> > >
> > > This is exactly what VMM should do: when it owns or manages the VM
> > > memory with MFD_MF_KEEP_UE_MAPPED, it is then VMM's responsibility to
> > > isolate guest/VCPUs from poisoned memory pages, e.g. by intercepting
> > > such memory accesses.
> > >
> > > >
> > > > Using this framework, I realized that the code provided here has a problem:
> > > > When the error impacts a large folio, the release of this folio doesn't isolate
> > > > the sub-page(s) actually impacted by the poison. __rmqueue_pcplist() can return
> > > > a known poisoned page to get_page_from_freelist().
> > >
> > > Just curious, how exactly you can repro this leaking of a known poison
> > > page? It may help me debug my patch.
> > >
> > > >
> > > > This revealed some mm limitations, as I would have expected that the
> > > > check_new_pages() mechanism used by the __rmqueue functions would filter these
> > > > pages out, but I noticed that this has been disabled by default in 2023 with:
> > > > [PATCH] mm, page_alloc: reduce page alloc/free sanity checks
> > > > https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> > >
> > > Thanks for the reference. I did turned on CONFIG_DEBUG_VM=y during dev
> > > and testing but didn't notice any WARNING on "bad page"; It is very
> > > likely I was just lucky.
> > >
> > > >
> > > >
> > > > This problem seems to be avoided if we call take_page_off_buddy(page) in the
> > > > filemap_offline_hwpoison_folio_hugetlb() function without testing if
> > > > PageBuddy(page) is true first.
> > >
> > > Oh, I think you are right, filemap_offline_hwpoison_folio_hugetlb
> > > shouldn't call take_page_off_buddy(page) depend on PageBuddy(page) or
> > > not. take_page_off_buddy will check PageBuddy or not, on the page_head
> > > of different page orders. So maybe somehow a known poisoned page is
> > > not taken off from buddy allocator due to this?
> >
> > Maybe it's the case where the poisoned page is merged to a larger page,
> > and the PGTY_buddy flag is set on its buddy of the poisoned page, so
> > PageBuddy() returns false?:
> >
> >   [ free page A ][ free page B (poisoned) ]
> >
> > When these two are merged, then we set PGTY_buddy on page A but not on B.
> 
> Thanks Harry!
>
> It is indeed this case. I validate by adding some debug prints in
> take_page_off_buddy:
> 
> [ 193.029423] Memory failure: 0x2800200: [yjq] PageBuddy=0 after drain_all_pages
> [ 193.029426] 0x2800200: [yjq] order=0, page_order=0, PageBuddy(page_head)=0
> [ 193.029428] 0x2800200: [yjq] order=1, page_order=0, PageBuddy(page_head)=0
> [ 193.029429] 0x2800200: [yjq] order=2, page_order=0, PageBuddy(page_head)=0
> [ 193.029430] 0x2800200: [yjq] order=3, page_order=0, PageBuddy(page_head)=0
> [ 193.029431] 0x2800200: [yjq] order=4, page_order=0, PageBuddy(page_head)=0
> [ 193.029432] 0x2800200: [yjq] order=5, page_order=0, PageBuddy(page_head)=0
> [ 193.029434] 0x2800200: [yjq] order=6, page_order=0, PageBuddy(page_head)=0
> [ 193.029435] 0x2800200: [yjq] order=7, page_order=0, PageBuddy(page_head)=0
> [ 193.029436] 0x2800200: [yjq] order=8, page_order=0, PageBuddy(page_head)=0
> [ 193.029437] 0x2800200: [yjq] order=9, page_order=0, PageBuddy(page_head)=0
> [ 193.029438] 0x2800200: [yjq] order=10, page_order=10, PageBuddy(page_head)=1
> 
> In this case, page for 0x2800200 is hwpoisoned, and its buddy page is
> 0x2800000 with order 10.

Woohoo, I got it right!

> > But even after fixing that we need to fix the race condition.
> 
> What exactly is the race condition you are referring to?

When you free a high-order page, the buddy allocator doesn't not check
PageHWPoison() on the page and its subpages. It checks PageHWPoison()
only when you free a base (order-0) page, see free_pages_prepare().

AFAICT there is nothing that prevents the poisoned page to be
allocated back to users because the buddy doesn't check PageHWPoison()
on allocation as well (by default).

So rather than freeing the high-order page as-is in
dissolve_free_hugetlb_folio(), I think we have to split it to base pages
and then free them one by one.

That way, free_pages_prepare() will catch that it's poisoned and won't
add it back to the freelist. Otherwise there will always be a window
where the poisoned page can be allocated to users - before it's taken
off from the buddy.

-- 
Cheers,
Harry / Hyeonggon

