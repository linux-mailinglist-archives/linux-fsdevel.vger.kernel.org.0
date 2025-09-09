Return-Path: <linux-fsdevel+bounces-60717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256E5B5048F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05CF362CA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C6C3570CD;
	Tue,  9 Sep 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EzJ9F4yV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GfFc5jmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A841E1E04;
	Tue,  9 Sep 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757439467; cv=fail; b=uoajfj710I3DbB1HAMhIuDjmBvPfIaNTbftNM005izxrg0bWVZzI6Sm6CyT7OSiW2ZxlUI+lDvxgIeTkhy91KpoQqMEJ+EFcq8XmM5VlBjfJmiZIlDmvV7K/ONO3vUesKtMTb3pzJOhlTUsZ/J2xK1aaTEvh5B4/uxWZKrftHjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757439467; c=relaxed/simple;
	bh=psQlTRrToIbuW9boZ/pstfnUrwQEWb14WVKI5VAhI8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lST/Y/Cx2DWcoSj9AsfAwX8pNBECmD/Et7pZlFFBBaIHrFGZXgbeSn92LjxSPHxaeKxLValTd3rUtyiLZuR3YMHhCTTrslWLE5pEoRIC+uREyeZ2nMQpK/H+dWlIQyK4tSkG/Sq74H+9UxsOYg9olQdhok6gkWg5tkJ1gTOtF8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EzJ9F4yV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GfFc5jmB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Ftew2017610;
	Tue, 9 Sep 2025 17:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Z4imtT5bhQSm36VBtsneRmycV93bCClBZo7SSFJGfdI=; b=
	EzJ9F4yV93206yAwVZAejJu5F227papBYwIE+isYS+mPN4Yyg8m/TT37IoAYGLVZ
	gIuXK7wIm61Y+ix+FYkQoLJ1motbigLMNP9z6NV0P8JLeZPod15eZLHIKgU10A7H
	OOjv9lbg0sXzsArFLuejQB4K+sRjltBsWguAoQW/OJjVb+T5KiyUwfkeLSIoS5zT
	7AuG5TF+weC2K+/E8q8MmmAoV08GZen1riq54DLFc7wyWdTPqdqbHBeGku0EGshD
	sxWC/CBhmv0BHRHWcZSSXXvdZJ4AZ/YKgJ5RMoPZoJXhekm5BqQncjaZZOYWadpP
	QP3UbJWp4N2KXfCY0juQfQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2tjdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 17:36:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589GYuFo013729;
	Tue, 9 Sep 2025 17:36:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bda5aq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 17:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAW9C+5yMu9wtoVj0vbABIwRwl11oMNAfczV7YnWc7NFRDkL4cNtvbr/XCx5Ifm6YaB+PCZZru+f2BPMDl+8abKKYmSpnDpqJWTdu3TloTPx8Jl44MOZM7H0vN0A9RrYEZhcOQcmb6afjUwCNYuLpc2j85tKP2VwzCb/HMCREgCb0yHeYDJc0ku7OmB1UosONHKLBQvGs07wLUhhAvOJtILPl3QmZJVPZWtOeDb313EgBqwdliyK4rnvsXmcbS/H+lFWRy1XiyyMrVsbPOsjrvuH8YFXYcq7I68NI0kZEPQTBHmzEoPF6/akx4e3PgK1pQDSTq6jf8DYQp8GbbRYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4imtT5bhQSm36VBtsneRmycV93bCClBZo7SSFJGfdI=;
 b=skYFiiT4jgm/pl1YX7JrxyoVe9dH6IcP5Chylsqmmls8uxlcnUkAQBXhIg8aolE9bJCusHKqM+5ZCNhvX2uCfv4Ed4nIjwcUPgg860yaRN2rmolxDuxqhrSITaavsUbGK6tUy9wimE8CE5/NQjJ8ay/GOQWRtXFZox7H9kwBK8RDi1+rVoJDbqExeT1GXwBSv/PxTCJaSHfnoKIVhcZ0Kp3WYhyovQtB8k/iU++cSa6UvCjLtuPa/gxpGsd4TbZHkqM5GC9EmMoUJhKFLItTvRjvr7auMqVrXSXASVtaKuS1Zykbh2SJpMZu7kxCK4lMleq82qyNE0TpZ+egrLID1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4imtT5bhQSm36VBtsneRmycV93bCClBZo7SSFJGfdI=;
 b=GfFc5jmBt/751z/z2hkJ4i6Hx56jPnT9nupVH/XwEWgEynQVTaut9wPBgsFXnhbM3Ax2BX1REn0GfVhQUwwGxQu846Sok5N7HjlL0B8Ns7wfgrbcrnZObcwuQKpriMxpGRdSM83nRqh0SbzLkakJpILAlM1/SZoIM+gSAvJeT5w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6726.namprd10.prod.outlook.com (2603:10b6:8:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 17:36:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 17:36:46 +0000
Date: Tue, 9 Sep 2025 18:36:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
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
Subject: Re: [PATCH 06/16] mm: introduce the f_op->mmap_complete, mmap_abort
 hooks
Message-ID: <4b3a2009-7ad6-4110-bff1-5d3adf43b5ef@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
 <ad69e837-b5c7-4e2d-a268-c63c9b4095cf@redhat.com>
 <c04357f9-795e-4a5d-b762-f140e3d413d8@lucifer.local>
 <e882bb41-f112-4ec3-a611-0b7fcf51d105@redhat.com>
 <8994a0f1-1217-49e6-a0db-54ddb5ab8830@lucifer.local>
 <CAJuCfpEeUkta7UfN2qzSxHuohHnm7qXe=rEzVjfynhmn2WF0fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEeUkta7UfN2qzSxHuohHnm7qXe=rEzVjfynhmn2WF0fA@mail.gmail.com>
X-ClientProxiedBy: AM8P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: a1741589-c2b5-47b6-6569-08ddefc772db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTl3Qk5lYjYyVkZtM2U1WDV1WFlZZG10VmpDVGFXUGQ5ckVnQk44SjAwQk1W?=
 =?utf-8?B?Sys1RXBkb01uUkRONG9lWXptSXVoWmN5VlpUM0QwYmY3bk8rLytrdGF5eFlH?=
 =?utf-8?B?c3BrVWxJcHBiK2FPMUZOU1pBOTJITXZpRTQvZ2tjYmxUTWZlRjBNdGw2Mm8x?=
 =?utf-8?B?aCtDcSt4K1pNWHFsRkhOLzFnNUdMclBrOTlvcWxkYytZMUJ0UjdYVDNxS2c5?=
 =?utf-8?B?K2ppczJaRWd4UXEyY24wMHk3MDRGblF0ME5vc0M5clp1Q2d4K1pQaDBJUGNE?=
 =?utf-8?B?K1FENGEzTGgzemhVN1owNmtxTFc4bUxya1RHUWZEV2NpUVoxSlFmVzRKRVBO?=
 =?utf-8?B?NkpJNEtOaUx3VnlvMnI5cGtTdDYwM0RNSVBCQkc5T1lKRmR2Z2RGKzdaNXNu?=
 =?utf-8?B?NEt0ajFXVlFialRkWSsvWENhcWtrK0toVXpBNTdyS0VFQ0dQeEpHUWZYc21h?=
 =?utf-8?B?ckNWc2pRZWRBaDFoWEs4RmJJMDgrekd6ellVU1B6NkdibHpSWTVkQUJhZ2Vk?=
 =?utf-8?B?ZkFaYnlYb1VlMTNyL0pzcXpyM3ViOWsvRk1BNFJxRmRLRjZjN1ZZcXBsQzZW?=
 =?utf-8?B?eHU2ckNPSWh5RTNMMWFFVHB3WmNLcis0TkNmb29vL3Y5ZVlCb2dvbm5Ib0lC?=
 =?utf-8?B?YitGUmM2Sm9YMGNWRUsvOGc4Q1Bralc4T1JTMUxUbVZOQnlvelFSRjlZNzla?=
 =?utf-8?B?WWY1QTROUHdFODdlaUlUTWR2WjU0dm9SVGtvSXRSNWRkM2FGZ1U3eGdlL2FK?=
 =?utf-8?B?YVgzVnBMUUY2dEE1b0dRaWJhVGJkR2Y0cXVlSkhKbjVuckZOWFMyRGVEUS9D?=
 =?utf-8?B?bi8zdUU4RE83OUx5bE50c3NsUDlhOFQ4SmFLOUVZdG9xUnEvdW01WWhhendj?=
 =?utf-8?B?NWV0Mnlra0c5YkhaL0R6SVE1UjQ2cVA2R2t1UkY2MnFpejBCTk10M3NZZWxk?=
 =?utf-8?B?UnZ2M2QvQ3FQdVkyT2dnTTR4ODlTb0ExYWhpdTJUSWtBVUJYUWhmVm5mTGsr?=
 =?utf-8?B?YTFZUzFPTCt4MVVGWHRQeS92VmR0UlB6OEFpUllKaHQ1VElCNExseVlGQ250?=
 =?utf-8?B?eTNtdUQzaEVvT2VIUHFiSUl1TVFrSEVmN1BqOHVMeUNLUHlZVG03WXU2MHZa?=
 =?utf-8?B?UklJSzJyMWtXZVdOUlczSGRCaWRhMWE0N1pSVFhQNDAzWFdzdWh4bEJhS1ZI?=
 =?utf-8?B?a0ZPbHRVWVRuSTZaNTlSVzBSOFdlWlVsV250NkxFTVh6NlpqYzhnV01rS0ZT?=
 =?utf-8?B?VHNZdmdYMlphWkdDaDdGcE5DdEY4NnYyc2FUTjRQSzE0U1FGNlYybllBdlI2?=
 =?utf-8?B?NEh5dldtNkhEYmdRb0FhZjQzVTNDd3Bvak1OKzJHYzQwYkRKYVBYOVdNdUlx?=
 =?utf-8?B?MndBQ0Y2OE9pSTY3UzhtMExLcjVPaU5ENWNnTktLSEptUzQ2RzdFZ2dmbTM4?=
 =?utf-8?B?Q1FWSDU3ZHE4ckpmQ0Z1S1BxRWJpUW5UaHRxZ0VFaWRCbXQwNzVUSE9sRXZx?=
 =?utf-8?B?YTBTQS85cnV5OGtKTHNxd3RrcWxZejFTVnk1amQrQWRzN054Rk5BdFg1TTVz?=
 =?utf-8?B?Q05TQVExSTlkSVBRaFhjT01qdGl1U3VsSE9RSXo3aXh5ZXBSZGZwMHd6WUFI?=
 =?utf-8?B?MGlJblUvNldtRlZNY2VBc1JONmlVT05TMXFsSXd6dnYvVk5MNmU1bkxhd2FO?=
 =?utf-8?B?WHNhMk40RE82d0xvWjZ3b3NrYXpXRy9vVjIwcVhSVXg4VXRJUUVIVUlyKzdj?=
 =?utf-8?B?V1hIYmYyR05ORmEzVmUzOVhEaDFhaC9jSXBscDlZdGVmWWxRRHYrMU9PL1hB?=
 =?utf-8?B?WWIrc2hsejZTSm5IV3NxUWR4anJvcHErSS9rVXBPZmptU25mcDMzV0lmUGRa?=
 =?utf-8?B?dGk4MktPMTlkOC8rOG1EQUlHZG9TOXN3T1RJNU5XbWNjQnE3WXZ1c2hzRlpK?=
 =?utf-8?Q?uq42bGxSCzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1JDYVFCNEcydVFmNHdGMEZtNGhmbnd6QUQxNUcrUjZpQkhMZ0pNV09xYitx?=
 =?utf-8?B?d1M4SERDVkpmSXdENzNDVzMrcks0N0tWbW9hYVlQOUlScFVKWE1Ja1VxelR3?=
 =?utf-8?B?MGhwRit1akNWUGVETklSS3pXbXF5T2U5cmxWSmNkREFEWndkMHBHTFFaSFd6?=
 =?utf-8?B?c3puOUpERFk5S29tdDNlcmlqTlhPMTVBU3Z5STNib1VtNWpLbjV1bHRhRnZE?=
 =?utf-8?B?YWR2Qi9OQjN3L005YnR4N1pkb3pVRm9jWmduOEw3RHdCZXJrL0w4bXRVQUp6?=
 =?utf-8?B?QlhyaXBsRm5nY1pYOGVyK0h1MmdCajQ5N1RVNUNLOXVDMXZIZWMyNHhWQnV4?=
 =?utf-8?B?UXQzaVpTUFdJTmhoRDV6WlBqR3k5dUV2ZjhNek96MDB6SjYrUVVGUHpnUS9N?=
 =?utf-8?B?Vk1SbCtsNHNsOUxwcXdTWm92MC8zRHREdHhrUVI2a3VvUXBkSEozczluOGJX?=
 =?utf-8?B?WGN3bnU2VC81TDhwYW9ycnRqc1RISkYzQlYzRVBEdWRvWnh3RmgwdFZ3Tlha?=
 =?utf-8?B?enhHT0ZaYk12MGxoVTlJTCtETUgwdVRXRWwrMzdFV2dJNU1HVGJ5aGNFTlhV?=
 =?utf-8?B?NXg4K0p6bjZHdWlEVnRkcklDcG1IZDdiaGZnNnlsQWQ0ckx1enU4bEdTYjU3?=
 =?utf-8?B?cDNIZll2UVR4YVloeXBDbGM4UWtia0xXdElDN29ha3hGNnNsTUowbTFKc1Bj?=
 =?utf-8?B?ekJCcWQySHBua05IZytPYnUyR1NQVEM4ZzVkNFROYzNGbGtNQys4Sjg0ZUlL?=
 =?utf-8?B?UE51ZzhDUzJCaExLdXA1MnJHNWNtOUpIaW1jOGU1TDZhRHV0Sy9xVU5nWlhh?=
 =?utf-8?B?VGNqZ2lXS3BsUVpRS1ZPUVVXS2RkSFo0M3hUaEFadURaUHpEVXF0Y3BUMFd1?=
 =?utf-8?B?NWxQTlZTdkl1ZlpBMWxicFcvZzhiS0o5R3cvdU9YbVBFL3FhelFodXVYZzUz?=
 =?utf-8?B?eHpiKzcxVFpORU4wTzYyb0N6UHVmTFc4QUhmMktuSzhNRjNaU3J6TDV1SDJZ?=
 =?utf-8?B?QkdJNURhcXJ4b3FOai9GRElUNTBsSTZUdzk4WHVkMS8yd0hWbTZoUnIyWEZM?=
 =?utf-8?B?V0t1TXc0K1diNEkzaUVZSXlzRWRrbURyZ09DUVhwcDlTa2pZLzFqRlpmZHNi?=
 =?utf-8?B?aWpxOThIUVRMZUZGSHRVT2NSdzJPamZ4TkRhd21JZklrRUx3SnRhT21RM3FL?=
 =?utf-8?B?R2J6bTlCbHJGelBnSStFZHBFOGVscytLWXUxa2EwZytmeXNlWFkwNmRyNVpH?=
 =?utf-8?B?N2xMMUQvUG5scGVmOU9LY1J0ZkhQU2F1WllxMFd3R3NwNGdpQjNxYkpnTjVO?=
 =?utf-8?B?dmNmaEQwYnVLa3MyZmNnY2xZeXdzYXJRN0JaTHB6aDFOY3drYXZudVRsVGVF?=
 =?utf-8?B?d0I1cFR5MlNpWG8wc3A3eS9xQi9BZHMrMWZpT3daeXNIWUdId3JTZ3A5ajUw?=
 =?utf-8?B?L2o0bjlPZ3JFMzhBUU9CTkdLalBFbXhOdGVOMk5aMGl3aS83bkcrSVp3QndI?=
 =?utf-8?B?MENZeVpjRHM1R0dJNTV3TkE4OWVPVUR4Q1VuRURIdUtBWW5iRXZxVjJYcUZL?=
 =?utf-8?B?YmJXajJMcnREVERDSjFtOUJvLzdJdCt0RUJFamZOTllKY09KTW5scmw4RUNn?=
 =?utf-8?B?ZE9xVE04YkFoRGJkTnNKSXB5MmJxMVh1dFArL3gzMEl4WTJiOGVnN3pYNFpR?=
 =?utf-8?B?VUQwMzg2amU3ZjVDTzVWSWgvMEp4clZqcTIrNUFrdC9JZS9xaVZ0TExsNmJX?=
 =?utf-8?B?NnNIc1pITDhpWTlVY0Z0WHhWaUt1VWh2WlNLQkZJZGxoNkNPdTlhOWNQSzRh?=
 =?utf-8?B?OUNVRUVaalFsZWovbS9LcFFob3I5VTZ2OENDa0habGxtMVAza09QamRyd1BZ?=
 =?utf-8?B?djFMUUg4RjFmeWZEcXVpa1lqcEtYMjVqdVZ2NTRia1FsZ2RFODVqZUZIK2RS?=
 =?utf-8?B?Ym84L0RGcjhjVHA2VEhpZEk1UGYrMHZBdkQ0S2dXci9qRWRBdk1kU1NXZThR?=
 =?utf-8?B?WWMyd0J2dmVPWVdRWEh4T3A0STJLd255QjRZYlNOek00aW42b3FpMFBSK3dQ?=
 =?utf-8?B?dm1maWtVTWgyL0tsS0dYZ3VjRHpUcTVqWlFlS0FIWTFZd2FGRm1Sd2daZHZ1?=
 =?utf-8?B?VndxSlAwVGhtY3NQOGZpS1VZckRaVVY4VzViRXpjR3FWZzRXZDI2eGRFdWNO?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1D/webS/xsA5zWyBfg+UkgsZvGcLgj8tuR18wFONlMOEnofnbO2zI0rnB6/cyx7oEswk0zOBgG1+fBz5+cPV4NBUmRB/NCNzuuPl2b/4ou5cXHSSNXARQoxhq4P0N2bI9/Qf/NJCslklHUqgyudghSKyh5UFCo16ecCu4URviv6qx+nV9ug+4JO23xck+pty+sHZupcbbiWaD+O5QFgQsYPStstkWLOEp7t44oP96SE28oKdd1TxvH4TK3lYuXTsjRKCxXFRuEsZfCVVTnEl7Hde5Tuz9P95nU39grYSwmgR7cldg/xxlcnw2SCnXb4pyXcziMbNIFTo8t6eoidgLWyHYgQDXPJ/wQBGDdlFzDa91dqiTToie3CD4yoVAQUDvM6QGi7ThwmrEyfY9tEo3tZZKMpLcGb/MpQ5GdRR1TvqGN/1XLhDcJEwlnu5MfEKFcJygeRmWMFyhxLVZObjtyeqyG1QAcW8b1IfZ9Efys4zcNA+U81uC3lRqp8fGK+4sd9U9mp9kysVg8a51ofFGCbCpkysonOKfdAVypn6lCrBzQcY9VYowaGRg/oZ4gaguq1QAxG7dMIUJKM0bpkokNYpWhf3skG/v/GY96mM7G0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1741589-c2b5-47b6-6569-08ddefc772db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 17:36:46.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoIjSezM3A65lWsXVAWVNrhE5YBkNqimAGTjk+ZoIh5DB1Ljt4xZjyQ98hN4CDBZb35GHib0iRT6ckGKyzTMUcbRo8wbwg2jlOF5qgB/S3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=897 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090172
X-Proofpoint-GUID: gLmj6bbQqUW7DegZCPyJMYJ5X2nvdIya
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX6uJfDVBvzcx6
 kaJq8sWxVFVadtt9hUoy9x2Tmv5KJm4z1TPjHxAfvkkixaU0OzS1LLVcMc11FTOL73Yd6zwMyp4
 PZB2H5OsQu7JhFj18KG3GviFKd4WzbVzD0Gix2PniCkGUhfMkvHKWAg+aUvYCFQPpogL6ovxyPf
 9Nu1775uLU4XUIBgo/fvwCCACJjR/akTfgpOb3nQLzQ2nWrw4ZHg7MONI8jOGlDvNqW9Zvh9dao
 DwL59DRMOp12KDeHW8kHAf5sMnN9AfFaCflisFAD+dsxbTd8QiA+gK7mmiKt8fpwJ8MelQmBaa6
 Znygncz0QrXlSNuZ/kDhjz6VRS24OebNZi/e+ZCuND8lSft2BnHVhv2R2HLQMo+mInyhVnJ8FLA
 2uMGEDxl
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c065b4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TIAuxHL14tBz2GebBo4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gLmj6bbQqUW7DegZCPyJMYJ5X2nvdIya

On Tue, Sep 09, 2025 at 09:43:25AM -0700, Suren Baghdasaryan wrote:
> On Tue, Sep 9, 2025 at 2:37 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Sep 09, 2025 at 11:26:21AM +0200, David Hildenbrand wrote:
> > > > >
> > > > > In particular, the mmap_complete() looks like another candidate for letting
> > > > > a driver just go crazy on the vma? :)
> > > >
> > > > Well there's only so much we can do. In an ideal world we'd treat VMAs as
> > > > entirely internal data structures and pass some sort of opaque thing around, but
> > > > we have to keep things real here :)
> > >
> > > Right, we'd pass something around that cannot be easily abused (like
> > > modifying random vma flags in mmap_complete).
> > >
> > > So I was wondering if most operations that driver would perform during the
> > > mmap_complete() could be be abstracted, and only those then be called with
> > > whatever opaque thing we return here.
> >
> > Well there's 2 issues at play:
> >
> > 1. I might end up having to rewrite _large parts_ of kernel functionality all of
> >    which relies on there being a vma parameter (or might find that to be
> >    intractable).
> >
> > 2. There's always the 'odd ones out' :) so there'll be some drivers that
> >    absolutely do need to have access to this.
> >
> > But as I was writing this I thought of an idea - why don't we have something
> > opaque like this, perhaps with accessor functions, but then _give the ability to
> > get the VMA if you REALLY have to_.
> >
> > That way we can handle both problems without too much trouble.
> >
> > Also Jason suggested generic functions that can just be assigned to
> > .mmap_complete for instance, which would obviously eliminate the crazy
> > factor a lot too.
> >
> > I'm going to refactor to try to put ONLY prepopulate logic in
> > .mmap_complete where possible which fits with all of this.
>
> Thinking along these lines, do you have a case when mmap_abort() needs
> vm_private_data? I was thinking if VMA mapping failed, why would you
> need vm_private_data to unwind prep work? You already have the context
> pointer for that, no?

Actually have removed mmap_abort in latest respin :) the new version will
be a fairly substantial rewrite based on feedback.

