Return-Path: <linux-fsdevel+bounces-43268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8334A502F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 15:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395D53AF633
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443724EF90;
	Wed,  5 Mar 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9uj0y3/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fg8fsUxe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0685424C068;
	Wed,  5 Mar 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186563; cv=fail; b=KtPGZi35JpXzux9Op3xktxVUs8yBThqGUlzGlB//9cbw3crzuhq412khobC67yFeiNhbLT+n6Xj8aU2oQvF3O3NXhXI7Q/N9ytRJqjGnTxUxkzw/1dFo9uPAWVqiMsyFC8Cr7JgEdftVZxRxa2q53tzjoz1X+oRww0AKE48K8D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186563; c=relaxed/simple;
	bh=Vqz0Le8MxurfImVmmdYYb6QUMyi1KQ8fyzsZn7Tm0OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ntxfP4UJqTRP7a+uuzJu3/B3/UDsQ97IlPUMU/B8H2FL9wX02x20mtO9BSrfzAhpw9wr+1OTzgzt5h58h28NmsGHS9eoJ6BYa8f7SmgDadh72KqGeaVcaMM6ayopG9Ny04uc2obHZdo/+dAp8R1+VwfHABKEz/ifaP9dWZdK9p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i9uj0y3/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fg8fsUxe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525C3r1U030568;
	Wed, 5 Mar 2025 14:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vSczvhB3DtU+OeTR7KM+VtMrcSqDDLR9E5GUWOlysJU=; b=
	i9uj0y3/z7H3+uPNiLhCqEmmk7BuVQveU2Zy3/1oG638WeOmY7jefq/mgCenRCQZ
	R3Q3BHg5WPiVLHWMU1xodwVIXJGZtqlXhpEC5MrrfXkRRn1N0Z/WwTH6z+ft06i7
	eiJDbXcGbrI/mFbinbtiHrRnLbsdlDhVDOZ71SrXABY4wjQQ0Ib5aNIhi2LIfbPt
	1eI/fgxzHL6KYeZ7ve0ik0uc1rFdFr9PPVgl8uO92wiTYS2ZYo8wN4dwutFY8OG+
	LvOjy2pkrDnnUGvsuT11kEAKJ+2tp061ZoBwc4kVvg9cS5gPRM2LKoYMJCqnbZeM
	caC6W+y+HwSczVTpOyu1AQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r47nkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:55:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525EOmWo003302;
	Wed, 5 Mar 2025 14:55:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpah3vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 14:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI5QATN/R4JMMTHjxrDPxfOqOUSMCT6W1v+/9/LDrqiMpXVUsq7oTHsWhXLBRW+LNy9yqlmLJeT2d14CszW8sBQihwHDU/HuXqP1ha2X0ERu6Y8Yf+5c2JCxehmzMwPc9dHSZKu92Goy8NXPfjOZXotZ6Z0oTzKlApyfTWnCEyU6FKjH+oC4knmiHww6hc10ylYCIlD9XAe5x7l8ufrft9sIehZNeVE5tMb9kmTPBfasiuNqEBX5JEZgszksMMb6WVWBVWpMcCMQrdF3st9Ozmrb9tURjy8feMHseRdWnCUngL6xwlM9DMO7tSGX4yVO+xIGiCNpPUNU9Bp9ntLssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSczvhB3DtU+OeTR7KM+VtMrcSqDDLR9E5GUWOlysJU=;
 b=Pb2TC4UeZCGxIwpZtiCI/c8GE3grYIIto35d81JDxqoVZirs0bncmPPyQoEQHmpusDlRTFkKDzN+GnwHHpuw2abfahNZ2zrU06hwQT1dAI5Lk1CJaopBJUVopu3XMGIS39X3szPEcvQKqkgHHk5wq4c1T9B21OeNBoWf4CgnlCo+wRRHkyKb59ikcJj6USbfYHR3/BBydEfM4clREXQ4nyP1s7zwCoyXOe/I4KuLckp6osfDhEN9AyJxB7Uyq8w+ZPw96mN8GCRz35G1BxORddKKdm3CgmoKWvj/pDg1qb/XrwzfePBjeUwiMxQTPhikqpVyzku65Ow4laCT5c2TsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSczvhB3DtU+OeTR7KM+VtMrcSqDDLR9E5GUWOlysJU=;
 b=Fg8fsUxedN7nKuIVaeHUHXtu2PG+ReazfWuoHMz243ajruztL1gkD1rF92VCBRJcKg85sOveIyGUUDu+TWICkasOwTTVnkQ/WBpB0OjZ4HL0DHOZzv8kO/wQyvZdlNv6NXvA6pupIZRs2DM07a74g64Jw6CybVAOnLsSpPATvZ8=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 14:55:26 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 14:55:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [RFC PATCH 1/2] mm: introduce anon_vma flags and use wrapper functions
