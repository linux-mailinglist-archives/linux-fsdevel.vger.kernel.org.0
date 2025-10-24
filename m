Return-Path: <linux-fsdevel+bounces-65410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7DC04CE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E005C34D67C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF82EF664;
	Fri, 24 Oct 2025 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5TQe7ur";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w9/APZfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9CC2EBB9A;
	Fri, 24 Oct 2025 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291809; cv=fail; b=l1gbVF3bLvtaerM/S5qNN5OHOcZocVb/M8jQq9tSkQQ2iHAMxQelZLRXfhz3Soli+VvjQU98jbD4UrSRjmaJl7yyWMtxGckXpmg/zpBdWODH6Hv3dw0QbwD+BwVZE+WxGHJLwTJt/bd3/bQtZnyoQ/g5d0T6eASRWJhTJ8GgFno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291809; c=relaxed/simple;
	bh=awuuImzGWz4genhH2YCEzznPbuX+8sPVS+TkCXcgVsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwRp+uG+2fhDi+S+c3uYEQJzY+oiUFTZIxGj7ojrfQkauOxVl9Wk6/UkQiKumRCtkj2X0/JiYMgS6HIXa1ZjMUBasMYvdPggcxyfTtQ9hGadYGDjQQHS//sUefy/QSa/O3YrmVncMkN6NPQSZhyH6rOmsYFfvB2n/LYPYGRDLfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c5TQe7ur; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w9/APZfv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NRsA005591;
	Fri, 24 Oct 2025 07:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=chdedve0egs56Eo6kFi0W9zLUw/nGNSXZ61q89MitpM=; b=
	c5TQe7urvCFituGipkmvR+rSTFieDPUaPsH3JzMkVR+Jfz+3FSg0ZnBHeEFQqLec
	mIy6MYkEIU3rX+8XMi3o0FwuFt+emuJ3InOFHsQG2wsNjO5slG/zT6LiBw7vTmLj
	5QMClqa0iY1Cjug2hBupmZffUAFKczoqWmhv5lSHh0eBgfETSGxXAQFDlp2jEy3o
	6YHDduOJkRm+0V+8WdRgpleVpdi1tXw6NIXeL4KpvVDTevgx8Pv5bJsO4SNviWbL
	n55iEZHhyzlib8LndqQqNKt020if8F05QIVMIPUa7SqlsyaJ4A1stmZ9N+PCC+f6
	OF6I7M+/uGSdZ4WzkxddPw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv5wm52w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6Y0hF000864;
	Fri, 24 Oct 2025 07:41:49 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfj872-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3lTjgdkzhvAcfcqfH/wMGl+W3Mb1gHjjoTyA+qevacaD1tHEqzlUjwuCwFpS8F5fnF1f+oiJmyyn19mWn4hkRDkzQkmYho1u/lOkbQC/QgtzTtli9FqnxiCzxNoh+flUp/V5QYJl9xhuiJSKSjYC6jiIADH661ufqbaDsllb2QJZbSOeVYwxmw6xcDyVWT1UpAsaBn4Sl36ew6JYcNhy3AEQtjrUj/OgB23I66/4MVhuBhgdiytkdIH4zix1D3VDhA1w+smP4N+sW3rQ/ol0bqWsTznR+VM8/Ro0XXqxNOuC6Mjv5hfvMf8qw9MKm1RqF7BEjddCgjriXAVIYIWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chdedve0egs56Eo6kFi0W9zLUw/nGNSXZ61q89MitpM=;
 b=jlIBnI9sFF0PlJMvvCP3TikSVQfVhsnF5rOoGSU7934IlOiOY7lBOtCR6xZfCXJAyV7OBbAP3f1P2V8EBsBpKVCRCKfUg1PbBW178IlbCIoBeedqO86JkBBCgeldTjA5cbmRWwbnY2Vlp2CdFdh0bCWjIDIgt76Vedk8FhyrnwVn1DPJkmGvuDklKbDmAknm7z0TlSR1wPsKOQ37/+T0VDEsHfanRDwgfyd93gRQSw2XhHWpA9a3GG+E7LOo6AdTVkTA557XhaXI33I/HUyvQqde1K+Sjz9+p0SrY4uj5ErqJh+ng45mm+mqsdmnXgtJkfa9ufi49BRT0HPiZ767QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chdedve0egs56Eo6kFi0W9zLUw/nGNSXZ61q89MitpM=;
 b=w9/APZfvE+BkRBpykWz7BOOM45FAPnnw5GSDiHS1LfXnFWTawfZGaJzTiOvjkPEp4ixKL419tJUWilYPFrNQHLikJWjLE94obG/ga1u/Etw+S9nP2ezv543susrHSRYMVGE3k65uJ0VKmoOTJkSlGi2Cgjf1/axdhlbxET8cJzQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:41:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:41:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 02/12] mm: avoid unnecessary uses of is_swap_pte()
