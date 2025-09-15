Return-Path: <linux-fsdevel+bounces-61369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6648EB57AC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2E67A605E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809E2309DDD;
	Mon, 15 Sep 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CIi83Q1u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TzNSLqDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225883093CF;
	Mon, 15 Sep 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939063; cv=fail; b=e+EgIJGKRUkUwGqhMFjDfVDGLHDujHbfrKfPym8HVj1wU7XyhxF1dolbMLcY+sxoj2GaDbT3UkTPMJ9WC9NaPkMHcWKCMP+rlSkjYFPjue0jaq75SnXcsvXivjvOndfv7tYNTYHl+GO4oa01V2ojRGjPCksbSovM5xnlohdd924=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939063; c=relaxed/simple;
	bh=0KYB7lNYOVDis78Na1Kyha4/1LZVpYfE8kdSGQBMLOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bveVIY9CnJQaJHbBmMoH6Mi3x0kWtAg00xYxTA1KBFc+L6bQ+fWc7+hUqqlIO/p30iLHGHe33dc6L7Gc8n/KB9pnhVKuyDunqCc03M+mX1627vYREPcKG/QUJ+rAA++KBMsGZbh9k+EjJlHxZrgSi9e5MEJ2p50NUPdus+p99cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CIi83Q1u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TzNSLqDa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAtno5016261;
	Mon, 15 Sep 2025 12:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6UX+modhKlgAliljWp
	s+Cs00h8uOWLdiqfWRV9Zj5mw=; b=CIi83Q1u5yEHpBzqSvjj7yxijnuw4kL3dG
	0AOHfLBcRqvOmtIQyoy9u5+d3HbOCj7ZBggmd5xyPF6YKZV3cBf8Cz4LAgOuUUaQ
	/SQSbjj4Cujosz0EEo35W7DrmLwERHQ6NJcRADLU097lH6LttmGlCS5ZFX+vsDeT
	WpIUEn10zC5QhPqOsLelhb2LRSEqHAhxDQeDHc/lQhgApwzvqjwTmBNRrXHqiQs7
	WVgpx8AQqKXEu+lNr2ikmAFrRiR/4yhZWirxS7wxbq+myN3vbLl1lPwNtVa3C782
	7IIGrxXJ2IvEzOSK3o5SEBEwbEi0A/osEKPCbBap8HrRq57Nk4ig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y72t9bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 12:23:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCBHFP016196;
	Mon, 15 Sep 2025 12:23:37 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ayr02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 12:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FY56Fy0imuchpMHPQP5kYyMyIM8Quly0SL007tZqTEje4QhVSB4XcZdckO5xVCvBbvS/eL+zcECfD7E9/+z8/go7IsIcUFwhqjrqhtV+j14kPgGuXsm/W6O953K+S1uY5gm+EMhG7HYOx/upae5b0R066nQwt7cxxGAm7qvXePrX2bMb2WA4pWoezw2pLx1pRi79vGK8Lxr+QkMp7k9HwA4VVC+B2ndeeGWukeGIGjr8QhiyzEivTnnFCkQhG1gkowwRQRpRrgNr9tUz5GfiNZvklG3ODn9gwjpH5g35SF+Ka39Wf3k+s/DcIb7FDWaYk1DxbzsVj+Hxjizn+oT03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UX+modhKlgAliljWps+Cs00h8uOWLdiqfWRV9Zj5mw=;
 b=Ar1havLuE+cDiot+U7rzNtqxTDI9tuniNYjya7EWLKGMeErM3RGPoErxXPVPFBr1ViwZyu4CAIOWyiTzfTl5h/+Qr14qqhSbFlCB5XnPSIEBpHW4IW4/LDgrxiuQfLwtnWHDwnj6UPXPoPKwP6pARKf4YLwi0OOjmEdPbzAn0u8xxqBua7d7O5RJ14FbTGeMW03jDfgVD0g3vT8NsISbz2rLrMrwQSjxRe1CWpYzyvAZzX1857zc5g4tj2sBDs8GV5UmyW5YXlpo0IJpF2X7W72U5xJVZ8lY1aolt8ydI+8Q84Gx6y9tXSSqPSgWuaMnykvxTx3qvkv+qTBCJ/Ugxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UX+modhKlgAliljWps+Cs00h8uOWLdiqfWRV9Zj5mw=;
 b=TzNSLqDaAwLycsU2eGKLaQT1+ccE6wcodDMhblCTdEdeCMtXILXVOhoI7OAWxT1HRZ8rxJCwajwtp8Zajs15vcJKjQJuz2lk5b6tfATFR+Zj5RnoWiiQKtvWS4LXxGE4yp4VK2gj+pTieeRjeDUUPuS4lUQc43QkVScV/P8Y7to=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB5884.namprd10.prod.outlook.com (2603:10b6:303:180::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:23:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:23:32 +0000
Date: Mon, 15 Sep 2025 13:23:30 +0100
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <77bbbfe8-871f-4bb3-ae8d-84dd328a1f7c@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121112.GC1024672@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915121112.GC1024672@nvidia.com>
X-ClientProxiedBy: LO4P123CA0245.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e5e6e8-e3fa-4a0e-9a64-08ddf452af89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6fi6V87pvYIk+OntlJ+qpBWQIyYgy3sRnhCZMZ7wk8/pd1Z7MUQ+XevsHvZW?=
 =?us-ascii?Q?tnMFR5GLUaviFZO9nrNGBxrByhEhu1eh94KrpBxQWfX255jE57IPdf4ePk+S?=
 =?us-ascii?Q?VSkGFtqeDtowiR7qXeX0E3TlYwc/E54vhqy8usQPrt/P9aGHHah8cH7TzzHQ?=
 =?us-ascii?Q?+W7AyUvRmkOm9uJ7h4iAHcACGvLYAlcMKIG+BFB1UnX1qSCezn4aHLei/7Ip?=
 =?us-ascii?Q?hON3A85t9cbxIsE4HC6+l/+9V7y709LosOtPtHoQJ2pOcMHWrfHLFkYqR5Qu?=
 =?us-ascii?Q?GaTp1IPD+pZ4rpYe6huEBAzP9jxXViNcLwGPMov1F+ik7UXdvhx0Il6mZZ7S?=
 =?us-ascii?Q?A5eKOedM1UM0mm0QsAxZHy1jsHtkWLS29WIMj5wDcmvPiik/ScBGw/isQSbF?=
 =?us-ascii?Q?2oqkuE12zFVEBQI4uswgG/ArF4K3CXzG2BqD9Rr25fYHwZL0Ofgu993TnBum?=
 =?us-ascii?Q?Ex0CjSl8hwahSnPq4cur7cqvUO7WiVBbiWZ/KJVk1KyONoyWd+riDixHgSwK?=
 =?us-ascii?Q?Hqpg1o0G+uB+1YIU2oW4QhA21oYIInRCmPVKZ2qrHr343r5OfTVMOlJvwK3e?=
 =?us-ascii?Q?lH3rwQ4wlM/0ooCXuCUKUJUuYlGltBVxMC/FaClkytEefKw0RlHmHhuFxjEW?=
 =?us-ascii?Q?jw7CoQEg9ytBFd6H/Fh1Z3J5kwz2t3kldr+dVk2QPsVHvK6aIBSs18l4/2Ad?=
 =?us-ascii?Q?n5Yk2ohruc1cQuJMZ1IXmAZA/KGWEsQ4qNhdz1dbu2VOJ9UR+xMenVMUmcfM?=
 =?us-ascii?Q?cTrp8hVJNNxqwEcqhLUFZFrKZghSq/+ZD+FLWHPzpDH155FZLl2CEwFMTkxK?=
 =?us-ascii?Q?xcisAduPLcs57klvIaZdbNi/vf2Vd+vT5cuOEh87R4pcD1GS1pR1PgJUNSMJ?=
 =?us-ascii?Q?mjmgh+hHADkLpGMoXLaOmzRJAqcL7P/hPTov2n2FPSnrzqAuv2K1BgewCacK?=
 =?us-ascii?Q?frDni5J8oNBmF98q4Ovw21HQ7RIU/v4YVMb7OcYLHp1XN/fDO9u9rj6B57zq?=
 =?us-ascii?Q?96v9j49Z3+x17dnuUDVLj4hAmTbyiLY5MmwLWubc+7xQVVj0jexRzEdeqhLa?=
 =?us-ascii?Q?fqKk97aVspu05OBvMwXgN/vQdCskzuZ9Pn0ymU8Oz0C0sWb+kLPRB+W4fXuD?=
 =?us-ascii?Q?MSewIVi6UDgV+yvxj7qMaYs3lqHyHoD9KBJlK9+JbHx/ClZRWQ2n7CFNLvom?=
 =?us-ascii?Q?ui9rNQxtbpNkrwNdon2odrY9tNsEUOQxMfoyhP282Vm3lAad7DE3j/jZ21MD?=
 =?us-ascii?Q?WCI3kKmW68rxK7CpBTKA1i4xweq0INipJO3XC6nWSECnaOwMvy+aCZGzQaIp?=
 =?us-ascii?Q?WSHgq1/sf/BV3DEY4ebVgoP/GZZ0LCSAWqF2KpIHXeju+mg+L67RUDkcCLyI?=
 =?us-ascii?Q?ZAs49NC3ugPMOzmeKfwo3g46S2YrET/P/kPzIGNTkE8aU9pOrWEWafOMrG5q?=
 =?us-ascii?Q?2ZW+Q2rQ3AU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ksEQ23NT30huZOK/m6in0pVz9IXfD7te75Td48NlQzUl3x6GnLILN9kGnCng?=
 =?us-ascii?Q?RTtxWx7szPYV8cU01ZsSc84F9a1xSaKMbHSRnVIpH88el4qBn88fIvnEdS3V?=
 =?us-ascii?Q?71OaIbMRDdC1XNoUXR9vXz6xaYWjYb8gttuaaP1K7On07fdWic56Xfo2j66d?=
 =?us-ascii?Q?c1HPWijEsQuWnHELDb5wjJqAJSWoWtBxTeURjz08p0xII91EkpY1iI/sIqf6?=
 =?us-ascii?Q?fv981BYB4NN9c4mYVyxOMuv8ZdI1OzbTSpkdiedCavuIGs99iJCEIjB3P6eO?=
 =?us-ascii?Q?4KM4eR1jp2XNkbviiOmkm1j8aQiGd2C50ZA7tVC1ANLhoJkt93pLpCaRUllu?=
 =?us-ascii?Q?eaKZ1Dh5mXCEhfyqVAEr3/lg/e1t8Jt6ZaqoS7vhQ4r2LSsg4SBiiy+i5noJ?=
 =?us-ascii?Q?KWaYpi+NFPYH7VBvvwAVlBBAaX8ZARaNc5MLkjSP0AoP4u37BqkLhpUjDVSj?=
 =?us-ascii?Q?+mHmpJguotMRPkco/fHaUiProT3jNG/qgBdm7AFUPbjMOLerT+AiENMpwOjD?=
 =?us-ascii?Q?nrcheUOvAbEn8LeeMk1wJT9OJq7uLkDmY/dHuhhK0g8LB+0oJPzO2vCsT9w7?=
 =?us-ascii?Q?pZD65IkznGzWa6orBb9GePZiQPw03vf3s21iMOPLCzlwN1DDm4M02+SYzrNu?=
 =?us-ascii?Q?s+229wPvGD7QCuTWx5JhiI+6wGiGXF5jgL9WskAwc5aNo03sr4qz2A1YK5om?=
 =?us-ascii?Q?uVvQ/qAUFv9+HHObgIpCEVkofv+NXaIEdTRDBDD2Q17stWAnmIMOwXcKZryR?=
 =?us-ascii?Q?qMZb+N/BtzY+CrGnroNAGRXoarYW0tzdKsY0U0qEvlp/3fhIiqaI2zsqY5XL?=
 =?us-ascii?Q?1pFxjX9taSHUWMp4wJzUR5lHHVAdu5nBXSEWNT8Hj/G27uhjQ47erUC/ycPL?=
 =?us-ascii?Q?6HzILn34AcgC0cj86Ofx4xiVqrm4ZUpPt2SPQUfRZwB9S5hoJcTS+Uo2F03g?=
 =?us-ascii?Q?08YT7AWJ7emvIVsuotL+GnVuQvaAYxhXPR7DjxVDxIusT6GFYERo9BvQXAPx?=
 =?us-ascii?Q?6JSetxbRIxBiRietoHJmUi7CAuT+K2FtMURhCHVt4pxc7Y6xbRfZIneL0EyX?=
 =?us-ascii?Q?A66yrM8KlHjnR9e4Z4iThn9Z5qiaWnE5RA2VNHi1jt5WKrQsjRIjyep7WV4a?=
 =?us-ascii?Q?RKwJjxxt+4f9n08iSvrx7ZlYOe9a7tYwXgarZs00M2BHmzFfUXLtdpRku1Ys?=
 =?us-ascii?Q?VvxA/t1Ab0dPyFKzYFnZGAAi4sl99KYchTZfiqe6w4RkrvnhG9dgTJ0a4rE0?=
 =?us-ascii?Q?hZ+zsXB5wgBz6JWwUDQgTccBD9GW4Bn/V4yu8SY5DmtAY6EchnV+r8UtFlDX?=
 =?us-ascii?Q?+n0Ka+QpUoVPD0huCvI9IJM23LSS7tW4HIoa05L25SUs2mBORRSNMvgtOadt?=
 =?us-ascii?Q?GnfPjMj9eL5eh9SMs6T937ITlkoz2WXQVIhmU4r/ogRLVU6uXj/NvDynFHpZ?=
 =?us-ascii?Q?Sy9792ZdplHAQQP03n29ZzcNj7eQ6I7HL0SDSxKArGYA13inZTuheJRXsORY?=
 =?us-ascii?Q?lK3pNmCz7ao24rJr7SuCMXeY60/HncFcpQLiECDfE8ffRx2mLGJZfNJt4JA/?=
 =?us-ascii?Q?GrC7PXqbG83VuP59OX+2rrbAZ7i+U+l6HbrvuuYtAtSByfScrj/M5oDzmFwH?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EbgINio4psbNtXRIUX4kHBHgcXenr2RtpTrQr8f+AArisU14fq7X65wHlDvgbwjP92N11Jx8mWHwNfhjFCdrlPRV2SGBd9Z7EH3kBLREl3WP41/7OXuM20drm7AowKdrFZZYvTCrSJz+/eRyMXYCkgbMB9EGCpSL6CHJzHMTe38as64kUNXm2zvE3bJzXfllARMdwmCWXyJxRFjZhzL/Fh54X4j93Mh6Ft0Ba0grwaFMirP06FGciw6gcP5y0V/qiOq9GykdaHzyyCR7LNcx2TGeS8UU3sR4NjBdWwhfEE9VBvYq69r/aUFum4HQspRj1gOh/jgZLbyKzHhsMa9hwYXE5cbpefifKT9xvVg8LOUxrlNKxYHocvil4WSCiUWs5z4LXoh1K2EQJbB9s0W1QA2I5CCjXLbsFHAYR9WEWiOituzjIMakhpFFvdytF806TCVtjzls8Wh1qaDmYhlnx8AiQnRnRzye1PyBceZRxGGA06KvKmnPG1mzwmEzIz+4hMI1zop9oH0DEzecB9vXfJnPuYoDJo9uIQO6h2oVpdY8RRtc2i69ygij6mnnDLdL7JR4wFgNuj6NWqCcf69/2x9rlRVoCscUKQo0+r9vgZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e5e6e8-e3fa-4a0e-9a64-08ddf452af89
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:23:32.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPpDMz8Xa1mDzm/n6A68jaAZ+PtYriYykbCttHabcPZotwkpRP0rBRMsHvA2WUKODu9M+ct6dFOokWlZQRWWoOn/1faEgHhx5BUpRtz7ZqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150117
X-Authority-Analysis: v=2.4 cv=F9lXdrhN c=1 sm=1 tr=0 ts=68c8054b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=9afJXiSWLFsG3sEkPHcA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: kf6ALWcggDYBslGHoFraPH5T3KpAJiWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMyBTYWx0ZWRfX11/jHSaOJDC3
 eK3nj8VLW1fJqQzsQkNbrH+uklTZLOabHT0oqnk3Bc13u32A4E5Kfn3vUa7rwQAOh40Moq0so4x
 +Rz/097kVNhGS/94jxCO6Gr48jsJUBnNBjsMb57QIwDIMECh+y6q+ZeTNrH4pNkMkWj8KiEZzws
 lQUut9rkDHf2bi+q1WmKHk78DP4D16lynbD9QHzl2Ps1+YCatafGRvbW4GcPZUk3K/o7aPoJK7V
 EqtIOiDX5O4CZobb+bl+KPGp1WV2c3WkzvhWBIgTU6wMGFVcVqjLZkWDgo8m6Y4w6MT7tbJLbtT
 um3zEgMPTbWAmmRHjO8EnTAjLp0S/E+4Yw/ZL0c1IekH3I5O0f4ayq884xlfM5SjYComnqlwzuK
 /vIcN+MxwrvmHO/ghh/wQizntQZTWg==
X-Proofpoint-GUID: kf6ALWcggDYBslGHoFraPH5T3KpAJiWz

On Mon, Sep 15, 2025 at 09:11:12AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 10, 2025 at 09:22:03PM +0100, Lorenzo Stoakes wrote:
> > +static inline void mmap_action_remap(struct mmap_action *action,
> > +		unsigned long addr, unsigned long pfn, unsigned long size,
> > +		pgprot_t pgprot)
> > +{
> > +	action->type = MMAP_REMAP_PFN;
> > +
> > +	action->remap.addr = addr;
> > +	action->remap.pfn = pfn;
> > +	action->remap.size = size;
> > +	action->remap.pgprot = pgprot;
> > +}
>
> These helpers drivers are supposed to call really should have kdocs.
>
> Especially since 'addr' is sort of ambigous.

OK.

>
> And I'm wondering why they don't take in the vm_area_desc? Eg shouldn't
> we be strongly discouraging using anything other than
> vma->vm_page_prot as the last argument?

I need to abstract desc from action so custom handlers can perform
sub-actions. It's unfortunate but there we go.

There'd be horrible confusion passing around a desc that has an action in
it that you then ignore, otherwise. Better to abstract the concept of
action altogether.

>
> I'd probably also have a small helper wrapper for the very common case
> of whole vma:
>
> /* Fill the entire VMA with pfns starting at pfn. Caller must have
>  * already checked desc has an appropriate size */
> mmap_action_remap_full(struct vm_area_desc *desc, unsigned long pfn)

See above re: desc vs. action.



>
> It is not normal for a driver to partially populate a VMA, lets call
> those out as something weird.
>
> > +struct page **mmap_action_mixedmap_pages(struct mmap_action *action,
> > +		unsigned long addr, unsigned long num_pages)
> > +{
> > +	struct page **pages;
> > +
> > +	pages = kmalloc_array(num_pages, sizeof(struct page *), GFP_KERNEL);
> > +	if (!pages)
> > +		return NULL;
>
> This allocation seems like a shame, I doubt many places actually need
> it .. A callback to get each pfn would be better?

It'd be hard to know how to get the context right that'd need to be supplied to
the callback.

In kcov's case it'd be kcov->area + an offset.

So we'd need an offset parameter, the struct file *, whatever else to be
passed.

And then we'll find a driver where that doesn't work and we're screwed.

I don't think optimising for mmap setup is really important.

We can always go back and refactor things later once this pattern is
established.

And again with ~230 odd drivers to update, I'd rather keep things as simple
as possible for now.

>
> Jason

Cheers, Lorenzo