Date: Wed,  5 Mar 2025 14:55:07 +0000
Message-ID: <028aa823d2db02dc20f65b2bc9b527877f33d735.1741185865.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741185865.git.lorenzo.stoakes@oracle.com>
References: <cover.1741185865.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::14) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c877be-7532-49ec-d591-08dd5bf5c333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAGL9EIWmYM96xgPRzt8Ahfx7F/8TdwLs63HtlVpTHYVB/eX2DGBZq/+EZeH?=
 =?us-ascii?Q?bIuJG9fJEr1zZHB0037jmTQRHlZBArdQlDTJZNjlzHY2EhidGYoxUCgeu84Q?=
 =?us-ascii?Q?fNNCWyv13+HM8uIjXCrcOw18YD4Z1GQfeiIcChf4JApcjzYeSjMix3uwb0te?=
 =?us-ascii?Q?+O+1LOYJn/htLtQ/h7CsGHtpiM6A+g6wgUW5/hHlAYS2/qNAqhbf1WNUb6z4?=
 =?us-ascii?Q?g9acpVX+qIkrTGnmBSpFBaJZBUmtN7LK38npnoKM7pjWzuJoR31HrHxVxEMa?=
 =?us-ascii?Q?sD9IwheFlZMMZxhJAvUGX+Vfll0to89ZTyncMgPhf5jN+a0/mJ5FjynyqNWE?=
 =?us-ascii?Q?KtHdY4lza5p5fLq+ZUWDZgkF4p/3PxO6+ln+7l3yywEcS0g4NgigZqhfX1pO?=
 =?us-ascii?Q?zsNR7BmU3PL8bfm5MD/8b+RDsw6sMRvNhY0IJUgKvu7IR5EloZBMb7RXkGKK?=
 =?us-ascii?Q?TCov96cb5cBKL25C5DBWAbGK8C3wf8N/ZvcMjgr7/4/bm+QcyfXF4Dleatzk?=
 =?us-ascii?Q?XTqt51qLNGGr4R9XCdhEa3pmqOsZQfitlfAL9brLwFpTLxeLf5uxPDx83syY?=
 =?us-ascii?Q?3IPRaUYCW/d4dxRkSgj9XX5H0AEqTAOTImt7Q7y8V1I9BPkkpfL0752Mts0l?=
 =?us-ascii?Q?GHyqefEUPMBN9+BG20mbXL89A8E/7AmBcrOcouEeMS6zHBpDtxj924CM7mXo?=
 =?us-ascii?Q?6dq6fVeSWzu5cDkwcElZxlqgXlWk0E8ED09H2gHN1ae2Kww1KrXpMljTwndy?=
 =?us-ascii?Q?yOosOCbw/duopiq50MXUysJ4iC3D4+5FsOuUoAQ21GTFSFLz/p9C2oKPCzmg?=
 =?us-ascii?Q?pgjuSvOc93ogyeIrQ7xrrLco9mVCSARmCZgHg7xGvzyLqFFRGoQOPtYv5Z6w?=
 =?us-ascii?Q?C2/trxbFpkFJKlvbGu8P/+EqsDjugJRJAEaw89JMbB0WwFCI85GVqeFwiJ4Y?=
 =?us-ascii?Q?nQ8E8IhpvIZPd200huSBlIce3KXL6ZqPLO35p4OXgrPEGNmpL+KA/eQWVq0O?=
 =?us-ascii?Q?6EEjSsYZO99uAtVIKJOyX4vg6t/m64356l/RGa8NNFfmES/Cg/YSavpt4SbB?=
 =?us-ascii?Q?XWLNWP0jUMF4j5/zWhjr+L5duO0b5lVWC8PVZnaHjuOMyeVE2JEp5FE9usu1?=
 =?us-ascii?Q?iSgYZ+DKSwalH/Lqm+smFdSXimo6LeyoMfERFNY0wskGExV8OQrx6jUA8EXo?=
 =?us-ascii?Q?/Kjy+qa918AVeIWsxUqhB/MyjU9gmp+WKX08a2MIvdpLSxP8cyBPcBav9fdI?=
 =?us-ascii?Q?ob8VRKFg5cGEQ0Kw/89a0tDSWtPPgGmUr8fcTU5gG1m9DIjVXCK00BHrp4DZ?=
 =?us-ascii?Q?1GBADaxhqFB7c0HwL7jQ811zlbz2uiVVtLPesolCwBjM3LyfRKB+MS5CpFyg?=
 =?us-ascii?Q?bOQpqvJi2G4eleO0biAPO98ncdNT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dmFnbakTfCNjv2dzZk3NYUZF9dRMq1PRE14XaWrP+R5AwJcN1fplXDTvG2av?=
 =?us-ascii?Q?4eZ2NWHDNcV9+H2g+fRGbhkvB/9cZ+pTLhHLFjPZIC+iGBYF+FYPUGOmIT8R?=
 =?us-ascii?Q?Hk84X6w80IZByvcn5C7Wce+Xbo3rDr1RAaATg6V4G9ZJctoCUAmejNqEbVpJ?=
 =?us-ascii?Q?+jJs5hDzwXrdM+IeH6L+aeqMnc0Ywmw/dh5pEhJ1z1sX7H9SR42OIY0HC2+O?=
 =?us-ascii?Q?WmEBNQbmsGLZ1xjI52ZZoSoZ5prPQeFdeaw4jnwt8BaJGHgsSILq84cPguh3?=
 =?us-ascii?Q?YFUn1ZEa2hiSA8eTgr0TYEnNeM5SO+WAAR1s6fgglcuhVZZCFeQ1NKlXifFW?=
 =?us-ascii?Q?f96bNAlH0Ai58ea7PefPRVVN1QIwIcj/kwsiTOA0+p9YlSEE7ToDCzSwKPEE?=
 =?us-ascii?Q?Ab/2qBEfXtH80xxrtY/4pzoOG2en6dMuAtECIsycy6CY8hgvRbdt8q0QPcCx?=
 =?us-ascii?Q?ujhOMbPDxQ4LDvnOLpGciVpArzRik/mFL010WHrTLYZ1mBmzBNKvfe7gpa6/?=
 =?us-ascii?Q?PmOfGcTKAjuPUYpcHhrbjWAJW57JgEQkRgGxuEyzw67KJJEqRrf7yUGkDeqF?=
 =?us-ascii?Q?FS8nFwD5krD58po6mjfQR6voiW4vR9PlAUGjaBn0NgByi5H20oun9rKIWD1G?=
 =?us-ascii?Q?CysZ+mHJKISCTAPzZWPBhBxUTtxIeQLFps3XusLhJ88DX3ibB8E3OHqMa7cv?=
 =?us-ascii?Q?lYuuYuXs26gy16z+uSYqeZ+rNfoz8hwSHSNLFh2zSYSRT5XoNZqi7L/uz0nT?=
 =?us-ascii?Q?jPmORNAmefOkYX5fEUeSKm9h+9rLynMjn7BCsug6S1gkbLKsbN+GnWTuXoQ5?=
 =?us-ascii?Q?rOxaWPYXpjk92A65c51ObfiIv4gOyPjfmHKx/GEfarjEiSf9UNcVJCata/JE?=
 =?us-ascii?Q?4Emm5BkBR2l45lehcjue4nxhJD4oqZJ3IVxCXlbeOPv26TtKG3KRCp7dIReC?=
 =?us-ascii?Q?5oUKiiu5ZkEr/tvRtjCzzZ5vBSdXSxlshkNBrOHYAwUxWI0Qg1aksIDcZlub?=
 =?us-ascii?Q?a7bABcZ6sK4I9rkHSxk4DkkKtUUCowXLH0K6Pb84OSLag09zNRy1dc2kLaXl?=
 =?us-ascii?Q?VawJGxSB2rxwVRhXkxYBGFE31sH02LZu/Rpk47eo69lLaAN6gauf++14HGdU?=
 =?us-ascii?Q?q3nW1KCkn4QrvSCjCniKd/Bh6nazPLvfd/CSxAgockysDg//zSMWve0n3znH?=
 =?us-ascii?Q?n+623m5nwqZtoqIva3LANl7Uz839yB24/3kJ6grPbMtrRn2GhCDNmyxPE4mk?=
 =?us-ascii?Q?uiUMdnw9ZMIm27WkQjpF6xN17bF1J7FFS1et2mnrhc3ATdNAKj1QWx0Mp0QH?=
 =?us-ascii?Q?U2f3IBhzS8eOQ7YWHl1w9Z8NL0FvkrniN9NXRss2xXyuJojgZx7yRI3zymIJ?=
 =?us-ascii?Q?mFphLTjvvuym9S9VaAXpem5fD2hY8c9ZkGPvRHyzsbclc0P7JFRv8nXqKmpz?=
 =?us-ascii?Q?3jnuYPFU6RNqeiPRsjCJxdUykpIGQhau0NQcWXKa+68kef1tGjmNxcpIC4Ox?=
 =?us-ascii?Q?LaNahIE5Td8tjdjHkKMRtT/cpBoh9Hbv+JTsY4hSSqNs1gQZAv6G4/LW4YSj?=
 =?us-ascii?Q?QHBXxnW7rJqdVPxuo0pt61KCZEU93coeqkg0/3E+uO/4EBnKBuU2Kg4yWoLS?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AzQiduE5h77RLL9ybS5Wxi5yxfMvtG5gcWB2rMJj8HptNBh+25Yu+8rWsrzbrawizhnpMJiPgaPgDjVbYyEA4hTGuTm79dYVMGpqz04NWjKd1NwniyYFCy6FJbfUucJFRYeQc4rSbdOAN+vIrHQKBxXYoO0o6lhdXV9KKIKMU7KelOTAOzqzVIWUtqp1X2Nzy9pogj8mDK1RLsKI3E/gXvoJ9DD6Z8Q/akpYCeCdVKRn/XnRk/wtrSX2gKcci4qeBUQ8wGP0yWo8HJDQ9810lArkyA7YX4hJt1FE2doa9h0/7FrhfFmOLs60j2nfUP1b/fxszOYfuV0wmjW7yZ+T+d8gBZtooJ2ShU8P7N1yi7jjZ9q2I4fxr9K42seoSWrGSXKUe1/Z9Hle80cU420hOon9MK25ye/2QFM50IWCHT6nnA1lm/q0BbCqVAsFT3qwAJRgW1z5imGzLlm1W42cH0lWjujghJFR4b8IgjIuz/ohtJ79UTLqu3wy9iLjGZll6IwmZYHzZb0FYJaghTP5cn9RwI0abFkhKpD1dv44X/SAlbE/kVYG94L6+ld7KIT4CgFdQxyFKWILZA2C08wAa8x+RLRb0v3Vs+pBHdaRu3E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c877be-7532-49ec-d591-08dd5bf5c333
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:55:25.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3/uFWIikfZ/g9smMbyjLYrjbdK+pm1ofUM/d+lwm/gY7vFa1CBe+wj75cVkZaDCTDZSAVtpGtKk/uNY+yLExfAetG/0VmaOSPbkKGx4zE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050116
X-Proofpoint-ORIG-GUID: w9nvLdnnxEym9xQtZsXoYi2S8e1ZLinT
X-Proofpoint-GUID: w9nvLdnnxEym9xQtZsXoYi2S8e1ZLinT

