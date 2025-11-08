Return-Path: <linux-fsdevel+bounces-67543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8137C43102
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F403B2C2C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F426A0D0;
	Sat,  8 Nov 2025 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GipQuQPs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C5AzFoAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2825BEE1;
	Sat,  8 Nov 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621877; cv=fail; b=bxdMKsl2ISFbo4IThDqPvoboA/etUYcNm96RcBz+5NZu2h03VaZxKPw2Rabkou7gPXT7wr6lvXQAdmhH7BtJUCfFUNSXonLetOH10hKnrz9fD60k7ZzTm37GeDzIKQHjL+8kGOpH+0HSxkF0kgKfCSiF6N0IJ/OTS+tt0/ACxsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621877; c=relaxed/simple;
	bh=gJ8zRazqzQ9hDxhtbg0qAlApDfcn449VuQ4f4oPaLcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPwoBV6xDjfVJw8KCSD4UUhHF+EN4jkCJN9+BgMP7nX6D5Ty7HFsdLA3zsjyXr3hQNl6hrxZTodKfqCNQt9ip73gZkLByAbJQ5l0JHm+x5HOT+A1UM5tlVLH2HNDtNirohl/6jg7kCaRbjtX7MfubJ7yEEg1SZS07w5BOexBwh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GipQuQPs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C5AzFoAb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GjUMU017463;
	Sat, 8 Nov 2025 17:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0JzEYXLZhk+XPgEC4WpeH2fagEy4AWaKQdESXVSnsms=; b=
	GipQuQPs0/Pz8a02J5vqHXu1LI7kogsOXPavQheN+GUz9Bc6Z/toVnArxEt84ZNu
	T6BNv5rV2ANqdplZr1Nm8jNurCSF1ht/zWL1ORSU2ma+xmNeCDx3NHpj/u0S4oOV
	X9wRoFh6AwjP4Bt0Md7WOVoSaZ5NJOoVY9gRlpkVChs8+MBlemgLtDnomaBKTG6e
	JV5kdjNZbQA6oEuwlV6sNxN9DNNUWgFB8My1rjJ2AvxrJMZ4DtcVnb3Oi0JziFIs
	VaMLgv7m16g5CbFaM1/ZG2KP01vYnPiPuNWkjzQxM2YwXrT1evYcjmQ+k1QOfc2T
	VNKI78GEf9w9tLQY0twXSQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa8se01ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GXJIh000746;
	Sat, 8 Nov 2025 17:09:16 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012012.outbound.protection.outlook.com [40.93.195.12])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaaps7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2VYmo1J/LW4Ad3kl/buFGWJrRh41qEz3f3Zn/s05ibABS2I73Xzy8dGkZ/j3W1ujuZTQ+9MgqFJEn7OClc6iXKd08SCc7KFOB+FzyqDLeEUSUKYwVSl8pzNwiPIInzPrPehfKKAzI3vuFnVw9T24ZH4q8al4uaeWk0BZpzmEa8DzHeGwZmo0R1dSD0ABYH6UObd4rUK8uLfWpUBB/0/+endqke4+YX7h7NSReDsok7amqf9psNqUotXkRlLCiyqn7ZrNad3oGo/acwhKl5LVj3lLEY3SgnqbQwgn0heTlYVHp1CNa2qd5rXNIYkt+Wd7B1iFTV/6vDaIR68XERJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JzEYXLZhk+XPgEC4WpeH2fagEy4AWaKQdESXVSnsms=;
 b=fq/lh9m8MAb/PNQWM7kZ+g2nJWYrkPEQAyoyEOokhKTcKWYx8pbC1fFa9VHR9Io2ToVSi+JcjKrZqCy7ATcwNXXwAWSdOZagE7XStlCKAkoTU1AiZRa503SzmG7ykrA8jd5LOxCwrC4N6COJDEaFx4G7vT5qKeyXgOLgqukHUEWhhoTz7WXuJxGLpjh/r2zmsptt1gyQgb0jJc3ffSexedPtSSnDqqaounhsAoIXk9H0WgBgSnc0CW5P03IYRn0CeSeBZgCPVXXBRZsvH/LnQuusLQ1GEoGP1INoRxbfTJT0/rCj23M7v821tWtptFu1Jcgz8eGBv2K6rge2KEAq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JzEYXLZhk+XPgEC4WpeH2fagEy4AWaKQdESXVSnsms=;
 b=C5AzFoAbrIJ8i6ka/Kl4kBWWhWJHgaBrGQz/r2kkeuZmucTjBiW6PCYXzLV0G8aLGnhhAUhWRvxJepKN/QpXJL2IPy4JKSWrVxQjvFiT5kIXO358RrBP8RB64XSI/ToS2W4M9KJgUhsrLX8DpkTVOGcSGGqETwjvU4i3nQQZOvE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:09 +0000
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
Subject: [PATCH v2 07/16] mm: avoid unnecessary use of is_swap_pmd()
Date: Sat,  8 Nov 2025 17:08:21 +0000
Message-ID: <113e97a7319cd39c9e59b3baef40dc57ba9c7610.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0650.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d72be40-c8f3-416d-54f0-08de1ee987e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMc8sWBm37x3rKxooeRXfC+rHXq+TwuoVROWR4bOcCQedAXffVK51l5B0pRb?=
 =?us-ascii?Q?3uODy0fImeyDh81K/wg9neI0qzvk6x9G2TxtRQhp1sbopsTwie5pscqoVAem?=
 =?us-ascii?Q?0IWlWKE7a5oowYaYPFazKNSA/agwk74dxJtue4mujaY4xIRSH+nDz1gfOW8D?=
 =?us-ascii?Q?LLRaDmrLVM2Vx0K8FA4ytqNjMzzSjLfGfmYwW/uPUaQJhXS41WodAo9P7w5k?=
 =?us-ascii?Q?kTsSmSO2ed9+X7wcOWl7gebYVLNY7sWnHIg+Hvu7huUlrG0rtb13X9QDK3HU?=
 =?us-ascii?Q?pdYmSrl1o3wTyu0FbGS5wjappjgF71I6uQlFtYw88ZuZgp5+344TbGxTQXba?=
 =?us-ascii?Q?338yECsHmI0P3AIsJYgLZZ3bMgqBJw3y3hu97FSKm+NBRTzeDTYw0BKvugeQ?=
 =?us-ascii?Q?A4JQoU75KoztzKwFw4UKJx4iWBzbp3v8l/kViV2Lgzr2y+vcuADvXRdLdd5s?=
 =?us-ascii?Q?w1d6JCUvj1RN9pMtGdazypFPdErdmKhf2hCNbeVq7fizqbyiO/By09EDdfNn?=
 =?us-ascii?Q?3rmwrmv6BcVux74HToy+AhMfClLW6JGTABor7Z+RKmQHyKT2vyxiigrJnXG1?=
 =?us-ascii?Q?fMyyBMesHeJVMvJwcwIpD6QpOyEE3KMv5XSM/IVy1chQe9jDYqIiOA3VWidx?=
 =?us-ascii?Q?P9GNYpmwbHQNfuJrTHBmCyPMcGMI8m+V8PFr2/sbVkusbx/yjTkWloLHGvZb?=
 =?us-ascii?Q?LyNNZRYwzeIuGsBMxJ8TKme4zp3bllCLKMQ0zyJ+Nks7KfdO/EAfx5T59ubi?=
 =?us-ascii?Q?vN1cmC10DSIvX1xpWGiCMQpXZVyo/wexW7ku6SgHvpiV0sberTjezFXwiYqh?=
 =?us-ascii?Q?2PuSldE5zZgnyWSt0HurSHPq+diJtiWY+MR7E3KCPm5AuPhGxYj4HMSo2NBS?=
 =?us-ascii?Q?miFmzEOdceJohnbSRQLmBz7ZA1O3myvP2/fqVLD3YMmTgzc+jRgTqYiG/er7?=
 =?us-ascii?Q?QpgHs/pWgmfHma6h1ppC097RWM7lEgS+By556DHfWvEo5Z4bSRvjAnTFvGWk?=
 =?us-ascii?Q?EN5cJpqnnQJq7A7NSpjS1RUCWfjZdPPfdLBNcYLmAbC9ke2u3OdHgC43lQsC?=
 =?us-ascii?Q?wsWOikMcsF8mmu+nvYNPifiMxyvOPB89Yo95OxKiGbbX7lTWLvL2rHTggwH1?=
 =?us-ascii?Q?7ti8bUrV1soyZ7ZOfmvKyyJUev+f2M6Ci7e+sBPgvnyw5kb+KTGnzVDj3gOo?=
 =?us-ascii?Q?0pIe+X7INVBOkIsNOqzzzyvyMt8A14HVI9TEM2gFPHOYU8eaWeqK1W1BW/m3?=
 =?us-ascii?Q?mn89w7EGb3AlTzerAUDsOY1jAQEMRomP3TdtOoNG+VJG0iry4BHdNOrbt0nw?=
 =?us-ascii?Q?D0n6ma2u7SsVAFLlpDQHq9j+Gp91gJUqcLKMegpuhnGZI6Jm19m8wCT/SpZW?=
 =?us-ascii?Q?khZHZww9dz1+YAzm8zr+aepnhOswrpsHkF1xRu2DOY2hd9cDhTU9C4eu8aIA?=
 =?us-ascii?Q?JKjt9JnI5n9dj/sECgk/3QqVjdqOdpxz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNAmA074Uj0Nx9gV/BK25o2boXC4Dd2ALJYAcwHM4w6/gl12B7u3NwKLY8AO?=
 =?us-ascii?Q?f1nFF8NwOhGG1X8AvaNfg+RLRZk2bK1IwtGXPyOsg3vquZN+Got98Q3wZrE4?=
 =?us-ascii?Q?PMKUdXpqQAcll9xUDxa2XGmER1Qe71fxC6UUxRVMxfOFJq3DBnnrG/BDC6cW?=
 =?us-ascii?Q?3WYGpbRLPbT1RAH0UzWsNpsT1QjkyE1fcMhc+aPTPGvktay0Es6mUWYPMe5A?=
 =?us-ascii?Q?F+gICiH/ZNCh/s4bfPect/DI8qw59W+kHXj7kRhzRKUd2XEXsMkEQgb+jgVh?=
 =?us-ascii?Q?vkrEaKqpvvfVU6bjszqI/sTercMfkwTP8CLcc9UQ6MLpeHlIzm0PyFZc8W2P?=
 =?us-ascii?Q?c6i7yq8IdgDMD89N6DEcXHNA5Xp5Vo9nbDgcwfCSKxg7IXlFVO6PgxUGnNv0?=
 =?us-ascii?Q?/0RyT2HkrMC+YoNl2+8QU3jkc0PEiNeR3hLozIICY0kuvxZ+skelee/cIhvB?=
 =?us-ascii?Q?VO/3Dxv2gCTSJRN1tqplBT+WNnACdy8m5025VI6+MJQ3uiC9bCQfcdAzPGQ6?=
 =?us-ascii?Q?X5JUKxVoinUEr4+YiYZA1UiJEJYzMpwCRWPu7T2gvoi5i1eDWqAQ5IJdhnP1?=
 =?us-ascii?Q?E6Z4Wxm7OrEmb5bxSr191xN1+p3vp1431q0gxGeyrI3tvTHjgkPgyyflhGUt?=
 =?us-ascii?Q?4W6H1d16o2jYB51OfPchfQKqFvoEAYUWz+DipOpUcHzlydY8E7i6+varM2oI?=
 =?us-ascii?Q?8NOlfjbwa5RIdJgSf+hxleDTZSp3rZ0bnoQOFx0tgQdyK2tMAB9VQZYsmUvv?=
 =?us-ascii?Q?9gO9OY3NTuHiLD7wJRblwJs6bW2m5rleslv53nhHyT6IKl7lnXEYlrFU/N4n?=
 =?us-ascii?Q?KJheCLyk838tYEuLdBFRObdaxQxOaVshRR6yHGN/hybw7C/dkYZK15HEfIy+?=
 =?us-ascii?Q?OfBHDeraR6c6MQxF8FBh18DMxV2IinWfbPagTZvOvAhq6OWAE6kAPkwl0wzT?=
 =?us-ascii?Q?FvOOocrf6PnBpo13U8AM+83HMHkHXihiIA0OhlU44TaFLj/oeAviJY+VnfT+?=
 =?us-ascii?Q?jeRtt2Awwq+am6FTpIuN93LBBC9wkrUMmuEV9p8Js0iwN1MONGUqfSQRQ3E3?=
 =?us-ascii?Q?+9gp+UiCk0WWMd2PmYfxFFyZnjZ5LZh4QN0ufpO1G+AgLjBlzsZ91MYsuv6/?=
 =?us-ascii?Q?B8wocShC72+grKPiBrU9ewKmZHQFd6aZzB7jus5yww4KtSfJXLm+hWXMMImw?=
 =?us-ascii?Q?PxWvEY4PeHVStSebNQppAP4GxCsOPWwVDZKUZQXvXmdMseo+EfY1Ad9jGbG8?=
 =?us-ascii?Q?KOgylXHQnr7Tt2PNQaQpZQ0PJBKdyECjyqBQ7eUNCB8PGbyVPLqOOkUk0Thm?=
 =?us-ascii?Q?RX02IQoAdlEu3WW9CJ1o458JBDYby7AwBi1vEaki/IyjrSb8Ht+Xf21z5gWD?=
 =?us-ascii?Q?mDlTB3wd9EHjSSpom+zrmx2mC8azoRfRw80gz9BGfYEKIQzJPC9ZIiB7n5dk?=
 =?us-ascii?Q?xxhddkMI2HtD4utARnD/rRm46zVPpDKN3NfQoqdnooOWlU9hpH5UOIPyUToe?=
 =?us-ascii?Q?3IuwQHc13SQTMXtfdVNMzJ880NF/pyNIcstdCf7DQ1EyV9GzSgkAHxKJ8M88?=
 =?us-ascii?Q?0pFm8dnkMEeknoNK1GnD85pVFslCKtAjeWomFbXweNX7uCWz4mZ87ZfTgHV1?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	59TjAGfuUfriGb8SupONIb5DvtZw7SDRUN5QKf8fBXqrly5agv+Aat/FowGfuRmVr9Tp8hbmVYpXY2I/TK5eXUG4Y4af9K1OnIP8fBH6i+KXn3LL1FgBWaptlNRvwyXoUrTX47YefKCQGxVkhWZibEjOttcwEkJ6BV8pTQg7I82sd7CdJ7JMMfyZ2i6frEO0zfMqcJXggH5CP8lNyew/zKUp06b4+Nj5VcKfvjaVz7EA0Zeqj1sTlAkK/GkJ0fKsFZyavmIr5zEDe6mrtY+a0l7wLcfmrghJHP1Yx3BG/88VyrdzAX4bYcnFCcM1z6VB8XB7UNrePULUQolNvX9qZmG8fC5nu5P7Q2H3OXF9AVwPCPynihNgpTWcUS+tPCj01T34agOXyvOvmvftfdtXSGTisgd5hOZDzSICVvZhPCNcHkmr/fPNEvxY/XOXuo2PnTMwfvhl6/+jHjmqYztyU5psoo+1NBBsqgRInEzdX/ttyThjYPiikL42LCVSIfsYQ3hO6jDJyxWYzh+zo0iE5K9WKJyVy4d80UIFOa7BdP8FgdMj6mLCiSawWWqBu3mlmu0ZLKoF3DEbMYule91h5x0qF1Z2nyZB2H7Sho17jFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d72be40-c8f3-416d-54f0-08de1ee987e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:09.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k3PnHtEKj6iaddCy0TbQNz2gC/2+7D2iiwuBBXtND4Zji9JAgpfIhbLe385weWMlAtLTq01MIKqyYysVZUg3Nl+XG4lDxbUL4AWx635f0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511080138
