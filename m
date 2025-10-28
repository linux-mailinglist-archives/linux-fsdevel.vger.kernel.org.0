Return-Path: <linux-fsdevel+bounces-65949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3ABC1674A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 19:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A54F9799
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CE2350D5D;
	Tue, 28 Oct 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NLKVUuq+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FE+2lsII"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49134DB4F;
	Tue, 28 Oct 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675728; cv=fail; b=Qf6oGovy5yt1BC4V46zTNpmUP29U44qE5cWtewGLKIAOfl7hCbaV/QYfVAH+bvEUEQxlmnDjDPCjwzJ/aFG3PDiAYlCC0h8+damqKINS1Cc3j27hqSbdAM36wnRNz6nkBZ+A4Tde6oQTYLmEseAPxtrn30UzzPLfYeGFulzvMNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675728; c=relaxed/simple;
	bh=Fy7SdeXvLH/JXRvh1QnZtTi27cOjETMnLu5jKkabm7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GwgSrrAkZo5GsIluBrnwhuIi2FU7vDytI6y/JVqKH6sFyGTjaUIuDg3OIxvrPA9+2TESEWXh0o9nxOSm3310d17sMSRgBPIi1igj8pmx74XB12AO8/R6Bm/8ztUcs3dj671qhoM3cbSXCMPjUyK3KJRMwWhqORaCgdZ7cRfWLnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NLKVUuq+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FE+2lsII; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SHSF4t019338;
	Tue, 28 Oct 2025 18:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1tWYaTYXbt5qhrhUVj
	LjsTq0wyYSA3bBuPCkr/IgVlQ=; b=NLKVUuq+5k7HJxJ+NRRB8ao4lypBqlJZwi
	VxwVbVElwf+Rug2Te9XJpTmSR+A8DRq3hhWWZ0WgSm0u1rdzz3DDQtm4wL7qKjU9
	iJiqOqtijS0im6QfAZsMNk6AOzkcOgOU+ZS1q5ie74PFYj1IiVWUYFXL7cPl37fW
	JTXEDLVbaw8kI4VTZOR9tlcxFGsZLb9AfE8qbM+iYSX6N6NId8Er+fTXYh2J6Uut
	zjA8vgO7rBaofkHAOJMJRsUT9zotveafNwG1EgXpw+MLLVOWpcVi5cYKiALeLxhB
	rhE+oV4QwlztuWnNsEL1M3pz/w0/eb1cX3/Mfb55f1MOJ6xQ6+Tw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uwm8xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:21:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SHYeQm009058;
	Tue, 28 Oct 2025 18:21:00 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0ftx42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lk1qBK47wNBFEUx5djBLc19MzVaLGoyj4j8dJYI49UvW7zuCRAj0i09qFwt3mJUd5ecn6sBLnCkfwkpP6zXBIAoxdaQ1r5MHtbG1HoE8tfBFfaiy3AmCzQdIGRtK9kOcRcPgBaN0g29k4dXGX4BMrFEfm24YNd1HZn6/U/UK3Ss9l+asw6NS+8o9WV9E/GWbrMOdShNi+R0X8JVgS67Qy++EuaEIEA1A+THpEVeHcvByZZwbCsGn9UcvkHV0A8Un4QRqxNkgsvTUVFUgRnLkvJvU9+BYaCkbWlrfsgLjH6eFAtel8mMqRO+NhJIEZUZ1FiSFGIy1sLt5LsU3+yGV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tWYaTYXbt5qhrhUVjLjsTq0wyYSA3bBuPCkr/IgVlQ=;
 b=Jzcp0zHDqij1TxzChW9ON0V4r4D4Xcef5Brb2EBG+wtWSqHtBk2Vz8iWDKga6SEAu33s6jiD+qNKjolfGGBlFWvYWQiQhOLD04VV09RaDKiLHysEE9hzMyOrg71S8XWaed4yeBIV/mxbuI+3g8WwtChXMLBzMdc82KhaOjup6W+iR2gmHYN7Qd98sxu39fECkn/x5nubeP4HclIZwlOVEcAls/9mRS256WUPWdL0wF3pPCJKqq7KijDzcgxOqziOHerpEya+MI2kV2AJxaUfjmD10iBk3TmJeGP6sERf+bQKJwrfKRPYt6xdxZg1fMN3hu47Du9GZhRPNUzvIw8mxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tWYaTYXbt5qhrhUVjLjsTq0wyYSA3bBuPCkr/IgVlQ=;
 b=FE+2lsIIQm7nbmxxn0fUFlDp6+Dx16mmE0IgeYrejxS4HeTLVRZ9NIxIxd990ukLCnZi6xU/h1VWdvAxSWqnylvhxWkxmSXj/5daIG/+ij+147oIoOvok6AfW8ATFhYBfvvJmLAstQmXr9YP1WHhqn8KGf2cGb9ul3YncdYSnh4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:20:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 18:20:56 +0000
