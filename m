Return-Path: <linux-fsdevel+bounces-54973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62FDB0608F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911797B84F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809382877E4;
	Tue, 15 Jul 2025 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CLkJIPry";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KymK2j19"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6438E202961;
	Tue, 15 Jul 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588359; cv=fail; b=OaWi4qGnkPYiGaYvjM/VDRH0fCsodO9fbvck6avojrVeUgrzebaMV51RR1Ht2fhBniihIlXuX+2a5IUrh/XHHVqCBQtKXG6AbSFndx5dINK+I5CtNFRrFO3dlShfXWEr9cnfQ3Hp9vs+TW9gvHHJrmU13pjWFp34UO5RPq3ABUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588359; c=relaxed/simple;
	bh=XcvgADXyh3ZOP8//tKzfxO1gYpldBLjiMyRYnnGvaC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bkZ66oTk3H1gXxnwErp4IjP1u54KaudGXuIymCQzcYS2IwscKAHztPgAHTHc0Ke+a3FcJiNM5uMMQfZpSo00PWEsjExHP65Bdvn+zt75ElOuW2w7f1mGAbgwIJQ5l0lHtEahgq0Da9DotmLvkJc3eN2IDsB6lptzGjxDGBZcJec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CLkJIPry; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KymK2j19; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZXnJ015351;
	Tue, 15 Jul 2025 14:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XcvgADXyh3ZOP8//tK
	zfxO1gYpldBLjiMyRYnnGvaC4=; b=CLkJIPryOSqqgNUFBIdY5mtB3FTEnzAfO2
	9mUxZvvaErDgoZn9wD4JwCYLOr8pWJY9EbyX93FwSwjjTXM/aANN6oVExZ/MwNm3
	y732pnjzfbrHt7r1R02rVFsLq0/vvrmytQRjdzMhRBz5bi0d84ow/CdKWCPqjijT
	Ms+edf3zX0wWez/LAmzOmivYPtLsxtRaeEGYIFbX8oIuygVW2SqYVYdYWqifQSHP
	wThSx4DnT4fdDRmjvrZJE56xK06dLs6TMyxheA7bHToQ0ntiu1j7j3zGIzfBuk8r
	Z8jw8F5w+tUVF+uf77y6MRdjvisGaZysi5A+JLmwYLEdWYYSrJoA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1axqw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:05:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FD2ldi029618;
	Tue, 15 Jul 2025 14:05:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59rnqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U++bEM+/NU+Moige8xW+JHxaj12TnHyV3CkaAoTaO6DmbJvTGS3r/sz8X6lE/VOc0Yzt3k1LJq03FhgtpAT47dp2QL+8ok7I7GG63sKaGEn25S+0WASYwESL6PQIQZ+XaEHUlZyt8azdJLU7RRg00xPbO3m6BqCJLr7JLzjZ5E5g9W3rgAPIEi3pCdW+ODvEciz1AFI3oWdYl8JCH0k/AJPFmUpNllZFyChlt1fWxmi5y8c6J66LZMzvDGemj9xUCk+lkRbZFZ8OtOdDPjk5YabSLGekh1ehj9qX6SgT9r7moFrbR9EMwa04bElsv82egm/X6ckpXntGGDrLqiXrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcvgADXyh3ZOP8//tKzfxO1gYpldBLjiMyRYnnGvaC4=;
 b=Oad5SgLO/79PBzmaTKoZIyQax8iP5JZNVLyXDf9LQ4CvCJSPICYqxQ44W/Kcm3vxV28puDTY11qzPqzoH6GosMlkK02VRyDWnAXZGh0aV8ryQuO40Bn7Km3r0r9EIl2EK/0d/p0SBGdGtq/GOpLCy9wQWB1zo13eg/bN7DpNLWI4/TKg1W5v23bftSwDgFqLv+yw3xNEeYO2FKB3jw8yNb28MuUPyEzmljCPaUimbSU8Ctfk7V3rIE5RxC/bIGAcOWw9uX86sIAuzKrh+PT7At61Vo4dOr41b3AISpK2yU1HqFC8hg8SqFA+70rexFH/CfYYj/IPZZrf1DfyzxAVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcvgADXyh3ZOP8//tKzfxO1gYpldBLjiMyRYnnGvaC4=;
 b=KymK2j197G2kEwTx71TsthYwvH271eLeO551RXADDl8tZRuLdDCWhJB//lsMOHOuVuZP5aUHczRV69s0E0MlqmIN8HVOZSnA2B3Ib+xk4xwSDnReGrf702w1Svd4L1fRh6o74hAmNguZO6Wo6IaxruoGs00k05cCHM6Z0DFFflQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 15 Jul
 2025 14:04:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 14:04:56 +0000
