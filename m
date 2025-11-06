Return-Path: <linux-fsdevel+bounces-67280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C02C3A57E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 11:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DDD189ABED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40F42FAC0A;
	Thu,  6 Nov 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EVqqSrmP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BBWPSc9b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AF2ECD14;
	Thu,  6 Nov 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426013; cv=fail; b=WOy3uE6qyuqfuoWGNilOukxu7LVxxuTAkCRMBpCIlei9ejZpT/LIOvUwB/yFOX3s3sluDFDL1bLSJuFFteohlBVO7uORgCbg7pR1V76b42PGbXUwxToURKGc3jF15CXgGGsSe9Ep4t180bl7EiCRBWNnAVd4hwefo9bRdN+/Fjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426013; c=relaxed/simple;
	bh=MKROvQyiASyYbJJiFXoisAtinMikLeZ2wO/FoIDKnv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCrHlJvbQXPXZAuXU/jkcYzN1tUhXQGaB9NRE9O5WfIpXpv2EQOSV0lQYNEI1xL5S4zUg6dXIdS+3/jelS705YIeNw7VhKC8GZHeYEQ/ehhaGlfkdwU9KiGHnxO8KjU6Naz3iphGqVIypfERm5espIokvlmBB3MPBlAR3NbKoVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EVqqSrmP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BBWPSc9b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A61CI9N001576;
	Thu, 6 Nov 2025 10:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l83b7Px4HVVWu/DG54n1uKxc/COK/eWvlZlxxmwskt0=; b=
	EVqqSrmPTu7yWLmxmEO+PvsM+8lC4DxmcPaA7aK0kBs2tuB1ta9LC2jpPO4V7rN8
	eWEhwLypjTM6mv1AiNaj1ls5az6H0mGTinQCf+Q7MN0LNkWXK1kFJIGWh2M4651I
	P3fILKzDHDDeHnxPoF9whpXTfItz1QiW3bedzVdFgWj01ntDpOT9XUR5vrhWOiFS
	1VkBS+s144CN8ESpuATWmEcYQhnU2ecUf1QMa7NrxuE/krclQXJg1cLwlaAWD6/z
	PxtPShqOfPdjQ7Ml+hWoaY635G4mVnpm2LlUO4PpEM44sdTdNKVMF9jpDo5pyj63
	zGkC9JOW7ZEoLhUO2E7pHg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aqw9qva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A69pktd010962;
	Thu, 6 Nov 2025 10:46:32 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc8c4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 10:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dl6GW+wzf6RHAtchkkb3saO/sxXhhoJ2k9HlH/ufb+N7rwUwuT9u5eFGsXsiBT69TBJRx5kTX249TQowRg+lmvB4cqbWVpBKMT1tMloN0zpkm/SJBOAiXRGyphqOpyT6ZxwTA2TD6MEo3+zclduZ0Ro7ZL/p0fdNdw6vHkf2Y7sqzveOlAOjzca5yNcaKzKNbPeXcB9rrEHZt8dyhimgWcTueROletD02nW6C72G6b+Rn90fJ3sqjE5WgbKzJrGZZVb8ZvgVvKh3Zu9HrF2bv7k2PZv3e6pCwvq6awYlbzQwm5JRK2/J7OLuI2Rv/xyyRkjF9xKUT44sIF6tdOMECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l83b7Px4HVVWu/DG54n1uKxc/COK/eWvlZlxxmwskt0=;
 b=ufoGf0P6ww+5RJPNd/N3iEfMOT8IvsdkN8RUoVOUADdcpGtG18G+Y4CckPYkPaTeIwSrCzR9Z5b5431K/BsYIoB3fmNjWPn5dBhWlGIoiffQduIDXMls+WCgyDyq6kymeOzzOXvgedGAgtib0fUZQypTZ9aEHxBe2axj8NEW+gqVhuuL1kznqTCb5lWo1buErIgi0eNtqwHB4XDZd2MseTHgq6CIj5HwVZitx2fNT7ld+DWN/IhBS7Onp6mOUrfoxqM8ktErdy5kTwsyTyVDEuwSjMnUlrszja8kOVR3E7DpkcxVKcG6TAilHCCiuTC2gEQ5aRHqF3K2lmRD5BOl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l83b7Px4HVVWu/DG54n1uKxc/COK/eWvlZlxxmwskt0=;
 b=BBWPSc9bmh8J/JChr8T9MZb1+b0zwo06bYsgY4/aGLr2wURHKuolUyOqFj7v1BQ1ue6gyjq0euwYJs/fQA5wK/TuEUf6YvzTil+IsByKACcdlw9G2dzL8BZ9eWFpZmR/wi+KU/GBRswhlQvebPoYt5afgPuOesW5xXyCtcs4AaM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8250.namprd10.prod.outlook.com (2603:10b6:208:573::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 10:46:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 10:46:29 +0000
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
Subject: [PATCH v2 3/5] mm: implement sticky, copy on fork VMA flags
Date: Thu,  6 Nov 2025 10:46:14 +0000
Message-ID: <9c9e9fb6b767556594b2cef023db01d45d8f8463.1762422915.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bed493-c231-470f-c9af-08de1d21bddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xYCCo93Zk9p3nynY2dEgud53Kqe/2IkxXXF8WOEChXGjT5MMZDbs9B8RhnY/?=
 =?us-ascii?Q?MHehZKigMrTk8APm1DSdSGB4xUbAvKd/SKm1ddHYxCFVEZVBI1vEq07Nk88z?=
 =?us-ascii?Q?M6YU/VWqOSUztRiWCq0006nuUX2kDAhwUjwuFcP8UfQP24q7zLucnHCRcStq?=
 =?us-ascii?Q?x00xmqr/7ME7s8VsFYVzEnVjA5slW3SbRkbz53T+82AsNc+e+ONeHn732+So?=
 =?us-ascii?Q?ZK++fSgSq+hEm5BIkdt7gNkMgKRkKKP/SoNUU14vxPwtBSRLb/baOSSMIVk6?=
 =?us-ascii?Q?6xBfsmWfsejwap3nPl4HLm7KVmlcOC9aHoobJCL76BocI+MZEFJdvcEyYe/U?=
 =?us-ascii?Q?tK1NyAectIf52vV+bFluBeICfOiUykPajVd8f+h9AfhKQaxSLxC5ocYb8zLK?=
 =?us-ascii?Q?xV03Ihvt7mnAiLhE/y2toYvGeazhgi1XZDnZQRS0T6y/V7NAvaobFNF81+xc?=
 =?us-ascii?Q?2qdm4d/IfDBRQgiOIB01u4+6uwawSWReRT4+WQID4Yi0D60y6x/Gf2BaqHW9?=
 =?us-ascii?Q?hL5NX/L5q20G+ouUQn46zyZYafQQxPX8IAmSfOJ6CVO2hERdM832zt3zul4c?=
 =?us-ascii?Q?47wEIr1/qWjrloF9IWmwsli2s3vOpQH+x3ZD5R+agBIUM88zFEs0G1lKhaSq?=
 =?us-ascii?Q?IlM1vbTDz2XT53cOJarCjgknlwF46FH0C/3iL/s5I6qYhxAVHBSf97FCn98v?=
 =?us-ascii?Q?NqbH0OpVqpALqcynL+iIpzTO8uatOxsMPwST2YlsPxbog/DQGkVqmcVaCYwf?=
 =?us-ascii?Q?9E5XA4ueF2J20lIV0YJMYbGIMh1mDsVpM+l3Tybru/8RhDkk6Mzk2n+miVUq?=
 =?us-ascii?Q?TomY7CU/J9jY1IBhOIejaAav1ZoHGD9QDGnSXUAoXfJZtPUh9rxEHIo7eMb/?=
 =?us-ascii?Q?hauYr/zSNgRVEZMuRftK3tvXphZ+uOckM76lUPay6VF2QdYF4f6SfOI+bclb?=
 =?us-ascii?Q?Jtal3b2n9lpbkFyGPo+yGr6VcErmMwBUbaBM/YFlnJShrKj7YQNW6jgYg+1R?=
 =?us-ascii?Q?ULBGHCPC34fr1zCUwER7IVT0P4MvGmEOAqZCGzfpUnQp/tFVPnMvFDV7Wwrt?=
 =?us-ascii?Q?OiJV2ydh4n9Qe4NXXFB6z/MvjOcwQsLu9BWbUNWQ4osAmuEAfIvaB/5PnE8D?=
 =?us-ascii?Q?Z5gNWuyN8i49pBn9WOxKB3iEE/iAHQm/+64GwbaCh+p0mmIN7xs1ybE/l/Tq?=
 =?us-ascii?Q?5Va/7TwfgQV7Nrgox7PqU+9VxwRi0lPSPARJ5rTaNP8pLk0HXI2TO5DW5ON1?=
 =?us-ascii?Q?xb+9mn8o903BegYtB2ChzU/roDHH3FsVrtqv5fxIsXzGJVAtyK0QDr3p3qC/?=
 =?us-ascii?Q?wTnWcFb4MV7/iIc6hhNCRmP3Mdi5HtO6dCUsFJa2g+tOYKu69FehATfz73S9?=
 =?us-ascii?Q?YGcGm5E7UJ62xzd5SuniHgobbVVzSXn8/s6ke1LuJoxnl8i2g/28jcNHQnjJ?=
 =?us-ascii?Q?N/VpVMUoEY+OONgcFwiY2ebgaUNoAswg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UO/Zk49BsSRe3mf5ys7lRNkxd23smv58WdaVJy4amPwfUkE838oi8qtng9vO?=
 =?us-ascii?Q?VQZ/MyN1gub80AY0lfwDK3jZlYuYQaUUQ40MNDmXqIPlwRCRZwImnVqUlOum?=
 =?us-ascii?Q?qcQnCQZjiOCcMfqYGNZk7LOTwlzyIWW4F+JVeS88A4awxI5NEa4JmvWdss1H?=
 =?us-ascii?Q?iwjQv6gMYir/5lStz6XWU2VHRMnZLR7W1DlEVpCsdVOg6oZyFBQQD5c3luPW?=
 =?us-ascii?Q?3SRDIvxhoDyKZYJPvq6FcFFmi59MzTfnGg9OwVPGPr93fppxfvlNIsbWyUCB?=
 =?us-ascii?Q?mzVzydeNRJtyxZRoNjgR9INazAgcKhzNDF2ImLwKgkH1xrKwlaGejFw7bdxj?=
 =?us-ascii?Q?g1w4x2f2SppsKxlWJjQNiVk17etDXs0Ks3o4HAKPz2QnHpyRrX74d0UtvOS9?=
 =?us-ascii?Q?s5l79YYUCYY1pkQmIgvqEa1Ubk1dcbrHq4m8pOP56m5VJCtVuf7fM7Beu5zj?=
 =?us-ascii?Q?B2tUkhgpVys16wlYCN9LJCV4Kad/lJbEOaldY1mYpYQVJTFTYKQWc0lbj+KB?=
 =?us-ascii?Q?GRQPGj7FrzOEkkQsOJPcNEPshW/fxNSk0NQLaV+BElJK1VleJGsReBza+vBX?=
 =?us-ascii?Q?85j2dfklTT5MMsSWNDKAnww7PfOWkI2Xd2Reu5C/4EtA1KcMaXtvGEDulGkQ?=
 =?us-ascii?Q?6dy4KNoaWHMSvIYJwqEx8fc0deNN5N9aFSl9Ghy/z/QyH/XOpfVvEkW7oSeR?=
 =?us-ascii?Q?tjbcedyboQNPKKbCXJy6+F1Rsd90JQ9m9mHJYZf1nWOem6OQuEIfHDxakjS/?=
 =?us-ascii?Q?RoxbvRqggfytMgyulQ/q8ifUBFYs7WTSHikbT1HG9st7nS0C0HDsBUifFLmn?=
 =?us-ascii?Q?vzsYNBvJqDlLzghF62OAKGzBK9zOhLsECVZ6MF7f2kB5NIQ08o+f9/PcIW99?=
 =?us-ascii?Q?/3EYpNZt12adYyB2OkmyGYU1Xs5sv7lkVZul+61zZyQk799aa/3AivLAAtVp?=
 =?us-ascii?Q?BRBZ7HOToTxpaTijtJX483c+j02DKc17MK9e+gOpRPXEojWMhUru6h0d7l+w?=
 =?us-ascii?Q?drBAMsc5OrQ5baknRxdu6nqQlSWHJGVkBrWZHPirMPyJJgJlky2TMzuURXfP?=
 =?us-ascii?Q?FCRyHkU8GdBsu4KSqJfMMIHuLKpscsJTbsQJ+7GnuOgebQbn4DjI8vyOZuNm?=
 =?us-ascii?Q?dZvOqSbnRQo8ZjycieZo3RcSxBQaUrhFnPgifTkpweFRNhVf4fk/zbzZGIYc?=
 =?us-ascii?Q?MR3PcfmPq/5ytlEBcIL+t5hHmz5QNGZEA8SGx9I6fI8nyGJQMcZ2eji4UWKJ?=
 =?us-ascii?Q?v5PgxJAAlmVLIpAB889axjWUExmc44WsvSVnPUnhYw5Jq5QOIh7FZBGIH3Fk?=
 =?us-ascii?Q?LSXacUF/crx4MNw/neAD+lo3q3u6LeTxJWa2HX0gys8KotafnPYkoPF4V2K8?=
 =?us-ascii?Q?ntvs3qK0+ButCEMxVTnHx3iPK+LeX4cnUWJBP1gIg3xsSnwxOGeKgCO4FAec?=
 =?us-ascii?Q?Z4iRTOodH32iW6x7ai21C2CW1Ra1zZcJ0bvSPdHYBsLFZTRPEXcnjF0LxdNB?=
 =?us-ascii?Q?WtSsXHJ2UmItcEXbQhE8fuGWCySCRo/j7WpLJdOUlp5J00Db1dJbujwJCH9w?=
 =?us-ascii?Q?W2+inTKK0wdQ8LrxhZAEljdxoKk/71uBxgYW7pdnEEPWQ1s9vc9eS69JszIf?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	++aOh5L6Y3XNfLPB+X2VRWkiMk+OO+3FArVR7tvjGpLbxkjMJGxDzLRzR1M+1VEBsRGlhuWrRX1OIbLvjjlYNb6pFvN99ea7QjZ2rfTfKABhk5zdsiKiqE4vZW7/PEvqXbXP5O0n9lBGROLesxP1B/6e3ba05y7/sB37WO8g9P3EYZSt+lyVmAoItA6ARBymMwp0HNY957+7s39C0+EoVVxvO1isefWraxEX87UhgLxOg2D4YhvuuAIP60q4O+9m5ETbmaamNRudvXJCul8zgQR7q4DUSL2DI6elCU1KW0Anmv651uOdQQu4rULnGNhwo3AS6UI247xOE3CKaILFz/9LD/GZaPJ80kOlgifLsazEOQ06D4R2Fn+4WAap5ZoGbcMDfN4JESG65/+UOHI320dul822tPdMB1Ir6FmWOCFhvvGsSQtx8C3d33svxmjMt5jvyCS/yHzD180UzvZ8/1eFQqnwhRt4wX27RjWde0/PetVC9P+qgZcEHqJWhe3sax1ZqTPHkAE4UNyY3KVdaLLX0bhW2KK6JqcrofIlFGoP+vgBoA8LKvL/EhphWsNQLgiWu2C6jdwV+mqYHaf4NxQhR3O0P69pxSUzAnOUom4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bed493-c231-470f-c9af-08de1d21bddb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:46:29.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CZr6yoI/ssM6acxqmqce7m5TmSl2k3TvglKXr4u5I5CA0OpaTLSYKTQxF1dJDirt7urtAlUvhRW4Fdf7iw/vE52twQRKaZQuAo3vO2fx/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060084
X-Authority-Analysis: v=2.4 cv=NajrFmD4 c=1 sm=1 tr=0 ts=690c7c89 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=mMqtBKPntBUHp3g5CqAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: nQHFjSBWeeQlJQBfv4pqZ1Y3v9dZ0TGr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX+QZ8nhAwQcXg
 8dDA21ALoNSsWGx/KWG5iUIrAnGG8fO/3pH4PU1juAAVkiMb7evH8zE5NzhWTVW+AMLA7/uFYsW
 3T/BYvU/gJqNEvCPgPnFD43DGb0mjwMkoU1dLWAa86fW1NXUbGDQKz8RHdsPY0ghufVl/AQnB2g
 4XXp/zKvyd4HE+5299GZc+1ULl5o6lCuY0sa2C6KXLSwSVcwkwaA3O6eR8U2LwJ5wvbmbfCaHpv
 uYgeuJVz9JxAN1KNzwk9Llu3YNfYpzHW5cHtfsiL4YWdFxm2fWY0Crg1xmwqnLddUSdrpO48hvD
 bi7YSpTB3UhLPCjajHD/27lUGQKCDOnrMGeMIiKv5ChSsDZeBadQHV+d10lykPDLmtvWrXunRGc
 02uFef06om95IBzL5D+lt/4PaNdptg==
X-Proofpoint-GUID: nQHFjSBWeeQlJQBfv4pqZ1Y3v9dZ0TGr

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

As a result of this change, VMAs with guard ranges will now not have their
merge behaviour impacted by doing so and can be freely merged with other
VMAs without VM_MAYBE_GUARD set.

We also update the VMA userland tests to account for the changes.

Note that VM_MAYBE_GUARD being set atomically remains correct as
vma_needs_copy() is invoked with the mmap and VMA write locks held,
excluding any race with madvise_guard_install().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 32 ++++++++++++++++++++++++++++++++
 mm/memory.c                      |  3 +--
 mm/vma.c                         | 22 ++++++++++++----------
 tools/testing/vma/vma_internal.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2ea65c646212..4d80eaf4ef3b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -527,6 +527,38 @@ extern unsigned int kobjsize(const void *objp);
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
index 334732ab6733..7582a88f5332 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1480,8 +1480,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (src_vma->anon_vma)
 		return true;
 
-	/* Guard regions have momdified page tables that require copying. */
-	if (src_vma->vm_flags & VM_MAYBE_GUARD)
+	if (src_vma->vm_flags & VM_COPY_ON_FORK)
 		return true;
 
 	/*
diff --git a/mm/vma.c b/mm/vma.c
index 0c5e391fe2e2..6cb082bc5e29 100644
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
@@ -808,6 +800,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
+	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -900,11 +893,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
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
@@ -974,6 +969,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
+	vm_flags_set(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1124,6 +1120,10 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
+	vm_flags_t sticky_flags;
+
+	sticky_flags = vmg->vm_flags & VM_STICKY;
+	sticky_flags |= target->vm_flags & VM_STICKY;
 
 	VM_WARN_ON_VMG(!target, vmg);
 
@@ -1133,6 +1133,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (next && (target != next) && (vmg->end == next->vm_end)) {
 		int ret;
 
+		sticky_flags |= next->vm_flags & VM_STICKY;
 		remove_next = true;
 		/* This should already have been checked by this point. */
 		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
@@ -1159,6 +1160,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (commit_merge(vmg))
 		goto nomem;
 
+	vm_flags_set(target, sticky_flags);
 	return 0;
 
 nomem:
@@ -1902,7 +1904,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 	return a->vm_end == b->vm_start &&
 		mpol_equal(vma_policy(a), vma_policy(b)) &&
 		a->vm_file == b->vm_file &&
-		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
+		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
 		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
 }
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index ddf58a5e1add..984307a64ee9 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -119,6 +119,38 @@ extern unsigned long dac_mmap_min_addr;
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