Date: Tue, 28 Oct 2025 18:20:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Leon Romanovsky <leon@kernel.org>, Muchun Song <muchun.song@linux.dev>,
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
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <ce71f42f-e80d-4bae-9b8d-d09fe8bd1527@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
 <8d4da271-472b-4a32-9e51-3ff4d8c2e232@lucifer.local>
 <20251028124817.GH760669@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028124817.GH760669@ziepe.ca>
X-ClientProxiedBy: LO2P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: c2210f53-7a60-48ee-e87d-08de164ebca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?maDAk3NVzIhDneWIJKbE0PeNcT8zJnjQe4uoTiATCdnBbvkqDHMIa+blx/jy?=
 =?us-ascii?Q?4tZY07C6OU2z9G/880ZGOJ46KkTmBI+NQQFKI/8dSN7+lIPKELzkeheOAU/W?=
 =?us-ascii?Q?+iCcGcUIRN3IW0mJflHr+MY41YDAqawXg8EU8CpgLmEDULJywyT9r1cEUWy0?=
 =?us-ascii?Q?XnmkdESCsgf6RZTOFBNZAC6RML7yu7dApdL3aUI9HWdF4rWFnpOZ3EJkDblP?=
 =?us-ascii?Q?ll7BJBiNMlL9AX084G4pEXkCqkGnpTriJES6w0mLfMiqRdSKeGcoxfYErRnx?=
 =?us-ascii?Q?+uRHFgdQ9Tvdy0L1J8TRQ8KZkVox3GrBefyUoohNtu/kbRFBUpCEtdPhSk7Z?=
 =?us-ascii?Q?z9MOutDwz0yjcbBMpXzEt3qHQosBoqoqoy5JUVustlRva/ckDo8StPV3vO3d?=
 =?us-ascii?Q?qoJWZNHBqT9Vbp0Cw+TNe6YIWXhDuoZUKdgM8SPTl64T2SL6ekDcsXe2P+XO?=
 =?us-ascii?Q?Xm3/HyWjFXgbyPxfPqW5h2sTw0hOIxYh2NFyLzEtMeAyEfczl7/41AxW6thb?=
 =?us-ascii?Q?NehHpe4Hb+YMXzdi4op7HqqlMr1bC5z330kvGyqaYuEonVCjfgbYGuopRV9J?=
 =?us-ascii?Q?JsiLzRYk+iIyF/tXzwopx7gi34WN44cgjOZ9qEH3pnMONkX3vKGLkaLf6G7w?=
 =?us-ascii?Q?bSL2/E5efzTNWk7IycVjocemzM3T8vwmWlxRzM47ojh4MRPRdkL+lFU5NC5I?=
 =?us-ascii?Q?nxZLD0G2scEMuFNaUUVbdmpO0VN35mTr6ZMx62frU/3pYSZ9wt1OakbxdfDo?=
 =?us-ascii?Q?XIldYK/VBUUZZxMf4Dox37mfwjF94ZLNjc2RzZwYhOYQ5GLfGYX1zoct588E?=
 =?us-ascii?Q?k5MjpbuwLBcMCXK54Q48x+RtC8Fqzv/LsuzyakvxusxfYJtzS6SPcigqwGlu?=
 =?us-ascii?Q?DzbmuLsPuNPUHCYncZFbQS0ZrPIlcpVgDkLv522D3Wc/BADE/Bs1fz/iG0E9?=
 =?us-ascii?Q?umRAJhpCodysHDJ3EJZsTtvLwJWEDa8/OKkq1CPIwG6ZQZmfKWCsi7PjCvT/?=
 =?us-ascii?Q?FnZ4BGdkGppOApriSFKns29X+F5hYJ1qAxxxLgmh3anmGxPpbQZBZ82LjKcs?=
 =?us-ascii?Q?eJHkkHaOs8bLu8VmDzfUcEJ2WxT2XS91aqre+q2hv3Lbp1HCuDei/OWk4Sxj?=
 =?us-ascii?Q?x1kRSH5N5h6BpCcVnao44znTFG1p4SVQRCdjIUzokYoxQZMQrkmClMbtOrZy?=
 =?us-ascii?Q?cwZtz29NWESJM+Hkm8OdbohwZLryA/gzOPL37oP/R67Jv7/Unn448Ub7ii4b?=
 =?us-ascii?Q?sIIqyhN7MgsJ8yHl9Ek11DrU04yRdETMzUgvKEXvWhYbhdD3+0qq3FTbu55W?=
 =?us-ascii?Q?apC4UT68B/jYu0cd56fBVf0AZTZlu6xHFhDu/YNGae56HQ8MGe4kfhbwv0Dl?=
 =?us-ascii?Q?rn1F+8MB6NFMlKETNYPJyLAg7n33JPc82C8G9o0OVQVFkr4M8bDrtdsi1enG?=
 =?us-ascii?Q?sxBYKiIzTql8BVN319lT61RkHd2ySWx0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ce+UmMoBsU3KMqFWyU+GnzrOon8D0oXa2yvUbr/djCLZApdrq3eTJy9RaTnT?=
 =?us-ascii?Q?wgQXEzs//4wyJw3dXYUhoeXpYUgqTTp4xMfJX0Tiv+5nRFxKjRVcLgTjY+W0?=
 =?us-ascii?Q?FDk6tDCitGfA2nAGOGA9e3POO4qMjoeg0zcmlQLh/mzQg1qytFgZ4hxoGmS+?=
 =?us-ascii?Q?bADTr9Rb0w8QUOYjkhhVCRiwQN0tVU3wdzVza2S/x0ycwub9tXh8ietsxe6O?=
 =?us-ascii?Q?DSkwD37/X/9b/jewFRk94kT3IzqLobW+KsbU3fh+iazENEe6WaL0Rh/lgGQr?=
 =?us-ascii?Q?HTMB4kx3xwBswuakLimRQ50CHEnl+GiMYqsWW0hAkKH8u3PHrBBrhfObiQIU?=
 =?us-ascii?Q?vi0upizaMwK5qR8+KPHBRFOJIcHLBs+0MstL2UZ631hQSGJEZw43sKTjyUkC?=
 =?us-ascii?Q?O0K6uF8cplt+ctLbGu6sIBywLnlrlCAKntsLCfR1YhwWphNeaTxcexAl7BTV?=
 =?us-ascii?Q?t0gBgy4qXDbCvcWCxLLNG+trCzY3L50bw3X7muIEpq4n1FXy93CiR8CXciOy?=
 =?us-ascii?Q?lLFZ9XETnJ1QWNPeab8UntECLQCiqHJWd8fHsNI/gfNw2yjK84VHdYVoehva?=
 =?us-ascii?Q?NZ9f3vGc1ZSDuuvV4EaQeQ4b55iWoKf7bz7LmPiU2faYbBTEMVhIaVaqfBpX?=
 =?us-ascii?Q?ZJZUiOimHdhGmn82X3a4N94tcQFNAUPT8SRqFcIFpqRzEAaKs1PbdGzz0Lv4?=
 =?us-ascii?Q?0o/Dr8eds0lBUUMDwK/X5veS4BmrJJj8xlPZMC0bFxqBBrCRZZOyZN2BD7hT?=
 =?us-ascii?Q?WH1Ro1xM0sDXxQ2EbA9EfsCln3aMYkL17Va5DFoz3e6WQxOla2KUXCyHG3JV?=
 =?us-ascii?Q?NH49zTjxZUB/0g6EFGkCUaynqbP0UaGNcGw6WP/fnS0BQ3J2sR8YCCiR078+?=
 =?us-ascii?Q?pePnNAZX9NEqU3CvxbpCV0xbfofylPMYbj197GMXNMAd1cdA7RLVBWBn2Y0c?=
 =?us-ascii?Q?FYrWsxnU4AncXwdsJ7FnS77o65xXMQL4hDaOnr5C7rcLzSrQviZyZUQqSgOp?=
 =?us-ascii?Q?GTidmfrmdEL7oSq0mweIBMN/zeT8q7X///X3y/knxPP5ll1DzAjJsE35+b5g?=
 =?us-ascii?Q?aM+WGgS81SMwepbSaqBu08XI36auSwX15AsubK3R3F/yQtdZlNXZB2+KvpuL?=
 =?us-ascii?Q?d4tiLU2uzd9tx/JecEorufu3FwAME/VdgFbYSW09unNQPKcnkeAR1d168KJF?=
 =?us-ascii?Q?hG649x/TEU7BaUOrXC0DJUNLGO3oKA5kqywEdyhGU3CKS6+OguupH32hDPTT?=
 =?us-ascii?Q?sODQCRRqgGgdrfg0smBIZkfkYQln/YiTMPLXxIOZBic1X6v8ziytmlZPToxG?=
 =?us-ascii?Q?RiiVctoy1JOFzYozaSVoboJt8y3IumOS/GeVytT1ntzMZxsQCPBaPsNZ+Roj?=
 =?us-ascii?Q?n4VC38GG7ivkBo2MXV3lMOyCrBiNe4BdauauWLPQ/epkCabUgKN8fsENl77c?=
 =?us-ascii?Q?o0Ty0w1g4cdllE3UnTKHLXxVSIAPyk1X3plL6ySyl+wTA1wHEYKfn1pRvn48?=
 =?us-ascii?Q?ckfUAlwTC8G3E6qhZ0VkzrdBN4kMhDol/Xy46w0qN8Y6u12STRD2TDrs2O46?=
 =?us-ascii?Q?Qkb/sLS26Vuceua09Wa2aVMvZJxn6NNRHfabFa5BtSa0WxHZx1+m9NZNOqZY?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/5jNL58ESbd0+cKYwsUCnUqbKAOCiIQKbgyyqiDqt6xhaJFTxWX6l5dAwJrJOHCya5gxSS+JN4asoipPEsnRKZp52GJXnJiqVULoc8qJ8ZQoXmWYKFf+Z3MM4r7GuBUdtGC4I1p8vb4pmGN2tEWflRs1LSU96eZI/Zy5CugJENuci1IQCCG0OGBdGdcJcSubFQubIvmGvrGQqVsWLbspDXc2/ht8IXPC4CmRAh1HBvA1X9/7J+GazOYFbQtOj+oX775NFJO4ePn+ldE9TSnoSOC1K9+AAaS2dy17oO01GcpbZUtEzIshEP7Y/6vMKl9sT1PIc41TfoPgny77e8DTiBx0NDIgtX/mnsSVzxJ6RdVvpAZRZIm+buAkjgNPSUMuhKz86JsGy/+zzoRlVvyfo7+ocDIO6uQceYCY2zdpQTbgLpx4ScKcCk5KXG2p4kPkEItjaPo0Q66f0IPXx73plJ9ykOXTmAymner8XTczU47WUdyFvX9yBQOpKgz8NW77LOL2Q0n/MRiX8vJelc6ViV6kKqSMIGKENl+uog9h7MT5VN/JoIi1bBrRmmaeh9oofXupMGnj4N1OFjuUCLlWLsVY/7xkfJGihe1uBLKsRDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2210f53-7a60-48ee-e87d-08de164ebca7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:20:56.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DObTnVJ7Gl3ORWzsRZAL7zFk3y0s7AYjGRKLZOJKzOALywDH6spw0JI0yfPah4eKN5pZbmozb/cu3/HdfGwD97AU0SF20vVH5i1+2gFKsjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280155
