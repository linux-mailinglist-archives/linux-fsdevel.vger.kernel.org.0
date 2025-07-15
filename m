Return-Path: <linux-fsdevel+bounces-54992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931FB062E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B87A8E85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7CE244693;
	Tue, 15 Jul 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fBa+BXBf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oJz8rdjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B221C18A;
	Tue, 15 Jul 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593249; cv=fail; b=Aq7MppQvEDo/wF7EnLVS0h7kcEO1x/Ow84Pc1H31ke6PS897tztI33z6HoL/6VM9QK4hVVCY0IkJfgunDKVe2+XSfEYuNk9pbU1TKrtlNvUna2hTRZQNQyM5stNPEQcDcm0J+F7ykTM782XRtO+6qBitrF+G0OYhpp9dzyV5AKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593249; c=relaxed/simple;
	bh=2NoepR6rURGRr28Nb81SPj/YOP+7RQy5ch5lIunt9UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdxcYZSYyuex8S/rm3ges5TWSv410KB6r8Ald2fAGkKIyU60GTiSipXNqmJhUgPl4bW1wCDePFliAUEumEjh0Ziax2jxIivhPEqx5aH9hjCSNOghfiuhSQJUxihuCl6Z10j4/MMccKQyizV3hiKAYdmbvWA/Hph5cCCg/3Zx/x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fBa+BXBf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oJz8rdjG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZLr8003901;
	Tue, 15 Jul 2025 15:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xIX/0h01dafyHlmSah
	PfXaUplP0h79AbxnxSN+HafWA=; b=fBa+BXBfhaVHPCFR/VdoBii0/LnSWYn2aI
	HaD8gTg7PPEJnzL5afeWTa/+Mnh2Z5Z2J4ryv+BLw59O2Nm/+uyRV9sxJ18IjGJS
	7yvPjVXYDaQpB/sk6z6GoeI2NJtz0T7Tu42e4XuuV78/XG5ZiWb8m1G/RvgaNZ9K
	A1F9Up/wf0wL6Fg4l8Esq8KbPSl0AWGZlOm3jNuz5pusDKmALPNIU7y5wMy8XLFX
	scW1S9EZnmr0ArZPle/vMQH7acfLyxwQm9F4Bq/4uOAlsUehGyvPp9DluW3pXIaQ
	63l5ZsVDsQXStDAvXD6IVeb7jA+gDjFtU5UE2nSnPcpbchvzmaYg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7y6sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 15:26:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FEoetk029659;
	Tue, 15 Jul 2025 15:26:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59v8gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 15:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZGaNgFWZLkOawEJo3tix91cWDrB4lEKk2TgcH1wjxWJt5nykbz+ghkQSYnEl/bKhFmB03QGe2vpVXlebjzhZm/RLuPqp7D/vGI/Sya6xXsYWRyEkajNlEseCsakGOLZFzXbuYizQN+E5EWXAZWtQtw5RH3bz02HK4vL9gCIq2opLFZTASf7Dy1OwRetK68XLe1rQ0SY2nlQfdUrI1hHNCw8JQPPgYwQ6J7Apwb0qH0H0cJDvBZQVNZQPX8E0co0P70OXgbc3+jwp8WaQw+BIn+UR8KXZ5RVznVfyTy4uwawN4Pt5ihkOh9Aol5rVxVeQgt9VOhtR6U4w6fXWvPauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIX/0h01dafyHlmSahPfXaUplP0h79AbxnxSN+HafWA=;
 b=ObOBhMNeZhQoAyu2K8OiyjPHmSvCVFkq6g179k6ZGGzOtK/ptgAooJbJErUUc+cC4512v9RqMJAMb+3CwzSqg6YUqaEy3CeeudPcFakQkdBHH1RSknZGsXonzNIguli96JIg7naxjbDkoozNAnNKfXLsvSoDH7J2fE7zW2UO/kbj8EN7SZOLPUM6GyKi72rahLSAs4zISe44NcA9TCEIeBjcmq8EDNis2iREB3qil1+8GNtDsggjMpr8LHcvn+WpD8I3JK8EI6EutTtrk1HPXFiL5kNnB2frpQyY7PVckVRRtJ7ApmTfUpLEnLW+38n2YOUwA/DKjHlbf+R6TFBMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIX/0h01dafyHlmSahPfXaUplP0h79AbxnxSN+HafWA=;
 b=oJz8rdjG7KLqA20q+29DoyKZAQ2TfqKElAANxXgkS+xKjRKwFadtGYaMhETP87Fziw5851csHu6urkd/nomMu40idYFCapkpH3ZhWaslN6ssvQ+Zxr9jCgblPvR3x4FRiBVeRqOdPRbwYKxTZqYIglzOjznLuOVnnS8I7MUKtw4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 15:26:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 15:26:33 +0000
