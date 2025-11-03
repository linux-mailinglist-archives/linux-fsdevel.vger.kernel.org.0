Return-Path: <linux-fsdevel+bounces-66764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77153C2BB76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8A33B7631
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE23310784;
	Mon,  3 Nov 2025 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lFg2yvNU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ipWc10HK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8730F957;
	Mon,  3 Nov 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173256; cv=fail; b=CoZy26Jvxap/vHIPNOC/xfsvvTWlr+ZwdKUPD8ssvtKEPmLoTo5iThCsugvYiVlFHjlo4W6ZTjR+U+nECrBXpWJrYsRTIwtyKwG1yOtnsdvgu2X5TfABSi7T8wWTKdQ5og0cvj4ck9armXiwWIz7UpKFKVZqSNvOgLiBW0N2/E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173256; c=relaxed/simple;
	bh=JsENxz2x8ib+itdjKINv3ZO8YbOGvYnldUFO4Xb0BtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TfuHdNrW8FSw6GUuEMRhv2x482lzarRBRYbFEIf9UW3ipCnxOzTOvEVyWTak/FI7pdO5cqftEZ3BSR+OK7UMPqHxY5MJ/hzhgIR2khYW/2t0f7L/AU6lMq5/y35M41qxODVhaY4p9Pc0Ma1bRjsG0PAIXDesBy7zbtphzI4QXZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lFg2yvNU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ipWc10HK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3COjmw009969;
	Mon, 3 Nov 2025 12:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pAKpiFuYj0Y2wnZNTmgZYg5+xZ73FBBzAh9o7DPvX8g=; b=
	lFg2yvNUX+c0o+alNp/lhVnP7zNev/3s8XE5bCctv4eCFJ9JUSWDKJWObQQ+qTrb
	/cmdh40h4KxKmawqO2WsYmlR1k201oOij9G6wMGCFgKXMZnLerkzsPRpYy7ILyjT
	Gd2DupNU6Y72BJRxjPoRdSZ3lFneJMs9GDnJoTLBcYD3+ynDkd/v13h0LabD3q2N
	R3Q9CE0u6yJhCuE3uWM1AbgtX1oCpaif6e3pUI4FRgIGIKvLlqQAkyTTeHwkJyeP
	O3FBYC4VSQMkHsqlAdZqDYHltdgdVM9tpLmDu0/wxXqonCNMj3Jg5LOHYyUqVdy5
	Q7nAwQabIwde5A293OR/jg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vca00b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3AfW3l039684;
	Mon, 3 Nov 2025 12:32:31 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhux5g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jatM09FTrt4CUPq6WWg7HrrUh2FWpa5g7vQc19om+FRQwhHeGqK8YmIfi0L30ruDHxGC0pBz5R9Fs38aaeArT94gvhtEX3939Z0dC9W6bmq5kSPG5ttzCtj43quu07031snMmQfHi+yavpaRsS9ZRHL0BRtk/27JBbfkB20+k1I0iy+1xhEqciJ3ovzakbWsK3jmh4xaNzasbFkb8+QeL4MMn8Fib8iqWP2TVai+j12E3x1tNGu0jTpmRaAwL0q9pLCYjAy0G6/qKQlnEMq8O7CKcxJKRsuT2Mutf02xhbHFS5RTIjunNln2o23isNl0KAKzgIkNqHHUxadkdpDX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAKpiFuYj0Y2wnZNTmgZYg5+xZ73FBBzAh9o7DPvX8g=;
 b=MO6dndXIKx+7SSpTv4sIizezn1UErszdiZUk36gvb+MVo2y0AqvpaNKbj59V2j0qzQzf2gf63+q3l11+L9evEj6yr1C8Qt9yRhxGkg1JIyZ8NXiMkId7K6WPnNYRi80rATKk/nbDzYqWzO+mgSn6iwJ9pIuNLzEQJejw5ZfVFZqWjckIMlWGzn+ft/+w4CxI5o/QV3FMsoo0C0AT3VlG+PsK4mA2w7MMOPKdIN9Zi+gegWKUqwHaHSY4EhPK/VNWwikVTMq0aRgGQiWUhjLwNrCr80mGOEf+wwbg4PDlRETvSK/tVvT2rufd0b+D9fBS+UY+rMspySom7CLYv9Iycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAKpiFuYj0Y2wnZNTmgZYg5+xZ73FBBzAh9o7DPvX8g=;
 b=ipWc10HK2DwmaZ/8d1ZXxMKiMM4m1EuXll+byG37m3vI8QMzRX7/9tDNkaM6Eabha5poaRy/19q00wRWrQOK6cHZP0fsTfIxJz4yjYv1KCiZq6C+CO4vcgcUUdsL2+3joGVWRIscPOfJVDom0+QpdIKhl/oPAyC/ZJQ5B7fDX/U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:28 +0000
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
Subject: [PATCH 07/16] mm: avoid unnecessary use of is_swap_pmd()
Date: Mon,  3 Nov 2025 12:31:48 +0000
Message-ID: <0f4219d2d682f1447b2ce0f87f5f5d935d418348.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0034.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d851e1-085f-4e59-887c-08de1ad50d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MyQ6sEFdDXIf/1OdKicn/idRNtijrMfJsUqwLKnw9kGUldJQu7cHOfKfTDBr?=
 =?us-ascii?Q?OAc80Kksc5KhV5QZ1nGWFq5Hpb+DTaT36bD4WQDfg++pcwgPKTAxV4XPgc75?=
 =?us-ascii?Q?XFlaDLGXhx2QwHcswCtkmlQ6MtVt0lNjPnEBiWEj5c/Yfl0Dqzk2hGfrgAiV?=
 =?us-ascii?Q?6dZnz3uAB/cV39K7usj7JWqfP0wUrFBVOi1tmzljlCvU+S4LlG3NCAdUUG1/?=
 =?us-ascii?Q?bgbDMbknCEoQSOeeG3aa1ZpNhng8hgZKCwZJU9npKXr41Gu6hdqjYNfnMChM?=
 =?us-ascii?Q?87hqt0UdeyJWXu5C8tQLVNA0CvaZ6zm5+yvRvnyfZ9WSz4oJTQfr0Y0y3RuP?=
 =?us-ascii?Q?l0SKgi0SBvHzOgpg5dHFtX5+Tey3DytG+KqhXvvppKzb90Taalmto6gl5n0z?=
 =?us-ascii?Q?3JJGhGFZpYSFFhGxWrDo+f5nXiReDqSfyAZta6y8l13M0dbj6XXA4/+6xkd7?=
 =?us-ascii?Q?awe1p33gfLoiGKFzs/vNasNJMCVcBGC2LCOehJqV9a0vj/LYOdZoC5cHz8sq?=
 =?us-ascii?Q?5btAc6GaOC0sIEalCHPIhNRSjQhKHIviXSxb+JXhiZN8TNtbtx6iodqARj7T?=
 =?us-ascii?Q?Msn/1hwKnfbOg54EOXxqgF+C2jWoKtBDkdkomViX3xlK/wkqelQCzQkG8FAt?=
 =?us-ascii?Q?AqmIQ2KP0I3b9DXEUV8j+nUX/E1is7Ix9unYL57gEbYOPaJzAgIB/1VNGtHn?=
 =?us-ascii?Q?KVKXmvIwdf80XPyd0u/U6fQJiaUlh5KlEYV9bgXtj9eYO8WhufBPuJhF+6bj?=
 =?us-ascii?Q?Uo1DEOi+wD41eWcDD6Vdk2LUJH/M8oJZJw3Sxo6x+lc3N9d526OQ3rDrogLI?=
 =?us-ascii?Q?dEk0TfKIAcIrTjp1vhmdec0YFtv0DNz2ddg/oozIp5WP22DK653q2qyHAmQ9?=
 =?us-ascii?Q?yVKH4f6vHM93y4B2Oz8j0G3u8G5MRiuaL8mzwPS7WfbhkQIeFLDsVcCziwO3?=
 =?us-ascii?Q?I0BmJizhIs2wtMRlKRkGWJaT270cYFq0dADY518wsih4YP1mZuaPFvJCzqha?=
 =?us-ascii?Q?5ixIzmsSQXvJWLJxb8Rqr96KR8uogFrErc++A22R7A3hZLQ1+Np7yl2WS3XN?=
 =?us-ascii?Q?FMQo8ZQO3W7hZHj3FpUHZFZXx6AFF3aNAu8U/uhgmiNDfo5GDJ2iWmqoU9Zg?=
 =?us-ascii?Q?Sl7897/6H3fEdH85J60TbtlwM6CYEbwVYd1BISVgrzog0ESSwk2zzw8//f6k?=
 =?us-ascii?Q?sW0o56y8mPn+iMC7P2w2+msLpUonzJxzWjsqtD7VH5VHhhIKo0wFG6itv6ee?=
 =?us-ascii?Q?txpAW/uVc6EO65k6uRFXXf78wRg3AU9EoaIUsrBXJ8U1v5XfH1b4IRD/hoQZ?=
 =?us-ascii?Q?ofbvkbGnxzmncFK7eKcVI6f4uDdcrPBen6vsvgkFP/hX0sNYc43VM6sbbN54?=
 =?us-ascii?Q?bB8BVWerPnbdByuO5AxXMPOioTs06hJLl+hlbCqINJf5Yyi2vAV+i9I/P1wK?=
 =?us-ascii?Q?TAomx9b4zcj3iVgaqeSHAqvxuGyYO1cZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iCp2ByX+br775fVCIsAFnA+gK+9+QNMQhzyU3VujdvFUfayx6PvtAISTI11r?=
 =?us-ascii?Q?mZ/m9PxLpnpXxzUdidPyW2u2Y0Gv/aOjySRNXzkZDPYCsoxNx7EWJtCzkIyW?=
 =?us-ascii?Q?hABWxg+wCteDl6+JsKMNJf8CzYf7FI20SHMyLuLjhmRwvAiV+94eZa19h4+x?=
 =?us-ascii?Q?552jH1oy3VsiPiYJQzk2MlKRPTWgfMc1Vb+yMyKq6JBWUcxHC7Ow3Ru8aGBh?=
 =?us-ascii?Q?E/o9+CrXNKlCEu5SmBkrUsf4whsj2xgt3P6zjANicpu9EXb/+RZAe2gTM0Xb?=
 =?us-ascii?Q?1AZSMCRuNXMrrnAtS70Tye/Gzs9v8h1ac4SO+SN8DXScI38ScdZor0NCwAwq?=
 =?us-ascii?Q?ElGELzo9b0vjrNv+fPRRAeZOH8GDWTrYcMWQ7vWjVplGt/JJklGpx+WUiaAU?=
 =?us-ascii?Q?4tFwK4nIqXwrZijX8LBWzIFMZH5nRCtLxZRXIKinzCbJacfd/wy2y2mAdqFI?=
 =?us-ascii?Q?zfpWX+PEK7KbPYB8fNMY3zIDaXB1/8FIm4QSHwm9hNtlxusV/g0BodID+EY2?=
 =?us-ascii?Q?cae5Zp8tosQg1vgKKCAk27/ApiPrSZKTvgrZ16YNercD38K7BeiAgz+3PXJ6?=
 =?us-ascii?Q?iUxmhrFHo7GZhWn6N2o32WhkbtkCfrIM2wk5K/renCA0X/z5ZYq3BVz2mtvg?=
 =?us-ascii?Q?EJ/Q6/pfQckJztYtesrGougkDgaErUbt9aLjuJxqncvY+RuxhCCM40U25fKA?=
 =?us-ascii?Q?buFFGYQrdjmMzrI2fVDfoywA1f5rGqvWQ1Ix/xN3IGMUzSGpY6XfQ/FXr2Q+?=
 =?us-ascii?Q?SGvLLUcsj+cTtdJDqmdXauGAyzuiTpQudUh33nWhgY9IoKaKrG5H7NHesy4r?=
 =?us-ascii?Q?sv3ming5LczgkrxFgKNnrU5oSN2I3//QA3CKfK7IXODQRy4YvM0EyKJAri45?=
 =?us-ascii?Q?rsKP1BeZPZ50bmFqReDTb6akNOlwnMRHjGCDo9f5hZD9OTCtZhofOnMSipIW?=
 =?us-ascii?Q?wHNcXIY8gy2iU8RfWjC1q+7qKJOBYcddo4aXGuSuH9yxK+7eTxE2ydOVpliQ?=
 =?us-ascii?Q?oNaJXCl+z2Y8KYOOvxkG6t+eZ6PE/eWcMF+LMumgB16W91RQ9fcw94kqn821?=
 =?us-ascii?Q?rrfHr2dHzMQvUjmYjOp56yHqAJ6wrb4lzBGIl+MznBEp2boXUMM1Ue9pk7Ts?=
 =?us-ascii?Q?bsQOzKCp4yXG5d4d2AdDHsE9PCcag8PU7vSAibY96OwjtkcEtyqdqb+FanUH?=
 =?us-ascii?Q?wWoABlSRa6mD6o3XUTcLtPCG08lPl53X/BiUk0KsVhjRCl5446JsYcNvGyWL?=
 =?us-ascii?Q?zU5ijpvYN1PQYWwPbtNGtkwXgLuaWkeNNvarO4V8zAXa94flbyMsr2t5Qd2L?=
 =?us-ascii?Q?+wGiOtltZf9FMH41VLUJte38S6STxI/BxQiVJYJ2NcLPzSP168xAC+1QUVHQ?=
 =?us-ascii?Q?lEmciDyeIY1alQcgYlqxPM0ewxpF+aECCQfgzmM/vw/211TZdXFKdFzsA/2G?=
 =?us-ascii?Q?62aCrhE1AiJ/HKcz//i7hHOMBvUK7Rpg1R1Qgd1Md97PCf+sLWKShxHwdN5C?=
 =?us-ascii?Q?x0sXa/tTygUNr6XKtGSgtB56cdF1oOHoVs89jyZ6DWL1XZSEe+o8mDOmqDae?=
 =?us-ascii?Q?AgB3UyiPzq06ziEY0NGSQUEIEtkGu9II+kIMaciilwO9fdGAt+zkAP2Tuuka?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EhZ6+jT+AmXFJT4RLWYQQ/pv3WlqREkLPUQeIB+STUpOBTYmaPZjzWpONCXNVUip3SBd0q+8JOWsm2/dsdcNzeQVCqoyFEEFph+Xc81Hy+kMrYi1G9ztKEy4uNA1RJVs4TY+C7vKAPicipuzZxRUglrvapC3hsiRUJTK0+I2/cpsHk5xV5JiSufWJszXbH5S6yBE+yV229LCuHI3LTRQpjeUdY1F1KGdyBd/q25Gz/gMXwUqnzyMJhD48O3UrRMN3BPZNOt49wLVAdH5dHp9+IyCwCaJ0z6fH4oJaRWXVElm9TD/GryLISaljM6nuxwEOQp7el95rIN28xq4PmJI1cwf5w9L7FDczbG0vFwtwOco6Q5Ne+7fFGqNAxH5x/G6oGluf+tnSscDtZv7TRH8hDSD+WdDm0aSaWv/SXLJCcD6jcIRjJGPvJcxy24uEZJCysrNbw7w3/hYG+daFR+0zGdWwH9NSbUAqHRFrim6NoXj2ob10f5J2bEJb2Jkj1lM9tpwzR6G4NXkYlRcPU/KcBsv7polc0AHkS+z9DmELadv114g49Up1DmZ3Vp97rP1y9mhRRGMQaGWdiG1MwowKb0Rjs6+ntW2sDO00qKarEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d851e1-085f-4e59-887c-08de1ad50d1e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:28.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpeQ0CtLOcKgYkZzklRiP1k4zaArkzG9vTkZJTXzFookm4BEEkY/iXyVMgHIkiTco+luz8b4nfCVQb/i/8dAv2EzSniRVCv/8wYtJSXlp0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-GUID: qDs-bmIrgyBhtGt8crFHpPeNuxn1JQqm
