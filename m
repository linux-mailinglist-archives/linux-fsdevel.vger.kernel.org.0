Return-Path: <linux-fsdevel+bounces-46635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02802A92325
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BFA19E822A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B526254AFC;
	Thu, 17 Apr 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSOROs2E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ohzXN/U3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7F8F6B;
	Thu, 17 Apr 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908858; cv=fail; b=O2zcpPfsCjwXfEV9WJsfxoPbe+ssCMHfO+RUglHXc73Vs2kf5NWy3XlyrB1VS8pVyJMwoUI9hRUut9K9aMaYjt0MabAT+nsUPBfb8hgUehSkjqDZyorykl0KOM2d9eCW/tL4xSpQdJEJSeUnFiAJ6EbydyQqrcXYAYvwpYJi4aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908858; c=relaxed/simple;
	bh=6Yw9yObndp9Gkw26LgNbvHCCHfT6WqKuDRhA64YpWNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R6rCXCNbr8jqCxPCeSTT8RSNXhfW5uNVGXR981OkBKxOHEDJv+5ebY9re8DxwXYtmj7NTsInGc4zln4B7glPjw55c3ZGTfxGhiWmLV/3Mpz0tKQHv9w1RPNlFpIHZHi11Ugmms0PCEeAMbelwi0ZX1MakOam/KAIv/YbavzM3+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JSOROs2E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ohzXN/U3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGNABC019615;
	Thu, 17 Apr 2025 16:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jDxw6nYh9UI0sPdHUxMSWhrcHxEGKV/Azz1GL3Q7DDY=; b=
	JSOROs2EOKsh1TitBAv1k0W5WH59eVK7WOryjkupPTykbulFjTAeOALchj6pNXqm
	b6EDst9CNjajo9S92Eo5LK16t4qfI+qRqs+YGzIbhElkPpifHTEVIiiYCN5Sr+rk
	JtAZtB4DwqmE8XxHeLI5/Ii7J2TuzzT07T+GTrBDELplBRZh+opKrbTsycP33HF1
	ynjUxz2rzMlBEplYSe4jXSVjV/tEuDYvWi51P3wMRYLDdCMkvygINOo3acE/k+Pq
	VFt9D945YoJFfNWJJt641k0SA3g/RzyfuSJnNGEkBn6GOW7fQxFpDevbpHsxwpS5
	SQAGMThrryMbm6AWojQtHA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4618rd6str-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:54:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HFOtqE005670;
	Thu, 17 Apr 2025 16:54:10 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5yrh5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:54:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJy7obBFMZ9PUt3Jbry6yQ0P2xrGF3+65PXUDlGhsosCGAGYJZgijn+X1x+OcjLEgcPfTaIhIlKx1ct42ieOFhNTpyGQU6LhcYy7Gm+WfvgsWZifvstaT+A2o5VGPVGF0Ce6LV2o6lot25kYYBLhjQRsI33Q9QKufWVVBo3rCi/w/P2E1PGAqtad3lwYFPNk8sg8KWEwtuqR3bIALwUNB8D6JgZKR7vUOghqCxGFiCvdvN19FKA8KiJdRNwmWBpKeQt4B2IoKktiKF9RC64ozdkwUZ4hj9w76d3rJY3qzZdNbgL9F6U5aTk3OBEFinENIYP33G6q5u/vzUKxpnHS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDxw6nYh9UI0sPdHUxMSWhrcHxEGKV/Azz1GL3Q7DDY=;
 b=bsTn1aLxFfTPta5dVksAR/KrAv3U0QYFSNt2w9lA4gqD7dNW0z61qjCJoTwzO0tEh4Zc9EKbvkVw91ypgsqMv7JFyz8EXycJWIAUgxTCnN4ghsb0KGuQ0owSvbjPJxJsDyzc1/jZ63doGURwSW879fQ/GGFd3Tkdhyg5jNuDf4UjUxgKbRKbsA2DcQYgM15SxRQ8Wik08C/EOwDMeZCKvu8/9S4gKbE4kcp7FpZdTmNV6oDtSAGDx9W1j7MBW/7K/0I5CbnX+mpFp/CY9TRBZNxEI1z7JmSxQLi6BW3XWH38zAD0f+Kl9ZOhFfL1URLlhuJMamOKUoSyrtp9ceQrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDxw6nYh9UI0sPdHUxMSWhrcHxEGKV/Azz1GL3Q7DDY=;
 b=ohzXN/U3Bn2Emj+Jp/ErShCCbsEZ1T/tFLchhursQqRLpz9xyj8j6PqKMhbY3EKSDd/OFruyleT3nFkhbBUdmZ+X2mvSVA3d7XOaD2mj/3B/hIG5qsNmXTJXcSgxjbIY35dLTW7Q+GswTQpUAz6cNldAPrI4Zrg/nbaKTJ+8/Mo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 16:54:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 16:54:08 +0000