Date: Fri, 24 Oct 2025 08:41:18 +0100
Message-ID: <f95f7dc3201d62cdbe56ea397201974f5a586bb4.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccd4d31-abb8-40b9-0a97-08de12d0c876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AMV6Hz6n93TrsXxG5nHaqLlFXn3jHhJP438zQrjQei+wcXMY2iBO6bMRXtrB?=
 =?us-ascii?Q?ZH6WHJUvXUVz5V4lAKuyhaK41KHh52E9X5gdnxHOZrY44LXlPCcc2PKKQFZr?=
 =?us-ascii?Q?zV8tS3VjAE6JYR/F4Gi3mpRcuQQ4EpqNJ3GIfuYGZqQLvOXNjUktfNdyLDHl?=
 =?us-ascii?Q?gfHMx9BYzwwaeGNt35/mlwu4DD7CCoQjT61g51NLwG+A0ZGyXWuFF35VO2Ab?=
 =?us-ascii?Q?vzUfMYAn2PqkCHU/XuZayR51l3mNSh1kOSTm+WS/IdJ7ToFkVw35nXMkbQzA?=
 =?us-ascii?Q?1ilOYkN47rJv3/OOMRb2gb60lrEdTaEeqZiLH5TqDmEpLmxXuYrdvKOhNrjF?=
 =?us-ascii?Q?qZsUFxSHHtOs/J8Ojo/lJhOV99dMgY8MDQ7s7uEx/7mgoGEfkFTofD1msk1s?=
 =?us-ascii?Q?lSZZ4nwa1pi1POYP8qqDfzXcN69QgqOu0gQzo+7+F/T1cs6fM755XeiECVSA?=
 =?us-ascii?Q?kfcASVJDKWfncZHGvh5KXH/bPqtLUxZt9cfp3iP9gAE3hcXqqhRfX/+5Nfwq?=
 =?us-ascii?Q?H1hhfgxC0rOs71lghY7yCIpw7V9JPOVRrhiPwZ6/0X6HDzi0xvA3OKgrJmIs?=
 =?us-ascii?Q?i9P8E0rIWdPCYcEe+eYGteK/rd63XiUF/hx26DZio2NIZ6Und8IIxlYDVc11?=
 =?us-ascii?Q?xkEDfwYhRYUVZDphzF+pbpQz26qO9+jxrXqmfZzgqT76NaNcAad8DfCmi/tC?=
 =?us-ascii?Q?X0ZsY71CgbCk2FC0HNO2zKe8HEtjSbywSeqnuexj1Ycfb67efoh1ubvoaITu?=
 =?us-ascii?Q?K8rMK/dtbf+SBe4297+JNnV09c58jYtlHkPE0ERk3LCIg8D54tAEoY5zdBAS?=
 =?us-ascii?Q?r23TdEY8G2qOZTU+uPRr6uJo6sFRkMkXPB5TpRMxISunNkGIt7zxgtj+KiJz?=
 =?us-ascii?Q?pTasclZdfqZM3+CWy7ccQFWQThrVKGV2DvdjJ1bbEPjWfqKQ49y8iCN5Yzwf?=
 =?us-ascii?Q?KJ7crq4d/5ueRxggUdKq1A5HknzFRHpILzzv51SE2XmqhvMGclJL+IsJvXBX?=
 =?us-ascii?Q?GdnxTU7qYq0/nUp5diJoBZwaRhOQDzpfVc0Nz6adZ4kFI7oUag22+DQas5xs?=
 =?us-ascii?Q?t5QhaVuBJNUiX0e/lAVjcLMBh46QCN5UC6JGv0TvVh/ZY9Jdh2eh4D0PeKNq?=
 =?us-ascii?Q?7oTFgdqz5P46bi/9fDRMKUX+cR96XDKtUfxNW0y+EgeNlhFl8EYFJWotRmnm?=
 =?us-ascii?Q?DjcuNdPprb8LHApe/xhSBb4bjSqqvFJg+tlj7Wfz4r/QVmVHva525U8ib6mF?=
 =?us-ascii?Q?oI0iCwkYQeCa9n8s5C0o1nNuzZ1oc0X8Fo9dhH5jWULILyN7QXRhZnVtqEoJ?=
 =?us-ascii?Q?nwXigZTDZzZ2HU5b5J/5jTNtV1VJ8jS6NMGSdnkhG7vwFPbILZkJqT3Sjtj+?=
 =?us-ascii?Q?4cCRuLg7JmZeUyHXYHj/1N3NpUj1h4N4TOBDFpjRB7YHTojfvdRafRHLpaeR?=
 =?us-ascii?Q?EpGi+8gIftA25Uf3SqetCj/EjmtLX3ZC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jS6EUiwxqXEoFopTv/mIWi/spSEbWkH35u0QRgtozqd8t3s7qK9WiZ7OndoM?=
 =?us-ascii?Q?pT1s+lALIiTzZ/nbqBr0E45AYm3QYM8PjzYd+3oJLRgnAKu2bdsewAY711yA?=
 =?us-ascii?Q?SarrMk8ok5cs0bACB6ob7IeX3Yc3Zz0eG/ydgoQnN3X5wphJx64aO/6pJjoA?=
 =?us-ascii?Q?X1oM9w9dcbHJzAad577yDNlsXNd6y4SU0+Opi6096P658EKrrsgma4KQRQrO?=
 =?us-ascii?Q?BsamUBozHav/WJGW/Zm+79l4VCtuDOMWTkvVUh1XllQ4V+F9/gUQgB5JwI1K?=
 =?us-ascii?Q?1vEawHMzSX+8036BLlMkdo2vOWQSwyXeE/PEF7CcsyvirYG0gLZW5Kj86OdG?=
 =?us-ascii?Q?Q8uT8DYJNW++TOamWMd3ILyy4dZ2jrOLrkkbU/w0jseyMvyA/qptAfv9XHVC?=
 =?us-ascii?Q?gqokBxBh5/W6auz76ak3KGjwBxU1A3q57CacfBRCCG1LWIuUwFASd97gIBjj?=
 =?us-ascii?Q?rkYT/fZjfs5z/rEY23FkJkZq0jZ12J5bDlh4+Xk1rY1FV+AKxN5wkgBf9eDO?=
 =?us-ascii?Q?mUA79mLrbvuIw2ajij+8Myl8SannmdJ7edHcVF/5X0VOvrg6baDz3PLPBVMH?=
 =?us-ascii?Q?jVRxY62KSkr0h93B2k4Zx4s+JCiqAfNwzx2TmA9BCjX05X7Ewku3/gmN0T97?=
 =?us-ascii?Q?u0Z3rjbQZQtUn22cdGARV9TW/JLHGIx6NFZX/RmgFw++Loc/uP2/RWbFxbIg?=
 =?us-ascii?Q?xlKfU3gV/pOacu/3c1NZ+mlPA7Az4ro7grt8wq4bz2lXcbSk8vZRKcWShBm0?=
 =?us-ascii?Q?mrdblMTR53/P4kHJJkJoqz+VQmh5MszVVnoK0xC6BicjzpzjtyqQ/s7edVLP?=
 =?us-ascii?Q?gBGfU1lRbd39J+wEXlC7Uek3HO5RLUQhDLJDZXlehT6hEDy8JZyXxVeBO5iK?=
 =?us-ascii?Q?6sfbsEOY1D221bie646whQLB9tfHGpimzShLPB3Plvknm5/u3RKWb1toVikp?=
 =?us-ascii?Q?Zbektsb76qth9kMqv03fFmXlYLB7aHL4O1rPagq3ABCTizLiQqajP4lYqXKa?=
 =?us-ascii?Q?gbWWR1GdJlhS2ftnF1gBanrvtc93N6xn44SOcb7HDV//5xFlWOjYkI4n3BzO?=
 =?us-ascii?Q?dEF/tflt6xiZqzgGSw66jDE7jzzrvyUg6Hi3OdOEAtReGUeuzKJz9fUQ2B+v?=
 =?us-ascii?Q?8EGVCthMYe1kZ2lJ7CK+XlJwNEYDp42yPLQNLwxyEeHK8Ifk8yxNbbzcyl4V?=
 =?us-ascii?Q?pYKJFF3UhFXcZfmzHkgEhFF46cZBDNSmf+jaazqdKhGMqH+WcbTxs5YlgRLw?=
 =?us-ascii?Q?f/FxQrtrRK/aLxRIaO/6jIt5RfPp9KjjKnyVnZwOslzWKIS3wwt9q7/IgG+w?=
 =?us-ascii?Q?HFSWtdou+sqpq63HUIqfr9icGbylylmAlohd2lvUx+2lqZCUb8iTHw7DiJYD?=
 =?us-ascii?Q?5dUcrcsTqjmAJd8FDLC4nc+LBBNjsrf98JdCQOXVz6vSVDU9TlKmAQ3dKBMW?=
 =?us-ascii?Q?ulN5TyXhdX22/A29z3mFSM32k2TfDZB5HJFxEkTcSur+SjAPOu1IM6zJWA2r?=
 =?us-ascii?Q?5Xny4KYqfRUkR/j0aRnmnt7AeO6p62yUIFlK1UkTgOxEwwcg2JzURPLi3pPy?=
 =?us-ascii?Q?UEK4G2487Hj//760QN3X9nv+eGN8qJsP8FEZIj4KA+6MGTd7v1gevwrkUdLn?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oF8gsbmR+OjsbQHTJWwNVeavLIFQo8dXOwKF+z4JHV/a3er/kO/YArTZdRIkM7EG/UnLP44OVL+Zl6FMDobQZyYjdQ6QfccQOpxUFA0Zpz/al5tPCMCK0xjMxgsaW1Xj7Tt5x0tb7LJc/ErC55J869jEygbwAcT0ryKcLbegbu7Ug/AKtN2GR54bbN4tQMKLAko1HRdXLwc5rLVLKINvhckoNBa5szqQ7Hv58zNfSLMT3IC+nnQZt8MMTHtzEsHIO9vIyrrfdnZEFxMJ+EeYfYymL5Q+ZIJszxLgjGff4QGHVjG/oWyaImAQ1BcM1eND4gFS/luSxyKGg30paPtW0vOuojNo9WSWZX2AYAOnCS/mkD+Zgj6QLnfxZTto0vQ0L8wKnh14uAKAoyi3k2Lh2ABXeJl+c/+zNyp1S10LbI02Xq7knb0qEoBJ0yS7Nahat0hvMMrd7Jgud50nPgm26w/fG7PzX5Z8jbuchtUpIwrfYcnQ+nnU4Z48I8DPzYBgmTjQ53iKCYSxt7MJc5ZqX491uDIyU3yW4ycYGTFxzB3ibCSx/AspgbBHT9uXxA72XNsJIleRV/goJg8vimi4jtugb96sGH0vY937zTDkJeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccd4d31-abb8-40b9-0a97-08de12d0c876
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:41:46.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55dIhL0GY4HcsBSefZTRCIb6Qebuwa7HrY3blbh6bqUyG/QwhLHCZaXTze8SBRl69VawsyjqC7Fcrd/XUuKoHBysqtAJHPrKJEj9d4KU/+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX5coImmMzjMyF
 6Qwp/gmrzK8eHcCS0vJ4pMuNrBWzbGDOPTdRdymZ/GPSE2k5+fDhmSySI4javjl47xjnHbofZpi
 zAsLlf/3EuB7/hGn3hPUvk92f2Ou6/dWIj2wog9/kDBGuFtQ2RAlAmJN6jGIz/VQk8HADn61Hh6
 hCSf/akcpGVhJZfaADpqkeqt9LVG5QTOPUosyN3Z0x0IVDL5jkrD9hOZPmGNrBAoMCNjHPRQIMJ
 qEh8EK+3+Zl+y3mCNCpYfF1Mkp1OFf6DJBD3DhrMLxXSMz/jzeZZS2+HT2OXMw8bJNfIu54IrRW
 cg7rZoyAEJEKvq1VZ55nA8ya7qJi2aPkI4aklmpwSDlqaKk/Ep2k/6Gi9FfDvVp2gormJ2ZwB3S
 DefpCg0Rs687yH/9DbS3iWwOoxglvg==
