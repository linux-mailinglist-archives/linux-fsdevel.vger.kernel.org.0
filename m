Return-Path: <linux-fsdevel+bounces-47921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C3CAA72BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 15:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC44A5337
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FA22E406;
	Fri,  2 May 2025 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K5jyy8oT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MDIRlwIn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8D9443;
	Fri,  2 May 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190821; cv=fail; b=Ym9srsm22rt+CQyvrogio+eiyZaBn0iz/V46LXI0p2h5Enh7T5yIj6CQRCe/wJH3DpM+6UBIdh5TB3BMODwwxCbBfyf/InN+97WOp49Px2qWR/aABEs2vLiU1xy8NC4FNlvebBGCl+4jwz5jLvjcu1VJjn3q7Bg9NVbKraluCd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190821; c=relaxed/simple;
	bh=gqTR5f04lletsdmRY/t0lqPrgDI3pbCmR/qRVHNbzdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t8DoVPWjyyefLx7tQRJ9gtO6/PCtdeYzQegqEhkXFbPJn46u7IOUZjpUFjey0bL0WADYuM1A93GiwAZmRpdW+rbxD1CypwQs27G7DPpl1SO5/Vt5rtJeG01zuTBTbXatK9yhVgbFNcKyaniqy9sZkphRjf5qZzcQqll/13vrMYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K5jyy8oT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MDIRlwIn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WwIU013908;
	Fri, 2 May 2025 12:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9ExB4bqbXlGhwSSmMo
	7yQeNIXfklxtUQqFLLYAhZp68=; b=K5jyy8oTpgT21bHBGCOqs28SPxw/adVRw4
	8jXr9sEQrkt972v5zclddBrfnvknn3+V1D95FJrane+Bglpezoz6I5aoeCDHKFSP
	R6q1K67X+Yxc447R+mj6A7BzRPPMhIzVmCmEHiWe0RMr0uy4fODYTpXwZMXgRHjq
	2hivzmUxurStcRCu1/2+17XR4V28z1Rk1R2heTrJVMfXckT4HcJymLbieXPo0S5y
	sKfaBN3rRIxXeZL1irrMh5pGuOtdPjDr5+TVL9+nBNchp91zw7mWqKxZtoTjf60Q
	7CkF6mluhHU4WuibLoF4tCjPFIEpdUM30yArA2NpnzrRzhhOx88w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utd5vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 12:59:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 542Awqnt035387;
	Fri, 2 May 2025 12:59:55 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdh72q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 12:59:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1mvt5R2g8ZLtk4tjR1ivnFLMNUnefqJVAoX/EH/cr35rpHQGAx5xEC0G0Tj8ZvMC/wzooGKNHstry5brmQ9dRpN27I1o+VNac2aiVbHovLTiNZnv0QYSSd40MYBhoHziuB/wSCYNDA0pOKVOgsStIiYtbDdd8PJcM4XujmjsRL8SMHZv5NV8zzB+HusRLxOtYCFgf+kfKLwXlopGqKW2HFKFD4/bo2wkJqbqwsxbQjkELAY5lItlFwdFa7MhIHt9cx7AVFBUiE13BkFtrn1tyWHYS4qM4Win0qgF5brzkwB3pe6hpA8JCKRFUGoqyicl1sKqpPL5potY9E6nmZC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ExB4bqbXlGhwSSmMo7yQeNIXfklxtUQqFLLYAhZp68=;
 b=UKGboa+EKqYioWKzmFH934XilgT7XVeVHGZ9j2Ggnc6yt+B2Ee1/u8EFce7jOI2RA/59I/v7VbXLZgNmV/Ibyy/GeTIhL5y0JgiLw+RtRvMzyiMLiYbxIS408lTGz9pAVJ/SLtpNbEIosfTMYcE8RHiuLoHoU8yzIbjopEugZeqgpYB+njWdc5xq4Kz9j/A4wcQEdKhj5ZKnK5Rlqe4FdprOIBRCLEMxn/ehdpCo0tRDGuzdGXn35EAUhha6eI5x557JyO1TVgHkwLSN5j2BcgsLgKGt7XuDktg4WAweytrcR7LNGu41o5SlPtA/6emPUxNNW4dPqQkWIandh2GCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ExB4bqbXlGhwSSmMo7yQeNIXfklxtUQqFLLYAhZp68=;
 b=MDIRlwIntzrW+VxmwpZ2tpx7lsKWfK1bGbvBsKkgSE2kMpFpQV4hsHrC4lNGhOXRhnF0MR6UGTj1oTSVwaR7yIYVIBPwzTviTa0u//090k1hQx16vW5Yk/vRhkDjerQRNjoIv50Q7sYrE1/QPBJiF79fC5LsS5R6BoPXGI860sM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6363.namprd10.prod.outlook.com (2603:10b6:806:26d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 12:59:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 12:59:51 +0000
