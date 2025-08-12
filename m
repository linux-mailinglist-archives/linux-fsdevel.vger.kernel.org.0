Return-Path: <linux-fsdevel+bounces-57549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA4AB22F3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9967D563CDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512BF2FDC31;
	Tue, 12 Aug 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5yw0hln";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h8J1Qf2Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038152D9EF3;
	Tue, 12 Aug 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020177; cv=fail; b=dy0iWmRfvWjpAadkYq+vv/0+lHkpq6KFkNtwkppRyX/ICbhJvdsbqq70MogwXCRTwSVyPqwW7HKlidzKWLuvRUk2MRAVt6phrV55NbiLoqwVFTkW/C3Ui5kbvtBg21ivGLSUtzH7hD16vk2Z8a9op0+c788KSE+B9j+dy4jgALk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020177; c=relaxed/simple;
	bh=T0vCL9CdjQZ3LLtGjqSIMs762G+ARwKejlfk1swZ7ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DK8bOi2OA4kzCcZ1T/KcUzkZ8w7fb47w2636UscBFyWihHEpO1VvdN9ryDORY/5ZGLm02L5PGtXbKFq8hJM6hC+7c3ytA0bGT7gqvnvN6Eh+8SLNilHFvgNPhDU2a2VtLhavipgK4Z/SntWz/eBPkEmnrKEzPTqmZ4EHD9uCtW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S5yw0hln; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h8J1Qf2Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC1wu005480;
	Tue, 12 Aug 2025 17:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0fQxmTULcPkZN3rooC
	UyDgfyfbL9xaqvgQXyNA88KU4=; b=S5yw0hlnTA/maaXdvizKToYl/gbFYPvZtM
	2hKnaYDs4q0ppFoVNqdj8nOKLWcQZfHPLtKv6okfnzyLJbFuqW8bSymC/hFWYbcF
	kLZF/bP/VyvC8WsSUyZ+pR6M1HhmGHGY9RGWPq0Qx5m1QwsbY6rRDNk3i+EBNvy8
	uMK8KVI7hD0UpljVLdTWQcBUNYr5ZBRL3taq67CL+LpvQoKuP+31OFvNp+OBvdUr
	8SYRTGwgqTLJ9ESo3qMampxr1uk12DiAYE+bMN5aZ3PBS5xvDT+JHwYbeKB5zlgM
	GYFyJQPS/GctYmyvIskKIeTpgk0/0z3+JSaLVtcqtfaK5RlEy+gw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dn5jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:35:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGQFO1038532;
	Tue, 12 Aug 2025 17:35:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgtm3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 17:35:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQ+IcRBJq0/wzQfyNjCjYg7N4YUw56rHZfZq46UURFb580FrfOVTcdPpkDiGSh2Gvq/syV1dDWEKaaDvZcEdVkfwtzZHpM3bKZjvGNUcaycrPTE3RnC7gDwntt3vPfYhIEoSNAIWVVKkxxdxF9vNaER/7/wkj+EVzsuzX4Iyn39EVMjHZ8pCWrY42HzSBXj2xhLLvRwIZS3+xziXMe6D0VWaAzEHXJZl8hUWrnWALFOPG4V1Wksv9dyTOb2Ob6mEDCEtazucMNnPgsFyamxtyE3B7KllFt//oEmzlZyHKd3e0yQXCSdMdsmuJKae93RzfNf/3MGvElP+gByYp59aJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fQxmTULcPkZN3rooCUyDgfyfbL9xaqvgQXyNA88KU4=;
 b=NR4xVGL33hPhUVcge+0frUzTdwCRI1Jf16iesPwbR1cqiwHMQ+I28dw5m+4ZKZPsMWuxRvtxY2d0or4/5rgXKBjmMWJOzrsz1IYv+jEPLS4aqVA9hZlYodvoIievGjPN9wTE2MHZrvWCmLfKBUxQoL1iD26qXKE5CMtC4b9x3n+XyqZk8Wdeo6yZiDYhzYf9/AESpTz4JTc+Py7OVrPaJylCd00gzWEaqWWxwoKYUh+GGqoTXBip1VSndvHOgegsjIEXJ/cXJVoT2Y8BgmFX1LmFCuvPa5j3wOqj78T+wMG0AWtro3eE48UwOW2poHSHMR2MGX7/8UxyhLD93Z+KHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fQxmTULcPkZN3rooCUyDgfyfbL9xaqvgQXyNA88KU4=;
 b=h8J1Qf2ZTjHr3sJ4X/apiY+Es+KK6WLSYr15EXRly+21r8z2XNH2oR6m/BhccKD3SOKb4Bngdxjlo1CosUoQn/EKrY2T4wNLyGj4vkAjtTKdtC6UVC9EbCe+OE1SBTehuYjd2OaO148YoqOIHKLlF3aB0on0zMF28DlQko4Ugg4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 17:35:26 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 17:35:26 +0000
