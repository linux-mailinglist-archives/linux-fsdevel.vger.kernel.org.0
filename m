Return-Path: <linux-fsdevel+bounces-66343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 022B7C1C4A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 511F5567B10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8208347FE3;
	Wed, 29 Oct 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrI0srwf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pw//QILF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71823286416;
	Wed, 29 Oct 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756690; cv=fail; b=inaQqqXBVqIMv+JawHxL5gDTMzu/H6rahCQmOE/bax8sLOoBZK6+XUJaa79PRuStxhAvGj/lr9NBfjZn85rsOgcFPGACir85g+Exgiys/KEd6Uko2CvyEmMF4stqsAPF6K1h43FngkBKY0NGb+6TXxtKlTR4Xo/FH7/vsCpWAIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756690; c=relaxed/simple;
	bh=G96rkigAgAKIPlpsgWGhXkQC2vNTozlHfXBXt7ZWB2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vByIf4F0AyyxfUj3+leHhOxNMLzV0BeVpqlc7iVSniRIrEuDzoc1EmuecWx0sqPCPeOsN/c0A1cGqSJa4V2uT+awwFlndZUZ/rBOTqUlv5EmkIfVCvqaaDdE9KBKNKFZYElchnsuVyWyrleHZrh3vRRaUFmIgszD7creavro0xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FrI0srwf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pw//QILF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGfs4p006499;
	Wed, 29 Oct 2025 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iMqZnH4omUWxTW4m+0vOfkZf0Qv5j09ed0RYDmGke7Q=; b=
	FrI0srwfJlg7R+msPulKG7kZ9g9e6xsZpbtfoXJ7l3DnUH6Wr+/DvbJUuPCXcmgg
	smycYq7gB2+B5TPQ+9vrYd+MOFjZm614H1TBtcRXRcpBVgo4Fnip7rR/uGYdfK+4
	uOhEwGtmHqBOsc10u9BialseVcVffF/h/zVa22hGhQskpAl0dZKyEWjM+a/cyMpE
	BrNBCUpSLAQ6+j8Mf08bOhE1+YLsH5CKf0mM5DqdqIP3zXhaY1pnb6DZRF6orPEG
	3we63PzL/ohfwqoSIEEW3IXdHffwYNJsFyhVshSJXNy6U8ae0L9zkAqVYGk8SVvb
	TljR2LSxtzzNy1lPf8RMmg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cv99j4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:51:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TFWEZH022996;
	Wed, 29 Oct 2025 16:51:08 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33xyfvr6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 16:51:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyAp+gDK8BU9oOpXGMF5t24jjR6AmY25jeQHGtOzqJQJJxxKjZeK9duTbeavY2tiVMOSiiZXMqVCxJj8PdfacQULq9RQeVy274c37/NaAbIRxaoDiQvyjP4a5SqtlxrjMJg2WzIN2O7DZ6sj66vVGBHQSM53zXiOrii5wjDfHBZCkUn0A8RPjoq7b30A6IXvC5W44lW4MwZYVkb/8q0XIKLJVweeAOf0jkpB9coQM/fCFtcUZ7R+uDlTI9WiAJX3ymY6Tv65GYzE6RMUCvz2517oM+IDgNYZDWrJqyC92rK/Hh2DW7atB/vwpsPLtaTU22tT0/ooM4NnNktIMmh67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMqZnH4omUWxTW4m+0vOfkZf0Qv5j09ed0RYDmGke7Q=;
 b=ZiugzcPqqIUwGOBVFe6XMKQpTJhsINSyGsRqvdIvHXIB+ZjU5swbWQAFTIdZH936dFBYKJWGp+ZSFarH1xNzNBzFvAq5qtulArNc21HugXSGyZeLnqO7Ud0kdBktf2P4bs8slARLIALB10CpT4g0yfc0pf97t8kBZlk80JC6IRpXvTLBIB3I949NiVo9ltXIVUIHvtLgWKZYTvraDkpyHJ49TxdXiUvBG4ynQ9oXGno4t1Ni9E+z3Z5Hp3PbpnkIpg5Pkf+jNGipW0bXF497zaBREUkxuOLyVJ2Q5U1Ana7uFrTjeNzAmItZu2YPx+291V3k7q1N/dxBwnVOLqrZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMqZnH4omUWxTW4m+0vOfkZf0Qv5j09ed0RYDmGke7Q=;
 b=Pw//QILFJIZgm6EijBGhynRlKO5FlJAm5Rju9fepwdIY5Vl1xMtEahioMopWttxRh9rRLvs0bj5iflAy/4t3RVRF0YWvfA6dmbk3rFPvlBtGn2jFCPQj3HJKXfn5E2CoJib6sVOrhv4Ugwkdb7DMX6kTZML0WKJ8Sw0qGTqxgDg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4251.namprd10.prod.outlook.com (2603:10b6:5:21d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 16:51:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 16:51:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/3] mm: implement sticky, copy on fork VMA flags
