Return-Path: <linux-fsdevel+bounces-67540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33801C430C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32BC54E81D4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1C2580FF;
	Sat,  8 Nov 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PnNJohfD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mt3BOkP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF85A2512FC;
	Sat,  8 Nov 2025 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621872; cv=fail; b=Fs4dbf1NiVYyEGY1VJsukI+2aOzeHSfp2aBDUFDmGUbok8OBPtt+81SnedvPPmaC31+sBvc5Q6gjuOVrcbD4Wj2fhLUS1NEUfVpgy1KyNlgTVSOv/E9UMorgqK/TZGLYOONlj8hE8AiLSMGPwkaCvO3kPfdwY38vP/W1d7lZQaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621872; c=relaxed/simple;
	bh=k0ElxpmS9HwZwo7xmLghbhMxnGpvnsPjGlxz7Jr4dHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N48QhouHvXTCX6umi6tDsliG4r8oN0x3Bx78O+72u/wPmW9Pcssd6WS90dYihfrfOP3jA5SuWyYMB0IqjtURy74YV2VjFnRvRcwLqnUzYedDOPm5NtiO2DmrxoRmlrwFxvhqpIoJdvIGyVfkaDZ1ygahx5YtLJRw9l91hhlBGKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PnNJohfD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mt3BOkP9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GfxDM009610;
	Sat, 8 Nov 2025 17:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Au3FCKtwkRYNsFHZTSml++AMw+FgHqiZR3qsM68TKXE=; b=
	PnNJohfDQ+ScUvmLRIbxVDfZPXgZzq7u0n8AOS5ELn0wlXd1Cj/LbpqFQ3Xaz33o
	2o6+szqtiIuSp+OCROx67QRzIBt2Ba8uOotSRzGdkzS0rAwiAAJY1XBYdCgUnRmI
	FWkuN4N6m1l7OjtSK6MeF5EISqKSGL1qTWWdny+qL2YWhG+fVGUCdnZUCzpN7wTy
	f+DBPLAFuT9dZqXoL0xGpkbeX7sDnaWukv1NOygZfZ+AUEj7hxAwS/Pc1rc/9icX
	OrXs3G3GnT3yIneYzskU8vadzcRTQoGO/GCLPa+NncF4AsvPiA/sZa83f8I4FlAV
	j4UeGgl9Kqxzwb9WKKfDOA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa9k8g0hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GoW0U007552;
	Sat, 8 Nov 2025 17:09:01 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76mus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPJ1lHALHLSHWdHlIRjElVcl+7bXb38lV1DKzBg8DGOU69cpakSgNic/mjdhxPS09/PCPGm8l44MnU8wGdc918gRog2mrpxDH7wdrONwHEMPFL+IK/iG0YGFe6aaBXEofArTBwip3ZW0TVQGAp+YtKcJmKk76HkATrx9Z88oMJ2F9raYwcoDmciTiOrDv4De2R2ReUmLAKGOSba+C3vIkLhPwXC0H3m/E/jaW1OjrIM/sIuEOVtSMTlFKvuTlZjFLRFufIayeHv5Tt2adTWKd9RqbvpN99AWUH6Et/V4ZciwBNNyXIDTXHCY+m1tFQDODvc4bxGBk8X0/NUmsglNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au3FCKtwkRYNsFHZTSml++AMw+FgHqiZR3qsM68TKXE=;
 b=NnzMYe49Pd4Qf3S/aw/T4Nay4AjdK5qdhCXGoaq3ydjMhvAKmLcc1Kr+fWpCf1+g4a+4GESp5FwYBOLKGt8jIbS5DmWeryNg2sXYDxKUwlGR1AoM4XP/LJg35SdYeZIfQtiQbk93Yay/lD1awHuV1dyq5HcrofYOlTuL4JWG2fPf36h71DbY/h0hCZyN/jN3llKrtHSh0TjI9Yetb4pYiObS3yxzhynDEtzfQWyZy1xu8+R1GawCWs+mYtVUf9y6SO3fY5j3ZZ6Rg3VfIjB+7xAFla/ka+A2vhQNkwWyUCZ70kkR3z+eBDuQRRFXzzy68LUj++juN1eWqLTStWuJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au3FCKtwkRYNsFHZTSml++AMw+FgHqiZR3qsM68TKXE=;
 b=mt3BOkP9Jmv/LJaGn6cqWXIIx69fKGTteQJpzodgJNynbViLkMq04+vaLxc9c6BpCEpH4NDnwboRDqqPrkPKq4xmwfcmJ3PjDHse5FXMKqO8PlMb68xFgYmgU9QUtTgMO2VTw+dz09PvUAcSWB9HD80A3o/D1h0UU7rGV223SNs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:08:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:08:54 +0000
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
Subject: [PATCH v2 02/16] mm: introduce leaf entry type and use to simplify leaf entry logic
Date: Sat,  8 Nov 2025 17:08:16 +0000
Message-ID: <cd103d9bdc8c0dbb63a0361599b02081520191b4.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0097.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 607fb913-4c0e-4082-524b-08de1ee97f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qzxHBqiYkWUIN5l1nSIEUHJ6ZOvuE0+y8SuaBOsWpS+mpNwroCAQkjQ6aPGe?=
 =?us-ascii?Q?lAIFfUe938Quui0YlckaKcYY6+AKptLy4ec94wKszZYC14I+4Bt0FGXuqE6U?=
 =?us-ascii?Q?FzupAsa52ygVOuCQy6J71YF8CUs8PGjRz5ugTLup72yqT7jQJ47+g7jYdjIl?=
 =?us-ascii?Q?uNBkpLSqTyAIl2eYfEAYfsoqXcKY4utT5kgh11incJarBfqrEbk1HXGLZsFO?=
 =?us-ascii?Q?24AJi3hl8Hum8eVK0MurKmnG9x9Azp26MbCrPqliBdrt/DCdUVz1OCCdyfuK?=
 =?us-ascii?Q?XFG4p6mDuR1juhJ0P4PqrjhWpMTagvWSaB5yegtgp06602afczWx87XkiKQH?=
 =?us-ascii?Q?nq/fy7brNeUlEwmlR6iWxb/8apakqfBit/xnSbaRaskUlnfHVT3bytUPQeQ2?=
 =?us-ascii?Q?vHHiLq06fOoErvnyw4OYIA5FvUJ/JRS83xx6eL+b1bP0LfEDdil2rp2weAOa?=
 =?us-ascii?Q?As6Sk1OM6GCaBo0sG0kKUAnG9iwW0Qv1INJnnytDWdi2Vcv8G4VJME7T6hE4?=
 =?us-ascii?Q?Dg343m4ZXDevUZzkKHxTlv7BHu2lLXtPmwiPO1Fk1/eJabqed9exiTgFQpWq?=
 =?us-ascii?Q?cEHNUssoY6WYmsL8qxtgD70aXuk4QOb67pzVJZaLjLJJ/5DcGDqbfDVooD4e?=
 =?us-ascii?Q?s7e8lp8QKYlEu+JcemrdO46HDPYJTa/5e9CVQvuf610DzejdP3H+1JsRqslC?=
 =?us-ascii?Q?hAoow76epzpiuWJhTnPuZbOQl5uams9fqe78/2OzvkR1v8BUvIQ4NkWwxAVh?=
 =?us-ascii?Q?AphmYGhlZfEuB0HHAYJx9Iu9897aR2oXYEQPTzHBcShjB4K5pvDREPuxbT9H?=
 =?us-ascii?Q?bkYsQlvH+HX9flr0bhI417Og9B9nMhTASbn/Pa1wybjzqseUFy50qrfOx9nV?=
 =?us-ascii?Q?sAbnvjZAAKUP+tfqIbFz4EYNv/01RdtgTKq1AlSLRAQGv6K4reH2dvzaNKO7?=
 =?us-ascii?Q?WvtMfmhGwCqKIv2R+GBAdC1bqm01Lgap6otDg64GdCNiTAdAdV7wrm13xJUf?=
 =?us-ascii?Q?ydRETAA3FBAKTGXwKWn9Jzh+4TMgwD1dFELxZxQZMkUTNILSQaj0hH7rXMbW?=
 =?us-ascii?Q?Q2IYvtQ8Sn/pdiqcCEv60YBaSzNXGVO2jOb8LnUB8mgbN5wEV2EPLVEhDrp+?=
 =?us-ascii?Q?ZEZQDXMpvUZPcXs0Ckn4kCDcOe+nYUkeGP/TcKrmCndVy+fvDx7wveAeTqX3?=
 =?us-ascii?Q?pOJFSKldVUwRol0wubkNs6X8SF9gckb6d6LN314bSSn69EzMUoGabD499gi/?=
 =?us-ascii?Q?UOh42DTuC1e6KiOlELQkh89wjxv49iSx+wbw1FqUgKXXuNF0IgkQzZdMRL2F?=
 =?us-ascii?Q?dZtGIxOENPcs3EaLPUTz4fdBlwEkHFrc/LY/F8/VcRfi+lM+9sWTF3DLeS88?=
 =?us-ascii?Q?P0L+z9ggQXx76Iphrbuu6EUmfGEn27kHAxpAgaqVf07rieNNGw4GZDmyPIJ7?=
 =?us-ascii?Q?sIhYqU3UVEwlmLGzdyoE92H2DRAqUAt+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0YjQ2WYApwsA4BSMnw/YveQfgksVI/78ExsknaalbXGY3UzSIDqRMjNhYcfr?=
 =?us-ascii?Q?cd2BPTvtsqwnwIsbMyjlRtqH9I2bvQ7n7njtP0CSsE4t38HdigS+fxMjzp/i?=
 =?us-ascii?Q?zWguv/S0EaG0YAwYmlX9BjexqmzF85gXukIccQKG1Bv4HpUlUBbJZkxhmfcy?=
 =?us-ascii?Q?g5x0IjROP7wPVAk1v4vOa+jSklJ0sl5U5CP4pYCzaDEw8azZcSMCA5rmbqCg?=
 =?us-ascii?Q?qFSP4fMz+Wb3aG0iz6lWbgXrLjeEHUrCBFvOlQwMSaQLFePL4qyPhpEeAnHw?=
 =?us-ascii?Q?FvXlWRXGeh/zFCN5UNHL0ExaqUu5vHmPOw9YSu0PK9Xvi7o8FqB1bdC+Jvwx?=
 =?us-ascii?Q?K5SbfEKxAAQtOrD35qrZ9c2yeeu3rv7Q02xN/MpfOUK9wRL2lazKL6mbekaB?=
 =?us-ascii?Q?n5BFArjqMt6lrOtgI+1wpp//c70T+LHOxXwGw9gSyvi3qiYbUyrpMh9ThbJJ?=
 =?us-ascii?Q?ejgFTzjaZ0PqXpjeIHaxiM7FgelIlGn8kz1GE2HVVLqaQ6CFaqljEXlaNs39?=
 =?us-ascii?Q?AGuQFHPhER7MDPhE4298rrKykoXBqxxIBx3dYRFHqelgE7MY700LxUjR5yaS?=
 =?us-ascii?Q?fyL0m50wkY/8yzQlwx94mEfs/QTZVflhK+GbypJBzAFrrsei1n86+z0wtrfv?=
 =?us-ascii?Q?S8F9zES75A64sDWua3eMyD7VjoBUCS86YIB6vgwR8CcTTiaQBqY2qFq8EW/g?=
 =?us-ascii?Q?Sa30yqedawnZ5qutWOGH5BxVn94WBkwfJmHBVf5tYVFPTpoASxZbzMHqLf+d?=
 =?us-ascii?Q?NjjnoWMImcmKBLpER61NJ9P59Ulxx2S+Wp/VUTjuqwNdgdo1XAc7TvQXNZ1C?=
 =?us-ascii?Q?OaRnHamD7o7l6PMVP6j8ZPoBVMgDcKsx0n4d8rwj4s+YW2jzfcTZvKnGPpzV?=
 =?us-ascii?Q?xjzKQdb9EThBi/3B2B2E1Z+O8FZgz0LFUV2PvTfpXRXxWjk+eJ6wqs35vYNz?=
 =?us-ascii?Q?ijTAEy2iVLppQuIeUmBbip7Jhr2CdJkzFwUZucecW+P//HsqUfKW01DSDGJg?=
 =?us-ascii?Q?A8ZVFg1k+TTdNC0/ozB4TA1UUZi3XDmbj8dfx8nnxG451XcoHpAFerhnabAx?=
 =?us-ascii?Q?8j61dzAoEyZN2TrpjN6I3M+KCLyWZU/cFeOChKOoX8oEtZ1/AgLkC3MOvxSb?=
 =?us-ascii?Q?lIVpbuSxo+KOLm8KXiWPEsBxW/hw3muw4H4JV8RbNEjoZllXUW3uXGyJK1U+?=
 =?us-ascii?Q?1Yl0Fo8YJfRTY/SWzV3xNuqIYq8VAjAql3VPN5PWbhchfzkrp1TwrwRbX0tP?=
 =?us-ascii?Q?lOmInExyUlG3YQrWRvZBmnRj3yrMlsr4NxeNLIGkW78bhl8EfVAjrL2KBNbY?=
 =?us-ascii?Q?Qmvqvkk/ChYbGqx177DiqAGkFCNiv3iUO9C3gKqcd9qjsfjc8RKR/ll3GSo7?=
 =?us-ascii?Q?uqPXEL2NpJ40v7A2TK8YBNtQu3css5JDqgYR9Tjtu95gWQWkOZnVAzumyI8q?=
 =?us-ascii?Q?c0x/P9RK8Yz4Dh1+QNYva2W2oGRZEe6tJMMSdAxnVk09uqMKn+S8voa7SUT9?=
 =?us-ascii?Q?dl+xYcGEuEwtDyDvdrV3SFCxz6VAqiqVFAc0W/XaM+Ylp/ovJGIfcefMo1QW?=
 =?us-ascii?Q?l4WAOr+Ws5DH5PO8t7XS13OmW1wrKNNRRDwkzDN6ODurqUZ1U18VJMqutdnB?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3zkyPO+OmlYwYErAiWSdTW+tp6irm2avXhijB/ZRSegqDqEpTC8efZp3SSVVxRg83CoyCdFLhChS87hmwxUfSczqy+6eyqi8C67DkrfDGsU6n7QgnnstmHZSNWqy/uA5srk74ArDPveyT1WVzykyD5OK5PrkoQlK6kP8+40BNKosQ34YW+VUAPlqGfsZMA8+TFKaWVOIvke/a6enKDDq+ruZw0v32slXNRSuSXWWnbvoVvoHUrMqPTezMnCBnkh9Ad69Yr9GIFAz7uhaxTS5Oy3/5a4i5KySALSfUyZfdB6cxBkUhbZTFQt+f93/hSxt1LeiLH7M6Fx6/BFOltpbX9wTdu5K8YEyv4ldZsBKVv9znfMzxJB9jQbeDr8l/BX2KPc+jmJL8gjMgRFjI0JXQ0/UcPO5Gcd4l1Hd2+V4l32T393aO2xYp1I7HdD9v3ecdu+sdIdMNGD0B8LICnIeUzKerkekHjY87PKk46htqbZrSDeMWM0CVr85enmUn7mflGYCs2UO+NPH3dPAms01bBSRlY2bITXsThiQhEymk4BG/H0R7ekf9BzLGz3PQzaYk8aCE13hYznIbc40+9rThohi4ULBw3B/HmJsiv+Ugyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607fb913-4c0e-4082-524b-08de1ee97f30
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:08:54.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjsApbNh0KuafM8nQcJPigcVBv0j7g6TxR13GMoW+F3s/cya/X8ZFrrW4m/gkb9QPtQFybCHSezVWDfANZYd/IanUAzkKKL/9+R9EJxus9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEzNCBTYWx0ZWRfX9YLIw8NNwIf7
 wIvmGOlOg2Si5zRrLkTrNXLKerykD+1NpLj+IEEJ15QQsHlWFHRg1oFkdBRls3micGvQ4sTnrEB
 FR/05RKpWHC3+gz+9ncB7PxLuncxO3RJcyw9YxBh/4tYaaqoXpzF0c2rw5X1yIunTIbV7Pufbaf
 yFBO2Rf9LqlC0KMrBjzkUE6VDQobNuPsEhvtCA+bTe6C2CDtma5RDSYo9xdMoaHKjgLgf/17ETX
 c7w2GlK5+gQYsvEkSB2g3JlqOp1hyfLxiCE06cK6LseUp7pzsDC33LR2pKOuIXI11XhIIaWiPqu
 PkVS6D9bgUY/Z6EsiS6RopogX6AmLj8Vqv6AmsGgdRI/oIzHGYeg1yXwCQJXQuOHTIgRQxWfOWj
 6H/mwYpRgiZNUEMtKcQQvW2xgaforw==
