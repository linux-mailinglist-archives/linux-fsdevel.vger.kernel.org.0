Return-Path: <linux-fsdevel+bounces-59890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED219B3EB9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE483A759C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF952D594B;
	Mon,  1 Sep 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U5ee3ReQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XLQRUd2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD408F54
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742138; cv=fail; b=sx9dTpM8i2Zjt+gSBEZRcmpMLlH6kJ359OcJtmE38FUskQz7i7DhwrTBzEmlc0EeLWhv2WFp7Waew7qYXexxkhcqDqg3CH8/b+Nwt/P1KEFPbx9QBcNHk2tiZeALW/Iuw0kKzZmI29rghQ5H3gPlYQg4XG9lx8DloP2ist7yMXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742138; c=relaxed/simple;
	bh=mb0Ggi4eAui7uoVuMrYrcHV3DX2/eAlNovbwquzht+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BKtb7654L4b8liuQ2gtY0k9q6CDNJCQ7vE+kAllkMZEVSTmRJRqrs83GT3CPl5sdwNAgZpjFXc2BD9hh4CsGjMhmkPJPyvD6Dtp/1nFJiVYDep3qpkCRIuq4k4xll2b68IMSliz8fSSPg8pjb2LL1DCEHw6s1IGqKUfxHQQZySM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U5ee3ReQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XLQRUd2V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581FMwI2026340;
	Mon, 1 Sep 2025 15:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KyCfmFaVSaOOO6iXixeR8zSjn5apr7d3+TeElhS8ZqE=; b=
	U5ee3ReQvOvTFgHyrIBYGazp8XcnfSxeiLg95hm3+LLaLAm9jJ7XXv89LF5xEKXb
	v/WXE/Y9UkV88tOXRNnz4eKFV1kuKz5Wbvlrv0WTbEsBp3ZT3M/pdKV4kFzYpwty
	/p0tj5+O+9uIrePDwTiX41bBMqzQcpe3WEf7PjcqsNoOgaZgJL6czSo43WsxTnNd
	iX98pPuPkcpBdjbhBENvsDQuYF2jF24794GakFYlqHfy3DzjWGrgJCk/ALe46pXf
	SEIUt+InxhmqC1GtNr8iCwyeBLHnUCxeDekQLkwMPx3zISRotUcHSUQkn4WnC44R
	vOPi4aaK2Kdn710WsfHICA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ussyjmk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 15:55:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581EBBFc026768;
	Mon, 1 Sep 2025 15:55:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01mgpfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 15:55:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubPJf7Nv6d1lX8Lv9fOuEYo1RslQSDbhtzVvFfadOat1N9VSm45b8fqV1Om7afh67E9URq34z3ra6Rq1ek3yCh8erLwvGoz73p2UVHCB+Zoz15v+0TI36GI7aKwwZ3hJp93bUqkrqGeOJg3xG+JYlDvLTmwmV4K6BuzTO7w7pZkmrnX98gJRcl6pYpSnQ3QyDkAL8r3XIgsoUGTJk8TDoJaMMZL7eo8C4dL8j4qORQjJgg98FP6Xl79ZgdG33bd0TPkNyExUHInQAL8e+azPk8e9tkoKNNNK+lUHkqn6zKK84/aezY9Kik0sjyRMlLvm5ACcCFocCK3bQRg6X2LMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyCfmFaVSaOOO6iXixeR8zSjn5apr7d3+TeElhS8ZqE=;
 b=k/KPEfmnb0ZP72ijZcp1vFg3vVTjuyTLSuGEIPONfFm7Wtk2hJR7fykjdPZAsnwK/cP2fu3RduF4Qa2lZ/EBctFex7z+lC3/7n2DAe9UaxoIiB68EymwmuRQ8cnalBCd5Qb/aLj9wK/ZqXwIMZXJtULhYVECvHqQvbVLj6HjChxn1Hz4GQ3VssrDSI+5b6Ym2qAolT28Ut32+kdoKVkrjCUbKNGVZnSnh+mFbselOsvVNKXQnpfKbXef0JF0V9nTC9TEtJQGSfyUsypt4FR2Bkf14gQhI3d5giScnVZEbVhK+seYgo4qo2IxKwUHyEFOkjBJz+NFs0ttbINVQePkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyCfmFaVSaOOO6iXixeR8zSjn5apr7d3+TeElhS8ZqE=;
 b=XLQRUd2VdTA15I19aLP5jUMtEEhVO+PAXHkJ3ynJ0ombo33P+vr1NzGMlkBupSohD56t9Wl/XdOl5vkXE35H6j9vmuWfTo9LrLAJnMZ5c2AnKtggLtINczb55+95KSA2MQvKOwvu4Ic2tVooVnPW2Sfnfzm5CpQr9XqtXEGDnF8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH0PR10MB4827.namprd10.prod.outlook.com (2603:10b6:610:df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Mon, 1 Sep
 2025 15:55:28 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 15:55:28 +0000
Date: Mon, 1 Sep 2025 16:55:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
        axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
        hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Liam.Howlett@oracle.com, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/12] mm: constify pagemap related test functions for
 improved const-correctness
