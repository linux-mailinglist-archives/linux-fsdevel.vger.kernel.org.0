Return-Path: <linux-fsdevel+bounces-64679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24CFBF0D98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA218A2A1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3084F2FBDE3;
	Mon, 20 Oct 2025 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mpzWDXpu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kGzqPqL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DD29B233;
	Mon, 20 Oct 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960005; cv=fail; b=sQxBVnfqOTI+Rw+FhdEtOcoKWet0+THOludUwby5E3xpFh3vOu2/zSqsqu3AoxCrjZEOckFd+USQGB80nQYHJOBzDMIByKWtk0yfO/pWSYAF5nbYkk+JNBfa3zI34PxXpzaAVeYtxldkIaY4m/wB2uDZSjSIzV2dgld6M7XyacU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960005; c=relaxed/simple;
	bh=gPP1v5GndP5FXb13HOdbN1a5CDv2g0Eh88b9fz/P8N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pAWPiQwvC35etc7vxbsl1zrhbBZuSIQ4QeHGqDUpoxpfThaqupw92YKSykVKFRSjU2sXgszYWTMCJ78X5tXaJGtx6U4nlIyytIhRhpIGKAItj3wPLJlLvnobN135MZd99wOjeR6850PKcDPFqjCtAPJVD4Mici+v3jgdThyBmh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mpzWDXpu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kGzqPqL+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SNDZ028368;
	Mon, 20 Oct 2025 11:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gPP1v5GndP5FXb13HO
	dbN1a5CDv2g0Eh88b9fz/P8N4=; b=mpzWDXpup9Vmyn8i+FpVganM66aLnnnFZV
	7KpzwtxABf8oQy9O8mrKMe1c4SmqU13oPatKgmw7EMan3K2CsZh6yZjZnY68HQz3
	lzTZRkqrhlniXQor672GBXciqGwMonRBqigrPZNI1qSM60ym+qGuGCVv2+sk91+/
	yQBl1NmCrt9ZXDvmIbK8a897jD1o+/eZRAi0JXK9pQaaLysIymuAniz5Rkl4bZNF
	KWxTE8o+q3mZsMN5G9pWgeYn1hylQOvSiVh6HIqAttn4fb9rakRvZZtAlyBfAPd6
	KvEtvMg8CSa1PF72VoI7Q4Lz9M8V7K045nnU5J+KtQdJ8tKHxRQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypt40y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 11:32:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KApiaO009393;
	Mon, 20 Oct 2025 11:32:32 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbuecj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 11:32:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVjORM+vCY3P4oOMnfLjC8slFhK5t1WVEVTYdZ+XyRAzmJdEsS90PbqsRkl00qgwkud2SQ4xZ9mPDMeGVZvlX/eORPyZpF0K+58kAG7w6kflT6BL89zTQfBMrgnIVwLfUKNoRRMe+CU9dXoW4stcnDBoBjf56hV0iH3+xtHhmpn/d4+E6dNjLxP3KPRh17++DNyA4WehPxk09GxR7TDLhpVx1Fx4d8B7nwBAxknO3RSWwBQlR2A2d1cHp9teRm2eEZqTsgM/Mc9jwdwlptW9f5YURUl63we7SgA9Fmj+2hXtgKC80aa2LIQ2A8gdQJzBu7RJ3KxvS34HOz4F3nycgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPP1v5GndP5FXb13HOdbN1a5CDv2g0Eh88b9fz/P8N4=;
 b=hLtEor9cNSInVT4sr6dcAOx+LLK/49I7S5AHognb7rT2O+46hBjK1tkgHpO48ODhPiOhZGTIxfqXM7NWcggO28l4kc5bdobyy+tkH2ehYXQmB/AvWksvcQNhfofsfwcoCu1/1pc3DncpkN7sp7c/VSkgfW6f5VtOI7e7BKPy3bAn/iUNEg0mBfuYyYfCgOvaCkZDPwx5A94aOcH7dGiHqq+JP4rqlJCRHKbqBGvo1yCV98Y1bcATXnIyzJo5hUeG7GjcKJLLsZEyY6QHXmWZCdulyQrFvLkH553DcbDxrNAfGiPABb+KqnEweXouYLnFiCLcqkXRUucJbuSzUtUrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPP1v5GndP5FXb13HOdbN1a5CDv2g0Eh88b9fz/P8N4=;
 b=kGzqPqL+tzAEfKa/8j4HFnz0jMZpvN2HalDqI4Sl2rPAnqqRxV6K869W3ho7iHEvyznzSi6rV7cvFKmEA729KgjEa0WpXPxxwyuBPJUall3FcZVsc+ma8nFaDZL8QICEEEYhD6JW+nPE/S6mRPIyn0LGV5NZcnVcrpXmMhijplA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 11:32:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 11:32:28 +0000
