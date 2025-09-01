Return-Path: <linux-fsdevel+bounces-59868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CDDB3E760
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF151896673
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2D72045AD;
	Mon,  1 Sep 2025 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R68yTLY/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m8QRNW5e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867113E02A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737513; cv=fail; b=NKlr1DkFtKIPIl9NOGRnuCrNXHyG3yI4OlySorNwTJd1s8HgnFS/sqBsVVGd+s1JhiJTB8t0icdLK7MBjO+SqGdle8nghufLz7wfCAPqx+fp7RJOnGgg04TSwYPVHH5fUbAlusf6yFT4X9Wzrn9oN9xB6zY/ZuR+6qnNOpY7oU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737513; c=relaxed/simple;
	bh=+k5A8GopAu8g3TRri6gxqilfNItWhiTl7Wi5sb40SWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A9XsOKzDkRVVh/s+N9xgCdqJNPaJ9xdiMK1d9AzvdISo0J8yVMj46Z3qfinRT4klrUe1dmCaMxt+12SfeeuIGW5f8l+CjYidzm3Kr7B9NEEbiFGGTn+LRLbhoFb9kBdJEtfmxQ+Zqj71R3R5xzVCb51E+FQtHd3swo53GsAt7Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R68yTLY/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m8QRNW5e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gQgv019348;
	Mon, 1 Sep 2025 14:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YH8UYXzGabRIgRVmGP
	1ocoyr2t9bl70QCBxKkvm7PBw=; b=R68yTLY/54e4r1FrTJd05oIJTuLH0ohRuU
	uetdVQoup7ul+rVndOpEETxgsupqqvXzbWPQnZU3d1MHYf4l/zBajRFVbl6Y9hsg
	Y8ouUHrq4x5aXSjXDoDTlLsEhxGi6k41M/9OsBmPm0PkTnv8FVGEoLEJphuqYYeQ
	nyFPZhf9+92usI2100vG+02SDtJQaplEVdT6S7BXvv21u/XeHDrp9UHtXq12YQ1Y
	66G1BgWiYPmUxvK/crl1gMfyRo3iit4DYI2F17NRjHzX11VdJw1wmmshntcOTuin
	YHsV8yxtH+4R1X2sTZUpHGXeGwY4eiIPe0TUyReh1N2dPMtRkLig==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9jktu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:38:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581CtWwH026772;
	Mon, 1 Sep 2025 14:38:27 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01mf08b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1YFlwyRyCYl8CiebR9wT5WL6vHGZXv7XILgQq9sKbrZaaMSTUu5rTLBBkG9uxBYKDZb9+q/2k1v2IJ9A6Xlb6xavEqkq0EW2QHRL0jrkaetyn8anhVhCE4WpIqdOFrFGi5JXAEUYfLtk3IO6Q46+WgaXL1sHRIhZ2Lnt/FE9EGsx8hg14LVJmhhs4W1k6ynldYUBWx6N7j2sL2hgQFTYxD+VqG4E42ZuQW/OkWvl9+upVgWr2/bp68GFFb5LyKSR4RguGjiYwsMCeVH+ZTXx93Eri9CzITINf1KCTgtwCYZqNCsIs+Vjh9efk0Pi1tGbOqr+tj6Ka0v7qm/LKEn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH8UYXzGabRIgRVmGP1ocoyr2t9bl70QCBxKkvm7PBw=;
 b=s4y7fWT4CPOhmakWPTG6phPODBwMTcPc4fWn7AFvCEi1MAQundC4XM5u5Kb+iRLW/tQBRBdQ63pFG+lQn+Ttxoo4H/HC+JN+AkMG9v41pioZL+tUap0KFgIUPuTo47Gfk03G1RwVR5hvpeIJwSY4TERq12h98Yi1+U+bCYHM98Z5ds3BKcykxphXSpEwBG8Pq+RewbT6+hlc5DRacg8qw2+13XukebwWwKOQos4e55ThlvzxalgMS3oWH5h7z6VhBT0e4Yrd99A59ENoqi89CfD1DKbWLw5PxEmOrQcdNZG/2/NDCUlyN0ayN5SaalAjv2181WPJKD0/2QLaNM+BUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH8UYXzGabRIgRVmGP1ocoyr2t9bl70QCBxKkvm7PBw=;
 b=m8QRNW5erAjlWkqNTWgH7N8v357oHXXAwRNy0fvyQAlO9L0fv5tPBtdN/d1vx+8OV9yZ75Icovt1zU0Y59HWgBRF/oWsODu/Xe1B6NzDnQeMedeJ+dA+MLvoSFuAs8z75N8jjSgDbCXK7CxdcTH4QPUWXiwg/YUJ6I0QosvI+kw=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 14:38:22 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:38:22 +0000
