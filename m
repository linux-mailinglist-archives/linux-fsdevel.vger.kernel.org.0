Return-Path: <linux-fsdevel+bounces-52355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDEAE22B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D214A72F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736ED2EAD08;
	Fri, 20 Jun 2025 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M9G2A6ka";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZV7/HAE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19426E708;
	Fri, 20 Jun 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750446615; cv=fail; b=ZWbD93/GQVVh5DWBxUIwBDBLJnphilh4ER9UBZhOtHVLywCo3Bje2qAeyBT1EpvFesvbGPReiX+yO1T9/PGUxR4dD7tmp3T3RQULM0PkC9jMDidzR1uuoKDTzTx/VbeR/ytGlbaVtFGWIVtR9Vbwmd7Vk7OchEGzp4njtfcuHnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750446615; c=relaxed/simple;
	bh=WHxDtXtP+r+Br6UXUj8kq0cfWIHCMiVwKfF9KwQHB1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Tb9NQVsef4Is+XjrWObTMQsA0f57u3g6sc8XWBnKzrHaAhLX2PqZctqHXG2F0EZ2jdPkK757+78PfH2U6uFFvHJY/x2q0GWyOYQKRvczb8a7V/QuNFqw4cIcSQFXMImAJ2O6BtiZ4m28f2anGCKZhs6T1lrq5FNcDK4OrZIdmjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M9G2A6ka; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZV7/HAE7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEBlO1019683;
	Fri, 20 Jun 2025 19:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DNhdN+zwpuc87todpmiizDUravW4X/pKbdfHimXuCLw=; b=
	M9G2A6ka0Bl8OQecPHQHP9AE86ygjXJoG/EMeaLyITpQUAhjsDZOMu4Ab+K/owmT
	PDYRayBNUu/RsjDCt49X9TOVVd+jxie4oScQpFi1Ngz1F6timDn3b8nq6KZqZjJQ
	ZY1dCKxZYdvT5Yv1+fqhLa3y1/i8+0UMTn/IqLtha4x/HYgYpK7eWfT/lXc7WsyQ
	hfAFYjpjH3E4Qi6+PlgDPR6DUCkt5wB2cmqYJ2YTImpzJX0NHm8L9wt71qMwXfS2
	+QgGD3R4DSvGD0ZYBWWh0HaUHuUkIVEM8TJsvAm9auNG3K9QrNxHrBYIR5Cu7+On
	LRxQmrRA4sGyOMAf6vFjuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvnbpge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 19:09:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KH2tLt018386;
	Fri, 20 Jun 2025 19:09:40 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhd8nkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 19:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP0quLcWNs4kPm0n1qkyTuY5TtIR8ONY8CKft3RHYldte2YWrqIqksI4ubmJYfqDTRiR5f3gGb5Fs3KoX3/vH0NdztBb4AV9KkRaZm6vVM3HEy/erWgkg8gvE+anaCvVwZQ8V/DE+ak41L9EqTsT3jc7rNjE5DhK8qerT0phdgCkTyDNcAgAe9pryBAUi7xZEW16pQdbKsfNslce6rGwKHmuEcN4Ivyd9DbxwiBqnYqwBQuf6+KSwg7bRV0vefgsms5mukkb8VAlKGcL+eAXN9fJ7MWagCg+fMhpHHAv9kluwhtLVA5IFGTIDMBlZDpnKj1bLNi3FjMhc95RW6V2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNhdN+zwpuc87todpmiizDUravW4X/pKbdfHimXuCLw=;
 b=MhzTSMrdJbVo5xD9J11QU8UxhI92F5qmqA1om9WEfjEgU9sk/wde7i+N7LVah+35ftDEUYl79M9mpcIgZFRmwpn0C7blagTZN1UTlzEVezo1p6VzGT5uU8OACn26uiEVDUPrX5d44PbdG0SQVlZoTfTTI9NGxqwoj8/pKRhskpj508GqPVJZ/WlYThIjSuUPmHJvWWDmnAEKSf+SZj6ubGgCwWPbK5mad8PaABAC73N3U6I0uZE3vGJtQJv6gNTwdoBiXf6eV1Tkb00M0Uo4pN+wVFjtmvMtdwW8FADrzzReKnJIqSwDTPtY275Y5ELnUgszXq02zMdESHXaik3QXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNhdN+zwpuc87todpmiizDUravW4X/pKbdfHimXuCLw=;
 b=ZV7/HAE7c8C9ymJ5/hh254yRJfAuD5DeSIVderhkbsj58Dju7+VYTMdz/sXsRk3hvtW8zIaI4wQoJ7i+bTyFtZw9dGl88dpFs7bHFwzgNYa+c7NQBnY2ym3KXwoZJfTuVq4iihYrUKv2EABv3jmePE/z7wWRMFBX6kC0c0c56uQ=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by BN0PR10MB5000.namprd10.prod.outlook.com (2603:10b6:408:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 19:09:36 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::f005:7345:898a:c953]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::f005:7345:898a:c953%7]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 19:09:36 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu
 <song@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>,
        bpf
 <bpf@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List
 <linux-security-module@vger.kernel.org>,
        Kernel Team
 <kernel-team@meta.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski
 <mattbobrowski@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] selftests/bpf: Add tests for
 bpf_cgroup_read_xattr
