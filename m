Return-Path: <linux-fsdevel+bounces-55276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB7B0926C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3265A2A14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B142FEE35;
	Thu, 17 Jul 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o6H0Thln";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AFUTAZhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC62FEE05;
	Thu, 17 Jul 2025 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771462; cv=fail; b=EwJsNS38X2FRF4CuCA8vcaKXmX+01SvlZTM9rO66KVDBir6ipTO1Axu8+eT+ty7vGVT9ToE2NWbeXrdtFKmS/SG4T04LDUCSfA+r9/xeq+oaksTD0uOnchzyWhDf27D1yW72QdPVSOrzeCNYPZP6RmeXic8crIcMjdKwd2yUqxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771462; c=relaxed/simple;
	bh=p/Xs8QiRkto8MHKl32VM4U7cjn+x6HMWztQAecAgWuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwgGhj3owTzs77+lkmFj7bjFk2WshWmSkT/fHN3/2THyOX8TvcHvBAok53NLHmiqo5qj3BY0J9L4MsMsxK8kJsTWY10kvnXtrkaB+04In3h01k6R9WqPiuGDUtkgYjnIymJGLO/YPcmIHY6pYDaz0+wXvKORht53hoX+O4V/D0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o6H0Thln; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AFUTAZhP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGC3Og009331;
	Thu, 17 Jul 2025 16:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2lun/Fhcj2yL9GPIcpJfHamMkFSztgQ3iAqjuiMZdjc=; b=
	o6H0ThlnIsz0XObNQreLLf1LLsvs/+3QQ85WFc2VNWTiacCQlj3tHC41WXY0F3+7
	buOIZFNlbzfXIQKjKczTdVXC5y/MNbyZJxb8LOICiozs1hyKJhqEIHdS0Cl3g6Je
	ARR6wo5dlFq4bPEL9GLShXnvr0IRU6g8w8CYzVYZTXC+rbI9FchdoWzawvWML6H8
	MoHpQ070UyE+DMR7w62nXBeK+5Z1UfgnsEq7eikJNIsOVr0ou8NdYKq18vn4lLtv
	LlHawJRnN2LwPqC1M7q40Ew7f+E073A7rtB5o28tr7Ezwdvu3H6nCm3Ui2xEmBF1
	rC4ZpBjn0MRE5FQAmcralg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4ugyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFvioo029654;
	Thu, 17 Jul 2025 16:56:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cprdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blQj+bmeD4W3RCdlJIFpJWV+7A9be+IVW5lNp8tfaMiOlX3yJUOIN5ycm1UJ2+WCTV2x3GP6tJCeDRZSIQcisTx2Lh+/yLs20ChRF9JoKe4B88dU/eK/ZUHbPtOv9bEiFwmlOgA3IZhqPX0aa9WuDwdh1pzotouuznEE8QLkQa90c4OkuJJUdIA72oqnGoFhZ/IfBToQlS1hyQiaqqG2QUdX/t+NpLu2NDWtnIC9xmVkNM2Hv0swVtxJz0AnwMfc8B6fssCuK9I8s+XEanPkfFZXBBhZTnruICHZJeibGlsfxDRv4RQxmSkugoBwVujDIsIaZqlS5zt23Up8ec1XZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lun/Fhcj2yL9GPIcpJfHamMkFSztgQ3iAqjuiMZdjc=;
 b=A4Po4bfsxpHqe2A3kvZIO2BDM0xmYJfZMbp+bPNin805vChy5oyY/ZYkpuqsI0V7rnNgIw5HeeIEtNbc6MHAGuIjPGZ9Sp5UJHa1xJ2dpuvsFcF7acSHFOgOxgrmFKo+hSbum0FzJq/8AYfSAU9NbZvJXZBbeMnUm+sOzG12yJEuwXvEVVEdhd8TceuQotLC/A9hNLPvbgWhLPP4w0BsdqCOFUC9i5gRlpi6RLWuu5khskacobJv1MNuHWcKmCl5RaTxnBdqHsjwBHrhG+c4VDBsy/tb11mfC5U6inFrqbEiYMb2ywaKatrr311w0u9sWaHx9W3nE2ZXFHtpimjsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lun/Fhcj2yL9GPIcpJfHamMkFSztgQ3iAqjuiMZdjc=;
 b=AFUTAZhPZka1VQpV1P4u1QhvdajMK+oTAvw+NJaka0m0Qekorr6PBgsCJfDYQ5bC5dh6q41q2tSVymlrIp2oMdw4YHemNrji5BVa93PxdbJhyXGmcjZTPOmj35X1t6LErLWAEOWHlP6n4K15z6fL6rpxVIPe5iG4JXLKJuW5SNw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF66324196D.namprd10.prod.outlook.com (2603:10b6:f:fc00::d22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:56:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 06/10] mm/mremap: check remap conditions earlier