Date: Tue, 12 Aug 2025 13:35:18 -0400
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
Subject: Re: [PATCH 10/10] mm: replace mm->flags with bitmap entirely and set
 to 64 bits
Message-ID: <scl3mdbh3atwaky5ae7sh2gyru6nomx6pulnifnmbj6hd4ug2n@ykbzkzo7e3bt>
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
 <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 35120f2f-16d4-4a7c-1147-08ddd9c69fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W1h4wlvlqBq4HN7KdLFSfMf5odN+sK8lJHRYI/61GM+ZuSSQAWTqmqgkDaQ+?=
 =?us-ascii?Q?rtO92QeMF6rsSo6ezgOmGn/i/lfgkzMC+xoD7ro0RSH3OUdDkrxlM2CEDGGj?=
 =?us-ascii?Q?CY9VUYVbsL4sh2UYLtgutc2me6iPHp85fMj0gq+Vg60isPBtoqdfDCmS+LQh?=
 =?us-ascii?Q?gqKgG9QIuNQO6Adw/EJ6ZZSs5bmNyv6kn4aEEDekwQewG9GFk5gn9M3lsvpb?=
 =?us-ascii?Q?TWr06vfDRbwTHg80Yx3dst7D6WLfSaArE3u1mvRQeLg7h6+3RFPCJ7bwcJtl?=
 =?us-ascii?Q?cffooIIlOzvqQesOQF+LPRJoTYaPIhioecDq/5wRfHHpuR+VG/wlDHovOKcs?=
 =?us-ascii?Q?VgskMSyQZDTZDUp8EcPxe5yV8zaxCW8dx8lcG6i1OI3WLOAhatV51gZmGOkE?=
 =?us-ascii?Q?9BXLGzbRN5iqxQsQkc+h25uO3xvlW8vNOGsdkLKD+A/QaiHzMzNEJNyCOsO4?=
 =?us-ascii?Q?AD87Ws+tyKCQntzsrHnDlnw8lbEBtkyW7FDMt/E9G63tfoCMO2Cbjcm/V+7e?=
 =?us-ascii?Q?l0rk0iPp5mlYItRYpR1IT5sfCYKvuahFCdiniB0m6HZj6+CKfYkJTSy98ibe?=
 =?us-ascii?Q?YV79EUfT+3RxYuSSlgGEiSTXaYOjQ1hRc2yAUJ7Swq4qQGChErXLBp0ipuWl?=
 =?us-ascii?Q?+U9hyYhbsTaNnRyAsYrE5BwN7tkp74DSvPsJYRHQPRpFOsENjrsQ65iwgQ8j?=
 =?us-ascii?Q?5Ah6b7+54kwRPLHL2M7NUikioprBn3yzqOjD8nQQO6iTNsE2SscmpHudVobM?=
 =?us-ascii?Q?gWH5tckECv03VGxmPsjXan98SLB2Ts4+NrFGk9NxbzbOksIbQCrCniToJHDO?=
 =?us-ascii?Q?MA18TB5GL2PogJs6iLeRVri1eQFZFnr302tYOxYE60lOiP07xOIwSAceX8aI?=
 =?us-ascii?Q?Y51w7Fd2h0mtKz6PdG6sNzLQq+68XyQrbPvkJQY+GifF4qOiFt56ueyEQSQQ?=
 =?us-ascii?Q?epc9ZYGcKuDnFZg6X2lvhL4eB7F7cOc6458O35kNRfBYeg1tC1/urMpgbKfK?=
 =?us-ascii?Q?vjpUXUXj2g+tQ2xVxBbbqELTHCZi2kAev9jFG4a+r7LJ1RqfQLJ2KCIK3vxT?=
 =?us-ascii?Q?ufc2AeqNwgfRdVpwzrBDzpDFiA2HZN0f6rsRfVGvzP8uFFyEs4oTr11UmZJU?=
 =?us-ascii?Q?QAAbZM8Ljs0W+L5vLe/k1tWRod2cLXE2IAVgcWqgcuX/zApSLahxcObK0TNE?=
 =?us-ascii?Q?pEaBGuekMFRAMZWnZdlOaPuLPHC0VV3UU2P95WKy0D193AysksDVICWWcs7Y?=
 =?us-ascii?Q?kpQipevCt9LkxvH54uFLaV+S3rQPzd1vHz0ktN7mDkP4UiTdF5geYi7L+t9b?=
 =?us-ascii?Q?v/Otn9K7VA8UFfUGv+dOom6TE6toiLp4AJscbL4K5wtBjCTpJBVXs33wAyEM?=
 =?us-ascii?Q?vJCAyxVD6Vi6V7QHfUhtK/potgs2gdPVUXlXYAyW4x5pzffxqUo40MM8MOwJ?=
 =?us-ascii?Q?dF5YyVdq1fU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlNhUe3Q2StsT6abM0hXB598Wu8X33InjKksFnXFD8I25FpkKH/PUpl+HTTr?=
 =?us-ascii?Q?0CwnYYl6GWpbXNK460ACF9tYVf85SR1s5hDFLRsxJXKgaL409iNCDBKVIFDR?=
 =?us-ascii?Q?MBJwQHKi1SgsAdDz/BtsPwjjZXC2W8u1efZUrL9BN+II2eetmGtdXdmNzlwH?=
 =?us-ascii?Q?Dt6x46Idr7EmKt7fwDlX6fN5wyePxy9u9cQH9zOJK9cdX9rHUrlDn5T3FDzx?=
 =?us-ascii?Q?q/LkWvhLdusLfqA7X++S5g9XfIkyVr8YpS5a1I4Z37FW7qkzCIJuDWm4eK16?=
 =?us-ascii?Q?WeULP3SEojabOs3PJTEoO7rqwM6LI7LJdEoohcp0FjZSlr/bGzvsdD4tPNbc?=
 =?us-ascii?Q?kzaTrRLIV+A1QI5+OI7e4rK1e5Y7T4h05Ks+UKvDJ2cmv+r75ZtPpzJDWl1k?=
 =?us-ascii?Q?WWjZMrgKH2u62RzW9vdMepoJYYtkxzFzJuGlwE/Shh4bJQpfA1TQzciqmCq4?=
 =?us-ascii?Q?YsW1B/Dn3cPlhXi+MlXH5e0v8jrFn2HxT7csfFSxwZ2uXf1ufl/nVc7QMxoD?=
 =?us-ascii?Q?kJAnd+1RUMJ9pPkYA84Ivr8G07YzkDn6VHG9B2cid0TfJ3zm2cOie8G2qKtT?=
 =?us-ascii?Q?1PPuuGcIdzoZHZ+/+cay5ds+gjldEDlT1+TJnNW3Wp74goEs3+ij7/oUxjJg?=
 =?us-ascii?Q?P1LlyUi+ubxTmankkqojIMkCTfGmpbYHLAB90WI7kMHY5V6NorrRFsYp6LXS?=
 =?us-ascii?Q?sPBZTYO07nHvyVrH+0W+akg5cOMxIPGH+i4cvbuqlpw+N7bLxNITLnlxxHL9?=
 =?us-ascii?Q?iU99j2LMMf+mDn9ePZTOwcRUG3D7tGJH/StZsRf+wBgnYsTgMC+TpU8FObqS?=
 =?us-ascii?Q?KVq4M730ttMfyfS+tKtuGtu8RgNDiyMiB+HeXDgZJqdNCLss7RVRdw52xT+l?=
 =?us-ascii?Q?iNn6IilCCNrdxeswLUmRx40FeqUeJs95QZN19JIsGR2Scekz5ZejYLWaxWzd?=
 =?us-ascii?Q?58sFhMgEPfd/Znm1EfpFMe8KQm7WQzjL3rBqQeALhnkCyGRKuOsh+ClP08mw?=
 =?us-ascii?Q?NSs4JFxjl/8iMXL0SFBsY/7qQUuTe72WaA0EMoAn5jNGRQo9/dlHwCYKjtUY?=
 =?us-ascii?Q?18dqmcXwnr3etq3IbfEs4FZUlyBq3sZ1lUf50xPLNW2Jwkkac0Og8HbtEEW9?=
 =?us-ascii?Q?SBttbsJOFCyIjx6lpClegwne9ucgCdWCRUrARJh6Mo98Yf+jgeVlQ93r5had?=
 =?us-ascii?Q?eMSRmTedchmaiAhI+EFxSazXXG2CaFlDZ5d1hzimo41e9hV3mAT8CZcI1EbN?=
 =?us-ascii?Q?tsfcT3knR9khH5fyaGAH8RWah1vswTbhnmjH/SGmlftv1UF+b+AvhcaMpfnr?=
 =?us-ascii?Q?FQRt6JpEiCmMa0NjzstUtXeRkZG5aDVi/Qxf/zXfKrrCjyqg/XCslNvN91JT?=
 =?us-ascii?Q?7ZQvqm3QS78rZNdoVChTxi6q0uXQhUr4RzEaoc2yWQ8aQIAPoy9Vhzy0h7UK?=
 =?us-ascii?Q?lnq1XA0wb723wUKdqNXgQGaSsocy3LzkoDsS95dEqTKM5CF3O/qg6MndUl0S?=
 =?us-ascii?Q?bZc1xYMJp3B2YrxToZ/hXuftzbg8mgjnNuhZ6aAiOd83pqxdk1zhVI1zX77N?=
 =?us-ascii?Q?YzEroj7DcyFcmq6d6eVZCxJx0J7VJ45YzqafF/44?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rDKM9XyDCu+MR9wPT4gi6y4DRma09HPCHVoYUiOxrxFS4a1QGMlLoVNI7sWKOpotPYsLBFNZ3kvGtWSFhG5zjCnUubHwtOKPYswPhavWgj1BLGIw9MlnMbsrEEOwwlS4FXYHPVwYnowFYhqNRBj3uIrGXvbtM2OHS5tj/azzZP22wL7l3n47hmbIDhEMHusYsFUgZsVtD2bLrl9w+Q2uhijWvvn6D4Pl9Eux/yhwGoSjkBSB63ER5Bu/IgXOv9azTMMGRXFyrUpmo3+wTUTaqp/YBSlCwCWpK5NP/KFeQ6ekHR25Xq4wjzRx7xnrbuAB+f+8KjBpVlLjj5JRLHfxzw5rXGcNol4ZtGVVy36l8yV4alanmV4YtkBQLVFWDQ4QYDAIkU1XITIHA9lnQr8z5zOzuRz6s4Hlb1aT4DXpw/HM46Cpnh2BvZnl9l8XqOxX+klzaWrBStXImzrL9tAZvA8yrDLMXWR/vSedFnN19SrS6ZUOg2yvyUQLugFEiz5iFQGOWrxl1RU2MfeCNrWx10OlfzZmk6YGLS6tF3TvqS/nNe/yd4vW72mAOo7R/ec5XLSkQu74UMbHH5xeQn0/IBjRIaosdq3Jp7n1mIMJNCE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35120f2f-16d4-4a7c-1147-08ddd9c69fe4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:35:26.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlTCS1Cdgix+37B4ilaoM106lOMs3IBH/GuIwbJw/cL97D5uBlxoTKAoftjons64t6Mez3/XEjdIPzLBfPtwAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120168
