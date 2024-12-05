Return-Path: <linux-fsdevel+bounces-36525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20BE9E52FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67635286E3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 10:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28131D8A10;
	Thu,  5 Dec 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cqOYXDur";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tB92NO8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB862391A1;
	Thu,  5 Dec 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395989; cv=fail; b=DoeVX0hEHtzLvxfMadobK/CiUb+HR+hThYTAWQ03dQ9cn7uZNDtg9gjylqJ2mQ+TF8OHuULYCxDGVuzOF9a355xukiCPnYOFUrQ8FZNGlNzsFSEmX3B+4P9zvfCV9PGl+urS2hemH2Q1QuedWS7pdyvnjlE+JJMavYhZydKYRRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395989; c=relaxed/simple;
	bh=dLtRNveSMZtht0mgM7jSf16EOo3KfR73EJk2GgXnQbg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sU19uf58ZMPp4yW5Sbco4Md6c0AE/qOPsZzrWbx31aTRxzMhkVE2K2youtk+Kw0ttnc7y2k++7wfnbWSqGKiRs2JmOHYVbc+gnoUVDCMzw5ONTBjYZvzsDUkHFN62fKU6UlHzKdwlnLmdShGMdsIKUPmO2bjG0S15WbEIAslGVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cqOYXDur; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tB92NO8H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57NFAg001481;
	Thu, 5 Dec 2024 10:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=crxYiJwsLIDP8OObe50BwFZede+9VvstqKi2Zrm+xMY=; b=
	cqOYXDurYHTVNwXxNg2eOQJExIwHdebSxXvQqUgJRxpV1NHAwTIHt8PlgSDhh+/x
	qnE0X2/4fSiirQTDZ2Ty/DqR9lrp6EGNDBB2EHzBDhebd0wrcNV4BoKtxlfrCIFc
	RMLaDoAv7zeCpKe63oFcaBfeFCnXhyOeAFTMkeCCF5ye+blJoy52LTqQT89L8A3z
	Rhm0ZQeFlHxaUriw/ghpiIzQpiYG7M1DIsMcvBaHCHcHe/yIWU1lB4E0+Ag6QfZ8
	840RcfX51Utl5JLgNdMMqch4iFbFoiPLKlckmmDk8gXXnjMrcvZGK8BHrw0ejrMb
	VKeZ19g6V9f4+t87yUrVjw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tasaj9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 10:52:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5AEKw0040161;
	Thu, 5 Dec 2024 10:52:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836wn91g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 10:52:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThkEqSRGDKPVRxW9obLfcj3fkSnxBggqkAyZ0r00cS/CnquVkG+jrSbIgJ5X72P63WZN21A7wghKHlcfmxwAmtilZCxd7Ypylg6AfMzrBddPqSgF9jh9ukHJ6qiCrm7P9NY8FwuZwH9mf3T097/fxRS8MC8nZ22GpBe5yTtPXQIr17yToHvyguW+H6AdtF68S6tGvz9f0+6s9mxsHxhBB0SETdnq7Kx8f5Qsmu/nFk/oH8jyI2i8heO5CU3g08a2UP/IGthZYsbDIM023gHYX8mbeIP2JrxqBM0FOm+SnssrdcoIe4AhKFaXHClx+obi5VwQJhuUyyeVRAbweJ00HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crxYiJwsLIDP8OObe50BwFZede+9VvstqKi2Zrm+xMY=;
 b=U77tnk/HQz3IA245F2s1jExBf7DObPUTVc0HFxvGVuH7ixoCXXJab3MJaROAf9kAis5Uu8bZO/IZG2sY8sph8DZ1fDLZAgu1fUs3VdaAh1dKOVa/TvmfHU8Vubi1RHBYHOyUUrmujLqMfAAmLwWgw/CFJR4V2xLUzdF6EVaoljlUwQnfYMJDJCgKayyQDdLTVt9Qt+/07oS2HSXu5ZwvySVzjMI72arfpfwQvcckKaUdLNW0zz8ddhthKWzR3Hbm2qBwEfu/ImmybC4lTipgBb1OzrbPUQTQCIBSf9ZU3UPmIGQ0FiGwSN7J5f/zC4gSrkof4IEcBMoSmIYmOJfrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crxYiJwsLIDP8OObe50BwFZede+9VvstqKi2Zrm+xMY=;
 b=tB92NO8HFFFMrdAiBDk0+Br1yQbw0vFQLjDdHyaP5VVm9cXkvgfRvay6G/5dTCQOGX4OFixeF3D4faG4zOyXmmnHa3SHO5G2/F4/HJbdJ0iOSrWvNjyC/oXtsiZVFuLM20efx3ccnXuPKxXBU/5Lu4m2RH42fGRQn28ccIzytsA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 10:52:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:52:54 +0000
