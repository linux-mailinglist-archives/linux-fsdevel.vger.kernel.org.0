Return-Path: <linux-fsdevel+bounces-41059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFBA2A713
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9123A8529
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676712288F2;
	Thu,  6 Feb 2025 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SB/fj7wW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vG2297Ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B42288D1;
	Thu,  6 Feb 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738840259; cv=fail; b=uKiTHJirshXXoeuNsLovJtgO0sMzFOpUbkQRrA2f3sashbrJJb4U4IsjZ/SyEFZYYjPH5MK54ClPrliKw2eR711PLUNc5nCUKBEYSWTwQY8jqcfZHaqXeiq1EiQKio5jTxxmKnLidtpR0AvsJ82AFb7iUsMbQDMsPeE9MjVVuXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738840259; c=relaxed/simple;
	bh=u6GyzzBLPjtq2SIjCIs93ugt7Q+M2eowmgVLpVPipGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TmF+I3GjuOPGn6WnHk9p6eLj5buTEP2a82oVI/5yJiCrlqq36HydiPqaN7LvnB4aeX7M1C2qDKHUTWbvrTjFaWwi5q/T+wSRWp2b8+sxAt7dr8XF/1A7QzMd8FLBm19VAchFYc9cVW59nB68A/8pcO4HNGmTmJl5mkpPljNnNJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SB/fj7wW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vG2297Ny; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161fuxd007535;
	Thu, 6 Feb 2025 11:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4PLmZHu/4770s711B9qT3ebbIzZctfULIseBbBnicP4=; b=
	SB/fj7wW1U3f7QbRa2J1tAJ4fqFZzDeXNkqbQlqfMTqI26CCkcQfNqj+eOorXMsa
	LFwY3tXlM2qIw0N8Dc14i2F9WMCOT6oOVkdDzcmNdsXYXG27X1zMmVZOx5b9mvuv
	kM0bHsd6q7b9W7O4xA0R1yl6ZVTBmeiH1PLBUk70W6+BMUX8uHS8RC3myY5YNH9e
	ymPyRNMubeone7jXujM9aNkg/+TpWnAL87TqjxY99pLO3+nrwirhTxWdxvPRc46X
	xyp2A5KWPnQY5icyA4yn7BXH10SltZbEkrh//081w3uVg7aj1xErvOLsAfHpD1Tk
	zbqW0K8hlVRVuR3fumP7yg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50uacrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 11:10:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516A4lN1022576;
	Thu, 6 Feb 2025 11:10:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8eabpj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 11:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8vqUKB6MhPDTSddbgONP8LSXyPptS24egVTA+EO2Z8DBBRxUvdt/sbNlP8BmkHHI3O739fLe7vBnBwU6lJxq6nCxydD+vssoC7AXemwGIKOYzVCq3Ol08iMNJrvsEFLfRPBF+5QaqGiPz22HN8fUNN66F1iO4+hac+oiws8YEdSZrY5lRdmhmbv03N8gRRK+QMhodg91zpemkwNtlWkl/6gYqenb8rgVny7Zr1aupwlSCz9Wqq/zeJ1agbHgOIxcjGbGUvsC1kQ2ymh4zPp+3S00xHHQxQ99j+L6jaCXZkavfzBrVI4W6ajmWm2+tUdp96Zswr4IMlB6QXoqsZkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PLmZHu/4770s711B9qT3ebbIzZctfULIseBbBnicP4=;
 b=Ov26QTRxgLieP8M6E+Wgthwj0R4mCyGhHZVALKFlZMMpl0CRzac2vqJ/Ghs2oz8R34FhWJzkXrQfcC35UtXAlfM7lQdLOlIYTl+S9kIzXNMNsmwKleumkUSpdQcXns1/+Cb72JgwsfItxd+HdoutprE7QBeTZRWzIhxZ6isuOiOIlVos+wHmdy2/yfYlHbR3d6KHEkGcQQkQMXUgUHw6LGZa0sI4akog4MYKqnQTqWPGAl9cgvokv3Z/j9vZE0QqPpsotGr5kp/DB0c/CIpK7yZgSxVWi8VVQ2ky32tJgL0BP9UfO+HsvKxhOhaiClI834RTP5V2hZDMSd0OPCjg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PLmZHu/4770s711B9qT3ebbIzZctfULIseBbBnicP4=;
 b=vG2297NyEkDwUWVNsXqm+FeaaXTh2b0VRXkRJ1L3n0ryaIE4i90Hhnb/tPEwqkzdwGwc40uembjpS9bB/Jw/kLMkJREwNvVMKHn4ZseDopCPCeRNlJzJpo+tgjfY0+foeWcPkFYPBPzlgpbX/n6njV6Qg2NTD3rdpkVOYeo+4eg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6669.namprd10.prod.outlook.com (2603:10b6:510:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 11:10:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 11:10:45 +0000
Message-ID: <58f630a4-3e02-451c-bd6e-22427cec5c11@oracle.com>
Date: Thu, 6 Feb 2025 11:10:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/10] xfs: iomap CoW-based atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-7-john.g.garry@oracle.com>
 <20250205200517.GZ21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250205200517.GZ21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0511.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 281ea6e8-6b22-44f7-b682-08dd469ee6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXVuS0xWMHhZbFE5T1Zxem4yUXR3VnMxZitOWDMrSFVpdlRud091dm5IU3lD?=
 =?utf-8?B?RVJENWE2RXR5bllYSmlNRSs1NXZOMWdBTENzY0xjaTBLaENGbll5QSt2c1Ri?=
 =?utf-8?B?SHhGZjMxeFN4cEREVTF0R3hUQjJmcVh3SStIK1BiWFlYTHdBcENCZ1VLRkJi?=
 =?utf-8?B?NFhjQlZ5aGt4eVVIUGlHWVN3azJIRDdaMGE2M1JYWW9tS2ZEQmJGK0U2Tklq?=
 =?utf-8?B?SXhNZGsveDlLNlNnNzQ0S0hBYlczOFZKMHVUMDNjd293SU91NFNwOVRETFlO?=
 =?utf-8?B?Sk5pbFg2Y1RLd3VBdDRsTHN2SU10cUgyZThxUStGQXArRGdxOW5QSlQxSElN?=
 =?utf-8?B?ckd3R1dmZ1FPUnJTVTBKdXlaR2RKdVJIVytHcXF6SkY5eFhmZW8zTDZhQlUw?=
 =?utf-8?B?R0x5ZTkzVUU1TExJcDBMZDEwRlIzb3RkSGpsd1lzVVZDS01RKzd6M1AwSjJo?=
 =?utf-8?B?a1VTZnp6ck5nVUtKOVNmcW5oV1V1RUlBL2JTeEtrOGFsSi9uYmJnS3FtOHZv?=
 =?utf-8?B?elhOb3h3UWthNFhNbkMwSUVuVFhsNmYwWFRWa0RqZUY4dDlkSlJEN05ram9O?=
 =?utf-8?B?aHFFTFRRSHprWVRnQ1BIZVJzanRPRkxSR1NETTdxQkl2YmluTFlDbUFZUU1i?=
 =?utf-8?B?bGRYUnFKTEFrMkhWNXdwdHhEVko2aGwzTTlXK0lXdzd3b0xNMW1HMnMzRXVy?=
 =?utf-8?B?Y25MQzBYa2gyemJVOElsRFhmSXp4QnJ0UFlaUWJMQUlaUm9hUDcvK2JpV3FW?=
 =?utf-8?B?Nmg0VGRELy9NaU9hNktqUHFDRXF6QmpPbXFEejhTbVp2OEdoZndlaTdleEJI?=
 =?utf-8?B?L0plMEFyeFpSV056ZHRkL0ZVcGdXUlhVZE1VdDZxNGk2emkrN1dxblRIVnFB?=
 =?utf-8?B?ek92QlgwcUZ1TUw1TlUrTFNRcjQxMzNjUFZSNk1aQ3g0cjRLaGFqcU9rM1Nr?=
 =?utf-8?B?WGxPU3dxV3NNNjVwQVFTU2ZiRVJlTXhDUVUzK2xqUExXWllleUY3aDhuWVFz?=
 =?utf-8?B?dzltRUJ5Y3hrdnlBL3N1Wk1sWVhFYU1yN0pJblFpdEMrVlBIVHNicTJzcStD?=
 =?utf-8?B?VVpOQ1NPczdkQStLWDQyVS8zdXFtRWN6VzF4R0Z5blA3UGV2Z0pqMUNHdkND?=
 =?utf-8?B?U2IzWDdSUHlqLyt0ajhrVDZOMW5lTlpGRUg0Z2YrWmtwQ1p0R2RsdWNVbzY1?=
 =?utf-8?B?QU1xaVhYRzA5QTREclpzclZ3MVJCZnlBZUNxOHpJaWQ4TXdIckg2RU9WYmNh?=
 =?utf-8?B?djVsVVIxbXBPQ2Z2ZzhpYjdQODdrdU4rSHNXZlBoY001K0JjUHY3SHEvTVJD?=
 =?utf-8?B?czdJdVB5dkU2ZVpmRll2Zkl1UEthM2N0Yi95ZkpXb04vUzB6MmE0dllDY0I0?=
 =?utf-8?B?SWwxY1QyNUdJVHBUTmRBM09NWWpwUmdsVFJRbC9wUHEzczE5RldTaStsKzl4?=
 =?utf-8?B?RjM0THM4eVJCUkRVbnMvY1oyTzRKeUk1Wjdmb2E3Z0lSSXNFYkQ0WHpoWVdP?=
 =?utf-8?B?azZGQmRjdDdVK1BvZE9JSHVRT2ZGNUFqYkRMNzZjUXl3eStWYThTb1JjWXhI?=
 =?utf-8?B?YVV6ZW15cFhQQ01zdytFbUJteWtIVExHNVhVU2tuRjdocU8yR09LYTVOZUJH?=
 =?utf-8?B?WktCVGVQeHVkcjYxUnc4UGZ5Q1RQMlZvdmJ5WVM5QWV1akxXVFZPL2VQMWk2?=
 =?utf-8?B?MjVhZzArcHNkV1dERkh3TmlnNS9ISkxsVU92UGpyRzBwUzdrUEc1c1M5Tk1N?=
 =?utf-8?B?b0lxSTVpQnlBSnB6WjROcFlyUXl2d1RkL2VBam0xVE1lazVCZW9mZEd0THRP?=
 =?utf-8?B?R2NrMTBrallMYTd6K2hHVUM5RjJFVVpxbWh5MU4rd1RjK0t5ekZ4VkdtNldE?=
 =?utf-8?Q?a7VyxtUu6zPGy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGtQY21qYmpXOGZGT1NONzdBbG1DTXBxeFpyS1JBMW1kbmJGYjFWSEd5N2VD?=
 =?utf-8?B?TmRSN3E5TXYrYmV2M1hJREM0REdULzBZRnk2aWJlczRpdkd4dTVINXJkS1dx?=
 =?utf-8?B?alVkQnc0M2xFMDVVSDNQVWdEOVdMaHZoTlA1ZXNucmdVZks0bjR6SVZid3Zq?=
 =?utf-8?B?YStNTzJ2TlBWRGNUNXlIdlh1QWphMkxEWHNVRFl1RnlobU5rRUtMZXRPV2VI?=
 =?utf-8?B?ZElJbEd3OTNndDUveXc4R1hEcEhYK1pPblZlT1F3eGVBV1JiT3M5VmVRcG9r?=
 =?utf-8?B?NmlTMzBwc3l2cnJIeXlyYjNBbmdscmd4TXpKaFhmc1B6amNCZFR2dml0K0w1?=
 =?utf-8?B?UVRCc0Z4NFdTS2xDVHJJZlRWc1FuVkJuSlBlN1NUTTlZUURnd3dkdnAreWZX?=
 =?utf-8?B?VHdnZ2JOb3g5ZVBEMUdBWDZqN2pGUkNnN3hYUGZRNXpOZzZXeGU1cFR5VzRI?=
 =?utf-8?B?bmNWemJ4TDdDcGF3M2hacUoxQ21aMmZGY0JFWllSYWkrSzVQOWNpcExCZXRV?=
 =?utf-8?B?cDBrSFpOV0xKY1kvd2JXck9nQzZZclVCZjA1Slc2Nks5REk1bDQwS1hFQWpj?=
 =?utf-8?B?UmRjeUs4bGczTEk5OUhMaXNFQktob3VzVkUrSE1ISTBGcFVWeGgwVUxLSExZ?=
 =?utf-8?B?eUhTOGk4d3AyOHE3TTVBdGtXLzRDVisxaXdWRk9NUmpaOEtQVXZFaGQwZDBn?=
 =?utf-8?B?czJDaUJYTzVTK04ySVc3aHgwQTMwaVRRYjNRQUlyaEZabUxwVW93OVBVd0d0?=
 =?utf-8?B?THZweC9zRzM2WWJRL25oTFFmTE9jbHowd3ZsM09tU3A5dFlQVTdLV2Z4UFVa?=
 =?utf-8?B?R3IycktJWEtQUDRmSjhYRldTYWNBRFB3T215eS80dTNFd1Arak1mYm54RCtq?=
 =?utf-8?B?T1RCOW5KWlJaVEZiMzVMMmh2eUFyQ1RYSWlZS3R3eTVJaTY3WUJYSzhwOHY0?=
 =?utf-8?B?Q1pUQkI3aVlyWmZ3dTEyZElqUjYvaVgrRzl6bjJHeERnQUs0bzZKU1JQN1RX?=
 =?utf-8?B?VzQ0UjdWRjVEa09wK2M2Z2NFNjV3K25rbVNrbzF0Q2llb0lTMmdVSG1ycVBX?=
 =?utf-8?B?TEhpVDFHUlhUZWlIbjlSZFk1Z0k0RVJqWFAwM2xrVGYyLzl4dUwrSHFtQU1s?=
 =?utf-8?B?Q3dvamJTZ0lRcDN1aXBmamF2OHlUenZyWXJMKzFoSjhUNTIxN3BmMWZ5ZW5S?=
 =?utf-8?B?QmJtenlRU0JIeDgzbmFkVWp3R1pWNmxqSnZab3NYYitzUDVRSWl1NWIxMDYw?=
 =?utf-8?B?STBKbFJpaDFXMWhPM3lHYkJuRlhreDVyZzc4TksyMGZoRXlaalk4elRDUWp3?=
 =?utf-8?B?eW40R0k5N29jMkNsWTh1bnBKY3JLWm9WYmV2VjhQdTdYd2NPY1R4V0RSRlpD?=
 =?utf-8?B?SkRQMXBvaEI3Z3lua3NZYUJESS92cEJseTJnVjJGV3BkanFKUjBNQ0s5SW1J?=
 =?utf-8?B?aHdpVWNnV0svUi83UTh6WklYS2lwTWV4MVN3RlY3VEp0M29EWkwzeWgwdWxt?=
 =?utf-8?B?bjJYVHg0VkpDcVlLNURlSkRkK0tVYnVpZXA1dGVqWTlmakpzQ01TSjhWQ1Mv?=
 =?utf-8?B?R1dmRnBvU3NkVG1RTlNWQ3Raa21hOHV1bXJuSWo5OWVBYkhsQXcrUGJrTmli?=
 =?utf-8?B?L3pBS3NmUWtDaEdWYlpWWTFXZmRsTnFSenB0QmVFYU5Bd3pseHlZbk1oVndm?=
 =?utf-8?B?bDZTbktVai9EZ3lHSHgyKzNLc3FiMG1PL0djWmVWT3hyakFqRUJzYWtTQjJG?=
 =?utf-8?B?Vi9meElmUDNBQ2VOUFd2aytvWnBubTRMakhQYWtCellWUXdDZU1BTzhTWHBJ?=
 =?utf-8?B?Z0I1NWVIZzVUNFI1YTYxekx1blhDSXpmd3ZqZlYvYTJOTUZpV3hwbzBXU3ds?=
 =?utf-8?B?WnBLQlluWjVPT2NXcmh0WTdCOHAvaUFYc2ZzUC9lTk5SRElTaTl0WVVkOGlD?=
 =?utf-8?B?QTYwMG04QStFUS83N1FDL21sRngwaE83SGYzTVZEWkJvOUVBSElwaURadHB2?=
 =?utf-8?B?VFJDL1hGQThwM0VaRVhCQ0J4MUhFNnhaSStDM1dTTmdWNEQySVkwaTBUQ3Ew?=
 =?utf-8?B?WGRmeXk3NjJEMDQ1SWh1dzVFT3ZkS1ViaGhybHhFbWFkQkZFRmhKSjZ0alJP?=
 =?utf-8?B?YnVzVm14aktab3Erd2JVcmRiRDRReElpcW5ZNGhhYS8rU2JtMzkzdWIzaXNv?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iaguOC6bgF2VvaP/fnWIQnH/VZ1l7z2yLlGBH7RsKzu6YfTdlbEci+0Wa6TyhTDiG5nkXVGEfwj2KHT0fSgfjWvCq9RnbwDeD+kzO1ColZ3ybUX0R9IrV92A2FMg+LDizrVdKcqmEZGTCgd4i5oL5mjYgulW31VMuoTNNKx508P6Qt3LAyOWzUPxZKOzkkTa6mzkjLunjj33lMAIIb7qA70K/3CSeZcjSLM5lKWeZETBmoOGgGhWX4b88TAelsPLfMkI/JhgaEd675cjcXza5XyN3EyrI7DJ5q8/VpQ5Ty6IAVYCRwBxpdt1pbryASh5oJPwLiskFiR18yU1JRuK9gsFXpMgm5EXyLhvh6EL+hFcSV6cOtWs9YChFVHnRWnKscxqFLCOP/uR/uHSEYekyiopchPG3/EcKSy4MeGcdzPaubCVIbsevTelVddGZaFV7hKV9/zm5UWBu0qSP/aE7WAnBnwjEX7GQ9XI78YHIL7GTnNb/9MsvGkMcwaxTsNvqPA/hXJy2qLoCU0oCgpy3ArO44C29IUG6Fnb3j8lVU1eSeav704NdSvMrVVBZTOFuppnXou0sb6qVW1UIe/LPS3ejKY8QXpL1BpuBtKJyUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281ea6e8-6b22-44f7-b682-08dd469ee6e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 11:10:45.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlEHwqY3ZI5qhu8hDu+j69qElPD8nXDQjRGoiw8AC3ltqxtUSqbH+vLryCqN651Ewcx1GMlaXluvFxwq04BbxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502060092
