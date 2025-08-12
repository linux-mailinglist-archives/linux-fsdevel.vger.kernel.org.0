Return-Path: <linux-fsdevel+bounces-57553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACCB232BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D807B1897460
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF961D416C;
	Tue, 12 Aug 2025 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A7U5T0BZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="amhPi3u/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12352D8363;
	Tue, 12 Aug 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022574; cv=fail; b=DYXYPnhRBtBPAdUygBX2IxcS0fHKW3Ido4S8VZlimQZPDhxTJ3nfELdGdNFENMTitj3gBau4XXYWw+N0sJy7EF6JGlFpw+mJbiUj0Pk6vZj0ppU8taEpEJd+afl1Az4vGhk06dWRufWssgBDAiGjHX4VMVlKa8B8izLt7gTIFjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022574; c=relaxed/simple;
	bh=7ESvg/LkIWUIeYWKIFVN1gG2yTfKK2vt92NaJ0MjyzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qSMhrItTgLy4hC34P/RBZakdykNtnDQTI9YVYZRsA8c9xUoecUyvOYRN53wSpkutnO2GSn009EJm/6K1ihYcjKTRB2ICXUlXR9vzDPHEl+8lr0OnHXu01FZiLxI+A3p460J2IoIGx4+NRJdK3di0yAoeeoMS6KFkSjcilQBle+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A7U5T0BZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=amhPi3u/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBxJZ005442;
	Tue, 12 Aug 2025 18:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=v/AKrkerpeKb8wxyWB
	bLojPfbnESsK47UPNkKQdRQBY=; b=A7U5T0BZgOBOFuD17g6/tHPcFwG//ysF1u
	pGenndBpUcTS7xENzEco1TBWhd0hdKsnz4LlyJJBM1QBlj+GPsmSL/jIl4xNjgFC
	Z0Ja9ClNN4ucrtIJSifbV3qU3DhpugpTR7iQtWGJoV3DCcEy1MqdPzlnBxwTci2M
	vFcY3boYzX8KCs/vnJ3e+Ypa95C0GmT+MvZm0ttBTmLNKlD4Cr8sCTbCOlpUjpKl
	1VhuAD3me797b1oJhLUcD6GLuJzEhYPsyeIdKyZidYZYGKE+yCmyTP2SJ8DBaLUx
	LP3Yndb1IELk6PGWcbd5TTmiAnbC3imUXdt/Ft1KpEsaW08VGJSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dn86q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:15:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CH1LLR017385;
	Tue, 12 Aug 2025 18:15:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsaarau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPmuu7Ic+Gn0EZSHv/4wSr8UOV6nGjaZGJMj/ccTi+Nvb31+ZYulH86CG/SOCB89do8mib8t0OQBlXx3vgBBxbrYEzIiVwFZ9/z3Q/5w9IxYHMGpmwOi3TlRrFJ5Z2IjrdkKwhcMHkpHgekpX6Q/GRDzPBlfJZu2JfJIvooIXNLo1x8V1XBOFZbt+ecuBMQ39KS6QRNJi2UDeRzWZoXscTp+zGk8zuqtxyYHuEG7aetmXKIUkBVSuUVHG7a+oTv1P6ujIzSB25I0oAgekYiXLT6OtgE5UwrF8LyQiF2F9A3Otk5ATzJP5O/HMNbth+doRliniyM7EQgFcltII0qJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/AKrkerpeKb8wxyWBbLojPfbnESsK47UPNkKQdRQBY=;
 b=E6tcC8wXwqHjyGAECBaiR1G1STp6z5pc++gUUjbiABtKG9YwRPAOikZUHtfrp6xzjXHKh8RoChHAE5ldxOgNv4cN9cHAaZ2xfvj/NQxI66abQp3snDaidvQPc/a61l26BB0SiadCNf46Pt2UIK6XiP0tSvl4heDy51DMxaS90+NNmlK7P9DNq+qPOTnITCsrERGRq8iqfRqglXLtPCH6Kkt2eAgSbdCe8QJjPf1K7Xmq3yisYU87ShVvT2Paw3JnEJCYB4vVkRc+9niI3HGhbOgrwwmXpYCW+MxqQHLGsRMcxekhrJ6GruLXndcVIwOI2lb6mZmdP9sMeHmJYBChQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/AKrkerpeKb8wxyWBbLojPfbnESsK47UPNkKQdRQBY=;
 b=amhPi3u/VQ2Pdu/3xBaov9uPN4b+0CT+9vEpk7gcssMjKGEWK3I537nTH9d9EgsE2t94vLAR2Xtd58CLOkP9ny6FjYCjP57Z3KY3Y77+ECwVJp8zfYnZ5t8vugd8/rL2A6eCSRnxZz7lkdmWUp7gr7LYt7+IRcl5cwHY40zZWsM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4744.namprd10.prod.outlook.com (2603:10b6:510:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 18:15:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 18:15:04 +0000
Date: Tue, 12 Aug 2025 19:14:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 05/11] mm/huge_memory: mark PMD mappings of the huge
 zero folio special
