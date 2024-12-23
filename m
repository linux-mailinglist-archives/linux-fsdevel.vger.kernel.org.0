Return-Path: <linux-fsdevel+bounces-38060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C3B9FB04D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 15:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD9418848A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE41ABEC1;
	Mon, 23 Dec 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SvlGK38o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gnF4DqMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCE3208
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734965129; cv=fail; b=aHvlcOCo6jvZlNAN8PVl/D103k5DwHV+sMzx0LwMAti99rGVM4D5ZWo/43oPwiaLTeDTTMUiEjcpKnD5reoDxO6vzTZISr/3vERXWM74HmTTANtrY4cZS2FanJW5Ef70ZsHVLK/KAHpzESRqrAayOXZ6UCMqFcsKBqEfj9X0ZZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734965129; c=relaxed/simple;
	bh=54QPbW67FN9z5av2J/JlxZSUj4grdxQglhE4djaPYSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fhYL3y08ElapBVw5zhrMk9z7ur5omfatNewJawn15fhFiMCRva9lJN8BJAjSAfYZ0rZ94q5s4bYZ1xwcD23Oj249UyW8EFTzkVahtYTY3+1CHCDmYZJCnmAliodkxI/O2HBQT/dMzo9BadLKj0CsH2yaEhklEU3IxoSKndndfiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SvlGK38o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gnF4DqMs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNE56nK024819;
	Mon, 23 Dec 2024 14:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=IfmXNF96+NgtsKhCKX1X/3FGIwPRllaUfRECaHLG96U=; b=
	SvlGK38oFeteX0KytfhxGlXFHXxSquygp245FzCM1zDNr4ktJuxWx4YowYGXyVzb
	gm7pS/cCrrwnJgthRRWdrAqLWW5ULlSy3izcX16218AVZDaVJUvlc0KdEvCS3KhS
	kjjvOB53kRi35LzNT2ozTFBDjofqDXjbRvj1LZhilByeWHJiHNhhZ07oNte2ygss
	3nKMwksFQhPYP6mOC4XU9vavUs1Srd+tCIrxcAEUTP4fG0dkBrIJpBo9u3qo8IW2
	wIiriVDdwhDkImao3oj0PoO8h/lRaF86V+r6TR1xnzCAsB9Nu+BG8Ocs4f2ScQ+J
	FFYzjwcRWIT5jEqFfAqAgg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7c2kq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 14:45:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNCckpn016651;
	Mon, 23 Dec 2024 14:45:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4d9a6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 14:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC8N9qLb6L6ojM5w8XC4SMvCXB/2G2ESlMAwaxvfMgrT+d3FVTj+YfLTHbK0Vtjo0lzHstSgGSKgvQmWAtCivgUs3yJ0DwwtYe+TvtagOiWGk/fBhNinYRNF8qnrQXFfni2ACHQEwRfkEd+6jZTvSi5LWZYt/nsU1lc0JEnoz3urQhim7xtppJiVzvyiCb6GeYlwUL9bCRn3Nhjt2uqOgdw7YcMA8JoEsHSuPwmW8JxsUvXVWfZ7mAJEi7DgMY158Ldn3y7rXo8ojlp6LKpIuvrLaOhQqeV773j8OG/MXvVGYg5MMmtiMv4KBtMptQK/AnHQGKFsKL01AFpQFkKwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfmXNF96+NgtsKhCKX1X/3FGIwPRllaUfRECaHLG96U=;
 b=A9Pig3LcXx5mOCtUB3sMoghhpj8asWNXLbnhDlvI0IRk3BoqEBBDB+eimWALUdky5OG8bJWkXUWz+SJgVs9EWYxAVsLBQsD28NlepPwlS2zIwPURsWASGwnoD0YwG3jpJB9PjTi6PimSMfTPvUVDq6PXZLFtBIQbphV1RPdg/Wx/kCCBkL0ORqRB3tr5B6nTCeCY8szpaWPT5NitBhEczP83LVfO6HfQIpJRWe9uDzrRV4F5NZF8ZefQDB1mgsBGz0J1sPN4d9sN4dmzHEPAiyPHVv2Yfb4ZhEud7E861j+4t31p7LeoQBaOY02If/T/olGni8rBVfI7MCm7IZ0glA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfmXNF96+NgtsKhCKX1X/3FGIwPRllaUfRECaHLG96U=;
 b=gnF4DqMseYzi1Srfy6qgOgkHky4kcSfTA/3zWRFy7DUy8gn+JY7MJruQ6SIwfq1m0XnbkyJT4VWajkfYQ1R6wp6Gmbxjkba/aNw4cpw3gHPzxTjcx54uJOYCGQ3BTXgQIHpDDFRn6E8R03qI+0wY28yBniAAI51DDr+lzuuGIy8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 14:44:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 14:44:55 +0000
