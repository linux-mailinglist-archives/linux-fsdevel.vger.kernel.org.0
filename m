Return-Path: <linux-fsdevel+bounces-65412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA4C04D09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E784E1AA1BCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1481A2F5A27;
	Fri, 24 Oct 2025 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sdNVfI33";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="stCAx015"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8D2F5468;
	Fri, 24 Oct 2025 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291838; cv=fail; b=Sck5ROBmuZWQVLbT8M9N6X7KquMxSMcAnkezQCiRYnLeX3/CUq8zlwRoiXmXAge1vgyiTTKOTQ/6GNSzHoQgK9RKOaLyMRgJvnKz4y0vEY23BvJc4E8xcajmCEkhlmHuv1nZRhVbcV1soxMayZQV+2+hJT0tOMpUEPnoBO8TUzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291838; c=relaxed/simple;
	bh=e0odl34dsCMgPjzV3f9n8IDXOHx8VO6jCV8Jh4PXmKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LfYZ7hphALgRITJ3MnpSl2gxLsVAMkl49z/lA4SEgrCMF/W9VUHwPvK18UyjYrXF50X8HpueSh0QFhm5Zj0ZuCrKNsOfbuh7VCfFtDj2KzhNNViBT14ovIj6PO4k+3fFFxE+Ja2IdJaZxViG080f2ghp3+Dt2EeqY2KoDl1x3ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sdNVfI33; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=stCAx015; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3Nwjw029460;
	Fri, 24 Oct 2025 07:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ggdF/T6I0YXEYXqPE14M1nwz5EZJMt4atTt+5kQ7td8=; b=
	sdNVfI33zCV/XnMf7hCr79MjOcr8FTtQ8NDugHJ0eMFMLxUSTH8c7Bd5Qjo5fTRe
	idQzGa/K8pWRf1USZM6ByRuWdGJXwjq4OVVwXuCcygRqkU/BIEHUyX6dHyG48OVl
	CGKTFdVrj6D5stVMZSdo3/+BTwUtYK7NHS/peF4A61VT26qaHvJqkPm45PP2AErr
	eb2nrV/oStoieTl4jMbm6THT3vYhhe8BLhKDozvJN/VQPQOGLVvcpWd3LOz6PMGV
	b9kp+C81Ayd8t4KjmpN8g2oxXpptFlC0nlpKqK4autOKqhkw8IEydHxV44VXImck
	A4f+cKctUMT/U/Dy8S2jdQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0v4jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7WQQq035638;
	Fri, 24 Oct 2025 07:41:57 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm4xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChLNUH5xeMv1isbKZ1B8SjN/yX7pM3KutZKWJ3ABCrgiEjSQbYJioBWInxh5YoxFta63mTQtZrPdfKDKHiPkmBbRCLgthyZqJTSGcGY53U3Ezo86Hmjwrr2e0mjzEQkyD+j8wG7kQ2AElWEUuXVybgX8U+Mh7JBPs/l1Tz5JxkEYLug4Mg/gi/d/7UyXvMDpF/t/ZwEzPzYaLWBSZW9LZ04I5Krmd26MREq08q1/MCCYCR4vswXFklh+4Bpf19evVuYlHUvO8DWq2/n5jDEwUfHAj0Bx9tW+m4h2HSmBy40k4vMfS4HGYNdRvAPLCqIt9yYC6I/ylcv2/r8qoQbWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggdF/T6I0YXEYXqPE14M1nwz5EZJMt4atTt+5kQ7td8=;
 b=CgGr8S0rdToIyIPx1wY0KVBfuDvbYAfodmgWO3OsjjDfyOGGZaDiRzADZjnsjBS5fW1wZciM5jYBSR04F2hgCFAnK+d/uwxfrkFufc/0u1w9ctXrrPs5Cc6jw3borPnc4EasMSO1TYS2Z7vtS/1bHZakaT/n8gpwyNJ+4MEiITzjV7nvHun2XeHtHEPVJSbinT2MoOy25PrErMRmgKVe5kaofC7KzI/B7d7bDtDHlahZfn9rZ/uG9LuNphLs2YyunHQRA0BXDI7jpuMEz2d0ksmJVpAeGPkX0TerO7xyLVKrwQ8AAaRziI2wjVG+FnTGvUm8LPFCfxo5CN2liliNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggdF/T6I0YXEYXqPE14M1nwz5EZJMt4atTt+5kQ7td8=;
 b=stCAx01557/u1HQqf4JIgERHFU81J+IOBu6Imbtv65Jjp5B9uU7Q46H0/C3UR/2cUQ4DgbRS8mXUaJwjAccvhu+gW5eIaEnqoRLM/IF6AR88PTjQyD5tk+aVbEGgliqvMAqiTunArQ1AKWgLtc6y/8LFTyL1zJUe4p9Fu52bEjU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:41:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:41:49 +0000
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
Subject: [RFC PATCH 03/12] mm: introduce get_pte_swap_entry() and use it
Date: Fri, 24 Oct 2025 08:41:19 +0100
Message-ID: <a48bf5fadd66059bbacca6a5f2eccc60eee3278e.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad025eb-7c54-4fc7-f97e-08de12d0ca5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bEcLPyj7GVPDK6Ol1tQWpyoKb7KEfak5hFm5a8WA0kxOTil6lfwmY5rkkJfo?=
 =?us-ascii?Q?oHusp4r2Y+kSjfWektEDBuW7G4hoorPqQpZA/TXgj131FWToiN9iTkaz4pWB?=
 =?us-ascii?Q?Ot8aNG4DgXp/39u9IZ43D9TaO2QnlEZzlJPhJPNss8A8lrebm3lP1bQiqzNJ?=
 =?us-ascii?Q?7upyXoIm59/gOT9tjKpgKOlFlt23q9sjB4tJz0ozS1mnF2dPsLNw/5pyYErd?=
 =?us-ascii?Q?i6bdv/tvKzeQ1q8CMUkIy6Y7l+78fjlUel3tfB6Yc0OS1ONiKHyJ5NIDdRPM?=
 =?us-ascii?Q?rQlYqVKpy5xNkNhY9iWiy3aWPIcG9lYX7lz1x6QvKmYu7Bjptz2XcoBDQ/7r?=
 =?us-ascii?Q?KFEl0eJjbwpv37DrHkQhUVN09NroL347kwPSfqiE+QIAsB5Vs/E4CNAtr6la?=
 =?us-ascii?Q?6H273Ww7R1Vr93cJeDoDPGcWpdxOZAX9uBHnVUzqhxIaJslacLMYoAM2saFi?=
 =?us-ascii?Q?/lcAI+ypCSBjVBYle9ymMrqx1FJXf8vtN2SUlkcc/7J8i2lQCFsT/TS14shn?=
 =?us-ascii?Q?6IA5knQ4a3Z45s1bOGF5JX9j73BzkfLfP40RUZRdTEURZkDxxeHPUYe0rdE7?=
 =?us-ascii?Q?H7hlMMokUoz8UwCpu6wb2TgfRWnBvzY+caEIiEOMJlIdXXxYzfCIUnhifmlk?=
 =?us-ascii?Q?zeeG0Nyf5PXarKaM43mQAR9ZyQ4lXN2BbQ/ym7gsE61S605H0nG26F950ZMy?=
 =?us-ascii?Q?TU40HKj3noaciCtfctPyt2Ehe/eM7+k5iLPA8Qr+59AxMFyb/BI/hwZCIhbG?=
 =?us-ascii?Q?fdXsqu7IrCqJ0yFSEQor9E3TkjvIoXmhwTS8qxKBYbxspoPq0sxdTZ9yAcDw?=
 =?us-ascii?Q?/U/13qp/YyusAkOCsMU6THDV8PZmbHEphgT02f6H+F0MQXnnd2JS0JqYsBUG?=
 =?us-ascii?Q?SQkmEi8kJ6/fvKfDPep7oDjYP0Z2P6KL0GNIUjri9jqOjogX0yhii+cDvUmb?=
 =?us-ascii?Q?9BMacI8GhCGZUmSUXLHAtfGKJ7j38GIh/lteYagHqxaKBJngoAAFZiS5rzCi?=
 =?us-ascii?Q?ypMQDBH+kBUO1orx+pCJwXuafISES4cv/nzF/mhjaV5KnWeKCi7GIdj7cize?=
 =?us-ascii?Q?MhxolEXRFFRUdy7u2m+WpowlHrQjwEzDlRoP77+GS0Q4GAgroM7edzVQwMHL?=
 =?us-ascii?Q?nqMJUCUBDZGoaq/1HWVCISPvADhUEXyvj61cLyPBlWuprnGC4j1PukyqxZmO?=
 =?us-ascii?Q?AsOiIWiqlWFR31+MP020D8sM39zD9p9qwwWslAfnYSMh/NwD1GYyNqRSwLE6?=
 =?us-ascii?Q?Y3j727pFQDDGj6eItcLSyp2k7UpgSiUvUOpgLnnHAmhOaOneFFFIB9uCGyCF?=
 =?us-ascii?Q?g3GypB/CVgJxU8s9y2nEF2XtGk1WPEsYq3YVs/by+kC8xNisYw0aSgk9sn/f?=
 =?us-ascii?Q?IX335JJhnYcnRxcgrv72xVPy5IpFwjCJJg8zZa0WvNWKs6zTRSw1YFv7SWU+?=
 =?us-ascii?Q?5GG7AmHVd3aevO6Z8iKhe7Kt0OF2lDTM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQa+H5p1kyljTLBm7DYucUdKqZNUGVu71/1Jvj1AwusKwV5pOREKuYzBs1zy?=
 =?us-ascii?Q?7VSZkfYS00nPVeUSgX253JTYWkEFBwzNFcRERKNeJs+ZfyOmebDq3hjoubU4?=
 =?us-ascii?Q?6y5ljk26MF5eR8++8rN7TTRFJRW5BF3HNVmrMGrVk4CuJwoFlRBwtgfhgGiZ?=
 =?us-ascii?Q?Xj5bS1ZOFu7n460AZvXVKTvvbcXw+Ro14D0L53pC7MzeFe8IeYVEX6OW45yD?=
 =?us-ascii?Q?Ca6Tl98dl7PhpPx371WSUOe2TBc+cOXh3LihLLgZkrUQNMqgXrzpLH/PBkGL?=
 =?us-ascii?Q?zbn8eyb3O95wkNlAgvF+JT6YMJzWFjnUXd2V/VP6U6+zsUM/IpqqaKWAS3CA?=
 =?us-ascii?Q?gWvWspElIuu0PaMNv1atTm7m7BJR0FCkzYeQn18cJEqhNF+43To+52npsyEX?=
 =?us-ascii?Q?IoXWaWD0KuYXTV56ZLsntDY6vSr5iv2M/w9ymUcFCvxPEY7f9l4jqW3OMaWx?=
 =?us-ascii?Q?V1F66toj52egsWui/GHWp99fln6lh84QKPMy7Qs3+wA1LMTzacCvgWP1SOZc?=
 =?us-ascii?Q?ijmy7Iehnx04tOLlKNjHu3GpHJXK2L0bwq/A7YM4LwxMzHfrEkKHXcetH4zX?=
 =?us-ascii?Q?OtQURx1rAh9Xh61z/WYJnD1UbAfAJ9De/iwY0QDyhIpyDtwxViyIX+arM9Wf?=
 =?us-ascii?Q?zH6iy276E2sCbTfdCOUEqvoeLDrTxTLH65Uys4zmoPQnR65/gr8xYSDGaveJ?=
 =?us-ascii?Q?vWMhEFpdBVJNuFQl5PEaUO0a2FEDvRJT/r3lqtMll7AiQyUEYGHJhZBReD8R?=
 =?us-ascii?Q?BGWVYi4CblDmO6eSqb5XshPIm4nktzvgJFcF0vRR5291p0iXEmAwNO4PPlzD?=
 =?us-ascii?Q?VnkL+cOn9tSscwsT1m0wsbRLIpmahm0QQHOhlzgIWCOgTqT6pgvuHXMWTEjs?=
 =?us-ascii?Q?0zgasCTHEIY8NaFQDRM8rN3WTJndziQ6yz+fj6MvLtedIjjrVVZSSDuL7Tih?=
 =?us-ascii?Q?Lzxa0ZEX41iYHwCn8XGx8lS6pseEzXpu6c56BcK1IPNqwTnbOA1PW/bQrbta?=
 =?us-ascii?Q?AzzSZWJIDSyQxaG18hEj9JEn6sly7T1Clhdtp+QcQqI4d4hTBAdMCKoI6pLC?=
 =?us-ascii?Q?qxAcQs5fiiJbdJft1Op/7CuGDBpo85UG90FKAZiT5SUgaASQpPiAZn9ZIbgV?=
 =?us-ascii?Q?c+vTDB+UKV81amCrImFx88rTeBctIeIGDl46jI08CK7T7kCePJUVIE3HHR7s?=
 =?us-ascii?Q?N8MVi8E6k4/VGkL7OIzXqoHvGk229Q3Seh/bMSU5+/x5ONcf447go/i6wfJp?=
 =?us-ascii?Q?RbUTKxNd+bMaLOI5QGCZbs1VWa+ABOQf+PN3cCzZp4kcJDE8GHBuPI7s1vIH?=
 =?us-ascii?Q?0OLpf76iFLuvwZItsWI1hcZD5jCvrm6MT7cI5L/5bQUlFV0EMUDeiV265dEG?=
 =?us-ascii?Q?S8tCi0jjAlZoJx8KYOp3smoZUifQNdRwFY8sCwTLPKwW8LwnNPfoL7zIC7Vs?=
 =?us-ascii?Q?/7v3JZqqOdG0r/1FtihKGeqPEgCkJRwG+fbum+7EypbQFH0onVsRkmxO8dq3?=
 =?us-ascii?Q?b3q4UmrgPbXx9ambDk3kmklR8ggT8m+TRbdl1X3Xe9RHw+TvE8iqE9hYCtfl?=
 =?us-ascii?Q?zvxmN3PYnu9pMoLo4YGx02B+M6VDX5S7xasaIAzpze7X3Axe85PL/6Jrv55w?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qRFbsWcmrOMfzsNeE2U9vmYpek6Z1foIIIMIC3j03DfSpkO7fZhXCNKPXp2gqCo7bS3Q8/GWUO0DGt/NBF0rV/0EQ5fWM1Hgvh2fL+cddMD2lCRgBkL5IpOeO5DCvJiNbMBPMVX0vaAP+tSVFu9KC/PXAvAInJyjzEWotvJxsUPWr//fyH3IQTu2sUiJMIKqFDe6JSTiRN+KXe2olP7sJGaMkSE0egkpInC/vNTLhh6Hs3dP9/Adc+88lEG03WNl3JblQq2yVTk1kbW9kCiBlGpS1q0Ul8K0YzJlOMsMzIOnHtsNWQ5dtmdFOubbnabnRe/iNEBeJocq6VG2yYfRsp+aE937GSMRxcuVf1QQ0AlS+rHdXCxmCRtVME91S6vamxB26BI8ArZQPOdQQWYVSeWibjXEU56BZza+PttE34HR3+99iwWRKeGh0z+6YUo230OEJyts6+W/rw9ElGVtDi5s0EdwTX37sgVJDMZjKSnhdh/YqkKRpyTcUN6EWW1GFzeSLt8BCVk8g+ZyGcSbuCpM7I9f2xFRmb7K8+vWo6Xk9pTo6f0XsfZ+rVhEgwcQdPmEAhu1SO+yBiQgYldE5SgS2vc97VuxlP0uMPWrZnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad025eb-7c54-4fc7-f97e-08de12d0ca5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:41:49.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAYbzcHS2ZNmeyoXgubum8R4ECYzeSwCmHx6UTy5ZYFKATEfaHpIFHOJu2ZTuHDiX5Pm7kdg/YeK0bunOre1iSflrjlLvqbHsgr1anKbi1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-ORIG-GUID: MqZfYk3cWjL79c8_Afc76aKNrMQr5lpn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX5tv7f0q+c76i
 82C1GW50c4+zlRzC5HqCAqGxzYAhPAIPhYNolTybOSEFm+o5bzwP3/IewhQ5C3oszC6LY189JWP
 610Tyfq1xS+8UVs83C117Q6O+3vh0kkxQX7VK5fHM+NJkL3Xk7MRSb/QLSto0hf0iIz9T5dlTnA
 Vthn9xI2rlvM0c0zfQ2QIxqs+vsbBH0Q7YFxIKBQwcVWjHCFCdfluX1q15Q7T6JF9Mr9KefBzwg
 7qOGCl15MO15ujiqaGQHktv3wKceWo14uHrGbcsaQu7Ng44xjq151NyHM9mtd7Gtdju9iS/nTBS
 GxAWzML0J117mYIE1D8ZRcrhqZSPHFxi3Qu1Vgv/3pfXUDZAVwWFtoXRxNwtJL/fz69HioMR4cM
 byqNIw/Zw6WdrU/RFw8kOUt+z7159ayT9Ipwy99PUhpzYIt3HR0=
