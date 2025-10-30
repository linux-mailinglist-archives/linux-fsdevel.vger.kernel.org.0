Return-Path: <linux-fsdevel+bounces-66439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BA3C1F313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29DE84E8DEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5702340A52;
	Thu, 30 Oct 2025 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZKTOc2E8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A/vJSnro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973233EAE0;
	Thu, 30 Oct 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815321; cv=fail; b=Rt0IkhaxSI9o1zmjdP466yHIrxt5M8bvWHCdlZqHLx3y5Knds28jdCtTwPhmDtFRQKW3q0toHVAWenzZ0WtEd2Tt5GeVboOA+55aZqk9Gw0quL7KgXaaoIM8Ib5WVRFT9gezo0l9MWCdw4RmRfA/+mwjmoGCPKnDP8/FWcQZ8NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815321; c=relaxed/simple;
	bh=parUFrrnFHagnOUyK70w/608XqQZBcbY9hlvpekwyLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OVsYaCWRkEQduwyeJm3Qv0D2YDJ/nZKpXzTp0je+CiYuoWp+drJCKlQsSU6QgVmaV0q+VMnad+oFPRRLmHfe13cXzEyvq4kRriuYTfgl9px2SHVbZMf/1ne3KMY6kRXfIfDRtmzPpMSpdBLq4NkteAjk+X0sS+i7taI5gdGLFR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZKTOc2E8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A/vJSnro; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U7gf2r019510;
	Thu, 30 Oct 2025 09:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8AcmwiB7AdIMeYa7SG
	94VGcwkmjYah57SGP7Yaqu1Zg=; b=ZKTOc2E8GVYp4AwRnsoX0fvLiF3uCIWwVN
	ED0+5KafY3sP/zbx2BqC2Z1BIcX6b5XrjQ5IE/VGpTHkyCoDtBXTjRCwKA8Rrehv
	e3WhKIjcU2PrPcLsvgBg10oL34W+FzJp7t2abM1X6emgLoRvjgLnhRIaa8eetgzX
	msLilGoT7wnJJ2K6PZjoGPqmQQUOacGxrY7cm6/UrIqGb01UzMyZZuTD1v00vjzx
	8j86tJnArZFojPMwQM+B8rGIk5HmomD6FrxAeJM2RVQuq8RtN2qEiN2hta9XwmmL
	aKKLwDYT/KJqudtYimxSMRU+Aq/7mkKyNIR1tpz09c11JT+9qzIg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a429frc0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 09:07:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59U7Tkf5021032;
	Thu, 30 Oct 2025 09:07:28 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359v11sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 09:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXRbwdYRvXD+criua6ZSObzbU535OmL3UNCRFK7kw+FT13++0HJYTGHtKplYrmuxRBPFqADYx4b9a8OtSIhuXxYHJVQiPsEJHsdddoatmxmaW1UpJ8i3j7R23X+xbxLvrGKyxeXXVQJ3+jJwlqhPdbsqNQqbnzbxywZshs8+qMT23Mu2wPJX+FNEgpLCwj6VJMxiXxReCOx4lseFQTFDBJLzzTMgpi6/9AERPrbbWirBQOtFD1DZ3YNGgBbP7XDt5ku3gTrYBRTMQ/STY58/c1jm/p4vcSMBhtSvc+4erBLm8Rhi7iG/TTcSxX3fEseQCL5adwGMUJr6S54QrNSMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AcmwiB7AdIMeYa7SG94VGcwkmjYah57SGP7Yaqu1Zg=;
 b=N8tb0POpsEHqDA+ya/A2ypvjE1nlzysKbWPwl1DbHFGwiT6f0LjJc/W+5n0DxL2GDk8wTYwvBLO2TnbvoSWqiPQRwD7T5d4cT+Q2+6s/vh7enZPuhwTkQa6z/+2TdL9QddIIWTd/F+dtV0LfJvoMEozmo2hJbiqBRwF0Pv4SCjHHnUT33rZwxMSGEPLLk7RpKo/P1/NhFsPDralbDKr+ExVEpJoAL4GlgyY50Hql53thcE+gBppfqNBtPv1hRe9X/Knz9uyPkyhMnd1NX6QgcnPt+XuxhRueNe//FY+oW+2DqKSGr4OgStjeqXEqD1e0Nwj7CQk762wMD1RGyyFSpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AcmwiB7AdIMeYa7SG94VGcwkmjYah57SGP7Yaqu1Zg=;
 b=A/vJSnroEiU/bwWuwjiGfeKOTfZ/r15wfkbTtyS9Z0piN3EaIPhGuW6W5bdZeqedrvjcOs7u5bpSTfoGBoVUYTFFRAbmoq6bXRqKaLGzOG1hCDyA5y9bz+OwL50xD2Of7FOyFdkE/Wfh6FvvOpyUdBRjEhBJk3WM6FJV3cAz2/Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF7F0BE85A1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:07:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 09:07:22 +0000
