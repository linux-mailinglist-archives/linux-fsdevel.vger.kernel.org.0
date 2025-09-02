Return-Path: <linux-fsdevel+bounces-59941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F33B3F548
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F051720FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3442E2852;
	Tue,  2 Sep 2025 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDmAkNEH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T/xKAXsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969752045AD
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794012; cv=fail; b=eOX7h8k8MnifPjx8zqvxZfp37Je7w16P9vUeL+EZCZBYuVDvv9aGuSb+QE34z81lRRMRn+RGpwbkHG2ZsNN63hpSD43c+J9EA8U9JQImdSayWX35xiVbSUq+iGmDgmh1fJZ0qC4GoQsaxRuY2Eotp9TEA9VXLM2vXuRRGta8Ks0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794012; c=relaxed/simple;
	bh=QPH3BSjyJYYsrRZ/Ek91uvkPzdBjzHO2duRajNlMfMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hO3CaKH0KWxS9bKnluOTARrzvZVrMRVI++wLJWhm873W9UBLLwRIEKBfqbl3EXlf839vVtVlYuFu8n7MzXwlKj1xqvTldG9teYlz6O9aYnJ2DtNJFXQnVhoCPRezq1tIJM+WumuwmVqUUVu9GFa0CS0N8PINGnf5iWaS7busMHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hDmAkNEH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T/xKAXsU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824fwx0013728;
	Tue, 2 Sep 2025 06:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VcmTPfbBh25aWGd8r5
	qS+r+uNAffq0URSjDSUJRGm4s=; b=hDmAkNEHWgCBsGzVYJtAAKbX9CRZCHiSFs
	+sKBhmscyWgLMAOmLCIiKakAYfxvG4W3jS/+SF+vZbW+BNom9MWMoLgPxJVSpE2C
	jiKZ/hofGtqtfdZQICXV1w3f9bEhLHmP/wgyP4r9AQBGQ5/yhWS+/ufKhMVq01b4
	uBgRVnubtiOPwLlCiH6EYGYi9sGZgGk1jkUw1gjD3549z6h4KHjUmvn1ZLde+LP7
	vwme5egBeGl5En8sw/b1t1MItA2qoDx49Vb6pFNT7RfR/GSyPTJP+jNv5z+mE2dy
	PEv/ZYKrPr+sa+H53KM7gaDyeCWuKudIiyXHbWTbE7PibzMCKGAw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgu9x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:20:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5824XZaS026755;
	Tue, 2 Sep 2025 06:20:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01mygr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:20:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gikb3rP1qol96jVs9Z/weDkAIXjzso28mWfhvOSDWY5tpEKyTPR+yf15+KuEtq+QXeyfeSJyIes7qTSVgisWVS1DAI/rgBKAK0xprBOicQ3Via1lrcCNvpvRIXs6SfDnqsETwjJQ8owAben0m5w3qpOqPBcExEEy27K9T9/cXV7QTH0/dOnYZJiEhAFHfE8jyrOQWxkWtxBNDXkoTJs97gC7ZHCa35tnClNTZeOOFhGidEkyVw85GjE7Vh057RllNO0TYJow9h+RsidW/4sxiOV6J1Vk8MIL5j+Yw++N5nuAoKMpD+oTXQgEdJMqFiaN4jbhQjOL5SLb5weWL1pD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcmTPfbBh25aWGd8r5qS+r+uNAffq0URSjDSUJRGm4s=;
 b=mY86PlOqPT0d4Tew6nPgp9DimUV9kjTEmMCJ7tVs05SFzmt960bAMaGKwS9/Slhou2ZmvPF3mNZ7FGLIsfqoQEB2Op4dLtYomipB6sFdb9ED4ZnejpdCYK3IdkhHVr037njTUPWWDLUIF4s8RzB7W8FuWt/ulVxV+e6aFnRxzc2oPof4xlfbFKmfcFwoviTVs3EVs+JlHiyxkG4EAc7Q400JW87qlxa+kpkmTo53SpCJ6kLgf71lmwFlzKFyMbUmjS65aKsMjnlI2WoUGDu8MhlBhcNhNFhA6K2BQqnJl9iNWzSKUZErjLpgAEbftcxMeRrornEhf5jKTyFpwewWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcmTPfbBh25aWGd8r5qS+r+uNAffq0URSjDSUJRGm4s=;
 b=T/xKAXsUkUcFbkPUVC1BS06fP3Ty+iYsrzgAsbiCK4d3uQrCYfYvF2andRELwQgpuzmArCoMaI9P2t9hf8ugjmMibLl62PCNKz1ugS3rj83XnKeoqC+xZ5MQPB5CpBzeHAaHnGRby4pLa7Txzsbm9x+SvrIqFP7qO84PSwwcRWY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 06:20:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:20:01 +0000
