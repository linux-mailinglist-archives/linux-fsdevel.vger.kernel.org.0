Return-Path: <linux-fsdevel+bounces-39970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3003A1A819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D6B3A974D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCD16F858;
	Thu, 23 Jan 2025 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TFsuwEOF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d2Is7wZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0A70817;
	Thu, 23 Jan 2025 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650953; cv=fail; b=o07/gxrv6UnbwB6N5lZSUiXHlo7R02YJ7evBxcwgjmSJibjSmtrAP5HFIIsIf2zBvbx3a3xRDI6ONIoBorW6MYgZAi5Xcq4jsExPRE9eQ0N2ONt/MaYWq3lTW6a2SlHHezOilPOIYUn+5A6pGInxTQhawZf3cvm+iaqVaWjmuf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650953; c=relaxed/simple;
	bh=k+KihyaKQr+npX9sRTErKrXhCWgkncLF2XMZLRxQHnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imJVwrAI3Kc/+LgIDlioQUpiiFzLwYEvsZbc3fnSV0ImBxCtvyWSlWbQc664Hi3IUpLS6tdEkoKcZ8w+qhNTu9WVf8OqcxHObkdY0QzRuWoiTpSm2sOXmdzNvawZ+k/ocykmtryyVKAYbEjliZt0n60aUSXVbq8uRjnAovqWi3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TFsuwEOF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d2Is7wZj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDax8E007697;
	Thu, 23 Jan 2025 16:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0hB4yCOz+xbk1Peh++mgVwfy85Lx6wR2NsC/B2JMEP0=; b=
	TFsuwEOFzQ39EDPwvr96R6w5UYCwSTWiF/1mvBLKHLLVNw+50Qxp0zJFLW7ErEDn
	KvV8g+JA4vNvaHH9loib2SQ2XEhq4z2ZhKTJ2uYaUpZmdxs0lAhcSMWnhQ/3SJVB
	vzQn3qPcZ0YWD8DQkqrMrc6o5VMvc8HE4LVj2Dca/bQONWy8ETSZPtfkxNmxR470
	5T+vytuhg+nls5G4gENNaVVfFihTDsJPV0MUSxIk94Doo5Ie7O6ozZ8a2J7lkq5M
	CVWqYkktaE+ujY6kdTZpDqePRjbNDwv/duTBznCPz4MiklGKUJeo+P3BuLn2sVAh
	/5aI24Iy+y0L1G8X708igQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh314r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 16:48:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFSHrI038031;
	Thu, 23 Jan 2025 16:48:40 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491a2vcb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 16:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJuSC21NYLOjrSKIG5lq2HGkiF7KZy1ffSwuWM/XZqiFgrh/7QQBy4QXkWaLLWz84rGP5JmrE3p0zct3JH3ZAHrSIViYk0w7PvauVkrtsmYXLMMT1y5CJCm1NSlxeEMBnaagjbiGFtCY7RDPFjXI9ayiBpCqX8cRbfX7Wk38hBxAlaaQEmkahR7r750HF0xzJq7tANhf5cY4KVkA6DC9sbxxGgn3E3eunFvNOBGadet9kYe4VapLdaTvIKmAme+CvYTdpTsaG+7aI1jH6qV7TN5KCiYoBKZ5i7sGL8H9CjnuIihYAuQGyyoDahYD80A7FXtAUrjxEsr5mnU4AH4+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hB4yCOz+xbk1Peh++mgVwfy85Lx6wR2NsC/B2JMEP0=;
 b=tra8E7pfjQxK3G4E21Re6udJ7KK6kPJ/jZwerioqdoV7WFSVZ6+JHpp+IHw+l0Gz8Dj9I380Z8UNioTPRoYDJxCqokvyRzPmK6CWG1TpLmO0sP/r1eFrI2Pjq9/S6xmdSCfbBTj4p5bvtIEwinhct7C7VA3GNlqwKdAebPP9XjPg2NNW9UrT7dhLf0yHyKTuY3pOLTSfgE41iy8iGs1d1n3NCkWg9pMNEmR8bwJSZ2yNETKwIqvS84oCQefwpNeCwj+H67tMeFiKeJ4umEyVg6xnjFi/qhKoD7Ca0z15UgWXabzthrMTEq4Z+tNo6ULGbYCIc5BTIAYQj6qsl83Tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hB4yCOz+xbk1Peh++mgVwfy85Lx6wR2NsC/B2JMEP0=;
 b=d2Is7wZjWHLVtfOxGbqscreQ34JPMcx/CnllKt7AvF4TPx7EGWwSausaNxB60TlojtnN+98JYdfc2d7cWbAMwBRwxxShcWXDcWglcuqqvInRQiRJ+7By6rz3wyZd37fFioU7os2BiXsPEVyNWVTBSeESA9aKXH+5D723U7+ykyc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB5967.namprd10.prod.outlook.com (2603:10b6:8:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 16:48:13 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 16:48:13 +0000
Date: Thu, 23 Jan 2025 16:48:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Barry Song <21cnbao@gmail.com>
Cc: lokeshgidra@google.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
        akpm@linux-foundation.org, axelrasmussen@google.com,
        bgeffon@google.com, david@redhat.com, jannh@google.com,
        kaleshsingh@google.com, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com,
        rppt@kernel.org, ryan.roberts@arm.com, selinux@vger.kernel.org,
        surenb@google.com, timmurray@google.com, willy@infradead.org
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <6aee73c6-09aa-4c2a-a28e-af9532f3f66c@lucifer.local>
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123041427.1987-1-21cnbao@gmail.com>
X-ClientProxiedBy: LO2P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: dee2909a-d4df-4000-da6f-08dd3bcdb9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnFqRnR1N1JVZlgrUWFSM0VteTE2VERDOW90NDh2eWJUdjlvdFgxM1JDWUYx?=
 =?utf-8?B?dWwvb1R2N0FFRXhJUjErcC9GemVRWktCOE55S2ZBM0tBa1RlS1FpWnVDcU9m?=
 =?utf-8?B?VEgwMHVyMFIzdUR4MWFXMFhZcm1uT1pHZHZneWk2ay93SWxFOFZFTVRmOUlL?=
 =?utf-8?B?M1FMVFdwR0wxM0pkVmUvNUtYd3Q3cXlnN2RCZjVZU0tMWUtkTmRveFQrUWQz?=
 =?utf-8?B?cllTb1UrSmZ0RlBPa0VsMzVJTjkvSEFrVTZ0YlA4Nitadm5yeVBqckZqRnAw?=
 =?utf-8?B?SndnMjZwZmdKUlcweGpHMFNjTjVvaVc0Yll1VmIwWERBTW1TQmhjb0s1alFs?=
 =?utf-8?B?bElaT0lrY1kzWHhWOXNha1d0U2pZUjIwUUR2N1IvRWd0eWI2a3FXMEh6Q0xU?=
 =?utf-8?B?SHp1SmpKVDB4ZmdXRFVVemFVSS80T2QwUmo1VjFiY1Z0bDhpVnVucCsxYlZk?=
 =?utf-8?B?OFI1TlFCRW9DZ2tDRGRYZGNSTWRzbUNHUHdNcVJXWFE4SkpUK2pMOFVocC92?=
 =?utf-8?B?MHNlY3IwUW55YkFnak9oUFRiZXkxYnB2V0VMNkpVZWExTFdtUU1GN01GV3gx?=
 =?utf-8?B?K0RlK05LNGFRRTZ6ajJBMENiTG54STFqbWlwUHhtd1k1ZnhXVUpXeldWV0gx?=
 =?utf-8?B?bEtYSS8wTTh0NGtsRlVjTldLVWphWFVjRVhMenJnWmtndkpNRDBHTTBpdzVZ?=
 =?utf-8?B?SFNIN3o5Tm5sdVlRdHpQNElDMFVEK3hVRGl3Q1RxVnpIY1lvblI5bzZxaVM5?=
 =?utf-8?B?UTBERGkxNm43cU95aE5YOUVKZ1RYRTFpd0F2bmZvVHdTZXlHN1ZrREVxREds?=
 =?utf-8?B?ellxdGdwVmMrSm5qUjdlWXNzaWFQeThudXVNa2hwZXlnRDRMUklZQlgxVWZu?=
 =?utf-8?B?a0MvN1dZd21hODZvd1ZQQk1jSTRjbW8wZExnQ1FSTTNRaURpWGp1SDBFOEZZ?=
 =?utf-8?B?NFdYWkE5aFJmVms1V0dzWkZ4T1dvL25haHhFdXE1ZkZVZ0tBc1VGVVBVbGdZ?=
 =?utf-8?B?NktjRGd0VVUzNXBtUmVUb0NNVFhrVGVsUlN3SEZBQUc1UEoxWFF1QUx4anI2?=
 =?utf-8?B?NjU2SFU1NjdQZ1pmY2w1ekZkaEVOdDZLS2g4dzBHdVA3d3V3RGhCMER2RDlL?=
 =?utf-8?B?eUVJMlpDZXhHeUNVOEpmcXd4ZW5TSUJ2MElpWVZBK0ZrcytNb3BzL2daT0Js?=
 =?utf-8?B?eCt5TWlxTjJiN3dXTnpxazZlSStRZ2ZrZDVvRnloVlV3cFAvK3dIWVlLWUE5?=
 =?utf-8?B?aGVyUGtsVEgxUVJmMHc3Q2hia2dFSGpFT3NocmRhZHlQWWJLczBKQVRPRjJ3?=
 =?utf-8?B?OVlUanYycUdvSkNXWVNnUFVPRk9GcWw3NlE1RjdoQVNpTWh4bDdBVnY3N2hI?=
 =?utf-8?B?azdsbXN1SmhNdEVDZ014Z2p3YkVvaFdROEZNU3JKcGVudU03TWQwYS9HbFVP?=
 =?utf-8?B?b0UrV1dESGFpTlBSdFZmMHdaRmFXUlVtcVUyUW40K3NIcnFMK1QxOS9KRURj?=
 =?utf-8?B?UFRpQ3oxN1V0NEZpbThNMUQ3R2ZsUFZ1NmtjdHFaSldaLzR6aUxiV2ErT0xw?=
 =?utf-8?B?TUZLVi95YjBKNk52c0NwNmRUd0dmTXlFZDZkTWhIM2RPRmpOK0trOUtYSC95?=
 =?utf-8?B?R3Rnd1h1OWtKSWZ2cE82b1NKMlkvRHMycnRYaHhsUWp6RVUyZnlWVlJzRTEr?=
 =?utf-8?B?aU5EYkJLQWFpVWMxQitDQ0xTcVlaTU1CY2dqbkRQZ0tGZk1Rc1RyN0pnRWha?=
 =?utf-8?B?elJkQXJtWFYydmdlKzk3ZWZOL2NRSnNWZFA4SzBNL29pMkYwUnplcE1Kd0Z6?=
 =?utf-8?B?L3Y1eDhJVG1zcC81QkczZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHVkYTZpeEhUdm5uUVhXSkY4Q2ZWNUFDZW9lMHBEMjRkRE5lcVZhWGdpUGNV?=
 =?utf-8?B?aGp3cWNWRDZFUUZYRm9jZ1pLalpYNWg1WUo2WWVlNG5WVG5CRjBQeWVMd2l2?=
 =?utf-8?B?RXNaLzRqWHlSNmhRa1gwNzNqRDJ5OC9lTDBGVWp4TEd1QnZaQlFrWGxldWxU?=
 =?utf-8?B?elRCMmVyaDMyTmR4Qnh4Q2xkZ0U5QStZMkxTOXovYlh2amU5dmc0VndPYkMv?=
 =?utf-8?B?dkFwdU5MTGtmUVpCTFBDN0tlZXhRc2ltU1VmTnVUMGN5Mm1mby9NMGxHeW9O?=
 =?utf-8?B?d2lPTGxUZC9pQnlyZDVkenFpdFI4aFRnMUVRaExrVk50aXl3U3ZRUzVMUFFw?=
 =?utf-8?B?N0tKNGVhYTZwcUgrY1BtbDhlRHU4d2lhMkJpaVJTelZ6TzRTQ09XK0NpMFly?=
 =?utf-8?B?U2ZjdytHdEZBSFNWOXQ5ZHpzSnFMb1RNaXJmZE5NOENseEV4ZkR5bnZOc1Nx?=
 =?utf-8?B?RmFxVlJxYTFhbmsvYXkxTXFscitWZkpZMktrRWV3a3I3MS9lcUZwdFZzT2M5?=
 =?utf-8?B?SFJwUlhuR3BKN1hDRHBWRHMzVFB6VVArUmtGY2drYkpOVmU1SUdvdHRLQmFC?=
 =?utf-8?B?TVR2OW05aEd2VkVjdmNLYmIyOXo4Mnp1b3RLTEdxck5FakRydU1GVWFOVmVo?=
 =?utf-8?B?TzlXdnVZVFBtVjB2WVlLSGpLY1A4ZUJqYVFLQVFXdE1MYzNyNHZ6Zjlwd3BB?=
 =?utf-8?B?OE90RitnM05BcHhhT2xIMkhtcTdpbUo0emprckxEMUMxbFJWWGQ1eVUybDRO?=
 =?utf-8?B?ZmZ1M0RpODJGc05SdE14S1VENHVpWHpYeEU5OGtSSTFUQm5HUHVJRVJTUnNm?=
 =?utf-8?B?WlF0T1ZhenhwSHhXU1ZBZHB1bHp5Q3Nib1djSWphdi9xU1JHOS82V3BoN1dZ?=
 =?utf-8?B?MkN5YUpwbzQza0doNmFzbHQvSHFtSHh5eHFSdnpSSGdzUURJell6QjJXa1A2?=
 =?utf-8?B?TmE1cWxHRjJFcG9wdXJid0c1SnJzenVuZzcrdXZJS09qRU5LZEN0ZGd4OWt5?=
 =?utf-8?B?U1ZuY3ZxK3hEZmdlamdENjF4em1qN1Rrc29IcDlzNHM4K1JpVTZydE5sLzFo?=
 =?utf-8?B?RENYcXJVTTczQmtZdTJLUXZBMWE1Sm4yczJyd1Y0NUF3NXM2bzlTcXVIZ0Fr?=
 =?utf-8?B?bjJVT3dERHNNaGFDTGtoQjVKeVZITlUxQVEwRFIzc3cvSkxycEdzUTgxRGhy?=
 =?utf-8?B?cjluZUJXU0Q2ekt0UFBiS1RTd05lMWsyQm1xOWR3WXRwWEthT2tRQUJvMFFW?=
 =?utf-8?B?V09MbEZMaW5zeGZ4R1N2a1oyMXUydDZ1NEFNTlBXL0ZSLzQyNXdjOG9hZjdk?=
 =?utf-8?B?Q0h6QWNkWjVYdUs3YUtzTU9wczBudWJTTHJrbE4razlMYjliMDhOeEZJLzZw?=
 =?utf-8?B?MlQ5N1hMbkc4a0g4bktGdUQwN1lDN2lPai9RQmFZVTFmNlFHVEdhRW1JRjRo?=
 =?utf-8?B?dHZwdCt2amxUSExWNmtQOHNVejhyOUlPYVhoU3QwdFhOODFaUE1oSHJjM3BF?=
 =?utf-8?B?V0xHaDhBUStFb2xuQ3YzRFM0Yk1QUDk1MVNJeVBHb0FrRlZxdlp1d3k3ZHo0?=
 =?utf-8?B?T2p4dVF0WEJ1TUtldFNxTkZ5emVRQW56RWRnRk0xM2k0ZnEvQWNZTUt6V2tm?=
 =?utf-8?B?c0pLdmIrNHhzN3VZeXpuSVBLYUlNR0h6Q0dYcmttSEpHV0Iwa3pqZmR3eEVQ?=
 =?utf-8?B?WHF1b2EyQ0JrQzk1OS9LT09OSlU1WU94bncxUGhsN2FoNENnenVSeXVvTFkz?=
 =?utf-8?B?bWJObUFDbVN0REpQcXM1UUgwTFpnY08xalZudEJpcVFUUVJCYUpGL3NFQmd6?=
 =?utf-8?B?dHFUU3J4b2NTenQxSGcvN1ZrOWtlakt0VTZOdlhDa3hmYm85djNaRUt3SmhC?=
 =?utf-8?B?dTZhQ3kvdkQ5Z2QzWlo4dHI5K0R0VnJESGp4dFo2dTZvdkR4ZEUyVXpGOTZU?=
 =?utf-8?B?QUlFcXhEM3ZYd0treDkyWHAwREM5eStueU5HUXZCYXU2b1JHRlJ4enFsc05Y?=
 =?utf-8?B?aXhNaTBVR09Od1pnUlBzU2hWMGI3WlRkejh1R2pYTUdDeW5GbTNacC96bXRW?=
 =?utf-8?B?Z1M2NUNiSkNkRzY3Rno3dlRUeWVHaEJuOGNsbGNRRzN2K1NTS3hqUFArcHVR?=
 =?utf-8?B?bmkycEhSa3VpcXd2QTM3aHM4Mk1pRWUxdGVWbEl1djlnNGdod3ZlQnF2anA1?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a2P9Z5bqYSuXlGEniRaxJeTqkAULXwCVbf76E3UdOLkweIOevZ/3Rp7FZAMbGqb3abxhZGKPMVCQ/OWxQZ9Jy4sJOncExOWa8vah36fG1ErDcbwqnMNahOly4+znpq/XnuUFlwb7SH+MDNJgpt3n6VN6IECMY0HrXiezbJHwzxtVpqpUFOwd9z72aUxv+mrp07YwdeLbelPFGq1z/kRi0oooIvqBs/IRIjLJhGH0SgM/YsOBwqkfUFhrM7x5oqOFVcSEbWfH+qWlgMSeAUOXhn8epLhis23MzqhfHXiWWGipPsLDyxZRyp/Zh4YUm54Ngvrq+g4p8oYMdN7JbxT+L09IxfaqdCp7xjeoBrJ08mdU4GCjkt0vfxQCG9DULmq5Yn6IgjUU8/3TUxI9nJ9IvwjuQ89/xzyPHbO8SeDlLRj043XHoeXZr/xjq95S6h0JqoMaCuktcA+8pCwx133YOGR9SUfpzNY8iYsOMBuNzuMeM5fewAOJw92mrBppQ0u6EYhv7dgwtFRhmJcDCSTlcMH792UPdmFXM9OMdtc2UWf5vo34owFKKnvoNeTzqSc67PhReyv1suHd2bMQsWbtBk52NijOfn/JHw7xNGvkfHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee2909a-d4df-4000-da6f-08dd3bcdb9fe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:48:13.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfWQO0d18B7oJiLS5yVnKPTO066uniiYaz21Onjc2RC+XvO7PK3FDyp183e7hPgPsM08Lw+dG7I4XLsCnVuoQbcYIkWE35HHGevHiin1r60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501230124
X-Proofpoint-ORIG-GUID: cClZUPByKRI8IjlpPEo45qkEB9G-J7uC
X-Proofpoint-GUID: cClZUPByKRI8IjlpPEo45qkEB9G-J7uC

+cc vbabka

I realise this is resurrecting an old thread, but helpful to cc- us mmap
maintainers as my mail at least is nightmare :P Thanks!

On Thu, Jan 23, 2025 at 05:14:27PM +1300, Barry Song wrote:
> > All userfaultfd operations, except write-protect, opportunistically use
> > per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> > critical section.
> >
> > Write-protect operation requires mmap_lock as it iterates over multiple
> > vmas.
>
> Hi Lokesh,
>
> Apologies for reviving this old thread. We truly appreciate the excellent work
> you’ve done in transitioning many userfaultfd operations to per-VMA locks.

Let me also say - thanks Lokesh!

>
> However, we’ve noticed that userfaultfd still remains one of the largest users
> of mmap_lock for write operations, with the other—binder—having been recently
> addressed by Carlos Llamas's "binder: faster page installations" series:
>
> https://lore.kernel.org/lkml/20241203215452.2820071-1-cmllamas@google.com/
>
> The HeapTaskDaemon(Java GC) might frequently perform userfaultfd_register()
> and userfaultfd_unregister() operations, both of which require the mmap_lock
> in write mode to either split or merge VMAs. Since HeapTaskDaemon is a
> lower-priority background task, there are cases where, after acquiring the
> mmap_lock, it gets preempted by other tasks. As a result, even high-priority
> threads waiting for the mmap_lock — whether in writer or reader mode—can
> end up experiencing significant delays（The delay can reach several hundred
> milliseconds in the worst case.）

Thanks for reporting - this strikes me as an important report, but I'm not
sure about your proposed solution :)