Date: Mon, 1 Sep 2025 15:37:50 +0100
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
Subject: Re: [PATCH v5 03/12] mm: constify zone related test functions for
 improved const-correctness
Message-ID: <d4d90b7a-fc5f-4f5d-8f64-7b07d3bd8d66@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-4-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-4-max.kellermann@ionos.com>
X-ClientProxiedBy: GV3PEPF00007A82.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::612) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|MW5PR10MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 86499747-f775-4781-1074-08dde96529e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JYoGdow/8PzczB3QoHQJ1lALI4TL+V5s6g/tN2mOYsesZUQu6O2VhZR0aNBP?=
 =?us-ascii?Q?u4fvPYtMuynG/vICDcJhs/x2PXD8qcJBc2pdpyXLdfb9otcYujjKfpXyRPK0?=
 =?us-ascii?Q?hz4PrD8GOfa27ShMZwT+HoxlkSnr6cicX8o9NyO803lXd2iQHxqYK6xs4ziV?=
 =?us-ascii?Q?Mt3bdma5z5ikP+DkAKYzEuaptNJjHLfJLBfo49sdEj+Ayi3eUt8IoTyHTk6Q?=
 =?us-ascii?Q?4CaTGgIGR/cO0ErW2FqdMzLx4FTlqczw1HZcW7awetoZaDZTlt0OT5u4fX/6?=
 =?us-ascii?Q?cawpc7rXlsYq+oMuUF3m8gcIVdakqslh5wlM60HaOzNZp75Bj29fzmN7pNm1?=
 =?us-ascii?Q?kXz/wStQ1PmxIgWDP5l0OY9HSqir6/8TGm2PdCV/4qvnYUnGUfmSmI2Kcdnj?=
 =?us-ascii?Q?v+u0BXNJHTJkLvHrq3xfUB3kgKQo73Y7V39Mq6nXeJaYHAvCZqGA97t2LfLq?=
 =?us-ascii?Q?jUJxgDVPQoJ2QAM7X1J5FWyBxQxnUte5OVlzi/SqbqqXkjmaVxy54v7MuHCl?=
 =?us-ascii?Q?0/ppbI2nSFrYg/iY/egjqkYDYCOoIeGXQw2rSMHuNvlj3FBt5jVrBg8CQ8+q?=
 =?us-ascii?Q?2dz6DQvt/JLRmkpbKwfp14KJWHWjtQWlC3wM0kgGRjXEWtjWjIYJGq+lkSC2?=
 =?us-ascii?Q?XOkIhYjzgTPZVDhqOqZoNUINuizztuB+D8o65XGWiLqKG+5o/EJvW1il+LRl?=
 =?us-ascii?Q?nYZEEFZ0kDJ+kCoovoUhX9FpRG3o+99BsGuxySVhxk6LWwZ2GEBNICbam5zL?=
 =?us-ascii?Q?9w1htu4AgXIa/vFHqcJW2WP+TyYJPGnvuqXjekx7k6lt9MW8xH/KHNzV/Wbh?=
 =?us-ascii?Q?4AnAVOGlFsrVf/2kcc3KPB7HHFMpzncKmlpDmZrJhVAtd+bneLrRaHcqXmnI?=
 =?us-ascii?Q?9yL+AtGt9LHkgvATzdRh49dEuxYnhdNOwyKfN+gRfmtbaf/HU7Lex7zRh3Ux?=
 =?us-ascii?Q?Yyv1lvEnzXVUF7RwXcRkQ9152Q5aYwKKSy3B/OtLs50ISQVWsasepcDuTRbH?=
 =?us-ascii?Q?ZQHOlBBLPvWS8bYYw8fg9EzuISF27Cc6o4t8Fb0OWfDywr0arCgmpYplhApB?=
 =?us-ascii?Q?Otbqnms5Svt2ZlHvXd4shA4cpsGVitQTBs26XTC8QF+hc4AfSAFQbqhyPJ8j?=
 =?us-ascii?Q?9gAfuHEG7azC8laOSVY7ODKdWZGJ16RY0Xa9loMCSeffVRBTyfydNiaVdhqJ?=
 =?us-ascii?Q?z1Crvt9rxtg6zoGqr0JhiLCuYRqyXaGw4hZKUua8xxkzWltYWYPzvugw6zDk?=
 =?us-ascii?Q?pKnxqv9H6qPjcYTWbLRgWEM8LksBfo3+aZM3V2p4G8lLW2xfVo5q7jT1RP8x?=
 =?us-ascii?Q?6sG4vPYRIwadJuT7xHLLlMRhU4hYGw9HTwATNHFiclfMJIYnhXRI2XEYdwSZ?=
 =?us-ascii?Q?T5plAdI43xN/VSjMlkstpcAa12MIVfpRKfVPfl8KyLAA/J5JfCW/OXut7Bsl?=
 =?us-ascii?Q?gQsYTW1+PxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36Kapsdykv6cb3eYdLp5UV2zyn6d7GFkAp+RGQU/d2eAOSUnrpa5SrHtyLax?=
 =?us-ascii?Q?q+COvmHFjgfbPBS08nxz5NxoqeAMOX/xyQ6gjH1LSxnfq7hgCyBvf/7wbdn6?=
 =?us-ascii?Q?mz0psOoBs/Uixm2bxF9ZdQ07TGU7YFnbZUtEJZ19zQWNwPsQGB5hurEcC20a?=
 =?us-ascii?Q?0P8XYGlGEqTUO2e7nC7n5NMSlgodvIJZ+5nXZFTF1IQH4YOwn/rZniHnxHIk?=
 =?us-ascii?Q?55loiu1GBKzbvTpOxna2W57o54dkGLTbdbOL37eYZdKHylckjHASykfdPyYS?=
 =?us-ascii?Q?jSNqqQ4AiUTDkew/PnzHh9cJqxAJ/UJ1gnwU74Wss7lsx5nleuY4J0GCpN1S?=
 =?us-ascii?Q?V9b7+nACbzIqcZ5BPvoxsnA2go2LU2PuDbEtQo+JpKDw5/WmJcLotXr3JF91?=
 =?us-ascii?Q?wPtMjxK1UUcZBhOXxR0I7vX1J/vBuc9yqXmzsm15RUWQ52Hb21SNfmkW/AhI?=
 =?us-ascii?Q?E8mejO6qOpfQ0dBI4M5b9FAiezfp5VTiKwodAgHeWGlNbxuU3ll9frV7mu+1?=
 =?us-ascii?Q?NuEHGWv+3JhkWKuWljC1YMCUC8rYWhHzrX2walGY7KkWMansqropxiHdOmq7?=
 =?us-ascii?Q?O9IURKIZjunnXAkwdcmPWOJEziasTb0iZkpXGHMyCZBVDCOI/g79RJxwEsw4?=
 =?us-ascii?Q?NwQ4AZd3qG5s+rw3KeYg5jPTWJ3pttYlEbfFw3VkLUYTuy8aGG6l6TW1K6q+?=
 =?us-ascii?Q?CI1dmiKVt7FV/of80VLFyp+wTyzX2xaouRzGHa++qdJXNwEOLCQ8MkcYH7mR?=
 =?us-ascii?Q?iwOmZPtPXJBpAUdq8vZgCrk4FMIfylR0khw0RiugsM0g60/gu6djYVh7h2Oc?=
 =?us-ascii?Q?meHuCsalUbbTb/ljVilATpWtNBybG6G3qfqQGS05CiWvCU2zFXbeHloVbht9?=
 =?us-ascii?Q?TD+NDoKAAPvo7yG837dj62DJW5jAKK7p0hTMOL5Q/UiNwkJBylbYPSuZArho?=
 =?us-ascii?Q?dphf3s70RJ/aTf7IILmGzrmiernhbiyx/pVep2gTTcWD5LN8SE0zdxgAaa+S?=
 =?us-ascii?Q?RkPpFhWt+2U5WC0lCQQDlP3U7An6ukd+iZJB7CYkHmuD4UsghLI7CB+7cUFm?=
 =?us-ascii?Q?HB5W8FCNbMM1jjxcOZv5+Ay8ZU/lwCOexYocVx+aE42zgkDhgFjL8NPUxmsp?=
 =?us-ascii?Q?8takEMigCqgvlxJPudoVC79gqbOwZnTUwZ2jLn2Z87k8Uy46Jn6euy2bHfKV?=
 =?us-ascii?Q?JIfdHGsWImLgR8WeU/OjMJICUbsyrN0Z+Bl5mbMIIuyRtlpL3OiwsxyeovEv?=
 =?us-ascii?Q?NoPr9Uxd2HLPNlimhqQO+GvUrwzz8UsridaMXpmKnCFEgWNbPjUEngKf+pts?=
 =?us-ascii?Q?zxPK+ru48j1gwulBIIduRP++fvuMLh4D5nrECfq17GX2vpKd1t82h8MpZRKb?=
 =?us-ascii?Q?EZShTiLWYStSwxaBbs0c/18yLCtAy7TC4P4glZJcuQt2GzkOq7WhRQV60mNO?=
 =?us-ascii?Q?QLsmZhZh/NKjUaukEqxUuLP8o1ukCafzWQKHXeZ5KycxjDpkRlAxYXAaH4Tf?=
 =?us-ascii?Q?cbdIHYGtU5iIDDw5upbm4xs/+aNljipGxlGWFUGSm8BdYBGgneH/Aeee4Cax?=
 =?us-ascii?Q?L4EGo92rEfYDtMydnFP8o+TdtFdf2aJ3m5QUGy2Q6wPWyVY9AlySv/5cIjyN?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ngVl57rmW/7tt9vTjtDyFn1+jJxO79H8FxEAlu4GtSEWduNLm1GvANbBnyN09hIQi/dfbA7HOH21h3rrOacw+FXmZ2CG8BPip+HsQdnVf8YL7wuR+VHhSKd2bUN6yj5BzkRnpe2eGnovvffgIqchXK7f8Z5RxsTwiyuxmh5OWJvb1udzUYkqTWjOvNOXD9qWiQgKD/CKHsS3+N9FodP2Y/9s9NV0oKb97K/uVlr7ZqFINBAAtlkAWac0d5s/AAeSifUnkckmV4HV5rjL2XPH7dUf6aAyBVLLak7hU481vcfxzjzvI/HjgcsSsn0c7Xue8zIaldYgvjxn+nR8NTcfKGnkme07ACTLoU38XSfAmjjzUlqWI/0AmMZIuESarc2s4bCUgPc+HUUrIZ4vp41hJ6iD91yRu0XYq/NsIjvgGgVbS1tG613galt5l6ZbxhvqkuH21+CS/Ure1MgFC5aKffFHnZ9EGryQGaYHAa+3aMLb1GDr4N2LJAX/LAXQp2CKk0dEK9iiEZhN3uYoRyLEtHUyw+ICp6Q2eI6l08T3yJOaWQAx5Ka+1u7bQBxxHJZEtJfOexXC5oF9a6sSspg+sn1f453O00U9L3YkalRreY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86499747-f775-4781-1074-08dde96529e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:38:22.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUV2B10bpkYyJX5ahS+uVUQkAEyFWTDRI3eYMHz62E8RRh91oFkD2AxsAbmx2mC0ru+w/jv+idWXoaidqj14EeB+f9c5LJI+qPNCs5Pp5Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010155