In-Reply-To: <de68f43f9e83230bbb055fdecba564ee662d6091.camel@gmail.com>
References: <20250619220114.3956120-1-song@kernel.org>
	<20250619220114.3956120-5-song@kernel.org>
	<CAADnVQKKQ8G91EudWVpw5TZ6zg3DTaKx9nVBUj1EdLu=7K+ByQ@mail.gmail.com>
	<de68f43f9e83230bbb055fdecba564ee662d6091.camel@gmail.com>
Date: Fri, 20 Jun 2025 21:09:32 +0200
Message-ID: <87ecvew7pv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:208:1::18) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|BN0PR10MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c59ff78-99e2-4bc6-c4ec-08ddb02dff5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFp4T3c1cG1kZk4xeklON3FNNFdXOUFXRVFCaHBBRFozeURHcXA3WHFwSHF0?=
 =?utf-8?B?d083eHV6TEc0Q0dESGwvdGlpanlZanFVNUtNVlBaSGd2dWh5dTVmMTRkNjRR?=
 =?utf-8?B?Z0RaTzVvTFI2dXRRTFhYWHZiQmNWRDRpd3JDQlMyV2xkN2hiS2oyT0F6K3dW?=
 =?utf-8?B?Ukw0UG5Ba2lxUWdMNVRNdGxGeHVhdTVnTUl3aUptWFcvakFENVE0NHBZQUJT?=
 =?utf-8?B?eENJUmNwSVF5Mnpmd2tRd0tmU0JmQWdJdmtURU4wRWhtUS9HS3pRRGdleFRj?=
 =?utf-8?B?dTRZOW8rT2NoTnBNbFhHeVRHQlpGR1lmdUpKeVAvWkx6SHM0dmxNb2t1b0dR?=
 =?utf-8?B?QzgwQktMV1phTkh3TWxDZXd1Mjhkc0pUSHV5bjgrbHhkODZacmFVdGU0ZkEr?=
 =?utf-8?B?bm9wdkxSNHJWNkRsejYwa1laRWk3dndockQ0SmlyRkF1dHlzcVBLbVVJTStZ?=
 =?utf-8?B?NnZwYU1WUHBpREkwZXJqcCtYQXV0aWFnTHhsb08rVy9lM2taMHBBRkFhcmI3?=
 =?utf-8?B?aGUzVE90aDRTaHpMbmY1Q3Y2dkMyZHN6a04rTUtYUUJiZ2hqNllUZ0hrVWxj?=
 =?utf-8?B?V1REQTArSTR4bTVmRFhqZnNZQVo5c1haR052YTByZkxXa1E1RGJSRWtMM2hN?=
 =?utf-8?B?Z1hjRHp2Ui9IUUxQbG45TG53TFNlQnVqc0YxeFhTUTcyY2JSUmc5WWxCa1Jl?=
 =?utf-8?B?dTNXVTdCVVZkd2F4bnZpVGtleHYvOU9YN2NYVG00WEFwYVp4M2dqNmFUN3FI?=
 =?utf-8?B?czRsM0w0ZU1DNXlmY2FkLzhJODdHMldRSTlISjJHdG5jMzV5VGNpKzNVRUZ1?=
 =?utf-8?B?eDRuSTkyLy9OU3ljT0RCU0MzbStEMWYrQVFRN0lUMnpocjNJWjhZc1ErbjJ5?=
 =?utf-8?B?TXlCRUQ2c3RlMVJqcDYvRjFVRk5LVHpoc1R1TlovSnN4bEJLSmJpd1hFendh?=
 =?utf-8?B?MG5KMCt0bHVUb01sdG9yTmFvaWtyTEZRZzFLY0dWQm9jRzJQSzN6OGVwOTlX?=
 =?utf-8?B?VlRhWEcvQytDSk01WnM1MGRLUEdjV2hxZXl5TEFuOHVmM1RRUDQrd2FDTzdP?=
 =?utf-8?B?dUluU1h1Z2dVVmRqZVVxUjh2WVZDMmdCT2J4NUsranRXVXd5ZUMrRlpFdGdN?=
 =?utf-8?B?OHpPbmFHQ0NObWwySGJuVmtBa0hHUHNPOGg0NmVMcDFCT1BQN0ZheUZJbmpX?=
 =?utf-8?B?WndKaFQrMU9IT3RtMTd5MzI1NFRPMVAwRmE1ejAxS1Eydk1XZmF5VjN2amVa?=
 =?utf-8?B?QUhubkRrcDdtOHlnS3J1TWl1d3Ftb1dYcFd5ZThadnR2bjFsaERrcExpU0dD?=
 =?utf-8?B?Z1BZRHdqaExGRjhUek9wUUlKN2gvOFhJUmJSVkRkb0lNbVBhNmRQaGxrbjZp?=
 =?utf-8?B?RWdqbGl3eFlTM3g0VW0ybzl1RDIwUjE0ZW01UHFkM0xZL20xZVlPemdnYjdZ?=
 =?utf-8?B?em90SHFOVTBtQjNYZi9VbnBSeEd0OEJvVUFHdVZ4d0s2N1dLTFRQU3RMNGYx?=
 =?utf-8?B?azNVSDBQZzVXWEROUFFKWjZsQzR0NlVZcnFSbHBhMy9kdk9DODVoZXVNeXRq?=
 =?utf-8?B?cHlkZUJJblc5b2p2ZEtmeG92NVY4bTdnK2V4MkMvRE1xcFJPQmFRclhhRHBI?=
 =?utf-8?B?VlM4TkZDVzYzcURMb1U1RGZId3dQN1JtQlBTcDk5N2VVUXlmQTdTOG5SYytq?=
 =?utf-8?B?U0pBZFVuQlNiQkJMb05qcFFrakJMc3QvZEJDL3g5YnJwbGMvTVZCQml4cVZh?=
 =?utf-8?B?YnQ0U1JiMXFRNE4rbWF5UmkvWXBLdi83V256WFNHV1JDMEZGS2JzNGtpUTNH?=
 =?utf-8?B?MzFUaS9GZTd3Sm92MmxBTWRsdk0zNk5RYkdhWVpGWHB1dzh1Zm5VeE1adUE2?=
 =?utf-8?Q?nvhkQzICJm/HW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEZBbGlBRHowb2ZSdGNtQ1FONG5KdVdjNi8xMzVBVWZTRnNtd2tTeE1udUgy?=
 =?utf-8?B?Wmk3M0FpK1ZIbGkwcC9yZVVYR3FxR3UzbmtabXVXZUNqQWhnRmZGbkdnOUNS?=
 =?utf-8?B?a1hmY3dTMkx0TUxwc3NSQXNIcW8rVjVMVGNoMzZTYkZNeGprRGE3ZHV5WGxH?=
 =?utf-8?B?UHpyamozQWMwSHZMQ2hLN0JhMURGVzFpbWFQK2xqditpcHQvNVYrQVoreDRR?=
 =?utf-8?B?MXNxc2FEbUJ0aTNTYTlja1dOc1ZRbnVKckdkZmpBYWlZbzd2S3dKVWM5eW1v?=
 =?utf-8?B?N1o0UWxrbUVaTGlqYlI0Mk9CditaLytxd3g5NldhbERQV2VVZmI2QVhGZ280?=
 =?utf-8?B?SVphcnhUMTBuVUpocHhjRXhqTjc0LzR0MktDUzJXSDJBcUJzWEhKNUdhWk5N?=
 =?utf-8?B?VHE1VURQTm5HVytSUnpyZjM0SGNiSkFwaGJseWhNa2kzbFM3dHQyZzhBU25O?=
 =?utf-8?B?ck9MN2luWXB6aHU2ZVlZcGtmbDhOOTZNN25iMXlZRGVqWVlhOGs2WWFpTEZh?=
 =?utf-8?B?a2syNG5WV2k1Ty9VSWNCMFoxOFVja3RRNnVySjVBYUlvQnN0ZFdFK2EzL0pB?=
 =?utf-8?B?ZldHVWVMZWMzdGZJNzV6dVVRbXFwcTFIWFZyaStXWG1DM3h3Y2c0cGlObDhm?=
 =?utf-8?B?MW5ZdUg4eVdrWkFmVHpaRFVHM0N0dlhONWRTb2V6WjJhL0xqZS8zclFWL250?=
 =?utf-8?B?emEwUTdjbXQwTldKSGlkU1IwNWNKbkxCdTM3UzZSY2dYZFdYbjNhYW5qUnEw?=
 =?utf-8?B?b3dWd1RrWWZUcHRDMGpoTkdwSzVwallzZTFVeGgzNmtpUXEwLy9Pbk00anVk?=
 =?utf-8?B?cEdNTjZHeGhXKzQxSEY4dlVTUmVpK0JwRzNwUHBpVjh0N1dYZ1liOTFHVDRk?=
 =?utf-8?B?VnkvSlRSNXlSZ1poY1dzejlwYnRDcUYyUUFSbW8rK2N1UVB3ZTh2ajkwekMv?=
 =?utf-8?B?OTZsT2RYSlg1KzBTcVZOQ3pNZXNMT0pDZ3l5T0s2YVplVHNMdWRSUWxnWE1x?=
 =?utf-8?B?aS9NR1U0MzFET3ZXRTRQUlIvSGdmYU5mSXVPQXliZnhPVnJ4SGI5Zm9tMXo5?=
 =?utf-8?B?Y2RJNG4wdmtGcFZ1Y1B0WVRaODA5WXVKQ0d0RWpuL3FmSDZ6RmNJOTY1cEZx?=
 =?utf-8?B?NmswRVZZVTl3ZXlKaXpLa3FCVGk0S0s4MXBIaGNnZlYzS3RaLzhWWmc1a00w?=
 =?utf-8?B?a1FkTHpqK3pGQmpjbzQ3azJlUVVNck4yaGp3cXAzUWFRQm4xMDZhcis4ZERh?=
 =?utf-8?B?M0ZZUHZxWFhLRTY0TllNMjVuei8vYTJZeVZtcktXb2YxMWlYa3RMM1ZkR3Qw?=
 =?utf-8?B?b3JCTG50dzRDK0F1QmpBNDJhcUlKcVQrS2pSZWc5UVFIdGpzOUMxTWloZmhv?=
 =?utf-8?B?eXN1MDJBcVRBa3NaUUdSc0tvbmNtVkNFb3h5M1NxZXZKVkpmNHBmcDdJWjg0?=
 =?utf-8?B?d3ZidFh3ZWxFcHN3eFR1UUdEeEN0ZmoxeWxTMnNtanRrNE1lMnJYU25Fd1ds?=
 =?utf-8?B?TVlOT3ptRGpUdUJ4emRnTkNaN3JPNjNyUkhiWFVSdjZFSEVSV2pHM24vT2p0?=
 =?utf-8?B?WC9kTEJHZWFKMGZCcGhFaVc2SHdZMGFmMWp4L3c1bHdpTU1UU085akRHaGpN?=
 =?utf-8?B?U0Z1Zk1mVVZDaWVkV0piYU9NczJOU1NCY0tRL0FYdnNmQWVMZmFaazZKUDBm?=
 =?utf-8?B?K1FnTEFzZ1lxd3hqMVhySFh0OXRHaWU3STNpRXpneVlrdzJsRjV6dGQ1eUFE?=
 =?utf-8?B?WGlkN0hRUlNKbmhrd2lBVm41ZUtDTUNhM1FqREpkUHoxKzcxZVF2UXFENGpR?=
 =?utf-8?B?WE1Db2h0Z29hOW5qSGZmUTV6K25UZUNsYUxpcHpseUhBODJYMVcrTWJINnk4?=
 =?utf-8?B?QWRSZmNLZWRZbmZ1MmRKZElBVXFKMFlsZXVqWnRWVzBOZWRMbDUvWjJ4azhQ?=
 =?utf-8?B?N2tWbU15L2VNV0RiSEtjNzN1RmJIeU9CZXpZaCszdVdGUGc3Tjlsam9nOEdJ?=
 =?utf-8?B?b3pYNEh3NDVZMklncDBZU0RlVDdaUzlSZkYxVVZZVFJWMXhSZkR4ODZJZFQv?=
 =?utf-8?B?UXI2OWhPakgzL1NTeGE2K0JTSzk5MEtFQXlrME41aWFod0M3L1R6UVkxU3Rw?=
 =?utf-8?B?dmZzaml3bHhEbTdSQTNPOHBibnNhbTdMK28yK1VENm5lcXhoekg4NDdtcTNC?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xPNL6tdGUgS6mcGw05hL1fu1NviR2v+uJ8fQSqRyPqHtHEqCiRxRqT8vlS0bBartAQnycZDB8KQ8zcJdj6+MlUl22HoRKA1ZLUu2HcJpAokvhyhvjqMRki7BKfMVrkR3tdC4QlG2pk3O5ZCr1J9tQWmu+09sRsqAvxsT0Ql5tWB9pexqZjchhd8uJiEZC/YE3Anxe7YUpWNYagK7c63kvl7O3Z8e76BnuYTcFn9nFFthwp+4VPhMxQk0lhsBO0JZNruYGi4I/cBVRgwGbi5tLVa10MybUGZbCRWItC3cp5xN8dbHDcbdUmKXzl4BPx2vihJOyxxyKLrLmY8NrAsubiwhQWrHZJi9i8mzmNWVqHInddLpA6FEvlJVElfShO1UIImaKy+jSUg4Y+KlQX/Ps7cvLV1Twx9Y4uqwsjjEEGuNd8q51X4pZ322wljwn0mc8JYPBWqv4UjrqWAK4Fy2Jh8MQb86Ot4XIyJs4lfKRoEyYnT0zTkwK2q/rjvDeZYv0QMYPdju+G7Oj9CVyMhOj53unhIINChDcMySVXlIg6ZVbS3q/M9iaTM1CkDd6clijylnrMcPwmcffeYM5BypoHA+QhNhIxT3qCxYF+0Ul0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c59ff78-99e2-4bc6-c4ec-08ddb02dff5a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 19:09:36.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMjvhLh76Rjg99/ktrkvEEPiyKpjj8a21Om/RAbN0WJXgXbqQoPlztXdzqhyDvwXstNGaXzfcTPNI2nIMns++vYpfzuek1DwTH93oFa5nmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506200133
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=6855b1f5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=b4LDLZbEAAAA:8 a=VwQbUJbxAAAA:8 a=dQK48KPCjxnEXofJzG8A:9 a=QEXdDO2ut3YA:10 a=20T61YgZp4ItGotXEy2O:22
X-Proofpoint-ORIG-GUID: dQQ7BmTqCc9Bk5Ftjmgs743MV9QzA-Wq
X-Proofpoint-GUID: dQQ7BmTqCc9Bk5Ftjmgs743MV9QzA-Wq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEzMyBTYWx0ZWRfX1LciVyZ+pZOe nDZPdWpmmaOH5uOjtNh6czxDcXVTbu5FrWS/m4ZgaGnjB4gGk10nHUn2m8KkJn/rocABIry8p2A VA0OjlblOmvDkq3v/1ScT0dnY9lc0AFropfMs8DVkTy9zCHrGKrnkoy8rhVtvlzusrOe2JpbXxJ
 clF1wml8kvdlBdCMnnRIlLUMjiIWMu9eBON6474VTnpjmJL3EWV2fmpJAgBcpH7Za/IdY0KqYr5 /qRpNdtBz62uqGfNZE0V8o1HHTAO7WGsAbHObc5LSDoU6URaT33ouoy4E7LVumqb+upcJ75W7q+ 9yJmIL/r/swI8dfR66n5sq7JiDW1UeyW9LAKUULOcatO4KBQK8WO1eudpQbnspFSG9yO3o1tSDZ
 GRlQKg95jXGuO9jCrlCAlKRskcRglfca6HiVYVDem2N5izIprpODNKTe7yFCku3xX2tH1F45



