Return-Path: <linux-fsdevel+bounces-43276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD9EA504F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CF4188A340
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5F196D90;
	Wed,  5 Mar 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ftyKyHFF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fA8Oz/iz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917D567D;
	Wed,  5 Mar 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192075; cv=fail; b=BxKo4VjdXGsQOcfPKsAN9vcdAVouUspt9L07PomF8ry3ELG6IjIg7OtBlMI84j5rLKQdIlyIQJwv9JlJUE5Xcn+A4w+kxxoSi8xiteIqwI9iI6KxJaJ1JYdZJZtVUmV/NM8ubyxL1jPM82Ocp3V66MdC9aWdeFpJ3IuAQk6yfaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192075; c=relaxed/simple;
	bh=uV7TPdgWX5uZQGBTZWPK+gO76IxljnpzpoIPjnlJGpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ItpPzrn0m6V3d3zKDehVvDLhSpb2WNRLQHrmOoE/eeVymaiuyHgespC9uxyChoFDYFQF5XAbYbcBp4iXqef0ytmUrbGEpJn+bOUISkmEPt8c+7CJb7H65E81UqBWgHU1Kdvr2WMAuUkaEJadMZu0Q1aRPc5r622dgs+CyV4y304=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ftyKyHFF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fA8Oz/iz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525Ftggc010681;
	Wed, 5 Mar 2025 16:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=RkBOkY+UBctoS2gePd
	iTYozh1yBnTH/9vz2O6qwjZGI=; b=ftyKyHFFJiKYySwe6WCaGVmWSJF6nT41eC
	wQretpBgej8mIp738+Bwg+FeH7iAWPW8Y21K70+qyQfsvNuGqi4oU1cvEWCwDc/x
	8uhDef3FNPL5sBWLc6kSrZh5pCEuvm10OwrUI6ptUEPL+I0CrbIufaXeCxWKaXig
	jjza9zivbwU1RiBohV1jLQo97zVyqpSrbV/dQnrS4Myy35z0V9WgeiEFMHgBAEof
	thWRoVpIEaJdvGLZQmouTWqc9tJmmQIKD5V+21EMCzp5z0yDysg7Zsr4aKNbAlpE
	IAACP9lxnhwxrNQ/IEfmiOp1GpYjiTaZWflJOTU4VYjdtoa0bJ2Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86r0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 16:27:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525FZt1w039739;
	Wed, 5 Mar 2025 16:27:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbamw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 16:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgeGf2D21VyFAPTJjHbfpFP5dN5pHZ7P62ZWSrPeJEOXgWN2VR2K+YGPuj6zIxz6NgwrN2UTNl5v2su/0VIpz+8nQ7/YPkgXjfUXmG+ahgbLRq+RSKss16D0r/QYTjf95aVfv+LMj9POeySf/fkguWQM2n+p92HjbFCyzi32Y5T0oL60niWb90L4yleyhen7TGvrL0X0z93ZCi935SYkG3GssX5nCA2WLfH1ppxF2hpbl6p+x7SEGaZS1Wayj3kkYPnw7+3VGEbo0+2Q7di7llZN/HYJsWdJbWmb8g+APk7EgBpeRghli6A31pvHOvR+GWIx0p0YmxJN86Kw2l2vrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkBOkY+UBctoS2gePdiTYozh1yBnTH/9vz2O6qwjZGI=;
 b=ewzjYzKbzB8+m0Sy8ZN2Dx7btkUkz0Rl5q37TSyy/mMWl2OTtqB+UJi2eIQ2JEm4XToIxklHNpONj1Nc9DeajWJxUMNeX8/737JPtsa7kSMEzhfKkcKg9W7ZQZEP9Ozdp+CTLBtsvgLQ7UnpS+dlEMIRIkI6rAXJP1YNDVZ3ygxd/bAPgB4mlLb064LJobLrg3/S73hwUpNTn3ATyA0dvax38sx+HF6ak9atgTVvbyYdd0XnPb2hmbTYQU6o/yGqcTf/JRXTWOMMR3tQF/KGzpWOhSmDUidMoJ1SYAyCrBYR+zDURSBABBZKW2mGZrCFi6Q9hXLohjAGpa05iWJcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkBOkY+UBctoS2gePdiTYozh1yBnTH/9vz2O6qwjZGI=;
 b=fA8Oz/izNZguMQflcnE1ugSVZGEU/GUW8FQCthXPW08wk+H/ofwxB805KMaqBm+/yyZysVhvGjF0jp3LYPKLGAewNoznmD3nANLlWCbi9z57zmkZ1kj92ZZkezeEHXn73jiR1d+lip8IOME/z6q+YrWH1nN9Nqza+0CVApe2WM8=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM4PR10MB6912.namprd10.prod.outlook.com (2603:10b6:8:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:27:34 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 16:27:34 +0000
Date: Wed, 5 Mar 2025 16:27:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] mm: introduce anon_vma flags, reduce kernel
 allocs
