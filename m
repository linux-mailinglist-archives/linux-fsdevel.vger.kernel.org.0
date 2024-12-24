Return-Path: <linux-fsdevel+bounces-38104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F397D9FBFEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 17:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B0C1884C05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6171D89FA;
	Tue, 24 Dec 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FwwzmPzO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S7oVbLMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5A1D63DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735056651; cv=fail; b=gqdn4VuvHalCPzjyGmemSGQHRZn9oDBXal4c8Aj8KNrlTQvLeIDaTdozl0b4NyDz9ZGPlOOmUNoAA8Z0lrkpO1F39DQgwYkX/DwdSa+GiRGRjWe7Q7eZWj4TKdTNLqz8O5scw4kaN9RYwy+hvy2gPbuFsDw7BxXqGbfRt8V/XLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735056651; c=relaxed/simple;
	bh=r43TO/5swRPOqsAVw+PcXxqhdYDQSczfewTm3PdtC6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B45uXgBqSPy/3vy2KJQlbaJPVs0FUPadOm0UuQMNojfwrQrRKUh8gCfAIjy75RnIPM2FxjX7WORrwIr/b+jlZmnkQT33+bk4s/BWtiry94Y1KEBQyC2lC+pPA+6wFay0LsyEYvoPfGGJyhT9a34OqB9X8wNr3Bl4QiQawzLURWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FwwzmPzO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S7oVbLMV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfdfx017788;
	Tue, 24 Dec 2024 16:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=P9WlDUgmUK4+wasMfyBIWre9r24M2KaET9IP85293nE=; b=
	FwwzmPzOhWtKpP58M1uTvN7S631z99zRP1E5ImpT3b7LS6VAz2iSmgQfS+9IVW2V
	7+RFPRA3BHk521ubFJf2RQ7MbO8tZjqDaknz35YyxXPTMjjZ8vSotQ09b7cHn1dv
	svE1IwvUqR9+ra4Zj+D/oHl8OIg4wjFxc1XQHPmw1F05wXdIls4OUT4Ow7wAWw0F
	tTbdtId+xVHsPxp5H84AG0T+oWbZ433DHb4/FXgwZOUhcFWlPBagw4nRoByoEFkW
	G4OsV2N6yLlIK8ormHCn+9RZtcCnC74cJmY7oqUIVFMxvngIJ8PfnvlmL0HtK4JO
	TuP5GffAw+4Qmdn9xKp4JA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq9ycfr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 16:10:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEBYMH016580;
	Tue, 24 Dec 2024 16:10:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4ecvnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Dec 2024 16:10:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTfztmJk1v0x/bbZY/q3HDX1ucTeB8kfkNN3erh+3SHBjJEHUivaiIdsp9mLqpRYIuEZ9rM7bi2CU5mSvUP9YUL/DV7UP3i+dKdHZ86QXwrFCBmkFqMdPEa6nUGsM7GIwCpDZLdnlPpDAtS1GIrn66AVq18JL2qx2P9blaV+o4toPmm0SccL+kuARBulKZB8JgO+4RqC8QwRZOV0WNXglpVND6qWkM+6qjQT2UKKrzpA7pLWHo1cvr/WbsRTwj5iX4XjB00OQtFdHaQ2XpfbyyngpEXXwMl1cf0CG2XqmiUann+15adVWUdsZf+9sTra/0COgLS77D+TVFcRfwHaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9WlDUgmUK4+wasMfyBIWre9r24M2KaET9IP85293nE=;
 b=a4+5fkDGvL84vEX7F/S4bffKEsJP1Njg9oJfrYnQGQY1cOc68d88KYpFEqGxO0z6VaibPmz3l8Oip6b0H8zqpeUKyAhRry3HjB1IV+NydeDua6vV2l3pIaeJ1k0jPqz3tgU3SwKl40dqAeQzEQjdJPzyGjPQNvY/eI9TOVZln8nRVCnmo22xeHMNhIX79+VpHiinqidL7r3KDnD8LqLPg+5kaFd6krulDJ35DRop0eZzhfUPmCQrYjh90SF8CartShz/jWZT8Dv4ww7x85vAy0mChtot8Bh+TdIJd2AG0i4fLsCaaRBRCmP5ajvquxUfiF6Ms5y5VLiRW2bwfbwpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9WlDUgmUK4+wasMfyBIWre9r24M2KaET9IP85293nE=;
 b=S7oVbLMVIwVWj9s02S7v1sRKNhkRaEp4sZYg5E5NwJIv9bLIk3+QWciN64GCbfx65y7DLSf6UuGwf+IoohbK1ogSa+a16Owu02XmOkihT/AAHgLY24oCVLUvA3WX47ixfpTwMb8x0tzouCSnDMpvRA+IJYNgE6th+Yx6Hb7MsOo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6883.namprd10.prod.outlook.com (2603:10b6:610:151::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Tue, 24 Dec
 2024 16:10:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 16:10:19 +0000
Message-ID: <7df73ed4-e54a-4e45-b8ac-f25df583acd6@oracle.com>
Date: Tue, 24 Dec 2024 11:10:18 -0500
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
 <71bbbf23-361b-4461-9739-ede4f120c982@oracle.com>
 <75a58251-27b7-9309-cb2a-e614dc29cb49@huaweicloud.com>
 <6dac6b48-c5ef-452c-fb75-84c7be587089@huaweicloud.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6dac6b48-c5ef-452c-fb75-84c7be587089@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0055.namprd14.prod.outlook.com
 (2603:10b6:610:56::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d72094-01e9-402e-04d3-08dd2435765c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkcrOVJ4S1BDZjJHLytjSWRnUHlaakpJeTl1VUpuaXpXNmRNcmQzdE5FVE1m?=
 =?utf-8?B?MWg2NWhQcGpBSXhvZ1VidEU5QWdTK29qSTRoNHE5dUEzZ1ZPMExiTG0xKzZ6?=
 =?utf-8?B?T1BwMzdzTkRTZ3YrazAxOFZtNi96SmkrSmdRNDhNbWtGWDlmTHRaOFcrdE1a?=
 =?utf-8?B?SkhRY05DYXMrNjdVWnpDMWdRbmw4TzI5TWhrVXllK0pNSzkzVXhRQmhLUmF2?=
 =?utf-8?B?SGVVdXlHOWpHWDc5QkNPVW80THhTWjJWUjhiN3pmanp4RGJCREUvVlhKM2hC?=
 =?utf-8?B?Q0NLV2lGNGdDS0pNbnNFanZlc1lWRWxMRkl1SGkwbDNlWndjVUUzMm11czJr?=
 =?utf-8?B?V2RWSHJLcHN2RStuSWIzTm9lWVFiUTZveTFlZzBodGZ0RWRacHpYRzkvNFNi?=
 =?utf-8?B?TVluNTB2NXpIeXJuRkY3bU54bi90TUwwM01JbnlhSWZtbTdOU3lxL05mdjVX?=
 =?utf-8?B?WGxMbm44eW1VSUwvN3dPN1NWK01HdFZXdFFtTmJFTjhkSm1YUzRNeVc3U2Rz?=
 =?utf-8?B?ZFNkcUlHTGZkRGxzMVR2MXZVamt1Z0NFcEo4Zm8wdk5WSGQ1VEoyTUtvWEJn?=
 =?utf-8?B?YUFOeElINjduendSNXgzbHhKMzJIa2dQZUR6YUF4cjdER2lSSU92c2laWUkv?=
 =?utf-8?B?QWRqQWhGMmFMbVNTK2RuTnR2cTR2aTUwMTNKM2dnazFwcUpkcHJQRUhUTTlj?=
 =?utf-8?B?L2szbzBKSDRsWThpd25tRWVSbnAxZVJRZUs4eTY2ZUZLKzdUeVRJbkFad0ds?=
 =?utf-8?B?V0k0eEJTMGpvbDFSRmNVM3BqNkRLNWJCMGdFbDZxdXRDK1N6WDlkbmlmMy9w?=
 =?utf-8?B?K3BWZ0FTTXN1Nks2T3o2Q2hQZ1o1c0Q4ZkNrOFhXYmd0S253eEpkMU9IRjNU?=
 =?utf-8?B?U0U4MHF1eXhWSlByR3UyQVdRU2dyaS9zNnBRUVZmL01YQkVOZW8xN3FTTFRa?=
 =?utf-8?B?dGtlK0lhSEF5SXloZSttdmVKVVRBYjhyOUI3Nm1lNVRSYzV6Y1lzLzI5MHp3?=
 =?utf-8?B?eCt4Ulp2bk8ra0s0amp5YUQ4V2taQUFkeW5vK3NEYkFrRWs4YjluQ0ZWTEtE?=
 =?utf-8?B?OU0yNkVSQ2pOd3lEQ256bDFNemNpVThHcFd4aHYvbVJneDNMc2ZIeG5BOTVh?=
 =?utf-8?B?SWo2Z0dBVEFTWUtJMklPVUEzQkpKQmhHK2tqazh3SlFHb3Z5N1IvOVVCUGw4?=
 =?utf-8?B?RWw1bHB4Q3VQQzJnUFlucTJrbVk2eDRqL1NPQy9nZGJpT3BYMkJ0Uy82Ynlt?=
 =?utf-8?B?K0tUT1g4Nm51RmlFVzdoTHA3YXArRUhPNmhYNWo2cTVXVEEzSzMybHp6Y1Jp?=
 =?utf-8?B?d3BQNjR5RUxaeUQxRHhETEIyM20vZ1hBa2hPL0hORDN2Vk5JeEcrZDhxaW5X?=
 =?utf-8?B?aFFmWDFVUmttTVcrZ2ltRXRnRXRITXl6SkpXMmFWQzlkK1V5REVlTVQrMnVy?=
 =?utf-8?B?VyszVk9abTREN0pkaGd4bysrYW5ZeG1wMnRkQ25wajkzRy9KOTFsY2piT0Iv?=
 =?utf-8?B?MXdjSS9oZy96VGZIa0dYcUxnTTFpU2RNSHZ3Vm5VaUdDbWppNzFrbVQ5a3pr?=
 =?utf-8?B?SzgzdmJ3NUNkcU5XNFpDb09ReGdhU1pHcmpwb1RmaGQzRm9pMytGc1dWVW5n?=
 =?utf-8?B?QXhUZ3BoMS85UXpmSVlucTUxVFVxVWduMUZvZmNuWTMvaGZmTWpRMVFjeDZr?=
 =?utf-8?B?bWduL1F4bWE3enJxZmJLa1lzclVVdVVrTFRCSFUzenFsaGYrTi9DVi93ZmZ1?=
 =?utf-8?B?YzNZU1RYV2Q1MHA0N1JBR0F1d1JYdlFGRXZzSjJ3VURia1hTdzAzRVJ4ZFRK?=
 =?utf-8?B?NHNxdllwQUdGZkdTSWd6ZzdQcUNEVCsrd0ZYcnc5aUVLZVJzUlRvVkhZYkJm?=
 =?utf-8?Q?zF2G8Y59OAe0Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTBOWTlkT3hEQWF1TUpoMEVyOUVob2ZvdFdoZWozbStzTm1EeXNoM0w2N2pZ?=
 =?utf-8?B?SHJPcmZZbURRQWdzd3hUa05STnRJVEU5VlFnZXJvTmVUa3dQVFNaaG55eVBY?=
 =?utf-8?B?Z3hvdmdYdSsrS3pVOUtNbDdOSnFDSWNFalVIc1lSWlFPVnVyTEZkQUsybXEx?=
 =?utf-8?B?Sjd5aEdxOE90b2tTQ0JuUWNJYkdBek1HVzBnSGduSXpWSWhZdDlRNkhKSHg4?=
 =?utf-8?B?OHBEMTVKNVZEV3QwY1ZkRWJha2tHSzNYRUs1SFYvcHMwYmRIR0NFMDRqSWJQ?=
 =?utf-8?B?TXlkalJ5NHpubFVOTnY0UktUYzJOVm9GU3F6VTB6MFJvRmJ4S2NnSWNjV1Zi?=
 =?utf-8?B?VjZyaEY0MWVaWmhUMTM3bUtVTFUzSTB3L0ZTdytLRVNRekZ1TU9TWjdlTGRw?=
 =?utf-8?B?ckZlUzVDMElkTGI4T21kSjlRaFpwTzlRQ1R2bDNPQjAwd1ZybmE2M0JCVDBX?=
 =?utf-8?B?b3hxbGFYSVQzQnZHU0lTU0RkcFo0aSsyUFF2RG5vNGdQbzdVWUUrUFNBQlc0?=
 =?utf-8?B?WWhQR2c3R2Vva0ljRDc5T2VmV1hTV1F3UFJpZnlyVVFDOHNsYm14R2hyM3dP?=
 =?utf-8?B?RVpRckszZFZzMzNNdmF4WTlad2szQS9ZUmpJQXBBTGlHKzVaQ01GZ3o5YWE4?=
 =?utf-8?B?Wi9yY2s0VE9WTlU4RWJGOVZHNFFvVVRQRjJLT1JveStzZFAzVHRhc3NQMklL?=
 =?utf-8?B?T0FIdlVyVUdkcXAxWW5uT0hCeXRFTjcwWWhUanBtWEo2aFBxTURGRFc4QmZB?=
 =?utf-8?B?NzZxQmJabjJSRC81MnFyVmZObzdSdzVEMk9wVzJveFFpcWd6OXR2Y0duMXJl?=
 =?utf-8?B?OVE4cXVjNS9nU3ZyZU9Xekx5NHZBRGptMnFMZ2NyWWh6UFVRMkQzV0FWZFNr?=
 =?utf-8?B?UlAzRGJsQWlLZWMxTHpnUGNkMVVzWDNGSldyTDJlWDFES0ZYd29qZDBKak1v?=
 =?utf-8?B?MEFXKzRyZzMrQ0dsREFoMnBsRmdDaVMyTFdSQmQ0bnA1WWxpOUVwekhxc3Zm?=
 =?utf-8?B?S3krajVHUHo4angwdmJPMS96elpIKzdzT0M1WkJvQXRWTms0cmR6WU96eHVy?=
 =?utf-8?B?Ujc1MHB0TXR3WkpnSlpXbFY5WVcwSXRlUGpJVHR1ZHdLUmZKOW85M3BlQ3A1?=
 =?utf-8?B?b21OREwxU2l1Q0dzS0dPdGdqTjVjTlBOOXVCRnhCVlQ2U2VvU2tPRmNJUnpn?=
 =?utf-8?B?eVQrOW55WTBrTHZ6TU9GWUh6SUJnTnRSTm9PMUZvb1I1QmRJMW5yRFF3U3h2?=
 =?utf-8?B?VUVuRWpJS2tvYjdzUXNnVjBjbEJnWDFpMnRXNTZSeUtETlljZmNnbHpsS3NT?=
 =?utf-8?B?eDlCMytNOGN4M21MRjBFbUFxNDFhMTJFWi9SNjdjMXBHaVpnS0J6YTJhaTNq?=
 =?utf-8?B?MXVpaFVPaVNuZFpOWUx1eHhEWjJveWtxazdKYW5IVW94MWh0bTcwOWo4TlpB?=
 =?utf-8?B?dnFHanNvb2RxZ2c5a2lHbHhSdEJBUXcyU2RTNDdrbGp6V25PZVNZYlJsTUlD?=
 =?utf-8?B?emo1eTlHSHBlSGlhSDY5YnUrU1pqRGM3bFlGVkFkaTY5R2k3WStKbERYVDkx?=
 =?utf-8?B?Z05JUFZ4Sm1TRG5DYW81cFF0ZUxzZ2tpdzdaTkprUXpEWk1IQythZXJGakh6?=
 =?utf-8?B?NHlrdE83aXA1L0l0QVozR0hPeVJvbjdpM3czYUdSSkR6Q1Z2MC85UjMxa2Qy?=
 =?utf-8?B?b3YvL1MvRnRmTHZ2NExQYWRkZDdwUzl3enRhT3F4YXZSZEpDMWtacU1ReWhz?=
 =?utf-8?B?Rk55S25zR1V1RGpEQkxlc1BCTEtMaTg5b3ZEZWNEMTA0UXNFenlMZW9tbS8x?=
 =?utf-8?B?YXZlL1FYeFJ3aWp5c0FQaDQxeDgvb0hma2VmL1lEWDZ3U2NpWlJmaDNvenlZ?=
 =?utf-8?B?SE9jNDZ0R2l3U2ZramdRdWZPd2RRN1B4MHhiN1NnQXNTYysrbUl5SThrUm45?=
 =?utf-8?B?bDNrcUdVRG5YNUptVVR3djY3WkVLRno0blNNUkR6SjhJZnJEbzVMTDBOajhy?=
 =?utf-8?B?UHR2RFl3VVN1SlZ4aUtmMHdXbGFhblk2YlR2bHR5RFM4S1hpdGdqOFpUWHJu?=
 =?utf-8?B?VG80WWZuR0VDTUVzdmZDeE1uTTU2ODBIdC8wV2pyOGt5TGI3VGpIc2hiaVdo?=
 =?utf-8?Q?LedmcLgXUybIuIRWt/D8++EqJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KrEJ36WrY5yfYuQCRJu1GDs+QXgHZjmIqJ1dHc31icfnolTPLUMi7tEfFgkKZST2vojGxIowHlqBGYgEu3koCOg+0rDFGMUuMv8JV5iKYXp288/EyShwLnBM91j6RE+WdRyfFLbx45khgI+KyuJ/zl2c6j1OjW+JKLU0BHfhaR8DOY0x5Z4i/Pxqm4rO3emu7JoUC7qRhxY06Lts1eaQgg5EZdN2JUixisDBWv/5aHLwmUQa0ChgYM45jiXO+9TY2PNCOjTn92KXzzJE4a8k5TyvLaeMOHFdPQxjBGuOR0wEqk32OLl3xaShtC4MdkJBAlHTg77spWbM3Q3YrtiAdEutRmeowFOH1SYFjq3Cqhy6PPeibffvmt+3tszWYWi18jFD1bBCcqHIHDDScJb5vYBvTFV3mPYq8i6bSMyuKoUwm///xdy18s3o0AQRaZLnvuLb+thxE5WZeTQewl/ISIQ2mvoiTjLSaSFkg/9oB5PfD5oCM7coAUalOwUZRVu4SGIQnIUHEQoQHY7ptGvoMWEZLWNDLIaNNovhVLdzC1oglYznqNv8nPlkuktGWEG/6sx2MfYt8bNMk9cWGsGNdxZX/WIypRv+de22f/V0Ucs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d72094-01e9-402e-04d3-08dd2435765c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 16:10:19.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQmZa6doCXcGwXCiEXyFCiH/GUoq9ub8/NmRimjzMMJXYSW+TH10ScgF0RZI8D1hQ7TwzCibPxY3KP9/4O/2gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240140
X-Proofpoint-GUID: yZgkvrbWCm59bfeYkneCKkGTG3kQ-h20
X-Proofpoint-ORIG-GUID: yZgkvrbWCm59bfeYkneCKkGTG3kQ-h20

On 12/24/24 9:00 AM, yangerkun wrote:
> 
> 
> 在 2024/12/24 21:57, yangerkun 写道:
>>
>>
>> 在 2024/12/24 21:52, Chuck Lever 写道:
>>> On 12/23/24 11:40 PM, yangerkun wrote:
>>>>
>>>>
>>>> 在 2024/12/23 22:44, Chuck Lever 写道:
>>>>> On 12/23/24 9:21 AM, yangerkun wrote:
>>>>>>
>>>>>>
>>>>>> 在 2024/12/20 23:33, cel@kernel.org 写道:
>>>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>
>>>>>>> The mtree mechanism has been effective at creating directory offsets
>>>>>>> that are stable over multiple opendir instances. However, it has not
>>>>>>> been able to handle the subtleties of renames that are concurrent
>>>>>>> with readdir.
>>>>>>>
>>>>>>> Instead of using the mtree to emit entries in the order of their
>>>>>>> offset values, use it only to map incoming ctx->pos to a starting
>>>>>>> entry. Then use the directory's d_children list, which is already
>>>>>>> maintained properly by the dcache, to find the next child to emit.
>>>>>>>
>>>>>>> One of the sneaky things about this is that when the mtree-allocated
>>>>>>> offset value wraps (which is very rare), looking up ctx->pos++ is
>>>>>>> not going to find the next entry; it will return NULL. Instead, by
>>>>>>> following the d_children list, the offset values can appear in any
>>>>>>> order but all of the entries in the directory will be visited
>>>>>>> eventually.
>>>>>>>
>>>>>>> Note also that the readdir() is guaranteed to reach the tail of this
>>>>>>> list. Entries are added only at the head of d_children, and readdir
>>>>>>> walks from its current position in that list towards its tail.
>>>>>>>
>>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>>> ---
>>>>>>>   fs/libfs.c | 84 ++++++++++++++++++++++++++++++++++++ 
>>>>>>> +-----------------
>>>>>>>   1 file changed, 58 insertions(+), 26 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/libfs.c b/fs/libfs.c
>>>>>>> index 5c56783c03a5..f7ead02062ad 100644
>>>>>>> --- a/fs/libfs.c
>>>>>>> +++ b/fs/libfs.c
>>>>>>> @@ -247,12 +247,13 @@ EXPORT_SYMBOL(simple_dir_inode_operations);
>>>>>>>   /* simple_offset_add() allocation range */
>>>>>>>   enum {
>>>>>>> -    DIR_OFFSET_MIN        = 2,
>>>>>>> +    DIR_OFFSET_MIN        = 3,
>>>>>>>       DIR_OFFSET_MAX        = LONG_MAX - 1,
>>>>>>>   };
>>>>>>>   /* simple_offset_add() never assigns these to a dentry */
>>>>>>>   enum {
>>>>>>> +    DIR_OFFSET_FIRST    = 2,        /* Find first real entry */
>>>>>>>       DIR_OFFSET_EOD        = LONG_MAX,    /* Marks EOD */
>>>>>>>   };
>>>>>>> @@ -458,51 +459,82 @@ static loff_t offset_dir_llseek(struct file 
>>>>>>> *file, loff_t offset, int whence)
>>>>>>>       return vfs_setpos(file, offset, LONG_MAX);
>>>>>>>   }
>>>>>>> -static struct dentry *offset_find_next(struct offset_ctx *octx, 
>>>>>>> loff_t offset)
>>>>>>> +static struct dentry *find_positive_dentry(struct dentry *parent,
>>>>>>> +                       struct dentry *dentry,
>>>>>>> +                       bool next)
>>>>>>>   {
>>>>>>> -    MA_STATE(mas, &octx->mt, offset, offset);
>>>>>>> +    struct dentry *found = NULL;
>>>>>>> +
>>>>>>> +    spin_lock(&parent->d_lock);
>>>>>>> +    if (next)
>>>>>>> +        dentry = d_next_sibling(dentry);
>>>>>>> +    else if (!dentry)
>>>>>>> +        dentry = d_first_child(parent);
>>>>>>> +    hlist_for_each_entry_from(dentry, d_sib) {
>>>>>>> +        if (!simple_positive(dentry))
>>>>>>> +            continue;
>>>>>>> +        spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>>>>>>> +        if (simple_positive(dentry))
>>>>>>> +            found = dget_dlock(dentry);
>>>>>>> +        spin_unlock(&dentry->d_lock);
>>>>>>> +        if (likely(found))
>>>>>>> +            break;
>>>>>>> +    }
>>>>>>> +    spin_unlock(&parent->d_lock);
>>>>>>> +    return found;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static noinline_for_stack struct dentry *
>>>>>>> +offset_dir_lookup(struct dentry *parent, loff_t offset)
>>>>>>> +{
>>>>>>> +    struct inode *inode = d_inode(parent);
>>>>>>> +    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>>>>>>       struct dentry *child, *found = NULL;
>>>>>>> -    rcu_read_lock();
>>>>>>> -    child = mas_find(&mas, DIR_OFFSET_MAX);
>>>>>>> -    if (!child)
>>>>>>> -        goto out;
>>>>>>> -    spin_lock(&child->d_lock);
>>>>>>> -    if (simple_positive(child))
>>>>>>> -        found = dget_dlock(child);
>>>>>>> -    spin_unlock(&child->d_lock);
>>>>>>> -out:
>>>>>>> -    rcu_read_unlock();
>>>>>>> +    MA_STATE(mas, &octx->mt, offset, offset);
>>>>>>> +
>>>>>>> +    if (offset == DIR_OFFSET_FIRST)
>>>>>>> +        found = find_positive_dentry(parent, NULL, false);
>>>>>>> +    else {
>>>>>>> +        rcu_read_lock();
>>>>>>> +        child = mas_find(&mas, DIR_OFFSET_MAX);
>>>>>>
>>>>>> Can this child be NULL?
>>>>>
>>>>> Yes, this mas_find() call can return NULL. find_positive_dentry() 
>>>>> should
>>>>> then return NULL. Kind of subtle.
>>>>>
>>>>>
>>>>>> Like we delete some file after first readdir, maybe we should 
>>>>>> break here, or we may rescan all dentry and return them to 
>>>>>> userspace again?
>>>>>
>>>>> You mean to deal with the case where the "next" entry has an offset
>>>>> that is lower than @offset? mas_find() will return the entry in the
>>>>> tree that is "at or after" mas->index.
>>>>>
>>>>> I'm not sure either "break" or returning repeats is safe. But, now 
>>>>> that
>>>>> you point it out, this function probably does need additional logic to
>>>>> deal with the offset wrap case.
>>>>>
>>>>> But since this logic already exists here, IMO it is reasonable to 
>>>>> leave
>>>>> that to be addressed by a subsequent patch. So far there aren't any
>>>>> regression test failures that warn of a user-visible problem the 
>>>>> way it
>>>>> is now.
>>>>
>>>> Sorry for the confusing, the case I am talking is something like below:
>>>>
>>>> mkdir /tmp/dir && cd /tmp/dir
>>>> touch file1 # offset is 3
>>>> touch file2 # offset is 4
>>>> touch file3 # offset is 5
>>>> touch file4 # offset is 6
>>>> touch file5 # offset is 7
>>>> first readdir and get file5 file4 file3 file2 #ctx->pos is 3, which
>>>> means we will get file1 for second readdir
>>>>
>>>> unlink file1 # can not get entry for ctx->pos == 3
>>>>
>>>> second readdir # offset_dir_lookup will use mas_find but return NULL,
>>>> and we will get file5 file4 file3 file2 again?
>>>
>>> After this patch, directory entries are reported in descending
>>> cookie order. Therefore, should this patch replace the mas_find() call
>>> with mas_find_rev() ?
>>
>> Emm... The reason that why readdir report file with descending cookie
>> order is d_alloc will insert child dentry to the list head of
>> &parent->d_subdirs, and find_positive_dentry will get child in order. So
>> it seems this won't work?
> 
> I prefer this is not a problem since dcache_readdir already report dir 
> with this order.

I'm experimenting with replacing "mas_find()" with "mas_find_rev()"
and it seems to behave. It needs more extensive testing.

What strikes me, though, is that readdir(3) probably has some caching
in user space. You might not ever get perfect readdir/unlink/readdir
behavior from this particular library API, IIUC.


>>>> And for the offset wrap case, I prefer it's safe with your patch if 
>>>> we won't unlink file between two readdir. The second readdir will 
>>>> use an
>>>> active ctx->pos which means there is a active dentry attach to this
>>>> ctx->pos. find_positive_dentry will stop once we meet the last child.
>>>>
>>>>
>>>> I am not sure if I understand correctly, if not, please point out!
>>>>
>>>> Thanks!
>>>>
>>>>>
>>>>>
>>>>>>> +        found = find_positive_dentry(parent, child, false);
>>>>>>> +        rcu_read_unlock();
>>>>>>> +    }
>>>>>>>       return found;
>>>>>>>   }
>>>>>>>   static bool offset_dir_emit(struct dir_context *ctx, struct 
>>>>>>> dentry *dentry)
>>>>>>>   {
>>>>>>>       struct inode *inode = d_inode(dentry);
>>>>>>> -    long offset = dentry2offset(dentry);
>>>>>>> -    return ctx->actor(ctx, dentry->d_name.name, dentry- 
>>>>>>> >d_name.len, offset,
>>>>>>> -              inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>>>>>> +    return dir_emit(ctx, dentry->d_name.name, dentry->d_name.len,
>>>>>>> +            inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>>>>>>>   }
>>>>>>> -static void offset_iterate_dir(struct inode *inode, struct 
>>>>>>> dir_context *ctx)
>>>>>>> +static void offset_iterate_dir(struct file *file, struct 
>>>>>>> dir_context *ctx)
>>>>>>>   {
>>>>>>> -    struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
>>>>>>> +    struct dentry *dir = file->f_path.dentry;
>>>>>>>       struct dentry *dentry;
>>>>>>> +    dentry = offset_dir_lookup(dir, ctx->pos);
>>>>>>> +    if (!dentry)
>>>>>>> +        goto out_eod;
>>>>>>>       while (true) {
>>>>>>> -        dentry = offset_find_next(octx, ctx->pos);
>>>>>>> -        if (!dentry)
>>>>>>> -            goto out_eod;
>>>>>>> +        struct dentry *next;
>>>>>>> -        if (!offset_dir_emit(ctx, dentry)) {
>>>>>>> -            dput(dentry);
>>>>>>> +        ctx->pos = dentry2offset(dentry);
>>>>>>> +        if (!offset_dir_emit(ctx, dentry))
>>>>>>>               break;
>>>>>>> -        }
>>>>>>> -        ctx->pos = dentry2offset(dentry) + 1;
>>>>>>> +        next = find_positive_dentry(dir, dentry, true);
>>>>>>>           dput(dentry);
>>>>>>> +
>>>>>>> +        if (!next)
>>>>>>> +            goto out_eod;
>>>>>>> +        dentry = next;
>>>>>>>       }
>>>>>>> +    dput(dentry);
>>>>>>>       return;
>>>>>>>   out_eod:
>>>>>>> @@ -541,7 +573,7 @@ static int offset_readdir(struct file *file, 
>>>>>>> struct dir_context *ctx)
>>>>>>>       if (!dir_emit_dots(file, ctx))
>>>>>>>           return 0;
>>>>>>>       if (ctx->pos != DIR_OFFSET_EOD)
>>>>>>> -        offset_iterate_dir(d_inode(dir), ctx);
>>>>>>> +        offset_iterate_dir(file, ctx);
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>>
> 


-- 
Chuck Lever

