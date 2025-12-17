Return-Path: <linux-fsdevel+bounces-71584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17440CC9A99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 23:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3DB6302AFAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95F310777;
	Wed, 17 Dec 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Akfc6nC+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AxaN5JPO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA030AD11;
	Wed, 17 Dec 2025 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009011; cv=fail; b=fxdMe3nGCIAVwCEbe7iKc2/DwvfmPeSsaDhQNsTsRi5tb0Ukyta27wJ9tQwqyG480xtvbxyKuA5o/LHj5T10aOLYfg/CTyws4D2uXHjg4mVgRjP5qpnedil0zesOmD2fb2p0YYIIE2KUwFuOhaB7KPpWJD0Aq1XSUn9i5Qz0pYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009011; c=relaxed/simple;
	bh=MR+nCyfPUmaazzODxOPOkcboR1VH86pATu5Ac93j8Nc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uF43gDuzMLky0Y/deIvhRiqywOxCR34ipfNh47VwAYBxUEM8vwMHoPh8BYXSBTghn6EnL9UcYyiEI1yroMRwE7RWRjR0L2slvWL7WS7ZnPf0H1CB1GhCoN6cDSdRirBcaHPzaPl6StYbFFUkCEbiC8l8MWtKNk+oSryWnsqV9uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Akfc6nC+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AxaN5JPO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHJQZsU3494622;
	Wed, 17 Dec 2025 22:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D4eoqqSOdo4Zf7ndvJXpqfg5oCGTgE3vE78Kf170o4o=; b=
	Akfc6nC+9FRbQAQRlg6Q3gyGwyNnlOGJZTdBHC7fr/x39+uZZVVpF3AmD1FwSU2J
	eAkgW3ppqm8FmpHmS8Rakp8e4vFGFHdqn2Fai/hVMjI6guYiWTpe5SzOPgC8c3nt
	zz7Dcm8y0K2yPNQaQjMGNYA7cDlvdWuRJia3SiuELWA7xWBDdkLx5EE7B4zNAurG
	2LFeYvz/7y/gM6NwsDUgf0cVKkkxjaC2+96b+hQSPCdCnbLjwSOJWQpBudGiBZKG
	Cmfe9Qqe246Tkeb07sfoBIT5WrAvT/cNAV+sYhKtFnscoZJ66SyCBWkJiNvMXveq
	UPfJtNvAryWmLJOq+7Pg0g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015xruf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 22:03:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHLgrCA025190;
	Wed, 17 Dec 2025 22:03:16 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkcbkkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 22:03:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWUklK5Z1eGRYLSvwnT1fNk4jlVMbYGKG/EzM+LBdRnr1ZsgxUfogwNYDSiGgbEDi8scQa5BfdiW265pkJhEGgFBW3bTFMCco+d7G3vRuwkTEZtPEfCp2Eh8ltwjYdF1PSh8Wmke0tFSQb2O1VPsJTASghrrDmn1XyUGLNtKy0rwQikhS1nyE+6HJXf6eLovdwFo4Gw89PPl91ufxPBiRUSCo9eZkRmJeEUfS0Rjppn2ab4h6fK49BuszVCocie46GM4L1d7sp2vDSj+4oDIjKIZU4m21qOi2/23tPF70C//PJTF0Lhn48r8k1AbbSnfeEHq6Qt+8CWzPDBwJlLhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4eoqqSOdo4Zf7ndvJXpqfg5oCGTgE3vE78Kf170o4o=;
 b=skL4dSOMlU0P7vxGy9i91IN0aAkg/omZzlVtvVUKJ+1EH5thhKNbe4+3uDOYR4CbvXwEUd4hpLbae2uiB4NzU9NcnkRluZOtysNYjYEVNSywSii1TFhNNjZjh31Hq9zTBjYHTL7dCijplv0BGlK7Z1vJ34vAgubCd2Xr/BDa5D7NMjPn+MThi0rJk/DTz4opOjF1I2+xWDf8e4d1adzpuYZ9OIyXY3BjpyBCLbaM+2xdw3AXhJK31Y8b3gw+vWU5U0dia/zsM02IOuxDaM9IqNvhQLMjDojVIYOFxkIWsur0yc7JPteV+/cCIlIaXj5sprqlYKC01UtT0urbbozCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4eoqqSOdo4Zf7ndvJXpqfg5oCGTgE3vE78Kf170o4o=;
 b=AxaN5JPOAWnGv/QqpwLTHJ6psGWxaC1qWZxaz504FeKSYJShC46NLaYcReC8NGcFoJvrG8XvYH26Hnsquf5r4zBhrckMgBwQ7itYHFwJbwSpCKEX57j2zho+e6TL3AOb0zEeTHdsIHgdcw9UIweS5GUuSNXwjdO5mlzWkpr/kV4=
