Return-Path: <linux-fsdevel+bounces-69457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA46FC7B80B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 20:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B58134FC49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3592F99BD;
	Fri, 21 Nov 2025 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dKAaVM//";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wEJocE9E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A899155757;
	Fri, 21 Nov 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753071; cv=fail; b=HAMnhgNQnPdI4kZtnQLw3Kinay+Q4VeRq+kJD58r9suRW2bLiLmBSworru/e1d6xm2apZ70Sm5uLXLaoo62/mTS20fUDTEUOwyGDj2zvY8uUX/kN0qFDELDHNi8avjTGPqgObqoUmYIKKOpKT9AoAKCo2Y8X718F4lrxH7ud+Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753071; c=relaxed/simple;
	bh=oxbnwVrh+wHc5Qx+DGqojISj5xCdyZl6HUDrI5I2l38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZCLPuofCRDxkcg8W+PKIRKqhjuPJ4WLu0w5cK/2uZSwV8vuL955PXYCp3ci74TGhUM25EGxySGfE9KuL38Gt52fJC217s9Vw1x11pAiwyppFmn51sb7GguDXc4LIrALE1rh4LujdlYC4XxyS5J7Ay2erDEl10bvexmV4z5q4ptU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dKAaVM//; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wEJocE9E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEgmVl027975;
	Fri, 21 Nov 2025 19:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=itcg/Vi6yyJZG1n5lX
	tc2QILAlGcU8Z+sDBKQQM/1Gk=; b=dKAaVM//p1kI0Io0ccWNymMJlB81C2tpZA
	ngHUid8vN6/lxAOkzjWbCKUDyQPliv9e+5XIE6iOXkqfig6AL8WJaJ4cVsMkKbKf
	pl8qGOxEe30GnWL6O87pXPbFBFPu7WoJ/wDxwLroJSH/SSN4w3H5BkXoLXHtszdc
	HgPoTY1ve+OaWTGid26MtVVTIeHUfsAnF84jmLQG5Lu+zQ9XUaEhiPqMtyFxbkFs
	7lmAP1plzP9gCMgf/Sgiea6LpFwTRZdV7NXonMr8n2p5O5B4Dqf6fJIHJsyiQRn3
	cB+dgfzizHGlLgl1lbGHlfe/xmg5reyRayD6w3+aPs7dbpD770yw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej96c8bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:23:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALIHqJL005110;
	Fri, 21 Nov 2025 19:23:23 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefydseyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 19:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmObPST5YJgZJvrMgpBoxBTMIRNfqYcWVsIHmYDJRq3Eo/NYSR/Qj7y+07rk3mLZ8rCHEhB+EUA1LG59B9Grpp9XYlIfk0IBDjBVu8YUEGotgT3OpiTQYtKfnSKl6fXj0SJdItWVNdSgC98flDkIblz5WcLdhLyh4057tPSBHdTEFXQ5Yvd1ZV8Te3hHc6BrFa7CwlJy7UEjDa8R49LRNPeK4LE6RFHJzVqv1VsxTj2ccX7Rw649a3z4dZAGhBekxPABFRG6v/GR5Qp+RjKKgSEiC4JO9xRfD1gQTDopjRMFn+VvkC4q3xH3tlwj8fz/JNuPqYIbmj0GKFMaLBajPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itcg/Vi6yyJZG1n5lXtc2QILAlGcU8Z+sDBKQQM/1Gk=;
 b=hwcJ0epTQQkycOeyR05k4Om1snBx5XerMhw34lL7Rrnz4zGy0TcKZPYGDf8SIMF4EBu3fAh49zKuj9OEqCaBs4bpdyb1kfr7qM9aJ3kKRXCFYaQQ/sCQ7X2Wp6crI0bC7QQPyK7ZQ5NiA1Vr3ce3TwJTnzPx1wuzT2ImObuPFqi7blRv+TcymDtKIa3bmy8y/3dSIQxbz9FxZCNkKoAXetBWvjzcTvvAavbJZTL55zbRluK4OLFo0XVXOpZ4gnZiFlYZCnkho/xWL5hMXXsPME7ua9w93hm2h3uojw6VWVmMq5N2iTGIsHvu2Cf97CIKvJp8C3ddkhFQGbcqWNkw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itcg/Vi6yyJZG1n5lXtc2QILAlGcU8Z+sDBKQQM/1Gk=;
 b=wEJocE9EknuHaO0QvoDgCpKbe5tB5PXz02PTDHkLvof+jFKv76zwNV4bYJPuPcXsF0AJiUW3MH2W3KsLZU9sXVJktcEixbXWW75YCtIEr82nv+tHspGysbxgd5r2igzzBQ4Wb4fkHa6keNeHpONML5tWqOTy/+DG62+BEvvwNLg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 19:22:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 19:22:44 +0000
