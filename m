Return-Path: <linux-fsdevel+bounces-43590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A0A59204
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624711890F69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3852288FE;
	Mon, 10 Mar 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k32ocdF2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uP1ArvGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72018226556;
	Mon, 10 Mar 2025 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604086; cv=fail; b=alk59u4SRAw0XEej+yYpd3trwIJFaHHrPb/YNiZxG7di2OXlUxTDGcFi+thkoUL6MarcwGvWIFw3vxDjRX/tzi4dD+XGFM4KnNeoSXeywpx7agyxFuYzFtPQPv6ODG36cCCKY2km7Zy8xFhGBHtdPLFkUQE0Nw7/jnW4laQqJfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604086; c=relaxed/simple;
	bh=acVEvqjLSbVtCE2QbzxG7ui2OX/j5BEyr1fZfuIP9sc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IlORNU5ywIJ9lcfk5rFTIf+qgEkjL0/Ag8iVs/SZwoimCE+Qs0DknOYkwn0t6FH8U8XiUGlYibheXZUtbbiheQY3lTLkncmTKlf+secLxm16FSsltaZ62Q8ypfLYMng5HoU2yYsyI6dLzyC6IaJmhITGby6oF4EsmFsm57ooQzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k32ocdF2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uP1ArvGU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9Bdwp023293;
	Mon, 10 Mar 2025 10:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6GwFqtRTCblr3DGJBDIl+m0dD0hRxt2r8bhGFDSEcMU=; b=
	k32ocdF2aP5j3lC1UP/KiFWnj2aeTol8oVNmrEVu16qHBUx4s7p1kp7x6gOXY6Bk
	iJQ5oQkiqm9s0rX22aOo/hnw00UZMJ7UtIJvBVGyBGSbxFeb6k9FcxdX5Y9yovLF
	6gbUWg6NZJ9Tvr4+06Nnb0780jB6kREyFG22y8ucWy/22VMIk4U1uJHDrLL1N+yQ
	2KdxEVndKsOKNUBTob0xORZI9gw2zKWohloPIeW2YdwsKq/dsdNU5nkB9F+Ey1n+
	OkBQljad0nOxyDYJhfP7VeIsHYZ1WK+pvi+RMQ9x2z1OAyEGGrCCOH/GMKbk4NsB
	5RvPRdWkNQjbX8znWQl6Zg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacaa31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 10:54:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52A91ZvM022480;
	Mon, 10 Mar 2025 10:54:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmmvass-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 10:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn88VcUlyP7UAI91NZGAugUOSfKBTiw+2+xOTdOvcFjSKTwKBcNgCYB0fhkNbiZWxwxy2pQ/DqxTimo/VlNurlJ4OhUtvZ7DpRW0214NoKyB98WbPNqO2pkdYJOmR83k77RF26K42WemKjL8j6U6aXN6JjVGejQxnN/CNqjWUYGbhUcfanESb3eLFtZ1n0sOKDgS5ukvqKW12SMSgely1SkIGmvns0KOTfMojN70NPN/XiuGdg3B+XbfwLgQa0PK90FHaOmUAEatZ2KKOI2FyCJylU8MlY0v+xWpYx1lilPMCxbWuEv87YnXb23bHRRDi5Rzp3JXM3j3vyc+JIYITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GwFqtRTCblr3DGJBDIl+m0dD0hRxt2r8bhGFDSEcMU=;
 b=YLCxwWPl9kZFTO4Z7WH6B4OJ1RI9EknJBuP2SDgF08eU9+MxpG2WTy/Xsdp9OFLFniVuvRi+/l3cHfQJLvJbHtj7kUose3yIe0hnyz8fvJ4IErhmu/Mxzn4AWgIHXd0c9uSGygK54F9Ak/GHfZczF94hkrntMHd0DDA7wHXj0tkUe5r+XXzRPw/2E4ghHnP8vGsBelLRMl8NTOf95LKhpYEOq+L8YlO2xVcs+LPbLO5KOEDpHBYBZcS5st4ZpgfnFJtETtLfrL/jvGa+iVG0XCuLD6VYkxdgc9MkVYzWzOddcZWyzeozbIPbYqu9AzKbRnRc2pCHHPv4qkTQHmn44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GwFqtRTCblr3DGJBDIl+m0dD0hRxt2r8bhGFDSEcMU=;
 b=uP1ArvGU6KucDfjNsHyd5tz2hJJYDgRIHlKQjmyB2+gvboVUSZ8rlia9JeNdY7ehuVd5paGWfdZldc9BOW9TMcyDzc6rc/B9XejC1Xu7cSxN4xIvcENPDqCcfPiDxFV/6GbjZdqiaHuXRinkAVAZlwKUWgiZvGNIlA1cq3psJuA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.26; Mon, 10 Mar 2025 10:54:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 10:54:27 +0000