X-Proofpoint-GUID: N7DqS7cdGfyEy_BSvvpCuBweu6oUH4jl
X-Proofpoint-ORIG-GUID: N7DqS7cdGfyEy_BSvvpCuBweu6oUH4jl
X-Authority-Analysis: v=2.4 cv=RfOdyltv c=1 sm=1 tr=0 ts=68fb2dbe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=jV9XR9aj_bnWWTu6b-sA:9

There's an established convention in the kernel that we treat PTEs as
containing swap entries (and the unfortunately named non-swap swap entries)
should they be neither empty (i.e. pte_none() evaluating true) nor present
(i.e. pte_present() evaluating true).

However, there is some inconsistency in how this is applied, as we also
have the is_swap_pte() helper which explicitly performs this check:

	/* check whether a pte points to a swap entry */
	static inline int is_swap_pte(pte_t pte)
	{
		return !pte_none(pte) && !pte_present(pte);
	}

As this represents a predicate, and it's logical to assume that in order to
establish that a PTE entry can correctly be manipulated as a swap/non-swap
entry, this predicate seems as if it must first be checked.

But we instead, we far more often utilise the established convention of
checking pte_none() / pte_present() before operating on entries as if they
were swap/non-swap.

This patch works towards correcting this inconsistency by removing all uses
of is_swap_pte() where we are already in a position where we perform
pte_none()/pte_present() checks anyway or otherwise it is clearly logical
to do so.

