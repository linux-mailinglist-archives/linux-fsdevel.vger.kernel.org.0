Return-Path: <linux-fsdevel+bounces-61763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C591B5999F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304483A674D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B136CC6A;
	Tue, 16 Sep 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IYrrTktY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c4s2G4Ix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0B36C089;
	Tue, 16 Sep 2025 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032065; cv=fail; b=Aji3/aspliH0nE4dmZ40lvq7r9Na4lbewLg+BqExkbzlbIX06f8F6debhwiSdw/H2LZCZEwEOTRXG/fOhKxAvsdv2cS5SRWrR70bFn/5v4flhaFGa7guiRIwNpxFhn6T4sR7C2LbK30vAYJl1CcnYTVP6nrfLmGVqHv+bth1ma0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032065; c=relaxed/simple;
	bh=zyWx9CHiAOIEBPfncjCl5KM8TnytCZFh48lzn9ulZyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTpPX/U7CfKTw/QpJSkHX7HXSa5qlp04D0djKzA5bX2SlGP9x/8t9fBPmGm4RfayhIsiZjiESfFnSaG1MlXMS8lnuxV6z3GFD3OHL0WCG/aq1neXIFi/1vneLfjD0+fpQSOPyIz+mQoQUXRrmx5OaYHyeduPcuN/lBIPL/JzPhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IYrrTktY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c4s2G4Ix; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCwA45029801;
	Tue, 16 Sep 2025 14:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mLt6Iw8NNsjDpMDEGiSX6emtwWW6f8/pFdcoNzwwJeE=; b=
	IYrrTktYI9X/1jU5k1taqaOppkOsu3ixSNoPA2UlbL+/hbkHnYg0MiGDIS3rzyCh
	m7QCM1ZW8Je6keAgCY2IdLxkpFXDKNW4u8dPe4NPlvMUDGrOaPgfN7yAOXFTNqdw
	IUME/CX0ZNSUYtq5M3ZB7O1Xx9TatUtTxlDdbkxS5uBBgH8MOqpvLkoRWkpzEptV
	1kPYpjojHeVwbRzQA0cbHwfT8Kq3aGJvpo+Vjz61RVFXchSd7B48bhOO1SKGJCwt
	FyNBBpuEinCtArgqce6xopJXfrSIHGFQZC1/jXr3aq/1thWx3IIlaXpp6k/Cslik
	Wn/PnUnU0RQH7cWfTVLP5Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y72vt1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDfijP033734;
	Tue, 16 Sep 2025 14:13:30 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ced7h-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ+lOTmDUrdwDQ+1SPcJsgzyCmJE6nkJgpl/lzHNKkxDCach3inRUd57FJt7/QRu08CgnuVbgXpcIlA+5UOpMqk4P+bfugGFa9ni7ts9MX07MVWpz3JShB4sbt2DMpGF3KA3/pavSbjt2OYFlrp+BabEBCSlUu0burltpS2I57H5EYjJeniHmjwmsgJQjaWKlPlYe4ZrcfHLBUvOT6ZxSUG3RhXxw0TV3bYKdK0Wm4v8tkfD93AVkBhzZP2RsLfI8tTj2d6rikynGazDnHrCa/iCMcrEfWFlQP5W0dElbh7x0gufqGrStubu28oSMboLaPvUjDEUEOcPWa3oDrYHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLt6Iw8NNsjDpMDEGiSX6emtwWW6f8/pFdcoNzwwJeE=;
 b=gDysegPFf0PbQCbT20SkV0H4WkJ/NN9K24LVgE+AjQ/tBZkVfUPzulqDXFSS2JJQ6J/7l85rteqpKTaV5kialE1307O5G40z19tDAPVtPe7r82mkluHjY0aCq0MuZeBRYgfwk2kJVHW4c5BsuqVTN2YfZPkTvap5lidxC94RB2sRC9JVPkUJF8InoHOjtWOj/pobHCZ5dWFhJTyRfttEa37mM3oSpcUH1KTiX/IHPmfSz14neVpAUVLwjhUx5abDccJ7scXd5c8xXAHNZEL/xDunSmp9qZTMypZkH5jAIRowGtCR77Tbw0RnQ2rJesY0ofUHDN3RMWO2D3qz9kIHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLt6Iw8NNsjDpMDEGiSX6emtwWW6f8/pFdcoNzwwJeE=;
 b=c4s2G4IxYRWAf5+nO4URcTEETAYc6Qbtk+YfQkuYmopFOEP9SD1cdKOWU9YLr660IlvGN/X560WlzFeJineOQ2/W9WAuPZRNoR7YXlPuL0NxkC7JW6BJqEYkQ0lQl4wBJCVzU9doHW6QafdLhqEqhmtAr35BmAXuExK7BD9evQY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:12:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 09/13] doc: update porting, vfs documentation for mmap_prepare actions
