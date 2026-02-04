Return-Path: <linux-fsdevel+bounces-76338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFg9H4iCg2llowMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:31:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B0EAFEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 18:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF655301904C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF3934A793;
	Wed,  4 Feb 2026 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QnGouFax";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rTL0d5E7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E014A8B;
	Wed,  4 Feb 2026 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226246; cv=fail; b=E8hE2vUIPNsgbYFOQtjDT+LU2zgDwFzgLfYpB+EegJMKX5zNRTPNkZ/k2l0VeG6bqEtDUTbZJqJVJ6C/lJAh8hZZj+gqC29TJmKENaLzFgw5yYG80v5k/A9qAkag6QewrJtqaMSd49d+IuS7LKv4pDa1u8xavGwqRd3lSbf3tR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226246; c=relaxed/simple;
	bh=7fIBrZwFqhVJ3uPtRltGJFUC0ExZtK4iXyAs6t1c8ps=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AsbdpImlQDS6ErbFLAIerrHyXqXAcgH4N1Ju+MIs2tB3euFTpicMtr2s8HpArLZMoFPRjwlurSi7qjA2enH7cJ/8BW8LRp7e81TLG/tGrMxNAXnonMOdyUsiaS5PZpvCNJZb0s/1jabsxU5d+O89V8XzgPUu0mL9doXwRb6+f4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QnGouFax; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rTL0d5E7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614DOX2J2146675;
	Wed, 4 Feb 2026 17:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rOqqJln4RsSwft73IfboVbkMNcf/njrRyGFXn8TMcUo=; b=
	QnGouFaxn3CY7zEeVK23DxXD7QH3yn/64z++Sri7u4Q+dklwkWHtSJ+39/+XfZNJ
	Ed/oeTicjnm8juUx9sYfik7KEuNFdoRpRHS5xxskD1Dcb1oU/DwMUWYTiq7Op6uD
	YnNZLYUsoHvZ4ONoTTQY92vgJNJ7OUyscnI210OoKmmvP00pMMzclCDbbiLNrD2d
	kZnypNIBLllQ/r/q0Vlo7xfwtJGm5sNJsF6kjMrTim9uhIuoaoVasa/l2ybrDJ1I
	acvLOd3VwiZhHZZtdc9P0IsOQnZiPx6I1D+9ydMmeKOWhmUrXWXwSfwLxLc3mvN/
	3x4hbev023EktK1EptA3Ew==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k7uj7p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 17:30:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 614Gcx2k035362;
	Wed, 4 Feb 2026 17:30:01 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186bqaa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 17:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUF2oIb40dGkHzHx4kScs1zlCweI0kn7NQQmynmNXALacoKvl17BZoaF1xfOQ2Gmh862Ku4uChP790q6fWuN8TvqrYHm0+PHi7Zw1XrwIOoiH+f4gWf671RgUummKasdflOc3IQY9sBIWcChbbdx1FpbHx0B51sdgez/sRK/T4kPi4zQrLEyvT14delpn8WPKGJkm/TUVkE/mNN5Pzhj0vwiQNapBma8xIb3fNgKAtU2yXK3O7ZDQB+9RS1ZuYlTeqOH6xeT4Bo05KIT0v9q+DgsaKy/vTz76rkdPXbDP6H/vzjB7mmtqPYWUr6Imedp2vAC7B16SmIssPq8TSVl1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOqqJln4RsSwft73IfboVbkMNcf/njrRyGFXn8TMcUo=;
 b=s3SsdzSCeYIzJei9tOyDr3F9k/Lsj6+aVgZKxlC8MQBoX6p+DrcRPBSCvS8gQXohPJNA6fPo4qrnJ8XCgK+ufeIKbVAu9EkyyswAvmGKRPb2WZ1Xncz3lPFBxdokQdPZT7TCHi0M3l+FyEv10j9m6WXtdzJl87qjXiCUn2rEMpvSMmplHluld2vVYJrp4P09Xm0pkoW++9rEU2SSUgyDSqQIakqKsjeERuoZkMUNi8LkNbSqKeopTCeBub+MDZe+GjjScw0+tCB2a7LGem3cfYJIKq01aLyB4e3MIDg51DxdsjD/XmnSrDiV25nBd1A7pZD5OC8HRwFofJl4VZyQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOqqJln4RsSwft73IfboVbkMNcf/njrRyGFXn8TMcUo=;
 b=rTL0d5E7jEd3uQbw2/2XPr2cyasifuMIfz44kiDzikziVoV2WtCmcoeItuRv+tLD5S5+/coRzhkM2qxOy5Lwl6nilfGQ/6WvAD4pGUm2OvHelgemPoWfpxvtBMWBmCuaEEa+x95bk9QJPbNJZJHeRQcGV3U2hdEFwootBUhYp7E=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB997603.namprd10.prod.outlook.com (2603:10b6:8:314::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 17:29:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:29:57 +0000
Message-ID: <01d1c0f5-5b07-4084-b2d4-33fb3b7c02b4@oracle.com>
Date: Wed, 4 Feb 2026 18:29:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm: memfd/hugetlb: introduce memfd-based userspace
 MFR policy
To: Jiaqi Yan <jiaqiyan@google.com>, linmiaohe@huawei.com,
        harry.yoo@oracle.com, jane.chu@oracle.com
Cc: nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de,
        rientjes@google.com, duenwen@google.com, jthoughton@google.com,
        jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com,
        sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com,
        dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260203192352.2674184-1-jiaqiyan@google.com>
 <20260203192352.2674184-2-jiaqiyan@google.com>
Content-Language: en-US, fr
From: William Roche <william.roche@oracle.com>
In-Reply-To: <20260203192352.2674184-2-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB997603:EE_
X-MS-Office365-Filtering-Correlation-Id: e4795721-573b-4566-c5cc-08de641303eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmNsUHBIajQ0SWFmNzhHVGlqWldncFJ1aGpDUUNnTWdESkpRMnJiMTRGc3VL?=
 =?utf-8?B?NE04Q0VWNVY1c3Q2bE5MMFhWVjF5RzEvN0kxWjEvaXpwNmFNQkF3Y3ZoU0VW?=
 =?utf-8?B?QUQ5VG1pWE9DUEZ1bm9VNFVMWXk4SnFHM3FYeUtBWU9Mdk9JWFEwQmMweFRZ?=
 =?utf-8?B?ejFtdWtNU3NGNTlCTkdMejYwUE8yMG1FZGF6RFVwbHZab052VC9iSm0zc1dy?=
 =?utf-8?B?ZzcvYXY3eEJrRlZyZ1lLdXlxSWVkbUhPR21oME53KzFxOU5NU05pcUpCOUtm?=
 =?utf-8?B?TGh1aXQ2amlBQ3ROclp4RVlWd1JrZjJjT2cyMzUwUU5pZ1hsS3oxd3J1TjJv?=
 =?utf-8?B?bjFQYkFhQXU0a2ovbDc0UWo5amw4MFJXbEJueEIrVDBZU1k1YjBYaVFjN2Q2?=
 =?utf-8?B?ZHNRV2VsbEM2bnZsaWRLQ0ZUdEVyOG5NdXN4UE1aRk91a2k5czYvWTVnWk85?=
 =?utf-8?B?NlE5dG1IdlYwc0RjdlRPelEwV3g3L09VTXBVZEUrenVEZlc3TUh0RFgvNzFM?=
 =?utf-8?B?WVI1V0MwVXRxVW1oeHVTYnNaVDhmZmlmbTd0TGZJZnFaL0swZW92Q3QxSEZQ?=
 =?utf-8?B?TmpnRTdHMTkyaFZWSHNQd0cvRnVNZUEyOHA3M1Q4MWQ2N2lLYUxIS3UySDB6?=
 =?utf-8?B?UW5lRlFIRUxPTHAxR1dqRG1OeWxNOStOMTNRZTJlQVk5dGFXTndiU2VuTG10?=
 =?utf-8?B?aElKcTUxYTRyWVUwaC81K2JoNUxoaE5XQjB1bXM5VEdOc1BqZkt0VlJ0L0JV?=
 =?utf-8?B?cSt2VmhreEdwcFdQanYxa2p5SlcvSzVJQ2kzWmd6ODZOUHJQaGlpUVlnMk9E?=
 =?utf-8?B?SXQ0SFpuK2pZR2I3WTlWd0ErQVhQTEJNKytYdG43QlZ3ZnJadWphbmlHRTg2?=
 =?utf-8?B?dnRoY2l3L0NUbXB1cVk3SzJPVGY5by9qdXl5bTdiRkg0NFBjdWJyZTFtSHYx?=
 =?utf-8?B?Yk1DOTFMM1IzcDM5U0QzUWQvREh3M1JtdVBvR2gwbUVRenFtU1U1WlhXNUZW?=
 =?utf-8?B?NlpkTldvTnc2T3Y3dVBpWDZ1NkQ1V1E3UjRmc1dSK0FIYkN3YzJPMC9SWHRR?=
 =?utf-8?B?WE5RRHQ0VThDbEZCeGFMYXdpLzZEbFZLUlY3djdxYzNYNFJENWpUaEJtbFFw?=
 =?utf-8?B?VlI5TmxlN1RmbWFaWHMvNGJMbHlpSENQa3Z3bnA2VjFTaDQyUWNzWWo3Z29H?=
 =?utf-8?B?ak1FWWIreGhaZE5ldldGRWhzcWkwelFKSFI0UTRmNmV6VG5RcGlVamhseGlp?=
 =?utf-8?B?M3BoSXQyNVNNZG10REh3MEFIa2M2WlZZbU13NmNrUVQwWFF3T2lOZk9HUFNQ?=
 =?utf-8?B?dzJ2KzR1MTVPUDR1d0Foa2lqaTAzcnlta2ZVa3A5blJYa0NOYnhLYXBTQkdh?=
 =?utf-8?B?KzZLb3hFNFFRU3NmUkVMUmtJb29ZTG5HWjNuSXVkMk9XTllDQlZSR0l3WDZH?=
 =?utf-8?B?aDU1ZVk1Yzgxemh5aWhLdmRSQ001R1hQRW1FU1dNRVU2N1VzRkptQlNlOVhh?=
 =?utf-8?B?b3FYTlJYSWdoTFZ0aHducVBBQWlvWCs3U01ycFlPQ0p3MUQwQjdLK0FkR2NS?=
 =?utf-8?B?NERETmtESngremErVW1SRW9qM09ZSlJ0UEZMQWc4VWdRSlo3elFJeVRvTmQv?=
 =?utf-8?B?a2F3c0szQUg4R3MyVW85MnBNcnYwRUt1enBpNmRUdEVTWVU3OGRoem5SQVMy?=
 =?utf-8?B?WUUzTElDdlNCd01hNGxadlpUV2MwWURjYXFVQk5kWW93dkNhbVhmbzlkcVU2?=
 =?utf-8?B?VGhXSlpUcjRoNmVYbFBydWxpM09SN0VxaWwzVnhXbGhrQXpkSzU2eXpPMk1P?=
 =?utf-8?B?K21TdzFLcWdLRzdaWmpzM2RnSGRVZ2ZraGRIdmdrbUJ4czlHWU1EOTlhYzA1?=
 =?utf-8?B?YTVSTDF4RGRSMmVuNDFOVmhGOUlEc0VvMHlsMmdWOHg4VEJUM1ovWjR0Y0hG?=
 =?utf-8?B?SG5UeEoxRE5DbkJhaHBac0lqZ1N6czJIMzBxMmkwcHYxRHpXNHNXN2E5WGlD?=
 =?utf-8?B?MGNQbXpySm1KYjVyallQbWRDT1Vta2JCVXExZUhqMFRPUXJOd01YbnA5NkZU?=
 =?utf-8?B?SlNSMVNHenU1Sm1ZcnRBRms2MnMrOTRrS3Q3c1dWNmQ0QjNySitPa3JoTXlM?=
 =?utf-8?Q?ywHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0lxWWVBSEhCQzduV3puV2NZSEJLS1RnTFE0c0U3Y1RydUpESUhXdnpJaHd2?=
 =?utf-8?B?d2ZsdG52YXhHTDczVHVzdUlsNHRaZWxIeG5qUE9OR3FqSDI0UWtNK1gxcXZh?=
 =?utf-8?B?dHhFMEcyRWNQTElVZjNDY0RneHMrcklKdmdUSFB1WjYxQmVHMnc5ZW1XeEFo?=
 =?utf-8?B?YXZ5c1ZzVWprR1U1eEVnVGVocUdBalhoMlhkcmQ0dlJPREVsejFZU0ROeHA3?=
 =?utf-8?B?bXNGWFh4LzNFT0ZVbEp1ZjQzRng4NHM3ODhGaU9iZDFMby9RRGFieWVXZ2xw?=
 =?utf-8?B?TGFvV25Ca2FjQ0syMlpBSU8zb2JBUFV3R0tZRTNLQWxvZFlDejNTZFlkcXBp?=
 =?utf-8?B?RWtyMlZXa25pb1kwU0dmeG5oY0V0RFcwQkt3bWt2c1ZHUWVCaGlqalg4OFpS?=
 =?utf-8?B?OVY1M1U0OXQzbmU1dkJYNFZpakIyMzJJWXRISVVuMFNRczZNbnduU01mQ0xa?=
 =?utf-8?B?WSs0cTZQVVRHZUd2UmZBeTc2U1l2S3BjMndQKy80b205S3ZBTldJci9aT2N1?=
 =?utf-8?B?TWJUQndOZC9CS3pESnIzd1RjOHl5Z3lhUktSUUlOQ2czUlpmZnZIOU9kUjhk?=
 =?utf-8?B?NkRDaGczbzNGMXhlVWRLNmxiTllOSUNwN1ZNZGE2cFAzRHpRelk0eFI3V01N?=
 =?utf-8?B?ODdZZ1ErclBURGRaN1JxUU5mRC81WFE0bHlLUmE1QlB1ZzA1VFRmYXlnWGlL?=
 =?utf-8?B?WjVyVzREbTdYMG9YRmFMUGgvMndVVHFZVXd3ay9mTFNVMWpFeE54QnFORTBv?=
 =?utf-8?B?ZFh5WjdBZTlxRHRFdjN2aTJ3emhCQ3VJSk5odWJmalVOZkVveXJLbkNtYlpG?=
 =?utf-8?B?SE9NV3pZQlZaMHJiTzYwTGZQU0RuamF3ZjRQNFBVdmlmai9GVWRzTDVUUkcz?=
 =?utf-8?B?TGYrLzVlY3lhM1pkMHBkdkt3T1J2cjBkdElqZU10OWE5cmZ0OWtvRUN1ck4w?=
 =?utf-8?B?d1lkQW1GNTA1RUY2QWxpUXFDZ1daYVk3bHRVQ2c3K3lXUnlTVG9XR2xQaTAz?=
 =?utf-8?B?eDZPVmRuOWpVUnJzSC9EQkFUY1lLTkw4MUxkR3U5d1NFNXhaSG41cG05Sndh?=
 =?utf-8?B?TlI0c0FMZTJCT0xhcTJ6ZHIrVFpzSUp0VVNEQlN0OGtsemlDOE45S0VyR3JE?=
 =?utf-8?B?bWxPR3g1SXZtWnBsdlhVbGcxYUlNVzNhZHlqL000Q3IveDYrc211U3VJSGZR?=
 =?utf-8?B?WGlwV1lHRjdubUtVeTU3bVZsS2lWNEpiYU41U083bmFKRy91dS8yRnpuUUFC?=
 =?utf-8?B?TktlbUdLQmZIUWE2NysxZjN5THlIeDF4TFcxVElxZWxoUjFIY2NDRmdZeTF4?=
 =?utf-8?B?ZEJVUnFpVzFCOWRLUlBOSGRQMGE0L1ljajFkbTFPcWphcVdyQWJMWU5hNC9p?=
 =?utf-8?B?WmZpenBPZ01ZaEpBeC9Wcno2bFNENEFuc0hSVEVhMlBocjRPdmpZODVFWEFE?=
 =?utf-8?B?ajlpNEs5TVBjNHFuNUtlSVVzY2xsRWxnOTdmdDZWbFdyNGp4dUdTeXl2RUNv?=
 =?utf-8?B?eG5OTml2dVBzSnpkK0QycitBMk5HYjZlS3hxelUyOHRxdHBLVm9ud3B4d21E?=
 =?utf-8?B?ZlREZkwxRHJHd1VLckhiTFE4OHZBL3lEWUdMOXYrWUVPcC9tc1pwR1BhTDJk?=
 =?utf-8?B?b0JCOHdENDEzcWVnNWVmcm5RWlJKd0p3R3pHZ0VRVWY1anlER0ZFem13Yk80?=
 =?utf-8?B?TlV2NHNtR2R1dXBUL1RoVmNVU0RXQnppelpwZXI2dHNEME5MWENSNTdkTFlR?=
 =?utf-8?B?ekFha2FTcldyUEJUU3BDRmdOazR2dDBudjYzLzlVOVJpYzVVOCtDYWZmV3M3?=
 =?utf-8?B?cy9EcHNtQUVKa3hqa2FPUGUxNjViY0grYjNxZUZIMmV5QXhOTHlCU0FCeG00?=
 =?utf-8?B?NWFiYmxlUFZYY1pObVVyTjQzRmxPUUtGc3E4a3VzTS9UTGVIRlN1cXVPaTdt?=
 =?utf-8?B?cU9rYXpMdlBzN1RzSWRzVUhsY0hXSEJCZXhVQXZxZGJCbHEwMXMxODdpR3pU?=
 =?utf-8?B?eEhKUFVTWFNVN1gwWngwWXY1SnptK1QwVDhUNk56V2ZTRFVIZjVIVjRnd1BV?=
 =?utf-8?B?S1FoQ2RuZXFPNWlYUXBMTlZwVWV6QnlJWWMvVnJmNDc3cGNKV0wyQ0JYL2RB?=
 =?utf-8?B?aUdBZWdmRUtxM2toTUl6NXhRbWs2Znd2aTFGdGp1U1hRcmNqL214bFJnR2Vm?=
 =?utf-8?B?eXVWTzhDZm5WaHRQRkFMZ0Vuc0F6cGVBTlBCQURHaVZHajVlYnRZK2VvcGoy?=
 =?utf-8?B?YWVmRVBOK1YxR1A2YXU1YmpXSEZPb2JGblZuSW5ZVytmbGlWUnFiMTZaVlox?=
 =?utf-8?B?NG1jczRiSHRIS3Jwa25kazg5aW9aY2FEN1ExYzN0Qk9RQzNBeElNL2JwcVdU?=
 =?utf-8?Q?J4sAPUVjsVd0rUbc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ShOPpxJ7hDF8eou+NfiVpp3TUVuycfqH0CXlViwdnyOtDEh8WYBUCGCDatQhytNMzUydDuByVfaRo2NzoqEACgKFDMnUP1i2AywD6SIWnuD+hgXBu/f5ZFdtg+osvI4fQ3WddnttYL2r/982nJjeTw8yKUyNL+HpwCbiMC8nenIksWf30A/+zMBE4LWna770e5Ie2UOgpIBxrzxxSGv1SeGb+s/vRypQe3Puvbpaly+EJLyc4dvkfqqHvtbbCgHcWZc4DiebSMQ84AulXnyh9j8fm9oAei7gNtIuly6xc085Ql+FoPrweHAdjT+aMe+Lf8BnFPlcwH9Y/kj0Mnxso22PVhyrmycnvyA+KE8she2I97s/MOhiIAZulzRlMul0FUzCexHd8LoLsSPkS6dAXHvcYFjw56xoNkWTYBhIbMUu/zmRZm/ncaTBMBvyfAQJBSAckzRDQdhw81Cxeah868Fc3QEu1OQEu9CXN2EhCzXsC9nmmUHidmW9vyjQYqQz+sJcVi4wDNz8gVosChtJmQEQsQ5oaOrg/yLNaJaAP3P+DIjlMvRwDTJwE2Ocr2L7p14+PgTlA0walR/k1KryF+k5kD/P3nNjmMYyVWYv5GE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4795721-573b-4566-c5cc-08de641303eb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:29:56.8623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL9gjZoY7EsuBGVqaCXdpi3aQRGQ3WLSVkF5/i4sKPw19DXs/czVqWzOOk2vgz505SzIeXHX+Wg4ky9iW1ug7z3VSLWIR2X286ANq7YgwnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602040133
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEzMyBTYWx0ZWRfX7vHRZDWrjq/8
 Afz/Prl87pGbD3YYC5oBHp2xZfrTedOlHWLhJxEYEurh369lxuRahSnFjNcLbci8q3Y9HeJmQS5
 OawVWbf87lWa9BL3E89DjfSG9UzP4LLf/mjgUziv4Vr9YEH3ylBROKzG5R6q3p1xTIVYP29Wuk2
 hGuewSu0aSCDdWyCyNXZb1SWly5xgKoOge/fCZHRiOeHkkWQkskK/N+kg0gV54zPhTWqgJnZa1K
 Ik7Ex3ZTJ1TRB3Hda5D0a/AUZQbw3Zxw/96vG033AFeIGR1Z1Z8MvWXBPnSxjkx0inLht0Yc6ny
 g47kmvj/3pI/SgKFeKUwFagQuqP+ulhkCoF/PSROECcXnDnZPh9QWqLmYaHLNLhWsCXJlZPCdDj
 txO+6+JEWUbqbI/LNNSdD5Vth0psbtfVhoukI7NITlVXyigQ6ONvPrtwDLaZ8UFTu/wqZBNzKYZ
 /SPinTXeYZ1tmPM9mGw==
X-Proofpoint-GUID: hOrmqkwr5Qs_lbAYI1OCUk1Z0r2u42_0
X-Authority-Analysis: v=2.4 cv=Z7Dh3XRA c=1 sm=1 tr=0 ts=6983821a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=L_QKBFx7AAAA:8 a=oiheiGzFm8RGR79SthwA:9 a=QEXdDO2ut3YA:10
 a=vnCMA-Uec3W5cvR2C-ze:22
X-Proofpoint-ORIG-GUID: hOrmqkwr5Qs_lbAYI1OCUk1Z0r2u42_0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76338-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[william.roche@oracle.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DF0B0EAFEC
X-Rspamd-Action: no action

On 2/3/26 20:23, Jiaqi Yan wrote:
> [...]
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 3b4c152c5c73a..8b0f5aa49711f 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -551,6 +551,18 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
>   	}
>   
>   	folio_unlock(folio);
> +
> +	/*
> +	 * There may be pending HWPoison-ed folios when a memfd is being
> +	 * removed or part of it is being truncated.
> +	 *
> +	 * HugeTLBFS' error_remove_folio keeps the HWPoison-ed folios in
> +	 * page cache until mm wants to drop the folio at the end of the
> +	 * of the filemap. At this point, if memory failure was delayed

"of the" is repeated

> +	 * by MFD_MF_KEEP_UE_MAPPED in the past, we can now deal with it.
> +	 */
> +	filemap_offline_hwpoison_folio(mapping, folio);
> +
>   	return ret;
>   }
>   
> @@ -582,13 +594,13 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>   	const pgoff_t end = lend >> PAGE_SHIFT;
>   	struct folio_batch fbatch;
>   	pgoff_t next, index;
> -	int i, freed = 0;
> +	int i, j, freed = 0;
>   	bool truncate_op = (lend == LLONG_MAX);
>   
>   	folio_batch_init(&fbatch);
>   	next = lstart >> PAGE_SHIFT;
>   	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> -		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +		for (i = 0, j = 0; i < folio_batch_count(&fbatch); ++i) {
>   			struct folio *folio = fbatch.folios[i];
>   			u32 hash = 0;
>   
> @@ -603,8 +615,17 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>   							index, truncate_op))
>   				freed++;
>   
> +			/*
> +			 * Skip HWPoison-ed hugepages, which should no
> +			 * longer be hugetlb if successfully dissolved.
> +			 */
> +			if (folio_test_hugetlb(folio))
> +				fbatch.folios[j++] = folio;
> +
>   			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>   		}
> +		fbatch.nr = j;
> +
>   		folio_batch_release(&fbatch);
>   		cond_resched();
>   	}
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e51b8ef0cebd9..7fadf1772335d 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -879,10 +879,17 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn,
>   
>   #ifdef CONFIG_MEMORY_FAILURE
>   extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
> +extern bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> +						struct address_space *mapping);
>   #else
>   static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
>   {
>   }
> +static inline bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio

