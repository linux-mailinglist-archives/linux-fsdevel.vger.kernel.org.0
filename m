Return-Path: <linux-fsdevel+bounces-63986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D98BD3E11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E50D188F974
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5293112CB;
	Mon, 13 Oct 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H1vpc0oQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dK3BylL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A27310625;
	Mon, 13 Oct 2025 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367225; cv=fail; b=JIaRDCdYaGN5ABSp1NzmYmpriZ4D2nEZ3I2jTUHjz9/7lz9OzaHktdgersACBedGidBohhqROwQ4aMux/yUfpnpGMU62GfAGYMnlxyucsU44rx7HhfK3ImWnw5wE/lavPsYZZVoTMC+2riikWW28bynmsMVvEbf5DISBooe4NYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367225; c=relaxed/simple;
	bh=s3SdVCgHmzfP4g9pJMTibGJTRGCIF9Bh9uolfn5OBdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ky7SofBjb1DE/fls6LvBOaCfzeXfd4HRT+wCAmqzQY/Mb5ZO52I8TbV4BUSxhGOnHeujYIAeoBxvXK0OcCh0Dke1d4r+MpRaUHhtBQkwcdQKFO0cUsCkSBs0f0GOu1wQ/CU6aeliiR1ThU5HB7CkUF21lP2HdWWljVj62PF++1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H1vpc0oQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dK3BylL3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DEkvPG003683;
	Mon, 13 Oct 2025 14:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7/eLJnKQgPtMHXI6oUVQ9qCOJXloLRXprLkRk4+SRFE=; b=
	H1vpc0oQdGInJkEOjQPNjOTF+KiDrm0rK3Hv4pbCcz7VTSrJkePs0BD8ws5nvCA7
	oQoOXokRuH2qNrgf7BVZen31gJfB/5MrkbwHFuOGGWic9quS+x7cAnnqNSVMlZoy
	jFLrAi6weE6DEYMTqtg8763Wradz5Jhz5/+zWHX6TAtjgjaKxflVrQ/61K6rquB9
	dj14Ev6aNrorhkIqML2lL04kZRAuI3MOUdhuGbf0Zi0RTJl+7e4o6F7Nk3w1nVu5
	guJepeQ/rDDIYG57kUirMgnzHFfqLlBjjV+oB7mxzk9JR5Eqh4//gLc590k26tjS
	vKu9+pbV+wBL68LYeNMYdQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf47je4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 14:52:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DDKZvr017998;
	Mon, 13 Oct 2025 14:52:53 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7dwfw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 14:52:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHCa3d5ccs+ZrYT4eHVZAFPiCPae2nRE0FWfEA7mfIlr6Z3c8bHnKxRd30FsIMX/Xwedv0WkZVw7BBrsG7zIPrijn6FVD2kAsfUQkpnfCcN6sE2b5GK4KPyJodYW6VA7PFnnXOGQWi6dfe/3ShdFEP8QeSFRWMkGfyK6UxqV7j+ST2BxFAoPTxvHvsnvV3nM7eS+sN6jLuHaMFBFjwwciKJuE8Jf9/mC6o2IO/16hN6FtUAAiISFhDb83HbPa2RLhNLwdyNYZCzgF6INZlwvQwkKIwEhfhnrhd3coxdPrGmrcbxQOvylOCiaGLZL+BSQthwWKnOSqGFCZ9t39XAMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/eLJnKQgPtMHXI6oUVQ9qCOJXloLRXprLkRk4+SRFE=;
 b=iC0B9Aqqyi8w7Yafx9ewKQCtzRkb668XjrXii6v6sGIW5ClV8PkV3g48b441zKj4GVqOiIwRPVd2Du2P+n/Tq2lKEwWZ0bh/D/LW7VrATV1lbBcmntJSTtfS/3ag6+4J1Vu/4YlkNzeG2AffLTy4U2MtqYlozrgOj4Ou7xcapHM9vjXqXG7wJakalYUzxqsYnYAGMHweoZk2nw04B0ND0g6kGmDZt/dDfPeLeAKardBJjbuN03ICNuvR1nyTKgb1g1A3vTFgenkKcp7Tws/+yBvns8hRa0ovu894rh+joEb0Ki7SD3t1AbZ03gfb6w3Q0qCMKbV8qBYAn92SwEw5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/eLJnKQgPtMHXI6oUVQ9qCOJXloLRXprLkRk4+SRFE=;
 b=dK3BylL3hFGahN/IDK5+RMLAbFEDTkItsYYd6blUxQCINO5WEIV0fx1aSLlQsDxg6H4XR7UCBrH5pfXuYo/XzfoQTJ1p4gEYNg4YnDhJM1nC1TiJeQuKIAg7HN1fXmMh3GQYSnc20HvHqQxPM1guov6nbB4XZdQIi2834Yx7jv0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8663.namprd10.prod.outlook.com (2603:10b6:208:571::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:52:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 14:52:50 +0000
Message-ID: <846db8bf-6e5a-4a2c-90fa-3d4ffaf4c1de@oracle.com>
Date: Mon, 13 Oct 2025 10:52:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] vfs: recall-only directory delegations for knfsd
To: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust
 <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Carlos Maiolino <cem@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, netfs@lists.linux.dev,
        ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, netdev@vger.kernel.org
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA3PR10MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: d01fd30c-5f51-49d2-2346-08de0a682e1c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OHZFc3JoWEpUNWdSZXREVng2WERwVERCaFV6K1VQa2dIN0ZZTEFmcDBaYllV?=
 =?utf-8?B?bjBpcHJsdi8xbll6bzJsa0RnM0JDZ2dJMHEyK1ZjWlVHL2VDTUlTdDZLaVZF?=
 =?utf-8?B?WlZBYzAwUUh4VXhQUVFYcFdPMXJzdDhyRVg4S01CQlMzcFBXNjMxVk85QkFK?=
 =?utf-8?B?SXVQb1FKcDFTb01GVlNBblhTN0xCLytEeFA1cUJSUGk1VFRzOXFXb052OEV4?=
 =?utf-8?B?RzRzWnpoN3c4KzJqaGlYaXNNK1p3N1Q2RWRENE1DdGhrUUx5Mk52VXpIREVj?=
 =?utf-8?B?N1VReTFrZnREQ2QydDZCVTVrVnVkSkVYeFlGdTlhVjYxMHN2d3FSWGRCUllS?=
 =?utf-8?B?UkxpOUI0aWwvUERhMWFmS3JKVzdsRlJpa1pEbXBjOENhbDVKWjhDRkp1WU1D?=
 =?utf-8?B?ZE53Vkk1aitiUG1kVjk1S1hkdmYrSHEvcnJpUkdEOWpIRTZqVkRRTzZoTWti?=
 =?utf-8?B?U1pLTFBNalRBTmZkNVBuMktqTjhoelpWcnptZndraEp1WEtFUVNPckZ3TGNl?=
 =?utf-8?B?K0VaOHBpOE9VcU52UXIvSEtha3lUWktaOHc1clN0RVUrQTBPRWFLNDZMNW1K?=
 =?utf-8?B?Y1A4L3QybVp2dm0yemF5RWhkSE9vcDN3VXZSNHM3bmRwenBOeGIyZW1yWEQx?=
 =?utf-8?B?Y2c0bnY4RlJZSUc0ellzQUNsOU1FaTI2MkJBL2paamNRQkdSczN5OHpwWklH?=
 =?utf-8?B?OHdVLzhjOTdwOTlEaFl0QVNBcDg1UnhLdlhIT0pOS2krclRROERJUE1nNmFp?=
 =?utf-8?B?eGdGNkxUWS9ENHdzK0dMaDh2K3RlSkVWbkdHNS80S1RVaDQyU2V0TWlGWUYr?=
 =?utf-8?B?K0J1MGxkUVRkMHhEU3ZjYkNDazZUWHlGWTkya25rVW55Q0Y0RFhTOU9SZmJO?=
 =?utf-8?B?NGdHTGt2R281aldWOFNNQXVVb0U4UGVYbjhNcG9lRWFQZzF4UFlqRStTckZX?=
 =?utf-8?B?ay9sZzZUOThDNUhURS9ROTlGdVY3b21wSTlRUXZIdldhQVhhR0ZjNGx4amxr?=
 =?utf-8?B?a3BHZU1lZDhUM1M0aHVNZU1hQ3RDRkZyNFpOcUNUcy9SVGl1MHVSbGtCSTFZ?=
 =?utf-8?B?MWhpWWtGT1Q4Z3l1T0RwVE54WmlDRWNudFYrbUZKU0V4LzhDM2M5NTdNRUNE?=
 =?utf-8?B?OFAvbDFLZUpMVm5iVEYzYUh3a1hXcHc5RmpqRkZsUlViNFRVUkZwc1Y1ZVlJ?=
 =?utf-8?B?MmIvQzRDRzd2VTFJN29GZ3l3K3NzVElPNTg5UDlhRVhpbjI0REZCejQ5WGFq?=
 =?utf-8?B?STA1S2pVMnExMXIwSTd5VmEzeVh1TUxmOUF3ZDdHeWRoR1p1dUFOR3B2VmxB?=
 =?utf-8?B?RHlkNVZzTkQwMVBBK2gzL2tCN0ZTL2x2VEcwZkM4RXZxaUJrMFhIMGhSbEUy?=
 =?utf-8?B?TUtpSnBhMVNUa0doNmlFNmlydnpIQU5nUWkxWXIyK0RJNUtXa3BDNk04TmQx?=
 =?utf-8?B?bjBmSGdjMWNxWjRBYjZCaHVQcGdFWUdMSXNPdmR5aXhoWnQvNUlhRDkzdklD?=
 =?utf-8?B?TzYzOEQ1YXdjeWh2NERCY2E0SnZYM29tUXRIL1Q3ZHMrOCtGb1Nhb3NDWWR3?=
 =?utf-8?B?SHhMRFcrdkxSZHBlMTc3bHh4ZWZSL2ZhNkNPby80Z2ZKL2FNRGtBa21BZjMv?=
 =?utf-8?B?THBhcmZBQXdlVE1YV3ozVk9UVURqckNNaEdheDJnVEhIRXY2MU9wTmNGNWxz?=
 =?utf-8?B?ZVdnakdmSnBKT0V2bzBRcndJNmd5azA4Mm54WEJpZmFqR1BHOHdqa0JpTktQ?=
 =?utf-8?B?VEFTRHVicy9MRTdqTzBSREM3UEVaYWlqN1o4MWNKK1dSZkJjSDNuUzhibXJM?=
 =?utf-8?B?elZhcDl0OXZVUyticllUR3gvY2E3ZDZRZkhGZXkwdk4ydGgwVVBXUk95bHFD?=
 =?utf-8?B?QnNtRE1iUGh4dW50SHR6ZHUzeEQ0R1VIV3MyQVFxa2dvWTl5b21PVCtwUlFq?=
 =?utf-8?B?dzE1blNBano4ckFFMEtFNGFUTWpjbmk5bXgwdEg3d2R0RUNzKzZrbzR3VjVj?=
 =?utf-8?Q?oMB8avdMk9ORK35RLjcem+lzNL1eV8=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NExMWVBHOWxiS0RpNzQ3Y3NBN3VIVSt2MENYYk45NW1wV0VyVFRPT0RiRzcz?=
 =?utf-8?B?ODl4NkhXZmZaejlza3cxZlArVTRIdStiWi9OcDd4SWdQTDVUREwreHFWUU1W?=
 =?utf-8?B?SFMwQzRuVWJRWXh5N0s1WEN5VHlZdnByekZObW13RytvYlpOWE50N1lTdnUv?=
 =?utf-8?B?TEZyUXNlWEIzZU9ML3dKRHd6Y1NPTTBLaTBLajlvZkIxeTM4bzliSjlsUUZM?=
 =?utf-8?B?TEFZZFRTZE5uUlp4R0tabDJxM1hxUEx0U1ZoZ1plcVNhclh4Ym5IcmE1dHl2?=
 =?utf-8?B?c0s1SVhPVHkwVk1RdUx2QTJMbjhlRmhxT3hzd1M1VDhES3BZK0VmV1ZZcVNS?=
 =?utf-8?B?bUszRk40ckVtOUM1aFF6UzMzSzhkVGdUQ1NMZnFEVENFVFplL1ZVQWJ0R3l0?=
 =?utf-8?B?bVYwRjJ5ejJza01zNjV3RlFQaG50N3BiMVpHbFVPM0wyVGdzcDVlVnJhTWRu?=
 =?utf-8?B?bkhVQjg5RkF0RkZIU2Y4MllYb0Q3QzJ3d0pSUEg5eVJ3UHVJMHdLM25xRDRj?=
 =?utf-8?B?azlLVjAxTWtBNFhJcmFmZk40UGhVUFFIckJacSsyOWZhT1NNQitlcU51ZWFw?=
 =?utf-8?B?dzJOdWw5OEdoeFNwOVkzT2lNK0hxUWEvdEtUTC9IQ3dibHBCSklNNXVQNGMw?=
 =?utf-8?B?S2xCaHNoY0hVUU4wOXpjUUNJT21DbFF1eDRkY2pSM0diY2tNdUxXNnZkNmY3?=
 =?utf-8?B?cEhoc28xcmF2eTVSWnVrK1pTOWlvMjMxaElIWFBXN09NajVGL2RCYU1tTjlo?=
 =?utf-8?B?bnVhV2VQUmpEejg4Rmg2M3h4bTZyWnZiWExmMjhNSDYxNXZkRTNFQUtNZGRE?=
 =?utf-8?B?dmhVRVFnWUJqVytUY0V5WWhscTlLN3NyZlhIZklxN1E4UVpYTFJxRlljN2Jh?=
 =?utf-8?B?TWNaWTBCbUswUUt3VkRBa1lHMlJLZ1VycWhJcitMNDdXSTZaZWdZaytUck5K?=
 =?utf-8?B?QldXdFVxdXg2ZmNjcjV6UStOT3l1UVZBY2ZBNWxXcUxxdVkvemtJeWt5QklH?=
 =?utf-8?B?eFdteVNmVWZTbXM0aHByWjJteEErK1hmUUJPeGRnVlQxN3JTdEt6TERpNXdY?=
 =?utf-8?B?S0U0MDIwL1hYV01HWW1rUDJEaVZQNEI2Vlc3WXhqcVVwL0N0YS9PWktaM01H?=
 =?utf-8?B?MUdkRUY5emJ2R3gycUdkaU1JcVVnUjB4ak5TYXdSM1RRTm82blVFZ0ppMXJX?=
 =?utf-8?B?dzlOWUtCSGliOVcwc2VuTVJRVWEzMlBaMzl3SGNJZVF0NGZQRDU2RnRwTmp3?=
 =?utf-8?B?d0dGSWFQMlk0OXloVTJOVUxFR2ZGMnVZWWlrNmZWMzQzMWxYMVE4dDl3clY1?=
 =?utf-8?B?Ly9aMldKVWFJRjQzM3lJRE5ZN0J5ZjFDSzlxUStEQWdPRE5RSWl6UmpYUEVq?=
 =?utf-8?B?NGVydmFjWWM0cVhyVmNBVDlMWVlZQzdlTUxhemFUVzVKclhUcmZ4Q1lvZWFN?=
 =?utf-8?B?VnA2TGVuekhwZmpSNU9XMXYwRVJqTDFmcndhZDhzMHJydEtvUzlKOGJoT2lt?=
 =?utf-8?B?SHBTLy92dlcxR2Z2V0I0UjNVeXZvNlVmMGlldTVPZ05wR2Z2Mk1QR2J1Y1o5?=
 =?utf-8?B?VWd5THl5SERPOUVmcGRtZ3pSb0w0Y3VwTmFITmg2OXorUWhzR1M0UmNMR0xj?=
 =?utf-8?B?WUJicjgySlcya3RLZmh2RytUeHFOalpUOXRNNHBUKzFMSzRMNTNDQm9pT3N3?=
 =?utf-8?B?T251dm14Q1N5bmpRd1AwZ2g1Q2V2Nis1VUFONld4S0tubWJrMWpSQlhlbmNE?=
 =?utf-8?B?UGZUN1F1dFI3NEpweVhYcXFXeTFTSC84V2RWeWtIOUZlZzNJcWZaa2FYem51?=
 =?utf-8?B?UGJFalpwb2piNVV5T1ZCT2JmOHRwTXk2UUp4WTlpYnZibHhTbDZaS21nd2JU?=
 =?utf-8?B?NXMxSmxsTEthcWNXVm52VS9teUtURWtGTnA4Qm5UZlVyYW5DcWZyYkc1dXp4?=
 =?utf-8?B?cDkvdEtnS2cyVUR5QnpXZGRCRG1aa3VPUXR3VE9Jdk1sajVFb2YxWStqQUda?=
 =?utf-8?B?cm5OOW5KNGVPY09lNFZNZlYwNnMrNFcyVHpReEJndkltZ2J6eUlONWtVbGY5?=
 =?utf-8?B?eHpuck1jR1FKRk55L1dNL2NiZ0V2MTc3RWY4MHBUcm9EUGxZVW9YN2NpSzdL?=
 =?utf-8?Q?At7ehQQZOfkvBjPYDTZvq2xG+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MkMqV24Tqt02Yo8aAuMw1sQDeVXg049xq2ukPFguujumjqh5wTG0H6apsBAtUCrMQSCWXUmMg/+bIizBJHFwt66mhC5kpVCv76nDGjfl7DHeMTNDajEfgOtG/6FCDceRCYc/xwLoS1an1+uPu05iNV045/nJWh7trzrULX/TR0bCwOxxbXQXoHvGqCTMz3QjLkFRoikzAV7HEg48A3NU4UHKsp6eVedR5REanxKhkDYYgy68qzKBfsv/w8vuHyiQcX+6bEbDi5X2dlZo3xhh6BK9k0lARlZKziSnjUMJzzXT7SZC0L1eyXk9ur7158p0HQcONROg3xuWd8sPSabX1rgdvBvqvpn7CHg3dzOsem4B8UXEaShMPqbjzM25Vyf6bM1C35GilI1un0sajtnAEr+PXyLdsXn99tUUlCJQ64sJMifqZiOgBsTLv8nt5wD5IKaOI1LG+MWCr+3ROliB/OFBREibuinuQSVKQQUJZo6mlPZUvK/71HO9zGE3TVpKr/my6iXAcTAoG4rTf85dNc2/5MfcU4lTF16tZYsLopKu54VGetYa/LwqfN6LDMuLIoBT94zGpZ/9u+qDPJ1TysdAbR48Jxi62OdzBvobk+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01fd30c-5f51-49d2-2346-08de0a682e1c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:52:50.1321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atique44Lc2NFolj3akAe5k6jhHDewWe9KgU9zOAeaGv1DwJgaLGw88ySK9A0cGxjyy6VxESzVidMZA7/h+Yxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510130066
