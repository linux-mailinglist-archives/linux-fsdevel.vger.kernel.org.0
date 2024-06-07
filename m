Return-Path: <linux-fsdevel+bounces-21259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F559008B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AD11C22465
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20B198A24;
	Fri,  7 Jun 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PzblTbd4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nk4eFbbw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748E195808;
	Fri,  7 Jun 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773914; cv=fail; b=pr+Ea0iO2PsquPIMycN9uAKde9arprk87DrUoXy6J7GjsZJcA6dE+H6yjcrX8bFNvRcXpjjqd96vsYlD+eFQmBM8yLqyRmxmx/b7cjI3QiExxq8VrdYGSHk8sccEUGQ9kFYkhGOy+gOyJe7MDeIU6uyIxMD0OZPUhqEbwZFZZLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773914; c=relaxed/simple;
	bh=Csqnl4e/2VoMfMwyGrL65RtyRsmPXC5fx72XeZqT+e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sR3kpRZ0z+fOCO3clxEigdnNgvwCQxWT/qbYSD3AUYlQe3k5UVBcUWLffLVLuQfqlS/qv4dNMVkVgnAjD+7vmsQH50//QuEF7Kdk1QPlITpU8O5GtWmRkg+mkOzPNMxhA/LSaMa/6wpgaAreGfTaMFbee7TvtvgsGfPHa1fFR8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PzblTbd4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nk4eFbbw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuUKk023598;
	Fri, 7 Jun 2024 15:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=JqdYi4rCjkvM3xsT8vleRaba1sBnZWeDE4pjZVe6oNU=;
 b=PzblTbd4u07wreWRs7+TnrOoImbvZb/ihLfRa11l57Z4m9OuiAgl0WCLjbnZHN1SIvEB
 7zTj9EBwqlcL+B5tq0WHKWETtvQ4uN++/mI/taaNjJaDb5+XWye7gz4pcuscIqVtE0eL
 WoVdpZ+GTdgWfKODL/E12+w/m5OkEd0OAO04LbnIKSoWH/SI3ihPmEeGsx2rROoV0BWp
 c4ln48A7MthdzhqcmoV6FOK/YVI6HOHUehnHdZ+9UAL6tQLnOPJBshbxJ2+e90Ijk4hb
 PAz6GajQ1eEsAXMuecTE5OimCTU93OR/DisoRvp3ma+5eL0w9xOZFVTRwWhVek3I6cIA iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrsdt6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 15:24:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457Dl2RM020581;
	Fri, 7 Jun 2024 15:24:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj6qmfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 15:24:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/lEk6+2qjnof7azGo07y9VhESndxgLbK4OqwKjM1dF8Q5NOBt2ezUKXYjksZDQz7kPFjHDI2e6TDPf29qqJAsmCHnTDOeKutQF77B8V47MUHmOJuW/u3yAHifXicgIFTbT/wsDJNc6I/zzHlrhVPsCdn+i1Gd1W+6IOwdYQM6IwbAkIDBiKb1bzNhPXvEi7JVuPt+9ANpSXhpxxahxkFqMYOYeLr7EgyomWf9S3bvgN/yKdHuxTVSTs+tCcUt2Ryy7VzRrVpYqOPGx/o0ePawQYzSPVGnqxfq2H+UpOpA/ceVM//pvn7NOxv6ftGDwTSsjT8XFUrVwMJAyEBkq9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqdYi4rCjkvM3xsT8vleRaba1sBnZWeDE4pjZVe6oNU=;
 b=UL2Z9w6y6iJM6Qr+gKb35RTeqxIYZVxOg4bFRVOQG2f1zfDtfUF4sPvRu/LmP8LMPgchmWu9NTlOHfy8DDrGsLxb8KDwE6y1io3F1mJB8LF1tTEGd/X/yTz91XMDkhqHltOZjIwhWcoIGO95nJT9qViu3y2Z0EX6DDzRR3KL20TkpjSlbvplpzvZvQu35lUZ3Qj7OE5bVqjjLqcME09283DqFI+YkKMYeN+ueSMWHEExtlwLLSQ7Agx33ieqbbTCWeCcCQtI7XOUfTugKo+TpMQqCMVHkFe8yG7I6qdxFLUb+oTujZ1+0HraBioC2Xb8l3F94ZlFhhAcaZfQukgnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqdYi4rCjkvM3xsT8vleRaba1sBnZWeDE4pjZVe6oNU=;
 b=nk4eFbbwFIuPpuVmFEnIVxT+fodyuAWSTq1cAvxmxZBUGjdQk6Bn/lzNQI7TFKof3ni0csIoZ5yF7SpGzuTIJNEfgWCAmtMXf3O6Wsuccct7V09j1/EZPG8peGF8/eXkKcRfd9ZWsgsB6/oFGq3rQ+7Do8NrtJQMjilkwowHlao=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 15:24:47 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:24:47 +0000
