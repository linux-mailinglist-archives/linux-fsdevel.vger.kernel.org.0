Return-Path: <linux-fsdevel+bounces-48570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7820AB110D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5BC1C255CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930328F941;
	Fri,  9 May 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cjz4dZ+B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SwGgYkGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6E21D3CD;
	Fri,  9 May 2025 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787557; cv=fail; b=P5InrJtE/saYtivHg+f6kcuxplvInYfNBgUJxRgbEpSNJ6V8VhKtsKpvAERk4FqEcp8p9jnQokX+watVr9DL7VZk+D9EncmKUZkr5R802HAKvdCSB57v1EiULgznCV8r1JXo91Re2gsikn4038NZPVjilr+22Y3riJxObN/fiNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787557; c=relaxed/simple;
	bh=d44B7aThjtqwsehH7aR4/cyB2avfq/DJ8QxA3oI5XFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DoLKoPZcpb1yI/EnOoD5M17R8IDKs5ookETmOGw6CSTKsPcLPtUig96pI5RFWnkcKappQx1opBm8wQ4T5TItVhPES8OvejQnF0xzRnjs1uCGy6xv+J9b7CZoV4DKrErM7IKDwACPFi82h6dD/O/BEV8iEovQ/K0Y5yUdgVYuRSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cjz4dZ+B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SwGgYkGV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549AWT24006352;
	Fri, 9 May 2025 10:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6RcDa73xu37VlFF8Qh
	Sirjh5vFfFADWqjH579luYPbY=; b=Cjz4dZ+BIlnjOAeDsgMHZF8yGDSJHbm6vE
	ZkNfdWKLbcHJR38HIuY6jR6uLLbEW35n+0SbzCCszzj3xkCo17/xOzx8nJ7OKLl1
	odpWfyiuIZKR5IsA9TwZKiPLiyMjAV3wFD06vmFKgWCevaCj6YlnhguyDRS/phRc
	ETWn+aNTJZ8p5gaIUWZGhOnDXDh0xLXZPJbTZT9yNJVFiQSPQ/qkhdo8YXhvC6sn
	ZRwCqipoOXia6LymHRVGFkDWy8JW9UgDoAXltcTOMzh2qxk/Pq6sS1lVRx4FO7DV
	tIi0Foq++nHTPJYYYcsMTmG+zsoVDpBnEitv4wPEO2Yb/wT8U2zw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hg1j80p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:45:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5499Al0O025076;
	Fri, 9 May 2025 10:45:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013058.outbound.protection.outlook.com [40.93.20.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kk3bvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 10:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD47hEHf9dAKnrWSUy0/NqCkQ9UUfwBuN0C4wobxDG+L9eOn/e4RcHBGTMdKaNJjJYgPNIs+f3lacyK9W2IxVLkZOJqR9T6bvzifunb/pzsHZzkbHGR/JOf63froLwpTNSlCWUtribyZkodNC4tV/56RdOyjFw2u0KsZ1/pPPvCbPaRSLaysjSQa0VO7aEJMkYfPAzNyLyjvrWpB/lSaMmfHYeAqdoCRHTVmW6YEAh3UfImLpWsFjeBCeWoG/ISFqGVxvcZSUCNj81m4gYkh3zSdHX7mT7BK94RZxKvd50ZRFIPvhn+5ikq+fmziQDZRJkobBs2XEIhmIhJzuyHa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RcDa73xu37VlFF8QhSirjh5vFfFADWqjH579luYPbY=;
 b=b+21B/RVgvcTnqpNDWeelOb0YKATEE+ujj+kFuEw+msZWZmgKw5cVFxuqg54r9sDw8GADiNaEvkgeWuzAxSrbhboT5RCYUP4mbVO3ejIm4PLUid3EvL189vowPh8v1XPPbzGl419T4WZAaBuzGUEQHsHBH5rVl+SOOo2JGR0Zz7kQt8FtMbJUJM+C2nPS/rqi2x37v8+ZwFMqYUDtnNnG6q8dzbIQg9WvUPP4ND3qLMAc3Re6Fe3jhMY2XgKDZnONoHo8vfJrU1/lrJuGbpk/3izIs7A+M203av62tg42IcM8ojUxTvutXtNtRjr60QBH9+JERgAixf4J1rVLZkXHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RcDa73xu37VlFF8QhSirjh5vFfFADWqjH579luYPbY=;
 b=SwGgYkGVc3V/Fi8FsADarUhajFRyYGfSKBtBjlyaqE6JjkJIPA0stOL7nzdBSSRXs4TIzFH01Dj7GpBqK4eQcFc9KbFOD2/6ZHvPBZJKxINlpN25qEilZ7FV9zGb9H4JrR8AybYEZM4RdOyPCTiy/H/KBcZzHBvjkQekLJN0Q+k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7081.namprd10.prod.outlook.com (2603:10b6:a03:4d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 10:45:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 10:45:33 +0000
Date: Fri, 9 May 2025 11:45:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <9f479d46-cf06-4dfe-ac26-21fce0aafa06@lucifer.local>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
 <c958ac6932eb8dd9ddbd2363bc2d242ff244341b.1746615512.git.lorenzo.stoakes@oracle.com>
 <2204037e-f0bd-4059-b32a-d0970d96cea3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2204037e-f0bd-4059-b32a-d0970d96cea3@redhat.com>
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf3046f-4888-4c52-7135-08dd8ee6a035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oGAkzN58Q83S24Avfug3te7YAGr8OgGMzMC4WfwbYs9KzjdAVib66L6MTpod?=
 =?us-ascii?Q?ZrGkUA5aabfgEwx0aJy1HWJx5BnJx86qWIf+YyeVaeV+AE9EePpDqQk6IRZW?=
 =?us-ascii?Q?StYW2y+6RWDA8XBFM7uy0iVEaCrXeIKtCOS1WX3s2YsYDu9VbJsNPgc0bNNn?=
 =?us-ascii?Q?OTJ4UbW1WmMCqQlMnhkajdCsxT6OfmU++tSF82Izc584bOGwwcKU8EjMOLkx?=
 =?us-ascii?Q?tXmrnFACt7vHwrhxUsZpf98cHtD+/ebNAv3uac1+ohkwueXJOEXiVNl4ScSa?=
 =?us-ascii?Q?fjOIu4+oTw56HCponhDNGshbkYJJR58zQhEOGcmnCYBahAzjpeybCvFgj0Pj?=
 =?us-ascii?Q?Be4n3Lc5++V215js+XVumS0j0RzhySuulQQYKz7kd74PbqQi2nqj4T6w2f9D?=
 =?us-ascii?Q?+BXhFm+ug4VVpjksdzNyyYd4rcn6U49PrLL3YeynZCdG3lEKqCLr4rFmb1dC?=
 =?us-ascii?Q?/fA2o/fmibj1RCgCOwcNuVjOqS7meNLYA9uxYHdyOzvV4IlEDtINclqRjlol?=
 =?us-ascii?Q?V6DL+WN4sMeNQeEWTZPgsQQgfR8nI4eS9qDsp6ot7tRRLP3vsXXGNkrWBex0?=
 =?us-ascii?Q?M6SQNZgXXdXbLU5WqedsT4KzGq/2qwFZj1WiuuS6UqI9006WNcr2dDaK2LuZ?=
 =?us-ascii?Q?ys1sAGfXTMBwkcD0qla9duZZuIdl3hUQM0+iTtfw3RKDIf6gnZ+r7DDwTwF7?=
 =?us-ascii?Q?ATiYp6WZeiAsn4yW+DgAe5ZFU7KuSIAZU/KAk5VPEb//bWdnPmO3Og2BjNZR?=
 =?us-ascii?Q?+hXFfw8gcffDlCjtMTEaxvEVVGar9aWHzN1Fs7gNxlL+lN6jC/m+gmL1XK72?=
 =?us-ascii?Q?LuVERYga+FSQstgX6gJnEJnaX3sl44XZr06zWY36MjpJ0m/lcSn4XhuDXRUs?=
 =?us-ascii?Q?enplObxkq1xJ5PrC3zKAxGmsiXaepY31nOodXGmV/UXJKpL+K3cFRsvWDICn?=
 =?us-ascii?Q?xH/h7GqeCtJVsfcToWqGrERQADrjPhWuz2/5VOXEcd8gcwBpJ83omSAa9hoE?=
 =?us-ascii?Q?snYfPvequA3uyu7la/xVezblW1MYo9G7vwvsYZ99lNf4U3LGNdf1XMKJ8HLw?=
 =?us-ascii?Q?H8lX+eXLhSJJn55dQiNhh+0oFGhVcMB9c4qPs4hOqj7FAm3OjJHU3lUrUyhy?=
 =?us-ascii?Q?SRvS6UvuONWQEtDZTmxG2VVoTkKpbUFVU/AGfDzr1jQsE6eTe8tIcU8cxHL/?=
 =?us-ascii?Q?L0+xKNoqqLFeuwnNcfNo06iLCsEJDCnBdOFGbAz3EO+WDOB9Uvqr9L0ac75W?=
 =?us-ascii?Q?fqr3A6NTQ4krF+sEXiqhNp5yZQ9Bg33IpMPlihI64GZP6Vu+R3lt/pyHWDQi?=
 =?us-ascii?Q?UjGHno3QuFXYbX9c3acnsrwLOHWx0Ij3yq8hzeQDfKEYmgYmDiAX3/RzB4uF?=
 =?us-ascii?Q?GX680zdYo1aSJTE2VSLbzdq505Ywi+7PsIICaGPDAPTVIZdVqv9YkzhhW2Vr?=
 =?us-ascii?Q?+vz5exYy7eA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VhG37/yRPn5LMfwHMnQ/s8Akvduq9VdJoaLEYDgRV6L5HY/HNqyRhNrLwdJK?=
 =?us-ascii?Q?Esb9pfA2uLMr5AdgtjTNE0ln0DLyCy70mlj9tKkWsr0YmO4Bs11xSMQB6rjl?=
 =?us-ascii?Q?UL2GlLXo9nUPfr0zKYQoHcbzBr2C7mcZ8qByLeiyk3im/c+HH9lHt156q1gc?=
 =?us-ascii?Q?5EFhqKHCj0ukIBprzuPg60I5C8EXWouXkHkw+8patj7TNMZYrwg/sLi262ya?=
 =?us-ascii?Q?vIE3HpG6qFIqOjsKSvNfK/nJM2YZQ8rieB5qZmCeRv2RdbVtXWiWKrBwZ6QW?=
 =?us-ascii?Q?PcKyYtC2Kyb+hLywXlEgU215kkPsPms9uKY3TF2eUoKpuiZxybPRbIFAWWWT?=
 =?us-ascii?Q?8thQTw61IqBHVT289OvvTkVgL4drjon4U9Oqfw8hrRwnM3CEBEOsYTDExEAu?=
 =?us-ascii?Q?7PHEN4dfkNbEz3qmYuwHePwJyY/p/fkUeGtspY0/I3BsYcgSJuFWk8Ab60vh?=
 =?us-ascii?Q?NDEBLVZcsTvNQF1F/7epIFMtOTusn7CgQUai54/gOm7eOEnUzxkCS08Qsxk/?=
 =?us-ascii?Q?bvoDBU7jGT0X93/aITYAn0nZj/FLz3uNlUmNtp4z+qFoh3yeY3PbiC6V0Jhb?=
 =?us-ascii?Q?GiASJ+B1OtavZIY1M1yTltUP1iYPwz0XZLaZgS6bC++CEAOHtGAq29qMtZcO?=
 =?us-ascii?Q?h31BD+dZ9RDPdmBryGXmWq9Mt7qkrEHRwUmhRl6qJ1jw+fJrKAP5YGGeDePy?=
 =?us-ascii?Q?0IZhzHVfb8+GHsp3JmC5KuW3qvqmmUbG1viL5vrEy3z6N7ELL+ckiLPGZSmt?=
 =?us-ascii?Q?gm/ai5PX653EPeyHSnlwey2eqpOMP+GC0x1g6vJY9FMGkYlcFUOqKp5T466n?=
 =?us-ascii?Q?/L6zZq4665nDXSOmkk2D/v+SlYqQnnwjTEA8+UgZEoYTJ9ZvY7k3wPx7nIhc?=
 =?us-ascii?Q?Xt3qRznMPlv2g4WnPnS9CYw+OjtuTUCE7WDM1XSvy7hCKbG88bcBDZt2V/GF?=
 =?us-ascii?Q?xJ5g54xd+dJRDlH7xNYnFo7HHYAMaC/QstoOZ1mSex1zDLghrnNUGp3QcU61?=
 =?us-ascii?Q?JtYKNdKaqTwMaxMz0MJWfSbFAbt5ner61b5Mes/cnAWJdeT6/5PS8a2nIpZt?=
 =?us-ascii?Q?5XvD6imhh2EN+PQ7XDuqYWicGcql68bdH7MXVvv0xOkWBF2ANeh0MeAmShin?=
 =?us-ascii?Q?TreoEZxPL91b+6y6dXisavSUBOjNS9gdBt0nDGO2a0GctVUjmd59CvI5UxPl?=
 =?us-ascii?Q?KD2e2ugXOoHxYB8qWXHkVKOyycFK0Ykkeq/t6bQxsn5z8gGJ0vfzXl3cNgHf?=
 =?us-ascii?Q?l/m0jcejvgsAFv/M2jVuULKa1j0pBHtfnMPGAqpPvtg/SXI6vUwFTPjfWvzt?=
 =?us-ascii?Q?X9eQPRkNxCx0/qg8oXZNDg5rlJSlDX0y81yW44jFIDOWs5gw1/6cJLTbB+4B?=
 =?us-ascii?Q?5YSiEAMnn+GjC2hzahFDUVjzbWmSZhetOn66lmdOhsi4MdhUv+fpmBn+5sy7?=
 =?us-ascii?Q?GkryNRPUhYKIWB2sRCXtMWasSGyqi2pwU5xUHq554iuk4fWfa+/rTKJdpP71?=
 =?us-ascii?Q?iET2X0dvFs5Ew5iZZOsSlfNw/Katy5T4U4LDaOalOXKJd6h91RzrIxbyonTE?=
 =?us-ascii?Q?/7WMm9twyElj9y7mCQ4Pv7ndEPSdJkbtscOSk7SaKQeplFRNKqyaF2CGNal0?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Na+neISFox63sd/3Idsw4eNY2UbTST54P7jw9gI45RuRrRADcum+17VstiTQdmpqUglBz+88p0vt7pXt4SFRJnel/8rJMdjbWONDMcX29Dbk2fyBkJZzpbnsSxRwMPckPl2G9/bwlIF9fmL2srOITIouLNZM5FSGj0bLA5PURj8QzK04qN+NJp5D+klW2Tg8SFX2vgeSTqo2uVlO8kXF4h08aVw0b9jlDRqXs/mXUrv5zrizNcgcLToGPGKxbvL8kNiRocqPOyOsCKcZJl3L6bSbzzF+Hkz3mbWcrlGZ8ozB2+ReuA5aG6iXcgProyycX0u+w86Dgf2pbFWAzeE7movxwWX7pzHaWTsKue3Y1zEqxK0+g8WTNN+IpCmm39e27wRmOYudXyhtWoKckRCaXom/4SmPOMDnFSOYz7LzflNEDLOzvmkT7/VX7Xjzn60KTULlfEhbL6zp9mXkeLN+KV7shbfmTUiYp0tk1u0jAP/pQevMZc25L+EziVF8YtpnCg+Fk3sg7vNmthTDFf1EKB0YOj2JWf30yoIXiZa2FQr0qzVbrUwDEbTBFHxQziQH9Ty2uY5gJVpgoaUjx30LpuwifOMcH8B/2c3Lgut6A/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf3046f-4888-4c52-7135-08dd8ee6a035
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 10:45:33.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwlR3VUzu04u1C8pj8TBye06zvIME0MGvL2LAbTw4uT6HfayAExVOPfEO7IP4AqAW4AOYIcSKbPYUGW5Lxhc26oXhvIO0GTpAAc3Nrq8g8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwMyBTYWx0ZWRfX/UrIjT2y/jx8 XxWh0LxkPgnnO5dMgquCs9fp9ktNHxy72jG7OcqeEvOiA0t1CPEkUz+CNkRQdC1oemO71LpcjHA ViIcWDhfFIgTTfbxuy1VMxNFgmR3ZtnVqJ1Vdgm64sJ1B3xUPGIOhiNYH+hlyoX7FJFonn2Zk60
 R2sxzfYislbPRFhVvDZfcc8eoDXIX0p1G63hoXmHq/Zfl3tFhOi9NbmMgOEdH2ImZTW5QUBNGnJ A5rKHtiSiBL8QgLXHSKbjD3gdiHWe9OGH/uaAdaMs3hMUzitTHe/Zfjx3vrScVUHRoWcpOJx9mF Me47d2NRx/ohuaW2Maxuvzb2gTSiyOnfcZuSUFRjoUX6gI5poJ1zuqt0UNtVt7Gxdymp3l00g7B
 Q8/Ywnlyezv2eC9BCwRyB2yKvs7/agVchYFamBMmF945pmXDPz6au1jh7yszsbmbuHYYg2Zw
X-Proofpoint-ORIG-GUID: 2DrDzpxVSiQPpiU2SoG1Dkh2DjtECmFL
X-Proofpoint-GUID: 2DrDzpxVSiQPpiU2SoG1Dkh2DjtECmFL
X-Authority-Analysis: v=2.4 cv=aYRhnQot c=1 sm=1 tr=0 ts=681ddcd1 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=y-ngpYahMhwiQ3nR65IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185

On Fri, May 09, 2025 at 12:00:38PM +0200, David Hildenbrand wrote:
> On 07.05.25 13:03, Lorenzo Stoakes wrote:
> > Provide a means by which drivers can specify which fields of those
> > permitted to be changed should be altered to prior to mmap()'ing a
> > range (which may either result from a merge or from mapping an entirely new
> > VMA).
> >
> > Doing so is substantially safer than the existing .mmap() calback which
> > provides unrestricted access to the part-constructed VMA and permits
> > drivers and file systems to do 'creative' things which makes it hard to
> > reason about the state of the VMA after the function returns.
> >
> > The existing .mmap() callback's freedom has caused a great deal of issues,
> > especially in error handling, as unwinding the mmap() state has proven to
> > be non-trivial and caused significant issues in the past, for instance
> > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > error path behaviour").
> >
> > It also necessitates a second attempt at merge once the .mmap() callback
> > has completed, which has caused issues in the past, is awkward, adds
> > overhead and is difficult to reason about.
> >
> > The .mmap_prepare() callback eliminates this requirement, as we can update
> > fields prior to even attempting the first merge. It is safer, as we heavily
> > restrict what can actually be modified, and being invoked very early in the
> > mmap() process, error handling can be performed safely with very little
> > unwinding of state required.
> >
> > The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> > exclusive, so we permit only one to be invoked at a time.
> >
> > Update vma userland test stubs to account for changes.
> >
>
> In general, looks very good to me.

Thanks!

>
> Some comments, especially regarding suboptimal code duplciation with the
> stubs. (unless I am missing fine details :) )

Responding inline... :)