Message-ID: <c2fdb9bb-e360-4ece-930d-bab4354f1abf@oracle.com>
Date: Mon, 10 Mar 2025 10:54:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] xfs: Update atomic write max size
To: Carlos Maiolino <cem@kernel.org>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
 <2LEUjvzJ3RO3jyirsnti2pPKtOuVZZt-wKhzIi2mfCPwOESoN_SuN9GjHA4Iu_C4LRZQxiZ6dF__eT6u-p8CdQ==@protonmail.internalid>
 <20250303171120.2837067-12-john.g.garry@oracle.com>
 <bed7wptkueyxnjvaq4isizybxsagh7vb7nx7efcyamvtzbot5p@oqrij3ahq3vl>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <bed7wptkueyxnjvaq4isizybxsagh7vb7nx7efcyamvtzbot5p@oqrij3ahq3vl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: b6046623-16a8-4a1b-0ee5-08dd5fc1ed1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGlhRktZSTNJUUx0NTRqYlNaNUFrZW55M2NpckkwMjd1dWJtVVE5L3lXS052?=
 =?utf-8?B?MDBXd0NrQ1o1WkZBb1Y1WDJYK1FXZUs0RGZjWWJjKzRDMzJ2RE1ocWtOK0FM?=
 =?utf-8?B?T25FbS9Dd1JkTTBUZUxpQVkyQVdwdlNaYjROMm92QjFRNmZya2ZWVmE3V3Qx?=
 =?utf-8?B?YWVMTHVVVnQrdUZKWE9yWTh1OEFDNTRXWi83NjEweWk2RkVZc2lnMHZ5cC9h?=
 =?utf-8?B?Y29RNVV6ejd1R1lIRnVteHJnYytIUmxlRlMra2loU3VoeU1SRFJwWHdYS1lz?=
 =?utf-8?B?Q2ovYzV5QmlVKzZLVzBMbUlraFJMSTN6VUI2MlVtSEdqaWJLRzhyNEMvSGth?=
 =?utf-8?B?OXFHUWlkbGFudTJ5S3lyVGYyaEpXSzVRbHdSQTlEQ1RmbVo3Vmh6dDVRdjZO?=
 =?utf-8?B?RTJBM0hpK1RBa2pEbktncXQ3cTFWbWJiY1RKUVduVFJJQm1kaDF5ak42UklW?=
 =?utf-8?B?WHc1S1JUV2NvcUxrMTMxMms3RXlwck1wWlhHelVVYXI5YUV4L3lJYktDZmZX?=
 =?utf-8?B?bVh2dFZ4M3ltaTNPL2RkNS9hQlFjSDViWVpUMUc5V20rLzdpYlAxZXB6V0R0?=
 =?utf-8?B?NW5Fc0s5MnNXKzJuTkdDblpUYVdlRGQ5K2VWTFFKKy9jczlJMzl1bkVoWmti?=
 =?utf-8?B?YVBrYzVra2trazFPMTdqN3puK1hDMkYrUUZwUHoxS05xb2xNRkl4cVl6Zy9N?=
 =?utf-8?B?c1d0dzBhSTJkMzlIdERFZjQrSzNNZ2JYNUNJbG4vc3cvQVdlcTZKRHdPN3Ir?=
 =?utf-8?B?a3VvWnRHREIycFIzYjBHdGZWQmE2R2RINVJ1bW5MM0J0RGtDT0Q1eHdIN3ZR?=
 =?utf-8?B?M2lOSU5FSDMwYUNuUGhqOGZBSzI0c050ZUhCRGZsZWs2aTJVeTFIR1dEREVl?=
 =?utf-8?B?UVlRRlB1NjJFYmVBR1NuSWtFQU15eE5TUmR0OFJzWUpPZGRQVUM3dnliVVZk?=
 =?utf-8?B?WmtISTE5cDdIZGlnSzJEa2ltdmNiRElva1NOTC9Zc3g0SFAwMDlKTTJ2UWpa?=
 =?utf-8?B?UndZNFJDWUtiZ1hPQVZJRnF3S2ZNWnRlWGZTeWpWYzFtK3dZSUJOUTBnNFov?=
 =?utf-8?B?cTA3QlkyeVIxK1o2aXZYdk1aQzhHUDB0MzkyVkg0V3pIdDNPeGxwMmZuM1Vx?=
 =?utf-8?B?bDZJQk42VFRoc1lwU3JGUWJ6YmU0M01kbUpFeldkK3hneEFxL1JZa0x2aGlp?=
 =?utf-8?B?bzROYXJveTYvY2NSUE5YU05NRXRMUEpUbGF5OGpXVk41WEd0endVa0FTS01r?=
 =?utf-8?B?VUN1N1Mxd0c2MHhzUE9ZK3NsN1lWT1VpMFB4bndTRkhzUFgvc2tLbml5SEd3?=
 =?utf-8?B?T2tTTVZTbHV6RXVRQjc4Mk5jekw4a0RQNDVMbWw4V0xDYndVQnU3MmhtMmkw?=
 =?utf-8?B?V3V6STBkcFY4bWNONXZSajE4S3FQREdUWmZ0ZmZQSnJCVVl2Y3V4YzNUYUJn?=
 =?utf-8?B?eW1qMnZEV0h0bW9ycEVNL1A0Nk1TeHRQbkIydm14akhMQkV2c1lMODRPdXZq?=
 =?utf-8?B?SWJSY0RPdmFXM3FveWR2dUxKMC8rdG5WdGJaWVMva0xFb3lGN1RSVFEyRisx?=
 =?utf-8?B?NGl1endFSUJva1FSWVZ0RllKN1JXUlNvamFUZzZIblk3S0R0TGgwTXdwZHJB?=
 =?utf-8?B?TU5ibDhxMnpCZkdUQXE1M3J5emlHYjI3a0JIOUJqREpvWUgrNFVVdzUrQm9i?=
 =?utf-8?B?Z1F4WkJGdkN0ZWVZbnFKN3Nma2JGeUZmRDE1cEhYdmJmdTNhd3UyN1AzajRN?=
 =?utf-8?B?V3YwU1FKZDJjRWFwSVptbkhHYWNDUFFObFdjYzVadVRsZ0VQbU1hUzkwRFY0?=
 =?utf-8?B?RGdNQUJnVUJ5RGJITEVISks5TUlNK0VBWE1yZUFSci92RU4ydElYTGdsYlR2?=
 =?utf-8?Q?vvK83hOBo47xj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REpqZEFkQm5GVzJlMkhjSGFkNG0rblhzYytpYWFoM2RNcm1UL2ZTY0E0ZldE?=
 =?utf-8?B?eUpMWTZyQ1hCWVo5Z0I0S3ZCRWVMNmdlNmVjbkdnZWpVOVg4dnpLV2dhRW5k?=
 =?utf-8?B?RnlNbWgyanBaNjl3TXJsaS93RkUrRlE3RjB0VmZyYmlVamdabFo2ZWZPUGhu?=
 =?utf-8?B?VUk4eFROSHdJem04dFdsSlNJMVN6ME0rUnc2NWsyQVVONDgzOWZYQ0p1S0lV?=
 =?utf-8?B?MDRWQ0tYWVNMdXpOQWJpRFZrcmE5czZzTUhBNG02UmZPQ29CZ204eFl5bXAv?=
 =?utf-8?B?eEdsRHdoZVN0eHhkMmxldzBhV1d1RldxRS9GZWgza2Mvdk9wQnJsVzUvR2Ns?=
 =?utf-8?B?VGEwK3BONTJLYWZiSjAwamNwLzBTbmx4SlpuMmlFR0V2V21UVjJMLzZiYitU?=
 =?utf-8?B?dWh0aGszNHRzQUV6UmNyT1N4WEU1M1VtRjZUVmdqd0JIMmJZRU5mVWxCQ25I?=
 =?utf-8?B?Q3VtVGQwaEE0N3N3R2tKWXAyQ0U1UEZlek9qR1pzM2ZrU0dpNjZqUWIrWWtq?=
 =?utf-8?B?SVZuUU5HVUtNOTlDT0dWc2o1N1FUV1BMTmxiREYzQk5xbWhIWE9KajUzaHpS?=
 =?utf-8?B?UDEyQlRqTHdySkxxVXpabFZOZ2hBWVJSL3hFalRTRk1EVEVxVkVXRjFsVmxP?=
 =?utf-8?B?R1hGa0lTbTlpYlNsUnJ4MVlkMUFHUDN4cXN1UGtmS0RDWmxuK0lCa29PMmd4?=
 =?utf-8?B?Q0dBVkw5cTAyK0RHY05hamtEcTJIbW1FSFlUWmVWNzZUdVh1Yng3TlM2Q1U2?=
 =?utf-8?B?SEhiMkRtaXE5WUpqdG53QzNyaEtFVnVMblVXeHFtU1VCamJFajlMaGhvbVRx?=
 =?utf-8?B?UU1VdDg1QlkvempTWVloM093QzhpdytaNk5SNzBNVFdPdE1XTWZYSVg3S1F5?=
 =?utf-8?B?OEV0cXhFYUFTa2djOTh0RlRWZElFSEhJS0FHRXNOZ3JDMHNRbkhsWFJISHI4?=
 =?utf-8?B?VzBrbHR6b2hnTHZoL2ZTcEl5bmpvUDNraTlkcUlmM1orMnlIV0w5VkhxRkVR?=
 =?utf-8?B?T2czWmhBVWhLQjBzZzRhTnIzM2JvbTdXZS9jaXNkT0lUZGFuRWllWEc1dS9W?=
 =?utf-8?B?ZGRVMTR4UDJaQU1WUi9YRWh0N3hyZ01veGd5ZVR4T3QyRFRnRFhrdjlUYUpk?=
 =?utf-8?B?TFRyMDNSSDFnR0xOWWRTOC91S2VOeXo4UlhWUkc5NHVKVGFaZWhLUTZlYmJo?=
 =?utf-8?B?YldzbnhLemtlNEovS1BPcisza1pjZEczLzlCS0lQTUthTDF5MzBoODNnMlI1?=
 =?utf-8?B?ZkhkaWNTM3cvZXA1dWJIN0s1dWF1b3VkdDF2MncwZzNSbnI5WWZhZkJEWEVS?=
 =?utf-8?B?Q0ovMjVDUkU4Z2N3NWhtQ1liVUZidVY3VDROd0kva2VYakt6Wk4vL1JNajdX?=
 =?utf-8?B?U3kyZnFwaTFNcjVmMW9OODF4QWJKYS93d2ZpU1B4VkRjSVkwUFFXWldVaHhJ?=
 =?utf-8?B?NmZqaHFVQU9wMTJ0SmZyWXo3MlFOUUVNUERXbTQwQzNzWG5PcHp6bk5KeDdT?=
 =?utf-8?B?ZkkzeTNtbmJ1QTk5RmNody9tTnR1TjF5bWpBMEkwL3RUNGRmWWxOUWFBb3dU?=
 =?utf-8?B?cEhhUDRmSVN5S2lDb05YRUdiYlpjMzN6S0RQVGd6Y3NKdHVLTVg2L1ZBZzdW?=
 =?utf-8?B?WWpZVmxYdjBYNzVOWmxySGMzOTRyN1gyeUZFdDQrejFUSXhnSDE0WHdPM3Nm?=
 =?utf-8?B?aUFPM1FYdVhKd2dkZjk4WjdMTXVDeFQxa2ZDSGJVY2EvMUhvWkZoWGlMbER5?=
 =?utf-8?B?M1FNTW9tYnZLc1JjR0daNFFrbHBzdGlEWDdtTG5hT3RBMGR5c0I5NTFNOXhv?=
 =?utf-8?B?a284dEF4UjVyY0YrNmxlNFhyeEhyUHA2NVQ3UWlidHlzZC9tQjFvTXlsQkor?=
 =?utf-8?B?aHl0M0xMU0UrbWFadUFOS3ZNc0lSNmViZysxQW80MUU0VGNOZ0hDWFI0Vy9V?=
 =?utf-8?B?NTE3MnZKR3BLanU0ZUhXVndZOWIwZXdKZTdDVU03NEZ5UFNoZ0NGamhhZmdj?=
 =?utf-8?B?NEw5clJKZVdPQnBrYzQ5OVV1bXNZNFFVaU1XMUh6NHgyc3lzNm0rRUlSNEtE?=
 =?utf-8?B?M0srTFRCeWNGWHozNE9zOEtoR1RrM2F6WEZ1OElVK0o3Ymltb1dkN1ZwanQr?=
 =?utf-8?B?L2hyelYwSkQvdFN6UExFZEsyZGJIMzZVekZLVEw5amZuVzQwVEp4a29TeGYx?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gPrF4lOf8z8ijtYAH7CSh+qaRlCztl3MdM1AB+91I8zR5Pw7IituJuTzHcFA4jhv5jU5AiE50b+ZLB64uEaneduHVsLtU8m0afGFbZaNJynQXkyQyvoVAhQ9gWwxDwoDtxN3Cnh3coWxWir8Bcz1/kagjBG2J2roJ6wLoO4bR45FJTyNYUajt+oQ7wNsfxUiOZsOsvjozjTpmI7TKAmb15+1dPa0tNx04DmTjpCSlskdIbCHnqw0CCizj9IyiWEoomiLKQoeqSLjFG9dQ9mmZsyDXFYP/eR2JdctaBe3//GCQNfqbnQ6IhN+9/5IT+XKNvm1pCVqkI7OzYMH02TnzU0jsSo+PPHKoKEc+K0E6XlWLgjh9dXSfB1+Nb+2BdDjPaeH0V63c2T4sDpS7435mkxMHmCP/HU1MjzV4p1zHFixLGMzz0D+AMQoSUyvjSmrZ9v4WXmzYVu+7iau8JgX+MPaMKV2MVmEXSskuOtir54kslN6ZgX/ibKsNV8GwOXZmRDmB1ONPs6t5PtK+kvzMlHJ5ulOs7E4gW+9+fLowEVBYfAPcl7xh7ZdW5AO8SMSm8Oa2jHlAvPFRdWqSMcUiIe/MP3/cubn04sQav4aXpY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6046623-16a8-4a1b-0ee5-08dd5fc1ed1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:54:27.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4G25iZ4UhD8Gyi1g8GRlCQeQNyF5ElQwyVhYMrFnvUu/1Ll+Je7AtUIDcrqVd+ZLjQm9KD6LBB3gkoG8wwsGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100086