Date: Mon, 20 Oct 2025 12:32:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        minchan@kernel.org, david@redhat.com, Liam.Howlett@oracle.com,
        rppt@kernel.org, pfalcato@suse.de, kernel-team@android.com,
        android-mm@google.com, stable@vger.kernel.org,
        SeongJae Park <sj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
Message-ID: <e4af1a65-5ad0-45d4-a888-8a78090bc5db@lucifer.local>
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com>
 <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
 <098b030b-9d5a-4b1c-ab44-55bad474e70f@lucifer.local>
 <CAC_TJvct_KXyUuiO328MgrHnVPwvx995mEucvRPvNBa9zCekqw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJvct_KXyUuiO328MgrHnVPwvx995mEucvRPvNBa9zCekqw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 333c2dc0-0eb0-4ddc-c25b-08de0fcc595b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bLMivoWMTiQYYWBzN3FLxh0+XdrkpY8tUt1NMknz2YqCwI+2VPNUOLUQn3Be?=
 =?us-ascii?Q?FpuEEdqGXtfDHMyxbqxQNx50izJZhPKHQxjeot+irfVHX0eSEdIiASDD85+W?=
 =?us-ascii?Q?ptlPM22Yo0AWk8Ro9U8ymSr66zP4wFnLa16aTZ0wL1D/7XWUmRK27PSu9RwA?=
 =?us-ascii?Q?vbwZ9wm4Og1zGY+qJ/PNjt9DLhI88LitkdvezPpVwEgSbwHaV9tplmbo24Sd?=
 =?us-ascii?Q?hXeMEqJsYSidDDsOJfRKp96wHzneofAolyNjlI3jjYIG7ovVAi5jh6GZLzQt?=
 =?us-ascii?Q?r759XzY71m19piGHq3FVUETm51j2L5HO791twO++SXBEYf8lc7AxVZkynUXS?=
 =?us-ascii?Q?KViEwK3hgCPGolWf6xNJI3iZmVUTJ9Y7412dd2a+hpRSiBAJCu9QRS4hviRt?=
 =?us-ascii?Q?1+CA6ilWWGhwa9u2eFkONAFJ6ICmVxKIp6Wf8uYp5BF/+8e/VwONvGjOkU9b?=
 =?us-ascii?Q?DRnAQGMXnJezGNypmMKE+iBYPSvZrY76xy6uB9sicenNXBxJlOPiG1MOPbu1?=
 =?us-ascii?Q?OJ7WMa8NDxxd4FUXVYClIZWN6dyxiY2vHQGkQI6j4zS7er5Hhir/uK0+u9ci?=
 =?us-ascii?Q?CuG13da6a56q3REfCCkdySykabsZqD0/gDkgt2sstn0yY/wRHz0FyWQOM3uR?=
 =?us-ascii?Q?Dgj4WtGAsyRRinU5Eik34GY/64iIbxyDdjNV+sxcw9ftaM2dYovZ0czMR6MZ?=
 =?us-ascii?Q?BuyiFrzn0M6F/NuIvck2ueD+TCQFEOmZOJHNWhV3+/R32W3/iSwJP5+gcp7o?=
 =?us-ascii?Q?0U0S6RaYRKOYqwSmZQdmnkGw5cyEK3ifGT2zBsraJEMElOBR2ykTHRWr7rPb?=
 =?us-ascii?Q?bVEYDP+vl5R8aIRGgt8QlhT7+QxBXSJ4+g2aCENXO+E+6/2vFTo2juNs2Gem?=
 =?us-ascii?Q?+fU7aL9WgT3YkhneUJpn/nO2Gblqa0lnrZF36aX9/9WKgqYyWFopjVY3BizO?=
 =?us-ascii?Q?+cU+xC6XYFkD7rfb3S2EbW7d390PwCz6zwlIjGl+p67w7NrTu9Ed5laVVqva?=
 =?us-ascii?Q?4/Ct2x5LdDmtJdtG+QRqe/wMQ2D3euwPa775pV543qlLq+H7q1TADqotvmsv?=
 =?us-ascii?Q?9V6UhU/7MDBZtR+6ORPVKZ8Wj+9Oi7ap+rozAW9m97cAN6lQBd9c3mVbVVuj?=
 =?us-ascii?Q?DmfVtUC7gAaVpAZ9fkbuFHaeMjGYfEj7Z2y1rUqppezlHyMdDVM9VLQeXEZl?=
 =?us-ascii?Q?oU8xNnpe/glkz7Ut436x6ef3YEEVv6vFgVykSFtKFe2fFQgv+XfzYKInmejR?=
 =?us-ascii?Q?huLCrb4vexrfm7DUlpSJ9JrKkNPJlhq1I6sHjv3dEeTw4uW0MfvPV1QKlClG?=
 =?us-ascii?Q?KIpejiC7lPkV3r6xIcT3KXQ9uFZbvGRHPStPybAy7Lbl9k0Y3ZeyH7JNm5Dt?=
 =?us-ascii?Q?wvRRjs42bsWGBKyN/4A+VZxDVUw5UUd8HTmM/45mFvsBMBoCCXIHins9Imdb?=
 =?us-ascii?Q?f4LfjkH80/QfzMaf4WGHWxgntVO/Ivc2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rbtXr7w6JJkr+NG/uH6PaRup+JijAX8TTLF4SiEMlQZNdf5+f/xMQb83umbZ?=
 =?us-ascii?Q?JDnJNDHwIpCDWmxWRC2aZwB0sNU1XKt9qAGMtNBzxFb9bY7Vg90iUBoJfwd9?=
 =?us-ascii?Q?OeemhedaL0JoQUK2Q6OEazJeyUprPOsdHM4uqNWLGDHoP5w1Nu+gloMCnknR?=
 =?us-ascii?Q?3w+IGpNdiac2vRMcU0vbL+xsk9kY/P+y/EGnyQSJzVWSyhxgXW7N7goqawTI?=
 =?us-ascii?Q?EEZxchiKKTlq1vx7hnibDTbyJF1W0HkJNm0G+5ggA5tDI1Wu8W/spgs/IQyM?=
 =?us-ascii?Q?5ciQAZ9nEUE3bsoWV3FWVDMdyozh1r2eFN52O3S4T0g+9qAxbEueg6KXXmx7?=
 =?us-ascii?Q?iskOiou/tWF/bKjJwMc2n6RjJivqvIYxsUiGCqSpRyhVRGzqnhxnGxNv8An4?=
 =?us-ascii?Q?54PWnJYlj8B9UmDqCqUFseii6GiWzrMisd4wJZRHuYFjjk/mNpmY1p2NQGjl?=
 =?us-ascii?Q?qp3pzX7QOaBxWNjIThqJdlbbtAY3JbAC9nVa/5cpvO4X8548zOnp9N14JceI?=
 =?us-ascii?Q?eMjZqWs7hwhlMFAP+lqtwYESXg7hYmJh+V8QKko9k4PDJmBvzuoDF+yOax5w?=
 =?us-ascii?Q?o6OpiGK7Bx+vcUefnL7f2Q880ogTHVRBsnrEwzZF8Wka87ekpmbJnL4cugkA?=
 =?us-ascii?Q?xImuFQZopB8sYZqN1r32KP8wm9zOxPhfB0tVwE+vx1k943qxKtduXiRHB9Od?=
 =?us-ascii?Q?zzHzMwgvp+Ejz+thqoI5U5+2far1UW/siPIksb5YGSwXAlqlsla2Ox8518WE?=
 =?us-ascii?Q?6cFDh/BpdAS3+g4OtxPwht102rOnOYK0Ml1w+ZLWTRWhiupKwcwsehZawwMf?=
 =?us-ascii?Q?Ov8GytQovSlfEwZ9dH3e+m8HlVmIj990nlKPuwEse8aGwC+248aaFocDfzut?=
 =?us-ascii?Q?PQ7VYL7D+IyOlO4qn2Llv3fxAQuwS63+Bao2jYGjDMojtJco2Hx2+Ch38Y/H?=
 =?us-ascii?Q?ct3EeBqhVhC4wfUuAxHIRj3KSOK/wz6RDOmqgoATrw3uP0o76FB2I2PhcN93?=
 =?us-ascii?Q?nJ+YSvLNdrXV2x89Jk7UeAe36iAGEDHNCe9VPK6GRoCHoogFhBG6fryIdzaB?=
 =?us-ascii?Q?rVElpWdPl5/PAAix3f9uw4jfGkEVRW/0KYgRXkexa6F6dLcIIXOQTwC0wLZU?=
 =?us-ascii?Q?snkjifmzsU5057YJ/oYsegrzf7gZu5y/99X0Rw51riiv1rM8N0F5//GRtAaA?=
 =?us-ascii?Q?mGSGq4ly3Fi31HuLct7V7PhwLH40YhsjB63CZdrLZFSaBeBOxH3cS1YyKpV4?=
 =?us-ascii?Q?n06TB1VhSI9BBpaUgDNEQQZfA0dIk8ifHvciFG60DpaBlousLrvdF/ZHG8J2?=
 =?us-ascii?Q?TF+DkfaAdg6Olxz/Zpp/3m+0mNwmmkATGokrLLSnVBWNU76Ox9HVfl6yspVD?=
 =?us-ascii?Q?q7P62mOSiKH0QQ83r2ubfYg+p489oEHgYoUz1kH1KuCIeJWIQY8ge0N5bGiw?=
 =?us-ascii?Q?ltBgcWN+Nfu/e45tdgHJOiC6Ia9uNT5kGfsYD5aUuAHhQqUiFrZvmoUel78X?=
 =?us-ascii?Q?uXC/c3V6NaxSpsZ5VP5AHu0bDFnMkypLiH2Qw8QQw3GUAVNSlCiCqCxHW7P1?=
 =?us-ascii?Q?msyRfx9WIADXga2JXWPAj4+s5vnAhzvyotoWsjPNWWSs44KwX60j+aFL/MtM?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F+ny+3PLlGJIIVsp9G9Peuk6oE2zrnqgcssNY800hAV2PiQNuJIXjslKJ3Fjj35/gB6Jph5/hW5S+C5FlZNa6UDi3b1AkJvJA7MDATI8216HjB+BtWkgN5XsreXvo3K9c/w7XB2a0Ed4B5FGGZimU66YO9H/wdq+kkYq5d5eAGGlZqM504bb6G5LzxFdCYSuPqQWVSWOJ73UQ11vMMHUPKf+8QY5zGLvGlEKc/K3tD3pQUV9kPZW7kNAQHD1oPS069e1Lc9Ahb7jwXDasMkd/sm9NSJhTK9WjNx6zL9Tn1KONLdo5Gou/+nsjDcA+V7K1jkPrP3x0DHqJsflRF3h1mdUog4JbTBLPZtJEiPvW9MT6yZPY7Eda/fTBsFiBrhyfnjvLycQEXAFKbGbUiBActnmNW0xxy7iiT+gasT811zgsxT+rAMdyQL09S6xMoBCFYmG/OfSlk0sX+ta+tWODtQfp6SWfqxyr595DOml1qVuXoF0cwz3TmZ1B46PY5Hm8ROypzYrZFgC+aon66mUzRwDzPoADXSrmsXqh9lAnW93yFB8fhwTn4MjCUSHJLdih5Uv2uUkNgyQa1fgYHE9M2epaeP3QU5zwMvKfghSVuQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333c2dc0-0eb0-4ddc-c25b-08de0fcc595b
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 11:32:28.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHXTkn0ozv1AkLQQDzkUSzuqXjtZk5tc7oyx05Ee2ZH806TrFEQGO5et8reG0kvMipQglpXirW62byL0h94vaDWs9beWbHngShHy1oK0q/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=994 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200093
X-Proofpoint-GUID: do0ObVzZmvnyey1Z5fRPSkWg_MGuPuHO
X-Proofpoint-ORIG-GUID: do0ObVzZmvnyey1Z5fRPSkWg_MGuPuHO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX3TvQZ5Wc6p6L
 4FGzFZprvjTDMxal0nRxoN/yPNT00LN89n/XkSFgYw/4IdfrHfkXG0H9PWjr6rrSJNirFrni/RZ
 Bvhz1EwOrHdT2zSytMT7NCdXxTuMiPTN8ecOx3IT4Nmj9/xEFrXDcyNnnp4Lazped8dLf9LPPqx
 areZs0DXji5dPSsLmjDUFNCWM/Moe0DzIxw6Y2jegrDX2v4hd9cT+jdbicoRXiHqi7UO/9xwMEh
 nfJXd3dqgHQBpc6B5qW1pW5z3n69NwnpfmP4jpAi4GKnMFV4KQYfw2uOF03cX3w+qXziF5WNSfd
 jkByxDNYxGUixQZ/g5e9OpTED72I/y5MULPiaGnoqvCqPGeAtEm3zAcRKsqeAqfs1W8MOsxA4Ez
 Gxe0s9JcxJXOBc1olIY4fSKtkZP/kBt4BOGZN/CP9IT7iKVD4Js=
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=68f61dd1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=TZoiOLDRoPF9d9RrMksA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12092

On Fri, Oct 17, 2025 at 02:41:00PM -0700, Kalesh Singh wrote:
>
> Hi all,
>
> Thanks, Lorenzo, for the feedback and support.
>
> The consensus from the discussion appears to be:
>
> - Drop this patch keeping the existing check lenient, but make it more
> obvious and clear that this is the intended behavior.
> - Keep the vma_count_remaining() or another helper and abstracts away
> the direct use of the global sysctl_max_map_count.
> - Keep the rename of map_count to vma_count
> - Keep the selftest and tracepoint patches, which are important for
> documenting the behavior and providing observability.
>
> If there are no objections, I'll plan to send out a new version of the series.
>
> Thanks,
> Kalesh
>

Ack, sounds good!

