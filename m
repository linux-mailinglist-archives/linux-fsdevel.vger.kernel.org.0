Return-Path: <linux-fsdevel+bounces-47817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC1AA5D38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 12:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764279C4333
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294C921C9E4;
	Thu,  1 May 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p/uBap/e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gYcKC7Lg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3901C5D7B;
	Thu,  1 May 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095307; cv=fail; b=UKQ6R4bllbW+izGyGdQE4v3Vo2MrSdn6Cs7j1dcUP/QSbu3ziZcd+ANCwp0J922Yu+iMG2wkRPcrKnvTJAtEsuKW9yIwiSeWjGfPNp/SYc7zW06IYgf+2k3SNNGmlS83Ov7zzlk4mRgx0niLnfP3VIfZjflg2CiVWwvGamTnSKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095307; c=relaxed/simple;
	bh=5DlAv7Fb5CPD1KZMf0V1j3Xoz8pwE5z936H5t4zl7+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gT9qgn21CCqbmBvmQQwhYTpRDnEYLEbyDKqRjipO0Dpg35gq1GaIa1XbGfHA9ZAfUJj1lWvZrqzO2dtX9lMucE99tObHONZjNRNqX0fnrVF3GMC7FhKACaT7xt+0jKUIWjrLIVtZyketWiJFF7l9FhR49a8Rn1xGp+dKbQLouXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p/uBap/e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gYcKC7Lg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5418fwWb029114;
	Thu, 1 May 2025 10:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5DlAv7Fb5CPD1KZMf0V1j3Xoz8pwE5z936H5t4zl7+Q=; b=
	p/uBap/enNGYScdWb9Yuv1twYEEn6dHN3AyFPznn7NTN+y6f2R3YAvYelr63UhxW
	VQ/UNS8Ot7tjAqOo81HG9QOAp+CcxQq17GZBLzU5o9rOIuT4rgtv1b++h8ylwJ9v
	WhVBg3lcAlEmBAP5GkhqUTy1alW4N+1vZyzVXED1iLdCp36ud0L22DjZ2O8b/VSC
	i2Z6ctMhvqQoCsSIBCwVZTtgDymv+MGGm4D8ve5XxIDtlz/j5FhALdBXGIAMG0M3
	0UphbL6LfNxX6s2mds8dtHYKXr2qlLK/YHakxgD8BNVT6TxFaWjxVEp6gbPHicUu
	pVMfXahV3D7WHxyAWAyUIA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukturg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:28:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54188Kkd001322;
	Thu, 1 May 2025 10:28:02 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxccx4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 10:28:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZniOcPJttQiCfJuv3nV2kfbIXqaUgB2kCIvyh7LnDzKOY5BAw7Nwhs5Ujl/5G9SlOMgQkrROCWKcX8gkJIuFMNcDAWcoLsL8ApdF8Ae3/Wx5pHd+7ZyVzv7hv+oXvsEjmdcq/JcxLWUstdM5QLumYsmVflnlD2TcVCt4OX//q2kSfLaZYSHwOkUKIRPRg9Rjym1U8o+fFa8Zuvd4QK/F6+QV7i0R0oexx9aRwnbyiNIcDmO/dw+MuFDOf+3AHGYpgsM03QisFZT24vPcQnaWYMiXKGBRTeiXrefK+GihQYdVKDIDK0uzUuuLbwZazzSmYBpPRd7SiZWX0jq0UBo9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DlAv7Fb5CPD1KZMf0V1j3Xoz8pwE5z936H5t4zl7+Q=;
 b=KZxRpEr7hGAUNwNBMNKjWDPX2wB9I34rvW6ZXi+AIkVOP2Jv6U32wIT7ZwN8oW4Fw+PitjMxNowClzufns1e323WkuwpMdD9lBiaxbzD9wURdFUxediY/5GwslFFwvKLT7Q13wtx6gruJi+S6HwfI1vJQFKTMjzh8ucIuXw5MRPGYSkIpCuVDlak7kRbJ+criyGef68kgN2/3lRxv8Qwxznj9MQSCc+24DAJLOqrZOshm6ab3zgZWc9ZxbNZCNNKEUL1v/hhUBkSLveWnNUHdFywEetIfPdt+IfWWfR1ziBCPfN09njLcegp42nq+u46CuurQeLP2qe78Q5PB5nAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DlAv7Fb5CPD1KZMf0V1j3Xoz8pwE5z936H5t4zl7+Q=;
 b=gYcKC7LgJIwrcoTLcyi7ovjoCP3sa0w21NeWKVOYnAOkPzpJmAUiA3P6Gk2/sBCaUxO37Er25HbM/uPeKcm7llchR08/ZNY+tBhpsTikGAgPhRSW4YSIz/5kNRs9yNT0SbixdFkLOiVyEd7F+cUMkFbfXT7UfZaI5b0Z6ViS7pA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 10:27:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 10:27:55 +0000
