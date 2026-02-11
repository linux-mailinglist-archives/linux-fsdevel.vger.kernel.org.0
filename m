Return-Path: <linux-fsdevel+bounces-76982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC+MIAkTjWl/ygAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:38:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9312855F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B80573030283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 23:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D103587DD;
	Wed, 11 Feb 2026 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GXy/P5O3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CDb5IAfP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE73587C0;
	Wed, 11 Feb 2026 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853121; cv=fail; b=C+aXCLofOmGAMJHm68U1u4iRWNVkYqBI3vFn26P2YqEtnFIrs+o8GVsIQir111GCeEUh4/ej7kys+hbQK24GtGqmMJAbP7/3urhWii8/T1Nmai5W4j4Ht1yetoxYxeEwiEqTghqWtK+ANegtTZQTB6qTIMTvw+iTRXd0J2Skx8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853121; c=relaxed/simple;
	bh=QuX6gtm35sWIyiyeIQXVsJ8ncB0vYtAHe5pRruHsiBY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tBSEaHLQHwWpW+tBc8oyFE5vB34AKzgQM3f1bTpLWHQuH8xDPQonT3Hoe0OZaPOfx630cXEx3y6Btzd5XLNrQsbcV5zIAgcR+ZU9fesocN2wzcfV+w/L1oICCFE0o4sUbK9keggyuh5Zm0RNHwAXRVBK/odtQIYURBTWAFRWpg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GXy/P5O3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CDb5IAfP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BNDXeV3474646;
	Wed, 11 Feb 2026 23:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t8UFWCdVnhQxcgHxLhXqZln3u5IvrfRherEjuWLtDoE=; b=
	GXy/P5O3+kBxSXLarn0WyImy2d89Lp8WQQJohKkYq7VI6e6978z+YCH54d6W4Yco
	uMTPlqRhTOfZd9YNqNo088kclFC5IK6rsX/l2sl1roNQqkX5kWQgSmwiNIN267T6
	MPTy1/oDVxe4Jz38E2noZcZtGxU2aB0GPlksrkbb0KkosY5pX9X3c8Fit56tMLeT
	2hyQtCwHr+p9jxj/Ae9FZjTBvOB/nhLNK6Xm6Ym2g00/2L+24fJEtFC0V13XXQIy
	6nfre1gojr/uFRA/0axku7uAm0bXnyA79NLbKGvLg0Lzth1fvVYuMjQGQ5CRYWRJ
	CVbj0FgaU6ZEj4QxG3k93A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c7rxu3yv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 23:38:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61BN02KX033009;
	Wed, 11 Feb 2026 23:38:25 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c825vq8h3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 23:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWyQcYDNkQ2DQ1OXNJ1agRWo4HbQZPOUhWgEetzxiUMRKs1ngLfDS62FLHOK2NTna/NMumjtTQzIsBnxJU6Tv7rpK3yj5MlvQrIUrAc9cumZ1dQ7a1RQoX0a0vGSSfUXYXZtMErFafK6fXal12MiHaRx3vAeNTJzrHmwibTOp7RcsxSM2JtJz1ngAy7I6KTc4JzIFGiy1Ik2jDQOiKC7q7fBqTH/n2aMSjw+klDLxVYCu5506ao02hmb2ssWNlxwwohOLKSlu7MVvyQsUYhZD2XnOFtv3hGta5wCibqJ7GWXKnU3OW6NXmiIeCMMaY0ugNm1MvhvC6yTLb6Ujj9aKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8UFWCdVnhQxcgHxLhXqZln3u5IvrfRherEjuWLtDoE=;
 b=Qs2Csatfxbr1L76jnc+aqSbHaJnB+sa6eH9Aguzq138WBLYvuxNscUoO06fFgStoiXvrrZQk/1g6tB0N3YN19ajJMgboM7yyamvU8ECbrwDsCy71aPDUQsBQGJHqpwyIZPYcKqo3DwZzVww8mxxmyjcZADzi/IOcGYGg0q2wON3jckWbo6MaMXqyshTjMO29eKUfW0KKj+CBWtmB2KqsKDKozXb7IEq/j1R313FhquAzOZkCRBjqCO2WhsHolV792HN9Xbe6UxMlRrf5/5IBWwg1yW+723QmUZcRmVfib4HyZzRkVaujeulGkp3EG3NLw6Vn5lZ56koVmHV5hGwCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8UFWCdVnhQxcgHxLhXqZln3u5IvrfRherEjuWLtDoE=;
 b=CDb5IAfPn/k9T4J5c50Ue+KwDJc/xOljK0zuVFcUmVJs4ubNn56oKj1m1J8lzww/Mq8HFVGPqmxlj1Hcb6jIjFFfYumDmmJaxvSia/KO3pKW0Y7RkSd/qtYlvGrMR1C6p1jSj96FByIQxhfwM4E/hGWKyNxgFh5CKypSGRS4XVU=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SN7PR10MB6980.namprd10.prod.outlook.com (2603:10b6:806:34e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 23:38:18 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 23:38:18 +0000
Message-ID: <1677f1ed-27db-4525-ae3e-5e4d12a9f5a9@oracle.com>
Date: Wed, 11 Feb 2026 15:38:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260210181632.1161855-1-dai.ngo@oracle.com>
 <a06f4c17-8227-4c04-b270-5c064b7de79c@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <a06f4c17-8227-4c04-b270-5c064b7de79c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::28) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SN7PR10MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d524cc-d707-4689-d90b-08de69c6a24a
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K1VIb1hHdFBCY2xrakJHOXJIK2s1YWIrQzBYYm1kUHpBaHJ2QWNTdzVHTUJv?=
 =?utf-8?B?V051TUUybGNsMElaRmE2Y1RRWThkVzJDVkhLS0kxN0k1MUp5NXFLK3Y4L2Yy?=
 =?utf-8?B?eDBKYjltT1k5ZkxSbDFTS2N0azBWMjRwSy9FNXFiaE0yWTNtYWkzVVFsZnZa?=
 =?utf-8?B?Y05IODVwMnFwSjFocjY5bjJjMVZsWE5YWXFHMEJsMGlITDdBc2IvOEJXRXdY?=
 =?utf-8?B?b09wUXozZGlqVjBDa0ZqRjNKaDBYaWs0eWc0QUZZbzN6Y0dYTEVXaXdHK1lX?=
 =?utf-8?B?S1FWWHBnVGU3NzcrZHM4VGJ4WnVtYWtSYXlNN3FEc3FVcFNGbnlCMEd1WERM?=
 =?utf-8?B?OS84SGRpbkxhcHBqTktnd2lKb2NzdldkdGZqbnNzUzJUdS9PQjlVdDBxUUd1?=
 =?utf-8?B?OExRbTZEZ2psY3p0NkpUV2NlRFZyUlFPcHE0aXRCM2VvdjZYQXkvb3BnZTJa?=
 =?utf-8?B?L0Q5ZVZHYWt5dk5ZdmlXWDdzU2pBTGhnbGN4MXZ2dVVPRThzU1IyeTNuYUgy?=
 =?utf-8?B?Q0F2ZlY1cnllVW1OYmF6U25KdTllS0tuZ29aTkNSR3hzazVHNUswQjMwZzNZ?=
 =?utf-8?B?N1Z3MWgxWlNuUTYyZnBudUlSTmxLYjVGelRBSFJPZlFBVWFBVkY4UXBscFZp?=
 =?utf-8?B?ZEN2M3JDczV4QXVWYUkrcEtxNUtzTUNqZ2FjSFlybkRFeEs0cGdxT1JrT0xy?=
 =?utf-8?B?R1duVjA1WWpLa3FVQ0JTV1lvSkZ5TGc2VDRSWjhROHVMQ0lKWlU3azJYYmFJ?=
 =?utf-8?B?NzhYTDY0Q01RbWE4QXJrWWdsVWt0QU41OU9iVXdVdzk0eU5RaVJXYm9IVldU?=
 =?utf-8?B?NUhiUWNiMFkyWEF3SzFjQ3FOWGtQZ3R0Z3RFNTZOT0RQZkJyL0dxSjIwSkx6?=
 =?utf-8?B?RE85RG5pR1doZWMzZXRsSUVmNktBMlJtNjV6d2NiUHl4ekRFRDkycWZ0aThD?=
 =?utf-8?B?Y1FjZ05YZmpGbjZyZ3ljMzVicUt3d0FBMThBN3lzVktDRHlGL25yQlhiclls?=
 =?utf-8?B?RkprdmU1anQ5aURkUXJRekR0OU9HR1V1cVpoRmVDbDNGZjNXVEVxNmdpdVlq?=
 =?utf-8?B?bE4yMFdOU0ZxZXdlL1lJQjQ4ZTZTTnBzckVhQmprSzJ5Y2JZWWp2S0pRbmtY?=
 =?utf-8?B?d0NGeEF0SS84QXREMmdBUXQxR2tPY0lUQ05sOEhUN0U2bDU4c0Z0c1NTUTgr?=
 =?utf-8?B?TW4xb1NEVWZCWkhhVUNvS0YzSi9wY2tyNVdRT3IxZEtYM1JGZ1l5RFF1L1dG?=
 =?utf-8?B?S1d3cGRmS3lhTnlMOFhwdzRhRzZYM0lnYXZQSDRuMUNDU2EvQ0tXVUZJaVNB?=
 =?utf-8?B?cmF1MG9uRWFHdStERWN1Ujl6eTJ2ekpRdDR1bW1mKytxeENHUVprQ0xVOWN4?=
 =?utf-8?B?RlJUcnRLSm1Mc3ErZGtZa3oyVlgweW94ZnRzY3RqeURnblNhNHRkaTU2bi9X?=
 =?utf-8?B?UHFBTWRmN1RJRFk5elQveElYUVAzcHBXYngwRnorWWV4dm1JMWJUQVQ0ZG54?=
 =?utf-8?B?YWwyMkcxNEFINThUTXk3ck84Z2gxUzlibHVOSm53cW5aTDBKVUxYclFUNjVR?=
 =?utf-8?B?UVZaY2hmWGFEbW9xR1VYMU9CZ0t6RndtMlRwL3ZJNEh3QUlVMjl6U2cxVFZQ?=
 =?utf-8?B?YnF6ZkFhMWtxL0NsQ280eXdpU2dia2FJS1Q3aVBjcWhiWmtqSWV3TDVrYnEz?=
 =?utf-8?B?RzB4eDBYZklOQnNtNVdkcjd6WXVDSU5ZeTlIZ2NnU2hkODFJT3ZQT3FVd3BL?=
 =?utf-8?B?cE9sTmJGV1poYzZwMmFZa0E1eS9HemZwcnl3Qllxb0hONklSWjFjK095Rk1l?=
 =?utf-8?B?cG1EcW4wM1hlaDBMUFprVmVQb1lvc3l0Nkh1V2VNN2NyTW1Eck16ckpYSy9D?=
 =?utf-8?B?b2JiYkZhUEp1YUZ5WEtFS01VWU9oVURCSkh1Nnl1TFg5UzJGWGVIU0F2WnRX?=
 =?utf-8?B?ZUxqUngzdWVIMjd6RWJGaXBxcFMvZDFoT2FPbmlGdkZuRU1ZZWpJZnBaTDZ1?=
 =?utf-8?B?VmkwKythSUExU01EUi9vYkN2UnZYZC9VUm8wb0RXY3JFVGpwZjR0MUs3QmlU?=
 =?utf-8?B?OWtFeDR5bFE3MHBHdDg2ZlBIVk9aR3JaZk5UM1RNT2JjVnYrWHhOT3dyWVZu?=
 =?utf-8?B?eDd6SXlQaVQzdlFvazNPUDd4Tm9VYjh1QW5IMUhsallXNzc5NVdDaTliWEJ5?=
 =?utf-8?B?SHc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bFloWHJzZnNIUk04WDIxK1NlVXFpRllVcTViQUZOajhpVmJ2T0c0NlBDaWMr?=
 =?utf-8?B?LzJrV0kwR2ZHNGZxb2VXL2dOcXJ4dGl6WWtzcWlQV1pNR2JSVmp4dm9GTlVH?=
 =?utf-8?B?R0kyS0hOVTVqd09VNlgrVWNzOGREdkQxZ0lwOVlld0dkR3RKNHQxS2RKRG1S?=
 =?utf-8?B?cGJWaWwxZ0ZPblBYUysrbFRSUGxVU1ZQdERHNGRGTW9EdlZrUVdlc2hBTVJq?=
 =?utf-8?B?NXRuN3l4UDh2aU5SK2RsTklEWUp5YmZxaCs2aTlOaHRhRUhCUHVoRk9YZEN0?=
 =?utf-8?B?M1o1V3hjTC8vRWNsSThob09acytTOUhRMjNvcGNieWZIUVgzK2dySnRGUDI1?=
 =?utf-8?B?S1M2QmpQNUFwS3ZVYTF1WVVOMWZqTE5sbEMvWEVXK3B3c0xEZ0ZRYXdGOWhx?=
 =?utf-8?B?aG1ob0tRZktJeWl5OGVMeXNYdjJ0OWRrWmF4UVVrQmVkZDQrZGJtd25Wbk1m?=
 =?utf-8?B?WHlUeGhaT1R0NkFtektmZWZjRXpHUUdzWFFMYkJYd0w4UVdmWXZObS85WW1K?=
 =?utf-8?B?YWdqam9jUVRHczZaWS8za0dkZjFlMkJaRFNYSXJTWUhMQ1dVaU1OT3Q3bUtu?=
 =?utf-8?B?SC9DSU5DeG1oL1luSjgvZm84MC9ZQWM2WFB6VlZKOWVsNlJMK216SXlzNFpu?=
 =?utf-8?B?MXNtU1FHWGk0eW9IVy91K2xsV3NCUk92Ti9ZTGtWeFlNV3MzUGphY1FKWHR3?=
 =?utf-8?B?cjZRd2xHMGxRdlpjQmtVU3RLR21Kb3lxQUk4bkpReVIveXd5ZGozbkhBekEx?=
 =?utf-8?B?SkZ3a0E2R0Z1TS9nalNLN09BVDY0Y253SWFmMmRBTkhEZk9NUWdSejdJSHgv?=
 =?utf-8?B?eXpoSytNVjllL2JtejhQYWFRd1lMT1dPZkorSXQ1VVQyakE2eFpzcEJjNk5w?=
 =?utf-8?B?akFiWWVBeENxV1BmUU01U3V4VEJaUzVQMTcxUWxlRVN4VXBvZkpad1A3QU5F?=
 =?utf-8?B?RUxPY1pya0laTGhIQ09XQ1g3eDkwUXZYOEtBMUhpOUYwYjdYd2svWFkzSjZ4?=
 =?utf-8?B?SlZsZU4zSWtwRmszZTcwMitBdCtKeEFuV1NMRTVORmwzN2pYQ1FtdnZrQ1pn?=
 =?utf-8?B?NnprdTVlcHFJSnRJdGpWMnZabEhjRk44WXlHUVpTREp1N01FbjZYeEpBa1M2?=
 =?utf-8?B?UlNKTjNXSDVxYnVLQzlBMG54YmxyZDBlV1psVGIwNUY4K1lPSVJyc1hTeGFV?=
 =?utf-8?B?aDZCWHN4TGM1YUxxQlkyd0grbDNUUzAvLysrT2pUejJXMnJNSmRka0MxNEYz?=
 =?utf-8?B?UUlwWmF1NlJhUkNFWXB5THp6dlY0YVZOcEdkay9QdDA1czZzZis0V2ErUllv?=
 =?utf-8?B?a05uUU1XRkVHQkM1Q0FlNVFyL1NlUGpIa1dlUTR1OU1RU1czckRja2kvNXZG?=
 =?utf-8?B?dXM4RUQyUFFBdjF6SThNbnoyRXduYUpqSC8vSWZtU2pVaTdMdWl4Nm5kclVv?=
 =?utf-8?B?eVYvRTgrRUJqTVJaRkQwOTZFUlNmeE9qLzBvNGxVNWVHYkdNVk9hbGVSZ1FK?=
 =?utf-8?B?OWZ6VzNQOU1qWGJxc2NRajkzQVdDbDhLOTB1UGVZSkx1eUdKdk1EQXVGd0VQ?=
 =?utf-8?B?eGUzY2hmYTlIR0JiVWM0ZklkNDdaOFp3MFNhMXpsQmpWRENVTjhBODMzak9i?=
 =?utf-8?B?TVNBU2JoVTlsK2VCZ3B3RHRySm9Dc29iRmN1UXErVSsxTlZlZmFSbWhDNGdq?=
 =?utf-8?B?RWM5bUxlZnZmZFFuM3Blc3VsYWdsVE1aT3MwTjBEejQyOHBWN2ZZQitYdVZX?=
 =?utf-8?B?bHdQcy9kTjloUmFieDcxSjM2NXQrQjFWajdrK0VJQ0pHZ29IQWN4NGJad0lF?=
 =?utf-8?B?V2o4Z2JpNEEyOTd5dDFCV0FRNXpmSFBwc1UrVjY3ZXJNS3F0c3BtcWs0YWFI?=
 =?utf-8?B?WHVGWmk3NGxGeVUycWphZzFnZGluV3dMcy9QTWZENGdHNSt1TVlvUksxSEpC?=
 =?utf-8?B?TUZuVHJSR2RjMmFnRFpJMmhPWGxUSFNKZ1FiRmRJNXZTdlZjZXhFOUVzeEx5?=
 =?utf-8?B?OEVNTGZQb2x4UndMVWw3bEhmcnM0cTFsUzJqRGQyWGhkYnkrUDlqaDlEZUlj?=
 =?utf-8?B?amp6emRxa09aYkdNZnFYRk1Uc0x3TjQwMk5FRjBoSTRibGRqeVk0NDBRUEla?=
 =?utf-8?B?cjM3RjJpTC9PTUdnT1FnSUVrZ0JaY3NPUXN3eVJYaHlZUS9mSUZrdFlDalhU?=
 =?utf-8?B?TEhIVjZrOEFRYjhXQ1F2SXUwR1JkYythVFAvZThIQ0hleXdpUWlaZTU4TUto?=
 =?utf-8?B?R0pCYkdMcHdHUDZ4ZWJwZ0VYanZzSnNMZ1hPZi9kaGFGRzBybkcxTTNDdGds?=
 =?utf-8?B?UnpmWjI0aDNWczlHd0IzbXhSODZWSENTZWpDbzBjeS9OT21iZjJJdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eqpcFnQmUz22VFpkOqy8pNcXSVAFCrpuhfTYF7wuquUQlR5j5/dPrv8kqTgPGliYbBM7nn7hD83T/wjUNfoNcM+n99rcKDh7J+1dqKSatlBJxTONhrj+AVXaZpqmzK15Onu/b9Yrmt2bXtLgs9UywSh6MmHR65Bm8wJGuBAgWrD9Y/lgXi52QZwnl1dTfxzwSITmADPkuetGeAKgxw4A/TZ+quw9Dql36BHTY1Mk4W9+5BgiBFKPTPant6kLgdxNGjbA+6+6oa8OuWrkYs22IfAV8yun+96dxXDRdh4bR/6N44zPmGmcSz/x94XJhFZ7Sa/WLt3eQzV7Sl3WRbq1V3Q0OwX2ct6PBqg8uXaA4oZoyYg1PdK+u007j+NlWezl5kaJvpNVyIhYZUXMeAHaFq0y7i8v+mnmRV8rII+CS07GU+1wq9IZ6Z1tCa7+BOjjrS+dp8zeG9Fgpo6ACLfXV86z3F5bnHOx9jFQv3Nh2PQoBEwFpyOGg0i35GLRPPWPyPB3N6pRgB7cgpXkR1M43VvcayhEOLW4e4rSwKJL95daqr9RmqrwCZOznrah/pVXrQZQTLakvR1XKe1yN5KBnDLXKKoGGW9s4Y49BtU4SgA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d524cc-d707-4689-d90b-08de69c6a24a
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 23:38:18.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnUK4967XmwF6SIGtu9qwjG1Ns5pxa3BKWXphzaLvOL1VNAFJCRVCgqKGsv4wOCgaYtqn+M3MjhtmPLra3bGtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602110183
X-Proofpoint-GUID: _uyhAT0CziSiWfEbNdRJDlUopx5tzo0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE4MyBTYWx0ZWRfX0Z0BFMntlotP
 VjYUBz81zvKiJch7UegDVjTXprF40lIK+QwDsvXLrSIjzHnMZTEt3jcy6jXbRP6mL/gkxx0tZ/+
 kaqJpq+ysBlJPh56EIAxecrKkcuAthVgniaLq053AdgYwxuPAbeU/Egz3HlvWms27WcAWyhQiXH
 AAShCzAhNslAjRG0X3b0ujEq5IUaRBgVbIQVucYzFcwJd1DzBkyqjPc10L+cTJyZQw+ho2LJjeK
 BjiLo8tkmyukvzS9D41tgFOHDjhgiZ51nUc1JfxT70Kuhmjp1OnBkm2zi8n3+q62UXXnm47PRZ9
 mUQxXJ1lBpWPayVJxRSxf8MTW1p63QutlHF/msr28ovSNC9grP7cEe8bTdaXHMV9QZQUUkv9oK8
 rs2pOF+x1WZXxW+Pp6J0T11RfxeIBXCeLOhYDgBciOAvvUA8bUBZGMfz1mtz3nxbnLW9QvS7xS7
 D/iyaH4F/hbr80TdiMyaxe/Pk/jHXd+d8iJP1DEY=
