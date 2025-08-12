Return-Path: <linux-fsdevel+bounces-57535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F74B22E45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678E3164963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68682FA0E9;
	Tue, 12 Aug 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a34V+CiP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zKIeVKh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F862F90EC;
	Tue, 12 Aug 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017270; cv=fail; b=Lfm2hCv3gr+OkhWe9dlMIZre9hT1pSASIyPts7xHvcoWFazNBsZMKL/vWLZqXZKLW0VxsYr/vkmhktWU46fjNZPUb8V3yVNAjlWlt47MrvxLDaOz15/GkGlJrzzNgtqcE2DL7wwnqSSoB2MqtUqtXrmiSBBu7zTD6+F+UAoPojM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017270; c=relaxed/simple;
	bh=PPA6TnlgeKlGl55tQbAmFLwV3cDQklXS0Tgj0bOdMWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T6hNXeDo+8WN5lqEKToIrLrdV+1A1GB5GVvlI2dZnObiZnIDJgfLnxo0PLT+yIcfyd7YQgygSXFiC+knVDRjTO1r5XdIBUUthPIj2+IbV4AshUdZfqkAdGnfwhe0eWQSLgU7Qe2WgvE6bdKe9HkQPLy2bTqHcHkonQKYgQyDKAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a34V+CiP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zKIeVKh9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC7Fd006416;
	Tue, 12 Aug 2025 16:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vIXQiXoFMRtV3Oe+QY
	OqM8wgM10/v7H6YDzqdUZ3ORo=; b=a34V+CiP1eqInxHujNJv56fu0/3czE/YnV
	xa6WzOwEZ7LEbePnNF+BeU4+2uA8RXIESyVEAdexbJVHEhr48XxZeJCSHgDIAb5h
	PDDYSzRKJFG4uANxwkBM79rCwtRRYmYRmdG0QoiPhPdFhP8fNk/w4+vy5lrzftsM
	lLSe3lRF1yXxVxKjhm9caCq/jVmodoHCFB0j5ZDci0WLK1YzKAexIaz6fx+scv1t
	sGoZ6+/1x2s8jo9EH19vvCFO/LlKazc9BMe0/lM6tNohhQZBtH2X8UxP8Zu+TlcU
	zB2lyKlowVyKuWgJ+NPq7OruDdvlM1NHMT0D27Z+SzldIyowrbXw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dn2as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:46:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGeRPn038545;
	Tue, 12 Aug 2025 16:46:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgrqkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 16:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ/c2FVhi6NS0MvoyIO6g68h8ONTHymnmnNxjLkQBVgu2P0Q/8N4iRy7Q0nZbntTHzkU9C8fVOWIlFn2xtn6uLNFqENFqlP7cvP37kyiaLE45tLezKYLixHUOW52iNFQtAGumBoaPKLTOdluhfa6GjKEFdQbhggXoapwwjMRDdfvNpGPqE8vW0g3BGyOjxlNgl8ddbQtfdE+QEZ0QB4S2zlRgHwdPcuV+YQKKe7Ub7cDVOyULNits43uS6RaFy7Uopo8rwX8ih0oSd1Ya976NUjEARxFj5oTmxRZ3vh8hASRB3bt9fTGr5kGYp8wHftoWogu5STbbZ2zQYgcKo/3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIXQiXoFMRtV3Oe+QYOqM8wgM10/v7H6YDzqdUZ3ORo=;
 b=KFjjXHL9X6FDr9A1Z/o58OJnSNHEYKUq3k5I6AvLol/d3xJr9HuUC6t2WaxQd0zOdnnfs6wyngOdu6+WoSv7eUSZWbxBIYaW9eVZXIyKCoRcxnrrOsJXl+1vh3RtAppAkS5TUU5uWkEwBA7LuhaFBm8Zqi2YP4TGr/2vJCY7u+9fz1IEZoRPgtd6U2Osulo4GHYJv/OR63DuBS63Xux0RnBFy/ySt9m5+IWaaXbZyN76KMGSJU4an9cbKWx0sbDS1ZBfl2bPqVaJKp/gvgcXk/qPOheOFTifEBS8EOxbXKIrjQdQqY/MGuiOsXHfsfdGGFNz7kl6rXdvEFkPVinpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIXQiXoFMRtV3Oe+QYOqM8wgM10/v7H6YDzqdUZ3ORo=;
 b=zKIeVKh9x8mAdYYMlz4F6HEGcqtjU8wmkyIHcZQCm3gX1fOfN9VctpfVRbfEMAOSuFSGouMEB9pbCgLyD4p8D412wk3d87toHIwfOoFlniwsUvCJ8WlikR1CtScZNyFVvLQrhw75XcUbu7rEORZFxc//C8BpotYFshjzXokW0+Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7263.namprd10.prod.outlook.com (2603:10b6:208:3f5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 16:46:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 16:46:54 +0000