VMAs are a highly contested resource, one which we are proactively trying
to reduce in size as much as possible. This leaves us with very little
means of encoding additional state.

However, we can reclaim lower bits of aligned pointers for our purposes, an
established pattern in the kernel.

The vma->anon_vma filed will always be populated with an at least system
word-aligned pointer which grants us a handful of bits.

We can then utilise these bits for a very useful purpose - being able to
indicate that an 'unfaulted' anon_vma state exists.

This is useful specifically for the purpose of being able to indicate that,
on fork, page tables ought to be copied, which currently otherwise requires
that a full anon_vma and all associated state need be initialised to be
able to do so.

VMA flags are hugely contended (and we have run out of space for them for
32-bit systems), so this seems a sensible means of locating this
information.

We do so via the ANON_VMA_UNFAULTED flag. This flag is cleared on fault or
any operation that would otherwise assign or unconditionally clear
vma->anon_vma.

There is no impact on any kernel behaviour other than forking.

We only read/write these values at a time and under locking conditions
where previously we would have done so.

We convert the vma->anon_vma field to an unsigned long to reduce the
instances in which inappropriate use of this field might go unnoticed and
to encourage correct wrapper function utilisation.

The wrappers are succinct and the meaning of them is clear. We also take
the opportunity to use READ_ONCE() / WRITE_ONCE() to prevent any
unanticipated tearing.

With this in place, we can subsequently update the guard region
implementation to utilise this new functionality, therefore proactively
avoiding unnecessary memory usage upon installation of guard regions.

This also opens the door to future changes to anon_vma usage as we are now
able to encode additional state here.

We also introduce the vma_maybe_has_pagetables() function to make it
abundantly and explicitly clear what this checks, differentiating existing
vma->anon_vma checks between the two meaningful cases - checking whether
there is an anon_vma and checking if page tables might exist.

We update the two cases which do the latter - the fork test, and
khugepaged. In both cases the same kernel behaviour will manifest, only now
spelled out clearly.

Additionally, update the VMA unit tests to reflect these changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/coredump.c                    |  2 +-
 include/linux/mm_types.h         | 67 ++++++++++++++++++++-
 include/linux/rmap.h             |  4 +-
 kernel/fork.c                    |  4 +-
 mm/debug.c                       |  6 +-
 mm/huge_memory.c                 |  4 +-
 mm/khugepaged.c                  | 12 ++--
 mm/ksm.c                         | 16 +++---
 mm/memory.c                      |  6 +-
 mm/mmap.c                        |  2 +-
 mm/mprotect.c                    |  2 +-
 mm/mremap.c                      |  8 +--
 mm/rmap.c                        | 42 +++++++-------
 mm/swapfile.c                    |  2 +-
 mm/userfaultfd.c                 |  2 +-
 mm/vma.c                         | 99 +++++++++++++++++++++++++-------
 mm/vma.h                         |  6 +-
 security/selinux/hooks.c         |  2 +-
 tools/testing/vma/vma.c          | 95 +++++++++++++++---------------
 tools/testing/vma/vma_internal.h | 78 ++++++++++++++++++++++---
 20 files changed, 327 insertions(+), 132 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 591700e1b2ce..13423d08cedb 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1115,7 +1115,7 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	}
 
 	/* Dump segments that have been written to.  */
