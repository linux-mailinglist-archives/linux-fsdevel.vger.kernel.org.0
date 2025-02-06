Return-Path: <linux-fsdevel+bounces-41040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF1A2A2FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D77B167945
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6C6226525;
	Thu,  6 Feb 2025 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Swhy0kp3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tPW2RhPd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0E226186;
	Thu,  6 Feb 2025 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738829443; cv=fail; b=e4yKdfiz9EhPawLa5+pi3+SxK/biKV3zRjJBNlwI4qFCJRpuODBHSjBJtxLJX0afZKrxUCEIWX+4l5NWTQn+0DgZDBzhu4qtF+WWfSlF388Qtj5ZXWlQAvyJUx5O+JrIMKttn77IL7zT5rF9ykw0wkGbKJ1zu2clwsYWsRmvK58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738829443; c=relaxed/simple;
	bh=MfvmhrANA+bEmcg5ypDyFz11OfEpOu5G1Od/1JpCl/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K1Hq+TCvgCVxCKTVmabJNVw+0hKucx47RNkknR/tNyKGaVIuPxKOEwvLsueBwXv5TAAfomEQY25KxaD1piIgXGudJBc0DQJ/P+mr+r7z37S7eHErChFHIkRhgxRR8bfRlpgRSGNlvMuOrHxNgj1Wg1VcmbarTy/1Kz3OtG1i2Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Swhy0kp3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tPW2RhPd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161gRGx003813;
	Thu, 6 Feb 2025 08:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zbQmlWW0AWdsmGLCotiXP9BCeu8JaUi9gRdkvfnZK5o=; b=
	Swhy0kp3qtkNeZZIk25MJqeqXig9agg9FQAYsiaECuI4YQQV5PfATxLz+Mx8hlPX
	RpYG5nLX7m/lUFCz6eUjUvI0SsPylCR3y4VzvX5bRkQ7mDSELPXLGeD5ex0Kpga6
	QoJe7pH3UHZAQnlC4h6NR6Wr7lt+N+BouIajEua+Gq/U/wF4VfxzdDxH9iUTZwrO
	PTkq3kUwSrM1gnIsFyRr7Xh2lBlok3N+eHr5loTt9NmgKz+dvOm5+6tltUQMaIWt
	1L8C8S9O7MpKNbNeTkt+kTSstWufCjd3llNkIcG1J8knfjlKYHR8dguIFokzwVwL
	CBti/MxG0Klhziq0cdLXaA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kckxmqdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 08:10:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51665rPH022584;
	Thu, 6 Feb 2025 08:10:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ea6amw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 08:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fap6DlNzfTQkjeNHXQdSmMbaeBY66pyo0wo30dw8fHNzt0cisexSv2Q7LruImxj85WyiURMjW6i78JIhk3NwSUGFRGdHbiok+fbo4Vn8tJOWAeGC4TZk0VKLYZWh1oHjt2X0efDZzgD19oZsRBn0nvrVP42nRBib9Niam9oook6U48RbwuwHRQ+kfKS1ewXSHi7wBKnc1VcHCz5iOek3IMffpt2wfJBqnqR91bIcXfAHYAHLCswAaiz+6TMKjcZMejxFhQ73VW8AWvLyRgfQ5lMEcdlGmjyVLm2nDTI3tJR6Xopx9Keoktca8NIJ5dD7NEEUpo08ivqiOXozXaD8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbQmlWW0AWdsmGLCotiXP9BCeu8JaUi9gRdkvfnZK5o=;
 b=NfYR0Ar+Dq0LTh/y/Qcfi343/fFA71k084RjCpTwKANMUZAiUV3bwKwY1OsZCtnBi6FgO5Z50UB4EID2hka3UbBJGIr59o0zjMl9U7wjdCjgCCgggnS/JoLpXGL8JoSwyUAeBJLAgUSgPaILE3YxazHGx2NtHn59XgGn+VhJWIbvV4FXj7E4TahgILHvjDvNJDkDji98PGNHZrcA9nRUmD883sc6cpuaU21SitBZ3Jtr75BST3iQwOvTq4SxwdU73FL3WjvgnOXqXPE8VGTNW1qUUgMCoHInWnEvsM55zA6UYc6HI9e/hJXwunTRzAioH8vE+h4YZl2JdEY9UTYh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbQmlWW0AWdsmGLCotiXP9BCeu8JaUi9gRdkvfnZK5o=;
 b=tPW2RhPdZNhefchhWHW6rUqIebE0mZOIy+0o8awj8wDf3SkWoJYvW2xs5KFzbzrD5vwKTYj17D0ioZVqEjYT2VRW40c9WnFQwNs0ZR1yN5oPltq/462qGngbjDvKd/rg6Hn1jVhcfN3EOGxdsrSTvZKzgcLJdpsRUZE4KdJWHlU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5164.namprd10.prod.outlook.com (2603:10b6:610:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 08:10:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 08:10:27 +0000
Message-ID: <0bcd5bee-132f-417b-b77c-64b80e007c72@oracle.com>
Date: Thu, 6 Feb 2025 08:10:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/10] xfs: Allow block allocator to take an alignment
 hint
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-11-john.g.garry@oracle.com>
 <20250205192039.GU21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250205192039.GU21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 74496118-bde5-455d-21db-08dd4685b72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3BWanZ3S2QzTUozSlBrdzFJMlk5S094YitwaHBCbHhma20rWEE4TTM2VGhE?=
 =?utf-8?B?RWl2enBsK0Q1UFBIbER0RmJIT293NzZOSTcvcmdydXZQcmhJMEVLTkxBZkJR?=
 =?utf-8?B?U3RLeU9ZbDhHNGpYckV1eXNSR0tBWmI0dGZ4T3B5b1FBVW1uYmM3SzJyVzZa?=
 =?utf-8?B?V04wd3pkcmJFMHZzdjJhQmZnVkhYeFhHTDhReDhaT21DYmJ0elNlQWgzUUIy?=
 =?utf-8?B?N09hUWFNSUFibWdVL0wzWStPUnMzQWNTd004a1R0OTE4WDMxTzY0RG9SaVFq?=
 =?utf-8?B?RnZ6bGRXdTJTNnp2QWl1S2R2QmFURFlqU1NDblRoTWZkbE1GK2hJTTRoVm5O?=
 =?utf-8?B?R0xNVFNiVjRTaWQwRVFSaUJESjdxQjFiUFVjU21waHo3K3Z4NUxlS1V6dllm?=
 =?utf-8?B?T0hqRG4xc0VjSDNweFkyZFJ2QkcwVSswYkFJRm1vbkpyQkV6UVM3bTVidmFV?=
 =?utf-8?B?OFdrR3NiK1AxcXVGeHlkODh2R1NYeWdSVS9MU21rUXk0WEFsWDk3RUI3WTdH?=
 =?utf-8?B?QyttMllqOTVoa1BJblhQMWNzMThiK05XeFVma1lkZjRFN1pLQVlWWlVLL0hp?=
 =?utf-8?B?WnBDS0kzNW56bEsxM1ppMG50ZksrcFQ4V251V0RkSmh3L2ZmejJPVzRBaUFZ?=
 =?utf-8?B?Yk1LZ1kwaklqTUl1RThYVlU4SVdkT0tBWm5SQXpCTGtvQmhUWWxjYjJ6aCtF?=
 =?utf-8?B?eGV3cTN5ZjdIaFkyblNBNThRQ21DcEVEendyY0lhMWExcHp1bVhuRGFzUkNM?=
 =?utf-8?B?ZVlQV3JlMzA1THd6QzhiT09rN3dJVWExVVNQQXFQMUxWWGxWSU4xZHdZZGtB?=
 =?utf-8?B?VDB4ZDVwUmNzZEFWRHRwWlpYR283MS9YeDFIb3E4UCtndXVwcUdOc01FZ1Bu?=
 =?utf-8?B?NjA4YTR6YjhseStaUTZ0ZVdScm9McHlaNUZQM0QyZG9rNXpLdXZEVjdJaXpW?=
 =?utf-8?B?U2FoSWp3cjNySUZqS0RoMGdJZTFGcFFTYVJaTHZ1ZzRJaHloRXFZVklCTXpT?=
 =?utf-8?B?SnBnTE5FZmQ2bWtiRjhzL3JFVUNjZ2tZVEtNYXF0dUZSOXFKWjBUZEVxTjR1?=
 =?utf-8?B?Nk93eENIa04xVlBHaDdHRjN5cEt1TVdNMW9FcHMvUTlualptTHVRSGpQbERH?=
 =?utf-8?B?UkduZTI5SVVIanBjK0YvTjlodk04UnIzQWtLbGhuMksyaGh5dzJ1cXMwQlls?=
 =?utf-8?B?c1FVY1VTaTcxT0lFUisxRnVTc3UvYThRbmUxRVFYUWd6dUpacDFxRG5tOTQ3?=
 =?utf-8?B?N2FNYS9wSFB2VmtzVUZwL1BrOEJmaFNSTi9rbU1tbzNlSzZXZVQwOXBvdHBn?=
 =?utf-8?B?MDdBTzhaZ2RIYkFMakw0RXFFV1hsQy9XSmtqYU9TT1ArSVZUWHVweEZsUUZV?=
 =?utf-8?B?Q2xUN2tJNldLUGxjNUtxLzIrRDNycW81VHdvcG9QV3ZhdllsWTZwWFBzWjJI?=
 =?utf-8?B?eFFpM1NYT08wK2J0RW0vN1dZQ1AzWi80ayt1RnpqaTIwUjQzaENIaWhVYmZU?=
 =?utf-8?B?U1Jtd1hHbmpGLzhuZ0dVMXZEK3luYWQzYnF2QXlMZnZRMDJDVFpoQ3ZwblZX?=
 =?utf-8?B?L2FBUzUxZitvbE1KT2xHMG9VckY1Rm05aTBRMGNqbTNBZEF2K2QvQ2FLeElx?=
 =?utf-8?B?aVlxUnNUMTJyZFd6Lzd1SjY2WkJBVWxpQWFybk1CNGhwNlhhYlhTcU4zQUZJ?=
 =?utf-8?B?blhNSjR4MjZySEN3U3RnSzFmWkdPUEVVdzlpU1hnU0FTcXRHZFRGZWhBVFgz?=
 =?utf-8?B?cUkwaTExbW5JeXFsQnFabFZnTmpIeHZUT3dONnU3YVlEQ3hiR1MvOGJVZS9Z?=
 =?utf-8?B?SDd0L2phM21OOW41RW1HUzU3Z1JGRmVHSnN1RmFrWDk4OHFIc0xmTkNZYlZY?=
 =?utf-8?Q?JUVHeSZbQX3h/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGxURzNpRmw5dFZnNlZVYisxMkc5V1NsaEcveitWUXg3RHBFSkY2OXdtaHRL?=
 =?utf-8?B?OVc5ZUxLMDhRdnZ6cC90TWYyMHI2VXFVNldFbjdHSHB2d0JHanlKRXU3T3NP?=
 =?utf-8?B?VmJ3UXhkWDZHQ0d2RkhPdzR3Qk5GejhHb2YzaDBmSG94aWJ2OGYrK0REcEhW?=
 =?utf-8?B?SDVaTXc1ekJTblk3dysrYVlIQzBrZkV5MFRZWDI0ckxiWnRmajZucHd6Y0U2?=
 =?utf-8?B?RktwY3ZFL3hVVmFCb2VNemdSVFZCVEJpbWh0T3hoZVNJVnB4dG5WU3E3SnpB?=
 =?utf-8?B?eXlFWkZDYU41ODdaMTlvUU44aUVKTFdXanBDdmZDSk0xdjRWdzNldW1VZG5m?=
 =?utf-8?B?c2R2bnNMbWFqMGRzd0NOWi81TEJ2eFp5QmZiN211T2dFdTFZZEdBdW91Sk54?=
 =?utf-8?B?NExXLy9sUnloMldRVVJhL2dBYjRBQW5FclBveXdNdG1kRHBsNmJrNm8wU3By?=
 =?utf-8?B?aU8xVTl0ekZDcnYvczV0ZCtkZ0c5QmtRZUx5VmtPdlFKQkVYOFYxeGdVcVlh?=
 =?utf-8?B?bmdUV0NpVG1IaE5EWTgzVldOUDlEc2ttc3RKc1IzQ0hHbkFEdncxTnV6K3F2?=
 =?utf-8?B?d1ZhZUxjSnNGa2VYcmZlUE5LKzZFaHJWQUlvOW93TkR5K1NXeTlRelVyU3FZ?=
 =?utf-8?B?VzVwSHBvQmVUUGVYdjQ2Y2hLK0VDdndLT2s2LzlqeTN3MGkzWjVoNnhJNUhm?=
 =?utf-8?B?WGhzUWR4aVNIVURCTE5DV0pjMXlvRmZhKzR4U3RpSk1vSGdBSW1UdkplNE4x?=
 =?utf-8?B?Y0N4ZnVvdDgwSitxdnN5dUt3SWdRL2w4RVByQ0lmbE5oUnFqVFZIWGZUZGlr?=
 =?utf-8?B?WXIzYmZGeUlxVG9KYVF3aXFVdHBhK0o5ak5MNm1QTTBvdmVhcTk4aWd6SkNq?=
 =?utf-8?B?ZGVuUGs3aGdUMHBDSVY3MS82cEtoS2RWY0R4QnBvMTRrNllRdzlWZElMQncr?=
 =?utf-8?B?Z1crWUd3ZHNVbkY3aStUeUdNSmxvWFdFMmwxRFd2SVJXQVVyenRwOGhBTnhC?=
 =?utf-8?B?YjZGcm41K3RQd3dnMXlzenQ2dDZnQVFERVBJeUZKbFlHbkFFYi9mclpWQlI1?=
 =?utf-8?B?dEhMTE04T2c4alhQK25rOVZXWndtanlHMXM5NElyZVZSTm9pWGNLaWt5dENz?=
 =?utf-8?B?V1ZMMzRMOFo1eTJ2SmJpR2ZyOU1RNE9DVjN2MDdydkFyaGx1L1ZKSms0UlJn?=
 =?utf-8?B?eDRMTkc4UnVBcy9FUDQ1R1lLYVdaSTJDRXV3bk1zTnErVjZydjdSbytKMmR4?=
 =?utf-8?B?cHVYbVNaSTFJUHorQzFaVTlqaS9rUnh1Mkpsbk9YMkp2OStySDB1N3E4TjBT?=
 =?utf-8?B?VGJ2ZHUyRXF1akN0SjJ6M2srMVY4MmVqa1R2OHhJbUF5bklXMFBieDZZRWl3?=
 =?utf-8?B?MXo3YXZ4WFZlRFJJWkk2SmxpalJyREROOWpyNll3ZWMxNVU1Rkx6K3pDUm52?=
 =?utf-8?B?NXU1RE5ld2RzbUY4ZkRFTWxrbjQxSGI0YXZOSjV1cVR3TEVXU25INFVneitz?=
 =?utf-8?B?U01taEh1VllHdzkySjAvRTlBNy9Va3JNVEY3ZzdITjA5SXY3Yi95NXIrbG05?=
 =?utf-8?B?bm1zWHJRTDZHZkFlditiVlhEeDFFbmFKNStjYitQNjFscStDWkl5QXJhQzdN?=
 =?utf-8?B?aVFucjBHVDFuN01BUVZIM1NGMDlEUER1R2V3RnJna0RXdm1qUjh1U1IrMmF2?=
 =?utf-8?B?VFNMK29yNklMTExlOE5vNEZUb3FaWVFOTFZYMFpMTklmUldlQXhma0VvMVUx?=
 =?utf-8?B?N3RxaHZZRnAvb0U3aFV1UDE2REdxMjVUTmZvR1ROeXd2VElkQW1nVlEyTVNB?=
 =?utf-8?B?QjhGd3pjNGw3K1JLSW1QNUdNUEErNGcxbWYyQ1pXdW5VMnQ1UXZxdmxtVkV5?=
 =?utf-8?B?N1Y4Mldaelk2Y0RnMHBSMnlrQkRFT3lUQlFObUNSWUhGQit1ZlFRbWxUYmE2?=
 =?utf-8?B?eEgvUXJmWjdtcXg3ODljeEk1OTJFV0NDdWo3Nkl2QmtCdnRmcDR3N1VCbVgv?=
 =?utf-8?B?Q09BL1o2dFpQRDdTaDl1Q1hheUxsd1ZpOXBTRUhGaGpNUC9wcHQzZ0RvTXFk?=
 =?utf-8?B?T0hSTmZHN2FMRTBDQjBXaEM0c2grQkFjUk1SVXMxOU5yNmtyMnViRCtUUitt?=
 =?utf-8?B?OVdmTTZ6Q1d2LzRpdGpsRitIck9zV09pS3liVWg4anJFeUd0TXhhMkNzSzI2?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wXy7CyL00MNqNbhFLGfXqYVTqmYFri69xaSZrsnlQjJSmuFCJp8TJq820/76MMjmLdTr/YDHXsDDY/cQVj59nCO9rbnjtYZnIrLpKYse6I1TU71vYygqptrEw2iKMWOlh/bjEGPY2sWVKEMMOSvMCVtH7ZMWRb+gdZRoUj4uTSuPslz/NXSjpwKOh/VZOckmYKTxtv5kusG31U6ZXz/5rkxR7VH9fs/f4FL4ycJuLvBtVXLwxsATzWQpJHdL8YamgzD1ziIM3gV5xDrpSU28s6rLpfrgp6Qn4qhZn3WCC8UdsHtpBvNxeJvdK5uW05g7yMXx/tuN/fFDpTTFJ/9ClpHNttxv0oCf9t8WyWdcHiRfvFBRFAJxKF6l0qVrEjkLEtTXRdl2y+PydziAGN/yK+xiEGsKbjplrtfqlNXarB44PbF9RC3agxyaYv4qWKcowXOgdTadm0Kpz8FssBg/qcz4y5n9C1h3Qi2UX3WafieH7vEc16OCnJxzfCPAXUuziGleKLbtx6uSTtqrkMobnxAvNy6ztyTdeRW/1KD4j0KO94eLfPLYQGYRc2h+6rrxe9F0cQEWTVojR8l4PfQ2Pd8cSBqMIkC54rJKTHLwgqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74496118-bde5-455d-21db-08dd4685b72d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 08:10:27.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXG08WyWj+JAj9I0cL3Voa5FjWuML/Rgp8P3hjH37jTXKa7qeUes1Zx66MTjZ07feYIlBTfei4xvDNNGlAk9gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5164
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502060066
X-Proofpoint-GUID: gP6MhOzTnBLSBZv1PhWXQMg1uZ63upH5
X-Proofpoint-ORIG-GUID: gP6MhOzTnBLSBZv1PhWXQMg1uZ63upH5

