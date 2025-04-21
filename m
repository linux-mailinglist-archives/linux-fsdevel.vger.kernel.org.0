Return-Path: <linux-fsdevel+bounces-46783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D61A94C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 07:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED213ABFED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 05:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0F2580F6;
	Mon, 21 Apr 2025 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W4GbmFO7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qhb+IeTt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B02F50F;
	Mon, 21 Apr 2025 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214489; cv=fail; b=kmLvzfyncubLxtchrBFjxyYPNSJ1aW2OAzz28HjO4M/bvA9AT70H3n2b2sZ7RN8+qn4enmQytZDEY9sIO+2b7GFT1+DMvEkdNlED7ZhVzlsPWPmveuIzBwr2eGwqMwkl5aNhwd/426NnRzscPk9GkVQkBxiMX87rltXu4aOY8Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214489; c=relaxed/simple;
	bh=F8JElVvaMytYD/ueEuBu8KwPfPEKEatqjzgtfRex/iY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRhW7cU+A/CrDYo3ahffaRKIYirNMViOk3G3CLV+GbhfA67rFOwPBUANUZAmtyKqZqm/kZ2smzHaoFcXg1rEevedbQiP3Y57+dl7Hb2vQVwaQT9Zmh1kHb6fzZmB0aa3BIh3kRUQTR+vZYpmiKZUa3w2vHTFjSgdXz1VHUyJNlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W4GbmFO7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qhb+IeTt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53L1DD52009122;
	Mon, 21 Apr 2025 05:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lKP5elIcZGj/k6AWSwzcvGlx4f2/zopxPcOcaVbqKvU=; b=
	W4GbmFO7ob1Lw8jsetlgq5TgZM2M5OYthBwaaV8PKR14zCxk4rMSJKWgJoLMe98w
	ihFZgHI52C1eb/4OgPn6/wYtd3iypMQU3Oi5gnpD1SgOCk2aJylSn5gq9UhnTMfD
	d9VgqkYn7UHf5lnscq/M8CA62CevuVDenbXFMDI2CoS/qmboQ6TbqkKvGPBsQ3GQ
	on/mS5IunAK5953yaO0BP8P0C7B9TZtnauhQhgYzWGiuK8yxykiVeQg3gsZKqred
	hstGi4cHy4gL7HMkq5CmPRPruqMNElYNk/bxSS9dxayJaYw0mv9Y+3TC07fZ/eOq
	WyYShLF6yTOoLP/dpmcHLg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643es9w29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 05:47:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53L4do9f021414;
	Mon, 21 Apr 2025 05:47:53 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011027.outbound.protection.outlook.com [40.93.14.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46429e599c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 05:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7KkPaoSsvwoL9qYLZWCfXCFb5NhWMFzmJ0McSL6mM5FG8X/2kuDePF2Datkjbu0h8J1iPvcoLp3xEoUXWqImhvvj06HjT3ZX2Q1eB2chcfkuw8pxf9TBbtX0O7o3NOZHooNWya9NbxKyzIcV1l42sl5IMRJKVzmbS+kkazoetxgPIniWxI9y8DFyFcGBEExM8jGoGSc3RL7faawWTIuX8vKqeaB7gsTubovhJ6zl6gWiJzov++oReWAXzGtG85KFWYzydHYIRUxb4pCdTbeO/dy7Ku2CvgIgN41Icu1vw28fJDyb4LcqH6GzYdGwV8qf1OC71R16l5Cf8CRGDWnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKP5elIcZGj/k6AWSwzcvGlx4f2/zopxPcOcaVbqKvU=;
 b=w/T57RDRL7SCOgX55uEc8KzCDmV16UIRqNbbgWPIfECjxEGHVprA+x4AC+JxMNHCmtKLEa5la6P9jnvmhkUnK2JoB07SdnjswVAdZkCSZUL/oi496b7CK47DHBZsJDZZ8JsDrmAwi3FWfvsdkEIr+c1wy8nocnnc05BOCl6ErYHHYnO9vqoVVadUL5KFn/+xrwJCGsSLTrjWdKMQfC4M7wQIDyG/A1CECONTDUJpReQ54SDpJ8HTOuMMvNP48zyAQNcRHU0KC8SeQXLRpD8vYFcrx1LiYID8euqC+996Udm6U9O39JnXHqiMBn53SjNiJlLPN0QWjgTCqbTUtw+F2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKP5elIcZGj/k6AWSwzcvGlx4f2/zopxPcOcaVbqKvU=;
 b=qhb+IeTtdxCztzOeoqCMd1nJ7srvaB1T84KNa8hPkRwYE44ogOJggfHyi8rvqYHHAZb6Esim/DQcT+g/aHTfdCYZFvwvBxJBBuVCqGegLuAGt1sqttx3IV+9KllyyEaUv5goyWE1KYdJL8Jb7aJoy81B+y7qHCPxim8LdDXJwbY=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8562.namprd10.prod.outlook.com (2603:10b6:208:57a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Mon, 21 Apr
 2025 05:47:48 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%7]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 05:47:48 +0000
Message-ID: <2467484b-382b-47c2-ae70-4a41d63cf4fc@oracle.com>
Date: Mon, 21 Apr 2025 06:47:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <20250421040002.GU25675@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250421040002.GU25675@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: aa67fcdf-b5ea-4b0d-9f40-08dd80980bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzBVdFZEcFFaV2NUZnVyWlFpek56OVFUK0xJNUtQRENCYW5KaDhRTU5YTFV6?=
 =?utf-8?B?Z3d6QWlmNEsyZ2hlRUJyZUlUTGgxazFEQWNQMC9JckFIWGwxL2RBSWxMUk9Q?=
 =?utf-8?B?a2tUTklYSUNtbFlrMmlMUEtBaHpMY0xYVndOK05YQmlmQW84dDFlakF1dkNl?=
 =?utf-8?B?NnZlZlI2a05Ec0NoK051MUFOdzF2TUlaQ2V0Qzk3RTlwcVhFTFk3dlQxUnI1?=
 =?utf-8?B?dmRxdXpMV2t3UmIxSTZDY0FEOXNBSXZNaXUvWGwzaitzWE45VUJFZ1c1QjM1?=
 =?utf-8?B?Z01MYk1QWmwrQ0tsRnlNcTNtclVTVWQ3Y2JKZ1pvS3VmZWE3ZW8vVkFwUDJh?=
 =?utf-8?B?YVpQcS9pT3dwa3c4aHJBWVJHTE1GQjdhS1NTZWhISEVjSEt6L3NKRkxVdmEz?=
 =?utf-8?B?c25HU2ZZMmNmWk9LNE5kMzdaYytPWm52Sm95RStpQUkzNzAyTElYUjdWcEQz?=
 =?utf-8?B?VFlwOUhTUjdjR2ZJRDlRb0hoZXFFSXoraFYwOXZDcHVPajBPUkFhdlhPMlJS?=
 =?utf-8?B?UVRZNm1xM1hQQy9vZFpBNmw4VmRHTHIwT2hYWWdZS0hBNFk4ZGJ2R2FLK3JG?=
 =?utf-8?B?MjlBVWJFVVJLSzlZTHJuS1luMk9jNkduc0xBa1FRMWdhTENmcFc4eVMzVWhQ?=
 =?utf-8?B?bVV2cTQ1eVdzd2lyMzBiY1l3S3BCL0ptcnZKTW9tOXNjQ2ljODQreWZ2Tm5q?=
 =?utf-8?B?QUgrc1gzMmtWWDlIZkNxTFpjNXBiVno5M1VndzRxMFgwS1c0NmFyZEFic1ll?=
 =?utf-8?B?ai9zb3djSEJ3Ny8xY2xBM0Z5N24wZzdacXpnS1p5TzY5bXVQaGd3S01aVHp1?=
 =?utf-8?B?QXpUT1MvYVlaZ1RpOW44SDBuMTRWaUtzRmNld2YxVERPNDd4ZER2a3ZrSGtU?=
 =?utf-8?B?alFqUGRuOGRhNytCSmxNR28wUFZqSlN6bTNaS09seGRsUVlwNXlBOEFxdXJa?=
 =?utf-8?B?QXJDVlljTzJKRjdZYXh4TDdLODdoUlpGd3BNTi91Mm93SnlNd0RGVHpwa1JF?=
 =?utf-8?B?cjNQODF6UWc2RzdvdVlhM0RCK21wYjhON1E5WkpuTnhXWmlOYjc3RXd4NllD?=
 =?utf-8?B?OFNhb211Z25mYW41MnNNMW1XV0M0QVBqSWhiN0lEakc1NlZBdmh4YTNsQVpP?=
 =?utf-8?B?WnVrZVdmYnptS3JtaXd0VmhEUElxRjViUUpQOUhxTjIyWFJiU3M4M1QrM3NH?=
 =?utf-8?B?bTFSYVY1N3hWaHpsMm8zQlErM1ZGZndvTGZWTlZLVXlQRStiNFlJOEhnZGtr?=
 =?utf-8?B?SEdiQzBWb2tpS0NYaTVGcy9jVlhyWlV5MThFZEF1cjBjN0hneEdvUWV3RzZN?=
 =?utf-8?B?VmJiVFAvK3lMaEtURkFMTHV0YlFEbWswcHU5NVp5T0pBcTQxaGwyNkJ6blRl?=
 =?utf-8?B?b3ZkMUdIeWJwNG14NDltc2IwelFsY2djK0NuVWNTRXdhZXZkak4vUlFlamhW?=
 =?utf-8?B?VTdPbnpHK1QweUJuaGlva2ZqRCtxcnhQK3R1dTRIYUVxYmNKK2xOanNydVZY?=
 =?utf-8?B?NWVxK3ViQUpLNXYwZEc5YStJRjE3ckR4TTRuZzg3ZWQ0NDhTSGdQWkNNVXRJ?=
 =?utf-8?B?amlJc0orV1J1L0w3WW5lb3lzaVE1cEVFSWV5YXNoZUFUYmhkN2w0SEszTWVm?=
 =?utf-8?B?S2FZamR4SHFnYXE0eEpRV2llalREdTQ4Y2I1dzRBYXR2UWxWamI2M3NyaENK?=
 =?utf-8?B?OGIvdzNkTC9PbXljbUtiSXRkMFE2ZC8vM2hyUXVLbU91aHNKTUYzOGpyMjlB?=
 =?utf-8?B?STdqbTVIa2R2d0tRR1NaSVlkSmM0TFRndmMvRE8xUVVMbVYxbmRwNUMxbWVr?=
 =?utf-8?B?MGFHcWUzOXBxTEJjWTJJc0xwTGxsN0hKdEFVVU45ZTFPQnNUL0tHSjBKMjZn?=
 =?utf-8?B?SFZzenVOVEszRkpEbE5icHozTFloUWFqREtyVmppcmNBWXQ4ZlZ0UHRFSGVB?=
 =?utf-8?Q?Q/X+ZlIDlog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVJvSms3a2pxMlR6emhxeHZVeC85UW1VS0tMU0hrSzJidWwrOVNES1NqSlhR?=
 =?utf-8?B?Wm5pTkw0enBmTXVKQmk3cUtYVEFlM2V6ME9rbVpQbi9EWThoZ2RYaXRpQWlo?=
 =?utf-8?B?aS9nckpseGlXYzNISHY0OHRUMFZOdGgrUzY3MlhrRmFVWVQrWnJIQmhCZXc1?=
 =?utf-8?B?UjNsd0UvKzQ0SVc2eWp3OXdkQUhVNTAxQmlYWkNPT0FYTjhwMmF0cEJOQm5n?=
 =?utf-8?B?TWZJNUFqNnRTSnpuTzZrLytBT1FyV1dMUXRyZFNxUkVWb2dKZXJlVWhVenRl?=
 =?utf-8?B?ZW5QTG9ZRE11TDZ1WEwvTTRaMklDMWsxbmo0aDZiOXRFTlRJZjlRVUxXTDhu?=
 =?utf-8?B?TmQ2Q0RVb1RSWHRpdnlRZXh4d2dFaytpTzhxMG9DM0EyV25kQzhUa2thRzB5?=
 =?utf-8?B?N0FreGNTV1FTS1BQaG5mcDJxcmJOcjhsWURVY0MzSlQzNjRHM3pZaDhvYWVz?=
 =?utf-8?B?Zk9lc3VKaDh2ZVhIQzkwUDQrMGlvYVpPay9ORU9FUnJVU3Q1L3E1dU84eHJE?=
 =?utf-8?B?OXJ2alBwSktwZitQMjBpSHRObnU2UTFZdEtPYVFycjVnZUZ6T1lRakd6MVgr?=
 =?utf-8?B?cjhvTHhTeDVJL01uM2NscXVpaVhEbzV4K3k0NUY0a2FHNERReDVNcUpmZHR5?=
 =?utf-8?B?YnFFd0RzVTJJeFVMZ1ZiRWwrOXRrS1NJNXZqVjFTVjZ2VkZHTVAwZm1VanBV?=
 =?utf-8?B?WnFvQWZQRXBIVGFlNXBScWV0YnhUT3U5aGI3M2FicUVhcEJNbk8yNFdiZURx?=
 =?utf-8?B?eE4xOE1tVUIwS1BzdUsxRlhaMEJDcDYwVGtFTFZpNnpTNlFNZk9udlRkMkND?=
 =?utf-8?B?NjRycDZqL3dWWUtjRi9BanlOZW5EbU1BTlBDMnN4NlNHUzNRVU5MeDdoTGgx?=
 =?utf-8?B?ZU56S2lOamlSMWlseFdERG9FL1U1R1dzOGw4bmIvMFZoaHNWLzY1eHljWnc4?=
 =?utf-8?B?OXVReGtISzdlS3J3RDlySDRKY1Flc0JoZnNZdjZ2cElVZGc1NlVOd0FsYmNP?=
 =?utf-8?B?MUxQMlc1MTM4a2lWRUxXckliMFRYUmcrU1ZXL0kwR1d6ZWRSczVHcnBiNU1G?=
 =?utf-8?B?TVNyVVl6NlZzZVh6NUY0b0NLSi9wZ0gvcGdCQy9VWXczcVZERXNnTXUyN1c5?=
 =?utf-8?B?NkpkZkFWL2dvSGZtcXZRcmNaNllHV1FMbGprdk1lZnRQVXdKbndRank0UnRV?=
 =?utf-8?B?RlBvRXVBMSs5TGFlejZjNnZmc2swQXNpUXM4L0FETklIQnF0Z1BnTmJrYWd4?=
 =?utf-8?B?QlhXYUpaQ29RUVJwUlhXRWd4RUlNV0FmRFJLZGtxZXN4Q21OM3VCY0VaMEs4?=
 =?utf-8?B?QytuRjFDK3NGODNFVVJJYVhteUM0MDEwWndMWXZSM1JKOURUTDZ4SnpyVTVv?=
 =?utf-8?B?U3VyamVzVnBEMGRFRXdBYm1QVU1HWVB1WFFKY3RDTi9EQkFLV1NOeWE4WDRJ?=
 =?utf-8?B?d29uSFhFc29ncDVJeGpHZERLdzE4WFh4S1dyTnhWMEgxaGNxdTRHTjdWbS83?=
 =?utf-8?B?Nit1YWltTFVmMUNzc2hxdUhTU2oxNGZBUHhCK05wZDdTSDdtL2pyc1puVjZ1?=
 =?utf-8?B?amxtM3ZLY2w4YmFKSnEwbTdCQ3V1ZlBpN2xIRnJaNncyK0d1dWNWbkpzd0h5?=
 =?utf-8?B?eVlqTmdtVlV6TE5SUXRneW9YSDhSbmRGM0t5QXNqVDVUNnJDbVFLU1UrVEpu?=
 =?utf-8?B?UXRwdm1uT0pCcEsvNDVmOCt1NkhITUZLelUrOVdCQ20xdGpjSHBYVXZKQk93?=
 =?utf-8?B?M2JiT3I0VXlXRVBPRlhwTHM1NHRpY3BMUU5vK0k2TTlHT1pQMzlqTzlaaUpW?=
 =?utf-8?B?NWpsM0FnUktVVjZtTzVLaEs0cGFyMExidVB1S2l3MVlHQzdzT3RxbUhQdXh3?=
 =?utf-8?B?cWRkaUVVVzNRSnlJNitBUGtXQ21lcDB5U3RmYlFiaTFPaE5uODcybDhGZjA3?=
 =?utf-8?B?aDZZVUFPNWxPQmNLVWxleFBFL0p0cy92QlpRb0lYUHJhVVdRTlZnZ1dhNW9M?=
 =?utf-8?B?aXhKT2tPWFJObnBrcDRqY01BdkdnRmZFMHEwdW1mNkFycGNNSkZOY21tZXZ0?=
 =?utf-8?B?VXhqVll3OXZtdjMxeWdmNExUK3BvNklYVUlKUmFqd0txYXduVnlOSVFFQVRI?=
 =?utf-8?B?SXArWVpkUi9iQ2FPaGNwaFkwTk9TdjMydzY0RTRyd2ttTzJlVEd6UUY1NU5x?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IX5bKjvas2Qz+6ZVai24pVmdMot0dNfpuasVTQEndMHM2j8oFI6uVINNloRI0XbSD90ZdZPlCUWNeV6qN7qdGSLmFt0oTuEpmB6QQNY6l1OoqWFE9yGynCrY/8jQWBJggARniP5O4xGEONyNK/CSWHNS0kuyT5QBSnIwrwt8T4L3viM6cmTSkyFxQl/hk9P4jS5rgD+0X6wgz1tps4c2tvDzHXjYmpV7I4Nw8g1eh5pr8CYmeCF48ibtBJx24KCfhSUWPy5v9hJoquorhnnN5iXw8hOjUz8FDDj+InA3yCs/WMYQHxYhTTvs56WH4nRr4t4pJkKqOSE97WCP2kVA/FLvm3DsPpU8D8rxfMMtV5IeRur5bm4divRsnuIruskZwDfpUAEpsAePMHd5Lu3D+AFYEkbKLFCbEAFjriXfUjiQ3E4+uitH49x3PR06Ph660lonBLDuMMeCIIoJiTR6ccAyuGAWJWXIZA9fDrlsHu0Y22lyQp3or859ZEaC2tuqNVuW9lvlhDjlb7F1Thws9perAed996iGecfoePL60/Obuu9HZ2M4tA9jgnUMIjgpfzDcWSn3bR8a0dnpv+qhbODsy/zaWqPHtK7ymdllQyI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa67fcdf-b5ea-4b0d-9f40-08dd80980bf1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:47:48.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcD7Bpf2EHcWbTWZVGLd38hRbnZQ2npdt39OquhisXBDJ4REXp4yWSQmU5JvtRW6Wf5FVYQIb4xGIIoD4u6FNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=794 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210043
X-Proofpoint-GUID: rP8NaGazG9vjRS_SYRS6tc-rcuHiJ8uV
X-Proofpoint-ORIG-GUID: rP8NaGazG9vjRS_SYRS6tc-rcuHiJ8uV

On 21/04/2025 05:00, Darrick J. Wong wrote:
>> @@ -843,6 +909,8 @@ xfs_file_dio_write(
>>   		return xfs_file_dio_write_unaligned(ip, iocb, from);
>>   	if (xfs_is_zoned_inode(ip))
>>   		return xfs_file_dio_write_zoned(ip, iocb, from);
> What happens to an IOCB_ATOMIC write to a zoned file?  I think the
> ioend for an atomic write to a zoned file involves a similar change as
> an outofplace atomic write to a file (one big transaction to absorb
> all the mapping changes) but I don't think the zoned code quite does
> that...?

Correct. For now, I don't think that we should try to support zoned 
device atomic writes. However we don't have proper checks for this. How 
about adding a xfs_has_zoned() check in xfs_get_atomic_write_{min, max, 
opt}()?

Thanks,
John