Date: Tue, 16 Sep 2025 15:11:55 +0100
Message-ID: <381cd37fc18a07a45270674cf4d09998ea827a7d.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0395.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc280aa-e731-4caa-4559-08ddf52b2324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T8AjEE/4O/V4RKujAtRhjciOpNHUTMwtZWPuoVQv1UA8V91bhXsVQKb8qt4K?=
 =?us-ascii?Q?0Dwp7p87BKi+LBG3KL06aoVhPI/rcZ3q4Z7nDoXia8NZfc+OKHkC1QM/f6zS?=
 =?us-ascii?Q?vMVDcvjbFcFfTI6XHZiGAb7973XqDBTzjle15KbLld4XBR68C7wrTxS/gUMw?=
 =?us-ascii?Q?hENyHc5Hymp10kpHjUpTbutidvlpk7URZF66AlQdmjnRQH9jU0OYX7yuK8vm?=
 =?us-ascii?Q?4zGsFR7ZPExkKmIB6YmGpHGCbDNK1318YI5eg0+5DZsCIn7LMkzT55xz5W+O?=
 =?us-ascii?Q?WbRDDBd2B8RYIPkSXZ+rFj+R5gpYUQMDAR5BQptMP/IPsc5UAqqVCzmZjuDk?=
 =?us-ascii?Q?otr0A+hpLUU4qGqlgM1dHzitESeFS0LTQhG51QjWUTmkqWtlENHdQrTELWg5?=
 =?us-ascii?Q?NJ3dyVeIV70scam35OZ4ysMMdHvPjrOBMpOR9cujaoY9hD+fRpj5zKNj26a+?=
 =?us-ascii?Q?RPvRRviJecfc1LMmZGBsQk8kSe7kjaXwvqJQY4lPXlUiGUxU9fiKh93TnN5l?=
 =?us-ascii?Q?s5hJIZw28DleHicdRoqaMHxZTmNqfmXj625GSN8DI0lC68yS0WiqDrhdE9aQ?=
 =?us-ascii?Q?vsz3a/k07YGQhV9M7RkuHqlx/S1Pg5PzwLXF0TyY+g/cPHcBal59Sk/ifQ9k?=
 =?us-ascii?Q?WK+hMUCMT9wWPDES2XgX2Yn8nmH/rr0MBCA/ZUPAV5POlpxKGsmu+hLAdXgf?=
 =?us-ascii?Q?P7JTIe/8UElDM9JuEw8CoYCCXFELvfImpevb35pNk2qEH8y2tnl9kGLoOeOR?=
 =?us-ascii?Q?sORy6lU1YmyaJdgaozMFFIv8HWWMpZIgsboIyXS5bis7JsUqXsmQjo3XecUa?=
 =?us-ascii?Q?2KCN2/1A2mDcxA/Si4uP9KF+OngTP7YNvJ/QHH8YCUO+UxqfEeoLfZULxOvs?=
 =?us-ascii?Q?XQLaJsoncRV9J57onXbUPiDqf4RIvctHO5lRYUdnSljbAYKT717vmyfCB6zu?=
 =?us-ascii?Q?OmqK6L4/6lrImfzxZ+si4mqD8KvkxTH39IY+srVTwTBqm7EOMPUu6NfDzWKl?=
 =?us-ascii?Q?taRd1aEnxI9XSvrdHPKTXHY32z2rOo733Ka7JYSrccHaXHbHYe/sKsfW81Na?=
 =?us-ascii?Q?Vj1LFng8xGipPnpr+8r+Chg354TcOn+SytQflRx6qP/4wQKuN07Jq2F7ILPW?=
 =?us-ascii?Q?J3y95IhUgzAtL4Ive//vKRWxlGUKR4tT34FaRikrCkSq0OyO2uYL5SuazkFX?=
 =?us-ascii?Q?HPzt1xpeT6HebQ1p9QN9NhIv1BIdd5A3318fDL15l9TpT4ufju7Nz+XHoB2E?=
 =?us-ascii?Q?LkjyNaCuyvqA5WxksPw8pdFFPh7wmTCEZYfNZmx4uE0lHfMAKSIskyUTs34O?=
 =?us-ascii?Q?aO2vTG/pGel9DFPVKYVODE/5xAA7egVuHdPIJU/4SLtKwkbnGHpTO/722OqW?=
 =?us-ascii?Q?FNLdqih7HHC/xK0pmdXM2XRpWTiM11Kr9I0HXjCXfZv6+u7HoYUb4UPl3Nua?=
 =?us-ascii?Q?cX72H0aWiZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f51HqmAQ2JVmGJX9D0xE8PV+jQuQT7uV0zCetx03hjnQttk8XFJmpwIImmIe?=
 =?us-ascii?Q?Q+XMupxJGg8DQj3fJW5rdkj/z2aTSY/9cxGj3qZCa9qu+ULweG0sa3O7mVpc?=
 =?us-ascii?Q?YjGadvFi1tl9OQICmh/appjxElfcBQf8uWFw0yUJLhA0EBWL/Sak2EgTT8D3?=
 =?us-ascii?Q?1qJr8ug9xr8c7TlPLf65VuEsRMe7N81RDdGn8Q48+Zi2+4mNYLxKCmhX7BaP?=
 =?us-ascii?Q?8bzdj+cPapE972ZFgXZqXDpLEE2qIAoJAW7cJdQu1Wuy4T4xQOzKUEi9Xp2i?=
 =?us-ascii?Q?KbToQrpQP4G4m61/dpPkuNM3XYJJ5F6WlwX5s2+Vx1S/AFbtEsJCa281XHjK?=
 =?us-ascii?Q?9aYMcpsQAb52H26DOMhd94lq5XIi6yzqjsFNocbSSvv3kQ3j4YLg65AwUmBN?=
 =?us-ascii?Q?AUJva3sOzJfjHU3LQQBDh9cO9C+9bUVm8gbv34hEhykmb502BzB6E0GlbuTy?=
 =?us-ascii?Q?X6irePXvyeEGe6kNmVlpZpFt/LyZsGZA1U8sr+GDcJ5c90q0ep18jRtc/M3Y?=
 =?us-ascii?Q?17gRzA3xuUkfCqjZdaqu6p3OrEOGuKqVej21JZ/JmeG+koUNGIOigCDFPL/B?=
 =?us-ascii?Q?7PmQMOKXajNgbeUUV66S257WF4ZybRhTlFeKQv2RoM1PuhX1GeOPtJfUSzP2?=
 =?us-ascii?Q?bH397TQQWbgmASTsiMrgU+RfhYSZTcSwol5m3fuECGzzeOtXQbeLW2vCJv+X?=
 =?us-ascii?Q?e2M1RhG6wE1wn+K22sBMi2fCELteSAQQfuSyvV9wDaMkyuuYXWYHA3EagTpN?=
 =?us-ascii?Q?xQzxEqGjIq1ZCu9Rf4Jytxwao7Z/V0LfkX++gTHkSAXEgv75NpHKS5zG3gWx?=
 =?us-ascii?Q?zjvZUbX3b52bL27V54kLhnIftEJK2Ms99GiRAVEUMRyiMB63kBT2AfYN8OEL?=
 =?us-ascii?Q?wJ3UhnKwO3/KCtMT/pQmXQkRfiXtNxX3oJXG2cKudC8LQqEJ7Rcx/GhucBWf?=
 =?us-ascii?Q?iuYeASHUrcvx9UV/tFu0JwMdb6Du3TjtE9Sx+VvV1ineLm9LWeIOEzRMndX/?=
 =?us-ascii?Q?hvO8X+se5ET2qlRqp8pE6YohsIPf1uXWQRS/HPZ6+WLJiQHQ36BHzlyRoYfs?=
 =?us-ascii?Q?eBRXWYnJ5rUfTy8SFVKKaKydn1ofGppSLGAvPUfm27GhfepKIMbAN+AG+ot7?=
 =?us-ascii?Q?0jGG2IZZn3I4D05IVLvc9XmrVrvAsrwPK+FFldVMMFPjbqrgIEYczTYgVqlE?=
 =?us-ascii?Q?jFRs93LXcp1LrOhO43KKbi4Q0gSJkR6WBIV8rqDwKP6MC7MzdyhfIb4nTEdz?=
 =?us-ascii?Q?u4ANDer8TK+dnsE6qDm4MRffKUhim0r5qWUQeCOMFHnFhvNMhjyTFt1Shrrl?=
 =?us-ascii?Q?nvIzNed2nwpHYnJiTRGgkInWmruT7pJVZaxWbIfiazr5wcJXDhjeosKlMpvG?=
 =?us-ascii?Q?gjDamm0L3lSoYgmrdRMj534vXSc03X+Us9WamWPu9lUa92FdalfEuAvzv9Xp?=
 =?us-ascii?Q?7TMi0jJ02H8VpmYXNKH0ZoX236HfUJ0rgtCTD3eJ8ciSNA/Va/zmW6iQp338?=
 =?us-ascii?Q?7IYK+g3AQB1/WteXTtDHMWBKKG2bnq2z7KrXacyyaX54lHLyimtrvWS8nUje?=
 =?us-ascii?Q?wU/Wa/gnpCgy2YcNTwGMdDnkmDB6T9vGA0dCIezisMZrvHLXLL8iCx6vYtIs?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dPeFeIQ/lfxQEkfoCrf8HPkZEj2fC2+AFsCEys02ZFpvKdP3INdwm7PUdCIXoS1MFULyqLfODE9eHHUVpddMgeMK89dKBIb2S0E7b48w7OH2UAZX+Gu/tqQwkHjBDsBN/U8FwGrMAj1V4bcB1PPwCIB1c09xV0GIUZUsN/k7GgCLl87YmRitlP3WmiAIWJW9Esv3gWjfrcoY6mlqyQjUGXPKPgJrZaf/ykxFVLoUZxyCvussyGL6HcOODoJD4smDhl9hIqeq4K0jTyVmkBiwEhu8Jf/lkgaBDZhudQPMnd40RPRYGuZdssRNmvLP4rNCGcGxB2aOFyb3q8bkXKAwveiYuORJubvOWWkzwHsh0Sa64sQ93SPBrWe7eqtJPVo/sLOYYNYcHi6wcwXiuZhAnE26tP/J2iBKj715+DxFyQaDRj8V8T4HMwDsh9hjagCmBaM+QehqXzPG7UTUsNQxLrEQ61PzhKzaxzUKuv4LporTa/otZDl2pri+M4tVk8o1/XDLFQkpuue0J7YY0TgfYw97RgeV9Ye1F3QtfJrgbPzCymnXFrwgfMPWmgC4IHgm3DJuGODMc6J0uyJJzbGqSfboUWDNDDjUkNzK7Px1n4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc280aa-e731-4caa-4559-08ddf52b2324
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:58.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we0oVtDYKcTtGPxJydFV76o7jgduFITbfj2XoSc1c3b9fx37qM8YgOlgBpZ9lHs2BULNw+ddZj7iETV+QdjHLbe0f6AK/9hxex9DCmDl38k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160132
X-Authority-Analysis: v=2.4 cv=F9lXdrhN c=1 sm=1 tr=0 ts=68c9708b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=CxsoVSIMbwK9moDqu60A:9
X-Proofpoint-ORIG-GUID: fB-KHcknhKUvlY-ehph2ir7WehYeVX0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMyBTYWx0ZWRfXwkeOh88dIXEv
 Sag/GQhcYgTBFe1Mbe/DsirK9rJLd6yic9W3jLbM6pfAECup3UTetGQ3RH77rw1MCRbpiqnrptl
 jCGgCptopSsomyBtbBsXuXKBjF+gDA8OuaoaeOe1vRASua0a04PKzQi2JS+fd2h2EYDX9evTOeU
 M7W57H+V3fw0wXCokboK88KPkKi/YBvopqYlUg/53mpw8ixkHA1fYaIUkq40nUiCmAy+MRLVKbY
 3tBXyh5m5BUN7cbPTMUnGlgpJsp6UMSk+FOH6ZipAsSwkf8zlkwPX7p4jK1th505119D7KJHV9l
 5DUlNqWICFiDKNmnMlkuFNys1ZGBxrdmpvI3fsyTG36WTLJH+LwxZE5MpSvxVdjiGqfu+vQ+WHg
 B9Pda7tN
X-Proofpoint-GUID: fB-KHcknhKUvlY-ehph2ir7WehYeVX0h

Now we have introduced the ability to specify that actions should be taken
after a VMA is established via the vm_area_desc->action field as specified
in mmap_prepare, update both the VFS documentation and the porting guide
to describe this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/porting.rst | 5 +++++
 Documentation/filesystems/vfs.rst     | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..6743ed0b9112 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,8 @@ rather than a VMA, as the VMA at this stage is not yet valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+
+In nearly all cases, this is all that is required for a filesystem. However, if
+a filesystem needs to perform an operation such a pre-population of page tables,
+then that action can be specified in the vm_area_desc->action field, which can
+be configured using the mmap_action_*() helpers.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 486a91633474..9e96c46ee10e 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1236,6 +1236,10 @@ otherwise noted.
 	file-backed memory mapping, most notably establishing relevant
 	private state and VMA callbacks.
 
+	If further action such as pre-population of page tables is required,
+	this can be specified by the vm_area_desc->action field and related
+	parameters.
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
-- 
2.51.0


