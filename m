Return-Path: <linux-fsdevel+bounces-60541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9864B4916F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D4B18916CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0AD30C626;
	Mon,  8 Sep 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="idPkMyDn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F62jsqia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111D30DD15;
	Mon,  8 Sep 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341757; cv=fail; b=bzQIKC01Wspr3TMOsxvUWlNIXSInetQLGewlk2iqdobnLvC5a7NtFWY1EJ060SOxV6qwrgX34QwWDB6vLHamlW2PDL4a/TWxsPmi1GfpybVpX5Jr7Oycbz8dv/DSvrKuIJahRVLLVrgybu7THH/5obt7h8a0nA9YLzyzWld72pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341757; c=relaxed/simple;
	bh=qgZg57SNo7BkeSMlsdDjyidqpl0DoyYmyRvEUhsJ07I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RBjaXvU+YmK8f+wXzBOXblS6my94TCddPupwCLHZwkKotlbOGZ/jA7jYdUKT8JLzUpWaQVKDhPGqXCCaAbB6qmO76pqnlqR4/aec+sAiP27GSU+NXCOS3h82RL/ZEVlWh+ULkBNxrjmHVKRFW9nnjO9VrWgo0gzQbODmp47qlps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=idPkMyDn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F62jsqia; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588EBCRr019579;
	Mon, 8 Sep 2025 14:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qgZg57SNo7BkeSMlsd
	Djyidqpl0DoyYmyRvEUhsJ07I=; b=idPkMyDnrcTWqZhHgm0fwJ8vSRM9HMKr6p
	zk21U8/AaIwZc+Cv/RxeBF/MrHvy20WGS8hJf1/Ro6cAw2I06JltLW/5siJLHazs
	HVEr0BPXZbn5w2FU8uAOspfnZxS6IreFchRJ4BA+M/sLgUWGkl61M5mJC+VIgMmi
	UBDCQZql5kd75U9gLWMnaGpPFgGBSVrYN0MoXG6RTUnMVKjqInsb9IXxIc7sCvyV
	xqndxGNNRxR7sKUsIVgH5mdS1luvTjCdO0uQiS6irjYN1J2KMawIIUKEWIKUt7Ia
	PyTUQ6VJcS1B0jAcmYYS/8Q13PPZOAuivA0ImtI2ahZq0WoNjB3w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4920npr1cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:28:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588Dhqra030623;
	Mon, 8 Sep 2025 14:28:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd88m5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:28:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uupt/JMCz1a5lBatVgjW4MD6QwqsITeO9htJ+yXsSB+jg+0Ui/PSWKwQc7FDpacuO4B8xdGFBWE153YW8ZiYRWm2KEtZPlYzA/13Acp0DEZtBPBwBKAbZCQZoMeHRj+j8q/j0nBmB7H/k6yVllDnxKsKnxs4dqcYF/ISdcBK8YhowHLjABXl+Pk1i16n7zZzA5WRDH9zeu3rII33xMqyKugs1+lMyOLqW5aCAfKsOnFGCE/FxzZd9BFh3AZxa1RsIU1TljF+af6MjGNASSiHnd9XVF79CHjVyo69iHAQYk6phRSV7czMf1Agfr4+4n2H1xDi5yYUm5U2Nxl7Lf6OkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgZg57SNo7BkeSMlsdDjyidqpl0DoyYmyRvEUhsJ07I=;
 b=DkBuIvVl87TI9SJ8ChJxcGK1HGB4Rl73Y8BFQhLFpQ8eUdGoWCQK/qTiHwc+cYaL9xcLKHesUaHx1QVSgvQSOmKdMLgEQrrDot/dRdEizHxuxm1WhcB3eItlogFNtjC6PcIz9yMjDXm9r/saFe9WItVaPArpnYXTZVtT0lgEOnPjkP1nOx20LdFpDSWNCjokwbHNkN/yhqiU3B/AAZMsUc1P7MyoZFF2xzcQYsRFjjySNDveasEVy9G0yUFmVeDx0FZeYKfvP8rTcrc5sjO2gw+BmzaXSLxfpkZgzNZxCcU06J9+PT8B0fauYi7eFl1UAUnLN1I7ZKyHOaMxHYBAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgZg57SNo7BkeSMlsdDjyidqpl0DoyYmyRvEUhsJ07I=;
 b=F62jsqiaLn+ToqdkioAkvDkOkc5ptkqs+ufESQLtCR4fxGZPY5c/qZrdZmbHsB99oEKmDqCyl64eAf3k5whVL/qHnieZT6HgvGhxQMgXVUA/BjN9btysKbx2wbfKaUPg6v6zTwsaGnfQyU+CeSRXH14060r06FVFsJLmJVPN73Y=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM3PPF2867093BF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 14:27:56 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 14:27:56 +0000