Date: Wed, 29 Oct 2025 16:50:32 +0000
Message-ID: <ec71238fd1f735ca6e4970ccdc0abfbb60967596.1761756437.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0304.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: d67f0875-8b8a-40e4-4ac8-08de170b59e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7I6I3Jj8g3AWtYf1QiLJfYiJWSAsUb2zmuF+q5AMNlo+AeP3qiEMkhq7bclx?=
 =?us-ascii?Q?5XUfeuMuLTqW15uYL6xFa04N/4ZZZSAXl6kKY6o7WCs5lBupozC1mDu/cIaa?=
 =?us-ascii?Q?PriB83eRHb2r1aCvDRjGij+pX2Oq5KfOIBQ2/vS7gFWBkK9L8xs7WpNMqLyG?=
 =?us-ascii?Q?iP5I14GZSfHdgIUnORNhEM3DEc7jB6GeAnBZ70FEsB7bVgDhoz+fUPUSpPEw?=
 =?us-ascii?Q?NIsDYPdyEmTzJ/Ir8Q5GWzYvfu5j/Bzdvo/9Tmr3HildSik9kXNyrTAEXY3+?=
 =?us-ascii?Q?0KsjdpApduxQNgZtnGUjQbcQeJPHoi/PuQzl5nnUgguUKn4SRjXn8mYblzNz?=
 =?us-ascii?Q?CwCLUYdWaBVxOSF7oNWc8VeU7TeyR+Jp9SlqlZ6m1NCccbLBdbdFZT7wiqIf?=
 =?us-ascii?Q?trLk/NTRCAzYQnghnlkwoMkek1JvBsQ6m7/VBelteS0VPnQDZPC++4reIORC?=
 =?us-ascii?Q?tILblct6fmiPTohj/lhSXYyf+wqr0Z0mqnDwC4Xv2OXt7NQ94KPoPWBpvLrd?=
 =?us-ascii?Q?w4vw0Y92Oq0IbEjc7ZzKCsq7MOhJE2K9dXeCOeh+1dBftJLun1OqeLOKLVpz?=
 =?us-ascii?Q?/KUWDUqrzyqKauYHGEDnhAwmLoWOtijSmOdz1wLLfeBprbs1Yhz3Uots5aDH?=
 =?us-ascii?Q?Tqqt7pLtvg6fiNJWf3mGJ9VL4DWJDOqPgvq69dqSjtz4MtTbPikc5pm0YSjs?=
 =?us-ascii?Q?NIoDrHRoZpN03CAYhs+jyRRa/nZzBIT85meQXGAppL9kPhdu4ynswlq6Vckb?=
 =?us-ascii?Q?k502qWBdHTIUBWgd52CIWTERaoBNmZCPjhalmVPsPj5CGdDdmK3BjVICBVUM?=
 =?us-ascii?Q?H7zvCbwIhbzMBtaR7OPLOQI8Kli5QnZ2IEfs7YOPimhW/5Ept1c40mE1cvkl?=
 =?us-ascii?Q?oQshcmwUsk8nc9Y83NxYHo4t4pwL5Jk/2wUXZYY+353DDBOLgQh1FsuWrR8z?=
 =?us-ascii?Q?LjVXGUYLTWz9U1g7tthX9q/DGzBYW0GhphZDLe/QEI9eAytre/wGFj/Qsczh?=
 =?us-ascii?Q?l2fBjW3fYnEgZ7WPsdYAs88YY6nig1ARakaxWVIhHzc22gTHjWTpLdlip8SG?=
 =?us-ascii?Q?CtKFQHoEQ4h0nec6nDp6u0s4J3E/KXL0dYGzXZignR9TtkH5aUQ8miYqh5dw?=
 =?us-ascii?Q?hybZv4QtwZ6p/4bM+ch9ds/pNOkvsMYmpyeP/JjNiBGQ51QA41WtTai5+5Ev?=
 =?us-ascii?Q?MeBNiHgf793kGcPtBOG3tXpQsXhkj0+ZI3w0E/hUAP0gSay/BYfXjUm1AqPd?=
 =?us-ascii?Q?F2CvgeQwVLjuH7ApAldT6Twikoy4KuO1vZ50ab5wLHJsmgOrFw/x5jO08uAw?=
 =?us-ascii?Q?ykyL+tJmFco2Hcqcxd0M0cCGiQDPkProqoI6HmdxV/k+S9WPodhmL1mQED1t?=
 =?us-ascii?Q?nvoPipvCuQQnRw3QC5yNgjyzU3ZPa4eNE855vhoWLLbhuLY5YMFGI4Vh5LN+?=
 =?us-ascii?Q?fZEgB9sn2ishd/hvJ2Nh726EJkJD6MSb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pxFJkIQxGrQ6KNOOXBVhFw6GT6QFsxTOHwu7V9W/ctuUIXBa6tgj0uNXxhyU?=
 =?us-ascii?Q?6uwV6EgVE1CgX1EkcxX4tzx3pLjwsGMPsouRe6PKwh5QElfj6+lpTOCLyZ5L?=
 =?us-ascii?Q?MVBg7megO4f6PKJyJ53V6bpZK3gG6C5DgknfukWoOxZDVMVFgrPEGySuS3Sp?=
 =?us-ascii?Q?8b2q9ai7q2rau5lyu9BywNFX5Ak34KTN54OQ7V8G+Pv/ljQ2ZBq8VMWTjMZ3?=
 =?us-ascii?Q?LoxlxB115qUoUDx/DkASE37bPLHPWe5U4OR7dnoT4fV276HizJcZNO8+iDy/?=
 =?us-ascii?Q?434QGlN1VnWdteeNmWzLm0YKLQTMc1tkGOD5OQC72llcQ70qoBttHSgIgbfk?=
 =?us-ascii?Q?0eLjGo40I2XNVvY/d66QjVDAaqs9Vcmqxd2UzKJEUaYP5BhM1GDX09ljvP9w?=
 =?us-ascii?Q?BXdoX0oJ4KYWn0Hfqfq6EUEWfNdnM8Gu8/EeZszwA/D9gng3FJDSclFvL2C2?=
 =?us-ascii?Q?nk/kNiyVeX/9t/OOyDTT4MZHBB0jl4skWpH/vBYF897UOhQ61/JtnXzquNW9?=
 =?us-ascii?Q?ujjOxP2lmgANGoMjwINjZYtoXpshy1VmEPleVWqHpmkgkPEfhScqVbVOEOBm?=
 =?us-ascii?Q?PqUR7sSpcSLLDA2zg87lAmp/XYm4B0Y7ZQhsrbi6PnzxX44tJ3MUOSYEfQi1?=
 =?us-ascii?Q?tW0nyHWYZX9grAsFcPis8/4xyaH0flffJAKzH9MfolVkVdzu1oTtcPKFDPcw?=
 =?us-ascii?Q?X1ae6hDQ9SC3fWhBIb10zToBojMy6enx9fQMIv+kOKxFlf2aB5GV6y4vVD0S?=
 =?us-ascii?Q?dJA78UvhxDG7xRyXpiA1nSZ5stIwmaD90l78ImWXbMVrxQjrP3YPZYDKRjNc?=
 =?us-ascii?Q?XNkrwgnCw7q0IyYmZC0nWXx4mT1YO36K4WDoKPe8HZ9p1OfQT/v5/YitaXIM?=
 =?us-ascii?Q?a+x2C8VWRIwtgF7M8GoLW266hTZHRVc3jJRzHexD7+An4ZgVLzwryaAiTC18?=
 =?us-ascii?Q?+DG9CyKSSVCEjjuAWN0DZagVMq2ab+QYZnD0+aVwIRrzEa5KBy+9e5BgjRvt?=
 =?us-ascii?Q?q8K2Jq8lPtbuKoDu+s2pfWxkBL7XWoGUc3PBMnf3TOvfUSeUttWSUd3alzwS?=
 =?us-ascii?Q?bKFMfY0nQsWtwUEIG9vhLzSHVolGjtqb4Wsn/6rFgeYtN6hRbfRecxTNLljQ?=
 =?us-ascii?Q?3MQ0XtVPouukset7CvT9hofUU+wI6GNR/IfMvU6rnzm8ytsEdqOSPZYXN0l6?=
 =?us-ascii?Q?pIxxPqMmB7PzFTkFGOOy2yG9ONInZZggjDiCmuFu9GBtaLKW9rmmGTQAtaQ5?=
 =?us-ascii?Q?Gk1Mvtp0qQ2l8KvqAyn+ki6OPRGSCPIPy1XsETxvMu55q0yfGEbC9i1Pz/wi?=
 =?us-ascii?Q?WdozBlA+8jwAIkW6ibwWeV57PnMJKWs9s8nwjhBMTEtEtMKAfY5ier6dpoHy?=
 =?us-ascii?Q?WpnOQFSqEEQYFjNQKeo7sPl803Zv1tJPLby+Hjsrkm4xqS4AjCSAVh3KHtck?=
 =?us-ascii?Q?N3oPV2SqRFHOSLhA93aIjrkPm8s9C8UgaKkn86bsWupNJ9BzUAH/yRKpYMCk?=
 =?us-ascii?Q?fiZZTqhyXuEAXT2uMFhLiZ2HDOIz17j8fjRZGd9K1qNXcq1+qTri3NcRsziN?=
 =?us-ascii?Q?6SNKzcB4b93aVfD3G2b2iB1c+kquvfzpsTN1xEnQFugy3KB5YKc4IHe9gj7v?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vP0YlLcIgRg/dUpvORL8/ZzSGsuMPfAomlGfgx1McRfGomt2uwJjyBKOa0b3HEjxQ47Coy00mBluQr9CSX2ws4gL5SoS8go5hECqDXUcUNJRmMM84ykYy5saYjGz1uGmK24muRA+MndpvHgFndFsFmftVAXeEnzGrRIYMixRBVib4rllIeOAZrftiVB3JaKG92hf+yKds5Pti5tGnqU1lmlVKp8T4T5Wdhy1pXCnXRO5FXFXrtS1PuS/ssVE9AbT0WJrUcwqFGo/tqu26DlHy7L7U8AnQAmHeVvyQOI4kTCWfpXs1cPol8aPEyWaEWHirApxWot4Vm6Q9Ma7yIRNaPZ1amomdiOfZI/szktF3rtLy6Vg0J5Dln3prRTl505kYSCz8JYfQiav7Pzg/99RcHDNgWsevV8Poz7zPdD9A1kv1znLLl7rfZuqITrh5r8GFtmx+MsOkUzp/cI8T6gwFB3m2DaCBMwO9a+nV/s7fUecsVSFT30cjiXBcDe/Gf1f+jJM9cTmULWSM4EBNa74m84Nwk4AP6U1tlPYB13TcxOLgfxqeRwHFGZKhOtstGt4TV0DRNjjL4AoRyxTBl0BNi6tPACTiRdv0QYD5Pww+xw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67f0875-8b8a-40e4-4ac8-08de170b59e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 16:51:05.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XCarLIk+gFCp+E6SKU9Gs5v36cskRMnQTn+BfrzVkB2b/tYvDoK4Z/I4mTfMW0qDnqb3+aPjHMWe1WhCNhBPzidfIT3jps7KdBgP+IpSZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290133