-	if ((!IS_ENABLED(CONFIG_MMU) || vma->anon_vma) && FILTER(ANON_PRIVATE))
+	if ((!IS_ENABLED(CONFIG_MMU) || vma_anon_vma(vma)) && FILTER(ANON_PRIVATE))
 		goto whole;
 	if (vma->vm_file == NULL)
 		return 0;
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2d657ac8e9b0..c250fceb4b83 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -823,7 +823,8 @@ struct vm_area_struct {
 	 */
 	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
 					  * page_table_lock */
-	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+	/* Contains flags combined with pointer to anon_vma. Use accessor. */
+	unsigned long anon_vma;	/* Serialized by page_table_lock */
 
 	/* Function pointers to deal with this struct. */
 	const struct vm_operations_struct *vm_ops;
@@ -873,6 +874,70 @@ struct vm_area_struct {
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
 
+/*
+ * We utilise the fact that the anon_vma will be at least system word aligned
+ * to reclaim bits for flags.
+ */
+#define ANON_VMA_UNFAULTED	1 /* anon_vma set, but not faulted in yet. */
+#define NUM_ANON_VMA_FLAGS	1
+#define ANON_VMA_FLAG_MASK	((1UL << NUM_ANON_VMA_FLAGS) - 1)
+
+/*
+ * The below functions assume the caller has obtained the appropriate locks
+ * before calling, See process address documentation for details.
+ */
+
+/* Extract anon_vma from vma if it has been set. */
+static inline struct anon_vma *vma_anon_vma(const struct vm_area_struct *vma)
+{
+	unsigned long val = READ_ONCE(vma->anon_vma);
+
+	return (struct anon_vma *)(val & ~ANON_VMA_FLAG_MASK);
+}
+
+/* Retrieve any flags encoded in the vma->anon_vma field. */
+static inline unsigned int vma_anon_vma_flags(const struct vm_area_struct *vma)
+{
+	unsigned long val = READ_ONCE(vma->anon_vma);
+
+	return (unsigned int)(val & ANON_VMA_FLAG_MASK);
+}
+
+/* Set the anon_vma field, clearing any anon_vma flags. */
+static inline void vma_set_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma *anon_vma)
+{
+	WRITE_ONCE(vma->anon_vma, (unsigned long)anon_vma);
+}
+
+/* Clear the existing anon_vma and any anon_vma flags. */
+static inline void vma_clear_anon_vma(struct vm_area_struct *vma)
+{
+	WRITE_ONCE(vma->anon_vma, 0);
+}
+
+/* Duplicate anon_vma from src to dst, retaining flags. */
+static inline void vma_dup_anon_vma(struct vm_area_struct *dst,
+		const struct vm_area_struct *src)
+{
+	WRITE_ONCE(dst->anon_vma, READ_ONCE(src->anon_vma));
+}
+
+/*
+ * Does the VMA have an anon_vma or any anon_vma flags set, implying it perhaps
+ * has pagetables to propagate?
+ */
+static inline bool vma_maybe_has_pagetables(struct vm_area_struct *vma)
+{
+	return READ_ONCE(vma->anon_vma);
+}
+
+/*
+ * Assign the VMA's anon_vma but do not set up the anon_vma itself. This is
+ * useful for cases where we want to ensure behaviour that would otherwise
+ */
+void vma_set_anon_vma_unfaulted(struct vm_area_struct *vma);
+
 #ifdef CONFIG_NUMA
 #define vma_policy(vma) ((vma)->vm_policy)
 #else
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6b82b618846e..5983654df10a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -159,7 +159,7 @@ int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
 
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
 {
-	if (likely(vma->anon_vma))
+	if (likely(vma_anon_vma(vma)))
 		return 0;
 
 	return __anon_vma_prepare(vma);
@@ -168,7 +168,7 @@ static inline int anon_vma_prepare(struct vm_area_struct *vma)
 static inline void anon_vma_merge(struct vm_area_struct *vma,
 				  struct vm_area_struct *next)
 {
-	VM_BUG_ON_VMA(vma->anon_vma != next->anon_vma, vma);
+	VM_BUG_ON_VMA(vma_anon_vma(vma) != vma_anon_vma(next), vma);
 	unlink_anon_vmas(next);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index f9cf0f056eb6..c5e67e68aa80 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -456,7 +456,7 @@ static void vm_area_init_from(const struct vm_area_struct *src,
 	dest->vm_ops = src->vm_ops;
 	dest->vm_start = src->vm_start;
 	dest->vm_end = src->vm_end;
-	dest->anon_vma = src->anon_vma;
+	vma_dup_anon_vma(dest, src);
 	dest->vm_pgoff = src->vm_pgoff;
 	dest->vm_file = src->vm_file;
 	dest->vm_private_data = src->vm_private_data;
@@ -683,7 +683,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			 * Don't prepare anon_vma until fault since we don't
 			 * copy page for current vma.
 			 */
-			tmp->anon_vma = NULL;
+			vma_clear_anon_vma(tmp);
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		vm_flags_clear(tmp, VM_LOCKED_MASK);
diff --git a/mm/debug.c b/mm/debug.c
index 83ef3bd0ccd3..ec4326cfc4f0 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -187,7 +187,7 @@ EXPORT_SYMBOL(dump_page);
 void dump_vma(const struct vm_area_struct *vma)
 {
 	pr_emerg("vma %px start %px end %px mm %px\n"
-		"prot %lx anon_vma %px vm_ops %px\n"
+		"prot %lx anon_vma %px (flags %u) vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
 #ifdef CONFIG_PER_VMA_LOCK
 		"refcnt %x\n"
@@ -195,8 +195,8 @@ void dump_vma(const struct vm_area_struct *vma)
 		"flags: %#lx(%pGv)\n",
 		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
-		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
-		vma->vm_file, vma->vm_private_data,
+		vma_anon_vma(vma), vma_anon_vma_flags(vma), vma->vm_ops,
+		vma->vm_pgoff, vma->vm_file, vma->vm_private_data,
 #ifdef CONFIG_PER_VMA_LOCK
 		refcount_read(&vma->vm_refcnt),
 #endif
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 826bfe907017..71232e4ec89a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -202,7 +202,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	 * Allow page fault since anon_vma may be not initialized until
 	 * the first page fault.
 	 */
-	if (!vma->anon_vma)
+	if (!vma_anon_vma(vma))
 		return (smaps || in_pf) ? orders : 0;
 
 	return orders;
@@ -1930,7 +1930,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	pmd_t orig_pmd = vmf->orig_pmd;
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
-	VM_BUG_ON_VMA(!vma->anon_vma, vma);
+	VM_BUG_ON_VMA(!vma_anon_vma(vma), vma);
 
 	if (is_huge_zero_pmd(orig_pmd)) {
 		vm_fault_t ret = do_huge_zero_wp_pmd(vmf);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cc945c6ab3bd..c3b974c6aa77 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -943,7 +943,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	 * thp_vma_allowable_order may return true for qualified file
 	 * vmas.
 	 */
-	if (expect_anon && (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap)))
+	if (expect_anon && (!vma_anon_vma(*vmap) || !vma_is_anonymous(*vmap)))
 		return SCAN_PAGE_ANON;
 	return SCAN_SUCCEED;
 }
@@ -1173,7 +1173,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		goto out_up_write;
 
 	vma_start_write(vma);
-	anon_vma_lock_write(vma->anon_vma);
+	anon_vma_lock_write(vma_anon_vma(vma));
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
 				address + HPAGE_PMD_SIZE);
@@ -1214,7 +1214,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		 */
 		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
 		spin_unlock(pmd_ptl);
-		anon_vma_unlock_write(vma->anon_vma);
+		anon_vma_unlock_write(vma_anon_vma(vma));
 		goto out_up_write;
 	}
 
@@ -1222,7 +1222,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * All pages are isolated and locked so anon_vma rmap
 	 * can't run anymore.
 	 */
-	anon_vma_unlock_write(vma->anon_vma);
+	anon_vma_unlock_write(vma_anon_vma(vma));
 
 	result = __collapse_huge_page_copy(pte, folio, pmd, _pmd,
 					   vma, address, pte_ptl,
@@ -1730,7 +1730,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * got written to. These VMAs are likely not worth removing
 		 * page tables from, as PMD-mapping is likely to be split later.
 		 */
-		if (READ_ONCE(vma->anon_vma))
+		if (vma_maybe_has_pagetables(vma))
 			continue;
 
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
@@ -1786,7 +1786,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		 * repeating the anon_vma check protects from one category,
 		 * and repeating the userfaultfd_wp() check from another.
 		 */
-		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
+		if (likely(!vma_maybe_has_pagetables(vma) && !userfaultfd_wp(vma))) {
 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
 			pmdp_get_lockless_sync();
 			success = true;
diff --git a/mm/ksm.c b/mm/ksm.c
index 8583fb91ef13..d66d0b4762ee 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -706,7 +706,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma_anon_vma(vma))
 		return NULL;
 	return vma;
 }
@@ -1191,7 +1191,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 			goto mm_exiting;
 
 		for_each_vma(vmi, vma) {
-			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+			if (!(vma->vm_flags & VM_MERGEABLE) || !vma_anon_vma(vma))
 				continue;
 			err = unmerge_ksm_pages(vma,
 						vma->vm_start, vma->vm_end, false);
@@ -1570,8 +1570,8 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	remove_rmap_item_from_tree(rmap_item);
 
 	/* Must get reference to anon_vma while still holding mmap_lock */
-	rmap_item->anon_vma = vma->anon_vma;
-	get_anon_vma(vma->anon_vma);
+	rmap_item->anon_vma = vma_anon_vma(vma);
+	get_anon_vma(vma_anon_vma(vma));
 out:
 	mmap_read_unlock(mm);
 	trace_ksm_merge_with_ksm_page(kpage, page_to_pfn(kpage ? kpage : page),
@@ -2537,7 +2537,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
-		if (!vma->anon_vma)
+		if (!vma_anon_vma(vma))
 			ksm_scan.address = vma->vm_end;
 
 		while (ksm_scan.address < vma->vm_end) {
@@ -2714,7 +2714,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_MERGEABLE))
 		return 0;
 
-	if (vma->anon_vma) {
+	if (vma_anon_vma(vma)) {
 		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end, true);
 		if (err)
 			return err;
@@ -2852,7 +2852,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		if (!(*vm_flags & VM_MERGEABLE))
 			return 0;		/* just ignore the advice */
 
-		if (vma->anon_vma) {
+		if (vma_anon_vma(vma)) {
 			err = unmerge_ksm_pages(vma, start, end, true);
 			if (err)
 				return err;
@@ -2969,7 +2969,7 @@ struct folio *ksm_might_need_to_copy(struct folio *folio,
 	} else if (!anon_vma) {
 		return folio;		/* no need to copy it */
 	} else if (folio->index == linear_page_index(vma, addr) &&
-			anon_vma->root == vma->anon_vma->root) {
+			anon_vma->root == vma_anon_vma(vma)->root) {
 		return folio;		/* still no need to copy it */
 	}
 	if (PageHWPoison(page))
diff --git a/mm/memory.c b/mm/memory.c
index a838c8c44bfd..8b9cbe2cb85d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -536,7 +536,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	if (page)
 		dump_page(page, "bad pte");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
-		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
+		 (void *)addr, vma->vm_flags, vma_anon_vma(vma), mapping, index);
 	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
@@ -1359,7 +1359,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (src_vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 		return true;
 
-	if (src_vma->anon_vma)
+	if (vma_maybe_has_pagetables(src_vma))
 		return true;
 
 	/*
@@ -3445,7 +3445,7 @@ vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
-	if (likely(vma->anon_vma))
+	if (likely(vma_anon_vma(vma)))
 		return 0;
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 		if (!mmap_read_trylock(vma->vm_mm))
diff --git a/mm/mmap.c b/mm/mmap.c
index efcc4ca7500d..1ccf1a065bc2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1350,7 +1350,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	 * Similarly in do_mmap and in do_brk_flags.
 	 */
 	if (vma_is_anonymous(vma)) {
-		BUG_ON(vma->anon_vma);
+		BUG_ON(vma_anon_vma(vma));
 		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
 	}
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 62c1f7945741..bf9bda53cfdb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -651,7 +651,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 			newflags |= VM_ACCOUNT;
 		}
 	} else if ((oldflags & VM_ACCOUNT) && vma_is_anonymous(vma) &&
-		   !vma->anon_vma) {
+		   !vma_anon_vma(vma)) {
 		newflags &= ~VM_ACCOUNT;
 	}
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 456849b9e7bd..a59d4e295c02 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -142,14 +142,14 @@ static void take_rmap_locks(struct vm_area_struct *vma)
 {
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
-	if (vma->anon_vma)
-		anon_vma_lock_write(vma->anon_vma);
+	if (vma_anon_vma(vma))
+		anon_vma_lock_write(vma_anon_vma(vma));
 }
 
 static void drop_rmap_locks(struct vm_area_struct *vma)
 {
-	if (vma->anon_vma)
-		anon_vma_unlock_write(vma->anon_vma);
+	if (vma_anon_vma(vma))
+		anon_vma_unlock_write(vma_anon_vma(vma));
 	if (vma->vm_file)
 		i_mmap_unlock_write(vma->vm_file->f_mapping);
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 67bb273dfb80..7e06e62d14a6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -209,8 +209,8 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	anon_vma_lock_write(anon_vma);
 	/* page_table_lock to protect against threads */
 	spin_lock(&mm->page_table_lock);
-	if (likely(!vma->anon_vma)) {
-		vma->anon_vma = anon_vma;
+	if (likely(!vma_anon_vma(vma))) {
+		vma_set_anon_vma(vma, anon_vma);
 		anon_vma_chain_link(vma, avc, anon_vma);
 		anon_vma->num_active_vmas++;
 		allocated = NULL;
@@ -304,13 +304,13 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 		 * Root anon_vma is never reused:
 		 * it has self-parent reference and at least one child.
 		 */
-		if (!dst->anon_vma && src->anon_vma &&
+		if (!vma_anon_vma(dst) && vma_anon_vma(src) &&
 		    anon_vma->num_children < 2 &&
 		    anon_vma->num_active_vmas == 0)
-			dst->anon_vma = anon_vma;
+			vma_set_anon_vma(dst, anon_vma);
 	}
-	if (dst->anon_vma)
-		dst->anon_vma->num_active_vmas++;
+	if (vma_anon_vma(dst))
+		vma_anon_vma(dst)->num_active_vmas++;
 	unlock_anon_vma_root(root);
 	return 0;
 
@@ -321,7 +321,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 	 * We can safely do this because callers of anon_vma_clone() don't care
 	 * about dst->anon_vma if anon_vma_clone() failed.
 	 */
-	dst->anon_vma = NULL;
+	vma_clear_anon_vma(dst);
 	unlink_anon_vmas(dst);
 	return -ENOMEM;
 }
@@ -338,11 +338,11 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	int error;
 
 	/* Don't bother if the parent process has no anon_vma here. */
-	if (!pvma->anon_vma)
+	if (!vma_anon_vma(pvma))
 		return 0;
 
 	/* Drop inherited anon_vma, we'll reuse existing or allocate new. */
-	vma->anon_vma = NULL;
+	vma_clear_anon_vma(vma);
 
 	/*
 	 * First, attach the new VMA to the parent VMA's anon_vmas,
@@ -353,7 +353,7 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 		return error;
 
 	/* An existing anon_vma has been reused, all done then. */
-	if (vma->anon_vma)
+	if (vma_anon_vma(vma))
 		return 0;
 
 	/* Then add our own anon_vma. */
@@ -369,8 +369,8 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	 * The root anon_vma's rwsem is the lock actually used when we
 	 * lock any of the anon_vmas in this anon_vma tree.
 	 */
-	anon_vma->root = pvma->anon_vma->root;
-	anon_vma->parent = pvma->anon_vma;
+	anon_vma->root = vma_anon_vma(pvma)->root;
+	anon_vma->parent = vma_anon_vma(pvma);
 	/*
 	 * With refcounts, an anon_vma can stay around longer than the
 	 * process it belongs to. The root anon_vma needs to be pinned until
@@ -378,7 +378,7 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	 */
 	get_anon_vma(anon_vma->root);
 	/* Mark this anon_vma as the one where our new (COWed) pages go. */
-	vma->anon_vma = anon_vma;
+	vma_set_anon_vma(vma, anon_vma);
 	anon_vma_lock_write(anon_vma);
 	anon_vma_chain_link(vma, avc, anon_vma);
 	anon_vma->parent->num_children++;
@@ -420,14 +420,14 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 		list_del(&avc->same_vma);
 		anon_vma_chain_free(avc);
 	}
-	if (vma->anon_vma) {
-		vma->anon_vma->num_active_vmas--;
+	if (vma_anon_vma(vma)) {
+		vma_anon_vma(vma)->num_active_vmas--;
 
 		/*
 		 * vma would still be needed after unlink, and anon_vma will be prepared
 		 * when handle fault.
 		 */
-		vma->anon_vma = NULL;
+		vma_clear_anon_vma(vma);
 	}
 	unlock_anon_vma_root(root);
 
@@ -794,8 +794,8 @@ unsigned long page_address_in_vma(const struct folio *folio,
 		 * Note: swapoff's unuse_vma() is more efficient with this
 		 * check, and needs it to match anon_vma when KSM is active.
 		 */
-		if (!vma->anon_vma || !page__anon_vma ||
-		    vma->anon_vma->root != page__anon_vma->root)
+		if (!vma_anon_vma(vma) || !page__anon_vma ||
+		    vma_anon_vma(vma)->root != page__anon_vma->root)
 			return -EFAULT;
 	} else if (!vma->vm_file) {
 		return -EFAULT;
@@ -1329,7 +1329,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
  */
 void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
 {
-	void *anon_vma = vma->anon_vma;
+	void *anon_vma = vma_anon_vma(vma);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_VMA(!anon_vma, vma);
@@ -1353,7 +1353,7 @@ void folio_move_anon_rmap(struct folio *folio, struct vm_area_struct *vma)
 static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
 			     unsigned long address, bool exclusive)
 {
-	struct anon_vma *anon_vma = vma->anon_vma;
+	struct anon_vma *anon_vma = vma_anon_vma(vma);
 
 	BUG_ON(!anon_vma);
 
@@ -1397,7 +1397,7 @@ static void __page_check_anon_rmap(const struct folio *folio,
 	 * are initially only visible via the pagetables, and the pte is locked
 	 * over the call to folio_add_new_anon_rmap.
 	 */
-	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma->anon_vma->root,
+	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma_anon_vma(vma)->root,
 			folio);
 	VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address),
 		       page);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 628f67974a7c..ed044fcdacfb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2234,7 +2234,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 
 	mmap_read_lock(mm);
 	for_each_vma(vmi, vma) {
-		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
+		if (vma_anon_vma(vma) && !is_vm_hugetlb_page(vma)) {
 			ret = unuse_vma(vma, type);
 			if (ret)
 				break;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index fbf2cf62ab9f..1163b10e841e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -77,7 +77,7 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 		 * We know we're going to need to use anon_vma, so check
 		 * that early.
 		 */
-		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
+		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma_anon_vma(vma)))
 			vma_end_read(vma);
 		else
 			return vma;
diff --git a/mm/vma.c b/mm/vma.c
index 76bec07e30b7..04331987ffea 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -99,7 +99,7 @@ static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
 static inline bool are_anon_vmas_compatible(struct vm_area_struct *vma1,
 					    struct vm_area_struct *vma2)
 {
-	return is_mergeable_anon_vma(vma1->anon_vma, vma2->anon_vma, NULL);
+	return is_mergeable_anon_vma(vma_anon_vma(vma1), vma_anon_vma(vma2), NULL);
 }
 
 /*
@@ -118,7 +118,7 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 
 	memset(vp, 0, sizeof(struct vma_prepare));
 	vp->vma = vma;
-	vp->anon_vma = vma->anon_vma;
+	vp->anon_vma = vma_anon_vma(vma);
 
 	if (vmg && vmg->__remove_middle) {
 		*remove = vmg->middle;
@@ -136,10 +136,10 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 
 	vp->adj_next = adjust;
 	if (!vp->anon_vma && adjust)
-		vp->anon_vma = adjust->anon_vma;
+		vp->anon_vma = vma_anon_vma(adjust);
 
-	VM_WARN_ON(vp->anon_vma && adjust && adjust->anon_vma &&
-		   vp->anon_vma != adjust->anon_vma);
+	VM_WARN_ON(vp->anon_vma && adjust && vma_anon_vma(adjust) &&
+		   vp->anon_vma != vma_anon_vma(adjust));
 
 	vp->file = vma->vm_file;
 	if (vp->file)
@@ -164,7 +164,7 @@ static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
 
 	if (is_mergeable_vma(vmg, /* merge_next = */ true) &&
-	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
+	    is_mergeable_anon_vma(vmg->anon_vma, vma_anon_vma(vmg->next), vmg->next)) {
 		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
 			return true;
 	}
@@ -184,7 +184,7 @@ static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 static bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
 	if (is_mergeable_vma(vmg, /* merge_next = */ false) &&
-	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
+	    is_mergeable_anon_vma(vmg->anon_vma, vma_anon_vma(vmg->prev), vmg->prev)) {
 		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
 			return true;
 	}
@@ -347,7 +347,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
 				      vp->remove->vm_end);
 			fput(vp->file);
 		}
-		if (vp->remove->anon_vma)
+		if (vma_anon_vma(vp->remove))
 			anon_vma_merge(vp->vma, vp->remove);
 		mm->map_count--;
 		mpol_put(vma_policy(vp->remove));
@@ -569,11 +569,11 @@ static int dup_anon_vma(struct vm_area_struct *dst,
 	 * expanding vma has anon_vma set if the shrinking vma had, to cover any
 	 * anon pages imported.
 	 */
-	if (src->anon_vma && !dst->anon_vma) {
+	if (vma_anon_vma(src) && !vma_anon_vma(dst)) {
 		int ret;
 
 		vma_assert_write_locked(dst);
-		dst->anon_vma = src->anon_vma;
+		vma_dup_anon_vma(dst, src);
 		ret = anon_vma_clone(dst, src);
 		if (ret)
 			return ret;
@@ -595,7 +595,7 @@ void validate_mm(struct mm_struct *mm)
 	mt_validate(&mm->mm_mt);
 	for_each_vma(vmi, vma) {
 #ifdef CONFIG_DEBUG_VM_RB
-		struct anon_vma *anon_vma = vma->anon_vma;
+		struct anon_vma *anon_vma = vma_anon_vma(vma);
 		struct anon_vma_chain *avc;
 #endif
 		unsigned long vmi_start, vmi_end;
@@ -858,7 +858,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		 * simply a case of, if prev has no anon_vma object, which of
 		 * next or middle contains the anon_vma we must duplicate.
 		 */
-		err = dup_anon_vma(prev, next->anon_vma ? next : middle,
+		err = dup_anon_vma(prev, vma_anon_vma(next) ? next : middle,
 				   &anon_dup);
 	} else if (merge_left) {
 		/*
@@ -1735,7 +1735,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
+	if (unlikely(vma_is_anonymous(vma) && !vma_anon_vma(vma))) {
 		pgoff = addr >> PAGE_SHIFT;
 		faulted_in_anon_vma = false;
 	}
@@ -1854,7 +1854,7 @@ static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old,
 					  struct vm_area_struct *b)
 {
 	if (anon_vma_compatible(a, b)) {
-		struct anon_vma *anon_vma = READ_ONCE(old->anon_vma);
+		struct anon_vma *anon_vma = vma_anon_vma(old);
 
 		if (anon_vma && list_is_singular(&old->anon_vma_chain))
 			return anon_vma;
@@ -2108,7 +2108,7 @@ int mm_take_all_locks(struct mm_struct *mm)
 	for_each_vma(vmi, vma) {
 		if (signal_pending(current))
 			goto out_unlock;
-		if (vma->anon_vma)
+		if (vma_anon_vma(vma))
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_lock_anon_vma(mm, avc->anon_vma);
 	}
@@ -2170,7 +2170,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
 
 	for_each_vma(vmi, vma) {
-		if (vma->anon_vma)
+		if (vma_anon_vma(vma))
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
 		if (vma->vm_file && vma->vm_file->f_mapping)
@@ -2844,7 +2844,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	/* Lock the VMA before expanding to prevent concurrent page faults */
 	vma_start_write(vma);
 	/* We update the anon VMA tree. */
-	anon_vma_lock_write(vma->anon_vma);
+	anon_vma_lock_write(vma_anon_vma(vma));
 
 	/* Somebody else might have raced and expanded it already */
 	if (address > vma->vm_end) {
@@ -2870,7 +2870,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 			}
 		}
 	}
-	anon_vma_unlock_write(vma->anon_vma);
+	anon_vma_unlock_write(vma_anon_vma(vma));
 	vma_iter_free(&vmi);
 	validate_mm(mm);
 	return error;
@@ -2923,7 +2923,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	/* Lock the VMA before expanding to prevent concurrent page faults */
 	vma_start_write(vma);
 	/* We update the anon VMA tree. */
-	anon_vma_lock_write(vma->anon_vma);
+	anon_vma_lock_write(vma_anon_vma(vma));
 
 	/* Somebody else might have raced and expanded it already */
 	if (address < vma->vm_start) {
@@ -2950,7 +2950,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 			}
 		}
 	}
-	anon_vma_unlock_write(vma->anon_vma);
+	anon_vma_unlock_write(vma_anon_vma(vma));
 	vma_iter_free(&vmi);
 	validate_mm(mm);
 	return error;
@@ -2973,3 +2973,62 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	userfaultfd_unmap_complete(mm, &uf);
 	return ret;
 }
+
+/*
+ * Helper to set the vma->anon_vma field, if not already set to a 'real'
+ * anon_vma (we are ok with overwriting flag-only values).
+ *
+ * mmap read lock or better must be held, this function correctly acquires the
+ * mm page table lock to prevent races against other writers.
+ */
+static void vma_set_anon_vma_if_unset(struct vm_area_struct *vma,
+		unsigned long val)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	/* Must hold mmap read-lock at least. */
+	mmap_assert_locked(vma->vm_mm);
+	/* If we already have a 'real' anon_vma set, abort. */
+	if (vma_anon_vma(vma))
+		return;
+
+	/*
+	 * anon_vma, in vma's visible to other threads, when previously unset
+	 * (or unfaulted), is protected from races against other setters via the
+	 * mm->page_table_lock.
+	 */
+	spin_lock(&mm->page_table_lock);
+	/* We recheck under the lock. Above check is an optimisation. */
+	if (!vma_anon_vma(vma))
+		WRITE_ONCE(vma->anon_vma, val);
+	spin_unlock(&mm->page_table_lock);
+}
+
+/*
+ * Indicate that the VMA has an unfaulted anon_vma field, that is, no anon_vma
+ * has been initialised yet, but page table data may in fact be present that
+ * ought to be propagated on fork, for instance, guard regions.
+ *
+ * This flag will be cleared whenever an anon_vma is actually set for instance
+ * upon faulting in, and does not impact any operation that otherwise
+ * manipulates the anon_vma.
+ *
+ * If an anon_vma is already present, then we do nothing.
+ *
+ * This requires mmap read lock at least.
+ */
+void vma_set_anon_vma_unfaulted(struct vm_area_struct *vma)
+{
+	vma_set_anon_vma_if_unset(vma, ANON_VMA_UNFAULTED);
+}
+
+/*
+ * Clear the vma's anon_vma field of the ANON_VMA_UNFAULTED flag, if and only if
+ * it has not since had a 'real' anon_vma installed.
+ *
+ * This requires mmap read lock at least.
+ */
+void vma_clear_anon_vma_unfaulted(struct vm_area_struct *vma)
+{
+	vma_set_anon_vma_if_unset(vma, 0);
+}
diff --git a/mm/vma.h b/mm/vma.h
index 7356ca5a22d3..5ff473796f3d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -174,7 +174,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.flags = vma_->vm_flags,			\
 		.pgoff = vma_pgoff_offset(vma_, start_),	\
 		.file = vma_->vm_file,				\
-		.anon_vma = vma_->anon_vma,			\
+		.anon_vma = vma_anon_vma(vma_),			\
 		.policy = vma_policy(vma_),			\
 		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
 		.anon_name = anon_vma_name(vma_),		\
@@ -265,6 +265,10 @@ __must_check struct vm_area_struct
 		  struct vm_area_struct *vma,
 		  unsigned long delta);
 
+/* Functions for setting/clearing vma->anon_vma unfaulted flag. */
+void vma_set_anon_vma_unfaulted(struct vm_area_struct *vma);
+void vma_clear_anon_vma_unfaulted(struct vm_area_struct *vma);
+
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb);
 
 void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b867dfec88b..2a40b85c3e37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3869,7 +3869,7 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 			    vma_is_stack_for_current(vma))) {
 			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
-		} else if (vma->vm_file && vma->anon_vma) {
+		} else if (vma->vm_file && vma_anon_vma(vma)) {
 			/*
 			 * We are making executable a file mapping that has
 			 * had some COW done. Since pages might have been
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 11f761769b5b..1918cbd6faca 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -46,6 +46,9 @@ static struct anon_vma dummy_anon_vma;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+#define DUMMY_ANON_VMA_VAL_1 ((struct anon_vma *)(0xffffffffff600000))
+#define DUMMY_ANON_VMA_VAL_2 ((struct anon_vma *)(0xffffffffff700000))
+
 static struct task_struct __current;
 
 struct task_struct *get_current(void)
@@ -476,7 +479,7 @@ static bool test_merge_new(void)
 	 * AA*B   DD  CC
 	 */
 	vma_a->vm_ops = &vm_ops; /* This should have no impact. */
-	vma_b->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma_b, &dummy_anon_vma);
 	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
 	ASSERT_EQ(vma, vma_a);
 	/* Merge with A, delete B. */
