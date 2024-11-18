Return-Path: <linux-fsdevel+bounces-35072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD09D0B84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E11F210EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F218E361;
	Mon, 18 Nov 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UdAMM76H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y6VK5D7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FE186E2F;
	Mon, 18 Nov 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921601; cv=fail; b=J9wtJnjMhEdlhkRCIkXl0YzGUV0ronK9r8+HHjzCbgbbwPNyt0HSOU4ohGUy3YYbvYFi5Si66oEX4iEz1SxpdYr2Xa6gnBDTz51093RbEdQ4PENVG94WcpOsrW/Jq/JOrcBMpxeEzcEs0nj9+9ELjyKVyeaN3cbNYifcEgXgwOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921601; c=relaxed/simple;
	bh=INslZ09onDyQJczdQWhS02MZ+iXqZ6fTsIPCzwMv8uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PE2aeNv8nsizyjnyY3LidRy76I7M/iofZN+i1QNvS/Zw4ih0KabyZAYynvHqacvwqylNuFUWWZo+v6caU1u5Z0udNuts6Rpt6H44D7ZFewX+PEfRFJph5tlbGiO1RRseGudJlIY9wGLiEl606XE8NPx7VlJg2TCKjc+YSlk8pz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UdAMM76H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y6VK5D7e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QbFe001088;
	Mon, 18 Nov 2024 09:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XGVLTk7dNvpPVfDn0DYf8nff3HbMK71iQYNqQDeLoB0=; b=
	UdAMM76HGiUV3yA1qr1mudNtKxh4W+wh0TCP28rUtA21Kbmy9LYW6mhwp+n0GOav
	jnJBq5bqskGUKeF2RM+HboD7pNcurr7+GchvPmn1ifcA3w15bKNBLtjjRTu+vc0I
	rBrb12I7b1w8mJWMS2jC4Uu3+OpKnVzm+CSNdQhlvG7LFtec0qFDFcd5XYXpgb+1
	ZQBnOUDx5qbivO28bSewjmfuH481JaU88bLgNiDcAAOQsnSSyWCWlwZhLwpwKDRZ
	fmjxse9z9l0tXCVz7yEy///IFtZzLNhNiXY6uhcftLZVPmMGNR6yXXnIPOv+flsX
	V0btOQFk9nQlx69ex4pBPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyya8c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 09:18:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8gFK7008934;
	Mon, 18 Nov 2024 09:18:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu73ahs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 09:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKTuc5Oqsfe6j5DlKOWTZGWYD52RZfStQv7zMqd7EkaZ2MTtwYOtnKBBCRMmZTUGnGW/L6J3mQcl2BA3Ey9jczfvUEIrmiV8/6/r7ZfJjRXe6fGGw9bGKTftLep6xgP0rdT7GUyoEaITmMvsZ61VyEGd/1XHpCnwncYjQDNuYiCYUS9VOuLglNG3+KwqUEUO5Tr3hFpmemIsYRNxv2DIWOfe33osNDDVLIXyMR1ndARA4b4EWMT+I7aMhXD67dc7X2rjR1xo5m684MThZfCGsFbqHqhExC45B8n5PhrR7Mo/Ymo22xgUN2ch13XK8r4dkUJ1ORt1xm7CLaqUwVb+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGVLTk7dNvpPVfDn0DYf8nff3HbMK71iQYNqQDeLoB0=;
 b=neAniMU5tezE47D9IgMvSEF5C4Lp3SGPiH4+KY694io+Zp4mFE8pZhpEwdpuEOoB8hzHEfRzJJi4sg2kOb8cBSNO2tZPazk7YQ575wVoqDFuoyS6SUORYxcZ0Fs2QjyYTjc/e1+hT6icVfW7Pibg53KoGommp6T60yEo8TbK2WT7vC2k7xldQUdtBdrj1QNzQY4HS08/oyTqVGsTsNbDI/oT1eSEpSfIH/2msovVzdJB0kKpw/9zpvpQJK3hFc12EpMj2fABN1MPJoKdlMYXZyGOuveZI0D4LSXkOfdBM8NoIZ/Mr/0M2FHSgXptX0Reup+MGjrsTmb0b+6UvDX2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGVLTk7dNvpPVfDn0DYf8nff3HbMK71iQYNqQDeLoB0=;
 b=y6VK5D7edaStOlUwE2eTuYkGY1h7RwHWj5yBVPAfS1e6BMCZ66KDjH6o6CYYYgY6JH/evS3PUBHATwVVI02dYcFgHch1gT4uHz8P5LJMs9cra/LGcunkLnhLRponKkS6S9YR2VJLz/FjNlxhU6pGCHGk9PrV3D5MbTnfu4jOPWw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5553.namprd10.prod.outlook.com (2603:10b6:303:140::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 09:18:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 09:18:52 +0000
Message-ID: <2b9c3d7c-a52e-4c6b-89b6-fb147e6d5233@oracle.com>
Date: Mon, 18 Nov 2024 09:18:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/8] block/bdev: lift block size restrictions and use common
 definition
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, hch@lst.de,
        hare@suse.de, david@fromorbit.com, djwong@kernel.org
