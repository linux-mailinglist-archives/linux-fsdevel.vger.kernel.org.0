Return-Path: <linux-fsdevel+bounces-67769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E6C49911
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20F3E4F4552
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE0346FCA;
	Mon, 10 Nov 2025 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fo8OalgA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YSeTAazj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4313446BB;
	Mon, 10 Nov 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813468; cv=fail; b=ipLWIbGyCGl/6n0Pw8MN0/hbBfgZS88OruhNVcpFO6J3Hp9ec023RqdQoh66UbqSaziWWbczRLtxj2/t+jPrDh4XEzyUhWIHmOmLjPEJaCGFv65Cjoo9Z5E1Tbf40SHlt8DsC3THga6SgUe3aeupL6ghcIgXJq8vXvhyDhizaTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813468; c=relaxed/simple;
	bh=SOKdtiMkUX1wfXKL3vCMqT58JDUIorhnArOoC54ZFes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kzxiADtWsigEfWCaPDInsaODU6hToGbhhveaJ0xflvnPEPv2PXNFhlGzBqq8uTO4SlpHcbJYhSYn3opZZI9BaOOaexb3DayKyQZdRKnF9x+2f0FSS5j94bY8buaoC0vugtfyUPCcGooUMkvMh8uIg5IJue2Y5k+AmZ7K+Q4snZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fo8OalgA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YSeTAazj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAL8kOf009329;
	Mon, 10 Nov 2025 22:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OHeAr/1/JvOCPFjeSf6O3LGZncrh/u/f9P6dTRZkvgE=; b=
	fo8OalgArR7+giFNItfG3QK0SuB0xrxpRG+vXq/ttg/j7CvYyWCC2zWDkVSQFj9L
	CdMyNJnI6YeKitsjO+opaoPU2nAV8KGVKMwXB9JuMkwfjO6TKKQADmsMQ9nCEP1M
	Lwfs/xXFUxj/skE6klQyoW+NhlF0ns8sDIkOQZQKO3THTIgP9adyhSB4CJIwJUlh
	FYYtGvOfx62wxNupbQ/PufStAUT58x6NKtMAHTFKmqI8MljsXvn3h2VxfoO5PzL4
	eZFqSp4eX9JDKJSTtQYe48T4GOheu2PkFp48pgGLryRsQgmV/2/ounmtLQVuT6+M
	YsbMHFt+40mtazIQ0R1OjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abqpug5tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AALsCKb000873;
	Mon, 10 Nov 2025 22:22:15 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacs4p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QleGP/ScfbxlGdnC6G+wg6Ul5AkMEjO5saRGhphWHq3R1onCzsE9pSnQpwsBj3Nzvf6Lv08H73xYCOh5zEGF8sRFpu6IEYnqUDdauSd+S+NgSKAMXv43rDWrdggmiBsOWlRGtXVVaAYI4QE68u9AjwVPLIIuRpdL5A+2bEJo/6W+ZA1pPmp/gW6EwNxxpC7lf1FbM3KkFWU+EH0MHdH0uaSHAovG4/Y19wsV627nVfI8IM345gttTtzrY4+/0dzUvGLeKIoi7y4wUwOust5PuNgq6c6DjX9OQbG9lVRVEkYX9mYggo6MMLLTGnyYei6sCN0j8Z3Mx+HA/ONAjA6tLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHeAr/1/JvOCPFjeSf6O3LGZncrh/u/f9P6dTRZkvgE=;
 b=v6oV6QirklPlWoPhgbtqFZ+tfZ0qRPk2ITEsAt48tVgeO+OGn2uAPGo1C2ZkkJe8asU8XeZsOsC4lPNMhteBliqLrLi5WjZ7fr8mBSMZrAI0J1OpAbengysu/LlEW7QE6q5/9545aGUaV6yEb00YjyAeJZFyxENxYhdu6Z+wQJeUQvZh5OYrTl3yf0bDXRKs1jiceCNQR+CRtTE9w6oI47ODskZXitKSH009jHC9688me8p/5bNoAAMQiXVK1giGqzqjpC2wbAcQsijLmVpEVQjVVD2bUJG65bgzzDM82UqqxkBXqj5RcGNq6eg01dCUDlwMBxpupAwDG+GCe8siFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHeAr/1/JvOCPFjeSf6O3LGZncrh/u/f9P6dTRZkvgE=;
 b=YSeTAazjtj5T6rLrG6K/0t1LG7c4JwJuMHzIdka55EbEn2yMjys44QffxmdZRPxEYdpdNdCKc75M5nXiwq1DcXJUpJLyW/p0xomFFnj2Y1SiWwZqTtkbhRrehvZGp8NaeTh97VaWaBGs/SG5698QRFjrDku1OPCVzRqHmyOKPD4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:22:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:22:10 +0000
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
Subject: [PATCH v3 15/16] mm: eliminate further swapops predicates
Date: Mon, 10 Nov 2025 22:21:33 +0000
Message-ID: <956bc9c031604811c0070d2f4bf2f1373f230213.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: e3185bdc-bdc1-46c9-a811-08de20a79756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?100XBnxb3COr2qwyFsUaPCUgUDqUQYmiw3KqThTKVPTvqZmYEyIFOEuF5t9P?=
 =?us-ascii?Q?bEiRNhcfMiBKFGnxH587uuDISDjzDgY1Hupmd1vGt7ruUvyglpSM4ve6BeiG?=
 =?us-ascii?Q?DrqZRcqtQwdSUYNiQufnmOgqqZaYKjlEES/JV/Nrc0Ni1cftO+UdGMAB08eT?=
 =?us-ascii?Q?MWtvACtK1rXstXFGKYzQ1etYPBx20IzifZQ49qs1bQ6nUJXG5Y4Rq07aysBq?=
 =?us-ascii?Q?4sgxeLPgcPlYUUMDCVug0LniaDt5701HTqar0P3OjedbVu0LSbZFy28a3BWQ?=
 =?us-ascii?Q?dWvfPZs8ooGdP7OjFOvD1llrhzsbK/wo2vMcwqDRm2TU5UvYdTOHT/qwJ8Zh?=
 =?us-ascii?Q?mE73uMLqur0lblSXfvTlTci20/SIC1B5txrSc3W/7I7jKFNvs0kcdQ5IkR5h?=
 =?us-ascii?Q?EoLDvrBx1GC2FloQWwpqAfIRLZRIWIfxvnYgZgRUSGoEboYat+6x9pSVRovG?=
 =?us-ascii?Q?UVVMFtc8R0L/4gxoRgjInIvZx1K/aDdh7JAgZHVMKRJoLbLtgi/e4xOwfycc?=
 =?us-ascii?Q?I0uImybcZBioJU55efbSmRJKZ390addQZYfar//bYcjhkOqhswOLbbXMGBmo?=
 =?us-ascii?Q?Tz4+H3LcJoAwOtZ86/+8H8WlIZMmTXKvQSA7PAimdO+alRXRALbTWaI6xCwF?=
 =?us-ascii?Q?jt0o57pnkvD4e64Ca32QuaBNJSXtKyxsNQkas+sr87Myo954NcxxRVWjJpbT?=
 =?us-ascii?Q?+LnMjPAO62WPNWNu+ndri4a3rwtpraEOoyVRsBfMT+FJrscTYJU+AmdL6BL3?=
 =?us-ascii?Q?JjTEujioufqr7flwnr7tnr14hFMjQ6foE5a2MWwcpOEbuWUeuU77K/G9rp/W?=
 =?us-ascii?Q?KhRg09VWHesxikzZvBM2R4RKuWrJlsoieSc4DIyMdIMdsJJgfx+5L0/ehnl9?=
 =?us-ascii?Q?MgsDEtrl7sDTcSdQw1GwGUHPLYsUUH2AD5FfCcWWsRozHvXOvsyNbZi08K2M?=
 =?us-ascii?Q?4YNJxCbXP4EKJOpat9yXUzW7A9eM6OavTdjAmCCw2MzcXVzY47+XloWkuo+I?=
 =?us-ascii?Q?Wp1b1mrhESBw7WRlna0SsZMYNTcIV/MXfcbVQMW7hiAo/KwUn1LrKPx88/az?=
 =?us-ascii?Q?9KdV3WJL6HNkkoR2JknNAlXCzsirq7+UFa78WYXc3+XI4ui5sPCjz96Ypznw?=
 =?us-ascii?Q?Hd94+XLcxu8oPvNX6xcKBZiUZovV5ZCSVnNCEUND+WZtgLgJk+N20bz9bKvT?=
 =?us-ascii?Q?S7CFGep827+2yYWt42p/MYV4F9Zj2GLboY2fBg4hr6WK3a5YTsCuXwTcsK5h?=
 =?us-ascii?Q?kRGrhmY+BgacxVEX60CNE6BD8FmcEAG/UbolkeJ1fc9UdYFeSpuYArKzIR4R?=
 =?us-ascii?Q?MrNE5R7WxaeWy/6YeTkVg4C1CpvzKZeCpUBAN7YIDkYGz6ODXpN4JGnlsslc?=
 =?us-ascii?Q?PeMNeAMRLEUbcUQiWs7VEVOMfXVcW+UwUe8C7SJHeSdY7093k2Ki7edf/Hw+?=
 =?us-ascii?Q?jNAwn1xX0ilD0DMcp4JTtHii55yzt1a0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZWwngl24VxRXIZoW2qqVX2O822Mp+GqJ5YAUCL5ryz7b/vX7tn3tIrRf1dM9?=
 =?us-ascii?Q?xPD2wKV3DzoQdv4B4HS1X1dqDyyE4gGb36pVQ9n0tiMK+sQLA4QtYvBN1ZGg?=
 =?us-ascii?Q?i0halEwoISw8il4YtrWGRsbZWvRU9/JSPyyvqlMndFjBMkeS5VFKvPY9Fob/?=
 =?us-ascii?Q?nmufKgeROACJQuaHNvj6ZZsNIGmxwcWi1XSCvQ+xkdeCVQ1QDpQvtW8xDmFe?=
 =?us-ascii?Q?1aRwDeLjdcbaiou5c0t8Hnf91m/ZRwgYuD/XtxmPCO5HycopaquY/IbC8NUL?=
 =?us-ascii?Q?telwTH+cWg2ZEskitI9T00pq2r/LFh7KLvg1/HGUvDfFyYIM/UVGZpc2mZEr?=
 =?us-ascii?Q?ToL1d+zrcK/OVMc0l//bpSjwcio/WVaWhy3NsB8txtJwxitcj66rgd8bxWsH?=
 =?us-ascii?Q?Vu/iBliXGrAZw0wS9tFhUbkhOejFcfA+NQ3Fmg5s8WCoWnT/AMpjJRV9XKcQ?=
 =?us-ascii?Q?oP5ZAdkZBvWYCVjCJshtrHVIw2ZS5cGe8YvXPk9AcBmHKeK8qERXDWoT5W2R?=
 =?us-ascii?Q?2EhRHlWZMFWia4A7L/LUSPtwbCNFINlgfG/7geNCuJY+jE96CH3lk4izjWNZ?=
 =?us-ascii?Q?feeVw/ZXXhtJYcjQc7vnq78P5ZlfX119FHol8yR7LLo2vcz+uHdo0tAkHzG4?=
 =?us-ascii?Q?36T5H8QXBSeBpLcRI257t77yBeS9GU0IMzc1OtjuI+MI3QV+nGWSEC9nX68f?=
 =?us-ascii?Q?aQrVrHVMZ+hKdiMfBLrbH56LeOX4iyVyT0uyuNtT10fbtm3uPoknkkzi84kH?=
 =?us-ascii?Q?Pamqes2+Y/qqrNvNiTnETDWCrfeGPrprAkEb0lTyf2M8gGN8qDfE2FGSbROw?=
 =?us-ascii?Q?W2vm9tiw+4bUNIwFKSEIio1vJHWs5IrQ15JMtH/cq4QgPJ8mNSg394+LQnGv?=
 =?us-ascii?Q?xZKAVXhajolEUlBm0XIl+ewG73E4Gizvu/0JOPaJJMRkOIUMBbxFeCmV1wAS?=
 =?us-ascii?Q?bxHmHE0dJxza00pJvUXHCvzhzxvODPgdKhkbyi/xDgGTWAfMNXOsQ16DvcgN?=
 =?us-ascii?Q?jqfvTd2I4oqNLLzUkLaBV3tKG7L4jLSA8pSdW+v+91G+mJoed/ZIrTXLFLsE?=
 =?us-ascii?Q?Re1zykltFlG2BCYKX1VLYx50o7pnHxd58hG6UQm/Cjo6ywBEe5AJmdDcu+7g?=
 =?us-ascii?Q?/Qk3MNT9PNG/KJ5TFxYOl1b1SYliSp19b30oGlyvRt5ZJzOdxkr1SMI9MVFY?=
 =?us-ascii?Q?LyWOF4mlbVXwoZpupnXW+8vAyp5Y9tdm18SIfHVGiyQU21Vtmzldtw8psOAV?=
 =?us-ascii?Q?B+ZxXr4+arc7/w5MptY1lqKwH3zB4QwajbH2u8Rp2TcDgoS2+2xxQk3OdpP3?=
 =?us-ascii?Q?7w975IRK6j5xLhIIeAykV0qpnhTIBItJvu2fgvxh0cvMfJ6DnLotzbsf8WFf?=
 =?us-ascii?Q?vM3MBIEy5YgGNWbhsuGhBvdQlEWDqlvhNLTS/MWxbOZotlyMo6H+OhqAX9ua?=
 =?us-ascii?Q?NkusI1g2KhrKuL55D7Fbo+7l7biVyUYT9L2WhGV909V+53nkLIZVomE2YAUL?=
 =?us-ascii?Q?+YvIl3+Dx+o3WzxWia04Iy6g5Tm5mMEjRMFgVXssOKaI8ResCC+6NiCkge7o?=
 =?us-ascii?Q?+e/Y+zlV1fCyayLdYC+zv+PulnUz6rEEjYiNlZYBg8a/cI5XlJacb7hBLTPB?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rlwtzLa4it8zbi16vyzsXcviQsAugjm8rzOv5Uu5HSa7xIZCfXupfEbjGYLIVwdgsBotloaNhpIbuYsGSBLmYcAq5VMeroO0py0g62LMBxARNQQbJSxiT0EQY39OaPHEovISDRYaV2nAsZyjzdRdIYAGLCJSsSetwtomxNCukz+85L8GPN8xXuWVoMiHGcyCm0RHQ7dwmnriPaYHTO0rRoteDPVAE40sTbEB7S/sg9I79M71EmPAC6RXuCCV12/vc6+mofPXPVGyd/axf7qQiU5er29jeqNs559Py8VOwB/WDklASaVS9PzeH4+yXvbhJlKxotHfQTg2vu4XAG/dIOyPTUtBwYMRntDXr8meRFW0CH8DPWN+dMZxbMGpTSrkEgYb25xR/HCVTobnMsM8WsBHaRHSRuDBp6lsb3m/Lz7svEmQcYjE0QGX2sUKjimgPZ0aTNdapXz3Aj3VwNPsbbKO19X+Dl8KG0wBebBAK2RV9hT+1+bszxjQ54LpcGmNLor0KofAVms2v210vkjU6wDXHguB4DE3agRx5/Ph2MD0Jv1XSkuVk0NTI+yV8aKVPCg1ulNZj/4JFMZdX569igW/ufDjNa1+n/Uswh62BM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3185bdc-bdc1-46c9-a811-08de20a79756
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:22:10.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwgpAIP5UFfan02YOewxZrccqPz81mFW25ddch98VqUM4F+VUk1GvmXLL1G/WQ3BfNQ3dr1u0Oc9yNI/avR+JldRalazWkNyDHowHGUjpPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfX5krCvsOrQdyT
 p6WLJFoKWvscAcHAGZ+7/wYGJPlCidMilQxrVNga+E8Xwzfl8DCkuFxOQH7XqXE+Jl/33XxKi/e
 eMw//nk6njp22D2AQw3kcZIndlrrTl24F0/+DhSed1+iNqFPNCxlYNlvQKCv7hxD1kLenVEVZxk
 SgIEHXPbp4hN3TrzY/YFnVnZhOuDgGUJ3KUM5vTmLnaJpALKEEksMzAG40KYwhtYv/TQtcmKdQ+
 0K1r/QIO8GKONcYTlyT7tPZtnC3boPGZnlPOy1kg2xTdiwHoDxGsZy+S6e4ObEBE/nlcBBy4jqi
 U0CHXlN0N/U9FmCCaP7jYCd6KBR47w7vIarnNQDW58oFv/ljaWyNXYFLLR0U02W0q0iRmCowC06
 Mekje+f8iPIcURYnGz3KwMIwBcXe1htQ467kCr2YTzRtlPlhJN0=