Message-ID: <fcae58c8-edcf-4a42-a23b-4747ccbf758c@oracle.com>
Date: Mon, 23 Dec 2024 09:44:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] libfs: Use d_children list to iterate
 simple_offset directories
To: yangerkun <yangerkun@huaweicloud.com>, cel@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-6-cel@kernel.org>
 <3ccf8255-dfbb-d019-d156-01edf5242c49@huaweicloud.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3ccf8255-dfbb-d019-d156-01edf5242c49@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:610:38::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4527:EE_
X-MS-Office365-Filtering-Correlation-Id: a6af34be-2f3f-4253-8d07-08dd23605d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVFocG03QUVUUnRCeFprTDdSNC9RYWNJOElsYlZUQUZWa2xZbmpCT3ordzZv?=
 =?utf-8?B?N1V3dHBSN2RhTjlBV25TYkFCc0h6WStBZHN1blgwWmtyRGU5dTh0eE0vbUw5?=
 =?utf-8?B?SldYMkJWVURwWit1MlU5aDdjVllJcU5wSFhMczNTVERMdWtoMDI2dnlxRVZq?=
 =?utf-8?B?N2pIMjFaVkxaaHM5WmRWRDNqS0V5bFMvSFI2ajNoRWtUV1FEMWx6UzdGa1lx?=
 =?utf-8?B?bGlPUEptaUM4SVV2RGJBN1FJTDhhemVnWWpzbVRMVkZ5QzZoRUpHbFBrSWJJ?=
 =?utf-8?B?clRLQUFwWFhOdURpMEpRN2V5Z2lkMDI5Q2JzcEJOYW1wMjVmMjFxTFB2elVV?=
 =?utf-8?B?bkdjTkR2M1dSNTB4L3FyZnhKUDZCQ29vbXI1WlVHN2ZNVnZZTVBQTTR3bElo?=
 =?utf-8?B?NW9OUXhjMFlROEZ1dVNRNUJqdWZiVEdNZE1lUjd4enhXTXltcmNzcDNkWWRB?=
 =?utf-8?B?ZGlNKytCL0h4UVRUWTVVMVBmbzhoNDh3UHgyeGdHbjlnUEFLdGozSHlkRG9s?=
 =?utf-8?B?TFZFT0paVVpkeEhjV0lybnR6S0cveERIMXVKWlQyMXpwbjNTWXZveFdFYnh0?=
 =?utf-8?B?TWx3a254STByaU5CelllY2NhMlVJd2tvWmdQbDZqWTVmMmhQb3BzVVJjV0Zu?=
 =?utf-8?B?T3hlWHorbzVpUjJrNzFUdXRaWGdSUjZDUXV3d3Avaml1TVVFQXBibTgzS3FZ?=
 =?utf-8?B?ZG10VUFnUDd1MFk5Ukk1RkZaSEg1aklYRXIzdWhyVzZRTENteVNwS2FtWWVZ?=
 =?utf-8?B?T1Z1OFpLTHJNdVFpWmFTV1UzWWdJZS80bDVKc1hnR1ltdzQ4YW1vOGJLc1Bx?=
 =?utf-8?B?ZVNINzR1S09qdUNzMWR2U2FJQ2c1c29CbjJ3UTNLbkRUZE1FeC9PUmQ0bFdx?=
 =?utf-8?B?RVVlem15Z3R4TmlHUVVBRHd5VWlqYnVrMDdBcm82aTZmc1o2Qmo3a2JwdmtZ?=
 =?utf-8?B?Tm1PRmc1L2lINW9hd25qemJsZnB6c3VoWmk1aHpaWW1kS25ySEF3d0xxZDc4?=
 =?utf-8?B?T0RwTEdJbTZxQnFEenpnOXFsTC9xdWtXdk9zRm9tV0thUnZoNlJQNSswYitw?=
 =?utf-8?B?S0ZmN25xSDBDSUY0K1cxNHFJTHMxRVdrWTlnbXhCNHZDV3RNNXZLZmFDamRC?=
 =?utf-8?B?c2lxeGtxVWk5ZHBha3M5d0FGbW0rakl6TmZKMllOUFZYSEJlYlNSN2F6MTUw?=
 =?utf-8?B?THptK3g2elJ4eUFncHY1SzNsZDZodklUamFxbkRVQTFtV1cyQ0ttdVluZ1c0?=
 =?utf-8?B?NzJpMUc4Y0sxOTJzbEt3Uy9Ub0ZWTGNERFVRRVZTR0hVa1lhbVAvRmFXUUls?=
 =?utf-8?B?cXlla25YL1VuU21DTnl3ekh5YUlFNFJGNmg1ek05UnNYcjMvdStRbnE3aVRY?=
 =?utf-8?B?SXhMb3p4L0J5bEN0ZGE4ZEgrSTdLY1R1bm5meFNDSmNyWnc1aVhFUk41S1RJ?=
 =?utf-8?B?YVJ1dWpGVnhIdkFRcDEyaDJFOXEyTnJIdG5ZMlgrQ0U4OS9oV3dlanFaVHJ3?=
 =?utf-8?B?ZHh0UlJBKzdGcTVXeWFoOGhJME9heUVpYkx5VjZ5Y09uT2ZCZE5mdUdmMWxZ?=
 =?utf-8?B?VW1DVDRQRVpxVEtxN3Vhd3dVUDZ6NFNqMGRGelI0MnhucUFtQXREUWJ5Sjh0?=
 =?utf-8?B?OUJVcWNNOU9kU3Y5bUk4SXFqMDBzOVVzZE9lTmhmbllIaFJwN1BwRHlOS0Np?=
 =?utf-8?B?TXZLeWNpcFVKMExnTEFMMnI0RmVuYWVNVkh0RVhYNWhGcmROOVM5VHdsSG12?=
 =?utf-8?B?ekFhK21lOHlTeGZSUlVhcnoyMUc3Wlk4d1Axeml3cDJaY3ExaFVMR1gyR0l2?=
 =?utf-8?B?YWJLVlJqbGU5QjMzR2hMUmNON2l4bWQxMFRJVDJjZkgwNitUV0owdjdrTEdz?=
 =?utf-8?Q?IIVR8fJ1fqRob?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1E2d3FnbDZ4ZlNCQ1piNzJ6RFdMcHlFQUZYY1NFUmpLTklZOWovbkcxRkpL?=
 =?utf-8?B?MjlCdjV0a0tNbjZKRU04YWtBTzR4TC9WM25SbUxNMU9JUlpFSHQxYmtFTE1J?=
 =?utf-8?B?eDVwQ2FxREw5bXFtbXRlUU00K0E1YWdVNHd2QUhSaDdBYktBZWFHOEsyZFRI?=
 =?utf-8?B?SnM0djJPYXQvcFBlTDVqUHNnZ3BiL1lLOGg4ekgzZUFrbjdwNU1xb29LYklY?=
 =?utf-8?B?c28wNTdLQVlQUHZqK21GcTFFbklncDRDZUozVlVFdVUrOWlNbUVENmk2bmk5?=
 =?utf-8?B?YmJWb0t4dDNTUFJyQVZXUEVGUFRSdjlLQ3Z4Wk9zUWhFcjVxeDB4ZnB4TFVE?=
 =?utf-8?B?ajNFQUc3LzBpUGNWUHNYR3pSMEhnVGVoRms5RGxuc2x2R05oajdzbjVNRFVL?=
 =?utf-8?B?Umh1RVBqaC9GUWkyaDJUcXFGK2dpNDJxa2tHbmJjcG9YTWJvMjd1cVd4dU5m?=
 =?utf-8?B?MDNZcXFjMTE1cC80REZGdlFrRS9SQjBoRDlFUlMzeDJMUEExYW5WSk1LZVV0?=
 =?utf-8?B?WnB0VHpIZ2FOaXpYajNFa1ZFRk9LaWFWT0FNNUJ4Rm40ZWlIK0lkMTFOV0d0?=
 =?utf-8?B?ajFIMVRHdUZWaHYvSHcxY1lGQzRxdTlVb0FaWXFRa3dFeWwzK2RYMkFJNkJM?=
 =?utf-8?B?Q0NmL25jNkxhWUtlOHZrd3hNK3lodDN6ZEV6TndLSVZCZHc3QTQ1eXA2alJQ?=
 =?utf-8?B?M2FyN0FJc2NQU0t6Z2lrd1NRalZKZ2tuRGowWmZKSTV3Wks0L1NlYytwSXJa?=
 =?utf-8?B?cG12ZE83M00rVkR5WTJ5Z25hMVN1YXQ4SklRQmdrdTFIM1BaczNJT1ZXV0Yz?=
 =?utf-8?B?MlY0R2VzMkMvb3BYUmJCcW5JNkNaWnNkM1JEUXZoRHhsMUd0Q0w0b3N6anYv?=
 =?utf-8?B?bjZEcWVEL3pXYXd6eDBqVUdHTmFad2NrZTV6ckdXVzM1U3ZmbGo2UlNMSy9s?=
 =?utf-8?B?KzlweTZDMVR4QU0ySEtQZTR1ZXFQZkFVZTBJb3Nid2p4ZDFjVjZEekMvWnJh?=
 =?utf-8?B?Q1kyak9FbzJqc2ljZFdTdGZZeE13eC9BT2E5a2hhaXMyR2FSbFNmOUxXNXhq?=
 =?utf-8?B?TFdWSVZFNHVYeEZ1eGpPeUNCWkN2MlE3RjJvQURYSENHSVNkd3dCTTMrZ2xQ?=
 =?utf-8?B?K1dzUmYzUjAxdlNyWEY3RVJJdXpNcnplUUh0eXdnblhhVGJyNTMwL3prRlBT?=
 =?utf-8?B?TGpzOVlpTVp5TzErZkRDVDFrZHV3cmYxeGpOQk1VZjd1eVJkT3haeGtjZWdK?=
 =?utf-8?B?T3VsQnM0QkZFWitBTXMyaS9MNFhBQ3liaHBzUDFQQjJwR1R6OU43cDNoYWdu?=
 =?utf-8?B?azd6eTRhRExKWUZBMm1Vb1h3Yjd5VFB2bWQ2ZjY1UEJVeWRGRU1TcjNxZktH?=
 =?utf-8?B?V2JaVWNObDFjQlpQY1VSR0M2WVFXU1JRK2s5WVBRVmtrMC95V3FOVkNxdjBz?=
 =?utf-8?B?R0RsRXVlTlhVYWFGa3hvWFpJaXVuMy8xeHZsa0hxdzRZUG16SjY3ME5qNGl6?=
 =?utf-8?B?UU93T3VUUGNpbC8wRVliSUFuMG1rdHV5QWJUaUhkVFk5bm5lZSthQk9lczhm?=
 =?utf-8?B?VXM4YkI4a0x3eXI5RE5KdHEzK1pyUlA1ZnMxSGs0cVlnNDg0UUNxUmU5Slkx?=
 =?utf-8?B?d3VlRFhBZy9CUzFDeVhybFAvaGF5aHFUdU5hMUNaZkZ2U3lsam5NSzFVZExz?=
 =?utf-8?B?Q0xydXpwWFltcDhBSFhaZXM5eXcxQjNQcTNqQnFkdEZLYWphWlp5VnFPcXJZ?=
 =?utf-8?B?ejFkVlR1b3YwbVpkcnVOamRuNDB2Ymp5d1RvUi9wSDREb0JhOFo2MkJHTWxq?=
 =?utf-8?B?QklvNlNkb0EyRXQ5UjdCdUc0R1hVWkpFT050eDIwMUFGenRaMmRaUDVZR2hn?=
 =?utf-8?B?aFhPSkorTHI5WkVjYTB3QlVQdkF5cFIzTzkwRlRxZFlOdEFjVFByLy84MTFx?=
 =?utf-8?B?OGZnRjRGQ3lrSEtHSmFlOTRjZk0vdkRCeWpBc1A3QVVUdEFhSUROTTZPak5x?=
 =?utf-8?B?V2ZoTmVMSGg2a05BUHhMOW5ESDJMOGIwS1duSGY3Syt4MCtyejA0dEhTSlZZ?=
 =?utf-8?B?YXMwTkVGMzU3OW9SUG8vcmhCUEN2ZEozK2R1OWZCanMrZ2R4b05INHhSbCtB?=
 =?utf-8?B?TUYvUHZDck1CZTJkK2RuRFFqUG9pNUg1NnE3TFJsZkNXdHptRVUxOEo0ODhR?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p8CnjEy024r8/ZUs2VlmkyA4NC4Kdu7myfMiXFu3M/EIDvw9l5/f89t9W5CokeSnKYtBoyXUidQ2urZhHspzJ9rF1kLDwXuB0O6N/17/oGsLMj8+Tsk911+9/0v4oq8urBQ2/xQ2mexbR3HAaIDkjIwyxq4XwAPIAjQ4k7QpYfkBnlKdOsLfVF7p5Wb3a38eWXMw5wSEwjW2hwRLRGcOINYguG2EJ/lzWt7J6okwwAdtgbOY9sblKNs2JwDwb+7Oot+u45v+AGl8zQ+ZFJZlctXcM64+EZt9qd0yo25WxmNcI3iXk1xA5IOhLYIwmY8MdCK6Ff7vIhmmTiC/CQ7uBIAUmlv2OIY+sytaDLgqg62fSfwEAOUQ75WgsEoUnwb0wvlofIVUqefOdWhZrQjPf9y1xAGyPTcEc9PNT8mzlwEe8XHZdvA/Nozfehvc0FdAu2MLCbQ3EctiXwQKs1LW/l5L9JeI+Kp9+GVQl2FTo5ZhkWWrHM1WYot3/cbZT9RBBL4e4buGFi3x7L0ZgSMJ3zRpdcaeoDZ4A1FsP3y+w59Aham2PmOjG+I92XbYMnXml5084/c1Z8aMu7qVUPIHJIgarIuiBM9EiJSTBjDx+hw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6af34be-2f3f-4253-8d07-08dd23605d8e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 14:44:55.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43TKJsccfnBeBi1NOQS04hazk9fMttv2EV4pJsWlkd+7MfXuNw8PT3XXMyB5tRlslnEVMkCVyUp4HNGRACf+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_06,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230132
