Return-Path: <linux-fsdevel+bounces-23214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C45928C32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086691F24D83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0473816D9A4;
	Fri,  5 Jul 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MVqj/fTA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eL7HHzgj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248E225A2;
	Fri,  5 Jul 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196725; cv=fail; b=kgX9tRlAHLxnpyciZqw10eyPizLsPE1417z89/6YshkdWnKkPIu9GXm/Ou2kLcqkNqf6GIFrCyX6yrD55ScsWdSWo2smWRHx5EyRoIhpK5ZSalBeO3EKyyutVg8DNc3jOIHkbi9XSLCoYdgchsvE6a1WMC+8N2hoFlgY4M4cCCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196725; c=relaxed/simple;
	bh=iwNUK4XfSUgI9u3B6bSlAIRGwT73b7+UrBeSDwH7H4U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ItOL9tZbQRp/MkK/FLEcpZK0N/uImZ5V4xWqrju4vgV6n6Z7z3mq/IIW37C2M1EdvXNhEMdFKgEOnvLYn+pYJmD/3ROLugH7Hzwdaiyst0FFJE3ooIaNM6Ray44WzdHTdAn0bkykzw03vMKEj6G/HPVEDPmOliMUnY8Cnau2SEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MVqj/fTA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eL7HHzgj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMUxd024959;
	Fri, 5 Jul 2024 16:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=uBm+mcSahoKxKt
	8hEPummXLEYfyXQ3wL5X+qmP5SHcs=; b=MVqj/fTAtSE+azBPNpuofcI8Vq0NLs
	AyHlO3KgR8Z6GC5Tg5ByZavrWm57dhCJEywWxoYyPpA9bERZ7842yK1jDkAxg2da
	N1SYg+6o3ibp2FI8jpTD+I1H/Edw+3xy4YR1Ph8E3lulYJYcnP0eNpQUPG3FLAOg
	E9fiCX/V7hWZllg1wgKPXA1TIBk8D4mMLnj01F0W1u5DGsbNyYT7YXWa6kKJVZ52
	8p9aXpobel9qNco/ohV1SDvfAu/IttRKBaZqIpsYFrb217eYC9+WEHV33Nv326MK
	iDbFADY1hv3YHuuASwH7JHhvDBrYM6x/kuGAlHyz8YpbrtoCsOnFoC9w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsv40g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465FUrPH010327;
	Fri, 5 Jul 2024 16:25:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhwsmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL1N9AYa21yKZ5kxFN7r81aydprpWwO4PXpD8Lq9qSj40ydefajuJOrk4B1TR1NNd7wWE2oGtg7cmBZPuOJBf8++pV1CL1fO7lwqVrSchB63GjqiEtFIv538f4ioSzB6cdgSe3lF+6Kfy9GJaEM++j+dK5g9XCQVdN6i8DHBWM2/rOJwjvtsGI1KFjo6FdQMFDOHv8lApdokD6LmJYaW9yVz2EDI13Q+Bu7/6lNcec7vPHk9191SuNrhI3LeftRJX0adDEKOcqg8Q4Eao3Ejx5Mi8yhtcD4AuRzJwvF11aZxzGOE39Q49EsgvOY6YyN9XUeGEQbJNDu0dHEOlupfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBm+mcSahoKxKt8hEPummXLEYfyXQ3wL5X+qmP5SHcs=;
 b=KRurvv1J0lLs+n6vY4Y+Hemb6xhBFfQ0T6RTCxuPMUCzeMD07eCKn7wka+fhP6YJTX6QbFdSlWYXQxA8wx+RZ4pVgMXbhuCvpHjQbuA5ZFcb8aYIGrXPuXgUdjtQVcfCLrCVtw5or2x5PSMQBR1epA1Zz6VIaVV2efZTXC972UjJ8WDrnElX8v42qIaXIX6k8VrXQMoPahb6NwKYqrFKRQ64er7I5x7yaN7TgT0r3Ydkwg2Uo/cU2YMjYH7Uf90V/40yH55B8WJub7ETe2B9gwpXsUKedeSLsPTwz9fdI2jrgGVMSJRjxoLVzqwJ+0JZeKxLq8bGEkPcg8342NZe/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBm+mcSahoKxKt8hEPummXLEYfyXQ3wL5X+qmP5SHcs=;
 b=eL7HHzgjNqgUwzQOQZZmJZ8yhtB5Kp78OtRordVaEDab3M1P5EwnisGFcob9/KafYHDxZ00Kh+J7K0laYKe5pdZ6tWSXToyQ/18GdKB0BLyPCCOWstOVNDJA9B/nW4KuKX/TLPj2k3oHj6V/x3Wq0xDqyq9OdUDUbMML4nvJ7b0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 16:25:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 00/13] forcealign for xfs
