Return-Path: <linux-fsdevel+bounces-41185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C2EA2C1EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 12:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743653A679A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AECE1DF247;
	Fri,  7 Feb 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rn+0A/la";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LQ8HYGsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4B1A4F12;
	Fri,  7 Feb 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929173; cv=fail; b=GhEjLg+2Ipi5GqwvXbZ8tmk4FHv7kLL5XLeT6TZJuVxibGHAIOdhQo7yJ/wnkYQRC6t3/bbeDLLkJsawWmwUUIqp2vwRQpOjeOVPVm4Pre6SL2GL4B4A5LcRvSi+AgM2H6jO2Sy8xjaR3of0cC/DlclBwF4cbqvO3h1Nc74c+SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929173; c=relaxed/simple;
	bh=7AnKSHCumnjp4P4ZKWRG1vBkAhWNYOOdyWQXB0LCO28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dojftNmOFa26NElVvbo7HVZk2UDou7W4hGoWfPp1YHxbE39y6q6XmlQlANA2d+W9g/46UvgOtU+6HcJl2TW4YDMHowFkVC7PuyjhvwU3fZCFysp0BjpSXnKhUuKrZfDcvRIa12ng0JbcH3vdETiFmPJPVhV8rxmLbi5/IzzROfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rn+0A/la; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LQ8HYGsW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5171tskY017536;
	Fri, 7 Feb 2025 11:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=22ikqikvWe4XQvWbFY+neIVUFTVVSpUlRFzpSyFOQQU=; b=
	Rn+0A/laDD5A0nGf1MK5K+k57Bhbi8CEvOTgUi9ptx1AsgeYWI4vxuocAmdC3bya
	l8PwsieBEQCNJVD8E82cKvMxwreIdJAza6rOmZg11afl10HIsFzpacGQyqiXN5Of
	6HOQOuk1PnZjAKwfzQXb1XSTjbFcd9wTK724U8kLCWwRc3psbRgXf16BLj5Roxwm
	4aDA52q52yDELpmijS3qpXEYh8W7Cwj0seZIZnoeYb82imM/PwLxa32/85QKGfq/
	6TjpqrBfyCowJVcxOZnm6FKGt7QM2ZjdB0xZFwubJ7kKa2rr1r/W356yP/nwOPyM
	FjxS6vOLUDWs6G75cp/X1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbtk9yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 11:52:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 517BgDjn027883;
	Fri, 7 Feb 2025 11:52:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dre8rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 11:52:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mv+DzQ9nWEe05b0eRjcU410XvVQ5Ous2XXPo+uAJSt8bmH5oiwYLyzuJrRIFdtOy9cz3SNP12W2pRoX7g7Rq/MO4JctrsgMVigb4Di46ePCepeTGDtltTzrNaQ52YOzSKnpY1HYj2nSCnyC9DwFj3M4sp+vYs2Dtn03JoHh3OZ8NnyTPyTg1QYjxezqrgc2Fju5grq174f5MBeVZ33Dz8STLTdlzBhsQrBZ6YN/G9+HvAezOVVIaj2q5/sTVraWioo4pwt4TlfWkCUk1qIGrnY10MT8j4AVY90Ru5/UaFxLTyCZgyvuW2jc2h89/dThiAmuCn4BY3Fh4wSWmB2PWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22ikqikvWe4XQvWbFY+neIVUFTVVSpUlRFzpSyFOQQU=;
 b=CMmLtQezKaeVO1fwsVR/t9iFha/t493E+az/SwU6Fc22rulD2GWnrDo1V0OUHcr7GMehrq4IQReNqxlPDW74oylnbbpNIj2n/O1pDpGAzJxA2GXSiWL1oYtrB+gCb2KYQKSb5+IKKe7ZtIaAnu8ZGXGBEErCBZDAmWI75oPosweX3j0C6+KSGNP/c+vAOEtW8FLOXQFOFUc4tY30gkowzeY2mjAQkulltDG+IOodXjFRnm6T/s+PTyGlDKzs8Cnfsi0zJn9/ve/t4HQEn1p39gMg3iMS6FNZ/zpKYrow+l9xOdFIcm4JaUyt0ji/C6EwPFSUOHxFPj/TBADbOFNeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22ikqikvWe4XQvWbFY+neIVUFTVVSpUlRFzpSyFOQQU=;
 b=LQ8HYGsWRYuA2eS7TwX9EmyveCJdyI6mAesQ+Wmn6oTDPe2dyY0x6iKsxEjXkT//GDjRl5iGaXk73cX9hVrq1oCS32N2/t8RHlntZA01oQI9OOcW8Ue2ZIXn0foMUo1B+NWLbc6778lOc79lMOs45O64R+X/8WI/sQaZ28gWMU0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 11:52:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 11:52:35 +0000
