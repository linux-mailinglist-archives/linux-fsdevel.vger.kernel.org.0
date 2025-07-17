Return-Path: <linux-fsdevel+bounces-55291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B6B09538
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 21:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379764E0843
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 19:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633421B905;
	Thu, 17 Jul 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lh7eQbsl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DY9Fy/cu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3708194A60;
	Thu, 17 Jul 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781956; cv=fail; b=OLc5Cu9lTSmW8hBQR/0VG2KJJz1c+ezd8cRLwuzOCh98SfyJM0tGJk3c+iFDjcQv9ONcVMz0T1yanWfBVg4Cr244NFLUMknYJ4W3+niGLa7X4SEzCPZRsuCrKbQ3XuHeW4PAnYhEIFz17EyOTbbblnh8V/kVMRzzFqhcrrfX0Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781956; c=relaxed/simple;
	bh=qiGUZL8oRlTHdxBqxWDBUvsUpupaev5/MKcxKePuz9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KRfS0lvyA0dh2mI3jHWG8iRiTIl+dddz5PHlDQSJkTiz0ei0wclPMhuqZH7jLLn043k+Jg14TvHygbRALx3e1CElVs4BkGqG9B7m16rj/IN321Ow0k4Mr6Kzie4m1F/e63OV2wkxnLJdN8ZanNjvjv87SIPxPXssN4QD2bA090I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lh7eQbsl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DY9Fy/cu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJXlAa027463;
	Thu, 17 Jul 2025 19:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Of7qKS8PsGwvb/Z2BQ
	qnm8opP3aSd2mFcm48dB77LFI=; b=lh7eQbslI++nPXA/w7NJ40NBCNRar/TL6V
	kJyXZ5sA9cV23pS5/1mYsIT3y1R+eKRGT8FFH5ywWS30uKdtWIxtcuIY8FT0eB8h
	SrEHPYA9tr0eTG+x48lCnvnrmyoMdDxfQ7HMx1eowL5cgb0LQhnDuKYCgHVq7dhe
	g1oOOkbNrna0O6yRpbV5/ViyKYeVR9ctR2qUd95yTzZfV6nNrKQh5cfAmJBkIYcl
	ld5qUAT0kkVaFpIeME9jjEuvTfoWJU+yzqgmczKdDmkY52fjp9mGlbhvYYBZFSxs
	MmyY54lRSLhhOKZvtL7qF/lRTWbg1N9N2FfgbipyOaXQpUEFr1RA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b3vyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:51:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HJQmAI011570;
	Thu, 17 Jul 2025 19:51:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d7kny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 19:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCmyxgAq4hUcCriY2ECBTFaXmAXkJY/BRYT4/RDbb1Ape3iDvc7SjFJUZZS71QOyD+uK9EON+YjO9BJOx21a8h6YW0TZ6Y9kgYAeI90xhWRBBJqBQvOE/nP5z56TBngBSfJVmJjvQBUt9YT4WEn/kezwjilQRssamFFGCW8OrtCrHBNvxAdN3BErmdzzId83crI2bpZ8O0wqi/a1ssyTZjfniP4kIl0BIA1GjPyQO1a+0A0mv3EHrtkr0/n1ekIrQaujlROVVm+mzpQfQ15MudkLhUw1jA8twMCcRQf7VWMa/JD9N2LJhjyjYK2xvGVzKhYaOpEjsiozr7grQ5t/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of7qKS8PsGwvb/Z2BQqnm8opP3aSd2mFcm48dB77LFI=;
 b=WAIRzepUgkfWYy4zprlX3UsqPmbLnJSSZdBCu3+1Gy7o+WwgpG9RnluL99Q83i9Jaw9REl7aU/5vAka7d1AYVeMX5QOz3XsGBsnUq7z0fIJJbOp7hEuIg+xbkElst/2qzuTlTEx7w5DQolRjTSmTu232uWAIDKv/Dg7fwj8CoWL5DKltnJCrSPXEzjF91a4WtImWq1b13bKiRQCb1QEBrTjjAUqKPzZfVDGDWgMbZH3Pud1Gbxu95y9F9cgzqsAJe89rysU0BtIYHAnb+zTBkIIJftj8bHJO+zcbkyxVcIWskWwY0z6nTYA850LuQWV/wqDarGUqpUh94CnlDSikhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of7qKS8PsGwvb/Z2BQqnm8opP3aSd2mFcm48dB77LFI=;
 b=DY9Fy/cuPLKqAbtYZLLSPGzuPeDj75/bW03oUkgcTRTouNJsjXqqx+/h4NcQCQoQOB+lffabopBJI6Uq5y1RRUwBDINlVbGtdFouA5s8koR4NAXquHsfcQfUZfXIiIBElvutKQIXo3kk5NWkpi9NalPGelupjUk1Y4Qb0iEIwHA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4412.namprd10.prod.outlook.com (2603:10b6:806:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:51:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 19:51:54 +0000
Date: Thu, 17 Jul 2025 20:51:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 7/9] mm/memory: factor out common code from
 vm_normal_page_*()
