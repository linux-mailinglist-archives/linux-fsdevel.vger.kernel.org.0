Return-Path: <linux-fsdevel+bounces-59865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA97B3E73D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3589A3A217D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3172F49EE;
	Mon,  1 Sep 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UfTBdt0y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Myw95xqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2A20468D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737195; cv=fail; b=A54OD+NdwfFVx1KyH3eBs3YnIcN2hbHcsTLX5EYNcfVLvbvUAJgaFkw8DBxDxAySPE1UTEEW4aIuFDSj3QiEtBg5OCS4LJ1X1QVyERCOFGATnE/Fz3Vc7comaGRY/vlHYYJOaAi9VCY1cnxxJLAckHiRWA76EV1Hd2PKvXcri9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737195; c=relaxed/simple;
	bh=KIo0qdLGhM6/HIydZwRslPxpjPhGfZQArJMxVICcwFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E/HG+3EPLF4omB5OHERdE+V6ioI/jhORQskjFrIIWIOy3Q+4A8CbSSqJQX1yxuenXWUMFmI8Xx4791eYgTezPKvkzofp+phMHBzetjWSDD2zoccOhgOQYEinpm1ADCArhNkJ2Zgz+X9IEuWpBcF/vzRgk8XVp5gWxx5Bgr4wXiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UfTBdt0y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Myw95xqN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fsZS015605;
	Mon, 1 Sep 2025 14:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Cj7H5l71z7n4ab26E1
	+FSdQCJ4yVGBa3bZL1TiIPLH8=; b=UfTBdt0ynsByWskip+i3k9i+AZXjrYOJ/O
	a1RP9NehIZHSP/5RbWlKc7q1LBr3xURmFfxyDkWukTbq64Fukyk1oUD3Kks50FHt
	xjvlmxzhGpUwtEcdP9YZ1XKut7bcCIRy8mwLMmDPsDgPGZwWRpnJmJ//rX9EKm1r
	ENZ2A647E3trRQ0TiVslsDfEgREGqAoxq5hG/MFnru+/gvRwIAiTI6Z9VaPfKjPk
	WZSRQc1PDWImGhwyHiCOdt1kaSEIm2x0gSZXGXKEpmHGlBoCYVz6F+csHHubQ9Kz
	03p4+jqBc2R3vU9HT8SI5n9qyz6iWDgOI9wpmdkYtODbbp8dqSmw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvtjg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:33:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581DjajF011674;
	Mon, 1 Sep 2025 14:33:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqre7mth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP8hy09sPHMfTUGHdDk4m3hlOhc/OiAOFD39FxKCJKH/BX/R8Cl5pbqfJo507hx4pypdkEOck2F3Z8LLyrs0M9BCZGxa6rWV1KJ6EO9PHO40PPuIUWEygPvPSX/KBwj0ddKs2+9o9RZiFwV419th0qlWzn785hmXLAmSeK9cnzZvgSPwWBEN0LsT80zsslqyggBT0l/1V9sYgArkJkPUE4ZAB8zpAS94Y21nvABT1hfoE3mnolOuvp74JNEhGxLRVR8INO4WR0wnzEkmTnDI1+mSJOuVcD0JHPO8hXHiUHYYrxWLt/hOn9RHw1kVrBNKP+Y6sP/ILIeSkDk1lWQm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj7H5l71z7n4ab26E1+FSdQCJ4yVGBa3bZL1TiIPLH8=;
 b=xGLTO+RhKSdkbT83y5MlzicjJ+z3MKX1LgMEfxbdKXpDLni2MpUSs2LeL9ApRRxjQC8KDcbNR+S6Gzw4BuSVGiLGKu2Ca+iXIXKrutx5MsPMbpzGg92EOK4qXKiufg/XFTLhjzJiS6udvn/svFH8ePvZahhrzSMUYa6hlvWvPuDZ3JUndxVokZb0PztU2eMD92Q9IPubxuCS9nP9XKz9ieUtCvClPzJlPvGjGIxdjLbBGTxmksKRyeJuZsvDy5dx92+wdsi0yeHOenf2FcuDOiwJ2C9bXQfS0EmKBIhH4QYZtINXfP3lkiDo9gay5/uyaameIrxV8aJHMogsyTByew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj7H5l71z7n4ab26E1+FSdQCJ4yVGBa3bZL1TiIPLH8=;
 b=Myw95xqNDuQhfUixjBD9IxX9A5JziNXhedjtI6BHDB7lCo7Dn8EhE0hqqfGKXF0sjkNdhrNjBF2kHcUKiYYcGcKCHIcY3eOqLwdJfLBNYgzv3DTF5M726kDe/7t3lsV/LjVnA50OnQu/D81xFg4tfsdPrtds1dbEE9PcYj9L2RM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB5157.namprd10.prod.outlook.com (2603:10b6:408:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 14:33:00 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:33:00 +0000
Date: Mon, 1 Sep 2025 15:32:49 +0100
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
Subject: Re: [PATCH v5 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <16d2d53d-a2d0-4cd8-9323-eb91ba51b061@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
X-ClientProxiedBy: GVZP280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::12) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d061c4-de37-49bf-08c1-08dde96473a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?whuhX3thdaEqR5rSqYlLIb/ufhopzcrYL3UbEiRMyzt9cXVXUmZWwiiNme3h?=
 =?us-ascii?Q?3p1lmQE2tqPhs7iXO+vO+LOkFQBTKff7zK3jiBd9rjOn/NBuWWpsDnyFN10S?=
 =?us-ascii?Q?dAP4mKParWOIEVhLgMehoKgtomxujPrMHqBqrRd0oGHJMzBetH7GNqDf/2Nj?=
 =?us-ascii?Q?fnlNAeRZqmdGyDneX8K/oSYMqk5X5glIcMNlAdJbt3ylkohyt3RgycL8mfQX?=
 =?us-ascii?Q?Ryr1nUAqshz3MtrzK/dpYOcy6r/rJW44+qQpE1sHJ9lUHkH+tCpHnWXyUVYm?=
 =?us-ascii?Q?BuJ+YQ6fTHGYlJT/E34PW6s6JPvOFONufUn1ZoV/qfAnl6/OVESsC/4KEddc?=
 =?us-ascii?Q?WZ6JThCrkFTLu8w1Cu3pJe2buc5gUs81LbBP9/VCsm8jO1H7+U73FS1QEGnu?=
 =?us-ascii?Q?zFV+Zj2/oFe/7cePzRfZCOrOLBBwU1F06nIOsXvYgdV8yu16WHJUpcYXADbd?=
 =?us-ascii?Q?/d1Re5RlOSQYcethKo70XQrBrWWynrgLpx1rGmembqhA2eDBJqpCNa+DnmwO?=
 =?us-ascii?Q?OGK25m72DyUgqqwPpwvpcLWP+XUtXbuQl0UcRMUJl4p1Y8yIzKv+Wjc8LFeR?=
 =?us-ascii?Q?uaoMNAUVowAuDIXpVwEptrmblX66fTNRtjN/eq3u6W61un+D/7XUNsahhZjP?=
 =?us-ascii?Q?Ci+1EuS/L+wg3kuiBu/CZaQJs1y2KMfMBSH2mozAdAvekEtpwfBWEL1gGX3L?=
 =?us-ascii?Q?hB4iLf3v1oKegVTS8doQZnot4k5G6Wmofm9gh/8+1/s1G2V0GpNw9qfqhcfQ?=
 =?us-ascii?Q?rmh6ORAUPQ1Xxc2qXaE9YCFDo0Pt3bdSqMSMdv7ztG5NuI4lVHX+yxcgAZLe?=
 =?us-ascii?Q?ewE46nJXDLEAG8w7x4uferoYUMcuuaRMz3bovAPYYu9wyCtQm20HXJBB87ED?=
 =?us-ascii?Q?+cPIBKxYFCeSSZ6+8jCYasSx8CEultofClcc6gZc+5xWOsD8WMHxcp0Z+ivH?=
 =?us-ascii?Q?wYEfB9iwonhgUNCdA8+3RGRQXZ19nkuV1vh55KtsCS3yily5Far+bESwpVWx?=
 =?us-ascii?Q?zqbg9hzE5QTwRR0cAoKurC7Nu3gdLFVWFolvRlRHPtuA/7TwxYmlF9s82sR7?=
 =?us-ascii?Q?N+3wGTahRSzTpbDI5Lp/OaliITtx3T+RpNoEzSbt0srI1R/n5mph3ihETBqY?=
 =?us-ascii?Q?FEuTmsz2YGvHTm6NXNfkWIzl52jwNDN04H5qSIkXcvuXBdLV89ZjjIl8tLAg?=
 =?us-ascii?Q?W28uL/q34OJXdkhFyyjzQxZsIpq2BxQNra8dTM2LfhOtEBgMnLTA21Nqqvjp?=
 =?us-ascii?Q?sflGJljyXVSb5OopritYz4RICfNLBA5KXLPvPBVaW/R4huJh0ncp7XqeaQWh?=
 =?us-ascii?Q?20AEvEVi1dQUDiu+3yn2QHoHzfx2Pw3dgC+VqIznrd487O/0DZz0zjAGE9RX?=
 =?us-ascii?Q?8MtTdF/lveyZWQYZy9Xnx0Fj3jjjjn1bw5xJ4CoWqaJjxKBgmwpkS7osnbDg?=
 =?us-ascii?Q?cjB8K/p5kGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hMljCElO6zygyLvEh/IECnuJmWJcvZS9qdJ+wlWdKgwSE0eZFYHHbPsOosLK?=
 =?us-ascii?Q?nT3YO+tcBrjJhiJn8tCztf3NMqGg4yIq1Zithi4gUZDyh2gR7rDHAH9w7+9o?=
 =?us-ascii?Q?+GF0jhpoaHsztaAnVrGo3ihCVQhH84r5Z3JutZdaZzsFOI7DN/T9c92Wcyh3?=
 =?us-ascii?Q?dR+73FIpSoagRy3nddItRSdUDRy/P/WT6Xls101c2SVRT7df5sGX8tK6Rpac?=
 =?us-ascii?Q?l9OoiH0GZPmuQyZMZUS+CQJ4354b0ivFH+6oRIWErv5JWoZM1OavDjPi5m6/?=
 =?us-ascii?Q?DdQQkVCIfLvBKebrXbDN4bmcoGNyE9z9I71EeglF16DyhCePzHDyPX7/0ILp?=
 =?us-ascii?Q?Mb7uR0l2ISpeV/X8muJJyaM+4h36UeikPjSs03TkC7IueA77EJiyN3I2eQyC?=
 =?us-ascii?Q?ir/1SuTyjfXT50wOnOiew3LM/aEZAz+lgPpt+xNECBPPXILUylh/jTBoTReY?=
 =?us-ascii?Q?we69DG9vaoQ/LEMYoDA7I6oc+faMGI33KB34BAFNz4pTIu3wUEMWSTpTMKU2?=
 =?us-ascii?Q?hZDoBGC5qNbZOxW05vi1xv9dKku7zC4VSbHprVfg6QE/nWdkBLQWcqHkYm1V?=
 =?us-ascii?Q?KDbXfv86pCmq0PGDia+hu/SYUhq6yqT4bgWwo8h0MqKwgIuOyWs2506jOVck?=
 =?us-ascii?Q?5oW5ho7og8k2/W0dTDA/B/w8UhehwaUrrOxbwPgHfQ9h8bH9PJ6fQXp+jMfL?=
 =?us-ascii?Q?bz+kN/VCG5w3E43CItdPQwZEb8Wj9vkxnyoyilbO5TiDFAymabvEn3pI9C+6?=
 =?us-ascii?Q?gSyI7LfJbWu3k1iTYP3C4eNSWENG4PGL1D64l/tfrEBtHQQPu1t1oMQSyf9a?=
 =?us-ascii?Q?6j3x6o/R40GcKcYrggymMTXwskWdflfgo0FL5bFW3sMp4dNeBqM6MAcKq9W4?=
 =?us-ascii?Q?z9Vad/OjImO3iZJUFx9gYzL8SCIVUxYTmHgE0Brh+VnjGwmrnlf48lYE8bA+?=
 =?us-ascii?Q?eS9FvzFnikERO4YvvXeM3aczzI4weK/+wYWqc0VR1+vwen4xtyyIHyvkAj5L?=
 =?us-ascii?Q?ie19h3kkGbEwYtNBcDYINgxkoqq95UTXFWSdi8V6STtgMcO/mQhYTT+0byuC?=
 =?us-ascii?Q?temAV1sG7gV5Nur4kYQCA+nC5y0JWgwX+V5JHRVe92GKA/kWPd5ben5Rjv4I?=
 =?us-ascii?Q?rXryU/1Y+iM/NAaJyZZ7U3grUfIdf80BkzwHlvpxP0kFF/+FMxnN1VIxJuk0?=
 =?us-ascii?Q?sTWA1Jyki+9Y6NX9NheoArK38P95hRzyVTUZjrEFHto789Gy7uwEjCO35FQC?=
 =?us-ascii?Q?LWdEjdjxsZgxVacFmFlW1Y0KRWnQHW9HT3Hqf1k0chWJRjJ1OZqpwqbKcKJd?=
 =?us-ascii?Q?oR9sbzRv3aCNrfdoPCLEOBsZzIRDzITTWZxh1JM7HbOpCcvTCsIqh/Z9D8Oi?=
 =?us-ascii?Q?RdWHDgaQMrDF137Nb2h9oInrJEAJzDQHfcYCGtXWxQgGWmWpD5CV40zaCpD7?=
 =?us-ascii?Q?o0d0jm8q94Cu8MrzF0ut/WZDRlWtsdDsyv9shrUSs4CCJMaJ50ZlaPg5D+8s?=
 =?us-ascii?Q?LTvEpi0alKidM+YRP3HUlrqgKBwD1XzPO92PICaV+Xh/kCYR4ek9TnugCI77?=
 =?us-ascii?Q?UyDroRIiZvPi4lAyRjp+xOioaY0UtjXVP0yM5hhizlicil6OmUt3bjoBby/s?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HSxoTy8zqIZ/KYwVO4uQ4L1sWPeka8GVQcp+gm5bmD7koql3ibLAjn7IYdi9TThHShxpVOuYEgGh/BYPcgip2vxS8LKx/iu4Gj63zPdumb78Gxh01FNRiHSKtXI07ofsd3CP5iWcjCQ2U/lPSKyEP+ra+as5pNdDZ7ZAs8341IBmJSOLB3yJwQ8ms5Fnt/4rAhBrpRk1/mFvqX23Haxh6/3cnYKECyYPBsExbw3Kt4NLJJuzmn/CUwAip4UiEIiar8cxlS3Vmr5hf34/iOFIJ/qUx4/ujM7ObMezabLnwi1UZoGsxausy0FbbCfeZ3q6Gqa54hLZ7fSc4beSpT2mTN/gE+9k7pSSsdhw0Af6Wtn2IoNG3+JIp1eYUD1jORC5ysQHGOrEyNtPNGXWR/mYtsRHigqg0PZ57LiAqNu9QAnUW36rqJjhITCuRu+kqH1ACNXlx/IHGvJYsYlu5rBxwpaz+Q2kqSZFJYrorrlNO1gINUtOhCe171dsC1ejskM5/6E0N4FKlzLMWyArG0wM19KaDwRXHIQmQXMI4UKvuj5WBP6xQLor0uAF8ORk1MKCUiWeaJFIJNZsAVY8ttLL1NEv17Pu5+GWrIBzT8xzWEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d061c4-de37-49bf-08c1-08dde96473a4
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:33:00.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdSaQDiHCalSlC5c4KfpNPeyk2bsC/Bavp5Len0Lkac5KmT0vE3/OLMXl1pepEm3lBsCo5dWZcGGV9QNpzB4mZymkwa8pWJHoZUknhY9PZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX/BzRwyGULE+6
 DfnnHpQ/kbLpawrkhEfebPYrXF5QM4HaYO9An1B1ik4yFaJrTORNj5/5b66FfO4Dbda1/LVGaxU
 SXgYukVWk6HvDX1T0yhCJP6XWFd86E2VpdKTsEtS7fyFzeH99Yna1kqsN5ZceWDqJgxLXTXj+FE
 2SggPL/GLjyQzS2xtvu/s7k7NhtvNoYe9uHpMtn8V4ybOSLhrnZ8/g08D2tUQ3c9UNMIvKKQWh1
 vbFbZb0M43hrBkslww4drnWjKepIa4GULHKlySQjo6P4mXCwzcKppiMFLdCFwcn9M8dOh1akDI0
 yruDD+QTryIJI2RNVbF4xeRRFin9DVOOS5hItorlFGr+cyoYNwDzskG0lRuE2XNyWC3T2wmsURd
 7Rm+d1ZvpAd+MUlXrf8k/OsYsVCMzg==
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b5aea4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=UgJECxHJAAAA:8
 a=K2KB93EhwB_LE_f0r-4A:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22 cc=ntf
 awl=host:12068
X-Proofpoint-ORIG-GUID: y4s-8DrJQna8z0Z99nwOPLNJsUKb0MDW
X-Proofpoint-GUID: y4s-8DrJQna8z0Z99nwOPLNJsUKb0MDW

On Mon, Sep 01, 2025 at 02:30:16PM +0200, Max Kellermann wrote:
> For improved const-correctness.
>
> This patch series systematically adds const qualifiers to pointer
> parameters throughout the memory management subsystem, establishing a
> foundation for improved const-correctness across the entire Linux
> kernel.
>
> Const-correctness provides multiple benefits:
>
> 1. Type Safety: The compiler enforces that functions marked as taking
>    const parameters cannot accidentally modify the data, catching
>    potential bugs at compile time rather than runtime.
>
> 2. Compiler Optimizations: When the compiler knows data won't be
>    modified, it can generate more efficient code through better
>    register allocation, code motion, and aliasing analysis.
>
> 3. API Documentation: Const qualifiers serve as self-documenting code,
>    making it immediately clear to developers which functions are
>    read-only operations versus those that modify state.
>
> 4. Maintenance Safety: Future modifications to const-correct code are
>    less likely to introduce subtle bugs, as the compiler will reject
>    attempts to modify data that should remain unchanged.

I think all of the above is really a lot of noise that doesn't add a huge
amount of value.

Please in your own words say why you are doing it, and also please mention
why you feel it's justified to do:

const <type> *const param

As mentioned on review of 2/12.

I'm pretty well leaning towards - let's just not do the 2nd const at all,
unless there's a really good reason to do so.

There are also legit cases where you might want to reassign a local
variable.

Largely, granted, you shouldn't be reassinging params, but it's pretty
constraining.

>
> The memory management subsystem is a fundamental building block of the
> kernel.  Most higher-level kernel subsystems (filesystems, drivers,
> networking) depend on mm interfaces.  By establishing
> const-correctness at this foundational level:
>
> 1. Enables Propagation: Higher-level subsystems can adopt
>    const-correctness in their own interfaces.  Without const-correct
>    mm functions, filesystems cannot mark their own parameters const
>    when they need to call mm functions.
>
> 2. Maximum Impact: Changes to core mm APIs benefit the entire kernel, as
>    these functions are called from virtually every subsystem.
>
> 3. Prevents Impedance Mismatch: Without const-correctness in mm, other
>    subsystems must either cast away const (dangerous) or avoid using
>    const altogether (missing optimization opportunities).
>
> Each patch focuses on a specific header or subsystem component to ease review
> and bisection.

All this is unnecessary noise, can you summarise more succinctly.

More words than 'const-ify everything' doesn't mean 'several paragraphs of
noise'.

>
> This work was initially posted as a single large patch:
>  https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/
>
> Following feedback from Lorenzo Stoakes and David Hildenbrand, it has been
> split into focused, reviewable chunks. The approach was validated with a
> smaller patch that received agreement:
>  https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/
>

^--- All of this should be below the line and is associated with versions
not the series as a whole really.

> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
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

I did ask you to do this in reverse order and add lore links :) I mean
these aren't big things but it's REALLY helpful for reviewers.

