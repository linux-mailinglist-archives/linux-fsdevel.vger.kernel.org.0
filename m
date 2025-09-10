Return-Path: <linux-fsdevel+bounces-60838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2767B521E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45D67B9DB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CAE2FB607;
	Wed, 10 Sep 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="phx2wMce";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jPV+fErD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05082F363F;
	Wed, 10 Sep 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535800; cv=fail; b=WrtWzz036f4wziIoxXxprMFx69fHhwanhUaHN1SqOmD9SteJSOnVuzX6r5msy2WyeI7VBiaiU6wtlf17iQSSE3AGPP5tQz0Br7e5OniJnVu8TfmnfZmzRIAqgP9eRZqt0/h9yOSlr95Gde8xLEDLhgbQuL1ELqDgGGf+iTKfP7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535800; c=relaxed/simple;
	bh=2++/s9XH8uJJ6CPezliHtngfkaGLv8gpHr9Xqzk/L14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4bxcDGdZlKzN8tJihl0s0hHNqFWJEzZvtpjjOffGF/ux2UqRng7sHsw/yPCkNICwW68WwmcethI6kKoat3fHZqEKCnEVP/rXnsrhGT0UDrMWG0ROzFphPlTisfPkm40bH9u/exX87rTIWCruia8B05Vf4dK1Nd1+A9LRi6j51I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=phx2wMce; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jPV+fErD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfiEQ005177;
	Wed, 10 Sep 2025 20:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pHTSDKgEPrqiEwdVqZJMgJ38DNBd/ZIi2DccuQYZpxs=; b=
	phx2wMcehpZL1VMk1o5x6/W65A76zr7GwNpXynmAwjUydWgo2+hJznH/rpTGRids
	VUa4j5kVe+hTXRhfuh3mat7FpD9fS2wsGtvwTcvJadtBfdjRzqx1rdRjesFlqkVr
	gligQPlbzVURAaPwGY0wdffBMSXwvRdV7apPBV4Paz8Z2pz+XVtZLgUVGxRxHD/u
	4JqIjw/z6QvTtFkWMlL0oXBSWgrquLsTpAHX0GfAYmt9KQg9IAMUDyVAZY2KoMdO
	jW9SR9dNIUJlDRbDZjYbsNnqIttqBhEsfl2lvGnGO4LdVoW2ICE1bhnDakvdubuK
	wRXvr80YHTp+FTKOd1ZhAw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226svyx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AK3dAs030716;
	Wed, 10 Sep 2025 20:22:36 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbfhjs-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAl1QJLhxkk2eGXVkbnB6699/xgUc46ywKIW6fP+1jh1Dsi3V5rA48dOlXDuBJmiJcVuHcQvqB9HefuqEmwm3lxVMg26dQM0ZqZHGjTlEtEoMD/DMw3h9uuwxg+z9pfID3N6PmLjokkTiTh3xrwafx3eOmBy8rsvCwZcUPCriOO0O1oUt7fAMjA34E5RHtq5zjnUaqgMPsmeCD33kENvLELrxdey8mNcPW6rAD7gKCbwHh8GBm2/LKI49N5W5Zbl0NpR4NghnjIIZY+EumcLMWdOSYY5jQQh/Oxm0k6imMXRDMC8u5ZMJqkr27jFFXDNqGVjC7UoqdbHpzua9Rk4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHTSDKgEPrqiEwdVqZJMgJ38DNBd/ZIi2DccuQYZpxs=;
 b=f6H4GX4AcybSNUb/pAfp5bhlivT1C3avWjkEAS6Ol6+MvU8QcEy6Bt2/4t2p74ORwr6SRG+GzY7b1tfs9b1udKtjJJkxWrf72dqwIgqwaU0UOzLlR7NZfiJqirIk6yNySzai08uPtcz9nhYJj+SCOCsWfim4wUmawukDp77Ri9dGPshbSECgnK/CPgX5UdyqZOdgJlPQa3jNFF1SCmhzTzWQvZvD2mf0wZ0dhZeNVxN3jP9IKxfZidQu0VqHqNySEEb25dpE3K63EN+oWh0w8y/JtiWYymwiGx4FCjT5QCXeWq4BbmGfCfL2Q1kleJFKp2b1T44Vmk2a9rnYL9wNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHTSDKgEPrqiEwdVqZJMgJ38DNBd/ZIi2DccuQYZpxs=;
 b=jPV+fErD7uv9eb9zvopvSfT0/LFddDI7Y/3QuwxvWN6R8Dk6UHqteDxZ9Rnrl68es5kbi91bBmW5oFd3BA57QLru5c6r8/vyAL31zAC+POehJ9qvXuOWa9oM7YH1v3uQ3fsLS6JGyrkjk31sRysAkMA+qLAhpwpgO6m1PSC5ljs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 20:22:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:33 +0000
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 02/16] device/dax: update devdax to use mmap_prepare
Date: Wed, 10 Sep 2025 21:21:57 +0100
Message-ID: <12f96a872e9067fa678a37b8616d12b2c8d1cc10.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004524.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::345) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: f77d8876-69b6-433d-77c7-08ddf0a7c5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/8oAtNDHiNvTcCpP2VuL2JrmxEC5oRHDCe2mL5gRYcWwK9oAD2KRQYrTqMfu?=
 =?us-ascii?Q?eDR0Zoo8EPeQXtfChULk0jO76lbWS/tx6Tdy0Pu8Zfvsb4r4cE266a5aQuVt?=
 =?us-ascii?Q?5a5wkvhuEOff8Grx3v7tI0EhPPVWCpl2glpNSqRMLgaxvfDvMywKzlja1d2q?=
 =?us-ascii?Q?QrC0/NkE/09c3/qkmRFfU0BRCV68mplboWHSdxGfa/meF3FQSJWr/FsBoSPH?=
 =?us-ascii?Q?aVjhZfJA1jbTVZTH9vvOWJMklLK6G8GqJj6cE+7pZObAa9J/eE/lZ1r0k4VI?=
 =?us-ascii?Q?HqkgrxnjEjfttSC/QZt6V8oGaIeszIvLrkSjdYDW+KJU3vvWclOV1Fh2Wgmk?=
 =?us-ascii?Q?jJwIihPENRI5sPMyYKcC+Iu4J1w/FLEQC4agwccErE+QKDD9rs37vRki/nIz?=
 =?us-ascii?Q?y8etny9HrccBQkAO/p/b6D0yiz8tC+s/24Z1FUHhjyiVBMlK7aV4KeAS9ft2?=
 =?us-ascii?Q?616q2IMhMAYVNnzTSeymYrWHraAvFZ+bI7M1rlVlQ5n7oV5Sp6bX5qP6N/dL?=
 =?us-ascii?Q?fdNUJ2k7bHo72ZJI0DsjymcdxiMjlvy7KeH+VgiCoGXNivro7mPx1ZmnbCJd?=
 =?us-ascii?Q?NrxYKwunJiMo8Bg3e7NQjRjaJ1qYRwjMaqEkXha6mw4QkFYts4b0MVIXOI7Z?=
 =?us-ascii?Q?caJ+E4JNv9aiW7XDJTyCAWuH6XxCcO0hgwmSlJ+jMYH/TqdUY6QKk/qk6MVh?=
 =?us-ascii?Q?X4l2yxmwHPrUYRrrGVkCT7IOPm6kEkdqarzVXEHsQz0j0olUino2saI5SVBd?=
 =?us-ascii?Q?jrooJ45Bu+ODr/+WKYHs98rF0Wkj7o1mh+LoO/kIMv6NaEDEBCDFW74hDh2N?=
 =?us-ascii?Q?+OLjieR2GqMdh2U0264TCJthhAPCvyRmiT/8x2vdBdtnmG/EKU+TpRHua03N?=
 =?us-ascii?Q?T7e40xmROionWXdZsPyNTw5hMcl8++asAnBSVQvzxq0QCyAMu+XszwFz3bkH?=
 =?us-ascii?Q?nToV1s9jCD4Jy9LDEQrJslb3Ns7VxP58PSYalun8F/MDT96SyHyTo1b5i55h?=
 =?us-ascii?Q?gWLNDT0HObJNY6fuXh70/4V49e/c0kVp7DUZYaucwAEaA88GHAOGbVOZKYuT?=
 =?us-ascii?Q?hBgWT5yIHn6zqnjBkqsI/O3L+2CN20Sim7N9OuxxTk78ISuxh/tmSVQD06zq?=
 =?us-ascii?Q?HAzutWE0q0RNCsGhKqifAcbYPhmmY032IdTHHNHT0V65W16gc5VXrsSe7H5i?=
 =?us-ascii?Q?veKRFRPm6R543JyERCQgf9HU2PvLwFm7lXopyieLBUpoKmdTmMLtMXUfRpro?=
 =?us-ascii?Q?ZQmNna35ojVuxL0XuyKBejqoYglegUdt2sys7zsxd+LS3h3lPakLZgB/sT2D?=
 =?us-ascii?Q?LuiJa+kJ6OpU1ZZxLU74JfkOK/CtCuBd4RTnbWyABn5UIiHUOYNDp6Tf4/IM?=
 =?us-ascii?Q?uqzPcmO01lriu+OMR0wVxyfZbHPbr+zuyybEWNDkWRr5MihVDWs+52RRoNoE?=
 =?us-ascii?Q?9MdHsBl54o0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YqB44gdwKQf55Azf//PW6/sYTy4a6VoL5mLEdSn/JhWPhZPvldtHtVZfQM/z?=
 =?us-ascii?Q?xlB5YAPDqHvgBQNEDr4JSjlkOJAPKVFtlKH2K82Rp8Qrir18Nt9RJvTrCfkA?=
 =?us-ascii?Q?cJWOWp/h8wU0U3/yyb+WzawJ7+fQqyC4ct5W5u7fYpZ9JMu2hKXga5i33Sq9?=
 =?us-ascii?Q?uGgLyusnZ21Gb5xXL79OMOUFWzG82gYDA/aAO2d83LVH/vAczldVEtsn1m7g?=
 =?us-ascii?Q?QlGzaEh5IXq3oHHySxaH+hz1EvHO45u/Ke5c2sFiwmoLIVYmUofWpTFov1sa?=
 =?us-ascii?Q?LBJ2OrL/Why03gAawEAblGMOmb4l7d/Zt9YQ7iFfLqMmZru6IOJMEduOJNwQ?=
 =?us-ascii?Q?kT8tqRGJFLpoYxEcaNaKIG0V8MV07/MtXZCdg0zdJCF3IbNQ0A2L9sLA9QyI?=
 =?us-ascii?Q?0DimkmJi/m8GFxqA8tdiSgiw59aEElxxVZ1OeGBcCXtCcnqVKtBmLcNveRt7?=
 =?us-ascii?Q?VkNt7ALw7rp8JZitCEOlXX/4z/UQrcGDlU8OadaNQDfiRIU4ubC2HOW8Yljh?=
 =?us-ascii?Q?HsUClg7tDzuDp99qKXqc1gYJtDV+ccdfpRijtCtoTvstNPLJLdTD6VXeYjYm?=
 =?us-ascii?Q?4QQ75H+6S4hzBxanZ3Y+D80xDD0VjxrqiXhP2aLmzOC2SLF216rKMPsmB2iz?=
 =?us-ascii?Q?XBLyYYLurREEtDCQYjZe48VaYXKeJA96x1hlwCPnZ7oGd88pkMo6pvlKKiT5?=
 =?us-ascii?Q?uHcfiia/+Rq7k9wUqUvgjXzIwVuhMzLR7zR8xkr4BHw3WXeuZ5eN7hEDOP0z?=
 =?us-ascii?Q?yHqEPvrrpIOdAr+DR//i7fXcVuiwAFwrvx5mREl4EtUt+pDHsl+1E3bequC/?=
 =?us-ascii?Q?K1uYujqToXFfwgbBStuMiNosn0qAUaG6wvY3QXltP6ntQXHdRkUt3HJZg/bd?=
 =?us-ascii?Q?ElpyQIRqdRkqIZGTxWwelXB+HoaUo6FokcwwT9CwIVRnqNfy0sre9AL9cboI?=
 =?us-ascii?Q?hIF4uBAQ87YNu57R1XhxDlNgq+fAIqMLR+s2eAoFosT7UFYidU6ljeeo7iPk?=
 =?us-ascii?Q?ujIRatwgJTG5LdbGl7zK7Nt8/z/lgolUMUmR9bdL6o52Q1DJI4bYgwq2VW8n?=
 =?us-ascii?Q?Xliqqs534Rt2RI6KlzKPuKaVD8Ajj+DbMLVgOK+cvwoqcjJ1XMKRXvxe2FlC?=
 =?us-ascii?Q?UNs1h3tYwd0EGs0EVU03GqTnbu0x++obuVqnjBGHybWicjHO47MAhx+xAEbN?=
 =?us-ascii?Q?yQHytK8mmEz9wWwXhAe8mAXDozpES438a1eYE6ZhbEy9DQfcHVm4YSEFqYcF?=
 =?us-ascii?Q?pNFwKzeNvCPtFxHozj1CNp01s5s/QrCGb17wsw/Rw5rMbl1GRSsczyLBRlh4?=
 =?us-ascii?Q?EG1xNCVvVchxRQys4NgdvJmKvqW/i8NR/GbvGvoDhtbkv3D8fgXRfseVNHI6?=
 =?us-ascii?Q?1vBs3XrGMZmuY6hcmHb+xYhpqcyedR2H+XiS6lfqZ9lskpF5ZND6XAwIHZpb?=
 =?us-ascii?Q?dnH3+pfhx6DPsUZbo/ChD+n9mOSrgkm0Ct6d3myWgdb43hpfv6bWU6eT4AAP?=
 =?us-ascii?Q?wssKq0ZaiT1uBFdxM7RyFRZsFvZ7pTRD2M2RXPUaWlBjrAGDmYqkgJATgTU+?=
 =?us-ascii?Q?Asv3B7HJ+lW5KEWHNRINfiiKssExH110d/8poCLiA8q1ESVVTQcpchkmZLlm?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5TjvicNfGgtsN9jcMmzIj8lYLRyFY+XBRnC1CqG+bb+AWvrG4ntj+7+HOQiOCyOxVi+9DbtnJlp6Nn9dJySd2azqTgLYsVqngpFy957Z9wg1YfMCnQpF9ppdR5aZSZDUDB979CIbc5eJqjRcUN3S4+++iswscztDpgR65jOY5NTN7O9YtvsbZ9ToIvcG3p/1zBWx1F6T6PBqMj8GIJegnx3o+PlESh5oa+C+GHE+W2/TlGh5Bb38suqk+TZFFjjbzid02h7yAQ1fkhyc+I5vV7x4d7R78eJu+Pr6PLQvqsFi+FIHaTONVU3lcNxFMDU20a23lY0XcEBouXkcTYcYKQ8qOIAOObMrZ9dpuxWhktZ422m2A9nqosb0wvqRrx7Bq8MWVu+rCrhvp7XzYek46Ikt/LceQLTFuwSDlinfVprMqbCdsDsB4gZazY5kw3XXt4LiOl+0vuFeJ0pEgqSYlUjxSKzSkBxT3gZhT+ZINOPWC91ecucU0ASDnwOSguOF9PV7RTYP3y2R1bjUolFt15XvblDZBfhpmDGSGf7dS9omaqtce3CFqdmpJ6uEizc0Z1c5Knnaye6Dw8RJ7MJzUg3q03yZrvqnV4d1TDvGM+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77d8876-69b6-433d-77c7-08ddf0a7c5ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:32.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBWM2xUioMlpCa3AYMEi+oZfvrllXZtmsZKLkR0JiE6VuPEGPYXcI9Qih1SEahmJV49QoVR03kJj4M83fzl9OkgtRZ2zmP8/MD7GwH/9z6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100189
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c1de0d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=2q_dOInNKJsfLPmpoRAA:9
X-Proofpoint-ORIG-GUID: rWR3MS3hl-hTvI15kBnc2dabVda0-fAn
X-Proofpoint-GUID: rWR3MS3hl-hTvI15kBnc2dabVda0-fAn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX6HJ8s5CXudJI
 zYr/f2fhPceO6MzOi77utV+CezKZYs7nOJtyYcH0mIBcsR4+sRTYuaF9u3+ufQ8srczGrZw1cZX
 3TqPf2+0yvIoj/fc7vg6/2kfv8/U4DLapuFhllWNjUKshEmyx5iIXXOnjOPM0lX9IDGm9Ly6A7T
 YkPuAAfrfV7Bq6w6jUeP49CDA7pbPOltDTHZdGuiqwVX9/ISCO36c1dfRjPiXmgsRyKzo0qxINl
 O/QMbX8TLaMK8PFx7tUTab5F4vazA8CUPJ9eKQKmHsWon6KIjOaKEJyYBhM9lU82Zv3H21ReKMu
 4Wn/W8DTSkdw7RjxtxvMzcoKyOc4YPMLZ4vXPQaJrJVh4B6Fvn1HoNp6xySeUwQDCjioNL9B1n+
 6zUdqb3x