X-Proofpoint-ORIG-GUID: akdu_74Cy9eicrb-Xx8wSKIsjuxTex2S
X-Authority-Analysis: v=2.4 cv=U4ufzOru c=1 sm=1 tr=0 ts=690f792f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=Xv-3kFOuIgxVCAwDjsYA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: akdu_74Cy9eicrb-Xx8wSKIsjuxTex2S

The kernel maintains leaf page table entries which contain either:

- Nothing ('none' entries)
- Present entries (that is stuff the hardware can navigate without fault)
- Everything else that will cause a fault which the kernel handles

In the 'everything else' group we include swap entries, but we also include
a number of other things such as migration entries, device private entries
and marker entries.

Unfortunately this 'everything else' group expresses everything through
a swp_entry_t type, and these entries are referred to swap entries even
though they may well not contain a... swap entry.

This is compounded by the rather mind-boggling concept of a non-swap swap
entry (checked via non_swap_entry()) and the means by which we twist and
turn to satisfy this.

This patch lays the foundation for reducing this confusion.

We refer to 'everything else' as a 'software-define leaf entry' or
'softleaf'. for short And in fact we scoop up the 'none' entries into this
concept also so we are left with:

- Present entries.
- Softleaf entries (which may be empty).

This allows for radical simplification across the board - one can simply
convert any leaf page table entry to a leaf entry via softleaf_from_pte().