>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   include/linux/fs.h               | 38 +++++++++++++++
> >   include/linux/mm_types.h         | 24 ++++++++++
> >   mm/memory.c                      |  3 +-
> >   mm/mmap.c                        |  2 +-
> >   mm/vma.c                         | 70 +++++++++++++++++++++++++++-
> >   tools/testing/vma/vma_internal.h | 79 ++++++++++++++++++++++++++++++--
> >   6 files changed, 208 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 016b0fe1536e..d6c5a703a215 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2169,6 +2169,7 @@ struct file_operations {
> >   	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
> >   	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
> >   				unsigned int poll_flags);
> > +	int (*mmap_prepare)(struct vm_area_desc *);
> >   } __randomize_layout;
> >   /* Supports async buffered reads */
> > @@ -2238,11 +2239,48 @@ struct inode_operations {
> >   	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> >   } ____cacheline_aligned;
> > +static inline bool file_has_deprecated_mmap_hook(struct file *file)
> > +{
> > +	return file->f_op->mmap;
> > +}
> > +
> > +static inline bool file_has_mmap_prepare_hook(struct file *file)
> > +{
> > +	return file->f_op->mmap_prepare;
> > +}
>
> I am usually not a fan of such dummy helper functions .. I mean, how far do
> we go?
>
> file_has_f_op()
>
> file_is_non_null()
>
> ...
>
> Or is this required for some stubbing regarding vma tests? But even the
> stubs below confuse me a bit, because they do exactly the same thing :(
>
> :)

