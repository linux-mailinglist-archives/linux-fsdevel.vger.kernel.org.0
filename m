Return-Path: <linux-fsdevel+bounces-54052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CBBAFAAF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB7F171AB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A67274668;
	Mon,  7 Jul 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YKFh6QPe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DwYjp3OH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E649271456;
	Mon,  7 Jul 2025 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866214; cv=fail; b=slxVYt6FWdYYqTLB7Q/bC65IAxH4oU7eaoxEeVJHnrna/mrS+6w4mo2t40m11q8oyTTsrGyvaDpzIHNo/yn27HZfjRhrR4MLg7L6WjDjDaZ9Ll3npvNUQqwCYxpPcaHw9+s2x2FeIpgHi0oyb/a4wm+9WczP8MANlWOtzmrw8f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866214; c=relaxed/simple;
	bh=074UYxuhV9s4XsDTwy9U7n9sjyNgO94F+VTJkiNgHaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QhwE6PLb4CElrLLau/A17b/IHBHwR0EiXz1K8yeXjk6JQO6IMrP5naxg+bCdYfoWPDl6WIc+wPM7rn9utoavBnihPqyFKaDn+1uWyW5ks9CxIHhhZoHyinWTGJhb8f+cdPhUQT3Kj9K4rO/OGoD+AvWBpXA34Sem9kIFpp5+0w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YKFh6QPe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DwYjp3OH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LeUdx004231;
	Mon, 7 Jul 2025 05:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3TewVDIJx9Odr+Qd/YNQrIeKGDph0Hf+8m0KaT/I41Q=; b=
	YKFh6QPeRI/1fbTFmE5DQQsVigvwnHrB+hrr5XtYhBeYE6xZpyAmZkPer8rSKcrz
	u5rOH9/F3vJumwfogy/PeH9ul8cKldTw56A+IpntTND/G05JcF5fkkqkQlsmKfDd
	EGdds76DwheQiiEDejeijlaka4skjIVBq/jeyl+b4zAk5OuoQ4ARhpDOp92zDhiF
	V6bVKn/t0Jn21IC8Kht1OX1V7DjiEimaMlcHeK1xql3uJhK8hd5/YVSWvDOy7oTc
	Jj+9YcRDcg4T1XbCWAiqzNvOw2R+FWPnvloGgZLkwCyLbvNpdOoWpPdv6nTAH9IR
	BpmoWDeuyJzW4IyHE0q11g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47pvkxsxyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBl024285;
	Mon, 7 Jul 2025 05:28:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvEnCBHWcNybjX4axc/xgmXpyFBtbTgm32MX4C+hg1JMY3lFhthIwmii6Y0u8GVdci3IN3XrErq+tBpg5FKWdVPY2ssC/MXXz1s1febTdeqHTwPMwKF1lfFvcVb3EPDpRvuWr1NZX2jDKCRSCGKKX8YYo6iZMSzKP+egMwzxIYwQ6HwnrJdaU2eJO9/oO1uXdtIfwl4QYKX3ykw32AGPhZ3aG7KtBZtlyTFZhA58f0dTUZtE08kx/NqpA0XVxMNTS9HFkzA9Nz3yEmUlJnRasDLu3p0ADtp2bFW5Mm2GiwvTOVzYs9i8L55SMKxaFZKBSZ01d3hz/7VxPygBxE+KZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TewVDIJx9Odr+Qd/YNQrIeKGDph0Hf+8m0KaT/I41Q=;
 b=bDGp/mgUb1dEk6FsLZRIG1Q2JTgfwwdsI37+jSSV2Kj60K2i8iuf6UKMRsrCzppW2cYaddKowFvaFZnn1YYLaZl2nIUlO1mLvDpmpp6MYovULr3qYNNtrGm2zSNznWJaZLGODJfAEcev8iDT9reTCY7gFAXnbAvMCyZzLLFPuT1jPhdpHL4GMWIiXsdty2I7eo0vnC5EIiI/XaiXGeeFESrevhXgAcfn/7W/ldPs3pteoBbDSzQB8Y7hf0xxzJmi1zmsutRCeZfuLK3X4j/A5yTfrtiHs+eBXLY6SptQ5SnCBivkNJUgZ0bXgAyOoktWU6XKskCugAQ5doFuJ6jy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TewVDIJx9Odr+Qd/YNQrIeKGDph0Hf+8m0KaT/I41Q=;
 b=DwYjp3OHuzsHCLoBIPAzDgxKRcoQGAwoSZbb7/LBCjaL6/UuFVI77YTP2CrrzX/I+cucfyLDt9AKBYSN0a5JspmuwMU/A0z8eX6xP5NBOqFt6Pp3PBAy0wMgjMGwABiqeVKt3LeK2ZSbvTn3OrYV9xZNe81aaQjFRZ960r5BlWE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 02/10] mm/mremap: refactor initial parameter sanity checks
