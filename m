Return-Path: <linux-fsdevel+bounces-48207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E81AAABF5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D3117554A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D91264620;
	Tue,  6 May 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mt8F5cMS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i3M6w2hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DB21BF58;
	Tue,  6 May 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523584; cv=fail; b=J2WG7pxRF5hNhtLpGgKs/qr18zhwUK4xbhHtMQsC/4zpHZBH8y9vclxv8aU78+SyjmnHSNJGU2eCusOrTCvbddAcQa2q4G7blSdFKYEbvb20+lBisuSRvWCx4djcaQygrH7QQ/H9dptpmiSYvqjINMNVEP8JKa+esOZG0ak1o6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523584; c=relaxed/simple;
	bh=vfzwrNoUYV3+DO5LA2Y8c4Ask53tCj+azd7FdZGk4Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fhPFzb6I0I5/W+SOPbqM7rcfsf7Jp1W5yhW9hUg8KYLQ+hlIDnOWcREOTXgkDuzXE4SpIMzM74J6xofGZwbn2Vqfmc9VEecUiC5VNo6pmsB3Ml1+o/ACZqJa3LAemJOGvf+u3I1Sh6SfJDwJaS/A0fASq3ocgBHz2YfMCJrrHRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mt8F5cMS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i3M6w2hf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5469HeAK031272;
	Tue, 6 May 2025 09:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=UypFT6XczM70o+aE0A
	My/nVv1TJlA3wGE7+InaOXXRI=; b=Mt8F5cMShjNVetw+B17qBTMjbubBw9RR9F
	TTqnIrOeEJSQOni6J22nmJOoW6UzDp7D3WyHX7scFn3+6ksI6nA911lLbSzNhqGt
	bR/Sfw9midxC7LYTSePV+HX3p+UK74GjpdOouDx0MBknD6RLOdVgRQl0hGeZfm3J
	HHa1tIkMotsMwPBypidihhuMgZTR3QQTcv9S86Zfa3pIGE6o07T7B5xx9QvvPzEe
	NEkToJWulJl/e9CcUoF8GDdZhgnB1pGf/sOxc8jVMMVb73/0n/teXW/tafrFD3QM
	RgLqP7f3IM80CjmcbyzXh66Yv85GnofKQuQWDqyN1ErrZY8R0VUw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ffng80e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:26:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467jMiY035492;
	Tue, 6 May 2025 09:26:02 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf0scw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBTQEKz51MxNPzYqgSRtUNOB/qjC5jr8bo2Cc0ul3wrlZjikne2bOMrF2p/1jY6a2K6xHfK96MwbRXrErpoE3CdyumL4RiEksXwOviRHcb3+AK0jlI1/4KLp7z/IFzTyk8CaOotn06QRkiXOM49sm5Dimir8XrNOU/HcMf47NZ0WenvLegpgRRqBHf+O/Z2QY5AXhVJlHn5MeyJjeXcj5Z57p7R4fw3xItz2tlwDurYT9ElX33il9D3fiNxnOf30NBPd/m39E/AIFQQlJFsHciRYKCRrdXzqC3/Spd4r3pL25QslCL9BD7jJ1OjznmylVPlWEyacnSHhjLYBlXndHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UypFT6XczM70o+aE0AMy/nVv1TJlA3wGE7+InaOXXRI=;
 b=u1jS4BF8GUmIZJhyFA/4eQ/Rwg0KN3fagWEfSgohrVCX5iw05yc8ElNavMegkvzXxpNU5AwIZNcxMFpkyTg2nyLbrm9Qk3L8iSIaAhyh2kASiB1KpZ8nBE7o+vMUHleu3Bf6gC/+USjrBcWkXlAk6l5e3+OXy4t7XSsdB0qrXkflQ6Tw/RNC9H3v2MnDGEG4OEln9Zh2gzZ6rONBjIqAtZFX1Z20CDdkw4UVscuQp7E/SoC9FwA77f5786muKIgOhZNk7kDeeC7O3wZXy94XXtLdUeEXAXfFfEbB27Jz74ZuOHxdeQoJUJSuKbnWXsM+3lLw/lsCqPHjv65ZPShxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UypFT6XczM70o+aE0AMy/nVv1TJlA3wGE7+InaOXXRI=;
 b=i3M6w2hfCzHArEmTZ+ohCyQdLOhNb7e+PXkA/Gp1/hN3LGJYk6sk+cuP7VpNQP/fRct6AxYtUsMHr8RcVLC/xK9TsQtDcjlaHAkBbMRA2QlBKhy6Atk7OJ4fGGPI0OR7brJTxkDcFRB2MQPkHWO93PeGaSo4WlkYE4A4+mzKNTU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF5F5663669.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:25:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:25:59 +0000
