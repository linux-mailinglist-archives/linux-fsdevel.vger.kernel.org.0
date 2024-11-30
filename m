Return-Path: <linux-fsdevel+bounces-36186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625A09DF226
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 18:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE82B219E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB01A38C4;
	Sat, 30 Nov 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h54W1a66";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aQkjwsQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5638468
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986531; cv=fail; b=HEyz6uLDyUMtxsbSh9SYBfOwDdZx3YbPt/FmNn9t+MT/1O7fn6LX47HBNntuv+aWlPpmPBXZdHB/xtAa1Ou3U+YfCopvvpahJhEryfNaI1x3m+Cn9lsgtZfeQR6orp+trZzV05bUxYlaE37Z6z9Yce5OwuDNi6qfqfQhqeHyMrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986531; c=relaxed/simple;
	bh=MCW9uR1ZzrUPlQv78AXP0D0HKw85b18uL/7Gu1tAoGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kDsNH+OvV4TZFvpopxUrDGYP0nUidgxxIxorH0qhoA0Z/DlmE5RZO3pqznKu+Q5KqAFFZoEjou+Aj3sFZ3NYCBlAR0WSw/vTU10191fTS5tm1In6Py8k2FvH2e64MUDWzTlIsX/Zd3WEup9qpFP2VnAkh5yuPW0/Wthtxnzk3zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h54W1a66; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aQkjwsQZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AUDwgIl015541;
	Sat, 30 Nov 2024 17:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jKGec9c3QUQHQ+SlyUMKAbWE7wCLQdchzjge/tYO07s=; b=
	h54W1a66jzIpw1WolDZJJkrOyQPj1avmaaM0clnKJJe4wwWyYLvHnnijRMmLlzDS
	i4Q26C19EJSVo+XfG/qxyfZP5itJQw2oOAthjXAtZr7F9JALlyr5IQ3XDqIqumUs
	/hG5cDBbg7cR1w2cszbeHgW5p9zj5qVsDLzaJZ0/yYjrDsznQtyYZiu6l34U50cH
	AnPZrQogvZ7r/5kCpb0zgpzS+xc+IV3eOqV/URzTHAyUsYdyiFU5RoTaV380cSd2
	g2ptjFL0zyUORb5GJTzQAlnZIdRYri6ODZReN19+QuGiQSn/YHOQ0+RzfV/79htg
	bjbgD3ixEwXMuu6LMNfBDQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk8rkdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Nov 2024 17:03:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AUCLMQB032899;
	Sat, 30 Nov 2024 17:03:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s55608r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Nov 2024 17:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ3jUvXOo9x9jGjxpohRE8SWqXA6XiaplFYzG0GqHQoDQEvWANwyhPDGwGsQ5VrM8my1cpvPPHZf4vXXsM3eXU7lywKMpk7jeZlkYpSyCOqoL/GE1K3Z+V7bV+4anyLEMljNy/OM94/QPgep25IynClBbug8rgeL97/5l02W3XSUBCCkQS18TQyG8xPEHDzc0PlrwzsXs1Hbb+0Sv9mKs6RAhpk3krKET8EVLBBW1ce86yyE0DdEQzzvysK/Omjtn0lv7qV13OJ23EO92mgdytaZ6sgOD9Jq2ETfyYTB5pmqMeyRmyu0GNFqBfz88dXNcky0YxgJcuJmyojx86gK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKGec9c3QUQHQ+SlyUMKAbWE7wCLQdchzjge/tYO07s=;
 b=LIEvf2fjLhkKMaspbemI9Q8eGL0ncOH1b/VMYBuD0LzBXJa96LYHCJZ/J1M9mKDlV0BkY8wfUPzupq+Bg7WD3RtwZkdg6LNCUJt4oDfBn2WF5JxoVzQLwgyuiTIW5DkC9w5GRFuL+TFNAv5xE+Ujf5CVuRGPqqVTrlbtS4V5ZuB/OSSf+sj9p2uKST/yGJp6CdvlNTJsX1npUSK9IBxw5s345siWTkhfFEt5NqY1yJf5s26tzfx6UlDeaeCSwigXKgxPkIMKGIpDRqraxeua72zxBBcn213eFNnnTZ1d6JZ1q65C5D5P7ryvEazZs8NGGi/mFQ9Kf+0Tc3iIbflARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKGec9c3QUQHQ+SlyUMKAbWE7wCLQdchzjge/tYO07s=;
 b=aQkjwsQZL/mKBWLdE9TvQe7rJURARVmx470n50gEKiqCmPBSIrEIB49GFOijzyWeNQqLZwjTExae4lG8++Xcrj5EwzBr4TfrIKq2z7yoaXU2yr+ZIQtxA5aL22q0QYDTIB8LlOZ58LZGDhtgQ6aU6XME/c+84Uu3N1ReCBYAml0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7007.namprd10.prod.outlook.com (2603:10b6:510:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 17:03:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8182.019; Sat, 30 Nov 2024
 17:03:05 +0000
Date: Sat, 30 Nov 2024 12:03:02 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: cel@kernel.org, Hugh Dickens <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 2/5] libfs: Check dentry before locking in
 simple_offset_empty()