X-Authority-Analysis: v=2.4 cv=NfrrFmD4 c=1 sm=1 tr=0 ts=690245fd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=uaDuWM232xa27JKlA18A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: UQV4vwmCLcUTxgh0lWgVuvofBFtwyM1R
X-Proofpoint-ORIG-GUID: UQV4vwmCLcUTxgh0lWgVuvofBFtwyM1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzOSBTYWx0ZWRfX3jvzIHMq6sf3
 PyYo1EnsjAiXi4NDxWFoqQbLP7/tqBq5oJ2ny1ICf8OP2UaWdspPdUqidb/hT7xsXTMrBa48svv
 vW0wSTxxlKVzTvAix7IGwRlTiV5x22pztJEO0Y4MPIvRj1Ih8uTD6i4/SyQhLOQ+PAVnvzgo4Sj
 jnhsEidvaP8n5WCecnpLHQ3SrSBgSo0bKjfmEwTrDsrzbkOe1DEMZ5Gh2mUbQlRFYVONiQcmRyF
 mEN5F4wigsGwqCBS3kIYleEH5auTDuejvMLPdWsQ1sNO9b/FdkN6l6ht7YZKfEm6Gc8yN6VWA08
 UPRgQ3oqMP3yupXLjdeUioR6n35z+dSWYmY35vt310Lud2r2GLn2MZF+YLx7cEIkDFkIT/8drP2
 p3Y81QJYNFOYeEvn1h/r6hCejeUfSg==