X-Authority-Analysis: v=2.4 cv=H5rWAuYi c=1 sm=1 tr=0 ts=69126599 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=12TsxHtCQ5kFwp23Kd0A:9 cc=ntf awl=host:13634
X-Proofpoint-ORIG-GUID: n25A8vz2vEqTzeAjjkp9rrzYWGQRZrsj
X-Proofpoint-GUID: n25A8vz2vEqTzeAjjkp9rrzYWGQRZrsj

Having converted so much of the code base to software leaf entries, we can
mop up some remaining cases.

We replace is_pfn_swap_entry(), pfn_swap_entry_to_page(),
is_writable_device_private_entry(), is_device_exclusive_entry(),
is_migration_entry(), is_writable_migration_entry(),
is_readable_migration_entry(), swp_offset_pfn() and pfn_swap_entry_folio()
with softleaf equivalents.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      |  14 ++---
 include/linux/leafops.h |  25 +++++++--
 include/linux/swapops.h | 121 +---------------------------------------
 mm/debug_vm_pgtable.c   |  20 +++----
 mm/hmm.c                |   2 +-
 mm/hugetlb.c            |   2 +-
 mm/ksm.c                |   6 +-
 mm/memory-failure.c     |   6 +-
 mm/memory.c             |   3 +-
 mm/mempolicy.c          |   4 +-
 mm/migrate.c            |   6 +-
 mm/migrate_device.c     |  10 ++--
 mm/mprotect.c           |   8 +--
 mm/page_vma_mapped.c    |   8 +--
 mm/pagewalk.c           |   7 +--
 mm/rmap.c               |   9 ++-
 16 files changed, 75 insertions(+), 176 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3cdefa7546db..4deded872c46 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1940,13 +1940,13 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
 	} else {
-		swp_entry_t entry;
+		softleaf_t entry;
 
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		if (pte_swp_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-		entry = pte_to_swp_entry(pte);
+		entry = softleaf_from_pte(pte);
 		if (pm->show_pfn) {
 			pgoff_t offset;
 
@@ -1954,16 +1954,16 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			 * For PFN swap offsets, keeping the offset field
 			 * to be PFN only to be compatible with old smaps.
 			 */
-			if (is_pfn_swap_entry(entry))
-				offset = swp_offset_pfn(entry);
+			if (softleaf_has_pfn(entry))
+				offset = softleaf_to_pfn(entry);
 			else
 				offset = swp_offset(entry);
 			frame = swp_type(entry) |
 			    (offset << MAX_SWAPFILES_SHIFT);
 		}
 		flags |= PM_SWAP;
-		if (is_pfn_swap_entry(entry))
-			page = pfn_swap_entry_to_page(entry);
+		if (softleaf_has_pfn(entry))
+			page = softleaf_to_page(entry);
 		if (softleaf_is_uffd_wp_marker(entry))
 			flags |= PM_UFFD_WP;
 		if (softleaf_is_guard_marker(entry))
@@ -2032,7 +2032,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
 		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
-		page = pfn_swap_entry_to_page(entry);
+		page = softleaf_to_page(entry);
 	}
 
 	if (page) {
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index f5ea9b0385ff..d282fab866a1 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -355,7 +355,7 @@ static inline unsigned long softleaf_to_pfn(softleaf_t entry)
 	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
 
 	/* Temporary until swp_entry_t eliminated. */
-	return swp_offset_pfn(entry);
+	return swp_offset(entry) & SWP_PFN_MASK;
 }
 
 /**
@@ -366,10 +366,16 @@ static inline unsigned long softleaf_to_pfn(softleaf_t entry)
  */
 static inline struct page *softleaf_to_page(softleaf_t entry)
 {
+	struct page *page = pfn_to_page(softleaf_to_pfn(entry));
+
 	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding page is locked
+	 */
+	VM_WARN_ON_ONCE(softleaf_is_migration(entry) && !PageLocked(page));
 
-	/* Temporary until swp_entry_t eliminated. */
-	return pfn_swap_entry_to_page(entry);
+	return page;
 }
 
 /**
@@ -380,10 +386,17 @@ static inline struct page *softleaf_to_page(softleaf_t entry)
  */
 static inline struct folio *softleaf_to_folio(softleaf_t entry)
 {
-	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+	struct folio *folio = pfn_folio(softleaf_to_pfn(entry));
 
-	/* Temporary until swp_entry_t eliminated. */
-	return pfn_swap_entry_folio(entry);
+	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding folio is locked.
+	 */
+	VM_WARN_ON_ONCE(softleaf_is_migration(entry) &&
+			!folio_test_locked(folio));
+
+	return folio;
 }
 
 /**
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index c8e6f927da48..3d02b288c15e 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -28,7 +28,7 @@
 #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
 
 /*
- * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
+ * Definitions only for PFN swap entries (see leafeant_has_pfn()).  To
  * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
  * can use the extra bits to store other information besides PFN.
  */
@@ -66,8 +66,6 @@
 #define SWP_MIG_YOUNG			BIT(SWP_MIG_YOUNG_BIT)
 #define SWP_MIG_DIRTY			BIT(SWP_MIG_DIRTY_BIT)
 
-static inline bool is_pfn_swap_entry(swp_entry_t entry);
-
 /* Clear all flags but only keep swp_entry_t related information */
 static inline pte_t pte_swp_clear_flags(pte_t pte)
 {
@@ -109,17 +107,6 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-/*
- * This should only be called upon a pfn swap entry to get the PFN stored
- * in the swap entry.  Please refers to is_pfn_swap_entry() for definition
- * of pfn swap entry.
- */
-static inline unsigned long swp_offset_pfn(swp_entry_t entry)
-{
-	VM_BUG_ON(!is_pfn_swap_entry(entry));
-	return swp_offset(entry) & SWP_PFN_MASK;
-}
-
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
@@ -169,27 +156,11 @@ static inline swp_entry_t make_writable_device_private_entry(pgoff_t offset)
 	return swp_entry(SWP_DEVICE_WRITE, offset);
 }
 
-static inline bool is_device_private_entry(swp_entry_t entry)
-{
-	int type = swp_type(entry);
-	return type == SWP_DEVICE_READ || type == SWP_DEVICE_WRITE;
-}
-
-static inline bool is_writable_device_private_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_DEVICE_WRITE);
-}
-
 static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
 	return swp_entry(SWP_DEVICE_EXCLUSIVE, offset);
 }
 