Date: Tue, 6 May 2025 10:25:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2 0/3] eliminate mmap() retry merge, add
 .mmap_prepare hook
Message-ID: <08e1ed6b-1175-4c07-9de7-6262d95cfd6e@lucifer.local>
References: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
 <uevybgodhkny6dihezto4gkfup6n7znaei6q4ehlkksptlptwr@vgm2tzhpidli>
 <0776ce6e-ed62-4eaa-a71a-a082dafbdb99@lucifer.local>
 <20250505-frisur-stempeln-9b66d6115726@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-frisur-stempeln-9b66d6115726@brauner>
X-ClientProxiedBy: LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF5F5663669:EE_
X-MS-Office365-Filtering-Correlation-Id: 20015d91-aeb8-408f-2e25-08dd8c800306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?itm8Pag1J8eF092IlqljSDij17/trbYoWaGuO5adUtzR5y55qZWWuRyW0Kq2?=
 =?us-ascii?Q?lVwEVvJ0CEXA2LsfalyjNUH+dqQWdvSDSSgRe1kPhXFT1q5D0+6aWcUOCTIs?=
 =?us-ascii?Q?Mcj4anildTaHmgrjfiJnT0MUBaYYsAmU+oVe8StFUYsocHJwSRTOM1rlE4n6?=
 =?us-ascii?Q?pQBdIcL8EsN5LA6XipkU7yYvdK3n1KeAi4EsYOpNcEmMksZF0E2uGjO6EDYS?=
 =?us-ascii?Q?zdE8D/YddLOkaFAq4flQPnrRoHG2zv/NeF8bRJsZp76Q3OY+Q6TEkiOkj9mh?=
 =?us-ascii?Q?rybd6AbZxr1PjMaupZeIWPNDlGtqUorxTW6kV4hrjwBPJKFrkqHSVk+zBbrz?=
 =?us-ascii?Q?YT/VtyoN5+QBXOPq7AFzyxRSCqPbQpkKc0bTZfsCGK3CoX8s9VSh73cFeJti?=
 =?us-ascii?Q?aDyWM5LBVd+5pYb2ZJXD6cdBKn9t/ByUY8lrZyn+8onjaJtj2Ylfm5YqKzQP?=
 =?us-ascii?Q?xdkPSyFeOuUCkrCbGPySVDBhxzrgW95f2N/Hwryj4K+9ITvtx2u3c40oaxNY?=
 =?us-ascii?Q?eC506j7MPpJuabBiJtT43ZB8dMRxCbhJ4ViFX0LEOUxG0VERv9/dOiR93S4o?=
 =?us-ascii?Q?TfwTZuw+ylfDG5ew3zkp9xBC+6gCH96R9nHgBYeUFiEe6t1tD/IWja0iNFtS?=
 =?us-ascii?Q?r73wzGe3zizimgPp+eONv82UhIGhR/Ti7O6X6l8w0nsXf++dzrQIifheXKJJ?=
 =?us-ascii?Q?bkv8WyhKbjtoozLE5SHCkm0l5EcNdmzwFRUHJAqTLj9KaciqeKmwFDhD4BRB?=
 =?us-ascii?Q?0pxPZznmWZ0ilCDQZY37QpsJuD7bmiWp0ErlUmeskMJctU6TaDXSUTfGo54e?=
 =?us-ascii?Q?REP4NcFEs6UD8AhsTd64UxALgryiHs1OqYDY2uzdyafFvE+Izm6eykSaFULZ?=
 =?us-ascii?Q?h2ud91jvRn8YV5oBTUvbMEOdQowO1T1PCMGITrJa/lV97QzNvmPEixa0esoG?=
 =?us-ascii?Q?rWfbI8GCFrcBKV4QFM+6lDRRUlQJpkr1PPZEeQ3H5klFbfuYyB5YZP4NP/LT?=
 =?us-ascii?Q?oCY2fWKZ6RLG0SkulQ2uzh9BgoHnzNgM32N8kiTwe7A6/MWyVaP41ewrBbkM?=
 =?us-ascii?Q?8cmAAoSEBZZq1Q/qIP+RDiJTiaW5l5RfXA8JG9Gp/AA/a1joUNJ7LX2m9AM3?=
 =?us-ascii?Q?6NOE4L3zR/mAD76hEL0eMseI1/8BS+qJUkWIpij6+nhnMtGRyJ3KCENCXfb1?=
 =?us-ascii?Q?xwhgL3sFFMaXMv+Ib5aBUj+4hRNmLoE4ixa4uyjrariBOgMNbbkwsOkpRQRZ?=
 =?us-ascii?Q?OvgPwk+/6zbR/ipWywCh9O6jOEet3CQiB5fKTNvLAXUJ2KpJYbOqJJNazq/Y?=
 =?us-ascii?Q?EptJlIPZ2ioDJaIioupEnsN9fSh0rA6kIcVb8/OhqWoT3GJynh3/EP/9qIaK?=
 =?us-ascii?Q?8tmrd7ojQTjFrIHZAnTF7XbLRT2VcpS8tN7Fl+HCAUHRNOyXKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fIjGI9NUsgMpxhx6jc8/KbPRh8YcgekoFhdAODBXwD2QVsjGombduZ3hzmYR?=
 =?us-ascii?Q?i8SzYN4bUDjkCyCVuqk4HTH13MyhIR4NZum6JqHiPjxwfXOjiXTL8FgrD5bn?=
 =?us-ascii?Q?kQ+h3wESEtsE7BIhV/H5K6Vx3G5v1rbSblENvUpPuVeIxZhCMdIZhH4wfOge?=
 =?us-ascii?Q?Y2C1r8G0NJlXRufpEP7aI4NVuayFm9jWgXj5tekxS+6ISsihE+f/IAHAjSt0?=
 =?us-ascii?Q?5YrwWgThecRBnTDuIbhd10jD4wjcu14W1rX59CdoIiOq/g8bSotK8MIUyytc?=
 =?us-ascii?Q?7SaJv60Zv6lp+ViGExzY9SzouQL9X7Fd0cEFRQDsEpvV0YCy/zo9viJ9+W3G?=
 =?us-ascii?Q?2msPQx+Qz9Pm9BdYjEUODg1HwD+b/IpnEebWykLuYxV4sozSXQ6WDb7eYwJY?=
 =?us-ascii?Q?lPqO4FeqBHWBIPDIrd2AQ0Kc23BHc+X+mbcm1QHeFYGeZXraab82VAeGGtWp?=
 =?us-ascii?Q?FPnpTjRN1NOoj35f00JqhKxm7TY+dHY+BmbcoSiN2fP3YSknLUCly99DaR2V?=
 =?us-ascii?Q?eOSD18oHHcpnT+d7JWECQHzS6dTMFHxRT5WZq8JFkfrdGCInP0x6kau0oEYV?=
 =?us-ascii?Q?WAz5ju1RecNtz7Sr0DdES/FUX3I31BVtsi0atERK4UKVs8MAAXo4vD6SDIja?=
 =?us-ascii?Q?G8BKDSMwL6AhsPwi6AG449Hc9fd9846u6nLn8lJtZ2Yg7xXNXC5dnIROjdu3?=
 =?us-ascii?Q?AlHQWNg1cZGPLuwLhEk0kLdYD8JXj3qjN+B9naI7DxHTosqQrz7GebwaczoS?=
 =?us-ascii?Q?BF53z+EpqD3WDnbb98FKuc/p2Q9tKNHHYVk8E9DSVbBD1JFj/E3hCSl3HwKk?=
 =?us-ascii?Q?i+IPE0KP4oZ8lVH/WVS5dgU9Wwu5z0CUev5cfoj0GjS1mVC/cDOUWPUzse8B?=
 =?us-ascii?Q?Kj9nOeGSOVvLTGfdliYNeinev7sx3oNNIoQUKRDaNrUnaSBnVrDs1okqeNEZ?=
 =?us-ascii?Q?aotcp8a0QTfgwWAeITT1FIkNcPuggJkGwaVgLy478ks8gRq4UUaZC07EKwx1?=
 =?us-ascii?Q?SqwCRfXw5UtD9Wbgd9CN102jVOdlIRDg6kJSr0OVB86zLxlT3X/qze5BY5pQ?=
 =?us-ascii?Q?D79d1tcjJjr+zZA9+VuObNsZGTtpf0fWbn3WB9ssQdN+Ch6RTG9eYTTOS0Ha?=
 =?us-ascii?Q?ZhoQM4FvE5aA1y6Ru0FX7uIsFbEHAXtNabl4/dTqO94fDxObCq3GxC11DuHT?=
 =?us-ascii?Q?YSzq/bNEve+eyKgGZ7mi2MQgH69CrD2TB1wf8QhlPhZDHmLBXq1NrHi5wxPd?=
 =?us-ascii?Q?YA/tNAw8d5nVpZIxv0C0vIRmMKDDYkgqwIgEnUotmEupaql3OrY7SLtarXVK?=
 =?us-ascii?Q?fLz30tS3QzuSG1BMOlw3bKwhKYHSPFxTzf9Iv1GZbHUGXciy69hyzi4/NLTn?=
 =?us-ascii?Q?BsN9nznVNcGGUEovLDflJwM3WncVBOMdVXHS3bwNzQ34rvUmV30ebHwzBwP0?=
 =?us-ascii?Q?8C0vcz+01JgWSTwZPSXNWc3Q7ewjm/ATDHeQqwmskqEGp7sFgDRG3GS77FuM?=
 =?us-ascii?Q?qTvKINE+d8rl5ytFGY4vWHXQ81+9v+YCMbjbfU9xWQh1s6C2D2Byby5wFpK/?=
 =?us-ascii?Q?w9o+tDWJLTgVEB3FBHwvRxhvybMlkf9F6rQrZ5lgZZ4US4h/NfUmJf8YGX7/?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kGCRq5iBvijRanHquNwMYsLkWfBNDvkyHg0OmHjqp63qnGIfB9scxKMtDdBsY4WK7C8U0iU/kdxHI08zIR1gN+KO+orNtv7mb/bisAyEOcvPR1atYI0yokFlCjduMoFfXpOi0jZ7Ckj+WERkR73ppQ0jsXUc4RmLITKGepatrEOB0EITRP6scrTOfGs8i1zBv06gs9SyctVhr/dU/AcrQsEV8B308a+sJoCqBzzqcQH9WNRAV+JyQmgosBs0+4SIxqT3nBQYWCZTsrwwvwncgCiIFFQRkwawrhS4CXvr9nPNfQONCi+76K1v8VnOW8RH3bGZhMe7Fs06OOPh4D9/Mo68Ir4zAXrkWw8q/5rQNbUdZsqtwGAF1udo23lFHRTlG0GXejrgPWNj8+62+NmR9HBN9AK87UXoZXb0XUmdi2L1hoRWKUnwTA6jfB2YZLUjjvFwHnF34xxstIiUCKmyFU9rG3aUv6EksGZGtv4QGPyBJXtPqSRKXsBH2JSGBA+2C/uZUTedoQLyTi6Y3Dg0V91KozZk4upKHpXJZW/sh2ZGw83iw05iNUipesAV4kBV4Zw521MvJu71IvV2h6OjToJjf1UhYF5DghNesA4TzzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20015d91-aeb8-408f-2e25-08dd8c800306
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:25:59.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/RFdX3stkTS8s1jn1+0kZTRWhYOD9egGvxAwinKEBKBHTWfpKony4PD/h9OD/fjdDulCSOJizy1youDLzsxCYHSLeiTPiBrfQNlvDIVbPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5F5663669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=965 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060089
X-Proofpoint-ORIG-GUID: DqsgIFTAOJCBMlbJ8zDFhS-LL8UE2J4J
X-Proofpoint-GUID: DqsgIFTAOJCBMlbJ8zDFhS-LL8UE2J4J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4OSBTYWx0ZWRfXypd2EaRANxAZ W0j4zS76+6FZc2nzgGOwr5JaYf9ZzH/WFzm8ip4Qtru1txeyauFp8diffVzQyyJjFNvblmeEoX/ dMiDIZwB6TVExo+C7scj0SbxBZXNuL1CxIgvf/2k7xfrzY58N+znPQSwwGtMU9PN08Vog03uHUt
 j98e7PgR3xQVklOxcEpSK2zKFsTMo0BKfx4N7C/BoXnnUc5TmJNM/1TMMOecUNOQmAimdQ69goE yt5ni8D7ARmCD6zTmHC3STc0kk2u2v5GQnM60Gp/GcGTRQOjVAR3It/Av5FVWALXdHYCgkLYeZY BtquR/Ux2/Yv3ZUBokfS1EcDlSUmDbXlc3jtMxn6uRl0FwIPx/UQvjfeT6wlx61axLebqIoEEnG
 RRTUTfOWsISTS1bnE1Bs7miY//Es5mIXvS06fEnqjS/c0Vg2IUq5uB+DHfrlqcmase5KI6iW
