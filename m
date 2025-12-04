Return-Path: <linux-fsdevel+bounces-70696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44104CA4F5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F8B3313ED6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC2335BB4;
	Thu,  4 Dec 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jHRXSeOx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NNkPT5oD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B7F18DB1F;
	Thu,  4 Dec 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869606; cv=fail; b=T98xMAkLxl6AVrj6bCVWSi43KrMCMfQoUI70WThZ0WRoqF06X4JecsRNr0HjjqUbbJf/ClBgCN85LjtwVxsN5Nu9fETcJ+C2cJBFoICSwUQTXL7AR+yk08LcnT3nG08pvyvy0PAGVIxz8iQyzYw6jARmiLmUqWNpXcNo+cd8WHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869606; c=relaxed/simple;
	bh=/IAyIVyw3xNCPVgSlA2F3zsBkbz9tfPqBndoGfb6aWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nC99gpfHSTMBfMY3bQfHAUNj2WD36DZ2Q2HCMS3BJeNZXOG8Ao1n7r+tLd8keYv13qGeKmgSzyM8cNLm5Vl3c35/ewUBcyp62qKC0ZpgkjFUVIZpF7Pv/0ioHwluRDxx67EUAnuTm8x3+dhNacKrJ54gfY9+F+dKkn0QltsF7YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jHRXSeOx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NNkPT5oD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4FEYwI1539974;
	Thu, 4 Dec 2025 17:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OrLRvSw1MOpA6KXej0DtdmTVmfIeeaX4OW/IPZml468=; b=
	jHRXSeOx2u5pM8SdA132JJCQOoSAPzCVItDMw6rMljlBRx0HdwE5aNZHrtTxXrdB
	Vodg/Ub9j7c5DKMo6jFj+xhiJpAYUj+JmlpWdvlNdSTrammRJrdJn2gTxkwu/rQe
	ImPZYJt7dEjWLzs4GIaS7K//rSgcOiSlM5ytcvKiHGSeR3WVJI5cQXchHBeni5Io
	I4lYbxeDVF2gZlEi4/aS6GohIpCqegGDQ48Uv28IyXeCMb+VEm/SMdiZjC7rUHkb
	YT6aF5lt/qxT4CtZWHLqAEkpa9E9MQFPDwrR8PFjs58G4OlNjKXlH9Z1CPHFWoio
	wrxrmpHsRZ7XVdquJAn5aQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7wng69n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Dec 2025 17:33:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4HH9qj040495;
	Thu, 4 Dec 2025 17:33:11 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9fxyn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Dec 2025 17:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gov0uVw/5s3lsO0bjN5/NNk6ElpMS8CJcWhlmACfBLZmxvS4y2EzOmmgoi6qFFHUkY8HrAVg/2+/lDm8Av1sLxYcqYOwADWLXC3BVrqv49Hr6jH08CQHji+Hwwu6dU7lq6eUCulTWmjkBUHuPUcPXOHRlyQPIIlGpPfLWRY+3dvaGIwXJ7aYCBZFf3DONnRFwVZZcqQcPC2vQqGBywSjGHAWICctkS183TtVS61R7GGhbGQzh/aYqXTRmZzoDJ+XTRZ2pI06TFsYikd+NKPZCRwUhCKpdgzmYTk0+fNadGtuGJDL5dEcbgq1CxnyWQsuQ+m3uGOs6B4ujBgfSJt2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrLRvSw1MOpA6KXej0DtdmTVmfIeeaX4OW/IPZml468=;
 b=xQzP8EHhW+G2ORJVx555PzzHHwXoolGS+CktDgf3letMytBRLdG1BkKFsVnFuTkcWcMZAx/WAR/q57Bw+UQV1uuDNqwvdXrxcSNQing16Fz9F3AcDhCP361NV/c3lPLOnLkMAKxeUe+1tIa6CPNeEDYZEhbLT3cKJSm7DkX+wWEpxZWwAthlrhs+eJIESjji1bu9qExDEVAmkgpGCxb3BrfoR+YQx3gTrngi1p5F+gIpzV/S8o57FD3o5bQ/OZ4LkzXamMDznjLQe9XdpRnywS/MRQ8zLqHtlH8NRQso3rs0TIZ25HMMOKFxKli2dIky39VR+y65ztRlY6PYeI+2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrLRvSw1MOpA6KXej0DtdmTVmfIeeaX4OW/IPZml468=;
 b=NNkPT5oDjZUrzQkXPuxFCuozb/FuxQFbM8DyGivYxMY1HHimM/G6zQjW4GE+jQWN2jwn5Yvpe5vFqNlm8dMGlEOwrEqdUcsGZCuSaokxUySrdqvQF7xp7pQhRhYLnMt3cn8Pi9+niYh4NzmT7ovXG+7+DGpL/R1xtx2Eu7Jx/SQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7801.namprd10.prod.outlook.com (2603:10b6:510:308::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 17:33:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 17:33:08 +0000
Message-ID: <97b20dd9-aa11-4c9a-a0af-b98aa4ee4a71@oracle.com>
Date: Thu, 4 Dec 2025 12:33:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Allow knfsd to use atomic_open()
To: Benjamin Coddington <bcodding@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <cover.1764259052.git.bcodding@hammerspace.com>
 <DD342E0A-00F3-4DC2-851D-D74E89E20A20@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <DD342E0A-00F3-4DC2-851D-D74E89E20A20@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 042bf90c-1dbf-4d92-07ab-08de335b30d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWFROVk2MmhpYkJBQzBLRE5CL0Z1WWQxU1NndFVHYm1UakhqNkl1WWtlNEZi?=
 =?utf-8?B?QkhiVDJzN2RKUlBMejBvM2svZlFoZkJVZUdsa29OYnVodXFRTUJsTmNiWjd1?=
 =?utf-8?B?TUQ2eVRjaXFLaVV0eDBydmpIN2taaU1ma0ViYXFtdUZhamUzNTFRamhQSVF2?=
 =?utf-8?B?YUNzWi9hQktIdEk0TUczQnZOK0U1eUxSaS9WMFBqODdmZHZsSGZsUHFVT1p5?=
 =?utf-8?B?K3dmaUd4UjNDTXBxMHhuczFLcDZBUkFDUnc3UUU0U1F1RFZFNmM5S2tMZHZv?=
 =?utf-8?B?djBpckZmZkNVZXE5QUZpY1o1NFMzcjVTWG5BZlB3VGRNTGZwYktwTE5OeVNq?=
 =?utf-8?B?eGR3VU1rUFR3Ly9PbjVpd0ZSbmNOa3F1elVyMjhIcDdhRXpPMWZKNmNTUEZZ?=
 =?utf-8?B?VmhtY1BHOU9VTFhVbGFWVjNRQ0VMOVpxL2M3eHhWOENvditPbWRraEd1Smkw?=
 =?utf-8?B?NzRqWXhDb21TaTdValBtalF4WnN1eVB6ZDhWSUZKYlpCZ09ZS3lXRnNUVTJ4?=
 =?utf-8?B?bXcwZ2NMSXNsSWhLUjFKMXQ5amt0a1dlRFNWMHRzVjFYNHU2eStNQnk2dlh3?=
 =?utf-8?B?Z2tZSjRjSmYzZTVKN2pCZDY0S1k1dmtuZlM0UVhDTnZpWUlzY0R3VmJWYXBq?=
 =?utf-8?B?R3JpYVJSMkw4Qk44aEVaQ2hYa0dCQnhjMVhrZUx3M0JqUmhxV3plN1B5VWpY?=
 =?utf-8?B?c2FRcnNjTmRtQ1N2L2tkYnBmVDlWNUdkTS82QTNFbFNnK2k3TmRoajBmcGUx?=
 =?utf-8?B?YW1lR09sQk5GdTBKMFZBZlQ3SUtGN2R5RjF6Syt4ZTJrMkRDazFJNGZCT3BZ?=
 =?utf-8?B?c0VEL2dxWGtDakxJRVprdnpvVjNYendaRTJwL3ZmZ1graE5JU0FwS2xZb1JC?=
 =?utf-8?B?dmQwMThxOVU2YWo3VlBnVWMxdE9oaDdlc1BnWDNGbkVQSkVJeWtHV3E4S2wz?=
 =?utf-8?B?TnAyQmVJdVVVRTlDWmhINUU2ejBuS2tWcmZVSWJ1akNXWTlEL1RaSW9DU0Jl?=
 =?utf-8?B?Y1hCVm9OOEVsN04wL2ZFMk1pellhcFVtS1F5OGovSDhnY2F5aVg0MklNK0R3?=
 =?utf-8?B?RDVzcTV2ckZ0bnZuemdtcjNNU2lWR0ZycCtiOVFtSlB5TU9zSE0vY3hZQVpp?=
 =?utf-8?B?SU1lNGcyc1l6UGV5NHFSS2w0aFVLei9LRFphbnpwYXJFWUwrMFZFSnpaR3Fw?=
 =?utf-8?B?M3QzVGkxVGY1Q2dHQ2pwem0rSWhCd0w0dXk3bmJ3aGV5aUxPWGt5Z1VVdDRZ?=
 =?utf-8?B?NElwTmJnZEhsTUhBYVUydjhsNVBEeVRIYmdKZHlsTVdEVTN3dThRYmV4M0g1?=
 =?utf-8?B?VStxMXArOGVWaHdaZjZXN2ZlVWwzZTZzWEFOTXcrMmZQL1c0dmRhN1Z1akxi?=
 =?utf-8?B?ZVJUbDM5S2ZtaDN1eU9jalU0aUh2RS9qYXVYYTFTOVZpb29FcklScTBjc0JT?=
 =?utf-8?B?bGpaMnFzWDVoZ2JCLzUwL3dQa0VzOVMzaE9uc2t3dVptOXBGT08yTGVZQ3M0?=
 =?utf-8?B?TnpyUDFRR1krSzl3V2IvcVFNRmY5OXVxZDJCa2JPbWFsNzJicEVaZWF5T2Zn?=
 =?utf-8?B?NTJrbWZrRlVYNnlVSjZjbXVmZHQzV1pxY2JwMm5IUnQ5NVBya09BcFJuRWFN?=
 =?utf-8?B?SHY2TTkvQzM4YTFYeG0xVnBOaGRGdGdkNHZjdzBpWEN6SnJsNlc2RmlSZnVo?=
 =?utf-8?B?eFprWGlxTnVjZFAvOXk3S2FhVVJSY3YyUml0ekJhdk9XZVNFN1VjVkw2RE1V?=
 =?utf-8?B?Ty9CWjFKeUxmUjk5R0lBYkpFZzVIQTUzSTczWFJ4bElLODZKRWp6bjdjY3pw?=
 =?utf-8?B?dUEyb1F5a3hkQkpNV2M2THplQzFxQjVaTTZLL3h4WWZKbzB4TDA3Wlg4c1My?=
 =?utf-8?B?ZEhDc3dCTHlrOHV5MnEvYm0xRHh2NjlISERaR0xodnNncFNiTktTeTBRWWt6?=
 =?utf-8?Q?9QQlStZRQWHrsueSDk4PyRlOA341KyZ1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REZySEFpUDhxTzNSSUpYK2ltQVliN0tkM0kzMGNmV1Y2OHplVDVvVnh0eXRF?=
 =?utf-8?B?QW5WRjhtQm5OL2ZOeVVPaEVHRjUxblMzTWFSSnJhWW42VUhCNHpZNHpiVUQr?=
 =?utf-8?B?alNvbTZucnovMWFLemVkQzYybUJQK1NndU9SVFVKSmkrMTFwdEh1d3Fscito?=
 =?utf-8?B?QmoreU8rdTZNOE93bEx0VDl4cXJZckhTZ1FsbTRiakxDZGJlYlFTa2xCcUc2?=
 =?utf-8?B?ZStGNFpZNXN2RUp3SDBaNGlHa3ZNQy9FV0hTQmkvSnFHT0pmOHdaeWpkdHAr?=
 =?utf-8?B?dm9HMkhKaFM3STU0RWdLNHlxYTRPNUNNUXlnM0QwU0kwbFE5NDJ5RWdaTTdB?=
 =?utf-8?B?YlQreVA0RGZ2aXQ2bDBMdDdkQjR6Vm83THYyZ2MxNWlnbFpFUWI5QVZpQ3Ft?=
 =?utf-8?B?UXhIUjhHdUpzUXlKbVdqaStGY1BwbWpCUFZEcFFTVkZBY3RGUkI1MEl2WXdE?=
 =?utf-8?B?TEtjQjBNWXNXS1lqZWM1RWtEanlZT05YaVZnVTFUNTgybEpINDdvSlVHN2s3?=
 =?utf-8?B?OUJSLzltTTlpanUyM21TTlNmRklTWjQyWTFzRE81c0dlQ3NLOW1IRWZGVGd1?=
 =?utf-8?B?eVo4Qmp1T0VnUzhLSGFJRlJROTdsMlUvRzdvdGl1MVNBSEZEQXNuTnBmZFow?=
 =?utf-8?B?aHc1YlQwbk12ODg4ank1bm9oaVU4b3ZFVWZ3VndOUVdLSFZHdVk4VFNnbzU5?=
 =?utf-8?B?Y2k1RDhIQnRkQ2wwd3M4YkRPSTU2SnZNM3FwRXNMSjNOQjZPM2o1ekVnKy8v?=
 =?utf-8?B?c0k0eitKbk9OWVhvUThvYkliSTJNY3pWQVpOYk9kK0xnektZVDBHdEVwcWlz?=
 =?utf-8?B?dHR0SDlKZ01ENFFkWVZRMnZ2UlVUTG8rOFFTYy8wdzk2bFZhd0xwMWlEM1FR?=
 =?utf-8?B?eXBjNjF2eVVoYUwza3gvcThtZzhrbWhTUW1sZXAySEVjR04rQ2RmZHNUdW9h?=
 =?utf-8?B?WFJTclgrNzQzbHFzZndNSlJtRVphUytidndXS1IzOW5EUkxnY2dVcXpBbG4r?=
 =?utf-8?B?ZnU3RDlublRwQlJTbUJrcmExaEZUT1RHQWYraDVqY09iUzl6eGZqcnVMUTF5?=
 =?utf-8?B?dWRtN1V3bUhWcDFsc2FJNUtockFwRkNtMnNnZFdtZ083N25mTVpkVHd4Uk90?=
 =?utf-8?B?ZXp6NUJodDVVNGttUDRjTExQN1RPaWRJbU5sWlgrdmtBcXhlQVNLNTlORnB2?=
 =?utf-8?B?aUFlU0w2UnRTZnd2T0cwcEo1amdOQlo0VmpSOHIrazZDVUpONWtUOUdnRXl0?=
 =?utf-8?B?ZSsyVjNKK1luc2doYzZBWWo1OFpoWUlYQVdkWVB4K0M2UG1LSlpud2oydklU?=
 =?utf-8?B?V1NFdVBQNU1PTSs0ZkVrcTBOc1Ftd1NvRDIyVUI5MHA0Z0U0YmhqZ3d3Q05l?=
 =?utf-8?B?cGlJdm01RG13WjZHZWhnQkFTUTVJUnpSM09nYlR3T0lvTHVrK0x5VWJ0YUc0?=
 =?utf-8?B?RGwrSkRyZ3FTZmljeGZYSmF5REhSbmhBdXZVUExqd1Y3SFRiRlA0RE4zOTlH?=
 =?utf-8?B?TWpzM1Jrd3ZWQU51NFphOXN5L0Z5WnVMa3FpUXVnSDRnWHJGQjIrcHpFZlJV?=
 =?utf-8?B?NVFEZjM4a1UvcEhHcXphOEx3NHZTUGxwK2RybTlZWFBCWTFtUVVLNElsZFJr?=
 =?utf-8?B?N0kvYjBiU2JNYzd6UjljNGVSSmtsd2p6cGlYUnhkYVlPSGN3bDdSaVgyUGpY?=
 =?utf-8?B?TkVnZ3U2Y0toTmhBS0w0aXNWU1F0Z0VuZDNCUlNWSTZ4NDJwRmVqZUE0dWpp?=
 =?utf-8?B?MmJIaUw5cnNkQ0FsNTZBblR0Vm1COFZ5ZVNDN2dCTWlIQkM2VG5ZRC9lRE93?=
 =?utf-8?B?Z2xpMHVVK3VqbmlSLzQvQTlDS3JPeEtVaW04alZYMXkvOWtvd0xEZjdXTDhW?=
 =?utf-8?B?Nm1yQytyWnRJSWdxVjdNdjVHeTRRV09rWHQ2R3lqRzlBNGlRMHdOMTdSZzdt?=
 =?utf-8?B?Z2l5RHZscTZnbHRhZDUzc1h1bzMzMlc3VTloeWcrMi8zVHZEQmJvenN5WkZw?=
 =?utf-8?B?cytUQWFpTnNHWTRDV1N4S05Bc3pZMGM5N2c5bkRCakg0N1UrTGZ0REc5Uno5?=
 =?utf-8?B?WkRNNVZ6djMxNDJHM0JFWTdlR0JKOGJTTzU0VDFQR1JIZlYzUUZTNXJHSmNN?=
 =?utf-8?Q?EsUnihS2rBmrXGIcTMHRbDP16?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BzwUALBtHB0j79yEF2J7vnvbT74kT9ZaeCn6YmZ/KRK5hfFHwZ597iWh4BiP8987u4kBhPHaETT0+kFTxHZc9ZSB18HqEqNMRHE2HBbgVeP9ZDUNEF1djSEDYQoAfesgE71q410fKIuaBsmhfe68VYv4E2JglOwOCdQPTa4JAR6WIIFy+8gIP0+29XvNpO2qFu07oWywI3P3CwlBeAs+R5V7B1MebwG2MmR0d79n4soMB3sv7h+PGYrpS0WsIFAfD0LPjhFuWO3bbXVcwKFUTj6khYeD0HLMqm9FVHYZYA1ge31i+uK331n9loRTCDeTq96pYvy3nT16C6tHv6w+l0InBhJq7ZfpUz72gl5cwEx5fbcJhXTOEYAIQ7JhFISsxRwNh3aldjFexjWhahTTk/f1CO/acp4QAMzkOy4LK57eDbMV9w4DrQa+QnGpG8SMSutuExFI/74fotUOPicZwqWrq8zs2yxtZNW9GXtKxi5YHfdw7cNwYvwYd8oiT3j2erh0bx3rxD2oanJOAXezPTjQna8XoSZaW5Q3p7PBy91a5itObRUVFM2vC7aBsqc6SH8BaPVlrI99cfOy/AxoaYx2XCj7Ok4PH8pz1kPRjGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042bf90c-1dbf-4d92-07ab-08de335b30d6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:33:08.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFzcBVegSn3NUBr+LDGf1uDgAyUOlYfhx9jll8Yfr25q+vTTrzZk+GT9TUKHwV0GbSPtyP7e5I2WhkMiKYwPbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512040142
X-Proofpoint-GUID: fNWKH5zva90LIRc-B0XwGHFjVId7Aod_
X-Proofpoint-ORIG-GUID: fNWKH5zva90LIRc-B0XwGHFjVId7Aod_
X-Authority-Analysis: v=2.4 cv=SbX6t/Ru c=1 sm=1 tr=0 ts=6931c5d9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=MFG4xVhCULzvHt4jkboA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDE0MiBTYWx0ZWRfXwSewAPdCpCH1
 JyFLqMw1PPA2glKjFAqQbcPnTQMmSl2Kb59w7/jrC/zEv9M6k1mCUWyUs68JGi6hB6qwYPh319s
 8ti1WDwKTpuRobzH2J4ac+a3QRKYJ4HR3dz008rmZ648dGpaip0aFuQm7FnYFgH6d/KV53RivlJ
 ql77oBSWA3RHGB0XB3lzT+MijJe1vEYMaibmG89P9UwyVIaWKyArhh9S4lsuBNQ4ZWki01FuhdB
 uSdqP8ckbJn/OGg5u7Bd5CZmcrN/BPH3emnRHz3N/EuZpUwaFzf+qy5+oUePhNJdx2vvonR3645
 T1I9y3gdqqZG3Op5fPDNy2I9EP4cWyrHdBqWL3aCDJznFew2xnlgWXDIR/c0WUJUR3icpjDt2y2
 GfKWpXI8lKW7CrEt00M1ZeLGO40Bja9xLP73eULxYjRN0H+XzL8=

On 12/4/25 10:05 AM, Benjamin Coddington wrote:
> Hi Chuck, Christian, Al,
> 
> Comments have died down.  I have some review on this one, and quite a lot of
> testing in-house.  What else can I do to get this into linux-next on this
> cycle?
The merge window is open right now, so any new work like this will be
targeted for the next kernel, not v6.19-rc.

I assume that since you sent To: Al/Christian, they would be taking this
through one of the VFS trees; hence my R-b.

If you're going only for linux-next, you can open your own kernel.org
account and set up a git repo there, then Stephen can pull from that
repo into linux-next and fs-next.


> Ben
> 
> On 27 Nov 2025, at 11:02, Benjamin Coddington wrote:
> 
>> We have workloads that will benefit from allowing knfsd to use atomic_open()
>> in the open/create path.  There are two benefits; the first is the original
>> matter of correctness: when knfsd must perform both vfs_create() and
>> vfs_open() in series there can be races or error results that cause the
>> caller to receive unexpected results.  The second benefit is that for some
>> network filesystems, we can reduce the number of remote round-trip
>> operations by using a single atomic_open() path which provides a performance
>> benefit.
>>
>> I've implemented this with the simplest possible change - by modifying
>> dentry_create() which has a single user: knfsd.  The changes cause us to
>> insert ourselves part-way into the previously closed/static atomic_open()
>> path, so I expect VFS folks to have some good ideas about potentially
>> superior approaches.
>>
>> Previous work on commit fb70bf124b05 ("NFSD: Instantiate a struct file when
>> creating a regular NFSv4 file") addressed most of the atomicity issues, but
>> there are still a few gaps on network filesystems.
>>
>> The problem was noticed on a test that did open O_CREAT with mode 0 which
>> will succeed in creating the file but will return -EACCES from vfs_open() -
>> this specific test is mentioned in 3/3 description.
>>
>> Also, Trond notes that independently of the permissions issues, atomic_open
>> also solves races in open(O_CREAT|O_TRUNC). The NFS client now uses it for
>> both NFSv4 and NFSv3 for that reason.  See commit 7c6c5249f061 "NFS: add
>> atomic_open for NFSv3 to handle O_TRUNC correctly."
>>
>> Changes on v4:
>> 	- ensure we pass O_EXCL for NFS4_CREATE_EXCLUSIVE and
>>   NFS4_CREATE_EXCLUSIVE4_1, thanks to Neil Brown
>>
>> Changes on v3:
>> 	- rebased onto v6.18-rc7
>> 	- R-b on 3/3 thanks to Chuck Lever
>>
>> Changes on v2:
>> 	- R-b thanks to Jeff Layton
>> 	- improvements to patch descriptions thanks to Chuck Lever, Neil
>>   Brown, and Trond Myklebust
>> 	- improvements to dentry_create()'s doc comment to clarify dentry
>>   handling thanks to Mike Snitzer
>>
>> Thanks for any additional comment and critique.  gobble gobble
>>
>>
>> Benjamin Coddington (3):
>>   VFS: move dentry_create() from fs/open.c to fs/namei.c
>>   VFS: Prepare atomic_open() for dentry_create()
>>   VFS/knfsd: Teach dentry_create() to use atomic_open()
>>
>>  fs/namei.c         | 86 ++++++++++++++++++++++++++++++++++++++++++----
>>  fs/nfsd/nfs4proc.c | 11 ++++--
>>  fs/open.c          | 41 ----------------------
>>  include/linux/fs.h |  2 +-
>>  4 files changed, 88 insertions(+), 52 deletions(-)
>>
>> -- 
>> 2.50.1


-- 
Chuck Lever