Received: from DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) by
 MN0PR10MB5933.namprd10.prod.outlook.com (2603:10b6:208:3cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 22:03:13 +0000
Received: from DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed]) by DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 22:03:13 +0000
Message-ID: <e2a365a2-67e4-4703-b635-d828a5c57e75@oracle.com>
Date: Wed, 17 Dec 2025 17:03:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: NFS dentry caching regression? was Re: [GIT
 PULL] Please pull NFS client updates for Linux 6.19
From: Anna Schumaker <anna.schumaker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
 <aUJ4rjyAOW3EWC-k@infradead.org> <aUJ9hliJJarv23Uj@infradead.org>
 <d272dc63-a157-4dea-966f-003cefa28d2d@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <d272dc63-a157-4dea-966f-003cefa28d2d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:610:59::33) To DS7PR10MB4847.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4847:EE_|MN0PR10MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 3831f0df-0c38-4edf-eb98-08de3db812a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTZhL0d5MUNqZGpiZU5aY09xdW1zY21sNnJkMllzVjdGMHM4MVhaK1h0QVh0?=
 =?utf-8?B?YjJDbkhlUEZaVVZEZXcwdmV4M2MwcDBMaUNIRWNDS0srNmJRK0QxOTdyTFp2?=
 =?utf-8?B?OVVPS3JKZElpNkkyb2hQS3B5MWh2WmtQUzFBdk16TndkVncrbTVrNnpvZ1lB?=
 =?utf-8?B?OUhWVGtES1gwRld3eGxod09XNEY1Wjg5TXNrTmkzdlRLL2s4V2RtNlNUeWpq?=
 =?utf-8?B?NktBYXdGZmdYazBqeXJuaTg4U2hjL3ZJMlNvVGIybEE5N2ErS2ZrUXN4cGNw?=
 =?utf-8?B?blFMYTBUNFpOYWEwNU15RDZLdUF0VEhqYkxKLzAyUXFZTGh0QmJSem8wVUFy?=
 =?utf-8?B?WUVDQTZQbTFsWG9IQlZrdWRJdGttaXBUVmxROXc5V0h3TFE2MDNNdTR0eVg2?=
 =?utf-8?B?ajlESnllc1pubUV3dDd6NmpLZW8ySFlHTDFiSy9MVEVMZlFKZWRJc2x2V0xx?=
 =?utf-8?B?eWtiVncrbWs5eTFpRnRJR241dnlTelQ5VGxkSVhKSkVad3UzbGc1ZE1SVHlu?=
 =?utf-8?B?REpkeUU0OGNuOUZZREs4ZmJ2cHRsRUxSZjlneWpoM2lhZGx6a05aRnVZbW0x?=
 =?utf-8?B?dmxYUzBsekFjRmszTFk1NlRIbzlFZ2pwbjJYaVU2bXk4UXV3WWtZdEZsb0VJ?=
 =?utf-8?B?RlFvUlBOTXpXS3hvMGZ2Y1pyWUhoaGlzZFYvOEx6YWNNNXY2blR3N09IUFM4?=
 =?utf-8?B?YVordzh0MTcwM092SDhaV3BpL3hkSFB2czVvTGlCSEZRSytZUFJmRlJxUHBR?=
 =?utf-8?B?MmZ3TTRJcGZoVTVZaE5IalFTU3I2cFkyeUtMc0o4S29PY0g5OGd2aFc3SXRk?=
 =?utf-8?B?dE00NU1LaHFSNThXVkw5R3UyKzlvNGd3encvdE5GYjU5cU85a3AxTFZCUVNF?=
 =?utf-8?B?dmF3b1hLWWN3czNQazcxZmxWa1FOY0E4aExpN2tPendYbFNVWlhCN0xta2h3?=
 =?utf-8?B?VEhEejBTbjlxZFpQYUdKUkkyL3pyTEZjVDNLNmhaTUJwUy9YNVBWNWticWRB?=
 =?utf-8?B?bjdnOUw2MFlOQjhqZStrRUhGa0t3RC8rSkd5VHdpelk1ZVN5T0ZLZWw1eEVz?=
 =?utf-8?B?akxiQm0vVlRLRmlLV20yaHVIU1hickpvS0hPVkMxRFhQc3RCTHg3eGxLTi9q?=
 =?utf-8?B?VEkyZUl0bG15MEdsclFDTVVFaVQ5RHcwU0Q0ZGNPSHM0dlpOTDRNMEUxejhW?=
 =?utf-8?B?a0VzeDJQQWNMcWZ5ZEk3bEY2MFVpdHo3THl0SHV4NjFQMFBpQTBvOFFBU3hG?=
 =?utf-8?B?Ykx1RUt2dkxDT1lMVEh2Q2Q4Q3lqRDZMSmNFY0p6ZzRDay9YWFlFUmc4SUpD?=
 =?utf-8?B?cFh3cWcvLy80MUR0dnZGZlROMTRjVEdvZ0RuYWw4dCt6d0Q0UzErcXBZSWlO?=
 =?utf-8?B?c0VhbzhNbmZsZ0pzV25uR1ZWekJ2ZUNtMUpmNmYvRnBkT0hOaWY1MTRCT0wv?=
 =?utf-8?B?U2JwRTZDZDA2Wk14eDhKanpjQVBZU1N5RUY4Mko0QWlpZU9DeVVDTmp4YlBr?=
 =?utf-8?B?eW14VmZ1a05IOElGQVl4bzhiK0NLaTN6SUpvNFljUHBkY0Y0VmFXeXZyZlA4?=
 =?utf-8?B?TVVtN3lrbi9VZlMwbVBrSkV4Y3pwclp4NVM2OG8rZzdEM0Jpdk1DaGUrWkRv?=
 =?utf-8?B?elZXYVptelV3N3JpZDgyTHhkMmJqMUdrNzVkTDU4VDFyNStNY0hUdFhYKzlW?=
 =?utf-8?B?SS83UzZtS3k1WVBKT2JIaWNLY2k1TFc5TmFaaHZIQmhVTTJia0FPTXc4d3lw?=
 =?utf-8?B?SE1NZzhMWm9QQW10Vk5YRklZVnVhVUJld1k1cUMvZmFtWGhSazhjMzQxS1BZ?=
 =?utf-8?B?Vndzek5xRldySWZjUVpvR3RCU1ZoSnJRQm1GZjgrK2lxTHJCbVIva1ZxemRZ?=
 =?utf-8?B?azRjSHAzV0tkaHRISjdkVk5oOXdRZWd2MnF2WUFTZmZxZGYvMUNKaGx4OERt?=
 =?utf-8?Q?VmOMJjZpfYen9qiINxRxJRWP4i5J6TEb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4847.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkcxRVVVdUd6Y0pWWXF0ckVIbFJSNkljZ1gxRXVGcHZ0SUFsSzBIK0xiTWRu?=
 =?utf-8?B?Q0dwK1ZFMnY4SldzbzdlL3dlZnN3WXJhVHFsbUNhK3RCcFEzZEhDV245M0Vi?=
 =?utf-8?B?VTRyRkJqVmhSUjNBTEtzQVRoVlNzcWN6Nzl2TTluSEkxOU8vck8ycXdldVRp?=
 =?utf-8?B?YnJGNUtIVHZhdGY1K2FGVVFGeGxYZ0JSem1tcXlHN1MvOVdCbzgySkwxMVJ5?=
 =?utf-8?B?N3NvZnpwZzM3WXFsN2ZldjdhWGl6TnEyKzlaY0czQVhlNFptLzg3WkZHajNS?=
 =?utf-8?B?Yll2b2ZlQ1FWWVhxZjFabWRsU2xnb1JRcGtHSEJFV3dBZXhOUkpTYjdSUVk1?=
 =?utf-8?B?ZHNSM0pOYUpKV1VHcVpkaTZYblY2Qi9EdlVNMmJCU0dQdTgvak94ekFqUnUr?=
 =?utf-8?B?Z3dGUFRkRFh2ZGVrWEhlZjFiTS9pM3VRVkdRMlBsQWRsSFY1cU8xTk9zNktT?=
 =?utf-8?B?OGY3MTBtRlpuYVArWUN1SE9kcXlWaGF4MVJNQkxHc2s3b0YvVjJCV2VvUlhR?=
 =?utf-8?B?R0JQeERVOGsxZ01tN3QvRzUrUHVOYTZnMTZOVEtXTk05dXo1aDFEWHdlUFRL?=
 =?utf-8?B?enNTU3VxK1JjcHR0UDFHNm9Xbm44MC9YQURqeWU1ZThLWFViM3c2UUJVaHA0?=
 =?utf-8?B?ZFR2NFFRN1ZmOS8vOWY1NHJhMDRQSjF6MVhRZk9tVFBEejBGdTFJL0hwNEYx?=
 =?utf-8?B?NnNmWjZVVmUvSWs2MmtHTVpXK2NsS0FNeFkzcno0Mzl6clJ6V1BsRHBPK2RD?=
 =?utf-8?B?KzVnMm0yMkRSRURFVnVCK1l4RjdlZVBQS0Q1TzZJa0QzVTNIMGxnWUcyMlpS?=
 =?utf-8?B?MFBaRkJvMWVlZmN4cDZPUGdQSjJra3ZWRkdFcmtXMm1RSDQwT0lITUpzd0NT?=
 =?utf-8?B?VW1pWWZQWnJtMnM0cmJ0RVc5REJzZDM0azJTSnBXWVB4N21pZjZWcDlHZjd2?=
 =?utf-8?B?eERieEFqRU1iRzVMcE1TSGovNVhqVDNwNHdQeCtRamxFODBERlV1QUh0bGFo?=
 =?utf-8?B?MSswRHJMb1o0U3RNb2h2ZTdpS1RqQVVhSkNuMk15cW4rZWl2S3NDdlJsZFBM?=
 =?utf-8?B?Y0FaT1prK1BTREIxc3NVaEwzTjFpN3NOL09iUU4zOFozTFpzUWtNN0ZtcHRV?=
 =?utf-8?B?VlpvSmhmV0hkbmlwYW1tQlhHMEZhRWJaUzdjTWhMLzd1QVVpd20yT3V1SzBz?=
 =?utf-8?B?bWFZT2ZGRE9yM0lCMUhTdnpJZXAzYzBRMExuRitaU2dvaTA2TkhVeDZLK1pP?=
 =?utf-8?B?Y3lFdXpqcTk5ODhNRFdjNUdoUWM5WTRRbHBvQTNIK2U2N2lBb1lWaTZleGM4?=
 =?utf-8?B?dTFNd0l6elRvNW95VzBOR21hQU5zbWkzdUp1NzlwZXUza1c4Nk9hRjU2Tnln?=
 =?utf-8?B?dGxnTHNJSnBBV3RRcHdrbWZ4VDEwUm9Ub2k2S2tuRm1XS2U2UHpIWlA3cXV0?=
 =?utf-8?B?YVBXT1FQRTloZkFUU2RBQ3NsV0tzNmpFOUtxOEY2N2IyRmltYllGWlBvOGk4?=
 =?utf-8?B?MWlJOWl5cTJUN1ZLN2RJL2dRV3lMSnRVTFRzWHhhdFM5eFdnamlPR1BkaEpi?=
 =?utf-8?B?SVJ4REpMaitoZnFlVVRyMk04TDZxYlVVdTdyOW1KQkNlUGFiTUNXTys3Wk9O?=
 =?utf-8?B?VGxLTEFIWDJkUm8wUkh3N2VWeHRBTnplZWgxeDFhdmlBbzdnWEd1MThVR3Vs?=
 =?utf-8?B?TURWZUZzNHRTTWJrUCtnMWhNWlVCQXlsOEpzM3VrR09PSlVaS2xoTTVLQXor?=
 =?utf-8?B?RzNRcVFONXo3RHZhUlBsYW1jdmpBd3ViM0hWN2x5UlMzbEw2cEpwczMvcGlS?=
 =?utf-8?B?NWg4Y0w0Vkh0LzZuUEpHc0tTbUVHWVdNaUdWK1JTVE5ua2FpbnJjL1VRTExo?=
 =?utf-8?B?QTVPNHVMTVNSMWJZY3FLc2Qva1dKVDFRRGRMM2xjdTMxRG5oTmUwWHA1UDdV?=
 =?utf-8?B?N2tWSjlRZU1pbXhZQ3AxeFUrNEVmMTN6OVkxeWcwVlM5TUNEUG53Ri9mSi9i?=
 =?utf-8?B?Sk5TOGtCSFhkSExlbzFyQzNFT3FYVFFxbytCNjVMcXNVTnByQXVpenZ6dVlB?=
 =?utf-8?B?MHFQWmxtTzlRS2hlS2REdmRWNHE1TEhxQzZYSXVnZGFXYmViK3N3Um1iVkli?=
 =?utf-8?B?L0ZsSHg1TnhiRXlNWU1CT1ZwbkgzR2kxWklhdFk4dEg1K255S3VqUXNrUk9U?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TbjxsWE20XaRfeSgcp4tWbNLVMkus736pA+YiszpZQs6C6xFTto27ydbTLJUd3RBAcUpjehTAlkN2bpPYOM7Khw7xoExJs7nhrJbvM0l58pCET4lsvRxSfGCc1ByKVI81NB16xQ+uMzsyv9UOwl9WNBpdnLA/o1PLfnLQY1ECuOLxtPulxejkwr5OnOOYf809QrZkbNBKvh0w4hFp5n6rlEdfPTImgX4K8F//iWdB9KZWiJyNnEwHGhwpqXzuMXf64NzaBqibPD5u3gDFC7TwcmItzwiKbRS/qHm7Dgnlyo2R7s9w0uYlswYsRu6nif16kfKT0b/+8xQGjZn2QqA7RhPXQwO0NlFxWYQPehEC8OwxvCNu6KtRJZALIOEeZdJy8oWrqpPA8v2C2jfe8Rb4Iq7evYlYVTXZ85SBmBWYqzsKq4KDAcddvf/z2TEbboMM9qOY4XYIzPAbyAb/qr3JvsF+oYmECe/tOnxbLGZztYZJF4sRdZCRBr+a299LR4HwU1udOzGc5zO3CWsDeqTyJN97IU2PbuOzc0gsiCHRMnmTbW+yn3xz4dwwaIcSEZJmz6zmwEn1SJ6jaqJjL3DQ+pxBiNxLzsAgQeyfmIQwX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3831f0df-0c38-4edf-eb98-08de3db812a0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4847.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 22:03:13.2237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dbLT9rR6TyQqZwo7XSzzmnAjkRuyRufPdXRLjV8aHUeBsr/FsmNlUVtXbfzm102wpJ37VwT7b0e/wlVzqbada594XvI27W6Ct+fgbCXObs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170176
