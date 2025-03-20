Return-Path: <linux-fsdevel+bounces-44561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31FFA6A5CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142ED3BE432
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316A1221DB3;
	Thu, 20 Mar 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k5WaEIjI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WXKmZqYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD28221731;
	Thu, 20 Mar 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472209; cv=fail; b=LPOFVGH35UyoIsQFzbsHTAE5eAFacRTMDv2eiUZvnk4506E2jBPACJwY699+iii7DvKdCcIMr93+xDlwh2981+0zVbSPWrFc0SS3zCXQQWD/m3HpaCBFMxrDSir/WBwToBqRPYCcGXF720xIn1CuxxAo7emue+E4nTHfMbaz+mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472209; c=relaxed/simple;
	bh=e45CLOI62OHCYhzgckHkF7O7xdKM5m2PtH8kHUTXg5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=poZw73eYbvklYl7aE4R7KPifJW6HPLfDEhHtSWaajHY5GQ7tnxIezC+nFNJurYPdMTDslIFR5TLqV4sx9h+0JQD5T/Xmz00ce8FwW6KfsB+E91++xWLISXcQ0PF5n3vQ8/HJP550qGX5CS2ovr32sj9rqoABRP0JADETJ/ElBMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k5WaEIjI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WXKmZqYt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8BuvL017529;
	Thu, 20 Mar 2025 12:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fYwe2dtgbE/G+UWKQ6EH4f3hi0S/SXLsb41sT+jZN3g=; b=
	k5WaEIjI8AQd+ny0QOX7bbrL7oCO0XiaLnZvURWp0DyxSyFKBJ+rc2cQasQiDD1P
	7zcVD3qFRy4YFWaszS/URyOJIzflYXob54WUvZ0tG3LC8tAsq+fWmPPhx4FwmJsS
	aP2e1hnQISchBBqbeepqjt4KVtKFfvlpANwR9Pj6U8lCZZEIjjkKkjtQ8kJz/5E9
	ml9ttMGqfqizpX29zajmIPDEn5KpQYfcA1HGlnDLL6UQ0uyxrjWP/a9CDagdvWc5
	2ZUkwhVadJ5NlpuwQVFYLvE3O/InO9K5TcESZKGSA1c769WY73qm+U7mnEu09MHo
	bJNn3xL/66uaMyzIFAcSXw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8ng9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 12:03:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KAeP9Z024475;
	Thu, 20 Mar 2025 12:03:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbm9xdq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 12:03:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiUC8REzt1XpRHHNvrYTdSoPmfObfeKMrDT7LjdE7monMqb8Dn6drpiQTnNm8YiLKroQPbYeGBjmdK4dORN4hfoyVr3mScB8wQgEGL21IclQwGCdflPfSUH6/lhI+uwjUMzhkyhNutqF6DMJp0YlZGyA5TDJqusYksriyYcUTnn5V04xPlZf9lOKFTcAW3Nid76lNqjVBq9gGJW5+cL3tMLT6padJ8K0LO6WMIdF9mqIbyViKTN9huHdb2a1jXGF1nsXj4iigHMITV4WcDPdIuoSvxm3NjVIthoBOQx0YX55Xt6YGWg4UEyE9lwx1JaR/4a/qc83bZAav0LumpD03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYwe2dtgbE/G+UWKQ6EH4f3hi0S/SXLsb41sT+jZN3g=;
 b=GTyyV6G3t/3hJOrJqon32dkD9LJRtpS/KIPdoL3hRVdu59eYsH8LzasuNJ0OT/Q+aoaym/c1MhkHosM7aeD5h5C0FmoYVP6rnCvfHAT/6MufASO7nKg350+alCaSPYMZzYj7LCsaLiVZKNc5ibB8dRaw+v64UKDqIILlIRWSw9FHLEx9j68pJKJmXrogZS7ncjDpPaFcjpCjBzDGLBLtNwEDQnsOAsuS1E2lT8VomISoCLwPZXRXJpSqyrKJPbL2hxCTp0RKy2BloksJlB1QL6hmWup4cc3lfyHBnTkxYzc+eRsG0ZQFP+OxZBuJfTvr2/J1WNaKCFsAewEjnvtvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYwe2dtgbE/G+UWKQ6EH4f3hi0S/SXLsb41sT+jZN3g=;
 b=WXKmZqYtu5b1s57JWl9IGJkMqBgNW8l8pwTUyZsE5z8U9jsMN2xY7whISY+iCXISP8aSqIzTVYjiWSNScNaFlMeOdk6ETVxz7YhO5d4omGMiRz2EHmt7OxARL3pMkmFbHdRh8RsYyyAb/8/tChoVbtqWB3pQsO3LmKmAgI5jas0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6902.namprd10.prod.outlook.com (2603:10b6:610:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 12:03:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 12:03:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/3] iomap: comment on atomic write checks in iomap_dio_bio_iter()
