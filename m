Return-Path: <linux-fsdevel+bounces-38650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C560A057C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 11:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF063A2B58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027F1F76D4;
	Wed,  8 Jan 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1kOSzb6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ACI02W1A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933731F6686;
	Wed,  8 Jan 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331209; cv=fail; b=fZ22A210J5/FGkp82bUfI/0eKheIusPzf+LhUqBeeaJgojfNua2oO0yjTZn0yngnhQquBzimnPgWDPTjWgpR7nPJVxKD7Sohs0A6mbAvayMPytLZKxBxEP9BlZWVYKO68pKDT5e29ygCheqKGXhSCEKX87qBJa/3DUOY3MA9YEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331209; c=relaxed/simple;
	bh=Sp5H3ZwMJu+iplSnmexKwCg2KNJK+es4kuoWNGXhW5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NisVTZ8oDrPY3f9ZPR+Bppe79Exo2oPLP9np5PYQkFh3Dlm8nvwWXsdhvdoyRxlhJaoOhuNix20DbqA33GAKzsw8lNHRevZybMDyhxtDvIbEbFDke/KxxGOvOycPSViMGrkHZi27i+u1kOEfY5NG4bnyyjLBVPQ/5YTWnQ7jvB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b1kOSzb6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ACI02W1A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081umZs017587;
	Wed, 8 Jan 2025 10:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1xm2Amg7944MqtsLwrPtAL64Dw/FOyLOZ5J3wOzJ/hw=; b=
	b1kOSzb66+wriU52riH7J0mARELHeZHMOkR8hIk8Ryi+08KvjWQ5kFZGa+ihHsVo
	Paa3OZtwmsZWB2bhl1AEBoM2yWWCKqlPEQrPRZU4AqTAtSv7oymdczt5bPkGUR+L
	gf6FgK3p2eYsiJcsVFQplx/CO/0P8ihdusXuuXePi1t9JSmJ6ee9qUevLy91fe5Q
	KP8LxbPMmFawLsy8NIgMv00w1vdOx0FBQB1cAdgqM2fzDTT1lsumsBnfFNYIlf6G
	ISkTL9M8ZpDkjYRyjuB8Ako+scu4rG3aVu5Ywfnc1qa9wu1zuCs4j65batLaGsOF
	Jquq0+nwQ1p8iN9H3TY7mw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb6js4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:13:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5089OUns004858;
	Wed, 8 Jan 2025 10:13:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9khpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:13:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVEl95GUTiVFJbvRdG7gwKKIkNwep5QOutmHfQ7gHnaiGYickbqUH0WNCN+9OoBL6EqYZVgxR1MhM77B4cn6xJ22t/5V9Ygl7E9coyOQTHUdXDhAucZsI1FMOsKTb8qI4M+h195tE7K2pnwBe8f9SJ8remK6825z01AXR4wsLmglpcx4VNi2C33PpX4jbQX5loibrHVMCs7xm1N0+lCCsD2jzT8arXQbH/p2n8oREHbUNkfW/68XdGKlsmf3KNlOQWvg7soWUpAgLKifym5EGBrgF47WO3FnGj20CBqHk2wNfzbUFzzNClrTlxlqzKtazAaKb7pH1c28BZASnDCGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xm2Amg7944MqtsLwrPtAL64Dw/FOyLOZ5J3wOzJ/hw=;
 b=ky6DYAx2G/lD4E9vWgXruvG1eb8TAs2FaABTVhtJgr0qHF2HEQwzQ/Amj2JI9O/uDrvsC5a9um7XSFYtgZa58NltQPZw2kPY0OZl1izrzMc96W548h+WuvaqXngSZJXSaht+8inJ/ashf0zGtTptqzWIIz2aRdQ6qJns5V/1tCcYUMRIe6ote6ePHLRjZQCJWaagQlY1n8mOjo+OCRrrqeBuI6uyFOaWwowKpn4XMJBaITpAaFWQuyvBO0LrtLaCuueaEV6rEzXQJYqiAUFKCb5VZ8YAR2WXiWkZs+mICGFb9cJeIKJ1dPjDR2iv8VSUmCvUvXfGXJ7LHZADr+yOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xm2Amg7944MqtsLwrPtAL64Dw/FOyLOZ5J3wOzJ/hw=;
 b=ACI02W1AbmWYwy3evNYPNGClQXsyYZcj21TR0/Xh/X9t+bAWCLYfmbYosOgoufUuDLiFYB0yUptWv86XV9uHHdsqTBhKu7aF0kzdFUdUVNV47QoyrJGzNAXc23KiN5fUJwX3dS0cQhR50BiTi8itX0R0HQgOdtbdpWrSIIC4410=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 10:13:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 10:13:06 +0000
