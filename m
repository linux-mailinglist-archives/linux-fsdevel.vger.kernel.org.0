Return-Path: <linux-fsdevel+bounces-55417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BB8B0A073
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF5D7A521C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86EF29C343;
	Fri, 18 Jul 2025 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oF+boYEg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i3/3U2Fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED771DED49;
	Fri, 18 Jul 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752833795; cv=fail; b=fKMThfz6PFZBaxD5RVTabJXJWEGWLlPCaTxeoBbCMwVoF7mpjqQbo3MT84NQsRF72XuBExjUTW0eywN78wF85Ra18VTTfcnktklqpXAovWwVTgxZrgjbgaA80nK2AgXx5pzm3PTYIqg6VvZqhRtSMIuJyNUG2ZJ91XdYPK+Odkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752833795; c=relaxed/simple;
	bh=uGGddbc8qMO3gw/2QkcrYm1YKG4f11cjDMylSD0nwV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZVbSpB76soo1Ht7ZCe52DCWqcxfMH2cQpCmY1xr1Xe7djD7OQWLQK6GJ39eu7e6k2DPtutKfRfR5++/nfosV1Fl/f4sLTCL26+y/JeCUlfS+bsMjkKdeuipNoUA+U0ujKEOE6mVOHZxNpchnfITFP/CqNSBl0HHwpdraEzr94gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oF+boYEg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i3/3U2Fv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8ffvU022807;
	Fri, 18 Jul 2025 10:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Tnd2E7D/jwA1n6sRct
	ZvqV+zd2xBJNs3Cx4M48q66mo=; b=oF+boYEg1GkhQvu4VPWL0PUL+hCJCe46Lm
	TYy6kDZE0FhE/YRCtR5lyTzpTtQa6XyIeho8lSLVxOXuWm8kAAAFVJrnlBYRuURF
	Dwin+6Gt1YPg+VY3ze7EGzgzmOz9zUdsEMGC1mJbccqEBBXuTs7dWu4RmfbkWY5l
	MbVh0gOeWRDSddnOyDPGfYrf5ZcBFS2m+Q1wUx6CTD+E/0K5zXMqKy5mOBzHIJDm
	i98MKx69SPvZJoSRgetf3qcA2Tl0+85/NBo+0vmyAXHuoVU5J3d9mLDu1MV5B97j
	fdFwXuWsg+S7UwhtR0/P2GsQdZwdrsomttZ8OpO8GZP0OGyTOUAg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx84ye0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 10:15:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8ehhe039688;
	Fri, 18 Jul 2025 10:15:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5dxm60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 10:15:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrRVwLsxv95sAOlrkTvdWngWHCEOs51sJEbix/htVmJsK3UVcfc1ze9cTh6MqNy5C+PJztDDYbfW/1XK8q/lAE5sm2RteOhnMcf5wlC3Nyd3SxFKEwZg8xn2JSH77R1trXZ7uJ5T9FRTC2R137Jz2izrzOMmmy/ScwJZJ87K1CCD9N0od1LUMoYPnQA+BjsatorTgGCYogLxvZqnFQeWOC+sR9nKJm9efOT0x6Wu/HXLL9okotBedA1f0ZLiurldITC0+vFB6G9AQ9WbCO7x6UzR/Fd2WXwWYpATLkJ5PE6QqrjAOuVqLH66L6noLCGhvaXP5c0fVcyTqWz0fV0Vnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tnd2E7D/jwA1n6sRctZvqV+zd2xBJNs3Cx4M48q66mo=;
 b=gRDRoNhxpupLf9P2lr3eugWKafavNBUTL902SRtFYMsnjJgHq8zUTTvQO6VtyNgE7vusIm67acXwALF95VvbwqA7pTUoO3VCQUXu/jqLdflNxJ7Dq4faTkXDYy2a7DhwgRBKXIOByXcGImoKZ7zGv7rX1tx3qbTvWrASc2fSpandDlqlEzwgNug7D5R7K4p9sjF3iLbsMcSpRD2W+2Mat+rbnxKZIgsC5zUACk2kwivqXQajS4aoNNs+a2yRxYr5Z10VcyvTDi3bH3DgGLCBDpwSvJ9RK/uLYZYk2/C1tKOpJmQEZAEiMlEjb64z+An/6GYEj99QN4zWLpJU+ZsNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tnd2E7D/jwA1n6sRctZvqV+zd2xBJNs3Cx4M48q66mo=;
 b=i3/3U2FvTNHSKcJeKTiAB3x6kamXXhsocZ4Yv2yPOOe8wpyACIFNQpNVH/xZZ1NHs2O4RIXLbADYT0cOIyyWUgaU+MHNOR/fbtXA+QH+vv/dwf+qAYt5L9n2gnKlH3okn7tmWARqOZzh+yzIM25/hQOfNRIa8qMaykNLVAtG+t4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF1849371D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::78e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 10:15:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 10:15:49 +0000