Date: Fri, 2 May 2025 13:59:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2 0/3] eliminate mmap() retry merge, add
 .mmap_prepare hook
Message-ID: <0776ce6e-ed62-4eaa-a71a-a082dafbdb99@lucifer.local>
References: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
 <uevybgodhkny6dihezto4gkfup6n7znaei6q4ehlkksptlptwr@vgm2tzhpidli>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uevybgodhkny6dihezto4gkfup6n7znaei6q4ehlkksptlptwr@vgm2tzhpidli>
X-ClientProxiedBy: LO4P123CA0562.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: dc09151f-6a1c-4069-87eb-08dd89793a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UpwK4JP6C8ADbMfHZXrWUYBM/EoTEPEcikxvf+JKUelHmFGnPgltYR6y3LEw?=
 =?us-ascii?Q?UZkqOO4PD2Yyt/mgeK56Jvp+XQWarnpZaE90pnRRphux096u7f4c3YxzhTRF?=
 =?us-ascii?Q?3Ipzmtmo76/TipXbhp8XEC+1ELg+KTPTExHt1j8HBin+7xPUDCpB85khFq/t?=
 =?us-ascii?Q?spDTJcGJauWXeC8AAaTTZwSR09Uw2Ouf/IeTYpZYhVdhj7xciD4XF7x096/3?=
 =?us-ascii?Q?lnHwmEX25kr+5oviAzoSkgReXAiT8CR/Mmn0O3l6l6V+4Z8tFKzeBhBPgsSC?=
 =?us-ascii?Q?jQLDsiitYp9d4l7jc2IDVmIGiQorJws3LaUxZM1dAbdiveyHnCdNle/lNJyB?=
 =?us-ascii?Q?CWyTC4/wyGsn9q6qH7PR0Na7r63dPysIto9SAs9niFPjXGxDVOGtGg5yMh5N?=
 =?us-ascii?Q?9rbbojFkOgjaddoorO4xuOu76/Jija/B/IZ0ghUzZvQI7bDpNlBe/ypDyKGg?=
 =?us-ascii?Q?Ax2ic5N8yA+bdAnlGVukip2hWDJlUiFRBwWUTDRGKagA5ld/rVRjCbEpv9oN?=
 =?us-ascii?Q?QDSS/b6oPvmYldcQ1bBV5PeH5xAjTH0xbq09/xvPHbv3bHLupxTeKZAAROWe?=
 =?us-ascii?Q?FN0L4NMGreQivGMfDzW1W5vD10P4frRrHx7INFSXq8B5bx2K8BLUQqeyrZS7?=
 =?us-ascii?Q?+M967SoPnWAgtBaSvZAFMT927dfZyisT/C/oKR5uyUGR7PS4G+L7e5gch5DN?=
 =?us-ascii?Q?lCHKcK5CjLe0zre3DqSc9OzfxdNVkQOeBpRoMdpfSeS0sgioPhAyy8vG44ro?=
 =?us-ascii?Q?LlleFXoCK7LfzfBXzvjRg4sRBbjbkkMTi9rGuhBr+Vp7RmzfM9XN2dY8WxUa?=
 =?us-ascii?Q?tGYjUAQ0JEG7ZA91gG/IFaFqTGG72YZUUElOEtea72kwaRSsvkOY7lFAWwcd?=
 =?us-ascii?Q?dEDLhB/Wah9ku9G1lDwBQ1Biv2Ah0vO6J1FPrVJziJjtD+zyTliBnABgST7h?=
 =?us-ascii?Q?IjAJVdD5mP9EoZTZSHZkbDYJuTZb5UJP2AaYCF+le7SbDW2z3kqAalgtOVja?=
 =?us-ascii?Q?ZE99xfdqSxQ6b0q7IO+7b0VvhZoMSo3HXOuc+5CkmFFnlJG4VvFvzRVKCU92?=
 =?us-ascii?Q?JA61S1N3IsfF+lXMQn7keZiN8YII6OFOprKqvWkaR9DQw75ckk27dkvGYt5d?=
 =?us-ascii?Q?b8zANOnB8UbQCMTC4wjHlMcLi4zMyRhPRIzG9K1T/Uf0DGmEE2/UlxDP9asT?=
 =?us-ascii?Q?HDObdbcbsi57VmoM27D5BQaWawmQW1z1DyoNytsT4UORUULloEpOsT4c4Ggb?=
 =?us-ascii?Q?7/fe8qw9XD7ZN9e8kQZGVw/B6MuxCcXelfcHBoQUwxQsFILrK+u7VV80AGlQ?=
 =?us-ascii?Q?MK3zSQc/kXbVXLI1Qb7QBbUI94xCOOHqqorbhE1fxOhxiOZsu593QO+dGtwJ?=
 =?us-ascii?Q?SSiKrF1AGHsR3iQ0pNVPPErkIJjW3ND2cipGtGN/mLYZUu9ssGcAxnQdiVZn?=
 =?us-ascii?Q?9iM5EGkadbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sS+iBuCM+rhQ8WRDe6YNgKtGWBzCgt5m3V7DpVyU7Yw1I8XNhmYKpbgzP8v7?=
 =?us-ascii?Q?dy3QhkAanLKsjXm2pFo4eV9UxTd3JvCIzNHLaTcOnogtXFgOcNKlyfikGnTH?=
 =?us-ascii?Q?nZ5uvm++G/U+hLGaBCMAiSAZEAVQXTlIZOZhlGKAio7+ycpdC1pJAaYsUOnI?=
 =?us-ascii?Q?K3ny7r2jQBupZcWLX6/R6hqxfP6NxsAJfyw+34k2g0hLcaS5Ppk5Tu4UV0oA?=
 =?us-ascii?Q?SAaCG5V8wt+HFCpDZTWMuNKJ7uXpW+/fDuAFz/dnDdraKNbkVfmVLteRTuel?=
 =?us-ascii?Q?l8PerzAQ0OkPgcw6sIIzgok84oJsoFAZTrIIdD2RVG6WR7mb2jRHQRNYwPHB?=
 =?us-ascii?Q?uhg278PEMWVimF9Mr3XfOdlxyxsWeAdYRvDbvBkoyCMrVtZ1d3nEbUVrjHgI?=
 =?us-ascii?Q?ciQ3REH1qYgmqkKqh4nibi0sx8cCIRoPYJA6E7CFnuKoZBDHDzGtUu9cQoNz?=
 =?us-ascii?Q?isYjvSwaUVNR9Lk9GELJ2US73WVf138Icsn3mVTOZs8bxP7Xkwg7QqdbAl1r?=
 =?us-ascii?Q?//N+o0egJa2PQrQzCRCdlZm1DlbMYz9UIBpXTGEnGSIX4jicdskQk6wGGvOa?=
 =?us-ascii?Q?bRxNzaYd8zgj+YlXbv+ICjofH/1QhU/jS2qbcUwODuDQYc+V+jrNMP3ZCPyZ?=
 =?us-ascii?Q?bZ1oxG+Z8AXJrwK8LC4h8GY6cID2GU9xpC+FHo1bckb05djkxGZIP9gQlLXV?=
 =?us-ascii?Q?9xFuWLkaRsnL1xzN0LYbu8ZaXuvBd108Vak/1LtVd9JsttWNEffRUWi+JW9a?=
 =?us-ascii?Q?bJY4l+gcV4hGPsIDwzAerijD8zhH2pLgmJSeBuOwhNLGYbWvzl8zF/g8G5HR?=
 =?us-ascii?Q?eXP48nMs07k9VhodVVHPvYG8P2WC5ntSZf1sxSyoiUAaDhnB3t7YKBNowBDY?=
 =?us-ascii?Q?5/xxeCGmH9Wi+iltVX5E2/sJwYvhLjadB4OPDJC2XWl9OAN8Fgp8OdFedMHM?=
 =?us-ascii?Q?D4inL8p2uJOMDmUcLhZwPHpVUwSuRSJarUrGX1sKDvN4wJem4UL4oRDxNhym?=
 =?us-ascii?Q?s2LFJgAy1XMFyFW6Z3Uaroe5V1GWDNzPSPhw96VjR32EMO8ARwMKFF2CUzbw?=
 =?us-ascii?Q?VknLLYRUCNIzsz7JLAJHjA0KwiDZKMo4huSNUUP0qJvSFSDpu2EjbX6lZ3cL?=
 =?us-ascii?Q?Z9iM8wqFG4AO+r+WR1ArhFVaFVQv0xvjdYryePo2JlJVLdrijSkK1dzmK6pI?=
 =?us-ascii?Q?sMCuBiWK93IJZPs58NcKKb00qj918lINetlCY7lHLfS8lKZPuyIHF7VOcX3u?=
 =?us-ascii?Q?ouJHFIfsSBdidnbp98UvN/ejMUDnrTXKwdC+9Y++9AKM+KtmVYtq6G9OO2PI?=
 =?us-ascii?Q?eJxGe8oJ648a4rGqtSuB/npFxpmcTSdxAeNqTgc0/HwNITN3cNLKtsEbaIcn?=
 =?us-ascii?Q?/q8715HS64HDm+29QTjkOoQp5zOSgmoEzzyYk08d6mZNOz5stGFgBf7aJW+e?=
 =?us-ascii?Q?E8SmIpRdflB5to2Ny4cXZZgR35U4G4jW3pMzp2u7NWcjtrtd/67xr2nhpdSM?=
 =?us-ascii?Q?uEGO3+R8pciKrGtUY1DsM9TvQzx+vMT1ECFCuyy927r4PzIvIhQVtPHC9de/?=
 =?us-ascii?Q?eaaVRFmmbha2eXYci3FqRiMGwk5RY/IuGciVNrkgcdG+/p8eVgpgBO7UpXr7?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IOK2tJaPXuxPKFFacC49GyGa/sk7r2Vtf1hzmNTW999I5nHbPur9ixGs3BqNrs3mF4beckopGyvKJmJUXHMfswVxmbcB5oB9+UGyN3UkNtAfczEWlw0CVcKxX1s44TXlGYWDS277kF/T6+L/UgiON447KkVCmTDgGPeH2eDXSYQixGtgy5bLMfxeSbwXiDY/mdH6uxVYxuho+gErKRmx6Ksy3qHPRO144KeGfuAZby81bcpt157kg/gupx4XJyzq8K3Me7X7WVLKsumXH2Q3Uzx9XyeRUujnFZn6xlpzZU0WEpnXmebvBUPMvn26vsvKo/bCUXgQ4YB+HGoPNrjSRXAe1L5c5Z6EDylOX8Xfug3pjP0qxS4roEemMMfz4Mx3j+fzhqWarG1EZICdqqXmcbwiCGhVJmBC1CqBr+F5PqjFqUbqQYFTTdWYK8i2jLwLT68cS1PYYKhMdCzAv/C00/sG2JPtwAAwcb9ImhgzMnCUVPKvJoK3IWETAjq+6dcixAKTVeTXZnJT8BUz5+u02SdXGkOgV9WJJ1mvId9ZLfESjSn9h+MrHt+ddWGWCkvB+wU0zmrf0LvLheWZpawYLBe2fv7L0QNBM3xb5lF5qn0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc09151f-6a1c-4069-87eb-08dd89793a31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 12:59:51.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a0LTC0LX128pof4qhYwHH/wkx+bmuIEOB5iKAdpFDfWaNMvr6u6U/eoqlYPbyRgdq8sVz+Gevc5t00KPRx5wZB0xdUXkVyPTYV59IamUi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_01,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020102