Date: Thu, 30 Oct 2025 09:07:19 +0000
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
Subject: Re: [PATCH 1/4] mm: declare VMA flags by bit
Message-ID: <f1d67c7b-5e08-43b3-b98c-8a35a5095052@lucifer.local>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029190228.GS760669@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029190228.GS760669@ziepe.ca>
X-ClientProxiedBy: LO4P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF7F0BE85A1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aad6ed5-b768-485e-c24e-08de1793bc85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yf+rPWSl8WubeH3bJmm11LO1+hY4TIRy1HGlt0f7zManLmwHACXDlXvHVGmk?=
 =?us-ascii?Q?pbLoMMJWHK7RMnYFPJZltNzd2BQRJCoTzSh6HmTbtm67topLz8WdQRupG7ld?=
 =?us-ascii?Q?bCO1ne8iuO283pc5pD8a3XqoQP5U69CSvvqHKJtGzUfKPTrHX6ORFXxge898?=
 =?us-ascii?Q?Ap3+BkAb5MhLLGhBcjXnXviNAvLKJSrFW945+l4CYc482rS4Uo8DbKt1l16J?=
 =?us-ascii?Q?XHicOtuaJhzls44y4syuLUP8h4x5rkuxxqyezWhDjrjTXVacfS9KZR58MIkM?=
 =?us-ascii?Q?tsHgQ4oTRmhRPUwfBNcCZFegWmtItqhp+YxTS2gaBqI8QwKuw/WElrUxESYj?=
 =?us-ascii?Q?lG6KoIwuKQjMLCdGHqDwl8TwAhvsLgyG5GiyA4xnuRQYzq+AfwD1vRhhWagC?=
 =?us-ascii?Q?mdUX6282ZyuMbx6feVe8f2DvyG70SE5BVDpZjsZLFvva9Ah+ZSbMXQX0ZIRH?=
 =?us-ascii?Q?W9OmORP5YB6VsD3lWXSYuX0D4cgkniwtEo0Ja4eN3/SKZ04LsLj2/gQ+lZEC?=
 =?us-ascii?Q?noPx3Hdg1d6x0T0DB8N18kT+HvD8CmD6a1OxYD9asKbSx2yCJFJ+oNcOrNBE?=
 =?us-ascii?Q?qtO9UpYsalsdRCKYiognR4UwPys8qKDREseHOYmnFkQiQBR9vWy/FmOvhd42?=
 =?us-ascii?Q?fCuK9FBo8EMet8SSECkC1/U+wibeGZdq82z3x03xFDJmxOdiKHudAv5Zg2di?=
 =?us-ascii?Q?VDSRkpInycNbr24orzv7DumshsEtFmHRFaSjHCo333NxYnJ1KfN1KEEbEnqJ?=
 =?us-ascii?Q?qQh2TSNP/aoznxoVQfQLAOzLS45KMKXH1/kO4Inlj9KD72h08sI+7DZphxEP?=
 =?us-ascii?Q?uM/qqC2WdWf+QO47XgRIqnurV+Cr83lwnWnT6oroUwma1YExUi59gQl9ZYml?=
 =?us-ascii?Q?PJKSTXDEjJ8wzgEJoqoJDOZaOD8w9oYrpjfQs4zRcVZr5lptmAg5/SAl6DGc?=
 =?us-ascii?Q?ly5OQCqzEWOndfoauG8ZJWNFRTJdLS34F41+R2+ghV9eEyzwhi1p8e+/5qw/?=
 =?us-ascii?Q?dIqgkEHcQ0gOLCP9qmXlchm5SvCaNrdG0omMMFnTO0Avx2YBuZjGNURAX4Aw?=
 =?us-ascii?Q?YMETNO2zhr7nn32OPVwVE343L7kCkzo0QLuaElwr1gOHFkpsCxP3cNutYJLt?=
 =?us-ascii?Q?9HZzxCxtF/0PyJh6ImNmJ9YR2rVGVB2sLnY9mGH1rGpvJj80Qlp49iPi0JA7?=
 =?us-ascii?Q?BERVuzMgsXb4MabOF/h0EFpiQiA7yXIRxKsVgwkC5cgWVJYFiAz2SM3DNV+C?=
 =?us-ascii?Q?XyhXfgGrh/+wkOfrklj+EYq7NCOZDHrSoa6rePQVLaSi2KInFhKy5a8uqF9d?=
 =?us-ascii?Q?CCFHKGw6lbIz3R2EfR64zDrf3SrVvCqtMb9Wga/j0BxupQponBJYSh6eb0Cu?=
 =?us-ascii?Q?cwRSxNXY4QJbW9XNpfNX8t8DdhBwNnm/YyPCQ9R7HEF66sls2zM+O/8QYFXM?=
 =?us-ascii?Q?1ULSYP8XWlNVob6wFtFo4c1JCpSEK4LvCgWDtlNZmD9myQ8Drr3uIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NgqABGlCRe0Uq6wjHiBkAFhcT46kDPvs6ynZGNacNHD7ja3Lx89N42RjMvQX?=
 =?us-ascii?Q?PMmgi2h8JYyrMsKLERpC9Ewg7vcbvOHfmo5CR4D8jrOAhSNuhMZpal7zkd8a?=
 =?us-ascii?Q?JHjO4I9nUNHdteMh+AW6+6hC2Ebv8bwNFi7Tbl8pHAQAQ+ZQ3pGnI8CWeXPB?=
 =?us-ascii?Q?w/kYZkAj+Uj5H0XDGhvvsmfHQAaM/8oJ0ULe2lx1v+SQKYzzTV45DanCWdMu?=
 =?us-ascii?Q?JOH5QNfNvMObf2oCu7GAwQTsNeta4T/Gct8a7+v8FRxbLGitVqI8c4dYneyq?=
 =?us-ascii?Q?ZPgJu++6P1fyojcbox8SP0X7As5c6FZZk8J2NYD+pK9TWW5DFjzSqPcg6hdY?=
 =?us-ascii?Q?mpwTou7A6YitmZe7KFNLCFyVyOZxMoql91nIp+BeNKihrgN3WCLcROHzxDi3?=
 =?us-ascii?Q?64LwC6iKlN6Ao5jOOzIBDMwzi8kNq6CT5SngfJcDPFt1L2Ys7f/4RrAHf08X?=
 =?us-ascii?Q?NMzk6CjaUeKunf2TWaAW3xkmKzguSWKXV1bRlQyEiSBa4bJj013h7mO7sFNW?=
 =?us-ascii?Q?9XCLQNQPNv2WawtYSRKhHW3z8dEauLEehLLOBLNAAQiQF6rhJhj0y23fT/JV?=
 =?us-ascii?Q?JOJR8qgr7muyrr13dzvydSWXyhEftt44F01q1QSA1bZE5VpVLvA7veXy8MiE?=
 =?us-ascii?Q?tdr/Xo4M6uVqrTXXY8ku5HjoKefzErBGr4VKX3KhJ0HO3QKqP54BJ3Jao+LD?=
 =?us-ascii?Q?GYQLIX2wZO7BCmSZgpbXBHaHDpndPohoEG1yXyfWGFh8n2Rbyo9amr/8zJph?=
 =?us-ascii?Q?oNegbg5MzISr+erExdLWaUls0QDl7LXgjM5ln6gyb74sLOEe7Qmnp3qfaRDI?=
 =?us-ascii?Q?HSHINgWfZyqJUDnGWheseSD6tLAaAODdDrPizbHqHDRpCv+jVyZ8BvLxVUSP?=
 =?us-ascii?Q?bUHUIgdf1QL/cyBfJ0oujHupVbco6rO/RxGcpQc9dTwCtFV5vYDcsMg+/hbg?=
 =?us-ascii?Q?WTrhw9pajhnTIaNGnGfEfcpaGkHSBKLN9irKuLN5MRhFatAjfn9IcKNnTj0T?=
 =?us-ascii?Q?LYfMJNFlei99e/OJffYwd3/xvWEsoP5qe8AR4zLKK0o/Y9QwozF8I2LMqiAX?=
 =?us-ascii?Q?cSU8V09mpMkvIB3dhQrnLKordRfTRjmViEWgQYw4DzcI6remPeS6sv1CDOOk?=
 =?us-ascii?Q?xi5shTG4pNDzhRozT6taVjKpuXZ1vHaJmQBOiUwNAB8SaicnD6btkWKlI4Ei?=
 =?us-ascii?Q?EdH61Pn0Oiqb9TV80e/tlrd1LCXVYT3bVnRpqugPj1KZu/rAriwjljb2e0Rg?=
 =?us-ascii?Q?0A+CvMxckNnw0EIDvMFBcgN2ExyV5e7Zj2con3S+YZSrRszZaiQ85DTWezpT?=
 =?us-ascii?Q?FZ8rCbhtorfawBEiVp4ISpVqZsyGvjTf0cGT/u2ijgw2J+B3mLoois46I1sd?=
 =?us-ascii?Q?3zNKSIqROj4d0wud0YPcueP1yXRK12o3cUNCWhpxbukm8r9pHUNAezSqXgTp?=
 =?us-ascii?Q?lNKaydgxByCNzuNrK66hfHhH5+yfYm0nqkDy/eIHZV93rgNBknR8S7+JpHUL?=
 =?us-ascii?Q?SPEtgHUQz0rJadEV/F2759m5WDZaKKAD+KGhoB0dTCSqGMxovqTKRDwT3avf?=
 =?us-ascii?Q?/aVskwy8GwplVrnzqoC5MC9mQl1R9S8UXEEJzvYFBnmN46l4beR6zb3WsnBz?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XZEtuT/YMzNf4WriFwzPOaBZtx0K1Sma36urgqGAPfMtrF2E+mxE1gHr4NmevosnVQvBfnf/T0jXvJG2Fvl7VOhxlsidmyczXw/jwISRMIa+4tXbW2gsE/mcR9R/w3esFy/43Tn4F1qouoD7j4VkVWNotxJuhdhkxzH/y7eaDfFNwQl5dBG7AAs/00oxs7dauZ2cUccdwik8sDdnDvwXtxPtdfpzlrbEdhpOTHvZtPkRaCFv9EKxm4Q9+RaIMjuSMlf+5npuprRWWhTVSGlfFnpeZFlq+hjr3Y4Qn9XtthvwHWIR4Q6xIB8f8AoceltEAAMHM+tq1O+T2QLof40N/LBcJUFnWYsWDuvGbkyRH1R4z3umH+Eph7B4hci5GjguYaedfjHTRn3+FLxgOq6IwmNJ68BHuQXpGU8P+RTkcjaacJpzhat/GYUx1WgRCMsQ8rgQXngXU4A+4kjBcdvwNgaI5+DhsqMil2/aKZlgIYvaF3SXXIOGqklS2OkicfvOTtaBErcRfXBCTDfyZ57ruAOoIpXTj4kn3RQrkL3irKkV1k/bfIMAS6IJn/xPAM9vXSqEze2AAdDrAsaQzC/cry57SuD/KjAOBl9vkyb0rGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aad6ed5-b768-485e-c24e-08de1793bc85
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:07:22.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkBtNARDHy8pgknskrqc8uoE5qO9UbGdytAhu+HZZ6Bp6yl4u4T8T4tdeAs0P3CKySGUFz6+zDB1Psh8FhoZaidQY5RD/Z1Un2QVNo782Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7F0BE85A1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510300073
X-Proofpoint-GUID: xSLMX8rQSem_HDebhLaArkPrUaCyL11D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA0NiBTYWx0ZWRfX14fZovrAl3or
 7iWkbHpNV0lLdx/NTprppZIUK87uG03jeFHTj5XXSQ/wqdGDaXnjDDPpombIlOL8ORLw2r+070U
 MWF223tXrmI7qtTtCfxvXCXwxiDJNfFgbsFz+WeVxQVPUTUwRoMI77aS+CLwD5GfM6I80RhcvPZ
 /fX1Vq+xN7n4KPX96dJtRQrRx2RgE5T5K3uOeSFQe8BXUA7qVmvPjbnl5rkfKATmOZs26X4hRlY
 LD0yYgCvDteBig5zo6w0ImptTu5ToIH64HvlkIJ1uBKJp9oYcHpUrb8OcdjDuH1E5MbdI2nAcFM
 fvk2hCt1ekMXm6ZwjFSVr2aj+zKpnZFRQ07wJl+Pbxth4kWia3XPFjdG1fjL1L1PU+AK44bNtuT
 Vnlrh45Qv39uXOG2QVzu1nnBkttLLSEq1cWkerpm+4to+QA/+Wo=
