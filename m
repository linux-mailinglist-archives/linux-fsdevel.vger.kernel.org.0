Return-Path: <linux-fsdevel+bounces-54998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C4B06411
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31FA3A3EF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38F625B2E3;
	Tue, 15 Jul 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AWjzrgbw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oJEUa+yO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6A2522B1;
	Tue, 15 Jul 2025 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596079; cv=fail; b=r+WXDxXX5BfshrpvI+X8irj2vLXuoNgsmKxgyT9DtdLyoe1TImTmIq1nr9AwdO+upCma1348AFW6vzWHsVokgSq3vEdcUuoDnItXnEn/Xjp4r0EPgjUgXo3kxG4qCa3Yhi43eoL6fH7HmDV7+XNUfXdwlUS9BWjSLBSTaT/T7j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596079; c=relaxed/simple;
	bh=Eb6eEL0FRjQF7cdS1g4JTHRAkEOB08m4nmCBA3P8G48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lFUt0houqAUjiK9Z4v4Gkx8jaRu8VfiTUG0VJAHnUA5q5lg5nE3s2qsa/eSfisasonHkxGUlb0p0H7OhPnLl3T9TohTDRG5FRBENWHfwvwCDE6FvTzsRIV1eTJYZt/+Zryj45TrJUcK5ENPLLz73DLNNthsKTJ/kKpT7FaqSoKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AWjzrgbw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oJEUa+yO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZDAC017570;
	Tue, 15 Jul 2025 16:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1CxyGlq3uISWOG6dOd
	0Sw6xe3N8MXnzGKPRJv9MbSds=; b=AWjzrgbwhg9UvSK2Yk5x6sQ/fPp2PNavrL
	vv2hUvpORTzG3U1iE3cERasiNw64L6M8TTbqD8pOrEhGbFYPHx4h61j5+/DREqmW
	QFEy+Sm/DC6vweASEPNn5uJT0IVe4k4R88cJc5j+PZ9KWzf2X7rkGsEFiA9cIhYg
	iDr1462BDflBPvkJvlagrBQ8Ciya+eefg4fdC3vG/bdPEKt165TQQJ6o34chqCiT
	ndu+KOFsSD31G6OlkKEDkgYvyMU7QD9NwUypfYY+s5KA98UtqZaRBCc7Z3h6Bx68
	GHJ45F6YhhbGaL7WfZ6EPmHD916xjUg8thLaLjgFEx0CrSqtLwpg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66xta2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 16:13:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FG0VWK040461;
	Tue, 15 Jul 2025 16:13:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a76ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 16:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTZHq4lQ9+A2lm5LacJ2Y15OmMvAfCOwHWYT676NAK5MzMol7WSNm9u/oOgZ8tajwACMqPDTHvxr0TnlI5GtZTEV48vmuQvfObYw0mMiq4n19KnSTqQXf7jFmaEqNoa122CegfF5V/hiQJlQOss6nmQd7omoYeOKZ7qfmCP+SZwhC2ma6B0ERXFIQoFg1g65RQuhMkdYmhD5czBPPdcEO4Ukzy1ulaGGIW90zANH0jEFzVPdlH/6OjE4H7lIEA51IgHQYyGQrXFZCHjDC7LG5guAGLW/YeBa538Ef1kq0nYrgaxS9TpwCt6NrTht5RCGgpNrUdrcGVwLiurPUipvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CxyGlq3uISWOG6dOd0Sw6xe3N8MXnzGKPRJv9MbSds=;
 b=hQ8Fn7LtE1qnv15A8ADqPOvEQfc1AK0nDDtAKfDeHfeWd0TA9gzD9h9tbl/f9nHjPudwVIxh7qILAwhrzIbNOBuap3/p6dV7Tz5wD623UaFXI5obzM0400rGW3AL50Hxj1fjegl6Q8lAxV2D2a68QejP+v2B10K+mdlXjMFXav8ZtNB5CvhP/dVjGxYZ/Pz474CftqUVpIYkH3qlA3SBu0e+HBx9f38tqLauxCrI7OsuCwT43Do+9cumUkoNKwaIr+gzW0dFzJvUzGpwuOrHUdSfKMy+2PjfB0mj5sMloTJfpoUF9NmJMgunOxh8J/2Kz+7eFCOCSCj2SYqtZbyHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CxyGlq3uISWOG6dOd0Sw6xe3N8MXnzGKPRJv9MbSds=;
 b=oJEUa+yOF+J7biiZxmIwk7M87i5dCw/uR8oBDT3NFccXIbQ+m6sBWutiEef8wzqrcY6Oqus2vg6TvBjN+0jMdvOQYtQsIBXOFLFBKNmlI1W1RlQifA4RPLdp84izmJDKE1Vmu6H1q1wQ7JZU4Q6Y6VgG2e4g7d48DVNVeFzmAfo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 16:13:34 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 16:13:34 +0000