Date: Tue, 15 Jul 2025 16:26:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/5] mm: add static PMD zero page
Message-ID: <13058099-e32c-44e7-ba3c-f34698f1a58d@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-4-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707142319.319642-4-kernel@pankajraghav.com>
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4851d76c-89ea-4322-5e36-08ddc3b3faaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YlmU5QasDPRAmpltnc8w02ZhI+LNn8+KyUMpDNHG5pKrZLMD8oGgJwSNKAz?=
 =?us-ascii?Q?BvjSTLmMY5HuNXK5285D0LioaYf4KE0a1qZyfeHplbtWp32A5NP8LPE4hE09?=
 =?us-ascii?Q?YiGpLXfCDmXICC3CNR7O5dnYu6phOwvCg7XYNFbRB7jahSnqWbfePqnbX1pE?=
 =?us-ascii?Q?GU24Wg+s1h4eONbWuwru4oXezENrYJ4FDQrmd+tH7aWudYXX3Iip1hXjmelS?=
 =?us-ascii?Q?Id0TJitFMN0/tm+o3/zRNv3Rxs9xhWAhDRQ+Rt3R6LgXyHOtfBg0gWqf+H1Z?=
 =?us-ascii?Q?YCAvUZ+/uNz4xZYUM++BYEw5YixkI15Eo2Vii6lPHnTgINQtPbCu2ETbKdPZ?=
 =?us-ascii?Q?A8BubH/Nd/WmUHfJsieJaE8gztx++BHseqdiSa5EMKcaK7LE7IfCdFY7IiZy?=
 =?us-ascii?Q?gSAv8Hi1UuGxIJo5AqSnGPQdsfkBYn/ZQoz6KxGQWLTUTTd/wZsrCq76ZFiD?=
 =?us-ascii?Q?MoiteQSiGf8uKfaTzYPbZjBv0tPROWHIsIsfisvDmYvEgBvE4Wd/UeYQlTyS?=
 =?us-ascii?Q?9KBsiOx/DnJMtJUusxOnt5mKhqDuxBGGQbLs89aY9gQgs/wdKYYFPhpP3lIU?=
 =?us-ascii?Q?ijYDadENIVRgjCEKNRdwDPmmGsTQ3gRNisBbA3PSpYyc6b+76N0p9abgV1ic?=
 =?us-ascii?Q?APZwAtGLS+jQNWDYJ7GN580tEv3RaXCVZ0JtxJGON2iINfSWqszln5rXf6HB?=
 =?us-ascii?Q?M9Yvj9kTQ4rE/+a9TpMRU8DGK91vJRwSGyST9QltML/PQdH8tXCogkb/5bvm?=
 =?us-ascii?Q?tfFtYyD1SLbzLi9RmYNrRK8sFxYUrC9fVuZ4SGsOPpw5E8ZqTpy0U1vC3pe9?=
 =?us-ascii?Q?sK/0iEWxC4C+z9riha8JkRnItx8uL6wSVUBFp9Dw3gFn9rm7Al6j8FyMnqa+?=
 =?us-ascii?Q?zya6zaBwfp1KdslFvcVTihJZK/NGCg9i0xEhHEJG9zOfwHaC2XX3XVr4szOc?=
 =?us-ascii?Q?G9pWlyxBZpGsGyZar5cUgmkfzlMrq+VZQluiqBB6t+yx4mCMSNeDJqHj38bh?=
 =?us-ascii?Q?x2m3dOX2dd02BxqXcKFIcndpCUNpd8ffI8WQzZKKi/gL4nn8XZ+uJCv+fWd8?=
 =?us-ascii?Q?IElbGWShQIGNtbdqhtscObl0qOXNuL0MP7XXvQyQFL8Fbk9pQjzHBtOkSy6g?=
 =?us-ascii?Q?AMp/24n1qpeNm8rlfPxPtpCUfNWbKIVzD/tqRdt2jI00OK3sKP8MtDfDUFzV?=
 =?us-ascii?Q?+wjzeuuvANZZx/LzUh+Js/2hwkH0ZNCNMy8mbHK/CTi3o/euLlssAnS4xTYk?=
 =?us-ascii?Q?gscNAi9do6iwxBOA175y7kqK15T+doaZpUHrhOYGHIX7w7N5pKptV1j7Ol8N?=
 =?us-ascii?Q?aewJwkWi12YY/q1A5qPJymEUPkyt73SRY9st2cbqMTwZYWSjrh9Btp7dEl5E?=
 =?us-ascii?Q?PZvS/Vl1o9KmRqkihMrGgDkGh530FhIJG0Y/Ks6BEL8y1w8PpKKphpmVvcpS?=
 =?us-ascii?Q?2BDilpI16i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+47oqQbJnPn2yaBVPgZxMPyh1A0r0Uip9V0O1XN65VI3iz1967XeCdTCOiCt?=
 =?us-ascii?Q?awuTsHVUFXckEvgN7Vzqgv1S7o1EXjed9kBcw22wfSfw3H04oPlYb19cMKDf?=
 =?us-ascii?Q?/8SFbwPoY7kes2l4BizuN5Wq9NadnhnJp6GPJnVIkMnoT6oO15F9LvGHleLo?=
 =?us-ascii?Q?gXSzIxG0zEuGwKwMtShcdHGRpGBqsPyXtcElRzHUUeuzEdLJHvGbdO1G1cpk?=
 =?us-ascii?Q?LipmXj2zk3ZLNWXl6XZ74SDbGAdLdOSfc2NpQ5tJp6dI8MmpN7NbxXr3AZbs?=
 =?us-ascii?Q?jA2juWdC+SRgBRn7KWVcx6qFGXVdgwZviabAuxgZW2gjgjRq/ej+sIDvaVeC?=
 =?us-ascii?Q?814ps8XqR+LnYxDzfJi5Amg2hNFz7MnyfuBX9CQSSapdaQ7yXrCdFOlieD07?=
 =?us-ascii?Q?Oy7nfJBJ8rmFvFiVY7eKyYyT9UAf2QegXf3MKc/AyVwIEn3zCGvrBzvPBHWG?=
 =?us-ascii?Q?qRriPzqUQhItnN8c8g7nTIKdvhHjq5lWoEMNAJ4CU0oqUGE+qkMwpyN82G6n?=
 =?us-ascii?Q?eXQqn44vrcw9MbrqS4XC0j/0pDxQGTTXhHzRW8QqrR3Di0aLmFcGZ3024WeN?=
 =?us-ascii?Q?tINse8t6ai0swBXi+nkfqezP9TO00/qjvJmxnaK+V9rcsBhaovEc0cexCi/F?=
 =?us-ascii?Q?vFay+9OyYqyJruWEDGQrXzpuGe3y30VNEGOrObJb2EXpHWAUa1xFB0Hcxq6s?=
 =?us-ascii?Q?Rei5THlHjYvwo4LlEu8vIVtf/s42PzoCoqvsnaUBbpFGVsoE+9JxjxYTaRXp?=
 =?us-ascii?Q?GUiOBcXhK3uf4ntxWcp9cbsdmGAP5PXbomFwjGFAD0PgWHfl6guszY8s4GPt?=
 =?us-ascii?Q?WY2BjNVArzirHCZhM/NJFP/044cxun3TFa9i5a+cgWnI2gol52NYm3heHdRi?=
 =?us-ascii?Q?HUPwT1rkCOdcFD3qMQDvo1VaWiUKZ8x9ZdD6TLmzNgnmggh1OBEFyew1Hfiw?=
 =?us-ascii?Q?utZdQsUDAXM2Jg6PseXcu3hMG91Q3kN69kOSJt2h7RCO1H8buiLYfbuSaxrP?=
 =?us-ascii?Q?NTpI2SWkvT16DMl1j9d0twZWlXnPaahtDIa+u/PvAXzemLgWapN8gK/umB91?=
 =?us-ascii?Q?GdmMRYcBV774V+xaSOhOp+Jqy2dInNqpI6Adr6d9zEqQsMQuvM+NfDq15Br/?=
 =?us-ascii?Q?ygofyCOKePOvN421KrK0HdS5D+/ldb7+AXJjxBzmfEWFa8LocKBMXC7z70rk?=
 =?us-ascii?Q?LpOySQhVIpJ+eeWgTp/Jl3Q3jKKMxV2LeYubbNlmz2cCsP5PMY0pQ+sCMWuw?=
 =?us-ascii?Q?fW7ZaygEjHH5kNsdUQq+Z3ryTIgr8MaKPr7BHBBUaUyogcOM1SYvxtzioUY7?=
 =?us-ascii?Q?+mOJh7BtaWbLd4fMfqSqMdj6AKCsAGWVyvGB1sceNHLzErqauMck0VpPFuTj?=
 =?us-ascii?Q?SRbqLvuSKllFsaJRXXZryDTHkJIHkOwNXYzC4+0MDAEuFf3sP1cL9sOUzLFY?=
 =?us-ascii?Q?QyPIAf4LvVAmMZR08eEoadKziLv87C+YMaZVpwXwk4YMNXoMldvuWXFYC9Nc?=
 =?us-ascii?Q?Jb87ny7bsaYw1kpfT9ZvGHNPnOH4/sbyYKzoxF6Hn4lehmoJlhAXrTyvYbuC?=
 =?us-ascii?Q?LmPCc43RnW7Z9FFjkNhu89DbXxXaJtufOHLwjJw4BV6HpEWheMVaV4t/KkW3?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0kfJ7qt8AzbDLGVcq/cpfjpzDa9ukGkxi8wwg7/0gpe2dxpyb46UsBrrx58yLfEPn1n3229XUMLmS9SmA6906MYjK6uW8bMr0tLOMdUU5Ty66J2fSqQrYSZXfeqzFrFpQPPrbsgF3Y3BBR3SuLnhq9bGJ34C/2oENlxw8azDFB9mo2+EtJG5e2VFscVJ3ameGNc+JTtJ3BR5OKK96/fNqM4sT8M/gOtcjFU51D3//7lmWORo3Wv2EJXoKYYIN31LrlEFai4MmBbHXFgiDACJXUww9yMYJQ/KKSV0tpG08S+kngNZu2exLTHGUo86FRvNyWnGyqliVxw2OYjULJgOlRbXZG9S4g3QSPPOjyroXBUhTAkdmWgBaEMPvZBBffLyH/ubTDEb1Vwr/KD+j36c7Mr6MSnZmLofHIhcHkTCs8H/u1OqkHPIbnHPtRhqMAOCeZZ7R3dWM+uVCHlMvuxlFnp5ubFpvHKJm43D+EushXUjuhfYHkG6f9GaKS7Pqo4Zyxh4/TtI/RfNEFzgufODhUIZWCZND1j0NtaiSjLVSFYhe5MGbzSMG0uSDoCkKAYcW5q8SyrIt3J/IFHUuEMpl5sJ3eu6KtZkRIBEef9dC+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4851d76c-89ea-4322-5e36-08ddc3b3faaa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 15:26:33.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: co/jbD+ZTLsBpGPDZl5db12gHtYw2JwBtKHpM1uOdsPn30cWeeOjjkKDUfkIc0qycBrCyTshr+seuFR9pEH3A2sUo797P/7r3c/UoHFuuLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150141
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6876732d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8 a=dPTIhl-epbyvKpsQMKAA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 9nvfd_RTJv8FMxojZTz3mlFzfbLZImRQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0MiBTYWx0ZWRfX86jpZ/krx+lM xluM8Bs1ygGP0sAaXBJdgyFBw3g6cx5SPTPSsJvuV7iLV3X+d0j44BhxLlo7MqUOi2GY5vKs5iQ WQ5bjpI9+Pe1ayiVuegoadG2owFx1oXCBVBo5o8nK02RqP21TS1YFOwsA0TxL0ns8d3dsZz8kyB
 L4V4dmEzrC5Y5PdvXGJ3cvYaJ6mmI/Gysl9sGKt0kO47TCpA2SSyVaCSuC+jM7VhsV7i8VQLJZf ZB/AJdVAkTktzBOr9uhz3uRs7XZlmf1BpGgh/6x7ZXpri9q9L25YLqeNIZzhkRyyBVVxsUhYMuN chwQfjTkoRSZYaGV3V/3mMl8qdNvDWiU0Sok1LAsSVNWkt3vqidbiBZa60pJQk2TWrAcRQdizWW
 cVw+VUSRLHVDFe/glBbJsccDzESy+PKueaUp8s7LnhYK4bRvvwEWGhP1j4pBrzzKIsFBtmcg
