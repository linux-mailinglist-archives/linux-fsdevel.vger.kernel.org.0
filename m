Return-Path: <linux-fsdevel+bounces-75589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP0AHBeOeGmqqwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:06:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D62A69269B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CAE23017247
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23B22E8B80;
	Tue, 27 Jan 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CQg2cwH/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="etMvC1X7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9E21CFE0;
	Tue, 27 Jan 2026 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508368; cv=fail; b=t4WiXoMM5i42qnWU2fbWoatkN++jYmcWmC/nEP0FnydUvMMCCLBxBz2/jH7OtuLXaxJ4DL/8twAZehnIYLRQMZn3PoEhGPWVTxECbwyV5r07QJcZbIpjJLgLaXD9TilCDBehgqg84AR7sUHkm5BYbPZzUs9ZAsHhA/xykob0GWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508368; c=relaxed/simple;
	bh=nTyol12OZ5sJXdaN0h5mcvrrysbxePFquLCXKJs6CQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HgcNpqVfU/nWrpusAdlJiyxNeN3ttIWmFBTLScqtwJfHtNI8SySiREvLQUqqXIvRWKy3EUQtlwmrD8yEob58r9RD6qMEGbE0sHQWkhl06wtIhGDo3l9ZljvewDjbU/rv0pnATlMEYbV5tZJkkbgyN24/fGe6EWizDchsuLf7Pdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CQg2cwH/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=etMvC1X7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QLpcqT247091;
	Tue, 27 Jan 2026 10:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ATkijS+oHTz2pkZHnC
	MPzI1xUVFpO/mP5LSB/y+nhlw=; b=CQg2cwH/xYGXWuava+TEocs3/YxG5Mf3y4
	He3+YJ1bB8/LJwyP8aeAz3+grMXXFDL3rUnSWURspdHN272QueQkNVHGc4Yvoo6n
	1NEEhmndlWvhHUnZ3692xv5HDrNH7tBEa2Q8t5Y+8IeaBctXWncaJny5JLl+FCw/
	1WQE35gHfQYl4gill3172EA1ttlkDiuxi71QESmWsx0UaAO1HvHj6og7U3xIa7z7
	x42OpzAvjhWn0xXd/CQBGdkNvc+/W6mYIlR2rqpFNhzs8z9LVK7i3l5tlWajW44r
	aR+XdkR2AdEEL72XGe+jHScIpV+ArbDthWCUhC+N8TlagrpI0j2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvn09ks4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 10:03:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60R8dRYH010437;
	Tue, 27 Jan 2026 10:03:51 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh97a84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 10:03:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2o7L5KeGZ0p2/pnJpTwQuqMCNIIgDa7i3xIeDE9wkr/hRSXS0v9QORKkSW65nxcdRlKXqc9GFVm9c494XkaVKd8Ktob+2B4oirrcuWHxi6d0ERXeY0fhapUhPFxP+M+LnUcPALeaokWekYfYvRpjJoxNPmd3Q10MIfxfeQU9rZsm1PdcsmAi4FmHpRlZcfU9ljf8RgpXoFSRUyhgVdDXAZnUxDXCGgvcoCby/5X4sppTbN8sFDeMx55qOQxPiTGnFa83o0x2JF8H9B0+sVrYIIN9rUyPwTgzDBSCDs8BSErg5JZ+SqQVlOFw4IqvvSf9e0VESehF5BOmHqDxHQwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATkijS+oHTz2pkZHnCMPzI1xUVFpO/mP5LSB/y+nhlw=;
 b=wQomPcpJRyXwK5mq5OBb3gUyjr2k9YKd9o8ofQnaNNppDLKmQmJMunNElnC53gMqmBZaNucTTB29grNCE0rU1yiWmNR85W8rhf8zFEPpNHgUu1jjzk9ZcTZw3oIkVZ1G2mHzI5ThCQ7ZjA7/oFY4+cD+Ynelh98iHl5TeyIP6jD6XsEEL2IRqOzAXomUsJd8M6L3qZENJIMq/yfUKeXWqrW+1BNtfZalyzbsPi9tA6/22el39U9ryaBuewtw3B68BVtRbgMleb93vlO972MCfxVw0mt7CxL+kX5XxCM4t/ivFXIyE97ERurDSFtrCxKd7nwWKmT24UsCtu5ys5JWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATkijS+oHTz2pkZHnCMPzI1xUVFpO/mP5LSB/y+nhlw=;
 b=etMvC1X7xBEJbu9H9mIxnVclSjxba5LaRE5g9t4ygn1EmuDbuqUOr43fA1cPPAOKTCECOHcJjJrOUVfW3WSLaTvWm8uXgXHLeGqpapqsKIrlRsBVitjJAJC+qYoABEcACGdHUaTYjaTRn5LFY+AidcIt6S3jZGHs0aNsPHAJj4Q=
