Return-Path: <linux-fsdevel+bounces-41186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D52A2C1F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 12:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C37164507
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAD11DF721;
	Fri,  7 Feb 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J9M4AYSi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mVeXasOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C321DED66;
	Fri,  7 Feb 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929247; cv=fail; b=IRTz1VacfMuIRSNdL2qwTxdNnBy+Yzj1wy4JcAKFnD7EhLE85CwDSAt+wLa9+sgF9zLe4lY8xqDPxPEBGrbMF+X88mrYzdHWsnZhXB16FMqmfoyQd90U3xGhw3YDA4KxBD6RQaOGPWQdKKUs0vJoluCbfhNbNMLOTjJLPYJTaQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929247; c=relaxed/simple;
	bh=aokIgeu+jfqabWzlbLbStOS5xelsmaP2pkNiIfG4rC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=amSkQsM+BsyDuoUfVUPTCt9xswHi58dUP3Ge0299FisSC1Qdf83Lq7S5fhqaH7QzMmQdXDgjN0XKUCZg7ZZ8BmV/6Qr1Hxjva+rBs4ztfuAaW3JoWjjfQ6YEsSp0XCmK8/oMPIKAtumBr0STiKm9WCCSHfLpCZwZ3jhhsp/96xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J9M4AYSi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mVeXasOA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5171tsVE017539;
	Fri, 7 Feb 2025 11:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aokIgeu+jfqabWzlbLbStOS5xelsmaP2pkNiIfG4rC0=; b=
	J9M4AYSiSJcfOhUOsp2Uiq1iBZofI6zos28qv0eMKT8jyT3QqcU5W7IFsDbFSLSa
	KMZ/2eDjuAOA6RVYWAnZqJWYFuZ3AFYOD6UIvVbquIB2ZUlq2AuEX8VSGa4HL4hF
	ptw2A8r7ac8aR9N0kCNf02xMLSy0R8yE3hN7M5JMIjYqg92FS6pZmCAKU2oTDwN5
	BsHUWtgCiSyiFet95L778o+PxCWSNckD49IS3aM3uLgbFQwtURqJR1eQx7kSxyLk
	TWFAmppIbJ/A8SdpZohs8sFB/+KWj74Uw+c3oNhW0yvUPzzuAZ4AltXBfZF6tMO8
	C1rdEdcZySRhNzSRkUF0HA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtka0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 11:53:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517AKuvd023577;
	Fri, 7 Feb 2025 11:53:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gn1ddm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 11:53:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQUSp8PU8XMEs2odYQBKPNWgo56aH95ZAxrUq+8sd538nW+BVk0gOBXiqaiMLXjmA53ikJNKpsfC28MJD1yiOT8hFtfVsAfx+DuWHYLWJMeBQsaet1X06NKn4e/N9baT3I2OZcKhQXZ400YzqNaV7eAF4dj8AdunbEHx686qEE5TMXSB2f3YOnXumGwQyiv4TCl8SFC2BhUw7LJ+23ypExKKsN5D+W8L7ySi/nNgPB2dnFaK4fgvmm+5rFBZkbfszVT2QdsaSwOsOzRaI84oRqyyD4/NmPb2Q+ZVsoatFgZACMrbEol8AizS7zhK0JiPvX1E2fEfkNE7gLEkLPBQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aokIgeu+jfqabWzlbLbStOS5xelsmaP2pkNiIfG4rC0=;
 b=T60fSzV4vgLwMscqnzn2XkkKGhItI89OGUHaFdtBXm1cx6MmPTYkAabQnY7W2JR4+RmD2xFvMKLa4tffrmp1GwiuxhQOIbT9l93BpHzJCj7oRQQD2PH6wn9OaJMgwd+gvWO24VP9d7plXtI8AEjV62AcsYxaFNaS2FGle+Ip3Woe626sZxyKGSfnUZt+6geFm5IqUPscmEcYkxHz/l1/5Cen3IcXthjHDxnvHaoa9oP4TLWJoX6XRDlB72ICiFfmvGMvI0pTRlU1JsrEIw5vr5F2izLt7j2Xs1rMCp5ctvI9RTmYahoLZzU5Ti4fq3MmaqrOHPce7w5TKMi4FFuszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aokIgeu+jfqabWzlbLbStOS5xelsmaP2pkNiIfG4rC0=;
 b=mVeXasOAVrYSpr1RA5wKR6gawcGDJ0SPXlWJTqrtjorHpwoDcPTgwUAZZa5xjCsivpXtuG02FsoUdBhxKWecwp9FFjGJcA+Mxg9MqpG8GUaFR9pZPX2d4HmB/uGi2nvmFZ1l0nP6+Y07MCCWEPfW+1X/HdQIkFvPZMKDcyDp3i4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 11:53:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 11:53:53 +0000