We also take advantage of the fact that pte_swp_uffd_wp() is only set on
swap entries.

Additionally, update comments referencing to is_swap_pte() and
non_swap_entry().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c            | 49 ++++++++++++++++++++++++-----------
 include/linux/userfaultfd_k.h |  9 ++++---
 mm/hugetlb.c                  |  6 ++---
 mm/internal.h                 |  6 ++---
 mm/khugepaged.c               | 29 +++++++++++----------
 mm/migrate.c                  |  2 +-
 mm/mprotect.c                 | 43 ++++++++++++++----------------
 mm/mremap.c                   |  7 +++--
 mm/page_table_check.c         | 13 ++++++----
 mm/page_vma_mapped.c          | 27 ++++++++++---------
 10 files changed, 106 insertions(+), 85 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index a7c8501266f4..5475acfa1a33 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1017,7 +1017,9 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 		young = pte_young(ptent);
 		dirty = pte_dirty(ptent);
 		present = true;
-	} else if (is_swap_pte(ptent)) {
+	} else if (pte_none(ptent)) {
+		smaps_pte_hole_lookup(addr, walk);
+	} else {
 		swp_entry_t swpent = pte_to_swp_entry(ptent);
 
 		if (!non_swap_entry(swpent)) {
@@ -1038,9 +1040,6 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 				present = true;
 			page = pfn_swap_entry_to_page(swpent);
 		}
-	} else {
-		smaps_pte_hole_lookup(addr, walk);
-		return;
 	}
 
 	if (!page)
