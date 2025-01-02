Return-Path: <linux-fsdevel+bounces-38329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE49FFA34
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1164718837BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93B1B4140;
	Thu,  2 Jan 2025 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cIsBiIYs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oKeVYPSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F11B3946;
	Thu,  2 Jan 2025 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826982; cv=fail; b=jietUNazpJgnH7dIug+z4UHNRMoxqgCFj3RioxxqQsxvikZJcTb8SkIzwhxbadGrbqoElKK+Onv82HgrwER7UX1wNBYVlB0Vrhc/eOBcWqE8XejiTX2hqOHNrW2O8EWoj54ftzU4mt+aed9hL5T5YD3NeJeSE27Y2dQgTFQevZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826982; c=relaxed/simple;
	bh=TsIU4HX8zCxiY2QYnVE48i6ug7HYc/y1yp/2PtUixJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XbscgbD/lEi9D1U2Qyasc+8q/J85QNELN3/stzOFzC4jrRjX0D7FafPJdF/ieVJ62Ri35SJY4dPjpUGPMlfu6TB40speBSaPHho4IeUeTeVmwf+avd4zIArubqbQTr3w4qlma5VDqDZHMS10e40k2cIi/65tMLSPgDUz3114b+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cIsBiIYs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oKeVYPSA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Du4ck019893;
	Thu, 2 Jan 2025 14:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=N2DdZNZTiT2hUXPOpR
	kS36Sd9f/OI7pHQw7NeaO7kuI=; b=cIsBiIYsVFIKiHMDeJcsHn5GBQjKMxzQNp
	R+K9DqoC9VT0YsHzc4HeyHxgEvw26NfRgfjC00r2Iv9CWNchoxO1/jVGKE0sX8PO
	6e0Kwg6TOYGabfhPhwKKMGIlWSsSiU/Zv3gKiFiaLDU7Cm/NyD/dkrrztFT/I5ib
	+NxPPz8wet6E6eY55fXAu33HppG31kBAK80OSFkRUzPtBIh/IG7X0CTD++jniZ0j
	Lso+EaZ16r/LxUyg3AW7c6SOiD14f4Dyg2sU54SwIql8ToIBUaTRhBP56rns6NVX
	wUVSLfJ3XLlEvGc09RKQBjH/z9wExZlQTf3UhEv2jIzlX3nARP1g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a5e8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:08:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502Bk3x7008492;
	Thu, 2 Jan 2025 14:08:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8tveb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 14:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RazN3KWvwWPp3if9MMH9oyjRQUJTCgXdFBOFMft2Hg3ab/vo7guQjyXmxnyIKRaqdzLjrjeqN+iWhcVYh2qUSlCcf2YZzqAOQHRITIYa3pOPbc/H3YoSDxRbYawuWtdpt9Z1CII2ggxBv3Ga0dXrP75dtSlrhHvawPEiFXtSzpJjnu+HpuW3c87Ak9f4WuNMLJOhplnv5Mz8GBZ2unKfQg+UfeSzwjxyHVAXfQie+VbJDs7Jtzz5yspYtICzyWFUxsV6HLrYJNheImcgtFtL/ACrTVwtRLZ6DXp0Z8p9ZP6+Q1WAbGUpjzW6VTHk6cvn4+4X4Bjwbg1mCgbczQ9Wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2DdZNZTiT2hUXPOpRkS36Sd9f/OI7pHQw7NeaO7kuI=;
 b=R2NnZP6g7fHI/2QUtKAMIUV0gBxKDUTwRxoUHj7lFixsD3SnX0/Jrv6rvRy80u8/lVbXCBC9+wfrsH+CrvfXBfyB8JpI083y3xZFdd/zFGluSlTu/teOEEXHD5YMFeMb/LC3YO5ikow7uYvNLltWSJbgUY5SaHVVAinX+GFAAP04k9zIAKKqIZhnAZczOo7K5hnwfPOSZAGtP4uPZaO9/056SFlLvS0SxRYv3nvteAPcXSxIJMn4rHR19vzmGR1XgwsiszPyQgZmWYmZLHLhRzu6LCpioT8i1R1/yqBgZmqYOcqidZZZxqXdcGLcGQ01t/+8DsVo1DOe+iOcZy4FSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2DdZNZTiT2hUXPOpRkS36Sd9f/OI7pHQw7NeaO7kuI=;
 b=oKeVYPSAVJMGnGHQCG+S9/vRHt5o0Ihp8fBM5rP1C+BIfATInGMSGPbrjgQsT83KKeBfI+iHPbut9eztb7mOuCzQYXjdp7n1MjAhTtGlqJ1ovRkdVFe6ydj/0SilSafOAonuamEJ+vRf8QV+3OrrbrOwE1rt0FcvMqQ4pD+b+dc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Thu, 2 Jan
 2025 14:08:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 14:08:07 +0000
