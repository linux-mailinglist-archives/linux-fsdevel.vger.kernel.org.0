Return-Path: <linux-fsdevel+bounces-56768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4609B1B6A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 16:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D03179473
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51F27814F;
	Tue,  5 Aug 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PJyyqzpd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YmxBqKqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DF13E41A;
	Tue,  5 Aug 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404584; cv=fail; b=azYtADeB6cDozUmtKs4Y89ojMtASdufnV7LkUxIcYF/A+CkR8KDh2xpKHxlqa7EgP5bSp1HzB9vOIURtZQbrGQ3APurQoDY8GFDlybk28UCYhc7ysrd4Q5+FRNpqUP8LrRgJ9dQTOo8V8gJWEGEnGP67xs7shXPDdvsF1SRTZjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404584; c=relaxed/simple;
	bh=Ad2nEew+w0/5tbxCKJSXh0Aaxf165IsCgu8uokOhHKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IeSZCTrj2A31tM3OZAVLRY2KjLLw/Es7hfgG7cBaKfu8X7Y6OaqklzVa8PKnwP2C0k2SMFFjB1L5DqhMyenDT6Zpum3iTEbnUSKRX78sOb7/1b/AjiyfmRUO7s6A4r849dOHjfGr1C6aQINaAWdjFYXNCLY0KDf1VNUvZX/rjFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PJyyqzpd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YmxBqKqT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575EY3Lt031151;
	Tue, 5 Aug 2025 14:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fkUr3UEePe2uUhDqlw
	iAIE1V/+OhZvPnidXYcD+LpAE=; b=PJyyqzpdlK/ubz5uzBKBUO3/sNqXm65ZE3
	Vkvui27PnFPH6YBNaS85IKUjbkVsu7S7IeCh3s1WoQfOWkn0qxaG8Hwj9BW3lGP2
	ytkBKti5hoJd74bNOml4PVUE1JeybAAUB+wXLfDHcaR1NiuLOWF61GFpr0Id4tFS
	IqQ1aDMn3lV+/xQJpk0g4P17D7BaWed6mUVtipQs8jh8wDh/Ui2yhHeKPfq2Lwm6
	KtM68di6CI32hPuSF8KtTB2DkewiKOGkfsWrJyiKSirBqIEW4ZafoNGqejcBp8V0
	NIRigFXSJfF/XSktHRYvlG43Skv09spnMYC3FsfYMk49gncYOC6w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489ajdmuym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:35:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575EV3AT036729;
	Tue, 5 Aug 2025 14:35:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48a7qe0sq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Aug 2025 14:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7V00h7C3+boosMBdfNCadfOFh7jjhPFBBgimTrHv627a9ogtYDgzRIWfUycJWfeR1Ic7s2+R8IkvafNfr9VFkTgGe9JLFeySasJq68hWQ1tMn/Pke7ruPkiKmyCcKHJOPsZksFSAXSPqSRsfuMWXWOO6J9ZxH0yaPbLk+7/xNB5pZ7iDAKP/i8+QzHRGYk/RfjqyGOGQ5F/V5tBM5tvH2uxn1yazE72uRZkYEgQSEnXHSkWBGIw/fe7RRYx0bq9gyBxv9lXf1YrVeu9CeoLQEK1bynpmeNLFhfGyYDcvhQZm+v/xdMt0hBHRd+IzIgYnqbREBs4ZgL+RzHJVixXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkUr3UEePe2uUhDqlwiAIE1V/+OhZvPnidXYcD+LpAE=;
 b=m8oUJvnnj38dccKMbwRs8Jt9Rqr92MgysSGT2h2o4pxtW66zj3yyhN/nr+FJ4mGprpuDdnotDp5guh1v2LRMRpO1bFGhvOt7fzqNQLcJ/w/8y32cQDCif1CH7jZEubrOhiL6g0E09AT8ghvbPb2bQK/Jvt+Gs/4HuncsrWvo3IVBTnuCNrpvm0+voJlfW+5JVCLVbpRLwS5lGLTYRFZu6RDnYVsnDjz02SXr/rnpbHLaExMGMh9TLZ4eKM6RxdUYcFGjyGhohSJqhQqsBTF5zO4yzJ0LMGBbph07YBNWJRV1OKonW5rJgdaWGvVFnp2qbxTMcswHMEFpSIKPcg9EMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkUr3UEePe2uUhDqlwiAIE1V/+OhZvPnidXYcD+LpAE=;
 b=YmxBqKqT2cCUxRAZ6CSVVrygXz7iaTr2E9fg9LLD5P1RB2xwVqtOmN6exYYGYCH8VNQWFNnk57Eqxz+eTwnjrMWXV/IeXRZNVb5JWVHUoF+WlsGAbr9pJpuySLPveIFs9ONlaJfLwbu5/kQgjnC3azzPwxxUnJFfVsk8NFh3Po0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 14:35:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 14:35:17 +0000
