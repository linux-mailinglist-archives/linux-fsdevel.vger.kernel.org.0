Return-Path: <linux-fsdevel+bounces-60720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A048EB5066F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 21:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339BA1C2724A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE69303CBD;
	Tue,  9 Sep 2025 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DStAxSiX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v8vk25eO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB12DAFBB;
	Tue,  9 Sep 2025 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446379; cv=fail; b=lDpCtUq7eACGI/iaP5z2fd3eXqJ7pEOLXQVjt71WMwwSehGmopYJyZUfG51U/K81DPgLZo8i67gNp2sb/8b7jlfrGQGxVbE8Y7v1/1ezTggBkg2qQrjFzORHFaYRKWxorAwp0GiToO/HaKq6Mf2pvak8ri+fWE+kPnIYQNFnmhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446379; c=relaxed/simple;
	bh=f4Nus2kbnTAGLxmbliIEcypuyCTo1tY7Ir81WZ88P0A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKEFHTtBAZaiyzJaBpPPnLWBhUrk8sksQORmrhxfuNcpQETXh5EpOVFayOyGVPRzr10mL8m9KGkLLe6MQb9QMYuZSJ8bMbL/oCHM6l4hx6nDVBAjhslomuANf9cFlVNs760E6dWfbApPsnupIoNXE0gQrQALNC4EVm0F3AfCiHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DStAxSiX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v8vk25eO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589JNSdR012687;
	Tue, 9 Sep 2025 19:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pNmlz2tk4Po+9ksMb5OAn+blO8E2ktJbu3Sn2InwttA=; b=
	DStAxSiXhL5JfsAfiyM1D9EAomt0tO9JEM4IOtsU1Q26+D2TK1GAzYiZP6o2GXJh
	dDb/IhJW2VERrPibN4TtqetYVknp2cYKHu3dz5PB4LrEPIp7OhsRkHnX6cGdUQss
	kAmnoG54kd/XOn2iaD3ZaRMU5t99q4tf5wRAmAp0HtOmnNDE23IICq2hSy5HB8Ql
	akQqjR6KBeVQeLoXm2AuwFdLZiVsr6jbhDdMYfqow5tW2IwGYZ7vrtjKTOdv7eqk
	wzzVmbAORlfj3PdTBnH90ksCm3j8T0Z/QnJLNZlJxT9tIhbPPtyUXl8cdg7nf4n/
	QGburzprIKGJqorA9EyIPQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226stq4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:32:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589HmSI2038972;
	Tue, 9 Sep 2025 19:32:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bda2j8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 19:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7BwKyhAjc/8V+o9LI8FsKbQwshCT8gmkSz540azZcnGPaRP68fkPSlh+3fxq6Wk6gD3wch3Ipk26M7CaihCiFkMmGS9hzWG1HChLzYiTT75RIyfkbX/euYI1Ra1KuY6YrTvuryBM4IMHWuc+2KzWkaKldyNSoqvu0uNZ1Id494/khazdA6g8QVj2WI6Qcjh2R9v2z/2kNWeJuXBsQ4TlmpXBhsMejME5hlG8H78fZLAwHAwAUFTfwqDXTjoyWY+bolTs42m3ADTkHVK5A7KQWP7MeutVEGvE4ZWF3OTKwYiL4f1u9maHhL8zgy7KEgmnZ1/5gVcTjttFqgO/f1BOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNmlz2tk4Po+9ksMb5OAn+blO8E2ktJbu3Sn2InwttA=;
 b=M2QLBLzDKjMQiOmzkIgACfYIqC7Bw6qdrpWK50tZIZJ2Xvue1ZSaDf6hXK5gjwNIPdNgX3WJ0PE29XE0mteJ6MJe73IU5qnZT0ZDS2EIy8z7siOWfOTG3WQQhKm3u0FkU7NWhRp30JvWxduwg11do2HOWeB29sDsx1teTDJD/IKtionolRqu4xUckWTmkAschiiMXLfeCCF8pxOm7R5CPhCz+1ZqDB4u2e3mpWJ07tq/x2ZpWI/vFSBnaWkyuH4LAVXuI5LGRB9oyZWMD0i/ONp3veNx0QsHRPNMy77iDClY7IRG3SUXXVkkqctQFZxSCcQdkxTJlhi3Oj8H6kZmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNmlz2tk4Po+9ksMb5OAn+blO8E2ktJbu3Sn2InwttA=;
 b=v8vk25eOBXLGYbOb4Rt/+r9x2RApL3YgumyPGTMgLkOIOlZ7ejrXQ6Zq/Y5pl7syRNdtXTDrmaKSsiCcXQzZePAu4B+iT5cHkR3nVCjSLfZsg2PSepHGM374ZdMZMFnvvhvxl7HyHs1U0PI0htufqTXdpAwDyEBhKeQQw0atbEw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7528.namprd10.prod.outlook.com (2603:10b6:8:184::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 19:32:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 19:32:53 +0000
Message-ID: <47ece316-6ca6-4d5d-9826-08bb793a7361@oracle.com>
Date: Tue, 9 Sep 2025 15:32:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: Cedric Blancher <cedric.blancher@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
 <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
 <e1ca19a0-ab61-453f-9aea-ede6537ce9da@oracle.com>
 <CALXu0Uc9WGU8QfKwuLHMvNrq3oAftV+41K5vbGSkDrbXJftbPw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALXu0Uc9WGU8QfKwuLHMvNrq3oAftV+41K5vbGSkDrbXJftbPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:610:e4::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e704eff-5a8c-494d-7a9a-08ddefd7ab68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3VxNGhCRUZIZTNpQW5mMVMrWXVGWkF2M1FhYmlNMFJlSHN0ZWhUTFVFQk12?=
 =?utf-8?B?UWYweko5YVNrU1huZ3UzODAyOUUrdDViQlhZNnZuaDF5UjkybWhFU0JJaEZ3?=
 =?utf-8?B?NE1vSkY0dmY4a2tlcWVUOHp2aE5BQ2IwMDZKRGoyUGtWcjBwLzNTQ0dtYnF6?=
 =?utf-8?B?YmNSSkQ0ZHhFVndnWDBiQlpIK0Fid2duRVprMDg5cFJqRWlqTzBiZG0reWh1?=
 =?utf-8?B?ZjBldGRpMWFQL1hpS1I5bHVCRjU5Vi9MaXRiOGJtNm95QzRBaVU3d1Q5aGNt?=
 =?utf-8?B?cmRRZVAza3p0VzlXN290Z1Fuc3pGdUtsVVN2cHZBY0llWmE1MFRYcm1WTURE?=
 =?utf-8?B?L0I3WHRGb2lCeUwxKzE3Q3VwZEZBVG5UNDRkTG1JMk5lc09xVi9ER01YQjRN?=
 =?utf-8?B?ZUVXK1Zrd29jbUNRdUl6NGk5Z0luUENmRE1WZmlyUDl5UmtkUE1NU2tYbWE4?=
 =?utf-8?B?blJtSnRHZDBTRlRyYlRiNDFBU1dyWDJISEM4cm5JMXEzNjhBL1VKclZzNTFN?=
 =?utf-8?B?RGFHY3luUWdHemN5bG9ZeTRpSWQvY1N3bWd3N1FWZnJ6dy9xaWJXVEFVTUJD?=
 =?utf-8?B?TGhVVkZRbS9wdU5uUklsazh6VnZOcnN3SHNPQUY1alc0K3EwMGlrZ0ZxY1pH?=
 =?utf-8?B?akJqTlJJcU5teXNpTmd6UW9Dd2FOcGhGVkpUbVdVZVNodUNaU243N2lieFls?=
 =?utf-8?B?TnRCcG9FVldsWCthQlZNVnNYUjdBZm9mV0RmRFgwd0x6aHBVaFpoalAxUnZl?=
 =?utf-8?B?QldqZDY3Vy81eEF4NlVKemtOSDNqcEtWdXRFZ0FudmJLemk2TVRHRFlKUnRq?=
 =?utf-8?B?Mk5xT3JyN3Z6WGR3MmJBZzRuell2Tzg5N1c5VmJwSTdSUFI0alBOOFRoUzZF?=
 =?utf-8?B?WnZOWVpPL0k2QVRlT3lzbkFZbk44UnBNSlp6bGNvYStGYjYxc1pVbGIvQXlh?=
 =?utf-8?B?d3JBcGxXcENGSFFLTU9sbytYc2ozMDJDK1VJNjZRcWdvenBVVS9aeU1McW1s?=
 =?utf-8?B?cVI5WU04R01RYWdETHdMTGhIWUlpWTFscGE2OEljUE13azY2VFVQc2N3L1N4?=
 =?utf-8?B?OG1CVitFRmlQb1p3VmpWOUpYd0V5L1pneUhMSnJGcEtaMnJrb1Frc1F1SGQz?=
 =?utf-8?B?TUk4UFFMalg2Uy9DNG42U1lwSndHWHQxTzB6MTJOTHR1YjVRcTNNM0h2bVYv?=
 =?utf-8?B?dkhiemdlL0tjOVF0a05yblRNcEN6TXFPOUdyS2NzSGtkZFEzUExUc3MwakY5?=
 =?utf-8?B?eGVJVkhpeXFSeXNGdzZ3cWxIS0tFT2lray9RRWdyTlBUUWlOOUUxZytPdFYr?=
 =?utf-8?B?aVViUEhMTlJFQnhpaTZvanNIUk12UWxlWXFqYXdLa3JYZCtmTWZrMHpiTWdY?=
 =?utf-8?B?b256ZFJWZzhNMkxOTmovalRIUTVxNmpYdDc3QmdqUEkrMVF2STluaG1hSGNP?=
 =?utf-8?B?MWwzTVR5T012aWl2OThUWHlodkFZZkphNjBJeTBlREROaGJHMCtKUTNkK2Nk?=
 =?utf-8?B?WDRITUZCM2JxdlR2dXQ2dFhOT0hlSVdJTXROamQ2aG9qcmRhTzZJUjZZeE1t?=
 =?utf-8?B?eEgrZVRQSGpQZ1g3SEd5c09OYmhWbHZqTlpBTzQ5cXNwejF3N1RvTU9mUDNI?=
 =?utf-8?B?dS9uRkh5clU1eCszZ0xYVURySitZTzFXNjV3U0oweEtHMXVHVTNFMWdHQ2Zj?=
 =?utf-8?B?NXl1U0cxaFhCK1RDVHJHbU1BTk5JQzhCQVExNjZPVE9OWm9lL2M0QTdDNDh4?=
 =?utf-8?B?UGVvUlQyTmVUNUNYTlpuU0xPMlh4QnZGVUNZWlk2K3BsSEhPL3NpcGhiVktw?=
 =?utf-8?B?NzBBbThRcWNzVEMzcVRPcnVrV3ZCZXA0dnZDZFZ6QU04TkY5MjIwMDllYVow?=
 =?utf-8?B?Y2ZteUR3aWtRWHkyVTlhaVRRdHAyRnE0SlZGZThlTnIvVDFTdWxNYlNueU9u?=
 =?utf-8?Q?rrprji0iKEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmtnZWN0MUo1UkVKdTJuSUZSWUFhWnEzYXpHMC9tWjdsc1JjTDZxSklTdGFZ?=
 =?utf-8?B?UnVub2s2d2RkYTkycEJ0Zm1seFBhejhtMHA5QVo5UUtvcEhCdUJrM21aY3lT?=
 =?utf-8?B?c2ZFcU50K2N2cXZpcFpMalcyU0d2Wkp1a1U3TlB1T2tsVUVPNEVUSlN3RXVs?=
 =?utf-8?B?VHNmN2NmZC9pM2IxR0YrNUNYRGx4MExmZFZVL1VTQ21oekE2T1pCTUJwcm5z?=
 =?utf-8?B?dkVKeGhWNVdCSGNvU1FjUzB1ZXcwL1VNOVFNdGx6WmVkYmRMWmdXZWlVKzNv?=
 =?utf-8?B?c2JYV1NlUysrTUpzOE5LVk9BcnA2eXJqaThPbGw2T21KeVFoUVV1WDc1bEpy?=
 =?utf-8?B?OG1id0NLVW5mSCtEa3RBQnhBeXBmdXFlT3BpKzcxeTRmWW0rVk1wb1M4eStm?=
 =?utf-8?B?bi9pZWNtRmxiRjRWWVVEeUdCczRnSkRENUtzZFNsc0tqMFMrTHZHQkRVUG1E?=
 =?utf-8?B?Vm1VTkpwSU1vQjVxdmIxL2s0c3lYMVdNR0lLU2pHbmYxbUVpTHIwWnFLN0pq?=
 =?utf-8?B?ZGl6dzBtSVR6L2dPMmk0WXBod0J0TUJtOG5URk1lY0pUSWxPa1VyQy9NWkEr?=
 =?utf-8?B?dkNwZGJ1eGRmMFVlMEQxNVlGK0NrMy9PMzRNWG1jRmI4dHFleGhrbWpheHA1?=
 =?utf-8?B?OWFZMm5tV3VESlRHenVXWnB2SGZjV2pVNERES3psUWNrcGYxRlpzUVdSclcw?=
 =?utf-8?B?N0x3TFdVWWdWUTcvaXFFSHBwY2RlT0hvQUdvbmY5L0J3OXhPQjZVTDdrSUR3?=
 =?utf-8?B?cmYxNkcxaXRJVzB5RWpLamlPNFVyeVJyMTJQeEo4WXBtQjJMOTl4d2ZpN1la?=
 =?utf-8?B?UjdjUXMyTXNyOVdpdUdoMVk0ZmdFd2ZCTm9ORzZxSUc0RTcxQkVJamRKakFr?=
 =?utf-8?B?eVo2TlU4ZWozdWFudXpUamJ2TG9oNXQ4Nk1hdHh3RGsyNTZjUFIyVlBZV2ll?=
 =?utf-8?B?bmYweGtVTXJpblpvZU1EekxjSkYyK3FqdEIxaU9VUkZENHVFTGdVb1FHUnM0?=
 =?utf-8?B?UW03OVRobVV3V1NPa2F5djE0OElWWEtoUVBVS0s4WXFPVURsMjYvaHBNR2ZM?=
 =?utf-8?B?ckFaN0ptakx4ZHV3V0xqY0RnZ2lPYXQ1d0ZKaTdrQ3lSQlVrcGtxaXFBWUVC?=
 =?utf-8?B?d0JJSCtUVE52YlNDemFIZ1A0eDJDT25xZ0hWZWxwRUVWV2RsOFpyRUI1UzZI?=
 =?utf-8?B?T2NINnE5QjU1alVmdXVtNXRnVlF2bm1MaWQ5a09jcGt6cWZUblZ5QXVFalEy?=
 =?utf-8?B?MlpYZys0RlVBTTFzRDlNNDNJRTU1Z0l4alVNMUJsZDIxS3l5aDNCVE16MEEz?=
 =?utf-8?B?Ylhoa3creFhPRUJ5b29JTXU4SDRIaTZlZG93UkdPM2syVkpOSzhWWkhDczVX?=
 =?utf-8?B?SlBTOURjNmR0dlFzYjJUVzJTMEo4TlVBK1Vwa3djMU5QY2hNU1VKeFN6QVIw?=
 =?utf-8?B?T2ZpcWkyc3NxS0lTVUN6blJoeW9wY1VWYXVGTXRjSFpRVjVzTWdGZmtra3Qr?=
 =?utf-8?B?ZG5hRUhlcVZLWUdTcXY2cWtrOTFsZFpqZFd1Ti9sb1JuRHZleFRWN0wzaVBj?=
 =?utf-8?B?YktTTGhYN0xPZkZFQlFRTmVhZzlLMElRL3dtZTd0bE9NYzRXdUtkS21CdmlW?=
 =?utf-8?B?ZHA1enJQN1E2R3daYXN1NkZIaXNCa1N6U2Y0bWpOZGRUMWtsU2FsS1I4UWhp?=
 =?utf-8?B?THpaZ3pDMlpqNldmZnJnemQxL2xuUFFXNzJtUWVnVmlaWVVsbGtzZkFtekhm?=
 =?utf-8?B?dzFVWXhvc2plODhKOFRpelprNUJTTzh2clZ1SC9PVjRod1dlS1lHbk8rMU1P?=
 =?utf-8?B?VDdSSFJ2UmxBR0ZlbVU2UEpaTDgzL2VaMVhQMzZXOFc1ZTJkWWpEanJndDNo?=
 =?utf-8?B?N3IyNDl4cmFORmhrSmptK2RjbUlPcEsxWlllbklIQUtUS3h2anZSc28xdzlJ?=
 =?utf-8?B?a3RIR1pJbTdOb2hyZkxsRHFyNGxvWUJaTWZ6MVlRVjlGT01Wd3F6MEVMTDFt?=
 =?utf-8?B?UGVQR2E2cWlRemt2QTcyNEFPNWMzYlhhcHNDMjRTZnlhcHM2NGNrWmE1UVp3?=
 =?utf-8?B?UWJrdDNWYXBUQVZrdzIxbFRYZG9jTVZBZTluU2JpOXZnS3lqcUhzenJITUJz?=
 =?utf-8?Q?HPtXy3DIdebaY3bEHXT8LvzqI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KsFZke5vOLwb7hqsb/VgsVPGqxNn2RuoO5SpaH0tzvHTpEfTlrseYevdHgeFrpsaQYfIs+EXgCfFGzPIcZTwYDZEHTps/+twm4DtpJXhcZPnHWYvvGTlJeqXEDzJirRXfCr5mC5cmv9XvvL6XFBzESy32deSXWBhfcL2MrGGwGqkrcnIHeN0dz+QiW3Lc+gd8wUtMbp1CRu65XmCL1Y4yuZtJqVtMQ3/0w3yp4smYEtFiFwbLe6M5lRaJnugKn5QGndDPtkwL2NindS1a5RzrVy8TTq1w9sI79I1W/0QdbYSBIths8JWKJfXVpxNzIYZh0MwvyAABjN+SJq/7k7Pn+xXynUIXEQxy6wRROfO1eDJY0ihXbaqUXfgPr6VRFdM90oW9nHcO2U9zbjL+60WuJ/NGCtEOUT2PD+whAQQDWRZEhK66OhLk3cg4nlpl1xGQD5YM7FYFjzz44PvY5BcmTJKZ2wnJCirxHd6Ss31QX9ZlnuEt/OjJAnKg1jb0olx4NybGYK+E9ntGvJ2lljZ4xZXi9aO0jOwnRJEXKqk2TdMnU87Hnx/Hv2WUj4VvnchW07+XZ5ehJRCHcv357ILiAtl3dfg6/eFb8/XAuh32Xw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e704eff-5a8c-494d-7a9a-08ddefd7ab68
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 19:32:53.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qDHYpv4mfxpC8zOmFcbI7/Y2W37vtu8FeDQr/YqK9OL8Qr9dyZC0f38cqWZn1D2TCDahed0BjVZIdpJJWF53A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090192
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c080e7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=g-TqIU0Pu0-rawpN_J8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: 2M82T14lAanhUrLOnCFDPjEj7A9nTqHx
X-Proofpoint-GUID: 2M82T14lAanhUrLOnCFDPjEj7A9nTqHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfXzQKzPXnx3WOa
 0qDblA5b5OdBgMPdMlX2flglqpfKA7joYEkpSaeFN32tDvV89AA8twhOhn8HL/iAYgyoTMDdgDC
 UKEtlfAqXrk6bSHY5VLnORbkigjmap8Ea8cw2I9vVwPkVUo9TT9j0C3bFeHhTm73lExSPQ7sTwm
 1jQTqISKWS6m+RtTYxfBhzUZh3sT9LFIRPAH18IUo/Ti9NreGYcaoT4PYDyWDpmnDnDUSltOX4L
 Yark1k8/+mPEXI0aNOplJLR3kblZRYzdwHHkVtPQ6o8P/edvOYNy4y5DBdsiYf5mDkFvA6X6wWe
 NAbL0Nv8XFiCCm3/em4tqOb7v3DZeBE8cTRVlgD+JHIGkyS46+PydkirYS3rehIYyy3wwelnwvJ
 Xzeip/SSDGmWuyWqQWgwtgIQ0+Xp+A==

On 9/9/25 12:33 PM, Cedric Blancher wrote:
> On Tue, 9 Sept 2025 at 18:12, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 9/9/25 12:06 PM, Cedric Blancher wrote:
>>> Due lack of a VFS interface and the urgend use case of needing to
>>> export a case-insensitive filesystem via NFSv4.x, could we please get
>>> two /etc/exports options, one setting the case-insensitive boolean
>>> (true, false, get-default-from-fs) and one for case-preserving (true,
>>> false, get-default-from-fs)?
>>>
>>> So far LInux nfsd does the WRONG thing here, and exports even
>>> case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
>>> server does it correctly.

As always, I encourage you to, first, prototype in NFSD the hard-coding
of these settings as returned to NFS clients to see if that does what
you really need with Linux-native file systems.


>> Hi Cedric,
>>
>> Can you send a pointer to some documentation for the Windows NFSv4.1
>> implementation of this feature?
> 
> That is just ON by default for the Windows NFSv4.1 server if you
> export NTFS, and OFF by default for DVDs.
> We never had to change it.
> 
> https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/nfsadmin
> explains a bit of it, but for Windows Server 2022 and 2025 it's a bit
> different. Part of the more interesting docs are behind a
> paywall/Microsoft login.

The feature is comprised of these three configuration options:


translationfile=<file> - Specifies a file containing mapping information
for replacing characters in the names of files when moving them from
Windows-based to UNIX-based file systems. If file is not specified, then
file name character translation is disabled. If the value of
translationfile is changed, you must restart the server for the change
to take effect.

casesensitivelookups={yes|no} - Specifies whether directory lookups are
case sensitive (require exact matching of character case).
You must also disable Windows kernel case-insensitivity to support
case-sensitive file names. To support case-sensitivity, change the DWord
value of the registry key, HKLM\SYSTEM\CurrentControlSet\Control\Session
Manager\kernel, to 0.

ntfscase={lower|upper|preserve} - Specifies whether the case of
characters in the names of files in the NTFS file system will be
returned in lowercase, uppercase, or in the form stored in the
directory. The default setting is preserve. This setting can't be
changed if casesensitivelookups is set to yes.


Sounds like there is more going on than just setting an export option. I
will need to hunt down a Microsoft NFS developer to find out how much
the shared file system is involved in handling internal filename
resolution. I'm at SDC next week, there should be one or two there.


-- 
Chuck Lever