X-Proofpoint-ORIG-GUID: qAowldjd3sAjAH4WkjghVxAgHqoQSmRQ
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689b7b64 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TEce-8w79EXfYalXPk4A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: qAowldjd3sAjAH4WkjghVxAgHqoQSmRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2OCBTYWx0ZWRfX7oqWgc+HZzkl
 iq/uOqLKxrKyA4cJNXKWcplSAXx2fLF1sZrFZrdZatyyn55giPjfI4Kva/mbvw68C+9gD0fwpOL
 JCU26MX+LmfnswRIgRDWcObD9RUK+AWmZAuatdrDsn2NIHJs+aGj8JI0hppHNUJeWlywI1rmj0w
 cCFhv786BGBSIb44Rad2xTyVah2TS0kpxmhzESJ5aOQJ3WhhfhMVQL+FdWCR6ezcLDpbliu1Oel
 UnQRhOebu+gOzo7WggaIrcQHR/VMPlK7Jnt9ZZ6MmZAnpawseeqhJqX+AOmq1AJsx9WlEIRc6iM
 +R0xNVz53wbp4rCI3jqqM59m0guksvY+BGHuLwHItC8E0sL1T0HO39RGsBcpVyafxuWvEvECuPQ
 51t0P0Rb5880ThB35eV8WI5lPzgYBymh6JBGl/wc8hLSFoBwrf/eYjgwKvEuPdrZr2fOrzJa

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250812 11:48]:
> Now we have updated all users of mm->flags to use the bitmap accessors,
> repalce it with the bitmap version entirely.
> 
> We are then able to move to having 64 bits of mm->flags on both 32-bit and
> 64-bit architectures.
> 
> We also update the VMA userland tests to ensure that everything remains
> functional there.
> 
> No functional changes intended, other than there now being 64 bits of
> available mm_struct flags.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

