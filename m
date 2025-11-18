Return-Path: <linux-fsdevel+bounces-68934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E60C68D80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 85AEF2AF80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266A34C9BF;
	Tue, 18 Nov 2025 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cvd1KJ//";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yqO5d2u/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABC350A22;
	Tue, 18 Nov 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461339; cv=fail; b=ea/N3cFzNRsKZ3svkjChN2a7BB1hFkDAQysJk9L+O/3svZXqO9Uur5CTnDx3Cm4UEmfFWy+kXgr6CAVDSK0MsfSwZLsf06xqc/NXFo3sg2oIp20bRU5pHswzAULDVrvYy8sre8A00mnGUY9YKqb+Lblp7ZAbdBA4XLjLiXiylqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461339; c=relaxed/simple;
	bh=fxfQpKoPbPL4UTGprDfLKvtqcYpw5Sm5J5fzXvEJoCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GUV/qtu7Y9jVdeQKbtAQqidtDkT0RGm+PS88T06F/98gvlMN+7YZ5QXLcQhO6HWG3ZIyrMMgKxET9T/wLtiCEpfhyDA52hFjo0EnbRdVLnnRNq6/zKyd54Ju/Uaq+ukuZZWDCqO2q9/OJWKs1/32//mpGKWkL5Aa1QfGmjOKhNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cvd1KJ//; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yqO5d2u/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9CFhE011898;
	Tue, 18 Nov 2025 10:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tfLadxyFUIoB2EiGP3FnKMAb5M8V9/FwQFSiexD1zGE=; b=
	Cvd1KJ//HQoiu1FG8anPMNolrGswVAjlCbEzWAisGTNC6GJF0BfjTr1aOegLdS4H
	1WoHjZ0aDOkJFaNjyrW1ptjMCwBMp34BF7z8Egk6njlvv99otPlnZISB3nKS1kRh
	JEKbeps23Z5UY8Vl8N+2ZZWLRR9mMBL+Kv1QgFXE3DEL3kM1+ekyi+zeq0cs37rA
	0ucZv4UbLU8OZyLJfJ6VGN/9cimPh4+wiosufB0YjLtnfFH/fJfIKq1mdepKRVqZ
	Otiff6M5H8DaY1buK3JSjQIqjaB6Vu6KqhLV/9dXSEQGTIfXUd+rfql6+eBGpSWr
	4vwfkGaEsjbp14mGZOgUWg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbcmwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:20:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI82AVO004281;
	Tue, 18 Nov 2025 10:19:59 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8pqe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:19:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHn3ZAwfGm8n2RObV4NOMI+hWmNsdFwWTbsbPiaXJC/ZxP3kudh/V/CDaafhSFw5ahwEdT58yM7sj5vBlhu6/oBF9HcWoYYeeT8vB9WRDDnj9JcNRoLAh26OdWhVXNfSv6D460WkTImtGqCADZMw0Job+hFCi4XwlMAV+H1tBTGoR/aiMko+zV/SyEpZmo+o2GLwxK8Mujuy368rtfGf016MM3mFImMJXX4Aj4rIUbNZqc4T1ijzW2tGT9oAUX+F+rR6VDJQthzG7sSwFe0AGQ7OJ7z61Z4F58oYBKWcbmUjNSPiMjoJ7uxFKPLOpo5H+X+E4Y0BVy2AZ2cwpOW3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfLadxyFUIoB2EiGP3FnKMAb5M8V9/FwQFSiexD1zGE=;
 b=DPH/Ijf9ByfnzLKuIy7sL517ekl/YIubg6Bzkm2Y/3gASG7C0ohf4pacP34bY+MmxhsdyiAS7SjoxjvKkPMUmGKFGm74uAvPqSKO1+InzwbOVWkgfOt1QQLf2MZ7gfdDJDEAJcSONC0xlU5VHdPyqbuTdSpq+0brXY5e92tKjrao1OLaUby99Wn8iSUKZ9eCK5h8kf9wtD/rtHhyNmfmrh8TYyOddAYNaXUt5sxNFcnJz6NWwE/Q4SaBsDxVJsz3V1vcpOLZYwD2GYZSXxk36bOiwx+yW5IQt0Gy+tcvt+OJAodBHa8F+Usp9mybYX+n/exr47p5eGaqDvHXnyjJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfLadxyFUIoB2EiGP3FnKMAb5M8V9/FwQFSiexD1zGE=;
 b=yqO5d2u/3GX1/sg8mrq1/l1m+zZNSl5Dmgxz5Dmztniq8+bL3DHSkD1E2eUo8L2M0V7fXIJCuGC2wYvRCPExHNkvKqdWTN1dnMepETnpT2as7VqzmQDVxCFJhw0+SNTQsbaGdYYBK2lfkdEkffwnpPUDvJDC40MjAAx7SbuZvos=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY5PR10MB6045.namprd10.prod.outlook.com (2603:10b6:930:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 10:19:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 10:19:53 +0000
Date: Tue, 18 Nov 2025 19:19:43 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com, david@redhat.com,
        Vlastimil Babka <vbabka@suse.cz>, nao.horiguchi@gmail.com,
        linmiaohe@huawei.com, lorenzo.stoakes@oracle.com,
        william.roche@oracle.com, tony.luck@intel.com,
        wangkefeng.wang@huawei.com, jane.chu@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v1 1/2] mm/huge_memory: introduce
 uniform_split_unmapped_folio_to_zero_order