-static inline bool is_device_exclusive_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_DEVICE_EXCLUSIVE;
-}
-
 #else /* CONFIG_DEVICE_PRIVATE */
 static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
 {
@@ -201,50 +172,14 @@ static inline swp_entry_t make_writable_device_private_entry(pgoff_t offset)
 	return swp_entry(0, 0);
 }
 
-static inline bool is_device_private_entry(swp_entry_t entry)
-{
-	return false;
-}
-
-static inline bool is_writable_device_private_entry(swp_entry_t entry)
-{
-	return false;
-}
-
 static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
 	return swp_entry(0, 0);
 }
 
-static inline bool is_device_exclusive_entry(swp_entry_t entry)
-{
-	return false;
-}
-
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 #ifdef CONFIG_MIGRATION
-static inline int is_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ ||
-			swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE ||
-			swp_type(entry) == SWP_MIGRATION_WRITE);
-}
-
-static inline int is_writable_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_WRITE);
-}
-
-static inline int is_readable_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ);
-}
-
-static inline int is_readable_exclusive_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE);
-}
 
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -310,23 +245,10 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
 	return swp_entry(0, 0);
 }
 
-static inline int is_migration_entry(swp_entry_t swp)
-{
-	return 0;
-}
-
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *pte) { }
-static inline int is_writable_migration_entry(swp_entry_t entry)
-{
-	return 0;
-}
-static inline int is_readable_migration_entry(swp_entry_t entry)
-{
-	return 0;
-}
 
 static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 {
@@ -410,47 +332,6 @@ static inline swp_entry_t make_guard_swp_entry(void)
 	return make_pte_marker_entry(PTE_MARKER_GUARD);
 }
 
