Return-Path: <linux-fsdevel+bounces-39192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E69DA11350
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22274188A292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0220F092;
	Tue, 14 Jan 2025 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQIbFC6e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="snsa+Hcl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84520F985;
	Tue, 14 Jan 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891118; cv=fail; b=CqIpj3FftshuYvNJttRg6w1ImvP65xUQMaxdPi9ZvvNo1MEA7l7+eCqO3Cf0ShGAAU6j1ydzay7mRezcokdtqeeGva7+dVrNUNnWf8JRmo6EwphVxYELrCQswscTnq7IdW3KTs+RozlNQAndVOla9GXqZHd/f0vRTeA22MKIE9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891118; c=relaxed/simple;
	bh=9djB0A2M1v1h8O/uujH24pyLMXahznjqndfipgfzneQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/BjRT6DWdww/OuU+jWVOmUR0pw3B2BSM0uT+biLjD8TJilWf+SpF3zwWer7ALzfYAr+hStiVbmliohHw+OBHuwn3ObPMKRvt7lnl5irfa766I49KpaUc2SBJZqzB43S+O99FGwLOTU7uWFyPqNr2vR4J/Lz7WDv0lISLAxioQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQIbFC6e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=snsa+Hcl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIXsW4001203;
	Tue, 14 Jan 2025 21:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0+t0ETvNgrCOYIuHI/KBu73Ykm52Io8D96iuU1xewMM=; b=
	AQIbFC6eVKUWmKILEE7MemOYg6vHugMNH5+ccqwtb5idCDnHk3htsIXW3rVDXoNV
	hP6XPu+OyesNJnrA35DDEPqSiHOND/V4QQk2Tzj6peG1UhD1FnIT954D18ZaU5MO
	2KCAkaCmQSYI5QzTTaosi1sSeArd/GHVMw904eIeiFCm+EvY0mNRz+uVgOMuRHJA
	Vuazh7taB971Jij0su3YFDx73lDsb9V6G7wwC/EEV4zBkcHzi0XSDYV4JgTTP+qB
	uHJ/PneEP/PDB9bBmVgxqUi4kYjKxd/KB1/TzsOsWUr5bzylm1yVrxf4r0PZdjIf
	/3Xjobl2yTfR/0gZv5/a6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gh8xhfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 21:44:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50EKmJXN031296;
	Tue, 14 Jan 2025 21:44:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f38p61f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 21:44:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/GpVpgV1Xu4Itzczq6hQtITjgUvX8YhIvArcbVGoHG1beZN1rr6XwPDBtRZX8p5XoxfsNaHSTCHpf/AX/LDaZFHZ24bW+mzLiabWqhS2Rz9tXxmlDR1mw+mu7DDmq/WsJrOI4Q62gBtXPyg3IRhiBhGmJKrudYeE572Wy0KO31jwUThodVnDAmegKnlFBX39knC8OnBICscTuYmO2x6Vd1a4SrSvRJOpxFz/ZWQKdVDc49DXo3uAQiCfkGVUEGKtmIxdMtwLIBjAIwcIi7iAV0cGLH/k/Eu/P93Wl9yUvXPWMTz5bsPkD+HRpa8zc3m2zpQ8pyo+iKWs6riK3w5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+t0ETvNgrCOYIuHI/KBu73Ykm52Io8D96iuU1xewMM=;
 b=atZ96RDIr+jZjhipFdFPYwI46gUkptQCyNcGpI9KgPeiyBI8kH2IxCZjNh9tuO7A3j55ZKPeF6vBNjepg+oV9bIZkhWLPwLTmFxqHW+msrKmedVL1+xpt07R03q93MM1VjayrSoT6t6WlZYNi0o8J3lUQpSaB7QUmEF9NPP9mUpldjbVtFDafZHRH4LN9v/YW9sIs/NaaPcLQZlCMDMHWIaA1PebHrUxWp9x11C7aaAH4OgDqVLNEsC/6HMD9AKDSNkAVlvDIWSvpBXQTeNGEu5am8vEjckEv7/o7eaZXJEj6IaExXgMmQdbXyIS/0dxH3s6sxG44KNoaKhIlFRU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+t0ETvNgrCOYIuHI/KBu73Ykm52Io8D96iuU1xewMM=;
 b=snsa+HclsEvH4vlPDAs+wwpW0td5Jb8fEFGncLVNGRXuFmuUiCPGbTiRkClhyfji4cAgiAXhHbEE5Foavq/nJN07P/EKkQ3apVk7/3ucjY4gUgexyMZVR64OMnh9aKn2y5YhufayxUYP+R2RQUYNHnx01PvhkFw89PYrA7/ZaGk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 21:44:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 21:44:56 +0000
