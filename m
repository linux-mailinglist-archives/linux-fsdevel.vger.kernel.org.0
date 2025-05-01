Return-Path: <linux-fsdevel+bounces-47847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E08AA61EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD964C3EC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89F2248A0;
	Thu,  1 May 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JnXklyzP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yMwAcxQR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC71A314A;
	Thu,  1 May 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118850; cv=fail; b=lY6+JegEb7lwwrCB/c5MOPCgKb/shJp1wg/lzlM1F7S3mebDlU3pBVp2Y0DzBMM9SPpwYN5RTWf6d1U+IJWYrzePGB38/ZnLy5/y1uRrsA1WI7uefkqvhwDsJ821FjMA5u0OlC7Rsp8/n+fOARNTv9rBqm2OVRmQ1rzcYVUbOBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118850; c=relaxed/simple;
	bh=77KmNwySS4Ui3f6G5cH6waDkX3oi/fSFnFvoGDQFpRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMbFFBq7bb0g23iLZbLMidVnrke54LcnI0EThHn7dXnww6ybms9lZfNjJ6/DGK/oeDxFlcb8I3paklDmMixdIpkquhBDmoQRdxoYbUPzWnP/t8uVnWe976BVZyccuF7HZDO3K/5qwCrT4LDPZ2zIRKtivsMQU1JEJ6f2or7LFSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JnXklyzP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yMwAcxQR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541GkfVW027289;
	Thu, 1 May 2025 16:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IOF37P8LozRk4TARzFGlYzCNY998OSHkLbZevreHlSI=; b=
	JnXklyzPksgeG/euto6P87c/AMfkFmHq3Pwyu6KrPWZWaLDoTqSpbOjuMV3NXc+O
	ajASlLUgct00DilfRVcpnPVnZi1MgNeHLIOlqjpuieTjcyuyenZMMgRoeol4bi3X
	ahBmSpQa5BWPtgs7wKBt3b9lDbKN5ZnWThNWOPOSrPmxrKpEZBPSt7FrVKyZHAQH
	JipHzQkG5/odFww0sgwVtcrWpu/7tJTppzVW16S0HjGnsMwrAQp4R0kjwauWnZEj
	Xm4razRmlIguwqWhEe1NUjcw5OFKOsXgSu+NvZxORzWn0tj8yvs2aTI3tSNWhMYJ
	qxUnrsPopIjkzNAvFBQ/sg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukuj80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541FbSq8035440;
	Thu, 1 May 2025 16:58:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxchjk1-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lk1ttiw57+d+18EGIcMdO/zajlYyXwNtiXAIsJZgmXD9NbJD0zinBidJbzH87Vf6uARBqkbLN9cJ/lHflZlbAsqfKXEb6ct1jag299661nzy0ylR9xI8xJRgvAu/lxeWB/VgzwD803BQPsNRjbpF/mka8ff/0aMJ78I3/X+k4J5pf1nw1a/kVKXmxoprcCThQnjqbwPm1dbcuzA7yiuCIi+7VkKnCTm0Xh7/H7/Bov+TKyCkguFvC7G8wTVkZ250cgP6EASiK8OuMehIpw2IGXd0eu2XNm2aixmjTQAzGKfl5BQkfL9p2BHHjowA03cBTrFCJMhNyaNyx+EPutp3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOF37P8LozRk4TARzFGlYzCNY998OSHkLbZevreHlSI=;
 b=CoNbb6ZYq31iKpaGNQTly50h+xBQd8APQtrqhWOvvLYoG777l6kuYgEgU/sQD2gYBNTn1Hjzz46psDcljA4l3wYoxnFmDTHwmxXbYFY+0lriPyN3Zro+Cypf1CZpMBeiEkifR66RaORJYvCJGa52mJdOx3sXFMoMAR03nY1zaj8QSD0wLJIgpem2Twmw4sZkbL04ylwpJWXbB0EUPHv0SJ7O44rYRzsyhv/nlUf4VhIHrAR6FAxqNXl9EFGVmNrvsJWtop1JHH304An0HBZ5sPEZwJD5ekMwVDU1VXJv6QX95Hna/Zz0G5EBNPiIn34CNJJ2klxqe4VuxrMH5mcqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOF37P8LozRk4TARzFGlYzCNY998OSHkLbZevreHlSI=;
 b=yMwAcxQRSfhOiaYby9udAGfo6me5A+POQjaUe5QQ55dRk3NCyCKrD2UfZw89TZteNrgpKRdn/3JLbBhh3GpR+s3FjAK52ZY6aE3mHf7uafOKbCk6Yja6Q2MeZbe3OHHwQQIcKdBGnrxFrie/FhNzxpHnfGSh+UqXPxCBAHV77uM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 16:58:09 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:58:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 15/15] xfs: allow sysadmins to specify a maximum atomic write limit at mount time
