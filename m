Return-Path: <linux-fsdevel+bounces-41043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8FA2A3F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF07A236D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983CD225A4C;
	Thu,  6 Feb 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LqToGjSF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IMCXvd+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2A157A6C;
	Thu,  6 Feb 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833334; cv=fail; b=aLYv/CHfwZTnkuzqPBAvtNGI0BE6+uyu/vHjiGHoLrwuSDItSBO9bSVo0FQ5Q/VME528I4H0rWXpmF18CiJZSQejNGXEk6+jZbQzr/FzTbk94Xd7qjyvKpyHJlopseNu7zMNdQpsN5HKY1sx6MeMqISJq+cCgpGiAcgIxki8YIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833334; c=relaxed/simple;
	bh=kvXaCZQtXeRmCpddzPdjB4lMHb0aO2n1jQMUHkaCS8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/TPfSi8t35sEVwlBzzqtKLinroys0l8gq062kPBuN2GYVc+pNxJt63xv5dJbcroS9iTc5m0gDUyt0/rn+Q27o/oO/Xx2BtgINtVeDt1Ar7v/9tdkN3zsS34Z90TJDAMJfc6C25qRHJlTRqKbovZgzKljCr7Ky1CZ/JzTHzErUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LqToGjSF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IMCXvd+H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161g50P011971;
	Thu, 6 Feb 2025 09:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y3vVkjWhzOG3EM/0Ekj1LKGD21e3J9aM2DzNA2cUUqE=; b=
	LqToGjSF3wY1vonlQf/zp+DgQaKlwvgEyI3ZSXtr57vHzNzHAw+1EJQWmJ0kt1OC
	6+eJ7d6mHuq+TDVK3+yHRx1cY3FIO7LI0JhyX2GeKimVc8dXDf98cyfl9Om//ujc
	KWEOOz8fHd8K+uXsAFm39Nkw9j/UPWgs8YrYQ5Y4i3mbK3jLxiVVQ3IbYGqyJT+I
	D17dEgtJsZK8IDxaeYxYIJQyjvxsYT5KJN3GM/+nSo4apG741Z/cYxdol/4e/4VY
	3vS4FXTv+MhIBJku4sKz9mHwxHtAOkIpur8g6YLdiglltcERl/kSZlj1J1BqFVwY
	SeAqWU7u4wrM0qZH1R7seA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m58cj8bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 09:15:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5167uPPJ026984;
	Thu, 6 Feb 2025 09:15:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fpquq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 09:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc00TrtRSDGci4tMQy3z/2tkVw0AABrmcCFyve2W34GhDxR8tXwz9/7XpQK1rHIrw5DYERfo/mw1NrQFV+El9CqxZuNPMjzCyaSs/2cODHtoX09mYdQsAjEqwYNUZHV9Fe15QN32RAy6b/+pr7ewez1EzXKJ0G6lhcj/97T9NT94Tm9oP4t41iMcCVPSfP/xEk7eHw0QJ1UnXeZ4r+WLmJ3HKWY1+1OJboXD4nMQ4rDChG0EbhZmnX9t6sEz1ZBa7YfLaJBu5iXwaWjGPr5pdO+b7xegcJkay1MCL3hxtuO75hI/SwNawZ2k0CsvGkB2ozBLZ0kAKyLUzcz5mmw2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3vVkjWhzOG3EM/0Ekj1LKGD21e3J9aM2DzNA2cUUqE=;
 b=UT6dc0GcBG6Cdc16k1OeZVRHCn2s6L/FZj7TgLMKhZkikJwFBUmdYYbFoZjXO/QFziLT/HN+3ha26yFTVBOYvAhtXyZsEs6hY7h1RUHOO2+NwUK57SWshXt9IPcJVYlL3gMRjUthNJKFmKl9AMoSj8b1BbCdPcQm0Qce7mtCZTUvd5+N9dsxfLatSyrRernzK3ZGMiyqAm97oZSqEFIMTbE2USmWGLQAXDzgBMieO75H5xc3PwD7+GP+VQHDrpOhx/NtelLysDmK16wNGvMdgpXK70p4u1RaCU3jtdzXoUJFmA+WPUEGaVFmHR4kT6jsqpLqseqG3YZ1G+U3YzY/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3vVkjWhzOG3EM/0Ekj1LKGD21e3J9aM2DzNA2cUUqE=;
 b=IMCXvd+HXrhUtOkFdeMWd5KCaF/BTNLQJ5EtNsw7ueFAcgSnUgMEMKuz0DyoH8ljJm1X1MCQHjtqIiuELE73YhAFv6jIVK4S0hyUj1KJG69X+z+gqwNmQGiW8RCMo9smcKagchQzWsKCnZdIdyZilNe9vMdGCP7fseDnkNld1+c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7846.namprd10.prod.outlook.com (2603:10b6:408:1f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 09:15:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 09:15:19 +0000
Message-ID: <b2fb57fc-7a3d-496b-8f1e-110814440e5b@oracle.com>
Date: Thu, 6 Feb 2025 09:15:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/10] xfs: Update atomic write max size
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-10-john.g.garry@oracle.com>
 <20250205194115.GV21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250205194115.GV21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e8b8ba-810b-4d18-608f-08dd468ec6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTg0T0l5MWRYK2xNMjFqUjJ3cXc4ZUZweWN0alEwaWlSMk4zRDhIUU9Cc0lw?=
 =?utf-8?B?cTNRaWNBaWlBdzNmMXlNbWNkQU9JUHJrQWJNU0pzRHJVbzh2aVd0aUYwa0Jl?=
 =?utf-8?B?WjBtM3N4amVraTJUM09YUDBxNHhiYmdpb05jUGpOZHRia2xFSTFDVTNDY3hr?=
 =?utf-8?B?WGp3UFdleCtXc3p0bEJMYTgyTVFKNDlHaHZkNkQ3SjJEUzFGejhlWG1VRHJF?=
 =?utf-8?B?czUyR1pjeGFhZlhvaXhYV0d4YndrcDFpS2gwZVRoczJyTnUwTG9CZE9kS08r?=
 =?utf-8?B?TGZHdVhEeUNzd09nUG5jcjNRSjJQbmVteEhGcHBMVXM0K3FKeDUwZkJzT2RI?=
 =?utf-8?B?OWtSSWNUM2ppK0xFWTZKaG5oZHdYZGdpUk9YYzdqcWt1ZUlEL05wS1MrcTJK?=
 =?utf-8?B?SnZNNmJhNmZhd2xZTitxd3pEVlNINHBSeWRUbWh4SE4vZjkxMU9tWHdiVTFj?=
 =?utf-8?B?blRrTkZlb010YUdIK2JBblN2by92RWZtNXZmb21RZHgrT0ZUM3NuVkVmcUZU?=
 =?utf-8?B?SklMZUM3WXVHd3pGTEZNUmt1S0hiSWliOXJyRVJVWExwZjdLckxPMkJCYm5J?=
 =?utf-8?B?aDVrd2pjOHZ1UFpSNGk2N2JCVnJxNFhsU0k1UTh0aXB0WG5xTzVDcHpNVWNj?=
 =?utf-8?B?a3FKZTRPblY0QWJUekN5UnRITzVMWHpTMmxJL0pOWisyL0FNNHc5U1RWcDJZ?=
 =?utf-8?B?Q2NKbzNZcEp2bExrRUVBVlMxUXVkeGJ3amkyMkZoRjd0aVpJd1p1Q3FIakh3?=
 =?utf-8?B?ZUliQXROYmlPdFNMTXE5c0YzRDNEaUduMDBEWXNjMW5XemtVSjlDSzZsWDlF?=
 =?utf-8?B?TU1ieTJxelZGa1Qya01sbXF0ckI3cmc0RmQ2RXBwMXdkeFBCSWdsQWMzQ0ZI?=
 =?utf-8?B?UVVnUTFCMVJ2ZTRNODhlanYrcUhUYVd5K1Z2SjF6ODZYZnBtdWdLdlA3K284?=
 =?utf-8?B?Vm9Ic3lQbDA2R0FETGRhbklNQVlkUFI0NDRONDBiRmtOaW0xR04wbklRa1VU?=
 =?utf-8?B?bElwWXd6RldCWUhRQTBrNndhV0kwOXYwM2lVZ2FqNzQ3T2FXRHpIdTlEZHd0?=
 =?utf-8?B?elZET2NaTm1Ib1l2dk8vZzlGUU9WOXkwVmVkUlk3NThDRUJ6aFQ4UEJGZEdW?=
 =?utf-8?B?cHB4aHZXbHZ0eGFacnp0VS9HWC91bG1jVklXY29rd1hSRXpXM1hJUGZxMG5z?=
 =?utf-8?B?T2JMZEtvN0JjVWNzdURPcGt0UFZUSzVlSS9RVWw0eDBoZW1qWUF6YmZQc1pH?=
 =?utf-8?B?TjVTYzhTdUNLaDJKYzBwalFBYno1M3FNVEpVL0pxNGd3YzJzWUJZS0dWVGFQ?=
 =?utf-8?B?RHVIUmtZSlJOSThPRXY2RlJRcWpPRjVxU2FmSnVJTUtHeXlWQldZQ0pXSWpY?=
 =?utf-8?B?YUpvejM1ajgzNyt5RksrNXVLUU1vaWQ4ekZ1UHp1bUhNQkZNQjdwVk96ZklX?=
 =?utf-8?B?SGt4dlZhd2F3T3dKQzNuZm1nSWFqZTJqR3FBT3lncXFnTFk3Y3kzTzdLS0xm?=
 =?utf-8?B?dU9oM2w0MUwyK2VKOERxbGE0Z0RZaFF2ZmcxcU53WFdtSUZSdzY5MkNjTEpT?=
 =?utf-8?B?UUtkME5wTjhPazcyd2VINmUzSU9uOTNoSklLYzdjditUZ0pZYzVXamVGcUhN?=
 =?utf-8?B?MjF5Y2VoTER5K09HcE5LVDdXL2NQMGo0Ti9raHZvRmZGZmNhQ2U0dzlaZVJw?=
 =?utf-8?B?anNYSEpoODJpeGl2Tk5WVXVXZXNaVWEvMiszNngyMGQrOUs2aEZjTnFSZ2NY?=
 =?utf-8?B?OFR3Z3VYbkQ1aElZMDRUZEN6MU5LSHhJREEzUFZaTFpzeUFHdGFFMjFuMGZO?=
 =?utf-8?B?Z29SOGlFMnlLUERpQVZqRnUzbnpWcStNTWtyaEtrNk93Mk00VFE4OTFWbENP?=
 =?utf-8?Q?ECrm2HC1VPIJq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEtzWWNNaXh2Z3VRWDVReWJnRFJ4bUtMK1FDdmw0Z2haVFhveUdKU1l2eHpW?=
 =?utf-8?B?VEpKb05wczAyRXR4bFcwQlJaSy9lcjF1K1ppOE5WMzhjNENuWFYvNVB3cisv?=
 =?utf-8?B?TEgzaktQUGlEVTVTdFNYZ09land2WENydzc5dGx5N0xOdU9LalgvUlM3TlF6?=
 =?utf-8?B?UTVWeUZ1ZDBZdWZ0NUE5M3JBamcwd2FJQjVKNVRoVXVEN1FWM3dzeUN5LzZJ?=
 =?utf-8?B?S1FTdkF6cE9zSDdXRzNkZWxkRTIzVkxkbUtadkl5b3hEb2pRMHdGaUlGbGpI?=
 =?utf-8?B?S2EyMmJjc3RyY09MTGxNc25HOTV1ZEMrOUs1ZXhkYkdna2tKYVBZTzJLc0l6?=
 =?utf-8?B?aHZpMnVTTjQxZHNuQ2taZDVYS2ZVWkl4Rmh0cmphN2JwL04zcnN4bFdrc05m?=
 =?utf-8?B?OTBORE80NnFNV0VCMkVVeHg2a2xLQkNUVlBpUDBtVkFkZEpXb2RhZWxWQmFT?=
 =?utf-8?B?bTdZSnA2a2dFZmZYS2ZDaUU4OFJRWlQxNVhQWFl2T054Umo0SWExNWp2bjYy?=
 =?utf-8?B?MHAxUVhHc1lqVzJ3amRLNmZCVytxWDQwN2o2MzhsSGNFK2dvUkZkcENMQnow?=
 =?utf-8?B?cmllbU5TQkxJZTlFWVBsZDJpVFpETU4wYjUwZGJJbHdKSktBZVNqclVycisx?=
 =?utf-8?B?eGoxSnAvNWdFb1VBTU9FMm4rR0pmOFRFOTFIemswbDR2UlllUDQyUlVoMW5G?=
 =?utf-8?B?cW5GMWpwdUE3WVA3bkpXQmZDMFRzcVpqOElXNEkxRjVsMldjUlhNbHZQSThU?=
 =?utf-8?B?WmkwbHc2TkV1aVpla0c4MTNpTngxR1B1aU5PaFFHOGRRZ3B4ZlB0ZW5mcFR4?=
 =?utf-8?B?NXZKRFU5aVorYlUyVGRoaEJPMWRqVk5RSHM5M3RvZ0NidlVQcGl3M1lBdGhv?=
 =?utf-8?B?SzBJUG04N2ZxMTZkZ2hIOEhOdjIyT1VraVJzVXo2bHV0OTBhQU55MEdoTkc0?=
 =?utf-8?B?R1FWdE9HdDJCUmNTdllOTFVZU0FVY2NRM01zQ2c1SjV3Qk1iR1pMVjdma0xw?=
 =?utf-8?B?cmxWY1FlY1RqaHJmQzNEMG1hOE5BTU9tQkovU1Rwc3VkNW05WHkwZUNUdjBw?=
 =?utf-8?B?ZGdiQ3NIaWgySmhIbkxPSk1kM2VmS1puYXlvdTlVaWFpVi9rL3U5L3pVTWNw?=
 =?utf-8?B?K1BSd1ZRc2tqeW51Tit5dnFHKzNHdXMwb3UxbWgxKytBU1YyUFhDemtpZkEy?=
 =?utf-8?B?RjJrUmFKR2t5aUlRUm9zYUhvdWRSdVcrWlp2ZDFYMG9NTnRuK0I3M3I0RzFP?=
 =?utf-8?B?MlhPYlJCOFRaWnV1Ty9PcElBTEVpeUxGSmpkQk1ybmplQVdGVEc0S0xhRnAx?=
 =?utf-8?B?WlVlNitNRTBESXFudmRjTStWc3JXeHF6OHh3TGlrVXFzTmxRUzhhZjRGN2Z0?=
 =?utf-8?B?ckZCR0RhdnRjSkZuMU5EWUtncFFneVNHdW9BL3loM09RckVWbVo5V3hzUUta?=
 =?utf-8?B?QmlEMElWWEVzcmNEbXZoZVNjK3hwWjhHSW45U1RnRmRTa01QU29tQ0hJNDlS?=
 =?utf-8?B?cGVOd2N3VlZyWDRDOHo1MzdBdHZxTWhjR0YwajNaSW5yQlhkRXVCVUhTd1Rx?=
 =?utf-8?B?UFFGeklyMXBITmFYVkxPb3UwbTVVcWdCeXprTHFWQTNibzJkV2QyTkQ1Qm95?=
 =?utf-8?B?UUZXajl2L1BubzRJYy9wTkNvWFprTzRDZzBrWlBtM2c4R3JhN0R5cUszSnFq?=
 =?utf-8?B?aDNyZ1gvdmdlMzduTnpjelVPL3h0QnpDdVRZSG1ORXUrZy9aUExZeHdoeUNZ?=
 =?utf-8?B?b2NMRnMvWkU5a0xhN2tGc00xSUE3QjFGRVRLdTNWcXBPOHJWWitpUjZkNTV3?=
 =?utf-8?B?ZW9nTm5QNTdBMDQ5dXlWWXkzZStUVFhWY2xWSnVkYjNYSGpWNllpYmdvRita?=
 =?utf-8?B?NFBncnhiMlNVTWdmMWtkSFp1elZ2RkhRWmZJazQzT2xvSzhJUWkxRmtMRXN4?=
 =?utf-8?B?TkdscWt1bVdXcnc1a0Nmb1NQb0tFRU81RnFkUEJnd1QrNm16K0ZNUDJIMTE5?=
 =?utf-8?B?eWNRREVUVjFpK3RHV1J5alZJZkNVdWJDaVJpdm1NV3JSTlgyWm55WFV5cG5F?=
 =?utf-8?B?U283SW5EY3I0V0QrSVM2MEJjZzJ4aVhoS0crd2xLMUh0T25SdElSZkdMSWpE?=
 =?utf-8?B?Ny9td0VVVDdDTkk1allKT2svMHRVQmp2aVhMRXJYdzJHc3ZiVlMxYTIydWxk?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4heqO2P166JHSknMVz41k4z8KmtVxe37OMEELbeUcuJvbt6drg7EgO9gwi2E1aadN64ne0B8IJWuu0tXih/Z94jVhTX/gQ3JnLb6361BuZFkFpYzHxg7SgFRIHAqh8fvDcrI8uYbUE27e66uzEwg7D6riQu8T9kRvSaSxGmoD7Qf+DwNh3Ud++ImCTdJSTWs+6mE49he0xtVcSnbgpsxGTjSCGl1xSmigcwNXxQ5hjN35CUAWtDj9XfuYui2gARL+WoltnSt6sQSJs/zIoZFh2/rIeq3Kh3sZDvgdwJlaioABb7XtmXVFuahy+KAQwsvoncuJMFTHYNLTzzuuZ0k/TGMdkr9aIJrzMFsiit3fi15vPqE6XxtNdN4HIgCt1yAB0wDy9p3EzHONsHKGpG5mtOExOrCeToE39tPV2w7SqWLTJp1GtYaT0PCYwtWRR4yk0cr0pYomJ5quhj+y+5i6iTWYCFh8lssv1vITRnPqULlj7DU6fh9xuc6mhTg31+7D1jkodinP/IxLLG+gwVdXiq1zx+Z0YziWdT77Qb62efQOTmiVHnG2JpicHJp1WDSEPJvWYjBEOkEZRqkv21zQ07bRDYx56aAkcxijRCU5Xw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e8b8ba-810b-4d18-608f-08dd468ec6c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 09:15:19.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeXCpU5YOj7OwUyv1cOD00FPyoVzgOx5NJpZZqcixb7Ms6TJt/aFEkoAfzKYkMyBI+rXxj57mD8wEwF6z/Gl7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060075
