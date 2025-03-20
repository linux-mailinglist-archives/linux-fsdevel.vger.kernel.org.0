Return-Path: <linux-fsdevel+bounces-44533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92094A6A2F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2044632CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19B52206A9;
	Thu, 20 Mar 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="irNdlRjc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t9PfAWA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD323A0;
	Thu, 20 Mar 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742464205; cv=fail; b=sJ+XQFnd+p6/hOskhHmA4IvI3PaQcaxpN5U+/2GoNnXeLs7BCz1U33DnFO8CQ74jRpiEHDhQPvFZ6Y/DhCttr+v+j0rMhx1nm+TJJ2w53+ruZ8qYKitCiQlNS4spfPPaRJ75amUHtfSkOGmL/qrNAOLrSG4ilX7ur62d5VxMUDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742464205; c=relaxed/simple;
	bh=1Q8phdaobbj+4sXODW7FK/hC+vAlwl9QMuMnrKzV3+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H93QmbwmhgLFhTEjA47bDE7msm3i78YqMi2NEBCPO0M9mWbfewmJ32zRWs1mWzRK3uhYZdkNwYqmg7Y6qGjQMYuvDmpJ+WL7qNcnzfuF4aP5tgzUxnMxslkrpTR8Ged4iwc/qLPHwGCtvwyXeqivoRpc+2pABAHs2JNyPlKPqpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=irNdlRjc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t9PfAWA9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K8BtUS030528;
	Thu, 20 Mar 2025 09:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MXj60ck1TQvzMLISdEAfYd84r2crN4c5bkdyz5ubdfY=; b=
	irNdlRjczPszI6z8qHYPxSwCPX0bU8SCgHcfPBRO0LDfTxv8w9rdTtilOVxKBdr3
	A+r+4TkJ7AYfP8h89AguWpWoWl3xeOWL+Givv/B4cv/TwdTLuVoRj/2nEaq+0HXS
	0y+Hne53aPWQ7ogLae5vV5BP7hQPzGetsc0+VggfLi7/065jbG/lEoogx//9pBJQ
	zUCv5ZJMJH+1SfH8Ixs2Xn4h9iATkidsjkHW7PF3unCzhsXmtfdYMLkD0MMxU/Go
	FYZLfIFthuqq82kx2tQ9AYEyp7/Q5DEGLnrjTQQCIytFiLPaTxcZaRSteu/9ly3D
	nn2lTrlgoEGO42WKDXQUvw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s5q5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:49:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52K89Aiu022430;
	Thu, 20 Mar 2025 09:49:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxej3708-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEPL2+BOEx1rkXVJ++JOsSSWbgBEDtboGtDT0Gtnnzl8C/endl3daTvkkKP4q/kL4BIDXeImn75HMUhelsgp3JXPESoZcW6jam6xT8jBOYN1LRYznUu79/SwFPC5ZmPiWb8q46rwkkeddhn9k0CrKFs46FFTdy/VYzrr5GEL/YQINU9IKWoi/lskBZT9sQADuWkFlL8F561kwKkwPlVbiJ08JgSwBwp4cS1hYBUPZvSNpelDdLeqvNlZ6jg9oeEWK/3Wb14FfLB6vuPM8CTrJjdV/Stl533CNGypCMA0al0AobaiU/lt/t2qqstKg6E77XKwp6nb1vRYpNPomhnNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXj60ck1TQvzMLISdEAfYd84r2crN4c5bkdyz5ubdfY=;
 b=tn1vVxCkR5AlWBlDoKbN9AQNz1PwN2seEDi75+jOsIaBe4XYgx/+9gYPhaj+lS22UJ7sUcCsm2n8Dn5lt7bGngIA69grPny3NoIQ8lzJ6ini4NSObgOjbSvozBmXGRwfvWtK4RrhtTtA2nWm20I4foaUyOlPgEUUAcZLpjBedyblMDKGznbxH9+EroEf6r7as4zNjG2EgJjhQNw7ycwGBX1lf21M0NOJEKyGUkf5U2B+tt2GnxAy7EPf42716n9BwuZDzP/dhg9cLrSZTjEBQLEDEOzjcxppZNExgxv8NA/OKAohrRJa7QdGV2exZJ6s7PIVBxe7T5W1cvDjLxg/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXj60ck1TQvzMLISdEAfYd84r2crN4c5bkdyz5ubdfY=;
 b=t9PfAWA9iDLvyQkJGGr2vJZgVJSVEh0kYO2jw83N3DOEy2bSMAYwcevXL+IT8isVRa7y+JuFvwYfastfDt/FxRhbUwxeaw/jTWlQrwy7NeDJqnHhdX3STYD1c7Ff1DuEdzgEHyHpDlgNFVHLP8bQCZguWvkULB1fIbIckaoZzwA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6838.namprd10.prod.outlook.com (2603:10b6:8:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 09:49:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 09:49:48 +0000
Message-ID: <f8cdd6b1-fcd5-4783-9fdf-bcb6e7c3e992@oracle.com>
Date: Thu, 20 Mar 2025 09:49:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-11-john.g.garry@oracle.com>
 <Z9fOoE3LxcLNcddh@infradead.org>
 <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com>
 <20250318053906.GD14470@lst.de>
 <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com>
 <20250318083203.GA18902@lst.de>
 <de3f6e25-851a-4ed7-9511-397270785794@oracle.com>
 <20250319073045.GA25373@lst.de>
 <ef315f4e-d7e9-48ee-b975-e0a014d10ba2@oracle.com>
 <20250320052929.GA12560@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250320052929.GA12560@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 37dd895b-98b9-4043-0bff-08dd67948d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFZyM2xWU3puYmw4WUR2Y1NIOFl4K3NXNXh6b2hJMWhYSEJoWjVXZlYvODJO?=
 =?utf-8?B?dkVhcERGR0JtWHJiY1dpTUlJZnlEUmxtUUpseDNHN2ZLSmFYVHVKWXN5dG5O?=
 =?utf-8?B?Wk4zeG5TZFRxZ051UGlNeHpBTGE0elZhaCtLQVJCdjNtNkpuNDR5VGcwYjlF?=
 =?utf-8?B?QmxXcGV2WXVmOHhvVEtYMUFkSENoUnpDeVdvOUVXdlBsNzBQZWpEZDMxa0k0?=
 =?utf-8?B?S3RjVTRPNGw2UEpZcExaLzZnLzVzemxQSlV3Q2V4R0pQb2hPMU1LQVNxSWg5?=
 =?utf-8?B?bDg3UUVGR3BQZW9WcVNoQUhIY2oxRm5LZStSM1pPQVIwVkRlUmZyeG9NV01p?=
 =?utf-8?B?TFRHSnFBSVpISEJPVVdLL3pGa0ZtbURoVmg5cmNsbysyWWQxTzc2Y3d5dWNC?=
 =?utf-8?B?ZEJjNmRMaDhLVUJxVk5xQVNLVVhrWTdZeG9BZ2FkZGc4SDVKY3c0Mk5PT1Nn?=
 =?utf-8?B?T29oMHZNUHg1VkJvZjR1L3ZXbko1cGpubkdwLzlIUnZzcytqVnpPbVUvTFp2?=
 =?utf-8?B?QUVDTzVKZUlnQ0wxOXFGVVBJMjNEYmVjYThpUjBXSWdpbjF3V3A1Ni9sYXBp?=
 =?utf-8?B?bDVWQitXL3RwZGs3dkZNam9Tdm50UVJsclFyQjV0OU5wdlYyRm84T1Rkbldj?=
 =?utf-8?B?Y3JaODBqUTNablkrdFNBQXFod2pXUTRDa29IVVRBeHdCTUVDRm94VllpV29l?=
 =?utf-8?B?d2hldGxBb2pEbFZic3RqcytkQ0svRlpPNUY3M0I3TnFGVGxsc0hBeWJndDFy?=
 =?utf-8?B?MDZHakgxUllSL25VY3l2Q08reXhVaGthWU9sblNSMmtNSVA4S2NNTVVuV2g5?=
 =?utf-8?B?OWg0VEZ2WXFLS3ZkbWJiZXlpdFJWV3VWK3p1YXovdk9TelZUUlNTYy9uMU01?=
 =?utf-8?B?clFJdklCQlF5M3NZQ2xvdG5Saml5VnBTZHc0clFhWTVmUTFlZzZxWnhaMlA5?=
 =?utf-8?B?L21XUm5maG5sMEhFLzBpY0tvem8yRzlUZjBnbjRDUkdzK05TZnFmWVBweHhN?=
 =?utf-8?B?Sk1rNFhBWDFvT2J2KzhkMTY5ajM3R0dTOE5tTnYrQnMwNTIrQk1DMys1b3NU?=
 =?utf-8?B?ZHk2S3F0Ym5xQmNnY1BlRU1vclhucjlGVnNQaU1Na2plL29Kb3c0TEx5dkdB?=
 =?utf-8?B?bWRVRk5FMC80ODNYeXdtNkdSNW04dCtZM205L0hDK0NPQmhSV2NpZkM1Y1Qz?=
 =?utf-8?B?c2EwL0hWQUZ1ZWttbWgwVnpMWmJkcEd0enpPZ3gyci9LQjYzY09vSW04RjZR?=
 =?utf-8?B?M1EwTUdZajhmd3ZmczNQeUlxWDFnL3hwNE1udkZ2ejRlMWxadzF6Qkw4ekQ1?=
 =?utf-8?B?NFR6QUFIT0twajNhKzI0WktwTnJFSWY1b2h1R3JkMGFVeVlxQ3ZweXM4VFBE?=
 =?utf-8?B?SDNSM1JoRVJyTGJ1dHFRYWpnRXBWUEpmRlNHWGM5NXRFc1JHa2h2akV5S1dG?=
 =?utf-8?B?bVovRkpiWVI1QkQ4TmlhOWhPL2haVkQ0d0xSWlZmREh4MytQSUpFeGx5T1VF?=
 =?utf-8?B?a29iU1FCVGU5VXE1bXdEUHN5SGNnOVBkelAxU1ZFb0lTVGs2eXdTM3FZUFZK?=
 =?utf-8?B?RExVbDVJTDZIbDVlNmNDU1hhZzFkNytCUXRRcGVvb2c5dHQ1T25iTmo4Ulh1?=
 =?utf-8?B?Z0RNNVQ5Vy96OXhxTzMveWpOYXFDNDZuR1VaMFZPeE0yazFXdWZKc1hsMDJV?=
 =?utf-8?B?QXpkNjNnSW9wQ21HcE8xL2I3TDN3SzlWU1hnMlEvMUYxMGlBZ2QycVRWYTVy?=
 =?utf-8?B?SDc4YjhKc2ZLbERKaW1kcnBNWlNSM09TSTZkUEo0QW1WNkM0dnVUUWJNWS9J?=
 =?utf-8?B?ckVQMlRHbHNUa0c3clU0bXgzRmR4NmszS3pjWGQyQWtGcTgwVm1iZ1VxclJJ?=
 =?utf-8?Q?CTWyURuPx/yvK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE90WHdQbXM4cHE4M3U2S0FhY1FWTTlWZ2duTmtlUGMyY3Y1QzhXN3Z3NG9q?=
 =?utf-8?B?ZjRQemw1aFdjYTdCaUtjWEFsd1NhY01FZHRxRnFWVHFSTWJFRitITWhteXNt?=
 =?utf-8?B?d3IxZjdpemIwcVRwa2ZJelhZQmFWckd3SlRFMTlUQnU3MTZaRkZ0RVZvSmJN?=
 =?utf-8?B?R1BBWTlBODVqbVFDallqZUMrSERWWUVNNDZGLzV0bzRWR0IrclFWNkUvWS95?=
 =?utf-8?B?UGJMS2RMRGEwK0VjbDZETXFWb0FqUysyREt2Q0dKdGRUNkYzekJNNGtJNTF0?=
 =?utf-8?B?NEJEZFNhT2p6K056ZDd5WStqQ2hGVmx5dytydTJpUDJ5YnUyc2VSUktCK1dY?=
 =?utf-8?B?cXpGb1F1d296bTluY2w4cjdRTGl4VWprRXJrSGprajljMytpQjg1Vkw5bndq?=
 =?utf-8?B?dUZ5RGZFR0h4RHRxUzY1SFZUVDY0TnR0NkxRY0MwcHJjNVYveXpmL3JDelFu?=
 =?utf-8?B?OEQzdmRpeklUbWNNU0RjSzRUeFdTcHg0WXJGcy9sT2JxYld0TnRRWWhOVzRx?=
 =?utf-8?B?YW53R1pFaGZ4QnFRWVhadklLTG10ajZXaUlsQUprTmFGOXpGcm1nd0dqTHBE?=
 =?utf-8?B?bUNiL1JBUnBBTk5kY3NhVUFDeDBQK1dubWdzWDVUbGdBRVBDNHZFdE1zUlJX?=
 =?utf-8?B?dWovVlI4WjlVVjNvSjFkTkpOSFNTS1o3SXhNSUZBdGZSZGIyVVkvcjJ1cDBy?=
 =?utf-8?B?Z09oUzlMWDYvSnhvUHhKZWtyOHdsdmE0SnBHUnFTazNLTEtCTFRTMkNjVUFT?=
 =?utf-8?B?Z0FCWlR2ZU93R0dudXExUHdWWTVkVkxMNDR4UHRpRzBkdnp4K3ZHT216L3Va?=
 =?utf-8?B?VnFGcWRpWWRVbmRuYi8xYXpXVmpZMWlCYVpGK0VGNi9ONXc5MitzeTlWWmJn?=
 =?utf-8?B?TXNrS3NmTm9nalRuZ3g5TC9nVlVIOVlFbHhPS0x3MmhuTFpUVWRwMEZXczdy?=
 =?utf-8?B?eHlLVzlJTTM2Yk9tRXJvTDEvVW9VM3lTL2pGYjVXSHp1b2ZEU2tEVTJFZE11?=
 =?utf-8?B?MEcyQTkvUmVYQzFvcDBDNm1DRnp1S3NockxKYXBsUlJFTkNHeFAyOTNZVVVn?=
 =?utf-8?B?SGJWSEFobDhVZjJHVTI2ekx0djlValo2NlM1OUtyaVp1bTV3NWpJRDJkczYz?=
 =?utf-8?B?SkdRY0ZIeXhLRFVuckcxTU9heFhGbDZrdHAwa3l2ZVBmWDhtZ2FtL0JkY2Rn?=
 =?utf-8?B?U1ZOZjJkbnFzb3M1RVFJU25RZjRMRUc2SjB4UlR1UmpsNnJ1eDMwOUY1T0U0?=
 =?utf-8?B?UkFjOGtjS1lXZEZRZ0VMb1lrYjE4L0trenA0Y25wOGdyenhleGE1anlhM2NZ?=
 =?utf-8?B?cDZXYm4yMk1KOTRvSVhwOUhRdENaWE5KOFZMNDQ2QnNqR29tNS9kSDZZeW1H?=
 =?utf-8?B?RXQ5eEdmZVYrQUhxQzJDYXNUenM4a0ZOd0VLL0JBTklHQzRwL3JOKytCKzNQ?=
 =?utf-8?B?ZmpHd3NETTBJc2dsV1o2VnFvSVpFRFVVRjJMYy8zMGlhYXIvMXc1SE1Ec0RP?=
 =?utf-8?B?QVE3SDgwOVM4blcyRGlyeitLVFh2c1k3MmxmTFJaZ29rWm9YM1l6VWFGWEtJ?=
 =?utf-8?B?OVYzakFVazB4dHVwSDhtUG5vTmpBbmNPNDFuODJ2YVhFQ1Y4UkZUT3gzOXVw?=
 =?utf-8?B?emd4b0ZScnA0UzZUNFU1WkJRUzYwTFpPampBRHVTOGtkMk9PakhGVE5jSnNT?=
 =?utf-8?B?Y2Y2OXlXN2l4RDljZ0htRUlhSG4zc3BNbXhhc3VMa0RUZG84YUNDMVVXLzJz?=
 =?utf-8?B?TTJ5aXUrQ0g1NWdDeU5nWCtsbkZ4TktGZ0loZVcydXBUZDZJR2FnZE5YQmN3?=
 =?utf-8?B?ZmxnZWxoQWdsQUgyT0p5c0FOano3U1V2aFppckZJUHdKajVsQ0hrbXE0SXl2?=
 =?utf-8?B?S2FJT0FWbUR5ZXV4ZFlzZkthYWgwT0pYTWFmMmVLUU9kTmJvOW5Ya2pmcEJo?=
 =?utf-8?B?S29sTDk1QW1aWFVFeHQycjZlNkNnWlp6N2Q5dndiZ1R1SGFqRFNlMFo3bk1k?=
 =?utf-8?B?ODBaRjB1ZTZJTkRvc1FHS3NLbTlkSkNVNnJwcDdON1NXZWZSSU41a0o1ZjhT?=
 =?utf-8?B?TGJobVB5ejN6ZXFIMkdLanplVjIyanAvRWpUdUxZWG9adEhuRUhVTTltdkFH?=
 =?utf-8?B?M3BZeExXVDFIaXVkRnNLUW0zRGZETG0vME4wY29jZ1ZzVkExWHEycmNzTmcz?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q98imaXUTjFZd2pJDgXnQG7NN8XniV+b8KjWYL3AZPL+M3nRmV8gewJW7BqiPgVhXjag395BI6RlnDz8k3WevoxoMtiz3XsDgYb5irDA6DM1AydMGe/G8o614d9O1Xn5Md/+Q6mZjdUxsSL09o7BpRoFXSENa862pKRAfPjYV8hVmOSvT3v0HPZMAUw1tU2a2cKfL1eauxOrbcAsCCDeqQO2YRRUHiuDZJr1oN7e1e1njcJPkWC3Czk+4zxyUfyncxuHMpi02RyU5mI3tbzuMr7UTeqoM/h9hPwdVN5YVlwfroULsVbcpw5AstDhxD3OXRLoSValYXyt6Am6J853Vsg5jBnAY8pfyfjrkpuEcxDwnpm8NpB11ne0rmAooh3RhtblnSlSq9HIe6VQD/w3xJkFMZYkrOpo41CSbnWu4Ma1yWiYta5LFLoPOBv83CwXQHYnWyu+TfgIIiINazP3fHpFiW8QI1VxF6m++iy8noEwIkeY7bXguEBV/EYruOYI6UVLXbwCl1JHJMbreDyeOOBfHG6PDDuL6KbHHqZ3N5IXtm6oAxfbReZFEBpUidvYYH9XO2rpzrugBmqTy4vumTAaL3S0Qos5RUsNiDh19f0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dd895b-98b9-4043-0bff-08dd67948d8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:49:48.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03XHxsOipJRqleiwi8LPGKAwxHM2cop6qlX2lOpGvBX1ef0CqdKpzo6LDnnOCFyQffFs4BtxTGV3leSjNMhUWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200059
X-Proofpoint-GUID: 8NQG6iDC4fRiPTBYKOAh3CtCThowzCN7
X-Proofpoint-ORIG-GUID: 8NQG6iDC4fRiPTBYKOAh3CtCThowzCN7

On 20/03/2025 05:29, Christoph Hellwig wrote:
> On Wed, Mar 19, 2025 at 10:24:55AM +0000, John Garry wrote:
>> it seems to work ok, cheers
> 
> Better test it very well, this was really just intended as a sketch..

Sure, I have been testing a lot so far.

I had been using fio in verify mode as a method to check racing threads 
reading and atomically writing the same file range, so I need to ensure 
that it covers the various paths in this function.

> 
>>> +	count_fsb = end_fsb - offset_fsb;
>>> +	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
>>> +			xfs_get_cowextsz_hint(ip));
>>> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>>> +
>>> +	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write,
>>> +			XFS_DIOSTRAT_SPACE_RES(mp, resaligned), 0, false, &tp);
>>>    	if (error)
>>>    		return error;
>>>    -	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>>> -			&nimaps, 0);
>>> -	if (error)
>>> -		goto out_unlock;
>>> +	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
>>> +		cmap.br_startoff = end_fsb;
>>
>> Do we really need this logic?
>>
>> offset_fsb does not change, and logically cmap.br_startoff == end_fsb
>> already, right?
> 
> Afte unlocking and relocking the ilock the extent layout could have
> changed.

ok, understood. Maybe a comment will help understanding that.

> 


