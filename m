Return-Path: <linux-fsdevel+bounces-61953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA970B809BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CDE620589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C50335956;
	Wed, 17 Sep 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ChFKXySA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mkSUYfRr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CF27FD6E;
	Wed, 17 Sep 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123314; cv=fail; b=AwI4EHNkFRuoEMcNWhscowOuZnxy4MLWdqPPcALY7+uY2+zwayfme/70HfLy/edUwTWXLr63sO+x7kvmGTW+RnRWUgrDQm74BKfC4YPlySIw6fHEz3AiyJ29fNa/DelU4zPaLQ5nwpsZAK69+ITqXqH+5Ka58hKpIoRVX62CeDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123314; c=relaxed/simple;
	bh=x9LlWtnucx+ZoRhvRWvhBqPTnNDkWGCYCXgH8ce7LNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccAp+tuFUj6mudtpDKf586eMxP3N8AD2j/eol53eapqwpyE4WKJjfDsv+Oi8T9nN9VhuByDAPClJXv+GYM5bQ3g5RsLkTgoBSriGw05bzdYQOX4inYAkbdq4xqZgHNcN4KV6NG9m7ZYNZjhBAIVauZafLS8a4zUCCG7ypUd4fXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ChFKXySA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mkSUYfRr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIV2M014280;
	Wed, 17 Sep 2025 15:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=trytYVWOefKvjlplHe
	Lq62OwYOvJMyefLEXhCIoFw9k=; b=ChFKXySArxPiCFBddQiU/n62UMw8hJpqcF
	LyK4KXYrEMmJoOX0Xx2M1IEGu3sms71TdOdlZ1MU8K5qa+W9iy3+tJ4kf6k7vya5
	N3UeAF7ngJiwkDjMB9iAUZIuYB9TepimB95PvlhMzRQPsTqGfMe8NT9RUc+48ByU
	xzwl0UQ3evr1rRN6eWOokMYDvGmOCs2xzOBxs3xXQScx3CXuOhKYaz+LYyIoP6jY
	EpFvHYDCYzJ/8wSvn4F2iZNCe+NcuJhGkEizyDdEG+9lDmdpX1VBwrO7W4fMfryd
	vTRJdHISkwPrpFoWCKYv++dBTo0tKlYqv7O1LdLBp8Uz5BynChnA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0k9m8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:34:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HFPllF033696;
	Wed, 17 Sep 2025 15:34:20 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dwjdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeOJDMzvyF7OaSPEq8E49YJnvXOeHJFgrkVd4QPKbooI3jCHElPwJR6qg8ucSkVqt8HgJ6itm9ck9VPD59WeR8Sa9FRpDwArCHAmQG2qVga6Rywg6t3ojipX60Wc59t5WMIoegyJdTMlbO80u960Ka5A2WstNd/fcQEx8886B6U0NBrlcX2Pij7NvKdxK/8yfrmvE4nMYNT/DRzz10lXST0mpI1aCyTRWRg9U6uo6IkJgrudPLbHezFkQQnEl40OyBy+i5gaZuc+7KbWL6X8Edr9GB55MnOKdUfs37nOkBhBKXo/LQBCF2uSAxz6NdQ7T1KyML0si61PBF1w0HZt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trytYVWOefKvjlplHeLq62OwYOvJMyefLEXhCIoFw9k=;
 b=av8rogR5Yr63/1j9+WWlZb9Wn9/iqim8a9ZjU0zA7uRcUcIb0DYq19QI+FWWBMp04mxV+PYdVhrhDPfEl7+mCkKVZcQfM/pRhOTOa/1V5AAUeYY7kSj3SClPj45aA6gjg64aI705n7gQS4mx9yg/l+fw1ZoqSBv+qmldi383pXpbtkaNuMZ3oWBjkm6Dn/np18WlytrZK+Ex4RgqIYc5vj2UHYNne5ZVwOvZYKrLt6XTE8hoVV5aa23EWsjsEuIcEY+fMolyAPuSv9X173hIZ72I+o94V5/yFvXCgyMwzyWbDG2L6kZd55wAKngU3m31v183vyCuhKNbky/foVqNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trytYVWOefKvjlplHeLq62OwYOvJMyefLEXhCIoFw9k=;
 b=mkSUYfRrQ/Y2aASF9n2MNWfXDAvfbpG3+RG5/nRA4nhC1h8Cx+QqiJ30/LXP+RgxoBEw7larJHXgb8G+MaHI0LHgDleHlxy/S1xC1mGdL7pn077dktzZIbDhY8ul8BAiMwkIxcVqe+glu02BCsHPFDLykRO5/8OKV2/k1wEi4Dg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 15:34:15 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 15:34:15 +0000