@@ -484,7 +487,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x4000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
-	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
 
@@ -501,7 +504,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x5000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
-	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
 
@@ -511,7 +514,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AAAAA *DD  CC
 	 */
-	vma_d->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma_d, &dummy_anon_vma);
 	vma_d->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
 	ASSERT_EQ(vma, vma_d);
@@ -520,7 +523,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_start, 0x6000);
 	ASSERT_EQ(vma->vm_end, 0x9000);
 	ASSERT_EQ(vma->vm_pgoff, 6);
-	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
 
@@ -538,7 +541,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x9000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
-	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
 
@@ -548,7 +551,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AAAAAAAAA *CC
 	 */
-	vma_c->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma_c, &dummy_anon_vma);
 	vma = try_merge_new_vma(&mm, &vmg, 0xa000, 0xb000, 0xa, flags, &merged);
 	ASSERT_EQ(vma, vma_c);
 	/* Prepend C. */
@@ -556,7 +559,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_start, 0xa000);
 	ASSERT_EQ(vma->vm_end, 0xc000);
 	ASSERT_EQ(vma->vm_pgoff, 0xa);
-	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
 
@@ -573,7 +576,7 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0xc000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
-	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
 
@@ -591,7 +594,7 @@ static bool test_merge_new(void)
 		ASSERT_EQ(vma->vm_start, 0);
 		ASSERT_EQ(vma->vm_end, 0xc000);
 		ASSERT_EQ(vma->vm_pgoff, 0);
