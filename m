Return-Path: <linux-fsdevel+bounces-60557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825FCB49359
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B46440C20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD20730E0C8;
	Mon,  8 Sep 2025 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jZURQn60";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XuJsxuR4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A981C3BFC;
	Mon,  8 Sep 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345342; cv=fail; b=E7g0fpZUBsYJ71PZ219M8+Rghxe9HlZa1sfUsStlD/leikypoPJsLSSTGXDxUyQADnVd8ObEp0Fl6/UCsTZKu/x8aSJW4Hkw+Xk1gpjAQnWX/ITVtCMLIJaMmRCMdFbZA8TvEN2IPRmZNDIcyx3nzLMyxepb1J9ceOoFMkgopNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345342; c=relaxed/simple;
	bh=tk+oOrjt8IXf6Zy4SCOVkDSXg+oacDEAfcKssA+rI90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=As27qn34AGajEZhZ4l6gQgImsdQay0n+ps13WLwZgz3+JTWZ5TzigzCROc5RAs+fu0q6kgRcMw8Ezd9PR2oQr8tBSKHMf+8EwTPD5CfrUvWOMU97KLVwbc6I+pQiHZoC2pC8WzZJTLgCjFpkgUU2MpoyJlYWR/9VciOk4Fy5a8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jZURQn60; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XuJsxuR4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588E27Pl018134;
	Mon, 8 Sep 2025 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tk+oOrjt8IXf6Zy4SC
	OVkDSXg+oacDEAfcKssA+rI90=; b=jZURQn60OeApNtu9WlB0fd0coiGn6VV2Kl
	nGl/rRqKXVqroZMxYcmVQ60je14ueM5ws+P95VKVjmGiL+VUeEeASf2ndcj0MND5
	+c46yQSJ3cJBmVomIWZNq+Po6ET3H98FoX7on9cJ1UiR6FYRsnkNdZGmSNBTKbLN
	260AljfP/ycAKxE4po3v8agy0cGrHIwZpCS13GmYDfLNNMJzAZn5v0ZEIoKl45ag
	RPt4OOF4CQpqNHvACaThtI9UK+/gPU2uVClRUvNAijdD4x8xKdVefCaizG/cBk9d
	3T1vrZf3PeGnvd/a6E8o4kU5yFzPAf6qKLtvTH8AtfsIbqiDdYog==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491yx6ra7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 15:28:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588F6VLM038858;
	Mon, 8 Sep 2025 15:28:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8c6ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 15:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT7C1FAeXCQhLgtoTltQDl9AblOQP3NN7za2xqHZspXOVnkxXHLbQn7Lnf65LTajKtYukfDDsmMcXcjiPu4f38GBwqlQSYgjJp9/DPPBsIg/ghK2Lc9EinWQf/yRndNlUUnCsLCb1N8caFj+GBgPWAPzBJhr9mvDZD7w/KrazC6EX99kjtCIs32bY5whEv7psZeoGOJFsad4KRopVtVxOXQlxlswL6RzCghpoZVXTn78A5SSJr8+b3V5IKC13jZ0a0/f8DIp0aXrKx1Mc6tUV+ohigXA3LWVrU7m71x+59UVDwCWwoBz5yIIxAJFEKL1yaPd0RNXZp1tlbb35dxhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tk+oOrjt8IXf6Zy4SCOVkDSXg+oacDEAfcKssA+rI90=;
 b=D6B/LPmrgGWl+5QE+Vp2uNeOlMUAR7FLCVhtGgEq0ODi8ssiSRiPpdKekvufcCK/wBD3B8/aYRuiNdxzAHYdsr3XJenCcDemX8R7z6c5FKYUyReaMGC9q9kiJnpsbB6EmnM1p6oRMG6KmUck7yqYot5RpkCFT15XKX09uXPrF0aW4NNOZ3h7UXP92pp5VsFq9418oBNzfK4jckjtXA2HtIx6MfFiCNQLe3dkvVtKqLgqXPHt4WN22wTzea2DiEuh6ZkLT3tLhmwDm9MTqOj9Cfq1t1BKvwFzW5Q88MMiAOs6egfgC14Y1QkREUotup1tQVyVHMplyuDwSHDIQCwsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tk+oOrjt8IXf6Zy4SCOVkDSXg+oacDEAfcKssA+rI90=;
 b=XuJsxuR4tupABX1kYD+Qcg9CPxFc++jMeOvP0np+gSwv002qA93fxk/TOGFBuNTxmItL7bCGaE1OO4slacyjFonl2fdZ4h51aWelwybJcQSFoekC5IXm/sq4X4o4oQfgrSMiM4KyZxsD9LsB/1NNgHa+OqzGvTTLQDZ2klq2F7E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7102.namprd10.prod.outlook.com (2603:10b6:806:348::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:28:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 15:28:11 +0000
Date: Mon, 8 Sep 2025 16:28:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
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
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 01/16] mm/shmem: update shmem to use mmap_prepare
Message-ID: <171b197f-0f40-4faa-9e40-1b68a79e05c9@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <2f84230f9087db1c62860c1a03a90416b8d7742e.1757329751.git.lorenzo.stoakes@oracle.com>
 <cc59a58c-266c-4424-9df1-d1cec8d740c5@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc59a58c-266c-4424-9df1-d1cec8d740c5@redhat.com>