Message-ID: <571d96ad-d9fe-4c76-8f05-1e487244b388@oracle.com>
Date: Wed, 8 Jan 2025 10:13:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] xfs: report the correct read/write dio alignment for
 reflinked inodes
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hongbo Li <lihongbo22@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085549.1296733-5-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250108085549.1296733-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: fc431bc6-d3f8-4fa9-95af-08dd2fcd0b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTRpNzBSK05YSmpqRitMaUlJN3ZpY2xmTGNSN2x0aTZDSk8zU0ZtckhNWVh3?=
 =?utf-8?B?UlRpK1JYUWlkNFB1M2ZWNjVCVUZKZWp2bjFoWVhrWTh1N2xYc051R0tXZkxL?=
 =?utf-8?B?d0ZDL3Y4ZFhDR0pIc2lKaE1PZ2hVRC9Hc2RoYjFxWTlUZFhhQktTcG5UaXdn?=
 =?utf-8?B?eUE4SGFtcWNWVzQrMVpQaFVvK1dFMFBwWldMdzNhTTczQ2pSYmxZa1BJNkpK?=
 =?utf-8?B?YWc1NkF5M3VVUkwyU3MyaGlpeU9rNnFUL2xhZklyV3RTT0JmWTdJL3dXakVp?=
 =?utf-8?B?eDFlNkJvM0kySzhsKzZuMVYvNFFnd09HZjFpYUVkOG5wa0dsWkNXbk9DUmxU?=
 =?utf-8?B?bTZ0YlJGYXlDZk9SV0hHeXExbHhHQTlNWWFjSHpWcncwdXRCV1NHUEJsamxn?=
 =?utf-8?B?MHBobVdraEltY1duSGd1UUJSSjA0LzFiaFBwM1l6NUs4VjZvOWJYQlByRGx3?=
 =?utf-8?B?Z1ROeTNOdU5GKzRtTk5pNjUwMHdxYVNubms0c1BWU0NRb0c2V2NDRy90SlNs?=
 =?utf-8?B?ZHlhLzk1bCtLa1M4cmVzbDNXUU1nSWJBREpYRzNKZmo1dyt4TWpsdktEUktV?=
 =?utf-8?B?N05oelk3dEJJc3dZdCtKQzZwSktLUXhqZFlhYzlwNlhuMHhlbVRaYW9FdGhX?=
 =?utf-8?B?VjhNVkh2cWNPb1ExTGRnYmhIMVNQTGk3WVlhajFHRDRncmNuYms5TDJUVXFn?=
 =?utf-8?B?c0U0eE9VSU9LbERqbENGOGpGK3MxSFdEQnFiS3R6d0VPd3ROOXUvWmNRRHZs?=
 =?utf-8?B?U1Vac3RVcjIrdWNTdDZGTFdLdm1qaUdmZnJ0YzBIYzJzcjFtNWtkK3hhUDRi?=
 =?utf-8?B?OWJXc211Sk1QTU9qeERHOGVHZU9DNXFERUZWSGhUTkZqOEF4cUZUUlFFQitV?=
 =?utf-8?B?MUViMnhXUTBqSnIzTzZDSkY4SU56NDV0cW9iNGpEeFhucWdUS0VpMnRKMXc4?=
 =?utf-8?B?U0dJN3B0QWFrb1ZwOGM0L3JKYjdmMUJrMHYvbE1TVUpBZ0VWQ1h3SHFCNVJr?=
 =?utf-8?B?Q3k3MDRHcmp3MGU2QTZJRDNaNW56UHdocEdFc0JWNXR5NnJKcTkzZkxJcGFw?=
 =?utf-8?B?ejdlNExvaTdFcyt1bW16bWRYbHQvSWsrSkJpT0VIcGUyOUNDcTU3QWtmZDRO?=
 =?utf-8?B?V0FYc0NDYXQwZEZ1WEpsMVdnTVFkTDJtMElxeWRvU0Q3cjg3ZytzVzBwSGo0?=
 =?utf-8?B?ZnAzOTRTenVXcGlucEJMUUM5VUpTWFNVT3JGcHBKV2hRcUt2TnpRQTlZTGRk?=
 =?utf-8?B?emVpZ2lzek9hdm9DR2F2WjdRb0d1THc1QXV2bWxiZFZTVTN2MHhoTGRaaHEz?=
 =?utf-8?B?YzNDeWJFL1JXVDBBZTNTR29rOWRVc1BZNGZqVnFPdjZCMGtIRXRNTGE1U3lx?=
 =?utf-8?B?Qm1qTmY5ZDZrWEZzRk4rcnYyclpGWk9ZUjE4OXVCTEJtTmFDTWU4T1BINDV5?=
 =?utf-8?B?SEo4K1cyUmdlNGFFZVp3Qnk3aVN5ZFNoMFhkandMUS9Fem1FaDhTbUtmRjFX?=
 =?utf-8?B?TEFyY2RLcjFkc0RCMXNQTW1oK0J1WnlGdWp3ajMreGozYmZJY0tRZFAvZVdu?=
 =?utf-8?B?Y3hnZWlSZU5McXZjbmY4RXVOQVo3dzhwN3JaNDlSUXJaYlJiNGNPKzlCaXRO?=
 =?utf-8?B?aFRkS1F0L1RlZ0pEY0J4VVZIZ3hMeW1MeUxkZnRuRlVhZU9pTk5BN0o4MUUr?=
 =?utf-8?B?eXF0RnhZV09LWHdRU3VVNlNRMWhNcFVKazVrSHhEWDQ2Q2ZTc1YzOWN0VnNQ?=
 =?utf-8?B?VXo1djhEWHZSUFpxWUVyeko2UXRrSHEzLzZJejBpYU5WMVNId1RIc0tNVTVm?=
 =?utf-8?B?eURLczJuaUc0cXk2UHIrd09iUlpFelpwWm54d3Bra0lzOXFJSWtvN25OaDlq?=
 =?utf-8?Q?/CBd3rhaibsmq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elkvMWNrcjhOQ3llclI5bE12aEJSY0VHRE9MejR2aVNHQXloSnNXY2s2KzFW?=
 =?utf-8?B?WThlRVBSclBJMHdjakJRSTcxYWJrb05tODZOenhDclZHNi92UUhPeWQzUjRH?=
 =?utf-8?B?S1NzbTB4RWJKL3diRVVSbEErRGluNU16WTdXZFJ6eTh0cDRnMDE3SmhYUG1N?=
 =?utf-8?B?aFlhRUxkc0RQZWJjdGh3cWJPQVI3UVdWTlE1aVV3SFI5V293U3F4VitiSGt3?=
 =?utf-8?B?Sm5tdk9yWHpGUGN6YzBJUXRaNDNsYjArbU9MRWwzdXVPVnhvNEVwQVV6dDZ3?=
 =?utf-8?B?bDdmVTFVZDdxZDd4Y1FvRXZSMk5kN0htSWtna0ZSVGV4U1YwRmRJZXdSaE9F?=
 =?utf-8?B?OXlNL1E0am9XNjc1UzJMSEordU1tRUlOUjRlRFB5ZWU5YVFEZTkrdFhsT0RX?=
 =?utf-8?B?M0lYbkljQ3d6dExDVXo4VnREUDQwRkdpSzRuQ0hWOXVKR2hVR0VldjhCdk9B?=
 =?utf-8?B?RjgzNTJOTjRxS2N6QlJXckppMXNlSjZvb3VIaFZvaDlUQW9zREhHc1BQNVc5?=
 =?utf-8?B?aVg1VXROQjRVc2lUUUI1cUlDWFdENmhsZmlOZ2l6dThXMUc3R05jL0hWYlBT?=
 =?utf-8?B?L202WitlcHZqaXR0VXNJem5zakE2cDVFc2dsU1FtbDdWNXpIUzdXK0d0K2c0?=
 =?utf-8?B?VUZYQmwzSEcwam9uQjIxWE8wU2ZFdzcxL3Rtb0ZwbENhY3lEN1l2UjNZdk1N?=
 =?utf-8?B?Q1hOZFU1eHFHbnU1TlhOSWVyWEhSVGZtRnBobjVibVAxb3d4Tk94R2U4ZHN4?=
 =?utf-8?B?ck4xdFI5WG1ZaWlrL3ZUVEJoNFN6SUdqVUgyZFpkcGV3R1hPV2NCeFp6Qk9a?=
 =?utf-8?B?UWFHVWRKbDBMRnZlRC9icTZzRTJna25ITVFKckN1dUVWWE5lMEs1dW9YZS9z?=
 =?utf-8?B?N245aUp0SXlmMCtrZnppN0VFZWNseGdEOE00TGUrTm91RTNKT1J3dDNxcUVQ?=
 =?utf-8?B?NnBEUTRaU01SM2FQMEFmRWlOL2NWck96U2JYNVgwRHBaV0VFZnBDaHZIWWJQ?=
 =?utf-8?B?cGdKMjg2VDB4aHB1R0FwVDZ1MkpHc0NJTnhxRTNzTTd0MWx6em5qKytyTUpi?=
 =?utf-8?B?bTJUU0tPdEVaaWJjb2k1c29MMWFQSU14NXZMci9FRjlrVzZFM1RlRHByQmhX?=
 =?utf-8?B?WERuN1pyS0grZFh1UHUzclpqajdIK3UxNEtYdDY3Mys0ZXlldDlsYTBtY1Jx?=
 =?utf-8?B?bU4wc3RyQjBDNWJQVlVVTnZKSEZXcmhsdlJWelVUaDJBRjBjTFhQVFUxdDBC?=
 =?utf-8?B?WWgwTUNNV1NhZkgxT0VDekNVditVKzNyamZhNGlKb1FZZ0x3UHZyeWdjdnZY?=
 =?utf-8?B?WG8wc2tscHllS2psV0FBdVY1VFpkR2RpNGxZMUkwU3p6Y2l1YVkvTm40YWFC?=
 =?utf-8?B?bkJtR1Zqa2xFVi8xZFBrRlhtY0E1MWErNFN0WkJqMTJmV3RDekZ2N3I4Wmw4?=
 =?utf-8?B?eW1mVldqUytEYUZ0TlVrNU1jOWVhRElubE1YWExQRk9uMTk2QUhhQ2xvYVlv?=
 =?utf-8?B?bnhwYVljME0yRTdEWU5XQlk3YUdyZkt3dVdyTW9WYXJtbDR2S29pSDhXNldh?=
 =?utf-8?B?QkhWVTZDQXRSTTlOdFpyQWlIdzVKdEpQSHlyejlPS1ZvTjZyN0hHVjVuMk5h?=
 =?utf-8?B?ZmRVSGRHbnlJa29uMy9FS3VScDVMQXkvOXVuSmwxSnc0cWtJZmpEbUNxZzNn?=
 =?utf-8?B?b2dWQ2RmamRoYit4MWNoNWpoTnh3S2VZUDdHWmx1NE5TQzZsWnIwR3daY0JL?=
 =?utf-8?B?R0dYQkJnRFhJOThZRXlYZzRzNElhOWFDTUNjMGd6K3FIZTluMGtGWm5kU2V5?=
 =?utf-8?B?UzhwSGt1Z0drMzFLRlNCVHdNSjFUV3cvQ2tYVkNXb1lYK2JHQk5XTVB5Y3V4?=
 =?utf-8?B?MGhzcTUzaEcxV082S25Gc1VGUU1MMmt0Y29DK0FjcFd5Vm1hMmU3c1JnVW12?=
 =?utf-8?B?R05vOG9mSUcvZFpLUTNYM0JQUjFheFdLcmQ1bWlkeGs2OGtNMEZuZmJJVHpo?=
 =?utf-8?B?WlBzT3F5MGVjUFVrNTFiVmdEMXR4ejY5dFZVOEQrUVBOQXpqdUdqMDNYM0hP?=
 =?utf-8?B?S2xEZmt4OGxxcHdXUjRhekZqTEpNTFYxaTkxcnNXcCtzMUEvUFI1K1JNa2NF?=
 =?utf-8?B?RVBmUldqellBN0M5WVJhMXJiR3NNaDhCYUd3b2hYVEhNdDg1VmlrWFh6UDE0?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1yp13Xl7fj9q+1M6p0rzq8+73uGlc2na+q5CmElej+ZKYePI+zuEP2M2YPPHjyevRYI8F8ogXJcRIjFeDLH4SgUHGZvHKnd3uQrCQxk9S6xxU8Crm83z1BqU6B8NM6wt1hDGnU/vJkhES3qrNarLdcCdFc8/AuTZ/boQBsoEHD8hnA1F1IX4oiS3A6bgfKb4zMiMRoFf1MAtBG05LOk8A2VI9/hvZEC/AQqb/38bcwn2Dl+Llr4ZvONpvRPB79WnH/0kEqFJuOygD6TDfbwpAl5HaQsJFUSUO5v7GEipX0aGeFRKv0Rm53wAasmuc44f3E5m3nYT+acEp80zNdkeDl8OMlnqK9tR09bt74eYNZqz7iFvXhHUYLm+6SgkLotpe2vLnwEPW5pYxONgk6K2rKywsGOfdxjdX8W2GXr8c81+euSz9/aoI/fcw6ivf88kkm9d858xxtAQTCdiBnlzxflYAiwsEqlPZ4zusdFO8EmeSnU02OVZIkXLOz5sgyGukGgC11mqn+ETRybqvGgPe8NScLqMLgttBzw/mkSp53t625n3NoJtJE1apUZvqQXepIaTUxtzAXKo4a2p+fkrdDQVZQs6g6vrRMblYSq9F2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc431bc6-d3f8-4fa9-95af-08dd2fcd0b6a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 10:13:06.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ixukc+Bluh7XEsULkN8jDN3y60WeEoCIsxMyBqsAGMO6cdumLXwJIBMokO+++ykGIqPfwVGMPVyiEk/6lElS3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_01,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080083
X-Proofpoint-GUID: 94Q_zNE4HQtTyBtASW3bFcq3Wf1wkwZo
X-Proofpoint-ORIG-GUID: 94Q_zNE4HQtTyBtASW3bFcq3Wf1wkwZo

On 08/01/2025 08:55, Christoph Hellwig wrote:
> @@ -580,9 +580,24 @@ xfs_report_dioalign(
>   	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>   	struct block_device	*bdev = target->bt_bdev;
>   
> -	stat->result_mask |= STATX_DIOALIGN;
> +	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;

BTW, it would be a crappy userspace which can't handle fields which it 
did not ask for, e.g. asked for STATX_DIOALIGN, but got  STATX_DIOALIGN 
and STATX_DIO_READ_ALIGN

