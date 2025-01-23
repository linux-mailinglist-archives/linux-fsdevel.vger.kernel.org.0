Return-Path: <linux-fsdevel+bounces-39979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F9DA1A890
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF57188F65A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E6149C54;
	Thu, 23 Jan 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kcfi7CHP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nVYnyJXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621E156F21;
	Thu, 23 Jan 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652060; cv=fail; b=lVdeWMKSnRHewsOhM15UW2E4eMkTOTZLicqdAzwmGsclE+MNt/1YnFEo0W51id6ES+ZgKq9koZePWvtBV+pfulRy2z+eCiBxJyhCkyjALJ8n1Z/fL2EsUWsnz0C54ldnvdQokDv2dIH6+b2WEvWtInhsw5io8jZev+cRZVWosms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652060; c=relaxed/simple;
	bh=mcr3PsvuMhZPtkabFBo7AouIBZgr+Sy5MGFmWp+oNls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mpoDEMK745mvMaKyGOJ6WIC2gOxbRa3FueLmN4j8V0SkVUY01EGflb/5O48W/B73QPsH6MgrSq1dKOhz6JXhsADnelnEBNuUj45ZDj2huj0/eaL8pUpWCjgnIWLgRcsl7rV94PZr6+G9OjpAC49cCp6xZIF9+e8hopIjDzvE1gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kcfi7CHP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nVYnyJXU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaVXk025538;
	Thu, 23 Jan 2025 17:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qbV2zFf0BugGNB6a17mLbVPFvkEAdHl44933WriR2F8=; b=
	Kcfi7CHPj0CyC1IidGKu1VYWLJnPbafqCDpxieX5tXNSRQzUHhbipUbe7pm2LiXi
	RrmKZRaohvG1yfJgCYf/u3wGarSA4tCW8h3kdSuUGgbVJj4L7us2Bng1P4b7K+jQ
	UO+C9/OHjkQRENiTwvFeFUVYnHGCS6OA9fo7Ml42KeV0qKtH0DuAeCxU47fl1m0N
	Eqba4fAIejLQ1gw3NocZkcPaAKiKbzxBFfwmZZKtnjgi4QpY+ZgCOrP/Kv2Z7saK
	Gt/4ZoBHn3EgYcnZYyzZXa3CC30hZ8LQGS5YOPubav0Wjyr1Rk2TQsos/qWxTj4w
	InutEvj4G+M3w+vqRgjE3w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awufu6me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:07:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFrRpQ018931;
	Thu, 23 Jan 2025 17:07:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c57rs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUf7SE45ax7zccTu0uVniYCbrYAsRVQP0EDpH4aQl6Gz7Fr6JNEcrS/uV+RqoVIL7cupaWv3T3aCR5V26bLPZEHmD3mDCTaaTjPZ+c/tWQpACo9nxb0+veqcPr46IrpQfcpqFhkwLCLgMTzzkY8Wj/CGpSB/AyTpSjWSeyzysFkEHmLJuDgMP4jsoHBx9xWI038x7mo5dBvoWx9sghZa/S2qF5Z9sMDi/hcKmU8gzFW/HQRHOAsAGptSuCWhQ3XzYzkd1lg9/NPSWMpAqTNJN503BbtsZPdWq/4RncsLmrKD3sG7l5sV+vpYeviRiU2N4hvJqD+1mwhsdRY9qfCmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbV2zFf0BugGNB6a17mLbVPFvkEAdHl44933WriR2F8=;
 b=Th+aqWD3WUnAXZD5ytb2gpWEZPxIKgdV/gSS5eMSnJrWoSFU+92dcEMGRCFHXe5JVjy0NeUBOpuB3/Rb7SO270VVEvsO3osfKZ6f5c1iU47Sa1/Q+ISEIVFLV2yo9/9UOT7lS4Fz7iHCABUcZft7Z3rpMYd41pohKJ8Jpm/gSfoAtLQ0Z2s4HsNGMIT8Z+QOrZ9w8WTjyj9N0jTUZ6Dbo617kGCaegBrbMl9fH0NGMHbS8Q712I4bJNEJp2UVpHGH1NdLoYp398AKpMMI3iMPhYgVp6Zo51Wx9OkoSRQYieEK5PCg8QT0NIDB6VWabEOO79ICrPWkJeDkHxlkR9JDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbV2zFf0BugGNB6a17mLbVPFvkEAdHl44933WriR2F8=;
 b=nVYnyJXUZy88e3EGB+KbV9MbaxlOeoZtGPjQgh7vfo9nBn1gut7lgbTMmtPmEkUAb5T+C9ucYKBE5bW4EYT1BUT0kgMFccoMRjT+9w5o1IzPxVdPvj/SrPeSZXnIIPxTExgADybTxh9ZSKlqfQyHsYFVj9bIhYKTM4gAbLotswA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 17:07:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 17:07:15 +0000
