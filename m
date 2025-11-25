Return-Path: <linux-fsdevel+bounces-69754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E2C84596
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F093B1512
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1062EFD86;
	Tue, 25 Nov 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MrXy7pWY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/eObct0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D152EC561;
	Tue, 25 Nov 2025 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065007; cv=fail; b=dhXA90WEXX+e4aCy1qRqXqYu4LOQ4FAD9iyhr7+bjigra269OhLxYW3HB0XUnRfSpxyCXSDdJVuI7OIv0rBbijM/ldXqYWTdZ1Uq+0ekqt95Pcdeq8sx4xQclVL4Z7gH9PkpUZAKJKtTExcUOXwiOv/WNJ5x9rY8+ioB7rZSUyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065007; c=relaxed/simple;
	bh=T0x6WU5C6Yr+ylhhUE60oncaT8QNPpJj7wNFQvqjFjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rv63DfvvimqjOuhEryEmilZnUnCchi/Bhh4OLRrb8l8GwkVAYvyUzoJ56DeniZxmzULFOYkdOh+ZJdgP+BZ4vWTQc02cp8uBzv3j+mbhs8+1QZYNAanHOuhtpwkrAvxB0QHgscIFrWzo5cFKbHmg6q7U1AxDER1gyUwdq8sFIjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MrXy7pWY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/eObct0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP9KvHG2400796;
	Tue, 25 Nov 2025 10:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Kja+VgMl2IPCyDwu6pMD/RT4rlEsjtqZ+0wAo/kG/Mw=; b=
	MrXy7pWYMV9S9v/Wj14IXOncq4V1Th2o9h1Akncz6F20y7SPpX2CV3ic34xTyMKB
	yLZSPpjLRd1L0rpL33qzsJjYsWzXlKIWGiXhVqEBeU3fjDTyd6fHzeZysR9qgWy4
	UTYFXQee/AeAmQt6KJcpcUPBTGOykooXCWM7uxnVW1WdFIt/P2b94Gmatx5Sgrvb
	pR+e/CKdKcXYa9XxA0rnAxl5dVmmlumFpWSce4yCkwoXoDAQYXaPkr12b2GIXCa8
	/eN3nEZmwRbNO+5/FvSsmPBCEgLE/s7folhtE014y72i1HSeNL7mMRbXMHlqFSy3
	NKJ3/JzVtyU28bv08q3lng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddcdbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:01:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP9tKNP022443;
	Tue, 25 Nov 2025 10:01:21 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mk9r4r-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:01:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQSzjMOYOcAeLZSv9Dvm3lNzQ+oUsiuoGfOd9UNjBeHZyCg1D5wRfiPu/7rSYWBK5S468eEyFXNNHtio1jSLUZ9de17NG+H3kFw6rmKD9oBUF1rUIsb3khGYVe2CTfS64xkSVdqpyY3ed5efV+IK6oWpwI2dH3zDU8zFOC+bd0+XhXyqYw5VCH/lFPk3HSnVdHtQnAFW/R7ni/y65wChnXXGPRVITlkyt29OSuhiaffWFTpfWzOPJddGhnOCy88Z5ODS62z/fb09o5j9mE9caWso72ypSghT7c9BiVT0bhIUrIbnrZ0p6CUqH4ShUiCkDmmpDn47OCoi/8glabxU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kja+VgMl2IPCyDwu6pMD/RT4rlEsjtqZ+0wAo/kG/Mw=;
 b=HkWe5QgakS4O+qul3KpaCPrNS9RJxSV35zc+YZh/JhTAFa7Ajv2Wc+mtHR6Y4RyekkA/fBBVBFFQAoYDxPwqtbqnWD5Ot3VbRrvs1UChKTldHk7o77y20L3URKXFyNWfaV7hkHH8C9SUqCsQ4ufxV/UgCmIDqczuaSQBBzCkTe29UKbzgCJm7NJt7T0jJkPKpZHbe3gDzqqRcmCAbpJd7WrxY+nyN7R+hEOme1VXkt1IKsU811hXf6vCj20BOngkV/VuOun/dKJtVc794pr/dRI/MgaxqQ6EHAylUcsJit/s0oIMQnYsBbNMbxk7lUWXQtj9VF/e9QZSNrGio2WniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kja+VgMl2IPCyDwu6pMD/RT4rlEsjtqZ+0wAo/kG/Mw=;
 b=i/eObct0RbjRtNbcM3HHY6rPAM2RSEP8kHPhU4zKjtlSyr+rQFuWvdP3KM7d6RHR+MB5d+sOY5ITBuL6Q/84IyEBLpYTb7lm3vCZb2isz51HoMo2+/F+PT+7pk34UmG/o7gIBAC6/0SFBKxaa0l3mRxHnbjQeIRi4wDR1wTSJ3k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7798.namprd10.prod.outlook.com (2603:10b6:408:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 10:01:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:01:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 4/4] mm: introduce VMA flags bitmap type
