Return-Path: <linux-fsdevel+bounces-57371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54DB20CA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8383A8E34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023952D3230;
	Mon, 11 Aug 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+Oe7LUi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GCn6s01r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86971214204;
	Mon, 11 Aug 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923726; cv=fail; b=N42A9SIcHbxxC5jkA01Fneui72R8MpIwuXWvOG5ZEhsywktfZFFhio59HBiU6igFEnjTfrlubE83DJRY42O7sreNHz7AugW5jpxnNA4ZzhrotskW18yj6eVxp6ThkSrYtldEiGmNIu/M+5rtk4o/EOzKEIUt4/4g/bJxMERWV1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923726; c=relaxed/simple;
	bh=WSvfuwnhWJ9hTf/Nzo1iXqTiD0/wrp9sGUFwqHug4fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j/aouDp3UegIxmfWNw6JMokkY1x3A4fuY18AbCwXBTumoOOOWMqMM7QeNdDT0C7nF+fUbsekr5cAU6WkYzE2NyU3cTrvXFOqK8NXl7T4pq85yChKK1Ov7fcoOBfEfZLJDuTiFghPoh4uYsgSJ5/zSYROPAGpEpuydgmFGc6Dh2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M+Oe7LUi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GCn6s01r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDMupD007324;
	Mon, 11 Aug 2025 14:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=x5sNrYL/4fgBk+TdhWVkJauYBIbv623FUV9s4/PMFBg=; b=
	M+Oe7LUiyYmFFEDApSDKe2ZeKz9lM+tSEO565AHQMheI0VGO6oNCDnPLNFBvAC4D
	rIIjZlMPRdDOF9VHHz5iFj3D4zriDwaZn5+zECPZlzKJ/W2yZvR4LDKK0OMmfhj/
	jx9qC4t41BZAU0giw+GfPewculMRg3rUcEENfmZOwlhaopcw7pek019mDBpr4CE+
	0+rF4de30gxmADUy9M2USH7tn06yT5cJ8J58qTioz49zTR/MPIe7YU6P1K1dfHUj
	rPKENwc8OiEAHlX/BSwEvAVRv6rK/1r0bsu3H4AsmgrQ0KDB+77qiwlbHl2A60+p
	XoRM83iSjcHwzZTLyppsPw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8eas5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:47:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BEjwoC017505;
	Mon, 11 Aug 2025 14:47:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8r0pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8UNj1k5ezBg/jTTa712qbQhAfuDeurNLy0UU8eidK0F11+5s0zZCcHXzGZDcMDEyRqhZUkO5pTqDpYD91gCczCBn5yiRdpClVi/zlg/JjDBBtahUqUcgZqE/8jvsevaa0AnF23j9BC8UroVrxl1Gdp6wCdGRpvQrFg2duirjGSftZ3/LtVILw//aBJ4BBVY5gB2oLAo7NMDWBuIXrqo0tC8URVHcsYV4cwsaldFUPyBWNGBjs8NJwQfEJzCwycRzfjJjyPiNO+AsGYIC3fnLDWxY8Kdg8ODlo4O/TUCj3GyBY8aUuSh1II72EltLk809n7ZZM+/LUlIcImGN38l8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5sNrYL/4fgBk+TdhWVkJauYBIbv623FUV9s4/PMFBg=;
 b=TCvVIv3H6Cs4gEna3+v78mTequWYa08aOeW3d0aU5T2U6gn1uhZ9SSfd3aP/q3Yo0Y0z7OEdPTcXaTwi5h9R1XKGgKoHcXbD0xIOUKXhAAY8w3R3svVEA/l0YwBwqfQElWRXVQlF9+i5xw6b8fHXHkxZC5H2zT62d8G9VdI9g7LPhiNdw28kCfAvR56obIMIi0Xf4HJHKRq9b+9D8ESKvLpDYZbB5VcTwC4yjeEPhLxUphL6K1BUWARapwSPEXhfN1kFz9nwnqt9YqA+tt9qRum0L0iwMSZsh31HM97IehmLRsTZSTNC24jkpq8eSGWKPOYbnZGM9PNHnt/H02K5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5sNrYL/4fgBk+TdhWVkJauYBIbv623FUV9s4/PMFBg=;
 b=GCn6s01rdOOqnnrzPaadgc4CVBipfDsapk5ohJUoGu/7rJjVymFnt1WNrGoyuuqtFL3vhme2uQW/0Uo+SXvKthwz0grWaufmggCIXzNTpYo7xkD6XE4fZiVwXrTMoFZ6aUgYQz18BO1ViOW+rmrn2D+pGrGEJ+TKsbOgyceogGo=
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d) by MW6PR10MB7688.namprd10.prod.outlook.com
 (2603:10b6:303:246::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:47:35 +0000
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::731a:2be4:175e:5d0b]) by DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::731a:2be4:175e:5d0b%2]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:47:35 +0000
Message-ID: <cf7f917a-e81a-482b-a28f-9b2017821aca@oracle.com>
Date: Mon, 11 Aug 2025 09:47:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] treewide: remove MIGRATEPAGE_SUCCESS
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250811143949.1117439-1-david@redhat.com>
 <20250811143949.1117439-3-david@redhat.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20250811143949.1117439-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF35CFB4DBF:EE_|MW6PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d51241-062e-463b-120a-08ddd8e60246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mnl1eDNMU2hrVldXTWFBdXlGdXZ1Y0RkOXM0cnpycTJxdDZack9QWjRlcnNW?=
 =?utf-8?B?OTJibjNsL3BQSEZtaUZPeHhZbGZDclo4Zmcxc05oeWc4YXU0RnR1Y1VxNkw0?=
 =?utf-8?B?THI0R3l2djhZcURFMFNIZ3c4MzF1RXZRUS9oQWtOQ1pRd1NsZmlQVjJJaTNP?=
 =?utf-8?B?OHRYY290S0cwOWo5elFDN3Q4UDA1dk5QRUF1bVk4TTBsd2NQcEs5b0lONXRw?=
 =?utf-8?B?TmNwK3dDcTBUV3FZaTc3cjNZMnVXaTQvd2k1YzhSbW5Lb01icDJrdDF6TCtt?=
 =?utf-8?B?QU5SZTV2Y2N0NzArbmR2NFRZTCtaazAxL2NVUnhWYlBKcUwwOENVa0VvOW8z?=
 =?utf-8?B?VkFZcVk5c09TcFVzTUVIakJtbHUzNEsyakpnbytLRDN4VU1YRDhyWVUzSXZO?=
 =?utf-8?B?cUFnRk5oanZ3WGNVT1lnQ3BQWkNTc3Rpa0ViWlZ0SmtVanFOeUkreE5LWGNw?=
 =?utf-8?B?SUYrQi9MdTBqdENnemJSd01vWnBib0VhbDN6UW9FVFoyQWpkdllNNXZQNjVH?=
 =?utf-8?B?ZlpoU2puK3A1SHdBZDYwb25RL2dTeTBkK1BrKzFrdGJlZWNBWlNKNitWMTl1?=
 =?utf-8?B?cnhhY2hzR3pFNE43MVIycUJRam85NnMxZnFNbmNLL054QmdGN256bDhMZkR3?=
 =?utf-8?B?Y2taZkZZdnBuY0x4dzh3YTZwNEwvbzlDQWdJQWJtUGtvN3duNEp4eGIrcmUr?=
 =?utf-8?B?enJReWhjemdlK0JHNEpvWTNhWWpRSUxGU01jMGdDL3pML1FSZDEwVnhGclls?=
 =?utf-8?B?NHc5bXJ0Q1VCaW11NjE5V0RacWk0UTBTaGpaanMvTzI3Ykx0MmNPU0FJZ1Yz?=
 =?utf-8?B?WWZZVy9nUlpvY3B5L2REWXo0TVVsMGNPUGZNV2p2VXExaFhsaUVtRTkvYldt?=
 =?utf-8?B?aWQrUGErenNFOVhjTE1CSzdxby9mcGNpTUFZNEtFdTgzcXdpS1JPeHVSQ3Nw?=
 =?utf-8?B?ZFNUWDJOUmRPWXZGWVc2U2ZRTncvWWJxaStQT1diL3l2NVNwejhWUlQ3d1NV?=
 =?utf-8?B?REllUVdMZThycVd6M2Zkc1dKVW1UaDEwWHZqSFF6NnNzNkVUK0YrZ2RXN05y?=
 =?utf-8?B?UFNZME9GYStBTlA3N3RMbXhGQ0V5NVlRVnZrTzFGdkRjc29CYjZzOWpyQmFM?=
 =?utf-8?B?eWdqTXZoVjdTMjZhRnhQdzNwM1hZSnJNWC91TUdFNTYzYWNJWXphYmIyNGYv?=
 =?utf-8?B?WExpZnpkd2ZZM1h1Ykp4VjlUaUNZUFd3REhTaGVscFV3bVVOK0p4TmxST21M?=
 =?utf-8?B?S3BRVnA5VjF2YTdTays0V1FxUWxUOUlCeTN0TE5Pd0NaNms2a05FTmFWL0Yr?=
 =?utf-8?B?TUR4NlRFdndtQ1g0NlJsWityaXB5QlZDRlRBcVFBL2lOdXB6dnJvNEM0Z3Rq?=
 =?utf-8?B?QklmQUk2NnVEK1RtUFFWbUtnQWFxdGtZQ3VhQ2cvVFEya2ZUeWVwdlhsSnpF?=
 =?utf-8?B?dFhLbk8zWnZoQm9wdFl4eEVpeXRHUHhBSDd4YWYvOUUrN0hHNG1QQmNCZUw3?=
 =?utf-8?B?bkRPS1ZtMk4yZ3V3QTJGazJTc1FxazBtWC9MUGhTQkN4WlRVeEE0TjIvb1pL?=
 =?utf-8?B?bS9lOFoyeE14SzNFNCtUZmp5ZzVJNzEwQWpMOFV3SkJ0LzBLUStkcG04ZzF2?=
 =?utf-8?B?VnhiMkJJVWJ2eWJUWnpzQ2tNWjU5MWpFNW11cm9RcUdTeld2YXE3SXY2Zzcx?=
 =?utf-8?B?UHZJY2dTRm8yWm5nd2dUWEFLZ2NJbXJUb3UwUmNWU3R1bmZka2tDWDBwYy9a?=
 =?utf-8?B?S25iSkpyWnlBemdUS29TMnFaY0YvKzllRE5zTXNNVklUK2FyY3djSWIzckZI?=
 =?utf-8?B?eUQ1WFdGY3RNeGw5L3ppTjE3TE9mRlVPYVBHUjFsUTFEZWVRWjI1MlVScGdn?=
 =?utf-8?B?bjF6RkpuZ1VTK0xmbHNnZ3Jsc0Yra1c2c0Via2dNOGw3eFEvRXBTS0FaeGU2?=
 =?utf-8?Q?7voFWocXydg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF35CFB4DBF.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkdweSswZURkbFRXNUtnNTFFK2IvazVEZVQ5ck1MNEh5VCtQZWxFeSs1amNs?=
 =?utf-8?B?TDVvRmR1TjE5UEFibEtUellsWnNYN3B0aHJJWWx5YUpEaW5IcUx1UkY0dHZs?=
 =?utf-8?B?WXgyOU50ZUEwckJHMWFzUnhLRjkyMzdaMjIvQ3ZCVDhtNG5nUXdMbC9MOFkr?=
 =?utf-8?B?M2ROWEt5S0lNT2dQR2NVdmREZkRPTklCek1jMEkrY1kvSWZOa1FvejdDWTR3?=
 =?utf-8?B?T0d5OU9Ec2VHZUJMYyt1M2wrRFVNbUlkTTVqOFc3R2ltbzhiS0FQNHN0M0h2?=
 =?utf-8?B?ZUdwZTNtWGFSWDNrejhnNzJUQW4ycEZYTDMwakV4dUg3RFZuTWhsL2FLRFVk?=
 =?utf-8?B?Zm43SVZNYnRmNkJZWVdwdXhvcHgzVmROSVZ5NjRDbjdZSUFqNXNOd09OVTVr?=
 =?utf-8?B?U3lvYXM0LzMreDlDaHFuR2xLTXZ2YzRyZXpWNVNEV0x3T0dlbnRINTJ1cE5O?=
 =?utf-8?B?UVI4dGJWRWFTQTVTUDJLZkVTOFRvT0R0RXErd2xqc0plTUtBUzE2d2czZlVo?=
 =?utf-8?B?eFRMclZRamI4aTl2d09Md29TOTNUOVVmcElsRWpEU2lyVHVKR2tPNXE3Vzlm?=
 =?utf-8?B?QzdzTHlabnlhSHc2SDVFRWc4blAvZS8vYll0SGY3TER4bXh3bWd1Tis2OC84?=
 =?utf-8?B?TXpjby9hWkZvRDNKekwwWHV5cUowMFJXdGZ4UUtweGF4dWZyb29GWW93ZTVE?=
 =?utf-8?B?bHRoem5BY1pseDJkUG1yejY5Znc2VHpncGFmM2tZWjcvN2dqR2NSN0ZDTlE4?=
 =?utf-8?B?MkdCZW9jVldJcTR5U3VRRVdrY0FtbW5SZUlEdWIyQXhkYmFVNzdZYUpMQ2sv?=
 =?utf-8?B?NmtNZGlRaGVQZlc4QVZLdTRRaFd0eitDWTlVa0FneUNPRWZsWDBjL2g1YXMz?=
 =?utf-8?B?NmxNQlBzbXZUVFpzZXdBTGVhQVIyVmdQSHpCMmE0WnZiTFRpRzRZWjF3eGM4?=
 =?utf-8?B?ZFlGR0d3c0NnTC8xV0lyck1jSkdpRStPUWRRQzRDYlNpN1hXdXRVV2dpZ2t5?=
 =?utf-8?B?c2pDTTkraVhTZ0RYTGwzNWZlQVJmbXkvTXMvRjJOeWZldEtaLzFpUEFJLzky?=
 =?utf-8?B?MVQ5WmRtZkRBSVYwcU42N1dQek52TXE4Y3FzRmRLb1RzYUlKSVJpVTErcVg2?=
 =?utf-8?B?N2NQMjJQS2FrQUhCNnVSY3daZnJQTjI3TDRwZFU1TUFqdXN2ZHBRbFNWMzhk?=
 =?utf-8?B?ZzRlMkF1c0crZjhyVm9CTzJkVmdock0reVd1MFFqNTRvWDZyZ0k1MjNYSnBB?=
 =?utf-8?B?VGNKQ0lWTWtEeThVN2pDNk9tME1UTDhnMUx5L1hkQ01Ea280TkJDUnI2WGlH?=
 =?utf-8?B?VTdwU3B6RUxrT3JraFJqNzhraGFFd1VsUEtLQVh6YVhMOXJrVVRLbGdEZmhq?=
 =?utf-8?B?eDM1TWIzejkyN2xvUU02RzBNcVFaYkVucWlrclk2RU5OMS9vcUlWZWZSRy9v?=
 =?utf-8?B?MHR0eUxzMjVwdElFRVlqT1FKc0k1cXFGSXlGZHBiWHhpTzlicFJGb1Z0OW9Y?=
 =?utf-8?B?Z0Y2cExMUmwxenYzNzU5TFdobmJiNkxDT2R1SG9qSDF6SUFCZERvQ1VuZU1l?=
 =?utf-8?B?Nm05U2d4RXRLQjFBNXVkdFVKTVBna1lMck0xc1MrZVZtaVlsQzZ5OVNvekFi?=
 =?utf-8?B?YlAwc21wTkJKNXhKUnFPZFRBOEJlbm1sSnloaEZsWkdyWjVZb3BMcmZ2L002?=
 =?utf-8?B?cEdmUVVXa0hmYk9Gc08xb2FHRkZjdnlQSXNlOUhvTUpxQlMvNm5LSm1EQVBi?=
 =?utf-8?B?OVQrRmRNSEhiYjVZb3VRaWV1SFRhMGF6UjRRKzlvS3dBYmNsUmM4dVdQdHAv?=
 =?utf-8?B?ZzI3N1R2M0lTVzlDQjhxVUpOczJRaUl3NVBaMFhoN01kZk41eDVsbHhvVzRG?=
 =?utf-8?B?ZitBV291ajB6dHZjSVVOcURHOGwyaHd1OFFFdkJ6WmhDd1AzdE1zdnJXUkFW?=
 =?utf-8?B?K0lOVlBueThEQmFSeS9yRzJKbUh4VVh3THNidFR1QVhqQjdNU3RiYWRIaVFi?=
 =?utf-8?B?dlU1SWV2dHJSRGdOOTQ5QTJiY0dkSFg4MkRpOVRzTDE2eE9hK3FvNi9rVnZv?=
 =?utf-8?B?dlRWd2l2RlZTazI4M2NzUG5oUVZHZElvUmpsNDhoMVhMTkRtbkdiVlF2K1pk?=
 =?utf-8?B?SjIvR1VKYU91UEtCQlJVYmpKMkhlZ2JIYjFHeHFkbEdyelVqZXNxbDVFakk3?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f7YsY8jOJmno7/rEX2l+/EW3FbmSJXsEd1zY1UyR5ET/T+Tqr25ZwYQAhwcpo53jNPr+XezM0fSrTlE6gYDjyB5I8ksqiFmghqU/Xfbxms7Vbpr3syVcIa2Zb8ZtkfkJ2D/myBCvpL+5iSRsq2M0z5T0TYPURx9vFwy2O5jceQuw8B9DBUazeHf5BLLI1rg4zEQjJaQtU1VLKZHys0hxp3EO1mEL2fEf+Z+uF0XN+eBoLycj5+Ww+yMuE5G1BJ+yAbBAjP3GI5iTZAeHwxF830guC+qKjrw/MzyxSQ5HkULg+c+ypuqjTtbYbAo+dzfJ4Fz0cMNuxxOC1POIzdCUaDLNIi2XkcFJ3enGX/0zaArsOwDPkcHZX/egIf8Q95jvXwFhEcXn7dHFYy2+9Bb9RvWAHp2W5XUwc511s2KTH9u3+PNf1MKzquoJLiFS98zCOG8Uwc5Ini2QpPnaJP3Mgxk/J6X3UDRYeBmPYtw9qSoUmKBxuVmx3lZbMmWeYvaIcvzG/TMg2JjVSRDADQww5iWKSC8GBjfDxtJIa1G+rzLxW8Zm3/J9vNamXrxMRRf63/2ZhiqHFAb+rulESuIR7e+kRvrKEdi4bUO3PYm112U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d51241-062e-463b-120a-08ddd8e60246
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF35CFB4DBF.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:47:35.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+F2B1Ur/7zDS/tJFvXrjkE8lpUpnFzblYnAwImDtlwRkXsViz5FjW/VphLXyHousU+4/AnWtzWquePuWA80DP7l2n8LtnN24FvWH+D2UKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110094
X-Proofpoint-GUID: krLYwdyRa_jgDobpmduZsjCJjXJ_R1ps
X-Proofpoint-ORIG-GUID: krLYwdyRa_jgDobpmduZsjCJjXJ_R1ps
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=689a028c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=7RSBwNs5q4-hbVoDzdkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NCBTYWx0ZWRfXyzmwheAQMdmU
 iXW1p+iIn8CRU3bIHfZjm8jgmHzVbksNqlRQGBtIKBmN0dgOEswPeC2AhLGQqcR7ohN2zVFsK2p
 o6mmCEMOOrJdIWOSs/QjezCvKM39nwQWcOl5HXwmMdvpqSq/BpjSzBaAc5Xl9EaTUgV/Tr1UjRD
 sJKroiJrIgwPI6QgSsOwtHQD4uiNLsGhBlLZaqxTKhXREngVIuw7dXh+aj3yatqEdWIy2j67Xhd
 EgWiEksDbGB2xQRsWd3Gc6HLwhgn008Rqujv2rKJxkxTnDmK6OyvEAoaLT51YE8AYqo1n/ZH6Vt
 hrKJFKaXbiaOC3pEkVLMg/7CrfNX0T3h80HwXTHaKlf6kqQNUE+7FkCU3ylfKhTBRCHzNzjfFq0
 ZQpP3qNE63UFLdZGCMAoWo5eZuxFCz+sgGLyoo1/42cNNx3Pc5yHOpkYLeHNCdQmoA5bLPW1