Message-ID: <1aef6483-18e6-463b-a197-34dd32dd6fbd@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-8-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-8-david@redhat.com>
X-ClientProxiedBy: LO4P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: bad37e64-796d-4c0f-3fdf-08ddc56b617f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/a+FpqH99qvE24hMjSvrwVwzpuV/6K/LKRa2Uk0el+8jZH8Ht9JeZNcYgcdb?=
 =?us-ascii?Q?WVa2oug6HCTuxHyFAoWFo5O2z94eLlXfPQwWSCgjh3CV8a4EG7nrJAf2n+oe?=
 =?us-ascii?Q?/crH3IytG3An/YwbstPB5oRnwL0TNDBUMGrgMBGiAn3NKjg/uIErMP2BySir?=
 =?us-ascii?Q?OYrE6htFKMUYtGHW5bAurxfG2yk1oCaM/YO3kZJWrQHzk2U3d9m/TlJshxYy?=
 =?us-ascii?Q?gGjWctYcRhYM0QGn4Cb2E+cqrFi7nb1OnkrOKd/N+r5m7xWO0nlLYAOLDXAm?=
 =?us-ascii?Q?cTznwO9o5EkfoSYzwT1JloqCqL2CZ6xjgol+Gn1EtfiUhjfn5hFd6Vd0wnn/?=
 =?us-ascii?Q?bvGRzpFUH51MRhiITlDOO7H7otrafxJWA0DJmKjSaFbDXa0h7cShPuRJLRCb?=
 =?us-ascii?Q?AkAPIADVJcFP48DYJSAFJhxrdkVH7b3pnxX75coNtLPAPnTqbbTcBWx8Ly58?=
 =?us-ascii?Q?BKzScB0MGlPhNFMlvLjKKEbIQ7czGL35oe29YYJKPGdkUfw0AOcT2wMHaicx?=
 =?us-ascii?Q?E1Qkg184u/qZLvyj5H/hTe4os6WGm7mNuMxxUd/U6LViP5EaL3gLCnT7ItTd?=
 =?us-ascii?Q?c9YcHfhuP8WWNJS91obro97WxZvq3f8o0KnW3dFEma8uq4r6PYS4rscyor7P?=
 =?us-ascii?Q?GAVVaLKN4SqlMM6xsfr9vjuUiaW5jDBJHN8ye2CWRwyk3NxVNMq5E1WM771c?=
 =?us-ascii?Q?2SkzWTlgezHmRYeuZkpaz8d/CltV63V30Es0vlF+3awupAbFl4xrW4HVaElG?=
 =?us-ascii?Q?YFpWQaLfSWdEv9sTPXIsaErJ/1QwaOzp1gbsJrTQacx8CGTreAtzgZSIy32k?=
 =?us-ascii?Q?/LVh61DKbi7nlE+iRA5WZT5EpxhAJvXThR7BHZUiGpJ4gvqtXeSEZ75c95mc?=
 =?us-ascii?Q?V6DNoKfyDqt78gHXF/jCarbhWNVKX3Nskk32MBQgwNIZ2bwgaoG+Q8MtvoMo?=
 =?us-ascii?Q?a88KtqZ1s6lt56FMl0irOd0Gw8JhnrA0cQvlMh9pDDtr47tdYJcPwIlrkxRI?=
 =?us-ascii?Q?P7og4J0O8Jjp1r6VAqAE6knjgqBD3sjLvCyrmY7ezWPrd72DShG1yislEFiN?=
 =?us-ascii?Q?8MzqEn8ffXa0GkArV+wStXIHWHzAxBMY5lPOPA0/VnbmCxmxQgXxsOkSdKez?=
 =?us-ascii?Q?rWUyHy42JmqXyactkYIHImK9dXquJjh+VHPFYdi6KUTPujARTw12JbzLyt2t?=
 =?us-ascii?Q?4hLG//yC7k2mmm+LX3PyngKS/C47YHC9rjtX7v9cHZW+dXN92940NunfuBOQ?=
 =?us-ascii?Q?ZmzSn3JPiLl9acYdni5FJteHyuFpqv/2L56tYDiJf7m4bZ335NUgaf7kl5y5?=
 =?us-ascii?Q?cNk99O80H/kkFd/E3vxN/UGaxmIW4yQF/zT82lxOzBBo7qG52JdlvYhxaCbj?=
 =?us-ascii?Q?tfst+WVAAE5cAxdqNJPucTMUhIKdh4wDCCQ/J30Y65J/C7swAF6ZYNt3XZby?=
 =?us-ascii?Q?/P313ilvo/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPuaCgd34wC26uZUxeNBrjnCk2hWt5TvWCE1RbmYwG2Z566xYbY4bPQZmnOh?=
 =?us-ascii?Q?PfADUeJj1UHai+L5AxlbmBZ4WjQAlElQPOnG9hBHp+8qCsqI7BPyVdKxqhX6?=
 =?us-ascii?Q?nfPdygg2UNEeK8yaX1JN5ctRvaosOfPyD2KezmhG2BWKeKgw3z5qf+ABOA/+?=
 =?us-ascii?Q?UmxGaopCO6BM9RfY2QunPJZq40BrFh6VcomjcNEDO3LG0V4xiplOBWgLvIL+?=
 =?us-ascii?Q?3zVH4AiqDMboOZDAveYX3OmLk944mmkW6L+5HPPR9PJFcGPDJwzUPUkh6rwT?=
 =?us-ascii?Q?vmq+Iz0Ls2uUmJOjhwDvW72qiGVG/BH5I+mnH1QH/neFAhOtCcrGYnfatfFK?=
 =?us-ascii?Q?f71IRV4h3WtW4Vu1VYNDO2Ljmfd7tGhQRqdYiOeXZn9uowHPLUJj5i1aua+x?=
 =?us-ascii?Q?j0KPrMuelocx087V5eZicdTIhK9/QMnrZT4YwktlN7+bRtbhK+vCDrLnhBhr?=
 =?us-ascii?Q?dz34WbhfV7F2QUEkyMwKvYEb8t7VnWNpLGPXA06j4/kqFgGiExfnK4E/tFF3?=
 =?us-ascii?Q?Rfo05mynC7vkF8ur48mNaYWeRTrzAhaXWMZJgL0/BbjEeJGo1kWU6ZU/ACXu?=
 =?us-ascii?Q?0RMUCfrtKU6brdw9HhpqP706HJT1QrLHtIXkVuKqTxmQp4eu7GeykEj6BJWF?=
 =?us-ascii?Q?4QrTQZh8qK53RAMtzytsBDd2LtdObr5rf+UyFIlvlRiRyvx68Wp5LtYZDYPO?=
 =?us-ascii?Q?nIPtpHC/uSLOjVNtC7hO3xBSViAlGLbFVMtZ4DTKrMZbRHAnJD51ShXa8IIH?=
 =?us-ascii?Q?fUyDFOmsotulv+RJ/q6xxSYjd6sVCokmaPtUhP3WH7IhEtDfs1v80UcaWw4m?=
 =?us-ascii?Q?cDaS9668Q9EktZ5xEmRnW2afimNPHNgM3T80ZiyyQ+KuUmF4meDRUIM30eYh?=
 =?us-ascii?Q?XJDAX0W4jc7kj4Yq01e+jKFHGDH783HO4M50qLjn8CSI28ZmMS/9yfe8F/k4?=
 =?us-ascii?Q?xym4Wb/zaLZQWNynBhUrd8KzW5uB2rrTrcpVasPF6xy7Gh2eyUxF4OMCSa/K?=
 =?us-ascii?Q?5hksi+HjBHV4GuE4E/IJHJpTy1JFfHmctTqzLIKmknceCCKIsoKOnCJH2XwD?=
 =?us-ascii?Q?FSdQbtwn+9/MooIrqKGAd25fSW/hF4oj1cKpH9vgnvx3Cu1/K3BteSEhyyuH?=
 =?us-ascii?Q?3j3I+878mXQjaLRUwi0oX3j9Ig1cGl0XGkmQYc8d6/RyoRb6c+6XCuaBn49n?=
 =?us-ascii?Q?uRIKhlIdt5khQd/7uSOrKOWE7aVxyUJk0m0zWhjmq/PkTxrgGbLYcaqc7c+W?=
 =?us-ascii?Q?m9HFMNjWG2i+bxlv3Ll24eNmXFxbqhd8zsBpUaex4inq7t6h8A5LBnC6FKD+?=
 =?us-ascii?Q?2KJb5nZHmycYKbC/XLf7VzkYW44iLPie4nSyk+6KOGVAbFRkRLN1CUHs6Bk4?=
 =?us-ascii?Q?UGKnM0YQU78pSg6N7yBcREOclP7CXNlAxi9HtCe/jyx1FiA3TEgWQE62Z6Ks?=
 =?us-ascii?Q?H14xNoFFWFgikJBBsRGjNu+8213A2u9VA4tpoNKp+hF+Ru9gxjPQv9s6PbTw?=
 =?us-ascii?Q?LWngLG9YG6Df4+fFSxZN4Xh0LNRZS2nGGkGrGvrVpW2+7E3PK11uvYhdK7MN?=
 =?us-ascii?Q?6jdxb9RuxOUHnWO95LCIxrSDi9V+hfj3adWOTNa2gfjYTTU95Lz5Lg0h7tlk?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0wVze2nyR5zmV2f7Zja3KC3HDb0xuLCgHLqiVAPc5HoGSJfXRbNCfUkIlyx27+W92Ij7+Epcuv0y5g6z+UxO665yV3VaVJ1n98CD7wImIElTeWOxX1OXZhRdygwf+f5fqE1aNvqSdY6en+7Ccydaik3O3g7x8X14AvzlTJmCT7cR+1RZfhM1sJ3m+SQRJcpcy4KbS/bw6PBFjnP7VKn9rWJu3RtAILtFTzwsEy4QLq1q2R4Ji3JSoPFThlPhA+BHcbYDzH0tY1RiadQmq0bfwu7kGmY7VCdVZl+pyYq3d7W8T+I7niWXiw1h6vKihedjZt+g9SIVc+XvjTH+s/lmyaURlGZGQ79kKfZDyisV6ppJp3bOhlumYL8WbZoPBoiZ8NSTr1IsOpsl5mNPozTnkoFuMtiDv0PJv6Ic484R4whERYPbFS0JPBLCIHgn2ncSqPR1gUqZv/EEMtBP1TnNiR9eL+28iZMrk5y0g1NiG21b222MidRleVbdRLWrLPhn07avh+Vkdm7d4puUxZUSJ8oKUqWZRGNWJrI32qkzHcCC5oQ1QxhMddmblq1HJw5VbkJeljegkA+Wf89SDuDuSj1klyV/NTQxge1VlEqdR44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad37e64-796d-4c0f-3fdf-08ddc56b617f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:51:54.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAx/23H7d2CqvmHoTlh9PNXnTiHy4ulfSxEZeShbvFSbmxQE/zC1djrbyzry4N41/aISljLlB2nfnRqIOfyi4Fd32NwgxSc3YjnehNdwhP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE3NiBTYWx0ZWRfX0CA/fgqNgnvD rVWHRFNe4J87MPj1ijDJoeA5F+sEamMlXP027WRlF0aTrZk9sQCQwEBFdUuqg5d6bgNw2BBPk9Z 6WolwCH3LqN4LLbTczxj9UnCUlERHG87iVWgGN5AUNKZi9qn2MNKTbnG1/mBM9EnB9x9AIfRSfS
 jbATDnclnhPhdWlxvxfHM1lMb5ga9dvIt5/XOc6aGvRYuEe968fn45UJpdCDd8X/CJVrlcNS7em RH0hlAOdSboqr/hUQdw77kqSRr7Z0qAAm/HCk5zzC3cuEIxrf/ietxj+sga43UMNSZooDC7OpLk 2PHBuxispLxHrhqQ1LP7i6FlW/pr0gjpzPTlQUa2OOZ6HkU/qC8jKAfyUcvXG1e56nAPxln9lgj
 keOebTxLsGcurtY0QvvySckdzc4GWf/Ghb7peWVmZkikQEGVksN5co5QNcT0k72dC+W91j/C
