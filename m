Return-Path: <linux-fsdevel+bounces-67143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA04C36366
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D216269C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97632274B;
	Wed,  5 Nov 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZOjllLA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HO/Watgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE3239562;
	Wed,  5 Nov 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354416; cv=fail; b=pgHOjtss5bQeXZpp9sJkbLo5U9M5hAEXY3Dw9v20drcGaFtv5w5SV3pyYpnBIDVqnEnVRXGGkzXOz7CreljRJO87ixWYkDSPCf/9D7vR899PvcXqGHFEyO1Lz/KFmOj7e1ESlRGICXlC+3Y/eTqRxElMS3abT23+Y8B9PEoxN3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354416; c=relaxed/simple;
	bh=gKRVzmMRlTQA3h6lrXQbfpqELs5BHeaCmiexcrwAwho=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KvcvyhxxmPM7cGY0DUB8NfgzQgH+v4p5ue4gVg/kKVpGWc+c3T/MKc0P3D0Twdu+C81Y11yh0mKzu3R1k04rq4PAJ+d5TiPmRcWh4HJ6wUQ77uBC9uHfN4W1TEXY3QIriaBQ1Tb86SJxOhLOGR0sFe5Fbt5JtLeUqt/IGMXmGnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZZOjllLA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HO/Watgm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5Densw005799;
	Wed, 5 Nov 2025 14:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ADZOVbb19R+45f3N1z4YgMO2qePyETNHpm2E2ndUgsE=; b=
	ZZOjllLAbp+4aVdZlUssXqZUe0OpDPDq7r4DGzYBqkxO8ab62xPYoryHuOhgs/Ge
	MQYa+1zflUdPfUmnM3LuUe3hDt/dNT3PceuPL8lLh6lDzSz9KKd10DHXNZQw67pu
	MAyzeS+k8w4PBVsT0xU3OuMPopH035+ijQHVT7WGGMGjqzOuwzF3QyYXkComMa7E
	R+t11x1bbMwFAYRMbO1xKRblR+U44A+yg5dOpf38CYvUrrZWUN0z9YZs813Qv4c3
	bHdq7+OM/7mNl/6FWGrNuPJyycrKIuyMcpcnGLxVmIvCtUI0Fh+stMVGce9gC4sh
	Djkfz99QYfzWKlvWBBbuAw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a87nfr6rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 14:53:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5Eht7T002696;
	Wed, 5 Nov 2025 14:53:32 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nemma9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 14:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOL/gqh8cgvKd8EG8MJV/3u3BVm5v2FCYGXUcUTtFA1RSOQK5y7gR7bJ8iXC34QWQallxVOs/mKrzBjJjgu4mUYdrhKXYbU1OI5w+WJUgfEV1ClCoU0bn+QYQ9cV7J7jx9t3c6GH488ha8xmkDDlZtPQmEq2y7co/UuDFCpBwmBc/LO8ST/p6kDbNnHgGis3sgHaTFbVmIsCNXz7zBLL4WjCnIiz/T9L8+OkZ+x+EddInbMWRWMsBtwu8ohJQ+iRlZhDw+9XCSXUKzPwoai3AlLyUPfEAyqJsTdcDHsPaJdXjx6WVJ6ZIWokOB9RPSoFnhXkd3HzdhDVcwYitXdlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADZOVbb19R+45f3N1z4YgMO2qePyETNHpm2E2ndUgsE=;
 b=kr7bEHhWxfTC2eeJS4w9+owxMJAY6EJ4dm2Hej0p8lAsEo+N104nenkp9OGDY3e8VEWG8nhwJRIIdJu1H6l5hcXE+zapajoeBDqPgQLDKxvT2whqhWq7DH8UfnLckuemu0Vf5YhWTmyFXpKt0PrEspIsXrzZ29Md8LVUx0AmigGFe3OpLhFvS7Xt8f6aHaKafWX/4csHEcef9QYd8ghFqZiZfkPl9S/XEgwOGfORY8HR/dKKCvWLNoBUz+1+c4o+f1hgw8wtZsKMs4P7EBNnIb2pFzbFymlv1FVhF+Sp8mqZvKNoL0EtuBmjNWpJ/9PIXxlPAhsVfjI0aDtC4+2Svw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADZOVbb19R+45f3N1z4YgMO2qePyETNHpm2E2ndUgsE=;
 b=HO/WatgmtGIzDBP6vvFafw77Kcw6ZCNYuUMF026OVbHwc5K5IQitdB+V+jIKqBmP5ku927KfofurtYtjRaNT7uJjZE2lFnXqy1rc+SP/oEOuslpGI/5+q+Vjb2oE7ctd6zFs+UiQJunaGRP57HjE5+cSrqnMc4CFisksNxTpKHo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7020.namprd10.prod.outlook.com (2603:10b6:8:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 14:53:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Wed, 5 Nov 2025
 14:53:04 +0000
Message-ID: <21813208-da86-427b-9e6b-4ecb066e6763@oracle.com>
Date: Wed, 5 Nov 2025 09:53:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4 server sets/gets FATTR4_HIDDEN, FATTR4_SYSTEM,
 FATTR4_ARCHIVE attributes from Linux "user.DOSATTRIB"?
To: Lionel Cons <lionelcons1972@gmail.com>
References: <CAPJSo4Wa4EGCTQhfK7O9S9O7rmkb5aQHg85_R19FJHqCGi1Usg@mail.gmail.com>
Content-Language: en-US
Cc: linux-nfs <linux-nfs@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAPJSo4Wa4EGCTQhfK7O9S9O7rmkb5aQHg85_R19FJHqCGi1Usg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0046.namprd14.prod.outlook.com
 (2603:10b6:610:56::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee29b8f-774b-4ccb-70c8-08de1c7b0633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVYwT05MYnB2Uk9sZEgvUDM3VmJrSXRPOGNkTHBGalJITWgzVWVPbHJva2px?=
 =?utf-8?B?VndiaDdmeG5QZDg2KzBHNUhXR0JMSlRrSTR2RHBrMWFqSXM1WEhVa0pLZ1Qx?=
 =?utf-8?B?d2kzMjlYUWUzQ1ZGbFVVVVk0TkZJRlhNZkxkRlFtM0dKMDBIM25kNHJXbXBw?=
 =?utf-8?B?SThhanJJbHVvdHlnMU5RZG5GakZ4eTVRL2NBYzlXU1FtYkpqdGJOdU9iZGNx?=
 =?utf-8?B?RXBWaFhiSTh4U29PQUJxUHc2Tm45N3NwL3k5QkFSVGtyNHpBU2JEK0kyNExS?=
 =?utf-8?B?cDlkb01VcmZ0NkNKYUI1ZjNYdTBwRTVsSzNnenAwUjM3ZEJpNDkxcCswTEZj?=
 =?utf-8?B?TWZIQ1NnbmNwQ0pTS1Y0VG5rWC9DZHhZb2Q1dzFNdlBFK2kwTGQ4S0ZHN2JD?=
 =?utf-8?B?ZWU3aEtNaFhBWUdaTTJRdE9zVmpJQlRKTmRTVk4rcW5IdHl0Q1hPZDF2eWUw?=
 =?utf-8?B?cStlVnVWVVUzNFlkWHU0M0ZZeTRZU0JaNzVEblhWSExlZWk3V1oyT284QXJB?=
 =?utf-8?B?bXdVT094a1Byb29mVCthbHlJb0hVMzBzTkNXQTBQLzhXczFoY21QNGVKeXpk?=
 =?utf-8?B?V05uSVg4b1RuWlNQdUNValhPY0R6T3hYeUtHK0oxUmsyTGQ1N1I5cGI0YUVn?=
 =?utf-8?B?Q3d4R0VYdnVnZEU3a3ZHU3EwVGVLeFZ5R3NnZ1FDVTVzSmdJa051TFh2Mk1K?=
 =?utf-8?B?VUtnQ1d5UmMzL3RLSUFYZUVSeXBDUFl3OFNDY2dNb0x6cmRmdy9iYmdkQzIv?=
 =?utf-8?B?R040WmF2ais1bStiZDhuSjFjR09vOVhuZnV6QlRMWktyMnhzL05qdzBVNFl6?=
 =?utf-8?B?ZUcvakdUaG81WThTNHF2aDFaVGdxNzNtZFFJUUpsT01HMjJaRTVzZE10OEtP?=
 =?utf-8?B?QXZoUzMvZ0t2SHMrTG1uWjZCVy9oT082OTVQSUkzaEV3OUlHNFdraklwQUZy?=
 =?utf-8?B?VStvZHNGZktqdk0wQmo3VjRRMmd0TkxvTEsyZzA4WE91T250dFJjYXpENjJ2?=
 =?utf-8?B?UEY2bWVjYndDN1h2a1JEOGdjRTlXZHlMampCczNMRi8yWGw2UUZKVFlUdkxN?=
 =?utf-8?B?T3piQUxBTUg1b0FKRW01VllISDRoWEUxcEVzMUN6bnliOVJMTDZTMEMreTdS?=
 =?utf-8?B?UDVSUkNhRUJ2dE1jL1NBL3prMldIUnZ6clU5VjZiTjdweVNDRm5BeVB4d0dC?=
 =?utf-8?B?NG1vRHpteHVJL25sSmpTS0l5S2kvNnJ3cUZ3Y2hySzZIWkorZXFqRGhXNWpy?=
 =?utf-8?B?d21aRmtwOUlsYlN5dlJ5SDNOb2U3LzZaNG83ME42MXFTZzJtUDdEaWZ2Qmtv?=
 =?utf-8?B?REhDUUJudEFPQmFlMkl2ZTV3VFdtY1JiL1p4SWUvajMvdFhibjFUYkxCdk5m?=
 =?utf-8?B?ZzBJWENLelEvRmRoYUZKZ2owQWZ0bk9uTkpleVUzY25rMWR3bEtGdE9RMitl?=
 =?utf-8?B?WVNGMzdESlRjMGNsZk9hNGdFbjUyR3VGU0RyTUZnMjU0aVRoWGk5RCt4dzJ6?=
 =?utf-8?B?NmUyaWRURndZbXQ2R1J0YmpKSi9lZDc5c2t1YzREalNpRFlSWGFyblJOME1j?=
 =?utf-8?B?QTRYVUZPQjN5eUs0TlhsKzd5Y2wwekhXaFpjYkFFSjJSUCtGRXZNNEp4b1Z4?=
 =?utf-8?B?QmFXdjkwNlprT2dVSEtVeGF4YXFwREVFakxQcmFOaG1qZCtsYnRuS1VnYVNV?=
 =?utf-8?B?NlVKblNGN2VTZjJCeVFWVFNNR2lxTHZYQ0RLYmVqdlRxQ1g4Wm8zY1JUTXZw?=
 =?utf-8?B?NGtsQ1BIdEFlWjIweWxVeGJNdHc5N3ZZSVV0bjlLNDRuemR2R1htc0doTFll?=
 =?utf-8?B?dUJoZDNmSGprUUZjV2t3VjkzVzhzRWl6MGt6K3I2T253QTJuODZKVzZBMjBV?=
 =?utf-8?B?ZjZyaEVDOXRlbzVRemN5QnJJcG44L3VyRWlmdWNQVFlqQWVDTXRMMVkxZWFi?=
 =?utf-8?Q?2hflpxhBliXGC/J2/0tWL/1md566LBoG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTByT3pTcCsrU3kwejJIRXVJM0hwSlRLTWJvVXFkdzNGajRYZHZrSUs3YXRG?=
 =?utf-8?B?U0haQnRaeTQ0K2VqTTBNbDk5Q3BQMzlzZUk3ZmY0QnhrUnpVdjBEREVVNzha?=
 =?utf-8?B?SVZiUnJYbkZvWGlVVmZWZGo2YUhpRzVyUVNVK3R1RUluVUxXYmhYcm0wSnFz?=
 =?utf-8?B?T2pENjJ1YUMyMUgzZE9mK0hHRXBMbHVRaVdLWUFjdkoydFhsanZrTUVDMUZ3?=
 =?utf-8?B?VUlVTnQ4b2FGSW9uMjRPeC9vQUxFbnFMNWpHSjRjc2xsVkw1cFdHaXBuZ1BB?=
 =?utf-8?B?VlorQkZwc1huT2QyN3N2eERNMm5NM2RZMzY0UzNUNVQxTWVBYklmWUx1ZmF4?=
 =?utf-8?B?QnFsZGhtRkhJQUUyZ1YrQzYyM1hTNHRNTWUrMEMwUXFVVkl6UFE3RUdheUFa?=
 =?utf-8?B?ZGN3N2ZULzJIaGJtNW0wWkw4RWo4M1o2YUJ3a3Z2bVRraUFZaUlUeDNOMENI?=
 =?utf-8?B?djk4a0dNeXdaRkZvR2VQWFNjeVdjczhiOGVYSXpCMDY4ZjFHTGxqZHlPWk1w?=
 =?utf-8?B?c2lLMGNDUEtDc1g0dS9xVjE1VU81MjZEdS9jc29XUTYxcUIwR1JZVTRYM1ls?=
 =?utf-8?B?SmIvcTJYZXNWK09SMDNqTkFSdUQ1eVEwZXNQQThkNFhxcEhpMC8zWGIwdzFk?=
 =?utf-8?B?Y28walVnWEhvMGFsZDFGWThSc1d1NzRwVUhKa0Z3d3NXZlE4SnBaUDBvTVEr?=
 =?utf-8?B?cXM4cFVDeHd5aUM0SjZ1bStlNk5kWCt1MmxXWWZoczBYQktmZnF3aHU1am1w?=
 =?utf-8?B?cE5pNlJXVmlIblNBSnZvNzZ1L2hEUUpWeE1XdTRBUDFBTWhrMUxoOWV2UVF2?=
 =?utf-8?B?aTBjQ3NBM1FnTVprb3NKZjZka2g2S212VGwxUDBJU3c4by8vdFprdmZqWWNV?=
 =?utf-8?B?N2FxTEtTaG8rcDVqTDRjdmtCRWxoVVlpSkYxbC81eEh6ZUplREpFQytKLzQ4?=
 =?utf-8?B?eUl6RlgrVmRMVk5sUmFtRVV1Q2plYWd6aUJlaGQ4ZW9jYjlMK3pHRjhoQW0y?=
 =?utf-8?B?NGlnMGRLZHZIUlB0aXoxd2R0bG5iQmtPRWQ0TFpmUkhCdlpxOUZSS21nVWgy?=
 =?utf-8?B?ZCtlOTA3U252MlFlRUJjMWFvOUZaelhxTks1U3JKaExNdjhneEtvTGxvQUNu?=
 =?utf-8?B?RGtLVEtGVmtaQ0t4d01Lbk5tWU4rbXlmdXBRa2pjTWdyOVBQRHdNTi93WVhU?=
 =?utf-8?B?UE9VYlptUXVMeUhva1VMdkZpWk15ZlprWVljRklZa0F2WG9NMS9DTm4xaXFv?=
 =?utf-8?B?eEVTc05ERGkrY0RJUkNqQWdGYTA0NWxhTEwzakdhbkEybm94b3AwWDdKK0ky?=
 =?utf-8?B?aUNnY3RqZG95RWI0MkM0MExRQzkzQkF3T2thZGFoZEdWMmZuWUFMeHlzWGJj?=
 =?utf-8?B?ampNQlZBM0ZUcGNQc3l1T25VOTh6REowY0duaGNCVEd1dVdNWnZjSFRkeU95?=
 =?utf-8?B?aU5tQ2lGbW9DTlBFcXU1b1ZZM3FadFdsQzlmQ3J6VXArbTlCQTBpak9OVHlv?=
 =?utf-8?B?TE9Zam5hK3Z3bXMyVjRLOGM0YXZMWHQvbUpmclRiaW1uNnFjd3RhT2RsRkNi?=
 =?utf-8?B?QzVnZFM4Y0szUzRmWXNINmpGTmxVc0NUeURLVGI4K0kyZURianY4MEw0enc4?=
 =?utf-8?B?U1hDeTZzQUI3OG5wamo1TExZU2d1RCtkK1p1TnBsQnVYVlptUmtGcFJabFRB?=
 =?utf-8?B?MllxZFMzQ2l5YVIzUzhqMVEydjNiUTJ1S1A1QVNDSzRoY1pqU2RLZCtIY0k2?=
 =?utf-8?B?NFNCa1BlNUNlZHlLMXVScUdwZk1tOEhjem5UZEpzRWpJaW5hWVRsRVRXb1B2?=
 =?utf-8?B?UXpPeEY1elc2RzRTWjZ6QnhGR1hzaHpiNGpud0RjODdVdjFldlVMVFRvZkdn?=
 =?utf-8?B?OW1jK3NDV0tnWGlWNjVDcnlJdXprb2VWS3lRbmtMYlJmQzduYWU5djRvZEtB?=
 =?utf-8?B?bGhESjEvZ3hXU1JHS0ZvTER1b2hZMm5KWEs5NUVmdG9PMzZxbDB2M1BRc1hE?=
 =?utf-8?B?U2U2RFpuV0M5emI0Q0w2dWRmMEpLSkZzZ3ZrOW5lOEZYVE5hL2pIN29jODIv?=
 =?utf-8?B?ajhWSVRIMnluc1JBbVdEL0k1RTJ3YkhINk9jQkVtSEU2Y3hRSG05MGswYzl3?=
 =?utf-8?Q?ikDcLHJ8AhAFJjIswuZqlQ23L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	11pi5hiuRUC1AmcfA5jLkSna5+pK92VS9c+VcZPNJd9mfzW21EJY3AU+6z69OOfVywTGCrzTEcZuWN8TwsOxl/eiPyiVV8pjzt81GdZ8e5Ybs704DGYEz4urR4zyscRxtwdK097e0jjtZLjnzq4D9CC7KvsUUbsAW5bEJ5j2Up5DPdmlKIAwcWRslXN/sqhStGrwbAr/8V0FQ5TLr9OlJGP6b143HFN+UBjxZgP9idJN0j0OTy+E+McMmlnjX+uwVom0d2fmuFET3zgXoMHqAAClgQ34Ay+Ji2QHmcghZ4DL1r/H/DtHusyU5gmUTxHM+WrPXipGWRfKeonExWqAo3nH05810ID1w9aQgAAimEdpPiF2Mbs0RfkYe2Q4TsERcpuIQS37BOu7Bw0CryPn1n4qhCDSrIxdEfCG9sIOtf/MUIHQcSno+dRtFBpQIWpL57S6J2Tz/bPWtKM2K+QEsPuxbor3etwOopl3s1UT0fd1/uFxB49aEt8k3anIG/DKSDaSEs6H+f2UswV5KkPFx39Id0/rlx82xQ7uuzM3xSn6vmECqSzsJdwlYYr68WE45Cw1BGM7B808BNyC2f4Ej/ac9VzrkaaPA8ICwiE3fk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee29b8f-774b-4ccb-70c8-08de1c7b0633
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:53:04.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pO0f/cCd9m4mhCuHyyDGJCr8TVGjxvM7JRy272A25l6V0e13jXzB7xAjNl7p/bqIxPa0WAV4oJ7Y8Ywioxt+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=779 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEwMyBTYWx0ZWRfX3rirFtgyVus6
 Kzz9F1xmXm4lBqZhC2ky+dGOHxEJ6GClfJKzhdXKDA5KbgY/H4FBWTpmhHfRIOClpIkxV78r71O
 vKhCsAAShbUCJvHiyLpsiTw7kRZOOvOopR03LxhTQ9NVE6eaqoRzOzKTwwsauqUJKvJX86ETtU7
 SLee5ePr9XpMf3J72i4ziTyDUn2IEZWnooo4mRb8La1agCASp70z8CXeYyFD5Sju2TY/XT+787j
 cisRe3mQSdjmNDjtZgf0sjl9XPNVnI7YNvbBDeB7sFwAf1yBvz+VcLOdao8TyMkRTbjr9nVqwhV
 IhWvQ4X0v9gtRJCYc1P+W34v3zQTyZrQ5KYUzbKqwCu2foK3ER0ROP+1mIPSr9R2eYIGcMK0kRQ
 1hDKpoHfD3Rh6jYLg48htq9ea2/MziNEj79juzQjBCIXEDWfOg4=
X-Proofpoint-ORIG-GUID: CSn5c8jwKcETSZjOIOsQhFIX_R4qtux5
X-Authority-Analysis: v=2.4 cv=YdOwJgRf c=1 sm=1 tr=0 ts=690b64ed b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VCnASw7wS2PUiqfvY1sA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:13657
X-Proofpoint-GUID: CSn5c8jwKcETSZjOIOsQhFIX_R4qtux5

On 11/5/25 9:47 AM, Lionel Cons wrote:
> Is it feasibe that the Linux NFSv4 server sets/gets FATTR4_HIDDEN,
> FATTR4_SYSTEM, FATTR4_ARCHIVE attributes from Linux "user.DOSATTRIB"
> XATTR used by SMB/CIFS?
> 
> This is for MacOS, MacOS X and Windows client support.
Of course NFSD can access that attribute. The question is: is that the
agreed-upon standard storage location that everyone else uses for those
settings? (I don't know the answer, so copying linux-cifs@ and
linux-fsdevel@ )


-- 
Chuck Lever

