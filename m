Return-Path: <linux-fsdevel+bounces-51460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D7AD71AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E697AB6BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1923D2B1;
	Thu, 12 Jun 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBG1L2cO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kJFxkTUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387A15624B;
	Thu, 12 Jun 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734505; cv=fail; b=TFIVR7GciNycqQrMzFxEwuxLJCBGZDply4MZEQ/R8i9Sk+Ief8ttITtvGwoeDm8lWzUsvKlft8paoXmL8UeuZtdXTAa9csHalvGyXrvhvvtoytduNETfL5cRwMRTVr958dA2hlN6Sk0OVdlWrifMSNB8lxu+4VJKrHb+3aGrRIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734505; c=relaxed/simple;
	bh=nr6eTXu9p9djA5ApJdhwwYC8XwLkl4wya77wbEZCDlE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l0qjGuzYkMD7JcrVvVa5fmndoXADeAfQE7+TR6Be7q4erElDvTDOYqxLV7ZyiGQjpOeyM1McIaP0AqTuzSkyAX95PU33vztEjcw9fk0swYWxXygsnY/sQnKI3ATfN1f5nmKPlcUkCZ8+OAnu8wkCSQ0xDIIIhVGsV15mSsZ9nZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hBG1L2cO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kJFxkTUb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7fYJR019015;
	Thu, 12 Jun 2025 13:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lxy1GzsJMLV2kycQFZQIljEW+GIKprw9un7vzpeKv4Q=; b=
	hBG1L2cOLCf8IYsteqWtopKDOXf0/0FvYFC6osL6SGaujImMvOVHLz5sReJov6Qg
	CjLoJ0zfJOztXbV0TtYL7doR9zmInS8eSsrdB1hnAkK2qIXi9Gfg6KUy8lY7K6xm
	If3hTr3VsfQ5XASuc9MVptHQZLoVKqxp/doWgRB8gDevDE7/3iRgl2MXwXH+bmOF
	xvCCR6AXryOHQjEtDIcEsqRNP4+kVcXZmkyuyL52I9nMCuqehKGCRePXXApHNY9k
	iV/oNc7tDtoAifeawB6eGx+6hoPbJhfa+HHKA/U0TXHhXSpeRLBpSJEDow76pL9D
	Pq2zJK1H2kwPiL8PY4TdIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx1rv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:21:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CC2u2L040818;
	Thu, 12 Jun 2025 13:21:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvck0hb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:21:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZp9tfvSTbmz9YETFB30sEgp89itd77XoYJnYyjItQFDYo8RzSfa4+h5NWbYeAFm5mIKt6SLImmzzavqrGH/xGxQyrCVjEyIFApJM9Z/atRWEbf/0+cpHt336DdmCHlW4hoFe0sXwpzlLLHuxJqY1mlgNPYXl+9HLEqjQ7xXC7Ku/sQEvTuMEsRMR/ab8OhTuiaQBpliO0yYmRL4xIZGYxxqm+ti21eYbUOjg0SoXFEYN4wKMMS10KiTWxN52jqsIqNtBtP1LcGeIqZ6dH7l91p/1qTz9WkuHoYHVHFfPhnKgt+z0KW+FTnm4NjBVm6oK3aI1agGhEsRLNBjDA59PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxy1GzsJMLV2kycQFZQIljEW+GIKprw9un7vzpeKv4Q=;
 b=MrpmD5RlnsC01hoax+7TWYfw8lj8M7QiZ7RufOo5xPfLHKaFeZ/v1c8IYihCkauVeetGijxrlKjJJE9EAxmTg1IvOIaL1QcBoPD9CSyNWwvyC+ydwzyoEDOW5E5aLZvpeyXnUKgvVIyrfcHNpe8RyfrcQS+D4Yqn9X0655MYL20VvnWl1IvTwOlhKNNKw/UiKYlws1VBQAnK8waG2V5wQbuEGDDLHTCyEwU9FiekwNJf8bun6tsU00A4JQmsjkxub7Yis8VZ5elwutDc6wgztrS2RPrjNWc/AJMy7dSb2bnh70ZTwhcMOQwT9WpA2y6O/esdR8VGwXfIqabaLpi0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxy1GzsJMLV2kycQFZQIljEW+GIKprw9un7vzpeKv4Q=;
 b=kJFxkTUb+zOXg9gY8iWiu0N54PJPWMskPL0cJp93ZBVb/i3ZXw2sc8uh8shfAhJLaGRGK75Kf7KM2v70ZoHcUjDEpqNNeI2Yo6kYbJTZxgF94R1A5lj05VJd6Unci6jsnVmZD2nanNh20/1S+Fk2ET17HxlKUJ9Wl3lcUsrIa5s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4323.namprd10.prod.outlook.com (2603:10b6:a03:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 12 Jun
 2025 13:21:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 13:21:36 +0000
Message-ID: <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
Date: Thu, 12 Jun 2025 09:21:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEnWhlXjzOmRfCJf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:610:4f::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: abd6c361-4a3c-473e-70ae-08dda9b40ef3
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?N2lhQVQvL0pLeDFURDBRb0IyLzNMYjFveXBCZTJObEt2N1V5dHNBOG9wUHJu?=
 =?utf-8?B?Z0FyaFIwMC81ZDVmeU1KQVhQcTB3STBoSDRuSW01ZXVNdVpQbEdtMnA1MEpQ?=
 =?utf-8?B?eXZzZ0xuK0VVc1FFdUlWUUsvZk1YeDIvTUZsMnlRN1NIb0F6Q3BTVXA5OStK?=
 =?utf-8?B?eUJKaTJpOWtuTzROTVZyYnlFMStkQnB5Sld6TFFVL01CL0MxdE9ZZWoyWGNk?=
 =?utf-8?B?ZEMzQWFyM1YvbHpJclRqZG5xdm51MzFjeE5NWENaZmExQTJKbGo2czZxdVdu?=
 =?utf-8?B?S0ZqQytTdHN1ckttRStCUUg2QS95MExybGhqN1N5NXlHZ1F3NTIyWElzRUdp?=
 =?utf-8?B?N2pGVTJXa09lQzdYWmtaaTFGUG5zNmtjQXMxakRyOXpqNVVtUE90aGRsTy96?=
 =?utf-8?B?UDVKbURSUDYyRXFURjRxRnVwMnlSOGJ0cSs0cUlOYmtlanBIZ2dUTm5WdGMv?=
 =?utf-8?B?UktlSVV4RWdFeXd1ZE9icGpoaDJDUUpjbDlOV0lZUnVSYmNyVDEvNnRmNjZz?=
 =?utf-8?B?K0IzejBEWDREUmZGZG9UbVJyRkhSSUxMQ0JyQjlGK2tXM015bmczT1VpSi9w?=
 =?utf-8?B?RU9kWC91UC8rVFZuZkNmaXQ3RVFEV290b0luMGpETTZXYjVGTzdDc0ZXVTFD?=
 =?utf-8?B?T01rM3hpR0diVHlaMjZFNytCejF1NzkzREtUWkczVE1OZDdSNXZQSExGZU5p?=
 =?utf-8?B?UElSWVhoRkR0VGRxTENDc1JpWTBDdTVVUzY2NDNmSGtpNGtWWXhJRlJIeUpw?=
 =?utf-8?B?Nml3V2ExQll1eHZrc2ZuZDZkeTQvZzVvUmY1VlkyaHRMb21xV2UyNHdjRGdI?=
 =?utf-8?B?SVYzTFNPZ3BmaVpvZ2N3OEJUUXZZSThIU3ROek9MTWFGYUoyTE13OUtCR1M5?=
 =?utf-8?B?Y0JRalU5VmxraGZ3ODFOV2t4K0dCK0NWNzA2blh6WVlhK0I3RUpUaW50Qncy?=
 =?utf-8?B?ZUlrYldRQzF6TjkvLzFrZVBRSjFxazdsN3psYlMxUkx0ZkF5RktTNVF1N1lv?=
 =?utf-8?B?OUN1TEVXUXhVcGtjT0E3TjdMZ3dKcmJ4N1dzT0dCeHRpZzV3MEFNcWJuN3pG?=
 =?utf-8?B?N2graDVKdk40QjVDSUJYTnkyUVk0TVloOUdHSnZkT0s2b2tteUJ6MWNlRTNF?=
 =?utf-8?B?aDc2cUtBNXMzem5kSFB2Nk5pMWdpdTNwd1U4RWhoRHlCVmg2WVpvMDBnL1VR?=
 =?utf-8?B?Q3B2MUdxMnNpVDNURVhQcTVRU21xUDVtQUIwZXFTaUtGY0lRQmRqT1FMR3M3?=
 =?utf-8?B?OElHM3JsUCtNSFU0NFYzZjRVRWZWcXVhN1IzQjNCKzlpY01KVXRMNmtoRFZx?=
 =?utf-8?B?d0lGZUtZaHYzaXd3K2YwcXZRaXpOazhGZklzVjVEQ3BWRlJ3b282VWNBTXhW?=
 =?utf-8?B?Y0tMUE1oN2RMNnozMnVvTFJhS0Zsa2ZlVm42cGVjQ0hDWUE2TEQ3UUVZb3h6?=
 =?utf-8?B?Si80RlRzS3FocEN1ZGF6dmorZGZKVXpsYXZnVENENUxtMTJ6bHIwWW5waHpX?=
 =?utf-8?B?OU5jMjV3K0pTdGNRaW5ZZk0rNDJHc0wwV2htUUZHNkxzRzhmZE1sWGdxZDli?=
 =?utf-8?B?T2lQVGplbVBhdmRnbHp2MHhGTUtWYlhOdU85UVJHOFNINWtqNGpiL1d2MGZP?=
 =?utf-8?B?VjFjR2JjMmY1UStlaTBJV3BQZkNOZ3pZK2d5UWxyUmNuMUJja0Yzd2FEWWtS?=
 =?utf-8?B?RmYrUzFvQWRTaUJJVGx1TmF1UGNSc3E2cGltT2Y5TXlVbVE2dmdOUlJmTzdx?=
 =?utf-8?B?eFAyZWQ3UGM0VkROUGtLWTV0N1pDYXA5a0xiTmpvdG82QTNyYWtDRVR0NFhU?=
 =?utf-8?B?dFllbFRVdWFYWXY5WHE5VzZkTVJxZlJtbzdLclF2UVdzNFV5YkhFSVFRb2xR?=
 =?utf-8?B?ajE3azRrTWRXUW1oaFpWbEVrSkJIM3poQnk5ejB1clErQ2pTVG9hTWZQU0o2?=
 =?utf-8?Q?XHtIaNRWWA4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OTBFREdIbXpieUNMQ3BMKy9UeG5pUnQwVmIwUDcwcnY1RFRwRDZRczhLWWFq?=
 =?utf-8?B?bFFXbE1kQk45RnRFc0tkUjJTMjlEd3FPbURZa2lhdUEvNXpNaGtGQW9NcjBh?=
 =?utf-8?B?WmFYb1NOd0QzWG5Pd1NsVlNBd3lqVGc3R0VGdTBaVFd2MWh4YjZDamRKWUVV?=
 =?utf-8?B?QlVYSm05TE5uSjNIZXFzRHA0VWhUeWIyeXVJQWJoMEpFVmR5Mk9pL3JaYTVv?=
 =?utf-8?B?anJ0T0FkZnRYQ3dHajAzZTdNZERSVU1PQXpKWm9Qems1M3J5OTdFMGlIL09Y?=
 =?utf-8?B?MzFmckZrMHV1RkVJNjdEZzlWN2xuQlVWb3MxWUk4V0owcnRRc2ZMeWxqS2JU?=
 =?utf-8?B?ZmhVTzVZSG1vaXNUT05COCtUc3V4Rm1UOE9EUVRteW0vYk1mMkx4Q2lvNFBW?=
 =?utf-8?B?RzlmQmtJMjZ1WTM1eDc1RmtLYWtmTElEWGlRdEUrQktGNC9TSUsxWlQ0UUxL?=
 =?utf-8?B?ZXBMcU9CWWdpNmdWSENUaHNEdjVueHlGMUtnNEdkclI5Sjgzc1NwL3kyZndp?=
 =?utf-8?B?T2xoUWJ6MFJLdHlNREJlNVlwNmRnaXh4ayswSEhTVXdRRnJBM08zRjFTTVlv?=
 =?utf-8?B?MzhKSXphQXFkRU5uUVZkMUJiaXRpMVJ2bVNQZTdSU0xuQjdpVlVFcXRxcHl6?=
 =?utf-8?B?UHNROXFOUWg1UzVSMFFZck9kMXNWS1FqNEtXNEo1VG91MFQxTkE2UXprNGo0?=
 =?utf-8?B?YzVsa2pld2RlYmFUNnFxS0YybkoxYW9rVXk4MTVUT2gvRmhTYmFoM3BNOExZ?=
 =?utf-8?B?Zis4Tmxqd0FWN1BYejVHb0hCcS8wUmhSMlBVK2E4aWJRN3hWNjZSSDR2dU5W?=
 =?utf-8?B?OHhQdFMyUWIvQzI2VWtMSWovbnV5MXJLZ21jeGluSzE1bFZpeEs1c2dIMTNE?=
 =?utf-8?B?QnFSdzJBT2ZZZmhMd2xVSWtUVWpvZGovakVGZDdrY1N3U3NGVnpTVWVkVzZM?=
 =?utf-8?B?RWZkTkF1SkVkeXVjNEx5bldVbG44VnFLTG8yQnpWcm1nbXFDK2ZxcGdGVGh0?=
 =?utf-8?B?dkVYVndER3owWnNCODRmTTBDck1ETEdUeDhBVzR3YXNJZ29pNGpHNzhjU3M3?=
 =?utf-8?B?M0dvamdKeHZxUWhxM2JtMS9GY0xnWk5XM216OXI4L1BMbTZLNmUyeCtUQTRX?=
 =?utf-8?B?cWNJMWVGWCt3eWlHR3FvcWdRRCtxUTVxTHVOSFlKT1BTWlJWK3g0VGNUNmps?=
 =?utf-8?B?Y1dsZmwzVTF0OUJkZmJvS3UycFBWbnhFc1czeSt6SEhCVUZTTFlUTXcwVmRk?=
 =?utf-8?B?dTBBZDZmS09sNVkyeFdFRXk2c2VseVJTemQyZStOeGh3dmFFRzlmOGFLRndE?=
 =?utf-8?B?NDF4OXhiS2lOVmEvM1RqNnA1ckVkVzJrS1dXNmF5UlJRK1EyaFZ1aTZNdTNK?=
 =?utf-8?B?ZzViSW9MdENwSitXRmZlZkc5YldOUE44YUhBSmJGS3lkK05NQW00WjUyQmRI?=
 =?utf-8?B?TGFpQkRUUjMrK0txYmZhbGR0RWQwNHBlTSszTjJOSTdjU29oOTJmYUV0U3dF?=
 =?utf-8?B?RmdSR05JaEUxT1JkVjRETkQybTFvQmxKVmswdllDeWdQcHY1SFBPVnFYbE9s?=
 =?utf-8?B?blo0UDVWY3p1L0U5Q1k3MEdKOTB2TmU3K0xlWnIrazJpbWhkbWZGaDRkc1ZV?=
 =?utf-8?B?dWNBaEg4dDcyTEZFVE1SZTRzYVlSVnFIUkt2cEhJZUhVMVdrSC9QYVRiTEpP?=
 =?utf-8?B?aVIxMStGUGxIbVlCWHM3a095SEZmeThjR2p0REdDV0xCci85NFF5SG9xNUkr?=
 =?utf-8?B?VEFodExnSjkrZzlDeGR4RDJCL0Y3NzMxTXQ3SGJBMmJlNlZvZWk5amVxaUsr?=
 =?utf-8?B?VG1DK3l3TUgvTzJUZDJsWWRtTTVnMWoyU2dOcC9NQzhwZ2VkbkFkN3RYaGxC?=
 =?utf-8?B?d2ptZ0JJcy9TSlFSYndrY3NUZENwYW1YZlpPYXFrYmUySCs1QnhkOHRFQ3d5?=
 =?utf-8?B?bGc4cWhpSk1vbDFFa0RqeGVjWFVMT3paTDRXcHVYV1VDcjFUNStmY0RYNzJX?=
 =?utf-8?B?bGt1WllCS1l4b0lkSXY4ZWZ4MWZNZVRrRUxZRmE1ZzdrMFdDc2VCRHRmbEVi?=
 =?utf-8?B?MXZkMTk2ZEFmK1JYeWRVTjNOS0NJRHJkNFZ2VDBxMHc1Z2IrVWpwa01DU01N?=
 =?utf-8?B?ZEttUnl2byswNDBJaytoSURiazNsRjZlbGNhSXVmRUJYeEcxbUg4M2dUY2Zr?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y6Y+YKqWzPH1HZrrvSHaYXg0vzYaquYJwUrf9FyyP9FuANamOWt6HIwEBzNH8cYRQ4EKj+DKAz40+hpv7Wa+62m0yxU1eOIhB+TM3mdc5V5dazeoLzOQQaitYy6EQfOjW4meSkMZa7yPmoD54kdBITbmgtTxjM1pPWoof2RJFcmZoPTOELejrFCrwDX+OyPrrIotGcW6NGNUCFZLYC4jZ08qdAEZBO+/9SuIVTO58tDdEC00P9ddJQgI+8ek3pT5XX7J2cXE9+alxYyMK6bYuJiLaL0ALeZKKSIvnovfeG9Xft1h7LI7DgsYMpD/FTkjZRR1szV7z0JFAyJrK9iZaqUVQheoCMIu13iqO6Tn//jyc+v3Va0b5qyW6aMraXAA0IS2i7kBrnEYMiUhvHR/i6Q47Kca0M4tL0hxPSG3LiGv9H5fhoKNwSq/2hSN/pC/MXYMlsbD/wG7jYMSER3IAiFZr5sDMbxwMfeWmJ91/OJiQ5HEb8YywJ+yNhaiY78R5GEfF5VgTCwo1JMQM2+SKKMf7gZdmZ70iOP+RX1rz2p7fy6ENLqeUQU/WZoREtCpxmvHVCwiBFRf3XANPPoDp/7T2UFoEtj6j2qC45eGllA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd6c361-4a3c-473e-70ae-08dda9b40ef3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:21:36.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB8WJZ8kYCxjjf0SFAglR7tZNnpvIYCNs2+kw/laDHtRmLY7psdAi5Jl6kfNMo1veoZpAcaTeFvvKuzu0c3Trg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120102
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684ad464 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TRtTYcYt5kwXhoch:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=kFXj-kT3gpd2NR7mdT8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HiycMAN5HAOCNzksQXnGMQjVKSPvamCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwMiBTYWx0ZWRfX73bGjovRqwNp QtUNgc6LmDsFxAvuZVLqkd9s0W2cwKCsyZNM0goP2GYdPGitJSfkcceJt2Hw/GjgLtCPvL6x1yX xwVB7TXS2ulEz+lUBNc+uOr3MFA6ZCUnPlY3QFDSLxh4JXs2o2Cl1MEi/wrK4HkmVhUAlf4mRdw
 JeIc9E63j3Y579ditqp5mMYB8rirAIghi/xFPQVTOXlInOkl0yXYSYrRte829C8qBNDUg7CCkTh j53OfygMfUY21ugeNNauZNVGVl9InYXXqbcr/vrYPab3pn4IVMeZ8euwTqGIb/+AR6SRPj+t57S dBtRXK5MeB/AZ059D7dSr2zjHjE1e3KIlg2VAuxgZKuGBbKcMWgTnSi/+QJ8LqBSyTP9Bboa/ex
 OunQ/2wYk8d6TlspscnYR8++2y5jTr4vAypGaGNKgpqhGH14PTwHTOgyoC5x072F5jd4yfbO
X-Proofpoint-GUID: HiycMAN5HAOCNzksQXnGMQjVKSPvamCT

On 6/11/25 3:18 PM, Mike Snitzer wrote:
> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
>>> or will be removed from the page cache upon completion (DONTCACHE).
>>
>> I thought we were going to do two switches: One for reads and one for
>> writes? I could be misremembering.
> 
> We did discuss the possibility of doing that.  Still can-do if that's
> what you'd prefer.

For our experimental interface, I think having read and write enablement
as separate settings is wise, so please do that.

One quibble, though: The name "enable_dontcache" might be directly
meaningful to you, but I think others might find "enable_dont" to be
oxymoronic. And, it ties the setting to a specific kernel technology:
RWF_DONTCACHE.

So: Can we call these settings "io_cache_read" and "io_cache_write" ?

They could each carry multiple settings:

0: Use page cache
1: Use RWF_DONTCACHE
2: Use O_DIRECT

You can choose to implement any or all of the above three mechanisms.


>> After all, you are describing two different facilities here: a form of
>> direct I/O for READs, and RWF_DONTCACHE for WRITEs (I think?).
> 
> My thinking was NFSD doesn't need to provide faithful pure
> RWF_DONTCACHE if it really doesn't make sense.  But the "dontcache"
> name can be (ab)used by NFSD to define it how it sees fit (O_DIRECT
> doesn't cache so it seems fair).  What I arrived at with this patchset
> is how I described in my cover letter:
> 
> When 'enable-dontcache' is used:
> - all READs will use O_DIRECT (both DIO-aligned and misaligned)
> - all DIO-aligned WRITEs will use O_DIRECT (useful for SUNRPC RDMA)
> - misaligned WRITEs currently continue to use normal buffered IO
> 
> But we reserve the right to iterate on the implementation details as
> we see fit.  Still using the umbrella of 'dontcache'.

-- 
Chuck Lever