Date: Thu,  1 May 2025 16:57:33 +0000
Message-Id: <20250501165733.1025207-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd2a211-9b7c-4734-9124-08dd88d159a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hg8OgvtFmGy2Zi+W5acnDu7N120VLMFjHHcm1pA8Kcm/MWrwmMQkpfUzlGFE?=
 =?us-ascii?Q?p/g9Xey7Abo769cNlIfiuQEz6LDG2MP/9ncq/ku0Vh8qTx10VGYNM29/vNX5?=
 =?us-ascii?Q?eeC89o2MV7ONE/uclzTFOPoXi3fhEEZdZ4GpbXGTtjYfhDwkW0WKavT3zUAt?=
 =?us-ascii?Q?FVxizRLQ6iHK6dKk0yGwvBGrB/rxKqQXHcnAjvdrcWXOdIB/hV8+I7ZXEQqG?=
 =?us-ascii?Q?pni5TH1z9AiVY+0B7rgzr+u77WN+nysRnPKZGKpMRZzIAsO9tOrn2WyB8HuK?=
 =?us-ascii?Q?aLGwshkXw4MbF3bu/EIGNX22KDFCVbp93VQv9fc8fhPGdjCGUz2GSprui+9c?=
 =?us-ascii?Q?Ikv0k972J3J84xlFqgZzxArM48yPHZH25ttK7SumMDVa9wns9nzyaOlVJVPx?=
 =?us-ascii?Q?YSyQqFve+thA2e04vTAeiD2blCKudoPzUpDrjd87VsCkwxf/b4QPIUUyqJdI?=
 =?us-ascii?Q?EfHYZnVjY3zcXOYEnMejcaYoWlBbqPSKhLSwVJ+xriJSWlMKYssiCQToqcVt?=
 =?us-ascii?Q?zC/WVmwF5XkqsZh3Yd/DopXQiZIYdfsQCybQUP138niQTXTdEXgPBffWuZa1?=
 =?us-ascii?Q?/CGJkRT2b0oJBUEP+f/IIlQkc4n/zseC0uM5vDH0GRUM7pM1iud8KPyIXHkP?=
 =?us-ascii?Q?wOPmy9BAm8L4NA7sCDiZBHFAdDPjpKBv1yPCRA6RZWIANrt3OX4MnKBQh77r?=
 =?us-ascii?Q?rfCSkzDPLbtlTKM1i9MuvYgBVxYIiIzVmdWsMiJkJ40OTMXNOrHS070BZNlW?=
 =?us-ascii?Q?NdaHH7/sTI/L2ochDojB1FygCf2vGS4CUNsQ7xfT6xIQeXSoHSb6+XDsHlcf?=
 =?us-ascii?Q?QT5x8dHrQzNLSqMH/655FtK3Dgdl1e7bQVe7LbcnKI5I1aOMBFrYPNc0TpYX?=
 =?us-ascii?Q?jg0IUN/wBXM2+sYwmeixQv0XImJNgxuvSMFjweHl97J1mcSdK1N5rGOI4hkj?=
 =?us-ascii?Q?787alRqqnwFA44IpY5KicOWq5XBqeEVyc0unvK9m8Drnx/rIOwuH/EOqCoWt?=
 =?us-ascii?Q?VBJA24DZs8zh/TBavbrrqA7ppBrsAC+6uKOaPFiBraUh4Pnuot+d2s+bkTWt?=
 =?us-ascii?Q?HXn4tcG3gKTyjEIIVIrDt1w+XnY4rx+hIoDQ/uD3j/paDJiS9LS6hBOcOQlW?=
 =?us-ascii?Q?3RtUNNRiVH0g2aO9MYMVMXhEt2e8K/XonwpMT6ufgFl97bdCRB4K9SvW3qxQ?=
 =?us-ascii?Q?uq4+/OAvnYBVEHiJ6dMss7SjZBSaG/MktsC2HXXXaqXhl4b/Jw7FKtA4vaxq?=
 =?us-ascii?Q?DpJ6JU3Qk/vXQniM5OkieKpsqm4I9gpTk1YXc6EbAM431M636kJ1WNQYfswv?=
 =?us-ascii?Q?9iOzJMOdMVPL2+mmHXNzWOd49EHlvrQcFn5aEjV4UchNu6Ixde4aoAdstQp6?=
 =?us-ascii?Q?zuYM7bKeeWqHUxNVS2fg3emAkY80q8x2TDrULMlCxz15eiR69D7rNGqLxKuZ?=
 =?us-ascii?Q?4d4Lj9d3dIs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gxY9lCME/EVWED7zJnHyu+bPW8VJ2S4ScQqmFpXm1Jf+fO4mb59K19lmYEGs?=
 =?us-ascii?Q?zDUqbEYVtCwJEhShNo4H+MNHMri1I7BIG21fp/+kw08TdeWsNvqKfizOSC83?=
 =?us-ascii?Q?kDUI0PMUAJq1jSZrANnOFKAPcLdTHurFus20/8edxMrxcmcsux7+4/neUmWQ?=
 =?us-ascii?Q?WnCq0cU6KiQ9KARS5pjh/FQCkqBVLS42SmlXrmSR4xs3lFFw5iKsdtUn7+Kl?=
 =?us-ascii?Q?e3cFSkxuzFVS/jXJh8h2lcHvGzMqbO6QVFLq1MWB16NOaLiy2LDhcdVVVtKJ?=
 =?us-ascii?Q?e73cAu3sOudPMmcTcslLt4Yvdgh14sACGayKwDTiHxcDwbUAH6nvSHKIcRC9?=
 =?us-ascii?Q?RUEssXyBHk+Qg03Z10aTcm855zWqjOZhErkrdCBNOI7Pdz5FqYbOCIbQFKWw?=
 =?us-ascii?Q?KyG2U2E0j/KwlB3KluoZRnTMRUxyRoIlfS5B/NhESkMj5dypwgcmBTjUk5G0?=
 =?us-ascii?Q?/riglVIRdIi/qERQWImncqj/n2HfCjBP71jSuYZ8Xzn/sKZhlHYXJLvsG83a?=
 =?us-ascii?Q?Ju8syW0XRsq0PemseC2BGJ2hCV1NdvX9kVZohplbfp3v/g6joCUBmh11C7eu?=
 =?us-ascii?Q?MjwtYL8/SfNN0HbD+XYYkxDu5X2zloXDQS7CU2iwSWQicSV5mIDkYJ9sMkok?=
 =?us-ascii?Q?mBsRNp2k1GMjQRJsKik7KWA+QaD3IM+nXl83VY0S7hXHUuZP36O12bCgccDx?=
 =?us-ascii?Q?1YKx50GZ36Cm/RiVocrctKbVvmbpNRdxzDi7S5Dgs8jaRgMeOb5Oty4KSZ1a?=
 =?us-ascii?Q?aUtVorpY3DMWY8QZ6bKaJyYojCVWyAdUv3zxhk7LFqJ1qLsOJoO6gMUGb053?=
 =?us-ascii?Q?Rg5X/Pwnvy2nUk3kQTR82xuXSBk1M6nkjo+SYTb4BMdsbDqWlf+OieTC43/z?=
 =?us-ascii?Q?fxe9kX7vKn7O6ecFIknWc7H5rkpMwcX8sx7uSXcswZjtAHRlGJgXVu9DpsXs?=
 =?us-ascii?Q?l8xqKHe2UMhyffOWRADG5LyWUj5Bc6oXf+rvTv5cki4KC8i5ApwlnObRndB4?=
 =?us-ascii?Q?eI8y6eMrug9aPi7J2qgsKO54M1d10dEHqlxLY4lw86ofGf3b4BhxWHaU871L?=
 =?us-ascii?Q?A1B9EeqEM6oz2QnUjjvp/TqdYn1WoPK1jdcITk6QtOTqa5r4ADuU8rEEqU7n?=
 =?us-ascii?Q?3mbE5m/QXme2KFSNdSHG10fi1ZSmknzp994jwCWDfH7DhluzzvnLF7Bsc+24?=
 =?us-ascii?Q?RmqX0CZSfrSvpKp82kLA+H0tm/e89pOy06rjvO1dXW+P1IvWIGj+oxyKv36l?=
 =?us-ascii?Q?AP3xld2sgyeyPtrZXkvn3o41WOJwwL0ctOTMdOn4/yMXJ2TM7xUqbDqlvrW/?=
 =?us-ascii?Q?I+b9tEAo3eSNe/Av6lVpEf5wN11XmU97mQtgYGCNuEqFVuFWIzcHK4SeupNx?=
 =?us-ascii?Q?aM1nyj5L8bIDlCokXVSmi67ZEFNn3EF0ZJGb7DXIHQyjrFcB4r1+NLg77rXO?=
 =?us-ascii?Q?LrgpSjl3UlOM2sbQb8uqKl46GAa60K+KMUTTjhQhTgH8CXj1SszD3TTMZ0iN?=
 =?us-ascii?Q?1r/qZa+5qscO3Jr3fY1ZAUGLE5ESIcYBasvVfJNZE7zQazdHdC3VAG0NAZfG?=
 =?us-ascii?Q?9Ev8yNLXwmB1at1QWJ19RjqLt9xK62zDGMew7cUBbtKb+wYnMSvpnm2qkLTz?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YmjnR9iRmMjnE63HdlA2YJeIf17gPeNhdc3KB8RpbzvCA2R2GMosO7TaHIO0bqgrBrpQJe/LC7EVDzLT99l8BGka2lutQQPZtUGDr1EBtI2O+qwBnGD97pgZGq8cFej5hUDUu3CEh5oKSFMR+xUWFowMAR51laPBkwFeShAvnYfITqkVOzZTG2jLlnS3unPAwZ8vYGraUceElUI6VaHBNqTNfjm63nD6qJCsgPMi5AWNBFKTM3j1hYg9nRCxYl45PvlWQKobrGQc6h1mhxGe3b00eqCyAHn7m5vDhB5/vlhBgRZmz3IZqT8KhjLmVICgN8tqjkiW4h/RQKjzeNaIlGX0yC6VobPSJpxOHpbHjHYQigE6vsvrOYrhPNBHL/CWLMT+6D62Hg2n7YdPDGFL01DMz03ujZr+AT6ZV1uSL/Cfzb1IWT68ua2GNQxVq9u0co5Mde/q5SjwucOey5HlcyWFT3l9sgwVMbnR9n8yL1NEe3TJ8K+bZgpZOPwPBiJmbbSahuBm5JvbdW8z2BMNgh34emsO/Wvja1KeeBoaZDZjlg1cOvFkL8stgrRtOwLzksVHNvjF+gCv8vEODhIpsEKgq9673uUnQ/dpWb85CMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd2a211-9b7c-4734-9124-08dd88d159a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:58:09.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RKUrtk0shCtvt6f9eaUQqyB54NVaI1wvxq2WFxwgC9ysyRQyhYZjoNBTpttmX5Tp6ODPP5+3Cf5kXRXqbzt0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOCBTYWx0ZWRfX6PaYgoQaXzSW eZiaQBkyQV9ANFqyjFy28mlZ5fzDM1JJhwE3t3Sesozr9sKt5bQoQ8bOZK9GrVpJJQ8uMYetMeL nrypN7GrTAGj5QTxCETIKqrXcMeAx/L+YvPIG3xEfIIarhCTyeKE2iAzv5J0GpBNRA8PMVhezg+
 NcQEyk2vlOKFf2hVuM/uGjGCx2PWM7eS2TS0aneat3bi1wa70QfsRo45LY9oG1+v01FrhiaEO24 xyShEmuBVGEzemu3k3a08NIcCpEoJLsgAtxeMOeyv2YgVxnNMg05Qb/Ct9SabTrNvwvjpNq8Fny rc5nYM5xGUnSDxWukpyG/fai0nuKfyp3MsWcWsWnVFSXAfzU8X/Wp3cvJg05ELWgEDutWBsTaMQ
 38pj9E+yrOkBo80dIutwGVVdd564SFkxPUHKxScTl9XalUOWQz6aPEzSA04cMObaO9WD7RzD