X-ClientProxiedBy: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: df85cd61-f802-406b-a3ef-08ddeeec51fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZtZ32P3jlsK1Ar/BPGhCzsdMYajauKJU3p19d567nvh2qKqes5kNOSj61n5O?=
 =?us-ascii?Q?q3WGG2g+mvnpr17yBJlV9AKrRgofJqMahSM3ZXWbfSP3HHkCkoxVx5DcWfGo?=
 =?us-ascii?Q?NsGuohn8LV8KtUIkP69w0E3/BFhE2es82LxZj8NT5fbMQdQT92vnvHDhp+pF?=
 =?us-ascii?Q?XV02pY3v2lrttI7W+z0jczpvN1sx6cOvHF+AvU6lLbtIe7Nin2xXFTyjC2JF?=
 =?us-ascii?Q?3zrrzgRzFGvQGSUPteNgdne8onXbx87EU/9Y7q8kgGxTjFaQxNfcmLwjLl7H?=
 =?us-ascii?Q?76pZIEfZEwBWIC7czdILg+rEEQQS6C528SkdlYJhsM5FuTnmw8s1DprohKMI?=
 =?us-ascii?Q?ZoZPLSCbxDsVLlrl3bZy0aZqgqwPJcpcRxoQGnltTU4BUNEC2qnK1cA9RyHw?=
 =?us-ascii?Q?eGaj31mkgHafAVeWDSu3bvl1l1lfq745dr27K+c+7yOma56DhnWc0F5nuiXZ?=
 =?us-ascii?Q?ALhixOyrBzJrVt8nxzGnHywBEYrykE4r6psziItuYOF1NgmxeIZBwc+FSOal?=
 =?us-ascii?Q?gq2FSsC/6VkKOdhXJDWuXUegnZS5+PgqYPBRbjiYB91k+5rT7IH1w7S5TA0B?=
 =?us-ascii?Q?fRRNM6k2fk3JqAcGtuCO0fV5eKIUPfA2fcIqMY6/M1lDcz/LZND7JsLBMe3P?=
 =?us-ascii?Q?6JNZdes5kArC3zPyQe5vwlNz4mC+Z/K1z490rUVRX6FwWXNa2hk4bM5QHkDK?=
 =?us-ascii?Q?6s2RGmPbPrrGjdvftfvuvy5iZcLBJBxZs5XnCxSVaUyfoDc3eVRwaJxP1Mr7?=
 =?us-ascii?Q?jCwf9ULqkcXYmU8kJeLPg6C6UvRQWjk57kd+Fa1JZkl6uV767DjGIARi1BJ4?=
 =?us-ascii?Q?VrZG5+CVbYfLbCMaStOUVDHJrqaOrXRsipBkB5aciklzIthW+c2B6DCSRqUw?=
 =?us-ascii?Q?xF1VErEq3MW86yc0O02ZR5HJI3S/NiDkj3+L/8/ukkk5R+I6cTwoKL+2PeR9?=
 =?us-ascii?Q?rWB4NmwI72iKMD6rTnRQC9KLieJpc0QkUez0GdTh70uaPw7QRCBcDnTSvADM?=
 =?us-ascii?Q?n6FFqAY4BKwSawK5+d+3WPfH5HMwCkHEgNm3Wv/UrzIUAo7UhUNxto/XPJ0Q?=
 =?us-ascii?Q?rCKK2i1xkkMvGdVfxl9oYRK71X/5ejJvzkjgikfmalA0ZoGJ8Y5pTXqhaUFO?=
 =?us-ascii?Q?CcIXQGHazpMZLmAbBbOmuTOMqMAVs63jnD3fGBNfcf8ntGvkQXhOR5OH+59j?=
 =?us-ascii?Q?zzfun2w1Jyeec7jYry9VPIcvQ1gN+fUEbdM0W0uTr/3+FlmUHzvRt77xRgsY?=
 =?us-ascii?Q?TBaJMy8vZJ+IF5HPw7Ii9vOi8A2/5dPz5cr1ECcvetAWsXaLMs3FbR51jiku?=
 =?us-ascii?Q?l2lBxtK4UuvJ5YD1JNaKfNT6F13Ad/OCRtaQTs+y2mBkIn3m9IeFAsWUiF/3?=
 =?us-ascii?Q?qaJEK6aRq2TafaAovyQenW5F7sIhkDC7nshnNXWtmXZmsvsOjX+ktLn5xbL9?=
 =?us-ascii?Q?U/h9Fvqyxls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wynVh8sX9cRf0ZyAKQXV6igD6REDe6LjlNbjUvfG88+i3vcDT4M1WBA3n+J6?=
 =?us-ascii?Q?4iB4SqNSiR8Pjil4v/fI1iS9l8ZvtK7hhlFNiz15trjuXdw4hqHMFF9gVlhX?=
 =?us-ascii?Q?dDuHb2+bG9K9HVCp/GPXQG3sUHIPFMBqoGy44HtoErIgQDY7LLbvlJCLdzTB?=
 =?us-ascii?Q?SMUTw8krNDTvgcEiUQsVJ7dYb5uK9DRwbsT65KvFCCYuvRsbg6XgQ7FzO+n8?=
 =?us-ascii?Q?6xolVXv4qnhGqJGB0sOght3miMNZWFb3e/zhLsb+bzllzAATGTKwnsAYlBKU?=
 =?us-ascii?Q?leBQ/NEVyxTTjVOlq1qaWsKi3QeVF4SQ/a2bM8atrzL4ohJNs8bGN8yGbFFz?=
 =?us-ascii?Q?rRt8Vn7U1bwDlM+dYTBGDYIeSgZ9uuiTbQCxtJ9jBIOhY8m5ammi73SLW4/n?=
 =?us-ascii?Q?Jdv109GPbV89UX35oz/s8LokC6sk39ukO4599nW3ffVTXpdVJZMw6d2m93wV?=
 =?us-ascii?Q?whZvFNdISRtJ+kXfaCFTHacjz1Uk94S/FjqWuxKMu81fAAZ+JPtcm3MPkwNI?=
 =?us-ascii?Q?b+TzI4PCdEqa7gMf5lee725mHUSrDYszNMXMsq8AtRKYiMVC/zE2utZkXPU8?=
 =?us-ascii?Q?MMVaUleyImvAhRFG55yVRRMIIeCl3NpffTPZl+41CfTsbLC10colRpVmfi4I?=
 =?us-ascii?Q?KrrQA5h8i9wXcv9diMwJPNVmHYqHeaDaGDvQn/vz8mH3xeHdQtjnt25k5Sq2?=
 =?us-ascii?Q?AHY8ZOPmzTnd5JFw8yTfQaGLL4/wkrkxg+sqbqDE8G1E7AHhD4jluEeJOWRQ?=
 =?us-ascii?Q?KVWNXkXA7yZeobNr7WJfMLrIaHPvIzlB9DhGNT7oSnCgTMs6+rq8rPCWqcN5?=
 =?us-ascii?Q?SEu4OFW8E06fH8VVEz1Y+JmoCbdpDPhchpwcip+tpDmaX5xu+bovFOKUZuWO?=
 =?us-ascii?Q?RvrPlh5MfKSK8iWopnhVJjMXc94vu8EI+T0zcsnmTpJq1IMdZKbFnHeKtvvD?=
 =?us-ascii?Q?VBtqcK+iT61ZiXBz4nbGl+MVCo0H3r28J1T5M7dd6/Elvhudfah36EATPxQd?=
 =?us-ascii?Q?QuqSqhFIBrOP8ieX/nGRnvWGOmjUEeKA+4hc3hZXsdiRd1jgtRprktBAxypg?=
 =?us-ascii?Q?V3DLe1jg5u7xOpawDsx9f7tjMLypc65ILekdyM2IiiWuGj2/pHwsRMrgJRUX?=
 =?us-ascii?Q?jbgnXq+lZc6oSvGML75GdxHIrKQPzXoLuqSWf8eqM2IfGIlKIPobE1M03fHK?=
 =?us-ascii?Q?ZDPYhEunaeBK7zaPiW84gyJBOACG9Gu9lHYjYW0xoqGB6UoYglW0i+l4SR5z?=
 =?us-ascii?Q?7Azyyy9tXzpcXbZ5TGe5i149PPB1enE3oU7wGI3o0eCkwNYJE/eB56pK+G24?=
 =?us-ascii?Q?1yS3wj7NiS7S0CjSzspXoc3Pukv4PqNQBmz7dNCfCFZ99McLdfwarrioxZvK?=
 =?us-ascii?Q?cvHsJH0ED5UCFdDlYgNqAidK1IW2LKpE2GyoUj1aq2mOCIW6WeJWh0npwkwu?=
 =?us-ascii?Q?1FNFe8PHGQN1wcwDHrpol28LGxfXsM/qWJpX93tXLRnCdoNqVKeYVZsgE8B9?=
 =?us-ascii?Q?1OM4q/aSpG0+lulNXGlqrJQQ4kOTDmJiIpRKrSUK5i3QTZ6yhnUdUaDmPMNv?=
 =?us-ascii?Q?Cho2NJiy47jnHbq3z8PYSYTGU0N03RABilJ7383LfhZpIpfLdLvWFwdcRgmD?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kco7Q5SWyHb8THwZcxUXFmw6p3f4VT2PLORsrle5gHizzbj39oNk/3wrm8gLnmiznRptgeYnozRT0yn9zFxW8p5smxEr7qJhMm3RRvoc0QZTH5FUNd/Aojdf6ode3kJAgyYZndUTZQZg2l8uq41oTPNqfy8a577PdM6bswCnNzvJ0PtGnnR5+Z/CYLhf/j6GUQZo1vDPMJeSbaMVz25rD3YIcmKz01F96kD1P/qRSOOgbNAd/Q23kgrm/2u9BG/Mkj6CbSsnNnSzh23Us5uVuBzyy5hm/Cw3Z86KHi3kxIInii7UDhGC3XqHlLgJ8fUceLnMVfdBl7QBd7soj9QgGLHbktCaEb7jx2bNJ/OXwn1QFjDg04k2h8VeFdScbmk9AmwOoxIv5mM0nkjE62cFVS6Waf4YRFlK1/LOMvTNEqB/9AXNCX+GFTPeLYfbUOx5z8g/YYRLDdU1UdqF8nG3rbq6x2lA4gUiAamFWAckQEv4/emZJDcxyNn93WO5t83Xf/hqZyXodLYBEkbgYq86pn0TuyRlKoRAYAGeY0PkOHyuKgFxX965cUMv4CYKUWRADUDJdMugGOdWSwYOgIWCmHE2zfdNQ3akdfwyYlUGuVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df85cd61-f802-406b-a3ef-08ddeeec51fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:28:11.2588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX4DXe1MUZpcISpm5wITTqBDYyQMMsTzdg3vS3wx/f1CTTS+pLNBE1uY4ksH6PLsuyxFYSNvU+1viERxWn8pC6/TQRfDWvoITGYA2YSr9DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=962 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080153
