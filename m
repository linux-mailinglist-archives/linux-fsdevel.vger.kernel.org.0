Return-Path: <linux-fsdevel+bounces-64220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6CDBDD9F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467463B8BFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8B30BB9A;
	Wed, 15 Oct 2025 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAWeDoHx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dY9lBCY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717D298991;
	Wed, 15 Oct 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519468; cv=fail; b=NsfdlGPvUefsf7GhWL33ikaRvJppBRMnVMxyBmkaNuLGBwgRpy5voxuf5vWBaCrNdCxb6FEGLAPV906JDZbXqdngvz9xNm0+HSyUHDYi40aXnOpikbSmdeQPX5AntyYjuDuvZKjfdged5pi5L8qwiciROjNIQnN8/PQtb4UvZwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519468; c=relaxed/simple;
	bh=SlmLAFLINqreFWPI1+0X2iWMmP2d6wJfUbmtABxU2Rc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NyS/qikJPt7puKZE8BZgoa0mTMyiaTdyXI+yVRnkqMy5GXh6+JZVfJx6W3v7A49gYCSrovuX8GZe/R/zwj9Lf5wobVkS28r3U7EqptKffncVtBNsqzarNh2DXlZKn1m33xA3OVZnjy7+azjXmLJU/9soOQxVc5dSzZYAoUQKh5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XAWeDoHx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dY9lBCY7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F4uFeR001031;
	Wed, 15 Oct 2025 09:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SlmLAFLINqreFWPI1+
	0X2iWMmP2d6wJfUbmtABxU2Rc=; b=XAWeDoHxm/La57tq7ez5myjOfLw47nYDO1
	e4z5bNJIVIzcy9fzZXz0gGbDBEz8KDwPnMuXFoK9FJF1pCcjhNaygw8PZ5whmC/e
	x3rLI2l9oMyZWXKjLH/nVyObGf4axTin4h818yMQZT4n3nxSWXjgfz//GK3cVwM8
	zX+9Wz7qV8WgDnvUE+a12h3X5VYAc7twuec4l/BH7LOLD9JCUT2BuEDcBEzCDe6X
	esvlH6GZHezyyg8+pVjmZwIQRoRJi+KIOBQG/LAlAsVvy2Q1GZQlfpAfxnkHZGEu
	nMVQIMpvYK1PYYY4k77ymoLc3ToCci+qjC2PuebzNfRuzrPEyXpg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtyp754-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:10:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F81cP7038343;
	Wed, 15 Oct 2025 09:10:35 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpg43ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:10:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPe3sqG7LdK8KRvplWaUUltVRxs4Lj6egNJSkmzqC1leSrAscsHLHk3+VwNlWdxC92uIPJSaPlaz1LV6ZNP109GkzY32TzZD/Kr9eUAvdyy90CZm2AotoMi/Kl4ExeUzcLnl4A2c0bpoe6pyrdzA60xXsiAV7UzHVLxHix0SFbeNDzNhOFAuEEfZPBFV4Y4aQU9Eqm3xTn8h8SMa6oRhA2Ul6Io8ThFnNWbROsT8vPkQssCiMj2NmuKsR/QaUKGxL5mhIP8s+2glWxzaMvZbJm846Ss0EFd/Dpx8QYu3hJfu6fVHzPLCfJTE7KJoYnOMzoLTBv03xVvgMDzWui6y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlmLAFLINqreFWPI1+0X2iWMmP2d6wJfUbmtABxU2Rc=;
 b=uCbCZT8ajUQsF1k8PzHr5jyI6SH925gi0MhS9Xo3GL74TgkSHc1Ln+fUeye20VhY/gdjpgRoUA6uuk4pBhrfWNj+ZmrQEhwrxlpgPiNepMJDFykU9xAKpbWGYtFas5uRT4nuksNU2M/K5o658y+bB963AeWKaBM+vr4aztG8J6yUHfHPeqhxDW0kFi+QP3/YvwDeAx2S40pVTzxQVJcLZakAmrC3WarNwRyB2IPBEKNJvCZfmUg+W0O+5oa2WKBuz/Uy+E2xOE4z/O6dH9xoszUgeP0UT1DongaVda7vlYV/b6eISzPmXa8l3J5zHfztxpbRe5GWz5XHiAZH1J94GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlmLAFLINqreFWPI1+0X2iWMmP2d6wJfUbmtABxU2Rc=;
 b=dY9lBCY7CUVCY+BSqSxdwxTpYAH6FQg0uEDyf1bMhHs0bbMuTK6N0ARVgX17WH++3LHXibpcoenS9KESA4R+mqyFeXtdR5ZxH3qAA85w3ETJpZbIZuzSWq3l2CqOB81IYSJ3dBszzeFVSAr9BrrMSPvoMKonkkJl8zpC1SEeNTc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 09:10:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 09:10:30 +0000
