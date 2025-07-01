Return-Path: <linux-fsdevel+bounces-53458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7CAEF383
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 11:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF93BC8E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CB426CE1C;
	Tue,  1 Jul 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kzs7Md33";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zeVnx8kt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5D130A73;
	Tue,  1 Jul 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362761; cv=fail; b=egE+dLvTdPNBW2aExxhHypNv1kMLSACMOrAoeOIrf5NdeFVu1H0EEoBybF0jRDJ+ImzJy1SFHPvFmC+wN6gWQ+HE6QMDQZA74GZdf3UPLD7ssel0R/BDazlOLMI5ZeKwr3emeMgDjQtCD3KHV9ufWNIypuIbCgj5oFJYlQd91RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362761; c=relaxed/simple;
	bh=S6rOjlLH43A9hwJEbiwSgdry0Oz8YdWLDfR1Ck33b2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdKp4wds4DAG8/6NhzYkIRSE2/tPaezp3tHSZxZ1+olYioM6ukMVSPn1UvCXJU/elDiaA2iSn3zdgL3+7Q9iHOCatwMkRyP9mRlPoigJu8Y6Z56eNw73uaspCiAuNK/YTRD/PFGfcHTuc75tyS2mVl7HmF552BwknYoEZ0215W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kzs7Md33; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zeVnx8kt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MiVo007917;
	Tue, 1 Jul 2025 09:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VAyTM0mKkcEEy6ONAH
	jpwhQdYCegnmePejApMEBz7Fs=; b=Kzs7Md339kgRRH94g9zwEUzozhURV38WdU
	RfW3+qt5+DzWbPG0TphajKT8ECt5yMvIr4VdwApMHifRsSVHEy7UUXdZRVq3BPdS
	5vWK00n0RUDkYQX1qYO/mr9VhogJE2Z6nlqK+5ffUC0EA+lv4IZQp8Q2sy94jGTh
	MgAG+MGgPomf6nTnhzgb4mbDspBYb9X3JPvHS4RPn7iIROK67Oujz7CU0i44A2Et
	soKlRbGC+AN65IJDT9KSgAYEmXZDMLgimRBIS/KY71Ye+eyAaIh1tG51e9jJCaAk
	+Mt8pS2igpSv+pTWnndi70ZI7oB44BJ2mOoULq/ixP1GVMqhrnlg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx4c0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 09:37:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5619EVfd017486;
	Tue, 1 Jul 2025 09:37:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1e93eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 09:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3sBdXru1wxEzeHxPFTORkmZcGS6d7Ng4nSYmTqzO5z9bT2Du4q6Vlfegb3agl29Qu1CV5Ag/4KdlWTiaqWx9VGfmZS9UZLLPxPCuaagIODxNBA8/2HZtXmHPcQtY3iUniuG5TMkXctm7xPuQj3KaAPoijdO+Z//8V2JLjEamqhooNDwz9F3YNhVnx04rviNiGfH+7gNjtDObGGnTcoxddT+fpx4jQIoMuAKeknWgyovxFTMojbi0gtrmZ9l0RAUxCP6BiEJ5SxlL26bYmsa34gIr1NfCUX6OVvDHpVBchopD9+lw+tBeLLIaw0zyBvvZPKyOavBnkxeTwzcc1/L7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAyTM0mKkcEEy6ONAHjpwhQdYCegnmePejApMEBz7Fs=;
 b=IG/VjuxQyI5doFh4fana4/SgbLtYGoXofNfQL1Z9iAk+zdmYQSKRr0XmLAnZ1lfF+vrFR6RM40hO/CJK7bPdZI4nIFRb2Z3L4M2Co2d1KyNp5+A6qkQCcx9S14LQqsa/XPw5w0lDbZOylmfh+XnngtFgseprQ+UX87uHZOtIZWEv5J/1KC6jrZJktocq4KONsCz0PJV5EnLOXVNlB3RQKf5BXU7NKbyLZryfrPeNWXY+36iRk7hhxMYF2n5Pif93gpEB8aYMAMCCeDOXtI2T8oDEbUKA/eLXUGIN6i5/x7hCsFkZzN9zA62ugv1d9Xw0SRjErw4Vy1Y7heH6Oj29fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAyTM0mKkcEEy6ONAHjpwhQdYCegnmePejApMEBz7Fs=;
 b=zeVnx8kteeVMVZTXCEBPa26/t8d8L/lpWG6M7AaTGwAIGO5CSeVcVDOd3VKwaKWsNXxozTEi6PhnKRLDSTunsWhpBtdeyjlbUrrPwGGC9gCPxCS0lknQMeZLUU0F8WtnM12IVAnStSHkge1Km6R6PKOqV7E2TzZq+rasJE0KGQc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB7740.namprd10.prod.outlook.com (2603:10b6:806:3af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Tue, 1 Jul
 2025 09:37:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 09:37:37 +0000
Date: Tue, 1 Jul 2025 10:37:34 +0100
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
Subject: Re: [PATCH v1 11/29] mm/migrate: move movable_ops page handling out
 of move_to_new_folio()
Message-ID: <7bd40318-e1ac-439c-8e0e-54b1a168ed24@lucifer.local>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-12-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630130011.330477-12-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 29aa8f91-6faa-4e13-e008-08ddb882ea44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJ56edqrpqOS0xNeAN/XhZui+Xf/rO/E/EOeQCoUgUgFF16OFHB/1OZ0Ct3l?=
 =?us-ascii?Q?zG1VmRZv0awb7oF6NGCdDyjyaHzatn3qgL8Ai0uTPLJIELwHagbfj0sIN3/k?=
 =?us-ascii?Q?nBBni7fqKk0sc1aouULs/MWVmAmjYgxM8RstM95BQqf5HBp1ymEvOVLqU2U6?=
 =?us-ascii?Q?E1bmT+vGzHXQkWlCYXHNOs6u5wrqYNn0wEvJGtAVJILqjRNza/Gxg6z0nN4i?=
 =?us-ascii?Q?TfMzIvXaH96VLoUNXZxFGJd3/ch2wZ5Qi/4P5BR3ZoeWeKT4+fik1g6ycE2Q?=
 =?us-ascii?Q?Z7q5cLhhX01jLht2rMeK6egI39SHgbNZk1/0+eLYPauL1d+1NiUW+U2PpxK/?=
 =?us-ascii?Q?hiQpYeTprG2ppoSDy0GPS5x6RDsT6yg8p2+CdRyB6+qNWyQ18/sagH8GRVPe?=
 =?us-ascii?Q?fyPDUpouxnEy6PywzIUasXYrvPYCk0Eorz4uLZB5OeT41gwwBAohw/idLPw9?=
 =?us-ascii?Q?dDKqAs8hUS1fmqyItCG9P5QZZHTsbmvm8n3dpx5KWbj7PJP1352iz0o4BRTG?=
 =?us-ascii?Q?elj1pwty8M8TIFL+z3VTWcvB7/deLn9b+3WOBoCtCG2D4pQoXVEDeXYsux1W?=
 =?us-ascii?Q?MOpxH5slN2Nna/wNvSiUtFl/eCXXcMX1o4HdUCfjK3zIdyr/sCoY7fDU3eMc?=
 =?us-ascii?Q?KlpcU2yddf4Gq6MTWkREsJl6Cecc9cjjUEKZPiL2/5biqxSAUvVMwqEOTEn8?=
 =?us-ascii?Q?cCnhYRHlpW5+JVWZHFEV5dUBFd4qYKuhJiSC9pFY2anm+HHWS1M7sUilWyuh?=
 =?us-ascii?Q?NFJ3jc6DjJyP1jiNJCvN09cO+l7NujrjAjaTgsfuPmh/1J/9huTQ/whC9kGz?=
 =?us-ascii?Q?54y35XelI3y10Sgu8saod09RyACZV5XCrnyEXqR1HvC/CWmRvKcftOcOiFkk?=
 =?us-ascii?Q?494qnFXiSu7UMz4E2afzbIaZO/JvX96zU12LLruiw2llMKdEolwIZwAhe452?=
 =?us-ascii?Q?I1FR+AcgHaER8hdIgT0EVMN0NQNl6IiAXBHa6rOfbVsWkRAwKrea88WTHH+i?=
 =?us-ascii?Q?r+ov+1IPcyW913yWGseKM+YS0BXUSrL4kDhY9ZawaaiVM0iE/TRRyYBP26q3?=
 =?us-ascii?Q?Su2TjXbMbNd7K+jX+1bdZmUiNuhu6S8V6Tkl4wQVtaU0bNa7OzpdLKYjm27I?=
 =?us-ascii?Q?P9AKPbjHfBavch2sNSpH/npjYTD2gs/nZW/FnDQy3V7pU8S4H9R/jhccLHi1?=
 =?us-ascii?Q?6VxUBdjhGzjNkn6QETPoCUh2vco5/6+TTgzHMAMemgf4D0Lzp7ApeG8bLRCx?=
 =?us-ascii?Q?l0qI6uJElcrgtwzmfduTg2T20L21FBKIDup4QEDUoJnCsXyiRc+xhmjHK2NM?=
 =?us-ascii?Q?e3lz1daWEw+l8vt51QfSPAgt+7WZuA4Sczq/pSlFRdorGK5ClgGCiVb3KLTG?=
 =?us-ascii?Q?FnMbh5e55mtJ/3fjMi3pZQQfTeWAZwUIlTPZLJQLMDDZwcWWs2w4CXVaZWUu?=
 =?us-ascii?Q?HsXPDTXuz24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2m+gqFmw/CzPV5q4VN3EQwUFnDJE35HFijNw1aX0lBY06Eayh/L4tmvTWRau?=
 =?us-ascii?Q?alxOgFaXOS57MyhnWwVQkF9ke6JX1WKfxnfrghXjK4Bgkx/DiEppV+Z3OQDC?=
 =?us-ascii?Q?QwIRiMegdF8YkCuad0ksmqMtqj377etolrLgNaPw24X9N7iIEbRFS0kRhS0H?=
 =?us-ascii?Q?DG4qmg6iqksihXvssB/fK4lClWjgasBmyBW/1azdz4UVDoKaiNl9KJm5St0P?=
 =?us-ascii?Q?H5FplaP0pwVnjXb2O/mrgPPwZtKY1uN0MtDmyrxCeSSV1/O7xkCBAxmuDA+k?=
 =?us-ascii?Q?JyRWsu/HDy6a1pvwrK+5xDjP8zrhuRwiVD/1/EJstRWTBwuQwL2f8bGdYS6V?=
 =?us-ascii?Q?Sml1v6733oOhmlvMqnw79B6MNR1HeyqZLGvSw7zeba//45n4ZMc1lVPOm+hK?=
 =?us-ascii?Q?mvI/GD7Lp0UaPSb+Qki1U76kJmiFPep3HZP8c/wx0ckYrhGbL4QyLR7V81/s?=
 =?us-ascii?Q?I05cXlpyUksbGyCdHEQMmBJudS6fBANVL3RxzzLnjzlVZsMWu8Ma9x18VSn7?=
 =?us-ascii?Q?83dkK7ckCj8wVVdOpeQCLNb51Ec3ZmALaN7RraekWYC2+U+LESj+hQRqj0RK?=
 =?us-ascii?Q?ibWu7szcvcsJ6KhY90iqVPWkm8TvKeUIp9ddxvDRurgxnPEtvbfY1Y12nIxp?=
 =?us-ascii?Q?UlDHfOk1bV+3CemCDoehpPa5RxCoOD4MVCnxwqKv+Q8l86DoXyFKKoKG0Wbc?=
 =?us-ascii?Q?HA9oJ5y0svm5uQyuFRxYeOBroTuvSfFeb/ZRgz7idO431u4O6VI9G73/uCBg?=
 =?us-ascii?Q?wWspLzCjF/J2mvExaQVe7ZdcnSXrkeZULx9YOZXu1fKS9XaOj84uo7s5koJA?=
 =?us-ascii?Q?IO4dbY7sEMgQlYwZgMgq+yAcwx8Wp6esG34JHQaVLK3YAxVzRYjsrzPzzGkI?=
 =?us-ascii?Q?n19vCJ/pjhrQFxCfYVM8jw0ugj8ZI0L9LXH3wiu39jAGDYokMxQZS0IsbHVr?=
 =?us-ascii?Q?ae+rOzrg5POZye07EvtYyeEHPMSMB2jjAfIxjYviYP9oxflEk9xSvSnRQsHQ?=
 =?us-ascii?Q?KBE9z0gdcu5cqfgmLmmztfn/Fe/UrVqLsIY0MTZEKPYJ4c+wlp49nQMi7JnO?=
 =?us-ascii?Q?m995RiQW1BA9naFZm2HBWD4Ed0QMEhbc2qFazSFFmVkD/JujYB4NqoyPl7hb?=
 =?us-ascii?Q?TcLkv8+rn1qInDt3cMU5CeAwrfoRlJMSLW1IQR+QD/zHZiEJZMhUQnj0a+Rb?=
 =?us-ascii?Q?7+pHF9ef7THyx5UEcrCZwZtI92B3koIgkfO8XUgVdsBwKdPFA2blV0y3ZStm?=
 =?us-ascii?Q?ycRffwmcO4ZnaNaOlwVXPTt7VkIoO766MB6d0I2xRhdbnTVZl1G6ep/rl+R1?=
 =?us-ascii?Q?JrMNG86HJNN653XvsYAMMiP50jAte+ILuNSZ4KPck3V+F8u9Me7X0whmA21n?=
 =?us-ascii?Q?FX2V+EnI51BT497EL2Cn2lXapnd86OnwGskIQcAuvMjgbK2Q98Ku+Sp18/Mr?=
 =?us-ascii?Q?sib0pAs6P6BCY6RVJD/GzIQCHnnVj2NejmcaHjrqwnQVtz7XVIpP26W6KThs?=
 =?us-ascii?Q?QkJrvttcpOIpWWAD9/MMQilbf7AiUy5xe/XxkbXnpB+dnyjy0q5qGzdj1s7W?=
 =?us-ascii?Q?1MBt9DXzpgSN9g4iWIAS8Ch/pEo6pt4nkr2F1Y2vG8H4QqjQk9n3d/WUkhEI?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UbizuV0xD3ndyQb9OZrbMyFY2++VE1jb5D+2/dz5JqlcJIXIikl2pKKYo9yozG6qZAy0n8OpezBJ3ltUSLwGdPgJ0kb4tky8ABiwkS6r+f6VLEr7hlZBJOjRKOhD29WwxB5mxxheC3+Llt9CLZce16jy9L9a6rYaf3ZfOfgqJShUfEa6o7jN9EiLN+CgH6ouhUXw8VcFYNXB/ZQJ5keFoXKEm5HA76ZwVRotIYmMNJaW/kVmOZcNQew4hDf8UAkppMXyQOSu1GHwsFPMHJsx4u8O89b7aA5Hr8bz1/pwy9XjGMu3qTElHN0FaT9ZWdeY0sJKZ6A++Jk6f1A+uVAi5hg/dHhb75WircDBgHPJDnEfmXtnajAQHLg6vNG9SK0bfTOIcLXc5ccbtmDbbff3WVC82c0E2uY1+c7XriwP5PDqiZLFQUjZSrj8hzMOo8KdwaO1nEkuxxN6D7jYKmPYJy2s/XvRVPXcnIVwgU8uotrVxqFHE5hcF1ZGQNNT7XQMZXaEDrQrlqmAD/WS2BZdpN8Bi1FIbx4t8jzjeuL2Ye98fQZnWar7ArhmWj14nIxUuzEAURwXxWeKIOHsp5fbL37CuOYX87oQXKo6ySAeAWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29aa8f91-6faa-4e13-e008-08ddb882ea44
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 09:37:37.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRDozNmot4wFs2XD+q1ju3f4zfGiHtVXG/ySpo0Un6qVJOmzzZcQViRX0x2njYgZYRpMZi5eYEuTcgqkB3UtkIteDBueWfL2sskQfZwUwK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1NyBTYWx0ZWRfX1xaZdMP3g2ck xyG5dmGoYKgtN2MegwmVfQTtyeumU9EiI3T4Cncts0XO2MDOQ8DzwrLLqyBDNy5FJhnmju37x7y jD5Vq29YNAFZRWCBMobqF1Yxic2+8MXQ6VucEh/y5ig+hKk3j0/rsa7PDPu1uuRhUuUy7BkaP2b
 00WUv5tvqLEoXSp8ya7MhKDR4ZrbCtnVCJAj5SudpojYZEdqN+lVgnZJh3PUfWD6QkRl+pOkmzh ZYjCT+Yl1CsgoWYRP7cz4NLDGs80My1JZKh5Iyyp/nZ6+3+Nw3y5lMniYFnF1TIzOLy2YMRV2/7 iup6zkbFTWONOy1feynJwkto1PnhfD7M7+3iFciNOE8ACdBWFhIZMe7UawWac8F4XAAZH0KY3qv
 DO93sukAkzK/e0NMfOQd+279QuNyWIkBWnh/3qdN+YSV7e22PChaPapKc3fhXwYncP4uwSUW
X-Proofpoint-ORIG-GUID: HViDn9Z7sOlhRB6Yf3QKLT1IiN90PRXg
X-Proofpoint-GUID: HViDn9Z7sOlhRB6Yf3QKLT1IiN90PRXg
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6863ac67 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=wV4putlMgOLdhwAISS8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13216

On Mon, Jun 30, 2025 at 02:59:52PM +0200, David Hildenbrand wrote:
> Let's move that handling directly into migrate_folio_move(), so we can
> simplify move_to_new_folio(). While at it, fixup the documentation a
> bit.
>
> Note that unmap_and_move_huge_page() does not care, because it only
> deals with actual folios. (we only support migration of
> individual movable_ops pages)

Important caveat here :)

