Return-Path: <linux-fsdevel+bounces-64609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49285BEDAFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 21:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEFC19A5E92
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DBC2882B2;
	Sat, 18 Oct 2025 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NvrN7AkV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PAVbJfJ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFB1B87C0;
	Sat, 18 Oct 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760816831; cv=fail; b=mahxPe5aiEXSCRhsXLrOKn7xv9MFW7x7BF35OPX77lV0k7gkOQXlfIGQuZ16SWODPQwk4f7Esnuht+l9feiZHUeIIMb9SJD0VM0fz432vfWhx5oz+YZGTiwnfELhlcKGLDH4r2K+T+qt6GlaesjIUFTzeuHr6mMy4KeOS3G+hj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760816831; c=relaxed/simple;
	bh=mqdiMEm/CTX+V6Yd/xKlQuxsCouPjel0wWQQolZdrQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kStImwhbq/+ZhcpFWZ5SIHkjXqm2bNsuv5TeaxZJzzw9mTFw1xgQDx1rwMQ0zYq+NEXPD0uuFRwBnRHnKPLzuZCfm5YtjiBHfoIGQE+khqZ8akjtmFtCKmykP9fMi0+WoTu7lGY1gO5I1PRTr8c3umoX2+3HfVuMFBfXjCBVW2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NvrN7AkV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PAVbJfJ8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IHqDek017267;
	Sat, 18 Oct 2025 19:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ce4KW7bUCOnMucv+X2Gr6kEJJ47iQ5oVVlsXu5pgKyI=; b=
	NvrN7AkV9Yf+8lOAHpvk52Sr9r/AyJuhGqvyPP49W15yPqLWdRStkNsMb2oBtpVQ
	LdxAfYi93coGDvK/ceM2MCVMlROhwbU+PZeX++ep4HLxNiHodovaVbVYG3JLgWrz
	4v775JE99CE/IpBvUZ63MFpATze63lcyTaErr/ja/HW/9qa9PXjCYDNCApzBJw0I
	nsHWGtTaZh2+jhFYIPyPS1drX2LNXKGWmM6t3hPaFGdb92itlvhcZckBUMXjA9Uu
	SsrwJ+/tDb6GXHbLSHfCZ4DkFmNTXhq7OTa3KNPWH2PXjJTda4sqNIpz18fjO7VK
	l0wMcMIcmfZFgnJi3Hyqcw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2yprg3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:46:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IDYAUx025420;
	Sat, 18 Oct 2025 19:46:27 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1b9fycf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrHtsg1dZtscxT0wJgNDfxlzpmlu4e+EXMPIs1hAGWAnUQtNAQ2fYuCQuYthucGJf0qjKgHWa5R2sItUPO22H3m+MKCFQTc4tRxI9KeZYySI8KwiMkt6bfxMIYuCU+QYcXnd85VAlfo+LjDdW4X8DIVQt6a97sYGJ+w0mPJdb4KxSXaW5Hnukf44CdCWLeSHz5l87fCAkFtT66xgPwCJrL7pglwhSThwn7fJE/G1IYH6mf8KVimN4cM5S8XMoMRl9pIo7vpwTEVSQbD7vfB2tM6Gwkyn2liM8XvB/pu9aI1eY1MoqPgLVV8JflflDIdpykQghrWkkxUGm5JbGraGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce4KW7bUCOnMucv+X2Gr6kEJJ47iQ5oVVlsXu5pgKyI=;
 b=u7WQzw2sVU0xD8ZJfsLFRgTDwZvR7AtIe/csNTN1Yzny1oEu1kH5SEqTAOZ8L9VPFSof3G7DRyj0QP41uyPWj3tf/bti04GtcSYbRez31WPNdKuo35jzCsOAjFXpwKPpSdsfDaBXshR30O2UuoAzfHLbeE/JAm3Cv6q2IfM7HlBUazmROCJxTUOp3WzSVFdWb19z8JIMtLnZoO8yVh9BKvCx9K95Zw2H0CfLo6CqXSC0aQJFiM13P2ffLZhkjBq1w9pHqjD9kPzZ8OhQs2l0XuvxSe5D2sowxf173imUwFxnsuwJjf40NGF0XXpjEeX2mmC5AerKIpooULfkQvxuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce4KW7bUCOnMucv+X2Gr6kEJJ47iQ5oVVlsXu5pgKyI=;
 b=PAVbJfJ8rFaHLPEfGMUbz5A48QerO106qzBJ1awx7n8Jnr3q1Re4ItSxkke21GWDBAilt+QlwPqp0W911nkBsp2huzaPuwECArCNiyOCBQhA84VFfeUn1uajHUdVmF5w8t0j3LuVI0uBmG8rLW7QJXtzKRDM1ALGvyjXG3gbXEw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7454.namprd10.prod.outlook.com (2603:10b6:8:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 19:46:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 19:46:21 +0000
Message-ID: <cc8a624b-6747-4566-b812-e27caf7861a9@oracle.com>
Date: Sat, 18 Oct 2025 15:46:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] nfsd: wire up GET_DIR_DELEGATION handling
To: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust
 <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Carlos Maiolino <cem@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, netfs@lists.linux.dev,
        ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, netdev@vger.kernel.org
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
 <20251017-dir-deleg-ro-v2-11-8c8f6dd23c8b@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251017-dir-deleg-ro-v2-11-8c8f6dd23c8b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:610:b1::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 023c69b2-4033-40d2-52f2-08de0e7f032b
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZXNsRTB4SWpacWRmdUFULzVRbnB5czNkeW8rdklLTVhaaDUxM1g5WXhTL25a?=
 =?utf-8?B?clc5eEd6V3d3MkhmdEROOGFUczFLM2s3WGFPSmhxdmdJbmxLaDE0RTFtYk5F?=
 =?utf-8?B?QTBkUENNUHpTVU1ZL2Fnd0RHbGVIdFFwMGpJQzBPYjM0TURTckgyOUhEU004?=
 =?utf-8?B?azVLVXA0V1pKai9iMC96TVRyZUthZjJCdXpEZEMxcklrY1krU2tJby9STndV?=
 =?utf-8?B?bTQ2SmVRTlFWekU4S1J5NGtpbGd2ZXFqM2dqdm9KY1ExWDRySHJMdUFCcVNr?=
 =?utf-8?B?SGRPTzBjaDN4RnpDY3RUa2ErczMxVnBHajFZSExPbkFZUTdkNkNuSk5sZ3ZZ?=
 =?utf-8?B?VnQ1T0NBb0M2T0JMT01IdjRmU2NZMXA4cG9SMVZaVmVUZFJXSUhaN0RCNXlZ?=
 =?utf-8?B?YTZDMHdRZlBGaHNOUTcvcnJLOXVIQ3czVFljQjZQUm9OT1RHZ3dnM1pLb2kr?=
 =?utf-8?B?TlZucWtGZDNpcTlSdFhVaGphVGswZmVuUkN2VmZkK2MvM3UwNkF2Q01jSGFD?=
 =?utf-8?B?QUtkOS9oSGtlb0wwOGRzR3lvb3dVMVhrSVVZZ2hrOHNzVjZ6dHFOajllVkxz?=
 =?utf-8?B?WmJ5ZEtZM1FUN3hCazJOazJpUG1ocm11Si9rQzU3YU5jcUUrNUZZaDUwZ2dB?=
 =?utf-8?B?dkZ4clJCeStSWUkrUDZ0ZmoxektDcTl4V3h4dTJvZll5TW15VVJ0ajlJZHNl?=
 =?utf-8?B?WmpTUmc0YjRKS2xRM09oN2tjM2ZMMHBMOUJzcjVuQTFCY1poZi8reW92dXV6?=
 =?utf-8?B?M3RYanZOR3JUUkxWN0xiOHlSdjBYeHczOFgvZUd6ZVhaRFZpTnVEWE00dmJE?=
 =?utf-8?B?VkMvTXdLUE1zeWpFRG00L0lKcGJtaEczeWc5Tm9ZTmplRW0zQ0ZzUXNHZDc2?=
 =?utf-8?B?RlU0TzFHUnIxaWwzd2xaQnRjRC85K0VLdmxybkgwbFB0Rk5xVVNlcVNIUkFx?=
 =?utf-8?B?MkNabnpWZmZWTXJFbTlTMldRQkp0UW5uQUFiNFdIdEp3RHRIbW1odzROSDdj?=
 =?utf-8?B?cWFoNHdpY3llTjBXWnFVVktXamZyUEZudjlmZmRqQkhFOWVaaWRPSjN1NVV0?=
 =?utf-8?B?aW9TeDdvVEhDT2R6QUE1VVIwT00vMG1aRGF0V0NxQWpZM1RTV0VBSUxJSjdQ?=
 =?utf-8?B?bkFXUWJBOWZBcnpKNjZlUVU2cXJ5U3BjbkcwMEptUHErSWNyS0dHU2xEZElU?=
 =?utf-8?B?b21kb2xBclhWTGIrUGYvbERTSjZBZUp2SUZsNzBHNnljQ1pOeXpBVzBzNHJp?=
 =?utf-8?B?eTkyUnpUS29MUjg3K1VIaG5BRVdhMmNGQ3l0SHkvK2hKUHo2Z0MwK01FMHVO?=
 =?utf-8?B?SzRqWFViTW9xWlhjMGZ0RG5CMWlmbFhDZ28yWkFQb2lxZU9MNUY2NG1CTmY2?=
 =?utf-8?B?VThUR3VjZDExOWxycE9CaTFwRlhIVFMyNVF6b29LRVhpaTBBTU5mWkxtVWQy?=
 =?utf-8?B?dzJLem9zQjdiU2thdHd4TDJQUysyQ1I2Nk5xM0NTNVBVRHkzNzFCZm1OMzBr?=
 =?utf-8?B?RXdRY3kwQjN6OENySzkzUWpzRkJKQ1llaXRIQURueVZId3UwcHVPbVJwRTQx?=
 =?utf-8?B?L2ZpeDRuRDMwa2dVRllTUk53L1hRMDkzaWY1NU12THNyam9HcFZMMElGMWZZ?=
 =?utf-8?B?SHlsbGtyZ0dsb20vVUc2S2dXNGRXZ2pxZWRWWjNrM3RUOWJwRFp5aW9vODRX?=
 =?utf-8?B?czNuVmMxT3pneTZ6TUZzcXVPWnVKaU95MlY5UkFuMUwrUDZ0dDNRdUU3aTlX?=
 =?utf-8?B?K3hxVGJaZjZSMUwzMFRNb3pIbk9yMGNzQzE0WHk5SDVKSmlNdmVmeWZpUXlO?=
 =?utf-8?B?cTFWMmVvTllMN28rdmJnaVlrMUNkY09nVkFOQ2pIMVY5UzNmZG9QZmh5ajg2?=
 =?utf-8?B?S2RoMDhPYlVmYWtNMCtRUVBkUlp2OHVIdkVuQ1JyTnZUN0NrUnNCdHp6VmhD?=
 =?utf-8?B?YW93MnNnM2VpbVZya3g1VGU2ZjBRZDNRL1pPaW42QzhWYVF5a3lmaVNFZTVq?=
 =?utf-8?Q?gIILlO4Z00gZnkHQ1iqdnTkuIXjdHs=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZFpYZHFUcDcrRGN6NEIzUVg1SVpVQ3ZVUjRHV1REOUZoTGZXdUl5aDZ6OFJt?=
 =?utf-8?B?TGNNdGg4aC9RNGVyeDluS0Z4MUowd2N1YW9iVEhZSzdBakhwNS9JOFNodHpN?=
 =?utf-8?B?QkEyaHFtb3I0aGkydHlqL2toSEh6QlpYcm9GWWU4Ymx0Z2xoVnJBQkQraEtP?=
 =?utf-8?B?S0lyMWNtaUdHblZuRE5qckFjNitua3QzMDRmck1jUlZiWktDQ2ZoYitXQ0RV?=
 =?utf-8?B?MUdoWlFIb3EzK0lHdDZxRUttcFUxR21Ob01qOXVjUG01SWhrRUloNGZiZTBl?=
 =?utf-8?B?L0RNbUIxZDZQalFPOHVvbU43RlhQeVRZMkxMa3RXNmw2RklYejVQdTlBenVr?=
 =?utf-8?B?NFJVUmEwM2twazRBVTJkZ2VBY3BGTlJKa2hTRG44cGtJT2pyWW42RmxiaDBo?=
 =?utf-8?B?YWVybGUydDZwbUQ4cWxNQzJnd3VKMjdNWHNEZzl1UllyOFJ3b1VMVUFmNUFQ?=
 =?utf-8?B?cmdRVDRXV1k3NnpoWUxpWjZHclUzVktHbFRPT3ZwR0ZZMjk5R3VmWkRZL1JE?=
 =?utf-8?B?RkMvcndKbWxhNzlIUncyZFliSlBCYXNVV2hVdEZIbTY3R2ZWMkZsaHcxZmxV?=
 =?utf-8?B?QWUxdmpZVExjQXJiVkxaeldvSWlSQjZBTjl6bkFESlBFTUQyNnMrdlJUSFlO?=
 =?utf-8?B?OUtMYzJLQmlUdWI2clAzMTJWYmUrSUt3VXMwd09tVjVnRHFXeUMyZ2xwQmpB?=
 =?utf-8?B?UUdHOTBVTXZrcS8zS1d4clR0NEhMbytMU0xEWUkzMXkxOEN3eUJJbXYxSUxi?=
 =?utf-8?B?bkUwT1E4VTRXMzdnMzBLendoTUVHT05nQlJCV3pBTUU3aHVxYkNubDhPWFBv?=
 =?utf-8?B?bEE4ZWNTWmxYR0x1a2ZHb2ZENUwrY0xoY2xNeHNBM1hnNEdUWjZXb2lXbXBq?=
 =?utf-8?B?cExxb1hwYlVPSzRNZnJ2b0tQcjdNSFhic2xTWUt5NlFKOEJYZFVKc3h0WUlZ?=
 =?utf-8?B?OW1NbGRGTDF6c01DK3FKSVAzUDNMS0d4cUErWEhnSldxaWlXOFEvb1N5d1Rp?=
 =?utf-8?B?N1Brd2JjRlIzYW1TbkNqNG5ISzIrT3NldDM3ZjFUczYzZktteCtpVkhJT0x4?=
 =?utf-8?B?VUIyRTh0WWFRb241SUgydm41anpZMUtJNnZlT2NJc25yVHErbkpuQlBtZ013?=
 =?utf-8?B?N3JFM3BXb3V2d3BkZjZQN1FNclRyMXE1RXA2aGt3UkEyYzUwdkUvVEQyWEhv?=
 =?utf-8?B?MFRqVzl1VWtiS1h1M0ZaRVZTZGxlQmtlRm5nVFBncTFZSmtES3Rtc3BaUUFs?=
 =?utf-8?B?S1V5bDZTSUpFdTFydnFiNU05SndCYXVEMjBLUzZHZ3llR2d6Tlp3NVg0N1NZ?=
 =?utf-8?B?aXN6RGFwODJnTW1DNG02VWIrQ2EyNlk4QlhMYVlDOG9maXNMZ2JLYWo1Z0dJ?=
 =?utf-8?B?RzM4K0xIQzc1UTVqMkJoczQrUDJoVHdlMmNIRkZHa2NoS2RNWEMxekgwS2ZS?=
 =?utf-8?B?V2NrNm1wb3FCS1k4RCtiY1dYUWhJMEw0QjZDYnN5MWU2bnI1Y1NlOS9FREx4?=
 =?utf-8?B?SWI3TFJSdnNwcVllZC9oRlhXSTFEOWpySjBzWFB0QUc0cEFBMVo0UUhyU2Jw?=
 =?utf-8?B?QTN4WTh3OFoyUWJMYjJOQmorUlV1OWdUTDh5dFJQK2NXUStCcmM4bEpOaTZw?=
 =?utf-8?B?NThXT3R3a1pmWDRRQUQ1T1BsbTFOTEN5RWYvSEkrZm9DWVBjaTArdnlaZ09N?=
 =?utf-8?B?T0VjZmhxNW91YTMvUVI1Z3N1ajVlVFcyYjZ4Q0hFVitIOENQN3Ryd2tKWjZm?=
 =?utf-8?B?UWtNTGM2am5kaXpSaGZkWW9hTWdOcmVFZ3g0ZEh3UHBhV0h5QUNpS28yK1pj?=
 =?utf-8?B?NHEyeHF3YU4zNXE2OE1yRlkrOXpvS0VPNFg0UVA3ODRKVkVwcFpRMVVCYVZ2?=
 =?utf-8?B?aXd4aG5TV3BKNnRONHk1OTZXY1FubjZYUG9OM0xXNlZLQlpGcFJWRVZLSUpJ?=
 =?utf-8?B?TitlcEhocmR1SzR0ZFByZVdCYUd1SDdtU0ZHa0YwdTF1dGhUSHcyYjVBRG10?=
 =?utf-8?B?MW5XclZlSmMrNmovZTJSVGVyUExKeFNjMkdlQno4Q0NEMWxYcVhYR041Y0tq?=
 =?utf-8?B?N3ZHZDd1MW52OTJUWHh1d0srNWIyQ1NpTmd6ZWNsYzZCREZoSmVabGNnWDdG?=
 =?utf-8?B?TlRDajBPOUd0OTJhMHQ5d3g2bGtMell6ZGpWSnFJVUptY2dXdlMxY2hQNnZx?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/3uCIboQZ+0pFbSY9dXX+ToFrusHzwRkLY6WqXAoK4XmHt9HqSEdIv6T/H911HUE/6RVetVtSI5QSaQK15gXbaTD/wE7RviHz9uYg2oZxgoaVLbJQ3JGuY040wkI9rvzW4qPFbPHqD192+WyHFc7pMYGyEsc8wOxv2iE4ECI+n7An7stvBhzqJOJ46Zl7lqrCoW1QM0HZgtFFdKlOm2aVea5wLIEz+I37cWQMNHGbwRS/Elks1+dEdlibFJcGbQx/Srr1CnSxpRUutjcFjoeKgykqJFELHTEHrzVZumJ5NLGKw7cnD9PkohEPa7tJeiBQo+taSW4XrM6C0Rq7gh3dw17zgYukdambTxJXPmAz2skx/kPg+8kQtFuz1sDGffrnjfq60vZb5di8SdcyPt69lKh9OuqCiwFcl7ZbIxvEe31BqlR/CmmQqv0+L1hIQ019Ws1cwkMWLQoO7vc3DapYJEPLFv58Pi3InsJpLNkVuBEOa5oVLzvZ7LYsB6o35pHXesQRva1MTTiKwZmEN0r42V/2y6pHaS9bwcWDp530JY+VG1KHbcmn9nd8VFMfmV+HEvz8viGMeonJw7X29miwddi/RYMDZ7DN/bqVAq/OkU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023c69b2-4033-40d2-52f2-08de0e7f032b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 19:46:21.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGp5v3vcrXvtN2FArulQCY1aBPtO8XqdI71m1+mmUNe1n6zRf+tnxnMgWUS2coFGiY3PbXg3xxFS3XrxurFEYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510180143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX7YZY4aaS1kBq
 WZ6h3Ckg1+yap4ReXErsudhHCaWg9VklKJS4a4AdRTmUf2xyAI/02JmXEg+kPVugPkqX05xm/gL
 SOdUyf+rQpAW1o7br1gEbtCgLILGux2MO1KUQyP8oiuw9auEo0fABk3H3f4HRmQrG/vxRs8KZ2H
 aGqocQUDlYhbAmO4mgw4Fh9f4dbEeHI71xR3fq+s1recbvwfxbJbWyk66D3ykMsBJmPDYf+mgVt
 Oz4Z6b0JKhTNSOfV1DaVDStAWoTVgfV/4rovYL1YKm5qe5LksYet9JED0QSTqpME1PEfj2eMmBJ
 OxqjN357zfg0ziWbuK16lpqhu+Pg9OVKHq39R9gX5wRqQDFkJg4ONlfLkvcsX8J5hryvAAA15mi
 w8MbMGmjVyOQhR+6jb847zlr4raEwA==