However I wonder if we can't look at more efficiently handling the locking
around uffd register/unregister?

I think uffd suffers from a complexity problem, in that there are multiple
moving parts and complicated interactions especially for each of the
different kinds of events uffd can deal with.

Also ordering matters a great deal within uffd. Ideally we'd not have uffd
effectively have open-coded hooks all over the mm code, but that ship
sailed long ago and so we need to really carefully assess how locking
changes impacts uffd behaviour.

>
> We haven’t yet identified an ideal solution for this. However, the Java heap
> appears to behave like a "volatile" vma in its usage. A somewhat simplistic
> idea would be to designate a specific region of the user address space as
> "volatile" and restrict all "volatile" VMAs to this isolated region.
>
> We may have a MAP_VOLATILE flag to mmap. VMA regions with this flag will be
> mapped to the volatile space, while those without it will be mapped to the
> non-volatile space.

This feels like a major thing to do just to suit specific uffd usages, a
feature that not everybody makes use of.

The virtual address space is a somewhat sensitive subject (see the
relatively recent discussion on a proposed MAP_BELOW flag), and has a lot
of landmines you can step on.

How would this range be determined? How would this interact with people
doing 'interesting' things with MAP_FIXED mappings? What if somebody
MAP_FIXED into a volatile region and gets this behaviour by mistake?