Date: Tue, 12 Aug 2025 17:46:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
        Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Message-ID: <b5ca3ef2-bd36-4cb5-a733-a5d4f1fb32fa@lucifer.local>
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135225.274316-1-rongqianfeng@vivo.com>
X-ClientProxiedBy: GVX0EPF0001A050.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::49f) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 510f753b-93c9-4267-5616-08ddd9bfd818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HmAQ4N5jY+P8h/io9wxyY5BPyaCXY8p7MlN9otEO2Pe7YfV2/hysCCcaHE+i?=
 =?us-ascii?Q?YdE8zQp78SQxVTIT/4lN1v/a82jBM1K6Ubk2g5d6Y70K7kRRQBiPeLWz/oKk?=
 =?us-ascii?Q?tkSpGveN2batUUbUsFzAgbO/u6UigwwX2EFUHVu4x6x6ZiPdtvGpVWe2XjNf?=
 =?us-ascii?Q?cXpA1SbUo7hIOvcQ2S2XtiRYWKhieWtG6tr56A5vBC4hiQh8Qx/QVLeIfuFj?=
 =?us-ascii?Q?AK8hPFjKiaFcD9sz6glh2OAD9mCTM3vp097HdaUh4kwrPwEgzHzzmka6MOEE?=
 =?us-ascii?Q?NMMdMBIKI8KiEOjancqz7mI6TBNLZMy4VyDLqtgD4Njkh3mo2kaVKEqFhAbH?=
 =?us-ascii?Q?dw1/E04AssIcFGWBJlEMgEn0Ls/7Ce8HO/yzm2zirur+Y2wHC2FRspiVqZIm?=
 =?us-ascii?Q?kVhi5e646c/nk2GYkt+qmueZU5k4yjUHqOLS3mQ0jq6Q/UydJs2nc7dVqwPk?=
 =?us-ascii?Q?PDUG+6zLTmMELW5+6mJwzj7kKmNK/iMkcN8ll4F1lcWAvVABJFImqZDWRFLu?=
 =?us-ascii?Q?HLxPeJm1GF3OZNsUMOUVG2YrWxH0BriH4DdO627Sd8/wa/SbJJ1lJRyICaYa?=
 =?us-ascii?Q?UmKZHNnfmmXWRjeIfvDYrPnQLTSvk6sJtYrLEOLoQTkKmUemliHdLJyeOgo0?=
 =?us-ascii?Q?36GTLgjabkdk5hCl1OKYHdQnhGQ+EMSPqUtZYeoGxTPPRtg3C3WStabmexUh?=
 =?us-ascii?Q?f1L6splzhyt9TR8OIUgHXeTbm1NIJTwY/DoJnmPVkVHJVlG1tYQXvWERJ+7e?=
 =?us-ascii?Q?AWap+G6+t7v2r9u5qew+g++a0Y43OwP0lFXwNCFHZpwyS9cBv7roDzm3+1NP?=
 =?us-ascii?Q?J6XnYCJ4AGx2Fru4sBR9QsSfKWfcpWdqHubB5WNVyxp0SondxkHuuhc1uiKu?=
 =?us-ascii?Q?jtfzewpvRmQiEPR0Fwj2Jmp7haNNoC61I35pFGM6xOhzxqb/OUASmxGSKtB0?=
 =?us-ascii?Q?PAvaqp78w3PmSQ87bZks1pFL4jX69M2pyT3JddftK1HJIa0Y7FiHlk4azktN?=
 =?us-ascii?Q?A0Q3mHbd9p9kCpPafKe2IfDL2ob2wJMZPCxYJGrUp2rrpejftdpuagE0Yl2F?=
 =?us-ascii?Q?9H73hLLeNTDJF5Nf9gNsxjxpH4XPH2n7AuGZdOSMMOkS6YMPb5JINZhVelPL?=
 =?us-ascii?Q?nL3nCoVBncuIGV7f/SIOzI/v9U7X4X3qKY90Xij3L639Ml9IekSn6e3TWF4z?=
 =?us-ascii?Q?3X+gGsZthFHW+tQT78QQL3xV8QoMCysZekjJ/RNA0AHMLbEfsPPI3tZNwt7k?=
 =?us-ascii?Q?PZ48OQtAK1HfASTZ+lyAv7syoV9iO5ThUhWVF19+q9dhR/C7JdEmJ0GtuJEB?=
 =?us-ascii?Q?4ruNlyOxGksBkeMpXGfCOc7lQfU+CAwdLZS/2gmDIj47JW1XDZWtzjCwQyWS?=
 =?us-ascii?Q?lLJRQVed0+/q1AN0ut7EWfFNU2Uri6BvHpfCPCC9sLT+oTgTN6LHxSxJaUJj?=
 =?us-ascii?Q?91F+n3rCbiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6NZmxdRcIdfv9G//vfefjuVYAe85mzHBtOrLB/I+QcwZNrWDtOnnjEnEQsci?=
 =?us-ascii?Q?zE5o5JkPrsqTnk+GjEbnFjoVx3+6/rD9+O3kVP5a5x9ZJ9I1J+/shlxb0/gh?=
 =?us-ascii?Q?+wKHoSrCEJ9bXSRuaTPv6ISht4siOfa5V+Qk6oeG1Pwy1Gx63sMz/fGkmKvA?=
 =?us-ascii?Q?KBjpp1+NPqaIX4oJYrQxNeQoU+Z9zFr0KkZ1Zchn3cgfi7spocBxZdtTyJaS?=
 =?us-ascii?Q?gSjxllu7NNepiR7kYID6O2B1UyUSpgp0Ef955jpIaQRGLZR6wgFpIkICtnBs?=
 =?us-ascii?Q?A3E7T5/Oc6eGXd1kktW2uDKl981uhBZh/AxxEeNbrUR4SWjBY2JiBy9YC4Zc?=
 =?us-ascii?Q?XKG46wd+LHqpmFNzE5WprJTT53thed8hINO6LBjf9/QwT5HhvQn9988mTFi4?=
 =?us-ascii?Q?JLvzqPpF3pt4mblAdnnckB38uCFZ/Xecjo5KQtyQe5E5Nxe1qrYgP+0sCMmI?=
 =?us-ascii?Q?4/C0EDN+o+9hUn4g9cuiUBp+H+7jFJtvDLxWuJ52+eNgXbQBlrU3kecYWL8l?=
 =?us-ascii?Q?XXsfSREds/7c5BjZ3kPz/m2afAEbDtQ/xIgqnQMvt10OZiOyqtdRsGFjPmhr?=
 =?us-ascii?Q?PD/WEy1SCifM0UmNwkNhzr55NA+yrWRZY5okYJelUf8wjJ/EmMEVYcTI/s+E?=
 =?us-ascii?Q?uTIncE/YFP6OC/c0FDzg/spKhLTZMAIHMe1Rn1ThRdJUCZwmr7OPPuaSwW3a?=
 =?us-ascii?Q?0Mu6xTsMXjqAc78k5N2avvn5n7Ty2JV7n8+qBCGFbX7is2HJqI9lLfN39c8Q?=
 =?us-ascii?Q?45+0e/+yaoVzQqy6XNprWvzTRsjkiRC7oWqRcVj0PlGZRAo2a7V2IZiXedYJ?=
 =?us-ascii?Q?Ol/pKAEIGy5p+raIXs+AycZ9SCDIeJTNVwrL2aMiNT3UcwqfnC0EMaYVRQ2P?=
 =?us-ascii?Q?UwOjYv3sH3CLt1BlDfMyESL8RKtusLgd0XrjUYfMTbUm9OUe8zq5SCJf4l1C?=
 =?us-ascii?Q?PQanAvvZbnPsE4yAHAc7MSLztUi2rPzVANjVZ5Hz1FJhaj9nySq2KIkurrxC?=
 =?us-ascii?Q?AGFTK0pt+eHn7/ZO0IxqSnsMFMEgmtuckx1OrW5mPQ7dF1OJnNOpSCKb2fhA?=
 =?us-ascii?Q?nTARaizyxqni8cE2OALiKdtOE3y24vfWvh22bVpwZzYCsuzzjUmDSQL98wSp?=
 =?us-ascii?Q?Uk+krXpF33gCZEcdek/7vpRdwf0U5MQ3Krh2uuskOeRbFG/l1eR1iBxtAbPY?=
 =?us-ascii?Q?bPHw3eC46WjsSp7h0KFZ9RKDytfCT+aO6C70H85mCL0nmBGB+7OrXhbFrjle?=
 =?us-ascii?Q?Quw1YROvck9beYQhGZQN6lvxBnA6p913BSwYFKHBzIgGZgPPVTA6k3Z148zE?=
 =?us-ascii?Q?BhTocePl8kmCAIurC3ejxrpOL5uKAxZBGzoxIY+oau9xtuiP6rGKc+R5KUyk?=
 =?us-ascii?Q?bllEjs5yy4d32wiuJH3kBI1HN4Ta0MRuPCjA2d0oR3z8+/8Yr8IW1JaRPZNW?=
 =?us-ascii?Q?3dS1browpPH0S4tLdVI3Jwl/o5hkMHrgE039gnongcmnodLLKs2N0nokL0C3?=
 =?us-ascii?Q?3xq/SQmCljczNXuAUmwJnNVaUlh2jrJuKetLKAq0KntOGwohJN95/65KABzI?=
 =?us-ascii?Q?MPCha44W7l/ZcaElWlOUWcul2XSP5bBEeXr/w+B0NhI40XVWm7UiSqZv0l08?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JugHzX8uyYrAYI0m7HHuKMRV/88qmnPFwtZyQGwepeM6/Ivj7zl4pxPESzG21pu2DIgzKI+7qtd0W9LkjMGB91IefNUbzkCu7dT70dXzBYOYcpEAXnUqU/wJQoFOy1rHpTJYt0fPx28PJq7e/ewi+mXJL7hGxoSbej0lGs92dIRupSy6TR2Xw2xDGotfcz5dXIWgEeVMmy8lt2h4Ebn5KDu8WOsCEHLpG2vj91FeuolNz94h/qNvqXk0qEaO9L0lp1qrc43zGIEcU/ijLJcQCmLJmSH3uu0bCg7kREU18S8R/xdlncGDdvN825zUiDlDXDGPfjRVmAM1u0q2uBFRcgF1UTwVNMkmwkaOaNQnWLwWDmvfIMZLnmZEhKXBcY1nAW4W7HRXKoT+qy2J9/3XNmNw+K60qJWiI3rVYa9UOjC6lTsH0lq/4NkJcYdN45sR4g1147YGeUgC5dx9KvT9wuB5vcBNNioAoBqhMUikAY2zOLYVUospU9GCnMRpqTW+ibnFS+EgrxCddnutQOJrVn7vfkOzikxK/FSMcuPsoqV+IIpbpIpuIIrev98fwxxjJmFnPVmFG4gMxpYj+MZ7FgJkupAEIM5BuFqGUw3wcwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510f753b-93c9-4267-5616-08ddd9bfd818
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 16:46:54.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gD2DEk8XTTtiusabXFQUKsTVHJNUTDcwQHVvxwl/e+2ZsdIdb0inoxOA2kfjLVXwzZ4AXg2zdgKcAHEkEPzPEpj1lFsi8RzeBHeroMwqCfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120160
X-Proofpoint-ORIG-GUID: z37HJrp7zfjoNhHUKZazI9QKuPLD2pHa
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689b7003 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=1WtWmnkvAAAA:8
 a=FxGaXRssHhVewV9F5S8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: z37HJrp7zfjoNhHUKZazI9QKuPLD2pHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2MSBTYWx0ZWRfX1/eRUIGAU0JD
 66pRtpXt3pZRDlx46YuQSzx40WNfDUuq3OTLKK1sfHbkR9kFhk2h4o3iHp8LAD7oZFxAK55tptA
 EoHq0PCMnqmpb7ClbKeXXzXmtY+1gO9dmvF7XljHBSsr2NFl+44Nz5BgzbraMbiEnvHLtrenpug
 OyMoorF5NssuKC2hte3dmzJIy40CpIknP/Th+z1OL6mZ1skbXtpF/g5v39P8SK/olN4OWEFhzVI
 1K8aXykz5pzlVgo18qJDqy5cEhQ6QYnRWt0vIpk1f27DKtQu5AEWDn3Me3c7a5JgAQfAZcBnXmB
 FtROmoFeivR7ZhCk/uhzlpVk3Io5AzAIdY+N7PzUEuzTYTSl6YpWkwu4k2ttAAydFFquU86aBV3
 vNwDz3S1bHQiS/T5fFscpcblYFSzmmV3ll50bbyvdA4tRUQ9+o7pkZV+OLh8E5GgLBXaljJs