Date: Mon,  7 Jul 2025 06:27:45 +0100
Message-ID: <eae3ffbee3c0ba66b4ee872f6bb48ec77ee25609.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 481e3df7-7a59-45de-cfde-08ddbd171fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AzHKhl7olSHtjK4WpH5oGyfMjGQq75bSilHLp3WWw2brDSKnXIiikz785oxb?=
 =?us-ascii?Q?Rx+cXtldbnJz7d0yaqh/AuXvDjv1So+lotAMYXqwyy5/qMoF7OFqbmSe48ai?=
 =?us-ascii?Q?MJEqrVnrfIhES3fDOYA9MvNlxkaHDjcp1E6rD8LK9QXRT3tQC5sYf5MyoL4h?=
 =?us-ascii?Q?Ghvyky8wbxjdFIkl/0TkHodA3nmVyedA475aV2hTXdDVQLQzfIBlo3fwdm5g?=
 =?us-ascii?Q?HG1U7TjjBpy9vWTF361lVB4CJKFihETrk5HaW7d3OswQ939Nd/eWU9U3Wf39?=
 =?us-ascii?Q?Fm6yqopTSLF+vguEfEofiWU4GCgQLvtd5uNoYwrFQRVRx7JFp/suTBzM87mm?=
 =?us-ascii?Q?+YChrl7f6usRH57OCx+OetdqEwbt3Vi+xdkmZTncWwDidPHD7woY/+1nzk/L?=
 =?us-ascii?Q?99mUc/waS9UCSbyNabQ98hQQonI0KrkEHjBwqFP0wMHTxfy0amHYuT+ba0j+?=
 =?us-ascii?Q?hUZBLrsfqB4d2GdBX8IyzuLlZWubclb7KSwKZ281WdMQEbJ0jUrr6H33ZlK3?=
 =?us-ascii?Q?R/uUtu/B3J+IvRoH8EOThQXpW0wIJD5OucjtQd3/1aufTuo+ZmgNio9YWHiL?=
 =?us-ascii?Q?G41uKqD5nX6QIB/pBrJnEkCxTeLs9ruTRZLXKmsRXLEpCwUiHG4Oekfn2scb?=
 =?us-ascii?Q?w8zWnPuQ3QtbVmoNBcv7dckTrkf0BANVPRqe6ElQ3u5uoVFoMrjk8KFCMUJS?=
 =?us-ascii?Q?iKKnRx7/ZvVv0C/7u5Bq465xlCZ8Kbi+RIJUD+iaPgrQkNhwd5bURIcLWnz+?=
 =?us-ascii?Q?q6mDvWvrDv+BsHHD/EyPnMttCJF2Td0rIkBSM6THcubnNsTNh4YDTD5xLwgu?=
 =?us-ascii?Q?s7g1jehsZEUI6TvmcF+/NQx2SKK5pMSHaSEYgTk8QP6Wol1muD5ec+tNruLD?=
 =?us-ascii?Q?kHHreprZ/vscIJvO93YKGFBZuJivY9AZJJunafXg9oNVYoANMrS2fpHEcv3G?=
 =?us-ascii?Q?uSMkzfvgVSPmkSHIdLhqDwefilvHnHV8r3tBjOh92ETF3EQMSHuc3ua5Ltjc?=
 =?us-ascii?Q?6CbkxlQX5D4eAvvlkHAZ+iUcNImoD0YwOYu/YZl0LQbsA37LIQI2grH2gpJZ?=
 =?us-ascii?Q?Gw2APWAJRW1G04PiQ/4PiHpETkL3gR0h6Zbr4Qe6xD8BulWL9CnkLtIIqylF?=
 =?us-ascii?Q?zqiuQahu/nBeQDNWqp1R2HSpjHtRsQOZHGkE1lJfCHpg2rz2NvXXfP7GPzh3?=
 =?us-ascii?Q?ha83tbb6czki1FFQPIKfCPT3Y58O/xN8Zx0hmmrbttyOf6+A087Z5516jxLY?=
 =?us-ascii?Q?s/qeHUTC/CUjNX9KYHHN+UtXheIoMppHN/kijgL5jIbVp2WU0s8piWcsuJ2N?=
 =?us-ascii?Q?ku5Ho4sy/A3DpR+SDKESCouNZ5WMJsvJe7JAFpA8KJVbT2npL2lWXaIKeFAj?=
 =?us-ascii?Q?AkGdPBf4XDjwzGqe6Ss7R1fhMLRNsbKjOv5OOzIEGM1/sAIT3QxxkicZSoK1?=
 =?us-ascii?Q?TeHSZXucyyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c/iCMtlUHQLydpkxVKC6+EzXtaK0M5BLOUAEjeuAwDWN62ktfn9irUBCAr0i?=
 =?us-ascii?Q?tITao/cIEIceKMyRPl1s8tKZzyQpadTM+8Bm/EA2alMUlch1s1WgSq/Z0tEj?=
 =?us-ascii?Q?mWBIdgsnXVXaNeUUUvREHjSiIT8sw8OvFRFz0CBIHqrMB2ZvavjxAsUE7E2/?=
 =?us-ascii?Q?rwgyerBSRUEmreCLqJTAfxKBajh8SnGnvKX0b8xo091VyXBXgd/sRtbjWnmu?=
 =?us-ascii?Q?H0NmZiUz+/U2gdOAmDtwZCczZBspVr8rKTuudcM6kJ8gNyp3YcDcR+gsWDdm?=
 =?us-ascii?Q?gVsTY1OfEeO5sOXGFZ6PScR2qmuKiaAvWGHR3mBgkzZ5w7yUWj1PRRrrNq2c?=
 =?us-ascii?Q?NDhv/tc41SWsb/TICNUSDS1MjHkZJQsefFSFHI+zvvipJClUCJ9o4FMEguD5?=
 =?us-ascii?Q?N3iXlZvAL4mg5SNDH+M6KsfTaIc1fZTc/YeWOiBL3xMX43pdvgN84+jeHw0h?=
 =?us-ascii?Q?730QjKrIORWZwB0xAaaUyCp7kyV4NKynd10Np7MEl4dc6cz3osiU1NNkyzlY?=
 =?us-ascii?Q?SQL6GoOPOeA2WdJnU7mA3dsq0SP/8leF0seI+YJjNw21WZ0BZTleAn73IdWp?=
 =?us-ascii?Q?2E0WAIt6RjZyzHoMa8SPA4ZYslJoHMTFLDiIoW4NojJoHR5q+xVrX12usUbp?=
 =?us-ascii?Q?Chrhm66Rmyj/3NxSmpIXyDZXVP0RROT0L7ljuVlhhmNFN6c0SULjtHnm3q50?=
 =?us-ascii?Q?h1AEnxUckGm5n4wKyhrMbyMzhW3TbeHzrE6lmrWq7dtKK6bAgpMrG4xPmlpx?=
 =?us-ascii?Q?p1j0s5/JM+RtJh/hLMhssOWcnUahs5SrNx2V5CWMij247feAAV5ihVoaQa1Z?=
 =?us-ascii?Q?nppgOHRXXpI/FvF058fTGHG11JkfkX2CwYzVRBuxKw473Rp/Yw71Bio7lGzb?=
 =?us-ascii?Q?kw12y3K9Jt1z2Zxl3VRgYlPqFgHwZ71HuD5V19hc4ETzcexpZunRyzIupaG3?=
 =?us-ascii?Q?Zta2d65+sUoE9jbhkU1aKPQvdVlkZMiWTqLZyZigneo5PBzD6fdfqf1t6qhx?=
 =?us-ascii?Q?mwDb3+LeRGRsEzKaqj5dIUyinvukhLnWEU4ucaS2LAk+ek/aooOcQ7Quzzec?=
 =?us-ascii?Q?lRhs54Z7B1+62M+j8DZdzMc9yR2szcJ0Fz8xjLNh8HDopCAY/oexQnZzhVOK?=
 =?us-ascii?Q?kYKwKYluOKCPVHze/UEUKbm4gBLM+Vi1nG4Ecpwf0iqkE2IiIm1dBKqfAT17?=
 =?us-ascii?Q?rjN0KShUZYXg39bzVu8m9wi5A78ULk/zmmTSHCtQZ2Ia82Q+Bg6KY1kyTccy?=
 =?us-ascii?Q?Gyiqibod3wx5+RFMacrYBvJXeJXgVY1uIATIOMtOEhykOKR6fBy8GqaNc/LI?=
 =?us-ascii?Q?G6JtQuY/DLey2ql/7CZdZHekS2Y/vYOWvLtX6pE7XEyinu5cJeO4g9DC+iKO?=
 =?us-ascii?Q?v7UP3LOxCRXsbHZUJD6A9rWdHedAEyuA1VEkqxN1nhLkSBMA47venLIGhYW7?=
 =?us-ascii?Q?oFFWGPgMfgjBW0Pj4JUg7SnIabz+o6A7J2j/leMGkGRaONb4iy3isuf2akfq?=
 =?us-ascii?Q?D3rWoa1lVD3yxSt3k2eivqZe+h8F1bZm0o55tUPRyBvvWjkXnzQ7uTUrl7Jb?=
 =?us-ascii?Q?PcNWzbiEUFmw0jJ00rdzwDL8bV0dcnHMs/osFnQKongyhjgD2jWke83DlMKm?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wlwfztQIqpkFdANGudtUkDCLxVyfDiSfB4/p+pSXF1fGp1iHOfz4tFdWBC6S1OK9BvgOHXL2XxH0XWRe+kdnyyX9vgzPwE7tDkrngybS9q+wokFwwCHkdn0dT/Xr+q6sjDjXymXJGOpuARpIM+TxdjVTHQqy2L0G/puv3kTWJg6c79VyzGEnkW3oLWYYKNUpfBuzYjMjwCHlJKgwmFt7n/IkAhmAVsGZtydMiJ+xEBUPIegtJLVsWuWf0jVlxXzLg/OhKJ98fTqgJIM4ZEQbQFBL3tFiEi0L6NqgJ7AZQU0Fl6NJxvJxt5wGO8QhhAQIvb/O6U/TSW3+7lFSwWpdN3U/sNPeQ/utA8FQK5FmTg9DHP4Vuarg8m1gxc63Nt9Dptt77fN+VFAI5lCivjxXmJdUh04TGTWVjQomk2zi3ZLl6M2HhxpU/AfCdt2V4HjvMeF65BnSlK9duAMnpZ4Wx4R26W87CgufVNVR+YRkwPiUvJWbF+Jt4Yx1ERKUmLsjx/vafDNeVz0PW/VIJPjnkxVODV1Oc/NuFXYHz6LCheIcVXp5YniLjBTCTHGLh8VSpxbA2k0REkgKTA8doauk61Dy4fmHiDJRddO/z2JiM2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481e3df7-7a59-45de-cfde-08ddbd171fe5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:37.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrlLNlkp4I6iT6djH3pJBCWq5jhiO91FbT3ZYnyy4uoOfpv7pnf6PzhkS8ZXyTFFeKxal2KsdMjfeCwfVc3gKHRpt0yJKuyvheFgGlJwPOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Proofpoint-GUID: i3XewSEmKg3Z8ISez95ih8h8KdkMhjRr