Date: Thu, 23 Jan 2025 17:07:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Barry Song <21cnbao@gmail.com>
Cc: lokeshgidra@google.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
        akpm@linux-foundation.org, axelrasmussen@google.com,
        bgeffon@google.com, david@redhat.com, jannh@google.com,
        kaleshsingh@google.com, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com,
        rppt@kernel.org, ryan.roberts@arm.com, selinux@vger.kernel.org,
        surenb@google.com, timmurray@google.com, willy@infradead.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <38ce85e9-9727-485e-b232-bb285ea24f31@lucifer.local>
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com>
 <6aee73c6-09aa-4c2a-a28e-af9532f3f66c@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6aee73c6-09aa-4c2a-a28e-af9532f3f66c@lucifer.local>
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY5PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bccf664-6e0e-4420-61c0-08dd3bd062e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWFhU3lTUGxyODU3N01WRmZYT2M1Z1FKT2FWNjF4VmlYOVllbk9NbVN5dHhM?=
 =?utf-8?B?U0svQ1Nsa0pwVmZKK3l3VU1jVEMzdlNPb0VST1lnd1JNMHJzWTYrcjQrMVUz?=
 =?utf-8?B?RktiUnNUbXEveEh5N2MwK2FUODJ2cU5rdXA0aGRnWVlXajVCeXZCUlA1OWx4?=
 =?utf-8?B?ZHFicWNTOURlbDE5VnJ3MkljZ0dqOS9VVEZwYm5vZGRWRm9QcjdVTTFlKzJL?=
 =?utf-8?B?QzMrbk94dzRJdllqMXNFMkpUeTM0R3F1N1RLaGtyU21zOFkrRThKL1NpYkRV?=
 =?utf-8?B?Yk9UTWxaeXBsVk9jbUNydm9JSWdXMHUzaEN6RGN6RVovblJkd1djSTdTc01O?=
 =?utf-8?B?UDhtODRxRVB2UHBxOEJveEtOMi9aNDhQZ3ZpMVpDbVBMVHNxZnhnQ0tCbGJa?=
 =?utf-8?B?WTljcFJISkVzK09ianNrb01tRnpoOGVKSG9tMkhVd2FBd0Q3Mm1PL3lqclN0?=
 =?utf-8?B?OXZKbXJzTDliZG5CTnp3TzBQelNHUm5TcVFvRGp3SS9STFptZCszYWFkSGcz?=
 =?utf-8?B?d0x5Y3R3Nk1zcXFwV1llMndpbWRnMFp3ZmMyY0dWSmE5WFhCcm9YTnlqajVt?=
 =?utf-8?B?clVhTUtwZjBUT0hSVzZSWkl6ak10ZGN6TzVuL0MvN2ExbzNyWjF3SE9vdERs?=
 =?utf-8?B?NXBIMXlBTDA0NGQ4bHhQeHFMc0VDRmtpTEZ2ME5PZGpCelpqNDZ4VWpoNGlp?=
 =?utf-8?B?S3BvSjVMalFiU2REZ3VOeFV0R0h6ZWVraXRmRkNlQXN1T1F0NGpkZmNjUHJp?=
 =?utf-8?B?VHBTb21MSkxXdjBFYWFNMXRLQUNXSVBINEpYZUdVUy94MU9IbHRnSmlsYmxm?=
 =?utf-8?B?STZ6WERkOUxBYXRCdEt3ajdNdDgwQWs3M2NBemFrSFBoR2NHKzNQY01Bbjhv?=
 =?utf-8?B?dXVaU05hdld1ZVZlQUFzS1c2TkpseUVtRW1hNzA4dlV5aFBCRVhsTGowNEgw?=
 =?utf-8?B?b0V1NGhCNTBZeGpzYmVGVjJUZk9TUHhXNW1TbWNaaTBVNDhCN3RCWHloYXpB?=
 =?utf-8?B?bVc0ZU16Ykk0YWFBN0pxczh2T2orYnhaVnZzU2c3ZmVNYVdIRTl4cnR3Y0Fh?=
 =?utf-8?B?NXBzaVhEeUVPdS9pc0hTQlFyamxrRDRnai9iV1ZYa3p3VlNjbnNpclhmOVZ3?=
 =?utf-8?B?bkRhMDVXelV6RHo3TkdUQWloRmhXZkhoODMyVkpieDlxMjNGRlFoUy9NTUI4?=
 =?utf-8?B?UWhXMStaUTI2bGlXMXhEb3A2amdMaENnQ2lkRWZPRzh5Z2RDbnpBS2UxdEdx?=
 =?utf-8?B?MDhIU05HWU51SFZPT081NnhPNjFTbUhTNmlBbG9ySWhGUGpxeDJLbG5NbGZq?=
 =?utf-8?B?eXU5TFdPYmI2MjdTeG12MERIOXBUK1lBcko4bjh4c0tQMm5nMWZ6M1hJbkx3?=
 =?utf-8?B?eXNrVEIxbFoxd1VXVVRnYkZCLy83ZnpIVEczYW84NEptN3VsbFNlaHNMajJ3?=
 =?utf-8?B?NzdYbzBYbGdQTlY0MFIrNnAyWnhRWGo0SS9RbmppdDE0dkI2Um0yUW5DbVdS?=
 =?utf-8?B?MStQYVRMODh0QWx4K1RIRmF5M0RPUVZmMW9QUkFGRU5kRXVwZUZ0UWwrRVJv?=
 =?utf-8?B?ZXU4TjN4amFtNXRuVnpvQXp1VXVEeVdPdCtseG8yeDNoZFFDTXF5bzE5Q0cy?=
 =?utf-8?B?RFY5dWxZdkJaUzZHTXB6QTFMcnV5Z1JQakYxd3ZsYytJY1F6UEtMZFd3Ymo4?=
 =?utf-8?B?VFNmQ2xvRUtGaGxSN3NsMkxOSzl2U2hEWWNMN1lMQmJrOEdac2l6VytHY2hy?=
 =?utf-8?B?VEFMTWM2bUVjMjcrSUlOamo5MHVnMnArN0xqZXQ1OUVOajUza2JPVjkrSysy?=
 =?utf-8?B?QWt4SGowZ1BEQzJRd2U2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bStqbEEzTkNhc1lxZFd3eHd1MGxzTTk1VlppbVJUNVkwSU9US2o2VzFEQVZO?=
 =?utf-8?B?enJXQ2NnRkJXQzJKY3hUelhUUTBJMVIySlNnQUJSb1RxbkVYT204eTRTV09a?=
 =?utf-8?B?eHZqdkY5SWtpbWQ4MzNSc0MxajQ0THlMQkNadWdPcHUyVkljOU1STkhGVGdJ?=
 =?utf-8?B?TmtwQnJoa1dwR3lEM3p2cW9vZFZWSUsxdEphK1Z4d1RWc1BjQWdWYlY2cVRs?=
 =?utf-8?B?akdtM3l2QWFTaHA3Ymo0L3RPWWRtR0JsdnFKUGpSRnY1dHdrNzlJUmpwUy94?=
 =?utf-8?B?aWJNNVlpMFMxK2ZiVjdXUUduTEtZWit0V0lFaTQ4S09jb0Q4R0RIdzRUN3dJ?=
 =?utf-8?B?N3Q3Y25FNzI0NjZ1MXhFa3NnS1Y1elZ0N1JzV0JKTHRhQVlnbkZBU2F1cTRl?=
 =?utf-8?B?Z2tXQ2RpL3NYaXhKdnJSSmtTbExwUThzYVZpa0ZvTDVodkIxUE5ZM2RTbjhl?=
 =?utf-8?B?VnRQYmJGWWhOdzMvK1d2Rm5ibFdwKzhYYmtzLzI4bU9ES0t5clpBSVI3UU5R?=
 =?utf-8?B?MGRHRWlZaGdURlVqMVM2ZW9xVEY2VkNyWWpibytPMmdTZ3dZNUFxQ1o5K3pq?=
 =?utf-8?B?QU1iK3RmTVJTUy9pM0Z4YjZCUVNOdEI4NFNTdzRIY280aEoxUkNmVGZJMjMx?=
 =?utf-8?B?QlM1cEJGaTZDUU1nc0YxU1pZaE5lRDJNbWZVUytCWDlBaDJONC9xNDVPU3JX?=
 =?utf-8?B?WlZjUVdwYk8rcEUxckh6b3RHV3hubHh0Mkx1eFlGKzJLWXlydS83Kzg1V0g0?=
 =?utf-8?B?S0RZV1o3Nm4zWk5CTGhNbXZaeDBZQm9RZm44d0MxZVJ0MWJqNkNjcDNXeUlU?=
 =?utf-8?B?blI0cGxibllQWXdtU1M1MGkrdmNpa0ZpUktBUHl2eG85dW1NeFF1T25NQXFr?=
 =?utf-8?B?ZEdlUkJkWm00dklhWjFoRmVXNnRHYVdSa2ptOWJUM2R2d04yWVAvczl6ZVZD?=
 =?utf-8?B?TE9sOVBTb0pWVWdJNTFEZitNMG1iU3VyenNFOU9nMGFhcjBkKzVkVjRpeWJH?=
 =?utf-8?B?SGV1T21CZ1M1RnNWK3U1YVJKdVBxMXhkcm0vNE51Wm5FTGptNjJpV2NvZGx1?=
 =?utf-8?B?a3Nac0pEbi8xczRjMFZjNU9UYkJrYm5FSHlFSEd6QkVZaE8vb1hWTUg2T0lw?=
 =?utf-8?B?QkpSRit0QjcyR1pzQi9uVzU2L29JUVBqYUtGWGcwZFhhQi9IN3NPdUFiM0RG?=
 =?utf-8?B?b1gwSmhkZGM4UEtma1NoNG9RaDl2eTNGYndLTmZTMFUxU0c4Mmo3MVdmZkg1?=
 =?utf-8?B?Z0QzcDlhcUI5dFNKWDc2VW9vL2l3K0RyUmE0T1ZiY2xtdGVzRkh6NWorSVdK?=
 =?utf-8?B?VUcvMHIrd1hGM2xnWG9NN0hFQVJrTkR2NkIvS1JkeFRrTHNPdGVhbnk0TFg0?=
 =?utf-8?B?cEtXMmNuSmhGdndlMkttU3d4ajJPU00ydDdCY2ZuY2ZlRGpkbUUzT1dhcytB?=
 =?utf-8?B?aTV1NG4vMmcwWmNSZW5qQzhIVmx4ZVBUKzBpVTgxRUNPeE1qMEFFV0JRRGRR?=
 =?utf-8?B?WkxBZ2M0SzVTcWF2M2NaUDN1WWsyaFhSb1A1Qmx5cWsrOUdPaHBuOXpBYUJx?=
 =?utf-8?B?S25yQUlqTDFqaUFhcm11dVY2WEN6M2RFMHc3Ri94YmlRN3l1WllKQmZsVEFi?=
 =?utf-8?B?NTl1V3BkZEVBUWY1aDFndnZnVi9HdEp5eWFUb2tXdUNCZ2QrcUdxZ2xOd2Iy?=
 =?utf-8?B?NUJIZ0VlYkNwWDRwVk5wRk1POWVIYURSRFM2TXhMSGswTC9vczh0NHZORXpa?=
 =?utf-8?B?WmIvOFRPSExndXFndm1nY09saVhDTVdPTzgreWJRZWtwazlCV2hrdmdYZjhV?=
 =?utf-8?B?S0JtcEJibnhtcVlrcGlnWExoNVRZaWVlSUsyRjdFbmFmME5mNGUzdmZVSWlu?=
 =?utf-8?B?UVd0am50VUhhTDF6ZEtER1NnNDdLVDA4cmE5ZGZuRmY3NkRCd09JQnpiVTNr?=
 =?utf-8?B?T0ZlOGI5Zkh0Ris1b3pjWmIybi9CWnU0RVVIY2I1bmZaT3lxUzNMc3dzT2k0?=
 =?utf-8?B?UGtEQm1icGRUNk4xRlJBQkpKZ0xCamdkMWU1KytscFNsaklQYXVMcTF3d000?=
 =?utf-8?B?UkZaSktTOEpIZjJ1dHdTNTlEU1VUeWhUelhreWJqb3Y2ektLNVQ5UWhYaEpo?=
 =?utf-8?B?SlNZTUl2VW13KzBXQmdkdUlLdDRBd1Q3eUlzcXlLRm45SjRyWjFwRWN1dVlv?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2varniYwYqx5OJiLRnofq6jxdYeThsp7Fr4kaEXfwAqS9HlakvQ7oTJbNmkrfXi+KZnCpHRJMvNDS3B/aVU3fSOaP6KrnB53v5bVGay4QC7SMVF6GqNFrZFE3R10Pbc9X7gExGf7Djh0DqIsrhDIJ+sQEgR5DntZ3FlLd+BpLzLPEYbnrv38Ay+YTM+WTln26rxvYyMutlzHHnWe2RDwQjW9L+6CJYh5dORomXZAiy8KBBZQLhINnB/UpsMyuQK8g74+Vcmfhl3kk56K4s3OJasq4yJTo8t2T0/oOcnlgP+aexWW1C3RB87XdT83Ws2IzXDDItL9k0KLe06HHw5cH9QZs0PC13OZhjUbYohuuoQ9Lw8ozh6wIV5Joh+oL5rh+fa56scacraVsOJNITVrqY1kNpXNmwND3qnrFziw6CyO1eVQrvrit3+BxGwdfH1UJzQ9VNPMtrHLLIPO2zOYynh+xqj8VOVd2sx0ycrEPBAqoX4FY+vN7BN3K3BABuuvLWPlGL7VKXGSUCYCJh58+A33qts0BViWdyhNN71wJE7fEPH5o0x3H+h2H0hcyoBZxXpYOnCMpqxPETzxTheu2Ct7PzbOf5YVE67obwsrV1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bccf664-6e0e-4420-61c0-08dd3bd062e4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:07:15.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fik3dSu/ZJtTT9GtFhy+hLwEpObDwZPlnO6W/ufX0hh/5L7mVnhRWjHYOgRJbIr1hM3Qu+3J2f7SVBxL0Oy9IQyD33Tl5vigxYa7F0I5ufM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230126