Cc: ritesh.list@gmail.com, kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-7-mcgrof@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241113094727.1497722-7-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:208:14::48) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5553:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c08534-b45f-4aa0-b7fb-08dd07b204fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0lmd0prSWNjNmlIeG1jL3FBU05kUTF6dHZnWld2ZmQ4bFBJNjJ6SUF3SGRl?=
 =?utf-8?B?bzI3TGFydDA4ekUyWHVvZVlzZGxGQm9GQlJRT0I3SnRhemkxN0ZVV2Q0V1BM?=
 =?utf-8?B?Si9xRTVaN0pkMi9tSGhLamxMajZjNXdnNEZuaHVqNGdnUTJVNjhRZjYwRitP?=
 =?utf-8?B?TWN6empJdy9IVHVjRFhPNXdYdVlFQlFUU2xpYk8rYkYzZ2lIb3BhNXBJV2k3?=
 =?utf-8?B?K3gwK3JONkd0dzh1WVBCaXQzcklGanRWejVqRmlCVmcwblFvRmVaU1hER3Fo?=
 =?utf-8?B?NElxRmJwQzhIdWJvd29MZW8rdGQvM3JSTEM3UEcrL282UkVTai9lVS9CR21l?=
 =?utf-8?B?dmM3cnJZSDZ4ZG85c2JlbW0wdGNMaEFWUng3a3A2dHZpcW5sbkJxZ0FzU1VE?=
 =?utf-8?B?N00wUWJIR0pJMVVhaktxdmVVdEFpTGpTZzFrYWRzT2picTFseng1cXExV1ZD?=
 =?utf-8?B?dG91ZUxCUEkzdVEya2c0K3BHaCsrT1ZySnpPckw0QmhOejVIUFIvVDM3OHRu?=
 =?utf-8?B?NllEWmU5azFDZWVKZk05UEVHY0lXN1lTL0htL1dhcmNWZFk0VXFieS9YNVVu?=
 =?utf-8?B?bFhVV2xJQkR6R1RiZTk5MDlVRk5ta3l4Q0pML25qa2lQanlaMVN1eVhpS0pr?=
 =?utf-8?B?SzRTbkdQUDFWTTFSNXdUeTZydjFTclVRVzc4T3FPZ1RXZzVkMVFhRXh6dXRp?=
 =?utf-8?B?QUY2QzI2d3VpV3JZcFhLaS9rQXh1cnQxWlQxYzJFT2xJNVVKdDRVdElQc1Ex?=
 =?utf-8?B?bTYxZ21zMW11ZjE2WnJDc2xtWGZmdW14ODhpOUpqdm92WXVia2VFUHRpYWtn?=
 =?utf-8?B?WDBkb0txVW9BTE1iMVM1bXpWZ2VyNHM2NzRHS0kwWFMzN015UURFTG8xTzRl?=
 =?utf-8?B?UHJhMXRkYUgvU0tacmpIWkM5SU5xR3dDY0xaZWx0MXRLckg1K2xvTm9HTGVM?=
 =?utf-8?B?NmFCTUlSQXVQYS9ldmtUaHZWa2psaFlvc2NiblRoQWUxNmVvdmltZitrRGty?=
 =?utf-8?B?SWlVZ3NzSkN4RnNaNWN4TDhUcHhHWDkwZUo2WW14bmxzcmI1cFNUdmJKdUl3?=
 =?utf-8?B?ZlduYnZHRk9aS1lsVjdkZXZwOGVOTlJScEhsTjRrMFROK3NyRnE5WDAxWTFM?=
 =?utf-8?B?VCsra3Azb21mZytsNGJUbFRGWEh1YmV1My9xK0xvSDR4K3ExaGFaYkM2aGVH?=
 =?utf-8?B?SnBkdkdoU2F4Ky9Ld05KdHJmV01nOERidjdrWEJ6WEhBN3I0c1VCc3dtWDhh?=
 =?utf-8?B?eE5ZcUUyV3V6WndWNHpKMDcycVpFZk9kcDBOSFlhUytJVm44b1dhQnFPWFRr?=
 =?utf-8?B?UkpkdEtqMmNCSnRLcndOQnA5anJCK3ZIZVNGNFRpTkNFU24wQVkxaXNWbDBm?=
 =?utf-8?B?a2NFWlkzN0JYNFVyc1FjZmJOamdOMFcvTzNtenhYNGdEaFppempDM0JnUFc4?=
 =?utf-8?B?VVhSZ1BRSWlyRG44aXFpc3UzcUNWVlNudnFRL1ovZHpHdkhZY2dma09CMTNS?=
 =?utf-8?B?d3U1eTZUYUxVaC9Sb2JFcHZHNVZJSlMzemRDRjdyc2hNaGl5QVFLUmhXWWpC?=
 =?utf-8?B?Q1Y0S2phaUFuWmtEWGJ1L09uUkk1VjJCMUdDRTRBWTM0aWczSVV1cEVMVE51?=
 =?utf-8?B?UC9KaFUvREhwckowSS8wUjZaNjlsTWI5a2gwaWVlN1BoTGROb1VDYi9PTGk3?=
 =?utf-8?B?MklaZ3gvZDdCbjZVRnptZ1p4YzkySjh1NU55NGtNUVRtcWY1ai8xc3ZHVTVs?=
 =?utf-8?Q?+JdKDojyXWM2ll8+PJRXoyM5sGUXG3jm7WgAzxj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um1DSXZlSGZFdU5xcmE4RlM0cFBSaUtWd1dGTHkwWmRPYlBHOXZJMUJGZUIy?=
 =?utf-8?B?TW9CR3pxZWd5TnpFWUFEMm1ibmdXWFlqMC9pQ0xOSWpHWGRPZWNrWnB5U2VK?=
 =?utf-8?B?cUlrRUZXR1NJVWFoam1jK09uZUR5N1UyRWRLNkhzSnVHQjB1WWFlQ09RdnBq?=
 =?utf-8?B?anVLUjJyWnNiN1FMN0hkTDNWeVVjV1hSNGorb2krb0sxMEJuVXhrYllyT1FZ?=
 =?utf-8?B?WlVpMG5keXo0dTJMNWlKZ3hqQVRmM2RjS0lIbWF4S1F4UlU5ZDN4d0o2Myt3?=
 =?utf-8?B?eVM5b2RKdUVMZnN2dDlJYlF0dFVpK0p6dHRDdHZNeW9FdE83L3p2clF3cmhU?=
 =?utf-8?B?Q21DOHFRUkNwQVJUd1hjTXVzenBmTWN6OUNaeU5kd3d5ZW9GeUxlSVRkMWFE?=
 =?utf-8?B?R21OOVZhRGErR1JCcVZMaWdydG1VclRkdFZPZHFaUDV6b1JvdGcydDJYaFFv?=
 =?utf-8?B?YWwxUW4vaUJYaHdtQlRRWklreTN6WUtESFJ2MFEzc3hDeGpjV0RUZThTdUhS?=
 =?utf-8?B?ZmxlUFBNS082TGZUTnFnZXRSd1htNEhpeTExakJCbS80dG9kZ1hRTkttWEVw?=
 =?utf-8?B?LzBmRU1hQXM0VXp3OHQvT3NEbGZMQzdzRVN3Y2VUWk1TdDdiL0R0elZMZEJO?=
 =?utf-8?B?YXl0VFRuRndvVjlZTWR4dDh6UDhnQVZsbUN0K1BrOEdpUEpsRU5CZjBjeGtt?=
 =?utf-8?B?Y1ViZTVpWGlxcGFsa2kxLzFETkdLY3ljc2dUZWNuYTNqdDhBWE1MY2M2THJ2?=
 =?utf-8?B?ZlpFZVhqTERSbFBsNzF6QVp3aS9JRWlQT0V0eWJMKzdhb0ZRSkwvTmU1eDJF?=
 =?utf-8?B?K05ZQ3lJbW5UK1pEbEtVRVZpWU5HZ3A4S05zZTM3Y0JJa3FUMUtiZlhyN0FE?=
 =?utf-8?B?OTRXNy9WalV4enJkQlhKaDkvOXZkeWY2NCs2V3l1aXltMC9rSzRDNVlvYkNl?=
 =?utf-8?B?MS92eEphOTV0Z2plWjZJQUl3bE1NejdISExXU2RkY1RWYzB0Qm9XbGM3Ymda?=
 =?utf-8?B?VjZadE1tTndpNHB6bW53dkt1Qi9mYWlTVHl4aDd5VXZ6b1ZpOTI3SWRGUTdV?=
 =?utf-8?B?TjhJQUpHNzY5YUlUS1JFbVJBZjQ1VlNEQzl1enU5UnlCOGM1OUVyaVFCUW5s?=
 =?utf-8?B?SFEyVGxmZWlubjFPa0Z3MG51bEdxRlNIdmx2NThPeUFVb2F3Njk1cnQ0SWQ4?=
 =?utf-8?B?b2JqbWxNR0dHOVVpMFoyVEY1UEZQOEVBYjNjYXl6ek5NZ1A1eXc3cmJleVRv?=
 =?utf-8?B?dHpFbW1VM1BvL2tJQ3dpQXcvVUdRRlQvdURKQmFkc3NWMFl3WlV5WXcxQUVJ?=
 =?utf-8?B?eW9tV05lWDZFMTByNE1lN2V3emZQZlZtQ3RXa2p5UDhaTVN3OGV2Mk5IcVhI?=
 =?utf-8?B?VEQ2d1hqYVROMUlBSUd3UWRUbHVlT01OTW5XZGl6UEYrYUFtN3QySW5aRm5K?=
 =?utf-8?B?L0MrV2Y4MlhrSXp4QjZPd0JSbklMRzFoR2NXOEhIcGRGVjU1S1ArZFlqejYz?=
 =?utf-8?B?MmdHSk1lL1lpYTF1UDJKQk9tNHBPUGwxTy93ckxtV3h4b1U1K3lBYVk3V3dO?=
 =?utf-8?B?Z0VvYy9QNFIwZktiWmZyN1BDbGFDK1Jldzl3NUZDTndyTjRTUStEQ1FXTVp0?=
 =?utf-8?B?MUlnM3BzRW5CRWgyUWdhNzZUZUpjZ3E3WVU5VUx6UjJwSlQwT1ZOQUJyYmVG?=
 =?utf-8?B?aGplQStyQmRiV0NzY21NazZ0Rm1wcWI0MWlRc3A5S2x0OThnR3p4MThoTXFD?=
 =?utf-8?B?N1lVOWxBNVY3R24rd2toWFl0bmszQnRTMDU1b0pOUU14dHdFZU9MMTZJWjNH?=
 =?utf-8?B?Y2JHZDRUSWI0Z2JQWkZVejRYQUd1NER0cmFLSWxLZWVTcVdmUlhLcFp3Tldu?=
 =?utf-8?B?b0VPSjBENklkcjdpZlR2ZmtYRGNGRzJYak1rNVU5T0RadzA2SkpRWWMreWNZ?=
 =?utf-8?B?MTlTdGZiajVrcG1UZ3FuWFVYK0R2MFBIV3pwM2N3cWNpQUJFa2kxZm1TenVC?=
 =?utf-8?B?b1NmUnBKaGhkOW14QTAvVUpXTlV2R2tUMTZHeXlIODlPRnhwcHF5MHprNWhI?=
 =?utf-8?B?RXF3cmtYU2pROUZBMXdjeEhSdlBYUHpEN0NaUjdPN2tWT0YrdENQNGwvRm83?=
 =?utf-8?Q?+wMOI1yWETDiJcgkbVbAas0Uf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B/IaWhtDCWKZHPysBZIxEhC1WA4RAJ/2S8nNLnp16y7MO1axBiYgssLYk7xxrPQh3hEjvCqC+DIXCgOUEPIbS0t865RhEcICJBjECITCjcxzNK98jPTuDrujLeVdVCTWHBc/FX7hVKsVV655gQzbvZIhhCxbzufKLmW6m0l/2eMZK12MQBQm7vq480sEC1b9/pUQCzDkUTmAh2RBiQFUyeH9IHFkG2UoAAyJZmURzc4/J03v2Y9dmm5ZiZIga6UUEG2DRPUo86FApvMJ91D8TJQueBtDikr2rUmCchRwbMm0oHNwAXOtTP7VQ935gXEmv7EvgLVLKWi+++DKk6D5lFwJhcSbF8JI9p5x/T/V+Oe8PuDR51EVckuAadWzJpYFrgCA5Wz/aC7U1o2Pmcy1oKSnvvl7dC6grpPqRbrUhx+rxtcaBq0JBkDgv+gherq0vCX7R3lhVz17AxY2l3i3MoC0nRUq5JaOfWbSNVF2rBi9zslLUUUDX477ENrSrL8KDYeszwRWOJyFUwz/iaBjd7iOK//BZSYxY3HcnRw7w6QZX3Tfa3LDCfW5YlXfetnlDCwMUVKtmc7FolwRfTIz9IiXyCINZV3v80dfimTqHL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c08534-b45f-4aa0-b7fb-08dd07b204fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 09:18:52.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmgFIS1izDzJ3tQ5ZOIW5hO/cnmtbatWclobYZGdIM/vEXC0SNNW2JmfFVU9AKORs09Il65FiwIcKjyMfaNxzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_06,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411180077
X-Proofpoint-ORIG-GUID: lnIkOYO6ft5IoU6JFNLRnxnhbBioh25j
X-Proofpoint-GUID: lnIkOYO6ft5IoU6JFNLRnxnhbBioh25j

On 13/11/2024 09:47, Luis Chamberlain wrote:
>   #include <linux/uuid.h>
>   #include <linux/xarray.h>
>   #include <linux/file.h>
> +#include <linux/pagemap.h>
>   
>   struct module;
>   struct request_queue;
> @@ -268,10 +269,13 @@ static inline dev_t disk_devt(struct gendisk *disk)
>   	return MKDEV(disk->major, disk->first_minor);
>   }
>   
> +/* We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER) */

I fell that this comment can be reworked.

I think that what we want to say is that hard limit is 1 << (PAGE_SHIFT 
+ MAX_PAGECACHE_ORDER), but we set at sensible size of 64K.

> +#define BLK_MAX_BLOCK_SIZE      (SZ_64K)
> +