-static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
-{
-	struct page *p = pfn_to_page(swp_offset_pfn(entry));
-
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding page is locked
-	 */
-	BUG_ON(is_migration_entry(entry) && !PageLocked(p));
-
-	return p;
-}
-
-static inline struct folio *pfn_swap_entry_folio(swp_entry_t entry)
-{
-	struct folio *folio = pfn_folio(swp_offset_pfn(entry));
-
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding folio is locked
-	 */
-	BUG_ON(is_migration_entry(entry) && !folio_test_locked(folio));
-
-	return folio;
-}
-
-/*
- * A pfn swap entry is a special type of swap entry that always has a pfn stored
- * in the swap offset. They can either be used to represent unaddressable device
- * memory, to restrict access to a page undergoing migration or to represent a
- * pfn which has been hwpoisoned and unmapped.
- */
-static inline bool is_pfn_swap_entry(swp_entry_t entry)
-{
-	/* Make sure the swp offset can always store the needed fields */
-	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
-
-	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
-}
-
 struct page_vma_mapped_walk;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 608d1011ce03..64db85a80558 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -844,7 +844,7 @@ static void __init pmd_softleaf_tests(struct pgtable_debug_args *args) { }
 static void __init swap_migration_tests(struct pgtable_debug_args *args)
 {
 	struct page *page;
-	swp_entry_t swp;
+	softleaf_t entry;
 
 	if (!IS_ENABLED(CONFIG_MIGRATION))
 		return;
@@ -867,17 +867,17 @@ static void __init swap_migration_tests(struct pgtable_debug_args *args)
 	 * be locked, otherwise it stumbles upon a BUG_ON().
 	 */
 	__SetPageLocked(page);
-	swp = make_writable_migration_entry(page_to_pfn(page));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(!is_writable_migration_entry(swp));
+	entry = make_writable_migration_entry(page_to_pfn(page));
+	WARN_ON(!softleaf_is_migration(entry));
+	WARN_ON(!softleaf_is_migration_write(entry));
 
-	swp = make_readable_migration_entry(swp_offset(swp));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(is_writable_migration_entry(swp));
+	entry = make_readable_migration_entry(swp_offset(entry));
+	WARN_ON(!softleaf_is_migration(entry));
+	WARN_ON(softleaf_is_migration_write(entry));
 
-	swp = make_readable_migration_entry(page_to_pfn(page));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(is_writable_migration_entry(swp));
+	entry = make_readable_migration_entry(page_to_pfn(page));
+	WARN_ON(!softleaf_is_migration(entry));
+	WARN_ON(softleaf_is_migration_write(entry));
 	__ClearPageLocked(page);
 }
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 0158f2d1e027..3912d92a2b9a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -270,7 +270,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			cpu_flags = HMM_PFN_VALID;
 			if (softleaf_is_device_private_write(entry))
 				cpu_flags |= HMM_PFN_WRITE;
