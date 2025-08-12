Return-Path: <linux-fsdevel+bounces-57532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F864B22DC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068DD7A80BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DCD2FA0DB;
	Tue, 12 Aug 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lP37fN8i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qMXBrBww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A92F90E1;
	Tue, 12 Aug 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016526; cv=fail; b=dHH7iNr+/jV5mcxMR4sIMNmz/R4AQmglSaa/wGMsxGGghqS3gasMEwreTE2cJzMCGXu4KkgMZ/BTbWdOwIWlLSKpk6wlyb0ZkGt+KdMd1XUJkVQ9yutRR6zlYpvdy46N8m0moiPBbozNQGyxrszUNhiVTj0aJL1AlmbGFvUwnj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016526; c=relaxed/simple;
	bh=maXf273K+dPRRHLcA7m3csTiZKlD7IHN+LD00ontZhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IFbYhCOyCIRato9TpHhssVvFhTmtBJTZk6lEJuslkCOydd5AAgzkwU6MnEh2O3s0roeWWtRRILj+KQWrv/n/f9dgU9V5m/8oEEm0NaXN50AAf8OE4AeeOEg2fmOoeBb7bC/uz9uVYzhnT6cS3B5MuMn8q0U2RQ8z0OqRXIaoghY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lP37fN8i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qMXBrBww; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBvUe025218;
	Tue, 12 Aug 2025 16:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=t7R6/TN2n6GCbuwIP8
	XBekAghyeuWiFXkG2zX1R04nM=; b=lP37fN8i1FG3ZuF56ldjLa/dmdeHWIVF1w
	dCsscAQ2i4Ta8HTA0YlpoEk0sF7kNFlnYNIcAOnuHcYSq5R0gl0l9Oww4eOkvTE9
	DVCK5SwVw6oVt8ni5JWBcZTFTS6ECxBiBgFok8T3AnZ7hfXHC/0Cy9J6QmOgoIBR
	InNdigIT4OaZ3NUma0aTRvrK2jyYQERxzrnxPcRXBLW+jo+V8zWTbWy7iperjkd5
	w7px1GWvEcROjH+UTAuqBiYGxeZPLfySb7y2jUgf0JZPjsZTnZF3AuWEy7yg6E4w
	0+QKI/UMNGgBXkz7c0oYUvLj+Xv2jWpCctfcHIDFkD3rA+O+vO7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv53vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:34:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGNa4A009881;
	Tue, 12 Aug 2025 16:34:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsggmh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSaDKFNvJoUlG2j2JyMfX6QS1yh15Xl+EjIBiGlKedz4WrjSFtTB4UwsGLmhOKjYH5kJXIkYvY42ExRcwBYxRsuAjtz/m4MEPHJrAoenqxFq+uSwJwTSkhIY4Q0DMcJCqNtKy3iTKJUzRIqEDGdqm9jlohXFvUedWVD5OasjMiGzJXdXJu1fQZ3lvbhtKXJgtLWa+aVVFp0WZEoNFiVsUXKDlWVUVufTAYs/7DrwPtGygpsXIfxh1Pxb2Dj5O4d8UMcUfCS9/yhlm5D3keDaoReoijjH2VK1YgIjw5qm7E+1KZDwBLAjEka7icOb0FptGtS9O2wKIBpArxKNrJpPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7R6/TN2n6GCbuwIP8XBekAghyeuWiFXkG2zX1R04nM=;
 b=R5FTC8LNdE6Vg5ixnOgX2EPi28b6xgv6ixXygrJdLNeaKm5/D2fdQsKqScqj7p9ylWn9CQuvQwn6UqrP3HU0Oo4A7dJUNCeJnUax8ZhDeVEYlWCa1JcQPxmVOLdAPDiFuEoE8IeR0nhJ/cGDMFbTITwl/3CAvPXcQrMCNO1R+HS/BZn4aq0RMwPfYqYg3tVfkeWnMifgfGf6vjA2JEyCQ+3zfdUm8phz1sppmhyoopo57TtfkL6YEXgcTWTlItUdhsNGrrDaoZ7XknbIKTh519Aidg3m6ZP95kMOyW6qGbT/Dhl7NeoxmtQ5dWO1/Mvda1FvXl6tR3Mtdg8P2beo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7R6/TN2n6GCbuwIP8XBekAghyeuWiFXkG2zX1R04nM=;
 b=qMXBrBwwsqWhtmvXXPnaOmQQzt6vgyu/8yALD/zT6eI0p0yWvxA/itOS+vZdG8tqMqk32cGHYH6AoLM97nxvmgXfAbbfu7B0Fnil7iPq5V6kanb3F67IydQrauwSgo2KfsozHxmzPBQ4NXF113h1/RIDXV46tRAhYnCzmgT1bR0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 16:34:36 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:34:36 +0000