@@ -1611,6 +1610,9 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 	 */
 	pte_t ptent = ptep_get(pte);
 
+	if (pte_none(ptent))
+		return;
+
 	if (pte_present(ptent)) {
 		pte_t old_pte;
 
@@ -1620,7 +1622,7 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		ptent = pte_wrprotect(old_pte);
 		ptent = pte_clear_soft_dirty(ptent);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
+	} else {
 		ptent = pte_swp_clear_soft_dirty(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
@@ -1923,6 +1925,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	struct page *page = NULL;
 	struct folio *folio;
 
+	if (pte_none(pte))
+		goto out;
+
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
 			frame = pte_pfn(pte);
@@ -1932,8 +1937,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_SOFT_DIRTY;
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		swp_entry_t entry;
+
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		if (pte_swp_uffd_wp(pte))
@@ -1941,6 +1947,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		entry = pte_to_swp_entry(pte);
 		if (pm->show_pfn) {
 			pgoff_t offset;
+
 			/*
 			 * For PFN swap offsets, keeping the offset field
 			 * to be PFN only to be compatible with old smaps.
@@ -1969,6 +1976,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		    __folio_page_mapped_exclusively(folio, page))
 			flags |= PM_MMAP_EXCLUSIVE;
 	}
+
+out:
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
@@ -2310,12 +2319,16 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 					   struct vm_area_struct *vma,
 					   unsigned long addr, pte_t pte)
 {
-	unsigned long categories = 0;
+	unsigned long categories;
+
+	if (pte_none(pte))
+		return 0;
 
 	if (pte_present(pte)) {
 		struct page *page;
 
-		categories |= PAGE_IS_PRESENT;
+		categories = PAGE_IS_PRESENT;
+
 		if (!pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2329,10 +2342,11 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_PFNZERO;
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		swp_entry_t swp;
 
-		categories |= PAGE_IS_SWAPPED;
+		categories = PAGE_IS_SWAPPED;
+
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 
@@ -2360,12 +2374,12 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 		old_pte = ptep_modify_prot_start(vma, addr, pte);
 		ptent = pte_mkuffd_wp(old_pte);
 		ptep_modify_prot_commit(vma, addr, pte, old_pte, ptent);
-	} else if (is_swap_pte(ptent)) {
-		ptent = pte_swp_mkuffd_wp(ptent);
-		set_pte_at(vma->vm_mm, addr, pte, ptent);
-	} else {
+	} else if (pte_none(ptent)) {
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
+	} else {
+		ptent = pte_swp_mkuffd_wp(ptent);
+		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
 
@@ -2434,6 +2448,9 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
+	if (pte_none(pte))
+		return categories;
+
 	/*
 	 * According to pagemap_hugetlb_range(), file-backed HugeTLB
 	 * page cannot be swapped. So PAGE_IS_FILE is not checked for
@@ -2441,6 +2458,7 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 	 */
 	if (pte_present(pte)) {
 		categories |= PAGE_IS_PRESENT;
+
 		if (!huge_pte_uffd_wp(pte))
 			categories |= PAGE_IS_WRITTEN;
 		if (!PageAnon(pte_page(pte)))
@@ -2449,8 +2467,9 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 			categories |= PAGE_IS_PFNZERO;
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pte(pte)) {
+	} else {
 		categories |= PAGE_IS_SWAPPED;
+
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 		if (pte_swp_soft_dirty(pte))
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 4c65adff2e7a..a362e1619b95 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -462,13 +462,14 @@ static inline bool pte_marker_uffd_wp(pte_t pte)
 static inline bool pte_swp_uffd_wp_any(pte_t pte)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
-	if (!is_swap_pte(pte))
-		return false;
+	swp_entry_t entry;
 
+	if (pte_present(pte))
+		return false;
 	if (pte_swp_uffd_wp(pte))
 		return true;
-
-	if (pte_marker_uffd_wp(pte))
+	entry = pte_to_swp_entry(pte);
+	if (pte_marker_entry_uffd_wp(entry))
 		return true;
 #endif
 	return false;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 86e672fcb305..4510029761ed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5798,13 +5798,13 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
-	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte)) {
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
-	else {
+	} else {
 		if (need_clear_uffd_wp) {
 			if (pte_present(pte))
 				pte = huge_pte_clear_uffd_wp(pte);
-			else if (is_swap_pte(pte))
+			else
 				pte = pte_swp_clear_uffd_wp(pte);
 		}
 		set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
diff --git a/mm/internal.h b/mm/internal.h
index cbd3d897b16c..b855a4412878 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -325,8 +325,7 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
  *	 forward or backward by delta
- * @pte: The initial pte state; is_swap_pte(pte) must be true and
- *	 non_swap_entry() must be false.
+ * @pte: The initial pte state; must be a swap entry
  * @delta: The direction and the offset we are moving; forward if delta
  *	 is positive; backward if delta is negative
  *
@@ -352,8 +351,7 @@ static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 
 /**
  * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
- * @pte: The initial pte state; is_swap_pte(pte) must be true and
- *	 non_swap_entry() must be false.
+ * @pte: The initial pte state; must be a swap entry.
  *
  * Increments the swap offset, while maintaining all other fields, including
  * swap type, and any swp pte bits. The resulting pte is returned.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5b7276bc14b1..2079f270196f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1019,7 +1019,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		}
 
 		vmf.orig_pte = ptep_get_lockless(pte);
-		if (!is_swap_pte(vmf.orig_pte))
+		if (pte_none(vmf.orig_pte) ||
+		    pte_present(vmf.orig_pte))
 			continue;
 
 		vmf.pte = pte;
@@ -1276,7 +1277,19 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (is_swap_pte(pteval)) {
+		if (pte_none_or_zero(pteval)) {
+			++none_or_zero;
+			if (!userfaultfd_armed(vma) &&
+			    (!cc->is_khugepaged ||
+			     none_or_zero <= khugepaged_max_ptes_none)) {
+				continue;
+			} else {
+				result = SCAN_EXCEED_NONE_PTE;
+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				goto out_unmap;
+			}
+		}
+		if (!pte_present(pteval)) {
 			++unmapped;
 			if (!cc->is_khugepaged ||
 			    unmapped <= khugepaged_max_ptes_swap) {
@@ -1296,18 +1309,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none_or_zero(pteval)) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
-				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-				goto out_unmap;
-			}
-		}
 		if (pte_uffd_wp(pteval)) {
 			/*
 			 * Don't collapse the page if any of the small
diff --git a/mm/migrate.c b/mm/migrate.c
index 4324fc01bfce..69d8b4a9db25 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -492,7 +492,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	pte = ptep_get(ptep);
 	pte_unmap(ptep);
 
-	if (!is_swap_pte(pte))
+	if (pte_none(pte) || pte_present(pte))
 		goto out;
 
 	entry = pte_to_swp_entry(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index c090bc063a31..e25ac9835cc2 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -345,7 +345,26 @@ static long change_pte_range(struct mmu_gather *tlb,
 				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
 					nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
 			pages += nr_ptes;
-		} else if (is_swap_pte(oldpte)) {
+		} else if (pte_none(oldpte)) {
+			/*
+			 * Nobody plays with any none ptes besides
+			 * userfaultfd when applying the protections.
+			 */
+			if (likely(!uffd_wp))
+				continue;
+
+			if (userfaultfd_wp_use_markers(vma)) {
+				/*
+				 * For file-backed mem, we need to be able to
+				 * wr-protect a none pte, because even if the
+				 * pte is none, the page/swap cache could
+				 * exist.  Doing that by install a marker.
+				 */
+				set_pte_at(vma->vm_mm, addr, pte,
+					   make_pte_marker(PTE_MARKER_UFFD_WP));
+				pages++;
+			}
+		} else  {
 			swp_entry_t entry = pte_to_swp_entry(oldpte);
 			pte_t newpte;
 
@@ -406,28 +425,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				set_pte_at(vma->vm_mm, addr, pte, newpte);
 				pages++;
 			}
-		} else {
-			/* It must be an none page, or what else?.. */
-			WARN_ON_ONCE(!pte_none(oldpte));
-
-			/*
-			 * Nobody plays with any none ptes besides
-			 * userfaultfd when applying the protections.
-			 */
-			if (likely(!uffd_wp))
-				continue;
-
-			if (userfaultfd_wp_use_markers(vma)) {
-				/*
-				 * For file-backed mem, we need to be able to
-				 * wr-protect a none pte, because even if the
-				 * pte is none, the page/swap cache could
-				 * exist.  Doing that by install a marker.
-				 */
-				set_pte_at(vma->vm_mm, addr, pte,
-					   make_pte_marker(PTE_MARKER_UFFD_WP));
-				pages++;
-			}
 		}
 	} while (pte += nr_ptes, addr += nr_ptes * PAGE_SIZE, addr != end);
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/mremap.c b/mm/mremap.c
index bd7314898ec5..f01c74add990 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -158,6 +158,9 @@ static void drop_rmap_locks(struct vm_area_struct *vma)
 
 static pte_t move_soft_dirty_pte(pte_t pte)
 {
+	if (pte_none(pte))
+		return pte;
+
 	/*
 	 * Set soft dirty bit so we can notice
 	 * in userspace the ptes were moved.
@@ -165,7 +168,7 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 #ifdef CONFIG_MEM_SOFT_DIRTY
 	if (pte_present(pte))
 		pte = pte_mksoft_dirty(pte);
-	else if (is_swap_pte(pte))
+	else
 		pte = pte_swp_mksoft_dirty(pte);
 #endif
 	return pte;
@@ -294,7 +297,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 			if (need_clear_uffd_wp) {
 				if (pte_present(pte))
 					pte = pte_clear_uffd_wp(pte);
-				else if (is_swap_pte(pte))
+				else
 					pte = pte_swp_clear_uffd_wp(pte);
 			}
 			set_ptes(mm, new_addr, new_ptep, pte, nr_ptes);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 4eeca782b888..43f75d2f7c36 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -185,12 +185,15 @@ static inline bool swap_cached_writable(swp_entry_t entry)
 	       is_writable_migration_entry(entry);
 }
 
-static inline void page_table_check_pte_flags(pte_t pte)
+static void page_table_check_pte_flags(pte_t pte)
 {
-	if (pte_present(pte) && pte_uffd_wp(pte))
-		WARN_ON_ONCE(pte_write(pte));
-	else if (is_swap_pte(pte) && pte_swp_uffd_wp(pte))
-		WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pte)));
+	if (pte_present(pte)) {
+		WARN_ON_ONCE(pte_uffd_wp(pte) && pte_write(pte));
+	} else if (pte_swp_uffd_wp(pte)) {
+		const swp_entry_t entry = pte_to_swp_entry(pte);
+
+		WARN_ON_ONCE(swap_cached_writable(entry));
+	}
 }
 
 void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 75a8fbb788b7..2e5ac6572630 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -16,6 +16,7 @@ static inline bool not_found(struct page_vma_mapped_walk *pvmw)
 static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		    spinlock_t **ptlp)
 {
+	bool is_migration;
 	pte_t ptent;
 
 	if (pvmw->flags & PVMW_SYNC) {
@@ -26,6 +27,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		return !!pvmw->pte;
 	}
 
+	is_migration = pvmw->flags & PVMW_MIGRATION;
 again:
 	/*
 	 * It is important to return the ptl corresponding to pte,
@@ -41,11 +43,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 
 	ptent = ptep_get(pvmw->pte);
 
-	if (pvmw->flags & PVMW_MIGRATION) {
-		if (!is_swap_pte(ptent))
+	if (pte_none(ptent)) {
+		return false;
+	} else if (pte_present(ptent)) {
+		if (is_migration)
 			return false;
-	} else if (is_swap_pte(ptent)) {
+	} else if (!is_migration) {
 		swp_entry_t entry;
+
 		/*
 		 * Handle un-addressable ZONE_DEVICE memory.
 		 *
@@ -66,8 +71,6 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
-	} else if (!pte_present(ptent)) {
-		return false;
 	}
 	spin_lock(*ptlp);
 	if (unlikely(!pmd_same(*pmdvalp, pmdp_get_lockless(pvmw->pmd)))) {
@@ -107,27 +110,23 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 	pte_t ptent = ptep_get(pvmw->pte);
 
 	if (pvmw->flags & PVMW_MIGRATION) {
-		swp_entry_t entry = pte_to_swp_entry_or_zero(ptent);
+		const swp_entry_t entry = pte_to_swp_entry_or_zero(ptent);
 
 		if (!is_migration_entry(entry))
 			return false;
 
 		pfn = swp_offset_pfn(entry);
-	} else if (is_swap_pte(ptent)) {
-		swp_entry_t entry;
+	} else if (pte_present(ptent)) {
+		pfn = pte_pfn(ptent);
+	} else {
+		const swp_entry_t entry = pte_to_swp_entry(ptent);
 
 		/* Handle un-addressable ZONE_DEVICE memory */
-		entry = pte_to_swp_entry(ptent);
 		if (!is_device_private_entry(entry) &&
 		    !is_device_exclusive_entry(entry))
 			return false;
 
 		pfn = swp_offset_pfn(entry);
-	} else {
-		if (!pte_present(ptent))
-			return false;
-
-		pfn = pte_pfn(ptent);
 	}
 
 	if ((pfn + pte_nr - 1) < pvmw->pfn)
-- 
2.51.0


