Return-Path: <linux-fsdevel+bounces-57781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D7CB2535D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 20:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1945A5315
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38F2FFDC3;
	Wed, 13 Aug 2025 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cS+krm+r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dp492Xko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7705192D97;
	Wed, 13 Aug 2025 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111285; cv=fail; b=mYfbfngToji7OSFEEkfLWLZMfPcmhLdNPNfu5JLhy4vgfV1ovJeM3RNgNz2aAKxXaw8aO148U9FGNfmsQtsAVeJmt87gfYbLqUFq1SFrLVmiMyPEMb51A31hTHwPx4hknIHLMnnI3Q1498Eod3WSHwVYXDvSftTu62+mourj+Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111285; c=relaxed/simple;
	bh=MUgANSvZ5mo+eveBlYyi6C8m3ifBCSDLxDeTjP10HAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=seuH5OaK1t6xQXjZj450AEWguuVgvf4lyvbSMwOSja16TPoOtiowFZVInh2/7glxbmQUZUy3bIYOEk55HWwLhp1T9r+izUE4Un57DrPFWS4SXPr39w+rnIlv5366UYlDw995cft2FOoAt+BQhXQWCZIk+VzMmG65FEjVFissa/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cS+krm+r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dp492Xko; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DIN1s2020802;
	Wed, 13 Aug 2025 18:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MUgANSvZ5mo+eveBlYyi6C8m3ifBCSDLxDeTjP10HAI=; b=
	cS+krm+rgGka0G3KMzM9shK/xr+IY3xBvi28eoWuqN7wMuqYPOaum2tWle7EfdUl
	yulA8ls2sIHjrXScvaCBGzTfI9DzJNuNnAkAZErmgxsWdOx3cpxjHIq0P4+suDaq
	Rc3K3dtzcHeEL8+BNM9aRddO6F1lR7cOhHoNosrnxYoJU14G7DBywalCoICMCAym
	GBii5rJ7h59CtHBD6/H1mlV2CYUXXcK8BJZOlNcEVjvz0Qjf/FpOPNjZxWxnnowh
	6tPGem/nkmIBsniYbjwlTrDogwxsf5Az1bgmQ1nR+HWUPnzuo++uqw+TfUzQPJpl
	K+Onr4adXEH8Q1f4gi/boQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dr4hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 18:53:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DHhp0C009843;
	Wed, 13 Aug 2025 18:53:49 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011036.outbound.protection.outlook.com [40.93.199.36])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsj3h67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 18:53:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8zgVkT2fcQDImqCZ6IyI8eCGK7+fpNRY5U4x/cCcQ3V+XoiC4Rg2YVJT2EATSF90spTrc0EzY4F73ska6WEP22NxxkY24+BugdbT9zYZVbNzDLsc6jljDv14qOE3GFMzevNHP2fmEUR/ZwcEmSleQBY2Yj4ZkPPUIrrDhefTnJpfajtYJJqKmQJCeJTt4B0QRskdh4IlGDiiFkDuS4Cx28+3QeU+vE7nk/i63AvaQYNhBQ6dMWNOeXDyvqJiLazbWUjS4D7M/QSvdGwATwMG5T0Ee+ilAIKuyeq1LHjnSy323MvcZehVFhmVf/Y3ZXLRsDb/+RVqGUQqLvklyUHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUgANSvZ5mo+eveBlYyi6C8m3ifBCSDLxDeTjP10HAI=;
 b=jkjYGCFFJtd2CId9dO8NWF3+K49EQPorC6V1xgeoMYNxVJssWw+W0L9IjC2pJCEXwDC3YwQ23j56LI9mTK9dhSnBLgHrbw5Q37xdJAvoAQpKUBrasnurDnPb00AGQRuEh5cx8/27lhTzVtjgLPRVRpj/m4NezMMmVODJ1f2mT18xZ9xD64Tn/wc9GktFZikhpoL8GIeh+2XLhuBYnHUEbq9wPfDV9MRj6LuY6ODRuZOj3HrxC0LDDSif5zCnYoSzUJMLVQ1VD54TDolk3aZcRvkaWHclSE9PDIM356Lmf9mQQ404RbFsFj8fyl3v381S3qarg0PDaCOolKYm8KNneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUgANSvZ5mo+eveBlYyi6C8m3ifBCSDLxDeTjP10HAI=;
 b=Dp492XkoYVqzEpWi7Uw0wHhaRt9u/JrMkh7Fi5wmoWnQidps+X30iGjuB5IoG4OnKmf1JGo4Fg5mUIIHUKgsusqZyvdKG1u5mbgv5NVOAYXWE7nRBbJJ8TuK87NOJFXdMtsqA6NDCH/Z98kt3AL9B/+ShugXuJSlSSCcUpqfcao=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4122.namprd10.prod.outlook.com (2603:10b6:5:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 13 Aug
 2025 18:53:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 18:53:44 +0000
Date: Wed, 13 Aug 2025 19:53:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4 1/3] selftests/proc: test PROCMAP_QUERY ioctl while
 vma is concurrently modified