Date: Tue, 15 Jul 2025 17:13:32 +0100
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
Subject: Re: [PATCH v2 4/5] mm: add largest_zero_folio() routine
Message-ID: <7060b3f3-3849-45d0-979f-733f29d883c8@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-5-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707142319.319642-5-kernel@pankajraghav.com>
X-ClientProxiedBy: LNXP265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: ee185eb9-5ae8-4a69-e7ec-08ddc3ba8c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VxcQg4kpT+4q4e3E+SgMOn2Kd5grMjoLy6l0WgTIRjHebgEq0ZLqA5hfSERq?=
 =?us-ascii?Q?m4kjPvmzTNyCSnI4nYDK86PnRHEbAOcpZkwxVG0MXAFq2va/xDR2CSVUMFuP?=
 =?us-ascii?Q?ef+mPed09mHOC+fC6jAWuHWreUmHvhiodk34g4Q+6dm/TSANqj+ZrBOLrFVB?=
 =?us-ascii?Q?U8Gsp0FJy6jAGpawY1qyamdK3OYw4jh9RgoGkg8LwpH7TLDCRlxUc6VPnxIo?=
 =?us-ascii?Q?2Rzs2wQaeKNrbGg/ujjdoNyRzaRauSITG0HZMjVNimr6Tm1GW35H6FPgEWP+?=
 =?us-ascii?Q?J0w64oplFaEwucr3j4yqu93V+idRRhZ4ZTjFVmTUGD1UYYsgXz+JNiCVkG8B?=
 =?us-ascii?Q?7gHp9oAer+3T1oZws2Q7bbTmV9uLvlMlbMO+NincEfnwOzWTOQUu2NuF0/mu?=
 =?us-ascii?Q?1FmKhTIJSBt6DLtZA/kMsCdWAl7Tw1/IUTuVDrLMzQLEPSzvJdAhm5/kJ2Hu?=
 =?us-ascii?Q?ZOY/qt7JDJqdmbiEfY7s83AorS5V0ujzKRwEvlLD1qte4oTkEuRKWgh7KB5Q?=
 =?us-ascii?Q?8+PB/g8Fdlos6g3eDlSQr4+6tglotuZeROsciKiQV6htjFj7/Stzfzvv5Lfz?=
 =?us-ascii?Q?5RrOkXnS9ncZM4asp8yGJ0zTytAkNMa5734g5ZbYk65UQXQ+PsszLDJMF9+/?=
 =?us-ascii?Q?0e9FOd6+PkFYT+cYXLzUZGf9rNlsgfIbrZAbf7jy33M9sofrIcZuelIiK4yy?=
 =?us-ascii?Q?F2JNboHMW6Gy113Xjlv4RCLX1mOIjjppvqDnpgKXrsmHkr98RLJoi0VozT/6?=
 =?us-ascii?Q?0Hd9HfRKbjXkOxSwrIZXJzoRvcTIq69d3CTRVg6sbdNvDEr68meDicLcyAVX?=
 =?us-ascii?Q?APeRM8MhDdIMHeVrePKgW9b2ivWgLp80PXY6asQt0xqG/RpWTZdz9bDnURkB?=
 =?us-ascii?Q?PCCTPhyvWVWi6SUnkrG/7LSeHHQDbEEVodJxNfEic9bDfiNyVl3cBx1ZNWQ+?=
 =?us-ascii?Q?+0AaISj0XQhwwtzaTzQitSS1GEarHYRWlKo0gTzkWQQ25vFcmwBqzWrKsNoZ?=
 =?us-ascii?Q?OH0rBcM2FwDW5oQipiC94+Oxi8yjgBYWm3z9KgMBV4g3uuMKojorvUU0wbqB?=
 =?us-ascii?Q?e4Igv0qot5N49QB/C9eUGoJIwi0YfatPAoMVy9P/NUsfuJB2cn0FZ9jo419j?=
 =?us-ascii?Q?zHGF8R0J3VbwKq3fxTbM8S6ypjOeHvQZ0pyct04gmumdXTAxxAYUe7ge3Rsg?=
 =?us-ascii?Q?arJmavHp2wDXS80WakAuavTCcdthgYbJLyxIbU2ueU/zEUJRFYKgr35Fifxr?=
 =?us-ascii?Q?3rXle2LWGF5GQEkqma6/ExvRF3O5nOUU/aY3pPXK0F+TR8EwHK5x+g+JTuE6?=
 =?us-ascii?Q?THtAOilhwvgHBoRDnFVGxdxVUcb9QYDYHbIrBiUKC2XyzxrwajOpqYu2O5Hq?=
 =?us-ascii?Q?jURh8rCtCGklF6Yu/z5AP0eRfqZYo1aM5OU8A9srCaNxcaB5X0COkf4KkDd/?=
 =?us-ascii?Q?fT79hWBBKK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x7Jmi1XzCDqcAy9kHUudFXzf/itpZGLlAuoTKZ3PE5ZlyXq9eFiIW8doK8f8?=
 =?us-ascii?Q?MZM5ktI+rDE6/6XtGFq4R78jS6jmsoJ8EMvNNTQi5mCZk6tGgnDDZ+ImgqRF?=
 =?us-ascii?Q?F8EGv8Rr1C6qPNxDimdXePcT5LVFoZ3m9g/Wew9tNUEJcLRRJueY5vj8x+iw?=
 =?us-ascii?Q?I7doBnOeaJnxu6C2FFqo74Ms7bi9I3GEG8ivw/E3NV41JmErRAYL82mvGw3P?=
 =?us-ascii?Q?S7MNh6BqRy/AhCU1gYNlfZZUU0NZk0Q0BXd0RBri6sn+0H0+rE5iDV1DDd2r?=
 =?us-ascii?Q?GuS09Bf0ZSZkUc9rXmoepoLP4MZwYn06Bh47soWoxkT/PfT938CG3rprxHDF?=
 =?us-ascii?Q?tFj8JdJW8gIxTuh1NpcCxHMyBlSrlD7pzbiCwtXNURP3kNJ8hM6/cgwfUltL?=
 =?us-ascii?Q?42XePk0CMqfaEkdK5FzMdZdPahX4q8ozEjUNkTrNjHYtlqejg3go3R+IHBM2?=
 =?us-ascii?Q?BZKle/XQaWliW+v3lIIX8IQamhMn4XVevt90BPv7XkuNUFywU0Zxn1cwrxFT?=
 =?us-ascii?Q?ZvWDFpX1CaCCjKyz16WUPzzpr/niZYPwcu1Ckbv+9xESkCjC3MaJmDXWQNlY?=
 =?us-ascii?Q?kXSzWm3U7tZdTE8qKN/OodWTeAhu131xfplWMlvTe2vY0xeGt69ut1D34dV5?=
 =?us-ascii?Q?f5eWbm2NB0Vjaq2JVEMiX0vMJlNqHScr5pYzchwbaCwB3E7bkvXFZ6M6SfI0?=
 =?us-ascii?Q?CxLWy+muvylkcFHO4PGQnOwJB6W6dpiL8TxxveOKJYYhyH7qVdblJs9eOfuh?=
 =?us-ascii?Q?jd2wPs4vpLyKLh1suLeXIXfREMW5ujP3460dbh3yrA7RtlnycliBqb6bRxqX?=
 =?us-ascii?Q?XZrwqFreeWNqNpzgkZIUqlT9P0qO5ZMq86UER5Z7qO4/i7ljXh47SJnNz3tP?=
 =?us-ascii?Q?pznKUXx5n3ZXpjJGhDc/+b+FseLrC4Oa8GjBKCJYoLjkf60ojMaocC99mXjo?=
 =?us-ascii?Q?bZmSPksR5AeCuRtjUil8QQf8yFpuQxLSTMepEWN35Jtbnr/ttYmQTIgIOxvN?=
 =?us-ascii?Q?thz2LRbBS6DEw9AcFnKCs9uIzrib8t16j87VyzHQ/T9CTnEPi4uhn4ov194H?=
 =?us-ascii?Q?kvGqQTZeDrrO6WsonZiRsBfDg3VkU4DKIt0TJkdwhiaGy+XCs8Rsg4nphwLG?=
 =?us-ascii?Q?WRWzmhMzspBIv08cTePoGyXy/W8KAR1sOykGkGb2i8JOvGJEbYT+d7ne3BHG?=
 =?us-ascii?Q?iS4T0PRLF55Q3SgSqYEX5X1OPfodyXNVNxN69xh8e3n9gkwom9cPWrFHDLI2?=
 =?us-ascii?Q?qWr7EPGamqXUvNuXmMWLoe0gb4MQfqB2GNqHS1Ux9IacsGkif68jnvseHyag?=
 =?us-ascii?Q?AoWExVmO2pgPoY3hRs+HjHuNLehz535ubQE+9LoWkIyY/JOnyvrbaYO+g6va?=
 =?us-ascii?Q?bhikebby0UH8H7ZyPPsswYNjobIFNXUMnmRwoUM2WZAS/VDEb7aI2u6gSE44?=
 =?us-ascii?Q?uVthicZ07plEMYQSKQ1dEP34RDj5VAPdOpM36GsxlDH+QFpjj+np3M+BZxEL?=
 =?us-ascii?Q?w6M5BBvDSlL8sjKhfn7yb7qfuWLTtcRLQSqGJpObI/4QTHSose+HAQCFT6H0?=
 =?us-ascii?Q?bkELwvS50Z7VTaVSjPLjW/RWAQXjb8/IGaol9csUS8+Eac+zZDcztjtNiPcb?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kqlGgn+xfH7cXTKG8Nhi2nk0kDs1QjKNI/R/Iu6cQpHx3z9VDjVUiBiRnGl1fUR0gZ9/LaivOguLz7FadF1vJDunehMvMILnB7IYDvasCw/zQreHneLXyomqzXfvAi60ZOcNv/CS/nG1CcjswUBF7VWbsXhF3Ke0uGe1OYgNKQhuXm/DG9lepz/IHKZSqjxUuE0c/wTmQJPfq4dD+JwvRTnmlYPvDGJyhIk9N/B7VhkQGh8sCsvC9itcR2Jc8UIw18D1VysoBFYYbq6/BZ+BiM6K/tQISxU4JJakywpJDzjxXvfhdV08GkbjwGmVT6zrf0XC4XkLruhaFKCcpF2fro5hfEiU/Mn1DvWkXRfkKJKbCw2kRz40mZttCa14lVbRKkXuIWVctHo/TRXZ9vsxj4M+CivJUxrUPSkF2nLOTkOxTUq4P3SIaonEQhYQfpHK6Z4VPNwTN+nFkPcRMjyCfVfY+AYf7qU1vNSqy64onj8TbEDN7m9qumIdyHBnE/9BR5u6cPgNoPhCTaopTk3pre8f4uXd2zW/w8Ywrk6p20+BW8hOYdWHU8I15WYKgYjYqBtPZxCpMGI2Ls7RIitVC77SjZr3XfttvlupGQ6msLc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee185eb9-5ae8-4a69-e7ec-08ddc3ba8c35
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:13:34.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KINA/CN/e+4kg0WKl0rweomw1G7ozVx/1gtc+ozj6sPEQ47hmnjdwyE36CAt039OFqCSUo8aTKvAJqM+9cS5Gk6Ax/v7eklfIgfpfSRMdxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150149
X-Proofpoint-ORIG-GUID: 600M-ICrtgP26qYdtuSt-u-WR1UeC7YG
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=68767e37 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=SRPK9JOtRlGjN5p6E5sA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0OSBTYWx0ZWRfX9K08ieGurFfn ZM6CWXA++UXIQiD8UmQmgaTChIcIgOCRRcvgjHVdxVP6uhys0iWwtv8FvgvfqdSBAVcwETQGiYm SoLqXcYr3Xg3+szkQsiDqMQl9c9bySD9fLoPT9TqZdynzRgQc7VkCyXZuu231n3GPB7LLruuUJt
 RFYxq1CbRjhhjkM2QNh6g8t6KSDF5jXVgo9xh49n/LXy3eKmUldIlHGsCBulTxpPEoJf3C2Ozbl Pq3LPQnUljV7eCP7d8g7zpDDKjDyI/vhj3z0w4uJ2GvzMFjlDkEVFcVLJ/U2J2jdW1BCh8lNmMy u7PtO8M/6iZUNPXJkaFlgIeDYuusJ5zjOP8+jVuLbF6rt6KSO1nxw6s3NCgL3h0EkSgYsWo5Gvq
 lEmctdKPDulK4M3sgDPSDbnaoh1dTVoaPIOWH1fKVCSqL6nuewgS3a+1//jFIeCNJqragDwn
