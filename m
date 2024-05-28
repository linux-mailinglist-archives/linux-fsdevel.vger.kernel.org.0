Return-Path: <linux-fsdevel+bounces-20337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EA8D1922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7EB288FBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D573216C455;
	Tue, 28 May 2024 11:09:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B113E039;
	Tue, 28 May 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894574; cv=fail; b=OImM6wK+BaFHQjhXZexv41MF+BL1FH1FXaF3tNjKPO5xEpluHTYq3ar2YF82Hilkwxp+1QAb1TEFvsrGnammK4z7J5yznITt0Bq2vMPn6KRTKspG6dPYT9lAg377JJ9z8IEohM8DDs200Holf4/6LkIVMSZu6N3oWJ7d+fD7K9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894574; c=relaxed/simple;
	bh=+ny/DxeIfcLAY1nG5YvT2ZYMqQaqzbuSvpG4ggEv0vA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tXs65YRXeQiETjolfynVkqratqLW7hXeYbgpXFVsB07tHFTxECt+7cmZhSl8tTFjylLTAMv8idDX9O14PGVgIJXiUc11vfieJ3LYun6Pcpqvpzyi7OVM4Drsa1bLMgMfRNVz5DhFgZMwnzKQuFagnDluEqrNJgyLeKHRqzGqIUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44S7xHoC003476;
	Tue, 28 May 2024 11:09:17 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DcuY5/1wM2KWvOgpMHx7qyelT1QbiE0LvxX6O+e3xnYI=3D;_b?=
 =?UTF-8?Q?=3DgKo5U1sFZeqwP7UVz/Q0zFWHFRIIIIo7eWJ7R2s3+M4/0PM8rsi0sSgVHRzx?=
 =?UTF-8?Q?3EXk2lHY_x3dQkFL95uvYB178bSsvnC5PKwqbrMxhvcyYZN7ngoKVCrcUXuwR2d?=
 =?UTF-8?Q?g5fb7j7kD+EHh5_3lntKofo6wZRSqYwFEycx6V5Vv9TRzge/Obh5JEp/IbX2pLM?=
 =?UTF-8?Q?GvaZXqIzRwo/1BsVbFan_pzLG3n+aVKyyf1WMFC0YUGlBve+vfz0P6IrAjhBMpp?=
 =?UTF-8?Q?FLhvcLoEPXRb70rAHWdUoitwTJ_n0/s8FcN4gpMMPQZOrW6zNk5D6R6NhDr2D0j?=
 =?UTF-8?Q?7iS9Aa95sp5wiD1SYBhbcMrTTKZlt3Ok_yA=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9m39w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 11:09:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SB1Xgj036785;
	Tue, 28 May 2024 11:09:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50wqm2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 11:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht9AHqbK5nWXZ4FJClSG5v1xDfIwiVuVfqfAi9VMSj/RhkCKBAe0FxpkzZ3cfEq8GoQiP09i70ekIqsYc6fGlS6JUDhcrCqZQFm/uWtdK7Ca5eoqlbveyBWpwfMmqwM5asyOtFaibIvQ4UIlHI1RA6dR1S+ESra+z381A1St4bG1hGVMoAraSPG9UHk8bw+t/7HvSJXFHeTc+zVRfDX/pqWTt7Tq8wTzll8py5XywDv2ZkMhbrnwuGDUY+sPVyUNIXmqrSctclbNAi/ZdcsnmJhEY028XLWwOtj8ns5gh34zQJzTCbzJWX0dGgVk2cBrUomPzoWU7QaA/TeqVaWr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuY5/1wM2KWvOgpMHx7qyelT1QbiE0LvxX6O+e3xnYI=;
 b=bflzRcj4TlcheCAAe07zSPMEKT2h/OnmzZV6T5GL0SjTQ8qNSk2cIln+/WtXzoTbNSx5TmGcN8RKMqI7BPpHANTji3gfggUEBUpwXzEDyAS9BSw4y44qbLN1+Rn3sedF5+erxcqbjEwz1I663BmqPv3kpH/Bgsfhib3n2zZdIeovFXPxZbl9ciWONXcMNNh+pgApMbvRLkAFAE7bB9dpD7PeO4gjoP41o5LJEZbQ5pFEyrhACL+O4inbFTwuR3R7ekKP+NdQmhCnAq3S2P/KgmXESFIqovda2ZYsIKfT+uDHcNd27NO8QxQLLdBVJxDoYFTOCEG7OYTP+1gsppQdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuY5/1wM2KWvOgpMHx7qyelT1QbiE0LvxX6O+e3xnYI=;
 b=aKt6i9ugFObw60haHq2wCq+CLGRCTz5bLg3f2+1ZxJyOIGGhcpiY75wigXxaP5Lb8Vs7/vq3dB72l0uRtsstOzdosmYaGZrrD/8RjdThj8KDxP+LIJrVscADBOWOsK6lHfVgxnCPqwnopvm4CZZMyTFZAnoZ5Dkl+RFLaWOrmps=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Tue, 28 May
 2024 11:09:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 11:09:14 +0000