X-Proofpoint-ORIG-GUID: _uyhAT0CziSiWfEbNdRJDlUopx5tzo0S
X-Authority-Analysis: v=2.4 cv=Y6f1cxeN c=1 sm=1 tr=0 ts=698d12f2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=qh5AmIxyxiCC-tmTLEMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76982-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 24C9312855F
X-Rspamd-Action: no action


On 2/10/26 12:17 PM, Chuck Lever wrote:
>
> On Tue, Feb 10, 2026, at 1:16 PM, Dai Ngo wrote:
>> When a layout conflict triggers a recall, enforcing a timeout is
>> necessary to prevent excessive nfsd threads from being blocked in
>> __break_lease ensuring the server continues servicing incoming
>> requests efficiently.
>>
>> This patch introduces a new function to lease_manager_operations:
>>
>> lm_breaker_timedout: Invoked when a lease recall times out and is
>> about to be disposed of. This function enables the lease manager
>> to inform the caller whether the file_lease should remain on the
>> flc_list or be disposed of.
>>
>> For the NFSD lease manager, this function now handles layout recall
>> timeouts. If the layout type supports fencing and the client has not
>> been fenced, a fence operation is triggered to prevent the client
>> from accessing the block device.
>>
>> While the fencing operation is in progress, the conflicting file_lease
>> remains on the flc_list until fencing is complete. This guarantees
>> that no other clients can access the file, and the client with
>> exclusive access is properly blocked before disposal.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |   2 +
>>   fs/locks.c                            |  16 +++-
>>   fs/nfsd/blocklayout.c                 |  41 +++++++--
>>   fs/nfsd/nfs4layouts.c                 | 126 +++++++++++++++++++++++++-
>>   fs/nfsd/nfs4state.c                   |   1 +
>>   fs/nfsd/pnfs.h                        |   2 +-
>>   fs/nfsd/state.h                       |   7 ++
>>   include/linux/filelock.h              |   1 +
>>   8 files changed, 182 insertions(+), 14 deletions(-)
>>
>> v2:
>>      . Update Subject line to include fencing operation.
>>      . Allow conflicting lease to remain on flc_list until fencing
>>        is complete.
>>      . Use system worker to perform fencing operation asynchronously.
>>      . Use nfs4_stid.sc_count to ensure layout stateid remains
>>        valid before starting the fencing operation, nfs4_stid.sc_count
>>        is released after fencing operation is complete.
>>      . Rework nfsd4_scsi_fence_client to:
>>           . wait until fencing to complete before exiting.
>>           . wait until fencing in progress to complete before
>>             checking the NFSD_MDS_PR_FENCED flag.
>>      . Remove lm_need_to_retry from lease_manager_operations.
>> v3:
>>      . correct locking requirement in locking.rst.
>>      . add max retry count to fencing operation.
>>      . add missing nfs4_put_stid in nfsd4_layout_fence_worker.
>>      . remove special-casing of FL_LAYOUT in lease_modify.
>>      . remove lease_want_dispose.
>>      . move lm_breaker_timedout call to time_out_leases.
>> v4:
>>      . only increment ls_fence_retry_cnt after successfully
>>        schedule new work in nfsd4_layout_lm_breaker_timedout.
>> v5:
>>      . take reference count on layout stateid before starting
>>        fence worker.
>>      . restore comments in nfsd4_scsi_fence_client and the
>>        code that check for specific errors.
>>      . cancel fence worker before freeing layout stateid.
>>      . increase fence retry from 5 to 20.
>>
>> NOTE:
>>      I experimented with having the fence worker handle lease
>>      disposal after fencing the client. However, this requires
>>      the lease code to export the lease_dispose_list function,
>>      and for the fence worker to acquire the flc_lock in order
>>      to perform the disposal. This approach adds unnecessary
>>      complexity and reduces code clarity, as it exposes internal
>>      lease code details to the nfsd worker, which should not
>>      be the case.
>>
>>      Instead, the lm_breaker_timedout operation should simply
>>      notify the lease code about how to handle a lease that
>>      times out during a lease break, rather than directly
>>      manipulating the lease list.
>> v6:
>>     . unlock the lease as soon as the fencing is done, so that
>>       tasks waiting on it can proceed.
>>
>> v7:
>>     . Change to retry fencing on error forever by default.
>>     . add module parameter option to allow the admim to specify
>>       the maximun number of retries before giving up.
>>
>> v8:
>>     . reinitialize 'remove' inside the loop.
>>     . remove knob to stop fence worker from retrying forever.
>>     . use exponential back off when retrying fence operation.
>>     . Fix nits.
>>
>> v9:
>>     . limit fence worker max delay to 3 minutes.
>>     . fix fence worker's delay argument from seconds to jiffies.
>>     . move INIT_DELAYED_WORK to nfsd4_alloc_layout_stateid().
>>     . remove ls_fence_inprogress, use delayed_work_pending() instead.
>>
>> v10:
>>     . fix initial delay of fence worker from 1 jiffies to 1 second.
>>
>> diff --git a/Documentation/filesystems/locking.rst
>> b/Documentation/filesystems/locking.rst
>> index 04c7691e50e0..79bee9ae8bc3 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -403,6 +403,7 @@ prototypes::
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>           bool (*lm_lock_expirable)(struct file_lock *);
>>           void (*lm_expire_lock)(void);
>> +        bool (*lm_breaker_timedout)(struct file_lease *);
>>
>>   locking rules:
>>
>> @@ -417,6 +418,7 @@ lm_breaker_owns_lease:	yes     	no			no
>>   lm_lock_expirable	yes		no			no
>>   lm_expire_lock		no		no			yes
>>   lm_open_conflict	yes		no			no
>> +lm_breaker_timedout     yes             no                      no
>>   ======================	=============	=================	=========
>>
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..9ec36c008edd 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1524,6 +1524,7 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   {
>>   	struct file_lock_context *ctx = inode->i_flctx;
>>   	struct file_lease *fl, *tmp;
>> +	bool remove;
>>
>>   	lockdep_assert_held(&ctx->flc_lock);
>>
>> @@ -1531,8 +1532,19 @@ static void time_out_leases(struct inode *inode,
>> struct list_head *dispose)
>>   		trace_time_out_leases(inode, fl);
>>   		if (past_time(fl->fl_downgrade_time))
>>   			lease_modify(fl, F_RDLCK, dispose);
>> -		if (past_time(fl->fl_break_time))
>> -			lease_modify(fl, F_UNLCK, dispose);
>> +
>> +		remove = true;
>> +		if (past_time(fl->fl_break_time)) {
>> +			/*
>> +			 * Consult the lease manager when a lease break times
>> +			 * out to determine whether the lease should be disposed
>> +			 * of.
>> +			 */
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)
>> +				remove = fl->fl_lmops->lm_breaker_timedout(fl);
>> +			if (remove)
>> +				lease_modify(fl, F_UNLCK, dispose);
>> +		}
>>   	}
>>   }
>>
>> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
>> index 7ba9e2dd0875..b7030c91964c 100644
>> --- a/fs/nfsd/blocklayout.c
>> +++ b/fs/nfsd/blocklayout.c
>> @@ -443,15 +443,33 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
>> struct svc_rqst *rqstp,
>>   	return nfsd4_block_commit_blocks(inode, lcp, iomaps, nr_iomaps);
>>   }
>>
>> -static void
>> +/*
>> + * Perform the fence operation to prevent the client from accessing the
>> + * block device. If a fence operation is already in progress, wait for
>> + * it to complete before checking the NFSD_MDS_PR_FENCED flag. Once the
>> + * operation is complete, check the flag. If NFSD_MDS_PR_FENCED is set,
>> + * update the layout stateid by setting the ls_fenced flag to indicate
>> + * that the client has been fenced.
>> + *
>> + * The cl_fence_mutex ensures that the fence operation has been fully
>> + * completed, rather than just in progress, when returning from this
>> + * function.
>> + *
>> + * Return true if client was fenced otherwise return false.
>> + */
>> +static bool
>>   nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   {
>>   	struct nfs4_client *clp = ls->ls_stid.sc_client;
>>   	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>>   	int status;
>> +	bool ret;
>>
>> -	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev))
>> -		return;
>> +	mutex_lock(&clp->cl_fence_mutex);
>> +	if (nfsd4_scsi_fence_set(clp, bdev->bd_dev)) {
>> +		mutex_unlock(&clp->cl_fence_mutex);
>> +		return true;
>> +	}
>>
>>   	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev,
>> NFSD_MDS_PR_KEY,
>>   			nfsd4_scsi_pr_key(clp),
>> @@ -470,13 +488,22 @@ nfsd4_scsi_fence_client(struct
>> nfs4_layout_stateid *ls, struct nfsd_file *file)
>>   	 * PR_STS_RESERVATION_CONFLICT, which would cause an infinite
>>   	 * retry loop.
>>   	 */
>> -	if (status < 0 ||
>> -	    status == PR_STS_PATH_FAILED ||
>> -	    status == PR_STS_PATH_FAST_FAILED ||
>> -	    status == PR_STS_RETRY_PATH_FAILURE)
>> +	switch (status) {
>> +	case 0:
>> +	case PR_STS_IOERR:
>> +	case PR_STS_RESERVATION_CONFLICT:
>> +		ret = true;
>> +		break;
>> +	default:
>> +		/* retry-able and other errors */
>> +		ret = false;
>>   		nfsd4_scsi_fence_clear(clp, bdev->bd_dev);
>> +		break;
>> +	}
>> +	mutex_unlock(&clp->cl_fence_mutex);
>>
>>   	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>> +	return ret;
>>   }
>>
>>   const struct nfsd4_layout_ops scsi_layout_ops = {
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..07904f404f89 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -27,6 +27,8 @@ static struct kmem_cache *nfs4_layout_stateid_cache;
>>   static const struct nfsd4_callback_ops nfsd4_cb_layout_ops;
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops;
>>
>> +static void nfsd4_layout_fence_worker(struct work_struct *work);
>> +
>>   const struct nfsd4_layout_ops *nfsd4_layout_ops[LAYOUT_TYPE_MAX] =  {
>>   #ifdef CONFIG_NFSD_FLEXFILELAYOUT
>>   	[LAYOUT_FLEX_FILES]	= &ff_layout_ops,
>> @@ -177,6 +179,13 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>>
>>   	trace_nfsd_layoutstate_free(&ls->ls_stid.sc_stateid);
>>
>> +	spin_lock(&ls->ls_lock);
>> +	if (delayed_work_pending(&ls->ls_fence_work)) {
>> +		spin_unlock(&ls->ls_lock);
>> +		cancel_delayed_work_sync(&ls->ls_fence_work);
>> +	} else
>> +		spin_unlock(&ls->ls_lock);
>> +
>>   	spin_lock(&clp->cl_lock);
>>   	list_del_init(&ls->ls_perclnt);
>>   	spin_unlock(&clp->cl_lock);
>> @@ -271,6 +280,10 @@ nfsd4_alloc_layout_stateid(struct
>> nfsd4_compound_state *cstate,
>>   	list_add(&ls->ls_perfile, &fp->fi_lo_states);
>>   	spin_unlock(&fp->fi_lock);
>>
>> +	ls->ls_fenced = false;
>> +	ls->ls_fence_delay = 0;
>> +	INIT_DELAYED_WORK(&ls->ls_fence_work, nfsd4_layout_fence_worker);
>> +
>>   	trace_nfsd_layoutstate_alloc(&ls->ls_stid.sc_stateid);
>>   	return ls;
>>   }
>> @@ -747,11 +760,9 @@ static bool
>>   nfsd4_layout_lm_break(struct file_lease *fl)
>>   {
>>   	/*
>> -	 * We don't want the locks code to timeout the lease for us;
>> -	 * we'll remove it ourself if a layout isn't returned
>> -	 * in time:
>> +	 * Enforce break lease timeout to prevent NFSD
>> +	 * thread from hanging in __break_lease.
>>   	 */
>> -	fl->fl_break_time = 0;
>>   	nfsd4_recall_file_layout(fl->c.flc_owner);
>>   	return false;
>>   }
> With fl->fl_break_time = 0 removed, the break time set by
> __break_lease() is preserved. After the timeout expires,
> time_out_leases() calls lm_breaker_timedout which returns
> false to keep the lease on the flc_list.
>
> __break_lease() then loops back to its restart label, where
> it recomputes the wait timeout:
>
>      break_time = fl->fl_break_time;
>      if (break_time != 0)
>          break_time -= jiffies;

Most likely __break_lease will recompute the wait timeout using
a file_lease for delegation which has fl_break_time of 0. This
is because if there is a layout for the file then most likely
there is also a delegation for that file. And the file_lease
delegation is inserted on the flc_list before the file_lease for
the layout.

However, it's possible that the delegation is no longer on the
flc_list for whatever reasons; client returned it, etc. So we
still need to handle the scenario you described below.

>
> fl_break_time is already in the past. So the subtraction
> wraps to a very large unsigned long value. Cast to the signed
> long expected by wait_event_interruptible_timeout(), the
> result is negative.
>
> schedule_timeout() treats negative values as a bug: it prints
> a KERN_ERR message with dump_stack() and returns immediately
> without sleeping. Inside the ___wait_event loop this produces
> a tight spin -- schedule_timeout() returns instantly on every
> iteration, the wait condition (lease removed from list) remains
> false until the fence worker completes, and each iteration
> emits a stack dump.
>
> The path is reachable via:
>
>      xfs_break_leased_layouts()
>        break_layout(inode, true)
>          __break_lease(inode, LEASE_BREAK_LAYOUT)
>
> On a uniprocessor system the fence worker workqueue thread
> never gets scheduled because the spinning task never calls
> schedule(), so the system hangs. On SMP the spin persists
> until the fence worker finishes the PR_PREEMPT operation and
> removes the lease via nfsd4_close_layout() ->
> kernel_setlease(F_UNLCK).
>
> When the fence fails and the worker retries with exponential
> backoff (up to MAX_FENCE_DELAY), the spin continues for the
> full delay interval.
>
> Would it make sense to have lm_breaker_timedout extend
> fl_break_time before returning false, so that __break_lease
> sleeps for a fresh interval rather than looping immediately
> with a stale timestamp?

I think this issue should be addressed by __break_lease since
we can have the same problem with timed out delegation:

  restart:
         fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
         break_time = fl->fl_break_time;
-       if (break_time != 0)
-               break_time -= jiffies;
+       if (break_time != 0) {
+               if (break_time < jiffies)
+                       break_time = jiffies + lease_break_time * HZ;
+               else
+                       break_time -= jiffies;
+       }
         if (break_time == 0)
                 break_time++;

>
>
>> @@ -782,10 +793,117 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	struct nfsd_file *nf;
>> +	struct block_device *bdev;
>> +	LIST_HEAD(dispose);
> Nit: "dispose" is no longer used and can be deleted.

Fix in v11.

>
>
>> +
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +dispose:
>> +		/* unlock the lease so that tasks waiting on it can proceed */
>> +		nfsd4_close_layout(ls);
>> +
>> +		ls->ls_fenced = true;
>> +		nfs4_put_stid(&ls->ls_stid);
>> +		return;
>> +	}
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		goto dispose;
>> +
>> +	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
>> +		/* fenced ok */
>> +		nfsd_file_put(nf);
>> +		goto dispose;
>> +	}
>> +	/* fence failed */
>> +	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
>> +	nfsd_file_put(nf);
>> +
>> +	pr_warn("%s: FENCE failed client[%pISpc] device[0x%x]\n",
>> +		__func__, (struct sockaddr *)&ls->ls_stid.sc_client->cl_addr,
>> +		bdev->bd_dev);
>> +	/*
>> +	 * The fence worker retries the fencing operation indefinitely to
>> +	 * prevent data corruption. The admin needs to take the following
>> +	 * actions to restore access to the file for other clients:
>> +	 *
>> +	 *  . shutdown or power off the client being fenced.
>> +	 *  . manually expire the client to release all its state on the server;
>> +	 *    echo 'expire' > proc/fs/nfsd/clients/clientid/ctl'.
>> +	 */
>> +	ls->ls_fence_delay <<= 1;
>> +	if (!ls->ls_fence_delay)
>> +		ls->ls_fence_delay = (1 *HZ);
>> +	else if (ls->ls_fence_delay > MAX_FENCE_DELAY)
>> +		ls->ls_fence_delay = MAX_FENCE_DELAY;
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_delay);
> Let's make this:
>
> -  ls->ls_fence_delay <<= 1;
>     if (!ls->ls_fence_delay)
> -    ls->ls_fence_delay = (1 *HZ);
> -  else if (ls->ls_fence_delay > MAX_FENCE_DELAY)
> -    ls->ls_fence_delay = MAX_FENCE_DELAY;
> +    ls->ls_fence_delay = HZ;
> +  else if (ls->ls_fence_delay < MAX_FENCE_DELAY)
> +    ls->ls_fence_delay <<= 1;
>     mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_delay);

