Return-Path: <linux-fsdevel+bounces-64607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81962BEDAA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 21:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D389A34D866
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19BA285058;
	Sat, 18 Oct 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nm5GO9vR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l7R7e9UV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058923B0;
	Sat, 18 Oct 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816055; cv=fail; b=iohQtVsJ1omuHuh0gbSR/zN1CvobuavQOuuLW3nItsyabB8Qi0moX2IwoJfWsuYEtks0wgzaSDi0/9nOR7k7gl3vOEW1HBhnmNycp9n2QXB61NGMGLJ3XYPTLZPeuarlk26/AoF7sQ2D8K1D4jnqL0rD4ZudHFKjAlcNNyvIyBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816055; c=relaxed/simple;
	bh=XIGVJUVkGSBkf2L2oO4CDvnWCkqq02tnb1elY/+lMvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jLfgYvMz+tMYOS4GAg9vFtjSuNAqTCBD647BEZryA94GztENQqnn/Akf0YMum+kktom3qm1WrCf9boPIdUyz5nGYpwuq94/vJ9k7EGshz7T0cy5LO+svSCeO+fmzjwuWrhhGKTYhA77pHXk2d0ixqcAHr5t9XkDRL+C2ZrfnCoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nm5GO9vR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l7R7e9UV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IEt1A8027847;
	Sat, 18 Oct 2025 19:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0IXmlWOX6YjJeOmtn8xHA0kERr2zrEysoTsqSZjZ2z8=; b=
	Nm5GO9vRIV9j+w5XF+E4LLmlek7YIalZ3Dyy9wCrN8A1PjGr0EUA7rf51fiQm3GC
	I3WMwpjYU1vR8yG7yL9ULJAWyjighTgfaIAZusHtKFyBnHhpx+lXQZD/VwYVrF+L
	p27DCxTSrT7iWEzONknEWeq0oipVrfjt2C2Il8bMHB/ykP5TxnPxsiK63F3Ewxqa
	eCs2OZGpqqXYFp1wm/XPrlAYwTl/i6ku/k9NGkS+lI2nEWDloJHnmY7qgEN7CQ1L
	0M7nYftBoPEpd+K8ff0RjdRGxvXVIoDsREUu33hHttZD7GY7L3fSDGhzEiE11RSB
	LgG820/P2lpXA3n/WzSbDg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2yprfue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:33:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IIZVCu013669;
	Sat, 18 Oct 2025 19:33:12 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1b9fjse-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:33:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhBRE1TKfxZF9VdD3HhLWDcV/FXXbjZKFwMen6cnSLJsjHDitQFVK3E0WQYG2wZ2He4B2ttzKJdBeY85AHl/Aq8/vV7TGwbLbC7x1VmfNZ1q4RXtZR7RMr9AOaGNvkHT5OiYFcokoK8BvtC1myRTbf3XZdBbAHeiEp6cSN1piA3KzsgVXinvASESoVccr8EjdZMhA165Z7Qfk9N4UJE5so//4gXhfsRamLFcYWKmA2k4NEIr9sr1dk0XuVbcoJIZGj6O3TRkcHIKErqmC83a1hTFHH0KUFCq5lSx722WoEpzDa/zJA7nCCbBxhr0xZA9Ro7JfmTe3m8B27eGkIijkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IXmlWOX6YjJeOmtn8xHA0kERr2zrEysoTsqSZjZ2z8=;
 b=H++JeTpa2WGYy0hSIXU3k8j8y1coQxZ99XgF6JuddXD/EtVZKAWWMGf39VluYpFMVLm0bkDxK2WGSVjfUX6v69rW8Zi3TDD8vQrtTCLr3Jcob+f2Z73G82F/yazn1A7Bz5h11hu1A6bBNffB/EfOAo6mcbTmnjE8AAXhHXFu38RgcOZsCrfOGCr4Nl55N6Hf1LLDL/8zAkBxb1O/s1WOW3kMZt0IencjA8aYH+HSJ1bGYyFd7PS3RrtfBRanxTWpDPsQxvj5kLlaY+iq6AfmGgxzhXHsDELJ0YMRNqEUU0oGZiH2Rgmh5z2NurFrBKyLLAuIfzL+OAH+IRJcYhpFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IXmlWOX6YjJeOmtn8xHA0kERr2zrEysoTsqSZjZ2z8=;
 b=l7R7e9UV7b0bOvB7LqBrCsyMcEQF4Vr1YRVZZuN4gA+Rx5mTZ1d8BYt53bkhhbFdpYjtar6DifFfQN5q6+TxxltTDhcNgngyt7bB+b205mF8PK+vwDgdmJIUNbCRwETwvJv1GK1KNVs6+ZqVg6o/LGC/zzYMG3YezUGaLjAXNAU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 19:33:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 19:33:08 +0000