X-Authority-Analysis: v=2.4 cv=PPsCOPqC c=1 sm=1 tr=0 ts=6908a0df b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=96_WKPqrBKIKR3zHGkMA:9 cc=ntf awl=host:12124
X-Proofpoint-ORIG-GUID: qDs-bmIrgyBhtGt8crFHpPeNuxn1JQqm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMyBTYWx0ZWRfX6LX1PmFZUFmP
 jKfsIMn/RLh0eXoHzLvCEds9JCdaeZJxHDneN9O1Ilh4/gZWceZdLTJUO33kb64H8fpwN1G3Zaf
 uBMk3NQhpFh+AIwsufzji9Hf93YMtFejrZP9zHE57poUn96dsOMK9qNIQmVa0xzd2v8hhcli8fi
 YIcIGRb2ZkLpTp5mFklyyLG2npJsb3lIVSX6xLfts5M52Mrg59fuMBVQtONnGaIRoBMLWBY8R3O
 Cv4pVmb1bzVwwnrtqKT8AOFVesj5OI0nchr903GFrRflcQMg7TL+vhAjA9bn7MKL9O1veaSJJo+
 O4XBnV7kqlulx5LmrSpaqR8TUfi8hS+3rmv/ApdTwU9p2dsknHstIXZtqPebHvggWheSkgwDvik
 c7+d0iBtnfeEG0RwY3xeKedI5oOWgLyzY0By/4qCs9PADqu2qqE=

