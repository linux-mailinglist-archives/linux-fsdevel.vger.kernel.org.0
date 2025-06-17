Return-Path: <linux-fsdevel+bounces-51950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73411ADDAAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CB23BADA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1FD285055;
	Tue, 17 Jun 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCR1wgGB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K4i+PmhC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D771E49F;
	Tue, 17 Jun 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181497; cv=fail; b=IXG+aiHIln3V9TyWQ7Fr+OaN2mZGglQYd0M+GAw7Xgyy/luC0UZs7K1BvT+0CZjGU/dvMHiPZymC7MTuxmXPUwQT7FE8dD1rqCSrwyqCE4S0ecIn72fDrer5cjy0eO+oECuKbE7HShevW1Lza18vnKhc44xp+53E0y1kAlk9al4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181497; c=relaxed/simple;
	bh=0ZWjbP55nFiG2KmEHe1yUeUzoMQc9joqxDvkiA+jQFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2WaiQt5aPZeKQ4yWViY5HVcW0h/PQyca5HuQRWiYwZ+/Q59p7uzUbwGe0K/GMVnjfk9QJ1fZXEk80SkScdRsFMITtSfrrFN31WpV43ehfNkBbUd6dKrkL0T60dYCf+NE1TM+0hVfKG4u752hjmRekpTzCsb8Wb9poY9T5Hrew8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCR1wgGB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K4i+PmhC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEXDuX012796;
	Tue, 17 Jun 2025 17:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qPP6uFL2A+mYq1+Yz4Qt3W1eVFxcxCssRsh2IDhOC+U=; b=
	NCR1wgGBdk7rvioWIPdOCe8RU2jb32JOeyH0g13utGdhkoHzPi3t86s6ytxY1BDB
	HcsQ14WxKI1ALm1UrcqWEuCDYe2eMloX07BOOWB/j4Qxbf6IWypFMPJKsr5qhXvS
	ea6gEYRhUVXQyY4VkMlMwP2PlVUgkbCOEoVTOpCdw87ZIb/P8dAaJk0kepGAUONU
	J0FKDK3DIauWk1U1rRhmFbNOFrR8BjYy5PRym49wsOI8ujlJNlENn5Ns3ditHhVO
	EOSe55vkFw0qW3w/T/sC3jVqMHEn2X0oldh01eXSM8ysoVC/hh1pqlUh2bvsRlmH
	nuAOEvgWVYo7vr58GKwoFw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47b23xscjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 17:31:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HG7rXX031624;
	Tue, 17 Jun 2025 17:31:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh99yct-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 17:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRjpxeIcQR8RtNb6WDSCVdXq4KTvN/41HLy6aZPa13vCwJJpNldg5XZ+iw6fFGp9pyWxkAs7RYeUdUEFRiWnby4fPkAgporg6HNUjMBJlvjbNtcxUe6hgQXE/a8yGQyM9eq9JTvr6jPpxVjNf88YRvK3kbw0UXbenkT0hwNBMVpr56Fya3Bw52TReGKXAw8RF1+Gg7ZGxHQZQ7ezTXy8p0gl13hg8qH/6n3P1woLWbXJCEq7Pa8ZDiZ/iRgQn5OqQ3VK9A5VQ7SMtX97+/ayaR3TpMSLGxxrYTLbWKHGHYTH66vQ28tBAHLYFBWLt4JSNfWJSE5/MbGVuJUwZ9phrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPP6uFL2A+mYq1+Yz4Qt3W1eVFxcxCssRsh2IDhOC+U=;
 b=G/WokhKKw6dpEcmzuGLGgRS9kzcOWjCBrd+BAqyI4Vf0/yCmENOCCRrYk6iA1TMSxGoEWoMyGHuU2Fvpmt8vi6lXbJa9OwIvqsKM83TthntKMOgZHIY91DpDcL/KtKKPZgGVttsPhfCtD5VcyuwcHmRf5acK7SlFJ+EaCFAhrhxfpEGs8h5OIPukmZJehRaHHvL23+LRk9ne9bOSJTy4BW4o5LCz2EAhmts8957siKmcZvKt5yLd1phDhXh0YaL9x9bZmycUEeXSZQYTuzc/Oo+bjLmhIgGLXqYByTH+8qcTEjuxE19abMIW4exkammn4EK2eIZ+2W5vna/eM2Czqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPP6uFL2A+mYq1+Yz4Qt3W1eVFxcxCssRsh2IDhOC+U=;
 b=K4i+PmhCt3MfC179dRIlaOQCQrrtTbvlfUD9vgBiWM/CMl49m8QNFFP7+oXi1jXd9j+gM5A1ysQL0Misbq7j4rPYjOMysOxhAbET5EuPSy/7z8j6oUiYM/6VAfTO60exflGmwAGboheIxRB+uFAr+sDM01TeDaDepoSUhIsXYgg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 17:31:26 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 17:31:25 +0000