-		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+		ASSERT_EQ(vma_anon_vma(vma), &dummy_anon_vma);
 
 		vm_area_free(vma);
 		count++;
@@ -971,13 +974,13 @@ static bool test_merge_existing(void)
 	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
 	vmg.middle = vma;
 	vmg.prev = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x3000);
 	ASSERT_EQ(vma_next->vm_end, 0x9000);
 	ASSERT_EQ(vma_next->vm_pgoff, 3);
-	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma_next), &dummy_anon_vma);
 	ASSERT_EQ(vma->vm_start, 0x2000);
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma->vm_pgoff, 2);
@@ -1003,13 +1006,13 @@ static bool test_merge_existing(void)
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
 	vmg.middle = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x2000);
 	ASSERT_EQ(vma_next->vm_end, 0x9000);
 	ASSERT_EQ(vma_next->vm_pgoff, 2);
-	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma_next), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 1);
 
@@ -1033,14 +1036,14 @@ static bool test_merge_existing(void)
 	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x6000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
 	ASSERT_EQ(vma->vm_start, 0x6000);
 	ASSERT_EQ(vma->vm_end, 0x7000);
 	ASSERT_EQ(vma->vm_pgoff, 6);
@@ -1067,13 +1070,13 @@ static bool test_merge_existing(void)
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
 
