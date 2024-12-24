Return-Path: <linux-fsdevel+bounces-38099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E929FBED9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 14:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBE7163119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F71AF0C3;
	Tue, 24 Dec 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cH+AiIuv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dGktZoOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A6CA6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735048371; cv=fail; b=T6JljOfD6WR6FGBKb15XwzGx5s+GcPrX850ZTHz+RhLtHDc5AGwHoZB2K3SyI97gm3XeFaG93EcZQV+ag9HdKghepmH+/EPjskAz5DxUmwgU7y+P35oh8d4N34mzpUvGeeDqvk1gII5TkW19PmdF5gEiNIEopl87XG5DvhmLFYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735048371; c=relaxed/simple;
	bh=gLtSlPviJC+8r4CVqueZqlflTHYGZ54VTKwlMM6e4Gc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALxsqJuYAbXBhrz7TSiiwm7DBL1EY3/QQ4J30fThFxe0jKm/M7YDtOOv0cBa62FxA9p9Woyi3qkx3IysPh4cwvnhbyeCFOh6Oj2YGL/ryaJBSTsmc+BUu950zIAgao0/QznCrKXrLoE/+DBnBhwPJWTBD5AmoT5j7bwol2g8MzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cH+AiIuv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dGktZoOT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOCBTRw002610;
	Tue, 24 Dec 2024 13:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=H/0G51L5WkYZWjDWGylkeRJzwhzL5Oun+HWLUhb+lrQ=; b=
	cH+AiIuvoAnA8HFdEoe+yy0jNDSyVPhcsPyTjFwxfdWsTDkPdrjSnezTg0ACxsQH
	/dyTQJ6xrb29dpGrZmqO/lyfPBihP5lmKwaMEZkS8JHfi7QXSqLQEy5DnW6aQSY9
	LeklevfojRW3qqaEy5HDbDnO0CXxru98pXC/sLmQqL7Yqw96ywlbvEVcRCKSL3cQ
	5bSCtIITwpY/LLUpn78FbXqDjgVvGo2lLgEONsglWH1HOWdjWjkj7s5UtcsbyKrH
	TRY4He+3RC5XPIYXRzai7GZGnK52axWIF4GcO6P+wohkp4hG+Di+W5lA5s1PRU/e
	vEfiHoTDkO210CrZKnJVGQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43qgeqrvwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 13:52:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BODFgqr000984;
	Tue, 24 Dec 2024 13:52:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43pk8tv07v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 13:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgmcI2nKISZmSM0hz+fwpnREzctjgmpCwqKCvXPeVVKRiQMOWAJew+4ERkVX60Ue1q8/ggOdMA70xsOLhBIlCbp5YRrj2BF7u0KxjFVyE3STib+cfkYxjmh5k85zVZNWgQkcfGUuPdNFzpiY3yRC6tZUZxlzzRh7nru0ET8EhTm6jXkDAb6yiYHp03TLUJmuOrCAjC02hfSDyEPEudNWGMyIL4tipPp+0E/6UOa6wi634FvKJeeSDkv6gd3x5nOVUYxiU7NeRWDaeedZ/8xcthhwYIca6eYynFRel4uoc2pU5dwfXqwow1aGrOHbOy5O3rSzZbz1dgxhJtBgDMzzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/0G51L5WkYZWjDWGylkeRJzwhzL5Oun+HWLUhb+lrQ=;
 b=tXwFn620dIW1PIRRdZqLiaS7dErwGIuJBUmb6A0r6LTORyyyTCo/W4Vj+1pKM468inCNnGTfgiJA3vE8vvWY4Rp1GbAuHf397QOFOBMey7+bDbFsmmBKaVMSbDefv3kjcxzhZzRRnDXnTjdu1AyTHz+Wpr/n95rJnus7ZDS2Bp/T/HYKB0qN591sy3rVPHliSoKQGxhQRmsTNoquh7VLmQe2AR1Nfg7qgagjrUML3gKVsPY4oo57CZQtIoz72B/abIizgKzE/9dxAfWx3bdNd07UIEE1DmVWZTYItJzGTmYqiSdwfQR+0g6eRx2UvcDOp1PriluV32PHrx5C6Ax98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/0G51L5WkYZWjDWGylkeRJzwhzL5Oun+HWLUhb+lrQ=;
 b=dGktZoOTg/uXWXfDrmnds/bP5INTuF99CnD6+TiJDuyoeb8YIPC706bInb9Orfm/HuZXX17D6Dy34eED4z7diSxXCpbYMb/kEqGsee2TZsPjSmFicIl+w1EOy8m+Gx08ELK78vnn0bV+3yJDcXlV3qWa28LnIUnGXi2VjpBqlEw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6246.namprd10.prod.outlook.com (2603:10b6:8:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 13:52:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 13:52:07 +0000
Message-ID: <71bbbf23-361b-4461-9739-ede4f120c982@oracle.com>
Date: Tue, 24 Dec 2024 08:52:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] libfs: Use d_children list to iterate
 simple_offset directories