Message-ID: <21e45c84-dc44-4f50-b273-ce158d130ab5@lucifer.local>
References: <cover.1741185865.git.lorenzo.stoakes@oracle.com>
 <Z8h04F4b_YVMhXCM@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8h04F4b_YVMhXCM@casper.infradead.org>
X-ClientProxiedBy: LO3P265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::20) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM4PR10MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0b44e3-c320-494e-9d44-08dd5c02a210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PXTyfkK63GDspaAsr0Hwk1iZWfDm6gOi91sa+j2rphsZDMirIXbVNi0Y+5sV?=
 =?us-ascii?Q?J/SMEcUbBocxowhvdh/TtmwwNp1MXrag0WxfxBQoQ4yUugyBxElKZpZuEkwM?=
 =?us-ascii?Q?ONGpyMRMQ+EmZ8ygpre2C3fWX+irEzOHioRvgCCie8L9n85fry53qdqjbnc4?=
 =?us-ascii?Q?p40Mk3vUw1KGTw46LQKLtRNyZMacBI5ZzjwjfT4+OxYtxpB1nsaV/0tTh7oX?=
 =?us-ascii?Q?IOarvgxvCodPBAcgVaQWUxJwd2KjunkGzFo1o4zu61nUUvfxjkCoxJfM1H+i?=
 =?us-ascii?Q?/KXN2ByxDjmoD2OjrPtb7o3g/JEfP6KcgMSYx2Mzu9U85ouL9LNCmVHBgnja?=
 =?us-ascii?Q?VOpTkgTKt69NXNRCtTqV+UQd//Jj7Ym2hlZgULVzbe7s5Ku/IBEanaCuQQKM?=
 =?us-ascii?Q?x8ppZ/d3G8/ZdoxikYfQXMWVW5+OmFWp2jWeivU+6uCnH4vmFSt4VFCpTfFt?=
 =?us-ascii?Q?+W7zfvdGvTOV8LuLkoMlOJ1TXYmwGKO+WGmPaQIbZ5uW5n80hWy6kvmPhSJ7?=
 =?us-ascii?Q?VzmNFCTlmv6l0vNkPiTwB2amyXrjUPGxZN+8wq3UNqotx2WyoFixlT20T/f1?=
 =?us-ascii?Q?IvmGL1vEdynFbk6V2DvYfX/soF8yYNNjoNdcIzuddMCNo3O/jyV1vjKjObVe?=
 =?us-ascii?Q?WnM9eSK23rBGcjoXvYAlD95579exfNejKZRFbE+1y4/OhIIeSCOhfi3gmbTX?=
 =?us-ascii?Q?+vNVGk71sGbT0rckX5eur+Ebcc12uI8+hLEtKApt0gq7uAFWVtA+57e6GlxC?=
 =?us-ascii?Q?ZnD5rTYSMUL36ubgTXyybZoRff7CKGOse/k7g1Mz23gL5jBrCw/K+ObteUz7?=
 =?us-ascii?Q?a0+H6JZln1mHLGCoDLQ7o5YvmJUtK7cGXYMbOX+BNz8PxDtYy44D3xSXis6D?=
 =?us-ascii?Q?4pCCZ6PqJrFQc199Zimq3ymiXY8QUThW9x+2rFKaKNT787aff2pj7CfU2NRC?=
 =?us-ascii?Q?XGp2weDe1Yp8iyuka7HUZ8sMaJuY83t6uuCwiL60qf3mdDU35MBq6SJGNhWx?=
 =?us-ascii?Q?iYRD72cSKsMpCq7Q+ZT8IuLdrAyqFpDrZnB0S2+92ZyeenOwYoY/IFWS2ed8?=
 =?us-ascii?Q?emJCp5YnD2Swz5DKBoQgmya329PSsxHNnYwpYDaoFfUa8+ixkKKcoUALxO3f?=
 =?us-ascii?Q?5We2sAbw3fQW6kUO3wMUB8y85pmMnp2LwuOhDJ1wz/89dpqtuUJSMmA04RIY?=
 =?us-ascii?Q?hOT6+VQk1m3EA/GjGfeKGt4c129Iji1EPXW9V/Q/sOo61moTjCnpUkepGHE4?=
 =?us-ascii?Q?eayOi4Hz45fB1vO+RLoTJJoLzTj9s9jSE0+zAAnPRougqS+HNqnVkxtDxUYm?=
 =?us-ascii?Q?cp6H8MSoOTMEcnh5kUEgr1ue5eNfxfLjCrvIaFbAYNRHtKMdm3hPhqRDEDns?=
 =?us-ascii?Q?7FyL5a7O0WGppqa+FdMANl27xgAS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bWQiGVff00feTu2pKC6hzFRtdBgbCZG+PJGBAaniKwsZJIVma6C3FGz8F+iy?=
 =?us-ascii?Q?Hsckkv71+fcvN7AmVdrPuz59c7uktuB/kquN1IhdnBJPnB2/wz5myQr1JScz?=
 =?us-ascii?Q?DoLGF5zUVJCrJ59a6/hfp0495Z+P7j/W/G3DIxJAf8C7iBIMgFRfnqi/+F6i?=
 =?us-ascii?Q?zyEAl9woueqW2+E0J7iFzINCuT98dwuP/deLBBCrWFAaGOkdd8NSHyCDVn2u?=
 =?us-ascii?Q?mBa+7bULBUMkAKEAoSloyRDPwUUwMoNGhwL+GelUR5rjZaEtHwBeMcrKx0Bg?=
 =?us-ascii?Q?29B2kbJ7ejoQ9pSkI6164cZjDj54ERUYf+T96p+D7BT4ANQfpdFz0n/d/Jua?=
 =?us-ascii?Q?Bj86VOJTnqc0OgMYNwgHZ8Cm4GdfaZl0Ggj81gxqTDpytXwhOLQIlvLSIhbg?=
 =?us-ascii?Q?lzArPqJx5uIF2LHEE4yc/QtmnoRL0mpMpMr0u6bL8FTkvmkrKDZxCPSbNLK2?=
 =?us-ascii?Q?DOp+DxzW1p3siuZ6aXwU7WRIjmFco70+0R0o/16VtOD8FjCT2bzaa9wEe5Kg?=
 =?us-ascii?Q?Dwgb4fEeN8tyMJJLfwAFzOZMS2bbW6BddxDVSF78gPRNNYthS9pLu5q+hwKg?=
 =?us-ascii?Q?DTW2AvQvXR6rlWqKrYmOkdhv2xDSOIhdzfYmtLZdfecVP7n767RxZlPA8WDO?=
 =?us-ascii?Q?ul33K1jrQO5GfYTkVVPXlzDNfWYSv+8pRe7D6ShnUW1MQ7wuqC5V1CFtGVUh?=
 =?us-ascii?Q?dIoCll5ttN1ZqVIiqd867abmYqAFwB2O0S+bgX69t2dP/V8jTs1Wnd0sXNsY?=
 =?us-ascii?Q?EtD36cxK+GVYSZ8Mya/+0jFUiIzjtjHeE+sXZXApcZ2xaMqrfk1ncrRmsea9?=
 =?us-ascii?Q?fDriVeZlKb8Fm4sYShL4/9wqrGGP33huXpfOSflc5+3AXC0dUuFAhFSUx8i+?=
 =?us-ascii?Q?8mHer+xM1hBkPOWo7lN3EMzwuWhTD4cWsYHEYuB89Bw+2Ulzo+EbMeYerZQG?=
 =?us-ascii?Q?Z/jilpaGlpnEGqudq0svv4Nmj7kK06rD1AMmYM+Y8mRAPARrI/tMYkenstUZ?=
 =?us-ascii?Q?E/mq46Tmk7EMtfUIhxk6ZX3Gj/SrRnIlIOlNiFSCMelfVIXmdfrtLCSDWZvy?=
 =?us-ascii?Q?3k9E1rYrqYCf8wLiGV5BOe5niNmPQ3oCg3HCnpO093yXUfIA2tZa86GSpHyz?=
 =?us-ascii?Q?5mDhNub91jcR+bKFlmhufP76o+4si0jfO5HDjSTMwYTwql2il7G1MLaLYpAS?=
 =?us-ascii?Q?ndhfw5qtq02y5B4jUnEtbGmY1gt2gz0ZfN2aOpAr0eaax+oI2HFWqrmIcVYO?=
 =?us-ascii?Q?DVDcJ6ah48H4HXsaVKKxTzjlRRhrDur7DTnthHzn2tHFEpMt1Gd38oRlHws9?=
 =?us-ascii?Q?nUT6aAqxiKtIdKoUrwmCHM1R/bFh4OD6JkPSvinU2ml+18lGl+EPcdsNpD4I?=
 =?us-ascii?Q?PkDuovFtA/W5/ieeTOfeB04JXOHskFuEQoBV5R/VFUrWvhKCJ2e3ubNjrUQl?=
 =?us-ascii?Q?s6wv1LMDSNjQ7YHqf2sTP0lGNJXPz/+VuOzfmriOVVAd33P9WdQq9iiv4Aef?=
 =?us-ascii?Q?nH627a1qexn5HC/Xr2b7WowS9NOQcFDi1aX9CiG2LWsaWeq9FfMnYzXVi4jw?=
 =?us-ascii?Q?TrLnE6DKcomM19A++L+rxNgcJ7zZHrjpDWoMOo7fgHgJ1N6eisp0KjZt4Qgm?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4iqtJ40oXvfu1DKeEHCHPfvQIYM4wkx9HzPDVgVi5dEfd2La6UgxGerBLcQ5RXOjG2bnbr9+2wtSdroEjT0SO5fFByfy7nI/GoVH6VW/K/ufSzuQc3FjgZ6nPjnHxJRp05bsdVooTGbpWLc6KF4xm9kUkLN5z1huH9ZAxGo94nu9nIzFjuVWmoK3ANWLMPYBNTqUUifg9cc5wBJOhsWKSkOn0p6C4IsdTOush4y3Qi7EO4sKll9+7JlHAQu8pYH3Ge2ep1+29VLwv3GREaKIhC1fAooO+7V0wrJWIRrbkwTAyttyG0bm7RH4rBbH8G286lazzMjIZQAGWt2S2VmkVFxs2tTzhZFcpnEfEezjiFMKllj6Q7gk2cgt5byGhsahheVSLXcG9AfLNgwmM15T3bFDgsdYDkTVYB2Yd9FHOuxTNmHRi82/ozRcLxP5iCX/TEp1c5y/xJSBPieyAVFi5d7rvSSX12RZBOya2uCtrnf88oIOb204+xiwu3lVbwFOg3Uroxzp8kPl1yN536bSBLDnQt7ieEbVLbVi50azApk8Q9kV2mIQVoYQqptBO59PspVPaVB7ObbgN4WwpgS6kgIvUqqkDYVYXe+HQKfQfS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0b44e3-c320-494e-9d44-08dd5c02a210
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:27:34.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvhELKZsOphMitUGNepACcDZdMsiZ7BXP7Vyt53OgIwFKaiisAtyRwPCw9BUsdmxHPwWlBYvmOPUJH4m0d5U0dAPVhjZgctvytWOFFCdWf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050126
X-Proofpoint-ORIG-GUID: xhGZZ1zCIGlWsa_15kcdk5Vz7PPehcfe
X-Proofpoint-GUID: xhGZZ1zCIGlWsa_15kcdk5Vz7PPehcfe

