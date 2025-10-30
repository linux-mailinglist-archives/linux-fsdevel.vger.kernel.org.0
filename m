Return-Path: <linux-fsdevel+bounces-66481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20696C2085F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 333C24F1940
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A4C23EA9B;
	Thu, 30 Oct 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B77V2jvt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XqJPExoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70151A7AE3;
	Thu, 30 Oct 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833139; cv=fail; b=V12r51CLrQrQYSj8hLeUfKHbk6bUtYyex8mQdAkf+Sh42ALqddlJsJ0M/mYxm4XC3fbImRJ7PoMsAkqKxNEw3t0kySvwt6HE9WIX2vRvdcubgaUWrZklkMcxIl5woTvgIoPZa4dGR6vscLnNoqUHtUYuRA6i09wxbP7Gb0cRhxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833139; c=relaxed/simple;
	bh=XvJ0nYUyQ+Dz0CwLy3hAU6shnTmPvh3bR3++k2dhETA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDzyF6tTUA/UA2/fWsGS+eCySeBtWcAoVaTGRSXnSU4GjGgjcul66BC8998iX1ntFqED994Yc8tthKC7YYodLJFqpXqsrYneNWaCBx9g3VmzH9E4u+Y/mVkwr83ffU1Pjb7QSkICIvAFU1ImEgxaW68afz6vmGZUAz6uJQQPjjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B77V2jvt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XqJPExoJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDdcUw021505;
	Thu, 30 Oct 2025 14:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EY35vYgiJvngNLxGpT
	zFo28vZL57XQq7tFS7f1Qjax4=; b=B77V2jvtiiEvP2xIfypnFA7nrzN4WaTNv+
	ozvBlGDCLO0ab+mbhgiSlNJQ232sR5J5SzFUMOOIgGp/w2ji6uthWMeFkjjMllol
	wmEVfZEUhNYgSamyKzezmfVDCT/M+I8IFFNQWOSrV29/gkF0dwRXidvLAV/ntqqN
	CS6dyU0TTMnD175+QMI1SZE+nO4JA5XphTvoBETwNeUEqCQyTVSvqr1LpD66bcQk
	JN7AYGbHtvAsJAK/SmoP/myfelU4mUTX+dFS2U+Rg+aXZCaulzgmbLAXB/Qlfp19
	fxAz1jHECNqGiP3xkHEspU5FhJmkPVPzjl6RJ6TG5nXFm/BlhObA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a493er2kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 14:03:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCqf8Q034004;
	Thu, 30 Oct 2025 14:03:09 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34edd3at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 14:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlPE7EheHy3bSXWo6n7/l2fnqEFLbnbXt+wrzGEL93eyaJMdPLDjqC8TZ0shM9XgeOY/CefkPjr2rcHwhWqPpdNT+c+Pwc4c6dOVVkv1Dhd0G8/h8s1wt6xkxGexKpZyEu1vJLtodjdTGYq3EsWhmd/hkQxvy4zCnyI5hewrXvyRhSmNkIZY7FuJfaqIoD5Yk+tw4dj6m0C0BAR3rZwtI/Gye+Q+0qAcSH4Ry38hVIyjlCbuXWsBJcWrSk1glvauoDzrP/0ihNgXxJNqLrVJHRwq5quJwWDPJA5ENAK55VWatlDfGCglahYv2tmZZb+OSufPAqCXpOzL8QzMNg2gzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY35vYgiJvngNLxGpTzFo28vZL57XQq7tFS7f1Qjax4=;
 b=BU55Ctf8fHWPtNs+LDoQeGdZ6W1FenrEyNEFFMfq4gno3/0lLe11Vq9kECZhpCYif6PIbHAlWWWEcGusflveV2w7jBx0pvPTQ5VEON3swk3Q29jfgYqWAV+EoSN2QI/P9gF/vGGx+lfE/WmS4Rp0NS1WAod4gj4GYpBC1xVPXIJ5c0EK06iEhg49GQQ++CGgwIHU4SOw6OKB7Mb+5Gyq9PC3HuHf4g9mxbYLq3gLACM5Jj/B8KKkwNCoBVBT0hlUpHGbjCrghQXrl8C3zNuaGsSL4rKgFx57sLs6msorGkHmxVDmvfkxaeUhP2KBFQcB0VlkMH8UfIYOjv3CyyA/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY35vYgiJvngNLxGpTzFo28vZL57XQq7tFS7f1Qjax4=;
 b=XqJPExoJMu/chvyej0Vzcx1vixwnSkxFqyoMp8eypMwWtn6ZV1oFcRUIbJJHiZI3YOQaKBnXzbgsKRBZKBJ2aCNBSidJgwUMWLQA/LG4wwFer3vaxIsnM7E/F0dsvZNNWxegNC4s8hlONbctOzSggSg3Yjt++0BPJYQgUl/0ZE4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4230.namprd10.prod.outlook.com (2603:10b6:610:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:03:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 14:03:04 +0000
Date: Thu, 30 Oct 2025 14:03:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm: introduce and use VMA flag test helpers
Message-ID: <a7161d7d-7445-4015-8821-b32c469d6eaf@lucifer.local>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029192214.GT760669@ziepe.ca>
 <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>
 <20251030125234.GA1204670@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030125234.GA1204670@ziepe.ca>
X-ClientProxiedBy: LO6P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 505b854a-5390-4dfd-3ee4-08de17bd0b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FnbNXTgLdujUpx+8GP4mOTdM7Unac6gy9YCevJiYDUmDmmcCHcaqEhQgEfKM?=
 =?us-ascii?Q?l1cWF25+xRSxMhikbWZaqM4GknbHYjxjvtnI4vXeavvQjXeA4opWgL3z6yqk?=
 =?us-ascii?Q?rOHUguTUHhNBY3v6Ey0xtbt4jZGfgORrh5mkxOZAGuwZA6uFb1II2l3b40yG?=
 =?us-ascii?Q?GXT0K1KXiRxgoGIm08e/Wvu7MtGJDJB1LcOLnrqZdlgRZ0kCxBnLLzsLF7mk?=
 =?us-ascii?Q?PY4JgIWFXQOPGTfOPvYDn30xqX4VNpF28iBCi9QP3SiVRaELEgClys4Sd6FS?=
 =?us-ascii?Q?fNDmwWg33L4Xksy80K63nJuS8Dc1vdZrX6oZSOdsyGFc6FfagFLubZSnBMy/?=
 =?us-ascii?Q?CpPoMJjroIvLJLvyGuzA5QsoqGTZ8VEUPZvJL21GYabvaSadll6zUHLYtJ4n?=
 =?us-ascii?Q?BL5lb3bhgY0q16ES3aZJuzdvLwIcDBTO2FXtCnidTe6w/BrNnSKnwP6SiHc6?=
 =?us-ascii?Q?phTeEtjRuDNNqeWzsnQWbsDhfOOoh9OhV+d+ZqUV+u2jW0vM+ia2OFznXWHY?=
 =?us-ascii?Q?4IZwaJ+ZjzbdF6lyvqZSBhUivpVzilROq//Hz1TV/FO+jaBc+yKbRrvP8D5E?=
 =?us-ascii?Q?GdpHRlbnNMj/AEBN7h+4IMT11kMbgAoiki/TpVSfwBCvTcQsEKbI3tTKy9gf?=
 =?us-ascii?Q?nQafO/2Xh+eUm9LTaDu3fbdACsWHHUevrkkhaywkUW5efUePkOepTJf8xV0B?=
 =?us-ascii?Q?3EVVj3q6riv8PKJnOR0fKPLHqx3staWLht/zh48GELsQ1Iz8x/73xB362bUM?=
 =?us-ascii?Q?YrXGpao98vq0DsE9LuZTrfYTHwxrC4f4/EbRllgkJ/PTF99ZFZSn1mb0ZPJd?=
 =?us-ascii?Q?JbyRI5ZmfUQ1YkfreqQ7v8RcWiXvlAhBlTotSoPO3K0vipbsL3jNezJUZHQy?=
 =?us-ascii?Q?IMUIPqQGOiJYAuZuHeP4iKd95VmK7OCtN304BSJUsQu8VIt79zIewlhgWcep?=
 =?us-ascii?Q?Y0a/iBkNvGHUtrPKQeiJqwjFr8ftSx1kUAJ+pGcpghjkKVLPCcJj04XfSJi3?=
 =?us-ascii?Q?25qBSfHNsnWAQACexVwdSkBSsTLQYWX7gOQWeucVQ3yUQchM2JC44sBbobMn?=
 =?us-ascii?Q?1Ut21zXXKPxbtp3Txbrmbplo3DWtIriUJrIr0VGSROKjxKktOzOmzNH77M2z?=
 =?us-ascii?Q?suzj9P//bDDA3T46tdVXuF8mjmfWaj5vKr9pUbJ14YzZI0r96krVFhLkJKpR?=
 =?us-ascii?Q?AVqDGNd6fsaaO67ouDXqavmkXqVQ/LcQc40ELBA3ay3bO3DBVQblg4el4zm6?=
 =?us-ascii?Q?oLC11W/iYs7+bzyG0LtsPYHAu+rX6SR6G0NrwIPUA+kZzB3uYIvJwHUD/uis?=
 =?us-ascii?Q?vxpGt5x8yZLtrpO96N6Nhb7BmAdTnqzDmOPNPssMuVADVaPgB6f0ifOOW1EO?=
 =?us-ascii?Q?0KZGZxwIKmy3T1errITyNhOpFjlDJYAvOzcwMB0T5ualk9sjWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CPiiP8pEMWOwnE5tRvlPtxzfr+jG2YEUGosNhmszlMuYRl5AsyNE6ithMtMe?=
 =?us-ascii?Q?6DmDe7C7RcVLBgnks7bSIboSAsoNbpdIe4otmQ8De3voaUI7+Lf/WkiG6c5O?=
 =?us-ascii?Q?N+6PLYVkxfrPq3eKabe/cgUPVNvdWMl/FF2xYFr4zgYmknRvz7uiYs/XaaLi?=
 =?us-ascii?Q?lh34vLKpp0kXXeekaJQcIg6YcKhp8OkxlqHEodpb/FHpFz/9RINi93LYZ1Kk?=
 =?us-ascii?Q?w88vA+z8znQbYFTmgS6ffSibEY6j5u9gNzuye0jnLOjH1QwqoCpe0gYeeTCZ?=
 =?us-ascii?Q?cQQKzXc9qvATlGqzWO1yUJUGpV/k21wItslR53vWjGoLoSFmB7Ayi7mfSzI4?=
 =?us-ascii?Q?lpk9l6fjZGbLF1kZ2pZDLdgrh6+smIklqu2aIsJIym9uoN7aRLUWX8tHsthC?=
 =?us-ascii?Q?HjxeDfdt+M/2qL43yo9eScYF+4p+XSZSJlJ/0N6bZ25qp9VjwAFnGsy1ZcJY?=
 =?us-ascii?Q?t/5Sg6OsJ6Z4ZFcpbTduoj8rk8DrAUA2bn3KNSIHviTJPWRS1bNLkw3vjDZ7?=
 =?us-ascii?Q?h1Kln82CvDZeHgohkIrNSbXHxsfkrhCkJpUIjn4OL/5hK8YaDYiiSgfzCSZe?=
 =?us-ascii?Q?wIOfoxg5za758x+2/WeCa3tNIYc1v8vM77AdE4uva8EOgLlq2n2ovr0mXjow?=
 =?us-ascii?Q?qWmI0QcwyJgYcYYnAh2Lr1R/1O7/4n/gHGI5zYq6XsK726AUSymkElhqOa3r?=
 =?us-ascii?Q?VQXz399Cvj4XuKDwIYjW5y3zZfMh4xaoEjSt1nxdbOOOtuTqT+hWwtC/oimE?=
 =?us-ascii?Q?zP0yyy5KN97kkxCyTRb3gkEczs3EMEYyqurWUaFV4m5QgWQRZXOLGvKlgypG?=
 =?us-ascii?Q?SAchUdr1ygQWFuaVxmi2gwGkgeOyY5CM5AkHe8+kpc3maX+MlOQrzP9RgC2H?=
 =?us-ascii?Q?i0C2Zm98w3kXvrDUwHJWyeIUzlJrqbPuVe1LHzjWzlCNJ+4ecWc+1dPfNTSN?=
 =?us-ascii?Q?YuSju7tJRqxyw9DCA2RedR564YuNMaIL2HXPEwCq/vfLEoaDKZm9Nm2PjyAS?=
 =?us-ascii?Q?+OOYa/ILsGx6CwPOXNt2A576oASQ197yUontWNNosklSeUcehpZq3BF16Ujs?=
 =?us-ascii?Q?8TG8sEnhnOfpTZ0Pcm7l40Ibl5iE0VqMrP+jhfKZFIexkYE/qkWeHqGHLfdw?=
 =?us-ascii?Q?P/XaQI72mPAOZnB/bRXLTvjjfSUXOUmtt0/Q7jvHEgjMJ1wrH3PjVe3waame?=
 =?us-ascii?Q?6OS53eT7CmQNbQ4ZNvIUcWEJORx6yjLn3UbEq064Gp4DDe6j/qaViKMuOX08?=
 =?us-ascii?Q?0gh2SxrNa27CPmF8H/GaTPHhsHE7VL0619DMus3rISSSTdlnMclWxoaDmT9J?=
 =?us-ascii?Q?mcUAnYU4l5a106aJsyf8ZTrlNpakd06TFt97hRFslcQB4uI7uTr4eyUWnWdB?=
 =?us-ascii?Q?KQUXmAZLZte2g26sRZxI1R5U22tfVZ0dRAJ8Mn3mgM9UVZcSuGTjBlGj1yN8?=
 =?us-ascii?Q?Iy14NZeZK/K4HISYza2OwT4K/i2uUa8uKjoYZgIdRRQ3tp20YrmpmkSAeARL?=
 =?us-ascii?Q?FfautsAoIyMVUbsp0NRbkXafGnEh/ZZknM7r04Bx367GKywee9bORF/cWjh2?=
 =?us-ascii?Q?AKQHThBQxUhCUr9TOoeZfH3bAYAZVhdUbcA05slPLMkLdaK1MUkvlaJqRYd5?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QiELdRqTDkIeu65O6p35zr3UscrTSkmB0LXmrkGwFa9mpy0QwKgm8CnwZmz9T73bBiAejXM8TsTRkgHtRbceOA7Sf4yr/PB7csBAQ7EqQnvShPbjA2evXiUR1ORI7/weOxAMntW6fvK2jiiK13+heUEj0/D/yvtIAGj/j9SA4XMt+MT20o0waA7IYnL+H26IwHCUjyApRDFHTqF6uigXh760ygiMhoeI9p6jFv0zLKhiFA00cRrYn+k9EJXLCbM5fCfilcmWFdyhByp4OWckLNeXniWO0hmeZDVe4WyqOYyxam/gFnDsAlGsUsP5n1nxvCMSXd6KllKI72gpnKgKdwIxOPAX9mQN042SKrsIi+axxawXNuJyRcdf/RSa2Fttv1xyF1a+tCII8idqa2D4yAL0FVkRHkH/1sFo10+yJ4ym0pKdLeb3vnd+3uSmH6ZS8/KIqvU74XGv87YyywSyTaFRIPc7Q1SNqnw+jef84iNXdMayBk8fe4QTp2QzbxYk7dTrXl+vwqoyfBtS4bE/rELq4FwOvXJMCFhK2rG4oPXjBErXmZjm46xASLTnVBq7BVNZoZ5H7R3c198/g9v9QVcaf1N1g113SocST5/g5U8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505b854a-5390-4dfd-3ee4-08de17bd0b97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:03:04.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CwfLg08O9zHzq7d+dL3ymZuCrBLNB/Kb45NJiI7gIJEzrqgGw5mjDcPQQUWEAGKJY8Fh5aHohcHLkaexuSmN7YpxUVBIFI+yFDMX0waWmoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300114
X-Proofpoint-ORIG-GUID: U7oqCSUtxr-nTT2VZFzp8rlBP9h4v1-E
X-Proofpoint-GUID: U7oqCSUtxr-nTT2VZFzp8rlBP9h4v1-E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDExMSBTYWx0ZWRfXz9YiD9xl4iwa
 vavSKUj3kDCfvhcdchRFSaJqEe5QnUCmSC5RH1Q7vNoEmS+KytPQ15d/AWgKLD4ruMhqrz6qfXA
 oYFhe0Y8g8DUBAo8F5Iku1RzaV29SuJWvAwt8Zjei2URVf/eKmPBpKXVc/FTLuAyU5TsYiUgJx0
 15qKjM+BPiCwV9OK2RYDym44jKy+BzU1VdXQMd4WVTBbbYgJcmSNuw06vXVGUlgo9Qv0Zorn5L+
 d8BKcFRXSO37hQIySvvNAr0OFegNfG/IuRWHgV2qcmbbmIwMd1g701Aqvm6mnmO6+OfYyL70SMb
 h+L2/FVe5ZmgBw6aa/RZOmVa5gFD/ydz9+cjUyFXtyMILgKdMJFK2yykrN3gLlGNtFOy7FU9xKD
 De6gBRX2IAWz6r0WdfdUusW1a861jaKd52fmvUNhWJv9KO/z26s=
X-Authority-Analysis: v=2.4 cv=Jsf8bc4C c=1 sm=1 tr=0 ts=6903701d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PeOOapuUAAAA:8 a=7Y-qsnt7Fx2XEZFZPioA:9 a=CjuIK1q_8ugA:10
 a=0BaqRfgCL6CLbWgV2pdm:22 cc=ntf awl=host:13657

On Thu, Oct 30, 2025 at 09:52:34AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 30, 2025 at 10:04:31AM +0000, Lorenzo Stoakes wrote:
> > It may also just be sensible to drop the vma_test() since I've named VMA flags
> > vma->flags which is kinda neat and not so painful to do:
> >
> > 	if (vma_flags_test(&vma->flags, VMA_READ_BIT)) {
> > 	}
> >
> > Another note - I do hope to drop the _BIT at some point. But it felt egregious
> > to do so _now_ since VM_READ, VMA_READ are so close it'd be _super_ easy to
> > mistake the two.
>
> Yes, you should have the bit until the non-bit versions are removed
> entirely.
>
> > Buuut I'm guessing actually you're thinking more of getting rid of
> > vm_flags_word_[and, any, all]() all of which take VM_xxx parameters.
>
> Yes
>
> > > few instructions.
> > >
> >
> > Well I'm not sure, hopefully. Maybe I need to test this and see exactly what the
> > it comes up with.
> >
> > I mean you could in theory have:
> >
> > vma_flags_any(&vma->flags, OR_VMA_FLAGS(VMA_PFNMAP_BIT, VMA_SEALED_BIT))
>
> 'any' here means any of the given bits set, yes? So the operation is
>
> (flags & to_test) != 0

Yeah sorry, you're right. nd __bitmap_and() for BITS_PER_LONG aligned bitmap
size (which it always will be) amoutns to:

	for (k = 0; k < lim; k++)
		result |= (dst[k] = bitmap1[k] & bitmap2[k]);

So yeah... ok interesting.

>
> Which is bitmap_and, not or. In this case the compiler goes word by
> word:

Yeah indeed.

>
>   flags[0] & to_test[0] != 0
>   flags[1] & to_test[1] != 0
>
> And constant propagation turns it into
>   flags[1] & 0 != 0 ----> 0
>
> So the extra word just disappears.

Hmm on the assumption that we can construct a vma_flags_t that the compiler
knows to be constant... I wonder if:

int to_test[2];

to_test[0] |= 1 << SOME_CONST;
to_test[1] |= 1 << ANOTHER_CONST;

flags[0] & to_test[0]
flags[1] & to_test[1]

Will propagate like this.

But enough theory... I godbolt'd it and https://godbolt.org/z/8PW6PzK1f

Well knock me down with a feather modern compilers _are_ clever enough :)

I have underestimated this...

>
> Similarly if you want to do a set bit using or
>
>   flags[0] = flags[0] | to_set[0]
>   flags[1] = flags[1] | to_set[1]
>
> And again constant propagation
>   flags[1] = flags[1] | 0 ------>  NOP
>
> > I feel like we're going to need the 'special first word' stuff permanently for
> > performance reasons.
>
> I think not, look above..

No, this is quite interesting then, I was concerned about this!

>
> > > Then everything only works with _BIT and we don't have the special
> > > first word situation.
> >
> > In any case we still need to maintain the word stuff for legacy purposes at
> > least to handle the existing vm_flags_*() interfaces until the work is complete.
>
> I think it will be hard to sustain this idea that some operations do
> not work on the bits in the second word, it is just not very natural
> going forward..

Yeah of course it's far from ideal.

>
> So I'd try to structure things to remove the non-BIT users before
> adding multi-word..

Yeah, OK well your point has been made here, the compiler _is_ smart enough
to save us here :)

Let's avoid this first word stuff altogether then.

>
> Jason

Cheers, Lorenzo