X-Proofpoint-GUID: 9nvfd_RTJv8FMxojZTz3mlFzfbLZImRQ

On Mon, Jul 07, 2025 at 04:23:17PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
>
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of single bvec.
>
> This concern was raised during the review of adding LBS support to
> XFS[1][2].

Nit, but maybe worth spelling out LBS = (presumably :P) Large Block
Support.

>
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completitions
> can be async and the process that created the huge_zero_folio might no
> longer be alive.
>
> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
> the huge_zero_folio, and it will never be freed. This makes using the
> huge_zero_folio without having to pass any mm struct and does not tie
> the lifetime of the zero folio to anything.

Can we in that case #ifndef CONFIG_STATIC_PMD_ZERO_PAGE around the refcount
logic?

And surely we should additionally update mm_get_huge_zero_folio() etc. to
account for this?

>
> memblock is used to allocated this PMD zero page during early boot.
>
> If STATIC_PMD_ZERO_PAGE config option is enabled, then
> mm_get_huge_zero_folio() will simply return this page instead of
> dynamically allocating a new PMD page.
>
> As STATIC_PMD_ZERO_PAGE does not depend on THP, declare huge_zero_folio
> and huge_zero_pfn outside the THP config.
>
> [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/mm.h | 25 ++++++++++++++++++++++++-
>  mm/Kconfig         |  9 +++++++++
>  mm/huge_memory.c   | 24 ++++++++++++++++++++----
>  mm/memory.c        | 25 +++++++++++++++++++++++++
>  mm/mm_init.c       |  1 +
>  5 files changed, 79 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c8fbeaacf896..428fe6d36b3c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4018,10 +4018,19 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
>
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
>
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
> +extern void __init static_pmd_zero_init(void);

We don't use extern for this kind of function declaration, and actually try
to remove extern's as we touch header decls that have them as we go.

> +#else
> +static inline void __init static_pmd_zero_init(void)
> +{
> +	return;

This return is redundant.

> +}
> +#endif
> +
>  extern struct folio *huge_zero_folio;
>  extern unsigned long huge_zero_pfn;
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE

OK I guess the point here is to make huge_zero_folio, huge_zero_pfn
available regardless of whether THP is enabled.

Again, I really think this should live in huge_mm.h and any place that
doesn't include it needs to like, just include it :)

I really don't want these randomly placed in mm.h if we can avoid it.

Can we also add a comment saying 'this is used for both static huge PMD and THP

>  static inline bool is_huge_zero_folio(const struct folio *folio)
>  {
>  	return READ_ONCE(huge_zero_folio) == folio;
> @@ -4032,9 +4041,23 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
>  	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
>  }
>
> +#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
> +static inline struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
> +{
> +	return READ_ONCE(huge_zero_folio);
> +}
> +
> +static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
> +{
> +	return;

This return is redundant.

> +}
> +
> +#else
>  struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
>  void mm_put_huge_zero_folio(struct mm_struct *mm);
>
> +#endif /* CONFIG_STATIC_PMD_ZERO_PAGE */
> +
>  #else
>  static inline bool is_huge_zero_folio(const struct folio *folio)
>  {
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 781be3240e21..89d5971cf180 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -826,6 +826,15 @@ config ARCH_WANTS_THP_SWAP
>  config MM_ID
>  	def_bool n
>
> +config STATIC_PMD_ZERO_PAGE
> +	bool "Allocate a PMD page for zeroing"
> +	help
> +	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
> +	  on demand and deallocated when not in use. This option will
> +	  allocate a PMD sized zero page during early boot and huge_zero_folio will
> +	  use it instead allocating dynamically.
> +	  Not suitable for memory constrained systems.

Would have to be pretty constrained to not spare 2 MiB :P but I accept of
course these devices do exist...

> +
>  menuconfig TRANSPARENT_HUGEPAGE
>  	bool "Transparent Hugepage Support"
>  	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 101b67ab2eb6..c12ca7134e88 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -75,9 +75,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  					 struct shrink_control *sc);
>  static bool split_underused_thp = true;
>
> -static atomic_t huge_zero_refcount;
> -struct folio *huge_zero_folio __read_mostly;
> -unsigned long huge_zero_pfn __read_mostly = ~0UL;

Ugh yeah this is a mess.

I see you're moving this to mm/memory.c because we only compile
huge_memory.c if THP is enabled.

Are there any circumstances where it makes sense to want to use static PMD
page and NOT have THP enabled?

It'd just be simpler if we could have CONFIG_STATIC_PMD_ZERO_PAGE depend on
CONFIG_TRANSPARENT_HUGEPAGE.

Why can't we do that?

>  unsigned long huge_anon_orders_always __read_mostly;
>  unsigned long huge_anon_orders_madvise __read_mostly;
>  unsigned long huge_anon_orders_inherit __read_mostly;
> @@ -208,6 +205,23 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	return orders;
>  }
>
> +#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
> +static int huge_zero_page_shrinker_init(void)
> +{
> +	return 0;
> +}
> +
> +static void huge_zero_page_shrinker_exit(void)
> +{
> +	return;

You seem to love putting return statements in void functions like this :P
you don't need to, please remove.

> +}
> +#else
> +
> +static struct shrinker *huge_zero_page_shrinker;
> +static atomic_t huge_zero_refcount;
> +struct folio *huge_zero_folio __read_mostly;
> +unsigned long huge_zero_pfn __read_mostly = ~0UL;
> +
>  static bool get_huge_zero_page(void)
>  {
>  	struct folio *zero_folio;
> @@ -288,7 +302,6 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>  	return 0;
>  }
>
> -static struct shrinker *huge_zero_page_shrinker;
>  static int huge_zero_page_shrinker_init(void)
>  {
>  	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
> @@ -307,6 +320,7 @@ static void huge_zero_page_shrinker_exit(void)
>  	return;
>  }
>
> +#endif
>
>  #ifdef CONFIG_SYSFS
>  static ssize_t enabled_show(struct kobject *kobj,
> @@ -2843,6 +2857,8 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
>  	pte_t *pte;
>  	int i;
>
> +	// FIXME: can this be called with static zero page?

This shouldn't be in upstream code, it's up to you to determine this. And
please don't use //.

> +	VM_BUG_ON(IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE));