X-Authority-Analysis: v=2.4 cv=IdmHWXqa c=1 sm=1 tr=0 ts=6819d5ab b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=apN8M-5Lg09n7WysdI4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13130

On Mon, May 05, 2025 at 03:37:39PM +0200, Christian Brauner wrote:
> On Fri, May 02, 2025 at 01:59:49PM +0100, Lorenzo Stoakes wrote:
> > On Fri, May 02, 2025 at 02:20:38PM +0200, Jan Kara wrote:
> > > On Thu 01-05-25 18:25:26, Lorenzo Stoakes wrote:
> > > > During the mmap() of a file-backed mapping, we invoke the underlying driver
> > > > file's mmap() callback in order to perform driver/file system
> > > > initialisation of the underlying VMA.
> > > >
> > > > This has been a source of issues in the past, including a significant
> > > > security concern relating to unwinding of error state discovered by Jann
> > > > Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > > > error path behaviour") which performed the recent, significant, rework of
> > > > mmap() as a whole.
> > > >
> > > > However, we have had a fly in the ointment remain - drivers have a great
> > > > deal of freedom in the .mmap() hook to manipulate VMA state (as well as
> > > > page table state).
> > > >
> > > > This can be problematic, as we can no longer reason sensibly about VMA
> > > > state once the call is complete (the ability to do - anything - here does
> > > > rather interfere with that).
> > > >
> > > > In addition, callers may choose to do odd or unusual things which might
> > > > interfere with subsequent steps in the mmap() process, and it may do so and
> > > > then raise an error, requiring very careful unwinding of state about which
> > > > we can make no assumptions.
> > > >
> > > > Rather than providing such an open-ended interface, this series provides an
> > > > alternative, far more restrictive one - we expose a whitelist of fields
> > > > which can be adjusted by the driver, along with immutable state upon which
> > > > the driver can make such decisions:
> > > >
> > > > struct vm_area_desc {
> > > > 	/* Immutable state. */
> > > > 	struct mm_struct *mm;
> > > > 	unsigned long start;
> > > > 	unsigned long end;
> > > >
> > > > 	/* Mutable fields. Populated with initial state. */
> > > > 	pgoff_t pgoff;
> > > > 	struct file *file;
> > > > 	vm_flags_t vm_flags;
> > > > 	pgprot_t page_prot;
> > > >
> > > > 	/* Write-only fields. */
> > > > 	const struct vm_operations_struct *vm_ops;
> > > > 	void *private_data;
> > > > };
> > > >
> > > > The mmap logic then updates the state used to either merge with a VMA or
> > > > establish a new VMA based upon this logic.
> > > >
> > > > This is achieved via new file hook .mmap_prepare(), which is, importantly,
> > > > invoked very early on in the mmap() process.
> > > >
> > > > If an error arises, we can very simply abort the operation with very little
> > > > unwinding of state required.
> > >
> > > Looks sensible. So is there a plan to transform existing .mmap hooks to
> > > .mmap_prepare hooks? I agree that for most filesystems this should be just
> > > easy 1:1 replacement and AFAIU this would be prefered?
> >
> > Thanks!
> >
> > Yeah the intent is to convert _all_ callers away from .mmap() so we can
> > lock down what drivers are doing and be able to (relatively) safely make
> > assumptions about what's going on in mmap logic.
> >
> > As David points out, we may need to add new callbacks to account for other
>
> The plural is a little worrying, let's please aim minimize the number of
> new methods we need for this.

Ack. My intent is maximum one more, but to try to avoid it at all costs.

