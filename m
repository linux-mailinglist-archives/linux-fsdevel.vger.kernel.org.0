Return-Path: <linux-fsdevel+bounces-75100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDLwAuhPcmnpfAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:27:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF5B69EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3C243000E27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA63A5C19;
	Thu, 22 Jan 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Puje73OD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ClVVpCS/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2683A2AE9;
	Thu, 22 Jan 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098138; cv=fail; b=iKI8Kw/OejemFQUBi349ct6E6t1R+7rVOJyPd3t5cSMuge8joHOniwOr8jlp96xZjgUm4FHlX51VSCL7b0u+/HafJLx8/BRUWeK558ujrozYKQ8F7KKbycWfEPL+mbfbslz2rpXdDhKjTlta1pby97WGKb/OWFtC04rPfrdD0Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098138; c=relaxed/simple;
	bh=ox19yeKqMs72KU9JP9P460DJbev0YTIoNGQR6/iyLsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1lgYYfCWGDacgdegPB4MgnWJNf8LTDULxM/Fv7Xnrrr38egG1xlpIe6s3Y8xngsyvaeqPX4PmqMMcggLFD+pjYQVm7cURGsjS8zIO6DJsFrlqyVATw+5PlUWucWhBk5aXSfeH+fy1/DTZsmSJ7g4M22/yYtpcSOpdMW9Vnk1v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Puje73OD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ClVVpCS/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgN2J248898;
	Thu, 22 Jan 2026 16:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F7dZSBuMD2wW6ot0+KvmUwjFeYZ2MV6+yS2S8pGAI2g=; b=
	Puje73ODkMkmTCZRj1/I/q5ir6HqgIsRV0+NVypkmFSRRreCTRkoTrMTFlW6Bijc
	zIi5r1JV1bYrFRT1Y1oL/5qqBfWBCwfnRQvMN/1QZYNyC+ExZpybiASoyqvss0cw
	0o1K3p+ZFqKZp3dBo/fgFVDZudvgv9c8wi6DnkojfV27GaH4o4hTqwCEo5lqSsoe
	2doEXh2BmYQNUzpoIpSCfuAPU6D+oj3QitUZe5sbyadugmlU9Di/vH7tlfY5Cd4M
	WdwfR40rxN5/hAYvS78KhNShGOpY34SkZkgnLgCzPfTdSRWgh0SrQgOgHPLQNJQ/
	yo+0XbWHGD7kmxz6do2Amw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10w000v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:07:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEgcCV032257;
	Thu, 22 Jan 2026 16:06:59 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgusre-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8+3r1R6ABFw4LSsqdFv/NuhInCZJpQJC034Kki5LGSzbDHJvs61C1wZDRwc4awnY4SuHuNnua2IXDEAGTrN+zbblfRHzt97OA3bMK4dt5gwss7CeqDh5cWZDq3MLIK8UyLMHwOek6IdKsdaAOBgPoQPjVdXWww+5xhqsIboF2AQzB+u7V0o4lRiwJHN8sDV5GBiIP8p7D/0uSuLO2VXPYOuOLcciipLWyAkALhbEyds/IBb4qZ/NvILgGwWrAGaTCWRBLSxZwPnMnh3Vmo8wZIKixgB/FpscP55omW3hBe0bbABmlyGwQnxwsSq2Nh//LRF4wrd49MnylO/3NlPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7dZSBuMD2wW6ot0+KvmUwjFeYZ2MV6+yS2S8pGAI2g=;
 b=yPvolAqRirhznGpBI/YDNS2MxOP2S0jfuybA5Ilc22AphJKKGmPmbSeqvpJgLXE9uelwOICS4gBg3aQ/T6ErIOrHb0qL1VWwKwo1Jb4jyMUHPg3V3vHpuIDsUB+fWPzrW4VJHh8N6K0MehSX0HvKT+hLTuFStOVx7MUuiu2AL4SGEkZAjmB3x8vykbB5OPTwWa/GN3ED15IZTZdvc5dV0DHwPON+yQb0GzUOLsUotmnOGz/oIUclk/TQV3OpQLyEsr/UXB78cCztWiky41qnoETJnrYzmjfGlyb+aw7fuDC0KmvfX9c78h3Ws2SGjXtfLr151szWGFmpQ+0DYure1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7dZSBuMD2wW6ot0+KvmUwjFeYZ2MV6+yS2S8pGAI2g=;
 b=ClVVpCS/L/Lx/Sn6gWr3huNja+HPJi1dhndhZ0mbgpK1zwe8OszE2GW4vfnCn5nv8ArkNrkxSLYVrb45ZClZQPFzPQyQBhfIY81jHCpHpjhjpex7rx4JZQD95GzEmuhZPs1Qn4Qi7jDRgrUNY2gqxPXtuGzx0IB3iiJRI/oWq+E=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:06:51 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 12/13] tools/testing/vma: separate out vma_internal.h into logical headers
Date: Thu, 22 Jan 2026 16:06:21 +0000
Message-ID: <dd57baf5b5986cb96a167150ac712cbe804b63ee.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 2849b9e3-09b2-4ffa-ad6d-08de59d03faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BDXrZ8HvmZsnmhHsP6aZu2k0lb3yZ/jnE19/XVCLzL8XmiU7GeW21oSP6JVF?=
 =?us-ascii?Q?qntVdTCtRjvBEqM8UFfdIUoV9kxwsayDSrDjzthwBurqg6drHji6aerJjcMV?=
 =?us-ascii?Q?H7d8aU1jGQwdGnHdkh2jRNUcAq6YdcOCOwoHnqlN8Nf7IBYvAkLnKjfHIQ0s?=
 =?us-ascii?Q?i43rj6FOSrtDeKtIuTNl14BK1Xt3bdwDGQlgeiEAoWuh0+Sel+5THKWAUYaP?=
 =?us-ascii?Q?zGs5oAZi1eoJPf6jI7ceM5rY+zRd0COAhU9wxj73SNnYLDLdaQFobY1b+n59?=
 =?us-ascii?Q?ysToSp/qSVtaVLzVVsTH3jfpnOxlBtVn+crhtWhwYAWsOi8W5q5Y71LNTy5x?=
 =?us-ascii?Q?d6jJTB8ja88UDRqkbs4TbA3Fk40JRSH2heRHgaBRmbXOr9n2cT0Joc6Oif6Y?=
 =?us-ascii?Q?fa+oCk6siNGmTTimJLMXJPWNSZfKExQQisVNFHKw6o/qHeEhNj7r39iC08Aj?=
 =?us-ascii?Q?oTIrQk1hGrlCvn77CbGLkdzREe63+GLclFn7pEiTFwH/7lIopBoRyw3M5vsB?=
 =?us-ascii?Q?MmXc/Z3GjzChcMoLfCZfRP0dWc6MiU9zwjKPLZDlSCAWubP7gQ5lwMAbOg9I?=
 =?us-ascii?Q?DA7dYbCeXp6ioDeoxgisYrKSr3jJRC8ax1dnfEFONfFdbRrbEnZz30dDOfli?=
 =?us-ascii?Q?3uG1DcMHDlDwOEuiUtj//teCbGJzaJpimXx9qtSmqQ7OAjkF7BrLTT+EGVs4?=
 =?us-ascii?Q?l4InCXdVfGAUTY2zl8uOrY6N2TsJnSrzkpuH9Dp0knUMXPrJclUe+IBg6pzp?=
 =?us-ascii?Q?ZW6eBlXMl7a6KTP5yH2YR2xrBQsEk919rAFA8vX3gMWEy4lruKVS2hgtnd8p?=
 =?us-ascii?Q?ExSEWaLZIyvOAmTO3v9tHIDPRk8k+Pq3s7KVY6bDJqwo4BG5fF5XJLhEHB/R?=
 =?us-ascii?Q?x8scR4nGGsaoqC6Av0Vs37IUB/aS4Gh90kf85fdiKI5/17Aa0yPux3UUFVei?=
 =?us-ascii?Q?pVmjsnWXMiTbzIDFxGlbMPoiMYO6pcAHWHysie6edxoJXBAVl6NmCxvdHMZo?=
 =?us-ascii?Q?mr9DL8LzlxXghTUTMmALy9mD5GnpRaCtbFRljMUuvn/fbEnjq72PkL4ouUYE?=
 =?us-ascii?Q?9k0zZ7yNgxVbCKna/h8tLucBeoZQB3s+N9Mb4GE0wqUUsyrZEnQwzhiDR1CD?=
 =?us-ascii?Q?gxyu0i2DU17XAmulYUITVSKpRizX9hXB1TDnjd+SY5dQd4wsC4NXrEOiDmdV?=
 =?us-ascii?Q?edOrSyvJZA4iD/I0XczESCWLye0f29CpHi0sOrO21MQBqM9mJBj688qRAy9D?=
 =?us-ascii?Q?O6vnTJb5EMjIvxjtKFvgvJtdfYt2SLZOBMwJDB71n/WzEpegUBmZB/MLBco3?=
 =?us-ascii?Q?u4IfRAd48sqWIDmbL/1ApF0CN88sXPkpDGpuBqYvHml/1tXHCgGokpm+ju/G?=
 =?us-ascii?Q?+XViUCdbU5c/SBj0uppB4oM8QjpQ7g/uQTs6rFWj8whgQTgD0t+m9oY3F8mM?=
 =?us-ascii?Q?lOoKrkAifQ01XM4JzOE1fl1uxsA9XQM0ACjKaaW1iAnCiwUXfNDvJ/35DXkV?=
 =?us-ascii?Q?VOfHhREhkFypYaJ2FTtV1rub7L7wQNQYtvPEoCqlqhuw5DpZ3MHiz+BnZAcf?=
 =?us-ascii?Q?zSG9FlSGjvLCbhvCNuA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kpzQ33axwwJDn+FrY6DAac3cYVbpR3ePGsWpSY6LWI0tBDj0/2lIoK+c5iqJ?=
 =?us-ascii?Q?f7WiCIyt0mkyCHXjn+jsX8kDQHzOWb+d/tSxhK1Xh/h81uwBy4+JWw6+lw7a?=
 =?us-ascii?Q?uZsmN/EqpOJ8p2JpGIyYmIb/D00AHz/DKSrUholLeJU047tuerT8Qj/a27ml?=
 =?us-ascii?Q?ziV8g8bCF/hZprfXOT56kDhGyqfMf/LI7PhCjA18isUw4Ba+WH+WqWcMQjeR?=
 =?us-ascii?Q?u+VBL63+pZLJitRXCe7v62HHqBbmx487nV8KYLu86RSgU0k14h7wAJ+B7Gwk?=
 =?us-ascii?Q?O8UwhKrceIdMcqJ9ngTvCtZ3u17qPdcm5vtyC44oeBmkl58O2189DdUKiK/x?=
 =?us-ascii?Q?ONuSN3e0L1TutIAVeTkNhJBRF3n0FRNB9gV0rdoiqutSw3DiGjk+r/t4iB3D?=
 =?us-ascii?Q?8+UvTA3KRK3mAQsxvcAr0WjeJMhTfwy5Bchpy3CEa0cl5XEk6GEg0ChOZtyw?=
 =?us-ascii?Q?1mUUspI4506C6OSHmucXOCjYKClKu4BChAsLDP1r9G0C+RBrNOx0nofJ60gw?=
 =?us-ascii?Q?EopFsUT/BtmV2ijVq9jC5im/MlpdRZ3ux8gVEGmak5JiV0bqDxYC9VsyMsTp?=
 =?us-ascii?Q?X5bv7pL505OXnx43ggC/pepKJ0aWL84XgrWb/U9M1SDWIlrcjWP43g4sYgdG?=
 =?us-ascii?Q?3uNWACBLk9D1v2D8/rkttE/1H0kMneqJ5MYgOEGVj/WHftcCr11hmAyVNWEP?=
 =?us-ascii?Q?jvfkKJa6THlmcBwV35bbUCFprR2SqJElEPl9uWxzhu9yVuKraZ+aOOo47Rtm?=
 =?us-ascii?Q?9dczhxd+1YbmkcrKmq4dvHefsyHFQ5OI+UDtExyDh4BzZsDMUJJ204CJ1Mb3?=
 =?us-ascii?Q?jBVGi5w49OZdBSz4tozShyIaDmYlhkVcltWL12ZCvN8B+wKHEEIwq6LqlYCS?=
 =?us-ascii?Q?E4viDHAJPgxQaXpcVBdLs46oefXgivLGIj1ZwCC0w2haU22yS47T6TT3WTyT?=
 =?us-ascii?Q?OkPjikhHWInqLtgwQVbflrVXdmt2zfmiWpxc1m/AVaQS0JxwWoIqCEiteJhQ?=
 =?us-ascii?Q?4JqOcf8HVasVDlcobvwxkT+26QHtKZS6OeCU4DSBwNSlHocQyFHOVBh9MYza?=
 =?us-ascii?Q?m0hDT2PVZv9lc0Eayy+rEw8074QMa1/4k+D37QQ9xkeHXH+q71VS0kexx2Bn?=
 =?us-ascii?Q?8H93gnvRtikuWszeZj4kdaB3gDgZwhoRgfIV0Wxz8+Z+3uCIkQGOVelcPqr8?=
 =?us-ascii?Q?Harw8P1+LT5F45yzwg2zUzBcsE6QyUijhv1mqghWjlLAYLMNdACXXAdRmx7I?=
 =?us-ascii?Q?Gc/g0S/0M9DXWN3ASdTHYhTFj5Vpg7rvszf9XvYYv3NUfWWmnQsxLqUYP+2K?=
 =?us-ascii?Q?nBd+7fIzVH8YMRVbP8PH6XqfZ/mByOlUGKSNN1pc2+Erlgv4gkZlc/hJg7o8?=
 =?us-ascii?Q?ydJbf4+xS3vr+3ceLknhGU+qz3KcyPeW/oxE7e78ejKNGrteWNm5qtOXRtRp?=
 =?us-ascii?Q?bK/RTbm6OZT3rnf6T+HmjowM1rO0ILQrV2CsB0OQ8HA207EAoU32NKdS0aSO?=
 =?us-ascii?Q?1aA64gFO66fIaojqv/l8aY9eM2U04kxst47mO5TiWL2IRzz8NoSCAqnNcWaQ?=
 =?us-ascii?Q?heNw3ciay6nAu6OM0cAnupWMrrUItxGFCd9y/NJgWLFuss2IJiBmhq9t4C+I?=
 =?us-ascii?Q?JkhDBQr1pZBfd0ekSqlWQKV75O7L7UOR3qh0HhMY8c+L0onwIeqkShS9X7bV?=
 =?us-ascii?Q?CfqmEay4wDf8jOHXRp8zrkESLGlaMvFPPZOutCsQIk1wVu0j/9swtKFQLZ3g?=
 =?us-ascii?Q?u2HjjqBSk9iyc0K9ihyz5SVnfzBeRBc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i6TKCURMXivXbr/TXREyFvP3DA6ByOdaTRLt3G4UBP92F4z7r6XDujETBzRxIFlLN1sdhS/cFv6XM4c2LAiLfZU221COeLPJz+2czjf3nFR4Ny5085uR7uX2u8UrDeHbXRkq6FJ9rsaFNzUUN8qqO6n7RMVKeUl6lGcd85NeUsgD4VR+NtwthqBtSPjSThRhO89t4/Yl2G/uPWG86wlX/l3u/QeYLYd5M73KZowSgU6kpUcyF8qKxIBMqZRw+RZAoDNzSwIi3EHkM3lgzv38zJ/gvdMcGHO3cutVppzB3pw45Tx0rAR4Ap7u6gNhwVWg2McTXjgWVoUVCVxlbKjMu8yXgdfjjlwx1KAVWrLhSQal3KgihNOSAGQTx8jIk9FM8wCk9CbvxyD/st03FZDZXSbe4RaDMKKJVQB2cIbpFZVWRMQwH3ELuDx8eHaOi7e7LXvimPU0JnB/ent9OdVpwLmAxeLuitf9EmiTdOfxosiXyv2ZR6+GhA997ksED0anV2a4Uliv9NdMoxPCJyKwaCTw09vn3l6f4vFbFRJ1PHpyQWg8/TbY7M3ss8cTxLneLwGkgzlFlPddRJqcU3mWnO/8GI6d9S3D/c5QsLeAxdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2849b9e3-09b2-4ffa-ad6d-08de59d03faf
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:49.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/5zyrF4Ns0wrjPEmIiahM7eLS/ogNLUfD5whHyI3hVtqjNbzg2GeZ385upZ1EGrPTFWkMTZzEvR2FrVo1P1ujYUh9FEZ0ZzJaDACfu6I3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=69724b25 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=zkH1Es5Rtyo6r0KHzlAA:9 a=zhoj8-HIGWkN-1eD:21 cc=ntf awl=host:13644
X-Proofpoint-GUID: jjMD4oG5aCkOhw6HihW4db8IVn_pSjbq
X-Proofpoint-ORIG-GUID: jjMD4oG5aCkOhw6HihW4db8IVn_pSjbq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX+d3g+JviSFAc
 2Nzb72NahVQ8fN4+nms7qO7gZ63zKLbEpD7whl4v4+vjf/oxlG9sdBdsF5weBd+7luB0LrmG3/3
 KpR9QgHEQsN3o751bmGO3REO1ToD0Huyx8Xrh5jl2MmCrQWZMNCBoUyyIZzbCg3+ZreQ//VJeJV
 aoOXzUjnJeD1n6xw92KsoI6AIfF8FHDi+OVzwKAQCcysokhZHpb46TSUc/Md8L5KNPgefNWYVd6
 4+xn1RML91qhxhohy9DqNvO61z6RBNhauKPEPZNRFdlLPW/cCgCtXTfJawiDI6hKpjWk9SLACUz
 EsVlrQgkPMwOsDy3ZeYQ2ql/F6wwMjrzk3yKbI4uN3G01LoHfkWv9T+XlM5A1RD+RvY86/P4hdz
 c74NhlUcnjUTf6DWIPde1qH/ZHaIilfJe7NrAGkWxadgW8hQnmfbpx0aeKW0ZtFUlj2kaOfaU58
 m5DMSEUG66toSrxwI+G+2BkfLLYxxXCchsVX7K4w=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75100-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2FF5B69EA8
