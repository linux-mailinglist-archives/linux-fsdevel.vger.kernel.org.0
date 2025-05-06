Return-Path: <linux-fsdevel+bounces-48280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA48FAACCFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 20:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD4D1C40F63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FC286437;
	Tue,  6 May 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJgr/3k2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WE+G1aN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95720B806;
	Tue,  6 May 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555410; cv=fail; b=qFTd1yYtqitoISR+vbaNNH+SWjVUe07r/8eICk8cyoQgkrB/4W3Q+COvJMaVA2aYKqp6x/DOcsEuzgMedM9Gc44oqTIKXQiJk+fd9ypcR3XUvHI6vXa1eUJBT+KNANzbXvRQLJYVMEbE51yj/jJpQR1LO8FdrJ74k2IAdn719kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555410; c=relaxed/simple;
	bh=L8KskmWhTyMLfmpv+OIekHXEkQTAon84fb2uvVAF7ZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gfi2LptrDDRYGJhBia91y1AlVeKXPTZbveirhkWhL1cU/SqwaVaa+DF0qrryNPz8TFadz6if8Q0PkyKiiBJNBpjDwYpVhZF3JQhfDztbBXPXkqqZHM1OZsJyYkVxP9NoySBbJJ0BS7Vm54TWkUKa+x9enfipfRLo3N1bJOaMhEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nJgr/3k2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WE+G1aN8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546HbhCo011452;
	Tue, 6 May 2025 18:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Cb/LsKBRf7L+mKToy/9s03fuBU39xpkfNpVZo2cznrU=; b=
	nJgr/3k2LAmaKH5f6LsG74789f3k2RII09oXtpjgS2PgZNKN6SDHEK24WTcPoNa/
	B+Y8TUM+UQ32ivkgDtE65YrUofuHwWYKveoJREBAL1P79r9VZStjA/HNE0DmT/a0
	hwPJnbWfYu5CYVUVB4Jrj6WGuKtbHFz6ct0vQnd71EhqRYN5IKf3dE6URoj8/DTj
	giMRaaGqbt3e3Lkx7503qzUpTfnWE5VEAe00nINyaPwxcNl1frGmIaw6iEchkQr1
	rq84rPefoADJCY+Q/WA4Oi9yYVylHySemuy1/iNEc1Qg16GpcmvFhoqVQl+R8Vg9
	L2KaV93ISbGoh5fR9yRFKw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fpyxg3tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 18:16:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 546I1TDf007317;
	Tue, 6 May 2025 18:16:43 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012035.outbound.protection.outlook.com [40.93.6.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46fms7yvm5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 18:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1NoZYgF7atwQmp6HmZmzxwH2A8Cm0JYEL5q/DnGmWMcrFwOd8Ps5xqbY7NjrQrhp9VBfXFaNBgzKDyplb3xGvQncLvy+Gh3NUKixHdTTXfJN0m0Pxc1GPaDb5jp7Wo4chhllxO3m90XGNXT06wz3JOmL3xaLQ3MTp1rNR1hn2xUZ80c4ChGZAIJodDAZ0xWXc4OuGV3SXoO/3TCL/0bG64wD9RpO/25yGAZHA5sigpTimT2pNFiKGiunEbZcZridJcGrnhYZFbIbldQot3Y2wBGXxB4UikoKNKb9ImeGdr4qrIpik6TirRxx7+WEaefoZl//nsuMTuG8C5klJUEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb/LsKBRf7L+mKToy/9s03fuBU39xpkfNpVZo2cznrU=;
 b=t8d+fNoO38v/OAnPYoGGabkgsn8BtiBWcjHbBJUBY3TViSU0Hd52WTMewWr3n1NO/Bg9/GpXSwT/LE2YPNE8aLsdpDC+FvqgLIdZjeUYDaIEw6HBok6d6bx0WQ6a3lBqor+BSSRYZK45cZb2VIN7zwr1hV52dBf7OfIjEarIDcmFwER8icoaUsBYCS/r9Fn/N1Y5YfQ5T+fEPhDGngdqCOwBwnv+TDy2fkqs70kJDuhoTW8jJhNaeyN5CCaKA2uu/CWfwRhOaW31Wh/tffi39xQmM/VQZTZR0rN85Nq/6wrq9+GZCAhUjR4YqTbCSw1D8l8qXGCVeeACOI06nOBz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb/LsKBRf7L+mKToy/9s03fuBU39xpkfNpVZo2cznrU=;
 b=WE+G1aN8hDBJzJKGJdUqnJsIpkeMMR5tpVdGAWtR43xJ3aFjf70eLCZub5bQejHB38lrxedl8ZFYqMeeqhEhAkC9pnJW7by1ld4Q3uzWTycuWZGwnZHFHRDcLJ3+jNQsLh7uDdRYP2AwPrGf31bqmddWTadi5AG1+8llucR1fU0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:16:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 18:16:35 +0000
Message-ID: <d4d16122-5db6-473e-82dd-39e728796064@oracle.com>
Date: Tue, 6 May 2025 14:16:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: performance r nfsd with RWF_DONTCACHE and larger wsizes
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@meta.com>,
        Anna Schumaker <anna@kernel.org>
References: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <370dd4ae06d44f852342b7ee2b969fc544bd1213.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: add19a94-3cdc-455b-e005-08dd8cca2325
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R1JQZkh4MVpsa1pxQ1AxdWZicW4zdmJXN2srMEE3S0huaXRsWks3bE9uUlJJ?=
 =?utf-8?B?V2NTN0FPdHVZeUI0cjZQNmt0QTVUNzV1dkI3QTlXaFB2YlpFV3NBclhXN2lX?=
 =?utf-8?B?YmszaXk0enJEUFVkSEJsZkxPQ2lnaXpLNWI0V1R3TTV5dkhQZFV0eEkyRnow?=
 =?utf-8?B?ZVVzWGtINFp5SHpFOU9RVkdJNTJKT1o0ZTZ4VnZmZG1WdHJ3cnJOeHkzUHlR?=
 =?utf-8?B?U2ZNSDVteU55MGUzQnE2YVc0VkV0VVgvVkx1VDFmdDg2MUFUS0NvU1lWd3hM?=
 =?utf-8?B?UHY0M1Q0N1FDMlBCNTAxdG5TLzRqcjZtVlBOeGF0R01TelEyeXh0V3poRnA0?=
 =?utf-8?B?ZGQ5blU5d215UWlkdFR4NEg3alJiaU5oUW5kVUptbmdNcTk2VG9CellJaG9J?=
 =?utf-8?B?NTBQZEpJTUhxaGNKSVZmTUVTbC8rWjZqY1NWRDkySDVaNVNqdmVWeTBpK1p4?=
 =?utf-8?B?V2VyeVkzUTE3NnZKVDB3SzVFQXVTMUhNV3RaM2lhb0hHdTBDRTNXellCbXVI?=
 =?utf-8?B?MVViQ0hNdkdEK0ZRMDk4N1VwR1FDdUFOdVVCSTQ2RmhuNHJjb3dBTUhTb3Mr?=
 =?utf-8?B?UTdHejlNM2NNQUUzNXV3TUpTc0htUDAydEZwRnM1N3A4MlRJKzk3cmdoUzUy?=
 =?utf-8?B?QzNPNDlzNGsyMTYrbVJEQStRZXZpQkNpT1RpVEhSM0NubnhqKy83b1l6bzh4?=
 =?utf-8?B?ZEp5S1pxYys0cG1YZFlKUGlDZ2dnMk9aaUtvRkYzL1F0SFVFeGszZ3o0dWl0?=
 =?utf-8?B?bnpDcG94cE95THF1cGcwU3lnb09TOUdsb3lqME9RejgyRXA2Z2FzcXhMWXFn?=
 =?utf-8?B?R0l2dUpsRVZyMEN3RUh5eEU5MTFsdlQyV1RhMUsxZFhCNWV4Yzh1UjNNWWlW?=
 =?utf-8?B?UHdsdUZuMXZKTUtXeXU2THAzQjNZSmNBUVdOZVBZZjdVcGptVHdJUmhWU3d3?=
 =?utf-8?B?aHNQYmpsZEQ3b0dNOGorNzIrTzJvQmUvaUFYOG5mS0QvYm5mTUk2WDNzaDRM?=
 =?utf-8?B?ZkF2c0JwL2svZEJMdTVwc1lZUE5yVzhwbklZUHh4OWR4ME1jbldWQ3o0R2Zz?=
 =?utf-8?B?RzFiak9HRDNuYW55MExqdHlUcm9LTmpmREZnZjVVTDhyamRod2JqSU5qbkd2?=
 =?utf-8?B?RzhkVUxZaDNKZGtDMmxERnVYSVR2c2pmT2kwN3ZOc2YvclhtOFprbEZySjlB?=
 =?utf-8?B?dWQ3V0F5TGlWYi9rYjZpSGwwcFo5alNETC9RSGpZS241eHhxZXVSSVlTUVV5?=
 =?utf-8?B?TVpidjNpZ3lnUS9hRjcxczhDa1lMYzlHcTN0dHNlT0J6MkNPWHB0WHA0VUVF?=
 =?utf-8?B?Szd4YTBzWHdVUStxd2RxZXRCY0VFanRkMDVTc1RUeFZKaWloc0YwZndQaks5?=
 =?utf-8?B?bFBJNFVUa2dlYThpaFdwc3RzOXU0ZzdGc2xucERPMFJhOTMwbndEaEVnUGZr?=
 =?utf-8?B?eXJsWkhJQVVNYkRiTmRJMXdJL1Y2SGV0OUIzMm9od3g3Y3l1bXNTNnZ4dlE0?=
 =?utf-8?B?cDFQMUpDSGdnMHhGZGhNTjk1cUYrbld6SUVwcjU2QVQyb2tYVnN4ODlicjRk?=
 =?utf-8?B?cDFVbzVCMDlJakVIRWVNTTdnUW5Id3pXa200NFg5ZnVnRjkvN2I2aHN6NGtR?=
 =?utf-8?B?T3hBV01IYm9lMGN2TG9LdVpoY252UDZQZXdRUE01dnQyREJLUFJFQ0lVN0xu?=
 =?utf-8?B?RDNQQUNMc1ZnNUdKWU11YTVRWG9HRzZDQkZmUzBnVGNpYk14dzhjY29hQ1ZI?=
 =?utf-8?B?SDVEZU5DREpjNTVSVHBPbm04azNnbjlFbDN4L0lTZHV1SzF6Vm5XanRFSlpa?=
 =?utf-8?B?azNXakFPUWpFQ2RLc3ZDUDcvRnBUMFluZGtFSmo5Q1BBa25PTkF3UCs1eGZp?=
 =?utf-8?B?NitvNmZZdXRHdzQ5QmdLTXB6MlVsYTlFYVhkQ2N1NDJ1R0cwK01sTnVYNEYz?=
 =?utf-8?Q?Hd1H/h46P+l/4cJ/MUjpRMBdN5NDJxz2?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S2ZBZmhxcm95YmtNUFJnY0JmU2ZvTlNSSGJqOG8xV3FUU1lQaFhqWElRTE90?=
 =?utf-8?B?Z1U5WjNQZytRMG9GbnkrQnRlNlRsVEswRGN6WUtuSzIwYkR1VGxiNXQxc3FM?=
 =?utf-8?B?SVJtbS9iem5ac2xDVG9kM3BlOGJoYkt5citBbkVTNGNKeFBOVGcyaWYzYkRY?=
 =?utf-8?B?RlZhdDdWV2xnc1VlZDZsd3UzMXdaMllFWEkvZVV3ZitnNzdMOHBDcWxMeGZn?=
 =?utf-8?B?WXF0SGhoakdYUytxNGpoMGRsYkdSVU1aVkJsOTgwaWNSemxmcXp3TTFCNW1l?=
 =?utf-8?B?dG9jZjlXcXh1L0hUV0p6SDBsSWNqNmpXdjB5RytUSkR5VjdkUng1djlUN0x0?=
 =?utf-8?B?MzVpd1VtcEQrSnc4OXJsRFdXYVQyT2lvd2hmbHNBUURzc2cyL3h3YlJCTXBG?=
 =?utf-8?B?Y0F2Yk8wTEZxNWwzR04zeTdRUFJkQWRpMEx3M0JLUzBJbXR4aG1RVldqSDg0?=
 =?utf-8?B?OWNGdnNaTTVUdzhCSDNnU0U2eXB5QmtBK2RvbGRHS3ZBM1lITktWTmtXWmEw?=
 =?utf-8?B?bEtmR0M4di9RTDZqdGlHWkJYY1l2SkJqU3IwOWcwWUpiTHgxcHdQb1ZGaVV5?=
 =?utf-8?B?U052M3MyZnpaTmZuQUtEWXRoUkFkMGdxb1FURlNFWFZLYWg5UEMyU3c3K0l0?=
 =?utf-8?B?M3A5MGNYS1pHd1RsUUFkNnlCTWJWaVg3ajVyRG55S0I4c1JhTEN6SVVLYkNl?=
 =?utf-8?B?UjJaOTIwNEpzbXFzbElVWTNBdFZSNFlDOTUvcDE4Tmk4RnVONDBPNXFkZ3Nt?=
 =?utf-8?B?eUc2SDRYSFVCSGl2dXJqRXhXOWJlbkhWVGpCUEFvQlFDYW1TMUdLdzcrZGVX?=
 =?utf-8?B?Q3hqOWZYbEVDUGVuQk53OW5GbURIY2NZZ3U5WGJ1Y1ZlL2owT1M0MXNVeEdD?=
 =?utf-8?B?RUVBOUZJTDltb1NhWkI0VW55QlR3NVl2VG9lQkZZOUN5YlVUUEIyUjhPYUNZ?=
 =?utf-8?B?V3ppN2xHdEp0eDNIUnpDVUExZ2w4SG9GK0dQZHc2NVFUSEdMQXBrQWVjeWY1?=
 =?utf-8?B?VElGVWZuc3RyVW1VTCtOeUZodmlrYm5WeTZmWWpnYmNweDhBbFd4N1ZWK2lT?=
 =?utf-8?B?TDJkMkdSQXk2RE1IOUluRGxlR1NuRVBNS3BNbExubEdoYVdoUUNlT2tnYlNY?=
 =?utf-8?B?OWZWOWZGcFl0eEJQK0UvTEoza2ZOeHlVUGFmNXpWN1gyMWR6U2FoM0FDVVN1?=
 =?utf-8?B?TENhV0xxYXhYamRoZ0VoY0VZbXZVNW1XRm11dE1pSUErT2RHQkR6eEE5ZTNJ?=
 =?utf-8?B?ejZLM1FXV1Y4OG9GUk9sNVFFTlByZm8vLzZVTjlOOEE0T3BLdDRSRnNWQW5s?=
 =?utf-8?B?TGlraVpJaitheHNySnZ6Kzc2YlVFQ3pjaVpyWElxdWkyZEpVbGZJZEdMZWI2?=
 =?utf-8?B?RHAydWVWaGJpRG4xTENQRUlUd0Uzd21uU2lQRTR0WVhRb0h4NjBvZW1MR0Vz?=
 =?utf-8?B?WTdDQVZ5d1A1dERCb0dvNzdNUmNMK0NUNTJXQ1lYV242YmZ3VUlZdC9ZZ2FK?=
 =?utf-8?B?c3FMbWpDbGRXcm1uaWVoQTVMaTFTVllKOXlMMjlic0J4YitWVlgwZnM0K2k2?=
 =?utf-8?B?VGhkSUhSQlB4NHFxVzlGQWlSclp6OUduZ1dFYTJmQ0lmLzl4Q21KMlJ2TmJs?=
 =?utf-8?B?UmJMNXZJTm40a1VTY25ocXVDZzAxRmNQVkpIZndJMnJRR0JiT21vbjl3RllH?=
 =?utf-8?B?MFVsTjFwWWEva3gvaUM5ZXNTc0xCQ1JxVUdybWJHT2JzRnFHL1FFVEhFVFVZ?=
 =?utf-8?B?enJqSmtRdm5qbnQzS0trc2NOYUp1M29RVTg2RHZTNyt6RDNsMWhjMUo0V3lh?=
 =?utf-8?B?djZoSlh5MTdvTTRaS1dhR3dwZXRtc3hRVUhDNjdRQWs2ekJHRGt1bmVyQWtt?=
 =?utf-8?B?SGZnMlQyMFFYdEJqa3oyWWF4ejJkWFNFVTAyb3VxK3I1VjErQ1BCa2wwWnpS?=
 =?utf-8?B?OUc2dEMzdWMzeEZaeGZBUGkzQXJNQitqaUh4cHI1SnE1c1RxeHRHeHNwbGpm?=
 =?utf-8?B?MUUwNEVQMkFUaW5JNXpxL25rZTAwWUxCV3lyNk02QytZTEVZRjhMaVBzUitw?=
 =?utf-8?B?VXV3RmZHdDdxaXBydUh5L0dDQXprVm16aVExZXlVWjh6ODUxa29MbGF5VlJr?=
 =?utf-8?B?RXJ2WGZRVjhYa3dXKzFGdFBUZTdWWUFCNExkOUd0R0pKS2JmLy9RVDdXbkpZ?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wBlpT5GzKiYo9qqKLAYu5uTheH4pN5J28IAeYvs3ofoUHyirlKXhTzEfSATF0OrEKpVtmmlgKflAVGeWSOEItzhO1wkNw8OrNkDct9yOrsOnmp827QBcYS6yTvRTn7gngNAxA1GRrH+Fpcy9yGCngccRHFg9AafDQbgryhG2Yfy3/TAwcS6TEYVVofXClNl+GB3JmegUHyyOPn4p6aEKXU1hPCGOCpD660epaUlKOZUaKMhGrkEYtl2GX8vlMsMqofT7zbQTLJx0Yl1b4DbLE2zJILYImcHoY3E6P0fX/Nh8N15ObBJ1wB+OIJx9bFk9MlyrFkLQfGHD6Ss2FxVq+hPncplbBsmRZ3bJvLZqQVUeW6XB7P9VT4BHg8nbYpnHeBWNObtgxeCfWGH6MXmMTcy9rvRnDuF9FboJs9UnvFScks8lFhCVAcvd3coT2c3SI7oeRC7bE0PKUjeqMFd4jdea3q+eNYhr40bTzJ93OTTM9pXTQuTOLdIUQDFmg3dS/HitAHVbrhp+3TRSq+B3FIsDUprC9zKmgnkdi4KIaBxTwPIALduiJPjCiL1ahnSyL3Hwxv+o4oWNl1cK3XgwIEFFvpgcS3IYLiuP7vVkN90=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add19a94-3cdc-455b-e005-08dd8cca2325
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:16:35.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG12rhdgsQCRINYYG0Q9w5GzSQrE8zxAMwFXyhUHopTsKoDDw4SLhfh5TlVfLA4bMvX/aTZ70QZFDzFZa6ntnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_08,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060172
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE3MyBTYWx0ZWRfX3WzjmuuD8LQB cynoql1XsIfu4ZUDl54l3PXxOKBDPrFv9ZI5/JKvypmbY+HFxpsmS7IWVUn95kLqNSXnDPFIAk/ tVGV6CM6lXPwBnLAkOo0xLiNvOVXAWJpZRN1mx/B896V5CjllnRHx15klxBygV2Ad/bTJAN6X15
 tDeawRSSGBnqCRt/0A8zefjP7fK2jQ09OwAnzAQqnjDHEyMhyPVvT7KDujJMcbqIJGMwXjrufXw RoMnybKOyx85VFzePVkxUdo1iMub5TV5B4Gvu213xHzmq+wsya4DDh9CoGjvcXW2bISq07ANEN1 Br6XHamXUJM3KTW7803CYELv+FMOsIt2doi5pshCVut67oeVEPLrIW/vTNPaFwUoYByA5fejHeN
 8a2ehx0NOw1pmC9T5erhfl1ad8j7GyqGYCORQjV0DgzqvmDNB8nvfoaZjEb+v7TwUKAX9Nou
X-Authority-Analysis: v=2.4 cv=LLtmQIW9 c=1 sm=1 tr=0 ts=681a520c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=cv9VShwS0mr3w7YD-sYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14721
X-Proofpoint-GUID: JstUxu72J-xSX9UY5ngVFOKDiYPzOoJg
X-Proofpoint-ORIG-GUID: JstUxu72J-xSX9UY5ngVFOKDiYPzOoJg

On 5/6/25 1:40 PM, Jeff Layton wrote:
> FYI I decided to try and get some numbers with Mike's RWF_DONTCACHE
> patches for nfsd [1]. Those add a module param that make all reads and
> writes use RWF_DONTCACHE.
> 
> I had one host that was running knfsd with an XFS export, and a second
> that was acting as NFS client. Both machines have tons of memory, so
> pagecache utilization is irrelevant for this test.
> 
> I tested sequential writes using the fio-seq_write.fio test, both with
> and without the module param enabled.
> 
> These numbers are from one run each, but they were pretty stable over
> several runs:
> 
> # fio /usr/share/doc/fio/examples/fio-seq-write.fio
> 
> wsize=1M:
> 
> Normal:      WRITE: bw=1034MiB/s (1084MB/s), 1034MiB/s-1034MiB/s (1084MB/s-1084MB/s), io=910GiB (977GB), run=901326-901326msec
> DONTCACHE:   WRITE: bw=649MiB/s (681MB/s), 649MiB/s-649MiB/s (681MB/s-681MB/s), io=571GiB (613GB), run=900001-900001msec
> 
> DONTCACHE with a 1M wsize vs. recent (v6.14-ish) knfsd was about 30%
> slower. Memory consumption was down, but these boxes have oodles of
> memory, so I didn't notice much change there.
> 
> Chris suggested that the write sizes were too small in this test, so I
> grabbed Chuck's patches to increase the max RPC payload size [2] to 4M,
> and patched the client to allow a wsize that big:
> 
> wsize=4M:
> 
> Normal:       WRITE: bw=1053MiB/s (1104MB/s), 1053MiB/s-1053MiB/s (1104MB/s-1104MB/s), io=930GiB (999GB), run=904526-904526msec
> DONTCACHE:    WRITE: bw=1191MiB/s (1249MB/s), 1191MiB/s-1191MiB/s (1249MB/s-1249MB/s), io=1050GiB (1127GB), run=902781-902781msec
> 
> Not much change with normal buffered I/O here, but DONTCACHE is faster
> with a 4M wsize. My suspicion (unconfirmed) is that the dropbehind flag
> ends up causing partially-written large folios in the pagecache to get
> written back too early, and that slows down later writes to the same
> folios.

My feeling is that at this point, the NFSD read and write paths are not
currently tuned for large folios -- they break every I/O into single
pages.


> I wonder if we need some heuristic that makes generic_write_sync() only
> kick off writeback immediately if the whole folio is dirty so we have
> more time to gather writes before kicking off writeback?

Mike has suggested that NFSD should limit the use RWF_UNCACHED to
WRITE requests with large payloads (for some arbitrary definition of
"large").


> This might also be a good reason to think about a larger rsize/wsize
> limit in the client.
> 
> I'd like to also test reads with this flag, but I'm currently getting
> back that EOPNOTSUPP error when I try to test them.

That's expected for that patch series.

But I have to ask: what problem do you expect RWF_UNCACHED to solve?


> [1]: https://lore.kernel.org/linux-nfs/20250220171205.12092-1-
> snitzer@kernel.org/
> [2]: https://lore.kernel.org/linux-nfs/20250428193702.5186-15-
> cel@kernel.org/


-- 
Chuck Lever

