Return-Path: <linux-fsdevel+bounces-54975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C957DB060BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEFCB4094B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EF829826C;
	Tue, 15 Jul 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hQqab+px";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QdntjmH3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A112980AF;
	Tue, 15 Jul 2025 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588586; cv=fail; b=gapiUl0irVcf2WKJcmWFLNU0jtUVpsoN5qxDp6XSWeWE8/+mOBWlQ/1mARfYoB23MxpP8Tcspm5q00usgXxLy2uRrUKlNca9RnWIrUf2XSRMjWDp6XQwe+58J9WA7f+k0wZpJi0Ul7+T3t3WlGgJvR3mv5DAzs3NngvEEGaziMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588586; c=relaxed/simple;
	bh=PcU9ax7lck/TaApV7KAf9Ybv/4YmuJroZEonCcW2+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d+vi1n7jz6fze+bBCEn5TheDo1v3q/Yn9XroQtE7vTfBynFUdUBJepAqRxl6R35DvqsnU5iVj3Rge/WEEhKSe46J6INZydFn9827hXiUpca4+k6NbY1mHul8y7I+R+O0QguKMOAujxcNXdN6F0jM7bueemf8ZTNbO/Q7xghjRaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hQqab+px; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QdntjmH3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZC2C015143;
	Tue, 15 Jul 2025 14:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SRWN9O+ZvaFgXh2eCP
	/OD2YcupYR7wzCLZbgYSq+EUU=; b=hQqab+pxzqXEWrhXG0bcpTtBumz3ddmBd3
	5qDYxWjEQ87Yp1ycSQKn3IbktFcYPGoqNNpc/LKAmzgatdi+/QFji4sz/mHkDjfz
	z25d0AgnaVmAT2WyG4PNFFONMZJ/YkuYJn/VI2hYyRqFfaniNlBNhDGWStcx3erL
	BXypzJiRna6X6mk0Dl/aOMErpd6WkgtLM0m9YnuGkG1N8QO7R2Q9UR7ppS4XWBGr
	gDOQ/dikXcURd4w/YgU2ITvfSAD/vRIEYWhrB9EjyMs7WMVHjOeY3VSFSpQnZvyY
	hH/dNSJtJqqHIgbCXMFTnDsOtJuSSsidFVUbSSX5snFZfEvaKWHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1axr82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:08:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDbe9I013762;
	Tue, 15 Jul 2025 14:08:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59h6q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 14:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX2C1CKGp763z0QI6YyukVK7Ddo4eqI2YLBO9FyZ0Tegi2HD+FCz3jP9XPrgMLvC8rcnq42FmZnyyD8xlzqkw9gKxffIBIOWKWUYF6icIGph91xsR0yTuSdK5RtizdaHJaEROyPVAVDbgeTtSKVm9XIOLQ3Z0xQ3X8I2WB19+HE3EUucnVYuC7OU0fif/1hByjpV/VPcAUQkdO9rYoCL3McGURbGDEC1i58F4VPUqc0BuCkdVWeyrNVVcrEFO+D+wTbt7U6GHX2QChMUf5mPZ6AvskNgCxcWU6nGOxU810utXeLn/lP9xs2sU0QQNPoIDFaum91NGK4IwwvzXTCcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRWN9O+ZvaFgXh2eCP/OD2YcupYR7wzCLZbgYSq+EUU=;
 b=APjgkgZ2yOnat+wR7bLKS2HgYhdofy+8DNyyNEeRUn5B90mHq1o2TPklV29TOhvkIa2tDUXh1FvbNWCbUAT+Jo7oz1VjvPM/eNKGfftDoiLSPPnZDMqoatX6RcdTBv4Qlnz+ccmOtDANRJDn5VSPSz0ExpHTUFiF9VSea6A5EYvcxajf6IPmIQOnYw7SLt8fMvQibgKdACLl8eW1M3j4pS3VI8iWU0Q8sh9mXGyER5v4fJ+2LjDNxjeTRwvQ4vsmnzKdB2eGz+NZ2MAmrOll0RXXZnu52xIvwB5hN/DrfzuCLwqgw26Nt3aepRIttc31OEhOICxcMIcRUQcOpSgXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRWN9O+ZvaFgXh2eCP/OD2YcupYR7wzCLZbgYSq+EUU=;
 b=QdntjmH3acog/IG/632N/VShXkOTSWlSEfriEG/qMJrTNDBpKqAY6yWBb6MVWQOm0YG7ooiGOp+wBXFZIRVvAUsWJrDwMAIYE6X0PnBXpZDQVEPlbRRYtKRBCzju8KCtrJ2n+3SersHFC6zbPX7OUEEkmTe0BmAC/quVafGoKWA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7729.namprd10.prod.outlook.com (2603:10b6:510:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 14:08:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 14:08:43 +0000
Date: Tue, 15 Jul 2025 15:08:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/5] mm: move huge_zero_page declaration from
 huge_mm.h to mm.h