X-Rspamd-Action: no action

The vma_internal.h file is becoming entirely unmanageable. It combines
duplicated kernel implementation logic that needs to be kept in-sync with
the kernel, stubbed out declarations that we simply ignore for testing
purposes and custom logic added to aid testing.

If we separate each of the three things into separate headers it makes
things far more manageable, so do so:

* include/stubs.h  contains the stubbed declarations,
* include/dup.h    contains the duplicated kernel declarations, and
* include/custom.h contains declarations customised for testing.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/Makefile         |    2 +-
 tools/testing/vma/include/custom.h |  103 ++
 tools/testing/vma/include/dup.h    | 1341 +++++++++++++++++++
 tools/testing/vma/include/stubs.h  |  428 ++++++
 tools/testing/vma/vma_internal.h   | 1936 +---------------------------
 5 files changed, 1885 insertions(+), 1925 deletions(-)
 create mode 100644 tools/testing/vma/include/custom.h
 create mode 100644 tools/testing/vma/include/dup.h
 create mode 100644 tools/testing/vma/include/stubs.h

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 94133d9d3955..50aa4301b3a6 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -9,7 +9,7 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) main.o shared.o maple-shim.o
 TARGETS = vma
 
-main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h
+main.o: main.c shared.c shared.h vma_internal.h tests/merge.c tests/mmap.c tests/vma.c ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma_exec.c ../../../mm/vma.h include/custom.h include/dup.h include/stubs.h
 
 vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
