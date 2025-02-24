Return-Path: <linux-fsdevel+bounces-42416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C4AA4230B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4803A97CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B866153808;
	Mon, 24 Feb 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AJb/wzLb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HqQgO4fO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5812F5A5;
	Mon, 24 Feb 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407036; cv=fail; b=qWVSVCser6sJgMLR4rpleMD/Pdac9q57S+a8JiiP5vslg99FMqX/ibY6r5fCwyy2ev9zye5xiVdAF63AIo6ojk8c4kuUq7w3QXdZI26Lv5StOZND5e61ueshirFJMBiEdiV9DDiADfmtOx8Jfux4SHGhs4MBY2s9+Zvt6dNv+bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407036; c=relaxed/simple;
	bh=D/Xts9kEeY5qY6HunDdoO2E+Rd3NWjI/sYbArhfY17o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOE/zTDh2ZbdUcdBaBMjHBQ8Bf9rIgRaEYXGTiM82Kw36rKzKE+XULVMHL4hAJqjGv+GIIzL61Skwi2crI3ZZYHCwlpitw+0MB0mLq/rSCwTsNJYHWNRsq9JCL1efoP3MVOec0JP0elJ8JwUNZb8N81vgHPbwr06nAJAzTX+oHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AJb/wzLb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HqQgO4fO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMbjJ019916;
	Mon, 24 Feb 2025 14:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2z0+78e+eUhrzsC8/R1q7CU8eMCHDSUCgjPaO7FXQo4=; b=
	AJb/wzLbPLsNNHGx2tqHQtZmsqyzwDVypzsIAY+ejafRYv7wj1PM/h8TM29AkfPH
	vq6iEX5rFRqTGWjL5CQVhGl6Mz0gdRNwg9fJ+mfpzDfVSghqA6+mD8kJA+ytcVzn
	yf77exf4bg6oVkTjOwVmKHxI8fm41zHY49HkRV5wF7n4mESNi1A1zHehT0CLzlFR
	FThxvkUMgzGt4tO0vg0QtVBVdv/LXA16cbaanGWF+mh6v+u01cLlbVGFGKfmO52k
	g8DMHyRXUKr56Ojj293rHBJx+84Ovc3DtVRjwck9PU336UDLXrSRYMOhYv4N0qpR
	O32wQwdkl51jRb9XVONX2A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2apde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:23:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OD92Sw024492;
	Mon, 24 Feb 2025 14:23:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y517q3sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITF7lqSfa1NahEnhy5uiO7lLSM48xODgKn+quAu2pAAgrqAa2nAiMXxiQd1Y12rT/b7pRuw/GGNvllF5vrjUbgRGyeaicqOLw71HEQKp6pwXfNLDx0acvgZeckTgvJY6tkmCMIjYjWei1HdeE/7jZ5FPmMEtBhQHOm410WLjXHcLtMNDabl2JOdZvcbHO/VAEZbM9a4GSa9ylQJqGv0V/SZnVOZZVN27QI7V71z23QwOgPt5s6jWB+FyL3eHZBSK6UAewttHaFDjXp1PT0s9GP8Nicypr0GEmDoEwQcwKziQJUIO9XLq0gZ+y7zlB9lCiOUjSuIfSJct6GU5ErUBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z0+78e+eUhrzsC8/R1q7CU8eMCHDSUCgjPaO7FXQo4=;
 b=YFt1WJQyMSksYVHJJugCaCQd9LLQf37vYH3E9umZfyP5+G6f7sHg9hZQZzynw8m5P6Gjm1MGjkbtZx237f2faIIUmE1sDjG7DlPq9AyZGtx55s5QUFe14Nm/TwGYQ/2jSMj76QPqa3nEBSujp5cJJjV2n4ErWJB8TuHvCKLUgebW3IrruMMnN90q/5MkbbjoI0TiHJ6yOF8VJ9YcsbS2AyI/T5QFE4Ih1zYSMsVkLC5JDxCTxC0tzf9j8GX+GVVrbqg/5AZS3JP2BXIsUpWmLEkHOwDOB5dXmP1fWPqc0LvcGBrpejISJXeICCk2ga/o4NuZpt4Vh3ZoklV6Rbe+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z0+78e+eUhrzsC8/R1q7CU8eMCHDSUCgjPaO7FXQo4=;
 b=HqQgO4fOoVAMvM1jGr0BaxP8u142j1wagpvna3KEh1aRzLyMfkL+up3WzBEXqWIW97bos3mMWg0U2N7sPzw03aCgdlDnbzccuCZdolehicY7EZFeNnwD8lE6Q9/PPN3k1NvnU846o97+HAeTlEa2dxTAwWONcyRWOYa6ZHSYTCs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 24 Feb 2025 14:22:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 14:22:57 +0000