Message-ID: <aRxIP7StvLCh-dc2@hyeyoo>
References: <20251116014721.1561456-1-jiaqiyan@google.com>
 <20251116014721.1561456-2-jiaqiyan@google.com>
 <aRm6shtKizyrq_TA@casper.infradead.org>
 <aRqTLmJBuvBcLYMx@hyeyoo>
 <aRsmaIfCAGy-DRcx@casper.infradead.org>
 <CACw3F50E=AZtgfoExCA-nwS6=NYdFFWpf6+GBUYrWiJOz4xwaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F50E=AZtgfoExCA-nwS6=NYdFFWpf6+GBUYrWiJOz4xwaw@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0247.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY5PR10MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 687516e3-b68a-40b2-0917-08de268c03d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0RmbFQ2ak95WVViMFBjRjk5SExaanBOVGRGRWNkRHJRR0drcTBIajV6UGNO?=
 =?utf-8?B?K2haUERsbEdxSFpPL0Frd3dFTDhhYW9RMHoyN3duSUVnMFM1MW1MSEpZTXBG?=
 =?utf-8?B?ODhIRXhsZ2g3K3h6MXpiUHNibTFOU2E1OTVPbHJaZ2VMU2hVNFdFc1kzL2NX?=
 =?utf-8?B?Tjhvd20rNmtYSUhYT25OT2cyR0pDMThtMDVBRjBVK1VWaE9MQWpWcE95c0hG?=
 =?utf-8?B?TjlINXRldk5oMTMyaklrUlhYY2Irenp4bEgvNlFGbzQ3djVKSXRwQUlnOXF1?=
 =?utf-8?B?ekNsMUJMOEVadkNpdXhCL3VEN0trUlJTbTQvbUhZKzc0YWF4U1ppSzlaVitn?=
 =?utf-8?B?c1JKbHhwU25OYlp0ZmR1ZDBqV01mNG1scGJvZ0MrMmhJdWZhOTgyeUpOVCtW?=
 =?utf-8?B?cDk3OENNZG1CRk9QNTVBbjhGRkd6VDNxMFhyYXVvaTF0L2NKNEZOYnF4aTRF?=
 =?utf-8?B?ZFdlV1M0R0VraHRQTDVsSXRqdWNTRFFwUThYV1hwZmFnU2FLR05LdFFpSERR?=
 =?utf-8?B?MWNLREFkMzZZTS9VYzFkL3NpYkgwenJHaEkzZTNZYVFtWFo3MWRIT004VFpC?=
 =?utf-8?B?M08xOHlJTmswMDkveU85ZzR3MjIvYmxXQWNCUVA5S0puTXM0a2ZwTUhuUjZa?=
 =?utf-8?B?NVNmdVNZWTNsQ05WcGNTWUQ3aDBCeStvREdjWUNUM1hwYnFRTGxodkF3MUxn?=
 =?utf-8?B?SWhJZUlVbVlWaHVxYVhEcEVxbXVGemN0MW9SbTB2bllNQTZiQTZXQXM1MUND?=
 =?utf-8?B?SDQrdEtGZ2dWd2Y5UXJqaUdLeGdFdUJRY2NGbXFYTWttT0RRTEtWSjR1R1dL?=
 =?utf-8?B?QUZzL21JUkl6Z0NwaFE0S1prRFN4WGpoMjhYVUpQc0VDbVZhYkZseEFRdVFh?=
 =?utf-8?B?K1R3QUlrUG5maTA1N0NidEhVUHZHejhGNGl4QzNYVzdtbUFvQllFZFZjWVNL?=
 =?utf-8?B?SU9MTzhzR0tlSTc4WmxFeHREU3VpeFlJd2p4RWk5b2lBUFNSczNVd2NkS3ZS?=
 =?utf-8?B?djBxWjdjUlNNVEx3R1pxc2hjS1ZoT3plMGJOclJyMVFVaDBQM3NOeUt0UVFn?=
 =?utf-8?B?ZURFcW5TQ2RzblRib3huNVMxZU9kcEZNSWxJcU94bEFDWEFDaDFsYS9KenFZ?=
 =?utf-8?B?RG0vS25ld2FzdGw5VWR4RkM1d2JRYTNlMTZHUmpZNUVLMHp1SG9ieFpOcDc1?=
 =?utf-8?B?eHZaZ1cvWkxWRXpsN0FVc3U5MEhYZmRPMDhXTko0emdXWUFSb3RBd2N6OHRV?=
 =?utf-8?B?U0FBZ3hLNlAwaDR6ZzJ4R1g2YWFuYmlvZHovWVZobllpWmc0bERVR1YrMkVv?=
 =?utf-8?B?by9yWVF4ZFZDc01wSDE4OEJWdEJuNUxoRGFORTJ3MGk4V3ZJN3NSN3lTUnZZ?=
 =?utf-8?B?WHh4VVllVFJNOHZsRExSb2lxR0NIeWlaK1R2NFNEL1ptczFIMGVXQ0tyTHpT?=
 =?utf-8?B?eEJoNWhvWGpTb0pWaDNBWkRHTFE0bTZzTWZFSVpnRnJpZ1ZXRUpIR0dGempn?=
 =?utf-8?B?Z3Boc0l0YXJRUXdDaUdZREt5UDJ4N0xyVm9PcDA5Z3J2S1oxcFZSaHJoczNy?=
 =?utf-8?B?bTAzanlwVW9vWGtHQXEvNnlXbDhzaGU1V1FwcVA2MFBaN3ZwQW5vZW84SUNp?=
 =?utf-8?B?cmVvSWE1UWl5TUNPZDRsVzZ4NlU2ZTZOaGdNK2M4Wk5OT2V3RWtLSWh6bkR3?=
 =?utf-8?B?UzZQUjI2RUw2WXhFa2ZUbmdxdER1enEzQkw0YVQ2Y01DUDNLNjl1eTJEZ2Rh?=
 =?utf-8?B?NVFFZVJRWDV0RlFuZFJEOWVyQVJWa3p5eXVxMmhHV2h0a1NPN3hOVDZuVXBZ?=
 =?utf-8?B?OS8xR1VRbG91bXJEdEt4VE82ZEM2UjZ3VGp4YUI5QkorUGw3ZnExT0hWWkpz?=
 =?utf-8?B?N3FKZGlXNyt6T0ZuVkVpallaRFBFMzkyYTd1S3dXVjZyR0RzS09Hd3NuS29r?=
 =?utf-8?Q?1CCcnLB2aZTtvyL6HD+OJHkJavvJH9cY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0wrV0tUVGxKelFZeXNmSFo5NlgzSW9CU3dadnNCbW8rNlRnZW5OOWtZZ1Vm?=
 =?utf-8?B?cTdmaFdoUTJGekpxUXhvRTIrbTkvUmo5VTVNZ0NuRFc5M1RndnB5cmgwTmxF?=
 =?utf-8?B?V2JtL2tYVGN6WW1xc1dnRkhEVDZzS3BsL2FGOVFHRXlMWjlLK0JSK0M3bW4z?=
 =?utf-8?B?RWFKKzhDZ3dxZEdSK0prb0xUWnc5eDczbkNPVmM1VStWa2dEZ0QxV2U0UWxM?=
 =?utf-8?B?UXZ2Y25iWGJhdUdGdkwxWmNPTEY3cFlzcE9kTnRwZHhJMmdpbURyRmt6OG1B?=
 =?utf-8?B?QUZkRmE2VE5STlRzcjFjd1lSSEN3RWUweCtyMXRDRFI4Q1ZycXEzclgwYS8z?=
 =?utf-8?B?c2RzUEZ1ZWErWVNQZ3ROV0pRT21DaDJhRTBZcGZRQUliMG5Ha1FZYkp1NFlE?=
 =?utf-8?B?V2xmZmpEN1NvTlJpWDBUY3BqNzV3dE9oNHBuMUI5T2dxaG5CdE5ad1pMRnlG?=
 =?utf-8?B?K2E5RFRIRm5Vb0xCc1I3MWtuaEpnK0tBa0Y0TUc3dm95MEdpUTdXeS9xRGpv?=
 =?utf-8?B?RkNZMVZaeVRuQ29FK2FMS3AyUVBoOTBGZFArZ1ROaWdkODUxQjllOExzR0Rs?=
 =?utf-8?B?RDFQeWkxLzdSU2hkMWxUcVVsK2w4UVh5R0JqdEtRbHhHdW1NNzJMV3dLcXBk?=
 =?utf-8?B?L0RHcTFvZXUrZ04xdXh3dHJ2M3FCajhBTHpGSzVZYnVtb2JzNFRUVjB0d1c3?=
 =?utf-8?B?SUlaUW9CRXkyeGpXR2NPZmN2eWlNdFlzblhlMmd0S1N4bkh1SWZ2NHo1UGFH?=
 =?utf-8?B?bVUreC9HcVlDcnUrczNTUStXbERVU0ZyS04zQmpFMkt5enhpS3VPY2RMV2tr?=
 =?utf-8?B?Nm42dC9JMm9MZjIxRzZGUW4yR09zWWdrT29DZkY4UjkzRDRqSEpUbW1rL3Ux?=
 =?utf-8?B?QWxCSFo2M284ZE1wd09KMi94T05pTjdxNW5lMk5CeGEvbnVTcm1GcmswVjFt?=
 =?utf-8?B?NWJ3ZUNFa29zTGh1OEtHVUozZW9peFlSOHFwdGJLVzJ5bVBCeVpsS0hqaDdz?=
 =?utf-8?B?OGd4R3UwWml5T25Yb0JqalVETHc5RFFXbnRKWlNJQ1Roem1sN0cybnVqWHlK?=
 =?utf-8?B?a25aa3pidUN4dENBTzNSS1NGWkNoLzhMR1ZDZndzaEgwWVBpK1Q3UTJPNjZn?=
 =?utf-8?B?MU5hN2NiVUE1MkhGWmRBRHM0ZC9lc0xvUElQREt6MVdLdTQrbC8yU0FvdlJG?=
 =?utf-8?B?OFRlRWdFb1d3bTV0N2hwZkltRi85a05aTHI3cVVVcVlwc1JDQmM0TkxoQzEx?=
 =?utf-8?B?dTkyNjA3TEpuVXJMWktKSVJqaGd6U2E3cDYxVmVRMGhrQ3BMV1BodUFLdmRj?=
 =?utf-8?B?MThOY2p2ckQ1NmZic1pLMDRzSEwxdHh6TTNtMlZFMWZjWG1OZTdKSHlpN3I0?=
 =?utf-8?B?bmZaRzd0a3JTZWlkd251YVVTTDZjNkpQWkJyRmMzbUd3bWhsQjFLYjJva015?=
 =?utf-8?B?VG5qNXZ6UjZNV2FkRzFneDQ0TEc1Y2JQZDdHbDdOdThVRGl0V2JrQllTbDVY?=
 =?utf-8?B?ZGxDZDNlTjVkajdXdm8wOHBkSmd3K0p3aFlYN2NSODBsTU5LbVhreEdrNmx5?=
 =?utf-8?B?dnRRdUhNeGNlQmpXOVVnbWV2WGVyUlBvWC9kTTMyeVJnY1QrQ0RRUWRMZ0gz?=
 =?utf-8?B?U2FqRk1JeVRPaUVzTWJJVEpMdHNrOUZkMmtDNnNDT2xBbTN0LzdxM215LzRV?=
 =?utf-8?B?dmdKNzVQY0ZOWEdGTDN4R2hVN0tDbWlOTTZPaENSNTVqRWtrakR1elNDTjM5?=
 =?utf-8?B?MXNRUFJYKy8wajdkc0pxOVBTT2p4NUlrSnRzbDljcVBnZjJwN0s2ejNTaEp2?=
 =?utf-8?B?Q0FYTUd2Y1pyVHVUeUEvQmtzSndwSnFmYjA4cVZJa0FqVEVDc3Bwa1ZSUlBm?=
 =?utf-8?B?L1RSVG5URytsZWZtcjdXZmtwQ2szbnJMRjFOTHFjUnRhWEhGU1h1YnQ5OWdM?=
 =?utf-8?B?M2VCZlJ5Y2t0eFNGTkxwSG9aNTFmRDNhRzhTS3NkTVZTU0Vwc3NOa2l3N2Nz?=
 =?utf-8?B?TzdhbHZxWmhQcVNXRUh1TjVISDZLOUdRcGZGcmxkeUdaVmRmUXp5M04zZCsv?=
 =?utf-8?B?M2FVVWVLYTRRU3c0NDl5RUhaQnV0RVdBY28vMjg2MGYwSlM3WTRiNis2d255?=
 =?utf-8?Q?rt/VrWQyfV5/F1ewUR1LlU1NA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cdvxWzwNBrlUJ11Cs0s+bgfPaVZup+skaMLTrfGMYjarAedbpVH7CxyXYvXr3z0acyYv7L6tUIPoodgOw79k8gYlTapOjsjZ0PwQjrVwQoRpoa9ITE3RF82GaS9djkcyfHk0FJI3v1SdzWICY5t+t7ku0AAcdsTuoREVlDC5osSabRc6N23QDhupy/su1JiVSHYgi3LCTt/aP5hRfoYyPOxxi2fZRq1ekwD0v+59TOj9v24Y6wcpRVb1HRi7snRMaufHiM/0GrNxOv3swZDSa7OONiCwe25gvznrQvqFFhVpTQm/Db3ljOOM8os734yrncelBXU6l4BXV6tEXu78VbwBbuoW08doFEQ9I3jAWihx/5Pcz311KkfoUV9hl0VzRNLSJHdvhVZTq2KH+zKHvpDQ5IMaYGIHcZ+k3JvwGkSAJS3IS73S7Oyf/QzjzMUr1C1U+Y8a3EYH+11LSVkV+uamyvJ/KRUARvHAfHzanoEaoQ94DkloNaOhL/9RANeCzRfI9mZK/Sgz+veX56AhcTaGsyZDu9ZCPc3VKyQGIRqQPQMQHcFb5NlPjsm+YjVx3fK2Rp5gv5DD0oKtahIrTXpH701U8QxW4Qff91OGF/0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687516e3-b68a-40b2-0917-08de268c03d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:19:53.8497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5uIfKezOdSd5NP9DB7hx7tCHf0OZ4u0ObLYPYREEEXB3xgzgm8ewozC3eKtkl5eId0Q9170Fs9cBc3n2Z3YFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180082
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691c4850 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=PDkvYM-1c6ZMK4CKzW4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: QVamD0SrW918-t3poXnfzEadX8I0Vo_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX67KDD1mSHJAE
 WZJytk/3UzXJEiXnJYjjF6IvqimOmnpB1+VLQeB+K/EX2oiDJ3ROqrqxz9NnP1QRuDwVDoM1v6v
 AA4EaohSrbto7SWIJw+B0ydaofvTGoiGqaLo8ldtzDL4K/je9eFN9XQEukm5yG2LCfNtWRjOOfV
 NBBZqa3vbdq3wdeJA0/FHoMRgCi6X2OZD6QtQ4xF7OzIRwOHq0Z3BNXwI1MCz6ujAR0cQhIvXs4
 2imBNdtBkaeGFKOLGr2nWPQKJ4CvdU7T0WrcUWpU6hi1ghLQ2NwLhn+elnfMfo2DsmBXU1+0c5U
 JH6FM7Sh+tH89csRySch/neUxYTMyhTm5cLY+sKFKA+e0kKkJwQtjDlrNsOe+E8bAH67TQ1NXiv
 Wzo14rUyGV0ytJ3ND21d4fhMF3/+DA==