diff --git a/tools/testing/vma/include/custom.h b/tools/testing/vma/include/custom.h
new file mode 100644
index 000000000000..f567127efba9
--- /dev/null
+++ b/tools/testing/vma/include/custom.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#pragma once
+
+/*
+ * Contains declarations that exist in the kernel which have been CUSTOMISED for
+ * testing purposes to faciliate userland VMA testing.
+ */
+
+#ifdef CONFIG_MMU
+extern unsigned long mmap_min_addr;
+extern unsigned long dac_mmap_min_addr;
+#else
+#define mmap_min_addr		0UL
+#define dac_mmap_min_addr	0UL
+#endif
+
+#define VM_WARN_ON(_expr) (WARN_ON(_expr))
+#define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
+#define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
+#define VM_BUG_ON(_expr) (BUG_ON(_expr))
+#define VM_BUG_ON_VMA(_expr, _vma) (BUG_ON(_expr))
+
+/* We hardcode this for now. */
+#define sysctl_max_map_count 0x1000000UL
+
+#define TASK_SIZE ((1ul << 47)-PAGE_SIZE)
+
+/*
+ * The shared stubs do not implement this, it amounts to an fprintf(STDERR,...)
+ * either way :)
+ */
+#define pr_warn_once pr_err
+
+#define pgtable_supports_soft_dirty() 1
+
+struct anon_vma {
+	struct anon_vma *root;
+	struct rb_root_cached rb_root;
+
+	/* Test fields. */
+	bool was_cloned;
+	bool was_unlinked;
+};
+
+static inline void unlink_anon_vmas(struct vm_area_struct *vma)
+{
+	/* For testing purposes, indicate that the anon_vma was unlinked. */
+	vma->anon_vma->was_unlinked = true;
+}
+
+static inline void vma_start_write(struct vm_area_struct *vma)
+{
+	/* Used to indicate to tests that a write operation has begun. */
+	vma->vm_lock_seq++;
+}
+
+static inline __must_check
+int vma_start_write_killable(struct vm_area_struct *vma)
+{
+	/* Used to indicate to tests that a write operation has begun. */
+	vma->vm_lock_seq++;
+	return 0;
+}
+
+static inline int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src,
+				 enum vma_operation operation)
+{
+	/* For testing purposes. We indicate that an anon_vma has been cloned. */
+	if (src->anon_vma != NULL) {
+		dst->anon_vma = src->anon_vma;
+		dst->anon_vma->was_cloned = true;
+	}
+
+	return 0;
+}
+
+static inline int __anon_vma_prepare(struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = calloc(1, sizeof(struct anon_vma));
+
+	if (!anon_vma)
+		return -ENOMEM;
+
+	anon_vma->root = anon_vma;
+	vma->anon_vma = anon_vma;
+
+	return 0;
+}
+
+static inline int anon_vma_prepare(struct vm_area_struct *vma)
+{
+	if (likely(vma->anon_vma))
+		return 0;
+
+	return __anon_vma_prepare(vma);
+}
+
+static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
+{
+	if (reset_refcnt)
+		refcount_set(&vma->vm_refcnt, 0);
+}
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
new file mode 100644
index 000000000000..ed8708afb7af
--- /dev/null
+++ b/tools/testing/vma/include/dup.h
@@ -0,0 +1,1341 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#pragma once
+
+/* Forward declarations to avoid header cycle. */
+struct vm_area_struct;
+static inline void vma_start_write(struct vm_area_struct *vma);
+
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+extern unsigned long stack_guard_gap;
+extern const struct vm_operations_struct vma_dummy_vm_ops;
+extern unsigned long rlimit(unsigned int limit);
+struct task_struct *get_current(void);
+
+#define MMF_HAS_MDWE	28
+#define current get_current()
+
+/*
+ * Define the task command name length as enum, then it can be visible to
+ * BPF programs.
+ */
+enum {
+	TASK_COMM_LEN = 16,
+};
+
+/* PARTIALLY implemented types. */
+struct mm_struct {
+	struct maple_tree mm_mt;
+	int map_count;			/* number of VMAs */
+	unsigned long total_vm;	   /* Total pages mapped */
+	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
+	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
+	unsigned long stack_vm;	   /* VM_STACK */
+
+	unsigned long def_flags;
+
+	mm_flags_t flags; /* Must use mm_flags_* helpers to access */
+};
+struct address_space {
+	struct rb_root_cached	i_mmap;
+	unsigned long		flags;
+	atomic_t		i_mmap_writable;
+};
+struct file_operations {
+	int (*mmap)(struct file *, struct vm_area_struct *);
+	int (*mmap_prepare)(struct vm_area_desc *);
+};
+struct file {
+	struct address_space	*f_mapping;
+	const struct file_operations	*f_op;
+};
+struct anon_vma_chain {
+	struct anon_vma *anon_vma;
+	struct list_head same_vma;
+};
+struct task_struct {
+	char comm[TASK_COMM_LEN];
+	pid_t pid;
+	struct mm_struct *mm;
+
+	/* Used for emulating ABI behavior of previous Linux versions: */
+	unsigned int			personality;
+};
+
+struct kref {
+	refcount_t refcount;
+};
+
+struct anon_vma_name {
+	struct kref kref;
+	/* The name needs to be at the end because it is dynamically sized. */
+	char name[];
+};
+
+/*
+ * Contains declarations that are DUPLICATED from kernel source in order to
+ * faciliate userland VMA testing.
+ *
+ * These must be kept in sync with kernel source.
+ */
+
+#define VMA_LOCK_OFFSET	0x40000000
+
+typedef struct { unsigned long v; } freeptr_t;
+
+#define VM_NONE		0x00000000
+
+typedef int __bitwise vma_flag_t;
+
+#define ACCESS_PRIVATE(p, member) ((p)->member)
+
+#define DECLARE_VMA_BIT(name, bitnum) \
+	VMA_ ## name ## _BIT = ((__force vma_flag_t)bitnum)
+#define DECLARE_VMA_BIT_ALIAS(name, aliased) \
+	VMA_ ## name ## _BIT = VMA_ ## aliased ## _BIT
+enum {
+	DECLARE_VMA_BIT(READ, 0),
+	DECLARE_VMA_BIT(WRITE, 1),
+	DECLARE_VMA_BIT(EXEC, 2),
+	DECLARE_VMA_BIT(SHARED, 3),
+	/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
+	DECLARE_VMA_BIT(MAYREAD, 4),	/* limits for mprotect() etc. */
+	DECLARE_VMA_BIT(MAYWRITE, 5),
+	DECLARE_VMA_BIT(MAYEXEC, 6),
+	DECLARE_VMA_BIT(MAYSHARE, 7),
+	DECLARE_VMA_BIT(GROWSDOWN, 8),	/* general info on the segment */
+#ifdef CONFIG_MMU
+	DECLARE_VMA_BIT(UFFD_MISSING, 9),/* missing pages tracking */
+#else
+	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+	DECLARE_VMA_BIT(MAYOVERLAY, 9),
+#endif /* CONFIG_MMU */
+	/* Page-ranges managed without "struct page", just pure PFN */
+	DECLARE_VMA_BIT(PFNMAP, 10),
+	DECLARE_VMA_BIT(MAYBE_GUARD, 11),
+	DECLARE_VMA_BIT(UFFD_WP, 12),	/* wrprotect pages tracking */
+	DECLARE_VMA_BIT(LOCKED, 13),
+	DECLARE_VMA_BIT(IO, 14),	/* Memory mapped I/O or similar */
+	DECLARE_VMA_BIT(SEQ_READ, 15),	/* App will access data sequentially */
+	DECLARE_VMA_BIT(RAND_READ, 16),	/* App will not benefit from clustered reads */
+	DECLARE_VMA_BIT(DONTCOPY, 17),	/* Do not copy this vma on fork */
+	DECLARE_VMA_BIT(DONTEXPAND, 18),/* Cannot expand with mremap() */
+	DECLARE_VMA_BIT(LOCKONFAULT, 19),/* Lock pages covered when faulted in */
+	DECLARE_VMA_BIT(ACCOUNT, 20),	/* Is a VM accounted object */
+	DECLARE_VMA_BIT(NORESERVE, 21),	/* should the VM suppress accounting */
+	DECLARE_VMA_BIT(HUGETLB, 22),	/* Huge TLB Page VM */
+	DECLARE_VMA_BIT(SYNC, 23),	/* Synchronous page faults */
+	DECLARE_VMA_BIT(ARCH_1, 24),	/* Architecture-specific flag */
+	DECLARE_VMA_BIT(WIPEONFORK, 25),/* Wipe VMA contents in child. */
+	DECLARE_VMA_BIT(DONTDUMP, 26),	/* Do not include in the core dump */
+	DECLARE_VMA_BIT(SOFTDIRTY, 27),	/* NOT soft dirty clean area */
+	DECLARE_VMA_BIT(MIXEDMAP, 28),	/* Can contain struct page and pure PFN pages */
+	DECLARE_VMA_BIT(HUGEPAGE, 29),	/* MADV_HUGEPAGE marked this vma */
+	DECLARE_VMA_BIT(NOHUGEPAGE, 30),/* MADV_NOHUGEPAGE marked this vma */
+	DECLARE_VMA_BIT(MERGEABLE, 31),	/* KSM may merge identical pages */
+	/* These bits are reused, we define specific uses below. */
+	DECLARE_VMA_BIT(HIGH_ARCH_0, 32),
+	DECLARE_VMA_BIT(HIGH_ARCH_1, 33),
+	DECLARE_VMA_BIT(HIGH_ARCH_2, 34),
+	DECLARE_VMA_BIT(HIGH_ARCH_3, 35),
+	DECLARE_VMA_BIT(HIGH_ARCH_4, 36),
+	DECLARE_VMA_BIT(HIGH_ARCH_5, 37),
+	DECLARE_VMA_BIT(HIGH_ARCH_6, 38),
+	/*
+	 * This flag is used to connect VFIO to arch specific KVM code. It
+	 * indicates that the memory under this VMA is safe for use with any
+	 * non-cachable memory type inside KVM. Some VFIO devices, on some
+	 * platforms, are thought to be unsafe and can cause machine crashes
+	 * if KVM does not lock down the memory type.
+	 */
+	DECLARE_VMA_BIT(ALLOW_ANY_UNCACHED, 39),
+#ifdef CONFIG_PPC32
+	DECLARE_VMA_BIT_ALIAS(DROPPABLE, ARCH_1),
+#else
+	DECLARE_VMA_BIT(DROPPABLE, 40),
+#endif
+	DECLARE_VMA_BIT(UFFD_MINOR, 41),
+	DECLARE_VMA_BIT(SEALED, 42),
+	/* Flags that reuse flags above. */
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT0, HIGH_ARCH_0),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT1, HIGH_ARCH_1),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT2, HIGH_ARCH_2),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT3, HIGH_ARCH_3),
+	DECLARE_VMA_BIT_ALIAS(PKEY_BIT4, HIGH_ARCH_4),
+#if defined(CONFIG_X86_USER_SHADOW_STACK)
+	/*
+	 * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
+	 * support core mm.
+	 *
+	 * These VMAs will get a single end guard page. This helps userspace
+	 * protect itself from attacks. A single page is enough for current
+	 * shadow stack archs (x86). See the comments near alloc_shstk() in
+	 * arch/x86/kernel/shstk.c for more details on the guard size.
+	 */
+	DECLARE_VMA_BIT_ALIAS(SHADOW_STACK, HIGH_ARCH_5),
+#elif defined(CONFIG_ARM64_GCS)
+	/*
+	 * arm64's Guarded Control Stack implements similar functionality and
+	 * has similar constraints to shadow stacks.
+	 */
+	DECLARE_VMA_BIT_ALIAS(SHADOW_STACK, HIGH_ARCH_6),
+#endif
+	DECLARE_VMA_BIT_ALIAS(SAO, ARCH_1),		/* Strong Access Ordering (powerpc) */
+	DECLARE_VMA_BIT_ALIAS(GROWSUP, ARCH_1),		/* parisc */
+	DECLARE_VMA_BIT_ALIAS(SPARC_ADI, ARCH_1),	/* sparc64 */
+	DECLARE_VMA_BIT_ALIAS(ARM64_BTI, ARCH_1),	/* arm64 */
+	DECLARE_VMA_BIT_ALIAS(ARCH_CLEAR, ARCH_1),	/* sparc64, arm64 */
+	DECLARE_VMA_BIT_ALIAS(MAPPED_COPY, ARCH_1),	/* !CONFIG_MMU */
+	DECLARE_VMA_BIT_ALIAS(MTE, HIGH_ARCH_4),	/* arm64 */
+	DECLARE_VMA_BIT_ALIAS(MTE_ALLOWED, HIGH_ARCH_5),/* arm64 */
+#ifdef CONFIG_STACK_GROWSUP
+	DECLARE_VMA_BIT_ALIAS(STACK, GROWSUP),
+	DECLARE_VMA_BIT_ALIAS(STACK_EARLY, GROWSDOWN),
+#else
+	DECLARE_VMA_BIT_ALIAS(STACK, GROWSDOWN),
+#endif
+};
+
+#define INIT_VM_FLAG(name) BIT((__force int) VMA_ ## name ## _BIT)
+#define VM_READ		INIT_VM_FLAG(READ)
+#define VM_WRITE	INIT_VM_FLAG(WRITE)
+#define VM_EXEC		INIT_VM_FLAG(EXEC)
+#define VM_SHARED	INIT_VM_FLAG(SHARED)
+#define VM_MAYREAD	INIT_VM_FLAG(MAYREAD)
+#define VM_MAYWRITE	INIT_VM_FLAG(MAYWRITE)
+#define VM_MAYEXEC	INIT_VM_FLAG(MAYEXEC)
+#define VM_MAYSHARE	INIT_VM_FLAG(MAYSHARE)
+#define VM_GROWSDOWN	INIT_VM_FLAG(GROWSDOWN)
+#ifdef CONFIG_MMU
+#define VM_UFFD_MISSING	INIT_VM_FLAG(UFFD_MISSING)
+#else
+#define VM_UFFD_MISSING	VM_NONE
+#define VM_MAYOVERLAY	INIT_VM_FLAG(MAYOVERLAY)
+#endif
+#define VM_PFNMAP	INIT_VM_FLAG(PFNMAP)
+#define VM_MAYBE_GUARD	INIT_VM_FLAG(MAYBE_GUARD)
+#define VM_UFFD_WP	INIT_VM_FLAG(UFFD_WP)
+#define VM_LOCKED	INIT_VM_FLAG(LOCKED)
+#define VM_IO		INIT_VM_FLAG(IO)
+#define VM_SEQ_READ	INIT_VM_FLAG(SEQ_READ)
+#define VM_RAND_READ	INIT_VM_FLAG(RAND_READ)
+#define VM_DONTCOPY	INIT_VM_FLAG(DONTCOPY)
+#define VM_DONTEXPAND	INIT_VM_FLAG(DONTEXPAND)
+#define VM_LOCKONFAULT	INIT_VM_FLAG(LOCKONFAULT)
+#define VM_ACCOUNT	INIT_VM_FLAG(ACCOUNT)
+#define VM_NORESERVE	INIT_VM_FLAG(NORESERVE)
+#define VM_HUGETLB	INIT_VM_FLAG(HUGETLB)
+#define VM_SYNC		INIT_VM_FLAG(SYNC)
+#define VM_ARCH_1	INIT_VM_FLAG(ARCH_1)
+#define VM_WIPEONFORK	INIT_VM_FLAG(WIPEONFORK)
+#define VM_DONTDUMP	INIT_VM_FLAG(DONTDUMP)
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define VM_SOFTDIRTY	INIT_VM_FLAG(SOFTDIRTY)
+#else
+#define VM_SOFTDIRTY	VM_NONE
+#endif
+#define VM_MIXEDMAP	INIT_VM_FLAG(MIXEDMAP)
+#define VM_HUGEPAGE	INIT_VM_FLAG(HUGEPAGE)
+#define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
+#define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
+#define VM_STACK	INIT_VM_FLAG(STACK)
+#ifdef CONFIG_STACK_GROWS_UP
+#define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
+#else
+#define VM_STACK_EARLY	VM_NONE
+#endif
+#ifdef CONFIG_ARCH_HAS_PKEYS
+#define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
+/* Despite the naming, these are FLAGS not bits. */
+#define VM_PKEY_BIT0 INIT_VM_FLAG(PKEY_BIT0)
+#define VM_PKEY_BIT1 INIT_VM_FLAG(PKEY_BIT1)
+#define VM_PKEY_BIT2 INIT_VM_FLAG(PKEY_BIT2)
+#if CONFIG_ARCH_PKEY_BITS > 3
+#define VM_PKEY_BIT3 INIT_VM_FLAG(PKEY_BIT3)
+#else
+#define VM_PKEY_BIT3  VM_NONE
+#endif /* CONFIG_ARCH_PKEY_BITS > 3 */
+#if CONFIG_ARCH_PKEY_BITS > 4
+#define VM_PKEY_BIT4 INIT_VM_FLAG(PKEY_BIT4)
+#else
+#define VM_PKEY_BIT4  VM_NONE
+#endif /* CONFIG_ARCH_PKEY_BITS > 4 */
+#endif /* CONFIG_ARCH_HAS_PKEYS */
+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS)
+#define VM_SHADOW_STACK	INIT_VM_FLAG(SHADOW_STACK)
+#else
+#define VM_SHADOW_STACK	VM_NONE
+#endif
+#if defined(CONFIG_PPC64)
+#define VM_SAO		INIT_VM_FLAG(SAO)
+#elif defined(CONFIG_PARISC)
+#define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
+#elif defined(CONFIG_SPARC64)
+#define VM_SPARC_ADI	INIT_VM_FLAG(SPARC_ADI)
+#define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
+#elif defined(CONFIG_ARM64)
+#define VM_ARM64_BTI	INIT_VM_FLAG(ARM64_BTI)
+#define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
+#elif !defined(CONFIG_MMU)
+#define VM_MAPPED_COPY	INIT_VM_FLAG(MAPPED_COPY)
+#endif
+#ifndef VM_GROWSUP
+#define VM_GROWSUP	VM_NONE
+#endif
+#ifdef CONFIG_ARM64_MTE
+#define VM_MTE		INIT_VM_FLAG(MTE)
+#define VM_MTE_ALLOWED	INIT_VM_FLAG(MTE_ALLOWED)
+#else
+#define VM_MTE		VM_NONE
+#define VM_MTE_ALLOWED	VM_NONE
+#endif
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+#define VM_UFFD_MINOR	INIT_VM_FLAG(UFFD_MINOR)
+#else
+#define VM_UFFD_MINOR	VM_NONE
+#endif
+#ifdef CONFIG_64BIT
+#define VM_ALLOW_ANY_UNCACHED	INIT_VM_FLAG(ALLOW_ANY_UNCACHED)
+#define VM_SEALED		INIT_VM_FLAG(SEALED)
+#else
+#define VM_ALLOW_ANY_UNCACHED	VM_NONE
+#define VM_SEALED		VM_NONE
+#endif
+#if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
+#define VM_DROPPABLE		INIT_VM_FLAG(DROPPABLE)
+#else
+#define VM_DROPPABLE		VM_NONE
+#endif
+
+/* Bits set in the VMA until the stack is in its final location */
+#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
+
+#define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
+
+/* Common data flag combinations */
+#define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_FLAGS_NON_EXEC	(VM_READ | VM_WRITE | VM_MAYREAD | \
+				 VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_FLAGS_EXEC	(VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#ifndef VM_DATA_DEFAULT_FLAGS		/* arch can override this */
+#define VM_DATA_DEFAULT_FLAGS  VM_DATA_FLAGS_EXEC
+#endif
+
+#ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
+#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
+#endif
+
+#define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
+
+#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+
+/* VMA basic access permission flags */
+#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
+
+/*
+ * Special vmas that are non-mergable, non-mlock()able.
+ */
+#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
+
+#define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
+#define TASK_SIZE_LOW		DEFAULT_MAP_WINDOW
+#define TASK_SIZE_MAX		DEFAULT_MAP_WINDOW
+#define STACK_TOP		TASK_SIZE_LOW
+#define STACK_TOP_MAX		TASK_SIZE_MAX
+
+/* This mask represents all the VMA flag bits used by mlock */
+#define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
+
+#define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
+
+#define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#define RLIMIT_STACK		3	/* max stack size */
+#define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
+
+#define CAP_IPC_LOCK         14
+
+#define VM_STICKY (VM_SOFTDIRTY | VM_MAYBE_GUARD)
+
+#define VM_IGNORE_MERGE VM_STICKY
+
+#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)
+
+#define pgprot_val(x)		((x).pgprot)
+#define __pgprot(x)		((pgprot_t) { (x) } )
+
+#define for_each_vma(__vmi, __vma)					\
+	while (((__vma) = vma_next(&(__vmi))) != NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(__vmi, __vma, __end)				\
+	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
+
+#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
+
+#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))
+
+#define test_and_set_bit(nr, addr) __test_and_set_bit(nr, addr)
+#define test_and_clear_bit(nr, addr) __test_and_clear_bit(nr, addr)
+
+#define AS_MM_ALL_LOCKS 2
+
+#define swap(a, b) \
+	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+
+/*
+ * Flags for bug emulation.
+ *
+ * These occupy the top three bytes.
+ */
+enum {
+	READ_IMPLIES_EXEC =	0x0400000,
+};
+
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, __mm, __addr)				\
+	struct vma_iterator name = {					\
+		.mas = {						\
+			.tree = &(__mm)->mm_mt,				\
+			.index = __addr,				\
+			.node = NULL,					\
+			.status = ma_start,				\
+		},							\
+	}
+
+#define DEFINE_MUTEX(mutexname) \
+	struct mutex mutexname = {}
+
+#define DECLARE_BITMAP(name, bits) \
+	unsigned long name[BITS_TO_LONGS(bits)]
+
+#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
+
+/* What action should be taken after an .mmap_prepare call is complete? */
+enum mmap_action_type {
+	MMAP_NOTHING,		/* Mapping is complete, no further action. */
+	MMAP_REMAP_PFN,		/* Remap PFN range. */
+	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
+};
+
+/*
+ * Describes an action an mmap_prepare hook can instruct to be taken to complete
+ * the mapping of a VMA. Specified in vm_area_desc.
+ */
+struct mmap_action {
+	union {
+		/* Remap range. */
+		struct {
+			unsigned long start;
+			unsigned long start_pfn;
+			unsigned long size;
+			pgprot_t pgprot;
+		} remap;
+	};
+	enum mmap_action_type type;
+
+	/*
+	 * If specified, this hook is invoked after the selected action has been
+	 * successfully completed. Note that the VMA write lock still held.
+	 *
+	 * The absolute minimum ought to be done here.
+	 *
+	 * Returns 0 on success, or an error code.
+	 */
+	int (*success_hook)(const struct vm_area_struct *vma);
+
+	/*
+	 * If specified, this hook is invoked when an error occurred when
+	 * attempting the selection action.
+	 *
+	 * The hook can return an error code in order to filter the error, but
+	 * it is not valid to clear the error here.
+	 */
+	int (*error_hook)(int err);
+
+	/*
+	 * This should be set in rare instances where the operation required
+	 * that the rmap should not be able to access the VMA until
+	 * completely set up.
+	 */
+	bool hide_from_rmap_until_complete :1;
+};
+
+/* Operations which modify VMAs. */
+enum vma_operation {
+	VMA_OP_SPLIT,
+	VMA_OP_MERGE_UNFAULTED,
+	VMA_OP_REMAP,
+	VMA_OP_FORK,
+};
+
+/*
+ * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
+ * manipulate mutable fields which will cause those fields to be updated in the
+ * resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vm_area_desc {
+	/* Immutable state. */
+	const struct mm_struct *const mm;
+	struct file *const file; /* May vary from vm_file in stacked callers. */
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *vm_file;
+	union {
+		vm_flags_t vm_flags;
+		vma_flags_t vma_flags;
+	};
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
+};
+
+struct vm_area_struct {
+	/* The first cache line has the info for VMA tree walking. */
+
+	union {
+		struct {
+			/* VMA covers [vm_start; vm_end) addresses within mm */
+			unsigned long vm_start;
+			unsigned long vm_end;
+		};
+		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
+	};
+
+	struct mm_struct *vm_mm;	/* The address space we belong to. */
+	pgprot_t vm_page_prot;          /* Access permissions of this VMA. */
+
+	/*
+	 * Flags, see mm.h.
+	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
+	 */
+	union {
+		const vm_flags_t vm_flags;
+		vma_flags_t flags;
+	};
+
+#ifdef CONFIG_PER_VMA_LOCK
+	/*
+	 * Can only be written (using WRITE_ONCE()) while holding both:
+	 *  - mmap_lock (in write mode)
+	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set
+	 * Can be read reliably while holding one of:
+	 *  - mmap_lock (in read or write mode)
+	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set or vm_refcnt > 1
+	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
+	 * while holding nothing (except RCU to keep the VMA struct allocated).
+	 *
+	 * This sequence counter is explicitly allowed to overflow; sequence
+	 * counter reuse can only lead to occasional unnecessary use of the
+	 * slowpath.
+	 */
+	unsigned int vm_lock_seq;
+#endif
+
+	/*
+	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
+	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
+	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
+	 * or brk vma (with NULL file) can only be in an anon_vma list.
+	 */
+	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
+					  * page_table_lock */
+	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
+
+	/* Function pointers to deal with this struct. */
+	const struct vm_operations_struct *vm_ops;
+
+	/* Information about our backing store: */
+	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
+					   units */
+	struct file * vm_file;		/* File we map to (can be NULL). */
+	void * vm_private_data;		/* was vm_pte (shared mem) */
+
+#ifdef CONFIG_SWAP
+	atomic_long_t swap_readahead_info;
+#endif
+#ifndef CONFIG_MMU
+	struct vm_region *vm_region;	/* NOMMU mapping region */
+#endif
+#ifdef CONFIG_NUMA
+	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
+#endif
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Unstable RCU readers are allowed to read this. */
+	refcount_t vm_refcnt;
+#endif
+	/*
+	 * For areas with an address space and backing store,
+	 * linkage into the address_space->i_mmap interval tree.
+	 *
+	 */
+	struct {
+		struct rb_node rb;
+		unsigned long rb_subtree_last;
+	} shared;
+#ifdef CONFIG_ANON_VMA_NAME
+	/*
+	 * For private and shared anonymous mappings, a pointer to a null
+	 * terminated string containing the name given to the vma, or NULL if
+	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
+	 */
+	struct anon_vma_name *anon_name;
+#endif
+	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+} __randomize_layout;
+
+struct vm_operations_struct {
+	void (*open)(struct vm_area_struct * area);
+	/**
+	 * @close: Called when the VMA is being removed from the MM.
+	 * Context: User context.  May sleep.  Caller holds mmap_lock.
+	 */
+	void (*close)(struct vm_area_struct * area);
+	/* Called any time before splitting to check if it's allowed */
+	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
+	int (*mremap)(struct vm_area_struct *area);
+	/*
+	 * Called by mprotect() to make driver-specific permission
+	 * checks before mprotect() is finalised.   The VMA must not
+	 * be modified.  Returns 0 if mprotect() can proceed.
+	 */
+	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
+			unsigned long end, unsigned long newflags);
+	vm_fault_t (*fault)(struct vm_fault *vmf);
+	vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
+	vm_fault_t (*map_pages)(struct vm_fault *vmf,
+			pgoff_t start_pgoff, pgoff_t end_pgoff);
+	unsigned long (*pagesize)(struct vm_area_struct * area);
+
+	/* notification that a previously read-only page is about to become
+	 * writable, if an error is returned it will cause a SIGBUS */
+	vm_fault_t (*page_mkwrite)(struct vm_fault *vmf);
+
+	/* same as page_mkwrite when using VM_PFNMAP|VM_MIXEDMAP */
+	vm_fault_t (*pfn_mkwrite)(struct vm_fault *vmf);
+
+	/* called by access_process_vm when get_user_pages() fails, typically
+	 * for use by special VMAs. See also generic_access_phys() for a generic
+	 * implementation useful for any iomem mapping.
+	 */
+	int (*access)(struct vm_area_struct *vma, unsigned long addr,
+		      void *buf, int len, int write);
+
+	/* Called by the /proc/PID/maps code to ask the vma whether it
+	 * has a special name.  Returning non-NULL will also cause this
+	 * vma to be dumped unconditionally. */
+	const char *(*name)(struct vm_area_struct *vma);
+
+#ifdef CONFIG_NUMA
+	/*
+	 * set_policy() op must add a reference to any non-NULL @new mempolicy
+	 * to hold the policy upon return.  Caller should pass NULL @new to
+	 * remove a policy and fall back to surrounding context--i.e. do not
+	 * install a MPOL_DEFAULT policy, nor the task or system default
+	 * mempolicy.
+	 */
+	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
+
+	/*
+	 * get_policy() op must add reference [mpol_get()] to any policy at
+	 * (vma,addr) marked as MPOL_SHARED.  The shared policy infrastructure
+	 * in mm/mempolicy.c will do this automatically.
+	 * get_policy() must NOT add a ref if the policy at (vma,addr) is not
+	 * marked as MPOL_SHARED. vma policies are protected by the mmap_lock.
+	 * If no [shared/vma] mempolicy exists at the addr, get_policy() op
+	 * must return NULL--i.e., do not "fallback" to task or system default
+	 * policy.
+	 */
+	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
+					unsigned long addr, pgoff_t *ilx);
+#endif
+#ifdef CONFIG_FIND_NORMAL_PAGE
+	/*
+	 * Called by vm_normal_page() for special PTEs in @vma at @addr. This
+	 * allows for returning a "normal" page from vm_normal_page() even
+	 * though the PTE indicates that the "struct page" either does not exist
+	 * or should not be touched: "special".
+	 *
+	 * Do not add new users: this really only works when a "normal" page
+	 * was mapped, but then the PTE got changed to something weird (+
+	 * marked special) that would not make pte_pfn() identify the originally
+	 * inserted page.
+	 */
+	struct page *(*find_normal_page)(struct vm_area_struct *vma,
+					 unsigned long addr);
+#endif /* CONFIG_FIND_NORMAL_PAGE */
+};
+
+struct vm_unmapped_area_info {
+#define VM_UNMAPPED_AREA_TOPDOWN 1
+	unsigned long flags;
+	unsigned long length;
+	unsigned long low_limit;
+	unsigned long high_limit;
+	unsigned long align_mask;
+	unsigned long align_offset;
+	unsigned long start_gap;
+};
+
+struct pagetable_move_control {
+	struct vm_area_struct *old; /* Source VMA. */
+	struct vm_area_struct *new; /* Destination VMA. */
+	unsigned long old_addr; /* Address from which the move begins. */
+	unsigned long old_end; /* Exclusive address at which old range ends. */
+	unsigned long new_addr; /* Address to move page tables to. */
+	unsigned long len_in; /* Bytes to remap specified by user. */
+
+	bool need_rmap_locks; /* Do rmap locks need to be taken? */
+	bool for_stack; /* Is this an early temp stack being moved? */
+};
+
+#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
+	struct pagetable_move_control name = {				\
+		.old = old_,						\
+		.new = new_,						\
+		.old_addr = old_addr_,					\
+		.old_end = (old_addr_) + (len_),			\
+		.new_addr = new_addr_,					\
+		.len_in = len_,						\
+	}
+
+static inline void vma_iter_invalidate(struct vma_iterator *vmi)
+{
+	mas_pause(&vmi->mas);
+}
+
+static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
+{
+	return __pgprot(pgprot_val(oldprot) | pgprot_val(newprot));
+}
+
+static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
+{
+	return __pgprot(vm_flags);
+}
+
+static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
+{
+	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
+}
+
+/*
+ * Copy value to the first system word of VMA flags, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
+{
+	*ACCESS_PRIVATE(flags, __vma_flags) = value;
+}
+
+/*
+ * Copy value to the first system word of VMA flags ONCE, non-atomically.
+ *
+ * IMPORTANT: This does not overwrite bytes past the first system word. The
+ * caller must account for this.
+ */
+static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	WRITE_ONCE(*bitmap, value);
+}
+
+/* Update the first system word of VMA flags setting bits, non-atomically. */
+static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap |= value;
+}
+
+/* Update the first system word of VMA flags clearing bits, non-atomically. */
+static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	*bitmap &= ~value;
+}
+
+static inline void vma_flags_clear_all(vma_flags_t *flags)
+{
+	bitmap_zero(ACCESS_PRIVATE(flags, __vma_flags), NUM_VMA_FLAG_BITS);
+}
+
+static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
+{
+	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
+
+	__set_bit((__force int)bit, bitmap);
+}
+
+/* Use when VMA is not part of the VMA tree and needs no locking */
+static inline void vm_flags_init(struct vm_area_struct *vma,
+				 vm_flags_t flags)
+{
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word(&vma->flags, flags);
+}
+
+/*
+ * Use when VMA is part of the VMA tree and modifications need coordination
+ * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
+ * it should be locked explicitly beforehand.
+ */
+static inline void vm_flags_reset(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_assert_write_locked(vma);
+	vm_flags_init(vma, flags);
+}
+
+static inline void vm_flags_reset_once(struct vm_area_struct *vma,
+				       vm_flags_t flags)
+{
+	vma_assert_write_locked(vma);
+	/*
+	 * The user should only be interested in avoiding reordering of
+	 * assignment to the first word.
+	 */
+	vma_flags_clear_all(&vma->flags);
+	vma_flags_overwrite_word_once(&vma->flags, flags);
+}
+
+static inline void vm_flags_set(struct vm_area_struct *vma,
+				vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma_flags_set_word(&vma->flags, flags);
+}
+
+static inline void vm_flags_clear(struct vm_area_struct *vma,
+				  vm_flags_t flags)
+{
+	vma_start_write(vma);
+	vma_flags_clear_word(&vma->flags, flags);
+}
+
+static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
+{
+	vma_flags_t flags;
+	int i;
+
+	vma_flags_clear_all(&flags);
+	for (i = 0; i < count; i++)
+		vma_flag_set(&flags, bits[i]);
+	return flags;
+}
+
+#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
+					 (const vma_flag_t []){__VA_ARGS__})
+
+static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_test = to_test.__vma_flags;
+
+	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_test(flags, ...) \
+	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
+		vma_flags_t to_test)
+{
+	const unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_test = to_test.__vma_flags;
+
+	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_test_all(flags, ...) \
+	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_set = to_set.__vma_flags;
+
+	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_set(flags, ...) \
+	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
+{
+	unsigned long *bitmap = flags->__vma_flags;
+	const unsigned long *bitmap_to_clear = to_clear.__vma_flags;
+
+	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
+}
+
+#define vma_flags_clear(flags, ...) \
+	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
+
+static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
+					   vma_flags_t flags)
+{
+	return vma_flags_test_all_mask(&vma->flags, flags);
+}
+
+#define vma_test_all_flags(vma, ...) \
+	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline void vma_set_flags_mask(struct vm_area_struct *vma,
+				      vma_flags_t flags)
+{
+	vma_flags_set_mask(&vma->flags, flags);
+}
+
+#define vma_set_flags(vma, ...) \
+	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
+
+static inline bool vma_desc_test_flags_mask(const struct vm_area_desc *desc,
+					    vma_flags_t flags)
+{
+	return vma_flags_test_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_test_flags(desc, ...) \
+	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
+					   vma_flags_t flags)
+{
+	vma_flags_set_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_set_flags(desc, ...) \
+	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
+					     vma_flags_t flags)
+{
+	vma_flags_clear_mask(&desc->vma_flags, flags);
+}
+
+#define vma_desc_clear_flags(desc, ...) \
+	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
+
+static inline bool is_shared_maywrite(const vma_flags_t *flags)
+{
+	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(&vma->flags);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses mas_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return mas_find(&vmi->mas, ULONG_MAX);
+}
+
+/*
+ * WARNING: to avoid racing with vma_mark_attached()/vma_mark_detached(), these
+ * assertions should be made either under mmap_write_lock or when the object
+ * has been isolated under mmap_write_lock, ensuring no competing writers.
+ */
+static inline void vma_assert_attached(struct vm_area_struct *vma)
+{
+	WARN_ON_ONCE(!refcount_read(&vma->vm_refcnt));
+}
+
+static inline void vma_assert_detached(struct vm_area_struct *vma)
+{
+	WARN_ON_ONCE(refcount_read(&vma->vm_refcnt));
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *);
+static inline void vma_mark_attached(struct vm_area_struct *vma)
+{
+	vma_assert_write_locked(vma);
+	vma_assert_detached(vma);
+	refcount_set_release(&vma->vm_refcnt, 1);
+}
+
+static inline void vma_mark_detached(struct vm_area_struct *vma)
+{
+	vma_assert_write_locked(vma);
+	vma_assert_attached(vma);
+	/* We are the only writer, so no need to use vma_refcount_put(). */
+	if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
+		/*
+		 * Reader must have temporarily raised vm_refcnt but it will
+		 * drop it without using the vma since vma is write-locked.
+		 */
+	}
+}
+
+static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
+{
+	memset(vma, 0, sizeof(*vma));
+	vma->vm_mm = mm;
+	vma->vm_ops = &vma_dummy_vm_ops;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma->vm_lock_seq = UINT_MAX;
+}
+
+/*
+ * These are defined in vma.h, but sadly vm_stat_account() is referenced by
+ * kernel/fork.c, so we have to these broadly available there, and temporarily
+ * define them here to resolve the dependency cycle.
+ */
+#define is_exec_mapping(flags) \
+	((flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC)
+
+#define is_stack_mapping(flags) \
+	(((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK))
+
+#define is_data_mapping(flags) \
+	((flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE)
+
+static inline void vm_stat_account(struct mm_struct *mm, vm_flags_t flags,
+				   long npages)
+{
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);
+
+	if (is_exec_mapping(flags))
+		mm->exec_vm += npages;
+	else if (is_stack_mapping(flags))
+		mm->stack_vm += npages;
+	else if (is_data_mapping(flags))
+		mm->data_vm += npages;
+}
+
+#undef is_exec_mapping
+#undef is_stack_mapping
+#undef is_data_mapping
+
+static inline void vm_unacct_memory(long pages)
+{
+	vm_acct_memory(-pages);
+}
+
+static inline void mapping_allow_writable(struct address_space *mapping)
+{
+	atomic_inc(&mapping->i_mmap_writable);
+}
+
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
+{
+	return mas_find(&vmi->mas, max - 1);
+}
+
+static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
+			unsigned long start, unsigned long end, gfp_t gfp)
+{
+	__mas_set_range(&vmi->mas, start, end - 1);
+	mas_store_gfp(&vmi->mas, NULL, gfp);
+	if (unlikely(mas_is_err(&vmi->mas)))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void vma_set_anonymous(struct vm_area_struct *vma)
+{
+	vma->vm_ops = NULL;
+}
+
+/* Declared in vma.h. */
+static inline void set_vma_from_desc(struct vm_area_struct *vma,
+		struct vm_area_desc *desc);
+
+static inline int __compat_vma_mmap(const struct file_operations *f_op,
+		struct file *file, struct vm_area_struct *vma)
+{
+	struct vm_area_desc desc = {
+		.mm = vma->vm_mm,
+		.file = file,
+		.start = vma->vm_start,
+		.end = vma->vm_end,
+
+		.pgoff = vma->vm_pgoff,
+		.vm_file = vma->vm_file,
+		.vm_flags = vma->vm_flags,
+		.page_prot = vma->vm_page_prot,
+
+		.action.type = MMAP_NOTHING, /* Default */
+	};
+	int err;
+
+	err = f_op->mmap_prepare(&desc);
+	if (err)
+		return err;
+
+	mmap_action_prepare(&desc.action, &desc);
+	set_vma_from_desc(vma, &desc);
+	return mmap_action_complete(&desc.action, vma);
+}
+
+static inline int compat_vma_mmap(struct file *file,
+		struct vm_area_struct *vma)
+{
+	return __compat_vma_mmap(file->f_op, file, vma);
+}
+
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	mas_init(&vmi->mas, &mm->mm_mt, addr);
+}
+
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
+static inline void mmap_assert_locked(struct mm_struct *);
+static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						unsigned long start_addr,
+						unsigned long end_addr)
+{
+	unsigned long index = start_addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
+}
+
+static inline
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
+{
+	return mtree_load(&mm->mm_mt, addr);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
+{
+	mas_set(&vmi->mas, addr);
+}
+
+static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+{
+	return !vma->vm_ops;
+}
+
+/* Defined in vma.h, so temporarily define here to avoid circular dependency. */
+#define vma_iter_load(vmi) \
+	mas_walk(&(vmi)->mas)
+
+static inline struct vm_area_struct *
+find_vma_prev(struct mm_struct *mm, unsigned long addr,
+			struct vm_area_struct **pprev)
+{
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
+
+	vma = vma_iter_load(&vmi);
+	*pprev = vma_prev(&vmi);
+	if (!vma)
+		vma = vma_next(&vmi);
+	return vma;
+}
+
+#undef vma_iter_load
+
+static inline void vma_iter_free(struct vma_iterator *vmi)
+{
+	mas_destroy(&vmi->mas);
+}
+
+static inline
+struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
+{
+	return mas_next_range(&vmi->mas, ULONG_MAX);
+}
+
+bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
+
+/* Update vma->vm_page_prot to reflect vma->vm_flags. */
+static inline void vma_set_page_prot(struct vm_area_struct *vma)
+{
+	vm_flags_t vm_flags = vma->vm_flags;
+	pgprot_t vm_page_prot;
+
+	/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
+	vm_page_prot = pgprot_modify(vma->vm_page_prot, vm_get_page_prot(vm_flags));
+
+	if (vma_wants_writenotify(vma, vm_page_prot)) {
+		vm_flags &= ~VM_SHARED;
+		/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
+		vm_page_prot = pgprot_modify(vm_page_prot, vm_get_page_prot(vm_flags));
+	}
+	/* remove_protection_ptes reads vma->vm_page_prot without mmap_lock */
+	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
+}
+
+static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_GROWSDOWN)
+		return stack_guard_gap;
+
+	/* See reasoning around the VM_SHADOW_STACK definition */
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return PAGE_SIZE;
+
+	return 0;
+}
+
+static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
+{
+	unsigned long gap = stack_guard_start_gap(vma);
+	unsigned long vm_start = vma->vm_start;
+
+	vm_start -= gap;
+	if (vm_start > vma->vm_start)
+		vm_start = 0;
+	return vm_start;
+}
+
+static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
+{
+	unsigned long vm_end = vma->vm_end;
+
+	if (vma->vm_flags & VM_GROWSUP) {
+		vm_end += stack_guard_gap;
+		if (vm_end < vma->vm_end)
+			vm_end = -PAGE_SIZE;
+	}
+	return vm_end;
+}
+
+static inline bool vma_is_accessible(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_ACCESS_FLAGS;
+}
+
+static inline bool mlock_future_ok(const struct mm_struct *mm,
+		vm_flags_t vm_flags, unsigned long bytes)
+{
+	unsigned long locked_pages, limit_pages;
+
+	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
+		return true;
+
+	locked_pages = bytes >> PAGE_SHIFT;
+	locked_pages += mm->locked_vm;
+
+	limit_pages = rlimit(RLIMIT_MEMLOCK);
+	limit_pages >>= PAGE_SHIFT;
+
+	return locked_pages <= limit_pages;
+}
+
+static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
+{
+	/* If MDWE is disabled, we have nothing to deny. */
+	if (mm_flags_test(MMF_HAS_MDWE, current->mm))
+		return false;
+
+	/* If the new VMA is not executable, we have nothing to deny. */
+	if (!(new & VM_EXEC))
+		return false;
+
+	/* Under MDWE we do not accept newly writably executable VMAs... */
+	if (new & VM_WRITE)
+		return true;
+
+	/* ...nor previously non-executable VMAs becoming executable. */
+	if (!(old & VM_EXEC))
+		return true;
+
+	return false;
+}
+
+static inline int mapping_map_writable(struct address_space *mapping)
+{
+	return atomic_inc_unless_negative(&mapping->i_mmap_writable) ?
+		0 : -EPERM;
+}
+
+/* Did the driver provide valid mmap hook configuration? */
+static inline bool can_mmap_file(struct file *file)
+{
+	bool has_mmap = file->f_op->mmap;
+	bool has_mmap_prepare = file->f_op->mmap_prepare;
+
+	/* Hooks are mutually exclusive. */
+	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
+		return false;
+	if (!has_mmap && !has_mmap_prepare)
+		return false;
+
+	return true;
+}
+
+static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (file->f_op->mmap_prepare)
+		return compat_vma_mmap(file, vma);
+
+	return file->f_op->mmap(file, vma);
+}
+
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
+static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
+{
+	/* Changing an anonymous vma with this is illegal */
+	get_file(file);
+	swap(vma->vm_file, file);
+	fput(file);
+}
+
+struct unmap_desc {
+	struct  ma_state *mas;        /* the maple state point to the first vma */
+	struct vm_area_struct *first; /* The first vma */
+	unsigned long pg_start;       /* The first pagetable address to free (floor) */
+	unsigned long pg_end;         /* The last pagetable address to free (ceiling) */
+	unsigned long vma_start;      /* The min vma address */
+	unsigned long vma_end;        /* The max vma address */
+	unsigned long tree_end;       /* Maximum for the vma tree search */
+	unsigned long tree_reset;     /* Where to reset the vma tree walk */
+	bool mm_wr_locked;            /* If the mmap write lock is held */
+};
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
new file mode 100644
index 000000000000..947a3a0c2566
--- /dev/null
+++ b/tools/testing/vma/include/stubs.h
@@ -0,0 +1,428 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#pragma once
+
+/*
+ * Contains declarations that are STUBBED, that is that are rendered no-ops, in
+ * order to faciliate userland VMA testing.
+ */
+
+/* Forward declarations. */
+struct mm_struct;
+struct vm_area_struct;
+struct vm_area_desc;
+struct pagetable_move_control;
+struct mmap_action;
+struct file;
+struct anon_vma;
+struct anon_vma_chain;
+struct address_space;
+struct unmap_desc;
+
+#define __bitwise
+#define __randomize_layout
+
+#define FIRST_USER_ADDRESS	0UL
+#define USER_PGTABLES_CEILING	0UL
+
+#define vma_policy(vma) NULL
+
+#define down_write_nest_lock(sem, nest_lock)
+
+#define data_race(expr) expr
+
+#define ASSERT_EXCLUSIVE_WRITER(x)
+
+struct vm_userfaultfd_ctx {};
+struct mempolicy {};
+struct mmu_gather {};
+struct mutex {};
+struct vm_fault {};
+
+static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
+					      struct list_head *uf)
+{
+}
+
+static inline unsigned long move_page_tables(struct pagetable_move_control *pmc)
+{
+	return 0;
+}
+
+static inline void free_pgd_range(struct mmu_gather *tlb,
+			unsigned long addr, unsigned long end,
+			unsigned long floor, unsigned long ceiling)
+{
+}
+
+static inline int ksm_execve(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void ksm_exit(struct mm_struct *mm)
+{
+}
+
+static inline void vma_numab_state_init(struct vm_area_struct *vma)
+{
+}
+
+static inline void vma_numab_state_free(struct vm_area_struct *vma)
+{
+}
+
+static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma)
+{
+}
+
+static inline void free_anon_vma_name(struct vm_area_struct *vma)
+{
+}
+
+static inline void mmap_action_prepare(struct mmap_action *action,
+					   struct vm_area_desc *desc)
+{
+}
+
+static inline int mmap_action_complete(struct mmap_action *action,
+					   struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
+{
+}
+
+static inline bool shmem_file(struct file *file)
+{
+	return false;
+}
+
+static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+		const struct file *file, vm_flags_t vm_flags)
+{
+	return vm_flags;
+}
+
+static inline void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
+{
+}
+
+static inline int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot)
+{
+	return 0;
+}
+
+static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
+		struct list_head *uf)
+{
+	return 0;
+}
+
+/* Currently stubbed but we may later wish to un-stub. */
+static inline void vm_acct_memory(long pages);
+
+static inline void mmap_assert_locked(struct mm_struct *mm)
+{
+}
+
+
+static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
+{
+}
+
+static inline void i_mmap_unlock_write(struct address_space *mapping)
+{
+}
+
+static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+					 unsigned long start,
+					 unsigned long end,
+					 struct list_head *unmaps)
+{
+	return 0;
+}
+
+static inline void mmap_write_downgrade(struct mm_struct *mm)
+{
+}
+
+static inline void mmap_read_unlock(struct mm_struct *mm)
+{
+}
+
+static inline void mmap_write_unlock(struct mm_struct *mm)
+{
+}
+
+static inline int mmap_write_lock_killable(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline bool can_modify_mm(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+	return true;
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+}
+
+static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
+{
+	return true;
+}
+
+static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
+			  vm_flags_t vm_flags)
+{
+}
+
+static inline bool mapping_can_writeback(struct address_space *mapping)
+{
+	return true;
+}
+
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+{
+	return false;
+}
+
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
+{
+	return false;
+}
+
+static inline bool userfaultfd_wp(struct vm_area_struct *vma)
+{
+	return false;
+}
+
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
+{
+}
+
+static inline void mutex_lock(struct mutex *lock)
+{
+}
+
+static inline void mutex_unlock(struct mutex *lock)
+{
+}
+
+static inline bool mutex_is_locked(struct mutex *lock)
+{
+	return true;
+}
+
+static inline bool signal_pending(void *p)
+{
+	return false;
+}
+
+static inline bool is_file_hugepages(struct file *file)
+{
+	return false;
+}
+
+static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
+{
+	return 0;
+}
+
+static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags,
+				 unsigned long npages)
+{
+	return true;
+}
+
+static inline int shmem_zero_setup(struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+
+static inline void vm_acct_memory(long pages)
+{
+}
+
+static inline void vma_interval_tree_insert(struct vm_area_struct *vma,
+					    struct rb_root_cached *rb)
+{
+}
+
+static inline void vma_interval_tree_remove(struct vm_area_struct *vma,
+					    struct rb_root_cached *rb)
+{
+}
+
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
+{
+}
+
+static inline void anon_vma_interval_tree_insert(struct anon_vma_chain *avc,
+						 struct rb_root_cached *rb)
+{
+}
+
+static inline void anon_vma_interval_tree_remove(struct anon_vma_chain *avc,
+						 struct rb_root_cached *rb)
+{
+}
+
+static inline void uprobe_mmap(struct vm_area_struct *vma)
+{
+}
+
+static inline void uprobe_munmap(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end)
+{
+}
+
+static inline void i_mmap_lock_write(struct address_space *mapping)
+{
+}
+
+static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
+{
+}
+
+static inline void vma_assert_write_locked(struct vm_area_struct *vma)
+{
+}
+
+static inline void ksm_add_vma(struct vm_area_struct *vma)
+{
+}
+
+static inline void perf_event_mmap(struct vm_area_struct *vma)
+{
+}
+
+static inline bool vma_is_dax(struct vm_area_struct *vma)
+{
+	return false;
+}
+
+static inline struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
+{
+	return NULL;
+}
+
+static inline bool arch_validate_flags(vm_flags_t flags)
+{
+	return true;
+}
+
+static inline void vma_close(struct vm_area_struct *vma)
+{
+}
+
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static inline int is_hugepage_only_range(struct mm_struct *mm,
+					unsigned long addr, unsigned long len)
+{
+	return 0;
+}
+
+static inline bool capable(int cap)
+{
+	return true;
+}
+
+static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
+					struct vm_userfaultfd_ctx vm_ctx)
+{
+	return true;
+}
+
+static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
+				    struct anon_vma_name *anon_name2)
+{
+	return true;
+}
+
+static inline void might_sleep(void)
+{
+}
+
+static inline void fput(struct file *file)
+{
+}
+
+static inline void mpol_put(struct mempolicy *pol)
+{
+}
+
+static inline void lru_add_drain(void)
+{
+}
+
+static inline void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
+{
+}
+
+static inline void update_hiwater_rss(struct mm_struct *mm)
+{
+}
+
+static inline void update_hiwater_vm(struct mm_struct *mm)
+{
+}
+
+static inline void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
+{
+}
+
+static inline void free_pgtables(struct mmu_gather *tlb, struct unmap_desc *unmap)
+{
+}
+
+static inline void mapping_unmap_writable(struct address_space *mapping)
+{
+}
+
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
+{
+}
+
+static inline void tlb_finish_mmu(struct mmu_gather *tlb)
+{
+}
+
+static inline struct file *get_file(struct file *f)
+{
+	return f;
+}
+
+static inline int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
+{
+	return 0;
+}
+
+static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
+					 unsigned long start,
+					 unsigned long end,
+					 struct vm_area_struct *next)
+{
+}
+
+static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index b48ebae3927d..e3ed05b57819 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -12,15 +12,11 @@
 #ifndef __MM_VMA_INTERNAL_H
 #define __MM_VMA_INTERNAL_H
 
