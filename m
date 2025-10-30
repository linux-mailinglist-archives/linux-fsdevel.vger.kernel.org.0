Return-Path: <linux-fsdevel+bounces-66520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D72C21EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 20:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4E4A3509C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99187286415;
	Thu, 30 Oct 2025 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qPC7u40X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MI+szKcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E312848A8;
	Thu, 30 Oct 2025 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852156; cv=fail; b=UsKjvKTIjVcvdIUmrRBqjLVX/BGqinbcuNrRK2WKrnQvps4JXwOEpUegBsoSSLUOeTTEfwOZ4HNJdYI6wnkBATFnrSJ1aYi+ty/teZNJRQMgf7YSFw+Hzq5wLf0tes/oaxXxUveOMMzRuXvErnmZay+p6kaa/cOovtvo4nwNePs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852156; c=relaxed/simple;
	bh=jwly/kKsTV+RcbeaEiTqhilgU4GcF8duInkdO9x8+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WDE79z2y/5ihhdq2/D7wYB1RzMeV4v/NU/nCA0vEtgWWs2OgqncCop1OoYMuVwAThLLeg1dkiEPwgslql6770bl4BRpBb8b3vHRQbf8ZgAlJu1OCSwo7zbpPQKe2TJ4OMWxlWomgElnOn9FtUeUJDgAICBDSVRSxApaHfkRUYCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qPC7u40X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MI+szKcc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UIJwJZ025247;
	Thu, 30 Oct 2025 19:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lTVwi+BPa28T5c8+2z
	CkG6+lpqeti3eyMrue0J92TFA=; b=qPC7u40XFoLRtzfrkqs4R0sxYEUBMWqYtO
	iCzEi/vPHFpqjJV8q7lC0nDFBFRtNXEQP0jdLkHBVmU+zsgcdkr8zhwzUsmvXAvT
	H7mq7JHQGgHnzGDrPE+cX2kFVKUzWjXNbiIkW59gzBBTUzmhP1e7TJou6aAXqzsC
	kvUzC+ulTuVoa2aZHcSTQspqlkrWc2MkHzg64XzvMRmo/HB4sgvgW96qQs3PFjJ3
	XrplSfGND6Xn+zUkQH8EPXdyrk2XkfLaBNVjErSKwStZvqeYlUsV/ofmObaSX5E7
	p+79NlsNbFU9ByZl2GLN5TD5SNNuKlIFGHSLoSe0LJ5NJnjXVgsA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4d6q04yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 19:21:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UHpj0H034080;
	Thu, 30 Oct 2025 19:21:21 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34edtkpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 19:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dumyzvMZZWP96NiZHAV1EUejm5RolAsTpm+063LD20r3Q3BCRbQgPtNH0jVpBATU7RFux8vcD6tQF7cKVIelKI1mrNUk8Vokv99BtMneXu47RHc3Z8sJTa/CPHV3RT2f659X0w4yZ7V+0nWxSKkcVlmfuyEFrtNsUP9uoXhwg2hMtLCIuaWW246foY4Y8yR9GQbE6Aw9RVXOWqEKjpBw3WjMRNljtT/gYPhWYi0V6cZv9FayGoiQiIksuq6pqV2RV1kXlx/T7xoF3ZP6e1vJiwrNxlf7KW1GHaHlRj8/5h/nDJ/R1NvkvwLp/wR6y2xyw9D2QnnfPLr6iUdBUKTfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTVwi+BPa28T5c8+2zCkG6+lpqeti3eyMrue0J92TFA=;
 b=s54TClgtrvMkkxi9Py1rOt2Dk6tAK1Br1sInj3Cc81YF4GZ57hh2GnsJMQ47pVO9NQrZdlNRjqeu+t7xUaZu93tyftbP0dgvpqX188uwPARKbGh6wKipVPrKCOx3VAbMTPjun1bxS7Uw4ZMtz3lk8TpeYxwXqjieLbk7zNW7OC1+EY1E+WRYImL1sLQF89qInu4ppwF/6qJwgFbJhc/B3/3ct+vkyXEP/tbzo2S9F3+XXbJEsOixCtIN6+R1SVoS02IDgFFnf27JghDhFQ6h/fbuYi2MRXLVoRA/WKroXqAvJNQrkZvlGl1kTWxpVi0+vz5WlTLlEwVQptvydsS+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTVwi+BPa28T5c8+2zCkG6+lpqeti3eyMrue0J92TFA=;
 b=MI+szKccNpMHCZLVX2aNSKFEunzXpDcbGreRz+2eCYHJeO0dEpGcHdzLaOf03KqkMAgH+OAfzsyQzsks/iurgUg7f01fPwBZSm5ANwWjHVpukAGJCtgNPtsNwJsfh07U7AwmAzp63p9VffWicoCNjJ0WLnI1bN+pioTmGJJxuYQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6861.namprd10.prod.outlook.com (2603:10b6:8:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 19:21:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 19:21:10 +0000
Date: Thu, 30 Oct 2025 19:21:08 +0000
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
Message-ID: <6fb14cff-00fd-4bd0-8fee-e392e52f61b7@lucifer.local>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029192214.GT760669@ziepe.ca>
 <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>
 <20251030125234.GA1204670@ziepe.ca>
 <a7161d7d-7445-4015-8821-b32c469d6eaf@lucifer.local>
 <20251030175421.GC1204670@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030175421.GC1204670@ziepe.ca>
X-ClientProxiedBy: LO2P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 042b0f25-a104-4715-a9e1-08de17e97bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CrU4DtMWbGnnKck3N+QfB46eZ+N/elp2PH104e+QYDzw2yJrxS34zaV3jChu?=
 =?us-ascii?Q?O1U7flMKBUwbXB9js5GTx4lHZzbrX1B6PQKIRVFZoA4pnQfDxV7y/unkvD3L?=
 =?us-ascii?Q?94GGyUn8cxa+I3U5T8RgD49/aAgyXpwg7N8irUBl5N2g2UNLFtAGwce/pr3R?=
 =?us-ascii?Q?7wXd8vBX1TXTpsKdhH5SX5w/pHDI4NZBal0007i7pra3UfsJOKkb2hMYEirk?=
 =?us-ascii?Q?H4akvjvHvxXyT52v/LutlqVbPf10NWR3xTO2VhmrCVOdLpzgaO0OgZQ3O+Sl?=
 =?us-ascii?Q?y/rTN1mvcArm016ZTDAVX9vGB6uRcfTQtrLJG58C/ezTe1Nje7jGC2KReBnO?=
 =?us-ascii?Q?WR8cYatEgt8NAfSz6hzI71cikB0FE7XDy0LPiqINlVE+J59Io/lALQR6pSiJ?=
 =?us-ascii?Q?v8xgQGGuoJlwHkJrrgqtqvqVtpORpdo8bbCXuHOxJnahkPV+FswOl4tC0ro9?=
 =?us-ascii?Q?U/EI/3tKGSwOcJeJUuekj3Z5RNh/1+9+TV6qXx8/FBRA48BK6Jo18s3I0VDE?=
 =?us-ascii?Q?ZEvZT7hfOdgMa8mPGiNP7UINLfD+zmecFb6Fvt3ki2/eoYimJ3b4TNcyqeMd?=
 =?us-ascii?Q?q18nQ6f+bmiul02UJnKUsMeDAKQAIH06Yo1TZCYVDy/a7kRgdzDAQGIKoIms?=
 =?us-ascii?Q?4gctBIRZSsSbUHAPNURCLHoDKtbkHhhJjv+8dHbyajDPSq5IwHKXvcmqwKm/?=
 =?us-ascii?Q?eU4SC/NvT29KRpJzvsIKTcwGkvy+m6IElNOpsR8OMfTgSdOa7LdB81n5prWd?=
 =?us-ascii?Q?hMcmKe4YGZzIO82hcXu6vqJqsV7uOE2/mAyTTF6etme5HwN4szwnl/fjY7Y8?=
 =?us-ascii?Q?vepLU+7Kbr4KhhU0/3LSMs5sO8QR+mMZmGZ6wmEfFGOMBhMRfaWJGD2XDUey?=
 =?us-ascii?Q?8XqL1FDwNic1LRm4HyxkwFcEhM6S7hW8fdqU/DXGN3BqntIT1eFnxhzSrTSm?=
 =?us-ascii?Q?GqpdU5PelUoXD44MoKIsNBTT244suNeWumHgqacHtzb5dDMbgw0ltZTv/ByG?=
 =?us-ascii?Q?h8l5D/57kgSYgfuPQNgd+6dia63QYNv5jVVlS+Sq2B5JY82huBlXdFh8kW/8?=
 =?us-ascii?Q?dSq5C9O4F7pMMEXPEINx7YXir7gy0XFRAUgGNHRmKFB8k7XV8HyAKJY1vimt?=
 =?us-ascii?Q?ddnoT9Wd4yCIawoIt2nTY9s9kHnSzvFgkji2fUERmSzMr0/mMdV+gBiNkzeD?=
 =?us-ascii?Q?dqwMYdjBH8TzmZVnUQoyCziGof+RIGDhN9cRHiYZEDKhU8NR3TMxI1aOSx2H?=
 =?us-ascii?Q?sisiZaTNQQsbVWvearlWZeXoL2ClDJ41SsUmcvjgVRY4I8WkYmh3vHC0b8kL?=
 =?us-ascii?Q?GH57rE5YECpEJMveF51u9FeNWCSDuZL/iraYizcVCNysdokG93cbMaDHc23o?=
 =?us-ascii?Q?F1H3UeYXAF0IZztJxz6l8MIQNDUYRi5z3a2snSTlaHAXwABZ2NgnvpeKj5wg?=
 =?us-ascii?Q?Urgpu7pjccq2ZT/+YYKhuyq+zvrirHHL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WOoL9dif6/YrzIqRFAeHuzYQrmGlFADlYxJUI/c/r+5z+0N4e57greAbynS7?=
 =?us-ascii?Q?0lsuiuMm9Su0Jkw1MwfVTba0/Ntex6HQLN/ULTzSBeqGCjbaGDw1d+BdeeBe?=
 =?us-ascii?Q?GMw327115GQPToEWms6oYsxYwzdHBfgGGhWzwAdXQG/LzGAb1l7UBh78OpKi?=
 =?us-ascii?Q?j9QmEJPLloQQ9euwuYR+KUMYXu8U3vWMMdG5+R3juEK88UuxbGQS1Vm4Ycoa?=
 =?us-ascii?Q?BCreYLL0AZicJRqPSk1HqvqTWvjHi8oaeCSb4SnsECjPby5TCv9I4Ah9T6/r?=
 =?us-ascii?Q?L1P6dKRRSjgaGbPWTyPKO8XJ7dw5HvKf6hE1up1aRTqzVwWQIWX6hed+E088?=
 =?us-ascii?Q?JuYZZeY2US2ySKZsdEsoZZZw05iOs9W59mh3Syj+QZRfrJtMPhqDk908j4ql?=
 =?us-ascii?Q?lBBCtGhgQpvXhUbIrryCpT0NHlJ1T94Cq/kUdmYUZk72mvo8H53lLgvoeflt?=
 =?us-ascii?Q?AQoIcC7WgsqWwvsXLwYGTc6ytgI9ve5cADW+zHAYVMYnEJKFV+03SAEgnCby?=
 =?us-ascii?Q?HSZ+NRx5tTYGiixkg3gQ9AbOcHbMY0t0X9pSgY9dyFyjFj9VJrdpI1kAj4Do?=
 =?us-ascii?Q?a4i1aA8SGlHTVrCayFpliWtN5ns6Wwr7wNrdwgures/7aVBQFIMk5oGWPSsj?=
 =?us-ascii?Q?f2P7wVE/18yuoyrKhTSBwKBbFMv8SK/aE1TyUR+k5IZKJVlO7itdItV1xn4X?=
 =?us-ascii?Q?nr//2iqarY1+LubPiQ/z7FW+7W6tqbojhBYsZM6/0MG+hHsJyETXChynTxje?=
 =?us-ascii?Q?MlhqZ1DbSmXtuwx+gmiMVTay+459FGCmTh1+Sh3l4BS2WDL2/wsmqnKNWOeu?=
 =?us-ascii?Q?O/ew/aw1Jnvtdq5vUTLK8Lnvdfplb4MrvzhFI5aBeXE3HNPACsSDURkmZk52?=
 =?us-ascii?Q?ls3Be2wn0U9QVD8onZWioh7ASgrUCqMZBWgOIqCAkno5JhyOhW1Rh/BeYJ6u?=
 =?us-ascii?Q?NJO+hdSR7h3VBVUCjQlW64jmFt2ODZq3vV/BYVEa4sgFrpk2swQesxlQeNaN?=
 =?us-ascii?Q?8xjFdu7Tha+HMUFUnpk85iuDQ7qgmSKDLqnhu+02cBIwtS9HdynncxfC/q2x?=
 =?us-ascii?Q?+QbxDs1qVhSD5NiryUc0SQLT2gAqXmeDjCeqzSuDjAJPBEPR3cdv05R3vjks?=
 =?us-ascii?Q?a1X+Cnm14D97/Jggb93bJVc7Ym/dzSoWdNCQAsl8pxuIVcN3CHf/oKi9AaA5?=
 =?us-ascii?Q?LIdY04pQ1B0NRTJL/8epe8AWDBKMGUY2+XZiovSTCJXF9bu0kC5YqEeKcoD5?=
 =?us-ascii?Q?AAPUelnEm5UGcK20FAk5YZYQRwyOC1UkrpfjWJcgVxEIqq+X/TJ2I8IfrN5z?=
 =?us-ascii?Q?vlAs2fO3Cwr39GBjiTI2pEaBubRdO3BlxdIpNuqn5v9Von198qat9biIYMfF?=
 =?us-ascii?Q?4k0a4NzvFEWO+35t7ZX9XNo/wWxKUD+s6sbYSjvE6WEefOYp2aWmjFXgDB83?=
 =?us-ascii?Q?AO6Bj3d/6VQ3PvinkLmwAPkh2yYuFwvHeMFx4iPBk9PZ0L9AGyVRzFK34v/l?=
 =?us-ascii?Q?cDltGHiJtXPbybh0hbwYvq9V4b4zdEFmDk0wuOvriImg+Mq3qzYJITxBeVjU?=
 =?us-ascii?Q?RCTy4xdOqKiAnurt4iDPZ+4iaim7i33io7T3E9JQcRKT2gyXZnTKQTtRhvlt?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	te2qTi99k7uWG/MDmBBKnvmJEvBB00Hx84zK/jzOyfn3EpgwsUiukyCn6rP/EIwcH8Q+AEl22jco4BXv8gOerHBrttpLy+RyAfKF+I2LfrvSNNNVgr2MGWSQIYEb61llcbx5Y/rugFYGsaaqNZ532o4l0cY48y94Mp1b6kmesPRadO7GYUmo7KwV/SCqe5oFgv+nYCq+31+BHHu4JQz1/XNcF/8OGled/dszH/RnxkDhWnSH6AtvSQ5pJPbYr4mKn32PYr4KMId4ox3llCvfeVib5hrrt2YO23+ICuNGRkl+Evh8EhEyfQnuJ9ktyMrhbJwdLjLWEPibqyWrFxIQidIZG51KLZq7GZ7GXzY1+g0k14vl8SbIOaQcwMh427ugVLyrsZuPu6ZEzDTXVUY7vk+Yl/ozwrgWW/umLjVzKt0lmwl86oVWnqERIXVCz1uztH1WnijZNdg6zhaN7QxnQ1EXI0h+GvrZfFril4/budT/86oXcS33csgCbmcaRwg900ce/puxsWbzANDK+szQzfBf4fLjPZXyUMq5CR1JhdtRs2ZYtOKZZ9qRfh9zHTSgIYhURQdSxZxKmXLdp0K6KLdFe3290HBw5VtlY84PlSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042b0f25-a104-4715-a9e1-08de17e97bc7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:21:10.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5hSp+i0Bqy2ofGTTGjtL80X6oev14QqNtD5MYrX7A7kvPk/+D5zbd8o5XxWcdpf++1DsW93OBlmSp7JQxvmfmFKIuNhNdRf9QmRStGlqzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=619 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300162
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MiBTYWx0ZWRfXzIhWcMz0crxN
 izkQHjCg1V+nQ7G98l7eI8BvPYU2CLNCVlk1ZXHBX7WoIHcYflmOzf22YzVFe66ipWFrh1d/3pj
 THPbYc7qsbFZKd/yGKhYq2aTWIK6QKTln0yDYhWz3djt0wsuYI6PzfifYrJLVRG29zacrY2gCEc
 RC51nZciSYod/L9COJbRLX6KIDl0CU1Pih2SsgUCjEZvH1lxxl5YTRj6NIZ46IJrOBos0sDU3Jp
 1FdRLW/lVhnS/gHlzmsl6t3HYAMchV5ag/bUPZhqVWCPClNW2ikzjhklpOzxdKerreX/xwBgpa8
 cfXAm5c8/HqdQOZi5AAvkX1WiJACZdSLmyzZBJKhvE0XyZlDwvhsmrOjH3VwhE6VZoLJCFumltJ
 IDfv7bb1L8SWpwzxpnp2JT7JYlepsJlBRi+JTcOylMH9VKdrwZI=
X-Proofpoint-GUID: lsd4rHQ8BOp6zI9Uk4D3dgsJKAxHPenC
X-Authority-Analysis: v=2.4 cv=bLob4f+Z c=1 sm=1 tr=0 ts=6903bab3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=498J7lsigpFsgnIJyywA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:13657
X-Proofpoint-ORIG-GUID: lsd4rHQ8BOp6zI9Uk4D3dgsJKAxHPenC

On Thu, Oct 30, 2025 at 02:54:21PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 30, 2025 at 02:03:02PM +0000, Lorenzo Stoakes wrote:
>
> > Yeah, OK well your point has been made here, the compiler _is_ smart enough
> > to save us here :)
> >
> > Let's avoid this first word stuff altogether then.
>
> I suggest to add some helpers to the general include/linux/bitmap.h
> "subsystem" that lets it help do this:
>
> #define BITMAP_OR_BITS(type, member, bit1, bit2, bit3)
>
> returns a type with the bitmap array member initialized to those bits
>
> Then some other bitmap helpers that are doing the specific maths you
> want..
>
> * bitmap_and_eq(src1, src2, src3, nbits)  true if *src1 & *src2 == *src3
> * bitmap_and_eq_zero(src1, src2, nbits)   true if *src1 & *src1 == 0
> etc
>
> Jason

Yeah makes sense to put it there.

Thanks, Lorenzo