Date: Tue, 25 Nov 2025 10:01:02 +0000
Message-ID: <bab179d7b153ac12f221b7d65caac2759282cfe9.1764064557.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ee6cfc-9558-4542-673b-08de2c0992ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8GVwFRWprOgRfz4PCXC6xq1YXSsK21mt1Kd2JMmmSa0wkk9myl+PZnb0nXmj?=
 =?us-ascii?Q?uwZ+9TTsfi4EEOpd7legTD9InkarQ4qhaptNrCkKDYY/1F4t7aHp+YeRilye?=
 =?us-ascii?Q?ks+Jl+zXIJIqe3REbCNwr2LZ6AJcG3p8h8xYWywHsQHiJuO2pdUIUD05L1bc?=
 =?us-ascii?Q?fjDitJXCaJkY+/iwn3AM0b8WbFuwh3Z0LVR2heONUHvrpXNAJep/EgJzZas/?=
 =?us-ascii?Q?e7eLkcrKYkRBY1lfF/W17hXUFubl0G4RwHqdeDNXCUoz4SjqnRhEtO5tCQ7c?=
 =?us-ascii?Q?iH48GmheaHF7wqhGsT85AKGvWbo8BhjjtEz0cUjyy67VPpVH9NXFZT4rnXJa?=
 =?us-ascii?Q?gj7/KHqdWFzkLzRcLCq/A6StCwZyS9vkLAROIpaA9G4cKCyk768rUo3hL3sh?=
 =?us-ascii?Q?93iPMYlC770kUJn9ZD9y0FnNyOX92t3tTNkiSBH6kvH95rB3SsSKAHxFqQ+J?=
 =?us-ascii?Q?i+WtVnV43vKZnU4hejHSPuoG31+4qb22WXZOm5n0XiT28YAjILny6xzRV9FY?=
 =?us-ascii?Q?NF64uRkOgbsrrbgIQvq0z/5OvvfMNUAHBNrBf8IgpZAaISwL74/q6jSsB6Xo?=
 =?us-ascii?Q?BFSpeHndI+fjtnq8RhV+GahwOp8g5KthoMwJ/vdCi+35Q/TpCYMJmTBhmtw7?=
 =?us-ascii?Q?1Q5RDVZ6x37Njy2Oc/zUnkre9gGuVof92iGvWyrpqnZ1WXRWkCbcJD9sNTXE?=
 =?us-ascii?Q?rWJDZYvqkrGQKGgQLCEdCyceqvN7xUhdA5PQ+6SZVDWJVLBwLNjHMn7jsnbs?=
 =?us-ascii?Q?cC8vAyQL3UH7BtgA4U9ITHJbtFWD+sRJHxgteG9BREbic2IlmHmyUwv85nwk?=
 =?us-ascii?Q?So5PT+Y0R4FX+DMP57QyaFH8iGBJE+aro8cvv9LxbUBFORXNN8j3N6ZrXj59?=
 =?us-ascii?Q?kSGNFnvSPdxKMIfLN4L4E/hw0YflBTm7KBqHztqQmofu82WA65PBjotSyaaI?=
 =?us-ascii?Q?sTeieKG+cGK52qbkFRG32FAG7DzQFWQK/H8uDU+kzjlcOK1dtWcNAB3O81e0?=
 =?us-ascii?Q?pyQCk9EprvXxibDuT80zuyL/+NgaSsVXYMjIldJXkbYihEeK+XFdAQEJXbtt?=
 =?us-ascii?Q?9QRW67IRVPWEeDGeQYKkiRuUgGkCJPir7LXm+Lr5XybHZbplV4kNDEifrs2I?=
 =?us-ascii?Q?lAmRllWGAmcPzalwjK6mdww7eL6m/2GR6Q/w8Ec6CZ02bT77/u2D+zUmezHX?=
 =?us-ascii?Q?H7yxS4Hw2sBcTxVf6+1bHvFnQZpwq3FfHX7zY2r/Jqo5WXjuzhc0WaFgsBJg?=
 =?us-ascii?Q?de3PUyE61mSSOgh7oArpyfa9YAkrd5iQ8Z8Yr8Dk1JfUns5sVfsxt8xSGIfD?=
 =?us-ascii?Q?hp/fmxDx9X4dHjXv15Z2ZYWlFIkh3bh+M2t2q+a0OQMqb7jGSbWcjfAOTEZ2?=
 =?us-ascii?Q?oqpAKywnoUbdT1BuSqAsyGG6uZgbjRc0ikSHOBFC6PfxB7FXnOmwYp7jiZwn?=
 =?us-ascii?Q?FvGk7ipcTNIvMmSoy5uxXKS29Ao8N74T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SCiNDNCSONqccxPTSYRwrkeavePofv7AlL8VtNQ3PuIFBSYwOzLuZCgYOfr7?=
 =?us-ascii?Q?BrYFmk/q5nV5u32ikbsNDTahAQESFfgjuK3cBxegg5+LSo02eDirE6LhPXyX?=
 =?us-ascii?Q?OB5hUwRYsgCz7sXCGqmnGobiqNEGL/o7mpLU7NWflRDBo6gqvxFjDNdxyGuH?=
 =?us-ascii?Q?1CjJZ5e9M56Te626/2/rWQ3MdxGNQmkUJoDCo/3lHLhqdMCfiHalZ4FGrzHq?=
 =?us-ascii?Q?rowPIhI5DwQMLYWhMbAx5tDoWOWrvCm2mzm9JzEPIxONUnma39piRpxrDvSd?=
 =?us-ascii?Q?mmx/I6VSopmUFokZiMeOA7XBsur8h44gxVHAunv48jEnoKKrxtdg80J+a5c8?=
 =?us-ascii?Q?8Vi93ji6VkHt/3M6hLNaOEKymkqRXOmfDj8H3jK5pfyIdKTeVezUDwbJfwLt?=
 =?us-ascii?Q?41tkeHn8J/5GH4n7CKkZO0czs/eFECa6Ts+yyTAd7iYlIFhmy/0e8PiPmMM1?=
 =?us-ascii?Q?ThMFIPHhzJrgXiqLaDQ6e7Pf3qrYT3+l10AwGTcKn26+dp0EIbPnQ6W2dVk2?=
 =?us-ascii?Q?51ITRkmVpdRPToFEt15Y/iAZLFsEPNzINIYfkvvcl/b+G4o4MOJGzif6dGQ3?=
 =?us-ascii?Q?5Xn4d9+sMGkiOifl67HkzblV5xXZ+OWa7Ortc08AQ2EH4aQn2DL1SfoXY0MF?=
 =?us-ascii?Q?+HdnQfcBfKggA0woYK9aYsvRTZQ25C5HYY77Q+l0ao3TiBrsIdWqq3nvtpv+?=
 =?us-ascii?Q?+5PeXfZ5HFjhvyXnYxGZG19rQsqs/SErTlIONAjesDVqGAgeRBXCUY4LLrgg?=
 =?us-ascii?Q?yuJRDX+leiwylsp82EspuwffKaqcNPnYE+OYSnTcfZpchW+Fo06Ttf5Xapnp?=
 =?us-ascii?Q?qFf16GrTTwhgZGlSxjw/zRQjAky/dWMjGjjBZZX3Ds42S+9Bbz7xtJoZlLUF?=
 =?us-ascii?Q?3Pw7tE0ysqhcCMJDT9rYmexBZBacQgDWKbyzCKh2Oh5A2cep2SKCGsf6REwj?=
 =?us-ascii?Q?sf31sCFMvKfyg64Ju3l1WEKSFFBpVL8ofRE2weEBhIIju5qimPsEXVXCZrRx?=
 =?us-ascii?Q?mV0aaXOYbXEgUPT+PkBjA7G/S4br93EpG8AwFd4mmjygH0kuMMx6jha/fygR?=
 =?us-ascii?Q?WGCW9RG8q8T+/wnGMr6yub2QOqNV3vEvlo8fi2ejnhE/WjaKg5XdkXmMV/U/?=
 =?us-ascii?Q?Q9xwCsHMlfu76NnrxMZbCM2I/VHIt6RsNW2QIVK8K36gLDx4TNx7DSspZnoC?=
 =?us-ascii?Q?JqOnBFTmk/9JkiSy998VeWfBDSwBf4wufUu2giTuNSw8cKPhGf0ueloGCCcn?=
 =?us-ascii?Q?Iwn0sYzemjQDc5cSnkhj0uCqxAbpmQl4W2zj2JojFF5n5rWzWjgVE7vpq/Gl?=
 =?us-ascii?Q?9XUgNzfwZKJDBOOFINOM/fxb0EZXvDVXTk+HsiWe1Cbl3EYb13Bx/WPxAHNB?=
 =?us-ascii?Q?K6p4g7Bs6JD1TR4Y7InZW5Yjut962VN1N5C6ctrXhzDp6iZNLCWeVI43mhE/?=
 =?us-ascii?Q?/zqAm+iOebuKXUbJhEgL1orTPcKKlB9ejUBM1odcQJ0B7n4s7DLO5Yzcs0BT?=
 =?us-ascii?Q?+fkcTsAbbxW2gIsGtbNlwDC1d8Z3uCsuJ8EIco6mYcOjyJdgT7sdMauk7snQ?=
 =?us-ascii?Q?/me3Hs3YAkt5s3r3zqVPh7OSVheZYXeYgHAI2HJD9DbYjtr1Diw4PTB7iv1C?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IQYkSoONDz6B0pgBQvRfrH0WxIQuhmN6BHxSrIihwvizxpbs0C4ealUcUi3kxR3EC588zuVv0pUVnOQ/jgKUjriMFAhQS4Nz1qydylRUIy7sDPKFpf1A93L+M2LVxSSNzx8Wm2nvSsn2lrt0EYK4HJ/7RBC1Sfo0y7nxZp/P6KDQDjCeYsnpD6x61iPJHglR1ioF5XB+ND7/+tQnL2paru/IZqSjH1Z82ag3XLq+9bjVTaCI+Qx8FhFvA55L1ACbZ6k7fJ/TX8AF90ADfD9sLRhu/IEbde1FAlmjg8AydztaVsoEccrWiVC99XGwH9xvAr4R3FlXCOit23QntEIWqRtIWdHUuzH7HitfLjJM5kmNfAtSp532Y1NlV8F7g6pHuBtfkXtN36FeVqH7MIcyPhZQwrHxxyp9gzZM+SsF9YYpoKQHb+DwvbFFNyMMA9GyJHaxQc894aFH69QNTKjmnu9oU6obCRP7mGLeI0x4nR8ahtA7WTS6yliXNqJ5DVPszrxgCH/4CAuMClynrDAI/o8LC40fEFP7i44zdDtaV/fK/vSG6s4ZxUZgqzt1gN/hBq4oUoHMMRrJVR826b6sNNM6g20AC3NhYoOzWlnEQNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ee6cfc-9558-4542-673b-08de2c0992ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:01:16.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVnRFkvTSaQRiNHMAPhC07q4aLlJKfPkXTIlb7qCj2OpR+JZOqBDNkfag9rWJ396J/12dP1s0fYgO5wGkHNtWuu8zVdeHP2el0YQnLYOyCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250081