X-Authority-Analysis: v=2.4 cv=Xun3+FF9 c=1 sm=1 tr=0 ts=69032ad1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=La1Q5_V0PeIA9EJ-WAQA:9 a=CjuIK1q_8ugA:10
 a=tZGO6t36mcQA:10 cc=ntf awl=host:12123
X-Proofpoint-ORIG-GUID: xSLMX8rQSem_HDebhLaArkPrUaCyL11D

On Wed, Oct 29, 2025 at 04:02:28PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 29, 2025 at 05:49:35PM +0000, Lorenzo Stoakes wrote:
> > We declare a sparse-bitwise type vma_flag_t which ensures that users can't
> > pass around invalid VMA flags by accident and prepares for future work
> > towards VMA flags being a bitmap where we want to ensure bit values are
> > type safe.
>
> Does sparse attach the type to the enum item? Normal C says the enum
> item's type is always 'int' if the value fits in int..

It does, have tested this, not sure if due to sparse doing extra work to
make that happen or GNU C doing more there.

You can see an anon enum being used for this in the examples in the sparse
docs for instance (see [0]) so it's kind of a 'thing' it seems.

I also tested this to make sure, when intentionally passing some non-flag
value to the functions which accept vma_flag_t and it got picked up right
away, checked via:

make C=2 -j $(nproc) 2>&1 | grep vma_flag_t