To: yangerkun <yangerkun@huaweicloud.com>, cel@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com
References: <20241220153314.5237-1-cel@kernel.org>
 <20241220153314.5237-6-cel@kernel.org>
 <3ccf8255-dfbb-d019-d156-01edf5242c49@huaweicloud.com>
 <fcae58c8-edcf-4a42-a23b-4747ccbf758c@oracle.com>
 <3976ba47-76c7-28e1-9f20-6e94e0adbbea@huaweicloud.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <3976ba47-76c7-28e1-9f20-6e94e0adbbea@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef820ff-e1fd-464a-db13-08dd242227f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2RVOUx5WUpUbnpEVzJEbFh3RytqcklGQytmV1UvQ1I2OEUzYlJhZjAwdEVp?=
 =?utf-8?B?MlhpZUd4OWlWeDVaNzdKYXJlbmMveUxrdkdpZFFBK1hOVnIyZ0I1c20wSWUy?=
 =?utf-8?B?dGY0ZTJBMjlLVEZya3A4V096ejhDVVE2b2N1eERncUg2eDcrMzFaY0wzbTZO?=
 =?utf-8?B?V3hoQVVvTm5qQkxlWkhGY3R6L09EYnl2ZVFiWHZ2WnFNeHNmb29OR1RLVURG?=
 =?utf-8?B?UmM5b2JQZ0d3c0locHgraUpMS25rd1NMTkl6YVBxTEFIdTZhTHhLSG44eU1X?=
 =?utf-8?B?T0ZoN1lCdE5JRnJzVjEvNVRVVllHN2trZWl1ZksyM050Qi96dFkzUnc4amY2?=
 =?utf-8?B?SFNhM29GaU5XcTFUK1VHY09BVTRXcTl5VmgvbXBScUljQzJFaXlNY0dHRHA5?=
 =?utf-8?B?alFHSU55TFRJeEc1dStSZkZ0ZTUxbWZyb1prK1pYUEd5VHJJMDFsV2UyOTJ6?=
 =?utf-8?B?Ni96YVp2cTQxMFZ0VWlIRjZIazFUdFQrNE4wL2xwZFhFdTNaZm4xL1JSZXVt?=
 =?utf-8?B?bEQvL3VJVlJBOG50aU4xSmdxR0Fmem01Qjdyd1ZmbW9GUUNsUFUrUDFqaDNW?=
 =?utf-8?B?RzFyUlBzR2VwZTE1b1FUNjBZWkRDZ2g1NG1GTzRCdHZ6OUg2Wi9lTXlybHpn?=
 =?utf-8?B?UGoxVUpRNDdKWXV3eTB5b2FDSTJXa3dZYjNQUkN2TXNCMUJwMFpUa3hsbExM?=
 =?utf-8?B?MmNmVTI2Szl3UkJjbWRkS2p2SlRnVTJVMHNVSjlZUW9kcmh6aVl3QnRIVDBq?=
 =?utf-8?B?ZFp4VFNMQmozYzM5aVBiTUNVNG1RWGMvZXl4RHNxbnFWQkoyTzg0Qm03N1ZD?=
 =?utf-8?B?Ui9CZFdERkduQkQvTzFFekcxbVlIL1F3NDhmR0lubFlWMUlhM25pWldXM1Iy?=
 =?utf-8?B?YzA1V2toaTBFWGtHZTkvaHB0VUtvaW56eGdVNGRrOHd2UzlXenpGYUlDQWVI?=
 =?utf-8?B?VFhzS0grdnA4aEZpNmc4MGYyamYrSDVEMUJPcnd0SUVOWUVqZ0lLMCtzWnpI?=
 =?utf-8?B?Mnd6T0x6ckRoOEZmblhTelg4aldXdFRSSWptdW1tdEJJYTlZajZFUFY4ZVkz?=
 =?utf-8?B?TGFMQkFYenJUN2g0WDBOVndHSHlPZlhmWTRPUXhPVm1WdU83OGJVa3h5bGJ5?=
 =?utf-8?B?M2p4aDBURWd3SnRJNk1BOHBPdFcwTzV0ajd3U3V0ZnNLbHA0cDRBSFg4ZFJJ?=
 =?utf-8?B?K0p1QW1xMENHMkdOUFdaaFBJOSsrZEUyTHVzd25sZHhPRUsrSUsvRGJkSzIx?=
 =?utf-8?B?aXNBdHlvckw1b2ppNG91WmwvYXhxbXlPNVZnbkFUWDhLUGo4N1JLd1h3UFRV?=
 =?utf-8?B?QU02WmZ1dGVzZzNHZUFEUkpLYVlzQUNGSzYxMkpoU20wRW1FY3pVMGtHdWhK?=
 =?utf-8?B?NExFdmZwNmt3bkV0MkRIN1JLM0l3VllrSm5NakVHQndEWjVDQXJpT09qUzNO?=
 =?utf-8?B?N091UEtFUlRIT3dwWkRBejFucmZ4a01mYk9OSzZVdFFnTU5rbHhLRnRNZU05?=
 =?utf-8?B?L21rN2FLZzVvQVp5dXZlQUV5OVRDOVRYWTVFRTNBZVlKbk9vRGczZ29Zb1Q1?=
 =?utf-8?B?TUNNNjREK0krd0I5bzVkdEltdmFwS1doKzdkOS95UDA3NXVJRFZVUTdwM21M?=
 =?utf-8?B?cmY4cy9hL2dMUjFUMmNCSzZOWWpKeTNhSytPTit3dmhreDdSWWdVUWhQUHha?=
 =?utf-8?B?TXNPUlNvR0VZek5NSE9CMjNQWHE1b1BBWTIrTnRIK3JmNks1MXdmZG45Zjdj?=
 =?utf-8?B?S21kM1dWdXZxbm5KWTk4eFNqdndqb1NTNndKL2FMTHcyaUROckZLeXU5VWI3?=
 =?utf-8?B?NEZJQVVJTXM4eUNoRTRxMys3ejZDNXFMcERmdDQ2V1EzUlJ3Tm9GS0x2VTQw?=
 =?utf-8?Q?8rby4RNlDzUmf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDExWk5KL1lQL1R2RlVjSUNYQlVqN25xblI0NzRheXA3M2RyaXdWRSt2Q0JH?=
 =?utf-8?B?TUpKZVluckwyUVJza3JGc2ZwU2ZvbEUraVVrcjNpWTI0bnJ2WWhEUjNkeXFM?=
 =?utf-8?B?TmpJVStOSjBGMEtpSlIzc3pQWTJOcSt2QUZ4bysxKysvM0tjN09mRTZMbDNv?=
 =?utf-8?B?NS94MWsvUVd1dW9jREhUblM5QmJmV20ydXV4LzRrOUFCdFBESU5IQjVXdEsz?=
 =?utf-8?B?OXFmZXdyTzNsaTZ1ZUFaQzBFUlpZRHdMWnNxZXo0aFFVb2ZldzNLL1c1MDB1?=
 =?utf-8?B?aXBPcnNpdHJQTm8xenpSSEVIdzM3NUZYWTVFQ1RLc2IxMXQ0U0MwRFVRbFE4?=
 =?utf-8?B?Ykd3UmF1dTlyeWVrSWpwUDB3MG1ZUHJoRlRWREptamllNEw1MVZqWTc5dnhq?=
 =?utf-8?B?a1BFT0Z1KzFZWXRka2tSbHNVR1hoVUthQ2g4R0NUOWRoOEJoOERWTnVqZk8w?=
 =?utf-8?B?ZUtDZStmZUtkcjZWcDR4TVZMZkFmUDNmTlQwYmN6UmhQVkZYbU14SVVvWVVu?=
 =?utf-8?B?QXlUQ0I0TWc4c2FKYmwxTjZVWTIxaTRnQS90UFN5NTZnWXVhaXpxWUNIam1v?=
 =?utf-8?B?Z1NWdWxyQTI2eTZENUdDMEJ0ckJPOHgxcVBKbEloVmNNT2tDSFBpcXEvek52?=
 =?utf-8?B?aXNRRTlYS3QxYnYrckFlY3Zua3l3OWUzNjZxS2JGQitRa0hNK0hTSkpDTk0z?=
 =?utf-8?B?VGtUaW1qT3ViMjVpWmx1aUwzaDFMQ3hXRzhaRldVUG8zS2Jtc2g3SElFdE9Q?=
 =?utf-8?B?RmZxL3N0Wjcvb0pDVzFWb1FVZyt0NGl6Y1Y0V3ZGLzRsb0JiTHhBcEVhTGg0?=
 =?utf-8?B?ODlGeFN4MTNYaGQvNy9ZUjBQN21zeVFGUTFqbFdWK0lDNHAvRnJlRlVWSjZF?=
 =?utf-8?B?eko3V1V2R0VqdnpIVnlTVFo2UllCQUNNTjNZRnc4RUlwc3g3czVpZVVYV01D?=
 =?utf-8?B?d051a3FkaC9EYllxUjNkYm80MGhXNXRPWFg4NUVsNkQ0cVJ1czA0MXZmYlRu?=
 =?utf-8?B?cnJwWDY2eXU1UmtTTjlOUHI3eFJ5eUdwK2lZUVBJZWEvbHpid1NqbnVWSzRa?=
 =?utf-8?B?c2Y3TzJaNjlaOWx6aDlqV0xOSEF0RnhRcEJnc0ZkRHQ4VVlQaWdNN0FlRUxZ?=
 =?utf-8?B?ZGtOQy9XYW5oclMrZGl0WEpXdkU0QXNoTTdLM2RmK1BtNjdsdVVlVy8wNEU2?=
 =?utf-8?B?dTJIY0RlanZmVWNSYm9jYVFkQm1uTDVjNHlRaks1a1J1b1U5dHhNMFZPT2Ur?=
 =?utf-8?B?Z3JBeHkwV0JEWWxiM2JQcGlpaWR0VVZTVkQ3QTdRNUF3RHVmYWl0NkZXOFRy?=
 =?utf-8?B?ejZEVnYxY2p6Sks4cHpZVHdDd0VHUGVUSStGcTcrVHZmUllYWnNtcW1JV2Fy?=
 =?utf-8?B?RDRGdVEzNUZ1dXhMenYvaHlmTUxyYm9sKzdiVDJBMmF6N1lSb0wyNy9MSzdI?=
 =?utf-8?B?RnBPamhtdHlFWkdaRFVFUXB3cTZOU1M0UnRNZ0ZhOFBMcmlYdDlFaFJDcUxV?=
 =?utf-8?B?RzIvajAxTDBpQXZNbUtIUnRRVWtXMW1HRi9SMnhPcjgvVlZkZm54ZDZNK1U3?=
 =?utf-8?B?NUxrcWl4R3pDcWtQeDlnNTNCQ3V0bzhtWm83dXA5anVyYmVSN1c4K3orQnRE?=
 =?utf-8?B?bzF1WnFKdWdYUGdtSml6OHV2aWU2Z1JtUUw2cGxrVzVzblkvTUpDSzVKM05Q?=
 =?utf-8?B?Y1RNN2cvei9XRE9Ham9QL2VXdFlSK3pyWXJLcHdlVVU2RHBlZXdqbkd3THh1?=
 =?utf-8?B?dHhwSVgvOEdTRUZqbXVjSkRlQ2h6VkZQY3IyQVM0RUxibW92b0JrNm8rZ0lW?=
 =?utf-8?B?eDZkcmErUlZSL0tpM1JpTG5taTRMQ0RWZ2VZNk9TNXNnZ2dYU0ZObGJjTEF4?=
 =?utf-8?B?bkRPa0Z4bkhhaG8zTFhWaThuY2M4KzZDcVJyamZUendHSktVVGVjdXhyN2Ro?=
 =?utf-8?B?NWQ3TmVQQXRTNjNHbGJPUHB6dUpEb0xycVBYekFiZHdyN1ZDNHd0MWRVS280?=
 =?utf-8?B?OUJYb3BxellVaE5oVlBReEtjaDlocGlUeWx2Yy9TOG9ER3VyRmRYWHJ0cWJM?=
 =?utf-8?B?TktrRGF1Y3hTS25mMUZCWWFvQTFOOGwzelVPTGZYcVcrMVZQa01pUVdWNnhy?=
 =?utf-8?Q?MJny2VHiGfMsn7RaaPOy27rKE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WeBylccZT5qtNzwwe8ojcwbNfXBXvbkPhDQiyFxPUU7hy5BuFjn4X/6B3bEDVDgoSvNeNRTBxIo/mR696/nXotXQMLGNzBJYZRLpKN3k3Kalxn/xU3LcaXgb3s4VVyfOXyAEeoJ0A4dPAdmURyLavzatStTUbr9a3kMTCZGQ/lqxLOxC7w+xvdO1Ffq6EEOBoP1J/x3MwOXVvfAtnlHgThn6wXgbWwSuxe0OP2P4IvElrgc8NfUq1n0kkC9MkGJx/smA/le620L6GeD6zKJM+JbeN21udEuFToDYlpoU4gDjZZfWgBuF24nrJzHbv4pueJ7NpV5RR9XAsiE76uzB8krK80o3LQ5ONZq5BKJw9LOie8Jclld2l32RY3x4SiBy1icUHui3ytvYpiLKaLYAx0UcOLD/XItguzfF8jA94YhiIwVBHBtmvvUGwXaV2erKzEAgrsoKd+uHzTbPo+vl8vIHr5X0jHIKjlhTMkcL0YzLHvpqkdYygN9Xv0pFcmQc5S/qsRoK9SyS2FzYaZBck9/fyqR42X9KSdIBAm1vEcvNpUCnPajY6JCPO2L9h6vJNr8VMbpkSxNpYvHQFj/sBOkdzBQxFEtUJHSin3G9heE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef820ff-e1fd-464a-db13-08dd242227f5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 13:52:07.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InfOjCZjpvjdQ60nspWTQ/sGUGfMXihY837P1Nq+mpzeSjC4bdiFLNQXezvtukrgfaTaLm15pnNEph5U2aRGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412240119
