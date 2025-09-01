Return-Path: <linux-fsdevel+bounces-59768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D8B3DFB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E023ABCBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED14312802;
	Mon,  1 Sep 2025 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gzWd7VCD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FECee1pB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658630AD00;
	Mon,  1 Sep 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721131; cv=fail; b=NvnmxPpaHJ1L+OQDxCoYqy1Jo8tPzU9/YzKiRUQn9uytDljkysyGP6iv30iENnIEJQNCjBtfdDnDssPrx5bkg90lo87KVTuW/FCFKKwOfsrBUPmY4ZGA+luOJagXkrPkoTMM3N4WQVsAsrD2CbjxrfZrHPQIwTJ1hl24zukBxQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721131; c=relaxed/simple;
	bh=tlNIbxT1sneZSDBQT3Xvag7za+ClEFpt2ouSZYBSjHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m52QhZqAir/oh3qQFP9sOY5xdRXznoa72D+d2Ix/YL6GRUcdG8kb8+SEqzjF0/NNZHBUasJ78kbGCJj1ZfTj50rFfSSJnwzrXRAkGmt7no0bN9NI3kWZ+Qk09Sq7eq6jpMyf0VOOI/RWrztsDJ/JAyPPz3ZfzilGUP2UH4aYwZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gzWd7VCD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FECee1pB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fnUn018250;
	Mon, 1 Sep 2025 10:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tlNIbxT1sneZSDBQT3Xvag7za+ClEFpt2ouSZYBSjHM=; b=
	gzWd7VCDaXDVL7xdGIVBG/aZrT08yxIRYZ3+jx3dIDk4dDLouFX8XbRpfoiZe5LW
	5Mx2t7sQMfoUAkFJZwtCnCflwr6jxmK+p7ifwzKVxfd78YRRO5+usgv9wejupXbq
	86DqKgn8DzyBqhxhF3OeSO2rvFLcT88becTTHXtRar8C6d6G0Q9YCNpM3tXJK5U7
	VzJcWVYfRYycpiVQ0MDYq+9uJ9nvzeQav0N0WUFaXfaJx11sD2eglt+GmtL74hEV
	2OJNsMRbJ5demcOOe6NtAe85GdFZ0bc8wGY4Uure7K6CbcP0s/mnqnqpEuMzadkj
	yxHTY75HjrPFWdrzwIPlcg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9j704-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 10:04:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5819YAKD011680;
	Mon, 1 Sep 2025 10:04:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqre0fsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 10:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n31H/14daK5HowdJHZm7UzPNLVAhlqcZcCryznol6/X9W06yI+F+30RDj+bSqBDOkGwcbgRiaYw2KfAeSJYbmErl18OGMMREWklR5WwiybJnTWe9WT1L2X7gzpyMaOOuSc1P1bXZzOoGFobFNyodWEvIG+LGX1YP9jC3RwByFSxNb2ILo6kiazkHxZQcOJmVCw9p4DxUs2oMLdhZA5aIzsSSDmrdTIR1lq6bxArzqXGC0KQcaYILGtxfiShDagXJG+BPCe0UIR5MHhyjAnUOr9/rcP53sKAHG21flXDRHu/0hBb7fve749C9AsXuGnlbmIxs4fuRK/ZqTbcVTzye7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlNIbxT1sneZSDBQT3Xvag7za+ClEFpt2ouSZYBSjHM=;
 b=R3vu2HIl8bJ2i2l1yGdbPrs7TF+5LTy5PRd+i+zRdid294Jq8BNjTfc6MtDpHXdXws0i6+RduRptxGEddKI5vIsoRra1qFlyQ/wkER3Uwyjl/REfXhTopfCeQbrXPycYezLYzPzDeXdTYM5gEHHTt6tX+tTP+lXoAL+ek0NWGHTwRir+191fOs6HVVRsDHg0vAz4nxI5O+QS/RHkt99SMgWOGK+fk4jJwr1ivtbPwC5qHieG3fvqdsmUp3m1mdK1denHD7mgTlQpD1eppxSld9oBfFj/LwLvnSZf6vsPOEtsgF04fnWbrTskcTLSAzSon2M9QntVJDXDnFnPfcN8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlNIbxT1sneZSDBQT3Xvag7za+ClEFpt2ouSZYBSjHM=;
 b=FECee1pBbfxvgEbi+Hl8yZEHcRA48GjueGM72xXr63wpnZaCJM6YcE8P8r6lgaabwqCL/O2IBX3DFVTdHP3wGz7h/lNnV3KosUsuhcY2yPNW3EFXL/WBJwUJM/0XaBHZp+/Z6WkHB1wOu2A7oaM6dTJXyyIfdPYuhU4D5CxaxYQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB7771.namprd10.prod.outlook.com (2603:10b6:408:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 10:04:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:04:26 +0000
Date: Mon, 1 Sep 2025 11:04:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        conduct@kernel.org
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
 <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
 <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0115.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 22442ed6-5566-4b09-b1b4-08dde93eeeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWdqNjlqOHM3bGZJeHdENi9PLzliMzhTWlRTa3M4N2cvckZTWGo5QkJnd0hX?=
 =?utf-8?B?alIvRUdBZEFxMVBZVkd3Q1Z0QjIzWW9aT2Q2NVpsNG9oVlZGZTVEMUVIaFZS?=
 =?utf-8?B?NXNkYk8vMWxVNTVNMVNXa0pCWjgyWW40S0ZrUDlDMERXck9lN3JWaXFFeXEz?=
 =?utf-8?B?TU9GVkRMVlpLYTlSWHFJU1RoRy8vcWtaQXlyazg4aVN2ZzR0YmVsVFVwdk1C?=
 =?utf-8?B?Nm5SM3ZYUDZnVTI3YXBLcVhuMkh1eFJkcVRYUXJ1VUxEMzhTNDZpckdVVXBy?=
 =?utf-8?B?aTgvTFpNWm44dk05djA0THQ5WkRWQVgxTHRHOTJ5Qk1mYWxaTTFnS3kra0dZ?=
 =?utf-8?B?RVJYb2VRektqRjE2SEx4QmpjMHRUS09zQmk5UkFpamo0WFp0MDh4SmM0MWR3?=
 =?utf-8?B?Tzcyc056aWZmZmIrZ3JMUVQ4V2hQTW9IRXNOQVdrNGordXJWWDk5VUgvSEpK?=
 =?utf-8?B?Z2hxSmNic29nTDJjNjlzVkw3QXBDb2RuZ2EyY1p2ejdNSStrR1BzVWYxVnRU?=
 =?utf-8?B?aXZqYlpXQjllV3J6Q3JNV2owby9IWmdYRVgrRU9KWDVFZXM5aHBpM09wT204?=
 =?utf-8?B?UThQRzhObGhQT0FNMVFBQzQ1aStEUkg4WVlMN3ozQnJVZDJUOTdCaUNXcGM0?=
 =?utf-8?B?alRHZzZkMVlTTmljRTFnK2ZLY1MwRXl6V3NMQUx0bnhyUmthVUd2bGhkMFV1?=
 =?utf-8?B?b1hHbkViKzNZcGo0MnJXQVJIU1Z3SUNzWnFldFU0UHRyOFRZeUU1ellITGN6?=
 =?utf-8?B?elZKVzdGazlwdi9pakpOZ2xHSkM1RlFyL04xVDZacnRVYVpiZTlKaEFhRnpr?=
 =?utf-8?B?M3MzZWtZR0dLL0k1OWpialdrNWd4cGxCbXdiVGRjUHpvRnhHR3FVVUExdGhm?=
 =?utf-8?B?Zk9XWGR5K29oWlR3L0c4MURiSzlGV0gyVHNsakpuRzdaTUV5R2dzUmVLZDNn?=
 =?utf-8?B?LzFEZE1UR3FxeUFndlo3T2x6ckp5NEh3azNTTktDNlY3V29LSXdpbFJrUWRX?=
 =?utf-8?B?Ykl0ZlNFd1M0ejc1aldTek5zZ3dmTjBMK2IyblVBSjBUYWVWNHJHQTJXNU5E?=
 =?utf-8?B?ZmNVRFJjZWhJemhwcXlNVFVHSFRKbkZxVkljUFdFYXRTRWw0Sy8zT0p5aVFh?=
 =?utf-8?B?WmVwcURuRE92UXJMZERqcVA1TWFTTUdjcTRvTDFPbTQ1ZmdSN2lGN1l5Sndo?=
 =?utf-8?B?MkRTYkR0ZlV4QlZuK2VEMCtxV0VVYWpZUmY0SUNPd1BCSmVZT2lIUng2cnp6?=
 =?utf-8?B?Q0pPd1FNMDJTcElvSHgxUXo3dVhXU1J1SnFaYmk0a29OZ1d3bmV1dm1nZlVZ?=
 =?utf-8?B?ajFJWmwwbTdmanlBbnVSRHNhZnFoV0pTQ0g5c3hWQytMSWhHTGZ4WWkvbTJU?=
 =?utf-8?B?U0FnMytrSXNJZ2lBSFlRcCsrdURrS3pWWTNEVnN5TXgxMzR5ME83ZDlZK2xQ?=
 =?utf-8?B?OVFMdzhteGFiLzBCb2FyOUV6a003aFZFTExpTzhaQ2JScTBDekdJQzNwTW0z?=
 =?utf-8?B?SUdCNkthMStOQ1ptUE5KbHRvekl6andRMktwaERBcWdvcGQwM296cmVPb2tx?=
 =?utf-8?B?b1dXdTUzUmN5MlVIL1VjcEJQZHBPQyszWDFNZU1xUUJEWDBhaGduQjlFaWJB?=
 =?utf-8?B?VjlEMlNabDlxYWIwNC9sK1VDd1RhdSs2VmYxbFpZbWpaYTNFQ0RyclZjM3U2?=
 =?utf-8?B?MGVrV0tYY24zd2JNSUJhdm1uVWl1ZStpRTdrVnZuWi9ibDNVNmdwd3ZUK0ZW?=
 =?utf-8?B?R1llT3VsdkZKekhLdmNpcFJ5WC9DSVN5TElpSTVXajVuUW9SSHpuVE1xdVh6?=
 =?utf-8?B?aWwxM0NDRlh0cEhoQjhBWnYzVzFGVnJ1aXo2TVJXQS9mSm1DTWxEWTlrd1Q2?=
 =?utf-8?B?Q1hrL3pYeVRIUWRsem1MaDNVZFpMYVpDYUtCTlo3d1ZqQ1c0dHdJMGwrVjd1?=
 =?utf-8?Q?dp981sBQnAQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUI4YzVpWFRPRW52MmdrZUd6aEQwRG5NcjJ5b0lvVXlGcWEzanhndnduWFdB?=
 =?utf-8?B?RTlScG9VaHI3RVhrVTQ5dzdIU2pveXhkMTFwRzBRcWhoUkdMbUVxSGw5L2NX?=
 =?utf-8?B?MEU4bXNCSHFYS0NVdmt6MXZ4OE80QTg1WXRLS3ExNkJRdmhhaFJLTjV6Q3Rs?=
 =?utf-8?B?S2RTUXZsNXhPeGlOTU0yT2xucVNURXcxQ2VzQ1dUK1BnNk94MVBBdTZnVGV1?=
 =?utf-8?B?aXA1M1BUdllNZFRUd3UvVUI4Yzh6ZEJVaS9XOXBDWWJydUwwNWt3cWM4SzFZ?=
 =?utf-8?B?RDdhTGFQU0xuOG5vYWZwR3RTZjJvclVodjlUZU0wSk5oVm5zL2VpL0hCYzRt?=
 =?utf-8?B?Zk9MOVJOZUlTWkh4Q2ZoaEFrQUZ3dFg1Z2ZqOEF0YTlPR3hSQnFWL3FCN09u?=
 =?utf-8?B?MlZWNmZsYWJ6Y3REc2pNeVVPVExRK0syaXR0VXBUSGFWMm95ak9NelIySHpI?=
 =?utf-8?B?cFVhbC9PdllWQnVyT01wYzZHUW53MEVqMU5TVThmNkNoS2U0SGRRdFJwY0tR?=
 =?utf-8?B?UFRBckxockI5cytQeHZJOGZCVkF3Z1RxcWRZY2J4NE4zVG5jL1JySnVHajlq?=
 =?utf-8?B?L3RGYnNSN0RMT2I0YUUzL0JMckUyamdoMGE3MGZPUzYxMGZ5L3ZGVWErb09R?=
 =?utf-8?B?UUlyWVR5N0R1dUZWam1TcjB4N1I2aGQ2M2pQR01ialp4YXFmcG92cHM5T2I3?=
 =?utf-8?B?dmFBQ2VYMXNNYWhaVDYzUlJmVmJrRCtzNXNlZEhnTTFSTS9HVzUvSG5aSnZu?=
 =?utf-8?B?RWk4ak5NVnYxY2JNNHAwMGN0TTVuNkxaTklGMVRnOUUyeGpGWHFuSzJWOTdp?=
 =?utf-8?B?K2d3K3JOUXdFU0VuRFFNRENRekdNWUpDZC9kcXdHOUVISmVBamJxbVhJZlFh?=
 =?utf-8?B?Y25Pbk01WE1rWFdENUFoVnRGcjRQQWlHeEc0bHc4S2lOdEZEend4ZDY4UkVp?=
 =?utf-8?B?Z0NKZnExUEQxTUd2eFRxVU90dFVZSHFacGM5WVpHak5SSEs1aXJlaHdZcXA2?=
 =?utf-8?B?N0RGSGU5VWpGSkxBOW56VGxoNzQxenlVVmRXVXVpN0NndS9XbWplRURybmxM?=
 =?utf-8?B?cjg0WWFoTGlXUmVMeTZENFdSWHY1OHdsUmc3aVVUb3pQa1FVSGZFakY1ajhD?=
 =?utf-8?B?dEM3U1BsU3pIWUhzam5BT1dRVkFaVW1jK0prRFBMK21BUERSTml5VGZJUC85?=
 =?utf-8?B?K0l3emo4dndJcHlJS1VBRDdtRHVIVFlzVndGMm1STW1VRENPTlNVMnhDS2lm?=
 =?utf-8?B?NmRnWWFRT2pmcDhhSWZxelArc013eUZaTG9UaW12bHJ3V0pLb1VMSG5hdmo1?=
 =?utf-8?B?T1hMTEljYUpmN1JHWDFFN0Q1U0pJblZDV1FtdTY4cjl1bGJncE9wbjVNRklu?=
 =?utf-8?B?TmFYaXUxcU1xVjlCNU8rY1o1N1JEMWh6OWEwcEpEWVBnUElTM2NrQ3lGMVc5?=
 =?utf-8?B?Q3lzaHJsN2lIazBJVkRHYTMzSzdpQm96ODF6NHpIZXhkNXJ4TmNsWDgwSnZV?=
 =?utf-8?B?VElEQVZUZzFXRUlVLzU5bWwzNk4zdlF4Q1VpSkd0aWpYS2dzTzV4QlpBdVlh?=
 =?utf-8?B?eGxwcnU4UXBIUkdUR25uOFBnbnVnKzdJQ1dhZ1NkR2UvZmpidFd4Zm5yRW4w?=
 =?utf-8?B?SHB5c3U5K2NDQ3o0Ty85YmNwZ1l6V2lIQStNSjZaZ1RYYnpjQVMvTitsaC9Q?=
 =?utf-8?B?UjlpV1BOUklUcWZJeDhJc2lFOFIwOU1QUXpWUldKeVIvdXcwSHJuK0FzYnhZ?=
 =?utf-8?B?WEM3THU2QVdqWTI2SnV6VzROVTRCVitsOGpmK2xNUGJTM1NpV1RvMGUxekJY?=
 =?utf-8?B?eVNWdjNUZXdxV3VtV3p2S0VhM0FjbmV1TGE4ZDlvRWNCSTRoVk1tdFZ6MkU3?=
 =?utf-8?B?aWlFdzNDaURqK0FTTVNmMlNmS2lzekw3RVc3YmtaY2toSk8ySG5pQWViS1VE?=
 =?utf-8?B?NzZZdjI0RzBCdXlOSkZZNWJmQnJWa3pNd0pqVUV6RTBicnRYN2paU2FCdkl1?=
 =?utf-8?B?QStQaXdrKzQ1MkdOSW03bzlDNlZOYnZHaEhPazBCQWdocWt4MGRTTGVMczFU?=
 =?utf-8?B?MlJoTzFDSmJsRHRLWmdNNjhYSmNKSUg5Skw1RnZWRHFBVm9RanFLY0c5MWU3?=
 =?utf-8?B?dXV1dVRaMVVraWVmQjVFa0FJekNTeXhPR25IZi9IYlFqeTh4V29ISGdJcTdX?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FYjqzN7FtbOIVOyCx4r9lBpbx0UFKjkOTANituwIBKxT060679+0YqNj/ZDlVAfqRL7lGLNByvsmViPMxixYS1vp9M0pCI1uYZ7VZFZQIc8Jr154Aej5mPQ5do3+Vu9ZMIvyoip2T0p7YGNp/oVfOfDIG2cRe0OsVmcKwlKrJX4uc+ldXIZEicZ/7vRRAsFAyn+y+bpJ7fjyIma0vzW9ooqYC1azgfUUHKjoRgdoC6IhDFXaBHZi7ucN/eNXcw8s0EHaG5UQ6dGOB6cUne5UFnIXONds7UzLjXXZq2/RMFsuyl93t+XQ0PDt7lj3TnVuPMNWyexzmtQgX8pPV5JbXXuUPSvbkjaNXri+jjZlUMC3zzwNwH3CfMNy0g5ABwwpGldBWaN1y+nL2yk0n36KZ2w/9wMBugPbdNhN5YmbB5/ArjrWPhNsyj8F6ae3PPxNFIAfYRbUjBNraq2HgFNk1v4daXkGfXqMeYmK+H9sfwL64avyJVUuZdnKWk1F52NwAC1qHSJf8N5xfkftRPcfyea3HAon0BixYi7y6Zt0W6ju7dFfillH2/T2agw+LCSE0KHCsj3xc+9Zg5aJCsILBPqe4nDAulPYu1CN29SUwmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22442ed6-5566-4b09-b1b4-08dde93eeeb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:04:25.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/tN1js2nazNi67EBcLOnWp4wStd61TnFvuUpIOTlF+lo1+6GhTbKpAllzkGJen4UNOmyVNXfiGJkbocHMP/svEwfczx1zLKkFGd/jVFVPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010107
X-Proofpoint-GUID: -DkicTxQPf-R3mB6LI1lLawuTh_bLbn2
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b56fae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=I-JsdhG4wfVrGcyky-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXxPvqbg9jyq6V
 cVaBig1MAHOQAfUrYd0FkRY8x80Ebplsf1UKEI2fATNRg2xLGEAoxGJJ9QDRyPlPCcxVBC2M+/C
 jHoI1s0rak+9no0b0EjOBdsSmBA8wsMa6d4zw4D6ufHaeD/2tIXYMDMhvmrrq6/dB1TU4aLmq5q
 PpNh1eN3TSepPxFGqoRvSaUJrrZe21ggfzPlB6EDaYt8K4KS1R7GyTouySFgDqQdRLr1kmdtMx4
 i6mTxb3d1To4GnIw0JO1LTblp1NqMemaYA+jY97+KV4WpO7c1PPEpiOZwVZaH3V/H3JkT5+v/Di
 oUx0rSufbDn0Z+agXEi5GF1KX8ZMH3k5CWsvm+mhf6sUZEBCo/UPXyhMxl2NGCZRBNOGfZOZAwq
 /+xmgLuw2vMDReiKp7U2gpMSZ1hynQ==
X-Proofpoint-ORIG-GUID: -DkicTxQPf-R3mB6LI1lLawuTh_bLbn2

+cc CoC.

On Mon, Sep 01, 2025 at 11:54:18AM +0200, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 11:44 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > You are purposefully engaging in malicious compliance here, this isn't how
> > things work.
>
> This accusation of yours is NOT:
> - Using welcoming and inclusive language
> - Being respectful of differing viewpoints and experiences
> - Showing empathy towards other community members
>
> This is also not constructive criticism. It's just a personal attack.

It is absolutely none of these things, you admitted yourself you thought the
review was stupid and you used an LLM to adhere to it, clearly with bad faith
itnent.

You have had 3 or 4 VERY BUSY maintainers take time to review your series and
you have behaved appallingly in response since.

I and others have been ENORMOUSLY patient in view of your awful behaviour, which
you are continuing, and apparently escalating.

So at this stage I'm not really interested in seeing any further iterations of
this series from you for the parts of mm I maintain.

I suggest you find another part of the kernel to work upon.

>
> (I'm also still waiting for your reply to
> https://lore.kernel.org/lkml/CAKPOu+8esz_C=-m1+-Uip3ynbLm1geutJc7ip56mNJTOpm0BPA@mail.gmail.com/
> )

Your behaviour there was appalling and clearly a personal attack. It didn't
warrant a response. I was trying to be patient with you and to see if we could
move past that and have a viable series.

You are very clearly in bad faith and looking for a fight - this is not
professional and this is not the place for it.

I have now spent my morning dealing wtih this and I'm done thanks.

