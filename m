Return-Path: <linux-fsdevel+bounces-59861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42094B3E6B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029081703A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFA533EAF9;
	Mon,  1 Sep 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YKXlvMrq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jlxa83v8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AF19992C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735819; cv=fail; b=W9as353fgXQ+QBXYtB+CjBXbOUeX3qs82AcAn3Unljba5WwO1RZW6VJuyjVvyvFPUKsYhHO2t9VcERCcY75xk4oNvmmvyeBD/QcxNI8ERyozz1iEX/8mdDy1BOJ6v7RsUPNgO0C8cJctga2puQm35m9pBpk2Mj8wLtKX6dMLfsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735819; c=relaxed/simple;
	bh=xfNB5CURUP8Qx+7PcKWBPN4vDp/dMtmWk+9qAYuSPeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nnXHmGMmetWtz3PMSWJ727YN5QjfY19zEIWNr/daN1cyF8WBiD7ubVOKsAA/eCVM7qk5bC80nspQNtndhvuAR54f2TUPb7pTkW29UHG/FntF2sp2gnrnBgKHA6HqhgA1bxt8ftGpAvGX43ofc1G8dtLSPi6N7kh2Z62QEL4cpT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YKXlvMrq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jlxa83v8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gBwr005474;
	Mon, 1 Sep 2025 14:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=K77xnvhqlAa1hwrp+R
	Ckb0ernvgM4tvhQgj8QfoVwK4=; b=YKXlvMrqk3DvL1YbN6wmgT2gAq4PYIBCAx
	OXV1f+0ssmXCpLYpLjTuDBDas8hc2NTFvLk9YIsJUpd+IazktJnx3uZ57zlLO/+j
	5/xBVX+xFQbU4BaQDxIlen4y/UkUWvsLsEjC7mD+xxWFulu1TakFt53LxNad+qqy
	LxRc42ap3qhq6C0fac52ff4Mzi7s0Qv/Q2+cxp3vq/QPx5xsk4SIkiu5CRF9zVqY
	723Wm4XdXicZ3OfHZ2BB7Gzbjn34jb0cKcClc3AQFJMO+Puen72VsX9+9Tp+gY58
	xdlTAYgv7qHRWllB48BHaJQS/V++e2l7+ngWW8sDQP5uE/e9eVqg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnahc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:10:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581CNmmv004190;
	Mon, 1 Sep 2025 14:10:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr85vvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:10:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF5nPd0r6JWz84uy4LeKFlPvuqlRqDbO/lkSgo/TfG7qYgcOsYYLfpp08XfkX8eCSiZ6oN5VnE9Ozv2cvgexTjxssqU4Or2FJbJsIzZTSLz36N5A3ks8q2m7DFeFIgBv8gvUwju5ckyUyzZEw83BlwkP0QiYnLCRJ8h1UEHPiTpTju01YUpUW0OBFJPdOBG1a5SH94mY6SGJH/zrmeqZeFSWJJvy0Rbw/yD1EeTluudM+x/XIrBYE/2AHQvB90NvOvjsh8FLENGkA/eRy1zLARzL/A3my2+2Q4L3dhzSak4P2jLLIHDp58creo8REo1UxDWi52BiIHXF/Aqv6CvO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K77xnvhqlAa1hwrp+RCkb0ernvgM4tvhQgj8QfoVwK4=;
 b=bNeGcs73IPmgc7x+2BvIVdKpdBK006njaI7xVWDqkLdwnpsICB6dk/2/kqDS495SiiOLNEeplsHkib1QPR2i5vK0yeIpdQ09+r6X8WVcq+i4LW82ZVdb4mSeDdwxvk5BZHcKbZZrz3MFY5bvZknWW+sRvFGwLSk1q9kaI3WHo7iRl5SOcWC81Cd6m5TPpEid66eJJwJ0KldzWhnER1LVcfROnqyw0595TgiOBwp0K3om/MswnIri5td6sHzhlyOV8Aa1FjzlUSG8rC9GuRb7eSLo+zxOp0s5UTG5iihC6ei65yPmKSVOp9JORsCLT38tYUN7oDp2mu7s05rAo/9o4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K77xnvhqlAa1hwrp+RCkb0ernvgM4tvhQgj8QfoVwK4=;
 b=jlxa83v8/Lu6JOGUOuu6ttw7Sx3F9WrzZh6B6kNxn2twU6cjTYmGBnFDIbRabs6zd2wWytlLiOXqMxHh1i+6U0bxh4AmjEcPZtKrncp2mm6yiI5xHSuUz1QpesnQiPVCVFo2CMHD4hN3yhyE8EjhUQ7tSYhUUIEIoFzYjYvIWXY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA4PR10MB8351.namprd10.prod.outlook.com (2603:10b6:208:56d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 14:10:08 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:10:08 +0000
Date: Mon, 1 Sep 2025 15:09:56 +0100
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
Subject: Re: [PATCH v5 02/12] mm: constify pagemap related test functions for
 improved const-correctness
Message-ID: <06b653a4-4584-4a39-af9e-2a93c75641a8@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-3-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-3-max.kellermann@ionos.com>
X-ClientProxiedBy: GV2PEPF0000662A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3da) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbe0a26-5b21-455b-ce12-08dde96141d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZZvioyApPLcWFKXjkhrPrdTyAvX5qq8bzHEvlCwJb/mN4eYHfPurGFZ1BKjz?=
 =?us-ascii?Q?VOKncm3wzrWWeASFFvjPOVmBJufq3AoZsS9ce58WS++DPaToIs7KdPpWO9M2?=
 =?us-ascii?Q?PeghzpM9rTFr4JaOm+3p2rVqKN3ey8KSQgVHyKKlGBhs0zL0yfsTF5vlDOEF?=
 =?us-ascii?Q?RIwjik+Xi5cbwqnYDSgAlmV7eEyFE+f0JWEDYn6HhPVnu4O9T/YJH/4tvt/z?=
 =?us-ascii?Q?Yb41Sfvp7TByJd4A/OlvvCguAvEwZjFsoi1YczzHbCtpEcKkjvK0ipZGTLjY?=
 =?us-ascii?Q?n2/SX9XbEcMajont2SGc/+wo+lw25ZUZBLe4G0PjFaLEa7jpRQS1bZzuwouL?=
 =?us-ascii?Q?tAriFk7X1lpHZYyD+hnkoSXi80V7rsj0+XQHtYWLLhM0pvkUJg8uGFr9Lqil?=
 =?us-ascii?Q?2kLbGwrT3Lr4DU+gwOhRNjRBcKTRpKHzFxwW+dvr2SAXeqt/ZPyBLe/1qdha?=
 =?us-ascii?Q?lT5J3Vpk39+EImm3cuZg9mqYIiRqT+FzeFoee7ObO7cfhgGmpxlC5WMtiZTy?=
 =?us-ascii?Q?c9drtUApof+5AE4O81XDnqbZC4vMlRn2WYnPSmNN/KdQNSaIlQc0nWJjnSb5?=
 =?us-ascii?Q?pTTua2fATZIu93FuqW7egoYNnPw7pJfkui3BKc8oo0hWy0wYRxDBB+1M1sKZ?=
 =?us-ascii?Q?WjEEE2QhsFofJkwK/h680tM4oUESmf4SGzis0QQiiUa5P++tSqXvQ6QU/USQ?=
 =?us-ascii?Q?/667jrIXvGmH+dXVJZF1P8uYUBtEJ5Kow11P+NWvXOfYGviCKuJgIGlaKIBl?=
 =?us-ascii?Q?by4bFJ5Ct6ccicqvXM+C//USoZxKGI/yHmVdFsIix0CT/ulu+ugJ6ngqfS78?=
 =?us-ascii?Q?CWmyYa9fDih+bkeUrAErdwZMSI8egBJ7MauHDvECbeViZaOS8tsKLdAkqhxL?=
 =?us-ascii?Q?mLpyU9FJPCwUyttSsbRFw3Kbslu7g/O+7pnQ0PrBuXsQRA/rpk3bNjZi/WGC?=
 =?us-ascii?Q?mvvEB1XfTcHbKro7hlgtdqK94GTfKKG0yADlmUezW09+JdbtbLblmXJiMWtY?=
 =?us-ascii?Q?PGegmpiZZEFtYFBwIoG2Me2fYkIGlEkls+s+dbGhb/pT0eZPgQR7mJJKNUSG?=
 =?us-ascii?Q?hF9D1Q4o/8gKacCcm9h1NNRPqyqEvrIMcZyyX1DoejQhrgPJm2Okn4hqyXSg?=
 =?us-ascii?Q?C6e7PfjagfOO95CUI76KisBti9B4i42aRlmPylflj0k26AvQLW5cKSUaKkcw?=
 =?us-ascii?Q?jOGUqyFwSu0wAf0HuI1O+YGYS/YDehz5/wxjeFiosjKcFSQATIjzsNU3hwFH?=
 =?us-ascii?Q?AOe8pSIsRDy2op/L1C14DrjyRm+WAbWHo2nZiwNH4DsZ/ZZ1+Nqw825TYX1p?=
 =?us-ascii?Q?+tOX9jLLseJZJwqNZVOSevESezj59mmZYwDQ1U96QkXPMKDpuPRULMCfpziC?=
 =?us-ascii?Q?dAK1P96M17zANYKi3OuU1VmJVPRnwosZgCfkNsy7FSxUkss6u78K51qvVxP3?=
 =?us-ascii?Q?mUQNsqRY48I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9b6rS3JlvV+BVuaOSqcXTaqIURBRq8RAu8v6j8eCgaTv2Uz+MkKG3rAqI+ut?=
 =?us-ascii?Q?P9UvV+g/0M6omrDTZhtqBbVqFw7hOjY4IZqT4+VVgqovIghcxckYhGUKKeLx?=
 =?us-ascii?Q?RC++RzDO0kau19P66qCiF3abwS3EUEIsnugD7M9lHscJyM4RiJ9EKoq9vHiL?=
 =?us-ascii?Q?oou3lqfVEHcQJXid9w+SSL5MuSNbwB63Fj434DFSVqeB4hNCziiZh1vPQ8o+?=
 =?us-ascii?Q?rw6pcWLuhKKiKOqqT1wAflcwQd//9laMpiKvZXb/INreBV76o1mtwEt/hXg7?=
 =?us-ascii?Q?zRfWr3JPklcnqX0mRFxp9j4koBtNOgrjuHtQY0KYLQ2jEJUuBfSuNgV4W922?=
 =?us-ascii?Q?u8OeM1YIUmeIRfBEV/eerel00UyM7m9Brb+OXtEPbfrOx0QoI8VV0JTEDNAY?=
 =?us-ascii?Q?AT3fDpLb4hzVzCMPBDnb9C1q1KpOSypjs/4pHxTdntmL8izoRCH2vUjGs8ib?=
 =?us-ascii?Q?6SKFh94tSL4IASxK01c0xkwC1X2atbjE9U7rhAlTGAOviZdINI7zSttgMVrt?=
 =?us-ascii?Q?9cLaJK40O5m+mUBFljvPLmw7X8DduPsFd3jELgU9iuDI1Gh2O1y8W2qtEFfn?=
 =?us-ascii?Q?bJccv/gF26ONRm4nQVEOhvB0c/ldiFNU+blWTuoAZ6I9Yd/u2F8TlE63pubV?=
 =?us-ascii?Q?AStP+31z+wae5ZIOOW63YbtOUZsE/QVMrUeVJV/NGnZHzSoG3uVZckt+Tvsd?=
 =?us-ascii?Q?DT/BAhHtkpqFzPAoVQmbD3eoSfv60iW7cpLkoG4uah6/p2vxl+OqHF78VsB8?=
 =?us-ascii?Q?G2qUdLGYwroJ9mTGcYNMtMiEJ5zpfyWvsCYTs1URR8aCOz1t0ckVpsQcaF4A?=
 =?us-ascii?Q?8GiOiaXbVlmXE0Am8GK73m49i3ntAguixlH6Wnj1J884K1qqvNaQpg6BEq0y?=
 =?us-ascii?Q?q+Df0EtjWpkKwyqkl3IVuAKA3aEqv6j6nR7VZpkmDguA5u0nq9WEd9fJM3fq?=
 =?us-ascii?Q?MwBXgwFwShWI8j8ufEzUd6Ovue7lKklT1lYCF7h1iJy7QRhL+p9ImAA+5nXj?=
 =?us-ascii?Q?pr86YyuyQRdBCosSegbuVs+PcIy+/NdeigRVFs67qV3GyuasTJMcj462j5/G?=
 =?us-ascii?Q?U0dcCZ1MFGC5ZH1XVDMUuGERGNu3NlNyChceO90V9vG1W3BBwu8XyDzpOL+V?=
 =?us-ascii?Q?bR2QID98pCSfPWoqqrJeSYZXuIg7q+X+yYZeEoLhFv/qqkFKftEEXcsDB3L/?=
 =?us-ascii?Q?0RgbhPw6SKD6M10V7VMph8R7L8HavpSz6Gn91emLfW3+r518Ns4vxGNwJM0n?=
 =?us-ascii?Q?YF3j/9vIxKS3eTZLO4/HwA/PRR/3YvpZd0aNc0WKJrBBPbDA7GQlka9Q9clm?=
 =?us-ascii?Q?hpQhqwLeGuqcuZZpSSR9r/gw/eBhWLql0QKZRRcKLcXR83sS+XCNKFyuuMJW?=
 =?us-ascii?Q?zmOylo1EYgbYrEsePN/V47D3p81iygxNYRoj3F4Z90gDCWVggrKfHwdUKdiZ?=
 =?us-ascii?Q?54T2u1Fz9ei5gnw/w8znc58U8iNTJaa7mkH2wwJL7A7xB0wvk2bfzAOvsS3q?=
 =?us-ascii?Q?NBg+FjGi9fc4kw5azvBhyBVFDPMG6F0uTd1lmCSjOCAuVOVKReQPwk0WixHa?=
 =?us-ascii?Q?3i/8ty3YzaYDH7fTqaIflT46Lehj7rpUNCR1PvvSyPNiUQxnBK40a0UBzT3P?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SrlFVAKkZCgr9oOEBSnOQD2FCVbkhyQWwWop6feMOXA2zN68e2V35Ffe7y8G3lYTkxvz3yZsSGjTK6xVgrfibkYiUdqfMnTjInpZJMW/9LdtnfZGW05vnzYbBL5xLhrsdK17mHXm89t2BpPcKjjPtj5qQsdzNTZH4REDFg+t6MJFzOkaa04W/8cvTxtMHI0qmfAZg9Z9bAhdldjwnEmsm5/LwT96V1bY2vUoIGHtPyN0ooikyrg5o1/fHGEiQ37y4F3tuUDH44NM2D+QnUd8C++kdlBldxOBGqgdndOON2XcgXFegVA0PlVQcL4KBvWVMPPaBQpr488eiZXYaFtNy+UEyIvH35plNFA8Lab09atlwx2B6tZI3Bb7DaQoV8WFRX2sKgiVTL3mMFTkVMYEPUMDOPKxe4UeI5ikx5F7ojJCQyXUPAS46Vxz1+VNMWSABGABzl9rWahAmB8Uq7njWKa6MyU6JimL8Ufvnib380qoi7DkiEvg9HCEnDO/bhw1SdKulCFMSXO6qFdCzrY5U9ipd+eXSfrbS3JplqGjjWjFsq/wg1KV5J4jDnxUFGpGOIqWr6WzejbZ1PsuyFQOTxjd5fLyWWRylU3PeLMUbZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbe0a26-5b21-455b-ce12-08dde96141d3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:10:08.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUhOnhXvWts4FzVi35nETnoEge7FiNAAuKkkxp2aG+HN2orvoygKiDFK7fKo3FIwPSYRQ0yY8eAZt37L6xljiaB0DmgzlBOfwQHw2UsSm3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010150
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b5a946 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=5MwDhDkeheV_mB3NFgIA:9 a=CjuIK1q_8ugA:10
 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: owdD9PcekXy-hVewcqNie6Q1Z8Yk95sP