Message-ID: <0659dfe1-e160-40fd-b95a-5d319ca3504f@oracle.com>
Date: Tue, 14 Jan 2025 16:44:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Immutable vs read-only for Windows compatibility
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20241227121508.nofy6bho66pc5ry5@pali>
 <ckqak3zq72lapwz5eozkob7tcbamrvafqxm4mp5rmevz7zsxh5@xytjbpuj6izz>
 <28f0aa2e-58d7-4b56-bc19-b1b3aa284d8f@oracle.com>
 <20250104-bonzen-brecheisen-8f7088db32b0@brauner>
 <cf0b8342-8a4b-4485-a5d1-0da20e6d14e7@oracle.com>
 <20250114211050.iwvxh7fon7as7sty@pali>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250114211050.iwvxh7fon7as7sty@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0444.namprd03.prod.outlook.com
 (2603:10b6:610:10e::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f996062-e5a4-4a5b-b804-08dd34e4b001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cit1ZHZHN2drYjBMd2FJL1BiZGk4OWpGNXNHVGFNcDdZaFpxYWpzYkhJQ0d0?=
 =?utf-8?B?MEtnNUFSVDgxb0pQQjhvZTIwV29ZcmVPSHUvQ2d3eEJnV3JmZThGMmhyOENF?=
 =?utf-8?B?Q2x6c25NTVNCdjdnR1JhRVRRYnAzR05aSm1OcFk2VGUrR2VBeDlFVHBDYzk1?=
 =?utf-8?B?VmJLSzdQZE5XbkNWTmJ5MWtQN0s5amtHM1BxVG4zYmNTbWNlN3l3WW02aWo2?=
 =?utf-8?B?MFkySFRkK1hIUVkyRU1sSVpUOVBTV21JRjFjcFlUeVB5aERYd1pDN2s3VmFI?=
 =?utf-8?B?UXArWHh6UFM4WnlzK2tJZlp5SzZ4Qm5jakF1Qngvb0cvUFdrRnliZS91R0lP?=
 =?utf-8?B?RUQ3R2VxeUt0WVl0Zkd6OXMyNk5meVJsYzJSTEY3cGxWWmw4bElERmhCQjRK?=
 =?utf-8?B?dUNvRWswQXN6emdoSGg1ZkY1WDk0aVFpRStUK2I0b3pnYVBCbUx5Z3VOeUJT?=
 =?utf-8?B?RTlyOGFYdWRmdDhPbUJESWJzT2hKSGZ1UU1CUmVqQjZydmVkOEJNMjdQcEpa?=
 =?utf-8?B?MW9vRS9KcnBJVXdxNUlMT3pnTit2K3dZTDNlWWUrVkZsVndKSEl3V2RhZ2tL?=
 =?utf-8?B?bUdQQlptVm9qc2tqdUd3aUNIZnBWTTFQSW8vMUFPWEQvUnlUR3JmU1RhTGFy?=
 =?utf-8?B?dS9WZ2F2ZDZnTzEwWFQ4bDB3ckNDUHJUM0NCVnhldWVEU2JDUDJtWDQ0RFJu?=
 =?utf-8?B?c1VyMGJyb1V4cDdudnU2emNSTWtQVWMyWEMyN1BOaC9iRFd1aS96ZFdJOVRE?=
 =?utf-8?B?aGZoMDFZbkVnYnJtZ2Z5OC84WDdyRUdsVGJtdzVxMEE4UGl6TTNiRzQrMUI2?=
 =?utf-8?B?M3ArdVZBKzlwNEw3WVdmM1RXbjZPTFZmWUJvTU1FVjNkWnFJSmxLaFZISE54?=
 =?utf-8?B?MDlnS2o3Z3dXMndHUEQyRDNENno5OWFHakZEenEwNjJiNnhpN0lKMCtUZzRG?=
 =?utf-8?B?ZC96QURieFZ0TStXR04zUkhUbGdXeWgwTkNpTFk3dm14VXNEeWI2MTJqeHNO?=
 =?utf-8?B?TWY5TTh1b3VtQVpSQU44bnU5NDhEc1YrTURNNTVwUGZ2RitNNmZHeWRxNVhj?=
 =?utf-8?B?M1JLMVlIOSt3a0gwUmpuMVZCTUZzMHVOS3lOQ0Z4T1NONHRRcHBoRXVzQWta?=
 =?utf-8?B?ai9GY29KaHdsM0p1d0wzTmU1U2hNbFZFZVplWDdIcnBvelAxaitMNkVJRkZi?=
 =?utf-8?B?YzBJWDhhM1BLT3FUbUVEc2tsMmsycWFYTmZUTjdPLzFxSnRnM01obDFEMkRE?=
 =?utf-8?B?ZkUwNGoyWjM5S2VLbldGV2dNbVVRNHkzZFA5Y2Q3Vis0WUdiUkZSOWQvSEph?=
 =?utf-8?B?cE1HNHhmSlhRMkVWaUhnOHNTKzc4T0FsRWRTbkd2azdhdUFJaUhGUGtUUWtu?=
 =?utf-8?B?RkJZMGM5S3ZjS0FrWHhTNU5Vd1Q2QkdTL1lqS3J0ZHRzajdKMzlHcEc2L1dw?=
 =?utf-8?B?bEtSNHp4UGxmVjBoSkJDNVRwU212aGhBVHNrTnp4TThLbTUrWC9vOUtsQWls?=
 =?utf-8?B?aFM2NktyVUMrV1hGNkFodmQyck5sTXd1cnlOTE93YUZ1eXNSNHpUMlZ0K3Na?=
 =?utf-8?B?MWV3bWVyS1ExV3NGUnI4REI4MXBmNy9ZZlYxWjR5bTgveDRZYzFJTXQ4K1Az?=
 =?utf-8?B?eHlrQXBkQzVuZ3RSU0NWNWFaU1JKc3VaclJwMzRHOGQwQnh1MzN5d3FVR2xS?=
 =?utf-8?B?MkdwMkp3ZlZDZHZxcWQ0bjFOUFhMcVE4UTdkMFBPQ0pZR2RyR3RoOWF2MEox?=
 =?utf-8?B?YWJoYVYzTnlEdXU1NmZ1aEhqSGN3aXJuZHNRdm9mYW1ZVUV2ZUdidjNrV0tm?=
 =?utf-8?B?SUNrN2ZyN29XR2NVbUxsS25TVlJlWW8vY01iTm5JbEsxRDc1QWJTaDFsclFF?=
 =?utf-8?Q?SLq7CPnTQquMg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXRPNmdVRkl6VUhvWjE3S0ZPZk1lQmdPVnNpdnBsSFMzZ3E4N2cvdUdHbk1K?=
 =?utf-8?B?ZXVrL1JBbndRQm1vN1pvOTV6bUFNbXhTb1JXdWwvTDN4Y3RhQ1AvekNweDVo?=
 =?utf-8?B?dU9JdHRjeldKakJtYjJRd2xpTnIweDFyQzdiK0d0V0ljL0ZQcUk3bVVnN1Ny?=
 =?utf-8?B?Z2RkWHlTK2Rmam5PMis5NlcwT0pvK0hUMGZCWk9iUFAwM2ZrOFFTc3lwTGhs?=
 =?utf-8?B?SFgxdjlWUFU3SGxJM0NVaytiL3FmNFpmRTQ1VVRqbW9ueGVsTkNuUWJrdjBC?=
 =?utf-8?B?MDRhYStoM1JKVHNoWHVvak5KTHNZT0lHQVVLenIxcmxQRU15QmFSM2RWUndD?=
 =?utf-8?B?dFFwZWhBc2Raa01WMGJVWUVjSTNwRWx6SlcrVDhNZkc2Nmh3cUhmY1NtalpQ?=
 =?utf-8?B?OGh3SW12eDNIZ2pIVmZjNGxGeEFra1lLTXFBdkttOWlpTmNjU1VML1lFRHNn?=
 =?utf-8?B?U1NhVEVnTGZUSHlGQXc4MFVtWSsvUm43aHVYSnNYUzNJSWNhTnBlNE9MbDIw?=
 =?utf-8?B?U0NKVUVoaGZNVEtKRmhRakoyMjJkeDFYL1VWNXV3ODYyOGdiOWViSEJFRWxG?=
 =?utf-8?B?eEprb0xzWjc0T2ZKY2JOQXRncm56dXFJeTBHaEQ4SWpEejVlc2FjWGlFbW9i?=
 =?utf-8?B?SE81S0RRMFBhY1hqSThGNEM3YmliWExZdk52cWkrQVBnVCsyNFM1Myt4QjZT?=
 =?utf-8?B?WVNhWGIrRktScmFJbjdyVmhjc3RRMWE0c1JwbVRRYkNNeDIrM2wrcnp2WlpD?=
 =?utf-8?B?U0JiWUMwbWsxbSs0U0VWWDNYTjY0Y3VUdEEwZzFBN0RSMWtaYkhBRU1EM0o3?=
 =?utf-8?B?M01MWVFwU0RkSUVpbVg3U0s4d21yMDYxOWJvSHc0UGdYb3BCQ2taVEVhbXhm?=
 =?utf-8?B?VUZjUzRYS1RXUFdaY1k2YStiNkxGMzJkdWtqYjhiT2VjYWw3Q1BldnRxTFpr?=
 =?utf-8?B?aEpnNEx3cVpWUDcwS2RCM0IvY01OWUsvaVRLSWtNbm5DaUt0eS9nOEdFdGtM?=
 =?utf-8?B?STd2TzFCVzdtMU8ycTdhVkUxQ0ZSRjRwMjNLUmpUa1VXbEluN3orYnBHaUR3?=
 =?utf-8?B?am5VQ2o2YXRHMnhSUVhnaHFyb0JXQ1VVT0FYTUFGeTkwa2FDeXRRdmYyemlv?=
 =?utf-8?B?ZXp5K3dTL1lISVpCbElKb3habDZ0MUlqZExyNm1maERVU1hCbVMyMm50cmx1?=
 =?utf-8?B?dmIxa1Z0Qm00TXdrcXQvTkhnSWV0eXk4cjNuRU1aK3Qwcms0YW1wd0RUZ05n?=
 =?utf-8?B?MU5zc2RmUDFqNWFyV2M4MFoxRkFDdFZZYTJSL2RCelMrbEM3UlpJTnpWTmJm?=
 =?utf-8?B?VHBHZXcrTThYNjZTY2w0S3pKYmgxeTZaNlVyUWh0d3FZQklIcC9vYWJkV05Z?=
 =?utf-8?B?U29xNzYrZUZUblowR3Q1WEJBa0llL2VGQ0RNU3lyNGYyVXh2ZlI4VENMUDIx?=
 =?utf-8?B?OTE4bjhxS0JVZXdJYnZnUURjWDQ5dTZSMW05K3Y1WStFN1o0WUhJdVUvMG9C?=
 =?utf-8?B?bnZoUDdTVkNnd3Qyd1ZRS2dUanlGQ3Q3UXlYcWk3Tms4M3h5T0djLzA5UEto?=
 =?utf-8?B?YVZndERRRjg1akxDamtBWnU1eDBRRG1rRFhZWGlnNFF6T3FnQ2p5djlOTTJL?=
 =?utf-8?B?djkzc1hIYWJIMXcyL21vTUNrUGYzS0RUQUgwOWRNVVJldFRqbDBzbHRWNWVH?=
 =?utf-8?B?a2FydGd6NVZOb01FNlR5Y1p0cmxzQ01lQ1AxQlF2bVMrU0U0QUsreGNOTExm?=
 =?utf-8?B?Vk1rUE8xUDEzSDBVS2FoekZKQVIwc1JyUzl6QnI0YURWUXlrRjUxRnowcVBk?=
 =?utf-8?B?YzMraWFvK1F0NUVzdGxRaCs3eStDQ2Vla0FkOS9HOTU4blF2blpWeU1WUXBN?=
 =?utf-8?B?RTU0OXRJQklMWkdYRno0dldNZDJyRVpTeXlOZHNZa01IY01LVmdCaHcwaUkx?=
 =?utf-8?B?bWNxOFkrYkdIR1dMWHo1VGJKL2ZOeHd4S3hSRi9NQW9uQnhjcXhVSFBzS0xB?=
 =?utf-8?B?VEpsZ0lzREVNbThicnBUWnpucHdLN0hiWm1sMjlUdmVBUXgrUldjdVcrVlQ1?=
 =?utf-8?B?aktOd3lPb0VWUTNVM09jZUpOWUxSMGI0M2d2YzgrUHJuc1NZMU1wTEg0UzJP?=
 =?utf-8?B?SG5TdnYyME1lMXJXZ01uOC9xV25ZMTdFakxzMEJ5ZFJKZkxDa2JGMzFTZ0pi?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qgp+888P9th174TId+gwEdz0R6Zh77EZ9BmbNbGaPplyxy/cNLb1L4/TzC/MHjFrpZ06FSxymNn7q169ya0VbjDZz+jDgIArX1Nlv5Wi3SJoUN0gcXUiThiYoJj71+Zpj1FvlVk5PIJLTVtcbDTWdM5hOyifGLjUc0blVvUGKTd0qZi2Kaxrjm/qG9+HmanREbwLNfFlIjHJVXGM8Ja8WMQywQAi34hUUwWAhStZFp2Q7wKdkbqV2XEkcbPQw78iy+d7SYpeTB8eW1NJ36xhscNGpKHDhxn6DO4o3LEfKupDjBaqJ85IaZ9Fz344y6e6Vy2xFyBF2FW2lN8tYTzV36zDjBLFYrgIUqeO87NfLTbr72RjbWbMHaJ3rpm01g0IUO2Wm5wU+Ce5GywBPTprR86Cd42PZbEP9xMUmCkdSvUbrv9rW/+A4dL0mlLblgHonhFWInA5tXU3wWixBkyhB+Hk93wHqYeqRa9EsRUEpFsFta8NaBmSMBUFvxw0v4vu2MD0gv5rIGFmGsydeIyHMpj+mOrULJJ72V+J8Bq63stAGGmr7bOL0Regq/WWfHaTZ5ensCN2Mq7uZlooEZoiqZyVIBPgF2V8kUZB4MH7q7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f996062-e5a4-4a5b-b804-08dd34e4b001
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 21:44:56.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Njqp79SCfHaxAXN3O5bOI2eka8N215A6W8Wto7Tf+jZSo8jvVbweh9wIWTyflCvHYgI5lUE10KdWi6aObLcw1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140163
X-Proofpoint-GUID: O8wu98YDu9PAAnbgBV2FzL4dJkAqW-6H
X-Proofpoint-ORIG-GUID: O8wu98YDu9PAAnbgBV2FzL4dJkAqW-6H

On 1/14/25 4:10 PM, Pali Rohár wrote:
> On Saturday 04 January 2025 10:30:26 Chuck Lever wrote:
>> On 1/4/25 3:52 AM, Christian Brauner wrote:
>>> On Thu, Jan 02, 2025 at 10:52:51AM -0500, Chuck Lever wrote:
>>>> On 1/2/25 9:37 AM, Jan Kara wrote:
>>>>> Hello!
>>>>>
>>>>> On Fri 27-12-24 13:15:08, Pali Rohár wrote:
>>>>>> Few months ago I discussed with Steve that Linux SMB client has some
>>>>>> problems during removal of directory which has read-only attribute set.
>>>>>>
>>>>>> I was looking what exactly the read-only windows attribute means, how it
>>>>>> is interpreted by Linux and in my opinion it is wrongly used in Linux at
>>>>>> all.
>>>>>>
>>>>>> Windows filesystems NTFS and ReFS, and also exported over SMB supports
>>>>>> two ways how to present some file or directory as read-only. First
>>>>>> option is by setting ACL permissions (for particular or all users) to
>>>>>> GENERIC_READ-only. Second option is by setting the read-only attribute.
>>>>>> Second option is available also for (ex)FAT filesystems (first option via
>>>>>> ACL is not possible on (ex)FAT as it does not have ACLs).
>>>>>>
>>>>>> First option (ACL) is basically same as clearing all "w" bits in mode
>>>>>> and ACL (if present) on Linux. It enforces security permission behavior.
>>>>>> Note that if the parent directory grants for user delete child
>>>>>> permission then the file can be deleted. This behavior is same for Linux
>>>>>> and Windows (on Windows there is separate ACL for delete child, on Linux
>>>>>> it is part of directory's write permission).
>>>>>>
>>>>>> Second option (Windows read-only attribute) means that the file/dir
>>>>>> cannot be opened in write mode, its metadata attribute cannot be changed
>>>>>> and the file/dir cannot be deleted at all. But anybody who has
>>>>>> WRITE_ATTRIBUTES ACL permission can clear this attribute and do whatever
>>>>>> wants.
>>>>>
>>>>> I guess someone with more experience how to fuse together Windows & Linux
>>>>> permission semantics should chime in here but here are my thoughts.
>>>>>
>>>>>> Linux filesystems has similar thing to Windows read-only attribute
>>>>>> (FILE_ATTRIBUTE_READONLY). It is "immutable" bit (FS_IMMUTABLE_FL),
>>>>>> which can be set by the "chattr" tool. Seems that the only difference
>>>>>> between Windows read-only and Linux immutable is that on Linux only
>>>>>> process with CAP_LINUX_IMMUTABLE can set or clear this bit. On Windows
>>>>>> it can be anybody who has write ACL.
>>>>>>
>>>>>> Now I'm thinking, how should be Windows read-only bit interpreted by
>>>>>> Linux filesystems drivers (FAT, exFAT, NTFS, SMB)? I see few options:
>>>>>>
>>>>>> 0) Simply ignored. Disadvantage is that over network fs, user would not
>>>>>>       be able to do modify or delete such file, even as root.
>>>>>>
>>>>>> 1) Smartly ignored. Meaning that for local fs, it is ignored and for
>>>>>>       network fs it has to be cleared before any write/modify/delete
>>>>>>       operation.
>>>>>>
>>>>>> 2) Translated to Linux mode/ACL. So the user has some ability to see it
>>>>>>       or change it via chmod. Disadvantage is that it mix ACL/mode.
>>>>>
>>>>> So this option looks sensible to me. We clear all write permissions in
>>>>> file's mode / ACL. For reading that is fully compatible, for mode
>>>>> modifications it gets a bit messy (probably I'd suggest to just clear
>>>>> FILE_ATTRIBUTE_READONLY on modification) but kind of close.
>>>>
>>>> IMO Linux should store the Windows-specific attribute information but
>>>> otherwise ignore it. Modifying ACLs based seems like a road to despair.
>>>> Plus there's no ACL representation for OFFLINE and some of the other
>>>> items that we'd like to be able to support.
>>>>
>>>>
>>>> If I were king-for-a-day (tm) I would create a system xattr namespace
>>>> just for these items, and provide a VFS/statx API for consumers like
>>>> Samba, ksmbd, and knfsd to set and get these items. Each local
>>>> filesystem can then implement storage with either the xattr or (eg,
>>>> ntfs) can store them directly.
>>>
>>> Introducing a new xattr namespace for this wouldn't be a problem imho.
>>> Why would this need a new statx() extension though? Wouldn't the regular
>>> xattr apis to set and get xattrs be enough?
>>
>> My thought was to have a consistent API to access these attributes, and
>> let the filesystem implementers decide how they want to store them. The
>> Linux implementation of ntfs, for example, probably wants to store these
>> on disk in a way that is compatible with the Windows implementation of
>> NTFS.
>>
>> A common API would mean that consumers (like NFSD) wouldn't have to know
>> those details.
>>
>>
>> -- 
>> Chuck Lever
> 
> So, what about introducing new xattrs for every attribute with this pattern?
> 
> system.attr.readonly
> system.attr.hidden
> system.attr.system
> system.attr.archive
> system.attr.temporary
> system.attr.offline
> system.attr.not_content_indexed

Yes, all of them could be stored as xattrs for file systems that do
not already support these attributes.

But I think we don't want to expose them directly to users, however.
Some file systems, like NTFS, might want to store these on-disk in a way
that is compatible with Windows.

So I think we want to create statx APIs for consumers like user space
and knfsd, who do not care to know the specifics of how this information
is stored by each file system.

The xattrs would be for file systems that do not already have a way to
represent this information in their on-disk format.


> All those attributes can be set by user, I took names from SMB, which
> matches NTFS and which subsets are used by other filesystems like FAT,
> exFAT, NFS4, UDF, ...
> 
> Every xattr would be in system.attr namespace and would contain either
> value 0 or 1 based on that fact if is set or unset. If the filesystem
> does not support particular attribute then xattr get/set would return
> error that it does not exist.

Or, if the xattr exists, then that means the equivalent Windows
attribute is asserted; and if it does not, the equivalent Windows
attribute is clear. But again, I think each file system should be
able to choose how they implement these, and that implementation is
then hidden by statx.


> This would be possible to use by existing userspace getfattr/setfattr
> tools and also by knfsd/ksmbd via accessing xattrs directly.


-- 
Chuck Lever