X-Proofpoint-GUID: U-HHLlBBd-v4aPJ3KAikzccT5fq3WgMw
X-Proofpoint-ORIG-GUID: U-HHLlBBd-v4aPJ3KAikzccT5fq3WgMw

On 05/02/2025 20:05, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 12:01:23PM +0000, John Garry wrote:
>> In cases of an atomic write occurs for misaligned or discontiguous disk
>> blocks, we will use a CoW-based method to issue the atomic write.
>>
>> So, for that case, return -EAGAIN to request that the write be issued in
>> CoW atomic write mode. The dio write path should detect this, similar to
>> how misaligned regalar DIO writes are handled.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_iomap.c | 68 ++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index ae3755ed00e6..2c2867d728e4 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -809,9 +809,12 @@ xfs_direct_write_iomap_begin(
>>   	struct xfs_bmbt_irec	imap, cmap;
>>   	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
>>   	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>> +	bool			atomic = flags & IOMAP_ATOMIC;
>>   	int			nimaps = 1, error = 0;
>>   	bool			shared = false;
>> +	bool			found = false;
>>   	u16			iomap_flags = 0;
>> +	bool			need_alloc;
>>   	unsigned int		lockmode;
>>   	u64			seq;
>>   
>> @@ -832,7 +835,7 @@ xfs_direct_write_iomap_begin(
>>   	 * COW writes may allocate delalloc space or convert unwritten COW
>>   	 * extents, so we need to make sure to take the lock exclusively here.
>>   	 */
>> -	if (xfs_is_cow_inode(ip))
>> +	if (xfs_is_cow_inode(ip) || atomic)
>>   		lockmode = XFS_ILOCK_EXCL;
>>   	else
>>   		lockmode = XFS_ILOCK_SHARED;
>> @@ -857,12 +860,73 @@ xfs_direct_write_iomap_begin(
>>   	if (error)
>>   		goto out_unlock;
>>   
>> +
>> +	if (flags & IOMAP_ATOMIC_COW) {
>> +		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
>> +				&lockmode,
>> +				(flags & IOMAP_DIRECT) || IS_DAX(inode), true);
> 
> Weird nit not relate to this patch: Is there ever a case where
> IS_DAX(inode) and (flags & IOMAP_DAX) disagree?  I wonder if this odd
> construction could be simplified to:
> 
> 	(flags & (IOMAP_DIRECT | IOMAP_DAX))

I'm not sure. I assume that we always want to convert for DAX, and 
IOMAP_DAX may not be set always for DIO path - but I only see 
xfs_file_write_iter() -> xfs_file_dax_write() 
->dax_iomap_rw(xfs_dax_write_iomap_ops), which sets IOMAP_DAX in 
iomap_iter.flags

> 
> ?
> 
>> +		if (error)
>> +			goto out_unlock;
>> +
>> +		end_fsb = imap.br_startoff + imap.br_blockcount;
>> +		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
>> +
>> +		if (imap.br_startblock != HOLESTARTBLOCK) {
>> +			seq = xfs_iomap_inode_sequence(ip, 0);
>> +
>> +			error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags,
>> +				iomap_flags | IOMAP_F_ATOMIC_COW, seq);
>> +			if (error)
>> +				goto out_unlock;
>> +		}
>> +		seq = xfs_iomap_inode_sequence(ip, 0);
>> +		xfs_iunlock(ip, lockmode);
>> +		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
>> +					iomap_flags | IOMAP_F_ATOMIC_COW, seq);
>> +	}
> 
> /me wonders if this should be a separate helper so that the main
> xfs_direct_write_iomap_begin doesn't get even longer... but otherwise
> the logic in here looks sane.