X-Proofpoint-GUID: TVbXt1VUuK93n3gWya_zE1BhLf-1gVCP
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=69257e72 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=6kSyhpO20BfhePVeaXYA:9 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4MSBTYWx0ZWRfX+G2SEXQfJa7t
 WWCyLvTVQDhKq2D0QU3OFqCUFmlEvF2W00M3bNn3XOe3lNTwrQcp5+A6Ak5pr56GSPc0g3e3YzJ
 oLAlN3EavxYTou/VxZ5kkAl4IkeOuU1CBcvMzzv27tpJeiwgfuMtZCIwngeo4iCPhoQhKX8IKDl
 rhvwNhGatbYQcXcy63DRnZMM7n7mjfv1zFHQNqfgX9v98+XHdDofrhWV88oWgnO8LZne9RzW3nP
 6uyX+2CEd+RhpKcjXrsXN25KgwWny/EBX2lcuUdmtGYNioZd59zdrKpxnjVzyPryEe13t16BOWP
 TpkC5el1t5gFsGnOW9N8Eq+Eu2HZol/ZPnQxtSxY9AIezfEPCC6tZGWcRK/OlqS7RIj7OTWbdxH
 R1L7uuo4UXJ+Qb1DBr0egqznIoY/X7rxX/ELciIQD2WJkQDc0CU=