X-Proofpoint-ORIG-GUID: SfMceGr442t1w93cV5UffzXilSHEVXbV
X-Proofpoint-GUID: SfMceGr442t1w93cV5UffzXilSHEVXbV

On 05/02/2025 19:41, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 12:01:26PM +0000, John Garry wrote:
>> Now that CoW-based atomic writes are supported, update the max size of an
>> atomic write.
>>
>> For simplicity, limit at the max of what the mounted bdev can support in
>> terms of atomic write limits. Maybe in future we will have a better way
>> to advertise this optimised limit.
>>
>> In addition, the max atomic write size needs to be aligned to the agsize.
>> Currently when attempting to use HW offload, we  just check that the
>> mapping startblock is aligned. However, that is just the startblock within
>> the AG, and the AG may not be properly aligned to the underlying block
>> device atomic write limits.
>>
>> As such, limit atomic writes to the greatest power-of-2 which fits in an
>> AG, so that aligning to the startblock will be mean that we are also
>> aligned to the disk block.

Right, "startblock" is a bit vague

> 
> I don't understand this sentence -- what are we "aligning to the
> startblock"?  I think you're saying that you want to limit the size of
> untorn writes to the greatest power-of-two factor of the agsize so that
> allocations for an untorn write will always be aligned compatibly with
> the alignment requirements of the storage for an untorn write?