Message-ID: <a0233f30-b04d-461e-a662-b6f20dca02c5@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-2-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707142319.319642-2-kernel@pankajraghav.com>
X-ClientProxiedBy: LO2P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eefa14d-6365-49a0-30b5-08ddc3a91b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oOZX/sMzqyP2dGydpS316KtRTkvg4InMfEOaBUSnFNIUghkqnty0DC4/Vh7O?=
 =?us-ascii?Q?DVpaCm6gdrTlRiHlvPq/nYput5b/yIcf0fQArMmNW2beLT0jk4T/0A4UQ2dU?=
 =?us-ascii?Q?12gr6ntS2woLlsYV8esPzY9Le+OWOiHYv7Xcub9KUhRURwnDy+Aq41kpSnrn?=
 =?us-ascii?Q?ZlixrjgZIrHKXFjuerW0ANvVteIaFfXc9gwvnmG668PiKF3lCokmIjAY6Xe8?=
 =?us-ascii?Q?didcgDOd3tpkherSt3eq/ygnnvEOg1vaxHJZEzippoAERK/Lv4H4HDsPHBSY?=
 =?us-ascii?Q?hc7MZ8Elxn843Er+xWEyg1h/0Zn3n+7PSOcjHwGuw9hkf7JrLLdVVOrktdeW?=
 =?us-ascii?Q?hUUnirgwcAilO3c5w50G83AKrT0Hf1D45f+AmkCioHvEI3COvP9Jl8EiWFJX?=
 =?us-ascii?Q?IwX9GBO0/BkwH+5pLaFTjRMwrNhVQw4ztzdBOczMMM/qrHnL14oOXGBM2ukW?=
 =?us-ascii?Q?9rAhpSTqEpT7BjVKViVXiAAhZGsJ8sW2l3YHnD1K3PZa4jx6QTF/TB8KZszK?=
 =?us-ascii?Q?DLCF9tXNtUIRKiQP1ujGQLxj+R2yIZmWRTMfKVnCuwK7chO8MwDHgU3vNpB6?=
 =?us-ascii?Q?BSz+fjMNDUmNPbZYeEMcWgmq5L9wdbJ45nyq4WTDvNII2hSzhRlo/gv4kTW7?=
 =?us-ascii?Q?fNTY2fNUR7eI3/pjSkocBTbLc09J1G4mLtVtVLaKrbFlxkxjVxVww0gTEjUE?=
 =?us-ascii?Q?ktJr8NJPyVHFr3tatgplFBi7B7QRoFXoO33WKWdJaB1ynkC0np7iDd5+a/x/?=
 =?us-ascii?Q?uY6l6R/HuYxwKZVXeaCWuqanWEmkUPmFdHjqYjC/Vh0GvlIu4FLA9DoddiKz?=
 =?us-ascii?Q?R3xYPUMnYtzmMXaRSxAgFTCHYiO6hTDm3e9UEdhiJOMpWD0lMR3L3yhDzM1l?=
 =?us-ascii?Q?Bh29iDzD/MgQFX2HcGLGdgcxXOaOuMpmc72crK4k8OVQx1vXKEcvW0nvHqWi?=
 =?us-ascii?Q?kuX7OqelA7KTR918wp5cLo0Em6d+Wy4y3uzv6Tc102EAwvP2M4i6xCEZcorn?=
 =?us-ascii?Q?aLDBmSbXp2MNCkA4j24oT1l89iaAmSymGCwNj4E6JKiVNHIXXTONUFyehUYO?=
 =?us-ascii?Q?oy595UVgeYxIJy3DJNdF/Ta77An0YkzII/uVkgEGAUpxRy0EJ1qEqZQwogYW?=
 =?us-ascii?Q?Et+lkJr6VVkCWFEcuB+juV2KZxDxA8sNkZAy7IUM1LFncXkiCu3DLM9LpNrs?=
 =?us-ascii?Q?xl8hOcZD2zugSGfRMntRNl7vmucbog2YOTVPSkVep4ruRSj2TM+AMoiXxb4v?=
 =?us-ascii?Q?VI/smTUn8RCw1b/5hLRfBhyKt+L/fCvXh+CBPo+Ie/H9sKTUu/QIirDbmSCt?=
 =?us-ascii?Q?Rj0Vp42BWlS/pygi9ss4WMLNSQP7ixl793l4DsuNCltxZGyFz3iiX/b/xtXP?=
 =?us-ascii?Q?66+eFmIupvluwRCUnaLZmSZG7wHUrL86+gbM3hULzLx5RkmGcO8QYSlN44w+?=
 =?us-ascii?Q?SdMh6ffePS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q4rJC6tgFLS9b0IWaGrv3Eso63AkwwOzLKJBbz7C5rsurCt9mWzxYfD17fYT?=
 =?us-ascii?Q?N+Z3XZPxljIht4qD2OVET3rz9MDQoN1knozXmUacWtEwyNu8y1k6i2P18rdI?=
 =?us-ascii?Q?8YvJ1LysD8Y6Wh4mwqkw0qsHz5No5fODOv5/7CgoJyMj5aAB1cQRYB36LAoV?=
 =?us-ascii?Q?e0qxWdGHDWeOe+QutAFOQj7TkPZ2SXW7OjVpqO7KM+2KS7rqggEGDLWciL1f?=
 =?us-ascii?Q?JdkFnxApZLBNqvM9hGSbSPBoPEjhX3TxCJDgpsZqJnDuCJ0MN+9UCGneB3zA?=
 =?us-ascii?Q?jFlDnGukhqeCSNa8D1IlQ7IC4q58Mhg/Y0twOguVNpQRffiZJDbLyn4UjIZu?=
 =?us-ascii?Q?mn9yy5Okri4RMGlp2IzNw8KfaHL/KlnCNB0GsMTsnYLY6jKbyBHkwtaDAaFh?=
 =?us-ascii?Q?JzaSopQAwesttoGxZuD3TNkU/6RILgRzTaVfWxfn5x5daUani0Ds3ebKswT+?=
 =?us-ascii?Q?ju2Qz971FTRAlm140XbZ1b4hohq0YQ/FNJaosXNs39MkN+n646Z+xAB+AjH3?=
 =?us-ascii?Q?hTKBcUetdMS39hn7T5Wy9O05fS9Hv2ku/tg2qkSad+Fz97630SSd6jAD9hnN?=
 =?us-ascii?Q?FH5CW2H3OeVKx5P6Yq0BDfBErqvMDglLWcXeywm0XwGPIEJ2KzVTm6NY6IT7?=
 =?us-ascii?Q?llym3jJFoPz89Gmz3I62eG6A011AKe/hqUMbkT5z8+ZdMlslKYNhGYaMqXiK?=
 =?us-ascii?Q?JQwRFkf9dnHWhBKO6VyXbfdAEF54Nw6+jFyz7jMo4klFIhVjR2r56aqdAp8s?=
 =?us-ascii?Q?grydOloc7UkN+6aZSK5ZjjJojBOBfxsrk9jsNpT2FetsAZ5VOYC5BlnDS1xB?=
 =?us-ascii?Q?8Og6xcQOgAR7wNXIxerRPQTLO4863t9CXonSGZwOQd3YqFOAQH48BeRn5zY5?=
 =?us-ascii?Q?fwtQIG0TXn2mTm5LmS//v0xmLXP0AdYgl+u5qiYcPrp9UexrtyPKABLeRsOA?=
 =?us-ascii?Q?D+TsvqBkz6SNVVYN0gBFtPW5c3Fd9Gx+WJ87Ed9KAeyQ2qzZepYgZoyT3uyL?=
 =?us-ascii?Q?xWy/eWW8odTtWaN6nAahQ39tDTmH76eDz+GRF/C10e8MgtDHR7A6RGvpfK4B?=
 =?us-ascii?Q?BdpUpbdN5amGaJowCKDVlaF2hUzTh0f1MgUuikNmQy3UBjjsNdGid4wSZNqx?=
 =?us-ascii?Q?qn9qye4ihQ/tjCGK7idMiFlcEJknP6aIi4/1XLcHkN2JqVKavP6bgeyU1zyd?=
 =?us-ascii?Q?mRAnVukKMxY2X29F1EHRH6aqr/jJyLdNk/FlC3dNQfmUNUKuEJdMz1R5//fJ?=
 =?us-ascii?Q?wPM399eO+hBzqVivsAxHSYmhV/E6AR/i4RGnKHjQvTtFrFi2Dp38OpAnKbuB?=
 =?us-ascii?Q?DMWdgJxx11JLGwJBx0N5N1w0GmUz1Wm92+zfot3BlwMra9AXfFKRWPOJ+vZ3?=
 =?us-ascii?Q?FO1eGGo1trHQJwlzbvFBVA+UmLAuDxEtWTx0LIVPtoUslIR6nyeF0ISgJiFS?=
 =?us-ascii?Q?VZLJTHFAAD0OJbRl22QUaIPzNbpZstk+pNDbfl8ww3XkaVmqxp/EXQc/J4VC?=
 =?us-ascii?Q?plpDe6ZxGNdO0txqLzNi0syEkdylbWznuHslfTj9miK6y9tnTatYpNwq+EsC?=
 =?us-ascii?Q?0dy0z6p/bEJoQChIUZ03PIRj3n5cbUjBRNi2xc289nYB1QxL/8geI73Tl0vf?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8BDDJE6u8n19qQ9O54ipGf07oM1PO4CN4m8oQQLc56IdOCKT/efLKxbW2TMxJdTyMe0ClUcj2FEdJ5k5+fBA2F8DPdVbjVqVcv7VNINRRvSjn0LkkpXmre6ZEEDpHmBBqEewX8GgOszRkjXU+LS4wTonkwDH1qv9bKeeQzjG2w3QjvndEZMvo3+7YYAO7HvSnu1nDRT2x/WD1s4rwu8miFof2m4Eodf5+zDhWPMf+vsu6uZl983iBku5rcJW8crb7Oi2qivNfFplfC7pgDUs7noKhNmG5+46OWXX+8O1WBJFYjZ2Tx1faAz/w3ZXL2jBd04UatV/Hav8/wcu+Hg/Iz4BVUE0As5jglUBiQHoH3/G77mohijaoSEXYkneXBLMPO8ExzI4wwEspQ1lpy1JlRTO2kYgde8we6vepoef1rEoqVSpuqlzCqkyqpsQ0oSuPqNxEesCBMO/kbjxCqkIKxGhb2CLoPGsG8xaapnFnTDLo756jsEf4YQITwKDmp/jrcbIdnH2yIxpYvwL6EK8Mh3urpKjZpzYFhuaXqaD18AUVGpmqgDIfUOy0UYogTEfgYRQwhqgt0KgIUoYegEUBGfE5nzb1aj7xeNgv8KR438=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eefa14d-6365-49a0-30b5-08ddc3a91b6c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:08:43.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwaQO7kAPnEERpKiEzAmpHE3XXQT/DFO1R2ps2Lah/CHNb/OvdPwfp3MAdiCZBFNSCecmM2PRra5KWBO8zlKwvepbTsw2/wpMLEXavcbp0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyOSBTYWx0ZWRfX2SwL+ptqPJxO /xxfptawse6gIcgXNBs25k577F0o2R5JodB28RZOQVxSTfaQ44inBs5B9nB+NtMPsHbTmwfqVf9 zrEuKlDias7cl3aEYJGofZXSwYduiJ+Q/VXaDfOYrVM7uurOlcrh0wkqGEv19HhrmegH8t9yaxZ
 XMKqxFRIS06PDoOPyYvuIduBJU+Ah4mGZ1NFNQ4QOkvFgOAxNiU3f6+H9uoocam1+dr7TLPnQsO nLs54fSuGZrPjzp8tBGNrTGYt82USzg+zruvKIaBpBHSWMRHs2MNDnJulwRsEOPxqB/6eUA3B2V YoCFvW1fSHxC5/YXSU5zLiO6fRudKvQAAdiwam4zgKX8AmJPLz+REGFZhHpxHHYruy2PHPn1hgG
 xmzF/C8C0ga/o5YufyiqIx7gVlPJ8VvfCUC+ucQcq2W9IQLRIzM1wcmOrWrZg+jJVzYZn0P+