X-Proofpoint-GUID: Ap47qOX--Xuss7kr3B_nnQwzYWxRDYt0
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=6813a83a b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vofBRnjZkZwxpctGmH8A:9 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: Ap47qOX--Xuss7kr3B_nnQwzYWxRDYt0

From: "Darrick J. Wong" <djwong@kernel.org>

Introduce a mount option to allow sysadmins to specify the maximum size
of an atomic write.  If the filesystem can work with the supplied value,
that becomes the new guaranteed maximum.

The value mustn't be too big for the existing filesystem geometry (max
write size, max AG/rtgroup size).  We dynamically recompute the
tr_atomic_write transaction reservation based on the given block size,
check that the current log size isn't less than the new minimum log size
constraints, and set a new maximum.

The actual software atomic write max is still computed based off of
tr_atomic_ioend the same way it has for the past few commits.  Note also
that xfs_calc_atomic_write_log_geometry is non-static because mkfs will
need that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/admin-guide/xfs.rst | 11 +++++
 fs/xfs/libxfs/xfs_trans_resv.c    | 69 ++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h    |  4 ++
 fs/xfs/xfs_mount.c                | 80 ++++++++++++++++++++++++++++++-
 fs/xfs/xfs_mount.h                |  6 +++
 fs/xfs/xfs_super.c                | 58 +++++++++++++++++++++-
 fs/xfs/xfs_trace.h                | 33 +++++++++++++
 7 files changed, 259 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/xfs.rst b/Documentation/admin-guide/xfs.rst
