Return-Path: <linux-fsdevel+bounces-66761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB91C2BB2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C76D53498F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6735530F523;
	Mon,  3 Nov 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K1lN50S9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IXFm7i4z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203430E0D3;
	Mon,  3 Nov 2025 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173249; cv=fail; b=oFt81m2zLrZ8XhN+AgdesBcp3Sf6UXGzyNbgysCptOz4rOLS8DnCcl9R/SZBuSRaoPyHBuiHTl+gDBtBFBQ6C50VXpXOWee9cQozNHjNTwtFXKCEyAmwmzPD9HkGJAJcqLp+x0DSmgt8YcARlC21GGafXVHWZDby1rKNNLHcpW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173249; c=relaxed/simple;
	bh=6P80hvkhcRb9iNjVgx1Ux8MHyYX/xlGjFoXeLkgriNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVmFUfMXBsbEnvuS1v2Zri521bnhzlnk7yEbgFrKqJy6d7eWSH+xlQHuA3wRC7OJ9Wz6WCwI5CkPG2cxlMayb807ckqDG/amku+gI68/CG0xKf/xA173gaAe2asy726uXAYt5mg1yJnrSpn5vDcFyPTSPB+88jrAIKBo1oQHe5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K1lN50S9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IXFm7i4z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CEcsH017255;
	Mon, 3 Nov 2025 12:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f03NiZg1DqFruMm084IJOTaL3bBz4ruFyVDEqvZTDPU=; b=
	K1lN50S9hslWNPaKlI3a+RNMJzRzzfSpu79tVFyIxFiK0xQrSalRArX16Dktz6rw
	SMu13pf9vTs3kttmn+WSS1VJkFx3QPv3e/K+D9DtQ8m+O2E81TS7lDHhkxUc3S3G
	7q9qpWU110yj6dAaTwfqLFFyLwPTxyxzJ+aRGApYvp6pWvgPDY1acRREj2BNpdNr
	aLya/9UTOX1mylHmhB1saQ+hGAfKd3jApIWFn+6j2ryzvG7fj6zycjpaPTldFSe8
	xu99NfmvaPJBArT4T8wRHVYrY3i6hKFWSFUTRa1rUXzephTs30rfpqjpNSHnw8cT
	FH3/7odAh0KDQq1KVwLbSg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6v7kg0wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BKtua010909;
	Mon, 3 Nov 2025 12:32:15 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbkss3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRN8yg6KMEUKKF+zl1tVqvH6MaLHe9hgVwT1G47e2vDelG6CzywYEju0ofGNQ9apJZR1yEQU/u1Jt6iYSMf0PNY2LdJ2UfutiIqQWhit/riLYkYP5ons4vX6ZPbRq/bf7udQCRg93KfB2T0ccFrjXIgG9BqtBWtpAlxdZ07E1j99y1l3kdiaPOeIkWlyt7c3bG8BBOdFRq7Y28M8IFpg+HwMpBmb3pU7kh7lmzV7qTrBfSw6A4Tkhi4L2T5MFubxyk1cSiX/1roOOmS9eg9RNmYN06bA4VARVOv/1aYvhIyCPuQqrssTccR7cQSqby77MfUBB/qhiL8Yx2zyplvWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f03NiZg1DqFruMm084IJOTaL3bBz4ruFyVDEqvZTDPU=;
 b=AfrH5w3aQeaM4XzPxmYigl0pAJwIMgWgQPgGH+nSZ6Zk4G5VoI79lPbm84pvSCvKeC1SkomQkArX7a72KfeqcKqhkcohxTCU0hOeSPrKHQIdxDKk5jZlW8g+Gtkp2XT6SWZJUNq4eSwIVeLTzqpP3htNTzaREmLxGiUtqTdyjOyTrmS4VST/iQkE+JcRAk35p61cu26GDpaLIjykeiDbFxX2gTL8VyDY/5qb9S+RzxKxNVDiGcIJxf160mkSHUSf7drrRlCwwrIJXA86OMC8gXuURGqoZPMsPllm73Qo1VuuhMJK+fk2p8WMq8pClPlyHgwuopKo4DMcYteWQJx4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f03NiZg1DqFruMm084IJOTaL3bBz4ruFyVDEqvZTDPU=;
 b=IXFm7i4zwqmRPzYHLARKXY6MhaSmCJhCsXMvGbyzwq9SjnlKWsf3uRCpyVkh5PpEa5dYXCMl6+uamVDaw4lbRq8dMkTNUqecgetwGY2tW0mzQ13WDDBtJOqk2aoNEx88wLqoxIbZRQ1qeHvTBGaUYYr0wIr1gszxlzMLMjy4p1c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Mike Rapoport <rppt@kernel.org>,
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
Subject: [PATCH 01/16] mm: correctly handle UFFD PTE markers
Date: Mon,  3 Nov 2025 12:31:42 +0000
Message-ID: <6918f70e17e23341d2425328bb991e2e094f7a7e.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0594.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 693c8eb7-6679-4361-6fa0-08de1ad50378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agnsn2cISZMGSrC/8JBrH8aWq3A2QEaH3jDvf11/eo747CWenprAnm6uDIE1?=
 =?us-ascii?Q?Zq1nRshUrJMdUMWmJg2huR0W4WSGi+sjG6Tdi0LkDIq4/76OxiZwTPz8gULC?=
 =?us-ascii?Q?8aWv+IZqkKidE82vYdwk4MTmFFTknGCmIKmB+uO84/PUBd7CE2INbeVzr7iT?=
 =?us-ascii?Q?zwHTiWe4F6ns/JvUV9Knf3dZ2dEvD4zwyiF9x6/l8yptBolL3fOLZB9B4+DD?=
 =?us-ascii?Q?egckD5RjozD9DDMM7vOV+4XutqtMg83AvXTt3sa2mYkKvS7ov3WDz4qNYvSe?=
 =?us-ascii?Q?gx3WYJhd8FDAgJbiQTiYxjdxNwSpVno/pDXGHbpG0KR6sbK/gftQygiRvp/O?=
 =?us-ascii?Q?399dTLKFoFHlAAOsa7SSGVM+1YWmtbg3sLIkAb0/87ZyBHrvPTf6GTeEN0lm?=
 =?us-ascii?Q?oP8K7Wh+Qfihy7geWze1haApfV2GQtCpcSfN0bgt2Ch2UhzbNZqR9BUzsch4?=
 =?us-ascii?Q?TagW/BwScL3EsZhd5QMTyi/HfFUw5UOfueNRIgB+sR+CEJ255IquOg2Kz+AV?=
 =?us-ascii?Q?DG4V8zLeMp3t15MGBVE4rRYUdr3PbCpmwyOgUvBrfV68I3MGGJINZlxlvFtN?=
 =?us-ascii?Q?Dth1UbZ6VtFYYDKMYqkhsHzElaUnKKVK96hZlw08IJNZ7c2M0Dbv8eTy00vH?=
 =?us-ascii?Q?iaAD0GO2yWxuGAvXzgKTKolZnCqo/xU02LYGHapfHgpUhgRW09Qjucj7I0z7?=
 =?us-ascii?Q?Lf2AUQSDdmioNOeyGOtex93VYL4VU+6WO3Piv+hYFBIuG5x4wThTxNayfIya?=
 =?us-ascii?Q?ZUV7Tq/tRfjqVCW8NiY1+SmM9jBdonYYzZ+/YMWs3Vuj5RyJlYCqhwkUAWyW?=
 =?us-ascii?Q?xDoozAzvfhpBojAupnNH+Da+EcRC6tnGdMVST3hKtd4R/Yxqpkz7YV6SApkI?=
 =?us-ascii?Q?gPkVviVROKRaMh5HyrBv9KflRXi4RfxRkh4+ToxMyW8PNweD/Z3JyueweAv6?=
 =?us-ascii?Q?neSbQHhSgGVK65NIukBVp4WoDnmFwuSA8YwFVcoiLklBgScFIWRhqLESnSJ6?=
 =?us-ascii?Q?SIT8Mr1GTssQF3DM/PCxub7w1lZ0FPAmAWtMB2k9BY778ra6SsPLdJpX0y1B?=
 =?us-ascii?Q?eenvKphOCiQQEWY0cX2wIfOpHHMB+u9+argq+lmzHVhzBdn99mX1nznrj8Vq?=
 =?us-ascii?Q?k49JwuH48Wpt4iYUh2jpgVTMhvPTe02KAj4JfW0+qifJaCVt0HD5VyP1RwDM?=
 =?us-ascii?Q?/iTSnB/fgArJoFpjPHVLgy/bNXQ70mZAMyBtzt3YoBShnz7IHuVQPqh8yMH8?=
 =?us-ascii?Q?vVQs9Nx1JSMQ9m6nX5mjZ8COpPkRJTrZRSGAWY3c8XjTqJ+cAh80/4kH6Deo?=
 =?us-ascii?Q?PrIiq3kFBvXwqXUKAcMlw5C17lp6TijYWzkd60kxkzg5kWnocZJ1whH/BcPy?=
 =?us-ascii?Q?Bommdj91bsX8S7JiVgnaKeTVixejptdMHBVwOOuA7JW22rQqtFm6JvSzue3U?=
 =?us-ascii?Q?v1h/mgwTrhCn3aitFb6l1Cl3eWc3eRlC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?le4Dv8Rt36UlzZagHbrwNQwawh/zc9tVaTkFAz1IfEn9Y3P03MUfixipTKZt?=
 =?us-ascii?Q?EnQcIoDRY/Pq7hOmwwKzCN8BCNXQiU4rPY6uks8cFVYT5k0OoBW1mdsg9GDX?=
 =?us-ascii?Q?3ScTzZMnAnsQPOS9l0oJB4mUm1WGfsEJ9clSerOTYpm+iGRxKVh5/Yk+CBFD?=
 =?us-ascii?Q?g6G6jmx8zXVLoLAUbwkkTpJ27ujC7ws8u0pMs6ZfCPE57KLi+k2J5xLWgFQJ?=
 =?us-ascii?Q?9BAuUZgUsgK1fwvIPTG/UcXxs9YUILEzllsLtcBjC95C3H3qGHN2MzlwuYHz?=
 =?us-ascii?Q?XJqTWuDy0ERcLf0cif56EPj9Z0HQGC5aHKiaIoptSYc4bZ7qDao2zZUkh7X5?=
 =?us-ascii?Q?pl9BNfH7TdXcpBepYHNmRuvlHOMdhqgf5C7n0JMM0fuCR49wqOtqjpBKwKR+?=
 =?us-ascii?Q?5serVQURR/EUCYBHovanp9SServ5g4qI5Y5QK0Ho6pKT5881/Wn+hztFwgED?=
 =?us-ascii?Q?Dm7/xbbyd9KMzUob5LZQlgqwn97Hn1qwVBRDYg1Y06Q/NaHMV2s2xXJEzaUv?=
 =?us-ascii?Q?qLdAg00+sIeb2fd4EXkNoI6R8nA74V8mzqejcVikSbw1BSaK2LsCmHM3bD12?=
 =?us-ascii?Q?Tar6T9qpHe+DC/mzPrmYOQ5RelSaTGliofQOWAp/kbavoFDV8XvsOFYTNrUQ?=
 =?us-ascii?Q?ZJvo7OkoP1PSOq3pTjcvZEX/0OvCAcAzaO+umDriEngiyluuSqbygmo97SIg?=
 =?us-ascii?Q?lH7GIeb2WWgDt4+6O/wcXlC8xNhL+20980ZhLfwdkv8uUtHG2NUAk/YvcwQ9?=
 =?us-ascii?Q?ZEEXTTkjvq65EpEMSK8hg7F/yX1b/FqXw3yy2N6GEvvZ2iqypDG/NMU1M4fk?=
 =?us-ascii?Q?Rf3CL9kqeEX8NMj9MSGICOHQpK75/jvbdumI2Jg82TrH/Xhf8Che5hE6lk7i?=
 =?us-ascii?Q?TVb2EbleSVJ5mfMaJI11wy4FreSks8ci9MT0dwqV0AsKhLyjVNc5k3ZPzCBu?=
 =?us-ascii?Q?gJWIbY+pw28G4I9rw7wIdm7DvJbmbtvxdq+CaVIfaTX/vChe4VTSQzw3+Fnp?=
 =?us-ascii?Q?zKDkFTFg96KutdlvEUXl0H7vrosjASlJljreaeRVevSUmhLLH9xonQxkB6yH?=
 =?us-ascii?Q?j5UmMS8HJpU0HmQWARw+qwLU9fPbgjTQ1OyORQIlkJPuKTL0DSMnJzowzv0J?=
 =?us-ascii?Q?CIWHar15WnxT2cB/QNVzRanbgdjl3NjP9JQtvIZ/pTW/h5DtoafvC3SaNmKe?=
 =?us-ascii?Q?5TSaVq/bRrwMWNOe7b1dXx8sqtWXH76hJ0jGMY8BwPzsabHpE4SEj7bDO0ru?=
 =?us-ascii?Q?O6DPmuK+fuxoFHo+2HZifxz4p4WdtOQ/2y90h61sjDwhD0AFtxzjSPkOTjwq?=
 =?us-ascii?Q?WCVgfRiOT/DuhCWhvLhWNiKYCWk0OPPrkjF4eIup0FbJ+88nk5TDsGn3HQF3?=
 =?us-ascii?Q?5eHkJhpAwgXKbuGNSdPVuzhudIoYAiyQaC4+zKaleXgKoohZyB8jyAqeSGPM?=
 =?us-ascii?Q?/EVDu5Z+EJRKjgG8bJtELZC+7/csWQQYxwn7kQUr0iZbn/NlByjBTqW6DxC3?=
 =?us-ascii?Q?XnzxrTYyCUgTO8d4qjTusDdqKDsXRxTmzq8iILHWKNgRNFa3SSqj7lTSVJ5j?=
 =?us-ascii?Q?LARvJlu+BviZDzuM7BnYhyb4EiC1lCc4ikwD0ch+BPfnwUF1M7QS+htvy+Bi?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r11qO5Qi7oup/mUMPyrpsuJw5zo5x7vHFruHSRz7yqIAi3Iv9zYnhc+85fpqIQNk5FBYg2Tp5OJW38rp+jqxx0mDsLY8+s6VkNxJy3bj+oT64ixmCLLAoMdYCcPtnG5yoS33Kym8DuSK9X61lE1hsX6YIFwwh5Plua29YJxjJ4zZJsnyVsSopWvPju6BSqMxbqb992Ia8dscd+G7TTvR9rZrMQLnVc58DgOZGUZFKag3UEMEKVbemLGifN90r/lEfQpykPB8OQp2GcRL/MifgrToUfSy3t3PYYlPUQuwMY2EiUknJwW9EmswW/QVzuu6hi8rT4+0cXliDcCYEzu4WjgHBCTj3jjP21VsOm1TftYWNMtUAXLmPIHhqi+FRncO9cIUyLzUzxibH/FnmcqDdwcWYVWqaIImQe/Jae+cRaSw1ws01ZIvCAcAzl+GgT7t4aEH6heElPtBx/hjxWs8m4QNfUdZP4tV38EPCTvFOTi6GnjM4+NyhDQfIPY6452C+KH8vR5R1J4niFrF7duXI0YLeWCOUQ6PFvqjuRcscI0ktWkLrB7Ic6rf+pI8RQx8QrO5xDCRN5k6vMcnUqEPE9h40IJFoQFPWL/4y2JWgZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693c8eb7-6679-4361-6fa0-08de1ad50378
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:12.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JRyxnrNacs+PD5TQi1b4Mh7Uut8rxvuVhacvRO1Ob1VBtrPonoT4SKhPR3la2n2NrkQDmU+wzCiNBHoVIXLkkI8euQg8UuQtKG8wMCKeUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-ORIG-GUID: WDxPEJ_WXtWnWg5sE5Yt3pax4_yy1pUt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMSBTYWx0ZWRfX0AqVvVsbrj3S
 IIBDLSiHFYJ5YOBW/UhS8Cl8fwgUptrqiGPakE/EiqzOrEQEPX4NaD8PsxXZgVo5Xm+RZlipq8d
 oHz4sjHkbN9zEybLVLoroW8TaCTCnLxcoNRMC65SyzBbCWU+e49Bs1G84/qjUIMWVAqKwx9ckTj
 smGhiOF5PMlOceQLF+LBJKszYOuVriSsQQH+u0cjdEqhIHNbvbjl5rREI+MSOKpc3QiTMhWrk5Q
 nnY1OHW2cDdmIpNvlaI7WV84BjJjnnxS89KmtYmTUNqn/EZv7UcfLs8HqiVLbwQERM7aUKUELBi
 ToFPAO/7h/cOySdN9V2ZCaTQaDGo6SSs6eQ8uBlXT2zz4qO6WQWJ2bdr7zosJMTZSOEXJuzKtxw
 cdeFi0k1e5bLUgeCDOnfpnOh8U5imFLUTI/iy2BkHty16jaktVs=
