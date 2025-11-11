Return-Path: <linux-fsdevel+bounces-67968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2619C4EDFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A51034C3C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D3036A035;
	Tue, 11 Nov 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SCx/ikPL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cZ7wZS+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3734253B;
	Tue, 11 Nov 2025 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876435; cv=fail; b=lI/A1XPRvilLDfKv2exKzsASdLXSt167y3rOLbPJzifGeGeVJ0d+4fYWjseyGCY4TZacgoMPzC1rw/+YZEqEWJDEEl0NLGx9v2iWPmB7W2mRwa09yUMIw6fBzwxo+bYTQMoHnt0Oen6YJURosnZvcDZUaeQYAE5jh8xCSrk69mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876435; c=relaxed/simple;
	bh=HL/C4wq6a0zH3/N/sJJwDiFHOc5RhUT607YHt8we5qU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SDucTFsizekgPgwd/avyzDE5ocPwKL9UA/yD0cE/OP/mG5nmQQP2Rj2hVbvNYp7RfFUC0wt7dblPWSMOYpe9QTUxv0AFwR6dZrOqXwYV8r32uCUV2xrXZr0uzKzYCYiBvEOwKccaqL9wnTaMEx4UEdMk3TJIbNvAk1iQpsfSNhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SCx/ikPL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cZ7wZS+r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABFNU4q029857;
	Tue, 11 Nov 2025 15:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DsuLJZF0Ap6TRHgTls7VVHRIwDmXbaRBPt+N87yHhiU=; b=
	SCx/ikPLm4Po0hbexd1UheDP75ozuVk4/xRB32m0U2Bdt5vZ4dQGdYAiJ4B5HFg2
	Hf5ywuhyo4jrGCn303MjjOwud4wic/ZaDmplxl3apa8mFToWe5NBi7/G4mNc79Pp
	gFo9hEk+0h6i56cbM92PgDRLaP/6ljQ/1/l3KBbdgv1MWgVc8/KXuot2OLWmkO+i
	Bh2fjc37+PiVBFkBdGfYhnuxbP8sCWzP1qMNCYBv0aQnFfaURy/31kGrLYoO1FXN
	CH4Oz+kt7EsjfTWa+5uOwYc4wDtGK4/NhY7r3HZrdBnks9yZrtVqrPn1bphKSWF4
	jhV9ogJAlyEhdAUpkF629Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac500rdrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 15:53:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABEIcCY010027;
	Tue, 11 Nov 2025 15:53:39 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vakefkt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 15:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6OGUes/zOfljgkrhSvhBLoQzXYVYlCcgEGsDgwrC9aTA2W2tAgeXA8zg2IED5rnodb+hPGxL1kywXAOAtm145c4tMVGTLzrrEG9eYwgxroy/vo9Sm9CyQkFa5yNjdsKEHP/JNZ6wfNTwUe1VosWC2wcmqpx8BCBzFoQP6uOtRTXCmXbIlDRy5HJDCNfUK/LORMBINJW4flxpaSPEUq1F4GIciALMY2uscOVz4w3BbipJNYR+QLyn97nW2NhuZj5fkSE4MdaktKSBc9wwKPfk6BqFONkAyFqokG4tCFa01tev4Q/uGR9WDH2I71FG4rF6XoIBIVx0cKGfAiSnbAfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsuLJZF0Ap6TRHgTls7VVHRIwDmXbaRBPt+N87yHhiU=;
 b=l4nycA8n/e1y7awRQekRRADtkD3fXYdseVoo1X/RzLv/Os0tT1cWjYgdz9l20fh9xwn/z2uSCwXR6E3CXA7oj4ZZz1RYuGtF32lrsq0tpZI6nuozWWyruW+NmgYNMBaZK3caRjRfZmi5FT9dfkBs0WwuKs1CGgMNBguVCGwFMWEiU6CutQPi8FrmzyU+7/inUZacv2Me3rOr3ndoTQnP/0Fo96eAGBV6P9EuI+Lzqhbdurd1XJWaosKjDzPd3YiUFvqTGkQawH+ZhYTdooeGrlkAbZoCKUV9PKFpy0wkykhiVM/08LmkUi1kZxXvtAFB715OdFj1XxNdvGPIAWvaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsuLJZF0Ap6TRHgTls7VVHRIwDmXbaRBPt+N87yHhiU=;
 b=cZ7wZS+rA8FRL9stEUmxdtI5rs+3AF0OC+F9i1bjConD5vbkS86gzTpmk5gzIovt4FZuwi3NVCKT/fOIuums0HRqDB6DFEM85je2Kn2tpq7pke3UzNflIKPD2cVEQlg5BpKksvXmIKR6rjzyyYPjvK8e6/hEbLex6evv+Uo/tAM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7604.namprd10.prod.outlook.com (2603:10b6:208:48f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 15:53:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 15:53:12 +0000
Message-ID: <295c1967-7cc3-4783-99ac-a8060c1380c2@oracle.com>
Date: Tue, 11 Nov 2025 10:53:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch 0/2] NFSD: Fix server hang when there are multiple layout
 conflicts