Thanks.

>
> Max Kellermann (12):
>   mm: constify shmem related test functions for improved
>     const-correctness
>   mm: constify pagemap related test functions for improved
>     const-correctness
>   mm: constify zone related test functions for improved
>     const-correctness
>   fs: constify mapping related test functions for improved
>     const-correctness
>   mm: constify process_shares_mm() for improved const-correctness
>   mm, s390: constify mapping related test functions for improved
>     const-correctness
>   parisc: constify mmap_upper_limit() parameter for improved
>     const-correctness
>   mm: constify arch_pick_mmap_layout() for improved const-correctness
>   mm: constify ptdesc_pmd_pts_count() and folio_get_private()
>   mm: constify various inline test functions for improved
>     const-correctness
>   mm: constify assert/test functions in mm.h
>   mm: constify highmem related functions for improved const-correctness
>
>  arch/arm/include/asm/highmem.h      |  6 +--
>  arch/parisc/include/asm/processor.h |  2 +-
>  arch/parisc/kernel/sys_parisc.c     |  2 +-
>  arch/s390/mm/mmap.c                 |  7 ++--
>  arch/sparc/kernel/sys_sparc_64.c    |  3 +-
>  arch/x86/mm/mmap.c                  |  7 ++--
>  arch/xtensa/include/asm/highmem.h   |  2 +-
>  include/linux/fs.h                  |  7 ++--
>  include/linux/highmem-internal.h    | 44 +++++++++++----------
>  include/linux/highmem.h             |  8 ++--
>  include/linux/mm.h                  | 56 +++++++++++++--------------
>  include/linux/mm_inline.h           | 26 +++++++------
>  include/linux/mm_types.h            |  4 +-
>  include/linux/mmzone.h              | 42 ++++++++++----------
>  include/linux/pagemap.h             | 59 +++++++++++++++--------------
>  include/linux/sched/mm.h            |  4 +-
>  include/linux/shmem_fs.h            |  4 +-
>  mm/highmem.c                        | 10 ++---
>  mm/oom_kill.c                       |  7 ++--
>  mm/shmem.c                          |  6 +--
>  mm/util.c                           | 20 ++++++----
>  21 files changed, 171 insertions(+), 155 deletions(-)
>
> --
> 2.47.2
>