Date: Wed, 17 Sep 2025 16:34:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        kexec@lists.infradead.org, kasan-dev@googlegroups.com,
        Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 08/13] mm: add ability to take further action in
 vm_area_desc
Message-ID: <9f88366f-84ac-4210-bbf0-b27cec284572@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
 <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
 <wabzfghapygwy3fzexbplmasrdzttt3nsgpmoj4kr6g7ldstkg@tthpx7de6tqk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wabzfghapygwy3fzexbplmasrdzttt3nsgpmoj4kr6g7ldstkg@tthpx7de6tqk>
X-ClientProxiedBy: LO4P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::12) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS0PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f85b1c-470a-460b-1824-08ddf5ffa8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dddZ/HBehOok70ReLDrZOea5PCmxrqe6V82h+pvv+Lz9JXja/aahxnKyaKoC?=
 =?us-ascii?Q?MltzU9Mczy7YpNEsWiR05QzpIxbEUfHSua+LWEl9U2E66WX/vBl2cHS+wQ6M?=
 =?us-ascii?Q?h60clIh74VBeH82E8MkEZBWj2N9Vh/30tvzgBstiUX3qJ/6/9URFEkkqC7OP?=
 =?us-ascii?Q?IOtQF45flf9/h9imiuOnWvXi9dII6hosGlaNVOEXDBMemYLWX2irXWLsgwsg?=
 =?us-ascii?Q?QCn/HI0gAj4b1twlJfIrbnl1mgOr2v11X7rfNzz4Yag5zRQRLLHxj20sXSS3?=
 =?us-ascii?Q?8n394Z6VF4PB4P/V7osfhPxIx8+Ztshr4whb/ZCLpy3L5xZr6dYiW3z2qGvh?=
 =?us-ascii?Q?tntcasj+LnEMIwUKV72ayrqqKR586s7iUcyHDk/fqw0uhwzCjjYvSBF1LQUs?=
 =?us-ascii?Q?748uaGTRck7d6gPi+AOlyJj19j/ZpaCUTolaMTcvMBZVuunt8HwWDZEwXfXg?=
 =?us-ascii?Q?1GYTociy832qy2P407lRcN/vhAnN+ncmRFC0Qeo1mMvHPKw2RjqapRsNuqy5?=
 =?us-ascii?Q?eoML2K93EAgkbWwqMhpC27JvNJf7nSBAxIYQVa6wRfBaaDjvOePy+/ScZ7rP?=
 =?us-ascii?Q?cKMxon0z54H3jjYUCdtFL0dZ6FZa1SMYDdQop4TOLEDWke3QFBGQQtiLhiUg?=
 =?us-ascii?Q?hpkSD3Z8uWepEIVj/yDdzsqKQJ92lHzAYykAb6lLP3ulAEoG9Sm598fs8UcR?=
 =?us-ascii?Q?u1cfQlRL6ihvvFolUgAiDYOFdFdKihOQNWLBO4t/G+HqwOLB3HUTALoGBdrC?=
 =?us-ascii?Q?meyCE/WZ+3fvLYwLyp/79/xmmfHmLLBPoPWnW7hdTaCLPM/ppJ+bsL7EHWyz?=
 =?us-ascii?Q?a30W+6gmWiABSNFp0gdXWdqjPGkCkSn6H5yoB5Uru9O4M/Hv28ZLYiqmR8ey?=
 =?us-ascii?Q?34lctPtMj/SjzVLU62nMeGbn/2PmmX/WJFN8ZiFI7EWHtEla8oYe0ueU/gHV?=
 =?us-ascii?Q?qH+FeaxdGvoi2Am0taw24X5Fs4u3ukZQ5vSEOG8KGg9+gH9vn2H5EOBGQBD9?=
 =?us-ascii?Q?RrpijUyLfFavdpfr9axpTchLCeS8KsjgE1D34vuo8euEoWC5dlUYyCp7HWE/?=
 =?us-ascii?Q?UQBkLhwmStmMQYHWoFdGCjMVIuZg5bmPGpDxdFAVD7Z5E429CxMRyi/kBKzS?=
 =?us-ascii?Q?mQ4h7qCSjF3SWHX5quPajG3Q4L4oxKW2PNeC8aAEM1zBhKngcbLfuWGnf35v?=
 =?us-ascii?Q?VOJUtwSL0G+y2gboN/R2uQaWpHSgab+wq9092VUN/+lfEakTquNB9ULqpyTY?=
 =?us-ascii?Q?2qhqjIMFgRIrfDxXdN/mSjorpWqrxisdKRpk7COs+nFpetiTgu+ks9/AfDgd?=
 =?us-ascii?Q?Dt9LnNGF+3pSc7JMg4Qjyux68IpQJ5/ZoBCLeOF9HmRnGV8Olp1da9Plpwtx?=
 =?us-ascii?Q?LwCtTsJmpiMNv2S3lkOXB0oy4cIt5oNcztqJcw6ZOgLVU74BOov3FnIw81JG?=
 =?us-ascii?Q?67Z0uJR9+tA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tLrbb8TxoLzN2K1WJnxNQ9K0Hl8Is5FRhphl7KwZ80fOE0N+SU9dQjBr7pO7?=
 =?us-ascii?Q?K5Hck1kt+u1HN+QTjQG2yGOHFJACy6uFUpwIOb5jdJlnbt85jTxrjbGCs5bM?=
 =?us-ascii?Q?AvktotjdPTTCe319p0J1ko1gGqSY/+fNgeMWJwGjORJ7RTxGs5FVNbXv1I0n?=
 =?us-ascii?Q?Gbloe6oXQcnfYKb6F8heDu/rVsZXyMe5DRjHouFjb3DEPFGeKuMp6i+CgEtI?=
 =?us-ascii?Q?DOo8PgE8mRb8xcB4hv5e8x3AHDzjdHeQEB2WQU14Gl5pUOIq6p7V1CXOvr02?=
 =?us-ascii?Q?CQWsJvQSO0COudsb1typ+5feiagPDXQvohXfdMLBoroRGQYAcixyuuybhyHU?=
 =?us-ascii?Q?8I9P6ckn4v/3fJTqft+J6KJtOSivCsg+W1/wMyzITFeOqClOSxamAon0yi6J?=
 =?us-ascii?Q?dje3l1ARSN+gSNzC/WqT/HGKx+U+KZ7c/FxLHWlRspnGmkyPIsfNQiRI63j2?=
 =?us-ascii?Q?zcRXPbCjjDVJoWA1wGTXpdCe0sQpFH9LkGvJGCfyyguD/9Lz3Hc//OkA7IqW?=
 =?us-ascii?Q?ypzjZWirXQ3grROPtsCH8t5LFRihjHVTaKGKkAUpRYqRJLqsmIK4a8DQ1aF+?=
 =?us-ascii?Q?eawW2vS+97hoDGOfKE/KKZ/nWzlCFT5Lh4Lu/VfwkgbwWK7JvjSacKywS1Yy?=
 =?us-ascii?Q?C6XdRco6q9Wvpwn/L2aG2Xv/vkaCnz0Eso442QIfm//gwqNE9LpGlm0vYsX2?=
 =?us-ascii?Q?QSg6cx5gOom8rp3k6MeT+wrDtSmpVLUwvPTuvqcrnhB0McgkdSBORGq7biJH?=
 =?us-ascii?Q?xIhjpBKKJHDdSMDSW5Btjl/pr4S8Rjod0T24N+GIxS6woXVUU8j16k3A1uhX?=
 =?us-ascii?Q?1StDWtanS68h/4aExx/1Tx+couzVKDc3NvxZPrlm6bZ0W0zbF92EJATxE7TD?=
 =?us-ascii?Q?P8SAOi8djllJOIhLjy1h9nIUz5lO55LeFfDLPkOABY5hgfvjmMO71qJrXShf?=
 =?us-ascii?Q?b73F6ZSzSTpRnKOAtQLjs+QcATnIOvgOKSCExaSJ1Nx/pp68veXlcS/guIgT?=
 =?us-ascii?Q?5x6yLrEY8jZ1rUoPsL9fBYJWiAWPKXscxKitEiZHW/jfTWvOQt8YJHS3i5r5?=
 =?us-ascii?Q?p92m/GkA0G7P4VKuvenoTAi7gpIrzswN6Lej0SbvjlAZvRzvqPShVYnYtfYb?=
 =?us-ascii?Q?KA6ydIBe368qH6Rhq+0w783EduB0tsQRtdSieNX6F1LdbqT/vW2H3Ng/e7ig?=
 =?us-ascii?Q?QqEoW/b0fgETLkQgDXCIZGuHOL3qDfsq/0aObiaIQ7wZRCXMmNPYHAZXj/3P?=
 =?us-ascii?Q?v1bPk/Jtpl27tWXy6mord803hqbHsmwwnkSL+EGir2Rof02v2F5+ycdIu0EQ?=
 =?us-ascii?Q?FLLFXPIgMpYbNNWcXFkvM3cE58K+iWnyEnCktMVufFT6dt840C64bQ43sXp/?=
 =?us-ascii?Q?lwqZSwfVj3umXYkjQuAmyY5CHWx8vKvc9kcvyQR+FIQyIjhhP6B+zkYBFn6T?=
 =?us-ascii?Q?OcngPMZoCm1QZzwcog/GnjUAQ4tRU0M7ZClnvFcprh8HT9sIFdraoUY7O4bV?=
 =?us-ascii?Q?4EjNCHoH4hwt+edreMBduE+tBClldq89OExb2yRZilDIS5LrqYMo2RPuonwM?=
 =?us-ascii?Q?ZWEt8jNI/Njx61BfkePkjvgwW4rDkaiDC6IXK9w2DnqZrqb9ED1wuKYjBY3u?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kbJRL4+VXzkNbbKKBnC5nN4vrFVd06MUYAmU6nXBMNVLoeF//L9+TkUcvn7fQ4zJVcSm84zzujSiGd8foV3NnQNyOKWAj8Tg9GD/gDbMZqRPJLesdAA34sYsBYcxcgXMQIwZltdBlrGza6FZgschKQDzKvsNk7KsCSyVRMTgEC/1fCCvDkZl5W5QlAqNjUB6X2kW938ZjSiRS1YfzOGO/CHdykS/bMjT2v0lYqnJTSKJ6jIRVx7fu7QktnNW/ZHyFjgDnMDjw9qp8W3I/DCOBj9qUQu5OL0neqca0NZqrRcnJsanQPGQK+pl1H2LmfKggR7rknJf+jNwDwktlGuZOZqvsWteebCddKhbdEE7W6R68Xp5uQSeliB7nNlA+/2OLYnENTJYtfn1y2bITphblX++9xPL8eHI9CkivswoQJw29cP3lnTDpL+clvy9F/kpa59Fau3vQRKGgjyRBJkfi+LUr2LKfK4jcizUy1iSAggYjSsR2rLeao2BtMga/ZJSjX1fcXdZ39c3mjdnIt558TtTv4/pmaqrjVTCh7oXyOcUa5FVMcbI9K3/smm1aOZQNYrOqZUgS4GUeSgyRrpSj2cWv1XTudXsLMVILq/d1Bw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f85b1c-470a-460b-1824-08ddf5ffa8d8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:34:15.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCOuj5RixjDe0yUHcwndp1oO8XfKPeyea0V90NOoBrEaQs/m4+Y+lPFl33mAlkw45eVou6+5ECqSig+vtTv6wNpJGdufDEsyp7MBTgSnYu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170152
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cad4fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Pew4m6A38V_gfoML_JYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: hr92KHgBUHrjPKHSwt4Gd4o5gHDXB9oY
X-Proofpoint-ORIG-GUID: hr92KHgBUHrjPKHSwt4Gd4o5gHDXB9oY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfXz6bF0H910NwB
 Aa9H8a6QUhV8ulxPpf9kxPk0sF81f3T+SOXDWj3SBC92jRdwIt6neBJc/KS4+kCbbICY1LDRak+
 CVSb4F6q6X8dUM+QZVjKsseSTJj7jK2nJo+90KmqYP0Zs19jRuQA04CSeGDLuzM53MZ0YOMWnw+
 pUeFwolFdfhXdDB4J68uJkDCcsMwvBNxyodJzjVg7ZFVTytdBJzm9WuF13UfiRedlMMLz6rMD48
 v4UCJq1WbRWWgQ+QJv8mOHtP94dGLh/n1pB25ppp/Hl4dj4LVvPdwEvHTtvae7E+QPHydt1A2U2
 CrcR+XqUK5EQe8TxeXNHizO30waViDmGATYpO8oT9ks2VdcoOKzljBqGGjsslai8Sao/fpUAAFf
 SaRFdNjJ