X-Proofpoint-ORIG-GUID: Dbtvh78agNu2IEMbqCmraIgo-luurMtl
X-Proofpoint-GUID: Dbtvh78agNu2IEMbqCmraIgo-luurMtl

On 10/03/2025 10:06, Carlos Maiolino wrote:
>> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
>> index fbed172d6770..bc96b8214173 100644
>> --- a/fs/xfs/xfs_mount.h
>> +++ b/fs/xfs/xfs_mount.h
>> @@ -198,6 +198,7 @@ typedef struct xfs_mount {
>>   	bool			m_fail_unmount;
>>   	bool			m_finobt_nores; /* no per-AG finobt resv. */
>>   	bool			m_update_sb;	/* sb needs update in mount */
>> +	xfs_extlen_t		awu_max;	/* data device max atomic write */
> Could you please rename this to something else? All fields within xfs_mount
> follows the same pattern m_<name>. Perhaps m_awu_max?

Fine, but I think I then need to deal with spilling multiple lines to 
accommodate a proper comment.

> 
> I was going to send a patch replacing it once I had this merged, but giving
> Dave's new comments, and the conflicts with zoned devices, you'll need to send a
> V5, so, please include this change if nobody else has any objections on keeping
> the xfs_mount naming convention.

What branch do you want me to send this against?

Thanks,
John


