Return-Path: <linux-fsdevel+bounces-27863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3D096489A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AC5281647
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E1B364BE;
	Thu, 29 Aug 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ce17IyGb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tuSq0pbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5CA1AED52;
	Thu, 29 Aug 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942124; cv=fail; b=YrDgMEct7zdL52Xo99ekzBGuH0V00TemvoBG+WSdEaAVjZ0llcb/xkWPC3oPe2ClCbbQmPF+NDV9m0N45RW8FFYXCQUjIuuTDc98aJCYQKroFdMxwcP+K8Hqk1sMYrsuroldhtLOf5LeJ+WhGgts3RlXBsp8ErlHmn0NaOX7ac0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942124; c=relaxed/simple;
	bh=LUI8InsDqYk/9jAWt+dDgRMvdCZbMeY3PA70CIfMBxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gjs3MbAPPREzupqwhGmNTUeyklek0SZGstwIEKy+0xxkkabIlQKEGIgoJsVn4f0ILeMZVjQ7R5OQo0TJQEMlk8NwsQPXnlEVlFbQX0TLiCzpNkDAyXzwiQTzZvaS64Nso4RxRPNn3k+EX7eal1gqUsWW1+zKR7wqQ9fm69lw71U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ce17IyGb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tuSq0pbY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TC1s0q032334;
	Thu, 29 Aug 2024 14:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Atkc7M3b0G7i1gt
	2nNgQ0u5izIo87BUR68CW4/mp+6I=; b=Ce17IyGb3+8wAaLu9KsynydOcoNiGEj
	Wa5gRzWAKcFX5PRPVwAkSS4kffwdaEiyLyjysAQNNQVmWYxcMRCEesB1F1VwHt5V
	AV6D6FCzMl2E3VNuHVNrdcGAy/J4uCDO76/GcCbNaClkiyvw1JV2Lne12+PLbHPK
	caJvTeq24yiy93jJZNCZB8Z0aRyo74k3CBETzD9uhN6YploIocD0+HQsNQqYvBuK
	uqx3m6lBifPEzXkss/iLgmDvBm50l8koTML+rYIkhoZjgXuJJpXFUYq1RKHWJXpg
	0niAQmEhZT+dKYv+7RKQANcw+v2Bktsco3oPAw3Dm4/b2KsyzWOkPrA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv4ary-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:35:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TEJhJK031806;
	Thu, 29 Aug 2024 14:35:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0wt3f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 14:35:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpYGtaONNnU9Gnz/FN6w/Ojvl+EMw3o/AF/VqOy7qc1x+WtngNAermJf/w9ouiUQgYhMgBiNjsKpYOWfyoupSrHhy7V8fgO7wGmOIM5IGqqKIFN/g3zXbBv48CJ/ei00aqT5df49z6QKAYlYUl43ozP1JI0Z3t6VkQhZ57OaLv9aGEo0pHuganNedwpoeDwzRIYitjWA351qGMQVnVI+EUGll2Flotpl86oP7dUgc0o26RRPTDNmv6/+wZ1jE/A/NBtpKOSlDSkzFUHmUy7grp8f2sj1zmFyPBWtbs+uLXwcnhlPr+YOo57VlqjdkR5/cfVUiBTfe+f1qs8Hxqs6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Atkc7M3b0G7i1gt2nNgQ0u5izIo87BUR68CW4/mp+6I=;
 b=qe4Ip92iRVyk/arGv8coXh7EB2Vbo7BKb754jTZu+xyuW5CYsulw2dEdtAaDVYrLH+RApMpsExRfBIS+IksTSq/zmHwSyjMjc9JOgineUK6BOtTFicp+gs3cdg4ixnLZcJEVtSg3KzY7WbChlTiqOyHv5YHR2EtN949vrIqb4jHeA0LvyV6jRMA9cfxB2qmvjWMu3RjBdncsdXk6shiVhB5ygECLNU4jEC369gj83kGL+pdV4jpZBkFau/vETzi3ClWYup7w4RzKoMuPMF6EB3+M1ICg02rPRStyN8+SPSAZV8EumdpnBX55a9caf4Ez+TWsbNEr7UKv6nihD87VJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atkc7M3b0G7i1gt2nNgQ0u5izIo87BUR68CW4/mp+6I=;
 b=tuSq0pbY5zYW7UlOfH9MJgsf8k/EfvetJwOlQLe9/md9Oz4YJuIwrTGcKHY3nzk/q7TS5xjPqqdTAgQ4shHgVCoIhPENNNxsM+HT2U7RulDj2TvVLSNF+WK9PJoDIjQ3C7Aez38FQ/93uhkH1BtL1ytXjnncHB/Sv3RdMdyDJF0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Thu, 29 Aug
 2024 14:35:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 14:35:09 +0000