Message-ID: <36049c3f-94ae-4bd2-9425-68649be92b61@lucifer.local>
References: <20250808152850.2580887-1-surenb@google.com>
 <20250808152850.2580887-2-surenb@google.com>
 <7d3b4b0c-f905-4622-95a8-e4d076dc71d4@lucifer.local>
 <CAJuCfpH+Mg7P--sP7LmhhUgGSU0AwmoJLYGyvft5fPC0Mz1P6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH+Mg7P--sP7LmhhUgGSU0AwmoJLYGyvft5fPC0Mz1P6w@mail.gmail.com>
X-ClientProxiedBy: GV3P280CA0092.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 305ea28c-d6f7-4ec5-94bc-08ddda9aba74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDBjVlE5TkFQWTFaMGlEUEF4VlFqUjdJOHU1aXI5ekx4WnVnUGZhLzZHZmoz?=
 =?utf-8?B?d3FCd1ZFcEc2eS9ZZFBBTVBPbVIzVjZIeUFYL2ZMOWZZZ01YUzVDVmdhdlBk?=
 =?utf-8?B?OU9TZzQySC8vdUNkMnBrOGVON1hnZnZISEJ1dDk5WGJtQnJPNVZkMTZjY1Ev?=
 =?utf-8?B?VzhOem5zTmJVR29jTnhVQmtyNmhudDBZNkRDQ01sd1p4ZGpIR1FHNHhBN0Vo?=
 =?utf-8?B?QTlxcy85Z0pUSS91QVlEYlVDRlpDRWxvVzZCU1VHY0F5OTRUMUs3eWs1TkxN?=
 =?utf-8?B?b3ZROW1OOTY2bE0zaWVDNlZzbkU0ajc5MDRWU0ZGcWFqZnpnTTh2V2FWVGdK?=
 =?utf-8?B?eTExckRoV2g2WVIvQ3pkNVJrUWwwV3NLUzNDdlNZcXUzTnhIRFN6S09jUGNZ?=
 =?utf-8?B?VzljWlhvUURVcE9MZ29rZmdKRmI5c2tEa0ttZldNVi9hdmlvb0N0dHBJOXRt?=
 =?utf-8?B?eDFzTWFJSVNWQkxjUlZQYXZYTjBaWmdrWDlHekNDRVczRmZudHM2RkFMVUJv?=
 =?utf-8?B?cVArNlIzaVdob0t0UkhzelVZMDR6NTVpVkVPMjk4R2pZY2E4Qk9VcDhuL2hE?=
 =?utf-8?B?aTQzR3ZROTFKSGljVjRQdGVJbTRaRGZnSFFkRHAzWDJXMVI0U3VkalVUYTNL?=
 =?utf-8?B?Yno1VFBRcFJTZTZxU1ZjUTVxTHRLQ2g1U3piTUd2S0l4dXFxNCtkNkppY0dI?=
 =?utf-8?B?SmVyenZBMkF2ZTYyaVoyMzBNbTJtN1F0SVU1azIrSWdYQ2RKZDJBeHcxd1NW?=
 =?utf-8?B?OFlrOXQyaFYzTS8waHB1WC9Ielpzc1ZIRlJSWGRZbmttL2ZjellWaXg3NmVT?=
 =?utf-8?B?OFR3QVl3aGNaenFIWmFwZFVQVWgwVEllbkl4VWJjc1JCcHJqNlA3RlhQUndX?=
 =?utf-8?B?VXpHaEVYZURyVHlvVjFDWmV0RmlFdmtvNHNMcHIrOVZPbCtZTG5LbmQra2RF?=
 =?utf-8?B?Wm1iTjZDUW56VUEyYm5XbkNjaFdZOGg1Z2o0VUNHRTBmMzg1Qlk4RU1ydVJP?=
 =?utf-8?B?bS9vSjJRanR4NGhtVXhwbmRKbmZhN00wNkJmZ0dBTS9CU2twQjRmWG5SMTBr?=
 =?utf-8?B?MGd0bmg5cno4NGw0ekQ0QjBZdm82SmdkeExQb29DVytEMlUwVDNLcWhwbitQ?=
 =?utf-8?B?UU1vZ0hxRDAydGMwU21aamJzRnRiejl1MHVBN05PTGtiTWFyTFhaVnNyd09K?=
 =?utf-8?B?R2c4enhSbEEwWDlZZGYyL3NTNHk3UU9EdGQwRGYvYXU2WE5xS1F2bzVxMkw0?=
 =?utf-8?B?bFVSSDdwSVRmQlJQOFRkd1c0QVFKZTNaVXh6bEYxN20rVUVzWWIzdTVZRWJR?=
 =?utf-8?B?WGdBY2lDSForOUFSR0lnOXl4ZHNOb1YvcWRad0RGaHpMYUVRdEVySWljUk9m?=
 =?utf-8?B?Z3h4OHIxQTh0Nlk1TWxsbDZwZUN6T1hsUTdiZEVQM0hGeHpmM0t5clpFb0Q3?=
 =?utf-8?B?WWppVHZscnl1RUJwN2VJOFZwRzFYL3R0T2tNMnhkbmZTaitBM2NUUGlsZzFE?=
 =?utf-8?B?REw5V2N2bDdIVnd3alBic2xZWGZhN0tmVVV1cVRJQ0lkYy9ITVEydUFaR0ZR?=
 =?utf-8?B?R1ZhS1FTdFpGaHRyOFlqZVFQdVZWdm1LL3pHL3EzeEN3R1g3SGszYURhTlFo?=
 =?utf-8?B?Y1BtSkFJVFJTV0NsOHBPbG5IRXgwRysxRVNFRkNManVMVEQ2T2FjcTRaUzYr?=
 =?utf-8?B?N0RieWJMOFM2K2Q4Nmo4aTMyS3lZNXlXcmZKdEdReFl5cHFSTWgxUThqbDZP?=
 =?utf-8?B?Z2QrSVhlWlhhdlNGMFQxSnYxVXJyYXZGVy9CRHBYTDZYR2tnbnBpZ2tvaEVN?=
 =?utf-8?B?NGFQaEdVVmJNS3ptenFadmw0aGlMZUV5VUdEU2syWkI1ZG13dC9MR2ZEYVY1?=
 =?utf-8?B?Y1puc2d5SjFsRzNwcFd5dEFmdmZ0VlBBMWlaUlNDZS9vWVhDV0lHS0paekxG?=
 =?utf-8?Q?0mnfJwhbPM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1ZLck4zNjFScnV0elZ3bS9kMFlBRlZBbDNWaTAyNjdPWFoxaWYvNWZqSVkw?=
 =?utf-8?B?ZFNyL3pXeWFzYnhlSWxBWUN2WVRjS2had0pNNFZwMG5uQkN3c1FFM1A1MnVl?=
 =?utf-8?B?QUZvUENRT0pUUERCYlFyUlE5YzErb0E4QWhNMFNUd1p5dmZUdTF0V25Qem5s?=
 =?utf-8?B?RVcvSDIrMU82dkZYMWVrRk9PVHIyQ0JVem1uRitoaHBnNklrcHpiMVRycTZa?=
 =?utf-8?B?M1lrTVVvS1pwWFhLNkhjdHdScWluamxsTHFsTFRxZXRHTmZnV2QxOXFUQUJJ?=
 =?utf-8?B?bGoxWGVHczJsRVF6VEpKcWZIdTJZSFk2OUhsOThGeFFMd2EzMzZtdy9oQnBT?=
 =?utf-8?B?ZSsrNUlpRG9za3FITUV6MEQrZjdGczV2S3lnSXpPeGYwNDJ5ZlFGZmJUZXlt?=
 =?utf-8?B?bHY5N3lQb0FtckdOV0hPVmVpYk5ZNGhXRmllRTBQTi9EUSsvTFhoNnFaQzZ5?=
 =?utf-8?B?YmVoYy9Fa3VEOG55U0psQWRUUWV1anRuZld5NmlISVU0YUNNdkRTUXRWZnht?=
 =?utf-8?B?RE5xYS84RThhQ3pITG5iYi9Jb0JSbml5dzdocDhNWlRFK2huWDg1UFpldUFj?=
 =?utf-8?B?SG4xazNBTkZ2RGREanN6eTlNcE15c1p4SzdNRm5tdEF5NjhCWUlnWFVGR3Yy?=
 =?utf-8?B?YStxdXRyZjZTckJvWmtQSHQvV1ZsSG1UOWp5b3VMa2xLSDFYVjlIaDJsK00y?=
 =?utf-8?B?ME9RR1Vaak1DZEc0UWF6WDh3dVAvREhJNTY2SVhYT3psRy9sY3FvWGlmSktq?=
 =?utf-8?B?OXVXUHJlZDFXWVU4M3dXd1FnbVU0Vit3N2RUUUwzNVgvU2lEN2M5dDFPWk5M?=
 =?utf-8?B?dVVQSmNaeUt6T3dlQ0JKMTBXVjdBSklTZG9RR2RhVXl1ZVg0dlYwQkppWlVG?=
 =?utf-8?B?NEtHMnRGRUZ4ZHNYYnZSelczK3laZFhRclVIS3dSTk1kRi9IL0UwdXBVeEhW?=
 =?utf-8?B?Zk9lSytrT2hJRHJ0NW9UblpLK2NOZ0ZFeWVENG5DdGZITm8wK1psL3VYSmJl?=
 =?utf-8?B?SC80M2FNczNZeldzNHlqL3ZDNUcray9QcmhjZkxwSXdmZnJMQ0pLdm1GNVVa?=
 =?utf-8?B?TmJlVDNsdnJoOTBVbjg2YmNmUGdTOHJ5UlM1YUhvUmpXMTFWRHBjWnNOUzcw?=
 =?utf-8?B?L0I5aDNTV25jeStzNU1rNmdRSUtWOFBBblR0MWZEOVFhQkRXbmRwMlZRQi9R?=
 =?utf-8?B?SUFZbVd3aXNoUmtpYkJWTk1HRGFGS2J2WjhjSjdZeVJMZkhaQ1NKUHhrMHkz?=
 =?utf-8?B?WFVjL0d2MlMyMFFZS3VtMDdYQ3J6ZzZ1YmF1ZjdLdnJRd1hSbDZCRVZPSmQz?=
 =?utf-8?B?N1NLaDgvRUEwT2RlWnNaR0k4MmZodnZkckJPdUFrRTZXbWpOTy9ENTlxNVM4?=
 =?utf-8?B?MnMwdnNQRFp3TDc1YUhpTWlxak8rNXhHNkoyL0tzN25DSmJ0clU5UTdIOC9M?=
 =?utf-8?B?V1hIdG5ZRmhIR0J4WTJTajlva1J4dGVtaHNwS0toSm5WbjFJbHpIV3U4dlkr?=
 =?utf-8?B?MWZ2VXlMTU1Ua2ZQbTRaSnlmeW1xKzd2UGpzUmtaTWRNWlNwWVBHSDc3RXRO?=
 =?utf-8?B?LzNWWU1tRUEreXJpZ2N1K2NQNFZtYVBxRFlqS3RaRFZ6dnZNOHJ2ekluQjJC?=
 =?utf-8?B?b3k2OVFNdEU2VVZRYSsxMzAxb0VZa1RnTWJkZTl3MVF1SVUvZWVsMytxTFU3?=
 =?utf-8?B?WmRpcHNEMlZJTCtTVklvYjJmcXJ5eGhLZlpHVzBQZjJtMXJuemVFZGc0cGNp?=
 =?utf-8?B?RHQwVHppWWFLSXdqUzRFUnlaaGpqSjQwNis4akNyWFROMFVLRVRONUhHMDF1?=
 =?utf-8?B?RnI3dTRkQXpZQTBWRVhjUFZ6akdwcUVmYjdiZEE4c0NmT3YvZzlWMjNzTG5x?=
 =?utf-8?B?TnFVTVFpNXk1dE5Wa2hZbG9GZ0Z6V0UvMDBqeUNCbytsV1Y4OEZzdUUyNlAx?=
 =?utf-8?B?M05SK2NCVnJxczBuOEExOEx3MEN5SFM5OTJBeGh5bElOZHdrSmYyWWZJTjVG?=
 =?utf-8?B?NjRKbWQvdkt0SjQrdlFXZnNqZi9SR29jY1FtNFJSVG1EVFVvWENGZG1acXNF?=
 =?utf-8?B?V2haQ3BIZjdNb2RTK0hBMW9WeWVjM0JKOGQrZURONFdLTWwrUFJ0VEdiS3BV?=
 =?utf-8?B?a2MxM1E1aEFpQ0Q1RkM0TWhCckV3ak50dGJRa3lNcVc3RzdwTXhocHVLSzZY?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cHEFfjNukBYuCsG28UwRaHcXNtLlK2yZ2BWxn4KOMJUtl9FggTL5WlMb4YWvXQUFfDswFB+lDFLuPA+CVY3q7veazWssGYcywReJudepVV5RMwrrQ+p1jAbQxraB29xXDciqPH1ZDhLihQI7XoM7sP0LLMLnmgLUHVT4OuyDKEnn31YDfI0vf46qosrAQ+4A1yXzYBVxCY4ZvuVg67960djbAu+qXXD3FKxPPkpb22GuzShAlrqSk5J1M/zYoRJGET7hTholYmtAMXF7WD4ZSLy7ynMN2P6GEUGe8X602S6v+KAx/iX/vRIVVpoqnQfllfBFw4VpNZ0gcJTDDMToY5a1+GIlGkLbMjrjThanpzbNb4FRY3RP6+QLDtaQrhhU0WaH53CNWLYRkHWTWxP138a+CMIg5ROfjJIMyX9jSy3KCSuVQBTABK7/nkR2mvQ4yNzypbUFMxYk6Ssqky/U7E2vinevh0ew1GKa/x6uUrSEVuG9+8NDKafitAe8CtjS7aRGx7aO8TiV3pEAiM8TRSdN0O9xbop4vgzrb5MhHUmzAAK4j0Gqne4najr+BKpc+lqAo3+QFZRKHbKNNWjhlwXNjvUU9xdSdKLgYe0/Ils=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305ea28c-d6f7-4ec5-94bc-08ddda9aba74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:53:44.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiDz/+FMGC8aD808lkw62axv8g8pXmE9ZbwCPplSk4H5ba7Xc4e5opwbFZxoEwl0t6T1/LYf6Ma4wqvMl4U+ZbVcqqK9oSFpJjXNJuKYAgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130177