If the entry is present, we return an empty leaf entry, so it is assumed
the caller is aware that they must differentiate between the two categories
of page table entries, checking for the former via pte_present().

As a result, we can eliminate a number of places where we would otherwise
need to use predicates to see if we can proceed with leaf page table entry
conversion and instead just go ahead and do it unconditionally.

We do so where we can, adjusting surrounding logic as necessary to
integrate the new softleaf_t logic as far as seems reasonable at this
stage.

We typedef swp_entry_t to softleaf_t for the time being until the
conversion can be complete, meaning everything remains compatible
regardless of which type is used. We will eventually remove swp_entry_t
when the conversion is complete.

We introduce a new header file to keep things clear - leafops.h - this
imports swapops.h so can direct replace swapops imports without issue, and
we do so in all the files that require it.

Additionally, add new leafops.h file to core mm maintainers entry.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS                   |   1 +
 fs/proc/task_mmu.c            |  26 +--
 fs/userfaultfd.c              |   6 +-
 include/linux/leafops.h       | 382 ++++++++++++++++++++++++++++++++++
 include/linux/mm_inline.h     |   6 +-
 include/linux/mm_types.h      |  25 +++
 include/linux/swapops.h       |  28 ---
 include/linux/userfaultfd_k.h |  51 +----
 mm/hmm.c                      |   2 +-
 mm/hugetlb.c                  |  37 ++--
 mm/madvise.c                  |  16 +-
 mm/memory.c                   |  41 ++--
 mm/mincore.c                  |   6 +-
 mm/mprotect.c                 |   6 +-
 mm/mremap.c                   |   4 +-
 mm/page_vma_mapped.c          |  11 +-
 mm/shmem.c                    |   7 +-
 mm/userfaultfd.c              |   6 +-
 18 files changed, 497 insertions(+), 164 deletions(-)
 create mode 100644 include/linux/leafops.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2628431dcdfe..314910a70bbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16257,6 +16257,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/linux/gfp.h
 F:	include/linux/gfp_types.h
 F:	include/linux/highmem.h
+F:	include/linux/leafops.h
 F:	include/linux/memory.h
 F:	include/linux/mm.h
 F:	include/linux/mm_*.h
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc35a0543f01..24d26b49d870 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -14,7 +14,7 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/sched/mm.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/shmem_fs.h>
@@ -1230,11 +1230,11 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 	if (pte_present(ptent)) {
 		folio = page_folio(pte_page(ptent));
 		present = true;
-	} else if (is_swap_pte(ptent)) {
-		swp_entry_t swpent = pte_to_swp_entry(ptent);
+	} else {
+		const softleaf_t entry = softleaf_from_pte(ptent);
 
-		if (is_pfn_swap_entry(swpent))
-			folio = pfn_swap_entry_folio(swpent);
+		if (softleaf_has_pfn(entry))
+			folio = softleaf_to_folio(entry);
 	}
 
 	if (folio) {
@@ -1955,9 +1955,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_SWAP;
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
-		if (pte_marker_entry_uffd_wp(entry))
+		if (softleaf_is_uffd_wp_marker(entry))
 			flags |= PM_UFFD_WP;
-		if (is_guard_swp_entry(entry))
+		if (softleaf_is_guard_marker(entry))
 			flags |=  PM_GUARD_REGION;
 	}
 