X-Proofpoint-GUID: QVamD0SrW918-t3poXnfzEadX8I0Vo_T

On Mon, Nov 17, 2025 at 10:24:27PM -0800, Jiaqi Yan wrote:
> On Mon, Nov 17, 2025 at 5:43 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Nov 17, 2025 at 12:15:23PM +0900, Harry Yoo wrote:
> > > On Sun, Nov 16, 2025 at 11:51:14AM +0000, Matthew Wilcox wrote:
> > > > But since we're only doing this on free, we won't need to do folio
> > > > allocations at all; we'll just be able to release the good pages to the
> > > > page allocator and sequester the hwpoison pages.
> > >
> > > [+Cc PAGE ALLOCATOR folks]
> > >
> > > So we need an interface to free only healthy portion of a hwpoison folio.
> 
> +1, with some of my own thoughts below.
> 
> > >
> > > I think a proper approach to this should be to "free a hwpoison folio
> > > just like freeing a normal folio via folio_put() or free_frozen_pages(),
> > > then the page allocator will add only healthy pages to the freelist and
> > > isolate the hwpoison pages". Oherwise we'll end up open coding a lot,
> > > which is too fragile.
> >
> > Yes, I think it should be handled by the page allocator.  There may be
> 
> I agree with Matthew, Harry, and David. The page allocator seems best
> suited to handle HWPoison subpages without any new folio allocations.

