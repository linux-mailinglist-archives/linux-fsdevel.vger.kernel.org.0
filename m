Return-Path: <linux-fsdevel+bounces-38473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC7A02FD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF781885772
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F641DF75C;
	Mon,  6 Jan 2025 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kfoYOaS1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XauQOlXz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A91DEFFE;
	Mon,  6 Jan 2025 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736188656; cv=fail; b=guzX1ip7BwMKWKDV9f/cHAD+Yo35G9/S8invMhsfCBjOO3N7CA51pN65P/sN0OvcOe3/t423OirbkWnRUPx+R86jp8ovdVb3ZJjYzJrU94KItSdY5KIcIhQj5Eu1mskvcCTas0UKi04idSXu4haP/bMQ/uBDE3cDbrSABeo8EY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736188656; c=relaxed/simple;
	bh=E0kIqelTldVKb0xtWBp1duMpNwMsRYvNBS2uSubeUJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/lcRQLGOnn4vlBi9bKDmGsrLDGLbp4NlBiL2ttr9UPlTa3u4CRpG3U0X3MHrXTkiMn4A0OXzE0yQvI8ee4UgvDxh3t2yMRpz/zywyBZWpIiKny0DmUh3rm+/886F6FLq65Agkeuzni3ccSfodYVR1WqBTSTIDDMopVu4bKOOqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kfoYOaS1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XauQOlXz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506HtjH5024544;
	Mon, 6 Jan 2025 18:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KgbAEtNdQkXBFa10f+XWJsGkFjs8qzCrvp7AW8Lr2G0=; b=
	kfoYOaS1tJN91G/EH5bRRMAwNT8+J415cL3ih7LY2X4MUYdAXUkfxlVWjOfY7Pm2
	TZk1fx66WnQSV+1w1g5Z9StF/fdlPJ/f8HmBzIzA0fL+tUcUxD+DJTh1z4uYmImz
	OsxTC3DXOylKfheYOP6zQigeng/+pcDUa+zMDvYtUUdUyJbE+oJ5cAD8NyB19iHi
	k59LTaoK5vKKkeemIN8L2IP1Bq544NfEHQmJlPZr+egm28XRr7bPlAVCSKtvJH1T
	bJ4heFdvFJ+9ndCRiKXqQ5tY5k6TFTzNAeT8npP8SA7jiN61t/y4RP+yyd+fs2GS
	oHy2bes3LfCHgY/AsdWMLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1btxft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 18:37:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 506GwFA7004853;
	Mon, 6 Jan 2025 18:37:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue7knmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jan 2025 18:37:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nA/dYiv4nQ9gOidPpUpL7WwBV03QIsmQqzlGxL8TmBuDbhMB/bClU1Dpo+oeK2GPfkCAYJZVhSo8I4mOstha3PjTMls5dcmdTQgM+CMv8CECPtulDcJI5ekjIsO4scz80rDhtE0ehOqPM+WTEseedavSEuZ91N7K23kj1c6E49TLncXzN5Fl0dbBZtLYO/6hHkTxC0DAZsrayRM5b4Wjtz6L5oylk04xCDdpD42M8ucBLVoKxMrGW6nkM6JZAQsauC7qPL0mmfyX2hPoINuiurLBKVFBwmNoa02dsn9h+YaZ6rj/Twxglkzv3+ux0uXqc+HCOeW0vi/h1+KLBZiZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgbAEtNdQkXBFa10f+XWJsGkFjs8qzCrvp7AW8Lr2G0=;
 b=mI8IWSuyep/48A0jkqEp5BcG2q95bwswoWDdZfcSjaVzc1DvrB7QK5CpwPGIowejuB8GrL4zhIFjdty5pWb4lkugpICAlojvALlBZATRLOsjwMBVifa1vxlhF4soyRo2+PcqEytC64BnuG+nNCYvXWoJ2l3bS99sQ9gbhK1Vp5u445DzhuhmOmO48kgKWaBwOX/TLF3dNuZaXLsZfxh49OW+nvuL6A8JvvS4udBpIAyT7iH/CHKXQAzuPkxSEN5BoBeebikB5qew3wZvQDNNHGgj8YS7wiFXOXBwWtv3lTvF+7iRQrwwxue9YgSVMsrgz5VJD9WA0rpxzuPbPkJBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgbAEtNdQkXBFa10f+XWJsGkFjs8qzCrvp7AW8Lr2G0=;
 b=XauQOlXzc0zbVG4cm0mHXeAnAoBC9eHlYPIu5YGKiLkY7hCUDHhqgiA8vIUzpBgNBxdG4aVmSC9HKHbEgFXuXLlyacJWpaz3wwMpoJfENXgrfQ1ZnNpuDDK2zFL8U+lkNOB/ciaJmZGI6g6x6nYfAXotBoOOfCXu62xPfI9xE20=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN6PR10MB8191.namprd10.prod.outlook.com (2603:10b6:208:4f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 18:37:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8314.012; Mon, 6 Jan 2025
 18:37:10 +0000
Message-ID: <dd525ca1-68ff-4f6d-87a9-b0c67e592f83@oracle.com>
Date: Mon, 6 Jan 2025 18:37:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: report the correct read/write dio alignment for
 reflinked inodes
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hongbo Li <lihongbo22@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20250106151607.954940-1-hch@lst.de>
 <20250106151607.954940-5-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250106151607.954940-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0073.eurprd03.prod.outlook.com
 (2603:10a6:208:69::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN6PR10MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ad6468-83b1-4856-25f4-08dd2e81215f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2dMNFVRLzhlZVZialMxWmthN1dIL1R4ZTRMRVh4U1BMU1F6WTNob3grcmNH?=
 =?utf-8?B?aXl2SGhOc2c1ZUkrMVVLZXhwTTk2dWltOGFweDZlbXJseStIVXcyWDR3aTBI?=
 =?utf-8?B?cjdINS9QU1JjZEIzbTNTMGc4amczT3hUTDVKSjFTSVJMK0V4SGZOV3I1YU5Z?=
 =?utf-8?B?VzZZN2RPS3FXeEZWU3RPejA2UWMrVlBaVGdKRG1nNEoyZ3g4RDcrV25MVWpC?=
 =?utf-8?B?U09PMnRCM1B0ZDZTbVY4T1NXZHVYUDBuSzV0cTJycllobUU2UjQwSEpRbWdj?=
 =?utf-8?B?QXlna3VwbDNiTTVMRVRydUlyMllHcVZwelUvVjNwM3dwY2F6eFhFRmNGVE1n?=
 =?utf-8?B?a1NlK0JFaEJwUGp2cTB0UmhwN2xCSGg1Q2E0eHRjb1NNT0pmejczMTljNkgz?=
 =?utf-8?B?VXI2Z21pNTI0VkZIWnN6clpNWW52NEpkb2NPMEFxR1NKR0I4ZDFqaGMwTHRT?=
 =?utf-8?B?SlMxUGRod0tIVG1qT1BJVWJHZnUrK3VjdUZZQWNDMDZZbDJnR3ROVy9lTkl4?=
 =?utf-8?B?cUNDWUpmRkk3WVBmNEhVMDRlTkhtTGMvcWpCN1VuSzArOGVacktRQXh3cFR3?=
 =?utf-8?B?c2RZTEorcU4rWi9CYkl3My9zYmJsM2czU2VIMDdVL3VjQXdpa1FaYjRSbXZq?=
 =?utf-8?B?bStUamVmcXlGZTFmd0tWeGdZS1RQWmhwejY4aFJiakxGK3diSU5OQStEWVVQ?=
 =?utf-8?B?bkdaSVNYZ0NvOVFldGpiQVpoc2VtVUQwdDhiaDI5cS9wUEx5VkhYOSsvbEZS?=
 =?utf-8?B?eHFFTEF4VXNrMEd4T3ZPTmxuVlJIUmt3bGs5QWlObHVVK0hHTjNUa1d2SjFj?=
 =?utf-8?B?QmRYYmFlZ2V2aW8razU5MXhvbWs5ekp5M0xKVlJRTGpVRkpvSXVYZmlmRXhq?=
 =?utf-8?B?a0U1ZVA2ZGhDbWtUN0ptcXovZ0p1RTNUWUhFdFIxZnY4UjVQZTVLVmc4OXZQ?=
 =?utf-8?B?SHZJM3ZvMmFSc25xNW0yS290SEtDOVRHSU9UdzE3RUdEV1RobTRabUpUeE5q?=
 =?utf-8?B?b0p2dFhNblpzRlN5THJMdGFsTGEwVThJUGdoWng5MXBGZjlKeW9TcHFkSTJk?=
 =?utf-8?B?bXdxZHdCUktPSDFLdHphSm9qQVQ1cm5WY1JyTWQwLy9nWlRBRGJjTWVrelZ5?=
 =?utf-8?B?TDFQNWZUY1JUcnhNL25Tb3BId1BrTDFnQ3lFYkx0VjJNVkErMldnV09TQTNK?=
 =?utf-8?B?cFJScVMyNmgrNUVnSjJRSjl4ZjlYNDR0Q2NxdTJqdzlHTFpJL3J1aC9hRXdh?=
 =?utf-8?B?UEhVOG42T3YwR3dPbGY4dDRmc1FqcnB3bTlUa3BoOHI1dTVyVVB4TVFPbklz?=
 =?utf-8?B?ZWh5SDdoTWJtZC9aMVh1TVBSVlB3eWYzTFhLaFRwZ2k4ZjljL0M4UWEwZTRM?=
 =?utf-8?B?dk5hbGwyOVBrOStFSUZwVE9hallUTEp0VU1udDB4cEoyN1hsZUlweWJ2TFda?=
 =?utf-8?B?cjBITHl3Q2ZGVFJSdkp3WUFZM3k0QVhCcWI4TDkwWU5rSmJoRWFzQVlSYjd3?=
 =?utf-8?B?SGI4Q2g4ZXh1S2RmQWVGUTVnRk9IQmg1czQ5MFhZS1JNaUtaWXFVblp4VzI1?=
 =?utf-8?B?cVpHLzZiQWNBN3MwRTNxczV4bytvSWw4MjFvSnFHUkJCNzJPZlA1OFp3R1JS?=
 =?utf-8?B?aGFJZGhGKzdBUHZhVGlqMXZVQzRUbnM4Z2puMk9YY3VYU0RYMFo4MnRPdmZ6?=
 =?utf-8?B?bFNWOFZiTkNyaElwLzlheU8wMWNTVmFKL0Y4aDl4Zk4yWGJGQkpxM3hNaTlQ?=
 =?utf-8?B?TkswY1plOW9ScnpWYUxrRjlQMmw0azhEUWx0c2srTTgyQ0s3NWJPZkE3NVRN?=
 =?utf-8?B?Ynl3a3B1Z093YjZlamlqejNvMjdWNktkMGFLSmFPOXFNWkEzdG9JTnFKaVhq?=
 =?utf-8?Q?lqw4s+vOLSh27?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1JHYjMxSnB0MTEyR3lVMXhWemQ4YUo0eGdzUG9OR29FQUNRRXNsK3ZnY2d0?=
 =?utf-8?B?WDdXdjJJbk1qUXpwQmlaeHhRRHBCbmFRRUU4MEk5d2ZiZUdIVUhuMEFTeGV0?=
 =?utf-8?B?dUk0UFY1SFdCa0U0NWNuYzE5cktvZ2ZqYkVlYXhMWTdZU3FscFZudGxhRTgz?=
 =?utf-8?B?MUplYVRMdkl3M29LS0pSUm1RWHJ1WEJXd05xTlJzUXVhTWcxV2ZnNC9FdjZ5?=
 =?utf-8?B?MkxGWjNTV0lEZW80TDByeWo3MHFGaUhDKytQejhxeCtCY0tCTVJHMlpSem16?=
 =?utf-8?B?OHdxY0t3YStSdkt0SzdCRi9FSXhoYmdTN3RqTkptT3UxNEpXQnBva21JNGNY?=
 =?utf-8?B?WHlpL290aTBBYXUrWmR0bDhHL28xK0dpVTlvQlJoQXFyczY4WW1jWkZ3RU15?=
 =?utf-8?B?ZFQwU1lUYjIwazZyRXNsUjhXdHZCaXI5UnQ0Mk1xeFdneFd6Q2dPeWh1eVFO?=
 =?utf-8?B?d0wvYzJmUHRXbGE4b3BYaW1GTXJ3RkVOZFJ4RU9yNmRxenFLMTcra2dqVmYy?=
 =?utf-8?B?cWsyREZEM0RxaG0zUlFNcndubGtDVXBKVk9hMWp2Ny81d0RTZWExVzAyQi8v?=
 =?utf-8?B?b2p1cC84bFpKTDRuRFhiVEVibFNpTFFpRzhyNHJTZituNmhkZVhnT295TlFW?=
 =?utf-8?B?dDYyV0YrSHBIb1lUSS9oZXJtSXFvSXRMN3RTSXJ4K1l5cFdYeXZ3MllNZDgv?=
 =?utf-8?B?ckp0dUVXeWZUdjVVcDlaSDliVzYyUVFuaGc1dDRaZTcxNk5CYUFBN20xbmkv?=
 =?utf-8?B?WjF5djJZM0tjTjFSVjJ1ZDAzQkNac09hSGxHSlhRVm9Td0d3enU5dWNOMGlB?=
 =?utf-8?B?dEpocWpnTHY2KzY2eHdVOHV5bithendpN1p0TTVsQXB0U2FwR0M0c0NwYW5i?=
 =?utf-8?B?RmtmUzB1Wi9PQUw4STVEK0xLQ1J1MTdUbnFNTnlDUlVvVHJacXgrbmlmU3dm?=
 =?utf-8?B?WGhwYnJERHpPV0puaHQxNVFuLzFxQjNUM1hhaVNBZ1dtdFE5T1g5a0FnQlhy?=
 =?utf-8?B?THJIcmZhYlZFU1BhWWViSU55RFNab1ZtOHdieHEwZ1pKMHMzWmE2YUljSEt4?=
 =?utf-8?B?SUF3UWEwVmNOMU45NGN0QWhwN2RUbUdxTk00WERyNkNSY2lIQ2VaR01QRmtr?=
 =?utf-8?B?RkFlZ2dtanRaYVRIY2hkTGNzNWpSc2paTUtjSG9TOXdhV3FzTkoyaTdWejFZ?=
 =?utf-8?B?ay9IelJDR0dNT0IzN05kNTJYeVB6TWNVWFFhQ1VQQVlrRDdYZFFIdzdpQUw3?=
 =?utf-8?B?RkJvdUhsMlFNMDhHVzZtZFlIWUkvR1ZXWWVzOUMxUS93TmRLZ3dpZ1lsNVNk?=
 =?utf-8?B?ZVl1czJNdCtiRWFHRW01V0d4bzE5V0dQRzVYOGJUbysxdmpYWXE1SldLNEl1?=
 =?utf-8?B?NGR5d0JHV0Qxd0JPc3hzZ3NoWThTUGRPcXZLMHk5VHVkMGZHd09KYjkxVjFj?=
 =?utf-8?B?bE9vV1VYMmRRMk1GYWlwTVVkRTJDL2gwSUljeHB4UHdwd25FeWYrZEFEbEFP?=
 =?utf-8?B?TDhnbmhEYTNyZXdEaTZaSnNPbEVHMzZNMTAzd2FBUnd1aDJEVTc3L0JGV3oz?=
 =?utf-8?B?QndlaVQ1N3l5QWRkbUVibG85Nk5MczVRdkc4Y3JSajhJL1N6VnN1NC9zTTRJ?=
 =?utf-8?B?NzlENWFzejdSOFkwRERqVTdkaE5McU5iV2p6TVRoTjdDNm02MEE1djNrcVlW?=
 =?utf-8?B?NGlkSjdhc1duTTQ2ZmErQlpPS0ZnSHduZ3RMLzNxMXZlOTFxN0FRUVh4N1l4?=
 =?utf-8?B?bS9BTFV4bUkvc2x2Y0VDMllQU1AvZEtSTElTYWJRQ0tOTi9oMFB6VklRSVpE?=
 =?utf-8?B?ZXcvbzF1bFlqYjMvLzdZaEU0a1VYMVRza0RFS25FWFVyeVk5NkhiOFNCaTFr?=
 =?utf-8?B?akRKNkpFUHNNZXU2L0ZNWWt1SW9xeUdKdWYzdkg5OU5XZ1ltV3dhMjlHS3ZP?=
 =?utf-8?B?V3AxZkwzQ1pScjRnNXFEdXFlYTBRNkJvOVk0RlJKM1BLR0NGTkJsemppR2Vo?=
 =?utf-8?B?bUhxWVBLZ0ZwTklzaTd1QmJTaE5yS3dSdENNbkdvV2VFQ2R2QmN2TDVrem9H?=
 =?utf-8?B?aUljWi9SK0d6ZVZ1a21MV3pGOVk0Rk9mRFd5eXFlWU1hcnVWZWd3Wjg5YWsv?=
 =?utf-8?B?MDdFU3dSU2NjeTVueCtTSDFHV1paYTlmTXFmTEdOZ2d0b1pFM3BFNlRIWFVR?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7GjsxklZCP8GPeqTupMnZdxdtlTAFxsfbE0/Zfia8EVqP1LVSo3gBMBu9zvwk13hS837V1Q7beDbfDnoTVMYMQaieoVA+JWNBxKqkUCMZE6jGkYToegIT68F0yJF5iVJe5O+RJgF6b3gf3OTpGf74pVRhre9GCYCLZKt9YeEOymxutj/GWr8HC19GJYZPOd+SXgJXnooFeuCj6lQAmUSWo7r4zubcPCQPZQr4lVnCFogRAYARDpBD6QdalFeLmC7i5fWh7bR4KpnDtEgZ1e7rS6rn/j3Xh8Cq1KirxX/6cK+0Le3UgK1uhdvfI5aUOb45j7pIa48DjlYpgeXVIigXQYOpUWOVhyqExQEqLQ/dIZ3FbjY4e1SvjYUeKSG3yEpmw9G59aunDTSuofT82fEhEA1bnKEi5zYBieps09qZiheJNyPmo8FdYfjxk/wSGtzA42JxkLLM6eSLygp7QhwOfDMoCpkH/M7g2lpvf848bjrEOZ5pqsnnT56QG4ztWnqmVA6ffp9aYQsTA0wR3QbwWW7WfMiY9hO9J1CvieGC0nVV5K1y1Q0vX/cLXDftuOD038ZoGbv83rCGVR7VqPS+vuqXZRhL5ZC2krmKj8GwXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ad6468-83b1-4856-25f4-08dd2e81215f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 18:37:10.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/K9vjF1D+g/90pRqCZmemWsj093S33LYrC5wbI6Rq/LHmWzzOm2alirTCdtP50Vfpsr8t+iX030dzMNxiRE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8191
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501060163
X-Proofpoint-ORIG-GUID: DItHHpFmPNF_AR1jwwG9HY1AbQcglbTb
X-Proofpoint-GUID: DItHHpFmPNF_AR1jwwG9HY1AbQcglbTb

On 06/01/2025 15:15, Christoph Hellwig wrote:
> For I/O to reflinked blocks we always need to write an entire new
> file system block, and the code enforces the file system block alignment
> for the entire file if it has any reflinked blocks.
> 
> Use the new STATX_DIO_READ_ALIGN flag to report the asymmetric read
> vs write alignments for reflinked files.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/xfs/xfs_iops.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 6b0228a21617..053d05f5567d 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -580,9 +580,27 @@ xfs_report_dioalign(
>   	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>   	struct block_device	*bdev = target->bt_bdev;
>   
> -	stat->result_mask |= STATX_DIOALIGN;
> +	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
>   	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
> -	stat->dio_offset_align = bdev_logical_block_size(bdev);
> +	stat->dio_read_offset_align = bdev_logical_block_size(bdev);
> +
> +	/*
> +	 * On COW inodes we are forced to always rewrite an entire file system
> +	 * block or RT extent.
> +	 *
> +	 * Because applications assume they can do sector sized direct writes
> +	 * on XFS we fall back to buffered I/O for sub-block direct I/O in that
> +	 * case.  Because that needs to copy the entire block into the buffer
> +	 * cache it is highly inefficient and can easily lead to page cache
> +	 * invalidation races.
> +	 *
> +	 * Tell applications to avoid this case by reporting the natively
> +	 * supported direct I/O read alignment.

Maybe I mis-read the complete comment, but did you really mean "natively 
supported direct I/O write alignment"? You have been talking about 
writes only, but then finally mention read alignment.

> +	 */
> +	if (xfs_is_cow_inode(ip))
> +		stat->dio_offset_align = xfs_inode_alloc_unitsize(ip);
> +	else
> +		stat->dio_offset_align = stat->dio_read_offset_align;
>   }
>   
>   static void
> @@ -658,7 +676,7 @@ xfs_vn_getattr(
>   		stat->rdev = inode->i_rdev;
>   		break;
>   	case S_IFREG:
> -		if (request_mask & STATX_DIOALIGN)
> +		if (request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN))
>   			xfs_report_dioalign(ip, stat);
>   		if (request_mask & STATX_WRITE_ATOMIC)
>   			xfs_report_atomic_write(ip, stat);