X-Proofpoint-ORIG-GUID: upAjlvXj6Q5eVCflOxGvsQx-xTb16IxN
X-Proofpoint-GUID: upAjlvXj6Q5eVCflOxGvsQx-xTb16IxN

On 12/23/24 11:40 PM, yangerkun wrote:
> 
> 
> 在 2024/12/23 22:44, Chuck Lever 写道:
>> On 12/23/24 9:21 AM, yangerkun wrote:
>>>
>>>
>>> 在 2024/12/20 23:33, cel@kernel.org 写道:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> The mtree mechanism has been effective at creating directory offsets
>>>> that are stable over multiple opendir instances. However, it has not
>>>> been able to handle the subtleties of renames that are concurrent
>>>> with readdir.
>>>>
>>>> Instead of using the mtree to emit entries in the order of their
>>>> offset values, use it only to map incoming ctx->pos to a starting
>>>> entry. Then use the directory's d_children list, which is already
>>>> maintained properly by the dcache, to find the next child to emit.
>>>>
>>>> One of the sneaky things about this is that when the mtree-allocated
>>>> offset value wraps (which is very rare), looking up ctx->pos++ is
>>>> not going to find the next entry; it will return NULL. Instead, by
>>>> following the d_children list, the offset values can appear in any
>>>> order but all of the entries in the directory will be visited
>>>> eventually.
>>>>
>>>> Note also that the readdir() is guaranteed to reach the tail of this
>>>> list. Entries are added only at the head of d_children, and readdir
>>>> walks from its current position in that list towards its tail.
>>>>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>   fs/libfs.c | 84 ++++++++++++++++++++++++++++++++++++ 
>>>> +-----------------
>>>>   1 file changed, 58 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/fs/libfs.c b/fs/libfs.c
>>>> index 5c56783c03a5..f7ead02062ad 100644
>>>> --- a/fs/libfs.c
>>>> +++ b/fs/libfs.c
>>>> @@ -247,12 +247,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
>>>>   /* simple_offset_add() allocation range */
>>>>   enum {
>>>> -    DIR_OFFSET_MIN        = 2,
>>>> +    DIR_OFFSET_MIN        = 3,
>>>>       DIR_OFFSET_MAX        = LONG_MAX - 1,
>>>>   };
>>>>   /* simple_offset_add() never assigns these to a dentry */
>>>>   enum {
>>>> +    DIR_OFFSET_FIRST    = 2,        /* Find first real entry */
>>>>       DIR_OFFSET_EOD        = LONG_MAX,    /* Marks EOD */
>>>>   };
>>>> @@ -458,51 +459,82 @@ static loff_t offset_dir_llseek(struct file 
>>>> *file, loff_t offset, int whence)
>>>>       return vfs_setpos(file, offset, LONG_MAX);
>>>>   }
>>>> -static struct dentry *offset_find_next(struct offset_ctx *octx, 
>>>> loff_t offset)
>>>> +static struct dentry *find_positive_dentry(struct dentry *parent,
>>>> +                       struct dentry *dentry,
>>>> +                       bool next)
>>>>   {
>>>> -    MA_STATE(mas, &octx->mt, offset, offset);
>>>> +    struct dentry *found = NULL;
>>>> +
>>>> +    spin_lock(&parent->d_lock);
>>>> +    if (next)
>>>> +        dentry = d_next_sibling(dentry);
>>>> +    else if (!dentry)
>>>> +        dentry = d_first_child(parent);
>>>> +    hlist_for_each_entry_from(dentry, d_sib) {
>>>> +        if (!simple_positive(dentry))
>>>> +            continue;
>>>> +        spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>>>> +        if (simple_positive(dentry))
>>>> +            found = dget_dlock(dentry);
>>>> +        spin_unlock(&dentry->d_lock);
>>>> +        if (likely(found))
>>>> +            break;
>>>> +    }
>>>> +    spin_unlock(&parent->d_lock);
>>>> +    return found;
>>>> +}
>>>> +
>>>> +static noinline_for_stack struct dentry *
>>>> +offset_dir_lookup(struct dentry *parent, loff_t offset)
>>>> +{
>>>> +    struct inode *inode = d_inode(parent);
>>>> +    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>>>       struct dentry *child, *found = NULL;
>>>> -    rcu_read_lock();
>>>> -    child = mas_find(&mas, DIR_OFFSET_MAX);
>>>> -    if (!child)
>>>> -        goto out;
>>>> -    spin_lock(&child->d_lock);
>>>> -    if (simple_positive(child))
>>>> -        found = dget_dlock(child);
>>>> -    spin_unlock(&child->d_lock);
>>>> -out:
>>>> -    rcu_read_unlock();
>>>> +    MA_STATE(mas, &octx->mt, offset, offset);
>>>> +
>>>> +    if (offset == DIR_OFFSET_FIRST)
>>>> +        found = find_positive_dentry(parent, NULL, false);
>>>> +    else {
>>>> +        rcu_read_lock();
>>>> +        child = mas_find(&mas, DIR_OFFSET_MAX);
>>>
>>> Can this child be NULL?
>>
>> Yes, this mas_find() call can return NULL. find_positive_dentry() should
>> then return NULL. Kind of subtle.
>>
>>
>>> Like we delete some file after first readdir, maybe we should break 
>>> here, or we may rescan all dentry and return them to userspace again?
>>
>> You mean to deal with the case where the "next" entry has an offset
>> that is lower than @offset? mas_find() will return the entry in the
>> tree that is "at or after" mas->index.
>>
>> I'm not sure either "break" or returning repeats is safe. But, now that
>> you point it out, this function probably does need additional logic to
>> deal with the offset wrap case.
>>
>> But since this logic already exists here, IMO it is reasonable to leave
>> that to be addressed by a subsequent patch. So far there aren't any
>> regression test failures that warn of a user-visible problem the way it
>> is now.
> 
> Sorry for the confusing, the case I am talking is something like below:
> 
> mkdir /tmp/dir && cd /tmp/dir
> touch file1 # offset is 3
> touch file2 # offset is 4
> touch file3 # offset is 5
> touch file4 # offset is 6
> touch file5 # offset is 7
> first readdir and get file5 file4 file3 file2 #ctx->pos is 3, which
> means we will get file1 for second readdir
> 
> unlink file1 # can not get entry for ctx->pos == 3
> 
> second readdir # offset_dir_lookup will use mas_find but return NULL,
> and we will get file5 file4 file3 file2 again?

After this patch, directory entries are reported in descending
cookie order. Therefore, should this patch replace the mas_find() call
with mas_find_rev() ?


> And for the offset wrap case, I prefer it's safe with your patch if we 
> won't unlink file between two readdir. The second readdir will use an
> active ctx->pos which means there is a active dentry attach to this
> ctx->pos. find_positive_dentry will stop once we meet the last child.
> 
> 
> I am not sure if I understand correctly, if not, please point out!
> 
> Thanks!
> 
>>
>>
>>>> +        found = find_positive_dentry(parent, child, false);
>>>> +        rcu_read_unlock();
>>>> +    }
>>>>       return found;
>>>>   }
>>>>   static bool offset_dir_emit(struct dir_context *ctx, struct dentry 
>>>> *dentry)
>>>>   {
>>>>       struct inode *inode = d_inode(dentry);
>>>> -    long offset = dentry2offset(dentry);
>>>> -    return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, 
>>>> offset,
>>>> -              inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>>> +    return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
>>>> +            inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>>>   }
>>>> -static void offset_iterate_dir(struct inode *inode, struct 
>>>> dir_context *ctx)
>>>> +static void offset_iterate_dir(struct file *file, struct 
>>>> dir_context *ctx)
>>>>   {
>>>> -    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>>> +    struct dentry *dir = file->f_path.dentry;
>>>>       struct dentry *dentry;
>>>> +    dentry = offset_dir_lookup(dir, ctx->pos);
>>>> +    if (!dentry)
>>>> +        goto out_eod;
>>>>       while (true) {
>>>> -        dentry = offset_find_next(octx, ctx->pos);
>>>> -        if (!dentry)
>>>> -            goto out_eod;
>>>> +        struct dentry *next;
>>>> -        if (!offset_dir_emit(ctx, dentry)) {
>>>> -            dput(dentry);
>>>> +        ctx->pos = dentry2offset(dentry);
>>>> +        if (!offset_dir_emit(ctx, dentry))
>>>>               break;
>>>> -        }
>>>> -        ctx->pos = dentry2offset(dentry) + 1;
>>>> +        next = find_positive_dentry(dir, dentry, true);
>>>>           dput(dentry);
>>>> +
>>>> +        if (!next)
>>>> +            goto out_eod;
>>>> +        dentry = next;
>>>>       }
>>>> +    dput(dentry);
>>>>       return;
>>>>   out_eod:
>>>> @@ -541,7 +573,7 @@ static int offset_readdir(struct file *file, 
>>>> struct dir_context *ctx)
>>>>       if (!dir_emit_dots(file, ctx))
>>>>           return 0;
>>>>       if (ctx->pos != DIR_OFFSET_EOD)
>>>> -        offset_iterate_dir(d_inode(dir), ctx);
>>>> +        offset_iterate_dir(file, ctx);
>>>>       return 0;
>>>>   }
>>>
>>
>>
> 


-- 
Chuck Lever