-			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
+			new_pfn_flags = softleaf_to_pfn(entry) | cpu_flags;
 			goto out;
 		}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b702b161ab35..f7f18a3ea495 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5640,7 +5640,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else if (unlikely(softleaf_is_migration(softleaf))) {
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
-			if (!is_readable_migration_entry(softleaf) && cow) {
+			if (!softleaf_is_migration_read(softleaf) && cow) {
 				/*
 				 * COW mappings require pages in both
 				 * parent and child to be set to read.
diff --git a/mm/ksm.c b/mm/ksm.c
index 7cd19a6ce45f..b911df37f04e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -637,14 +637,14 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long en
 		if (pte_present(pte)) {
 			folio = vm_normal_folio(walk->vma, addr, pte);
 		} else if (!pte_none(pte)) {
-			swp_entry_t entry = pte_to_swp_entry(pte);
+			const softleaf_t entry = softleaf_from_pte(pte);
 
 			/*
 			 * As KSM pages remain KSM pages until freed, no need to wait
 			 * here for migration to end.
 			 */
-			if (is_migration_entry(entry))
-				folio = pfn_swap_entry_folio(entry);
+			if (softleaf_is_migration(entry))
+				folio = softleaf_to_folio(entry);
 		}
 		/* return 1 if the page is an normal ksm page or KSM-placed zero page */
 		found = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(pte);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index acc35c881547..6e79da3de221 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -691,10 +691,10 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 	if (pte_present(pte)) {
 		pfn = pte_pfn(pte);
 	} else {
-		swp_entry_t swp = pte_to_swp_entry(pte);
+		const softleaf_t entry = softleaf_from_pte(pte);
 
-		if (is_hwpoison_entry(swp))
-			pfn = swp_offset_pfn(swp);
+		if (softleaf_is_hwpoison(entry))
+			pfn = softleaf_to_pfn(entry);
 	}
 
 	if (!pfn || pfn != poisoned_pfn)
diff --git a/mm/memory.c b/mm/memory.c
index ad336cbf1d88..accd275cd651 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -902,7 +902,8 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 static int try_restore_exclusive_pte(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, pte_t orig_pte)
 {
-	struct page *page = pfn_swap_entry_to_page(pte_to_swp_entry(orig_pte));
+	const softleaf_t entry = softleaf_from_pte(orig_pte);
+	struct page *page = softleaf_to_page(entry);
 	struct folio *folio = page_folio(page);
 
 	if (folio_trylock(folio)) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index dee95d5ecfd4..acb9bf89f619 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -705,7 +705,9 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		if (pte_none(ptent))
 			continue;
 		if (!pte_present(ptent)) {
-			if (is_migration_entry(pte_to_swp_entry(ptent)))
+			const softleaf_t entry = softleaf_from_pte(ptent);
+
+			if (softleaf_is_migration(entry))
 				qp->nr_failed++;
 			continue;
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index 48f98a6c1ad2..182a5b7b2ead 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -483,7 +483,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	spinlock_t *ptl;
 	pte_t *ptep;
 	pte_t pte;
-	swp_entry_t entry;
+	softleaf_t entry;
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!ptep)
@@ -495,8 +495,8 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	if (pte_none(pte) || pte_present(pte))
 		goto out;
 
-	entry = pte_to_swp_entry(pte);
-	if (!is_migration_entry(entry))
+	entry = softleaf_from_pte(pte);
+	if (!softleaf_is_migration(entry))
 		goto out;
 
 	migration_entry_wait_on_locked(entry, ptl);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 880f26a316f8..c50abbd32f21 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -282,7 +282,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
-		swp_entry_t entry;
+		softleaf_t entry;
 		pte_t pte;
 
 		pte = ptep_get(ptep);
@@ -301,11 +301,11 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			 * page table entry. Other special swap entries are not
 			 * migratable, and we ignore regular swapped page.
 			 */
-			entry = pte_to_swp_entry(pte);
-			if (!is_device_private_entry(entry))
+			entry = softleaf_from_pte(pte);
+			if (!softleaf_is_device_private(entry))
 				goto next;
 
-			page = pfn_swap_entry_to_page(entry);
+			page = softleaf_to_page(entry);
 			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
@@ -331,7 +331,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
 					MIGRATE_PFN_MIGRATE;
-			if (is_writable_device_private_entry(entry))
+			if (softleaf_is_device_private_write(entry))
 				mpfn |= MIGRATE_PFN_WRITE;
 		} else {
 			pfn = pte_pfn(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab014ce17f9c..476a29cc89bf 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -317,11 +317,11 @@ static long change_pte_range(struct mmu_gather *tlb,
 				pages++;
 			}
 		} else  {
-			swp_entry_t entry = pte_to_swp_entry(oldpte);
+			softleaf_t entry = softleaf_from_pte(oldpte);
 			pte_t newpte;
 
-			if (is_writable_migration_entry(entry)) {
-				struct folio *folio = pfn_swap_entry_folio(entry);
+			if (softleaf_is_migration_write(entry)) {
+				const struct folio *folio = softleaf_to_folio(entry);
 
 				/*
 				 * A protection check is difficult so
@@ -335,7 +335,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_soft_dirty(oldpte))
 					newpte = pte_swp_mksoft_dirty(newpte);
-			} else if (is_writable_device_private_entry(entry)) {
+			} else if (softleaf_is_device_private_write(entry)) {
 				/*
 				 * We do not preserve soft-dirtiness. See
 				 * copy_nonpresent_pte() for explanation.
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 8137d2366722..b38a1d00c971 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -49,7 +49,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		if (is_migration)
 			return false;
 	} else if (!is_migration) {
-		swp_entry_t entry;
+		softleaf_t entry;
 
 		/*
 		 * Handle un-addressable ZONE_DEVICE memory.
@@ -67,9 +67,9 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		 * For more details on device private memory see HMM
 		 * (include/linux/hmm.h or mm/hmm.c).
 		 */
-		entry = pte_to_swp_entry(ptent);
-		if (!is_device_private_entry(entry) &&
-		    !is_device_exclusive_entry(entry))
+		entry = softleaf_from_pte(ptent);
+		if (!softleaf_is_device_private(entry) &&
+		    !softleaf_is_device_exclusive(entry))
 			return false;
 	}
 	spin_lock(*ptlp);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3067feb970d1..d6e29da60d09 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -1000,11 +1000,10 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 			goto found;
 		}
 	} else if (!pte_none(pte)) {
-		swp_entry_t entry = pte_to_swp_entry(pte);
+		const softleaf_t entry = softleaf_from_pte(pte);
 
-		if ((flags & FW_MIGRATION) &&
-		    is_migration_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
+		if ((flags & FW_MIGRATION) && softleaf_is_migration(entry)) {
+			page = softleaf_to_page(entry);
 			expose_page = false;
 			goto found;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 775710115a41..345466ad396b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1969,7 +1969,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			pfn = softleaf_to_pfn(pte_to_swp_entry(pteval));
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
@@ -2368,7 +2368,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			pfn = softleaf_to_pfn(pte_to_swp_entry(pteval));
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
@@ -2453,8 +2453,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				folio_mark_dirty(folio);
 			writable = pte_write(pteval);
 		} else {
+			const softleaf_t entry = softleaf_from_pte(pteval);
+
 			pte_clear(mm, address, pvmw.pte);
-			writable = is_writable_device_private_entry(pte_to_swp_entry(pteval));
+
+			writable = softleaf_is_device_private_write(entry);
 		}
 
 		VM_WARN_ON_FOLIO(writable && folio_test_anon(folio) &&
-- 
2.51.0