Date: Fri, 21 Nov 2025 19:22:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
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
        Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH v3 10/16] mm: replace pmd_to_swp_entry() with
 softleaf_from_pmd()
Message-ID: <0c429a7d-cc12-49b6-bc71-4b219683743c@lucifer.local>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
 <3fb431699639ded8fdc63d2210aa77a38c8891f1.1762812360.git.lorenzo.stoakes@oracle.com>
 <68f18daf-cc45-479f-ac6f-0b4dce153ea7@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68f18daf-cc45-479f-ac6f-0b4dce153ea7@suse.cz>
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a6725d-92ea-4c14-ff57-08de29335902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZYVGsgnZlPJvOWHnsNys2k8KmgtLKLK4YreQZeW+kSL1IMsdwiscRltzN2kg?=
 =?us-ascii?Q?quSHc9atQAjQqH7w9qsaP+k2LtmdGm+4XClxnq97AKhs0taVnxHCVG+X116w?=
 =?us-ascii?Q?aAUVHK7O/8neUOZBEta8xPWLVd+Gftu+xSfPQubS6XneGe7ugZ71kL62/ifi?=
 =?us-ascii?Q?CEzvrI/dgqo3Q5Whjhj4jEVxC8oWa5lL4G7LQmhsc8XtRve3RZBzQwL5bNXP?=
 =?us-ascii?Q?a19NvNFDCKHKmLne+saD6DgZNJpemRD2w5IlLFHLMUszloGYgK16ZA5oF87p?=
 =?us-ascii?Q?XWeyEoVQdQwhT/GIsAlUvSfEmiwHX/c92TDud9SWzUHNAIo+ea4zT3r8Grxf?=
 =?us-ascii?Q?oZW3soHXqwxS1vq2xwOQQs5pySc9EK+OnrCv7aofOvbJVD30EFfYt/ybo+CL?=
 =?us-ascii?Q?MzrG1STwEwnfZ//pVY3BgcviAYveGuplFGiDKechQ2hE1aCWjOECEjev5fPO?=
 =?us-ascii?Q?+RD90rkm/MWyqNM2YIAexs3yXFCGDW09EISOoFEpC23VKzWbxSlt+aFHb1+O?=
 =?us-ascii?Q?WgFJ/BS48HssS3J+/w7l8vV3rSN4g2i53RQyXT+viL6g6KfREf0vV2prlKQO?=
 =?us-ascii?Q?RrTo83Cl3rbuCdeEWzpJXR5XOXQagZtRBPJQbyFOe5wawpdYqHW/uab5sOWS?=
 =?us-ascii?Q?gszOOiuG4TgUECnoNts8BTMsVP8+bfdQ7PiAWRlvDtiTVu/qBNnUIMg1fv6F?=
 =?us-ascii?Q?ApYO18cIzgQB0t+27aUdqudG3ggenYdGKZV6PsYhX/6jj7Zu6e/fPWDHCEYn?=
 =?us-ascii?Q?Xw4iURcjUNr8oIpwaQ8G38UfaQe0CXo+3F2N8jPMmJlys2HsQ8aR+6+wF1bQ?=
 =?us-ascii?Q?C4laraIB09xKtPMAMMsEUSquHL8rUpzuZ8pWKG1wDhjY4XiyjHkOrwhn3Z/Z?=
 =?us-ascii?Q?rlqrV/mW0OKNMJ1BiRGerV4tl+wx1+HLu/q6SH7dAuoBZy0QreCIKa6KP5Nq?=
 =?us-ascii?Q?UjRDwPaDtkdyRMaBroWlOTwrTGHkIyhbKtRQCG7hx9penBtZwITTsua8Li0X?=
 =?us-ascii?Q?KN/tvsFSLfXw+j1SvP0jGKhy59PV8Vq6zuEPRJNodvQw4yZubdN2LO/KOOY5?=
 =?us-ascii?Q?Zh+633qDHacCpC9FnOQTKVcq8iZluWSspAr8YSOOq6LuskjHjO2QMSGWEIFS?=
 =?us-ascii?Q?yJNsqLZrq9FraFFWZ8hha9vJHrbxoqPRw1eoeUZ9j9cvZPXi6hnMzcf+Zdrt?=
 =?us-ascii?Q?j2UNKgdXuKwqcM/5lAZLy4nyMbvhUoE+HPpytlKrEoJ71jhm4xYMErJoTTXf?=
 =?us-ascii?Q?wl4BPUSxFPMIwCmQI2NYe2njdWdobM3sZQFDG8xpGZ7go/Z/qfFPE6RztzDG?=
 =?us-ascii?Q?bDYaC07vu+OknBWq+ACFiGQne06A3XT5fG57+SI6R9cRSMDCwdrPNzj5HYUw?=
 =?us-ascii?Q?TJNNux0WqZV9WAqi6lsnUeHFToDBEaPUSs54JRkw6y4+3tTj+vvDvvuDgcf4?=
 =?us-ascii?Q?QMIq7LNp9fkTnLhw3kE6uSWNza0lSuM8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ygaPl0qM1b3cXr1hC1xtAFcvEVetgAJFbl96OUQrwPDlgdUyIRhgYBBTvCfs?=
 =?us-ascii?Q?oYss0AFsGXYI10/f9Nbj4xsnoDkD2C0EJmQQiDVR5IeNl9U7cQgUfauyk8Nc?=
 =?us-ascii?Q?BaBxx+voprsO+3bR4pEAEIjZFucKBkF6ZO2LABHZqaCIqU0WWh6MYCRuFsXM?=
 =?us-ascii?Q?JHFZi92lXHvbq373gcjX1ofz+408zrjDtDIwCd1KPgoYO80Xsxdwo6RzLkFd?=
 =?us-ascii?Q?yyDyH3urHCMN0fqif2WhSr9p7CL30OAbaNbx8EhswpU2j88DVgg2ceMMY768?=
 =?us-ascii?Q?byCpf9X/ULaUVD8l1FIjf+kX0r7OOgAl341k2ARGFAnfyHqMFlXm35XfjllZ?=
 =?us-ascii?Q?iNKCSrI8RPhRSRUP6mIA+Ruzh9JaNWe+I3w3IonFm77JKz8Bv6CjsHx3maRb?=
 =?us-ascii?Q?mOxZNKtFIouvfN0gpjVhm6nDCkyOHy0hCjYTCIa8GXikoNJuLgxhvMJrJKTY?=
 =?us-ascii?Q?RhK3cAKnWLQyyg6+VYQiLytrBctSrekN96CPnE9QAG/PUOS5DPjvUoE4l05C?=
 =?us-ascii?Q?eJTvbS99xtrclN+wmfxqkARohqo5+ox3a63+bV6EfInfHdKA86q/Dvt1iHHX?=
 =?us-ascii?Q?S9C09e2go6ecuSXLVxEg1hZeHz+PJ974wo6b+05SgINZyRRHv9CkV8+4kSGD?=
 =?us-ascii?Q?Q8cKvTmHhrq7j0IyDMF+fnOP7ZdC9ObwhAA6XI8brhQ5h6o0voXh7d614h5M?=
 =?us-ascii?Q?GVMqyTuOIdkXDpSAqUCF90D86JT5AUbF6gWhQLEGs2BsEGOfon3FgGeib83J?=
 =?us-ascii?Q?i5j9aBDHMkEAzsfVthSz96C+mzaxJ9ragdTodLHg2u8sCVs8aptp43ZEvDuI?=
 =?us-ascii?Q?rdzSOERfVeAy/W6cGYD5lBl8n44A+it6yUQd8wKCNKVd45FJIKj4/bds8aEh?=
 =?us-ascii?Q?Aei9TOSgi5KUjFz61yAmTJw4cl5iuOcJNwo2o1y0bfx2nNQQzIr+TixIRPg9?=
 =?us-ascii?Q?V4h079y62xKwZle0+u7u1DWlBlDFlMPMrTLiawK3UFMgCy5Wj6+2uWTHdPUb?=
 =?us-ascii?Q?YWQFvly1x4NdrCPqh59japjGvbt4fWt5bW324JG2AGvye6XKVHex3CF05tOm?=
 =?us-ascii?Q?/ew9ZF8HNz2yB/GWwb/LKG2g3YWE6wQYrJkoTmAvxNxttg86p3zD0NpSg9B2?=
 =?us-ascii?Q?IqH9QO3frS8sCLb3B6c1lgpI7bf9cuiZBv1xnWjvvilQNyR7G2rzYSQwrSfn?=
 =?us-ascii?Q?dSq2k75ZPCWwwXpslIasrZ9OSu4V3cDhcsmxV6unZA7DYnZWuA1LNiyXAkC5?=
 =?us-ascii?Q?TLWUkWDkQtzuYs4gYkqn2v2GMYnBOmYeljd0HQkALMAu1EJC5SnetuTf2qPd?=
 =?us-ascii?Q?EgLrO2fOzQTQKKQOP0qxFmYviBUeAn97/llIMdq+pl0jTJECHJgDGJoaOs+L?=
 =?us-ascii?Q?0YXasqI8KYUvc46uXEEtO2fzm6D6zqR2n21D/0H7qtY76eQRAYPH3/oCOzTL?=
 =?us-ascii?Q?inc0/ndE765GtN9QjeM3L0s+NIJ9XrROf/6aZI6sDGqFVxnMy6sVV3ISuoKA?=
 =?us-ascii?Q?9ApFljzM95RfAH+5KgeeouwxUTgAWv8oghEYSkGVE0UMpJEqmC4SXaCIAwDd?=
 =?us-ascii?Q?edd5CukKeBEt+vKsNg49/ex2OZ1p6HaMC0RXXlJNu9i/MWmwDkxKF9lyaXP7?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9i/GE7fRMV3KMtLWHeJ5/GPSrlm7ZEJ6anK4s0tM/u8aDJGBkTeXxB5RqrX5987p7HZudKW4j0pvaQu5lNL0Fo2sQ7LCsi0d1HTovUIq+3TAX4oYp/inv04sxGOxLoEktKM3R4yHQE4J3x8EV6CNzQHnlcUtsypBYtLWzspjWq0uegKsxzTNQXXBIovjQtjBgjoTO+QIB0yMku1WEohVhkc8z5s1kbkDW47KI3D6/axyPz/JntdkyhEUWXZ3avMc6kFz3xCpmulFVTHvdCepePuR7WmhQCvFEZkDY3FwE3WLp7ywcOox1bQmxmAE8XgOu1ZiEWMxqq3sTXAyvLjE3tgQqxvlrrm/ciN16cSK/GdqmMgOnVJX0jVU+pz9kkjCsqwFIAtxhiSV6lahTE993lmwrVCr49WgFnojH/L0KeIcmHQhJijVpGSUtp48j8kTxGcDPpdHQbF9n9zpHYEuxhXASwjNOBrpInH2bH1BTAb8XhaEAc+ZCptf7FFlwsIahqE5briLIgdpkwJX+lPed8GoSgkbkllBX7jMmvSTQGdXwc1oGzEpbsgoNtWQWmA9YP19NL7Pfc2MGrsEXe0I5ZXsbqqhpBN6ZlOpc4uV/QE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a6725d-92ea-4c14-ff57-08de29335902
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 19:22:44.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qB0rDGItDgygzZDJvd16PRaZXhVDh+d/RxJYe0CfzoX6XP943AycITwPjJ5TaEKV+8RrU1jxjd2JzYuY6VLKT4qrHlVeUSdX566TxYKr/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4722
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511210147
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=6920bc2c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Mbr5WjKDFZc3idkGdFwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6_6RF7ZwKMfMYcnhFJ4wm3-0QuXf7w5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX+qjfnqz1KG6I
 /OVLgr/UFz9cCfa6neMo46Yrivm2Bx3kiuWRAZb0kcFCdXuD+s/Jot032F0Yi2aY4eYGc5DhCM0
 FIiCdjBaLaQIXFQPSpt8Zztr9Lumci6BhV8+bTYa+QogycrXPiKFpuAdlZKghMj2qhA2d5Kcg1F
 OtQUtriGytcyauysYVmXqO7p1PLZVFrrqUiv45f7YkEhf71VR8ZPTfJEy4L8xLv801tj/vWEFGg
 x9t5+7tcbOYj94ej5SHiMlsURIA212Vr0P9t80S2Vtvz+SDtwQbCkA5GUevkQhmFXzVgo9RlYD/
 kQqJJ3hBO1B4b6oGKlvX2+zzewgk7Z8yDnHRN3O1yhRnPcudR/UFW8vCxZfAf04p4+NdxJdn0Ye
 tuN2pg0uGSH6FYpvFRCk+byFg7rAOA==