index 5becb441c3cb..a18328a5fb93 100644
--- a/Documentation/admin-guide/xfs.rst
+++ b/Documentation/admin-guide/xfs.rst
@@ -151,6 +151,17 @@ When mounting an XFS filesystem, the following options are accepted.
 	optional, and the log section can be separate from the data
 	section or contained within it.
 
+  max_atomic_write=value
+	Set the maximum size of an atomic write.  The size may be
+	specified in bytes, in kilobytes with a "k" suffix, in megabytes
+	with a "m" suffix, or in gigabytes with a "g" suffix.  The size
+	cannot be larger than the maximum write size, larger than the
+	size of any allocation group, or larger than the size of a
+	remapping operation that the log can complete atomically.
+
+	The default value is to set the maximum I/O completion size
+	to allow each CPU to handle one at a time.
+
   max_open_zones=value
 	Specify the max number of zones to keep open for writing on a
 	zoned rt device. Many open zones aids file data separation
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index e73c09fbd24c..86a111d0f2fc 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1488,3 +1488,72 @@ xfs_calc_max_atomic_write_fsblocks(
 
 	return ret;
 }
+
+/*
+ * Compute the log blocks and transaction reservation needed to complete an
+ * atomic write of a given number of blocks.  Worst case, each block requires
+ * separate handling.  A return value of 0 means something went wrong.
+ */
+xfs_extlen_t
+xfs_calc_atomic_write_log_geometry(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount,
+	unsigned int		*new_logres)
+{
+	struct xfs_trans_res	*curr_res = &M_RES(mp)->tr_atomic_ioend;
+	uint			old_logres = curr_res->tr_logres;
+	unsigned int		per_intent, step_size;
+	unsigned int		logres;
+	xfs_extlen_t		min_logblocks;
+
+	ASSERT(blockcount > 0);
+
+	xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+
+	per_intent = xfs_calc_atomic_write_ioend_geometry(mp, &step_size);
+
+	/* Check for overflows */
+	if (check_mul_overflow(blockcount, per_intent, &logres) ||
+	    check_add_overflow(logres, step_size, &logres))
+		return 0;
+
+	curr_res->tr_logres = logres;
+	min_logblocks = xfs_log_calc_minimum_size(mp);
+	curr_res->tr_logres = old_logres;
+
+	trace_xfs_calc_max_atomic_write_log_geometry(mp, per_intent, step_size,
+			blockcount, min_logblocks, logres);
+
+	*new_logres = logres;
+	return min_logblocks;
+}
+
+/*
+ * Compute the transaction reservation needed to complete an out of place
+ * atomic write of a given number of blocks.
+ */
+int
+xfs_calc_atomic_write_reservation(
+	struct xfs_mount	*mp,
+	xfs_extlen_t		blockcount)
+{
+	unsigned int		new_logres;
+	xfs_extlen_t		min_logblocks;
+
+	/*
+	 * If the caller doesn't ask for a specific atomic write size, then
+	 * use the defaults.
+	 */
+	if (blockcount == 0) {
+		xfs_calc_default_atomic_ioend_reservation(mp, M_RES(mp));
+		return 0;
+	}
+
+	min_logblocks = xfs_calc_atomic_write_log_geometry(mp, blockcount,
+			&new_logres);
+	if (!min_logblocks || min_logblocks > mp->m_sb.sb_logblocks)
+		return -EINVAL;
+
+	M_RES(mp)->tr_atomic_ioend.tr_logres = new_logres;
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index a6d303b83688..336279e0fc61 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -122,5 +122,9 @@ unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
 xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+xfs_extlen_t xfs_calc_atomic_write_log_geometry(struct xfs_mount *mp,
+		xfs_extlen_t blockcount, unsigned int *new_logres);
+int xfs_calc_atomic_write_reservation(struct xfs_mount *mp,
+		xfs_extlen_t blockcount);
 
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 9c40914afabd..f639af557b4e 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -740,6 +740,82 @@ xfs_calc_atomic_write_unit_max(
 			max_agsize, max_rgsize);
 }
 