X-Proofpoint-GUID: lHOzIekI2wVJkA27JEBsc-32oAzWyyt5
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b5afe4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=NMxtF6NneZFbZcyBqk4A:9 a=CjuIK1q_8ugA:10
 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX1rU6SLvYihUM
 hQTKP+dqO01KOqsuWkYhansnzOh3l3Fuf/tG3mBLXdNtsSyziEA9mQh8xSj0IstSruqu/IxlilW
 K6wQYlIR2i+SHelwRi+xVDCqVQSzvcsZtdbqDxaiEFkoLS2T3dWD/4gpmmhpu8cdGyirbioVLsN
 wa1TEmtWZIpli0JpVe10QJ4bth1ZrnUEXyqrBUpM0Nqp9lVDZVgQdfgz/xko/GYf3Zc4k2tm1Fs
 7p2yqdk4nkBcy0ZhNa2w+pv34qpYGYnVZxezYEMhfewzmwMzbJej8uuq6/MgvkIMnHs2bztwC3G
 xejeAl8bsld2AynWyAaDljGlSHX9wsaU9EM2XtmfVnyZokTfqzTAVi95e+4CQn8H2bCPjXUKDTS
 YpguQ8J1
X-Proofpoint-ORIG-GUID: lHOzIekI2wVJkA27JEBsc-32oAzWyyt5

