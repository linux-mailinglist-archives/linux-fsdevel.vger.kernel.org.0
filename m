Return-Path: <linux-fsdevel+bounces-52904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E826AE82BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F991BC6EA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80CC25B31F;
	Wed, 25 Jun 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T6wdGX4f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yr6jwF3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA96175A5;
	Wed, 25 Jun 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854687; cv=fail; b=NYQsut/cnjgxHEZAjQjRruUZ9eI0V/VM64ZvDP/Y19kfIEQMXZxn+pBMbq9Ar8zWGAvH1qrsoTKNSkBPPQe9gJVjef5Po6HKrCvXDClaRJMMj6sgCko2uHbVOsJstroP2qxbpJcU8ydL1WFtKRo8cg0A+nf9glMwbxgLMokmb4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854687; c=relaxed/simple;
	bh=A+mdfSNCYy8vBesgcg/WfxLWTHuGuMqAwlyNBMOZ6lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EGrYIVCxGqtw1Oi249FFQIgF8Msi0SE/dhfAhufuqo78BLjp0CpGaOq6hI35HG9obzrPGXw6e0pB743bcHgMme3OobHYWMZ8DfMMKvXQzaI1QL3ZiI+1rpBlRNC+nasD2IeuhVnx9yBsVk8hFVKkxrsUwjGPOrmBGKQWFqjPMxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T6wdGX4f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yr6jwF3Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAq9v0012852;
	Wed, 25 Jun 2025 12:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kEK2vRc6tRCOTgN/my
	pCbvQ5bc8vQsZKFdkqi1bChVU=; b=T6wdGX4fCjaAenUvgkPwlD9IaATIGQ8CJs
	9nj2T5pCXkE6PbMFNMoG4ZKVhRpWiVp1Soqc8AxKGPBv6Z2vgaYiho2PiS2DcaqK
	JlrIrwg2YRPJKmU4UvoUWF60S7TMILXGL2Hekqbw36aHIqNR9aCrGVKTL6lgeWbM
	0dUj06AKrEj+nlhs7otyqTbY0BxaRC2OZ50XDfJBc0w2/NThwNdvaFzMEr3xkcWX
	y0R5T3tjY3sulKzO0T7vPkTyw/pnYkkkoqbSUueCFB/xWovjxyDaEmaM2iFGgaKM
	CslJRbijcSS2rHD6XELJ9fkltHM5f+iSdkr0FiJjPUCJ2vltTGeA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7e7uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 12:30:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55PB4mer001892;
	Wed, 25 Jun 2025 12:30:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehr60jhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 12:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUlr3zR5e8/iQ1M5mizGeTyqZ3nIS6eezQc+QCMZKSc77dUE2wRyi3+MWHfLjyPkP0MeL1zJX/o6C9RTMe+yZcKFrTchfxgYB5aPe2FSdyB0wep2jYbDTbwGJucFRLzFV+2H0ng3HOCofHQcU1Cxjqjmh1hdAPR/4bvkc31GlAgUm0HX9cYy33IirKMgGf4dzWxhAcGsbQJIww3Nbm6T50SpTG2wfII2zgt0XrAaZE74UMA3CCgap1kzzYSAfeNc1bZvyt4fQ2plca/uYCD4NBT3QDpl3QGKxf4K44xJCSfyKDNIg2HoRjA9GvpCRp9rXa1WiD8E4xoIPLXE11yJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEK2vRc6tRCOTgN/mypCbvQ5bc8vQsZKFdkqi1bChVU=;
 b=YoKQUdCOTBMTgB2I8aW13jUmEQpaGbVGtfGvQbKVobIp/XxR3Cl9PNk5fDr0D8x1TBFrvsh7u/feJS8VRB+4fNF9+CQP2j8omjzsx60/N5Ikbqwah9lx22tfirggvOU83mlUXF7wji05UJMZxVXOhV42UFGDOUUrfZqAnlkByF2EI2M/2Khhjpk5eWQn7alBMTaaKMGxxCJiVkVZ8WF/8CYx5cQUCgPGpcLI3u3tO034SMTLb65oYcQazX3bLGwLCeD9+viQUkOa0QA4mTRxfOWBMb8MsNU4vbLnE37JS7gUBOlvkEpVIxsp6nF6/WXz28hYlTxT2hFBghye+VbGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEK2vRc6tRCOTgN/mypCbvQ5bc8vQsZKFdkqi1bChVU=;
 b=yr6jwF3ZCfMiy0VgFUpR1nu1pQpjfV3napAzuJ+46ukjh6nf6ktTAYUpTcxAaXC1ZG6TU4i1kVDMs+sXDsyi1E/md+4hvVW9uKQ9fz+OuXGMHa3X4N4ta0sHqsiJuvYaSP4tDKu9sP8OxLqnG95F5ztq+uDAliev2L/5oAR88z0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7031.namprd10.prod.outlook.com (2603:10b6:806:347::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 12:30:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:30:26 +0000
Date: Wed, 25 Jun 2025 13:30:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 6/7] mm/maps: read proc/pid/maps under per-vma lock
Message-ID: <fd305c41-b2a3-4f0c-a64d-6e2358859529@lucifer.local>
References: <20250624193359.3865351-1-surenb@google.com>
 <20250624193359.3865351-7-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624193359.3865351-7-surenb@google.com>
