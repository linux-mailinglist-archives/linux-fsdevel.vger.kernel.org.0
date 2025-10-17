Return-Path: <linux-fsdevel+bounces-64429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2EBE78D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA52188B428
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB2320383;
	Fri, 17 Oct 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l92K/x3V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GRaoTxw5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4D320A0D;
	Fri, 17 Oct 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692100; cv=fail; b=oELdsgVbj0qQlLzdT5xp5RPlF7RwD9S2n1TvB5XrGZ1DSFu+5I4aobbCv5om6kRjXdm1BlIoAS3YqgsiljETkM8veE6wfUsYSFN624yXUch/eJFLJl074XCmsKc19P4wCf7KUwyUGlCBLQit4+qxSzOxjlkiKZ2Xqp1q4SVZisY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692100; c=relaxed/simple;
	bh=3Oa1VTm2or20gyfA2SOnxJGMiEfSMena3dkenpbjKZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lz0/COK31RLOtYDq+EfioYlj106PsFYZZh9Wiuk//PNPwvNWLr2PyHdpYt94BCA6sgmsWPw88VhR4Y+cBVrSG2fGZGkS/BK41LmmjSi5inmVvJEITNFUU0V4ahh4s91B3nag2VAsO/1DvUaujXoxu1JVvU6tQtNPS6DDulKH8EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l92K/x3V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GRaoTxw5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uA3k020487;
	Fri, 17 Oct 2025 09:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1QKXq269HM9J02YOFy
	bYrBNHdfI47IY9tm5VjyxMn5E=; b=l92K/x3VmfVTu1RtzJwhBG/hTSwv2jK0mz
	NHVBCDpcztvZ7SVt8XuZGC4fkrl+OOYtoZbxeQNSk2d/hi2iBuyCqXL5M5X4eXuy
	NS9bHlfSHyCIKbRBMLSJ6xavRIYkhKsIxnzCB9TzoOb2i2hKAbhV4bDjCRg8Whs5
	MSE8YzVxh3V5nkU85jn4E2KkJ62xJY4F0rHNTk47sqAch+pK84Bb8Xpw/VgbEl5B
	MoWlnFwDtsIa2E795pAEFann+KyPw5zHH9BLRdvOOzktrje51Ak38A85TcI/cPsf
	ePj84uie5Gud876T3/NZr6VWUh/c/iUKH2NyFxeSctpDkflUuYdA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfss2hpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:06:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H6WUFo025776;
	Fri, 17 Oct 2025 09:06:49 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpju8jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIvowuU5spyLtuls9nO87dl750CY8UFLY3es1CcP5xpa3LKUC3rLSkdTLhBp/w+k0I9D6N6vKjOjnoj+5i/ZMZqJMymXnt4qfHugj2vYEoVjWtB3k6gKxuNwOFsZjyTheT71Jeov+Ah7l6ElchrcpvOolVPOQxlk4cnTLl6F7fESgYBNn60+loN8W5Dw2/mv4D97Og5Oht9Pjw0bK1hrktStHhDh6TnKjPEskN8eHcY8FhFRyNE+uKIbORnyCqmhcE2/l1jWPPiYlrA3PwJg2ZJ/GuLAXd7KLgiMP5/UYiGrYNst1Kf0KKdoeoytV0kcRn3WNCLYHV4tSe4O+/ILug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QKXq269HM9J02YOFybYrBNHdfI47IY9tm5VjyxMn5E=;
 b=fmKAEm2agKp2tikyLTwcN2bBP0VP6nirnkA9n9s6fal3pNz0hM2gfAWr4EPf7NYeogXsaXZO7GYp7RWRlyGgc1IOvyaH8CkqZ7HAhMfE0u0uibAwoBx2XfaEa2SNLwQ2q8C/WBK4FyDe+BEvbfEm3ffB1aqAwAVcxkXEnmtjHP161oX0Ys2oRaeLo5fWMNERasE+3WvILamDfPPOmHtZ4RlJQJtIKbtM5QojFL8hW5PSzlhUwGr1NXrTwTnZT2W7LHrkbbNTqHSVAC1ufesnM6ps7CyG8dgfgQPf/pTO/rnW+cM4mLYr1Aqw2BfAEDYlVIzsKLcg5N48qGEIWM702Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QKXq269HM9J02YOFybYrBNHdfI47IY9tm5VjyxMn5E=;
 b=GRaoTxw5NXRL/9NhzB7aYTzvaC10niLp4nYbtjcjkSBD7NoiZFto3SfiKyIcci8/CxAreNc6Nh7i+6SsKtKXZ0j1D8mJwvXNjZNVDhAP3cywwmNQpszR1Y8WC5x6uLrHHUsh8SjnVgy1XoDpPg06a9pkswy5P/QFlXL/yru2ET8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7351.namprd10.prod.outlook.com (2603:10b6:208:3dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Fri, 17 Oct
 2025 09:06:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:06:45 +0000
Date: Fri, 17 Oct 2025 10:06:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>, linmiaohe@huawei.com,
        david@redhat.com, jane.chu@oracle.com, kernel@pankajraghav.com,
        syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, mcgrof@kernel.org,
        nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <16b10383-1d3a-428c-918a-3bbf1f9f495d@lucifer.local>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
 <20251016073154.6vfydmo6lnvgyuzz@master>
 <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
 <20251016135924.6390f12b04ead41d977102ec@linux-foundation.org>
 <E88B5579-DE01-4F33-B666-CC29F32EEF70@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E88B5579-DE01-4F33-B666-CC29F32EEF70@nvidia.com>
X-ClientProxiedBy: LO4P123CA0180.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: c5111b6e-d96c-482f-4c2d-08de0d5c7ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gnwYy2SHA/ZAd3wcu+qkmBymq6ns+tU9lB9Sv/4tj4FvaxcDffRH5+3R8+cv?=
 =?us-ascii?Q?Xl4cDP3ntxTy6aT9/napaIDy8rjIPyNjsas3Dz7nUOwP9qs8YEq3u8ZOBDvX?=
 =?us-ascii?Q?KnLZDr1r385Sw7slnIdpFYkbVHitPmg2E+bEZaEhxqZ8qTmdpWxecIirrvpc?=
 =?us-ascii?Q?U9Eqhs3tRVJMX3FU+CK9+knzKDTMfMps0Qopq81tgLCc3z9oO8yRM0eTmRYx?=
 =?us-ascii?Q?K7VcS0+fX+eRceGXqtnxKtppfNHAT9sGS7iQrIzwoe80jC1yCfDF6nf7ITQH?=
 =?us-ascii?Q?A0+YPMBBpB95bXSfIUjMoMJKKnRetVYmJLKAQB2XftmF0SDlKLuK/kJLVZdM?=
 =?us-ascii?Q?SjgIY5hdgzRK1cQ3KA2HUCnvuVLzDRolRXsFowj2gzIkXjinvXF/+OyScy75?=
 =?us-ascii?Q?1DmumWwjspbTvBzTzgCJHYKBR993+ztSKhwINuasLF2GiBQKB3Ls8iY/XmIw?=
 =?us-ascii?Q?hJ6MC0UBhx5bInWHem1GWA0ygOvoDijiI8tdHW4arvvPNhVPL6JzC81UIiEb?=
 =?us-ascii?Q?JIQGJlgvviF3S5gtOwef38boX1+1MHILjJ0bMrUuvHcjz4F7+H9KvexUKQHK?=
 =?us-ascii?Q?+WcQBToCwmZdWU9vXoUzN4xecOtm7OnEj5aTzbrH9Ox2l8ZmDtczibksulvd?=
 =?us-ascii?Q?ymo9IgmPKLiLw2IKaqO7PpE5FQkg3XvIJO9JQWmzN4AsH5Fi8k16kHkrFK7x?=
 =?us-ascii?Q?l2k7DH+ppqDymf1S3R+9nYQPhrCReS0KSg01tgt2inJJE96D7gVwpm+b5Pew?=
 =?us-ascii?Q?bw5jaoshql1lN99mliNPTqWETyYjgWg66qRHr2n8Yh1IuuHzcJlcbMrz6qNR?=
 =?us-ascii?Q?Wk6+J3Qn1sNYxdJGXTJ7DLeinVTIkjwc/F4/1O4DVyyvWh7RMeB++T+tukm5?=
 =?us-ascii?Q?1bwo0LpOvEnh22RxscuoIgdgwj5e0JSgaFmkLdVs8swOUbXJt01Vf24Bl4vO?=
 =?us-ascii?Q?Wil7NBnC9b2xXk75O7Ombcgyj5reO4z/td/iTmYIZnUWQPtH2KvB3SrM+FEL?=
 =?us-ascii?Q?msS6azC8M9hNFKqkcAf1o24dTmfbKzCFe3vrFa3zwGbyqY/Cl0Y9XNpOxFXK?=
 =?us-ascii?Q?Cq5dgTP4VduOJTA3cZqE8kKgDvzZGStx7+r7/MZswKb0Rvd9VjNn67WkeLp+?=
 =?us-ascii?Q?5fG+KN2049I5iuHRCxY53oC2EgC2bXFyYDKIv3qZkx/eyW2zgAuppdfWe/S+?=
 =?us-ascii?Q?oYLLEQTC/4Q7G0hZ9kLJrdpmOGPtlnD1CVf1/HLGHsDuSNZwxENt6F42FuBa?=
 =?us-ascii?Q?lxCwGE9KdpTw5z+pKfF6/0BS0dx8aGCpzWbColDgLjqoFJm08E06/81x8XU6?=
 =?us-ascii?Q?1NjHiRshxZRwNF4RctOWoVzFKNaT6cxA9JAtMENgxKnoITp3xXPq+RoT5I0y?=
 =?us-ascii?Q?9mbnWmpOR8H7mt/3ptVwf2jTcb5k9ovz1kHEAs+1O6VhWw/7QSED/pjVU9La?=
 =?us-ascii?Q?UPS6UngX9e7bpCWGheDCVVT7pth15nnj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vdzYaOoIe1VYbFgzPJzqk3fmw41M04znf21+XQZwgmhF3/HkkW7lH/PfhW8D?=
 =?us-ascii?Q?7lTIB3MpgWHNAtttxXJCYFDBHJYyY+RKo64XvRV9Mva7CV5Jg0uHZVnCOZVO?=
 =?us-ascii?Q?thihOiHYCRyTvAiDLpkURcJcULkc8U1vDnAzq0DIalK4bJW+SbZhCp+XWyie?=
 =?us-ascii?Q?Ys2Su0Oa03A3mJAhx3CDkN81yEcpnwzuTfTFthXHm4hjhZsO4PsWQbHh84gW?=
 =?us-ascii?Q?whK0bJiHT/HXMZ7+Z5vJ5FaAVkBYdIHorH49c1rGqdk1mjJqTHamVKhGOw28?=
 =?us-ascii?Q?b2qQAW0sFRrwWYvaBm9nkaf3b+hI5iUZckIIQNiGMheEhfJ8W78ZRhKic7gt?=
 =?us-ascii?Q?ygF3n0jPAW0SLNF5x+3V0axbMVOaWF0+TOz6vTVNGuvlQDV/dJqKE9tcUw7u?=
 =?us-ascii?Q?KbrSM3HBKnqfZ2L5Olr79pvn3ovy9fVClLbAnNbt2c4m8jueemulDnvjEDV5?=
 =?us-ascii?Q?D+U2rT9UW17tUeQJJYKgVMbS5PyZ2eOHihWCEjKbd4sfcOfMhcqhNDETOtdh?=
 =?us-ascii?Q?Pn6xjz6+l5vp5fOSCcgula0/Y3vpCPhANPlZNzsD9JCEu2vPXXpnD1tga15+?=
 =?us-ascii?Q?02Lt/9fyS3SDSg5zEJuHINvB8Dgg3FofM0TIuBr3UPywzGh4/qdQXwvANbKg?=
 =?us-ascii?Q?SnQXoB2u6tvx7OjGyAUa0lHsbtjxwCFPttV5DRELWl3VsJhMsa06rEBrmIZK?=
 =?us-ascii?Q?NfB5ETOle+hyZNN1uW6bivZh8obS/eCu4MiVVfyusKs4+EIqtVafAwSnDeSm?=
 =?us-ascii?Q?AiPPWBGFrh8utvBHEgOHNrGBevQLWTiIwQWYCIosoEpm5BjfYQgmMhIVW235?=
 =?us-ascii?Q?qJj7jWFfIPOuQtPZI3HUwhDM68xEfywiB6fJX9nmREPKnVHgcixQ01QpAZCv?=
 =?us-ascii?Q?PL5Jk3wMCxLabML/y6i/wED5ojcOVDcGoGyWaM+dHZt/s3XoXS3rMCkFKUJG?=
 =?us-ascii?Q?uS4xh6tQ4Ck/Ueykjg2V3fVs15hysYk2Bbrxrr9VZtZkVdTsn+qncSS8fzdL?=
 =?us-ascii?Q?1mvWr4dirCRs3FAG+H2UbyuRQY+9Y7YNpkpXlcqtomuIuk9DnTIakPc7C719?=
 =?us-ascii?Q?CG5kPO2d7r5tq4Os37R/xUAguV4azG2m94H3ztq1DlA2mIo94q0z/59kaWC/?=
 =?us-ascii?Q?xN1hw8fb8JShCaG4rRTyCFJbzf0T6y6OUbOCstBCiggcbOoWcFeiHboP8Fju?=
 =?us-ascii?Q?NuwkAGJuwx6yLGExbkCc1HiWoYx5oOY8rM1pu5qSP9IbOEDnBJn8ovV7w5xA?=
 =?us-ascii?Q?+/7cybKNV8CsbqG2oeBChrOGwkWZ385sRPBehEAC3e7LfWWL7MqamkU/VUEn?=
 =?us-ascii?Q?4FSrclZAuqFEO+MAXxd7xrS7rSqkTiCP8GwPYIFY4ZEYEYpixeRa7RpH8Y3V?=
 =?us-ascii?Q?h1LUKv8/n/tSokyCrIBG409L2iI2c6PGX1wdN3Q+R89EgqkDJYaYPh+kIDac?=
 =?us-ascii?Q?k8PQ4JunNmvY6EmGHLGuYV34+Pc+gGn1pJWkR4NsifLOgOHZ7wt2xSboIn76?=
 =?us-ascii?Q?R91NnjRRC2NJ6P0u9ZlLo4UjN83k1XevfNY+hOZ9lt6bnP1tIuqrCYCjqmX/?=
 =?us-ascii?Q?+F1g31lYBc5N60gR1vS9o0FE8caoBm7FnBp/dxzL2mfbpkij507PN2GWHL4k?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UCI/Wxqd4opED3imINafYDN1jjstmeC1oHPAyOOfa90g5nQktYSBvOKxi9XH3SvoMuCW/TqvXQX8qWhHz20qO+Jb45varH+7UikEHkvH4w3wqdZtj2WB3WWz4OY72731waplQEGpdoW6f77rC7HhS0xVCgKubdrWj9b/bmA0X/SPqb288irbzaaG+mcunRbaURF5HWvaFVfa2Drn9ohxy92trPawHCFskYL19m+WLekz7mfhSdUh5vgt0nx6PP5tKw3vqoqSJIH8nJSCuoHgze2cbzlaUraQki8ooCYzcg7VxgnlsEE7eeMRuxzm29h+dxUQxo9VpAjOlQYT0ebdPKl72IsxP4Nj9D3BrglR3skcnK2+NzJYiGgbMfy+v0IhbWzXfsdwkWeAZmVnhvyaJkm6IxSLKl7EB1sCX96cA+kvgXYasKATBzhSIsPFYPmWsFffU3q5dl3rBEXOsHYyXCpjcoAqfrqcSFjGY2uB1jp9jk9BQsp4wQ5To3FWSRd6QyXYWjoZNdPrxb4rdCwF4EdOo3UwhPgii+pZehbT+McrDNs3HFZDt6l1dATZpRUQ86Je3EFCVvvwTMtB8vGnh5n98UG9WGwxy111LbFFIdM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5111b6e-d96c-482f-4c2d-08de0d5c7ece
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:06:44.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xba1qCyedmBzsg+GL73Y89NIgYq5uHtJ9YWBoSSWORqL9dV20yaHcZ16AJDDV5nW7vksXS4lI9JaSNI3LrsyjhjThOOfylrcEQE6DdvdKGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170067
X-Proofpoint-GUID: SFXi73FHBG3D4j3mvDiTi2HnT8DFy5GV
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68f2072b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=uRT6S_nvXbFMe3qWU0gA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX/9z2ofubKE/c
 v6r4tno/6oB5qtlkHcGHuDiJkCFubkZyLs5hBR2bmc68OM/tUXGBzWCwUOUbpEC+9EuYl/yCGkn
 hlbDyhyLzF3asLx+FLUu4PTDvaABUZ+wfZMtZhnrttlbKEng6c6Qh33C77ItSNILjFld9BoxEWR
 8vsOBJX+0WTXnjO85X4QeEuveYXBtVjANzwIFx/DvwvnmAW3xoyY7LSP32vglLK7cdB9HntU69e
 VJuha76TcwesLjmIE/Tgxam4PlQpnEbqSFq8bGUU4LFS7NRLDChdTDtDSpbB47PlD1oYpy/EvKq
 9EyafpmYeVh5u5ZkJ0HZ26z8EtgFfATBL24qTdAiaAdUaTut8K4SFAP3HcPhMSu60D8ANR0P3b5
 nJx4SfElewDCqHpWg+Jp9WXyjvQq77fFGq+w/iEPYToV2jqRyBg=
X-Proofpoint-ORIG-GUID: SFXi73FHBG3D4j3mvDiTi2HnT8DFy5GV

On Thu, Oct 16, 2025 at 09:03:27PM -0400, Zi Yan wrote:
> On 16 Oct 2025, at 16:59, Andrew Morton wrote:
>
> > On Thu, 16 Oct 2025 10:32:17 -0400 Zi Yan <ziy@nvidia.com> wrote:
> >
> >>> Do we want to cc stable?
> >>
> >> This only triggers a warning, so I am inclined not to.
> >> But some config decides to crash on kernel warnings. If anyone thinks
> >> it is worth ccing stable, please let me know.
> >
> > Yes please.  Kernel warnings are pretty serious and I do like to fix
> > them in -stable when possible.
> >
> > That means this patch will have a different routing and priority than
> > the other two so please split the warning fix out from the series.
>
> OK. Let me send this one and cc stable.

You've added a bunch of confusion here, now if I review the rest of this series
it looks like I'm reviewing it with this stale patch included.

Can you please resend the remainder of the series as a v3 so it's clear? Thanks!

