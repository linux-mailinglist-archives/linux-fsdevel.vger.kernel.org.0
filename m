Return-Path: <linux-fsdevel+bounces-53415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C39AEEE25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152B33B2B93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679F241672;
	Tue,  1 Jul 2025 06:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J8J9ymHv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WHPdXS5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7A21420F;
	Tue,  1 Jul 2025 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350014; cv=fail; b=kbvdEgLQ7whQ6JYstcxln6CL8o+iZWFx2aajYTUdWubZwwHwxlIjrRTCiSl4mcppLu/EWRjA8AHSVqxShg7EZX6yXe+w9pVZkcDgcaYjP+r+ZNwXnoMD8Sw0pKejXPBixDrYuONK5I96eKNxcNI/xe/dKo2bzYV+EOCyeMO+vqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350014; c=relaxed/simple;
	bh=FOWAFTNZ2bnj5TblmIukBUH/k1s2syX3Y9FOb/x/WCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b2euYo3qlGUL7ygZrdZHuj5x1Q6n1/Ez0FWcMLdk29Uv7sIYQWVjZIZPBidrbTduEY7lxTW2XLPnNNpgsPie9qlGSIMKRN+UfYLlIhYyJhAUBREvCVjK0q0Jge8Jye4ep4X6Jv8hU2g3/aVHQj2gJBHYg4OH61MawRvv/xK2WFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J8J9ymHv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WHPdXS5S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611NkbT006189;
	Tue, 1 Jul 2025 06:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KJHGqdxNwABI387pwq
	pcIz4yL77VlJ3EMo2ACrmzlDc=; b=J8J9ymHv14qpHhWZIbrhjqufvw7D3A5ykD
	dsTPXNml447zQBuqIfwvBNMRVVt1STBIc0WTKBRQ5F53ps12erBl59Che5MRd5SM
	B32hGOhFFVnh45irEDghJxsYiRj6rv0PiDdw4d6Upgn5pAN8n8yuJxyL1oH0oSMa
	WBSkiif5zU0n32OcHK8+PlZZgFpmCbyV2vqV+UtgMi9ZxCFAdK6wrq4jm64nxiBH
	1jmbjDS1ZiNbZzeyNTieAF2/X4DSMX/pOMU1mYsvHw0kyEa+modyLKuy0ZARKx2M
	/36uqOOCZ/1W39d+aSh1GoVXoUj8JxckYrETY1Q6Dgexe/6WsMkw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704by1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 06:05:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5614vnJF009107;
	Tue, 1 Jul 2025 06:05:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9atfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 06:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJWB5DeEOBYAfTWcNax6PuEkiklIz0VFozWtyuaWH4Eepp8AbPlPlIzmNYVTdBpggFi8d2O6/RQl3sMb77TR+TacbDy2yrcCFyy4owUPdstCJ3xtaISmQ8m4QEwq7aG6mfxlMXIT6dtJGrK1BO0/9WwYi8f4mA+3ymZ1BZNjAAcGztSWB+5GR+8wJOGqW5gz+H9eCrsIjMwN1NYBmeIdFJl70xyJYIt4tNUaJqL7X18wpU+0HdEpUGVIgYlLUV01fvJHhKJ947wpxmfQbF6ZGxUJX9JyuKi4cJ/yKerlPCxvMrPddOlUX1N33sdpAxiW882dtgJy0X7pea0BLKYaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJHGqdxNwABI387pwqpcIz4yL77VlJ3EMo2ACrmzlDc=;
 b=S+0GNyyFafmm6+LuusK6iCA4hXQSMhBxk2n8zxXWwb8tdeYh1lf1hZ2Fzbu+k9sLmGcRhDWOiOH1D3UaUZdwrvoSwjWk0eLaJmxoymCZdD5WGVjUonDWfmPnVoceTex4hGX8mXBXZJrqSB0I2irCARpmgpAFdd6GYzUiFM87SS0D1FSGJuH9hc5ymIOXu/1GG/ToGsPzEjKzmb4hV2lf6tQiVW/+b7u24HPOg+T2uei0vF/qFjMDW794tAk9lGlbCw+ek6l0uBO344SoXev18xppXoLpUSDS61FabMCvJ8EejlZbswIz5MORQOz+WcRMCQAFDjLB028zHOMNdHsAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJHGqdxNwABI387pwqpcIz4yL77VlJ3EMo2ACrmzlDc=;
 b=WHPdXS5Sv1QegEyqpLCU//7DtYjm/LSaFoCmwFRC+B/ZJfH9nUsSMEuXR8QsTEKS8pX9JZHaHVNMiV/OrHlVeIvIivLHTHioWPpEjT/nbqB3u2QicR3wiHpYXfFVYSYkWFgYr4wdu6b/APoxNZo+XHlE/mVgYK0vJ7lu/aPUi3k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8469.namprd10.prod.outlook.com (2603:10b6:208:561::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.28; Tue, 1 Jul
 2025 06:04:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 06:04:58 +0000