X-Proofpoint-GUID: IYcLt0RXGypCiRvXN2UGTyzeNw8PGFRp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX/szzCbqok8l+
 a8EhtelLwZei7jL7DCYC5RpCn96YHoTcgprNDgeD1chuIWYV/lI/7bz8AaOMpMjgeO8xTCXIbyF
 BHLrWNGCT3l238CPx7lWQVHXsItYkhi4gXsrmNh0X0giA+67pHvKx3Q38KGDp906QoqdoF5Uaow
 OmdKniEr80OonNeQ3jBVfdXhFMorZ0FTMLK0mapyZG416gOObUgyFE3CnvkaWk/FVxXW3so0xOj
 LACvI0kIIrPga5stXs9jk4n0V9Y7KM4BZpHw9qSgPxQX0B0tBWfEN7FxQXnFHMegbS0SRPW0cBN
 Lvuax13ulFbvihYDvJZNUeccM2lB33Qy8pAILiiheAZX9a+AXyKoFBG47WzCGG2K/ivrHUYlNoS
 iAuCYavbFaMDAnoAmfN74Fx8szkVd6R3VU+G/w/byLEicuQYQvM=
X-Proofpoint-ORIG-GUID: IYcLt0RXGypCiRvXN2UGTyzeNw8PGFRp
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=6901098d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4_-8tt-Ts-JjSCUy2Q8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12123