Message-ID: <21904951-0cac-4a79-9be6-7dbf2f9849b6@oracle.com>
Date: Sat, 18 Oct 2025 15:33:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] nfsd: allow filecache to hold S_IFDIR files
To: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust
 <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Carlos Maiolino <cem@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, netfs@lists.linux.dev,
        ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, netdev@vger.kernel.org
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
 <20251017-dir-deleg-ro-v2-9-8c8f6dd23c8b@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251017-dir-deleg-ro-v2-9-8c8f6dd23c8b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:33::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PR10MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 77d5d7c5-c79d-4e1e-26eb-08de0e7d2a9d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RW1BZXgrL3AvRVI1b0FlRi9FYWIrOWFqN3ErTjdXby80ODZXUEllK2xyU051?=
 =?utf-8?B?b24vVWN4algrRFB4TDFlSVFGNUE3UHV0c1dKbkpPWVJaTHU5VVJEbmw3Skpk?=
 =?utf-8?B?ZUFHWDM2ZVFOVnUrWkphUTF6TnUxVnFweEZFV2RhT2FDV0pWSzNUUXRvL013?=
 =?utf-8?B?bExvOW5vRGE1ZUx6dDJ2b3l1OVZNTXRYUkpvUytsQ0M1elIxVkJHdHhxMGh0?=
 =?utf-8?B?SDYzRHdNR2NPcXMwV3V1Ym9sYkVGMFMxdUdXcW9NS0RYVjczVVU3TkNhZlky?=
 =?utf-8?B?WGsxSXd0cHNpbmJJNndTWnlzSjFRN1RJRVNvcFEyM0FsbHNwQnpDcktyUjJ2?=
 =?utf-8?B?d24yYlRpSDNFTXo2Wld5NEVzUEtIR3RTSkhBZ3FZOTU5YkwwUUJDZmpSTCtS?=
 =?utf-8?B?NkFRUlhlVE16L3N3Q0h5UmZFdjcwZTdhbFJ5T0t0RXFLcExVSUlOdVc0aktN?=
 =?utf-8?B?MU5WTVQ1bTh6cmU1dlJLUVlXU2xLZ2JwOXR6dE9uODRWcmRQU0pyenQzRWRC?=
 =?utf-8?B?QTRQYy9yQWdkSm9PK2s4TmNWdFo0OE1aNkFZd2RYNXNhYmZ6VkpPQU5FczdC?=
 =?utf-8?B?dUY1c3FHYzdodUJVZVp4cFJxODZGTVVRQXJNOCtTakdlSCs1dVZtZHIvMzNW?=
 =?utf-8?B?R0YwdlRiWDVCOVByUGs5dkl4WUx3ZlZtbEk3Y2U3UWVoU0tDRmpySUR2U3Z2?=
 =?utf-8?B?aC9TUTltckRlbnhlU21ibHFCdlhqL1Ywb3NGWGhicWNIVXdnWDNqOHM5Q2Nm?=
 =?utf-8?B?TU1yZy9RV0xrOWoxSTBrdlRXZysrdmFNK05POW9iTlZUaFlBQnZJL3BBR0lD?=
 =?utf-8?B?ekxJRUphdEF4Q2RsTnhnK1MyNmlCODhzMVV4Y0IzU0dCSFBySnZZZjZ3OHdS?=
 =?utf-8?B?NU1GQjgzZ2xvQlMyY0ZWZUxHQzczTC9RSnFvYmZ3UTRGZDZnbXdlNEszQmN3?=
 =?utf-8?B?OGNFaXd3b0c3dlp1dElMU3RlVWlGdnlicGIxbXdoaENlRWduRnJYdjFtNGdj?=
 =?utf-8?B?VzI4V1RSalhST0ZCeUlUaE9Pbk11dC92NGtPWHNza3VIVnM3UXEreGZhdnV3?=
 =?utf-8?B?R1N3ZnpvNWFSRXlsdU1KVFErVGtNSm1lUXFVdC9pQ1ZtTzVLTmxER0c1ZEgv?=
 =?utf-8?B?UUZPM2JyWkp4OTlhQmY0VlZYTUJXZHZuMmRNdThhOUxWckY1YXNWNGhnV2pF?=
 =?utf-8?B?RnJzV2FRaXN3R3IxMlMrbGE3TGhobmlWWXVtbnZvLzN0Q3BQdVI3QVFrQ0dT?=
 =?utf-8?B?SHhqMWhzYWw2SXlqUWhieHA5YnhEK0RaSTkzZXFrNTRuQnY1S3VYbkt6bWJY?=
 =?utf-8?B?V0d4YnlSZFBNV20vckFJbitrVVk0cEdjSzN2cytjTnVDRzhhcjlWa2FHcmFQ?=
 =?utf-8?B?cXBocVVoUGVaQkMvZnVvS0lzdHNsMXRpZy9iZ3ZJUVNqdmg5SityVDF4TUhO?=
 =?utf-8?B?ck04ajN4bW9MQnEwTkZTOHArQzE1OThaRExXdHl6eDh6UjFRWFVBcG5hSzRC?=
 =?utf-8?B?R0JiMGdVWVMzY3FLck9Jc0xOV3RRZk10Ny9xbFltRVJ6cFNTT1JiaitJUzlO?=
 =?utf-8?B?TjdQWlJZT09UOFdTZmZITkZsaVVabXl6WXE3QWduNENVQ211cTh6ZWlMSVJi?=
 =?utf-8?B?U2ZMZENzZDBaY0pMMXNTanZuLzV1dGdxNHJPRksrZDJuN0hEN245R3dadWZT?=
 =?utf-8?B?b1lnTEVQYjZYMzNmVVlsZDdyRmVobU9RU3NPaXgya1V0cUJBRmltWWl1V0xk?=
 =?utf-8?B?bi9ESlk0ZU5YMHRhQlk4UDFTZDJWZWVIbHJGWENldk53U0FBeUpVQ1pPREdp?=
 =?utf-8?B?ejFqbWtNaTY4cDZpRTlDVkptTHQweVpZWStWaVZveGlaUDltZUJhKzdFT3dW?=
 =?utf-8?B?d2pRRVAzcERBdmV4dmFnckFlYlJZTXBsaGI0RUUrK1lnSzNRNDYzTVB4ejhF?=
 =?utf-8?B?QVhYdUlRS05jcnB2OEJRY2N5VjdLMTZtQWdoUVp0R292em1XbUo5UnEvSE9E?=
 =?utf-8?Q?GQcpIdKVHpPLhnI1Ku3n8Ci2SSNKbg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q3RNSVNVRVNKaFl0RWVsdHRYWWd5NzY0Q3pGYW0vYzdXOUF6VjlmbHlHVzBn?=
 =?utf-8?B?QWxzdGpJRkp4R1JlS2orajl3MEwyT1JZcXRPdnZXbDVxSFV6enNnS1RPNkpD?=
 =?utf-8?B?Yi90OFpWc24vem0yWmgwNjVYUVZENk4vb2tocjI5TTFPQkkxaks2bkVGckxM?=
 =?utf-8?B?aUFIbG9vcmpBNUdtOEU2NmJuOXIvWVFTUHI4VEJTdHN1Qk5SblVHZVZndU9Y?=
 =?utf-8?B?dDNOTWJsQjYwcTdmZGxvYTlMWm5ZZ1lnZERodDdabmpjSWFUemRHWDRtT0Uz?=
 =?utf-8?B?UHUrODV5WkhQb0dxcFh5dHpLcCs1Qm01Vy9VSU5hZEVKVGdLU00wT2cyT1ZS?=
 =?utf-8?B?bU1TeTJuRGFqbXYvUkM1czdVeDZuUXJoK2FvU3F0TGZqVlJIN21hd1N3RVdC?=
 =?utf-8?B?OUdkek1kMzVuUlErWmlZM0k1Umo3UkZwZ2g2a21NZ2JRVW0wcitLT1hscHhO?=
 =?utf-8?B?QUxWcFk3bHZzK2lQMUFOQjF5QXZjeXV1MXNxQnVScmFhR0RaK1hicDZFOURq?=
 =?utf-8?B?OVgvY1BrcmF4Y1BQN2NQNUs4UVBaQ1lZYjdZVmtGOTgxZnd1dk9Pcm40TEtt?=
 =?utf-8?B?d2VwR2pWNWV1L3NYRDZKaFJSWmxlNytIOHJRVUJSaVFpb2xxOGJvYmJHRm5L?=
 =?utf-8?B?M2JCTHk4cUlXWllVc2ZRNXl1b3VWazUvRUlKMFZwK1hCS0xSRnlpaHdQMGtp?=
 =?utf-8?B?UE9kUEEzTG4wU3hSa012cTR5YjlBdlJ3QWJ0L1JSOWZhWk1YWjFjWW9McXlG?=
 =?utf-8?B?WWZSZDJWVEpkUWdIUk5UVWg2MXNZcGExTHR2MkpxTnZQUHAvL08wS3J0djg1?=
 =?utf-8?B?b0JsdVhxUGZIRjk4S0Q5WUpOVHZteXV2TGdYQ3dueVFoU1ExTkNpT0tWb3BJ?=
 =?utf-8?B?NXdiQjZPSFNjWXM4VVp6bEtlSW5ua0I4ei84bHJKQ0kxUHhBSkduK0QxTFpq?=
 =?utf-8?B?YUwzbEdNWXlQdE03eUIySys2VCtuMFZmM3MyVE5leG12UnBwWm83Y3FuMEln?=
 =?utf-8?B?RXlka3dHOTh2V2xWb0gydFk1bjVRbHYxZGJhMVRHdFlxcm5ZdjJKT1Q2ZjBR?=
 =?utf-8?B?Q0p4aERqQjVGTE9iQnhuY3JNemVWMWdFR2NMWllTK09lUWpyNFZCMmRQRXc2?=
 =?utf-8?B?T0ZjZTJQYWpMQktudElCOVhmdnpPTnNMcWdNcm5mYk9IeE5aY25DTTVlRjVl?=
 =?utf-8?B?T09HUFhnRXlVc3BxT3E4MVVyZThTb3dtK1hEbDQzMGRaTUx2ZFliUXZaWVdl?=
 =?utf-8?B?WEtaS2ZEbUtuWk45bXR0Q05BZlQvbVpUTWUwNHJpUitnVGIzUGlvYURMM1JZ?=
 =?utf-8?B?V3FLbm5CSmZMMXFqell0T25YWXQxVlJuZ3UvNTZUWVBCTkQwdFgzUllGTWh0?=
 =?utf-8?B?ZWJYQVAzTnZkL1FDdXBNdDIyb1BYcVNpMGpXV2pMVUJIK2hQSmU0SXZ0YkxT?=
 =?utf-8?B?QXpJV1hRUGE1YjlBYmRQL0pOKzdKVmJMSzhqaE4xZWRkTm1XUGtVTll6eUh4?=
 =?utf-8?B?YVBJMG5vUm9Va1o1YTg2NmFTVDBRR2t0L2ltMmVqcWRYM09kS2paQlBtWFVl?=
 =?utf-8?B?TkNOQkxQZDlramtiTmNHL0NkK3FGdDV3Rkg4ellob1E5SmVEbWd6OUpndDdr?=
 =?utf-8?B?aUo5Yld0Rld5MTdMV2xSUTdKYmFJSlhVZ2Vma29nOEhiYjU3eFlzcy9BMW40?=
 =?utf-8?B?cmhYQnlpSzZrM1RXOHVOUFc1OEM0ZkpRVkh2bGRGSlZSeGw5QURmVjd3TnB6?=
 =?utf-8?B?eGFJN1RhTTg5YnhWR21LUDcrMllITzR4RzFPdVhrWkMxTDB5Rlo0MnI0ZnRG?=
 =?utf-8?B?c2pWRUZYMFQxZ0J2QkRjZjFzTWxBTkVTVE0yZEltaEc0TElnTW5reUpaRmV2?=
 =?utf-8?B?TFVvL2RnT1hkNFNCNVhMSmExaEYva3hiZ0ZkN2xkbVpmS1FGbUY0Umc4cHEz?=
 =?utf-8?B?cCt2dWI2eFpIbldKVnJsUm5xTy9aSnd4MjZaWkNWL2JnejlsZ0loUFpNNmZs?=
 =?utf-8?B?YWpJdWxUb0J4Ni9TUExzNWZpaGxZMFpYMnRyeHRpdkd6QkpKWnV6YTlwT1J6?=
 =?utf-8?B?UU9sSUt1S3RrZktzQXM0L1VrK1d2Z21DOVRUd2hOV0hjTW1WaVpYUDRUMEY4?=
 =?utf-8?Q?hzOljVkS9wTV5SCumVFfD2RAo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RPxdR5c+lIRFr4/NxxUOWXqvdW8fLay5KQpvQMFZeauguB4tN7/a3pg+DVUAI/pncTK1w6YCE/jBwxNDWbl2RlTEoQUMfXoCHKSTcS9/X897R9cfJTLr9cD3oMgF1h5wlLDEVVtJFYHoTmfFBXdb2g1EtOkm2Y7OHCQusgFBuGs1lHUDphFrDB8nQbDvPx0A13Dxu4bwxoyjuS0w3TY4EAitcfxn4y8ali09+iTLfYha4WY3G5m2rqkaLUai0to6hTlq2kHzX0JbEEaxLdVcVrHiPQkpx43z20giNUxxOo6/UPvSZTer3MubFhHJ/XAW62/D98kPXwVGHXl3bY9+Uh5bpSzJqm0hPvswM3xClkUVwjW06aGQAG5kXulc4w37HdmpCF9hnSxjHTl3hc2ySRwYbxZBtY3FltCF8B87jijPjowVOatjcEA3Y3BWmwkYwGNWg1avZL8r0/Dv5CetPp+vblsKT9EfFUvEWIH608r8BPSbl6pwfveBd0lyx7vliX6rIk3FNMoJUW8ZjpKmR9Xmp0ekigAS5kfj59smYUOwibmBPmYg7k2NruTa/Q+C8t4nUj5UA42pllA9YL0qpabVCUSrmveZg/MFuRwu0Go=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d5d7c5-c79d-4e1e-26eb-08de0e7d2a9d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 19:33:08.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WpGCxid6aEQBWhqtGTNn2qW4LK4wIztShll5lT0SwXJrGg7LRJAyISzY4WDrEJyXPFIGsXUGiWIzMK/oNd60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510180141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX+YLsxpK4EVdC
 rSKwQwCC7nglj2ZqAdujoXK+A+qn2R6jBcLA4gp5hx2h3mJAwRleW+558EQVvIsY5sj39d0VDkw
 v/d8E1ksvsn1f9aYUZjLYAV19CnwJdBN/EXO2TNXGBrx/Ly75lYy1avi0h52GeRcJSyHjLgOMUC
 oK1z4wC/Tqu0k759JUPLvaxyk1+l+DApC/qmKzPmGqWsSquC9F8oA/MFuTPfgZMkAkOSKi1Dh7x
 UUqY9uQYyKhOZ1X05aPMhhEsKsEK7NprCqJAkmPcagh7LcYyrvR/mm0+gFfne7NuAiLoljwsro+
 RfZ/aByFy2ovgKDPaW7qkry3EBkL2OXqTHCKdfECyFIO20Tu1dzWaSFdytMwio2yy0MOxFCJQTH
 YFwZAqOuPcFb2ti6WfqeflxZjtRVaQ==