A nit below, but..

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/mm.h               | 12 ++++++------
>  include/linux/mm_types.h         | 14 +++++---------
>  include/linux/sched/coredump.h   |  2 +-
>  tools/testing/vma/vma_internal.h | 19 +++++++++++++++++--
>  4 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 34311ebe62cc..b61e2d4858cf 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -724,32 +724,32 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>  
>  static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
>  {
> -	return test_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline bool mm_flags_test_and_set(int flag, struct mm_struct *mm)
>  {
> -	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	return test_and_set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline bool mm_flags_test_and_clear(int flag, struct mm_struct *mm)
>  {
> -	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	return test_and_clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline void mm_flags_set(int flag, struct mm_struct *mm)
>  {
> -	set_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	set_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline void mm_flags_clear(int flag, struct mm_struct *mm)
>  {
> -	clear_bit(flag, ACCESS_PRIVATE(&mm->_flags, __mm_flags));
> +	clear_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
>  }
>  
>  static inline void mm_flags_clear_all(struct mm_struct *mm)
>  {
> -	bitmap_zero(ACCESS_PRIVATE(&mm->_flags, __mm_flags), NUM_MM_FLAG_BITS);
> +	bitmap_zero(ACCESS_PRIVATE(&mm->flags, __mm_flags), NUM_MM_FLAG_BITS);
>  }
>  
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 25577ab39094..47d2e4598acd 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -932,7 +932,7 @@ struct mm_cid {
>   * Opaque type representing current mm_struct flag state. Must be accessed via
>   * mm_flags_xxx() helper functions.
>   */
> -#define NUM_MM_FLAG_BITS BITS_PER_LONG
> +#define NUM_MM_FLAG_BITS (64)
>  typedef struct {
>  	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
>  } mm_flags_t;
> @@ -1119,11 +1119,7 @@ struct mm_struct {
>  		/* Architecture-specific MM context */
>  		mm_context_t context;
>  
> -		/* Temporary union while we convert users to mm_flags_t. */
> -		union {
> -			unsigned long flags; /* Must use atomic bitops to access */
> -			mm_flags_t _flags;   /* Must use mm_flags_* helpers to access */
> -		};
> +		mm_flags_t flags; /* Must use mm_flags_* hlpers to access */
>  
>  #ifdef CONFIG_AIO
>  		spinlock_t			ioctx_lock;
> @@ -1236,7 +1232,7 @@ struct mm_struct {
>  /* Read the first system word of mm flags, non-atomically. */
>  static inline unsigned long __mm_flags_get_word(struct mm_struct *mm)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
>  
>  	return bitmap_read(bitmap, 0, BITS_PER_LONG);
>  }
> @@ -1245,7 +1241,7 @@ static inline unsigned long __mm_flags_get_word(struct mm_struct *mm)
>  static inline void __mm_flags_set_word(struct mm_struct *mm,
>  				       unsigned long value)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
>  
>  	bitmap_copy(bitmap, &value, BITS_PER_LONG);
>  }
> @@ -1253,7 +1249,7 @@ static inline void __mm_flags_set_word(struct mm_struct *mm,
>  /* Obtain a read-only view of the bitmap. */
>  static inline const unsigned long *__mm_flags_get_bitmap(const struct mm_struct *mm)
>  {
> -	return (const unsigned long *)ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +	return (const unsigned long *)ACCESS_PRIVATE(&mm->flags, __mm_flags);
>  }
>  
>  #define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN | \
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 19ecfcceb27a..079ae5a97480 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -20,7 +20,7 @@ static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)
>  
>  static inline void __mm_flags_set_mask_dumpable(struct mm_struct *mm, int value)
>  {
> -	unsigned long *bitmap = ACCESS_PRIVATE(&mm->_flags, __mm_flags);
> +	unsigned long *bitmap = ACCESS_PRIVATE(&mm->flags, __mm_flags);
>  
>  	set_mask_bits(bitmap, MMF_DUMPABLE_MASK, value);
>  }
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index cb1c2a8afe26..f13354bf0a1e 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -249,6 +249,14 @@ struct mutex {};
>  #define DEFINE_MUTEX(mutexname) \
>  	struct mutex mutexname = {}
>  
> +#define DECLARE_BITMAP(name, bits) \
> +	unsigned long name[BITS_TO_LONGS(bits)]
> +
> +#define NUM_MM_FLAG_BITS (64)
> +typedef struct {
> +	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
> +} mm_flags_t;
> +

nit, This might be better in common test code?  Probably just leave it
here until it's needed elsewhere.

>  struct mm_struct {
>  	struct maple_tree mm_mt;
>  	int map_count;			/* number of VMAs */
> @@ -260,7 +268,7 @@ struct mm_struct {
>  
>  	unsigned long def_flags;
>  
> -	unsigned long flags; /* Must use atomic bitops to access */
> +	mm_flags_t flags; /* Must use mm_flags_* helpers to access */
>  };
>  
>  struct vm_area_struct;
> @@ -1333,6 +1341,13 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
>  {
>  }
>  
> +# define ACCESS_PRIVATE(p, member) ((p)->member)
> +
> +static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
> +{
> +	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
> +}
> +
>  /*
>   * Denies creating a writable executable mapping or gaining executable permissions.
>   *
> @@ -1363,7 +1378,7 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
>  static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
>  {
>  	/* If MDWE is disabled, we have nothing to deny. */
> -	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +	if (mm_flags_test(MMF_HAS_MDWE, current->mm))
>  		return false;
>  
>  	/* If the new VMA is not executable, we have nothing to deny. */
> -- 
> 2.50.1
> 

