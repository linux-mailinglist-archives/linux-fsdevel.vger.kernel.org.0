Return-Path: <linux-fsdevel+bounces-57306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08451B205D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECCE2A0E2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABFD23B632;
	Mon, 11 Aug 2025 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HdMtAGb4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Weduu8bV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91D1D7E4A;
	Mon, 11 Aug 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908770; cv=fail; b=VijQRUbQKahdoVkf9CIqiCOPWUzyXcXCd9G6qACnrN9cRISbYFrO3khIoA3H0I6912fpKjqjp5MM2OEzgS1bNb/Z3DOioHpGJiXWntZEvUwBN4y8v6ZBTchVFBpb07g+6ig3sCUo4YCelWfDbW5fwY+4bfwu73Yo7KJkirZQE84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908770; c=relaxed/simple;
	bh=U3yEDIwOjomvU75EwblOuMVw0QpLSrokVkdO9CeDodg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I3Z/nVbxYckjLF+IPEPg4vRhaftJ+GLP0W0QlRgomCffaCwJfBSQagdrmIOym2oLOahAoK3bDnB8bsPkdwgOb4wJNmn67tha/ZlZ2mpqHerVaD2rnbv99siTHnHDviojcapkr7W/C+droo8ZgW2nQNxpveMiHqIHkAdj47C0/zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HdMtAGb4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Weduu8bV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uEaV004960;
	Mon, 11 Aug 2025 10:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=U3yEDIwOjomvU75Ewb
	lOuMVw0QpLSrokVkdO9CeDodg=; b=HdMtAGb45b9K30oDKW+c74iptYntQ4Wjgw
	JGG9YpNry6dFAbYX4OmkQlpspsFOV9ndXrQfVLlaM1n1L4ob6ymkizzZqtwpFyFm
	4eM5GvaIS30Qt81LpM1sxcvj5pPS248ppMD1lZjWd2boivMYRMn+xHGsBDgWyaIW
	pm39Vd1NHmQ3//OND6fezX+AJAPY+lu2xrUBYAdJdaGMlQzQ9TCim3JOpW66/S6p
	wiIpHMyoigIviSRLl4CNoS5WAnmqr3IWdB2tiDQUL7/it6qdqYEv4DP6co3Icm50
	qSArvOd9TyNQCbui5zeCfWUdtNCg99YarGF9NLFWUvWLTXmg1oEw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4a7bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 10:38:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B97jg6030163;
	Mon, 11 Aug 2025 10:38:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8fm14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 10:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pesSEt4iFtNLk/6yS/QjfWnCNDKZC5UoIMJ0jzFLchvIDkmlbbxyGY0GWXLASfIg+Fqya5ViQ7vbBmNaP5MreyP7g8wS/NBjIij5DGEwbW2NeNpYCtwO2bepKla7ahtJYmhW2L7qB1JbiwUqgl+pD9N+Agu+JcH614mybX551LmMkXlfkIF1n7MiIKHIhAXOp+X7sqm7qFPDsS55RScdpR+bivsqzTM+LpxtJpP7gQBlXdcOWUM6pMTqKolN5k1IjDBGZCz//Lr4CfgB1CXRtszmIu7Wo6XJhva+GqzcAGt4HrQGnOPHNg16OeUOB4tkzWdTA4Yd6DADEMeSNIFBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3yEDIwOjomvU75EwblOuMVw0QpLSrokVkdO9CeDodg=;
 b=nRxy+ziDxZQFAUS0/20G1L2LUxQJsJ2n1v6qZiLYRCT8MzjHnUMgZ+xZj4P+83nQATKx+TNiMutXyV7zzmX7z3a3uPFMDiaSgQRKZDMH1Ak/vn8MRwvgE66UWAoSglAzoiG6I89pCemCFc0JoqbxR6kiCJBVKG52xhDUQtkoC61wh5KNc8V6+HpBim9/BXWSxfTkzyC80hoxQ00r9BlDKCvyhExPiDveUIA3t6SeAzpfnKPR1q/8zLbZAufnpASi6pWpm7N98bNo7kX4VR4qmEKpIEGOH+xkQln4i2iEdVcz7zDAm6WJyZvbCF8l865m+UAQDgpz5AQIjYGfT1dhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3yEDIwOjomvU75EwblOuMVw0QpLSrokVkdO9CeDodg=;
 b=Weduu8bVk7Kuez/BB9J+EVhl4LRSdx6WB4Q4zcgNMmBMHUEOnv3TcQvOhaaQ69eBZKqYjxydmtd23BthSGgUJPjtHRPSjioGT2ZKWrhEPkIfanfrtLWjHBCveLAKydrhZ3nOIFjqXbwYDbweY5n6PsGtGIlr7pE7CFjWd90Mm2g=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6531.namprd10.prod.outlook.com (2603:10b6:510:202::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:38:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:38:39 +0000
Date: Mon, 11 Aug 2025 11:38:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>,
        "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
Message-ID: <efe936a5-aaac-4627-b227-f844b1267297@lucifer.local>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
 <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
 <b087814e-8bdf-4503-a6ba-213db4263083@lucifer.local>
 <lkwidnuk5qtb65qz5mjkjln7k3hhc6eiixpjmh3a522drfsquu@tizjis7y467s>
 <57bec266-97c4-4292-bd81-93baca737a3c@redhat.com>
 <osippshkfu7ip5tg42zc5nyxegrplm2kekskhitrapzjdyps3h@hodqaqh5r26o>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <osippshkfu7ip5tg42zc5nyxegrplm2kekskhitrapzjdyps3h@hodqaqh5r26o>
X-ClientProxiedBy: MM0P280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e58e47-1bea-4cd1-8c92-08ddd8c33bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jCUcnzJnnlD7cVbPWR2THIOqJwrHlw8RMul2eys7U/AUYTG0O/aDkwn4znAW?=
 =?us-ascii?Q?Kxk+TrKcLZPT/HYdQ2jGBQKVzLCmbh9HRn5JQAVBoUjJevbwUM/erfLjyLdJ?=
 =?us-ascii?Q?6yutmIKDuM8p0GH6nW8u3YiAmC7GulmWcTm51xVqsgXeEVJ8GmnCJrHMppz1?=
 =?us-ascii?Q?AGn0jvWn5arXdSDyRO8PXBMujl6a1R8oRoFaqzpiNdJtwU8QvCqrcEO5QNhn?=
 =?us-ascii?Q?BWJwcsXhu8es6bV75OB4aIIJ2D5pKZcf1ZQeS0a9c595RHiRv5Z18rGLcMoe?=
 =?us-ascii?Q?5o06L66uQCuoC1CKacPcIA+UAZSgul4I93ISeVzAM+QAht++zkKn+jfQ2j+N?=
 =?us-ascii?Q?L+yxjsZk1BqIGTUvkqVFEpsVOsjgmW8LMSWRfRelmUej4gdH3a1uq/dELMgu?=
 =?us-ascii?Q?HYVQ1EVKG9HH8NEkhW47j1ze+4ODfoBEgCSagHjL4+xCBbgM7N8DhWM4AxrO?=
 =?us-ascii?Q?AchMwcrz7/+97EdIicpnU9FG2t71UvYuPA3HHmFtSma/pGtUs/42nFsH5Q1Z?=
 =?us-ascii?Q?X5AquPjo4545cftc9ffXLXhaDq1ybZXLNadOVo8C8O0k/5LmIbwVDV7x93S4?=
 =?us-ascii?Q?C+RnPAoV+Y90yI4wKlkChMUllFxphfLa6G0y1SbFiR0HJXhDrqoc7C4gLMtS?=
 =?us-ascii?Q?/5IZQ3cCzIifsTucrS7MiaTNwKZokSW96LkDKj4bkteupHZyYt09HZ47UrHN?=
 =?us-ascii?Q?ynKPYhew2yS1H33SLTy82olv0nGkJ/m+yW7jvrMcyJTBFhFfusROQUtjfolQ?=
 =?us-ascii?Q?oAbbLNQQJ/f/I+M+uIZ/I8nUmXQuOrWK7/0AIA2L4ckSTaCkGls6kTDt5ArO?=
 =?us-ascii?Q?pcBMLq0Q5WwGAShvmoxx9Kj4n+Z0ygyV8XeyiHb3t9HbZPzUl+zMnaMRReZB?=
 =?us-ascii?Q?kNdKDZdPAXyCQ3Wj4cFmuRcs3Q/vJ437MBbAPfOGHsRiMJlYmNbsOqptSHBg?=
 =?us-ascii?Q?nj30dQtA9YGpHI8aqq9JmZ3TuFrSQwoSdJ+fO3F6TrOJJtwrzoi1JKS03BQc?=
 =?us-ascii?Q?Bn0EwuBVkzD5xqdd01HzF9ZsFJHeshecs/+VjY9VpfBEFgFmQzQiSvtL7oJA?=
 =?us-ascii?Q?ralT3FWuxZ5KmcHsKbk9JefvqQ6qkHLtSb/RTh4S0IebKoMTqD24l4iO2liS?=
 =?us-ascii?Q?kSU/l/jjFMuUNHyDNee4l40+MHNEJ0ouTwTEs0G+FDdLAsVJRqU4KqVL59zb?=
 =?us-ascii?Q?7+lexV3WKqmIzAr24GXVkpNBaopllh384F9r/mhLLNvcCUQmHDozLl2JVKlr?=
 =?us-ascii?Q?NHdms/36dzoIaFSsVOC39e4j0qAoOl0T4tdJuGAUL0kjFH6W0nPpXfSshwDO?=
 =?us-ascii?Q?zRhyOCmoXLYLs+mDBoq+lFS8JDmjsMEkEyMJX6F+IebW4O5cRu259yYtPgAi?=
 =?us-ascii?Q?lXgHiv3SYHfhwqiKzcn3/Q8JpwVxvaGiYigJnyG/A0Zg+YinPHF1ux2+ncFe?=
 =?us-ascii?Q?QUWKwdMxpuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ziOlrw22PsnoOLZGrFlvW5Gjs3s9VTLrnTarmnUbNZEvJ3Ci1LVlXHkaR4fe?=
 =?us-ascii?Q?LkWL+eR7a45no2OCQY7PzGIgFkeOwTkCBBomJJyr5JnxsvHsLI0ZykR7r1u1?=
 =?us-ascii?Q?1ajhzWXuc8a4Yq1mIUrjg9Hh84+ZjiYZXzfbWPBAM9OCUVGkpsEKAGQVFQ2Z?=
 =?us-ascii?Q?U7HAPsjz8DHPeoY/wOEg19Zn1YydDM04U+op7pRT2uMvP35E+SwqW983jmd5?=
 =?us-ascii?Q?4KzSqDm4XxN4hfHIrl8c9b+uCVCPGuhmL+iudvkCSlY3MNDSvGwFx9YbDJET?=
 =?us-ascii?Q?Xxn2hcc6D9cK2XDwdmarkVhdF2QLAq77B0/+BwSkdK6y1U3xwnxNpgPXSxKK?=
 =?us-ascii?Q?ZjBl6V4fTM7vQxPV6waKEgNurVzLrJ4w0YKenudPfLWic3wvzlRH35tyZJ3S?=
 =?us-ascii?Q?7QEKAmOUOSe1ptaQp+jMD2kVAlp5BSyoINmQoJvMfwqrM5DyKiT3vQKPle5p?=
 =?us-ascii?Q?S+mRvx1ZzduuqTO1E+pzhkeTC5zGNIEXDxCyAFkkbrTWctgTTuyvn8KbHbIr?=
 =?us-ascii?Q?/TkaOIVcPRlCkD6fK7wsLcD2gOnJm94isoJsxrbnNCkhre8E0pnhdHqf+SXJ?=
 =?us-ascii?Q?iTQ9VEjBk8hipyzTPTQkDYG+TQ5GrZYb+KDkMY+1kE/Dnn8eSxLT7YwG9zV+?=
 =?us-ascii?Q?/f7S9LM3WZP1LnD1qfg5qRwjeTV4KxPvsrgIH89ss5DlwaOGJXG4shf/syqa?=
 =?us-ascii?Q?7VVWdhxJlS4Nw9Fq9arr3aiib+DfDic7PrtjYrif7Yn/+nY++oO/4UHPDJUG?=
 =?us-ascii?Q?o9u4dX8tv2h6uX1O1gUCR/dLF/ElyI4SUVGD91bHv5/0fOuFYySnKSXdg7a6?=
 =?us-ascii?Q?fxa5op0n7i3fju4LV6e5tPMA1puPXptZo3oKtHBhN5obh50kHJ+H920hyWTx?=
 =?us-ascii?Q?+oy6Ow6xttkIQ6lZ0RQICB/+n5rkYLdrWj4BhkQsQro+UY8fxPaCzhsDME/j?=
 =?us-ascii?Q?2IynLG8vkJuQwmZSO/HcDk2bYu1AMUdSaxOW4G/ZvNQPN1QCCNcEsBTvD/ew?=
 =?us-ascii?Q?ZWjg65hcMDplDTDXAkWMiNnP1pva8CpRznsj/Ul2k8F39ouEHjmJ/uHgdKJm?=
 =?us-ascii?Q?wor58VNQMGzcrhzPXCP9tOBFpWwMNmMrmQW9tmI7JTUsVF2//eV8ShwnSi91?=
 =?us-ascii?Q?D3xSIBdJs0/Hy2+TbyTm/TAk7IseO0z/rxKYYEonTCvamk1eoNkZPJL2nnR8?=
 =?us-ascii?Q?vpHiN0uSE8qndI0cvnPyyfNeXc9JKLhDvsQ4pUAokZ+FkIeFYIA60SArAzzB?=
 =?us-ascii?Q?8TucAf4BMZ1bf5EJ/4TQivUoSiyJXrv+vpvvtmLeFM+H9/TqhatGX177/h7W?=
 =?us-ascii?Q?4VAYIgD03bEPUuXTagXYJ6SkLnD/U4tEubFYiVk7IFcZbc/87W3Ud15lc9NS?=
 =?us-ascii?Q?/V5owh0XCo+IjcYmMTgYKJK70lzUroeUTaorjZ0DjUEGZjsyNajFGA3WQIXU?=
 =?us-ascii?Q?WnGp5P7yT8c3Mz/IvdU9L5OZcgV6pw9+AyuLgJuXxZULeWYXh2Imyz2Jpe6S?=
 =?us-ascii?Q?H3M+/z/HbvEaZz42hxNNRzO1Myupr0u0tJDTX+ju3FL/KAYf+4eDYp1q887E?=
 =?us-ascii?Q?dLre2YVF1qidSb+88QQFN+z1Y73E6So9hphWF9eiqyFagzZ3A2Kxar+DdfoB?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u69ZCb1hI+HSLPsoUfULONpiITfaXI9TwLAFZGqe0YztJvKLUupj0p9s6plcorG3KPUOt3P8409OKleL35uk9nw6wkUlSfkMxOqfjGoDNCkCj2EDdI+3OxW2P1eJxLxMoKaWXQ/AmxZZcT490yyQXpAfgl7NBZ6o525X/NevD6Ayf0jqznpXcVtqTv38/skt8tDXmafxzvACnPvGTz2s5QNGSAqOmJJKJ0uVTKmf+SH7MiAFS0mR1oSptHVg0KsQ24MnFcAtCfjUTCPtSOmtUDTJVqFljleqHeOa5UrA34NDixq1113fIVTtV7P7ebJjXbPTfzkgaowajIN6EIibjlhaAFXf0OiHRUTULQMA8pQh86BvWbLgHAkEadGizGS9TrGINLsqXgmEXZOQhbGXOq+vA3FB9qYWbMvoRdNfweUyx408GkL/1laM4f1cy6G9G6a2STihOUhwMGpXmwW8odNy9Cj0KE/mC2ZVnLv0ntKM41y3kmZml+9MkdBl3SWbLYGM6hUMVJEWF1tFnBSm5tBnOvigJBXcSM3bqs7Ed9eiwiPrn+1P3ngNmCCIOI8iGZbP48xQXdpVSuiZUMg8i2leNIfBtKRcei/ofIcc8s0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e58e47-1bea-4cd1-8c92-08ddd8c33bef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:38:39.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfYTeP+rv0xACz2SOztHagLA7JymJMttVgylJEsHLSXu9hHvXVmvOMveXfP4NTqqzM5Y26JSCky3K6ZnQZOIUARPf5E4DNb9h1wMp3ACclQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3MCBTYWx0ZWRfX2y4HTCb3DBKY
 /M6egUlXkjQEYLCyBIrEHG5OehgmqRdXMLcZf9m51XSLaZDkhqWQEam3Fanfpl9aeS4jRxuszRJ
 uUA6vDZZSXgsMkFava1VzkiEZ9VpqJ4oCATJ8ZWm3FANNFjksSyCkllPPuJyOTfuVjXmfizgGAY
 MRH30ZDx7vRjdrptM6qB1AwfWxXIzGnc5FXFN025jFFTEmDan4G8wIlWdOo2gpFxchsfI69ej4h
 2sKlLOBUZV/ZWQHh9vIJSxu7cVxekDzL7zI1o6UxnD9kYNAhIw2MpHzcbptvpJpCsR/qeUDKZD4
 RCC+5/3qkyUEkgBjZjc3wvj1SgN9aZIHFTkPwmDU53GrC6t3NCKtjecWIdHoO4QL/1oNkyHAFAW
 PptNdfvk399u0MaJG8BvJ8flcivdovfZzYnmyW6Q2zX2+kCnU4iHiSC9ZZKeSu4Ca6sRSGyU
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=6899c833 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=b9kdJWguJiP7UNHyFtoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: JFBfeBRCK6UtDUBNFJXeqf8hfyKXHCG5
X-Proofpoint-ORIG-GUID: JFBfeBRCK6UtDUBNFJXeqf8hfyKXHCG5

On Mon, Aug 11, 2025 at 11:36:29AM +0100, Kiryl Shutsemau wrote:
> We have 'totalram_pages() < (512 << (20 - PAGE_SHIFT))' check in
> hugepage_init(). It can [be abstracted out and] re-used.

We can decide to do that at a later date with whatever heuristics we
like. Let's just get this merged, it's behind a config flag there's no harm
being done here.

