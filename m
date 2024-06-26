Return-Path: <linux-fsdevel+bounces-22534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A732B918A3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 19:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C9FEB212FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D014A19004D;
	Wed, 26 Jun 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="haoHABHu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="goxgJuWI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C97EEDD;
	Wed, 26 Jun 2024 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423677; cv=fail; b=I/2cALclvLu5QX3Dr0GLLhXB9ONwdTISHJ0Fw0P/q/e6GvbgJB1JdqYAAhKEu8RprnesTmFIu2pxRtTotUIKAOwxvEfGjwLAbrVudbHyI9nT2AMcgyFMcp42EkmXgrPITFqltaEkeZfvI3spSb3TlFOyVHjG4S4lDSVabGCg3ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423677; c=relaxed/simple;
	bh=KSmNR50xVu1EyPP/Chbydx43/awataqbG3aRI0jlbm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2p9chx/e6lEybg7BCHmNZBEilsZfLKXZPewJL70pkV8pv3iqziVkFGj6m3H3y+nCkXpQ0gxv8WtVmSf/S3WNlRpubArImZBP208bA6GxRvzPMb/di4nztEje9HJRf2nlzngApReRIDXoDR+eU8y8sbptDyqPnyuau9MB+aY7bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=haoHABHu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=goxgJuWI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QEtU0h019623;
	Wed, 26 Jun 2024 17:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=C0h7jXAJkavUjLvtc5AoOJZLaWnc2naI5DApFaHvA9k=; b=
	haoHABHuIhGML0cT8sZT23h8x+514CxkQPzsXdcup62eyYssfTD6d7jNsE2c4gDL
	ontaBhJn8qvL8gpi736UXSnmbSrL9o8s/k88UuYLJmuPmzSzvuqhvAr8sB+v77St
	v1nLqZbTr0dnBMGaSfE9C4aYGiEDhdZvh8F+5CJXZDHg+o6f1J2UYD/NWxH2ygI6
	ItZ/StmI+PiEdFtalcu978Xd2a5DT8NmqaeE96URQ2KfCydVK/iRcahSj4aOaoEv
	wuAu0glrddMy5NY+ECCYOTYzI/0WiStaqmfosu5sByhPDMAT3oxXZBffVicvk4LT
	NCdUcntwxbQx7TYVgbgsLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7skxag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 17:40:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QHb6T3023445;
	Wed, 26 Jun 2024 17:40:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2fv38s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 17:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii6kyGpxDcHTt7cNW99lJ2ZsIp1VTQooCBk3ezjH2P/cYu3c5SV/aq3SugN0DBXiWOgGMkfyHQo0Q8PBoxYYts3N+V0xJ9IkIHivUyETJt1aPOxLsvJJgXRCjKIJdTo4X/pX5feoAwN6gKMbODJniJd8qonyaQDlRoEphEneHWSNKz7bSUdpvWtkav6qwLyUmRbVr2V/PNUdwulZ6JZ0lFjJl+mGFZkojkFa9nMY2PYakMp9ABvp5tUZlWxsH9dzZQSpxwrFft1B9vFcVSXDnEOTK1unEtesNKArkqCc3jmbEi5JlN6jXVVO6gWoBkamBwXYp0TPIZJjGNAIhdKnfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0h7jXAJkavUjLvtc5AoOJZLaWnc2naI5DApFaHvA9k=;
 b=bxW6mffpe99AqzHzP+d6XWgGnakCDyTp2VL0GimL5+cr65TCydfLsdGleOjCsSqfgaq1znaeYEl+ptXPcpVd5eAx99qAZtsMz+plNlnN5J950uJPqK5hRB9voHc6cPmgg82ldHgfENch5Mr0gf5ksTxfu56azd6pNAhTgTDj1/WrmmzOpsvv4vhZ8p+bjdGVvW2ukqy1vwBFuH2M0x3cYPVgO0T6zu5rhwMX7XEIdzb115BsfKzqLTNqHXJoLXagf6GPsKxwCsvw0ZOY+pik3flKUfhu7LPYKKEqILXzVVe+7D+r1DfFj5HewEI2m3mCabp1+jFj8MuCyyf7QGYkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0h7jXAJkavUjLvtc5AoOJZLaWnc2naI5DApFaHvA9k=;
 b=goxgJuWI/A5PRBq1yB9QSl7Aea3kdiTJ2QSq2gTuYy3WRILyeKrqUS2z63T5EiovO8AQUophAgijD1oZtmkBeYTDNAbzSrAWoFyvb4xXZnb7BNg0MJg+J2p3yn7watqbM5VlDjGfEnwdPbkGzxaB7qtLPx5xYAhaFY5xPwbbc3g=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB6027.namprd10.prod.outlook.com (2603:10b6:208:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 17:40:47 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 17:40:47 +0000
Message-ID: <52a063a3-ca63-4dd9-8914-62ef0a7ed794@oracle.com>
Date: Wed, 26 Jun 2024 12:40:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
To: Jeongjun Park <aha310510@gmail.com>, shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
References: <20240426034156.52928-1-aha310510@gmail.com>
 <20240530132809.4388-1-aha310510@gmail.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20240530132809.4388-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::11) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e5e9b7-9f78-4f46-03ce-08dc96071ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aWRiUzdad1BPay9uRStxMFdKWlo5UjgyY2RVcGxISS9IQzV2aXB2MWljY2dL?=
 =?utf-8?B?cVU3TmtxNUNaZnlWN3B4bWg0Vnl3enFMUUFKVUZBbGVDNC9Ea1EyVE5aMmpB?=
 =?utf-8?B?MFo1c0xRd01KZHhVZ256NGhLSjRRREdTYXcxSS9HR0FXK0VoT1FGTDZPMTFJ?=
 =?utf-8?B?NDdGRHYzRGJubGplM3haYzlWekRhK1hrYXMxV1hEVzV5YkMyb1Q3M2NnUVZk?=
 =?utf-8?B?TnBSb01MQmlxNGNvUmpORm8vbDF5eHpkVnZtenJZbEcvemVvMHJhS3BJUDBP?=
 =?utf-8?B?elp4QjNIY1B4aWZwd1JrTXpzL0xXWkRGZnJzVnlkVkROdVFUbi8zR2p6N0FV?=
 =?utf-8?B?aCtEeFBZVnphM3hNOWRUOXFjcmwzTEY3S0gxTy9QeFZZLys0WGo0VUsxNnRT?=
 =?utf-8?B?cFlvUHMwSzBoMmNrUC83eTZiWkl3NWZPKzR4ZVBJUlc4TFJFNkdMQ3UvL2ty?=
 =?utf-8?B?YjB4SkF2TE9jWnhVTVUvQ1FpNnFTY0puYnBKckV1dDUwbWFmMlNvbWgxeHVz?=
 =?utf-8?B?NFphN2pSblZ5cDNicmVDeVBLNWVpejRSZnAreG1WdU5ZSkxGS0piZFZMUGtY?=
 =?utf-8?B?T3k3Y0xzQ2VOcWFaRE9OQnRUQi9BSTZlL2s4eWQ0cHhoSDFzM1dkVFRSM21H?=
 =?utf-8?B?ODA5aXh5cFl3YmNJSi9OSzRZT0hHajN5SGdvSjR2Uit3UVU1azZPSFJTU1Zp?=
 =?utf-8?B?aHJOb3ZNN1Y2MnowVXhBcUMxNHZRNXJRYUgvOE5ySUtXYXFQeWJzeHVCalhz?=
 =?utf-8?B?TFkxWnFMRjNlMGtXWEY0ak9FTEJlajlGNkVqWXI5bW5xSGxCa0VvcGNEeWxX?=
 =?utf-8?B?Z1JudWdjOHJFVmpldDVrWFZocTFJREFvcjMzR3pPbFYxOS9aMkhGQy9kWnpt?=
 =?utf-8?B?Y3laZjhOQzFMeFJTRFk2d0ZEK201V3l3SzJWaFZFMTE1NUw3TTA5S0h2SzZs?=
 =?utf-8?B?d1ovQ240aldyMXh1NFRYOXVCQndoT1NUaG11YzltbEtza2ZnbFllRGpYSlFy?=
 =?utf-8?B?WjFKZWNhcENmbVVwWFRtMGZGbWVHbkFKT2VJTG1WUjNmVFRIYWNBM0dnYUZZ?=
 =?utf-8?B?bHBlOUQ4NE95SmdNWjNZNUtkeHlsWE1jUFBsSU9SMDdER1gveG5jcGc5Q0Nu?=
 =?utf-8?B?MUliTDNHMVlNdUtxTlZjM2UveXFDdDhwN3lMV3B1SjAwV3owL0lVa2JUcVBK?=
 =?utf-8?B?Q3QxZHo1Qlowb3VxMkVzQzhpM2lNb0laRjlmd2Qzak5CbWtQUTNPbm94WE16?=
 =?utf-8?B?cGFBMHV4b2c2WmppYWVLb1ZlckJsWHptTUErWWd5OHU2dTl1YW9rNlNuTm96?=
 =?utf-8?B?UmVoZGMwVm1IKzlCeVpSV2Z4eU1XRDFVS0V1NE5Id0E1c2hiYXA1eUZWZmcr?=
 =?utf-8?B?enhmdlJwNkk0RGluUEhuSGNpYk9keE04ZkM3SU03TWZpUGcxSklXRXVoZFFn?=
 =?utf-8?B?cDljY1EvaXV4aVMycGcrNmZJTXBJZjhjMXBwUnNzYUhrcHE2aXVWTXJMRnVG?=
 =?utf-8?B?T0h2dTV4c2VJT2ZmN01yU041OGFEeEtzbGRnYUUyRml0Um9GUEwyT3plSnJP?=
 =?utf-8?B?TTI4MWZET1V2SytHczUzYWhkQmZFd3l6ckpkWlhrK0xKSXJqMFh5N1hBQWlo?=
 =?utf-8?B?TmN1Vk1iOGJsRWM1QTZ4QjFLcVRxZ2pqemFaVnN5T1lvRTlNSWZCVFhCanhU?=
 =?utf-8?B?ek81NGFtR3JBaE16N0ZGS0VPbXhXNTk2alcrVE9oUXd0OFE0N2ZoT2ljVVp1?=
 =?utf-8?Q?SHvWacngSN4ZIp2NNuQG1t/S278pPDX8GFhDb6/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MDVjUFo3RzRWamoxMkxnVklXVVNQTTRaMXYwOVNwdVE3UFArWTFoWldDeUFI?=
 =?utf-8?B?UndNbitpNjRNL2pmOWhKYWFYbW9KRzF6YjROc1Z2MlNtb1JmR1hYQUNySVBX?=
 =?utf-8?B?a0JRV2xGazBQVjdHRXBXZkRDZGRiUFA1YXJjekZjYWdodTB1ZDg5bDN4ZllO?=
 =?utf-8?B?RjhlaFIvZTRuMFJ5QU5nZHY0ZXVKQ0JKRng1b1N6Z2hKNU4vZkxVektSSHJM?=
 =?utf-8?B?aitYZkE0WDVqL2xrcktiaHNGRUhYSnVYSG8rcUtNTlBLMWJCNFVWNFlBNjhl?=
 =?utf-8?B?eE9Oby9tWnZhb3RwN1VyNUY0MnVDWlRGNjdaTWl0TTZsdXhyUWlycjRCT3dB?=
 =?utf-8?B?TmFXM2tveVJpakVqY1JSQXFuWVh1bXpsYklWbTZQSDlCSGpSa1Fma2RFbExm?=
 =?utf-8?B?ejE1YStMcUlLdUYvSDF6dmNITUg3RkVZc3VJRExjMVJMMDBHU09RdytLRVVG?=
 =?utf-8?B?VytOK0UrVURZWnlMQnVPVFZHMHk4WHdUeFQrcEd6QnI5dk5IYkRpb0tKWElr?=
 =?utf-8?B?ZlJ4TEZrZmNmbmgyYkNvVmZ0V2xUdGllZnhyRTVWK1h1YS80NkorUjJ1SVBJ?=
 =?utf-8?B?RXYyNEFsdFIxMGVOOWlNdnFZdDBST2J5bHhBUngxeXRVV3M5QVpOZlg5M0Q2?=
 =?utf-8?B?ZzBkTzNPK0xwM3pGdjFaMjhqWVZNcVBXREovMmx6bzU0dXJWcEw4Vkg2SW5W?=
 =?utf-8?B?RU1aMXZtYlZxNVhDdEM5WTRRMlZLZ0lQalMxdlp2Vm5Hd2RKWGRQOVhPdm14?=
 =?utf-8?B?clVnUmpYUVBxdmtIU0RsNmxMY1dXZXRIU0VpQmE1elVoQkt3REtYSE5lSTRI?=
 =?utf-8?B?cDIyS0c3TmprT1FwMzhzTjE1RTlTZWg2ZGVSZ3ZSUW8vb3dpM2J0L21uUWxJ?=
 =?utf-8?B?bnNTZFp2K3FtcTZHdXVja1Z3TVdoUmhYVlUvZVVRTFQ1MTlabmVpRU4xSlB2?=
 =?utf-8?B?TTIwTmNISloya05sQ1ZySkU4MjVDcWhxL012dDRkWktXU1VXNUhLdzBvakxn?=
 =?utf-8?B?SGVnVlFTUHBYc3dOc21TQlJRYnNzQXhYdnZHcGh0VmswUVlkSFBKN0wvdmJT?=
 =?utf-8?B?UzVUbW9JRDRNV1A5OGpjV1M0RWtubU42d0NnYk10K1VITGttcVliSktSdEFj?=
 =?utf-8?B?T1ZKWWFOZno2aVdMZ0dLd1Z2NjVWZnRJdVp1NlRPa0pUOTEwWDJyWFRnVld3?=
 =?utf-8?B?NTFSTmZzWkYvck1QUTltVW5rUTExd05jMzNRYk0yNVpianRDT1lGOXN1dGND?=
 =?utf-8?B?MzBFRjEzbkZjOFRkSUJYZGc2bU5kZnZDd2FveS9HOWlJa3FaVEVBZjNSMVFP?=
 =?utf-8?B?czJXbUpOSkhnODVzS0EwcHlxTVdrNHpuN1JUUWE1cFFqVE9hVTRPLzVhVkhh?=
 =?utf-8?B?VGMvMWhGK25BVFVvN3Y0WXFWRjIyNDNQY1BKMmFUYlZvL04wS2ZwYk9ra0tt?=
 =?utf-8?B?bjBNNGlRM1hvL2ZqNzdiWXlVUStHOGZhcjlZRUNiNUZaNXM4VXhLQURSTExY?=
 =?utf-8?B?NzJ5SER4M1ZtQUptL0VlM3JTdHVwRmp4WUdXWDhtY3cyVmRvN3VZc05zSEhK?=
 =?utf-8?B?d01kbitSQkY2SWNWUGUzK2tYNGpnLyt0TlltTGhWN2QrWElUZUwxV2V0bTg3?=
 =?utf-8?B?VFpvMDNyRll4WS9VUkhmSndoYjdxejg3TFJETGhZR2lpSGhHandpMVBXK3Bw?=
 =?utf-8?B?elJHeVVybkVCSmduaGJlZFBuTlRxUmltRDdWY1BOZnNYNW9VL2pIbkI0c1RH?=
 =?utf-8?B?UUE5QkVlTkVkaWRlV2wwSWpxMDhadStWQ1JYQVNvVUdyMVMxaE5zcHJkbkFE?=
 =?utf-8?B?SFRPT2hvR0tXa3EyNFYyQTVwdVdaVzNSMVlpTWlraDdGMjEzWExheklJTjAw?=
 =?utf-8?B?T3REcTAyRjFkVDIrYUlsVWw4Vnl3b1NiZzNnSUdhcDlpU3p3SVl6U2Q1Q1F6?=
 =?utf-8?B?ZWl6MnVHcDB2VG5Nc2NTVW9EUUZCQk9DSVp5Qy9ETDg1TnF6QkowQmF0a1lC?=
 =?utf-8?B?Uk5KOXgvVzVFSEV4YzhLaE9mN2ZwK2E2dVp5QzJvWVFWMVpNN0VpazhybGw1?=
 =?utf-8?B?WngzMmpLVGZLMXF5WGZmeXR3dVBFS2toNjJoSU16VGFOelFBbHh5VGt5QWtx?=
 =?utf-8?B?UDUzekttUWt1MzI3QWs0YWlsb3ZmdVB1eDZGVi9DblJmK0phZllpZnJFMzJu?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qgWCKCtUBP7pVcqcMTxmDiFT1AuXE0Fy5C4uzJ2vSVll5Gc9f9ONw5z1mzOjtfRdCWaVxyayfMyrizcRiFut11iKrW0trusIxb55CVm43XFL3SpKAA4n/JdYNpjh4pn3h986ynSj+t01B5OhlFY72J115VeH+kc9V5amxECeKpxTnwKFtZPBWSrGLEcAQkpNHg3p8cNSmoALZm+Yb6nm1RoSlbje2FnzuTO9LoNVOCdu8y+1A/E6VFcSdwb7PazQD7L+LEOFZxuP7XfUJ5UMh6ucpswH5xBLHGP9N4fJvASaX7b2hQ1zJxD7JPDHhgcFqeYA/WVrEJmuogl7Zzt+05IwLHDR9N1JZEOo5wxXPDBKxnva+wxmGitVBq7fY2HqNcgKdTjDdMntpSislYAKDwZi54lvlsRFPAvfKV7Xj3um95SU5IrYnW/jYiHJjcF0064UfGmy3ZbHQ9uLbh5bR4TnHaQYnl0wdMLUkTtJKmfWJEVhw8EzrwEM2gm7KsFBsnk/ztXQWWwBLpwB1ZShDGY50SkT7eHkASXRACTfjen9WISqVZkUBmwBW3xk16uIefSDiefNFVCFykzLV7H8Q7n/VFGxETdFlmn5wsDhexA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e5e9b7-9f78-4f46-03ce-08dc96071ca6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 17:40:47.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RISr72zaJ0n72OR5KvQQQmuj5T4ro94WCBlfIjLCBAA5pLrWr/UynX7n0eLiZLD84NUGkIP0mSBKaA7UAFFwDeX+/Y2d/qor6s3qaoIKxUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260130
