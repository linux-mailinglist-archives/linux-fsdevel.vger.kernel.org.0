Return-Path: <linux-fsdevel+bounces-62068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDD7B83221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8204A5B4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25292D97AC;
	Thu, 18 Sep 2025 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RcL+V29n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iPCAkxEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA72D97B6;
	Thu, 18 Sep 2025 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176824; cv=fail; b=ajOzzZ+KvX5HRYu4j0hCPlEYYzuhRLEl2MX1QtFB69KP0PjjWSVfbR+JPMiRzr60tQ+GpARaUf+FFY9veJLWO+j8zA0jOuvNduCRrK0X7vh2dQHYSPGS22LI2oH5en7uxSw+SPVwwoiWStYNs+fiPKdfPIh3k9qFXrG0lTDO00M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176824; c=relaxed/simple;
	bh=pN9faJ1HZDGOqXLUlmTZIAP5uIuoyAXSiVwxjLLfHxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CE3PE+8xXg3W3z6csIpylGLLeGEZeuExQBZ/6xUUJnAo8uxpthmC/NDbO0sM+cJMAyThxa9dlEWu8WX6odZ+Q0h8D7EnN7XYEpSN9Te6k5uxoZMfYtSQ6q8HweLoeD5FIQMC25sDX97rme7SWAuyQAsu6MZzjcl7/JB17viH3eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RcL+V29n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iPCAkxEJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMFZ1Y014473;
	Thu, 18 Sep 2025 06:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9YN5nS5GfRLxC/jHbT
	M/RLaHf+vmfvOt9hoHfhGkeSM=; b=RcL+V29nYCpMg6Mvg6fcxMeK8/2SbqAyJ2
	2zA4HIJZbwZ8lAAUfKuIvWHYzauJEnvn0mV+prsmuPPsw6QKnLMN6SdJnsQOxAuo
	j+iTaS6M6e0bF3bCe0vBJwydPp6F94xkSdSmwp3UZjtFmRCtx7kd0ML/4SYIaCja
	0qMGFGOwPBoCbqDqOiMDAU1HGk8l9LA/77ZJWiAHyn5TP9cfnHWI/boYUeRe3ESC
	vBapCEvduFnlzi3uzYpTuUHsS7NaMT6A1DicnkKK33LymGXm8/TuuaQrY9udbJV5
	Mdv7NOs6W98UQ/RDW+AVdD8cLOfpADK+fgfxblHx3OWDKSJKIYXA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbtsst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 06:26:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3MBA7035116;
	Thu, 18 Sep 2025 06:26:20 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2n0cju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 06:26:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO4tI401hRN8+0UOq07MBZJKO4BPdUrjd5DCc9PcyrL3az9syydzAulensnsRGd2ZKXbVMCRQR4z+YDfxPh+W1oP7IO/ZqHzHWq/kSsuixgR9+SFDzohunwGWjMDEJq1ZirxX3Zv88bBaZ2vn/he73QXKbAaioPD5G2OISjB4QBF8Hb+/xsg/kCO6usMiQzgXVxHuXOyUk6ICZiV97UybIezDAviWA4/twPsWM7JXxmJ+5HyWmuUcl1cpOB7Ib14fLEH50UDcoAiiDpehitgB5WaidRz7tCyN3+15PZiQ9QmfdWHfLqLpkOPSy+THfEQ5Be+9MHDioSIMDluzTyHzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YN5nS5GfRLxC/jHbTM/RLaHf+vmfvOt9hoHfhGkeSM=;
 b=myBcyCfkdMxkNJcroGQaejwU86l6lfjbF5JND8iJnaDqHKX9hgoQRPOAWG7+zaGdtPur30pw9kizfZVQ9qmHXdPN+dRX14hyAIq7T5cr4fd1vIeIcT0DU9fTTODB3uAn2fXbXRtz3POt69Obj//LYCEXaZn0fhUnfryWoGfI1YqfZyJVaz+Kwb8PHbMxi2QnTGIdv5wLdG/tOKsH5u98knNSPFHTYvDN0WayqqOssfZP3S4K7Nk5HEdu/knQhcDc7eldqQEAbAO/SIxiOSqiqs3bWZu3bkuCoKsMERvBAQtmP+eZR6wT8FeJ10M6ZvU5tNroLTHbBJ7kf6YxEcQ+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YN5nS5GfRLxC/jHbTM/RLaHf+vmfvOt9hoHfhGkeSM=;
 b=iPCAkxEJLFFgiBYXv0RWBT1rGoVla440ewPIHFbLeFaAku0W8s6Nwq6JfpDutuqFqdDJbD0WCv7Us+0BwocabO1TVDghgI1zkCx8G0ZZLA0+duLjs9E4N82lE6Zljk7SdqeFwFoc6atojH5sv7XC4rA0xn2dEpvYJRbKyQuSTMk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5659.namprd10.prod.outlook.com (2603:10b6:510:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 06:26:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:26:15 +0000
Date: Thu, 18 Sep 2025 07:26:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
        kasan-dev@googlegroups.com, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 07/14] mm: abstract io_remap_pfn_range() based on PFN