Date: Fri,  5 Jul 2024 16:24:37 +0000
Message-Id: <20240705162450.3481169-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:208:236::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 73931a74-a68d-4e56-da6f-08dc9d0f0991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vi8254NN4Tn88upW9HIDCnxg10vB2UYq3yxtgsGLUlXwSU8uvfIYgleiku+r?=
 =?us-ascii?Q?kvBBmRa/vjQ7bbT/bSh1YjXXr2S1b9vRuClP3ua+mLaSwecGWegDZaoyHm2v?=
 =?us-ascii?Q?LZqmsJ2/qxrdDkxpWkZWsU9pgK/CQY9+PruegWSjmQpJyZlRgtTx19TZoQDQ?=
 =?us-ascii?Q?umB+L+ohnb66K7pG0t/Jo5lWNSSKO+X/esIPVTAc2MvtuREGpV89XYv00F+C?=
 =?us-ascii?Q?uTge62WxSQBuOiAqGXezxXDU6ybOTIaq0y1f4htOAS5IWuMbHA0Py7kftPoK?=
 =?us-ascii?Q?CmhIDkyHHgUQQEhX9rHBXzEfeolWI2yvkOyCShddEAkw2MSolrDVzvqUQWEN?=
 =?us-ascii?Q?uABIHbTQPtA/F4wYERO9ctJT89UAa/PoROuAECTgHOads8upIFK9Pk+/2I0a?=
 =?us-ascii?Q?4RwXjBNKaTmvCHDfiXTE5ehUFL7v0UyjlDGJvj/NfmM8z9Onp5ZsUtWzAPwZ?=
 =?us-ascii?Q?RN2Y0yTEQrMebju7m6q0ckw/dubdhjdsefV8Q5s0CO4VT0b0KD6dfKnEytLu?=
 =?us-ascii?Q?CJaVW6RxQA28iPIc9NETrZAkAFvT5kNnGrPzKjJfqrfS28Zl49ONEs2nwLQC?=
 =?us-ascii?Q?4RP3oy/c97ICg1dnQoazWFuGpLwZxRzxMo+vyDuY7tdzDsbd7cU4kX62B0ct?=
 =?us-ascii?Q?0gvpMEp0qjZYYJI88kZssdwzVo0cR0nLT4qg0X1zGghXRetkSTA9C7xg3QgQ?=
 =?us-ascii?Q?QvKn3oOgPHHV4A6dbY0ngCWWMGxvehJjV8LtY3j5vf6RponpiFggd04kI3V+?=
 =?us-ascii?Q?WbyQgpe3JfvnTKMQ/OAxf2jer1mPlEKZ93GH4FZpfmU3Y2wep3b0Lm5uNT9h?=
 =?us-ascii?Q?DT130xUInCjiMUlGOCLMpvwO2e+3Y5OywoMl3w3r42PsNUg7UW9APbO3KUmG?=
 =?us-ascii?Q?GiyJqfDHC/lI77ipYYaWq3Eyis1LAIcbtsRiaWpJEaE/U+5t5aChqBAUX8VF?=
 =?us-ascii?Q?4YGyvO3NjWKN5IxkXzoZgE5mcbOihZQKLX0w5GklcBI7JWLgNAG0rKHGDknr?=
 =?us-ascii?Q?SBvzG5e0ExGr2AE6NRm0jj+YwoXFfBCVUddXt879haAsZylsTeNCm226rum7?=
 =?us-ascii?Q?mR9yoZ+aF1Or0q007BvrGhwTs8nsYjSM/pjmgcXtQWvAbhtKvjjtb8fjihrN?=
 =?us-ascii?Q?VrcMVUXQ8qyN6OG3i+V0hNMQ09iiDRjHhmo2WccxDMxgLrEs15GIjCf0fvff?=
 =?us-ascii?Q?c1ccO5T4/Nrxp2RVPQ3GvqDcbsHAizuJUSAmV3XTvOFY5tzEsskKRoRAuovC?=
 =?us-ascii?Q?ekFQ3rbZSOFUB4x1pEcFNhHABD/usmpLlcO7cVrU8NDVj+r1wI/YyGbL59vr?=
 =?us-ascii?Q?saxbm/DXQK5i7R7l0gpF6/ul?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZUbW3eothfVy7AhGNjfNr3O9kkXyvGvD1oFi/7nky+Yd0D919WqWt3c4P2UB?=
 =?us-ascii?Q?JmWbnbzRbP6UFFnoukuIRG6bFu7bbg/MCS9cBkOPerwsAS97DIU0GwOQnwC3?=
 =?us-ascii?Q?2RYMyaSxPrS66uw3EMuklCzXZkEv09QjrBlVigeGmGN91YM2nZJKWFXK5CGR?=
 =?us-ascii?Q?xIRU4cX0zKjsAMcaHA5pwNiWobK6TG51YkFXXLbXhDeRGXA1dX2tCHbRuuyu?=
 =?us-ascii?Q?KMB/EAMAXs3xt0ULRrrff8LJ40frobDrvsq6oBx1g3UlFxTk/ng5/zFJ9HRd?=
 =?us-ascii?Q?fDl0oerRLc+gqSmoy/eEln879TeSKG4EtjsSYHTF3h5R64ZCP00auteCz8Q7?=
 =?us-ascii?Q?A5Q8XPfC/wVxk2PRbIxcxwH0T7EIcVIs53yiMzfNgUhX51ysAV4dEXfEQJgs?=
 =?us-ascii?Q?bf0ONFQEsrKOcZfvjzpbPCNi8WBqcq0fq3kbrBIBq9pRbL2FfeGpLWv/pH0n?=
 =?us-ascii?Q?JsV5z5CDzIZz5IP2WwiT7nJ5/7ntxlALTrMNWNc06o6DlR0/LbnLU03SzRDg?=
 =?us-ascii?Q?CYxeSzIe66d6tEFWVls5tBdSM6YYzKejR2RUbAaBw/L7ZT9UR9YwEVwHCdX2?=
 =?us-ascii?Q?PMgWXHRQ8vgmd4LSAZW+tXUgkjICDo165NIyh+z/DZTEJ0NOr0FPTetoNlBR?=
 =?us-ascii?Q?cv0FwqmAjhaBuxkf23IWQjYPZeixXvKInSCN5i4X3Gonu4mlNp2zLKoKxGrq?=
 =?us-ascii?Q?GUAVdhXVze2TbhyM1S7J69qOlvJLvemTBG4ex2xU60tVPe74An+NBdx8xY6u?=
 =?us-ascii?Q?bSS4Tm4p8qHsMWotxVV5Ikyx34MdBCAUpu6mbb4VVuoLVjXLqS0XpiM0SSEU?=
 =?us-ascii?Q?kOJJ1ZqCHewpaOMURxB7czgwbsM8LZk4aXbO79tfFOf5InLaIhP3Dg9fzWLM?=
 =?us-ascii?Q?SQqWUHo5O7KJpFHMcmX6Tkojks1TCfbVaxZ5yxk4dQZMcbz/kBUcKYI6Xs0A?=
 =?us-ascii?Q?DABJ73CkTu+tQ6PvVl7LJUkbyv/pMclmm0OfvnTXe3nuF01tbgKpkfkmFrpU?=
 =?us-ascii?Q?4bUOoQ31NybOAltie1NKFi+3H9iuZ73RFVy0pon8r1aKcAMB1QcXCg/mQIH9?=
 =?us-ascii?Q?4mUYAiiB6bKtc+9/uGlJTZ1fd9W+g96HRdqjF5em42cd7Osn7+upV3c2vCAP?=
 =?us-ascii?Q?cNVii7TnL3tU8esph/XjOyXxu6UMh4fCZzNCsTsbtOq+tDzjiZATJHrzxiiv?=
 =?us-ascii?Q?XCNZIW6fhNQgd1RQ8C4YtSrrsXD89xcniaDkTp7OXBr7zK/sRJ9Mn+HAc3AJ?=
 =?us-ascii?Q?vMA4xnM/lQGaV4gLcglSJqmcSDdXhXC1/4wohsJeTQqbzGcAJSrS3QFTZgXA?=
 =?us-ascii?Q?SSJviRbtnPFK5au0vSQ2+jVKkSFS1Xps9Y85XPE/uKhcNiQmMarQ/WJqxH5j?=
 =?us-ascii?Q?kr2mc6GWH0hu17eyMGOTdew1U3TyUUZbuzKvkvGs0FdL/9LIBk19XBpWyAJ9?=
 =?us-ascii?Q?R43kPIYLDopu5KKVfEPD3bpPaovIHl7N8qgL1wGmUD9YWHpzxPOaeeyuwDGI?=
 =?us-ascii?Q?NVbMgtAlga4ymqNAT71JyKx8XAhtUHh7sLkx85JnsXSPph7+2JSbR1EBbcYF?=
 =?us-ascii?Q?ZiHxs48LknBZhsLW+PgwyZTBQg2ES4D0DOTjnEReCZDMWb+1PS8S1dDjWFgb?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y1YMre111uR9OcV/iVDMnFz0mlfPfTfzsfIJQfY/Jcqq3w3p5c/ZxRtlwBVyOgwOBZvC5kW+t8a3qRxl2I26lVXPsKpb7vXnVbOMQPZYsx7RF0uK0RFAoLXfZiVGKOXm4kodv7n5N6c4lFr6WTVAXK3BUpxwAz3L0JpLSqfsWqnfVeVHSK1s4mG0/PECWwGN28f2Fn1KmqE4NtlkxT2CPepF/2sga43w0JOoJjg3bvzeWUvXaZTTydNSgCnWaB0UVPzpa4dmvbowR41v8a1NbiuORwpwPVf1dEiNSoM3rv0RcTQOeboTsib0oUgqLXS3g5/hF+9XdPn1LLeOMm/HeWQ4fxNwZdJjStnGf+ppwWxdIdRjN2HexJ7CiGxmLGQ0q/ruK5JU4xkdxi4QeM0QIDUXIm9Knx7duqDzTJfyJIGAqGDQgrm8XTheVha3qReqZvfftjJcDC4rg0cv6UE9cyWNc5VaAHP21Bp7zOsZIsyXLZLTd5KHy6uP1koBOhWuvr4U7wTbblTHecRJd++zKBP4iG9VAHeXK3ZXJIBQtCG9T/ESn6tvysljc1nUBGH2yWOeB9/KjTppVrBi/k8TrTUKPr4dsFTUUYZqb0Ilkv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73931a74-a68d-4e56-da6f-08dc9d0f0991
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:09.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyHzZfAx9jY5aMHEUXuQCjjMKD8YVr0tMp+SBKsFWjjw+JKEJ1M9z22oaobwf206aGPe+B+2NNw7OistoFNiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-GUID: wb9VeMcHqW-jbl74iplW0etqw8sRBwb8
X-Proofpoint-ORIG-GUID: wb9VeMcHqW-jbl74iplW0etqw8sRBwb8