PMD 'non-swap' swap entries are currently used for PMD-level migration
entries and device private entries.

To add to the confusion in this terminology we use is_swap_pmd() in an
inconsistent way similar to how is_swap_pte() was being used - sometimes
adopting the convention that pmd_none(), !pmd_present() implies PMD 'swap'
entry, sometimes not.

This patch handles the low-hanging fruit of cases where we can simply
substitute other predicates for is_swap_pmd().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      | 15 ++++++++++---
 include/linux/swapops.h | 16 +++++++++++--
 mm/huge_memory.c        |  4 +++-
 mm/memory.c             | 50 +++++++++++++++++++++++------------------
 mm/page_table_check.c   | 12 ++++++----
 5 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index bd0042851ba7..0f02bda5d544 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1059,10 +1059,12 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	bool present = false;
 	struct folio *folio;
 
+	if (pmd_none(*pmd))
+		return;
 	if (pmd_present(*pmd)) {
 		page = vm_normal_page_pmd(vma, addr, *pmd);
 		present = true;
-	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
+	} else if (unlikely(thp_migration_supported())) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 
 		if (is_pfn_swap_entry(entry))
@@ -1999,6 +2001,9 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
+	if (pmd_none(pmd))
+		goto populate_pagemap;
+
 	if (pmd_present(pmd)) {
 		page = pmd_page(pmd);
 
@@ -2009,7 +2014,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_UFFD_WP;
 		if (pm->show_pfn)
 			frame = pmd_pfn(pmd) + idx;
-	} else if (thp_migration_supported() && is_swap_pmd(pmd)) {
+	} else if (thp_migration_supported()) {
 		swp_entry_t entry = pmd_to_swp_entry(pmd);
 		unsigned long offset;
 
@@ -2036,6 +2041,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 			flags |= PM_FILE;
 	}
 
