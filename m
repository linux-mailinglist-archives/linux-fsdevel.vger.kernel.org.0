Return-Path: <linux-fsdevel+bounces-35791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DDA9D85FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D7E163C7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB491A9B4F;
	Mon, 25 Nov 2024 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UUcXxkII";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J1DDOBWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A3567D;
	Mon, 25 Nov 2024 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540273; cv=fail; b=mwCrlRyoUZqO0CcbECpo4kdGv/lyBJ4ktFaU1JMJ/6dnMNaB34Z6GPkatENTf1Ih1M8QOn9xPbzsnKZbFmfg/SO2tfjJPqWZ9St5rAUq2lOEZwnU3UtN8PVqbAgvWqPGHFeGqbHoEOjFwlt4s2Tog6hUFNrnExfxv+oUxYnk6bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540273; c=relaxed/simple;
	bh=Ol6NGslWeERGFtvJAnKbaZailgJoB+L3/zYd52za2As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EPdcbUHdmsuOXA/CefKjpUL5xVN6aL9iFVuBWNL0o86cdKu+LvECFqdQrWizJxS9ISeU5jKk6BgGyRuEe6PhN59ySz38V3HTdLbrYh9YqTIAWYiheHfn3JMa9QmWjo8TlpXq+Dbb3yrdtSEnSIzv4YQC+6f42UO/QvLOIibZei0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UUcXxkII; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J1DDOBWP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP6flaX003734;
	Mon, 25 Nov 2024 13:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fVAJTo7zbea4PGaPf8
	8kFLZxOW1MT2u/eAnqv6LhYEI=; b=UUcXxkIISw5QFtLVyL/t6V/pVHRa/QFvqB
	bFdRl9c+cZk/v4gbGaoEV9PFFod69CXHlqrCYLmzuMx++qI24Wuxk+oECt5kizfC
	Lo3ir8Srpi+EnfNh2Y7wSHmHaX5CpIR6orgm2lObmsNDOHievWQlKOwz205WoltE
	PYAUSlDymM+1wNZ268EuvcS3EQobXDodNsz75Qw7k2aTJwo/7aawXx+b54RjsWbq
	I2VIHIzZk/gqne5mS+95PiLeGRvfCw5S0lLfBBxzUMnCv1e0rQiQ07WpdO4f8GAc
	2Esy2jLFpgznxLpNCEMIvg4FTwVaRDPp4i+9BAGQl/tJOhTUxCwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384e3185-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 13:11:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4APCF17Z002614;
	Mon, 25 Nov 2024 13:11:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4335g7qkva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 13:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML334S1SlNS266uaIdHotHsOGwg32hoVyMyiRX5wVn9wwX5nkbh7RK5yklVgC/0tvR0bXAb0NRAmkqgL0z1SLz4V+u9sOpXhjAQd2y2vu8UrBH4N0mTsFOTvjsI9zKsHrINKZX39tDSenQAVtvgPUHJPaUNEoyYARpkpa7kn7nzifki84aAKl6c7AJmFdraVXMjFmtcUQNIvgQlvhibFVdUevhoCGbRDoHGNTvaqiAwsyYKlZRQtCqs8ptN8GjOJsYRCtzM+TStPjtpm8ShZMoBrpj7dISrzj5iMIcDaG4iLCKETe+6cQb9kB7Tp+9O5ZTQ9nZFDLFPufrhkBIj/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVAJTo7zbea4PGaPf88kFLZxOW1MT2u/eAnqv6LhYEI=;
 b=IjQF5htiGW4MbGr6UBRHlD80x7Hs2r7BYnhRYP2/Jhfl290Ag3aOro+QOTUGvyV8n7roNKJ677gj0kRxS0rq8yH82CAQ3HdMfn0HyAqoF+9X1cV4GkwCTRToXEX0OzS8t0EMqPfD0X2YKIBisC+KOSpJutDDMDxT+G94v88keo6GUD0LTdxebG0PwapNURbWc/3o/gzKo+6J9VEJwKbrvQYkpglDhHcPqgyxSjmdJQDHDnhcv689PAgp4/NmguTwTb/krtMjMLrRELWIu5xpiYY2kMEF3bMTOc4yeQMxP0U9UgSUC/AatFmnNriuVuaw6nm3YXkPN5sH6H0Ypwa2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVAJTo7zbea4PGaPf88kFLZxOW1MT2u/eAnqv6LhYEI=;
 b=J1DDOBWPRbCmUn7J+uJaizgnDEexTtYM7STO8Yp5iahMXlEYEEVqCdEJPdaSvLcMyRvtoD897KPlV38ZIlrNcjeSKHAPtQqIX6OSd9rwh08V+L9najLi+PKMp6ZkPim1Kr898J4FbZJKKdy/Fqkm+oClgETldV3biDDfoTdQmYU=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH3PR10MB7355.namprd10.prod.outlook.com (2603:10b6:610:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 13:10:59 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 13:10:59 +0000
Date: Mon, 25 Nov 2024 08:10:56 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/26] nfs/nfs4recover: avoid pointless cred reference
 count bump