On Tue, Oct 28, 2025 at 09:48:17AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 27, 2025 at 05:33:57PM +0000, Lorenzo Stoakes wrote:
> > (Note I never intended this to be an RFC, it was only because of
> > series-likely-to-be-dropped causing nasty conflicts this isn't an 'out
> > there' series rather a practical submission).
> >
> > To preface, as I said elsewhere, I intend to do more on this, renaming
> > swp_entry_t to probably leaf_entry_t (thanks Gregory!)
> >
> > The issue is no matter how I do this people will theorise different
> > approaches, I'm trying to practically find a way forward that works
> > iteratively.
>
> It is why I suggested that swp_entry_t is the name we have (for this
> series at least) and lean into it as the proper name for the abstract
> idea of a multi-type'd value. Having a following series to rename
> "swp_entry_t" to some "leaf entry" will resolve the poor naming.

This is addressed below.

> But for now, "swp_entry_t" does not mean *swap* entry, it means "leaf
> entry with a really bad type name".

Yes.

>
> And swpent_* is the namespace prefix for things dealing with
> swp_entry_t.
>
> If done consistently then the switch to leaf entry naming is just a
> simple mass rename of swpent/leafent.
>
> > > That suggests functions like this:
> > >
> > > swpent_is_swap()
> > > swpent_is_migration()
> > > ..
> >
> > The _whole point_ of this series is to separate out the idea that you're
> > dealing with swap entries so I don't like swpent as a name obviously.
>
> As you say we can't fix everything at once, but if you do the above
> and then rename the end state would be
>
> leafent_is_swap()
> leafent_is_migration()
>  ..
>
> And that seems like a good end state.

This is a two wrongs don't make a right situation.

I don't want to belabour this because we ultimately agree using
leafent_xxx() now is fine.

>
> So pick the small steps, either lean into swpent in this series as the
> place holder for leafent in the next..
>
> Or this seems like a good idea too:
>
> > We could also just pre-empt and prefix functions with leafent_is_swap() if
> > you prefer.

Good. I may even go so far as to say 'thank science we agree on that' ;)

