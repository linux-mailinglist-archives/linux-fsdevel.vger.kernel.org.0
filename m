Return-Path: <linux-fsdevel+bounces-51323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F837AD57B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FBA3A2CF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755128BA95;
	Wed, 11 Jun 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="haPCEzAo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SVN1n0yR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55D27FD49;
	Wed, 11 Jun 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650203; cv=fail; b=KPODJRa/rpaDnaxsDjRasPirJsUVMvYeNi6L3+VHxgwbdfN4cR9+fEJ4bDQ86EPWFhYsfT0malujps/FtlBGpgrFR3WFli4UugLuhgfZUKeJjWmeh9ulu2GDMZrlfCexRad8taOn6ZSXN9cHsb/6pJKI/rcL5wRiLWrhOdoLZD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650203; c=relaxed/simple;
	bh=YRZaOSS1WGpXiKsEomeAt1rkw0QDiVpj1IlHcec/PzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k5rXlVpe8rPTZRjZ0JjIyKQK7C9dmBU/QIX9XylZpLn44CCRnxLg1EtYHCCKjEPgp/gvSZYxxOl/wr3IoZMi1ZEvnfSy1pY6yZMFrkHcE9BdR8koZm5rVuDWrowjNEVoX/FduSMSPgf/dkuefBPl5+bnGmMMV59axUcUMRYak0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=haPCEzAo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SVN1n0yR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCtaJS025337;
	Wed, 11 Jun 2025 13:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uB9wDGH+dA84cno4rdznQmlMXuxOY2GLj7cZVYLMx58=; b=
	haPCEzAouY8KK3mlp5oIDlbD/pga1mxiBiKqvAtQ3ds2ZKBjjV5K3YZKTeO0kTSD
	VY34qVYCP0Si0YNSGAuF6ALoiiHl7mc/4C1Ngg4aelDg9BmpbsL82uKr3H48Qi9s
	Q5Cv4B1/mf3R120RBTYbwXIoKDlVr/WYZXV3m+KQhfgxd+Epxy2lwRyP2SfoO/j6
	d3iLdHhrWuF3pnvNsnIVDG+NiucBECRC7BD9lYHqfWLoiAK/IGnkwGY2ILGJgknh
	oVKoW9p5GVsc/nfD1NheyHIiy6wQprckI7TQ6TIfD7l+hRrYTyijPOIc3FGzx5tW
	MEzjNnkQX+kIn+ajtngZQQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14f0bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 13:56:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCqVUX031404;
	Wed, 11 Jun 2025 13:56:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bva76wv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 13:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYhnd47qhwRWZbVkHrF+Ilh1VPLxiiPJkPxflOKtpfu+/bsGa7YD/G/Q5J9/xiG2dfYL11Y2YIWBvNckizjuk4WTaavERFIiH7jb5SOQqF7dfgTmLwvjYYVT9KRwXG6Ehsi1i1KXL+uAx6CNw1bISMj9dgU55Lh73zGirt9cm/l3OXo5Ppso1xlDUM4XyQIMOqIfZxmyE9ml8vk75ectmETGzvU7moj81s/pI6vMEuyGpQXLqtQ8u5nte7qTyBDFg2TieOvFnf6XnBjcmkje3wOL9EuEMKI5RNqMhIoFzjUP6OuGB0q3XEIbY8mq/QwbbXt1rTM3oU6NNZyObqhn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB9wDGH+dA84cno4rdznQmlMXuxOY2GLj7cZVYLMx58=;
 b=QUC2XXINlMYQcs84rlqvxgygV6UHS5lNR4S0O7vseKlXh4lpnkDz6XutHJVsYoW61Q0ACeKVz13tjwYswuRdfEk2LQiPpccq9Yved2xrolIGzChQHENl2Voz9lIkxh+HZ7KT4/f1ajE7JOPQ3gWVwwrLr0oNb8F7LVhIGGNpm9fUdXiUpGCMtrgpNnUDAcqnIXwLeBfIB/qMQ1fQWBv6woyvmFnDjHecmQRlKW2RTpXvaH1RG5n6aFmeySQ8eNvgUK47SuxFjFlWIf8Iwi7OEbiTU96LnMAk2lmx6PmC8kjZeWuJYI5GTNv+orm+T93azgOATIP7rj/xldCbYuCfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB9wDGH+dA84cno4rdznQmlMXuxOY2GLj7cZVYLMx58=;
 b=SVN1n0yRh5vlRXMbCMPvdwHa21kpdH9sLuJiCp3tcV3MTlrXrEmsvNdyGKIoVVsfbL62lGFJ0jPeEks75HOzt1Y9YIEKG89805T0NKgmfhyG6JCshl/JRLC5tPIsvmIG7NTRERUDGRRTS0Q/OuMonJOigNbECbej8jFPDMjYlWw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH3PPF55F79EE4E.namprd10.prod.outlook.com (2603:10b6:518:1::7a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Wed, 11 Jun
 2025 13:56:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 13:56:34 +0000
Message-ID: <72f75b36-a0da-45fe-9197-ea2102ee963c@oracle.com>
Date: Wed, 11 Jun 2025 09:56:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org> <aEko3e_kpY-fA35R@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEko3e_kpY-fA35R@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:610:20::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH3PPF55F79EE4E:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b40ba3-3e5b-4d6f-89fe-08dda8efc687
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ak82TnhkamROczZpNmhzcFNlM3J2ZGlxZEtnUmpvZjRiTGs1K2Y4NFdkUHFa?=
 =?utf-8?B?RzNnUDFUZjc0eS9VNUx1NnBmbnpYODFmV1lvWSt5S04yN2xhWW05emVxNXNl?=
 =?utf-8?B?NXBmandWV3JKZEtYYmFDZW1KcXkzY0JBQmNxSnNQSW5VRlNDMVZYK0tvOGVI?=
 =?utf-8?B?TGE1U3RRTzV4UW9xVDRiYWRBblp5dXV5Qm8xQ3FQMEk2NmNFdm9CUXh0N2hN?=
 =?utf-8?B?ckZUUFYwNUplT2s2UFFQQmtMMHVHNUlzU0FreUdrcFZUTnlwanlTc0g4WHll?=
 =?utf-8?B?VTJvNnZKNXFQajBxS1Y3Mlk4UWRBckJVMWltNEZkYnJtK1IvQlBicTRlMGUz?=
 =?utf-8?B?d1JtRXlGVEJNZm56c3o4ZlNib2JzRzladjdITGgvYTNVWE1RN29jTVFFVURY?=
 =?utf-8?B?VTVSb1dwdXNWRndsOUFTUnBoUjN6alk4V1o1M1FuY0FKczJMM0RubEJ0SEdL?=
 =?utf-8?B?RWVkU2R1a2d3aVMxdWR0QlVOUThraEcrWjdnTDdta2NHbGZEZjJBQXdMYUZl?=
 =?utf-8?B?L0FTNGROT1RqamlXOU5TWmhYL0JYNmNJeGIwdWJBOGVzNnFyU2YrQVpqS014?=
 =?utf-8?B?U2xQVGNGcTNxVWdMeHFvbmIwQXExRXlUWGkxYTBLcTlsYkxrUFBJQXN1TU03?=
 =?utf-8?B?cVVabVUxUHZ4Q1JuVG4reUR1NTJ1dEJDa28wVm1nMUthcndQbmpmUUc1Y1N4?=
 =?utf-8?B?UmRpQTRuK0xMNW16WkxCS3gvVGE5SVFVY1pTME1nbUVEeEVtb2hwcnpqemJy?=
 =?utf-8?B?bmpuc2trTFhlazl3U09BUnAwZHErT05FdHBtb0Z3dTRQeCtJQk9MOC9wUnh1?=
 =?utf-8?B?MUxyMHo1M1Q0ZTBYSysxVk45cmJsVGo3Z2VEMk5uODlGeWl5anEwZlV0cXZW?=
 =?utf-8?B?elExY0JGTmlhbXgxakJML1FTUkR6Wmx2V2V4OG0wK1puY1FaL3FLUDVEeUV2?=
 =?utf-8?B?c05tdk8relBCRU9VNU5MRm1PazQwUnFyaUtDK2NZeDRzZlNXbHFOd0R1NHBm?=
 =?utf-8?B?dTl2QlJCWUFVMW90RytETW5BNTdWSEMxemRzN3M4cVVveUMyM1BYK2t4eHFO?=
 =?utf-8?B?b2lYZ0dadkdsQVJhTVltQ3JRWVdyQ01qWWc2a1orYnpqV0RzT0FIZUFOdjZW?=
 =?utf-8?B?NGRUekIwdHVXNExRaVJMRU5BV0Q5b2JHdmYvaXZSS3pZb1Q5ZGtkSHVlL2hI?=
 =?utf-8?B?aUZaWlRwTm10K1hwWlhXSDM2Y3FuMWkrTkJyeWZ4YUV6VUFwWVliZWFueTYz?=
 =?utf-8?B?U1hCK2psbVlXM0JhTGJtODRYcWVoZzFBSWhlYjMydWQ5TWlYNlAzOXZtb0Jq?=
 =?utf-8?B?a3JQMTVyV0pVZ3NUcEVSbExOa1VXME40TmNienQ3QkdrWGVCcGxjSkgvSjdU?=
 =?utf-8?B?TTh6ZWlya2NmVXBjZDVTdnR3Vm9xbXJhekVwdXltUGdCSE53ZlBNZytiemFk?=
 =?utf-8?B?TFhzbkdUcGE4ZlFoSXpxZ3BNV1BRWjFPNEhwS1pSUUFZcXQzckt3bWxmU0hH?=
 =?utf-8?B?eEVFM0taaHA3TDlxOWkyeG05VlFEcWlDUTZzVVN4WmllQUtmQmhETzdzYWxE?=
 =?utf-8?B?ZVJLWTliL2Fnb0hKaGU4Vnl5b3FkYm15Tk9sZUpqYTlMeTFSdk5JdWViYklF?=
 =?utf-8?B?NSthUGpDd1hDQ1d2QU4zY21aNkVZejRqQUlJVCtiK3pPeEdpOThpOW1CYk05?=
 =?utf-8?B?amc3cEpwc0xhSHhRZjRmemxYaVFHMzFCMDgzNFdHQ1hCZlBXNDQvMXdLYUx2?=
 =?utf-8?B?TWNyaGpHWTdTeS9KV0dGdkdkazdINmt6cUYvZlo2clFucUtTd0lkdmR1T3NI?=
 =?utf-8?B?a2F0M2tqaTJpdnhGNDlzSjltQUgxVlFUYXFRcWFHUDErckJCa1ZwcHVlSU45?=
 =?utf-8?B?Q2xSSkRWaExZYmNUYVVKSW1QYjJESmFqYm9TMGxaTFdyM3pVZTU4V0Zjdk5q?=
 =?utf-8?Q?90iJvicQ0lc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WHBVYVJpL1A4dzhKazFnR3U1UG5OYjNSLyt5ZWVVdFVpOWpTUlM0bkRtWXhB?=
 =?utf-8?B?aHBsMDJFVnZrOWF6eUdWWlFnNEcxSHlmdWxKVkwzNnNUbnVLMHVRQXJEMTR3?=
 =?utf-8?B?dkhWc1pOaGlvQUJrZGIrZmpoK2VYbVc3N0JsRTl0cVVEQWp1YWh4VmVmOWJJ?=
 =?utf-8?B?eHpIMlpjZnZrcWN6OHdMZTl6VGY2NWViK0doU0NXYXBGLzhxcEkzclAzODI3?=
 =?utf-8?B?STRabVROcXpxVk5CWUIrc05JcXV3YjBDUGxqTWpDajBvc0c3dHlicVg0Tnl3?=
 =?utf-8?B?Sm9oQ3lOWnpER2crNFVwU2RTb0ZZU3JrZ0JTM051YUpqUFYweUJZYWNQNlpj?=
 =?utf-8?B?UGRxUU1Pa29Ld2ZmSTUyT2RXRXpvKy9nRzV0dEtnNXplcWJBcXhUSmJXd2My?=
 =?utf-8?B?Q0lveTZxOXE1Z2NVU1FsU1ZSaUF2NWVtQVJtSHJ6bTBTYnpUZUQyc3c2RlFU?=
 =?utf-8?B?TmQwWVhudTNwVXFYNEF4akxvYURmZFJZZWc1dCtvZG9TemxZNnJiZU9sLzNt?=
 =?utf-8?B?Vy9ZZjA1TEZxMHp2aXBNWThaQWpwUkRVb3JIV0JISGVsYWtyTmoxcTV2bDJ0?=
 =?utf-8?B?SEFndnNzazdHKzJqQmtGMExJbEp1YjM5d01TQjA3WWl1UFdDbnd3VUQvRDhz?=
 =?utf-8?B?OUtqMW1aWE4xbVRXZDlQSFRKbHQ0ampPWElScVE2M0pHeTBhK0ZtblIzVUFr?=
 =?utf-8?B?UGl3RDhDV2JaM0FvMlF2aDFLdGkzRTJRZHFOVHlTdnczbjZ0SG4yZFYySitQ?=
 =?utf-8?B?RVdOeVZ2eXMzbEs2bXJCMW5IcjhRNmpJM1AxVFB1c2RCVnNWZ0Z2WVM0UGxl?=
 =?utf-8?B?WmdydHl2V2o2WDd1aDFNQjJlR1QyaGE3TVdCWUl3Rjd1cWo4QUJBekM4VWVv?=
 =?utf-8?B?a28raXE4SDJzZUJVRHF4UVNSZTN5SUFNekZWejF3SFg2UXAzV2U2WWQ0bXlT?=
 =?utf-8?B?VHVSbHJYRmxoaVFzT1dsZEg4VlJTd05JUTJ3V1JsNVlqVURxUzZ1eG1GRFEz?=
 =?utf-8?B?d2FPM2l4TW9yMjJ2ejBhVTc5dXd0RXcwemEvYWlETUpSaW95Ti85cEgwSHZV?=
 =?utf-8?B?OStld2h5dVllb0JJd3pQVUo2RnMzcWg2NGhqaUMzVEJ5RlU3VFRSdEt6SzNy?=
 =?utf-8?B?TXNDQXFVMHRrUjliaW9KN3BtRlYrZ1gydmZBUkYvZS9iNmRhYW9zNG96UzN5?=
 =?utf-8?B?YXFSOVJ2SDhSY0I1cDJrZUJVZDQ2VTYydUFDVUZqTDlVSUZoV0FIeVhGSVJM?=
 =?utf-8?B?dThJQksvVUNNaWV1RVRiZXZUWXdYRitqS1lIWVNyTE1WdFdBYW9TTGVLRHUz?=
 =?utf-8?B?WitONHBLK3R2WmdCSXBlRUorc1B4V1lVM3JjdEZ5OCtxVVBPV1liL21VRC9l?=
 =?utf-8?B?T0pYWUlUMnh4R0cyZHI5NGlwQnE5dmFRWWVUb3V2RHFkemptcUxiQ25EK3BF?=
 =?utf-8?B?V2ZhVjJkSUJKNVpUa1BOdUhuTFJLbzRiK0pGWUo5RGJtQnFZWWwvWHZGckZC?=
 =?utf-8?B?UHdheDViV3JPa3FUbE9MVFFTSHhsQlRoYmhUZm9CL1JYMm43QlI3K0YvdWpX?=
 =?utf-8?B?eDMzTXg4Q1cwQnE4NDFSeS9MZXRmZmlPUENqWWs3VUtVbFc2VEZXbFpYQURv?=
 =?utf-8?B?TWpMNzRyRGtCQVFXMlRUd21jU091YVJ6MXMra3h6aXkrcEthc0tuTkV4blB4?=
 =?utf-8?B?Q29JZEoyYlhUQ1czMVJnSVJ2Y3E5anhseFRlbkxRN2lURnlQTU1PSmhyemRN?=
 =?utf-8?B?RG9ZbkVKQzBRZHVSQ1YrRk4rMVFkZHN0WkFjc1dNU01KNkh6eEh5V1pqREVX?=
 =?utf-8?B?VXpWUzc4WmdjQnludURYcDVmcmwrTExodlhNRHcweVF5MEFqV0FYeXpSUVhm?=
 =?utf-8?B?OUkvMlZHaXFGS2UwODNOWExGNDNFVDBwcXJkY1dsWDBXWkY1TFlSNXBoTkhJ?=
 =?utf-8?B?VHAyYVVCZ01sRG1JSHAvdUZPTEZXaFZ6eHVwNVRTaEpyb21qb21vTFNDMlRY?=
 =?utf-8?B?M3l5TExvd0s2Zllma01RUjhQbzkrOXVCS08xZkMvWk9vM2ZkQk9GR0luWWdi?=
 =?utf-8?B?QldiWkFBQ3NGaUdQNHhzZVlvY0I0b1hTVUpKYkpsK3RXdEdkQmxTc0ViYVlL?=
 =?utf-8?B?ekR2SUlLZVltYkhxL0RYQmlhOG45RmpvYzlXNzlMV0FhL2Rxc1B0blVSckpm?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dahUJ2T6OuYde1FOSYU2ELjYdeUOq3OuhbzA9ZNjsfwIuVPs+gJZZZprOpR+oa/rHldz1YsYygiRsZzVjktisDHl5Jvu90suQNCBUaDXPseHAZU48/4ArPgTN2Lz4oAWtMjc+sM1N0qCGmS7rFDjzXeOdUbP2nwAsGG4jb5wxfZh4nttBeLQg8cPXS+FeB2U1th0aRFYtiBYVPewACSTQU71XyouQBaSpi11OZSDuMOyM5UoD0+JgJYegn8ttSBccrIJZ8qrEvVe+bDNDTiaGw2CQvm8lTMKtPD+z4Px6RLXKqV5NhuUsvgE++fY1NWO0/w7JyPmucAXpKpunJPt29AsZw1URX3iPaTd8OWmY++7jYsLLxuER7xr3V4JLrdb8tgWHSwfe0fVe2ipINFVcPp/nI7sE41lsYUhREPnNS8CGX+JeO8q+wM9UqlRcm+Ed2FqeGeXHeQnWo1IjbV6KqAXP+QxU4dcB67z0tgSX6BD8NWyjBDCNoowQQnlEQn08aIbrnnG+X5IHrwvTPhLgguS5lqV2ToEaBurML/9nbRovY+hefGk26qn0ngfVKOumfdN9FZtvCYC4i5zWrBttRPZcaYYKQooizA4Vz3nFlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b40ba3-3e5b-4d6f-89fe-08dda8efc687
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 13:56:33.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyvoKgEWJZKx+OtZgjJPHTh69kB/267vmK1Kcpx5SYtYnV6B0FaS4MfmbuNNH3iF0+hEP1MVbAEQzFbt5bWWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF55F79EE4E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110116
X-Proofpoint-GUID: fL-9K3FbV07yboe2avkaQQCyEHOGV5y1
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68498b15 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TRtTYcYt5kwXhoch:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=8bSh9sUeZFcR8Tf2JZcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDExNiBTYWx0ZWRfX0ALxjA6ELEH9 wOwLoGlmtj9tc+08gpB9TnPFZIvtsdHJ8n6RnF06P2z6KwyO8yqOIl6U/D+2qwX7bGHlUhMECb/ npmY0IwzdcOQjTouQqFS4veEGWSkZ4vd+2DhMi9hV+RxhgNiaFhgeqWPdsptKRHmEJpo4LUSorS
 kRe4JYJtzehFR99qy/J5/ifB7OmMNOrRobL6XGgTD0fz+fuYFnEpOTgZMgRXBV69jLO+pVSmX+b T8mP/T4mWdwWcxAC991dOjOI7KCiucp8r2KZNEeI5oY3yaJg+Zl70VECrYckad3rB4/vMLwbNRi mOajyuuVvdKcQncZVISMOoOg08b6E4V9PJ+m67yUm+gCHzJE0tPc7QW8JzUJPFtAByeBdSN/5Du
 E3R0qn8k0ZI9HIuoHTKjZUv2M/cSOlScP9Fu97WHEtJB9180Fz6C216D10FNik7aub7kqMuw
X-Proofpoint-ORIG-GUID: fL-9K3FbV07yboe2avkaQQCyEHOGV5y1

On 6/11/25 2:57 AM, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 04:57:32PM -0400, Mike Snitzer wrote:
>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
>> or will be removed from the page cache upon completion (DONTCACHE).
>>
>> enable-dontcache is 0 by default.  It may be enabled with:
>>   echo 1 > /sys/kernel/debug/nfsd/enable-dontcache
> 
> Having this as a global debug-only interface feels a bit odd.

This interface is temporary. We expect to implement export options
to control it if that turns out to be necessary.

I don't feel we understand the full performance implications for
most workloads yet, so it seems premature to design and introduce a
permanent administrative interface.


-- 
Chuck Lever