Message-ID: <fcf7af77-1f2e-4b07-abb2-f7c0740ebdfc@oracle.com>
Date: Thu, 17 Apr 2025 12:53:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Automation of parsing of fstests xunit xml to kicdb kernel-ci
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Tso Ted <tytso@mit.edu>, kdevops@lists.linux.dev,
        fstests <fstests@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <aAEp8Z6VIXBluMbB@bombadil.infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aAEp8Z6VIXBluMbB@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:610:b3::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcc737a-aabf-4bb4-372a-08dd7dd07883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDRkSDRySFloSFpZUlRzR2ZVbGdmRkR4RWc1OE9raGp6eGN3blRZMnRNMXZK?=
 =?utf-8?B?U1BRV2ZBd25VRm91WEkrYm5hTy9TTXdDV09UUmVCbEUrNEJWMEVMaUNrVXVW?=
 =?utf-8?B?NEQ3SlFwOU42c1NoRmRlZXpvQlVtRlM2RU9kMEl6TnNkUEV1SHpDczkxMHFX?=
 =?utf-8?B?ZDZHRU84emY1b1QyN2JrdUxOL1BXaTFiRmRBSHg4MlVweXZ4c2xmN1R2b05X?=
 =?utf-8?B?U1NFZytiSzJPODN3YmhRSDByVnFLRjVqU2Jsbm9TdUljU3VSUDZEU2dZbEto?=
 =?utf-8?B?V21IU0xURmNDWWtHTXVaRDYvNWEzQXArejF6QVRQRk1LWUVxRDg4aUpmYmR0?=
 =?utf-8?B?ekQ0SHdhdUZlek0zMmxwT2JtTTg2THA0L1cya0NaWWRRV2kxMkZYRnJUdzdt?=
 =?utf-8?B?WWZGMzdXYmo1V0FvTnI2d0pNekI4YmU0blBaN1FjT3JUOGZsR0tURE85Y2I0?=
 =?utf-8?B?MmpCL2l4VVR2YVFVRFFOcVZoSTYwZmJkQnEwc0RUY1F0aE9RVmdkSG5USkdk?=
 =?utf-8?B?SWxGZ2JhRFRWVThFSEV1TGRmU0ltTGdBOVQ3NUpKeC9oeFk5emgrZG82WDg0?=
 =?utf-8?B?Rmorb3lOZDFXZ0V6RVNFQ0NKWjBFMDJqWVlmanFHRmVCTEFKaXhpV0JWNGd5?=
 =?utf-8?B?U25PMittYm93SStFUzErNjhNWWh1bVFiNXdaQTNRVFo0YnFNTnl3V01ML09o?=
 =?utf-8?B?bnl1d0ZMbm9NVndLamdGU0RmMHNIcHJDT25QUnovYjhQUDZQakFQcVhYclZz?=
 =?utf-8?B?UDlyQ2pXSm1GaGI2ak1BT0p2S2wvTHdCa05WYS9iTUxJbGtSMzlhanpCbkNS?=
 =?utf-8?B?dmlVbWNhSG1tTHlZbEFOYzNYT2QrTi9XR0gyU09nWHBYak9oc2pqeUtkTzNS?=
 =?utf-8?B?bVFpNXFWNFkrbTB5MHVlZEFiMkEyR0dOUHVPQnBNblIrTHdwVWRjN3ZueGlt?=
 =?utf-8?B?K3hGY2dnYVY4eVh6U2lWWk9rZ0lUNy9oY1JyVXBPejdqSEQwWGRkamhDdFpp?=
 =?utf-8?B?R2UxVm1WQnl4Tjk5NkZvdkUrNzdiVVNFSDFGNFVuMDBNSzlocmlFdXN5bW9C?=
 =?utf-8?B?NTRDelFIdEJBQ3UzM1ZIZEk0TFZ0OFErQkdvUm5QTDNYUmQxbnErWDFVQU9P?=
 =?utf-8?B?eUh4Um5jbTFZNjdNaVRSREdtZTZDNURNS3VKTnkwNHVSelNKNGMvNzhlU2pS?=
 =?utf-8?B?ZWNqZFZaR3N6TG5qaWtBbWxncWNUYWRvK25vVnZUSFN0RTR6dXhYOUpSSHNw?=
 =?utf-8?B?akFrZ2VONFdWcy9wMGRyN09yeTFUeVdwSVI1c1hGY25XclRKcXJPVGNpUnFE?=
 =?utf-8?B?QUpJdVdEWmxRNXlTUThRTEFmR0JGYzVMTjRIUzlMQnNIK2R2cHFUdmZ2YkpM?=
 =?utf-8?B?TC94bTdMSlRhSUZ2NGhFcVpaVTh1b0FrUks4R0FBcm1NbUFrdWZmdTFxQll2?=
 =?utf-8?B?OFVmMlo3ekErS2VSRlNXbklESC9lOEhOZURtTWh1OTFXbnZYRXdOQXp5bE1H?=
 =?utf-8?B?eitRMW9MMXpQQUNyT1lNTHJrQTlvRWs1UzZSSW1XQTYyeU1xSFBQZ0VpNDVl?=
 =?utf-8?B?SGFheWxIb3VaUitFMUF2ZFQ2eG9ZTWV2aTNmOU1remhXYjhtR0ZjU2xJOE44?=
 =?utf-8?B?MVRSZzhNNUtrbGlqT1IzSWY0OWM5YzZVSWkyd3lKUXJCU01hQVdJQ1pCUlpW?=
 =?utf-8?B?akV5MWVOYXFmWGxPc1ovcGR6VDF0d0o2d2o1ang4VmFIKzhSV2lBZFFNNDhG?=
 =?utf-8?B?OUZmUXc2WlBTdW5qb0xKUnVDdVljUUlKZzFWWEZNNS9FeVY4TUsvMW8yWSsz?=
 =?utf-8?Q?E6dY1nbgULVmI1aX+SHOkC9LqAV1QnDhmj2ss=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmtJWXFjOGNORzhRWWtNcml3TWVkRjVCOGtXc3NueDhXQ1dtN3JqbUgxckRh?=
 =?utf-8?B?dlN0UzhqVEZnaTlpc3FhNW9nTXBxWkdXR1BtYkh0THQveWFVd3FDVzJlQmlH?=
 =?utf-8?B?WHFITHM5clB3NmFRSWlrVndFRnlPQWlFQjhyZU1tZmpNa2lyOE5FZUNkdDVT?=
 =?utf-8?B?OHFQNjFMdTNGQmZXVXJZOVVSOU9GL2NUSTk0bllaSllOVlBCRVdLWHdYdHpN?=
 =?utf-8?B?V0gzZU9MT1FNUFJkS0dyWC9oMGQ2UHp0SUl1TkMzSW05TlJHUHM3bFFRRVgy?=
 =?utf-8?B?TFNvcFVzY0R3R041dUlxbnhOdFA3SjE4bTlvaDZoa3k4MzVsUmlPcnI5S3dk?=
 =?utf-8?B?ZHBhQzZnYXNybHlXNHJSbFE2ZEUvNGNhS1FEOXQzY0VaVHE5Ny9BMWZQUEkr?=
 =?utf-8?B?UW1yVlBBTW1sUThxT3A5OXJjVDJsNm9SQ0MxbmZrNkdUS2YyT0Mrek1wSHV1?=
 =?utf-8?B?ZHRTNmNteWU2SU83WG04djlVaVc0YXEvTnk3NTVtQnVwemxUTU1UeVdzVE5M?=
 =?utf-8?B?OFZFeThqYk1tSEF3N2pMbkMvbnVKZU9iQTlBMGpaYzJsRjhuMzN1RVRpUTJI?=
 =?utf-8?B?ZGpmVm1xQThQTUM3ZEpqZ0lDNkJCWEkwblU1empZaXdOeGR4OFI2NXhsTjVL?=
 =?utf-8?B?STUyTnhRbitwS2RRUTJLRXp2NEdjOHN1VDJTTWxhTVRKV2V6QVV4YUord3BN?=
 =?utf-8?B?MTBBdFNCeUxjc3VqcUYvT1NuNDBveW8yeWVRQlZRMlN2UC9SS0NBUUY2eWdp?=
 =?utf-8?B?MGJ4WkdQS0ZnSnBXK2lGM1I1Rml2UGdlbTJjTUh2WmVITzZUZHNQRkRCeEhF?=
 =?utf-8?B?WlhGakxETng1SjJZOGFHTEpmQU5EUXFLYjh0ZmJVWTdUUjBHcVFCSThVT054?=
 =?utf-8?B?RWJYNzN2NmM1c01IRTZMdzgzWVh0SzJLRGVTN1BjTHA1WUc5Y3ZaU25sUVVw?=
 =?utf-8?B?K0wvWkN6VDlPQURiUzZiZXZ5YUIxR2hMRkxlUUozS3FJdWgvSGJJSFAyM1ds?=
 =?utf-8?B?QjJKZUlXWlBPNmFjRTlDeS9RT0c4aVVaMUJ4Z3lOai9senJZVUR5ZVI5MW5p?=
 =?utf-8?B?YWpNNXVPMTBHMlFvZ25LWmpRTDFncGs2MGVnWUFuL3BmRjdiUTk4ZUczY29G?=
 =?utf-8?B?TkhweEdZWU9kbVNta0kyNjFyTlRVZlZSK3hSYkZoZklSZmV5OEIzTEFYQVVR?=
 =?utf-8?B?NUswUThCejlZSFhETVR3Qnp4Qms4OXg0OVVrR3BpWGRaU1Q4U2pZeG1WcElP?=
 =?utf-8?B?M2J3TGI2VkpKakZmT1FWVWNPQ3ZESkR1WjdOQmZhUWxRQWlRMmpzUHVYdVlh?=
 =?utf-8?B?S3RSbTdFZ0xIOG5naXY3MEJTQmc2N2l6bWhBNXNqcjUxTk41blJ0c0FoZWpL?=
 =?utf-8?B?dmVXMWxjREZkd0plbjZTRnFNanNXalpyTmwzMkRRQ01GOExyNEdxNXRBMGE1?=
 =?utf-8?B?WFBFQU9JSzRsdHV4TXV5dEErR292MjFsVEFVOVdzK0crQVZsc003Ty8zaFVs?=
 =?utf-8?B?blY5M1ViTGNyMWRtazRqbmlFQ3J2eFgzNmY0ZVVCa3BnSGt1U0hUVFZsa3NL?=
 =?utf-8?B?QW1YaUJUeHN5YXhJeFk5U251a0FPL2doQ1AwQWJhSnFrVVA5MkwyWVVaaWdV?=
 =?utf-8?B?UjR2VHpIQXBHeUtSZ01oakZhbFpCd0VQbms5cGNsYThZSHYwNE5RdXd3aGxQ?=
 =?utf-8?B?SEhxcEFlSUF1WU5VcStzcW8vcmo0VGcxRjlMWmZLbnM3aFg1bTdueFA0Q21R?=
 =?utf-8?B?VG9mSjRYTUFhRlNMeWNRbTA0UjVpQlgyN004VzJnU3ZtelV0ZTBhaUVoK2wy?=
 =?utf-8?B?SFVPSGZSUllvclJZY1JXUHBBQ3Z0eTY0M1ljazFSZFF3U3F0TStMTUJrVU5n?=
 =?utf-8?B?aVFSaDNxQTRKY1dlajEwcmNyOURsWnNkTjBZRWZHMnJXMW16YjJFMzlUUWRq?=
 =?utf-8?B?b21Bb3owYUZEanVwTWNWRzVPY2t6bjlmd2NZdVNTek1Pc0V1ZlorMW1xcjRv?=
 =?utf-8?B?WmxvNGFGWmNFUDNuU1IxcGJvd0VaNEFGTmdkWlozWEt2RUZ0anlYckxWNUl2?=
 =?utf-8?B?LzBZNVh3UWo0eUtGRFNVd3R2K0YwTXl0anR1aGo3emF4SmVJYU5rODQ4OG5a?=
 =?utf-8?Q?YolJwF3sBr5keSYGqTY2XgdMl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JaIV8PI1RSbUcf5IzNk8QyIYmDWX4LASMZz9fKOgHW41J5px0u9c9xbJwP2G6k4IszF+vUds1/sxnMOROvuyHlO5Dlx5YMxRjmX4ZiFkhjHqeCIw8BhvH3xJZcrsn1CUVb4azFDvODhkT3MQyewMGdSOGM2TsBetdLmVHdOiNU7yz7VV8Y0fWDbZQXJhxNipEBuqDcaZAZPpaszN6/JQukm2y/JwcK0xWmC+mE3rLrNktP/wDUacBvLbcim/wdLd1VEcR37ZoKbaevKYIRGICW2Vc4fahQ76HlmqHqaoU6G62idV6sHKI/ILbsNcbOJLegeYpLKKbwJ7Fyo0138qW53yYk5GM4HLtq0NfQ2AkBHRBxTvy/qLWpYHLVtc6WRnWz2e++fnmqDeY+c8EBR+ObkhledERyILiyH4SxPVNckqqlYT2yd3VrYri/HoNSN8HZJhXT31rm2IPf4MtFY6o/vQbvJNMbYhZ7VtzzsdyenJpm9uiQl48XbVr4aTAKFrdmOvdGYJi35LWNWbolkzm0pykFVXTxJSXrzdeIv1Nh4v2PKkqHP8fMKnKTTIaz8loLVaYFmmRYr8CplD8TC4hjDnSCnYpjAX+KOcOOcwpFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcc737a-aabf-4bb4-372a-08dd7dd07883
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:54:08.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IbE1MwOAFA8cZ+YudZ6TkLpKgWaZsqU5Txh5JC73g1JevOTqVS16JHs7nRTcFY/APV7O5wvW1dgeNe8AeggUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170124
X-Proofpoint-ORIG-GUID: rREeVzF3uBgtHG2KOsWDjll3LPIA11Ej
X-Proofpoint-GUID: rREeVzF3uBgtHG2KOsWDjll3LPIA11Ej

On 4/17/25 12:18 PM, Luis Chamberlain wrote:
> We're at the point that we're going to start enablish automatic push
> of tests for a few filesystems with kdevops. We now have automatic
> collection of results, parsing of them, etc. And so the last step
> really, is to just send results out to kicdb [0].
> 
> Since we have the xml file, I figured I'd ask if anyone has already
> done the processing of this file to kicdb, because it would be easier
> to share the same code rather than re-invent. We then just need to
> describe the source, kdevops, version, etc.
> 
> If no one has done this yet, we can give it a shot and we can post
> here the code once ready.
> 
> [0] https://docs.kernelci.org/kcidb/submitter_guide/
> 
>   Luis
> 

https://git.nowheycreamery.com/anna/xfstestsdb.git is one possible
solution.


-- 
Chuck Lever