Message-ID: <45f336e1-ff5a-4ac9-92f0-b458628fd73d@oracle.com>
Date: Tue, 17 Jun 2025 13:31:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        keith.mannthey@hammerspace.com
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
 <aEr5ozy-UnHT90R9@kernel.org>
 <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>
 <aFBB_txzX19E-96H@kernel.org> <aFGkV1ILAlmtpGVJ@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aFGkV1ILAlmtpGVJ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:4e::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: b215ecf9-5cc1-4eb0-32e7-08ddadc4c8f7
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WWhDM2g3byttc1dIbFcwVTF0MER2SE5zcmxLN3BjSnFHTEtrckxCZkk3RVQr?=
 =?utf-8?B?WjlUTHNGZDQwbUR5SDNpVHZWUlpieU4vSW5FVThxOVZ4UjN3R0k0YmVnb1Zt?=
 =?utf-8?B?MVBVZ0gwSHdJcThpY0xLYzVEK2twWldlc2dxc0FaQWh2ME05TnlLTHpjTTBr?=
 =?utf-8?B?aXYxa0dlTldSelMvK2REMmk5SWplaHp5anJqVmh5dU9uWWN1SFljRVhTTGVF?=
 =?utf-8?B?QVU1OHZDMVBSNWprbHVrZXpKeUtyYlZXNHRtWFRMT1JPUzZIZ1dIaDVWQTZV?=
 =?utf-8?B?L1l6dTcxYjNLZXJlR0tEc2tKdHJ2ZFF4dlRhQjloWmZYbkdVcmZDSm9oeVBC?=
 =?utf-8?B?cG90elNQVkdLQ2QzQmhNYlNsaTM5T1gwbTZFYWU1YXBnUnZrUVAxVFR5dlN4?=
 =?utf-8?B?Vjk5QlJmM2Q1c3ZCRXBqQy8zZVF2aEJZUm9mZWV4Q2R6dFZ2YW9mWDFwWkNP?=
 =?utf-8?B?SEV4bTM4ODEyS2NXQ0NFa1NQd3JKTUJvd0dKbXNqNW5FaE94VlpMOENIV1p4?=
 =?utf-8?B?YlJQNWxYSmFiNHdiZEs2RGVoVnhqSk9hNWVRWEluS0R3SjA4TkNuajdqNHh4?=
 =?utf-8?B?OWlqL2lmb0YvV1ZQNHBHei9nZ25mcEd6ckNubGJTY0xWUGEyZmovQ2FpV1hY?=
 =?utf-8?B?aTdQZG82K3NVNUpMd3o4NUFlM3RnZ0EvWm5NQ3g2ZnJkMXg3S2RieDBCRmdn?=
 =?utf-8?B?SWdzVUFIYnV5Z3QxNWJ6V3BhclhQaTVKQ3lBbXdVZjhOL1lJdXVHT2xsY1JV?=
 =?utf-8?B?Y3lnd1A2STBTZjFNei9JaXBBWEx4SFhQRXoxTUx5UTM0OGRCeDRhYmVuek90?=
 =?utf-8?B?a1dYNzIrYWtzdHhReVg2cVdyN2lzWTVUSFhaZUdIUkRqOVJ5Vll4NzI1Sm5m?=
 =?utf-8?B?M1BsaTB4QXY3L3VteDRacTg0bCtIQWlUaFd6VjNpS2QzVzMvVXVHVFQ1RUNO?=
 =?utf-8?B?QWVKeXFDYUg2MEJrWVg2ak9hdTE4YTFjcTVaa3k1b1luMnlOZ1h5OFVjNU9p?=
 =?utf-8?B?Qm9QV2xHeXNXSWs1VC9DNEhQbjBsMUdDQ05Ic090M2tFM0IwMStrUkthVFgy?=
 =?utf-8?B?OXVvaDN3MVFjYjhmN1BrU09mems0UHAvWG0rZkV2cXNkRElpVm9Jd0dUVmUz?=
 =?utf-8?B?ZVlnTm5USEdIUnUxZ3RtNzdzU010MGxqU2Y3K0tHaEdNVmVSNHpyNFZCMlVr?=
 =?utf-8?B?SVc0TTJXOThkbmk0c2JBWVpLVTh4dFFXVzluVG41RlN2RnkwRGlsK1J3YTlC?=
 =?utf-8?B?aDVXK090Tmw2VDZtQzhHanlnSzNJS2IxUW92ODQ3Qi9QeHl6SzQyNXFWMjJm?=
 =?utf-8?B?M0xNS3c1Ym9SVVhaa0FCb1lSY1BoR0NJSDM2SFVJck80ZVZzL1ZTL0ZUSktP?=
 =?utf-8?B?NFI1SXlUby9FMThobVdrUDVUZVAvK0E2WWEwclpacUJrKytRdzRZd0JMRmw0?=
 =?utf-8?B?aExKdTRONEMrekFEeXBGYksvVzJlNDhhWTFDLzd2QUpvZ1lJNWo3cVJUaDJn?=
 =?utf-8?B?TE9IeUp1bGJ6ZHN3UGNDV0lvdzZvOFJ6VFFXYUtMSXdSckwxc0JXdlZKaWZY?=
 =?utf-8?B?REdIOGZEYXlLRFFCNHJLZENxcUNYdFI3cTF2TFd3YUpkd1FyQkk2NjJRN2lP?=
 =?utf-8?B?eS9iL1U2ZnV1NHNOSzNjYmJWZTNNbURHdGtrVEhNWUNSaU5oZkJPMHlidkJk?=
 =?utf-8?B?Q0c5RmhWdDZCSTRvdUwwb1hocUV3amtYZFJMWXVTWkhWRWxuVWt3aVgzWEVL?=
 =?utf-8?B?dVJUaFU2M3VVayt1emJmYmwyUnd6S1ZrM2JvWVh1L0pSZnk1a1VSVWNGbkh3?=
 =?utf-8?Q?0ZEbMjGCV5Bfi0vsxHBFi4/nfKdzk1cV6SCuU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VFR6TzA2S2ZQM05GRHp6ODJydjI3ZnF1S01qUFF5K21aSUNkR0VlTDgzSCti?=
 =?utf-8?B?OVdOOGFzYnZpR2F5enBTRThNeDU2YUYxd1JZNkN6RkpFNEdoZXR4YzE2bEZs?=
 =?utf-8?B?d2JNUFNpRE4xa2UrR2lWdWEwMnVYcTZtTElQM2lUOWVvWmRVY2VaSHgvd1pU?=
 =?utf-8?B?Zjh3eUZTVGVQTTBUZ014VEtwZ0IxdGdrZjZ2TDhyTElrd3dadDhRTjBoVU5r?=
 =?utf-8?B?aVQzUzZBSGRDNGNOUWlneXRqSlFHc1RNNzZiZkxRemZYVzBWbjZwbEp4YUF4?=
 =?utf-8?B?dUt3MW1sRnAyU0dqdGlXZnRCSkxERk1OZmo0b0dkMFZXVTJzYlhhV3ZrNlVD?=
 =?utf-8?B?eDBtTGU3TkRRSFZEOHJTc0FYc1loMzkyVnNaKzEyeVFNcGtZelBvOEo2eWJh?=
 =?utf-8?B?VjJ5MVg3dzBFbnV4TW9nbmtpWnU2WVJuMlZ1ZE9rS1lDR1ZZR0NiSUlNdW1o?=
 =?utf-8?B?Vjc3WmVaQ0FvV3RaclpTdzA4TDZvTTllb0RMU0FwK3poTVV3ZE52Mk1CWG1t?=
 =?utf-8?B?WU1QTjNBUDJRZDBZZUJ6QURDanFrY0VINkNQUEh2YkkwN21ydlNzWURNcWd4?=
 =?utf-8?B?dXBuWUpyUTI4L1hac2tDZ2pmSVdpRVZaNmc2RWIvU3NYMVZzdnc5MTVncFdP?=
 =?utf-8?B?My92UXhuSzNKVE0rV0FOTFdPNk9qejJDdEh5NWZxeEExMlNzdE5sM2tvU1o3?=
 =?utf-8?B?a0lOUURYQzB2b2kyUHNVV2p5TUZqK2ZQRUtSalhRaEYyM1puVDZlVW1tejVr?=
 =?utf-8?B?NUU4T1NXTXcwcE5MS2pRelNKazQxR3RldzZtUEdDN1Vzai95MHRXVXNwcmhw?=
 =?utf-8?B?d1VUSkFDT2xERTIyRzRTenBsdjlvMjZEc0p3VllJTGFUb0l4ZlR4T3RJR2dK?=
 =?utf-8?B?Z3JKYVZVUTJKdVBUaFN6YWdHcFRTaEFWUDFxdWJrbm9oWnpHdUk2amFJd21Y?=
 =?utf-8?B?eUdsSHhxMnJXOHZWbjh0bG1lcjZmZ0dhZ3ZZQW94ekh3cUlBNEJQYTJhRjJV?=
 =?utf-8?B?ZHR1b3Z3NUEvNkQzNHg0L05NZk1qa1ZXaGFhcXZocXlFYTl4NUp3c2lGQVda?=
 =?utf-8?B?eS9lWndNNzJyMnVJdzRTbnFkU0NKQzl6ZUNvaXlYdkROWGpTbjhjcXNRTi9x?=
 =?utf-8?B?YUdoc014WGhWT252STJwK2R4MlFxcE1kKytLUWhZZmpNQUczSW5LbUFBVGxs?=
 =?utf-8?B?eTlYZXJtMWxNblhyUllXTTJuYVRoSU55OCtTOGNoUEYxa3RRUG9ybzN0SVVz?=
 =?utf-8?B?dFFvck9kRmcxTk13KzJWYm0vNkZOVDc4ckFSWTlhS2VUdWQwSnlXZm5zWUQr?=
 =?utf-8?B?NUFScmpESkFrMGxjbnQrak5UR094S2pGU2NzZzJKcXVuYzBHeUZOdzBVaGJq?=
 =?utf-8?B?MWZUQVNwaVFUOVJuU1B3QVZrVGdCMUx6ZlpHeFVlVHFGaWZrNldIMW9OaDhl?=
 =?utf-8?B?QkRWcUFsOWJRbnN3YmNOYi9wL3Yva2hXWFNza1llWVZ3VVlQK0J3cG10WDg5?=
 =?utf-8?B?QXpkTEQ2b2IwKzNlMEV6OG50ZC9mbGZDSkJNMGY5b3VlYXloTzlVK2xpRjQv?=
 =?utf-8?B?TlIrdEoxK0dyVEF2Zko1ZTZFRzUvbU1DTjduUkpXMnRFUndTT0RFOU9mbFQx?=
 =?utf-8?B?eDVVUjJEeGhUd1ZpaWN6NDlYSTBuRVo4QTRYK1ZTeStHZXB5Z29hc0JBRnh2?=
 =?utf-8?B?WTFNaWMvRUFkM20rQVh6YnNmVUFNTHB6Y05oVVNRMHkyTk9HU1Y0UXpRYWNT?=
 =?utf-8?B?WUU4aURRS3lwY3U2SlBKL0MvYUk2WWtUWkhtY3VvVnArcFZYQWlKOWp4dDFk?=
 =?utf-8?B?MVl6bzVDUEhhb094V29EbS9nOGNMeDd2TlUwVGZIbkhrcExRUFhGdGdOMi9l?=
 =?utf-8?B?ZncyUk5UU0NEcmQzL1BXQzZZekRPaFBJTHc1L2k5bkg3c1dGbWhQeElXSFZK?=
 =?utf-8?B?Ky9ya3lLUCt2Y3dFSlQxWnNjbm5vZmZiZlpnalhYSDU3MVRDZThjTGZZYlpT?=
 =?utf-8?B?UmFhck1qc2d5dlZlNnVZWWRiWEtXQXlodFJaMDBhS2RQVHdZQ1FQWWc3cGhZ?=
 =?utf-8?B?Slg4eEhHZVA3VmZzNVgvSkU1UGlrcnlraExvNFZCK1NPS0lUekNiRUc4RTJX?=
 =?utf-8?Q?4wtYBvZ0YH9d/Bzj7+Kivooke?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TWgA+49ejlKsQJ6RfHxeIwUOAcxz1RzaQV74pf5rSjg0+ZkO7M55XhVctgnYzpw8Mi5ZVouSozGvPiL48Tmjtrz0dff+JBwkdVbPuBXxsqZ7lnuBmoCga/0/sPZ3vivK58xvRNU1uRoH/dLf1s6IvLx5RoiX4nKAypenHCYVddAiXwKBje5XMiVSWQcmPHIufmCQ6aBBWbFsPC5ZzqjxSHwyE6ayCemi0uwPM3S7tdVklzrpIs2m0GUG2ldLNs/05kCSn9nBTal6XHHrTbUx9axWo8sknRhDwIG8Jr4q7fhz8TVlHO0gPdAKQKVgbWUVMhdoobN+RSdHmUgnsJhY9dX6J6l1v9mxDGbGFXDttSVgUYcD2gtbhMH+texz4wPZtIEBFTtbVAGlS294hfCL7WLjqQgEBgoHkzNtv3pTe9VwTO8okoCdti9hPtsC66FdBwNCOGC77a5XauFi8clNiCYpf+f+Jub4uPW5+oaHReJxlAQzaozmbHbdq9+33/WZXSq5t7RnAKmJCV7pQ9W/wTXchimUbQFz46pe4qZuZxz+QImdBNHfFK97CT42Hadl7kwpl7r85inXVRuV/dSS7Klx3LlEWsqKtBxA73I+0kw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b215ecf9-5cc1-4eb0-32e7-08ddadc4c8f7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:31:25.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMnbI9Ilk9D38rOlKhKhWD6Xz8i5lJUORxtWdKu+xgDirVaMdwUnXgcciRtoc63qd9gtNbE6jVVPCloxk+m4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=885 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEzOCBTYWx0ZWRfX6ewr2CLs30bb aKcWQyEHZDMqHf1mnF2crEvG9syNosx1C2JJtQAXg6pBW+YdZMQyqcacvOMqAM9AZNzbf7g2jjf irl7bqnEhE8QD2gXNNB0is2+5LRs33nFlFdg0S5Uum6RHomKtw0ba8H8+RMDbxb+wWQbzDxWNVM
 cL8Ho4Fr04WWIKfid+yzo487V+g0CNtF8T7nDw/meAtA6MEvPRzymRpNV1lshTP/YJ9IznSy/94 ghavn4CzWn9mGZJMMqPqGXb4/4ED4teC+LYkbgZcsDGIXuh3uFp521noOwMH24hSLsEB4jNTZoS xOkUPSzr+dCDeyOGY789qBduqC6P56RUXnFSp3ZO3uL4k2SkLHBWEJbtpKlofMph9L/PnV2z3m9
 LJlAufk924qhN2IZlzw9kmH4iE6HbjygHYa9Kxxvy5EZAVyImI92UQX3HZwadruewm/ynyMK