Message-ID: <d1a968ae-7963-44cd-8a14-0d3b42808b37@oracle.com>
Date: Mon, 24 Feb 2025 09:22:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] VFS: Change vfs_mkdir() to return the dentry.
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
        netfs@lists.linux.dev
References: <> <01a3f184-940c-494e-ade2-775e3441fc4e@oracle.com>
 <174036551056.74271.9438990163654268476@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <174036551056.74271.9438990163654268476@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:76::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ac53f3-61ad-4faf-2736-08dd54debb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STNRUWZoUDNUN0lmWUNBQTAvclF4M1htMzBaUWNKdUUvMHJJcWpDRHNvenZn?=
 =?utf-8?B?dHFuUFhvL1J2cVlubHh4NnRnWHpjWEVBUUF3Z2lYNlIrQUVVMmNZeXBVU21C?=
 =?utf-8?B?OEZvYWZROXRqakwwcENDV2FLUklFc0prN2d4RktCT3pUM3hhZXdjelU4Q1Vw?=
 =?utf-8?B?cnZ1L0lERGQvM0Qxbkw5VWt2NVlDOCtQS3ZzMGFHbGorSjVzR21zSWdGUlp2?=
 =?utf-8?B?bk9aWnpTN1RoZHcwSkVpZ2Iyc3A3cE5EbFlrOTdGTC96L2lhUGdoYjVUdlBL?=
 =?utf-8?B?bCtkMEk3OWxhL0gyR2Q2dHd6a0h0b09BRTVlK3VsQllwZDdBdEhQK1RKaFZz?=
 =?utf-8?B?N3VIZ3p3cmROcGRwYzdlUTlMTHpieTBlcVVqUlM2c3pFQTZzM3NtQ1BqUTM3?=
 =?utf-8?B?b2NXUWhFTVRRTmIxZ1dvZTJuT0ExM0hiN0ZJV0EyNU1IWUlrWGFiM3NUcGk4?=
 =?utf-8?B?di9ZNHBtWmdlVmp1UDZUMXVwWXl4YlAxV0RJU3BWYlV5T2lUMklSQ3RxQWFl?=
 =?utf-8?B?MWwwdkhKRHljRXpnWmtmeW91MS90dTNUTDVzWUhBbmFYNDlXZGYwWWJGZzFP?=
 =?utf-8?B?QmNPdG5qS3Q3eW1EWVErMzA0d0xXMTkzaHNrUjBuVTZqS0hsOGNQVUxKMHhp?=
 =?utf-8?B?VGI1RTR4dGNPYllpNHpLcXFLU21jR0ZDYkpWb0tySmFjc295a2hoMTl4ZnJB?=
 =?utf-8?B?emJJcVJuVmxSNmZvZWFEeEFCRWRocW5JTHU0dTlZL2I4T1ZuY1NpRFlxalda?=
 =?utf-8?B?YmhFNGZvWTNiOGhwWmIzTlNrUlB4SEF4YURsMkJnekhHREFjeWFkKzYya2pF?=
 =?utf-8?B?eVR4a1NVeXhyR0tEMlkyRy9VdmIyL0MrbitMbW4rZW9wZVNyOG1pL2ZaUnkx?=
 =?utf-8?B?dmdRUE94OEhTZExneDk1USsxLy9jMzFNczBrY0VUNGgySnRleVFGbUl0QVhY?=
 =?utf-8?B?R054TWpqNlZ1QmtLT1UvRHBzTDhPdHhUZEZZZUwyRUNHUE5wcWpsV1lyREUr?=
 =?utf-8?B?L3RPVldlc2VTS1lIYk5CWFluc01sbWV1KzdsNHYwcmhnS3QwdW5UYkh1UzJL?=
 =?utf-8?B?d1NCRU1NVFJMYnVDd0g5UGUxdTBudGJ1QXpjUFNTRkdJaWlXbWtkYWd3SE9P?=
 =?utf-8?B?UHhDWGhwUGpjTXlzSndIUFQrTkh4bFZVM3BoVlhnZnk3RWpQK2xpMFlDMFl2?=
 =?utf-8?B?QUlwcW5TczZvME9nNUpHbDZqS29GR1o4ZDczb1REUytZMFZkcWUvRFFFK3E2?=
 =?utf-8?B?VHpsWllnT2Y4T25LWkZXdjhOOG9lSXVLS2Uzb3BKTDJuOWZtYm9hVUNtZUU2?=
 =?utf-8?B?RzgwQ2FZcGxBZkJQWG95a0JxYUtXRVRkd3hBT2gzVzlRZWh2M1VyaG0vMEhj?=
 =?utf-8?B?TWg0dk4vSFFnb1g5bUk5SlFkNDM4VUVUWjhRa2lXOERQS1JkZHc1ellyeDhz?=
 =?utf-8?B?Q3I1RnNPbGlXZXdEYUZ4aHlOVEprb05NUlhxSHRnaFV0bWp0NTJRdm9ZaS9L?=
 =?utf-8?B?L2krTitPcEgyMEY1ajFvbElrVU01K2h0UHA2VzNuTDVOV2dxRmp0Nkxjbmc2?=
 =?utf-8?B?bEFBM01CTHl1S1JaZ3grS2lWZGp6TGsxK3VjSVZwMFIyZHdxWUNYanBPSlRX?=
 =?utf-8?B?SnBlNm9ZQlZkVFlhM0ZqL09iR20xVTN4c2RPZ3F2by9NV2lZWGNZdDVmVE9t?=
 =?utf-8?B?NWs3bXo4SWJNTENIbjgzL3VxRGM1azhZZzA5WitnQVBlOHVpYTVwcXFKcHFI?=
 =?utf-8?B?Q1BEM1dibnJKWmtFa2lTbStKTkx3blVqOWxRdmNKY1FiMlF4Rk5MRXdVVmxF?=
 =?utf-8?B?cGJPM21WS1YzczF3TW5tZjVlMnByTlptczVud2FxaEM3NUNyazNyaWs4QTR5?=
 =?utf-8?Q?JY+gKrnByig9S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHJNY0tkS29kaXpSdFBZdGVaQVhCa2t2eXp6dVFwc1NORW1NYTUycEZoaFJI?=
 =?utf-8?B?NUtOcXpxNjdCRkF6VTI5bG9scTVZQ0JDSW5MLzdNVGpjRUJyNVJNb3Fhbjk5?=
 =?utf-8?B?MFlyRkg1Nlh5RFZkK3BTRDl0RWgxVDVOS1BjRExEZVlMelZ6TUNCb211UHMv?=
 =?utf-8?B?ZXo3YnhnMDIvUDhPa1JGUDhqWW9ZcWpnOG00dmVGa21reDNwek9ydmsxWVJV?=
 =?utf-8?B?S2tLVUlVYU1xM2xNRmlCR0FEenZ2L2Fyb1Z6YU9nWncwcWZLRVVvTEVkbmZx?=
 =?utf-8?B?azNMbVJLa3BVaU1RQXRtNmVtUDJVNzRoZzA4ZUFPdFltYVlZSXVWTVp0cWhs?=
 =?utf-8?B?elcxc3pnTlhSaHdFRkJXaTJ6R3RCcVNndTFsUm94SFRSQlJCWElJWkVubzJV?=
 =?utf-8?B?VUxjODJOZVhmNEFQQTAvQWQwT2RPanNZWmlDV2FpcllVcGFSNGNiZGFUMzRu?=
 =?utf-8?B?WUpzdmNpU2RrQTB6bFdNN1hCZTFFT3BoMjF4VnNRTEhEa1RTS3V2dS9aM0Ux?=
 =?utf-8?B?RnZTVklWSHRxaUk5Yk55NmwyaHVISlRmUklUVVlEaTZxdHRVRUpjK3BqVFFj?=
 =?utf-8?B?a1JMcktJU29nVzZrOW95cjNjU3NXU2I4NlIxcmZlbmNuOGtBYVBWR3J2aU9K?=
 =?utf-8?B?aUZPQU83R2RKeDdhTmVlQytJdjd0TXI3ZUVsTkZoL0E4K0I0QzVaVit0eFZm?=
 =?utf-8?B?L1hGaGdvekFWdzRLQU1rTnROUklxUzBBc3JqTWppU1FacFhsNEtDSUhFRzRm?=
 =?utf-8?B?NlRpRE8xS1lOTm5RRTNNWS9mRDZQWlh6MGFZaU81OUdua05rRnZXSlhrcWRM?=
 =?utf-8?B?NW9NSVlEdElWajd2M3d5bCtwUEI3RlZ1UlFlVkYrMlVBbE9PTVBCSm9na0RO?=
 =?utf-8?B?U1BXM29IZGtIRUFCdFF3eiswNmQvRk9yM29rMU1RRm9vckkyK3FoYVJteVla?=
 =?utf-8?B?TnBRcXM4RnRTK3FaRGw3TjRabmVqTVpaOGxhOTNwWndjTWhHZlUxNFBOaURF?=
 =?utf-8?B?L2VvMUNvc1hEMnhLdnNFUTJ3QVlxdUxKZVNtY1c2SktDRmhKOTJTYVhQQWtl?=
 =?utf-8?B?YW5aL0tlU0xJV1YwTHpJMkxoeDdacDFkcS9MRU1TRnI2SWdZWG1GUmcva0VW?=
 =?utf-8?B?aDFwRUp1MmtGUDdSRy9ULzlEOE5uYytiTi9WMzVYdk9uYlJ2STVTbnJpckVW?=
 =?utf-8?B?NU5pMDViZ2RYZVhBZ2dTUmpCRFBZK0w3U0gzU1NTYXhGS2ZJVldtdzRFQWdu?=
 =?utf-8?B?djM0emFFQ3E4aldkZTdaUWl3eG43ckdmeWhtZHA4TmxDSERjNW80eWxJVExK?=
 =?utf-8?B?LzIxdWRXeHUzWkdoem1iVXRvdDVVdmdqd2o4OTBBV05PdUtWZHpJVnVRU2Z2?=
 =?utf-8?B?MHdMMTAwdWNRTDFaUTNQNTY0azh1UDRQOEdMYWtLWERLRUtVemsrQ1FOYlNo?=
 =?utf-8?B?a20vZUpDYWVJSzNUdURBbmN4WURVdHVMTjF0WlEybUxWWTl6VlBvU0k3djEv?=
 =?utf-8?B?QTNiZ0J1SElBcTNlRklsYWdpOTUzQ2hEY0FRMnV5dktLM0trbVhZRkZnNVY1?=
 =?utf-8?B?amhnUlZXZThFQU83RklPWjdYbkVHNWpoSS9xWjdtcHFVQmxCOTRxUFhkQ1ZK?=
 =?utf-8?B?aHZ3QkVMQTF0dmZEdzgxUEx2UFNIcEozcEN3ZExXYlNFQ0phaFFKYXJWM1VB?=
 =?utf-8?B?bHdGL1I0OVNrbnljWGc0Z3JMUTc0WktzNy83d3pIRi9kWGZMNis1SUFYY2c3?=
 =?utf-8?B?bVFzVjNQTEZwME1yMlN4VFlWT1JCbzBWN0FlU1JPejVOVmkrKytzeHVRZTlx?=
 =?utf-8?B?UFNMWlFGSzJ1ek1EKzVFSERPSi9aVTVnVHpFakNaeGxSTTI2cit2Z3FseWhj?=
 =?utf-8?B?WS9EUjBZMXBIT0FkNUlFdmo0R2IzQ0h0U2I4YmJRc0M3YUVjVk1mZFlKZU43?=
 =?utf-8?B?TUJmTWQ5cS9mYlIyMkZWQnlXTWV6UnZaZXVGeExSaVpyV2s1dUpKOEF4ajZO?=
 =?utf-8?B?RlF0RkNHQUpDNG5jZXYwK1FKSjRTRlQ4dkJRcllyN2FRdGhRYkZtQno5VE96?=
 =?utf-8?B?WUR1RjNDRkVtSEVjdE9INFJoNHJpZURXMUhnSGhZa0IxZk9rT2F4dnBmNVRW?=
 =?utf-8?B?NkhqTFd0Y2thYy9mR0MwMTBPSDFjTWNwOHdmbFJpcVZudWFuemdnNXh4TXMy?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NOBG5T3wJd29X4yG6ES94/D81wT8TjjafcVAz3r9GeOwRvktzYDiOWYk+spTcPKq4XvgsSdMaxmLcnTc02+93SXNL4H5roZfwtJ1K6Y4tIMUTEC/Haa6wbNgEtp6udB33dg+kCGfElvJuXTBUxIpjrfXoxSRtdm4plS77YBwVqx4a3ZV42eHt37r7i3AB6EcJz+XZgYsVvR1rdW13atBMolZNcciHo0t423XCp/KSMlIXQVaUjQaNm1hTvLOYnLR2xB4rwQeRMwW7WjFtEW9JArREZuqNOnUaWt39r1btLM1PGmL9Y+2/baE+CsKQwE0wgGtSy1cMGVU5OYdDLqK9oiT2WuXrPkhKKtNRB6V4+uT3HQoZ4guzXlFDJVCsldh91tkQIr/UwUqoNjIlPfrXzzQM7tZFqispYIdiVlLIgfeqvA/OTnlbdxHLgJ8PDuE+F/WX6KnIaXCS/zx+wIwth8dbVIOm6ev2vA+QGX0kziruueoWKkkFZHYT4+qivYY4r8X/T7+yekJ5/DDCty7NLb2GX8oJ9IHpQkRO7trQsww8Rym2/hDjoQf3sz8Y4AWUc68l/Uvvbai39JGCADSSN7LU6G8rASz2QfXQGioxhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ac53f3-61ad-4faf-2736-08dd54debb96
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:22:57.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgPx+iVxGOvHBsE9yryys0fdwOAUIR5hA1cbVJh2UIgC/EK3cSOFZmedhyzdscD80cudLJ01zx4DyhrPcWtUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240104
X-Proofpoint-ORIG-GUID: xi9M8wVWBf6MxAEJgwZfttBesbw45jk7
X-Proofpoint-GUID: xi9M8wVWBf6MxAEJgwZfttBesbw45jk7