X-Authority-Analysis: v=2.4 cv=SK9PlevH c=1 sm=1 tr=0 ts=68ed1246 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=bYUO7fSskbVSFXVlvFkA:9
 a=QEXdDO2ut3YA:10 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: h5et_sjEX4tWXtisRPYr1u7p6zHk23NZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNiBTYWx0ZWRfX0G6EeBEL7hlS
 90Wsngl46qB3XaKyp/NT/PcE6H2v5UfWzOYSo0l0D9TRA3jCgux+22gaxYCMD8tSMlOUcJ/Zpnf
 OYiy0HSeKFw5V4tem0zWTZoYq0cZGFLVV+6tBrfOnR4YUsQ8FWBa1TJ2BadJZ8V7nj2dn038Me3
 AatQ3yS5D5Xk2k2oIZBLCKU4fdPkDAsbngtCgXNV/lYnVl5rcWGjMnjrCc7/WNrcRoJqwHyTzgX
 AEpN/2vgPlNuK93Jz5YH/Vad1yaWGwWblSP0CAPdytcnm+XusRCwpaatfx3t3WZpBr42Xk0rlml
 OyqXThrKlGaGgwCbAsDaR/fRl5LUGX60kHvSHuzJdOWQ7XnJbYazWTzFR1nWbdqoTJVBqa+PC3c
 a4jpIPjErDRSbs/XHR2zkaai93B4hw==
X-Proofpoint-ORIG-GUID: h5et_sjEX4tWXtisRPYr1u7p6zHk23NZ

On 10/13/25 10:47 AM, Jeff Layton wrote:
> It would be great if we could get into linux-next soon so that it can be
> merged for v6.19. Christian, could you pick up the vfs/filelock patches,
> and Chuck pick up the nfsd patches?

Question about merge strategy:

Seems like I would have to base nfsd-testing (and nfsd-next) on
Christian's tree, once the VFS changes are applied, for one or two of
the NFSD patches to work. Yes?


-- 
Chuck Lever