Date: Mon, 8 Sep 2025 15:27:55 +0100
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
Subject: Re: [PATCH 12/16] mm: update resctl to use mmap_prepare,
 mmap_complete, mmap_abort
Message-ID: <d8ccda47-aad1-4900-be48-ae413d55d98f@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d9e9407d2ee4119c83a704a80763e5344afb42f5.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908132447.GB616306@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908132447.GB616306@nvidia.com>
X-ClientProxiedBy: LO6P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::12) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM3PPF2867093BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b28dcfb-ac4d-4f8e-2d3d-08ddeee3e786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3rexvRO9dwwN7/pCaGeJa61JMytcn8Ok6fGOIVQJUjIi6bkiLkjsJPW/Mtfo?=
 =?us-ascii?Q?6avCP0ZtLBcefMzOI+VfaN1OL4ibTT9/YfljTTCoKNGrYWERVEy3NfknL8Hm?=
 =?us-ascii?Q?rPU1xRc2B7TEWoOKMu7ncCejfD46JDt5Fp7e5Na/I8FiE5OObZKP9alm2PiM?=
 =?us-ascii?Q?U/GmbIZOReK7VwldtqeWvBjuq7LhUWyzx5/fl89XbRb8INE2WisoPfGphSX1?=
 =?us-ascii?Q?FxB99XgZx2MwrCziSm1SZNWielJdxz+07ANMbj8Jfniti5YJny2xacxg4m4F?=
 =?us-ascii?Q?uOY4SVgksKtMta/lPexMFZIPslrkrt4x0cECbAAuMfiRBNRT8IdWPNeSVKDV?=
 =?us-ascii?Q?WBbpQqRUcmwCvseAjPIwFv6FIHGK57SLbBhkiGwhbcspjx77jrP6BZpI4DA4?=
 =?us-ascii?Q?/sSatJlsnaHvOHHAsa1L5XoQx5fHTRvRGWTOjllpki1aQVI2V4Ce8qH9sfKE?=
 =?us-ascii?Q?h0t8JQw95d0Affp3K8iTFPXgQLzKOvdMCeGsUjl4RIqRZQH5C2rxKnSe5OTJ?=
 =?us-ascii?Q?gzrmXjQ5VGTn0EFDoKHbWuTj0fym4HIhJ2gXh4iSf0KxS68EjB0Aaq2JbcUs?=
 =?us-ascii?Q?R/HJZf3RhrR3CIY27QPjyZecQNvWhsNwWU3ikLRAz/ZHOhRzM4XWuwL6T0sv?=
 =?us-ascii?Q?RZuXyc/eSGb4weuzlDX6IJv9eeSDijacHWgmsqQ4DnwaSi7DOmt8/no3t5Qe?=
 =?us-ascii?Q?+6Q7PZBP70+kEOF6eyeqwPqmmnWZq86h4fPqK2jhFNcSSslicnxnY6l7Sscg?=
 =?us-ascii?Q?t9DmoT9rG76ctoTXYDSi9ZmgP9vmnvCPlTEx1ibUY4rxpjOYRWPg2R4ZBdDn?=
 =?us-ascii?Q?b3lpzPWUBfStP8uNy4ke1vgNp94ERj0B0KqU2bc41dB3WXvtRTKDDXlRh+Eo?=
 =?us-ascii?Q?+F5N/sViMy8Zg/J28xWs8ZiE3XDXKNXopS0h0BYuf7LbtMz0M9H5DNfZbHaX?=
 =?us-ascii?Q?+gHKeXCPXPn62NjBEnRvrJbypg6IZrX1Goy7W6+9JCD7gjSEbPUjSRMYWCD+?=
 =?us-ascii?Q?CGdL4jWJcYly0G+oJh+Sh0eqNzZBZHmIUCUir431IUzmHwXVw94Yp/jBMukX?=
 =?us-ascii?Q?sthD8ZQJErLzMceaRzGZpqsRhII73IdTuNcL7wIBBSKWUZXk0TVNBr66pGVu?=
 =?us-ascii?Q?cHoYHiEmRGlzZLah/WN8nUvBv6lkX2cvGSZwxOVSRkC4C8g9fyWsMhgFW814?=
 =?us-ascii?Q?tnK2O4KqRLAabn9n0K4ahwhblk8ito7d1Nh50rmhLG7fo6ny/WiEs9fyV32s?=
 =?us-ascii?Q?ksy02xHJxuKN2DKAd5ijeTJiPkhp7fP5LosdzJxMI+zF2GDt47GEDAnDLYX1?=
 =?us-ascii?Q?510IY2GWng/W46tUOKmGDhvh9VScchl7n529iDrQJe23YYB3Zt1P7NWmHTCl?=
 =?us-ascii?Q?X8Rvt5Dn6ymb7FELYgy+HXjS8tZp/O4xQDHrXHCNu/wxtcNeNCFoGK0cIEVm?=
 =?us-ascii?Q?qfdhsfbXz00=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4UU0MV3uHYWQBzceEMvRl+KaRQph89+v6yGYoMKr263FUtEX6fgJZUZk6tcz?=
 =?us-ascii?Q?2TDAkuBNMqBxljFp7Lpj1iytoDv21v6O5JC8OFngrYO/IoPZV3BW+A4XqF3V?=
 =?us-ascii?Q?sNyZLeIHqLEG5fIxTwjkDLqutJW+AQDVDQcLifb1tYtDVeFrRMCOe6Zzn5jw?=
 =?us-ascii?Q?sVGaaP+TynKb9JFndK2mKRyPnds9Bgy09s8NH2g1BM3EKX23+2F+BeuLk4ap?=
 =?us-ascii?Q?2Jb+kO0xU05kvm5a4MlZVrPEpKNYLuHAezGu2USvkiyfHXpOG8CAsomI+88f?=
 =?us-ascii?Q?v00kIW/J1U0VjiGrVltHTiUOQNm6UL+pl8o/gFQNRNf0g2cH0KAlP5XvdKR5?=
 =?us-ascii?Q?vLpa3RL2U8CBlz+Ia1j6sbS32Sh2bDo+i/nfAGBlE/hLE3KymDhSoJ47pnHe?=
 =?us-ascii?Q?20wkVazY9KoWXxtsRNFceVz3gQzwZCy7DS0d+49LhsTa6bCS44T/UIFWPdnT?=
 =?us-ascii?Q?LX8XHZzRI6hNwcJVlWMDAjCJZd4M5yB1/lu+JIIInwZjxinUa4IWJ7ouXh84?=
 =?us-ascii?Q?YyG6EWa5SsTH2zX4kiDhpfQg3UcrZ8RyBBYe2XP7/Ali/iY7veZlat9UVdn6?=
 =?us-ascii?Q?x0yxmEWy3mFgfkZdoiz06tvDDhCy3l/7QW0SX0sFqP7BKBfBTfZlg4pmo2uA?=
 =?us-ascii?Q?LrNsTUAujl2/iCLeLpBQE4scVu7RXWIYqyphs2Y2GCDKfHIP0Yae10QpY4Xj?=
 =?us-ascii?Q?FrjdHzkh6L/639S3nvsQGEStG3bGfQB5wdAAvyf4jhTxnOFrD11OZMzGuJeJ?=
 =?us-ascii?Q?f9O/tOZse90psNy2aRtiQQ62otIrln6pi2vsCjBQfnAM0r68adHDsKkyp/QY?=
 =?us-ascii?Q?EysRpBifNohULiPZ+OMESXu7CpfAS+48tsumQ4pi5OJubnp6K/7JLMyvcnc4?=
 =?us-ascii?Q?xU2jfk1ron1yoth3/grH04i8FjgxCXPwoXhxoyY7an5FnqAv7RHZmVy9yoS+?=
 =?us-ascii?Q?jXIWPqxA72vXADUutf/AF0V7fGQhhTC2Y5a8ZpMAOLnje5+cWOJYMoX56SJB?=
 =?us-ascii?Q?dP+0PvvrAsd6UpzYWtintEsEMTpsCOOVLdhAzw+zvuc9Zp55DFn3ceU3q1Mu?=
 =?us-ascii?Q?MaQ03BMjaeLG68d8kigouQii3hES/egVC6JiYgdsDUu/oZySwFRoX4TcL57m?=
 =?us-ascii?Q?tS/DuCJima1rrL0YKtLao/N6vlq1sXY9EI7XQR3aNcEDiVDhlmhkQxWzyZEt?=
 =?us-ascii?Q?srtwaMlfwzWjrHtTrxLgieayV8g822e0XYyY7psCqCOujCCviCiAlHrzGDzO?=
 =?us-ascii?Q?cEImMB5I3Q+Xvkv//quCUHDKNSrUjMk9bCaI4A4S4DPCDRkwdA0Be2mPM+/O?=
 =?us-ascii?Q?VeSOcwpJ8mw687O0EqkGlVYEOxZQTXyLjWpibEBDVr2F8A+iCgpNMqHoMyCr?=
 =?us-ascii?Q?r98Eby/ISgkpk+snjCykwMSzvD8HiFrz8TCNOIfJySqS+C5xy0hGK2czz9Sb?=
 =?us-ascii?Q?UHSqgzKvIcKVvHL8pWrJ8oAzT5RZE9XAi6ozKTS7Y7D2VB6O7WlZ+pfqAqTZ?=
 =?us-ascii?Q?2lMEQCC/LcjTOlK9GfurGm2m5FPh7cAwG06+whlxZrA2Ujk1dObm/Ty+9P1R?=
 =?us-ascii?Q?+dcIgEWBmPdKRXLQtR2PtJ2xHcl+NhCMV1vuOdbpTz/RQ1ROdufKF7ZF4WGA?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8Toa/h4ju5ArjqOHl7La2z9TvOMWbp7S9f5dkq2JMJQKnm+RXLffDSUhBdHEoEIRjO93rbWHy4uK6IW6Y2wzld/QqEldAVWJqJrOORa9APPSOlWQRt4SU9pDEVJRPGunIUskSPGAYw8WGLs5CC6Sko0UlN7UakHX0mTK0m40XCWMXAyWs7L9xTIwqmglMTVk92rZpnBLeBLvBO5yTsdDA5gRAkFIH9bcYtUkEcUCIcxiKXAUlw1ThPPBkmWmIQ6Vwyd6FJyfUYfC4sDVVv36fh3fSPAScZarDgxp/6vkStcYDtRtynqi10JfHF2mTeTJLemGzbD/hHYlaJg6Ss51b076F10q4llBJSSlv4PTT4AVAqGJFWTLM7+3wQya5BC5G42J8TsMX5ysfeItKgsWOVuiB+b9HdtDpt7bFaC3HxiXxkaEJKHq0vdRAdRR4WVfpXLqBvtp1otE0Mpq3YQKbAGMPvgGzFuqGluu/zwS/zFUMVegqnjnSxwLFk7oZwmM9+MO8aoO7Bp/eBjcaeXN2/KKoczuS21cV7jZUoqR65VRwZuJ51gSyZeh8KYJKxOtj89YQu6M8CDyzitBDhh1cTdO01vneGatvlABXAl5R+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b28dcfb-ac4d-4f8e-2d3d-08ddeee3e786
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:27:56.6419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtbhaUw81dPF93NpMLSWCiMiJpXb2ElFgCluHwDeiVxr5DdSmW8+p6FP+iYp47W1pVSaeZlCLazixQVhM9pz5sVBEsH2C4gZjd6xa2Bjipo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2867093BF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=851 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080144
X-Proofpoint-GUID: XHi_GQKYr9TWZ45UdktdP_SBZ7Y385ul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE0MiBTYWx0ZWRfX9YkezS+XHoDD
 9Vt/329QovsRraD8PHtjm78VbgQbCAvCigNYt4pyCiOGbHpW4E3QttSSnZY/FvKnpGKEUoAad6F
 TP6cgzXduilFNGagpoTSqPJebzsuwOGIwXKeGU/Nu+h09xEUaZ6kfiGxMcmGD/0R9xBfdd0P3Ja
 ClkjjVb2zA7X31w+mqSSfyHtwrCFAnXF/ceAPFp4LyZsZi0DHsY84WV7Qqt40BdByJ2FzuQWuNQ
 CeK9X/EgJI2CMQXps6QnaeA0oTt84UywNznMW9jAf0pZRHxGA53+5Ya2uSrlIZsDKUcytC8FXmo
 xLSp+FxRjYDsfUlau5d2AfCzQRV8NuMeXc5kBOmfJudZpNFCRw6ofMmZRW0aj5Px371FUr21gBD
 fgdDEmw9
X-Authority-Analysis: v=2.4 cv=R9QDGcRX c=1 sm=1 tr=0 ts=68bee80c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yuwUMpN5NBPrsbIGbq4A:9
 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: XHi_GQKYr9TWZ45UdktdP_SBZ7Y385ul

On Mon, Sep 08, 2025 at 10:24:47AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 12:10:43PM +0100, Lorenzo Stoakes wrote:
> > resctl uses remap_pfn_range(), but holds a mutex over the
> > operation. Therefore, establish the mutex in mmap_prepare(), release it in
> > mmap_complete() and release it in mmap_abort() should the operation fail.
>
> The mutex can't do anything relative to remap_pfn, no reason to hold it.

Sorry I missed this bit before...

Yeah I guess my concern was that the original code very intentionally holds the
mutex _over the remap operation_.

But I guess given we release the lock on failure this isn't necessary, and of
course obviously the lock has no bearing ont he actual remap.

Will drop it and drop mmap_abort for now as it's not yet needed.

Cheers, Lorenzo