Date: Thu, 29 Aug 2024 10:35:06 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 07/25] NFSD: Short-circuit fh_verify tracepoints for
 LOCALIO
Message-ID: <ZtCHGufMwxhUP8bg@tissot.1015granger.net>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-8-snitzer@kernel.org>
 <53b4d01faa49f2785f8f2ccd014fd8af9f634986.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b4d01faa49f2785f8f2ccd014fd8af9f634986.camel@kernel.org>
X-ClientProxiedBy: CH2PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:610:4f::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: b1956af9-35f6-4cf1-21f1-08dcc837c88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iwsVHVxUwTKVL5VkofIDfkzquowjPdQ6m8j81Fv7PJN3c+jdJnQR0fWeFxmC?=
 =?us-ascii?Q?CfTfoJyQ4zRj3LCy9GceJuvvTqnDvVWQ1zsUsQGsODw9WcpqC6bRsqGNQBRf?=
 =?us-ascii?Q?dD+Xf9oRjb1OQJXqisW14BG2CRbeWR3vVn9ccMAlqQd3oED1vtr27+ywfbNC?=
 =?us-ascii?Q?30EVFJqV3LEbdr8b+T1oy+YnKAIOi1G8Zx2OOOYTKc3Rpx78H/3k1c12dz4S?=
 =?us-ascii?Q?+/I7NezUch1vLKxCHSurw5ePATHeXMViqaeEWa8DTLZedm501gVcgYcUbwiE?=
 =?us-ascii?Q?qtVV8qcgckyszyfKypWR5mvIZ/rFDnT7XpzacE2OySMClQhQy/nxGyJqYS8V?=
 =?us-ascii?Q?iXTrY99pBZl8Q/+AThRPUr2VVnjJsYPcazIoBFF1lBtfPr+zIL5cGvoPLQKh?=
 =?us-ascii?Q?VhPQY5fmHomVl8DCNJC+fQy0vIH+fE3rzf+tyQIR/MVctvyWXk98Cxk0hXlv?=
 =?us-ascii?Q?12Gu8hni2LjQr8ESpDcekkmlEdfgJfNf7vjhRqv53ByZRHwh7J+TcPTGEfQH?=
 =?us-ascii?Q?t3903sEJv5QBxRJEbikl4kmfDYlfDbfAufcVh75DsdSASpDxJQ7wNF+HHluf?=
 =?us-ascii?Q?Oj4tDqXwrL5h8K80N6kplhLkiDcyct9z+oFY+r9KQv5PoSNLueerjvpCnUje?=
 =?us-ascii?Q?D/r8mo8ZS2dWlrVcvd7EkB+XCCUvI/kYVrxQavVG/hOMwnxKiH0znPIudFAM?=
 =?us-ascii?Q?2x/lJk0jBZp/1ExCIN+vxUEW4/2TALeqPtkcQaqgx5iPqfnADk+VTW8Bv9Ur?=
 =?us-ascii?Q?nfy1YlE5YWa5GXm+wTC4vfEil7LNGOSO3Vm90Exel94yPOVCY5xy/S29KoLq?=
 =?us-ascii?Q?OfA3F+ovKXwFfjUPM7Yf9Oc1z/TvzLQJ09AwmSr43dztqo6PTp4EzKpbQFkz?=
 =?us-ascii?Q?PNlA2cxOhrIPy1lnOu0QCjj5Rx23WDyY5wdxz1vdihBWqnsS1odkv78I9sNE?=
 =?us-ascii?Q?wT+vsmt91tg0wDJgVtoiBQ8HXXIpi1O6WthbHlMxRKeaB6L68a9W6pP8S0ir?=
 =?us-ascii?Q?vPPPGpLVMMw86ZWnpQqVnShMqZKIyEbOExoHsOZpt7K9vDoZUjOfv5NVjWkI?=
 =?us-ascii?Q?6Igm8a8su25X60/BvtWir5FjdytoNdy8YBdTYk2dNqbrZIN9PVCRB6XzMzDm?=
 =?us-ascii?Q?RDTqMImLxmhqxpqko0Zlap66iMUdKigAb2rrDnopjDqfO8x7dqMe7rBZKZfA?=
 =?us-ascii?Q?rdtClL3Dc7zWx4KQm+abhkUZREtite6BRichdJm4ko0X091J3gRX13YBd/2u?=
 =?us-ascii?Q?OYb++YxXr/lXO46ZcmK0lNYItBJ9hi0xNLkCD6VchvvF/GdFDq8ubBnhOyfR?=
 =?us-ascii?Q?zSOCvScy0F3710SFCAYMjHBSItfDrkKJoXK05qouZP6xIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XYdZj2Hmy8PgN9i8zH/Zfy9qU4O6hjzKKDlKYjRY1bXIUPXtbbUGY2p8BFq?=
 =?us-ascii?Q?IvteCKWitSPOP0B+biTbEDeQfxHUkGWC4ViCpEwCuXlajDG8SXbnJxk9h0jq?=
 =?us-ascii?Q?g7tD1N2/AsGCj0gSVUn9ivtr0Ui6XMxLf/TF94IvruLyF15W3kEjkR0j064G?=
 =?us-ascii?Q?G38OU8Bo4BtVwpWYFN2A0wBN+zqZnkZKyFHJZHkkiaMReUe4fQxQPzXBp9m+?=
 =?us-ascii?Q?CVbSFfklnXBYfyVfOV5gkOE+UtcigPoLckr3d3F4kgJQdiezKe0Y98oDTokH?=
 =?us-ascii?Q?Wuk5x+Neh2psDdtw2SeKNOtgA62mUW58hODq098P131uyh6TqRIqDTiSbp1U?=
 =?us-ascii?Q?1QaTusaWdTYZAWIX8pYAYJlBBa7SLxNZd25bzW5/CL/qEKMdp7VUpunO1vLD?=
 =?us-ascii?Q?iO5iWpCisbDciocIfwnIU5V6KpBM5Nzk1wyXLoe57dTFvxjRzWzqqYvDwedC?=
 =?us-ascii?Q?Q79WvpqYbpiSU6nweXJMvUhSEBhhbxzy8f6B7lkJwyZumBVTQd3sr/F65u1A?=
 =?us-ascii?Q?9iu8qy/oY/Fg4PNOMkl46lihh7WNe0kSxj5iWCqHeV4ZRRquLnA5mUFZWEne?=
 =?us-ascii?Q?6ovIWZqfJ6/DwCj6oRccmSRPkfX6hIrb5l7rK6LjKqHHMbdwhA8p6uLIl/ks?=
 =?us-ascii?Q?DnceeXqsWZRCwICd6HdSv/BaMK7iAGY4hKfX3FigIpu9FKfQihPlsJaZ464x?=
 =?us-ascii?Q?u7nsJZwJDl3L+D1ncLRbeoa3rzhuZ6GhLzxzThkN9uD/yZrfBXI//jcXKp4d?=
 =?us-ascii?Q?6AU3x/MBnIF8ERjuWSt6ARQ2rsJGHRaQnZGcsE/9ucyYsampdcuCHk/vNj9z?=
 =?us-ascii?Q?s/+umb7HnATnIVfO+jXITli9VJFFHVWgQU6fPB1HV+X6ktqFeR+llV0M3lou?=
 =?us-ascii?Q?EwtzsFWPGsSZvnfdZNfgNVMx24T5w3Dh0CA7XG2psBjy/ZUpJ5GMnIkExFnX?=
 =?us-ascii?Q?FzgUg419GxLiweThITMRxomcYodxTFXWIsQ1maKsQ0EsEw3IUVg/PW5TQpFO?=
 =?us-ascii?Q?lFekIGYqMJAqTV4tl8IrfkCjYbOGjfSVOttwf5TENT+94qiTtemUvO+mNC/W?=
 =?us-ascii?Q?aispiBWEDC4wo7IWkmh2Jizcb4WhHCsshYAFtA6A96mEMt+2ZVH1Iahw/eqt?=
 =?us-ascii?Q?1cx9AHOPDSO1xCKrRFpd9l1XJrP/pKLvPCauhYll4YjxzHiBouneWJkcjPIF?=
 =?us-ascii?Q?8T2wcjApSiN51yK8H2phtgUcFJtQQTkH6RtZDjZP2WQn2/YJ+SJWnTipr9Ip?=
 =?us-ascii?Q?e+Vh5J+V4QvMgLH2jQSGnSKHGiynH0WdmO+g+t8+8YhTGZ9l5lYga2F6V28Z?=
 =?us-ascii?Q?K5Gn8ejH0MWW50Jt9kx6/0u5mvofUufrOoWGT9hx2JYn7sUvXypPxYaOJCNt?=
 =?us-ascii?Q?O4qdWbiZRF5YQHUwNdistF2ped9eNGErNWKXcqp3tcrU3EaHejTBTRNZUORN?=
 =?us-ascii?Q?ZUfdVcNXKXf47+2WIeCD/1OiKueROVGjAyxoC4GsgOI/hXlPA4YWogkqRQ4T?=
 =?us-ascii?Q?6ETtoAbvQzR7wqdEWHcPDI8rnPJP9XWFAfo2inxU2gCHrTE93ORdLDqjfe7f?=
 =?us-ascii?Q?/OLfUZ+j5bTuCC3iZHlW98Qtor5/o05mR+4xzch2apKMdng1e8BQ++lbSnWa?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nm3/1DWM6HdKVyNP8yqfbyh+5+FXQRCr7IvqyRw18UI1yGjoMUOWZsS+9AocsJwhG+WWP5HZNrwFgROSNkV8nJk/BdYvc+znrA4TxlYC+DtQR4jK5ImFd7gGxhD2CQWhOe7SvI10aLIYuMUubFOQfJF5KPZfLyBGkbBr2TMduTPFwYZUBLeeDe3YXfkTg0z0Qf1TLWY9FUVQpc34NrLHd9gbw3LWRywCd6siDKiw9wuOLD5BUczLpZ/+Z6ukvDscq2Lko0Y4/ynBKnNILqcLzcw+eP3Yp3VJ/LOHs2FMGcX5jiKATzSlg9N7u50WSGVHUVYUBp+1YsD4i+DJ9c5pnI3hMOL9/OrS7kNIDS3WvCrWngsS/v9WmuQjZoML2XnaNrAXOTd/aKeMbqu8IiytHiu7eEgGszcQO6ZXj2GJslFILhfd6RjFVK6IHdY+G0vegjYPMYE0p96RMLt5gQRSbkLZhSzMyAoR5kpvuJZeixoZRXTJEYdATaW5KnW/+pnLJlTLXPElUxSnt/ZA9jsZWE/rWvgmgVWNzt4xKgXzmu7GSxMFOssBbfHTBUa+4ooyy5CHvsL7Bp/eK7CNB7pBiltcTabDPjjZSqtklQ7Z9nQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1956af9-35f6-4cf1-21f1-08dcc837c88f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 14:35:09.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELzz9HthneAEjLrFtzrIlLgM4XMVwaTSbvXvPwl/ug5F75Caa6Nb4xQIuR2zsdMrfmPFNDJwhxI2nmwHJef7qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290101