Date: Fri, 7 Jun 2024 11:24:45 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] mm/mmap: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
Message-ID: <ngoofgkp7gibr5454mck2godqu22clhichvg72ajwey32x3es3@4t65vvm2fcf3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
 <20240531163217.1584450-5-Liam.Howlett@oracle.com>
 <CAJuCfpEfUpXD5Zas7CBT1tqKsF363fOZ9hBMY0Rf=KaX1emnsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpEfUpXD5Zas7CBT1tqKsF363fOZ9hBMY0Rf=KaX1emnsA@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0296.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4a0ba3-cd91-45e0-5c75-08dc8705f72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NXdNWk5pTnBVaERTak1hUTl4emNhZ3dMeUNyZktFcklBMG5FQ2R5bFFMOU82?=
 =?utf-8?B?bDIrTmt4ekhQWk9YaENMZ3JJSHBPSFFncXlCY2RkbHBoeEdMQkhkckQ3ZzNr?=
 =?utf-8?B?dERRZXpRMUNpdVl0YnAvLzBLdjN2anlJTXAyUzdLV2d3N29yTE9YWUJEWkcy?=
 =?utf-8?B?SmVoVTN3UDRYTW5TT3Vtd3pEUnB4U3hmYlB5dFNtZUI5R2dIaGIxWStyMmxa?=
 =?utf-8?B?QnFXMkRTbFdnTktiVE0rcmk2WnhocGRDd09jRk40Y2pWU0FMY1dTaDZpVzRE?=
 =?utf-8?B?NDRIaloveHNCNkF2emZUNFR0WXN6MTNXaEkzVkIzY0c5OEN0WXRBY3dGWEpy?=
 =?utf-8?B?dFBjS2dVb2wzamt6cHJ0RERnUm16K3dNUDRSYmRkN3ZQTXZYK2dMMEdCeldU?=
 =?utf-8?B?WDJPR1FvaSs0RG9lc05FMURIak1OOHNQYzhGMTJtaGVwM3Vsemg2Vk5pV05x?=
 =?utf-8?B?TmtSNzVVK0lUcnFiMThoWE5VMjI5dDdQVkxDbkx4MldwMWJoZDNwWWNCL1My?=
 =?utf-8?B?cmpQQ3pFL3BCODBhelZXM2hkRE1yK1hoQnpUcFFKa1l2S2R5T1VBZUJLZi9u?=
 =?utf-8?B?d3VMbDl3ZFF1RXF0Wmw5aHBXc2hPMXA1NVdtbkthYzFkYTdwdHZuUHlHN0tr?=
 =?utf-8?B?MmdpQ2tSZHdrbXZlZDVYVXpGL2FTSFljN3R3Q0dGZVBRakVPUWV1Ukt3eDh2?=
 =?utf-8?B?V2gvU3lBb2xCTTU5enEzM3R2REdLYmRHaWpRamcyTThkWGNPOXBVT1d5VkQv?=
 =?utf-8?B?cy9ZUEJycTZIeVhmYlB5NzlEcUtOekhpdFdPMFY5RDZEN2ZHaFZES0dsaVht?=
 =?utf-8?B?SGRCbE1RNVVSeEhZci83NVNIQnZSZWc3dFRVQUZJRGJpY05jYWVNeVB4SHdJ?=
 =?utf-8?B?cVVyOGdScFgraGpPNmRXSis5ZHFrbllJMTQ2WXZqRXoyV0M2NTNOcWtOaVo2?=
 =?utf-8?B?djNEZjEzL0ZaZ25yRFd6Nzlwb3dhN0czS2htRFFNcXZxWTJaMm5oN1prWHpI?=
 =?utf-8?B?aitkY0dSakk3c1JnR0NSRjNZYnJrRW9ZT0hoNU84MXJ2ZHB6c2VGN2UweWRm?=
 =?utf-8?B?amorU1JhYzlBMHZXZk9JKzZsOU1zWVBJbzhjUXo1amFOUUtNWng1L25DR0Rn?=
 =?utf-8?B?UEh1YkxINmk5aXZNdkMyaDY2Ky80dEcxalRDMWdoVkRscFBWMCs3by9yK2hJ?=
 =?utf-8?B?bVlzOE1FdUZERGxzVGppekZ3VjJ5d2tMNzM3cWJYTUU0V1ExY09MS044R3BP?=
 =?utf-8?B?RXZsUGZHayt4dndWV1BIRC9qNk42dk5JSHJOWVo4eFJJaGVLQjRETno0UnY1?=
 =?utf-8?B?dmRmZm1XRm5ZVnpZMWd6Ui9EeU9mb3dzcDVkNTNMMmZkOHFYUmhuTy9EOUYw?=
 =?utf-8?B?bkNrR0I0bEhKdkpDcEJlTDk2eCtJaldoaHlwTU80bHc4SEo5M2VEQ3VGeEdO?=
 =?utf-8?B?RCt0eGtlT3lvRFlmVzl5OTVPek5WMnduS2pIL3VPdjVycHVrbG5VcDBRV1dx?=
 =?utf-8?B?eXJtTGNHZDVPUEhzcmw5N3huZTdXSnZ3eXFLcm5KUCsvM211VitGcVhaSkVq?=
 =?utf-8?B?alRWQnNxUkdNK0NPU0JMamI4Ym4xTkRJZ05kaEZaWnF2S2FmanN2RFI4aURR?=
 =?utf-8?B?Uzdjaks2TTZxZERJS2VpYlU2V2V6MzZMc2FLaER5clJaQ25yZnJhRDFzcFhK?=
 =?utf-8?B?ZVVKd3dtc3gvR1JJMGhhQnBwY29PWFYrY2FncEZocjVja3ZySlpheG1FY0R5?=
 =?utf-8?Q?xrU0iEhidI2kpCgV2+MwX12RD5Z1uKjZZPezavt?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cE5hdzZSVnZ5R3ZjTXA5YmpNSGJZRWU3bEVtdWFKcXhoNUg5WlJudFVWOVFG?=
 =?utf-8?B?REpmUlhLb1BBQlRiZzFiUTFyNWNIYWZMS295T3dyOGhybE84S3VranovbjNI?=
 =?utf-8?B?NXpCV1JDd0VpYzZ2NU1ZNHhFMUhXM1ROQkM5VG9FTFZmNGlWNUhZR3IyTmRn?=
 =?utf-8?B?ZElqRmp5ZVprVHBlSG1GZjRyM3h5NnlHWXpOMjY0TUNrZmxjR25sRVhEaGV4?=
 =?utf-8?B?eGFFN2d1Y3Z5WGpPOFV6MktmajBoRWpDWHdVMW1CbHRLYThVZzlnL2RJTTFy?=
 =?utf-8?B?b1I1aUxReWdzL1dKQ1lsU1VEeWJvcGVHaHgxRHhpTzA4bnF1eUZsMW81MVJB?=
 =?utf-8?B?ODUrSldrMkxGVXRKUVFrTUVmQjlxZ2dmTGlYTFBYcVdybjVyZXJkR0pRdjRV?=
 =?utf-8?B?TVZtOURxTjRkbFFJS2JHUWVWeHpGb3NxV1VVYnFSOGNtTkc2bGdEbWRISURa?=
 =?utf-8?B?UlpFelViZzc3aG1NeGxzczByV21saWhwYkdVWGdQWlIrb3F4UHZnTGtTTnhM?=
 =?utf-8?B?bjI0SER2UXZkN0RJKzZrV3ovek5NakF0S2JENk5yWXlteFdyZnpYK0pRRkJs?=
 =?utf-8?B?dUdud0JZdDR2b2VYd1V5S0ZqbkZmN0ZWWWVLblVNQ3l5WWttV2tJTXoxOVZY?=
 =?utf-8?B?UDVtWVFzUzBySzk1Z0c0amdSZVRFZE9lcWlZWFNQU09nYytxbFp6eFhmUDN0?=
 =?utf-8?B?WkxtTUIzWXdhM3ZzZ1VEd05haEtqeTBmcTQyN3BUajZwWS8wVVptQ2JMUXo5?=
 =?utf-8?B?SXBxNzZrM3BHZWh1SDl2K1VzNWVibWF3MVZ6dHhONXJvV0xvaFg3WUhvekRz?=
 =?utf-8?B?NVljV0FyQml6WHRYZVI0YlZYTUhwaTJRVG1LWWw1dC91QS9EbkY2R0tSaEEv?=
 =?utf-8?B?N0gwNDZmZ0l4MDdheUQzVnd0cG5vZzZiZGhraVVOTE84Q0cyWHVzSWFCbGJn?=
 =?utf-8?B?dGlBWkMyQzZBQUVZc2JkR0FjSUhiNlIzUENHRHNzaHdVV3Rzb2xIcmpWKzE5?=
 =?utf-8?B?NXVsdVY3SnpQbmtwL1dWR25lcGRHQXdyZHhiU1c2ZWhuSitKUFZ4T21kek5s?=
 =?utf-8?B?YlFOMUVzWS8yMGp3aDBJT0ptZUUvcnREU3JYWkw4a3dkTEVmbGx1b2dhMHhP?=
 =?utf-8?B?NXR2LzBSd0lmSE14c0dCUXN3MkVxUjBqU3B1K3dFOXVSNlhqS0Jjc3l3OXRT?=
 =?utf-8?B?MjhWTFZCRjN1R2NLY1BJRU9iaDZRY2krNnIyU3FMczhHclQvZnU0R1NqY25L?=
 =?utf-8?B?QXN4cGpPdU52cm5xNkdDZHhrTGwxZStSVjVFanYzdTVTRFRXYWhkMm1HaGw0?=
 =?utf-8?B?em1DSkhYem83Mzh3VTZVZUhiUC84UWpubU1aQjBmMVc1d3JUWjNMS29jQUhD?=
 =?utf-8?B?S2gybWw0Sk1BT1Y5NjFYTWQzNmtrdDI2VEtub0Z3T3VIUkdjd0hrRUtwQUYx?=
 =?utf-8?B?d0Qra29hQTI0VmZaSDR5QzhqRnpJK2hlUkQzbUliVFRzVC9hZENYWmtSNEFz?=
 =?utf-8?B?WmU5Z3BDWGFVOFJITjVMUHRueG1QM0M2MUNJemYwd0twbE5YSWpBZThaM0lt?=
 =?utf-8?B?R2czNDVKWmNaRm1mNWFoL0owZnFxbFRwazJ0UXpad2dLYm1FNEZMeVVDYnYw?=
 =?utf-8?B?Qmh2eU05eFBKdDNSNGtDWHhqRkVRUngrREdPaFlEUHFCWTd2bThBWFNnMkRq?=
 =?utf-8?B?YmNOS1cvYlFGQlVxeThvODE4RnVPbVpsQlg4QjBlREw2ZEpjRVEyVCtFbVNP?=
 =?utf-8?B?ZGgyQUtTcVpNenR0S0l3R1Q1RmpDZU9KbEF3U3d4VlpBSjY3ejVncTJ2L1BG?=
 =?utf-8?B?MHJCeDBlamRNRjhNc3pyeldaK3pacnMxVndHWFNCSklFRE5GL2ltVCt3Mktz?=
 =?utf-8?B?TXFWdmcrOU5RcVBYVVVoQjV1c28yeUE5R0J5ZGt1VUdkNHVuOE5ZV0RrTGkw?=
 =?utf-8?B?K3dHYnYySFVqVGQ3akRKYTF3Vk8zZ0Z6YXRqdWl3RCtlY2tpcHkyN2hGWDhk?=
 =?utf-8?B?RjV2WEtVMU1xSHhUcm9IckVycHRFNWZCd2tjRzdFdjBWVWpZZDA0MEdrcFY4?=
 =?utf-8?B?S0RBWHVRYXh0N1NhamtUcXExMlVMVkZYY3dodWx5YjUyMU5FcHV6S01qeEFl?=
 =?utf-8?Q?weNahMqJgN11HOpNK1I4h4ImN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	k0Ze+YxzUyb+gVx5piEEBX52jXpObXk9C5dRfm5P4ANNFZoBcxLLpvOnQ4vaVQMqOT5yGGkgwT+9rVZUHBjIt0rqz/MnJGg97kJRdv7rdhWCFG2e5MNGTeU4uKAWG92jJ6+6oNVfY8ao+2BM02PSAKtNcVXKJKQXAJaw9jyj7iTMpMjZpSWWj7AlIp4dB5tjVbY92E1SlQoNNmdKil2mLqzepEZuAnSFfQBHwHgGaccuhn6W8ib2HA++s9zjXJkHEc2q1ae0kRfDUE8ltqwGkzWQfv47KlD7i3kFVepfSDHLGhZx2RJ2zH2erDY3Y2waXM1VVZDlLL86gh0sFVkaJVcarbuGq7pj2ZMMR94px/NYpfXllmoIjEmZKpeeyLygA6SRHX/eMWDvg/Fi3DNn+IOeqcG2UoaFoTFQL2ojgv1/yR3UZ4uBk2aY8ytpWsxBsCWUZxiIwZhDWZaCQwNoxdku/EWeUTZXpsa+y+hQVeyBriCXIfsAoRcSbND4TQvjXoctGR1bTaNzdz247gWMG3Z+725uXCub0wV+vAobZ0wklwIwOcrj4TZ7TQ3RRJrKf5/+kACPd7mvATrC7luRJ6cUAU0zRWOBODxpAj+6QuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4a0ba3-cd91-45e0-5c75-08dc8705f72b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:24:47.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3Y0aX6eVtDqc2RYJXYlZabbPeBKoJzW748HkaSB7Esk5MOKjdnhapVnwIJpuBbgK89xYj6GBhJ+VHOC9YW4xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070113
