Return-Path: <linux-fsdevel+bounces-51789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CFDADB6B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 18:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317D83BA253
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEBC286D64;
	Mon, 16 Jun 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="OJnxSFdU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-007b0c01.pphosted.com (mx0b-007b0c01.pphosted.com [205.220.177.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EA20FAA4;
	Mon, 16 Jun 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090903; cv=fail; b=EKI3c5rF458bHfs3QmRjoWbTIW+oB3xMCh/wb4+m76AzO1QHY/oJO9jUHuglc7+LU+CHRbt14fvSwp7TzJSTvyualQuFrOkSx8qM5Wxvxcb1/i/1iBDp9mWwXPmgeEC1IWLgQ4FEay9NcoT5eoEWOn2gxTSBPNOoUl/rwR4gN+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090903; c=relaxed/simple;
	bh=OGAaE8OaKbi+AyyBIrvuPej0uuYtas/eGeFEAgRNoo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pDCnWSATioHWtR+jZSC+e0gbHESv4r+NqjADYVt/Nh6YOkZEVc4EJ0orK54IERVkkbdasaVG/FXGDs29Rr+YRHjD/hfleiGmBpPjdArMrxhretiKibU7pYs/m/BVveaq49niQJD6nKWNK/geymQBfgfZkpmUbxo6RauZiwl787o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=OJnxSFdU; arc=fail smtp.client-ip=205.220.177.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316044.ppops.net [127.0.0.1])
	by mx0b-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G9xHFU026144;
	Mon, 16 Jun 2025 11:21:21 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	by mx0b-007b0c01.pphosted.com (PPS) with ESMTPS id 479r3mxnw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 11:21:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF7sVi+Atle7vnEi5FeRI1MYQtVikO2W4UTv/R4DDaZbz/3+CoU7D1QMI4zQFBZ8CHoSxczapQDlvaQH2hk61kQJcK2RgMcidLYBVriyVNqAdTKcUIGE+mnqslUeGOku3uYRkaQotFe6BXh18ePLIYhaXCkestni+vniRe0HjzeTIpwAv5UAWmGuLEQLPIJqXEbxzaZmtIcGjQWKsM9fweEKMfMn5c0RJD1/cyX1T0ZE1F0K8sGN8i4bUkFJw/SBgKVyVCvwTxMBmQdTjiUpN9pLCV+46OjM2kNijXqt097NjftDJdamrDst7DHDmpjmqMuyya04kkVLbuv+R6681A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBPNDlqk/0RPWmHq/WeQOtDPphwEPFt4OFdsO4KZwNo=;
 b=i6najaP/l00EBLGHKjHd9jrBUsmNCNgOU//5VzbuCwqpADqYnfmy9So+uyF8d0z/jYQFcjohl7QzNMm6p2i5rvb7/APkrSynstYBySFBqDGBc23P8fpEUmzYYs28LTCFsgKBpRNEic+9FO/eggVaBuYuykFUjPJJ7f7Wx0kiCyP1BOc9wcAtYXyRlM1NecP+Lsn/GdvpTEZecS0E8UlblwQP9vQVBsay1X786MczUwKItzu4MTDxD+9W7vtR8xrMP96sz4ToD8vGxjveiMgFlyGoAJ+g5IHrODsF7EgLegLrAkVr2mcTzW/Xvt55nFnhcX959mClBjQDVLe0Du+x6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBPNDlqk/0RPWmHq/WeQOtDPphwEPFt4OFdsO4KZwNo=;
 b=OJnxSFdUJ6BTCSGoBFZ2NVZ9PREsVlJD4jCN3T4Q3IjgMhoiSG69az3f6LEqbUf86ly4rN8jGUvt0xYLgONcknjU3EsNENbbN/U4Ygnm1ZxIBmOh7L4g0wYk1NUXbXJ+N7sWwoDGBjSHUQBirDZ/DV7Zujc3vnrHUb9DTt1+MLWr4deeBeDlsME8YVHX1HiYwAUrwPRhmjrOZuDVeYwcpFUkyC70YYxUfN9NM2VVrNQFhyAdxHxdz0YNUvyKICcDOmH1bnEvqMnT7tVH7eaEsJW09cMW+lChqv1AwAobi4KtNC+hr2A9ASHh2X9InFoRj5BOkvF5XcQgFfOATYp0/Q==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by MWHPR06MB10248.namprd06.prod.outlook.com (2603:10b6:303:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 16:21:18 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 16:21:18 +0000
Message-ID: <f3eb815b-8c47-4001-b6e6-ec47ae10b288@cs.wisc.edu>
Date: Mon, 16 Jun 2025 11:21:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] docs/vfs: update references to i_mutex to i_rwsem
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
References: <666eabb6-6607-47f4-985a-0d25c764b172@cs.wisc.edu>
 <fd087bc3-879f-4444-b4ad-601a3632d138@cs.wisc.edu>
 <fduatokkcmrhtndxbmkcarycto5su7gb7jfkcb53gvzflj5o5a@itnis2jwtdt6>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <fduatokkcmrhtndxbmkcarycto5su7gb7jfkcb53gvzflj5o5a@itnis2jwtdt6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:610:53::22) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|MWHPR06MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: eede4652-bf3d-4d73-e1c2-08ddacf1d322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|41320700013|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mjl6T3dkUEptb3VpSCtzaTJaY0syQ1QvSFpYcDFwZHJKTWxVWEZBUFlYU1U4?=
 =?utf-8?B?OTdiOTVEMDRMMHgwUXlPUmRBSWdBU2Y1Z015cFdFeU1oZ2RBSC9Vdjc5b0RD?=
 =?utf-8?B?bDUwVkRTeDBCNTEzV3p3VnN0QmRYTWFaTndSeC91MlhuZlZJa2hSSE1jc2xz?=
 =?utf-8?B?V2NMTDRGMUo3WHNHMlRCQ2tRU0pyaFp2WXQrcjBRSUVhUVBjOUJGTC9SSDBn?=
 =?utf-8?B?Y3FISTBHMkdwRXVNd2M2WGQ5RDNGWFZBR2oreDBNNldZdzdJVDFyVmkwd2R3?=
 =?utf-8?B?RExmMVVCcjRVdTVLZ1NIaEc3RFdWN0hLNVhNNWo1L2xvTitJTkE0N3V5ZUda?=
 =?utf-8?B?ZE95cmdVRVVrZ0lCc2ZrVDB5ekhvVjBWSGZMTFVBQ1F3VEh2ZWhFV0pheUd5?=
 =?utf-8?B?RXJYR3lucE5TVlZGK2V3RnlLVVZGM2E1eGpmaFIwVU9UZWxIWm4wQ0IzNGFH?=
 =?utf-8?B?T1lITDF6UEZ3NnFKRmo0NUFBTE81QVlXaXN2dVJ0QUVWUUk3cUxEZWlyQndP?=
 =?utf-8?B?VFJieVhnSWJsdVl6cEJHSXgxZ0twRkVSZmpVS1k3T1gwamx3QzFMb21xTVRx?=
 =?utf-8?B?RHZVSFloeG83UU9ra21EbDV5dDFDcWdteFNMdUlBc1pWRnpUdm1mVy8yNWNS?=
 =?utf-8?B?V1lRNzNSenU0NGZZRVdQbFROcGRXNGNHcjBnVFhiODRKMFZMbnVBMzdQTzFS?=
 =?utf-8?B?bU9id3ZMZnlucmFIWU0zUjMyWWlKbzNLdVRhaHhvVE8yWXBwVXUxSGdqUlVV?=
 =?utf-8?B?YS93VmNBa2NFMC9zb2V6TU5rMkp6bnUrYk1tMEdON2RTSG9jTGFKWGVJZ285?=
 =?utf-8?B?S2M4bXV5L05vTHdsZm05N1lSN3cxM1JNbEFpSkNvdUtTc1ZSVHNjc3NJTEts?=
 =?utf-8?B?c291cXUxNlp4YURLUzJVcTBUVlZSTU1ocTJ3WFFDSjd0cEhVWjBWVzRmdEJk?=
 =?utf-8?B?c2hUUEluTUc0cTh2ck83Q3Q0Rnd3K1Q5dXNPb0NYSkRyZzhzL2w0MGpGOUZp?=
 =?utf-8?B?eVEwR0VkMmxzWWF1TVRSKzRKSURSNW53ZEQ5YUhEVXVrK1ROaE9XVVAxQnkz?=
 =?utf-8?B?aWtuQlM1ekJHd2M4ZGtNazZ4bWJQTlVYRUNVV054bUZzMHR4MU85bVNUeVJ4?=
 =?utf-8?B?cXdDYmtqTGpXTW00QjNIN2Q0ZzBTdytMRmVXOTlENThVelR2MWZDczhiTUJq?=
 =?utf-8?B?R1l4UTJFNFl0YVE4dVcxUE9sSmNJcmxIaVN2TkYvTzVUZnowRDFmRTRNNW4x?=
 =?utf-8?B?WmVFbmpERXRydElwbzNNK3JxdEpHRHlaWVZoMGdXNG5xeTRYYkc1NlRaTEJu?=
 =?utf-8?B?bDIwUFVFcy9wbndDNnplOUJEd0NGMiswbTZMQldDa3FSbDg4VmpDT2NqN3dX?=
 =?utf-8?B?NFYydUFrNGlBK3ByVVQ5VzVJOENLYmdKZEJPdGlrc1A3d2dvNitJSUpxelN0?=
 =?utf-8?B?S3A2Z2FhU0NWcWtOZ3F0RGg3MFJQL1hHSkhIV3I1R2dNdGFUQ2ZFRytUTXdn?=
 =?utf-8?B?M3kzRXhzbGdYRHBkNUlGMzV6ZzRzZ1RiRG5raWhmN1NHeDBQV00xTWU0N3Qw?=
 =?utf-8?B?R20xOWkrQmFadzZaZXhiNVFpZEN0TnBmQlVnRmI4aWNtcGZ4YXZ6SmNWM0VG?=
 =?utf-8?B?K3pPMzk1eVZldlVPSHQzbE9NRnFScHlpb1dSVFBKZlZpamlsMDFHeEc0Sm1D?=
 =?utf-8?B?d3dCWFgxL1A5ZDFoVlRYZTh1UXBHbUJBSXhzZlNCRFo5aWJ6VzN0NHlXU0Ri?=
 =?utf-8?B?andTejYrZzB4QmFET1FUZGFvb2RVYjdFQVJnUmwwVHk5dUFLb1d5RVQ1RzFI?=
 =?utf-8?B?VDg2cUFBWTl3ek82ODZHNWpCeGF0cGhaeFZEZnlXUUtVOTFCOWUyWmI0MXFi?=
 =?utf-8?B?dnJpV3R6c2kyZDdVR1lDN1hYZmtxTGlLZUxPaWdKdEtBN25oQkdqU205Uy82?=
 =?utf-8?Q?8864o1bfX6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(41320700013)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWVoYldYcGZWYXFtNGI5OE44TGFnQUFoM2FDMzhpcUxDcHpzQ3BNem9hZ0Rk?=
 =?utf-8?B?ck94bDVZNE5UeDN2dFFhMHZnOVUzNmo1TFVTSUsvenoyR0FEOWFGSndoSVVZ?=
 =?utf-8?B?UnRGR3VlTEtzcy9vNGdueUZvbStEaForNWpiUW5ibDZYdnJhUm5sN0swVkdT?=
 =?utf-8?B?MjdrQy9NYU9SaFFrREc4VUlIRzgzWThyNFY4R2E2dUhBMzRWb0xGWXpRWWJv?=
 =?utf-8?B?clhySkRiWG9qemU1MnVMSGs0ek9LVnN2R2hxczR6MGVGRHpxemV3dmZzalpu?=
 =?utf-8?B?RnF3NkFtdkJJb0FqaERHZkFKdUk5SkNjZUFqQUNUYytYVlNTQkVzdGdFdFdO?=
 =?utf-8?B?RnZ1Qi9JR0ZYWTFqMkpPQnNyMUxJL3ZKOTlDakdWOFdsdHppNkhvM0xsSEFR?=
 =?utf-8?B?MGprMGllZlFNZFgzNVRLNG5yOE9MQWNqOGhYRjh4MWxvU1NpRnZCZ3ZiYWdB?=
 =?utf-8?B?cVdBTzUweWE3WmxVOW9tejE0NTNFZnhlU0Q2OXlCRnM1T0FTR3JXbUxxeVlk?=
 =?utf-8?B?eHI3T1NlZEVMdHh1MXY0cXlETklQeGVjckRrd295UWJvNkkyTHZxSzFsb29i?=
 =?utf-8?B?dmpFR244d2ZWRHg4dWoxRU1IUjA2T1JNTk9pU0RzQTVBYkNJTHVyWC9hWVpZ?=
 =?utf-8?B?UDh3MXRIUnFYdVE0N2hGcm13aGh2b3lnLysySUdRTHlNSTBBV3ZNdTM4MzNn?=
 =?utf-8?B?MFlTWFRiMVQxaEQyK3dvTmhHZEFYVXhDdFZ5VVlSdVBNNmpqVkJlb3lNSDI2?=
 =?utf-8?B?clJDZVlCemQ5bzdydm03VUd0SklPOW8ydlR1aGJYaStONlEwb0lmanJDNEpH?=
 =?utf-8?B?UDVjejkxdExwa1N6VlY3N1JkK2h2YWZkSmJTaXhqNFdiU0JyYldXaTI1REFJ?=
 =?utf-8?B?dWNSOW5BaUZkR1c1UFhkcCtBeGlMdHZiNmRWS3NkV2lOTWQ2eFY0UXRqMGV3?=
 =?utf-8?B?djVsVnl4TkZDeEFRaWxkTVl1RWlxQzN4NzVxTDdtV25uZ0pJZUF3RjNnbm1K?=
 =?utf-8?B?ZXMwMGZVQUo2RldGbUR1blp1YUJkeUZHc29RMlRoZUk5RTF3cENpU2xSSHVZ?=
 =?utf-8?B?amgwM1JvNmNFV2xmVitRWHgxYjFyUEtWT1NOYThLWldSQUdKZFA5S1RMeWdY?=
 =?utf-8?B?ai9MZ2pGUC90YzBsOEZRcmt0Y2M5R2pwb0NycWpOYXNYSTJ5L2xxdnhOSVdh?=
 =?utf-8?B?ZGJYbzZIa0lvWGUxMExINzZaSjRXTW9acFhjS0ZUTUxlb1Mxd1EwM3hCRFJN?=
 =?utf-8?B?LzBkUEcybGpBekhSL2ZpMEN4UnBsS0lpNlhpUkNHd2ovamZFMjhHQS8yMFEy?=
 =?utf-8?B?YzZjS2h4bTIrRVl4K1EvNWhSNEg0UWxQa2lUYndXTFJOREJCNEhObFFoM1d2?=
 =?utf-8?B?a2VOVXovK1NIaU1oM0lUUVZjSWo4NzhOMnJ5K2cvbzcrZ2x1WXh6eTVlcHBG?=
 =?utf-8?B?OElEVFJaMnNUR1hrb0ZnVU1sd1ZkMXd0UUllU1JVWnRvc2ZOQzhEbVVhaW42?=
 =?utf-8?B?NWlySXI0WEQvR0lUQXRXM3MwOWZxLzd2dkR5OGJZS2krK3UrZ0xKTWg2bzJJ?=
 =?utf-8?B?WmJ1RmtwZE5VejVYaHZHVTY1UUtXQ29ZaVhFMHRRb2QvT2ZCMkJreTQ0Q25W?=
 =?utf-8?B?RWxOcFZxcitSMjAxZGhndUNvUGJjSktkY3JBWkFxaTZIK2M4Nm5BVHQrRC9T?=
 =?utf-8?B?SWhZN1B0QnBlbkhLRktPbFo2S0toWDBjV3hTQlFLRFliWHpkNG9obzZnSFhu?=
 =?utf-8?B?QklSL0JSZ2hrV0dSVUE5cklkYUVHaFlQbmtFQ0ZuWEZaYzNySjYzQ1BZQTZw?=
 =?utf-8?B?N3JsU1JjaDhLRmVtYmF1TGk5eFloZVdNVURYQXoyVVcvcitzVmZNZit5WnVN?=
 =?utf-8?B?KzJhTzRpcXNXRnMyMGIvUm54Ly9oWnFRcHBWWTdXZDQ4WWplQzFCQXRrTmlk?=
 =?utf-8?B?aXBqSngyVGdibnhuWktINWFUbS93ZTB2UnFBN216RUJ5eUhBQkFKSk5ROG5w?=
 =?utf-8?B?cklLb3d1UjN4b0N3NGJOM2RlWU5KNCtvWWQwKzh4Q2p2NFFUNXc5ODZxaDRy?=
 =?utf-8?B?citFb0o5bFpGRU1kQkhUeEU0V3pKdUdSYTRXSGdldmx3M0JHK3hHckxYNXlp?=
 =?utf-8?B?bVpuR0x5SlluT3RwcEFhdXpadlVtNXhORlFVZW90K3VNd04ySmNGS0ZZUVJF?=
 =?utf-8?Q?q2yBAF3VOgrqfp8IkcYCzn2/Axq22faP0N/kzOHhxUJ2?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: eede4652-bf3d-4d73-e1c2-08ddacf1d322
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 16:21:18.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5F8Xxfo/1wpFcJOKuuuhgaiiIblAuRhlBq388ZJ+ThPO2/sEBjv0AFq4aP9814Ko+CmBtQDH70CCPvJmQxpKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB10248
X-Authority-Analysis: v=2.4 cv=AvDu3P9P c=1 sm=1 tr=0 ts=68504480 cx=c_pps a=YTCy/NNc/GbGYbKR6UHGQw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=3-xYBkHg-QkA:10 a=1E0aQHB0DHgRhcW9lg4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: WMUGXZgA1nYSSCk59tpKNUq3GQC4PSy7
X-Proofpoint-ORIG-GUID: WMUGXZgA1nYSSCk59tpKNUq3GQC4PSy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwNiBTYWx0ZWRfXxXlkkJRGEUn1 gyEUmWbhhc4HRm/q0wE65NbNiUe314ivyfiHhfr9YyCTTb+NZbWpb98qw5E7kXWJREakUFRgpmA bKtaLCnn+pmChqlSZpM8hPnPOBQ4A8rdu09vmvqDBUppFNUWFWC1rf8SJ+b4T3F332aK623MJ3q
 UJs4ESI3k1+IIRrfDHwAo1JezVXpCyatqrpOhf1Wv7m5BrWB4csmh5qBTfajqh/KOLzr+jgNmEg R5AfxizHDa8CJMSZ8HlBt3qK4e3gKcj0UP7YJzaHECxeyn19p9gYRjW7HiM+H/X3etMIhHI12cY Qiqpr7xoUifvrYQTBCShFvbzasDgwvXUxxzWttkwVvC2LGRaKlWWhdX2lwuawTKuWj4vmBJeT3i
 sEcY7HwsVDDXasNi27gwi4Gurjubds+FF+1QUl6K14yUkquocTKuIUdclxeKiqQZwYqoBUTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=900
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160106



On 6/16/25 5:10 AM, Jan Kara wrote:
> Otherwise the changes look good to me.

Thanks! Just for clarification, is the __d_move comment accurate? i.e.
Does it assume the two i_rwsem's are locked in shared mode?

-- 
Junxuan

