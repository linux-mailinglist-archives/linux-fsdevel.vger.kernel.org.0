Return-Path: <linux-fsdevel+bounces-37713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96C39F61C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 10:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11385170C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD3119CC17;
	Wed, 18 Dec 2024 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="AT/q7A1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCC189BBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513975; cv=fail; b=JM8ITUbkW4J8dABx0famD6TcVdd9ZC0lP0pU3iydk5UAR/c4GH9j+cQhcoXPw20qccqc+VsfBPo1dHG99NYfDj+TqX8gW86BevvP9lSlGca49Qkoef0uf0+XjlBJ4FjiGQiC+hJYP/mYpZCeRtxQ4p9+3QYfkSNjeYShw1wcq70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513975; c=relaxed/simple;
	bh=oX7Fvchgz30Cv5Hoxr70jsz7v99DfFukJCLUfei2VoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J6O/BMUysZLzLNPlh/MXe7SwZmxeV4jeuYEbYelVifl+sFK14Ou+CE+UtyC7AljSTC1+gz2jAuuXAmbIVmE0NKItvBwZNrOO4/jV4Vbg1AwMt7rXzaW2sHiLfpGzLzJLxTme00HVAokxs161eA5LeAkiTL//unb9rEHuWI4JY0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=AT/q7A1R; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44]) by mx-outbound14-23.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 18 Dec 2024 09:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcibZdKHGK/YciguaAxnjscXzmDBoNWb9O1n+PtKD9gkrKo6E8nq7upTdpgdaFyoGAt5z0U+SzAzhFEmc0xNUMEkUhoYrStAjzgQ4ZRIlCq252r7olujZma4eH0UWPpKpOfML22fPuNmQvXJ/M5t4I+t5YW6c3q3nOr0t9NISnYnazg3rGONnsFyiSLnfdbkM78jI2I+SyWnkGBvIeyjdjcSP3j+KeKtlPs3cmgTwGlHWB0f3z2t6AXksSbBer2kiAQnl2ThFdAO/PoYMJl6kGy/zFc3aLj4J47q9WQz2000gntWwJMfpKWYI6qX+qLpPTBFFJxzrfjJC1DUGjgdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFKdSiBp6mY3q70I8E/wgihDgxL1qf8Z5/uypeNtYRw=;
 b=MLKj8AFIjHjsxurGB52R33KWj/uTSY7pyMO+UVK+0OLuaew+Sf7Lb+j/oCVlH0wpUO9QTt9rzn+pSdBMQLKF8hfqNXYbHEMurtcURMRDAT/LI+TTPXIvP7uLJVN1zXFptlgbaZbsTX/yBok/msbbBcByWhV5y8AuI5b1I8zMQGNnlyRWI6UWzO2czjzXabtXbl3xCZtlFWronyN6A3ZRIOCdmlHOT3wyP469USUaxbMWZT1sZecmbBM82cSYRZMc+LgD9aMamAMlGURaOEFx+l/heH7UTOpEXkTybZr0C8YOh/4nP4egUCdI6xoGHQ1XEWr2Qs8218NBm1PO3DJGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFKdSiBp6mY3q70I8E/wgihDgxL1qf8Z5/uypeNtYRw=;
 b=AT/q7A1RymGBYT0n3i4Ydg654SWmY7QQ7QVkw2TQ0/9gjTnJhL5FgsdrsN4W+YVtZFfZ9wEZsvrZjz8hF19n774ho4KjDu+k5IXx3LkbNOR2dSs24bUZYJECNTg8ep1FutPyG6uOlctyGNgzHRoAuuQxVhjMS/KYXYwqpXW0t6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DM6PR19MB3770.namprd19.prod.outlook.com (2603:10b6:5:248::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 09:25:54 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%3]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 09:25:53 +0000