>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/migrate.c | 63 +++++++++++++++++++++++++---------------------------
>  1 file changed, 30 insertions(+), 33 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 0898ddd2f661f..22c115710d0e2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1024,11 +1024,12 @@ static int fallback_migrate_folio(struct address_space *mapping,
>  }
>
>  /*
> - * Move a page to a newly allocated page
> - * The page is locked and all ptes have been successfully removed.
> + * Move a src folio to a newly allocated dst folio.
>   *
> - * The new page will have replaced the old page if this function
> - * is successful.
> + * The src and dst folios are locked and the src folios was unmapped from
> + * the page tables.
> + *
> + * On success, the src folio was replaced by the dst folio.
>   *
>   * Return value:
>   *   < 0 - error code
> @@ -1037,34 +1038,30 @@ static int fallback_migrate_folio(struct address_space *mapping,
>  static int move_to_new_folio(struct folio *dst, struct folio *src,
>  				enum migrate_mode mode)
>  {
> +	struct address_space *mapping = folio_mapping(src);
>  	int rc = -EAGAIN;
> -	bool is_lru = !__folio_test_movable(src);

This is_lru was already sketchy, !movable_ops doesn't imply on lru...

>
>  	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
>  	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
>
> -	if (likely(is_lru)) {
> -		struct address_space *mapping = folio_mapping(src);
> -
> -		if (!mapping)
> -			rc = migrate_folio(mapping, dst, src, mode);
> -		else if (mapping_inaccessible(mapping))
> -			rc = -EOPNOTSUPP;
> -		else if (mapping->a_ops->migrate_folio)
> -			/*
> -			 * Most folios have a mapping and most filesystems
> -			 * provide a migrate_folio callback. Anonymous folios
> -			 * are part of swap space which also has its own
> -			 * migrate_folio callback. This is the most common path
> -			 * for page migration.
> -			 */
> -			rc = mapping->a_ops->migrate_folio(mapping, dst, src,
> -								mode);
> -		else
> -			rc = fallback_migrate_folio(mapping, dst, src, mode);
> +	if (!mapping)
> +		rc = migrate_folio(mapping, dst, src, mode);
> +	else if (mapping_inaccessible(mapping))
> +		rc = -EOPNOTSUPP;
> +	else if (mapping->a_ops->migrate_folio)
> +		/*
> +		 * Most folios have a mapping and most filesystems
> +		 * provide a migrate_folio callback. Anonymous folios
> +		 * are part of swap space which also has its own
> +		 * migrate_folio callback. This is the most common path
> +		 * for page migration.
> +		 */
> +		rc = mapping->a_ops->migrate_folio(mapping, dst, src,
> +							mode);
> +	else
> +		rc = fallback_migrate_folio(mapping, dst, src, mode);
>
> -		if (rc != MIGRATEPAGE_SUCCESS)
> -			goto out;
> +	if (rc == MIGRATEPAGE_SUCCESS) {
>  		/*
>  		 * For pagecache folios, src->mapping must be cleared before src
>  		 * is freed. Anonymous folios must stay anonymous until freed.
> @@ -1074,10 +1071,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>
>  		if (likely(!folio_is_zone_device(dst)))
>  			flush_dcache_folio(dst);
> -	} else {
> -		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
>  	}
> -out:
>  	return rc;
>  }
>
> @@ -1328,20 +1322,23 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>  	int rc;
>  	int old_page_state = 0;
>  	struct anon_vma *anon_vma = NULL;
> -	bool is_lru = !__folio_test_movable(src);
>  	struct list_head *prev;
>
>  	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
>  	prev = dst->lru.prev;
>  	list_del(&dst->lru);
>
> +	if (unlikely(__folio_test_movable(src))) {
> +		rc = migrate_movable_ops_page(&dst->page, &src->page, mode);
> +		if (rc)
> +			goto out;
> +		goto out_unlock_both;
> +	}
> +
>  	rc = move_to_new_folio(dst, src, mode);
>  	if (rc)
>  		goto out;
>
> -	if (unlikely(!is_lru))
> -		goto out_unlock_both;
> -
>  	/*
>  	 * When successful, push dst to LRU immediately: so that if it
>  	 * turns out to be an mlocked page, remove_migration_ptes() will
> --
> 2.49.0
>