Date: Tue, 1 Jul 2025 15:04:39 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 08/29] mm/migrate: rename putback_movable_folio() to
 putback_movable_ops_page()
Message-ID: <aGN6d9HQWjwvGgpr@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-9-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-9-david@redhat.com>
X-ClientProxiedBy: SL2P216CA0099.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2261e4-098b-40b5-ff82-08ddb8653579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IJjFDARB2+MfWP5r5UghG1KrrdZyEx9YWB+eWtHVbAMiEIUWPH0Nz3X14/CO?=
 =?us-ascii?Q?/EG3B+PvJpwQb+f+RE+z8u+UEkk8xd6+etiE7xPQopWfFBK6YOzfASIvbJJr?=
 =?us-ascii?Q?aL6Q4zpt1nOkAQevmRKokZQZMjrn77Bw2lX6ysetdiikPQfeNOFVnwJjIIMO?=
 =?us-ascii?Q?S9sNB5lxCFc6LaBaU/vIzXRHVYEBSoz/tI96IGQKy/cTYhLaxFUas1/Dtm1Q?=
 =?us-ascii?Q?QXxs8V/IhIgDFi7o4+rFK+m+//ZblZ5kV1IJUayP3s2SwqI2ECsG87VvrrDA?=
 =?us-ascii?Q?WdrliMqxfW0SDfHyiFuGITq6GKIb3gxUryHi2N8uU60TmTYKW/b5t7ApAmmn?=
 =?us-ascii?Q?OgNFHYZDqLnT2gpxaB89Va/II7qMpgHQWaoicgslGjFPZRXF4n+EEoa208x3?=
 =?us-ascii?Q?xnuS1GFEgwq6sHmUVezGyq3n8iwJQRa3O3+R8V1SqmudscSiwcWcuSs7EaL2?=
 =?us-ascii?Q?MjoDVuDbNmApG5Dr2e8HwcF+nxbo6KI+pzrp0XpHxtT8FuieXWHvGXyf0Osq?=
 =?us-ascii?Q?wf50RlCA5EGNaSbgJuyQ9Xm9b6YOX3UJbPzw6OAEtw/0PZWQXUniTScaw1NO?=
 =?us-ascii?Q?URxi4mnerEe/3uJQzpe+p1ggs4Gzs7C6IKPqeXKQviYTQFudqq/pAHrVRSfJ?=
 =?us-ascii?Q?DRG/bRzqj+oTM32kUOjT8VUhjsPz15QSzwjzjUNbWHrMzEVrd2JrCae7fxBE?=
 =?us-ascii?Q?rBa7pBm1bst+2sRbSKtLh/UmT6vU9nCaf2LkHXcc+mOaqJ4GF0Gby+Th+Aph?=
 =?us-ascii?Q?IF56+od1NU7SbWzFfpcVe84ZNReaayP2M0uJAycA/lcgKDdSf9mA8mgnxCHk?=
 =?us-ascii?Q?20Biy+4uHBTNHS3ahavkhuaAXF0gV53qz88G8JIE9irvbq8MlVvZ5b2cgH0w?=
 =?us-ascii?Q?+mVYkuLtXoi7I3khBHPxY2Fe+I1Cqj5LnUBIMbykqf/CL2HWbF0ATznIc4W4?=
 =?us-ascii?Q?Zi4pZDHGZKpyrbwixHkb8anoUfU8kzohVjL+eZYarawG37JKuhMCNdctW7Oe?=
 =?us-ascii?Q?esX6eWpRYX61BXjZpovl5n1L88MHoyk7iqaKT25R4L33gd3GMo+SuOQ94osN?=
 =?us-ascii?Q?WhryplTG6VxMi7fNIdMGxMwV33JNiP5JtpmKqL0i5PXRbh6s8D9taHOLSZ11?=
 =?us-ascii?Q?4uJaNZDjGj8TYZqjKtDpjVCf9jdZ6cAWI1ESMl6bOt53q0jLuc2zZu19kQH1?=
 =?us-ascii?Q?t1NaGpludiES1YWTFnD4zHx+FgS+Ks0FucesOnneW3sTauwVcwo0mfnGos+N?=
 =?us-ascii?Q?W62ekCq2gdDiYYAJoGyWhYp0SYDpFTvjnbLkEodCoeLpAnSxazYrVkgO2Xzi?=
 =?us-ascii?Q?VUllxz31IgAeaUqXpQBgj47dMjz6mfVP0EtnxN6qM+DgJqdB0EWP6RWvIBPL?=
 =?us-ascii?Q?hlgCK20yi8E7QEehpESW/TDI7kppXrJ3xTgXD0rvO+V/R2kLeClyCW+Xabgm?=
 =?us-ascii?Q?v0dlQONA3IU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QZO5AAFauXm758nu7hPuMSMEKwXX7FJJkX0f11i0OYoNKgijYksM2N1v7uOA?=
 =?us-ascii?Q?US3QpNj4uqN9Buu/tWZ5ZRYcGbA9dVhjgdL23QaQK+oyP/Zq3EH9U1MFHLzc?=
 =?us-ascii?Q?97P3n/DRm6+jPpMzmizf9RKhANP9tIH91tGHYbN1TYCM71QLfSGhCem53XoM?=
 =?us-ascii?Q?VkfNwc/RJX8qZQy7VMFBArQAn4zfpDBDKplixS49qsbVCHMigr5gGnUlUjEV?=
 =?us-ascii?Q?T+o0hAW31wMz/o+/oIy3zVBoqEqVDAxJykNmX00Lgzb+h7b8fTluSGuJGiOy?=
 =?us-ascii?Q?epLAfXq03+N2GGxF2Pn2Kwu/opL3K+yAnfXd16r2DYTKYELcIoZgEhteW0f6?=
 =?us-ascii?Q?+gFtuEqBQ5mBVc3sqMQSZrxMYUKX7O4eJDPggpOM/SM6cSwc48SaOW5Vp3M9?=
 =?us-ascii?Q?ozXbfETCj5iQkoDlfUqaF3oxdgDoeduwAkkxVLnfoGJFLkO5zzIkE4Co+2em?=
 =?us-ascii?Q?20/JUSqTLA4x2rAuWs4h7OrjCkFwjswMetcCEtXax3NlJt9qnX9UnRGqyfnN?=
 =?us-ascii?Q?PQwS/Ci7F3VYQ4b2c1RZhoW7H0jGH42Vd7Gfh0XtyAgoPeWmAiFHsM/qR7d1?=
 =?us-ascii?Q?bJ3qU3OwvnW3G1zTfezjaRKBWXIteUJt1WMzpvM3DSkm1Q1AhqHahZ2CLoMm?=
 =?us-ascii?Q?YhFRyexfyeMZNvBUqWsohkRhF1/CDMeK7549bfRoWSzYGwpIGe/LicAJpJqG?=
 =?us-ascii?Q?bl12BHwVJ62+a6xgoR7hRk6GWG+N9E1lzBT4KQEOE2Bs6jFTCiHsrkE7qBH4?=
 =?us-ascii?Q?1tRj6zePU6o1BPMLwr+ehYUtqxeYXnMlpIsBGpaHaKDfDM7WKTKLsI5Q4k2g?=
 =?us-ascii?Q?nz4DGCKW4hr0AD6JWIPJU+0QRkL030Q1SVyZT2kevG0SzknjRmBRt3/s39Cn?=
 =?us-ascii?Q?/8QzjJ/Y3/gcZjA8+8K7tXf/7YLKAUBp2YUdr40k7uUCf0ieqwEdkv2OWZOy?=
 =?us-ascii?Q?SCQ12agFnY6IizQxEf0QLUDZHTzDBeyKlkXOh5p2saZ4OKY6n0Oz2jDDWuj7?=
 =?us-ascii?Q?CAN44sISrLsNGrVFCbFGBn7A/q4tG6TLorcjhn+T0DscA3VClLOM2Tgqh6fZ?=
 =?us-ascii?Q?WFktbcgW8jOIgFV7+GiYpNXRuaCzW+HjTr7O2NB71blEa/dODYviGGSKtVB4?=
 =?us-ascii?Q?Rq8OYVcEeVrwY8qSHmHxqKSCv+NrH26PUaBCgDITT0XXe/NahI5/4HaBK165?=
 =?us-ascii?Q?tpJWGdJ5wJFHBXMAvpe3+daL+nWN5oZlxqoUduUW/hGR1wY7xegDQhhwe+9T?=
 =?us-ascii?Q?PCa5D4KrNK2admfoYH8IWkkhdEglufcLPPc5c+wuUqqSN3NL07fTr31I0xIC?=
 =?us-ascii?Q?2hi9I0vHNwtfkECnmeINXjtxvniVEY9N2hiL4YfF2EL10bIPCnXqdPPHAt8k?=
 =?us-ascii?Q?ZODqXBo0lBk56M/DcxSRF1TozmYSNFIo3RVKBUha0fTeU4RHHAUrL0Dk9Dte?=
 =?us-ascii?Q?MUkATNOPqbLoKdni3meVn/z+O/3iYDKrlk98wFwM63Da8GzcidsOA1jb3NDB?=
 =?us-ascii?Q?1cPivM4lAOILPi9iQnK/MoU5bOVj7gO2FVRmxIgbk/AX1UltrxQ/VmiLwNUq?=
 =?us-ascii?Q?wLJmnZk7vMAnE702LIkGc3/BJwozXY3LiXRwxsST?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nmHRr5JFdQYiqsFu1f2priAqmGzd9QJR+ub7if4gPlcBT2ii/Ln0R0VtCyRJr/XiEiSc3bFYWtcrmqo0sdEvQHfhLRjQeI4CU6knFU8Cqh2VGYBWWhnMrdKltbxox4VQqq5y1tO8TpzIY/5j1eUFfKqCAOrxvhUDd0vNoOMYWxBO0cIl7r+bQI2atJf1hblJbV4fdiTNAFfDdG/aSOHSqlWYoJekCvJKQatZJGuFninRDHSIE+Npne3T3A5Xphn/aX6fDum0di0lQ58R8j2cK279JXVPmYOoZcmZFk73rlsoMcM79QRlcBJP+BxBa9oFtDGLPSM4bT+UkUB9zqw6+sweVqLLn/JdU5pZ9btDjbBxs0xx01b5wx1qbm+ZpO2Bw+I1xa9fmYHyJMZmAyPu2Lcke9+B1StXsd9+n31H7p8ygSv2kb88goUe0FsCeo+xK4tlt5k6GxWVq1Koy8izZmm1aG0ZnU+whS5M1WpRDQZH5bbLy8+RtxcLXnU5EcyBE3rHMYbmokmi2B/dIjjrL9anmYoBnAiNIMJtjpHiSeVom1u+bUWRllVjDvYThQA07hzHnc6cc8/8PtkDvhe81BoB77vdrhYWj7ekMIjPOqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2261e4-098b-40b5-ff82-08ddb8653579
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 06:04:58.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGDQ1SnRATniPje6bUqvwrdRZstY5akgsHMzKcWwougxniDKyOo0rr5Vogor3zTvB9MfSPIzbwa1rU1pqp8DKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010031
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzMSBTYWx0ZWRfX+7PB+SXLfGXF 9KZvACiAn7dhr9dY1iQfhQkPSVHWnggJ/nmvPMUaWbMoze5TEAIeVqpkJcNy/7wDftgBBZJEBg+ aqz19oTCZBj8Gdidj3DGo9x9nWm9hR7xlOCHPWox4DlC4QK3xv4t9KOK9cW79wbtehC9qSGHLvq
 jmJkfZ+JT8ezAsTpruhBEg4bZRRk1lNFoBQ+oJGXeDg1YpRtYMdmV4IBbbh+JUM9CL6x+fBaRBC Rt69uOGZrcyYKZxufpnHfX4jy40UBiMwjvnS6JyHs8qRVQeEU+qS91j4Enfjk4rd+IYMf9egFv1 uLl3VdMTJTTFxcMMTVhFjr3qyYlNzIgi2qTF9cGLfjgQ1Lqphb0A6v22DcIp10mwkTrVay/18kV
 CG1VPu6qr4iYRe3IkFVL9cquszbojFyth2jcOjgR8yhONgLeHI4aQkSrw7vH7KFcT1LlXp4B
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=68637a90 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=GhA8FySDDzEqsV6xc9QA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14723
X-Proofpoint-GUID: 67Ue1-m5xTnPWbF86oj6Gm6M8Aub0SOP
X-Proofpoint-ORIG-GUID: 67Ue1-m5xTnPWbF86oj6Gm6M8Aub0SOP

On Mon, Jun 30, 2025 at 02:59:49PM +0200, David Hildenbrand wrote:
> ... and factor the complete handling of movable_ops pages out.
> Convert it similar to isolate_movable_ops_page().
> 
> While at it, convert the VM_BUG_ON_FOLIO() into a VM_WARN_ON_PAGE().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

