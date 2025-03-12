Return-Path: <linux-fsdevel+bounces-43823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0484A5E1CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D612189F2B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC201E6DC5;
	Wed, 12 Mar 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CVv5bqna";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nbnRbe0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCD1CBA02;
	Wed, 12 Mar 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796983; cv=fail; b=lwxDBG5JNGyCTD4z71XQHwFhX1n2HCDiYmr2QrZ3xhj0ZIb+rAhZxjrcgL21dT3WopksxOuxNedf/r00HlKDiVMX9Oa/5A8W+6ZXkLD/nakmHXxQVx8tnWMu1ChywFTeiDyTctISgXBHeD9H6Qfu37tEoXuBuTOl53495lfgBY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796983; c=relaxed/simple;
	bh=J3RTyRtVmNmVgpgHL1fwzJKV8/k61PKpy3Kehus9sq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gLj26nheYB0O0/qvLMde0rhV05+Tzh0z47TcZGX3Uiq65KvqEn9K4/mdbwAcVdbJT7/MY+0hIPAWj7imGwi7xfC04ruybBYsfLiDfcJmw6YvqjQLhLnFcacoun8ZrCQaY8xZ9y0vxsRNk1sTsBUGTHJbFvq6hvOmUZzIOt3RI5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CVv5bqna; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nbnRbe0F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CC8ZWF000640;
	Wed, 12 Mar 2025 16:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kMkvYNTxjiNAJ76kxpXAyvTxWCpkT1TA/YXV5gj0dGc=; b=
	CVv5bqnai8r7loO2E39NX6dVY9dcgxlEWV4agtYYmXaGKXRAYoU8mHm7grvAgxFX
	kJCKGVd9fZa98CYHDumk0wE5YHm2XkXEf+K/bG4QtxCUOGd2QXM6BLVA8wbu1yeB
	HPBvu0W3fHAITqAYF9XfRC7lPlLn/0tCBOe2YEpS6+2yIZHKZqWhaOoa+QkaORLo
	0cKgKA4zPhQCTdaBg0yXvzcz79vWpp0u/qNlGtTTnP27iOUYHSj+ehDYVZKIcfSM
	6Mhwcgk1N1eh+cgisHL3mRlncgfmSlgaxw+2iww6ZEioVKOcVqhip9T/nStFg1mN
	Rdr0n7oN7MpO36FMRc+Tkg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vj80j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:29:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CGKU7F019319;
	Wed, 12 Mar 2025 16:29:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn0r9rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs1yPETRC8m+TAsLPDs2TyA9jSmk/bdnHGE6aHbH4j76AFeh4skdPXX5JKdC/fGM+OnkrCTPTxADdJucNX3CHRyGTtMsFqrznvfqA0V883lxCowNbZ2uz3oDjnJE44L0c7qK796+Ss+5Aa2ky4NSItjA6gUD3pbJ3pJw3ShzW9+bmx0zsQDS21hZpAzfyJIt+x5BKXSAC/8d9jS/TNWnoOQAJzY10JrLxdBZ0dHuB7FojiiXXTZRi6KBLDWncHT0BZOzcNxifXOT1YCgTDfg08xXZgqMhsq0wveIeYjKZByWa1dQNpia+Pm8WJsHnp+22SrA9RaeH9CN8vT1Q1RvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMkvYNTxjiNAJ76kxpXAyvTxWCpkT1TA/YXV5gj0dGc=;
 b=dqYK8WfHrkk3Y1BytSUXhlOnkVaHvUDaKo6a1AVATJEotRgFQfj2VT6aI4QwXXsovowitaSkL2iJG7PvHCI5yFORQ5EQnJTfvzYqL7sJ23Lydk5cEqgiRBLW7rnUq9vpzjc1bhvU3f1EryOXbYLO4YkaN3odwNxL1VmxpwmuZIi4O8KZYoSFLZwALgOCs1EsDmCnboCKy+k55Lv8VbtSxi35ttPvFFiSw+biUyZdABpXTCN+G7FbhPDmzoBKqleMf+n9pCh5GasqpEB/yb+ImaDp7cBEHejHD6nwHuwZbBIKPBFMKHfsqJPhRJ4lHgWXxqW+E+9jzJTO/tzfOoMetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMkvYNTxjiNAJ76kxpXAyvTxWCpkT1TA/YXV5gj0dGc=;
 b=nbnRbe0FzTT6JvMODMMSmMEG3WRTBEKUmm7ynqprjP8hY1aIuxrVqJoFq6xMQxByRgHxoYoIREXP9GuWI0NVpAHHh2Sc3JmmwVsNgiZzPX/SqIVXYYN/eWMhGO2MhWboT8TvR98PRuHUQRVbCE22c3XAcGZWSLdCCakQnVZweB0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS4PPF9FE99AC64.namprd10.prod.outlook.com (2603:10b6:f:fc00::d38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 16:28:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:28:32 +0000
Message-ID: <74d22f33-83c8-40b2-a8c7-a034f5970669@oracle.com>
Date: Wed, 12 Mar 2025 16:28:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] xfs: Allow block allocator to take an alignment
 hint