X-Authority-Analysis: v=2.4 cv=a5Uw9VSF c=1 sm=1 tr=0 ts=686b5b19 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=44BLHjD3IfhdABlFFWYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfX0lv4KWjap5sY 7C3GCLdPvoC8n2XfA9cg+YKdIdBDT9t6aFEQM+da5umPye5hX9LJhhnb4pgx8fT4SKKwQuJxkfj CngOdYfi8QOHbt7o1CMp4JYVFWjFR9yALxehUfWl/Hh8v13MhYaNbZuHU7A2w7yFtSSkqbKkyiu
 eZAHwJdM8w/YK+HOuyYg0N75KEOKaqzProoPuRG1LBqnjkNgTRZ25LKHOLIQl3LNwNxxBWRGGN5 //1sJGGznjNAUwASmIpVJgyhFBybkUuThIhRp4fXFNA9CDfghCyXvec6CPD5gHx8rnO3SdWmDnp 3B284GDflADucMFJv9/0pJ6pSMFn3+Cs4jZPs2Yn/3wGMvPOXqDeaDcXLuaM+8D9WQbR2vwRfp9
 esoAoJbfh2tYVQSv4LnUtQMuSL2/BoS7MO2UQxW4r8GpIwSMrsGLfXk86PgtREHm6fPADggv
