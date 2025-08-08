Return-Path: <linux-fsdevel+bounces-57110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC3B1EC6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E3D1887ABD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0827285CAE;
	Fri,  8 Aug 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fxpv6/rP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sQMjoc+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6428541C;
	Fri,  8 Aug 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668322; cv=fail; b=VTV3vyYSajYiOZZ1YrQckcI+ST7DBYTwOX1V9pHCgd7oen+guQ50c2w5VoA2RF0hSjSTUmkOy6nAJgSo7ooX5AsT5iYRFWjAt2oS+L4S8MVpFGXErQxeBG17CR5OV3TbK4LUiowYWh6HPhPWGMCAcCBrb7ehzG7pMPGp0Z2olWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668322; c=relaxed/simple;
	bh=kCmBYoKchtROlSi/cminok7J70RVuY4ZR3d90XD6M3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s3fiAG4BVRLZq4OJoBXbayc0F0Vk7yC18Fxa7ihXarMZN7TpkGtCNH57Eyao+/ghOiTGZRqhxoLSoSvMtJ32RKspFAA9Dvth/DY0aH5TJfai9lhK815HOlhTUbaMR01gJ7oLR7W6c3ziw+Ma2uOq4ssfwswyQmfrM7yR7YVPeV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fxpv6/rP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sQMjoc+R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNWQ3001329;
	Fri, 8 Aug 2025 15:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=q1M5WweRFj2IuXfgBW
	u8KrCu56DBl915hj5S7O1FDcM=; b=fxpv6/rPJ6RuFm6IjJBFLSMdq+++QTbPlL
	F0qz8+74bojIr3sTBBUQwcA3f25bUZAjejueMMDilChboU3ns9iuwCRQx/IIPK/M
	j2MzgD9ybFdWJB7Hrb95QaQWAaJPD19JETaVvYuijxrvU/PqE5oBRh61sW8puVST
	qRVkPagJdO06EEWxBjHZUi2M8AJFkyG/vjdV9kTYMmnH/HJ8uf6GJf2iDuGWOxxT
	7JQ+gVcd5tV2CMZUgZUkd+mbCsolA6Pk66saOStiKEc7qdG/KH8KRl8yrSjU/bX6
	YxJolSVvqyHZ6tMqNLOGGe8Jxb0WGoGdmhjpaEP5NGDDPX5pFwRA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgxhuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 15:50:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578ESniH018510;
	Fri, 8 Aug 2025 15:50:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwtxx2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 15:50:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwwt3KcFpLciCtH6q1zj+VMbVeOS25djTMhiU6OrCnU/O9mbmuU4C3F7DgV/25KczuTkFgCqVmZ7kBcwJX5TlLQXS6+XkHa9ru2+zjlQlsu3guRv8XJ775RC00PWI6VX8cyuE5X+1hc5Q1s6l+Sls8ulJjU5LqoscTmAbB6MLKBxiCDYIVLno540ik/nOmvjAamB8b4Zu18FIW1vU5pon0vUertjK6Gb5Jumi3pqmdBuMDOOONMEUAkD8aL9FGSBeE7aBAuoDmWk/7D2+bkD/MXb6y2dhyrW50iA8knbU34Qk39IhJlheHcUs/9ucefU5fNwuHGh31Dr6FnN4Gcdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1M5WweRFj2IuXfgBWu8KrCu56DBl915hj5S7O1FDcM=;
 b=hyYu3X45idKrRHC/LDCYpxQOd9j9NNawr7dxw7hgkT9V1NKU5HrjsWuWAIEBifbX+jdeVWOUu9pdE25v3NTlbHd2BBXavohpgx/aX8fv0Aa+LO8cMyHJCH6iEM3hpE+GesICb7vbr45uwYmplucXhSpb0x6/SjeUvj2Nn32nrqChuJ4HNDyUDiOhvNzsEVCX4MKqbYBUxCdTZpcGNgMaP/GisN33EatTlRdlSFR30qvty3GdOzKsPynCM/2mAjhlH/DIEDN9a+XIj2BqnzdwsELsRHblQs3rHlQ5w5ckMeGMl1MZqj+gS5l4L1oTB19ZyhZRead0dnacBRWhtsSeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1M5WweRFj2IuXfgBWu8KrCu56DBl915hj5S7O1FDcM=;
 b=sQMjoc+RwXoQfMeP3D+V9PIUMuoHH60Y/YskT6tW9ECbuyhNLizQM2NRxX6VyGO8OhjJv9NpZArFAeiN46sQ048huZ8LydO9TrKeHyj14umShGG1wFIvctI2YDvkFtqoPkjvAWfn2+b5bkYXMoXnXB1OIcrlknDMTLQKuTITGME=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFDE34AA4C5.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 15:50:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 15:50:50 +0000