Fix in v11.

>
>
>> +}
>> +
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + * @fl: file to check
>> + *
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * This function runs under the protection of the spin_lock flc_lock.
>> + * At this time, the file_lease associated with the layout stateid is
>> + * on the flc_list. A reference count is incremented on the layout
>> + * stateid to prevent it from being freed while the fence worker is
>> + * executing. Once the fence worker finishes its operation, it releases
>> + * this reference.
>> + *
>> + * The fence worker continues to run until either the client has been
>> + * fenced or the layout becomes invalid. The layout can become invalid
>> + * as a result of a LAYOUTRETURN or when the CB_LAYOUT recall callback
>> + * has completed.
>> + *
>> + * Return true if the file_lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +
>> +	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
>> +			ls->ls_fenced)
>> +		return true;
>> +	if (delayed_work_pending(&ls->ls_fence_work))
>> +		return false;
>> +	/*
>> +	 * Make sure layout has not been returned yet before
>> +	 * taking a reference count on the layout stateid.
>> +	 */
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +		return true;
>> +	}
>> +	refcount_inc(&ls->ls_stid.sc_count);
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>
>>   int
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 98da72fc6067..bad91d1bfef3 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -2387,6 +2387,7 @@ static struct nfs4_client *alloc_client(struct
>> xdr_netobj name,
>>   #endif
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	xa_init(&clp->cl_dev_fences);
>> +	mutex_init(&clp->cl_fence_mutex);
>>   #endif
>>   	INIT_LIST_HEAD(&clp->async_copies);
>>   	spin_lock_init(&clp->async_lock);
>> diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
>> index db9af780438b..3a2f9e240e85 100644
>> --- a/fs/nfsd/pnfs.h
>> +++ b/fs/nfsd/pnfs.h
>> @@ -38,7 +38,7 @@ struct nfsd4_layout_ops {
>>   			struct svc_rqst *rqstp,
>>   			struct nfsd4_layoutcommit *lcp);
>>
>> -	void (*fence_client)(struct nfs4_layout_stateid *ls,
>> +	bool (*fence_client)(struct nfs4_layout_stateid *ls,
>>   			     struct nfsd_file *file);
>>   };
>>
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index 713f55ef6554..7ffb077f6fbf 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -529,6 +529,7 @@ struct nfs4_client {
>>   	time64_t		cl_ra_time;
>>   #ifdef CONFIG_NFSD_SCSILAYOUT
>>   	struct xarray		cl_dev_fences;
>> +	struct mutex		cl_fence_mutex;
>>   #endif
>>   };
>>
>> @@ -738,8 +739,14 @@ struct nfs4_layout_stateid {
>>   	stateid_t			ls_recall_sid;
>>   	bool				ls_recalled;
>>   	struct mutex			ls_mutex;
>> +
>> +	struct delayed_work		ls_fence_work;
>> +	unsigned int			ls_fence_delay;
>> +	bool				ls_fenced;
>>   };
>>
> Add:
>
> /* Cap exponential backoff between fence retries at 3 minutes */

Fix in v11.

-Dai

>
>> +#define	MAX_FENCE_DELAY		(180 * HZ)
>> +
>>   static inline struct nfs4_layout_stateid *layoutstateid(struct nfs4_stid *s)
>>   {
>>   	return container_of(s, struct nfs4_layout_stateid, ls_stid);
>> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
>> index 2f5e5588ee07..13b9c9f04589 100644
>> --- a/include/linux/filelock.h
>> +++ b/include/linux/filelock.h
>> @@ -50,6 +50,7 @@ struct lease_manager_operations {
>>   	void (*lm_setup)(struct file_lease *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lease *);
>>   	int (*lm_open_conflict)(struct file *, int);
>> +	bool (*lm_breaker_timedout)(struct file_lease *fl);
>>   };
>>
>>   struct lock_manager {
>> -- 
>> 2.47.3