X-ClientProxiedBy: LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 6009b0ea-37c6-47b6-60c4-08ddb3e4102f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aLQ2v8mUDZ7LSlmZmLTbMf/bfGC+YyUEMzdw4lK0baDaVGvcBiQ/QKUq3UuJ?=
 =?us-ascii?Q?ANb2Imy7FewUQ0s6CTQa90btsOxv3ET5sxfH4Xr443D1njMP4bHM0oKGZZDc?=
 =?us-ascii?Q?+PjJ1UmC40HYVvJVjt6KcZRo1J47vQWwjDo8DYLEcDjyJz/tzVnJBbn6Q0v4?=
 =?us-ascii?Q?x3Ll8TS5WTHz90aQdfPSvw5KqmZDFqLeT+qB5FGPad8qUc39obVzh0iktCJ5?=
 =?us-ascii?Q?xt//JRBFSVDkB4Rkt9kbQCpwOiy9WdAh6nw0lepHZCWv64pdm/GqzKZWMTdc?=
 =?us-ascii?Q?ZC6Drq/eCs5N/WPTy8aSF5S+kHFEeruBX2UviOgbkBqMNXCEwHoomCEa6XL9?=
 =?us-ascii?Q?p6llicbFkZNsKA/rOx4S4VLqVFm1Madlt7kzJmunw2P72jWKU3aYRZ8Y+fH/?=
 =?us-ascii?Q?OpUgeoI4uisC1qSK/eO9X0dEBNANohQVH+eCMqGu7jiKu889ZN9RycN/90Ch?=
 =?us-ascii?Q?hcaMIVvzRbsL8evsVuat3YeiZneEHc4eAi3M0qNQzgd+PMtSnsJ9QnWzmymg?=
 =?us-ascii?Q?snCSTyzOZuyhU4Vs+XD1Wz3OEy7iGKoG1ZtnADKRTJbRC3jonmTq6aL48aIa?=
 =?us-ascii?Q?Sfp7YgtvLC6GpHtja3piDdHbzt6VC0Vg5Hxd4v8qnoDo7QLK+CMmnThLwFlT?=
 =?us-ascii?Q?Yld7NnP+OeJJCFcCv32c9nUEY4q/yfrbG2IWsKAfJC8+drEXPDHPLojkkkb9?=
 =?us-ascii?Q?WCS7wWdnXz6c92zD33RR3k6uAUw92tDN3JrdJwDXR0lBm40i4rgV7ySsqhcp?=
 =?us-ascii?Q?QKhlzYU94atGRZKG1CaTQQQ1mv+5CJouDEckxFrhIMNE6gVPTtcb1eaAbRBN?=
 =?us-ascii?Q?UjaP2IS8uA8py8SJKWUMLSMFCary2bfcHl4CyUbKfuroXpYQBgMuJFlcbRjT?=
 =?us-ascii?Q?OFrP6v7xePaxVbdWEMpt65d5KO4C2lI5/NYqVhOu7L2J7UuvrI3ndh4/qmOd?=
 =?us-ascii?Q?nrYDTsSFpMft2CTDwwxQrZ5aGctUV3e9njo4FwWoQN82OEbrm1/GAoWK5Yo4?=
 =?us-ascii?Q?lk1AkZuvsNkMB+Zg2wVc7+wUhY/Uz9cNOXfHpn6xOc+fQOUk3dU9IIXNf3Mn?=
 =?us-ascii?Q?+e8vjQOq7w7uhC4uja1vucDeVV1NN9Fc6ZJQBs/fcNFkMtjKBRxt2kkRxnOm?=
 =?us-ascii?Q?aXrjfNUaQO54vPvISN4pk4c29vOhepTHvI0MNh3ohpbBIlzyNhHesKWKgXHx?=
 =?us-ascii?Q?wuILr+IBmdqv1UjIugK+JxBSwqNgv/rmQcusWFNw5Fe0bvqBhZcIiE6kCvMI?=
 =?us-ascii?Q?CEZ4jOsOrd5CQ+kmV0n1CgCl8Cw3ErqzMjOueTFNWmZri5XmyzBHmUlt9pnw?=
 =?us-ascii?Q?Uo9Z6HMFB1Nc7Dth9M5aLcLC0ilQjt4/u4w2HA7h5yiNVBSdZizXP/TM/krw?=
 =?us-ascii?Q?MlN6P27pJdvdzCKzwKxIUH7EizGh9QCB8Vfgy6qqu8WKNpnpgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ClrlNEa+6TImx8gCgN2Q7ZI54ThmQtGJ1KxT83/gtlR8KE4w3LFHeE9RpLY3?=
 =?us-ascii?Q?dum7tFZ+9EVi2gmmGMLdQ7r6l3plCpbMAgjHSqQOzwO6pj/BZodHCTetHgfg?=
 =?us-ascii?Q?EQI87uqfeFw14qSCnucnYBKfi6ZXfKkc+SYlakyNUZs6uTOw7aArVLQEZcfq?=
 =?us-ascii?Q?ZfM0uGDZR8dxl7l5QcpkEE/8e7qcHWfv+Y0cv7phrPM1O4VXHxu1J4SN0J5x?=
 =?us-ascii?Q?1WMf+XIEF5/QChlIMz3fbJdviFEFd7iruTRA2v8bGih42PJtLFx5m0TxKH/n?=
 =?us-ascii?Q?pGI7sMrhJicdwDeN8Pq7H0bMOvbI//CYABFF6NrBN+Sd7O6GZE/eJB7LISqK?=
 =?us-ascii?Q?uIMtHctSW3ftFPoywvfO6mRQbGcpr0K1ZJcAIPnDuE5UpJ4ihQl8dyE/U7YC?=
 =?us-ascii?Q?9/3B+lTqe9oXlbb7Lu3V96Upl00zSOpk7zAzUDOHbnzeA7wsq4feuZD1/nju?=
 =?us-ascii?Q?yn4wyBlL4CwM8sc6W34xicO4qlOlya75sgD4AyZcUtnvIIQcnT2I4GOE8qC0?=
 =?us-ascii?Q?1CbdI8JVO/QAIogRkmnHsv+c5i9usTrXUAjsBHCdW6MxunveqBHmi9yVcffz?=
 =?us-ascii?Q?UCaadLeEJkPRZPCuSN397Y+iNM1HpRPRwrEmpVfESwQKwzOYn+aVYYxLm55v?=
 =?us-ascii?Q?k+XoF3XVOoQG9GhkR9Fy3Ybb5Fc+12mBvyx3Cvj834jC4HMIvSS+lSGq9av9?=
 =?us-ascii?Q?0j9IMLIpPGoEIq6gnwf2t4k885es3iApWcvVH8ADev67/nE9rOt5SKnAF/zm?=
 =?us-ascii?Q?Bk5u+bHuxZKAUDQnC/jumfp6sEeQeSX2llsmecbNowLse011bX34hTPJ6d0y?=
 =?us-ascii?Q?ZdSOEZVf5z3VVJOCXH2y+yUfGiGjCySPTpton75l/6+Mfhu+ogQPSabEPWkl?=
 =?us-ascii?Q?1ZINZp8ktvv6KGeGR9Ni2TzPwQj6tF/vwkOXlEHMeWlimxwogBKavhDjrlE5?=
 =?us-ascii?Q?cucczwxf9qzxA9IY3Vsk2V/rglERL1Dq4smJtQzYwZwJPJGVO0srrjndrrfQ?=
 =?us-ascii?Q?ee41icl2lpLqKxqyEsyWT/SYrrtZpxknEM32/Tq/xEpKtvlGRW7Ayi5/J2/N?=
 =?us-ascii?Q?02U+XJzuRfONAgcnxr4zlr47LRaVbPII6WxIvRRD0S3Ettmax+cuM96Jc6xo?=
 =?us-ascii?Q?Qx/PF0Ma8sEygEsmYym5EadXbRQe0B4CRH8kIL5L4m+JnjKEWXcNUsH1hYHX?=
 =?us-ascii?Q?hNsd6LCvUY3Gn8keSSfAiisU3J4bxA6gH3OL9ybNJnnBJTySpMIpjkxVaxbf?=
 =?us-ascii?Q?g1yomLMcZmVwF7GnjrigghXUq1Hc6EVRvfKZrEIK+6u7AfXos/SMA/LQRl1v?=
 =?us-ascii?Q?fHx0hOw28ciYudmgM6EvKBljbclZ3pRr7dEyqeapsXRWvL/wh4+YpUljaEwY?=
 =?us-ascii?Q?zDonUUhiDb7RhWLN8H5WKixP+bOZR5OsQIlS3hu88XPz1sWlBNh2nZT5LB3m?=
 =?us-ascii?Q?UbwNnkWj83w1v+eamhAyNgZ2ZRRUhjf878gEZU4Mro6mzrjPzJxzubNiO7cz?=
 =?us-ascii?Q?m/0jVVmrG0ehRZl7s2Vj5fbahZHv2bTr6cmp2BUoMEwYCP7KEQx7DwfeeDrY?=
 =?us-ascii?Q?GW6iY8/c7rit9taWSpA6kMWcr0Cu+qN/tRcT6qO5XOj3i7yaVy/h0Vfo5rdK?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wH+yTHOEyUkqKBKYGYlsWn7rTgvjaWY0jm0rghZX/XOq8NMgQ4ObRyfyCdTPOqAX6wHLEhYPyXz6meZxB/7fXb6Axcvhe3AJVBt+FIBHDp3jC6MVCICfDYnERF/uyrxGHpX+TfuqyPwX8kqbsvz2/dm5F5HjaBKaEzBYsH7Ik4BNCwWkl0BJ5Bg+55SEvZ+jmzXJVmJBoIIG6uri8FU0rIovutKW5JMe1ss3IgJsxGIjiDxDIktqURwm/I+RJvW/TD8p3N3JJqbDOU46ZFZc8b8sytPJ51Vsu7voEOcQpLou+R2Xi/QPLbTahmbhK2jxWt/fw0pPmNCMjwu0la75KKRXL0AJf6A/QdPvET+jJymbj3QPWzVyCxn1P2Pkhl45qKyEYcGmrERHtK7Idac2mpO30NYGeVPcpFRZQJO3bt5ZoImNoJF5VLD4qVpdZWUpuaRcpSeU0ac+h2EeJlinifXZ0nwIRxObVweAVHUtlgyxXxZr3FnvNsmAdyQhVwktvM586BCtDtzBg9/vf8O8N5piifAzvkaODYP1/XQ1CqrOuLuX3s88pklGIxq/GWAQsrD+US6YrV1W3xGtCdvqheUoefjFqtt4vVVkTi9tyiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6009b0ea-37c6-47b6-60c4-08ddb3e4102f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 12:30:26.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qThDVNt2XFY8xQXI53qkpYq48rkkxiDoVHw0RYypvGbosLqsaqd7CCm7+w8LtYArTuE3eYnA3/EamD57Jk9Y9yUDr/+agoUz+ShLI/nzuVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506250092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA5MiBTYWx0ZWRfXy6de92+yWK3m hwS/DCPLjN4wwcwfGd9E7Sum/HqxQTg5pl1VQQluHnv3K1E9RIsD1peLMxG3xff/Svb3ERPL0Fo W3v5pGL//wfKKPlsLF5dcW5wxufJF4EEJDKm0HFp67S1+1ydYxpb3FEmVfSTfDGVEvtMVLh5OMG
 FBNPfUYKtMNGlvHCwhj2ePeY0zP/LlYEE7sbm513sCYkrUziyuuYJMiH21zyOPuznZH/fTUOhQA q2YvoHE7drddleTzPuaAbXz9z35CAd9Sm+5UX491DsnuluwrSiBbup7uHyQKq1mJz8ZGn3g5RUf RwiWpdwgZey2Rsbo6624N+H7YLumTcRGSuMtlJv76Wq0W0i4Ab40SFggikpOS6RvUXCaWpCfyvR
 9toCnWjjOxVjbJ5x25duA9RM+JCuVdkipoBx3Q6RynmsehEhl2T2ySK/2JOkLEe8q77r2yPy
