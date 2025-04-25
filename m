Return-Path: <linux-fsdevel+bounces-47337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B95A9C4CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F140E4C5A95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27652238C2A;
	Fri, 25 Apr 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SSKQk5/x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s8VMKrnI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83621A436;
	Fri, 25 Apr 2025 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575790; cv=fail; b=ZsvFENYEvryA8Pv6v+8BrvFoHFg4y7J0OYjalH6YZp2ZuBgGKBJvQWOQaqYQoVxSs7rZ2KXYZ0Vte4atUru9EkdWBlsQh1FJklQ34TAn2fEkY9WFEdM9+l2aUpf4U+cKvdHi9J2brUxeyvFtLHHkodMEYtGLghqDVPA2ihqRPI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575790; c=relaxed/simple;
	bh=jM2EKOYWtXShPd3X4EpMb0EQtg86Ehw2jYBF81ALI7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jBOfA6g2t9P6jfuvNs89gsB711mHodIrnWF1g/KfvaTGxSWRBYr4YA453MTUEA8AnaYXbUL9Wk1U1mvRj57QAKhDiOzOGKgoIVpWX7E/CWK8xYIOsaJhBeJLnjYQmxPkC1Kjyjo9ypS7vkvYoOKomE2ZIXkjO2quCE+I2VbwHIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SSKQk5/x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s8VMKrnI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PA8LHn012968;
	Fri, 25 Apr 2025 10:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SrKWMJ2FIL3bRMeHOnuagmxluqA9t971Qz4xljQUyE8=; b=
	SSKQk5/xXdK6YOsW8+rqc8cMjUI6m/lSvWBz+fCvbM74qLCaHR3a/g/ElmWZMHWt
	A4uVyQwbpGVXHS5B+vYNWVw/ZMVK1x3bdbIqEy0fjqV6kImHw070dKj+n+TdGFsJ
	6XnQ0idgb7191V4p02NmJJWfMKp+LxeO4VTGVnUm94repTPmnjRz3UatUEBO2Q1/
	TWVMpxIrKRSUeV+KFqPGBpkgoO2Ta0s0DXSKg000LPJULVLwblWgmhiike8DvPgH
	pIv+w5fZX7ygju3y8jr0MSVXZyE+0olHyOTkWjXSpb9GTZ76BZ7rJsFiOV8jIsGU
	NotC5v2Wu6wAbIUUqyH0tA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4688bv0020-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:09:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P91x7n025359;
	Fri, 25 Apr 2025 10:09:22 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011028.outbound.protection.outlook.com [40.93.12.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbt786k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pny1XSGyjgvGibVWNbl9u5EgYzsXB/kB8KXbvFF9jzL2nlRcE1kyJ0pZKFZcMEJGWldtTQKweV5awqfgeqDdfL+C72Kzxp1NnrBHPGkblI1iliYxpABWh8ERipXX+p3uT7/XT4K2cIOFIzo6FzFuEV9Ebb80YJ+EBYfD1aLHEsjDLMZDTDXQe7a+OlpceNWWtsDmqKWtXol+al9x72iNOyQLsddTiJcYUpf+zCRLP905lDCnjwco7rSfjKMr4osppxdfdaiRJiiIuOLE7w8EhbstmFo/4JjfT3F1WzBhTVh8nvgvCFHzUGsvkUKRziF2PsPktPBHCPK78J/J6CLM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrKWMJ2FIL3bRMeHOnuagmxluqA9t971Qz4xljQUyE8=;
 b=l7TFJ1e5NGKTy8obRijHbea+VSCO0FvHQUGDW0OU0HSR/0yn1YNo99B5u5XBK8N0hMAON4/akDfg5gtROHHRn+gP9n/97tuOS76fB7DYsV/hJZxUSJ3RD/hBB/Usl/ju0Ct3/siYwHD0UT8I/6C0TMcJDz5UykLuafeYJ8XWx9E/KBcfMf/NVSnzC3C/lmUdPNxqhiQaSD3Gh+nGz2zPI6B9dPkU8eQ4KNgAEfluQNUexkkymNh2CJYjnKP/ZNH70Q9Ww/Z1juMKV3ViZA9WqRqdM9ztv78TAbH9zCaPdMEUKLKtS+ztKcjVh9y/Tf1Fqxe69aGiZcDjItU5IRZOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrKWMJ2FIL3bRMeHOnuagmxluqA9t971Qz4xljQUyE8=;
 b=s8VMKrnIhmfGPkK65RXrFhATkIMMs8qyWh+/43aGY3W3QH/iTd5sUjbWycv96lTWcoN9jIdjlMhSV2ClSzKcO9vU6mUtNgGZKhRhqIgGvUoZ9DaKGF0pOkdDU3c37XxB4eOYXVG9rIbaNo5qpZRuf9CG0t7rV31GJQ6uj6aCEOk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB7046.namprd10.prod.outlook.com (2603:10b6:806:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:09:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:09:15 +0000
Date: Fri, 25 Apr 2025 11:09:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <7b176eaa-3137-42b9-9764-ca4b2b5f6f6b@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
 <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0470.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d85325-d642-4ff6-6de8-08dd83e13bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlBsbDJpWThkUXpPZFprV2hES25GNXNLWkF2cnhLU0lFSk1wc0VKUW9Oa1g4?=
 =?utf-8?B?TnU3cE1NWWxrUHVDY2g0ci82NExjeUM3aWljYXN6MGU5aE8wbXlFVk5PNUht?=
 =?utf-8?B?UkdETmMycHhVazd5WER0Uy9Xd1poQlNYWk1Zc3VhbjUvdzlNVHozZEpjdHUz?=
 =?utf-8?B?d0ZOcHJIeVdjdXZoTjdqQjduK1ZnblgxbmRUZXlEckhjSkU5di9DK3BHOTNm?=
 =?utf-8?B?bGtBKytHMEdkaGhaSjVPd0RxUVk0bDFNT2cwRExxYlZSWXNoMnV6M0V4bTBt?=
 =?utf-8?B?ZXF5SGdHaXltRll0ZHEwczFVbUg2VnhSVHAyRlZHTW82N2QwMldiQkx4Z1Yy?=
 =?utf-8?B?ZXRJdE5xV0VlajJXOG15R3dUaFhENFp1bjRPTTZtM21IWHM4QXFwQTFvOEl1?=
 =?utf-8?B?YTJDWSt3VlA5TUV2RG5Od1VENzRidzZIZUIyWGJya2lQTHRlRFZhZVozd3lZ?=
 =?utf-8?B?dkdaYmN6bG5YUlEra1l2WS9RSUlUeGxYYkpBa0ViR3ZCYU9VOERQc3gvWkhw?=
 =?utf-8?B?Wm45M1NrakV3ZWpTTndGc1E0MnE0cHROTWUyV3d2eHBzSjR5cGpHZFJvNDIv?=
 =?utf-8?B?Mkh3KzJkclYvanlHZytNQWRnQmpaNElQYU5RZFgvNkUyb0pPVUF6elo2eWUv?=
 =?utf-8?B?YkluYXRZeC85Zllubjc5eUhlamZNbFRNQjRaVUVEd1hESlFPSmY2dVcvcy9i?=
 =?utf-8?B?V0ZqTDZTSHc3L01aSmxlVkJ6OFczMk1Ubkl3T3AyOXhqbW5rekx1R3JOeUJv?=
 =?utf-8?B?NWFyNW9pQnBtQXdnak43cUZ3c0VkTnp6ZDhlMndmbWc5ZFhDdHM2QVByVmZa?=
 =?utf-8?B?SFhncFoyOUFKTjduejFzYVZDNTFONnMyWUllTWxUdkJCekdxNDBIZDhEc1dm?=
 =?utf-8?B?aGFsbHh0NVlSazRqWjRPZTFRamdhRDYwNnNPNE0rZGkzdGpmUjVURHVOdW0z?=
 =?utf-8?B?eUlJaXM1a0NoVTNqYXIyUWllYzAxWGg4N0luWW04bm9FN1dxaFFlSVp2WHdQ?=
 =?utf-8?B?YW4xUm1SWFgwdWlKV2Zob3ZGbDI1V0x3ZTlTUXpETWJFZXNlTWNKMzVDZ3Vh?=
 =?utf-8?B?ZVVRN0owRkF2TU53ckNxU0tPTXdpeW90R0cxa1R3RzRydnhQcDRrN2hzc3Ft?=
 =?utf-8?B?S2V5UkIvS2NueVJYTGJCdU1YYUcrcXE4TEx2R3Nqd3hEMlk2bnFqR1UrVllm?=
 =?utf-8?B?VWcveUlpaEJUS0JKMDZlV2FtQ1REWUw4MTJienhqdlcrU0QzMzhQY29qSU9C?=
 =?utf-8?B?MndLSEF2R01uandvMVpvYUQyMWdJem55WExDZ21LWTkrWksveXV4WHVJQThr?=
 =?utf-8?B?WGh2SFVhZ2RJc3hyd1l1cmdscSt1K0I2cm1HdFovRzgwK0dzQWlNR09VYXpB?=
 =?utf-8?B?QlBOZnBEY0s0ZXZhd3hZN2w2ZThBc1l5OUxTUW5GdHdvNXVYNlFhLzJ5SlNG?=
 =?utf-8?B?WXc2VGhpMGZkNzhzYnUwVzZaUXd5aGswL2tqQld6bHJvWHVNbHRPWHpEQ2t2?=
 =?utf-8?B?dUN3SndFZEFoMUxoOWswUXorR3pVajlvRVpLNjdXbElWNFhCbmZYOGM0cFE5?=
 =?utf-8?B?S2drMkFhYTJaVWJYWWUvQ2g1RmFxN0JKbUNJWFMyVU1jZkpwRmRWcWhjM05u?=
 =?utf-8?B?bldZdDRHVGN1bDFiYmxKN0ZnVXlGZHgrK2RRVitMWHhxdGtmbUhzT3pGMFJH?=
 =?utf-8?B?bmp0THNTL2dJeGE0MVZvUnpJOFBUODZGRk1CQ0lzdi91L3owU2tRQW1JQ0t2?=
 =?utf-8?B?Q2N3RXBlRFBCLzJieVE4R29DUDZzaDl1VUJMTkVMZXhqVnRSUnhlclBkblJ6?=
 =?utf-8?B?c0lxTkw2dTJQbXJFMld1L1J1cFI0UUNvVmFOTVBZVXNCWkQ2RHB1LzhDYWUw?=
 =?utf-8?B?cDdGbFBxZ2d5Sko5Y3FKWUc5MXVIRCtEWnh4RU1YRHRCZTZTNXVSMkZxak5K?=
 =?utf-8?Q?Sp3ZGwayzEM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STA2QzRhLzI0WHBDWFFFN0ZlcHlOOEFYQVRBbzhFWFZkVEVVazh0aFR2YnV4?=
 =?utf-8?B?MThjZzlpSjRRcnZORUJrRDRqYzBFQi9DdGM3OFE1OTdWWThwQlZkMExTMGIx?=
 =?utf-8?B?eDN1eFJDUmhJM3BmbDlvSXgzZjBEYXRHeGlISlRvREdJNGdIcEt4dGZnUkd6?=
 =?utf-8?B?K1RPbDh4ajNaM3kxazcweFVtcnhzc0FJR2QxWnBlOURSZWcvVHpnRHZYb0pK?=
 =?utf-8?B?M3puU3FjTjlOb3FiUUZNeU9MMkV6dzBJSGxUQ2pHMWhUem5zaENPbDR2MENr?=
 =?utf-8?B?RGZTSkVDK1dBcXprM2x6czVTOHhPb3hlR1YrTWE2Ri9iQm94WkU5OE1wNEEw?=
 =?utf-8?B?bktYS0hTSGlhUDNUNVJXcHBuaTJFblRtV2xYU1FVUHQ0NEhPQ3N6QmZnSmRk?=
 =?utf-8?B?KzNuSGk3cUE5UFl6QXVQVkl6SWJhSVlGaWdHbmJ6ZGxldWRYamJiVGRwSmxV?=
 =?utf-8?B?R01xcnlTMEJLN2k4amwrS3hTTXVmdHZkcGhCdDN2YjAwMll2Nkpuclk4bDZV?=
 =?utf-8?B?VXRqRGxBQ3MyY3RUcktpYUFCTnFqZWlsZVJsN2VlRVVwSkVWWUlMcG4vS0g1?=
 =?utf-8?B?MW1zaW5MaVJOOExFWmtvN1NJKzRkZkhNSUxPT1pZb0FJNVZMVUFiR2Vpak5q?=
 =?utf-8?B?UU1Zb01oMlVtelZ4endLclRQZit2QnQ5RjZmS05md2wwS0RnMFQxYysxdXJm?=
 =?utf-8?B?WHNKUmZ6NzlFMFluc05LQjgvWFMwM0paMXp2N3kvTXVHeXYzaWhEeXdkeGJ1?=
 =?utf-8?B?eGlHZ3RjTC9OR1FNT2Erd3g2bTBubE1HemhjTllWaDcyNTFyWVhvb0VDOVdD?=
 =?utf-8?B?M1RLNm5Qcnp0UGRvS2p6SHZ1dmJ5QUwwNkpDbnJ6SnY4UDJuNkhBOFUwUkFX?=
 =?utf-8?B?MHI0QzVaWTNjRit5SzVXZmg1UHhnVmd3NVQzN2UxMmNRcTBaTTcvMkdZejcw?=
 =?utf-8?B?Z08wMjhTUVN5K2tTeHo5Yi84SEJpMjNnM2dRRHM5WHpHRVcrMkE0TXBPc1Fs?=
 =?utf-8?B?Vi9mN3RlVUpBWEJwQWhpeUpQUUgyOEFoRnVoL29TLzNwZDllTUttcXRTM0Nq?=
 =?utf-8?B?Z1FvUmhIaTZhaEJUc1AyRkdlajIzODZiSDFMcWZUNnFpd2pjdjFZM2tHOWVH?=
 =?utf-8?B?bTUxNEVZVU5UNVJ3SWVvL3V4V0xIbTlKemgvWDNkZW5mbjcrZ2g5Q3dwUTl6?=
 =?utf-8?B?TTFVU0ttczlxcXBYOUkrMmNMcTUyTmVmQ0RlNXdib3VydlVERzM4UW1hcWN6?=
 =?utf-8?B?Yzg1dkx2djZqcU43TmRLbVBKVDRzSGZIeWJoREN2aGZqZlNjWlQ5ZU5tTFZB?=
 =?utf-8?B?NTQwM3ZVS2pQeFc1OU1JVzZKM3pVbkJEejIrVnVNelMxL21MUmUxdVlmZkJS?=
 =?utf-8?B?OEJpUi9kTks3WjZQWlJYRFNTSUY4M2ZlZjdJK1RzT2wzaUJwbzRpTnkyc1hE?=
 =?utf-8?B?UnVnanE1M3FtbEpCVXJCWURhcW5TYzhQSXROamtvU055NW9yL1FBemRYaDJU?=
 =?utf-8?B?TllnUHBIZVdHcWpDeThQYUU1ODQwK1F0MXVZN1RnRFp3VFl2UnAyTlVOdzZR?=
 =?utf-8?B?dmRvVU5NZWE0MFlYK0JrblhOMFZIenU1L1R6NklIUm9RL2FUSUtDSERvMEE2?=
 =?utf-8?B?OGYybS9aWGd3ajlvNjQ4N3lRVW1EZ0ZvMC9nVVlxYTZORVo4N1lnQ21iR0JY?=
 =?utf-8?B?YXNWQmdWVUhaTVl3U1ZiWWpsOUpxSkZwQ3V3UjU5NWloNmJ1R3Q4Q0FmcXFw?=
 =?utf-8?B?dVBPOUJBcWdaenp4WXNNOUtIaCtMYlFhSDAzc3dudExpZU90eExSQWYzSVBM?=
 =?utf-8?B?V3E4UmVwNk0rMGJKb0hYUXBvT281YStWelM3R3luUHdEMXFPQTBtZGxQNzg4?=
 =?utf-8?B?UkcveUs2UEZHWjBVaG9BTnprTlMxYmFtQVorb2N1QVBJaUxsR09VUUhtSzZa?=
 =?utf-8?B?ZTdId2RDYkNNS0VOalpEMHNFdTB6akpIVFhzYTN1U2dIZ0tRM1B5Tk1XVGRG?=
 =?utf-8?B?RWVwNXNaOUFzUzFKQWNUZS91bis4NEw5NnVrZ1FxSmRuaUNEYUpCWHhYN3hq?=
 =?utf-8?B?REhoSTlvSkFFNFpoemxNYnpNVHdSbS9RQ0x6cDc3VGEwbXduWXNxVHpGWWRV?=
 =?utf-8?B?anJ2Qy9sYzZUK2s2VThQeTVyVStqRTQzc3h5NzdYREs0MHNZMytIbC9aZVRi?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bud0idPBNPg2Ja0JUz1XBi2/Q4UzxPsIEawkX3WLYLjk70RSryDEeUqNWx7aFM2u6+5cCnvjNhcW5t+D+SVWPU8qwuQJcNzjIsrMEr7oIzdUjrsG61/GJLKtjU0b2wJ9xuetZFbW73hNPJZMygUXWRPOyMapbfFrQeXTmoSJuFghEAYaTMcPNRCfrHHk48R5AIWNvqOZxjW1Q/GkqgWMhLUePsKWzJR7VT+XVftH6c3Q/slDgQqP1neKnAdKAVYS3TSQy2i36SRl6DDqIyLn+sb12cxGeRxlL1NjBE3lBV64AZqY/VBjHXpR6SFBZ8B93F/Jx9f3zvO9UI/rGlHikcIqF7sbIgRpzYq+KYKlKjz/Ee4Z92baCNDNe9iu4EFph3do2MLJ6bYsOSjHNjYwByIyf98scbQCjoSNxx5cxy9W5FUUe08NPdJE7qU67H2GrsRhZVBmafhgpyPfEsMqRrfU5zIIbUgoW/JNL4jiNCxyP5D4N5r3Z/mUDBSVQt7ix0Xyt7FJ+r+Uippjk9ZkNuQ6tuNUT4WtLVsPnd0tcB1yX4ubXYfN9dDJHRUY3a+8OhN/gv0fSbgKj7IDGEqspT+h+wr1CgTsD+2tvrDWRXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d85325-d642-4ff6-6de8-08dd83e13bfe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:09:15.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hARFuiTSiis0SCwPwKTTwii26jaT3dQE/b99L4E5W6sh6p/X9ZMfFQuEzNeJqyLvrEX6NSsgEFpGlFB11TmyJsY6PVCNgdek3Qv9kw1KuLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250073
X-Proofpoint-GUID: r7G8uqq48xAVv5VBJADMhaTx8ZtrI4UA
X-Proofpoint-ORIG-GUID: r7G8uqq48xAVv5VBJADMhaTx8ZtrI4UA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3MyBTYWx0ZWRfX/jdcqqVSBNfu +UtR5keAdSZPIcl9fmCrg2Y3ewx3HxarwxX/CyQb2Yzg07DckmMZPQl0GlnygeSymFmTxOWysD7 3x4dX5vuOXhk6tnfG6+QwT7NY/OVwf3O6wtVc607K7mlZLKTT+KYCpCc+YxYZL51lIAFxd1Iaeo
 2PMTkkmsv1VK/dFl1oBZdm6+WDIIQAur6Q60b9bI+8DrhoS171AWwNlD4VRlJD5x6qXvZBGRmVv FtHKdtJUxoGXYKa8Iv+dmTOaqqNek6KkfUUJT6JOs3UXzBp17NfYsMuh8lZ83Y3KcFgPqfPkKJN qoKHgrLOcASNwyTg0AKl6SqLwwrGwUhfmT2zz0UL7Y6Qc6Iq6uicZlPXUfh+1neBe6QR0ZPOccO 7FWYiraL

On Thu, Apr 24, 2025 at 06:22:30PM -0700, Suren Baghdasaryan wrote:
> On Thu, Apr 24, 2025 at 2:22 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > > Right now these are performed in kernel/fork.c which is odd and a violation
> > > of separation of concerns, as well as preventing us from integrating this
> > > and related logic into userland VMA testing going forward, and perhaps more
> > > importantly - enabling us to, in a subsequent commit, make VMA
> > > allocation/freeing a purely internal mm operation.
> > >
> > > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > > CONFIG_MMU is not set, and there is no sensible place to put these outside
> > > of that, so we are put in the position of having to duplication some logic
>
> s/to duplication/to duplicate

Ack will fix!

>
> > > here.
> > >
> > > This isn't ideal, but since nommu is a niche use-case, already duplicates a
> > > great deal of mmu logic by its nature and we can eliminate code that is not
> > > applicable to nommu, it seems a worthwhile trade-off.
> > >
> > > The intent is to move all this logic to vma.c in a subsequent commit,
> > > rendering VMA allocation, freeing and duplication mm-internal-only and
> > > userland testable.
> >
> > I'm pretty sure you tried it, but what's the big blocker to have patch
> > #3 first, so we can avoid the temporary move of the code to mmap.c ?
>
> Completely agree with David.

Ack! Yes this was a little bit of a silly one :P

> I peeked into 4/4 and it seems you want to keep vma.c completely
> CONFIG_MMU-centric. I know we treat NOMMU as an unwanted child but
> IMHO it would be much cleaner to move these functions into vma.c from
> the beginning and have an #ifdef CONFIG_MMU there like this:
>
> mm/vma.c

This isn't really workable, as the _entire file_ basically contains
CONFIG_MMU-specific stuff. so it'd be one huge #ifdef CONFIG_MMU block with
one small #else block. It'd also be asking for bugs and issues in nommu.

I think doing it this way fits the patterns we have established for
nommu/mmap separation, and I would say nommu is enough of a niche edge case
for us to really not want to have to go to great lengths to find ways of
sharing code.

I am quite concerned about us having to consider it and deal with issues
around it so often, so want to try to avoid that as much as we can,
ideally.

>
> /* Functions identical for MMU/NOMMU */
> struct vm_area_struct *vm_area_alloc(struct mm_struct *mm) {...}
> void __init vma_state_init(void) {...}
>
> #ifdef CONFIG_MMU
> static void vm_area_init_from(const struct vm_area_struct *src,
>                              struct vm_area_struct *dest) {...}
> struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
> void vm_area_free(struct vm_area_struct *vma) {...}
> #else /* CONFIG_MMU */
> static void vm_area_init_from(const struct vm_area_struct *src,
>                              struct vm_area_struct *dest) {...}
> struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig) {...}
> void vm_area_free(struct vm_area_struct *vma) {...}
> #endif /* CONFIG_MMU */
>
>
>
>
>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