X-Proofpoint-GUID: Bci2QErZ0Z3qCPYMIaPRmx_7IJ45Gbyw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE3NiBTYWx0ZWRfX26LKnOk5DuHf
 0u2PODQrzLx6ccqC9zkW7oGOo24QIO+wjlP5XhNs/upjpJ9Md8KqkYilqZ5zzTb+5ydO7wcG2ZS
 fCVtE9SnKN0XN5Cbjq6NkVyjP8O/KX4k2B8A8+k33VrU9zfmtl5oBZ+d42cv7iK61B0sgFqyR52
 HkEz4xi2UnfGgqSFOtsxOG4xFZPa8JNARGoturQZEjHB92jJda1loB8gqo48JsDgv34zWqT5icW
 zDepxeJnG58qW8KqEepbO0MmFTOk3PvO1kkDUD8FrSnXvYTUMVxH4pEKT6R3z5QlzEa4cu1m61V
 IUc2PWzNAAf9hBGqMi2CzXgunmzDjRs+v1cbm1T1pXOtjRjhOjYpOL/PjxVhM4ExnMrMFeRIToc
 ZNbE1XElPSVZxricVDbh3/wDdeAF7w==
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=694328a5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=dSKWXZCsGpzTyduC:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JBQiEXGji8H0c8fqWQoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Bci2QErZ0Z3qCPYMIaPRmx_7IJ45Gbyw

