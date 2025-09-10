Return-Path: <linux-fsdevel+bounces-60840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758EAB521EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BECBA05E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3A3009E3;
	Wed, 10 Sep 2025 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PAxM6SFO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dYkIJSmw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1272EF64C;
	Wed, 10 Sep 2025 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535806; cv=fail; b=bgKw0NLHxpbzitpwaw//F4ACh79NEBWtDfFnI6j+T85F9TlJ6mNHtL3A/+YekMcNoauxWPKnZBjto4peDBi74LNpXkrZoMBZTZhqOGgXVnBeH+r/isNpC9uFgtHYj7QhNSAs37nX8VESMdruQlgpVcDo+0xAKo3Jja+wGpUrEOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535806; c=relaxed/simple;
	bh=i5q4+c+zY/lV4Mh2OKNou8Bg0LyVUwKxrwsb0YIZ20c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBwN+009JGFKFh6k74fp5AvYUb0TDh7wPUcK5IEjpd+CIb+Hwh7Z4Ptwki+U5WNydfeeZpEe326GGE/ofvnhdUW73SXSSe+GzXsjbi3a1XTHpNEHmDH4S5Vlz+yGInCn8XIg6uZxh1CyxmqUOIwdTSe4s+hghWRzNTaQ8QUEaRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PAxM6SFO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dYkIJSmw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfjHn009713;
	Wed, 10 Sep 2025 20:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HmoYH7UtjFIU7mwG50sNABYBbWEke9S7Scd1ARsxMAg=; b=
	PAxM6SFOB/8RCIMMUM7WRilwUforWbdz7KILgpW1AkyRnRevFzzqbsQPeD6PJN5A
	fxMQnNhlDSaHjJH3et5bI9gd9fPQt9dJxBazSo7zHPHnUvOaOzWi2ecMsbJP/1zV
	CXw3fjTXek2kDRAaZmotUlsscCahQY74/IlNtnPEsUbc91yUuDout3od4Ag4C0O6
	HjXCt2vwU+UAoCRoArygjGYR1oXohbxMZn3ZWOjRrPno77ZCnwBSal5eiMYhmtGJ
	jBMwxyRoUR+cPa/MwtbPv+x8Dhon35OgUvciXKi8MTaO1fMmz2YBXLwTT23uMEAF
	bZD8yKr600yHId4JRrBZXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgvy33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AILQCL038766;
	Wed, 10 Sep 2025 20:22:47 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbgtpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1lTFGNXZFrbTflL6ORyVe2q096AjzvOgLWFJJ/Ke3Q8ly5FSD9QJxzlMvDZXmnsRArJqcEj16cgr4/zKBJXLesBonpLcasfOUCp0r/aRr90Rvm9wwAxzUHWbtiZwrxTYicP4XJ/ZP/pITh+K6y5B37zGXoQN1l2km2VaB5GgilRFs+pLXjM5GO8pS/x7pNuh3/M4xjV8FikzWZrnOzPSIVD/6cdHFhj0tqll6xbEiEpIlqrmsHAu3fkokxLFp7ACOcLaTPKcrB6yBv4tBScUu8oaFZ4Tu7AhxfE2H9ccw0/lGCk6m0SXZMBQn8KijkENQUbqzX3oVcuxQb010qRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmoYH7UtjFIU7mwG50sNABYBbWEke9S7Scd1ARsxMAg=;
 b=X9Th1m/SnAGzwfcyqRBQqHVFADHy/9RST4RntfJ+ZqGlNKrPBx9e+9rOhJ9e1pONOsBd/8KgcutODw1gYQuXPW9Jrenb7odqITMoR1dPL8mRg7BIeP/zTFA/UmyCF1fiIFwQvQ4YPWFRmzTYS62/HcOlMJkyDAVPpfDkAELzJvYg6+yms7dS/pUEX6d2Zyg3wyM47xewDWGZxX15o6+jw2lk+CX0NzOFUv/xGi3ec7/kIWnLQVHcgQ+YaSpM324SvMcfsciY2T9bW/75J0eVvp9e5zfJJbU6QB9Q2eO0jmwFmTfT1cMX1qCB7Jy3K3YEFu2fHzVmRHWhy+Lldt/DFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmoYH7UtjFIU7mwG50sNABYBbWEke9S7Scd1ARsxMAg=;
 b=dYkIJSmwbxozQwKstlWPzFghz8xtbThy+Mb/ucd4dz6hNSp8kDuaysP00Y2BkILJTDnfIgkQs5naIrzGPY+7tWIKlNZYj49JmxxFIcan5B3CxcvT3UyBRH8KLXK/eXpH+jwQem51vcpiXsmwcVwhTubtKpU0MKR5R7puZKeIigQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 20:22:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:41 +0000
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
Subject: [PATCH v2 05/16] mm/vma: rename __mmap_prepare() function to avoid confusion
Date: Wed, 10 Sep 2025 21:22:00 +0100
Message-ID: <9c9f9f9eaa7ae48cc585e4789117747d90f15c74.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: ac61e260-936b-4db7-5259-08ddf0a7cb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6Icrwe2boaOTxEgAbAmKu22biysduJ7wtbVo8Fu7q04IVlVxWUCnaNG6y7Q?=
 =?us-ascii?Q?u90RyCqU0UKDaMpzBRiAGR7V7zoGNv/NlNAzp/M7roaV1VL6KFKQzLHD/gSo?=
 =?us-ascii?Q?/bA/QDr69+QeJSw2by+Pp5P/ge1flY2V3xgmeQjrFTBN3I4fyReXMHX8FwKn?=
 =?us-ascii?Q?jKEDHCfk9sAq2YMA5AolagBixhB+J2CQ3WyG2bsPYgZlOiGqKe3B5jNRFna3?=
 =?us-ascii?Q?/vdz5J10WiydItPlkWedUoQRU35a1QbPL/AbTcQvwB1hsVwEFCqN5h1fXJ5s?=
 =?us-ascii?Q?5cj30AY8SFhtPXfbLdbrGyyLXJdRItUMqeKy22VJe4aZUjiObWMT/GUl31La?=
 =?us-ascii?Q?WCU++e6Waw74U7XmKr88GR6H/wrfQfO1ePw9/EGUvujDdVEXXJUa9MrPjs40?=
 =?us-ascii?Q?JMfP3XoYH1OfIIfuBb3aN0jPLpF7IxoqW1UotUmpgH2qXNVcUZZuPNnx4VOQ?=
 =?us-ascii?Q?M7SpcFhydeIEr+VHsCtbybMQ7InjtGANnG55/5jF56wGxI1qeiLEcKZst5Js?=
 =?us-ascii?Q?b2K6ly4kwXsMc6kjjwco+R+uoTyah2exGb4EgSTAt90s3Pr1XP2foJYw3G1b?=
 =?us-ascii?Q?RUmHcP3TmDxbXwPzCM5ynQRaCD6iX3uC/SsAp4UevxWKn4B8AFtDkIRdS7Ve?=
 =?us-ascii?Q?eXelTrnNGtHeO/BxEUz7+wUNmaIHnfJapnNsUKPFBE24Z98BYSluBliGn4TV?=
 =?us-ascii?Q?rloq4HLmRT9bigOIfrnzAVJROHrIuo3vBQbH4aIcO8aQAqWE4BqixDqXW7ED?=
 =?us-ascii?Q?DdhPdDUy01RKOMSKtKPu/NPvgtcvlNXh/0x7Vbg6f5zBne/lc8L0ef689z4c?=
 =?us-ascii?Q?nl0e7UysA7aldDkByg93Hs49JfWNPPXbxunWvPBsvXHMwTOE6n65KLMgsxVM?=
 =?us-ascii?Q?OX1WR/OiyLIa+2A5h0tH8AyQVcuPTM98O1I4QNeKbBzR7EtxRTYoWlnVEhkr?=
 =?us-ascii?Q?OXzgKjwX6icOTr54UnLjZpIRptOHgnzX4ksgcJtQ5JQy1RsJlkt1W1uvqppm?=
 =?us-ascii?Q?rfk/PqHZiGsLTATzgvT97WkF7huS/kD/FQUayeXqJvfh1IS+ANIA6JHlMZPU?=
 =?us-ascii?Q?dJl6t2Y6PsGKjiyINGpLEV4MmE5IvMATyrsB8ml8Oz1qDq9YuM+vlBHUPdAa?=
 =?us-ascii?Q?dZPx9jIPD2lyIWlZVKGrHy0m3wDMD75Wmhft3EhPxxEHEgRL7tbJ+/xgd9Rz?=
 =?us-ascii?Q?8MuSfc9eAwR//Z0Pkf4QZHTQWiWm8pikOXz+vzNkj4p4OJ7in+akKvhWeZaN?=
 =?us-ascii?Q?6F8wMbqPXWkL/A9SqnpfeflBdB6RXvLa86TLmNEG2OW7aivBx2eqT/ONeDtA?=
 =?us-ascii?Q?Wdh1q7+wu9oEpLQyV5LHimAoMO8n2ITTFv1cqWahaSrErECjLtYWv0/0ImVB?=
 =?us-ascii?Q?zVGbBzy0GbPnyisnxTIfcXNzOJInPEZWW78S2ok9x10GMmS6nFL+x/CexL91?=
 =?us-ascii?Q?0XSbv5I05WM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uMTSWBBJXnxCYHpYtjT0F2a8+kTx7Wf8Kzu64TQgPR922fOAdVWF0G6LI8ph?=
 =?us-ascii?Q?+yTcVaKbMZkZeJqfu98SwDb2Io/NRE20SIBD+V6TzX3c3MpdtW8wLEoUE+P0?=
 =?us-ascii?Q?owNZGpg09pMdmQtYCBlirigpWwn/WF7uFnj/9LRYo15sEvSMByFzSOn2C9+2?=
 =?us-ascii?Q?igVy2+JhK4n8r4UohMlfdmr97xH/hI6yEklyyjViJ4u7yRNH4LGiTKy1/dtc?=
 =?us-ascii?Q?NFtWs8LPhKpPh5gcXSA+0k5k1lyAerRGysalvSrjeRurqwxlJKgXr4ekayhw?=
 =?us-ascii?Q?18i5/3ncNqc2jo5Ij1GThvwvs6i8EKsoVn5pY7NHcgdD8WWejafROe1LrOk8?=
 =?us-ascii?Q?HlPw4ZuNUd8gEannN+BvoTsVO1u0wQX/eb2ZKkNpNaD3XqJ/irlutxjIE8nx?=
 =?us-ascii?Q?NWqcdfmf7IHgbplh/mPDCKsIRHHg97Jp/NPAqJ/+hpYywTsBLFCs/WoZ+sf2?=
 =?us-ascii?Q?EuJzY+/tcjRbUxJilKa/TgGNYxxDhKm1kl9t2nGEh8jx93UodPFOS6ZH4E5R?=
 =?us-ascii?Q?HTmmX2xDNpkvSwjV+Hvc/4ZLsPDB+XKcWiTcMMQXsnoXEpA0IdkCHXlGbIuj?=
 =?us-ascii?Q?fJh9tPCih43gMNqD1wtkG+Cj6DtPJYx6389EvPKS5F3rQrrg7wTz2HqS6XNa?=
 =?us-ascii?Q?JL4rBBzTaiIN5CWkGZKFlhkB/HlWLvDGYn30ldvUIL1ZdQx2+QdSJva0SxbS?=
 =?us-ascii?Q?I1KIHvy1u7lRNo9PQDRL61Ag/qA4rNULNpcCIDuves32AKJhWpqK2bXJmpzA?=
 =?us-ascii?Q?X4c/0UelFkMGyiOwo6Vd1LFB6SkzpZu69GdBiYM3Tt2IWqbRDMLaXSOcNIGb?=
 =?us-ascii?Q?emFRfWwMhNYRuAAt3xvs4nIuVcMC98F8BYuWVWaj3rU1VVuwP2D1q+iSbsDG?=
 =?us-ascii?Q?Nn8bpxjSnGbDHvkw+61/sIY3ieITKC8KWPVz05p7ms+5w4t0zdxO+Djf3MUi?=
 =?us-ascii?Q?2kRUO4LESWP0VxOXKzvAWa0CaElJBd0AbDjOwJxtQrkqHnS8Clk+Bf61QdW3?=
 =?us-ascii?Q?/ntLJSeu4ykLthN5YRSUnTSTkDovchjgT2cI8EwJQsmrOodp6HuWr8uqeMsq?=
 =?us-ascii?Q?Ew+mBTwsu7ViLntWQ80ywGFIUGoP94QbXkt8w+B4i0nhkcB/uBngxiCsYN9Y?=
 =?us-ascii?Q?ZSVM1UuttHra8gNUGcuzRJ7YCLNnGciW2FJmjv/e3L0XWRnG0pSuNuIFQVuI?=
 =?us-ascii?Q?c9s+IPt66k7hshIA7V4jg5aY5IzI4QJlc8GN4i+3bLK86PSyWjU5YxUDLZza?=
 =?us-ascii?Q?J1e4MPSf8duw3+GsyJIrm7CScb/Pjicj5KBrKulr65IVCksllxJOCQXxnb6a?=
 =?us-ascii?Q?swAx3HoSAVjn3vcLwNEOa6EMTY9w4Jt5/8y7uhWwpNpnCXrGeD/RiA8qvnVv?=
 =?us-ascii?Q?25hBuzl1d78Tp6yNIkQAjpTnd3K9i+b2Xoe14rW6LZjxz1BNP9R3kf4xn5tN?=
 =?us-ascii?Q?EAXJym7prGK/IVQ/a78b4LKATGl6O4Eds/ObxzX/zRaUkmByIcJA564m2Xpg?=
 =?us-ascii?Q?NeIrWNo3RUOxMHlkkHjQwQMECC/b7TLkEc+kUxOEvh00jWcpTnaTvShc6IVj?=
 =?us-ascii?Q?h1Fp2/zP82TpYpxhVVg+DMd1Az2xAeSPvIedjkOxMgOP/yJrDdzz1Q8ONLJ4?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZeXLEffZPZT8E34kjWumrvE6UiORoXjcnQjkGY7MOuUJJgk9MqTeP2CpDabh+dDKIPtYFpW7VbzqRd6aYv7Jn7qZ30REzW4s9nbZJJQPu9nM0mJ3uEx30LuOh+LrSHHLb+IuuceW76p1N/zO7J4N1wg4C9fpbgl0VdzL/ONHRBxicoqbD1I1dpWxYOKbn1ujjKswFamIUJn1PMSTLK52pyv1Rnp7GDkGexuX0KMocg4kPOGRewlGxUSe/6SBQFJ1CAYhHxiCtX3MTdcEPse4VccuRC98NlTsSsvJvR9sUZU9EfcFmhVo8V/O1M5nADR/gkV251XefZcHZobAJZ//7itk5kogYe9fCKQs1gY4beldxKo8Qzo+WGAc37cWo/jkJ4/xkhPlKReczLaaUqMuUqKKidJdZQZrqZhFaZBNceoGDysIGWbPeKcWuPWPZfAyFAe6WvjsI0wp+UMC6ON2GlzOedcEeWZOsl/E35Jd9JEaUm8hPBOsE/+9qK5+CwqSl0WAi83retA/ukDBKDxyinFienvNwUKHJK+8xL6baz0evZoPcnizhAaZRN5md3nJkl+eEcrzJ8lcmFqaNLdn3poHcyGRRhWFjspT7iT6fvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac61e260-936b-4db7-5259-08ddf0a7cb31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:41.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRc+Thtjbz3QHdTeWUqb9MCOVdV0bLzzSVCF4jX5ZSC/A/GUxDDRoJzx8vqbR9T7aQtcURr2VGIUZ5h9HqQ9FvudMpiD23EfjYjThL4wMqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100189
