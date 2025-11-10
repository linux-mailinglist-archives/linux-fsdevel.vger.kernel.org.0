Return-Path: <linux-fsdevel+bounces-67768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA5C498D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E15188B330
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17895346E40;
	Mon, 10 Nov 2025 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lKIB3P1N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IHNo8oJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB83446B3;
	Mon, 10 Nov 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813467; cv=fail; b=S4pLN9U0TYYPrIHPmHlKw2dyiQvlDWm7938FfZ7iJIwqWpHi/xIYUsEzt7pv76A8c9LoZwnpmtzy8B46Fc68qbRyKe5nJmjX0cZQ6P/T1AaXma32EXv72LG78xYAtnM5aMMaoWlnxBm7E+o/JPCshYcptbQGEFTba3siC9Uhkyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813467; c=relaxed/simple;
	bh=AZ3s0B+uhePQZXTS6i9X9ezX6E6ciUS6QFxCmlxX9io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFXwg67KorsbO42ZLFpuZ1eM4MWi+SfWUmRSuGcyDkOnvKbzAJP+dDl+x+mPT8GUeQMGRbDHG9KQMWfPJyH9Gt/62mZJh+NCeOFUHHa+yHuF6xj9VSkVBdrYz0KnW/kIkFwmZ3hVAmWqzxqTw/OyvIjQ0V+6M10/Jit631N71hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lKIB3P1N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IHNo8oJR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAMIJlW025921;
	Mon, 10 Nov 2025 22:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=; b=
	lKIB3P1NgLu2xw3DsELqn6NY/aTTRtqqm2OzAO0gH7H08cRyaX0uCeOsYS2JI8nN
	uNb2czrI5gbTmd4Fh248hX+qJZT03GRgr6An8BHAv54CPTpSHsC7WzKMuG0rWmgO
	uxtuJoL5JQd5WGL7FM4Lm1bz9iB1HY5GY9+o7TD9Ufy6tdw95LPWPXX5hUcmZrgu
	gWdv+JSP2N6NxcZzomD1gBfHTtfZEL37liQ0Dg6M6LHT/lSAE3qJyMPmkFdoHlb6
	uah+8WyB8EgmWjHkJa8XuKFtjxAqxjuywpdBHtWXoAsNU+CbKOxYVNpw+M/I0P3K
	tx1t9WlBaJW7sRTWSFhmuA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abr5vr2b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AALo2IC040096;
	Mon, 10 Nov 2025 22:21:58 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8rypg-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcvmxQz+GOpi/pnsG0ZKUrck1ATEMfp8LqpOW92I4mFZS3laQzVC3IHjjLFZHgZCW2tz3qbXvQP+sm3vjJH4o18gL2aBK38pPHb5CQTuGJX3nijQq95BdTDuwEss+tBZQ9TE4X9WeoKJiNxtjedYXwB7OQ36g73bSvuCTW9CxtTzKRj03Z6SXs2vRJKwJtbRA7YKIQZsTGA8oKgAAm1VXUdCgVN87nmWf19JmKpQVbUVNi3fcknKipnTNHgEB0f15hR0P+WOAbqT2uLvzNWRVZkJubIL71x/PLQMi+aLHB6L6TjFFZUsBwaIr0kglfWxtz5r/JoBDemY+vQudhq3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=;
 b=tFmKtEOrr0i41E/h3ud3S/fAgIY5HNQhiak20WmFgDf9zO4BIJReHgAuUwLNRwKvGOoJiA/jlyPBHQdxGFhJjoXIGIp6+U+S6El7F87xpMADG/NOGEb/Litqlns5cbSWR9NkIrwHyFmcVb3337WpsAT282KvgdvBxpEG552MvHaseUNeBrfKiDnQzdBs3Rfqhk/VS0hhSek61c3ZwdoCE4F3bzRUl9yfXBb5W7O1l6O2bPBunTTA9O6OctS5RipzJwi+646qoU9OAc8+V8NU86lVpFwo4TeHyHyo3iHw6r2G3rtQLrqYIwpbZAYPY6qrPADihelJ7PBG/1l045KPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=;
 b=IHNo8oJRSHFSgBTWEkk2tUqcDmp/xIc9GYfpWeKljdhhq+bfkl2HXucijS3Ftp3FJHuxcjX6aoHxobBl9UFfZp1m9uMU6Tw22X1SSUsM8yCxIkH1H+8OEQDgproTBXmtMdPcgcaT0LsgAHrw+LAk8seWDBXpCmyLXArW7rWV0sU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:21:54 +0000
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
Subject: [PATCH v3 08/16] mm/huge_memory: refactor copy_huge_pmd() non-present logic
Date: Mon, 10 Nov 2025 22:21:26 +0000
Message-ID: <6eaadc23ed512d370ede65561e34e96241c54b9d.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3555e853-ddb6-429c-e67c-08de20a78de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zjXli5ingarQUx/RCxDJ3Icq+PTM9nO6jH/I6Q8j+jYuKiP3YGfq9chr46LU?=
 =?us-ascii?Q?A7O4EHXgqa2TD8FDWxdwoQsLvGrS8zbyK2z1JDoXkfsexbBnF04srZG2Pc9+?=
 =?us-ascii?Q?7LBTQ4K5e0fvZPL/dlzmmqlhbwicTOrtM2dVwDSY+riCUk1/6WBQXTmS3GVH?=
 =?us-ascii?Q?3Dym2An4bbtjM8O/QablGqDpqKVqUTzSsBJYMKxUxVyrCj8moVkZiAH/U6FL?=
 =?us-ascii?Q?y6x3fljTVciJfvXIp03r/a3NRh8hXDWmzHQFKDq7L+xzxSMRkFT9B6sgl5T8?=
 =?us-ascii?Q?ayuM8SbcWy3/a78PVp0r0i9ugqNkY4a7lJzh/4/345ccxX8Dbe41STGz8jKH?=
 =?us-ascii?Q?4JXG/S+Hkw3M7jL7HzHXa1gkNWtbiivMuTiYEoyfd1fF16zCzZQBwrVQadB1?=
 =?us-ascii?Q?fsN702IzuRedT0GkInhBZIFnfnW9zAncKLwg955Z9PbMcDl04Q0UGT+ApocU?=
 =?us-ascii?Q?jwibyGKBWveBdReCbSrwDGEUwmFrV0xgk+DiNUEQ/XBbvZocLE0HJYXYyuDw?=
 =?us-ascii?Q?eSLoIiEXUir9wxe/NrEHyDmV1X4cbOmUMsLzxx0cc8nZxOj2ctMoHFMXrVAL?=
 =?us-ascii?Q?Y7aRReXyVGmvC5txOfUxFoohm1WCFhMhHiNCtniSpHUAcFfiNHRHXjoPR4Og?=
 =?us-ascii?Q?Hq4Gq44KW3AGg3l59bgGqYRcTwG4aQ8vUkYQRe4OlY1PQLYjhl4euXKk4RVN?=
 =?us-ascii?Q?e+qge3zvGp6uJbAnB0Xvk8l/zB3vskdH3veStYvwjIsejtUo26FS+c2ogI2V?=
 =?us-ascii?Q?fepewA/CdF3rxAeQMS0vKq7xuEJSk+qdKJZrhcFrv6ljPe9jBPcr2ltVQRSl?=
 =?us-ascii?Q?wz10NYDXaIP9mxZmccR3KF7ofj1HD5Q6cDJ0PcjrOpvehpyxEb1mWbTn3OOX?=
 =?us-ascii?Q?U2VhxbqdLubAz64fKPk/vttmMzl97uRNF7NLM8Z19fGWCMPqkkdHHFksNnFl?=
 =?us-ascii?Q?4p4QNsI5DPO2w+UCrb1jEM6fs3zFRgt9F+FDuHCInbZ1iD2977TYqvlQ2tAZ?=
 =?us-ascii?Q?udA+FKP1d4dfVTOX+HLDRzIjdF7Vu6S6j2Zyyu4cdc7pKp8HB1QIXIkJRgmu?=
 =?us-ascii?Q?OPpdUz8Wmojr3QGW5EjqS6PtGBN/eLNApTdqmBWTjlns/rW8QJcnp/FNSujo?=
 =?us-ascii?Q?ooKAmIGxOlmpOByIvvPf2KRQO64iCkFgQZ3sVYh1VwNvyOd2CSqARyQG+IrJ?=
 =?us-ascii?Q?yN5L2/0w/e3g3WjUs4nSqzGqtvLBreYgazX802ZYbFAOZH0YuAnSPzTFj8gc?=
 =?us-ascii?Q?+YeFb6EYPKmsKXTy2Cqzc+jZDa8ovG8NZSwW7eni6viXdwwvzdDXn1g1p6UA?=
 =?us-ascii?Q?ffhrmt+FESsehoT8NPyFhagD6W4ettgg9NnNZrp+TKZnojqm7ytP3qT8dbu4?=
 =?us-ascii?Q?FmAekgfkXnfkZyH78DTxx5yM7sPm+hkw1v/cvyvseXFzjQjZOcEECiiiXlfC?=
 =?us-ascii?Q?OVTNp9W2pkAaiMI/KRJ6t2kWXyUtKam9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YNbBrA+rVGacWyh81xEsgkoduswr/j7D9WJLD0Ktvd0xWmuBZ6erim3gNWNg?=
 =?us-ascii?Q?MDb6t0LKC5KrZjJCDG2ZBasXGpdZuYwlMhDzI9sZOXk2wLVirez/O7B55E/b?=
 =?us-ascii?Q?2BoRc5i4OCYsydOn4Dqc62iy9IDzTZOXQuQUgzy7YtGjZc2zB8aG9Jpc7WBw?=
 =?us-ascii?Q?MnTR1nIKUtVx7M0LBUtGIEha2kSMePddeii6QftPFyxnoB8z2tuFRRS87GHy?=
 =?us-ascii?Q?SJTkjvob2NZChg8kcc+9RoPZlVTWxDEXdPtnoMpJPl3K+r09bgEI0hThMOYG?=
 =?us-ascii?Q?+R1duUMfIEYNNu8yKXJ21+MMZ9Y3o/r73yTNvFMVgW6ORvWdA6k3YpUnWxM0?=
 =?us-ascii?Q?PVOxlSbH+KT/Qy1TJzSo0PivjioMIwYVeUAIVWw3BU82fV3btlTJBSZztlGm?=
 =?us-ascii?Q?ZqBS7hNDXLU4aGAEeEbgb3xffdw0lYnLani2i5U0acpnvTD7Y6SRGkjVcfgH?=
 =?us-ascii?Q?1OQIyNTJKl3Pt9HhCwIlv4uG9zrsA2vdrm+ftaaAvSyo7dhxK4LzSnUQHoSy?=
 =?us-ascii?Q?Fo5hrZnCqttBb7voAma3Ee6gwBlNa1ktFDbuKz/JpnlPStqp0sSMWF1Jf/uJ?=
 =?us-ascii?Q?Rtn9qqIoO9tz4P3jfaSu86FLQFNQ019+wn2Ch9lW23xO8WZ5GExcbF1E9xi0?=
 =?us-ascii?Q?UClTcflkbVzj1rpnTGY/hhn8XqVxrJDHmSVeQpmKbH3r+EN1GKVdsVuf7JUB?=
 =?us-ascii?Q?IYbS6RGP2C+rlWsC3umOq1HHAsNM+ykyIe8Ic88EeziIfcqzJj9z6MMlBPB/?=
 =?us-ascii?Q?sTdtzr4pKH3Pz2cMuJEXiwagDzbl08YmP7lmscbUg8UqZG+m3sVOzTXDWwQp?=
 =?us-ascii?Q?yZJv4wHS1iVWPJbD0fGx3D5k+B3b0zxOYDJB/Rcy1Dd078iL2dWEjHkBusNg?=
 =?us-ascii?Q?HQgpZT6xoEXJz8yJqK2N/z3LKQekx+2VSMDrMHnLrNf9g8wSsZXaGhLkUorT?=
 =?us-ascii?Q?G6oyFszka8NdRXoBcFVX6A/qIQTZffyKPXAALV96fPipupBPHEZXNkxfXqBz?=
 =?us-ascii?Q?i0aZMPrM7yvvDJHygwQ5wDHpd+9GaNz1pEVf66jsl+oHo7LNgXyzR6Rdc2J2?=
 =?us-ascii?Q?6F8YYuFuJfzTfG4iZWG9KZiULhPOJFbEHLtVvDfpXstliVxIQZ+Kp3ZUyKHM?=
 =?us-ascii?Q?SCAQNZydZZYPKO8xgp12WveAV0qd/ICekPZMnJSFNv7TnNEJ6It4zbH0s3YE?=
 =?us-ascii?Q?CsqaplGjkZLmhE0SGUAoBIhADQLUN15d5MjXkD0HohrsPeuSoMVNI4iCVgC+?=
 =?us-ascii?Q?RNn9kEaQSoSim0uVzT2FaOv5tng2uHmYip3zHDgffOnQkPf+gT3iDt/cYiq0?=
 =?us-ascii?Q?poN1qkz1ELy7JChKC/99pX1OaowquirmQyCv+c87I5RkionlQkrCoHPUaRhn?=
 =?us-ascii?Q?9eHBEjzu5qgHvd5Mb+V+Js2BOtQF9ocpeTo4gYuJuw46htfFoE+9LmRXzIBE?=
 =?us-ascii?Q?YSMg4MspI8jX8MDtEWP1iyAOp1ao1t3FXg7rT+WqttZ0rYHYFg2K7uzClple?=
 =?us-ascii?Q?ERPI08FF0aT1u8HsZZSk8SlUUVS3NtpUvg/aECNNdrnotXKV4IWelNSY2nh9?=
 =?us-ascii?Q?lDDlhd4vXEpPpE2jsSCaSF3C6o9Ca3NKzbk4n7nPDy51xznm+QaA5ro9Rm5G?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jz66qQejytzq11cNl8Ks1WjNIuW3Bg4FNP7bzMinpaOBz3fXvFQaWhrRgA6bcuVyekc64bTrzqc3aTchiL2YCk/m513yFz/GucbsBB2QbDUvwItKhLCDOzgdsTy3LwNxecFtBr3TSWN0gnhel9Ni6/cjX2bNRG+UJn0gd+q9TOu0xcmFCpUcVNaSpGd9BpEEcoIcKfkoU4t/t//SgeQYuhWWpceZ4Bsn/tsFPw5LKqOFcpGfh6Cojd17wK8g3JrWUe2lMyBiAZ44PstLKOz8VRFnVbZe0idp63w6yXBXERUb0tXigih73VfQKcJCxgcWkjvdtLlRi1yvDWqSooPTHyNlDUV5s5xoYJe3/1/HEgehxeztmJ7UTAjE1Wx+z8pdF05rotVejJtvtegq548WwzuIbcmDCNqVMntEEHFE/GoUq6yeWcioOb0NLyEleCYMArSCNoPZF1C+NKwLBazDX9ZQZRNpDQWaZlFrtnmBKYSVA/A17YzblyVjEUXeuCNAGJzckeNBkwE1VZPPo7wGD++ySBE/FgLMbr0B7x/JFgJBpCno0k0IwCJdVivz6b+p5owVFMlPl4U3WzHWwPknCf+gWFdhanVfUbjM75FdUOE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3555e853-ddb6-429c-e67c-08de20a78de5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:54.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUSPxbgSsoMdbPzxtsWpJfHWiEKPPcOqg6RMn8WGWmX3Kte0Kr6SYUOiqySeRo6/OIJpmxpHQpHa6xw4SLBiLB2rri+Md0Vj/9XDGikTonA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-GUID: hlUy9_HQyJtD8Fw90kSVH5r59-9SCpJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4NCBTYWx0ZWRfXxojIbNOOp7yW
 3NfYLwQL+CY8QXGKeplVwn4TR/4hzYzilUeKU7oaihwkyBbmPFmmH8wntRL0pTHC99Sq9HnhQUP
 ipPIBn7RXQQ8K5b3PpBqnvae8N92tzA0Jr/zuLyvxlt7BU998AUdVrQnGJVRt4qkrfY3/Q+Fm7y
 jbMJ7H+sgJoRahHMVqEZBTCo5I40RBPJGptj7ZcTRzoLGeF7KHNx4I81FSDtkLf/q9CeIJecBLL
 z127iv1V5QyF6Vtwtdz4ZhHJwU2FwQgcdjiXdcXktswIGXVzz5fnkq8s0qJXagaQFLBGXNtwQgz
 b1KBviYm2ILp+i4vLwpegHkdvj/Pf4Qi/tIcOuw7AzT21KhpXrI6A+DLfU+45wfL42L+ZddWV5q
 +k4Ll2k83BEuTncBSGpRHZZ60NFpUw==
