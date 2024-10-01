Return-Path: <linux-fsdevel+bounces-30504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B73298BDEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3AAB24A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8454A21;
	Tue,  1 Oct 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NsXsaOH/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jzxb4Cs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526A1C231D;
	Tue,  1 Oct 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789763; cv=fail; b=ryucI2XG92Onqu5fw+/baLNvLYTgrTjFnjnM2ESBCyn41JMlGfGsvIVMEAsZgeUZKkb8TZtJnYQWNFe0Lidv1bIu/VtnUx6u3diq62dm6Wa+TbPONZ2GHr2OpMNWxudes0AmW+V5Cpgzfr73Ghf7za3W2qbjeEUbOTnsJMBVQUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789763; c=relaxed/simple;
	bh=qxAitXufeg765MNrlDiWQUqRbhRuWAO7fzJ7MkL1c+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yt10cQ+MlD1cz1FCZ2lUgNWgVA0oTL2u3FujOahv7N5I2m/8LEbIh/dtijlJxLBKVCtFZ9tMgJmQ+xmOaPylNiQpt/0935MBBpJvSbo4OpOHz5yEz/EVwl3Tb6rsbRGLymyVNKuUf4vxIsNN7iJPIyqmuXgZLN+6106aYEQzi0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NsXsaOH/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jzxb4Cs0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491D5bxc003290;
	Tue, 1 Oct 2024 13:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=JpgQ+8AS9CuB8m2UUAX/SLwEVvh02KRdBBPsIgLlkjM=; b=
	NsXsaOH/1q/Utq8d4GtcJgi0HoQnNYWGTdh3wuFFVd7EwZHOaC6X2iox2jL5ETi8
	nkm93MCb6DCfvaFXm0NLHx3O737nm2LxqE/SgLVDhh1kEQBwwp8Rbj6mc6WFO78E
	Vt1R6BbYk+uaxXh75H/6Y6rpCqBKWblfsnQpq7+cy2lj2tC5Cbo/A5DDaUzxEn/V
	xoZ6SJnOl7AzOIfbaAtFOKXhPfsUODmg/eMkbfUDJN6edffKVRseW90MpR27+dHD
	NGijDMGGzAfBeOIjx16JIL0JLtZSvuYK0nKTM/YfYOq7sPp08kfWPTp/wg0vFjGv
	VNvWjmMtqzBWU16oj/3b5A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d67vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 13:35:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491CNjsB026279;
	Tue, 1 Oct 2024 13:35:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887jj7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 13:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFeOp9rQ81k8nP2ywPKbGpGQn/J9djtLTiCKa/hmkwVEM/gK24e79j+mHIn7uWQqUkpjqsuvNhlocaP0fCL5pVPRymIZ4VmvyggAu4IW2s5DKSa69Rj7A7i+8S0P+CNIKkmVDqFMeHkBijB1C4Nsv/qhc4+351mSzA227VGOBMbd/aSTsbVpai6i0tJ9bxaT83VrG/sFHeyaPAg7FSCMOffUMDyEWpXnjQZL8cMddPbwda5iYOovZ3Cc5FBjrl0BSmovUFfFGM1jm8AZCeSK7t2teDVmXf56T6m5YiAUSrynTl8e+FfKS4qchAH72Xoo9ljXQ6Pvjf3s0sGd4FdlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpgQ+8AS9CuB8m2UUAX/SLwEVvh02KRdBBPsIgLlkjM=;
 b=OgnIXIk8wbe/7DR8/ptmrKUlLugGkhCtGO3jkSHr9inUubhKz2nk+nKVO5qDL0dRsvHURmWTVP2n5kWWfJGknHvLiykfBlKk4rp5vhohtg3/ynWzredsuToZkHq3NVuZ08boAcADu2r7wNrGhRgM1abbGvKUFSoAONSXvO91yHFKvwx/gJA1ybtEQUSvucvF2y7KlQULq4+VLosiDsPLt26GKClC2SpBVRC/EOKkl/YDB5HFUmaoBGp9Mr2QMsNdXQu4E6ao9csQZn5JXOpVhPWAQcIk6rXG91XLEkvBq3jB3kAItEhbnVTy4PRCK28TVxkBsicen2l6dP6Y7rie/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpgQ+8AS9CuB8m2UUAX/SLwEVvh02KRdBBPsIgLlkjM=;
 b=jzxb4Cs0uV1Uvf8JTJ6ffPouminZuiiWGCz0fobbY3gxqGbJdUyP2inHHColO01W6DVG7eHhp3GV8GogKFO1GW4CuTcm14NoJmbdq8kBnDYaYIZ5igfMtjPbKuvUee03ZXTS/FsOdv5kMSZtER0DzyGqITeV7XTiPOawyP/04/A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6613.namprd10.prod.outlook.com (2603:10b6:806:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 13:35:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Tue, 1 Oct 2024
 13:35:43 +0000
Message-ID: <76104c6b-e5d4-4c12-84f4-ec4322ec7721@oracle.com>
Date: Tue, 1 Oct 2024 14:35:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] xfs: Support FS_XFLAG_ATOMICWRITES
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        dchinner@redhat.com, hch@lst.de, cem@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-5-john.g.garry@oracle.com>
 <20240930160349.GN21853@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240930160349.GN21853@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0343.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: d10c1fed-f857-42f9-7093-08dce21df272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjBnQnVhSHNOTmRndDkxa1ljYWJMblRLNzkrUytGSGQ3WHpyWFhscldOd2h3?=
 =?utf-8?B?d0pHRUlkZ2p0ZUlSRDFGdmJQa2VmYWZnWlJYVnJSVU0wL201bVdINXV0Yk5I?=
 =?utf-8?B?WWdDWUlMZDlmMnZaOTlJRFR4dFB2ZkZ5V3lzNnExd3EyaXFUZjhGVjRFa2Jw?=
 =?utf-8?B?VUx6Ti9pVDIybVB2akNBUmNSUkR3NFIzUHRxNmN6VVovblh6cHVHR1VuVjlZ?=
 =?utf-8?B?M1NWZTJlTjdFeHBBb0tHYnFLUDIvam5LQnM4QjQ2TUxUdkg1VHQ1Wm9oZGQ3?=
 =?utf-8?B?YmdldmxyVjJoMWlPenF6empyNWZFQzlWckUzb084SXRXNTc2ZmdqTm9QV0hl?=
 =?utf-8?B?NFNNWmk4RGRURnB6SjJWNVdXQm9GOUxzc0RpRjFQVUs1NVczcGdOM1J4a05F?=
 =?utf-8?B?S1hKNUF1NHl6RUdMRmplam55MEQvTmtmMktzODNHMXhqbVJ1MjZDdU0xYWZa?=
 =?utf-8?B?VmVpbnhrRHFQdUlReS9DRFB5cmlVQTY5OHJqZm5TMFFmY21iWFRFWVRlNjBB?=
 =?utf-8?B?dVMxN3ZaQVcyUkRQZ0o2Mk53Sk1UL0FRbnR3N1dmWi9UNVdabG9BQ0kzaWsw?=
 =?utf-8?B?ZXpaZ0htbGVMMlBtNGY1d3ZtbHRHUi9YWGphMFpjcDhMTWhiYjk0WmpTZUhq?=
 =?utf-8?B?SUQ0L25MUXVFK3dPVlI1Rm5wR3JMQ2l3TThkeGZBVUxYc1V2TXpUT1JyOXcr?=
 =?utf-8?B?dkZNcitHbjVHNHpJbU9VS2lDbmgrQkpocmQyY3U4VlJpbXlDNS9JZzNMaE5Q?=
 =?utf-8?B?cDBBdzZBQ3ZSVVJXdFpnL2dqSlYyOUY5WTNrazRDdkNkelVPQ3JvYTBsVll4?=
 =?utf-8?B?OEY0cFpxQUdpWjVZKzFZVVZMakpIdkZQSzZqekVUbzdnb1R4ekZzZnNsV3JS?=
 =?utf-8?B?ZXVTVG1TZGdsTU5SSXhraXpyWDVIZGV4dy9aelhVVjZYdEs3YTlpOTlaeWNr?=
 =?utf-8?B?aS8vdXQ5ei9jQ2ZsK09KOVJ4MXhoWmdzQXZXbzRWSGkrbkt4Ym5vV1Uvdk5p?=
 =?utf-8?B?d0hramxhWG9WVXdBeGZWL2ttcUtiUXNoSFNjc0RtdGY4anRxR296TW1jTjJy?=
 =?utf-8?B?Z1dZWU13Q1NQdTVyeTBtTGs2OExtS1llSTY2b1ZaMG9oUm9BZ3hnQ1VRUkxK?=
 =?utf-8?B?N0x5WjM5Q3I0VTNrVCtoZVJic0VqQmw5N1NHQ2Mzbi9MdkE4QXBzUTlYRitX?=
 =?utf-8?B?SUovUjc3aEh5RGd3bjlyREwrV0NwZ0JWeUhsWm5LaUdJS0hLOWpVcUxxVHRT?=
 =?utf-8?B?NjFSdFpnTGNDM21NUUdQQjBUaTdjZ2NTL1psN2xLRGNGczdnZURnb1YzQ1ps?=
 =?utf-8?B?ZGRhd0lRMW9KL1J2THlvSzNaSkxJUUN3WWE5R1hRTVFJaFFNQ3pDcG1CZXBL?=
 =?utf-8?B?NnpkbjVWNm1ZWHZUa0NiczNKdkdVckVVajRBZDRHM3JLYXYwS1lDbk9nTTV6?=
 =?utf-8?B?ckd2bkNZako3M1VQMzVRUVhSZHc2T2Q5c3lWbDZibzJvZmltdllsUnkzbXox?=
 =?utf-8?B?Uk4vYlk0aUdScUFhRHQwMjVNWldXcTZCV2NHa3JRTmJYZ2R5cThydjlTclVh?=
 =?utf-8?B?OFdGdHFmWkhuQ0tWM3hBMnZQZGs3UlhzUE9aUkRXVFd2OG5aemY2M2kwTHZM?=
 =?utf-8?B?eDhzR2RiaHU1L1poWVNzZGNRRGp5R0k5SUtaZ0gzNVluZGoxNGM5MHNkUm41?=
 =?utf-8?B?Z25Yb0Q0RGFqdmRNUEVuWG03SndHZEl0THFETzdhTUlXQUlydllKSk5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU5OdnJiaEl3Wkh5dkJnNmJsa3BEcCtMc3c3Sis2RXBpK3UvZkVPbjR4R2hN?=
 =?utf-8?B?TkxIbm5FRlR1dEc3cmoydUdzV0NabE1UK2I0WHJTa0dhb09YK0Urd0FEVHFR?=
 =?utf-8?B?bXFQcHNQZjF4NWtRdlloSG5tUnRQNXRYUWg2SWt0ZGhTN1BrbXl6em9iU21F?=
 =?utf-8?B?N1dtTFNrS2RoQkFid2hIRWgrVU9YQW0zYS9DWFQ2VmY0Y2t4SVBTcEwyV2d6?=
 =?utf-8?B?T3hwZzRsMjlSczJFeUxOV2I2eHEvWnhOajgybW9VdU5SOW9hTUtpSTRaTUMy?=
 =?utf-8?B?L1hCc285M3JjckhHTWFVa3dyOEkvT0gwOURyNzFvMFJhV2VOaTg3alNHL3Y1?=
 =?utf-8?B?RHZ4TTM2amVwN1dEUTAvSWFTWitOSHJtL3Z2ZmdhRFlaZUFZZ2c4Z2lsTTI4?=
 =?utf-8?B?OGVkVGV5blE1WVJEaEJpNWJ4ZXlibG9UWGtxVmdWWFVYM1drVmR2QU9YZFhN?=
 =?utf-8?B?WTE4TlhTNEJqL0duZS83OThVQlhFcmxkS2V2UUxrTmRBUmdDYmpoczJDNmFr?=
 =?utf-8?B?T2V3NVFLRVZqY2N6L045bEdTWHgrWXluS1IyVDNVaURxWFVGaWRaYnBhR3Rm?=
 =?utf-8?B?Zmp6d2QwcUhWRXFpWlR4ZE93R3ZnYVlTWkFzOVdkR3BWbDJ0aFRiYlVxRTgw?=
 =?utf-8?B?ZkNycjFpOFZEUys3MnNxNFBCak1xWEFHTVY1cTlhOHc0K1ZLMGFQdzNENWJO?=
 =?utf-8?B?SzZ2Wi9oQys2RVFiZEU0RTJNcUMvQ21nSGF1ejdudklGVXFsZG05V1ZtOXcv?=
 =?utf-8?B?RHhOREMxVnlmb0ZPeXBrTDVqd1lwUHlweTNtcTIzTGVQNE1VTFppMVZPY3do?=
 =?utf-8?B?MGEzMWNKNmF1Qy81eit2dGNiaTZsY2RJQ1grTVJ0NHFsdm5hRzNSVGoxR1h1?=
 =?utf-8?B?OGZZYkp4SHJnSnZxR3labERmQjFxZEZZR2RYYTcwYzRtazdyZGlPL0hzdU44?=
 =?utf-8?B?bGdGQy9YZ25Od1ErUitYS0h2QmxwWnZMTlJEUUhTdFp2M2xwZktsVEVldkdj?=
 =?utf-8?B?Y3VFZUN5RVlUaXdBcXhvWUFneXo1QndpTHpoRjdPR3p6dHQ3RENXTWljSVYy?=
 =?utf-8?B?KzFNQ2Qwc3JhWSszN0JzY2JwOVNHY0wzUTN6bnRxdVFDZXdYWDdMRVNEWGNG?=
 =?utf-8?B?VEFzVnFCLzU2ZlRyaXNaeXhuaDUzeitSWjBNOW51VXFpMTJIUU5WLy9acjg1?=
 =?utf-8?B?TFRNZ1JFcmh1MktTeTRsYnJEVS9vcFVvK21aZjFra1pBSGVrOFpzUElrS1Yv?=
 =?utf-8?B?dzBWdHR2NHFZRi9TZU5OT3BIV1p6ZE42ekQyMGc3YU1HUUdPTE1YZjNiTFBs?=
 =?utf-8?B?Skp3UDg5SDdwMmF2VDZyNGZpNWJRNWNNZEUwYllxSXloL245T1JvVytoanhT?=
 =?utf-8?B?aHRTWUJOYXJSLzlBNW9sc1FJRlVqMmpWUXZnQlZkZlRKR0hJSXBPM2txMGhL?=
 =?utf-8?B?ODMwb2hJSXphTWJnUnVNTmYvUTJZRkhwL0R0ZC9ISkI2YkF4RDZYVjdTVXlw?=
 =?utf-8?B?Zk93ckNtL1BXSnR2RXJXdHZHU2lmMTM0cDY3NTBZazRhNWZjQ2plUVJkZ0tX?=
 =?utf-8?B?SG1pNlA5K1dLUzkzbG9wUXRha1ZPdHEwUFl1SWhlUUp5RUZQTmF5bTk0eS9K?=
 =?utf-8?B?WUI5TjFWdHRmajJZYmRYOUczRzVENlhncGNwUzkweE5XYUZHb2ZWZ2xKMmNw?=
 =?utf-8?B?bjRzeE9MSUZUZkQvK1hIaUcxSmg3dDdDbm0wdDlFQkJXVmVKYTJrL2ZlaWR1?=
 =?utf-8?B?VzVQYWhMMlNpK1N3eS9pZEY3ZThPT2IyWkIzZ1V3TzU0YkVPNXQ4MG45ZXlN?=
 =?utf-8?B?cEk0TXhGZnFPa2ZQNlVtdDVQak5XNytCRXNZTFhUaGlhZHBKdnNNbkdWcHAr?=
 =?utf-8?B?Rys4bkR6NnFrZTlnU1BQRE9lMEo4YXVYV0tUTTU5L2JLSTRNdlV4ZUNQYjZz?=
 =?utf-8?B?cXhFblcvbkY4R3hJcmJZMXgwU2R5RlNheE5naE9QWFlRY2llM053bzR3cVVD?=
 =?utf-8?B?cnh3a1BZbXV5eWxDbzVUTXZ4dThUdkV2WVpTQXJ0TVZOZUlSdUMxUTIybjJG?=
 =?utf-8?B?dzNGcXhmbEsrNlI3bU80ck56RjdHZmNSNURrSk8vZDY4emZremFtU0I3VjFQ?=
 =?utf-8?Q?F4fF1gFq7Kfq0pISHfAzAQl/N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rEnnIpWNAAfHgOMSH2fQuWWhVUD2UjBZbIX3vpHf7fAY+EoB6d5tngPUphtzGYbLDaQbafj40ZsEGHkMb1I5rNuB0ftW0Cs5IUYuefOLhStFiCXInElsNaEArKioI8hxrRNUXSD09/mNS9qD3Z6eXKnyDksz3PU31k0RXFrLmftaMmngS2J9dqVbQ+v6McrRcNeMG98Ks454vPYEpcdV6yfa/jHxMvS/wGqib8oH92znAySvQoB2rp4NIA2ql8Wzy5Mfp+FENKxjBSLrN5qP1DHotPXaYKPgZwF1oo8RxqqeT0v2hQEIPpxbW9hangYC14ShQUmzus05wI7TCaQHR8G4KF7zN0llO4WnMmOJxAneW1zoiHGzwNZMH+sCtF4V80YLx8bZbEISLsA1V1KcSasF58glj9igDc5Bs8GLGCkjG8+Oj2CiySUu9PA91E2hPZcJ6a/zyR2gB6etemNIVVQVCxmgZUwsg8Upe5HBnVGI7jocuuFd1BAD/np1wVu91RJk0VxDFfmsFXgR/KxKEeCmdRb0DUhrjhfpGiC+hBWtQsTjn4zJZVu/5lq4H6+Z22eL0WkYDhurKSBUzM2B0a5RvORpzUp77wihVQhz3zE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10c1fed-f857-42f9-7093-08dce21df272
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:35:43.1438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DRERmPB2IB7NBERylHkJasCxK6hm+cEcBNC0c+3Pg1zZQcb6OAf9tipEPPSjAmiRoa668QdGJIGyf/Xz/xIIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010087
X-Proofpoint-GUID: gV6zaNxdLTtYlnhC4QPt9-dLIJWhrikx
X-Proofpoint-ORIG-GUID: gV6zaNxdLTtYlnhC4QPt9-dLIJWhrikx


