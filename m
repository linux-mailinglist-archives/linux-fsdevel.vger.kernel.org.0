Return-Path: <linux-fsdevel+bounces-67744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A930C491AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 20:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E278C34913C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8238337692;
	Mon, 10 Nov 2025 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iV/MWBAH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XIWxR52F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C993274FD3;
	Mon, 10 Nov 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803556; cv=fail; b=RMVt/JLd5d1AHcWuf/jX6Q6rHLq7D3PlnmIBoOlVrRIk2FjshzYbnnlnr5sbyrWIqXov5H+74ugvPcf5wlNjkw0G1n8pApz8jlUnDApNJVgyLZ9/5JM4cHeG9fLtQCoxIUWLqUbHTSvLi1o72vXrXnNS5Jd3iLNIvrT6q5kYy3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803556; c=relaxed/simple;
	bh=7R9RS9acuPu6rWnaYrN83OXidBuJEGfwfPzQP3wxyeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ROd66D7xfl0gm/H+XG+3KRlbB6Y95SBixLKpt4n8JdANB4sJhr5T+A4nfYsFoky0e3E4mSXbFXVOj60DUFJnEjFIUgGIaXa6tSugb1/NHVkgm8WlUZq6mP66wZfBskpJVdRbddmptdlyXA4ciIjDBtBBpuSVTt8zChJejSh1za0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iV/MWBAH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIWxR52F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAIst9g021315;
	Mon, 10 Nov 2025 19:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=u1tQe1Hx1GXzwrtffKgaTNnwMyegDDqPqGSpmxn7XeY=; b=
	iV/MWBAH6ezsxtqw6g+wGbCX15LFhzi300apShm2sxKw0vTc2juBZ5UqKldp74pA
	4RTvmsLZRmuqV40p6j3py0LTKy/0slgun28RqkFjf9t8b/AL8xEsdJUrl+eqYD7f
	3NQYDVy8CpK4UUT4DmRF6uysa0J7Kz89czxGyiLDpNSJVWf462aZsY8kKJswLIhZ
	9Da64cgaqE2D7qqCmle0QvQYUngGJy15uIAW5roFhR+N+n9UCaR2wpK9L0LgIFAW
	KcAxtjP8YGDXVa1wmZWrJ4y9kimbjugezd6O1Z8VXiAtvG49mGr8cnIuwV7NRSXP
	FPXWpZRC1HB8Obkuu9lLwQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abm9ng9j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 19:38:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAI3d6U010251;
	Mon, 10 Nov 2025 19:38:35 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vajbs45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 19:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLQZzpIIC2Fxc1v0JaYOQ+jdmVSf1mjjrdpUPjo/RSUzd+96FPE5RXxfNu2Q2mslQfZ8jPYEEKgdS+GAV8z/z1r8oRZ9uyr19hCy68sD3tHVP1qUm5DlTScfT6LnsQsovE8kH5i/IF7WiDISyuWm3dPs6uN1pdmO3gH7XTcADPFOf7Xa7IrCB5Leu25glRtwv2XlzhjI2Bg8zDztT7miHjs7u04pDm/946Im0TIMjqPAMpBkNMSGV8450y8dHYSeNjDA46JWofwpElJdD3YtOvXrxVdfrxUHnoX67NLvICOUPwWmwzxT6jZf7YPtRlrLhRrOQbWnCkE1T5Vr/R+2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1tQe1Hx1GXzwrtffKgaTNnwMyegDDqPqGSpmxn7XeY=;
 b=bJOR1mmNri2HYGrW70T0LKU0+dpopFvm2+dn7qvw91OIDpiuGy3bshYbO7N4ku/pa7iMmUaIiNmCLuYFHHBbwrnJ0vDgOB4rglNrUw7NtgSull8nP8BmJsYw/7zhy+l+n65ZXO+maK51ive+555FKBShKzO+lBL2WTuYCFGliBZAFEl5dkNTdZq/0qMzZ/SRAI71Ies3ABVB2jV9POzkZfha5auTRxvDPcwg7PEXuCTOntAQsT5Yi85eXK8FLcBUverlInjRgns5iEO5lKYZNQ5qKGR+izzToG18/Wiu2gJVxXclQiH8mBrZqMo9K+j9u/cZ2rOL41hDRSb7gIyejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1tQe1Hx1GXzwrtffKgaTNnwMyegDDqPqGSpmxn7XeY=;
 b=XIWxR52FqNxPXXH8J5BXP7+0lSKUhqc9D2NLDDqUl3YZVvV/zJcFDYiHNmYr/wJH/Z/7xjGQA/+V47ILiDSSRhyi9ixIkQefNTJu9MU4Ef1L2EF5e3C6mFDhu1koARyvV3gMAF9w8g3QCBdFItx4WNtoab1YK9Kyn9Ekds3Pusw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8472.namprd10.prod.outlook.com (2603:10b6:208:56f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:38:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 19:38:20 +0000
Date: Mon, 10 Nov 2025 19:38:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 04/16] mm: eliminate is_swap_pte() when
 softleaf_from_pte() suffices