Message-ID: <ce6ff351-9bcd-418d-a1b9-081b3ba05493@oracle.com>
Date: Fri, 7 Feb 2025 11:52:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/10] xfs: Commit CoW-based atomic writes atomically
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-9-john.g.garry@oracle.com>
 <20250205194740.GW21808@frogsfrogsfrogs>
 <ee8a6ff2-d1e3-4ee8-9949-cf57279ee5d7@oracle.com>
 <20250206215014.GX21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250206215014.GX21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0086.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::39) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c03b72-206d-46a9-f24b-08dd476de996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0ozaUI3OGVCVXF6NTYrWThyR3hqQzQvMHZ5TXM1ZUc4d3NJb0hrbks2czlS?=
 =?utf-8?B?NzBNNE5YZXgyTEdwZHRlU3AzU2N4QWpyYWZQM2piQ1IwUDhVbjd4OXNNb2pU?=
 =?utf-8?B?b0cxOXJkQ0NFR2pDZjBMaFhLb0Q5ckdYaGtoUUdGeEM1N1hadDNySzVlQWpS?=
 =?utf-8?B?WkJRMlhyR1VTbnRnUXdoQ2JLZkgvYWVyRWlXZTNnVXVKQ2pjcDhiSVVPNjNN?=
 =?utf-8?B?dytmNEpUcXVCYURaMWN3ZGJlYi9SeXJ0cklDalZ6d2kzaE1OTzMvb3haejFJ?=
 =?utf-8?B?d3VBM1dTOG04ajZDM1FOTDdrK2Z4VTRHUHJvbUVyLzN2SUVUUVVZWHFDdGU5?=
 =?utf-8?B?M0Y5VVZrb2JSQUxoV2VqWC9Cek9EazBMUFZINkFUL2NWeHllSFA1c29YbnA5?=
 =?utf-8?B?UndUQk9POEh4ZUtPbFJ1dTQva2ZDSDhhWU40eHdDVExiUnRValg2Mk9FNE1V?=
 =?utf-8?B?Vm43ZXpucndGR3pIVUZWVWpoTDFWR3dHS0ZIcGdwaUhhdTB6dlMvYXNoV3li?=
 =?utf-8?B?L0tpQlFJRUliNVE4TnpjT1Yvc0RTcTBqRUNyQm5nZWtQYkhvWDQ3ajJIeGxF?=
 =?utf-8?B?RVNUZUFOOTVza3VHM0VVa2lWWVpRMzdtZ01BS01USXJJWkV0NDNHek9mSXFB?=
 =?utf-8?B?NHhxZ1U5My80cWxwbldrMytmcFVZby9nbDB0RXhSdlUzV0Qzck1hdmhHMUxE?=
 =?utf-8?B?ZUJYNkVKaDE3TUZOTWdyQnZRVlh3VTRwOXdYdGJKdlBuTE5uOG1DODUvdjJh?=
 =?utf-8?B?SUpraWF4dllMNVNUNzBrT2JRcG45WXdsdm9INjNRZmV0aUVqSGJ1LzZxcWFn?=
 =?utf-8?B?OHJXVElmd3p4RVdtc1hYUk5PUFFrSDhPb1pnS0VNV1BndTJGOERZN29lcXcz?=
 =?utf-8?B?NVJDc0dhY0owT3dlWHhGREhoV3F6SFl1alIxNUJ4ckpMaEgvajlhTUp6V1FY?=
 =?utf-8?B?R0MxRExscHRJRmJYQ1d4ZThmN2wxdU1HZ0JHMHplSDQ4amZMWGl5Y0wrem9x?=
 =?utf-8?B?K3A0MHpRVCt5eWdnNzg5cmRXZE94K0E5S1cwcFA0U2k4RXZsUWpkNGlPWjN1?=
 =?utf-8?B?UzB4TlRMdWg5QlUrZFRMZjQ4UGphRTgwRTd2dFNMYlRkT2xuZFNzWkhLREJv?=
 =?utf-8?B?Z1V5TzMxdnQrME5QOUNqUy9BdGd2bkh3MTZDMGFpWmkzU0hnNHdRQ1lsKzdi?=
 =?utf-8?B?REsxeDJQTHZkbllTS1VxSWVqQWdPcTZiaTJ3bUpSUi8wVm9GbWMyUWxQMGRU?=
 =?utf-8?B?LzN4anUrYkF0VzBRMGJxa3J2NllTNzBNK1hSSXpiVW9iM25WaGp6Z21UMkN0?=
 =?utf-8?B?aEcvVTFqVnRRNUppaElvbVFrY3VQRGVNUTdnU3c4NDRnR2JoRmNjYnY5RGs1?=
 =?utf-8?B?aTk1SmtBRFVGczdaQXg2d3FNVFZYalZwV0twdGF6ZE93T2owMmNxWFVYUUli?=
 =?utf-8?B?Tmc4QkE5L3J0Z2FCelA2TmdEaXZsQy9MRXdqZUpLNU15OWY0M1V0MFFGcFor?=
 =?utf-8?B?U0lJMFo5RzU0OHF4V054cmJJMkdueGZBV1NtR2JXSnZCYW5DTjUyNHVuZWFL?=
 =?utf-8?B?VEQxMWZJZmZwSFR0Qmw3SnlWY3BGRFk0UmN1Z0JwYnVRaUh4VEZEV1Z0TE85?=
 =?utf-8?B?Ym5BVHVHdmVGVWJjbXgwZ2xLak0vcnlpZm0yaUhrWExzNW1EbTJmMXd4ZjJQ?=
 =?utf-8?B?U1V4VmFHdXFUZ1k5RThmQ1M2d3B1NTNMK0RlUUw1d2p0bWZYbk5HWGQwclBh?=
 =?utf-8?B?U1JDcXhZdXY0b0wzSlU5MjFrbVNSSzJlejJRUGhBcFN3TnpQbnI1VkxRZDdr?=
 =?utf-8?B?WnA0dU9seTJmTEFHWHhueWR4ZUFVT3BLV0hJajZHYnV6R3g0WXRoRFhFTGMr?=
 =?utf-8?Q?itqKgpWmSsbqG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODNzNE0xd3hTZkU4cElaQ2tRSk55SjBUTElEWGJKUmM4UEM1VGlYMUtVajhs?=
 =?utf-8?B?dnBFZ2o5U1Y1NnhhK0cvbi81bFFoTEZaY3QwQmt4TDRFZ0xTaHNKU05aeC9i?=
 =?utf-8?B?VnFueVM3ZWVpTVdHSUNPMFBZSlRHR2kyT0g5Q0ZiWXMzSWVVYTIrcWJMM0Qr?=
 =?utf-8?B?NG1QK0VVdjNaRnZTdCt4ZzBtMEFlUFdPZG5LWU80ODRoT01XWTk0clBUVkJY?=
 =?utf-8?B?ZTZDVndpWGVEa1RFZVBZY2YxRXRSNXJFVVFTWktXVG8wUjJWZEsyQXpmZ09E?=
 =?utf-8?B?aXFpT09oSy9EVWM3UzFaR0Zta1F2QmpXTTMwK0tzRDVJak8weU94M3N5V2Rx?=
 =?utf-8?B?Z1ZGUS9mcHg2RHhCdnhOQ3psbnlRWGRZK3lmdmpiUXBGMEVpTzg3elJDNWNz?=
 =?utf-8?B?RVJlbGYweGtzZDNrQ1NUbGpJNlljRnVjcGJtZlQ3ZFowWDVHZ1VkcVNvU3l5?=
 =?utf-8?B?ZVp6ZHR2L1F2REEyNm1NaGdpOUdYZEE3MFdIZ3RLUzlLNXhQWWJCSGpMOGtK?=
 =?utf-8?B?WEo0VUk4UmZZOWZpMytreFBsQnZmS01ZcGpiRFB6MmVMUzh4TTJoQjdvLzNO?=
 =?utf-8?B?TU83TUdyaHRNNG1BcEQ5bGFLTjluNno2Tm9IZ2tIMWJBRVVvZy9IQmxzdndC?=
 =?utf-8?B?TWdoQmdReUV1ZTQwdzgwY0F3bWpmVHBTbkFsTlZGM21aQTFtNjgwczB4cnFQ?=
 =?utf-8?B?SzJ0TVl5THNtNDZyVHIvZCtOK0dHUEVLWVRGWVhiVFFzUkNSdis5ZzdxNzcr?=
 =?utf-8?B?K3Q4TFc0bmdkRUVQQm1RclhlYnRSZ2JOT3I5Q1V2RTEzK0xMRjhSck0xTDc5?=
 =?utf-8?B?V1FOMGJjYWlnc09mbjFkUHRsZnBZOUEvY2tmY1U2Z0N0S1Jyd1M5UmpEQnpI?=
 =?utf-8?B?cXN3MUowS2V6UGJmN0RReHcrbVFSb1VwdlplL0FYV3RhVEcwTVRuWldWZXZS?=
 =?utf-8?B?ZzF2ZCt1cytnclBvRVZ1cGpLSmJhdUllUnduT21rOVdDU0RSd3VocDZUUlRl?=
 =?utf-8?B?azZRSmh4d2hQdEw0UEJNT3lZSjJweTYzajV6aXZOZGxwLzBFWDFJRHFwMU90?=
 =?utf-8?B?U3AvOFo0bWExU1JhWm45YmM2MlBSS2pjK29ZUWtkMklxQ1MvMWdXUkhVUmgx?=
 =?utf-8?B?Mmw0eEVLaTYxbkVxajlEZlNDNVhrZlRweVFOdmhzZy93S3NwTVJ2VU9WZU91?=
 =?utf-8?B?ZklLc0orejFpZ2RGakx1MElhRGxJb3BRT1JHMHRFZ0R5dmtGTjhyRzgva0V0?=
 =?utf-8?B?Ti8rdSttR05yMTdQNHVNMGtXZVdEcGNjbkIzTWRobTNoQVdHWHhHWXNTZkox?=
 =?utf-8?B?bnRkMEFWZWtWSXE4OTBzZGJJaDdncTZRQ1RkbzNLcnpmWHIxbXVVbEJBNW9h?=
 =?utf-8?B?SlhJcHVOcm5ObTZ4NW9ORWF6eHkxd0VONE5EWTJkZUdjcHRUMFVsdjV6Nk44?=
 =?utf-8?B?RXRRZTJ3YnJGT3AwL2lBSVlCZEU4dWJBTnpFV1hCTzdCK2ZCOHZaMnM4M1di?=
 =?utf-8?B?c2RvckVSZm5KZXNPUG9tUXl5SnVkRHFSZWlzcjJHNUxNZ2xnc0VlM0RGSENP?=
 =?utf-8?B?SWpGdkV3L2JnSEtQVElzLzB1S2ZJRWd4Vm5HRzZpVWR6MS9RSGZSdWhoVGM4?=
 =?utf-8?B?cHVzK0QzZ0VjcG1LQ291Vk9VYlIxbmtNWlNqRy9DWFRrWlRyNG8xWWRWMWJ6?=
 =?utf-8?B?WXNGUTRlWElncmpuL1JsRWp5VlU3TTQ1ejdnVDNsOFBHSEYzdE03R0VUWHFU?=
 =?utf-8?B?VFd3ZHFTWUtxQURBeWlaNStNYk14TWlxTnI4UkJ0U2Jmai94bEt0c1pKWG83?=
 =?utf-8?B?UEVzVy9OeUEvOEc2SWZodzBhbHRaWldYNXFxTXpDYy9TVnpzS0ZnSkhqeTQ3?=
 =?utf-8?B?aHQzVU4vRWphTHhOYVBpMVpuRWRyTXdJTElLcXNaeEJnTEMydEwwb2pCbllN?=
 =?utf-8?B?K0tMZHNscXA3ZktkcFo1cHBJUFA1bC92WFlSbEg2TExWSWU3NkVwUXU3M2hk?=
 =?utf-8?B?S3dnQUtoQUNHSS82OFpnY2VxNkVqbFNhODVlVytPUGgvZnBEK1E2dENIa091?=
 =?utf-8?B?WVAveXMwY1RWYllzdUptQUxnSzNSREk5OU4yV3FOZC9UZDlmTVZZQTBFTlJo?=
 =?utf-8?B?amVhNWcwYjFzZ0dTRXJxeWxUSTJJREloRnpTTkxZU3NoNXYxWndVdTFkWGlu?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2WQXbz8EoSd2FmIKLgQ0yHklXdscWrvcbF8zEBRCuvT5zpXFhwPMaIVWx2cB482aL0BX2cNvz7+xixJaw6Od7URBei5KOdOvmCX5G43+S28FFfT4tuSUDGXwcbEnV2YDpwblJUUTcQaslyKYV+kq9ex4U1P6X/8/I12QhSbqqPBQDFUCfxlzbANk9CKOoQ/SK9NMPEGS0pRwCZ641q1YbSu6gs7VVaQ0oeE3QN9ZqbZsjKjchNtinEl4uIeT6syd4zKgiXdgFSp0Fa9wxWRkGqZAr/ltimuUUNipa5a9uv0RU7LPHRnxkiSVsuo2wfJ/2MSiYZvtmq9iN2nLanIt5oFW6mY1L6d7uZSRJK9N26zyWhvIIoLdl9ZmInH/sI+JmV0BC3KBbG+6FhfIhFSOB8vWTYJf+aYPiyJc8+4kHkbVsSis2eSCrYDqsiSoprrR9hZ5qd/TiWvY1qlrhi6/1bmm6RnTkxO3Bs4MVsoIp3beljmYW7SLnT8oSlm0k9BKeC2qH1tG+SQD15o0rSgJOjcuKZvvE0ZKqitttDeO6Bh0xKixJ0gjIzJApvZIM+G2fdXGB0MfdmlTdNN49W1dXrMsZHi8GK4keUAf8bYZNrc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c03b72-206d-46a9-f24b-08dd476de996
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 11:52:35.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6XhlVO9hCWb6rWGLbAN6oSrkuvQNYH2YbUe1R2bA8B0gPnzKwhXD/BXx2MQjyt6qPc+cqRsKZ849zurHUNOsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_05,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070091
X-Proofpoint-GUID: 70mpzFq5SQBBlQB0RjyNn_PFHmSX_Jul
X-Proofpoint-ORIG-GUID: 70mpzFq5SQBBlQB0RjyNn_PFHmSX_Jul

