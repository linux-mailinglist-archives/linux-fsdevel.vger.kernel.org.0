Return-Path: <linux-fsdevel+bounces-36008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448909DA9EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD111B21890
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EBE1FF7AA;
	Wed, 27 Nov 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJPOJGeY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vjSZHO6V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42E1FF618
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718238; cv=fail; b=Vb6XRUZE1jribu5214a9faJNl6hIPm89n8KBpjp+Tor6F5fbzkl0woVBcsIuwap0FGUQLxXtDxqC5cTiLHlnPBe0ayqINnLMA4ua/Yq7FgpYGGyWeWMtZVZYj/nUy2IRK/W7qDRV18rr5XUgmEXyZF0CIkVIFKjg5r5aekeMIbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718238; c=relaxed/simple;
	bh=A8bZFdV3wUfDrIBtkzhEzcAnMuTWggscpidGynxK3iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sd5km6Vqq/DLad8q+w15sZoKFBN/he760D8TJeVX/TxRCQu1mDtvcfXPIOl8933ZkRa5xcZv9oyKlYOBReMXxLm1tReCmmAoKZIkRv1N4QLXpNoIiv4ilAkFEnc5Z3P8etA5FHH4EnynHKydXkC9FXaLJIkowqJGDl7vtpSzYfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nJPOJGeY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vjSZHO6V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARE3iTf032578;
	Wed, 27 Nov 2024 14:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pqsKwQhqgMbYn6lLSSgJCFyfgBBmA9IxxZwNs4pYMMA=; b=
	nJPOJGeY+JPV9BcpH6yexfUv/JnrM7nuW3JRp9pxBSaqs5SRGFKqk+/YL5CkC5th
	1vzD3jL5O3Zv1b+bW6u6akD10f/HOPIP1T6rAgkN6ls2CeQub0BgUcwoxh2YKj9H
	JU/gJUlSQ+kb2VPTGCyTEM28m0nt0gxjOImTQ0/V+7rxxi3uNwc1jVdYg4+BVuJL
	euufhQev6lKZYdeYu0eRQQWLVnAqbDieu0wj9/WqDPEiwHCnV5r7LDBt9Rx1nXT2
	djQEQhLmgT+DUIZRWoL+01nidiZkuj9eDzWdvNGBWVsyvc3MeOPhlIOYDTanudrV
	zfP/Nz32bYkotY2RCaqHPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384h094x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 14:36:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AREShZf019307;
	Wed, 27 Nov 2024 14:36:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335gh5nrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 14:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6WReAZIPV1XUSa51jTLOcXVYg5eZq308ffaUhKCDx7rrkVWRMVh5aJwqCACM4B1oEpi8925C1F7Eu2gENQUpFJ8Ntgzk1mp8Tq409GB/yOLzA9mrF3qeY+dNWJOP2cME953ifEhA4S652VV1JsWyUBgw6ElZm/3aJs8s8E7A1BnjTuIFm7cgQGGWayM0Bhqym7rG6RHJkmeGy7B2gkF2MqVvu05rKPEQcIV8lv/EpsHxYFAf6x1SJ5ZBnD/Rjy2tjGUrHqzUQB558q6Lhc3YLcULPRyb6w7qeOOFdD/d3DzVv84FIFgnl/Cx9D2MLhywqPDBI2KMXtbFKbTSuPvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqsKwQhqgMbYn6lLSSgJCFyfgBBmA9IxxZwNs4pYMMA=;
 b=d4wOxrJApPghpS7QVuthA6ZYcSyHQNv2zRu9+oosjl25da5CIcLAWoGQtHAkYYMbJv4F84NX2BF0c6WZdt/APggm/WFVibnSumoZBFiYecqIWTtRHusNPwvWFpXTzgaEdkfMGReWJ9BtRjqTSjGXZBWtT3GhnOXnIo/VVrSCRCu6uwYsPS4ryWqnbgdj3s3nWgmH6fKc1PeloQP62+j6tHFGfbxTILSGok1cLqGglsT1WFI1RPup/ozGiBgpK3HAOxBz8Ye4/cGMtsdffo/Vkt/JESkC2pqkJjI2FGn0ihB0kqtDypM13Il1VTC2GrKu+Xa1aowdDRhV99Hu2PgdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqsKwQhqgMbYn6lLSSgJCFyfgBBmA9IxxZwNs4pYMMA=;
 b=vjSZHO6VPE6aQ2q45GmY+tcsGf18xUn8hryhXAZVMD+bTLo/rY/lnAHM6l6A1gMKIMvKqa7fJA4SeKrqL48lamYfB45NdstmYzEEGnGXQ9BCwCZR6c94MtJT1BOeG82gJgBjVRYI22aeSLRdhIIi0KQdDYUFP7oKWwZlPpXuZc8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 14:36:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 14:36:39 +0000