X-Proofpoint-ORIG-GUID: TVbXt1VUuK93n3gWya_zE1BhLf-1gVCP

It is useful to transition to using a bitmap for VMA flags so we can avoid
running out of flags, especially for 32-bit kernels which are constrained
to 32 flags, necessitating some features to be limited to 64-bit kernels
only.

By doing so, we remove any constraint on the number of VMA flags moving
forwards no matter the platform and can decide in future to extend beyond
64 if required.

We start by declaring an opaque types, vma_flags_t (which resembles
mm_struct flags of type mm_flags_t), setting it to precisely the same size
as vm_flags_t, and place it in union with vm_flags in the VMA declaration.

We additionally update struct vm_area_desc equivalently placing the new
opaque type in union with vm_flags.

This change therefore does not impact the size of struct vm_area_struct or
struct vm_area_desc.

In order for the change to be iterative and to avoid impacting performance,
we designate VM_xxx declared bitmap flag values as those which must exist
in the first system word of the VMA flags bitmap.

We therefore declare vma_flags_clear_all(), vma_flags_overwrite_word(),
vma_flags_overwrite_word(), vma_flags_overwrite_word_once(),
vma_flags_set_word() and vma_flags_clear_word() in order to allow us to
update the existing vm_flags_*() functions to utilise these helpers.