Message-ID: <cc72d070-4225-4256-9745-320b7bb669d8@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-3-max.kellermann@ionos.com>
 <26cb47bb-df98-4bda-a101-3c27298e4452@lucifer.local>
 <CAKPOu+_aj3wA14VaZo8_k+ukw0OafsSz_Bxa120SQbYi4SqR7g@mail.gmail.com>
 <8e3f20bf-eda7-496c-9fb2-60f5f940af22@lucifer.local>
 <925480c3-d0ff-4f24-ada0-966ad9a83080@suse.cz>
 <001833dc-ee02-4bd3-8a37-820d0cd56be0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001833dc-ee02-4bd3-8a37-820d0cd56be0@redhat.com>
X-ClientProxiedBy: GV2PEPF000045AD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::40a) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH0PR10MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: b003c741-7307-4ab9-98e5-08dde96ff8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2w0MUQrZVlVbS82QkpPNno1Z3VHVThYbmoxMldBQ2wwcVBGR3l4b2F3WnVT?=
 =?utf-8?B?N0FpUDNHdmhEbHd2VFNJL3RETGZWZ09MZTl3NlV3T0JpRzlmalpTUk9TYVJn?=
 =?utf-8?B?VnhFSm5KbDZJS0dSM29VUnFzNXZCZGZEcUNTZ1p3dVRDSlY5akZ1RHc4M011?=
 =?utf-8?B?TjZCZi9aTFpsZmQrSDFwU1ZsalBwcW5TTVM4SkJvREtMNW9YWFlUWmVvVEJN?=
 =?utf-8?B?aWUwczBLdHNpc3NBdTJGbURqdFVvcWJWaHdrVXUrYzJxdVdMOWxyTGJ3UklV?=
 =?utf-8?B?czdXamxXRFhabEY0U2g0anpyMUpDemdZTUFCRTlPS2JHNmNTZ3IvbWJySzVk?=
 =?utf-8?B?d3ZJUHppRlBTbFFGWkNEdVBzYnZETXl2U0Y0SXhkcTRmemoxcFNiNmxFaS9r?=
 =?utf-8?B?YzVvZm05UUFXdDN4YTZnYU9QTUV0VjEwclAwSTMrcmpLWWdGTkNsWGZPeU1m?=
 =?utf-8?B?cjdFb3U3Y2pQeFFpeWp1V2dTTDViVEhhN2s2blh6bVpodU5kdnJIbWtWNjl3?=
 =?utf-8?B?R0NHaVFncE9xUVpTRXFsYWRyUVlpNStpMXN6WmFhQXNUTlAraGZmcWszSWhp?=
 =?utf-8?B?MXdzdTl3dDRwZmxKTXdpdGRidXNJTmV2M0JDQWhXSEF1S09tKzM3TmlCbjlv?=
 =?utf-8?B?U1d3ZTJHMjRtaHlOMmxnWVBGcE5ZRU1HQ1RsZlVDRGpib0tqSkk4VGFCeVdX?=
 =?utf-8?B?d2V0SFlISlFpZHVtb2JLUkVrMnZ5UlB5czBaN01zakkxazNSL09pTGlPVG1T?=
 =?utf-8?B?Q2prVXJPcTNwQWJKYzdRN0NZWnpDckY1MWlBTTRHdnEzeE5VZ1lLVVd3SGhS?=
 =?utf-8?B?MjNTRkNCTUc1Wms0UURONGpxVDVQM1pVOVplZkx6cURMRWxyU2RDMnJvMy9S?=
 =?utf-8?B?d1JRcy8zL0dFOHVGamJOVEJLVThLSkM5czNQNU93R21aTXhJU0YrSUpvRU5l?=
 =?utf-8?B?V0ZueU83TXppOTAvcUl3Tzk2aTdiWWhrRG94TExKdTNBQ0V2SkdlVHc4a1dV?=
 =?utf-8?B?UVhKTUpaUS9Jd3owblY0WllRM01WNjRBUWNOdXh1cGsvdmxmQ01BQWljL1h1?=
 =?utf-8?B?QytvdFdFem8xRk1uVjNpajFVM3hZYkpmdXYxZUxyaDlHY1FDOXo5MnB1N0R3?=
 =?utf-8?B?ZlNoWndIQ25UUkpYemt6UnJMTmpuWDdoU1IxaFlOOG1kcTcrcCtjaEJOZkdt?=
 =?utf-8?B?RWthSUNJUlVHdTAxUEJyR2hpYjl6R01PUEJIbE8zb0psL29udFdDVm9NVlVU?=
 =?utf-8?B?eGFKajdQaWw3eDVhQmNuOWdIckR6Y2VPbDRsUWR2NTRTOERZOEVsdStZN1lu?=
 =?utf-8?B?NmRHOWtzUHZTVnd6RVE2czlKNmVTc09KcEY4aFhySjdseElPK1dEZ1NVN1RO?=
 =?utf-8?B?UnRoLzJPczVQWUN1RmtvaTdacjBHc2s1aFlPemYvWDBKeUtIVlhsVFNOckNQ?=
 =?utf-8?B?b1M3UThlQ1dHUXBLcGU2QXdFclg1MHl5YmtEeGU1Q3JNLzlNc0l2azJtS2dz?=
 =?utf-8?B?MC9qWjNBbXJhQzA4SDFqaTdydGVtek9JNDRsNDhicXdORHhOeC8xYWFHOGE4?=
 =?utf-8?B?OWJXYysxOXlyWU1vbEtPYnJHTVg5VWJlcDZHaXYrellQdENEMmRBeGR5M2V4?=
 =?utf-8?B?SmlMU0tNSTlhdzRrelJtbDFRa29qUTVxQWFJQS9WdXh5NlhleHU5SGMwZkM4?=
 =?utf-8?B?VlZxKzBEY09MVGw3YlVHYm94cDZNb2MzUjh2dnF3QWVPV3NKU2lDRHlEd2Qw?=
 =?utf-8?B?Umc5SGx5clkvRytlRlVyNmF5a0hiWCthSkU0bkJBNVByb0hYVklMVEVQWHJa?=
 =?utf-8?B?S2Z4eStiS3ZtV0xURkRPaDkrOVhLYjg3Sko2dkRJNXJmTzJld1ZLYXhDRk41?=
 =?utf-8?B?WFgvY1VDUmZoMlp6THFaZlV4MXhTNUFWRTBoUTNrWDhQMnYxMGUzTzZrQXlZ?=
 =?utf-8?Q?tP1H4dZwqCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFZ1VmRld04yRUkwWXdnMHZJK3NIQ0pZVFU3cG1aaXdxVlJrazB0Q1pBVkpZ?=
 =?utf-8?B?QjdDNWF0bHpwV3RnZ1pkbVZRRzJtRWpZZHcxZUtPMVRaMkVUcUpHYXBSU2t3?=
 =?utf-8?B?MlJKY1RnUFZ5RG9vNVFTa0hYNi9hSlhGUkkwdFd3UTg4Y2d2N0VmNmdzOElU?=
 =?utf-8?B?Qm5EeXVUejNWdFN1ZVkzWVZ1cmUrUUhIMk5ZMmxwaEhhcTNqU25pVEpkSEc4?=
 =?utf-8?B?WG95REhBWU1NRmlTdGlId1gxeXo3QU0wME11NSt5TmJxNlFCdVhKdFJOaHlX?=
 =?utf-8?B?Q0duQXFtVkcyaG4rKzZITXlZU0FpYzVYZnBuL1llbTBoZFBhR3VUVGhYblpj?=
 =?utf-8?B?V21lOHZqSFJBcW1FZUYrYU1rcTkwK2R2cjRoQ0kvUUhrRXd0aGU2TWJLamRv?=
 =?utf-8?B?TTBoU2VCekt1U0JnOHZFMmM5NnZNMGxYVVdjZjNHbXpLZzF4R2N1VkdpMTdO?=
 =?utf-8?B?aXVXTmR0eUp4M2NiM21CZ2hiWnlWbDZ6eWE2UjZ1ZFJucnVUMTg5QnV4QnRk?=
 =?utf-8?B?WFZCdE8xUjRBVzNiRVBJeHZjaFoxRG1VVmw3b0VFZlBnL2tYTXVmRlNVV20v?=
 =?utf-8?B?L0NnbmpwZkFxNUpGOWJrYVA2TXFtL1ExdUFONS94a0w0WlhnMTlvY2kwTDVo?=
 =?utf-8?B?aW1rQXVSRjRlWDRKSDRVSS9CS2dpZ1dJd2NBSksrNlZiaEtJOEluMEtoeENX?=
 =?utf-8?B?ekZCWFJOaVNIQmhsd0xnQzdGNW4yQ2thNFhQQkFrdjR5SEdOcFVoZWpwYUZI?=
 =?utf-8?B?cUFlRStIVEFpQjZ4aHNiY0pnK09JOEgzUWZxY0VqSjBwVkMzSWFIaC9FNGh1?=
 =?utf-8?B?VjdVREc3RXFVTDBnTDA4RWdzbUl0RjR1WFFMMkZ1ZnBGcDMxMlE3WFFmQWdz?=
 =?utf-8?B?S1NaY3J0YmFjcUhpWEx1eDRlQ0lGc2hUOHZIU0M2Zk1FTHhWOFZ0bTY0M3RY?=
 =?utf-8?B?cjAwbzJsbE8yQlg4TVlhSUZrMUxjSHI5WjdVTUFPeXRNLzY0WVJ5MFYraWRa?=
 =?utf-8?B?YllMSEwrNEluVkRvSUlja2lJclhYcER2a1NSN2hFVDZqZGozcjM0ZHhCc2Zz?=
 =?utf-8?B?NFN1STdub0xsUnFzNVVicFBlTUwwTHptODJHcjdmVURJREtYb1dsd0VlQXZM?=
 =?utf-8?B?bElLNUNCUld3RHhsREtrSkRHSVE1TEtGb2tFV1pzNlQrNDEzWjhOdnhNWTNI?=
 =?utf-8?B?NUNmaDIwV25wYUJvbmtvbUs0OC9BSUxQSHpmbzBKZEJ4T1hXQnY1d25LY2dW?=
 =?utf-8?B?ZHBUZE9FczJzbjBTUHBqYVlEM2lSKy9qZjRJY0Y5MUlkekMzM3VqRFEweVUv?=
 =?utf-8?B?a1c5MFN2T3JaK3pNNGoyN3dMSVh5U2VOelA0Z1MxUkhaVVM0c1Ard21UWWFl?=
 =?utf-8?B?R2czSVBhZTg2Tk1FZlV0M0lIWGV4eUtPUDlGTkU0cVduUTJDNythSlQxZTcv?=
 =?utf-8?B?VWZFb0lGaDRJN1BLUHo3MmRPZFpFdU5pdVJmVE9ocFpURUFHaWRWVWFmaVN0?=
 =?utf-8?B?NG84anZuNFJhZ1AyaFB4bVl1dXFOTTdBa3o4cXQ5YUlLclNHSFIrVGRrQXVN?=
 =?utf-8?B?KytwM0VxSjZ6UzZNRlBoZ0ZmNnc5YzBQWEVXdTFQbDR0bDFjUm1wd2FWVmRx?=
 =?utf-8?B?L2NKY2R2V1prb01TM3l4aHFSN0MveUVCTkpmMWg0Ui9HZ3VLbVJ6OEZ0Slpa?=
 =?utf-8?B?dTdXUXBuNXo2QXBseWs4a2JPUm1MVmRpYVR0clErbFQ0MkhlYXVuV05kM25M?=
 =?utf-8?B?YUhVMVYzbUdieFNWU0VBWFBSZGlOalRsdXMyT1k5MzlubE1yMm1qUnJRZmhU?=
 =?utf-8?B?SzVyUTZ6elRrNTBDRVphL2VBS2wvWjhLTGIxbGNFdjhUV0E2L1ArL3FZQjVx?=
 =?utf-8?B?VUNuMkMycElOekNKN3czN1MrQXhJTW9wN1VGZXlYamw0UTJKVzlPd1ptZWZP?=
 =?utf-8?B?MXZYRjVTODhQc1JLczE4cXl6dWRGNjRYZlVuRTFKQnRUNFZxUlp2VUpLM3FP?=
 =?utf-8?B?Ukdsb0NGMExhZFVPZ1hHazhVL2lZMm4wNE1MRTQwRWEreGM1VCtYcHU3QW1I?=
 =?utf-8?B?b25uZGV0c1RiaHA3bDlUajRZZTRWZEllaEE1SGpOUHJDLzlKM2pGUHRjSTVn?=
 =?utf-8?B?c01iUGw1OTVycTlBZDYrVkJUdUV1NnNGcmZmTE1tUC9CSTc3Q0FIcmV2OEU4?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vIyPmpjExJb24J9lWS3p5eyyxehEHrUWnhPFBp1FudAYhqk3T37K0US1//obbhrwqjOB94kmplZmRM/O5TkjLG+KKNdkdtA3Wc6ynKAjn7ber3qJRuM1drCBGDGqpQ1khaR4m9/pSWqZrTFSqmLFw/5a2iPZJtcLW2PqmDxzbEXvBw6lwKeyQ4IsKlxNg7x7nqBHdpWR+PSyP8N3CUUjTlH9QFwyHPcq4+9m6Sm0U/iobqvkNiPYksoxl12cvR9pZal8g1dXd3XLXaRsS6eGIvu4bOb3ZNtLAU5SkvXqIhJDjbSo1xjWVdRVmpTZ1R+exyDJfYFMo4YdFNo514Gs60KLUG9Jh5a74RMfENp8TwVt1gkOcinl4QzjAHDONmOXwOQ0XKEOglNFJp3OWaLrzZsrM4jWR60ETpmSFcgUPfsYwjWwXGXe1oRO751kM4LCrN9yKdrmNOKus5NCxHm2ZYdq6NuL9SrBEz633diI4zFPkXT3dBc9XjtZghBZZRtR17zxUiVS4baXzd37iy024dtUb0BTjPTLYjzSePqgjQ3ZVI6d0AHbLUof0DG1KAILEtD2uPDbBUgIVKiFTiFGn/O7pKmrxHm7YcPTQeDQ+YU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b003c741-7307-4ab9-98e5-08dde96ff8c3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 15:55:28.1273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSpgihYLZmTO6EWDLT4AcsB71Ea41j7WW9lcfg3WBF2Vkj1SoqdX/dfVJwG7gcLlest5SBm9/jjw4iU2qNTj8TP2Tv/aqccWmg1eLY0j2NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX33Kaj5jTPyL8
 hUbP9R407TfyLXbRtEkrBdkF6KKSeHzF7wnI1e03uFpqTaIhBqJ5305DLn45mcghsnSdRTky6Ha
 yxgVDjzoBGv9/QYOsy/h0EPYyDR2JVuHJ6FvIFVAc67eQ4BmkagCvmf6G/DfzYXnXSN/yZJXxc+
 qNwHoUsZ7LApA11M8Ku0KBpkqI5CvcfOyxpc2ZyXiEjCVPMurl22q21v8eizQ6oTaaRoF9MQlat
 NUawfgiOoERGe62PTf2eF6BAuNMWfu5JuFAjj3hCX8IrkJxnwCxs2DHHshrb/IVoSR6YYFDaJ1/
 P/09AM8egoDJnrcoINokA62DIvV4jQMd9RXswcWIV96K8syHJ0yLNWqkFLMg2O8eWJKLTYBEim5
 hYOvXwsB