+/*
+ * Try to set the atomic write maximum to a new value that we got from
+ * userspace via mount option.
+ */
+int
+xfs_set_max_atomic_write_opt(
+	struct xfs_mount	*mp,
+	unsigned long long	new_max_bytes)
+{
+	const xfs_filblks_t	new_max_fsbs = XFS_B_TO_FSBT(mp, new_max_bytes);
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_group =
+		max(mp->m_groups[XG_TYPE_AG].blocks,
+		    mp->m_groups[XG_TYPE_RTG].blocks);
+	const xfs_extlen_t	max_group_write =
+		max(xfs_calc_perag_awu_max(mp), xfs_calc_rtgroup_awu_max(mp));
+	int			error;
+
+	if (new_max_bytes == 0)
+		goto set_limit;
+
+	ASSERT(max_write <= U32_MAX);
+
+	/* generic_atomic_write_valid enforces power of two length */
+	if (!is_power_of_2(new_max_bytes)) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes is not a power of 2",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_bytes & mp->m_blockmask) {
+		xfs_warn(mp,
+ "max atomic write size of %llu bytes not aligned with fsblock",
+				new_max_bytes);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_write) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group) >> 10);
+		return -EINVAL;
+	}
+
+	if (new_max_fsbs > max_group_write) {
+		xfs_warn(mp,
+ "max atomic write size of %lluk cannot be larger than max allocation group write size %lluk",
+				new_max_bytes >> 10,
+				XFS_FSB_TO_B(mp, max_group_write) >> 10);
+		return -EINVAL;
+	}
+
+set_limit:
+	error = xfs_calc_atomic_write_reservation(mp, new_max_fsbs);
+	if (error) {
+		xfs_warn(mp,
+ "cannot support completing atomic writes of %lluk",
+				new_max_bytes >> 10);
+		return error;
+	}
+
+	xfs_calc_atomic_write_unit_max(mp);
+	mp->m_awu_max_bytes = new_max_bytes;
+	return 0;
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1161,7 +1237,9 @@ xfs_mountfs(
 	 * derived from transaction reservations, so we must do this after the
 	 * log is fully initialized.
 	 */
-	xfs_calc_atomic_write_unit_max(mp);
+	error = xfs_set_max_atomic_write_opt(mp, mp->m_awu_max_bytes);
+	if (error)
+		goto out_agresv;
 
 	return 0;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e2abf31438e0..5b5df70570c0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -237,6 +237,9 @@ typedef struct xfs_mount {
 	unsigned int		m_max_open_zones;
 	unsigned int		m_zonegc_low_space;
 
+	/* max_atomic_write mount option value */
+	unsigned long long	m_awu_max_bytes;
+
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
 	 * Callers must hold m_sb_lock to access these two fields.
@@ -804,4 +807,7 @@ static inline void xfs_mod_sb_delalloc(struct xfs_mount *mp, int64_t delta)
 	percpu_counter_add(&mp->m_delalloc_blks, delta);
 }
 
+int xfs_set_max_atomic_write_opt(struct xfs_mount *mp,
+		unsigned long long new_max_bytes);
+
 #endif	/* __XFS_MOUNT_H__ */
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 6fd89ca1cea8..f815ee92b9aa 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -111,7 +111,7 @@ enum {
 	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
 	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
 	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum, Opt_max_open_zones,
-	Opt_lifetime, Opt_nolifetime,
+	Opt_lifetime, Opt_nolifetime, Opt_max_atomic_write,
 };
 
 static const struct fs_parameter_spec xfs_fs_parameters[] = {
@@ -159,6 +159,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
 	fsparam_u32("max_open_zones",	Opt_max_open_zones),
 	fsparam_flag("lifetime",	Opt_lifetime),
 	fsparam_flag("nolifetime",	Opt_nolifetime),
+	fsparam_string("max_atomic_write",	Opt_max_atomic_write),
 	{}
 };
 
@@ -241,6 +242,9 @@ xfs_fs_show_options(
 
 	if (mp->m_max_open_zones)
 		seq_printf(m, ",max_open_zones=%u", mp->m_max_open_zones);
+	if (mp->m_awu_max_bytes)
+		seq_printf(m, ",max_atomic_write=%lluk",
+				mp->m_awu_max_bytes >> 10);
 
 	return 0;
 }
@@ -1339,6 +1343,42 @@ suffix_kstrtoint(
 	return ret;
 }
 
+static int
+suffix_kstrtoull(
+	const char		*s,
+	unsigned int		base,
+	unsigned long long	*res)
+{
+	int			last, shift_left_factor = 0;
+	unsigned long long	_res;
+	char			*value;
+	int			ret = 0;
+
+	value = kstrdup(s, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	last = strlen(value) - 1;
+	if (value[last] == 'K' || value[last] == 'k') {
+		shift_left_factor = 10;
+		value[last] = '\0';
+	}
+	if (value[last] == 'M' || value[last] == 'm') {
+		shift_left_factor = 20;
+		value[last] = '\0';
+	}
+	if (value[last] == 'G' || value[last] == 'g') {
+		shift_left_factor = 30;
+		value[last] = '\0';
+	}
+
+	if (kstrtoull(value, base, &_res))
+		ret = -EINVAL;
+	kfree(value);
+	*res = _res << shift_left_factor;
+	return ret;
+}
+
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
@@ -1523,6 +1563,14 @@ xfs_fs_parse_param(
 	case Opt_nolifetime:
 		parsing_mp->m_features |= XFS_FEAT_NOLIFETIME;
 		return 0;
+	case Opt_max_atomic_write:
+		if (suffix_kstrtoull(param->string, 10,
+				     &parsing_mp->m_awu_max_bytes)) {
+			xfs_warn(parsing_mp,
+ "max atomic write size must be positive integer");
+			return -EINVAL;
+		}
+		return 0;
 	default:
 		xfs_warn(parsing_mp, "unknown mount option [%s].", param->key);
 		return -EINVAL;
@@ -2133,6 +2181,14 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* Validate new max_atomic_write option before making other changes */
+	if (mp->m_awu_max_bytes != new_mp->m_awu_max_bytes) {
+		error = xfs_set_max_atomic_write_opt(mp,
+				new_mp->m_awu_max_bytes);
+		if (error)
+			return error;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index d5ae00f8e04c..01d284a1c759 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -230,6 +230,39 @@ TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
 		  __entry->blockcount)
 );
 
+TRACE_EVENT(xfs_calc_max_atomic_write_log_geometry,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int blockcount,
+		 unsigned int min_logblocks, unsigned int logres),
+	TP_ARGS(mp, per_intent, step_size, blockcount, min_logblocks, logres),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, blockcount)
+		__field(unsigned int, min_logblocks)
+		__field(unsigned int, cur_logblocks)
+		__field(unsigned int, logres)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->blockcount = blockcount;
+		__entry->min_logblocks = min_logblocks;
+		__entry->cur_logblocks = mp->m_sb.sb_logblocks;
+		__entry->logres = logres;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u blockcount %u min_logblocks %u logblocks %u logres %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->blockcount,
+		  __entry->min_logblocks,
+		  __entry->cur_logblocks,
+		  __entry->logres)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