Yes I'll do this.

> >
> > We could even do:
> >
> > /* TODO: Rename swap_entry_t to leaf_entry_t */
> > typedef swap_entry_t leaf_entry_t;

BTW typo, obv. meant swp_entry_t here...

> >
> > And use the new type right away.
>
> Then the followup series is cleaning away swap_entry_t as a name.

OK so you're good with the typedef? This would be quite nice actually as we
could then use leaf_entry_t in all the core leafent_xxx() logic ahead of
time and reduce confusion _there_ and effectively document that swp_entry_t
is just badly named.

This follow up series is one I very much intend to do, it's just going to
be a big churny one (hey my speciality anyway) but one which is best done
entirely mechanically I think.

>
> > > /* True if the pte is a swpent_is_swap() */
> > > static inline bool swpent_get_swap_pte(pte_t pte, swp_entry_t *entryp)
> > > {
> > >    if (pte_present(pte))
> > >         return false;
> > >    *swpent = pte_to_swp_entry(pte);
> > >    return swpent_is_swap(*swpent);
> > > }
> >
> > I already implement in the series a pte_to_swp_entry_or_zero() function
>
> I saw, but I don't think it is a great name.. It doesn't really give
> "zero" it gives a swp_entry_t that doesn't pass any of the
> swpent_is_XX() functions. ie a none type.