Date: Thu, 1 May 2025 11:27:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/3] eliminate mmap() retry merge, add .mmap_proto
 hook
Message-ID: <c2254436-008c-4adc-a144-78dc81d8607e@lucifer.local>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <CAG48ez25mXEgWSLZipUO2d7iX-ZjF630pMCgD95D9OuKGX1MfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez25mXEgWSLZipUO2d7iX-ZjF630pMCgD95D9OuKGX1MfQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0577.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a19799-cc4c-41d1-a939-08dd889ad5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cC81RXdJcmViRDlyd0IrWjZwT29jbEt4QkwwNXlWa3BxTW55MVBqQUlINlFu?=
 =?utf-8?B?dStSWlUzZ3Q2R0NNMFByQnFtTSsxcUFkWDdQUlpnb1JZUTFuRTJGMHJMdUFT?=
 =?utf-8?B?RERnenBHRHlueXl0S2d0aFEyeUlLWmsrYXI2K2xQN2dYeHdlYWowTXRCUi9Q?=
 =?utf-8?B?c0poTnVDcGR2VlhkMnZDQklQRU9NTG5uOHVabnRJVHJUeE1NeFFYZzIvbTlN?=
 =?utf-8?B?SW04bGtqR2tRbHVHN0ZSOGFVUE5nQXpWa054OEdCczYydGJISG1xU1lxMUhO?=
 =?utf-8?B?Vnl6Umk5L0VCNmkvQ1BRTU1ZQWozOFNIdlhKcEswaEw2MEhFRDhaTWR5OWQw?=
 =?utf-8?B?Z0NyY1B3a21yeWluYVhxSnZkR0ZhQXRLdWhlV2hGMnJoSXFURU0xZm1uKy9E?=
 =?utf-8?B?dnVxQW1zR1hZUXE2OWJZdTJNaVQ0bll5czdDK0RYVE1hQWthWXo0dW45Tmp3?=
 =?utf-8?B?d2ZINmg0a0pDTHYxMVpvKzdyQ3JHWjBIMEtjUDBNRzdIOFljejI0czYzWW5K?=
 =?utf-8?B?cFRqSjVxQitSVTFFcXJ5L1M1RTNoemZLb0NTTHIxdjd1U0NFWHMwb1lZK1Bi?=
 =?utf-8?B?WEE2SXNNMVBnK1BvUXNRanJRSEorby9GdWpHTm0rdEMxcWh3RXBtbzlIdHBV?=
 =?utf-8?B?ZkdNNHB6V3E1MjEwNE0wMmJMY2F2cEJRYmo0VzIzME10M0IrNkJGQVJ6emtP?=
 =?utf-8?B?ZW1HbzdwckN5UWZjWFRxV09FRHU4OEMzOUg1UGgzakVyY2trRFgzVHo3N2Fj?=
 =?utf-8?B?RVgyMzlORjdBNnBWaXdxUksrZFRDNWdRSXovbXRuTi9tWVlDNmZ5SFpyVkJy?=
 =?utf-8?B?ODIzZ1I4bTM4eEswZE5lYWVBaVBtWUpHaU8yMmJpTUtlNjVVUTIxT21rNHU0?=
 =?utf-8?B?aVUyZmFUWGpIUFhSeCtJNjRkejd5eldZR2FNcFd4c1lla3pNcnpLdzdUOTg3?=
 =?utf-8?B?YTFNaC9RVE9JUE91V1h2NzFmZGdUWGFodCs0MEkwdHM0ZW5YdVJ1T1dpY3By?=
 =?utf-8?B?ZXhlRWVnd0hpNi9sNzZkdVVvbEdwL2gwQ2hxR3NVR2Z6eE00TmdBcHZGVUJr?=
 =?utf-8?B?V0MxazRLWVpqOGp2d2ptTTk3TUNYazNPbG9tQnphTm5yMzRUOWhvZzJCUHYv?=
 =?utf-8?B?TTVnWHVzdmVZeWxXN0xhU3VITTRVbnVsTCtKb2hMZ0tHa0w3WmhqOThUN3Jw?=
 =?utf-8?B?aGFHTHJKTTY4MTB1K2NzamV1bUluRTZWNEtBWU5LcnNmVFBnQlBoRjE0bDB2?=
 =?utf-8?B?K0RNdnYxWnVpeWdJS0tUd0hLczlOTGxjYktuQkdJVTlTdmdTUWM4WC8yQUh1?=
 =?utf-8?B?VlpVWENWeXFXZE16TzNmaGdNZGxnQWpRMjlIaDhCVS9RSVAwRk1SUjlFZmg1?=
 =?utf-8?B?VHFaUHZMTDVPejdReEJOT2pZZFYxaXBIa0l6bnRiYVZ4cHpHM1Y2RWV6cjds?=
 =?utf-8?B?cGhYWTFPeW91QytrOExXZDZpdENlWDcwYm54QXVNTXc4QnJOMTZrMnVuRTFm?=
 =?utf-8?B?c2w4YStxWmYyMkFsNkhmNnc2dWV0ZEhpNmpuNEFTVmZheHNzazBrSUlKQnVt?=
 =?utf-8?B?ZHBzVDNaWG1DOUtHekN2NlVsYWtFK0FvY3NrR3Y2MXRRQlQ1anZZNWJ6U1FO?=
 =?utf-8?B?em5FOXV0YUdSaG9EUkc1RnVVMkNMRDZ2R05zTlFYQTRqOWpQWEtMUWhuOEh2?=
 =?utf-8?B?QXNKMDBXaktqaElMdFliUm1Td1N1REs2dDcweSs2V092anNwUTNGUlRIRTNw?=
 =?utf-8?B?d0I0dFJCRklXdVRKOHkzTVpLQlhtUkxldFlYbkdiNUFjaGRqZE5vZG1UVUNC?=
 =?utf-8?B?ODcyRm9yZFZ5NHMxdlBUVENsVVRJZlNFVzJGREFhTlcyRXBCQUxKTUVXTlRH?=
 =?utf-8?B?MitjOXdtc2EwaUwxYk1oZ1VuNlNwbkxHN3g3a3gvcDBhNFZRclBQTm9RMjZC?=
 =?utf-8?Q?zRZC2nphifs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3ZWYnM1MUNQSGNrVU82c1NNdlE2NmVjRzEyNTkyejV3VzhFMXRTcUd3Nmph?=
 =?utf-8?B?NTZBLzQxc05hQi8zbUFVdXY0cVdvZUJ3Zm1kT1VteW5paDk5OVhJNkEvMk9o?=
 =?utf-8?B?UWxpU3NqWFFiR3R1SUFKcTFIV0hteVJQVVV3dmJSNzF3b0pYTTRIa0g3WHlZ?=
 =?utf-8?B?dVFidm1PTnhNK3JmU2NrZUhQQmMxelJTeGNvVlorZHF1V01ROGFpc2c5d1JD?=
 =?utf-8?B?SHEvUUdFT2NyUnlqVS90MjU3dlZlcWVCUDI0d0V4UDVwVGh4dzhCNkV4ZHla?=
 =?utf-8?B?RC9zdEtsRnprZnJjbnRRY0JtRDJjRFFXQ0tqMUtUdm9zR2tIZ3kySGlYamZi?=
 =?utf-8?B?QXB5aUlvK3VqWHFUZzhhYkROdnB4SXN2anlDeUlxYndRckJjWjd4TkRMMG0r?=
 =?utf-8?B?TG1KcXkxcVptYVZ0eUZYWmhqY2RXOExmZzdGcWloU1ZOZWRmcVdaTzZSMXJW?=
 =?utf-8?B?b0czMmNwWWhaT2VKVXQ0L2hvUXVlUkpGU25RaitPRFJ2RlVad3VJT0pBT0w0?=
 =?utf-8?B?RjlYUDdIR2xPNXFtaEZMeGx3RmhXMmdSL1lsTjc5eXJHNlE1dDI1OUFraGUr?=
 =?utf-8?B?NkF5MHp1TE1kUFBHQWpHVkd6SG9pVU41VmhvY2c1U0JoVmhpWUFwTUltVTQy?=
 =?utf-8?B?THBVMXAvb0xkVWlHYjZxY0ZEU3J2V2NNbVZ5WlZHRzZtUlJCYzUwdVNLT2ln?=
 =?utf-8?B?K3EvZVdEb2RXcnFEVklDd3JzTjltdUNzdGpGZUMyKzBJTUllYjhXYTRDcUFK?=
 =?utf-8?B?MXJyMDR5eVpoTUxmSTdtRlRnMWZadWlzYWEreFJuTmJKczlkU1FBYXJlVGlo?=
 =?utf-8?B?NklNdnZtT0o1NTNuQWpvM3J1NzdKOXMyckRxNjdGZ2FCTCtHdG1ucS9uZ1ox?=
 =?utf-8?B?TWQwb0JqQUxKR0thZHlCK2w3OXpMcUxDY1VXWG9BWG5rdGpRa3VqRmJlN0tv?=
 =?utf-8?B?VkZhQnVvQlc4LzgvV0djSmx0bm1ibFhSNldlZjRxWEkwenFIR3IrYjQ3N2FB?=
 =?utf-8?B?TG96Sk13SWxSTTh0SjV5TEdML1NXaFdqNVVGcUNHeHpsSWxhL2lNOXdIS2My?=
 =?utf-8?B?MlZVd3RZdlhHdGlJeTBCV1NZY2JHQ09YS1dVUlVwb3lvZjZNWW83L3lHRjlP?=
 =?utf-8?B?SEhhcitOTTZqZWR1QS9YSHZRQ2w1aHgzZXkrb2p2akp0ejFIdWdCV043RFk3?=
 =?utf-8?B?aFE4WCt1aW1FclJMM0U4TjQxRFFLd1k0czhwdmFHZ3Z4MEdBVVlXelNuWEJJ?=
 =?utf-8?B?Q3BoeXZTc3doUEd4SnZSdnZuMWdmNXA0VU9rUzJ3WkxMTTI4S2VKSnNtclhT?=
 =?utf-8?B?MGZQbE1aZWRnV0dyR0pVQ3c3cUlwRmFtZzZGWGIwTU9aNEFPSFVkZVZITmQ5?=
 =?utf-8?B?aURaSEY3REtsbnp2YXhtZDZSaDdXZUh3V1cyUkJVY0VueG5YWWViWGw4a2hk?=
 =?utf-8?B?RnExbGZBaGZiVUZ6SEMyd0V4c2IrWEx3ekhrblduekxKVTBZUjV3bmlDWUtR?=
 =?utf-8?B?SzI4S1ZNdUgrdyt4SndlanpYcWZEMUxkaVk0NjB3cG9USkYyd1NDbUVnVEhr?=
 =?utf-8?B?KzBDVGpHQUcvWjRDSlk3bW9OQXZ0b2xMRXNmeWdnUmpWck1EdW8xRXRpbGN5?=
 =?utf-8?B?bVRDYk94cGRXdGVLL2U0OWNQM0ErMzBRZ3hVUnJrMzQ3RURuVk1VTzlwb05l?=
 =?utf-8?B?NzFCTHY5R3hkRWNMZUN2cTN6b092RWpsditvY05sSU9oZ3VIQkZ3QVlUcndI?=
 =?utf-8?B?SzNzalN4L3VZTTNXNjJxejlUc0RreEt2Z1VnQVRhSFUrTXlkTVZvUjFEcVhl?=
 =?utf-8?B?VjhZdm83OXZGRTU4bHBvd2FrRHVCb0E3R2x6UjAzaW9Jck5zcFl5Q3Q1bHZl?=
 =?utf-8?B?WEtXa25PdEhwSmdUbnQrYlNUZ1JTVWg2ZWZjcjgxVFFyYllnVUxCbTZvVDFS?=
 =?utf-8?B?NW9HY0VzRmwrZzRrK3RWMHV1c2Y1SlBqYjlvM05UMjlkZXpFZFJTRXBEYmZX?=
 =?utf-8?B?cklwV1FwL1BwT2NQNUVXZWlXaHRHT082OGsxTWI0OXNJcTJoVEpVa2FISE80?=
 =?utf-8?B?NWRJN01OTkRXVGxKSllMU3MyMktOdTNrMXVkQXdhMDV3WFdZcUI1ZkF5dWQ5?=
 =?utf-8?B?UWx5V3hHTmRmRWxpNlgrZWxVcjhhYzZsOFpoajVsVnZSQThjMUFhQVJ1VEFy?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JoJO9VXYhPdvN4vhZ32NVxFwmIb7FicxHw11FlWBJHlUhdV4p8MrSqqjdgu68HViKoss5ZN1V6hV4FZRLMNwFACPPdQwueVn6gl/9QZOAvMux1uWqtZ1U6mkyXbvFPlKds6tgl9Y452c7BlhS3sBAen8EBNuD+wkMDrEIRk4OUeI69F1AYegu99LqwdNaoffZI8pcfuMGFDkuS0b1VLsK/9W3pc6bwqsoTVN/Nc9iszihzYUVp2KwYXHrIO1c790YqGE0E58VexBG4XV1B5+QVAJLbzlrfp5Ollq5FW43PSCpvWbbl54t+EHLyGc5KHVEwdtQ4tryE01JE+1c5lmXgmRoEfnn66gfra7vbj5MzfPCqzzraRMFv5sQeCO+629DutFqscR/FlskumhlfTIerL2e0OTEG1RCgKESLELXsxxRStQbAwEC4RD5B2XwSaAt1TENAAsE+3vcU+aXh46zcjPzcELpmtICRZhqkMH5H/O/PJkS1m9hqcaFovWX0F8H/Q2fBZqA7r5hSBGF4ZRc3dUf3fE4rvsm2NNRAL1le6PdwZFiCw2koAAPt+YlILP/eW9breU7sNs/MdjDyjWSDDDUzn5lXDQZzJtX6g79fI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a19799-cc4c-41d1-a939-08dd889ad5dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 10:27:55.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLjYHVPoRRqJau4D3+JmDK+YLNyO17QcbSJlWaa0sE7t4evVL4ufrPWbIhlGO87ToVGIX2uA/g8lxIbvjE5UwGOBbb3douDKsktquxwD6+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=930 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3OSBTYWx0ZWRfX2WwNBYJLKje5 ab8wYoxVlz0uptb67vYrFvFbvmXgB3T0ayc6ORINbNCFQaXCnVNxMFEb1MtI7en2cPNksXRJYmS LVewrhmEC4yqvWbGX6AXTCHbWgXbvf1iEzzvHfAFmAXu3KykIFrbH4H/KCZ4QDagUBzwxM16KLC
 BLO4xa25JByZ0Qt86MSLdo9q+Ikf//2g90B7AQ+xB+7H7+1c8uiG+Sr6ZdADBS/eoNNGMiviDDR KgKDJd4kA6x3sktERpbRqSA5sOfIceuqWu6GFReLWYpZySk+Y9KSsIlNl+g7xnge2HUH3i4Xpa0 988Tqq5ZKDM719q9KkZ0ad/u15KB10pq9TKBlewO7VtvC/S+QZCRGZIVzc/npQbkKhLOTeF7g23
 jpzZYte4VznCgoT3YUzNh/Ef6Q/f11d+t4u5L9W/7JFjHZP08y4LAyYun5CFeSVnUdMYdKjj