On 8/11/25 9:39AM, David Hildenbrand wrote:
> At this point MIGRATEPAGE_SUCCESS is misnamed for all folio users,
> and now that we remove MIGRATEPAGE_UNMAP, it's really the only "success"
> return value that the code uses and expects.
> 
> Let's just get rid of MIGRATEPAGE_SUCCESS completely and just use "0"
> for success.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

For jfs:

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>   arch/powerpc/platforms/pseries/cmm.c |  2 +-
>   drivers/misc/vmw_balloon.c           |  4 +--
>   drivers/virtio/virtio_balloon.c      |  2 +-
>   fs/aio.c                             |  2 +-
>   fs/btrfs/inode.c                     |  4 +--
>   fs/hugetlbfs/inode.c                 |  4 +--
>   fs/jfs/jfs_metapage.c                |  8 +++---
>   include/linux/migrate.h              | 10 +------
>   mm/migrate.c                         | 40 +++++++++++++---------------
>   mm/migrate_device.c                  |  2 +-
>   mm/zsmalloc.c                        |  4 +--
>   11 files changed, 36 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 5e0a718d1be7b..0823fa2da1516 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -545,7 +545,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>   	/* balloon page list reference */
>   	put_page(page);
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   
>   static void cmm_balloon_compaction_init(void)
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 6653fc53c951c..6df51ee8db621 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1806,7 +1806,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>   		 * the list after acquiring the lock.
>   		 */
>   		get_page(newpage);
> -		ret = MIGRATEPAGE_SUCCESS;
> +		ret = 0;
>   	}
>   
>   	/* Update the balloon list under the @pages_lock */
> @@ -1817,7 +1817,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>   	 * If we succeed just insert it to the list and update the statistics
>   	 * under the lock.
>   	 */
> -	if (ret == MIGRATEPAGE_SUCCESS) {
> +	if (!ret) {
>   		balloon_page_insert(&b->b_dev_info, newpage);
>   		__count_vm_event(BALLOON_MIGRATE);
>   	}
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index e299e18346a30..eae65136cdfb5 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -875,7 +875,7 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>   	balloon_page_finalize(page);
>   	put_page(page); /* balloon reference */
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   #endif /* CONFIG_BALLOON_COMPACTION */
>   
> diff --git a/fs/aio.c b/fs/aio.c
> index 7fc7b6221312c..059e03cfa088c 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -445,7 +445,7 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
>   	folio_get(dst);
>   
>   	rc = folio_migrate_mapping(mapping, dst, src, 1);
> -	if (rc != MIGRATEPAGE_SUCCESS) {
> +	if (rc) {
>   		folio_put(dst);
>   		goto out_unlock;
>   	}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b77dd22b8cdbe..1d64fee6f59e6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7411,7 +7411,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
>   {
>   	int ret = filemap_migrate_folio(mapping, dst, src, mode);
>   
> -	if (ret != MIGRATEPAGE_SUCCESS)
> +	if (ret)
>   		return ret;
>   
>   	if (folio_test_ordered(src)) {
> @@ -7419,7 +7419,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
>   		folio_set_ordered(dst);
>   	}
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   #else
>   #define btrfs_migrate_folio NULL
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 09d4baef29cf9..34d496a2b7de6 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1052,7 +1052,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
>   	int rc;
>   
>   	rc = migrate_huge_page_move_mapping(mapping, dst, src);
> -	if (rc != MIGRATEPAGE_SUCCESS)
> +	if (rc)
>   		return rc;
>   
>   	if (hugetlb_folio_subpool(src)) {
> @@ -1063,7 +1063,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
>   
>   	folio_migrate_flags(dst, src);
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   #else
>   #define hugetlbfs_migrate_folio NULL
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index b98cf3bb6c1fe..871cf4fb36366 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -169,7 +169,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
>   	}
>   
>   	rc = filemap_migrate_folio(mapping, dst, src, mode);
> -	if (rc != MIGRATEPAGE_SUCCESS)
> +	if (rc)
>   		return rc;
>   
>   	for (i = 0; i < MPS_PER_PAGE; i++) {
> @@ -199,7 +199,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
>   		}
>   	}
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   #endif	/* CONFIG_MIGRATION */
>   
> @@ -242,7 +242,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
>   		return -EAGAIN;
>   
>   	rc = filemap_migrate_folio(mapping, dst, src, mode);
> -	if (rc != MIGRATEPAGE_SUCCESS)
> +	if (rc)
>   		return rc;
>   
>   	if (unlikely(insert_metapage(dst, mp)))
> @@ -253,7 +253,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
>   	mp->folio = dst;
>   	remove_metapage(src, mp);
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   #endif	/* CONFIG_MIGRATION */
>   
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 40f2b5a37efbb..02f11704fb686 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -12,13 +12,6 @@ typedef void free_folio_t(struct folio *folio, unsigned long private);
>   
>   struct migration_target_control;
>   
> -/*
> - * Return values from addresss_space_operations.migratepage():
> - * - negative errno on page migration failure;
> - * - zero on page migration success;
> - */
> -#define MIGRATEPAGE_SUCCESS		0
> -
>   /**
>    * struct movable_operations - Driver page migration
>    * @isolate_page:
> @@ -34,8 +27,7 @@ struct migration_target_control;
>    * @src page.  The driver should copy the contents of the
>    * @src page to the @dst page and set up the fields of @dst page.
>    * Both pages are locked.
> - * If page migration is successful, the driver should
> - * return MIGRATEPAGE_SUCCESS.
> + * If page migration is successful, the driver should return 0.
>    * If the driver cannot migrate the page at the moment, it can return
>    * -EAGAIN.  The VM interprets this as a temporary migration failure and
>    * will retry it later.  Any other error value is a permanent migration
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e9dacf1028dc7..2db4974178e6a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -209,18 +209,17 @@ static void putback_movable_ops_page(struct page *page)
>    * src and dst are also released by migration core. These pages will not be
>    * folios in the future, so that must be reworked.
>    *
> - * Returns MIGRATEPAGE_SUCCESS on success, otherwise a negative error
> - * code.
> + * Returns 0 on success, otherwise a negative error code.
>    */
>   static int migrate_movable_ops_page(struct page *dst, struct page *src,
>   		enum migrate_mode mode)
>   {
> -	int rc = MIGRATEPAGE_SUCCESS;
> +	int rc;
>   
>   	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(src), src);
>   	VM_WARN_ON_ONCE_PAGE(!PageMovableOpsIsolated(src), src);
>   	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
> -	if (rc == MIGRATEPAGE_SUCCESS)
> +	if (!rc)
>   		ClearPageMovableOpsIsolated(src);
>   	return rc;
>   }
> @@ -565,7 +564,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   		if (folio_test_swapbacked(folio))
>   			__folio_set_swapbacked(newfolio);
>   
> -		return MIGRATEPAGE_SUCCESS;
> +		return 0;
>   	}
>   
>   	oldzone = folio_zone(folio);
> @@ -666,7 +665,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   	}
>   	local_irq_enable();
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   
>   int folio_migrate_mapping(struct address_space *mapping,
> @@ -715,7 +714,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
>   
>   	xas_unlock_irq(&xas);
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   
>   /*
> @@ -831,14 +830,14 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
>   		return rc;
>   
>   	rc = __folio_migrate_mapping(mapping, dst, src, expected_count);
> -	if (rc != MIGRATEPAGE_SUCCESS)
> +	if (rc)
>   		return rc;
>   
>   	if (src_private)
>   		folio_attach_private(dst, folio_detach_private(src));
>   
>   	folio_migrate_flags(dst, src);
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   
>   /**
> @@ -945,7 +944,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>   	}
>   
>   	rc = filemap_migrate_folio(mapping, dst, src, mode);
> -	if (rc != MIGRATEPAGE_SUCCESS)
> +	if (rc)
>   		goto unlock_buffers;
>   
>   	bh = head;
> @@ -1049,7 +1048,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
>    *
>    * Return value:
>    *   < 0 - error code
> - *  MIGRATEPAGE_SUCCESS - success
> + *     0 - success
>    */
>   static int move_to_new_folio(struct folio *dst, struct folio *src,
>   				enum migrate_mode mode)
> @@ -1077,7 +1076,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>   	else
>   		rc = fallback_migrate_folio(mapping, dst, src, mode);
>   
> -	if (rc == MIGRATEPAGE_SUCCESS) {
> +	if (!rc) {
>   		/*
>   		 * For pagecache folios, src->mapping must be cleared before src
>   		 * is freed. Anonymous folios must stay anonymous until freed.
> @@ -1427,7 +1426,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>   	if (folio_ref_count(src) == 1) {
>   		/* page was freed from under us. So we are done. */
>   		folio_putback_hugetlb(src);
> -		return MIGRATEPAGE_SUCCESS;
> +		return 0;
>   	}
>   
>   	dst = get_new_folio(src, private);
> @@ -1490,8 +1489,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>   		rc = move_to_new_folio(dst, src, mode);
>   
>   	if (page_was_mapped)
> -		remove_migration_ptes(src,
> -			rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
> +		remove_migration_ptes(src, !rc ? dst : src, 0);
>   
>   unlock_put_anon:
>   	folio_unlock(dst);
> @@ -1500,7 +1498,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>   	if (anon_vma)
>   		put_anon_vma(anon_vma);
>   
> -	if (rc == MIGRATEPAGE_SUCCESS) {
> +	if (!rc) {
>   		move_hugetlb_state(src, dst, reason);
>   		put_new_folio = NULL;
>   	}
> @@ -1508,7 +1506,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>   out_unlock:
>   	folio_unlock(src);
>   out:
> -	if (rc == MIGRATEPAGE_SUCCESS)
> +	if (!rc)
>   		folio_putback_hugetlb(src);
>   	else if (rc != -EAGAIN)
>   		list_move_tail(&src->lru, ret);
> @@ -1618,7 +1616,7 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
>   						      reason, ret_folios);
>   			/*
>   			 * The rules are:
> -			 *	Success: hugetlb folio will be put back
> +			 *	0: hugetlb folio will be put back
>   			 *	-EAGAIN: stay on the from list
>   			 *	-ENOMEM: stay on the from list
>   			 *	Other errno: put on ret_folios list
> @@ -1635,7 +1633,7 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
>   				retry++;
>   				nr_retry_pages += nr_pages;
>   				break;
> -			case MIGRATEPAGE_SUCCESS:
> +			case 0:
>   				stats->nr_succeeded += nr_pages;
>   				break;
>   			default:
> @@ -1689,7 +1687,7 @@ static void migrate_folios_move(struct list_head *src_folios,
>   				reason, ret_folios);
>   		/*
>   		 * The rules are:
> -		 *	Success: folio will be freed
> +		 *	0: folio will be freed
>   		 *	-EAGAIN: stay on the unmap_folios list
>   		 *	Other errno: put on ret_folios list
>   		 */
> @@ -1699,7 +1697,7 @@ static void migrate_folios_move(struct list_head *src_folios,
>   			*thp_retry += is_thp;
>   			*nr_retry_pages += nr_pages;
>   			break;
> -		case MIGRATEPAGE_SUCCESS:
> +		case 0:
>   			stats->nr_succeeded += nr_pages;
>   			stats->nr_thp_succeeded += is_thp;
>   			break;
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index e05e14d6eacdb..abd9f6850db65 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -778,7 +778,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>   		if (migrate && migrate->fault_page == page)
>   			extra_cnt = 1;
>   		r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
> -		if (r != MIGRATEPAGE_SUCCESS)
> +		if (r)
>   			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>   		else
>   			folio_migrate_flags(newfolio, folio);
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 2c5e56a653544..84eb91d47a226 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1746,7 +1746,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>   	 * instead.
>   	 */
>   	if (!zpdesc->zspage)
> -		return MIGRATEPAGE_SUCCESS;
> +		return 0;
>   
>   	/* The page is locked, so this pointer must remain valid */
>   	zspage = get_zspage(zpdesc);
> @@ -1813,7 +1813,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>   	reset_zpdesc(zpdesc);
>   	zpdesc_put(zpdesc);
>   
> -	return MIGRATEPAGE_SUCCESS;
> +	return 0;
>   }
>   
>   static void zs_page_putback(struct page *page)