Date: Tue, 5 Aug 2025 15:35:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v3 2/6] mm/huge_memory: convert "tva_flags" to "enum
 tva_type"
Message-ID: <ad83a0c9-be30-4743-bf09-0ceeef1554e2@lucifer.local>
References: <20250804154317.1648084-1-usamaarif642@gmail.com>
 <20250804154317.1648084-3-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804154317.1648084-3-usamaarif642@gmail.com>
X-ClientProxiedBy: LNXP265CA0086.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d426198-e837-4708-82ec-08ddd42d4c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QpEzAfXCihETBNM2ZlFH7ckrfg+oqodBBbou7MqDAEk2H+c2wyFgBl4AziBx?=
 =?us-ascii?Q?kcG32vhTFK90rcJczOPucpFSCwCjq6LwMQwTtoSBXXe3T4VhoeUKVldxyY2f?=
 =?us-ascii?Q?cuDdbWr6LOZaez4DMFOwjKZ5jSvl4MdmwvzbbTcRuyGzfwokhVaZNLh1pc83?=
 =?us-ascii?Q?97Y/2lXzp+LmbNzVAumkJs3d5rE4lV0zBZb+V1rnN/MCoHax+bR/+JpODbFN?=
 =?us-ascii?Q?PapNPrvnqZnYi9p8xRjdWpFbkY1ltgRBROpY5XwIpVfd51kulhRH8V5A/JmZ?=
 =?us-ascii?Q?mF8jgkIjDFmqq95EEdfPv/cW67OmkBB/0Kb51zYFvq5sHjKKZSELaoUMThGK?=
 =?us-ascii?Q?62hvwDV4jfnR97ivxiSh89N3I+t5QigiFNYyahYuD10iHYzcd6D1ooVVRzhI?=
 =?us-ascii?Q?D8lOJRysBCctCtpyW4czKvU9CooxuW2mkfoZArk9DmUn0d1g6kHWhS+zIlLy?=
 =?us-ascii?Q?nWKCms4riPlUJ9bNR/rSRtpKYbFqbSAlvtfP56qESxGVOMeoUmik2uDWqB0q?=
 =?us-ascii?Q?d1tn0JDro5JaQz9IFp/+Fjpln59ncBxve/uwAVBktlkUKAdBNm45MNxy5sUo?=
 =?us-ascii?Q?/w18ydEMtP4qsngDa3rquKB3FOuJfockfEZgWP6OTfAYoRUJSZTVfNEyvU0T?=
 =?us-ascii?Q?uOU/IxzFXCMKfNbVuP4W44M9hukyKuXBmiaVjJGqJNHfhPV+qAsu/cVKOxJo?=
 =?us-ascii?Q?QK6IUrtYEqqf6E4CmIFwR6mN5WKrm59zG4oE3BHoJo1TTGB6qaNPhi/Def3a?=
 =?us-ascii?Q?x+y27R6qgoJ2vIlj/8UUncOTDodtvtU1IrQvoprcAgnLO+50IU18ZZ2Gsi0x?=
 =?us-ascii?Q?oV/ij+TpxgACzfl/r558Xvt7wFugyCWVVX4Omzjt80xxkun1mxR+jcs2qcnd?=
 =?us-ascii?Q?MZNkMrG8os3fIJFfQihOoepKav3fJ9EStl9ulBXWHWPnanhN35XM+kSj0A+9?=
 =?us-ascii?Q?QTIEKEREXT9lQjW3GL5IFVMA5JZPvi1Jj02ch89yICEdUNn3AwKUuJnTfq4w?=
 =?us-ascii?Q?kUvvP8+D6xP0J/ATSaUh6OHmB6909DpE6KgvqcjZGNTHtV4lFjTnCU35n396?=
 =?us-ascii?Q?zeJhUfp8PYaIMFqou+4qM1bhtN54dHAk7GitwBXVKg/2WqY3m0Gc/qXl9Bee?=
 =?us-ascii?Q?nQv+iN9iqqxXGvhDDfWjit/uy4kp7ap2QLKlK3FtKFCXD/ab0p1PI98Isf37?=
 =?us-ascii?Q?wO0acdmXk+ascBU5hYuUmT1FEVte+Up6e7j3yHBoSJ5N29LN/6DKA0vWNPJN?=
 =?us-ascii?Q?KxtrSHhPYpy0NjFSe2rVSr0btpaV6UxM25tOEOQ8nJr6scFnFGFCqdlkRWh8?=
 =?us-ascii?Q?58bGoxOCtjKJThSuHyG0nlxUnBh8uyihuF+Awytz/PuLAeT827mTVLEzUwon?=
 =?us-ascii?Q?9VTyqy2zPQ5EaFbYkDtpnmsqn+p7PF3BJyHcVvA0M85z5u3mwnHv4d1NItPl?=
 =?us-ascii?Q?J7mljelKeUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FF4J/9AIZ1l6I2BOgQXJS03qXh9BgCTzsm3eT+IBXgXvh+0iofs0kVMb3PQX?=
 =?us-ascii?Q?ubRVml1XxNv/uLXPLRC7cstUSmdRd10+FM9pLpsWT4/dbhuHeNYKmZE+oUnJ?=
 =?us-ascii?Q?2epikO5p5YZE7xidWmfr7SJuo4lPTRxmlSTCG7QazNnNf+540HzJ39eD5yLA?=
 =?us-ascii?Q?jMuCWF2h+jS0zivkWHCyl2HFXxT2803aL0wQLyLRnMaYsuoUfVqFPV8UUPIb?=
 =?us-ascii?Q?T4xlDUcPk3sH6v9Ao84QlkHtLYCEQj91wQXVKgt3VFkTZN6VEhQS7uC0iSeY?=
 =?us-ascii?Q?d+rU9CZjE/dCer+lLbE3cP0GtmU2Kfr0fBoC/OgrdMYTBEOCOfU1MqmYDf+H?=
 =?us-ascii?Q?WUsFCoArsbhNAEcr/nH03OX0mMwR5os/2SE/jGMrpmD2AWXA6qot+7R1pwo/?=
 =?us-ascii?Q?ZTySUQt2HdDCNClewp1zvrA6l8KlIxjNPriGfidcbQ4rD2QruVFkPSHhSGFk?=
 =?us-ascii?Q?f3XIL3G6U5W5SAFjNgOtmfC7zhSOjzsg23t4njIIDSLceBzZmHZW7qih2QV1?=
 =?us-ascii?Q?H44UKFA1DPk0g4j5WXeY4K0tRK+7hss4hVIg7FnrzU3nvfrV4tpjpATwNdBZ?=
 =?us-ascii?Q?5ZhUutCvmCYZqKks96oqstNE/Kvv1ezoS1pi1eg8z30C4sLcVyaG56WVmD0W?=
 =?us-ascii?Q?U2Vp6e2zX8E/H4vq8G9wVJIxURHZ+u9Hn5sMNzNeQmc6J8SGdcG5lIdm2uc/?=
 =?us-ascii?Q?ELw3BzIC36Z0ZeWjKXIob1D10iV6+vugVYvizBW2XCXUb5QIEn2UntYqJquf?=
 =?us-ascii?Q?p2wTVpQajRndtHyIbbLjgve88QCenEG3/wy+ER+WpbqvLFbhS0zbJzWx4HVB?=
 =?us-ascii?Q?lUnpINxun7M70tJ25523hqfZv08uLsEZb/Mt7QODmcvxpCWCUBHCLvtjHqRd?=
 =?us-ascii?Q?2UDYCw1voHWW3ieCfHS3ahJylKCbHaDT2DTviGjPPwkuNyUNV+lwR1QLZKck?=
 =?us-ascii?Q?6a4jnlJno+aQY2BWducJuAWyQzlI3W36+TI9ykiNuVCswIdccPHFktlhqwD3?=
 =?us-ascii?Q?yFgkniBxyFKC1kNxKlJnnKc39ZULFJiBP6FI7W1RNQtZcqR9mJm9egYlB6Wt?=
 =?us-ascii?Q?WwL7IUNLvrucY+IB+2yrpWqjM0+18uqj9VcfasAP+U0SIkgaG0WLv22EOs1a?=
 =?us-ascii?Q?9+ImK/5ZG3TV4zE4GyshG7/by0RSqnnltmJlsriJFIdLRE71ciA3KpG0kAxo?=
 =?us-ascii?Q?pPWr+HdkWRRHheJK8U0djJUzYiYNv66NuUdaIhtWhJP1eWlYzlwJmabKyF6T?=
 =?us-ascii?Q?nxD/BWPJKumOMApwCk6ku5Vp7EaH+PsB0tVHGznXCrQDp3XhAm0MWAZ2ZtZA?=
 =?us-ascii?Q?zdp5Y3Q9jibG2cZRngr2BrWjeKae2J+NUJlI6H3okRcWPDXK+vlac9I2QPBy?=
 =?us-ascii?Q?djETNCrpvIoajBHmg5wnYAokEmOqjQt1yPzOu2lUO+6L1AeDlK7Yh2V67q7+?=
 =?us-ascii?Q?a+sHsdvgRfniYLhXXKyH2QBrcpm76qN3zdQQwClF3pqQphiOwihF/QtXtLUT?=
 =?us-ascii?Q?lNwtad52ez2uJnjLHAcwih7uYjOPE0EnFLYxkupmkl/uWk/cMbeW1KsgHTsK?=
 =?us-ascii?Q?XvBTSrDmMUBL1QVNuxzJE+/Ft4kdXBpAdMO4xp4Llf16N8yaw6wKvezMIxWW?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HCR8zApd3ynza68XTqm31kcE/qlm3diHWWXdbwQ12hiT1IRHNJFWzf2BwUBA3kn230yz4UGW3IRXZVk4e6tDLWUJv1e5/sjAp0atVvlW0tYjl7AC3/9xtsbeJvrfkSeq/j7FsaHVJS9M1ctvyG+7Te1q5Q+tcJvsNI9CwcD1SlUJXBF8GACQW5FodjMIJIMQbZ1Y1a/6RtweSrhyJu0/BQtyAeN9NO5FT8HRv5APuqiIuHZjdSVPAxSMGH6Dsje4Tttm1NXUAdd7HDdfaOUWJue6lXzyZfzAzNmrqplpiQI+pa3yr8w9DDxi5dBrMNTQLz7FRAYDjKDu9QCp8MRkDfMLMTVhctn/HNFcsZXN+qxtct/TVePbkMoUiI0Pg/16Qw/acuPD9aqha89dAQbuhuR/sbwzWxjMSB3fRY1XID9AFEqCadH6RAVVrnCjNg5ORde+guXlv7qndaocbGNAgmuHmiY8CClsfHvR/vzVIRXbXvdKKY5PvJiKsroYAOXrQK+fY/eASFfjH44j+hg+iGf2GEjKGQCLTwwGSRtnN2LHkwJ8V0rKEux9VqF+EVnAKEv/JjN4nmcFFga9wVWqJjwd+ldvmGduC6hOQ7pR0YQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d426198-e837-4708-82ec-08ddd42d4c50
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:35:17.7139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRVEvS15U6AB5+qCgj7L60YGOhC06cdToDGnzViIJBmh3JKLVin8ioVV2jW2ZOroOAhySrYNq+ewgIWthR3k9aX0rlQuEftzP+DNtBqIdZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050106
X-Proofpoint-GUID: HLWacQu6Q5AkeLDo-xhwo9a5iRJ7OHff
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNiBTYWx0ZWRfX4LfTTerpNjIs
 b0Dz/A6Rw4LDlWUZtpsUvMClMe+10qIkPAKk+nG/T9Srh5dI5MNSW4REggLhpDEfbX63jGvdQOp
 pZhwE9gnN/tpyidEVUJi6Mg8g6F9t15Q93kzLoy64h6DdOroirCSoWrt9L6YDR+VA+4yqIjyqkM
 KOVXFtvWtgYdfvLRKUAnTQ+QdWJWjPpXGs5k/kPE2D0RyL7CyvOUAvSZ0m4oqu/t0gpdn4ESwyK
 Uoig6YhfDaTrEJFy0Zbnx2p01kw225v0YJtVixhdU18RYVFUwrEwEJLa3+8nYqRGFSRZC/5gzId
 vAClTTgr4964deBKkgL265MKnn9KdQTBeERyvqOuCah1IjOj/Upd9PQ0FjO56U8pzax19ReBr0D
 FtAyWiUxy2drJpDOIEmqbOmdQPY09eNl++/Y2ZrXxS5ZZ+TXmks92fGHk7gcy09F2R1wugZe