On Tue, Aug 12, 2025 at 09:52:25PM +0800, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
>
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
>
> No functional changes.
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

LGTM, I wonder if there are other such redundancies in the kernel?

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v1->v2:
> - Added a modification to remove redundant __GFP_NOWARN in
>   mm/damon/ops-common.c
> ---
>  mm/damon/ops-common.c | 2 +-
>  mm/filemap.c          | 2 +-
>  mm/mmu_gather.c       | 4 ++--
>  mm/rmap.c             | 2 +-
>  mm/vmalloc.c          | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 99321ff5cb92..b43595730f08 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -303,7 +303,7 @@ static unsigned int __damon_migrate_folio_list(
>  		 * instead of migrated.
>  		 */
>  		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> -			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
>  		.nid = target_nid,
>  	};
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e5c9544fee4..c21e98657e0b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1961,7 +1961,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			gfp &= ~__GFP_FS;
>  		if (fgp_flags & FGP_NOWAIT) {
>  			gfp &= ~GFP_KERNEL;
> -			gfp |= GFP_NOWAIT | __GFP_NOWARN;
> +			gfp |= GFP_NOWAIT;
>  		}
>  		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
>  			fgp_flags |= FGP_LOCK;
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index b49cc6385f1f..374aa6f021c6 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -32,7 +32,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
>  		return false;
>
> -	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +	batch = (void *)__get_free_page(GFP_NOWAIT);
>  	if (!batch)
>  		return false;
>
> @@ -364,7 +364,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
>  	struct mmu_table_batch **batch = &tlb->batch;
>
>  	if (*batch == NULL) {
> -		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
>  		if (*batch == NULL) {
>  			tlb_table_invalidate(tlb);
>  			tlb_remove_table_one(table);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 568198e9efc2..7baa7385e1ce 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -285,7 +285,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>  	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>  		struct anon_vma *anon_vma;
>
> -		avc = anon_vma_chain_alloc(GFP_NOWAIT | __GFP_NOWARN);
> +		avc = anon_vma_chain_alloc(GFP_NOWAIT);
>  		if (unlikely(!avc)) {
>  			unlock_anon_vma_root(root);
>  			root = NULL;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..90c3de1a0417 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -5177,7 +5177,7 @@ static void vmap_init_nodes(void)
>  	int n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
>
>  	if (n > 1) {
> -		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT | __GFP_NOWARN);
> +		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT);
>  		if (vn) {
>  			/* Node partition is 16 pages. */
>  			vmap_zone_size = (1 << 4) * PAGE_SIZE;
> --
> 2.34.1
>

