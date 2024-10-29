Return-Path: <linux-fsdevel+bounces-33107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D0C9B4518
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 09:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B254D283BB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 08:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07925204029;
	Tue, 29 Oct 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WXMK1/Nr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yaYHn+Wi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3C204009;
	Tue, 29 Oct 2024 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192290; cv=fail; b=t8OwQPePaKMFousUeBXqkNlWFk6nvqCLCnI+FBPXMXewhRbr4+mjq6wHyVylzRirLTcKDM7TNG30KsqnzwkPCCChVvV4ewsfyVSb4VUoH4lDm9ubAjBqIpf9oyIAkpk1ejNWk0h0EhB4SNDyM4Gu+VhzUk8ETp150VB9rqihtzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192290; c=relaxed/simple;
	bh=fF9J3kCG8NKimywXZ+gu8ItsCXEfpySNgyBHa9REEw0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFQVnxHWMGuzBQRz7JgNdvdE9ut39Gbs1G6zcAjND04BxsHxgHjuyrch4QOdZl6nBnZKt4ZVBh2qPTnx1bpmNj8uJ2L8ciNzhLrdDplagf85NLPbEsi9MxB3BCk+TPMQ2XyOw5IHfgb9NZ43JOzbqZEPIMJigNN1rJyG4jJ+snk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WXMK1/Nr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yaYHn+Wi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7tZkq029741;
	Tue, 29 Oct 2024 08:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DkZ+9hayh6unJKqDpL7vcm5EcC2wiBh+axQcVbNaCfo=; b=
	WXMK1/Nr1Af5YlyVpgk4OF8PQw/6nDkoy7itCdTt9peoEIDQ6mtHKEbBzWN5uwIg
	CKoCg9NzSqLS15a+lqumAIY52tHdp4d309VvXg9kBjzv13usWGODOccGDb9hvJYu
	mSXqRJ7fErRkKXZkBgeEkkVKLgbjnw92FWUS1lQFbRNBCoCQJ/+4jkpFld57u/ID
	tH/x+jGwx0t0SsEvB3hyJsDytMY6hPKCUfAgkABtPsNq2Ltohh7H5vQuqcqnFNEC
	0sd9AfHsNOMAKMCIQe5vH/Ie45e1vjMux8EWTDFR+LkSqI+4ylDOcgXvgj746yCA
	9qn7Jig9kbfU04/XnaK0dw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmcvrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:57:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49T8bFje008666;
	Tue, 29 Oct 2024 08:57:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne9bwnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:57:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyr7+Ab4AW2K4La5KXkXStsKMbURfveFdURCqg1jpleueoY6d7JBOIDPChPv8OCuRi4oSt4jXEBA0CfAL1OHoe/JWewLx2xe84HdTMcXOXtExOT9fA0GosEVSFoDVFHyw7ouU8Pw7ha5Prf/3SiuwDGsFxgW6oqOSncwJ0yuBzHsjDCiBaxoBvl/70sIggtJiWZOwaSFl1PLn59uctH5rlvPsNXFs6VH3KwE/pMkauCn642lH1yEpX2W3tPiCbeYbDpkUs8EquElNDjOnuyFHtTqyc9LX0WR9FNdbx0dWI/dx/fhGb4r3aSfIVwLfTDDi/z2CUahpv3EIA4Oyv+ahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkZ+9hayh6unJKqDpL7vcm5EcC2wiBh+axQcVbNaCfo=;
 b=V1u3MunybLwkfJbSDgFWmiiLfl34epaCOQ6iZtG5aXTpG0Hv/IldT5s13XyJCYlcheB+WUlNbXEjKrdIT33pLGf/S250ChKJm4Qc6LZaMhrBOcV3nUEgdnk5NP1SheGdMBukDvVH7EmeTQhfL1YWwknN9LRhITcWL00fbeu0MPh+wG/lMXt3K2P8l4lTcobsV2swqFM/EBv/fdFz5cK2oXDVE1Yw9h++TdHVMLen2vav2Yq8Y0FpbWiZNwhrg2uAhL9VAfjGy2IcCBRc5TssXAb7zz4k6ycOH9FjBtz/zJ/UurzABPY+LiBefiN31DknnamXcF9UzNEdu2j1QO6YYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkZ+9hayh6unJKqDpL7vcm5EcC2wiBh+axQcVbNaCfo=;
 b=yaYHn+WiYGT+iwtowoJqLLYMJgsTdzCrLVOsiiFOmrRXDNvRfbcP7ddESXTkPlbGulLfsxG2Sky7e0VDnGMW/MPkB9StXHFXb6aKuyw8Lt6WZbYlx6JwqLn3q7JV7WVAKaXRXnnMU8UYKrPKX2hNvuROv3EtNW9kU+PLZvkcoeY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Tue, 29 Oct 2024 08:57:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 08:57:53 +0000