[0]:https://docs.kernel.org/dev-tools/sparse.html

>
> And I'm not sure bitwise rules work quite the way you'd like for this
> enum, it was ment for things that are |'d..
>
> I have seen an agressively abuse-resistent technique before, I don't
> really recommend it, but FYI:
>
> struct vma_bits {
>   u8 VMA_READ_BIT;
>   u8 VMA_WRITE_BIT;
>   ..
> };
> #define VMA_BIT(bit_name) BIT(offsetof(struct vma_bits, bit_name))

Oh my eyes! :P I mean kinda clever but also lord above :)

I don't think we need this afaict. The idea is to catch accidental
instances of e.g.:

	vma_test(vma, VM_WRITE);

Rather than abuse. Doing the above is _very easy_ and so I wanted to
explicitly have the bots moan if people make this mistake.

If only C had a stronger type system...

>
> > Finally, we have to update some rather silly if-deffery found in
> > mm/task_mmu.c which would otherwise break.
> >
> > Additionally, update the VMA userland testing vma_internal.h header to
> > include these changes.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  fs/proc/task_mmu.c               |   4 +-
> >  include/linux/mm.h               | 286 +++++++++++++++++---------
> >  tools/testing/vma/vma_internal.h | 341 +++++++++++++++++++++++++++----
>
> Maybe take the moment to put them in some vma_flags.h and then can
> that be included from tools/testing to avoid this copying??