Date: Tue, 15 Jul 2025 15:04:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
Message-ID: <9559c488-7a74-4c17-9e1a-b4d5273a40c6@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707142319.319642-1-kernel@pankajraghav.com>
X-ClientProxiedBy: LO6P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1ed269-5723-4861-806c-08ddc3a8944f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r4pik5FEi4bqRUnzqEVhUdbq+ql9IiodmQsHLDpNsWurHs/V/M2UYUnIYpKC?=
 =?us-ascii?Q?wnO4wW4m4sNM6OMkAmkb53NWxfhV+PIKwQ+DnDYFEd/01c24SAm60ALoKYcq?=
 =?us-ascii?Q?cpJbJ0IQ/FZeSivsbGDeN35LIBko2CIi28HxCcOsaPUZ/TLIPiTe369pPEyi?=
 =?us-ascii?Q?xc7Lcw5n7H3S7StRvZqGnTmHuOuYfkJ5qa4SR953hBFZHrHt4o2pvbQBFP73?=
 =?us-ascii?Q?TveBagNlCz5BGTpMZ4CzZoDJzzAJpKny00j+qRe+Gr/MOhHlfJUpS28HQkml?=
 =?us-ascii?Q?Drq29bBS9B972p/u2pwSnfKGJDh4I5NBH8R2aiPWE0+W7j4+SBuP8BVwew5y?=
 =?us-ascii?Q?ppBIEZgxrygGvCr3bLjy/BlwvllVUkwz+0NNfmP+fifb5e70NEFMn0sSA+pd?=
 =?us-ascii?Q?630P3Eenhk5Xk8+uGxnaQUbtyOO5XjB/YMXnm95ci7PtfcNZ70wU/ex4CG3s?=
 =?us-ascii?Q?GVnyF9/dnS13Ga1ZR7KxuPoNq7IQyYI+R3djab7Cqk5i1NnvrPPa48KRBrWq?=
 =?us-ascii?Q?hU6uxPXCuG1+ubrACR7ee950yy6YMvnhjHEFb94DpJ0pZZ/Bq5g4Yht0NAgB?=
 =?us-ascii?Q?D42GTu9OMFlKpBk0phz+4E91MHUyLruMKob8YR8BG6XE5mn7XEiRPU22rwR9?=
 =?us-ascii?Q?XxkYicCzo88CXrYvBXK3a7p7i6jktnwmKRffvS5WLB0/DxSpnMgIPwzNZxwe?=
 =?us-ascii?Q?cGyXseDTByJtkdYj9+c4mp5vDjUMBOV2o1Pc7KK7MC3xotRXsr33Edtj4ru3?=
 =?us-ascii?Q?7Q5HhtyHMhhGCOIb7qFK7WBc9b+ttEoMEmmcgqTV8gp8NIQtmvbDX2M4ipCp?=
 =?us-ascii?Q?wQ6N/D0cZB4rpNFdLs8dbOm72MA1wWe8QBnVeh1MIo9RVVaxK9fDPw8LHev/?=
 =?us-ascii?Q?65OIdXVcRk4872RhyeNL/jY6F5n/SZUrmGacXIxCVII118yMeOnodBTgZeYB?=
 =?us-ascii?Q?j+YNKu64PLflRmbkyN8IvHwjIZFOIW1ZmuDm2TYjqNQSPxHmidMcB5dCL6k9?=
 =?us-ascii?Q?DCIC3MNDGqtFDnJwysu9LSuLAPmGPgUizIXXdZP2h9WVivDrGxXgQqR4s8JO?=
 =?us-ascii?Q?zNX2mjF0/Gi9AD13ygcRnAUdWdmMNZeUvsExzfIYznYW4vNKueadiH2sxGqh?=
 =?us-ascii?Q?ggNc5siA1YgnaLwY4VuZ5BowRAHXqRQvRYBPsCVPH9tAV5jNSSecPHOjXC5X?=
 =?us-ascii?Q?MDm2GsKlUPumu0+WBD0WOj4VhRdjvNw14gljGtQOwQXsQLy/K6iHcJuacyiN?=
 =?us-ascii?Q?jWKQv3upVNABlVR8Tpas7Ok1O+9kQGnbB/8+Jm65opI5M4fY/gMJd6GpYFhj?=
 =?us-ascii?Q?jkij+36mJ2bO5fBsC2wkfVRY6AVkIiWRSk3iNT6NVTAZsW2oyg9UDzX4z2yK?=
 =?us-ascii?Q?UZeNDSIaXiPoF0R8+YQkEUOfYBdd6BPvGH5GfwgAm/owjiy6i5M6hQkw9nLi?=
 =?us-ascii?Q?ZEGm/6W+ZpM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRqVDdulss1Y2/nF3GtrMCCQ9wWujdCXAtFMqAA4nSdJgkLYOdR/ICzrxU9B?=
 =?us-ascii?Q?KYI5sl0lQMSnHNzvxQmqGdLYXAYZB83d7i1cPXhj8/YLwL+zo5EVw7G8gltY?=
 =?us-ascii?Q?dvh8CODfWL+bqBh5/lL/Et9O62J2iJs4gLZ618jSQETYSP97nRpEVdVH0bPZ?=
 =?us-ascii?Q?KvKSL7ArgRQ7vtCwXgBcRFW9BG1d2pjZQ55OJsX07gaVvTACWWGPywz9hVXg?=
 =?us-ascii?Q?+GYtMdQgfj329Ik5BOoRzuK1Dvkbv0l9FWy6xLHUrAJq0H1GwFAosTynYr2g?=
 =?us-ascii?Q?M7sAdpNS+O12dhCojhkxyY3wGf7S+ameWhssXsvM8D1uJxgykYCLv3ZSjemy?=
 =?us-ascii?Q?tvVIvpZ0+k+l+vvy5VtS3WpBHDheM22aysR6fGPGcpTcVkO+2K/AW41u5KGY?=
 =?us-ascii?Q?+WsmE0T73e/+KJVECcXQpQhgYsaiKEPR64Ob5YUkAOdlZcumS5nSs+4xeeJu?=
 =?us-ascii?Q?rQT0zS12UBGcm4yS3I9nxuGLg1gsx6KjogelUuK6pJzBN0pzZkyIEKzgfIfR?=
 =?us-ascii?Q?ft4FjmRIBrP3FbwJbLIzu8rf1uGCU8SBgUL/DLYSQUAa0dUeoVwtTpP1eLfn?=
 =?us-ascii?Q?DSIt0qCcnsvnkvmqjObprCq66GJeEacJuACm4Df6YoytKJYbN62j51BNsZWJ?=
 =?us-ascii?Q?OfVQSCcBEGVJDHu10TpAbBdrhwkW036bnNN5/xrsi8guj/weW0846DR913j5?=
 =?us-ascii?Q?DrPOM5IHECVtJ81wZWl/R1FDbjXpog3AfQKH4UV1MEDLI4mJAz55L2utQ7Kb?=
 =?us-ascii?Q?duC7toHMJ1eZ3Vc/BAyDk8B9+I0EvwjHlo7+Wn59tihp2VlKWdDKj4bieYT3?=
 =?us-ascii?Q?jKzp++5lH1IKLJj1az8UILxrxpUygBmLnEUqA+8266bSbZ0LjWD6lrRbWz3l?=
 =?us-ascii?Q?oU29W1iDnuCd+OEDM7bTdGW6zIi7fF1vfePwpocrCuOCG27atSQ1jlA3g7+0?=
 =?us-ascii?Q?twOoTiSfqXH6LZnotJ9oxMK71A6D4qqaJkehvCrbU/QgJZSY3vNAhg6tAePs?=
 =?us-ascii?Q?bkHkuNpB21hq1R7CrwgnK6UP+RApKGLwFlHdVWvaoTFj0RtSCLDt0AMgxEH2?=
 =?us-ascii?Q?n2klPlWT097qVc8jovLBJAEqNGr6cyhUKGW+jjk8JOUA0eQo1tLdXG2vfxnd?=
 =?us-ascii?Q?9CaQiF90fEAuRecw2gssiVw5qdolimCKR6uOIWXiu55UtLdetFLtqO3qv0qD?=
 =?us-ascii?Q?QfEtRy2MVlb7NVNmerjnspW2+t8MypxF/1WpcyqD5Y94OYIdt0yL+OD5ycgY?=
 =?us-ascii?Q?tApt6lyyS104EdqQnAtHmKQHA8rw1MXhsnEu/o3/5hX3sReU/HwMIb12RckP?=
 =?us-ascii?Q?tKm5gv+iveLM8H5Wlrf5AHFbJdbCQVrFSP/c3il1qInlcpI2Mjzjxba9it14?=
 =?us-ascii?Q?h4ghs90lvZSQ59HsJ4yvd1drcx41v1eBTT3V2Q52tLOfm02B1NIUN/lzMkFj?=
 =?us-ascii?Q?K1eugLtexC6MamIbdjl6yn4dSPs+IvN24YleFli714fJha939bsYq2ewJQUv?=
 =?us-ascii?Q?c2/p2Mowo6HC0aL5PpBzJ/0qPNSUXdRAd+S2RUG/c/+Ork+/+BbXH2D/sJCm?=
 =?us-ascii?Q?i0j/Q3ovwtWk3Lz6RO/gm4X1c6c75QC/tczBWPXposLmNrzULsMYpp8mX4Wt?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WXOEKQlTpw4UggkfzfYtpjhfDCKvuLTyJi2wVQ3ReKOXDW8Xm2z6o/NXk9GXMyCVe8fNms1x/xnJWoFKNlf3d5qGjh05rcy++IEAln4jI0pFO9qGbAB2ZuLHV7ofNBqpriTK7WEdKQWjTT+WVxZDJnXPz573eRryFaiWWwTB60ylGKnWItiqMYkN5dNdVOtMK4d6rPLPRHT84oThFN8D4y1S0+cv0UHHMVDRVH1EEtSo+RdrWRQfCDT50Xhxvv3/8ReudJOt8vOyHhj40yK+lbmuO9Lxs1Mnsff8ByzKOEsyE49b9M77yzmVDvKEQhVfdgcZDYOt0oaY3x5s+V/UbSiowfoa8FHqu8TzTN/Xmzajrvlx9LLeKM9zYYxZabYWmnbfJT8/Xpyo210W7tfcjxDPLgLdg2jwXapz9+zrfRuYh08atMNzsakxiBNw5nl0LA1WfHCSwhakbSerHPuYGzrhvNfEiuR5FgAqC5wdTLnuGc1rtIFKYJDMFuDRO+0DUQjvz6eQ1epue7IwOTCtfl60rjWiM9ayGwrXk1jvM9vrttmyd7bGBS62bwA1/W/YHV4X1SWbV0MZ8KzpQlctBKZJEDwa5+fMQLmS/HmGkO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1ed269-5723-4861-806c-08ddc3a8944f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:04:56.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hgSildtGO2vGAFXdfwAEPWkgXSFCGiHFuPHR21OXTpJfHRAYjzT2L/I/KspR3TZI75DeibaXk8scpAGk5YhiXP22XCl8PBPhCj7pm+AM5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=835 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyOCBTYWx0ZWRfXx5WTTKMlVUEP L4E1RjXkDuq8U77MWRkIySTbx3Sl30Da3sMQw4P8NjhHHp+xxIMQVyFeKop48yhZS6z7ZcGGTUE XKN0BFZBCd2SIFbSHMDgn/oONgXkVTiPtpUvUrZ/jE95tiA6ePFpqqCkv7S70KGSDiWq9xUgM1O
 mB/HNNObZg9jKYHJf2+KFIhMkWZ2GxUR1rgIST/1p+ai+4wCDXR5hJr1GZr9AOE3Bqed/y2YHRF mZWgpvD7g7mskeMGBTRrZmJ+EwaVUFr2rihwaxFmfCOnM0SJW1P8Q6oOnhMjIrZ8F6eNqX+WJia k/9lqVzWVuOGBA907SUP+ec2PQfvQYCDtBjB78GKMa7uqD8gcfqR/ozjzXVpOULEM0A2mLCvBmb
 Uc2CP/ztpHWLx7VgJZykwNLFmvZiJNRqnhu/SSZwblKSN0IeFhYq4GOpQ3YyqEp+n03AIo57
X-Proofpoint-GUID: 1i0pV50NcaQWmSiSCwNxyp1YWavrPMDQ
X-Proofpoint-ORIG-GUID: 1i0pV50NcaQWmSiSCwNxyp1YWavrPMDQ
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68766016 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=o22vTxkKlqjjKeklEp8A:9 a=CjuIK1q_8ugA:10

Note that this series does not apply to mm-new. Please rebase for the next
respin.