Date: Thu, 17 Jul 2025 17:55:56 +0100
Message-ID: <8b4161ce074901e00602a446d81f182db92b0430.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0285.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF66324196D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4013466e-007a-4a03-8f8c-08ddc552db0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/iJX/T6DSmd50a+8lNSKv1NP93CO6i8G+zfwhTmRJN0gw3Q84smY47DQfg7S?=
 =?us-ascii?Q?hQ+Wm1BFpCUsOLV2JDsmiotQ8GN6X8Hap3/Q3oxdBpCWau2eZUQOjKUQHESD?=
 =?us-ascii?Q?ygSIb4EhU3Iq7DY02JBgkxZLN3/9EksZZVoY3Q1Kw2mwS5KtO+IDolGKbUZa?=
 =?us-ascii?Q?U6sRv6VYxA20G3ussKVM7ce8GFS2AaeQy0FpsA6xHOIT2kUCkZx4TFNYYMCP?=
 =?us-ascii?Q?b0iDN4DXwVMway3AgZLxWJ3pjjsrOiR2tk8DjULUxCwZ/9hosDbLcMCk0+RO?=
 =?us-ascii?Q?1wK2d2lKUzYAjskvhHuu3BNzISo1pTOaGqwxCH3DfObSqsRBzhY/5/SwXkO1?=
 =?us-ascii?Q?IuqHNvOoQ+Xn3hEewqMfQ/DuKXvOPD3ONLZ9b7BsHEDjrwDXm+gI0Amh24Yq?=
 =?us-ascii?Q?nVZQyFIohHMy9AGzMOr14E/eLF2zVhLlSe8wNklRMyS2qPTjevCRUMByQGO5?=
 =?us-ascii?Q?GEuQ5BcQ7LZUBt8UtbIx4zhy+nsJqNaQ9RmGvcP6vmJf+oVvEIRscYRCcEhy?=
 =?us-ascii?Q?xfGO1pyabGmN8j+VakDse/kn5ZoUcYCnr7rxO16lQesreL2zkWoRuKRTLBYy?=
 =?us-ascii?Q?mUByhHZ7DVR/iS4+6kD/I1z/hVkt2mML4Yb71ed+gyjuIUKzAFRb+lG86yeu?=
 =?us-ascii?Q?42Esek/pFwXWISCR/QDzd8ZufbK+xYud62oMvYums3V7HIqEgkgXneCUClPD?=
 =?us-ascii?Q?IAPHd6JwYluGYYhhr8rh+JAI/ApK2WWMJ7M+iFrD6AbMjw950wdL4DhuGZ58?=
 =?us-ascii?Q?qfZhrg3Aqk++Agq2IHEF+9TCr1FmflGUujldjzTjNTfciGqKe/SqkMRISrjJ?=
 =?us-ascii?Q?INYVPtDXUANm/tTZM+cbEvWlp+F/DPEne/Bw6eBuWdk8szWSLikrqzDcHoP7?=
 =?us-ascii?Q?Ksvch/QAZ0Q5/7GHs/kVuujb0jWd8lBaEHTmcPkeGD+NAVvWrxr5jec1xH+r?=
 =?us-ascii?Q?f96c1JM6Q494kX5JB3ItaGfCLycvRoxlNDS01NE34G+MbeJNEGc6txsfCwm5?=
 =?us-ascii?Q?MtX3NOD/nK3+WsfZ8xBw66Bol+VUm2vCZAact35mDg1HtrK6d8vTD+4DU+ze?=
 =?us-ascii?Q?0/LbruGo3X0Z0THElDZjoLSrJDqE0HbbWm3W+40i9kHwlH7/2Ci3ZyRzZ8V6?=
 =?us-ascii?Q?iDIfYiBjRbL3JcfnpfhIjNhW7HbamAvkG1Hdht1J+7o+bVf26eDm2Rsxpu/R?=
 =?us-ascii?Q?ALuM8BsXstC9WcJn0YT5dEczmIFFPh27pcvc833gKCpxfB+QexytnpuZ0zxv?=
 =?us-ascii?Q?wOQYAmYgAB+03EYRhg4ReP2djn7JFy5vAn9HGhQsiwTCCbfugnu49Gs7TZHT?=
 =?us-ascii?Q?hTGBaULe0ecval7b7F+4rixnEJOvVepDkiCqouwAxcFnkyhzjrrKvCe+9fNh?=
 =?us-ascii?Q?iMA6s2QIGhboSmJHhnRzVt6BlnGdcTb7I/fU6dwixSdTPUy1qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9CO8LOHP+vLOXT412Qk6Lw6E+o9REMZVhPjN8KwD2U+SgLhlCT2RfrYehATM?=
 =?us-ascii?Q?WLJ2wNOdVCqL5rdFw210lpX+TGkx+Pd8ZsaPzGVEL/vuf34RK8wIqY98pDty?=
 =?us-ascii?Q?9OvuE15+TgQNGIPCs6g7pPJDgwzfMRd5nd053VnyzIytAEUEPvEV1W3Nj4kr?=
 =?us-ascii?Q?Kz9EwyKpxjdtTiqCcKxWqsyHQ5i3ih1T6+nGbquPfbn3YU8CWO81Y2Ci91gE?=
 =?us-ascii?Q?su7EBrDE2VDyurQ0A+x3xiIOSKixMWETdSknyQJ4t4N/c96rEEbo+Z/EcbNt?=
 =?us-ascii?Q?9tttxgU6bjuABzBFlErUQ4cPKYxxYXvo7hv5aHuao2DB/HuYxquoZ1oM2lkZ?=
 =?us-ascii?Q?kT7KJCGCKdJfHeV8dyZv77p2TTcGMUryxxtOJodpO8meummOyS3mO5Ucmie4?=
 =?us-ascii?Q?lm1e24NGrGJUtXfelbruUBKTuVsuoDpmSU8qTz92zg09seALRHr3tLLSF+7v?=
 =?us-ascii?Q?hDM9r8Tx9guVBJ692J2083e01ZgUbceJFWjfOr9J8hOB3eFZRdLD4uJpMWtU?=
 =?us-ascii?Q?pHarsBkTkmebU+WLAsmEepamVzDMO6dGNmf9gZ/nhZFvHEXIcBDNxSQv0AKp?=
 =?us-ascii?Q?es7uL1XOn2jqb/J/NjPUtpb19ZGXlHHcbz6ssvVcDxvnQ0JOzyHKrFEE/1+8?=
 =?us-ascii?Q?QCc9XT1vZwnNj+a6+QJGUCvPB9k507natJSHq1xZhqsT/MoMcXy7xHMPszb7?=
 =?us-ascii?Q?qTEUn+zqfH3YG1sA4YtS6vKdd2hHMsdZpaDf94QgGDysr8CU7v9MVuKEW2Vh?=
 =?us-ascii?Q?UtXKowZkbGwk3QFa4SsGzDng/njVsTbOLKpmRYfdueZoWM7R6vJ+ejjUIp+0?=
 =?us-ascii?Q?lXiFbPpowznZfdRkoGNqbe1dI+xoy2OwtzRaMRmtRDMEmP9kqFDgGLuZNxre?=
 =?us-ascii?Q?lG0J8IgETyE80jYrgwz5nt1xu0C7o5Cmrdgrb0H8mO8+LsdnN+8Z3wNDj85c?=
 =?us-ascii?Q?Pg3vxELdSsMZFWTHAYxjhRH/ccDu9rhMZeUVCpJ1TR4f0QgHA8WpM5tw2wCP?=
 =?us-ascii?Q?kvYJxFAbg+b294GG0+70J7mKzUQVbyqSBjNoJBccrJntSSA5v4VcJ6SjKz8K?=
 =?us-ascii?Q?xmWHaGlkk2qWXX/L67M7YPiU1vxMZlNJo1h4fToz+MbN1rZfO71wEXF6Mgxh?=
 =?us-ascii?Q?Qx1mG1rOK+FlXMIv47bHNWuDwkwmQFrWXV9XAlwC5rarXyBHYi4fq2HnndT+?=
 =?us-ascii?Q?KAYO6dOEQ3iJzW1Uj3blCo3pss54r6pYUlXtmfxCEiGocFNRc2ygX0JdhSBJ?=
 =?us-ascii?Q?DLoPZXcinJR3L/qGXmXWFviwjaNNccDt9jg+nF1qKwTc5aYfnOTHy+aTEkim?=
 =?us-ascii?Q?DNtva1kipBih/FWnc3aL2jBVl/HhuvcToWebIcJ3Lly3zb5NsiNKKonCAKTZ?=
 =?us-ascii?Q?tYuabvXR8zcvwvDWUOSzMPUt+Km7wrhDx+hMt3sMiWE4yn58a0r3n9kwnWw4?=
 =?us-ascii?Q?Audj3VQP+YdGnsvn0jlYTsgtA1FMuWDWZPv3c9RqSH+AP9ft4LtLLwe1l9cY?=
 =?us-ascii?Q?h+Kp3RlXmZuGzfgElKrU139Qj+4tPO3r7GHd4jzz5OjJXhV4pqUgD0vsQjwx?=
 =?us-ascii?Q?BdGkLMEYMhP23glZWUPdxX7JoWaqiifIIUJMnVM2bYKmblyT1+7oKJqHfzG0?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6kcBJbCxJfSXyERzA9g6cXYxbwujZt2TrP0rkZy4BcHHLzzkApNzGlANkHDl+coLKNIi7jOSr+iKT8TP+lbsFxhY/ImxKIgQd9acm634mzRg2L8QSz5iS6oKeTYSDX/5odEjXIHka0xPexChqJ5eEySRUj5995mpM8zfgxQW2RXw03frK7dk91HaDFCNSBkH99yX890NntYqKbCoqL/V89P2S6DVfcUHan0xEq7vbL9kjTQvlihUWzYMU4YC1YNKmcjuW46OiJGFvvHqiWz6mArBt+H1NwvEx+K731eVQ+2Y9uZyIjNFjDCnJMl16u/0cPO6KgAa/ztvHLRz7qRBRy0h49AJxrLtlbmAYqPzPHBvRqmDEC5bq1+K0LDHV3XB0x5LTOtGMqVS4tNnSkk9q2fzEeoyG7ObcDMdPWxz0yc70vThrXmcvvRFlUhRkbQU4oFa2c3TkVGzN/uhouiPVEK+OVj1ek6jg1Pg8qUF4ixsuRmqs5nEyY8oa+3Y0i2M9rNcvud2kymjvhGp3CqbKmGOU27pQPLmYtyjL44SYmRUP5E1RgfBkEGUb8BVpMsxjoZ0Ncg3K5+M9ySHU63JJDGcXKbLwFibBvj8Zb0YXhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4013466e-007a-4a03-8f8c-08ddc552db0c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:21.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5rRnqvcgtqLpkH9Xsft5+yDSyJgW3CBUNyUMhtpp2H2Hrd7aRVd4ObGTh/I+/gR8BM/sFnuHgTfPP9XPTzQHiv5gouogQG00Ee/u/MMIFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF66324196D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Proofpoint-ORIG-GUID: YZEO8TqNtkOnxKzQDnhw0XB6aEHi8-e6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfXyL68gVWN7EJJ NkMpAUfYqHS9So6n+f06xB6vG7UL+UpWJudQWmJGDloOOf3VSosI0KzM0mQF/ZtKSLMzhFTTdqb /5W8Wse+3McFfnTxKqFuYrV+WFJumTmzWdj8sw81GdLYB4t7thKkS2S/6YUOENEby269WscLSjv
 KNGp3Qii1zz5rqcTATV+F0l7m2eF+oBxiwFTVNEUPJwdvTFpaoQekzRNWurkjDVTPoMBCORo1hg gt2/vmoq47lrffziGLZUgFS6bY8Gxjej4LQrW+bHv1/LIsfJY39WDG9uC7829KM0NGl9GXLyV+9 eJMTO9/B1zBsjonfCoqy59gjUZVYT2PmPlu6oOZLJM05bBgtoZLlGibQfxV9KocLdlCkvKPLtnp
 NMojdjn0cxIxHhWdqzyMjEydDDePIfLt21pyEvc6xUPauu0fZWWs/5eez0Ax9Pvd5YCRiyqC
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=68792b38 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QQFbvnUwB9Dxs2rSiigA:9
X-Proofpoint-GUID: YZEO8TqNtkOnxKzQDnhw0XB6aEHi8-e6