Message-ID: <3aa4e43a-745b-4c86-a8d8-12b3b3c85484@ddn.com>
Date: Wed, 18 Dec 2024 10:25:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
To: Shachar Sharon <synarete@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Jingbo Xu <jefflexu@linux.alibaba.com>
References: <20241216-fuse_name_max-limit-6-13-v3-0-b4b04966ecea@ddn.com>
 <20241216-fuse_name_max-limit-6-13-v3-2-b4b04966ecea@ddn.com>
 <CAL_uBtcXdULyu7AK6T0+GKn5mbY2tLtE=uUG0P3CwM9YHyjOmg@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAL_uBtcXdULyu7AK6T0+GKn5mbY2tLtE=uUG0P3CwM9YHyjOmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0206.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::30) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|DM6PR19MB3770:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e5479e-73ef-4675-1a38-08dd1f45f84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUJlS0llNkZ0OVRoc0tEWFhPR0w0dUJJemVYcDdTdnNmWk5PUXlUUnh5WG9Y?=
 =?utf-8?B?VHQzMXZqSEhzay9WTVAyU1l4WDhtNUUralAxLzJ5dklRS0NnenBSbzAzTTRE?=
 =?utf-8?B?N3h3TmdVV2YyRzFqTlFyblFJT3pmaTJDdDdIb3pWdjlrNDBXVXMyd1RoOExj?=
 =?utf-8?B?K3pRbjVxVmFyRzFyQkh3Y25UV0w1ODZwcUROem45OVlCeXpMOFdGdy9wYk5B?=
 =?utf-8?B?Z0dYaTNwZWovWUVzeVBMRzZQSXZrRzJkcGN5L0ZRK3pMWko1K1pRUDRjNk9L?=
 =?utf-8?B?NkZWeXlURlgxL2drWXFzTnZhVG1jR3JDRVlxTUhLMG5hZmxQNnQ4OUpvUXVa?=
 =?utf-8?B?RXRKalR5VDhJNTJVc3RyRUpFdUtMT2J1VmFsNW5aeTFGNGRNY1orc08zNzUy?=
 =?utf-8?B?OFplVHYreUU2NUpOOStaZGdaTEpLeTZ2NW43Lzd2UWRDb25YUnJ1dkJHaXF4?=
 =?utf-8?B?UzdIeHZzTU5mcC9qbjc4RGVTc0wxWGdKZWtNaUVPNVFFd3dPZWJxRldITjFx?=
 =?utf-8?B?Y0dUeXZZWjFwUk1zYmhFUjY2QU12dzRueHdjTzhHbFZncExHK0VpcGJBVXBB?=
 =?utf-8?B?OGdCSldVY1lUSE5yWFFSYlVjVmtOY0pVOGwvVEVlUUl4L05oRndiZU8wUm5k?=
 =?utf-8?B?d0JVZGF4bVg3aEJqanhZQTRoNjlzSmk0R3ZTVzVrM1lYUzgwbHZFSFZkVDQx?=
 =?utf-8?B?ZHB5QnlwNTRqZDhKQ2xVQUIrQk5UMWl6T3NqRi9ZWURaK29WUzgwYUdDekxO?=
 =?utf-8?B?cnlsU1YzR0xPd3k3UzU1b3oyLzR4SEN6Q0UzWjA2bHZwNWlsOEVoQk4vOEZV?=
 =?utf-8?B?OW4zdkJOWkt0QVlRMGJzZkdlMndaUnEwTXVsbjN4a3lWU0FKVzUzTmlrVFpl?=
 =?utf-8?B?c1YwNzVvV2RLaXVMS0tWYytqa0ZZVE15VWpwNmk2TXZwUGttdGFSci8wOGt4?=
 =?utf-8?B?Rkg1WUxIZEJiZ01nWVNUbldOSE5nRmdib1pqTENHOU9sTi9naGw2RjNXR1cz?=
 =?utf-8?B?RHVNbnpBb1pyeVYvanBHUjFOY0xuQVBSK2Q5S2svZGZUWHFLUHdMVEgxTXcv?=
 =?utf-8?B?OExJSkE3RkpjMFA3eWFEeU9sbnN5Rit1UXNCRkMxdGR5aXRYVUc4STFPa3Y2?=
 =?utf-8?B?SExJSDVPdkJrMVZZc09CY0lnbWJqN2s2SDZpeWRsY1QrUzFhUXJBSzZnZkR6?=
 =?utf-8?B?R3R3WGpWUDFNSFhQd1JIaDF2SDJoNmV3M0JmVW04bmZsc2JJREJqcHp5ZFJn?=
 =?utf-8?B?alJIZHRraTBXWHRhTzZ5U0gwUDF4M1ZpSFZBS2lQYS8ydE1Yc0pwOXJXalZm?=
 =?utf-8?B?Q1FEWHVFVzdGVVQzRWtFeHNoZE9rWjV3WUEvNXkyOEc1Y3RjSkU4ZmdOQWs3?=
 =?utf-8?B?NG4yWEFTWFJUVnFyL1FTa0pLMDU2enlmeExMYStaN1hROVBLcCtyUkZ2c0ky?=
 =?utf-8?B?RHdIVW5yLzFNdHV1djZEYTlvZ3d3RkhTMWNGQmx4WjlIcGFTRzhvS0hUVSt1?=
 =?utf-8?B?RHphbkJ1NGMzbDlGdm1ZelhrcFFSeGhEYTVUV2IrY1RYY0s2U284UTB5cjQx?=
 =?utf-8?B?UFN0cGZNTTh0Zzkrc3VGdjdLVFJ6enRoV0lHcmVROExDbWd5RjQwUWRKSSt0?=
 =?utf-8?B?VytIaVljU1I1SGVYckMzQXRCejZ3THIyckZCdmFnL0ZGTDZTdzFaZWRHcXFu?=
 =?utf-8?B?WUhONGphbkpKWDk0UWx6S2poeFJ3YU9YdUFxYVdjTXo2dk1mTFpFcTUvRHFn?=
 =?utf-8?B?TzcrcHhtNDduWmRGVUh5RzI2akorQWdBK1kybjBmMlNiTVltWmx1ZmF4dFRL?=
 =?utf-8?B?eTVsdlhRV21zMDlmSHA5bE9UN2hXRzBsM0lFbGlkMGM4SGpuRElBUDlpS1V5?=
 =?utf-8?Q?PlzXIcsYkOPXx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0orSEE0dmtuZzFtZ2JXMWdZUGt6UXFOY1NnaHhJMTBrNDFsK3BZSE5kMWhx?=
 =?utf-8?B?SmVNaGtzSGw5aXk0R2Q1QXEzMXc0ekVpMzlGWG5oY2xvTjI4aTdFYm1xTUtP?=
 =?utf-8?B?ZDYwUlNBU0Q5S1FFV3ZMTjBMR1ZsZkJHdTJUSDhtUXJ2OHhSVXZNTkFHTmRC?=
 =?utf-8?B?ZnByL3o1UTI1bjEvVWNIUHFvOWxkeW9IaE5NdFJHd3lLTzVCdjcycnVzSjUr?=
 =?utf-8?B?UFRYUWFYZmF0QVFwaWxqQzJLNGY0MncwOFBzZTM5KzhqbUpPNm5Ra2xTNXBK?=
 =?utf-8?B?TUJjSkdaRGgrZEt0M3EvK29iODhFTTJjakFlQXJGWHJMTmcxcWRtemxLYnZR?=
 =?utf-8?B?MENHMmhwYTVzQ1RkdkxxaG5FWlZrKzJYbStVTHkzVUNoY0FrZDI5a2o1eGNi?=
 =?utf-8?B?bWxHMWJDVkZ1UFU1cDUzK3hLMHk4NW91Q2xUY0tacEpYZFYzQUIzVEJaZk5u?=
 =?utf-8?B?TEtoMDNZR3ZKRDhSL1FBbmZMalk1RnVZUkV2Rlg0OHdNRXd3REx5MGZZRjlZ?=
 =?utf-8?B?WUUrWjM0RDR4Y1BRaHZ2RmxUZ2dpdmk5ak94QmhJbm5Jb09BcjM5ODBmOHFs?=
 =?utf-8?B?M0p1UnA1R1NkT0VyOTYwWFhsaGFoV25IbGNtR3VwZFIxVGRQVStPUjVFTDF2?=
 =?utf-8?B?WjFlMlhCM0M3WUpkZVEwZXlxMHNvb25yaEFBYWxRZjhCWGNMWnVVMU5wNDkx?=
 =?utf-8?B?WFNkV0duOWV3dXFQWGFDM1ZDQXBuU0dVb3hMYVZJKzFOQkg5ODUyQklZNFc5?=
 =?utf-8?B?eWhnVWw0UG1iMXFUb1RNWFNIbEpFTmZ6WlYzOW1mSWVTclFDNGFJWEVMTUF2?=
 =?utf-8?B?a2wvWmd1ZjhMU3Y3dFBGdWtkMmdpR2F1NW5DYTRjZEs5bnNwRjRQZ3RIMXZy?=
 =?utf-8?B?Vm9yOXJLKzR0aktIZkhxa0pFRVBweUVhTnNBeUxWRE9wLzlBYUs5bUF2MDRN?=
 =?utf-8?B?UHluSUFpbXVUY1RHaDhQSjFsY2x5NktVdXVXNjMyRUcrN2dESGxXcTlLdzRN?=
 =?utf-8?B?MmM2bFpQMk5vSDhoVXorRVZZdnd5OThnd0QvQzBsWC9rQ0t0cTJXVTR3L2M5?=
 =?utf-8?B?cFJ0bGE3RjhqQ3ovVmgySUlxK1VxVHZEYVRxWEwwU0srQTFHaDJvc1VsSDhx?=
 =?utf-8?B?M0dtb0RwckVDNk9EenZUNXMwUUwydjFqYWwzeUJidVA5U1Bpb0Y2N0VCWnFQ?=
 =?utf-8?B?c0NGeHhtRHNPZ3RzVFZ5enNKdURuZ1JhL2tZOG5hQzRodiswamxSR2dhTStT?=
 =?utf-8?B?OWJ1enVndUl5N1p4Tlc2ZGNlK2RldThJR2t5dE1OU0Y0ZGg0d1lWQWJucUll?=
 =?utf-8?B?aFgzclplOTVod2ViK2RVSXRIeWRSaDNZdUlDSlhjd1FOK3YrRzJkd0VRcHBj?=
 =?utf-8?B?QVpxeko3K1p6WUhBa005bzZUeUw3TFpLWlJGNUxyam9FWlBFK0sySTRJK2E2?=
 =?utf-8?B?MnFnZFVtT1d6bm1sakp5WUlUak8rQW5jSnRNTHJwS0Y4em1xU29TeHJ4Q2gr?=
 =?utf-8?B?dkxwRG5mWXhNN0NhSGhMUFNJOFB6cWIvdzJmeHZ0bmVNcFdSWVIrSFRWR2V3?=
 =?utf-8?B?WGVYcFB0RnprSFVTTER2ZjdZZ1c0T3VKUitUdzExYml1NHJOU1B0cnVaRzEy?=
 =?utf-8?B?Q1ZUeUsySFdhUGh6LzhpN1E2bTcvMmJtNnUxcm1nc1ZtVE1WLzVIZ0FpRTF2?=
 =?utf-8?B?TExwTTFHbE1XU29tUHRyL0ZCQWt3bTJpa1cvOWRzcjZZWXNVRnMxaWdKQ3JU?=
 =?utf-8?B?a1ZIZm1odXJGVlg1dUpYVlIzb1h3aVNWQXMrcFZqaHBER2pVODlrTjQrWXJw?=
 =?utf-8?B?ckNJWW1iSG9LaUY5amhCdkdnQkVxMjVDdkpib2hHYlNYek9UQ2p0QXpseDlI?=
 =?utf-8?B?UVo3QTFJeXlsc2xjZ1p4Y1lpRU1jZnBJRjBEK3B4bFFHb3VsMzlDMWEvL3pF?=
 =?utf-8?B?WkVYaVIzdlJmUExRSmxhOXh3Z2ZvcDVDc253L0tiQ3YvSTVIM1MwMWZwTHpW?=
 =?utf-8?B?dzB1Ui9MOHlQWG91ZnZtbTlrd0JXd3k0Wi9PaWQ0YnVLUDA4bjVkYTZXaHg5?=
 =?utf-8?B?UWVTaVlMZWpUcnRxVDJxcEJqaUVpcGlyc3kzVlJJL3lGTW9QWnZLZGd4Y0V3?=
 =?utf-8?B?UXNlMWtPRVRDZ0tWUVd0STVmMmdxT2Fqay9wTXhBTkV2Y3g3ZFltaDJvblla?=
 =?utf-8?Q?ROhbdsNkrxjAVcKFbSBDashyoa7sRIKMioXv9KaG+fT8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0/FVXXJPxTyDjYhN/RxuBSLetRwK6Y4MMDQJjqZBJz943K5PLrBUS13S6ZYz7d+NuMcofTgpmERG5xJGCC8QhQ7/KtYR/+70lfmeo5Bwb64X5/foCoqe1WSZflgwuq0WQdLgb4pZEFyri+rWptRXUMLUJsFgB+BZgn9sbfOcXK/V5S1rSS+YPr7WHw8xnzswjbfkpvV2tsP/mRK44QQDqQ1uMNdsiUBf+NVebn3LR/OxbpuOjlit1CU4iwIEiY/fkYUjJB5hJOqdYPj2kRiJO9p7RY26nlJALgQWQX4ZR7s1g3MT/Mz4Le4rslFPTKHjU+wz7snQpYZtD/pUR6akBXb3VqwHhbB0c1msOQD0iKK+Ft6iNa4f/haMmSB2+k2hiWTsX2hlXWB9Dn9GrPRLjwk1EvcNCAHqrExzmXT7ZRKx9WO8NaJqGSsAfiCoxIiHtVAYlQViywvP3x1KbSBmSGVVci0jSDSGoQ+VBMDJj7miqWN43nHkU3Tft+Ifn3ZLpxLLCwBTrHnqNMIKP4g8NYjSkbzdAQ4f4U6Gi5TLno554i1SHJwn0qHprpc/dX/jMq4BDJCL2JP5MH3XN4CUYYWJ8Vk0JUOBQSSyS4oBZ/uuPuK9KVUHCsmnwaJDD8GX24UTlr/1y4TLit+IDRrw9A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e5479e-73ef-4675-1a38-08dd1f45f84f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 09:25:53.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXx0qdfTm6QZ9SkogRfYiAZ53DMrDs8Q0gW8P+yxhc4i9UbUi+BfvnzEvAkcODtAXg2iEkhhQOly4QrBKbxwXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3770