Date: Thu, 20 Mar 2025 12:02:49 +0000
Message-Id: <20250320120250.4087011-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250320120250.4087011-1-john.g.garry@oracle.com>
References: <20250320120250.4087011-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:335::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: a6942e51-b411-4d27-615c-08dd67a72f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Dr7H14TeNHxaWIDOMQqI9ebyCqrVoMxwWL7C+VJbpdd7J0ZT9G4dsXa/thg?=
 =?us-ascii?Q?ZY49R+LP1dBhTBIVK8uzz8REDO4VT1qYygssHiCXaMvts5J28QuSAVtcyke/?=
 =?us-ascii?Q?V4tzylP5E0h9N2UbdusKEG663eS5YavJaUO8aobj8sQYDltyYVwB1BM+WOrR?=
 =?us-ascii?Q?HejvNtbIux2MxKfp9NqKFEK3Eo0+vcYgIh6wDV91kkmZO5QfaNHAs7Y2IPQW?=
 =?us-ascii?Q?oBMwsO6yR1SnHH5or0ULOEHvBX4yzmXIvepGrZP1vskzhlrUpJZhfuQmN/1q?=
 =?us-ascii?Q?1LuTxb4/drygqndDtovdPeej6jbssWdzjJOn41/xsQyKip7QGzD1b46iMit5?=
 =?us-ascii?Q?HmxJGY9G90JqkqPTv+2pS9WiaBYNuXEhc0aaJi3S4gdxhjajVeZN/yTfJDVx?=
 =?us-ascii?Q?Qf5UPgYYCgj4jFVVfr8NS2v3XrEz9Wwf0vOlJkk2nA6ybcNhgmG2moxmSrja?=
 =?us-ascii?Q?G3t1+FuO/cFNY5VMvJonOxRunLehsh8VGDqiSwHKbuDrBQ+8fDEBXX8wDsof?=
 =?us-ascii?Q?sViiATbPVIWnQLQXnCHmlVEzGVyWgjJkw/IK2xxZTeKd8sEsw8qKNN7uhCN1?=
 =?us-ascii?Q?NLZs4yzSfj2O6CK6ReZLXQO9zixywCPc4iZ+mdlq//pVt9qv9JWYZjp7+Uc/?=
 =?us-ascii?Q?2PXfNXKv98NNarkC67Bd5RMBb4z2PIzFt4sAOenHTmG6d1a4EZa2v/uzpiPS?=
 =?us-ascii?Q?hgKMPvBZuJUSdJKMmsZ8fP8Qj01TfJhP526JXAYDxgxCou6FwtFrGX9NyH/2?=
 =?us-ascii?Q?UhT7ZNoY8gBA0JJXVFh5QBvcY0+myIkA6RX+lV7ya/MX3r4ErJC9oYK2wFjK?=
 =?us-ascii?Q?BkBO8+BA2Dj4xE3UJL/H819cL3DOjgbbbOIE5AXs+oaVafkc6D3lT3zAy0fT?=
 =?us-ascii?Q?gZ/SMNsPmFiompNYu85NW35H3tZTOJGBxWfDsZ/kyAJ631VspRkwo906jtGB?=
 =?us-ascii?Q?36nrfVJBlKE0ROXY5WV93BG3GHesXvP2ntGnpntnVmENksLcinq1EbZQYPLp?=
 =?us-ascii?Q?kUZFkZjv8PcvTRZDvzl/auSmVCtyplv/6xAKFQtzVIP/imUN1E0ufeqSjCVP?=
 =?us-ascii?Q?FV7a/Fz2rCUSVC8SAQIdN4lPYoqAq7JBERmldX5sPAS0hoLbCMWI8tUYCHMH?=
 =?us-ascii?Q?nWqQlOJCKi864X9prDM1hQvEEXo17Y9uOGuJZmE3sWgDOg92dOoIx2GgO6A8?=
 =?us-ascii?Q?J7lRJHfNDKTd2WT2fV3wLMhU4TL/QiB8YncE0cIcSIFSFtXUN8y1fgNhis8+?=
 =?us-ascii?Q?XTXZKkI9xRk9NV3hQ/XMQUNYuVh8tPbwzpEPDXkta0REjNwyKMiP9LVn/wif?=
 =?us-ascii?Q?3sjsormN8vqyGvyZ5LKgTfN/44booxUPez+g3MnXN5v7H/2pgDUiqOVVfjiy?=
 =?us-ascii?Q?z8RaTwCcOw0ahDbaMRF2qh20/JKb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mfwbUrbGztTD/vD0Ns3iHEpeBVfj1J78CSvBM4ah5WMCIxUxL8h8x7xfTWVg?=
 =?us-ascii?Q?RkeX9PtKEy4oqCL2hqtDt9l+/a61ab8OT+Fzl060KhZe2ZWu56k0Y+A4Knd+?=
 =?us-ascii?Q?wlFltNfO76CTXWuShzIdLO7QB9W/dQCGmjlRnGrAH39Y4Xd+8vn+5WpiO14N?=
 =?us-ascii?Q?AjfmjRF6eKtbT6x5BqoQSbGrXb4VvdsESPXawfVpkFc9ePrxyuGXtHTMHBSJ?=
 =?us-ascii?Q?eHd8v7eMyk26T8GCvNlH2FWqHfEBEy6w/uEWKatroUnJgh7FYMW00JQ9OPhk?=
 =?us-ascii?Q?IIWgEaIWrvjwyGUQKl4NxgTS95DSg22XBr/IndBLZA6zIAyC25IKZMAihndO?=
 =?us-ascii?Q?wThsffMQoMSzsXDcCrnkWI0roipPAvS4Uv0G463WR1qgHZrqVRM/ls+KpLG9?=
 =?us-ascii?Q?AFa6gZDOdjkLRi6LYDoeL7b2TnOPrNYAb/vzLdANMyZW3o/kzo3pdZmTzhsN?=
 =?us-ascii?Q?ENmgvXYAtK0D3/uZdAPsD5UBwEB1gI8wKhmnl0r5s4nY0iNo4nEHIHXricLV?=
 =?us-ascii?Q?TtKjNE2LzbbiM0RP6Ghtfo9NslD4PN7tBOgtjxf/rRS5qvA7L2EilHV80lET?=
 =?us-ascii?Q?RhDMUt7D1D3r8ONovGOHCZLPXBAXlFURuGfCvROeMxymVAWdHhR5m5hswKHy?=
 =?us-ascii?Q?X05jJlhxa1OKwpm/lTFBFZMVzZI93eQX9EWcgAECo3zgitNu91KVwZVzlFmL?=
 =?us-ascii?Q?b0wo4A2DuOQrYV241cD6RPb7ZGvE5EvG+5uAE/W+DaO8aeQLXsSxiJC3XxxN?=
 =?us-ascii?Q?jiL4LHtqshuXCXxieqJFEGbjzximwJHh4QDFej0BlHvvB1Hbe+dlwkhBuy9v?=
 =?us-ascii?Q?10XtDpRoPw8zJYNCaGj+m6bi4a5owZegSM9tw0xZL/W+4xwvcsN3ozGiXbhb?=
 =?us-ascii?Q?yzMeo8pIOu2pk6u9EOPHlwcxaKq3Qk6fSS92vX9yFPP3K6N52Z3iZig1Qnu/?=
 =?us-ascii?Q?QucMfLcBLV5c48UqAEV6PaJa82oJsBqyCCLiCj1xWvOsn3db8VJiazI/f9NR?=
 =?us-ascii?Q?azBy5PVllILXI0h9sCLGBr2yJipmheiKJA3JW7jqTPID/eOQ46Gtrda79bok?=
 =?us-ascii?Q?7QX6aVts/TnRoIdZFvWHpsGhw+KIriDVFQEZ+RSh/zaHrDPqveY0quXY6qsW?=
 =?us-ascii?Q?Ar6a07Jp7wedal/PGC8JL52dyDZfgwb7qmVYqtsetO9dsk6VQrq/PsRL49S9?=
 =?us-ascii?Q?Z/b2j0B28WKd5CUMxqo0r9+ffi1fCWZNizROtvqhpqxWOCKk+k5+RXCTX/ee?=
 =?us-ascii?Q?6jW18GpDQacsjgIB663XwgSVu67vIpsIu1Hx6mE2jxamTvJ6p2smha2PaiV9?=
 =?us-ascii?Q?w0dH7Oa1C3tj/xA8HWg0dIvKkiDmoVXKVxsHDwMW/C8IboUUaomTLU/Ue5l0?=
 =?us-ascii?Q?AgG5BiVtVXRkN2eq4v5qBE37+vquuUZT/ZWKN3R0fAmB7ZBeKTnEohP4wWGg?=
 =?us-ascii?Q?T2X2NaQTrOhVANb9L9Lb9nL+tas7qh0AaasjBwm6NnxAA9DcWGhRiRiwS9Sm?=
 =?us-ascii?Q?zKfQm1k5y1xD9x3Gfag6HPuRtvGlOHu+yOA3cHYuUhojsKLcWTr0KBC55Rpb?=
 =?us-ascii?Q?sH1qIULUiB3dYbgOBPXye1QKA3LlrxQ7tMFX2/HrPMhK8Suqvei/+QEdB1FQ?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kXVLATTnl3AROMar60qIWkmDHOWTLgpIkIpC4WBEVpvrR+4UFFEX2F7FZdqOg0qasQ5ecf/UFytKUO/8APl8qYwKcqnS0opIUZ+7ErC/LwvMmcOIYR5scISUDDGHkzG5vUPA1+YrsAhhtF/sFWM1XfeR0WawJnUugq8A6oKbbQkrd9MXYbKxncivF8K1wt05Wxpn8X/DMsNpUZwF6ZqCXb5sMgDQmBioPMpp0vq0nQKXdX9Yq+of6n6ZEyK7tHl8WPrZa3MUHguZGIdcM1lNId/9IxVHWOhiF8KhCjE/W8fiAc3c5XC8VvREP1L09sPP9QqZcM+pLXNVthDSe6J3Pnw+QQ1XRU+pLxbWbSDd4DHQJKyexKn5APF/E9j63/YCMYTBNN9JwblBwWTqL5fdgHUvSM41ACU3NRzCHr7R7OoOOy9MNjtzRLdVi2CNSDR6D7PJpJqDgGAjM1VXr+Dj6YdjxhpOcua6lGGmInwDbJVR+vzHrv3HxQY3SLxGeJFYH5z+Gvwqyc08JOr029N3ra/yJwUsfU/pMMxbE0KfQ4EXfSogrm1AjLYHIzLo2pnNGE98nBAaX/OO0JBcJwz77Cd9BBvR76G+6JCnX0vCpa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6942e51-b411-4d27-615c-08dd67a72f27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 12:03:10.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kww2XSNpYdnBjwxMJodSG9nSAkY3gMjnyIB1XPv/ftlu58plzHLvbnCDs0wYKUQNSHSvOHA4zyxnBc2ViRa7DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200073
X-Proofpoint-ORIG-GUID: T4q0nv7XGsTkgl_qhuNa89kQKggD0O8U
X-Proofpoint-GUID: T4q0nv7XGsTkgl_qhuNa89kQKggD0O8U

Help explain the code.

Also clarify the comment for bio size check.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8c1bec473586..b9f59ca43c15 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -350,6 +350,11 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		bio_opf |= REQ_OP_WRITE;
 
 		if (iter->flags & IOMAP_ATOMIC_HW) {
+			/*
+			 * Ensure that the mapping covers the full write
+			 * length, otherwise it won't be submitted as a single
+			 * bio, which is required to use hardware atomics.
+			 */
 			if (length != iter->len)
 				return -EINVAL;
 			bio_opf |= REQ_ATOMIC;
@@ -449,7 +454,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		n = bio->bi_iter.bi_size;
 		if (WARN_ON_ONCE((bio_opf & REQ_ATOMIC) && n != length)) {
 			/*
-			 * This bio should have covered the complete length,
+			 * An atomic write bio must cover the complete length,
 			 * which it doesn't, so error. We may need to zero out
 			 * the tail (complete FS block), similar to when
 			 * bio_iov_iter_get_pages() returns an error, above.
-- 
2.31.1