X-Proofpoint-ORIG-GUID: owdD9PcekXy-hVewcqNie6Q1Z8Yk95sP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXxNtnm4KcIo88
 UQfJfZywsoSBuC5Zq3K4pSqn2CsgSK8BPBpuMFz7EWrKIGw8P+kPhXT+LjkQu3Txdn1r3tdAPvD
 FSGUR5iRCNZTCJ7E0S9heAuIHhHN/MxSrFQtvIw4s1wvQI6aWqIFiFj9gT19EpCJwr/tJVi9dvw
 Jo/A8vv4yEAA/fHwZRnlYvS12se1lrUSD8AN4AEo7sfuq4x/U96+T/wEUn8rEs63rdVxTnbY1VV
 QICLMfqUjV41wifUovFk8zFFiwAnMc58OSAUmXGCH6r1wWpJtJ31fyvA5HzgAIoes1wkRLV/ZHo
 IffAvhmvLXDhzlfildn7IsEyShAOhLlWKNa+qucmYKchnCGe6hZWVW5YVZfXRxe+F3HfjPfTDuo
 6HQN6UDG

On Mon, Sep 01, 2025 at 02:30:18PM +0200, Max Kellermann wrote:
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
>
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/pagemap.h | 57 +++++++++++++++++++++--------------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a3e16d74792f..1d35f9e1416e 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -140,7 +140,7 @@ static inline int inode_drain_writes(struct inode *inode)
>  	return filemap_write_and_wait(inode->i_mapping);
>  }
>
> -static inline bool mapping_empty(struct address_space *mapping)
> +static inline bool mapping_empty(const struct address_space *const mapping)
>  {
>  	return xa_empty(&mapping->i_pages);
>  }
> @@ -166,7 +166,7 @@ static inline bool mapping_empty(struct address_space *mapping)
>   * refcount and the referenced bit, which will be elevated or set in
>   * the process of adding new cache pages to an inode.
>   */
> -static inline bool mapping_shrinkable(struct address_space *mapping)
> +static inline bool mapping_shrinkable(const struct address_space *const mapping)
>  {
>  	void *head;
>
> @@ -267,7 +267,7 @@ static inline void mapping_clear_unevictable(struct address_space *mapping)
>  	clear_bit(AS_UNEVICTABLE, &mapping->flags);
>  }
>
> -static inline bool mapping_unevictable(struct address_space *mapping)
> +static inline bool mapping_unevictable(const struct address_space *const mapping)
>  {
>  	return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);
>  }
> @@ -277,7 +277,7 @@ static inline void mapping_set_exiting(struct address_space *mapping)
>  	set_bit(AS_EXITING, &mapping->flags);
>  }
>
> -static inline int mapping_exiting(struct address_space *mapping)
> +static inline int mapping_exiting(const struct address_space *const mapping)
>  {
>  	return test_bit(AS_EXITING, &mapping->flags);
>  }
> @@ -287,7 +287,7 @@ static inline void mapping_set_no_writeback_tags(struct address_space *mapping)
>  	set_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
>  }
>
> -static inline int mapping_use_writeback_tags(struct address_space *mapping)
> +static inline int mapping_use_writeback_tags(const struct address_space *const mapping)
>  {
>  	return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
>  }
> @@ -333,7 +333,7 @@ static inline void mapping_set_inaccessible(struct address_space *mapping)
>  	set_bit(AS_INACCESSIBLE, &mapping->flags);
>  }
>
> -static inline bool mapping_inaccessible(struct address_space *mapping)
> +static inline bool mapping_inaccessible(const struct address_space *const mapping)
>  {
>  	return test_bit(AS_INACCESSIBLE, &mapping->flags);
>  }
> @@ -343,18 +343,18 @@ static inline void mapping_set_writeback_may_deadlock_on_reclaim(struct address_
>  	set_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>
> -static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
> +static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct address_space *const mapping)
>  {
>  	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
>  }
>
> -static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
> +static inline gfp_t mapping_gfp_mask(const struct address_space *const mapping)
>  {
>  	return mapping->gfp_mask;
>  }
>
>  /* Restricts the given gfp_mask to what the mapping allows. */
> -static inline gfp_t mapping_gfp_constraint(struct address_space *mapping,
> +static inline gfp_t mapping_gfp_constraint(const struct address_space *mapping,
>  		gfp_t gfp_mask)
>  {
>  	return mapping_gfp_mask(mapping) & gfp_mask;
> @@ -477,13 +477,13 @@ mapping_min_folio_order(const struct address_space *mapping)
>  }
>
>  static inline unsigned long
> -mapping_min_folio_nrpages(struct address_space *mapping)
> +mapping_min_folio_nrpages(const struct address_space *const mapping)
>  {
>  	return 1UL << mapping_min_folio_order(mapping);
>  }
>
>  static inline unsigned long
> -mapping_min_folio_nrbytes(struct address_space *mapping)
> +mapping_min_folio_nrbytes(const struct address_space *const mapping)
>  {
>  	return mapping_min_folio_nrpages(mapping) << PAGE_SHIFT;
>  }
> @@ -497,7 +497,7 @@ mapping_min_folio_nrbytes(struct address_space *mapping)
>   * new folio to the page cache and need to know what index to give it,
>   * call this function.
>   */
> -static inline pgoff_t mapping_align_index(struct address_space *mapping,
> +static inline pgoff_t mapping_align_index(const struct address_space *const mapping,
>  					  pgoff_t index)
>  {
>  	return round_down(index, mapping_min_folio_nrpages(mapping));
> @@ -507,7 +507,7 @@ static inline pgoff_t mapping_align_index(struct address_space *mapping,
>   * Large folio support currently depends on THP.  These dependencies are
>   * being worked on but are not yet fixed.
>   */
> -static inline bool mapping_large_folio_support(struct address_space *mapping)
> +static inline bool mapping_large_folio_support(const struct address_space *mapping)
>  {
>  	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
>  	VM_WARN_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON,
> @@ -522,7 +522,7 @@ static inline size_t mapping_max_folio_size(const struct address_space *mapping)
>  	return PAGE_SIZE << mapping_max_folio_order(mapping);
>  }
>
> -static inline int filemap_nr_thps(struct address_space *mapping)
> +static inline int filemap_nr_thps(const struct address_space *const mapping)
>  {
>  #ifdef CONFIG_READ_ONLY_THP_FOR_FS
>  	return atomic_read(&mapping->nr_thps);
> @@ -936,7 +936,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
>   *
>   * Return: The index of the folio which follows this folio in the file.
>   */
> -static inline pgoff_t folio_next_index(struct folio *folio)
> +static inline pgoff_t folio_next_index(const struct folio *const folio)
>  {
>  	return folio->index + folio_nr_pages(folio);
>  }
> @@ -965,7 +965,7 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
>   * e.g., shmem did not move this folio to the swap cache.
>   * Return: true or false.
>   */
> -static inline bool folio_contains(struct folio *folio, pgoff_t index)
> +static inline bool folio_contains(const struct folio *const folio, pgoff_t index)
>  {
>  	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
>  	return index - folio->index < folio_nr_pages(folio);
> @@ -1042,13 +1042,13 @@ static inline loff_t page_offset(struct page *page)
>  /*
>   * Get the offset in PAGE_SIZE (even for hugetlb folios).
>   */
> -static inline pgoff_t folio_pgoff(struct folio *folio)
> +static inline pgoff_t folio_pgoff(const struct folio *const folio)
>  {
>  	return folio->index;
>  }
>
> -static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
> -					unsigned long address)
> +static inline pgoff_t linear_page_index(const struct vm_area_struct *const vma,
> +					const unsigned long address)
>  {
>  	pgoff_t pgoff;
>  	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
> @@ -1468,7 +1468,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
>   * readahead_pos - The byte offset into the file of this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline loff_t readahead_pos(struct readahead_control *rac)
> +static inline loff_t readahead_pos(const struct readahead_control *const rac)
>  {
>  	return (loff_t)rac->_index * PAGE_SIZE;
>  }
> @@ -1477,7 +1477,7 @@ static inline loff_t readahead_pos(struct readahead_control *rac)
>   * readahead_length - The number of bytes in this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline size_t readahead_length(struct readahead_control *rac)
> +static inline size_t readahead_length(const struct readahead_control *const rac)
>  {
>  	return rac->_nr_pages * PAGE_SIZE;
>  }
> @@ -1486,7 +1486,7 @@ static inline size_t readahead_length(struct readahead_control *rac)
>   * readahead_index - The index of the first page in this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline pgoff_t readahead_index(struct readahead_control *rac)
> +static inline pgoff_t readahead_index(const struct readahead_control *const rac)
>  {
>  	return rac->_index;
>  }
> @@ -1495,7 +1495,7 @@ static inline pgoff_t readahead_index(struct readahead_control *rac)
>   * readahead_count - The number of pages in this readahead request.
>   * @rac: The readahead request.
>   */
> -static inline unsigned int readahead_count(struct readahead_control *rac)
> +static inline unsigned int readahead_count(const struct readahead_control *const rac)
>  {
>  	return rac->_nr_pages;
>  }
> @@ -1504,12 +1504,12 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
>   * readahead_batch_length - The number of bytes in the current batch.
>   * @rac: The readahead request.
>   */
> -static inline size_t readahead_batch_length(struct readahead_control *rac)
> +static inline size_t readahead_batch_length(const struct readahead_control *const rac)
>  {
>  	return rac->_batch_count * PAGE_SIZE;
>  }
>
> -static inline unsigned long dir_pages(struct inode *inode)
> +static inline unsigned long dir_pages(const struct inode *const inode)
>  {
>  	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
>  			       PAGE_SHIFT;
> @@ -1523,8 +1523,8 @@ static inline unsigned long dir_pages(struct inode *inode)
>   * Return: the number of bytes in the folio up to EOF,
>   * or -EFAULT if the folio was truncated.
>   */
> -static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
> -					      struct inode *inode)
> +static inline ssize_t folio_mkwrite_check_truncate(const struct folio *const folio,
> +						   const struct inode *const inode)
>  {
>  	loff_t size = i_size_read(inode);
>  	pgoff_t index = size >> PAGE_SHIFT;
> @@ -1555,7 +1555,8 @@ static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
>   * Return: The number of filesystem blocks covered by this folio.
>   */
>  static inline
> -unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
> +unsigned int i_blocks_per_folio(const struct inode *const inode,
> +				const struct folio *const folio)
>  {
>  	return folio_size(folio) >> inode->i_blkbits;
>  }
> --
> 2.47.2
>