On 2/23/25 9:51 PM, NeilBrown wrote:
> On Sat, 22 Feb 2025, Chuck Lever wrote:
>> On 2/20/25 6:36 PM, NeilBrown wrote:
> ...
>>> +		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
>>> +		if (IS_ERR(dchild)) {
>>> +			host_err = PTR_ERR(dchild);
>>> +		} else if (d_is_negative(dchild)) {
>>> +			err = nfserr_serverfault;
>>> +			goto out;
>>> +		} else if (unlikely(dchild != resfhp->fh_dentry)) {
>>>  			dput(resfhp->fh_dentry);
>>> -			resfhp->fh_dentry = dget(d);
>>> -			err = fh_update(resfhp);
>>
>> Hi Neil, why is this fh_update() call no longer necessary?
>>
> 
> I tried to explain that in the commit message:
> 
>                                         I removed the fh_update()
>       call as that is not needed and out-of-place.  A subsequent
>       nfsd_create_setattr() call will call fh_update() when needed.
> 
> I don't think the fh_update() was needed even when first added in 
> Commit 3819bb0d79f5 ("nfsd: vfs_mkdir() might succeed leaving dentry negative unhashed")
> 
> as there was already an fh_update() call later in the function.

Thanks for the patch description verbiage, and sorry I missed it.

Even so, IMHO this belongs in a separate patch instead of buried in this
unrelated API change. This doesn't fix a bug nor is it necessary for
changing the return value of vfs_mkdir() AFAICT. At the very least, a
separate patch makes it possible to include a sensible reference to
3819bb0d79f5, which is helpful.

IME these tiny weird looking warts often have a purpose that is revealed
only once the code is made to look reasonable.

Make the fh_update() removal a pre-requisite clean-up to this patch,
maybe?


> Thanks,
> NeilBrown
> 
> 
> 
>>
>>> -			dput(dchild);
>>> -			dchild = d;
>>> -			if (err)
>>> -				goto out;
>>> +			resfhp->fh_dentry = dget(dchild);
>>>  		}
>>>  		break;
>>>  	case S_IFCHR:
>>> @@ -1530,7 +1517,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>  	err = nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
>>>  
>>>  out:
>>> -	dput(dchild);
>>> +	if (!IS_ERR(dchild))
>>> +		dput(dchild);
>>>  	return err;
>>>  
>>>  out_nfserr:
>>> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
>>> index 21c3aaf7b274..fe493f3ed6b6 100644
>>> --- a/fs/overlayfs/dir.c
>>> +++ b/fs/overlayfs/dir.c
>>> @@ -138,37 +138,6 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
>>>  	goto out;
>>>  }
>>>  
>>> -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
>>> -		   struct dentry **newdentry, umode_t mode)
>>> -{
>>> -	int err;
>>> -	struct dentry *d, *dentry = *newdentry;
>>> -
>>> -	err = ovl_do_mkdir(ofs, dir, dentry, mode);
>>> -	if (err)
>>> -		return err;
>>> -
>>> -	if (likely(!d_unhashed(dentry)))
>>> -		return 0;
>>> -
>>> -	/*
>>> -	 * vfs_mkdir() may succeed and leave the dentry passed
>>> -	 * to it unhashed and negative. If that happens, try to
>>> -	 * lookup a new hashed and positive dentry.
>>> -	 */
>>> -	d = ovl_lookup_upper(ofs, dentry->d_name.name, dentry->d_parent,
>>> -			     dentry->d_name.len);
>>> -	if (IS_ERR(d)) {
>>> -		pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
>>> -			dentry, err);
>>> -		return PTR_ERR(d);
>>> -	}
>>> -	dput(dentry);
>>> -	*newdentry = d;
>>> -
>>> -	return 0;
>>> -}
>>> -
>>>  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>>>  			       struct dentry *newdentry, struct ovl_cattr *attr)
>>>  {
>>> @@ -191,7 +160,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>>>  
>>>  		case S_IFDIR:
>>>  			/* mkdir is special... */
>>> -			err =  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
>>> +			newdentry =  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
>>> +			err = PTR_ERR_OR_ZERO(newdentry);
>>>  			break;
>>>  
>>>  		case S_IFCHR:
>>> @@ -219,7 +189,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>>>  	}
>>>  out:
>>>  	if (err) {
>>> -		dput(newdentry);
>>> +		if (!IS_ERR(newdentry))
>>> +			dput(newdentry);
>>>  		return ERR_PTR(err);
>>>  	}
>>>  	return newdentry;
>>> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
>>> index 0021e2025020..6f2f8f4cfbbc 100644
>>> --- a/fs/overlayfs/overlayfs.h
>>> +++ b/fs/overlayfs/overlayfs.h
>>> @@ -241,13 +241,14 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
>>>  	return err;
>>>  }
>>>  
>>> -static inline int ovl_do_mkdir(struct ovl_fs *ofs,
>>> -			       struct inode *dir, struct dentry *dentry,
>>> -			       umode_t mode)
>>> +static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
>>> +					  struct inode *dir,
>>> +					  struct dentry *dentry,
>>> +					  umode_t mode)
>>>  {
>>> -	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
>>> -	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
>>> -	return err;
>>> +	dentry = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
>>> +	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(dentry));
>>> +	return dentry;
>>>  }
>>>  
>>>  static inline int ovl_do_mknod(struct ovl_fs *ofs,
>>> @@ -838,8 +839,6 @@ struct ovl_cattr {
>>>  
>>>  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
>>>  
>>> -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
>>> -		   struct dentry **newdentry, umode_t mode);
>>>  struct dentry *ovl_create_real(struct ovl_fs *ofs,
>>>  			       struct inode *dir, struct dentry *newdentry,
>>>  			       struct ovl_cattr *attr);
>>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>>> index 61e21c3129e8..b63474d1b064 100644
>>> --- a/fs/overlayfs/super.c
>>> +++ b/fs/overlayfs/super.c
>>> @@ -327,9 +327,10 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
>>>  			goto retry;
>>>  		}
>>>  
>>> -		err = ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
>>> -		if (err)
>>> -			goto out_dput;
>>> +		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
>>> +		err = PTR_ERR(work);
>>> +		if (IS_ERR(work))
>>> +			goto out_err;
>>>  
>>>  		/* Weird filesystem returning with hashed negative (kernfs)? */
>>>  		err = -EINVAL;
>>> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
>>> index fe29acef5872..8554aa5a1059 100644
>>> --- a/fs/smb/server/vfs.c
>>> +++ b/fs/smb/server/vfs.c
>>> @@ -206,8 +206,8 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
>>>  {
>>>  	struct mnt_idmap *idmap;
>>>  	struct path path;
>>> -	struct dentry *dentry;
>>> -	int err;
>>> +	struct dentry *dentry, *d;
>>> +	int err = 0;
>>>  
>>>  	dentry = ksmbd_vfs_kern_path_create(work, name,
>>>  					    LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
>>> @@ -222,27 +222,15 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
>>>  
>>>  	idmap = mnt_idmap(path.mnt);
>>>  	mode |= S_IFDIR;
>>> -	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
>>> -	if (!err && d_unhashed(dentry)) {
>>> -		struct dentry *d;
>>> -
>>> -		d = lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
>>> -			       dentry->d_name.len);
>>> -		if (IS_ERR(d)) {
>>> -			err = PTR_ERR(d);
>>> -			goto out_err;
>>> -		}
>>> -		if (unlikely(d_is_negative(d))) {
>>> -			dput(d);
>>> -			err = -ENOENT;
>>> -			goto out_err;
>>> -		}
>>> -
>>> -		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
>>> -		dput(d);
>>> -	}
>>> +	d = dentry;
>>> +	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
>>> +	if (IS_ERR(dentry))
>>> +		err = PTR_ERR(dentry);
>>> +	else if (d_is_negative(dentry))
>>> +		err = -ENOENT;
>>> +	if (!err && dentry != d)
>>> +		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(dentry));
>>>  
>>> -out_err:
>>>  	done_path_create(&path, dentry);
>>>  	if (err)
>>>  		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
>>> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
>>> index c287c755f2c5..3537f3cca6d5 100644
>>> --- a/fs/xfs/scrub/orphanage.c
>>> +++ b/fs/xfs/scrub/orphanage.c
>>> @@ -167,10 +167,11 @@ xrep_orphanage_create(
>>>  	 * directory to control access to a file we put in here.
>>>  	 */
>>>  	if (d_really_is_negative(orphanage_dentry)) {
>>> -		error = vfs_mkdir(&nop_mnt_idmap, root_inode, orphanage_dentry,
>>> -				0750);
>>> -		if (error)
>>> -			goto out_dput_orphanage;
>>> +		orphanage_dentry = vfs_mkdir(&nop_mnt_idmap, root_inode,
>>> +					     orphanage_dentry, 0750);
>>> +		error = PTR_ERR(orphanage_dentry);
>>> +		if (IS_ERR(orphanage_dentry))
>>> +			goto out_unlock_root;
>>>  	}
>>>  
>>>  	/* Not a directory? Bail out. */
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 8f4fbecd40fc..eaad8e31c0d4 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -1971,8 +1971,8 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
>>>   */
>>>  int vfs_create(struct mnt_idmap *, struct inode *,
>>>  	       struct dentry *, umode_t, bool);
>>> -int vfs_mkdir(struct mnt_idmap *, struct inode *,
>>> -	      struct dentry *, umode_t);
>>> +struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
>>> +			 struct dentry *, umode_t);
>>>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>>>                umode_t, dev_t);
>>>  int vfs_symlink(struct mnt_idmap *, struct inode *,
>>
>>
>> -- 
>> Chuck Lever
>>
> 


-- 
Chuck Lever

