Return-Path: <linux-fsdevel+bounces-71620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80569CCA568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 752453027CF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A630C37D;
	Thu, 18 Dec 2025 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nrb63J32";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GMwJVUTl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8F1EBA14;
	Thu, 18 Dec 2025 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035780; cv=fail; b=XZjPPDZWtWPihP8uJjPRszuc0bfOYgLvIRBqlDC7VENOTBO8VGMOOHBIgOWlazR/TxbVpZyCl9ZDIVAEMMplyX/og3ylygbLlD8d7mdcxb99hm8EPHRkQBnxQRS8w9YRLJZkmI4NUy3xaf23r2JStIPc3bZPQzx3OQAjed22W/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035780; c=relaxed/simple;
	bh=/JElbxJ5SSqtGQae7/Ol8DWH0hogKfIPa6YYL3se6Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtXq3m4ehlTlJl1x/zJoRPnqRseh0znOa2taGRTPh1S3x0M5drDXmdVVinJGILWHk4/Nw2bVfCX7juoOIn0UwLRkzF4nCnSNU27vZyhYvNlL2CsFky/7+N9bJ6jx/TosZ205PYLyN0/gkVFGgnLMEwhiQmml0H4d5UH46Ac/4jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nrb63J32; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GMwJVUTl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1h9Cv412899;
	Thu, 18 Dec 2025 05:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6TseSqFcdNa1hh8Hfu
	4bZy1acZmVqLPp00IfQJb25UI=; b=Nrb63J32ijkTX0qTKWIngYQ9PbfrGCUd+k
	t+ctM3hP5aNdlRyq8MeE90uVRumyUvYJvlAnmWljtMbCXCkRenroXZdAocfOGj98
	MZlkgeXSd2QmN4RygELgm3ySRmwMXLJ8c1pyEX+p61ZZu7/RQFSHqpsM/P+zi0D5
	kqD0WQjN3C9PGG6jPi3nAzl3qcflXbdCH5LLBML8EDTa6pRJBcNH0JhSuxgCgGwE
	eKKfHA+uNM17+1vN3/r2Z+tLvF5U/whEHVfzohQCG+msyNcPTCpH9xGMDGoqw5HZ
	BQPaxUH3RySAjUO7j4mAPQK4vEfztR5uicghyz251KJNiWwmeINw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015y7ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 05:27:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI4j6j4025249;
	Thu, 18 Dec 2025 05:27:57 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkcpa5f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 05:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjupQn02JQX3Op8Eod1FNcukym0YlGSObwAaa71NEzoBH/tMXS/kmdW3jL1w6BLUJVN7mdg2xVCHnW2dF1NL/r16whiC9chUZhSQuLC9fv9tf1rzwfBD4VSnLvPjDbpm1o2n9XJWCnkjGucqFzIKaTNIn+pss5nm7zP6cZZ7vrWrqkqdlyWhRFhwD+DR1dvdk7h4gYaDlAyMVVtSLaLqBTpc13Z7OumMiX/HArDKPtxtFfa55hQgecnukMfKLK/dT78ORt33GnM/e9OH4prHyY6rOEibyzZ+EC2WI2B0Gl2Y2wRL4IcHB5P5pDF6LveMmV6ZyvJqAZifZzfBAPmm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TseSqFcdNa1hh8Hfu4bZy1acZmVqLPp00IfQJb25UI=;
 b=nFDQ7GfHti/6+zAI/nF1ccIXGZ+XvulMANzz1GlSvsKmftgUfL1bmZl4+OUg8CcchpatGoIi3zd0vbIiCq6IzQlsgADMDWSAG7EkROqJrQOx9Na8WdDEAyfuXkXREnxo6kYTeiSQpVMfbQOmU2k+45PTV4HMVwdDLUj/qKykL/llFkWnYZsodMrYbDk2f3IypE1YLJNnX+uvsqlX7tTYQGPNEhKCqE8JtW0UEGifaq0KMI0a7rdeP7N/+IUj1Y82DrTVx3AlwxcsXqjtYehRAj8cEFQBLK1aHRTZ0uc0UPyTkjrsIFmMZnI0ITVq6z7NJjIUjhp5GtFGD/YZWAPXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TseSqFcdNa1hh8Hfu4bZy1acZmVqLPp00IfQJb25UI=;
 b=GMwJVUTlS+96OxzHCHCpaD6VutR4CT+2D9EdwfybkNyo8nqpc04TFP+90nXxnevBibWRnKHn27TjUTBFHx99SPhVqS3xCJ40LZM+GX9UIxtDpYk5fg5C6L9e5MRcr8C+odi0XN5vPaOymXazm/aLdMYcXArht89GZ4TaiCZc7zU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB5967.namprd10.prod.outlook.com (2603:10b6:8:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 05:27:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 05:27:51 +0000
Date: Thu, 18 Dec 2025 14:27:32 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
        Linux Media <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
        Linux Virtualization <virtualization@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Network Bridge <bridge@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthew Brost <matthew.brost@intel.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Philipp Stanner <phasta@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Dillon Varone <Dillon.Varone@amd.com>,
        George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        Cruise Hung <Cruise.Hung@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Sunil Khatri <sunil.khatri@amd.com>,
        Dominik Kaszewski <dominik.kaszewski@amd.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Max Kellermann <max.kellermann@ionos.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Vitaly Wool <vitaly.wool@konsulko.se>,
        Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>,
        Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
        Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Lyude Paul <lyude@redhat.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Mao Zhu <zhumao001@208suo.com>, Shaomin Deng <dengshaomin@cdjrlc.com>,
        Charles Han <hanchunchao@inspur.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
        George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 05/14] mm, kfence: Describe @slab parameter in
 __kfence_obj_info()