Sorry I should have been clearer. I don't think adding an **explicit**
interface to free an hwpoison folio is worth; instead implicitly
handling during freeing of a folio seems more feasible.

> > some complexity to this that I've missed, eg if hugetlb wants to retain
> > the good 2MB chunks of a 1GB allocation.  I'm not sure that's a useful
> > thing to do or not.
> >
> > > In fact, that can be done by teaching free_pages_prepare() how to handle
> > > the case where one or more subpages of a folio are hwpoison pages.
> > >
> > > How this should be implemented in the page allocator in memdescs world?
> > > Hmm, we'll want to do some kind of non-uniform split, without actually
> > > splitting the folio but allocating struct buddy?
> >
> > Let me sketch that out, realising that it's subject to change.
> >
> > A page in buddy state can't need a memdesc allocated.  Otherwise we're
> > allocating memory to free memory, and that way lies madness.  We can't
> > do the hack of "embed struct buddy in the page that we're freeing"
> > because HIGHMEM.  So we'll never shrink struct page smaller than struct
> > buddy (which is fine because I've laid out how to get to a 64 bit struct
> > buddy, and we're probably two years from getting there anyway).
> >
> > My design for handling hwpoison is that we do allocate a struct hwpoison
> > for a page.  It looks like this (for now, in my head):
> >
> > struct hwpoison {
> >         memdesc_t original;
> >         ... other things ...
> > };
> >
> > So we can replace the memdesc in a page with a hwpoison memdesc when we
> > encounter the error.  We still need a folio flag to indicate that "this
> > folio contains a page with hwpoison".  I haven't put much thought yet
> > into interaction with HUGETLB_PAGE_OPTIMIZE_VMEMMAP; maybe "other things"
> > includes an index of where the actually poisoned page is in the folio,
> > so it doesn't matter if the pages alias with each other as we can recover
> > the information when it becomes useful to do so.
> >
> > > But... for now I think hiding this complexity inside the page allocator
> > > is good enough. For now this would just mean splitting a frozen page
> 
> I want to add one more thing. For HugeTLB, kernel clears the HWPoison
> flag on the folio and move it to every raw pages in raw_hwp_page list
> (see folio_clear_hugetlb_hwpoison). So page allocator has no hint that
> some pages passed into free_frozen_pages has HWPoison. It has to
> traverse 2^order pages to tell, if I am not mistaken, which goes
> against the past effort to reduce sanity checks. I believe this is one
> reason I choosed to handle the problem in hugetlb / memory-failure.

I think we can skip calling folio_clear_hugetlb_hwpoison() and teach the
buddy allocator to handle this. free_pages_prepare() already handles
(PageHWPoison(page) && !order) case, we just need to extend that to
support hugetlb folios as well.

> For the new interface Harry requested, is it the caller's
> responsibility to ensure that the folio contains HWPoison pages (to be
> even better, maybe point out the exact ones?), so that page allocator
> at least doesn't waste cycles to search non-exist HWPoison in the set
> of pages?

With implicit handling it would be the page allocator's responsibility
to check and handle hwpoison hugetlb folios.

> Or caller and page allocator need to agree on some contract? Say
> caller has to set has_hwpoisoned flag in non-zero order folio to free.
> This allows the old interface free_frozen_pages an easy way using the
> has_hwpoison flag from the second page. I know has_hwpoison is "#if
> defined" on THP and using it for hugetlb probably is not very clean,
> but are there other concerns?

As you mentioned has_hwpoisoned is used for THPs and for a hugetlb
folio. But for a hugetlb folio folio_test_hwpoison() returns true
if it has at least one hwpoison pages (assuming that we don't clear it
before freeing).

So in free_pages_prepare():

if (folio_test_hugetlb(folio) && folio_test_hwpoison(folio)) {
  /*
   * Handle hwpoison hugetlb folios; transfer the error information
   * to individual pages, clear hwpoison flag of the folio,
   * perform non-uniform split on the frozen folio.
   */
} else if (PageHWPoison(page) && !order) {
  /* We already handle this in the allocator. */
}

This would be sufficient?

Or do we want to handle THPs as well, in case of split failure in
memory_failure()? if so we need to handle folio_test_has_hwpoisoned()
case as well...

> > > inside the page allocator (probably non-uniform?). We can later re-implement
> > > this to provide better support for memdescs.
> >
> > Yes, I like this approach.  But then I'm not the page allocator
> > maintainer ;-)
> 
> If page allocator maintainers can weigh in here, that will be very helpful!

Yeah, I'm not a maintainer either ;) it'll be great to get opinions
from page allocator folks!

-- 
Cheers,
Harry / Hyeonggon