X-Authority-Analysis: v=2.4 cv=X/9SKHTe c=1 sm=1 tr=0 ts=68b5c1f5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=gh3tW88rVyy56NfNenMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PyRkanv7IZZKj-AzafCxWIhxGy3nYe49
X-Proofpoint-GUID: PyRkanv7IZZKj-AzafCxWIhxGy3nYe49

On Mon, Sep 01, 2025 at 05:52:47PM +0200, David Hildenbrand wrote:
> On 01.09.25 17:47, Vlastimil Babka wrote:
> > On 9/1/25 17:14, Lorenzo Stoakes wrote:
> > > On Mon, Sep 01, 2025 at 04:50:50PM +0200, Max Kellermann wrote:
> > > > On Mon, Sep 1, 2025 at 4:25 PM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > 1. (most useful) Const pointer (const <type> *<param>) means that the dereffed
> > > > >     value is const, so *<param> = <val> or <param>-><field> = <val> are prohibited.
> > > >
> > > > Only this was what my initial patch was about.
> > >
> > > Right agreed then.
> > >
> > > >
> > > > > 2. (less useful) We can't modify the actual pointer value either, so
> > > > >     e.g. <param> = <new param> is prohibited.
> > > >
> > > > This wasn't my idea, it was Andrew Morton's idea, supported by Yuanchu Xie:
> > > >   https://lore.kernel.org/lkml/CAJj2-QHVC0QW_4X95LLAnM=1g6apH==-OXZu65SVeBj0tSUcBg@mail.gmail.com/
> > >
> > > Andrew said:
> > >
> > > "Not that I'm suggesting that someone go in and make this change."
> > >
> > > And Yuanchu said:
> > >
> > > "Longer function readability would benefit from that, but it's IMO infeasible to
> > > do so everywhere."
> > >
> > > (he also mentions it'd be good if gcc could wran on it).
> > >
> > > So this isn't quite true actually.
> >
> > I understood it the same, that it would be nice if gcc treated incoming
> > params (i.e. pointers, not pointed-to values) as const and warn otherwise,
> > but not suggesting we should start doing that manually.
> >
> > I personally agree that adding those extra "const" is of little value and
> > makes the function definition lines longer and harder to read and so would
> > rather not add those.
> >
> > I mean we could first collectively decide (and that's not a review
> > half-suggesting we do them) that we want them, and document that, but AFAIK
> > that's not the case yet. While there's already an agreement that const
> > pointed-to values is a good thing and nobody objects that.
>
> Yeah, and discussed elsewhere in this series, it would also have to be
> clarified how to deal with the *const" (or const values in general) with
> function declaration vs. definition. I don't think we really have
> written-down rule for that yet.

For this series the consensus is clear that we should eliminate these and revert
to const pointed-to values (1) only.

We can determine how we do this in future re: const actual pointers (2), but
this series isn't the place.

So Max - can you respin with the (2) const-ification removed please.

Thanks.