X-Proofpoint-GUID: VTh4RvPO_zEt4zqCYAhGvyp0iqJ34TiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDEwMyBTYWx0ZWRfXzxYoKVoOcp7L 6lDzu5nTo7T8EhgKm52SJZpIOKJ6ys9AsyAagWBpQJ5Li1GIl4T9k7yDPbqAgC4T0ZdLfw0zrdM Tjq6eEq2KBaVKUfYgLREDjy1ZVWz7Sksp3nqwFz0ZLr2c4G30ZEnk0U2ZhPj5d/Xzvj//OaF/st
 +C2td8d9hHLUmOS7cz4kuma9Kg7r2AsOftFeiwa0q0FQigJMTfx8FUx8gO2EhjlM81/v7pW3JFx ii6hvUDp+aRtXq2c0tW55c07qxK4romnoKMyQhvKSUXJj+OuqJmhXi1VdlgBY5At83SGjLFn0Fw MTa0HacdRSAzRZovW935YYTPIgDzqgp1fTnnJyyod1IbnggEKMO13ui6D37savbUAK19jg4butD
 LsoLzWl05EDNZfuUfEHLG/Ta3oVKLlCW5YAwedL7y1IzMfmzs0UnQrsTTvsZ+Q+8APr4EmSV
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=6814c1cc b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=iox4zFpeAAAA:8 a=A66-PY4S7IA7ME-N3OYA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: VTh4RvPO_zEt4zqCYAhGvyp0iqJ34TiG

