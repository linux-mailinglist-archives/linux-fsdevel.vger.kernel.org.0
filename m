Return-Path: <linux-fsdevel+bounces-34027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDBE9C22AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C65B21BF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B210C1DFD1;
	Fri,  8 Nov 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="THOt+Vkp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FnmD3JMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E4208A9;
	Fri,  8 Nov 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085497; cv=fail; b=KshhLUfgwTHXqgyj1FmPy7f1t1SRpozU2t/lm/xMPUXzQlt6mrOYe41aJTgv0R5b7PpARDUBihTtTKfpttryBiKe7b2cnVhs9DhJAMXX48PEfNMfjvYeEeNnIfHscLBBCWvjsXj9ZaWgdBv7htzvYUHjrX9X7weKKnQ69V0zE2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085497; c=relaxed/simple;
	bh=YpZ1PFgajRbwkjVWzkVOrLtGxu+KcrelRJy6bPsLRdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cg8/AmBsqCbxKqAL18Eghngz6qNdgv5rmEqg8LJRBDLCDcDXQ26PXmGRTlq7+FKfPJ6OmwtercZPXBIjIbqlYdVlhU9YalTEtn0YwXeLhzDKL7SXQO/KFMAbyUv0BcgsX+qTuKlYNNQcpl80u00LNaWaLOAOnlemBcVEwi/dZJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=THOt+Vkp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FnmD3JMD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8FtZJG010109;
	Fri, 8 Nov 2024 17:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IYljErZyL9VHYzKsTd5XhynB2jJrjLy81sIB1hSFGmo=; b=
	THOt+VkpxYG6wWwl634BBnyJpGMdCpFX2oQOr7+bsLGUlcLWCe/ukVZD6E/zG3qo
	4jhgQJKJsrDvb/fLXgNuXyIvMoHiMZgRRbBNiimFPr39j3m40DgSWIh25+PY2/d1
	NDWtuSCjE1RMQamokk80DFrWYMCId0q9TykEkPDgEoGSKhvLekCRg71/n52MzUN/
	jaLrGi8oPOxYpwOglrU6Bwm8xH9bXUm8RZwZg552Qbw7dRUznB/cqkfe6imLol8k
	RixagSwZGA+zUsfPPGQXBI+3UD5BkcrrI8/zaZbio8gwOA9obZi1pC4btR4QBare
	Zk68hr18KwRf9tc44YT1mQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gn1wfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 17:03:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8FGjGt036092;
	Fri, 8 Nov 2024 17:03:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahbux30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 17:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yui/XQEFxsjXkQr0eDbph68vK40t0IXhOM7IH12uNznYG2FhWCdsze5BTIIMbhCDKoTvEv24cHN5fIYHekOzL/DWLmK+U0/TmtnRXpMwubIQyXMUibsZnBC57gaD3E/DqJAJQarwl55szWfIMcZuiOZUUs923E2hQt8gu7SqcqOn+GiFTViaIohONQui0TZL41KOnKOvTWeAE08BDNrtvAXpb8sjV2Oek1tQi2u+XQtr3e7jwyTUq7rdhDHFruSZ4iy/FaHKrWbeC8jER4UfcdclJ/Bw39I/rhM1uJ0rCPtw0JpJKEsjL1A428S/d9obI6YeNDYK7LkB2HnxftHCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYljErZyL9VHYzKsTd5XhynB2jJrjLy81sIB1hSFGmo=;
 b=s/ZUH7INP7IWPgKtVwpWve5hJtC892H1pd57ho7ym6DKcJI8A0upMwN1OYjQGrTUg9MpT3H/Mi+PMbn44ECQ1gOOc81pg4K/tTxOHG+yWZ5yOhFnxANwPTkVD/dP5S/tnp4FLigCvOUjbtyE8KLFP4Ryb7cWbo6fA8VNnmt7fwQpwL/6wqQyV0fTG1n7Ng4FrenLJz8sv4o16mhLr5Vg52NTBwVViM8l2QJFdcN78j6KAOikrUQqaqVulX4pmtINutR1jGZsart503UuDGkG76Ju+fTBQ/CUrJV0Ca1FChnVvzYyg7XVlkugQLUfo53XnwETioGy8DI69D3APkSIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYljErZyL9VHYzKsTd5XhynB2jJrjLy81sIB1hSFGmo=;
 b=FnmD3JMDvCzW1+cCjZKXL5oKmMp9i9TWCXOXkqta+hwfZJVD10uXDrtzqnP6vfKMEC/8Zn0ZvF0dSd2p3adbvjOEcxrfQdu0HNzgfwzEpmxHqZSP1Zhc5tdmbx41gKXhkKnjBDD6L5aJxCvkgOyQlrKjl7y3yDxU7Vo2w9qVO3c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7445.namprd10.prod.outlook.com (2603:10b6:208:449::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 17:03:34 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 17:03:34 +0000
Date: Fri, 8 Nov 2024 12:03:31 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Greg KH <gregkh@linuxfoundation.org>,
        linux-stable <stable@vger.kernel.org>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
        "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 6.6 00/28] fix CVE-2024-46701
Message-ID: <tlzw3ktm7xlspfnvkexhmzvzsuhz5zsd2rw2pjjakmvefup5w2@32ufrnferdw6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Chuck Lever III <chuck.lever@oracle.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-stable <stable@vger.kernel.org>, 
	"harry.wentland@amd.com" <harry.wentland@amd.com>, "sunpeng.li@amd.com" <sunpeng.li@amd.com>, 
	"Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>, "alexander.deucher@amd.com" <alexander.deucher@amd.com>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Sasha Levin <sashal@kernel.org>, 
	"srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>, "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>, 
	"mingo@kernel.org" <mingo@kernel.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	"yi.zhang@huawei.com" <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>, 
	"yukuai (C)" <yukuai3@huawei.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <2024110625-earwig-deport-d050@gregkh>
 <7AB98056-93CC-4DE5-AD42-49BA582D3BEF@oracle.com>
 <8bdd405e-0086-5441-e185-3641446ba49d@huaweicloud.com>
 <ZyzRsR9rMQeIaIkM@tissot.1015granger.net>
 <4db0a28b-8587-e999-b7a1-1d54fac4e19c@huaweicloud.com>
 <D2A4C13B-3B50-4BA7-A5CC-C16E98944D55@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <D2A4C13B-3B50-4BA7-A5CC-C16E98944D55@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 3273249e-58c9-4db1-edd8-08dd00174777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFpkcWZIYlhGTUIvMWJhbURyWkZ1ajJVTTkyYmtMTTYyeHBHZFhzbWF1K24x?=
 =?utf-8?B?TE44SmRvUFIvOUR3RFUzbUw4S21mSFpKVm50Y0F5SkhESjZuTmp2ZU9IYjFU?=
 =?utf-8?B?a29uN2o2RllTeFFZL2t3QmpoQllpdXBZWTZaYm1OWENFYzJlTG1XUHphTjhx?=
 =?utf-8?B?RzJzOHBNVzZNemZueHFHcU1tcVJDSUd3c1pGcUZmcnltTk45aFZkOFYyQ1Fj?=
 =?utf-8?B?QWozL3ROM0F3R0NkUkM3S1RjVnZBVEE2cnlzSFFHazh1TnBVWURwMjFPN1Nu?=
 =?utf-8?B?d0xXUFY5eU9tNlY0SVBjYjkzTUJ4aUF1dStWZkJLcmEzbldzZkRLU1Vpd0E5?=
 =?utf-8?B?aUp6b3FmMjBlVjFUTUQ5dDRXZjBwUHBTbWRQWkZBUko1dzZlbkJidXRPVlV1?=
 =?utf-8?B?ZVF4bWY5YVNKMk1lSkZSdGFFQm1ndDRZY2phV0R3MEhEL0pEMVlBRlJyOXVQ?=
 =?utf-8?B?RGdCTS9qcUs3emdvUEJldHl2bjMzTzhKeG1acFVjNzVnT2lEdXdZUnhtRWFl?=
 =?utf-8?B?WEJiWEFEY1BKdXR1dlIxSWFsYXNhMlBrN0RkVmFTb2RDc0tWS3hvemRxT1RB?=
 =?utf-8?B?ZjZ0aElSd2djY0dIcjhkNG91ZU5WRnJsK2RoYktacmcwSnhnNlo5Tzh6TkJq?=
 =?utf-8?B?MFlzZ3ZmaFF5QnVZQXkyb2krc0hDQXV2RkFvZCtHa0xkNml5UllQWE50cmRh?=
 =?utf-8?B?YzBRQnVnVEZ0VVpaaElyTEY2bjFjQk44aGFkT3BURFA5akJkSldNMm44NkV0?=
 =?utf-8?B?RGJXa0tEaEE5cWVVNExOSnh3NXpCNDU4S0RCeXMrZzkxcWd1bHducnlOa0lB?=
 =?utf-8?B?ZTEzdkVacTFVTUhyTmJCZ2had3FLOWJrZDZ6dXZsWmdEUDdIRmZuNUdVbHQ4?=
 =?utf-8?B?R1FHenUwMTFmYVZETkRSYVd1a2pvQjByNjA2QjkzektUelVDZm1PZDBneGcw?=
 =?utf-8?B?Z1hXaTk3eDZuMjg1dmJLTHpUb1hHRzkwdzBoVFJzclFqR1hvT1NXS25yMVc3?=
 =?utf-8?B?QVZtcVZsMTliSXpNNHJQaU5kQzk5OTZvQWJLTG9LTkkzZ09ZQmd1UEowa1By?=
 =?utf-8?B?TGl4WDByRmY1WllkWkd0NlZFTVRLaGVrOHNIM3RmWXZvV1JUbjF3R1ZnaUtK?=
 =?utf-8?B?dklneFhkUGFuSUxIOWlWMVVnWHA5OEJOVjBpSFRPYXFtRVc1dDdhOWVVSnBM?=
 =?utf-8?B?Q1pUVlpsOTRBdW5BVVgyekNIMEVhQktGVGptVzhaUy92R1piYmVHdm5LMlNu?=
 =?utf-8?B?aVlZTlRqbmtSeEJXYnJyaVo0SU5rY2dKNXhiSnplbklNdkRsNmR3dFJvMU5y?=
 =?utf-8?B?U2VJcVpwMUtHME8zdlBDVEJVNDRWSnRMSGdHeENveE5iNVJIUk8wa0xVcFFk?=
 =?utf-8?B?amFQQXBVU00rSDBqYW9HR2MwblBVV3lXTURuNnVsd0NMSFVJT1pCQ2R4MDd3?=
 =?utf-8?B?aUVEaFRYVml6Ky94Z3k0TVZGRG5vTmR0d3ovM3dxcEhWcllGcFFGeXJvYm9C?=
 =?utf-8?B?OXJPQUNNaXA4VDY4MG91SUhEbkdLVW5sZVhsWHZ6TU01c0Nkc1RYejBkMHVw?=
 =?utf-8?B?UnFyaW9UZy9jR1F0Vzh5dmNrendSalByajdWSU8wSUl0YUFNTjVCRm5vR253?=
 =?utf-8?B?U0VUaC9YaGVpeXVuZ1ROOGF2TzJEdWZZdEttbERiMTZZRWRZMGJmMVBSSmw5?=
 =?utf-8?B?RklEZVJrSHN4MmdmSVhKTGZtRUVPMWUxc1dVYy9zVVpKTVFNSTJQMm5NNEgr?=
 =?utf-8?Q?sxGUxuU1TtU5dyQDSLcNIZCkO5+ttGA8lk4Zqfr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjlEOXJBZDJoZks3YVpkbjJjSDhWK0dEemtUclg5U1NTYWpiczFwTFUxL0tQ?=
 =?utf-8?B?VTNHVmllS2NlT3NZNm1CZ2NjZjNYM043UkhGSXhrT3pVZlB4RXRqSHE0SXhP?=
 =?utf-8?B?a0NQUE9jRXV6VWpvd1lOaGl1ZGF0YXM1eHF6em82YThOMUVNaWRaTzVrWG1o?=
 =?utf-8?B?KzNPa0hYbktTQnUyTENDWUpuV0VNSU01MmZaN3h4S1dMV2Q4RDFBYkM0VWdR?=
 =?utf-8?B?VFdnWEhRcmh6andzeTFObExRZjJ4blBTdGVpREtBZnczeW5XUElOVnl3Ujda?=
 =?utf-8?B?aGt3VVRpaFZqOU9DdnlSdzdsTHlLUzdpQzVXV29DdWFXOFFzcDJpWXdIQWFG?=
 =?utf-8?B?Rk91OFVrRXlRQytaTTh1UFlSQmJYRFhOcmk4ODUwM09DaHVuRzd1amJqbkRS?=
 =?utf-8?B?dEhxMDg1NU1wenVXTE5CQTQvRzFZVE9hWW5ZSk52WU9od21kVWduMEJCQ29a?=
 =?utf-8?B?UVlWa2pvNXAwS1JiUDU2MTRMZ2dvT3dhKzFkU1NXTVd2djZ0b2h3bmo4N1lr?=
 =?utf-8?B?UHBVcEV4dlhRc2xYNHNSOHJoK0U2TldMSHVqeVJHQTRMamhEYWFoZFQyZWYz?=
 =?utf-8?B?Tk4zVHJCU2c2NlZJaUl0bXpwTWFGbWl1L1RqWmVrYzYzcjBUckE3emM5VFYy?=
 =?utf-8?B?VzlkbFJzdXh4dWJScGNMSUVjVmY1Tm5OL2U3QzBSVGFCakc1b283Vlo0TjBJ?=
 =?utf-8?B?eHpiT3V2Nm1kbERXWEJLdEhabEVOL3VkU1h4TTUyM0FmK1lFc1dlWmlzNUFk?=
 =?utf-8?B?c283a1pjd3ZWcW5xZXFKcGlXNHdyUjd2U2VEa2grOGoyZ0x6OUpDSGJabVZC?=
 =?utf-8?B?c3VjbG4wamVtMmVXdjh4WDU5RVpPY2wvM1grR2VOQ2NFN0ZLRG1WUlR6Wmwx?=
 =?utf-8?B?OWw2TlZHa1lwblFBUForWmlvMjBSZi9xdWY1VlJRVkNHY1AwR3dmYkVXWUZP?=
 =?utf-8?B?dEhBWEhITGVHdUp2MlRKZmljZjhRVE03eUs4T3BlUGVMV1E3RXkwZ3JLWi92?=
 =?utf-8?B?RW9KaGdDcGRIcW5sMFpiYm9HRE5jbnR1bDN5SnZ0YUNDZXh1K3laS1haZjA1?=
 =?utf-8?B?a0lxOFZNM0txQnlPOS91RWlpMlRVa3h6ZkpPZWtXWmgvdkM0aGIwZ2lCa0JE?=
 =?utf-8?B?RFNmUDlscjM4UG9kajhTMFVuY2lXOWxMK3VXSlR5UDFtNklqbWg4cGFqbitZ?=
 =?utf-8?B?QWRNekRLbzYwQld5TFJsZ2R4L2pQUHBEcDdNd251c1Z2a0ZCTE9MK3VJSnkx?=
 =?utf-8?B?QWMrS2lJaXhSVHZCR0FPYkRFRnNKbkRVRmdtdUp4c2RTNGg5dDd6K3BRUzhQ?=
 =?utf-8?B?VXNBSmorTXdjZGFnQ1NmekJRRHJYT1JFUVJJSkE4ZDBEdkR6VjdpT0dlLzRO?=
 =?utf-8?B?QlVPMXFXTGlUTW1MRHdHR3E1RnpuY1ZrUGVYMlE3QWxnRVVMUHRYMEJHTEJX?=
 =?utf-8?B?NmhNOXo1VGFpYU83a2hnM0tmSHpEWXBTakQ1c0dvejVzZnBiY2lxeVFRNCsr?=
 =?utf-8?B?OHhMSVFmdDVXcmduVWQvR0Q5amkrc1NaSkpLcEpxS3NpSDVHQ29qNW9BS1NL?=
 =?utf-8?B?RHRBeStnVncwRjhiVytlMnBzYVFYOVNhNHFaVkhPNVlaNjUxcGJqSWFZMm5r?=
 =?utf-8?B?VkY4emZIREs2bmsyVEtPRlVvUGtEekZBVFl4amhIRWorV3dVK0VDTzNpWmFZ?=
 =?utf-8?B?SkZFL2RZZW5nVVgxa3Q0eXlVTDlYNXhXcS9qQ2dhTTZFYXZ2ZWZBcjdPbGs1?=
 =?utf-8?B?REFlZ3JxbzcrV0hDY2p6TjlnZ0tYdmlETjBjQnN0R0pQR3kvQUpaQ21xZS9T?=
 =?utf-8?B?NXZKTnVWT01JWC9xSWxMNlhRSnE4NnZtSTh4MFhHUmtQU0JGSUxvbytkYVRN?=
 =?utf-8?B?cFZUc2FncjBQdjNaQnhwQW5KU3o0VXo2anBOM2ZCZmFHQ0lDR1l0L1RPbkIr?=
 =?utf-8?B?TjJqQkdJN2ZPUE5nZXdHa0s5NFFvTFdpNzJjekZMYjZMVktHM1lMOUNEamNs?=
 =?utf-8?B?eGRaMEUzUGxoVjFwNVNCS1l6ak94bk85R3BEMFFMR2piRDM2OWJHRUVxRnJh?=
 =?utf-8?B?cWVVUEZaR0FwUXZjQVJVTWl0eWVxZDliMGUrTm15U2dRaG96S0REd1pTcCtM?=
 =?utf-8?Q?r0WQEwGBH6cOZxOA+gUFMDDRl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uj3y1b26dwD5qL6b5vEGEayJeSxl96UZFhCQi5RCt2GdZ0rlmfrgjEFdk2meeuovCfDNXYKnYu4VIDf96wQuOcj/Q4lkThvicjgSHdGaLau5ttAZI5Zd1qPkYb91O5mMSvQAsMV53KMyFC2+2J5QdzsLcZhAaRIcNLZxqWbL8W2ZRHnsSW8GN20ChDzsmzS+xY/ciAFRg3jFrF+jl3hogaEhPYWkmUO7GDBAdFGJPgVFUIGQXkCPCFKI9e/2RZaSuc5CZwVlB1Vb2f0/gQ2IPxqxKdpGOWUKmMmcaQ+zIrwqf9UCG4gwnp8fScaDH+562LnVz5lF2IVlOAqDmqMRM6DAl6Ax472eGNbuhUAa0sOCJbzvoCEkdRkoOl4Opi9uDP8OQEgmOmRvsi5cgwy2aL6SgGk+M6UPuJbl61KQyMgq3x4Li50SI1mbN3oWThfm2d+ErKqSGjc/aObU2J0foMh4xCmZFyVach1vBnU4z5i3wBKTuKW6owX5E6dDAhaq3XNjGfJKw8ok2EbxSSb69ywTlvntfLJP7v2LHdXTvtCF8QsbVd9JRDBPV8I0JVAqyaPE0Q2FBGLeGtnMESEorG5UjxSrthALeniULViXPqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3273249e-58c9-4db1-edd8-08dd00174777
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 17:03:34.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VU11BJvoqBUPF8V0Uvd9NKI9qGzqkdD1dHYk3z8f55D+YANdQuPadHyFOhjZcNt7Tpx+jLeIaTMYk14W8BPIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7445
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_14,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080142
X-Proofpoint-ORIG-GUID: K6dTSEhYCNXUpGXuSWCLAmAshgpeVO16
X-Proofpoint-GUID: K6dTSEhYCNXUpGXuSWCLAmAshgpeVO16

* Chuck Lever III <chuck.lever@oracle.com> [241108 08:23]:
>=20
>=20
> > On Nov 7, 2024, at 8:19=E2=80=AFPM, Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
> >=20
> > Hi,
> >=20
> > =E5=9C=A8 2024/11/07 22:41, Chuck Lever =E5=86=99=E9=81=93:
> >> On Thu, Nov 07, 2024 at 08:57:23AM +0800, Yu Kuai wrote:
> >>> Hi,
> >>>=20
> >>> =E5=9C=A8 2024/11/06 23:19, Chuck Lever III =E5=86=99=E9=81=93:
> >>>>=20
> >>>>=20
> >>>>> On Nov 6, 2024, at 1:16=E2=80=AFAM, Greg KH <gregkh@linuxfoundation=
.org> wrote:
> >>>>>=20
> >>>>> On Thu, Oct 24, 2024 at 09:19:41PM +0800, Yu Kuai wrote:
> >>>>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>>>=20
> >>>>>> Fix patch is patch 27, relied patches are from:
> >>>>=20
> >>>> I assume patch 27 is:
> >>>>=20
> >>>> libfs: fix infinite directory reads for offset dir
> >>>>=20
> >>>> https://lore.kernel.org/stable/20241024132225.2271667-12-yukuai1@hua=
weicloud.com/
> >>>>=20
> >>>> I don't think the Maple tree patches are a hard
> >>>> requirement for this fix. And note that libfs did
> >>>> not use Maple tree originally because I was told
> >>>> at that time that Maple tree was not yet mature.
> >>>>=20
> >>>> So, a better approach might be to fit the fix
> >>>> onto linux-6.6.y while sticking with xarray.
> >>>=20
> >>> The painful part is that using xarray is not acceptable, the offet
> >>> is just 32 bit and if it overflows, readdir will read nothing. That's
> >>> why maple_tree has to be used.
> >> A 32-bit range should be entirely adequate for this usage.
> >>  - The offset allocator wraps when it reaches the maximum, it
> >>    doesn't overflow unless there are actually billions of extant
> >>    entries in the directory, which IMO is not likely.
> >=20
> > Yes, it's not likely, but it's possible, and not hard to trigger for
> > test.
>=20
> I question whether such a test reflects any real-world
> workload.
>=20
> Besides, there are a number of other limits that will impact
> the ability to create that many entries in one directory.
> The number of inodes in one tmpfs instance is limited, for
> instance.
>=20
>=20
> > And please notice that the offset will increase for each new file,
> > and file can be removed, while offset stays the same.
> >>  - The offset values are dense, so the directory can use all 2- or
> >>    4- billion in the 32-bit integer range before wrapping.
> >=20
> > A simple math, if user create and remove 1 file in each seconds, it wil=
l
> > cost about 130 years to overflow. And if user create and remove 1000
> > files in each second, it will cost about 1 month to overflow.
>=20
> The question is what happens when there are no more offset
> values available. xa_alloc_cyclic should fail, and file
> creation is supposed to fail at that point. If it doesn't,
> that's a bug that is outside of the use of xarray or Maple.
>=20
>=20
> > maple tree use 64 bit value for the offset, which is impossible to
> > overflow for the rest of our lifes.
> >>  - No-one complained about this limitation when offset_readdir() was
> >>    first merged. The xarray was replaced for performance reasons,
> >>    not because of the 32-bit range limit.
> >> It is always possible that I have misunderstood your concern!
> >=20
> > The problem is that if the next_offset overflows to 0, then after patch
> > 27, offset_dir_open() will record the 0, and later offset_readdir will
> > return directly, while there can be many files.
>=20
> That's a separate bug that has nothing to do with the maximum
> number of entries one directory can have. Again, you don't
> need Maple tree to address that.
>=20
> My understanding from Liam is that backporting Maple into
> v6.6 is just not practical to do. We must explore alternate
> ways to address these concerns.
>=20

The tree itself is in v6.6, but the evolution of the tree to fit the
needs of this and other subsystems isn't something that would be well
tested.  This is really backporting features and that's not the point of
stable.

I think this is what Lorenzo was saying about changing your approach, we
can't backport 28 patches to fix this when it isn't needed.

Thanks,
Liam