Message-ID: <511317b9-7155-40c7-91e0-faf134622b9d@lucifer.local>
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-6-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811112631.759341-6-david@redhat.com>
X-ClientProxiedBy: GVX0EPF0001A046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::48f) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4744:EE_
X-MS-Office365-Filtering-Correlation-Id: b335b214-0913-465a-4daf-08ddd9cc28d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMymG0V27K0l2/9ZZj+4MboP1zKVNbFQyRpH+20gcAErkeTFY0vnERB5XhVI?=
 =?us-ascii?Q?+Gi4IXtJ+ebBGs/25KIrlkBftedx9hfwqH+1lqNUmLeGpi+2DFB9WTyHXtz6?=
 =?us-ascii?Q?FOsu2vNLXuyC1xPt4vFw2dTpbsQezQObIgRO7HvOyaW+EiMguGk05KhRJnLz?=
 =?us-ascii?Q?jDOK9pBkRPRNb4Wkkcf8S+PDDBicCPJPsclFgvS8a0DDxgwVdHI+rxXcD8pp?=
 =?us-ascii?Q?if4OVUjAE4ocRZV8ODgFZ2dZlGX43OVDp8YyGs14HCQEYzBkIDzLvFudkPJe?=
 =?us-ascii?Q?NJJNzl+gis+azwsUJarUEtAd7A2WdJAJGssJnUQUtqTsWHGBn5H+DVTxB6ng?=
 =?us-ascii?Q?fmlJ00IP83b/NflFiC6Eo5NU7fjrCNqd14EnuOW0AC8BY/piAs4POjUkvAvY?=
 =?us-ascii?Q?Kh+2RtfUXaN6Qcw5JocENvUJz+u0qZ2nwnqoRZkbjsZCaiFeXac8o+75upb/?=
 =?us-ascii?Q?xoRJr5q+tos24ih9Yq2nVo3hJNUwHdyV5C2ODoGwfgdXrHJvZSwGCnBXUhdi?=
 =?us-ascii?Q?SukaNQmwEZgr4g0llNkQOSlc8R5VskoFKeGQAC/Uo2nhsKw5gSv97iytt5y7?=
 =?us-ascii?Q?T1gaAuszfMMI4hA8LCl7McrPt+JLG9EAjik+8HnMDi9JS2Cz7+Mhq91vH5nr?=
 =?us-ascii?Q?K+rWaAQZ1z/J0USDGJiCWSi5paUTAysCcrUpYPSfQhFaSGNLMepnaYH70/ht?=
 =?us-ascii?Q?eWCBOqtS0JXXDkh5dRVSRlyH97amXHAW0lNSbsfIsrHdbe327JxIM/Jc29Dj?=
 =?us-ascii?Q?/LVx2JGCYG5P94LPU/IiTvpDHROJkQN5XFVHUMHLomSqPDBUXl0eADoAaW75?=
 =?us-ascii?Q?gTPN/Q6Q2yMDn+g6ndRKzRGJOIM9TAkWgROzzihub57sWS35jG/cwoltZBQF?=
 =?us-ascii?Q?ZlanGmBR+Rn3MPSpnEtwW7qjKckw4BSfd7FPanKC0pWqn1LIkVy/hiJ77GGW?=
 =?us-ascii?Q?tKSQTyxBVx3GpWncIless+adKnCUaOiKy+l9+E20JO3ehW8JiJ5ui4M5//pz?=
 =?us-ascii?Q?zzFenbmzY0IDXjEc/s0LLv2My3chfUB/e+FvfMMTN0htZC/qylfdGsRK1g3N?=
 =?us-ascii?Q?UFPc9e53/CF2RI4hyOo653Q0Y5MHK/1rAgXSaHdHmTxZkrhcH4qDw4KzaO+7?=
 =?us-ascii?Q?n+o+pGPURfqfDtz+wH97ZGolLFSuLQyZyhjYelfL1h2DJzHkBtISfIHalsYU?=
 =?us-ascii?Q?Cx+5Ki9xL2IXkIbO+3vf3n3BZCUQJDo9Vgqel8GO+VkHKTf5X/XM95tR7evz?=
 =?us-ascii?Q?YFj6HD4Kk6XD3N/Kn3V5Kff6nXal42nH/8mC8FGk51FAVUdW2RYmmaJoi5Nk?=
 =?us-ascii?Q?KMhtWD+L3fe6t5LwV7yR2xJznJtC1Z6W7/WHxGB1/1QpnmYroSuYorD1k2Ge?=
 =?us-ascii?Q?/TG34ZEQxrgGIE3tUjmCFhgRxExxGP54m/zD844LHWsEgsZOelxXqhwjFuUo?=
 =?us-ascii?Q?qo2BT78aH4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tp7l9ZOSzL404BPsv7DRUVRtaVa+OWxKN0HUDCbfJDEqIyK/G789CiC6T0gu?=
 =?us-ascii?Q?lziI+o1FgapymdkHFE5DF3mJ2inle1FI3YFr8mVDnWKNLuX4M5pDEECK9f9F?=
 =?us-ascii?Q?Tq7v1RlioPX8gUhEPxXfCa0+EfabxWAhxBqHzDG/bGh4uaooLDINGPGPcBG5?=
 =?us-ascii?Q?AzYY8LNMdrF1x5ET+WjmZHhOxNfhPv6E3nJJmSwA8QGWARWn0BQq9gaewBnd?=
 =?us-ascii?Q?8x1ooYqjPhGYKwOTSsdQwhYdAKOn6PenJ6L09XcSzQAl2HBjy4068Gi6sKBo?=
 =?us-ascii?Q?zs46ac/neaAU4K/Nt9I/BzFv3JuqJ9LoHeHz/+yLoNo9nAmrt6sh3C+4/sJS?=
 =?us-ascii?Q?UHJacmeMGQQ3Ac/DqNOjE1HKdoofpDgnRIrkdTSywgNmUfTjMJ0hwQUxIXHf?=
 =?us-ascii?Q?Y4MLciwtA/s5jkOIZZiL7RH+L9U7IuRpO3V2N9Ip3ThNDDledZ8I9SHHcE7Y?=
 =?us-ascii?Q?G8PoVa+7Afj8pPJQguC0FDOWBRh12y0lC1KonVwQH/JeHSCryqsfCakWeD2z?=
 =?us-ascii?Q?hdrYCM3L6xc7cCne4dNLgQfIdpL8h6Uo30ZLXINxZQGOJCEsdLwyGpBNZ2qE?=
 =?us-ascii?Q?F8OESXniKqhUozpID3GL79O2/kI/Ppx+h4fQzOMH8LyUrVP9M8ax9Ak8KS5V?=
 =?us-ascii?Q?641ZO6zTPhIYkK5WQptYfTbA/05Zm2vUXZ/hNios6xsaVs594K3/r9IixK7M?=
 =?us-ascii?Q?6S9lv7pjRyhKcnoLzFP+QJbsXhaAegckdzzsx1KF5Sh8/fayBXF6PnekDykC?=
 =?us-ascii?Q?p20v+/qNAsuEvAh+rY+2ycYXJkYJPYpoC5TkoYjWKee3748LaavXnx+GnmaG?=
 =?us-ascii?Q?18irb7kfqXxFfNjjDMK5Sq+uY7SEFRonHuua+CYpGdL+vacjG9QJR/1AGcsw?=
 =?us-ascii?Q?dj9uCWq/QMxhdq66yN+ASdW/hJWP8ZUR4pFKheWTgtTIza2m8soelxxohGn8?=
 =?us-ascii?Q?YiXbnQcf3mCHvGm1dXNxpEFM43x8v/Iorq8ZW2vsJxSQDHe3SnoSR+9WVFTZ?=
 =?us-ascii?Q?UXjG3X40BUm1jqA2zpkUcHQ8CiXXf2YlxM7kREOMYp8eSuTxz9AOHmP3DE8N?=
 =?us-ascii?Q?3r3h7ewJO9fPa03HvW742CMcoBtSKBso9DoOjh1Yl81/eyek78l03hPIDe79?=
 =?us-ascii?Q?FG5BJYjhXiXDefKGwGvFHuv6HQRHiBWLfOt5sJN6Etf4+zDd5kdsVfaEadtu?=
 =?us-ascii?Q?ymSvmxAmv7jjcVJp52iMuVivxHC5EmK94GKyAcZRdTKrb6/z4DPlhO5dELIJ?=
 =?us-ascii?Q?8BN/zJyEQm3mnI1A+iDbxhYthePlr8p+NNePdkPPJtm8wPlN28M2ZHBMLelP?=
 =?us-ascii?Q?qy4QgFTMDHVlKk7K6IoO9QJeoyzx1v8Vb/nmxdxb/IOVPFNVE5XR06/Y3zte?=
 =?us-ascii?Q?NRZHQN4o+r7d3ojkm+aZuVj6j7R4/uPFGy6XsXjvb5yIIHCKVkKCA3bHnuS6?=
 =?us-ascii?Q?nmoY5N0qhIbzU+YybBQqrUoMsN3FGQWmo6G6mXkOjK0zC5TeeUqSJ+8K7pY6?=
 =?us-ascii?Q?OZkVzBaSBIGoxNeWSXFjkgzd+aSitG2QACL6BmRB3vSA085YTfTyODd0QdnB?=
 =?us-ascii?Q?JT5UlKgUxB5vqRJYX9h1g5i56IHWv+Vd5JeKUp/1Dmh+nh7p8oqMWQurpcoF?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iYnNSPu9YTKkbldaUSFfMmrTQ+iu4XNtXU0KoaWKNoTlIJAHkbGxUnI8Pne4JJ7oKJKr1/QU/zIqDcdesnZBtJtDJnShYWj77lgzo0Sv1Ea0jGy/D/io+aLyGizCqpsxBFq2wWNDHpPVDzq4irZbOVIYM+pclhRxMjylBxlF8APJAxH0Kbtyshm+g7YSEp2CSueS82o/hTGt9nA5MwNWy5Pkf6HpmLt9KeHAMczpGmddSx8a3B9kfoYDuYHfC508SrYQyxMtDnDO9E25WoHcipSmO+oKlPTjnKcfo2b2/eAGM320pClCMf0QtdN7VH/aOl0ra+erqhZZrHdjfffR2Xoec4kkDcJUIvZQOGyJGcWiS+x3T/Yk/tFC38Jde+6eelcdFw7mWD8qldHCPvGYa3O9udIhq/XlTK7P+rR2m2j1s7QQv53T8C5yrrPG+dALRYsA0f5xuaD+nvkGp+BZH/7++5p2aL6WCvGWIY1hQY7yc5GcYLtQMHxdytmMtsLxupYYGMTSspNUUvL1S+W3XnP5Hwsh5rTDFb6QL6cwpa+dcGgh82VWI+6CoGaMZoh1nbUCkam6eJALDkpa+J6gilTYaekSWTxDmVpfccS9CFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b335b214-0913-465a-4daf-08ddd9cc28d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 18:15:04.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldZ+m4aQ4N3dt5m+lDX9Ax4aJNeTYPrEEcBwp81xt5nnpYYAQGgJeBIWxCqGO6HBrDnNzeQpJSo2/HutijZP/sdOmXvTTH3kpkqem9BE92A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120175