On 05/02/2025 19:20, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 12:01:27PM +0000, John Garry wrote:
>> When issuing an atomic write by the CoW method, give the block allocator a
>> hint to naturally align the data blocks.
>>
>> This means that we have a better chance to issuing the atomic write via
>> HW offload next time.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
>>   fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
>>   fs/xfs/xfs_reflink.c     | 8 ++++++--
>>   3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index 40ad22fb808b..7a3910018dee 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
>>   		align = xfs_get_cowextsz_hint(ap->ip);
>>   	else if (ap->datatype & XFS_ALLOC_USERDATA)
>>   		align = xfs_get_extsz_hint(ap->ip);
>> +
>> +	if (align > 1 && ap->flags & XFS_BMAPI_NALIGN)
>> +		args->alignment = align;
>> +	else
>> +		args->alignment = 1;
>> +
>>   	if (align) {
>>   		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>>   					ap->eof, 0, ap->conv, &ap->offset,
>> @@ -3781,7 +3787,6 @@ xfs_bmap_btalloc(
>>   		.wasdel		= ap->wasdel,
>>   		.resv		= XFS_AG_RESV_NONE,
>>   		.datatype	= ap->datatype,
>> -		.alignment	= 1,
>>   		.minalignslop	= 0,
>>   	};
>>   	xfs_fileoff_t		orig_offset;
>> diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
>> index 4b721d935994..d68b594c3fa2 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.h
>> +++ b/fs/xfs/libxfs/xfs_bmap.h
>> @@ -87,6 +87,9 @@ struct xfs_bmalloca {
>>   /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
>>   #define XFS_BMAPI_NORMAP	(1u << 10)
>>   
>> +/* Try to naturally align allocations */
>> +#define XFS_BMAPI_NALIGN	(1u << 11)
>> +
>>   #define XFS_BMAPI_FLAGS \
>>   	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
>>   	{ XFS_BMAPI_METADATA,	"METADATA" }, \
>> @@ -98,7 +101,8 @@ struct xfs_bmalloca {
>>   	{ XFS_BMAPI_REMAP,	"REMAP" }, \
>>   	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
>>   	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
>> -	{ XFS_BMAPI_NORMAP,	"NORMAP" }
>> +	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
>> +	{ XFS_BMAPI_NALIGN,	"NALIGN" }
> 
> Tihs isn't really "naturally" aligned, is it?  It really means "try to
> align allocations to the extent size hint", which isn't required to be a
> power of two.

Sure, so I would expect that the user will set extsize/cowextsize 
according to the size what we want to do atomics for, and we can align 
to that. I don't think that it makes a difference that either extsize 
isn't mandated to be a power-of-2.

So then I should rename to XFS_BMAPI_EXTSZALIGN or something like that - ok?

Thanks,
John


> 
> --D
> 
>>   
>>   
>>   static inline int xfs_bmapi_aflag(int w)
>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>> index 60c986300faa..198fb5372f10 100644
>> --- a/fs/xfs/xfs_reflink.c
>> +++ b/fs/xfs/xfs_reflink.c
>> @@ -445,6 +445,11 @@ xfs_reflink_fill_cow_hole(
>>   	int			nimaps;
>>   	int			error;
>>   	bool			found;
>> +	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
>> +					XFS_BMAPI_PREALLOC;
>> +
>> +	if (atomic)
>> +		bmapi_flags |= XFS_BMAPI_NALIGN;
>>   
>>   	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
>>   		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
>> @@ -478,8 +483,7 @@ xfs_reflink_fill_cow_hole(
>>   	/* Allocate the entire reservation as unwritten blocks. */
>>   	nimaps = 1;
>>   	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
>> -			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
>> -			&nimaps);
>> +			bmapi_flags, 0, cmap, &nimaps);
>>   	if (error)
>>   		goto out_trans_cancel;
>>   
>> -- 
>> 2.31.1
>>
>>