Message-ID: <Z0tFRkq9kxREW6vg@tissot.1015granger.net>
References: <20241126155444.2556-1-cel@kernel.org>
 <20241126155444.2556-3-cel@kernel.org>
 <6917283e-d688-a133-9193-ca5d6255dafb@huaweicloud.com>
 <Z0cudKvYImrmbBRF@tissot.1015granger.net>
 <234243c3-7368-4824-6c1a-ff9eee4e10ba@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <234243c3-7368-4824-6c1a-ff9eee4e10ba@huaweicloud.com>
X-ClientProxiedBy: CH5P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: e25537fd-7b33-49e2-50ce-08dd1160db85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGNmV1R3cnVveTFQMUVJMkVaNUVGZkk1T2RPTzU5VW92RCs4SDQ2Y3U2WEFT?=
 =?utf-8?B?NjZKVExDeTBxejBXNUxsRUg1b2J2bjdWSStIOTJIUkVnKysvd0NsZXMyQ3JF?=
 =?utf-8?B?TUhwT3N4UTNDS3FGRlN3eWxvWElmOThhR1M1RzBFOWp2dDl1QXZzTkN3citB?=
 =?utf-8?B?c2thNXpGd1RXbnMzYnBCeXlOVEdOQS84YWI0dlBxYmpJNzJOVEdQNXRCY3Ru?=
 =?utf-8?B?MXZzVEp5MDljVm42V2hRYlNOQjErNjBGTUI4UFZPbnoxZTBQUHJpdFlSWTJv?=
 =?utf-8?B?aTBSNVYxNnlHa2w1VmtMbmZWeWxlc0oydlQvd0Z6dXF0VnN6a25ESFRrem01?=
 =?utf-8?B?OEpEUUxVVDM2S1lOVlU0c0VyY0Mya2FsWFVUV2dTZ1FUeG9nMm10YVZvc0la?=
 =?utf-8?B?RHB3S3ExZmRIRXNGTEZSK0Z4VjYycWF5enRkd0Zsa1c0ZDNRcllGeVVxaDVE?=
 =?utf-8?B?aXpDM3hOTWJjMmJHOG1PZXRiQUlpZ3JXMzNNdXp2K0YwMk5SaGgvSFVwQnR4?=
 =?utf-8?B?VDlJcmhCMFNhTDViTXpDeXJZYnY2OXRydy9BUUtLbmNRdXZBc05Lb3FsVVEx?=
 =?utf-8?B?KzVka2w1cVh1ZzlLRldoYXQ2eENmckxYUjhweXppdEpudHcvaUFNV2RISjY5?=
 =?utf-8?B?dEo4TFlzSHdOOUhDYllpNmtNU1hHamUzbnplSWxuQUJxRnFGNXcvaWxUbUtU?=
 =?utf-8?B?TVdoZHlXYVdkd1ZNUzMvVVcwWW1pQjFKUXc1MCtYSGx0Sy95ZzE1NmZSOTZt?=
 =?utf-8?B?RmdqS0FNUGNTY09vVDhUZ1owTzk2aklpVjN3anQ2SjZJQmM1OXlWRTNNTUJY?=
 =?utf-8?B?ZkRZWHJTUlR1VDZyM0JuaThuSHF0S0FNMmRHRTRMNzlIaTBPSXEwK2JvalhN?=
 =?utf-8?B?TTMzWUFMSXprVUpQWDh3eTJyRkhsb3N5YWRMYUR0cVZlNDNJa0pwaWpkYXVD?=
 =?utf-8?B?VG94ZDlxN3p5MzQyYTROVWU1YUt1eCtpclNvQ0d2YWlXeCswdSsrYnIwcWpE?=
 =?utf-8?B?M0JrdzRuZFM4Y2h0YTBLZEFrcXcvbTk0c29RQS91bCtVY0IxaXV0aW92OVhW?=
 =?utf-8?B?bkl1R3BGRTVjaFE2Y0ZUMmQyYndETXJHMmdnenViOEptSm1xNUQvNzg0MnMz?=
 =?utf-8?B?Q1V0VWhjM2d5SG5wWXhqK0ZaV1B1MjFZZElGMVUrU1BsMm9SMlU0RC9IYklw?=
 =?utf-8?B?YnNONXI0VStCTWlINkJrdXlTZDhQbno3Ly9qbUE0TGMrdmUycUtMdHpZamZH?=
 =?utf-8?B?NmlEMjN3UnBzbDQ0WDg2MDI5UXNGRFM4NXJ4Nk12b1UvYXNZY1NnUE5McHFm?=
 =?utf-8?B?T1ExYXd4NERpOE0zak1oZVZoZHJIOUZ0d2xuTjBESXNyUlBiaExvUkpUdjFq?=
 =?utf-8?B?bG1id1ZsZFA1UzNNWUZkd2xCZDBmczBPV1BzTmtsMEpYR3Zuc1lNdUZ3SGxX?=
 =?utf-8?B?QnNkN3N0cElyallJS2MzN3Fvb2t2VU9oeE9jOExuREZ0WkI0bFcyQWZKY285?=
 =?utf-8?B?SzlEYUdoaXFaamdPWDNwNU9RamxJbjl4TUMvQVdnOEY5K1N4dE5Qc3Bwcm56?=
 =?utf-8?B?OE1NeXJ0Qkh4dHp2NmxHQ3c3WlpPY2hpQk91c1dDYmNaeTYrYkg2OE9qc2hH?=
 =?utf-8?B?NHhlVUJIU3BQeXFnaWVnKzNrZmxia2doZ053ZytLSU9hbzVhZzQ4R0hEeVlG?=
 =?utf-8?B?b3VsZS9RSEIyclVJSSs5c2VvVm5SZFVJOXFwa1R0SWxvbHZENlhkQW95VU90?=
 =?utf-8?B?ZUYyQWprMUpBNitodUlHcmhiUitWT01WR0xZYXVMaU1LYUpLMlN6VDl5V3ZF?=
 =?utf-8?B?d3hvYW9icGEyYVdsRDJJUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnRzQUFKZmxzNTg1dngxYkRFbkVUSm9sTVBBVDV0b3lkOGVLdzV4NjNsUHNF?=
 =?utf-8?B?MlZlUCtnazJEQ3NUNlJONk9kMEdPM0NLTHhDa25jU3NOWmtnZHlWYlZiWWY3?=
 =?utf-8?B?dndWZWg3K2srNGZ2UDVTTlU3aUp1Wi9RNmdYbFBvd2c5anJ3Q1plemtlQmdV?=
 =?utf-8?B?Y2VNemp1am5sMHlvdEhMaHgxUWJ5dFZHQU5CZWxwL1plbzhxbE1kOGlrazJt?=
 =?utf-8?B?TGNJY2swSy9ReFFaZm53WSs2MDlaSzhBcW16K2ZwRi80WUdoVzdnd1VDRzNH?=
 =?utf-8?B?WUtnbWh0bkJzMkJCNUl6MWNaQmFidWxQZVRrYllzZ1czQmJIOHdETTh4SXIr?=
 =?utf-8?B?T3JWQkZIZTBYV2JmQXZXSHNTUlQ0WTNkRGFtQzZRcTRld1o4VzB3VXhyNDRt?=
 =?utf-8?B?YTJ2ZFNwdE1TZ1lYK09NY21ZazNHWGNkU0hVclBiNFREUTZGY1puQlFMc0p1?=
 =?utf-8?B?UnY4YnQ5aFlEYjJQMFRFUkNrb1pqOU41dTNKMXd2RjJZU01qeTU2c044YmZX?=
 =?utf-8?B?YlYxVDVRM0xoamIrdXc0SnJ3SUxQa0JRU3phUHVickNOMW1ReU9nczBpWVZm?=
 =?utf-8?B?V3hCZHVoYjV0c0dpY1MzZUl2Rkdna2JaVnNXcklTcFdPam9lbG9ZQnF4TVJR?=
 =?utf-8?B?MFZOS3czT0NsdzFFOGhjV3h5MDg0c1d3TVhZZktSeE11bHpkQ2N1UkhzRW9p?=
 =?utf-8?B?eHhVL24rSTVvV1RKRHIrVHFJVmdXNjJ3TXRKZWFycEJSdkZrdmh1S3dheFNy?=
 =?utf-8?B?OVFoY0l0ZnZhWnRwWTRDRGRGV29pRERQT1htRGFiaEVEc0dSY0lNcUs1ek04?=
 =?utf-8?B?STdabEtHalhNTlA1RWJSUjVwOG5BOGc0cm1zZnN0dDlVSTRobFZFQmM1bjh4?=
 =?utf-8?B?UGJ1WU5kejBqbWZFSURBUkE2RzBINlpESTBTTVZJSXlodElzZHhUaTg2b1FT?=
 =?utf-8?B?SEkwaHVmeTZycUZsdCs0NTFUWTdsVUd2MnpxWjU0K3pOYUpKYlBnb0ljdzZn?=
 =?utf-8?B?K2NVQzRqSjNqb1Buem8wd2JyT1Q5TVY2K0FSYm1nU0RNVEVRaFRFQW96Y1FP?=
 =?utf-8?B?TmpHVUJJK3JGTHYzc1dkSHd4WGcxOWtVeXBNWTBGYmxONjZIODA4ZmhWL1pt?=
 =?utf-8?B?UzJQem1vR1JQayszTjgwSklrcGRBRWJEZERGRGNINnY3Z1lPbmx6SXlyMjVZ?=
 =?utf-8?B?eERRQng0Zm9NQzdhbm1jcGkybUlwMzg4RklidUc5VjVoVU9rNDRqaDRVZmIv?=
 =?utf-8?B?c1NEVVRxTUk1UGdKZFViRDE2ekpDbkZlNmtWNEU1eVk5OFJZa1R3SDA5WlZ4?=
 =?utf-8?B?RzVFTzB5K0dUeEk3WDJMaEV2TVV6bzJ5cWppNDRxSENsVk5pdnp5VFdjcS9i?=
 =?utf-8?B?Zm0rMlZWeWxYd3VFSmRqdFhFT1hrcEJjazdpZjJwYnFId0JrK0RUbGNBUzgx?=
 =?utf-8?B?ZmJhZGhFS2xoYmM1V3JyenhRVUtYRHQ3SVFvUDRGY2kyQWV2enphSmRwcDQx?=
 =?utf-8?B?SmJDNHJiMmN0RzM4cCtZRldSVEhBTGQwN08ydC9mYmlLRk14Rjl5TXZnNmh5?=
 =?utf-8?B?S3I3SWhwRnJISVp4Y1dZdnpFWjZ3bUlHcnRxNjBobG5ZeEhVUjY3MUFjd25T?=
 =?utf-8?B?ai9vUFN1a2RLU1JCSi9yTG13a095Qkd6dk1GQTZIdmxGZCt0ZUxrQVVSRnpB?=
 =?utf-8?B?QVRZSTJaeFVUNjRoQnlzMGxvZm84QVJNeWtuaHp2aEE0bHo2aGtKdEJTSGpq?=
 =?utf-8?B?aUhVYld5czhLblNZZ0tMb3ZUZ3FSM2F0NTl3RXNGUnU3dUUvb09hYUJqTW9R?=
 =?utf-8?B?dmgrNElweUNxWjJ3dlkzdDVHaWZPOWN2YnZRVFI3aGs1ZXlFYlhhR0dtam8v?=
 =?utf-8?B?NWo4eDhta2plQnBBRURPSVY3Tld2Y0w4OW5TcW1xQUMrdWdCSVJidDN3STBB?=
 =?utf-8?B?OG9teGJUamh3MUVYM2ZvV284Sm16NW1XSHpwaWdVQjM2bFNscXdWaW0rRjRT?=
 =?utf-8?B?NlZUQUtpN0Y2cnFaRm80UmIwbDFLTkFPV21GcUpyMUVrNEpxNERPNHU1L0Fw?=
 =?utf-8?B?TnEyWjJWR0pEd0wrQU5VQ3lWZ2ZocTVPa2pkQzgrRDFXOVk2ZmxlWnFCeXpk?=
 =?utf-8?Q?TpQnlFkFuOGKpUuJZO/U7p0vt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XOBrk4B9a+btQay+Yttg+nTTsEBcFiuLw4ULujcMhP459cNEGsHSzdUu6dwrBJEe8bV71HmWmc6h7ITubQBPMYSxb1uhB+apEVGwx0HXOvXirHerN48ew/QVrOsaUUY8t8brBrG/ftKUhG5SRAjxC1sZpMovPv0lEBeKOVXWga9RnMSVW6vS42RSa54CTfWPMubfST+P6LaBWIcsyIBAcq+E9cdUuK/GzGfbT6Kr1TVs7+MbTyYa01drOOsR10VatU33bNBA18zOZ+jEy4mCQzNkWzOEN5NmIlOkcfGJSX1zuqijsy21EQCwJqn45OTBttZNNeugRcB5Xp46lwiaj4ZPpEulJIGIJAB0GUZnTF5hV//axAHtOBRQ3OxLl0kBy2u0sYcTC5V4VOLZhYtvlCJva7wF27vUyk7ZsXcJQvrgUg/Ghuab2GXAgUy+zgipovP30X95IvvAWaebG7+XyaTuPUSyYJ8gNEjwUOfQYoDlThOk26AVdnKnNbRPwPXEXVh//cnFBw51f6nk9q4oDl+29m8NSIqexsVwFHamap8WSwuvF8daadnWfS+qeje724VUEdBae0qoLpgbSfGRYSRdRdZvTvcEdaNkAl3WvHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25537fd-7b33-49e2-50ce-08dd1160db85
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 17:03:05.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM6N79qT1QCz5R+thC6LmxAqefpvN+PwhYeU928xtESk3KEt9ICnPjjz5SpqS62jxenO4MHOqgjm8g5VcGFHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-30_13,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=627
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411300142
X-Proofpoint-ORIG-GUID: kEDpPDW7lp3OtYyTexkyTBrZOWQHCKPE
X-Proofpoint-GUID: kEDpPDW7lp3OtYyTexkyTBrZOWQHCKPE