It's useful to be able to force a VMA to be copied on fork outside of the
parameters specified by vma_needs_copy(), which otherwise only copies page
tables if:

* The destination VMA has VM_UFFD_WP set
* The mapping is a PFN or mixed map
* The mapping is anonymous and forked in (i.e. vma->anon_vma is non-NULL)

Setting this flag implies that the page tables mapping the VMA are such
that simply re-faulting the VMA will not re-establish them in identical
form.

We introduce VM_COPY_ON_FORK to clearly identify which flags require this
behaviour, which currently is only VM_MAYBE_GUARD.

Any VMA flags which require this behaviour are inherently 'sticky', that
is, should we merge two VMAs together, this implies that the newly merged
VMA maps a range that requires page table copying on fork.

In order to implement this we must both introduce the concept of a 'sticky'
VMA flag and adjust the VMA merge logic accordingly, and also have VMA
merge still successfully succeed should one VMA have the flag set and
another not.

Note that we update the VMA expand logic to handle new VMA merging, as this
function is the one ultimately called by all instances of merging of new
VMAs.

This patch implements this, establishing VM_STICKY to contain all such
flags and VM_IGNORE_MERGE for those flags which should be ignored when
comparing adjacent VMA's flags for the purposes of merging.

As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
already had this behaviour, alongside VM_STICKY as sticky flags by
implication must not disallow merge.

