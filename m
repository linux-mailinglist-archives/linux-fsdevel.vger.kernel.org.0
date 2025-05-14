Return-Path: <linux-fsdevel+bounces-48957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305CCAB68B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90666861FFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A214270560;
	Wed, 14 May 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QNq3traa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A9HejMVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6931E04BD;
	Wed, 14 May 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218229; cv=fail; b=YnJXNjo8EMSodqBvdadTYDEBtjH4Tfpf7vWK80QFbVOyXR1Ckzl4EgSipMua34+2NPg6aME3OMD+gcBk2XSn010YXfmjFpEW5V7KhfhXIyBY9sH7aqbqoTPnCHJZKgrYqS0G/rkHtI+4SS2/xb7uytQtLcqmePYaiFiSGi/nzRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218229; c=relaxed/simple;
	bh=qxdxaoIgAq1jYTcJfjpDhVfxaHqWtdw2/YWTa7ykpRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mid3p1zZD0/x3Ax17jQz4n4sjUzTNy/cCRkaUmHdtk7C7p5jd8J25wAe9LOuFd2y4otLTr1v9StAQ+iaK1sINWPpMn+ebCJwPST/ycJY8ElBRaY18MYHo0Eh/Hf8a1H4/eWF2gNnModiw9HDJC2OIVw4WkKc6M4t/zfMbeeOE6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QNq3traa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A9HejMVp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EACSKR016476;
	Wed, 14 May 2025 10:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qxdxaoIgAq1jYTcJfj
	pDhVfxaHqWtdw2/YWTa7ykpRo=; b=QNq3traaQNeN76mDmPkxaP1gTwLby3+5Rp
	g6wrmYO5dX5Gv1sc1MDZpjsbHJX+DxPId8HFVXZ26f7amCG+4zbVLwaxg7SFVliB
	FZ0l2d5PcHErM0kzecjsfrxn+h5Jb9/6kwG2QZfo6gOZB6yhn+9rwxeAJOFFelLw
	p56wpUWh9GgXjvqu5dmzGB3qdzYuRbjghBM4UwsiB5nVOnSSqf5NXPWFvegtx6vC
	9LoJbDh7voWUEDJcRxXeKw4f417ZFfGjW6f4TUmaegGm34LZ+ABA59fSlT4TtjUT
	2Y9cuVDh5H0K0zOpEmGNHjAJ5tgTlZDZwvjFLpidsGVDeNxa4/Qg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ms7br0hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 10:23:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9FEaF033238;
	Wed, 14 May 2025 10:23:30 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbs90snp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 10:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oa1Lvd6flYTeGkpEqSuU18P+QaD+RXxGBHUOHx4VKt/VCRtT+F4xpDy9IPxE7FQ8k9tdEUtCS7o2FYKe3cwLOLcaGhEe8s94pwRWCuDx/PB07dLeLJQnC55LNRkA33OoSIpcBx7BHaVwbhBuaEqPcT+cMBstCWdaxU4MUgdt3xGwKHKUgpDKOE4UICeGP/c6uU8DH735xIDycVOEDp3En4NkumiiVeyZCv/jmkCIq6uFzVqYCDYTZpm6/3gFpVGQ4plnz9jklkI9uoCu9Tnrg3n74wFuDeK0ombc37X7sJZ0nSHrPw/faEHUTZydZJhpmpjEBrEXrT2hcLaWhHbh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxdxaoIgAq1jYTcJfjpDhVfxaHqWtdw2/YWTa7ykpRo=;
 b=x5EMDAYv0EJl8Wsze9pAYO63q8EkFHufZpi9QfOznEJR1qP8DxQ+qzdKEz8dk6Q/nnOqfqMFLodnBGm/ud6bCldRgZt3M0ShJVNtQO9xr0iA+ix8i8bYO4ihb82Z+KeTDGIUtvyRzU+do6ET17eRegYKe7HL4CR0LLcv7QBC2fI2ktowvMNF6jjo8XvAnguK93rLoLe1Y+Fol2CHV0DNjri7mHct818n2HYbdUKOZAXltmevsOivZRZlPdZL+t58oeNNj6RBMC+cA+aN4wHIL58Ofli2NeIWDfovTNT5K12YXXkzFZuskQPljmddGescAxQ5PBTjcQQFRij0A+ZFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxdxaoIgAq1jYTcJfjpDhVfxaHqWtdw2/YWTa7ykpRo=;
 b=A9HejMVpDzruducmulKWA3ETcs/Qs71nHLcolsNdyVvAzRsokndubz0bF0sUalQ70prxCl8l15JGJnOfGCn7Hq+ZnQ+hpvqBIFKheTj/XXfwMvIvHdogzkYkJ5zeDFcqrZU8HCcPcOyRak0y8oqI7rhfi6/rgKfUuHgvpUdurdc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5146.namprd10.prod.outlook.com (2603:10b6:610:c3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 10:23:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 10:23:26 +0000
Date: Wed, 14 May 2025 11:23:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: remove WARN_ON_ONCE() in file_has_valid_mmap_hooks()
Message-ID: <e0e5abd4-3303-458b-8f55-1e3157d25cd1@lucifer.local>
References: <20250514084024.29148-1-lorenzo.stoakes@oracle.com>
 <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357de3b3-6f70-49c4-87d4-f6e38e7bec11@redhat.com>
X-ClientProxiedBy: LO6P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5146:EE_
X-MS-Office365-Filtering-Correlation-Id: 881d568a-cb3c-4caa-95f7-08dd92d15cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1u5GXXK/1d96OzmL9z6m6xwP2sRUp2sUsM95TTzU+xFWLRun0l3J2XyfuL/H?=
 =?us-ascii?Q?XaHMErmf7eqpgNHyGiAui1uXqQjauTDGdBXC+oQNFHm1qnok/ybWxW0ocmiS?=
 =?us-ascii?Q?30x75LigbtrLP8u+9L691E70kks3VJrHu+JZ2i//cTIegpLz0nIwxE+LcwIf?=
 =?us-ascii?Q?N7kJ9EAfKEAqbzfmuaKl5OItk4O57cOValwqrYYDkbRZExqisd8kiD/rkCKF?=
 =?us-ascii?Q?U3ZBn0GiK5K/mmGl6pWCYdu9LC0GuA/8vbeuCzed+OcUX/ubDU3r4wuWp+iw?=
 =?us-ascii?Q?BcJceEM2ajLEusT5bnRvpPms4ApO8zErOi9gu0lw2RHoOSTfWSLSUpwnyQ5D?=
 =?us-ascii?Q?0UMyc9Jr1BYDG34wKPNBOGjAjuH//x5jFYmaNAPUIJ53Iy4M0mXmZIcBt0yU?=
 =?us-ascii?Q?2AaIIZaqGoQh3+FKhSunhSHKAEuZ4qIFosNHSipI9UjRaB1YjbszfZWp687h?=
 =?us-ascii?Q?HaaGpwgDuN78JMHXGb09Xoh+IwnYwBZC4pzdzpQMtCXtTGvzkBMcNWhI6LBI?=
 =?us-ascii?Q?pHxRb5KZ9PvFPK5bQLX9zK4UjWziv/1Ty9nN46WR6mqYFZds4iiHaFrAgmPz?=
 =?us-ascii?Q?gFWiS/hkMDrVJ0OJI46wrPle7NJNqDvoy1w1F13g23PxYJLutiBNg0b7Syxx?=
 =?us-ascii?Q?bEU1kUfqH/zIWP97Uz0KIyr4nWriDx5he+xg+EbDEGCZNohGxj30SmVOKL3Y?=
 =?us-ascii?Q?Qxv/t9J/AJs1C1m8pjCgl9nUQ6EnVRij+3O26HHCASx5lHOflsMZGMd6pxVP?=
 =?us-ascii?Q?AYkCnjrunM0F4PRIj/1ObYrglhu6UJHE6NYHkxcYDf7L5m4bqsuqHXYxwgeH?=
 =?us-ascii?Q?q8cnQtizLzyZpgU8tSID7nSruY+C8DvDJt54Ru11JTrC47r7Ts2aItmZV72Z?=
 =?us-ascii?Q?H8HLVzFf72HXATP/1BTnQHTk40wEp44k5OUkQpyOo41aWKBN322w9DotfnmG?=
 =?us-ascii?Q?iFs3HX7mlPgqIuzs86BtOiAg7faEm65vmrhx9ocxpcOP0LGxwX92bfm4oCmX?=
 =?us-ascii?Q?EE+5iK0dCpAe+wv0vueQxL/bQviXjTAvvzwCOT4ABOLatttUWw+NYMHprR/i?=
 =?us-ascii?Q?3pj3/90Ii9StbUkC/X4oiX85ziza8qf499KyKfOvDdP/5y3HiREJrxqKKeld?=
 =?us-ascii?Q?O65Ff8KcKL2mdZNMajbzT84ml/yysa+tjnA9Lo9xmv3VvdhuVjOwgSTlhkMc?=
 =?us-ascii?Q?lr33Odt62bFRJsMSZY2425pgEi5hD8jxgTkUs5v2LTH5thfjPZBtnWgpLTAd?=
 =?us-ascii?Q?fFKvs8O19K7ZA6rQ3sRy2M2VFKqrjMzFDYp/GFgmPHdhvoYqMerHyQCW0nw7?=
 =?us-ascii?Q?La2uFHjrC2RrmZq7qEYdUUYhoH55QbF81GpVpuPJfZCFyofsCzxOV7nA35Z0?=
 =?us-ascii?Q?v4OgxgvO28T/dlDd9Su8dPll/ePQMaA6Pml4jRla9aFB7DIUYVsniKqXrBMN?=
 =?us-ascii?Q?8tiHVtO/yXI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cm70ZlIvLNwcWlvmMZFiYQDuS8CUo41vswdFY0PcRdowh52xdcgF4b0qIKLU?=
 =?us-ascii?Q?2vLY+2808u2W49zmJVTOCnzxTTHEDq0U9tKneUPYZ+9cKlSroPktDgIerXbI?=
 =?us-ascii?Q?Yhuc8JwSD0p014eqqYkRxzrHFlyu7ekWpqUeBAo6+Q4hQqM/kT8eaK768Rbc?=
 =?us-ascii?Q?J7ebUU4BSAYzT6EAIx9J3Qu72labUJEgi2+WfieoIf5hV2/KgpJEM6PmVujg?=
 =?us-ascii?Q?ffp/Nd6i2jJH0GFvJeSAM+COYB62oH3j01f/QCnliQY6lLUfEh4HnrTxKqTi?=
 =?us-ascii?Q?rBkOfmBDdisDss1IvHrGumRaQeF9VYMmStyraDrBxqI93UpYwIAz0aibSo08?=
 =?us-ascii?Q?twktX246Xh79OeVrIGcPjjtjTlEWAVSyK0BK1YDoyTPETkBLzuv7d5ZgTLRI?=
 =?us-ascii?Q?ND83ptOp7pB9OAHvYXreyZ8/mWECPBHAlynKcIRbAVlaTWpZ78hOwe+QXpCR?=
 =?us-ascii?Q?mbNc1RQU0KTl7Q1cOKks3EXOARCJMMCUfaIon0XtFrptXrq9H2SmEwHjY8Ps?=
 =?us-ascii?Q?6r687Ggr+BLdT10cAEW3rEzzQAI5lVFdUzX9HM9WD/l/2LqoOFcBSn0dFz8Q?=
 =?us-ascii?Q?kdj58ePFnhJGyPX1quIgts6eUTwuWw8SOiYZYilcY+AE9GB0otkJwuySiUw8?=
 =?us-ascii?Q?mZnFegJdDNqLvX2IrhDngyffBl/7kmgJvOaxEEsmZ0SuU4O0jJnmDu9wMFfb?=
 =?us-ascii?Q?O7cMrkR2BXayZsW2oJFVaGKnpUyT4WcKsDlg3csN3s1PYZyO1qSJ4y/Pop/7?=
 =?us-ascii?Q?fouH9lotvFm+IFxfbFEZPi4QCnq0q9e8n12iwpUJ/vBloCHU9Bdwai/Y/9JS?=
 =?us-ascii?Q?H8IhMpkU8SZspNAKOk1gvsuK8IsTeQQ17L7mwJuQNysTpt/EAVYy6FRz3tV2?=
 =?us-ascii?Q?x+elxqkgMa7LFamqu5HcHLaPuhb7LIZhHT9H8kMFVc3EXePsx7Fz4mftclZM?=
 =?us-ascii?Q?UUnEUdMMdZaG8PLwHzj561WsD1mPThUHHhMyO46aw+1u7V/xMgtyRlnnPKdH?=
 =?us-ascii?Q?MrxcF6q4keyJgapjRADcCunfLw8S9OF9N8ZVrtXqSxBI5hLgGuflsM0UUK6H?=
 =?us-ascii?Q?xyZZ72P6aRyAJ5y7bFRo6ftCPkwE9zgBs2i8HfqmTIHr+0rk7DfzW1ZsNbUJ?=
 =?us-ascii?Q?SuenZLNVJvSRocnKkPA8wf7j9gejK/SjJ0Cf4iko88eMDkESmIDpdzkUsM6e?=
 =?us-ascii?Q?9SytpORFqH56y7HfckY11oRJGad8mE4ou8rVy3P8m97+ABwKKDTEOK4bUd+0?=
 =?us-ascii?Q?R1cDqf8O+RV4vIK7+SvL1V7OCOzzKXmQCs0Ng78Tk30IdLT+ahAOarvDr9ez?=
 =?us-ascii?Q?2O0zHsq9EeEormyCLf1hOzjcEGjKLdE/IoY1AyBgA5ffj43sF+uW9bpNDVou?=
 =?us-ascii?Q?PCXMQgY0pe27skraQ3w02FFwQxnqZyazu6nGudJgcrOHmAI/tnMVUEEWBG5e?=
 =?us-ascii?Q?CyxlQSQVx0B+b6K/2P3fD+iOfzL1uYW5nKmcv5vfvp876FKbh7euhAbVSoRM?=
 =?us-ascii?Q?9dCdyPh8YLF9+1evZ8/Vqd5Ot/1QTyLOd44SPvQ+qAUMhqMteAOE/cdlPz7H?=
 =?us-ascii?Q?ndaWCGpiJfCOOrWGm3XvMm+mAv0IJvy0LMG1ZaMXSCUEbHPMSHd0DlYqEDVX?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VHqt5L49qh7EMBkSZTFInAWhxzZd34xOgjQGCZROq0Ao6j1MC5niDmXPbFt25xaWR4ne04NFJW53f82bZlN86Kaj6GxAg3M0apJ+WhD8JIzj+8VOkfBn3vlCabW6Vq5BlAxEztItS0RpFmOmnBEsaigpXagj7Te1uCST+RGsicZd0NE8VJvyQLsiwBsRT71SWrzGKGx4wjpMpLas9aAoANkNtOVoWEJkb45H2wn4Bt8HSOzXmbEbGTOjwj38DSU8/ULTbx6Z1Js/M5mq3+bNZbqzJf3Ql8ryXfkRTkkzT+DoVe/KmtOBhkRNrc4xX6eaZZY47CaIFr/7tvEmmFTCOoaVwDlFKQn+0s09WEzB5XUEFBWUi+u5px5JrPCIESpbb+keykg9Y6no4C0vlGhy6ak0iKJiLI1wPgJfjx8sjwRYxj7TByhQjvFMW4bA4SGojODBuMPdl7M3xnjprMsKo6c0bm+vJgXfzkYayS3wDGw3tTvVyAHAUhvi0CoLC08Oi6oXN9oGrW89MhHbTTQFI/as/tc2JPmI5QHG9co0gs3oEch0hmVd44j8h0nQP4Mg9Vu32eA6GvHPBuwZqRrYL3g5kKUBB1Pz9g8NOLhWFKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881d568a-cb3c-4caa-95f7-08dd92d15cc4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 10:23:25.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYTJ999e8LkTOwNy4khOdd2tHKmuRQurW0FazidpmPFVjuSFU7rdqP2OOeGIN1sv0kqgKJ7wHsh71xDAaXECT6ByYkBU21AqmB6vdkkiwgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_03,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA5MSBTYWx0ZWRfX47szxZlTBqs6 lS8d+cYeifax+P8IW9FeDST3S3k9I/s/WksjGJCugJ4eZzxJK1Tr1re8sgOgLWZt/b9NxBJ1xfI m+50e8WM4ZS29Bog/35lTr74LvMHBJzRyYsyyl9kO8Sp17mLSPQ8GCbb6DmPNH3gRKmDQIDUPKx
 z4MmgRij3yI5MfEuC0RNyEpkHDthF3Jz+Q/MgikGZBr+BbRtdwaoLY75p+9fP2moHWHyf/S+wky TCeUbK6MeGNoeUb9FgYLJldoPfnP0zazOi06hq052OiVZcXcaZu4Syhs4xGQjnb754dGZG81lLn ylCc9AG2OAJgBMJzvWRqWjPbG1WAAYtwyHExnDXHDMBEjty0QBtnuy5azTxnsMVYGtvBZLxG1op
 WhHr93SLfp81WM9wHOiZpwJV6oC+KRL8yV0f+WFP3vy9UEOP9jern8XnP7la9hq+3ccO4TqY
X-Proofpoint-ORIG-GUID: _M2VWaKqfI_Q9jDomlpgtBc7HTeVAKK2
X-Proofpoint-GUID: _M2VWaKqfI_Q9jDomlpgtBc7HTeVAKK2
X-Authority-Analysis: v=2.4 cv=P846hjAu c=1 sm=1 tr=0 ts=68246f23 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=kUoz-J4NU5G3iG9F6qAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185

Andrew:

(to save you having to dive into rest of thread)

Could you add the Fixes line suggested by David below?

Thanks! :)