X-Authority-Analysis: v=2.4 cv=Fbs6BZ+6 c=1 sm=1 tr=0 ts=6908a0d0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=K7pD0KWnulOJboH6qJQA:9 cc=ntf awl=host:13657
X-Proofpoint-GUID: WDxPEJ_WXtWnWg5sE5Yt3pax4_yy1pUt

PTE markers were previously only concerned with UFFD-specific logic - that
is, PTE entries with the UFFD WP marker set or those marked via
UFFDIO_POISON.

However since the introduction of guard markers in commit
 7c53dfbdb024 ("mm: add PTE_MARKER_GUARD PTE marker"), this has no longer
 been the case.

Issues have been avoided as guard regions are not permitted in conjunction
with UFFD, but it still leaves very confusing logic in place, most notably
the misleading and poorly named pte_none_mostly() and
huge_pte_none_mostly().

This predicate returns true for PTE entries that ought to be treated as
none, but only in certain circumstances, and on the assumption we are
dealing with H/W poison markers or UFFD WP markers.

This patch removes these functions and makes each invocation of these
functions instead explicitly check what it needs to check.

As part of this effort it introduces is_uffd_pte_marker() to explicitly
determine if a marker in fact is used as part of UFFD or not.

In the HMM logic we note that the only time we would need to check for a
fault is in the case of a UFFD WP marker, otherwise we simply encounter a
fault error (VM_FAULT_HWPOISON for H/W poisoned marker, VM_FAULT_SIGSEGV
for a guard marker), so only check for the UFFD WP case.