The devdax driver does nothing special in its f_op->mmap hook, so
straightforwardly update it to use the mmap_prepare hook instead.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/dax/device.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2bb40a6060af..c2181439f925 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -13,8 +13,9 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
-		const char *func)
+static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
+		       unsigned long start, unsigned long end, struct file *file,
+		       const char *func)
 {
 	struct device *dev = &dev_dax->dev;
 	unsigned long mask;
@@ -23,7 +24,7 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		return -ENXIO;
 
 	/* prevent private mappings from being established */
-	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
+	if ((vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, attempted private mapping\n",
 				current->comm, func);
@@ -31,15 +32,15 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	}
 
 	mask = dev_dax->align - 1;
-	if (vma->vm_start & mask || vma->vm_end & mask) {
+	if (start & mask || end & mask) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, unaligned vma (%#lx - %#lx, %#lx)\n",
-				current->comm, func, vma->vm_start, vma->vm_end,
+				current->comm, func, start, end,
 				mask);
 		return -EINVAL;
 	}
 
-	if (!vma_is_dax(vma)) {
+	if (!file_is_dax(file)) {
 		dev_info_ratelimited(dev,
 				"%s: %s: fail, vma is not DAX capable\n",
 				current->comm, func);
@@ -49,6 +50,13 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	return 0;
 }
 
+static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
+		     const char *func)
+{
+	return __check_vma(dev_dax, vma->vm_flags, vma->vm_start, vma->vm_end,
+			   vma->vm_file, func);
+}
+
 /* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
 __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 		unsigned long size)
@@ -285,8 +293,9 @@ static const struct vm_operations_struct dax_vm_ops = {
 	.pagesize = dev_dax_pagesize,
 };
 
-static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
+static int dax_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *filp = desc->file;
 	struct dev_dax *dev_dax = filp->private_data;
 	int rc, id;
 
@@ -297,13 +306,14 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 	 * fault time.
 	 */
 	id = dax_read_lock();
-	rc = check_vma(dev_dax, vma, __func__);
+	rc = __check_vma(dev_dax, desc->vm_flags, desc->start, desc->end, filp,
+			 __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;
 
-	vma->vm_ops = &dax_vm_ops;
-	vm_flags_set(vma, VM_HUGEPAGE);
+	desc->vm_ops = &dax_vm_ops;
+	desc->vm_flags |= VM_HUGEPAGE;
 	return 0;
 }
 
@@ -377,7 +387,7 @@ static const struct file_operations dax_fops = {
 	.open = dax_open,
 	.release = dax_release,
 	.get_unmapped_area = dax_get_unmapped_area,
-	.mmap = dax_mmap,
+	.mmap_prepare = dax_mmap_prepare,
 	.fop_flags = FOP_MMAP_SYNC,
 };
 
-- 
2.51.0