+populate_pagemap:
 	for (; addr != end; addr += PAGE_SIZE, idx++) {
 		u64 cur_flags = flags;
 		pagemap_entry_t pme;
@@ -2398,6 +2404,9 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
+	if (pmd_none(pmd))
+		return categories;
+
 	if (pmd_present(pmd)) {
 		struct page *page;
 
@@ -2415,7 +2424,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_PFNZERO;
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
-	} else if (is_swap_pmd(pmd)) {
+	} else {
 		swp_entry_t swp;
 
 		categories |= PAGE_IS_SWAPPED;
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index a66ac4f2105c..3e8dd6ea94dd 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -509,7 +509,13 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 
 static inline int is_pmd_migration_entry(pmd_t pmd)
 {
-	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
+	swp_entry_t entry;
+
+	if (pmd_present(pmd))
+		return 0;
+
+	entry = pmd_to_swp_entry(pmd);
+	return is_migration_entry(entry);
 }
 #else  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
@@ -557,7 +563,13 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
  */
 static inline int is_pmd_device_private_entry(pmd_t pmd)
 {
-	return is_swap_pmd(pmd) && is_device_private_entry(pmd_to_swp_entry(pmd));
+	swp_entry_t entry;
+
+	if (pmd_present(pmd))
+		return 0;
+
+	entry = pmd_to_swp_entry(pmd);
+	return is_device_private_entry(entry);
 }
 
 #else /* CONFIG_ZONE_DEVICE && CONFIG_ARCH_ENABLE_THP_MIGRATION */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f6c353a8d7bd..2e5196a68f14 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2429,9 +2429,11 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 
 static pmd_t clear_uffd_wp_pmd(pmd_t pmd)
 {
+	if (pmd_none(pmd))
+		return pmd;
 	if (pmd_present(pmd))
 		pmd = pmd_clear_uffd_wp(pmd);
-	else if (is_swap_pmd(pmd))
+	else
 		pmd = pmd_swp_clear_uffd_wp(pmd);
 
 	return pmd;
diff --git a/mm/memory.c b/mm/memory.c
index 299ce5dcba76..a0ae4e23d487 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1376,6 +1376,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		next = pmd_addr_end(addr, end);
 		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)) {
 			int err;
+
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
 					    addr, dst_vma, src_vma);
@@ -6350,35 +6351,40 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pmd_none(*vmf.pmd) &&
 	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
 		ret = create_huge_pmd(&vmf);
-		if (!(ret & VM_FAULT_FALLBACK))
+		if (ret & VM_FAULT_FALLBACK)
+			goto fallback;
+		else
 			return ret;
-	} else {
-		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+	}
 