Date: Fri, 18 Jul 2025 11:15:47 +0100
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
Subject: Re: [PATCH v2 6/9] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
Message-ID: <200da552-4fc7-44d8-bbea-1669b4b45cf5@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-7-david@redhat.com>
 <73702a7c-d0a9-4028-8c82-226602eb3286@lucifer.local>
 <c93f873c-813e-42c9-ba01-93c2fa22fb8d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c93f873c-813e-42c9-ba01-93c2fa22fb8d@redhat.com>
X-ClientProxiedBy: LO6P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4ad504-9eb0-4850-67eb-08ddc5e41185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?39AfOTf+DNJNy6mXfRF6aTkRD2Z50fdAbtcMl7qZaAHuBR6WJyl9dmRFLfZH?=
 =?us-ascii?Q?+3YIswku3w6lWg9LHNBsh5xTT4TM43bYNtKm3FB43Im/sJclWOcyg09kUpXj?=
 =?us-ascii?Q?kDVmdplOVrtKRW8cubA1dlxh+8Qe1x7ySu3E0zkSdQqA2BXO7oEqdEvoiqdT?=
 =?us-ascii?Q?aFXXhq1mwB+mCAJm4tGPYUnyw/UIroVmgl92mvc4OigZgVe1xGBdGZ3LgNJj?=
 =?us-ascii?Q?+dIa1zPndRUq8NAUjUExZ3NtQnq+H2k9VUugrpy9TKvDsrl/bO0sZE0Nyqm+?=
 =?us-ascii?Q?8sdEoI2f7W/HmXWLOGOcq9YyNw/WK9dEE6icK2a/crnI6PyODu5B1JPVbibe?=
 =?us-ascii?Q?7Mvuw77eek09l3B4BNU6EaUlCTC3tLj1AdyBY0K7CaFPoQPffOLNBW81Fu/U?=
 =?us-ascii?Q?IVsrTsMnGpgH/grMLxJ8sy/4jkarhsKmuoeFFAGIVo593WRX02e4PL3bdwzy?=
 =?us-ascii?Q?6gpEt38opZBWuasJwKikDic+ufpVugOcL3AKd4e3nswyQlKWcE0bNTza7VV3?=
 =?us-ascii?Q?MLiJGYuw4+QtH70OfDzcjyhfJOQ2rS/77D9c+D/0CTdAjFIW4yJxJRBTmVMW?=
 =?us-ascii?Q?C1wwaF0odkysL7oA0+LQ9hqEnq8oURuZvaEezgwVOP19QtB50Tbhl6hdji/P?=
 =?us-ascii?Q?/R9dbdSG88y1nqAg9wZEzgeMvKDwyq6K1zeDdeXXqhLxpIIqtZiWQuWCozSj?=
 =?us-ascii?Q?GrAgjoOvw9VKPagVouOaavnkughIjXPmOkScmZK4fV1rThzYE/F8fvMSp2uG?=
 =?us-ascii?Q?AzUn1qFlNU2mNefofC/FV6s2Fl8xpy6Q6t4sSRjxPUZtCwNbs5PlhGf/AI3C?=
 =?us-ascii?Q?Z/9+mCtYo0NAGLGINXoHgqJoBwea2N5DMKEvzgNzmCLT4gRf3PCUkZqMl5po?=
 =?us-ascii?Q?ZYSiPXMtXU2Ub+dqTEi3FTVbKFu6OTVXwNyrDpOpehvN0zkJvrXKDjysXD2t?=
 =?us-ascii?Q?02E/khPJkRfz7oXclICTZt5koCo5EX7XQqHE62Dp9qHUqGKkMlcWnVxx0pwJ?=
 =?us-ascii?Q?V7621K9vqr1l73KQEAVuEhuks2vjFTieO3WVkejg3QYHz8ucYrR2ajz/CaUb?=
 =?us-ascii?Q?GhJxFlNzIJivx6kzmLYrUjuWtSdpSlJf7CWY14Cm+Fpn3IriZhrbFaWdgJAS?=
 =?us-ascii?Q?Gt5jA5G7VDtH9CjUdZYABLPDhmTo4KeszJuogFj4bXUp7CxlfGo54fqfSCsS?=
 =?us-ascii?Q?GWagFpC7g61tpFLugNQfhyXHv9xaRoet0tbgcnlysfn/4QKU2VXmoTwXuvw/?=
 =?us-ascii?Q?0mBENgzrSWVX1fR2iybTYjd1UUwGXlUkHJXxy4RnnlyGdNb+DWydZ9O5yR7d?=
 =?us-ascii?Q?Hnh5NtgjI9H0z4BTMJWL+ZoLGIkfu/rTYgXjOOE1bgaNusVJxA+5XWTHiiFj?=
 =?us-ascii?Q?uvEleVCk4an4Nay+F8ZFZJb6WYIOmJ6vJ3VlOHDbczr3OfKyOLO/eDBrmgTu?=
 =?us-ascii?Q?J25iMU80RwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yPmwn093LFWLDyIRSd0MUa9NPMee224gGtco2tz7L7ROJmSShGYSWIgxRurn?=
 =?us-ascii?Q?qZucj0KVCK7xJf7BfJmQDMIfm0sgq5iR+UA/cK+9AOUj940Hu4EJs4aU2kx+?=
 =?us-ascii?Q?phCL9Myz4izW7WCo80YZtlLjof16CrxCXIvoQiPNuqn7zUh75q1PDBPePMDb?=
 =?us-ascii?Q?tD6K56nTLGnDB0x2bWYhe415DUTxdIdSwCJKUavHYIovIo3OTG9TtnTsdRst?=
 =?us-ascii?Q?ir/qJ1NGMa+2Le5czWd96o0BH35rB+oandtq8ZCLb4fRHCNovgHBCbqd8yzn?=
 =?us-ascii?Q?72eiCiS8IsDyNn3oCD59MgiLv/RjJ9daN6M/6INfF73yNfH1WGWf+8jOgHtc?=
 =?us-ascii?Q?92Fs9uYskPQ7ITBdPj9aULWcyukcwyZWBecRyJY/R9cXVadY87/eaqUnWikG?=
 =?us-ascii?Q?dDyes6gmRXU0K+OP62cHmR+DqsyEA6gxG2gIa+1huK7J9sRYNe7HYQSyz/Im?=
 =?us-ascii?Q?+0kXdFZJlg7a4tIHB6UCrhzMlglJMAATjuqzOR6MMDOgv1dBVoT5/BifKR8H?=
 =?us-ascii?Q?001MgVdLIqTbtetbZ1q47anadL7MO579RNePryuNjJOP3V5FYOW8r8ScMeqb?=
 =?us-ascii?Q?9PlXpaRFX6CwhHq6UDFG5Zps84Pnhp20GNqDjTe9PEVp7agckwLmsLb7rosW?=
 =?us-ascii?Q?cdCncNLaDkQF9s9KW5r3GH4etCOqyCzIJQbKv6K9sudWzq3USN7jNKJRjotv?=
 =?us-ascii?Q?ZyPw/Gl4Srmgo/gjjuVelDITqoKYMeSNYV0KL7A64Sh9RwQaVj8vXcUcknBs?=
 =?us-ascii?Q?K6KVNSXUVEk7H8tTStDbxMNtmBFG0EW7XRAFOyr9w8SMRp4v0YB+JjxJZfbB?=
 =?us-ascii?Q?UrYCBXUDiyuGf5JV3CWNxgJqBFQAhDKTpwBRZfsq9CwonGtGgFwTcoIOpqC7?=
 =?us-ascii?Q?d/iXP+E/aBkBX4GhgPuoPFKcPbHc0dSQ4V62s5sn752YPLBFaA/gwNwLJH4T?=
 =?us-ascii?Q?4wJ42SexA+n+gH2KfwU7oEh3uJprQUH02iNdeNzyglpGj6RspQJytQz0NCZf?=
 =?us-ascii?Q?fXsQ9DWh3kvwbkwxqIFMwC6tCZ4ndmCdH7wfsqlIXn7o21F4Td538fuVGoox?=
 =?us-ascii?Q?tl8JxI0gdsJ5+0pFfA52Sx0At56B9MAYuDz2pOb8f7WQgZFVLl46qj/3X2aY?=
 =?us-ascii?Q?Tir4ZKuuDeswGrNihSjI3a0OlQbVkAqU93QN0Y9UoW3BmsjUy3Bspqh7zQcM?=
 =?us-ascii?Q?W05eJeaGDWFectXIsRykzwIqbSjAXRdYkkZU+5KgV57aEyDoAEgGYpSvWIAc?=
 =?us-ascii?Q?+czrWgQavo+XDawrO+Y4ox8PTo4ir1M1dCfden2m2vg7vPIVg5hVDi0+Ts52?=
 =?us-ascii?Q?mAG9F2krUEZDeEtxX+r9zJ1CUYtX4ZIkBTJMOIqp69qcv8XRmcKa5xEUZDoM?=
 =?us-ascii?Q?NsPLhscED8Vwi4ADDL/0fZijxJ0/oYMPSmWWQ7yct+x07Xwmts6RAElNdh9f?=
 =?us-ascii?Q?rd97681JeD0vH86tzM+SDiTHV2Ufy7/zQuk4f7dSkOzwVCmyFxYZLceKf3rp?=
 =?us-ascii?Q?DjPb/jvYHYzG8uVII8xNZBdDlCx3MqVg98n8QhT8uWSvadFD70Fn2Y0NaKHN?=
 =?us-ascii?Q?9AP2krt+LkBd/C9SRbCfrbbsA174ZrMUBpqLj0oNDKSlyKQWMkTdk/oEfJvo?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bbgL0S9GZFPM0/+uV1G2eC8ejtXoCI/BsZYMHXN2sLwZIXYBIvPbHBo6wPaJ72h7UQOwveAqOVA98nws8kY7QKBDpjepTjANe5PHDTVaxERWjlUobI84mXW+phXaByMHgyJMEMdQZYuQfYzjWvZNzlNJ9E0XnpIfGMoeci4cX6I4ms8kI7hdBVkot/naOITuTXAVt+se+56X9tb5nYf5/Ov3MPVU/3tGps6/1ZNgE6N6fyn8+6W2DF/6VsPSZKgdMci8VfZrNe4JVqzQnnByrglKrhtM6kO+GEjBFnO3v0KB1bgTMed86vqp1Um3vcvchkR1UgkBLdYEogITBZMO0eGES5boaBEo9DyPurrHWW78iyGdRxAx97qgjDe4culwOtljAZEcnJtg2bUBi2VflRlBWW4oYMJ/HFxeqUOQpMplrOF8fZ4XCL73AFnH6f9+Z26ZT3r/A48u8XzjLsyH8C79R3Am8m3XU7128hSoBg96JB9KT38Opdr+OgANjpHzNWZYG9aomOFzoqcbaCb2bQGwRyYqfwuP7jkiqwbcbb2Mib0ibA8/6FJN6vWNP81yPZeKHb8F1BIBWq9QPtaPhfRkWfOSD+aIoN4vJ6gnFgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4ad504-9eb0-4850-67eb-08ddc5e41185
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:15:49.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTk+/tNkZULAmaZHvjtsi4a7M/8G7irdeXI568ZVivBG/fEwWkfYagLnah//Y8zr/mtEfNDLIXpcj7ZSTko1EzwQ0X1oTPorlyk2T5+6wuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180080
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687a1ed9 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=58EoUeYbtHUeDGLcjXUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: rt80JmRpL9B9FQQF8PKxmv_6H3C4Nlqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4MCBTYWx0ZWRfX55Ti8hjiodpL kKNJiXmZM6EHsyJzqGAkPdP8daLF3nG928uifg08besEHkELlwWe8GFls75RWsy9ves6i7YbkFk 2pJ+nu5S25yuunz3xkdA909ErvWbG8cJDhbJXSMUojDiNf8psAlaixAYYTyuk09ViIoYYbkfV0A
 fQfuq6QzgYUmP4A54VMICZ8fKcJiSD+p5+COqcYRpLUItZJj/Et27Vd+KTWcr46COESCzgBD2Ep qLV35XA2mBb6ULhFbG+ylooNHZZGnf9GEGf3m98BvZEXc00zUYl8dKjc7AJ3laj1/nCv9WSHsR+ WuqiOqg2Uz1kGPC84aXYi4/0B7aW3gJtkQF1F6zAfNNUwF5Hrgxz83ysS5CDVZPbxuNr2cwgGtM
 N00nGTkd7FmCQpWk5F2cAlljF0KTYFSaoGZ4e6GkFw7m5jKkfgkxa6Y8LMKHVd6RdGgULaQt