X-Proofpoint-GUID: l1KstOOfNrL9lwbA4zWHNbm8F9RWiAlL
X-Proofpoint-ORIG-GUID: l1KstOOfNrL9lwbA4zWHNbm8F9RWiAlL
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6879545e b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=mUPUarKZXQvfMSChq2YA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062

On Thu, Jul 17, 2025 at 01:52:10PM +0200, David Hildenbrand wrote:
> Let's reduce the code duplication and factor out the non-pte/pmd related
> magic into vm_normal_page_pfn().
>
> To keep it simpler, check the pfn against both zero folios. We could
> optimize this, but as it's only for the !CONFIG_ARCH_HAS_PTE_SPECIAL
> case, it's not a compelling micro-optimization.
>
> With CONFIG_ARCH_HAS_PTE_SPECIAL we don't have to check anything else,
> really.
>
> It's a good question if we can even hit the !CONFIG_ARCH_HAS_PTE_SPECIAL
> scenario in the PMD case in practice: but doesn't really matter, as
> it's now all unified in vm_normal_page_pfn().
>
> Add kerneldoc for all involved functions.
>
> No functional change intended.
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 183 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 109 insertions(+), 74 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 08d16ed7b4cc7..c43ae5e4d7644 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -590,8 +590,13 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
>
> -/*
> - * vm_normal_page -- This function gets the "struct page" associated with a pte.
> +/**
> + * vm_normal_page_pfn() - Get the "struct page" associated with a PFN in a
> + *			  non-special page table entry.

This is a bit nebulous/confusing, I mean you'll get PTE entries with PTE special
bit that'll have a PFN but just no struct page/folio to look at, or should not
be touched.

So the _pfn() bit doesn't really properly describe what it does.

I wonder if it'd be better to just separate out the special handler, have
that return a boolean indicating special of either form, and then separate
other shared code separately from that?

> + * @vma: The VMA mapping the @pfn.
> + * @addr: The address where the @pfn is mapped.
> + * @pfn: The PFN.
> + * @entry: The page table entry value for error reporting purposes.
>   *
>   * "Special" mappings do not wish to be associated with a "struct page" (either
>   * it doesn't exist, or it exists but they don't want to touch it). In this
> @@ -603,10 +608,10 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>   * (such as GUP) can still identify these mappings and work with the
>   * underlying "struct page".
>   *
> - * There are 2 broad cases. Firstly, an architecture may define a pte_special()
> - * pte bit, in which case this function is trivial. Secondly, an architecture
> - * may not have a spare pte bit, which requires a more complicated scheme,
> - * described below.
> + * There are 2 broad cases. Firstly, an architecture may define a "special"
> + * page table entry bit (e.g., pte_special()), in which case this function is
> + * trivial. Secondly, an architecture may not have a spare page table
> + * entry bit, which requires a more complicated scheme, described below.

Strikes me this bit of the comment should be with vm_normal_page(). As this
implies the 2 broad cases are handled here and this isn't the case.

>   *
>   * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
>   * special mapping (even if there are underlying and valid "struct pages").
> @@ -639,15 +644,72 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>   * don't have to follow the strict linearity rule of PFNMAP mappings in
>   * order to support COWable mappings.
>   *
> + * This function is not expected to be called for obviously special mappings:
> + * when the page table entry has the "special" bit set.

Hmm this is is a bit weird though, saying "obviously" special, because you're
handling "special" mappings here, but only for architectures that don't specify
the PTE special bit.

So it makes it quite nebulous what constitutes 'obviously' here, really you mean
pte_special().

> + *
> + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */
> +static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long pfn, unsigned long long entry)
> +{
> +	/*
> +	 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table mappings
> +	 * (incl. shared zero folios) are marked accordingly and are handled
> +	 * by the caller.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
> +		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
> +			if (vma->vm_flags & VM_MIXEDMAP) {
> +				/* If it has a "struct page", it's "normal". */
> +				if (!pfn_valid(pfn))
> +					return NULL;
> +			} else {
> +				unsigned long off = (addr - vma->vm_start) >> PAGE_SHIFT;
> +
> +				/* Only CoW'ed anon folios are "normal". */
> +				if (pfn == vma->vm_pgoff + off)
> +					return NULL;
> +				if (!is_cow_mapping(vma->vm_flags))
> +					return NULL;
> +			}
> +		}
> +
> +		if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))