Date: Tue, 2 Sep 2025 07:19:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <76ec40af-d234-400a-af0f-faeb001c9182@lucifer.local>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
X-ClientProxiedBy: LO4P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b659b6-27da-488d-732d-08dde9e8bfb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UlMLdaRALYxuF49fM+PxJvwsdR9QEgH2PLjm0Yy2XMVnliBTkqEibfdsDhMc?=
 =?us-ascii?Q?rUSTVT+SFGr0dIA4K0vzyPPvKcwOp2bgezreXIMKjsLnp54av36UwZkELpLa?=
 =?us-ascii?Q?+NXqW2rlTuOpBTO/P/mxpbxNIE4O2AANL07Aak1nMGN9pDjmA1XSXq+p33OB?=
 =?us-ascii?Q?CflhavIJk1gtSWNgiZu7ZA3Hg6J6rbcXVCbQkJWupw08outbfJdBb/pQKaOl?=
 =?us-ascii?Q?UgXt/XLDB3hV4RLehQ0nkZv0TSnQU0tlkRM89sfyWuRyPkk2x/px2aMHPUDI?=
 =?us-ascii?Q?l+1dki9VwnDQseJIt7wFGf8nkCiQ/QVSH2NQgCQi9RCwr8mlQ/b+QdK6SKJy?=
 =?us-ascii?Q?cuP1S8WyE7Up0l1U62OR3mt15OYc3MTOtB/hEKx1laFwokIN+qAmpoRGIPOA?=
 =?us-ascii?Q?gdls1jLW1tAcxsCn4SmMcDZNJCp8UBrrIpkRFoVk9yqscctxyJ/pQgv7IS6f?=
 =?us-ascii?Q?enH3i9Vwbmf7h0un9JZCPceYunobwJRL1HGmNT2k3DVTAb8ah1HC9lO8Wp5X?=
 =?us-ascii?Q?KxnihON9uC80KVkZtNXi1rQCsRRKRbxSCoa3V+hpdt2G2Kh1T2r5CDUzxrho?=
 =?us-ascii?Q?OTB0eGqat5zZwJl4TQN6EdJJqvXd9aaaz3RmZPWih9Wui3RCqGEU3/rJvyUR?=
 =?us-ascii?Q?y1J6I5GS5BITnrtgMj0G9Aar7Lvvr7dkO4I1/45CjNwJWieNKlBanZSQd/bT?=
 =?us-ascii?Q?em2PmG+sHNTG0t8AdoNBd9uN+EZpb4VDdqTck+Iqc7i2Dsbf6ZZAkRnhzqb0?=
 =?us-ascii?Q?UbV2xK4zGJrZnJAxJ0ISh6TH9Og+cwLLoerEu8DqAknVr+FjGjE4ckpfXDgY?=
 =?us-ascii?Q?SE45Ze87mZG3vXrVLtT3NZfDqp6UrU2/L7gJCd7g4deKFmUNI7/XBbLoY1o6?=
 =?us-ascii?Q?8BNkCFoKA6Ts1HkMRsBTXlZFBf8GCOh9eBa8UKjTaL/W425jFF5RuErgyPh/?=
 =?us-ascii?Q?gHny7/IjAykeSVsn3ldzvfEzPhpVGcRXvzL0V74ONd4Tx7rczn93ikxDqxp2?=
 =?us-ascii?Q?at9wPdxzle7891LFGgVvhUgzwvFqQ/3gcJ0gglZ2BaI9x5ZLTupMuLB0B3nL?=
 =?us-ascii?Q?ux1driWfn/3FvCrqLsGtfcENv3iINTFI2LD2NFICxLcj6xMy2zI9lPWl4gvz?=
 =?us-ascii?Q?cVM5Lbh85MHw8RkFEHo2V/UlgxdvNns9KxOBsSxJHh9gX/vpSzPyz2yvqSZ2?=
 =?us-ascii?Q?CCRxHE+H8coE6WqlbXlPXjh1puD7Q6dRbMqifsAylSDd/dexL2TcAC+pFUqz?=
 =?us-ascii?Q?ewnij5mLh8K1Q50HKw6KA4MDxPnMsdKY1l+pHkEeBauqbirmz/nTrnIzf+8t?=
 =?us-ascii?Q?dkm1GeCLFO7N6eCqYEAvfMcLqFHWrj3ouhX3fCh99ZLN7D/T5VPuTTVs9GEK?=
 =?us-ascii?Q?Er5jYA8ajbsYLrAm0evJuOdaclMoS7oB4p3Cw+yEICFFanakyfnWDGhY4jW4?=
 =?us-ascii?Q?YFil93G7C+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ABLb45KiOxrrQQdWsHeXHXuTbUdQ7iqttV1vlHLdhvfS8YSxRgSKG7ehlPTg?=
 =?us-ascii?Q?13HOQ1qPELCw934tA38heKsjV7hUjnAJbsykQtLy59TzJxAhTVuIPkv0tvQX?=
 =?us-ascii?Q?kWjcWw2xaBgvumdcKXhhpifL4flKPiL5b9UvCj5gNLOnXvEV6o0oHqsuHXZZ?=
 =?us-ascii?Q?Z4ha9KeiZRVo49eUQvpzIIUHzjn80ao3mG+6SMpYZirQ9/zYW0IwMmIB2zk2?=
 =?us-ascii?Q?rpOlVuZapb93ztRBC6fjHbJGXm3H7hteGQs23poxAlZiVCzXsiDuatUA/P19?=
 =?us-ascii?Q?5X5UOM3ygAz8gl1SXuOWmjH8jQjet4BkuUpuv3UaM/Nq4fqu193lCZbFk/A1?=
 =?us-ascii?Q?cMgFVyLmJ5ESn24H2Z/Ew+R4hF0PftBlVoEAsq3lwjDHhMNHveAi2aelEmjc?=
 =?us-ascii?Q?odqIndSglNB9cY+DluiezfFY2I6tEoI64d0QMp/YcMvg/T72qEfK24bhpF67?=
 =?us-ascii?Q?Rq8OBNJYoihK1wSpVnzQ+AaQ088hQHIWvV8hccan/wKNbeHdmECjeG7f0blc?=
 =?us-ascii?Q?Wsa8zHMglBL8565rJky2SBeu1u3uueEkko/KxjDBRRYboB23Tb3OMXn8Q0qe?=
 =?us-ascii?Q?xIeRbHmeIv5h6Fgzg+kYz7QbrbLL6J6CMk17vFLIH2WqmcQwD0Q8erW5TsJT?=
 =?us-ascii?Q?OJcqNl27vQg0IBRkDYjFZd9VimYBzbbYeRXr1dTVLm27OSneOXcPPDk9RvrH?=
 =?us-ascii?Q?kBvh6p2jLS9KAKrmsGwlsiRJmfqqpK+RX4wXFKOICV2U4mHIf60Gaslcvn8y?=
 =?us-ascii?Q?x5FWksdBtyjRhT/VEeXUHVVDXjb1kpk28EjFWpIPoHJBTa9QlWiVKjkzx1M+?=
 =?us-ascii?Q?LQjhPlD77nknkrTb/4lRxcyRVYCemckZQ0TIy/x63RWdlS1C89Lz0pN4otJi?=
 =?us-ascii?Q?qsbIDYUpsvAGmW69OvtQDZxOaYC2MfJ5BS6bZF6vnErE6PTrdQto1Bs8s9eU?=
 =?us-ascii?Q?R8yGp1XP18dbj1VXUzoCeGRIlt7g3LycG3dV6slidFS76dk6n48e5sFX2MTe?=
 =?us-ascii?Q?QiBrg1b6kuPj1CoMHs5XqNQ4MUvmm2xU1RvlthMmtGWusB8QIVvG/JIMfmLu?=
 =?us-ascii?Q?Ch8rB4+tR8mz2+N/v1xZb2IMnICJgH6jm0hVkNyxDb2flgAvjatB0nU4YlVv?=
 =?us-ascii?Q?CkGRYJBSEPq8UAOHolINR95yFOjkZtKhQkQalufhEUfJCcLvqBoclVy73Qve?=
 =?us-ascii?Q?g+3wfpvlwiSfJe/2ZxhoJ3DgBy11pfqH1qANHF+aduaoZbvk9ibbYlF5PbOl?=
 =?us-ascii?Q?Rp3Si79OOLpW+VqnZvBbeMFy8b8x5stdsL1wrBaMdhLAA925aQujog89qKmm?=
 =?us-ascii?Q?pDEupr7cnvjKlQ3n6qBvVHwrQpseeEug8YTnHwUoNyPL2LrCJgogwQE8OoID?=
 =?us-ascii?Q?Z8aLF6B8TsAfjEd8rcOqeslNwVTLZbqTmvhrW3nP9fSzGbBf1BAwLGd5QZ8d?=
 =?us-ascii?Q?6EnkrVGR9NmTNm0k45J/ugGakMjAK7Dh12eQ5JOB95VWljxe73pX/5HobJe3?=
 =?us-ascii?Q?HrzR4ILetXIa7EF6GPZGQZaSJhKB2At8F0NdGD0dBbMUjTScm5rOusmz9Jqh?=
 =?us-ascii?Q?rzKGZXrOCBojeHVyVm5ujYAsKLH291NOuMq5joSXSkCjzAKlYj9yKGfOBy69?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tKqloIeJ+3JTUEUBHwC7cL0jDGndcZ2zMh8s9ogacvnPn1A3mzTXHlnDGcQENccrDciDHrLyvV/6xGQmkiu3nN/5QIDKhAPlYoPi3CYAEPzqwU83QXwlNLWnEr7awRUBgv2iBt14PMrS0wA7zBKy+hX0yrXCyzG9c1noYLxWKh8Rg0G1oFVXmDuUwSbp87p0fVgGUtOEokKKtjzu/v0Q2YTbfhE+wX8aDDs9RWg3G6VLexpAV4JZIKZ69125ZcDTFFvs9PUK1DdK81ozdenoJlX+alzK9wHKXSiTWgthVlKt/EU9q5H2CvcmI5p4RgV5ADzk7q1PEE/STSuD4X6fY7Ofg/aP/1g2XKXFzywTw2ZDQ+0CM19C1mc0qUAjIWt5xZIIbGmDWz9QvZ5E9Z0j5za9KX8dB2bX23O3vJERwFo+BPiVC5hYlZ0x4zk27FQSWKjAIGT2HA1CZy58OZc7M6EY5bGF3Qb9S7rggm46KD6Q+UTtLY9NATkNn2h0+2h2pXCMx5uGOPUDfzbEAjgulIY2UnvyfbAVn2NSS/gIcMs8YVUadhqMeSMeNr+5SNVRmzfr7bE3FJlMDvISt/0kc3Sj+2kz6f3mXjYU9ebG38Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b659b6-27da-488d-732d-08dde9e8bfb9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:20:01.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIMBfVWxTiIdSL019bIs7WB7NczJy7Y5gwx9+nxBpkGpjDzVDDnwU7fNldFUfJdqtykOYJalEHaEIDOOlBqM6XkhsmBeknsIN6t/6JTjtuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020061