Message-ID: <0b65cccc-b39a-4121-ac0d-52d49c85632b@oracle.com>
Date: Tue, 28 May 2024 12:09:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
References: <20240228061257.GA106651@mit.edu>
 <9e230104-4fb8-44f1-ae5a-a940f69b8d45@oracle.com>
 <Zk89vBVAeny6v13q@infradead.org>
 <4c68c88d-496c-4294-95a8-d2384d380fd3@oracle.com>
 <ZlW4o4O9saBw5Xjr@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZlW4o4O9saBw5Xjr@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd700ad-f0f4-486e-41e0-08dc7f069bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UVFHTjFuTmdqbTRob3dpM3V0TnJ6aFlFelNLMWN0ZmY5RU9oWkxNUng5Zjlm?=
 =?utf-8?B?QXhaWjQ3azk1WEhqa1pGbTVNVjV1OFhFOFhRQWJrWFV5SG9DcjA4ekFVamRS?=
 =?utf-8?B?NWVoSGRZUnJScmQzTStPQTUyQWdySmhhZVkwK0dFdmdyc0cxRWZVL3YzQWZn?=
 =?utf-8?B?bWRyMnhSZmhMNzFoV0t4UER5Z1daQXhldVVsbEd2SHNXSTEraVZKUm9kcTdG?=
 =?utf-8?B?cFk1U0lpNzc3Z3kyZGg0U0FTbXgrWFpISTMwM0s2WG9vOGJJb2UxTXdjbFQr?=
 =?utf-8?B?bE1KZE5Ram91eEpJVVA5SVJPL1g2cUxPQ01OUWpMdTZoSDlMcEFUekFrdVYx?=
 =?utf-8?B?S3FLR2ZoSlVpa2Q3SW5SZnZ5Wi9OVnFpVUJkUWpoV2JjVkJiTXNJamdXaVQz?=
 =?utf-8?B?d1h2dkNNVFVjWkg0bnpndnd1bUlST3IzSjBGTWljRHB6ZEV0aCtpUjV5Skh6?=
 =?utf-8?B?RURIWlUzbkZPSFpaVnZsTmZHWGVhNGpXdzlaOGhaT1I1c0swZUdhaFVIcnFD?=
 =?utf-8?B?TC82aVRQMFVnTW9BQ1hJakV5MXRRU05scUhMeHFPOVhPaW5MaVpCeFhXKzk0?=
 =?utf-8?B?YldUOVhia0RxNG1GYzg4Tkh6eDZHMFNKaGtoelp4dHFtNk1ZUFFVWkNRbFo2?=
 =?utf-8?B?T1NGQzJXQzNlWmxNWWdjUUlZaTZSSDJjWDZwVWZUM2pReVhjY2xDMTU5aHBh?=
 =?utf-8?B?RTFhNm9yaE0rSVY2T2tIaFpGRG9CTFY3QjlRTXJseHFGd3hYbHZIQ2NmeThS?=
 =?utf-8?B?QU5la09SMDB6V3hKcTdBNHh5NmUxR20wSXY2WkpMbnNtdGNSY2FBTGErZW9G?=
 =?utf-8?B?VWt0L3BJZ2hNZGpPUlpPOUQraDNKc1NpeGx1TmVvcjVQL0RndWNSYjkxRE8x?=
 =?utf-8?B?ZlRMS0szcjZXRkZUanRwZzFmUVNxZGhXaGdXR3k0d2xSZjNoWFI4QzJVeFRl?=
 =?utf-8?B?RENCamU3bmpwdnVrakFESlQ2M3RONTZRcmE5VGt5dE4reVFlR2x0STlNejRa?=
 =?utf-8?B?Y1QxZjRSMjJCNFhESzFqcCtvekpleUdKTys1SXk4Z2FIaUc2MlFYOG12NDcz?=
 =?utf-8?B?RkY1UFdpWCtaZ2pOTnBsUnpKSU1HT1E4SnhNeW5uSFNhVE5WR292UWdJcGNS?=
 =?utf-8?B?dWlkaU5TMksrLzdkcHlwTkJCWVQySUJRMWJ0Z1Vad25GTEFNeFJUbHduZUd1?=
 =?utf-8?B?ZGl5RFprZmlSNG5xM2dMQ0ROdjlRWkJXMGYyVEdwWlBPbWIyZHRibmlZS01I?=
 =?utf-8?B?NVZQRHp5cXk4em9RNjEwSXMwOU1Nd2RjQXJoOGZYeXdQY0tqQjJGVlJReG0x?=
 =?utf-8?B?QXNhV3FudnltaVRwWjN0NHRmdHdjaFcyTWhJNHJZN2lYSFl6VEU2UHNFTUR6?=
 =?utf-8?B?ano0VFRRZGlPTGtzRmYwK2pBZDdSTnNvQXlKTEhDSVdrOHVaeFl2RFJvQW5z?=
 =?utf-8?B?ZDhteklLRVVLNXpCTEQwRkZIUGg3TkhzUkQzbHV5YzBJYWpYdTVkc0RicEJr?=
 =?utf-8?B?Q3hFZ1Fyb0g1VG13bUtZUk1TTm1tWWZKSWxWWXM5eHVFVGppaWhJMXNqcUow?=
 =?utf-8?B?R01ZU2Rid3NkL0pMVDJGRjVlNTBKMWVSOTFuWVpXMXJWa3cwTXFNYnErNmNT?=
 =?utf-8?B?Q3JWUEVWTUtQNHIyTXdjK1pHWXRFTkRVS2NHT2plTEVVY2NOTmx5UFlXYVFn?=
 =?utf-8?B?MWRzYytweXgzZWo3b01selU0SVFuakFMeDN3Mk1kTmVzUmxLSmpNNkRRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YmpTT3FLNW13SGUzZW14emxQdGxmQVBVVVA4MzJsZEUwMkNzTlhSRlVKZDRm?=
 =?utf-8?B?WStUOTcvYksySUFnVERiVFhSNDBTVE5WUzhWZHVyZjdmVHlTQTQveTRWZTlZ?=
 =?utf-8?B?TnJXSkQ2VVJ5eUZrbDZ2VWdUK1YydTZ2RGUwNHNCZW5BcVhCZDVRaFY1RW1Z?=
 =?utf-8?B?eHZpQktTYUIwbXROeCtQSFY1VDc4QzNMbVpkTkhuUzBiVHRpVzZ3K1RwUXNN?=
 =?utf-8?B?WWFMZlV2SDVyY3A3L0FJYmZMZGNKdGwzOUFFTXFwSDlJWVp5cER1ZVo1WCtC?=
 =?utf-8?B?bHZzcG1KaUc5bTlaRHFnUGQ3TjBpSTVDSFpON0ZOci9XbWxPQjdlWUoralVJ?=
 =?utf-8?B?YjB2UlhLeldOZVgxNEkzbnVaVzhiVDNUUk5WczlMeVhsTXNya0poSmhkSzdL?=
 =?utf-8?B?UXJNaDduSllVYTdScDNSaW03MTYxc01EdTNEa0srcC8vcXNzNUQvekMvZ3c1?=
 =?utf-8?B?WkQ0UXE3eUkvTWE5aTYzcitQcjRqYjN2ODVKbXZpekp5VUtWZ2hSRkJqcVdi?=
 =?utf-8?B?bXlGWkxuY2JzZVhvWi9VT1RhYVFucmJ2dW1TNGV4RlB0ald0b05lR01pcXY4?=
 =?utf-8?B?dkxkeTAvOVI5TjZjL2l3VGxUZ1FIV3g0SzY3NncySHYra2xIS2E0bVJRWXN3?=
 =?utf-8?B?ME42SWFXMGJmSWUwUCtWVmp3N1psNEZYaVdGQnI1aDR5ZmVxUklJNkZlcTVh?=
 =?utf-8?B?STZkazJyNWk4NEtQSkRPYXJQaDdiZmd5Z1NYYWowNlQ1bG9obWNZNVp2am1V?=
 =?utf-8?B?Y0xwakRLRWVNRHVWb0o3VGMwTDBuN2hDb3pHODRaR3lOUWlkVFNubXZmeDBK?=
 =?utf-8?B?OGc2ckoyVm42d2IwVnlhV3NJQmFIdFprL0tjemxqbEhUbzJSQWFUdXhaMWhD?=
 =?utf-8?B?NGtCdU42d3dvUkVITHhaMnllQWRQSVladSs0SGNuaWo3UHhNajBleStBTjR4?=
 =?utf-8?B?d2J0Uk1tVXgrL1ZvNFlpUlhoelBJaUNFTUV2MkFRY2ZGcVFCUms3d0h2MExW?=
 =?utf-8?B?WEhJaThHUHdxWXVUaUpmenc1UkZuT0hnSm5uamNwNmIyZ0NYbm1hTTljR25h?=
 =?utf-8?B?RDFIWFRhU0xZbVUwQUNJYWJBdGxIQTRLak1DK3lYYjJ2NHZsaDV5aXRPbi9C?=
 =?utf-8?B?Yjk2a2grV0lyZ3FiTmg5V2FhSW1Oek1GK2JYWVYvRHB0NjJGMEZmNlBadE5I?=
 =?utf-8?B?K0VNSGZkaVFrRkFTaytmdlRiZlZ2VGZqb3ZCbFM1aFppdHlKdkpZYzhQWXR4?=
 =?utf-8?B?VVh3S1I2cUhhNnRLWXVwSnNKMzhJdi9lZUkzNWVRa0E1NTBqZERtb29EUnpH?=
 =?utf-8?B?Rlhvb3BSSjRTL0ZKcHZoK2V5UjI5ekJpbHJ3MUViWjVoak1DMEJTcmcyRllD?=
 =?utf-8?B?QjVsc3dLdWRsenRlemlnV1Q4b0w2RWpBWklBakk4L0UydFQwZ3pqeWlrZkxF?=
 =?utf-8?B?NUZuSTd5Q0tzL0NHWXlSUFlid29kek1McENWcjVaazJxcTI4bkxvbzMrcUFB?=
 =?utf-8?B?TG1yemplVTVnVCtJSDZvcHpWU0ZRUjRSdVZ2OEx0TXlhZ1ZrOG1ZWlI5SS9C?=
 =?utf-8?B?dDBRUnZzMittY2ZIajhhWlQyRHJsQ21oSWNybFo0U2xveGRhVkhpdnVaS0x3?=
 =?utf-8?B?QldkL0t0OThRclF5TGlwQ3BreHRDL0E2dDBBVlFtOWdkWHlzZE1FUS8xYmtt?=
 =?utf-8?B?WjdlMTgvZncvSklkUHErV05hOGlsUXNIL3NabEZvc2dXOUVOVDRqWStmM1Q2?=
 =?utf-8?B?Vy9NbEhtN2ZFdVlKODJYdzI2bjJ4OU1PRjZLYXRldm1nRjB0TkZyeHg3NTU5?=
 =?utf-8?B?allWKysxeXNKUkRIRTFqOEdwSFZ2MXN3dkZXMWp0cVV3MHIzLyttZDZvRUdP?=
 =?utf-8?B?andwM0swV29VUk5GcmM3amxuY242WlVURmFRd1J4L3paK3JSbS9lb0hoN1Ju?=
 =?utf-8?B?eDZ6Skx4Q0ppOUgzS3g5bHZUUnJYZzhwVWo0WlpjTmUwN01pdFd1aHNBaTY2?=
 =?utf-8?B?QmtReE9adDM1OVRIajNUYjh2RW1iMW04YnFXV2VOWTFmTFk0YzhWZ1V4WmNt?=
 =?utf-8?B?SDc2YTdnM3ZhVUx5Y0VaQmQ1L01iYjczMUZnWk9GeVljR0ZHK1cvM2lKcVpY?=
 =?utf-8?B?SGMyUzFNaHVaZUdoWU4rSGFrU1l3d2ZiQitNQUU5MnE1RGswK1BHYWQ2YVFD?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PxfGa/G53XRUV0inI4PAszP5CLQ5RN3oWTjIb/ZKTMOWGkUxpnSKOJN1kO9OmX7RrX6vYRWZ9ETlsGQ90ZUIzn/EY93Br583JYBFHMt7yKAQt79/IEoD232kXwjUUrx2e3UQ9xqJ3wEzLvcoiDCr4fIgqj647ynwJ7CdZ1uckEgfr7v5tsf+AOnzJU2ys+IeZ2NfGZUKjdo/y4MqNN01Wees/lEwJ+Y7Bm8mBqBepxhnAoLyRuCfSPcmYr/zEdUs5a9dv1cOVaoJOu1mC+NKw6BKW8e4H6fuBtC86nOOLORc1vH9BHovkjEG/r/XCVYKjmd/JoEekVwMncPPnjmaEjr5ErDVinLP6QLHM7Tg1hgTt9m3umvxxUJtEn5ZIbjebByVu9UCGJw+UrYE4cgVcMH6SbsuB127LcoD0yvCw3L2NfZ4e6WoZcKyyJKzcNyHN9xH2YOhosghOfgzX/YSTCSLdYVvoyBvEK2suVrH7Wv2s9KxkLJeZJ5kysYU2HoXW5gGlM7K5iE3qmIy7X0PqbIvxaWmpggRWczxSBXl+dMVRqXx6/jjpgn5phUN4wFh+qJtIyk6O6vMNbdq3Mw4pIJTWjFWplNP5EK/rm/0Bm4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd700ad-f0f4-486e-41e0-08dc7f069bc2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:09:14.2454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmjciTmXh6UE5bUZnte2EhWT4MXb+tl3jD8fsvn8kIyFGsJkOFVIc4lJVJrSaTMeNqieYjpJDs6oyUrgBgf4Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280084
X-Proofpoint-GUID: qAEU5tOMbd6iKkLY5Jnlk0O_ZAuQBrCA
X-Proofpoint-ORIG-GUID: qAEU5tOMbd6iKkLY5Jnlk0O_ZAuQBrCA

On 28/05/2024 11:57, Christoph Hellwig wrote:
> On Tue, May 28, 2024 at 10:21:15AM +0100, John Garry wrote:
>> If so, I am not sure if a mmap interface would work for DB usecase, like
>> PostgreSQL. I can ask.
> Databases really should be using direct I/O for various reasons.  And if
> Postgres still isn't doing that we shouldn't work around that in the
> kernel.

As I understand, direct IO support for that DB is a work-in-progress, 
but if and ever it is completed I don't know.

Regardless, my plan is to work towards direct IO kernel support now.