X-Proofpoint-GUID: MqZfYk3cWjL79c8_Afc76aKNrMQr5lpn
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fb2dc6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=drdI2bGYmz5d-Dgk2eoA:9 cc=ntf awl=host:12091

We have a number of checks which explicitly check for 'true' swap entries,
that is swap entries which are not non-swap swap entries.

This is a confusing state of affairs, and we're duplicating checks as well
as using is_swap_pte() which is applied inconsistently throughout the code
base.

Avoid all this by introducing a new function, get_pte_swap_entry() that
explicitly checks for a true swap entry and returns it if the PTE contains
one.

We then update the code base to use this function.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/swapops.h | 29 +++++++++++++++++++++++++++++
 mm/internal.h           |  6 +++---
 mm/madvise.c            |  5 +----
 mm/swap_state.c         |  5 +----
 mm/swapfile.c           |  3 +--
 5 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 24eaf8825c6b..a557b0e7f05c 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -649,5 +649,34 @@ static inline int is_pmd_non_present_folio_entry(pmd_t pmd)
 	return is_pmd_migration_entry(pmd) || is_pmd_device_private_entry(pmd);
 }
 
+/**
+ * get_pte_swap_entry() - Gets PTE swap entry if one is present.
+ * @pte: The PTE we are checking.
+ * @entryp: Output pointer to a swap entry that will be populated upon
+ * success.
+ *
+ * Determines if the PTE describes an entry in swap or swap cache (i.e. is a
+ * swap entry and not a non-swap entry), if so it sets @entryp to the swap
+ * entry.
+ *
+ * This should only be used if we do not have any prior knowledge of this
+ * PTE's state.
+ *
+ * Return: true if swappable, false otherwise.
+ */
+static inline bool get_pte_swap_entry(pte_t pte, swp_entry_t *entryp)
+{
+	if (pte_present(pte))
+		return false;
+	if (pte_none(pte))
+		return false;
+
+	*entryp = pte_to_swp_entry(pte);
+	if (non_swap_entry(*entryp))
+		return false;
+
+	return true;
+}
+
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/mm/internal.h b/mm/internal.h
index b855a4412878..78dcf6048672 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -378,15 +378,15 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  */
 static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 {
+	swp_entry_t entry;
+	const bool __maybe_unused is_swap = get_pte_swap_entry(pte, &entry);
 	pte_t expected_pte = pte_next_swp_offset(pte);
 	const pte_t *end_ptep = start_ptep + max_nr;
-	swp_entry_t entry = pte_to_swp_entry(pte);
 	pte_t *ptep = start_ptep + 1;
 	unsigned short cgroup_id;
 
 	VM_WARN_ON(max_nr < 1);
-	VM_WARN_ON(!is_swap_pte(pte));
-	VM_WARN_ON(non_swap_entry(entry));
+	VM_WARN_ON(!is_swap);
 
 	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
diff --git a/mm/madvise.c b/mm/madvise.c
index f9f80b2e9d43..578036ef6675 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -205,10 +205,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		}
 
 		pte = ptep_get(ptep);
-		if (!is_swap_pte(pte))
-			continue;
-		entry = pte_to_swp_entry(pte);
-		if (unlikely(non_swap_entry(entry)))
+		if (!get_pte_swap_entry(pte, &entry))
 			continue;
 
 		pte_unmap_unlock(ptep, ptl);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b13e9c4baa90..9199b64206ff 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -754,10 +754,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 				break;
 		}
 		pentry = ptep_get_lockless(pte);
-		if (!is_swap_pte(pentry))
-			continue;
-		entry = pte_to_swp_entry(pentry);
-		if (unlikely(non_swap_entry(entry)))
+		if (!get_pte_swap_entry(pentry, &entry))
 			continue;
 		pte_unmap(pte);
 		pte = NULL;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index cb2392ed8e0e..74eb9221a220 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2253,10 +2253,9 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		ptent = ptep_get_lockless(pte);
 
-		if (!is_swap_pte(ptent))
+		if (!get_pte_swap_entry(ptent, &entry))
 			continue;
 
-		entry = pte_to_swp_entry(ptent);
 		if (swp_type(entry) != type)
 			continue;
 
-- 
2.51.0