Message-ID: <e8cd315b-4902-47a1-b75f-21574a4488c5@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <75c2e8fa38de383757a49bcc3f5c081be1e27a40.1762621568.git.lorenzo.stoakes@oracle.com>
 <CAMgjq7AP383YfU3L5ZxJ9U3x-vRPnEkEUtmnPdXD29HiNC8OrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7AP383YfU3L5ZxJ9U3x-vRPnEkEUtmnPdXD29HiNC8OrA@mail.gmail.com>
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 39566c66-422d-4a3e-61c8-08de2090b419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEloalRpVm1QRjVHMVBNNUFIU2NpTllraERZNnluSFo0TUJWbE1RVTFxTFNH?=
 =?utf-8?B?cEZGam5udjM3andsb0UrTmdNZklRWmRieGdvNnErRGhtVm9SQllueEpJM1Ni?=
 =?utf-8?B?OTRmWFUrbm9CM1FiS3VmRFNkUk1Hb3hqTU50VDg1T29hbkV2RVpRSWZKVUtz?=
 =?utf-8?B?UGllTTJzdWlsV3dZZUZsNjlTN3ErNVRORldJalJZQm1CMm1CNy9yeC9QaVN4?=
 =?utf-8?B?UmlSdm9SY1BTbStrdmMzZlJSdWFUUG1tekpuRFQ1K1FlbGtzWW9RRVZncmh2?=
 =?utf-8?B?NEhaRDZJS0FDQWdweXVPcjR3cUQ0bEpJR2ltckV0UkUvS0JVa0hzNlhTbEph?=
 =?utf-8?B?N09XSGdnLzlKRWI2cFhtWG1PRFNHRzJSV2FHV0RpdW5mSmo0Mitzdm95dnQv?=
 =?utf-8?B?QUZvZWRDZUpRaHpaRXJMdG9SV1hVdFlydE5xcTJVNG91MEJoZ2RuTFVZenBI?=
 =?utf-8?B?eVBSWkJxUW5ZOUxTR0Z2NndIVEZaOTZVcEhGTmc1Z2lxMXZKMDJDbU0rOFlD?=
 =?utf-8?B?dUNvcU8waHpyOUVpa0h2VzJMY3JaL0l2NlpUOXZKZ2FRTDlVcXphUExUOVJS?=
 =?utf-8?B?Y0NyTldjamxjYmhkaVR2c1JpcE1ENUJXTzRSV0YvcG9jLy9jUk1oc1lpTzhR?=
 =?utf-8?B?S21IRzVhQzlRQ1c3Qzl5dTlodGRKOWNFME1lMFlqbUo4US9haGdIWDBFdW5B?=
 =?utf-8?B?Z2xFVmdtZGhCRXlDdk9lN0lpS3RlaitQK3N4WFM1VDlBYUxFb21aTFNQT2tj?=
 =?utf-8?B?SnNIdG1ac1lFSXpuazRGVnUvNEhDa1VFejVVQ3dXK2w2VkRPZnI2V3Z0cWpH?=
 =?utf-8?B?T052dzlzYUM2Tk1VM1NEVmduNGJialltK3F3eFhPeE55VlplUk12ZUF1eHhQ?=
 =?utf-8?B?MEZUdWJMVkR6MVdJNTFraDM1TExETmxGMUpWTUtrelNTZ0FDMUtzWUZMYzdr?=
 =?utf-8?B?d1VPcSt2ZkU2NWJaZFVIN09mQ1RmQnRWUTgrVmIreWJmbVpmZXZvQ0orbzJM?=
 =?utf-8?B?d0QySmwwMVhjVXJ5bVc5eHZhQ3hnNzl4M1RrY0ZrQlFFZkxMS1BTS3dqRVpi?=
 =?utf-8?B?bHkybXZNVGJXOStqVXl2TGkreWFkNW9VK2kzYUhKUlQ4MlZWdkxqRmVQMjRX?=
 =?utf-8?B?TnF1VGZQY3Npa25nc0pvMzFDZ2dtT3VLRC9GdnRPMHhQYkFsb2ZiYTlkeW93?=
 =?utf-8?B?VEZCVWU3SElJZjVvdkk1dXJMTEpJRTQyQU1LNkhVY0FBTEdtelZUejFCSmU2?=
 =?utf-8?B?Z2gzTExYR21rSFhVSlVlZVB2T2lYQmNxeXlPMTMvQnVGYnFQWENsNDE5S0oz?=
 =?utf-8?B?dnFSWFRnUFE1TFJidFlRZXNkMlFabkNiYzFxNFk1OUo3UzNjVzljc2tLRWhk?=
 =?utf-8?B?MEZsNzBpekRtNE1Tb0I5Y0pNQldySjFzY3BzTzdCdEM2QmNmYTc0S1Rmb2Zz?=
 =?utf-8?B?QS9OdE9mMXZiNmV0QUZGNnhnRHhieHB6emVTZ05lekc2clpyNm5DaFR0U2F0?=
 =?utf-8?B?WGpVQVVobWsxR0EzYzkycjJ6Nk50SnA4U2RKUDZSdlVzY3kvcmYvRkd6MGlL?=
 =?utf-8?B?bG1iMjlxM1E1bDRkTThkTUdvZGI0bDNzaUVqa296REJ1MHRBQ0hxZDExMVo5?=
 =?utf-8?B?a0NWaVVrZ0ZDRHcyL2N2cDJRcGRiSTF6Qi9NWHVydUZncysvZHVqckt1K21N?=
 =?utf-8?B?M3JncytEL0tERUl2TW5Wd0hxZmQxc2srVTFPcm5wZmJ1Q2NDeUZZN01VU1Zt?=
 =?utf-8?B?WVBkKzF3alZlZXdRWFV2Y2RtY1VJYzhmK2w4cEJIZHV2V1B1cXpWcHdYTlVq?=
 =?utf-8?B?NlY3N21aemdIcm5ES2hXOFc4YUhmZUpJYnNWNHZrWFpRemVrcmszT2pKZGdq?=
 =?utf-8?B?aVN2bllpejhKVE52b0czdUwrMDVsaEdYSUZQYVNuZWJyb0xnL2l2VHRGb29X?=
 =?utf-8?Q?CQzwzM7LZ4UtU05IxQsYXXpkBxPK2Oeq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkFpV1JOdUhOQzhwdDB2em9wbzFMWXRkZ0NXMnZRV3A3citaUkJzMXBaNGhn?=
 =?utf-8?B?dkdFZk1jUGVWQThaVW90d3RBR0lsd2JZckFKZlFtdm01UTZ0dWVCOHRGMXdj?=
 =?utf-8?B?d21OZDRHTEV3Z09mWHVhSDhVa0gyeXJINE1CbG9UNlgwdXpQLy9BelZYd2Zz?=
 =?utf-8?B?amdEbzF5aW9CTCsyaUsyN0F0UnJqYXFoY01JaGFxVHhPWDZ1ejJOUXU0czVB?=
 =?utf-8?B?U1NDWERtV0s5UGNkMG1WRXR1alphd0lldHY5TmozWnpzWFB6UUFBUk8waUlX?=
 =?utf-8?B?bVBYRjZEWldJelREQTdiR0xRa2c3ay9YcGhtRjcrU096TkszQ3RrQWI3Y1A2?=
 =?utf-8?B?Uit6Z1dGQ0F6TWp0bG9kNzRsOXBPb1cyWSsza2hJTXUrWno1N0o2UnJrSFB1?=
 =?utf-8?B?SEFKVHloNFdMckdVN0pEcU0xT3hKNU1FVmpHWnAwa0ttNW4valJhYmU2cXJ0?=
 =?utf-8?B?VGVwaXBrRUEvMkhkaHAvKzM3YUpPRXkvTjJNeXlHNVZlK0VSRUJITTRLMURx?=
 =?utf-8?B?V3B5dnpWeUw5VjBEZEJKVlJMWlJpQXhKQXBNTzluK2I1ZmRSME1OVW0wZlpH?=
 =?utf-8?B?M3pvNXN6bGdXc3M3WUtJQTNOVi91c1N5U2tSL1ZyZkMyVm9PaXU0TUtiVmRq?=
 =?utf-8?B?dEROZFN1Tkg1WWlta1VBN0hhSTU1NC9BT2FQNktMbjdoVzIvTncwSVVHeEhH?=
 =?utf-8?B?QnlFWmVMZmcwOHBhUmw3K01jdDA3bjZxOWJvbVNROHdFT0RNMmtnaldUcUJr?=
 =?utf-8?B?cTBhdkc0T2JiTTh4aHdRbnRBTGl4VHVQMjdXNk4rek1LS2FlbXJCTWNBdHMv?=
 =?utf-8?B?czhMK1lxSnNwYU11UnhYaUNnSkRsUURSZVpvRVVqb09BRkNKNmlOUEYwalZs?=
 =?utf-8?B?c2xDT2kwZjNESzV3Z3dsVEpKWkhLMDFDZGt4ZzY5Qm5Fd0ZnaC9wdEJrU2JC?=
 =?utf-8?B?WVI2YnBidy8xMXp3bmFUWVR4YnNQUWJBMVVkSHFpTGNQdlgyTExTNjR1bW9M?=
 =?utf-8?B?cVBQZFJuTXMyVkpBWm9PQ3BETVdvTXNVbElNNmtJdTU4MXhreXV3RG16S241?=
 =?utf-8?B?YkwzdlZ3VzJnZEtyMXRDNDBQeVRLdjNvNVpsdHdnQnkvcnVrbmZ5Q2t2Z3k5?=
 =?utf-8?B?SXZIbmN4NU12R0hOZlZwTzZTN1BXVVdsVXRaNGpIMTNEekU2a2VMYXNnN0tj?=
 =?utf-8?B?N2diRHdDbnAyVkxNWmxFUjdwMGRVMVVEOHppNWxPTGVYNUVxQU1Lb0VoelJN?=
 =?utf-8?B?dE9Ud2J1ZVBHUEtHY1AzQTB5VkF0WmJoT3FTbTM4NHN1c0JrZDVuRGtNcHpM?=
 =?utf-8?B?U1I3YjhDTVhFUkcrNFFZUitiY3p5dFBINXppRk5RZjRQYjRvSFhncTZHLzhk?=
 =?utf-8?B?cCtobTg5NWtEb2FXUk5LOHhpR21vbUZ5UzMrNXpyZWU5Z0FudXVFUStCdFBk?=
 =?utf-8?B?cjNjRHViK3UvNS80Ri9uZVFualNjQ05tRFBNbTh1STl6RUoyKzl5UC9WNGlR?=
 =?utf-8?B?NkFkL2hjOEdhVUs0OGYwRnRjZnVhZnZ1N3U4cm9zQUFtdkphak5XSG5sck5l?=
 =?utf-8?B?V3RYWkVWNDkydGZMTUMvdDVqSXQyTlFQakE5YU9TdGowbEova0lKR09nZWFP?=
 =?utf-8?B?YWpBRzZLUE5zYjBnTWp5VVFha01rT2JIU3c5WWZkMzV2OVAxOVk2elNKMXZW?=
 =?utf-8?B?V2hyeklwcVpuSGJCcUJPSXZVaGhxZ3RodkJhODhzeUdFdTlCNjJsakkxT2J1?=
 =?utf-8?B?RUlWN3VVRnBBNlVYcXNYRm5QZTAraUc3aXZHQ1NiaHpRajl1RUh2cnRBd2Zh?=
 =?utf-8?B?REUvdEg3QVVuaGMycG16WDNjYlN4aVE0YlRyL2xtWVMvT1ptejFCd2dlNVEw?=
 =?utf-8?B?V0hkZzFlenVHakhwdDdsMzRVM3Vaa1BGS1QyWGU0b0dZbFY2RGdLNnpNdnl5?=
 =?utf-8?B?eHdTUi9FUy9qVlZrS01aaC9aaVVnNVBETUMzbWhxRTY4dWlPQ0FBQlViQlV3?=
 =?utf-8?B?OXE1aW5Ub2ZieFBodk5FRjdnWGx5dVV1VlFJV3NPakVzNm43eFBZc282Y0sr?=
 =?utf-8?B?Y3U4Q1BsRjJxc0tYZk9KRGgwUktWSlY2ai81YmZaOWhwMGRsSnRRcVhVKzlG?=
 =?utf-8?B?bkVUWFREc1FNb0NTdjFlZVhLdXZ0SXZOS3VuSEZRWmkwNVRHVEZQQytKMnVp?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tJs84Oj2iS4rsTfrQr/bEVR/f2QkBmOUP3fIkoZlKA1XBql9CTJPKPVFjqEmCcqNui4eyfuRgRQSJRDDSQvkY5w0Bh55OPMCONicwnAheergkQ7Q0B87rmcyVVQy3zqXlSlr6S5F0mgQnsuYKhZs05K0qZGLtbIJwADBT75NwoE8Ryq+WMcnproFdXf9d3wsbwz2+DtGR/c0tcgQSp0InoG3GyvPqh6AJ+uHnXP8knBLHeeH93ZD4+9TtCYoY5pE4/QS5pWYt+oddUJJFsRylUyaDPosJC7IZl6YlecRrwWJN5lw5Kk5Z4ZiITRFasuXfmKlThfK8xks9OsevBsXtdxGi0EqRc7xUl8Vtg0jxWWmoES771ie6EasWOazkA6bqHnAh9mNU3+kwGT+nSJR+GBPY7+zlBcGgoy8KrixoVx/hH8DqEmfVqZ3KuGSIz4vd2BT4tyX6rcmuwMaDqohlhHWSUKuFeTgmMKoc5inYrJ26YsS42vjHc/ale5zZsffc0vq/SZErKh3m8LWVnuhxr/MobBRxr/fOo+ViF2/9Qcpj0/eo9oSoF6XO+Z4/Q2JJWIuaSXM2kY8c6gqJHQN5IZI1IIVVcgRmdUPy1QIiIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39566c66-422d-4a3e-61c8-08de2090b419
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:38:20.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itxx4TdFFS6kFLz7fXD9VPZr8VWwnpBEtWYlABk4K7MWwBzl7LTrCtp153GG3PWzmEoZz31zqoay85Y0us/CZTPdKXg0WWuIhq75j8Tj3+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0NiBTYWx0ZWRfX+4Dy3OiQKyfL
 Arw0AUM0j62nVnK+cFKAN7nH+5UfzrdpRkv1a5c+IiJ9UO7lkbfBZV+TqQR6OJcr8AJmVvDr087
 H54keqzSZMrWbQ327KidPp+7xLoXwBI32GJJ5Q42WOrOayGv8xFs5gguBP5ziCAg/SHcUvCa5m8
 RVLXQUOHhfx4togJTK3LsE2EPLEmNEXmNhQ6/2nsM8D27TimoE5BroiTCsisAIdMMxL7MeVYwNV
 QgTjfYywhYX83r1pCF3p3wwj+CDhvm1We2NJC4m1uiJKlPBJ7kfQrtn9oWvF1TynEIiU61ZxaF2
 sy8CCxjnnnRRqGsZ4bWDbuOLuYVw/dpFrgKtMIabFVrlJqts+eXswarzbnhRDrQthb/y5aq2yUp
 wKTW/PuVF4i7AFBwLcPbJU0sKDCM8gJoMtWdUZQVlXIYiWjRW4Y=