We update the VMA userland tests to account for the changes and,
furthermore, in order to assert that the functionality is workingly
correctly, update the new VMA and existing VMA merging logic to consider
every permutation of the flag being set/not set in all VMAs being
considered for merge.

As a result of this change, VMAs with guard ranges will now not have their
merge behaviour impacted by doing so and can be freely merged with other
VMAs without VM_MAYBE_GUARD set.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 32 ++++++++++++
 mm/memory.c                      |  3 +-
 mm/vma.c                         | 22 ++++----
 tools/testing/vma/vma.c          | 89 ++++++++++++++++++++++++++++----
 tools/testing/vma/vma_internal.h | 32 ++++++++++++
 5 files changed, 156 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f963afa1b9de..a8811ba57150 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -522,6 +522,38 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
 
+/* Flags which should result in page tables being copied on fork. */
+#define VM_COPY_ON_FORK VM_MAYBE_GUARD
+
+/*
+ * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
+ * possesses it but the other does not, the merged VMA should nonetheless have
+ * applied to it:
+ *
+ * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
+ *                   metadata which should be unconditionally propagated upon
+ *                   fork. When merging two VMAs, we encapsulate this range in
+ *                   the merged VMA, so the flag should be 'sticky' as a result.
+ */
+#define VM_STICKY VM_COPY_ON_FORK
+
+/*
+ * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
+ * of these flags and the other not does not preclude a merge.
+ *
+ * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
+ *                dirty bit -- the caller should mark merged VMA as dirty. If
+ *                dirty bit won't be excluded from comparison, we increase
+ *                pressure on the memory system forcing the kernel to generate
+ *                new VMAs when old one could be extended instead.
+ *
+ *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
+ *                which should propagate to all VMAs, but the other does not,
+ *                the merge should still proceed with the merge logic applying
+ *                sticky flags to the final VMA.
+ */
+#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+
 /*
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
diff --git a/mm/memory.c b/mm/memory.c
index a2c79ee43d68..9528133e5147 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1478,8 +1478,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (src_vma->anon_vma)
 		return true;
 
-	/* Guard regions have momdified page tables that require copying. */
-	if (src_vma->vm_flags & VM_MAYBE_GUARD)
+	if (src_vma->vm_flags & VM_COPY_ON_FORK)
 		return true;
 
 	/*
diff --git a/mm/vma.c b/mm/vma.c
index 919d1fc63a52..50a6909c4be3 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -89,15 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 
 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
-	/*
-	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
-	 * match the flags but dirty bit -- the caller should mark
-	 * merged VMA as dirty. If dirty bit won't be excluded from
-	 * comparison, we increase pressure on the memory system forcing
-	 * the kernel to generate new VMAs when old one could be
-	 * extended instead.
-	 */
-	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
+	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
@@ -809,6 +801,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
+	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -901,11 +894,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (merge_right) {
 		vma_start_write(next);
 		vmg->target = next;
+		sticky_flags |= (next->vm_flags & VM_STICKY);
 	}
 
 	if (merge_left) {
 		vma_start_write(prev);
 		vmg->target = prev;
+		sticky_flags |= (prev->vm_flags & VM_STICKY);
 	}
 
 	if (merge_both) {
@@ -975,6 +970,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
+	vm_flags_set(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1125,6 +1121,10 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
+	vm_flags_t sticky_flags;
+
+	sticky_flags = vmg->vm_flags & VM_STICKY;
+	sticky_flags |= target->vm_flags & VM_STICKY;
 
 	VM_WARN_ON_VMG(!target, vmg);
 
@@ -1134,6 +1134,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (next && (target != next) && (vmg->end == next->vm_end)) {
 		int ret;
 
+		sticky_flags |= next->vm_flags & VM_STICKY;
 		remove_next = true;
 		/* This should already have been checked by this point. */
 		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
@@ -1160,6 +1161,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (commit_merge(vmg))
 		goto nomem;
 
+	vm_flags_set(target, sticky_flags);
 	return 0;
 
 nomem:
@@ -1903,7 +1905,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 	return a->vm_end == b->vm_start &&
 		mpol_equal(vma_policy(a), vma_policy(b)) &&
 		a->vm_file == b->vm_file &&
-		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
+		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
 		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
 }
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 656e1c75b711..ee9d3547c421 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -48,6 +48,8 @@ static struct anon_vma dummy_anon_vma;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+#define IS_SET(_val, _flags) ((_val & _flags) == _flags)
+
 static struct task_struct __current;
 
 struct task_struct *get_current(void)
@@ -441,7 +443,7 @@ static bool test_simple_shrink(void)
 	return true;
 }
 
-static bool test_merge_new(void)
+static bool __test_merge_new(bool is_sticky, bool a_is_sticky, bool b_is_sticky, bool c_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
@@ -469,23 +471,32 @@ static bool test_merge_new(void)
 	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
 	bool merged;
 
+	if (is_sticky)
+		vm_flags |= VM_STICKY;
+
 	/*
 	 * 0123456789abc
 	 * AA B       CC
 	 */
 	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, vm_flags);
 	ASSERT_NE(vma_a, NULL);
+	if (a_is_sticky)
+		vm_flags_set(vma_a, VM_STICKY);
 	/* We give each VMA a single avc so we can test anon_vma duplication. */
 	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
 
 	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vm_flags);
 	ASSERT_NE(vma_b, NULL);