X-Proofpoint-GUID: rt80JmRpL9B9FQQF8PKxmv_6H3C4Nlqx

On Thu, Jul 17, 2025 at 10:03:31PM +0200, David Hildenbrand wrote:
> > > The report will now look something like (dumping pgd to pmd values):
> > >
> > > [   77.943408] BUG: Bad page map in process XXX  entry:80000001233f5867
> > > [   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
> > > [   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067
> > >
> > > Not using pgdp_get(), because that does not work properly on some arm
> > > configs where pgd_t is an array. Note that we are dumping all levels
> > > even when levels are folded for simplicity.
> >
> > Oh god. I reviewed this below. BUT OH GOD. What. Why???
>
> Exactly.
>
> I wish this patch wouldn't exist, but Hugh convinced me that apparently it
> can be useful in the real world.

Yeah... I mean out of scope for here but that sounds dubious. On the other hand,
we use typedef for page table values etc. etc. so we do make this possible.

>
> >
> > >
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   mm/memory.c | 120 ++++++++++++++++++++++++++++++++++++++++------------
> > >   1 file changed, 94 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 173eb6267e0ac..08d16ed7b4cc7 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -473,22 +473,8 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
> > >   			add_mm_counter(mm, i, rss[i]);
> > >   }
> > >
> > > -/*
> > > - * This function is called to print an error when a bad pte
> > > - * is found. For example, we might have a PFN-mapped pte in
> > > - * a region that doesn't allow it.
> > > - *
> > > - * The calling function must still handle the error.
> > > - */
> > > -static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> > > -			  pte_t pte, struct page *page)
> > > +static bool is_bad_page_map_ratelimited(void)
> > >   {
> > > -	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
> > > -	p4d_t *p4d = p4d_offset(pgd, addr);
> > > -	pud_t *pud = pud_offset(p4d, addr);
> > > -	pmd_t *pmd = pmd_offset(pud, addr);
> > > -	struct address_space *mapping;
> > > -	pgoff_t index;
> > >   	static unsigned long resume;
> > >   	static unsigned long nr_shown;
> > >   	static unsigned long nr_unshown;
> > > @@ -500,7 +486,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> > >   	if (nr_shown == 60) {
> > >   		if (time_before(jiffies, resume)) {
> > >   			nr_unshown++;
> > > -			return;
> > > +			return true;
> > >   		}
> > >   		if (nr_unshown) {
> > >   			pr_alert("BUG: Bad page map: %lu messages suppressed\n",
> > > @@ -511,15 +497,87 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
> > >   	}
> > >   	if (nr_shown++ == 0)
> > >   		resume = jiffies + 60 * HZ;
> > > +	return false;
> > > +}
> > > +
> > > +static void __dump_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
> > > +{
> > > +	unsigned long long pgdv, p4dv, pudv, pmdv;
> >
> > > +	p4d_t p4d, *p4dp;
> > > +	pud_t pud, *pudp;
> > > +	pmd_t pmd, *pmdp;
> > > +	pgd_t *pgdp;
> > > +
> > > +	/*
> > > +	 * This looks like a fully lockless walk, however, the caller is
> > > +	 * expected to hold the leaf page table lock in addition to other
> > > +	 * rmap/mm/vma locks. So this is just a re-walk to dump page table
> > > +	 * content while any concurrent modifications should be completely
> > > +	 * prevented.
> > > +	 */
> >
> > Hmmm :)
> >
> > Why aren't we trying to lock at leaf level?
>
> Ehm, did you read the:
>
> "the caller is expected to hold the leaf page table lock"
>
> :)

Yeah sorry I was in 'what locks do we need' mode and hadn't shifted back here,
but I guess the intent is that the caller _must_ hold this lock.

I know it's nitty and annoying (sorry!) but as asserting seems to not be a
possibility here, could we spell these out as a series of points like:

/*
 * The caller MUST hold the following locks:
 *
 * - Leaf page table lock
 * - Appropriate VMA lock to keep VMA stable
 */

I don't _actually_ think you need the rmap lock then, as none of the page tables
you access would be impacted by any rmap action afaict, with these locks held.
>
>
> >
> > We need to:
> >
> > - Keep VMA stable which prevents unmap page table teardown and khugepaged
> >    collapse.
> > - (not relevant as we don't traverse PTE table but) RCU lock for PTE
> >    entries to avoid MADV_DONTNEED page table withdrawal.
> >
> > Buuut if we're not locking at leaf level, we leave ourselves open to racing
> > faults, zaps, etc. etc.
>
> Yes. I can clarify in the comment of print_bad_page_map(), that it is
> expected to be called with the PTL (unwritten rule, not changing that).

Right, see above, just needs more clarity then.

>
> >
> > So perhaps this why you require such strict conditions...
> >
> > But can you truly be sure of these existing? And we should then assert them
> > here no? For rmap though we'd need the folio/vma.
>
> I hope you realize that this nastiness of a code is called in case our
> system is already running into something extremely unexpected and will
> probably be dead soon.
>
> So I am not to interested in adding anything more here. If you run into this
> code you're in big trouble already.

Yes am aware :) my concern is NULL ptr deref or UAF, but with the locks
held as stated those won't occur.

But f it's not sensible to do it then we don't have to :) I am a reasonable
man, or like to think I am ;)