To: "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-10-john.g.garry@oracle.com>
 <Z9E679YhzP6grfDV@infradead.org>
 <4d9499e3-4698-4d0c-b7bb-104023b29f3a@oracle.com>
 <Z9GP6F_n2BR3XCn5@infradead.org> <20250312160027.GY2803749@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250312160027.GY2803749@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0677.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS4PPF9FE99AC64:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fb3077-c537-4021-7261-08dd6182ee31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXc0OEFObTB1Q1Nud0JJK3drTnVqa3lRUE82K1Q0c1RNSkpNaDlsZ0ZZNSs0?=
 =?utf-8?B?NGI1MGJwek9GbEVwa0ozMVdXZHBRNCtiU3RuV2gyblpmL2xqYkVaUXA0L0dJ?=
 =?utf-8?B?ZStyWDc0bDU5bzFjZ3NXU0JYRmlDT3c2YnFUZEJnd2dpNUxJZXdJV1cwZ1hT?=
 =?utf-8?B?c0ZPSVBvVCtFS0h1Qmw1SlFscTBwYTJiWmZwQnBxWVlPMGFQL3IyR3BFTkFx?=
 =?utf-8?B?bU9ockFLQWRVNlN0d1MrUXBnNjdmWGFTaEVVRm16UjBEUWxMSEY1UVl3U1M2?=
 =?utf-8?B?ZkhMcmpzdHVOWkZXK2FhLzBJcjJrQm1MY3FlOGRnYi93VTlhMVY2a2xqc1g1?=
 =?utf-8?B?MVZjTU03Zmp4K3I0cGQ4SjQ5YkZIYk1KaVhBdlExZnlWdEZCNTZmaWRkSUdH?=
 =?utf-8?B?UWd1MGxXUVFkbFk5ckgwdG1hRjEyWk5ZdVYyQkFOaW1RRXZRa2J5S1ZBWW5K?=
 =?utf-8?B?U0VXbTVBUkpsUjNFMEVWbUF6MUF4UWJvZzgwUUNFbXFEOTk4diswYzRhN25s?=
 =?utf-8?B?NWdYTDgxTzZJQWFEaW16V0lqMHRDbFdmaW9aMmpNU2ZhaklwVDJ3VExoZ1FC?=
 =?utf-8?B?TlNETEpTRDVTOEV0cDhEa1N4eUZUYTVBbTZzSS9zM2t4Z3UzdzFHUERjWkF1?=
 =?utf-8?B?bkJka3BSK3paQTU4aFNhSHg2Y0x1WGJ3ZlVVNXFlbUk1eGV5dG96SW9lSzZF?=
 =?utf-8?B?YTBNOGlFdXFLU2NzRzZPOE5QeFIrVk14K3YrMmhETWh5S1I0UURqTnBtOUJK?=
 =?utf-8?B?RndYcXlkR0g1bUJlK3paZDlheE9aZGw0VmVxWE5mU0E4TVFtRFFwQk5QTElq?=
 =?utf-8?B?Ump3Mk12ajBOMGFoMWNxaHk0YVRSSmxPTzNGa0pwMmU2WXpMSFFKNStIR05s?=
 =?utf-8?B?REpuQVFaOXlldlI2a3FiTHVXV0ZoK3V0b0gvRDAxZDludEExZTczN3NsQWgx?=
 =?utf-8?B?WWE5eCt2NE4wQy9rVmdQc3JIanluWEYxRlE5T0dKOW96bi82VDhmdWpKRE52?=
 =?utf-8?B?V2tYeUFZMHlxV2lNd0tockdrUm9VY2ppaTloTFg2ODM5R1owNEV2SERaZXZV?=
 =?utf-8?B?SjNYRFJsNTl1Yy9yVGxOWnJVSXhtQXBDbitscjJ3OTVza1U0VjJyaVVNSU50?=
 =?utf-8?B?bWN6N3NCMmkvMHZraFczeE9HWUFkRkdPYjBzSDhZdXpOS2ZBYkFiN3hXTHUv?=
 =?utf-8?B?YXM3UlhqMllnTFUydWJCOCtaSGdmOEVIeWZjNHpLYWFEUCt0QTZ3TUdTSWRo?=
 =?utf-8?B?MjFZMG84dXZQUk1yeWJLUFdtdkg2ZmFhUllLblJjUVdYT2xaUzk4K203eHcx?=
 =?utf-8?B?SUZzRFdTb1E1WUQxZ24rTmFMS0Y4UExlY2I5T1hxbHMxNFhtMmJnc1FQaWsv?=
 =?utf-8?B?TnA2OURHUFIya2VoUFRHa2JmWXBTUXQ3TGZiNFRTMUpJTDJzWXhsTUNGV3h6?=
 =?utf-8?B?V0Jwb3VlVTVnTFJJLzFZWlAxcE5nSlZzRmIvUUpaQS85aXlpbW9LaTBZNlZT?=
 =?utf-8?B?aUdFaWpscWd1NHg4TUtTdDN1dDRTdTlBMWVpODlyTzQ3Y3FvcmtqKytBay9T?=
 =?utf-8?B?RVEvcDQ3UHNxQzRrSk5JeG5DaGovMnlZVUUrMVAxS21tQnk4L29oZEthZERD?=
 =?utf-8?B?eVZqYjFNbitnekdQMklGNzh5b3g3dEk2YzgxRXB2Z0JWMVlkV3pIeHpuRTE0?=
 =?utf-8?B?eDg2S0p0S0dVWngxa0tyWWFUanJJaUg0ZWhZc3FxRWl6eHM0WDJ0STVLaVFy?=
 =?utf-8?B?MzdBMGVzZ2h5aDZGa1Jua3ZsNVJuR2tudXl1TCs0T083ajROYlU5T0RWYStx?=
 =?utf-8?B?TmNHTHE5cWs0azlyNUx2STlmdzF2OEg2b0hRT3RUbXdtc1M0R2JVK1ZQVkxX?=
 =?utf-8?Q?2gZVgjUH31zUQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkNKdkhRb04vQkYvdnBBSkVVUEdpclBPaUYwbWtKR1l6YTlyZVVwYmNob21D?=
 =?utf-8?B?M2hTdTB5VE9WaTJpY1E5YVhVNkpDVENoY2h0M2grckswbUxzYnlSWFNTemth?=
 =?utf-8?B?Tzl4M2x1WU9jZkdQZkFNR3loU3dNVTFWOEFIRDRlVXhxayswUmh3dnkrZXA5?=
 =?utf-8?B?UUh5TUIvR3JHc1ZhaVlISDU3aDE2Vm1iWkQwRlkyTjJleUFFOW5hdWRmOGd6?=
 =?utf-8?B?U0E0U3EzNkppSXBUTDFUb3ByWTcwK2hIbUJrNVFqdzFWMkZja1NpTWpyNTFS?=
 =?utf-8?B?VVJ1VGJnQzR4SG0rUk81eVBwQVRFaDcvQTlUNjAzQXBwaUtuT01Rck1nMVcv?=
 =?utf-8?B?MW1kWUxlK1NHbnpQTmt6dlNsbEVYbzJVL09YdE0yaTFpVmVOVWRuYXRlQmJy?=
 =?utf-8?B?Z2hJWFdZNHByZlNOVnoxUjBmYmQyRXpqWmFueEJDMnJzMkpGelZkR3FNRFBX?=
 =?utf-8?B?MnNOYWRsNlZwYUlDUkRtdkZDUEVvVmpCMExiM1V6TU5TQ0ZqSENGQjdDRUts?=
 =?utf-8?B?TWs4R1M3SzVtRzQxdDh1R0wyOTQvM0ZFOHdiNEk5VW52MEljQ2t5bEVWYkNZ?=
 =?utf-8?B?aUlWUHd2ZUpJMjU4V3g1M0RjZWxmczRXUDJNYW1QbjA5TzQxTjdyWlRpRW5w?=
 =?utf-8?B?ZVFoODZ4OG1kQXcvQisxZFAraVBZakl2d2xYYWZDUmR3QTJpMHU0NWxHNElq?=
 =?utf-8?B?OHVzVWYrd0pKemZWR0JBSWJXQi9WbGdEWjhjeHQzYTgwZ05YR04wNzlaQlpX?=
 =?utf-8?B?cmtUOHBnVlA4Ly9WUnd1Q2xoeVBBYTMzc1U2bTRlRnJWUlUwYjc2dlk1c2w3?=
 =?utf-8?B?cVZucWpQQi93UENQditPWHNCZHV6ek5qQ0pTRVN5L240dUI5ekZ1T3JEeEk1?=
 =?utf-8?B?eEtvYmxOTXY2ZHMrZlZ5N0lsbjR6YjlxcHVEUitWdVRHRVJJMUM0Z2RkWnJY?=
 =?utf-8?B?bm5yWk9INm5uOUE3SE9rL3FFTEVvQUYwTUdkKzcreCtRL2ZJV3JzNzNrbTZW?=
 =?utf-8?B?VkxGZ2FYdXhZYUxLWjZLZXpOczZYYWVibWpxMjduSmltYVJrSWJGZGtwaUt1?=
 =?utf-8?B?VSt5c1BvMEo2MWxxYmJTNTYzS0pPR3U2eDAva2tLV2RUT1BxY2h0UE5PM293?=
 =?utf-8?B?dDlBUk1jSVZZM2t3TDdONVQvVGN2dWU2VHVCVE5BZnBRTkhlSEhrK2F4OXlm?=
 =?utf-8?B?QUtOaFk2TEdTbHhYK25OcXk3b1JmUFNRcDVoS0RLM01VbHR6YTlBVllDQjFa?=
 =?utf-8?B?R3F1ZXgrNDk5TjlibllBRTVTUUF6R0VKbW9lZS9GZlFGRjNnanVFOVBKQ2FJ?=
 =?utf-8?B?UHRrRmdidGJoUVRyei9qS3g0VWdEdzkvcWt3OUN0ai9VOXYwMStxTUdEQU5L?=
 =?utf-8?B?K1Z6aUlkZGJSSVoxMkprU1BwbkovcTZOdGFFdml2cXRyQldoSnJXUURGNStz?=
 =?utf-8?B?MlRWdDBSbUJ1SnBsNGpIWlhKd3JaeFp2cXFvTWVUMGNEbGxIZUJSRG1QWXcz?=
 =?utf-8?B?S2UwTWlLQkRoTVpnaU9vYzd4N1JnZ2psOGJHVmFzM3EzMUQ0L3dQTjZXR1dS?=
 =?utf-8?B?SHBaNGF5bnBKL3ZqWk5UekhKUlEzalNyUmI4SlQyZEVnSkM5YTVmT1ZPa2Ni?=
 =?utf-8?B?c1NlYjdnWUJBdk9sNFVKSFZERHVaVkNlSVNWc29pNjRmRHNXcjJpQW1lRjJU?=
 =?utf-8?B?dW40VVVham5kUG9LTHRmNkphYmNwZ2FrTm1aS29BUlFqZ3pjS21MYkFGOVdN?=
 =?utf-8?B?S2ZLNmI2YWxNMUZ1a0hoaFgwUlFDNEdCVlJNWlJyT2tmVzQxQ0xpVDhlY0NG?=
 =?utf-8?B?VlFMbitoSGQvWERoZ2R2cVVjMnJlYzRLblhRc2JvTGc4WTg1RWZkd2VSd3Vx?=
 =?utf-8?B?eXpRaGZSMFEzWURnSjVwSWVVWVZPeGIwYWF1KzFpMVVQc3VaeTA4c2NocHJS?=
 =?utf-8?B?bWJnUGRDc29QQkZ6bjNjS0RBTmxUK21wblhlbkJodnkyTkl0UEJWTHhHWWZo?=
 =?utf-8?B?ZG5LRmMyVjdYKzNlemVhdVYxeGV5THVaVmJPRXNwQk9reDVxSmpHT1haTnQw?=
 =?utf-8?B?SWphR01naDdua2Y4MHBHSWRqSkdWZk02dC9ZeWZZNE1NUEVPdVdYTHlpeVlr?=
 =?utf-8?B?R2pPeDViNy9JL2kxN0t0VlNyVm8rTkwvNE0rU0ZjNmMyQ09nZUhnWEJhcFQ4?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kog47NQc7C9DwrIqwz7LWA+yJe/QgRuYXtfVGnXOsaMO8u6x5u0RXJ/24MbhD9ORe7fGJ3990IzPRDfS1xJrFuwWkSm/0FsvmJZYm9JEsEdgsQnf4sLUw9XcYcDsgwMAbjvx3qeGjycE17ayUBZGHynOg7WN9loaDpaoU7C1QN7LhzIv291Xgx01vgs3MpbTDMohG8CqjD5z4Rwze1RigWZkK8suyB2RcVVsHVf0qY44zVLX+H7yYfebc8QFme/tJp/rXsms8dxWIgvFmryZcnNYdtpe+wd7mwehAxdDJgbqB3+nMIxh0QbKEPC4KFyhFiSeXlVDXbWpwJ3Bzxq/8b82Ty7sf1EvGBGl04JETealgchbqsLitV3AZKVxCPNSpZ4GMZxOUwgWvqrlbpwfk2X7D8s4JKTHm/bsVJBoRfAzwUQszqq2II+vnSgJFhzT/dSDIejQNyioVQeFFJcj537vzlwN7Zmu9VfXK3XU+Mh5o7yN65LeYEWohW/WdYj2FK9zgYGEadoKxUllxgIsdHyg5zdlTWjG5oK8wjSZw1FLDVFYELZ+rPFqh/CsZruFFDIEqLJiKNCQo69M/0+Q2oRcNqY8xAfrxB9qmS2C3mg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fb3077-c537-4021-7261-08dd6182ee31
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 16:28:32.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3sU2dlg8v17UonCrS/Da9pzsPxQEWRbzYL/7R0lvGty+zDk+FmtpKeJM9M+wEqJRmTG2yq9eoFFoJYrP3mScQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9FE99AC64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120113
X-Proofpoint-GUID: QYPnYsgkOCnno23Xbd-hAnHPnpPE9a-k
X-Proofpoint-ORIG-GUID: QYPnYsgkOCnno23Xbd-hAnHPnpPE9a-k