-#define __private
-#define __bitwise
-#define __randomize_layout
+#include <stdlib.h>
 
 #define CONFIG_MMU
 #define CONFIG_PER_VMA_LOCK
 
-#include <stdlib.h>
-
 #ifdef __CONCAT
 #undef __CONCAT
 #endif
@@ -35,1936 +31,28 @@
 #include <linux/refcount.h>
 #include <linux/slab.h>
 
-extern unsigned long stack_guard_gap;
-#ifdef CONFIG_MMU
-extern unsigned long mmap_min_addr;
-extern unsigned long dac_mmap_min_addr;
-#else
-#define mmap_min_addr		0UL
-#define dac_mmap_min_addr	0UL
-#endif
-
-#define ACCESS_PRIVATE(p, member) ((p)->member)
-
-#define VM_WARN_ON(_expr) (WARN_ON(_expr))
-#define VM_WARN_ON_ONCE(_expr) (WARN_ON_ONCE(_expr))
-#define VM_WARN_ON_VMG(_expr, _vmg) (WARN_ON(_expr))
-#define VM_BUG_ON(_expr) (BUG_ON(_expr))
-#define VM_BUG_ON_VMA(_expr, _vma) (BUG_ON(_expr))
-
-#define MMF_HAS_MDWE	28
-
-/*
- * vm_flags in vm_area_struct, see mm_types.h.
- * When changing, update also include/trace/events/mmflags.h
- */
-
-#define VM_NONE		0x00000000
-
-/**
- * typedef vma_flag_t - specifies an individual VMA flag by bit number.
- *
- * This value is made type safe by sparse to avoid passing invalid flag values
- * around.
- */
-typedef int __bitwise vma_flag_t;
-
-#define DECLARE_VMA_BIT(name, bitnum) \
-	VMA_ ## name ## _BIT = ((__force vma_flag_t)bitnum)
-#define DECLARE_VMA_BIT_ALIAS(name, aliased) \
-	VMA_ ## name ## _BIT = VMA_ ## aliased ## _BIT
-enum {
-	DECLARE_VMA_BIT(READ, 0),
-	DECLARE_VMA_BIT(WRITE, 1),
-	DECLARE_VMA_BIT(EXEC, 2),
-	DECLARE_VMA_BIT(SHARED, 3),
-	/* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-	DECLARE_VMA_BIT(MAYREAD, 4),	/* limits for mprotect() etc. */
-	DECLARE_VMA_BIT(MAYWRITE, 5),
-	DECLARE_VMA_BIT(MAYEXEC, 6),
-	DECLARE_VMA_BIT(MAYSHARE, 7),
-	DECLARE_VMA_BIT(GROWSDOWN, 8),	/* general info on the segment */
-#ifdef CONFIG_MMU
-	DECLARE_VMA_BIT(UFFD_MISSING, 9),/* missing pages tracking */
-#else
-	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
-	DECLARE_VMA_BIT(MAYOVERLAY, 9),
-#endif /* CONFIG_MMU */
-	/* Page-ranges managed without "struct page", just pure PFN */
-	DECLARE_VMA_BIT(PFNMAP, 10),
-	DECLARE_VMA_BIT(MAYBE_GUARD, 11),
-	DECLARE_VMA_BIT(UFFD_WP, 12),	/* wrprotect pages tracking */
-	DECLARE_VMA_BIT(LOCKED, 13),
-	DECLARE_VMA_BIT(IO, 14),	/* Memory mapped I/O or similar */
-	DECLARE_VMA_BIT(SEQ_READ, 15),	/* App will access data sequentially */
-	DECLARE_VMA_BIT(RAND_READ, 16),	/* App will not benefit from clustered reads */
-	DECLARE_VMA_BIT(DONTCOPY, 17),	/* Do not copy this vma on fork */
-	DECLARE_VMA_BIT(DONTEXPAND, 18),/* Cannot expand with mremap() */
-	DECLARE_VMA_BIT(LOCKONFAULT, 19),/* Lock pages covered when faulted in */
-	DECLARE_VMA_BIT(ACCOUNT, 20),	/* Is a VM accounted object */
-	DECLARE_VMA_BIT(NORESERVE, 21),	/* should the VM suppress accounting */
-	DECLARE_VMA_BIT(HUGETLB, 22),	/* Huge TLB Page VM */
-	DECLARE_VMA_BIT(SYNC, 23),	/* Synchronous page faults */
-	DECLARE_VMA_BIT(ARCH_1, 24),	/* Architecture-specific flag */
-	DECLARE_VMA_BIT(WIPEONFORK, 25),/* Wipe VMA contents in child. */
-	DECLARE_VMA_BIT(DONTDUMP, 26),	/* Do not include in the core dump */
-	DECLARE_VMA_BIT(SOFTDIRTY, 27),	/* NOT soft dirty clean area */
-	DECLARE_VMA_BIT(MIXEDMAP, 28),	/* Can contain struct page and pure PFN pages */
-	DECLARE_VMA_BIT(HUGEPAGE, 29),	/* MADV_HUGEPAGE marked this vma */
-	DECLARE_VMA_BIT(NOHUGEPAGE, 30),/* MADV_NOHUGEPAGE marked this vma */
-	DECLARE_VMA_BIT(MERGEABLE, 31),	/* KSM may merge identical pages */
-	/* These bits are reused, we define specific uses below. */
-	DECLARE_VMA_BIT(HIGH_ARCH_0, 32),
-	DECLARE_VMA_BIT(HIGH_ARCH_1, 33),
-	DECLARE_VMA_BIT(HIGH_ARCH_2, 34),
-	DECLARE_VMA_BIT(HIGH_ARCH_3, 35),
-	DECLARE_VMA_BIT(HIGH_ARCH_4, 36),
-	DECLARE_VMA_BIT(HIGH_ARCH_5, 37),
-	DECLARE_VMA_BIT(HIGH_ARCH_6, 38),
-	/*
-	 * This flag is used to connect VFIO to arch specific KVM code. It
-	 * indicates that the memory under this VMA is safe for use with any
-	 * non-cachable memory type inside KVM. Some VFIO devices, on some
-	 * platforms, are thought to be unsafe and can cause machine crashes
-	 * if KVM does not lock down the memory type.
-	 */
-	DECLARE_VMA_BIT(ALLOW_ANY_UNCACHED, 39),
-#ifdef CONFIG_PPC32
-	DECLARE_VMA_BIT_ALIAS(DROPPABLE, ARCH_1),
-#else
-	DECLARE_VMA_BIT(DROPPABLE, 40),
-#endif
-	DECLARE_VMA_BIT(UFFD_MINOR, 41),
-	DECLARE_VMA_BIT(SEALED, 42),
-	/* Flags that reuse flags above. */
-	DECLARE_VMA_BIT_ALIAS(PKEY_BIT0, HIGH_ARCH_0),
-	DECLARE_VMA_BIT_ALIAS(PKEY_BIT1, HIGH_ARCH_1),
-	DECLARE_VMA_BIT_ALIAS(PKEY_BIT2, HIGH_ARCH_2),
-	DECLARE_VMA_BIT_ALIAS(PKEY_BIT3, HIGH_ARCH_3),
-	DECLARE_VMA_BIT_ALIAS(PKEY_BIT4, HIGH_ARCH_4),
-#if defined(CONFIG_X86_USER_SHADOW_STACK)
-	/*
-	 * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
-	 * support core mm.
-	 *
-	 * These VMAs will get a single end guard page. This helps userspace
-	 * protect itself from attacks. A single page is enough for current
-	 * shadow stack archs (x86). See the comments near alloc_shstk() in
-	 * arch/x86/kernel/shstk.c for more details on the guard size.
-	 */
-	DECLARE_VMA_BIT_ALIAS(SHADOW_STACK, HIGH_ARCH_5),
-#elif defined(CONFIG_ARM64_GCS)
-	/*
-	 * arm64's Guarded Control Stack implements similar functionality and
-	 * has similar constraints to shadow stacks.
-	 */
-	DECLARE_VMA_BIT_ALIAS(SHADOW_STACK, HIGH_ARCH_6),
-#endif
-	DECLARE_VMA_BIT_ALIAS(SAO, ARCH_1),		/* Strong Access Ordering (powerpc) */
-	DECLARE_VMA_BIT_ALIAS(GROWSUP, ARCH_1),		/* parisc */
-	DECLARE_VMA_BIT_ALIAS(SPARC_ADI, ARCH_1),	/* sparc64 */
-	DECLARE_VMA_BIT_ALIAS(ARM64_BTI, ARCH_1),	/* arm64 */
-	DECLARE_VMA_BIT_ALIAS(ARCH_CLEAR, ARCH_1),	/* sparc64, arm64 */
-	DECLARE_VMA_BIT_ALIAS(MAPPED_COPY, ARCH_1),	/* !CONFIG_MMU */
-	DECLARE_VMA_BIT_ALIAS(MTE, HIGH_ARCH_4),	/* arm64 */
-	DECLARE_VMA_BIT_ALIAS(MTE_ALLOWED, HIGH_ARCH_5),/* arm64 */
-#ifdef CONFIG_STACK_GROWSUP
-	DECLARE_VMA_BIT_ALIAS(STACK, GROWSUP),
-	DECLARE_VMA_BIT_ALIAS(STACK_EARLY, GROWSDOWN),
-#else
-	DECLARE_VMA_BIT_ALIAS(STACK, GROWSDOWN),
-#endif
-};
-
-#define INIT_VM_FLAG(name) BIT((__force int) VMA_ ## name ## _BIT)
-#define VM_READ		INIT_VM_FLAG(READ)
-#define VM_WRITE	INIT_VM_FLAG(WRITE)
-#define VM_EXEC		INIT_VM_FLAG(EXEC)
-#define VM_SHARED	INIT_VM_FLAG(SHARED)
-#define VM_MAYREAD	INIT_VM_FLAG(MAYREAD)
-#define VM_MAYWRITE	INIT_VM_FLAG(MAYWRITE)
-#define VM_MAYEXEC	INIT_VM_FLAG(MAYEXEC)
-#define VM_MAYSHARE	INIT_VM_FLAG(MAYSHARE)
-#define VM_GROWSDOWN	INIT_VM_FLAG(GROWSDOWN)
-#ifdef CONFIG_MMU
-#define VM_UFFD_MISSING	INIT_VM_FLAG(UFFD_MISSING)
-#else
-#define VM_UFFD_MISSING	VM_NONE
-#define VM_MAYOVERLAY	INIT_VM_FLAG(MAYOVERLAY)
-#endif
-#define VM_PFNMAP	INIT_VM_FLAG(PFNMAP)
-#define VM_MAYBE_GUARD	INIT_VM_FLAG(MAYBE_GUARD)
-#define VM_UFFD_WP	INIT_VM_FLAG(UFFD_WP)
-#define VM_LOCKED	INIT_VM_FLAG(LOCKED)
-#define VM_IO		INIT_VM_FLAG(IO)
-#define VM_SEQ_READ	INIT_VM_FLAG(SEQ_READ)
-#define VM_RAND_READ	INIT_VM_FLAG(RAND_READ)
-#define VM_DONTCOPY	INIT_VM_FLAG(DONTCOPY)
-#define VM_DONTEXPAND	INIT_VM_FLAG(DONTEXPAND)
-#define VM_LOCKONFAULT	INIT_VM_FLAG(LOCKONFAULT)
-#define VM_ACCOUNT	INIT_VM_FLAG(ACCOUNT)
-#define VM_NORESERVE	INIT_VM_FLAG(NORESERVE)
-#define VM_HUGETLB	INIT_VM_FLAG(HUGETLB)
-#define VM_SYNC		INIT_VM_FLAG(SYNC)
-#define VM_ARCH_1	INIT_VM_FLAG(ARCH_1)
-#define VM_WIPEONFORK	INIT_VM_FLAG(WIPEONFORK)
-#define VM_DONTDUMP	INIT_VM_FLAG(DONTDUMP)
-#ifdef CONFIG_MEM_SOFT_DIRTY
-#define VM_SOFTDIRTY	INIT_VM_FLAG(SOFTDIRTY)
-#else
-#define VM_SOFTDIRTY	VM_NONE
-#endif
-#define VM_MIXEDMAP	INIT_VM_FLAG(MIXEDMAP)
-#define VM_HUGEPAGE	INIT_VM_FLAG(HUGEPAGE)
-#define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
-#define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
-#define VM_STACK	INIT_VM_FLAG(STACK)
-#ifdef CONFIG_STACK_GROWS_UP
-#define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
-#else
-#define VM_STACK_EARLY	VM_NONE
-#endif
-#ifdef CONFIG_ARCH_HAS_PKEYS
-#define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
-/* Despite the naming, these are FLAGS not bits. */
-#define VM_PKEY_BIT0 INIT_VM_FLAG(PKEY_BIT0)
-#define VM_PKEY_BIT1 INIT_VM_FLAG(PKEY_BIT1)
-#define VM_PKEY_BIT2 INIT_VM_FLAG(PKEY_BIT2)
-#if CONFIG_ARCH_PKEY_BITS > 3
-#define VM_PKEY_BIT3 INIT_VM_FLAG(PKEY_BIT3)
-#else
-#define VM_PKEY_BIT3  VM_NONE
-#endif /* CONFIG_ARCH_PKEY_BITS > 3 */
-#if CONFIG_ARCH_PKEY_BITS > 4
-#define VM_PKEY_BIT4 INIT_VM_FLAG(PKEY_BIT4)
-#else
-#define VM_PKEY_BIT4  VM_NONE
-#endif /* CONFIG_ARCH_PKEY_BITS > 4 */
-#endif /* CONFIG_ARCH_HAS_PKEYS */
-#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_ARM64_GCS)
-#define VM_SHADOW_STACK	INIT_VM_FLAG(SHADOW_STACK)
-#else
-#define VM_SHADOW_STACK	VM_NONE
-#endif
-#if defined(CONFIG_PPC64)
-#define VM_SAO		INIT_VM_FLAG(SAO)
-#elif defined(CONFIG_PARISC)
-#define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
-#elif defined(CONFIG_SPARC64)
-#define VM_SPARC_ADI	INIT_VM_FLAG(SPARC_ADI)
-#define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
-#elif defined(CONFIG_ARM64)
-#define VM_ARM64_BTI	INIT_VM_FLAG(ARM64_BTI)
-#define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
-#elif !defined(CONFIG_MMU)
-#define VM_MAPPED_COPY	INIT_VM_FLAG(MAPPED_COPY)
-#endif
-#ifndef VM_GROWSUP
-#define VM_GROWSUP	VM_NONE
-#endif
-#ifdef CONFIG_ARM64_MTE
-#define VM_MTE		INIT_VM_FLAG(MTE)
-#define VM_MTE_ALLOWED	INIT_VM_FLAG(MTE_ALLOWED)
-#else
-#define VM_MTE		VM_NONE
-#define VM_MTE_ALLOWED	VM_NONE
-#endif
-#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-#define VM_UFFD_MINOR	INIT_VM_FLAG(UFFD_MINOR)
-#else
-#define VM_UFFD_MINOR	VM_NONE
-#endif
-#ifdef CONFIG_64BIT
-#define VM_ALLOW_ANY_UNCACHED	INIT_VM_FLAG(ALLOW_ANY_UNCACHED)
-#define VM_SEALED		INIT_VM_FLAG(SEALED)
-#else
-#define VM_ALLOW_ANY_UNCACHED	VM_NONE
-#define VM_SEALED		VM_NONE
-#endif
-#if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
-#define VM_DROPPABLE		INIT_VM_FLAG(DROPPABLE)
-#else
-#define VM_DROPPABLE		VM_NONE
-#endif
-
-/* Bits set in the VMA until the stack is in its final location */
-#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
-
-#define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
-
-/* Common data flag combinations */
-#define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-#define VM_DATA_FLAGS_NON_EXEC	(VM_READ | VM_WRITE | VM_MAYREAD | \
-				 VM_MAYWRITE | VM_MAYEXEC)
-#define VM_DATA_FLAGS_EXEC	(VM_READ | VM_WRITE | VM_EXEC | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-
-#ifndef VM_DATA_DEFAULT_FLAGS		/* arch can override this */
-#define VM_DATA_DEFAULT_FLAGS  VM_DATA_FLAGS_EXEC
-#endif
-
-#ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
-#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
-#endif
-
-#define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
-
-#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
-
-/* VMA basic access permission flags */
-#define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
-
-/*
- * Special vmas that are non-mergable, non-mlock()able.
- */
-#define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
-
-#define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
-#define TASK_SIZE_LOW		DEFAULT_MAP_WINDOW
-#define TASK_SIZE_MAX		DEFAULT_MAP_WINDOW
-#define STACK_TOP		TASK_SIZE_LOW
-#define STACK_TOP_MAX		TASK_SIZE_MAX
-
-/* This mask represents all the VMA flag bits used by mlock */
-#define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
-
-#define TASK_EXEC ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0)
-
-#define VM_DATA_FLAGS_TSK_EXEC	(VM_READ | VM_WRITE | TASK_EXEC | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-
-#define RLIMIT_STACK		3	/* max stack size */
-#define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
-
-#define CAP_IPC_LOCK         14
-
-/*
- * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
- * possesses it but the other does not, the merged VMA should nonetheless have
- * applied to it:
- *
- *   VM_SOFTDIRTY - if a VMA is marked soft-dirty, that is has not had its
- *                  references cleared via /proc/$pid/clear_refs, any merged VMA
- *                  should be considered soft-dirty also as it operates at a VMA
- *                  granularity.
- */
-#define VM_STICKY (VM_SOFTDIRTY | VM_MAYBE_GUARD)
-
 /*
- * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
- * of these flags and the other not does not preclude a merge.
- *
- *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
- *                'sticky'. If any sticky flags exist in either VMA, we simply
- *                set all of them on the merged VMA.
+ * DUPLICATE typedef definitions from kernel source that have to be declared
+ * ahead of all other headers.
  */