On Wed, Sep 17, 2025 at 12:32:10PM +0100, Pedro Falcato wrote:
> On Tue, Sep 16, 2025 at 03:11:54PM +0100, Lorenzo Stoakes wrote:
> > Some drivers/filesystems need to perform additional tasks after the VMA is
> > set up.  This is typically in the form of pre-population.
> >
> > The forms of pre-population most likely to be performed are a PFN remap
> > or the insertion of normal folios and PFNs into a mixed map.
> >
> > We start by implementing the PFN remap functionality, ensuring that we
> > perform the appropriate actions at the appropriate time - that is setting
> > flags at the point of .mmap_prepare, and performing the actual remap at the
> > point at which the VMA is fully established.
> >
> > This prevents the driver from doing anything too crazy with a VMA at any
> > stage, and we retain complete control over how the mm functionality is
> > applied.
> >
> > Unfortunately callers still do often require some kind of custom action,
> > so we add an optional success/error _hook to allow the caller to do
> > something after the action has succeeded or failed.
>
> Do we have any idea for rules regarding ->mmap_prepare() and ->*_hook()?
> It feels spooky to e.g grab locks in mmap_prepare, and hold them across core
> mmap(). And I guess it might be needed?

I already did a bunch of logic around this, but several respins later and we
don't curently support it as Jason pointed out probably we actually don't need
to, at least so far.

