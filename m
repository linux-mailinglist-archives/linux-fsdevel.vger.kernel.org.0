Return-Path: <linux-fsdevel+bounces-67738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F401C4878C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 19:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B40CC3490F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8983128A0;
	Mon, 10 Nov 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kDaOWVLm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SeI2aq7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB052E7659;
	Mon, 10 Nov 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798061; cv=fail; b=lIIK/stTTL9ous6LS1TYO4AOKIu2T1uu/PQYQYzZ+vcQXWvcuylBcEZBU0/peJccX9oVMxKQaXHaNvbiJu19nvdLTXjauj0h0LIUg4WLK5iDYWB+c9rB8sYCaUrr6XY4NOCjTOK2iahkV2r832EHTuqXjwB0IHbSjXNciPksCcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798061; c=relaxed/simple;
	bh=bzywUbb/Z6Drb8DquuCnA4Qa7Up29nvtQt1nuWq21zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJDMS0ZSskhd/fX6hqp2XMhBWWFn05t+fjGHMouZ9yC0v3rff2+D3grdrx6KT1VnkC8fJPUsMn3jrJg++RROO6m52wRc88o4dgO2uvKkbrFHXdVkUdsHD7VUZejnr4Mbz22uuerIGaBDN9QdyJaojXmdwPgEDfZg7D6RzW1eKOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kDaOWVLm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SeI2aq7b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGNXAf016805;
	Mon, 10 Nov 2025 18:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7IQ8xtY74+z2lYc5vC
	apRtY3zEx2gwrq5GPYweScPZw=; b=kDaOWVLmLAVzO07DyJy6AsOaOOjZwEi8XU
	eqyodnUwAjYsgO8KYYrgSkiMWFutj2oyYaDR71rRq1ks/Qkm3ZN/ipKnLd/FFNkF
	XJRyczPz4BBQS+17ClRtndvJd0SiXrNeB5PBenCzHAVEFDYZbkoLgJB88g9nxXzY
	PGhaJMZ53OKdLpp8uwvXGXNpddOzzvtEu4AzPdnfod8sAyfFO+sS66AxyrGa5iLN
	31UIBtFs7C6WBhDXi8gRug9wHen4ANgpbM6PfVcLdyDvCoGwHwQnXZxu7H5HJqbJ
	4Wae2csrDJdSeeOBQz/4FsXJHEeQgEMXFOUkfFL2MvaA+aoA9MzA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abjhbrep2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:06:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAHemRR007359;
	Mon, 10 Nov 2025 18:06:07 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va90hft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB+Ul0fiLQJ1dG1XeQsO1V7ncRrPRy89PpI8yzPBolTLwhFms0KmeRqbtt8TiJX7mv+8zV3zJXNLCLOYqMBSEBowOu2rw8KUcd8YJoJRTltzLaR+QLvCJiZzo8vJGrvpAj1qccPlriWIOXKUqrzSDFfPOzewagwZaqrEw2pFh5qwbCkapxyxd3mSw7AmkaduXe5I1AdVdrxYRU8uxH7QurU4xyU43bK10bLbHqvEnkFVXIA6NrJuoju5X+Sry4AAQL/ldVTVaJUC8bX2nUUZ+wFwl8Hp8kbMc5IqhE5JVyB9J+Ir9SZbesF/h3kPPD8YZxapnY9OQ6uj559QryKPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IQ8xtY74+z2lYc5vCapRtY3zEx2gwrq5GPYweScPZw=;
 b=f0S8iZgafhF9CbxWflcRtU5GieTXgRJaCwDJYIXUlBAC3/bkKC/o90vDwlsuxfXC597Owy9D9mv9mP1JnLV0fjv01s6Ex9R7nDnGycWSNTqkfMXEY4voY6WEsF5ip7mOals5yCpvk9ZK5A7LLJBz8YhP9N4gwXbbKm1VbI//4LpXnLsQR6yVrDMACWVVW6yjv+hBW0iiEgvpiVUgKyCT8uixumFGgwYbMKHVZ1mNQ3Vpr1nZCGXIIC+dlzRqB0Kz5wDx+UvYR0HljAKKU85DoKdjDAz+Lb7ULTPrsLK5mCNlSxVvdfloOsOabkur0YfKTTdERF1uKSu/PLgTNd2cxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IQ8xtY74+z2lYc5vCapRtY3zEx2gwrq5GPYweScPZw=;
 b=SeI2aq7bUZwYjsh+T4EF0E+Dt1S5tvpLU8Qtz7bZhpbZ/tKGPGe3DQEAWOk6wtIYMTnh+jiONG3AdYqAXaftItcCXKPt0ft2fBAND9v7O+1gekex4Kf8PWTsqdYBTq5xsUmLKpJh9T5pkkhFzwnG4mMBMwbMuFVZZLdE4FH6ebM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6611.namprd10.prod.outlook.com (2603:10b6:930:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 18:05:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 18:05:52 +0000
Date: Mon, 10 Nov 2025 18:05:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 01/16] mm: correctly handle UFFD PTE markers
Message-ID: <faf82f6b-d0b4-48d5-bdfa-11e6472d8ba1@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <0b50fd4b1d3241d0965e6b969fb49bcc14704d9b.1762621568.git.lorenzo.stoakes@oracle.com>
 <aRHJ0RDu9fJGEBF8@kernel.org>
 <1a77db9b-ddb2-42bc-8e8f-f4794a5bfc6d@lucifer.local>
 <aRHsSxhIikzC9AAN@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRHsSxhIikzC9AAN@kernel.org>
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: ad78e4a8-ca1a-4c68-896a-08de2083c952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24haocQxH5Rq1X3J8WvaeBuy1ZEZsANC1EAzZbd2jeaFOnxSzVKbpQmqgof3?=
 =?us-ascii?Q?7W8Ls9nAOFDrTfyyhyDyNQWCeitM1In5dESEV2FZS2D+uFxUiNJF9ZX0FWUY?=
 =?us-ascii?Q?OyNz+9TVug0mWYjqD4v0Fq0SXynF5Zd0BxaaTuq1CgbRT18J11WsrEfcjhQ9?=
 =?us-ascii?Q?ojYVvRCDFOFh2dnPlJEKnQHXDdS5GQMQbKhmj1rcUizdWY8IJh+cuV58+7l2?=
 =?us-ascii?Q?GN3JcArSqZv/x++FdEDVKNAwXklR1PIGrN1/DBL42bXu9BxiAiRz0KbCB5Cm?=
 =?us-ascii?Q?F2nEtjW59K2izNkwaVVfIbyMcCwzN175HbP+kQF1pYaNas70UCRJ7r6B27ZK?=
 =?us-ascii?Q?CWjs5TpsJ694D+uDYfrO4JL/IzvRgdcqk5oYINgkuhK59t04Nb31VqcGhq5U?=
 =?us-ascii?Q?dp3MUjigFRgIZ1wlU62AXxyd7r2ZAOtf2P1cYAdQ4LZBehff0GC+rVSmrFkr?=
 =?us-ascii?Q?mmXJnPwRyMgaBDyXkpbRSQ8KN8PUeUPtKU/3zKSi3PHcDj1obN7YpinjiEHg?=
 =?us-ascii?Q?p/RaHdjKrFQh1wT2wJB4h3X/DRu+9ax1PfgfMEwZfZMsNfMhxUhG8PEZChBc?=
 =?us-ascii?Q?2EZ6X2tqz2qnKKs0/9vCUcenJpTVgZjgBUKzd5uG7PnDzBCVpIo50qsm+31u?=
 =?us-ascii?Q?sIrx5BO5qA1xAzyWkXcKGwT+KOEGwjyLFL82dBeQcw+gT7QzHxg/vvY0sV09?=
 =?us-ascii?Q?tLIEwkhK1t5jdSs6V1JJ8EDDCE0h2TAQdQVxMDojZ7kthhcw34gZJZg4/iKc?=
 =?us-ascii?Q?uAjEW/DEw0wh7RX5raVO4Tct+4XjPCbW5uqUp++JdD3PFU0vlNXUyXXsd5v7?=
 =?us-ascii?Q?37bXf53F7bx09eg0AA6tqCtPJfj83/+tfg2OzZeDhM0IjBjHr4449kfetvcv?=
 =?us-ascii?Q?HXywP/7Ooln6BnFdXvrzf25B2prfY9jZajen7WJ2ZoL0O+yz5jLwEIusN6cp?=
 =?us-ascii?Q?FDt4KpyNuJ9uhLO/QxOH8VGsjhl8LtjoLGDYHaQl+o53QNvd6iE03wPfwpLP?=
 =?us-ascii?Q?RY1vYLpqFy1U9T3OJPBQpqrM6d2MeeqKp87O0LshvxpEuPJPyB3XamEUQWm+?=
 =?us-ascii?Q?JOL/4QTQQvVYGFpN1frH7aT4mHA2vlOO7geZxhvrf/yg5Vwm/Ooa25uvQ9c1?=
 =?us-ascii?Q?riHrU1XCuHfGndFmFRZxipPbQtoS+mD34jN2wanoqnYtyvrOxJ6+OLFrcQV2?=
 =?us-ascii?Q?yl4vA0cP9tKohtiTw53HgBWDJfiLQyQ7UCqNd1ZAjmbEEqOZ3kY3jP3IeHGv?=
 =?us-ascii?Q?v2FaVR29OuZRvi8a3ZWRXvKlre+m7uPsV3NFQ9Dx4NR3nNSSHxUK/VHeOCEj?=
 =?us-ascii?Q?v+Vy+Xkcd6q38FHkRRINmGsBmmae714nUfa97VqWrVsutvxVRZ4EPbz09jVe?=
 =?us-ascii?Q?SahLrSbaNmgYq9jKhDzyN0XhmFGCt8ZdxrGglnxlY44UUqN92aMHzfRVp9FD?=
 =?us-ascii?Q?JYFpZuYJl9XRayGBT2aC2pPrdDPiCAQr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/71qSM71dMsdM/WGBzlzvJrztmPB92zVECi2KLTGI1AMYQ1e8vZ8m0nM4Lv2?=
 =?us-ascii?Q?hNM83ru99hujSLuxazwdtTfOF06MB7aMH0slwuSjp8kUy37GOHZUc8N9t7+n?=
 =?us-ascii?Q?Hvneuz0g7yj41L+4uDHv4fNwgMgU6J3HFnyXeQYdXtl9F6jD2htNyaBlEkFE?=
 =?us-ascii?Q?ZyTRX/w258UlVTGOC1lLTKTFxDeTFZY5L+YfMLI9XVbMtIkFkTjiGNlaButj?=
 =?us-ascii?Q?ELpWVWWiDRYVO0fDcGxHcGVlD8p5yCTG9k3Frt2toesECSvOMDIP5LGVSECK?=
 =?us-ascii?Q?GkycpRKSj4YzpxvwEJzKgD5+Wgz4muAiJt4CMMHRygCg5EhuHENor8X/EOLF?=
 =?us-ascii?Q?J14q814/Ch2NhaLaiTUSUevk3GaBW8hQB3Vl3hnxS7GNSCloQHTzgHyjS26w?=
 =?us-ascii?Q?/oiFy7meU7sISGQEWJro9EzCStJWGzPiE9lrxIOLlGBaMO2B5mdEtrfd2DUM?=
 =?us-ascii?Q?G+IP58LUNKyZJQIiD9a1kiqwmqK3Mrcry2Itzt0QpRAZRWldLgLqN8e0+UQ/?=
 =?us-ascii?Q?mXNOKW2yfFTiOClAln+wCcWkpm/jC8Cc08+6UGrEpT3OVPinJX+WjCluqyqn?=
 =?us-ascii?Q?bZBl+cHih246bsvDdtclKaDB72fWJ+XSned4NYGEWDj91O8IU5e/bzBG7+/R?=
 =?us-ascii?Q?8Aojaq9bhS6V8Bkf1qVbL+oPBBq43NZ3jZDmnFOKpvZYmgykOty3qN4fFGXg?=
 =?us-ascii?Q?u4/31lJNT9j2hpxcxZMecbXlfP7GVkOu+OGhv7wM3Z7zAJH8drApSXarMYWF?=
 =?us-ascii?Q?qLLgU1LfLW+jhtt5Nmab+QwASUB7UuV3PiLk3ePxULCbztbgyVLnW+YrZo70?=
 =?us-ascii?Q?Yg2okU1L7+BVju9K6FdSCnZzoBlNx42/mwxDtvKweWMsD5DvVqu0D5PGH5mj?=
 =?us-ascii?Q?rvQhxbqoLpgPHsHZ9Otvg80UHcvF4daQUPncqjO9jClWMr7jmXurGNUgweBq?=
 =?us-ascii?Q?ue13FM7594Iaom9Xn9ENXsxyKHn/mp4okCGfX9C322TSjq+4pZ+REbFFAx7R?=
 =?us-ascii?Q?QF70+gdfqnq2xyG4F+d7sjhiI9Ol3zFecizfi1RwvRJtuREGi9CSJ0CVi8l0?=
 =?us-ascii?Q?e3Aq6HaHW3MrwYCsyWxKMDmeGf5GWLgVS3L19S5XXiU+GGr7htl5TDtn4ZL1?=
 =?us-ascii?Q?r12Ml+1aNMaA+QV0n3OQiE2EvixjswXEOJk00MutBMcMr59fK8NiQBIEqJ9A?=
 =?us-ascii?Q?hT/vOr57QyjxLazrpeR17qw+0E7HL11twVtGO7JcQ8tvJi74V/G8Oh8tzO6m?=
 =?us-ascii?Q?8wtWR0hFdQYp280vIAlpFm4MRGS/w1/KH4saY9nTK7y2K6m7vfA75c1BJ/Mk?=
 =?us-ascii?Q?c85983RcrnVInkIYFtEgY+kELvNWnhxSiPEebV0KcdahHvAP+/TI40595sCf?=
 =?us-ascii?Q?0UNeNKXPPSpMKGSnL8PxGOkxd6xm5NTzj+ybWdobgJIl0veafv2AclXHLR7q?=
 =?us-ascii?Q?9f1sTE0E+BWok9yQ7zp9bfOU3UTw24XOvKNjE2trvOAFOZbS1DcWgpNnjA4t?=
 =?us-ascii?Q?Khx+ZI7SBJ2Ne2S2Vibpt+axhn4iN1sZLlJvRmA9ab3rd2tQAeYAz74pCUTa?=
 =?us-ascii?Q?T5Xj5XjQj0uoHGLg7h2qGptqgCePZxyed6h8b76pDdh+m8nX+QNA++Ocv2gC?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WIuHI6eaCqWz/ly3Iys6NqZCLBpcrtp9mn/ZTzylwXWrNgNUuXNIck8zEpXk/ar12yPkLqAln/5OoFdcoGuAkd4fgpEhKG0S/TpnXQoKiGr9IJY/c5RMw40wN1jkTP47BxecUFkyj0B0/qdXvNtWIOiUs826mvP38U5Fj5Z6Kdi8ILivtdoffcccnasR7pKmnUsymEk5VkkrHu4JH54TxTOIUq0EuOiKWkz2MCFahVdX7eURHAypT9sVYZu1BQ9otsb6/ti+ChZbiClPDAwDiPPFVP/IpIkTtR+452OXZeWGARDp71JvQgtfHx7rZfplWv6r2IwSsAtzY4jUfX4Hj623qt6yyodQdckDY+ASLqqTNCZV3ETAkobAPradge/VWQDVS3NMbFBM8xyzCGAC5X0d1IpoQemcdkmGXg9pqHX2YG+YBMBxjMP0KaH3PzjPXW/Kv2bmQfLPBP1wg+RT4ZzuM/j2Qqf1z77YXwB0KUsmUP5sANLxZJEBP7zHty78HiabJipqTXyMDWb7Sa6TkaW7cHwGX2m/oYeRgABtnpEzpcV/FA6U4lsiA/vG0jmTJCFU+yWaoZYM+yLyPFiNy9ont8kYCUxH5eVQNToaXQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad78e4a8-ca1a-4c68-896a-08de2083c952
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 18:05:52.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6857vkmWYiffrUz+ne41UafjuOn3ORr6XWhjWLD13TGwE8CRhNU4UQMHFemjGYxPKsx3Zfg9Io3/mskIctiGPdE1P+bPFYJT8YByogGIZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100153
X-Proofpoint-GUID: uvirbwRjrcFGLyNRuWSoPG7WYyPOu7Tk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEzMCBTYWx0ZWRfX/XDX/P4DeFAd
 3Zy8nY6k8pT91tE+ydRDUpdN/j22ECWbF1RsXCcmUd7TsTkQNzYVc9LPTC0X3k0cOx6CM2qIMzi
 nl6ubJGR+38CeVUsj08W2PZdCMs9NQFuT+OfOzSOf32uwmceIiH4SoXteq2Cp0svoh43676xnAq
 KBoK0IwejikTUJyeNHSrDrd0LxKsLuQaz/3LievLK4hx/cmaOmB7WHkedomYtmxEENWCw0FSUKc
 oOgom2QktvhsHEbAWcrPOOqHCuD1tSEffs63mpPVMaaVSctaU4Xtqo9ixiXuSRppIk9HMUJxzVR
 pC58a7TU1yCpfqEai53rpkuRWZ2x3ZTrgOS66/gWCi1mmvxV8AGdiDNZg1VFvXycaXzOMvvKYKF
 GpKdpAtGAIZa9Bv9KZCB1pIwNs3ojQ==