Also [VM_]BUG_ON() is _entirely_ deprecated. This should be
VM_WARN_ON_ONCE().

>  	/*
>  	 * Leave pmd empty until pte is filled note that it is fine to delay
>  	 * notification until mmu_notifier_invalidate_range_end() as we are
> diff --git a/mm/memory.c b/mm/memory.c
> index b0cda5aab398..42c4c31ad14c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -42,6 +42,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/memblock.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/numa_balancing.h>
>  #include <linux/sched/task.h>
> @@ -159,6 +160,30 @@ static int __init init_zero_pfn(void)
>  }
>  early_initcall(init_zero_pfn);
>
> +#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
> +struct folio *huge_zero_folio __read_mostly = NULL;
> +unsigned long huge_zero_pfn __read_mostly = ~0UL;
> +
> +void __init static_pmd_zero_init(void)
> +{
> +	void *alloc = memblock_alloc(PMD_SIZE, PAGE_SIZE);
> +
> +	if (!alloc)
> +		return;

Ummm... so we're fine with just having huge_zero_folio, huge_zero_pfn
unintialised if the allocation fails?

This seems to be to be a rare case where we should panic the kernel?
Because everything's broken now.

There's actually a memblock_alloc_or_panic() function you could use for
this.

> +
> +	huge_zero_folio = virt_to_folio(alloc);
> +	huge_zero_pfn = page_to_pfn(virt_to_page(alloc));
> +
> +	__folio_set_head(huge_zero_folio);
> +	prep_compound_head((struct page *)huge_zero_folio, PMD_ORDER);

What will the reference count be on the folio here? Might something
acccidentally put this somewhere if we're not careful?


> +	/* Ensure zero folio won't have large_rmappable flag set. */
> +	folio_clear_large_rmappable(huge_zero_folio);

Why? What would set it?

I'm a little concerned as to whether this folio is correctly initialised,
need to be careful here.

> +	folio_zero_range(huge_zero_folio, 0, PMD_SIZE);
> +
> +	return;

You don't need to put returns at the end of void functions.

> +}
> +#endif
> +
>  void mm_trace_rss_stat(struct mm_struct *mm, int member)
>  {
>  	trace_rss_stat(mm, member);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f2944748f526..56d7ec372af1 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2765,6 +2765,7 @@ void __init mm_core_init(void)
>  	 */
>  	kho_memory_init();
>
> +	static_pmd_zero_init();
>  	memblock_free_all();
>  	mem_init();
>  	kmem_cache_init();
> --
> 2.49.0
>