This is a stepping stone towards converting users to the VMA flags bitmap
and behaves precisely as before.

By doing this, we can eliminate the existing private vma->__vm_flags field
in the vma->vm_flags union and replace it with the newly introduced opaque
type vma_flags, which we call flags so we refer to the new bitmap field as
vma->flags.

We update vma_flag_[test, set]_atomic() to account for the change also.

We adapt vm_flags_reset_once() to only clear those bits above the first
system word providing write-once semantics to the first system word (which
it is presumed the caller requires - and in all current use cases this is
so).

As we currently only specify that the VMA flags bitmap size is equal to
BITS_PER_LONG number of bits, this is a noop, but is defensive in
preparation for a future change that increases this.

We additionally update the VMA userland test declarations to implement the
same changes there.

Finally, we update the rust code to reference vma->vm_flags on update
rather than vma->__vm_flags which has been removed. This is safe for now,
albeit it is implicitly performing a const cast.

Once we introduce flag helpers we can improve this more.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h               |  24 +++--
 include/linux/mm_types.h         |  64 ++++++++++++-
 rust/kernel/mm/virt.rs           |   2 +-
 tools/testing/vma/vma_internal.h | 150 ++++++++++++++++++++++++-------
 4 files changed, 202 insertions(+), 38 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2f38fb68840..2887d3b34d3e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -911,7 +911,8 @@ static inline void vm_flags_init(struct vm_area_struct *vma,
 				 vm_flags_t flags)
 {
 	VM_WARN_ON_ONCE(!pgtable_supports_soft_dirty() && (flags & VM_SOFTDIRTY));
-	ACCESS_PRIVATE(vma, __vm_flags) = flags;
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word(&vma->flags, flags);
 }
 
 /*
@@ -931,14 +932,25 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 				       vm_flags_t flags)
 {
 	vma_assert_write_locked(vma);
-	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
+	/*
+	 * If VMA flags exist beyond the first system word, also clear these. It
+	 * is assumed the write once behaviour is required only for the first
+	 * system word.
+	 */
+	if (NUM_VMA_FLAG_BITS > BITS_PER_LONG) {
+		unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
+
+		bitmap_zero(&bitmap[1], NUM_VMA_FLAG_BITS - BITS_PER_LONG);
+	}
+
+	vma_flags_overwrite_word_once(&vma->flags, flags);
 }
 
 static inline void vm_flags_set(struct vm_area_struct *vma,
 				vm_flags_t flags)
 {
 	vma_start_write(vma);
-	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
+	vma_flags_set_word(&vma->flags, flags);
 }
 
 static inline void vm_flags_clear(struct vm_area_struct *vma,
@@ -946,7 +958,7 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 {
 	VM_WARN_ON_ONCE(!pgtable_supports_soft_dirty() && (flags & VM_SOFTDIRTY));
 	vma_start_write(vma);
-	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
+	vma_flags_clear_word(&vma->flags, flags);
 }
 
 /*
@@ -989,12 +1001,14 @@ static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
 static inline void vma_flag_set_atomic(struct vm_area_struct *vma,
 				       vma_flag_t bit)
 {
+	unsigned long *bitmap = ACCESS_PRIVATE(&vma->flags, __vma_flags);
+
 	/* mmap read lock/VMA read lock must be held. */
 	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
 		vma_assert_locked(vma);
 
 	if (__vma_flag_atomic_valid(vma, bit))
-		set_bit((__force int)bit, &ACCESS_PRIVATE(vma, __vm_flags));
+		set_bit((__force int)bit, bitmap);
 }
 
 /*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3550672e0f9e..b71625378ce3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -848,6 +848,15 @@ struct mmap_action {
 	bool hide_from_rmap_until_complete :1;
 };
 
+/*
+ * Opaque type representing current VMA (vm_area_struct) flag state. Must be
+ * accessed via vma_flags_xxx() helper functions.
+ */
+#define NUM_VMA_FLAG_BITS BITS_PER_LONG
+typedef struct {
+	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
+} __private vma_flags_t;
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -865,7 +874,10 @@ struct vm_area_desc {
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
 	struct file *vm_file;
-	vm_flags_t vm_flags;
+	union {
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	pgprot_t page_prot;
 
 	/* Write-only fields. */
@@ -910,10 +922,12 @@ struct vm_area_struct {
 	/*
 	 * Flags, see mm.h.
 	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
+	 * Preferably, use vma_flags_xxx() functions.
 	 */
 	union {
+		/* Temporary while VMA flags are being converted. */
 		const vm_flags_t vm_flags;
-		vm_flags_t __private __vm_flags;
+		vma_flags_t flags;
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
@@ -994,6 +1008,52 @@ struct vm_area_struct {
 #endif
 } __randomize_layout;
 
+/* Clears all bits in the VMA flags bitmap, non-atomically. */
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Copy value to the first system word of VMA flags, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+{
+	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+}
+
+/*
+ * Copy value to the first system word of VMA flags ONCE, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	WRITE_ONCE(*bitmap, value);
+}
+
+/* Update the first system word of VMA flags setting bits, non-atomically. */
+static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap |= value;
+}
+
+/* Update the first system word of VMA flags clearing bits, non-atomically. */
+static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap &= ~value;
+}
+
 #ifdef CONFIG_NUMA
 #define vma_policy(vma) ((vma)->vm_policy)
 #else
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
index a1bfa4e19293..da21d65ccd20 100644
--- a/rust/kernel/mm/virt.rs
+++ b/rust/kernel/mm/virt.rs
@@ -250,7 +250,7 @@ unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) {
         // SAFETY: This is not a data race: the vma is undergoing initial setup, so it's not yet
         // shared. Additionally, `VmaNew` is `!Sync`, so it cannot be used to write in parallel.
         // The caller promises that this does not set the flags to an invalid value.
-        unsafe { (*self.as_ptr()).__bindgen_anon_2.__vm_flags = flags };
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags };
     }
 
     /// Set the `VM_MIXEDMAP` flag on this vma.
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index b7e8fc9ccdf4..9f0a9f5ed0fe 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -524,6 +524,15 @@ typedef struct {
 	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
 } mm_flags_t;
 