Date: Thu, 2 Jan 2025 14:08:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp,
        dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, kees@kernel.org,
        j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com,
        vbabka@suse.cz, trondmy@kernel.org, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com,
        shikemeng@huaweicloud.com, dchinner@redhat.com, bfoster@redhat.com,
        souravpanda@google.com, hannes@cmpxchg.org, rientjes@google.com,
        pasha.tatashin@soleen.com, david@redhat.com, ryan.roberts@arm.com,
        ying.huang@intel.com, yang@os.amperecomputing.com,
        zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 -next 06/15] mm: mmap: move sysctl to mm/mmap.c
Message-ID: <ef1d602b-23cb-4a95-b83e-c506958dc90c@lucifer.local>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
 <20241223141550.638616-7-yukaixiong@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223141550.638616-7-yukaixiong@huawei.com>
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: d378f103-49d8-407a-11f3-08dd2b36e1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xx0TjvQz2GfJWD6KdWaR2lZQs3d4pAkIdk6Fv3YVSPqSNr7WL4tb+CTv+8ao?=
 =?us-ascii?Q?oj3VXvP5cSeiBTegoejwoaulLKORinO8bzRyxGxJdgf9mWGmuBm9iYOiIQiB?=
 =?us-ascii?Q?pDmXwlfIHZRj+v2fVyHweUxCmlczElBVYmBYF8GiTooNcjKSuw4j6PszVriw?=
 =?us-ascii?Q?GYrE55d4sAjUTmHswksGscVqtyaU251L+Tb2plvqefqfiXubfevrWBl0cffZ?=
 =?us-ascii?Q?HBBM/f1f3AdgxnNaVsxa9FuJv+ltyqygEx8AKCtL8yHAEQnKTf4CWr+LzhLG?=
 =?us-ascii?Q?UwEy1hU4WamKuEep/tynIscRx8fhl2vYBbsc+RetVMP7avommDz+D/7DeIYY?=
 =?us-ascii?Q?ne6MchSVPcYPCQ0he7KtTKKOr3gH3mAclzFr1DOjOBgSNxl/hls0TZ57Oxsw?=
 =?us-ascii?Q?hTFFiK1o2gSmnNnRs9ga458L5QW2l+qTz32BDLSpz7ghZz2m8RwSfTN36RUn?=
 =?us-ascii?Q?I8oPvW3x+wQlFguuBbzKdSNqzQp4jORL+XPL2QSJSyDX9+/1hi9lhnMNFCK0?=
 =?us-ascii?Q?s8IDvA4IH1ujxaIJyQLYedmZ6l4v/8wy2jGP7ybdgML10UWtO7yybvFxCJ0X?=
 =?us-ascii?Q?d7ySymPEsgzNMdUmHBPBZmTDUUqji9iL0RaW+GItObJcCUdDm+zV+E3kKY+O?=
 =?us-ascii?Q?4WSYPmq0nU+rtBsXiJCQIR3mzqK4KdKsDzAibNM9w1TtdsWu3LXVrP8Iqa9Q?=
 =?us-ascii?Q?K8ex0yBawcHHfUeUVurfAdTuvRDJbzahyCwNzyxmxSZVchl8+Lz+KnyFA8ag?=
 =?us-ascii?Q?NfglC/Z3IIvDHjiteLZ3gUiAHy5GLoIQWSeo9oZ0LhxqksUYlqCKNW6jc2gm?=
 =?us-ascii?Q?6uvbJFhFGSZKDteatPCta0U7tXh9VQlcARWx00EWVJypauLSjQo0NTn1iUHu?=
 =?us-ascii?Q?lM6j9hYJpL3UctHXllbW6nJQMzBR2xQ9oig6Zuloe60UIZXEkGA3g9ypVcX4?=
 =?us-ascii?Q?Q6U5XJjTFcPL7kk2I44j2ldEvbvTFDmMcerQOtQ5/Scb4StjXJJQ1qxmcEwr?=
 =?us-ascii?Q?0iUO7prYK3R/e1JQSHmiwVapmIvzXX671ghuaHtfKJ/tmBqiAYsLk9L3iYaA?=
 =?us-ascii?Q?Di1Ypti9+0p+X0POgGGxjuXUkphvWcnxzWoqQFPoG/n0zSE0SJXn1uDlGqIO?=
 =?us-ascii?Q?mA29U8+dRH36z9jJJLppzOOEc5Uo87dFDG0cB9XmvGtvVgbTkUjZWnan4xrd?=
 =?us-ascii?Q?yeyhYCsHkmTsOJcWSG8eMjm3IbbpnXY7SgvHXBrtS9BsGVEZdC3h3QVxpSit?=
 =?us-ascii?Q?rwKi3jSXAfB+/hrniNui52cgr8+byzeK/EN961VK2yQNbR2GsZ89nBh4ztEI?=
 =?us-ascii?Q?2iWKXn6ybT9BtRf+Dr0RDeRWrNNUVXnYwzj+PkOMyeKXMVSx/mblLtjSgbUe?=
 =?us-ascii?Q?2OSncmKjDEjL687ObvvubqHbdn5Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3N3XzXuxeyTZzfMyzQBgHtpp93tHu3YO2UxwBq05u8OBSi6TzaxtbIMp+sgB?=
 =?us-ascii?Q?B9rSGoSNkHPlSV66gxZ2YCgqw8oLgkM3/iaIj1NGkxf/0rHULy3c+zkoKreF?=
 =?us-ascii?Q?a3iF+ukWsdSQ0uXw37Qp0IEjNyLvP3WDN/gq0HaBsKG1IBDuhgPw6sIdLL02?=
 =?us-ascii?Q?MxTy5up5Uh1pkbnnoO+VpXOospLkTlDraUIBU3s+WAssVK6ZGzDa9kWahDnz?=
 =?us-ascii?Q?w9yY6HW2uhhZz2hiQTFWWbetBndxMxeV7kY8wow9vR9rmRWE/CfEr9jYmbNz?=
 =?us-ascii?Q?bbRM26L8Qrbpw+2mw4HEi9nkbkItLEiLMIxzNaAo7MX5R0j2sqfZHe5X29AC?=
 =?us-ascii?Q?jr+PxuZZZhBj1zV3730og71TFDfCBz0wCXiHiVSsZ4JHc7rIafQ2l6WCBB5V?=
 =?us-ascii?Q?hlmcC1g96hCuhaa2jLhFIf45UeHWvvA+yGRNADKCE93sBJwqyJP35N7x2b1T?=
 =?us-ascii?Q?0y91D+4La7Kcz0KIuBscE+bfal6HrxfZiIIm3jRdoIOyuFU+tszEC5vPH+a/?=
 =?us-ascii?Q?SGVPnI6baCP4x24GYDPNnS+C2E9i00QxVHUNTcYgCWFsgH0m9OsNR2PEauk3?=
 =?us-ascii?Q?XiUcuixIlBA559n6zlCE3e2IfNwMxFXND8EAiNf27LC+TLYrhuUPSP2Novkm?=
 =?us-ascii?Q?i0AXypiMW9F6Zt8b/kdv39WiwYS4k4c3Pdx4nGEI1hXa77wCLc4So2rY7NDZ?=
 =?us-ascii?Q?DGILjP84Lae7mnzbnfHZx2Sue2x/+5RfZFlUwDV7mT7/BWR2xycK9AbrXBr8?=
 =?us-ascii?Q?pjxbneJUOufCjUS2HjezFPBCd/B/AarKAoyU60XWwAeABlJe0W5TCpsP8vcc?=
 =?us-ascii?Q?4MHHnHKUXQs6IUsa8LtSjBu7qwCoSMNhkomBy9GUlALBDhab1xP37/xJlg8f?=
 =?us-ascii?Q?5e4pBmeUM8IvNnei4mwTP3PfeLQ5b82JBSxjoLGq7vo6y/QQRoMQfpxq0B0f?=
 =?us-ascii?Q?zePJ9pjxZHmUCsKZRu7apuqt990xQfpf6ySQi9NHrGxID2X4GMsuZVFGjz5k?=
 =?us-ascii?Q?sAw6v/+yB6KFjE2fL3rlnI4+nKx6e50kghhkonvivtej3nsnNzYnLFr4YNVJ?=
 =?us-ascii?Q?lDDTXrhDbitXBsBtBA07dq6reJAQQFfPevGHfPVb8j9t7H/+KRsWTd38QHX4?=
 =?us-ascii?Q?Zn8ocn+D6Bi1SOL48Ed7f3C/YZ4C6P7oRjYmdKd3y/yebUcyE0UcV4AfxFAk?=
 =?us-ascii?Q?KD/qZhWxU1dFgtT6am3if6BXH3J0Sebxz9GTKfvn4lXELFUwbEPHr3r9TZuy?=
 =?us-ascii?Q?J1SPK6v/xO+fPSvhdY+44fesxTKNGF5bmn1oUGNirbHosbudTG4nlwmV+L6W?=
 =?us-ascii?Q?3ToJCzFi2ZRgPhKo8W2kPKq0Pfr4R0oAspHZF2yknNKvlj5RJjnyFaAsIEMA?=
 =?us-ascii?Q?HE3XD6o4VLDeyPD+SkXc1FEO0vGqu6dR+VzSQ4UPZ5IjSiFBlwKNlIg7SYuH?=
 =?us-ascii?Q?RJXnfks6OJC8gLAERnsKUeeFuYmzaPc2Z1mSJE2K31E4ua2lnSAWjkNh9N/a?=
 =?us-ascii?Q?XiNVsLZc0ZVeZbEI+jgI9cW7mypjrYegAZo3f2LecEqJgeK07dQL8ilAXskr?=
 =?us-ascii?Q?n/fkITZgEuVahU3y6goxISw84Sdl98tRezPOzqpt1e6LqgemdjIseOHAFV1F?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GmSCc4sdeScesQWM71rNNLpxIrIAWbwZsC7pTclm5LHc+AU07wbXuJa57O3sJ0JkcPVmvhSqKlc2HzqY5M0EzfV/HRFc50rv4YFPovtlwjKryAY275yqt8Nki3WrZyUnCwxqObqiJmPfmQTjmi/XHyrNSZlYU5KNVG5r4Daj7oMAu2s7wr2vdRaH8arqRkqGsTY9KPBTHd8PLymTuy1L27xHodnVcv+LO7CdAjtB6EZ8EAywqriFOWZFS74uPY8nj1RVjbQeha+H6x0OrFD4x61pskgvHDJWKUeZixeg5XNjwQSK68fYy93N9dwY9SFUh4vCbp4uy/Smmc5ZVq65av/FgpV2hAmfbgt8UOF64/CU/oDqsP1KwDYL32Ek1bGC1Ou0JlefLJeouSAHGPv72zpB7K88R4J61g0wgYuUp4xrnattilLlNrCSK8TmqgFBuXr0eC2/FDqNKD6vcFOQDekd5u0/bu/wXQyK0Iu5+F01j27xKMuGiuaI1YW8/rVHjfXdM2P9rODR1aun+BU29lzZPqN99aKCaz9XaoK0tTbU6S+27gm2Ye25ciGzBimwYZ3H2rI6f7IXaChvV2W4bkg8jMJJ4ee7oBQvQhGUxqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d378f103-49d8-407a-11f3-08dd2b36e1ad
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 14:08:07.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJOF9IdoDJcjHlS8PkqAqfWDa0fFesd5QqRwtPTNaFu1714aKYuIYX1TeSyRarYyW68+yODXB9LpzqKZcH6NDIY0+B3bCvqUT2jqUeo0mKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020123
X-Proofpoint-GUID: vn2DLHr64tu9gqDjwkN0tZcrR7SHeIrD
X-Proofpoint-ORIG-GUID: vn2DLHr64tu9gqDjwkN0tZcrR7SHeIrD

