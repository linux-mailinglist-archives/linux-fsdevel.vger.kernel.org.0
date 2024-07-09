Return-Path: <linux-fsdevel+bounces-23395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 874F992BAC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054A31F22B35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F06158A36;
	Tue,  9 Jul 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lJ+IvXX0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LkRGs+DW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3212DDAE;
	Tue,  9 Jul 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530803; cv=fail; b=TofO2nP8/PkABu5LdL9yUVUmIKobkridNT/cnnQHBWxWJNJ+Jn+0cW+5oGwcMozjQSvj2p80BERr9RnosrCTnPIVuJzn1WL1HCjT8dI3tQWyTgYupt0rW5fn+TXXEgtRjGUbBg61USOVWBOtfWQWgyr3shV5P49BgR9tDqeG3Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530803; c=relaxed/simple;
	bh=mINZ5fThvD29Ak/HyZNxP17bftxYKalI1phMr3PtWIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5TeofSeS+DIZ7ptYDIEY/pZIO8Rx1QVHALtgwcxwoFb+wqpK+yYjUiYLUyGttr9WoVE68SeHyYNVRmuRH8Vxo8JQusUxt+u+Zy17wjRxr+1RkT3549Xka4ohuaj/zkEarqL68H6O1ej2th+w1RBhbSet6odQTN4swDj1NQqTzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lJ+IvXX0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LkRGs+DW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT4EF021037;
	Tue, 9 Jul 2024 13:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=q7KZ/tnpEQRTvsu
	B+ZcP7R47ByXjIusgo3xbvRDG3oA=; b=lJ+IvXX05dGECpZLo4KQpTfWKUjwEgv
	Q8f3DzjrKN+tFqYIEbFPZpbB7Nzhl3/Bjk1mFrsNIWBkcBcrMLHHCeNfe/5ZeSMN
	bMvA82O/tre4hHtlzYQP/7i2390qfDzmByKf9cw0q4ofingKAWsJGREAW/dDMcKH
	yCIzlQmtBRCDD7FbbRb/z/NL4WHDaM08X0M7eCnUleF4vmYf4IqMoyN1JQKy51ok
	vfuL2CGE3LKmXBp29AjW03Rm2THByTnvhI9i07kFKhDLZ0l6eODr/r6bQD+6pTCh
	ZN30SOqKUP9Cph4QRq2nJm9DrjY7dlQO6Vy/fTM/9P/fY6DXrb5gMKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgpvvt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:13:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469Bu978013658;
	Tue, 9 Jul 2024 13:13:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txgxbp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eELTwIT0fZX0vuWqIOylBW1lNTt5rFem/PdS52wTfyhcJoPn0fkyD2RzhxmCPjS7uuXQe1jFqWz3S2IQ+TAtpspgJQzN4QbWat6FiPq+W7GPw5gtXDLb1XwFjHYRNeU0mB6oub0mqYBOno5z9lFA4KFl8jhMxrANLUSPC61NKt5vHe9wh5eQ8nL5GMY4YEVnjf+WbQFH9nsAlGGTEKER/cij9AdxiDa0Q7s5L1Wug5dnDDYKZlP6ZxbSqgoKO+/2ilb0dHzpDCasLh2boePDzzZqDxzI2lw8WtOiJiw9jkRFJsnTN8Dxm9kq+dMH59+1a+qUXXJs4HwFou//P99nEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7KZ/tnpEQRTvsuB+ZcP7R47ByXjIusgo3xbvRDG3oA=;
 b=m2PrVZJcQPCPHvheNoWz+BDntJH47sSEu7UBmQ6Xmb5SHiWyPjPrA24u79vONMjezSPpBUpJ95CTdY57MxSmsS2AX0d5VF8dmfpf4Csg1L+UL3i4hrS4yg5z/d77udUF9Jf1j4DcYTtifeHiT8O+cucwmffktJ2ti0V1OsSOy94ESfi382P+SQlkAU/Ed3FNmfETAKlnJvcDbJwMhViFw+KNXDs1zAJ6EUs3o+sYEmRWtEAI4Kj4A6mRB+VKpfgpDcRCy4l6jWfD//CY0ia+sYzCpvMJg5ImK+5qsNOk3dEoD+ivXsUOxuupJ/Ofj3lS8U8Ufgqx3sWLamXW4QcZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7KZ/tnpEQRTvsuB+ZcP7R47ByXjIusgo3xbvRDG3oA=;
 b=LkRGs+DWTDujytmd2gGnvR+sYcqeeJWrw9HRBmp/TeXpfePDYbn28v0Z91eTg3hG9/0aBPA8I0JySOcLntpNTEjc/5JuQa7aTKTMwIMe+mCaFr90cazKhEHnFhTTHV7gdKtFj78DO8Jb5tHqO4ZJaNO6Yu35YZqWGUajUqd3IrQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:13:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:13:03 +0000