Date: Tue, 12 Aug 2025 12:34:25 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 03/10] mm: convert prctl to mm_flags_*() accessors
Message-ID: <se6zvzoepmmxnhfrfzjtqit4rn644ttomiteqzrzcqw6wdr2gd@mr56ldap5xkn>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <b64f07b94822d02beb88d0d21a6a85f9ee45fc69.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64f07b94822d02beb88d0d21a6a85f9ee45fc69.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34)
 To PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af01ff3-0c97-4ab3-8fe5-08ddd9be2013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?okv6vx2V47+BhcCQdgW80b+PoyKvBZ7Ve3tHahEsQdJ0dfNA3282p4Tsd0zH?=
 =?us-ascii?Q?kb7CiG6EAd8yf5RVFhZ6MbJLbd1tgwXdWD2nICScKmanylVvAtjdwBb2pWhE?=
 =?us-ascii?Q?hDim6g8ZXPIGFSdKckKM+NgqoF3E0XTzKDfxW5AESQ2D+caHej2YFwGbc4Wo?=
 =?us-ascii?Q?U8p0JB9c2Tb0fWngI8bjytOuLH7Jr0bb6m6dD+gEtYZM5QcOP36ehoXAFGUZ?=
 =?us-ascii?Q?X+9Ecueo4LPcfnuQmgVwjqBnfUgmQYUvD+gS60rOOqLMGNz36x+lusAye0zE?=
 =?us-ascii?Q?o0j60DRGpDwwbLEROJFdbWHQyHTY5CduvweZcnyDCs2KMYuHdBmEfa1WKr7k?=
 =?us-ascii?Q?s+YCN9vlHQ0aGw2KlWqb6rOKLeMb+oZZykpV8JJMC6izCAC21HiPo1XXDJNM?=
 =?us-ascii?Q?HOjnp+s9dbW+CiM1sUC2ed+d5QB5mmF6qD+Csn86rYjd7+FZANfKHOkYHITP?=
 =?us-ascii?Q?Race/HdbP0RYeFmcdBO6G+ygnDh5yVK8N4FjdbQ6zWSWii60NfvUsz34yvNc?=
 =?us-ascii?Q?xfxnYoYxMc+cxoAjJFP3vxwUS2wRA51uqJVOaARdkeY6r9DasgFvcnV9Q+3K?=
 =?us-ascii?Q?Uukxcp8JbFtLarOH6Ljh16HbZ/PUU9RcK2zE7nnr/2haRp0zcd3pfqYlcDVV?=
 =?us-ascii?Q?imKysnwHl426nuBljm03IDP1Jx8ZeZifKJNa+R/JXbGtCrwR5+CX56AoNCli?=
 =?us-ascii?Q?vq924Kv9itMP46X2DU5BGRJjmmYXKpZ5QiGTE2DiRnADymsK1GGNS/BYVKPa?=
 =?us-ascii?Q?eq3xVAfKh4YbssaBFteJ/r0xFueU6+N19BnzBuHuPtsWHksXnjTQhUB22ICG?=
 =?us-ascii?Q?Q8Q92sUZgGEmGyhNNp1tLtgvfACja12XE/yTVaMEzqKoLD5U3u7xue0E0GKG?=
 =?us-ascii?Q?LNtBY9te0IvjoBzqZegUI0QBYL9Ay1JT2csTJohwFQ0zDs9VWx3cXQUYGEVs?=
 =?us-ascii?Q?wOIboiKC+5aEQfAJ3szW2BX0C23N2rDvesfBxrHvCbStuq5UJBDlq3IwXDgn?=
 =?us-ascii?Q?7rLnO4fJHtXvQn4zBA+UfG/oQ3CwvLNL4Bh7T3o5GnOjavVh3T3E6Bznw7bm?=
 =?us-ascii?Q?oFmPh9tgUmlwm7c4kBpe1xRhBCLxY+2w6CgL372HVZQ4dVKJWg4wWMoY3QSl?=
 =?us-ascii?Q?wGnBWtKkm8kmmvEcPMOdQMtH99c0Sk6+paiMfm6ImhwHSRSFwzJRg319zF+z?=
 =?us-ascii?Q?BwR1JxHx+9lsMl0AW3UPs5RSWNnpQ9vsbXuTIX6TVfsi3u62uO5nHBHUymQy?=
 =?us-ascii?Q?pY1DdmATPhCalCQvx2WaKZ9R2eVhKMFVUxkGaCVFo5pucutDZ/eq0Dum6zEo?=
 =?us-ascii?Q?jRq+etwc2i3YODH9jSfIe5ts5q7On07aUTF67QidjykBsaupYdJkw1QNwa0b?=
 =?us-ascii?Q?DVELH7IiyVSalI12fCZPQcQ9dgEmUN53nyu4iNOwvSnQ6kGyoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYZLsEe2LsWrYAxjP6fuEswHHIJZnLuH1xF+llNJdZVEDSZe4ieB0PmZF19c?=
 =?us-ascii?Q?esdxK6j69emJUygVi1apG+18KHTFm0DLPEJkH+Snu/WCviS8gbnuGgxgwAT1?=
 =?us-ascii?Q?7m7MfW1CGfdxVq4kX57ABYs/gmYpbK+LdJ09a2/rjD15sst9F9KXyXlsvj90?=
 =?us-ascii?Q?V17u3rfdHUvZRXQwVtOwBaskEU7e2NEcIDK+5VUNnMc30dI7AOm+hsyXpJr1?=
 =?us-ascii?Q?lrbedjUCWb9Sxx9wvGmQdK+uZpOTxh7/HorBCNustE5wLodC8iYwvo/GktBa?=
 =?us-ascii?Q?oGElxKlJWzG9fKl+xmplDFgQF2KCJGJuxQpsfIop0zQ+xnBMyMWin4s3t9JU?=
 =?us-ascii?Q?tsP+T2dV0v/IDFaE73M/jDgXEcbI2ID9vn9hX1ILQ+/QNY4HeShHH17MmqH1?=
 =?us-ascii?Q?7qeZWUt++8OHtJ+y77nQ+Mk+UgzEPLJ1856VJWwvH2noaXUfDZZaJpQ6qkPL?=
 =?us-ascii?Q?w1wDp4LK+3wSzm9BZZaYPFQjMVwGJjYI4MAsSzJn3x28xA7TzeYWJ9+quyHy?=
 =?us-ascii?Q?qmM2WMiX3vQXdOgNtn02ysdcU3vBRQbk59Ig86NYalnSu6TNZ/fB9B+pxzNL?=
 =?us-ascii?Q?CHGbZiJNm0GnhfjqqqTGArlqIUbnRLzC/x9TFbt1LqNr/1Zts21f2Sps0qGt?=
 =?us-ascii?Q?zRmz/7Xy1wuWtTEj1/Jg1IoRoUJeq2/WJSJ81RBfm0zDhyEuXtDk8z6Hx5/h?=
 =?us-ascii?Q?MeHNBNDfAlxo9lSrNtLUJxbrleB4KUCdgCskIhsAXepKqdB/Cqv3ulsHqgg0?=
 =?us-ascii?Q?73fwg9Zf59pxTX1n6SgXERZugsFZaklS8NJcTJLWl1MF53mA2ISH+sQZIHwa?=
 =?us-ascii?Q?RxProcvz/mJWgctTyboM6+ZflP9OzKUqIhMUbi2T5K+vPBUlCvprALQ/RyAh?=
 =?us-ascii?Q?4MJOjvhDrV17J+8qFapQgc5LLxvnzxm0sEjaxEUat2vC2k4jh6OPZoTnUyn3?=
 =?us-ascii?Q?FsvIKIPaKHpuMNWZOpj9Sme86PYSCl623lXHB+aXpL0GiTes3v8XEGNBs4If?=
 =?us-ascii?Q?//tqC/hXDsXFEO39p5ZUVZ5D6ku8ghNcwir3XGnwwFJky+zH+mhyj1yvuiT8?=
 =?us-ascii?Q?UYSkF4/QOOByRQcADoZFjDzHHmA7jZgc6xkZw0eAGFtbyCH0e04rnVysihtk?=
 =?us-ascii?Q?YAtZhLLEkkN0XKQxJhGWlKKtO++3jolKFlq9qjxIyWtjWfsdWbFaEFHaNnUi?=
 =?us-ascii?Q?uNjiaars52G2Yb9Cibtth9yALcPCQR4W17gVWvYTs6aMwd61DXNM0xo1rukt?=
 =?us-ascii?Q?h1inq8ErtSQdLwPrhJjr+Eq8i+Z0FMjAunKEThiIE6FOXjbIKvDxXwR/Zsw8?=
 =?us-ascii?Q?Te2AlfNpVuxDnXa/ryr7Izfxy6P8jcD7wmbhuy0f/AMnfL/fG/zbhxH/6FDF?=
 =?us-ascii?Q?jj6PFHC4nA79Dmcv5wzLu7SlpHSrK+RJNfyRSpZzvWbSvOjghBPu1g6jGPE6?=
 =?us-ascii?Q?WN9y2VP17TgYxqC1O/yGS2744coNu6TYCWaRId/pAJ+gboWGKYasSoJa9qJe?=
 =?us-ascii?Q?3PsxpMdF1d+05172gVIjod3lLtCOEQKbuEn1M30RmAngArpVyV2307p2oKoG?=
 =?us-ascii?Q?FACHcXwBeiB2MRPdha36VwOzXbimtDRuV4eMEvEH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LF7mzeQee5TwfY1MbMJJ4Ioe9pvuPkOGQN1Uhl1LxTrU5TeMVL4Yk7nLst4tyTXYPcLXcVrmfy44z45/J0fxw9hN6ZbolG/cHzSrcAVVYusxK0jGUSTWdns70/rWQyEvWMQj1cFEmAMHRJcfTJQrxK3gdk1CGBKLPin1WB41d75lniP3iy8LEuHNL/KC+2CljiEYf40fM8bvqXTfUVsQ19ndjZ+r+eQcb21iV+LiKXdmS3su9lTQO0fnsR/P+0Vd7+m3C1z6GwphiGa0UI5Bf2tXQzu2HKqBvqsUIl2x20mgtbtP+HNlfLj05VNdCKOFIrSTy+TiWhCjb87/Hyj9eqbxFn9Uq5FGq3HzSwtD2CZd8LGYJO50QPvRgetmZgqQB8y6ZSu/WpAMllG+PEmhnCLNA39a5JQWTKntnT4nQhpJIVvwq03G8utlCICWn36ifqowmfRaGwGJ+F+D4nHvXmSyM7X41klRB/4zFboyjOfH3tdtEmhsVgZydshbsGtjWp9kNcpOKFExjdNfNnkBzqDmZysucwmHLfK3YjaDgtRC23hosq4gTLBewUNN/J8/cADIuTG5eujUnLdxU+hIziTIrnj8KboggQR2mVKU5nI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af01ff3-0c97-4ab3-8fe5-08ddd9be2013
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:34:36.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asiVCZZmRIqSp1U1XvdCfwwZy0HkcFzahN0BB+XvpHN41u283qwWm9uPzHI4M/JPBsMRM5q7KMyoCEqVR/o4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120158
X-Proofpoint-GUID: QmgUF28GMI6mS5czjMehiCoSCxVJLnKq
X-Proofpoint-ORIG-GUID: QmgUF28GMI6mS5czjMehiCoSCxVJLnKq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1OCBTYWx0ZWRfX6EsBI42sM/7j
 P2HSWkepZ8K09fCBUns1Rg7tySyybwuZo0bFQ7P7vpWjTP58QlyCNQe1M22zJZKjSxXtiOX8zkZ
 6cc14pKUHinhh1AT7PO7ZmmWS9htMhQiGApvMCJSIasfaJZY2xVVzH33226e3Crn+giz24CzTQF
 qIMJKPgr4xqwG0i5qxAggINnE/X9rZqxxR1/053OfPLIbSCFaEgl3gzNWEUukZPw2TSnMwfvq3i
 D20aZDNItVMQlNpq19Fv82hTyGK7qkmgBf1c+NVVKlauXQZjjCn/1fz7szAjRXtbpujsIs3WZ+B
 P+zIMjAwKFAykGs2LgEOBuQ/XfFAaputiYou33u8L9RlWnfxm6azgIa0hYOHVmRFUQtirtYwK/c
 Mh8TTfpp5/qe6Z2N4xX5Cv+sH4Yux2j8UDOdXcVPM2txUg/DrmYNp5oB8ehA1yHnjDJI8Gy4
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689b6d23 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QqsDaGNXm2mk-8n34i8A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:47]:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  kernel/sys.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 1e28b40053ce..605f7fe9a143 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2392,9 +2392,9 @@ static inline unsigned long get_current_mdwe(void)
>  {
>  	unsigned long ret = 0;
>  
> -	if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +	if (mm_flags_test(MMF_HAS_MDWE, current->mm))
>  		ret |= PR_MDWE_REFUSE_EXEC_GAIN;
> -	if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
> +	if (mm_flags_test(MMF_HAS_MDWE_NO_INHERIT, current->mm))
>  		ret |= PR_MDWE_NO_INHERIT;
>  
>  	return ret;
> @@ -2427,9 +2427,9 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
>  		return -EPERM; /* Cannot unset the flags */
>  
>  	if (bits & PR_MDWE_NO_INHERIT)
> -		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
> +		mm_flags_set(MMF_HAS_MDWE_NO_INHERIT, current->mm);
>  	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
> -		set_bit(MMF_HAS_MDWE, &current->mm->flags);
> +		mm_flags_set(MMF_HAS_MDWE, current->mm);
>  
>  	return 0;
>  }
> @@ -2627,7 +2627,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  	case PR_GET_THP_DISABLE:
>  		if (arg2 || arg3 || arg4 || arg5)
>  			return -EINVAL;
> -		error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
> +		error = !!mm_flags_test(MMF_DISABLE_THP, me->mm);
>  		break;
>  	case PR_SET_THP_DISABLE:
>  		if (arg3 || arg4 || arg5)
> @@ -2635,9 +2635,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		if (mmap_write_lock_killable(me->mm))
>  			return -EINTR;
>  		if (arg2)
> -			set_bit(MMF_DISABLE_THP, &me->mm->flags);
> +			mm_flags_set(MMF_DISABLE_THP, me->mm);
>  		else
> -			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
> +			mm_flags_clear(MMF_DISABLE_THP, me->mm);
>  		mmap_write_unlock(me->mm);
>  		break;
>  	case PR_MPX_ENABLE_MANAGEMENT:
> @@ -2770,7 +2770,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		if (arg2 || arg3 || arg4 || arg5)
>  			return -EINVAL;
>  
> -		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
> +		error = !!mm_flags_test(MMF_VM_MERGE_ANY, me->mm);
>  		break;
>  #endif
>  	case PR_RISCV_V_SET_CONTROL:
> -- 
> 2.50.1
> 