How do the two locks interact with one another and vma locks? I mean we
already have a very complicated set of interactions between the mmap sem
and vma locks where the mmap sem is taken to lock the mmap (of course), but
now we'd have two?

Also you have to write lock when you modify the VMA tree, would we have two
maple trees now? And what about the overhead?

I feel like this is not the right route for this.

>
>          ┌────────────┐TASK_SIZE
>          │            │
>          │            │
>          │            │mmap VOLATILE
>          ┼────────────┤
>          │            │
>          │            │
>          │            │
>          │            │
>          │            │default mmap
>          │            │
>          │            │
>          └────────────┘
>
> VMAs in the volatile region are assigned their own volatile_mmap_lock,
> which is independent of the mmap_lock for the non-volatile region.
> Additionally, we ensure that no single VMA spans the boundary between
> the volatile and non-volatile regions. This separation prevents the
> frequent modifications of a small number of volatile VMAs from blocking
> other operations on a large number of non-volatile VMAs.

I think really overall this will be solving one can of worms by introducing
another can of very large worms in space :P but perhaps I am missing
details here.

>
> The implementation itself wouldn’t be overly complex, but the design
> might come across as somewhat hacky.
>
> Lastly, I have two questions:
>
> 1. Have you observed similar issues where userfaultfd continues to
> cause lock contention and priority inversion?
>
> 2. If so, do you have any ideas or suggestions on how to address this
> problem?

Addressing and investigating this however is VERY IMPORTANT. Let's perhaps
investigate how we might find a uffd-specific means of addressing these
problems.

>
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  fs/userfaultfd.c              |  13 +-
> >  include/linux/userfaultfd_k.h |   5 +-
> >  mm/huge_memory.c              |   5 +-
> >  mm/userfaultfd.c              | 380 ++++++++++++++++++++++++++--------
> >  4 files changed, 299 insertions(+), 104 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index c00a021bcce4..60dcfafdc11a 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
>
> Thanks
> Barry
>

Cheers, Lorenzo