While we're here we also refactor code to make it easier to understand.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/userfaultfd.c              | 83 +++++++++++++++++++----------------
 include/asm-generic/hugetlb.h |  8 ----
 include/linux/swapops.h       | 18 --------
 include/linux/userfaultfd_k.h | 21 +++++++++
 mm/hmm.c                      |  2 +-
 mm/hugetlb.c                  | 47 ++++++++++----------
 mm/mincore.c                  | 17 +++++--
 mm/userfaultfd.c              | 27 +++++++-----
 8 files changed, 123 insertions(+), 100 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..04c66b5001d5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -233,40 +233,46 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	pte_t *ptep, pte;
-	bool ret = true;
 
 	assert_fault_locked(vmf);
 
 	ptep = hugetlb_walk(vma, vmf->address, vma_mmu_pagesize(vma));
 	if (!ptep)
-		goto out;
+		return true;
 
-	ret = false;
 	pte = huge_ptep_get(vma->vm_mm, vmf->address, ptep);
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
-	 * changes under us.  PTE markers should be handled the same as none
-	 * ptes here.
+	 * changes under us.
 	 */
-	if (huge_pte_none_mostly(pte))
-		ret = true;
+
+	/* If missing entry, wait for handler. */
+	if (huge_pte_none(pte))
+		return true;
+	/* UFFD PTE markers require handling. */
+	if (is_uffd_pte_marker(pte))
+		return true;
+	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
-		ret = true;
-out:
-	return ret;
+		return true;
+
+	/* Otherwise, if entry isn't present, let fault handler deal with it. */
+	return false;
 }
 #else
 static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					      struct vm_fault *vmf,
 					      unsigned long reason)
 {
-	return false;	/* should never get here */
+	/* Should never get here. */
+	VM_WARN_ON_ONCE(1);
+	return false;
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
 /*
- * Verify the pagetables are still not ok after having reigstered into
+ * Verify the pagetables are still not ok after having registered into
  * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
  * userfault that has already been resolved, if userfaultfd_read_iter and
  * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
@@ -284,53 +290,55 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pmd_t *pmd, _pmd;
 	pte_t *pte;
 	pte_t ptent;
-	bool ret = true;
+	bool ret;
 
 	assert_fault_locked(vmf);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
-		goto out;
+		return true;
 	p4d = p4d_offset(pgd, address);
 	if (!p4d_present(*p4d))
-		goto out;
+		return true;
 	pud = pud_offset(p4d, address);
 	if (!pud_present(*pud))
-		goto out;
+		return true;
 	pmd = pmd_offset(pud, address);
 again:
 	_pmd = pmdp_get_lockless(pmd);
 	if (pmd_none(_pmd))
-		goto out;
+		return true;
 
-	ret = false;
 	if (!pmd_present(_pmd))
-		goto out;
+		return false;
 
-	if (pmd_trans_huge(_pmd)) {
-		if (!pmd_write(_pmd) && (reason & VM_UFFD_WP))
-			ret = true;
-		goto out;
-	}
+	if (pmd_trans_huge(_pmd))
+		return !pmd_write(_pmd) && (reason & VM_UFFD_WP);
 
 	pte = pte_offset_map(pmd, address);
-	if (!pte) {
-		ret = true;
+	if (!pte)
 		goto again;
-	}
+
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
-	 * changes under us.  PTE markers should be handled the same as none
-	 * ptes here.
+	 * changes under us.
 	 */
 	ptent = ptep_get(pte);
-	if (pte_none_mostly(ptent))
-		ret = true;
+
+	ret = true;
+	/* If missing entry, wait for handler. */
+	if (pte_none(ptent))
+		goto out;
+	/* UFFD PTE markers require handling. */
+	if (is_uffd_pte_marker(ptent))
+		goto out;
+	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
 	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
-		ret = true;
-	pte_unmap(pte);
+		goto out;
 
+	ret = false;
 out:
+	pte_unmap(pte);
 	return ret;
 }
 