X-Proofpoint-ORIG-GUID: _tu3l5F5IhIoaSqnicMdIUZyzg1QDy2m
X-Proofpoint-GUID: _tu3l5F5IhIoaSqnicMdIUZyzg1QDy2m

* Suren Baghdasaryan <surenb@google.com> [240607 10:38]:
> On Fri, May 31, 2024 at 9:33=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > Clean up the code by changing the munmap operation to use a structure
> > for the accounting and munmap variables.
> >
> > Since remove_mt() is only called in one location and the contents will
> > be reduce to almost nothing.  The remains of the function can be added
> > to vms_complete_munmap_vmas().
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/internal.h |  6 ++++
> >  mm/mmap.c     | 85 +++++++++++++++++++++++++++------------------------
> >  2 files changed, 51 insertions(+), 40 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 6ebf77853d68..8c02ebf5736c 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1435,12 +1435,18 @@ struct vma_munmap_struct {
> >         struct vma_iterator *vmi;
> >         struct mm_struct *mm;
> >         struct vm_area_struct *vma;     /* The first vma to munmap */
> > +       struct vm_area_struct *next;    /* vma after the munmap area */
> > +       struct vm_area_struct *prev;    /* vma before the munmap area *=
/
> >         struct list_head *uf;           /* Userfaultfd list_head */
> >         unsigned long start;            /* Aligned start addr */
> >         unsigned long end;              /* Aligned end addr */
> >         int vma_count;                  /* Number of vmas that will be =
removed */
> >         unsigned long nr_pages;         /* Number of pages being remove=
d */
> >         unsigned long locked_vm;        /* Number of locked pages */
> > +       unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages *=
/
> > +       unsigned long exec_vm;
> > +       unsigned long stack_vm;
> > +       unsigned long data_vm;
> >         bool unlock;                    /* Unlock after the munmap */
> >  };
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 57f2383245ea..3e0930c09213 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -482,7 +482,8 @@ static inline void init_vma_munmap(struct vma_munma=
p_struct *vms,
> >         vms->unlock =3D unlock;
> >         vms->uf =3D uf;
> >         vms->vma_count =3D 0;
> > -       vms->nr_pages =3D vms->locked_vm =3D 0;
> > +       vms->nr_pages =3D vms->locked_vm =3D vms->nr_accounted =3D 0;
> > +       vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
> >  }
> >
> >  /*
> > @@ -604,7 +605,6 @@ static inline void vma_complete(struct vma_prepare =
*vp,
> >         }
> >         if (vp->insert && vp->file)
> >                 uprobe_mmap(vp->insert);
> > -       validate_mm(mm);
>=20
> vma_complete() is used in places other than vma_shrink(). You
> effectively removed validate_mm() for all those other users. Is that
> intentional? If so, that should be documented in the changelog.

Oh, right.  Yes.  This needs to be extracted into its own patch.

We cannot validate_mm() in vma_complete() due to vma_expand() being
called prior to the completion of the MAP_FIXED munmap.

I will extract this into its own patch for the next revision.

>=20
> >  }
> >
> >  /*
> > @@ -733,6 +733,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
> >         vma_iter_clear(vmi);
> >         vma_set_range(vma, start, end, pgoff);
> >         vma_complete(&vp, vmi, vma->vm_mm);
> > +       validate_mm(vma->vm_mm);
> >         return 0;
> >  }
> >
> > @@ -2347,30 +2348,6 @@ struct vm_area_struct *expand_stack(struct mm_st=
ruct *mm, unsigned long addr)
> >         return vma;
> >  }
> >
> > -/*
> > - * Ok - we have the memory areas we should free on a maple tree so rel=
ease them,
> > - * and do the vma updates.
> > - *
> > - * Called with the mm semaphore held.
> > - */
> > -static inline void remove_mt(struct mm_struct *mm, struct ma_state *ma=
s)
> > -{
> > -       unsigned long nr_accounted =3D 0;
> > -       struct vm_area_struct *vma;
> > -
> > -       /* Update high watermark before we lower total_vm */
> > -       update_hiwater_vm(mm);
> > -       mas_for_each(mas, vma, ULONG_MAX) {
> > -               long nrpages =3D vma_pages(vma);
> > -
> > -               if (vma->vm_flags & VM_ACCOUNT)
> > -                       nr_accounted +=3D nrpages;
> > -               vm_stat_account(mm, vma->vm_flags, -nrpages);
> > -               remove_vma(vma, false);
> > -       }
> > -       vm_unacct_memory(nr_accounted);
> > -}
> > -
> >  /*
> >   * Get rid of page table information in the indicated region.
> >   *
> > @@ -2625,13 +2602,14 @@ static int vms_gather_munmap_vmas(struct vma_mu=
nmap_struct *vms,
> >                 if (error)
> >                         goto start_split_failed;
> >         }
> > +       vms->prev =3D vma_prev(vms->vmi);
> >
> >         /*
> >          * Detach a range of VMAs from the mm. Using next as a temp var=
iable as
> >          * it is always overwritten.
> >          */
> > -       next =3D vms->vma;
> > -       do {
> > +       for_each_vma_range(*(vms->vmi), next, vms->end) {
> > +               long nrpages;
> >                 /* Does it split the end? */
> >                 if (next->vm_end > vms->end) {
> >                         error =3D __split_vma(vms->vmi, next, vms->end,=
 0);
> > @@ -2640,8 +2618,21 @@ static int vms_gather_munmap_vmas(struct vma_mun=
map_struct *vms,
> >                 }
> >                 vma_start_write(next);
> >                 mas_set(mas_detach, vms->vma_count++);
> > +               nrpages =3D vma_pages(next);
> > +
> > +               vms->nr_pages +=3D nrpages;
> >                 if (next->vm_flags & VM_LOCKED)
> > -                       vms->locked_vm +=3D vma_pages(next);
> > +                       vms->locked_vm +=3D nrpages;
> > +
> > +               if (next->vm_flags & VM_ACCOUNT)
> > +                       vms->nr_accounted +=3D nrpages;
> > +
> > +               if (is_exec_mapping(next->vm_flags))
> > +                       vms->exec_vm +=3D nrpages;
> > +               else if (is_stack_mapping(next->vm_flags))
> > +                       vms->stack_vm +=3D nrpages;
> > +               else if (is_data_mapping(next->vm_flags))
> > +                       vms->data_vm +=3D nrpages;
> >
> >                 error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
> >                 if (error)
> > @@ -2667,7 +2658,9 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
> >                 BUG_ON(next->vm_start < vms->start);
> >                 BUG_ON(next->vm_start > vms->end);
> >  #endif
> > -       } for_each_vma_range(*(vms->vmi), next, vms->end);
> > +       }
> > +
> > +       vms->next =3D vma_next(vms->vmi);
> >
> >  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> >         /* Make sure no VMAs are about to be lost. */
> > @@ -2712,10 +2705,11 @@ static int vms_gather_munmap_vmas(struct vma_mu=
nmap_struct *vms,
> >   * @mas_detach: The maple state of the detached vmas
> >   *
> >   */
> > +static inline void vms_vm_stat_account(struct vma_munmap_struct *vms);
> >  static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
> >                 struct ma_state *mas_detach)
> >  {
> > -       struct vm_area_struct *prev, *next;
> > +       struct vm_area_struct *vma;
> >         struct mm_struct *mm;
> >
> >         mm =3D vms->mm;
> > @@ -2724,21 +2718,21 @@ static void vms_complete_munmap_vmas(struct vma=
_munmap_struct *vms,
> >         if (vms->unlock)
> >                 mmap_write_downgrade(mm);
> >
> > -       prev =3D vma_iter_prev_range(vms->vmi);
> > -       next =3D vma_next(vms->vmi);
> > -       if (next)
> > -               vma_iter_prev_range(vms->vmi);
> > -
> >         /*
> >          * We can free page tables without write-locking mmap_lock beca=
use VMAs
> >          * were isolated before we downgraded mmap_lock.
> >          */
> >         mas_set(mas_detach, 1);
> > -       unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, =
vms->end,
> > -                    vms->vma_count, !vms->unlock);
> > -       /* Statistics and freeing VMAs */
> > +       unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> > +                    vms->start, vms->end, vms->vma_count, !vms->unlock=
);
> > +       /* Update high watermark before we lower total_vm */
> > +       update_hiwater_vm(mm);
> > +       vms_vm_stat_account(vms);
> >         mas_set(mas_detach, 0);
> > -       remove_mt(mm, mas_detach);
> > +       mas_for_each(mas_detach, vma, ULONG_MAX)
> > +               remove_vma(vma, false);
> > +
> > +       vm_unacct_memory(vms->nr_accounted);
> >         validate_mm(mm);
> >         if (vms->unlock)
> >                 mmap_read_unlock(mm);
> > @@ -3631,6 +3625,17 @@ void vm_stat_account(struct mm_struct *mm, vm_fl=
ags_t flags, long npages)
> >                 mm->data_vm +=3D npages;
> >  }
> >
> > +/* Accounting for munmap */
> > +static inline void vms_vm_stat_account(struct vma_munmap_struct *vms)
> > +{
> > +       struct mm_struct *mm =3D vms->mm;
> > +
> > +       WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_page=
s);
> > +       mm->exec_vm -=3D vms->exec_vm;
> > +       mm->stack_vm -=3D vms->stack_vm;
> > +       mm->data_vm -=3D vms->data_vm;
> > +}
> > +
> >  static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
> >
> >  /*
> > --
> > 2.43.0
> >
>=20