@@ -2330,18 +2330,18 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 		if (pte_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
 	} else if (is_swap_pte(pte)) {
-		swp_entry_t swp;
+		softleaf_t entry;
 
 		categories |= PAGE_IS_SWAPPED;
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |= PAGE_IS_WRITTEN;
 
-		swp = pte_to_swp_entry(pte);
-		if (is_guard_swp_entry(swp))
+		entry = softleaf_from_pte(pte);
+		if (softleaf_is_guard_marker(entry))
 			categories |= PAGE_IS_GUARD;
 		else if ((p->masks_of_interest & PAGE_IS_FILE) &&
-			 is_pfn_swap_entry(swp) &&
-			 !folio_test_anon(pfn_swap_entry_folio(swp)))
+			 softleaf_has_pfn(entry) &&
+			 !folio_test_anon(softleaf_to_folio(entry)))
 			categories |= PAGE_IS_FILE;
 
 		if (pte_swp_soft_dirty(pte))
@@ -2466,7 +2466,7 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 {
 	unsigned long psize;
 
-	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
+	if (is_hugetlb_entry_hwpoisoned(ptent) || pte_is_marker(ptent))
 		return;
 
 	psize = huge_page_size(hstate_vma(vma));
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 04c66b5001d5..e33e7df36927 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -29,7 +29,7 @@
 #include <linux/ioctl.h>
 #include <linux/security.h>
 #include <linux/hugetlb.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/miscdevice.h>
 #include <linux/uio.h>
 
@@ -251,7 +251,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	if (huge_pte_none(pte))
 		return true;
 	/* UFFD PTE markers require handling. */
-	if (is_uffd_pte_marker(pte))
+	if (pte_is_uffd_marker(pte))
 		return true;
 	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
@@ -330,7 +330,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (pte_none(ptent))
 		goto out;
 	/* UFFD PTE markers require handling. */
-	if (is_uffd_pte_marker(ptent))
+	if (pte_is_uffd_marker(ptent))
 		goto out;
 	/* If VMA has UFFD WP faults enabled and WP fault, wait for handler. */
 	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
new file mode 100644
index 000000000000..1376589d94b0
--- /dev/null
+++ b/include/linux/leafops.h
@@ -0,0 +1,382 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Describes operations that can be performed on software-defined page table
+ * leaf entries. These are abstracted from the hardware page table entries
+ * themselves by the softleaf_t type, see mm_types.h.
+ */
+#ifndef _LINUX_LEAFOPS_H
+#define _LINUX_LEAFOPS_H
+
+#include <linux/mm_types.h>
+#include <linux/swapops.h>
+#include <linux/swap.h>
+
+#ifdef CONFIG_MMU
+
+/* Temporary until swp_entry_t eliminated. */
+#define LEAF_TYPE_SHIFT SWP_TYPE_SHIFT
+
+enum softleaf_type {
+	/* Fundamental types. */
+	SOFTLEAF_NONE,
+	SOFTLEAF_SWAP,
+	/* Migration types. */
+	SOFTLEAF_MIGRATION_READ,
+	SOFTLEAF_MIGRATION_READ_EXCLUSIVE,
+	SOFTLEAF_MIGRATION_WRITE,
+	/* Device types. */
+	SOFTLEAF_DEVICE_PRIVATE_READ,
+	SOFTLEAF_DEVICE_PRIVATE_WRITE,
+	SOFTLEAF_DEVICE_EXCLUSIVE,
+	/* H/W posion types. */
+	SOFTLEAF_HWPOISON,
+	/* Marker types. */
+	SOFTLEAF_MARKER,
+};
+
+/**
+ * softleaf_mk_none() - Create an empty ('none') leaf entry.
+ * Returns: empty leaf entry.
+ */
+static inline softleaf_t softleaf_mk_none(void)
+{
+	return ((softleaf_t) { 0 });
+}
+
+/**
+ * softleaf_from_pte() - Obtain a leaf entry from a PTE entry.
+ * @pte: PTE entry.
+ *
+ * If @pte is present (therefore not a leaf entry) the function returns an empty
+ * leaf entry. Otherwise, it returns a leaf entry.
+ *
+ * Returns: Leaf entry.
+ */
+static inline softleaf_t softleaf_from_pte(pte_t pte)
+{
+	if (pte_present(pte))
+		return softleaf_mk_none();
+
+	/* Temporary until swp_entry_t eliminated. */
+	return pte_to_swp_entry(pte);
+}
+
+/**
+ * softleaf_is_none() - Is the leaf entry empty?
+ * @entry: Leaf entry.
+ *
+ * Empty entries are typically the result of a 'none' page table leaf entry
+ * being converted to a leaf entry.
+ *
+ * Returns: true if the entry is empty, false otherwise.
+ */
+static inline bool softleaf_is_none(softleaf_t entry)
+{
+	return entry.val == 0;
+}
+
+/**
+ * softleaf_type() - Identify the type of leaf entry.
+ * @enntry: Leaf entry.
+ *
+ * Returns: the leaf entry type associated with @entry.
+ */
+static inline enum softleaf_type softleaf_type(softleaf_t entry)
+{
+	unsigned int type_num;
+
+	if (softleaf_is_none(entry))
+		return SOFTLEAF_NONE;
+
+	type_num = entry.val >> LEAF_TYPE_SHIFT;
+
+	if (type_num < MAX_SWAPFILES)
+		return SOFTLEAF_SWAP;
+
+	switch (type_num) {
+#ifdef CONFIG_MIGRATION
+	case SWP_MIGRATION_READ:
+		return SOFTLEAF_MIGRATION_READ;
+	case SWP_MIGRATION_READ_EXCLUSIVE:
+		return SOFTLEAF_MIGRATION_READ_EXCLUSIVE;
+	case SWP_MIGRATION_WRITE:
+		return SOFTLEAF_MIGRATION_WRITE;
+#endif
+#ifdef CONFIG_DEVICE_PRIVATE
+	case SWP_DEVICE_WRITE:
+		return SOFTLEAF_DEVICE_PRIVATE_WRITE;
+	case SWP_DEVICE_READ:
+		return SOFTLEAF_DEVICE_PRIVATE_READ;
+	case SWP_DEVICE_EXCLUSIVE:
+		return SOFTLEAF_DEVICE_EXCLUSIVE;
+#endif
+#ifdef CONFIG_MEMORY_FAILURE
+	case SWP_HWPOISON:
+		return SOFTLEAF_HWPOISON;
+#endif
+	case SWP_PTE_MARKER:
+		return SOFTLEAF_MARKER;
+	}
+
+	/* Unknown entry type. */
+	VM_WARN_ON_ONCE(1);
+	return SOFTLEAF_NONE;
+}
+
+/**
+ * softleaf_is_swap() - Is this leaf entry a swap entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a swap entry, otherwise false.
+ */
+static inline bool softleaf_is_swap(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_SWAP;
+}
+
+/**
+ * softleaf_is_swap() - Is this leaf entry a migration entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a migration entry, otherwise false.
+ */
+static inline bool softleaf_is_migration(softleaf_t entry)
+{
+	switch (softleaf_type(entry)) {
+	case SOFTLEAF_MIGRATION_READ:
+	case SOFTLEAF_MIGRATION_READ_EXCLUSIVE:
+	case SOFTLEAF_MIGRATION_WRITE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * softleaf_is_device_private() - Is this leaf entry a device private entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a device private entry, otherwise false.
+ */
+static inline bool softleaf_is_device_private(softleaf_t entry)
+{
+	switch (softleaf_type(entry)) {
+	case SOFTLEAF_DEVICE_PRIVATE_WRITE:
+	case SOFTLEAF_DEVICE_PRIVATE_READ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool softleaf_is_device_exclusive(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_DEVICE_EXCLUSIVE;
+}
+
+/**
+ * softleaf_is_hwpoison() - Is this leaf entry a hardware poison entry?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a hardware poison entry, otherwise false.
+ */
+static inline bool softleaf_is_hwpoison(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_HWPOISON;
+}
+
+/**
+ * softleaf_is_marker() - Is this leaf entry a marker?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a marker entry, otherwise false.
+ */
+static inline bool softleaf_is_marker(softleaf_t entry)
+{
+	return softleaf_type(entry) == SOFTLEAF_MARKER;
+}
+
+/**
+ * softleaf_to_marker() - Obtain marker associated with leaf entry.
+ * @entry: Leaf entry, softleaf_is_marker(@entry) must return true.
+ *
+ * Returns: Marker associated with the leaf entry.
+ */
+static inline pte_marker softleaf_to_marker(softleaf_t entry)
+{
+	VM_WARN_ON_ONCE(!softleaf_is_marker(entry));
+
+	return swp_offset(entry) & PTE_MARKER_MASK;
+}
+
+/**
+ * softleaf_has_pfn() - Does this leaf entry encode a valid PFN number?
+ * @entry: Leaf entry.
+ *
+ * A pfn swap entry is a special type of swap entry that always has a pfn stored
+ * in the swap offset. They can either be used to represent unaddressable device
+ * memory, to restrict access to a page undergoing migration or to represent a
+ * pfn which has been hwpoisoned and unmapped.
+ *
+ * Returns: true if the leaf entry encodes a PFN, otherwise false.
+ */
+static inline bool softleaf_has_pfn(softleaf_t entry)
+{
+	/* Make sure the swp offset can always store the needed fields. */
+	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
+
+	if (softleaf_is_migration(entry))
+		return true;
+	if (softleaf_is_device_private(entry))
+		return true;
+	if (softleaf_is_device_exclusive(entry))
+		return true;
+	if (softleaf_is_hwpoison(entry))
+		return true;
+
+	return false;
+}
+
+/**
+ * softleaf_to_pfn() - Obtain PFN encoded within leaf entry.
+ * @entry: Leaf entry, softleaf_has_pfn(@entry) must return true.
+ *
+ * Returns: The PFN associated with the leaf entry.
+ */
+static inline unsigned long softleaf_to_pfn(softleaf_t entry)
+{
+	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+
+	/* Temporary until swp_entry_t eliminated. */
+	return swp_offset_pfn(entry);
+}
+
+/**
+ * softleaf_to_page() - Obtains struct page for PFN encoded within leaf entry.
+ * @entry: Leaf entry, softleaf_has_pfn(@entry) must return true.
+ *
+ * Returns: Pointer to the struct page associated with the leaf entry's PFN.
+ */
+static inline struct page *softleaf_to_page(softleaf_t entry)
+{
+	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+
+	/* Temporary until swp_entry_t eliminated. */
+	return pfn_swap_entry_to_page(entry);
+}
+
+/**
+ * softleaf_to_folio() - Obtains struct folio for PFN encoded within leaf entry.
+ * @entry: Leaf entry, softleaf_has_pfn(@entry) must return true.
+ *
+ * Returns: Pointer to the struct folio associated with the leaf entry's PFN.
+ * Returns:
+ */
+static inline struct folio *softleaf_to_folio(softleaf_t entry)
+{
+	VM_WARN_ON_ONCE(!softleaf_has_pfn(entry));
+
+	/* Temporary until swp_entry_t eliminated. */
+	return pfn_swap_entry_folio(entry);
+}
+
+/**
+ * softleaf_is_poison_marker() - Is this leaf entry a poison marker?
+ * @entry: Leaf entry.
+ *
+ * The poison marker is set via UFFDIO_POISON. Userfaultfd-specific.
+ *
+ * Returns: true if the leaf entry is a poison marker, otherwise false.
+ */
+static inline bool softleaf_is_poison_marker(softleaf_t entry)
+{
+	if (!softleaf_is_marker(entry))
+		return false;
+
+	return softleaf_to_marker(entry) & PTE_MARKER_POISONED;
+}
+
+/**
+ * softleaf_is_guard_marker() - Is this leaf entry a guard region marker?
+ * @entry: Leaf entry.
+ *
+ * Returns: true if the leaf entry is a guard marker, otherwise false.
+ */
+static inline bool softleaf_is_guard_marker(softleaf_t entry)
+{
+	if (!softleaf_is_marker(entry))
+		return false;
+
+	return softleaf_to_marker(entry) & PTE_MARKER_GUARD;
+}
+
+/**
+ * softleaf_is_uffd_wp_marker() - Is this leaf entry a userfautlfd write protect
+ * marker?
+ * @entry: Leaf entry.
+ *
+ * Userfaultfd-specific.
+ *
+ * Returns: true if the leaf entry is a UFFD WP marker, otherwise false.
+ */
+static inline bool softleaf_is_uffd_wp_marker(softleaf_t entry)
+{
+	if (!softleaf_is_marker(entry))
+		return false;
+
+	return softleaf_to_marker(entry) & PTE_MARKER_UFFD_WP;
+}
+
+/**
+ * pte_is_marker() - Does the PTE entry encode a marker leaf entry?
+ * @pte: PTE entry.
+ *
+ * Returns: true if this PTE is a marker leaf entry, otherwise false.
+ */
+static inline bool pte_is_marker(pte_t pte)
+{
+	return softleaf_is_marker(softleaf_from_pte(pte));
+}
+
+/**
+ * pte_is_uffd_wp_marker() - Does this PTE entry encode a userfaultfd write
+ * protect marker leaf entry?
+ * @pte: PTE entry.
+ *
+ * Returns: true if this PTE is a UFFD WP marker leaf entry, otherwise false.
+ */
+static inline bool pte_is_uffd_wp_marker(pte_t pte)
+{
+	const softleaf_t entry = softleaf_from_pte(pte);
+
+	return softleaf_is_uffd_wp_marker(entry);
+}
+
+/**
+ * pte_is_uffd_marker() - Does this PTE entry encode a userfault-specific marker
+ * leaf entry?
+ * @entry: Leaf entry.
+ *
+ * It's useful to be able to determine which leaf entries encode UFFD-specific
+ * markers so we can handle these correctly.
+ *
+ * Returns: true if this PTE entry is a UFFD-specific marker, otherwise false.
+ */
+static inline bool pte_is_uffd_marker(pte_t pte)
+{
+	const softleaf_t entry = softleaf_from_pte(pte);
+
+	if (!softleaf_is_marker(entry))
+		return false;
+
+	/* UFFD WP, poisoned swap entries are UFFD-handled. */
+	if (softleaf_is_uffd_wp_marker(entry))
+		return true;
+	if (softleaf_is_poison_marker(entry))
+		return true;
+
+	return false;
+}
+
+#endif  /* CONFIG_MMU */
+#endif  /* _LINUX_SWAPOPS_H */
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f6a2b2d20016..ca7a18351797 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -8,7 +8,7 @@
 #include <linux/swap.h>
 #include <linux/string.h>
 #include <linux/userfaultfd_k.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
@@ -541,9 +541,9 @@ static inline bool mm_tlb_flush_nested(const struct mm_struct *mm)
  * The caller should insert a new pte created with make_pte_marker().
  */
 static inline pte_marker copy_pte_marker(
-		swp_entry_t entry, struct vm_area_struct *dst_vma)
+		softleaf_t entry, struct vm_area_struct *dst_vma)
 {
-	pte_marker srcm = pte_marker_get(entry);
+	const pte_marker srcm = softleaf_to_marker(entry);
 	/* Always copy error entries. */
 	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5021047485a9..4f66a3206a63 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -285,6 +285,31 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+/**
+ * typedef softleaf_t - Describes a page table software leaf entry, abstracted
+ * from its architecture-specific encoding.
+ *
+ * Page table leaf entries are those which do not reference any descendent page
+ * tables but rather either reference a data page, are an empty (or 'none'
+ * entry), or contain a non-present entry.
+ *
+ * If referencing another page table or a data page then the page table entry is
+ * pertinent to hardware - that is it tells the hardware how to decode the page
+ * table entry.
+ *
+ * Otherwise it is a software-defined leaf page table entry, which this type
+ * describes. See leafops.h and specifically @softleaf_type for a list of all
+ * possible kinds of software leaf entry.
+ *
+ * A softleaf_t entry is abstracted from the hardware page table entry, so is
+ * not architecture-specific.
+ *
+ * NOTE: While we transition from the confusing swp_entry_t type used for this
+ *       purpose, we simply alias this type. This will be removed once the
+ *       transition is complete.
+ */
+typedef swp_entry_t softleaf_t;
+
 #if defined(CONFIG_MEMCG) || defined(CONFIG_SLAB_OBJ_EXT)
 /* We have some extra room after the refcount in tail pages. */
 #define NR_PAGES_IN_LARGE_FOLIO
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index d1f665935cfc..0a4b3f51ecf5 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -426,21 +426,6 @@ static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 	return swp_entry(SWP_PTE_MARKER, marker);
 }
 
-static inline bool is_pte_marker_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_PTE_MARKER;
-}
-
-static inline pte_marker pte_marker_get(swp_entry_t entry)
-{
-	return swp_offset(entry) & PTE_MARKER_MASK;
-}
-
-static inline bool is_pte_marker(pte_t pte)
-{
-	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
-}
-
 static inline pte_t make_pte_marker(pte_marker marker)
 {
 	return swp_entry_to_pte(make_pte_marker_entry(marker));
@@ -451,24 +436,11 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
 	return make_pte_marker_entry(PTE_MARKER_POISONED);
 }
 
-static inline int is_poisoned_swp_entry(swp_entry_t entry)
-{
-	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
-
-}
-
 static inline swp_entry_t make_guard_swp_entry(void)
 {
 	return make_pte_marker_entry(PTE_MARKER_GUARD);
 }
 
-static inline int is_guard_swp_entry(swp_entry_t entry)
-{
-	return is_pte_marker_entry(entry) &&
-		(pte_marker_get(entry) & PTE_MARKER_GUARD);
-}
-
 static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
 {
 	struct page *p = pfn_to_page(swp_offset_pfn(entry));
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index da0b4fcc566f..983c860a00f1 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -16,7 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <asm-generic/pgtable_uffd.h>
 #include <linux/hugetlb_inline.h>
 
@@ -434,32 +434,6 @@ static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
 	return userfaultfd_wp_unpopulated(vma);
 }
 
-static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
-{
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
-	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
-#else
-	return false;
-#endif
-}
-
-static inline bool pte_marker_uffd_wp(pte_t pte)
-{
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
-	swp_entry_t entry;
-
-	if (!is_swap_pte(pte))
-		return false;
-
-	entry = pte_to_swp_entry(pte);
-
-	return pte_marker_entry_uffd_wp(entry);
-#else
-	return false;
-#endif
-}
-
 /*
  * Returns true if this is a swap pte and was uffd-wp wr-protected in either
  * forms (pte marker or a normal swap pte), false otherwise.
@@ -473,31 +447,10 @@ static inline bool pte_swp_uffd_wp_any(pte_t pte)
 	if (pte_swp_uffd_wp(pte))
 		return true;
 
-	if (pte_marker_uffd_wp(pte))
+	if (pte_is_uffd_wp_marker(pte))
 		return true;
 #endif
 	return false;
 }
 
-
-static inline bool is_uffd_pte_marker(pte_t pte)
-{
-	swp_entry_t entry;
-
-	if (pte_present(pte))
-		return false;
-
-	entry = pte_to_swp_entry(pte);
-	if (!is_pte_marker_entry(entry))
-		return false;
-
-	/* UFFD WP, poisoned swap entries are UFFD handled. */
-	if (pte_marker_entry_uffd_wp(entry))
-		return true;
-	if (is_poisoned_swp_entry(entry))
-		return true;
-
-	return false;
-}
-
 #endif /* _LINUX_USERFAULTFD_K_H */
diff --git a/mm/hmm.c b/mm/hmm.c
index 43d4a91035ff..b11b4ebba945 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -244,7 +244,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	uint64_t pfn_req_flags = *hmm_pfn;
 	uint64_t new_pfn_flags = 0;
 
-	if (pte_none(pte) || pte_marker_uffd_wp(pte)) {
+	if (pte_none(pte) || pte_is_uffd_wp_marker(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 01c784547d1e..a05edefec1ca 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -28,7 +28,7 @@
 #include <linux/string_choices.h>
 #include <linux/string_helpers.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/jhash.h>
 #include <linux/numa.h>
 #include <linux/llist.h>
@@ -5662,17 +5662,17 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
-			swp_entry_t swp_entry = pte_to_swp_entry(entry);
+			softleaf_t softleaf = softleaf_from_pte(entry);
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
-			if (!is_readable_migration_entry(swp_entry) && cow) {
+			if (!is_readable_migration_entry(softleaf) && cow) {
 				/*
 				 * COW mappings require pages in both
 				 * parent and child to be set to read.
 				 */
-				swp_entry = make_readable_migration_entry(
-							swp_offset(swp_entry));
-				entry = swp_entry_to_pte(swp_entry);
+				softleaf = make_readable_migration_entry(
+							swp_offset(softleaf));
+				entry = swp_entry_to_pte(softleaf);
 				if (userfaultfd_wp(src_vma) && uffd_wp)
 					entry = pte_swp_mkuffd_wp(entry);
 				set_huge_pte_at(src, addr, src_pte, entry, sz);
@@ -5680,9 +5680,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
-		} else if (unlikely(is_pte_marker(entry))) {
-			pte_marker marker = copy_pte_marker(
-				pte_to_swp_entry(entry), dst_vma);
+		} else if (unlikely(pte_is_marker(entry))) {
+			const softleaf_t softleaf = softleaf_from_pte(entry);
+			const pte_marker marker = copy_pte_marker(softleaf, dst_vma);
 
 			if (marker)
 				set_huge_pte_at(dst, addr, dst_pte,
@@ -5798,7 +5798,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 
 	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
-	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+	if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
 	else {
 		if (need_clear_uffd_wp) {
@@ -6617,7 +6617,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
 	 */
-	if (unlikely(pte_marker_uffd_wp(vmf->orig_pte)))
+	if (unlikely(pte_is_uffd_wp_marker(vmf->orig_pte)))
 		new_pte = huge_pte_mkuffd_wp(new_pte);
 	set_huge_pte_at(mm, vmf->address, vmf->pte, new_pte, huge_page_size(h));
 
@@ -6750,9 +6750,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		return hugetlb_no_page(mapping, &vmf);
 
-	if (is_pte_marker(vmf.orig_pte)) {
+	if (pte_is_marker(vmf.orig_pte)) {
 		const pte_marker marker =
-			pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
+			softleaf_to_marker(softleaf_from_pte(vmf.orig_pte));
 
 		if (marker & PTE_MARKER_POISONED) {
 			ret = VM_FAULT_HWPOISON_LARGE |
@@ -7080,7 +7080,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * See comment about UFFD marker overwriting in
 	 * mfill_atomic_install_pte().
 	 */
-	if (!huge_pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
+	if (!huge_pte_none(dst_ptep) && !pte_is_uffd_marker(dst_ptep))
 		goto out_release_unlock;
 
 	if (folio_in_pagecache)
@@ -7201,8 +7201,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
 			/* Nothing to do. */
 		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
-			swp_entry_t entry = pte_to_swp_entry(pte);
-			struct folio *folio = pfn_swap_entry_folio(entry);
+			softleaf_t entry = softleaf_from_pte(pte);
+
+			struct folio *folio = softleaf_to_folio(entry);
 			pte_t newpte = pte;
 
 			if (is_writable_migration_entry(entry)) {
@@ -7222,14 +7223,14 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 				newpte = pte_swp_clear_uffd_wp(newpte);
 			if (!pte_same(pte, newpte))
 				set_huge_pte_at(mm, address, ptep, newpte, psize);
-		} else if (unlikely(is_pte_marker(pte))) {
+		} else if (unlikely(pte_is_marker(pte))) {
 			/*
 			 * Do nothing on a poison marker; page is
 			 * corrupted, permissions do not apply. Here
 			 * pte_marker_uffd_wp()==true implies !poison
 			 * because they're mutual exclusive.
 			 */
-			if (pte_marker_uffd_wp(pte) && uffd_wp_resolve)
+			if (pte_is_uffd_wp_marker(pte) && uffd_wp_resolve)
 				/* Safe to modify directly (non-present->none). */
 				huge_pte_clear(mm, address, ptep, psize);
 		} else if (!huge_pte_none(pte)) {
diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..2d5ad3cb37bb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -29,7 +29,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagewalk.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
 
@@ -690,17 +690,16 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		 * (page allocation + zeroing).
 		 */
 		if (!pte_present(ptent)) {
-			swp_entry_t entry;
+			softleaf_t entry = softleaf_from_pte(ptent);
 
-			entry = pte_to_swp_entry(ptent);
-			if (!non_swap_entry(entry)) {
+			if (softleaf_is_swap(entry)) {
 				max_nr = (end - addr) / PAGE_SIZE;
 				nr = swap_pte_batch(pte, max_nr, ptent);
 				nr_swap -= nr;
 				free_swap_and_cache_nr(entry, nr);
 				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
-			} else if (is_hwpoison_entry(entry) ||
-				   is_poisoned_swp_entry(entry)) {
+			} else if (softleaf_is_hwpoison(entry) ||
+				   softleaf_is_poison_marker(entry)) {
 				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			}
 			continue;
@@ -1071,8 +1070,9 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
 
 static bool is_guard_pte_marker(pte_t ptent)
 {
-	return is_swap_pte(ptent) &&
-	       is_guard_swp_entry(pte_to_swp_entry(ptent));
+	const softleaf_t entry = softleaf_from_pte(ptent);
+
+	return softleaf_is_guard_marker(entry);
 }
 
 static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 4c3a7e09a159..7493ed084b99 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -60,7 +60,7 @@
 #include <linux/writeback.h>
 #include <linux/memcontrol.h>
 #include <linux/mmu_notifier.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/elf.h>
 #include <linux/gfp.h>
 #include <linux/migrate.h>
@@ -109,7 +109,7 @@ static __always_inline bool vmf_orig_pte_uffd_wp(struct vm_fault *vmf)
 	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
 		return false;
 
-	return pte_marker_uffd_wp(vmf->orig_pte);
+	return pte_is_uffd_wp_marker(vmf->orig_pte);
 }
 
 /*
@@ -927,10 +927,10 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 {
 	vm_flags_t vm_flags = dst_vma->vm_flags;
 	pte_t orig_pte = ptep_get(src_pte);
+	softleaf_t entry = softleaf_from_pte(orig_pte);
 	pte_t pte = orig_pte;
 	struct folio *folio;
 	struct page *page;
-	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
@@ -1016,7 +1016,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		if (try_restore_exclusive_pte(src_vma, addr, src_pte, orig_pte))
 			return -EBUSY;
 		return -ENOENT;
-	} else if (is_pte_marker_entry(entry)) {
+	} else if (softleaf_is_marker(entry)) {
 		pte_marker marker = copy_pte_marker(entry, dst_vma);
 
 		if (marker)
@@ -1717,14 +1717,14 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		unsigned int max_nr, unsigned long addr,
 		struct zap_details *details, int *rss, bool *any_skipped)
 {
-	swp_entry_t entry;
+	softleaf_t entry;
 	int nr = 1;
 
 	*any_skipped = true;
-	entry = pte_to_swp_entry(ptent);
-	if (is_device_private_entry(entry) ||
-		is_device_exclusive_entry(entry)) {
-		struct page *page = pfn_swap_entry_to_page(entry);
+	entry = softleaf_from_pte(ptent);
+	if (softleaf_is_device_private(entry) ||
+	    softleaf_is_device_exclusive(entry)) {
+		struct page *page = softleaf_to_page(entry);
 		struct folio *folio = page_folio(page);
 
 		if (unlikely(!should_zap_folio(details, folio)))
@@ -1739,7 +1739,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		rss[mm_counter(folio)]--;
 		folio_remove_rmap_pte(folio, page, vma);
 		folio_put(folio);
-	} else if (!non_swap_entry(entry)) {
+	} else if (softleaf_is_swap(entry)) {
 		/* Genuine swap entries, hence a private anon pages */
 		if (!should_zap_cows(details))
 			return 1;
@@ -1747,20 +1747,20 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		nr = swap_pte_batch(pte, max_nr, ptent);
 		rss[MM_SWAPENTS] -= nr;
 		free_swap_and_cache_nr(entry, nr);
-	} else if (is_migration_entry(entry)) {
-		struct folio *folio = pfn_swap_entry_folio(entry);
+	} else if (softleaf_is_migration(entry)) {
+		struct folio *folio = softleaf_to_folio(entry);
 
 		if (!should_zap_folio(details, folio))
 			return 1;
 		rss[mm_counter(folio)]--;
-	} else if (pte_marker_entry_uffd_wp(entry)) {
+	} else if (softleaf_is_uffd_wp_marker(entry)) {
 		/*
 		 * For anon: always drop the marker; for file: only
 		 * drop the marker if explicitly requested.
 		 */
 		if (!vma_is_anonymous(vma) && !zap_drop_markers(details))
 			return 1;
-	} else if (is_guard_swp_entry(entry)) {
+	} else if (softleaf_is_guard_marker(entry)) {
 		/*
 		 * Ordinary zapping should not remove guard PTE
 		 * markers. Only do so if we should remove PTE markers
@@ -1768,7 +1768,8 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		 */
 		if (!zap_drop_markers(details))
 			return 1;
-	} else if (is_hwpoison_entry(entry) || is_poisoned_swp_entry(entry)) {
+	} else if (softleaf_is_hwpoison(entry) ||
+		   softleaf_is_poison_marker(entry)) {
 		if (!should_zap_cows(details))
 			return 1;
 	} else {
@@ -4390,7 +4391,7 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	 *
 	 * This should also cover the case where e.g. the pte changed
 	 * quickly from a PTE_MARKER_UFFD_WP into PTE_MARKER_POISONED.
-	 * So is_pte_marker() check is not enough to safely drop the pte.
+	 * So pte_is_marker() check is not enough to safely drop the pte.
 	 */
 	if (pte_same(vmf->orig_pte, ptep_get(vmf->pte)))
 		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
@@ -4424,8 +4425,8 @@ static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
 
 static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 {
-	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
-	unsigned long marker = pte_marker_get(entry);
+	const softleaf_t entry = softleaf_from_pte(vmf->orig_pte);
+	const pte_marker marker = softleaf_to_marker(entry);
 
 	/*
 	 * PTE markers should never be empty.  If anything weird happened,
@@ -4442,7 +4443,7 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (marker & PTE_MARKER_GUARD)
 		return VM_FAULT_SIGSEGV;
 
-	if (pte_marker_entry_uffd_wp(entry))
+	if (softleaf_is_uffd_wp_marker(entry))
 		return pte_marker_handle_uffd_wp(vmf);
 
 	/* This is an unknown pte marker */
@@ -4690,7 +4691,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			}
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
-		} else if (is_pte_marker_entry(entry)) {
+		} else if (softleaf_is_marker(entry)) {
 			ret = handle_pte_marker(vmf);
 		} else {
 			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
diff --git a/mm/mincore.c b/mm/mincore.c
index 151b2dbb783b..e77c5bc88fc7 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -14,7 +14,7 @@
 #include <linux/mman.h>
 #include <linux/syscalls.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
@@ -42,7 +42,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	} else {
 		const pte_t ptep = huge_ptep_get(walk->mm, addr, pte);
 
-		if (huge_pte_none(ptep) || is_pte_marker(ptep))
+		if (huge_pte_none(ptep) || pte_is_marker(ptep))
 			present = 0;
 		else
 			present = 1;
@@ -187,7 +187,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 
 		step = 1;
 		/* We need to do cache lookup too for UFFD pte markers */
-		if (pte_none(pte) || is_uffd_pte_marker(pte))
+		if (pte_none(pte) || pte_is_uffd_marker(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte)) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab4e06cd9a69..0bae241eb7aa 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -326,14 +326,14 @@ static long change_pte_range(struct mmu_gather *tlb,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
-			} else if (is_pte_marker_entry(entry)) {
+			} else if (softleaf_is_marker(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
 				 * because any access should sigbus/sigsegv
 				 * anyway.
 				 */
-				if (is_poisoned_swp_entry(entry) ||
-				    is_guard_swp_entry(entry))
+				if (softleaf_is_poison_marker(entry) ||
+				    softleaf_is_guard_marker(entry))
 					continue;
 				/*
 				 * If this is uffd-wp pte marker and we'd like
diff --git a/mm/mremap.c b/mm/mremap.c
index 8ad06cf50783..7c21b2ad13f6 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -17,7 +17,7 @@
 #include <linux/swap.h>
 #include <linux/capability.h>
 #include <linux/fs.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
@@ -288,7 +288,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
 		pte = move_pte(pte, old_addr, new_addr);
 		pte = move_soft_dirty_pte(pte);
 
-		if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
+		if (need_clear_uffd_wp && pte_is_uffd_wp_marker(pte))
 			pte_clear(mm, new_addr, new_ptep);
 		else {
 			if (need_clear_uffd_wp) {
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 137ce27ff68c..be20468fb5a9 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -3,7 +3,7 @@
 #include <linux/rmap.h>
 #include <linux/hugetlb.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 
 #include "internal.h"
 
@@ -107,15 +107,12 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 	pte_t ptent = ptep_get(pvmw->pte);
 
 	if (pvmw->flags & PVMW_MIGRATION) {
-		swp_entry_t entry;
-		if (!is_swap_pte(ptent))
-			return false;
-		entry = pte_to_swp_entry(ptent);
+		const softleaf_t entry = softleaf_from_pte(ptent);
 
-		if (!is_migration_entry(entry))
+		if (!softleaf_is_migration(entry))
 			return false;
 
-		pfn = swp_offset_pfn(entry);
+		pfn = softleaf_to_pfn(entry);
 	} else if (is_swap_pte(ptent)) {
 		swp_entry_t entry;
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 6580f3cd24bb..395ca58ac4a5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -66,7 +66,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
 #include <linux/falloc.h>
 #include <linux/splice.h>
 #include <linux/security.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/mempolicy.h>
 #include <linux/namei.h>
 #include <linux/ctype.h>
@@ -2286,7 +2286,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	swp_entry_t swap, index_entry;
+	swp_entry_t swap;
+	softleaf_t index_entry;
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	bool skip_swapcache = false;
@@ -2298,7 +2299,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	swap = index_entry;
 	*foliop = NULL;
 
-	if (is_poisoned_swp_entry(index_entry))
+	if (softleaf_is_poison_marker(index_entry))
 		return -EIO;
 
 	si = get_swap_device(index_entry);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cc4ce205bbec..055ec1050776 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -10,7 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/mmu_notifier.h>
 #include <linux/hugetlb.h>
@@ -208,7 +208,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	 * MISSING|WP registered, we firstly wr-protect a none pte which has no
 	 * page cache page backing it, then access the page.
 	 */
-	if (!pte_none(dst_ptep) && !is_uffd_pte_marker(dst_ptep))
+	if (!pte_none(dst_ptep) && !pte_is_uffd_marker(dst_ptep))
 		goto out_unlock;
 
 	if (page_in_cache) {
@@ -590,7 +590,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		if (!uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
 			const pte_t ptep = huge_ptep_get(dst_mm, dst_addr, dst_pte);
 
-			if (!huge_pte_none(ptep) && !is_uffd_pte_marker(ptep)) {
+			if (!huge_pte_none(ptep) && !pte_is_uffd_marker(ptep)) {
 				err = -EEXIST;
 				hugetlb_vma_unlock_read(dst_vma);
 				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-- 
2.51.0


