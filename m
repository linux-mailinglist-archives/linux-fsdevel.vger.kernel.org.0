Return-Path: <linux-fsdevel+bounces-64962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F95BF77E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB2B18C68B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909463491CD;
	Tue, 21 Oct 2025 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fsnESmzF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MGNaaOpX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75216347FEA;
	Tue, 21 Oct 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061687; cv=fail; b=b9NDQQ+8R2GPNFnd+aON+IFj/2nrr/6ems+m2jHzGt+xa/YkKgaErITQ8S5B+mES8O1cCExbXeHdBB677TmZNePUrfeUerMkvSPt4YPvtKb/UiXkEjasOsRIHubBOQ+EUZbZk0lds02C4dvigiqJ0AtXChEPQfaqXu2IuzzBjgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061687; c=relaxed/simple;
	bh=6QkkoA/5YJp5NlQkUCP4ZyX1BKoWXK0QP2qRJRSSlWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P3VKTPV8aO9XEs6eDFIQcu9M/SB8odtKquXZ9AN1BCGvc5CCbdj2Sypt9JI5LNZKB7muEUPayWovvOHUPNhnFc7VnORb7rURAh9fl6n4/roVPZGTYCai50B182mr+VR+lcWnz5Noa5Yz3lYZRhYsZZPSlHtwaGzJzWa60PWp85M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fsnESmzF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MGNaaOpX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEIc4f001962;
	Tue, 21 Oct 2025 15:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mY7tULCRbP2BbJ/Zou
	LM0vaXDNGEwaZlsiSftu9sK/A=; b=fsnESmzFDV6B8ATQuRijKpF04SDmeuo/j2
	yr4Ehh1jvC4TF1NJxFsTA/Am5ukyX5sOBI8i6bw+JBlD/4SQFiCC9jew3AX9jqz7
	tiyXwfYtA063fbsgR/Oj302+R4a7BakVD3rzsGJbHD/J7vAgSvpHOJCHrm42p7a/
	e+euReIHjrFhqWY37viVpAWNSZwjsalISTMD3hGNe9ur6sKJ8sMkqLCCLQBC1BKO
	d7/Uc5LhT8DJH8MdTruIJCcjyHr6GFz1UT1rWqY675Lbs9q+Se+xGL2cReJv90pp
	Ya/8rjc+8tQCwoSuqY4ji0EpfVtuFQ7A+wqudAhTyjRPpdAqymrA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d5ssu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 15:47:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LFLkMV035213;
	Tue, 21 Oct 2025 15:46:58 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bd1rrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 15:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVE6gy24PYO6xfx7fQS401DtUo1DBYYjjx54K+XH1AfdUuYKxCJ34dvW3z3Abp08Lci4iMOempcKbQ9dyuH5SLsMCgWNnAGb1ZMK3oevGpJfMS5cxWoZPpdV23Rx+WuJhgn1uPLLis2S/+j+MLcNfNBAriNGF0k4TDZgiAA4AoOzqH5wmeNvcHlP5nJg6IQzj0SIv3gD/7X/MO8iR33GTi0iPhFKEzC9abcabBuckSP/S+wmYdyLZCrZQ9wGwuANL+ol9EFRgf9AkvtlEfh92iW1pd50Dd4SW9tt4x+wKBHajHk1+MnYB9B9vzTZDeG8GhV0k4O8n1DWgWgnxgTkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY7tULCRbP2BbJ/ZouLM0vaXDNGEwaZlsiSftu9sK/A=;
 b=WJfqM+JC3ZcYHvNB+YosCnhMGfCf1wg4hgCOGzU3u8TQNvXmogMnOpsqrIreJcOHQsWniJ6N/Shrp/4MA7J/HKKB3Ky+n2YBSwHYaC3i+plyp5zWy8goN7i0NRZhvdid1d0Th+MuriQNEFBvPTO9XyEZtX91MKmJj7CIwb3lNgQeIkotiXhUrGqqSgpx8ZSwfynQ8DjYrIhR2kLBuvonOA5KqEhHdTdKnP7zGOiVV+gyb+IXjxJaLz8fFa81zwLSTRqhzpBC041MC5hOFfO1rxbB2oE3kWyf7AZcuWETyYelmBz0iJHgIbOb9HWjL3H+4qzmnDsRvkuT7L8HxzO7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY7tULCRbP2BbJ/ZouLM0vaXDNGEwaZlsiSftu9sK/A=;
 b=MGNaaOpXpJ2ZabCKS7XGcbPsz6r6bwIjp9mbC3RfuNf3baNK3x+CyY6ZYFf1dROE8PssCoFspqLWNuRFbzuxMFeLo6LdjnwrGZpD4DfZdFMnEnFKGshuFa7ejMScFIlj9Z4OM6T2suraLyJRg94TXDLS1ArQvYmkneVGat8xtOk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4365.namprd10.prod.outlook.com (2603:10b6:208:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 15:46:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 15:46:54 +0000
Date: Tue, 21 Oct 2025 16:46:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
        kernel@pankajraghav.com,
        syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, nao.horiguchi@gmail.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <bc842ea0-3faa-4f0f-8ad9-06b6e079b4bf@lucifer.local>
References: <20251017013630.139907-1-ziy@nvidia.com>
 <24b02541-d880-4a48-a11a-23e3e0427f54@lucifer.local>
 <D17E5D2B-980C-462F-9B1D-FE26F01D3A9D@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D17E5D2B-980C-462F-9B1D-FE26F01D3A9D@nvidia.com>
X-ClientProxiedBy: LO4P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: a591a2e4-e394-4efa-83a0-08de10b90f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fgay9HLB40LyPJLqXzgWXv19R6rsuU7E8V0CrOHppyZ2IkiOGjq/4Gc1+WLw?=
 =?us-ascii?Q?v9QkdCJb78VPGS9Zb3To/WsAzc0lVDewHdTk44xQl4FV3d60ofEwGqYIJlgE?=
 =?us-ascii?Q?tcI4iBqs1l8gwtiKdiofe4Z0QdF/SfF2bt33DCRQeYBnFwqd0Pd6oqEX2jy/?=
 =?us-ascii?Q?+lnS1OYYjYEN1l90MGeVYVxsPgQOoKrCwx9E3k13/pSWAaq155YPzfqGq4kl?=
 =?us-ascii?Q?k+3Qtc6eLNObUTf+NGXqNN76zmo9OEHNufGyrcMee/RlEjWmiIKz6pEFq3PN?=
 =?us-ascii?Q?oH5WRfgHDYLnKX53P7Ds/dJ0XT62wlhBqUwQq8hhZPEFI1wr5YuIcK+psUSV?=
 =?us-ascii?Q?qt+aOrLoyUPuSLQ+vWzzfdDgPkmCk6lHzZUzRf313qtmd8xJmbcYyzBjWD2/?=
 =?us-ascii?Q?erbzysV38n2DWACJluohP4IsGrK1fW/Mere2S9iFEfL3a6EwO2qDQWKJfW/O?=
 =?us-ascii?Q?kh21YpwVPdbKs0eoCoLi8qi1sKfLCTJAS+f4mKyRlP63I36DIGlGRltpzAuh?=
 =?us-ascii?Q?trgwXMT3WRM15kfs2UayyBHRUYLLeAMnxKUd/oIk8g4L8q8gITSulGjSJ5PM?=
 =?us-ascii?Q?2SdRO8GAXr+M+u7Ypb7XweTHbJ55bsn9bnpQMqGEYYv555AWJCniogX7BYmG?=
 =?us-ascii?Q?yiz0TZtFHhZ4anfXK0Qg5PlMkSjo/vQDHZCs7WQSfJGGiSR7PLtKabxs9v1g?=
 =?us-ascii?Q?Iws0O4c0MKoH6k2HJXtSyAmy30i6ip9FVBQGfFO3yJdZniozKEA2ZQ4KR6e7?=
 =?us-ascii?Q?dEcdjcjOlkvSzAcYW976d86sMFGad0/e2b6CzEEg5o64UVvVGfSej3Whp2iZ?=
 =?us-ascii?Q?ZtuWJFstPusc/nKDF5g3byDjgWcY3/m6xnTLan19QoH5QR7XLqS1lcQ/aZKB?=
 =?us-ascii?Q?7T81xJ3cG97LnAZXCtNE5QRHozWpcku+jLM7m9xrpEy7dEiLG3HmEPLIf5CJ?=
 =?us-ascii?Q?FcgbEgTW9d0nMHWGs12wD1KBdZaEkSFFW67xTpN6EjJcoz72lwTVqVugq9jw?=
 =?us-ascii?Q?yPNsl8z6TlB3JuicwzvfvGeGzkCjmxYnjOI8UTKEdtD8zHnju5dKpz8WW4V7?=
 =?us-ascii?Q?6og+sSuqtT+ZB0ROZlfELK93MKNxFb18pXOlnbR8bGMbMBPf5vEUnG/5h0o8?=
 =?us-ascii?Q?KKA9qn76VpgUMCnSA7SKVYnIccyB2P9OwbH3301SHJGLkkkOlCJzAe+S7Nz7?=
 =?us-ascii?Q?fk6dSZUVPUJz+793kF37BUl7XAC1W70kDnZqyzBNWOi+rQDkXo/VnPqKYuuo?=
 =?us-ascii?Q?ltlI+A+WQclAeFI62R889W0lgZWSScC0521o6TAH6cdVTrHA2caDq+3QG4B5?=
 =?us-ascii?Q?Fm3NETBR4llz2ipYSFqF5fP3Ww/sRlkCUrcgqx2wvp6/LVHmpp/UGZsrqHRX?=
 =?us-ascii?Q?WwTwFDHF34xdCjO+R17LCtnMrp8IxvTbJHe+Y2GeWsYavL0zZRQgig4xU0n1?=
 =?us-ascii?Q?A116UZsm1MiIyWOkrIEMJgHue/O6x6S3aX6XfUn52rgZysr/cpz8yQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikZIaUktlRK5MTiwWtAwPy8J70BYTgi1EVlRs0VSM/Jxdv0VOSse9/t6hEer?=
 =?us-ascii?Q?tHUYzK65Sl+mnOz4Fs8YqqxcVM0CaArRjt7GaUs5paC+xbZ4J6frcpZ4VjZT?=
 =?us-ascii?Q?SaJwJg1oEBjGEXqnPOXeVLeHivsEnOViAMct+e29ddo34mQMKsb3bivLdSb8?=
 =?us-ascii?Q?IPBn/IXu++Vju9Uutta2yNQa7ZU4jgAm20a7z+w60fixtw7/JhZxK63pC+QN?=
 =?us-ascii?Q?ryMD9uoo61fGnGGHryGCqx5Eg6kgb0iGoWTTodMdID81EbemC6MPQAsoKgBh?=
 =?us-ascii?Q?D/52xRI8uX87/1TIXMK/8DqKrS3tSN928C9DmIflOZNRmFelyBWR3/7qxM9e?=
 =?us-ascii?Q?fScJXvNgDEWtIh0OF3hJVXs6WBob415QazZCWJZ4up45Nl/tvxJIDGb/cl8T?=
 =?us-ascii?Q?XSij1HIM13yqRfUvLZjt4PpTDoX/RlTPQbkduI2DdrlDItlrx9GUOhEOzmwF?=
 =?us-ascii?Q?x66oUyzPqfY1n8FIn/waiKmBcV7JGDtKkPBspVpTsaWwN+BmCLyOrxipjGUd?=
 =?us-ascii?Q?xm4yCtdxH74oT9RAsII3dri/AJHA1oyrFeJJbTK6/Sc/0WoPq+aHYtDrEVCR?=
 =?us-ascii?Q?fmTgv5qXSCghkby1BDeNsekuYhbl8rTmpsAeBxMrHeKt4Lu0lwKBCyrfmw/x?=
 =?us-ascii?Q?dFi2crZ0gJZy47fmU7mfK0+S2RWn5ZbTPfL5Zq407idXelWjsz78USrzh/rC?=
 =?us-ascii?Q?aQR2nbvuEuvToAZiFto3NhmkkhA5SQihctqDCNZwHEu00Cpe3Ryra75MVGSy?=
 =?us-ascii?Q?LvuPaEugv7SGPBwRymTw8u2ak9YC6zHHW/jQpD4NrbgiBiyWfl8HdyC6QcJR?=
 =?us-ascii?Q?dY6LzrSKcq0ExwicvxdsFQSMCyngxNYDudonk0V6cMPR8KbskpGUZYMScsS4?=
 =?us-ascii?Q?86pLwk5e94jwtIijwqS9BzD3XmS951Z7GtBPeUGpBA3b+0I19UCWrIP3DgHq?=
 =?us-ascii?Q?VxQeG1sJSyM7Ry27ET+EC7Mta06V2Yqsj51WzBaHWN/ygO9dI0teJqYDx826?=
 =?us-ascii?Q?96hjqgETMxHU+3qOSfc2khA8/n1GaE3qC8KrFDBBbNcxTvLp8ikdm5ZFZmom?=
 =?us-ascii?Q?NxsRoihAU6hYIGUHBN8NH2cXAAlEkOV9BDx9lwd/jurQarv1ATmkF1aC0SZ+?=
 =?us-ascii?Q?1WZaHNfuy0dfJhoo3bz6iP1wS6OaW9FvqL1AaRQ11/4G2XSQ7Cm3CD2Q9FDN?=
 =?us-ascii?Q?GK3CrLiRmfBDiqVKVTqXGuMOCa6usdJaOlcEQxiaIJtQA3i4pCYmOpqUXlTV?=
 =?us-ascii?Q?HPwE4r9HJR6ffhJJPdPwtfguBQaOl54EcpYOQGW3Jb5tn4h0pzME091PRJe2?=
 =?us-ascii?Q?ctGNiUPLQlLw43HT7+Z6eXRsV13Hz5pHNK6S0gU0V4Z9vQfiQ6rM3gSdPURr?=
 =?us-ascii?Q?fS8zammS/AzT3q4P7z7qW927Yu2gx8B9XdqUte5q7Z/0AwmIqagbhlpRMX9K?=
 =?us-ascii?Q?mw7Nq6X90LFRAJq9gq0owf4SHJC9UTDZHXfLQEMyF6pd+FhfW2E7KetY54JI?=
 =?us-ascii?Q?Hp8DOAOiy8PesOuDpGSqnj+/3LHO2XuDjDvwGSlZvxjQSEr0+thK6acLkvD/?=
 =?us-ascii?Q?DWWktHsaZXz/wSNF671I/hs8mH1zRm4u+sLgUFqlo/SfbRWvU/x5pv1sV0eI?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A32XO8kiR/X759jJBaFMwu/6eVZlPSvFqahxJGuJS1NNz9p3CfoTL66lQRZE7ktZuQqYeFbpFnexHxV9RI++b8f6O7aZ2OlgBhAJtGxjEh9cWMU7oOzi4nPfKb6P7V51AUIqVINIw+W3KqHrET6npEwDwPtaaFxa26iWMdtPlu0pOtrySEwxKOJNH58XZr7j+ILvspttILYFwWMg1zyfR0dDS8stAWSqmKFHT86tGluK7MF5fhV4bb2nBsqaKhmzXVCRyBikQLYdaO5VRl3C3EyLkZLQID6Vvz40nnSfePD4kxBL3XtX9b25oS1lxpPBmuV60fMOfHg1M+eNCdS7FDxTd40uuuuU8UTpQvyH2dy1PQAzOdWIuQiLf5Y01cK3yaGIrlbHCU5RDaABLmzFMEALqj+BY7mT+qDwcLD0a/p5OoQzx4XFDt0cIERczBnJHTO6WBYwg9LFlubDGDAh5y0ObeohaqvYFSyFl/7CPNnTubd9Mb2CBoeWtiaT5Uz2Q+KI28Dx7/K50BGZPuNr3JSFpS4vZg55Ra2HVYVxxllhjOa3DqPfTjoLpJzS0tdnJMIBK+RWEF2oWHwBiCBnHCzqjxZJtMQ+ORy0naWZB6g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a591a2e4-e394-4efa-83a0-08de10b90f6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 15:46:54.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxCIskdWV+yE/O2kmrDirtfrhC3r53pGoDZ3Dy9RUaho8UmhWoXuhPZKtIwS+VgwlVDeM/jiCZGSf0rFQ3KgILhwBpJR1g80u2Jm/hNFgZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXzu87KHDWmKIJ
 UbLaPs+qelMDPTtEhBudr7gw3cTHYjsjzOTwZvcdbqeJRh5SNrgNVKLjBpoNvbJgjctK24O0ppf
 gCm7tNMAfmAjbpajVc3/pUIFBrjW2C7sY/1b4D22ylHJNzwBazACx7SydCQ59eei93oIzNwicxs
 vmwKZgUM8Ejh+mlJDlFn5ynHgQ3ZOA+QPtQBXI1fRcIT6ZTv+avUf8H9iP3MmX99FtQ6j56Ykdw
 Q4uAp0WAVd+Vslhg5JLQp3Y/rnfbahyCdI+RNF7fdM7uvT6ZW32V0aQxMF5FhDqGfDwvyJZbS+n
 MlxE7AUu1dkvv/yjLU/RPJcwz4r7DTz0KPaygv2AgJxxzrMonSciHYAyagM9R+mVTSaEEeJbeEp
 b94KqvgWQNM7yc2MGbUTwIRmV/d9PLFlKs7lJpfCu0qSIGXMrO0=
X-Proofpoint-GUID: 2cbmLscy_13bkHOghH6t7mYjsCW3glcA
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f7aaf4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=Ikd4Dj_1AAAA:8 a=hSkVLCK3AAAA:8
 a=yPCof4ZbAAAA:8 a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=oR-iFBQDl6IpsAHa_KEA:9
 a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: 2cbmLscy_13bkHOghH6t7mYjsCW3glcA

On Fri, Oct 17, 2025 at 07:28:49AM -0400, Zi Yan wrote:
> On 17 Oct 2025, at 5:19, Lorenzo Stoakes wrote:
>
> > On Thu, Oct 16, 2025 at 09:36:30PM -0400, Zi Yan wrote:
> >> Page cache folios from a file system that support large block size (LBS)
> >> can have minimal folio order greater than 0, thus a high order folio might
> >> not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
> >> folio in minimum folio order chunks") bumps the target order of
> >> split_huge_page*() to the minimum allowed order when splitting a LBS folio.
> >> This causes confusion for some split_huge_page*() callers like memory
> >> failure handling code, since they expect after-split folios all have
> >> order-0 when split succeeds but in reality get min_order_for_split() order
> >> folios and give warnings.
> >>
> >> Fix it by failing a split if the folio cannot be split to the target order.
> >> Rename try_folio_split() to try_folio_split_to_order() to reflect the added
> >> new_order parameter. Remove its unused list parameter.
> >
> > You're not mentioning that you removed the warning here, you should do that,
> > especially as that seems to be the motive for the cc: stable...
>
> The warning I removed below is not the warning triggered by the original code.
> The one I removed never gets triggered due to the bump of target split order
> and it is removed to avoid another warning as the bump is removed by my change.
> The triggered warning is in memory_failure(), since the code assumes after
> a successful split, folios are never large.

OK that wasn't clear before thanks.

>
> >
> >>
> >> Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
> >> [The test poisons LBS folios, which cannot be split to order-0 folios, and
> >> also tries to poison all memory. The non split LBS folios take more memory
> >> than the test anticipated, leading to OOM. The patch fixed the kernel
> >> warning and the test needs some change to avoid OOM.]
> >> Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
> >> Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >
> > With nits addressed above and below this functionally LGTM so:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks.
>
> >
> >> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> >> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> >> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> >> ---
> >> From V2[1]:
> >> 1. Removed a typo in try_folio_split_to_order() comment.
> >> 2. Sent the Fixes patch separately.
> >
> > You really should have mentioned you split this off and the other series now
> > relies on it.
> >
> > Now it's just confusing unless you go read the other thread...
>
> OK. Will add it.
>
> >
> >>
> >> [1] https://lore.kernel.org/linux-mm/20251016033452.125479-1-ziy@nvidia.com/
> >>
> >>  include/linux/huge_mm.h | 55 +++++++++++++++++------------------------
> >>  mm/huge_memory.c        |  9 +------
> >>  mm/truncate.c           |  6 +++--
> >>  3 files changed, 28 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index c4a811958cda..7698b3542c4f 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -383,45 +383,30 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
> >>  }
> >>
> >>  /*
> >> - * try_folio_split - try to split a @folio at @page using non uniform split.
> >> + * try_folio_split_to_order - try to split a @folio at @page to @new_order using
> >> + * non uniform split.
> >>   * @folio: folio to be split
> >> - * @page: split to order-0 at the given page
> >> - * @list: store the after-split folios
> >> + * @page: split to @new_order at the given page
> >> + * @new_order: the target split order
> >>   *
> >> - * Try to split a @folio at @page using non uniform split to order-0, if
> >> - * non uniform split is not supported, fall back to uniform split.
> >> + * Try to split a @folio at @page using non uniform split to @new_order, if
> >> + * non uniform split is not supported, fall back to uniform split. After-split
> >> + * folios are put back to LRU list. Use min_order_for_split() to get the lower
> >> + * bound of @new_order.
> >>   *
> >>   * Return: 0: split is successful, otherwise split failed.
> >>   */
> >> -static inline int try_folio_split(struct folio *folio, struct page *page,
> >> -		struct list_head *list)
> >> +static inline int try_folio_split_to_order(struct folio *folio,
> >> +		struct page *page, unsigned int new_order)
> >
> > OK I guess you realised that every list passed here is NULL anyway?
>
> Yes.
> >
> >>  {
> >> -	int ret = min_order_for_split(folio);
> >> -
> >> -	if (ret < 0)
> >> -		return ret;
> >> -
> >> -	if (!non_uniform_split_supported(folio, 0, false))
> >> -		return split_huge_page_to_list_to_order(&folio->page, list,
> >> -				ret);
> >> -	return folio_split(folio, ret, page, list);
> >> +	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
> >> +		return split_huge_page_to_list_to_order(&folio->page, NULL,
> >> +				new_order);
> >> +	return folio_split(folio, new_order, page, NULL);
> >>  }
> >>  static inline int split_huge_page(struct page *page)
> >>  {
> >> -	struct folio *folio = page_folio(page);
> >> -	int ret = min_order_for_split(folio);
> >> -
> >> -	if (ret < 0)
> >> -		return ret;
> >> -
> >> -	/*
> >> -	 * split_huge_page() locks the page before splitting and
> >> -	 * expects the same page that has been split to be locked when
> >> -	 * returned. split_folio(page_folio(page)) cannot be used here
> >> -	 * because it converts the page to folio and passes the head
> >> -	 * page to be split.
> >> -	 */
> >
> > Why are we deleting this comment?
>
> This comment is added because folio was used to get min_order_for_split()
> and there was a version using split_folio() on folio causing unlock bugs.
> Now folio is removed, so the comment is no longer needed.

Ack.

>
> >
> >> -	return split_huge_page_to_list_to_order(page, NULL, ret);
> >> +	return split_huge_page_to_list_to_order(page, NULL, 0);
> >>  }
> >>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
> >>  #ifdef CONFIG_MEMCG
> >> @@ -611,14 +596,20 @@ static inline int split_huge_page(struct page *page)
> >>  	return -EINVAL;
> >>  }
> >>
> >> +static inline int min_order_for_split(struct folio *folio)
> >> +{
> >> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
> >> +	return -EINVAL;
> >> +}
> >> +
> >>  static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
> >>  {
> >>  	VM_WARN_ON_ONCE_FOLIO(1, folio);
> >>  	return -EINVAL;
> >>  }
> >>
> >> -static inline int try_folio_split(struct folio *folio, struct page *page,
> >> -		struct list_head *list)
> >> +static inline int try_folio_split_to_order(struct folio *folio,
> >> +		struct page *page, unsigned int new_order)
> >>  {
> >>  	VM_WARN_ON_ONCE_FOLIO(1, folio);
> >>  	return -EINVAL;
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index f14fbef1eefd..fc65ec3393d2 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3812,8 +3812,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> >>
> >>  		min_order = mapping_min_folio_order(folio->mapping);
> >>  		if (new_order < min_order) {
> >> -			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
> >> -				     min_order);
> >>  			ret = -EINVAL;
> >>  			goto out;
> >>  		}
> >> @@ -4165,12 +4163,7 @@ int min_order_for_split(struct folio *folio)
> >>
> >>  int split_folio_to_list(struct folio *folio, struct list_head *list)
> >>  {
> >> -	int ret = min_order_for_split(folio);
> >> -
> >> -	if (ret < 0)
> >> -		return ret;
> >> -
> >> -	return split_huge_page_to_list_to_order(&folio->page, list, ret);
> >> +	return split_huge_page_to_list_to_order(&folio->page, list, 0);
> >>  }
> >>
> >>  /*
> >> diff --git a/mm/truncate.c b/mm/truncate.c
> >> index 91eb92a5ce4f..9210cf808f5c 100644
> >> --- a/mm/truncate.c
> >> +++ b/mm/truncate.c
> >> @@ -194,6 +194,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
> >>  	size_t size = folio_size(folio);
> >>  	unsigned int offset, length;
> >>  	struct page *split_at, *split_at2;
> >> +	unsigned int min_order;
> >>
> >>  	if (pos < start)
> >>  		offset = start - pos;
> >> @@ -223,8 +224,9 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
> >>  	if (!folio_test_large(folio))
> >>  		return true;
> >>
> >> +	min_order = mapping_min_folio_order(folio->mapping);
> >>  	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
> >> -	if (!try_folio_split(folio, split_at, NULL)) {
> >> +	if (!try_folio_split_to_order(folio, split_at, min_order)) {
> >>  		/*
> >>  		 * try to split at offset + length to make sure folios within
> >>  		 * the range can be dropped, especially to avoid memory waste
> >> @@ -254,7 +256,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
> >>  		 */
> >>  		if (folio_test_large(folio2) &&
> >>  		    folio2->mapping == folio->mapping)
> >> -			try_folio_split(folio2, split_at2, NULL);
> >> +			try_folio_split_to_order(folio2, split_at2, min_order);
> >>
> >>  		folio_unlock(folio2);
> >>  out:
> >> --
> >> 2.51.0
> >>
>
>
> --
> Best Regards,
> Yan, Zi