Date: Wed, 27 Nov 2024 09:36:36 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: cel@kernel.org, Hugh Dickens <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 2/5] libfs: Check dentry before locking in
 simple_offset_empty()
Message-ID: <Z0cudKvYImrmbBRF@tissot.1015granger.net>
References: <20241126155444.2556-1-cel@kernel.org>
 <20241126155444.2556-3-cel@kernel.org>
 <6917283e-d688-a133-9193-ca5d6255dafb@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6917283e-d688-a133-9193-ca5d6255dafb@huaweicloud.com>
X-ClientProxiedBy: CH0PR04CA0077.namprd04.prod.outlook.com
 (2603:10b6:610:74::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 0805059b-c550-4ef5-aaa8-08dd0ef0e775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGdIWGl3R1JtZjNrMnY3QU1Iam5PYmlZb1Z0RkYvUGxtT2lVN1VRVE01REd3?=
 =?utf-8?B?VDU5U3JMNnBiY0hCYVNBVE1FOWcrb1Q0WGsycVN4dnp5SGN6QVI4TzFlSEo3?=
 =?utf-8?B?OUpoZFRUZDZ6WlBiL1ZjdG1rdXpPZFVlSXhvVXI4L0YvT1FBQnhiNXhTRmVn?=
 =?utf-8?B?VUVZck9XYzhqZm11V2x3YmluU20xV2tFTTBCRlloK0dmQmRwaDJvWW95WVhv?=
 =?utf-8?B?akpjMFRRVDBTS21NU1lGNEd6aGVwMk1xc1R4dXFhTnZYbWdCV2RYVVBEMitJ?=
 =?utf-8?B?T2FCbXVPeVZVTTRNN0hPdFRiRzdibllRU0lzWWY1ZFY3SjBVdjZWendMb28v?=
 =?utf-8?B?dWZPU3ROamYzcXQ4NTZnei9zdlczTGFxb1ByVG9wOXJoYnlLeUNHY2VPZmtE?=
 =?utf-8?B?aytkQi9uUTVMY1BuTmN5UXpXdGIrWlJrbW1SeEYyd2JTM1NtWUh0WW0zVjg4?=
 =?utf-8?B?dmJrbi9JOXNzaU02RFdKTGdUZTE0YmNVWng0ZFdxVTllcUdhYmFKUEVIRzFH?=
 =?utf-8?B?VytMQ2k3RDgwc1JIVCs5ZklZTzdRWG5ZUmJtNkFNYTNmUzZ1d3hpV1RodlhE?=
 =?utf-8?B?eU9hZ3R5Y0I1RkZlS2x5Z3lycWtFcVNEbUc3ZHpMWDluU2NTaHphWkpGZUxG?=
 =?utf-8?B?RHVnZmxOdnptZFdVOUFlcFVXaTY5VmJHWWt4b0xVNjhUQUVYT3hrb08va0dw?=
 =?utf-8?B?L01xY2NlaXF6NWNSeFhVbllMRWtjdkp4YUFjVDlkQTRWem41MkhLaG1WTkls?=
 =?utf-8?B?ZXU0OTdSdXErMW5hSDdXU2J0S1cxb2lZMGdUNk9YU1RjeERIRHNrbkxwOXVy?=
 =?utf-8?B?ck5sSXBXclFQZG53akFEUkR3ZVR2bTA2MWVXb1dseUEzTGhZTENVcXN0aVp6?=
 =?utf-8?B?V1NBZ3VrQU1lZ0M2N1Q3dWU3U2ROTm82QS9tbTgwZ3FCQkc4ZjRQdlA1U1Zk?=
 =?utf-8?B?dGlLdmRVQkJkUmdaZXVHZEZBUUNjYUpNV29HRjg3MzY1UEdyTHozSDg2b01N?=
 =?utf-8?B?ZklucFRCc2JVTkRFYmxFeVlOSitramJReHdlTGpkdmE2YzBjRXhGT1FwVTJz?=
 =?utf-8?B?NmswOTZDU0d0Nlh0Y1owaEk5U05iYUt6bWdEZkZLamNJQ1Jubk8vTDZjZzNw?=
 =?utf-8?B?WmZMNGVDYW1hdlNNUkZURXZPMGxueVI5bFo4OUM2aHFHSE90Z25neHc5RGRn?=
 =?utf-8?B?S0JnMkQxV1BLdmR1SHVTblUwRXJ0ZEQ2eUYrS0RXVGVmcjhEREc3elIxd2Yy?=
 =?utf-8?B?aEo3cFp6K2RFMW5vS296OEl1Y2NOOFU1THBDYjR5UTNuMTJOeUt0YTFPVUFW?=
 =?utf-8?B?aUlzMVY5QTZpcFk1RXRYeWhxNnlEN29YaklPZDArS0JZRFNGMnQ0TGRGeksv?=
 =?utf-8?B?WTEzYmZTM284cTk2U1ZZUWtRa3lQd2FJTmhzbkM0MElJVWZaKzZsMXRQbFZJ?=
 =?utf-8?B?R2pPcitMMTJZLzd1Uk5kWlE3YUh1OXZ4UGkxRlBHaGoxUjBMNFFMUFh0M3I3?=
 =?utf-8?B?RkF4aHlqUUxqWFZEbU5ic1BuT3Bla3hZQVNMRWVFRXJsa0thSUFIZ0NqVGRy?=
 =?utf-8?B?V0M0cTZZblJPRzVlbGxHb1JhaDBiUjFaZVA0Y1BQUEpKNGx0RUt2UUYybjFF?=
 =?utf-8?B?elk5MDdnR09rdkNGTklPdHc5SUdyRVVZRldFYWxyai8wSHB3SmpyQkc1VjYz?=
 =?utf-8?B?K1BJT1lFWEdkb1RhVWxwRUJzREhPUm4zdXdaMVFmZUFWRS92aW1qcnp0VG1Z?=
 =?utf-8?B?V3VSYUlFQzNiQ0RJR29ZdnZYUHZObWhJMGVaQldoejM2K1dhVVJVYXpiMnVE?=
 =?utf-8?B?Q3VUbXhhNmMzdDdrdUdiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVF4OERWLytpMDJ0T0NPSXNjdTQ1eExhZ2o2ekRxN1YrdG5KeXh0VUoyQmdL?=
 =?utf-8?B?QmRSdTUzZVJWUFZxV0Ewcko0NmhNSnRQSHhkZUhCaG4yL0sweU9tQWNHNkVy?=
 =?utf-8?B?ODc0MlpqMzNVVEw5MjNnMkZLalVBVXBEcm8vR2dRZDBxNGg2ejhnakptMkhL?=
 =?utf-8?B?bFoyZlBLZXBidnEySTVzQ3BtcXE5MFlhL0tVU3hTYjZDbnN3cVJKV2tmcVJr?=
 =?utf-8?B?VCttZitiMHpzcjJVR3JKV29XL01QTXpqTmt2QXhTRC92SFIvMk85ZjZRb2JN?=
 =?utf-8?B?OUkwYjlBRDd4WTVLZlk1M053Rm5nUzRxZ1lwOXlBMTRSM241Qk5FZlUrcHQw?=
 =?utf-8?B?cm4rMEtpMTUreEM2eEdmckt0YlErOWJMd0NKaEFkYm95QTRCd3kvZ3JIUTc2?=
 =?utf-8?B?MFR0Y2ZhVEx1WGV6ak5YMWFYdWZVanU3d3h4R3NvWjQxZE0xTWhkRlZ1OUkx?=
 =?utf-8?B?SGRvOVBQcFMyd0ZTaUQ3T2VpSFI2NGt5V0pjcXR4WDhIUlBBS0grMGM0aE8r?=
 =?utf-8?B?d1Q3QitzcGhIY21QNXdCU3phQnJDbC9ZU0drU2RpWWZNTnowWVlDNnpTVENB?=
 =?utf-8?B?bDRqcnZWYkpST1U1TTBHQXY5Wmg5VnR1eGJzeFVRdlVkM294Y0ZIYkJ6N2t0?=
 =?utf-8?B?a3Z1cTlCenA2UVhVb1hmYzhWNC9NdzZQRWNhMnc3TGpHbHlMZENaamtSckY4?=
 =?utf-8?B?eHJadTNPbVBZN3dyTWw1dHhHSUk5VW9vWDNyWktnbERYT21yR2RwY0lzTFEz?=
 =?utf-8?B?MEdlVXFpR1p4N1ZlQ3F1cG11UG1iRVMyeEl0OVplUHpZenQrTU9MaWtxWjcx?=
 =?utf-8?B?WU01NG9PVWhhcVVsMWdkZzRMVWVpNFZBVjcvK3FjVjcyVGpFS3MyU003MkhE?=
 =?utf-8?B?VWZuVUxoY1VJdVVrOUR4dVVxeTlMSDc2WTdYN2lrcFhNQnRMZ0N1TDhWTFRh?=
 =?utf-8?B?Ty9oQjY5cWNwZ2Q2SDVFM3VMc0hXbDFPV3JBU05UcU5xeWJDY29KVDloeWhw?=
 =?utf-8?B?WVdQUVZSU0hpQk5Senp5Z2hkNG1HSTRLVURTVG5BSUhuZVh3L1BOZnFrWHNG?=
 =?utf-8?B?Wm5GMTFVS2YvcmlrWWJmVFcyQ0s2UGQ2SVJiZGFFc0xNRlc0ZXRvTmJKZnRE?=
 =?utf-8?B?NTRPNXVaMW11dktVeEZydUM0Y3I1enhrYmxHVFJ1WXdjOElXSFViVHkxeGdm?=
 =?utf-8?B?RjVpYzRPS2NPTERWcGZHSGZxTHdKUno4N016ZjBjeUN1dk1VR3BVZHpjd1BJ?=
 =?utf-8?B?S0VRN2N1NGZoeG4wWGdCRlpPMW40YkZmT0RqUnNiZXJBZWYzV0kwai9OOW9u?=
 =?utf-8?B?Yk5IZHRzOWNuNzBGMzhVa3pnaUxsWStiamJacktKMHNwdHgzNC9hY1N1UC9x?=
 =?utf-8?B?SXRFbkRwRjJIYXc5V2M1Rm9DbnVySnNiTEJWNm8rRDhDWm5HS0FnMm4vQVNU?=
 =?utf-8?B?ZGtaZnhVY1FwNEpvR2lzUGpnR3BHOStRUFdtc1lqUWlFOUhPRjh2L0R3YlRD?=
 =?utf-8?B?RHMxWTc1bmw1V283NU1EaElpdjJmQWtLNHMyTm16NVVROFU1NXg0cnFTN1VW?=
 =?utf-8?B?WVhRWkMyTkV4WE9JcUN4VDV3NVF4cVlYLzJlL3N4cThXSVMyYXFoR1ZHS2xq?=
 =?utf-8?B?cGRhYUI3bEdSeUxnK011NEtLYXNJTDRWNmtuejBydkZXWC9vVEduajhoeWNI?=
 =?utf-8?B?MVRoYytUbDgrVXMySnh2M0RuUS83Wjd3NFRWamJzODJLckZ5eEpoRzlZNWRZ?=
 =?utf-8?B?aE1xa2hkMU0xTmgyOXF6RmZJejcybWJKaVcxK0tFTXZ1cUtCa3E4MHpXMlVo?=
 =?utf-8?B?UlViNVZLamVKQlJDTFVSQjBHcWdBNE9BNDVkUVNZOXBIWmtuNXNlZXZSaCtQ?=
 =?utf-8?B?MEp4ZS8vRHpwdTY4czN5c3crSTZ2M2tzWG9vaTlLRmRRSzBINVdBZHk3QmtE?=
 =?utf-8?B?dzQ4Qy9xd3A3a3U3Sk5rQzM0azR4bGVCa1dpSUpzZzBEQzlzd2lRR2ZQTG9U?=
 =?utf-8?B?WVBLWGIzWkFpeXV3cStJblZ4MU5zYXhIeWtQM1dwbENNZmJMZ3p3OWRlZ2hX?=
 =?utf-8?B?ek1teWp3Yk1vd0FCNVo1Rm5xZE8ySUdsLy9WcHZJaEwxOEhISTNHZG9jMGQy?=
 =?utf-8?Q?K53HqF5HROqMKLDvF+HxW9ooG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vib/kzvsRXicyPxPQJMLaLkORoPqC8yTUUDgxu0/87cjMMtaWH+KICS1QIOdsh3ZT9f+JLIdJo5PtHLgeIoVCkNvQ4dyduM8lX7vlh6kjyqtsNqqFi4ItP2Jn+usd1Ra5XXjyUKtU148f0BEvJEAZrGyL1UqolMFdmXyYBmC33MaWiB7hP+u6NFr2hLNm4CS/EyqNZ7dmyg7V54ibM+v9Jfkh5RGjxwHJyOzoULuyLzeeBvKMJKXlRa6RQ0FRuWHHGHddKhGhB8QwtklfUOEv9NYIYPyW/QHaoF8GP2z0OT4RtoSUGMQ9mUh628z8wLgrc9ojA4bal2/aTEJN20/shCgY9S8jWULh6n6X7HyiZe/5WTpMo2rGkOfp8G51xlWv5VuHtUn5LZ3fbP247Tdtgn/mGmdora4eWMmgRP6hJhyXaVWQ2sXEOUHJW5DrjVp3VYCUYNc/XIf5tgCfbbGpmfwojj3KND+YccOCjDp21xZghNcsZ/uNTZZaqdFEKbT4GoEuycpxBxSsV91beDbUrdxT/E7vNZmsVcuVqQTfSTuDCAFVrXoEMfdfEN8eBnpAMz5iofRJnJRk5gagf0PA//4xYq5FabDwXFd87EoLEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0805059b-c550-4ef5-aaa8-08dd0ef0e775
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 14:36:39.6225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDXcwjRFOxCSSGXg2+1p2D5VJnz8yYTJlYoL4jzDgh7zum/ODaxwS25U2QT1jHV8bBXAGp82lOIBCLkS8ZeFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_06,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411270115
X-Proofpoint-GUID: 3upp8WPPkOC6nkZiUbqWQLk9axEaS_HS
X-Proofpoint-ORIG-GUID: 3upp8WPPkOC6nkZiUbqWQLk9axEaS_HS

On Wed, Nov 27, 2024 at 11:09:11AM +0800, yangerkun wrote:
> Thank you very much for your efforts on this issue!
> 
> 在 2024/11/26 23:54, cel@kernel.org 写道:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Defensive change: Don't try to lock a dentry unless it is positive.
> > Trying to lock a negative entry will generate a refcount underflow.
> 
> Which member trigger this underflow?

dput() encounters a dentry refcount underflow because a negative
dentry's refcount is already zero.

But perhaps it would be more accurate to say this patch attempts to
avoid triggering the DEBUG_LOCKS_WARN_ON in hlock_class.


> > The underflow has been seen only while testing.
> > 
> > Fixes: ecba88a3b32d ("libfs: Add simple_offset_empty()")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >   fs/libfs.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index bf67954b525b..c88ed15437c7 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -347,13 +347,14 @@ int simple_offset_empty(struct dentry *dentry)
> >   	index = DIR_OFFSET_MIN;
> >   	octx = inode->i_op->get_offset_ctx(inode);
> >   	mt_for_each(&octx->mt, child, index, LONG_MAX) {
> > -		spin_lock(&child->d_lock);
> >   		if (simple_positive(child)) {
> > +			spin_lock(&child->d_lock);
> > +			if (simple_positive(child))
> > +				ret = 0;
> >   			spin_unlock(&child->d_lock);
> > -			ret = 0;
> > -			break;
> > +			if (!ret)
> > +				break;
> >   		}
> > -		spin_unlock(&child->d_lock);
> >   	}
> 
> Calltrace arrived here means this is a active dir(a dentry with positive
> inode), and nowdays only .rmdir / .rename2 for shmem can reach this point.
> Lock for this dir inode has already been held, maybe this can protect child
> been negative or active? So d_lock here is no need?

My assumption was that child->d_lock was necessary for an
authoritative determination of whether "child" is positive or
negative. If holding that lock isn't necessary, then I agree,
there's no need to take child->d_lock here at all... There's
clearly nothing else to protect in this code path.


> >   	return ret;

-- 
Chuck Lever

