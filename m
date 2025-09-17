Return-Path: <linux-fsdevel+bounces-61983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC3DB8153B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AB91BC6A49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 18:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA002FF674;
	Wed, 17 Sep 2025 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p4w4xzpi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f26fONZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622CC34BA4C;
	Wed, 17 Sep 2025 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133323; cv=fail; b=SH8wBP5dO7oqwWpXZcV0FxAtKNWNUxsOBhViwAhL6AAMo7ULyvpzhPqvf7JUTTUcnGZK/d4s7y3aoXbhIkGnHrnER0rOb6wqyam3qflg6adeB0fRpx5gKtxlUgx8xhzESxcH8kvr6E118RSmV8yYea683afCuxR0kfr1MZVMHbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133323; c=relaxed/simple;
	bh=9qgB2E1i9JRhf+MQYQv/vvMPGMgZ0HXKhWnhRKEbQuI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oaXWtHeEuentB2/l+uZc9fmG2F69nw0xoujpMSw/DQhWkkpdKegO+q95G9mWOt0ysN74mld3f1OoFYgWvj0MDvYPaf3oKSd3Pm4a9Mq65RhYreS7WTqOX3JGYrdbfR0Lccik0xRYjfHgG45Qqetkq1rkI7ACaeHj+2qHG7jz9Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p4w4xzpi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f26fONZc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIYd7031358;
	Wed, 17 Sep 2025 18:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BaAaSMm98cZS2v9YLWa4CXAcmPJnn2IQgxvyCIowEDA=; b=
	p4w4xzpiyeKaZnOAo6EYOSptzNju687YKgmqILRRxi4+RIAbNmMYjdKxfYanopDQ
	Ho7TmzByuhEuiEJuXVaPCU9fwKtJMGrdi0GJMKecsgnrsmFeAMUefilBS/+p4BYK
	r1OCL6jHjP73oIZMfaGzibE4apvjtOMynLcsPsCypD1OvIcca6JLzOaO1q6nK/Rs
	n6rtkPrqqMbvnK2A3HeU2Q4kSl27jIzbIETdpgRZsjoEHgOHpn2KKgiFF9dPxLle
	kb3Jq9GmSrmYWQ11f3lRIUYmPC11xTypjjLkI//++C6q0gFlyrOM6+GtpfRSnyc1
	82H+qkiy6ZRiIrTuPjtg3w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb1xs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 18:21:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHBVNZ001577;
	Wed, 17 Sep 2025 18:21:43 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ec380-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 18:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGDx+jkrW1iVc0/Km1AqRTvnT4hkbauo/9B7eLipOxDC2drqOsvZq84vd8omPdxIqbCZhCmRAqJFjdZsy0aRA9AVO4LZIK0z+gCFOSJ/Eb5dNeLYjDhQZBUCZwTlMwtKMSzBI6bhYs5IqnUORQU5NSyMHVfJC5OnsIUPDhjYqMpX8XqFdE/wD9FWCkFZvz/DC2Id8G9aqAUKtZ7hoGHNlrsioVpZjudGt1I7osAfJCdXauHi/2d3W7n/iCTLrD/uzMyLGGpRyPnxg7gnfZCgnGEQiwArfNlJOUtt6sBK5feO/tVd6luoEuHbMTDfN0aXyX+aqdLUp7Wqf8OKljN2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaAaSMm98cZS2v9YLWa4CXAcmPJnn2IQgxvyCIowEDA=;
 b=T1bQnxjtKVUOnS+Bwq39fNAMPIviLxkAv15xxYKffjN7m/NgeQytoZGGKI9ehtBnuzyomlx/Uo40CEmW3h884n8gCLQKI7F9iuU/rsvxhN3P84RTt+25duRwlUFGM/bEMzmg9QSmCJfNCe7TLp4YLMCNf7LVkBEK5WyLTI2FqV789Zi8IL+wSrUzXnDcAwyQoMWJqlPCSPdBHTTBk1ayyvTeOeTomWXcaxvHInusL6nPHVQEgMXu4u6TaT5C2hc1dxaFLJ/IwBGCJHAcaCiEu0gQoH5IosHKLT1ZOACePVPhK/cDLDzUuS444tvPt5+FKjhz7h4aBDwesRUGFlKHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaAaSMm98cZS2v9YLWa4CXAcmPJnn2IQgxvyCIowEDA=;
 b=f26fONZcFpTj02MGv24IwfIE+cthSmQGHr3NwloBvo99wbDOPPYBSmeG1tewHLXwN2mWsaheHdAtreXPzg7PXEdI96Z/wv7iBbnPoNIwvUOW1dcT8IxNmxQBAA25sYoiokxb/3h1H460K8la0AGVhQ++kAmnQDCSVmXlsdxTloU=
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d) by SJ0PR10MB5661.namprd10.prod.outlook.com
 (2603:10b6:a03:3da::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 18:21:40 +0000
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::211d:441:2594:6cca]) by DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::211d:441:2594:6cca%8]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 18:21:40 +0000
Message-ID: <cd6f19a2-d521-4b6d-8569-bc077b9775ad@oracle.com>
Date: Wed, 17 Sep 2025 13:21:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH (REPOST)] jfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
References: <1cd51309-096d-497f-8c5e-b0c9cca102fc@I-love.SAKURA.ne.jp>
 <dce0adb2-a592-44d8-b208-d939415b8d54@I-love.SAKURA.ne.jp>
 <a471c731-e6ae-408d-b8b8-94f3045b2966@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <a471c731-e6ae-408d-b8b8-94f3045b2966@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0176.namprd04.prod.outlook.com
 (2603:10b6:806:125::31) To DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF35CFB4DBF:EE_|SJ0PR10MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c9a484-139a-46f0-f4a2-08ddf6170bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFVRRkk1c25zZUV6UWJpeGVtYUJ6d05Xcmhhemlyc2doL1JGSEJpemJIaGFJ?=
 =?utf-8?B?cG1pdHdERWZqNXpYRStpWlhoaWVnSFNaTmJoNFN6eS9NV0ZOUnpsYk55dk5P?=
 =?utf-8?B?Z2FmRFF3Ym9NS3c4Q290Vzc3dDFnQnlIMHhDWmJvQ2dwQzgzZGtFWUQzM2hU?=
 =?utf-8?B?eHFOMXFIKzJDSnJYeFRwWTE1TU52bllkc3d2eE81WVpXMFZlaGhLTTNpTkVw?=
 =?utf-8?B?SHVOUnBmUnB6TXBSSFJQVWRUOVJrbWVsVitGK25HZFU2eE5WdEF2eEJaZEFX?=
 =?utf-8?B?OENTTm9FdGVWRXB3dGUxcFpNbW9iY2RxRkZnSlFWV21wZ083SkFYWEQxU1By?=
 =?utf-8?B?WmJoTk9QaGF1UVNUVzRJNTdiT2cweXRZY01iYVZ2b1I3QytDYSs1Z0dnVW5Z?=
 =?utf-8?B?OFI4K1RnTEszV29QVGdJYXVRVHVEd0dOOWhvRi9jOHloZVhRR0lIVUNMdGNX?=
 =?utf-8?B?cktpY2VlSHBVU1E3M3RCdTllbU8zZnd0VzhMaUhzaWVEZzFxNktLTDB2WEVi?=
 =?utf-8?B?ZExuQXVtK21JUi84bXU5Yk4wMXNtWFAyK0tWZ3BqbktPUjVWbFZicEJhcXhK?=
 =?utf-8?B?Tnl5RHoxcDcySXVMOXM5Ri85N1V6SmlpS0dFeTJDS3REVzdrbHBwM0IydEJK?=
 =?utf-8?B?eFlUUk10VlZjRzlSZDhITDVSRFFUSEEvNGt0bGM0R0hacHp4SVdndnRTR2NZ?=
 =?utf-8?B?aWszWkp1dTE1V29zL0xUT2NBMzFRVllVZ2g5cGttMUFodGpmeVJuQjhWNkEw?=
 =?utf-8?B?aXY5b250R3JFbGZmWDlXRHYrdzlJSjdKc3R6OWRhbDRlVFpFd1VmdktGUGw3?=
 =?utf-8?B?RWZyQW82L1hRakVCN2grZzFVNFNiaWs3bWEvMWoxWVpNekdHZkNrMjF2YzM4?=
 =?utf-8?B?eEx5SlpsVEJpWDhocWpOeFdSYU1aWmRNSlF1aFNoZkVjaVJaZGdKTzdTYWY3?=
 =?utf-8?B?Wk9KZnUzSzQzcHRFQ3JjOGQ1cnA4T3ZadjM1NVFrY3FGUUVKT1paR3h3Wkdy?=
 =?utf-8?B?b3ZBa3ZMaHVlUUFxL0dDQllXM2hWQUpBV3dYNU5FckZidmZEam1BeHdxRjF2?=
 =?utf-8?B?a1ZDSmVCRzU5WlVkQkJjUk9md1NrSGhMSFFvNWZhTDUwL1VJellDM0xkdzZE?=
 =?utf-8?B?UzZvQmZLUlpVWjQ2aXhoS1QxSFpicnBGdjg1Qi9laGhFN0hRSURaUytrUGdl?=
 =?utf-8?B?Z0YvTDNMTm03ZWNJT01aSGRVL0dTS01sQTBWNTNadFhLbExwcDg2dnJCdStp?=
 =?utf-8?B?YSttc3VhMDRqZ1JEN0NMdVFoSkxwTWI4ZkZuTDdZS1VEbmFFWUpyNjU4OWpQ?=
 =?utf-8?B?M3hHbGNTb244VXVVaUp4NHBsY2Mwb1h3cW9HYmNzNE40bEppUUlPOXBBQ2I3?=
 =?utf-8?B?bngyVzZMZmZqOTlzZHJtVWFrc2dkOFNRNkNCbGlEenlML3ZnNkZpMUU0NXB0?=
 =?utf-8?B?YmgyK01QcUc1blpQejRXTWJEUzhTS2NsVXVObjNSRmZObHhiN3lNMUl1S3RB?=
 =?utf-8?B?eERlKy9PRXNzUnJaZFJXMm16cVJrb3FTTkYyQldjc0JwQnpTbUdyQVdZWlNE?=
 =?utf-8?B?ZWM4NS9UUmE5UUZod0R4bUxmWk1meG9VTzYyYWR2TTUyZVRiazR6NjJVeC90?=
 =?utf-8?B?OGhkbnZMM0FvZ3VqZHo1eTFNeUdKemM4d2xneGFYbU5YSStGdFFQc1NzSmpK?=
 =?utf-8?B?VkpZak9wOXpJMDZjdVpsSmVuT2JYeGZVTkRMejViZkJnVzM0ZFJFaXk2dTBV?=
 =?utf-8?B?K3pldFNSMnl1eHc4Q1ZGU0ViQk8yVnd4blpGbjVCQU5wUXpibkh2VjMwZVVl?=
 =?utf-8?Q?wVFNIakHAxb1uPoctRyFr3wmmsUq/1GmJzrIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF35CFB4DBF.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVMwK1F2ZklWL3RZd2gzSUFCZzR6YXh2WTlISHEwSFMvUWpmSkV1bHgwRGdI?=
 =?utf-8?B?Mmg5QUorU2tpZ0ppdXFYYW1iK2FxQmQveEJsV21VNkhIVytkKzJXYzhLdC9X?=
 =?utf-8?B?WUVrZ0NiTGZ3M2M1VGJzQUo1Y1NHU2pidGVPN1pPaXhNRVVJNWcydlF5RHdp?=
 =?utf-8?B?WSt5ck1IZzh2dEEwcmpWQk9JMk9QU0pHdzRYMVphTDg2L1VrUzNGU0dCdDF1?=
 =?utf-8?B?c1hlOG1SMk96eUtGVklRNk9hM2FFRHEyMnNDY3RxRmV6aGt1emRaKzlRZElz?=
 =?utf-8?B?Vk9saUVPYUlsSjhWL05ERklKbU84SWYraENta3FDNGs5OEJZZWp4dUdiL2Nr?=
 =?utf-8?B?ZVpobmZia2U3YVBjb2FseTZ4V0o1Y3pDa0Vxdnl0WGxnOXljREJnMEsvNXk2?=
 =?utf-8?B?WEljUUVNNXg3SmRiVWVhSDB1KytMdHhqZ0hMLzc5Q0d4ZkJvK0p4eDBYVUI5?=
 =?utf-8?B?d244VlE2ejVheVJHckQrYnY4eEFsT3p3czBONHJ1cmhtOGhLblBYbWFwMlVk?=
 =?utf-8?B?ZVA1NXdESWxLSmEvNjNRQXZndEJGOWFmRmVYSEMyQmFxMGtZaE9zS1hBdi81?=
 =?utf-8?B?R2hmQnJTcVplSGZFbCtubzNubk9aNUVEVEtzbHZzMzdoZWxkOHFyWjFGMTNQ?=
 =?utf-8?B?eFZsaUgrRzVGbmQwREZmbWRmcGhqQmNZM0hlRTdxeHFKREZoYmx3QUxjL29J?=
 =?utf-8?B?R3liQzAvalFlSUJ6a2JvcSt1SFc4NFhSN1dNbHdtTzFGWlN4WTZNUzZ3cGJX?=
 =?utf-8?B?eGFKeVAwRmljWEpMemwvODlqaXZmZTI1MDEvN0NJR1AwcmdNQUJSYzlUUk4v?=
 =?utf-8?B?NEhEd3BGUEJ5RytqYWR6eTNiaVVIVFRrTFdoT1BUeXZqbGMwbnN0cG11bWFm?=
 =?utf-8?B?aWl4YUMvaUdsa1F5amx3ME5sV2VrMG02MVA3MnBxSmtuQ21VRWFwKzRzYWNZ?=
 =?utf-8?B?WSsxckJBWEJFeTQwZVNzQ1BUV1FSQkpPTXFOOGRtK1p0M3gxVlJ0bTlSWDBh?=
 =?utf-8?B?STBFNUlFT2pCSkR5ZmNJQjg1MzV0UldLWmpVaXpuTjBxRll3NUp4cnFOQm1O?=
 =?utf-8?B?QVZaTGRVL3hmcXUxWlMydnJpcDlnWUFRRXZqR095cDd2dW04Y2F4dE80QVRZ?=
 =?utf-8?B?emZPSnQ5djZJVjc1cWRncDVGeXBPcUxIT0NRSFArWkh3cU5GcUc0TGY0d2J5?=
 =?utf-8?B?TFR5d2FBazFCaW1yejA3WWxURUd1NnN0aXlmcC8wSGk5aUNaWTJqQ2lMSW5j?=
 =?utf-8?B?enNMNUszeEVxNjUzSmc0dmh3NWtmaUNrdktFVHY4MlUybkgybWpQUWdBaDV4?=
 =?utf-8?B?RTE4dU1qOS92ZXgxaW1jYmZtYTRRVkpUNk5NUjJnUWJ2U09lSDZKVFhpdDM4?=
 =?utf-8?B?a0Z1LzNKMTVsZGNudEJxOHlEUEpCWC95RTExV1BZN1BpcmdLMEF4dEtWdXR0?=
 =?utf-8?B?QnBidUxYZFFiUmMwYjE1RGVGR0NGdXNrR1lnQm5EeWN1Nk1BamluWVo1ZTJr?=
 =?utf-8?B?d3daM1IzbWVkZWdhOC9DYmNtbTdEdTQzbWxBOUpGN2dHUWd2TVJ4WTBpRENy?=
 =?utf-8?B?dkJTeGthM3V6ZjB5ZGtWNG03akNYQ3RXbWluWVNsa2ZsYk52Njc3ek9lM1Np?=
 =?utf-8?B?QkhVU21IY2xBRy9KdXJzREs0OUE2cXhlUWJRUGNEQ2twcWoycEQzY2VsQVUr?=
 =?utf-8?B?cVBrQ3FHWkMrSUk2TGFjd3EySXFjVFlIY004Z2RJOE1FUVhjVjJZNUtHRzNn?=
 =?utf-8?B?MXhyeEgwUC9BUnVDMWVUY0NCNHlUbHpWZWFSY0E1M3JldFllR29kaGY3TFUx?=
 =?utf-8?B?OFVwemhXQ1NuekZCWkxRTTRheGQzNjlOYW9sdS9iaWZWejF3d05PL0NBTFNJ?=
 =?utf-8?B?SUYxKzkvMmtldHBFVzNRQVRpdElJT0xqL01lNDFBNlB5OWNFY2M0cTNpM3Rr?=
 =?utf-8?B?b0F6azZmZFZlTVA3bnp2VGIvakF2VzFLL1pnais0aFduL1NlaEhpUmxmbUd5?=
 =?utf-8?B?UkxYMkZPWW5NWWNOL2JTdWVnL21MTVYzTTY0Qy8xY0kyMzZzalhmY1lZOFZP?=
 =?utf-8?B?bFdEQVhHa29OdXZ2OXlZQ2hkRnRKNFhvckJJb0MrN1FseWtxQVpLME1uVmZv?=
 =?utf-8?B?NHl4aVlNMXhaU1RYWWl5U3FRNFdmRHRsd3B2enFTYTZJVmJuNFZMdGlZQ240?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d2pInXAl00zdUp7zEsCF51FQT+dRJsjqmSzKs++3O4nYMyvpBOPm+C1oU82SHm23O1t9vA6ZthmwjianXO8E5NW7RydpEZ5uox1vSym/NJKCsNu1daKy9nqS+O83t5XZAwcllIzBbbAmcH4aFP/h6dNuXkPXz4FwtvKaegmv56ZFXOSaN5g78Qrt7XRxagH2A/q+2+6aqBO5Vvi5ACC7V30WRbrMkwuoGC9Koe2DanQO7P9kyL8RRtUT7W7FCblsxaWCc+JJA3DKeN0EqmnAkgjkt8R4F+DWIVCi424aB87zW2rqaXSqWsjmmQjukHc/Gnsox/CTOBjI5a0vvU3EGJ4zZRJypMW1cKKU8m0LSl4+52areARfelkLsAbHBthWaP0wlr56mTTr+s9qc1C8mVhxD65nFnc2oi/NkBG72ZP/2WhJjikfSCfzL9/RWU5zew1zgUYdDgrtUqEl0fY1LUBITrKykmktIVLPbMsCEKp0CC4CudzMfDeWvCgEVetBCYrki6qqoNQepS/g6Ooi6hrcj7LbqEfa8ASwKziq60EHNhhhdtAS608wA8YBcjdkPU4WADMAYJ2FZTMKBC+ay9uBtRxKPQYymK4bNGEhvBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c9a484-139a-46f0-f4a2-08ddf6170bfd
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF35CFB4DBF.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 18:21:40.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsFpmQF6jpAXWZc0I7Hsq0l2M5MpTk6GJBI/yP6otetTn1VPD8tHJG4wqvSZqc8JmVrxfqadcrZC83/9+9GzMNBQhm4twqKMarlZzI+fDfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170179
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4bfnLQZ7F/37
 +1GzF+PE942ayR0Em+znyY7/XeH6sFgyZPCM/ry3CT9A7lWBnNbZc7FdnL9NqN7lxSD4z3ehpX8
 9jq1aUdLP0/DVTtX3J3+3tGakrSNuzzBUYrq4QdeoZGSO7dTAma4zsywCSmuddl78Okf+y0fv2F
 cEGfKa06gz167+Cou3kOVIl5+3cTpgO2dfXGnC9sW9FNb4Rra/SktceKHm91eWLnSfwqtSLju+u
 v7rHVr2N0YJSR0wYIbg36BwgOKdzL0WVRCfV988BwCstgzmNSP7hnfotBF1yG9+cS6yVQu5ywB0
 +fTeYgILGK0713H8udEpw7zcxMP7JSSseAksaK2gGa7k1YxxIi1ypQ7aDqC0RSDKycYzttp4gae
 1q3qNKJe
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cafc38 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=E3x-2L7OUUt2cCDIQa0A:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: UGj09Al06P0HJygr-Si2zqKskB4OTWHQ
X-Proofpoint-ORIG-GUID: UGj09Al06P0HJygr-Si2zqKskB4OTWHQ

On 9/12/25 9:18AM, Tetsuo Handa wrote:
> The inode mode loaded from corrupted disk can be invalid. Do like what
> commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
> does.
> 
> Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This fix is similar to fixes for other filesystems, but got no response.
> Do we have to wait for Ack from Dave Kleikamp for another month?

I apologize that it's taken me this long. I'm applying this patch to 
jfs-next (after a sanity test).

Thanks,
Shaggy
> 
>   fs/jfs/inode.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index fcedeb514e14..21f3d029da7d 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -59,9 +59,15 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
>   			 */
>   			inode->i_link[inode->i_size] = '\0';
>   		}
> -	} else {
> +	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
> +		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>   		inode->i_op = &jfs_file_inode_operations;
>   		init_special_inode(inode, inode->i_mode, inode->i_rdev);
> +	} else {
> +		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %lu.\n",
> +		       inode->i_mode, inode->i_ino);
> +		iget_failed(inode);
> +		return ERR_PTR(-EIO);
>   	}
>   	unlock_new_inode(inode);
>   	return inode;