This series is being spun off the block atomic writes for xfs series at
[0].

That series has got too big and also has a dependency on the core block
atomic writes support, which has now been queued for 6.11 in Jens' block
tree [1].

The actual forcealign patches are the same in this series, modulo an
attempt for a fix in xfs_bunmapi_align().

Why forcealign?
In some scenarios to may be required to guarantee extent alignment and
granularity.

For example, for atomic writes, the maximum atomic write unit size would
be limited at the extent alignment and granularity, guaranteeing that an
atomic write would not span data present in multiple extents.

forcealign may be useful as a performance tuning optimization in other
scenarios.

Early development xfsprogs support is at:
https://github.com/johnpgarry/xfsprogs-dev/commits/atomic-writes/

Differences to v1:
- Add Darricks RB tags (thanks)
- Disallow mount for forcealign and RT
- Disallow cp --reflink from forcealign inode
- Comments improvements (Darrick)
- Coding style improvements (Darrick)
- Fix xfs_inode_alloc_unitsize() (Darrick)

Baseline:
xfs/for-next @ 3ba3ab1f6719 ("xfs: enable FITRIM on the realtime device")

[0] https://lore.kernel.org/linux-xfs/20240607143919.2622319-1-john.g.garry@oracle.com/
[1] https://lore.kernel.org/linux-block/20240620125359.2684798-1-john.g.garry@oracle.com/