X-Proofpoint-ORIG-GUID: HLWacQu6Q5AkeLDo-xhwo9a5iRJ7OHff
X-Authority-Analysis: v=2.4 cv=FIobx/os c=1 sm=1 tr=0 ts=689216ab cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=fp7mA_UQtOfmEVu42oEA:9 a=CjuIK1q_8ugA:10

On Mon, Aug 04, 2025 at 04:40:45PM +0100, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
>
> When determining which THP orders are eligible for a VMA mapping,
> we have previously specified tva_flags, however it turns out it is
> really not necessary to treat these as flags.
>
> Rather, we distinguish between distinct modes.
>
> The only case where we previously combined flags was with
> TVA_ENFORCE_SYSFS, but we can avoid this by observing that this
> is the default, except for MADV_COLLAPSE or an edge cases in
> collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and
> adding a mode specifically for this case - TVA_FORCED_COLLAPSE.
>
> We have:
> * smaps handling for showing "THPeligible"
> * Pagefault handling
> * khugepaged handling
> * Forced collapse handling: primarily MADV_COLLAPSE, but also for
>   an edge case in collapse_pte_mapped_thp()
>
> Disregarding the edge cases, we only want to ignore sysfs settings only
> when we are forcing a collapse through MADV_COLLAPSE, otherwise we
> want to enforce it, hence this patch does the following flag to enum
> conversions:
>
> * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
> * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
> * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
> * 0                             -> TVA_FORCED_COLLAPSE
>
> With this change, we immediately know if we are in the forced collapse
> case, which will be valuable next.