On Wed, May 14, 2025 at 10:49:57AM +0200, David Hildenbrand wrote:
> On 14.05.25 10:40, Lorenzo Stoakes wrote:
> > Having encountered a trinity report in linux-next (Linked in the 'Closes'
> > tag) it appears that there are legitimate situations where a file-backed
> > mapping can be acquired but no file->f_op->mmap or file->f_op->mmap_prepare
> > is set, at which point do_mmap() should simply error out with -ENODEV.
> >
> > Since previously we did not warn in this scenario and it appears we rely
> > upon this, restore this situation, while retaining a WARN_ON_ONCE() for the
> > case where both are set, which is absolutely incorrect and must be
> > addressed and thus always requires a warning.
> >
> > If further work is required to chase down precisely what is causing this,
> > then we can later restore this, but it makes no sense to hold up this
> > series to do so, as this is existing and apparently expected behaviour.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >
> > Andrew -
> >
> > Since this series is in mm-stable we should take this fix there asap (and
> > certainly get it to -next to fix any further error reports). I didn't know
> > whether it was best for it to be a fix-patch or not, so have sent
> > separately so you can best determine what to do with it :)
>
> A couple more days in mm-unstable probably wouldn't have hurt here,
> especially given that I recall reviewing + seeing review yesterday?
>
> Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

