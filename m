Return-Path: <linux-fsdevel+bounces-42684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05183A461F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7EA174340
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE69221703;
	Wed, 26 Feb 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UmzXUNe8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CJZHpRVV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044821B9CA;
	Wed, 26 Feb 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579078; cv=fail; b=hTSO3Rw4XVGFo4dOe7YdL+TiO8QfiOBmOrv5rIuBFkyYeUDb3DxV5/+OvPW/jUEbsF+AT+Al6+35I2KrMhCuQOx8kHXA3+2VqmJn2hBPNdyK+l5JRPGlieo1/HrxogCn/7KDmvB8uK9Ad784QQu9vuadHD5FARcutGF0WnXTcho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579078; c=relaxed/simple;
	bh=61GGFtyG2aFHbnR4yr6ltzWWbDiOGEVeMl15vprwyFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYmDLeeQXOm2igszHCbBik+eYNo5xw/1ILyc1fVjN38vkHrN3t1U+hBva/TzUdiHPAQhp2FF1rI5KUxKn+kahnaEb4i1rQRNtwW9oMaExJeWoAC4LM5+qvb215Q9gF6oZ+gB4QetaZQcfMvUN5UGYpcQdfuIbKRrEMauEZ0JcTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UmzXUNe8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CJZHpRVV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDtX7v025846;
	Wed, 26 Feb 2025 14:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LxEgy9JkZn65Et15/RMc3WkqYeOU9g/X+x4HxLfi9o8=; b=
	UmzXUNe8v80jVqmgrTe5R5Xw8aXLm5U4LsgBDV3pUfQzzx0BF/KWobkxArRb9YmI
	IDKv0RAvwEF4IluOxDxkaJU4tJgnaykitIjxZaZLNxJkld9MLrfTO6hyW+VIr0eW
	CNvfUisQvxoYGUsqOZugzRR+OgMT+m3rdZaOH0rvOzSrO4cW01d/udev4byH3vJ9
	oa0ky5e4+qX6Gnsz+/ZYwhtgZgGN8TQacOUmO5g1pmVwEYRqoEkS5nVV9OfVzzCD
	qFqOPnPh0cdPaamUBiQWTluDoMWjGV4FaKAvyWj6oPyWy1jSDpCEV2KYLvPrJ0FY
	IimNmBao5dZVYyMLwEIodg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse17px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:11:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QCxoKF024675;
	Wed, 26 Feb 2025 14:11:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51are28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:11:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2T/OxP9J+gZTkBlCyK0BN8t8VREqLQczMoT+61C7xa1MbK6jFxnzJsk7tPQirH74e07rn1IT9r9OE4SD7/c/izdttP9V0DVJdAFvH1diUEseVpnXUGW2hJaIIBmfDTzDsWbeA6vkEt+wX+ei+5xMDJ2ortmOq/oGzkJeEe4+BwfQ4hLKZ5eu74b3h0TAyBpauOuBHzjf+2+8MfPfTMLjTH0qlBhDbRLj/2BSq0isoj4IUFiSamjFRQow4AioRM6iJS3MpdUagBk2k2Ip7h573joV/DiF5Z+9Chs/QYjyAlBX5CkTKZNC9cdrG/XX5sAcv5oC2crC1U+iDkY1akP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxEgy9JkZn65Et15/RMc3WkqYeOU9g/X+x4HxLfi9o8=;
 b=r2wCYucPZqiJc0ItdWATEZP4zpnyUgiAbfhMnnudYrITYRYktBu9pxHQD4Vivmw2MdC5VdQkfUOUjs9xnyMZpjZUwOzC4BNXNN+uEBnzccS+DhpIpNvBP6ExyrZWuokCuxcICSFWmWJGzWuVDae/i+8xXbxhPaGIKrtsd1s/m8NXUiZzHeirk6LNocFgd9zUwVSXDt8nAs5oFpDBUJfgbEhPrLlte3KLKpooj40Q0hzirGpl1zwfZcTOI9ih85GU879omY6u7XbgUx93EiovE88+0ti0if4q2yt+n25pUi94V84PmTTfpXWdqs1S4kAPcj77WDWqdbuKpL1imifDUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxEgy9JkZn65Et15/RMc3WkqYeOU9g/X+x4HxLfi9o8=;
 b=CJZHpRVVTFxIIl54NKOwzpOnHmi0NrRngQNSqyIZVDf/+hEXniBQUwHDy3piD6eY5t6IY9TVzC7Oxzf59cXnfgtZj1bEEI6w3oRLR6cikM2+Z7Q2pE8Kk9Tu9kSkYYU1Stacof87l7szhM3LKveBHqJK/nnDyib9FFI/Mwm6ISM=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ1PR10MB5954.namprd10.prod.outlook.com (2603:10b6:a03:48b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 14:11:06 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8489.019; Wed, 26 Feb 2025
 14:11:06 +0000
Message-ID: <263acb8f-2864-4165-90f7-6166e68180be@oracle.com>
Date: Wed, 26 Feb 2025 09:11:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Takashi Iwai <tiwai@suse.de>
Cc: regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <874j0lvy89.wl-tiwai@suse.de>
 <dede396a-4424-4e0f-a223-c1008d87a6a8@oracle.com>
 <87jz9d5cdp.wl-tiwai@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87jz9d5cdp.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::14) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ1PR10MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3beef7-6f69-4bd8-1d86-08dd566f6909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEMrNFZlQjZmRXRvV3pMcEY1QXNnVzI1TnZRREcyelF1bTdUMk1haTdBSFh1?=
 =?utf-8?B?Q0c1K0pDS2tNdWV1bml2eDdXeExMMHhOZVUrWGZUN054NUFOM3B0WFYzSlVU?=
 =?utf-8?B?VWM4OWFrUnZZdk41WmVDTW9iRDRJUWp5OGpCbTZaM0ljTUpCZG5kbGxCT0xQ?=
 =?utf-8?B?WWlDZzdWeFQyRlpCOWtnWmFMMHhvMVZpL1BVTEM4bWFTZ1phZmF6eXczVDRl?=
 =?utf-8?B?eVZKOG1XbGJFS1FLcDNlc2hJUGVyejBEaWd4OVZVT0UzSkhTZS9WOVBqbXJ4?=
 =?utf-8?B?TWlOSDJyRGdkcGd5Q1NYYU42NE5mb3hSYXJ0dkZjVUlZZEhhcXoram1vMk0z?=
 =?utf-8?B?VnBTMndqTHY3eDdyQ0NnSE95YjNOdmoyN0diQ3k2M2dZWG1zaWVScE9TSEFw?=
 =?utf-8?B?N0phcVh0SmowN1VKTVZUSkFxRmEvNnByYzY1bVRGZ0t4amNwekE3elVVWEVO?=
 =?utf-8?B?cmhBTlFhSGJSYVdESXBuSE1vdnRydndjQ29sRlVhVjdMSGt5OFJQMU5UOGhL?=
 =?utf-8?B?cHNiTDNXb1hnMHVJSE9nemxHa2d1SmQ4dEFKWTJDTHJLZWw5eUhDT0pzc2dW?=
 =?utf-8?B?aEJlbkFxbk5FRDhqMzZneUlUNS9vVjR0cGdnOVd2SVlaeEx1eU5kVmZYN0VR?=
 =?utf-8?B?QmdRR1pSd3owQVlFeXRPcE1BQldxMG93UVRpR0prTkpvY0ljZHZHSm1CVFZH?=
 =?utf-8?B?YmRzblVtcllWdzh0aVhkdys0NjFWcjV5bHBFSXdadzVzU3NqbEtuOWsxTCtS?=
 =?utf-8?B?dmRHQytBdXZyWFdldlRxQVFLSmhQTExYS3oxaU9LQVRiSEtHckVkL0V6Y0Nh?=
 =?utf-8?B?SC9rMC9sTXM5cmwxOXVLa2VwWUluQUdmNXNITklQdXFBN3c4MksxOUFrbjgz?=
 =?utf-8?B?VHFmUE85ampCZlhOaUJwWlg5TU14VXpndklWSGZGNXVrVVRWeUoxTHFmOHVQ?=
 =?utf-8?B?bmExenBDOTl1TU82cUo3M2d3ZWdKRmxCYlJCc1lka3F4TU03WTFqU1lWMzJP?=
 =?utf-8?B?eUxYZmdESGNUa1JVSVArL0tMNGV5VENka3BEbXRpaUs2S0lBbi9qZHA0RHpw?=
 =?utf-8?B?R0k0ZXpxNlBBZ05vaDd1WWlJb2J6WEdSb0RXcFBBdnllTnBhQlhKK3QvSDlZ?=
 =?utf-8?B?QW43N0Q0RmlxMHM1aW9lM1dqVmdSelZzellTVWd5L0txTTNMZUhqWFFIdmIz?=
 =?utf-8?B?eTNvbStndDJGYUljMTZpQWg2Q0p1Y2lqU093K0FOZzl6aC9xV3NYc0NHM280?=
 =?utf-8?B?S2Y4RDJoTWJQVGltOXJJZ05qbkRDajdqb3JyN1h0ajVLUzlyRloxZXBmd1dr?=
 =?utf-8?B?S1V1d3B6MkRFSEdNNEg1QW5PUm9qOG5EWXlsWmVsTStvQVlRZi9ucVFkTm1J?=
 =?utf-8?B?b3lTQWNnaTNSTjhWS2prYU9pTmlmQVlpdnFrM1pMaDEwNDVVb2VjSFpmR0R2?=
 =?utf-8?B?WStHeE9JSFUxQjBGWlJqcStzZm5mL3QrWFR5QlRwTFZYTDcybUpQUHA5Unpv?=
 =?utf-8?B?blQzK0Y0Nkw5YjBUdmJKcmk1VXNVSC8wTlBuK2xleDFKcEZaTVFOdmVCMktw?=
 =?utf-8?B?Y2xrUDNwUWxMSGtYd3FRbzNXTTBtWlJ1emYrZXRNZHlkT1QrUjIzVWpub3N5?=
 =?utf-8?B?UkNMTG9PZUZmdDlHTDhicWNJWVNlT1FHVFhTNlJ0WFRSZER4Rm00d1U5bng4?=
 =?utf-8?B?RDRlbW9HdGwySHQyNVB0amtJWjErVHFuQVZkOEpVWVJlbjZOWlhGUUtURU43?=
 =?utf-8?B?b1pZQ3ZLcU40MFAxdjQ3Qk9WR0xyc0UzR2xNbzFyK25rdytWNHIwZVFJcmk3?=
 =?utf-8?B?ei9Bekh5UE5xcmlDWWJiUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3ljblNTZVNHTWVmRTUxWVBRd0VJbnc2bEVEQzhBYXh0UnBOLzFoTEp1blZF?=
 =?utf-8?B?VXI2OEQremhnNXc3L2N3Si80Y0hiRlNKY0Y5SXRZY1BpU1o2aDFvQlBtY3JW?=
 =?utf-8?B?U1d0K0ZaT3NnTThxUm9DbUpYb2IyWUc3YVY3WEYzdDVqQWtibkNyKzB3dlNu?=
 =?utf-8?B?UDhzdktTK2ZXSUlwM0prWHpZYzYvLzg4Mm1KYVk5QW1sQ0dSdm9UWldCVUFi?=
 =?utf-8?B?U2hMTHdsZVZZei9UUGlVVEVBM2M4UGpWWTZDaWlueE12MmxSeS84T3BxaC9H?=
 =?utf-8?B?MFMxMmdpdnhCMWZ0M2NRbVdVMnR4WHNQSzg2Y05SUTdrOFJ4YjVQZGxHWW9L?=
 =?utf-8?B?MHYzTVBZamZ4K3hqbUM1UjZ4NVhTRW5aSmpWcFJvNzNWS2FnNGdtemsxVTNk?=
 =?utf-8?B?KzRkTFJwUUs3YVREOC9jb0J1Z2NmUmM2UWxKbzdUNkdmVmNMcHpKbk5mcCtk?=
 =?utf-8?B?emN1TG9VVXZ6dnljbzRlR2dEN1VLQ2NqWEdWVVVmWnpyZzIyRXNJRCsxcmJm?=
 =?utf-8?B?YmRDQ3dyMWNXcnk3dWpJVUczeDQ2bEt2SjBFd3NBNmFlUGdsT25icHllY0FN?=
 =?utf-8?B?N1NiTEtmWUJGNU1mV2JOR3AraFIzdEdDNzdQK1AvZVBxMzh0QzdZQ0tRNFJY?=
 =?utf-8?B?bXdBK25ONUY2aFpkMWNKWHFCWmxWQlAvaW5HVXhEUjN5RmJxejc3ajlvMGM2?=
 =?utf-8?B?QTdlMmpOclgrcnh2dEdIUjdGVnVhNVVFUDZWNHFYc3A0dFlwZ2dpaHdjL1pN?=
 =?utf-8?B?WlFadW9qRk1ncXk2RG1MU3hoM2IyakV3QjU0RjQrMTFWODcxQXMvOWRsREJk?=
 =?utf-8?B?Y1kwblRuSVZYVzdqS2hzYVRsN2docmxPYXRjNVRQSGRrTUN2VUdVSk9Bd3Qx?=
 =?utf-8?B?TzlEMEMvTzZuT1dYTkt2b3pGc2NzRkZORzU4RWNmcVU5akZSQ2VjVEl2ZEVD?=
 =?utf-8?B?SVY3d0RoMkJURFNPSGoyV0EyZWpwN0NaVG9sMldMaXBIMzd2eGlHbGZZVDRE?=
 =?utf-8?B?dE1YY2JLTEMwdXNwMnpiRnFHK1pMRVEzLzZwTTN4b0NjSGZndk8yT1Q1bGdP?=
 =?utf-8?B?cng5b0lRR3JkVTNYVk5PSWtjL0RBVW5yb3p6OTc0a2tUdnB0Y0Y1eVBIQWNH?=
 =?utf-8?B?dmd4OXpUL00vdE41Y1VYV2Nra29rQ0xhZXpka3FWbSt6RlNueDlUZmFpd0lM?=
 =?utf-8?B?bnlsdFVHYTVVRXRvVUpXZDlQUnhjUzdGZGFsK0ZBUmV1cE5uZG1PUncvbS8r?=
 =?utf-8?B?b1JKdnREQUEzZ21MQnB0clFXNFB2a2FqdFYwQVg0TDR6RHlEMVlGdmRyUDVv?=
 =?utf-8?B?WXRKQ21PZTJJWVJaamlRNWNzNldKME9SVUZEM1c0YjUyT2hyUVJrSEJXK0ZQ?=
 =?utf-8?B?RW1ieFQvZmFlYUs4blJ0anhIM3poa0R5WWVzYXFYYzZDYkVXNmZSV3JvWXlC?=
 =?utf-8?B?UzluVGswNUd3V2t5bTJlYTZHbXhDTGgrdW45dkhjUHNINU5ZVmg3ZzgxM2dY?=
 =?utf-8?B?K25WV21UeUJFQnFnclh5Z2prak9vQWdtcTBPWlJzd3FKVngzYmtxZ25iSE1l?=
 =?utf-8?B?eWJEVE0xa2RIWlovS25xaWNLQVlONTkyNC9BSlZFdk4yT1IwdXozRUtrVWpW?=
 =?utf-8?B?UDk0TE9XQVlwNDZUYWNRbDQ0Vldla3lacjVaYUpBTHgzUy9leEVyQk5FNk5M?=
 =?utf-8?B?RHZpWU12Qkk0RVMvUGJBTmh5ZXdYc2pUZDl5RUVKMUYzcGNCSTFOeFdOOHo3?=
 =?utf-8?B?SDFDODNDcEZRcUV2MFlZb29aUmFXM20ySVpiQzYxR1luOXlWOTBtMXVoc0RQ?=
 =?utf-8?B?cFlvL3lpbC9wSWM1KzgrRGl0SDEyaGxGckU2TG5pejRZdnFFSStIUFFvY1hR?=
 =?utf-8?B?bkJFTnNqcUdXQm5yVC9MUThOdEVneEtEYXo4T3BzYTBpbGpQN2ZCVEtCd0R2?=
 =?utf-8?B?Tm01NEt3dWFqZ0RWdVZ4cEo4ZDgvWFB2OWtGWmVUNk9ISGpmdzJOS1lnM2lu?=
 =?utf-8?B?OWRkeFljb0N4L0lUOE9yc1lpRHdwcW5LTWZYTjZZWHkxUDZ1WFc0cHgzNlBJ?=
 =?utf-8?B?SjhrZ2s1b1ROVEtpOEJzU1BYOHdtMVhEanpzZUl1VHZRSi8yanlteGVHcHlu?=
 =?utf-8?Q?+ygbMIIr7dFBVgWDC7Xw5iJyP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O0o7sO5T1cQeM26nfy73dcPYt+sOufeWrgBmI/5cNVX7SKeQUt5J7NH+KxZ7cvLJg/FKM1f9Yd9SWwZKASrPJaX9sQ/x42eK7Fs1gl6Jr6lsglFj9jh/HDlqiUZq02MsdZ2PNqzTM67Uj2Jlo2BL6Vw7P/A+5zp/r4GQvtoYQH2sPdn0lyNcVzRI0JzRuVjFESKPCMlS0BJVG8HNG+d9Wzzw19cbAmhsQK9or55vWATmfmTCUQ9GMtQkL/EOXZ8/pLiMPOaTd5qH+zSIj1K8EgXDQUbMox1VTpY/iz2++E5+xmWmLg/5nvTBjGju5KiiaS1Bc39SkJlcUQOVDKJPJ7BkFYNvEqfrGzYpnzfr6hbYh2DY1NQkxWKULGAEVFJHYgpIJjNr0+5z0xxqRnHGXXEsVTG7KxPOZZ6eFeXg0BGg4ave+4o8p3B/1g7EuQgszrG7f58m/4UDzTB4bMiTN+2sRf6g9923gwOpz+3zT/IcyABtP7t3q7F9NwLbbPOMdrOtIICR0+5Som6EYgEpVzK1oubFMMwDEpsC8unirUr9eEk9BluaohfI4msfeYbaC+TMtOK7Q3qEyyWFKJCm5FaN+Hs11mUGdAmosXhQ5oI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3beef7-6f69-4bd8-1d86-08dd566f6909
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:11:06.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIrdjs9YQSJL6bBJJN3q+q8TK6LLaF2Fvdf/vBHDgGVhh/tCLuMyPys3HMMZBgQnNR7/QHsk693nuYhQswJuhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260113
X-Proofpoint-ORIG-GUID: mrsZEPxee8pcAmziVC6BMDEPvqB1f1j7
X-Proofpoint-GUID: mrsZEPxee8pcAmziVC6BMDEPvqB1f1j7