Thanks for the changes to the commit message, looking good!

>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  fs/proc/task_mmu.c      |  4 ++--
>  include/linux/huge_mm.h | 30 ++++++++++++++++++------------
>  mm/huge_memory.c        |  8 ++++----
>  mm/khugepaged.c         | 17 ++++++++---------
>  mm/memory.c             | 14 ++++++--------
>  5 files changed, 38 insertions(+), 35 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3d6d8a9f13fc..d440df7b3d59 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1293,8 +1293,8 @@ static int show_smap(struct seq_file *m, void *v)
>  	__show_smap(m, &mss, false);
>
>  	seq_printf(m, "THPeligible:    %8u\n",
> -		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
> -			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
> +		   !!thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SMAPS,
> +					      THP_ORDERS_ALL));
>
>  	if (arch_pkeys_enabled())
>  		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 71db243a002e..bd4f9e6327e0 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -94,12 +94,15 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>  #define THP_ORDERS_ALL	\
>  	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_SPECIAL | THP_ORDERS_ALL_FILE_DEFAULT)
>
> -#define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
> -#define TVA_IN_PF		(1 << 1)	/* Page fault handler */
> -#define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
> +enum tva_type {
> +	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */
> +	TVA_PAGEFAULT,		/* Serving a page fault. */
> +	TVA_KHUGEPAGED,		/* Khugepaged collapse. */
> +	TVA_FORCED_COLLAPSE,	/* Forced collapse (e.g. MADV_COLLAPSE). */
> +};
>
> -#define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
> -	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
> +#define thp_vma_allowable_order(vma, vm_flags, type, order) \
> +	(!!thp_vma_allowable_orders(vma, vm_flags, type, BIT(order)))
>
>  #define split_folio(f) split_folio_to_list(f, NULL)
>
> @@ -264,14 +267,14 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
>
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 vm_flags_t vm_flags,
> -					 unsigned long tva_flags,
> +					 enum tva_type type,
>  					 unsigned long orders);
>
>  /**
>   * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
>   * @vma:  the vm area to check
>   * @vm_flags: use these vm_flags instead of vma->vm_flags
> - * @tva_flags: Which TVA flags to honour
> + * @type: TVA type
>   * @orders: bitfield of all orders to consider
>   *
>   * Calculates the intersection of the requested hugepage orders and the allowed
> @@ -285,11 +288,14 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  static inline
>  unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  				       vm_flags_t vm_flags,
> -				       unsigned long tva_flags,
> +				       enum tva_type type,
>  				       unsigned long orders)
>  {
> -	/* Optimization to check if required orders are enabled early. */
> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
> +	/*
> +	 * Optimization to check if required orders are enabled early. Only
> +	 * forced collapse ignores sysfs configs.
> +	 */
> +	if (type != TVA_FORCED_COLLAPSE && vma_is_anonymous(vma)) {
>  		unsigned long mask = READ_ONCE(huge_anon_orders_always);
>
>  		if (vm_flags & VM_HUGEPAGE)
> @@ -303,7 +309,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  			return 0;
>  	}
>
> -	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
> +	return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
>  }
>
>  struct thpsize {
> @@ -536,7 +542,7 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
>
>  static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					vm_flags_t vm_flags,
> -					unsigned long tva_flags,
> +					enum tva_type type,
>  					unsigned long orders)
>  {
>  	return 0;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2b4ea5a2ce7d..85252b468f80 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -99,12 +99,12 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 vm_flags_t vm_flags,
> -					 unsigned long tva_flags,
> +					 enum tva_type type,
>  					 unsigned long orders)
>  {
> -	bool smaps = tva_flags & TVA_SMAPS;
> -	bool in_pf = tva_flags & TVA_IN_PF;
> -	bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
> +	const bool smaps = type == TVA_SMAPS;
> +	const bool in_pf = type == TVA_PAGEFAULT;
> +	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
>  	unsigned long supported_orders;
>
>  	/* Check the intersection of requested and supported orders. */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2c9008246785..88cb6339e910 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -474,8 +474,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  {
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>  	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
> -					    PMD_ORDER))
> +		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
>  			__khugepaged_enter(vma->vm_mm);
>  	}
>  }
> @@ -921,7 +920,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  				   struct collapse_control *cc)
>  {
>  	struct vm_area_struct *vma;
> -	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
> +	enum tva_type type = cc->is_khugepaged ? TVA_KHUGEPAGED :
> +				 TVA_FORCED_COLLAPSE;
>
>  	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
>  		return SCAN_ANY_PROCESS;
> @@ -932,7 +932,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>
>  	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>  		return SCAN_ADDRESS_RANGE;
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
>  		return SCAN_VMA_CHECK;
>  	/*
>  	 * Anon VMA expected, the address may be unmapped then
> @@ -1532,9 +1532,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  	 * in the page cache with a single hugepage. If a mm were to fault-in
>  	 * this memory (mapped by a suitably aligned VMA), we'd get the hugepage
>  	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
> -	 * analogously elide sysfs THP settings here.
> +	 * analogously elide sysfs THP settings here and force collapse.
>  	 */
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>  		return SCAN_VMA_CHECK;
>
>  	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> @@ -2431,8 +2431,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  			progress++;
>  			break;
>  		}
> -		if (!thp_vma_allowable_order(vma, vma->vm_flags,
> -					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
> +		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
>  skip:
>  			progress++;
>  			continue;
> @@ -2766,7 +2765,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  	BUG_ON(vma->vm_start > start);
>  	BUG_ON(vma->vm_end < end);
>
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>  		return -EINVAL;
>
>  	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> diff --git a/mm/memory.c b/mm/memory.c
> index 92fd18a5d8d1..be761753f240 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4369,8 +4369,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
>  	 * and suitable for swapping THP.
>  	 */
> -	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
> -			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
> +	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
> +					  BIT(PMD_ORDER) - 1);
>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>  	orders = thp_swap_suitable_orders(swp_offset(entry),
>  					  vmf->address, orders);
> @@ -4917,8 +4917,8 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  	 * for this vma. Then filter out the orders that can't be allocated over
>  	 * the faulting address and still be fully contained in the vma.
>  	 */
> -	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
> -			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
> +	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
> +					  BIT(PMD_ORDER) - 1);
>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>
>  	if (!orders)
> @@ -6108,8 +6108,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		return VM_FAULT_OOM;
>  retry_pud:
>  	if (pud_none(*vmf.pud) &&
> -	    thp_vma_allowable_order(vma, vm_flags,
> -				TVA_IN_PF | TVA_ENFORCE_SYSFS, PUD_ORDER)) {
> +	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PUD_ORDER)) {
>  		ret = create_huge_pud(&vmf);
>  		if (!(ret & VM_FAULT_FALLBACK))
>  			return ret;
> @@ -6143,8 +6142,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		goto retry_pud;
>
>  	if (pmd_none(*vmf.pmd) &&
> -	    thp_vma_allowable_order(vma, vm_flags,
> -				TVA_IN_PF | TVA_ENFORCE_SYSFS, PMD_ORDER)) {
> +	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
>  		ret = create_huge_pmd(&vmf);
>  		if (!(ret & VM_FAULT_FALLBACK))
>  			return ret;
> --
> 2.47.3
>