comma is missing

> +						       struct address_space *mapping)
> +{
> +	return false;
> +}
>   #endif
>   
>   #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ec442af3f8861..53772c29451eb 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -211,6 +211,7 @@ enum mapping_flags {
>   	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
>   				   account usage to user cgroups */
>   	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
> +	AS_MF_KEEP_UE_MAPPED = 12, /* For MFD_MF_KEEP_UE_MAPPED. */
>   	/* Bits 16-25 are used for FOLIO_ORDER */
>   	AS_FOLIO_ORDER_BITS = 5,
>   	AS_FOLIO_ORDER_MIN = 16,
> @@ -356,6 +357,16 @@ static inline bool mapping_no_data_integrity(const struct address_space *mapping
>   	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
>   }
>   
> +static inline bool mapping_mf_keep_ue_mapped(const struct address_space *mapping)
> +{
> +	return test_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> +}
> +
> +static inline void mapping_set_mf_keep_ue_mapped(struct address_space *mapping)
> +{
> +	set_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
> +}
> +
>   static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
>   {
>   	return mapping->gfp_mask;
> @@ -1303,6 +1314,18 @@ void replace_page_cache_folio(struct folio *old, struct folio *new);
>   void delete_from_page_cache_batch(struct address_space *mapping,
>   				  struct folio_batch *fbatch);
>   bool filemap_release_folio(struct folio *folio, gfp_t gfp);
> +#ifdef CONFIG_MEMORY_FAILURE
> +/*
> + * Provided by memory failure to offline HWPoison-ed folio managed by memfd.
> + */
> +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +				    struct folio *folio);
> +#else
> +static inline void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +						  struct folio *folio)
> +{
> +}
> +#endif
>   loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
>   		int whence);
>   
> diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
> index 273a4e15dfcff..d9875da551b7f 100644
> --- a/include/uapi/linux/memfd.h
> +++ b/include/uapi/linux/memfd.h
> @@ -12,6 +12,12 @@
>   #define MFD_NOEXEC_SEAL		0x0008U
>   /* executable */
>   #define MFD_EXEC		0x0010U
> +/*
> + * Keep owned folios mapped when uncorrectable memory errors (UE) causes
> + * memory failure (MF) within the folio. Only at the end of the mapping
> + * will its HWPoison-ed folios be dealt with.
> + */
> +#define MFD_MF_KEEP_UE_MAPPED	0x0020U
>   
>   /*
>    * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a1832da0f6236..2a161c281da2a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5836,9 +5836,11 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>   		 * So we need to block hugepage fault by PG_hwpoison bit check.
>   		 */
>   		if (unlikely(folio_test_hwpoison(folio))) {
> -			ret = VM_FAULT_HWPOISON_LARGE |
> -				VM_FAULT_SET_HINDEX(hstate_index(h));
> -			goto backout_unlocked;
> +			if (!mapping_mf_keep_ue_mapped(mapping)) {
> +				ret = VM_FAULT_HWPOISON_LARGE |
> +				      VM_FAULT_SET_HINDEX(hstate_index(h));
> +				goto backout_unlocked;
> +			}
>   		}
>   
>   		/* Check for page in userfault range. */
> diff --git a/mm/memfd.c b/mm/memfd.c
> index ab5312aff14b9..f9fdf014b67ba 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -340,7 +340,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
>   #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
>   #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
>   
> -#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
> +#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
> +		       MFD_NOEXEC_SEAL | MFD_EXEC | MFD_MF_KEEP_UE_MAPPED)
>   
>   static int check_sysctl_memfd_noexec(unsigned int *flags)
>   {
> @@ -414,6 +415,8 @@ static int sanitize_flags(unsigned int *flags_ptr)
>   	if (!(flags & MFD_HUGETLB)) {
>   		if (flags & ~MFD_ALL_FLAGS)
>   			return -EINVAL;
> +		if (flags & MFD_MF_KEEP_UE_MAPPED)
> +			return -EINVAL;
>   	} else {
>   		/* Allow huge page size encoding in flags. */
>   		if (flags & ~(MFD_ALL_FLAGS |
> @@ -486,6 +489,16 @@ static struct file *alloc_file(const char *name, unsigned int flags)
>   	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
>   	file->f_flags |= O_LARGEFILE;
>   
> +	/*
> +	 * MFD_MF_KEEP_UE_MAPPED can only be specified in memfd_create;
> +	 * no API to update it once memfd is created. MFD_MF_KEEP_UE_MAPPED
> +	 * is not seal-able.
> +	 *
> +	 * For now MFD_MF_KEEP_UE_MAPPED is only supported by HugeTLBFS.
> +	 */
> +	if (flags & MFD_MF_KEEP_UE_MAPPED)
> +		mapping_set_mf_keep_ue_mapped(file->f_mapping);
> +
>   	if (flags & MFD_NOEXEC_SEAL) {
>   		inode->i_mode &= ~0111;
>   		file_seals = memfd_file_seals_ptr(file);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 58b34f5d2c05d..b9cecbbe08dae 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -410,6 +410,8 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
>   			  unsigned long addr)
>   {
>   	struct to_kill *tk;
> +	const struct folio *folio;
> +	struct address_space *mapping;
>   
>   	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
>   	if (!tk) {
> @@ -420,8 +422,19 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
>   	tk->addr = addr;
>   	if (is_zone_device_page(p))
>   		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
> -	else
> -		tk->size_shift = folio_shift(page_folio(p));
> +	else {
> +		folio = page_folio(p);
> +		mapping = folio_mapping(folio);
> +		if (mapping && mapping_mf_keep_ue_mapped(mapping))
> +			/*
> +			 * Let userspace know the radius of HWPoison is
> +			 * the size of raw page; accessing other pages
> +			 * inside the folio is still ok.
> +			 */
> +			tk->size_shift = PAGE_SHIFT;
> +		else
> +			tk->size_shift = folio_shift(folio);
> +	}
>   
>   	/*
>   	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
> @@ -844,6 +857,8 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>   				  int flags)
>   {
>   	int ret;
> +	struct folio *folio;
> +	struct address_space *mapping;
>   	struct hwpoison_walk priv = {
>   		.pfn = pfn,
>   	};
> @@ -861,8 +876,14 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>   	 * ret = 0 when poison page is a clean page and it's dropped, no
>   	 * SIGBUS is needed.
>   	 */
> -	if (ret == 1 && priv.tk.addr)
> +	if (ret == 1 && priv.tk.addr) {
> +		folio = pfn_folio(pfn);
> +		mapping = folio_mapping(folio);
> +		if (mapping && mapping_mf_keep_ue_mapped(mapping))
> +			priv.tk.size_shift = PAGE_SHIFT;
> +
>   		kill_proc(&priv.tk, pfn, flags);
> +	}
>   	mmap_read_unlock(p->mm);
>   
>   	return ret > 0 ? -EHWPOISON : 0;
> @@ -1206,6 +1227,13 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>   		}
>   	}
>   
> +	/*
> +	 * MF still needs to holds a refcount for the deferred actions in

to hold (without the s)

> +	 * filemap_offline_hwpoison_folio.
> +	 */
> +	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +		return res;
> +
>   	if (has_extra_refcount(ps, p, extra_pins))
>   		res = MF_FAILED;
>   
> @@ -1602,6 +1630,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   {
>   	LIST_HEAD(tokill);
>   	bool unmap_success;
> +	bool keep_mapped;
>   	int forcekill;
>   	bool mlocked = folio_test_mlocked(folio);
>   
> @@ -1629,8 +1658,12 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   	 */
>   	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>   
> -	unmap_success = !unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> -	if (!unmap_success)
> +	keep_mapped = hugetlb_should_keep_hwpoison_mapped(folio, folio->mapping);

We shoud use folio_mapping(folio) instead of folio->mapping.

But more importantly this function can be called on non hugepages 
folios, and hugetlb_should_keep_hwpoison_mapped() is warning (ONCE) in 
this case. So shouldn't the caller make sure that we are dealing with 
hugepages first ?


> +	if (!keep_mapped)
> +		unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
> +
> +	unmap_success = !folio_mapped(folio);
> +	if (!keep_mapped && !unmap_success)
>   		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
>   		       pfn, folio_mapcount(folio));
>   
> @@ -1655,7 +1688,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
>   		    !unmap_success;
>   	kill_procs(&tokill, forcekill, pfn, flags);
>   
> -	return unmap_success;
> +	return unmap_success || keep_mapped;
>   }
>   
>   static int identify_page_state(unsigned long pfn, struct page *p,
> @@ -1896,6 +1929,13 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>   	unsigned long count = 0;
>   
>   	head = llist_del_all(raw_hwp_list_head(folio));
> +	/*
> +	 * If filemap_offline_hwpoison_folio_hugetlb is handling this folio,
> +	 * it has already taken off the head of the llist.
> +	 */
> +	if (head == NULL)
> +		return 0;
> +
>   	llist_for_each_entry_safe(p, next, head, node) {
>   		if (move_flag)
>   			SetPageHWPoison(p->page);
> @@ -1912,7 +1952,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   	struct llist_head *head;
>   	struct raw_hwp_page *raw_hwp;
>   	struct raw_hwp_page *p;
> -	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
> +	struct address_space *mapping = folio->mapping;

Same here - We shoud use folio_mapping(folio) instead of folio->mapping.

> +	bool has_hwpoison = folio_test_set_hwpoison(folio);
>   
>   	/*
>   	 * Once the hwpoison hugepage has lost reliable raw error info,
> @@ -1931,8 +1972,15 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   	if (raw_hwp) {
>   		raw_hwp->page = page;
>   		llist_add(&raw_hwp->node, head);
> +		if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +			/*
> +			 * A new raw HWPoison page. Don't return HWPOISON.
> +			 * Error event will be counted in action_result().
> +			 */
> +			return 0;
> +
>   		/* the first error event will be counted in action_result(). */
> -		if (ret)
> +		if (has_hwpoison)
>   			num_poisoned_pages_inc(page_to_pfn(page));
>   	} else {
>   		/*
> @@ -1947,7 +1995,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>   		 */
>   		__folio_free_raw_hwp(folio, false);
>   	}
> -	return ret;
> +
> +	return has_hwpoison ? -EHWPOISON : 0;
>   }
>   
>   static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
> @@ -1980,6 +2029,18 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
>   	folio_free_raw_hwp(folio, true);
>   }
>   
> +bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
> +					 struct address_space *mapping)
> +{
> +	if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
> +		return false;
> +
> +	if (!mapping)
> +		return false;
> +
> +	return mapping_mf_keep_ue_mapped(mapping);
> +}

The definition of this above function should be encapsulated with
#ifdef CONFIG_MEMORY_FAILURE
#endif

> +
>   /*
>    * Called from hugetlb code with hugetlb_lock held.
>    *
> @@ -2037,6 +2098,51 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>   	return ret;
>   }
>   
> +static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio)
> +{
> +	int ret;
> +	struct llist_node *head;
> +	struct raw_hwp_page *curr, *next;
> +
> +	/*
> +	 * Since folio is still in the folio_batch, drop the refcount
> +	 * elevated by filemap_get_folios.
> +	 */
> +	folio_put_refs(folio, 1);
> +	head = llist_del_all(raw_hwp_list_head(folio));
> +
> +	/*
> +	 * Release refcounts held by try_memory_failure_hugetlb, one per
> +	 * HWPoison-ed page in the raw hwp list.
> +	 *
> +	 * Set HWPoison flag on each page so that free_has_hwpoisoned()
> +	 * can exclude them during dissolve_free_hugetlb_folio().
> +	 */
> +	llist_for_each_entry_safe(curr, next, head, node) {
> +		folio_put(folio);
> +		SetPageHWPoison(curr->page);
> +		kfree(curr);
> +	}
> +
> +	/* Refcount now should be zero and ready to dissolve folio. */
> +	ret = dissolve_free_hugetlb_folio(folio);
> +	if (ret)
> +		pr_err("failed to dissolve hugetlb folio: %d\n", ret);
> +}
> +
> +void filemap_offline_hwpoison_folio(struct address_space *mapping,
> +				    struct folio *folio)
> +{
> +	WARN_ON_ONCE(!mapping);
> +
> +	if (!folio_test_hwpoison(folio))
> +		return;
> +
> +	/* Pending MFR currently only exist for hugetlb. */
> +	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
> +		filemap_offline_hwpoison_folio_hugetlb(folio);

Shouldn't we also test here that we are dealing with hugepages first 
before testing hugetlb_should_keep_hwpoison_mapped(folio, mapping) ?

> +}
> +
>   /*
>    * Taking refcount of hugetlb pages needs extra care about race conditions
>    * with basic operations like hugepage allocation/free/demotion.


Don't we also need to take into account the repeated errors in 
try_memory_failure_hugetlb() ?

Something like that:

@@ -2036,9 +2099,10 @@ static int try_memory_failure_hugetlb(unsigned 
long pfn, int flags, int *hugetlb
  {
  	int res, rv;
  	struct page *p = pfn_to_page(pfn);
-	struct folio *folio;
+	struct folio *folio = page_folio(p);
  	unsigned long page_flags;
  	bool migratable_cleared = false;
+	struct address_space *mapping = folio_mapping(folio);

  	*hugetlb = 1;
  retry:
@@ -2060,15 +2124,17 @@ static int try_memory_failure_hugetlb(unsigned 
long pfn, int flags, int *hugetlb
  			rv = kill_accessing_process(current, pfn, flags);
  		if (res == MF_HUGETLB_PAGE_PRE_POISONED)
  			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
-		else
+		else {
+			if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
+				return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_DELAYED);
  			action_result(pfn, MF_MSG_HUGE, MF_FAILED);
+		}
  		return rv;
  	default:
  		WARN_ON((res != MF_HUGETLB_FREED) && (res != MF_HUGETLB_IN_USED));
  		break;
  	}

-	folio = page_folio(p);
  	folio_lock(folio);

  	if (hwpoison_filter(p)) {


So that we don't call action_result(pfn, MF_MSG_HUGE, MF_FAILED); for a 
repeated error ?


-- 
2.47.3