Yeah I know... it was more for clarity, but I take your point, this is possibly
not really adding much.

In the first version this had a file && file->... which made a lot more sense
for this. But then I fixed things up such that e.g. file_has_valid_mmap_hooks()
assumed file != NULL.

So, will drop these on respin.

>
> > +
> > +/* Did the driver provide valid mmap hook configuration? */
> > +static inline bool file_has_valid_mmap_hooks(struct file *file)
> > +{
> > +	bool has_mmap = file_has_deprecated_mmap_hook(file);
> > +	bool has_mmap_prepare = file_has_mmap_prepare_hook(file);
> > +
> > +	/* Hooks are mutually exclusive. */
> > +	if (has_mmap && has_mmap_prepare)
>
> Should this be WARN_ON_ONCE() ?

Ack you're right, will update!

>
> > +		return false;
> > +
> > +	/* But at least one must be specified. */
> > +	if (!has_mmap && !has_mmap_prepare)
> > +		return false;
> > +
> > +	return true;
>
> return has_mmap || has_mmap_prepare;
>
> And I think you can drop the comment about "at least one" with that, should
> be quite clear from that simplified version.

Ack, will change.

>
> > +}
> > +
> >   static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> >   {
> > +	/* If the driver specifies .mmap_prepare() this call is invalid. */
> > +	if (file_has_mmap_prepare_hook(file))
>
> Should this be WARN_ON_ONCE() ?

Ack, will fix!

>
> > +		return -EINVAL;
> > +
> >   	return file->f_op->mmap(file, vma);
> >   }
> > +static inline int __call_mmap_prepare(struct file *file,
> > +		struct vm_area_desc *desc)
> > +{
> > +	return file->f_op->mmap_prepare(desc);
> > +}
> > +
>
> [...]
>
> >   struct file {
> >   	struct address_space	*f_mapping;
> > +	const struct file_operations	*f_op;
> >   };
> >   #define VMA_LOCK_OFFSET	0x40000000
> > @@ -1125,11 +1157,6 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
> >   	vma->__vm_flags &= ~flags;
> >   }
> > -static inline int call_mmap(struct file *, struct vm_area_struct *)
> > -{
> > -	return 0;
> > -}
> > -
> >   static inline int shmem_zero_setup(struct vm_area_struct *)
> >   {
> >   	return 0;
> > @@ -1405,4 +1432,46 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
> >   	(void)vma;
> >   }
> > +static inline bool file_has_deprecated_mmap_hook(struct file *file)
> > +{
> > +	return file->f_op->mmap;
> > +}
> > +
> > +static inline bool file_has_mmap_prepare_hook(struct file *file)
> > +{
> > +	return file->f_op->mmap_prepare;
> > +}
> > +> +/* Did the driver provide valid mmap hook configuration? */
> > +static inline bool file_has_valid_mmap_hooks(struct file *file)
> > +{
> > +	bool has_mmap = file_has_deprecated_mmap_hook(file);
> > +	bool has_mmap_prepare = file_has_mmap_prepare_hook(file);
> > +
> > +	/* Hooks are mutually exclusive. */
> > +	if (has_mmap && has_mmap_prepare)
> > +		return false;
> > +> +	/* But at least one must be specified. */
> > +	if (!has_mmap && !has_mmap_prepare)
> > +		return false;
> > +
> > +	return true;> +}
> > +
> > +static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	/* If the driver specifies .mmap_prepare() this call is invalid. */
> > +	if (file_has_mmap_prepare_hook(file))
> > +		return -EINVAL;> +
> > +	return file->f_op->mmap(file, vma);
> > +}
> > +
> > +static inline int __call_mmap_prepare(struct file *file,
> > +		struct vm_area_desc *desc)
> > +{
> > +	return file->f_op->mmap_prepare(desc);
> > +}
>
> Hm, is there a way avoid a copy of the exact same code from fs.h, and
> essentially test the implementation in fs.h (-> more coverage by using less
> duplciated stubs?).

Not really, this kind of copying is sadly part of it because we're
intentionally isolating vma.c from everything else, and if we try to bring
in other headers they import yet others and etc. etc. it becomes a
combinatorial explosion potentially.

We might be able to address with the tools/include stuff, but I think this
is one to be addressed at a later time in some cleanup code there.

I am keen to avoid this kind of thing as obviously things can get out of
sync (the VMA stuff tries _very hard_ to minimise this and only provide
stubs that truly are stubbed out.

I will add to todo to improve this situation!

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks for review! :) will respin a v2 shortly.