It sucks to have this copy/paste yeah. The problem is to make the VMA
userland testing work, we intentionally isolate vma.h/vma.c dependencies
into vma_internal.h in mm/ and also do the same in the userland component,
so we can #include vma.c/h in the userland code.

So we'd have to have a strict requirement that vma_flags.h doesn't import
any other headers or at least none which aren't substituted somehow in the
tools/include directory.

The issue is people might quite reasonably update include/linux/vma_flags.h
to do more later and then break all of the VMA userland testing...

It's a bit of a delicate thing to keep it all

>
> > +/**
> > + * vma_flag_t - specifies an individual VMA flag by bit number.
> > + *
> > + * This value is made type safe by sparse to avoid passing invalid flag values
> > + * around.
> > + */
> > +typedef int __bitwise vma_flag_t;
> > +
> > +enum {
> > +	/* currently active flags */
> > +	VMA_READ_BIT = (__force vma_flag_t)0,
> > +	VMA_WRITE_BIT = (__force vma_flag_t)1,
> > +	VMA_EXEC_BIT = (__force vma_flag_t)2,
> > +	VMA_SHARED_BIT = (__force vma_flag_t)3,
> > +
> > +	/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
> > +	VMA_MAYREAD_BIT = (__force vma_flag_t)4, /* limits for mprotect() etc */
> > +	VMA_MAYWRITE_BIT = (__force vma_flag_t)5,
> > +	VMA_MAYEXEC_BIT = (__force vma_flag_t)6,
> > +	VMA_MAYSHARE_BIT = (__force vma_flag_t)7,
> > +
> > +	VMA_GROWSDOWN_BIT = (__force vma_flag_t)8, /* general info on the segment */
> > +#ifdef CONFIG_MMU
> > +	VMA_UFFD_MISSING_BIT = (__force vma_flag_t)9, /* missing pages tracking */
> > +#else
> > +	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
> > +	VMA_MAYOVERLAY_BIT = (__force vma_flag_t)9,
> > +#endif
> > +	/* Page-ranges managed without "struct page", just pure PFN */
> > +	VMA_PFNMAP_BIT = (__force vma_flag_t)10,
> > +
> > +	VMA_MAYBE_GUARD_BIT = (__force vma_flag_t)11,
> > +
> > +	VMA_UFFD_WP_BIT = (__force vma_flag_t)12, /* wrprotect pages tracking */
> > +
> > +	VMA_LOCKED_BIT = (__force vma_flag_t)13,
> > +	VMA_IO_BIT = (__force vma_flag_t)14, /* Memory mapped I/O or similar */
> > +
> > +	/* Used by madvise() */
> > +	VMA_SEQ_READ_BIT = (__force vma_flag_t)15, /* App will access data sequentially */
> > +	VMA_RAND_READ_BIT = (__force vma_flag_t)16, /* App will not benefit from clustered reads */
> > +
> > +	VMA_DONTCOPY_BIT = (__force vma_flag_t)17, /* Do not copy this vma on fork */
> > +	VMA_DONTEXPAND_BIT = (__force vma_flag_t)18, /* Cannot expand with mremap() */
> > +	VMA_LOCKONFAULT_BIT = (__force vma_flag_t)19, /* Lock pages covered when faulted in */
> > +	VMA_ACCOUNT_BIT = (__force vma_flag_t)20, /* Is a VM accounted object */
> > +	VMA_NORESERVE_BIT = (__force vma_flag_t)21, /* should the VM suppress accounting */
> > +	VMA_HUGETLB_BIT = (__force vma_flag_t)22, /* Huge TLB Page VM */
> > +	VMA_SYNC_BIT = (__force vma_flag_t)23, /* Synchronous page faults */
> > +	VMA_ARCH_1_BIT = (__force vma_flag_t)24, /* Architecture-specific flag */
> > +	VMA_WIPEONFORK_BIT = (__force vma_flag_t)25, /* Wipe VMA contents in child. */
> > +	VMA_DONTDUMP_BIT = (__force vma_flag_t)26, /* Do not include in the core dump */
> > +
> > +#ifdef CONFIG_MEM_SOFT_DIRTY
> > +	VMA_SOFTDIRTY_BIT = (__force vma_flag_t)27, /* Not soft dirty clean area */
> > +#endif
> > +
> > +	VMA_MIXEDMAP_BIT = (__force vma_flag_t)28, /* Can contain struct page and pure PFN pages */
> > +	VMA_HUGEPAGE_BIT = (__force vma_flag_t)29, /* MADV_HUGEPAGE marked this vma */
> > +	VMA_NOHUGEPAGE_BIT = (__force vma_flag_t)30, /* MADV_NOHUGEPAGE marked this vma */
> > +	VMA_MERGEABLE_BIT = (__force vma_flag_t)31, /* KSM may merge identical pages */
> > +
> > +#ifdef CONFIG_64BIT
> > +	/* These bits are reused, we define specific uses below. */
> > +#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> > +	VMA_HIGH_ARCH_0_BIT = (__force vma_flag_t)32,
> > +	VMA_HIGH_ARCH_1_BIT = (__force vma_flag_t)33,
> > +	VMA_HIGH_ARCH_2_BIT = (__force vma_flag_t)34,
> > +	VMA_HIGH_ARCH_3_BIT = (__force vma_flag_t)35,
> > +	VMA_HIGH_ARCH_4_BIT = (__force vma_flag_t)36,
> > +	VMA_HIGH_ARCH_5_BIT = (__force vma_flag_t)37,
> > +	VMA_HIGH_ARCH_6_BIT = (__force vma_flag_t)38,
> > +#endif
> > +
> > +	VMA_ALLOW_ANY_UNCACHED_BIT = (__force vma_flag_t)39,
> > +	VMA_DROPPABLE_BIT = (__force vma_flag_t)40,
> > +
> > +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> > +	VMA_UFFD_MINOR_BIT = (__force vma_flag_t)41,
> > +#endif
> > +
> > +	VMA_SEALED_BIT = (__force vma_flag_t)42,
> > +#endif /* CONFIG_64BIT */
> > +};
> > +
> > +#define VMA_BIT(bit)	BIT((__force int)bit)
>
> > -/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
> > -#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
> > -#define VM_MAYWRITE	0x00000020
> > -#define VM_MAYEXEC	0x00000040
> > -#define VM_MAYSHARE	0x00000080
> > +#define VM_MAYREAD	VMA_BIT(VMA_MAYREAD_BIT)
> > +#define VM_MAYWRITE	VMA_BIT(VMA_MAYWRITE_BIT)
> > +#define VM_MAYEXEC	VMA_BIT(VMA_MAYEXEC_BIT)
> > +#define VM_MAYSHARE	VMA_BIT(VMA_MAYSHARE_BIT)
>
> I suggest removing some of this duplication..
>
> #define DECLARE_VMA_BIT(name, bitno) \
>     NAME ## _BIT = (__force vma_flag_t)bitno,
>     NAME = BIT(bitno),
>
> enum {
>    DECLARE_VMA_BIT(VMA_READ, 0),
> }
>
> Especially since the #defines and enum need to have matching #ifdefs.
>
> It is OK to abuse the enum like the above, C won't get mad and works
> better in gdb/clangd.

I think having the enum anon avoids issues I've been concerned about with
named enum's containing flags when used as parameters yes.

>
> Later you can have a variation of the macro for your first sytem
> word/second system word idea.

Well I think we'd probably want to name the macro accordingly.

DECLARE_VMA_BIT_AND_FLAG() maybe? And mention in the comment that it's for
system word siz

>
> Otherwise I think this is a great thing to do, thanks!

Thanks :)

To give due credit - Matthew suggested this a while ago, I've been working
towards it with the mm flags first as an easier case to tackle.

It came out of my assuming that the VM_MAYBE_GUARD stuff didn't have a flag
free to do this in the 32-bit space. As part of this work it became
apparent I was wrong, so I implemented + sent that series yesterday (doh!)
but this change is still useful as it's beyond silly that we're constrained
like this.

I should actually probably put a Suggested-by for this, didn't even think
to, sorry Matthew! :)

>
> Jason

Cheers, Lorenzo