Date: Wed, 15 Oct 2025 10:10:26 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Hugh Dickins <hughd@google.com>, Kalesh Singh <kaleshsingh@google.com>,
        akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com,
        rppt@kernel.org, pfalcato@suse.de, kernel-team@android.com,
        android-mm@google.com, stable@vger.kernel.org,
        SeongJae Park <sj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
Message-ID: <e539c9b3-72cd-44dc-b4de-15376b41b56a@lucifer.local>
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com>
 <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
 <kqxweui7gdnnwu6gucnn4ez7cwq57xih43p7dgvqa7tvfc6vjg@b4alxiizejsc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kqxweui7gdnnwu6gucnn4ez7cwq57xih43p7dgvqa7tvfc6vjg@b4alxiizejsc>
X-ClientProxiedBy: LO4P123CA0597.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e0c658-20df-41dd-1c4e-08de0bcab098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HN6B2Bz4QeZ9qUhgVHgU24aAB/iC3yZDqQeAAJWtVE6pBR5l8FQwvrqCMQZz?=
 =?us-ascii?Q?5EQ6Fd6vJ7toXyHLybtXD9Jog45CPsZWKHeuou3h5CSvSV6kT7E+YeLibVqU?=
 =?us-ascii?Q?yWovN/K9X1o8Z4R9rTzMYDh9UcwcVt42qmfpfSoHyLJTZ257mzwLZiD6OLIv?=
 =?us-ascii?Q?M6b4HeTso/emlyC6zWE5RwWWhXo4UBFc+ol76MzB5aup/nAG0KpBMvtHdXH3?=
 =?us-ascii?Q?EzlS7E92ilVXemxNIiwribBJMdNFsXbrpRXc2YNs/d/GYtI8RUIvUynPbApn?=
 =?us-ascii?Q?ahPu69l0E98GAo3TyAv7ebysFw9ahlGBz94J/V9iJzmIjbLYwNBLT+F/dKKS?=
 =?us-ascii?Q?DqZde3540lkEFbeWVZ4hHDLjlj7l9kERbG4tcE3kq2Se06uW8Z9ahnmm6OyS?=
 =?us-ascii?Q?ccIe6uSvErvCttGUgbRtjDoX0A2mGAcQqwydY0bqSXxOwvBZQxUMDm307Zj+?=
 =?us-ascii?Q?q0wo8/P36D6EXf5JDXFSh6w+v9odiJhFvpBgwXvOUGNipY5GFjPghGy0Opre?=
 =?us-ascii?Q?zWqFEWsp6X3YJ1lZW9cP3pB2BO3T/7utsPVdVdXdsMSmCNYss7bfyb1pBuXW?=
 =?us-ascii?Q?hupN0o3lxYM/eCJHjIlXsiAhIQ+b4Z9I8UKrvVSmGNv1RN/6EB7VN0xXZQ5a?=
 =?us-ascii?Q?fhKGoXwKcn4XGPuc3PT67H3EZxRE5lqhZMAdHkxUSEVVQWbcR4Sq880rA6pf?=
 =?us-ascii?Q?SPgoZyDKG8aYmTLq6Af3tjHfpLRXKQF9bGpfZuzeOSYSjAP6YCKGCedL5rax?=
 =?us-ascii?Q?vStFX4UhxyLNvUoCqsg0ZfP2XLiaRSirTDUgKvDbHKWGPN5YbKPkA/w1RI9p?=
 =?us-ascii?Q?e6roAxBaIK7y5LRO5bLH0a39Jyv492+Au8Aq7W1z6i9pCGF0WhlyGw/qBiYG?=
 =?us-ascii?Q?nNksFVu0ASXwYplIp9+/R8Q1JMnwyRscEov0w+Yt6Dw1SI77OiMNyFd/7FK/?=
 =?us-ascii?Q?+9Oh0EO0DaFZaizba3wA/K368NoCK5niiDAgZlktSBH65RILCgGKVaTtWwfm?=
 =?us-ascii?Q?JNX0ToryORdS/uel7eVwvQC1QVMnhblGWVvROwUm9ew4bfqAXXkQ/QmhBsxx?=
 =?us-ascii?Q?2rvuJRYAwj2KIy9O4HEHvz6om/tUdIWSTHdQDaIyyhZ0WMcSaKABco3gI5pt?=
 =?us-ascii?Q?8EpuO0xfe/nfZq9LL51aza4/t5yqgbRpEspDHIJyM8c37Nqdj6M/+1dMqHeW?=
 =?us-ascii?Q?+kLeynDdZwzHUh6zbm0yakehtj7zVNiygKp6Eu/ENzgSar+1dpQOZL8J7PtQ?=
 =?us-ascii?Q?Da2AqkZlSCRkMJK3vDiTWdfEHtQZAVRdfWvV+ewhQ/O9JejQiPP/LXw1+FO1?=
 =?us-ascii?Q?9S/fHnjSL/5PEtgoKNqfe4aYyS0uZKow8rvqQeqPu5Vp6t9tXepnLsUYZVKP?=
 =?us-ascii?Q?8wz58ej3Shb0Q7fXIY4RQcvvRQ/qQjVz/JIIFkTI8iY7+pO+DhzCJ+TR0AEy?=
 =?us-ascii?Q?NzjQSi8Yk/A/j6egWcy26v58n9x54vSFxDP7ovgZ4dUN53K1zpEwiVHvA3J1?=
 =?us-ascii?Q?VA1DmvhFjvqU++U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+c5jsFu/tk4N+jwQek3kPVkU8/9B1TFHIgse83gU/XrTT0PLNYYZWQ3q0Yay?=
 =?us-ascii?Q?3+XTCfFVMoO3lRv6sXsr83pB5rc07/tgCDXrcJbSOscCLX7ryKSBmNAyZMfv?=
 =?us-ascii?Q?KRC/tJrR6vk/t4w7COBllVM0cv2fT0CXCeCPQBu5d2tmFixdYySPPbsA+3cN?=
 =?us-ascii?Q?9y3emYPeSdmFSFIWv9HzIwPWBW9xJdEVoxDkrcNqtFg1W46AWT6gyknDxBTk?=
 =?us-ascii?Q?rXsfnyP2Sx1fhjbMLrSlbWF4TFdHxPOOiuHOGnXdqJfHMY3DYr6feNXUcGEy?=
 =?us-ascii?Q?AqVBZstUVKEoXVemwC9cr2qjy1uDalVJrI38zVUBDlzarapIByrHADSEevQg?=
 =?us-ascii?Q?AHdBI5fST/oY/aPKM+Lt6/V9MgRQsq/KNQzDHIn+430eWnBS6Kjc1OV8ax78?=
 =?us-ascii?Q?QfkFA9oj4iU3z9aV3shQEDhC0p5ornqiJJymzpNaFgC/Ci1Mhu72c1TKkR+x?=
 =?us-ascii?Q?knbcPzuCe6BlFHnN/vvrIpei0CMxE2ZjzJUBdvSC0VHlydDir978UBEc6Crx?=
 =?us-ascii?Q?LLyfQwjQz1YSoCW7EF7P7QTF8B8Vv28Sl9GWiFw6vqoMOEPtiNfSh7m2rQVi?=
 =?us-ascii?Q?5eEsw7JAcZaU3Y5JHnsKavNtY2gc8YPaF563xovo2BHZHAjMc0DVvqoWeism?=
 =?us-ascii?Q?ErUb3mQwgPpRXPS1bifwzmGYml58KU5YoTI4tt1kn9Ftyrvk0X3DbFz6szs5?=
 =?us-ascii?Q?OYGhqIeYRIAoeDSqalbFUaD+tOEOCPu3w0lGvUcY01sC9DucQjt75FGFf4pz?=
 =?us-ascii?Q?AKVnvGPgv5p3319mWVvaUKeUdCGtrEw3ihV8fLiQfscBzv+ydmMMY6SSS8v+?=
 =?us-ascii?Q?IKnRjp0EbACVY6tXAp1ylXRTL88tLRU8Vt2vPwD2kWukuNiLNVC1oXE0tgrp?=
 =?us-ascii?Q?wKGV1eXoVbe4wRZ1dBALQAkx5HYt46wLHtooNJY0dkeGCyw5W4XxUtlCAKca?=
 =?us-ascii?Q?AROhV3Ok8F33mi3KNRbAhlrh5o9vGzgh1J+g3Vr9yK3MDhE2oz1FlX4zgDns?=
 =?us-ascii?Q?UPDC4ro3/McdrYsRw/ysELmypNf5VGViLFAOB5yk9Xg/9kEBvQov3Oyqhtvt?=
 =?us-ascii?Q?HHCk+UKlvDoIHq9Oa6JEpzSsGKfDbQMa6fQGF34sGYGOs+VuEz0wzEbalMgu?=
 =?us-ascii?Q?amJH5omDdWz1ywj6fK2CE4hcMkDrLktJm/bdkidgDJ3tl0y51SHtlKy7LPgh?=
 =?us-ascii?Q?WyU2TI1B3ldqP/Gfjllvf5GFNWLiXGheby5CZq8qTRYZyEMR6sYJK3s7oNKd?=
 =?us-ascii?Q?wyhQGYdGp/+yPQxko5NDusY8hdgE4VttUFuaTtO5/KZ2qwyCdt/TaZ7ksdyJ?=
 =?us-ascii?Q?nnKanpPU04EAUHJWq/VuSmMsrRA15S3bJu/R9sORRfoQHg1jOLzi9RZ6WYXj?=
 =?us-ascii?Q?3BnK0bUF1GTJ9IW0zpkIRuUWXR1IlByy/3Szs97TI3eGm5sRqlJy/fKG4SIA?=
 =?us-ascii?Q?kiSlQwF4n0GZxdpV59f2xE5NBAOUN/KojPYJmeutOm14oB6QtmK4teE+U45w?=
 =?us-ascii?Q?vGKwLpBmWBDXHn2n0EZuQz0GEZsWPUT0eMMVm8v7poUiH5Kc72i+qpt6toUC?=
 =?us-ascii?Q?rG4Rmhl2i8EG393ah7fZcTeYVllMBdhbCR+h5qX04z5umjpz2qyP3YqhBq9j?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	geINo7+ETKH5V2yRjMX2cc42J9fCwgMrfCPwNa8CllL2GFJjzG8L8FiHBVz2HIWgOY44711LfFsLZj9IxCyGJAlVoK/69hJt30Zta3elmzpVLgb1F2/JumIMwRN5ZB1QxERKhQ30/mk1KoiQCMTxnwY2QHQisXsuNPHUrNLsjP4tamyBqZsu2iobY1DQESc2jNCtfxGproGPBFoH9Mqh08KpnnOlH68VIKKC0VtQmtPmSxjXQC5fcH0gjAoeARRh1mvaEqoDkKtqLPPl0QbXex7sk2deUBvJyvyfNyA8jFyrU0zVm7dLS1SIF//N2WqMdtNI4iHdsvM+GYcofAOVBhNVK8PJtFNkZk6bqNKuQnRgKuESZ1spx6GSFqvhcQQNdjCWgv7QpxyuGuFIWb+M/XaVRypB4Nm4aE2gLr5l1Wr1vsKxNEVMHpsIZe4uK8+acnsXO9yB2Vcr4xWPEPvYLoups1VXwBWJnZTFZQUhXCQn80xX+HPbpHRJx6rcNU8ViAQKBCcfemaKJFfmeeHLTaDYtZy5YjryToIfbttScn16r04u84L3uW9VPcAPmVW8gwSLvW9HM5BDYcrBWswp/ZcosbG2Gp6EmCMv9jQ8mgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e0c658-20df-41dd-1c4e-08de0bcab098
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:10:30.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BruOno2Zp5IdTNDagYC9pqdR8mfOjJrg9rylHtH6j7NC57u7qv7g6uwpRABQvtLrLSxP0Rm97DurejG/ufm8HZY8/OHzz4lHNBdviKMM9U4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150069
X-Proofpoint-GUID: g2g-PFtYzPq0iREIF1PCWlZKOjOSikfN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfXz+4VgMnvEyM5
 KQIytvLT62tG5Vj9oXHqwolmFJBrmPdXjIqDk+6jOO6gZtVJWhQEcVQvn1xj/Hzx+fHJX5S/Lwy
 dcmXMKXaItok2nHcXA/YcBocDmRo7anPNudDHE7r6qm4FKOHHwG6I0+M0itSnjQnepLd/UEdpZZ
 y2rsUM1kp9+Z8hgoi6d1/RCxgfN5w2r7MdTnb7Mb68mAFzjqhesrO241ZTL5xinSPcRp5uGx8to
 vyECdCpaP/L6HUDcvcn7sIdHaTY9+Ne3wnttxRfToDqaA2oX+ejdiU8Zo7dcTX1QUM4ef0OwhKW
 zx1gOxlnidDpaxutoDiiEUvIPPcWzZqCU4PgYeceefxj+91yq9xm+hkxBweiX6ns6aWpzHbzYXn
 W3E71OzmkuOZxqZDY7dcx+448YDKg8yGcTHN1iK3NG+ilmtcXhk=
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ef650c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-AbTh5--ipdtio5tttkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: g2g-PFtYzPq0iREIF1PCWlZKOjOSikfN

On Tue, Oct 14, 2025 at 01:51:31PM -0400, Liam R. Howlett wrote:
> In either case, it seems like a good idea to adjust the comments to
> state that the count may not change.

Yes, I am busy trying to catch up with my backlog (do intend to look at
this more closely) but wanted to say - let's please document what we're
doing here in a comment.

It's my firm conviction that we in mm need to eliminate as many instances
of 'just have to know' or implicit knowledge that is either undocumented or
tricky to find (buried in a commit message from X yrs ago for instance).

Cheers, Lorenzo