Message-ID: <Z0R3YExU4TT1V4FH@tissot.1015granger.net>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <20241124-work-cred-v1-15-f352241c3970@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124-work-cred-v1-15-f352241c3970@kernel.org>
X-ClientProxiedBy: CH2PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:610:5b::17) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH3PR10MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d853f95-3551-4b42-afb1-08dd0d529aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lCqWX8Wzv0cdsf9J6RTg5Jtenrtt4e5gDnGRHRYTfjjjlkhZ0AmGS1dKZusB?=
 =?us-ascii?Q?GsXSmz1catfRmdb4zdz78GOuI2A3szn6Z7KYKd/gRKYsjS1j/ar9za8UYrNo?=
 =?us-ascii?Q?y8IGoqtJA2HSQecdj6kGGZORI2vJwjnX0j/FIWWffBkkxGaK75x7jktJC+lA?=
 =?us-ascii?Q?pfj9M++oZ1yoa/tfRVSxox//0B00SBt9K+fYLu4HYfOfKtOaZnIzg4n07mlY?=
 =?us-ascii?Q?xFs+toPQgnODcvtuw2dljq3pXywU5Nb5fsLnJ6PLgWS2sam3AoxzV+9QZVvr?=
 =?us-ascii?Q?Tkpx0wgVrst1blTSaHy00LuoOjG8VxGOlyVwdKOV+VL1bQV9pifZyNQAeB71?=
 =?us-ascii?Q?312evYddT3jAj4IzjjxrLlHRtrnFlaxzafkjsN2JyzGzaSQOE+/5nwn2zahH?=
 =?us-ascii?Q?ai42owMebhspkb7BIbtGHd96JvdM5oBPTef/xbjZSXXSKf/iiCdkwGFzltFB?=
 =?us-ascii?Q?BYAZCx8tOtM8IEz4jE5hQwimmZQAGsb9hqURXKYxlovb6pV59Xn2kb1lzDIW?=
 =?us-ascii?Q?leKfUVD60GSekBM6bI4CUYGjeynaP2sT/2PDocgu4k+YqWpR0HEeIcNFjmuh?=
 =?us-ascii?Q?l2YDnMGmu9G6oseiV110IOfCe4RhIxDfFwXyFqtm5wydUXNQb+8JjjkVLUdn?=
 =?us-ascii?Q?Cyg+u3J66/Lo8T9XZgKyefRqvjHuEV/9SljI7BdHbJjdhY5INaHTX9ZUDiqv?=
 =?us-ascii?Q?jGBy6LlZbHC8U3JUMPHxcgrjh5t/SnMopAFaQxRoq8fWsbptZ0RvImqGrZGK?=
 =?us-ascii?Q?2eA6FvQaRuXAqRCP2PQRVAqGvIj/NsNCicM7gjmoe8c5eyyqStIHsG7m7ms5?=
 =?us-ascii?Q?MlwilZY3Xr6lKDWf5ygw2Lxq+24qHlcB+IvXy4sVa007bWeXSl6pB+sOGujN?=
 =?us-ascii?Q?OXYwbMxTjl8adzKej3ANiC/PDeX58OJTkWsfBa+NFHFpv15U/GDf6wiFvhNv?=
 =?us-ascii?Q?EJUyc6PwRa488IHHfD7jO92/SQHq4Zf11uDqqMy2sMmKxImmjt5l8ATBeqzn?=
 =?us-ascii?Q?1oOd21k+emKodImHrSsYh4BGudezmEQxlE4h2nIO62GwT8rkSwzgfPujhds4?=
 =?us-ascii?Q?fgs0op/SGnYz2peR+Q/voPh3kE5TpyNXbiJ5tjtWwJPT/MFlSNM3CmGmVMgU?=
 =?us-ascii?Q?UKtZmQNz4gUrK7N7TpCLGE+h3njH1lN4Eau7bVyj6HgS8BzdavbTCcVUq3UQ?=
 =?us-ascii?Q?bxZ5zLKNOkQFverIPHBRjNMLJg5GfuEaUoKB0BtZWyWCkbFX1yAcArSX5gez?=
 =?us-ascii?Q?NWeF3i8jONDRvZ6m1VLwK5oiYAlRK07kMoIOGb7TIyFxcAHK67mHl0TzydCH?=
 =?us-ascii?Q?yc4fZMQ9FzVG5xkcAmgFc/1pnNuThm9W5uymeEuB4DKArA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qzOwZfhVSKBx4LDjyGAtMBLHns3tZ7ICROq386tQuYv1AONsZWGzh0/ICJO?=
 =?us-ascii?Q?YoFJMJnpYVLHi10pZ4PCoo/i73udiSOfIDBP9r+6eqzdlt4muCMtC6WjYI3l?=
 =?us-ascii?Q?uNR0jSqwI8t9FDM0jWkw/gO5Xj2JqRW7gF6QOtWR9jde0UWCvhHZwA+H5xm7?=
 =?us-ascii?Q?w8Q6mioVaPF22MxoXVzHtguIV/fvYbhAnmwchZqKPsxbHv3STnL/3MaEPSLb?=
 =?us-ascii?Q?vIvM0cQLz9oZ5wmDjO1Ge0SK4YfZIzmPlvVMNndIziUyOj2KbOBy6N5rpTzs?=
 =?us-ascii?Q?JPga9a1wqp5K3Mur8vB+jQGpJ6omxLeFCMZUZTIytUBy2ahcvZKgK9dpztWb?=
 =?us-ascii?Q?9UG+bbQXhaMkIalftfhbO5FrdRJIDh1JDOcOHGn+bN15ZywUZW4Of863cwEj?=
 =?us-ascii?Q?1mMj5XUZ0MlZrlilFJd2UEGcsDfDzFTfXKEW8rRjUrfOHKBQikt6JkJZg5oQ?=
 =?us-ascii?Q?wsK7VzKAB16Kq5cDeO+ceBXQ2XkjxqWtpAPqGzmd4n6zqmCC1yfUfuvkFf6s?=
 =?us-ascii?Q?vymc4xryrw1Oi6gG7735xZcEOshd/lZi3SUhowpFFwb4S1v+b5zvIn7xaI7c?=
 =?us-ascii?Q?+B5717nx8cexA3RTmO/dbJbWE9/uZSncyZ0FF/pM6VVxjuYM3a1HmNzzLtr/?=
 =?us-ascii?Q?mn0oqJY/ziK71Be0W8qO3QMn09NoRHn6FHmTY+LuEQrvEqqbhrI4S51DBiGl?=
 =?us-ascii?Q?wuTeQd8Yw+VJi6Q3zd9bRu0qesyotE85YS+Oo6PP2CMVxSg2a3/jNMyiu0yO?=
 =?us-ascii?Q?1HlBxPHhqwKw5KrmBTV6Ki8bTqSWTmijyHSolfr2GwppkR5Zv2KZ5fr51DFh?=
 =?us-ascii?Q?yj6y1PeeZyszqAXKmUQGqd9KjURua9ut3tEmCHTtyv5Aas7bgcxrPM/mmRca?=
 =?us-ascii?Q?TodL95Ijr3VWzgNjUxfotB1N5u1aNaO7r1HHva6ZeLx3ti+rUWpBpkhtMfB6?=
 =?us-ascii?Q?5b6CVwpFm7FS4d3R9Z0onBOHsJxWzHUfPHXeqbqCF4DD36vESzaxt9MJJxPM?=
 =?us-ascii?Q?h0xRjMMnltBqkuFWS/RSnRWXQ0YfesdzkuoeUxyD0GaG+ABff7UU+5wqyBJU?=
 =?us-ascii?Q?gDmUu16U37eRybct9mD7KmPRB1qRTAoRXdDolQdQE/rXQOUgDs2wZ5crZ1Wu?=
 =?us-ascii?Q?C+gdsnsWH+HZ9hIWOaXWCfdtkj2hrJ2BtlNTEGCsYVdfwzwdQL0l9VJO1udP?=
 =?us-ascii?Q?ZQIhGz5s/mB64/Ho2Wi5CAVsrMhSL4ZphpzvKeLUk+9URXhPdOWi9F25RZ96?=
 =?us-ascii?Q?j9IBaTZx0X6JFKf3dX6lzNgMylgez7XF/0y8b57Qh0jYJ9ivCrnu+tzLRxCv?=
 =?us-ascii?Q?dLavH19lfCpA6oAULVybGBLAvc7y59pocyFEDOqSaKX67c+eXpHLjOeehR1L?=
 =?us-ascii?Q?KQtfXjIWDGP430GBonB/JSKmjme1D7Nh20rgTFcinRurkQ+4FSWDC8oaOCR7?=
 =?us-ascii?Q?NTxeASfG8D5LWajQZctAIyOZPUlsK91H3bSc/6Pmp8Ub9+Fc3ymIQJf/2453?=
 =?us-ascii?Q?dax5d1R6wja8XSSmnc88jnAx0JrAarEPEUcHbKVyApKyxECYq3hH358kbzBV?=
 =?us-ascii?Q?8Ee83I6HMf17m9e2+pz6PT2dgTmUkNeGL7VC+26s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JpkJ/kETxoUCqduUeGqA43Ye1GbFAjGNw4xJMLy13/QupJbOUVdgcIiWhwUkoiGWqsH4dQ/lUReFkoNT1kbBpZSsc197gwMh7YyvamOIj7bXxKksfLiETwqRGlaHrqcSh/ZQywUVJh0xfr30bQNKoDLP2r34UvmOwbTtrfrqD2s6/gMA6Q5Ig8b09FZuvAze+aBEVDyrvHn9v1kYSVOt2Wqv2vL7VjL8rm4UbwgKolP2FYuqD5Dp5y77aIe/O3Ac0H05ytRp2oKztzja3C6Lzs10ZJu9LAnN2GBbEoXT63XIB+Ph6W24t2dYrjYLRD9WIZ9lve2IAVWswzKeOPIF/XLZpPBLjhoq9VqXLBXVx1XvwR54bEotImS+My56uHt7KhHu9xP6DdrzidP20JazWreBnXtTJAJ93ek7GASUJ0RSZqaG1GDJIvT0nrBcS9Cz9FYt0D2FIAXLFZOoEpnNQULJKXm/AC6THD+2wYeDUx6P6E8x7AbX2lkLdBlw0OMWaMHWeA+2p2w8TMc37vc1Bn+HEk13en/oJNqerYVeoBYujM+O7zEvdmbIqA31djHuDGByvThcH4gr/3WHv89w+MIktxJH5j8b3wMuiY+U23Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d853f95-3551-4b42-afb1-08dd0d529aa4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 13:10:59.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB0deT6bGbL8bKuEpQypUTatLWJCIx1eSt64n4GOQD0QFqorZVfnXjKtRfTIRuEYwojsyfiMyYJkNFFGh63f3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_08,2024-11-25_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=954
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411250112
X-Proofpoint-GUID: -lzHTt9T8QuS6w_3aAU8Vqi1rai0e1FL
X-Proofpoint-ORIG-GUID: -lzHTt9T8QuS6w_3aAU8Vqi1rai0e1FL

On Sun, Nov 24, 2024 at 02:44:01PM +0100, Christian Brauner wrote:
> No need for the extra reference count bump.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/nfsd/nfs4recover.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 2834091cc988b1403aa2908f69e336f2fe4e0922..5b1d36b26f93450bb14d1d922feeeb6c35399fd5 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -81,8 +81,7 @@ nfs4_save_creds(const struct cred **original_creds)
>  
>  	new->fsuid = GLOBAL_ROOT_UID;
>  	new->fsgid = GLOBAL_ROOT_GID;
> -	*original_creds = override_creds(get_new_cred(new));
> -	put_cred(new);
> +	*original_creds = override_creds(new);
>  	return 0;
>  }
>  
> 
> -- 
> 2.45.2
> 
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