On 06/02/2025 21:50, Darrick J. Wong wrote:
> On Thu, Feb 06, 2025 at 10:27:45AM +0000, John Garry wrote:
>> On 05/02/2025 19:47, Darrick J. Wong wrote:
>>> On Tue, Feb 04, 2025 at 12:01:25PM +0000, John Garry wrote:
>>>> When completing a CoW-based write, each extent range mapping update is
>>>> covered by a separate transaction.
>>>>
>>>> For a CoW-based atomic write, all mappings must be changed at once, so
>>>> change to use a single transaction.
>>>>
>>>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>>>> ---
>>>>    fs/xfs/xfs_file.c    |  5 ++++-
>>>>    fs/xfs/xfs_reflink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    fs/xfs/xfs_reflink.h |  3 +++
>>>>    3 files changed, 55 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>>>> index 12af5cdc3094..170d7891f90d 100644
>>>> --- a/fs/xfs/xfs_file.c
>>>> +++ b/fs/xfs/xfs_file.c
>>>> @@ -527,7 +527,10 @@ xfs_dio_write_end_io(
>>>>    	nofs_flag = memalloc_nofs_save();
>>>>    	if (flags & IOMAP_DIO_COW) {
>>>> -		error = xfs_reflink_end_cow(ip, offset, size);
>>>> +		if (iocb->ki_flags & IOCB_ATOMIC)
>>>> +			error = xfs_reflink_end_atomic_cow(ip, offset, size);
>>>> +		else
>>>> +			error = xfs_reflink_end_cow(ip, offset, size);
>>>>    		if (error)
>>>>    			goto out;
>>>>    	}
>>>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>>>> index dbce333b60eb..60c986300faa 100644
>>>> --- a/fs/xfs/xfs_reflink.c
>>>> +++ b/fs/xfs/xfs_reflink.c
>>>> @@ -990,6 +990,54 @@ xfs_reflink_end_cow(
>>>>    		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
>>>>    	return error;
>>>>    }
>>>> +int
>>>> +xfs_reflink_end_atomic_cow(
>>>> +	struct xfs_inode		*ip,
>>>> +	xfs_off_t			offset,
>>>> +	xfs_off_t			count)
>>>> +{
>>>> +	xfs_fileoff_t			offset_fsb;
>>>> +	xfs_fileoff_t			end_fsb;
>>>> +	int				error = 0;
>>>> +	struct xfs_mount		*mp = ip->i_mount;
>>>> +	struct xfs_trans		*tp;
>>>> +	unsigned int			resblks;
>>>> +	bool				commit = false;
>>>> +
>>>> +	trace_xfs_reflink_end_cow(ip, offset, count);
>>>> +
>>>> +	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
>>>> +	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);
>>>> +
>>>> +	resblks = XFS_NEXTENTADD_SPACE_RES(ip->i_mount,
>>>> +				(unsigned int)(end_fsb - offset_fsb),
>>>> +				XFS_DATA_FORK);
>>>> +
>>>> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
>>>
>>> xfs gained reflink support for realtime volumes in 6.14-rc1, so you now
>>> have to calculate for that in here too.
>>>
>>>> +			XFS_TRANS_RESERVE, &tp);
>>>> +	if (error)
>>>> +		return error;
>>>> +
>>>> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
>>>> +	xfs_trans_ijoin(tp, ip, 0);
>>>> +
>>>> +	while (end_fsb > offset_fsb && !error)
>>>> +		error = xfs_reflink_end_cow_extent_locked(ip, &offset_fsb,
>>>> +						end_fsb, tp, &commit);
>>>
>>> Hmm.  Attaching intent items to a transaction consumes space in that
>>> transaction, so we probably ought to limit the amount that we try to do
>>> here.  Do you know what that limit is?  I don't,
>>
>> nor do I ...
>>
>>> but it's roughly
>>> tr_logres divided by the average size of a log intent item.
>>
>> So you have a ballpark figure on the average size of a log intent item, or
>> an idea on how to get it?
> 
> You could add up the size of struct
> xfs_{bui,rmap,refcount,efi}_log_format structures and add 20%, that will
> give you a ballpark figure of the worst case per-block requirements.
> 
> My guess is that 64 blocks is ok provided resblks is big enough.  But I
> guess we could estimate it (very conservatively) dynamically too.
> 
> (also note tr_itruncate declares more logres)

64 blocks gives quite a large awu max, so that would be ok

> 
>>> This means we need to restrict the size of an untorn write to a
>>> double-digit number of fsblocks for safety.
>>
>> Sure, but won't we also still be liable to suffer the same issue which was
>> fixed in commit d6f215f359637?
> 
> Yeah, come to think of it, you need to reserve the worst case space
> reservation, i.e. each of the blocks between offset_fsb and end_fsb
> becomes a separate btree update.
> 
> 	resblks = (end_fsb - offset_fsb) *
> 			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
> 
>

ok

Thanks,
John