Message-ID: <3ab6000e-030d-435a-88c3-9026171ae9f1@oracle.com>
Date: Thu, 5 Dec 2024 10:52:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: Lift blocksize restriction on atomic writes
To: Dave Chinner <david@fromorbit.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241204154344.3034362-1-john.g.garry@oracle.com>
 <20241204154344.3034362-2-john.g.garry@oracle.com>
 <Z1C9IfLgB_jDCF18@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z1C9IfLgB_jDCF18@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0043.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4823a2-0058-44c4-bc58-08dd151af883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnBwUXExQWtlTHQ5Y2crRXBHUjNTaFpad09wTmJsSDg4OVJ5Ny80dG9xTE1v?=
 =?utf-8?B?MWZEdkZLTy91L21oME1rOERDVlR6Qnl1ekhYOGVxTnNkQ1NnM0U3cjc5RjdS?=
 =?utf-8?B?YzJ0djhhM0VxK015UTZjVUI1d3NPRTZ4THRMcG94aWljT0pIVTBjNzJEd0ZZ?=
 =?utf-8?B?WXBMN0JTcUltMFM4NGhPSERHMXpOaHo2aityb0ZMNWpXU29tcS8rMlZUSC9u?=
 =?utf-8?B?bTdpWllCcS9XZVgxeWJhR1RTRlJWS0l3ZTRiTFIzVXY3Z05qUjUrUU00L2U4?=
 =?utf-8?B?N0wyNG9BZ0JOWmg4MUQ0dUcra1plT25LdEdoaWJFY2hhekFoZUtSdWpqSkxP?=
 =?utf-8?B?dDliTkRKUDVXaWZYL2Q3NFArdWhvYlRweEU4MVplNThwYUpXTVgvOWxMaC9o?=
 =?utf-8?B?VE5qcDhNMjh0K05Ha2gxZ0EzMEdQL1dRdFRDYmlwbmpQRUY0bEt3b3dqR0Mx?=
 =?utf-8?B?eTNWZG1QVHJOWWNPdHJUVS9Hd0dweUlod2xpeWRRQnlLKzA2WFJ5TThrdTds?=
 =?utf-8?B?YjVNaXd0OFUvN0ZVM1M0d2paUHBBWHhrTW1pRStRWHkvK0VuUkRrdWZ3Qlps?=
 =?utf-8?B?OXJySExvTWxQb3FGTWJYVGZybzFBQ1dFZUdyN3F4NGtldTRCNHdRb3dvTXJ6?=
 =?utf-8?B?VWI3SHpQUGxiL3A1ZDBMYkh3eFpmZzZVT2I5dFRUTUhMTm5Ga09EcmhUcG9x?=
 =?utf-8?B?M0RITEhJeGUyNG9QLytEQXp0VzFqY1IvRnpRTVFxZWxGbHoydTFlbjFmd3Jx?=
 =?utf-8?B?WDlMSVZkakIwTkVocDNxOUN1MTdrc0FjVXo3aGwrM25EeU5sd2NWWjRFekNh?=
 =?utf-8?B?ODF1VzZmZkUrbk51dTVJWW05RHFNWGt6cTVkY1VYUHRiU242RVNJTVVheits?=
 =?utf-8?B?NzRaTjlYVHNqUkkzcUxEd1ZwYjV4aHVsQi9OZmJvVjRnM1M2WEFZS0o4MG5n?=
 =?utf-8?B?eW5FMlVLekZTdERUWTBpdEpzN0xCK2M1Y1VPR0pQSFA2S0JGeFpNMDhiNUhG?=
 =?utf-8?B?eVVyVEovRzhKYVM2SWdjOEpVTkJHNFlUdW8wK0J2YXVrRDBzTndUVDIxYklD?=
 =?utf-8?B?MndGVWJHSzkxMkw5Z0JzRjNJTzNDVEJ5M1N2Z0F1VU0rRTU5TVllc2h0cHBZ?=
 =?utf-8?B?SmwrKzRzL2JXNm5LLzlUZmdPTURaekpXWlVHV1FYUGZ4Y1R1aFJWUDZmYzZX?=
 =?utf-8?B?U0JkOVRObHBtT0RDR1BPeVV2R0JUT2xOUis5UllhU3NJcVJFUTZEY01jakhI?=
 =?utf-8?B?THRMN2tFVCtpREZmRTlRVC8vOVJ0YktudGcxRW44LzRnY3dxNGFVSXdmWVFX?=
 =?utf-8?B?UG5mVDVSNE5LbTVqQTZid29relBsb3BWVjVFVW1wcUpaNnZ6dTFFZWgyRTNI?=
 =?utf-8?B?blc4bThuZEcrMEFGVmhOQkc3REprVExFRGg4T2tTMXVOemNGSnRVaFRUeExn?=
 =?utf-8?B?UW85cGIyRXZ4MG5MOTlZeGN5RzBadVRnRnR5bCtRZnB5WVZkeXorWjlsN3ht?=
 =?utf-8?B?eVBqTzVKV1M1L0haT3RSNjlNdnR4dXlGeU1ZV1JwekRTVVpsKy9oNVorL1ht?=
 =?utf-8?B?OEpJYWlvcUsrUkkyUDdrb1BMUWVTbDMwbkpoQ052TGZ4bnFpc1pOaE16VXVl?=
 =?utf-8?B?LzlsMGxJYnF0aFl3V0tBWmpNczZoOC9rNC9EQ1lYMGFLMUJTcEtPcmhLVDVy?=
 =?utf-8?B?RmZyc0syWkJkdUloRUwyMFlkblAveTNnZzVnWXBNenlTaERSbXU0ckpsdWVz?=
 =?utf-8?B?cHdZUmRpb3lrcnk1WVkvYkdibnpPSm9zRmJGeTFVR1B6ck92LzFNV2YzZDJu?=
 =?utf-8?B?WHhVSlloemtlSjBqYzliQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHA2TUcva0hqS1duLzNMZjVndTFmRFBxbzRONlNqZkhxNzFLeHlqTllNdWhP?=
 =?utf-8?B?RVFRMm50VUp1WG84R1EwcGpSYTk5VUd4TnFmNXQ1bEFKajJQaGpKMkg1MnN3?=
 =?utf-8?B?eDc4Zm54bkk1VTJIMzRUTjJBU3BDTjVpSUhRS3F2N3NwN0UyZG9uZVF0MnpI?=
 =?utf-8?B?TXVRSjE4bzhyK0N0RER2UTIyd1dISnlQZmlITmtmMUlTS0VxMzhkcDNqRzFH?=
 =?utf-8?B?SVlYaURHQ2F1QXpqckREcUhTR2g0R2pPZkRVWGNCamxDNlVzZW9MNlB4eXAw?=
 =?utf-8?B?K1pJbml1WGlpNEYzblgrVlhlUk85TUJTaFpFUzlwVk9SczFVb3o1aEdqL2hE?=
 =?utf-8?B?YUo1dk5WMjBpQWhaY2JiMVlKTGt0dUYyUnl1SUtSZmZpVTM2cFROcTR3SFJm?=
 =?utf-8?B?aThOT3VCckEycG9SK093RzFQSnBnODRuL2pQRmREMXNxRnhNZFRUY0h4SmJm?=
 =?utf-8?B?bWlOZzg3aFhwLytsa1F0cGF2YTE3OTdYZ3dub2VENzVoL3BweDhJNUFnUFdG?=
 =?utf-8?B?R2NxdWp4c1RKbzNsNUpPbURDY0JxdmNpSEtVc1VBd2RUK2EwZkJQbzhWMWp5?=
 =?utf-8?B?OWQyeEZZZ0FQdzkrVjJQaGlTbkhoWXhZRHNaaDV6K0Q2blNLZE5qQkxjcHFx?=
 =?utf-8?B?dUYyUlpFMDVlYnNHcHFJd2VBeW45ZnJ5aWg3WU9RR215RnFtVldPdldOcTBY?=
 =?utf-8?B?ZFQrSFBRc045RkNxZkE5SDJ0a0JFRVA1VFRaTEk0V2VHVjgrOGhlU25mZzlv?=
 =?utf-8?B?NS9WZDV2K05tTUFKWUpQSlhQdWtsN1Azb01kOU5wZlViY2orWm9Ma0ZEamJq?=
 =?utf-8?B?WS93dHEyNkljc0xkZW52a2YrbGVLaUhmaWVkUm5TK1BQenY2Q2VSclUzd205?=
 =?utf-8?B?YWZNSVVvVUFteUpnQ0R6SGx6RWFGbnM0NjdrUVl0VnhYYVNrWUF3UXh6UWti?=
 =?utf-8?B?OWlVbXpLTzd4ZWU2SlE0YVQ3ck5IVTlLbzZCbHpaNC92ZTBhT0V4c0NhOTRT?=
 =?utf-8?B?bWtJdENmUVY3azMzVEdrcU44b2J0R3dJbXEvZ0JjdmFPTlVMYXB6dEVjT3Bk?=
 =?utf-8?B?YVVZR0tyK1ArNU9KVHNISzA1MTI1YVE4M3BEeGZSS0haZ3ZIN21Dei9kY2dO?=
 =?utf-8?B?cXhESEVzTHdubzJpOTlFaEl0NlozYkN1Yk9SaEU1OEtrUU5YQlBhZ1NhMVZr?=
 =?utf-8?B?elRsWmRKMXgydXR5YUU5cm5KRWRpemdTU1RSZjVLT3kxOTRyV3U1TlJ3cHNK?=
 =?utf-8?B?eWVoTWJMS25lNWZkOEFUVU1yeEFnRWhCMzlFWG9Ba0xXWm9TSUlldW5LU3ZK?=
 =?utf-8?B?M2xzc1c4clgzbytKWTkyV3ZIeG9yMEhRYXY1Zkd3WHJtaER0UWFqMUNOelV2?=
 =?utf-8?B?cE04Um81QWd6MlBOZEN2RE9ORVVFMnZSYTVLbE94Szl6Y01iakMwdG15bGJt?=
 =?utf-8?B?Sm8zRHg3NVE5a0VyWjA4SEtJOCs3R2FLMVZyc1hEejFIZ2Q3Y0NLeDZnWXY0?=
 =?utf-8?B?cGxQdU91M21qZE55ZU9USCtxVWlyTEZrV20yb0I5aFRLNGJPMWJzNzZoNUk4?=
 =?utf-8?B?emVzNkJmZzkrTGxNMGhTMzhkbGROQWYzQmxIODZpYW5QSnczVU1rYjB1NEN0?=
 =?utf-8?B?d3p3M0I3UTBkaXRFMmVrWXhnV0NTRFdqcFRYS0ZKS3pUZzltL0h5OE1pUUJR?=
 =?utf-8?B?bkhrb3RZbnByT3VSWFYvOStTUVZKV2F0N2s4bU9tK2dFMGdrL2Rjd0pDU0hi?=
 =?utf-8?B?eEpKYldoK0hmNzVXQ0txbTl4N0xmem1NK3p5UXJ4YkVIK3hDZ1VUeDFqaWxv?=
 =?utf-8?B?cWZTUVpuSXIyWFFBU29VcmJUZmNaY2FZd3pGeTc5amxQNlZsYTZUNmM3bkRv?=
 =?utf-8?B?Vk5zS29zWUkraktjdTlVcTJVRGdSalZHa3ViTjRvbzJGRmtuRzVXVEEwbTRY?=
 =?utf-8?B?L2FmZlo5dVJhOC91MlhHM21ZSU9od1lTNVRxb2ZBZlFNYUozR2ZnYytSNDda?=
 =?utf-8?B?T2NJTzhYem1Va1F4QkpRRElORENwZGRNeDE4U1FnSWZGT1JXVzVOVUdpT3Zm?=
 =?utf-8?B?bGVnWkR0ZTRKTUxteTJ4Wk1ZSEpKS3Y2NmFGMjVxMFZwa2dPTnRXTCttcUlk?=
 =?utf-8?B?ejlURTQvVzE4STFxbWlWWFREUW9xcHdLbmdsZU5MWmpHRCtGdC9uVVRGYjRK?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HQ+TbEUlGr1C5+esB8Em251c0gPS26c8lfnH/rJaFo7iMLTmjGKhtz2ngWcsrfX6nXaR0xyzX/rdZOIwuaJSwmZS98bAvZ0PhlfeyZtEGJ2raEB66xN3FEJqRkDqDP75Fhic2oIRcALFSjqHnrFOAUgF8dIm/RX5dGoR3RqrGOQy/RMcGpMhn25GjFVCPAxpPkr2+JvaVBMCutkX2i4u5YcVoDRxiH0lTDMEr0F3VKEDZKbN98lhBTl5qDNDLvLXXHdQLI+whRzi3h/l3m4iPDojNrQVaNRksCdxfZuwvvHoOj5ZONiBrbs6WL5pkmCw03wtNlnESaxgcsEr7Wq5LlSQYgV8RbtmQi9sBuR+J3MapHVfbCizxSA7dBg6SQ90K0aXlEsdYt/kzd5pnwgOMuKhydz2TAoL/CTgTOQq+5+YFoxhrouXbP03iMCmNC/Bxg1Onsw2fGmjKyxCEgYH8fDm4jI/k4TrCxmhURsmcYxJvH4QJa50RWkMINT05luIzdD8PYVm7ebaaIxJzkhTN30VijjbC4zJ/1J54D7e06K5Mn7w7XBw7d4Go/jC30yahLMhFsxi53VnPzJKVCvpUKkmXL7XVqzwamcIpWO8RPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4823a2-0058-44c4-bc58-08dd151af883
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:52:54.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqoVH6iM3CuM0CvbtMtspJHMPR4AXc6+3rFl/cUu6ODrTS+4Z45v92J/Tq43txI//yaLYW9k8yonhTzCfoGSyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_08,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412050077
X-Proofpoint-GUID: KpZJi5yQreu6x-u7WlajNbbKgxP06m6y
X-Proofpoint-ORIG-GUID: KpZJi5yQreu6x-u7WlajNbbKgxP06m6y

