Return-Path: <linux-fsdevel+bounces-36860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295799E9FBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 20:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E1A1640ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF7198A01;
	Mon,  9 Dec 2024 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9Sg3prO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vc0A98u9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A414E2CC;
	Mon,  9 Dec 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772927; cv=fail; b=rX6/iRBwM26ltHoAsHFxAFbVSOhNALRYfK3ISb3pbwmnWuWaSF18gxGMB2Km+Q2Q6FBsVp4OcsYE7B60jLoUaeCvM9XXn4ixpxDovvTkJNYbKKNcuDfdCYyVpStAfXvQ55FLKZAiYTDkXbHPatfw7qJ7q9QT962VFdXZl58HmO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772927; c=relaxed/simple;
	bh=bKHzTCnxNDo0QuUWQWVXjs4Wnh9wHqkmLRwY3Ny/0UU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kCLQgGrPEhCESdHh4HPZpwVBIfvn+niKPMuNnkt3YHrnH1cJoApW3o789tVzo08xIpnJVR7fJmpEIXQBJoMkkQbBVOKOjqpEOsjLmTdHQqE1qebsh6ac0FXpieyfCAddgfsj25dj3yTPbZn96SExT/soKiUbycEEN+sx3XH6CRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9Sg3prO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vc0A98u9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IBnAs027062;
	Mon, 9 Dec 2024 19:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=d8TU2IsecQ1SI18Jff2BMZzItIWLLxBK+P8Gq+1Fno8=; b=
	m9Sg3prO2qd0530FJ4XCrTeOzWjHTmiUTGVsPQsvR2gLil7s7ENwWW0EhFTj/ei2
	E4uVazJ2WA6WNjp+7UCMoGrOpTcklvomJfygExTRUjwSwv7Ho7rLE/ZHMe6Lzw1m
	zwN24iCPrPPgkFd4fmezA2ntaf2GongrKruBBIvHmyc/kSwbCEMO/cxFkNpK+AEQ
	ulpnf5+84Di9aYwUAdCKZEHg/gcKUzl+gzGpBs7Fbz1qv7wqi/D3TXg4jzUOhnLL
	rEwS5nqbE8vvYyAMlFXVeAqPxtXJbdrGJrbme3EzH5+q0Ny5BY4vVUpDb5GpFA2g
	Q2uMWuAaelxYXA/S4tXu8w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy04455-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 19:35:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9JQ0Vu020583;
	Mon, 9 Dec 2024 19:35:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7be17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 19:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QESeI7D8Ryrt7TtaO6CAka5MU7yiG+x9zkEljgBejemhrbGazua4N1BhuDPdyu9bFKbCy+a6ipwslKGL3akAsQTTuWsshEE0xV6u7TMQT7GXE9aAUsLj06coizLNMm4fgNbWT1HYTHjV4o5UQGM63E9enSPS0FOR+Ih41sMncfnHm4/74G04IYlKoLmW/MddkG7DH0cAyCOLulN6GxEzfg14k1xil0YGdvIUpIxyIORK9zEpHhY82YBFdEUrTGu5HVWXpA3LOdENPFm0iajGpNptufQxnf4lFLfcDktBuhJpOM/y/4CQL7koai749G8EB25oMErYGW1QKZPHLel51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8TU2IsecQ1SI18Jff2BMZzItIWLLxBK+P8Gq+1Fno8=;
 b=j4tGIt1kgzDQkxMyVg2ARCFwtJMsfeB1e36/207rtK7oS4xEClMBaf2WfuIoomsSqQ3lNOlmCCrCYxmrfB51rDdUQldCuRKcoHAfeVPXNaz9UTvbc+9HHbtipaaxa/Eq3iAdm3VaJzUHNFjccpZ+y0oFcQtTU4fkDI6Zbi+l3k/RlZDuyQddOconZRgSr8590kH4N3PAQd85VrKQAilzQvhSoNRTrv7x/afoq1WYkrjt/r7xsXyJDYh85WzBPt34nA1jsGGylPLOTFTYsr2QrFjnhGn3yVRlFmgpjGyZtY5ysvtjXNlf1DLcOIy2C5mmcCjJp7Txiion/WrwRzZacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8TU2IsecQ1SI18Jff2BMZzItIWLLxBK+P8Gq+1Fno8=;
 b=vc0A98u9AFVK7PHVDNfdUIZ2+ObtQiJS5h5ZmmQCwFp3V6wQhjd2Gps14OPf8Hz3bJ7ShhdSAl2n6A16hxPuBqint9SXH73qI+rU5UpLAKYE5NjrjxnGkc+V6FztQWGWa5JmkJyhg8pAcDKKan+txUPKA8E/qm1BMT/nlidL3cI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5761.namprd10.prod.outlook.com (2603:10b6:303:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 19:35:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 19:35:08 +0000
Message-ID: <abc5b280-7d18-4438-851f-e333dd3e8361@oracle.com>
Date: Mon, 9 Dec 2024 14:35:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: disable generic duperemove tests for NFS and
 others
To: Christoph Hellwig <hch@infradead.org>
Cc: cel@kernel.org, Zorro Lang <zlang@redhat.com>,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
References: <20241208180718.930987-1-cel@kernel.org>
 <Z1b1d3AXTxNhunYj@infradead.org>
 <6dc5c09f-e1a2-4296-93d7-b2cda471a73f@oracle.com>
 <Z1cHpXAS0S8R6_g4@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z1cHpXAS0S8R6_g4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b01671b-02a2-4c50-21c8-08dd18889733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDZxQ3JsbVJQMFdWQUFNQnpCaDd3SWxLVlpqTG8wd3BtMEh3ak1hWlUxdEd2?=
 =?utf-8?B?TWZkSEoxcWtRN2kyRzU2K2VhWm5NRm9ucmdMYmtwNktQaTMyTzQ5aUlaMkNs?=
 =?utf-8?B?eGhRQjgrN2NKcE41MjhBeitGOGNnenZHVW1uTjQ1Z2ZqcjlxaHQ1TThlM1I4?=
 =?utf-8?B?dElMaCtic251c2x6dERGa0ljbXRwQUh5V2tadmNlbENDaTA0UE1KUFpBN3Zo?=
 =?utf-8?B?NUthZEpIRm9sQW9TNTcyZ0JIelNFZVUwTkdyVjdDQ2RkcFprV0Fqdkt6ZzN4?=
 =?utf-8?B?ZVRkN2ZQUUhhTnpieWFVdFVRb3VpZ0FIM0hYS0NoUEtrczVEZkdld2pNQkNs?=
 =?utf-8?B?QytLWUdvUjJKbERPOVdORFgzQ2hzQW13YTFDbkVlSGxrdGJqRklHN2VxRTk1?=
 =?utf-8?B?dW82OVR1OC8vb1hVN1J2WDllUFdLeHczNUdHWkJOU2k2V2ltOWR6cmFrUisz?=
 =?utf-8?B?Z2FPUlJkQkh0VEduZnJIQ0RIT0NxdGNOMk5lWjRtM3JxS053WVRDNThFWUY3?=
 =?utf-8?B?SlNJeXFKMTdGNzJrOWlVVXpMeGdoRVlmSExYcXZSSmRXYXROMVB1K1k5MkdM?=
 =?utf-8?B?aTdnNWUydjFCNHZXL2o0WnBvOUUvU2tFdno0RS9sd0l6Q3BqWDVwZzJwV01S?=
 =?utf-8?B?WlhFVVRGRjZ0TDk4VmtPbTB3ekZzbHhPWDk3Y2xxdjl2eGwwdWt6WWtOSDFL?=
 =?utf-8?B?RUdweGhWMXF2WHZCbUNTZ2J5T09Sc2JVM3dmc3RhcHM3M1VEVTZybmFYNTNL?=
 =?utf-8?B?ZzRxMy82bHJ5K0xGZlB5WEhRRG1ZZWhFejJtRDFuYXEwZHVaN0R5cmNybWpn?=
 =?utf-8?B?UlRYKzNWcDZlRHFONUJDZEpjWDNjTERsQVBnc3liOWtWaW8yWko3OWtRU3Fk?=
 =?utf-8?B?dXF4U28yR1JHcDlNdXhNcUcvZlNaNXZFa2M2WDZJOEZaVHd5YnZJVTBOT1Vl?=
 =?utf-8?B?ajd0SW9OVkdabEcxNXhrWHZaMEh6TUVULzQwaldvQWE2YWM1RWx6WW81OFlJ?=
 =?utf-8?B?Vi90aXpXK0dhNmx5ZVFYMmhhd2NNRGJLcTZkNU55aTJRYStJUCt1aXdab3Jq?=
 =?utf-8?B?QTlrSXNNaS9Md0RFdmxmWWNWTjdReG13UnoyN05oVTI4MjBRVnRpaGVoR0J2?=
 =?utf-8?B?dDZabVBaUXdUM2FoYkVENHJMYi9TN3hOY3JXYjU1anpnL3JUNTJmTmdnSmVx?=
 =?utf-8?B?NUppZUZBdWtMWlJTOFdQdGNqMXpWVWpUWG5YMzdsN04wVW53d1ZhNmJ0OVhU?=
 =?utf-8?B?RHR0OHIrMkNDeEI4dSsxNW5wdnBzTVpuWnFFNnUwWU9KelRCcjB1MmphT0NJ?=
 =?utf-8?B?aFhjaUpvRjZZTmVPNmZDVnF5T0ZZUFhReURXc1VQVWxnWHFZeS8xWnpMSi8x?=
 =?utf-8?B?WUo3eWR2THkxUnBPQ040TnVudklMUXBhV2Q1cWVQN0pnUExKZW1aVlB4NnJR?=
 =?utf-8?B?MUNZT1k2OEU0cUtoUG1GTWIzTXVDMjJ6VE9nUWVwc1ZCTk56RWlBRE1rUUxp?=
 =?utf-8?B?OTM3OXZrbVJPQytCeXFpc3VvdnhrekF0Uks1d0pZK2JmNE05SGx3c1p3Yys2?=
 =?utf-8?B?dXBzODVGYUlMY1lNTFpSamJFdDl6dVBFbUd6eng4VFJHV1IrakNVR2Zsdjcz?=
 =?utf-8?B?RGVkZXZyck9tblZ0L3RKckhSTTZWb0crRW5NTk8rN0dDNHlFSldsTVRoa2RU?=
 =?utf-8?B?aXpiVjdrcjk2R3FkdzRhaVNDSjZLejdZQ0pwT0FndWpid0hJMEFEa3JEd1lE?=
 =?utf-8?B?TVlkc3BGTHJVSi9BOWhBcDZuNzFSblZZZ0ZXWWxtN1lOK2hINE9QY1M2d1cy?=
 =?utf-8?Q?aM6S+BpQc8icMh0cN4w/UUVyB41Etl9K+Tzd4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWtrN0Y1Mkc4bkpORjFrenVmSjJzb3RjTWdDTDJ1SEZMRDYvQXJzYm04WUpy?=
 =?utf-8?B?UkgyMWRUelgvTTdFMmo5K1JRV2JzcDdPZFZjK01vUHJ0QW1naW9iLzV6QjRG?=
 =?utf-8?B?Q0Nwako3NGphZGNscUFOQmdxcTZZdzJFOHBVMkhTcGlTRFFJUkhqbzQrTWhw?=
 =?utf-8?B?cWM3QUtLUmtKTUlxM3draG80VnlHUHBqQjkzL0JldnBzU3JaQ2Y2c1dENCt1?=
 =?utf-8?B?NUJMemZUSHV3d0llZzlaeXM3QmQ4dlVPdlE3eTBQZ0tsSUdTY1BZb3R0aUla?=
 =?utf-8?B?RmJjVnhPQ05QSVQ1Zm10cTV3UWFTeDZlM3VGTWh0VlFZZEFkdUZiSVpwZGVB?=
 =?utf-8?B?akQ4aXltTlVkMGQrc3A4YTNpUEhzanlyRWphY2taNVFQTis1ek9NaUI5ZnB0?=
 =?utf-8?B?R3BRVUNhckdNTjkvUHdDelFZSHd1M2JXc3J0VkZUZ1hYbU1hWUlxRmhUQXJH?=
 =?utf-8?B?bXNSUnU1ZGg4d2hiYWVpbmcvb2lkTzAxeDBCaXRhbE9zU2ppZUdSUSttdGRE?=
 =?utf-8?B?cmd1VFBoemFIU2toM1ZHMG1hOTlrdVZ1T0F2RXJmdkRrbnZvUGZNaENGUXQ3?=
 =?utf-8?B?VFg5elVvVFFENjBrL3NDbmliRHJWa3FnL2xyOXdDajEzY0k3ZElxckszNWRt?=
 =?utf-8?B?ZFlvSUdBMTluS3NGUjhmRmxodTZSK3VmTy96aWU1dHpmTHJBZ2h5ZXAwUE40?=
 =?utf-8?B?L1ZTSTZMbVl4VnJ4a2M2cXN4QWlCRDRkbnp6aUdJZWlnTGs2aXVlam9PNlgr?=
 =?utf-8?B?M0hiMkw1RUxGdzVtbU9ReUtpWG5YWVNUNURYa0s2Z3FSeEhKNXkzdGd6Ullp?=
 =?utf-8?B?RmViWEMvOEFhOXRweFhPeUhBT2t1SjlaeG9vZmI1NTBkdG9mZno2K0hUSzkr?=
 =?utf-8?B?Q1dodmVPRG1FQ25LcXZwVGdiaGthWjR5VFp3Nkg3blFvMFE2ZW01bGlBaDda?=
 =?utf-8?B?d3FCVWN4eW5ublduVHFCSEFGdkdKczgzanQvMGtUcXBMVitXRTFMQmIyN2xE?=
 =?utf-8?B?dENpSFpEWWZVRTh3YStqWG1kbGxuRjRYYVlydTMvL3RXd042NDlpTXVvVjZ4?=
 =?utf-8?B?b1JiajJUN0M3Tjc4VlNySjFYek9GV0sxc3ZmUUhVaEhjVXRtVGdmMUVUSGp5?=
 =?utf-8?B?WjlyZFhtdHQyMjFBOU5lS1dtWjRsd0JPamV1UDlsTFJERE1NMFJZb1hYaTk0?=
 =?utf-8?B?b1dWSlhTdTRaUDY0aHN3aENiUWJUdjZma1hDOHZUdDBjSERKUkFpWWlWWHc3?=
 =?utf-8?B?eDMyTmJabEdwdGw2ME9LKytFaE1IZ2lyeThDVElBMVpOTkN6SXhjUW1mQlJw?=
 =?utf-8?B?OWkxNUJtcHFGSm9vbkFCWkdnUE03Sk5PRmJ5eUEwY05keUFPUnAxOHJ6L243?=
 =?utf-8?B?Sy9kN09VNWwySmlPRFNIRnl2UG9lTVIrSkY4WDc3MWJ3YThiWGZoSVUyTUVU?=
 =?utf-8?B?bmhLTVVwb2hSMTkzUnN1Ynp1emd1TmJmRjFEZXB3M2RjN244U0kyL2dCdXFS?=
 =?utf-8?B?dGw1S3ZhK0lleTRKemVCZEdJM0VpejJWL3gvYjR6RlExcEdkRjBxN3RsV29V?=
 =?utf-8?B?RlloSUx5cGNxMTRUWTRveVZkdS84WVF5QmducU9jdldhQXg3ZzZLYUxaZktW?=
 =?utf-8?B?bVRVZ3ZlVGlQQktmOEdCSkJZUCt2VnNZKzBQSnZ2Q0NYL29oTEg1MXFqRUhp?=
 =?utf-8?B?Yk1vVk5GRyt6QmUxN1NGdnpUc2NlUjI5NGMzT2ozYXk1MU5qM3B3ajZnaG5t?=
 =?utf-8?B?QUxQamJPSTVlaHg1blNYY3crczRvbDhlT0lyZmZJL0owWmxNWVo2YlJFV1Q0?=
 =?utf-8?B?dVZGTVRkbW96OG5xRWRseWNRVVEyL25DTGdxZDJNbWlaZjlBaFVLdWtxWjk5?=
 =?utf-8?B?elV1T0k0UFc3cW1aYXBYV1drVmt5dHVFMkZWZmhIWDhXZ2Fudm9OdmlvRXVR?=
 =?utf-8?B?WmVrMDFkWTZDVFpIeHpYK2QxRG9OTEx1Yy9WNkhuZVM5YkdKZXZwalFHQUFq?=
 =?utf-8?B?Mi9ZR2pWRGtvZlA5OGZYcWcrYk80ZVFPM2lrZmJ0V0N6Tm5jeWM4YVcvTzBB?=
 =?utf-8?B?YkErWWl4SW9kMmtPa2JUdTJVL3Z0Z0tuRW5HNWR4MUdXVjB3blZHZDlZZ3po?=
 =?utf-8?B?d05GamNTNTN1VFB4OXJWZXB4RDNNQUdodTlOM3Vha2w5cGEyNEFIQzNsNWFu?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eoe07oJHQkPD87ScZladU25ntkGlXD5UOd5MrxuoOYjd5O0Al6AoM0qUZtvNQhRoDxgCjzCsxCrj1vrRl4SO5H/etccMu1UN4lhw3E35Clb07ZoqFT1V+zjfXcbdHPg2ytKlkoDlgtl3//2Dp16VxhAtezOu4VGBUvc9y8lFMgYOoHYD5cI6GeIptxlZletLVAZfmWfk2UUSPxAEnQmcdriSbHpKV4vxs/q0bte6ZVTG2xZa0qlSTmiUiMoHqOg5tN3mIryuJKkKeBH7rG9ub655WWEyOtE8Z0X77/UezIbmrwQcM23Q5q9MV0g58mKN9ZyhHcQBpZ9n3nuU54jtsxM4Corwtt6adf1OCLMWeTGVIBdYeBX1uePJjL5RBU3ifsuJ1G+5QFqvgOa4jeXV2FEImO5mLOehdPfNy3HE9PHKErEn1aCMAP4ukEObFJez4fj9i7bvMz9nS1I3/THSUYc4tCm4+S9lyzFHEle+pWQ432N6vGp0PWag1Xa7W90IJALNtotnOc105p0DJTNCUeQXlIMhw0La4wGp/IjWuVK7tZHhDXzON0L1EJbMsOpHiurXVcXJgDmZHRbLrKtpvQiJs+/hUJycJFke279oP/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b01671b-02a2-4c50-21c8-08dd18889733
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:35:08.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5/v82rYLRPJ6TfgNiwcdQDw533TJ1TlB8kb00O5bdNVRayMYAnJySPidjkyjLHH4FF8PQUBJuj0r91ZerF34g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_16,2024-12-09_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090152
X-Proofpoint-GUID: p7hnHNXZArLvJE8bOhcwzSKGImGB2H0e
X-Proofpoint-ORIG-GUID: p7hnHNXZArLvJE8bOhcwzSKGImGB2H0e

On 12/9/24 10:07 AM, Christoph Hellwig wrote:
> On Mon, Dec 09, 2024 at 10:00:58AM -0500, Chuck Lever wrote:
>> 2. How to disable this test on filesystems (like NFS) where duperemove
>> is not supported or where the test is not meaningful. The current check
>> for the presence of the duperemove executable is IMO inadequate.
> 
> I've not looked at dupremove, but the name suggested it's de-duplicating
> and thus needs a working FIDEDUPERANGE ioctl.  So the test should check
> for that using the _require_test_dedupe / _require_scratch_dedupe
> helpers. generic/{559,560,561} do that, so something either in these
> helpers is probably broken given that NFS rejects remap_file_range
> with REMAP_FILE_DEDUP, although a bit of tracing would be useful if
> there actually is something broken in NFS or the VFS.

It doesn't appear to be an NFS problem; duperemove is not even issuing
the ioctl as a toe-test to see if it will work.

I opened https://github.com/markfasheh/duperemove/issues/363


-- 
Chuck Lever