@@ -1097,13 +1100,13 @@ static bool test_merge_existing(void)
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x9000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
 
@@ -1213,16 +1216,16 @@ static bool test_anon_vma_non_mergeable(void)
 	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
 	ASSERT_TRUE(list_is_singular(&vma_prev->anon_vma_chain));
-	vma_prev->anon_vma = &dummy_anon_vma;
-	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_prev->anon_vma, vma_prev));
+	vma_set_anon_vma(vma_prev, &dummy_anon_vma);
+	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_anon_vma(vma_prev), vma_prev));
 
 	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
 	ASSERT_TRUE(list_is_singular(&vma_next->anon_vma_chain));
-	vma_next->anon_vma = (struct anon_vma *)2;
-	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_next->anon_vma, vma_next));
+	vma_set_anon_vma(vma_next, DUMMY_ANON_VMA_VAL_1);
+	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_anon_vma(vma_next), vma_next));
 
-	ASSERT_FALSE(is_mergeable_anon_vma(vma_prev->anon_vma, vma_next->anon_vma, NULL));
+	ASSERT_FALSE(is_mergeable_anon_vma(vma_anon_vma(vma_prev), vma_anon_vma(vma_next), NULL));
 
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
 	vmg.prev = vma_prev;
@@ -1255,11 +1258,11 @@ static bool test_anon_vma_non_mergeable(void)
 
 	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
-	vma_prev->anon_vma = (struct anon_vma *)1;
+	vma_set_anon_vma(vma_prev, DUMMY_ANON_VMA_VAL_1);
 
 	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
-	vma_next->anon_vma = (struct anon_vma *)2;
+	vma_set_anon_vma(vma_next, DUMMY_ANON_VMA_VAL_2);
 
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
 	vmg.prev = vma_prev;
@@ -1303,7 +1306,7 @@ static bool test_dup_anon_vma(void)
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma_next->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma_next, &dummy_anon_vma);
 
 	vmg_set_range(&vmg, 0, 0x5000, 0, flags);
 	vmg.middle = vma_prev;
@@ -1312,8 +1315,8 @@ static bool test_dup_anon_vma(void)
 	ASSERT_EQ(expand_existing(&vmg), 0);
 
 	/* Will have been cloned. */
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
-	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
+	ASSERT_TRUE(vma_anon_vma(vma_prev)->was_cloned);
 
 	/* Cleanup ready for next run. */
 	cleanup_mm(&mm, &vmi);