But I think we need clarity as per the above.

>
> >
> > > +	pgdp = pgd_offset(mm, addr);
> > > +	pgdv = pgd_val(*pgdp);
> >
> > Before I went and looked again at the commit msg I said:
> >
> > 	"Shoudln't we strictly speaking use pgdp_get()? I see you use this
> > 	 helper for other levels."
> >
> > But obviously yeah. You explained the insane reason why not.
>
> Had to find out the hard way ... :)

Pain.

>
> [...]
>
> > > +/*
> > > + * This function is called to print an error when a bad page table entry (e.g.,
> > > + * corrupted page table entry) is found. For example, we might have a
> > > + * PFN-mapped pte in a region that doesn't allow it.
> > > + *
> > > + * The calling function must still handle the error.
> > > + */
> >
> > We have extremely strict locking conditions for the page table traversal... but
> > no mention of them here?
>
> Yeah, I can add that.

Thanks!

>
> >
> > > +static void print_bad_page_map(struct vm_area_struct *vma,
> > > +		unsigned long addr, unsigned long long entry, struct page *page)
> > > +{
> > > +	struct address_space *mapping;
> > > +	pgoff_t index;
> > > +
> > > +	if (is_bad_page_map_ratelimited())
> > > +		return;
> > >
> > >   	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
> > >   	index = linear_page_index(vma, addr);
> > >
> > > -	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
> > > -		 current->comm,
> > > -		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
> > > +	pr_alert("BUG: Bad page map in process %s  entry:%08llx", current->comm, entry);
> >
> > Sort of wonder if this is even useful if you don't know what the 'entry'
> > is? But I guess the dump below will tell you.
>
> You probably missed in the patch description:
>
> "Whether it is a PTE or something else will usually become obvious from the
> page table dump or from the dumped stack. If ever required in the future, we
> could pass the entry level type similar to "enum rmap_level". For now, let's
> keep it simple."

Yeah sorry I glossed over the commit msg, and now I pay for it ;) OK this
is fine then.