Date: Fri, 8 Aug 2025 16:50:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 4/5] mm: add largest_zero_folio() routine
Message-ID: <f9b0b6c5-b33e-4995-9e58-4d1519d3a6d3@lucifer.local>
References: <20250808121141.624469-1-kernel@pankajraghav.com>
 <20250808121141.624469-5-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808121141.624469-5-kernel@pankajraghav.com>
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFDE34AA4C5:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc08f20-61f3-43dd-1a41-08ddd6935915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vy9kUHqay2RiWLAwdZK9FGdfCRekRFi9aGVSaNapSsUxVR7l1V3ezHqYM7XN?=
 =?us-ascii?Q?lYn95hgdliiEFbmRr/xbtOV4i99cOILfPttvq/0P8KHlc3yXINq0KTleVmK0?=
 =?us-ascii?Q?8lbYBIKFmYcVfKG4yU+jk02of0nX+x84846D7W3YBEdjodbjEU3V1YS0yO2Y?=
 =?us-ascii?Q?clk31Ck4ITI+N8BGM+nHv+t0YeI3jIzJdLf0ulsorp3FDuJouKKc34j6SvkF?=
 =?us-ascii?Q?jcYuFOVl5nZkqWjzXpKMLzzQzFwVzFGPZNGCUE309RJOvS5pWs4EFnK3LWqe?=
 =?us-ascii?Q?0YaQsIo2jde3LwEan2JAurbe1w3UwrCj6655OXqRnnq9r1aRrbKN00XYBIdh?=
 =?us-ascii?Q?UcYasHbc6LjAOacD4FrF8hfSTafJRh/l4hU+tkZQxiaSnYj0nSSjGqbsjufl?=
 =?us-ascii?Q?IAVYx010FTwx3PIYTsMWKYO/Zx+zv+9Uj8SoCYr4s7HvNCW21whJDFGbjX7w?=
 =?us-ascii?Q?Pcmn0MOpD1ZMSmCV9px4II5ED5kq78Igk/oPKyF1KpDrTD6Gwpr5MD6Xi13G?=
 =?us-ascii?Q?AIFlQZZtpB2w/EQXExyQo5djXcTXhsJU89o1AodGaoVVtQPKaMffxJM3Zf1k?=
 =?us-ascii?Q?5C6KHDjkI7fz6PaYEbaFkRqrEuJuYq4ZYuvG3PiZUTUh+8oQtV9pyIev2dbI?=
 =?us-ascii?Q?paAM13Z737go6uWXwfR5rgcIgnKKQVA825/GRO22jI5urrQFm2aw5VDVt98F?=
 =?us-ascii?Q?uvM+iWz1XKL2WpLNAapdUTYsuwYyaHIjSv2MP10rBM1AezBbe/7HACqoEdsS?=
 =?us-ascii?Q?B7mnff1qreGyzPxK9UEhv9mOgcTZ1mkW56n8wYnrtsJUtnJ85WbtGhBDsPJ6?=
 =?us-ascii?Q?FSFhAcgszxWsSRtBYjbXhAp5Jbwe+aMuKWUVxgJnk8pWefpEjLNJP5ML0IiV?=
 =?us-ascii?Q?VrNZH3QWxZURdYmxMqJExomRRk2oCOqcr5CAfemGhXjFhpSIde5Ck7BBmtWN?=
 =?us-ascii?Q?N0OVye/EPCwD+cwWjhdch9dQsy2DzgpodySHYPtyjc2r2VzKd/o4RnhHn59h?=
 =?us-ascii?Q?df3HQQTT58shamKoADK2ekX0+T4HhBO5aR5XMcSBkeh0CZDohQgnECmZFWFb?=
 =?us-ascii?Q?StdQWjjn263BpoN8IJhFLALYmRWzbvq8LA09TpxxRZyd92GEStn1Lch+mTLz?=
 =?us-ascii?Q?NW9Z4iwbwTjNGu3AfVAEZDUFK9w3dDk/Xay2KTOvnhoTu5a6NIg1F0hy759U?=
 =?us-ascii?Q?VhwzhF3euMJh75i3r2L0ScezTc1pnehcmTMdwvMaJhCwdU+mHhpNcJBbu//I?=
 =?us-ascii?Q?m+c/VX6ypn3UZab0H154yV7e+Upp2PhQ6hUfSDNuw2aykOKSxyiXWuNT3+H3?=
 =?us-ascii?Q?59GN4Lp7zPDrH79GDeFdOoqzO2RlBAP8OaCL+9yGjRgBUxCYl0ZouJLEFDTa?=
 =?us-ascii?Q?+O16OauG4BHk+PNMJPKDdzumg4x1x9syCUjhtYyXyZDTeBhCJOSg6UwrNPFx?=
 =?us-ascii?Q?zmyRhFZrpDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ORAq9uvWArplMbN0dHvcdjktoCV1+/WH2Va8HfjvzQEIQ6hCgljRElulDKr?=
 =?us-ascii?Q?c5lKIUOO+AVEYt9UmYyRMJYPNKqZkALev/EsNvCULdIRAnkmDQ2XgflF6PIU?=
 =?us-ascii?Q?lOW/2l+dl5dxuWL8mDEOpFEB/ixWs9qzC3tSlKvguehHVmX8c5XaBos29pGb?=
 =?us-ascii?Q?FebtZW9PQViqEOvdC2sVKlruXvKcVUsS1JLtAOkg1slw3PhGOcoDdHYWdYOL?=
 =?us-ascii?Q?Lfe10BuquDG+6vr5KFp89OCJNCtvoNWvDQ0rQT8WFGKYf18I6xSKum8SgPSs?=
 =?us-ascii?Q?ZGOq5VuybIy3j8Hs9U0SgBNMOutWJR0hDiKOKX8heQ51Ib952NNNmJ2z8dPM?=
 =?us-ascii?Q?3hwBEA/xvDwTYhucU+x4E2tjQdgiKdFxUJzhT5r1Aqa82bpVNOiPRI/53UQG?=
 =?us-ascii?Q?TeUIuQRHyXizylcN3NJwN0IK4LZ3AdD8Pu1X8TANHUMeZGcV0CxFXlGvAKL7?=
 =?us-ascii?Q?ycTwPzbUj7e0NZOJliksqfnqFLMjM1Dp38VYQqpVG29UymAlz3NtTPcQ+zyG?=
 =?us-ascii?Q?JrPvsAI2JtZooaP/T3/sEixY1k9GJWHSfVsDW1oqrv/56Y6M5DO3PyiOmQLw?=
 =?us-ascii?Q?jQdlt/mYR1hZqWbRNbTW+mxeARjwOHnSUii5uhh//ZDBe/C8pfWzzmwrlzFE?=
 =?us-ascii?Q?71PDmQWoq5ts0TLPPQ5ulMGWy4SgHpLDplh/4sUfemPeGnsYWwhSIa3x7M0y?=
 =?us-ascii?Q?W36QWtxNxhRvqLEW36MXcabUTdsR+uw1RQ2a4/MAqlaE+0fHqIM+1QHSYz+p?=
 =?us-ascii?Q?Ujugf0cO2kpdn8/ohexC7TS2LISY8IHKumvNgMx0YrzXyn2ZZ6BSEhOYY7NX?=
 =?us-ascii?Q?Vn6DEYI6tdNl00v9+JbgU/O/6l8sbJEweZjYvDh4aBI0n3Na7X6Cp6R0L+ey?=
 =?us-ascii?Q?YM+B3yXUxwnQ6PywSLxj+uyYfqcyn5UCceJQszXZq7r1P6PritZL81scFanY?=
 =?us-ascii?Q?sBUymrB9ltDre/mC633UWO6bZyi8jH4VYY8GTqYSxaxBftXNfZSdry7VRbWK?=
 =?us-ascii?Q?Kpv721m3VNpJG+AAyqH9hpoHBlN3E/KUB7STLmeWkRP1gaUadZq7un7JDADL?=
 =?us-ascii?Q?YZoHbh2PXI8XCVCpZLTBFFWeUd4BzaJDsrimN1uOWmZ1vupZrmZsr2N0hfIs?=
 =?us-ascii?Q?yjrSuaiCAxRFI9tA03YfJsBiromtt0teTqOmLKD30Po+FO4qYt4NVi8Mb52I?=
 =?us-ascii?Q?9xv3SWREK4c92vw7lQhGHXg+W7seTjTpNqn+pg4xup54sfOIANLRQC+bNC3a?=
 =?us-ascii?Q?I1DDGVaHbe3nN2Nt1YXDpPSKE7B0Uj0bjMo50Lx8TfdlavN7bTUdyyu+vRZx?=
 =?us-ascii?Q?3ug6hRT/Lu6E1rdhqW4TDd9ddMtJzvYto5tcpOlWqb0JnUMX92FKTSCc8X0Y?=
 =?us-ascii?Q?UoNpN5RgNf1K7FHOv6Uykfo2j7wEQsQuW3IN3g6KxKREtBQyvRJLsnfoCN6+?=
 =?us-ascii?Q?58QhfksmKU+YOiubkm7d33EB1fB4ICUpI4FtkW0fUF0whLZq5ZhMtPFHbJCt?=
 =?us-ascii?Q?MTiAGMd7zuP69+zcPpcGB/5hKoTb2qmLvVYwbtOgFiZE2AZf+U3lpgEgD5wL?=
 =?us-ascii?Q?XA2Q4WA34CvJ8bABZIf5b1RtaCy6XJpoNFqgDHIuXvR1tdicuOMVxGuMEFIl?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SJ3pw8/aCH6EXpf0w/LbciauxqPXtIZ6zXLsn3iT15RUPvOOSGx78GrJxljI4+yoff7e8gRRARkbSwl+cx9CYD6SdpIUnxTFkss7s0ccdiHsmHLXv5AGAKDkdpUkPsaQwh8sj9NE7SRf785rftJgNI2/i1HgrmFFpUXLAlods39FKpo09C77ERMYsFRqxr2PcloBfftUbrEBjdibl/hdU2cSUtunSGIyHFKVE2cSq6bFRYzcDk3N7GViIoD77f8HzJM/PTFroPYjZDpd6p/VMi8TMGuU5k7zAj77OaF9Wvxi8QpTmuxsRpso4duu+cNRZ4QOqgiuqtS/D9sExlEVfXppEbw/jnwY0DN8xnp5D0PONZxMaTTBa4qMyyeRNvW4IuHU/2AO4/LfEp27vchdCCojD1LOzqJk5gTQG9KQW2766MJAvfDoMNGNPZVYpepEEAJGNeV4LW0tNb2zoqxXbW5JZec+/MggPUSBbVMSnmkVPVCTr7crkyLBku11xD73U8xsrxd4NwIGb+omU7I4QqpnLH2V4VSTlB57FnLMDS58pthhsMAwN5FJLAkXp6OoKPb5j5eGzG1TLuvPGcVqVuq7G7lk3H2uKLRim3UB7wM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc08f20-61f3-43dd-1a41-08ddd6935915
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 15:50:50.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFbza0Ck27d8ebObd2c5sBjm+75bXR148kpIqYbnTcPJTA80Rjjt08Zz0Kq7+EBCZ/aWfILUzAANFTZobeseuNIp0fuCvql3nqOwf6ZqL/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDE34AA4C5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080128
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=68961cdf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=hlPhqOGCPa6wHWZYAvYA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: PEBOfpwdym-V2egufxSQzWca6J2mdxdx
X-Proofpoint-ORIG-GUID: PEBOfpwdym-V2egufxSQzWca6J2mdxdx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEyNyBTYWx0ZWRfX6HD0g6yZPmHO
 fYPU+qdw8mEPYP1q1o+eSUsjLg4yL3r+1/M9n8pK4LJD7W7ioDoaIdpj0afD+2ki1KAJBSVJznH
 Ew3y4JkOlLgDBIPLFciktCzKIhp4o61uhWAuOKi6C+90FEJ4j13a1YqqAJD98EV16Gr28ttoI2F
 RqPdcaHHLWNTTJoTxe2AJsM/QpHS5INloW0rThwxhCeUx9YWthOfFp4G3MjcCwhfhSUxs+BtYPJ
 R2MHXYi55UM4TXgQzPw1V+XsBxET0fDv3XeKjRS1XYa14/+kGrHt/vGb80OZL/d5eU0g7vFS0nb
 YzHaz/SzLqLkPJ/LtoO2uyxtdTrsEhgSTB4HepjjuJg37uWSEYWjdV4p157xpxqkn9e/fob8ONJ
 h89TH48nqXW9PRFJqc4H8VVjst0c7PsiGIJxy9TwCbgw1XZEsuabhG6baI65mPiDaP7NqZsh