@@ -1335,7 +1338,7 @@ static bool test_dup_anon_vma(void)
 	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain.same_vma, &vma_next->anon_vma_chain);
 
-	vma_next->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma_next, &dummy_anon_vma);
 	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1346,8 +1349,8 @@ static bool test_dup_anon_vma(void)
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x8000);
 
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
-	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
+	ASSERT_TRUE(vma_anon_vma(vma_prev)->was_cloned);
 
 	cleanup_mm(&mm, &vmi);
 
@@ -1364,7 +1367,7 @@ static bool test_dup_anon_vma(void)
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
 
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1375,8 +1378,8 @@ static bool test_dup_anon_vma(void)
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x8000);
 
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
-	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
+	ASSERT_TRUE(vma_anon_vma(vma_prev)->was_cloned);
 
 	cleanup_mm(&mm, &vmi);
 
@@ -1392,7 +1395,7 @@ static bool test_dup_anon_vma(void)
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
 
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1403,8 +1406,8 @@ static bool test_dup_anon_vma(void)
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x5000);
 
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
-	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
+	ASSERT_TRUE(vma_anon_vma(vma_prev)->was_cloned);
 
 	cleanup_mm(&mm, &vmi);
 
@@ -1420,7 +1423,7 @@ static bool test_dup_anon_vma(void)
 	vma = alloc_and_link_vma(&mm, 0, 0x5000, 0, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
 
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
@@ -1431,8 +1434,8 @@ static bool test_dup_anon_vma(void)
 	ASSERT_EQ(vma_next->vm_start, 0x3000);
 	ASSERT_EQ(vma_next->vm_end, 0x8000);
 
-	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
-	ASSERT_TRUE(vma_next->anon_vma->was_cloned);
+	ASSERT_EQ(vma_anon_vma(vma_next), &dummy_anon_vma);
+	ASSERT_TRUE(vma_anon_vma(vma_next)->was_cloned);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
@@ -1457,7 +1460,7 @@ static bool test_vmi_prealloc_fail(void)
 
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 
 	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.prev = vma_prev;
@@ -1469,7 +1472,7 @@ static bool test_vmi_prealloc_fail(void)
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
 	/* We will already have assigned the anon_vma. */
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
 	/* And it was both cloned and unlinked. */
 	ASSERT_TRUE(dummy_anon_vma.was_cloned);
 	ASSERT_TRUE(dummy_anon_vma.was_unlinked);
@@ -1484,7 +1487,7 @@ static bool test_vmi_prealloc_fail(void)
 
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_anon_vma(vma, &dummy_anon_vma);
 
 	vmg_set_range(&vmg, 0, 0x5000, 3, flags);
 	vmg.middle = vma_prev;
@@ -1494,7 +1497,7 @@ static bool test_vmi_prealloc_fail(void)
 	ASSERT_EQ(expand_existing(&vmg), -ENOMEM);
 	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
 
-	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma_anon_vma(vma_prev), &dummy_anon_vma);
 	ASSERT_TRUE(dummy_anon_vma.was_cloned);
 	ASSERT_TRUE(dummy_anon_vma.was_unlinked);
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 572ab2cea763..46e668eb80bc 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -135,6 +135,14 @@ typedef __bitwise unsigned int vm_fault_t;
  */
 #define pr_warn_once pr_err
 
+/*
+ * We utilise the fact that the anon_vma will be at least system word aligned
+ * to reclaim bits for flags.
+ */
+#define ANON_VMA_UNFAULTED	1 /* anon_vma set, but not faulted in yet. */
+#define NUM_ANON_VMA_FLAGS	1
+#define ANON_VMA_FLAG_MASK	((1UL << NUM_ANON_VMA_FLAGS) - 1)
+
 struct kref {
 	refcount_t refcount;
 };
@@ -227,6 +235,8 @@ struct mm_struct {
 	unsigned long def_flags;
 
 	unsigned long flags; /* Must use atomic bitops to access */
+
+	spinlock_t page_table_lock;
 };
 
 struct file {
@@ -287,7 +297,8 @@ struct vm_area_struct {
 	 */
 	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
 					  * page_table_lock */
-	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+	/* Contains flags combined with pointer to anon_vma. Use accessor. */
+	unsigned long anon_vma;	/* Serialized by page_table_lock */
 
 	/* Function pointers to deal with this struct. */
 	const struct vm_operations_struct *vm_ops;
@@ -421,6 +432,59 @@ struct vm_unmapped_area_info {
 	unsigned long start_gap;
 };
 
+
+/*
+ * The below functions assume the caller has obtained the appropriate locks
+ * before calling, See process address documentation for details.
+ */
+
+/* Extract anon_vma from vma if it has been set. */
+static inline struct anon_vma *vma_anon_vma(const struct vm_area_struct *vma)
+{
+	unsigned long val = READ_ONCE(vma->anon_vma);
+
+	return (struct anon_vma *)(val & ~ANON_VMA_FLAG_MASK);
+}
+
+/* Retrieve any flags encoded in the vma->anon_vma field. */
+static inline unsigned int vma_anon_vma_flags(const struct vm_area_struct *vma)
+{
+	unsigned long val = READ_ONCE(vma->anon_vma);
+
+	return (unsigned int)(val & ANON_VMA_FLAG_MASK);
+}
+
+/* Set the anon_vma field, clearing any anon_vma flags. */
+static inline void vma_set_anon_vma(struct vm_area_struct *vma,
+		struct anon_vma *anon_vma)
+{
+	WRITE_ONCE(vma->anon_vma, (unsigned long)anon_vma);
+}
+
+/* Clear the existing anon_vma and any anon_vma flags. */
+static inline void vma_clear_anon_vma(struct vm_area_struct *vma)
+{
+	WRITE_ONCE(vma->anon_vma, 0);
+}
+
+/* Duplicate anon_vma from src to dst, retaining flags. */
+static inline void vma_dup_anon_vma(struct vm_area_struct *dst,
+		const struct vm_area_struct *src)
+{
+	WRITE_ONCE(dst->anon_vma, READ_ONCE(src->anon_vma));
+}
+
+/* Does the VMA have an anon_vma or any anon_vma flags set? */
+static inline bool vma_anon_vma_empty(struct vm_area_struct *vma)
+{
+	unsigned long val = READ_ONCE(vma->anon_vma);
+
+	if (val)
+		return false;
+
+	return true;
+}
+
 static inline void vma_iter_invalidate(struct vma_iterator *vmi)
 {
 	mas_pause(&vmi->mas);
@@ -768,9 +832,9 @@ static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct
 static inline int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 {
 	/* For testing purposes. We indicate that an anon_vma has been cloned. */
-	if (src->anon_vma != NULL) {
-		dst->anon_vma = src->anon_vma;
-		dst->anon_vma->was_cloned = true;
+	if (vma_anon_vma(src) != NULL) {
+		vma_dup_anon_vma(dst, src);
+		vma_anon_vma(dst)->was_cloned = true;
 	}
 
 	return 0;
@@ -859,7 +923,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *)
 static inline void unlink_anon_vmas(struct vm_area_struct *vma)
 {
 	/* For testing purposes, indicate that the anon_vma was unlinked. */
-	vma->anon_vma->was_unlinked = true;
+	vma_anon_vma(vma)->was_unlinked = true;
 }
 
 static inline void anon_vma_unlock_write(struct anon_vma *)
@@ -1161,14 +1225,14 @@ static inline int __anon_vma_prepare(struct vm_area_struct *vma)
 		return -ENOMEM;
 
 	anon_vma->root = anon_vma;
-	vma->anon_vma = anon_vma;
+	vma_set_anon_vma(vma, anon_vma);
 
 	return 0;
 }
 
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
 {
-	if (likely(vma->anon_vma))
+	if (likely(vma_anon_vma(vma)))
 		return 0;
 
 	return __anon_vma_prepare(vma);
-- 
2.48.1