-		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
-			if (is_pmd_device_private_entry(vmf.orig_pmd))
-				return do_huge_pmd_device_private(&vmf);
+	vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
+	if (pmd_none(vmf.orig_pmd))
+		goto fallback;
 
-			if (is_pmd_migration_entry(vmf.orig_pmd))
-				pmd_migration_entry_wait(mm, vmf.pmd);
-			return 0;
-		}
-		if (pmd_trans_huge(vmf.orig_pmd)) {
-			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
-				return do_huge_pmd_numa_page(&vmf);
+	if (unlikely(!pmd_present(vmf.orig_pmd))) {
+		if (is_pmd_device_private_entry(vmf.orig_pmd))
+			return do_huge_pmd_device_private(&vmf);
 
-			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-			    !pmd_write(vmf.orig_pmd)) {
-				ret = wp_huge_pmd(&vmf);
-				if (!(ret & VM_FAULT_FALLBACK))
-					return ret;
-			} else {
-				huge_pmd_set_accessed(&vmf);
-				return 0;
-			}
+		if (is_pmd_migration_entry(vmf.orig_pmd))
+			pmd_migration_entry_wait(mm, vmf.pmd);
+		return 0;
+	}
+	if (pmd_trans_huge(vmf.orig_pmd)) {
+		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+			return do_huge_pmd_numa_page(&vmf);
+
+		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
+		    !pmd_write(vmf.orig_pmd)) {
+			ret = wp_huge_pmd(&vmf);
+			if (!(ret & VM_FAULT_FALLBACK))
+				return ret;
+		} else {
+			huge_pmd_set_accessed(&vmf);
+			return 0;
 		}
 	}
 
+fallback:
 	return handle_pte_fault(&vmf);
 }
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 43f75d2f7c36..f5f25e120f69 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -215,10 +215,14 @@ EXPORT_SYMBOL(__page_table_check_ptes_set);
 
 static inline void page_table_check_pmd_flags(pmd_t pmd)
 {
-	if (pmd_present(pmd) && pmd_uffd_wp(pmd))
-		WARN_ON_ONCE(pmd_write(pmd));
-	else if (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd))
-		WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
+	if (pmd_present(pmd)) {
+		if (pmd_uffd_wp(pmd))
+			WARN_ON_ONCE(pmd_write(pmd));
+	} else if (pmd_swp_uffd_wp(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+
+		WARN_ON_ONCE(swap_cached_writable(entry));
+	}
 }
 
 void __page_table_check_pmds_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd,
-- 
2.51.0