X-Authority-Analysis: v=2.4 cv=SaP3duRu c=1 sm=1 tr=0 ts=68bef610 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=UQyiNi7Jvx-vLDuNDE4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: 4v9mq8MoXs05fTzfPDpidNpQBLYVYucL
X-Proofpoint-GUID: 4v9mq8MoXs05fTzfPDpidNpQBLYVYucL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEzMyBTYWx0ZWRfX+LH0NQA8zQ9L
 yjp2RPdxzChJmhtebJyTglBeCsqpwDPiaerOuLMD9hal1SQ2Cq7ee7m+Zsqw7ve4UeImD0bpk8D
 H0+zmggvvCT+B/7JVQqbpyag05KVvG18wCYqq11fx1iLloiIpy7u0l2OfBFXjGOF6TrQTmHAJ98
 Y6SsmYuWprUWqr3rMeGQmilRDbPMwOU4q2WRCXDD54rA2BKCNoLlGmhwIaWftpeIvjiOC5n79YD
 /dfzFPsmbtoC1Wr3Blyz/ne8jZ5OO9j33ifWgLTipy1iB+MODxY9ahiB3+GoHJQkqu3p961GpBk
 9amoFQWrP1DWNmmh6vnwz0GZA7KAnQRayxF6/dyX7q+jINYTQwwcmIKNTrCS6i130ZHP3Zmu/il
 Eu4JqrFQA7oWXZZltAX1hs21Sjokmg==

On Mon, Sep 08, 2025 at 04:59:46PM +0200, David Hildenbrand wrote:
> On 08.09.25 13:10, Lorenzo Stoakes wrote:
> > This simply assigns the vm_ops so is easily updated - do so.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Cheers!


>
> --
> Cheers
>
> David / dhildenb
>