@@ -490,12 +498,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	set_current_state(blocking_state);
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
-	if (!is_vm_hugetlb_page(vma))
-		must_wait = userfaultfd_must_wait(ctx, vmf, reason);
-	else
+	if (is_vm_hugetlb_page(vma)) {
 		must_wait = userfaultfd_huge_must_wait(ctx, vmf, reason);
-	if (is_vm_hugetlb_page(vma))
 		hugetlb_vma_unlock_read(vma);
+	} else {
+		must_wait = userfaultfd_must_wait(ctx, vmf, reason);
+	}
+
 	release_fault_lock(vmf);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index dcb8727f2b82..e1a2e1b7c8e7 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -97,14 +97,6 @@ static inline int huge_pte_none(pte_t pte)
 }
 #endif
 
-/* Please refer to comments above pte_none_mostly() for the usage */
-#ifndef __HAVE_ARCH_HUGE_PTE_NONE_MOSTLY
-static inline int huge_pte_none_mostly(pte_t pte)
-{
-	return huge_pte_none(pte) || is_pte_marker(pte);
-}
-#endif
-
 #ifndef __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		unsigned long addr, pte_t *ptep)
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 2687928a8146..d1f665935cfc 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -469,24 +469,6 @@ static inline int is_guard_swp_entry(swp_entry_t entry)
 		(pte_marker_get(entry) & PTE_MARKER_GUARD);
 }
 