X-Proofpoint-GUID: oryXnGrjiQq1N99OZyyo3OHl9bWBSW9-
X-Proofpoint-ORIG-GUID: oryXnGrjiQq1N99OZyyo3OHl9bWBSW9-

On 5/30/24 8:28AM, Jeongjun Park wrote:
>>
>> Matthew Wilcox wrote:
>>> This is not a good commit message.
>>
>>>> +   if(agno >= MAXAG || agno < 0)
>>>
>>> Please follow normal kernel whitespace rules -- one space between 'if'
>>> and the open paren.
>>
>> Has confirmed. This is a patch that re-edited the relevant part to
>> comply with the rules.
>>
>> Thanks.
>>
> 
> I have just discovered that the patch I sent last time has been left
> unattended. It appears that the vulnerability continues to occur in
> version 6.10.0-rc1. I would appreciate it if you could review the patch
> and let me know what might be wrong with it.

Sorry this has taken me so long.

Applied.

> 
> Regards
> 
> Reported-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>   fs/jfs/jfs_imap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 2ec35889ad24..1407feccbc2d 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -290,7 +290,7 @@ int diSync(struct inode *ipimap)
>   int diRead(struct inode *ip)
>   {
>   	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
> -	int iagno, ino, extno, rc;
> +	int iagno, ino, extno, rc, agno;
>   	struct inode *ipimap;
>   	struct dinode *dp;
>   	struct iag *iagp;
> @@ -339,8 +339,11 @@ int diRead(struct inode *ip)
>   
>   	/* get the ag for the iag */
>   	agstart = le64_to_cpu(iagp->agstart);
> +	agno = BLKTOAG(agstart, JFS_SBI(ip->i_sb));
>   
>   	release_metapage(mp);
> +	if (agno >= MAXAG || agno < 0)
> +		return -EIO;
>   
>   	rel_inode = (ino & (INOSPERPAGE - 1));
>   	pageno = blkno >> sbi->l2nbperpage;