-#define VM_IGNORE_MERGE VM_STICKY
-
-/*
- * Flags which should result in page tables being copied on fork. These are
- * flags which indicate that the VMA maps page tables which cannot be
- * reconsistuted upon page fault, so necessitate page table copying upon
- *
- * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
- *                           reasonably reconstructed on page fault.
- *
- *              VM_UFFD_WP - Encodes metadata about an installed uffd
- *                           write protect handler, which cannot be
- *                           reconstructed on page fault.
- *
- *                           We always copy pgtables when dst_vma has uffd-wp
- *                           enabled even if it's file-backed
- *                           (e.g. shmem). Because when uffd-wp is enabled,
- *                           pgtable contains uffd-wp protection information,
- *                           that's something we can't retrieve from page cache,
- *                           and skip copying will lose those info.
- *
- *          VM_MAYBE_GUARD - Could contain page guard region markers which
- *                           by design are a property of the page tables
- *                           only and thus cannot be reconstructed on page
- *                           fault.
- */
-#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GUARD)
-
-#define FIRST_USER_ADDRESS	0UL
-#define USER_PGTABLES_CEILING	0UL
-
-#define vma_policy(vma) NULL
-
-#define down_write_nest_lock(sem, nest_lock)
-
-#define pgprot_val(x)		((x).pgprot)
-#define __pgprot(x)		((pgprot_t) { (x) } )
-
-#define for_each_vma(__vmi, __vma)					\
-	while (((__vma) = vma_next(&(__vmi))) != NULL)
-
-/* The MM code likes to work with exclusive end addresses */
-#define for_each_vma_range(__vmi, __vma, __end)				\
-	while (((__vma) = vma_find(&(__vmi), (__end))) != NULL)
-
-#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
-
-#define PHYS_PFN(x)	((unsigned long)((x) >> PAGE_SHIFT))
-
-#define test_and_set_bit(nr, addr) __test_and_set_bit(nr, addr)
-#define test_and_clear_bit(nr, addr) __test_and_clear_bit(nr, addr)
-
-#define TASK_SIZE ((1ul << 47)-PAGE_SIZE)
-
-#define AS_MM_ALL_LOCKS 2
-
-/* We hardcode this for now. */
-#define sysctl_max_map_count 0x1000000UL
-
-#define pgoff_t unsigned long
-typedef unsigned long	pgprotval_t;
-typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
-typedef unsigned long vm_flags_t;
-typedef __bitwise unsigned int vm_fault_t;
-
-/*
- * The shared stubs do not implement this, it amounts to an fprintf(STDERR,...)
- * either way :)
- */
-#define pr_warn_once pr_err
-
-#define data_race(expr) expr
-
-#define ASSERT_EXCLUSIVE_WRITER(x)
-
-#define pgtable_supports_soft_dirty() 1
-
-/**
- * swap - swap values of @a and @b
- * @a: first value
- * @b: second value
- */
-#define swap(a, b) \
-	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
-
-struct kref {
-	refcount_t refcount;
-};
-
-/*
- * Define the task command name length as enum, then it can be visible to
- * BPF programs.
- */
-enum {
-	TASK_COMM_LEN = 16,
-};
-
-/*
- * Flags for bug emulation.
- *
- * These occupy the top three bytes.
- */
-enum {
-	READ_IMPLIES_EXEC =	0x0400000,
-};
-
-struct task_struct {
-	char comm[TASK_COMM_LEN];
-	pid_t pid;
-	struct mm_struct *mm;
-
-	/* Used for emulating ABI behavior of previous Linux versions: */
-	unsigned int			personality;
-};
-
-struct task_struct *get_current(void);
-#define current get_current()
-
-struct anon_vma {
-	struct anon_vma *root;
-	struct rb_root_cached rb_root;
-
-	/* Test fields. */
-	bool was_cloned;
-	bool was_unlinked;
-};
-
-struct anon_vma_chain {
-	struct anon_vma *anon_vma;
-	struct list_head same_vma;
-};
-
-struct anon_vma_name {
-	struct kref kref;
-	/* The name needs to be at the end because it is dynamically sized. */
-	char name[];
-};
-
-struct vma_iterator {
-	struct ma_state mas;
-};
-
-#define VMA_ITERATOR(name, __mm, __addr)				\
-	struct vma_iterator name = {					\
-		.mas = {						\
-			.tree = &(__mm)->mm_mt,				\
-			.index = __addr,				\
-			.node = NULL,					\
-			.status = ma_start,				\
-		},							\
-	}
-
-struct address_space {
-	struct rb_root_cached	i_mmap;
-	unsigned long		flags;
-	atomic_t		i_mmap_writable;
-};
-
-struct vm_userfaultfd_ctx {};
-struct mempolicy {};
-struct mmu_gather {};
-struct mutex {};
-#define DEFINE_MUTEX(mutexname) \
-	struct mutex mutexname = {}
-
-#define DECLARE_BITMAP(name, bits) \
-	unsigned long name[BITS_TO_LONGS(bits)]
-
+#define __private
 #define NUM_MM_FLAG_BITS (64)
 typedef struct {
 	__private DECLARE_BITMAP(__mm_flags, NUM_MM_FLAG_BITS);
 } mm_flags_t;