Message-ID: <9d28f23b-5455-46b4-b88e-682b707093be@lucifer.local>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
 <4f01f4d82300444dee4af4f8d1333e52db402a45.1758135681.git.lorenzo.stoakes@oracle.com>
 <20250917211944.GF1391379@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917211944.GF1391379@nvidia.com>
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4a7a35-5204-4951-67d4-08ddf67c4578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9y4omMA4RmrNPRXFuUPyMgajAfvMHIcqGYxOoS6PiUqpKSXqaePdE8YJ6pYc?=
 =?us-ascii?Q?06LdIHG8mEdTLzTysxaFJ8HzqT4o2ITcf4Wef1vBl5lkzhQO2QlCtxdoblcu?=
 =?us-ascii?Q?Z1b9AC+gnMQJ0Typm2JcdfyKfBfKbD6MPsFh/aCbtzWAbBHeudkboSsLqKp5?=
 =?us-ascii?Q?UK0fiYlBmC1OOucCoAYUGDhEXvqbHZLMrcSnLnEfu3UYMH3fwX6d6eWJgyMg?=
 =?us-ascii?Q?+Yxjne73sqX5z6BcfPjNBtVS5qO3fUurY28JS6cSHbFu7fX9EfgmAm85NVtg?=
 =?us-ascii?Q?yqlCTMBu/AoXlBhpU9GWBDhbhjxWEexT+vPL86CYttQeAvnXLIg3YJyP9E0K?=
 =?us-ascii?Q?KPck7ddTZqzMGNwnqQ1ZGeeaO23/PH6xL2MmiPNDxGZujTjdw1zENxjbKN/J?=
 =?us-ascii?Q?5CzO4RDtBb3h96/l1ctRMomvnPXUiVbimaDGRNWP6zsWFpP1O3NXMk0OE0h6?=
 =?us-ascii?Q?B9YHxUnMPrCyftNHcN2iLagGT0j5FCGqhpqOioaxfpa3vOD3DEImbA5sSdi5?=
 =?us-ascii?Q?a/D4rzxOTY2XLcoeqg47Atg6F7Ryge84M3YQk0cvP9LaiASyKPxDNCTF5F4L?=
 =?us-ascii?Q?fczh30LaEpOL5TIk7/PQfLIq2Ebqohd7yoDqtH97ZUOtQfSgFq7GO9A7GoQ+?=
 =?us-ascii?Q?wJMjPNK7ieIebztm3xvKqpuDbjymX1/KUoabrLBqcYmW0j0pfL/IDIBwnQpH?=
 =?us-ascii?Q?HKMlG74BE0MY3J/Z19yHj7+tTIOXmkeRnbZPCFjRxbKLs4nu8iPTTEO0nN5E?=
 =?us-ascii?Q?PwJG6mM4CeLRWUrMRkkBgPn4wmZH1S5zlcooVhfRfBpfABrtrhkHt3cQoMpA?=
 =?us-ascii?Q?6Bhl4VlshmUjCjqShXBkEiI23x8j3Sr+WRtXUAoZ4wdav5bO4heOwy+PNc+f?=
 =?us-ascii?Q?4S7rjjButbPZ37t3qjSJbl+bhYzNs02BSflS2wpw3N2i4SlwM0m8wbEGmPvd?=
 =?us-ascii?Q?4Fr2qLyml129+N8G+lFbSrJk7hufncyrGMzC2WSGapN/8Gi7a0eeSqNG4Slj?=
 =?us-ascii?Q?6hKUVVvkaSKtp+Rup4PhuMknpsRQ1Cu9+U1LyMC3fdJer1SsawwVf64mZyEF?=
 =?us-ascii?Q?sFDZietm3lrvxuWI/wHM5oxhbfQ9FDHoB5rn7i/jTDyVevxqvqciq4hB+WK8?=
 =?us-ascii?Q?Agm05brOK89eOIhJNL4QG+pn8A0iMJ1gQ8MVrPn7LR/PO7bURdx0j4O6zp22?=
 =?us-ascii?Q?Mf7rWhXofhofNDnHQoJLULWft4EOg3VrRLHmbHm59D93OTRSJ1Q1N1sFmZdR?=
 =?us-ascii?Q?JcwLFEQGItyj6ePF2UIEAKsMmbQna9USHjmvH85lDn5UvJ8bnUBS1/QvPQWC?=
 =?us-ascii?Q?doOgBOJ5Uo+eGqPDaQgEiksCTdxtFfK7CFCRQmk1ilVI/H3vFK4lWpr+9cPT?=
 =?us-ascii?Q?TOZIHDbro4D602qhkbH6u09G1cpREVmETleHfkcdTvhQRsK03Mx48UVzEKXM?=
 =?us-ascii?Q?GU4PmBB142o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gf4JE4fc/N0mcXDZDjkpLyIfN8wkzpP8ICjJrX5sfKoZO5ydRpZJedZRXdSK?=
 =?us-ascii?Q?l7JvE7aWUY0iH/bqF01zS2YLsl/VGUPtF9b4CfbLPuaP4B3pJJWXkEld0SFb?=
 =?us-ascii?Q?m7k2YVoEjmlHt1VgjMykBUjzZndqIklZxmbxjX66oWddvZcCZehek1UHeKOa?=
 =?us-ascii?Q?Sk8AY+QhgrD0wcKJr7MmCp2mh1uX967l3zKpTig0NXa1IucgyMkpJBIaYdpx?=
 =?us-ascii?Q?SXAAdq3wo41FuXYaDFQhi/7wQ+5I/4P2NjHjsXUV6cgkOB+G2zWSm6PX1iF9?=
 =?us-ascii?Q?Ais/6mrVHqq+pTZZ5cPkUgwu+y9l+ScLwvPwkilrhHM6JN0lh17mOfDdj6dC?=
 =?us-ascii?Q?zFakUG3VISIUwpLowanb8Xx3t3tMbCU/Mr02YkNccqe8/eDsSilpGc3Cxx0J?=
 =?us-ascii?Q?HU9GC9wMJuzNQGWYsv7/ofL/Olc3JalkUBgpaxoamWc6/2DAWsiNCs4L1BfQ?=
 =?us-ascii?Q?w/BH/6tAo9taVW/iwO9M94gD9lA8ZYnIqng+3XwRXRo/xuw44eka83L0U6iD?=
 =?us-ascii?Q?5S85sJEyjj2c0SNqWmWm3ElJJGJYLv9Quu2hO/EQQPbDgoGB91H//ezSJGN4?=
 =?us-ascii?Q?RA/jQXbKw3KjzAqX3eTfH0Ww3thl01qSsis00gDzBo1YcUFp8YR5/AI92ifm?=
 =?us-ascii?Q?xcljAoGlIcYtJxJuujWreH3VzFPi6zPlu55smjrulxtY8edDCtXBy2yaJEJ6?=
 =?us-ascii?Q?qWUdS0ISul07fajoWr3KW1irtpYEY62uVi/3en8l2ssRUuOAJoEfrn8RmGpo?=
 =?us-ascii?Q?DDx+uX8ogeFkInWmTx7ScdidWbH6uJpuxeArluuz4OuNIlnKfKDkaFQvzeBk?=
 =?us-ascii?Q?6MjaGm2cGAUOZNPLXCGjEtzrvy/QoB0JGB/vjdwiSMQom9KGN25Fdy5S6/9N?=
 =?us-ascii?Q?p3eyDAnN3KgbjQOUWYc/OsiUlnd0bCQz/o3ivO5S0PjGbIMpguwi50MWmirB?=
 =?us-ascii?Q?ha2cTiHMxTDwtz/UojbCP3qqB5vfHVAKgF9cQBwQMnvviDpECF7CvBWuDVtz?=
 =?us-ascii?Q?n28IxomctdGGvfWYNnCrwVGD8YDSLS92PCvoT7rzGO+JOe7H+6VzNBkEqd+1?=
 =?us-ascii?Q?nodf3pYUDqMeXY1hvm/wFPveKp9ZLvQASV2vw1yNkYqreL1ziCcJSpcJj/u5?=
 =?us-ascii?Q?oA33uKn7ZDu25nqP9yDEEbPzDVXGzZ04+Id4UDzHg8YFZDS453FTTFKh1wRk?=
 =?us-ascii?Q?SHWzVLJdJiRBonO33foLaxnNJq4F9HpgFmsT2AOkTpL8I06Cw7LH1OQIr08+?=
 =?us-ascii?Q?XooHxmUHNf5tZBCIvhfYNgE+fvolyhXT0mEUW4/KOiTS8QFTMPhbkPAQ5RLT?=
 =?us-ascii?Q?IJci+wSQ6NHnrwTq8EvrUAKhis6wWTwkkiwo5CFBAQ/BfdRrAHc17iElUWc3?=
 =?us-ascii?Q?NsD7WfmE/nRTJhvIukht/zy8C5AxnoDKZTrmBpajfFl8QF13V/Ef89uErAQB?=
 =?us-ascii?Q?vaivJFkYbJnk2IrJpz5uSNAGN6uFwb2LMcOtqUmbrhLcJrNiEmNfmRoGP95R?=
 =?us-ascii?Q?zaF3vPpbQPjsN4usuWq083YSo6v/OE05i5FC9kSuM7PP+xKVzBZ27SVymajQ?=
 =?us-ascii?Q?KMsBMR41QmeKwoCE6YhzhhBmQECRUTY1dOYTzOkwGL5vQYbBHfHHLz4LgDZQ?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gv0VpA0yieGTrTUnsQ68TCydDDGcwk5yKPKbcnnXsL7nmQUFSIyuYCCtNdtnQ7X/QOHuuJIF+UW1I/wXWLhgbWnv5Uv0cm5nEdwDVpJGZeTvz40coVoJ0YtFxlo491oLn2JNseQeYFnIm4CjmQAEE+lKVl61S8N5WZ0oUytuOck5OxWNJVg9yWWjBguNA74wIs5ysY/9lhpZgZxTbiWDDKEZSoLV2n+THhgNvJx8g2y2xPW+XDzce383m8ogibWCm9yvPxd+uBGVHNszqNW+H70YzkXmFzbl03kX6xOBt3K+vMwbWSFo1B2Hi9OrWi9i1g78IR8YssblVyADLDN+uCMNZ8as06IdE4dgEjN8ssFo2DIz8stdNKqj+taa+yyz2SFayh195tBAKCRxlMW6/vEFPVQtoeWR1nJo8X6KZlCRhm32HTvjV/No6PlfwPuxXchn2POfiSOJgOF4HXCBmUnINRE6C5cYrEpWO02yKc3QMlmkaqF/UfCVq7/yb173WX2BZs9hUzbqUthYKkqcfwFb/fZpIJbEaXhjPTczoELm2egJcuHn8/+UirbgRE8ptB+gaWK83PT7i19zSxZI0AdceUW4SOM6+LDM0dzAQgs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4a7a35-5204-4951-67d4-08ddf67c4578
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:26:15.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1efGtBF7aoU4rPaCMu2SksdRj+DabWaQf8jPrpSZsOJDKrBhwdvkjmj6JbnPrbIvDp8zXOXrv8PFy0rztw6evERTxamm33nfOEgSSAFfhy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4Bpp2vdcAf0i
 KCHoLZHG/mJ1Z9Up/zquwUo5V/7xIaj8XlXU57zI2/JIREqYyzoupcUoJ1b80VMryOOuyUORA3y
 Ne2zxaoEV8Q0ansWN9qGv2vU7LSblPako1fJRSKWKm2nSM+rhrOd3XAAULji4v46Z0U//DI5izz
 hs1NIMtdE/TLy/Yq5WbKbOrMaX8t8qQ6PXIEuxwuLeQ47XPaPbDafmGHc5bbFzCUnQ9k8GYlvwp
 6MGjVK6XlcuLyBS8eD/F9QfZFgAqEVKth9dmAuMsOF5JAtOBsCNeolsWqEdxyyoZz8VRUTfC3Zi
 KxvPMqUOovmDQcpU2PJs8tdERQQSaEOPJWfuo/DQW1i3zW3dlY/+mITtQCUyRlrTx7qiqUlw+38
 CpOkYQZxU90bZbtCmH4vWMlp/T61Ow==
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cba60d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=AAxFpcqIBcFea-8j-GcA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: tC6EwaE0WPKqgZuZxlNUhubYhvsVmFML
X-Proofpoint-ORIG-GUID: tC6EwaE0WPKqgZuZxlNUhubYhvsVmFML