X-Proofpoint-GUID: 600M-ICrtgP26qYdtuSt-u-WR1UeC7YG

Nit on subject - this is a function not a routine :)

On Mon, Jul 07, 2025 at 04:23:18PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Add largest_zero_folio() routine so that huge_zero_folio can be
> used without the need to pass any mm struct. This will return ZERO_PAGE
> folio if CONFIG_STATIC_PMD_ZERO_PAGE is disabled or if we failed to
> allocate a PMD page from memblock.
>
> This routine can also be called even if THP is disabled.

This is pretty much implicit in the series as a whole though, so probably
not worth mentioning :)

>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/mm.h | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 428fe6d36b3c..d5543cf7b8e9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4018,17 +4018,41 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
>
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>
> +extern struct folio *huge_zero_folio;
> +extern unsigned long huge_zero_pfn;

I mean this should be i huge_mm.h again imo, but at any rate I don't know why
you're moving them up here.

But maybe diff algorithm being weird?

> +
>  #ifdef CONFIG_STATIC_PMD_ZERO_PAGE
>  extern void __init static_pmd_zero_init(void);
> +
> +/*
> + * largest_zero_folio - Get the largest zero size folio available
> + *
> + * This function will return a PMD sized zero folio if CONFIG_STATIC_PMD_ZERO_PAGE
> + * is enabled. Otherwise, a ZERO_PAGE folio is returned.
> + *
> + * Deduce the size of the folio with folio_size instead of assuming the
> + * folio size.
> + */
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	if(!huge_zero_folio)
> +		return page_folio(ZERO_PAGE(0));
> +
> +	return READ_ONCE(huge_zero_folio);
> +}
> +
>  #else
>  static inline void __init static_pmd_zero_init(void)
>  {
>  	return;

No need to return in void functions.

>  }
> +
> +static inline struct folio *largest_zero_folio(void)
> +{
> +	return page_folio(ZERO_PAGE(0));
> +}
>  #endif
>
> -extern struct folio *huge_zero_folio;
> -extern unsigned long huge_zero_pfn;
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static inline bool is_huge_zero_folio(const struct folio *folio)
> --
> 2.49.0
>