X-Proofpoint-ORIG-GUID: JXIAwwkhieywVhFcBqtCfUTH1_eODFcY
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b68c97 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=UgJECxHJAAAA:8
 a=lHmRfTpA4gC-4aNflXMA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX/VnYiMa3Xvnq
 nuqaz0RA3KMjdn0UnjN99lxfEPNUBBrGFobKVwgJGX51MuefitdJ/QdR0kOR244dNTYoCsOtXYe
 VJUK+gycN/BVaZ2oQwm6ygyByf+u0Btxk+GKJ/r08qMLEMozifpktCeoE5fYZuMr5y9/C0gbt5P
 VH6v6VVLeqS3w1K6mSabD0LZgkGgCd6OcE/Pi5hPlQx8OcuspMvqscv67Ktsqyaz9jpzdo5gNF4
 ubIngS/Ntqt5GY9wAepndL6hr0oRwoJ+X2Yo2tmpp2f2yunlS6WQDUpTKtrAsv/bufuJebaaiYn
 /nhilhP3Z2kPgyQ4CZgviPqwvsWa0oGwxN0YfKctDWJBPhT705PP98yrfFYHlabjswZirqFb5fr
 XnoQ7MNw
X-Proofpoint-GUID: JXIAwwkhieywVhFcBqtCfUTH1_eODFcY