-/*
- * This is a special version to check pte_none() just to cover the case when
- * the pte is a pte marker.  It existed because in many cases the pte marker
- * should be seen as a none pte; it's just that we have stored some information
- * onto the none pte so it becomes not-none any more.
- *
- * It should be used when the pte is file-backed, ram-based and backing
- * userspace pages, like shmem.  It is not needed upon pgtables that do not
- * support pte markers at all.  For example, it's not needed on anonymous
- * memory, kernel-only memory (including when the system is during-boot),
- * non-ram based generic file-system.  It's fine to be used even there, but the
- * extra pte marker check will be pure overhead.
- */
-static inline int pte_none_mostly(pte_t pte)
-{
-	return pte_none(pte) || is_pte_marker(pte);
-}
-
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset_pfn(entry));
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c0e716aec26a..da0b4fcc566f 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -479,4 +479,25 @@ static inline bool pte_swp_uffd_wp_any(pte_t pte)
 	return false;
 }
 
+
+static inline bool is_uffd_pte_marker(pte_t pte)
+{
+	swp_entry_t entry;
+
+	if (pte_present(pte))
+		return false;
+
+	entry = pte_to_swp_entry(pte);
+	if (!is_pte_marker_entry(entry))
+		return false;
+
+	/* UFFD WP, poisoned swap entries are UFFD handled. */
+	if (pte_marker_entry_uffd_wp(entry))
+		return true;
+	if (is_poisoned_swp_entry(entry))
+		return true;
+
+	return false;
+}
+
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/hmm.c b/mm/hmm.c
index a56081d67ad6..43d4a91035ff 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -244,7 +244,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	uint64_t pfn_req_flags = *hmm_pfn;
 	uint64_t new_pfn_flags = 0;
 
