Return-Path: <linux-fsdevel+bounces-28899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A24379702F8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA8E280FE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE6215F308;
	Sat,  7 Sep 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DuwIriM3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D4CPdCQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3F15884A;
	Sat,  7 Sep 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725723289; cv=fail; b=mGJgKXGDYcYWYshCpIkHTmeWZUoS5HEIXPE8X84usaYiJpbI+z4JhP5KKyB3aiH69f2g8nSAMP/LLIwInl/qCSSsOGjB4pZ6W5Mk6sf6KjXxt1W9fI9oCNL4hd1IzzWKT6POqJqLN5JXlhPkSZyhBqdAuSIiHLwFx5sn00kQtII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725723289; c=relaxed/simple;
	bh=KDJrCKGwYeTcTjGk8/DPIX0BWuAo2G7Qhlqem24+INM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WxBHL2SjHhDuJtvt+kilUpwhE6bO6br30i8Sch903WkZ3LCg+o3l1rxkmwBQRJnNnqye+93mveehQhEhbk6Svtk4E8TtSszm39p6uYUu5KcJhuTnrkcN9dN2nY+r5zhRAa6ItyEM8L4MleRR2g2Igy7b9m478xmDtxCW0bcFw5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DuwIriM3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D4CPdCQj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 487CxtIY019129;
	Sat, 7 Sep 2024 15:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=INJIx9qpBaBymlV
	mkq5LLDpVJk6v+bGO/np6zM00xb4=; b=DuwIriM3yXVXoQ6kowEzJ/l+wV4bKB4
	038EHt60wpX5lY0GkuVHoJXtqxutBLgKuNGnbq8WPhSZMqjIJjWGucd55u6hlwIM
	kC11Fu9FMItyHEkaK0fV+NoFF/27rp8UzIb4HmAriVIng6ckLLexARpSAOA7Ddq3
	vW0Ht4JrcnuxKTzi9VtbQhhgM10i+8sP5Rql+YVQZfX+GuAyKgHcBNo7EI9x7nRq
	UGd0S0mpwQ0A8MtYYybuKJRHMLm8Fe+fyRYz55K9T0vltnxbcBmry0O4mC4nou82
	p+fOhegMWq7x5MJC2MoaxLMbeonl8rWrZSy9+iNQBJ3QNTm4bLgiawQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gd8crfrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 15:34:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 487BV9p9032386;
	Sat, 7 Sep 2024 15:34:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9c3att-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 15:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty+f1rToaOl9kwuY7N8SLtEl2C9t/+fcPt3tA/tBI89v4NUt3XHP/nluZeezkGZzeESPL4osYsWVxfW6gMW3OStDKKnIq2iadpzM7TFG3slkzBtWBwvVARDWqivB4htePZwBnajVaDt59nnuidyJp/hT5kcwNJz3Iyh9mePX1X9zLWkrU1oYKJLKbLUqYdyNozGiVTrXVvoG5aVDzylTqFh31aOETKmAx4I6kuSDuhixfYSz0A2BuBW8f8hwe4ZU64FiXNeOBVWfUmjxvm3VM+8Jpm933AoYNGl5FSPZ9jBVq7z9eCYy2+9McHaCOzBxuEViVLzCBDIz4ADAXzkZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INJIx9qpBaBymlVmkq5LLDpVJk6v+bGO/np6zM00xb4=;
 b=QZnPgx8QYAkH0VzlxG3zAXzcsn1XIzMw9s71I/3KaJXpjg622WVzIVpJYJlX7ms2pPyHD7wizHT77OTTvXIK6sTLQQU3yuGVwt+pzOPKYUJFC9RJmx5nIxiys3fc1bH1txoOmKXr7IKVxzXEtpFx1aVfZGnT6+TrTHXjeFn5IgeuazgHAEEAU0QCtONzB4/Oo9JuZOWAKdhA4khOSX4jNidJgtxOmyIZ3N7qUfanRGvI6kjZVb7FlTVfMoFAzZrpP4weYUtqYB4kYRvo/Vf34DiW0QSjMDaQs6s7chBaznv6wiEJunKf0si2cVgPjQ4zbKjBw1+U6UB8JwSgas+t8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INJIx9qpBaBymlVmkq5LLDpVJk6v+bGO/np6zM00xb4=;
 b=D4CPdCQjKoDwttFIJnKfM6h8BZH37dBU35aBVUmHyao1AoRiT00tCUiJcHpgVe/z5l1gBm3RdsbuRtvxHURnHDwJMIjvh61Ul4m22uKg2pRHZ/yk0D71onQcGhc2VDnM/DlxVpoSwUUIrVHArZdVJVLfnPC78kigzA1MXhP3xNE=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by SA2PR10MB4428.namprd10.prod.outlook.com (2603:10b6:806:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Sat, 7 Sep
 2024 15:34:18 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Sat, 7 Sep 2024
 15:34:16 +0000
Date: Sat, 7 Sep 2024 11:34:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: replace xa_get_order with xas_get_order where
 appropriate
Message-ID: <67g6bjo4xu3ba2dc2fat5htwgv3brkom7mhsqlsklgufhac2dy@lnqv2jflatzc>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org
References: <20240906230512.124643-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906230512.124643-1-shakeel.butt@linux.dev>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YTBP288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::40) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|SA2PR10MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 857f0be5-2bcd-4c89-f430-08dccf528887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/UJcPKnJ0C0jYiDO0ZMCm9e8j8Gnv/7lPQC4Sxia/tPTk/CDU2/7QPX0XDrn?=
 =?us-ascii?Q?Mh2GpVSbLkicYVQ1Q4wuM1Nnx/vujsG67Gzo8/Oymg/IEpYlLpd0lxIZutiX?=
 =?us-ascii?Q?8dMr5w1IyQ2Xt6HZW7W81AjDIHn7NrsusGICCVKZVCxxH2oucO3Y6mTw/dU3?=
 =?us-ascii?Q?WdIW0MuuBhXEYOc/rxamvQpZFGYilfhiBxiDdK4paRmy0XGLa5EVMZxzwH4s?=
 =?us-ascii?Q?cp/Jo9PTpDPOudi2IlbsKEYf5sAc59uLbD10IEz9dOiBFYWGqLSzdXvLHqPv?=
 =?us-ascii?Q?+8ypg3SqwU/0DQUBGtzWdAIzUVL8ad8jLX0W/YsSxRL4mOjf/3yhyXpocpb9?=
 =?us-ascii?Q?OPb4QwFcN16+Vj9hxZccW14ZaH8o/hvcLI5g+lIAz4sPIjI4eF/utz8Yelws?=
 =?us-ascii?Q?bH6YTP39CFifMB7PUDlxUFeqR3wUmdN9elZf2opQcATLdNR8UC6MoKlDm+90?=
 =?us-ascii?Q?gPff30UHR/UC3H9ACn93CqcEdUZBEz0XbJ0or62dt8MgZnG5qFRs1xbBs5Q0?=
 =?us-ascii?Q?3RoNrhd4YH1CV9/4aeODxODL/4FnMuNQdMGL53QwHToUyH9ve4blzrGNk5Nu?=
 =?us-ascii?Q?4cm0yPib5gKfyd7PdvWZ7n2Almpk9Q3PDdNZvcvNs1S2zfRWrGTL55RdUZjT?=
 =?us-ascii?Q?pT6rfRCt02DyPXUnTs+7zePzUHKLxOsZi0zs5puLE3s2SywKJSqNnLH/VrBr?=
 =?us-ascii?Q?FmB5jicAXae1/0rd4Dx23CkLApqxULv+CLrQ/vJbwGWsoWoPJqtQz9KNyTza?=
 =?us-ascii?Q?iPYno5c0d18gtxWzftI6h1k9xHXrhI+4FUhsUX31E54rXftmc2gLCoL3HyNZ?=
 =?us-ascii?Q?jyv+ZMgemW7IqgWYfHfT9yk37Y6sY6pz62KL5bwOMFElt+sKaKIILAasslta?=
 =?us-ascii?Q?74E86S6/aMcxT/3ZJt1o587MpQw8atkK6BeO9GIJ2uOHtDOF2r9OnVr4eL5Q?=
 =?us-ascii?Q?iNw1FWeO4W9lQfMZt5fG+lhmnUDbx0EUR3xtkVt4P0rwC8PhJepLV3zIi2BG?=
 =?us-ascii?Q?k/EqeXh+08FWNjkxVY18b7ZkMFk7wl0EATlqL4uglIssw+cxjyTzL+FX/p1b?=
 =?us-ascii?Q?7wLBR7YitouyHx23kErDHp7bCst0kutAnTa3pOCG8Rnk7QtQg/HESdhClYys?=
 =?us-ascii?Q?rSjhAu2CLRETruWJwjTx+3qJRcFev5Wds6xVK3JSMGX4c4G+HQRvoiLhSe4U?=
 =?us-ascii?Q?ZS83QMTErF+MBi5aNA9Mq+N3qduR3zTSQh1EBAUeVUXsYiWmWZb4WenJSDK4?=
 =?us-ascii?Q?qskLorBZy8Y9yAd1YjLVUgk4E8IGf9XVqKMW8rVulzzu6uCP5Sg7EJSYUyc4?=
 =?us-ascii?Q?HGRPGnvrCt6Qv8+GAzJLLs25+omSuYgF02S14GOOcP0/8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E3CvckOW3LOUtuDlFoK9wnn0N/LP5LhxYEQ/kksvbh8+6DR12HfiDg9QH6+A?=
 =?us-ascii?Q?zFG4LmR0kOsf+RT7iDdKZax6C55dLUHjfCfUWbaIvS2NvdZCYOB5mgpdINyc?=
 =?us-ascii?Q?yHXuHp8H6RuCgaK63NyFclizhe42VwL86Z9a5n5oAjQ9rlQUyo7ngfG4qcK6?=
 =?us-ascii?Q?JW8J0CHGtv9NiOYw1ZtWmrqf4/m734XUByC2eOkOJRGZX+HMJzYxC9QfsyTL?=
 =?us-ascii?Q?ePNEFLBhJWm6YauQCFpzuyzxSK9sZvuu7u2yQ0HClnZkujq7aKDhmnxy4Bkw?=
 =?us-ascii?Q?fjTBoRItGIvgYN8xhn4yVa2F9YQ9nF96utCOSqc0i8zJ/hkmj6ZuAWP9n1/7?=
 =?us-ascii?Q?/HyTWPmwDalEyWN10rkUsLzFdTFESYp8vIC9+SNEklD3+nBRtS/tfNjddZGY?=
 =?us-ascii?Q?uk68dQm9nK2OzQfdkvV/b7IoaAGxZKOyHKkq6MUO123wPHSoMGR4FNej+9wK?=
 =?us-ascii?Q?rjXcucNxBNYfZGLYaHUfa59qJNUtDdlgOxSAClj3G8qubIZctzuodqFbwcnA?=
 =?us-ascii?Q?SHc/O914L9KLIuY24GM2DpRB6fqMGL1pMOT7Xo+jRWLE88g6Vz8DUpwyFYhk?=
 =?us-ascii?Q?fdilc7p9XX0PTWIXiKxqNMk/GgFpfO0FfSYmpRrcXQzTRvyLth8I2CLIrDw6?=
 =?us-ascii?Q?AV5EU9ApSK1qcxHxE2Q1XdQ1Do+KZvpoBUhdMWHr5MNAoZZ+bAFkXywUjCaQ?=
 =?us-ascii?Q?pKz526f+fTCre1IfiO1LvkhtkNLLjrAUVRlwB7ZiKcvryRBms90Y1ng+9Dit?=
 =?us-ascii?Q?ezlA02trmw95KQH5HOoF8SvyRuXkMGp4ad8Xdyzoj+IxVxRIRPDG4GMrKc0F?=
 =?us-ascii?Q?Rvp+K+SLlFP6pR4oF8hpcbBt0OlvCltDH6T0yPFIJ+whXqhrkaDVETxEtxg0?=
 =?us-ascii?Q?gb3GzpuvqMtE4GNcWeLZkdtOFpZL62Oaeq0B2tDhJ2BawWlTEe+0eHtnaac+?=
 =?us-ascii?Q?Tx2NBvzjbv0vEJoy6e/N1pUHsFA2/KnQPV/m4hNAoqSDNLaSvxOAPjW8KTX+?=
 =?us-ascii?Q?kZ2LokNRsZTmT8rpDvTGNNnUgoARL8MaduzYldMJiOid29WQKWAsHXJVVrs+?=
 =?us-ascii?Q?NNilkRaphwYsufWjuu6gjZnRgGd+MQiRrzV8McRh9CbaHNvl+cc47jP82tvE?=
 =?us-ascii?Q?2GbWMnElOxRKeTbaINyWgM3UBie4bDQLGVXVoDKt5uxiBigpoe6ubdzKR1Om?=
 =?us-ascii?Q?/0mqY6C40negu/u1U949vbuV3s3PKB7aZXnm956MSnsvl36wRpdbjcDWMyLY?=
 =?us-ascii?Q?5IZD626KZnPRsu04UVjERKSaxIpy16WYqLsglrYTJsbe1BxXhrABDYidZhMi?=
 =?us-ascii?Q?f2tMSNHZBrA0P8IrflUDRAtID3Fw1SGu0b5Wz0ow6s8d/kY4ptVf3jtJ6y0u?=
 =?us-ascii?Q?evmIaMqgHudjrDYqV9MFmH0Vf42/x+7RXf0gVuxymCaUpWPN9S2tIcUHeq8V?=
 =?us-ascii?Q?0orqAAcsT5J4OMHQUDe0Jeqfdp0LWu9+eHBsO8/3RaXmaYIhW+lvHTr4YdfS?=
 =?us-ascii?Q?i+ER9QKc6D8g2Wa1R3wsDFMF3R3xX4bmjFNWjEbpCVHf94qQ1GNZDfDz4m8+?=
 =?us-ascii?Q?aErd9ziiZMmeAZ5z42PPbMPMiqDJvtHIo/7Qw0Ir?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BdmwGFpl/soL5KM6apCGgJOQIjLWmJcDrECjQNqmClPjJ1gIns+6zqs79VORg8UocnXJBJ9+2EBVQv0+05p3wCJCpJyk+h3axCCVsnBD2OrJOgUczD8cVkQ/b8mVa5Oi3/A8ftUoiX+jXK5wSyCfji49+BfhIDl3Kzoj/HhPAvFESKHjyCA+vCDpr8GE9jkcgnxlq0BSXNRqu8v0iL7gA70aRrpBTu95umn6nObX6yhPbO6k1PitltabgdO2iXppxRBUAAZGh+iTtdJZV3TUXy3ccwiqG/hXSkRbYqJCnHRmDnV+GV3cqqkEjtfyJGFjZoXaL348+klm+3YHxPQZtTk4NEnLy5DTJOxhu2s38t/VRyi6fHImvfxoscas6hLQDV+EN0R9UrO1zQqp7PtXoip6z6QrD0xYIytC2pqB6ZVTCokQzsYD1hmYWKrWeYw5yGwHraB3I1sAcR9MDcp1UMFSOx++y9C3819k7PmSaltjQzKRicIy3Mbtx8mQzKLSDtCHHnO7paEECgfRMXBSMwvSCoou8K6RH6xFmuI326P4oENQl7BlBbVLv9mfKPLpTcXARfXudnkx42qn+fdTREyRzmqOJ4cv1fvuV8Sr8Co=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857f0be5-2bcd-4c89-f430-08dccf528887
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 15:34:16.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9U1wv3EwFAbh5p5FjCzknDHFcy3LKeZyHi96jYhfT6lNplue3KBLz4NR0XogCdmi+re17lIzzsI5UHCS9KvPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_07,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=955 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409070128
X-Proofpoint-ORIG-GUID: QMepSq1cEfPHpeLzlCZ7mw81lWejptJt
X-Proofpoint-GUID: QMepSq1cEfPHpeLzlCZ7mw81lWejptJt