X-Proofpoint-ORIG-GUID: NKcoa3qSuGzEFtFsXdII5yncmscdT4Aa
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689b84ad b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=pssIr5Eb8AsxVtukJnQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NKcoa3qSuGzEFtFsXdII5yncmscdT4Aa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE3NSBTYWx0ZWRfX65/xqYCuka0P
 S11Bp+J4FoBSyGI6DrU2U5M3I//JUkRALYzU+A1H2uXmbumfjX7VJTYN0BNnEAjrurpn8ydWm0O
 D37UfOuF55ptmgW84Yq7XkmtO+7CUAaK7C3b2OBRyMiwXHl+DoW344wUFp6ApMoK5+8ZKbmn+2K
 9pR8N/d6A9E5GLoEPfXjgjymKxwEoY8LbpXGmy5uo+B7subW5eaYznd6Ehldyw6aq4ZymHeUi9Q
 QPCqfajHJEnUSEOgPyMUCWTkLnztSy9rDdyBQueQajPr3z3JKmBRUYUEiPmsM5MreJbJ2pYu9Aa
 JJ6/2svjqAEN0DNCmBwu2i1GjCpwjO+QXHIrG15kbyTkY0Y5euCajbBZ27KNZoNeGKMlCWLv4le
 FTDKu2lm2j+BMg5rgQc88zo9knQ1r6OvqYeC/sxwXYmTrgs54h2LGyN1jay8Gpk50FKjNP00