I can do that. Maybe some code can be factored out for regular "found 
cow path".

> 
>> +
>> +	need_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
>> +
>> +	if (atomic) {
>> +		/* Use CoW-based method if any of the following fail */
>> +		error = -EAGAIN;
>> +
>> +		/*
>> +		 * Lazily use CoW-based method for initial alloc of data.
>> +		 * Check br_blockcount for FSes which do not support atomic
>> +		 * writes > 1x block.
>> +		 */
>> +		if (need_alloc && imap.br_blockcount > 1)
>> +			goto out_unlock;
>> +
>> +		/* Misaligned start block wrt size */
>> +		if (!IS_ALIGNED(imap.br_startblock, imap.br_blockcount))
>> +			goto out_unlock;
>> +
>> +		/* Discontiguous or mixed extents */
>> +		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
>> +			goto out_unlock;
>> +	}
> 
> (Same two comments here.)

ok

> 
>> +
>>   	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
>>   		error = -EAGAIN;
>>   		if (flags & IOMAP_NOWAIT)
>>   			goto out_unlock;
>>   
>> +		if (atomic) {
>> +			/* Detect whether we're already covered in a cow fork */
>> +			error  = xfs_find_trim_cow_extent(ip, &imap, &cmap, &shared, &found);
>> +			if (error)
>> +				goto out_unlock;
>> +
>> +			if (shared) {
>> +				error = -EAGAIN;
>> +				goto out_unlock;
> 
> What is this checking?  That something else already created a mapping in
> the COW fork, so we want to bail out to get rid of it?

I want to check if some data is shared. In that case, we should unshare.

And I am not sure if that check is sufficient.

On the buffered write path, we may have something in a CoW fork - in 
that case it should be flushed, right?

Thanks,
John