X-Proofpoint-GUID: -8Wo2Ccs7Ap0dzYSIsGAxdPPI6xv6QNY
X-Proofpoint-ORIG-GUID: -8Wo2Ccs7Ap0dzYSIsGAxdPPI6xv6QNY
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=687660ef b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=xasvYu1Dew-LyfKij-0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061

On Mon, Jul 07, 2025 at 04:23:15PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Move the declaration associated with huge_zero_page from huge_mm.h to
> mm.h. This patch is in preparation for adding static PMD zero page as we
> will be reusing some of the huge_zero_page infrastructure.

Hmm this is really iffy.

The whole purpose of huge_mm.h is to handle huge page stuff, and now you're
moving it to a general header... not a fan of this - now we have _some_
huge stuff in mm.h and some stuff here.

Yes this might be something we screwed up already, but that's not a recent
to perpetuate mistakes.

Surely you don't _need_ to do this and this is a question of fixing up
header includes right?

Or is them some horrible cyclical header issue here?

Also your commit message doesn't give any reason as to why you _need_ to do
this also. For something like this where you're doing something that at
face value seems to contradict the purpose of these headers, you need to
explain why.

>
> No functional changes.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/huge_mm.h | 31 -------------------------------
>  include/linux/mm.h      | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 31 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2f190c90192d..3e887374892c 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -478,22 +478,6 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>
>  vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
>
> -extern struct folio *huge_zero_folio;
> -extern unsigned long huge_zero_pfn;
> -
> -static inline bool is_huge_zero_folio(const struct folio *folio)
> -{
> -	return READ_ONCE(huge_zero_folio) == folio;
> -}
> -
> -static inline bool is_huge_zero_pmd(pmd_t pmd)
> -{
> -	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
> -}
> -
> -struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
> -void mm_put_huge_zero_folio(struct mm_struct *mm);
> -
>  static inline bool thp_migration_supported(void)
>  {
>  	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
> @@ -631,21 +615,6 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	return 0;
>  }
>
> -static inline bool is_huge_zero_folio(const struct folio *folio)
> -{
> -	return false;
> -}
> -
> -static inline bool is_huge_zero_pmd(pmd_t pmd)
> -{
> -	return false;
> -}
> -
> -static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
> -{
> -	return;
> -}
> -
>  static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
>  	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
>  {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667a..c8fbeaacf896 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4018,6 +4018,40 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
>
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +extern struct folio *huge_zero_folio;
> +extern unsigned long huge_zero_pfn;
> +
> +static inline bool is_huge_zero_folio(const struct folio *folio)
> +{
> +	return READ_ONCE(huge_zero_folio) == folio;
> +}
> +
> +static inline bool is_huge_zero_pmd(pmd_t pmd)
> +{
> +	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
> +}
> +
> +struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
> +void mm_put_huge_zero_folio(struct mm_struct *mm);
> +
> +#else
> +static inline bool is_huge_zero_folio(const struct folio *folio)
> +{
> +	return false;
> +}
> +
> +static inline bool is_huge_zero_pmd(pmd_t pmd)
> +{
> +	return false;
> +}
> +
> +static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
> +{
> +	return;
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  #if MAX_NUMNODES > 1
>  void __init setup_nr_node_ids(void);
>  #else
> --
> 2.49.0
>