+	if (b_is_sticky)
+		vm_flags_set(vma_b, VM_STICKY);
 	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
 
 	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, vm_flags);
 	ASSERT_NE(vma_c, NULL);
+	if (c_is_sticky)
+		vm_flags_set(vma_c, VM_STICKY);
 	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
 	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
 
@@ -520,6 +531,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky || b_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to PREVIOUS VMA.
@@ -537,6 +550,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -556,6 +571,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 3);
+	if (is_sticky) /* D uses is_sticky. */
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -574,6 +591,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || a_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge to NEXT VMA.
@@ -592,6 +611,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Merge BOTH sides.
@@ -609,6 +630,8 @@ static bool test_merge_new(void)
 	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 1);
+	if (is_sticky || a_is_sticky || c_is_sticky)
+		ASSERT_TRUE(IS_SET(vma->vm_flags, VM_STICKY));
 
 	/*
 	 * Final state.
@@ -637,6 +660,20 @@ static bool test_merge_new(void)
 	return true;
 }
 
+static bool test_merge_new(void)
+{
+	int i, j, k, l;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				for (l = 0; l < 2; l++)
+					ASSERT_TRUE(__test_merge_new(i, j, k, l));
+
+	return true;
+}
+
 static bool test_vma_merge_special_flags(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
@@ -973,9 +1010,11 @@ static bool test_vma_merge_new_with_close(void)
 	return true;
 }
 
-static bool test_merge_existing(void)
+static bool __test_merge_existing(bool prev_is_sticky, bool middle_is_sticky, bool next_is_sticky)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	vm_flags_t prev_flags = vm_flags;
+	vm_flags_t next_flags = vm_flags;
 	struct mm_struct mm = {};
 	VMA_ITERATOR(vmi, &mm, 0);
 	struct vm_area_struct *vma, *vma_prev, *vma_next;
@@ -988,6 +1027,13 @@ static bool test_merge_existing(void)
 	};
 	struct anon_vma_chain avc = {};
 
+	if (prev_is_sticky)
+		prev_flags |= VM_STICKY;
+	if (middle_is_sticky)
+		vm_flags |= VM_STICKY;
+	if (next_is_sticky)
+		next_flags |= VM_STICKY;
+
 	/*
 	 * Merge right case - partial span.
 	 *
@@ -1000,7 +1046,7 @@ static bool test_merge_existing(void)
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1018,6 +1064,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 2);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1033,7 +1081,7 @@ static bool test_merge_existing(void)
 	 *   NNNNNNN
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, next_flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, vm_flags, &dummy_anon_vma);
 	vmg.middle = vma;
@@ -1046,6 +1094,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_next));
 	ASSERT_EQ(mm.map_count, 1);
+	if (middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_next->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1060,7 +1110,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPV
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
@@ -1080,6 +1130,8 @@ static bool test_merge_existing(void)
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_TRUE(vma_write_started(vma));
 	ASSERT_EQ(mm.map_count, 2);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
@@ -1094,7 +1146,7 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
@@ -1109,6 +1161,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted vma. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1123,10 +1177,10 @@ static bool test_merge_existing(void)
 	 * 0123456789
 	 * PPPPPPPPPP
 	 */
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, next_flags);
 	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, vm_flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1139,6 +1193,8 @@ static bool test_merge_existing(void)
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(vma_write_started(vma_prev));
 	ASSERT_EQ(mm.map_count, 1);