Message-ID: <133de98f-4d62-4885-a3b3-fe57ab7455a4@oracle.com>
Date: Fri, 7 Feb 2025 11:53:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/10] xfs: Update atomic write max size
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-10-john.g.garry@oracle.com>
 <20250205194115.GV21808@frogsfrogsfrogs>
 <b2fb57fc-7a3d-496b-8f1e-110814440e5b@oracle.com>
 <20250206215403.GY21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250206215403.GY21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d3fabc-21e7-4e0b-7326-08dd476e1826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGxwTzhrSXBJZjVqY09oVWtnb1RWeCtSaHFLNXJYUjlxYm51RmNkMVZVUXZo?=
 =?utf-8?B?QnZRdys1Q1RYQk9HMUZqYUdDOVRES1R5SXpCSWlpcWp4dG5EbXRTZW92TVBy?=
 =?utf-8?B?STZEUGNGLzZHSy9Ra0lRK2FSOUx4NFBmS0cxMGMwbG1pVG9NdjNUQ3lPbWJ6?=
 =?utf-8?B?NVgzWldoVlNhS1NMdlplUDFEaUpBMzZPZXN5NjJPYng4amROWXJwZ1d2SEds?=
 =?utf-8?B?bDVSVWVTSyt3a1d5MHJkaVNqZ2lkaFI4Y2l5V1M1aDU1YnV5NnVKK0FsZTc4?=
 =?utf-8?B?UXoyNEgrVWxESlRBQkRNcFovWWZEN1RVSlF1TThsQlk5SVh4RjVHUGZRRDFq?=
 =?utf-8?B?SVI5OHdWUHdQNHdEYmtqMXJCY085ZGpZQ04vZjdXa0hRTG8vOC8vbk1lK296?=
 =?utf-8?B?a0NNVHhHZHpyYlNoQWFoY3paWDdIajN1MmlnTUxkQy9DTDdQRlZLR2k4KzR0?=
 =?utf-8?B?VENCUHNlVVBNdG1mdEYwRXkrR05wM3A2Uk83Qjd5VU11SWRPNC9XbUV4VVdP?=
 =?utf-8?B?Sy9nR01CVk91b1ZZYmgrU25uaUZpNjUyRmRSVXhySlhZcUxKZVVyM1ZQRkpO?=
 =?utf-8?B?Y0pRWTR5UGFjNkdiWmVoOGM1dk9kNUU5ZEEyS0ZaNnllZ24vbS83elpBVGVw?=
 =?utf-8?B?eGRrTzZwT3prZkdKUFMvYlBNMFkrWndqMWVGdmFlVzdwTzJ5czNKZ29MUlpJ?=
 =?utf-8?B?OEdHV3h5a0k1TVIzV0JYeFJ6YVRtTWZoWURaekxsT3hqUlBGTDd2ejl2ZERE?=
 =?utf-8?B?SkNjOE1nUS9PemRPNXRRbVV3ZStvNVp2R0NLK2xCb0tkYUlaeC9vV3pTdmlK?=
 =?utf-8?B?MkdZSjRqMStEanVHS0JFWXhRdDh6OFB2ZHFSQ3ljL0FIdnp1dCs4RE1ZT05S?=
 =?utf-8?B?WnhjTDZySnZlUjF3M3J5dmk2c25ieU5GL2tJdlgzMmswLysrSFBxNkFiMEVS?=
 =?utf-8?B?eHRSSXl3Q3ZPR0laMTg0U205RVdhemdONEtiL2xySHpBY2pXTW1zVnpMSXRl?=
 =?utf-8?B?RXpoeU1QemZxRGxXOU1OMUt5dmdBSloxM1NuQThzVmFhMmFMUDlTWEUvV0dQ?=
 =?utf-8?B?WlZJZUlyMWJhOFVOZ0V6Z3IvM2ZOQXdPdEwxdkNpSHliK2wrckdoc3dybjZu?=
 =?utf-8?B?dHRKRStDamhmK0JheFpudWJBM3gvSi9QM3BhOW1QUlJHYUdFd2d4RXhkK3l1?=
 =?utf-8?B?cUZ6d092YXlZa1o2VEtKNFA3aVhpcjZCemlQUEE2VWFZK0JsbmJMbHE5eW5l?=
 =?utf-8?B?NFR2VVpQbnRsTXdibnZOTytaSGwzbmZXUnBzbXhnYm53RXNscFdPb0M4Mzlj?=
 =?utf-8?B?Q1JNYmFKdEpGNGlUeDlsOGVpWlRjN25NN3BSamFVVDVFTEUrK1MzVGxPSmQx?=
 =?utf-8?B?Y25WRUlLSnNmTDJ4QSs2S21TMzFCalFmMXZBWmd2MWo3WlpSRzVoZFg2ZVNB?=
 =?utf-8?B?K1czOFFUa2dIQ0I4SEtpYWFubjYwVlJhZkoySHhHVFhTbWJDeWd5WE9wZk96?=
 =?utf-8?B?Q1AwaDNXTnByWnUxb0RjcjAwV3lNNS9oT3prTjVLRk80VVQySGtVeDZrcHRv?=
 =?utf-8?B?QmpML0pmL3BsOXgrQzdBa2JaSG1kRzJHV2hXbTJGR0Q4Rm9ySm1sZGU4Vmgr?=
 =?utf-8?B?Z2d2UDRLbjZPbzFQZlhEMTVqN0hiT3U1VXBhM0hhRXlSa2VhYWlVMXNFdEZu?=
 =?utf-8?B?YzF5Mi93RUo5T00yUVI3aHd5OXFXaTVrZ25WZ1RpRThzK29Bajh6ZVRGSkVH?=
 =?utf-8?B?U2c3WTNwNGZsbnBzMld2dkd1aFh5UHBNVFN2bExmcFU2S3pYQWlXaThocnI1?=
 =?utf-8?B?blhTWE94YnY5Q0pUZ0J0eHVzcTUwSFBvZWlFL3Mxc1dtOVd2SVczK1gzUlQz?=
 =?utf-8?Q?Q9KI29KtGCI1E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djl5RTliTmg4bUFFS1JCdHFRNmJFTzNOaVFRTy9BejBZUTMwa2E1MHpaQTlk?=
 =?utf-8?B?Q0FGb25rK2Z1VHpPUWRBOCtZa0gxRk9tOTM0N3BneHB2UTdwcUZzSVVPNCtV?=
 =?utf-8?B?T1VpeHFiajNSU09Wb0Z3czJGZUNjL1NDYkFZYVowR0Z1QVJFM1NyNVJlVGhS?=
 =?utf-8?B?dU9oV0hkdTlOWlk3V2NJbGYxVm1OOE9RNXdqVTl2VHppY2prVUhoYWVRYllL?=
 =?utf-8?B?aVM3dVVmdHV4NkowTW5rcVFxbnljNnNubjMrc08rc3M0b3I3dzNackUyeTNM?=
 =?utf-8?B?UHI2ZTNxVkl2Tk1sSGRkUUdYNU1oUXNxR3hlUGI2MGVCNWRrNW4xYlJ0RVZj?=
 =?utf-8?B?V3ZzMGo1T2RRTUdqT1ZFYS9LYVpwajJJMjl6dllwR3pQck5ueVhVTHZsNktS?=
 =?utf-8?B?eGVWbHFRMndTeUxzWE5nUE9TTkRDTTdyM0dDYU5MN0hPRVZPb1FqeE5yL1hl?=
 =?utf-8?B?RHBiejZLN1lUV1NhcnJmSEt6bGV5ZVFSWVdPZC9aSk9kM2piSE9FOVNQdDhX?=
 =?utf-8?B?b0pMK3I2Kzh5aUdQZkxqL0UzTmViSVVKdnRsMnVibjNVRGxJbFRITXFGakNl?=
 =?utf-8?B?UGVkbGxTbk15OEJzOTRCQ0M4MVlaMVdvOEo4Tk5sZHBweHNGZVNYK0o3eno4?=
 =?utf-8?B?aFZ5SjVqaGVGRllkQUpGNFk2UWhHOVFrWU5acnpNUUR6L2IrU1NNRTF1Qk1B?=
 =?utf-8?B?YXEvYkJtQkdkMUlDVTJLd0t4ejBYaDg1dlEwcHhpckp5TmJsa3ZaY3h0bktB?=
 =?utf-8?B?dFo5U0pzZnFtbGxSQm1KYkpYQmxRbHlxenlkcEQvQkx4aFZRV0NtdHN6ZW9m?=
 =?utf-8?B?VmEyS3djaDNFQXJsWTlhYmk0cVVzbUFVdnBnN3NSZmR1WDJtMEhFbFZBWktT?=
 =?utf-8?B?eWovV1hIRVJMdk9JeDYyWVFpaWxXNlFZMkpic1BTTnhSZDZKZk1vOU9VMUsw?=
 =?utf-8?B?UlVydzIrc0o4S2p0STVkSHFtb2sxZSs4SXZUOXBPenBrcWt3dlhGR0p6SFp5?=
 =?utf-8?B?NVVqUXkrZUcveGxRT0JiQ3pZL250LzRCbFVjYllNMzNENGlOdXRYT1JFTlBH?=
 =?utf-8?B?MlhFSys5RGZQOXRON2dDZEkrcVQrRXdXWnBaZEJsRmo0Y20yc1ZwZjN5RlFR?=
 =?utf-8?B?UTdJNmZXMGxpVmtRaEdUa0dxb2RxVExMRzEzaWphTUl0S2hBREJ1Z3pmYXN6?=
 =?utf-8?B?emI1aFBuSURrRVNmdVJObkp1VHFpTXVtNC9FRzgzZXU2SkdvVSt4bG51QWs0?=
 =?utf-8?B?UVBpNTVaZFlPWWpEQlpNOE5PR01kc3AvNFlhNUJ6VTBueHhXTjZBazdzTUNz?=
 =?utf-8?B?TmhPd0w4V2RpRnlhdTFMNjBtREZVY25QaWwzRSs2ZXkrUVJCNU5yWXBSYmZH?=
 =?utf-8?B?QlVRZ2tSYjNVMWRxajVSSnl6ZW5IalJ5UWdQUllodHZ6SmpBWHZzS1RCZ25D?=
 =?utf-8?B?Q0lTb3AvUHRYRnpQaGM0YnZUYzJ2WkhYdlRETC9GTnIyTlhFdFo1eXc0UjdQ?=
 =?utf-8?B?TEVJQkhEb09YSHBKMGVJY2J3V05zOURMY2Y0ek9OTk53ME9vbGdyTEw2cEFo?=
 =?utf-8?B?Sk5qSUgzRGhmb09iUFR2aDFJcnhlSGRjWVRiR0hOMUlEdkNleVdsWTJNc25O?=
 =?utf-8?B?RWZ1Z1VGaTY3cUQzMmd4eFVBcDhkN01pWTVLNnduSGlWM013TVhaaGEzeVRK?=
 =?utf-8?B?Rm5IbTZVdHBwcms2U1FLcWkwQVBTMjRVM240OGJJc21Ba3ZXOUdUOWJXNnBn?=
 =?utf-8?B?MlM1UzJyTXQ2aW5CV1pWanFCakdvdTFEaFEwZllCc2N0bWV4S1dDUllQOS9z?=
 =?utf-8?B?VlNSTnMvaVVyN3ZnalNJZXZzaGRSb28zTUE2Ym5Id3cxSm52RXhReGVVQkhZ?=
 =?utf-8?B?MWsyR0I4LytVYkZIMUQ4dlNpcmxDL1VZRzV5NFg2Uy9VNU1XTGhhMzhVY2Ry?=
 =?utf-8?B?TjZDVDRhMWlEMEVYTEExLzhac01kTDRMMEM3MHNiSEQzbi84bTIxYUx1OXFB?=
 =?utf-8?B?ZC9oeHdTTnBieVp0M2RrT3Z5Z0tlRm1pZFJSV3dvOHdpVXJwR2pHM1QrdENj?=
 =?utf-8?B?cklMTTlpaUtZWWRVUzh1cXJHZW9ERG5iZExETm1TbTg2SEVZalNXb0MzU2dz?=
 =?utf-8?B?VDBvR25SMTNiVXJCSkVtRU52cWxadmN3NWNFWjNnd01iTE90d0dNQ1JDUWxH?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dqRnQfUYUkQ16WtG/9MdNUBJEakrCrKQXUCeWLEVYT33KsIYpqHrU2tvPKZKuJ6x7WYxV2JQ5R9N9Cxx1xCNGYNEELR/LyR0O91t66guGFoVAtkWkWMpboHwaPsQPyw8d13dHTP4EfMAa6F+744I6ERfbtAsS1puml26Wevbh54rHj6wZibmnw4OPLFlO1Mts9iwQr02Z+WkwvpKNeXARVbVy/HuGECtJuq7HV+r4fqHtVHWqsw5KD13ddvDVkPu2dE81fefhKXNvM//q3OFCZ9fzR5CTo3HyDoma+gSb3V1pxHklXsuhXoOan7uP5MwJ6phcdARYKQCWvuVdxJx0s+L3zSbBUFHZ5Cu8nWE3DzwzJe9NWtFyt/3fRP+XeE99v4GcORK+2zqF2a+Wcxcb8/TVSwOQvLPc7BzgB9fjiZlWEJOU0WENnMQzqBTJTT8LbjFmXElmKcIftggfsT5LrasDCC1XQugVK/BoYojmI4o1bC5Brc/ySYwiaLlJlMDgYiCU75z4n4gsMOMFRDCl+XUL60MDqyPFUPDmA4ZjudM4CZ39MfxCo8+mI4cI5lO5SUMcmMIseKPeQZIZ+nXcizB+9OTee/8BclCwFKQmpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d3fabc-21e7-4e0b-7326-08dd476e1826
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:53:53.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SmG8sM4S4QzULBkx2uyEn7iAbxLvd9xTsc0XfIvKlcAByjTeJV3hYNYPxruPmnqzjs7LJbImPD5XPTCl3M/cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_05,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=988 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070092
X-Proofpoint-GUID: 0TeI_LJROuMxsMh_wvspRzYTzUEVjdmn
X-Proofpoint-ORIG-GUID: 0TeI_LJROuMxsMh_wvspRzYTzUEVjdmn

On 06/02/2025 21:54, Darrick J. Wong wrote:
>>> I think you need two awu_maxes here -- one for the data device, and
>>> another for the realtime device.
>> How about we just don't support rtdev initially for this CoW-based method,
>> i.e. stick at 1x FSB awu max?
> I guess, but that's more unfinished business.

Understood. Let me see how the changes look for RT and then reconsider.

Cheers,
John