When we expand or move a VMA, this requires a number of additional checks
to be performed.

Make it really obvious under what circumstances these checks must be
performed and aggregate all the checks in one place by invoking this in
check_prep_vma().

We have to adjust the checks to account for shrink + move operations by
checking new_len <= old_len rather than new_len == old_len.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index db7e773d0884..20844fb91755 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1343,7 +1343,7 @@ static int remap_is_valid(struct vma_remap_struct *vrm)
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;
 
-	if (new_len == old_len)
+	if (new_len <= old_len)
 		return 0;
 
 	/* Need to be careful about a growing mapping */
@@ -1443,10 +1443,6 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len;
 	}
 
-	err = remap_is_valid(vrm);
-	if (err)
-		return err;
-
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
 	if (vrm->flags & MREMAP_DONTUNMAP) {
 		vm_flags_t vm_flags = vrm->vma->vm_flags;
@@ -1635,10 +1631,6 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
 
-	err = remap_is_valid(vrm);
-	if (err)
-		return err;
-
 	/*
 	 * [addr, old_len) spans precisely to the end of the VMA, so try to
 	 * expand it in-place.
@@ -1705,6 +1697,21 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 	return -EINVAL;
 }
 
+/*
+ * Will this operation result in the VMA being expanded or moved and thus need
+ * to map a new portion of virtual address space?
+ */
+static bool vrm_will_map_new(struct vma_remap_struct *vrm)
+{
+	if (vrm->remap_type == MREMAP_EXPAND)
+		return true;
+
+	if (vrm_implies_new_addr(vrm))
+		return true;
+
+	return false;
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
@@ -1726,6 +1733,9 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (!vrm_implies_new_addr(vrm))
 		vrm->new_addr = vrm->addr;
 
+	if (vrm_will_map_new(vrm))
+		return remap_is_valid(vrm);
+
 	return 0;
 }
 
-- 
2.50.1