+	if (prev_is_sticky || middle_is_sticky || next_is_sticky)
+		ASSERT_TRUE(IS_SET(vma_prev->vm_flags, VM_STICKY));
 
 	/* Clear down and reset. We should have deleted prev and next. */
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
@@ -1158,9 +1214,9 @@ static bool test_merge_existing(void)
 	 * PPPVVVVVNNN
 	 */
 
-	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, vm_flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, prev_flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, vm_flags);
-	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, vm_flags);
+	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, next_flags);
 
 	vmg_set_range(&vmg, 0x4000, 0x5000, 4, vm_flags);
 	vmg.prev = vma;
@@ -1203,6 +1259,19 @@ static bool test_merge_existing(void)
 	return true;
 }
 
+static bool test_merge_existing(void)
+{
+	int i, j, k;
+
+	/* Generate every possible permutation of sticky flags. */
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < 2; j++)
+			for (k = 0; k < 2; k++)
+				ASSERT_TRUE(__test_merge_existing(i, j, k));
+
+	return true;
+}
+
 static bool test_anon_vma_non_mergeable(void)
 {
 	vm_flags_t vm_flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index e40c93edc5a7..3d9cb3a9411a 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -117,6 +117,38 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_SEALED	VM_NONE
 #endif
 
+/* Flags which should result in page tables being copied on fork. */
+#define VM_COPY_ON_FORK VM_MAYBE_GUARD
+
+/*
+ * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
+ * possesses it but the other does not, the merged VMA should nonetheless have
+ * applied to it:
+ *
+ * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
+ *                   metadata which should be unconditionally propagated upon
+ *                   fork. When merging two VMAs, we encapsulate this range in
+ *                   the merged VMA, so the flag should be 'sticky' as a result.
+ */
+#define VM_STICKY VM_COPY_ON_FORK
+
+/*
+ * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
+ * of these flags and the other not does not preclude a merge.
+ *
+ * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
+ *                dirty bit -- the caller should mark merged VMA as dirty. If
+ *                dirty bit won't be excluded from comparison, we increase
+ *                pressure on the memory system forcing the kernel to generate
+ *                new VMAs when old one could be extended instead.
+ *
+ *    VM_STICKY - If one VMA has flags which must be 'sticky', that is ones
+ *                which should propagate to all VMAs, but the other does not,
+ *                the merge should still proceed with the merge logic applying
+ *                sticky flags to the final VMA.
+ */
+#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
+
 #define FIRST_USER_ADDRESS	0UL
 #define USER_PGTABLES_CEILING	0UL
 
-- 
2.51.0