On Fri, May 02, 2025 at 02:20:38PM +0200, Jan Kara wrote:
> On Thu 01-05-25 18:25:26, Lorenzo Stoakes wrote:
> > During the mmap() of a file-backed mapping, we invoke the underlying driver
> > file's mmap() callback in order to perform driver/file system
> > initialisation of the underlying VMA.
> >
> > This has been a source of issues in the past, including a significant
> > security concern relating to unwinding of error state discovered by Jann
> > Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > error path behaviour") which performed the recent, significant, rework of
> > mmap() as a whole.
> >
> > However, we have had a fly in the ointment remain - drivers have a great
> > deal of freedom in the .mmap() hook to manipulate VMA state (as well as
> > page table state).
> >
> > This can be problematic, as we can no longer reason sensibly about VMA
> > state once the call is complete (the ability to do - anything - here does
> > rather interfere with that).
> >
> > In addition, callers may choose to do odd or unusual things which might
> > interfere with subsequent steps in the mmap() process, and it may do so and
> > then raise an error, requiring very careful unwinding of state about which
> > we can make no assumptions.
> >
> > Rather than providing such an open-ended interface, this series provides an
> > alternative, far more restrictive one - we expose a whitelist of fields
> > which can be adjusted by the driver, along with immutable state upon which
> > the driver can make such decisions:
> >
> > struct vm_area_desc {
> > 	/* Immutable state. */
> > 	struct mm_struct *mm;
> > 	unsigned long start;
> > 	unsigned long end;
> >
> > 	/* Mutable fields. Populated with initial state. */
> > 	pgoff_t pgoff;
> > 	struct file *file;
> > 	vm_flags_t vm_flags;
> > 	pgprot_t page_prot;
> >
> > 	/* Write-only fields. */
> > 	const struct vm_operations_struct *vm_ops;
> > 	void *private_data;
> > };
> >
> > The mmap logic then updates the state used to either merge with a VMA or
> > establish a new VMA based upon this logic.
> >
> > This is achieved via new file hook .mmap_prepare(), which is, importantly,
> > invoked very early on in the mmap() process.
> >
> > If an error arises, we can very simply abort the operation with very little
> > unwinding of state required.
>
> Looks sensible. So is there a plan to transform existing .mmap hooks to
> .mmap_prepare hooks? I agree that for most filesystems this should be just
> easy 1:1 replacement and AFAIU this would be prefered?

Thanks!

Yeah the intent is to convert _all_ callers away from .mmap() so we can
lock down what drivers are doing and be able to (relatively) safely make
assumptions about what's going on in mmap logic.

As David points out, we may need to add new callbacks to account for other
requirements by drivers but .mmap_prepare() forms the foundation.

Great to hear about filesystems, having done a big scan through .mmap()
hooks I am pretty convinced _most_ can be pretty easily replaced, there are
a few tricky things though, most notably things that 'pass through'
.mmap(), as raised by (other) Jan[n].

For now we fudge that case by just disallowing any driver that doesn't
implement .mmap(), though I think in future we can temporarily work around
this by having a wrapper function that takes a driver with an
.mmap_prepare() callback, populate a vm_area_desc object from the vma, then
'do the right thing' in setting vma fields once complete.

Once the conversion is complete we can drop this.

So overall I think this is very workable, and it's very helpful that we can
do this incrementally over a period time, given the number of .mmap()
callbacks that need changing :)

I am happy to dedicate my time to doing this (as this is near and dear to
my heart) though will of course encourage anybody else willing to help with
the effort :)

I think it'll lead to a more stable kernel overall.

>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Cheers, Lorenzo