X-Proofpoint-GUID: dzxwF7hHET952DSyyHbg7ykC0j-LtIqK
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f3eb79 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=bIhVEiLJkjvrmFNRmjYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dzxwF7hHET952DSyyHbg7ykC0j-LtIqK

On 10/17/25 7:32 AM, Jeff Layton wrote:
> The filecache infrastructure will only handle S_IFREG files at the
> moment. Directory delegations will require adding support for opening
> S_IFDIR inodes.
> 
> Plumb a "type" argument into nfsd_file_do_acquire() and have all of the
> existing callers set it to S_IFREG. Add a new nfsd_file_acquire_dir()
> wrapper that nfsd can call to request a nfsd_file that holds a directory
> open.
> 
> For now, there is no need for a fsnotify_mark for directories, as
> CB_NOTIFY is not yet supported. Change nfsd_file_do_acquire() to avoid
> allocating one for non-S_IFREG inodes.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/filecache.c | 57 ++++++++++++++++++++++++++++++++++++++++-------------
>  fs/nfsd/filecache.h |  2 ++
>  fs/nfsd/vfs.c       |  5 +++--
>  fs/nfsd/vfs.h       |  2 +-
>  4 files changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a238b6725008a5c2988bd3da874d1f34ee778437..93798575b8075c63f95cd415b6d24df706ada0f6 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -1086,7 +1086,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>  		     struct auth_domain *client,
>  		     struct svc_fh *fhp,
>  		     unsigned int may_flags, struct file *file,
> -		     struct nfsd_file **pnf, bool want_gc)
> +		     umode_t type, bool want_gc, struct nfsd_file **pnf)
>  {
>  	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
>  	struct nfsd_file *new, *nf;
> @@ -1097,13 +1097,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>  	int ret;
>  
>  retry:
> -	if (rqstp) {
> -		status = fh_verify(rqstp, fhp, S_IFREG,
> +	if (rqstp)
> +		status = fh_verify(rqstp, fhp, type,
>  				   may_flags|NFSD_MAY_OWNER_OVERRIDE);
> -	} else {
> -		status = fh_verify_local(net, cred, client, fhp, S_IFREG,
> +	else
> +		status = fh_verify_local(net, cred, client, fhp, type,
>  					 may_flags|NFSD_MAY_OWNER_OVERRIDE);
> -	}
> +
>  	if (status != nfs_ok)
>  		return status;
>  	inode = d_inode(fhp->fh_dentry);
> @@ -1176,15 +1176,18 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
>  
>  open_file:
>  	trace_nfsd_file_alloc(nf);
> -	nf->nf_mark = nfsd_file_mark_find_or_create(inode);
> -	if (nf->nf_mark) {
> +
> +	if (type == S_IFREG)
> +		nf->nf_mark = nfsd_file_mark_find_or_create(inode);
> +
> +	if (type != S_IFREG || nf->nf_mark) {
>  		if (file) {
>  			get_file(file);
>  			nf->nf_file = file;
>  			status = nfs_ok;
>  			trace_nfsd_file_opened(nf, status);
>  		} else {
> -			ret = nfsd_open_verified(fhp, may_flags, &nf->nf_file);
> +			ret = nfsd_open_verified(fhp, type, may_flags, &nf->nf_file);
>  			if (ret == -EOPENSTALE && stale_retry) {
>  				stale_retry = false;
>  				nfsd_file_unhash(nf);
> @@ -1246,7 +1249,7 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		     unsigned int may_flags, struct nfsd_file **pnf)
>  {
>  	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> -				    fhp, may_flags, NULL, pnf, true);
> +				    fhp, may_flags, NULL, S_IFREG, true, pnf);
>  }
>  
>  /**
> @@ -1271,7 +1274,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		  unsigned int may_flags, struct nfsd_file **pnf)
>  {
>  	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> -				    fhp, may_flags, NULL, pnf, false);
> +				    fhp, may_flags, NULL, S_IFREG, false, pnf);
>  }
>  
>  /**
> @@ -1314,8 +1317,8 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
>  	const struct cred *save_cred = get_current_cred();
>  	__be32 beres;
>  
> -	beres = nfsd_file_do_acquire(NULL, net, cred, client,
> -				     fhp, may_flags, NULL, pnf, false);
> +	beres = nfsd_file_do_acquire(NULL, net, cred, client, fhp, may_flags,
> +				     NULL, S_IFREG, false, pnf);
>  	put_cred(revert_creds(save_cred));
>  	return beres;
>  }
> @@ -1344,7 +1347,33 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			 struct nfsd_file **pnf)
>  {
>  	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
> -				    fhp, may_flags, file, pnf, false);
> +				    fhp, may_flags, file, S_IFREG, false, pnf);
> +}
> +
> +/**
> + * nfsd_file_acquire_dir - Get a struct nfsd_file with an open directory
> + * @rqstp: the RPC transaction being executed
> + * @fhp: the NFS filehandle of the file to be opened
> + * @pnf: OUT: new or found "struct nfsd_file" object
> + *
> + * The nfsd_file_object returned by this API is reference-counted
> + * but not garbage-collected. The object is unhashed after the
> + * final nfsd_file_put(). This opens directories only, and only
> + * in O_RDONLY mode.
> + *
> + * Return values:
> + *   %nfs_ok - @pnf points to an nfsd_file with its reference
> + *   count boosted.
> + *
> + * On error, an nfsstat value in network byte order is returned.
> + */
> +__be32
> +nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		      struct nfsd_file **pnf)
> +{
> +	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL, fhp,
> +				    NFSD_MAY_READ|NFSD_MAY_64BIT_COOKIE,
> +				    NULL, S_IFDIR, false, pnf);
>  }
>  
>  /*
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index e3d6ca2b60308e5e91ba4bb32d935f54527d8bda..b383dbc5b9218d21a29b852572f80fab08de9fa9 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -82,5 +82,7 @@ __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  __be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
>  			       struct auth_domain *client, struct svc_fh *fhp,
>  			       unsigned int may_flags, struct nfsd_file **pnf);
> +__be32 nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		  struct nfsd_file **pnf);
>  int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
>  #endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index eeb138569eba5df6de361cf6ba29604722e14af9..12c33223b612664dbb3b18b591e97fc708165763 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -959,15 +959,16 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  /**
>   * nfsd_open_verified - Open a regular file for the filecache
>   * @fhp: NFS filehandle of the file to open
> + * @type: S_IFMT inode type allowed (0 means any type is allowed)
>   * @may_flags: internal permission flags
>   * @filp: OUT: open "struct file *"
>   *
>   * Returns zero on success, or a negative errno value.
>   */
>  int
> -nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
> +nfsd_open_verified(struct svc_fh *fhp, umode_t type, int may_flags, struct file **filp)
>  {
> -	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
> +	return __nfsd_open(fhp, type, may_flags, filp);
>  }
>  
>  /*
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index fa46f8b5f132079e3a2c45e71ecf9cc43181f6b0..ded2900d423f80d33fb6c8b809bc5d9fc842ebfd 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -114,7 +114,7 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  int 		nfsd_open_break_lease(struct inode *, int);
>  __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
>  				int, struct file **);
> -int		nfsd_open_verified(struct svc_fh *fhp, int may_flags,
> +int		nfsd_open_verified(struct svc_fh *fhp, umode_t type, int may_flags,
>  				struct file **filp);
>  __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				struct file *file, loff_t offset,
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

These can probably go in via Christian's tree. I don't think there
are going to be conflicts between these and what's in nfsd-testing
now.

-- 
Chuck Lever