On Wed, Mar 05, 2025 at 03:59:28PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 05, 2025 at 02:55:06PM +0000, Lorenzo Stoakes wrote:
> > So adding additional fields is generally unviable, and VMA flags are
> > equally as contended, and prevent VMA merge, further impacting overhead.
> >
> > We can however make use of the time-honoured kernel tradition of grabbing
> > bits where we can.
> >
> > Since we can rely upon anon_vma allocations being at least system
> > word-aligned, we have a handful of bits in the vma->anon_vma available to
> > use as flags.
>
> I'm not a huge fan when there's a much better solution.  It's an
> unsigned long, but we can only use the first 32 bits because of 32-bit
> compatibility?  This is a noose we've made for our own neck.

Sure, as discussed off-list this is something I'm going to look at, it's
not either/or at all :)

I have in the back of my mind _other uses_ for these flags which isn't
stated here (perhaps should be), perhaps we can have other kinds of data
type we reference here.

But perhaps it's a bit early for that...

Other than that was a morning's work to see if this _could_ work as a
_immediate_ 'what can we do to address this issue?' solution.

The vm_flags solution is viable, as we can modify merging behaviour for a
'sticky' VMA flag that doesn't impact merging, i.e. mask out for merge
compatibility testing, but ensure propagated on split/merge (same behaviour
as what the anon_vma flags achieve).

