Return-Path: <linux-fsdevel+bounces-53378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD7AEE418
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7067180001
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B1292B25;
	Mon, 30 Jun 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NT4f0ooE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YeVK3Xhr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48F25D8F0;
	Mon, 30 Jun 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299832; cv=fail; b=opb9UTTqxGFbTxrayXJ9+9+UEbeOZ51SkcYUa0xMQ94gxk/QUeo6ALXFE+v2X1Exq7jVEVs6hj1QZYIB9LDScTY6I7k3Yk+C+cpVkmMFwMz7Quh72b/e1PEZ0OTPbGs7o+DHPG941HFSq+lqastKcPTnx7vjB/thdEgC+YilWRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299832; c=relaxed/simple;
	bh=CLlZtYZoZmktqe2zWCEdhTCHYFi22Z6lAp3mzWMPMi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L6sfSFtImcjbL7eiMdO+WI4pH0hCAi6wcXxx242Eq7UdN6L74g8xQ/T9sArS8GKjwUeb7xQaKWiOyMClJxdxgafrNclQGJQsWDwVmGUDfiBXf8+g7kaPAiu8l1yRJI/iUFY4PieaGEYkUDHFa4MIvEhP/3SWjv15KCe/j9fVC/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NT4f0ooE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YeVK3Xhr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UElfNq020341;
	Mon, 30 Jun 2025 16:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6/Eq+U30vhc3IFsh/l
	B/ShXJ2j30DgZdCdH6tKXPZuI=; b=NT4f0ooE/miN3k+vgS3u5bEZ7iHnLlJk+m
	F85iaDK1ZyQVuIqbki7fpOSsVV78Y90WJf9DQUdpYM9zueYiPawOw557HePLH4/8
	vDobftzoreDEtznD2RWjUWM/kVp9juG1yNe0Jcet/G7pHxGpiqnF2J0/J0kmlLP8
	W8/PEgdweJs6XkXq3fqKyturb4aPLQBkBW4aPJsxJtQfyF+I+RDyBgdTCoT+vUdd
	Sr/bwmGqDu35sHvfvrN2R+jhkHJgbtVirC1b5uuYQgPfe7AXjET1O2kG3JkWeZzi
	XSGFDTsG37desw8cn8CAb3gejQnBcPjuRR/qgONRQ6iCcrzAWQCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7t5vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:03:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFchkq011855;
	Mon, 30 Jun 2025 16:03:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u89w1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:03:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlszEnHNpxtuxbsvr6GjTxZEUP6ss2rdCX8h+eOgWFjRYpq47KehM+XhLN9YGhU9GaVLlwXMmE9IEmh/3asVEPgQyDMBY31mSfMPel1v10Cm5p2mwtb+ugNHfDSrMkONAHCRBqVw1z2JUfEsqHnwi1XUWUfyBCZdwg4Duu9q5Gvs1XicX6sNdoEzWHmHF9F/wUzu/kdhaByCGWEPT29JRzdUcJcB/L8ZINcWF9RQ4pTgvlVs7hrVhVhCyxyRp3ugvhMl6mwC/9BA0RA7VG48zpMafe/fcGfzbE8iq2H8HqjUQtEIJt2271BjYHkwWafEBOHRBRAoUlI7nxyEirHuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/Eq+U30vhc3IFsh/lB/ShXJ2j30DgZdCdH6tKXPZuI=;
 b=x9yOXHNs8gltUMzuqOeTB4zgnXm029i3awYu2yU4bhKnP45yZoenEas2Fx58GzSaJpwIqW3U7fvl4RlzvBqZcYpeSGnZ1N1g6eBi5/R/t3cq8xPwTNnvRDz7MzVkfJ69EVmi4rgVIupFkV6tBOGPEKzkLZUQPWn3luQURvIxpYT36wmzEejpsbx1HoGJaXVzHbniz4AYUoT1Rwq/RNxTdpqWLP9MIDP11PEd7hePTE18RjVmH86H5af+vEZXhy+cpAzLeXM5FBVkZD/0BMliAyy5W2HZ+qTAD5LTax93oGZfJk0gI4BHxYEYlc9qM6ZpXggv3pCWj3Met8+iYeSDwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/Eq+U30vhc3IFsh/lB/ShXJ2j30DgZdCdH6tKXPZuI=;
 b=YeVK3XhrWq1IoEauPZC++Joiu0k1rRLg+gThfbyoJMP3IKRUjDjghylQcjPuvaVdgf+sow42Y83zL/s1vAUzWFTNMkebhDxyvVCIem11RZR5Ah+VukS5F1z93Ebp7zwq3hyvFpOeaIEMJA+Jxnhu1xC8qnOKyPKQabFfsRAMri8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 30 Jun
 2025 16:03:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 16:03:47 +0000
