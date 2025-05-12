Return-Path: <linux-fsdevel+bounces-48738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CECBAB35EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCDC189D389
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258728E61B;
	Mon, 12 May 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ukgq1d51";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M425nMX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF011AAE17;
	Mon, 12 May 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747049523; cv=fail; b=NJAOiacy+XJmtrjHdLm+ULVrzjao1OrFsjS/1zYhaN/jir3JTG2JCTvXEr1hIkBrrlp4+1/N6P+W4lU4yrJhLRmOC59VZ2mAAvoA3oQtcs3zjUnIkJKT+FB2MXu6CAh+0NejWfXbsTYqmD5Z8JLGif4Na8326g/RGy1anzT/MNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747049523; c=relaxed/simple;
	bh=de7XWRe4QHY0XHSO+EbJDWW9mYgAJSiImFkJw/pE7aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O8Kj72Y8XPRb4XjO5Dba6gKjoqaRVmYnBdaFiMG9eK0ez15969nKNRjb23Zix5quay71uOwC69OwPOtIGrqtUHWpn6Vf1hGWz2oykYGzjwXtq0N1iBjjzU+bv6IcUtaTQ2cC032BR8irU67Af9wiWn4YFfRhiuyqJM4LtkFabcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ukgq1d51; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M425nMX6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C7fsRo027431;
	Mon, 12 May 2025 11:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wyfm3dKv05udckMNfo
	NFe/RHc0xwLODEwosKg83h0FA=; b=Ukgq1d51qiOpnU67KaNah573EfumqOakoK
	aoWcwbkcT0h7K8iSOggHO1Y6EB3iY6BBTRUl29fAQtSKI/TqE/QD/tMR6LDDePpf
	tVnucNF77C95S/UhUhma5LA4xD+EqZR6ykbEr0LUaL4oieUZF6kKxRPTzfcib7aH
	xpWFtELY66UYfVlztG+hxjzmU3xi4ZSgzi9G41OaRPAXWLIVUN44ExBHOn12ynvR
	zISwYico1zLAF/solJ0CmP8eGLMUWitgTuYIppCTQhsJIapOM+fob5n4cd/mUDdk
	rSZSKiMH/ijblS8tkgdpUsOX6z1/GOWmiGDFr5B9hBtLf80bY0uA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r281n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 11:31:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CBKqj6022348;
	Mon, 12 May 2025 11:31:39 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010003.outbound.protection.outlook.com [40.93.11.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw888w2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 11:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9uLTZDi8JA5VDaXvbB/0vpGwlRGzqQiMkGrpB2WFOV/roVlS1DAB0OWcMGu0XcYV6cgHGHeIR+QtHISduXyYJWbCz7rM6p+yGMqr04wJcQEc5+lx9f5NQQ+Zsn/fgttKLFoIl26P83t+Ki3Ni4rmpgSXHGHljg40QMzh2w1gDR+oY+JGz+tYSqgqMasRqRVyD3ojvA7O46sOPn2X8yrAIFkMlKrSGD0PnUPbkAHmTtKERqsYRUXwzxyizjZEn3QY5bp9A1IWLsFf+JZ5P/TT6CI2Js1giby4syUAwUK6h6qpvTlGlxlDDIaSJpNpCpy5oybW9hUtS70uxo6X72A2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyfm3dKv05udckMNfoNFe/RHc0xwLODEwosKg83h0FA=;
 b=rAI/mFYSqr8yBR/DY0H0JU12MbOyBQ0GrkjSv7WXfD+ZEB6/1CYhhQZjpVKunPVE+f3kIwihA78533BrUSHazoKSemtgWX+5vbQ0qAUyvTkS8/WTgLe89WoM8/w3/kNJpkwv0bgB5IOmy5LMiTBT2+JBiO6CpSlADnGxD2tk4RBXQXLeQFZkjRxTlD/6or16PhUAsMJHPuwU2Fzb4dbDPb0EFUoM5ZikN39EhAhjuuHWi3xIepTJ5tY9ljpC3AqimfuMC3DkRBMAjcXFROv2+OTmR3dlalVgEmYN7dl8ErIisfpcXtOjYDUTs7V9j2PLJ4ZDZRDqFDa2OK+FKdVCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyfm3dKv05udckMNfoNFe/RHc0xwLODEwosKg83h0FA=;
 b=M425nMX6v4WCH5QAWF0ay/TcZ3pRbcZ2wWHTcF7v4wxLZnb6H7X7dIn52v1+CvucLY6lYUPVML2y4gUAIdF1YyEboTijYcrhO/Z4jVjtY8BLYPwg7JaewVXz+mMNKUrjY5zQp7STpWCzwM2sUl7VE7eT4pvjC0as+8Q+rJ5Pnqc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB7365.namprd10.prod.outlook.com (2603:10b6:930:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 11:31:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Mon, 12 May 2025
 11:31:36 +0000
Date: Mon, 12 May 2025 12:31:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <b33f05e8-9c5b-4be0-977d-005ca525d1db@lucifer.local>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
 <20250512-starren-dannen-12f66d67b4f6@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512-starren-dannen-12f66d67b4f6@brauner>
X-ClientProxiedBy: LO4P265CA0289.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: b13d6bb3-55cc-4fb8-ae5e-08dd91488df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHO+GuWDp1BsUa3LfhgwpKHzXIkz0rkBr8IBzhB9TvXAcIL2RFY3EL9jqHMk?=
 =?us-ascii?Q?K3aI/Gp3moZUkb43Vq3TxV/M1LDnD1km21BAVNUEmgvd1ceBcla8sHFoYTCu?=
 =?us-ascii?Q?cWU1bQ2cnEPEk5IqjD8cUKpMLoWQ+YEIEgv0GqyO8fBJSTLpCfi43PPPRWNg?=
 =?us-ascii?Q?TEGn21Rd68SoVlQMgUxQT/umhbcy+Nw40YcnJHwwPNuzunmFV4NUP3VS541a?=
 =?us-ascii?Q?/m9vrt8U+gp1UAFWdevID5gD37e4pagnLuCzYWLu3iWo+MizJ00r+qrPB7P0?=
 =?us-ascii?Q?bmTHwiQz9W0Sq0umu1rR0uOd5NnadPvrOmBK8yjrZLP5haVLg5l8gnvUkn9X?=
 =?us-ascii?Q?IF1z7MGoHbfzG83dDrDdXu3YIBe7yapqtMUIu1hCADc0gPNRcYJ3vY+Hpgoo?=
 =?us-ascii?Q?aFATaIYhu0XieszQN2Ps/aFic7cVY1Tt+4QshcYgny8llpGG770IdE7sNveK?=
 =?us-ascii?Q?hCKv8jgGeqSFHoQNaGRdZuF0pjYmT/omKtIH5TmtoO5W70CHAO7rDje0bjVb?=
 =?us-ascii?Q?ynWLbQQi7I6WX0sh5rT+k8+Zk1juzULb0Bx3I/E+ax9feBbCFvhlg8ZhfDjO?=
 =?us-ascii?Q?Qy2FVMqJaV0oQOYkjcFa738J0JQx/2oiX31tzSYa7SY9QgZ6x5aALRfZmzeg?=
 =?us-ascii?Q?vXUfqaPkgoGvv8Ux7ySwPS8oSNmZ0/AP1UwKfRr7U7d8LedgT30HHCYD37yK?=
 =?us-ascii?Q?K7S8T288VE1Gfuq7sgYNv4kVUjCyWw4GfJUnud6NDpy8Vn75FQCMNM5155Bm?=
 =?us-ascii?Q?4gazMsWT5CPoULtE2ln6MsRVUjijlB3KFYA/A4WJmqQYJabG3nGyhflbcHfO?=
 =?us-ascii?Q?Ypm7OP7d9ElHOEnVJoQyRhdioq6bmsBgunnnz/GVEDgnvzr4iuIxSzTgf8KM?=
 =?us-ascii?Q?/zDoIGIu+phEiFxjTWXGKQxFbyrGPeqoGN5ai5c+cwi5F7e5SWu+idHz64jV?=
 =?us-ascii?Q?tiRPmPXHceYTeo08UgZuyRQdCgetrSZLYcuVTKpZOQpL9cBP4iYIMFx24EzY?=
 =?us-ascii?Q?NOmhsgtPFNTZ8UaTG8Qy/n/BRB3SGYGsylomk96CcjMj6XSC9L9eQ2Sm2r4V?=
 =?us-ascii?Q?GgihA991OaJQs+27L4R7RALTPqWgAnQDjTMyFTi/T6uzNg+mi3CAc0ye/DDv?=
 =?us-ascii?Q?eEY43HrIm/L+NaNQzyJmwGopKyWhqaUPMHxs9RXpDrYsF9AKeiup9iA2mXA8?=
 =?us-ascii?Q?ktKSG0YSh5WRRXJe0bo3fyL9y/IpsbkGMaSYwAVaUTTfjkOmmOpf0vsm1HsT?=
 =?us-ascii?Q?iSE5Wit7TMXGT/k18t8vuQPLI29cUSMZDX0huM4IG5D4yLfb/VeK2DDYVef5?=
 =?us-ascii?Q?Ah5qeFf/wMLRJAX2iB0xVsEzzebTt9bRdsMT/i5dZyUgJa8kcPs9/wF6PV9q?=
 =?us-ascii?Q?lo6s0ElopjkYrcQ2Nq8ZPuP5KSvIQz9xNUFTnhSFfyqQxkSHJ3zcSHkAxsA4?=
 =?us-ascii?Q?/7+PL7Zuffo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5mzLYt+taHBvOmSPumXQ3xdt0dpV4oH0Qo7y1q/Spis4qASazu6GUseG16P?=
 =?us-ascii?Q?u1TOx1IFfSKJC4x71CcjSLNJ7yVDEn5oDALeuNsEIiSw0R+GzoYguxWcdktJ?=
 =?us-ascii?Q?N1ANbKNqzKc+TgbKuoHcf0jD/IWsWX3sY+MYLCW4+s+1qg6jLBbdDnDgnO3N?=
 =?us-ascii?Q?Z+7w30zZU6s7G/8Vw0uxxvsXZ8BHaEwOQ7ALumc7zJ+wJ3tLn/Vspf70wb77?=
 =?us-ascii?Q?lGKSUTXEYrmAvOthOdGUpLvYEcx/ZuvSmu2ScwqvVMQoyKQs3qGEVSBVJCGl?=
 =?us-ascii?Q?kmBlZWRufdHR8CHviaRem4PLXaKA7Phcht95ZpoyHbDAORrtk2Iux2eXUSWE?=
 =?us-ascii?Q?hGW53nM3hlj3/unaiWh625buMS7xTbjEfrzmFDlM0W1Tjrxev6wJiRDNbHIl?=
 =?us-ascii?Q?riNOxVZJtw/0aJuuFD+6wOBFWvnmz1ShZz9DrJY0yHM6YVGZ1GHQAGS7dRrE?=
 =?us-ascii?Q?jgd91g9+WgJ3nHdOdHKOqM7zKtR2gc7pSNU/avfc88siwW/GWQ/yQGEOyd2T?=
 =?us-ascii?Q?fn+7mn4TxnJmX/LE/Z22fTymXN5eZX2bJDyF5+AyVs5yXDNvoOaN0XWu+tof?=
 =?us-ascii?Q?CcvEbgiK0iCXakVlt/1gWv91H+PNHaC6U/j44Qn9+jvIHZC4nkXr385wHlU4?=
 =?us-ascii?Q?cEKWF9A7YgzTUqigdm5YzCu/O/6rcekk9daphpnPREjq0cVHSxcFLoLPgfzS?=
 =?us-ascii?Q?UCJL0KNQOi1G7pgaE9xhC1qOvwTdmtdD2lz8eF7k8RTyRN+paoe1xi56U+Lw?=
 =?us-ascii?Q?RE25/KKROiIfMQSVORTTj1Kx+Bwd1DZ1CbNL6dNDdXPO6sN14pijiRZ6bHNY?=
 =?us-ascii?Q?9YnA1AOotsTRkjRkGxkiRHSjdLrwtiE7lEHELMlowh+hakUB1uuHfe+w0BBQ?=
 =?us-ascii?Q?8v6nrrEeqRlo+IsDuVIqxjDsqVYsCFWDdhTYnzkpbapwyoVa1UsIyk4J6cu8?=
 =?us-ascii?Q?/ySC2B6TVx7DoerC0eOUJG1mkOwzI7ZbE87oam4Ig/IfoqTN+YZnff+580Rs?=
 =?us-ascii?Q?f5wOVxPDSzazTq1CYW97qAnHwBw4QMAgdyWH0R5p0cdw0w0pb+r1GAQzEu1H?=
 =?us-ascii?Q?uKF0OY/BD51dZ4b8LuJGOG/UFLaBLOEL/WS53wzl1cA/qoeJ/+Wss/t8WKgY?=
 =?us-ascii?Q?Ec3zb4Gr+/gOBlzk6VkIDCpTg2zFuDnmBaxsSvKcmTCyHFHVq2WoMD9HMl5/?=
 =?us-ascii?Q?lGybzNdNCvN1DaCLxoCzjeWt0/tcyDoem3AFoJmCZpm/Z1G8ohauBa0KkBjz?=
 =?us-ascii?Q?DdOgW4WBXWQ3nW2LVWs3F8xVMiUgQpWvawSqGTH/o2ty1aNqzfZO7q0B356w?=
 =?us-ascii?Q?aBpGx15pMWOzCHAjKUDIUopl9uJlzhCFOYBUeKQJXOX83pUi1WcFTvYQzmXO?=
 =?us-ascii?Q?d7aV1eE6tqgzFMUS2FeJnm1zpNFrlGz0LLQIrTx6lBdWR6uzH8HzpA1PnlhH?=
 =?us-ascii?Q?23Ys9wuJZEu37ln5IzR/VMuHD8wfZpnOyOu6pHN32nU3pw8H+35/HrPeZG8I?=
 =?us-ascii?Q?KDtuntXG4Q9W/S8haEdT6Ty5wrej9zI5mfJ7aYXlyHSE7JmRudEuma2BWHC3?=
 =?us-ascii?Q?CboPK/kPiAf+UoeqRYbeWhg3eMuiOcvVEzanuPBPpEbff3kjhbxSzosg6FMn?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KrW0fbp3UOUj726P3iEFOkQk9ylYab5Nok5OMNKevwR0WeipdmIos/6+xUzmvALsDaERBZa+JW5w+Q+r65LtyGxssmlUiFB+v8ZuklILbTPJFOgxQlDxkmnuG1RTVxIGdO9wLZywOL2P51LG3CeGLGFHjgs+5YVQcroM9W9HoZqB6eQyLbJVQgvs2mu4+DApBiuZ+9oeitRKUUQ4uWKKHS8VuANaPJguNVlkLMm44Yc9N7kkAFgS8y5RmOSa6wIqfRHFEzSzgggrQTIuTEHnJiEIPDVGd1QoqT8f22W34a9CRVyfxKxHxYm4Cgbpo9+jxjxSGW9A6Mtz/FYSKp8cjtIVL2CbNLn71jbeO9Rwaf7bvnZjn0NRaQp/E+VLQxhVRDXsPm1QYfFk/krFu0gR+O+o+aWd9zKlaQsCMzdr+7EAmiO/WwXxgYxEX1dX7WkV+mhFHVapMFIrWW0jQN0g2xrSaADLeicZS1Zxx+o3G5OZY3nCMEl01Xi+VPL5HdRlUC3bZ8iaR1LVVIgMigsnWdcTpdy2bc6K+p4Uni2jzXqAVmib4s0Y1vBrRM7xUEz7sfxcTZOJdr0oV1xk+tzZ1fl8l74HHceaQKTNz86ygpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13d6bb3-55cc-4fb8-ae5e-08dd91488df6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 11:31:36.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SzNyAhcXz7fMTKDl4qrO23BM7OJpoyg5gFuhfFtJ9RbYuh82UM7w0xM35L+P1Ghosj8SrEuI+FKl1M4RhJccNEWsxZgLn6/CeheCTsD48o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_04,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEyMSBTYWx0ZWRfX7QgOp+CXwWYR YLxCFKLm/bQJc2WeCNSBEVLE7q7Sxi2iHIXLlyjIdediIk0D5GIcOJH9MatM3crGzlEbtyrzJ2J 2CkPvX+ft3tv/9NUEoprIe2urlcaqWvCZYlSadLKbnc6d0NRdqKpgLbWeJxKWni6pf9oU44LgrE
 89FHgRRNNR1lcfNgaKQz/Q7mwI8aW4K54MuK5yRpYNbc1FxINEbCQFPdfIj4350HET3JFUUOW5U bNPABMMr2w9vpT6kqvDP81rzMaQSNFpuXJKyUH1Q9GDyC+Di/gtlrEaURU4YMzkUHcwUKwiiUn1 6Ysqw0W5jh8p3J3H1Y+LObKBi4YXiopJDP47BkHa3tA5y619NvEb8v37BGwSahu5kRz/XuwmRP7
 gTVlVPz1UOqqX6ilhWEysdPC3pRO8e/1CDGShSdGcsFFt2VHVWdtB8Hq0Oy2bBpXHFYSZCot
X-Proofpoint-GUID: 9LXorAyEdfzVXTp9WqBtsUafDET9d2FA
X-Proofpoint-ORIG-GUID: 9LXorAyEdfzVXTp9WqBtsUafDET9d2FA
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=6821dc1b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=YmHLT29RruF6RFQuJccA:9 a=CjuIK1q_8ugA:10

On Mon, May 12, 2025 at 11:24:06AM +0200, Christian Brauner wrote:
> On Fri, May 09, 2025 at 01:13:34PM +0100, Lorenzo Stoakes wrote:

[snip]

> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 016b0fe1536e..e2721a1ff13d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h

[snip]

> >  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > +	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> > +		return -EINVAL;
> > +
> >  	return file->f_op->mmap(file, vma);
> >  }
> >
> > +static inline int __call_mmap_prepare(struct file *file,
> > +		struct vm_area_desc *desc)
> > +{
> > +	return file->f_op->mmap_prepare(desc);
> > +}
>
> nit: I would prefer if we could rename this to vfs_mmap() and
> vfs_mmap_prepare() as this is in line with all the other vfs related
> helpers we expose.
>

Happy to do it, but:

call_mmap() is already invoked in a bunch of places, so kinda falls outside this
series (+ would touch a bunch of unrelated files), would you mind if I sent that
separately?

Thanks!

[snip]