-
-/*
- * Opaque type representing current VMA (vm_area_struct) flag state. Must be
- * accessed via vma_flags_xxx() helper functions.
- */
 #define NUM_VMA_FLAG_BITS BITS_PER_LONG
 typedef struct {
 	DECLARE_BITMAP(__vma_flags, NUM_VMA_FLAG_BITS);
 } __private vma_flags_t;
 
-#define EMPTY_VMA_FLAGS ((vma_flags_t){ })
-
-struct mm_struct {
-	struct maple_tree mm_mt;
-	int map_count;			/* number of VMAs */
-	unsigned long total_vm;	   /* Total pages mapped */
-	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
-	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
-	unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
-	unsigned long stack_vm;	   /* VM_STACK */
-
-	unsigned long def_flags;
-
-	mm_flags_t flags; /* Must use mm_flags_* helpers to access */
-};
-
-struct vm_area_struct;
-
-
-/* What action should be taken after an .mmap_prepare call is complete? */
-enum mmap_action_type {
-	MMAP_NOTHING,		/* Mapping is complete, no further action. */
-	MMAP_REMAP_PFN,		/* Remap PFN range. */
-	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
-};
-
-/*
- * Describes an action an mmap_prepare hook can instruct to be taken to complete
- * the mapping of a VMA. Specified in vm_area_desc.
- */
-struct mmap_action {
-	union {
-		/* Remap range. */
-		struct {
-			unsigned long start;
-			unsigned long start_pfn;
-			unsigned long size;
-			pgprot_t pgprot;
-		} remap;
-	};
-	enum mmap_action_type type;
-
-	/*
-	 * If specified, this hook is invoked after the selected action has been
-	 * successfully completed. Note that the VMA write lock still held.
-	 *
-	 * The absolute minimum ought to be done here.
-	 *
-	 * Returns 0 on success, or an error code.
-	 */
-	int (*success_hook)(const struct vm_area_struct *vma);
-
-	/*
-	 * If specified, this hook is invoked when an error occurred when
-	 * attempting the selection action.
-	 *
-	 * The hook can return an error code in order to filter the error, but
-	 * it is not valid to clear the error here.
-	 */
-	int (*error_hook)(int err);
-
-	/*
-	 * This should be set in rare instances where the operation required
-	 * that the rmap should not be able to access the VMA until
-	 * completely set up.
-	 */
-	bool hide_from_rmap_until_complete :1;
-};
-
-/* Operations which modify VMAs. */
-enum vma_operation {
-	VMA_OP_SPLIT,
-	VMA_OP_MERGE_UNFAULTED,
-	VMA_OP_REMAP,
-	VMA_OP_FORK,
-};
-
-/*
- * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
- * manipulate mutable fields which will cause those fields to be updated in the
- * resultant VMA.
- *
- * Helper functions are not required for manipulating any field.
- */
-struct vm_area_desc {
-	/* Immutable state. */
-	const struct mm_struct *const mm;
-	struct file *const file; /* May vary from vm_file in stacked callers. */
-	unsigned long start;
-	unsigned long end;
-
-	/* Mutable fields. Populated with initial state. */
-	pgoff_t pgoff;
-	struct file *vm_file;
-	union {
-		vm_flags_t vm_flags;
-		vma_flags_t vma_flags;
-	};
-	pgprot_t page_prot;
-
-	/* Write-only fields. */
-	const struct vm_operations_struct *vm_ops;
-	void *private_data;
-
-	/* Take further action? */
-	struct mmap_action action;
-};
-
-struct file_operations {
-	int (*mmap)(struct file *, struct vm_area_struct *);
-	int (*mmap_prepare)(struct vm_area_desc *);
-};
-
-struct file {
-	struct address_space	*f_mapping;
-	const struct file_operations	*f_op;
-};
-
-#define VMA_LOCK_OFFSET	0x40000000
-
-typedef struct { unsigned long v; } freeptr_t;
-
-struct vm_area_struct {
-	/* The first cache line has the info for VMA tree walking. */
-
-	union {
-		struct {
-			/* VMA covers [vm_start; vm_end) addresses within mm */
-			unsigned long vm_start;
-			unsigned long vm_end;
-		};
-		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
-	};
-
-	struct mm_struct *vm_mm;	/* The address space we belong to. */
-	pgprot_t vm_page_prot;          /* Access permissions of this VMA. */
-
-	/*
-	 * Flags, see mm.h.
-	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
-	 */
-	union {
-		const vm_flags_t vm_flags;
-		vma_flags_t flags;
-	};
-
-#ifdef CONFIG_PER_VMA_LOCK
-	/*
-	 * Can only be written (using WRITE_ONCE()) while holding both:
-	 *  - mmap_lock (in write mode)
-	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set
-	 * Can be read reliably while holding one of:
-	 *  - mmap_lock (in read or write mode)
-	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set or vm_refcnt > 1
-	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
-	 * while holding nothing (except RCU to keep the VMA struct allocated).
-	 *
-	 * This sequence counter is explicitly allowed to overflow; sequence
-	 * counter reuse can only lead to occasional unnecessary use of the
-	 * slowpath.
-	 */
-	unsigned int vm_lock_seq;
-#endif
-
-	/*
-	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
-	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
-	 * can only be in the i_mmap tree.  An anonymous MAP_PRIVATE, stack
-	 * or brk vma (with NULL file) can only be in an anon_vma list.
-	 */
-	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
-					  * page_table_lock */
-	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
-
-	/* Function pointers to deal with this struct. */
-	const struct vm_operations_struct *vm_ops;
-
-	/* Information about our backing store: */
-	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
-					   units */
-	struct file * vm_file;		/* File we map to (can be NULL). */
-	void * vm_private_data;		/* was vm_pte (shared mem) */
-
-#ifdef CONFIG_SWAP
-	atomic_long_t swap_readahead_info;
-#endif
-#ifndef CONFIG_MMU
-	struct vm_region *vm_region;	/* NOMMU mapping region */
-#endif
-#ifdef CONFIG_NUMA
-	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
-#endif
-#ifdef CONFIG_NUMA_BALANCING
-	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
-#endif
-#ifdef CONFIG_PER_VMA_LOCK
-	/* Unstable RCU readers are allowed to read this. */
-	refcount_t vm_refcnt;
-#endif
-	/*
-	 * For areas with an address space and backing store,
-	 * linkage into the address_space->i_mmap interval tree.
-	 *
-	 */
-	struct {
-		struct rb_node rb;
-		unsigned long rb_subtree_last;
-	} shared;
-#ifdef CONFIG_ANON_VMA_NAME
-	/*
-	 * For private and shared anonymous mappings, a pointer to a null
-	 * terminated string containing the name given to the vma, or NULL if
-	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
-	 */
-	struct anon_vma_name *anon_name;
-#endif
-	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
-} __randomize_layout;
-
-struct vm_fault {};
-
-struct vm_operations_struct {
-	void (*open)(struct vm_area_struct * area);
-	/**
-	 * @close: Called when the VMA is being removed from the MM.
-	 * Context: User context.  May sleep.  Caller holds mmap_lock.
-	 */
-	void (*close)(struct vm_area_struct * area);
-	/* Called any time before splitting to check if it's allowed */
-	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
-	int (*mremap)(struct vm_area_struct *area);
-	/*
-	 * Called by mprotect() to make driver-specific permission
-	 * checks before mprotect() is finalised.   The VMA must not
-	 * be modified.  Returns 0 if mprotect() can proceed.
-	 */
-	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
-			unsigned long end, unsigned long newflags);
-	vm_fault_t (*fault)(struct vm_fault *vmf);
-	vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
-	vm_fault_t (*map_pages)(struct vm_fault *vmf,
-			pgoff_t start_pgoff, pgoff_t end_pgoff);
-	unsigned long (*pagesize)(struct vm_area_struct * area);
-
-	/* notification that a previously read-only page is about to become
-	 * writable, if an error is returned it will cause a SIGBUS */
-	vm_fault_t (*page_mkwrite)(struct vm_fault *vmf);
-
-	/* same as page_mkwrite when using VM_PFNMAP|VM_MIXEDMAP */
-	vm_fault_t (*pfn_mkwrite)(struct vm_fault *vmf);
-
-	/* called by access_process_vm when get_user_pages() fails, typically
-	 * for use by special VMAs. See also generic_access_phys() for a generic
-	 * implementation useful for any iomem mapping.
-	 */
-	int (*access)(struct vm_area_struct *vma, unsigned long addr,
-		      void *buf, int len, int write);
-
-	/* Called by the /proc/PID/maps code to ask the vma whether it
-	 * has a special name.  Returning non-NULL will also cause this
-	 * vma to be dumped unconditionally. */
-	const char *(*name)(struct vm_area_struct *vma);
-
-#ifdef CONFIG_NUMA
-	/*
-	 * set_policy() op must add a reference to any non-NULL @new mempolicy
-	 * to hold the policy upon return.  Caller should pass NULL @new to
-	 * remove a policy and fall back to surrounding context--i.e. do not
-	 * install a MPOL_DEFAULT policy, nor the task or system default
-	 * mempolicy.
-	 */
-	int (*set_policy)(struct vm_area_struct *vma, struct mempolicy *new);
-
-	/*
-	 * get_policy() op must add reference [mpol_get()] to any policy at
-	 * (vma,addr) marked as MPOL_SHARED.  The shared policy infrastructure
-	 * in mm/mempolicy.c will do this automatically.
-	 * get_policy() must NOT add a ref if the policy at (vma,addr) is not
-	 * marked as MPOL_SHARED. vma policies are protected by the mmap_lock.
-	 * If no [shared/vma] mempolicy exists at the addr, get_policy() op
-	 * must return NULL--i.e., do not "fallback" to task or system default
-	 * policy.
-	 */
-	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
-					unsigned long addr, pgoff_t *ilx);
-#endif
-#ifdef CONFIG_FIND_NORMAL_PAGE
-	/*
-	 * Called by vm_normal_page() for special PTEs in @vma at @addr. This
-	 * allows for returning a "normal" page from vm_normal_page() even
-	 * though the PTE indicates that the "struct page" either does not exist
-	 * or should not be touched: "special".
-	 *
-	 * Do not add new users: this really only works when a "normal" page
-	 * was mapped, but then the PTE got changed to something weird (+
-	 * marked special) that would not make pte_pfn() identify the originally
-	 * inserted page.
-	 */
-	struct page *(*find_normal_page)(struct vm_area_struct *vma,
-					 unsigned long addr);
-#endif /* CONFIG_FIND_NORMAL_PAGE */
-};
-
-struct vm_unmapped_area_info {
-#define VM_UNMAPPED_AREA_TOPDOWN 1
-	unsigned long flags;
-	unsigned long length;
-	unsigned long low_limit;
-	unsigned long high_limit;
-	unsigned long align_mask;
-	unsigned long align_offset;
-	unsigned long start_gap;
-};
-
-struct pagetable_move_control {
-	struct vm_area_struct *old; /* Source VMA. */
-	struct vm_area_struct *new; /* Destination VMA. */
-	unsigned long old_addr; /* Address from which the move begins. */
-	unsigned long old_end; /* Exclusive address at which old range ends. */
-	unsigned long new_addr; /* Address to move page tables to. */
-	unsigned long len_in; /* Bytes to remap specified by user. */
-
-	bool need_rmap_locks; /* Do rmap locks need to be taken? */
-	bool for_stack; /* Is this an early temp stack being moved? */
-};
-
-#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
-	struct pagetable_move_control name = {				\
-		.old = old_,						\
-		.new = new_,						\
-		.old_addr = old_addr_,					\
-		.old_end = (old_addr_) + (len_),			\
-		.new_addr = new_addr_,					\
-		.len_in = len_,						\
-	}
-
-static inline void vma_iter_invalidate(struct vma_iterator *vmi)
-{
-	mas_pause(&vmi->mas);
-}
-
-static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
-{
-	return __pgprot(pgprot_val(oldprot) | pgprot_val(newprot));
-}
-
-static inline pgprot_t vm_get_page_prot(vm_flags_t vm_flags)
-{
-	return __pgprot(vm_flags);
-}
-
-static inline void vma_flags_clear_all(vma_flags_t *flags)
-{
-	bitmap_zero(flags->__vma_flags, NUM_VMA_FLAG_BITS);
-}
-
-static inline void vma_flag_set(vma_flags_t *flags, vma_flag_t bit)
-{
-	unsigned long *bitmap = flags->__vma_flags;
-
-	__set_bit((__force int)bit, bitmap);
-}
-
-static inline vma_flags_t __mk_vma_flags(size_t count, const vma_flag_t *bits)
-{
-	vma_flags_t flags;
-	int i;
-
-	vma_flags_clear_all(&flags);
-	for (i = 0; i < count; i++)
-		vma_flag_set(&flags, bits[i]);
-	return flags;
-}
-
-#define mk_vma_flags(...) __mk_vma_flags(COUNT_ARGS(__VA_ARGS__), \
-					 (const vma_flag_t []){__VA_ARGS__})
-
-static __always_inline bool vma_flags_test_mask(const vma_flags_t *flags,
-		vma_flags_t to_test)
-{
-	const unsigned long *bitmap = flags->__vma_flags;
-	const unsigned long *bitmap_to_test = to_test.__vma_flags;
-
-	return bitmap_intersects(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
-}
-
-#define vma_flags_test(flags, ...) \
-	vma_flags_test_mask(flags, mk_vma_flags(__VA_ARGS__))
-
-static __always_inline bool vma_flags_test_all_mask(const vma_flags_t *flags,
-		vma_flags_t to_test)
-{
-	const unsigned long *bitmap = flags->__vma_flags;
-	const unsigned long *bitmap_to_test = to_test.__vma_flags;
-
-	return bitmap_subset(bitmap_to_test, bitmap, NUM_VMA_FLAG_BITS);
-}
-
-#define vma_flags_test_all(flags, ...) \
-	vma_flags_test_all_mask(flags, mk_vma_flags(__VA_ARGS__))
-
-static __always_inline void vma_flags_set_mask(vma_flags_t *flags, vma_flags_t to_set)
-{
-	unsigned long *bitmap = flags->__vma_flags;
-	const unsigned long *bitmap_to_set = to_set.__vma_flags;
-
-	bitmap_or(bitmap, bitmap, bitmap_to_set, NUM_VMA_FLAG_BITS);
-}
-
-#define vma_flags_set(flags, ...) \
-	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
-
-static __always_inline void vma_flags_clear_mask(vma_flags_t *flags, vma_flags_t to_clear)
-{
-	unsigned long *bitmap = flags->__vma_flags;
-	const unsigned long *bitmap_to_clear = to_clear.__vma_flags;
-
-	bitmap_andnot(bitmap, bitmap, bitmap_to_clear, NUM_VMA_FLAG_BITS);
-}
-
-#define vma_flags_clear(flags, ...) \
-	vma_flags_clear_mask(flags, mk_vma_flags(__VA_ARGS__))
-
-static inline bool vma_test_all_flags_mask(const struct vm_area_struct *vma,
-					   vma_flags_t flags)
-{
-	return vma_flags_test_all_mask(&vma->flags, flags);
-}
-
-#define vma_test_all_flags(vma, ...) \
-	vma_test_all_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
-
-static inline void vma_set_flags_mask(struct vm_area_struct *vma,
-				      vma_flags_t flags)
-{
-	vma_flags_set_mask(&vma->flags, flags);
-}
-
-#define vma_set_flags(vma, ...) \
-	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
-
-static inline bool vma_desc_test_flags_mask(const struct vm_area_desc *desc,
-					    vma_flags_t flags)
-{
-	return vma_flags_test_mask(&desc->vma_flags, flags);
-}
-
-#define vma_desc_test_flags(desc, ...) \
-	vma_desc_test_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
-
-static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
-					   vma_flags_t flags)
-{
-	vma_flags_set_mask(&desc->vma_flags, flags);
-}
-
-#define vma_desc_set_flags(desc, ...) \
-	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
-
-static inline void vma_desc_clear_flags_mask(struct vm_area_desc *desc,
-					     vma_flags_t flags)
-{
-	vma_flags_clear_mask(&desc->vma_flags, flags);
-}
-
-#define vma_desc_clear_flags(desc, ...) \
-	vma_desc_clear_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
-
-static inline bool is_shared_maywrite_vm_flags(vm_flags_t vm_flags)
-{
-	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
-		(VM_SHARED | VM_MAYWRITE);
-}
-
-static inline bool is_shared_maywrite(const vma_flags_t *flags)
-{
-	return vma_flags_test_all(flags, VMA_SHARED_BIT, VMA_MAYWRITE_BIT);
-}
-
-static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
-{
-	return is_shared_maywrite(&vma->flags);
-}
-
-static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
-{
-	/*
-	 * Uses mas_find() to get the first VMA when the iterator starts.
-	 * Calling mas_next() could skip the first entry.
-	 */
-	return mas_find(&vmi->mas, ULONG_MAX);
-}
-
-/*
- * WARNING: to avoid racing with vma_mark_attached()/vma_mark_detached(), these
- * assertions should be made either under mmap_write_lock or when the object
- * has been isolated under mmap_write_lock, ensuring no competing writers.
- */
-static inline void vma_assert_attached(struct vm_area_struct *vma)
-{
-	WARN_ON_ONCE(!refcount_read(&vma->vm_refcnt));
-}
-
-static inline void vma_assert_detached(struct vm_area_struct *vma)
-{
-	WARN_ON_ONCE(refcount_read(&vma->vm_refcnt));
-}
-
-static inline void vma_assert_write_locked(struct vm_area_struct *);
-static inline void vma_mark_attached(struct vm_area_struct *vma)
-{
-	vma_assert_write_locked(vma);
-	vma_assert_detached(vma);
-	refcount_set_release(&vma->vm_refcnt, 1);
-}
-
-static inline void vma_mark_detached(struct vm_area_struct *vma)
-{
-	vma_assert_write_locked(vma);
-	vma_assert_attached(vma);
-	/* We are the only writer, so no need to use vma_refcount_put(). */
-	if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
-		/*
-		 * Reader must have temporarily raised vm_refcnt but it will
-		 * drop it without using the vma since vma is write-locked.
-		 */
-	}
-}
-
-extern const struct vm_operations_struct vma_dummy_vm_ops;
-
-extern unsigned long rlimit(unsigned int limit);
-
-static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
-{
-	memset(vma, 0, sizeof(*vma));
-	vma->vm_mm = mm;
-	vma->vm_ops = &vma_dummy_vm_ops;
-	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	vma->vm_lock_seq = UINT_MAX;
-}
-
-/*
- * These are defined in vma.h, but sadly vm_stat_account() is referenced by
- * kernel/fork.c, so we have to these broadly available there, and temporarily
- * define them here to resolve the dependency cycle.
- */
-
-#define is_exec_mapping(flags) \
-	((flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC)
-
-#define is_stack_mapping(flags) \
-	(((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK))
-
-#define is_data_mapping(flags) \
-	((flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE)
-
-static inline void vm_stat_account(struct mm_struct *mm, vm_flags_t flags,
-				   long npages)
-{
-	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm)+npages);
-
-	if (is_exec_mapping(flags))
-		mm->exec_vm += npages;
-	else if (is_stack_mapping(flags))
-		mm->stack_vm += npages;
-	else if (is_data_mapping(flags))
-		mm->data_vm += npages;
-}
-
-#undef is_exec_mapping
-#undef is_stack_mapping
-#undef is_data_mapping
-
-/* Currently stubbed but we may later wish to un-stub. */
-static inline void vm_acct_memory(long pages);
-static inline void vm_unacct_memory(long pages)
-{
-	vm_acct_memory(-pages);
-}
-
-static inline void mapping_allow_writable(struct address_space *mapping)
-{
-	atomic_inc(&mapping->i_mmap_writable);
-}
-
-static inline
-struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
-{
-	return mas_find(&vmi->mas, max - 1);
-}
-
-static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
-			unsigned long start, unsigned long end, gfp_t gfp)
-{
-	__mas_set_range(&vmi->mas, start, end - 1);
-	mas_store_gfp(&vmi->mas, NULL, gfp);
-	if (unlikely(mas_is_err(&vmi->mas)))
-		return -ENOMEM;
-
-	return 0;
-}
-
-static inline void mmap_assert_locked(struct mm_struct *);
-static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-						unsigned long start_addr,
-						unsigned long end_addr)
-{
-	unsigned long index = start_addr;
-
-	mmap_assert_locked(mm);
-	return mt_find(&mm->mm_mt, &index, end_addr - 1);
-}
-
-static inline
-struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
-{
-	return mtree_load(&mm->mm_mt, addr);
-}
-
-static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
-{
-	return mas_prev(&vmi->mas, 0);
-}
-
-static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
-{
-	mas_set(&vmi->mas, addr);
-}
-
-static inline bool vma_is_anonymous(struct vm_area_struct *vma)
-{
-	return !vma->vm_ops;
-}
-
-/* Defined in vma.h, so temporarily define here to avoid circular dependency. */
-#define vma_iter_load(vmi) \
-	mas_walk(&(vmi)->mas)
-
-static inline struct vm_area_struct *
-find_vma_prev(struct mm_struct *mm, unsigned long addr,
-			struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, addr);
-
-	vma = vma_iter_load(&vmi);
-	*pprev = vma_prev(&vmi);
-	if (!vma)
-		vma = vma_next(&vmi);
-	return vma;
-}
-
-#undef vma_iter_load
-
-static inline void vma_iter_init(struct vma_iterator *vmi,
-		struct mm_struct *mm, unsigned long addr)
-{
-	mas_init(&vmi->mas, &mm->mm_mt, addr);
-}
-
-/* Stubbed functions. */
-
-static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
-{
-	return NULL;
-}
-
-static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
-					struct vm_userfaultfd_ctx vm_ctx)
-{
-	return true;
-}
-
-static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
-				    struct anon_vma_name *anon_name2)
-{
-	return true;
-}
-
-static inline void might_sleep(void)
-{
-}
-
-static inline unsigned long vma_pages(struct vm_area_struct *vma)
-{
-	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-}
-
-static inline void fput(struct file *file)
-{
-}
-
-static inline void mpol_put(struct mempolicy *pol)
-{
-}
-
-static inline void lru_add_drain(void)
-{
-}
-
-static inline void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
-{
-}
-
-static inline void update_hiwater_rss(struct mm_struct *mm)
-{
-}
-
-static inline void update_hiwater_vm(struct mm_struct *mm)
-{
-}
-
-struct unmap_desc;
-
-static inline void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
-{
-}
-
-static inline void free_pgtables(struct mmu_gather *tlb, struct unmap_desc *desc)
-{
-	(void)tlb;
-	(void)desc;
-}
-
-static inline void mapping_unmap_writable(struct address_space *mapping)
-{
-}
-
-static inline void flush_dcache_mmap_lock(struct address_space *mapping)
-{
-}
-
-static inline void tlb_finish_mmu(struct mmu_gather *tlb)
-{
-}
-
-static inline struct file *get_file(struct file *f)
-{
-	return f;
-}
-
-static inline int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
-{
-	return 0;
-}
-
-static inline int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src,
-				 enum vma_operation operation)
-{
-	/* For testing purposes. We indicate that an anon_vma has been cloned. */
-	if (src->anon_vma != NULL) {
-		dst->anon_vma = src->anon_vma;
-		dst->anon_vma->was_cloned = true;
-	}
-
-	return 0;
-}
-
-static inline void vma_start_write(struct vm_area_struct *vma)
-{
-	/* Used to indicate to tests that a write operation has begun. */
-	vma->vm_lock_seq++;
-}
-
-static inline __must_check
-int vma_start_write_killable(struct vm_area_struct *vma)
-{
-	/* Used to indicate to tests that a write operation has begun. */
-	vma->vm_lock_seq++;
-	return 0;
-}
-
-static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
-					 unsigned long start,
-					 unsigned long end,
-					 struct vm_area_struct *next)
-{
-}
-
-static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
-
-static inline void vma_iter_free(struct vma_iterator *vmi)
-{
-	mas_destroy(&vmi->mas);
-}
-
-static inline
-struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
-{
-	return mas_next_range(&vmi->mas, ULONG_MAX);
-}
-
-static inline void vm_acct_memory(long pages)
-{
-}
-
-static inline void vma_interval_tree_insert(struct vm_area_struct *vma,
-					    struct rb_root_cached *rb)
-{
-}
-
-static inline void vma_interval_tree_remove(struct vm_area_struct *vma,
-					    struct rb_root_cached *rb)
-{
-}
-
-static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
-{
-}
-
-static inline void anon_vma_interval_tree_insert(struct anon_vma_chain *avc,
-						 struct rb_root_cached *rb)
-{
-}
-
-static inline void anon_vma_interval_tree_remove(struct anon_vma_chain *avc,
-						 struct rb_root_cached *rb)
-{
-}
-
-static inline void uprobe_mmap(struct vm_area_struct *vma)
-{
-}
-
-static inline void uprobe_munmap(struct vm_area_struct *vma,
-				 unsigned long start, unsigned long end)
-{
-}
-
-static inline void i_mmap_lock_write(struct address_space *mapping)
-{
-}
-
-static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
-{
-}
-
-static inline void vma_assert_write_locked(struct vm_area_struct *vma)
-{
-}
-
-static inline void unlink_anon_vmas(struct vm_area_struct *vma)
-{
-	/* For testing purposes, indicate that the anon_vma was unlinked. */
-	vma->anon_vma->was_unlinked = true;
-}
-
-static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
-{
-}
-
-static inline void i_mmap_unlock_write(struct address_space *mapping)
-{
-}
-
-static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-					 unsigned long start,
-					 unsigned long end,
-					 struct list_head *unmaps)
-{
-	return 0;
-}
-
-static inline void mmap_write_downgrade(struct mm_struct *mm)
-{
-}
-
-static inline void mmap_read_unlock(struct mm_struct *mm)
-{
-}
-
-static inline void mmap_write_unlock(struct mm_struct *mm)
-{
-}
-
-static inline int mmap_write_lock_killable(struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline bool can_modify_mm(struct mm_struct *mm,
-				 unsigned long start,
-				 unsigned long end)
-{
-	return true;
-}
-
-static inline void arch_unmap(struct mm_struct *mm,
-				 unsigned long start,
-				 unsigned long end)
-{
-}
-
-static inline void mmap_assert_locked(struct mm_struct *mm)
-{
-}
-
-static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
-{
-	return true;
-}
-
-static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
-			  vm_flags_t vm_flags)
-{
-}
-
-static inline bool mapping_can_writeback(struct address_space *mapping)
-{
-	return true;
-}
-
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
-{
-	return false;
-}
-
-static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
-{
-	return false;
-}
-
-static inline bool userfaultfd_wp(struct vm_area_struct *vma)
-{
-	return false;
-}
-
-static inline void mmap_assert_write_locked(struct mm_struct *mm)
-{
-}
-
-static inline void mutex_lock(struct mutex *lock)
-{
-}
-
-static inline void mutex_unlock(struct mutex *lock)
-{
-}
-
-static inline bool mutex_is_locked(struct mutex *lock)
-{
-	return true;
-}
-
-static inline bool signal_pending(void *p)
-{
-	return false;
-}
-
-static inline bool is_file_hugepages(struct file *file)
-{
-	return false;
-}
-
-static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
-{
-	return 0;
-}
-
-static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags,
-				 unsigned long npages)
-{
-	return true;
-}
-
-static inline int shmem_zero_setup(struct vm_area_struct *vma)
-{
-	return 0;
-}
-
-static inline void vma_set_anonymous(struct vm_area_struct *vma)
-{
-	vma->vm_ops = NULL;
-}
-
-static inline void ksm_add_vma(struct vm_area_struct *vma)
-{
-}
-
-static inline void perf_event_mmap(struct vm_area_struct *vma)
-{
-}
-
-static inline bool vma_is_dax(struct vm_area_struct *vma)
-{
-	return false;
-}
-
-static inline struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
-{
-	return NULL;
-}
-
-bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
-
-/* Update vma->vm_page_prot to reflect vma->vm_flags. */
-static inline void vma_set_page_prot(struct vm_area_struct *vma)
-{
-	vm_flags_t vm_flags = vma->vm_flags;
-	pgprot_t vm_page_prot;
-
-	/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
-	vm_page_prot = pgprot_modify(vma->vm_page_prot, vm_get_page_prot(vm_flags));
-
-	if (vma_wants_writenotify(vma, vm_page_prot)) {
-		vm_flags &= ~VM_SHARED;
-		/* testing: we inline vm_pgprot_modify() to avoid clash with vma.h. */
-		vm_page_prot = pgprot_modify(vm_page_prot, vm_get_page_prot(vm_flags));
-	}
-	/* remove_protection_ptes reads vma->vm_page_prot without mmap_lock */
-	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
-}
-
-static inline bool arch_validate_flags(vm_flags_t flags)
-{
-	return true;
-}
-
-static inline void vma_close(struct vm_area_struct *vma)
-{
-}
-
-static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
-{
-	return 0;
-}
-
-static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
-{
-	if (vma->vm_flags & VM_GROWSDOWN)
-		return stack_guard_gap;
-
-	/* See reasoning around the VM_SHADOW_STACK definition */
-	if (vma->vm_flags & VM_SHADOW_STACK)
-		return PAGE_SIZE;
-
-	return 0;
-}
-
-static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
-{
-	unsigned long gap = stack_guard_start_gap(vma);
-	unsigned long vm_start = vma->vm_start;
-
-	vm_start -= gap;
-	if (vm_start > vma->vm_start)
-		vm_start = 0;
-	return vm_start;
-}
-
-static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
-{
-	unsigned long vm_end = vma->vm_end;
-
-	if (vma->vm_flags & VM_GROWSUP) {
-		vm_end += stack_guard_gap;
-		if (vm_end < vma->vm_end)
-			vm_end = -PAGE_SIZE;
-	}
-	return vm_end;
-}
-
-static inline int is_hugepage_only_range(struct mm_struct *mm,
-					unsigned long addr, unsigned long len)
-{
-	return 0;
-}
-
-static inline bool vma_is_accessible(struct vm_area_struct *vma)
-{
-	return vma->vm_flags & VM_ACCESS_FLAGS;
-}
-
-static inline bool capable(int cap)
-{
-	return true;
-}
-
-static inline bool mlock_future_ok(const struct mm_struct *mm,
-		vm_flags_t vm_flags, unsigned long bytes)
-{
-	unsigned long locked_pages, limit_pages;
-
-	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
-		return true;
-
-	locked_pages = bytes >> PAGE_SHIFT;
-	locked_pages += mm->locked_vm;
-
-	limit_pages = rlimit(RLIMIT_MEMLOCK);
-	limit_pages >>= PAGE_SHIFT;
-
-	return locked_pages <= limit_pages;
-}
-
-static inline int __anon_vma_prepare(struct vm_area_struct *vma)
-{
-	struct anon_vma *anon_vma = calloc(1, sizeof(struct anon_vma));
-
-	if (!anon_vma)
-		return -ENOMEM;
-
-	anon_vma->root = anon_vma;
-	vma->anon_vma = anon_vma;
-
-	return 0;
-}
-
-static inline int anon_vma_prepare(struct vm_area_struct *vma)
-{
-	if (likely(vma->anon_vma))
-		return 0;
-
-	return __anon_vma_prepare(vma);
-}
-
-static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
-					      struct list_head *uf)
-{
-}
-
-static inline bool mm_flags_test(int flag, const struct mm_struct *mm)
-{
-	return test_bit(flag, ACCESS_PRIVATE(&mm->flags, __mm_flags));
-}
-
-/*
- * Copy value to the first system word of VMA flags, non-atomically.
- *
- * IMPORTANT: This does not overwrite bytes past the first system word. The
- * caller must account for this.
- */
-static inline void vma_flags_overwrite_word(vma_flags_t *flags, unsigned long value)
-{
-	*ACCESS_PRIVATE(flags, __vma_flags) = value;
-}
-
-/*
- * Copy value to the first system word of VMA flags ONCE, non-atomically.
- *
- * IMPORTANT: This does not overwrite bytes past the first system word. The
- * caller must account for this.
- */
-static inline void vma_flags_overwrite_word_once(vma_flags_t *flags, unsigned long value)
-{
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
-
-	WRITE_ONCE(*bitmap, value);
-}
-
-/* Update the first system word of VMA flags setting bits, non-atomically. */
-static inline void vma_flags_set_word(vma_flags_t *flags, unsigned long value)
-{
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
-
-	*bitmap |= value;
-}
-
-/* Update the first system word of VMA flags clearing bits, non-atomically. */
-static inline void vma_flags_clear_word(vma_flags_t *flags, unsigned long value)
-{
-	unsigned long *bitmap = ACCESS_PRIVATE(flags, __vma_flags);
-
-	*bitmap &= ~value;
-}
-
-
-/* Use when VMA is not part of the VMA tree and needs no locking */
-static inline void vm_flags_init(struct vm_area_struct *vma,
-				 vm_flags_t flags)
-{
-	vma_flags_clear_all(&vma->flags);
-	vma_flags_overwrite_word(&vma->flags, flags);
-}
-
-/*
- * Use when VMA is part of the VMA tree and modifications need coordination
- * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
- * it should be locked explicitly beforehand.
- */
-static inline void vm_flags_reset(struct vm_area_struct *vma,
-				  vm_flags_t flags)
-{
-	vma_assert_write_locked(vma);
-	vm_flags_init(vma, flags);
-}
-
-static inline void vm_flags_reset_once(struct vm_area_struct *vma,
-				       vm_flags_t flags)
-{
-	vma_assert_write_locked(vma);
-	/*
-	 * The user should only be interested in avoiding reordering of
-	 * assignment to the first word.
-	 */
-	vma_flags_clear_all(&vma->flags);
-	vma_flags_overwrite_word_once(&vma->flags, flags);
-}
-
-static inline void vm_flags_set(struct vm_area_struct *vma,
-				vm_flags_t flags)
-{
-	vma_start_write(vma);
-	vma_flags_set_word(&vma->flags, flags);
-}
-
-static inline void vm_flags_clear(struct vm_area_struct *vma,
-				  vm_flags_t flags)
-{
-	vma_start_write(vma);
-	vma_flags_clear_word(&vma->flags, flags);
-}
-
-/*
- * Denies creating a writable executable mapping or gaining executable permissions.
- *
- * This denies the following:
- *
- *     a)      mmap(PROT_WRITE | PROT_EXEC)
- *
- *     b)      mmap(PROT_WRITE)
- *             mprotect(PROT_EXEC)
- *
- *     c)      mmap(PROT_WRITE)
- *             mprotect(PROT_READ)
- *             mprotect(PROT_EXEC)
- *
- * But allows the following:
- *
- *     d)      mmap(PROT_READ | PROT_EXEC)
- *             mmap(PROT_READ | PROT_EXEC | PROT_BTI)
- *
- * This is only applicable if the user has set the Memory-Deny-Write-Execute
- * (MDWE) protection mask for the current process.
- *
- * @old specifies the VMA flags the VMA originally possessed, and @new the ones
- * we propose to set.
- *
- * Return: false if proposed change is OK, true if not ok and should be denied.
- */
-static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
-{
-	/* If MDWE is disabled, we have nothing to deny. */
-	if (mm_flags_test(MMF_HAS_MDWE, current->mm))
-		return false;
-
-	/* If the new VMA is not executable, we have nothing to deny. */
-	if (!(new & VM_EXEC))
-		return false;
-
-	/* Under MDWE we do not accept newly writably executable VMAs... */
-	if (new & VM_WRITE)
-		return true;
-
-	/* ...nor previously non-executable VMAs becoming executable. */
-	if (!(old & VM_EXEC))
-		return true;
-
-	return false;
-}
-
-static inline int mapping_map_writable(struct address_space *mapping)
-{
-	return atomic_inc_unless_negative(&mapping->i_mmap_writable) ?
-		0 : -EPERM;
-}
-
-static inline unsigned long move_page_tables(struct pagetable_move_control *pmc)
-{
-	return 0;
-}
-
-static inline void free_pgd_range(struct mmu_gather *tlb,
-			unsigned long addr, unsigned long end,
-			unsigned long floor, unsigned long ceiling)
-{
-}
-
-static inline int ksm_execve(struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void ksm_exit(struct mm_struct *mm)
-{
-}
-
-static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
-{
-	if (reset_refcnt)
-		refcount_set(&vma->vm_refcnt, 0);
-}
-
-static inline void vma_numab_state_init(struct vm_area_struct *vma)
-{
-}
-
-static inline void vma_numab_state_free(struct vm_area_struct *vma)
-{
-}
-
-static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
-				     struct vm_area_struct *new_vma)
-{
-}
-
-static inline void free_anon_vma_name(struct vm_area_struct *vma)
-{
-}
-
-/* Declared in vma.h. */
-static inline void set_vma_from_desc(struct vm_area_struct *vma,
-		struct vm_area_desc *desc);
-
-static inline void mmap_action_prepare(struct mmap_action *action,
-					   struct vm_area_desc *desc)
-{
-}
-
-static inline int mmap_action_complete(struct mmap_action *action,
-					   struct vm_area_struct *vma)
-{
-	return 0;
-}
-
-static inline int __compat_vma_mmap(const struct file_operations *f_op,
-		struct file *file, struct vm_area_struct *vma)
-{
-	struct vm_area_desc desc = {
-		.mm = vma->vm_mm,
-		.file = file,
-		.start = vma->vm_start,
-		.end = vma->vm_end,
-
-		.pgoff = vma->vm_pgoff,
-		.vm_file = vma->vm_file,
-		.vm_flags = vma->vm_flags,
-		.page_prot = vma->vm_page_prot,
-
-		.action.type = MMAP_NOTHING, /* Default */
-	};
-	int err;
-
-	err = f_op->mmap_prepare(&desc);
-	if (err)
-		return err;
-
-	mmap_action_prepare(&desc.action, &desc);
-	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(&desc.action, vma);
-}
-
-static inline int compat_vma_mmap(struct file *file,
-		struct vm_area_struct *vma)
-{
-	return __compat_vma_mmap(file->f_op, file, vma);
-}
-
-/* Did the driver provide valid mmap hook configuration? */
-static inline bool can_mmap_file(struct file *file)
-{
-	bool has_mmap = file->f_op->mmap;
-	bool has_mmap_prepare = file->f_op->mmap_prepare;
-
-	/* Hooks are mutually exclusive. */
-	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
-		return false;
-	if (!has_mmap && !has_mmap_prepare)
-		return false;
-
-	return true;
-}
-
-static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
-{
-	if (file->f_op->mmap_prepare)
-		return compat_vma_mmap(file, vma);
-
-	return file->f_op->mmap(file, vma);
-}
-
-static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
-{
-	return file->f_op->mmap_prepare(desc);
-}
-
-static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
-{
-}
-
-static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
-{
-	/* Changing an anonymous vma with this is illegal */
-	get_file(file);
-	swap(vma->vm_file, file);
-	fput(file);
-}
-
-static inline bool shmem_file(struct file *file)
-{
-	return false;
-}
-
-static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
-		const struct file *file, vm_flags_t vm_flags)
-{
-	return vm_flags;
-}
-
-static inline void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
-{
-}
-
-static inline int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t pgprot)
-{
-	return 0;
-}
+typedef unsigned long vm_flags_t;
+#define pgoff_t unsigned long
+typedef unsigned long	pgprotval_t;
+typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
+typedef __bitwise unsigned int vm_fault_t;
 
-static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
-		struct list_head *uf)
-{
-	return 0;
-}
+#include "include/stubs.h"
+#include "include/dup.h"
+#include "include/custom.h"
 
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.52.0