X-Proofpoint-GUID: GfTNAHdeRCiVevNFLVxpmRVYp0TxI8rX
X-Proofpoint-ORIG-GUID: GfTNAHdeRCiVevNFLVxpmRVYp0TxI8rX

On Thu, Aug 29, 2024 at 10:33:18AM -0400, Jeff Layton wrote:
> On Wed, 2024-08-28 at 21:04 -0400, Mike Snitzer wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > LOCALIO will be able to call fh_verify() with a NULL rqstp. In this
> > case, the existing trace points need to be skipped because they
> > want to dereference the address fields in the passed-in rqstp.
> > 
> > Temporarily make these trace points conditional to avoid a seg
> > fault in this case. Putting the "rqstp != NULL" check in the trace
> > points themselves makes the check more efficient.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/trace.h | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 77bbd23aa150..d22027e23761 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -193,7 +193,7 @@ TRACE_EVENT(nfsd_compound_encode_err,
> >  		{ S_IFIFO,		"FIFO" }, \
> >  		{ S_IFSOCK,		"SOCK" })
> >  
> > -TRACE_EVENT(nfsd_fh_verify,
> > +TRACE_EVENT_CONDITION(nfsd_fh_verify,
> >  	TP_PROTO(
> >  		const struct svc_rqst *rqstp,
> >  		const struct svc_fh *fhp,
> > @@ -201,6 +201,7 @@ TRACE_EVENT(nfsd_fh_verify,
> >  		int access
> >  	),
> >  	TP_ARGS(rqstp, fhp, type, access),
> > +	TP_CONDITION(rqstp != NULL),
> >  	TP_STRUCT__entry(
> >  		__field(unsigned int, netns_ino)
> >  		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > @@ -239,7 +240,7 @@ TRACE_EVENT_CONDITION(nfsd_fh_verify_err,
> >  		__be32 error
> >  	),
> >  	TP_ARGS(rqstp, fhp, type, access, error),
> > -	TP_CONDITION(error),
> > +	TP_CONDITION(rqstp != NULL && error),
> >  	TP_STRUCT__entry(
> >  		__field(unsigned int, netns_ino)
> >  		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > @@ -295,12 +296,13 @@ DECLARE_EVENT_CLASS(nfsd_fh_err_class,
> >  		  __entry->status)
> >  )
> >  
> > -#define DEFINE_NFSD_FH_ERR_EVENT(name)		\
> > -DEFINE_EVENT(nfsd_fh_err_class, nfsd_##name,	\
> > -	TP_PROTO(struct svc_rqst *rqstp,	\
> > -		 struct svc_fh	*fhp,		\
> > -		 int		status),	\
> > -	TP_ARGS(rqstp, fhp, status))
> > +#define DEFINE_NFSD_FH_ERR_EVENT(name)			\
> > +DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
> > +	TP_PROTO(struct svc_rqst *rqstp,		\
> > +		 struct svc_fh	*fhp,			\
> > +		 int		status),		\
> > +	TP_ARGS(rqstp, fhp, status),			\
> > +	TP_CONDITION(rqstp != NULL))
> >  
> >  DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
> >  DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
> 
> A bit ugly. We really only want the rqstp here to get at the socket
> structures. I'm still looking at the rest of the set, so I'll assume
> that this gets cleaned up later.

No, it doesn't. We don't have a solution for how to trace
LOCALIO activity here yet.

-- 
Chuck Lever