>
> >
> > Though maybe actually useful to see flags etc. in case some horrid
> > corruption happened and maybe dump isn't valid? But then the dump assumes
> > strict conditions to work so... can that happen?
>
> Not sure what you mean, can you elaborate?
>
> If you system is falling apart completely, I'm afraid this report here will
> not safe you.
>
> You'll probably get a flood of 60 ... if your system doesn't collapse before
> that.

I was musing whistfully about the value of outputting the entries. But I
guess _any_ information before a crash is useful. But your dump output will
be a lot more useful :)

>
> >
> > > +	__dump_bad_page_map_pgtable(vma->vm_mm, addr);
> > >   	if (page)
> > > -		dump_page(page, "bad pte");
> > > +		dump_page(page, "bad page map");
> > >   	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
> > >   		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
> > >   	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
> > > @@ -597,7 +655,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > >   		if (is_zero_pfn(pfn))
> > >   			return NULL;
> > >
> > > -		print_bad_pte(vma, addr, pte, NULL);
> > > +		print_bad_page_map(vma, addr, pte_val(pte), NULL);
> > >   		return NULL;
> > >   	}
> > >
> > > @@ -625,7 +683,7 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > >
> > >   check_pfn:
> > >   	if (unlikely(pfn > highest_memmap_pfn)) {
> > > -		print_bad_pte(vma, addr, pte, NULL);
> > > +		print_bad_page_map(vma, addr, pte_val(pte), NULL);
> >
> > This is unrelated to your series, but I guess this is for cases where
> > you're e.g. iomapping or such? So it's not something in the memmap but it's
> > a PFN that might reference io memory or such?
>
> No, it's just an easy check for catching corruptions. In a later patch I add
> a comment.

Ohhh right. I was overthinking this haha

>
> >
> > >   		return NULL;
> > >   	}
> > >
> > > @@ -654,8 +712,15 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > >   {
> > >   	unsigned long pfn = pmd_pfn(pmd);
> > >
> > > -	if (unlikely(pmd_special(pmd)))
> > > +	if (unlikely(pmd_special(pmd))) {
> > > +		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> > > +			return NULL;
> >
> > I guess we'll bring this altogether in a later patch with vm_normal_page()
> > as getting a little duplicative :P
>
> Not that part, but the other part :)

Yes :)

>
> >
> > Makes me think that VM_SPECIAL is kind of badly named (other than fact
> > 'special' is nebulous and overloaded in general) in that it contains stuff
> > that is -VMA-special but only VM_PFNMAP | VM_MIXEDMAP really indicates
> > specialness wrt to underlying folio.
>
> It is.

Yeah I think we in mm periodically moan about this whole thing...

>
> >
> > Then we have VM_IO, which strictly must not have an associated page right?
>
> VM_IO just means read/write side-effects, I think you could have ones with
> an memmap easily ... e.g., memory section (128MiB) spanning both memory and
> MMIO regions.

Hmm, but why not have two separate VMAs? I guess I need to look into more
what this flag actually effects.

But in terms of VMA manipulation in any case it really is no different from
e.g. VM_PFNMAP in terms of what it affects. Though well. I say that. Except
of course this whole vm_normal_page() thing...!

But I've not seen VM_IO set alone anywhere. On the other hand, I haven't
really dug deep on this...

>
> Thanks!
>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

