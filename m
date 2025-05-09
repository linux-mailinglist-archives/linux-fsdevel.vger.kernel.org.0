Return-Path: <linux-fsdevel+bounces-48574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B883AB114E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4CC1BA66DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70C28F521;
	Fri,  9 May 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owSqZU7d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GY7xXAA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1821A434;
	Fri,  9 May 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788265; cv=fail; b=Bb5+uUFmhw/pvBB0CuoK5cIbCW+mEoWSOCcVj0HKVktRUf0vQ7dm6JYmkn+JhtjHpSSdcq89pnylhxbWoGlHFFjgkZxe0OE7kiJYi33cMKnSd87dn1nSo2jxSyG/yp7eGFCUsP4PGAlLLq9l4uDEEhxguO3Z4fSv5S436/xBQic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788265; c=relaxed/simple;
	bh=oL49kg/IYL7CAIkmZoJOx5FA6Cvdf6gyUnPSWbsrmxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVCrv+dO4NtbwwvdzfKeQ1S1BB4tGDR8iJVVyPJSjlJHf+BEcaNtvsCGOa0KQMi1oSXmi3Gb7+mMecOoVC1JqTfiPJQ+IgICfftE0Z5pauAhWggxKUTP8qUfrl78h8R//5milSUejHWp1KqPc6ra/KX1cC4Pju4kTtNkiUInaMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=owSqZU7d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GY7xXAA9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5499NFUR005947;
	Fri, 9 May 2025 10:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UzyIDYtnKlzNl/J305
	nvbwfESppXoM4ERGqCZBZbCLA=; b=owSqZU7d26aN9goqd++2C0FFClLG/jFdAa
	idAJXm1G77Ygx/6N7eMXFfeghsBYtefqj0E0EdxsWBIrD9z85/qtls1cwsblHGE2
	icgSyH6VqHrfjDshi3kVoU+EUArTEz+CLuSaLQgOIeD0TKOQ7NQrSXOtIv7pmxWt
	aqPTpoC6uooDA8tUA9ltOeTiInxzBJKccSY+blphJ8LA4u6mLCyEfQE5I0b48plB
	FSOYiU3A1IQyg8oQTWa/E6tDXSHFBKc3NePT/72Ww19AZ/z2UDDlh/L16Xghhmvn
	0LjXjtlHg7R/+Xkc94mu9PezzbjwEDGnuMEnZULhrvyNlVKbYkOA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hf0yg5r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:57:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5498djYb037610;
	Fri, 9 May 2025 10:57:25 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012053.outbound.protection.outlook.com [40.93.20.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kckqhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTLHDn9Ey2CuLUgB/D0yycwBJeHI4+wDzFW1ZWFIqFUvkiC2t0Yv8os6nhf/OCejW7ST+tifv1UL64rU0AC6FG6LkS+T8dwLuuXUl8+ObmY3xIO838/7OHDeDv3UeO/+QAXTQZsxFKWrAmPkBjyE/2OMSmY2Ry48gYabHPREDjNLAtG7IiXDcK47MeF3U5BpDPak7+5YOmf8hoSNzWDn5J/eUiX97a+1jK9/s0A9yKhFsbrIb21ZXg1u329JaeifKiKUmtMKImzBP3c7F8kKlR7q/vy/ZJwQgbUHiB9MexvXRBt3vF4PpC9ucx6bnSBOUUhOfSHcVm7EK4JTTGjbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzyIDYtnKlzNl/J305nvbwfESppXoM4ERGqCZBZbCLA=;
 b=HF9p6/56XtyA0v6znzvbH4aFAtJl0XsCSAuSsPHBrhoUuPJjxdT4Y5J9SpWN+3ZPZFZQX+E+173c/bmpAd3v2U/b739lfAh3zjbNggX4RqEQw4xiA7FQ1lNZeD2FZlT69aGQbA2g5mb+3Ig0Hcjwi2ZMx9vicr2OzhQ/SWPqfpp2UMxHkgvDhCYMPAzR/7hsZRWiA6rtj0esMViByCy1cU47G29HFMbKxCBoEAGECj02feDCF+y4nEeDG5UxxBehEz8nToEctb99neIJUGvRijJoBrYPKeZhRQcaCIt8PaAleX73w2tcJj5JMDx/mMWdMSDPntkQ9MIuyKeg2HfZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzyIDYtnKlzNl/J305nvbwfESppXoM4ERGqCZBZbCLA=;
 b=GY7xXAA9Y0kzPzMpHr25QXi5gdmFu+zJyoxhftA+r2x7bL0YFcymHbLBzzYymHjTYs8kA0gxMCimoDt2yeIiLA0M/jZjMOSYJui8Q8FkZ5iVbMR7iDjnzaO5Fa/sIHP84iSnN3inp49q7akJuwqAaA2bDgWSz3KKTYJBOMffOE4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB7063.namprd10.prod.outlook.com (2603:10b6:510:289::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 10:57:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 10:57:22 +0000
Date: Fri, 9 May 2025 11:57:17 +0100
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
Subject: Re: [PATCH 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <9b9fd5ce-c303-46c4-acc7-40db1201f70a@lucifer.local>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
 <c958ac6932eb8dd9ddbd2363bc2d242ff244341b.1746615512.git.lorenzo.stoakes@oracle.com>
 <2204037e-f0bd-4059-b32a-d0970d96cea3@redhat.com>
 <9f479d46-cf06-4dfe-ac26-21fce0aafa06@lucifer.local>
 <5a489fa9-b2c0-4a7d-aa0e-5a97381e6b33@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a489fa9-b2c0-4a7d-aa0e-5a97381e6b33@redhat.com>
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a29ee9-e1a2-4f1e-e43e-08dd8ee84686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ryJE3An1DM875Y8XdQ1UJIcGCTE3OEt4x9mZPX82dnlU6g+3m3ekzPvK2O36?=
 =?us-ascii?Q?2DLne9wuAFOjIWquNawRVNEX3aGluzVdpRfTee43G0Kr6Pd76+kdh9pgtLWU?=
 =?us-ascii?Q?Gd9qsJpJGAhY9HTqtyod/yjSlqspAyfNR16GCIcFjNn/9vME4PIxo06ZLWbq?=
 =?us-ascii?Q?VzFaveLy9jBFO+UPVf/Zdqli/u96F3zJ2p587crszCtvrsWeWhrhnNR+zmCE?=
 =?us-ascii?Q?jNmUZ3NrGy1tujGovRO5tSC2ysnXEGfVsZJSTKSHv9nvMqc2WTBp2IPDK6rI?=
 =?us-ascii?Q?SQq70yyTYv/QJcukIb7zXTi3uA7akUXjY/PTJxnjn9Bg5wHAXUCv6HEfes8L?=
 =?us-ascii?Q?/40yjUdlvsgGhgOdaU5/+DrYnXDbH7V+18s6d4l+WDx4/7HUhj0n24onaW+W?=
 =?us-ascii?Q?8l3uYvVXvCBMn0HR1YmISnaB0JLcq6ntEzvHyMI5GsIkBO8Yon3q4NAedaO9?=
 =?us-ascii?Q?FkVPTqulaTaN+YiY54CGrURb4x2RR44tZ+mQ7pWiH2QXx9cVR9lN1lJOCrGD?=
 =?us-ascii?Q?8/6aOn/mKYL2j7D0s+d0+5k27urykx/lIjG+jTKljDNndnG/ENlWvjgnSb7s?=
 =?us-ascii?Q?ed9F3NixKJDuB6eQuhR5MfcJfIxnKIVG5Nw+6qyWFovCuXVbkzcerY59Ki1G?=
 =?us-ascii?Q?XrwzfklpTwyx/C+X8bh1zMZSjCN0XA321aqMkg/aWYygoqxIgEa9dxgNjmZb?=
 =?us-ascii?Q?6Q00iIY9fuur5/e+kDk/3lM06Mfn1IVUt3BpzTrPQTLFgpKADNF1AwDgrFOQ?=
 =?us-ascii?Q?5MHs/ZehkD013TBthoGdiRK2bjNCxefivDcCz+f/4eEA0b1YqD/juMOUnc9b?=
 =?us-ascii?Q?GoazygQMJy6BuHYsnHmIZr1DyEgzxKpIgjIdM6n2eF9aAKYkuqwK7f3EmMJy?=
 =?us-ascii?Q?8i4tejTXn7e3J5CUwVwEpHg7wxajy6zCPDGhpHTfAyoYlJ5USOrAOj4E29K+?=
 =?us-ascii?Q?u4LOxNUmve6d8m4Z0Y+eYTMEPB/D2FtDLW0mAKzJTg5k2nhuLLqDEL/zL29b?=
 =?us-ascii?Q?HRQPFuajdX7ziUiJiNsV0st5vSp+TWL+gJj3OCCM9DUgNwNlD+MowaVeX32Z?=
 =?us-ascii?Q?ZBX7sZdwaZ8X6TLvDedR/Y4hC3CmM2qy9q6P6pvvVcSPUU23hzlHAeAZCV7n?=
 =?us-ascii?Q?O3jGm1rCmJeqXhQgiMBVQ+3SGVjVyB179Ut+jGsny+mgvvT3QkTid9CVGnFI?=
 =?us-ascii?Q?4zShLC+jJw/S9V2U1AcP1M/V3Jf6m6PIf6s95yvXizeNXrT1dbOAOWijx2tO?=
 =?us-ascii?Q?V2oIW4yx1Gi/NPmlOHD7KIY+K6SfGIMW7/sSdfqOjwWqxpalQQqsFAnikqWR?=
 =?us-ascii?Q?dg6Bk+ey64SsXeFoUMqtUOaDH/8bwLIg/Z6IiJ6EBWX98f6f03CurnBsSy96?=
 =?us-ascii?Q?8MBCxFdoLMG8Ezov97ArROT1FIei5WVUjoK8Qha8cY7li6Fk7jBG+qdQtjM6?=
 =?us-ascii?Q?HTZOkLGBW6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UIYHAihF0dMExscLnkD/hxHFBuvX+J644dBmdyaJnuretREywe6f9DwpOxZO?=
 =?us-ascii?Q?wjbtJ0+f9sPjK0Upqkc0fAJAiAWam3ahVgX5BlhFUu0tcIWq9pqsHwEsyI+0?=
 =?us-ascii?Q?Vhsqdi1DJb6qbxFfBZedphRriN3UVSM7v1TUfSY+fyEGgWjUWbVR0BH4wteT?=
 =?us-ascii?Q?pzrHq6j3XHF09m6IYPokyZ2OE3sCTr5MplMjQJFqXR1jd0AkHdmx3tVSgN7H?=
 =?us-ascii?Q?L2igumUcQKs0XuNGrfjuMxdSnQkdrytF02GJ1hqGNvMaT3JjgsEcLwlCWddh?=
 =?us-ascii?Q?SY1hHRs7GNcHbOR30saV8C5BP4V+sEA3FjU9YvbUHZkw5UwMzXzvwzqjoGtt?=
 =?us-ascii?Q?nDSUGD/gc24WeZDzspf8efyrYokEREIkoq+kWgVAmRgQDXe8JH5zVHcCY1kx?=
 =?us-ascii?Q?embwEtRxhDoj2KvBmeguNdZFLeNpBAewuN4Ms3tR4ZdrnQ+7Uf/uSljNHuwK?=
 =?us-ascii?Q?6UQD0Qv16H4H5nfMicvw7Bck/5K+fzaG6HBe4M6gGSXPZ+cI09d/CCXRhjau?=
 =?us-ascii?Q?6f2kmJfgurt0252Z6g4hX3on7rGJEm/dsStycmdosTTvu5LPSv4CXzRp59qY?=
 =?us-ascii?Q?5sE9nqgCuRFbUTK5i6mBNDkPsQh7zTHKB49XBBkN7f+IhkQseagTEc6Nk+q/?=
 =?us-ascii?Q?S6r6DjETV9KaA7iGJuI1n5mmT16ng/68J+QlWWTorvmOibQpktg+gDshcqiL?=
 =?us-ascii?Q?eYAByataKJ10EmCJUzHL2gfnujrL5P6Gf8ZOM9MhyW0FH6CLjyCqCVBWgVbi?=
 =?us-ascii?Q?q4WP+KfpNeNOYXs981oPsMRz/UWJ+CcHXw1eHCsVdCub2rfRfEknAiCVIIp4?=
 =?us-ascii?Q?zXoJZ8/lEOjyT1L8skrkULTUGwYkYwQhEP8xsHoCMS98gnYjnXVVrgH1Za8c?=
 =?us-ascii?Q?DlCVYrFPGAYevq4LxtcXsFdnJigX4NsPbk8Cb5o01hXcFal6PUiOBY79CkxB?=
 =?us-ascii?Q?+teZ/iuhgRj6tD7hT/hwQijBzOV/RtTPZWIN5CKc5/Gz0JjaBvABTo8UGw7d?=
 =?us-ascii?Q?/KpRHCSUEFXsbbw3A41ALl/kKQ1gdZ6MmWqaNTDdL+4D+XEhxbIcWDVqLGlA?=
 =?us-ascii?Q?E4QvZBBUQmfCjhaXDLDc53R21bTwZ1NTUILV3KeCKMUCGftGTU2wLuri4SmK?=
 =?us-ascii?Q?/4HEPHRIunEa8c8KwqZ/p9xntAG77z3qjbTxAIe4G/kYSIXO+ufRrU0XeEuX?=
 =?us-ascii?Q?XFPZDUTdzipVPpr6PhcnkdyWz2U2tHOC6/Yal8OqtW79RuFYMcJqbIw4VYLJ?=
 =?us-ascii?Q?LJcPi3EYabqr8lTf58w+i4FOr/yIBYPaxEcYTCeU6jERYRqBDfT33VjwTio2?=
 =?us-ascii?Q?UXOmFN8chRV0j8kh8IWcXsdk6KAbBgSHa5EcMqbOHlZUQhy8igQXTl5tjQwW?=
 =?us-ascii?Q?SDoaaQyH46j6cmrplOuER8XYgY989ZftMu9afsTY4MlyhureruuAF48HvXPW?=
 =?us-ascii?Q?RErGt9NUjrohi+/z8QSzd3OPDFTh+cOxDO2i9FHsnqbwO0vuIWxTdGiu3l1v?=
 =?us-ascii?Q?PAGEU25+pVDy1eUe9lIWEpNnPjxSElmfW8GXl9PqqGrzVKhHsjw/R6d9pS+Y?=
 =?us-ascii?Q?1qqW/lY7WbA1YUyzRlEVQxLagYfxvReG8my3xXAuddnlVxDcdOk+NuRErZMM?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z2nEWZ4CnleKdAY2cQ0/YOoCjn+Lk+hHgkVxB3zT12RIAhjAqiWgDRCPr4OdcEabBjQrcZCckbr4Ylb7HmO+Rd1HTcBxv3g4jDMIlabrW/TQkluK5lsHOqhs+wwILm2QYH5PuOV9QMMMojetoBx1h7a2Sb7zNjBKtorFWdXaEYIIFpFzdel2iclQx0c7NMXBHqmq27OyM0tnlzubFDfvWm2JaGOD8yVcE/bMF9VWI/unDCZAj0iMf8VN9GRs4EPNAPJiUHCgKonawnnfXIeVgcTJNSvjm8DQ5hYcmbX4ofArthhbUa5wRNwLT9EWA6MCZl0H890i6Trur1gafze8eyJAngHs/2bDpGqiWzH18izeT5SsErrM+izhbu/Os0C4oVuAf0dQixRyLLlm6yEEXkrvyEonFbZD9DocXf00voli875xaTBB9fw8Tsk+l2S7Xt3UVRAykOY3rvNA3iZ5Mhs8CxUNJ3cP88SynHh+lQW41qJkCeErtel0OFh34e4l0NzZJ+cRHqaWOVvzBNDvpPYTzbPD04JAL/rYoegeUZAUioqqtctFDCQrfFX55X6/VwFBYbpKGx8AGFO67/om+n3em1lWyAk19qz9VU7I/DA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a29ee9-e1a2-4f1e-e43e-08dd8ee84686
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:57:22.4023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSPWGgnwBnRMD5yauenps5sF2Lh7Vsy9ppn9R5QRbwGu89Di9fNqrFlxuZ+dWWuHTfV3LFSxrTiiDxIJm/+Ynv7HwZMHavk6dUONNSFsF04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNiBTYWx0ZWRfXxM3tVhOUlzbu MYLOZQoMl0iDe2m5J2is73553BAO2hUO6Ts889PfkoMzMw8Vrsdrbp7D8aC83gl/DtWVgcuXQI8 GD6v2MMB3YlQtBEt8Dw4ZOppB3GCgi/I+eMIjnsXdASiR4gaoNL8cVGYbFLcnGsLxmYPyt+vN1q
 2CZiKtb1p7VU7bSrA1I76g7PICuCfbKS4yCTJagk6FG8TZM9TxOcgIrtLZXHQUQ2hn3jxf31XHK w7Pa4DHl1xrngXra8x5m/982uZqc6Hx4458+WXMSGd+m32n46i782PZVFZtdq2A6Vmnhr+7v8YO EYG6hT7VEfDfedMWE9azwcSgn8w//bQAUo6WJuhtsFaNi7k7RfamlX+Ip+yE0vF9HNRSreNLF62
 sjBDAn34nWbuCb4oATKxS+j6fCnZ//7u5Ny0exHGnCMEy525Due9SEuBrFmvHEZxGVus8Qnw
X-Proofpoint-GUID: q2OLwJdIqZfmckJaZF8uyz5X-k7DrsEj
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=681ddf96 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=OJbrH6SLPO6WeisfeGcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: q2OLwJdIqZfmckJaZF8uyz5X-k7DrsEj

On Fri, May 09, 2025 at 12:51:14PM +0200, David Hildenbrand wrote:
>
> > > > +
> > > > +static inline int __call_mmap_prepare(struct file *file,
> > > > +		struct vm_area_desc *desc)
> > > > +{
> > > > +	return file->f_op->mmap_prepare(desc);
> > > > +}
> > >
> > > Hm, is there a way avoid a copy of the exact same code from fs.h, and
> > > essentially test the implementation in fs.h (-> more coverage by using less
> > > duplciated stubs?).
> >
> > Not really, this kind of copying is sadly part of it because we're
> > intentionally isolating vma.c from everything else, and if we try to bring
> > in other headers they import yet others and etc. etc. it becomes a
> > combinatorial explosion potentially.
>
> I guess what would work is inlining __call_mmap_prepare() -- again, rather
> simple wrapper ... and having file_has_valid_mmap_hooks() + call_mmap()
> reside in vma.c. Hm.
>
> As an alternative, we'd really need some separate header that does not allow
> for any other includes, and is essentially only included in the other header
> files.
>
> Duplicating functions in such a way that they can easily go out of sync and
> are not getting tested is really suboptimal. :(

This is a problem that already exists, if minimised. Perfect is the enemy of
good - if we had make these tests existence depend on being able to isolate
_everything_ they'd never happen :)

But I will definitely try to improve the situation, as I couldn't agree more
about de-syncing and it's a concern I share with you.

I think we have a bit of a mess of header files anyway like this, random helpers
put in random places etc.

It doesn't help that a random driver/shm reference call_mmap()...

Anyway, this is somehwat out of scope for this series, as we already have a
number of instances like this and this is just symptomatic of an existing
problem rather than introducing it.

I think one thing to do might be to have a separate header which is explicitly
for functions like these to at least absolutely highlight this case.

The VMA tests need restructuring anyway, so it can be part of a bigger project
to do some work cleaning up there.

todo++; :>)

>
> --
> Cheers,
>
> David / dhildenb
>

