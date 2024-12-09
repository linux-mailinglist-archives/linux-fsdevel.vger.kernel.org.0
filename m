Return-Path: <linux-fsdevel+bounces-36849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E2F9E9CD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9948528106D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C88153BFC;
	Mon,  9 Dec 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eYawlqXD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HTpAh2KH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4201292CE;
	Mon,  9 Dec 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764833; cv=fail; b=Uap23B2oAqtyo8/8rnarkIJ0Xxe/on+mlWyXbY0YiKIPE3R/XomrJOKypGZwqBOq3a7nEqJVkeXcKa0FmAV21isC+4JFI4UGXMkHbYGGxCxGNjiMI6g0wItAuEbp3M3zg8No1dqL56rDkRDuym67CeGiBFo8N8UJ0wIn+FXyI50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764833; c=relaxed/simple;
	bh=cfD4jMnbhWyuAAhdRRE9R/m1FGMYa9+yAT0BcCtaSQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a/CSciwKuQGINPN+upEGZvhc+p9QNscqdTtJye4WFR015IvZgGNqF5WUq5goaEC/HmZfCHKpc2mSXLUtKE4GhNZ0J0b1txdoBWDJX3l5JrZZa7ftkyrjuC0qRv3Ty0N8qBvnfTVjsBwkjLh/StkGi1lvRQDczkBcpR0P9SWrf28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eYawlqXD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HTpAh2KH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9GfqTW000829;
	Mon, 9 Dec 2024 17:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XLvZ+IHa7Kktq34A02fSrPawJ99+I5FHaZqyFraGl6w=; b=
	eYawlqXDeWdAZopI2WsirRShKk2xg0DEvYSTq9R8k47I+DNwFQwle1h5lLb/Xdq0
	mTzqAEJ7GicWxZwC9acsAU6Kh4GVvxYEMYecRA44WV82o+O6u+9bGBYb8LNS7vpb
	dNylcMJJM0mW6vO9mYATisVpWDHZfxjETYzawWOS8f02pgIhHY1ToteqhG5QzfqM
	T4nNdnt7nSL1cEDIoaC7MBei0tLpJZVuNihq5K16BR7Z5PMUpBqVxo+Dt+0JQSay
	PpD+XUU/LipId/kHUazS//UODtauYXBBR3WI9ixDIRXvxaFc04dSbUcuibugAMmA
	AU974uC2YNiEIwZSu1GDRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt3rc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 17:20:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FnV3k019284;
	Mon, 9 Dec 2024 17:20:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7h9ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 17:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2zoDe6KeYNwk40BMiAHWxC0ESVL3LjXXj2uu72b1g2LLp+gNCoonjLBLI4SrAeiXu3HIwbpDuvRkF1PeRCGjFMlAxYC2shdeM3gHMuIgu84R8MwrfmjhldtdshPyGCHeLk/gbGMMj1EMrK1y/ue/QnAQaOX8w6+NXlLc65GnOMFrkvF+IpX68Tfmo/SCcisBEfpOf+A/kxojA286F+00u7JD/IScYyrjAYQE7+iYHlqEG/MznPTroAvutwqM3B3t7uI68vlG/pKRfWVNV0Nt4xd4VFUB7y1S0LdmB9aDJ7J7DhNN/I/va6ZXh8EBtRdbK6o3vryTiLIpqrWvl4ciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLvZ+IHa7Kktq34A02fSrPawJ99+I5FHaZqyFraGl6w=;
 b=kWVnOWHmGTHB7X0cJkezWZiH+G9V6JUVh9W+FuGlgzvcYNEKqrEpDq5Ga143IjR5/MSa1FlNfLdwm9czRkKUh0WEGOWeVkvorn7Jp0t5NL30CTbkBFWvtf2GywzOVMYX8fWiEk/yT78jmUXxH5qloJkw/5hsncJLSFrZMSUI5Bm3WcipkQXMzOy5xjPGpLEHxV5m3TiCayEIZeJgAaLxciokXWfz6ss0ngZMy2QoZ+87VuTK6hA+dAAV6Yas37CCIFaSQJVL4gPLHiBOaJeSMNeBnL8fb36mTAO/JiPxfZca8jTmEcT6Spjv6hlPmB24e0YUeaNVthLf6+srGohmZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLvZ+IHa7Kktq34A02fSrPawJ99+I5FHaZqyFraGl6w=;
 b=HTpAh2KH+AwZiHXIb8Nhb7zCV/vskfumX3vKkij0F61z6qkBuYS7I7KeLhacAxdYNsHizcocJGMrK5mDbgy829ROUqWK+Ct5PPLwFPOHZ5mnKRq5V6gIWye77Qj61zgGfMhxT6KVqgwPVlVib8kc3fAwhpzxa2QdJcyiIDB4TZ4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7424.namprd10.prod.outlook.com (2603:10b6:208:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Mon, 9 Dec
 2024 17:20:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 17:20:12 +0000
Message-ID: <337ca572-2bfb-4bb5-b71c-daf7ac5e9d56@oracle.com>
Date: Mon, 9 Dec 2024 12:20:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export operations
 as only supporting file handles
To: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Erin Shepherd
 <erin.shepherd@e43.eu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        stable <stable@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
 <Z1D2BE2S6FLJ0tTk@infradead.org>
 <CAOQ4uxjPSmrvy44AdahKjzFOcydKN8t=xBnS_bhV-vC+UBdPUg@mail.gmail.com>
 <20241206160358.GC7820@frogsfrogsfrogs>
 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org>
 <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
 <Z1b00KG2O6YMuh_r@infradead.org>
 <CAOQ4uxjcVuq+PCoMos5Vi=t_S1OgJEM5wQ6Za2Ue9_FOq31m9Q@mail.gmail.com>
 <15628525-629f-49a4-a821-92092e2fa8cb@oracle.com>
 <d74572123acf8e09174a29897c3074f5d46e4ede.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d74572123acf8e09174a29897c3074f5d46e4ede.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:610:e4::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c6eb0b-403a-4533-8158-08dd1875bd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2p6V0FxVU9RRFBxanhkNU0xV3JEYWsrMGYxSFlWazdpbW15UkNsMlpCRzZj?=
 =?utf-8?B?Ui9CQ1Uxa3g5ZzZabDh0V2srS3VLZmlWZXdnOS81YnJ5SWY0RjVlSlUzUnhY?=
 =?utf-8?B?RzNYMmFra2NIZ2VzYjJwbFFFL0tNTzJaSnVSUDBETGFGeTRBQVJqbHNlVDlI?=
 =?utf-8?B?VUxFVHoyS0tUMnM1aHZpLzBoTkRrYmlsd1pCRVJqWnQxN1lwbzYvS1diRW9a?=
 =?utf-8?B?UllTeXFlYUM0WXJuN0x2VU0yTTFia05odHpPS2ZiZHVPVXE4TTkweG5ZdzNt?=
 =?utf-8?B?UXpsTTduZ2ZyK05hSVhjUUZ6dFJ5NVpkVEU1cjBKeHRKTVc1amRQM1p6NlNN?=
 =?utf-8?B?aUdCbW85ZlphcVk1NTdPQzRPblY4cEJ3VXdXbUhlMzc0c25mT01vNlU5eEZY?=
 =?utf-8?B?Y05LWVlTTnEyemtsaWRIVG9Vb0xtK2J0UmY3S3UrVnFPVi9zMzc3eDRRYk1P?=
 =?utf-8?B?L0FQYUpmcXhYck5xTXJzU2pwcnNjam9HNWtDbWVQemQzNUI3d0k5VmxSa05q?=
 =?utf-8?B?L3dhOVZ3eFAzRnd0RnVCSEptSnBZMVUvVGxsaFhLMy9CYU1QYkRvbnplaUJt?=
 =?utf-8?B?ZitVSXpYaCtSUFFReVpoU3BJaUVjRGIzUFNIUFVwTlQ1dnZtc3hiR2grTzNQ?=
 =?utf-8?B?bGk5MkhPenZnbTFZSG5XMUhKU0I3SGFjV1MycW1aU0t5cE00ZTJxNE16VU5z?=
 =?utf-8?B?OFpyOFErcENMVHFvMURJY3VWcUJqUnRvVHIrbEVGM2F0ZWczYzVScWFqVElv?=
 =?utf-8?B?QmpTY1pUcDhNZ2JnRTlNOVZJR2ZwTHQ2d0kva2ZQSXg1eityaENtOGJiVyt5?=
 =?utf-8?B?UXlzUmVKVWZUSFJhUDhhRTBwNHlvRjE2cGlvS3F3dGdWS1RLVXEzNGhkek9V?=
 =?utf-8?B?cGtwRGQram9wN0x5R25meDdlaEtpOStOV3JMdFIwdTUvRktyY1hDVXdqQkFK?=
 =?utf-8?B?RTVSdnI3b2pWVEZIaWd4MUNVMG9zMlo3KzNINjczWHgrTFpaNlpJdHNsZmZm?=
 =?utf-8?B?bFFXK21PUEphQ1QrWjROM244MWJZUWIwc2JrUXRvVHE1ZzFOV0VFd3BaRUZH?=
 =?utf-8?B?ZzJUN2dXOGFJL0VzKzJXM2ZRZklSUndWSFVqUFowazFTYlBCUVFFZC9LWGNi?=
 =?utf-8?B?d0g5YWpROGtkcExZL0NKaHpFVDdFU1pLc1ZVdGdVb2k5aHpqMWVwbWJVbVZN?=
 =?utf-8?B?WE0zcWlhSm9UVkpzOE5GMlVyTFNrdDYxcDJUd1g5M3c0eHlKQ3BhMGNkOU1L?=
 =?utf-8?B?NXQwQVl6UjZ2SFFjcmJnbnFaVFdRemU2bjhFcUxSS0d1WWVRMk5iWEoxYkQ4?=
 =?utf-8?B?RGR3Mng0MFUvcnFDTXJwVS94YzAxZFZMR2M3MDNkdWhhSW41amJUb0ZOSDBS?=
 =?utf-8?B?aFlqaHU2OFNQZFFZcTE3ZnFZWldpVEQrb0tBbmZIQkRnTjcwUm5yQ2dxWktl?=
 =?utf-8?B?YmVFYW5nMzk4VTVCRzdmcElrMyttdzJkT3J6dlpxdFpOTURHRGlvUVNRL2lu?=
 =?utf-8?B?Ynh1d0FvaHhhWXpwY04wdUc4VGhGY1k1dGFjQmo3UnlDZTBNdzBybGg5dWdN?=
 =?utf-8?B?OHR2OXVvNVdHWGhGZTFCVHVkYUR4TmRVY3VwT2xnenpQL2pQUjZOUTVDZksy?=
 =?utf-8?B?eGIwd3JFTlJ2TTlLNDhKak9LTSsrUG9qcjlBdFRaZnMwQzZzeTY1empJT1po?=
 =?utf-8?B?T3lIS2dvWkJkT0FIczFpUWJac3IrcUN2RWZUMzIwR3padkYxSEhNc3FyeDlN?=
 =?utf-8?B?SVZPSjFobC8weWZEeFJKemNJcmE5eUpybDdrZUgwNlZnaXNjZWJ4K3Nmd3Yv?=
 =?utf-8?B?alYwN05WQmtYcXBqUGUrQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzNkdk5YTSt0bGZTZXRBY1RCYnJqcysycVdyMG5hLzg4cjErdDhaYVpFZHlm?=
 =?utf-8?B?V2dvVW8yQWFRNU1heHl2eDNYUk01NGorUzE1MThzOGtRangxV3laTDMvM0ty?=
 =?utf-8?B?RHJKS2N1UGovYjFUUjdKL0VZVFExcks1MDZ2K0Zjb3p2MjBIckFYMVpYOHVl?=
 =?utf-8?B?RXZ6WFlVL2hrb3hOaURsTWdmeGtKMHZha0EraDQwZE1wOEVmRExrc2Myclhj?=
 =?utf-8?B?KzFhQ3c1QjFUSmQvSDcwM3MxckI3R0dHKzV6eTVkalFTOVIrZ2E3M0JtbFBj?=
 =?utf-8?B?UVRTL0ladlFnS3lGQVFMSHJWSmQwRmVNVGd0VG9vdEs1VG1KZW1jYTlITFcz?=
 =?utf-8?B?cnhLRjRnMHIyVDdlQW9LeFhROG1RRlNwK0Z4Y1ExYXFJY0F2NUlTWjZCYm5m?=
 =?utf-8?B?QTJPVUVKTFFWSFpXeVBJOWZuc1JuRTFJeW5BVGg4dW1XNXVtWkZEcUR2L2w1?=
 =?utf-8?B?dlFwOHQxUWJXaU1BS0RLeWRmczlOMDRENC9mOThYRVpheUZaL2FBeTdEc0tP?=
 =?utf-8?B?M3RUVVQvRHFrbGZIejhhWEtFK1hRQkNNdmRuL0p4R1lrZ1dmM1lUeHBocW5R?=
 =?utf-8?B?K0x4K3JVSUtaemQ4UHkwVDZPR01rMFZydG40ZVZPcHczUTkreWE4Mkh0OUx1?=
 =?utf-8?B?dXcweTBoM2ljWjRjVXRZZzdvamEzUDhpdGF2Smhja295ZHBJQUpTVGhBOERS?=
 =?utf-8?B?dGhTTGFFMUJFTnNZOVovU2t6WU9ZdUZRVjVYNmQ5eWJyMzU3L3J6V3hJN2I4?=
 =?utf-8?B?eVd0c2ZZcnd2MGp6cXBxcFNUQ2lDdFJ5ZVdxaldWcGZCc1hNcUc1OTF4cC9O?=
 =?utf-8?B?NE5mdmVmRS95SFk2Z1ZwOWFRTU8wOTRoU3M3dDgweUp1L1pENHlNTXpmVUdY?=
 =?utf-8?B?NjAwSCtxdHV6b2lFUVpCbHlTVGNabmprb2xJdUZTdUZVZ2VwREFaMUZma1pq?=
 =?utf-8?B?RW5HcnJKbkFSRnpTdkpYRk10K0h3b2VVdWRPeWZrd1QyQ29VYXdqK09TV094?=
 =?utf-8?B?cEV2M2lpdUwxQnRhZDlFakt3NmUvcnkrVVdtZUZrYWFobkZ3aVlUYzI0STFP?=
 =?utf-8?B?bGRTaFJNQzBGSkk3dUlxd05tSGRpWWpYT1RQUmxqS0JNZDMvTDQzR0kyQmxR?=
 =?utf-8?B?b05nWFJYZTFsMjVNSm5uVDRuSW1HeExQYnQrcGhXVERDSnBOVWJJM0hDcENz?=
 =?utf-8?B?WDBWbHpKS1l3Sm1PSUN2NmZKTjFwZkNRK1dRbE9rN2JqUXNZVWZ5RXdJSnN4?=
 =?utf-8?B?dUcrWG4rcW5VN0VtMzhJU3dYdW9hb2NHbCtaUEl3REE3WW5Xa3VCNGRqWkpH?=
 =?utf-8?B?OGlQV3JCTUkvVlZMd05rZkt3VHRZKzFrdVJVME9oMUpzR1ZsR1pFcGpGalR4?=
 =?utf-8?B?UzBxZU1hc2pGWkdjcURXV2VXVTJ4b1I4a2oyZ1M5ak9rVEJ6ck1Ob2NlRzBE?=
 =?utf-8?B?bDFRYkdPZTVkdjNGYWNXQ0RVNGhkU1RISUpjZ3R0TFgycGJzQXB5UVlTOTJ6?=
 =?utf-8?B?NEdkM0EzTzU4eGhTR2h0aHNKZXd2b2l2Syt3a0gwK0dFakRrQllyRm4rMkVt?=
 =?utf-8?B?NTVhd0w1d3k5QVlpazh6V3NESWNpem4wU3JmbHhuVU84SFdSVWlYejdVMGNF?=
 =?utf-8?B?MVNMaSt6Tit4dFJuUWE1aUNvVjRFNnZ5cFl1S09tRFY5dUV1WG84eGtCcktw?=
 =?utf-8?B?d2RmdkpLdWNyZ25KanlXNTRVWGFKOGNDa3JJL1FMeEdUZVJ4bzBqU2M2NSsx?=
 =?utf-8?B?NHhkYytxWGlWY1l3ZUdlS0h0Y3FJcGl1a3RlQWV2Tlg0MVVuYy9xM29vRSti?=
 =?utf-8?B?VnJkT1Z2bG5GRXkzK3Q2WUkxWHNBM2RFRkpEcjVEVzhrbEhVVjZkY2gwb1gy?=
 =?utf-8?B?S2JXN3Y0ZjdrL1hFRDFFZGFiSmI1ZVhweVdVMG9WUWliL2tjM2pUOC9hWmhi?=
 =?utf-8?B?ZDlCOGxyNVNVMENTY3BwU1kzUkJNL2VPVzVQc3RWMnJSR3dzYW83NE9wU1Iy?=
 =?utf-8?B?b2hyUktrQVhJdXdkQng5UDhXcTN3QmRuRWk4N3MzV28wSjBpS1I1TzdEdUtU?=
 =?utf-8?B?MkxwZkROZjhtb3Y1SjNaR2ROc1dhRTBTemZ4V295cVpUN0FaSmJCeENqTDJL?=
 =?utf-8?B?bGsxOVU3Rm5qUldUcFEyQTVLbkhzalFaeStUalpVL04yVCszTEVHMVkzb1hL?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e8GkVennvoq1YUVuqSiI5K8OXpdEVhl4Oq648JxZvBYIQigZmw8i5b6cSznriuIIsDFB3nL7VgZJOJypBnzqSyzhSlxMD8dOcfXOsI3XoLvaumQ/+C0ccYSYnpByrG/q4ljGqfH8EgM7S/+IEmeT9GJ49SDAzE3aaZbymJkGbUbUu88rzECQcSN8/C89JAru6B4WbPKugAwYUxutqFB5ZfNWpewSti9dH5pAPEKbytE68EL0bWaZCrub0BFB7PuEEVT9HFaR5IJEHRq+oEmviERD4T4qiI0SOqVvqZ5hU6G4jz0AKhFScAAByp3DZW3tnHxyB5qYGEAaPw68klYAd6/Tuk7tiAu1rxYMFa70dFOFUXOHIc5ZbzwXuJhQt85kv2uWLfPkd8ZSv4W9gZkOlAM5OFu9M7KTopRWwD5I0r2kUBe2BBkl6j4K/IBbNTzpsrMZ2FOlEKF9107/rj1gVObiMqvFHiOj/8gk/9tVfsD0mBHm+EHT0ErmefWbxWodG6pezMdRdYWQqvsaPH3HGobplEF1nAqmG0pDRmH2X/+X5L79hwWvpBiTsN/vIhhVmuUCR63shQrBJINn4f4Xy9kZcAeI+R3PFYQ/oj79r+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c6eb0b-403a-4533-8158-08dd1875bd99
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:20:12.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpqI540+rxsP8nJin2nPUShi78FvBuEzNVJCDuq9q7ACgcZvQ72ljssaYJFO+YKKz6Dsi9RhFuc90FLWx1XDMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090134
X-Proofpoint-ORIG-GUID: ei-PySNDIj-AGu1WJfyLjPbaByn386ew
X-Proofpoint-GUID: ei-PySNDIj-AGu1WJfyLjPbaByn386ew

On 12/9/24 12:15 PM, Jeff Layton wrote:
> On Mon, 2024-12-09 at 11:35 -0500, Chuck Lever wrote:
>> On 12/9/24 11:30 AM, Amir Goldstein wrote:
>>> On Mon, Dec 9, 2024 at 2:46 PM Christoph Hellwig <hch@infradead.org> wrote:
>>>>
>>>> On Mon, Dec 09, 2024 at 09:58:58AM +0100, Amir Goldstein wrote:
>>>>> To be clear, exporting pidfs or internal shmem via an anonymous fd is
>>>>> probably not possible with existing userspace tools, but with all the new
>>>>> mount_fd and magic link apis, I can never be sure what can be made possible
>>>>> to achieve when the user holds an anonymous fd.
>>>>>
>>>>> The thinking behind adding the EXPORT_OP_LOCAL_FILE_HANDLE flag
>>>>> was that when kernfs/cgroups was added exportfs support with commit
>>>>> aa8188253474 ("kernfs: add exportfs operations"), there was no intention
>>>>> to export cgroupfs over nfs, only local to uses, but that was never enforced,
>>>>> so we thought it would be good to add this restriction and backport it to
>>>>> stable kernels.
>>>>
>>>> Can you please explain what the problem with exporting these file
>>>> systems over NFS is?  Yes, it's not going to be very useful.  But what
>>>> is actually problematic about it?  Any why is it not problematic with
>>>> a userland nfs server?  We really need to settle that argumet before
>>>> deciding a flag name or polarity.
>>>>
>>>
>>> I agree that it is not the end of the world and users do have to explicitly
>>> use fsid= argument to be able to export cgroupfs via nfsd.
>>>
>>> The idea for this patch started from the claim that Jeff wrote that cgroups
>>> is not allowed for nfsd export, but I couldn't find where it is not allowed.
>>>
> 
> I think that must have been a wrong assumption on my part. I don't see
> anything that specifically prevents that either. If cgroupfs is mounted
> and you tell mountd to export it, I don't see what would prevent that.
> 
> To be clear, I don't see how you would trick bog-standard mountd into
> exporting a filesystem that isn't mounted into its namespace, however.
> Writing a replacement for mountd is always a possibilty.
> 
>>> I have no issue personally with leaving cgroupfs exportable via nfsd
>>> and changing restricting only SB_NOUSER and SB_KERNMOUNT fs.
>>>
>>> Jeff, Chuck, what is your opinion w.r.t exportability of cgroupfs via nfsd?
>>
>> We all seem to be hard-pressed to find a usage scenario where exporting
>> pseudo-filesystems via NFS is valuable. But maybe someone has done it
>> and has a good reason for it.
>>
>> The issue is whether such export should be consistently and actively
>> prevented.
>>
>> I'm not aware of any specific security issues with it.
>>
>>
> 
> I'm not either, but we are in new territory here. nfsd is a network
> service, so it does present more of an attack surface vs. local access.
> 
> In general, you do have to take active steps to export a filesystem,
> but if someone exports / with "crossmnt", everything mounted is
> potentially accessible. That's obviously a dumb thing to do, but people
> make mistakes, and it's possible that doing this could be part of a
> wider exploit.
> 
> I tend to think it safest to make exporting via nfsd an opt-in thing on
> a per-fs basis (along the lines of this patchset). If someone wants to
> allow access to more "exotic" filesystems, let them argue their use-
> case on the list first.

If we were starting from scratch, 100% agree.

The current situation is that these file systems appear to be exportable
(and not only via NFS). The proposal is that this facility is to be
taken away. This can easily turn into a behavior regression for someone
if we're not careful.


-- 
Chuck Lever