On Fri, Nov 29, 2024 at 04:17:56PM +0800, yangerkun wrote:
> 
> 
> 在 2024/11/27 22:36, Chuck Lever 写道:
> > On Wed, Nov 27, 2024 at 11:09:11AM +0800, yangerkun wrote:
> > > Thank you very much for your efforts on this issue!
> > > 
> > > 在 2024/11/26 23:54, cel@kernel.org 写道:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > Defensive change: Don't try to lock a dentry unless it is positive.
> > > > Trying to lock a negative entry will generate a refcount underflow.
> > > 
> > > Which member trigger this underflow?
> > 
> > dput() encounters a dentry refcount underflow because a negative
> > dentry's refcount is already zero.
> 
> OK, so you mean dentry->d_lockref here.
> 
> But I cannot see why we can trigger this, if it is, it's actually a bug...
> 
> Can you give a more detail why can trigger this?

I think it is possible for the mtree lookup in simple_offset_empty()
to return a pointer to a negative dentry, perhaps due to a race.
There is nothing explicit that prevents a dentry from going negative
while it is still stored in the mtree, although that condition would
be quite brief. So, best to harden the "is dentry positive" check
there so that it acts like other dentry locking code in fs/libfs.c.

Perhaps labeling this patch as a "clean up" would be more clear. I
will remove the "Fixes:" tag -- it does not fix a bug in the current
code.


-- 
Chuck Lever

