Return-Path: <linux-fsdevel+bounces-47540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C52DA9FA8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 22:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BD41A86B06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CA81E32BE;
	Mon, 28 Apr 2025 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4G0q6Ma";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iS2kdzjb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22538C0E;
	Mon, 28 Apr 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872014; cv=fail; b=vDFg06H7FY+DLdIi6epOYjo7igHPP30BCZRxpAoE3hY7xZTeC+apqFB++r+HpoCot/MGboQWOlNlSOAMwPPexQdDRcGVlnRoFNjwQiorc2W9P5jKjQ7k3fAGuKi90+dQTQ0OUBTk6uAJ5dDtibPJJUTN6C+98CT0APzRWi0iH/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872014; c=relaxed/simple;
	bh=q+eBcGGTmM0VSWAl7SOXUZpJ6FcC3PQh3A78+VgDYfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=usAGtxv5xzzd6ko2btmLQiFVlU8w7yUkquhS+HzdBU8ixSprT75cZf0zR0Z3dCK2jrpsHXRqgN3xn8iXQJw4QL/Kli2KxxcTNxMkRVhooh2rpSpV5KT++VPXUQXI3E6U2LA4dAPXnjC6j+gK2IZ7MDaI5vdddEU5mvq8v5ysV8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h4G0q6Ma; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iS2kdzjb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SK8Bmo018461;
	Mon, 28 Apr 2025 20:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=S/++5VPGkCkydo/fnh9sQ2HnjZ1zqngibPyyAeIIfTI=; b=
	h4G0q6MaYaWKSf1VWVC47EIq8qth9/U0eaMC7rvN0XnQaig95D506rChMEOkrhzx
	rBENXWDmJ9WErYa9oe0gi9pq1yBPTbn2d4gKEHrYHoNpvWO9Rxbpj1M0GoIphGL1
	6DKuMZosmvBUFT+a53MYWsvaCsLAw/sP4UmHEzobu687PkqOU+AlmtjJf2qNRjTw
	Njq5cSERv5KjvvR+xkzaBuEf9hQJCifkUJPAo9vbp3WpPitlficSE/2wuBT/akKU
	AY8g79nX4gCY9qU/+o2SXPK/Ml4coSzQRTnm9NSWU9lca+hx65pR8jqgpaq4z+XD
	vTj+ZmFsbzpYprr/k98PSg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46age4818w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 20:26:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SKNdLh033466;
	Mon, 28 Apr 2025 20:26:34 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011030.outbound.protection.outlook.com [40.93.13.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8xaku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 20:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5tr548XLFBz1bpd80STxccjnCJNTn+5uavFOzBKzfxs8EjO+sREndpcrqQcgwv6Mf1cFDgYXT3Wzq7Emgef6KIJ4q2nX+u/3G9TIm2v6T5W3TjKr3lKbKR4A1BaoGB46RwNJHSF1XymadmCArMRFTmzdtB5dV6SbnBgY5zL8pzqyOf3IbKbIGkyAlCMqRPm8aF6GFXODdlNqQgXXxEKb2wNWdAuFt0U67rgXfXvugFk8F3QIx+5ymr/bfpE5jS4GRLIfgd7KlMp55f203tW0iCRE5v9q3j5WVc2T55aUIPJTaj3UheqlTp3FxsZwxA03+3Wl7SvlG5hSKvd35OVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/++5VPGkCkydo/fnh9sQ2HnjZ1zqngibPyyAeIIfTI=;
 b=TL4JQeVzojTck4xGraN3POuq2imhmq7bSla+CUlmXRe6a0CV6lRMawPchKadKva/77O6ibW9UNebGukda1vcUJ+3HFkoVO9mANShbRaarGw0TZSsGfF/i5oH6GfgxTmZlcRZbrovHZqaDdohyRtwoLY8nKuqJ/Q76YePgppCS/BPiSlJ5CeNTi4PsVxTVyBaDOSNBMKDk3wjtMz+8TWSstxLMTDqwNpEC0ISujUfdQTRSe00hv7ezEr7YPT1pNutMpf+nVRA5MzmP2obM5bekVa7yXXzXkkcRlDtrRPS98KLsAHRsKNCxlh29C3IxVqRfYRi9J4B79yhz9UuEwViNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/++5VPGkCkydo/fnh9sQ2HnjZ1zqngibPyyAeIIfTI=;
 b=iS2kdzjbIH1s0aA1iRBDN7LcqERdPmtsaXMikWDbkn2PCBZRsX/PwaHfg2yhe6SedobBYsNAn3/SVeq4wMkVjRJklHnG0paWSfJ60jJ0yXeQWh/XrRsSEPQWOPdx8MKS99lXVTtkPo3jUF6rauTeYKfQdH77QXC5ES0Zi20BQRk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5123.namprd10.prod.outlook.com (2603:10b6:208:333::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 20:26:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 20:26:31 +0000
Date: Mon, 28 Apr 2025 21:26:29 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm
 VMA functionality
Message-ID: <80f0d0c6-0b68-47f9-ab78-0ab7f74677fc@lucifer.local>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
 <p7nijnmkjljnevxdizul2iczzk33pk7o6rjahzm6wceldfpaom@jdj7o4zszgex>
 <CAJuCfpHomWFOGhwBH8e+14ayKMf8VGKapLP1QBbZ_fumMPN1Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHomWFOGhwBH8e+14ayKMf8VGKapLP1QBbZ_fumMPN1Eg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0602.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b3459a-3ef2-431f-bd6a-08dd8692f66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3dxd20raFdJd0lvWWpYL1l5TXhabUZmbjc3Q1FoS2g0SVVhalM5VkJsZXJJ?=
 =?utf-8?B?ZFQzL1hZNmIrNDV4bE53UXdpY3Zqc1VjZXBaNHRaQzBUUWErdlh2Q3plNlor?=
 =?utf-8?B?M001aERRbDJRMEtRRXpFb2lmM2ROZ0lYOFNxbk53d25RU0ZPRHVaeG5DYnl4?=
 =?utf-8?B?V0pWOXIzOUYzQ1poUlhOOHMxOTAvWVQ2YStTazFvQS8rczNyckw5dVJXTHFL?=
 =?utf-8?B?T2Q2cU52OS9CSjFIUXozUk5XMno1VEw5WlI0YUliNXRnUG03azhGeWlZWmxx?=
 =?utf-8?B?R21OWnRJRVRaSEtkS1R2MWVlQUw5RGpCcnpwUzc2SjR3V0daTWc4dXBxUnM4?=
 =?utf-8?B?UnpxYU8relVXYXhWRlpQWGVPdmQraDlBL1pkdnc4MFAxcm1aYnVIaHFaQ0Nt?=
 =?utf-8?B?dUMwcEtTaG5mUjZ0UEcvMzdscXdXcTcxM3IvSXkwM3V6aDhFTXV0cHQydFpS?=
 =?utf-8?B?QkdiRE5PeE5TdTVYMUpsQ2t1eVpqcFhrYk5CN0o4T2dWQXJUeFNlTUs4dFBp?=
 =?utf-8?B?UEZueDkyb3ZBejVqOTA3NDdISzlqNkJualQveVhVUEh3YmpjL1QzL0ZOYkRR?=
 =?utf-8?B?R0tHK1phdjI1UzFDNnF6MkZYeU9XRDM1WFhXaFIxN1dBTmFIYlg0Tld3bld5?=
 =?utf-8?B?WjlHaWpsc0RVSW5ZRzA4ODJSMFhpam1oLzdWRjNxYXo3ek9JVnRFYWYxMDZq?=
 =?utf-8?B?TFBjWTRXM1VVVll6SmM3My9HY1hYZjc0VUdjMDNUaDgzODJFa2FuaUJkWTFx?=
 =?utf-8?B?b3hNWnhRRTNsZ0hmS2E0REhpMXpOU0dSWUJKZ3pramlMc2pBR05wUE9jNDRN?=
 =?utf-8?B?MS9HK2JSejg0TllrVEYzN3FsMkF3K0U0VS9KWTBEdisycjRrdVVvZ2YrSFQr?=
 =?utf-8?B?WGlRd3phVHVVd2Nsd2JmOThFc3l6eHN3R2UvdUVWZDVSUm1Xc0MzTjJUa1l3?=
 =?utf-8?B?RzhwQ1IwbEhFNFdRSVEvaFdlN0hoV1RPRGVBMVBYN0JSejFUdGJPQlJJV0c1?=
 =?utf-8?B?eVg5bjFkaHJzaUxBYldPVHBTYzdsVkZHTGtQVGIrUThaMlBwM2doekJqQ2Nu?=
 =?utf-8?B?WGxQQVEvTHdJbmYrNGx3Mmd6ajlyQTErS2kxTU9oRHBlK1JsRm5zenZLK3VF?=
 =?utf-8?B?OHpBR3hXb3FuRFMxMWxoVTQ3RHZUYi90WkVGRDdyK21tSVlrRjUzcEZWV2xo?=
 =?utf-8?B?RGI2M2JyelczUXYyZkpPZWJzQm1qOW0wOXZhbExvc3hpQkViTm5ySm9Ud2Zw?=
 =?utf-8?B?VEpEK1lldElNYi9lRFZGVE5wVWc1T2wvZHlQY1RMV1ZWSDhkWkZKYXhBMnBy?=
 =?utf-8?B?ZmhJNndwZE5tdnJoM3p5eGJldlpYTjZQemdmc3NZMlZ1MnFYMzhKamxKZnMx?=
 =?utf-8?B?RFo3RURwWGxJclQvVm9UczhmdEN0ZFJxZ0hpZUQwSGtLaXhHbkNhYnU3THBL?=
 =?utf-8?B?RHEwZHZUa1R1dS9PYjVqU0lMSmJxTDU1QkU4UlBkREk0Y3hqdmx2V0lMcERJ?=
 =?utf-8?B?R0hJMHlIMUx6VXY5eGRhNFlhNUlYODRrY2FTVHByNmRYcGR6MHMxNitJN0w2?=
 =?utf-8?B?T1AxL0ZKNXY1azhScXFEMHdvcmdoMHE5V3FoaXM2b1JGSlV1WjFkb1dTOG1F?=
 =?utf-8?B?Q3B1enpFMnIveE5ucTdFNTJpUy82clJBQlJEa2FKWTFRdHV6VTQ4Rk1EN01x?=
 =?utf-8?B?M25qRHB5T0VFZHpiZGpsbVlTZERIVDBHK1daWm8yY1BhWFI0ZEY0eGhQbkFa?=
 =?utf-8?B?SzNZVlBtZ240MjJUUWZNTjlROXF3REtqRWsreEMyWk5ORCtCYVNCVCtHRlNL?=
 =?utf-8?B?ME9RaHk1YnRXd0ZUL05tbmVWMkVHbGFyRWI4MnFFZ2VEenFnZnNCeFhSM3pX?=
 =?utf-8?B?M1Y5ZlZVejVuY3VSS2FCNllYZVpCYTdicUdvMTFsQys4UHd3UTRRaGlpU1VC?=
 =?utf-8?Q?Q748yPbE0yE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGhLREZHaStUajlMUk9rWE40WmxGRVk2RGJRZTdCMVhxdzN5emVkcDdrSGVz?=
 =?utf-8?B?R3dqMnFUR0pJLzFIY05ka2hMenZyckhYcmM1Z0ZUNGFsZzNHWmx6VWlOSVds?=
 =?utf-8?B?QnZmRTQxTlJnNmcrRWV3dUV6aldXZE5OMngwSHkzTjRaUFh2S2tRZ1ZVclI3?=
 =?utf-8?B?bno0bVNXS3NKNnhDVzhpTWlEK1QxU25YZ0ZyWjJiZWp6MUhZSUtjUm82SkJ6?=
 =?utf-8?B?bzI5amwwYm8wb1VNV0VVczZkK1BITHRZY1BPVzZTOHVpNk45dStvNXE5SUlF?=
 =?utf-8?B?Tm5ydGRXSjRUQVVmenRQUkV4dGRneHVaN1Z0ZS9ac09zN1M2eXErNitYZzRq?=
 =?utf-8?B?Y2RhZFVQeTJWYVAyc0ZMVXNGb2ZGTXpKWXlrSnE1dFFsM0x5L1I5L0NmV0li?=
 =?utf-8?B?V0FPYWJZVXFOV05iVW41SEcrZEd6dkx6ZGduL05idjQ3NVV6Tk1PemRtbTBk?=
 =?utf-8?B?ZUtEUk9Ma21Xd3JVaU92Y09PdzNyazVLYWFHbGZDaStaL1NwZkNDUGVpemVG?=
 =?utf-8?B?VjYrUHFxQ0N3bThGK0tZdUdJTHl4UEZRdE1nOXVaQUUwcnQ3ME5tR3J4WTI2?=
 =?utf-8?B?dm13NENuemptaWJ1Qm1lSlE3NFJ1bWg1ZmM3a01xVXdjcEk0QytlRkl5Y2NL?=
 =?utf-8?B?cXRWK2g2MmxkSS9PbHFvNXRaWEo2cjNLcVNYQi80amJrNWUzbUd0QjlScGdo?=
 =?utf-8?B?YkRyZkYzMzZaQ0RpOE1USHJEc0VBU2ZKV2srS3g2bWg4aVNseERSS0Z3cFRK?=
 =?utf-8?B?SitZTm5SVjlPMUE5QWRKejYwVHNpTXBjMUN5ZVVjZ0tHcE95RXZOUXAvVmtk?=
 =?utf-8?B?UW15OUFsMnpVQUNpb0FPNWNrblVvRHlBaEJ6ZVdVd2JPRFo5NEU3bDVxR0Vq?=
 =?utf-8?B?SVo0U1FWb2p1ajV2bnBlRm5MLzBRbDR1a20vcFV5QTRsclJSRkFoTHdid0t3?=
 =?utf-8?B?cFVyb1R3Yno2allKd2R1VVpiVXZMdTVIUUpUMmJiRUhibWVHZUZhZFZUdG9p?=
 =?utf-8?B?UldKMVhaLzVpdDhkaXR4ek94MXExbGJLWDhQMXpmcTNLMTRERVlySTRsc1Y5?=
 =?utf-8?B?WVRKSXZlcmczeStVVFp5Y2JmR2hUVXJmYWtVbG1QYmZZZHM3OEYvOTlDK1NC?=
 =?utf-8?B?bVBpUllrL1BORDZWcHg5U3VIRmZFbEhXTzlyOHNxV0JyRDVKMmV5ZzIxLzNi?=
 =?utf-8?B?YkJOTEpPRkNsdWpYTmxJQ2s5Z25JOW51UnlaWmF5Nk0xU245bFNtcVNnYmxT?=
 =?utf-8?B?OXEvczFibURGLzdNRHl5U0tXVTB3ZmcrRC9xNkVUdERqTGtLVVVweHhoRkNB?=
 =?utf-8?B?cEdzVW1RY1B2bUFxeEorYWdLcng4Q1VxamxlSGxpUWl1bytpSGhHeE11b2tq?=
 =?utf-8?B?cEZ4cG9mRWd5Um9aSmVaUmhCMGdwZ3B0WHJrQ01QZGp3Rjk5S0NXQ0twRVhw?=
 =?utf-8?B?NW05SDRmbDFJdWxFbXh6aTdIcFY1c2JUVVFTQlFJb0VOWnNZSDVNZWFtdTFl?=
 =?utf-8?B?cmt1dnQzUVpZU2hZV2hqVDFhVUd1dEcxUm1KenZCRkRkanhSNDlBdzA1cGRa?=
 =?utf-8?B?OUxFTUV2MGlWSVBsMGJqejVEQ1VZSVhzVHNZRytwTi9YWW9PNUh2NmxBa0N5?=
 =?utf-8?B?QmRZc0toMUdiSzd6NmlaQ29Xc3NLSjRCRWs4dkZRY3VFeDJMdkZnbG4vYXJr?=
 =?utf-8?B?OW9iUGpjWFpjT2dBVXUwbkFUVUlsaGNFY2YzSmIvSWxDY01xQVRsem1lZHpp?=
 =?utf-8?B?azBYUXpLeHA3cm5kYlNKMUR0TmRIbmZCbDNZWHh6TU1jU0kwOW53SWhGNnNs?=
 =?utf-8?B?dDJOSTY4RjI1a2liM2xGdG8xVU5jQ1ZpejlxQ09KWFhQYjVCN3cxQlVOY0NV?=
 =?utf-8?B?ek5ZbmJ1dkJHd2NzS0RMaURjUm9QeXoyKzJCSVh0S2NpbFNXbk11cjQyMWJr?=
 =?utf-8?B?UUNtWFZqdFlHd2R1QlRqOUw4aGwyaW9kbzVpYTZybEpjWDB3a3JjNlk0ZGJv?=
 =?utf-8?B?eTlnVFlXVnVscXdFbWtzcmR6TUpodERLSXNXRXFDUHFQQXlDNkhjRFZLY2Z2?=
 =?utf-8?B?b0tvVkh3OVFCOUZ5eVRoRmFtOU5TdVpZUkVLUG5nemh6M3h0VmxMejVhQStY?=
 =?utf-8?B?TUNpM2YyTE5idWZ0bW1YQVdCc2lSVmM3MWVwQ1REWGRvYXQxeStRQ2tpbjA3?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qGUiKCPn/oKy8A+JuSoXJq1EeMCqIkHBlKD6MRErXRWO3xMH3/+xYuWI57PCkGWji7sHCMrL6G2fY3xognGkh4JGJldQ/IiEg0cPUBt2aRf4xi4WDZE6sKw9RPuaz98NOKfUQFB/nz+6sFWPchtCHq8K1nbT/pcmmA9PtOaMXiZ4hxFxUMcxRW0h4n8IEU+ykeibNzJ7G1QkLIKYk8HPqiGea9+J4TWjg4tKV1f/FpTCkvzzJBt0vKe58Ery3xb0qE2mBiVJFcgNctQe4UnUR4t9nkBhWVAFaBh1fK3R4KBpSNj1ADrnqwUssKL7y2bS8dm2m41ILhPerlYzEjW3F6ewMRXeExm24JfPiRGxUWIPVZgVEH0HzstATyCK6r8p6DL6moJlSAgyf/921QzIJmQoWyF2dKa0M8S2ek7QvS3DD+xBNfk7E2mHtJEdckLc8vi/rrqqpwxxvS4/sbDkjYQwi79CEBL+mmsIBdmll+Nv7MQ063S8pXtzz0VUSG+JTUAd6SIGrc9ViNacXCBUSp/3softbOZyH/BcHcrs4GqZr4KURjc19WtdCHlpmmZ7uEow24/4XH20jTWsVVZf2Hvp4Lrno8xuR90OTjaPGbQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b3459a-3ef2-431f-bd6a-08dd8692f66d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 20:26:31.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUqf0tnyhOOAGg3798gKfzTkJs5h9Yau2c1a3PplRKhmt3mRwM3yTlRFa8BeZJwoN6WSw62I/SFz0Ck8PWpcZMQQ4pbem4aiphbi+jZXQHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE2NCBTYWx0ZWRfX1JjH7cBX2RtA 1dZ4DoI35yw7EbL04VT8ZxoQBzOQtET6C3UcRmuDtVGOZM9DHYkWQyUYRC+7OfmWdb1MMu5+bBQ jqoMXqR/eeq2g40s3y9M5HmJm5jCugxIYHjHmn4V9Jivarzb8btMXC3Qy9x6J03VnSgJww9N1Dt
 S+PaTm7Miq87SThWztSv2BiYEXY1a6rWYtauXG2yJADV5xfGOxiN/l2bnBBS1fKHV7KcmyrtVf/ lA9NiTLiZnzv2bTheNjD0X/8Rs+A9XQrAKWxOVDPbwvyUr91Xmo4Lv5OPVBglozZri99qZAn8kT vZ9YMoDLEHONYGBIWwHMDfmlwZ6CeRno6QZvXX6tHHygDobLwRBZMFqIMsDOfDqkYNSDAmavI1P kbmRMngA
X-Proofpoint-GUID: P3kbQfkBj4NC45ICfiF09OAoTngYd0_l
X-Proofpoint-ORIG-GUID: P3kbQfkBj4NC45ICfiF09OAoTngYd0_l

Andrew - I typo'd /* vma_exec.h */ below in the change to mm/vma.h - would it be
possible to correct to vma_exec.c, or would a fixpatch make life easier?

Cheers, Lorenzo

On Mon, Apr 28, 2025 at 01:14:31PM -0700, Suren Baghdasaryan wrote:
> On Mon, Apr 28, 2025 at 12:20 PM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250428 11:28]:
> > > There is functionality that overlaps the exec and memory mapping
> > > subsystems. While it properly belongs in mm, it is important that exec
> > > maintainers maintain oversight of this functionality correctly.
> > >
> > > We can establish both goals by adding a new mm/vma_exec.c file which
> > > contains these 'glue' functions, and have fs/exec.c import them.
> > >
> > > As a part of this change, to ensure that proper oversight is achieved, add
> > > the file to both the MEMORY MAPPING and EXEC & BINFMT API, ELF sections.
> > >
> > > scripts/get_maintainer.pl can correctly handle files in multiple entries
> > > and this neatly handles the cross-over.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> >
> > > ---
> > >  MAINTAINERS                      |  2 +
> > >  fs/exec.c                        |  3 ++
> > >  include/linux/mm.h               |  1 -
> > >  mm/Makefile                      |  2 +-
> > >  mm/mmap.c                        | 83 ----------------------------
> > >  mm/vma.h                         |  5 ++
> > >  mm/vma_exec.c                    | 92 ++++++++++++++++++++++++++++++++
> > >  tools/testing/vma/Makefile       |  2 +-
> > >  tools/testing/vma/vma.c          |  1 +
> > >  tools/testing/vma/vma_internal.h | 40 ++++++++++++++
> > >  10 files changed, 145 insertions(+), 86 deletions(-)
> > >  create mode 100644 mm/vma_exec.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f5ee0390cdee..1ee1c22e6e36 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8830,6 +8830,7 @@ F:      include/linux/elf.h
> > >  F:   include/uapi/linux/auxvec.h
> > >  F:   include/uapi/linux/binfmts.h
> > >  F:   include/uapi/linux/elf.h
> > > +F:   mm/vma_exec.c
> > >  F:   tools/testing/selftests/exec/
> > >  N:   asm/elf.h
> > >  N:   binfmt
> > > @@ -15654,6 +15655,7 @@ F:    mm/mremap.c
> > >  F:   mm/mseal.c
> > >  F:   mm/vma.c
> > >  F:   mm/vma.h
> > > +F:   mm/vma_exec.c
> > >  F:   mm/vma_internal.h
> > >  F:   tools/testing/selftests/mm/merge.c
> > >  F:   tools/testing/vma/
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 8e4ea5f1e64c..477bc3f2e966 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -78,6 +78,9 @@
> > >
> > >  #include <trace/events/sched.h>
> > >
> > > +/* For vma exec functions. */
> > > +#include "../mm/internal.h"
> > > +
> > >  static int bprm_creds_from_file(struct linux_binprm *bprm);
> > >
> > >  int suid_dumpable = 0;
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 21dd110b6655..4fc361df9ad7 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -3223,7 +3223,6 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
> > >  extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
> > >  extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
> > >  extern void exit_mmap(struct mm_struct *);
> > > -int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> > >  bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
> > >                                unsigned long addr, bool write);
> > >
> > > diff --git a/mm/Makefile b/mm/Makefile
> > > index 9d7e5b5bb694..15a901bb431a 100644
> > > --- a/mm/Makefile
> > > +++ b/mm/Makefile
> > > @@ -37,7 +37,7 @@ mmu-y                       := nommu.o
> > >  mmu-$(CONFIG_MMU)    := highmem.o memory.o mincore.o \
> > >                          mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
> > >                          msync.o page_vma_mapped.o pagewalk.o \
> > > -                        pgtable-generic.o rmap.o vmalloc.o vma.o
> > > +                        pgtable-generic.o rmap.o vmalloc.o vma.o vma_exec.o
> > >
> > >
> > >  ifdef CONFIG_CROSS_MEMORY_ATTACH
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index bd210aaf7ebd..1794bf6f4dc0 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1717,89 +1717,6 @@ static int __meminit init_reserve_notifier(void)
> > >  }
> > >  subsys_initcall(init_reserve_notifier);
> > >
> > > -/*
> > > - * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
> > > - * this VMA and its relocated range, which will now reside at [vma->vm_start -
> > > - * shift, vma->vm_end - shift).
> > > - *
> > > - * This function is almost certainly NOT what you want for anything other than
> > > - * early executable temporary stack relocation.
> > > - */
> > > -int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > > -{
> > > -     /*
> > > -      * The process proceeds as follows:
> > > -      *
> > > -      * 1) Use shift to calculate the new vma endpoints.
> > > -      * 2) Extend vma to cover both the old and new ranges.  This ensures the
> > > -      *    arguments passed to subsequent functions are consistent.
> > > -      * 3) Move vma's page tables to the new range.
> > > -      * 4) Free up any cleared pgd range.
> > > -      * 5) Shrink the vma to cover only the new range.
> > > -      */
> > > -
> > > -     struct mm_struct *mm = vma->vm_mm;
> > > -     unsigned long old_start = vma->vm_start;
> > > -     unsigned long old_end = vma->vm_end;
> > > -     unsigned long length = old_end - old_start;
> > > -     unsigned long new_start = old_start - shift;
> > > -     unsigned long new_end = old_end - shift;
> > > -     VMA_ITERATOR(vmi, mm, new_start);
> > > -     VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
> > > -     struct vm_area_struct *next;
> > > -     struct mmu_gather tlb;
> > > -     PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> > > -
> > > -     BUG_ON(new_start > new_end);
> > > -
> > > -     /*
> > > -      * ensure there are no vmas between where we want to go
> > > -      * and where we are
> > > -      */
> > > -     if (vma != vma_next(&vmi))
> > > -             return -EFAULT;
> > > -
> > > -     vma_iter_prev_range(&vmi);
> > > -     /*
> > > -      * cover the whole range: [new_start, old_end)
> > > -      */
> > > -     vmg.middle = vma;
> > > -     if (vma_expand(&vmg))
> > > -             return -ENOMEM;
> > > -
> > > -     /*
> > > -      * move the page tables downwards, on failure we rely on
> > > -      * process cleanup to remove whatever mess we made.
> > > -      */
> > > -     pmc.for_stack = true;
> > > -     if (length != move_page_tables(&pmc))
> > > -             return -ENOMEM;
> > > -
> > > -     tlb_gather_mmu(&tlb, mm);
> > > -     next = vma_next(&vmi);
> > > -     if (new_end > old_start) {
> > > -             /*
> > > -              * when the old and new regions overlap clear from new_end.
> > > -              */
> > > -             free_pgd_range(&tlb, new_end, old_end, new_end,
> > > -                     next ? next->vm_start : USER_PGTABLES_CEILING);
> > > -     } else {
> > > -             /*
> > > -              * otherwise, clean from old_start; this is done to not touch
> > > -              * the address space in [new_end, old_start) some architectures
> > > -              * have constraints on va-space that make this illegal (IA64) -
> > > -              * for the others its just a little faster.
> > > -              */
> > > -             free_pgd_range(&tlb, old_start, old_end, new_end,
> > > -                     next ? next->vm_start : USER_PGTABLES_CEILING);
> > > -     }
> > > -     tlb_finish_mmu(&tlb);
> > > -
> > > -     vma_prev(&vmi);
> > > -     /* Shrink the vma to just the new range */
> > > -     return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > > -}
> > > -
> > >  #ifdef CONFIG_MMU
> > >  /*
> > >   * Obtain a read lock on mm->mmap_lock, if the specified address is below the
> > > diff --git a/mm/vma.h b/mm/vma.h
> > > index 149926e8a6d1..1ce3e18f01b7 100644
> > > --- a/mm/vma.h
> > > +++ b/mm/vma.h
> > > @@ -548,4 +548,9 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
> > >
> > >  int __vm_munmap(unsigned long start, size_t len, bool unlock);
> > >
> > > +/* vma_exec.h */
>
> nit: Did you mean vma_exec.c ?