Yes, that's it. I'll borrow your wording :)

> 
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_iops.c  |  7 ++++++-
>>   fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
>>   fs/xfs/xfs_mount.h |  1 +
>>   3 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index ea79fb246e33..95681d6c2bcd 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -606,12 +606,17 @@ xfs_get_atomic_write_attr(
>>   	unsigned int		*unit_min,
>>   	unsigned int		*unit_max)
>>   {
>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +
>>   	if (!xfs_inode_can_atomicwrite(ip)) {
>>   		*unit_min = *unit_max = 0;
>>   		return;
>>   	}
>>   
>> -	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
>> +	*unit_min = ip->i_mount->m_sb.sb_blocksize;
>> +	*unit_max =  min_t(unsigned int, XFS_FSB_TO_B(mp, mp->awu_max),
>> +					target->bt_bdev_awu_max);
>>   }
>>   
>>   static void
>> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
>> index 477c5262cf91..4e60347f6b7e 100644
>> --- a/fs/xfs/xfs_mount.c
>> +++ b/fs/xfs/xfs_mount.c
>> @@ -651,6 +651,32 @@ xfs_agbtree_compute_maxlevels(
>>   	levels = max(levels, mp->m_rmap_maxlevels);
>>   	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>>   }
>> +static inline void
>> +xfs_mp_compute_awu_max(
> 
> xfs_compute_awu_max() ?

ok

> 
>> +	struct xfs_mount	*mp)
>> +{
>> +	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
>> +	xfs_agblock_t		awu_max;
>> +
>> +	if (!xfs_has_reflink(mp)) {
>> +		mp->awu_max = 1;
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Find highest power-of-2 evenly divisible into agsize and which
>> +	 * also fits into an unsigned int field.
>> +	 */
>> +	awu_max = 1;
>> +	while (1) {
>> +		if (agsize % (awu_max * 2))
>> +			break;
>> +		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
>> +			break;
>> +		awu_max *= 2;
>> +	}
>> +	mp->awu_max = awu_max;
> 
> I think you need two awu_maxes here -- one for the data device, and
> another for the realtime device.
How about we just don't support rtdev initially for this CoW-based 
method, i.e. stick at 1x FSB awu max?

 >  The rt computation is probably more
 > complex since I think it's the greatest power of two that fits in the rt
 > extent size if it isn't a power of two;> or the greatest power of 
two> that fits in the rtgroup if rtgroups are enabled; or probably just no
 > limit otherwise.
 >

Thanks,
John