X-Proofpoint-GUID: _kQfA_fzbmOB80D0PVhIawJ4QNmKLIIa
X-Proofpoint-ORIG-GUID: _kQfA_fzbmOB80D0PVhIawJ4QNmKLIIa

On 12/23/24 9:21 AM, yangerkun wrote:
> 
> 
> 在 2024/12/20 23:33, cel@kernel.org 写道:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The mtree mechanism has been effective at creating directory offsets
>> that are stable over multiple opendir instances. However, it has not
>> been able to handle the subtleties of renames that are concurrent
>> with readdir.
>>
>> Instead of using the mtree to emit entries in the order of their
>> offset values, use it only to map incoming ctx->pos to a starting
>> entry. Then use the directory's d_children list, which is already
>> maintained properly by the dcache, to find the next child to emit.
>>
>> One of the sneaky things about this is that when the mtree-allocated
>> offset value wraps (which is very rare), looking up ctx->pos++ is
>> not going to find the next entry; it will return NULL. Instead, by
>> following the d_children list, the offset values can appear in any
>> order but all of the entries in the directory will be visited
>> eventually.
>>
>> Note also that the readdir() is guaranteed to reach the tail of this
>> list. Entries are added only at the head of d_children, and readdir
>> walks from its current position in that list towards its tail.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>   fs/libfs.c | 84 +++++++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 58 insertions(+), 26 deletions(-)
>>
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 5c56783c03a5..f7ead02062ad 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -247,12 +247,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
>>   /* simple_offset_add() allocation range */
>>   enum {
>> -    DIR_OFFSET_MIN        = 2,
>> +    DIR_OFFSET_MIN        = 3,
>>       DIR_OFFSET_MAX        = LONG_MAX - 1,
>>   };
>>   /* simple_offset_add() never assigns these to a dentry */
>>   enum {
>> +    DIR_OFFSET_FIRST    = 2,        /* Find first real entry */
>>       DIR_OFFSET_EOD        = LONG_MAX,    /* Marks EOD */
>>   };
>> @@ -458,51 +459,82 @@ static loff_t offset_dir_llseek(struct file 
>> *file, loff_t offset, int whence)
>>       return vfs_setpos(file, offset, LONG_MAX);
>>   }
>> -static struct dentry *offset_find_next(struct offset_ctx *octx, 
>> loff_t offset)
>> +static struct dentry *find_positive_dentry(struct dentry *parent,
>> +                       struct dentry *dentry,
>> +                       bool next)
>>   {
>> -    MA_STATE(mas, &octx->mt, offset, offset);
>> +    struct dentry *found = NULL;
>> +
>> +    spin_lock(&parent->d_lock);
>> +    if (next)
>> +        dentry = d_next_sibling(dentry);
>> +    else if (!dentry)
>> +        dentry = d_first_child(parent);
>> +    hlist_for_each_entry_from(dentry, d_sib) {
>> +        if (!simple_positive(dentry))
>> +            continue;
>> +        spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>> +        if (simple_positive(dentry))
>> +            found = dget_dlock(dentry);
>> +        spin_unlock(&dentry->d_lock);
>> +        if (likely(found))
>> +            break;
>> +    }
>> +    spin_unlock(&parent->d_lock);
>> +    return found;
>> +}
>> +
>> +static noinline_for_stack struct dentry *
>> +offset_dir_lookup(struct dentry *parent, loff_t offset)
>> +{
>> +    struct inode *inode = d_inode(parent);
>> +    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>       struct dentry *child, *found = NULL;
>> -    rcu_read_lock();
>> -    child = mas_find(&mas, DIR_OFFSET_MAX);
>> -    if (!child)
>> -        goto out;
>> -    spin_lock(&child->d_lock);
>> -    if (simple_positive(child))
>> -        found = dget_dlock(child);
>> -    spin_unlock(&child->d_lock);
>> -out:
>> -    rcu_read_unlock();
>> +    MA_STATE(mas, &octx->mt, offset, offset);
>> +
>> +    if (offset == DIR_OFFSET_FIRST)
>> +        found = find_positive_dentry(parent, NULL, false);
>> +    else {
>> +        rcu_read_lock();
>> +        child = mas_find(&mas, DIR_OFFSET_MAX);
> 
> Can this child be NULL?

Yes, this mas_find() call can return NULL. find_positive_dentry() should
then return NULL. Kind of subtle.


> Like we delete some file after first readdir, 
> maybe we should break here, or we may rescan all dentry and return them 
> to userspace again?

You mean to deal with the case where the "next" entry has an offset
that is lower than @offset? mas_find() will return the entry in the
tree that is "at or after" mas->index.

I'm not sure either "break" or returning repeats is safe. But, now that
you point it out, this function probably does need additional logic to
deal with the offset wrap case.

But since this logic already exists here, IMO it is reasonable to leave
that to be addressed by a subsequent patch. So far there aren't any
regression test failures that warn of a user-visible problem the way it
is now.


>> +        found = find_positive_dentry(parent, child, false);
>> +        rcu_read_unlock();
>> +    }
>>       return found;
>>   }
>>   static bool offset_dir_emit(struct dir_context *ctx, struct dentry 
>> *dentry)
>>   {
>>       struct inode *inode = d_inode(dentry);
>> -    long offset = dentry2offset(dentry);
>> -    return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, 
>> offset,
>> -              inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>> +    return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
>> +            inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>   }
>> -static void offset_iterate_dir(struct inode *inode, struct 
>> dir_context *ctx)
>> +static void offset_iterate_dir(struct file *file, struct dir_context 
>> *ctx)
>>   {
>> -    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>> +    struct dentry *dir = file->f_path.dentry;
>>       struct dentry *dentry;
>> +    dentry = offset_dir_lookup(dir, ctx->pos);
>> +    if (!dentry)
>> +        goto out_eod;
>>       while (true) {
>> -        dentry = offset_find_next(octx, ctx->pos);
>> -        if (!dentry)
>> -            goto out_eod;
>> +        struct dentry *next;
>> -        if (!offset_dir_emit(ctx, dentry)) {
>> -            dput(dentry);
>> +        ctx->pos = dentry2offset(dentry);
>> +        if (!offset_dir_emit(ctx, dentry))
>>               break;
>> -        }
>> -        ctx->pos = dentry2offset(dentry) + 1;
>> +        next = find_positive_dentry(dir, dentry, true);
>>           dput(dentry);
>> +
>> +        if (!next)
>> +            goto out_eod;
>> +        dentry = next;
>>       }
>> +    dput(dentry);
>>       return;
>>   out_eod:
>> @@ -541,7 +573,7 @@ static int offset_readdir(struct file *file, 
>> struct dir_context *ctx)
>>       if (!dir_emit_dots(file, ctx))
>>           return 0;
>>       if (ctx->pos != DIR_OFFSET_EOD)
>> -        offset_iterate_dir(d_inode(dir), ctx);
>> +        offset_iterate_dir(file, ctx);
>>       return 0;
>>   }
> 


-- 
Chuck Lever