Hi Christoph,

On 12/17/25 9:23 AM, Anna Schumaker wrote:
> Hi Christoph,
> 
> On 12/17/25 4:53 AM, Christoph Hellwig wrote:
>> On Wed, Dec 17, 2025 at 01:32:30AM -0800, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> the merge of this branch causes NFS lookup operation to shoot up a lot
>>> for me.  And with merge I mean merge - both parent of the merge on their
>>> own are fine.
>>>
>>> With the script below that simulates running python scripts with lots
>>> of imports that was created to benchmark delegation performance, the
>>> number of lookups in the measurement period shoots up from 4 to about
>>> 410000, which is a bit suboptimal.  I have no idea how this could
>>> happen, but it must be related to some sort of pathname lookup changes
>>> I guess.  Other operations looks roughly the same.
>>
>> To further pin this down, I rebased the patches from the NFS pull request
>> on top of the baseline (d358e5254674b70f34c847715ca509e46eb81e6f) and
>> bisected that.  This ends up in:
> 
> Thanks for reporting this, and for the reproducer script. I'll dig into this
> today and try to fix what I broke!
> 
> Anna

Does the following help? If so, then I'll probably split it up into a couple of
patches before sending to the list.

Thanks,
Anna

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 23a78a742b61..c80f4d2289cd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1516,14 +1516,6 @@ static int nfs_check_verifier(struct inode *dir, struct dentry *dentry,
 	if (!nfs_dentry_verify_change(dir, dentry))
 		return 0;
 
-	/*
-	 * If we have a directory delegation then we don't need to revalidate
-	 * the directory. The delegation will either get recalled or we will
-	 * receive a notification when it changes.
-	 */
-	if (nfs_have_directory_delegation(dir))
-		return 0;
-
 	/* Revalidate nfsi->cache_change_attribute before we declare a match */
 	if (nfs_mapping_need_revalidate_inode(dir)) {
 		if (rcu_walk)
@@ -2216,13 +2208,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open);
 
-static int
-nfs_lookup_revalidate_delegated_parent(struct inode *dir, struct dentry *dentry,
-				       struct inode *inode)
-{
-	return nfs_lookup_revalidate_done(dir, dentry, inode, 1);
-}
-
 static int
 nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 		       struct dentry *dentry, unsigned int flags)