Date: Mon, 30 Jun 2025 17:03:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 06/29] mm/zsmalloc: make PageZsmalloc() sticky until
 the page is freed
Message-ID: <74894b3e-9a64-4600-aa3a-e212d2f63e1b@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-7-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-7-david@redhat.com>
X-ClientProxiedBy: LO6P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 297dc354-efff-4dfd-47ba-08ddb7efb251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1U8qMfZBVbW7ETKYcwOV6muGvBMM12kOn8s1s9m3rbuEB0Zomrzsy6yWY4IH?=
 =?us-ascii?Q?7JojdP/yal+Gtp6Mp2SHB42AdCdbFnR3NGVYZ4A67bkNs2eymbaG9HAeZWG1?=
 =?us-ascii?Q?curwvmUvrepzSPOu8YHagS92k6rNeYP/22YxiaJUdc6zg6ZdA6gUmASBb0HU?=
 =?us-ascii?Q?zP/rnEUKWCPNscOKh/hyCN6RPRbmNpRlyA3euP3wJeAszMrMUZr2JyHBybjH?=
 =?us-ascii?Q?Ukqxi5LRc5ERQB8iFDOBY73JkORLs7o/xXuSOqBSpB6t65YZ8rdzFgncLe2q?=
 =?us-ascii?Q?xPe8xRSRmGU8d+tliGfY15Y3VaWv1zoKoa27tdTq0qLFRwqR8iaqQZaqcFs9?=
 =?us-ascii?Q?Vuw9UFC7L5K+dqWVCO20oKfvGGzGs6Q6NIt9ttxjS93J5tJxIjFiWiGPveUl?=
 =?us-ascii?Q?ZAwUj/R7zXd7ZjtqaGUTwuUbFGbKeCjOQ1H+TU+0G4WFIDuVa/tfVk4ZNIgZ?=
 =?us-ascii?Q?ntSgMfFVIcMCw8pexafMyiIgt2NQbBx793IBQJUzYmDufSk/WXnN+IHeAEig?=
 =?us-ascii?Q?KWlR3E6rJrPkUOvRKYO5GU66hz+yXTzjidWqtShwsb0Qz+G/VYMT27YFv+k3?=
 =?us-ascii?Q?6vPQaOMC0EZDfIV6r3i8owykBQ2Hcc4Zg92SVhlJNrcmMpVMq0xENw44tg2R?=
 =?us-ascii?Q?W9bhamzBG6SXJWAkbvBhka37K5KssTuArRNYzEC6oKhVsZFjqYSILDMThwEK?=
 =?us-ascii?Q?YfxNcnBldJZvoh6dF8D1A0fGqotWcMffQLL9Zo0MS5DKYqD1whO94RyGgZ5b?=
 =?us-ascii?Q?+OuyyKWMOLa+/Go2YrIr6IL1v/xrUpizLGNWCfEuz6Rf2FekMK0hC8Fi2d8s?=
 =?us-ascii?Q?HDgMfTRwkrnfBUOZnGsKcW5OGOg4l8H/tqd0205USYl3CXOZ9pPtTp+n4wi0?=
 =?us-ascii?Q?2emLg7azPPAQ0RTPoyP/VCleiYgKnOYufuPRRYYte4ZyJo87/k2k0yyYAALb?=
 =?us-ascii?Q?IZ8OD7xQWQ/cNWFCQJ/r3/CX4s2nvFEZrhEImFOIdRjAY0HlRpR2bjnt6Fj9?=
 =?us-ascii?Q?XI5dxKUfAdY/x9N8ym5aOObfC/KGgfCD7KaEatTel/c8bt+9qaVZ2SQJc2Hy?=
 =?us-ascii?Q?4LK7n76+R7p1tf6d1i3l+TL3rX1+NHpq/7Q0dc+PtEczxpisTK9Gh1B0erYW?=
 =?us-ascii?Q?J7cuBpd819vKZoVRmHDaTEFbqP/z0j3tL39JNQPv9lwXGauW8wFPKL2uUQeU?=
 =?us-ascii?Q?aEn9LKRVoEqXCqMeEgQb1YzImxc63QRoAlLKtNjljCDnmJZw/atT9tGdcCPJ?=
 =?us-ascii?Q?8Icvp8vH3TM5gkmnXkQyhluVW5TdKq57J2/oHc7OhxiEQ/ow4VWeCtfE3y3l?=
 =?us-ascii?Q?CCRYmyaeFz4pcoJZ6aSxmMbOpgSXjUJD6Cjn3ySpIHMBbnkyue/mIUPXh10Q?=
 =?us-ascii?Q?efDtzcJtleKYZqwpAD/RWku/9uFhAUinPjApP4yYj6T9Zhe/LA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?To8nraBC2CyPIcXazJ/GuwjgoqAlDTdItVMqjrWkBPnPJeDe0edbq9jchdxv?=
 =?us-ascii?Q?Ra+AbQTMEbSNSGk5ymCdAYrjTGcQ5SUZtadNmmioE8sg56X1e8L4SMH9WWoq?=
 =?us-ascii?Q?DTLCJQaSd1TznuJav6gt6+J8FH8KCTabXg8b2lDzRja7NEzONO3p+HVFFwFl?=
 =?us-ascii?Q?/xcsvmL15Ca9POMirzrkPsA5vBumxs4eev+9/pVaq6/KUzUYoKm8t4wDEYH5?=
 =?us-ascii?Q?CuflZvMQ1YvzV6Nhhnk+lB9ZEviJuDqYDYugaUoyFB8zL/Av4+2YSwaU4uXf?=
 =?us-ascii?Q?9tZ8BCEpfomCNRh0y/Cu2OPe9ivbvoTxcRMlc4HB/kKb0IT3MST3JkxAJZEY?=
 =?us-ascii?Q?uWAOwpfMG4I3HwrLFd3DDsMwH/zAamdWc28xeoyrAYi4/HJXiIJbzz6v93iU?=
 =?us-ascii?Q?gLNW7QYTbXzm1Kv1HxZ+IzEOBIND4qrNEZZfsXSzO9ugwXtQ7qyf9PIUnaQ5?=
 =?us-ascii?Q?fzBk9QATL6CHMKhItHJAsSe+ikG0RXt+9OFNuVDPZUIBrYnCZiBfIbI0H8Lt?=
 =?us-ascii?Q?qhTpJhSTMBa5HuohzBJTF1m2q7NpCicJsNeE6QGGzbPnRgOikkh0urtnXIGr?=
 =?us-ascii?Q?LNZxh0OTiNqeUe/JBA/k22pY3n1IedBoe9hQVbdSwVm9XZaGaFjfNb8aPgXs?=
 =?us-ascii?Q?s5CE3BlZlEFcPH3y3WrXwiM9IPCW1vXa+Jly/zm20Ah6RjipW1rj954GvdPL?=
 =?us-ascii?Q?mMoiosIIjltVGRDLcgxnh7PbV0BIQXbS88ozXF1932QlYHdaxHCVo9jKalIT?=
 =?us-ascii?Q?fYZVIiihyisNfzdYEpxjyX0FFLcM1Ix6TlfbC6dsZN8x7YwSDSqU7IZ8I8S7?=
 =?us-ascii?Q?LDqvtqJUYrvAMxzUSwliOz/vXT5PaEzMwxmsRPfAmaufnSQORwfifqwUC6tk?=
 =?us-ascii?Q?qKz0dptNiqQ9qOiYgMhkcoE/5ilGYaFzOiTWsb4nhcTYDWqUXQL+GMtj6QAj?=
 =?us-ascii?Q?edqJoDnFgF0VuvWWuqoZGuUDxJxPBFRoN1VHkjizQ9K5r0QNJlWB9OSFFV6a?=
 =?us-ascii?Q?oMDcYUfzv2Mt/jGOIWBVKfxOz1AsI45VsyiSDiMlD/lekqMoyKEskTzKo6wC?=
 =?us-ascii?Q?QJtpeFb4eBLmSejintA2+8hyi3Q20gDO44gtXgWrhVAetKMfMNZin8tATLK7?=
 =?us-ascii?Q?H0klAZU/n28C2XKKl/d8OZev2fGLM4xW2+wTk25tyDMc5OO7iAewItB944+r?=
 =?us-ascii?Q?Dx6Incdqn3J6crGo7HRBfhnB2vNQHNkGlRvfM1wGQ4nZ7ZeJOpQZTLAi9BcQ?=
 =?us-ascii?Q?ugzKOmFNbV1GsBXMoRoKO7RNHNpVxQxzR7EyoYFSre47+atZ8VZWFugzl+Np?=
 =?us-ascii?Q?lezASnYIw/K7pt6GoZQdawEqQUj2pDiIV5+pI1vz4KggcwfvHKAMKofP1YTU?=
 =?us-ascii?Q?IEyvBIu+poi/G427iqMCDzINSqQ/6pO0oGs/RqwHK8N1Iy/DTE16hCkciQLD?=
 =?us-ascii?Q?FIBSqCZs6B8yPAshS71MYJNrueIfyHCpfYyUiXLXdrphi+/jGu2FUnUebjQa?=
 =?us-ascii?Q?0J+38h8oHmS6A/taHmwV2kS/JcyLJ0zI5NXA3YDUshBnJ11/EwMC14VyUy/P?=
 =?us-ascii?Q?YGzU/csxsilIUicZLCQG1TbMi2mrzBrvWiabIuHVAlbgCmHp4+6C7/f5lZ1L?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QKHhfsxo3sq/iZC7uQnUe+xRneztmFzkR5EJjRUQdQV9cN0PNBBr8/FnN/Nznm3AjI30IWXXfyNWSNWSekxtckF1IstDVY1b2r/jAzy0gFEEH4kByL0LCzUqY/fxdl/7kINO3p5RfxCixPdFGrr/APaPOsSc1VqrXbEvVKxFgcxoDIAKE46gpU2YtvUFqK7O7jGvG3kUj0p5FvGr8g1R4pZUtO5RPD1gDwRxNSrPpz3cUIjfPWD+uWeqyy2NJNLF+OpW5lww7o7I0LDPM7EiTHG2RorXNFD/1r52Pq6aw/h+9D3oyKZUzVG/Kx2/N0XA9E3qfa41EERpVBDaU+MvXFJhkdT70Kc8Utd+shU65oPXScRFKTdkJX3MMx5mnnGBX85NaZBG0z+d4CxghYIZnWEk1d818fbm2vmgkTg9jMjD1SNgn67AY+QZgWEBho6LDorVyjVBkrarlpJjx0wJTHDDi5giKo+LHy7TqxC6B0fZ6/mPaxLU2sD9v40FjMgZj2bKoRA1w7Ae0waMyIwOlgWNGr3DFrK8XKOI/bSKEwmOvP3R2vVKoWBip/TJ6zZwnFjyoz3Zn9BLG/jstV/UpHMqUWLwWmG52zXTHffZk0M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297dc354-efff-4dfd-47ba-08ddb7efb251
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 16:03:47.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnFA+zyec8O4T2i14ZV3HxY3xZ4GQ4QCbIcdLAg/hZlEa87NwfhswCxvpJZHBVQp2A9tdq/cWqHjcXtQORmjdl+Kzt6sC27ltKjlPcO8XBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEzMiBTYWx0ZWRfX60C67jRVe+lg OuPV6fl3YvKXMs7jvNSB/R9yqY2+U0nk77qHWnH8k21+GkatDM9dn7DrCc0tFc+PdKNzfrg5LMZ OFmzPjr4q5RfyXUlJ3bgIMeCAPoLTgwt+W0K7Tt85abowxNCOY6SxlUKwM8yg23xMjKZBKxhSIq
 j7ticSO9baGrGFlLvwwQXhSatDjNwa7MLiZHqBzdC9QinYrpR5CQwFQxMxRNl9jL7kpQMoJ27vo NjmtivCzaNxox378A8iMO+hloQWKEUZ9VYwV0FU08MbU/G2l851AQph9KorFxbvc/4k3NaO51RE QTCHThhZ1/QrCwcfie7HQYQUg26u93EchPAg7uYZ0hJE1ELR+EZuNMtkfyq0NGngBJq4I9Ou3vD
 udyRRNSFaQn/6PauUokAVv2Xk4/pqUkZBcI0fl+zUDdrMIhYxmWeiovFMEYNdXJBy7dZwFJJ
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6862b568 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=cm27Pg_UAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=LEvmu-3r5RuW8tMfl3MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: _ZcTgVCtJ1U8XAd3ClJ-fgJ_kW-SJWeW
X-Proofpoint-GUID: _ZcTgVCtJ1U8XAd3ClJ-fgJ_kW-SJWeW