X-Authority-Analysis: v=2.4 cv=I81ohdgg c=1 sm=1 tr=0 ts=69122990 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=HWg_i5MIUKt8J3pdJrIA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: uvirbwRjrcFGLyNRuWSoPG7WYyPOu7Tk

On Mon, Nov 10, 2025 at 03:44:43PM +0200, Mike Rapoport wrote:
> On Mon, Nov 10, 2025 at 01:01:36PM +0000, Lorenzo Stoakes wrote:
> > On Mon, Nov 10, 2025 at 01:17:37PM +0200, Mike Rapoport wrote:
> > > On Sat, Nov 08, 2025 at 05:08:15PM +0000, Lorenzo Stoakes wrote:
> > > > PTE markers were previously only concerned with UFFD-specific logic - that
> > > > is, PTE entries with the UFFD WP marker set or those marked via
> > > > UFFDIO_POISON.
> > > >
> > > > However since the introduction of guard markers in commit
> > > >  7c53dfbdb024 ("mm: add PTE_MARKER_GUARD PTE marker"), this has no longer
> > > >  been the case.
> > > >
> > > > Issues have been avoided as guard regions are not permitted in conjunction
> > > > with UFFD, but it still leaves very confusing logic in place, most notably
> > > > the misleading and poorly named pte_none_mostly() and
> > > > huge_pte_none_mostly().
> > > >
> > > > This predicate returns true for PTE entries that ought to be treated as
> > > > none, but only in certain circumstances, and on the assumption we are
> > > > dealing with H/W poison markers or UFFD WP markers.
> > > >
> > > > This patch removes these functions and makes each invocation of these
> > > > functions instead explicitly check what it needs to check.
> > > >
> > > > As part of this effort it introduces is_uffd_pte_marker() to explicitly
> > > > determine if a marker in fact is used as part of UFFD or not.
> > > >
> > > > In the HMM logic we note that the only time we would need to check for a
> > > > fault is in the case of a UFFD WP marker, otherwise we simply encounter a
> > > > fault error (VM_FAULT_HWPOISON for H/W poisoned marker, VM_FAULT_SIGSEGV
> > > > for a guard marker), so only check for the UFFD WP case.
> > > >
> > > > While we're here we also refactor code to make it easier to understand.
> > > >
> > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  fs/userfaultfd.c              | 83 +++++++++++++++++++----------------
> > > >  include/asm-generic/hugetlb.h |  8 ----
> > > >  include/linux/swapops.h       | 18 --------
> > > >  include/linux/userfaultfd_k.h | 21 +++++++++
> > > >  mm/hmm.c                      |  2 +-
> > > >  mm/hugetlb.c                  | 47 ++++++++++----------
> > > >  mm/mincore.c                  | 17 +++++--
> > > >  mm/userfaultfd.c              | 27 +++++++-----
> > > >  8 files changed, 123 insertions(+), 100 deletions(-)
> > > >
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index 54c6cc7fe9c6..04c66b5001d5 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -233,40 +233,46 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> > > >  {
> > > >  	struct vm_area_struct *vma = vmf->vma;
> > > >  	pte_t *ptep, pte;
> > > > -	bool ret = true;
> > > >
> > > >  	assert_fault_locked(vmf);
> > > >
> > > >  	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
> > > >  	if (!ptep)
> > > > -		goto out;
> > > > +		return true;
> > > >
> > > > -	ret = false;
> > > >  	pte = huge_ptep_get(vma->vm_mm, vmf->address, ptep);
> > > >
> > > >  	/*
> > > >  	 * Lockless access: we're in a wait_event so it's ok if it
> > > > -	 * changes under us.  PTE markers should be handled the same as none
> > > > -	 * ptes here.
> > > > +	 * changes under us.
> > > >  	 */
> > > > -	if (huge_pte_none_mostly(pte))
> > > > -		ret = true;
> > > > +
> > > > +	/* If missing entry, wait for handler. */
> > >
> > > It's actually #PF handler that waits ;-)
> >
> > Think I meant uffd userland 'handler' as in handle_userfault(). But this is not
> > clear obviously.
> >
> > >
> > > When userfaultfd_(huge_)must_wait() return true, it means that process that
> > > caused a fault should wait until userspace resolves the fault and return
> > > false means that it's ok to retry the #PF.
> >
> > Yup.
> >
> > >
> > > So the comment here should probably read as
> > >
> > > 	/* entry is still missing, wait for userspace to resolve the fault */
> > >
> >
> > Will update to make clearer thanks.
> >
> > >
> > > > +	if (huge_pte_none(pte))
> > > > +		return true;
> > > > +	/* UFFD PTE markers require handling. */
> > > > +	if (is_uffd_pte_marker(pte))
> > > > +		return true;
> > > > +	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
> > > >  	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
> > > > -		ret = true;
> > > > -out:
> > > > -	return ret;
> > > > +		return true;
> > > > +
> > > > +	/* Otherwise, if entry isn't present, let fault handler deal with it. */
> > >
> > > Entry is actually present here, e.g because there is a thread that called
> > > UFFDIO_COPY in parallel with the fault, so no need to stuck the faulting
> > > process.
> >
> > Well it might not be? Could be a swap entry, migration entry, etc. unless I'm
> > missing cases? Point of comment was 'ok if non-present in a way that doesn't
> > require a userfaultfd userland handler the fault handler will deal'
> >
> > But anyway agree this isn't clear, probably better to just say 'otherwise no
> > need for userland uffd handler to do anything here' or similar.
>
> It's not that userspace does not need to do anything, it's just that pte is
> good enough for the faulting thread to retry the page fault without waiting
> for userspace to resolve the fault.

OK I will clarify that in the comment.

>
> > Cheers, Lorenzo
>
> --
> Sincerely yours,
> Mike.