>
> (there are many more places to fix up; this is illustrative):
>
> diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
> index 0660a03d37d9..c6ea81ff4afe 100644
> --- a/include/linux/hugetlb_inline.h
> +++ b/include/linux/hugetlb_inline.h
> @@ -8,7 +8,7 @@
>
>  static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
>  {
> -	return !!(vma->vm_flags & VM_HUGETLB);
> +	return test_bit(VM_HUGETLB, vma->vm_flags);
>  }
>
>  #else
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0ca9feec67b8..763210ba70b6 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -571,7 +571,8 @@ static inline void *folio_get_private(struct folio *folio)
>  	return folio->private;
>  }
>
> -typedef unsigned long vm_flags_t;
> +#define VM_FLAGS_COUNT	(8 / sizeof(unsigned long))
> +typedef unsigned long vm_flags_t[VM_FLAGS_COUNT];
>
>  /*
>   * A region containing a mapping of a non-memory backed file under NOMMU

Ohhhh does test_bit() automagically figure things out for sizeof(addr)
including on 32-bit?

Maybe I can quickly slap together something for that quicker than I thought
then? I was _very concerned_ about tearing and that being a total PITA
hence deferring a bit.

But... if you're saying I can churn this to death and it'll 'just work'
then say no more... ;)

Let's put this on hold then until/when I have actual reasons to have
different anon_vma types and I'll look at the 'make vm_flags 64-bit
everywhere' thing instead.

