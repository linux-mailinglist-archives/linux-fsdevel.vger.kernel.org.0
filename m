Return-Path: <linux-fsdevel+bounces-73074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D508D0BB37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 18:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 196D0300BA34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F4366543;
	Fri,  9 Jan 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="zraBzlnB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248323644D1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979781; cv=fail; b=n59tPpdLyq+PoA5dzeeFrsfxBxF4C/G+WjqRn/MZtaGxAV6Fxa6PK527anT/U/aF1/NSunFL6mWskd/kenjGMMQXuFhj2+xYPCMXPB08LmSCOLk7M63YaesrPkRCIwtTcZRHE5ZzF0vYqzyT5jxZo9w+NHbs9ZDg8pKzw23IynE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979781; c=relaxed/simple;
	bh=eW+YCp2sZH/IXef1Z1dgA4R4W0z32g8K/mHqi0zQYgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NMJLqbBycYQYAXm+0IpEy3UCaMxnpTuuWVNOGvJSLsQrup+0djxu7S+8Va2BJlOzA6bJ5hO6Pl8xlxjAQ6GClG2zjxksoLyTPh1qP1C0JpYEcitIiFMdm4AO4mlkq5HkIjOTLdL+UK7Vm7QqkWni2MBBjOA5H4oUJJdvt63ytqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=zraBzlnB; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022138.outbound.protection.outlook.com [40.93.195.138]) by mx-outbound9-132.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 09 Jan 2026 17:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYVaskLLyj9hq5V4f63WlmHqkfAWLEy17+Qh/2IrSF6Hc29RN8sSXJqjEMKjGMRe0oq1WLMfyc3bujhPWSpjPSiugvkJwgq1ot95nFn2xNSQUUGTcJAJfY6L2gQJG6saBW1PK1GKqzpSRaDBIFLpgvbPJYMCkWTluKIAgjRqssrTEfTDL59ezEKgVAIisdZiCAMEYboSW+HJaQo2auOEFBgT+BP6ryp/HM3G1MVOR09xU0bnGlbVLMr4k2CIaBU1VrOa34p8pzBs48CervUKrHrikMzi9HWHI3DkUYF39W8Ygc8qMOS+Hp121+WKwBWyewHVQFqOsGVxpWjVqGKpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/DRRM+X+R8qOkXuJuzrn1hWjEbaQKrqeOM0U40jbwM=;
 b=GNQCJ5VTZ+y+0rVns+g6QreiVfhHYM/L65HNcAj0WRr++H0w5P1HUqFxp5uD+vLlgbJ4GKOfXEYYPmInbDkjWS4JTOZENDUnSEy0i4OkyExn8tjRvurX7qEq7SfwTny3+RIkuz0s3yjaJfhfmuu6/VXKE5eFDIruFEIYzoc7vzBgpYjChGujbiFLye7ZT1v2NFN6JcW9lsNKaLXNG227xf/LSYvsTQD5A9ist56cXLhxd5cfGNx85C1D3+R0fk8GrccW12s+uibHB0VHSyKz0Esr1+XLymyp83K9x2AauTkiiU8JLj12jD2YdLIgGitGwebbwc7A79+sncygPO21Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/DRRM+X+R8qOkXuJuzrn1hWjEbaQKrqeOM0U40jbwM=;
 b=zraBzlnBsNOJEx66TjCfDyNxU1IgFL4a/WpciuM15AWICm5T1IXUSrqpXN5a4zUlYz2CSm/LvM5FoCHfThjRW3G7G89vE9GpqXQQKrPs5Qm/jVOyJBhMVZGPJkNpoie2sB9qK+cdkDUOm8lUI7zxNFPa3s104fNdLyaLyhwAQL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DS4PPFD0D1E5D67.namprd19.prod.outlook.com (2603:10b6:f:fc00::a54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 15:56:31 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:56:31 +0000
Message-ID: <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
Date: Fri, 9 Jan 2026 16:56:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE
 operation
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Kevin Chen <kchen@ddn.com>, Horst Birthelmer <hbirthelmer@ddn.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp>
 <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0471.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc::13) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|DS4PPFD0D1E5D67:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3aa1a2-6bf8-4503-f63b-08de4f97a7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2ZHbTBVRCtCbm5hVFAyWEc5ZGJUWDd4WDZJaEFOMXhydkV6QTFaZDVlM280?=
 =?utf-8?B?VGxFazZ0VkxROUppWDZzVGN6MEk4U1EydWFDbWpEbUE5aG5rYUFtWmhJTHJV?=
 =?utf-8?B?RzN2cjRjRG4yVUZMVkdPY1lQOEc3WGR5OUxCVjlrVW55L0toK01zS1I4RGwy?=
 =?utf-8?B?MWF0em9DaDBWQlZIMklRbjk1UFUwQ09IM2tFM2ZKNzQzZUhPbVgrQ0MrYUtp?=
 =?utf-8?B?dUl3bFFUT2lNYlFsVG01WmtqT2RHRW8zNXV0QWdaNjMyT2hjeWFhRzJmUTVp?=
 =?utf-8?B?bG1uYmF2OGJ5TjRuMTN6UEhLR1VEUkxWa2Jscis2eXIweXJ1UjdSMllFNUQ2?=
 =?utf-8?B?ZlpLYW5tZFE1dTlnSjN2Zk5pS0dvOTBhR3A5eHpzS2E2MnZZU0NvREhPMnBQ?=
 =?utf-8?B?VkFuNi94WFJZUms1bklxSlhUVmRDNCsxVTlPRnFwNHVXMFJOQjV0SzlBenVK?=
 =?utf-8?B?SlM1bzhwMkpRSnRHZjBVK2RCdzlBY1hURzY4M0Q5eS8zNFAwNFJsd2Y1MU1Y?=
 =?utf-8?B?S1htVGROdlE0djZUcVZLTjhaYllocVN3K2l4OXg2N1NwaWVmZGF6ZW1MdSt1?=
 =?utf-8?B?a2JnWUFZak9WWlhBeWVlbXdybEhTS0JyczZtMjNSNjdIS2RKYTJBVlR6U3Zl?=
 =?utf-8?B?TW02dnhQdVVhZzZXMi9yL0N1ZUJ3RWMzWElaUWcvcENmNG0rUTJZUzRsT05X?=
 =?utf-8?B?TVplU2NIdE9LMVFhdm5HRXNlQ09TTUJIUHEwd1NyZS90c3J6c1dsNUZnYXBY?=
 =?utf-8?B?aXNXUTdET1NVWUFmeUhJbHVNVjNTVDI4SGJHVE4wbk1wRy9Ma0gxamJiSjAv?=
 =?utf-8?B?YlpXUG9ieXIrTXRQRnNKdDV6YlY1RFNzUnRMZXh2NmNrMjRNRHZ0SitoVUk1?=
 =?utf-8?B?L3ByOE1uaDZWbHJxd1A0VDBrMGpnTHlJYkVkeUM0VXZ5MTVxejN1UGNtUnAr?=
 =?utf-8?B?WEQ0WjJ4OU5ZUXpCTjBGUk1XZHhqUlZtQzhjVmRMYXd3S0N1NU5RLzhPWUVk?=
 =?utf-8?B?UkVpUGN3NTI5aEVHWkVySEhmWVVnVXBWemdGMUQwVmlnYnh3MVoxTllLZi9U?=
 =?utf-8?B?VUFEeWFQSlpPbmFGUHZXTitXQ3AzcHlkbXUvRC9zVjJqdyt4cU9hb29xSkg3?=
 =?utf-8?B?NWNhUlJ3WWUxTmVMT1dZbUxOaGs2OW1ZWlZpRWNxQTBTakE2MDM1SFJzNy9k?=
 =?utf-8?B?RlN0MmdCWkVFSVB4QWFhdVhaOUJYUWVqYjl2T0k2K0x1aHBsdEFsdUZ1Q1dv?=
 =?utf-8?B?b1daZmNYMG5sOUc3bUl6L1c0VjVsZ3RHYXVXQmw0YW0wVXRnT01SRWRQNzJa?=
 =?utf-8?B?N2pPdkRqYjdhZHVZcnNhbU9DazJhdVB3eHZ3UFdDam9RSzhtL1JrdlBOZGpu?=
 =?utf-8?B?eGI1cjQzemhUOTIvd0oxNTV4ZjNoWERzWUl4amJuK3VlV0pDa0RRV2lpVkMw?=
 =?utf-8?B?Ui9jMDdsUklUNVVGMkV1UHBpRlNXTkQ5QUllOXkyUlg1Mmg2Tm5oMmZTQ09S?=
 =?utf-8?B?Z2graW1icmxBUnlEVVVhMGlGdVc2NzRBZy8vOExyelN4SFNodzZncVJWNDNH?=
 =?utf-8?B?UzVJZkMwVENBSW1EMEVieG9vakZrdElOV2FNdmlhTENQNEJTWTdFTUd6UXhW?=
 =?utf-8?B?VzBHY0hwMkFocTVaNmx4bkRhaUlKbmhxTlBSS09BUjJaSk5sT1hNRWdONS90?=
 =?utf-8?B?RjdZRE9iRzdabS9pZDY1TlBsWkZDRHd4UmJwUzZ3UzJCZkg1ZVVXQWVrMVMv?=
 =?utf-8?B?bC9UZ3hoVGRWSjB0UFh5NEhPNHE5c2dOajFQYnNROTk3dDJxWDJHU3RuYUQy?=
 =?utf-8?B?aHJsMHJCNytJbmRLY2h4b0xrb3B1SFI0OVRYSmgvekk4ajFjbi9FcE1zSzZN?=
 =?utf-8?B?NTF4Y3RWTGJHbVFwOXFqcCtTWDBVSG42aW9USW5iVmhMUEdMTEtiZXR4SHoy?=
 =?utf-8?Q?ayk4JLo0lu7f660ymgrE64saqhznc1KT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnVUMmZtOXVPWjJjV1ozY0JXb0RWcGx1VmgwQW9DNmRDY09GeUFYSE5sTGVF?=
 =?utf-8?B?QnpzcHVWUEI5RTBYY0JTRW1xQ1YrNGhXa2NLeUUvWXpJcmF1RG1qS2dacTMy?=
 =?utf-8?B?Mm1XSlpXeDAvTitZQU9hSjg0QmlWNENYeWpZVlVYUGEvWVdoNk5HTS85MHNq?=
 =?utf-8?B?YVMwM1VjZTBnaGVRY3JZaU55T3hDb2lKNDl0YzI5TkFtSVQyei9LOU1ONExa?=
 =?utf-8?B?RXFVNENBYXdJM3dzM1ZpelhKMzZRQkdEZXlIOE0vd0p0ZDN4OEI2cHlyekp0?=
 =?utf-8?B?ZEZCcllBV3gyZUVtV1FFV3MvMUY1WDJMeGthRmZSWXlzSmttU0lYUWNOV1Zv?=
 =?utf-8?B?MXZLbWxndlNkWFpLck5HQzlmbXErb2hiMUJkY3RMTU1KcWR1RVpYdW4zSm5m?=
 =?utf-8?B?MTUxbGx6Y2JvTVdZOUhVVlJPVm5MbXp3K2t6Z3VHd0Vib2RvSE5GMWtzOWMx?=
 =?utf-8?B?ZllqL2dwaG9aRktlTjdzN0JvY0lDQ0lwMS9OUUVGamxrMGExck1EMWIzUHR1?=
 =?utf-8?B?bktOamVSYitoYnRJT2VjNnN2SitVbHdmUW1DZGhGd1FYUUdWc2ZSRVFiUWpS?=
 =?utf-8?B?VGJ0Y2FDaUo3NjdSVzdZcHkrajlTUkZ6d1FZNStHMU41dWdjSWdEcnlpUndP?=
 =?utf-8?B?NnJwaW1aTmgvTk1WWlNpU0g4QmhyUzNGNy9kZ2tvd0JZNitaTzZkK0haZHNk?=
 =?utf-8?B?cTg2ZFgwRDgzaThKZU1HNXduV1h3WHhYVndGRVM0NjNTNHZrUjBWaVNrdVgx?=
 =?utf-8?B?cy83b3VrcXhEUHFUUGorZ1YyMVZHa2VkQXp1aktqMWMyMi9zeHcvczgxS2VY?=
 =?utf-8?B?VVp0UXU2YVFWakZwV2lRcVFxRWZkTEV1blkyeWgzZS9Td3B4MEtlRVkwN1hl?=
 =?utf-8?B?Zyt0UWJwa2cyc1owU1dvSnVFZHkvMDE1R1p4dDhSL2Q5L2JCRXJnRDVlaDlv?=
 =?utf-8?B?ODgyN0pXNlF2QURTOUlFRUdMam5Rb0VPNlZwUUFJUEJDMGJTcEM2azlvbkU1?=
 =?utf-8?B?K2tjdkhmN2gxdFNlNUFyZFNvZlZ0QWthZFJWSThYNjNwTWhvSmhNOUhCLzEw?=
 =?utf-8?B?bDdnQVpPZFd1Q1pVTEV0YmNkN0JxdHExYXVPVXI4U3ZuUjZmVGZISGV2SnB6?=
 =?utf-8?B?bDdVYVNBd3pFZElPbmdGRFVMSVVkaW1hZmkzU3ZFc2lXS2FaNFpoUWFqakdR?=
 =?utf-8?B?Mm9SL0hVakNhdWJxRTk1a2NnTERHS1V5S3kzbk16UFI1b1VxQjBDY1ByVUhx?=
 =?utf-8?B?TjNraXhKeUlBYzdPUCtlOUdzeHZ0K2drN0xYWlhpMmhPUHBicDhpczNJUXhO?=
 =?utf-8?B?a1JSeGN2SUxvekxKWklsSHRZK3pYMWdERTE1eHFQbWhQUVJXQmhUL1hzKzY3?=
 =?utf-8?B?MVdKVjFWTzdEdFp4aEZ1RElYTWpQeWRPT24vc0lSRFBkODBmOUJCOGd3RU9w?=
 =?utf-8?B?enJtLzllZHRYc3haSjYzdlcvU21JUlR6K0lCY0lwdk9qRHltczFLQlR3SDJv?=
 =?utf-8?B?SDYxQXlrV2J4MUNqeDQ5UjRsak0xTEhES3lBa1FmRXMycjkzQ0FKVjZoazRB?=
 =?utf-8?B?Zisxb2RmUlRYR00rekNtVjd3Skd3WG40WktMeC9rbGtraHFQQkhmMlZDcEFj?=
 =?utf-8?B?WTF2aDhPeEZzNFhHb3N2L1o1OWp1eHlQZ1JnNG15SXVNbmd0cHV1RmxIbDF1?=
 =?utf-8?B?R29rOEpuVEljZnV1K01ZUy8xZ0htcks4Um5IZlRzSjZ1UDJtMUNSUUZpdWNi?=
 =?utf-8?B?clJGeGJpYllBSzB3ZkY0bGhFY0tRcDg0M0NlZ3FoNGFaK0FLc1YvVjBodkcz?=
 =?utf-8?B?SlU3UG54Nm4xTGRBUEVUcU9LcDFTSEFwZlVESXVYYWMvdEdWc2x3Vm1mTnZp?=
 =?utf-8?B?TzVqUUNySHYrK0FnSkdkaHZlc2p0MzNveVozZ0xNN01CSVRDWFhoeVpxN1dP?=
 =?utf-8?B?NDVqcFlRUDF6RFYyQTY2clRyaTRNQ0g3NjYrcStXekxuNGtnYjI2bXhQR1Bv?=
 =?utf-8?B?bzkwbjZ4MWUxNklKUncraU94STFQR1ZvUUFMMjNYRWFHb21lTy9kSjBtemEv?=
 =?utf-8?B?bjV0eEtpU0wrbFlMUmN0YWxndlFpNDR1OGxSc0UrY0EwVHRGNFBKbWxuRzlS?=
 =?utf-8?B?RW5Rc0dwZlZYZlpWcjA5QjZJa2lOMHoxRmt4Mkcwb20ycHZKM2c0azQxMEpK?=
 =?utf-8?B?WG90T1FWZ2dkT0RzdXY3MWFIVTllV0sza2NXdEtrT0EzVWpSbFVSeHlQK2pa?=
 =?utf-8?B?VGoybGdwVytleUswcjFJb3Vib2VpTFBhdXRxRW4yNURONlJKVXpaN093aUhi?=
 =?utf-8?B?SnNaUDB3ZHloV0lhR1poZFJEL2RqWWx1RmhTNXhrWnhYUWtvMTlEVStHWWpm?=
 =?utf-8?Q?MSFDGvPHMjMDK5y2rlUffoSdOfXdBYEh4kaDlJnmzDbFk?=
