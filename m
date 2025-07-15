Return-Path: <linux-fsdevel+bounces-55006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A67B064F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A7B1AA68A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FF0280033;
	Tue, 15 Jul 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8WWoJEG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P2hZh9TQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2B1DE892;
	Tue, 15 Jul 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599456; cv=fail; b=LOV5uZ6T5VY+3NQFTLMj4RSookhmBFRfXUJbdZSsQXRmtkayYWPHEaK1rAXJY2nR7bgEwFofOpB7sOidgGNj8zp6s6M/6aYTALOT5axpFpnyHHgZTZs8OJM1lCDDrnzSo5HhFs7MnhMNPHplsrOcDqYUkM1BGK1RQWy86NfpdJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599456; c=relaxed/simple;
	bh=PgQ185ZDmyYs8N5Z0HQ7B1mEvAH6F3XK7f/p9xzs2Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WSsJYDInWedxMcjwcwfBnbHC/XH2yAY0JP2wO4WJ8acuextvAUCeLxuNa1NpYeLfbgUIMeVTwbPw0E6bUhIOYveObubnG2AHvy2wZEEGxk/Bex3kuvZEMsMfY3UBjtGXQ7SN6wVcFARv4djzIxoF5+dTpljJVPaSqJejHE/rXY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T8WWoJEG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P2hZh9TQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZEN2031245;
	Tue, 15 Jul 2025 17:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PgQ185ZDmyYs8N5Z0HQ7B1mEvAH6F3XK7f/p9xzs2Ho=; b=
	T8WWoJEG+KF0iZU25KneKK7xU8VXR/UVFEBZvG+4QMRMoaQ9xrdsOCmh3cCyHmU4
	jz1RAMsQH63l8c23wz18g0wk6/X7rCJsr9LI8rAcXs8XwhFYg4wXFkcB4g7RrLL1
	OzM2C4C9zWafS9djlFZwDCkczsns4NyahRNJouLi5CeTaeTPJH6WXICSVbAkMwej
	AAk1mz4Da4SYY1fdgwjux+/7/kxwfgmydMBtWUHEBc2UKy02RpiG8MpzqnW0B4tB
	vgX4qKV3K7jRgFSI+8cgg99zR4V981PlZU06s4U+xcML7qSNEvX9lPJGjZ0TN3jq
	Zc2z6s+nbh5kjszeNNU1PQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fy7gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 17:10:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FH51cc040319;
	Tue, 15 Jul 2025 17:10:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a9hvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 17:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve+8l1iqf2Y9YoBQoDG+O7Pn6ObAVvZ6EQG3LZ3tIMs4FIRJ4JvJYn+dF1jOh7GN1d7ilHKWi1p+oi1JIsoQkarv8iHWlRtLECsPGQY3rGbg0+RgO3tL/wduXDPdqTw4Mkb9LxI1AjbshY5/gh3pqntmSe8fW+v8fQMgXRAb6JHAZweZ29GJx7c7IHk1kVQp9Q6j62Kk7kpZOhx2sR4rWRgKOD8tle6XeHhAydZ383JP3gbmC4UL0/aK8WR9f3zBfq90DlqHGZCafw1bTirvGhJ1+qhJut3LldtouOk6+AXBMIVgm+JFp5BUeQk8n2bQQq2X7r9579X3hjLRxkhuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgQ185ZDmyYs8N5Z0HQ7B1mEvAH6F3XK7f/p9xzs2Ho=;
 b=TwoLcDjzPl+VDzFr0zaQt1Cxef5x+N8ct/6OCdGRUMZMY+teJKPw/tvBhjR/f3KakRGN+PLObbdvUijsabC6DH3r6Z9gISqn7296ahL0einMXvj+aUXUPrVB9R/tSxGb1waz9lovOWSBQwE4Lt/pD01c+/KGDWAcbkqSjYc4GPG11iU7pp9lGk9+Zl09XW81oDHWNqR7mXEMmKR38YfDOY5BtCpP0U3xL+SQzUUPnnlYJxrVX+0RPUNYMV4VRl/6P212SVk7wvQgfIHc/IyMytk0kt6JHNiZd+XAQsbm/hLxSAhXF1B4UTuiq/kRcaYvL1tOq1Gc0JpCf3ymLko87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgQ185ZDmyYs8N5Z0HQ7B1mEvAH6F3XK7f/p9xzs2Ho=;
 b=P2hZh9TQf6eKIOW8CGHGN1odNxHfidmxFcMQtWqoYO8HiD2N5n+zsamZwEsgbCvBJ93Jy3OyRUbhwY3UURzK4y2rVozQn5NBS77sEzr9uuIl5830UKI4zlgV5bXKn7u8IHuIO9oFwVZDRXRWT52Bv1Bfg30b+HpPglokEDpP64g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7038.namprd10.prod.outlook.com (2603:10b6:a03:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 17:10:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 17:10:18 +0000
Date: Tue, 15 Jul 2025 18:10:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org,
        mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org,
        adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com,
        yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org,
        osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com,
        christophe.leroy@csgroup.eu, tjmercier@google.com,
        kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under
 per-vma lock
Message-ID: <7568edfa-6992-452d-9eb2-2497221cb22a@lucifer.local>
References: <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
 <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
 <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
 <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local>
 <CAEf4BzaEouFx8EuZF_PUKdc5wsq-5FYNyAE19VRxV7_YJkrfww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaEouFx8EuZF_PUKdc5wsq-5FYNyAE19VRxV7_YJkrfww@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 20944b66-4045-4102-5f74-08ddc3c27990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGlSWm9hK2tvblplMW8zeXBYUUYyUHNzM2pubCtIUld0cGdDV2wxUUZqMXV5?=
 =?utf-8?B?WGVtWktVTmdtWVJ0c3NXZnY1ZXc2REtyMm5EMW1qbHZFdDVXZWFJOTNjVG9F?=
 =?utf-8?B?aWZMMWx0MElueTFIdVdvQXpOSWhrTFc0UERBSlJBMVJYTDhCcVBmMnJyTUp4?=
 =?utf-8?B?eCtXVDVKT3kyM0kvdCtGMG5LQ01WYVlCNGh1VnNtTjNSaUJ5Um53WjFLZXU4?=
 =?utf-8?B?SndNVHcyOXVqbXZFb1RreHNUYkYxTlhpUWpsSjhJZjhiUkhtMVE5QWVNMVY1?=
 =?utf-8?B?U0RHemU1c0VYMnNURXVZaklKalVDMlQzdEYvenpCQ0ZMWFZWQUFKL3diMzVx?=
 =?utf-8?B?Qzc5eUNZWCszRUV2T3FNVzdEZ05lYVN1M0h1U2tzb2N2QlExaHd4clgyYWpn?=
 =?utf-8?B?VWFGcHV5Y3EydzlxKzRiMC9DSnRrQWdSV3VrbGU2UEZkaVVuQUdVVjVZYUJB?=
 =?utf-8?B?Rkdwd2RpREY5VlpacWM3WWl1UTVTQ3BqcmtIcU1USDlQQ0ZVN3lEQ1A4VnFv?=
 =?utf-8?B?MVl1VEIvc3JIQWJOK09HYXlXRm5sNDNuaXNJRmFPenRmVlZXU2w1TTN3WnpP?=
 =?utf-8?B?YWpMZmx6aUwzQXMyM3N0VTdQOU5DYVJzKzJTL2YxTmh0dDRpUXZ6WVQ2VWZY?=
 =?utf-8?B?K3dGWGxMdVU5WG92TXVwNGd3V2tVcnRWVXpHdmVyYXdlKysvdHFqcFNsV29X?=
 =?utf-8?B?ZzQyNWRTNml5NDYxQ2N5MXZ5bGxJbUhEejRPRkt5dkQyLzFtd1h4KzFQU3F6?=
 =?utf-8?B?cFYwaTIydXNNUzhNWUNCdmU0UHBkNURLeWhiaFl3SW1HOTA1U1ErNStLcU40?=
 =?utf-8?B?a0FLSk1tTzZoUU1KUWxIYnN6emRXVmp6bTd0SlRGNHhLSUNOcnhSSjArdVU4?=
 =?utf-8?B?cGpmQUNIdElCQUZiMWNkTUFvK2RVOEErbG1BSlJpL2ludDdMSnYzSjhSTkd0?=
 =?utf-8?B?R3hOd3NCenQwbjB2UnU2VEtrYzYxNmNuR3lzWXljV0JuOXBqTEx2Nkw1V3pO?=
 =?utf-8?B?NnQ3b3d2dTMzT2w4NHpsSCszT3dLQ0I0emNyS1YzODB0aUJudmNIcWN1MmZH?=
 =?utf-8?B?WjNYQ0doRXdoZjg0empEOXQ0NnB4c2xMbXM1RGJCU21JRVVRRXc0ZnBKYXRZ?=
 =?utf-8?B?Q2o5bmt6QkUyaDRpSHNKLzJSYjA1SnhhV0xKcHRqeHVmWU5tOWc0SGlHK1Vy?=
 =?utf-8?B?Z3NyTDVJWTZDUkVnNDNHM2NOUDd0MG9DeSszeHNzZk0xYWhxYmlUN0c0OFdN?=
 =?utf-8?B?SStCTk0vTzBjVnJOcUtvL3BDU0wxMHI4cjVGZlpPNUs3SWNQT1BhWjVoQVFN?=
 =?utf-8?B?TDR0OU1aNG5XTTZhOGppSHd4RVh2dkI5N3k1ZFQ2OHRMdTdJTGJ1OGJLTkh1?=
 =?utf-8?B?a0hsU0t1eUwvOU9JcHRkZU02QUZUTEt0SU9NWnQ0ckc2M1EvR0tDWUZrWUtT?=
 =?utf-8?B?VnJNRUF0Z2RQTFdZckNZc1pwY1NMbjZhd1c1WVcwcmFtTUNXRlFNNWZGRHEv?=
 =?utf-8?B?ZFdwaElrdXFjdFVxTHVVM3dKR2w4aVhPbElteDFjQXVvNlZWMmdzczQyVUNu?=
 =?utf-8?B?bmljejJvNnljc2UweHplNGdyeS9ueGZ3ZFRVTGtQWVV0anIrZVpPcjVtK21Z?=
 =?utf-8?B?L3VJMFMrdk54MTdGTkkzdk4xL0VlUUhEWllHQ3hXZUZCYWs3U1BLWURPeEpR?=
 =?utf-8?B?enpzRktlRW5kaFdLbnlmWkR0NFJCNTRuZ3hEWnBXY1dUVis0eUZEWlRtRVND?=
 =?utf-8?B?aTV4MW5xMUNBUjlOcjBKZ29uU1Z5MDRteGFoM2dqd0xoZkdMTjhDSU9HNlRK?=
 =?utf-8?B?K0MwaWllK2JkSk5lYURhZHU3Q2NjS2pOanRUbTRoRjcyYnd0aE51akVUU3dO?=
 =?utf-8?B?VEQxWnJKT0h4b3U4UUJzMTI0dVh1M0pyeUhFYmR4dDNYTVdZWU9uVzFLcDNr?=
 =?utf-8?Q?0Zhu+fg4Fl8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTMyZXo0akJ2RkVKOGRMdXNMTWZXd1QrWDkyV0I3cS9KdFpoZHFaZHpreTBa?=
 =?utf-8?B?ZzRKRHhocmxFL0RWSjdMZ291ODNCYnk3OGd3Wi9IQnA0YkdROHpPMXJIWEhG?=
 =?utf-8?B?MEZMaWExbXU4QktIVm04R0MzMm1NNk8wSEhlZVVXOUdrLzlWbUN5ejhtZi9D?=
 =?utf-8?B?c3diNlFFeFhzbjEvMG5PTktJc2ZUT051MEFYSEJvRXQrTlBLUDN1OHgyY0g5?=
 =?utf-8?B?RnBPbk5pa290UWZVYStlSW5oSjNzaGJQOTRMK3lST1JQaGxWZytBNC9oNjA5?=
 =?utf-8?B?NjJMZEZZV3A0ZTFna2RwY1BXV0w4SStQc3N4MDI1TVNpN3gvVFdvQXc0cDM0?=
 =?utf-8?B?OUpQSGVqWFYvaC9WWUFuNTE3L3V4aWNYcTdDQytYNHlycG1lcE50THRPYVBW?=
 =?utf-8?B?c3Y2TzdZU0FCZ3Y1SVRIMEUyRHh1VElBMkxGUWJCVnpIYjdMNzBxbklQRXFi?=
 =?utf-8?B?cy82V3gwQ05LNXZRN3JSSWE5TUYzMkhtaFY0bG1sZXRKVVFQeFBJTHhIU1J3?=
 =?utf-8?B?QzFGWmI4TS8xcDZIMzdDbCtSSDRqS1JwUmx4OHA5L2JxMEtqckpHdWlzUGk3?=
 =?utf-8?B?S09DVTZXQkc0ZzkvdmhqNFJTU09OeGxoUUppRFlnL3VPSFM1YmtEMnJ5TVVB?=
 =?utf-8?B?ZU9PZVVXeUdxdkFMZHRnbmVzSWtnOVFFMmxTZ1g2OVVwd29DbGtpZFlWZkpN?=
 =?utf-8?B?c0JCOHg3QlJMUFBMVW1BazlFQUtYY1ZaZGErVE80NUVBVXNoQmlkTllNcHpx?=
 =?utf-8?B?dnF0VGtHYzE5RS9XZEZGam5RWUppTlo1Vk15cjBleXJud0dYMjJsMEVHQjRi?=
 =?utf-8?B?dTVXM1NQbmgyM3haTkhnVFpXTU4vQUY4LzlMZWR2eUYzY2FmVkIxVlNuME1T?=
 =?utf-8?B?VnlDRzl6WHhrYXBOOWhja3NUYnIrNm54VG5lNERlc0xJN1greXNXNTJ4T0VR?=
 =?utf-8?B?Z2ZkNEhQRmhncGdiQitidktpckt6a3Y4NytUd0o2cGJKZzVPU1NrRjlXVWwy?=
 =?utf-8?B?b05JS1ZiUmhDdUVtZG5PSktLS0hSQ2J2SnRtQ0lLVitpdE5uS25VcTRJSFhD?=
 =?utf-8?B?YjVIY0pBdGx6N1ZKVmJrZFRkY3d6d1N0cVZ2aE5menVjVjNLVm5DWVE4T2lj?=
 =?utf-8?B?MllUUHpPY3pScWMySXFEMUFwYm5pRm9GUjB0QzZiTkI4Yndpb3QySjRYT0dE?=
 =?utf-8?B?S2VRTE0wTjFHNzBLc0U5QW1ZQU03akNseUdINkdIMTU4akdsTTJYWkxXOVY4?=
 =?utf-8?B?RWhzeDRzeG1JVWIvc1g1MnFaNEFIN0tPcDFTcDZtVlIyRFg4d29rMzF6dHFX?=
 =?utf-8?B?RWtxMTBhc1VXTi9LbmRDUkFMZCs0QXRoKzFXcVpDdEJJSkZTRENmUUdpVTF4?=
 =?utf-8?B?V3FVTmluYVhZQXJUVExDenRYdyt4NVo5cHRURjVxYllITEU4YXBRdkhCUENt?=
 =?utf-8?B?OGZ4L0FPNmVZTHMwWWc0cHM0UFN5eFdRRjNBZFNKbm8wUjJpVXF3N1ZDWWZS?=
 =?utf-8?B?d0Rscythd1N4WW5TQXRCek9CZ3M0aGdhaXJxbGU2ZXNZN0pQYnhCWGpQbm5D?=
 =?utf-8?B?Slh1clR3V3Z0Y2lUNXR5VG93bndLRnIyeGY5enNzYktUTGF5Uk1EeStDRm95?=
 =?utf-8?B?Nm02dFJHTmorQTVhL00xUEUrQVlnTUErUkNyT1ZNaENZaWQzcG9qNCtYMExX?=
 =?utf-8?B?OXc2ZlE0VXltOUtkQjAyL3lCWUJ3VnFXQUdPTFB0c1hwU3pMa1dLSXBuQ1I0?=
 =?utf-8?B?bEhEZmpjK1c5RDZQTGtycFF1N0wvczZUOUVKZVpFeWZzOEwvYzU0MW9EUDNu?=
 =?utf-8?B?eXFLN091OFY4d3JValNxVWV1WStzZ3N2K0ZkL3VzbXNNWmxnRllFaytURkc5?=
 =?utf-8?B?S3RaUldQdFVUOXliK3hxTmpaMFRhSjhxMFJlUTNDOFNCYmt2RFV2b3Z4VDZ5?=
 =?utf-8?B?M0tmOFpoWmwrYWFJck9wR2w1TTV0Nk5Hdkhzcmoxd1VZQllhelhUNVZybUJG?=
 =?utf-8?B?Zy9jSS9BbkdtQjVwUms2RmFhUmpQVllwSXY5TmNkcmltMWlrVWduUGJ0M0RV?=
 =?utf-8?B?akxhRGo0TFJzbGIrMzBGaVBaZ1NQWklLMm8zcnlJWjNKQzU4U3pKVkJvN0tJ?=
 =?utf-8?B?ckQ1MXg4bUU4dnA5UU92d0kyU3BDbVBza1M5N1VoVzQ2UDE3Y2pTdGVqOUg0?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zu/QCQjMF+HMGoexQjplqu3V3H//O7y9JDgzbVMDe0y0/WF+/WYy+ForLIg93CiWWCFZlTxTyxyLIGiCeYLflx+q/dTA3ChTffY3K4GlGitHB2M4UE1uE8S93JqyGbfJAsv9rnHBRkNjcEO24QdQ+XGKiK6ZA9t3Qj5hBylSWIV5vIlBDW4kIMzTmDAKWOFfaKMvGk3MT9IqrGV+fd3dN2nRydHIOTkI5gPFPVD3bjt/0m4vkILbrYeV29AlgGeCk88t0XP053AzZpWDogFZb0veFvfktSvj3c/LN3dgXgsSpIghE95nBEQRyAaRZ7ViMcm+pNBeCOolYlswrj+Z2YyX9j6ed9WDgQjK6Zy/DFw/Pk12vWXqTzgSMX2vjGzpkUqSAHriA4zD1d1zQ3cyhjz29DolD6a0vcTUY7HfXLvj+03VVKRzS6ZRLnxbBx75ehZ22T6W8rUojzQp8s3s8fNtZRzZMOleag3e5LiondiH3lWO+0yL86axeTuG00IaOxXr6Mae6mrZtU4n894qHOqN5vV+E0yjfMb7vXhHOZo6YlmyGhfZBTu5NPEvmeiXPbUo8fLiUHcvYhg8V4GBiTaK9OleqKwZfR2fYIP+hs8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20944b66-4045-4102-5f74-08ddc3c27990
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:10:18.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEbnaT/eTy/iGNkB9q+1ODMtWQnHYkoyTyJl+2iid8W66DZTKL+xdz844Jcq9VeCKKqkI0St8k54EdFyrWMgRgLBrMTDK6lE4PwLsp5vFd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150157
X-Proofpoint-ORIG-GUID: 7APz-HOXYJm-fIDUlKMjcJx3T8NGUGaO
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68768b7f b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=rmMUEn68dzajLPKR-tsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: 7APz-HOXYJm-fIDUlKMjcJx3T8NGUGaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NyBTYWx0ZWRfX+OI2rnfxrj+8 0DoZW5R+vbnGwISZvCo+L7rsBQA3HEjfJUqe8f8mxn2jmPnnH+jyP22j+JuQabRCa/RNQ7eH6wB cg73rg6DaLQVTLVrDHBdSHUK6gMd4/gscndPUhCXUjuIeTW/6dkKQqnc+u5/clZGkAGRMgpm06C
 So9VqiIlBvAKbxYFSyeLj6ASzMgqCh8OZ/8tuF+XuSIt2K9fsvk/aWKyy39ndbDqMbc0aAFhc35 0lZbsbmXNIuoY2riwuGOhZxGWpDPx1dYfDYYo2sPg2c5cnKBBXKyblCgxHfBL1vwiVYm2dg+0PI FfQcx74w43bQqPyel6XyXPrcpgL9PfZRg77px+XSldV7SjRaEo0bbAPk4PGPlOYWq3hBjz4NKwJ
 GGuwI0PHRaZThbVLTjnMfOreCueMuy1YlDPbBFZqoWYftFQHvKZ+Asoz+EjIRaYYioz/3uUd

On Tue, Jul 15, 2025 at 10:05:49AM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 15, 2025 at 3:31 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 12:23:31PM +0200, Vlastimil Babka wrote:
> > > On 7/15/25 11:52, David Hildenbrand wrote:
> > > > On 15.07.25 11:40, Lorenzo Stoakes wrote:
> > > >> On Tue, Jul 15, 2025 at 10:16:41AM +0200, Vlastimil Babka wrote:
> > > >>>> Andrew, could you please remove this patchset from mm-unstable for now
> > > >>>> until I fix the issue and re-post the new version?
> > > >>>
> > > >>> Andrew can you do that please? We keep getting new syzbot reports.
> > > >>
> > > >> I also pinged up top :P just to be extra specially clear...
> > > >>
> > > >>>
> > > >>>> The error I got after these fixes is:
> > > >>>
> > > >>> I suspect the root cause is the ioctls are not serialized against each other
> > > >>> (probably not even against read()) and yet we treat m->private as safe to
> > > >>> work on. Now we have various fields that are dangerous to race on - for
> > > >>> example locked_vma and iter races would explain a lot of this.
> > > >>>
> > > >>> I suspect as long as we used purely seq_file workflow, it did the right
> > > >>> thing for us wrt serialization, but the ioctl addition violates that. We
> > > >>> should rather recheck even the code before this series, if dangerous ioctl
> > > >>> vs read() races are possible. And the ioctl implementation should be
> > > >>> refactored to use an own per-ioctl-call private context, not the seq_file's
> > > >>> per-file-open context.
> > > >>
> > > >> Entirely agree with this analysis. I had a look at most recent report, see:
> > > >>
> > > >> https://lore.kernel.org/linux-mm/f13cda37-06a0-4281-87d1-042678a38a6b@lucifer.local/
> > > >>
> > > >> AFAICT we either have to lock around the ioctl or find a new way of storing
> > > >> per-ioctl state.
> > > >>
> > > >> We'd probably need to separate out the procmap query stuff to do that
> > > >> though. Probably.
> > > >
> > > > When I skimmed that series the first time, I was wondering "why are we
> > > > even caring about PROCMAP_QUERY that in the context of this patch series".
> > > >
> > > > Maybe that helps :)
> > >
> > > Yeah seems like before patch 8/8 the ioctl handling, specifically
> > > do_procmap_query() only looks at priv->mm and nothing else so it should be
> > > safe as that's a stable value.
> > >
> > > So it should be also enough to drop the last patch from mm for now, not
> > > whole series.
> >
> > Yeah to save the mothership we can ditch the landing craft :P
> >
> > Maybe worth doing that, and figure out in a follow up how to fix this.
>
> For PROCMAP_QUERY, we need priv->mm, but the newly added locked_vma
> and locked_vma don't need to be persisted between ioctl calls. So we
> can just add those two fields into a small struct, and for seq_file
> case have it in priv, but for PROCMAP_QUERY just have it on the stack.
> The code can be written to accept this struct to maintain the state,
> which for PROCMAP_QUERY ioctl will be very short-lived on the stack
> one.
>
> Would that work?

Yeah that's a great idea actually, the stack would obviously give us the
per-query invocation thing. Nice!

I am kicking myself because I jokingly suggested (off-list) that a helper
struct would be the answer to everything (I do love them) and of
course... here we are :P