Naming is hard...

I mean really it wouldn't be all too awful to have pte_to_leafent() do this
now...

>
> > that goes one further - checks pte_present() for you, if pte_none() you
> > just get an empty swap entry, so this can be:
>
> And I was hoping to see a path to get rid of the pte_none() stuff, or
> at least on most arches. It is pretty pointless to check for pte_none
> if the arch has a none-pte that already is 0..
>
> So pte_none can be more like:
>    swpent_is_none(pte_to_swp_entry(pte))
>
> Where pte_to_swp_entry is just some bit maths with no conditionals.

*leafent

I mean I'm not so sure that's all that useful, you often want to skip over
things that are 'none' entries without doing this conversion.

We could use the concept of 'none is an empty leaf_entry_t' more thoroughly
internally in functions though.

I will see what I can do.

>
> > > I also think it will be more readable to keep all these things under a
> > > swpent namespace instead of using unstructured english names.
> >
> > Nope. Again, the whole point of the series is to avoid referencing
> > swap. swpent_xxx() is just eliminating the purpose of the series right?
> >
> > Yes it sucks that the type name is what it is, but this is an iterative
> > process.
>
> Sure, but don't add a bunch of new names with *no namespace*. As above
> either accept swpent is a placeholder for leafent in the next series,
> or do this:
>
> > But as above, we could pre-empt future changes and prefix with a
> > leafent_*() prefix if that works for you?
>
> Which seems like a good idea to me.

Yup. We agree on this.

>
> > > I'd expect a safe function should be more like
> > >
> > >    *swpent = pte_to_swp_entry_safe(pte);
> > >    return swpent_is_swap(*swpent);
> > >
> > > Where "safe" means that if the PTE is None or Present then
> > > swpent_is_XX() == false. Ie it returns a 0 swpent and 0 swpent is
> > > always nothing.
> >
> > Not sure it's really 'safe', the name is unfortunate, but you could read
> > this as 'always get a valid swap entry to operate on'...
>
> My suggestion was the leaf entry has a type {none, swap, migration, etc}
>
> And this _safe version returns the none type'd leaf entry for a
> present pte.

I mean that's already what's happening more or less with the ..._is_zero()
function (albeit needing a rename).

>
> We move toward eliminating the idea of pte_none by saying a
> non-present pte is always a leaf_entry and what we call a "none pte"
> is a "none leaf entry"

Well as discussed above.

>
> > leaf_entry_t leafent_from_pte()...?
>
> Probably this one?
> > > static inline bool get_pte_swap_entry(pte_t pte, swp_entry_t *entryp)
> > > {
> > >    return swpent_is_swap(*swpent = pte_to_swp_entry_safe(pte));
> > > }
> >
> > I absolutely hate that embedded assignment, but this is equivalent to what
> > I suggested above, so agreed this is a good suggestion broadly.
> >
> > >
> > > Maybe it doesn't even need an inline at that point?
> >
> > Don't understand what you mean by that. It's in a header file?
>
> I mean just write it like this in the callers:
>
>   swp_entry_t leafent = pte_to_swp_entry_safe(pte);
>
>   if (swpent_is_swap(leafent)) {
>   }
>
> It is basically the same # lines as the helper version.

Right, good point!

>
> > > > * is_huge_pmd() - Determines if a PMD contains either a present transparent
> > > >   huge page entry or a huge non-present entry. This again simplifies a lot
> > > >   of logic that simply open-coded this.
> > >
> > > is_huge_or_swpent_pmd() would be nicer, IMHO. I think it is surprising
> > > when any of these APIs accept swap entries without being explicit
> >
> > Again, I'm not going to reference swap in a series intended to eliminate
> > this, it defeats the purpose.
> >
> > And the non-present (or whatever you want to call it) entry _is_ huge. So
> > it's just adding more confusion that way IMO.
>
> Then this:
>
>   pmd_is_present_or_leafent(pmd)

A PMD can be present and contain an entry pointing at a PTE table so I'm
not sure that helps... naming is hard :)

Will think of alternatives on respin.

>
> Jason

Thanks, Lorenzo