X-BESS-ID: 1734513957-103607-13346-2989-1
X-BESS-VER: 2019.1_20241212.2019
X-BESS-Apparent-Source-IP: 104.47.66.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamlmZAVgZQ0Ngg1Tg50czUJC
	kxLdEsOdkgNTXF1Mg8OdUixTQ5OclSqTYWAPZWNQ9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261188 [from 
	cloudscan12-226.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 12/18/24 10:15, Shachar Sharon wrote:
> On Mon, Dec 16, 2024 at 11:14 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> Our file system has a translation capability for S3-to-posix.
>> The current value of 1kiB is enough to cover S3 keys, but
>> does not allow encoding of %xx escape characters.
>> The limit is increased to (PATH_MAX - 1), as we need
>> 3 x 1024 and that is close to PATH_MAX (4kB) already.
>> -1 is used as the terminating null is not included in the
>> length calculation.
>>
>> Testing large file names was hard with libfuse/example file systems,
>> so I created a new memfs that does not have a 255 file name length
>> limitation.
>> https://github.com/libfuse/libfuse/pull/1077
>>
>> The connection is initialized with FUSE_NAME_LOW_MAX, which
>> is set to the previous value of FUSE_NAME_MAX of 1024. With
>> FUSE_MIN_READ_BUFFER of 8192 that is enough for two file names
>> + fuse headers.
>> When FUSE_INIT reply sets max_pages to a value > 1 we know
>> that fuse daemon supports request buffers of at least 2 pages
>> (+ header) and can therefore hold 2 x PATH_MAX file names - operations
>> like rename or link that need two file names are no issue then.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev.c    |  4 ++--
>>  fs/fuse/dir.c    |  2 +-
>>  fs/fuse/fuse_i.h | 11 +++++++++--
>>  fs/fuse/inode.c  |  8 ++++++++
>>  4 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index c979ce93685f8338301a094ac513c607f44ba572..3b4bdff84e534be8b1ce4a970e841b6a362ef176 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1538,7 +1538,7 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
>>                 goto err;
>>
>>         err = -ENAMETOOLONG;
>> -       if (outarg.namelen > FUSE_NAME_MAX)
>> +       if (outarg.namelen > fc->name_max)
>>                 goto err;
>>
>>         err = -EINVAL;
>> @@ -1587,7 +1587,7 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
>>                 goto err;
>>
>>         err = -ENAMETOOLONG;
>> -       if (outarg.namelen > FUSE_NAME_MAX)
>> +       if (outarg.namelen > fc->name_max)
>>                 goto err;
>>
>>         err = -EINVAL;
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 494ac372ace07ab4ea06c13a404ecc1d2ccb4f23..42db112e052f0c26d1ba9973b033b1c7cd822359 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -371,7 +371,7 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
>>
>>         *inode = NULL;
>>         err = -ENAMETOOLONG;
>> -       if (name->len > FUSE_NAME_MAX)
>> +       if (name->len > fm->fc->name_max)
>>                 goto out;
>>
>>
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index 74744c6f286003251564d1235f4d2ca8654d661b..5ce19bc6871291eeaa4c4af4ea935d4de80e8a00 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -38,8 +38,12 @@
>>  /** Bias for fi->writectr, meaning new writepages must not be sent */
>>  #define FUSE_NOWRITE INT_MIN
>>
>> -/** It could be as large as PATH_MAX, but would that have any uses? */
>> -#define FUSE_NAME_MAX 1024
>> +/** Maximum length of a filename, not including terminating null */
>> +
>> +/* maximum, small enough for FUSE_MIN_READ_BUFFER*/
>> +#define FUSE_NAME_LOW_MAX 1024
>> +/* maximum, but needs a request buffer > FUSE_MIN_READ_BUFFER */
>> +#define FUSE_NAME_MAX (PATH_MAX - 1)
>>
>>  /** Number of dentries for each connection in the control filesystem */
>>  #define FUSE_CTL_NUM_DENTRIES 5
>> @@ -893,6 +897,9 @@ struct fuse_conn {
>>         /** Version counter for evict inode */
>>         atomic64_t evict_ctr;
>>
>> +       /* maximum file name length */
>> +       u32 name_max;
>> +
>>         /** Called on final put */
>>         void (*release)(struct fuse_conn *);
>>
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 3ce4f4e81d09e867c3a7db7b1dbb819f88ed34ef..4d61dacedf6a1684eb5dc39a6f56ded0ca4c1fe4 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -978,6 +978,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
>>         fc->user_ns = get_user_ns(user_ns);
>>         fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
>>         fc->max_pages_limit = fuse_max_pages_limit;
>> +       fc->name_max = FUSE_NAME_LOW_MAX;
>>
>>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>>                 fuse_backing_files_init(fc);
>> @@ -1335,6 +1336,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>>                                 fc->max_pages =
>>                                         min_t(unsigned int, fc->max_pages_limit,
>>                                         max_t(unsigned int, arg->max_pages, 1));
>> +
>> +                               /*
>> +                                * PATH_MAX file names might need two pages for
>> +                                * ops like rename
>> +                                */
>> +                               if (fc->max_pages > 1)
>> +                                       fc->name_max = FUSE_NAME_MAX;
> 
> For the case of FUSE_REANME (and FUSE_RENAME2, FUSE_SYMLINK) with
> large file-names (4095) you would need 3 pages (PAGE_SIZE=4096):
> fuse_in_header (40) + fuse_rename_in (8) + names (2 * 4095).

Sure, but if you look into functions like fuse_perform_write() and
fuse_direct_io(), fc->max_pages does not account the header. 
Maybe not documented as that, but effectively used as "payload"
pages, which is also what the file/dir names are.


Thanks,
Bernd