X-Proofpoint-GUID: MxQLU3u-gRsCS89zzJg7kWdtOt8klGL5
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685bebe6 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=P6J5fS9UEDNWtr9jZEsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13215
X-Proofpoint-ORIG-GUID: MxQLU3u-gRsCS89zzJg7kWdtOt8klGL5

This patch results in some spam :) there's a stray mmap_assert_locked() in
anon_vma_name() that triggers constantly.

Andrew - I attach a fix-patch for this, could you apply as at least a temporary
fix? As mm-new is broken at the moment with this patch.

Suren - could you check and obviously suggest something more sensible if you
feel this isn't right.

I'm not actually sure if we'd always have the VMA read lock here, maybe we need
an 'assert mmap lock or vma lock' predicate?

Worth auditing other mmap lock asserts that might have been missed with this
change also.

Cheers, Lorenzo

----8<----
From 1ed3bd12d43be1f8303fd6b7b714f5ef7e60728a Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 25 Jun 2025 13:28:36 +0100
Subject: [PATCH] mm/madvise: fixup stray mmap lock assert in anon_vma_name()

anon_vma_name() is being called under VMA lock, but is assert mmap lock which
won't necessarily be held.

This results in the kernel spamming warnings about this on startup.

Replace this with an open-coded 'mmap or VMA lock' assert to resolve.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c467ee42596f..0530d033b3dd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -108,7 +108,8 @@ void anon_vma_name_free(struct kref *kref)

 struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
-	mmap_assert_locked(vma->vm_mm);
+	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
+		vma_assert_locked(vma);

 	return vma->anon_name;
 }
--
2.50.0