On Wed, Sep 17, 2025 at 06:19:44PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 08:11:09PM +0100, Lorenzo Stoakes wrote:
>
> > -#define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
> > -	remap_pfn_range(vma, vaddr, pfn, size, prot)
> > +#define io_remap_pfn_range_pfn(pfn, size) (pfn)
>
> ??
>
> Just delete it? Looks like cargo cult cruft, see below about
> pgprot_decrypted().

?? yourself! I'm not responsible for the code I touch ;)

I very obviously did this to prevent pgprot_decrypted() being invoked,
keeping the code idempotent to the original.

I obviously didn't account for the fact it's a nop on these arches, which
is your main point here. Which is a great point and really neatly cleans
things up, thanks!

>
> > +#ifdef io_remap_pfn_range_pfn
> > +static inline unsigned long io_remap_pfn_range_prot(pgprot_t prot)
> > +{
> > +	/* We do not decrypt if arch customises PFN. */
> > +	return prot;
>
> pgprot_decrypted() is a NOP on all the arches that use this override,
> please drop this.

Yes that's a great insight that I missed, and radically simplifies this.

I think my discovering that the PFN is all that varies apart from this +
your pedan^W careful review has led us somewhere nice once I drop this
stuff.

>
> Soon future work will require something more complicated to compute if
> pgprot_decrypted() should be called so this unused stuff isn't going
> to hold up.

Right, not sure what you're getting at here, for these arches will be nop,
so we're all good?

>
> Otherwise looks good to me
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!

>
> Jason