-	if (pte_none_mostly(pte)) {
+	if (pte_none(pte) || pte_marker_uffd_wp(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1ea459723cce..01c784547d1e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6743,29 +6743,28 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	vmf.orig_pte = huge_ptep_get(mm, vmf.address, vmf.pte);
-	if (huge_pte_none_mostly(vmf.orig_pte)) {
-		if (is_pte_marker(vmf.orig_pte)) {
-			pte_marker marker =
-				pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
-
-			if (marker & PTE_MARKER_POISONED) {
-				ret = VM_FAULT_HWPOISON_LARGE |
-				      VM_FAULT_SET_HINDEX(hstate_index(h));
-				goto out_mutex;
-			} else if (WARN_ON_ONCE(marker & PTE_MARKER_GUARD)) {
-				/* This isn't supported in hugetlb. */
-				ret = VM_FAULT_SIGSEGV;
-				goto out_mutex;
-			}
-		}
-
+	if (huge_pte_none(vmf.orig_pte))
 		/*
-		 * Other PTE markers should be handled the same way as none PTE.
-		 *
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
 		return hugetlb_no_page(mapping, &vmf);
+
+	if (is_pte_marker(vmf.orig_pte)) {
+		const pte_marker marker =
+			pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
+
+		if (marker & PTE_MARKER_POISONED) {
+			ret = VM_FAULT_HWPOISON_LARGE |
+				VM_FAULT_SET_HINDEX(hstate_index(h));
+			goto out_mutex;
+		} else if (WARN_ON_ONCE(marker & PTE_MARKER_GUARD)) {
+			/* This isn't supported in hugetlb. */
+			ret = VM_FAULT_SIGSEGV;
+			goto out_mutex;
+		}
+
+		return hugetlb_no_page(mapping, &vmf);
 	}
 
 	ret = 0;
@@ -6934,6 +6933,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	int ret = -ENOMEM;
 	struct folio *folio;
 	bool folio_in_pagecache = false;
+	pte_t dst_ptep;
 
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
 		ptl = huge_pte_lock(h, dst_mm, dst_pte);
@@ -7073,13 +7073,14 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	if (folio_test_hwpoison(folio))
 		goto out_release_unlock;
 
+	ret = -EEXIST;
+
+	dst_ptep = huge_ptep_get(dst_mm, dst_addr, dst_pte);
 	/*
-	 * We allow to overwrite a pte marker: consider when both MISSING|WP
-	 * registered, we firstly wr-protect a none pte which has no page cache
-	 * page backing it, then access the page.
+	 * See comment about UFFD marker overwriting in
+	 * mfill_atomic_install_pte().
 	 */
-	ret = -EEXIST;
-	if (!huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte)))
+	if (!huge_pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
diff --git a/mm/mincore.c b/mm/mincore.c
index 8ec4719370e1..151b2dbb783b 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -32,11 +32,22 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	spinlock_t *ptl;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
+
 	/*
 	 * Hugepages under user process are always in RAM and never
 	 * swapped out, but theoretically it needs to be checked.
 	 */
-	present = pte && !huge_pte_none_mostly(huge_ptep_get(walk->mm, addr, pte));
+	if (!pte) {
+		present = 0;
+	} else {
+		const pte_t ptep = huge_ptep_get(walk->mm, addr, pte);
+
+		if (huge_pte_none(ptep) || is_pte_marker(ptep))
+			present = 0;
+		else
+			present = 1;
+	}
+
 	for (; addr != end; vec++, addr += PAGE_SIZE)
 		*vec = present;
 	walk->private = vec;
@@ -175,8 +186,8 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		pte_t pte = ptep_get(ptep);
 
 		step = 1;
-		/* We need to do cache lookup too for pte markers */
-		if (pte_none_mostly(pte))
+		/* We need to do cache lookup too for UFFD pte markers */
+		if (pte_none(pte) || is_uffd_pte_marker(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte)) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 00122f42718c..cc4ce205bbec 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -178,6 +178,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	spinlock_t *ptl;
 	struct folio *folio = page_folio(page);
 	bool page_in_cache = folio_mapping(folio);
+	pte_t dst_ptep;
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	_dst_pte = pte_mkdirty(_dst_pte);
@@ -199,12 +200,15 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	}
 
 	ret = -EEXIST;
