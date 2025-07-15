Return-Path: <linux-fsdevel+bounces-54942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E742B0582E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310463B1B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DBA2D660E;
	Tue, 15 Jul 2025 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n6PKaREW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VFUy+qRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A18633F;
	Tue, 15 Jul 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576748; cv=fail; b=gThWQjZRG/WJ+9vXb7ASOhYbpIjr9RQu2zyqka7kpppv3IEi36zbgUQs2zxykHvJadNbBi8bgckMu/Rr8OhSQNWs1jhPftMPGYND1FToUzw3fEWUjDvvYL1uqYCrMwVO0JOZPHul0eVHwrEvmEAiPyNJwcE0cfnYzzlQd5mmw4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576748; c=relaxed/simple;
	bh=Ht5KcCotImP6jMkbTU5PCmPA86grwng/maVVRG3l2DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+Z/SLcgSnFEQTIRZL2aQnh8asLwlMQ0k9EVRuobZxHENr7KtOYozzWx2zzBcX0nX9lAKyqlVlpeCePGYW84p2G9Dq/aSr2HNZA0kauSzwrBumdavrlcQdV0J1/TW1k0aVIFOS30svZ0rLTMlQOh+L7hJrPqf4VpPkmhpuwF+4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n6PKaREW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VFUy+qRb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9YrAQ030072;
	Tue, 15 Jul 2025 10:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ht5KcCotImP6jMkbTU
	5PCmPA86grwng/maVVRG3l2DE=; b=n6PKaREW3kun2j6GCtvKdGJ229hWs3UZC2
	TJRHcV0sHZXSRlQcyM9mAomnqi0RRi7AQKpJGhcal71Ed6EPjUZ0Mg7qAzny8qxw
	9ctIJkKsmZ+E/1RKh7nLLd4LtuSMNoMis4UXTCG2PrhuIE6I4NmawbAHtpPxT/5s
	9I4TA0kM5LBVL97l5+DZ7FvpSeaQuspy240LGuzd/b81jyE4vejpZW3ITxvQQHQA
	gjThXl+EJU5JwmRa4vHHNwo3DklfUKCa+vhdfLCB7Sd6hIHEHwumNET4fRjrP+pS
	lAhbGgbUZinWxxY/63Wu08aZ4Wpbp8GTVQ6soObiuvSFTVEZurgw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0xaxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:51:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F91Ep1029634;
	Tue, 15 Jul 2025 10:51:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59j2h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 10:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAICYwgpNZnYE71rRcC4DCUuLXmnIrEU5IjaRz675u7GH01IfQ6vlN095Pf+tlu+qkOZF2Kwg1tXidpOAURjSzP5oKMewU8fErhTynDsUCeecsktNhCTdVPfrlrhbi6iu6dgd+oxSmCgLV23KfZnpZAaGUhrqyEv5orUfckfIbWI4BreCyWLFCn+ITGwQT5Qje7aWAXeEHqMLU5Q/CjPXTQT9E+Fjxpc18wlNoHK6KePl3smwfbEQ8THQmY0eVYSxdrI+spkAbW0YAFMWW2wzoDy95kberCN210tsYQrhVIYX9sArTVVGU3ebrpd31BioFYi1KXbgKAyPetfgCLEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht5KcCotImP6jMkbTU5PCmPA86grwng/maVVRG3l2DE=;
 b=AjH+ghi2LagPppQaFggDHP4SlDa/xsVlYjugzRT1bOU2//A3yybTnelZUmKKjmUwQvC/QYhrEJEK0JANcWiYSw5jXb5xibFv3Hs8fwq6c5Xb9c5BnujobV0vLydvxRuBHrkcv8TXVF1Gf9TA2jThOU9EMoibJvvUicMunqWdHQWs5Rs/lt7Upo2lZmnu4eHIUTkexJucu10aMF6BEOb3xqb2DCyDSGWR2iS6aAuGHYvWSPGuV1KLtlu4cgOwWyYlIRmTYzLoeYXK8iNjyF34lKZIU8NCBTWl76n0sA0f6QTDPy43sr2C89y4uHQ4bPRFZUzIpxupbW+YwpbkBV2xGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht5KcCotImP6jMkbTU5PCmPA86grwng/maVVRG3l2DE=;
 b=VFUy+qRbPjS4XdUpFVlLJs/YufMf/1SZam/QQ/vCZcdguYF6whYLJajpXk9HOQY/FwF4FOQ1Nk+HVxNjybedsqdYYRVF9pAdmh1X5GZBd4NVblbtCQtdnEitNFsHU1XQz731ddQEkeuabP0TPp4yl7sAv9u9cbgT0ya4zUjU8c4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4319.namprd10.prod.outlook.com (2603:10b6:208:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 10:51:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 10:51:53 +0000
Date: Tue, 15 Jul 2025 11:51:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand <david@redhat.com>,
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
Message-ID: <5a22a420-61ed-4cec-bae8-759ce867fa93@lucifer.local>
References: <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
 <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
 <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
 <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8d3100-a0dd-4da3-8797-f097e063ca97@lucifer.local>
X-ClientProxiedBy: LO2P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::33) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: ea65151c-cce0-4ab7-86ea-08ddc38d9be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nE6hSNrdjDFJwUTxpsSEn1lUMVyI1ikhzCjD8XpaGwk/qHH/RrSusvpZOy6k?=
 =?us-ascii?Q?FSsWHECpPbMeuWbEco7/s551Rk8eVTt2bBmJM64yEMciQvgMna3vgvYh8Rs1?=
 =?us-ascii?Q?J/75BdYHuHQmTBTXHuJdxSJsz7r0I1+HzZgch4YVT3aZ945QW4cT7Ge2l7g5?=
 =?us-ascii?Q?kz1VOr6Ysd/vuWmPMva8PmiXXxd7o4E+Urkbki0+RBkf4oQRjR/OHRXbxOcf?=
 =?us-ascii?Q?UovK1m/CkDoY43jWGu7mxW/m5CxAroZCN5XQN80vZiUZPD5UwjCRmKO+5DZZ?=
 =?us-ascii?Q?lu2JqcpAcJOLA8K2W3ScsiLf9nNX4FvH1qNz3HKa+96CakKRBN2kTWu5fwvz?=
 =?us-ascii?Q?0aFXpm5RLb+gOpkzWtWz/UJVpH0PABVn5o6BB1lwHZ8BMSK5XS3hxw0kzz62?=
 =?us-ascii?Q?3/vZ49x+9PNW+hszpHuvxLm7BLoLf/O1RmguLFjbboza+IYT9S7t3nVvE+b7?=
 =?us-ascii?Q?MgJdQO6It+1kWH57HiAE/k/lFrJCAYOoGIKnFWzLxlSz8Ctiowg1SoU/seLj?=
 =?us-ascii?Q?ksXYwqdZ27zr8IcVvYInqvxkiHIMtvvi1H4LsIcEirYSjZxrt9P4///s041Y?=
 =?us-ascii?Q?1+LRQfCzWEd1hSB8+aa6ZpM4175AVa3sJ2iJSsHXbH3gWdnb0dVDty/B7WfK?=
 =?us-ascii?Q?CyYMV8g33tb2NQonpVLtKmoUsI/u7bDFVqO64nHa5GaqlTm2ypa+nl+Uho4B?=
 =?us-ascii?Q?MXCZCnQELq17j2lPkXlxg+fRW/v76V0WvH5DwN7Clokw0mL66rJVzf9xcJ1g?=
 =?us-ascii?Q?lsRRxmDO4gyKBqF1rFMMwn9IGjkbGbuFIvUebr1crkTHYBTdgC7DriY/Hdhn?=
 =?us-ascii?Q?lmNAFaakq3WDKZaFHzDBMLhLyTVMXqJif8KK0APUY5E01pGyVdHbe64t5Z4S?=
 =?us-ascii?Q?Lpqn7TJ2giwcMcMfbQSZmybzBG3g7Flz0N6SPK2VdK9iJJ4no/9TzyxMU8Jp?=
 =?us-ascii?Q?qcKqHut3VhnuGi/3NYHtWQlZbwBbuMWSbatA1EVuOPoe/de/PM1tU2CAjfiv?=
 =?us-ascii?Q?WrcS1OSb6GCsOxBXWDnA4bbD/4WO+Ds0APp9NLPhgK4t0Zg/+GbrIpQrvHBH?=
 =?us-ascii?Q?FD7JoeHykvPinItIMvHDF6C4L6JUYr5yxy1x49jAsLGGDtpECk42hgt5i6YY?=
 =?us-ascii?Q?F7wvrp3CyIB/R8TlJpOZbkiKMN/9QvbRpc75BYnwtFI6vqYvl9ZA0Gw03B3n?=
 =?us-ascii?Q?ZSx2ttwMomAiMwEYg+RSjCg5M/CIIfgqHoxeANnaxo+GcxbOAlDXomMcPkhv?=
 =?us-ascii?Q?tEvtV/t3SsKy638+0jElfc+bnKudwX/olDEltsS4UjGHzPvyZprluvJnkQhC?=
 =?us-ascii?Q?C1ZzM92y0OBrtREh7Bpa/EjBROzg5kHqpxn9e6vXv38pDCOlIMznmHKCaxlw?=
 =?us-ascii?Q?gFIIIQamYbfeDyu4h5uMpJxmupWEPUAf5dDWZt+7qD3+9flSvWF4s5ZNFXif?=
 =?us-ascii?Q?g4Pkecm4aaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MA+JQbdxejm+N9rJ1tjTXYhudUt8gt/27+2aOvt1VMiA4uQ8WhLWDRxMYUMB?=
 =?us-ascii?Q?VfpgxcZN0gpoYKvE/lJn9OBxrUMCJiqaZ4eEHOiA4iUY7wLf/WoASXA4PSDI?=
 =?us-ascii?Q?dJLhWnFXHnbmuOB+9Ob9umSTNJSNZf5c6Zb0lAER4c2qhK8TKtiPy+L0woD1?=
 =?us-ascii?Q?Xhpt/osAaAFqnvjFGPpTR6BFrEZMRcM6qBYfhAWEQdTfTtRIGTar5yIZEGPe?=
 =?us-ascii?Q?YmJ2AnbelXQ/MPnWYnwsCSNfBHCcXlpt0dQky6q7xn4f1nLyNq6RcOMQX/rz?=
 =?us-ascii?Q?0hBNzb9WLDww5L/mLJ8w5djZ+/OaHjuRjiZmP3kS2qh9nrfvoIyWWewA08Dt?=
 =?us-ascii?Q?QZjpiPpgkqTowMWXGOTe0cibXP2TMI+shQlxK/IGHHF1uD6HXJYz/P+rGLsm?=
 =?us-ascii?Q?YgskngIkiFACIxht5FPwAo9wqDN3fYDv5mkc+cGIkteaeHpqu4iAmONWUlMN?=
 =?us-ascii?Q?ey09W2IGmfTMDbEAGGfODGkDNYzkodGRWzhO15wruGvWSigDJMTmNx93CZx9?=
 =?us-ascii?Q?D8tYHo6uAh63+KBD34w/+lukmR6O26b6S3kGviDCjLlGbpg7Lri896c5tOwX?=
 =?us-ascii?Q?C8gO3SA/cWgk3SNBDqGbWF3G1QLbhn25uOUrbrvacNLIItTfFIN0T94xXRCb?=
 =?us-ascii?Q?pNreCwnbTOkGSHYP6HgeLmPCqt+aKv0tFElALB8CVro18/2QdlImD+8CYD1o?=
 =?us-ascii?Q?tkhAa73r7cMdoza8Tvsmj8NWihZ9Mg89hv19GC74BCMA6c6SxaOSYyYSaoIj?=
 =?us-ascii?Q?vB2BU/Ec6Gkl50syQAxptVUfhE/jEj04KriTGsVtti0PLnmGgJbR2ATBIrp3?=
 =?us-ascii?Q?eYLmOkXqUtVctmguxXuOqfl8BdVyr+4TfsyzKJxR9KS4Z6RZIBn1OFk47xHm?=
 =?us-ascii?Q?A482txRMLQygEVlIEjwPVD0G3p/PKL6iTjWrwyKdQMIPOHDIYutIQdmcImoi?=
 =?us-ascii?Q?knJ8necgKj/5HMFgnF/nmlkRT0HSOe3xr31NY2ixL+4oATwRqFAgu2bjzchQ?=
 =?us-ascii?Q?r1ibIjtqkxzb5ouXMWikCZSwkOA5F5pu6XU1P8xTVAmDdCaePMlHv3IDwaI8?=
 =?us-ascii?Q?dYXzuOHmmZb62pmukGwf0PoZDGvrwpGFuAwsZEy7IcOP5FGvLxQx2LQgPOOR?=
 =?us-ascii?Q?wsFQVzIuC4qrMkDwwuDVOTpu+LJjHg0uSbfUzSH3SDkdonZb5+t/xHplxPem?=
 =?us-ascii?Q?4R90PN/CrYMnEO+bAIleebzVmboW9n1wSI31ftuIoetZkhY0ACkny29NwnR6?=
 =?us-ascii?Q?reh3e3G7Jg9UplR4Pil/YJ6TNKZ9Y4cXj2gWOfCl7k53RoA8rLPasWT5cmLA?=
 =?us-ascii?Q?D0uJ1yvik1tCw7OcrRpOJZfl3Dsjj7YT/T7w/ajMvT50pMZa/C/+GdHgNpEG?=
 =?us-ascii?Q?+4iQ6nWqgua6G7r3Bfm58+HM33EL8L4EWCU9KlfkgUULUaSVk3Fe+ewA//gg?=
 =?us-ascii?Q?67jo6M995uyC8UjAag6f/qU2NYIf+B3Vq2GSV4NuAA8eRZF4QYzK9Ki8Saaf?=
 =?us-ascii?Q?+K6RFcojyi+uuixToWWXh53EJGeZEjlMK+RGwsCS8i0YCwyJjKYnKgtkmRf3?=
 =?us-ascii?Q?KJArdMNjj4Nl33rPwua8bs3ykSWeCFQgcWJuA3Zy08v08jsF7vxrHcQcGNpb?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kTt5N+GErCFRmAFh7+KCA8z9k+H6IAO30e9966WNenEcJ/yFD6HhSSSestxqVa7G16m4DJ8CFJ+Bxb4jJqC2iU4qsZBeBnv0roSN+/OjDPW/4Lr7X9DzYbNleAE6cn2gs3SgpGAlzpjeIjJr/jVLB+RbowNNLBSGQqYuoVbdURHduM6CluZsXJpng6nz44YJMZeQjZNRVekGuVlCVbcCEo6aaGMWZH+B9NW/3mVhXcspliifpdFIW7qHIUiJvxUQWh1H4LYsGmTas0g3CxVuOCAtf9kBVl7qC+ombirD4jRIShkLP91yiMbBo5jNR77P/qYP+WyD4/sD2xEy19dVXJvQuMa0uo5uUPOv45P18a4QdATrkk8OfYw6+59f1zJEQp922uOus1SNGEdLmXJdE7QFca5B+okzBED10FPbf004tvskEO6IGzAwZQ7ylIz+fpVGlgmP8lb8QN3OLSq/p+52i2ePe0swIItDaC1uoF0YIAzAOt8HT7DEfLL4t4Wm6Qs4aJgO0Rvou1vqaLcfrW18jxzvSVusNujfgMqEjvcMOBSb0WTITUCU7vIn+EFFtmHT4ld0fMrLxcpEzyTwKXFuMbXSRIfqnEt0QWgGttc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea65151c-cce0-4ab7-86ea-08ddc38d9be8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:51:53.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dvEQgMd2738/45rJ/wRei6IQa839WIolCkjNR4i01PqhO0H6rfHwyBiFu3kPKCyotsak25tobdbctx9JTYeoFhp6DXknC9u2Cj+qy+EM+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=799 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150098
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=687632cc cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=7WFSMVx-WVFThUAiNOcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: S4Z4ybCd-OELKGu1PJ5aPcXYnuBUE3NR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5OSBTYWx0ZWRfXzCQ8w7ND0XDZ HmIx+MH6W22Q7KJbh5FjOWXhFT1WTCZN1kK7GqESpR694Ba5vO7qQRpwX+WcnatYX24qPMLkgbX 285g8nXvidyvK3fU7O5B5rHON0IX9mHh7pgBVMdMqvkw9YKzXpGT557Hy8eQ16EPqohLtkMXaKe
 t1+zF5KLV89zF+CHLIvlKYGaHE+SozklovJnlGypXI5rybj7+duhIUzCDpq0V1iEXEBRa4O/R6r FP+5wxCQwdVBK1lTLCBj7sxWp7ZZKF/vSKNK8jo7CGi/e27rwjJnpwf6N479wEt58wA7nYgZU49 f96qEVqv5O9xJbmYn/Ya/xfEimLWjoD6uNB9evOonMVE2GbVvj+TTIE4uGHNJVqDvWgOlScyta2
 PiymMlqwF1/bg0f7RmjVFgrz40dcncCYiSZU2o1mzvyXVsT9UaLXwty6Kk3dtHG3LOtjY+bq
X-Proofpoint-GUID: S4Z4ybCd-OELKGu1PJ5aPcXYnuBUE3NR

On Tue, Jul 15, 2025 at 11:31:23AM +0100, Lorenzo Stoakes wrote:
> Or we could just sling in a cheeky spinlock

As politely pointed out to me by Vlasta off-list s/spinlock/mutex/ since we
apparently allocate for anon_vma_name :'(.