This handles zero/zero huge page handling for non-pte_special() case
only. I wonder if we even need to bother having these marked special
generally since you can just check the PFN every time anyway.

> +			return NULL;
> +	}
> +
> +	/* Cheap check for corrupted page table entries. */
> +	if (pfn > highest_memmap_pfn) {
> +		print_bad_page_map(vma, addr, entry, NULL);
> +		return NULL;
> +	}
> +	/*
> +	 * NOTE! We still have PageReserved() pages in the page tables.
> +	 * For example, VDSO mappings can cause them to exist.
> +	 */
> +	VM_WARN_ON_ONCE(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn));
> +	return pfn_to_page(pfn);
> +}
> +
> +/**
> + * vm_normal_page() - Get the "struct page" associated with a PTE
> + * @vma: The VMA mapping the @pte.
> + * @addr: The address where the @pte is mapped.
> + * @pte: The PTE.
> + *
> + * Get the "struct page" associated with a PTE. See vm_normal_page_pfn()
> + * for details.
> + *
> + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
>   */
>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			    pte_t pte)
>  {
>  	unsigned long pfn = pte_pfn(pte);
>
> -	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
> -		if (likely(!pte_special(pte)))
> -			goto check_pfn;
> +	if (unlikely(pte_special(pte))) {
>  		if (vma->vm_ops && vma->vm_ops->find_special_page)
>  			return vma->vm_ops->find_special_page(vma, addr);
>  		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> @@ -658,44 +720,21 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  		print_bad_page_map(vma, addr, pte_val(pte), NULL);
>  		return NULL;
>  	}
> -
> -	/* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
> -
> -	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> -		if (vma->vm_flags & VM_MIXEDMAP) {
> -			if (!pfn_valid(pfn))
> -				return NULL;
> -			if (is_zero_pfn(pfn))
> -				return NULL;
> -			goto out;
> -		} else {
> -			unsigned long off;
> -			off = (addr - vma->vm_start) >> PAGE_SHIFT;
> -			if (pfn == vma->vm_pgoff + off)
> -				return NULL;
> -			if (!is_cow_mapping(vma->vm_flags))
> -				return NULL;
> -		}
> -	}
> -
> -	if (is_zero_pfn(pfn))
> -		return NULL;
> -
> -check_pfn:
> -	if (unlikely(pfn > highest_memmap_pfn)) {
> -		print_bad_page_map(vma, addr, pte_val(pte), NULL);
> -		return NULL;
> -	}
> -
> -	/*
> -	 * NOTE! We still have PageReserved() pages in the page tables.
> -	 * eg. VDSO mappings can cause them to exist.
> -	 */
> -out:
> -	VM_WARN_ON_ONCE(is_zero_pfn(pfn));
> -	return pfn_to_page(pfn);
> +	return vm_normal_page_pfn(vma, addr, pfn, pte_val(pte));
>  }
>
> +/**
> + * vm_normal_folio() - Get the "struct folio" associated with a PTE
> + * @vma: The VMA mapping the @pte.
> + * @addr: The address where the @pte is mapped.
> + * @pte: The PTE.
> + *
> + * Get the "struct folio" associated with a PTE. See vm_normal_page_pfn()
> + * for details.
> + *
> + * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */

Nice to add a comment, but again feels weird to have the whole explanation in
vm_normal_page_pfn() but then to invoke vm_normal_page()...

>  struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
>  			    pte_t pte)
>  {
> @@ -707,6 +746,18 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
>  }
>
>  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> +/**
> + * vm_normal_page_pmd() - Get the "struct page" associated with a PMD
> + * @vma: The VMA mapping the @pmd.
> + * @addr: The address where the @pmd is mapped.
> + * @pmd: The PMD.
> + *
> + * Get the "struct page" associated with a PMD. See vm_normal_page_pfn()
> + * for details.
> + *
> + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  				pmd_t pmd)
>  {
> @@ -721,37 +772,21 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
>  		return NULL;
>  	}
> -
> -	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> -		if (vma->vm_flags & VM_MIXEDMAP) {
> -			if (!pfn_valid(pfn))
> -				return NULL;
> -			goto out;
> -		} else {
> -			unsigned long off;
> -			off = (addr - vma->vm_start) >> PAGE_SHIFT;
> -			if (pfn == vma->vm_pgoff + off)
> -				return NULL;
> -			if (!is_cow_mapping(vma->vm_flags))
> -				return NULL;
> -		}
> -	}
> -
> -	if (is_huge_zero_pfn(pfn))
> -		return NULL;
> -	if (unlikely(pfn > highest_memmap_pfn)) {
> -		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
> -		return NULL;
> -	}
> -
> -	/*
> -	 * NOTE! We still have PageReserved() pages in the page tables.
> -	 * eg. VDSO mappings can cause them to exist.
> -	 */
> -out:
> -	return pfn_to_page(pfn);
> +	return vm_normal_page_pfn(vma, addr, pfn, pmd_val(pmd));

Hmm this seems broken, because you're now making these special on arches with
pte_special() right? But then you're invoking the not-special function?

Also for non-pte_special() arches you're kind of implying they _maybe_ could be
special.


>  }
>
> +/**
> + * vm_normal_folio_pmd() - Get the "struct folio" associated with a PMD
> + * @vma: The VMA mapping the @pmd.
> + * @addr: The address where the @pmd is mapped.
> + * @pmd: The PMD.
> + *
> + * Get the "struct folio" associated with a PMD. See vm_normal_page_pfn()
> + * for details.
> + *
> + * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */
>  struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
>  				  unsigned long addr, pmd_t pmd)
>  {
> --
> 2.50.1
>