+/*
+ * Opaque type representing current VMA (vm_area_struct) flag state. Must be
+ * accessed via vma_flags_xxx() helper functions.
+ */
+#define NUM_VMA_FLAG_BITS BITS_PER_LONG
+typedef struct {
+	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
+} __private vma_flags_t;
+
 struct mm_struct {
 	struct maple_tree mm_mt;
 	int map_count;			/* number of VMAs */
@@ -608,7 +617,10 @@ struct vm_area_desc {
 	/* Mutable fields. Populated with initial state. */
 	pgoff_t pgoff;
 	struct file *vm_file;
-	vm_flags_t vm_flags;
+	union {
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
 	pgprot_t page_prot;
 
 	/* Write-only fields. */
@@ -654,7 +666,7 @@ struct vm_area_struct {
 	 */
 	union {
 		const vm_flags_t vm_flags;
-		vm_flags_t __private __vm_flags;
+		vma_flags_t flags;
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
@@ -1368,26 +1380,6 @@ static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags,
 	return true;
 }
 
-static inline void vm_flags_init(struct vm_area_struct *vma,
-				 vm_flags_t flags)
-{
-	vma->__vm_flags = flags;
-}
-
-static inline void vm_flags_set(struct vm_area_struct *vma,
-				vm_flags_t flags)
-{
-	vma_start_write(vma);
-	vma->__vm_flags |= flags;
-}
-
-static inline void vm_flags_clear(struct vm_area_struct *vma,
-				  vm_flags_t flags)
-{
-	vma_start_write(vma);
-	vma->__vm_flags &= ~flags;
-}
-
 static inline int shmem_zero_setup(struct vm_area_struct *vma)
 {
 	return 0;
@@ -1544,13 +1536,118 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
-# define ACCESS_PRIVATE(p, member) ((p)->member)
+#define ACCESS_PRIVATE(p, member) ((p)->member)
+
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
+static __always_inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
+{
+	unsigned int len = bitmap_size(nbits);
+
+	if (small_const_nbits(nbits))
+		*dst = 0;
+	else
+		memset(dst, 0, len);
+}
 
 static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
 {
 	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
 }
 
+/* Clears all bits in the VMA flags bitmap, non-atomically. */
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+/*
+ * Copy value to the first system word of VMA flags, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+{
+	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+}
+
+/*
+ * Copy value to the first system word of VMA flags ONCE, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	WRITE_ONCE(*bitmap, value);
+}
+
+/* Update the first system word of VMA flags setting bits, non-atomically. */
+static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap |= value;
+}
+
+/* Update the first system word of VMA flags clearing bits, non-atomically. */
+static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap &= ~value;
+}
+
+
+/* Use when VMA is not part of the VMA tree and needs no locking */
+static inline void vm_flags_init(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word(&vma->flags, flags);
+}
+
+/*
+ * Use when VMA is part of the VMA tree and modifications need coordination
+ * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
+ * it should be locked explicitly beforehand.
+ */
+static inline void vm_flags_reset(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_assert_write_locked(vma);
+	vm_flags_init(vma, flags);
+}
+
+static inline void vm_flags_reset_once(struct vm_area_struct *vma,
+				       vm_flags_t flags)
+{
+	vma_assert_write_locked(vma);
+	/*
+	 * The user should only be interested in avoiding reordering of
+	 * assignment to the first word.
+	 */
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word_once(&vma->flags, flags);
+}
+
+static inline void vm_flags_set(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma_flags_set_word(&vma->flags, flags);
+}
+
+static inline void vm_flags_clear(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma_flags_clear_word(&vma->flags, flags);
+}
+
 /*
  * Denies creating a writable executable mapping or gaining executable permissions.
  *
@@ -1763,11 +1860,4 @@ static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
 	return 0;
 }
 
-static inline void vm_flags_reset(struct vm_area_struct *vma, vm_flags_t flags)
-{
-	vm_flags_t *dst = (vm_flags_t *)(&vma->vm_flags);
-
-	*dst = flags;
-}
-
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.2