X-Proofpoint-ORIG-GUID: i3XewSEmKg3Z8ISez95ih8h8KdkMhjRr

We are currently checking some things later, and some things
immediately. Aggregate the checks and avoid ones that need not be made.

Simplify things by aligning lengths immediately. Defer setting the delta
parameter until later, which removes some duplicate code in the hugetlb
case.

We can safely perform the checks moved from mremap_to() to
check_mremap_params() because:

* If we set a new address via vrm_set_new_addr(), then this is guaranteed
  to not overlap nor to position the new VMA past TASK_SIZE, so there's no
  need to check these later.

* We can simply page align lengths immediately. We do not need to check for
  overlap nor TASK_SIZE sanity after hugetlb alignment as this asserts
  addresses are huge-aligned, then huge-aligns lengths, rounding down. This
  means any existing overlap would have already been caught.

Moving things around like this lays the groundwork for subsequent changes
to permit operations on batches of VMAs.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 65c7f29b6116..9ce20c238ffd 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1413,14 +1413,6 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 	struct mm_struct *mm = current->mm;
 	unsigned long err;
 
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
-		return -EINVAL;
-
-	if (vrm_overlaps(vrm))
-		return -EINVAL;
-
 	if (vrm->flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1525,7 +1517,12 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * for DOS-emu "duplicate shm area" thing. But
 	 * a zero new-len is nonsensical.
 	 */
-	if (!PAGE_ALIGN(vrm->new_len))
+	if (!vrm->new_len)
+		return -EINVAL;
+
+	/* Is the new length or address silly? */
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
@@ -1544,6 +1541,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
 		return -EINVAL;
 
+	/* Target VMA must not overlap source VMA. */
+	if (vrm_overlaps(vrm))
+		return -EINVAL;
+
 	/*
 	 * move_vma() need us to stay 4 maps below the threshold, otherwise
 	 * it will bail out at the very beginning.
@@ -1620,8 +1621,6 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 	if (vrm->new_len > vrm->old_len)
 		return false;
 
-	vrm_set_delta(vrm);
-
 	return true;
 }
 
@@ -1721,14 +1720,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma;
 	unsigned long res;
 
+	vrm->old_len = PAGE_ALIGN(vrm->old_len);
+	vrm->new_len = PAGE_ALIGN(vrm->new_len);
+
 	res = check_mremap_params(vrm);
 	if (res)
 		return res;
 
-	vrm->old_len = PAGE_ALIGN(vrm->old_len);
-	vrm->new_len = PAGE_ALIGN(vrm->new_len);
-	vrm_set_delta(vrm);
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 	vrm->mmap_locked = true;
@@ -1751,6 +1749,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		goto out;
 	}
 
+	vrm_set_delta(vrm);
 	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
-- 
2.50.0


