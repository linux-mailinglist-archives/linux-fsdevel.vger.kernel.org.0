Return-Path: <linux-fsdevel+bounces-51458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4626CAD711A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDC11898AA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2123C511;
	Thu, 12 Jun 2025 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQ3Ptzgz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NbNfCnk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A841ADFFE;
	Thu, 12 Jun 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733463; cv=fail; b=rsAgIL6Fm9q7bBlyTV4dT2Cxrrj8wAp1xEkLuFL1B95AGaQV4BEoo2csT7nwncxFI+6ye++ukeffiel9DRVzFpPW4NFsY1gSTy2q+TpPm83I6ntLqpFMEg6v5nEQ35rW4XEaFCuk8QwkrtQDmM46BDXnNZ94st6ZSRZ0OjZGero=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733463; c=relaxed/simple;
	bh=3GeHGMTBSc5R2U3F0gb0lnu9yx3FSPtkJKnYv1wy25U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qsrupgi5NBwAle+jr70Au/Ln3Rpk1gOPH7PFgJJkmY8hbnomB+cwT3RehxDPzywfU8eszad/aHBqJinmhkDPo9qRFzAdQt/RcqGpvBE/wzgHmzwGeCjFhqFgH2+5Y0FxLYsC6Xee8M4yXhkjTMX5XoyipAvY2c8somC/j7V9ha0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LQ3Ptzgz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NbNfCnk/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C7ff6U005742;
	Thu, 12 Jun 2025 13:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ER1CsbFYFlCNmYKmh5ReHv8PTDZ/ibud9b+J1IyLV30=; b=
	LQ3PtzgzeE0Ev6Hnh5SDdzOJYc3eUNqI1js2TOSJSVr0aoBLrQXG38a3qaWKNf5G
	kuF66rULQcmkiZGVV9O9jU4a3OpBMHy/f06M4Vy5S6ohr2XqvxMVvilSs/1Ksk5z
	qVVoiLBIR+0ZWSbH744CMv8TBHlFA9BPriW1jrDOzcsBZ0T+z2QSNJiVp1B+gYA8
	/DhQS4ryuYQvxOlfVSHBh1tKXibxuiRawnz5UA/fD/fWMV1iZ0Hy3Xx0gnVnUAEp
	oX0oroJFFsG/5S+Z7zio0/VwsU776Qdn4ZzdlfIshdjATpArB/RvBP99RVZeahVh
	ALfNNbs1VNTSIeyoet/TjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v9nrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:04:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CBffZ2016879;
	Thu, 12 Jun 2025 13:04:06 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbjexw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 13:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTNGkHbrgCN+hvRCnpJIgfOozFk173CRzlJLPjDTsK1Ey1jNefQiZKy36DaB6xqhiniQMafM4cMcKnkZxbOefsJTFO/+Gyy6he0pf1PvAXpPQoyZ9eepHUAmTBlWMXZIRukacqA9b5Q8ZklkP/RkZg9BO2sLEBtjhnN5gpeGrJEjFiaareLYy+/BUyanhw/qFYxyn/KTehV4nWDJWYBWoN0FSDW+F8B0K4A+XjUyYHidSl24zi6qEdSUG1udPr6Dm99T1U/MmqDmHjEJpbzSKhStVdmLN+hdAKq8TLO2uC92aB3zJthdyjnR91l0YqCjKGb8i0e2UWW2iqLrRylITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER1CsbFYFlCNmYKmh5ReHv8PTDZ/ibud9b+J1IyLV30=;
 b=LyDZiqTPJf4D07PvU9huiLYqbtNAhg/wCxJ34m1dG2K0EvztUvbP4x8tl213qF92JDT8RKs4caWqIEoSe9tFJxjaD8HI0MYghxFiSwavMExIQJoHw5Ob2hShAvlj6VQ6Cg70KazJJQTOUV4nCNlT/7pZXrS8+DAXbcWhDqRuNfuGRRlagLVyKZtwpdA6ilPS+B2ug4NEXhRAHeBgaanUt7i9dQ/nrWDwKb1rpdAiZ5s/FckZB1cettHlkXfbNnAuoKSRKIDVfWtG246cJVnmNyfwlsAerQukbyRdzakRinVR3OYbTtjAgR+/WG2rDACjBcHogrg3M2LpGnxIRb7Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER1CsbFYFlCNmYKmh5ReHv8PTDZ/ibud9b+J1IyLV30=;
 b=NbNfCnk/K50zuL7yjUJrhBDhUTlXaEJTIVvg5eKgI+00zSk8OImbPl+Wd+Qa6t4paqBaznaIpyQthoe8F0N3jhMqZZqeeG0RgMz3KCtCo5q+XcnmTGwRybTkdcC9A+2JH5tPDjp+ntwD2i3qKOs9xUI2/knnn6G+lRXM+bAqiLs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4330.namprd10.prod.outlook.com (2603:10b6:5:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.21; Thu, 12 Jun
 2025 13:04:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 13:04:02 +0000
Message-ID: <ef5104a5-7d3d-4798-aba9-8801338d9be6@oracle.com>
Date: Thu, 12 Jun 2025 09:03:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata
 to dentrys
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>,
        Joel Granados <joel.granados@kernel.org>,
        Namjae Jeon
 <linkinjeon@kernel.org>,
        Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>, netfs@lists.linux.dev,
        linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org
References: <20250611225848.1374929-1-neil@brown.name>
 <20250611225848.1374929-2-neil@brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250611225848.1374929-2-neil@brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b67a4db-b4b8-4540-1898-08dda9b19a72
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?d1VJdGY1RkkrckJMNWp3UitPV2hGL2ZGMXFRVTZSSkl1ay9BdFVubTIzZ1k4?=
 =?utf-8?B?TjF3SlVYS3l5aEJMUzdlOVJ4ZUhHVk0wRHc0YnBoZWI0MUg2eFg3bnVwNC8y?=
 =?utf-8?B?b0FOMXFYelN3bUtoNUpJT292cmpOWkNuSnJGdWVsRXMvYldWNFltaHRxY1pW?=
 =?utf-8?B?ZWliNWVCOUZldm5FSGpFT003cDJlNFp2NG05clQvanpoVGZqb3lhQVU2ZEhM?=
 =?utf-8?B?OTB6a2FtaFRPaUhzVUV2MWd4RXBHNzJHRDFib2ovL2R2SjhRUVN4bzhJTVZw?=
 =?utf-8?B?WlppMWJBeGdyb3dOcTFSS2JDQUJQWDNyejJWa2I0V0VmQWtxaU5EVHladmhU?=
 =?utf-8?B?NllvK1hsZkZNTUVrM2NuMXBkamg2OWFWVTZVTG1ybEE0UTgxNXdib1dPclFy?=
 =?utf-8?B?RklhdmJNd3pOU29yazdRa25YUk1TT2hETVI1NzJMSTdPSmRySE8vSmkvTGpt?=
 =?utf-8?B?Y0pMTU5Uay94ZklaZjJHSW1RZnh0Q2pjTEFxZS9ORkFRSVFKZC9RZXZsU3Yx?=
 =?utf-8?B?MWtVYkIzRzRuRmpwZVkvc2s1c0x3bjVtL094VUlxeWpqVGFOaHh0OHpMWGpx?=
 =?utf-8?B?bDlHTFdrK3E0Nkp1N2NkRXpvM3htclFMMnd6UGp0RzcrS0VISGs0aEJFOVhF?=
 =?utf-8?B?MmtCa2pHcmlJaWlWUWFJMmpyT01XNE1waWl2UGNCZVZFaGZJQS9ZTVRVdnlF?=
 =?utf-8?B?WTNiQWc4NW1ZOGlOL3IrKzZGOGExU04xNUh0T2UvRllBb0lZWk9QYVBXV25G?=
 =?utf-8?B?b1hDZURzeEJobkdvOFljdFV5U1c1ZU4xaXJpRHhQNWF1ei91ZU5UWE50MFpo?=
 =?utf-8?B?Sy9GeloxS1RENGNXeUtyL0F1M003ZDBhd2NsVjlkSWFBV2QxVkZRMXFOdW03?=
 =?utf-8?B?UGtaVVJGVHpRTHkwQkpRaFZ1RVpVckpsaFM5QmVpYSt5ZFJFN3kwMW1yelBa?=
 =?utf-8?B?TURMWW4wV0xRR2NVWGh4aTZVeUFxQnZkU3pVZHA1eW5wckh5OFdEbDQ1cXpw?=
 =?utf-8?B?TWZ3bVFsYzBsQlMzYW05MGhoTWU2REdjeVVPMGNsR2QrTGlFUENCbXRCUkl1?=
 =?utf-8?B?V3J5UGtrcXNqQmdqcFBNWmtvUkFUMy9PSnBlQythM3FWMm9FMlA0eW5iSHU5?=
 =?utf-8?B?THpoOVYrQTVjMlhYQUNXalhEOUU3L214ZXljNDYrOEJhQ1lrU2h1U1JJd2Y5?=
 =?utf-8?B?K0xIMVVXdlhCTUcyVE02WmN0R2I3QnNnSlIxdDl6UEpBdTUwVkhmYWxhamdk?=
 =?utf-8?B?UW5Rc0FHR0tlUkV1dVdTRFlvdDhWZVNmc1greW1raW1FR0NxYzdoMzh3OURp?=
 =?utf-8?B?OWMrbkRDZVh2eU9xWDEyak93dnNvaVVMNHp5VUk1MmlHdTZTRXd4a0pibXpO?=
 =?utf-8?B?QkVuWGo5dDdiMUIvRGJvNDIyVG50SWw2T09NaENEUk5VVlhkRWVIUzUxSnBY?=
 =?utf-8?B?NC9pbWFTVGRSQndzSVJWbTRMQ2xEMUFVZThQTEt1MHNWcE1OM3RZNVFQc2tM?=
 =?utf-8?B?a0RIc05qSFNWZGcyRFJpS2UzWWE4K1NnSjdIdFpkTmg4TUxIMHZmQmJuWW9w?=
 =?utf-8?B?Yms2dTc4Wnp0RnJ4TXZuR2tMZkJWRXh2dFUxdTltbks1emhESm84OXlibkFC?=
 =?utf-8?B?L1Vmc0FZTThXcFhKdEJxV3FSdEdwVVhCc1ZoNEtCN2xGTDF4R2JKWjRtdHNl?=
 =?utf-8?B?OG5nRG8zQ21uT0RMTVBjYmJJZkdTZkxWaU5EYklwNmsxN25RQXpZeHRxY1Fn?=
 =?utf-8?B?QjcybDRTd2ljU2RVTS81OXNyazE1akFhM2djZEtyVklsWU85N3FMTFAybW5v?=
 =?utf-8?B?Rk9rVzljSFVHbWo5OHNRR1d3b21yNkxaSXNOMmh6S2t3bGF1cWhsWUNQZjJR?=
 =?utf-8?B?V3pEbGlEdmw3NDJ4T0VZOVAyWHRxN3hiRmZPSG50QWtlTzg1cSsrSzRtaytm?=
 =?utf-8?Q?FHoAib/R1wQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NTJvNmtkb2NXUUk2ZWdBSkVUMVZaREI5YTFqUVQxSFV6am92OVJ5SlZtZ0R6?=
 =?utf-8?B?YWtzTTUxcHJIU2tHMWxOS2V2Q0ZFZm9jejRTSm1UQzl6L2hhdXNleWVNYVAz?=
 =?utf-8?B?OTliMVNqejBMd2YxYlh0eTNBNnlLc2pNcEVqR2Z2aXFubmlYWE5BMzM4SDI2?=
 =?utf-8?B?U3ZSWFdROHl1aGRlQi9WSHFObDFRRFgrUEVwTzNUVEV0Qk43UldQRlljb05p?=
 =?utf-8?B?U3hVYkV0TXh1U2JBR0hVWHRoWGdUTzV1c2paalZnUWFIUDBNVmYrdlV4VGlR?=
 =?utf-8?B?T3ZOMnUwdytKU3A4dlpTS2c2TnNwc0pTdVRzQmtPR2tIQkwwaGFrZGROeklz?=
 =?utf-8?B?cjJTQlNiSXlJWjRaUXJpM28xVkY3bFUwT293MmRDMGpySGZsNTFLVFZNVzNK?=
 =?utf-8?B?V0VJVlh6NURya1BMc2VHMUxlNGQ1OGVlMXREaXFkL1ZHamkrcm9YY1ZHOWlS?=
 =?utf-8?B?WUpJbFU5WmNnU1BJNlZ1MWUxMStsUGF2a1JtUWZiQnRSelExNStGNjBKY2lP?=
 =?utf-8?B?STU4RVptU2VxRHNuMW5uMmFtUkNqUFlJU3NZYktscGs0blBKQlJrUm9oUGpW?=
 =?utf-8?B?NG5JcmRxeDRmbFVqSEVXeVFIVm1aa2xta29VeTdvaUF6TEJJYjRDVUFaRU5N?=
 =?utf-8?B?SDhodkJlNHEwNnJ5YUVsR2poeG95Q1JxYWZHVlVjZmJzVklDSVhjeVVGMGVP?=
 =?utf-8?B?SkxNSUZvQzRiWFpHT0p1cGxLZVlEQU5ORWFvNy8zS0xINkg1OWYxVFJhRk9z?=
 =?utf-8?B?bzNlUDRHeFdkcUZFOGdCV2pENXA1WGIvTG9HVVAyam5JaTRibjBMZWJ4TTND?=
 =?utf-8?B?dDdXem83eVA2VW1Na2N3dDNhcjc4RUZ4bEZ4MnJYSnhCN2NHU2lUTExyNFZr?=
 =?utf-8?B?cCtSVkdScGc3aEVPeW11bGpuWHRPWDRUTGJSZlhlaHg0MldvQk44MWg2U29G?=
 =?utf-8?B?UUo1RGZtOGNEOFhuQzJ3SkNrVlVKbG9laWlpT0pQa0Nhb0JxZTJHVjZhRDRz?=
 =?utf-8?B?STcvVU53QUdWWVNQc0p5SCs4Y21JT0VrNDlURVltbGhRL25sRDQvN1ZTNTNu?=
 =?utf-8?B?dTBXTUxsa0VnWGNheGdGZVhYVWlvL0lnZXhsN2poaDJlVmtjekFEbVFYdVFp?=
 =?utf-8?B?bTAzVTlOSTdtSk5GR0NoM1pkbE9BSnRrNmFHVWMyaUgwQkFEUEZ6d2trZzRq?=
 =?utf-8?B?SFpuZlU1WVBBZVdMRGZxTVRZdi85a3U2ak1PZ0pCVm9uSlFYTkZQeS9oa2hx?=
 =?utf-8?B?ODlvR0hNblJIOFhiWTVpdnk4R200dDlQYW1OcU82ZGlnaHNBUEwwcElaZC96?=
 =?utf-8?B?dGR0emV0WGM3a1hvOG8xcnBlekhLTjRUdEtCazZLdHQxN1VWRG5sMWl3cUo4?=
 =?utf-8?B?ZWk2MHBZZFltWE1HSkd3eXNYRFRUcDFaVVpxYWRFY04wMkJWWC9HRlNlcXJK?=
 =?utf-8?B?NVIybmp3ZEk4NFBrYmVNNHg5SkpLVzRqRFFMVUdlenltMDA4YnBLdk1EbU4v?=
 =?utf-8?B?Z3QzM21ERWJCenEwZ1dPMmNLZmpRTE5qOVgxdDlxNzZWZU5sVXlabUk4MnFn?=
 =?utf-8?B?NEtZMmxiTnB6c0VLWlFjK0pGaWordEthNElIYVBlbzNpWnFuMVJLSWpOazJ4?=
 =?utf-8?B?UUkyVnNuZTFLOUFQdEdRaElQSFQzdWg2NEs2cFZCVW5DZFpBeXRMRWc5ckhy?=
 =?utf-8?B?OWU5ZDl1Q2Z4WENBYmRWbW9XbSszTDk1RWxIZEdDQmgrbDg5d0VJM1lNZDR3?=
 =?utf-8?B?Q3hVa012SndiTENsczZSNXpjMEpWaGRBY1JLUWV2TGlmN1lqNm05YUVDQ3BD?=
 =?utf-8?B?UVIwUFVnR0RlMzFycVR0STBoQnlISndGOHJJWHFVYTRzeEtHYnFnRkVSQ3FB?=
 =?utf-8?B?WUdXbWx5QitIWU1zL0d4L1I0YXJveEt6eWwrVDM1dXlVb29sZGFkcndPM1Vj?=
 =?utf-8?B?TDMyU0doTVJQSGVxeEltY3drTyswMVhPd1orWWwvczZCQ1R3Q3ByRmh1Ny9R?=
 =?utf-8?B?MVlLdFg1Z0Y0NzVEOStKLzdhOE1ackV4SEJKTzNHbCtJSDBOU3FoaWVlOXgx?=
 =?utf-8?B?cE9KN052TUJWTDJYNEp2VDZJUHR3ZGtIL3FmSlU3SmJMcjlnL25IMUNYRVNR?=
 =?utf-8?B?SWkwdkowVDZlZTJudDA3Zm9qVTRmSmVXdmUrZ0JFU3IwbUNWZFcyS3YzRWtE?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h/bg5uhtvD8uu/ML3jwBRgTUl38IAouWOdsA/K+sx8qIY5RH5Gz3AgKwKM1pNJ+NwfuHJZLN9HwlHgu6FPZ9JEfDGHN0VEtF54D8QfQv/mIoU6oDLuHsDdU6N8Gzz5ZefxSBvHAKPwxf3GuoACmYh3JJ9F6+mulCV7e5Pdx5kG6qBGI9cDfvNvz8oquZuW7zLpjy75/9J0D/jzeuDHG5uIm8K6YqRkXlXg0TxGA/D19Y7+hkw4c0X1R83KdS7afyymlZCQ7thSamm/IZAyeV7MMv7xTdJgqupX0Pdq3Rs44VRMjvaxF2EzoJLXCEusohiipDw8DTQNWSDLVYVx9TGW1Ps8bDVOkFjfOQzeAuuuhU3OIedjkL4+oHDuaeiL/klso1hNVyuJJGGghfPcDWynkf1VjBCpIT3AFaKC3Pk+FUt3tCGqOfq/sXaGoQUFuo73mm3bExSmvPfEWuXlaZ1nCQhC8G1IQhnmuhtuW88sfh34lP5SKepI+SNqN7yMNr43wvMx/ZTddIBIX+VjyvRGgVTc38tqBNKol/I5YGaIdgsOSoOspj2e8Y11f1THiATxF3/86lBezIoByOjJ7Bv3p940KgnOvrFgHVQ/OtAOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b67a4db-b4b8-4540-1898-08dda9b19a72
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 13:04:02.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szpN0WC6NUTpqGuVe8XMAbtnJlqoeKv7GfrZzX8agcm590kCPu+X3mkMaH+Vlt7l8vtnWBuV6Or6G/c+nHcDlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506120100
X-Proofpoint-GUID: uFcAy92eXLSlGCJPbPPr-oINbtOXJk6g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEwMCBTYWx0ZWRfX0TMm/fqLMS+u Z8a5f7b1M5tWGJWgl7BQV7wstN8FaU4oa+KnhCg53xvudVwlZxelNeeEihrItln04T10gV0TSZt +mS3TiUioUMVizbBLzqakOmzlCNpvT61ztK+Au8WYgGfOkaWkNInpw0wTZMcNMcLgYnV26194oX
 9Ozojq4hay7RpBpr8VIig4/UxyngMWnyK6xrDPbTEm0oFvPHvtUMCqTL1cBrQxRpwgjB1bVjYiP Cyp4uJKpueYZQo9Isu7lNfA/4VElmFZdsf8ng85SgY3MBSfPro+objhn6l7Et+L/hDfI/ZOM2zf d5AJtxaB3JalKyvoftIEljIaK1c0MinMebffoFuy3z+8nvQYhTiaeyCQehURrzw3mTBy5hCDqWD
 s+hyjrgEQnF6R9NaowdI2Ysfn5VpxXjyth78+8vsta9TkLOuY67iBG0B4UQDlkR00vHakV9J
X-Proofpoint-ORIG-GUID: uFcAy92eXLSlGCJPbPPr-oINbtOXJk6g
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684ad046 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=u7Qn0_cGMiFtJtlvCXQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On 6/11/25 6:57 PM, NeilBrown wrote:
> all users of 'struct renamedata' have the dentry for the old and new
> directories, and often have no use for the inode except to store it in
> the renamedata.
> 
> This patch changes struct renamedata to hold the dentry, rather than
> the inode, for the old and new directories, and changes callers to
> match.
> 
> This results in the removal of several local variables and several
> dereferences of ->d_inode at the cost of adding ->d_inode dereferences
> to vfs_rename().
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c    |  4 ++--
>  fs/ecryptfs/inode.c      |  4 ++--
>  fs/namei.c               |  6 +++---
>  fs/nfsd/vfs.c            |  7 ++-----
>  fs/overlayfs/copy_up.c   |  6 +++---
>  fs/overlayfs/dir.c       | 16 ++++++++--------
>  fs/overlayfs/overlayfs.h |  6 +++---
>  fs/overlayfs/readdir.c   |  2 +-
>  fs/overlayfs/super.c     |  2 +-
>  fs/overlayfs/util.c      |  2 +-
>  fs/smb/server/vfs.c      |  4 ++--
>  include/linux/fs.h       |  4 ++--
>  12 files changed, 30 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index aecfc5c37b49..053fc28b5423 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -388,10 +388,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
>  	} else {
>  		struct renamedata rd = {
>  			.old_mnt_idmap	= &nop_mnt_idmap,
> -			.old_dir	= d_inode(dir),
> +			.old_dir	= dir,
>  			.old_dentry	= rep,
>  			.new_mnt_idmap	= &nop_mnt_idmap,
> -			.new_dir	= d_inode(cache->graveyard),
> +			.new_dir	= cache->graveyard,
>  			.new_dentry	= grave,
>  		};
>  		trace_cachefiles_rename(object, d_inode(rep)->i_ino, why);
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 493d7f194956..c9fec8b7e000 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -635,10 +635,10 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	}
>  
>  	rd.old_mnt_idmap	= &nop_mnt_idmap;
> -	rd.old_dir		= d_inode(lower_old_dir_dentry);
> +	rd.old_dir		= lower_old_dir_dentry;
>  	rd.old_dentry		= lower_old_dentry;
>  	rd.new_mnt_idmap	= &nop_mnt_idmap;
> -	rd.new_dir		= d_inode(lower_new_dir_dentry);
> +	rd.new_dir		= lower_new_dir_dentry;
>  	rd.new_dentry		= lower_new_dentry;
>  	rc = vfs_rename(&rd);
>  	if (rc)
> diff --git a/fs/namei.c b/fs/namei.c
> index 019073162b8a..5b0be8bca50d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5007,7 +5007,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
>  int vfs_rename(struct renamedata *rd)
>  {
>  	int error;
> -	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
> +	struct inode *old_dir = d_inode(rd->old_dir), *new_dir = d_inode(rd->new_dir);
>  	struct dentry *old_dentry = rd->old_dentry;
>  	struct dentry *new_dentry = rd->new_dentry;
>  	struct inode **delegated_inode = rd->delegated_inode;
> @@ -5266,10 +5266,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  	if (error)
>  		goto exit5;
>  
> -	rd.old_dir	   = old_path.dentry->d_inode;
> +	rd.old_dir	   = old_path.dentry;
>  	rd.old_dentry	   = old_dentry;
>  	rd.old_mnt_idmap   = mnt_idmap(old_path.mnt);
> -	rd.new_dir	   = new_path.dentry->d_inode;
> +	rd.new_dir	   = new_path.dentry;
>  	rd.new_dentry	   = new_dentry;
>  	rd.new_mnt_idmap   = mnt_idmap(new_path.mnt);
>  	rd.delegated_inode = &delegated_inode;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index cd689df2ca5d..3c87fbd22c57 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1864,7 +1864,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  			    struct svc_fh *tfhp, char *tname, int tlen)
>  {
>  	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
> -	struct inode	*fdir, *tdir;
>  	int		type = S_IFDIR;
>  	__be32		err;
>  	int		host_err;
> @@ -1880,10 +1879,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  		goto out;
>  
>  	fdentry = ffhp->fh_dentry;
> -	fdir = d_inode(fdentry);
>  
>  	tdentry = tfhp->fh_dentry;
> -	tdir = d_inode(tdentry);
>  
>  	err = nfserr_perm;
>  	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
> @@ -1944,10 +1941,10 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	} else {
>  		struct renamedata rd = {
>  			.old_mnt_idmap	= &nop_mnt_idmap,
> -			.old_dir	= fdir,
> +			.old_dir	= fdentry,
>  			.old_dentry	= odentry,
>  			.new_mnt_idmap	= &nop_mnt_idmap,
> -			.new_dir	= tdir,
> +			.new_dir	= tdentry,
>  			.new_dentry	= ndentry,
>  		};
>  		int retries;
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index d7310fcf3888..8a3c0d18ec2e 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -563,7 +563,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
>  	if (IS_ERR(index)) {
>  		err = PTR_ERR(index);
>  	} else {
> -		err = ovl_do_rename(ofs, dir, temp, dir, index, 0);
> +		err = ovl_do_rename(ofs, indexdir, temp, indexdir, index, 0);
>  		dput(index);
>  	}
>  out:
> @@ -762,7 +762,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
>  {
>  	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
>  	struct inode *inode;
> -	struct inode *udir = d_inode(c->destdir), *wdir = d_inode(c->workdir);
> +	struct inode *wdir = d_inode(c->workdir);
>  	struct path path = { .mnt = ovl_upper_mnt(ofs) };
>  	struct dentry *temp, *upper, *trap;
>  	struct ovl_cu_creds cc;
> @@ -829,7 +829,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
>  	if (IS_ERR(upper))
>  		goto cleanup;
>  
> -	err = ovl_do_rename(ofs, wdir, temp, udir, upper, 0);
> +	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
>  	dput(upper);
>  	if (err)
>  		goto cleanup;
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index fe493f3ed6b6..4fc221ea6480 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -107,7 +107,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>  }
>  
>  /* Caller must hold i_mutex on both workdir and dir */
> -int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
> +int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
>  			     struct dentry *dentry)
>  {
>  	struct inode *wdir = ofs->workdir->d_inode;
> @@ -123,7 +123,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
>  	if (d_is_dir(dentry))
>  		flags = RENAME_EXCHANGE;
>  
> -	err = ovl_do_rename(ofs, wdir, whiteout, dir, dentry, flags);
> +	err = ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags);
>  	if (err)
>  		goto kill_whiteout;
>  	if (flags)
> @@ -384,7 +384,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
>  	if (err)
>  		goto out_cleanup;
>  
> -	err = ovl_do_rename(ofs, wdir, opaquedir, udir, upper, RENAME_EXCHANGE);
> +	err = ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCHANGE);
>  	if (err)
>  		goto out_cleanup;
>  
> @@ -491,14 +491,14 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
>  		if (err)
>  			goto out_cleanup;
>  
> -		err = ovl_do_rename(ofs, wdir, newdentry, udir, upper,
> +		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
>  				    RENAME_EXCHANGE);
>  		if (err)
>  			goto out_cleanup;
>  
>  		ovl_cleanup(ofs, wdir, upper);
>  	} else {
> -		err = ovl_do_rename(ofs, wdir, newdentry, udir, upper, 0);
> +		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
>  		if (err)
>  			goto out_cleanup;
>  	}
> @@ -774,7 +774,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
>  		goto out_dput_upper;
>  	}
>  
> -	err = ovl_cleanup_and_whiteout(ofs, d_inode(upperdir), upper);
> +	err = ovl_cleanup_and_whiteout(ofs, upperdir, upper);
>  	if (err)
>  		goto out_d_drop;
>  
> @@ -1246,8 +1246,8 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>  	if (err)
>  		goto out_dput;
>  
> -	err = ovl_do_rename(ofs, old_upperdir->d_inode, olddentry,
> -			    new_upperdir->d_inode, newdentry, flags);
> +	err = ovl_do_rename(ofs, old_upperdir, olddentry,
> +			    new_upperdir, newdentry, flags);
>  	if (err)
>  		goto out_dput;
>  
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 8baaba0a3fe5..65f9d51bed7c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -353,8 +353,8 @@ static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
>  	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
>  }
>  
> -static inline int ovl_do_rename(struct ovl_fs *ofs, struct inode *olddir,
> -				struct dentry *olddentry, struct inode *newdir,
> +static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
> +				struct dentry *olddentry, struct dentry *newdir,
>  				struct dentry *newdentry, unsigned int flags)
>  {
>  	int err;
> @@ -826,7 +826,7 @@ static inline void ovl_copyflags(struct inode *from, struct inode *to)
>  
>  /* dir.c */
>  extern const struct inode_operations ovl_dir_inode_operations;
> -int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
> +int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
>  			     struct dentry *dentry);
>  struct ovl_cattr {
>  	dev_t rdev;
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 474c80d210d1..68cca52ae2ac 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1235,7 +1235,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>  			 * Whiteout orphan index to block future open by
>  			 * handle after overlay nlink dropped to zero.
>  			 */
> -			err = ovl_cleanup_and_whiteout(ofs, dir, index);
> +			err = ovl_cleanup_and_whiteout(ofs, indexdir, index);
>  		} else {
>  			/* Cleanup orphan index entries */
>  			err = ovl_cleanup(ofs, dir, index);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index e19940d649ca..cf99b276fdfb 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -580,7 +580,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
>  
>  	/* Name is inline and stable - using snapshot as a copy helper */
>  	take_dentry_name_snapshot(&name, temp);
> -	err = ovl_do_rename(ofs, dir, temp, dir, dest, RENAME_WHITEOUT);
> +	err = ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_WHITEOUT);
>  	if (err) {
>  		if (err == -EINVAL)
>  			err = 0;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index dcccb4b4a66c..2b4754c645ee 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1115,7 +1115,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
>  	} else if (ovl_index_all(dentry->d_sb)) {
>  		/* Whiteout orphan index to block future open by handle */
>  		err = ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
> -					       dir, index);
> +					       indexdir, index);
>  	} else {
>  		/* Cleanup orphan index entries */
>  		err = ovl_cleanup(ofs, dir, index);
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index ba45e809555a..b8d913c61623 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -764,10 +764,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
>  	}
>  
>  	rd.old_mnt_idmap	= mnt_idmap(old_path->mnt),
> -	rd.old_dir		= d_inode(old_parent),
> +	rd.old_dir		= old_parent,
>  	rd.old_dentry		= old_child,
>  	rd.new_mnt_idmap	= mnt_idmap(new_path.mnt),
> -	rd.new_dir		= new_path.dentry->d_inode,
> +	rd.new_dir		= new_path.dentry,
>  	rd.new_dentry		= new_dentry,
>  	rd.flags		= flags,
>  	rd.delegated_inode	= NULL,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 16f40a6f8264..9a83904c9d4a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2016,10 +2016,10 @@ int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
>   */
>  struct renamedata {
>  	struct mnt_idmap *old_mnt_idmap;
> -	struct inode *old_dir;
> +	struct dentry *old_dir;
>  	struct dentry *old_dentry;
>  	struct mnt_idmap *new_mnt_idmap;
> -	struct inode *new_dir;
> +	struct dentry *new_dir;
>  	struct dentry *new_dentry;
>  	struct inode **delegated_inode;
>  	unsigned int flags;

For the NFSD hunks:

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