To: Dai Ngo <dai.ngo@oracle.com>,
        Benjamin Coddington <bcodding@hammerspace.com>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        hch@lst.de, alex.aring@gmail.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251106170729.310683-1-dai.ngo@oracle.com>
 <ADB5A1E8-F1BF-4B42-BD77-96C57B135305@hammerspace.com>
 <e38104d7-1c2e-4791-aa78-d4458233dcb6@oracle.com>
 <5f014677-42c4-4638-a2ef-a1f285977ff4@oracle.com>
 <3dbe4a47-615d-4b5b-bf14-05bacf7de9e7@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3dbe4a47-615d-4b5b-bf14-05bacf7de9e7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:610:59::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: a99c681b-e53c-4cbe-a306-08de213a6b78
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VHE4ZWQwR0toM3dkKzBmazVid1IyMDhxczhFYm9WMzZDNzJPOXBrNEFDNi8v?=
 =?utf-8?B?TWRndXVlVERtSkI3anBaYm1aS1B0UzFFSnhFSkY1KzEwa1REaHJxWFBzN2w4?=
 =?utf-8?B?bXpTbyt4ZVRTS1NPYk9YZ0ozZWR2dVZMZUxvYjlIZlZ5UmJIaEZYR09tcGVU?=
 =?utf-8?B?VE9sVlBZZXRqeXZjcmErQnNtNE1HUFQ3d0J4Yi9YSEVpYW45RnEzRXUrdHhV?=
 =?utf-8?B?MnBTd1ZHbkdEOGhCSWJKYkVaQ2VYWncvRllqZXF2R081N0c0dUErNyt1RlZO?=
 =?utf-8?B?S0l1bDVDRHpKT3U2alY4WjNrekJDWlNQUmZnOUlvZERrd1VjaEZLT2JaVEdu?=
 =?utf-8?B?cE1oTnJJbVRHR0dlSzNaUmQ0UWdKUnczcWkvdVptT1kxUXZ4QnRvaUhFRHJy?=
 =?utf-8?B?ckNBWlhTSnpmajZBQitVQS9tbHFGYjFkc1RjbzR5R3ZiL2JGbUZQNXc2U05O?=
 =?utf-8?B?TGI5YUJxM1ZoSlFXZVJYcXlLZ2pNU2NoaUo5dDF6ckFYK1ZRay9yL2VhR3Bt?=
 =?utf-8?B?ckVkaWxwK2UyaXR5Y0VoYVc1WUxuTW5SN2tHd2I5MW1PUDVIMnNpT3BMckY5?=
 =?utf-8?B?R0RZV1puUURIQzM3Q3UzcUdMQjA3Mk4yVkRWS2lrbWpsb1lUZTZubGVzLzFB?=
 =?utf-8?B?bHY0K2dHZWRMU0htL2Z6cVVITFVKSXVGeWNuaDgrTkRIZDE3bEhIejB3dEVL?=
 =?utf-8?B?c0ZYMU8zUGNvcys4ZkpWcWV6K3FYOWtVTXVGM0R6SWNxT3c2TW03RTFRUDY1?=
 =?utf-8?B?OEtTd1V4c2hYNW9MemhDeDNqVkxLaUJMOE5ONFRhUzlYSGlXQUpCQkJOejlm?=
 =?utf-8?B?ajcxSHdzTjZDY1JlV21GdmxXSVVHV2R4S1hmM1BGQWFtMUpYVWZQaktLdVEr?=
 =?utf-8?B?dUE2THI0dHh3Y05oNUZTMmk3bUUyOW9WNnJrRjdKY1FwbTNFbGVQbGhhQmw4?=
 =?utf-8?B?OGRVakg4WGZOLzZLblFTSFY1QllnQ2ZQcWF2K0pSN3N0QmtIMGJ3NVNPbmRF?=
 =?utf-8?B?Y3NkaTVXQnd5WkFYOUpndHlwdnZRS09sV0EvTXNzZFExR29vUmpWV1NZVUE0?=
 =?utf-8?B?SlV4WWYrTyswVWNSTkJIclJEV2JQSXMxSlRiakxQTVpLanN6N0Z4eHh3THgw?=
 =?utf-8?B?LzVnMTlWa0NOY3J0dXRkcmlGYlBLdXJBRmg0SnhhT1oxV0FmcGhvY1FVaThy?=
 =?utf-8?B?SW5Cd1NDOE9KdkdMc01SbXYrOW00cDl1YnRuemh2ZzFkUnFBOFo3a1V6Vmtx?=
 =?utf-8?B?VCtRWmg2SUNpNENBOXlTcEVSUm5uMlF6TnZXRmVtVzdWd0IwVzB1TVk5Q3oz?=
 =?utf-8?B?am91T1lreG5sQ1R0eEtsTFVhaU4wcnNKSTVHdC9FNldveTZEV2hDUTlxMFNP?=
 =?utf-8?B?STZtWmxXRVBuRHcyMU5RQXVoMHgxUkxhVjhPT1d4UHkvQU5Ga2VLeFV5bDg0?=
 =?utf-8?B?elVEenB5K0ZoN2hheXFHNE4xMjdEbHlROGl4enl3TjVLOXNZajNWeUlQNjgz?=
 =?utf-8?B?NWxpc3M3ZFE4NURTZFNPdk5LbHAvWjgxVFh3OHg5NVFlMDlCK1BVMjhGNEx2?=
 =?utf-8?B?RXZaQkdSaGNCVEhrSmhGS25RWlNWSUZGdklURS9Vc3ZxWUcreGhiVC8vSE84?=
 =?utf-8?B?WDRQejlSUSsrWTFwbHYrSjVuYWdXNXZUZHlJMVdpdkQ5aEFLdjNsNjBjczhV?=
 =?utf-8?B?NFZveWdSZmN1TFNKSDJZeEpibGFVWkM4UHFCeGdOL2pSWW4xei9rekl6Q3hr?=
 =?utf-8?B?M3lRZ1ZCc2I0TEcxNVNjSGd6RHFGMDJqK3N6OWQzeVRBTGMvemx5QlEzYmlI?=
 =?utf-8?B?dm5JRjFJTFZtQUtjRy9nQWJGckpBMXlyMmlVaXpScU5pM2hCUHhaOXp2M0lM?=
 =?utf-8?B?a051T3ordzRTdW0xMG1DbDFSZ1c4aUxmdEpJTzBxbDNneFZwc2FaVHJNaVZQ?=
 =?utf-8?Q?THBrL+7I32c6Bgn9S/x5DWWEqZDMZuJk?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Qkp5WXB3UnVQWVV5RzBnNjRaeVNPbEdtTXpESC8yek5BdlRXR2F2N3NDU0Rk?=
 =?utf-8?B?K1ZqTVZOVTBURk1oWlZYdFRlYlFDNjZBcFh4NHdkUzZ0dGM0QkM3Sk1jYWtH?=
 =?utf-8?B?dEZtWk13VUNKT2hmbVkzWGUrdzc4R1J4dDVSUk9LTjdtVWJibGVFdkVONWow?=
 =?utf-8?B?NUg1VnYwbEUwa0xqc3R1a1JScTRwZ3JlYVp4SWVKTDB2U0wwZXhIWUErNWtj?=
 =?utf-8?B?bjlKOGVBNkV0YjlHT2FzVGxKajZkVXhzbEUrMDFmVUJ5YS9JdkI1dVA0RDNu?=
 =?utf-8?B?QkVUUXB4b2V2RVVnNStIcDQ1NjZURmRpRnNZcFo5WVB4dHJacXY0VUxBWlpL?=
 =?utf-8?B?ajJCdG8zbjE0M0JMNjBqNEQwYVQ4NGZtV2FpODJuSnJhQWQ0MUlLeDdNZlpa?=
 =?utf-8?B?eU1hb0RVZDNHSTl3KzZDdVdLMGl0bTJaQmRydVk0aDh3aUZKdERUWllPd0J1?=
 =?utf-8?B?R3RnNy85d2Znall6VXJPQTlvR0VHWTVqWVBMd0lGVjMrQzFveUpjNzBKL0Jx?=
 =?utf-8?B?S0lFdW1iWDU4dHBML2llV0dkNm5FRXNJcytuai9yb2J6eEh5WC9WaHBBeDlP?=
 =?utf-8?B?SmFUZG5IbW5YZFBiSUZMZUowemVBc0FQdEgrT0dDZEtxYnI4SFI0V1NpaHY4?=
 =?utf-8?B?anV4QW41Wk9BYThLRmpBaUxIcWM3TVdzaDA2aW9RMmZ3Z2ZLbHo0VFBlU1Q1?=
 =?utf-8?B?c1VEeTY3cGt0Vjk5cXBMVW9PL0k4WGN2VHIwMzRKblVmdXQyZzIyWnhBTVNM?=
 =?utf-8?B?dTFnQWxnaHhwcFBsQVBYY3JCUXJDbmR0dUVJRkZUOXNCT3llNmZXRVY5OHNQ?=
 =?utf-8?B?RkVVc2hzbjBJOHo0V3B1emRDaTMyZUtxd1I0bmRzcEtFTjE5a0o5STgwNWFa?=
 =?utf-8?B?WjU2d0tnamE2Ulg0dFh1cUZRRmppTE0wcVhuVGRvcUFjYk1jWFZjQUZpcnVh?=
 =?utf-8?B?RDJJZHVqZVRBNFdxOSs5UVZzRmR2VGNEYjhmd3FnV2VpbzRicytRLzM2bVlN?=
 =?utf-8?B?WXlNTjdoczJlL096Rlh5bEFORitSL1VQdm9Xb3FMQUluNkFQTnlXSktUYnN0?=
 =?utf-8?B?ZlJDNmcyeUQvcUZrZmR6UEl6WksvU2k5QnJvQ215N2R3VVRrRS9sejZnV3Vq?=
 =?utf-8?B?ZFUrU2F0UURHUTE4MjFqWWZBeEFPNUNTeUNVeTNjSFJOZ2ZWR2lmcGhPT21W?=
 =?utf-8?B?SkFLRkVQQjlRdXFVbEJuYndUUEtFSXJlYmlQdXZObXRsdFdUc0N5R3hUSFlY?=
 =?utf-8?B?Q0FrWHlSK3Ezejcrc0c4WXZFM2hicHh5bmNrbHFDc3lOTk0zZUJaMDMyd2NG?=
 =?utf-8?B?dEpIZWJYWkJZRDF6QUNrWnFoMDRqZzZlZHRvd1ZDUUd3ZVlkdU1rUHpiNXVR?=
 =?utf-8?B?Y3YzNXhiOFQ0bzAvZjJSQ3lTZUdWeWdPYkZnUEtPWEoyTjFDNDVZY2hVVzVT?=
 =?utf-8?B?VHo1dTl2UUNOQTBGWjVkZk1QeHFzK3hGK2s2TnNORFErcFhUQmdDYzhra0I0?=
 =?utf-8?B?TTNIUUM5YVJyZ0Roazgxc3hjYVlYR0k1NC9IZkFqbzYrdVd4UEJRVm9mdW52?=
 =?utf-8?B?TCs2L2hVQ1pWQTdDc01YV1c1TTYrRnVQRDFSY3IySTBrYVhZMzhhVjNyQ054?=
 =?utf-8?B?ZWErUDc4ODhXS0FnWURaYlhyVjdMc3dvSnBXeDN3KzBKdE51Qzl6SE1LTmFp?=
 =?utf-8?B?M0RlQzhCQ1ZpNTR2c1dIaWVIbHg4a1J4a2w4NGI2WG95RWVRakdMMGJmR0gz?=
 =?utf-8?B?ZVplVEFjbnBSaG9iRE8xaWllQ21pVndQUTQvZlFyTnhDMTM3TVJoM1hET203?=
 =?utf-8?B?RkwvQ1gxSHNzWVhXenhyL0hBQWpWT2RZNUFkT0tEOXM1OGp0MGsxbWlFeHVC?=
 =?utf-8?B?NVl0MkpqdEhNYlFNYlp1SFc0S3NJY3h6Y1Y2RG01c00vaDQvalJJWXUvRGVB?=
 =?utf-8?B?MzU0Vkt3YU4rRjBUd2F6RnBrWDlydWpvTlJFeUF4UVBsb2R4bnZSdURkaVU0?=
 =?utf-8?B?blIza1ArTm9PTFVVZHAzL0lTMmM1bkxJRnY0RWNPQy9hdnpicU9udjhLeG1S?=
 =?utf-8?B?Y3NNdjhmdEFqNjB4cm8rSlU4Nkh3dGRabHF6Z2c4Z1YzdHhrUXRHVlNZZzFw?=
 =?utf-8?Q?qG21QdiPWsyhMj2qpQd6/ehFJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TTtrWb3lKcdw13Dt0tqULh0JYdDtHQCXs1AUhFvLkkiiM7ZzjorufrFfzLd0dTBXBp8ceT9sKFKxuLDSoUcL/plqKkalGbaXWP5GsOEFK9LHAgKKPiYFHN8rjgRF4g3rMICHyjHQE3PxPFwhzdByuH9rw4QfE6So3dAyYkzBYcl5ooriCz95sOv2sJlO6nWz6ltOgVPKtOcGlkL3XgLxOuuAqJTLjDloMpQqhWml2CLxgE+kdE4fJOQ3yD/Y3FejlZkGCO31jRCFlj7mXL16n5OavKhzEVGeGhHmhkFZSV1hDn0vehAXNjgN9KIvkpPU+mZrARN2VUJiD8Xv8BXOxbXn2eQ/c7AD+bjK4UTGrvycIMNTXqZDdwVZutusWAQoLAHj45FmXZ1J9WzzRaAWHK2PBNVJNpamw/MmpDtYSWF56385bwPKPt0C5CUWE2caMi8SXC3mZxDksD0ODliFdi40j+XHNdkphdNxzi+q65Q1O0Uq748Yr7uWA1z6icLyd+wAYks6p3GkOXMinv8Jz0TZhUXBY4NlPM71JKf/OPmuglr6UBEZYkF4VOe1NP6xO1brePgi+932jgNqaAEH+iGzL4h+FAvJ/ZXenvRXD4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99c681b-e53c-4cbe-a306-08de213a6b78
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 15:53:12.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GIVQqpb9Ha1BfbEKhxpNBkcyPjtisv0ROoDjLnVQ5UTeAzqmv72rP1NZs9IpvUNZykt/VN+NufRNDRZmSpZ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110129
X-Proofpoint-ORIG-GUID: UIIOOYfkYUo50dgGBL2qkvxkbrPnpRNd
X-Authority-Analysis: v=2.4 cv=WuYm8Nfv c=1 sm=1 tr=0 ts=69135c04 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=flbYNHY43kNVR5B2RekA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5NyBTYWx0ZWRfX1xBJBjPNuS7E
 yEWPaRsplJNAZj7JzP0P3dFx9pstL0GbbCP+gyAjiqvXszdVnGIe6KlkXTw6qTY6aCntcnqQn2y
 un4uLN0ZjdWLjawv8AXPbU8GNwCw4z4vMuXzn3DYiBS6aQj9/UQ0EILnuB9zYeAhU+WlCt3Czcu
 GAOe5YE06/CacYfYeG65oJfTAEQHzzP2pKjvb5YR4/IFGTQbV+fqVPKaC89UIrjo3mXD+i+Zdul
 OQlDL+St1hY0LkqNnx/8UQ2xBigePEndmOqmkuXkJVKIJs2gX94/giMkKxTzunC5jFYZ7TCr9i+
 UU3PsAohOmTdGqkPfOA2E3AB8nOBHD+mAMIdSVB9fRmG3usjwQQSC50eqlNcVav2FQnonBNyY0H
 6ZDMByrBLASxPi1hxDdQLkFOBew7B9GuU75NSgAFh+LDdg7oEgk=
X-Proofpoint-GUID: UIIOOYfkYUo50dgGBL2qkvxkbrPnpRNd

On 11/11/25 10:43 AM, Dai Ngo wrote:
> I think we need both: (1) dynamic number of server threads and (2) the
> ability to defer work as we currently do for the delegation recall.

Agreed. I wasn't trying to imply that dynamic thread count shouldn't be
done at all.


-- 
Chuck Lever