X-Proofpoint-ORIG-GUID: _kKp3q1w4HkOhMcfjZoyoRlSO30kAFlt
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689cdf3f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=6-8YGsThPIWc6biHcAgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12069
X-Proofpoint-GUID: _kKp3q1w4HkOhMcfjZoyoRlSO30kAFlt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE3OCBTYWx0ZWRfX2XkXQNn2AFwa
 y1UvkyvFeKn4CELSCUISE/Wb2CcvXDNufudTCwp8nnjLutSKQeTnrPkwPIZwUnYfo4i99Yaiys3
 2yGVYFaW5lmJfV6g2uIbmZXvRbf/hbrwQRdNxWeRW/RdJl+SbLP3D0jDU8Vjl0iYZ+vUNYrfdX0
 ydU79w/NEnaUr8R2XFcfkfquTq+7asS9Zb1W5rIPuaQR71GsKvLvrn9JD7NYJy125xc6bR3Irxm
 MjN+jhB3+PVTG5afK7HJw2BA8p9fcjt5KTXXjM+Bn0VlS+Ua+4rU/ybMyvfF9hTvJiDnj/jntny
 eeLsYDvPyES6y2jfyQIxcxDeTQfQYKwqMHG5CyA2o7vfy64sqW7rrG5wB9IbWSuSP+x6ZHcKW/+
 9btwjxRUlKr11esJJy+/lWNpekS0LAWdYCK6a7e+mnhwoFDYrALyCT8cqkR/G1iUij7Dbahr

On Wed, Aug 13, 2025 at 04:21:47PM +0000, Suren Baghdasaryan wrote:
> On Wed, Aug 13, 2025 at 1:39 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Aug 08, 2025 at 08:28:47AM -0700, Suren Baghdasaryan wrote:
> > > Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl operation
> > > correctness while the vma is being concurrently modified.
> > >
> >
> > General comment, but I really feel like this stuff is mm-specific. Yes it uses
> > proc, but it's using it to check for mm functionality.
> >
> > I mean I'd love for these to be in the mm self tests but I get obviously why
> > they're in the proc ones...
> >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Tested-by: SeongJae Park <sj@kernel.org>
> > > Acked-by: SeongJae Park <sj@kernel.org>
> >
> > The tests themselves look good, had a good look through. But I've given you
> > some nice ASCII diagrams to sprinkle liberally around :)
>
> Thanks for the commentary, Lorenzo, it is great! I think I'll post
> them as a follow-up patch since they do not change the functionality
> of the test.

No problem, and sure that's fine it's not critical stuff obviously :)

>
> >
> > Anyway for tests themselves:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks!

Cheers, Lorenzo