On Fri, Aug 08, 2025 at 02:11:40PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> The callers of mm_get_huge_zero_folio() have access to a mm struct and
> the lifetime of the huge_zero_folio is tied to the lifetime of the mm
> struct.
>
> largest_zero_folio() will give access to huge_zero_folio when
> PERSISTENT_HUGE_ZERO_FOLIO config option is enabled for callers that do not
> want to tie the lifetime to a mm struct. This is very useful for
> filesystem and block layers where the request completions can be async
> and there is no guarantee on the mm struct lifetime.
>
> This function will return a ZERO_PAGE folio if PERSISTENT_HUGE_ZERO_FOLIO
> is disabled or if we failed to allocate a huge_zero_folio during early
> init.
>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Hm thought I R-b this already :P

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/huge_mm.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index bd547857c6c1..14d424830fa8 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -714,4 +714,26 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
>  	return split_folio_to_list_to_order(folio, NULL, new_order);
>  }
>
> +/**
> + * largest_zero_folio - Get the largest zero size folio available
> + *
> + * This function shall be used when mm_get_huge_zero_folio() cannot be
> + * used as there is no appropriate mm lifetime to tie the huge zero folio
> + * from the caller.
> + *
> + * Deduce the size of the folio with folio_size instead of assuming the
> + * folio size.
> + *
> + * Return: pointer to PMD sized zero folio if CONFIG_PERSISTENT_HUGE_ZERO_FOLIO
> + * is enabled or a single page sized zero folio
> + */
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	struct folio *folio = get_persistent_huge_zero_folio();
> +
> +	if (folio)
> +		return folio;
> +
> +	return page_folio(ZERO_PAGE(0));
> +}
>  #endif /* _LINUX_HUGE_MM_H */
> --
> 2.49.0
>