X-Proofpoint-ORIG-GUID: 7FItodJgzAfiVy7vvOjF8qEIDObzNs2D
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c1de18 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=9WrioahaYVwPZVrL5YIA:9 cc=ntf
 awl=host:12083
X-Proofpoint-GUID: 7FItodJgzAfiVy7vvOjF8qEIDObzNs2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX6jXtVwR+YrKG
 XS1wmBVZcRHfUONBC9yeVTn+ZYT7iLhRu1rSq1/SNvNtw0HzDtWK+rFDlvwvdhLxb6e/+kgXOza
 3kCqOl/5nrK/6+30L/icChkful+lBwdu84ApccWjyWcJLIqJMQwnDBWBI6CEKQE/3T5ukvGZfh5
 n0qDVuHu68O+Gtw1z+Gw08S7oQ5nOTdhktgdQDeNkGLKsxMP65ZYilBxUxhIGtCXbGmZD9JsX5y
 rrpn3BREu6EWLCr3u9K6/Db8gfTsjgz0j6MOvNkP5DmogLQlvL4ntHDLrBiKYXAKAOzJs8p222I
 avRbvgyD4OCHd1STQYpxIkmeFTC72bsq4c03Gm18ZDyxz3dFCTF2eFECAJHsn8Mkgo4B1jbktIg
 uECItm/z+A57Z4zRlty9ulC802Seew==

Now we have the f_op->mmap_prepare() hook, having a static function called
__mmap_prepare() that has nothing to do with it is confusing, so rename the
function to __mmap_setup().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index abe0da33c844..36a9f4d453be 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2329,7 +2329,7 @@ static void update_ksm_flags(struct mmap_state *map)
 }
 
 /*
- * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ * __mmap_setup() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
@@ -2338,7 +2338,7 @@ static void update_ksm_flags(struct mmap_state *map)
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
+static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2649,7 +2649,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_prepare(&map, uf);
+	error = __mmap_setup(&map, uf);
 	if (!error && have_mmap_prepare)
 		error = call_mmap_prepare(&map);
 	if (error)
@@ -2679,7 +2679,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
-	/* Accounting was done by __mmap_prepare(). */
+	/* Accounting was done by __mmap_setup(). */
 unacct_error:
 	if (map.charged)
 		vm_unacct_memory(map.charged);
-- 
2.51.0