On Mon, Jun 30, 2025 at 02:59:47PM +0200, David Hildenbrand wrote:
> Let the page freeing code handle clearing the page type.
>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

On basis of sanity of UINT_MAX thing:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/zpdesc.h   | 5 -----
>  mm/zsmalloc.c | 3 +--
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index 5cb7e3de43952..5763f36039736 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -163,11 +163,6 @@ static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
>  	__SetPageZsmalloc(zpdesc_page(zpdesc));
>  }
>
> -static inline void __zpdesc_clear_zsmalloc(struct zpdesc *zpdesc)
> -{
> -	__ClearPageZsmalloc(zpdesc_page(zpdesc));
> -}
> -
>  static inline struct zone *zpdesc_zone(struct zpdesc *zpdesc)
>  {
>  	return page_zone(zpdesc_page(zpdesc));
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 7f1431f2be98f..f98747aed4330 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -880,7 +880,7 @@ static void reset_zpdesc(struct zpdesc *zpdesc)
>  	ClearPagePrivate(page);
>  	zpdesc->zspage = NULL;
>  	zpdesc->next = NULL;
> -	__ClearPageZsmalloc(page);
> +	/* PageZsmalloc is sticky until the page is freed to the buddy. */
>  }
>
>  static int trylock_zspage(struct zspage *zspage)
> @@ -1055,7 +1055,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
>  		if (!zpdesc) {
>  			while (--i >= 0) {
>  				zpdesc_dec_zone_page_state(zpdescs[i]);

Maybe for consistency put a

/* PageZsmalloc is sticky until the page is freed to the buddy. */

comment here also?

> -				__zpdesc_clear_zsmalloc(zpdescs[i]);
>  				free_zpdesc(zpdescs[i]);
>  			}
>  			cache_free_zspage(pool, zspage);
> --
> 2.49.0
>