* Shakeel Butt <shakeel.butt@linux.dev> [240906 19:05]:
> The tracing of invalidation and truncation operations on large files
> showed that xa_get_order() is among the top functions where kernel
> spends a lot of CPUs. xa_get_order() needs to traverse the tree to reach
> the right node for a given index and then extract the order of the
> entry. However it seems like at many places it is being called within an
> already happening tree traversal where there is no need to do another
> traversal. Just use xas_get_order() at those places.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

This change alters areas that already do the rcu locking and the
internal state of the xas isn't altered, so the external loops are not
affected, afaict.

Looks good to me.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/filemap.c | 6 +++---
>  mm/shmem.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 070dee9791a9..7e3412941a8d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2112,7 +2112,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>  			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
>  					folio);
>  		} else {
> -			nr = 1 << xa_get_order(&mapping->i_pages, xas.xa_index);
> +			nr = 1 << xas_get_order(&xas);
>  			base = xas.xa_index & ~(nr - 1);
>  			/* Omit order>0 value which begins before the start */
>  			if (base < *start)
> @@ -3001,7 +3001,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
>  static inline size_t seek_folio_size(struct xa_state *xas, struct folio *folio)
>  {
>  	if (xa_is_value(folio))
> -		return PAGE_SIZE << xa_get_order(xas->xa, xas->xa_index);
> +		return PAGE_SIZE << xas_get_order(xas);
>  	return folio_size(folio);
>  }
>  
> @@ -4297,7 +4297,7 @@ static void filemap_cachestat(struct address_space *mapping,
>  		if (xas_retry(&xas, folio))
>  			continue;
>  
> -		order = xa_get_order(xas.xa, xas.xa_index);
> +		order = xas_get_order(&xas);
>  		nr_pages = 1 << order;
>  		folio_first_index = round_down(xas.xa_index, 1 << order);
>  		folio_last_index = folio_first_index + nr_pages - 1;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 866d46d0c43d..4002c4f47d4d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -893,7 +893,7 @@ unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>  		if (xas_retry(&xas, page))
>  			continue;
>  		if (xa_is_value(page))
> -			swapped += 1 << xa_get_order(xas.xa, xas.xa_index);
> +			swapped += 1 << xas_get_order(&xas);
>  		if (xas.xa_index == max)
>  			break;
>  		if (need_resched()) {
> -- 
> 2.43.5
> 
> 