Date: Tue, 9 Jul 2024 09:13:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 5/7] MAINTAINERS: Add entry for new VMA files
Message-ID: <64e2xsikig3vr5ayd6pkhcek7baazmebft62lgcrwdc3je7xyf@mdh7dcafgcds>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <c21f13e43a4bba058f25073a2d89ac1ec5490fcb.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21f13e43a4bba058f25073a2d89ac1ec5490fcb.1720121068.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:610:38::31) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ffefef-ff1d-42a9-97f2-08dca018dd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0ZYDpnCQou4C02dBT+6NWf1RjPPXLG+eCLOb3EFFllyIhKA3prGhTY3BgCoY?=
 =?us-ascii?Q?olYwqwUpqlQo3dOV/GiFeLf1jRW6jwptQ09QeMscU4QCvpFJpulhRFg+MNHG?=
 =?us-ascii?Q?/jZglSVV8D4NK92wNduL7vDmfu/194jAh9I35ye0pqpoiBbWxd3TF8Lnrve6?=
 =?us-ascii?Q?q1ytbYTC7ofj8dOnK57AFzbmzAkTmr9gv6TXN01SupSHIAN0c/D4cSlJ+Hpq?=
 =?us-ascii?Q?7OcB+LGZvObD3i0k8xxzCB5ysnG9VIzQOXLG6nSf/ssFSMo6GmHEupXi2aum?=
 =?us-ascii?Q?giAbDSZvJVOtO4qi18MZjoKhYUx15w0VYFE0Qj8ULpszTTiNtbjfBM36npJo?=
 =?us-ascii?Q?nO3k1Yo+lpt8WiFxrLzlv/EwWa4IxVqYR66ytBRqi+XlPRBBomgy+erB6uUt?=
 =?us-ascii?Q?ECeJ7FNECbM4oLA8l46lmdGluBlMBumdePXF4B74viVFfzi+zVjHjIzGzA3v?=
 =?us-ascii?Q?fy/cacOl0mNTHXO/giOTmVygw0x9f6F1VEoAfD3D5mIpT+plu9a4H4+p64AT?=
 =?us-ascii?Q?Jg7/gMyaezX/QUT1m9B8Dx+d6E98+5pxX/IKbsn9qdhUMqHu1RFFfshljXgT?=
 =?us-ascii?Q?IqWBKu3sKL9Fffo7t6PeMVP5LXz99nYbBXexF+hR0rp+1YT1LxWpgl3SKz+e?=
 =?us-ascii?Q?S4hgmTILCfof/RDphcD1B23r6bGzBTWwwPpa5VzePSu/7O6sdNhLSfJwGxrP?=
 =?us-ascii?Q?eiSgJJrjbFR0/wZPMVNlFF9NRrizrAd2Rhyvo0mL/Xsf9Wc3e9sYAk/iLLu2?=
 =?us-ascii?Q?M2D1Qbb3DnBMGio4i0qmuJ1ZMWPbXaCMp822TZbmde4GNuDJT4ifQGXMh+gK?=
 =?us-ascii?Q?att9QnT0xj16sv8DVH08a3qLGPZw1yseZFXYUSz9C8j2hfcT4ddK9Uq0qUUU?=
 =?us-ascii?Q?0kHMptVlr2vDCLcnjWQ/OUUgzhFUBnhgMxgudXR80WMnjQOwfBjIfwSB0tHU?=
 =?us-ascii?Q?jgbvDYDOFV5HhtQDAEvHy9RPJiTfXXneZmSiw791JHQCZurfhgdRjljOutK6?=
 =?us-ascii?Q?DnYDDjCCt3x1ZUHynhhS5w0LjLfkfDfMMXU8L1PaD0BJWivwNzoxW62jqMOl?=
 =?us-ascii?Q?s11GFAB/yNxALd8vqqkTqIE6wqdGtuiOD4a0HwMyXHg39ByePSwWDlLs35fZ?=
 =?us-ascii?Q?yaNnWN27AXDb4iL/9VzgjhUOBE0pNYo9n0PW/uD1RyLhFbaRESvafubiuoNK?=
 =?us-ascii?Q?aoz2fL/rjQC9SwzIjJvOqMCQHDRLkjnVQGSKPZLFXT/qNX+QPA5a/XN8KtmE?=
 =?us-ascii?Q?gB7Nin6J2KXkkU7lDfMu67hj3jCEmlZ30eog+GWx9plcvmOfiGPZ1dKmM9/L?=
 =?us-ascii?Q?9xQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?h0NB/BCtJh4ZxoerHS4SngsbP8gcKapYtw17XSD8DRBV8vPYwjArBjToBjNu?=
 =?us-ascii?Q?8R2PcgfVQ4j644gS9FIq3ay2MurCw/Fxss5SoV7HD6xGsiElbWnmw388MzFQ?=
 =?us-ascii?Q?H92CXQCLYeBnLOY6XN/rk8rBDzDPqeMzizSBWcEvN+I5xBLDhC+kZg0/GV93?=
 =?us-ascii?Q?NQ2wWESiDzepNejbs8UnwF90ROkk0NEkaDmDczsgNlh6FkgNE35bhJiXI7XA?=
 =?us-ascii?Q?BaRvP6AhLOdigb1GHgPiP30nGCzGxvJ34MEoay2awQLVU2AfVTvqK4XSVGRR?=
 =?us-ascii?Q?7+2FH8Z5YbqjgF1ZEGLxdslsmT9PPyh66baTseQ4mcw9+26Ji/ZC4qWtPSnu?=
 =?us-ascii?Q?ku3pFIYF9uT2U9ic7UibSs1vI+YkTKj6ZlEGDj82PKBqpFEsRZsvC6RnZi9E?=
 =?us-ascii?Q?4x2rprJwhqZ5JufuLYRWbsHpK+Dcjv0y2P375jAjMqD1PNeKo8kfhaP+g+ez?=
 =?us-ascii?Q?cXub++f2KUXRuuZOBV3pYzRyY3b4Linqv62PcBDc0MFA20kjFsoir7ndZeIi?=
 =?us-ascii?Q?jXcyg+qatHij529qJdwjNl3qKGI/hwOLpNIGtI9SAqIL0P+n5NHnVQ3MhVbS?=
 =?us-ascii?Q?abDYH6YZ1ACa27RL8jpGh0uKafoqnDXY2g57hvnSvIbNCUxG+p4YrLDhXnTG?=
 =?us-ascii?Q?2TOS1qaXSRuLh2cNV4nfRTTBNysTfFKDOaUCekFuWycqUM2aigEzJ9szhlMi?=
 =?us-ascii?Q?tk2Jsfo3AIxSSWYOAzqTafK1Oeul3sXjV5QOKKJjyT6zwl5FG1MLAZiAzfqY?=
 =?us-ascii?Q?ltdBiumv1Klcc4kXhtdHrwh6NAxm0f7h/ib3hgA/3LaoLRAhnSvco+EWEuaj?=
 =?us-ascii?Q?A7Oiax35nPNV7GXZCNW7cauKhq6Lp1ZR7ltCHg+soMzpFys1m3FrA3xcQPvg?=
 =?us-ascii?Q?FQiefbZbUFV/E/ar+sI4FlC7STMyn2xeHIQ+I6BFVPRVEp+GeOq9y5IsJjQJ?=
 =?us-ascii?Q?KdXzuTs4lzWAsBnorrBAbUd2bv5//kh0Qu4iXwa0LuT12YAbfLzMAzmvVVEB?=
 =?us-ascii?Q?pL0GNZJwJ/LI8hjnQXoPB2KgCFsokSav0jXo14bwwDt1Jna+C26PWjBdTaII?=
 =?us-ascii?Q?nAy5BJANdzj/Id2aItUcdbjsEwesVggZNy50Dbo5nQQTPZTkAT2ZErNCcI4O?=
 =?us-ascii?Q?T9AOGvLeplFgECoK4DdVbXR7x78P0/ftRaTkqutdHfYlur58gaBqJDkTQmyi?=
 =?us-ascii?Q?eU/bIH0wE+vF7nB/T12dGX01b0M0vPnL87KWOsoc5ReozAwRihUzIHkA13gH?=
 =?us-ascii?Q?FqNyPfm0mVTXUlaqnB8yIUJjo84Au42CxJ+5z8z8qsgm9Xl9NbWDtFxBWzVm?=
 =?us-ascii?Q?q3wrafVJam9RWiXmST9GNb+6duFTxXHGG4E/FwVhMJ5J4BIAXRyqSbsdzeje?=
 =?us-ascii?Q?TW5H925Md/JDAoKigzSTSj03U3z09vVhDBInJHQPKJksvhm3ckxKefqyw7tc?=
 =?us-ascii?Q?yCqOehJIVUuN9WkLzXjwTxWMgsTrCcp7VwEJ9DVSvaG6x0LAM0bspfIujtot?=
 =?us-ascii?Q?+A2QdL4wZM36I0eSOh4Iw7hXT3IAFLmqc0Cd1m7gXVx8EDZexlihXXWo55/e?=
 =?us-ascii?Q?X4B2D5boLPj5q0KlN3tjBlItge0gcZsLrD3prqAJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Nbwy+btfd+bgE6fSlxihuOZnq9vfiDmY3aG25+IUP7LjuLonjvK566MmSlujbKwl5xSP7/q3xpzvRFZ9YtwYIUO403zmRVbQM33yxPnyGwb5WUy8LBHTnd0iKaUDsNy/vAFbHPM+kvqlCLXqgHIgTMtCtBfTTnqC5SgpJg8NWruwHx52+1LtCITvcaAFIlS3C/ICBI5W+ZAo35Zc6E7LAUDwAJHMIbvCBK9cIojET1Xf96hmqb3n9q+usyTfPP4gJmSkG1Gcf9x3hrX3TjSXxQQFwuzyScZzxPpOFT65ZznnsrZa5VNtdfeGw3zhZ+MFGfrOy/JMhmufAiLxs5uqPNG6+yN5no0GzOM7s8ZgLkJxx8TVMnfTvRFmH6T9Dy9a0NxrhejT63QQ/kC0LS9Uzh6PyGzUiga+AIEIxD8u3jA2ovHLlKD52vV5Fy8g4b81KAzBhAksZ7C8kFUIIguQwYCN9JO/3DmBkZyYnG/4BGx7d/+AWSmIfpyZQaWJdZrJd/pfqTTWGAsLHswhMf72D9sqKiKzMiNDjU7AmrRaMthtSRf+8G2JiiSzMWeUAuWvWC5m51pDPlOCOoFeg7NGY4/MSaUvhsGWXgNrelOf6pI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ffefef-ff1d-42a9-97f2-08dca018dd70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:13:03.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78cwp7GKEhmTh2XqPdVy0gYhhhPvkW9IlMc3rNppMIQBv91CDG+ORlhpNIwaEi9ShsUrTCexnsxozeeETx45Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090084
X-Proofpoint-ORIG-GUID: aF20xZVChyvYKpuYXG0Seo9otL2lxCqH
X-Proofpoint-GUID: aF20xZVChyvYKpuYXG0Seo9otL2lxCqH

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240704 15:28]:
> The vma files contain logic split from mmap.c for the most part and are all
> relevant to VMA logic, so maintain the same reviewers for both.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb1f0d3d26bf..e5ece55b3cfc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23972,6 +23972,19 @@ F:	include/uapi/linux/vsockmon.h
>  F:	net/vmw_vsock/
>  F:	tools/testing/vsock/
>  
> +VMA
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +W:	https://www.linux-mm.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	mm/vma.c
> +F:	mm/vma.h
> +F:	mm/vma_internal.h
> +
>  VMALLOC
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  R:	Uladzislau Rezki <urezki@gmail.com>
> -- 
> 2.45.2
> 

