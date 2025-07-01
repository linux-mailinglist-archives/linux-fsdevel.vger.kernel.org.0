Return-Path: <linux-fsdevel+bounces-53456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C24AEF2EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8384B1BC760D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5872602;
	Tue,  1 Jul 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nTpAa5xj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U43WDwja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798B22259D;
	Tue,  1 Jul 2025 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361172; cv=fail; b=JT45Okerxz9xtnJ4OQCpe+0dJqq/OoBrYgq/eA8Lb1x6TQbu07/4P6rKgCY/rEk+9lwcfwW8tBH9PDGqbFaLtLo4AYs9VjUqyLCyPFmTZPP4OGVz0L7JCk9UchNKiUlpAysGYRB38WOV7G+brCdme4hGzQr1yf2ANpjv4Zu7vdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361172; c=relaxed/simple;
	bh=W7wjk5wvqJjNDeB8irGYq3Hq/arci5vGROxglIaJhzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GXfD1t+rRFsRBWAV5zDlA3zF+NRfSyqyvhagQ6J4Ri1FhjPcu9I2wq2mxF6y+NqKRgui+3zvlVcbCi0hePhC99Yn0b1FUUPdzt2I1hWtkHMCNkUZLUY3HyJFBCLbMCYPdg3ORn6gP5YFLSKSil0YBGgFcUo7PzUFa0gUnfnNtpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nTpAa5xj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U43WDwja; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611N2nl024121;
	Tue, 1 Jul 2025 09:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=W7wjk5wvqJjNDeB8ir
	GYq3Hq/arci5vGROxglIaJhzg=; b=nTpAa5xjg55eVwK2SDlq/d4zYRzuPfhhfE
	pUOtL755xVwPNwARiep6k5i9bLlDGWQnCRcYdDjfUY+5auZ3v/CPkK1aeCHQFuOt
	HNkaJw+cYbA9hDgeoZzSQeIGgYwt3WtYbGymkJYsWBBAbXP852FxWovl8sLXVSke
	73QvEY7Mk/CnNuVscoMPrV5uuf7Zzpf3nvcHmPIBcSjk+Vw6yEW/twax/C3pBZx3
	MotkLWos5rQlKdWs0Qt0T9zknDL5n5UI224kkynnBTTGKIjQ38vaZTF3M6LCbLL3
	dSMXikfE/Vwm5OXSHD8DY1AYr2Oaoq9pxwCYbxWkFvqVDMsdHlLg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef4c8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 09:11:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5617Le3G025830;
	Tue, 1 Jul 2025 09:11:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9g6qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 09:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Us2PkcMYOnHIj5nRh9L6wYLK63hvyjIU3FdnY25VK048NWc8hyNixib7WrUyxgNJuSRuRxx6NFntugO6IGhlqcVEC2e6AS2evYmSMC7B1ulfXgQOxv6bY2YVOG+IZAyovYTnwwcwUETftC1zP8MW5Tt0Ou82h3+psmxxC92PRlLFL1ExcKoCwmnxyuVOr+OIsNiZFwhXTwDtNTm8HYsVwjWqJ2aVbE3cIgvfp+VEb6rsyYAzD9qg2DcSdsDXHKqvJgYHjlIi5xSdw1V+BbWhvMdShUWDnM5PRNHWNBnFYLABBQ6CkIaRjIB6eRFcsHRU+6V87JYxp5iMjAceShNWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7wjk5wvqJjNDeB8irGYq3Hq/arci5vGROxglIaJhzg=;
 b=K146/BGUA/MdJB0DuxN1/n0NYLpHdwMpBWYekqXHJWmbn0nUcqybTHjQrRlOZlML3pE2pTG/FWgU8pk+d8+ipcr+m/KbMUNUDK4Elb4x9bP9RB8JdVqzCI9phlE3E8rljSyBJyaKjbKoRu/MaUrnwZiwwExTKllvGkSU1deRkcf+i3EbdEjjlUWAJHkZGk9r+sR3EbC6ssGXGdTA4A4nmCXldkcr5G+rkumN6X4baDyQApaWuIykKmUzUyqHUU4FUhQDBxsC0nci/D98N2MD0CmccaLRsdKe1FG9BpA1+YvlW+uGa7hrKn5w0auYGyXPfutHCgV0tz0xUKNpH48pkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7wjk5wvqJjNDeB8irGYq3Hq/arci5vGROxglIaJhzg=;
 b=U43WDwjaXg0xtilU5WWSb6UMhhPNpRkbRIVCkqlhiKBVTu1dCUGnXUcu0bJLqoAs31Ui5Zl0loWQwi5bCBvT4LaYWb2j21nyQbcmcouZXmKSlcuoOeKw5lLSbQ+tAuI59Bga8yb3If4yGJ1A6GrGe9PUYeGkQiC8bWmZGJiY4As=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5803.namprd10.prod.outlook.com (2603:10b6:a03:427::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 1 Jul
 2025 09:11:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 09:11:02 +0000
Date: Tue, 1 Jul 2025 10:11:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
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
        Harry Yoo <harry.yoo@oracle.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
Message-ID: <09fb264f-db0c-4015-a74d-6a036b0b4fe3@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-8-david@redhat.com>
 <a014bf06-f544-4d24-8850-052f7ead738b@lucifer.local>
 <872810e0-3570-47ff-8f91-3cc97a8870a1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872810e0-3570-47ff-8f91-3cc97a8870a1@redhat.com>
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab87d41-c263-4357-90a1-08ddb87f339a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fb5UNrhyU8Mg1YO5UqUIUmC5Yuc7XqZYg+AbJeUsJkTxB+WMY9blcfOY0F3r?=
 =?us-ascii?Q?GZKqWKr7EeQieKuyQMWuD+zEptaio+sFYxREmnxZAFofYRyOJC4P2DEPib74?=
 =?us-ascii?Q?nzouHpl0JgNRsCyO5rKHEIoIynSyg1ZvCNUSZexXla4JCsKXyxiWtifo7X+S?=
 =?us-ascii?Q?7avZW4ZMJx0ajIkrzo+Dbip9fklXAzgxFs9VGYRDLESwUSR9lpHVomxHt7O4?=
 =?us-ascii?Q?NO8PgrGoG0MRYuWDoiTIJqsrM94W/9MT5ScLuN60w8eDXkONzhGaSdcsXrNN?=
 =?us-ascii?Q?3UkHdaHEV23UOdLykK0fAX0sr4zpClVQXdQhXIrcSdepS9tzCg0/bz1bbweY?=
 =?us-ascii?Q?ObvbueaoLx9HS3BkIJA4NbBKBMcQCHl2NjhpwOvmCjr2KRPXo23sZFC/NSk8?=
 =?us-ascii?Q?0Zs/hgoa1Y0HL9MXE00JuwvWV7E1UFdrcGanSVIP1K7skMdWYz14fXqderQR?=
 =?us-ascii?Q?yIr2GvOy1aOQmfGJPIl5O87RGAhlIpe0mbBzJX+CoCaiGzdwkdFFlbl+wwGF?=
 =?us-ascii?Q?mbdQiMpGaZgIfWFry4qKGvItXYCdZkftpGdVYNxwsS7Rch4P8OauFuuXIDRH?=
 =?us-ascii?Q?LPK505BBydGhCXmb3yw7wAMsyx3RwbEqysc7+yny4H6FUoB6nU9V+hBmVw2u?=
 =?us-ascii?Q?Pl7a7GGBRw3BJLZ5n2uQkZc+G2Yzo0/7IFvoz1Y99AfziJ2Ot7ODVbOUfwFH?=
 =?us-ascii?Q?HV7VA0Wau+r8OcYorEatn6xr2TflkJ2wawswN5TK9eD19GQzez7voA69qQV1?=
 =?us-ascii?Q?l5Ebn+nVGaEF64rvD7GdxzfBt+NUxqhP+EJLO1n0HHrqvD7F+E/hzz+vvK/d?=
 =?us-ascii?Q?Z6JVCfX0hniepCvUW7PI2LzKD3QdrArW11LJdfBXYtQNkkub4fQFG7FZPaIg?=
 =?us-ascii?Q?I+haca9YHqvAMfjeYpLMWoMvun78in/4EAaKQV8lgTMTggvBSCFA5AFpPLw6?=
 =?us-ascii?Q?8r7nIDOBKB04D5Ts0VYkmFDk//u+xHpzNJGAUZIC/J1osfGQb6F/gZAJv04T?=
 =?us-ascii?Q?56iveLNO9feKrqsnB771+H0bsMhq8srHw+vt8WKk7kJai1SeW/UpWRBDUlxb?=
 =?us-ascii?Q?mFgpd+ZuV5fqHIhcKh9IfZx6od5j1hJfcs9lsukqTW4w0wKdyMgHfhZA+hpK?=
 =?us-ascii?Q?XWkUV7zzIspTl2cww1lEwG/ctCwelxDOMWHS6bZhR4fL9rKCvxQFntFUgOzX?=
 =?us-ascii?Q?2XWqJZipZjfcFfJ5Ohrt7kcjFeAlbJuuWdJHPD549osY07OvLWIsWcPmWZzF?=
 =?us-ascii?Q?TwwMT484ei1hy6ocArbCEVGxkZa1XfD4PKOa3woHrNX60EZHNqYyGF1J+7US?=
 =?us-ascii?Q?WzJ1hBD7DO6V0XxMd4RjBP6O3roCPXZtVHOYFgvxLq7qUMVB4LEzLyLQ0um2?=
 =?us-ascii?Q?Yg1X3jwy/pf4LKFpbxsho0ExA/Zkc0kZh0X1Pxzrmx3b8wgbH1B3xO5BxwOL?=
 =?us-ascii?Q?YDB4n6yLVmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G7Rgr9ndh94hKhvEZ6Hv4hFfKLfLId8288ONscc0VM1VrXd2rtyHkpN4MDKP?=
 =?us-ascii?Q?pK2UoAFc2AskEmnB3MHaE9TqEph80jZ4KbAieer/nzKv7nB4Ew1MAfDboLVt?=
 =?us-ascii?Q?ZPZuw+2xCNxufAPCpmvmBXjlQxgVub/O/3mUrdx1Dm63xOumuwEeLvgoxAIs?=
 =?us-ascii?Q?h6+2Mz6JejmVq75zjaN7oGf9G1Pc3lRm3Z+9KJhQHKfk+J5vitw32bxMAlZR?=
 =?us-ascii?Q?rdrPaepySKhHmGEESVjSItRwOWJqGCEAR/c1GSQFgbquk1xw75jw58TO2Rmw?=
 =?us-ascii?Q?1zHuG39f7wf+qHY9hK7iluMuD8es2uq2jHoIJ8wBezoF+abmgg60RCbWfUbu?=
 =?us-ascii?Q?8dyqAzR4oG+lQ77KgqYU5lT89T4UcQ7zi4tPjG/fUWLmwFBDZtXsj6c3Pyxe?=
 =?us-ascii?Q?vSNdp6aFFk291fQVfAa3ks2ZtF+tKoA4/KXOxlD2gQbU07PU/8aRT6suiVxh?=
 =?us-ascii?Q?jyzF/aDxRLecrc5u6MXyVVnlGsp47PUpmKIHja6sxoMm5upRqmqsTThBH6FZ?=
 =?us-ascii?Q?4Nip4f0cjgbaSIkWTJ9CV8/5q9IzD+89VOPyTysVyTcQ0B6nxYFXv7orNaWU?=
 =?us-ascii?Q?7vJUxxUjG1kTmtq0ISUMRCi8mw7gvH++VLBxHKzw73aRdqOAYwOL/Nu6Rq26?=
 =?us-ascii?Q?y+qX3o0Y2Y7fdAm46vVMXh9YHGK+pfMqtGJM4HGePi0E3i7MjbPHV5hZi2bf?=
 =?us-ascii?Q?okiA3bbd9BbIAZ+HiluCunhacHtRmdwJiObUcNRpQhoEWQX/UtX2Qc+DIocv?=
 =?us-ascii?Q?dWoQZj0pNUvTfUT2bzTtZ1YEQTvp1Dpyohxli+m1HwZYYLHMuPqIDxDeliMI?=
 =?us-ascii?Q?+Yot8w1z6WjV6LIk4X0Va2JMF6+UCm98eZtjesuCwSEpaW91jfMbZdVw5F8Q?=
 =?us-ascii?Q?+sJAOGaY8lQ8F2QStdylSVbB98iaPVg3Q355L9pr8CHRA3Pb2vsmchFDzl32?=
 =?us-ascii?Q?vThCV8Io/69lBJIxPbWzfgFdZBJnS++na8rfQP+19FXN9wTmTNQ7ZBMe3oDb?=
 =?us-ascii?Q?kiJskihbnwO91ia06vsYtEKPDF0a1xoF7v2ie26aY7jhHX/7f6wlO7I3I/zT?=
 =?us-ascii?Q?aQ1VqRY8szqjON+liOhPYL1oP0v3bAZVcEniRxiKoI6w+LjjQIoMAO+fdjvS?=
 =?us-ascii?Q?bmx/IGtUlUg5iEZwRSuLyU3aYiaBWg3b/kEsomIHh2UH+1Vy7KYmi0KmHmY9?=
 =?us-ascii?Q?+CNC6wvQdQGteTxc8rWZ/0NmUj70WwkyeZbglaP/pRoMP09/yZU7EcJLJ4q+?=
 =?us-ascii?Q?MyeTDnBUJjlQDW8aI9ALx9HVGFsUSpFd98vrb7RWZoppQk6Pdh1VeZo4p+PG?=
 =?us-ascii?Q?naLNzCAhEYFSIMSoBWnF4rGYlC5f47Aq4fHTD+0yb/HzNVwK882vqpyNoFXm?=
 =?us-ascii?Q?sA6xvdDTCgrVnG6FockLNWaeMyE8eJXAUYxlasdGttSOOWKGbjDdeHxdc+xx?=
 =?us-ascii?Q?i3Yl1JF7cxJWqaok3jBg/wlKXz7lc+Oiiq/DGwHZ0gRWPcK0PARKB88W4IdW?=
 =?us-ascii?Q?768AV/c0oKAWmj15Jxni8sclZ1655/U6ykevqilc/B1qlAkm2h67T8JqVDLO?=
 =?us-ascii?Q?YhNy6923qcW5jUw4uEhiDiCx7RSe7jxvZDTkTtfjz4VFHLtW6zpBBEVrVIXf?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qbREieThgAyGQPWbfxzW344PfaGSaiiNk8x+Ri/GRvhf8d06v9eQtYnoHxAfBEny1FfEycw3mIkiUxGB/BaB282KbJPeP/BjvXmO7FkZftt9uEsblnMmc90jnTISWTB9/AF9EqsRreaBoGPywKR/a+Sv1YVMh1CidRBj2Z509jxxG+wFXkX0J2G1QeWpKGLJQgOSfRWAHi8JrMD+vg80mhjeSaNd7Q9/Vsca5masatEYrZHi16x2lvt20Htb8xBYr/oYg91Nj4eNfOrVVXLyo0zzKq8ceWkV2OS03qv6V3jWnO81mU8htE6V5hZOgOGAzMP6o077ooEkH29W8yNH7RuPw8m8zGvyCbcl/3dIykzn0vMJg9s0Svmjaqf/nO+XXyfZoCrtJmaZqeNZGD/vr/cb0dUvfSuIJffmipQ1idZ1S/wD+gf5O/7tjd26L84XDne0RWiv0IyJpOs0Klj8Evk+WOzKkgZiF3M/pe8RcvOeNEwrriel9FDOnPRTQvWpgFt3p/8q2R4+djJOgIGufOphaqivnXghpzncjzymOalUu/c9h3egU/Fp26GZaO4MwIsvteE9zSpJBT/St9c4x2VBXrFd/szl8YixdfvAL0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab87d41-c263-4357-90a1-08ddb87f339a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 09:11:02.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+fZLi74XXn1pZbDf0PXLSy8/C/5pDqhB/mDLuKiPFqgBiGmzFQksInKJxDYKshTRXnGlTfpCplYLnNr8/lOW9GfIwyk6bQB6j8T7aDXQCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010053
X-Proofpoint-GUID: 1SB6zGOx5fe5pRBCuSYg44CzUm4diIXU
X-Proofpoint-ORIG-GUID: 1SB6zGOx5fe5pRBCuSYg44CzUm4diIXU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1NCBTYWx0ZWRfXz9qORWmh+FFL bIhJs+wzTDSRPuHiQy93Ag6GPDqTuqACKks5mve8oCInsc8/CNUSrUWIuqgux/XBJ4/+z88IlSn rxEHotJ6vBnZwl8+9mACYxzrviKQDq0X7ou6dR8xdiAb+4WlkVlbujEDwtiDOfA/Uk25E6kkZx6
 fRC9Maypqb3r/F9856CHFFbb4yjMkJANiHH3vta+a+R0CjE7Rp5l5Sxlh0LDx9zuXPbU348h+FQ 4wC/FksljRt+VZNyk0TxVAWwe5gKzYvTWwWaq0l04XJPXhKyEj0lTeeL4ZZX+UIRWKayyVAm70q iWeaAfIH65UihkslcfgFYo+nqeJzohFXqzA0bg+ROAjUAWi4oSse+zo7XH6CTzgNhYvHNNCnBQ2
 zpAZX2SkJ0vR+b07MlPe9Zx62Vr8/mI2gyEQABfpSvpWZmyOEl/3NA1n7OZRTbfgbKXU3lZB
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6863a62c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=muCX1xIpbn2whLXREDgA:9 a=CjuIK1q_8ugA:10

On Tue, Jul 01, 2025 at 10:29:54AM +0200, David Hildenbrand wrote:
> > I wonder, in the wonderful future where PageXXX() always refers to a page, can
> > we use something less horrible than these macros?
>
> Good question. It all interacts with how we believe compound pages will work
> / look like in the future.

Indeed.

>
> Doing a change from PageXXX() to page_test_XXX() might be reasonable change
> in the future. But, I mean, there are more important things to clean up that
> that :)

Yeah one for the future, and not exactly high priority :)

>
> --
> Cheers,
>
> David / dhildenb
>