Darrick J. Wong (2):
  xfs: Introduce FORCEALIGN inode flag
  xfs: Enable file data forcealign feature

Dave Chinner (6):
  xfs: only allow minlen allocations when near ENOSPC
  xfs: always tail align maxlen allocations
  xfs: simplify extent allocation alignment
  xfs: make EOF allocation simpler
  xfs: introduce forced allocation alignment
  xfs: align args->minlen for forced allocation alignment

John Garry (5):
  xfs: Do not free EOF blocks for forcealign
  xfs: Update xfs_inode_alloc_unitsize() for forcealign
  xfs: Unmap blocks according to forcealign
  xfs: Only free full extents for forcealign
  xfs: Don't revert allocated offset for forcealign

 fs/xfs/libxfs/xfs_alloc.c     |  33 ++--
 fs/xfs/libxfs/xfs_alloc.h     |   3 +-
 fs/xfs/libxfs/xfs_bmap.c      | 321 +++++++++++++++++++---------------
 fs/xfs/libxfs/xfs_format.h    |   9 +-
 fs/xfs/libxfs/xfs_ialloc.c    |  12 +-
 fs/xfs/libxfs/xfs_inode_buf.c |  55 ++++++
 fs/xfs/libxfs/xfs_inode_buf.h |   3 +
 fs/xfs/libxfs/xfs_sb.c        |   2 +
 fs/xfs/xfs_bmap_util.c        |  14 +-
 fs/xfs/xfs_inode.c            |  17 +-
 fs/xfs/xfs_inode.h            |  23 +++
 fs/xfs/xfs_ioctl.c            |  51 +++++-
 fs/xfs/xfs_mount.h            |   2 +
 fs/xfs/xfs_reflink.c          |   5 +-
 fs/xfs/xfs_reflink.h          |  10 --
 fs/xfs/xfs_super.c            |  11 ++
 fs/xfs/xfs_trace.h            |   8 +-
 include/uapi/linux/fs.h       |   2 +
 18 files changed, 392 insertions(+), 189 deletions(-)

-- 
2.31.1