X-MS-Exchange-AntiSpam-MessageData-1: oobIUS5GULpPzQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ij5wvCZQ13vSy/HK2KFgHqKej5PuuOzt0N+eC7ysf2qV1ewnOo7M7GHpOqMy8sAK6kRiUPQoa9pIJmoYeSF/975PMCgtu4nlUUcQmMxzsAE4fILw5AEyhpOBp9fEuSTaQKNv+uQ53M+MaqZCE7iQbINV5qLoJNLmfiYvG6h4W0j5vMdWaS8vNPIdGY3RqyyjszVU2x2fPcE1u7L0y2Roe0lGZE+zDthb3vVUKlp2tfczUgyZNG41gePeYOb2hBH5pvrML/UsWJdmZvn7BN8qmaw2KzSX9X2IvBSrpjMfpZBNudWOnvfcgnmcZbyFBKB/cFvCGxf09l77ctkxFuzBZehRO0G9h8j/gGywxZb2d2WK1OpLwDhBkpWKO9wMXw9bOY+h5Wp1KpbawgfZXV2iYSpuTjCxs0+Qv7KH0X2DrY4q/VzA4V7Tr5Qdv6Y/J1f0Xbx8D3DcOonclXh2earoeBGVtpmItCFIoF1BvT5YZPHYusGhrxTbnXnFLhGPHmu0Tt2JXtC1KgKfYLCKb+cvdoRLO8OjALf7LBjJM9VrHVVtTfgYvSMaisnf5izqazNSuNrBwZ4chXsTK4yrzQPG0cNl0we94Res4klVBmHIvcjmi8qVWQ/zlRQv3el+eh4qcUoRGskx3EEJaK0TgR/TbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3aa1a2-6bf8-4503-f63b-08de4f97a7d8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:56:31.0827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHhdRItOrHAzwx8ay+Lnxl/CodSbIhDi6mLR95PJlviKVuEg7uttYpylOURBS4WkcSVqQ/3bcpzxNEc4yI+YNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD0D1E5D67
X-OriginatorOrg: ddn.com
X-BESS-ID: 1767979777-102436-7788-21319-1
X-BESS-VER: 2019.1_20251217.1707
X-BESS-Apparent-Source-IP: 40.93.195.138
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYWJkBGBlDMyMQwJdk4ycwsMc
	kgKTktMTE10cgo0cTCJMXSPNnc1FCpNhYAM7TpbkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.270277 [from 
	cloudscan10-231.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 1/9/26 16:37, Miklos Szeredi wrote:
> On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wrote:
> 
>> What about FUSE_CREATE? FUSE_TMPFILE?
> 
> FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN.
> 
> FUSE_TMPFILE is special, the create and open needs to be atomic.   So
> the best we can do is FUSE_TMPFILE_H + FUSE_STATX.
> 
>> and more importantly READDIRPLUS dirents?
> 
> I was never satisfied with FUSE_READDIRPLUS, I'd prefer something more
> flexible, where policy is moved from the kernel to the fuse server.
> 
> How about a push style interface with FUSE_NOTIFY_ENTRY setting up the
> dentry and the inode?

Feasible, but we should extend io-uring to FUSE_NOTIFY first, otherwise
this will have a painful overhead.


Thanks,
Bernd