X-Proofpoint-GUID: v34Tvpu2blxQG8BPyJay3k8j0NUmvsDY
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f3ee94 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=_f52hmyKKtPQ7mZJ_noA:9 a=QEXdDO2ut3YA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: v34Tvpu2blxQG8BPyJay3k8j0NUmvsDY

On 10/17/25 7:32 AM, Jeff Layton wrote:
> Add a new routine for acquiring a read delegation on a directory. These
> are recallable-only delegations with no support for CB_NOTIFY. That will
> be added in a later phase.
> 
> Since the same CB_RECALL/DELEGRETURN infrastrure is used for regular and
> directory delegations, a normal nfs4_delegation is used to represent a
> directory delegation.

s/infrastrure/infrastructure/


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c  |  21 ++++++++++-
>  fs/nfsd/nfs4state.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/state.h     |   5 +++
>  3 files changed, 125 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 7f7e6bb23a90d9a1cafd154c0f09e236df75b083..527f8dc52159803770964700170473509ec328ed 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2342,6 +2342,13 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  			 union nfsd4_op_u *u)
>  {
>  	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +	struct nfs4_delegation *dd;
> +	struct nfsd_file *nf;
> +	__be32 status;
> +
> +	status = nfsd_file_acquire_dir(rqstp, &cstate->current_fh, &nf);
> +	if (status != nfs_ok)
> +		return status;
>  
>  	/*
>  	 * RFC 8881, section 18.39.3 says:
> @@ -2355,7 +2362,19 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  	 * return NFS4_OK with a non-fatal status of GDD4_UNAVAIL in this
>  	 * situation.
>  	 */
> -	gdd->gddrnf_status = GDD4_UNAVAIL;
> +	dd = nfsd_get_dir_deleg(cstate, gdd, nf);
> +	if (IS_ERR(dd)) {
> +		int err = PTR_ERR(dd);
> +
> +		if (err != -EAGAIN)
> +			return nfserrno(err);
> +		gdd->gddrnf_status = GDD4_UNAVAIL;
> +		return nfs_ok;
> +	}

These error flows might leak the nf acquired just above.


> +
> +	gdd->gddrnf_status = GDD4_OK;
> +	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
> +	nfs4_put_stid(&dd->dl_stid);
>  	return nfs_ok;
>  }
>  
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index b06591f154aa372db710e071c69260f4639956d7..a63e8c885291fc377163f3255f26f5f693704437 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9359,3 +9359,103 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
>  	nfs4_put_stid(&dp->dl_stid);
>  	return status;
>  }
> +
> +/**
> + * nfsd_get_dir_deleg - attempt to get a directory delegation
> + * @cstate: compound state
> + * @gdd: GET_DIR_DELEGATION arg/resp structure
> + * @nf: nfsd_file opened on the directory
> + *
> + * Given a GET_DIR_DELEGATION request @gdd, attempt to acquire a delegation
> + * on the directory to which @nf refers. Note that this does not set up any
> + * sort of async notifications for the delegation.
> + */
> +struct nfs4_delegation *
> +nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
> +		   struct nfsd4_get_dir_delegation *gdd,
> +		   struct nfsd_file *nf)
> +{
> +	struct nfs4_client *clp = cstate->clp;
> +	struct nfs4_delegation *dp;
> +	struct file_lease *fl;
> +	struct nfs4_file *fp, *rfp;
> +	int status = 0;
> +
> +	fp = nfsd4_alloc_file();
> +	if (!fp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nfsd4_file_init(&cstate->current_fh, fp);
> +
> +	rfp = nfsd4_file_hash_insert(fp, &cstate->current_fh);
> +	if (unlikely(!rfp)) {
> +		put_nfs4_file(fp);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (rfp != fp) {
> +		put_nfs4_file(fp);
> +		fp = rfp;
> +	}
> +
> +	/* if this client already has one, return that it's unavailable */
> +	spin_lock(&state_lock);
> +	spin_lock(&fp->fi_lock);
> +	/* existing delegation? */
> +	if (nfs4_delegation_exists(clp, fp)) {
> +		status = -EAGAIN;
> +	} else if (!fp->fi_deleg_file) {
> +		fp->fi_deleg_file = nf;
> +		fp->fi_delegees = 1;
> +	} else {
> +		++fp->fi_delegees;

The new nf is unused in this arm. Does it need to be released?


> +	}
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&state_lock);
> +
> +	if (status) {
> +		put_nfs4_file(fp);
> +		return ERR_PTR(status);
> +	}
> +
> +	/* Try to set up the lease */
> +	status = -ENOMEM;
> +	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
> +	if (!dp)
> +		goto out_delegees;
> +
> +	fl = nfs4_alloc_init_lease(dp);
> +	if (!fl)
> +		goto out_put_stid;
> +
> +	status = kernel_setlease(nf->nf_file,
> +				 fl->c.flc_type, &fl, NULL);
> +	if (fl)
> +		locks_free_lease(fl);
> +	if (status)
> +		goto out_put_stid;
> +
> +	/*
> +	 * Now, try to hash it. This can fail if we race another nfsd task
> +	 * trying to set a delegation on the same file. If that happens,
> +	 * then just say UNAVAIL.
> +	 */
> +	spin_lock(&state_lock);
> +	spin_lock(&clp->cl_lock);
> +	spin_lock(&fp->fi_lock);
> +	status = hash_delegation_locked(dp, fp);
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&clp->cl_lock);
> +	spin_unlock(&state_lock);
> +
> +	if (!status)
> +		return dp;
> +
> +	/* Something failed. Drop the lease and clean up the stid */
> +	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
> +out_put_stid:
> +	nfs4_put_stid(&dp->dl_stid);
> +out_delegees:
> +	put_deleg_file(fp);
> +	return ERR_PTR(status);
> +}
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 1e736f4024263ffa9c93bcc9ec48f44566a8cc77..b052c1effdc5356487c610db9728df8ecfe851d4 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -867,4 +867,9 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>  		struct dentry *dentry, struct nfs4_delegation **pdp);
> +
> +struct nfsd4_get_dir_delegation;
> +struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
> +						struct nfsd4_get_dir_delegation *gdd,
> +						struct nfsd_file *nf);
>  #endif   /* NFSD4_STATE_H */
> 


-- 
Chuck Lever