Message-ID: <aUOQxLXtVLVSe58U@hyeyoo>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-6-bagasdotme@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215113903.46555-6-bagasdotme@gmail.com>
X-ClientProxiedBy: SEWP216CA0119.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: a3253b09-987b-4467-2f9c-08de3df63001
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Uy1j4e2QALjdO7VPqWWp0bf45gm5id56kKuXrs4Ds+kceST2lEMA5UMUmFiD?=
 =?us-ascii?Q?sJP0tKKz6VQoPZJR77uNyVv0YC+CbNhSxGE83rO3IGQdji9ihZoHJu4iM8+w?=
 =?us-ascii?Q?jBWH0OyA0UNvJVyeke2ooB2albuJtiIYXmu3ePjcvKsy/nMlAhFaaTlo5Oiz?=
 =?us-ascii?Q?c3tp9ocQztI4sJRFLL6ykKPMMc1YD72ihzk9AguYRSxS091nu7MhdH9XXLPC?=
 =?us-ascii?Q?Disbg1PUPc9y8+AvERTLyC3SsZ8Y/q4orfgKSUhnczMvvEIpo0SvI3kz3fNm?=
 =?us-ascii?Q?8hUruDa6vPAIjTW83eYqdi2n78FA5LI816DfHa5aCzDwxpbYQu0I9l/w3ycI?=
 =?us-ascii?Q?3y2HE5hFAH6Wn3d7KVjY6JPACpvpC4JaqXQORbSmLgjye4EKrhOZDgdtIzwc?=
 =?us-ascii?Q?LZDeKTevvsCVNJVCUZuST/a03utQG8J4HpwS8m8eU7th1VrPy/UP/RFkElaS?=
 =?us-ascii?Q?ivphqmXTKRTShdQ/ul19PKQxmk20KnvOHeGlXHxYUaBKvpfChxaSL63m2bgj?=
 =?us-ascii?Q?l+A91Ua58uVUpnKcxebqOYHx4DjNzz9fJEjjxhMbtUiuxEfUoYQj/wLRyVcN?=
 =?us-ascii?Q?Al/ppV2IkIdr6CZV4XFFPLYyJONkeMZumu/uJ9KTkZVt4QGi9WpMZfNPePkv?=
 =?us-ascii?Q?lwTCxv7BPuvWqIIoxkirblSZM4mK/3O9RisV4QzQ5cFhei3ClwWQF4ZakE4O?=
 =?us-ascii?Q?L2VxdzPvOcdnXlmu7BuW7gjHmxVG07y/OZHqnjF7kbKeVaYxeIGgmNwNixrz?=
 =?us-ascii?Q?KYieY67YphpC5d4MuruHSTfq9k4mPep8NmJw/J4wwwGFQviZPX+Z45vTtlVJ?=
 =?us-ascii?Q?lem4x/p9NTL9fxjoJWddrKjuTapRJhjHs09NZYuymMQ1rKfDRZyEaPPWI9lX?=
 =?us-ascii?Q?WjJsA9XSFx/krC79FiaD+fR5HiyLD/yRKeJyWEhNx7cxiNonZZ9UP+cguiPS?=
 =?us-ascii?Q?9TjaNDKFAs1uYGxl0NhiCPzi5h6lNsLbWCj1y8Xl+5cZxpmZ/6wjHw5MduTA?=
 =?us-ascii?Q?DwpYFK+BfHI7QrWnAKSN7NlpfXgU3Ev9PtZ5RXXcTjRjfAey/5V+GbFz44nN?=
 =?us-ascii?Q?2iNU3j77G86Kny4VdRWd8ngB+1sgaudE/4F84GE/DczYE4XUU5J8CTsD51EH?=
 =?us-ascii?Q?XumPP0d+JDHcqbnGjsFQpGnMDPU6GmsO2FSb/Ac4c6UNuKXYEFGkcBPE5Wuw?=
 =?us-ascii?Q?Dv6ZDm1QeZEVxoNSs9MfQiStpoACE7/6BuWE0yDFHuf4+amqefSTr7rHcL8m?=
 =?us-ascii?Q?IVTiSOvkGLxG0KHGtyPJfhUsoPXR6LVRksMyjT8m176ro0KoDFrb0ru/ORtA?=
 =?us-ascii?Q?hN9dsTFPJK5SrCN6NoGeAPyb3hTo4ciCnYfmYFru064U3uXBZYJUBIlqp5Px?=
 =?us-ascii?Q?oDCv+dS+sw8Cq5Au6LW3XhSHgUhwJ0AxjeBMIOF+0Ez0mmC3czSQH/sdoJAZ?=
 =?us-ascii?Q?XE5ceHh0pKwXMgNJIgEvuD/S0zfsMzC0?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?QqvMoFkGzdBL4cCFiEeYTnkxlzm7NJb4V3OF0NsUAN/4qHQFdeh4oZTaQgVR?=
 =?us-ascii?Q?Vj/AMIAP1A3yqV0DtoDXmngUmjz9VtpG5/5J42KqrA9R12LtLMntH7iMOoiu?=
 =?us-ascii?Q?y3ux/E6ZOpSTlFWdLYA/fEtdHAI0KT0hX1+eUV3UPIMomyj/YuVndtF43y0x?=
 =?us-ascii?Q?Hvc2/KVFC7Pq+9qcqNz8+/8IvJbcoNkCgl6vFuU9fwuNWFT4ZnZsWxIVMo3R?=
 =?us-ascii?Q?mm05TexaBF4b07ILTpEUSmnlF1lS7ps3A9afotDWfU8vika61mxVV7AHClX4?=
 =?us-ascii?Q?TuYhbMzvKJhPak2HjDz/BRXeXRjq3vhUAgbvj8UiEORwyzDonYdR6Hx/izWU?=
 =?us-ascii?Q?oIDKfeXc2tFjMpe5TrKv/0kR+FnOKXOrVSVeE/imVxMQIOn/IRkRJ9uopUgc?=
 =?us-ascii?Q?Puo3OR/HndhBn9bIR9DVff6Wndkr17AcAGXpXbd9rYhCyhllP//arPoi/MKK?=
 =?us-ascii?Q?cnb85X8G5QN+M929UzflEP2PhWKulC2tVylSTYmELxRBtcbwXSAhDVAaX6Mc?=
 =?us-ascii?Q?elD9ced5wKuPV+HGGL1DjhH5PSmj4TTOSxtGTj9TAm25VyYLPlivu53rUjfO?=
 =?us-ascii?Q?QgHAT7lAsnjxGhVhwMzhrz8JzdxnChXvp5e5Swyy+8mBf4PRDpyOjnYSsUlf?=
 =?us-ascii?Q?o6+oiPxUu5DWqdPCTrppBFMGWHrBCmJh6q1SbFTXslO3bjgd4649C5AtHq9X?=
 =?us-ascii?Q?Wexmj7Vokhct7J/mbWhir5SRxChZIZZ5Oune2+AJUKOqKJZoyxEujTkpjjFr?=
 =?us-ascii?Q?h3bWg2ScTuVqRZ2XpJercoilsxJTHQ8OkVF40w2pyvM13uVqYtwV6YJslUKW?=
 =?us-ascii?Q?zGHWb2UjbRBotZ0/lGtwLABdLt1B/7be0xf80l0mWTD9YuYamAMEeun+adqO?=
 =?us-ascii?Q?+jX8k1BQBz0hIjbbwCD8Nv3h+iQo6Fjc1qEMrAZKsopb/t9oNQI0tMNEospr?=
 =?us-ascii?Q?EL+9LyAzjViwWcLFx4tnoyEnof+QKNpJYob6VuOL4liO1S7UiIszINAwDqeZ?=
 =?us-ascii?Q?XKqlVy/buSXGXWjJElvcaY9CZoAJfERXW3JngP3THHWy4Q/GoJuNFYguqqb6?=
 =?us-ascii?Q?r86WS1378kflifFZzOVP4gpDD4BNuZv6GvatWJDk8ak+tGKlJTOE1iH/DQVw?=
 =?us-ascii?Q?RqJP9sd8tqkkUd6ihowKuR/J+7zMu8IxBi/K+P6QlX1EoIWIbmWDVc05xwUO?=
 =?us-ascii?Q?NP2ZXxO/X55gp6cUH1b7LNUenpMKfbSF5ujCvB+VwnxjJCUEclLomUEEE1mc?=
 =?us-ascii?Q?DQ4537lZcKf8qCckERqOGTkzy7AfMYb8hYldgA9dGOxChVCOy8xVXaPY2pIw?=
 =?us-ascii?Q?1gwOE2f33/6KvHrmJDoRecVsxNpMg8O9XCeoI6Xu6YC+ZB9+EeDepcK46p5K?=
 =?us-ascii?Q?eESpjf0JvwJZrn1QoPEeV/33gSXlIFRurccFrib/R7E+f3fx5dOU3fxLzPjn?=
 =?us-ascii?Q?4WfiFseuMeKrxA0YH3B8lK04d9HnhP4FkFsfitDG8qK6ls3lCHfKMh7Y9yap?=
 =?us-ascii?Q?vpzgLng3XAIICnCZAxptkOG5CoOVI1vWQDQUNZ2yVYZhyOyP0fXyPMV2XLMo?=
 =?us-ascii?Q?VNO2vH6dKm3WYiyhtJ+YuM7LMd1t4XVIOFqS+rFn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tE4lWbknYszrdnRNvubZH8dODjSMpX7aSmgm9L6zEVr/ABf2/V/A6TH7tQucszqQsuHYcUWwY1KlI3z2HDuAwWdUw6+SlngiqPOfNiWh5itnz2/Ibp+uPFAS+GttLdEWd8vVkpiirNJ0gK0r0yJ0E5lMZsXksanj03JEXY1o1ocgx67FxSbPbJT6f9//9HaFlfRSifqLAi+1jJYdLeAuKfKu+9DW1VWqtBscMYeK6g1LX8pJgod7YN4Bq+Iz0W8qKJB0rzbqzHzBJPo3blgNq84pC1Hehi5FCrRooH1U8KHmZKBghTKejmrAiwhg6GXz2gXeAvz27gIpfPRwemCROIX2JDAb5fc0bwlb2kUZaqXL6+tYXA4UW7d2FLPxCnhH/hz533WZwmRO6XBYKbNgkyI7YsRRHxG6bV+PsC+9tKqc7tnPYurUKetpx8Cfx9Xf8LFrScu/WiRppD+WmIPp8H0prE4O8UcXT9XsawOOGUfikjAbeRsSfAYWbqsNun6K6Eo+cDb7D88L+RvhJliGHcMvxM3XJ3IGVJEY89uPbdq1j/YWVAvkDjLkHhO8uIDvsqB+VFih9FaEZnt83r+k+UmUtZ8YqZ9wzOTgkJqzXiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3253b09-987b-4467-2f9c-08de3df63001
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 05:27:51.1123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GVMj5IT+Cia90fnQ5qQ4yzTII8NvSQ+zxJDXSTUSySX8H3tloSQrTrKkdZ9P9e6yAINoSxJBUP7qAuYHNZKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512180042
X-Proofpoint-GUID: XGoSxf8dfUdMI4QvpZOV2PKSpOzr2eEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0MiBTYWx0ZWRfX/lB64Ksbkz2u
 S28x6MDv255ywv4qahLJL4PUCj5sbelSC41muY7W7ClsMxr5IE5nkRUJ1E3XZQR0rJ1ERXDJDjg
 WckyWqQZYIPOjrljRjvitKdSUfazMK9cSfPGcZ20QLdK/tSEGVBp2H2NEEBZ/2pqDoiGqcHewGn
 slFGYs3eIThlAoufZ++9TrjruXN38EYA4u80m2n8l0FU481+VBtURLmTNdy9sXht1O2OtiaJC7l
 CrDP0ERrXAPhH51sP3kuggT5CitkoMLOS7V5tKYzALVU1m4MVEd1BdPzXTpaNbDCvD+XT+/ZYms
 m2IHWJAgH9Q3XUOz2TgU0nFW/sMd8eTd1uZh0moOu9sLUxfqN4IQEy5rMXKh/EYl0/z7IdMKnL3
 YKblzjGWkPvjuL32wphfj5bY9li7tw==
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=694390de cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=tOzzCTW8nSJqF8abkYwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: XGoSxf8dfUdMI4QvpZOV2PKSpOzr2eEZ

On Mon, Dec 15, 2025 at 06:38:53PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./include/linux/kfence.h:220 function parameter 'slab' not described in '__kfence_obj_info'
> 
> Fix it by describing @slab parameter.
> 
> Fixes: 2dfe63e61cc31e ("mm, kfence: support kmem_dump_obj() for KFENCE objects")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Acked-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