X-Proofpoint-GUID: LbmOOcWrUqCLUYYgJclDiRwtc-l_ae0O
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68134cb2 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Bfc2oX1D9-CMmg71xloA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13129
X-Proofpoint-ORIG-GUID: LbmOOcWrUqCLUYYgJclDiRwtc-l_ae0O

On Wed, Apr 30, 2025 at 11:29:46PM +0200, Jann Horn wrote:
> On Wed, Apr 30, 2025 at 9:59 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > A driver can specify either .mmap_proto(), .mmap() or both. This provides
> > maximum flexibility.
>
> Just to check I understand the intent correctly: The idea here is that
> .mmap_proto() is, at least for now, only for drivers who want to
> trigger merging, right? If a driver doesn't need merging, the normal
> .mmap() handler can still do all the things it was able to do before
> (like changing the ->vm_file pointer through vma_set_file(), or
> changing VMA flags in allowed ways)?

No, the intent is that this form the basis of an entirely new set of callbacks
to use _instead_ of .mmap().

The vma_set_file() semantics would need to be changed actually, I will update
logic to do this implicitly when the user sets vma_proto (or whatever this gets
renamed to :P)->file - we can do this automagically.

However the first use is indeed to be able to remove this merge retry. I have
gone through .mmap() callbacks and identified the only one that seems
meaningfully to care, so it's a great first use.

Two birds with one stone, and forming the foundatio for future work to prevent
drivers from having carte blache to do whatever on .mmap() wrt vma's.