On 04/12/2024 20:35, Dave Chinner wrote:
> On Wed, Dec 04, 2024 at 03:43:41PM +0000, John Garry wrote:
>> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
>>
>> Filesystems like ext4 can submit writes in multiples of blocksizes.
>> But we still can't allow the writes to be split into multiple BIOs. Hence
>> let's check if the iomap_length() is same as iter->len or not.
>>
>> It is the responsibility of userspace to ensure that a write does not span
>> mixed unwritten and mapped extents (which would lead to multiple BIOs).
> 
> How is "userspace" supposed to do this?

If an atomic write spans mixed unwritten and mapped extents, then it 
should manually zero the unwritten extents beforehand.

> 
> No existing utility in userspace is aware of atomic write limits or
> rtextsize configs, so how does "userspace" ensure everything is
> laid out in a manner compatible with atomic writes?
> 
> e.g. restoring a backup (or other disaster recovery procedures) is
> going to have to lay the files out correctly for atomic writes.
> backup tools often sparsify the data set and so what gets restored
> will not have the same layout as the original data set...

I am happy to support whatever is needed to make atomic writes work over
mixed extents if that is really an expected use case and it is a pain 
for an application writer/admin to deal with this (by manually zeroing 
extents).

JFYI, I did originally support the extent pre-zeroing for this. That was 
to support a real-life scenario which we saw where we were attempting 
atomic writes over mixed extents. The mixed extents were coming from 
userspace punching holes and then attempting an atomic write over that 
space. However that was using an early experimental and buggy 
forcealign; it was buggy as it did not handle punching holes properly - 
it punched out single blocks and not only full alloc units.