X-Authority-Analysis: v=2.4 cv=DM2P4zNb c=1 sm=1 tr=0 ts=6851a671 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TRtTYcYt5kwXhoch:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=WLGaNtMBAAAA:8 a=91jTk33z7gcE0fhI2WoA:9 a=QEXdDO2ut3YA:10 a=gcKz3hfdHlw52KqWNJGX:22
X-Proofpoint-GUID: QG0AUgbak5gjhayVV8dZnB6T6slu34Ss
X-Proofpoint-ORIG-GUID: QG0AUgbak5gjhayVV8dZnB6T6slu34Ss

On 6/17/25 1:22 PM, Mike Snitzer wrote:
> On Mon, Jun 16, 2025 at 12:10:38PM -0400, Mike Snitzer wrote:
>> On Mon, Jun 16, 2025 at 09:32:16AM -0400, Chuck Lever wrote:
>>> On 6/12/25 12:00 PM, Mike Snitzer wrote:
>>>> On Thu, Jun 12, 2025 at 09:21:35AM -0400, Chuck Lever wrote:
>>>>> On 6/11/25 3:18 PM, Mike Snitzer wrote:
>>>>>> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
>>>>>>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
>>>>>>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
>>>>>>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
>>>>>>>> or will be removed from the page cache upon completion (DONTCACHE).
>>>>>>>
>>>>>>> I thought we were going to do two switches: One for reads and one for
>>>>>>> writes? I could be misremembering.
>>>>>>
>>>>>> We did discuss the possibility of doing that.  Still can-do if that's
>>>>>> what you'd prefer.
>>>>>
>>>>> For our experimental interface, I think having read and write enablement
>>>>> as separate settings is wise, so please do that.
>>>>>
>>>>> One quibble, though: The name "enable_dontcache" might be directly
>>>>> meaningful to you, but I think others might find "enable_dont" to be
>>>>> oxymoronic. And, it ties the setting to a specific kernel technology:
>>>>> RWF_DONTCACHE.
>>>>>
>>>>> So: Can we call these settings "io_cache_read" and "io_cache_write" ?
>>>>>
>>>>> They could each carry multiple settings:
>>>>>
>>>>> 0: Use page cache
>>>>> 1: Use RWF_DONTCACHE
>>>>> 2: Use O_DIRECT
>>>>>
>>>>> You can choose to implement any or all of the above three mechanisms.
>>>>
>>>> I like it, will do for v2. But will have O_DIRECT=1 and RWF_DONTCACHE=2.
>>>
>>> For io_cache_read, either settings 1 and 2 need to set
>>> disable_splice_read, or the io_cache_read setting has to be considered
>>> by nfsd_read_splice_ok() when deciding to use nfsd_iter_read() or
>>> splice read.
>>
>> Yes, I understand.
>>  
>>> However, it would be slightly nicer if we could decide whether splice
>>> read can be removed /before/ this series is merged. Can you get NFSD
>>> tested with IOR with disable_splice_read both enabled and disabled (no
>>> direct I/O)? Then we can compare the results to ensure that there is no
>>> negative performance impact for removing the splice read code.
>>
>> I can ask if we have a small window of opportunity to get this tested,
>> will let you know if so.
>>
> 
> I was able to enlist the help of Keith (cc'd) to get some runs in to
> compare splice_read vs vectored read.  A picture is worth 1000 words:
> https://original.art/NFSD_splice_vs_buffered_read_IOR_EASY.jpg
> 
> Left side is with splice_read running IOR_EASY with 48, 64, 96 PPN
> (Processes Per Node on each client) respectively.  Then the same
> IOR_EASY workload progression for buffered IO on the right side.
> 
> 6x servers with 1TB memory and 48 cpus, each configured with 32 NFSD
> threads, with CPU pinning and 4M Read Ahead. 6x clients running IOR_EASY. 
> 
> This was Keith's take on splice_read's benefits:
> - Is overall faster than buffered at any PPN.
> - Is able to scale higher with PPN (whereas buffered is flat).
> - Safe to say splice_read allows NFSD to do more IO then standard
>   buffered.

I thank you and Keith for the data!


> (These results came _after_ I did the patch to remove all the
> splice_read related code from NFSD and SUNRPC.. while cathartic, alas
> it seems it isn't meant to be at this point.  I'll let you do the
> honors in the future if/when you deem splice_read worthy of removal.)

If we were to make all NFS READ operations use O_DIRECT, then of course
NFSD's splice read should be removed at that point.


-- 
Chuck Lever

