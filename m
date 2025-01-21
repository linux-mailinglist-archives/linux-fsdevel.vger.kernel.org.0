Return-Path: <linux-fsdevel+bounces-39795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C1EA185CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 20:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E2C1885ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FE1F560C;
	Tue, 21 Jan 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zx3vX/78";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xIy2+XoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FB1AC88B;
	Tue, 21 Jan 2025 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737488744; cv=fail; b=cU3z+s6lEPchGDk3u7kjCUbHF6m64ybz2jOHopwQHnRG7uvhR+mD83HqLw4E+E67cyilWzWz3aHc4wg6cnWJXFXCZ+sagyB5Zm7OLqaOpCwS0zAuOEOkmH8Xqb6afZMLSQE4woXkBpW6dZxwhV9f/ov61mDNYDv2+/rwJUrfM5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737488744; c=relaxed/simple;
	bh=Rd+P/A/TVd6j0DlOPCBg6hiTxvbTPP0YNHp2m3OHcaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L4GOiBYrrw64FxiVmf1BNdcz8IXW1lVoaatBoVyx8zcOybtYo7loDQcWYEg38gSxMiYgl/7KelRQ6Rml+WVddeSq3cXJmeAQ5K0V+iAvuHPDSx7DPeXMOusv74UBZGdoza8b1nRr3DBvao+oPRDIXitYF1lKeTLO5yv+Zb0+BIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zx3vX/78; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xIy2+XoT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LJJtlb020660;
	Tue, 21 Jan 2025 19:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NfoEEBXNuqioXypBs9N1ZE466hMnqegEaIS0p7J2EoQ=; b=
	Zx3vX/78Hr02B1ddI1jQMye9X76rPhq9vaUFeS4TOaU/Jnsf6dfpGuemaaCNAOpj
	aeZTZqVmnS7o2kIf89e48PYEJrf1+yWfyGqg9Peq/2YYPP5gwDPkyVNDoW3zxXHT
	JYzniWC6P2ea6YXxWPfGcAENd3OHArFgWOCXuBJxb7cV030kJ6sP2pUF9+3eKEly
	AYJTEpNr+1BkLPLVxSDJk79fuT53GFEsMUeYI8UW6YhglXEHbp3WpefpdtLy1X7t
	o5hBajY0vtFLMPKpqI27kYY8jOIulP8iv0GJSO3dAlltofOISikTLF9T0LwwtQ1j
	zv7WIWmKQFkJW42paf8UaQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nse62d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 19:45:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50LJELwp030420;
	Tue, 21 Jan 2025 19:45:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491fj8ys2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 19:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8WrQHSjbSEFv1eJZUkIS6DKj81OFr49of2ZOieIZMXbrnEFzSMRPZWJvG52DuWE+Aku/fP9GFOWqk3zlRUMlbcgnn0/7kR9todeixjARQT7KX9bcJjEXWHbDprgVC5H65fPA1ZAfjIQLDSr9MtQmplETX3GnXDHjx88uZmSosJyLhf1vvpb7+iGXV76BY6H9nkEO0IIjbMRDs1J7JtsahtHzz5Kjm2oOSo3yWayQbT/ZNMr1I8C2LJdxcifb0I4Oh2l4ImvDnc+Z8uBB/aC0JuoG/dq/1q3rYOtHUjdFNzn+QXKHfhbbv4rywikyaHbxqi1jYR/h2thGz8+Jvpycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfoEEBXNuqioXypBs9N1ZE466hMnqegEaIS0p7J2EoQ=;
 b=G/6eI57++Pjx1t3WqnJOgEG2Ox7FS17a1y+yAqssw0c2gK6tRJ3dGcIPNlq9ohibLOPhNxTEz9gSzI3QrBVCFGjzgHyljKH7f+2hRDtU35FuiXdbbbTwdWwRVfvbkifMSTNp+l/jQcul1h74bCZmeLxHXwXHyMBZuhM+v6shh33Ryv59zUnkiEmWSVPfwSTxyLqrOJzF2m/80CtY9aFsU3eMXpd5fUH/NtqG5rjaUyv9FPpWOq6TK3a1l1NLu0bc76z5YA1qr4HEeh7l3EAIt/3Uam76w0ePbZsE/gUoV6p/1vdSYcx1tcgtLs/itTrFYvfuVXVJs+M/H8PbCIGvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfoEEBXNuqioXypBs9N1ZE466hMnqegEaIS0p7J2EoQ=;
 b=xIy2+XoTkjL6bITkBHXhCuDNr04xMG2JJktNqLd+ckzN+gmLbjw/ksuWSKpp0AKGwnIhA6mRxQZyZKeZEILyupNrZgBKmLe4T4rCUAAD/YUvirK+iDUfBVNn6c2+UCfMBTohNZT/xMC59LU1pSQtiT+Pn2L+DqjDpH2pUrayvn0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6591.namprd10.prod.outlook.com (2603:10b6:806:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 19:45:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 19:45:15 +0000
Message-ID: <7d2299dc-b91a-4e23-924a-f3462b69d4bc@oracle.com>
Date: Tue, 21 Jan 2025 14:45:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nfsd: map EBUSY to NFS4ERR_ACCESS for all operations
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>
References: <20250121103954.415462-1-amir73il@gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250121103954.415462-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:33::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 8066e6ac-022b-47f1-94ea-08dd3a5420a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk1RbCtPQjIxRHh1QnJ4R2NqZnZXOEIvMzc5bUpDTVFMb25XRCtSVnpsc05K?=
 =?utf-8?B?T0lzSHJjZkVQWms1RGdPMUQyN3U4bVRRNGlhdWh3WktVZVBqanl2TS9sa0V5?=
 =?utf-8?B?NW5RaFhEajJxUzBQbkNERzFtaGRqanlIMTExS3FheG5RRDdLekxNMGRPVEdT?=
 =?utf-8?B?b21OWS9lNk5veFdtRWdET1IweTdoRXpxZ2pldCtqelFxUDk3Mk5ZMFVkRnRS?=
 =?utf-8?B?bi9ZTXZxNDM1ZEN2Tlk0aUorRjJFaHUyNkI3TGJuWGg4dnltS1JROE55Z2Qw?=
 =?utf-8?B?MzJiM2dFNkw3Z2syK3J0Vmc2SXRiRmE4V3lnZ3ozQnhDZzRoblVLVVUydkNY?=
 =?utf-8?B?RXR4OWJ0QmZjVVBVcHlNeEw1a05DdXkvU1BPcC9mTzVMd0lMNUViZ25CRTJj?=
 =?utf-8?B?MjQ4cFBySG02SVk1TndOcER0dFJMd3J3RjdyWEw0S2dCU2pzL1Y4ZytIZ3B1?=
 =?utf-8?B?Q1ViQmlIZVVSclVEWE1zSmh6clRSTFA4QWJGNEswS0pFYktWV25TbnYybmRi?=
 =?utf-8?B?SVBsTWJBYjUyaGp6ZTYrSHdWQjBCMzJwckl6bU5oRkZUSTNPOVhEMm05dW5C?=
 =?utf-8?B?OHZNRU9Nbmc2YUxaYjNmbG5vZWF4MjMzNkE2MFh0MmVpSmRlZzM2RkEyOCs2?=
 =?utf-8?B?QS9yOGg4d3BNZ2xHRTdPRE9iZmU4RDhFKzBOQmZKcUxyUCsveXRaMzBRZ3lH?=
 =?utf-8?B?UFEvamhoNmFuS3p6ckVYRXZuYVJ4TEc5SnlxQ2g4akdiWEszYTQ3SXlHbVpW?=
 =?utf-8?B?Z2s5c0M5UmhHRlVqanRvSDV5TkZIZEJPbzFEMVFsY3hPN09FcEFnaGhwOTdD?=
 =?utf-8?B?eCsyNXVib2F3MG5EYXFRSVdNKzZyUWM1MDBIRzlBYThoK2oxL2ZUa0Zzb3BV?=
 =?utf-8?B?MEJLMGRKVktJb3Q3OXNkTm04UkpVMTMwT0JQOFpQeTN3Qll1SUFFR3NKeVBS?=
 =?utf-8?B?NFZ3TFYwcjlPSzhmVUl0eG5zU21wZXYzdkYrRVpoMFpYUjhFM1REbGt1eEh1?=
 =?utf-8?B?akdVNTZsKzZaWi9xZFhKWGlxZjVhMmZGVkM4TVN4OE1LODVhcXdrc0ovQkNa?=
 =?utf-8?B?cG9qVmhtY1lzV0dhWlYvVzlQVWtpUzJ6dVp0RWZrRFlNb2JaNVBiVGtUbExZ?=
 =?utf-8?B?d3JlR2Z2L3hEOUx5bWdZNDVpOVZSTDIxU210MHROWmh1VUxRTkhzSHZSVFFF?=
 =?utf-8?B?c3EwRXdOd1dDbFRIVjVCblNDQk9QY1NqVlBzZmlZaGtzTU95RUNla09XbVhV?=
 =?utf-8?B?SWVQQVh1aUx0SnRCTVhRZjAyckQzSGQxUlRzMms1L2ZTYWZsZXpVOCtKM1Vl?=
 =?utf-8?B?d3F0TzFqWjFtOUpFTDR6TFRBR3crOFhRaC9vZFYyT0p5Z29SSExmUFpFSHRY?=
 =?utf-8?B?bDJFZ1RHWHFYaHhTRVA2M0lNWmE5U1FyUVhBaWFFTGpGeWF4L3pRMVVaL0Vz?=
 =?utf-8?B?ZWwvdTEyREhXdTRyRW9mNis0QU9kMUtHMEorc0ZpTWtxSUdoanRRTUREajhX?=
 =?utf-8?B?WGlabWFGK3A3WFJ4aUpKUldwMTJYMmdTZUhwTmM1VUkzVXdVQWgxeVk3RzIz?=
 =?utf-8?B?cWpDOCsyY29YRVIrWmxIZVkxeHhaNEZBeTdvVWFiUEMzRzJBMDZBUU9VNG5j?=
 =?utf-8?B?bXVtOHY1WS93QVMxcUlzbk1hT0ZqWit2QUYvemxsdFE1b0t5RzlRN0hVSzlj?=
 =?utf-8?B?YmhZeWg5RHZIbGhjT0lCSU1FZ2RMdFpqa0trN3hJc1BFVDh2dFRZWkV5WEJI?=
 =?utf-8?B?SE9NUmRiNndzTmVvTGhaZE5idGVtNnF0WDZVQTE2TmN0QVBKMmRKcGtuSHh3?=
 =?utf-8?B?QnJsbEdvMVRZSm1wY1g1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elEzelc2SU9jQXhsU0ovbjRXaEIyTENaMDZTdmN6ZHRJUTN1cmdxeGJpaDNa?=
 =?utf-8?B?OU5PRENWZHhhVDc4eXZjTFp0dDJlUk9DaFYxM0dLdGNkektCbDY4QkZlN2o4?=
 =?utf-8?B?Z2ZXRU85cGpkOCszRHN3d3FVMEN6M0ZvRU5TNHVZTXZwRFBQdGxPeXhZeXky?=
 =?utf-8?B?d2UyZVpOWGdkWFJaMjNCQm1tU1dyWllYOVM1enovK2pLNjFVQnI3Q3JYZkx4?=
 =?utf-8?B?c09LYnJBSDRuRlhsc2FuZzlsNStBTlBFdndEYStIdGFvM3NhdUJQOTNiMjBI?=
 =?utf-8?B?Wm9JcXVMTXp0M1FtdzhrUTdsZU1sYjhYcDJHd25meUVyeHZWMlNEcGlrVXp5?=
 =?utf-8?B?RHBsWkJaRGJaTWg1RHJ5KzRlMUJXcmRWTVBmaytRbSsxZnJCL1A2ZHovOUtn?=
 =?utf-8?B?SjBHRytlTjNEc2k4ZzczeXF4RExqS2RCcjNwUUtaazVQR2hIWmlBV0lEbWhB?=
 =?utf-8?B?SVhHTzRPQ3ZINUNtTUxORUUvTWxtdFJGLzlEeC9pU0NNdlZIbHN3YXE2UWY0?=
 =?utf-8?B?RGlOQ2poc0VZanNvaysvdkF3RmRWN2FwVi9tVmVPMUtWa3V1bHlpWi81TkV3?=
 =?utf-8?B?UUJzL3RQLzlrbFp3MzF0WGw1NXYybFRFRnE0dXRLaWdQa1prVVZKQTVFcW9F?=
 =?utf-8?B?QXY2dVZjcGh0djJvRDF6czJaL0dUUHFyTFZGdk8xRG1nd3dVTG9sUUJlSXUy?=
 =?utf-8?B?ckhZVXhTZDV6Y0hMdnNhTGx0OVUzZE5zMTJmTjdKUzVMWmNqeWZBcDE2UGNj?=
 =?utf-8?B?WjZUNms5eWNRTFlHZHBmTEZ0QmZWQkJDV0c0NmhXb3N6UVE5bmRDOUtyc0Ru?=
 =?utf-8?B?MTZJUzVKY1hyMmJTaDFuUGJTZ2d0Z0pwY2Q5b2V2N1dGajBoUWllcXo4RE5k?=
 =?utf-8?B?SW5kOTRjd0RIbjlpVCtBNC94VjBUd0k4YXR6RzJEWklFeE9TUjZCc0RTYWpN?=
 =?utf-8?B?WUh5QnRncENFQzlrdlZ6WWplM3BQYVhqaWVvOEg2WmxWeEJseUdQekhySUdz?=
 =?utf-8?B?Nk03TGsyVXRGbXl0NzVsWTRxUmJGMUZNZE1ZYjNTMGo3YW04R1BueG8yTjB1?=
 =?utf-8?B?WkRNZEF1VE5vUkNYbkxOVHI5ZjlXdmNMZEM1UjJrOFo3Rm5EeDh2K0MzTXd0?=
 =?utf-8?B?SjEzV1RyZTU2RWJYZGxjc3ExYXVKbGhaR25xZE45TDZRTC9rL0FoeWVYUXpz?=
 =?utf-8?B?UVBuU2lLWlVvRWs5KzlYbytxd3NvWHZWODVHNVhBYkp5ZmcrL0txY1FqbnhM?=
 =?utf-8?B?NWdTTk1IVGxvYytIS1JHcGYvRjY1TitOeFQxd3I0NmJpS3ZaQVFwTU5wQkJ6?=
 =?utf-8?B?R01VdVlKMUFBa3RlNEpGTDk0ZDZRQ2pIdmd5WW44UFlvQmEwNjVMTk1LOEJP?=
 =?utf-8?B?bGYwWE5tUCs5MnhjQ1dsMHNFQzkySEFnS0wwaEt0MENsY0EwT3NvN2NadUpW?=
 =?utf-8?B?OUJRN2pEbnN3RG5HZHB4M3dEeVZmWFJWWGpIVlpVQmxmSTZGZ3ZXWmJQMEND?=
 =?utf-8?B?VVgwUG9GVEtxNS9FRnd5NnJ1dnVIcVlLYWVQNXBEOG05YXhHenF3N2ZqUDda?=
 =?utf-8?B?YTB3OWxUNnhBZWlScDJYem1oUjdLdnVXdEJLUS82Um93VTkyVzRkT0htUFc4?=
 =?utf-8?B?eHA1WTVKRjJZeGJQVlZaYkhnZ3BKSWtwY25URkF4dFJ6dmxCS0xnQlh5VjVS?=
 =?utf-8?B?L2xnbWNFd1lIVnFYdFh3VkRBYWVOa1J0a2NpRjZpc2s2QmxkQ0JoOWhVYlZL?=
 =?utf-8?B?bWhjd3d1TFFZUDhtV2N5amdUeDMwQjd4Z0h1UWZzUVVMVDNSMEpybkszSUR0?=
 =?utf-8?B?SGFsWHZCOWZ0OVhsUnovVG1mNXd0SVZpamF3TDQvd2QvdFkxVXI1RnZ6MnRj?=
 =?utf-8?B?dU85clY2QzcybGNTZjZNeDhFYlgzUlpFbSthL1VkSTFCR1NiTWtkU2NoMmxu?=
 =?utf-8?B?TWF4Z09vUEhXeEhEYWlPemJWemt5MTBGRFNrSU9jK0lVeUVUSFE4emdXMzVP?=
 =?utf-8?B?aE9mc0V3NUFJQ3VQLzNnTHpwbzdNdVVFNE1sUk9XcTI3cVFUaU9jN1p0N1pq?=
 =?utf-8?B?c2drcjZFbzRybFlPTndTNHEzdWM5a0FveWpMR2RMZis4WHk2dU1ORkdiUCs3?=
 =?utf-8?B?U3JTMk4ydnl3N2JyY3BScDdyMnppbTUxMFpYemZvT1dMb05Ba2tkZVhhYkl5?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e80r6mF5NnQ2/XZ+ONBBvFqWemQ2a2FgTXsqL/WqIaC0sPk3J/TAbON8qZHyXH2n4rVxg5nVm3cocfZusWjkXAxsoOw+VC4cbjAPVLeSiTMmRbuyUMeXAvZWg7DwCOimr7MtwHVjLkSNpd9/shJzdHk5s+t13QgAudpU+eY0euuHDi3prRr6Vx1TQunycg1PJI6QeDnnJnFsBNM9m/T9M5wZ7evTCxlFDBFFtuRdylPRBV3JgWCYW1DkaHlxctOylxh/dHb/DuRYGwb5rkxqBmeiPG9EAKI1xRQoOFb67UtD5TYmn4b9olBYKTHJhujl17qHqb9m/URAN2tcrllhqeBxJvKp3RotLbyNMTdE8+ezppq0pQfnDGU2Viw+x9rB/kb3MWotbFOlX9T+dopEyygy/4AcZLfJpCOLgn8ygfFF8zMW2gmknWTKK91sTiNMKRfUt0rCLqTkqzl7H04YAHlHdssqczWZkN5fOWdrXlLJs1MwuE4atgi5b3tgU2hf+AFBMPvmlrD0tDxo2mE2o20oc7ATkdtKtbO5yb7IOuQ7ccwV/XF0cAQ/mnzG0dccNpmbd2zxR+Ct3ZbIUmpInUCd+2K3kdFLraFfW8ssKjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8066e6ac-022b-47f1-94ea-08dd3a5420a4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 19:45:15.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+bazmYG33wOp7tUoPmmc22TxK8hT2hLj+hOKwAINJwgtwrOhlDI1QOsxJQisBwrunsHcy76Xo90zc9cIbGVPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6591
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_08,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210157
X-Proofpoint-GUID: X6Do08KsRHoEopd1uFiCCSUjO33ZOqyF
X-Proofpoint-ORIG-GUID: X6Do08KsRHoEopd1uFiCCSUjO33ZOqyF

Please send patches To: the NFSD reviewers listed in MAINTAINERS and
Cc: linux-nfs and others. Thanks!


On 1/21/25 5:39 AM, Amir Goldstein wrote:
> Commit 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
> mapped EBUSY host error from rmdir/unlink operation to avoid unknown
> error server warning.

> The same reason that casued the reported EBUSY on rmdir() (dir is a
> local mount point in some other bind mount) could also cause EBUSY on
> rename and some filesystems (e.g. FUSE) can return EBUSY on other
> operations like open().
> 
> Therefore, to avoid unknown error warning in server, we need to map
> EBUSY for all operations.
> 
> The original fix mapped EBUSY to NFS4ERR_FILE_OPEN in v4 server and
> to NFS4ERR_ACCESS in v2/v3 server.
> 
> During the discussion on this issue, Trond claimed that the mapping
> made from EBUSY to NFS4ERR_FILE_OPEN was incorrect according to the
> protocol spec and specifically, NFS4ERR_FILE_OPEN is not expected
> for directories.

NFS4ERR_FILE_OPEN might be incorrect when removing certain types of
file system objects. Here's what I find in RFC 8881 Section 18.25.4:

 > If a file has an outstanding OPEN and this prevents the removal of the
 > file's directory entry, the error NFS4ERR_FILE_OPEN is returned.

It's not normative, but it does suggest that any object that cannot be
associated with an OPEN state ID should never cause REMOVE to return
NFS4ERR_FILE_OPEN.


> To keep things simple and consistent and avoid the server warning,
> map EBUSY to NFS4ERR_ACCESS for all operations in all protocol versions.

Generally a "one size fits all" mapping for these status codes is
not going to cut it. That's why we have nfsd3_map_status() and
nfsd_map_status() -- the set of permitted status codes for each
operation is different for each NFS version.

NFSv3 has REMOVE and RMDIR. You can't pass a directory to NFSv3 REMOVE.

NFSv4 has only REMOVE, and it removes the directory entry for the
object no matter its type. The set of failure modes is different for
this operation compared to NFSv3 REMOVE.

Adding a specific mapping for -EBUSY in nfserrno() is going to have
unintended consequences for any VFS call NFSD might make that returns
-EBUSY.

I think I prefer that the NFSv4 cases be dealt with in nfsd4_remove(),
nfsd4_rename(), and nfsd4_link(), and that -EBUSY should continue to
trigger a warning.


> Note that the mapping of NFS4ERR_FILE_OPEN to NFSERR_ACCESS in
> nfsd3_map_status() and nfsd_map_status() remains for possible future
> return of NFS4ERR_FILE_OPEN in a more specific use case (e.g. an unlink
> of a sillyrenamed non-dir).
> 
> Fixes: 466e16f0920f3 ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink.")
> Link: https://lore.kernel.org/linux-nfs/20250120172016.397916-1-amir73il@gmail.com/
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: NeilBrown <neilb@suse.de>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>   fs/nfsd/vfs.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29cb7b812d713..290c7db8a6180 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -69,6 +69,7 @@ nfserrno (int errno)
>   		{ nfserr_fbig, -E2BIG },
>   		{ nfserr_stale, -EBADF },
>   		{ nfserr_acces, -EACCES },
> +		{ nfserr_acces, -EBUSY},
>   		{ nfserr_exist, -EEXIST },
>   		{ nfserr_xdev, -EXDEV },
>   		{ nfserr_mlink, -EMLINK },

> @@ -2006,14 +2007,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>   out_drop_write:
>   	fh_drop_write(fhp);
>   out_nfserr:
> -	if (host_err == -EBUSY) {
> -		/* name is mounted-on. There is no perfect
> -		 * error status.
> -		 */
> -		err = nfserr_file_open;
> -	} else {
> -		err = nfserrno(host_err);
> -	}
> +	err = nfserrno(host_err);
>   out:
>   	return err;
>   out_unlock:


-- 
Chuck Lever

