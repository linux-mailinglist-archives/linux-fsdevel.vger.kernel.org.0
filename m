Return-Path: <linux-fsdevel+bounces-32104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1DB9A09FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A331C217C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815D4208D99;
	Wed, 16 Oct 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G7Cl+luh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bZNzGLmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C10208D87;
	Wed, 16 Oct 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082222; cv=fail; b=Gi7PFWz95n5nH23/gwLD5OZxOmE8ww/d9zoA7bunVyoZ6SjQP/PvOnRYIDo7iCohIiKKVnPxnJtRsvp3TdskbDgwgQNTavVcbhJJdRT6iQqikyYqJZoy50HVURyqHKltNbhjFJXlc4gpezx/CDyin7Cu/gNZJKffoi2QUR5QRX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082222; c=relaxed/simple;
	bh=B7OKgsiyNY9IbSzELjSBgiN6ziwReqiqXbo5k6Dqe60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=us5Kl4oLPCLJcbOkOo6YW6BDhqnfuDm8/s/JF/k4BbkkyuCGndyZ+sapkcVPJDOsxcDFNDCu3fU+hY83b3cQZt49TGgpftfi7PsTWuYWR9yRMqCGW6UlkXo9srYJuz3I5Xk/ttLUUb9oeZLNFlQcPr+84TWHmx/M4FO3uULrOg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G7Cl+luh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bZNzGLmX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GC8FpG017479;
	Wed, 16 Oct 2024 12:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wOlYywul2l4VwwMeb0cm5py93TuAn647xXucvIoKFWs=; b=
	G7Cl+luhpLLItjlNNOrI/KUIicZ2bicLdBedEWVeyRa992uz9erHvZc8kG3nWcNW
	H3/3s3nTBNvktTI/hnJIcgWRWUGsz0WI7VqT/yvsXUIQ2CtPiJDJYoSUTDrpm+/z
	Z9qNhxBYQp+0zzTTass2/nYMqjaZVz/ObSt0SCm97fg/2USV2YrWpTLTPkOPNjGu
	N9iZg0ip3XUAT+dp61VR3nEfGQBHkYf+saHrwVwwYVmA/xpEfeAnBeFO8a4DFVOu
	FsYxk6bd6jZpTS6vU+uX3BXGtF6wTohsh+60q/KQdyscIr8wG1El7sZ/oRNgdTNs
	XhQ/MW3T0c9xAqq3YlA1WA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2kqea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 12:36:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAUnMj036673;
	Wed, 16 Oct 2024 12:36:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjf5pq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 12:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jO225VtZ9euK2QxvznQdJ33zLgaLkQAKiIcLkaxZp3S3a2RcSEAR1//gxS/DdM62jdV4Y6PjyvQGlIaS4dZsw1y5J2jOQcVZjEykzCHyVUZ/C284HXoFScfboKZFbTYjQQe5xxdu+v7apMxghajFG+fgbbWka5dNVWF6MBNR1S9UDM0lXTNtxs1I+U9wpDtp4xRx8Q7ifATg7AuunhpkWfhCUXD7cU9g+I4kS21qApD4HAej5u2U2bKkauuy+VcbNedPFy1xr/2DwbgvsDGQxIHLNDccO6ClVv2xBeDxIp3AWAWu9amp+kYNWKpKE4hlNY8+OJusol0uNcKOnKImKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOlYywul2l4VwwMeb0cm5py93TuAn647xXucvIoKFWs=;
 b=quciR3zEXFT0j8BGfIIeUUEES5TTlUpWvJtw0VELFRRsQpZ92xWiUaDBt/upVRJr9HlzKu3awzV7AhKhZPYJOIXfUvgmPYAgToyEKzN8uYm2u0M6DPhvzmeOrR+MyZuHBT8bfu5+lrjWD82okSvW9NiIViyNTYVOwLuySxxHcUz03a6b+KjmGVKsN3cuYPFzSzMKdR673F/tq5So2KE0oZ4L9XlyjooA8uZg43H8eRnbt7Yj3grzmuW0MVJMFPFoHT3a2OhpQHZx/J8qYlbXR+cAOOMj7PzDP5k+5kgtvdZAiwFfkXlWIE1LijX/LUnGoqMB7+fmE6GV1G6Z7MVw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOlYywul2l4VwwMeb0cm5py93TuAn647xXucvIoKFWs=;
 b=bZNzGLmXv2jCWkAB/lL8KfW9ugZwETFftA06fxyBZ2Q7kNqZc4wlmTUo5+ZPsginGvvjbnXT7J8X9gVcVZ8xd+twmIjRbtQBHUGLsy4/ZwsKW621K3adrRoiCgsx/cHhk3S4YJ0gnENP3SYX76qrRhKZMltsJP6b2agbofKPa3A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7496.namprd10.prod.outlook.com (2603:10b6:610:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 12:36:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 12:36:45 +0000
Message-ID: <e56a3443-6195-4171-8c22-b78450f0ba26@oracle.com>
Date: Wed, 16 Oct 2024 13:36:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] block: Add bdev atomic write limits helpers
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
 <20241016100325.3534494-4-john.g.garry@oracle.com>
 <20241016122919.GA18025@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241016122919.GA18025@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 258f99ed-57ec-4853-5390-08dceddf31dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?My9yZVV4b0pBaUJXV3JsaGJsMHY1OWphNmFONnVoZlVjdlFFaWFJWUR1R3dv?=
 =?utf-8?B?ditsRXRGOWVwNlVUb3BVSkZIQlIyWk42U0IyVzRiUkRoRGRIb0FGT0NuZDJl?=
 =?utf-8?B?Z2lOZDBEYnp3cEs0Tkg4dlJ0a0tBN3QvYjhzMG1XOTZiQTYzenB5WXFsdkU3?=
 =?utf-8?B?VUk4ak9PRkhtRjIxUVJMaXhTZ2ZhbUVoQ1NWcVNabkRKSUFlR3o3NTNIN3Rk?=
 =?utf-8?B?UVFYcVBnZkVxZ3k2Y3piUExjUWFQd0drNnhPWU4rbGE3RWE1Misrc1RmVk5h?=
 =?utf-8?B?Q3p5a01kdUNreURqVm1OYWk3SFl1TjJpSTgvelZoeDFSRWZwL0NaMXdwdlNq?=
 =?utf-8?B?TTNvc3VveEtrUGl2N3FXMUFnN2RuQkN0T3lqRlExVWxtbjJYOFV5UEZ2bkxq?=
 =?utf-8?B?S2R3K3diUm5leCsvTjJXcDQ4dkpEWXljZ2NjcXVXZ09oS0VIclFiTnk0MEQ3?=
 =?utf-8?B?Qm1sZTVDd3pFN05EUy80cVkxcndjYkJRellrSmowalpoamxndS9TQnBkUTEx?=
 =?utf-8?B?bXk3SmxVN2I5Tjk3ZkRWSmg2MFRyeHFsZ3lrclNIRVlkRktvc09aRWJXU0RH?=
 =?utf-8?B?Q2p0V29TZ1FjSm5FWEhHUEE4QjdFcjZhbVBRSGplV1pHWmxYa2IrRlh6UW5Q?=
 =?utf-8?B?UXlPQXRuL01iUldrWXNlYmQ5MlFHZFBXL1h5M0dYMlFEUWdDTWRiL3MyN3RC?=
 =?utf-8?B?eDFZb0VJR3lFL09UNnRsNGFRMzNNbmZRQmNlUnd2clN3ZjlxSkhIVGxwWUo0?=
 =?utf-8?B?RWFYSTg1bTNqM0U2RjkxWFY0Y2tLSS9iSEJTZzliNEhoY1VPS3VvdCs2YU9Z?=
 =?utf-8?B?NUxZK082dHphemd3Q09ia3NJbXZMTFdvVVpWRXlLQnB5VG9SM1dEelhHRjBn?=
 =?utf-8?B?bW9HdlVyeFE0VlFZMzlFQ2dGUnJJZWFBY2ttTjB5UG56aFV3R25scTh3VXMw?=
 =?utf-8?B?aWFIVStsNGVzNDBoSWcydmNPN01FWlh0WlB4bXFZR2lzN1NPc1ZRMFVOaENH?=
 =?utf-8?B?czRvUTJSTzJIOExYWlNTYndUU214UUg5ZVFwRkFCbyt0bUxBRnM5Ni9zMWV1?=
 =?utf-8?B?VFBQQVJKeXg0R01nVWVEUVd6cWd2REI4ck9xQm14V1VQZThZZ1plVTBHUkJm?=
 =?utf-8?B?RjJlakRzY3RBR1kxQXV0VjVTMzd1ZmZqVU1VdVhXWjNQb21pL0hjbUFRNGNR?=
 =?utf-8?B?VWE2NFQ3UEQ5UDVzMDE2bEFmQnhhaFNzUkYwVncvL2VHTkpLV3JiSHdJWEFV?=
 =?utf-8?B?bkRReTdnTkVRVDZ4MFE2MzEyZWxEWGU5ZXZYZ2NmbjJLbmY4OGtmamlVUTN3?=
 =?utf-8?B?NFRhQkw3aUYrejhLd0UyQ3NBcVZYR1dLMG5lRG9xUnI5MlpTaEpNaU9jWDJr?=
 =?utf-8?B?aEQvZkxyOUkvNW5oMWV5WjhtZHVYUlRNL08wUEFUQ0pGNjJjQXNuZFJoWndx?=
 =?utf-8?B?WCtCM1JpczNGdFJTcTNmMW5zQXl2SlV6cXpkUFRXT0kxYzN3Z1dNdFZ0eEJw?=
 =?utf-8?B?VFFqOUgwNkl3ZGM0N1hIL3ZncXR0S3U3UUlOR29ocnNsWEwvQk1vMTdUTGVt?=
 =?utf-8?B?a1JwNDJhcTAzbGZCVTZBeUJwZzV5WjRRUnIxTnVCSTVlN01zNUIzS09mNVlC?=
 =?utf-8?B?UEd0WFl2Z1dWVmhYdThoR21oT1ljZ0twMmZUWkpQV2tVSW80Y201WjQ4RWpa?=
 =?utf-8?B?NnE1bWhpdE1pVHVRVkIwYlkxOURnbFN0ak9WMXllRHo5S1VWUVVXS3BBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0lib1M3YlJRVHV1bWxGTzQxdGdpajJhQ0loMlNodDFiajJNNGltd3hYdUt5?=
 =?utf-8?B?QnI5MkIwN0FjV3FsaUFvcG8vTDdRdEtEZjJOVDI0a3NsVWVSMlhVOVJXOUJw?=
 =?utf-8?B?NUppY2I1NG8rdnc5eWdSRE1ubVhBYWFlTUswYjc1a3lBd3VSMEJSTjNZaHll?=
 =?utf-8?B?WUpQcysrSzZ3dm9FVG4vb3NQQXRIT01DU3VWVm9CeEE5TU82ekJXdUdiRElm?=
 =?utf-8?B?bGJjTGtuUVVPQm9jK21ZSjZFS09WOUhuOUwycEI1dHFqekZSTkNMS2FzWHRk?=
 =?utf-8?B?UFBhVHdVb0wwSndqN0p2UHhTRXJvK3NHcHBmalIvTllVemZnNnBuZGRkU1M3?=
 =?utf-8?B?YldCTXJCTDE3N3B0SUwxbEhCNDVzblNuZjJLQno4a21CRWFGOUUyOHZpK2NG?=
 =?utf-8?B?aE92VzQ5Vmd0NE45ZFBnNlI3SFRpNzFlOENUS0gyNWt6VFpWTlRoTmk3NEd1?=
 =?utf-8?B?dnRYVSsyNzVUWFdKbGY1U2t2ZTN5Tm1iemQzaXRmdWtaRVdLeWxzMFZEMi9t?=
 =?utf-8?B?MWhxVFZaZlBVMzB6VGVJN29FeXVqaklJQUp2am1Wa2ZjV29iMVVNblloN3Zj?=
 =?utf-8?B?eGV6VkFtUkZuNUNEUSswbnVUZWtxTjc5MDBvOEtzNG1QZ25NTEFTQ1dnV2dZ?=
 =?utf-8?B?YU82WkdGRmtBdUk3MGpwR1JlUGxXbmJiOTZGbEtUTVM2RTZheHVLdlFyTHVK?=
 =?utf-8?B?MjJBNXc5bExuOEFWZjJTREZ4ZkhOZTZkV3ZMZXZCZHNYVHh0UGc4a3RDV04y?=
 =?utf-8?B?TlJwdnpGeVlXQlo2dWFrTzZXSUR4TUptb0ZXMk1jV1FWNC9lb005bUlBb2hS?=
 =?utf-8?B?NUs5K3RxSEFadWNoK2Uwd3AyeXRFaHEyMFNKL1M4VkMvVTZ1c3VNdEVtZHBP?=
 =?utf-8?B?a29vSTNRQzQwTzMxV2hGUmZHVWFUTGw1cXFGYlFuUkI3bjdpdmNld3BHOFR3?=
 =?utf-8?B?Q3ByL0RoM2dwejJKS2tGWG9yOGNwYmtRVjF1ZGxicUh5eEVuc3pWb1R3ZFlx?=
 =?utf-8?B?ODZBQ2xkcmpQa0NZVjVYeWV0U3BOMGpDSUFiUWoyOXZlZmNWTWFyenk5Zlhk?=
 =?utf-8?B?cWJQV1EvYkVQZjBkN2IvbTA1djJpRmhYNnZXNlFyMzBxTi80dk5aMDVVNXJp?=
 =?utf-8?B?VFFUNjJpL29Hd01PM1BiYjg1c0szbGxaNTlibVQrL21Dd0RoSm1GQ0hkc0dw?=
 =?utf-8?B?eWVhSjh4YlVWelJkeWZlc2VxMW52bjF0bXA1NVNtU1I1cWxoQWZVMXkrOFVZ?=
 =?utf-8?B?UDRldnltbWF5RExyVlUrbEl3ajZTTTg0M1AvYTV1d2s5YUZUMzVscTJkbGhV?=
 =?utf-8?B?ZzVSbU9Gc09NS21YYUMvK1JlNVM3U1pyUEVVcVhKUkVURUJUZm5kVUorcTFm?=
 =?utf-8?B?SEMrSWNXbXliN0d4MnBZemIrMk1lZDE4WmJYZmRoODBvNUlGbThpUWdhcXJ0?=
 =?utf-8?B?Q3o5MUpDc0UrUVB2OVZzVDN5NlI4Wm5URmdjVnNTV0ZlN3IyLzhmWFpiL3dV?=
 =?utf-8?B?SUdpMzAxdXNEdFBOemQwTWlUQ0hjK3JRVkVZVzhHOTd6emlYY2JOdjhSTlJD?=
 =?utf-8?B?Q0VaNmFtaWZOYXN4YkxXT2JXaFRpZzRPNnJZS0h5WjhhOGlDdnRaZjZpR213?=
 =?utf-8?B?YXA2RWtocVZKTFpFSksrVUFQZnZGY3U1TFBteGxURUtLZGhkc1ZvOGJWNVVy?=
 =?utf-8?B?QlFLajk0eTRyN2w5dXZqdUxJRzNHQ3kwWHNwMlpxRHhUNGJicis1L2FnN2Ex?=
 =?utf-8?B?Z29kbUg2TXlTTC9HRnpDQU4rTlc1a2J2TDZXZURtR3ZOTm05aTBpTGJyeDVz?=
 =?utf-8?B?Qm1mWGxhNkxWMTZHUHkraDU1NEpBU1FTN1J4aDBMV3A0Yjg5dEdSa3l0aVRy?=
 =?utf-8?B?cHY2NkcxTnN1NVdoQ1loeCtneThzc2YzWUcxN1YvSWNBTHdaRjFsMjNsQTRV?=
 =?utf-8?B?OHNWYS9KU2VGVTYwekxWMmRSYVZEY3Y2Q0xmc2hPbC90TWsvYnRidHUvWmVJ?=
 =?utf-8?B?UUxsbGJiUDA4RWUzeExETFFxQitFOThIMHlVNmlPVGdKUk92ZzhJeEc1UXVm?=
 =?utf-8?B?ZDFHazhJY0QvbG9UNDFuTk5lWUgrZE1nMU13QVZMNWZ6Kzk5SlRQUUgraWNI?=
 =?utf-8?B?emJycjRrNWVCSWNudi9tcDlBd1hkdjIzTGQ3QmJnenYwTFFhekg0WDdVUEJr?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7cbcWLmq0LbXcadDW/d9gnzSMGTLVR796g444l3AVdSJd5/moraMVwdRji6veNPXinCVuq7LMAxnKgIF1xrlVO2NaJydP1UUqoq19K865Xc8ixFEXdstznQiju32mAy9UnPbhRvIGO+18EgN8pOIQEFkcZK5cSY9+kk3o5lC2b7dQtSRSotUsY+Ne7dRIY83PO3UegHUdfMJmdnHueSpsJZAy8oimjo0IYFQ3+BdBP0Ef10pt7Syw0Z97REAJRNR5ioIiySese918N+/TOMGyApGk/BfKLCWRHoluDGrH5SzRImDW8IPHRtJ2xuLXCUnnVaEKYW3mNfoHmDiQPpV2e/5Caivh9oG6bcOHv4emVkRTfnYRrd/wFPA3zFjNc8ZGaXdKfyc45ZdX7Hld1iSpdsXTiFvtcbIu1YN8Cekoi/IJTJJFKSzpjIPD6hWGUUMZPnCRIcCtBamflPLBm+JVYlw6DkfrIeGXKNj4IrEjOzMYzV4bHtFOk3MjbN2r2BJ/XCmuLFoDb/HxAdiK3KxAeAWSV7jaboH8AgRfPJPFZcwsYq4xvnLOweyyOSBR5bfUJZ2LFObp9GW2V5qTng3Ju0YvuEowAUEoV525rX3ZmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258f99ed-57ec-4853-5390-08dceddf31dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 12:36:45.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPLCAfoYziJcgK5p6ztTdTFb1wz0wxfExsz2HIB0PJllWE1lsi1Q9ncztc5KG0P3slTwSoQAydPYRTohZzxuCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_10,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160078
X-Proofpoint-GUID: wUid2bgCdD_ifrsaIC2bsfzGrp4CXCjb
X-Proofpoint-ORIG-GUID: wUid2bgCdD_ifrsaIC2bsfzGrp4CXCjb

On 16/10/2024 13:29, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 10:03:20AM +0000, John Garry wrote:
>> +static inline unsigned int
>> +bdev_atomic_write_unit_min_bytes(struct block_device *bdev)
>> +{
>> +	if (!bdev_can_atomic_write(bdev))
>> +		return 0;
> 
> Aren't the limits always zero when the block device doesn't support
> atomic writes and we can skip these checks?

Not necessarily. bdev_can_atomic_write() has the partition alignment 
checks also.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

thanks, but let me know if you would still like to see any changes.