On Mon, Dec 23, 2024 at 10:15:25PM +0800, Kaixiong Yu wrote:
> This moves all mmap related sysctls to mm/mmap.c, as part of the
> kernel/sysctl.c cleaning, also move the variable declaration from
> kernel/sysctl.c into mm/mmap.c.
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>

Looks good to me, thanks!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v4:
>  - const qualify struct ctl_table mmap_table
> v3:
>  - change the title
> v2:
>  - fix sysctl_max_map_count undeclared issue in mm/nommu.c
> ---
> ---
>  kernel/sysctl.c | 50 +--------------------------------------------
>  mm/mmap.c       | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 49 deletions(-)
>
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index aea3482106e0..9c245898f535 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -127,12 +127,6 @@ enum sysctl_writes_mode {
>
>  static enum sysctl_writes_mode sysctl_writes_strict = SYSCTL_WRITES_STRICT;
>  #endif /* CONFIG_PROC_SYSCTL */
> -
> -#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
> -    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
> -int sysctl_legacy_va_layout;
> -#endif
> -
>  #endif /* CONFIG_SYSCTL */
>
>  /*
> @@ -2037,16 +2031,7 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= SYSCTL_ONE,
>  		.extra2		= SYSCTL_FOUR,
>  	},
> -#ifdef CONFIG_MMU
> -	{
> -		.procname	= "max_map_count",
> -		.data		= &sysctl_max_map_count,
> -		.maxlen		= sizeof(sysctl_max_map_count),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -	},
> -#else
> +#ifndef CONFIG_MMU
>  	{
>  		.procname	= "nr_trim_pages",
>  		.data		= &sysctl_nr_trim_pages,
> @@ -2064,17 +2049,6 @@ static struct ctl_table vm_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  	},

Nitty, but  this bit belongs in mm/nommu.c?

> -#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
> -    defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
> -	{
> -		.procname	= "legacy_va_layout",
> -		.data		= &sysctl_legacy_va_layout,
> -		.maxlen		= sizeof(sysctl_legacy_va_layout),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -	},
> -#endif
>  #ifdef CONFIG_MMU
>  	{
>  		.procname	= "mmap_min_addr",
> @@ -2100,28 +2074,6 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  	},
>  #endif
> -#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
> -	{
> -		.procname	= "mmap_rnd_bits",
> -		.data		= &mmap_rnd_bits,
> -		.maxlen		= sizeof(mmap_rnd_bits),
> -		.mode		= 0600,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= (void *)&mmap_rnd_bits_min,
> -		.extra2		= (void *)&mmap_rnd_bits_max,
> -	},
> -#endif
> -#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
> -	{
> -		.procname	= "mmap_rnd_compat_bits",
> -		.data		= &mmap_rnd_compat_bits,
> -		.maxlen		= sizeof(mmap_rnd_compat_bits),
> -		.mode		= 0600,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= (void *)&mmap_rnd_compat_bits_min,
> -		.extra2		= (void *)&mmap_rnd_compat_bits_max,
> -	},
> -#endif
>  };
>
>  int __init sysctl_init_bases(void)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index aef835984b1c..cc579aafd7ba 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1603,6 +1603,57 @@ struct vm_area_struct *_install_special_mapping(
>  					&special_mapping_vmops);
>  }
>
> +#ifdef CONFIG_SYSCTL
> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
> +		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
> +int sysctl_legacy_va_layout;
> +#endif
> +
> +static const struct ctl_table mmap_table[] = {
> +		{
> +				.procname       = "max_map_count",
> +				.data           = &sysctl_max_map_count,
> +				.maxlen         = sizeof(sysctl_max_map_count),
> +				.mode           = 0644,
> +				.proc_handler   = proc_dointvec_minmax,
> +				.extra1         = SYSCTL_ZERO,
> +		},
> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
> +		defined(CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
> +		{
> +				.procname       = "legacy_va_layout",
> +				.data           = &sysctl_legacy_va_layout,
> +				.maxlen         = sizeof(sysctl_legacy_va_layout),
> +				.mode           = 0644,
> +				.proc_handler   = proc_dointvec_minmax,
> +				.extra1         = SYSCTL_ZERO,
> +		},
> +#endif
> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
> +		{
> +				.procname       = "mmap_rnd_bits",
> +				.data           = &mmap_rnd_bits,
> +				.maxlen         = sizeof(mmap_rnd_bits),
> +				.mode           = 0600,
> +				.proc_handler   = proc_dointvec_minmax,
> +				.extra1         = (void *)&mmap_rnd_bits_min,
> +				.extra2         = (void *)&mmap_rnd_bits_max,
> +		},
> +#endif
> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
> +		{
> +				.procname       = "mmap_rnd_compat_bits",
> +				.data           = &mmap_rnd_compat_bits,
> +				.maxlen         = sizeof(mmap_rnd_compat_bits),
> +				.mode           = 0600,
> +				.proc_handler   = proc_dointvec_minmax,
> +				.extra1         = (void *)&mmap_rnd_compat_bits_min,
> +				.extra2         = (void *)&mmap_rnd_compat_bits_max,
> +		},
> +#endif
> +};
> +#endif /* CONFIG_SYSCTL */
> +
>  /*
>   * initialise the percpu counter for VM
>   */
> @@ -1612,6 +1663,9 @@ void __init mmap_init(void)
>
>  	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
>  	VM_BUG_ON(ret);
> +#ifdef CONFIG_SYSCTL
> +	register_sysctl_init("vm", mmap_table);
> +#endif
>  }
>
>  /*
> --
> 2.34.1
>

