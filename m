Return-Path: <linux-fsdevel+bounces-48945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61016AB66A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A77B0F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D922171E;
	Wed, 14 May 2025 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jVvDzoWI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tb989Kex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DD203706;
	Wed, 14 May 2025 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747213047; cv=fail; b=TlrF8mjxv6b2XBKcvuXADmA9E5ivD7NXtfaTbjpoDGEhlkZJkfMvGmv3tesjMl6OpVmB7Trt/DKm9pOnjwwUwnVZ5h3/4LvNZabbxqSnuNJXr83UiztQFacObElpVN8TKx2ef0KCulegPoF9DH+wRnoRMjsUbyyHPZrPn26wQEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747213047; c=relaxed/simple;
	bh=K+M3OyEiD0SSEpQ1PwQIxa65RtgY79s2J0AnlRAgVO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFLqNUVFSU1SFV/TUTY95SzkBm6ZMT7txE7PaOR6jvmNrh3SpOQeQyowd9bk3y5BFwHX7AsEh1D0bBTRB04hQNFRHOjWukkRmi9fau+RB7VF34Rg7sKdoewXGSANPohrPS1tdMHzoN1+l3mDxnhPAcYAK1Y/Zedln2l9P9MpK84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jVvDzoWI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tb989Kex; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0g0Ai016879;
	Wed, 14 May 2025 08:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=K+M3OyEiD0SSEpQ1Pw
	QIxa65RtgY79s2J0AnlRAgVO4=; b=jVvDzoWIEaX2a+Qhv7pUL/1+j/yFUZqDcR
	/tJZ1mgIeUZgYq3yHZ+HsstQg0qyklguM3/YwkWR8Jfcns6+Ng5gBXTOy8Lc9Zsc
	zNzI6jVw3qUBS0cWYG2Lo7Iu+khiaFkC/BlN9bXk7BlU8L4yl2HNLILnAAeqY5PC
	MLCatkhX05hctDVHYwkjXJ1bMJLHsHFyrJyYJEwXVDBETZk8B9NjsAmWhAFHt0eB
	Eds37WLBazhzfMQ2/0TwwhgXKjS8btCaZ6Nf3R2SIEf07gxfy3inZ2NE4rURmW+Y
	J7asPdCcrlYHncCcMLG3Of3zbC1xK4bomXu7x89D/dPniNDkrX7A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchh49d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 08:57:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E72cM4033315;
	Wed, 14 May 2025 08:57:02 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011031.outbound.protection.outlook.com [40.93.13.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbs8x5cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 08:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dh+ge57OZ+Aa5gstUVoqO9RSmERp30bM9AdEePDGzvKoDChkpjEAPtWDdB93S51hhMyiL06/2bPiCQTZ9m9zt5kfjJNhVO+O3haKLor5xD36vjdYAvXWx7p26JOymVdUp88er2CB6B/8mTZQiKAKcnF8A09SVT+RsxXU/V5BTWG77gSvMSXifNP/HWslSWys19/tNkkrGszPgyV5Ib71i17vmYovYfU5rL9Wvti9DzkhsYRUeeTU4jRTlpfNIIYxoCT82DON4P4RqikSbuV91T0bg9gCN/pv0j4z/cizxC7sWrrP7AcU6WFvq8oZ76LGQXDy75n/bao5f707bBvpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+M3OyEiD0SSEpQ1PwQIxa65RtgY79s2J0AnlRAgVO4=;
 b=ebw53BANJn8qrKKganrP96+q987FLvv1DvRK05mjIW25GlveQbW0JVDEVb9HmnXANo4ozQ0GN6gBblDsTHP3mQ4Ewn0q56S252ikyJsuysiOyU1bYbvYaHrKxFwmvmsEb6H1kPduehZAnC53rNO0uBgWxj3Z1hWT8ISZl4iK7yFzdsmAefKMhesi408ZYx4LMHRKUDdWAiEBxsnBQ8FB/S0E8v+nJEI4WcHIQuEbMg1OjJmrU/Fx/zkagRxZtQsW7667fXEl4bVJDqsFfyKuyaQB1MZD1fxadwSJGno0RdjJ3OkjcU6TR+TatPLP+oQSfcCaE5o0soFnMTg+97XYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+M3OyEiD0SSEpQ1PwQIxa65RtgY79s2J0AnlRAgVO4=;
 b=tb989Kexf0khI2oWMiect60I2011nVDJskz4AQw2F0Xu6Kl0Y63s7hRo/AHiD+cQzfwoGBcrSzdzHr7kIOJ31nY/GnXjRHqrA3F7jOKiYvOkSDcICnMzMOVgX+HfeE3M/2CR2riKLFp02Q5DZgX96fDMBuPK7BI4aTRqoWeeEa8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 08:57:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 08:57:00 +0000
Date: Wed, 14 May 2025 09:56:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
Message-ID: <f7dddb21-25cb-4de4-8c6e-d588dbc8a7c5@lucifer.local>
References: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
 <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
X-ClientProxiedBy: LO4P123CA0373.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4a16a1-3fc8-4796-5a54-08dd92c549d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?an2sD34pgIVX1FMY8JyvaID5U3NrDyY3tLWjqRwE31fj/drC/HZ3tPBb6v8g?=
 =?us-ascii?Q?+vCQHlDQMrJj1nuX35OwtnNReQ5XZN+Jamj6n38OjtUJ4I4Q0TzBfVlWps9B?=
 =?us-ascii?Q?Fcf8C44uFAbg0wjtB84Fw316mJhdGlPebOrlU7jmxxfpKPMqxfHlXVJTruKX?=
 =?us-ascii?Q?Pk5o/qUuQ8KsxoY8fpx0LD2Z2zV2HJc/CS/sv5suUfB/Q4wRqdZn9ohl5nGU?=
 =?us-ascii?Q?nMzEY2GmJmimxu0loVWQMwzv9UfIR2G2y6iEN2kYhH0M0zlWrknU3c7B2uCf?=
 =?us-ascii?Q?NGcU7GzaBvtPfBXhzXpvfJO5srkcRwQOxJOPRSnmZSTGA81mpyPZ0WFZlTRv?=
 =?us-ascii?Q?1nCA2DbQmkqYHa0VCyBljBQLjhtI6Nk6PAKCfGTzpY/jogHpSIDVDVvaIrex?=
 =?us-ascii?Q?6YpCpoXKv/MBdANNDMOKd4cL3/oVbDwJbyZlwOENADbMdWcetXzy4lCOO+K1?=
 =?us-ascii?Q?O9yb0q0PTl6BSPP3KdS5z9R1P7SCLQIxou+J1oxF23+O5gz9HL4ZEaAv1rNs?=
 =?us-ascii?Q?BLLdD9L5X4GZpoiCvvGWMzwAZOIMuw0/fewMCe2VmHsL0zYc4NM/uTlMvMds?=
 =?us-ascii?Q?aidPr2BJTpyM2ukMyrCr6nA/vsPYyknq3XKdewGHjc3l9aXXtvu4o9YKNV2H?=
 =?us-ascii?Q?miZ7yfahe1U55JTOl60Pc4T+veTADfd6XB/bZQkIAvL58pC5cTaZZOQAKX9Z?=
 =?us-ascii?Q?OoggNFqVecXmw5qp51V2jQZkxKiN6Nw3Od317oYxanJ4MadUiIl+Man6GlEC?=
 =?us-ascii?Q?uXEPUOXqaZY/TLbxe0RgVdI+MAYWStfhm48ZBKoVWe8aP1uhwjHaWkkBH7au?=
 =?us-ascii?Q?pAOQwjaY3QQShVes4ARZlHZtkCYJU7IwIPPm6Uj4s0akwCu8tADm+h3EedsU?=
 =?us-ascii?Q?wrwZfSNKMKMt/DVFSsm1bpCsndXby1yylhVFqTzDbyAL2limMB9PvTFnVld3?=
 =?us-ascii?Q?hAWpx1rcmw4H0IR0i6y0EL9/CaSUbv08Uummpyt07eUGSQQEE+eOM8UUrEXk?=
 =?us-ascii?Q?QKGWv44zHFPNi8GLtpiFzuuMFgFIuqWZ+j9pxbm5Hf/Ok3ojPMtJ8oqOtjM8?=
 =?us-ascii?Q?A2cMDtxcT7Cz+1TcsEfv+nucIP3SXLJkPzYFu1PjlXgk75b5kD8RNpUBCAfB?=
 =?us-ascii?Q?w7usa5CmOksqtoRV+jLKWE+62XtuxThmkEMOMbeVtLGQHhGlGYxFnOmQzgnc?=
 =?us-ascii?Q?BdRg09jfjj0jJLHBQgQtYrGFFt1m/Dn1pJUUKCrevjbOYoIbc4wbUwolhtKI?=
 =?us-ascii?Q?p9JoCs44CzFCJpDiDVsWXav9ys7/SVdnJQhHMvWBKy4Zn+6GowaXTgid7tY+?=
 =?us-ascii?Q?yrQ9mbUdmjSPEUl9AtZtm2iOwNoxK+XyEuZOUcPh9PpbMQZY5khYOIo/AcJs?=
 =?us-ascii?Q?aJytIdEcDDb++HpDdXtGWKLtpQmZ1O5Cpl/gfsvbM1W33/koT7/RuCUZ1Alz?=
 =?us-ascii?Q?nX13QIyu9h0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQwX15WsG9UC+O23VhEFA5JXrBIT/T+zKMb/emsZ+yMuj/dm243QLiOdlzol?=
 =?us-ascii?Q?UNv0dGauHEyqbJOVjmxqVklkN1dp/ovFh6k02r5PbmI4zFXpKBH3faLLj4rx?=
 =?us-ascii?Q?we/DI0z81ZsYZkVVQMO9MRTwpqUmeptPxSnW02vHkDrryAA5kAbCrO4xI7fY?=
 =?us-ascii?Q?tucoF4q/+dvRFu9GxX+QY7JLy0n+M3SgUSqKiOoth7XqzUhY6w/xKhuLGlb1?=
 =?us-ascii?Q?EUHWMxCJZ+pogLuKhtTu/H4q5f6p/6f0yyeopghFxFqb8Im29NnovDdaCdWj?=
 =?us-ascii?Q?IyiXyJXUebyV1+6+WojnSK5e/JQgtLqrngKzirBvEWCqfvACFiLKc1C7XQet?=
 =?us-ascii?Q?8lUYEg/0aJa8MQ4Z3MAix1umkViN+RDP3VCy5hAXMyMx8di5+0WXfBDORMQw?=
 =?us-ascii?Q?xl7H8pmOC5iRLFt5qzlUNMd+p+Zp3ERR6PJcZNeTUKUvltTMG5HEgA+a81f6?=
 =?us-ascii?Q?siCX64WGD/Cl9NVDI3rch2xSDFFtp4FrrOdN5qygG0oRsdPyXoFxghrG9EJA?=
 =?us-ascii?Q?IGeltDRnlB6D6clAUxr1RtQbMyiaWcoStBSkPLU770Tk1aKBVo6B+6jOe1hY?=
 =?us-ascii?Q?Mw+kdS+Oft9jHQKBXMueQqg1z3v/9YsF7gcFFCw4SDssgcnxB5WlIkRHxeXR?=
 =?us-ascii?Q?vvnRpj7+M18J6UBhIsRUnolPVbf/ue1fmI1xN8gFH8CqKakjIi+VhH3v0yWC?=
 =?us-ascii?Q?D6CLINFAeNihoknZeYPQCHUgm/bhPw3JH6wPfS4ldveqmAMQSnzWmxSMppNH?=
 =?us-ascii?Q?jiaW9FojBvk3cSWP16njYzTX6UHGVXZXKC2Dqh3+JW91MljplU/qcMPhKQXK?=
 =?us-ascii?Q?ZYIsfltIg05ueQO/pJCzMP+WFLYUiS8fRWyu7zxw8cC6vTpQsXOUYs/YLoDs?=
 =?us-ascii?Q?lfvP741tCsBuVwMcf0dcK1vX8dmKSsfg/MawY0ch57xv5F14AVXDBvDhi8Yc?=
 =?us-ascii?Q?uM1Dq/7rMjlqiWDLgD/1LZ1FteAJHKb9NjCi6Y8cr2fi+GkmC3k502E6NK72?=
 =?us-ascii?Q?hQF/r3FoqPYQ/z7g/bcEfBTS0pbt/+KhTtbc6fOLi/zMsadhR/OmgCRFp8Nf?=
 =?us-ascii?Q?6frbAoSBMZMvfP+H8409jLhE+Ejbt8fGQzDeP+XDoO4JR6B2M7ZD6ACn3xJD?=
 =?us-ascii?Q?7f+vXWkVLpMNWi+WOXiFndlm1nOUa3uSDa7JSsV4eDLE1xYMG/GnU0xFUoLZ?=
 =?us-ascii?Q?XKL8bVSgyBq+BVe84Ah6AibBczkH8G21fSC0xmpIY1070hL2KJagfOwkVfEw?=
 =?us-ascii?Q?vAdti1Qhc9K9sNChNYtHuVyFqB6B6CshTyWLySLbFF5BjmHXZgIx8PjF4P68?=
 =?us-ascii?Q?VmtI3G9MP1iDroMt+nONYIBzPetSvRNGpHHVniEt+7C2skHlBF2sekXenmcb?=
 =?us-ascii?Q?/XVz66eXpT3pvQYnDcRPwWgQdd7GlHppR+gHoYHuBnb2xQCuv9RJAMAV5aj+?=
 =?us-ascii?Q?Evl9Gcu+Hh/DqAyeSPFDy2ybHCauugGJsHe+XEKMElkHVCayHAKYEb7dPY2/?=
 =?us-ascii?Q?Qs7QkZywEDs6qopI5uCOMqsUroUNBINYJuAImGnrILwMh3DU9Tg436IgJ6o9?=
 =?us-ascii?Q?NiARBH9Hd4V0UslLpud0hNsz18+XVTOQ4uOc9/bU9Cf9GkRSB7cHwptP6q1B?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bx03ZfiZxFVC3jkXpivAxxWO5Ye82SyKLEx7hRLzFB2BzmxyZZHEoR7awNAa2hSdAuGY2ow6lriAHFN/Kov5m3ac6ryGJlbt0u7QeqUQ6CWHD9fs/nnzEP7UjtUdmmnhcWePCg2wmucpRBu9DePZ7fztFuh1c+OxDjQ/j5NbkY3kXTNc/sNPouPKemzWW+V4DCKA2Q6CA1CAxFPmeJ0n2mBDV1x1btJnBexP8Japtme0xqQmbH57yT6HwcRc2fWVV1PrGEqAP000hL4bQtNUAikFqcrV7b9JVKMCzi/cNUrJT7u/pzrUtvQUjhOChwhMRQOD82aqmspEK4jfOgEAy8qZMAAYAaeus/kRUxmo7Fr+pohdxs/pPKD0td3onH16drLthi8IUZ+l84pEMlhuYtx8iyTm97UwYgRK17bhn32B6ThG9M4iOgbG11GxVvifTB6kCXRFo7feTt8PjmgSRSVjTvgZPYwNSzULByxAWYOQk+X8AWHrlonx/nj4OZwws207DGqZxWoAdoBbH3ke+0GUqPtl/rM9c6DOZX/mHBRyIT1cDfPp/dc3u+WQMyOS7YF4JBu8PYGtp0aOzUwTd5r1mB6KCO1dj4HDFeYFBR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4a16a1-3fc8-4796-5a54-08dd92c549d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 08:57:00.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BYboGD3dALCWVWBDVU7DHsYSoxzml+fjGLbUd0wyCyosBbZ3VJEqj+Wmx+SMHYeJQ/3VNi08U4qDsA2m7MWayVn/WKR/RuGNgf8wYlmXOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140077
X-Proofpoint-GUID: IwmGSnsIMkb4fjG3b6bK6qRI-ZgZ42-s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA3OCBTYWx0ZWRfX1oeiASS3No4p PcR2UHAuRhP+uZikQGjBW1gJk3SkZVaY4jPdc+34azuviedznSPaSymZcGEYrWSbc7Uhcrp2e3A Kowp7AGYatIXFWs5OkqNE86kbzGFhRmdamsl7bYkLAsuej3QcD1njGeW2eUiI8ySjJd82KMa46C
 i29sx6A0/SSgLgLd+nxuHScQeg+hB+rd9ku64rEOsiT1nPAFyAYZg6+vQDetYsbQj0z6SD6w3Cu slUN0axKBQGA1QeqAcwhLFyLv4y8NW0/fXJ07sOoiOii+NqZT//sSCdd/cSV95BHdQHuqW9Sabe 8X6tao/lLBUq1HW7R6P1c9FOYjQCYQr+TDL3FjUNvUkbzg8bFE/EGfq3YKNxqQn+b5oPNVPl0Cj
 pLzEoIZcOUZyBHE64Rd5xI4Hh5n5zuZrv0ELJqDDrywDF+CWherKEIP0xNPomv7PWc5FP8BW
X-Proofpoint-ORIG-GUID: IwmGSnsIMkb4fjG3b6bK6qRI-ZgZ42-s
X-Authority-Analysis: v=2.4 cv=Da8XqutW c=1 sm=1 tr=0 ts=68245adf b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=IPsZoht8uiJp1Li_cD0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185

On Wed, May 14, 2025 at 10:49:57AM +0200, David Hildenbrand wrote:
> On 14.05.25 10:40, Lorenzo Stoakes wrote:
> > Having encountered a trinity report in linux-next (Linked in the 'Closes'
> > tag) it appears that there are legitimate situations where a file-backed
> > mapping can be acquired but no file->f_op->mmap or file->f_op->mmap_prepare
> > is set, at which point do_mmap() should simply error out with -ENODEV.
> >
> > Since previously we did not warn in this scenario and it appears we rely
> > upon this, restore this situation, while retaining a WARN_ON_ONCE() for the
> > case where both are set, which is absolutely incorrect and must be
> > addressed and thus always requires a warning.
> >
> > If further work is required to chase down precisely what is causing this,
> > then we can later restore this, but it makes no sense to hold up this
> > series to do so, as this is existing and apparently expected behaviour.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >
> > Andrew -
> >
> > Since this series is in mm-stable we should take this fix there asap (and
> > certainly get it to -next to fix any further error reports). I didn't know
> > whether it was best for it to be a fix-patch or not, so have sent
> > separately so you can best determine what to do with it :)
>
> A couple more days in mm-unstable probably wouldn't have hurt here,
> especially given that I recall reviewing + seeing review yesterday?
>

We're coming close to end of cycle, and the review commentary is essentially
style stuff or follow up stuff, and also the series has a ton of tags now, so I
- respectfully (you know I love you man :>) - disagree with this assessment :)

This situation that arose here is just extremely weird, there's really no reason
anybody should rely on this scenario (yes we should probably try and chase this
down actually, perhaps though a driver somehow sets f_op->mmap to NULL somewhere
in some situation?)

So I think this (easily fixed) situation doesn't argue _too_ much against that
:)

But I take your point obviously!

> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")

Is it worth having a fixes tag for something not upstream? This is why I
excluded that. I feel like it's maybe more misleading when the commit hashes are
ephemeral in a certain branch?

>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

