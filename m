Return-Path: <linux-fsdevel+bounces-20624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B38D6338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0857428E6F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C1158DBD;
	Fri, 31 May 2024 13:38:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD39158D8C;
	Fri, 31 May 2024 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162702; cv=fail; b=Ry4sO89cKTCsggSUBlMYQA01NR5bGEqNOMD6Ur8CiEAmH0QraubdjcXhkFeNourgAHQONsxuFAckO7OBSjllecQ360g4C7/XSNDTyZkLxTxgtFIqV/5AmlDDsZeNNbmDS1QEwLAqU+LF8exKsQKFMKTIn403dNRhb1959cx5Vs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162702; c=relaxed/simple;
	bh=o6hLkgBDfpSaZlK/V5iWhrX5a5H7naH0BVGSpt2e/OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NAw7miGD1AiIJnZyMlAFCCemDsDjrPYtIgKuVShf42RN9QBF+VSU6n0QkcTOhNuygL2mtNtBgxwGOhxoIixggm/lqbqRamRxnYs/9JhQDz7zmwvCGzZgjNPq8nvO07sehE79KhGqX11ctITEo3DPcBkQr6FVajFkedAr05SsGpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9T2Uu019209;
	Fri, 31 May 2024 13:38:05 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DvQrtJnDqjH1f3iDi/TL7H+7wlAwUfGw1ZQW3ZVCVxOc=3D;_b?=
 =?UTF-8?Q?=3DMrAL8fM/dO55YlQkVFgITMWPKq5BlthsfW73nRT6G2bKSpqf1GjFLjnYTA2O?=
 =?UTF-8?Q?u9oqWIT4_tWu5vHqU84HLvsqXQGbg8XBTkfRisbA3VqPOJL9DTMnnU1sAEDZ2MC?=
 =?UTF-8?Q?ap/zfSbknzHzKM_Jf4WuTcRA9gehtBs940CbNeSCveTEffHrVgh14k/OWhoeGyw?=
 =?UTF-8?Q?g5BowEWrfxPpQipyuA0+_8VC+HAZi3mbKbGWpKLiaMG/H8dqRlPkwk8d4HlilRS?=
 =?UTF-8?Q?KSJDW59lxYjxQnZWBiRwMFrWt4_MMbjDmXxOJw9yS/2eqktfKG6WM1/niVGvbFa?=
 =?UTF-8?Q?YVUZIH1AGfH6ukcfnVGGA8uUUn9Dew3E_UQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fck71c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 13:38:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VCJnaK016239;
	Fri, 31 May 2024 13:38:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50tv767-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 13:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8p5b5nS8UGWM8ucdrme3NrB8JuvAeUGkFAdQ3trUPcDfooCWJVNOPpDuZBs/c0B78hkkazS59uAM0qrIYgy8ujRSAHAFrKdbVW1/vjDvsjsiregu+mEBKudLbXWXxowzH0cyIbVey7hDl/TMALgbH5pIYGQ6ww2RUm+QTTV43ZWXPu8tGroOK+nor4NOEOoB1m35KjqQP/550aQxlK5r0vaEqc3Ek+74H2r6MRrLjHFZVOis/YKFeMQXD+Yd7SzwXG9jCkY9NUh+GgfDUuWMsZ32eYcaMay+qRMUMswBNZ4rq2UDrlfDO+mjLrTWUwLx5c2mDmnb4FIm77zQX20Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQrtJnDqjH1f3iDi/TL7H+7wlAwUfGw1ZQW3ZVCVxOc=;
 b=F3zlrgQpPbwAovnqmTG9/RARKc7kufymWYTY9uE02mtFPFy3WNd79ZEG/0weLHHcCdYFC4df3lE8lpEMK6F8ead6Rjwmpn6Swc7b1soDU6ZnBLGrH4Zo3I9xuLcH9r+JAQRS4hrXypFJfxA9ZMSr2gX5zGKGszgMReaE09/brDkGY4tS2AUtifamc1AtoORGm/hQ8Ua13izhwibtaCwTFbYyWIOsKMS0Vm0545RG9IuS0OltVnGludI9DmSSwOcR/DDqzNG6/E20wkWNmSXxozlKG4+RKWVQLGGABxoLULaXxSVuCMLtVpIWhks17tUxD0qgze/UljRQpNAawcnLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQrtJnDqjH1f3iDi/TL7H+7wlAwUfGw1ZQW3ZVCVxOc=;
 b=BmAzbJTdN+98vJGlHKA7SwL0rcDg4BhU6RU+0oU0coQhv0BlUUihfLMfqcPJl4tzrV5hVYypjCzTTpxA6B8k0WqxL+cutTMvKdSmGaVXSeid4NS4DCROEqp8aGgphBXUvv4k34qQt8m1O9m1/8+YBN9npuS0wE04Gi48utPnWnQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB6515.namprd10.prod.outlook.com (2603:10b6:930:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 13:38:01 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 13:38:01 +0000
Date: Fri, 31 May 2024 09:37:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-mm@kvack.org, surenb@google.com,
        rppt@kernel.org
Subject: Re: [PATCH v2 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
Message-ID: <gkhzuurhqhtozk6u53ufkesbhtjse5ba6kovqm7mnzrqe3szma@3tpbspq7hxjl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, surenb@google.com, rppt@kernel.org
References: <20240524041032.1048094-1-andrii@kernel.org>
 <20240524041032.1048094-5-andrii@kernel.org>
 <eciqv22jtpw6uveqih3jarjqulm5g3nxhlec5ytk2pltlltxnw@47agja2den2b>
 <CAEf4BzbphUBPnA7iDz5pis17GRwzpqsduftV_JHyf1Ce0MMqzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4BzbphUBPnA7iDz5pis17GRwzpqsduftV_JHyf1Ce0MMqzw@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0327.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 028757c1-191b-4748-f994-08dc8176e3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b0NIWnFJQ3g3ZFJZTTZ4TlBXejZ0WDl2SzBaa0tCamhzbDlUYkxTajE4VTFQ?=
 =?utf-8?B?bENJWFFUUGRER0tvU0IxSU9zSHQ3d3E4YS9TSzF1MUJUTVFZZ3FrOUVucFFu?=
 =?utf-8?B?WFJudHRYbU5BTjdHb0x5Nmg4eFo2ODV1aDFLdVRyRUVzV3pjWmY5S28yUmFE?=
 =?utf-8?B?MkNoM2R6czlaV0R0N0N4NGpHVkF2emplaUZET200RW9YTENTV2lUYVVUNFVm?=
 =?utf-8?B?Z05CTzlkd3p3MXJYMjJtZkVBWi8vTzlJejMxdU54aWtXRE5iQ3Rjc2JteFlX?=
 =?utf-8?B?Um1SM0NhTDVBT1BIdktXNTg3T0k1aVhaUCtPOXlGeG5ZdFhtcnFZbXozbGQx?=
 =?utf-8?B?K2VUOXp6WHgybWovVUdPbHdnSDBZLzlPY3QwakVNd09WZ3hCYSt6TzdKcEtw?=
 =?utf-8?B?OTNBN043eExZU2ovVUU5bFVSTjFrRVFLZUNCN2ppb0haY2RJSld3U1BVNnZ3?=
 =?utf-8?B?a3FEcFAwSFIzdWFjL3JZRUVxam5MSFZEWnhidk1UTDJJMmJ1RDNDaklBSWU5?=
 =?utf-8?B?RVJWT0Q3bTB3N3EvVElhOXdyVlQ5WUdNeTZrUVN3S2lGUUVodTA4VU4vWVV4?=
 =?utf-8?B?alFDMER4c2dQeEtwU25PQTN4enZpdk1Mbzg1U1hTTFY1a0lBcEMrQVNUQmFU?=
 =?utf-8?B?VkNqSmVibGNXWVNPQlQ5OEZLUHlQbGJUeG5WQ2JKT0MvN2dlQUJkMXE4NkpL?=
 =?utf-8?B?OWpzSGpGcXBIb0M2NmtyNmROWjNmVHdoSEppV2l2b2pyZnNiMUNxbEJFVldW?=
 =?utf-8?B?TFAwYW0wTWh1VERqUjduUGozaFRqT0VkdkxVUGVTVXpWeXlKT0d4WFBvV0hH?=
 =?utf-8?B?d0puTnBwZDBpWkZDNUlXUk00R2lRYXdQU3FZNDU2VVpnZDdqTnZzcG44enRW?=
 =?utf-8?B?QklCcnRkWHVROXJ2Q1A3R1hWM01CU2tBRmpUVUdRYTBmdUJTSmVtMDJpeWxN?=
 =?utf-8?B?dW1sQjhtSFFoR2ZMMDgvTFkvSlQ2QUcveXpGaHJGVWRDWnd2RFhIMzdDZEZp?=
 =?utf-8?B?dnRTTFR1STB1NkFtbExzcmExNFduUklHZ3poRTI2K3Bzd2hvS3d0REZKWHJt?=
 =?utf-8?B?bFZjZDRkWnhwUDllMFo0YUFFUHk4SVVSaUt2VVIzYzI1U1cxK1pPRXBQY00z?=
 =?utf-8?B?L3lrZjltTDRDS3pVbjA0UUgyUktwV1NseXBudTkvVXFFSzJhdGFEVEoyNXJD?=
 =?utf-8?B?dFNJNW5MZG5tWHRtb2FaUmtjWStSSEpIck1JNDlicmREYURoYWVlQktiY2I1?=
 =?utf-8?B?dTRBRGNJR0k1Q0Q2M284amJxWlFUYTUwSlpMK20vejhueXNNZDdPOEp2eVFW?=
 =?utf-8?B?QTZyVHlnNEtWdUpIN3lDSkpsVzgxMG5kN1FVSkMvYitMZDE2Wm1VMkEzQWx0?=
 =?utf-8?B?OTMxWHNHYjhCaHN4RjlLTFhFRWZZWk5xdWgrTDhVRjlocWRnbEJVYThOcHJD?=
 =?utf-8?B?SjRnMEZFMjBJZTAwWXU0a0tpK0kxV0JHazhHZVBGSXdXZjdEWjF5N28rUkhi?=
 =?utf-8?B?M2s5d0ozajh0Sk9wbHdwTnczMWxSa0xVS0h0QUo0NVhTd3JLNE5tZHUrU2Qv?=
 =?utf-8?B?MzQ3L0NPZVcwaFFwYlZDTjRQSnhiRVNSenhsQTRzZ09HT25TaTU4bUF3MEEw?=
 =?utf-8?Q?IGx+41Nda/9WDmvfEE1fu+zKSuRhvhgJsaY35Gr+OdgA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0pkOWpGY2NxSEcyV01kb3FZTEVuVkNrY0FoV0ROTkNGd3dhR1JyOHIyOGIx?=
 =?utf-8?B?QitEbWY2SEZ4WTVjOVQ5V2QrTmhGdkpnYXVSK2k0S25DS3VoLytRN0ZUVjNw?=
 =?utf-8?B?M2J3dU1WYnpJdmxhbHlPa3dsbTZrRzhnMDEyUnpCTDVXT3IvclRVUmZNaUpE?=
 =?utf-8?B?WFFBZUMxWDF2Wk9jZ2lpNUlJeWpSOU5qMklTeE1UeExxam9ZTk41RjZROXVE?=
 =?utf-8?B?NTRmbzAxeW9Lcm5XaVM2VFN6cXdKZTY2eWllai9BSFZTWWhnQnp4U0VycnFY?=
 =?utf-8?B?d0tad3R5dytQNlBiRm1RZDV2aTNTa2tVWEhtWkpublloZ1c0eUFQRVA2cW5L?=
 =?utf-8?B?NDBXcHJWSEZiNWJ4SzVsRHBlYzgxSnhJQUJabWlpUW1leGpWK2xlaTE3NkJa?=
 =?utf-8?B?VTVVZUFaTGRocjRBNkh4d1craXV3dXVoRzJqb2NjakdTb01aa2l2MDQxWUdm?=
 =?utf-8?B?UHRyNHB3RXJWMkNOY2ZTK2E5UFc1YWthU1ppdWFxaXFIaVJsc01NSyttTGVt?=
 =?utf-8?B?R3NZMmhGQmR1ek1oaitWbmZuRWpCY3hFRFdCRFlQQWxqK0ttL1Y4Sk1KTGZW?=
 =?utf-8?B?bUJqTVNRdzhGcUFyWkJRQjAzU0FmTzlUSGZkL1lSSEtyZ1BRdTJuTHMwR3ZP?=
 =?utf-8?B?YnUra0sxT3Y3V1pKTWJWYjkzWGZkTkZCOXpYSElYNTJ3VUZPTWFtZnVHRmtK?=
 =?utf-8?B?UHVOU1F4Zks5TmZiNTdyaFg5Q0hqNzJZYkRxbWNIa0ZxaGJ3TVRGQUtXYWlY?=
 =?utf-8?B?STBKcnhGVXZHT3BUeUdCL1RaZERIQWhIOExYWkNPbVhzQ0xwdmVvdHc3blY1?=
 =?utf-8?B?UnRiKy9UdDhnS1ZVNmEwbmo2MWJMamppY3JpVEZXRWgxVlRYRVpxRlNuL3dE?=
 =?utf-8?B?dlk5eW52MEVyaTVXLzJnRW5hTC9xaXBZTllpUDZ4cnJtc1lmNS9YUGxhUzhs?=
 =?utf-8?B?aEdseU05REIvMkx0UUQ5cllaeE1TNGpwQWl0cHcyUXJuRG5ML2ZWTk13dXNG?=
 =?utf-8?B?VUZDcjhrRUpuektUUThPcEhpby9aTmxnM0xiVDdkWmtPODUzdlc0SjcxS0lr?=
 =?utf-8?B?VWV3alYvOE1LeTNqUnZ2T0JQRkx1aFhsS01jcnAveGlnNVRlSjZ5c1RMVkdl?=
 =?utf-8?B?OEw3d3NFSmd0cFBlNFpSd0oxOGwrU2RKK3FzQVRkKzJ3MmVQMDVwSlFlSkw5?=
 =?utf-8?B?NVFuZDl6b0ZYVW91UGc2SER5Vld5UTNwdTBGQjkwWEJLajE4cWdUUmI3aUVM?=
 =?utf-8?B?RHprMnpUSU15RUJFTlEvb1ZZY1QrQ0ZsaWtYUDBYUHBLVmdBUjViOG4wbHlT?=
 =?utf-8?B?YnlrWEg0ZTlISzBVRVNLMTllUVhic0JQUnFwdjEyUjMvWEJmVFY5TTRIVmhE?=
 =?utf-8?B?WTdaWEs4QjQrTVlQRXhhSFVpVno5eWFidHJzNVFlQzR2Sk91eWZ4eER3dzlC?=
 =?utf-8?B?OE9qSklVM3paS2MzTW5KK1dlT2JPK3pPOXBlWHJDQThCVVJGdDltOVhubi93?=
 =?utf-8?B?T2VXd3c2UXg1VE11dWxCbmtNY2Vic2x6blo5MXQ4VEU1MU13bVBFNFQ2UDFC?=
 =?utf-8?B?RXFVMXoyZVpoaFNTNFk2VEdYNTh3eTRiT3pwZ3dIUVdndGJVMkFiejNRUmN6?=
 =?utf-8?B?N0EveUVmZElOaHdiM01TZ0U5d0FiWE9zUUcwU2QrMGVTQnVHdWdDTlZmVk5D?=
 =?utf-8?B?UWFkL0g5aUZHcVBBNW1TZkRCOGQrd1VwNlFaNVhKeHJ6cGkxK1ROWE0vOGlS?=
 =?utf-8?B?RVBJUlk2Vk5sRUVxeFEvbWpHcXg3WGx4RGlOakZ5OUo5ekdHK20zWE9PaGhl?=
 =?utf-8?B?YTN2STduNG50ODJBZ1ZQRzNUZSt0WEtvWndCN24xR01HZUJNcWpPN2xPK3BH?=
 =?utf-8?B?ekE5Sk44R25weGZPWWEySDJoZHRJRVg2dXlLeXlHRnhwaEF5YU54eWZhOW5X?=
 =?utf-8?B?TGZOQXVTWDJTRzE4ZXZuZWtES3BMYytwRitOVnBRTDdtY3BFVkU2V0ZDYXpP?=
 =?utf-8?B?WXdhOGxrRitla1hndWpVT0ZnSSs4dFd2N0hidUd4dnp5L3o0ejV4WkJiczgz?=
 =?utf-8?B?WERkZEFQU3dkbDhhbVNFZTQ1Q0hFVVhzRWM0Z0pvaXZxR1Z1bXVRaUpkNitH?=
 =?utf-8?Q?45a+35JNSwwc5uFkidGqxD3qQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jJdwyAYBsErwT2AkRcC0dY/VRRPErY5K4O5TuwP+yX1DkIQetwuxT0mg8lqWAF3kKIa6HyRz9DZ0QqT5/BZk94/F1bflveF2zJ01vli7VoJIBmRIO5YJ6AygissMu0CjjklO1tlhsXwAYGK1wp9SKeqE8gPMIElHufDEP+GjLmPfvR5CT7DRxKEbEfNjqrEyQqDCeywQrs4sB6AKSAJOmfo/hdhOvJsCmwdsbmgawcJuDbD/TVQt/P/O25s5YsdRvq1zHU8WPnu1OugJjcv3yvyKhe2GIOam8oovhQIAdSBhsye+KXdpszGj0VCb9jGuiZYGUAriC/H+SFLusVEzlEa/Z1I/sdzxKbH6BCbor5sXjPN+C2nurpV8SlsuruFY1Iq1AkzSiobdH39IPrELAh99czGKa0g5HDrL1B92os2VNwtfjR5ekEO3kaphT+2SLHXeX1gAaJxHejCKF2RxEslBsPPVV1uE95G/aRH3E4V/Ku6UwyCkV3KWIOGLRUfyk1oB0JuASQ49W4TuMCRwPRmyItQ3Q8CZNl4ReGX6i+GloBc//l3DBiS+XXdIWTqZtN3JTI944xi+nnJDsTUTt16U8nTrYwUld7kyAjS2unY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028757c1-191b-4748-f994-08dc8176e3e7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 13:38:01.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7u10cWKpHfbq+C8p1sID3NLtG9IQrWroGinoSJk666nLM34qAz95NRXaRSdtG4l96Sh4tSemBtURqrxXUYBMxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_10,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310101
X-Proofpoint-GUID: N8S9viFA8ZIi2dBJH8CndJSGP-Hb_6UV
X-Proofpoint-ORIG-GUID: N8S9viFA8ZIi2dBJH8CndJSGP-Hb_6UV

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [240528 16:37]:
> On Fri, May 24, 2024 at 12:48=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Andrii Nakryiko <andrii@kernel.org> [240524 00:10]:
> > > Attempt to use RCU-protected per-VAM lock when looking up requested V=
MA
> > > as much as possible, only falling back to mmap_lock if per-VMA lock
> > > failed. This is done so that querying of VMAs doesn't interfere with
> > > other critical tasks, like page fault handling.
> > >
> > > This has been suggested by mm folks, and we make use of a newly added
> > > internal API that works like find_vma(), but tries to use per-VMA loc=
k.
> >
> > Thanks for doing this.
> >
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  fs/proc/task_mmu.c | 42 ++++++++++++++++++++++++++++++++++--------
> > >  1 file changed, 34 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 8ad547efd38d..2b14d06d1def 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -389,12 +389,30 @@ static int pid_maps_open(struct inode *inode, s=
truct file *file)
> > >  )
> > >
> > >  static struct vm_area_struct *query_matching_vma(struct mm_struct *m=
m,
> > > -                                              unsigned long addr, u3=
2 flags)
> > > +                                              unsigned long addr, u3=
2 flags,
> > > +                                              bool *mm_locked)
> > >  {
> > >       struct vm_area_struct *vma;
> > > +     bool mmap_locked;
> > > +
> > > +     *mm_locked =3D mmap_locked =3D false;
> > >
> > >  next_vma:
> > > -     vma =3D find_vma(mm, addr);
> > > +     if (!mmap_locked) {
> > > +             /* if we haven't yet acquired mmap_lock, try to use les=
s disruptive per-VMA */
> > > +             vma =3D find_and_lock_vma_rcu(mm, addr);
> > > +             if (IS_ERR(vma)) {
> >
> > There is a chance that find_and_lock_vma_rcu() will return NULL when
> > there should never be a NULL.
> >
> > If you follow the MAP_FIXED call to mmap(), you'll land in map_region()
> > which does two operations: munmap(), then the mmap().  Since this was
> > behind a lock, it was fine.  Now that we're transitioning to rcu
> > readers, it's less ideal.  We have a race where we will see that gap.
> > In this implementation we may return NULL if the MAP_FIXED is at the en=
d
> > of the address space.
> >
> > It might also cause issues if we are searching for a specific address
> > and we will skip a VMA that is currently being inserted by MAP_FIXED.
> >
> > The page fault handler doesn't have this issue as it looks for a
> > specific address then falls back to the lock if one is not found.
> >
> > This problem needs to be fixed prior to shifting the existing proc maps
> > file to using rcu read locks as well.  We have a solution that isn't
> > upstream or on the ML, but is being tested and will go upstream.
>=20
> Ok, any ETA for that? Can it be retrofitted into
> find_and_lock_vma_rcu() once the fix lands? It's not ideal, but I
> think it's acceptable (for now) for this new API to have this race,
> given it seems quite unlikely to be hit in practice.
>=20
> Worst case, we can leave the per-VMA RCU-protected bits out until we
> have this solution in place, and then add it back when ready.

I've sent the patches to Suren for testing on the /proc/<pid>/maps he is
doing as he could recreate this issue, but I think he is busy with other
things.  They are isolated to the mm changes so I can send you the same
patches to include in this patch set.  This does increase the risk of
issues with the patch set, so you can have a look and decide how you
want to proceed.

>=20
> >
> > > +                     /* failed to take per-VMA lock, fallback to mma=
p_lock */
> > > +                     if (mmap_read_lock_killable(mm))
> > > +                             return ERR_PTR(-EINTR);
> > > +
> > > +                     *mm_locked =3D mmap_locked =3D true;
> > > +                     vma =3D find_vma(mm, addr);
> >
> > If you lock the vma here then drop the mmap lock, then you should be
> > able to simplify the code by avoiding the passing of the mmap_locked
> > variable around.
> >
> > It also means we don't need to do an unlokc_vma() call, which indicates
> > we are going to end the vma read but actually may be unlocking the mm.
> >
> > This is exactly why I think we need a common pattern and infrastructure
> > to do this sort of walking.
> >
> > Please have a look at userfaultfd patches here [1].  Note that
> > vma_start_read() cannot be used in the mmap_read_lock() critical
> > section.
>=20
> Ok, so you'd like me to do something like below, right?
>=20
> vma =3D find_vma(mm, addr);
> if (vma)
>     down_read(&vma->vm_lock->lock)
> mmap_read_unlock(mm);
>=20
> ... and for the rest of logic always assume having per-VMA lock. ...
>=20
>=20
> The problem here is that I think we can't assume per-VMA lock, because
> it's gated by CONFIG_PER_VMA_LOCK, so I think we'll have to deal with
> this mmap_locked flag either way. Or am I missing anything?

The per-vma lock being used depends on the CONFIG_PER_VMA_LOCK, so that
flag tells us which lock has been taken.

>=20
> I don't think the flag makes things that much worse, tbh, but I'm
> happy to accommodate any better solution that would work regardless of
> CONFIG_PER_VMA_LOCK.
>=20
> >
> > > +             }
> > > +     } else {
> > > +             /* if we have mmap_lock, get through the search as fast=
 as possible */
> > > +             vma =3D find_vma(mm, addr);
> >
> > I think the only way we get here is if we are contending on the mmap
> > lock.  This is actually where we should try to avoid holding the lock?
> >
> > > +     }
> > >
> > >       /* no VMA found */
> > >       if (!vma)
> > > @@ -428,18 +446,25 @@ static struct vm_area_struct *query_matching_vm=
a(struct mm_struct *mm,
> > >  skip_vma:
> > >       /*
> > >        * If the user needs closest matching VMA, keep iterating.
> > > +      * But before we proceed we might need to unlock current VMA.
> > >        */
> > >       addr =3D vma->vm_end;
> > > +     if (!mmap_locked)
> > > +             vma_end_read(vma);
> > >       if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
> > >               goto next_vma;
> > >  no_vma:
> > > -     mmap_read_unlock(mm);
> > > +     if (mmap_locked)
> > > +             mmap_read_unlock(mm);
> > >       return ERR_PTR(-ENOENT);
> > >  }
> > >
> > > -static void unlock_vma(struct vm_area_struct *vma)
> > > +static void unlock_vma(struct vm_area_struct *vma, bool mm_locked)
> >
> > Confusing function name, since it may not be doing anything with the
> > vma lock.
>=20
> Would "unlock_vma_or_mm()" be ok?

The way that seemed most clear in the userfaultfd code
(/mm/userfaultfd.c), seemed to focus on what we were undoing instead of
the lock we were unlocking.  Instead of saying "unlock one or the other"
we have "uffd_mfill_unlock()", and have two versions of that function
that take the same argument.  This way we can have the same blocks of
code calling the same thing, with a different lock/unlock happening
based on the CONFIG_PER_VMA_LOCK compile time option.  If that makes
sense to you, then I'd prefer it over the other options - none are
ideal.

Note that people didn't like the "unlock_" name, even on static
functions as it implies it can be used everywhere and may conflict with
a global function in the future [1].

[1] https://lore.kernel.org/linux-mm/20240426144506.1290619-4-willy@infrade=
ad.org/

Thanks,
Liam