On 12/03/2025 16:00, Darrick J. Wong wrote:
> On Wed, Mar 12, 2025 at 06:45:12AM -0700, Christoph Hellwig wrote:
>> On Wed, Mar 12, 2025 at 08:05:14AM +0000, John Garry wrote:
>>>> Shouldn't we be doing this by default for any extent size hint
>>>> based allocations?
>>>
>>> I'm not sure.
>>>
>>> I think that currently users just expect extszhint to hint at the
>>> granularity only.
> 
> Yes, the current behavior is that extszhint only affects the granularity
> of the file range that's passed into the allocator.  To align the actual
> space, you have to set the raid stripe parameters.
> 
> I can see how that sorta made sense in the old days -- the fs could get
> moved between raid arrays (or the raid array gets reconfigured), so you
> want the actual allocations to be aligned to whatever the current
> hardware config advertises.  The extent size hint is merely a means to
> amortize the cost of allocation/second-guess the delalloc machinery.
> 
>>> Maybe users don't require alignment and adding an alignment requirement just
>>> leads to more fragmentation.
>>
>> But does it?  Once an extsize hint is set I'd expect that we keep
>> getting more allocation with it.  And keeping the aligned is the concept
>> of a buddy allocator which reduces fragmentation.  Because of that I
>> wonder why we aren't doing that by default.
> 
> Histerical raisins?
> 
> We /could/ let extszhint influence allocation alignment by default, but
> then anyone who had (say) a 8k hint on a 32k raid stripe might be
> surprised when the allocator behavior changes.
> 
> What do you say about logic like this?
> 
> 	if (software_atomic) {
> 		/*
> 		 * align things so we can use hw atomic on the next
> 		 * overwrite, no matter what hw says
> 		 */
> 		args->alignment = ip->i_extsize;
 > 	} else if (raid_stripe) {> 		/* otherwise try to align for better 
raid performance */
> 		args->alignment = mp->m_dalign;
> 	} else if (ip->i_extsize) {
> 		/* if no raid, align to the hint provided */
> 		args->alignment = ip->i_extsize;
> 	} else {
> 		args->alignment = 1;
> 	}
> 
> Hm?  (I'm probably forgetting something...)
> 

note that for forcealign support, there was a prep patch to do something 
similar to this:
https://lore.kernel.org/linux-xfs/20240429174746.2132161-5-john.g.garry@oracle.com/


> --D