> 
> Where's the documentation that outlines all the restrictions on
> userspace behaviour to prevent this sort of problem being triggered?

I would provide a man page update.

> Common operations such as truncate, hole punch,

So how would punch hole be a problem? The atomic write unit max is 
limited by the alloc unit, and we can only punch out full alloc units.

> buffered writes,
> reflinks, etc will trip over this, so application developers, users
> and admins really need to know what they should be doing to avoid
> stepping on this landmine...

If this is not a real-life scenario which we expect to see, then I don't 
see why we would add the complexity to the kernel for this.

My motivation for atomic writes support is to support atomically writing 
large database internal page size. If the database only writes at a 
fixed internal page size, then we should not see mixed mappings.

But you see potential problems elsewhere ..

> 
> Further to that, what is the correction process for users to get rid
> of this error? They'll need some help from an atomic write
> constraint aware utility that can resilver the file such that these
> failures do not occur again. Can xfs_fsr do this? Or maybe the new
> exchangr-range code? Or does none of this infrastructure yet exist?

Nothing exists yet.

> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> jpg: tweak commit message
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/iomap/direct-io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>> index b521eb15759e..3dd883dd77d2 100644
>> --- a/fs/iomap/direct-io.c
>> +++ b/fs/iomap/direct-io.c
>> @@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	size_t copied = 0;
>>   	size_t orig_count;
>>   
>> -	if (atomic && length != fs_block_size)
>> +	if (atomic && length != iter->len)
>>   		return -EINVAL;
> 
> Given this is now rejecting IOs that are otherwise well formed from
> userspace, this situation needs to have a different errno now. The
> userspace application has not provided an invalid set of
> IO parameters for this IO - the IO has been rejected because
> the previously set up persistent file layout was screwed up by
> something in the past.
> 
> i.e. This is not an application IO submission error anymore, hence
> EINVAL is the wrong error to be returning to userspace here.
> 

Understood, but let's come back to this (if needed..).

Thanks,
John