Message-ID: <fff46380-1e01-473d-860e-19d5a02a7d1c@oracle.com>
Date: Tue, 29 Oct 2024 08:57:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] ext4: Do not fallback to buffered-io for DIO
 atomic write
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729944406.git.ritesh.list@gmail.com>
 <80da397c359adaf54b87999eff6a63b331cfbcfc.1729944406.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <80da397c359adaf54b87999eff6a63b331cfbcfc.1729944406.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: acd7a4f4-0baa-4b01-1707-08dcf7f7c657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUxQSWM2ZG1XRVR5bnZuNlVVdEIxZDUwVFloK1dWUEpjQ0ttMmZVbUhSSUxE?=
 =?utf-8?B?Yi9aVk5WaEtONWhxRThoa2pLdnA5Snk4dXNiVENsbzA4MXcwckVzQ0JmMnFx?=
 =?utf-8?B?UVo2Mk81VlFHVmI2Nncwc0ZOQmczWU1HMnVTbS81ZkRhMVQ3dnhCVG9yeGNa?=
 =?utf-8?B?KzdkU0lLUzJqV0k4SGxoWDhYRWh4Njh4ckNFeGRjNGx6TkpMc2lTTFErMFhY?=
 =?utf-8?B?R05naThCZmJWeEFNYkJBNU1tL2dZekxIelBTbTN4NnFySWxReXFBWXA2VUxp?=
 =?utf-8?B?OVNjVVpvSmxPSzZKWHgwM1AxQ3lDSE5rTktHQ2F3SDJZQlJjcVBHSWdQNlB4?=
 =?utf-8?B?cVpCOVpReFU1cVBNWkg4RnhPZDViZzRQelJJTDhRblM3b2trOEsvS1lWL1dN?=
 =?utf-8?B?U01JTk1OekFtNzJvbFRpb3NYOVBjNlNoOTZwVlpYZ0dweURrcE5FYk5oT1dK?=
 =?utf-8?B?WGNCaHA3Vms1Y0RzNDhTQVFHTEtWRkwxUlp2WXdPVytDSU40Y0l0elQxLzdu?=
 =?utf-8?B?Q0Z2WC8vZ2EybitMdzBIelJORmJCais1VDQ2OG8vMVVBQkdoZ3B2bGZDKzdv?=
 =?utf-8?B?WThqT09CT2xOWXpPZ0hhZU9oM3BhUE5zSlY3S24xbG5BRWY5WGJveUtkSERM?=
 =?utf-8?B?Z1dTRWlwVGJ6NXVuMXByOTJZTS85dUczcytqYjNqUTFoS2l0VGdzYWJuTTAz?=
 =?utf-8?B?V01pQ0JGUnZXQlRXeTliWnlZa0JadzYyN2RzZGdMQW5pZHVweXFMM1loamdt?=
 =?utf-8?B?bFRTUHY1bmRLWDR6RGdEQ211QWRvZC9RSHljTTIyamhzb0ZMMHlMSnVyMTFz?=
 =?utf-8?B?LzlaeDNZYTg5c1lYSWhvODc2Y00vNG5teFp4dEgxNno2WWNzaUJDOGJ3dldt?=
 =?utf-8?B?MVdwNUtGcHI1aC94ZmU4V2FFUWRnRmk2V2psUE9UNFFTdS82RDg2WWY5eitN?=
 =?utf-8?B?TXZhUi9iaHRYTnNYaVNaT1M2RnpDeldWZWNVTkp5MnhHZWdjalV1bjd3Uml4?=
 =?utf-8?B?Qm01akVuZkZIVEY1bmFiQ3IyQXh5TEYwRHhOQldoMFFUT2h5cHdZZUduaEF3?=
 =?utf-8?B?cWZvRTIxQlF1ck93ay9sNFlmSUdWWkVDeU90alcwMTJHZm9LMkNKSTlHc0Zl?=
 =?utf-8?B?N1hRbkRQMzd2RTJITjBhTHlJanJUL3lVM1NrN09NTHdGOVU1ZlRGbTBVRVFv?=
 =?utf-8?B?cVJwbktDazFKdUpZUXl1NTdicmt1UjlEM2pvQlhETDBFbnI4ZHk5a28xZDRH?=
 =?utf-8?B?empjM2NiM0RZTFAxd0lmMHpqVGZNQTFwQzZ0WDNlK0JOZ1hGNXM1L21MNnFa?=
 =?utf-8?B?YWQ1UE41bFNQQ3pTVC82azZPMERnTm85TnA5ejNHYmVlM1dQYVkveHZ2U1lZ?=
 =?utf-8?B?QTA0Mnlkd05tRWdRWjZoNFIwUXQvbDBNSmpIMjdpTlQxd2xnRlpVSlJQRTF0?=
 =?utf-8?B?QnprZkxqeEhaS3pDVDRxc2REbm1PTk9LeWE3bEZrV0c1KzVwNkdOR2c3NFdD?=
 =?utf-8?B?YXpNei82YzVEbnFHdFk1a3BwVkpqTHV2TTN5cWIxQitBQ1lZeGFyLzA1ZHZo?=
 =?utf-8?B?RkRVSi9teDNoK2NxOXhmZzFzSmtxdzNHbDJpS3dvUWsrY3N0anpGM3pkTEJp?=
 =?utf-8?B?eVpSUmwyMlNRb0FzbittTll2Um84OXBPWnJ6TmtmV05QR2ZidUFZdVFWajhL?=
 =?utf-8?B?aDYxSXMzZzhGVDIwOHV2SVVtcGFZeWZ2bGh5Tys5eWdOeFJrMXBUQzdKeE5w?=
 =?utf-8?Q?zE1UpZ49YV8Jj27jiM9n9IqTWw9Owa9GJBHVUwS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3JmNWI2Q3Z3aE9LZVpnRjNzOGcwQk5IVCtNSVlXLzc0YlBTaWxyMThwMkc0?=
 =?utf-8?B?ZFNxdS9LUVpIRlQ5ZkRyUm96VUE2R2M2bFk0ZnRTVkoweWRDRkV2UU50WDgr?=
 =?utf-8?B?eUhrTWJCK2dmaitCWWJWZ0o1RVZJaHM2MENYeVJkOGdiVDZRZkxBUUNxTDdG?=
 =?utf-8?B?ZVJ4NWswVldxZDhDNDBZbnhuUTJZaDhRb0dUajFmaGV6TUhmRTJpRkJRV3Nj?=
 =?utf-8?B?eDlIRnA0ZmFOVnoyU0RldUZ0NC92a0ZMZUtNZksxcUcwbjFNYksvR1UyUW1W?=
 =?utf-8?B?Mm5hTkFNT1B0SlcvRzZseU05STg3S2l2T2JaRnVYN0hnWnQyZWxIektFUmtB?=
 =?utf-8?B?a3NkODMzQkZPaC9rK0s2QjhmUGtkbUEvemdjTTExT0lNWUppMmN5SXZPanFx?=
 =?utf-8?B?MHdnWS9kcXhsTVV6dXoxcmJLOGp6Y2ZCc3E4Vm44eGZRS0Nwa0Q2Z3hSOW53?=
 =?utf-8?B?ZURvVmlLY3VWMlliVHp2V3BzZDFQTzN4T3cyb0kxUVRBV3hzb3IrWFFLZmp3?=
 =?utf-8?B?TW9kSWZDWENJSEVTRHBiUzMwTlJPeGU4d1hVbjM4c1ovNE1rcVM1RWpTcTd5?=
 =?utf-8?B?bk5kd3k1akpOTm9BeHkvMFpuK1NRcE9xa2dxSnNxaFg2UTZjOUtYVkJ4Nmdt?=
 =?utf-8?B?ZFg2dGVYVlduc1pkN2ZLaU1vVEk1ZVVIYzFhSngvMTJ2azVrUUhNVnJ1M3hn?=
 =?utf-8?B?Z3lLUmhKNFdiR1FMVHNtMnNvWUszcC96RXNKdXR0c2tOVWdZQ0lvT3ExKzdX?=
 =?utf-8?B?QTNsNWRROVlGSWVEN1lRakxraGRSeVV1aEcvNCtMeEE2aElxQWY3MENvQUpY?=
 =?utf-8?B?czJYWHNzaU5waVBGazg1K3cyWE9Gc2xNSFpZTDZmTUVVRVdXSFBhcG43QUlk?=
 =?utf-8?B?N1JMUkRBTWgraUVNRFhJZUJVbjVnZ0I1ai9iZFpZenRWMnNBU0lMeTNJOUJh?=
 =?utf-8?B?TEdYZ3dBV0hZWnEzcjZlY01vcDdtN1FUbW5ac3NoenJhK0ZsaVRYR1R3clZW?=
 =?utf-8?B?eFZlOFBNbmdiV0xBV2c1bjlYVHpPWVFPaC83TC9jWGlHbjNhL1ZxNjJDTUJF?=
 =?utf-8?B?ajZyeWJzUjJIdksyS3NxeUlhUGNZVnFKTm81RU1hZWJvUUxYN1FSemo2Q0pP?=
 =?utf-8?B?anlnaGIyb2dkRUNSL3lnT2J2STRtekFERHNvMzliNGtlcVpRbTFJL2ZrR3Bq?=
 =?utf-8?B?V0Z1SngzSDBxcWY2Z1BLSzEzamhKQ2RiMitBc05BVXl5ajNpWnZzdjV5OEJK?=
 =?utf-8?B?WEZ6TWZOK2NWaTVLeHZkL2pnWGxGMU8zVDFyclVlVDZ6MUhtTmpwZFFiVGF5?=
 =?utf-8?B?VWR6TzNuR2ZWU1lIN3lCaXRpRTdaT0FkY3BIU0FxeWRucnA1allibHp4bW5S?=
 =?utf-8?B?S1lYYU00MFBGbDZTQjRzNWMyeUNXWks5TllhN0lCdloxZ2dweTJRclFUVkdm?=
 =?utf-8?B?Smh5U2xBWTZINlpjSlVVTTNwem9iVEoxbnltSWpBYTQ4THFZNDM3K1hIOU5G?=
 =?utf-8?B?WTR5T0UzcWdJYlROQWhYSkVIRXBnNzJNaVVGMldReUpuZkpBQTc5L1cyRzdR?=
 =?utf-8?B?SUw3dnl0dkswbUdMelFiYkN1MGZHMjNxZDdyWTk5TkFjYnJmZkZBR1JHZ3Zu?=
 =?utf-8?B?ZzFaUFlRRFF2OFRtVUhvSUJyb2FOd2MyUE9rWmdXMFhneVhOa0ZDL25iekEv?=
 =?utf-8?B?SWxjcU5NUTlqRTNESDFFWmxVRTV0MDQrWnMvSVhJTlkvODNjUXE1QWtXOEE4?=
 =?utf-8?B?alk5YW5jOStwaW9vRnluVHVtYWUzcnV0blhtSklaSzV5T1dFOGNadDBqaDgr?=
 =?utf-8?B?WDlNNDdPTWJlcFFzby9PRGVITDh5TDRrL2F4SGp2Uy9NdW13TUVJWnRmUXh3?=
 =?utf-8?B?RWFoUkVZOVVjL1pIY3hsTGI1NWJFMUxUZHV1NkJuS2tFMzFtVERKTFNsMFcw?=
 =?utf-8?B?ZmJIZWxkRHVCQm5sMW1hRnUrQm9YUE1FejliRE13Y0UyZlp1RFNPL2VlakI0?=
 =?utf-8?B?T2NXQ013YWFxSUVVdUJDeDdKRmRGQ1pWcUtMcjJySjRDTjVPOHAvcmIwQllS?=
 =?utf-8?B?K1lMMlBpNGtwSTZ3S0FLSHV5SVlXRkNEc1U3L0pjemZlZUl0bmo4VjFGbDQ4?=
 =?utf-8?B?Szl5eGpPc2RSRFg0Njd4amdXUlhIb2JBcUxkdXZyV0tWZ0FkZUFzME9jdktB?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X7ubNrFGpmTvdYLGDVjt1gn8zLUM4N6+5roVWH8m/Oj+aJe4YWKJYy3tQKLCo2ak9rPAvoxBfzy86wmHCsCiNYi98uMAzAhsP0Ctm0oZBmqDisD+0adSQHjTrHJSgZ5Q6iKsLnxR8FbQw4biK5Gd02g46PUcm7CNJhU31WGJpRnhkSFsmfo/41Z6AdXCm3ygOG91spjdHOvHvAv4Kefn3PUnNiiMYnfqG8u2TbwBAF/Z8dZH1UvU3rezoSfX6dZWMl+MAtx5UBoCoaKmuFZOhuvLH3La11UeegKDxOPkh1IEHFKh40qCJ+i+Z0ALCXpF4OADiiCDqyl0RhiFgHzc9GePt3x1nkqz1zEGP/03fF12ttWhx0nFz3axQbUQtVZy0QQnBeMDLE8bm3y8xiwB9Z6Ft9LP9VhW3FvShODyQ+Jlw5CPceIM+ruX1rbEc2aqGBz+jBRZ6kTZbolu27IFI5x5p1o1hWgrpp3U48oWutK+2RkLmp+oChEwbZJe/g5cYpGseufaVgnIXry57QuqLOiJcLc2EVd2c0RZp3SdUQ2xSDLMz/erYY9amLZbZqmCops7gXpQ4Aj0g7xzO+gZadqA3iXnGMQ9BihbxQ/3o+Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd7a4f4-0baa-4b01-1707-08dcf7f7c657
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:57:53.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3lX52RHiJREI/CZ1S0ZaqxVRcSQmyrVSQHbx1eyZXaNs3wy2McZDuxPVAgTfmnAroonDXxHFo8B61bT2tWPHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290069
X-Proofpoint-GUID: WaRG4CCmcw7B3FXrurqQ_qIVONygEmXX
X-Proofpoint-ORIG-GUID: WaRG4CCmcw7B3FXrurqQ_qIVONygEmXX

On 27/10/2024 18:17, Ritesh Harjani (IBM) wrote:
> iomap can return -ENOTBLK if pagecache invalidation fails.
> Let's make sure if -ENOTBLK is ever returned for atomic
> writes than we fail the write request (-EIO) instead of
> fallback to buffered-io.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

I am not sure if you plan on dropping this patch...

> ---
>   fs/ext4/file.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 8116bd78910b..22d31b4fdff3 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -576,8 +576,18 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		iomap_ops = &ext4_iomap_overwrite_ops;
>   	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>   			   dio_flags, NULL, 0);
> -	if (ret == -ENOTBLK)
> +	if (ret == -ENOTBLK) {
>   		ret = 0;
> +		/*
> +		 * iomap can return -ENOTBLK if pagecache invalidation fails.
> +		 * Let's make sure if -ENOTBLK is ever returned for atomic
> +		 * writes than we fail the write request instead of fallback
> +		 * to buffered-io.
> +		 */
> +		if (iocb->ki_flags & IOCB_ATOMIC)
> +			ret = -EIO;
> +	}
> +
>   	if (extend) {
>   		/*
>   		 * We always perform extending DIO write synchronously so by
> --
> 2.46.0
> 