@@ -2247,12 +2232,10 @@ nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 	if (inode == NULL)
 		goto full_reval;
 
-	if (nfs_verifier_is_delegated(dentry))
+	if (nfs_verifier_is_delegated(dentry) ||
+	    nfs_have_directory_delegation(dir))
 		return nfs_lookup_revalidate_delegated(dir, dentry, inode);
 
-	if (nfs_have_directory_delegation(dir))
-		return nfs_lookup_revalidate_delegated_parent(dir, dentry, inode);
-
 	/* NFS only supports OPEN on regular files */
 	if (!S_ISREG(inode->i_mode))
 		goto full_reval;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ec1ce593dea2..d74cd8659999 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4830,7 +4830,6 @@ static int _nfs4_proc_access(struct inode *inode, struct nfs_access_entry *entry
 	int status = 0;
 
 	if (!nfs4_have_delegation(inode, FMODE_READ, 0)) {
-		nfs_request_directory_delegation(inode);
 		res.fattr = nfs_alloc_fattr();
 		if (res.fattr == NULL)
 			return -ENOMEM;
@@ -5422,6 +5421,10 @@ static int nfs4_proc_readdir(struct nfs_readdir_arg *arg,
 		.interruptible = true,
 	};
 	int err;
+
+	if (arg->plus)
+		nfs_request_directory_delegation(d_inode(arg->dentry));
+
 	do {
 		err = _nfs4_proc_readdir(arg, res);
 		trace_nfs4_readdir(d_inode(arg->dentry), err);


> 
>>
>> NFS: Shortcut lookup revalidations if we have a directory delegation
>>
> 
> 