On Mon, Aug 11, 2025 at 01:26:25PM +0200, David Hildenbrand wrote:
> The huge zero folio is refcounted (+mapcounted -- is that a word?)
> differently than "normal" folios, similarly (but different) to the ordinary
> shared zeropage.
>
> For this reason, we special-case these pages in
> vm_normal_page*/vm_normal_folio*, and only allow selected callers to
> still use them (e.g., GUP can still take a reference on them).

Hm, interestingly in gup_fast_pmd_leaf() we explicitly check pmd_special(),
so surely setting the zero huge pmd special will change behaviour there?

But I guess this is actually _more_ correct as it's not really sensible to
grab the huge zero PMD page.

Then again, follow_huge_pmd() _will_, afaict.

I see the GUP fast change was introduced by commit ae3c99e650da ("mm/gup:
detect huge pfnmap entries in gup-fast") so was specifically intended for
pfnmap not the zero page.

>
> vm_normal_page_pmd() already filters out the huge zero folio, to
> indicate it a special (return NULL). However, so far we are not making
> use of pmd_special() on architectures that support it
> (CONFIG_ARCH_HAS_PTE_SPECIAL), like we would with the ordinary shared
> zeropage.
>
> Let's mark PMD mappings of the huge zero folio similarly as special, so we
> can avoid the manual check for the huge zero folio with
> CONFIG_ARCH_HAS_PTE_SPECIAL next, and only perform the check on
> !CONFIG_ARCH_HAS_PTE_SPECIAL.
>
> In copy_huge_pmd(), where we have a manual pmd_special() check to handle
> PFNMAP, we have to manually rule out the huge zero folio. That code
> needs a serious cleanup, but that's something for another day.
>
> While at it, update the doc regarding the shared zero folios.
>
> No functional change intended: vm_normal_page_pmd() still returns NULL
> when it encounters the huge zero folio.
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I R-b this before, and Wei did also, did you drop because of changes?

Anyway, apart from query about GUP-fast above, this LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c |  8 ++++++--
>  mm/memory.c      | 15 ++++++++++-----
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ec89e0607424e..58bac83e7fa31 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1309,6 +1309,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
>  {
>  	pmd_t entry;
>  	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
> +	entry = pmd_mkspecial(entry);
>  	pgtable_trans_huge_deposit(mm, pmd, pgtable);
>  	set_pmd_at(mm, haddr, pmd, entry);
>  	mm_inc_nr_ptes(mm);
> @@ -1418,7 +1419,9 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	if (fop.is_folio) {
>  		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
>
> -		if (!is_huge_zero_folio(fop.folio)) {
> +		if (is_huge_zero_folio(fop.folio)) {
> +			entry = pmd_mkspecial(entry);
> +		} else {
>  			folio_get(fop.folio);
>  			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
>  			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
> @@ -1643,7 +1646,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	int ret = -ENOMEM;
>
>  	pmd = pmdp_get_lockless(src_pmd);
> -	if (unlikely(pmd_present(pmd) && pmd_special(pmd))) {
> +	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
> +		     !is_huge_zero_pmd(pmd))) {

OK yeah this is new I see from cover letter + ranged-diff.

Yeah this is important actually wow, as otherwise the is_huge_zero_pmd()
branch will not be executed.

Good spot!

>  		dst_ptl = pmd_lock(dst_mm, dst_pmd);
>  		src_ptl = pmd_lockptr(src_mm, src_pmd);
>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ba4f6b718471..626caedce35e0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -555,7 +555,14 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   *
>   * "Special" mappings do not wish to be associated with a "struct page" (either
>   * it doesn't exist, or it exists but they don't want to touch it). In this
> - * case, NULL is returned here. "Normal" mappings do have a struct page.
> + * case, NULL is returned here. "Normal" mappings do have a struct page and
> + * are ordinarily refcounted.
> + *
> + * Page mappings of the shared zero folios are always considered "special", as
> + * they are not ordinarily refcounted: neither the refcount nor the mapcount
> + * of these folios is adjusted when mapping them into user page tables.
> + * Selected page table walkers (such as GUP) can still identify mappings of the
> + * shared zero folios and work with the underlying "struct page".

Thanks for this.

>   *
>   * There are 2 broad cases. Firstly, an architecture may define a pte_special()
>   * pte bit, in which case this function is trivial. Secondly, an architecture
> @@ -585,9 +592,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   *
>   * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
>   * page" backing, however the difference is that _all_ pages with a struct
> - * page (that is, those where pfn_valid is true) are refcounted and considered
> - * normal pages by the VM. The only exception are zeropages, which are
> - * *never* refcounted.
> + * page (that is, those where pfn_valid is true, except the shared zero
> + * folios) are refcounted and considered normal pages by the VM.
>   *
>   * The disadvantage is that pages are refcounted (which can be slower and
>   * simply not an option for some PFNMAP users). The advantage is that we
> @@ -667,7 +673,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  {
>  	unsigned long pfn = pmd_pfn(pmd);
>
> -	/* Currently it's only used for huge pfnmaps */
>  	if (unlikely(pmd_special(pmd)))
>  		return NULL;
>
> --
> 2.50.1
>