Received: from CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7)
 by CH3PR10MB7234.namprd10.prod.outlook.com (2603:10b6:610:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 10:03:40 +0000
Received: from CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9]) by CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9%6]) with mapi id 15.20.9499.005; Tue, 27 Jan 2026
 10:03:40 +0000
Date: Tue, 27 Jan 2026 10:03:37 +0000
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
Subject: Re: [PATCH v2 12/13] tools/testing/vma: separate out vma_internal.h
 into logical headers
Message-ID: <1e032732-61c3-485c-9aa7-6a09016fefc1@lucifer.local>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <dd57baf5b5986cb96a167150ac712cbe804b63ee.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd57baf5b5986cb96a167150ac712cbe804b63ee.1769097829.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::15) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB8215:EE_|CH3PR10MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 94743a37-0594-4b5a-5764-08de5d8b57ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EpTqK8Y4hCZxveBKv6z2efVWrjshcUzmIqicGe9gy97r0DM2nASsPqtB+cff?=
 =?us-ascii?Q?zLQ4HCu80W7z+KjuXPTp5m3TfH8A7gzp/Pi6odrpBeNAdFnTJ1rOhV0M6gsN?=
 =?us-ascii?Q?0M/+4i/G2VCKNMa8RrRRM4x6U51apA6YlcNR/LOa5TXeuS+Lzk+Bq33KKEmP?=
 =?us-ascii?Q?INM6pSd3lzXCXCV4QqSeTlQIWEL8l97ML+LadnCcYPrHrOE4PG2Hs8WYb1yh?=
 =?us-ascii?Q?3Hy+OVRXQ70CdIlcxy1nghRNs0myyKVWvHDn0KtyknS4NxxAhp+t8rzfGIPp?=
 =?us-ascii?Q?Nk/MFud3E0iVKY9YHGDtQM8VCYiWh2kAfb4YS+dl16vm001E2jVcaQPVgwp9?=
 =?us-ascii?Q?8xDg6nN4ZxIiI1ajSB5OSJlaYgdqd7PfyTowbk2ykJSCF/DZYstNXRdLmYyK?=
 =?us-ascii?Q?5t/7URtU+bWE53evADzBDbcCqiCCUwZDRpJsv8yYSwMVaWNedpaEhghNsSvE?=
 =?us-ascii?Q?Dils8jGIljzRtdM6mITHdjwyEETkP+j4/YtQXZHT2MgPyAvErmwXxFWmgnxY?=
 =?us-ascii?Q?zaQpgdXBO0nkm68EIl4nBsIgHrpozV+SeRTC/BWQre0kbKatFjep52YKILvV?=
 =?us-ascii?Q?2b6cRsPRuQEFZAPNhoYuQT0ZBdymMxc2+pTxDr/GvyIbRM4lWHzxKhMn/oJ8?=
 =?us-ascii?Q?bQi5AyMW8PbbrXjpiyvgzlsi1fxR25x8hZR4OEoIJKZGceWEU4wrU7QcCP3D?=
 =?us-ascii?Q?JrMQOZ57z7ntPzj2KaAnblfFfCT8UltLD2WQDoLrcr3Bz3v4hjTsqiBvhGSd?=
 =?us-ascii?Q?DhCblgRSu45duXexDrVMyWffZeFrrc4ACtUkP88LvAd0ikkEwS16DHopEhqO?=
 =?us-ascii?Q?v595OE+MwogpPY6EnatN6ClWwEi+IKvI6DX12D06GdOaHLMgWgASz2wKh+YI?=
 =?us-ascii?Q?B5inA+L3pTfRiRV3JAuT+KpDB1ITGEKlnKQMdgiGSCpYv/5yKEeqBTjFcy4N?=
 =?us-ascii?Q?QtBBebgFs1m6At+sXqul/XCVHUn1PU3qLLAXFlLXb45MmpJW8LD1fMaOoAkq?=
 =?us-ascii?Q?1IfL/0HPpL+un3HaqsT2fwmfNz9JEGGQXZWIl2TT3h86QTK8XcfMyclmytEm?=
 =?us-ascii?Q?mikwbS7kfKNK4xeTWYoc42ysGWSk5DyMaD9KSA5yR18lLXdO/XU/kpJvZhlJ?=
 =?us-ascii?Q?l3rjhjaX7ATRaQmzBeLtYBUK5D6F6TPCx+qShOcWwLMtJdiyE8wOipFyYcYa?=
 =?us-ascii?Q?wU/ralMJFjq0U/kezzuuzkEIlHXdjA6GtYaigrZe0Ur0J+6UTB5SaGN1+aPd?=
 =?us-ascii?Q?NiX3bjfD9ygEBUQzuYSJ2aiGN9/JE6jkbrR5aCoTnj5kHqCLVAD6KMOykbLD?=
 =?us-ascii?Q?utnpDtL4FZdEaRpqpbyLXmlz6TatAFwC3R9avAhUdTQcSE1GuD+/VXDhfiSZ?=
 =?us-ascii?Q?5a6KuKJlKvlUYenAI6h7q48d5AWkGAis2STbev100OWQALrirRkigcL9recP?=
 =?us-ascii?Q?nU2Iq3Gpx2AYKQWS8JNUt6eTssRZ+EaPoz+0vi7HMg49F9457qeaXv4skcsr?=
 =?us-ascii?Q?MkCoErwa5bvYN2puPYflzvYqpW/3jg104eNvtpca1jQ8ktp724tAvdtWFOnc?=
 =?us-ascii?Q?oUxXKgQ4EADdukb8hrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB8215.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ui99UDGVonf5yVooQu9qz5XQknsDGbze65WXiZZgErkfPaq4mrkvYY4J9flg?=
 =?us-ascii?Q?PF1CoBpnKFTjD2gxWU6MDpYR9A52zRXW7cxjziTb1GXZfO7rZ646LHiABC/l?=
 =?us-ascii?Q?WR2qQYWMwvAVOYAsuFHhXlknvBTnQfutyBoPsIGRtWF+AwVZykrMtr5B2UHj?=
 =?us-ascii?Q?TOznANoVXc2XzESdqqOY+KThIpA5UCfV6jJqtt6CgUcGeLymP5GQl7h7G0zc?=
 =?us-ascii?Q?LMXmmPqA5vDwAbFh44dwHQWvtvCdxa14++X+IcJ1tPhgO0ZkjCBNdwlp876c?=
 =?us-ascii?Q?7Z/4BoXJmJIdKURA4Hu6SLnLsamBJJkmQGDafTwOEShYecAhjHr9Eehwy1Oy?=
 =?us-ascii?Q?pAVpzStX2hIIceWHj+VKCXuy3HbCoVbSO1EWy50abFY0dInp3JsdmIVTP37M?=
 =?us-ascii?Q?CKxIm5nes7CN+0KKcFJfzNdkKQHjCOY4umXNEHPDK9WddLxPjPuGBi+5JGmo?=
 =?us-ascii?Q?uDWO7K9rMY1wnu2tzN20PtKMiy4zCpEGsQxjVyV5mRxZfNkQejB+9Cz0H0Fp?=
 =?us-ascii?Q?g+KupyexiQyKsx6ki4PJpj7+CQsG7/FT6It/Rd6z3fY0wrOLIIosVVRirxUi?=
 =?us-ascii?Q?B/IPF1hQX0BHyQBkhw+X4wLzNKdXbMoE6ED7AyM5KrkB5MUYQymsKtmI0lPI?=
 =?us-ascii?Q?UnGKamHKrDepn+iaVnwoOSiOFCdB/QWtoek6VHgMBeBsamrl8GxS8jI6mnXk?=
 =?us-ascii?Q?ZdicNOVVYzn5rjnCj0hsQoyeK2CMooBoR97cTaQSkPLN7sujZp3X54QKXqJ8?=
 =?us-ascii?Q?kA+5seynWmLJYFOUcZLNM62IwzQrjQr98cO0Qu6NjWF1hICHgkqkQiKmtbHA?=
 =?us-ascii?Q?D6zfwdGSp3SKgd6XPiA/d2PS0Prv9rEYqYtpGkMsVq/nkPPaICUSUPwB8OSI?=
 =?us-ascii?Q?miEBXJjWDyquQ5fUJ9aXAX6RTqYBSeQ9yr51vwa3779GfW+kI0wo+uPG3z8e?=
 =?us-ascii?Q?uBvP6AhK4MJA5XVX6bpoviqnBg3D28yBkBcjd7tZX6+vsKtgTUIFf/fsMVaA?=
 =?us-ascii?Q?EcM0LykcslsFqGdZgMc7J12ycHpBSuMvxpHk/UXLWhcqbSlZfnTweDtKmNdj?=
 =?us-ascii?Q?FJPj3JRySdpW2TkVok8Pi4SRDUXDy2lN8ZvhyotgpaxCmgbQ/itHeek8cVYF?=
 =?us-ascii?Q?uC3+v8iJt0uyzxk6e6AUlGLNTu2Xz8ob/wQg4aJJ5sClTWBD3gRHXz0JX6hm?=
 =?us-ascii?Q?43wRH+g/GCEb6A0s4tBBJtlmzo8ANKg+9eaMSYK/qLUiXGt6g4MoDQglxasG?=
 =?us-ascii?Q?YF49q734FiJ4cnnqMZQ9H/dyFdC02wvl06XFO6F+1LpAldjd1dBaGNffx53B?=
 =?us-ascii?Q?0GaWcDROFW3vtKVckYqX5wtO0ZBZtlLVkAQITOhmxQhOs15pKTdYgBu9QaJ8?=
 =?us-ascii?Q?bWVyh5jbF6eJ5PeEFuimix1rESkvq/FIkgMOmO4Lzn5H/4UQTpj2lEBfxo5s?=
 =?us-ascii?Q?M6rioDOougdL860CflME7G9c0VSHKWVC8tLK6ssDE+aYD8Rgsj6JZJaTGZoO?=
 =?us-ascii?Q?6LpKkJKaolbZscxr7nwrkr2h1h1FlqXxHO3w2jGriTsq/gxjJpE+9oRSaeX5?=
 =?us-ascii?Q?uKlmXO/mhal02xjdfMBCYP0yr1eSw3WNxYpCsJg/UgEf8hg5lT/brUeH6avc?=
 =?us-ascii?Q?SZu3f8tz2JDPbpzlQLB8ruWbfBQTTIg+AdUV5PmYppSlg9gGWXgjsZGd6paH?=
 =?us-ascii?Q?6yfKj14brhyZjCWkjP1GyH5AxLtdTrjd90o3F22yLUqUwpAEO4xpvrJduwiz?=
 =?us-ascii?Q?pCBCahLXSv5NSZ73Khy5KHGNQkq2Epg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AuuP4K6F4M99NqfWIXSqleOqIQD830sB7M7hNDoZ6RY8k2sfBgpUZPaEfqJiVUEsZj7ovST7lbWHJL/L4zfMS8JWVSz+6eDAY6aPcOqyvpXHkyggIXNrDF8Ywvak5DJ5+kEqtUU6HE+7sp84GyEW7hTzRUNGLcZP6NzALl388v8785Bbu3Gz5U1T2D9yvzF+CN169veIZ8RA8r4lF//v98pDP0sDMl9hkVqyYE9bQ47Vys+z9B6DmuziRUnhss4Rzv91ndh4AhDT4aK6yZs4tatvBTVFSHNFbjyGQCPAO+gjC4754Y5Ly71O2sPEi2cuN7acBQUsGrgOStTBTRbgHIvYXeQ/jMPrmp4WwFj4kwTgLaVYXgZlz4rfK91MdcdHAdp+M51TzOQ5jagRnoJLNAqymRM4mTcCiddKeUw5Uh51b7MgM/APoKBiBzLjepQA0ryEo84dVo5wOCPEmGnIDqcmo2MJaJ5T7R4vAGb+vl6Ci9eHHGb+4CiOYqKFrYnW7kzjl2cHfscQzCdljjW+n9UnF57eJ4cFzG5u6BcuNcr0LbiMmuH3pwWdX40UoN+lzuY51WeFa4Htt2mlm4oEtb2op+gEJ/p0W6Qay7H5Jo8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94743a37-0594-4b5a-5764-08de5d8b57ec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 10:03:40.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DRc0NQallHrLLPuAJ3mYFq990hxCKNZCcJ5rOrSNt/40Zh6DtZvKxgIGJ36bKVthwKZgC7XW4VU6dHyOE622bubhZu1OImdZQ1qQvBRbUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA4MiBTYWx0ZWRfX7jMY3NqMm+0m
 7Kyrp+0qdJEE5v+o2XjHqYiHj2I+vkqWK490gJCeEoX73v/1jC0n+SFgqyhgb9PXgRlplfjhxJA
 PAuwiTrfHAXgQJaJfo0zGemQbcglmopw88vfBjpZo+5Yas5eeMGT6gxcc5LQmq6961WkPlPl1A4
 pvoImPeGMKPgypnXPFSjl0K6HaDdXPCIj3/q7KrWLV0IkqGrjAJitH6BWC4SO2SyAC8jQuIV47K
 G2d8CHYvU+oc2tlwREj/eUW5WaGV8E0vnkVgPS/4dys0D3dn7kerTAu2Sl7g9HSAZjEApg2gsCO
 XIXVAl8TXXtQyQEXIlTKbT7O5n8qSeGGHrIwd90yY9bglDFF00QFEfmwjvLC4Me90up3WjJkbMS
 UTJAv+OjejygT2KwUmpcsDbltvPR0Wb2X2dEZ1dWQv+YRqZNjXh0rvH1tJm0XvSdy1+fNWLKbJF
 9HLB0ptMc68tm/tjjgw==