X-Authority-Analysis: v=2.4 cv=LIJrgZW9 c=1 sm=1 tr=0 ts=69123f3c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=fEv0p7E8uM8H73ZNHdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12100
X-Proofpoint-ORIG-GUID: n0smUxLRYHRYmSi2fBPlyEuiNDNet2Ad
X-Proofpoint-GUID: n0smUxLRYHRYmSi2fBPlyEuiNDNet2Ad

On Sun, Nov 09, 2025 at 08:49:02PM +0800, Kairui Song wrote:
> On Sun, Nov 9, 2025 at 2:16 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > In cases where we can simply utilise the fact that softleaf_from_pte()
> > treats present entries as if they were none entries and thus eliminate
> > spurious uses of is_swap_pte(), do so.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/internal.h   |  7 +++----
> >  mm/madvise.c    |  8 +++-----
> >  mm/swap_state.c | 12 ++++++------
> >  mm/swapfile.c   |  9 ++++-----
> >  4 files changed, 16 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 9465129367a4..f0c7461bb02c 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -15,7 +15,7 @@
> >  #include <linux/pagewalk.h>
> >  #include <linux/rmap.h>
> >  #include <linux/swap.h>
> > -#include <linux/swapops.h>
> > +#include <linux/leafops.h>
> >  #include <linux/swap_cgroup.h>
> >  #include <linux/tracepoint-defs.h>
> >
> > @@ -380,13 +380,12 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
> >  {
> >         pte_t expected_pte = pte_next_swp_offset(pte);
> >         const pte_t *end_ptep = start_ptep + max_nr;
> > -       swp_entry_t entry = pte_to_swp_entry(pte);
> > +       const softleaf_t entry = softleaf_from_pte(pte);
> >         pte_t *ptep = start_ptep + 1;
> >         unsigned short cgroup_id;
> >
> >         VM_WARN_ON(max_nr < 1);
> > -       VM_WARN_ON(!is_swap_pte(pte));
> > -       VM_WARN_ON(non_swap_entry(entry));
> > +       VM_WARN_ON(!softleaf_is_swap(entry));
> >
> >         cgroup_id = lookup_swap_cgroup_id(entry);
> >         while (ptep < end_ptep) {
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 2d5ad3cb37bb..58d82495b6c6 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -195,7 +195,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
> >
> >         for (addr = start; addr < end; addr += PAGE_SIZE) {
> >                 pte_t pte;
> > -               swp_entry_t entry;
> > +               softleaf_t entry;
> >                 struct folio *folio;
> >
> >                 if (!ptep++) {
> > @@ -205,10 +205,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
> >                 }
> >
> >                 pte = ptep_get(ptep);
> > -               if (!is_swap_pte(pte))
> > -                       continue;
> > -               entry = pte_to_swp_entry(pte);
> > -               if (unlikely(non_swap_entry(entry)))
> > +               entry = softleaf_from_pte(pte);
> > +               if (unlikely(!softleaf_is_swap(entry)))
> >                         continue;
> >
> >                 pte_unmap_unlock(ptep, ptl);
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index d20d238109f9..8881a79f200c 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -12,7 +12,7 @@
> >  #include <linux/kernel_stat.h>
> >  #include <linux/mempolicy.h>
> >  #include <linux/swap.h>
> > -#include <linux/swapops.h>
> > +#include <linux/leafops.h>
> >  #include <linux/init.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/pagevec.h>
> > @@ -732,7 +732,6 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
> >         pte_t *pte = NULL, pentry;
> >         int win;
> >         unsigned long start, end, addr;
> > -       swp_entry_t entry;
> >         pgoff_t ilx;
> >         bool page_allocated;
> >
> > @@ -744,16 +743,17 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
> >
> >         blk_start_plug(&plug);
> >         for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
> > +               softleaf_t entry;
> > +
> >                 if (!pte++) {
> >                         pte = pte_offset_map(vmf->pmd, addr);
> >                         if (!pte)
> >                                 break;
> >                 }
> >                 pentry = ptep_get_lockless(pte);
> > -               if (!is_swap_pte(pentry))
> > -                       continue;
> > -               entry = pte_to_swp_entry(pentry);
> > -               if (unlikely(non_swap_entry(entry)))
> > +               entry = softleaf_from_pte(pentry);
> > +
> > +               if (!softleaf_is_swap(entry))
>
> Hi Lorenzo,
>
> This part isn't right, is_swap_pte excludes present PTE and non PTE,
> but softleaf_from_pte returns a invalid swap entry from a non PTE.
>
> This may lead to a kernel panic as the invalid swap value will be
> 0x3ffffffffffff on x86_64 (pte_to_swp_entry(0)), the offset value will
> cause out of border access.

Hmm,

static inline softleaf_t softleaf_from_pte(pte_t pte)
{
	softleaf_t arch_entry;

	if (pte_present(pte))
		return softleaf_mk_none();

	pte = pte_swp_clear_flags(pte);
              ^
	      |
For (0) value stays the same.

	arch_entry = __pte_to_swp_entry(pte);
              ^
              |
#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })

Just grabs the avlue.

	/* Temporary until swp_entry_t eliminated. */
	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
                               ^
                               |
#define __swp_type(x) ((x).val >> (64 - SWP_TYPE_BITS))

This will be 0 shifted so 0.

#define __swp_offset(x) (~(x).val << SWP_TYPE_BITS >> SWP_OFFSET_SHIFT)

This however will be a strange value, so this is a point I overlooked.

Presumably this is the 0x3fff...f value you're referring to.

And this has a knock-on effect for softleaf_is_none()... damn.


}

>
> We might need something like this on top of patch 2:
>
> diff --git a/include/linux/leafops.h b/include/linux/leafops.h
> index 1376589d94b0..49de62f96835 100644
> --- a/include/linux/leafops.h
> +++ b/include/linux/leafops.h
> @@ -54,7 +54,7 @@ static inline softleaf_t softleaf_mk_none(void)
>   */
>  static inline softleaf_t softleaf_from_pte(pte_t pte)
>  {
> -       if (pte_present(pte))
> +       if (pte_present(pte) || pte_none(pte))

I was hoping we could avoid this, but in practice on a modern CPU given we're
checking a value in a register against a bit/being empty this should be no
issue.

Will update, also softleaf_from_pmd().

>                 return softleaf_mk_none();
>
>         /* Temporary until swp_entry_t eliminated. */

Thanks, Lorenzo