Oops yeah, I did the same for vma_init.[ch] too lol, so at least consistent...

>
> > > +#ifdef CONFIG_MMU
> > > +int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> > > +#endif
> > > +
> > >  #endif       /* __MM_VMA_H */
> > > diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> > > new file mode 100644
> > > index 000000000000..6736ae37f748
> > > --- /dev/null
> > > +++ b/mm/vma_exec.c
> > > @@ -0,0 +1,92 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +/*
> > > + * Functions explicitly implemented for exec functionality which however are
> > > + * explicitly VMA-only logic.
> > > + */
> > > +
> > > +#include "vma_internal.h"
> > > +#include "vma.h"
> > > +
> > > +/*
> > > + * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
> > > + * this VMA and its relocated range, which will now reside at [vma->vm_start -
> > > + * shift, vma->vm_end - shift).
> > > + *
> > > + * This function is almost certainly NOT what you want for anything other than
> > > + * early executable temporary stack relocation.
> > > + */
> > > +int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > > +{
> > > +     /*
> > > +      * The process proceeds as follows:
> > > +      *
> > > +      * 1) Use shift to calculate the new vma endpoints.
> > > +      * 2) Extend vma to cover both the old and new ranges.  This ensures the
> > > +      *    arguments passed to subsequent functions are consistent.
> > > +      * 3) Move vma's page tables to the new range.
> > > +      * 4) Free up any cleared pgd range.
> > > +      * 5) Shrink the vma to cover only the new range.
> > > +      */
> > > +
> > > +     struct mm_struct *mm = vma->vm_mm;
> > > +     unsigned long old_start = vma->vm_start;
> > > +     unsigned long old_end = vma->vm_end;
> > > +     unsigned long length = old_end - old_start;
> > > +     unsigned long new_start = old_start - shift;
> > > +     unsigned long new_end = old_end - shift;
> > > +     VMA_ITERATOR(vmi, mm, new_start);
> > > +     VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
> > > +     struct vm_area_struct *next;
> > > +     struct mmu_gather tlb;
> > > +     PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> > > +
> > > +     BUG_ON(new_start > new_end);
> > > +
> > > +     /*
> > > +      * ensure there are no vmas between where we want to go
> > > +      * and where we are
> > > +      */
> > > +     if (vma != vma_next(&vmi))
> > > +             return -EFAULT;
> > > +
> > > +     vma_iter_prev_range(&vmi);
> > > +     /*
> > > +      * cover the whole range: [new_start, old_end)
> > > +      */
> > > +     vmg.middle = vma;
> > > +     if (vma_expand(&vmg))
> > > +             return -ENOMEM;
> > > +
> > > +     /*
> > > +      * move the page tables downwards, on failure we rely on
> > > +      * process cleanup to remove whatever mess we made.
> > > +      */
> > > +     pmc.for_stack = true;
> > > +     if (length != move_page_tables(&pmc))
> > > +             return -ENOMEM;
> > > +
> > > +     tlb_gather_mmu(&tlb, mm);
> > > +     next = vma_next(&vmi);
> > > +     if (new_end > old_start) {
> > > +             /*
> > > +              * when the old and new regions overlap clear from new_end.
> > > +              */
> > > +             free_pgd_range(&tlb, new_end, old_end, new_end,
> > > +                     next ? next->vm_start : USER_PGTABLES_CEILING);
> > > +     } else {
> > > +             /*
> > > +              * otherwise, clean from old_start; this is done to not touch
> > > +              * the address space in [new_end, old_start) some architectures
> > > +              * have constraints on va-space that make this illegal (IA64) -
> > > +              * for the others its just a little faster.
> > > +              */
> > > +             free_pgd_range(&tlb, old_start, old_end, new_end,
> > > +                     next ? next->vm_start : USER_PGTABLES_CEILING);
> > > +     }
> > > +     tlb_finish_mmu(&tlb);
> > > +
> > > +     vma_prev(&vmi);
> > > +     /* Shrink the vma to just the new range */
> > > +     return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> > > +}
> > > diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> > > index 860fd2311dcc..624040fcf193 100644
> > > --- a/tools/testing/vma/Makefile
> > > +++ b/tools/testing/vma/Makefile
> > > @@ -9,7 +9,7 @@ include ../shared/shared.mk
> > >  OFILES = $(SHARED_OFILES) vma.o maple-shim.o
> > >  TARGETS = vma
> > >
> > > -vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
> > > +vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_exec.c ../../../mm/vma.h
> > >
> > >  vma: $(OFILES)
> > >       $(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> > > diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> > > index 7cfd6e31db10..5832ae5d797d 100644
> > > --- a/tools/testing/vma/vma.c
> > > +++ b/tools/testing/vma/vma.c
> > > @@ -28,6 +28,7 @@ unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
> > >   * Directly import the VMA implementation here. Our vma_internal.h wrapper
> > >   * provides userland-equivalent functionality for everything vma.c uses.
> > >   */
> > > +#include "../../../mm/vma_exec.c"
> > >  #include "../../../mm/vma.c"
> > >
> > >  const struct vm_operations_struct vma_dummy_vm_ops;
> > > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > > index 572ab2cea763..0df19ca0000a 100644
> > > --- a/tools/testing/vma/vma_internal.h
> > > +++ b/tools/testing/vma/vma_internal.h
> > > @@ -421,6 +421,28 @@ struct vm_unmapped_area_info {
> > >       unsigned long start_gap;
> > >  };
> > >
> > > +struct pagetable_move_control {
> > > +     struct vm_area_struct *old; /* Source VMA. */
> > > +     struct vm_area_struct *new; /* Destination VMA. */
> > > +     unsigned long old_addr; /* Address from which the move begins. */
> > > +     unsigned long old_end; /* Exclusive address at which old range ends. */
> > > +     unsigned long new_addr; /* Address to move page tables to. */
> > > +     unsigned long len_in; /* Bytes to remap specified by user. */
> > > +
> > > +     bool need_rmap_locks; /* Do rmap locks need to be taken? */
> > > +     bool for_stack; /* Is this an early temp stack being moved? */
> > > +};
> > > +
> > > +#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_) \
> > > +     struct pagetable_move_control name = {                          \
> > > +             .old = old_,                                            \
> > > +             .new = new_,                                            \
> > > +             .old_addr = old_addr_,                                  \
> > > +             .old_end = (old_addr_) + (len_),                        \
> > > +             .new_addr = new_addr_,                                  \
> > > +             .len_in = len_,                                         \
> > > +     }
> > > +
> > >  static inline void vma_iter_invalidate(struct vma_iterator *vmi)
> > >  {
> > >       mas_pause(&vmi->mas);
> > > @@ -1240,4 +1262,22 @@ static inline int mapping_map_writable(struct address_space *mapping)
> > >       return 0;
> > >  }
> > >
> > > +static inline unsigned long move_page_tables(struct pagetable_move_control *pmc)
> > > +{
> > > +     (void)pmc;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static inline void free_pgd_range(struct mmu_gather *tlb,
> > > +                     unsigned long addr, unsigned long end,
> > > +                     unsigned long floor, unsigned long ceiling)
> > > +{
> > > +     (void)tlb;
> > > +     (void)addr;
> > > +     (void)end;
> > > +     (void)floor;
> > > +     (void)ceiling;
> > > +}
> > > +
> > >  #endif       /* __MM_VMA_INTERNAL_H */
> > > --
> > > 2.49.0
> > >