X-Proofpoint-ORIG-GUID: hlUy9_HQyJtD8Fw90kSVH5r59-9SCpJH
X-Authority-Analysis: v=2.4 cv=YN+SCBGx c=1 sm=1 tr=0 ts=69126586 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9UmCEYkwnbpDqGD1g-YA:9

Right now we are inconsistent in our use of thp_migration_supported():

static inline bool thp_migration_supported(void)
{
	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
}

And simply having arbitrary and ugly #ifdef
CONFIG_ARCH_ENABLE_THP_MIGRATION blocks in code.

This is exhibited in copy_huge_pmd(), which inserts a large #ifdef
CONFIG_ARCH_ENABLE_THP_MIGRATION block and an if-branch which is difficult
to follow

It's difficult to follow the logic of such a large function and the
non-present PMD logic is clearly separate as it sits in a giant if-branch.

Therefore this patch both separates out the logic and utilises
thp_migration_supported().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 109 +++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2e5196a68f14..31116d69e289 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1774,6 +1774,62 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
+static void copy_huge_non_present_pmd(
+		struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		pmd_t pmd, pgtable_t pgtable)
+{
+	swp_entry_t entry = pmd_to_swp_entry(pmd);
+	struct folio *src_folio;
+
+	VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
+
+	if (is_writable_migration_entry(entry) ||
+	    is_readable_exclusive_migration_entry(entry)) {
+		entry = make_readable_migration_entry(swp_offset(entry));
+		pmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_soft_dirty(*src_pmd))
+			pmd = pmd_swp_mksoft_dirty(pmd);
+		if (pmd_swp_uffd_wp(*src_pmd))
+			pmd = pmd_swp_mkuffd_wp(pmd);
+		set_pmd_at(src_mm, addr, src_pmd, pmd);
+	} else if (is_device_private_entry(entry)) {
+		/*
+		 * For device private entries, since there are no
+		 * read exclusive entries, writable = !readable
+		 */
+		if (is_writable_device_private_entry(entry)) {
+			entry = make_readable_device_private_entry(swp_offset(entry));
+			pmd = swp_entry_to_pmd(entry);
+
+			if (pmd_swp_soft_dirty(*src_pmd))
+				pmd = pmd_swp_mksoft_dirty(pmd);
+			if (pmd_swp_uffd_wp(*src_pmd))
+				pmd = pmd_swp_mkuffd_wp(pmd);
+			set_pmd_at(src_mm, addr, src_pmd, pmd);
+		}
+
+		src_folio = pfn_swap_entry_folio(entry);
+		VM_WARN_ON(!folio_test_large(src_folio));
+
+		folio_get(src_folio);
+		/*
+		 * folio_try_dup_anon_rmap_pmd does not fail for
+		 * device private entries.
+		 */
+		folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
+					    dst_vma, src_vma);
+	}
+
+	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	mm_inc_nr_ptes(dst_mm);
+	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	if (!userfaultfd_wp(dst_vma))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+}
+
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
@@ -1819,59 +1875,12 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-	if (unlikely(is_swap_pmd(pmd))) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
-
-		VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
-
-		if (is_writable_migration_entry(entry) ||
-		    is_readable_exclusive_migration_entry(entry)) {
-			entry = make_readable_migration_entry(swp_offset(entry));
-			pmd = swp_entry_to_pmd(entry);
-			if (pmd_swp_soft_dirty(*src_pmd))
-				pmd = pmd_swp_mksoft_dirty(pmd);
-			if (pmd_swp_uffd_wp(*src_pmd))
-				pmd = pmd_swp_mkuffd_wp(pmd);
-			set_pmd_at(src_mm, addr, src_pmd, pmd);
-		} else if (is_device_private_entry(entry)) {
-			/*
-			 * For device private entries, since there are no
-			 * read exclusive entries, writable = !readable
-			 */
-			if (is_writable_device_private_entry(entry)) {
-				entry = make_readable_device_private_entry(swp_offset(entry));
-				pmd = swp_entry_to_pmd(entry);
-
-				if (pmd_swp_soft_dirty(*src_pmd))
-					pmd = pmd_swp_mksoft_dirty(pmd);
-				if (pmd_swp_uffd_wp(*src_pmd))
-					pmd = pmd_swp_mkuffd_wp(pmd);
-				set_pmd_at(src_mm, addr, src_pmd, pmd);
-			}
-
-			src_folio = pfn_swap_entry_folio(entry);
-			VM_WARN_ON(!folio_test_large(src_folio));
-
-			folio_get(src_folio);
-			/*
-			 * folio_try_dup_anon_rmap_pmd does not fail for
-			 * device private entries.
-			 */
-			folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
-							dst_vma, src_vma);
-		}
-
-		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-		mm_inc_nr_ptes(dst_mm);
-		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
-		if (!userfaultfd_wp(dst_vma))
-			pmd = pmd_swp_clear_uffd_wp(pmd);
-		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+	if (unlikely(thp_migration_supported() && is_swap_pmd(pmd))) {
+		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
+					  dst_vma, src_vma, pmd, pgtable);
 		ret = 0;
 		goto out_unlock;
 	}
-#endif
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
 		pte_free(dst_mm, pgtable);
-- 
2.51.0