+
+	dst_ptep = ptep_get(dst_pte);
+
 	/*
-	 * We allow to overwrite a pte marker: consider when both MISSING|WP
-	 * registered, we firstly wr-protect a none pte which has no page cache
-	 * page backing it, then access the page.
+	 * We are allowed to overwrite a UFFD pte marker: consider when both
+	 * MISSING|WP registered, we firstly wr-protect a none pte which has no
+	 * page cache page backing it, then access the page.
 	 */
-	if (!pte_none_mostly(ptep_get(dst_pte)))
+	if (!pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
 		goto out_unlock;
 
 	if (page_in_cache) {
@@ -583,12 +587,15 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 		}
 
-		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE) &&
-		    !huge_pte_none_mostly(huge_ptep_get(dst_mm, dst_addr, dst_pte))) {
-			err = -EEXIST;
-			hugetlb_vma_unlock_read(dst_vma);
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			goto out_unlock;
+		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
+			const pte_t ptep = huge_ptep_get(dst_mm, dst_addr, dst_pte);
+
+			if (!huge_pte_none(ptep) && !is_uffd_pte_marker(ptep)) {
+				err = -EEXIST;
+				hugetlb_vma_unlock_read(dst_vma);
+				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+				goto out_unlock;
+			}
 		}
 
 		err = hugetlb_mfill_atomic_pte(dst_pte, dst_vma, dst_addr,
-- 
2.51.0