On Mon, Sep 01, 2025 at 10:50:09PM +0200, Max Kellermann wrote:
> For improved const-correctness in the low-level memory-management
> subsystem, which provides a basis for further const-ification further
> up the call stack (e.g. filesystems).

Great, this succinctly expresses what you want!

>
> This patch series splitted into smaller patches was initially posted
> as a single large patch:
>
>  https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/
>
> I started this work when I tried to constify the Ceph filesystem code,
> but found that to be impossible because many "mm" functions accept
> non-const pointer, even though they modify nothing.

And as Vlasta said, this is great context.

>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Glad we got there in the end :) hopefully having more const-ification will have
a knock-on effect anyway for future development both by:

a. People needing to ensure it downstream of this stuff &.
b. Seeing the pattern and adopting it.

So this should have a positive impact I think :)

Cheers, Lorenzo

> ---
> v1 -> v2:
> - made several parameter values const (i.e. the pointer address, not
>   just the pointed-to memory), as suggested by Andrew Morton and
>   Yuanchu Xie
> - drop existing+obsolete "extern" keywords on lines modified by these
>   patches (suggested by Vishal Moola)
> - add missing parameter names on lines modified by these patches
>   (suggested by Vishal Moola)
> - more "const" pointers (e.g. the task_struct passed to
>   process_shares_mm())
> - add missing "const" to s390, fixing s390 build failure
> - moved the mmap_is_legacy() change in arch/s390/mm/mmap.c from 08/12
>   to 06/12 (suggested by Vishal Moola)
>
> v2 -> v3:
> - remove garbage from 06/12
> - changed tags on subject line (suggested by Matthew Wilcox)
>
> v3 -> v4:
> - more verbose commit messages including a listing of function names
>   (suggested by David Hildenbrand and Lorenzo Stoakes)
>
> v4 -> v5:
> - back to shorter commit messages after an agreement between David
>   Hildenbrand and Lorenzo Stoakes was found
>
> v5 -> v6:
> - fix inconsistent constness of assert_fault_locked()
> - revert the const parameter value change from v2 (requested by
>   Lorenzo Stoakes)
> - revert the long cover letter, removing long explanations again
>   (requested by Lorenzo Stoakes)
>
> Max Kellermann (12):
>   mm: constify shmem related test functions for improved
>     const-correctness
>   mm: constify pagemap related test/getter functions
>   mm: constify zone related test/getter functions
>   fs: constify mapping related test functions for improved
>     const-correctness
>   mm: constify process_shares_mm() for improved const-correctness
>   mm, s390: constify mapping related test/getter functions
>   parisc: constify mmap_upper_limit() parameter
>   mm: constify arch_pick_mmap_layout() for improved const-correctness
>   mm: constify ptdesc_pmd_pts_count() and folio_get_private()
>   mm: constify various inline functions for improved const-correctness
>   mm: constify assert/test functions in mm.h
>   mm: constify highmem related functions for improved const-correctness
>
>  arch/arm/include/asm/highmem.h      |  6 +--
>  arch/parisc/include/asm/processor.h |  2 +-
>  arch/parisc/kernel/sys_parisc.c     |  2 +-
>  arch/s390/mm/mmap.c                 |  6 +--
>  arch/sparc/kernel/sys_sparc_64.c    |  2 +-
>  arch/x86/mm/mmap.c                  |  6 +--
>  arch/xtensa/include/asm/highmem.h   |  2 +-
>  include/linux/fs.h                  |  6 +--
>  include/linux/highmem-internal.h    | 36 +++++++++---------
>  include/linux/highmem.h             |  8 ++--
>  include/linux/mm.h                  | 56 +++++++++++++--------------
>  include/linux/mm_inline.h           | 25 ++++++------
>  include/linux/mm_types.h            |  4 +-
>  include/linux/mmzone.h              | 42 ++++++++++----------
>  include/linux/pagemap.h             | 59 +++++++++++++++--------------
>  include/linux/sched/mm.h            |  4 +-
>  include/linux/shmem_fs.h            |  4 +-
>  mm/highmem.c                        | 10 ++---
>  mm/oom_kill.c                       |  6 +--
>  mm/shmem.c                          |  6 +--
>  mm/util.c                           | 16 ++++----
>  21 files changed, 155 insertions(+), 153 deletions(-)
>
> --
> 2.47.2
>