>>   }
>>   
>> +static xfs_failaddr_t
>> +xfs_inode_validate_atomicwrites(
>> +	struct xfs_mount	*mp,
>> +	uint32_t		cowextsize,
>> +	uint16_t		mode,
>> +	int64_t			flags2)
>> +{
>> +	/* superblock rocompat feature flag */
>> +	if (!xfs_has_atomicwrites(mp))
>> +		return __this_address;
>> +
>> +	/* Only regular files and directories */
>> +	if (!S_ISREG(mode) && !(S_ISDIR(mode)))
>> +		return __this_address;
>> +
>> +	/* COW extsize disallowed */
>> +	if (flags2 & XFS_DIFLAG2_COWEXTSIZE)
>> +		return __this_address;
>> +
>> +	/* cowextsize must be zero */
>> +	if (cowextsize)
>> +		return __this_address;
>> +
>> +	/* reflink is disallowed */
>> +	if (flags2 & XFS_DIFLAG2_REFLINK)
>> +		return __this_address;
> 
> If we're only allowing atomic writes that are 1 fsblock or less, then
> copy on write will work correctly because CoWs are always done with
> fsblock granularity.  The ioend remap is also committed atomically.
> 
> IOWs, it's forcealign that isn't compatible with reflink and you can
> drop this incompatibility.

ok, understood

> 
>> +
>> +	return NULL;
>> +}
>> +
>>   xfs_failaddr_t
>>   xfs_dinode_verify(
>>   	struct xfs_mount	*mp,
>> @@ -663,6 +693,14 @@ xfs_dinode_verify(
>>   	    !xfs_has_bigtime(mp))
>>   		return __this_address;
>>   
>> +	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
>> +		fa = xfs_inode_validate_atomicwrites(mp,
>> +				be32_to_cpu(dip->di_cowextsize),
> 
> Technically speaking, the space used by di_cowextsize isn't defined on
> !reflink filesystems.  The contents are supposed to be zero, but nobody
> actually checks that, so you might want to special case this:
> 
> 		fa = xfs_inode_validate_atomicwrites(mp,
> 				xfs_has_reflink(mp) ?
> 					be32_to_cpu(dip->di_cowextsize) : 0,
> 				mode, flags2);
> 
> (inasmuch as this code is getting ugly and maybe you want to use a
> temporary variable)

As discussed later, I will drop the cowextsize check (so need to pass 
this at all)

> 
>> +				mode, flags2);
>> +		if (fa)
>> +			return fa;
>> +	}
>> +
>>   	return NULL;
>>   }
>>   
>> diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
>> index cc38e1c3c3e1..e59e98783bf7 100644
>> --- a/fs/xfs/libxfs/xfs_inode_util.c
>> +++ b/fs/xfs/libxfs/xfs_inode_util.c
>> @@ -80,6 +80,8 @@ xfs_flags2diflags2(
>>   		di_flags2 |= XFS_DIFLAG2_DAX;
>>   	if (xflags & FS_XFLAG_COWEXTSIZE)
>>   		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
>> +	if (xflags & FS_XFLAG_ATOMICWRITES)
>> +		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
>>   
>>   	return di_flags2;
>>   }
>> @@ -126,6 +128,8 @@ xfs_ip2xflags(
>>   			flags |= FS_XFLAG_DAX;
>>   		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
>>   			flags |= FS_XFLAG_COWEXTSIZE;
>> +		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
>> +			flags |= FS_XFLAG_ATOMICWRITES;
>>   	}
>>   
>>   	if (xfs_inode_has_attr_fork(ip))
>> @@ -224,6 +228,8 @@ xfs_inode_inherit_flags2(
>>   	}
>>   	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
>>   		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
>> +	if (pip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
>> +		ip->i_diflags2 |= XFS_DIFLAG2_ATOMICWRITES;
>>   
>>   	/* Don't let invalid cowextsize hints propagate. */
>>   	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
>> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
>> index d95409f3cba6..dd819561d0a5 100644
>> --- a/fs/xfs/libxfs/xfs_sb.c
>> +++ b/fs/xfs/libxfs/xfs_sb.c
>> @@ -164,6 +164,8 @@ xfs_sb_version_to_features(
>>   		features |= XFS_FEAT_REFLINK;
>>   	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
>>   		features |= XFS_FEAT_INOBTCNT;
>> +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
>> +		features |= XFS_FEAT_ATOMICWRITES;
>>   	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
>>   		features |= XFS_FEAT_FTYPE;
>>   	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
>> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
>> index aa4dbda7b536..44bee3e2b2bb 100644
>> --- a/fs/xfs/xfs_buf.c
>> +++ b/fs/xfs/xfs_buf.c
>> @@ -2060,6 +2060,8 @@ int
>>   xfs_init_buftarg(
>>   	struct xfs_buftarg		*btp,
>>   	size_t				logical_sectorsize,
>> +	unsigned int			awu_min,
>> +	unsigned int			awu_max,
>>   	const char			*descr)
>>   {
>>   	/* Set up device logical sector size mask */
>> @@ -2086,6 +2088,9 @@ xfs_init_buftarg(
>>   	btp->bt_shrinker->scan_objects = xfs_buftarg_shrink_scan;
>>   	btp->bt_shrinker->private_data = btp;
>>   	shrinker_register(btp->bt_shrinker);
>> +
>> +	btp->bt_bdev_awu_min = awu_min;
>> +	btp->bt_bdev_awu_max = awu_max;
>>   	return 0;
>>   
>>   out_destroy_io_count:
>> @@ -2102,6 +2107,7 @@ xfs_alloc_buftarg(
>>   {
>>   	struct xfs_buftarg	*btp;
>>   	const struct dax_holder_operations *ops = NULL;
>> +	unsigned int awu_min = 0, awu_max = 0;
>>   
>>   #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
>>   	ops = &xfs_dax_holder_operations;
>> @@ -2115,6 +2121,13 @@ xfs_alloc_buftarg(
>>   	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
>>   					    mp, ops);
>>   
>> +	if (bdev_can_atomic_write(btp->bt_bdev)) {
>> +		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
>> +
>> +		awu_min = queue_atomic_write_unit_min_bytes(q);
>> +		awu_max = queue_atomic_write_unit_max_bytes(q);
>> +	}
>> +
>>   	/*
>>   	 * When allocating the buftargs we have not yet read the super block and
>>   	 * thus don't know the file system sector size yet.
>> @@ -2122,7 +2135,7 @@ xfs_alloc_buftarg(
>>   	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
>>   		goto error_free;
>>   	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
>> -			mp->m_super->s_id))
>> +			awu_min, awu_max, mp->m_super->s_id))
>>   		goto error_free;
> 
> Rather than passing this into the constructor and making the xmbuf code
> pass zeroes, why not set the awu values here in xfs_alloc_buftarg just
> before returning btp?

ok, I can do that instead.

Thanks,
John