On 2/26/25 3:38 AM, Takashi Iwai wrote:
> On Sun, 23 Feb 2025 16:18:41 +0100,
> Chuck Lever wrote:
>>
>> On 2/23/25 3:53 AM, Takashi Iwai wrote:
>>> [ resent due to a wrong address for regression reporting, sorry! ]
>>>
>>> Hi,
>>>
>>> we received a bug report showing the regression on 6.13.1 kernel
>>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>>
>>> Quoting from there:
>>> """
>>> I use the latest TW on Gnome with a 4K display and 150%
>>> scaling. Everything has been working fine, but recently both Chrome
>>> and VSCode (installed from official non-openSUSE channels) stopped
>>> working with Scaling.
>>> ....
>>> I am using VSCode with:
>>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>>> """
>>>
>>> Surprisingly, the bisection pointed to the backport of the commit
>>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>>> to iterate simple_offset directories").
>>>
>>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>>> release is still affected, too.
>>>
>>> For now I have no concrete idea how the patch could break the behavior
>>> of a graphical application like the above.  Let us know if you need
>>> something for debugging.  (Or at easiest, join to the bugzilla entry
>>> and ask there; or open another bug report at whatever you like.)
>>>
>>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>
>> We received a similar report a few days ago, and are likewise puzzled at
>> the commit result. Please report this issue to the Chrome development
>> team and have them come up with a simple reproducer that I can try in my
>> own lab. I'm sure they can quickly get to the bottom of the application
>> stack to identify the misbehaving interaction between OS and app.
> 
> Do you know where to report to?

You'll need to drive this, since you currently have a working
reproducer. You can report the issue here:

https://support.google.com/chrome/answer/95315?hl=en&co=GENIE.Platform%3DDesktop


> The reported stuff are no distro
> packages, and I myself have no experience with them, hence have no
> idea about the upstream development.
> If you have more clue about Chrome development, it'd be appreciated if
> you can report / ask from your side.  Of course, feel free to put me
> to Cc.


-- 
Chuck Lever