> On Fri, 2025-06-20 at 11:11 -0700, Alexei Starovoitov wrote:
>> On Thu, Jun 19, 2025 at 3:02=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
>> > +       bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &valu=
e_ptr);
>>=20
>> https://github.com/kernel-patches/bpf/actions/runs/15767046528/job/44445=
539248
>>=20
>> progs/cgroup_read_xattr.c:19:9: error: =E2=80=98bpf_dynptr_from_mem=E2=
=80=99 is static
>> but used in inline function =E2=80=98read_xattr=E2=80=99 which is not st=
atic [-Werror]
>> 19 | bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
>> > ^~~~~~~~~~~~~~~~~~~
>>=20
>>=20
>> Jose,
>>=20
>> Could you please help us understand this gcc-bpf error ?
>> What does it mean?
>
> Not Jose, but was curious.
> Some googling lead to the following C99 wording [1]:
>
>   > An inline definition of a function with external linkage shall not
>   > contain a definition of a modifiable object with static storage
>   > duration, and shall not contain a reference to an identifier with
>   > internal linkage
>
> [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf
>     6.7.4 Function specifiers, paragraph 3
>
> The helper is defined as `static`:
>
>   static long (* const bpf_dynptr_from_mem)(...) =3D (void *) 197;
>
> While `read_xattr` has external linkage:
>
>   __always_inline void read_xattr(struct cgroup *cgroup)
>   {
> 	...
> 	bpf_dynptr_from_mem(value, sizeof(value), 0, &value_ptr);
> 	...
>   }
>
> I think that declaring `read_xattr` as `static` should help with gcc.

Yes I agree that is the issue.  It is a restriction introduced by C99.
I wasn't aware of it so I had to look it up.

If you need read_xattr to be accessible from other compilation units and
inlinable, you may declare it as static inline and put it in a header
file.  It will then use the copies of the helper pointers in the other
compilation units.

Alternatively, with GCC you could try to add a direct declaration for
the helper function to progs/cgroup_read_xattr.c, that doesnt need to
use any static intermediate pointer:

  #if COMPILING_WITH_GCC
  long _bpf_dynptr_from_mem (...) __attribute__ ((kernel_helper (197)));
  #define bpf_dynptr_from_mem _bpf_dynptr_from_mem
  #endif