X-Proofpoint-ORIG-GUID: 6_6RF7ZwKMfMYcnhFJ4wm3-0QuXf7w5h

On Fri, Nov 21, 2025 at 07:42:50PM +0100, Vlastimil Babka wrote:
> On 11/10/25 23:21, Lorenzo Stoakes wrote:
> > Introduce softleaf_from_pmd() to do the equivalent operation for PMDs that
> > softleaf_from_pte() fulfils, and cascade changes through code base
> > accordingly, introducing helpers as necessary.
>
> Some of that is adding new pte stuff too, so it could have been separate
> patch, but it's not a big deal.

Yeah is always tricky to figure out how to separate things so tried to get
a reasonable balance :)

>
> > We are then able to eliminate pmd_to_swp_entry(), is_pmd_migration_entry(),
> > is_pmd_device_private_entry() and is_pmd_non_present_folio_entry().
> >
> > This further establishes the use of leaf operations throughout the code
> > base and further establishes the foundations for eliminating is_swap_pmd().
> >
> > No functional change intended.
> >
> > Reviewed-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> Assuming the below is fixed. Glad I could demonstrate I'm not just rubber
> stamping all this ;P
> (probably missed stuff anyway, as usual)

:)

>
> > --- a/mm/page_table_check.c
> > +++ b/mm/page_table_check.c
> > @@ -8,7 +8,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/page_table_check.h>
> >  #include <linux/swap.h>
> > -#include <linux/swapops.h>
> > +#include <linux/leafops.h>
> >
> >  #undef pr_fmt
> >  #define pr_fmt(fmt)	"page_table_check: " fmt
> > @@ -179,10 +179,10 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
> >  EXPORT_SYMBOL(__page_table_check_pud_clear);
> >
> >  /* Whether the swap entry cached writable information */
> > -static inline bool swap_cached_writable(swp_entry_t entry)
> > +static inline bool softleaf_cached_writable(softleaf_t entry)
> >  {
> > -	return is_writable_device_private_entry(entry) ||
> > -	       is_writable_migration_entry(entry);
> > +	return softleaf_is_device_private(entry) ||
>
> Shouldn't there be softleaf_is_device_private_write(entry) ?

Ah yeah you're right. I don't think this probably matters here in practice
(as in, it'd probably be a bug if pmd_swp_uffd_wp() was true but also read
device private entry).

But it's incorrect obviously and a mistake, will send fix-patch! Thanks! :)

>
> > +		softleaf_is_migration_write(entry);
> >  }
> >
> >  static void page_table_check_pte_flags(pte_t pte)
> > @@ -190,9 +190,9 @@ static void page_table_check_pte_flags(pte_t pte)
> >  	if (pte_present(pte)) {
> >  		WARN_ON_ONCE(pte_uffd_wp(pte) && pte_write(pte));
> >  	} else if (pte_swp_uffd_wp(pte)) {
> > -		const swp_entry_t entry = pte_to_swp_entry(pte);
> > +		const softleaf_t entry = softleaf_from_pte(pte);
> >
> > -		WARN_ON_ONCE(swap_cached_writable(entry));
> > +		WARN_ON_ONCE(softleaf_cached_writable(entry));
> >  	}
> >  }
> >
> > @@ -219,9 +219,9 @@ static inline void page_table_check_pmd_flags(pmd_t pmd)
> >  		if (pmd_uffd_wp(pmd))
> >  			WARN_ON_ONCE(pmd_write(pmd));
> >  	} else if (pmd_swp_uffd_wp(pmd)) {
> > -		swp_entry_t entry = pmd_to_swp_entry(pmd);
> > +		const softleaf_t entry = softleaf_from_pmd(pmd);
> >
> > -		WARN_ON_ONCE(swap_cached_writable(entry));
> > +		WARN_ON_ONCE(softleaf_cached_writable(entry));
> >  	}
> >  }
> >