X-Proofpoint-ORIG-GUID: 7YLPGiOyk9ytNll2IzsmIMxT5j1wLI6x
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=69788d87 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=xL-mWBlC858c6hyJi6gA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 7YLPGiOyk9ytNll2IzsmIMxT5j1wLI6x
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lucifer.local:mid,oracle.onmicrosoft.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75589-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[93];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D62A69269B
X-Rspamd-Action: no action

Hi Andrew,

Could you apply the attached fix-patch to avoid a duplicate struct define as
reported by https://lore.kernel.org/all/202601271308.b8d3fcb6-lkp@intel.com/ ?

Thanks, Lorenzo

----8<----
From d19e621020697b25d70f13ffeb2b0eb46682a60d Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 27 Jan 2026 10:02:00 +0000
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/include/dup.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index ed8708afb7af..0accfc296615 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1327,15 +1327,3 @@ static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
 	swap(vma->vm_file, file);
 	fput(file);
 }
-
-struct unmap_desc {
-	struct  ma_state *mas;        /* the maple state point to the first vma */
-	struct vm_area_struct *first; /* The first vma */
-	unsigned long pg_start;       /* The first pagetable address to free (floor) */
-	unsigned long pg_end;         /* The last pagetable address to free (ceiling) */
-	unsigned long vma_start;      /* The min vma address */
-	unsigned long vma_end;        /* The max vma address */
-	unsigned long tree_end;       /* Maximum for the vma tree search */
-	unsigned long tree_reset;     /* Where to reset the vma tree walk */
-	bool mm_wr_locked;            /* If the mmap write lock is held */
-};
--
2.52.0