X-Proofpoint-ORIG-GUID: CY7gdNZ617n33Vi3NWuerVuDQ2hGTENp
X-Proofpoint-GUID: CY7gdNZ617n33Vi3NWuerVuDQ2hGTENp

On Thu, Jan 23, 2025 at 04:48:10PM +0000, Lorenzo Stoakes wrote:
> +cc vbabka

Sorry my mail client messing up, forgot to actually cc... fixed :)

>
> I realise this is resurrecting an old thread, but helpful to cc- us mmap
> maintainers as my mail at least is nightmare :P Thanks!
>
> On Thu, Jan 23, 2025 at 05:14:27PM +1300, Barry Song wrote:
> > > All userfaultfd operations, except write-protect, opportunistically use
> > > per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> > > critical section.
> > >
> > > Write-protect operation requires mmap_lock as it iterates over multiple
> > > vmas.
> >
> > Hi Lokesh,
> >
> > Apologies for reviving this old thread. We truly appreciate the excellent work
> > you’ve done in transitioning many userfaultfd operations to per-VMA locks.
>
> Let me also say - thanks Lokesh!
>
> >
> > However, we’ve noticed that userfaultfd still remains one of the largest users
> > of mmap_lock for write operations, with the other—binder—having been recently
> > addressed by Carlos Llamas's "binder: faster page installations" series:
> >
> > https://lore.kernel.org/lkml/20241203215452.2820071-1-cmllamas@google.com/
> >
> > The HeapTaskDaemon(Java GC) might frequently perform userfaultfd_register()
> > and userfaultfd_unregister() operations, both of which require the mmap_lock
> > in write mode to either split or merge VMAs. Since HeapTaskDaemon is a
> > lower-priority background task, there are cases where, after acquiring the
> > mmap_lock, it gets preempted by other tasks. As a result, even high-priority
> > threads waiting for the mmap_lock — whether in writer or reader mode—can
> > end up experiencing significant delays（The delay can reach several hundred
> > milliseconds in the worst case.）
>
> Thanks for reporting - this strikes me as an important report, but I'm not
> sure about your proposed solution :)
>
> However I wonder if we can't look at more efficiently handling the locking
> around uffd register/unregister?
>
> I think uffd suffers from a complexity problem, in that there are multiple
> moving parts and complicated interactions especially for each of the
> different kinds of events uffd can deal with.
>
> Also ordering matters a great deal within uffd. Ideally we'd not have uffd
> effectively have open-coded hooks all over the mm code, but that ship
> sailed long ago and so we need to really carefully assess how locking
> changes impacts uffd behaviour.
>
> >
> > We haven’t yet identified an ideal solution for this. However, the Java heap
> > appears to behave like a "volatile" vma in its usage. A somewhat simplistic
> > idea would be to designate a specific region of the user address space as
> > "volatile" and restrict all "volatile" VMAs to this isolated region.
> >
> > We may have a MAP_VOLATILE flag to mmap. VMA regions with this flag will be
> > mapped to the volatile space, while those without it will be mapped to the
> > non-volatile space.
>
> This feels like a major thing to do just to suit specific uffd usages, a
> feature that not everybody makes use of.
>
> The virtual address space is a somewhat sensitive subject (see the
> relatively recent discussion on a proposed MAP_BELOW flag), and has a lot
> of landmines you can step on.
>
> How would this range be determined? How would this interact with people
> doing 'interesting' things with MAP_FIXED mappings? What if somebody
> MAP_FIXED into a volatile region and gets this behaviour by mistake?
>
> How do the two locks interact with one another and vma locks? I mean we
> already have a very complicated set of interactions between the mmap sem
> and vma locks where the mmap sem is taken to lock the mmap (of course), but
> now we'd have two?
>
> Also you have to write lock when you modify the VMA tree, would we have two
> maple trees now? And what about the overhead?
>
> I feel like this is not the right route for this.
>
> >
> >          ┌────────────┐TASK_SIZE
> >          │            │
> >          │            │
> >          │            │mmap VOLATILE
> >          ┼────────────┤
> >          │            │
> >          │            │
> >          │            │
> >          │            │
> >          │            │default mmap
> >          │            │
> >          │            │
> >          └────────────┘
> >
> > VMAs in the volatile region are assigned their own volatile_mmap_lock,
> > which is independent of the mmap_lock for the non-volatile region.
> > Additionally, we ensure that no single VMA spans the boundary between
> > the volatile and non-volatile regions. This separation prevents the
> > frequent modifications of a small number of volatile VMAs from blocking
> > other operations on a large number of non-volatile VMAs.
>
> I think really overall this will be solving one can of worms by introducing
> another can of very large worms in space :P but perhaps I am missing
> details here.
>
> >
> > The implementation itself wouldn’t be overly complex, but the design
> > might come across as somewhat hacky.
> >
> > Lastly, I have two questions:
> >
> > 1. Have you observed similar issues where userfaultfd continues to
> > cause lock contention and priority inversion?
> >
> > 2. If so, do you have any ideas or suggestions on how to address this
> > problem?
>
> Addressing and investigating this however is VERY IMPORTANT. Let's perhaps
> investigate how we might find a uffd-specific means of addressing these
> problems.
>
> >
> > >
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > ---
> > >  fs/userfaultfd.c              |  13 +-
> > >  include/linux/userfaultfd_k.h |   5 +-
> > >  mm/huge_memory.c              |   5 +-
> > >  mm/userfaultfd.c              | 380 ++++++++++++++++++++++++++--------
> > >  4 files changed, 299 insertions(+), 104 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index c00a021bcce4..60dcfafdc11a 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> >
> > Thanks
> > Barry
> >
>
> Cheers, Lorenzo