On Mon, Sep 01, 2025 at 02:30:19PM +0200, Max Kellermann wrote:
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
>
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

On basis that we figure out whether we want the "const <type> *const <param>"
thing or not, this otherwise LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mmzone.h | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index f3272ef5131b..9a25fb1ade82 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1104,7 +1104,7 @@ static inline unsigned long promo_wmark_pages(const struct zone *z)
>  	return wmark_pages(z, WMARK_PROMO);
>  }
>
> -static inline unsigned long zone_managed_pages(struct zone *zone)
> +static inline unsigned long zone_managed_pages(const struct zone *const zone)
>  {
>  	return (unsigned long)atomic_long_read(&zone->managed_pages);
>  }
> @@ -1128,12 +1128,12 @@ static inline bool zone_spans_pfn(const struct zone *zone, unsigned long pfn)
>  	return zone->zone_start_pfn <= pfn && pfn < zone_end_pfn(zone);
>  }
>
> -static inline bool zone_is_initialized(struct zone *zone)
> +static inline bool zone_is_initialized(const struct zone *const zone)
>  {
>  	return zone->initialized;
>  }
>
> -static inline bool zone_is_empty(struct zone *zone)
> +static inline bool zone_is_empty(const struct zone *const zone)
>  {
>  	return zone->spanned_pages == 0;
>  }
> @@ -1273,7 +1273,7 @@ static inline bool folio_is_zone_movable(const struct folio *folio)
>   * Return true if [start_pfn, start_pfn + nr_pages) range has a non-empty
>   * intersection with the given zone
>   */
> -static inline bool zone_intersects(struct zone *zone,
> +static inline bool zone_intersects(const struct zone *const zone,
>  		unsigned long start_pfn, unsigned long nr_pages)
>  {
>  	if (zone_is_empty(zone))
> @@ -1581,12 +1581,12 @@ static inline int local_memory_node(int node_id) { return node_id; };
>  #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
>
>  #ifdef CONFIG_ZONE_DEVICE
> -static inline bool zone_is_zone_device(struct zone *zone)
> +static inline bool zone_is_zone_device(const struct zone *const zone)
>  {
>  	return zone_idx(zone) == ZONE_DEVICE;
>  }
>  #else
> -static inline bool zone_is_zone_device(struct zone *zone)
> +static inline bool zone_is_zone_device(const struct zone *const zone)
>  {
>  	return false;
>  }
> @@ -1598,19 +1598,19 @@ static inline bool zone_is_zone_device(struct zone *zone)
>   * populated_zone(). If the whole zone is reserved then we can easily
>   * end up with populated_zone() && !managed_zone().
>   */
> -static inline bool managed_zone(struct zone *zone)
> +static inline bool managed_zone(const struct zone *const zone)
>  {
>  	return zone_managed_pages(zone);
>  }
>
>  /* Returns true if a zone has memory */
> -static inline bool populated_zone(struct zone *zone)
> +static inline bool populated_zone(const struct zone *const zone)
>  {
>  	return zone->present_pages;
>  }
>
>  #ifdef CONFIG_NUMA
> -static inline int zone_to_nid(struct zone *zone)
> +static inline int zone_to_nid(const struct zone *const zone)
>  {
>  	return zone->node;
>  }
> @@ -1620,7 +1620,7 @@ static inline void zone_set_nid(struct zone *zone, int nid)
>  	zone->node = nid;
>  }
>  #else
> -static inline int zone_to_nid(struct zone *zone)
> +static inline int zone_to_nid(const struct zone *zone)
>  {
>  	return 0;
>  }
> @@ -1647,7 +1647,7 @@ static inline int is_highmem_idx(enum zone_type idx)
>   * @zone: pointer to struct zone variable
>   * Return: 1 for a highmem zone, 0 otherwise
>   */
> -static inline int is_highmem(struct zone *zone)
> +static inline int is_highmem(const struct zone *const zone)
>  {
>  	return is_highmem_idx(zone_idx(zone));
>  }
> @@ -1713,12 +1713,12 @@ static inline struct zone *zonelist_zone(struct zoneref *zoneref)
>  	return zoneref->zone;
>  }
>
> -static inline int zonelist_zone_idx(struct zoneref *zoneref)
> +static inline int zonelist_zone_idx(const struct zoneref *const zoneref)
>  {
>  	return zoneref->zone_idx;
>  }
>
> -static inline int zonelist_node_idx(struct zoneref *zoneref)
> +static inline int zonelist_node_idx(const struct zoneref *const zoneref)
>  {
>  	return zone_to_nid(zoneref->zone);
>  }
> @@ -2021,7 +2021,7 @@ static inline struct page *__section_mem_map_addr(struct mem_section *section)
>  	return (struct page *)map;
>  }
>
> -static inline int present_section(struct mem_section *section)
> +static inline int present_section(const struct mem_section *const section)
>  {
>  	return (section && (section->section_mem_map & SECTION_MARKED_PRESENT));
>  }
> @@ -2031,12 +2031,12 @@ static inline int present_section_nr(unsigned long nr)
>  	return present_section(__nr_to_section(nr));
>  }
>
> -static inline int valid_section(struct mem_section *section)
> +static inline int valid_section(const struct mem_section *const section)
>  {
>  	return (section && (section->section_mem_map & SECTION_HAS_MEM_MAP));
>  }
>
> -static inline int early_section(struct mem_section *section)
> +static inline int early_section(const struct mem_section *const section)
>  {
>  	return (section && (section->section_mem_map & SECTION_IS_EARLY));
>  }
> @@ -2046,27 +2046,27 @@ static inline int valid_section_nr(unsigned long nr)
>  	return valid_section(__nr_to_section(nr));
>  }
>
> -static inline int online_section(struct mem_section *section)
> +static inline int online_section(const struct mem_section *const section)
>  {
>  	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
>  }
>
>  #ifdef CONFIG_ZONE_DEVICE
> -static inline int online_device_section(struct mem_section *section)
> +static inline int online_device_section(const struct mem_section *const section)
>  {
>  	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
>
>  	return section && ((section->section_mem_map & flags) == flags);
>  }
>  #else
> -static inline int online_device_section(struct mem_section *section)
> +static inline int online_device_section(const struct mem_section *const section)
>  {
>  	return 0;
>  }
>  #endif
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
> -static inline int preinited_vmemmap_section(struct mem_section *section)
> +static inline int preinited_vmemmap_section(const struct mem_section *const section)
>  {
>  	return (section &&
>  		(section->section_mem_map & SECTION_IS_VMEMMAP_PREINIT));
> @@ -2076,7 +2076,7 @@ void sparse_vmemmap_init_nid_early(int nid);
>  void sparse_vmemmap_init_nid_late(int nid);
>
>  #else
> -static inline int preinited_vmemmap_section(struct mem_section *section)
> +static inline int preinited_vmemmap_section(const struct mem_section *const section)
>  {
>  	return 0;
>  }
> --
> 2.47.2
>

