Return-Path: <linux-fsdevel+bounces-67607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11154C44701
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 21:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87D9334644B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 20:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F9921D58B;
	Sun,  9 Nov 2025 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gtJlSa3z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ck++xVY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A4171CD;
	Sun,  9 Nov 2025 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762721252; cv=fail; b=r5JSE2HcVhzV6ml+59xKe5P5ZcR4/SvAqTUYSVwQxw7DR8hFrE8hf1cI9bMgJ5r5ttugyLYjV5ZQdPd4yxo6Zi5ZhtTGa3Lh9b9+N9eJyb/TiFJz+/0O2tUqq7i6JaAocl0dCdgsnEmP/rxp9/rbGg8gwI+pVPNE5pFeML3LhAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762721252; c=relaxed/simple;
	bh=+Vnh3iBNgB7c68KS/2VbshTuCwZsx9gBE4e2f0JYZK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q1HAjPoHFVTHEO/T98PaBcdzi2u41ZTs5LjgEKXVL/VHvnNv4v0Eaw26W13w6STiCZbBzii0hvafM4RGctv/T4GBn8FWW4PgQb1sKUBumhohvs5jGuQR0LRdCKxrOAoHP9SQSZumVxUciV++VHFsQCvFvLPqW2s5Sgsoych5IgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gtJlSa3z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ck++xVY/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9KBrJk025370;
	Sun, 9 Nov 2025 20:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=luXt/oJ6vsRuFy3uKg68AqDDTfRv5/VT7P/auDs78eM=; b=
	gtJlSa3z+dUJMZ3AxtR9C/eay66Q3GoXSlkSocHczOk5yILQMAdY4QsoM/yULtFp
	zwB9VLsrQBPW1U/2IMaG/TnJAD88iWVGJbEdwMwJ2Y7FaTqVEhjSvYpczS6lEPQ/
	1+bst5x9zsR6Proutsg/keBpPldX2fiXcvAwRDt2RonP10lrkse/XkbA3HOU3GUs
	8AEvT9U3rKbptsvUuP1eBe7PiFHtFkor6x9DP77NB8TF71U7eklLoZ1bnauhVYH4
	hJb9kO3yCh8mAW7AcXgovjOr/0QLOXCaK1tzzdNeFGwSS5ONhYXtH5kEqY745hkN
	QCk95ZCK47sDgoRyxkRggQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ab0qv82d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Nov 2025 20:47:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9GCmfa020489;
	Sun, 9 Nov 2025 20:47:19 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va7d5j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Nov 2025 20:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsdBZyB7LiPJv1EkJir3UP8UBuiRijWIaEOo2+ZS3+/JrwLD3hlknCm8fhsAATX6Esz67m03/OO/pR4iDof2fcf4oRiQNfX2PZ/jz/pZAS5/2vXEcdGE1cm3PpDbwLPi2HcTAa4jc+0qxHzjH9QkFf85m6WE+ICoZ/nZ/8bBlKkprFR3Hc+3gx9ulcz6f+7QPJOgtloR65zyvzrrputrOEq1dMloxmXeX3PsbQPsRRxS/lVSzYmHiXYiy3FZLTX0nUws+uRg2ElpdhipWjMm1GM8r+2GUz9NnbH58A0BybfkxBNK6vQoKTbrlbNcf164trx31m+Cz31hmPNCXQuacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luXt/oJ6vsRuFy3uKg68AqDDTfRv5/VT7P/auDs78eM=;
 b=YRC8NRiIpDTgfHVJfybtoV3va8xT9AWNho5q3/+er21mu80kdjNxnfcw7xeTyUt0Wp3y92go37iORd84pq/LbNunlytgQUtairnd/F34rI4ZRyveUv71uTrJxqEqXGEks7uqzWA+YlXZMucegamppVHjXRAvrryfsyviqIOOgGkrZ2qTEjhcTE1IFaikO6o1kPyTdxjzCoK1ZXMAIZZH9SruBK2tmJ/4q/NVcAxnayQsQOwSQsuXEBxR4eJ4t9CyKwO0tlw35185rDjKMWaF5vUvhSa6xlgXHlNaeYXtVHN4J7oAwwMVTf8Mg5L9RO+7nAjEsLHd5w15TYhqaudssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luXt/oJ6vsRuFy3uKg68AqDDTfRv5/VT7P/auDs78eM=;
 b=Ck++xVY/pW8i8UjtIJis9OiBb7O0nu0qIA/2fbld2aXENfv5K4QcE7UNcIlH00n70h23GSnatl+wsjXSwOT6Mj09KS/wMwi3+ESpKdJX6HPem4VnVem5JMSjCSnHaskg8ILDX9wT8Aphxc80HaMAEq41W43qloVVVs2j2UH2oBg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4227.namprd10.prod.outlook.com (2603:10b6:a03:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sun, 9 Nov
 2025 20:47:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Sun, 9 Nov 2025
 20:47:16 +0000
Message-ID: <26959e66-f04f-4e6e-a8ce-a44c4362d99f@oracle.com>
Date: Sun, 9 Nov 2025 15:47:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: NFSD administrative interface to prevent offering NFSv4
 delegation
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <8918ca00-11cb-4a39-855a-e4b727cb63b8@oracle.com>
 <2602B6D3-C892-4D5A-98E7-299095BD245F@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2602B6D3-C892-4D5A-98E7-299095BD245F@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:610:11a::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 2002bd11-2f48-49df-1889-08de1fd12ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVdCQWcxY0VxSU04TnVoVytCTTVkWmtSYVA1Y0h0bTdZQXg1WEZrNG9XS2k2?=
 =?utf-8?B?cVYvVUg5bGE5OHJyOXR5M29rTVB1d05vdEtFRUJZU1VUbk9WWkJ3S3V6TG5R?=
 =?utf-8?B?Nk5zdXZtUFBTWGdneUJCY3NxOXpaKzhoUmh1aWR2cSt6QzBnQUtzZDBTQmtN?=
 =?utf-8?B?U0hXbld2ZVFuVFFBT1RqMCtQczNXQXlvZ0xqWVpzbnJ3RVRoanVGZlNLRjFZ?=
 =?utf-8?B?anBrSlJtamp6K0VDTDVGYlhjMFU0UEswdWtFQU0rZFhKanQ3UTBwQldVbExI?=
 =?utf-8?B?bzBmNElObTRZYzk0S3BRb1BzVllmdlg3ZFh0c3prejYvTGM1Y3RqZ0dOMUQx?=
 =?utf-8?B?QTJjU3BmRDVmVEVDeStjemltOEp2cmtyVTlHRjRKeVV5ellyU2k2Y1N3NGpQ?=
 =?utf-8?B?T0R6TUlhZmo4SjJlQ2JzbWc4QXdVU1czNDBnWHRFNjN1TlZ6SDNOQitxcnU4?=
 =?utf-8?B?dVl1Z1IwSGhrL0E4MUZZRHVjclBPck95YTJrRlY4ZXM4U0huMmkvTWJJZWFY?=
 =?utf-8?B?VUpzUXhmRUtEbjFRekFCM1piRHJMOU5saUZDcDQ3V05mQlhnN3NNTnRBY21k?=
 =?utf-8?B?TUh1cktjR1AzR3BQTXJMZ2g5Z3RoRzBqdnlwVHJJSGs0ODY2Skk0dkRidUcv?=
 =?utf-8?B?VXYxVzI1VlFwMGR5Y3Nsa2dITEEwYjhVWHl6MndNQUhzcjhBcnhPeTQ4akc4?=
 =?utf-8?B?RWx1WXg2WmVHK29Hc1ZhNnJmL3F0WTZJVFljWGRlMUpyQktsVldYdDBaaUNo?=
 =?utf-8?B?K3pCRlBVS1VWblBIWlVhblJmNElqY0VRbTJXajhmQTcrRlNOWE00NU1iUkFO?=
 =?utf-8?B?M2VJaWxWdCtTNitiZjFtaDQ1SFVCTmVZQWJxVC84Z1hnYkZ1VTRZeUJlV0R0?=
 =?utf-8?B?Z0VxSnB0QytOOFhwTmw0VWpGRzVjclcwTm5idi9vRWpSZzBreEkwbmptUDZV?=
 =?utf-8?B?OXk0dE51NldmRC93L3pueGxKSGo0dFUwb0J2Q0IyS0VSeU9OU01VamxMR2d0?=
 =?utf-8?B?eEx4SkM4ZlY2QlNNdG1YRmpxbEs5K2dsTjJrQnNGdFM1b0QwSVVzRWx2cHdS?=
 =?utf-8?B?Q0dDK1lybG5IMThZSkx0S3ZGbTM1dUxEcmpOcTZtVWphMWhkOURaSDMyakNK?=
 =?utf-8?B?cWtTRzdTL3RYeS8vQ3p6QzY2SmFZbWs4Uk0zQjNNVUR2Sk1FR1RxVVRRYzB3?=
 =?utf-8?B?RmxxdmVHOUIvMmIvNFU5ZGtyOWFXbEtCQzM0dWFFNU1ScVQ4ZTlXbS9HT2Ux?=
 =?utf-8?B?TFpId1dMZVJyQksrbGxOd28ydUFhYjgvTExjQ3NMSFBYRUVzeXFFT1R1VU92?=
 =?utf-8?B?U2VEY0Q1NW9aOW9SRzQrcHBadjBZSmo3ekpkUk5ycDFmdDJ0K2hCelBoU3dD?=
 =?utf-8?B?RzJ0YUhCeWE1WDJaVlB6aWJWeTg1K291VXJQd0p3Zmk2VzNHOU54dTZPMEZE?=
 =?utf-8?B?L2xiWU5qc2I1YTdPWTBoM3hjam9KN3VIRVJiamo3ZEo1R00zUFpVM0t2WXRj?=
 =?utf-8?B?K2xEUkREakFPV3FDM2xEcDRTUVpUZ1c0czZWQzF0RzV2eEx0TG91RU9pTDdB?=
 =?utf-8?B?RE56R20wMEtWRDJRVjRqU3Rjb2FJRnJxNkNKdkJicDU3cUxCbXhTRXZZOVla?=
 =?utf-8?B?OExsdWlsQUVLdWZhNnBtdzBvaDJKb3M4OEh0TUx3NlRTSXpvYk9ONmJMUmxk?=
 =?utf-8?B?TmVBcndkcmVzYnZPSmpZdEpKM0kzM1hMbWQ1NVdUWEFUWURXUUNMOUwrY212?=
 =?utf-8?B?MDBmR1RJdERXMER1TkNVWDZLNjF1U3ptbi9sTnc2TGxPV2tNS3hrd0JGNmMy?=
 =?utf-8?B?TkxwWVVpdlhhOGxxSDdqdkRCNHVYUTVHblloLysxYVptSllQQkxHYmpYN3kx?=
 =?utf-8?B?blB3T0Q3b01TZGYxdkFVdVh0Q24vb0s1RnZNY3BLem5GTmh6bWNWQ1grMlZo?=
 =?utf-8?Q?ztgPiWLju6mkARwHIOVkYqDVfEBTzgLu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXViUlp1ZmJJUEpSdk5OOHIrYis5d0dMN2tRSWRlZGNRT3dOOURNWnl1Y2Y1?=
 =?utf-8?B?TkxEK05nZWNsZ0lsRlBWbzZTQ3ZveGZDL2VUTzhtM3hBdVNkWFM5RzlCWDhp?=
 =?utf-8?B?QUNaenhyek1qbkc3QWp0WXBZdmEyQjJhWTNXcUdXN0xVcGE3cEd3YjJ4RDRt?=
 =?utf-8?B?a1FDRzlaWTdHT09Tbm9mNTllby9WRTZ3WEI0NExYK09qd2xGUVdNZHpRZHZK?=
 =?utf-8?B?S25zYTVKUExkMStJMHVXZ3ZYakZWNThFdUgwdEFTUzFKekxyZ3NDUlpxRTFk?=
 =?utf-8?B?L1V3R3ZsRWE0SUtzUG5CR3BSUk5ZRnVpZGNTL0RjOSsvVlVGaTBJUSsyN0lS?=
 =?utf-8?B?QVg3VnBhdXpPNS9iK2RDQlV0WEJSeDZBQkhDQjZBKysrY21GRTAvVDNObjI1?=
 =?utf-8?B?ZVVYVFpBWWswaVhHeHdHM1JRNmJRT29uV1k1QVRiVjQ0bzhjeU1qUHpMSUtH?=
 =?utf-8?B?c2dieFNGaFNMN3EvZlJDNzhYcHQ3aTNDakZWcG45WlVwQmJPRDF0MUhUMnFp?=
 =?utf-8?B?RlRKSGtsQWVrbllPb05KdDFOMkdvYzY2cEtVM2tPWE1GSTVxM0ZSNUkzSDBn?=
 =?utf-8?B?cnlQNEtoMVp6dmJCTm4yZmhkbEpFdWx1VkhKS3p3TUw5MHNTMnJzNWpxQ1BR?=
 =?utf-8?B?VnJkL0hIZjBZVUhoUEhoZzYvN0RxOHByTVFkN3ZMdDFtV3RhR01Xa0ZueEVW?=
 =?utf-8?B?Y0VHa1dCLzk3eHFma3FXRGRTMDVEOGVUaGlDVkQ3aHMvVkNGTGtuQmN6bzRU?=
 =?utf-8?B?dHRpcDZUN1JHRFB1Um4wZEVpK05MZ2FnSDBwcEFsQ2tPQVZHZW5XMEJDWVFE?=
 =?utf-8?B?b0Z6d1czWGhXQ2Z1WEJ1djZkQXVLcTE1ZHVMdjhvUlZzVTcyVTlFNUI1bWhU?=
 =?utf-8?B?TFBZR3lqZStuWmY5d1dQOXNFaGVYbXZZSDRKOWQva05sMVRIcHNVMUZBU0E1?=
 =?utf-8?B?ZlllSXFKWmszTHBoRGF2SEYwYjdJekhWeEJrbEVLT2NDM2l6eUlwaGhhVXRl?=
 =?utf-8?B?YUVtUEFXVkpEQVZBRnZkWlFiZ20vUGkvenR4S1BkdU41QjRnVWYvTHZhbTg3?=
 =?utf-8?B?cURaajdpRGF2VTcrbmxOTmdTZXhXc2VKYVNFRFF5RFBRMEpVT0xKaTZCVU9K?=
 =?utf-8?B?MlhwMzBRVitDT1I5NkVJWEZpOUJoUVcvUlJLUExFckp5TVcrbFNuRDBHUTVp?=
 =?utf-8?B?SFYvazdLUmdYaWZHekt2QWdrOVFPZmtJMkQvN2ZBaXRUOVdLbGZyQWlCTkdV?=
 =?utf-8?B?MS9mTXIvN3dWTFZ3WHVaeFRTdkJ4NlJrWTEvV2tQNkxjNTRHRW9NdVFjVFgx?=
 =?utf-8?B?YUJhMlFHU09pNnRzRUNkSHRsRTFxaEdta2czMWpZelBPc0UxMjNieVNhQlZI?=
 =?utf-8?B?MHdGSC9FdHVWaWFHQ0hQdUZRSklwYlpTY1pLQ2VCdS9xeU85K2VSZG9Sa1JO?=
 =?utf-8?B?b24yMWpqNnlVS1lrTmU5Z2ZCQW10M1Nrd0lQVVFDV09qdGhWL3dUTWhBWmJH?=
 =?utf-8?B?blFEYjVhMWlLNmMvcnFURnFGeWVYSDhPbDI4anBOQjVlamRUK3F4ZG1PLzZi?=
 =?utf-8?B?UFlVMEVaRUU3bW93VklleUNHMUdWNDFXRXkwNk82dGYxSzdnY1BxbTFsVWRx?=
 =?utf-8?B?ZGFlSDE1K2Jjb01SM2hiSjdacG15T1ZWSm5kSVdGd281bXNvRlV5aGtMWFNN?=
 =?utf-8?B?cEpkZm9IQytXRy9KV0dHRlkwRDd2Q1JpNFZsSnZVQ1pySXFpS0ZWdFVpMnZ2?=
 =?utf-8?B?cG82ODB6S24rdGZXeW5zMm9uT3ZUc2ZQVjMrM1p4RHdKYXBrbWJoelY2ZTJ4?=
 =?utf-8?B?VmxDSEo4K0F3U2RmZWVIRzBJNkRiOWJzNTI2YUZxRnA0VHhwWnBoOGRUUUJ1?=
 =?utf-8?B?OTZjRGxlRXFTamt4S1NUT251OXNYbFRzU0Z4RmFuMks2eWZId1BleU5VeGo2?=
 =?utf-8?B?bUl5MHZLYlJrSEpjcFdzZ3Zrc3NySysrMXVkS1ZQWmtXSmRuV09QL1J3RHRk?=
 =?utf-8?B?eDUvYUk5MDlVMHBaeVBoYWhaajcwNzRoclhPVlh5Z01HNGt6UUo2ZFBwNkE5?=
 =?utf-8?B?d0dBQTlpcmFWOVM1U1VobVlRTXJuVks1RG12ZTBqdnIxaElVSzlUVnBVeUNS?=
 =?utf-8?Q?rJhDvPjjW/63u3tEfJBlC1W7H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L97n2ZSjoEF/CYR6c8Akn1sWOD4fI6275XH9wwJkybWMsdXSRXf97SGG3GDBFNyYQPEk7QMpOWJMqWzwt0c7d/sWpfvhdqrTdd4xk0iUJArRwMfPoMFOPYSIR8JKM3Bhscll6iMVezbVrWXKCiUG4CCuzu8zaSZNWx9RFecS/kWZXfV8Z5K32rkeImCDNx99ENxqB64oIrcUuD8JuSK3xE/fpH95RGIHgdYLV0b4EUY20Dwc0NysWgotXURTo5wlj/2LV15ks/SUJ37zW7p/jjUU8PV0lBBpVeovqhawmoLmEdL2xYjwU/9BWdlMWqEmWovBf8ncX3mwdIw94+PrxXqmRxXLhgddixv4mLKAJ0mGL2mLLgvs8KcGNCk7PrUjyCp0CcqZoeD4Yj1pX5wOmg5qEXMMTYBjkpnZessrOsOtKhy3ARwV2E5YQ0x7/a4SvWMZGVPQSjMouVb6YK3rXj5raRSrdQRXqSF8pxnpTWOsbUfw2uVAafLrs8mwIQsuL58dtLj0z/aABz+DoIIbnMRhbabcTWmPtAQqMzTyx7ClXBs3fbFg52SYzGxiSrWgIkSafQSYdRT4w4NsWnETzy76vjWegD15f4kmUgbZQZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2002bd11-2f48-49df-1889-08de1fd12ae6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 20:47:16.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHKSP0WCvroodB2AxwdfOt6MoRmKgCH+CRCA83iYYTioB1KT4i0AUDEkCl/wNO8d/ZUoDc5UPR1Izb4fRCc16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_08,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511090185
X-Authority-Analysis: v=2.4 cv=GagaXAXL c=1 sm=1 tr=0 ts=6910fdd8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Tl5lojH5HskJUQE9O0kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2oAFe_4qguflq6JtrSDzy5oUcibTa8vJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE2OSBTYWx0ZWRfX43lyMIXF12e0
 tZo5xLfjm/IHKhx1hMKxMBEDnCjWDhKYWaMRvD4HH5HGcoiD+ZjtcyyaxQ8dpIycKkxq6SUyXeA
 b17P20UYmTSUmKFttJT5jKRUQdI/6ABMWzTe7aUIkx9LPZW0PrM31b0Qei8yqTTAKgZztUvb/W5
 A/qx0zXEsriLZAMcS5W8UJ8gbzuGkK2PrEo39BMJ4VuHddpFQFCPuBDg/eafHUpHJbolwYKaz9G
 NbCatO2UOrgYbPC1cwlu/x8BTguYKpahohBHh41eqM1Dpdg2omztA0rVdhA9SBSbmTq4S5Zhyfr
 BJyuxahR8eynGLDzWiz6p5ZJ6sK8CferLpWPRg8rNPbyEpK8HDv4q5ss62QaaIIGEDvu91ukKKY
 n3OJeL4AeMq3I5pHGqHPOwPUVBCHkQ==
X-Proofpoint-ORIG-GUID: 2oAFe_4qguflq6JtrSDzy5oUcibTa8vJ

On 11/9/25 1:57 PM, Benjamin Coddington wrote:
> On 4 Nov 2025, at 10:54, Chuck Lever wrote:
> 
>> NFSD has long had some ability to disable NFSv4 delegation, by disabling
>> fs leases.
>>
>> However it would be nice to have more fine-grained control, for example
>> in cases where read delegation seems to work well but the newer forms
>> of delegation (directory, or attribute) might have bugs or performance
>> problems, and need to be disabled. There are also testing scenarios
>> where a unit test might focus specifically on one type of delegation.
>>
>> A little brainstorming:
>>
>> * Controls would be per net namespace
>> * Allow read delegations, or read and write
>> * Control attribute delegations too? Perhaps yes.
>> * Ignore the OPEN_XOR_DELEG flag? Either that, or mask off the
>>   advertised feature flag.
>> * Change of setting would cause immediate behavior change; no
>>   server restart needed
>> * Control directory delegations too (when they arrive)
>>
>> Is this for NFSD only, or also for local accessors (via the VFS) on the
>> NFS server?
>>
>> Should this be plumbed into NFSD netlink, or into /sys ?
>>
>> Any thoughts/opinions/suggestions are welcome at this point.
> 
> Happy to read this.
> 
> I think this would be most welcomed by the distros - there's been a lot of
> instances of "disable delegations" with the big knob
> /proc/sys/fs/leases-enable
> 
> I'd also like to be able to twiddle these bits for clients as well, and
> lacking a netlink tool to do it for the client the logical place might be
> the client's sysfs interface.

Jeff is working on a system call API that disables delegation on the
client, to write unit tests against. Trond also proposed one, years ago.
On the client you might want to disable delegation per file.


> Would you also look to grain these settings per-client?  The server's
> per-client interface in proc has been fantastic.
> 
> Ben

The issue with per-client control is that, if the client hasn't already
contacted the server, we don't know how to identify that client to
the server administrator. We can't use the client's IP address because
the client could be multi-homed or DHCP-configured.

So, per client, the settings would have to be done every time the client
contacts the server after either one has rebooted (I think).

If we're doing per net-namespace on the server, that becomes easier to
implement and document. Each container instance has its own settings
that apply to all exports from that container.


-- 
Chuck Lever