I don't think it's really worth saying 'do this don't do that'. As wayward
drivers will do whatever.

Sadly we do need those hooks because of error filtering and e.g. debug output on
success.

However on success though, I discourage anything too stupid by making the vma
parameter const so you'd have to do a const cast there.

On error you only get the error code so good luck with that.

Obviously there could be a static mutex, but I think that's unavoidable.

>
> >
> > This is done at the point when the VMA has already been established, so
> > the harm that can be done is limited.
> >
> > The error hook can be used to filter errors if necessary.
> >
> > If any error arises on these final actions, we simply unmap the VMA
> > altogether.
> >
> > Also update the stacked filesystem compatibility layer to utilise the
> > action behaviour, and update the VMA tests accordingly.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> <snip>
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 31b27086586d..aa1e2003f366 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -775,6 +775,49 @@ struct pfnmap_track_ctx {
> >  };
> >  #endif
> >
> > +/* What action should be taken after an .mmap_prepare call is complete? */
> > +enum mmap_action_type {
> > +	MMAP_NOTHING,		/* Mapping is complete, no further action. */
> > +	MMAP_REMAP_PFN,		/* Remap PFN range. */
> > +};
> > +
> > +/*
> > + * Describes an action an mmap_prepare hook can instruct to be taken to complete
> > + * the mapping of a VMA. Specified in vm_area_desc.
> > + */
> > +struct mmap_action {
> > +	union {
> > +		/* Remap range. */
> > +		struct {
> > +			unsigned long start;
> > +			unsigned long start_pfn;
> > +			unsigned long size;
> > +			pgprot_t pgprot;
> > +			bool is_io_remap;
> > +		} remap;
> > +	};
> > +	enum mmap_action_type type;
> > +
> > +	/*
> > +	 * If specified, this hook is invoked after the selected action has been
> > +	 * successfully completed. Note that the VMA write lock still held.
> > +	 *
> > +	 * The absolute minimum ought to be done here.
> > +	 *
> > +	 * Returns 0 on success, or an error code.
> > +	 */
> > +	int (*success_hook)(const struct vm_area_struct *vma);
> > +
> > +	/*
> > +	 * If specified, this hook is invoked when an error occurred when
> > +	 * attempting the selection action.
> > +	 *
> > +	 * The hook can return an error code in order to filter the error, but
> > +	 * it is not valid to clear the error here.
> > +	 */
> > +	int (*error_hook)(int err);
>
> Do we need two hooks? It might be more ergonomic to simply have a:
>
> 	int (*finish)(int err);
>
>
> 	int random_driver_finish(int err)
> 	{
> 		if (err)
> 			pr_err("ahhhhhhhhh\n");
> 		mutex_unlock(&big_lock);
> 		return err;
> 	}

No I think that's less clear. Better to spell it out.

>
> It's also unclear to me if/why we need the capability to switch error codes,
> but I might've missed some discussion on this.

There's drivers that do it. That's why.

>
>
> --
> Pedro