X-Proofpoint-GUID: YKM0l74Kqd0y9o4r67rP-U8SzaM6CAcW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEyNiBTYWx0ZWRfX0lsnixYacQh2
 izdtSDSjwgiAG5MKrQ04y8mXQLhUQOaXU5vwh+2UaTpKhMRU7m7bDUvird82qlUNmRxAT4d7GOF
 JzNVFoOxQuiWpfMwSCDbJ0VLU+TzCEZA/HoXl6/Ex63MbloqH+055iyIw2iiP1GW1jy7rUzV74B
 byNFANIFnDmsR1MBnjoglrLAN2BZsgfTYjWUXchoxRW0E9DdHUcaV0AB6FXbrBcIZu1tsjjADV7
 Ik0yDw2XDVlxWY1mYfdpUnf544ahaiSXR5z0+YQjNGwLc/fSw80MEblHTYBjtOn5QLhbLyOlpYC
 CB3oP7iFB8CmMgFzdAeEgSzxy0b2B5vdR7M3/c/nzqLwXXRDowiRrmobJlW1hnCndHBet5kH4Ey
 yo3P5kE+OHoAfxHtUfCX+SihyJdmM/INo3dou0o2hzc+1T0p9rc=
X-Authority-Analysis: v=2.4 cv=XuL3+FF9 c=1 sm=1 tr=0 ts=690f793e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=96_WKPqrBKIKR3zHGkMA:9 cc=ntf awl=host:13629
X-Proofpoint-ORIG-GUID: YKM0l74Kqd0y9o4r67rP-U8SzaM6CAcW

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
index 5ca18bd3b2d0..b68eabb26f29 100644
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
index 7493ed084b99..fea079e5fb90 100644
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


