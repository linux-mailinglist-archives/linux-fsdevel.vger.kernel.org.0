Return-Path: <linux-fsdevel+bounces-36233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FB9DFF62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 11:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F45B2205A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E8D1FCFC2;
	Mon,  2 Dec 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P3JefoIp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ryxBraHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9B1FC0E5;
	Mon,  2 Dec 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733136764; cv=fail; b=eGYQMLuqS3tQsxyYbaiYJyiboFv+0GKt6yjK9D6Zo9+emi/0mqWYE9VcufdS9mphllvI0kq8ABgU1twsWZTDjVMH3Vtiz6xpVaqKdERUiJ9/a54K587zjUDLP2DwOCHZ5ejbSnPfbSTrAY1+A7UztM5xm5qennb59YG80wdPuC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733136764; c=relaxed/simple;
	bh=RRWYOB0/QwEOL4piObNiH8Pjc5ETGUWyhYRppMzLPts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h3JaMc9s0+D8o5IlhWFslDHtyMf07cVTuWVFNAijVoTL2u9G88ev7jGbb318/ThiQJT5nWJiSn8/ll8upPZBoT4uJcetzmQfRSRbvaX1g/7c1CsFbf8n78XOzOQAF12HCJHeU8tgh77sMAnAXLUfbsrJz/BkefvQ/yCIaPpsNWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P3JefoIp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ryxBraHB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WvlH006615;
	Mon, 2 Dec 2024 10:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=T7nXkd9sgPhJovRioW
	TDvtM5c2sTKGrDWlpZP12lDfQ=; b=P3JefoIpFH0h4L4oAP+6w2kyQmJmPEggIY
	Sq2g8I4M+rN8QBuPiVdtHN5ai7avVD8p0LW+ZzvfQlfdoKH9+4ZjSNvgPiu4j7yF
	RB5KtYk1rJwjra40eWibNBmTKW6aiNS48tSFWKR0xhrL2rOqkbRiT8wnjAuHdDL5
	KXbYSMILXUW98XRnGUJJemhvuNVl1vCzhfufKs9YtMvv5iwdLB5ADvaN+r3G0boF
	TNqCXDbVxftccuUOFOj2od/RRmcLv+iC+iDSuBkpfhKgBDNF3XqHbIQadEI01qL7
	DMTZXfGqcBujqV9wehOI6psJwfPRKhvx7KQnpTd3clXZSjr350Hg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tas2m99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:52:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B29jvrU031053;
	Mon, 2 Dec 2024 10:52:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjaufdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlh4Lu0GE8Xzf0N9S+j/1GoUdjYIpWXjaVup3brWj0JI/MBjOsIPP5MDf2ES7XDnnw+JViclC+IsGkMi8GrzOi72kgcBDPQoxMxVSrJdtNXYvzLwjCduqnBfK0lXT/dHjx+fvrkWCHAKkT5oIWY/qMr5qX3Y9OflQCVVEQ+TbYF4X4+5JxEzE/6z2JPA4GxMDs20XLFJjIpw3T/b9SRaVl+S5j7Y9aQL1Q518AC2c20R+Ls2QppKmhYBRHxeUPSIz52JwCm2NQIuEfvXpnSZbZfFlLE0E6OkTVDzDx6E9Fz7/pcXWNgl5hdxfeU2tSMR/fk0SO8FZ+OVKXnaOzCG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7nXkd9sgPhJovRioWTDvtM5c2sTKGrDWlpZP12lDfQ=;
 b=B8Yb2gEr0YdrVDB3v0mmNuX7VRLpd8vN7HiwhW5Q4PieflG+dYW2uTJi5wo1bDS1ZCJU7IbkK/JhvNZcEG/BECmtFeDhThW2QIrrC/9Hjs9ab3MlXp61KAu07v0bPPIss5OspC1BX4GbK6HxWoyb0gUkdtr3pDoQJvX/2eQ2aGFpslFB323J2Gurreat0WF8QgqD4YzFjeLc2ycdEFfTxpvIItDPZJUxBQ0Cc7JRXTBuSM2lMLpH6sYj8NL2KbM3lv2TbSDiwHm0akWMgBR4fFSDFi6OcVGQKBMH5W9lMk9uScKDT9aKzqOMsAwfOQvqDNcL2cy4riOWa7zaC3GV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7nXkd9sgPhJovRioWTDvtM5c2sTKGrDWlpZP12lDfQ=;
 b=ryxBraHBqIyT2TAw5iC/awKmkJEr2WSQCpKwlPkCal6Y1e80K6kV09dNcHkYs3p7miqH8PclmwThOHmfaUI08rn68ey/nsmTUhAy3gRkUt+A8UUscv7jXKy6IqfGVjQvedz8jZZWRlCzoJ4jNRiIOhpuZSVSdV6EdVw4SGrOFFg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4812.namprd10.prod.outlook.com (2603:10b6:806:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 10:52:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 10:52:20 +0000
Date: Mon, 2 Dec 2024 10:52:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <fbcea328-9545-4f3e-9f99-2e2057ce32df@lucifer.local>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
 <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
 <20241028-gesoffen-drehmoment-5314faba9731@brauner>
 <c96df57a-fa1b-4301-9556-94a6b8c93a31@lucifer.local>
 <b8f4664c-b8f0-46ca-b9a3-8d73e398b5ca@lucifer.local>
 <55764300-1b53-4d14-99cc-e735d3704713@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55764300-1b53-4d14-99cc-e735d3704713@lucifer.local>
X-ClientProxiedBy: LO2P265CA0388.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1bdf84-80cf-4312-e588-08dd12bf6566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p8A3j89/8cxWUrFpHVQp1A/Z+vlBjbYzyG7hJWH/fPRWlGMQiEzl16bqujcv?=
 =?us-ascii?Q?hZpvPvDgi3q1ClhG8hB6VGYcFUiTlbyysxFdcVaAJfofEHlXW8BxEUrExfmI?=
 =?us-ascii?Q?RIM1lZ34xv26/fh0n7kGmvEqL8GkYdaRf26HF3uAVVaQQ4JsNpToTsqKxGeQ?=
 =?us-ascii?Q?HuytUK0olQr/k1i/oxGrfl3gPXkNM78Aa1V+lSjDQ+B5FfvdjL9M7d7h2nK0?=
 =?us-ascii?Q?o6QLDdzVWya9Mj+7b/unOBYTlMmNtOoSOFKVtG/abGcOnBLcG+IXhEz2z9F/?=
 =?us-ascii?Q?M4SSOT/y+xi2l6V3Srqw7/VAREop+wPv3E3+hxWxqUB5m24qEHcGUJZLSGnE?=
 =?us-ascii?Q?GJn3EhK/PpjrdJxJpWgEuiwifQniuz9ohwpmQWqg/ZBO7mEu0wbPMvPaFsKS?=
 =?us-ascii?Q?H77Y9B2odgGoAoJiayeuws4VUDCmdZtGSTUnIKZ0kTHOHWNVoKjleShzyosK?=
 =?us-ascii?Q?uUXR+/yjvW0lqZBiEYqUQP/VzihIX8urY9fQFPCZWO1KqR0oH8arE3DlPHLK?=
 =?us-ascii?Q?25iNVyv4tLZ34yKBpktDdYlXbGI7mOp3++gPNn6v/+w/chSRjGBCuX6fSaA1?=
 =?us-ascii?Q?HoiEwlrv9jjbrOHp2ch+ucImmqrvF0DP4X7xAhPef8rURAaj/+AN9F7/WX+K?=
 =?us-ascii?Q?GQS9Q/HVUNmEXLSM6HTky9+x0phl+Xvr1ZwVD3kd3HvLGHOPqvYVg+DaIb3L?=
 =?us-ascii?Q?1GPgUroHWXf5dVLVynItwxL/50qkZfd0Do9Cxj64XQeA2D0QRiTvmydu7c02?=
 =?us-ascii?Q?KgqICCf49rOmMgbxbVU+hsvuqnH9oNQMfsvwhVzzdaDuxypDnYZ/+qICmZE5?=
 =?us-ascii?Q?gRBaHxAGVv3rBK8vJsc4LmNHG4O53KcbPPxUp7ZCMGE9pmKq/PG5lyzIdqIy?=
 =?us-ascii?Q?7VANkf5CGGV6qbm9SOunJ04AakIjPTvwx/QGYdfG96ZM3Gj9fm6SIfLk9PHz?=
 =?us-ascii?Q?EswkfQsnQDsQ9Jt/h0VIVe4R4Mq/FTUEGhqpfctUwCAEZJH6v2VaCCU2f5gc?=
 =?us-ascii?Q?oeXEZoo/Yu4UfcNaK67rURyrR8oUiSKUcRzWa8Ya9K+qBnxOhzP2N0IMORKz?=
 =?us-ascii?Q?7fRRxCzSO6mGRxMZK49n/OGrEJfbIbZyHhrLcsbUjgQMknrCJI3FIIbtdcQ1?=
 =?us-ascii?Q?21zyehf41QdM/bfp0xybUI5BZuukomNpbzAm5RD5ZptQUElXlW3FToxpDGe7?=
 =?us-ascii?Q?nJaMZTvetJZqVSBj/88gdekAP0ouBKoVUmsmK2SwdeVhfG9GTNbB2N211xDf?=
 =?us-ascii?Q?933L75GZ8YZq2lEvBM3DU7kdveqpe72v30LX59U+xOfXNF1AvNsLg66rny9l?=
 =?us-ascii?Q?Ve4RRtG5AFNoAPNZ9NK+WFSYUJ/fXyWKWXFbGlOb/fFMXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENw5bcA8cajfqnL4J+dV45oD8iKDt9wfKXheOkzFE8DWqJpBJtafTPRaiZXa?=
 =?us-ascii?Q?gH+TRcPKCT/qUdX/vwLdZN8xhZz6aUWytLlqNp3m3MWVNP7QNK2iH/piwone?=
 =?us-ascii?Q?S6gwb+njgoGZPJrC0IK10/zspqGn6C65JrdFMAU2JznLyxMN0RPBdC02pOMt?=
 =?us-ascii?Q?793S9niBOCyTb8C5gz0ZcM9GtEDaAgejVnM7V9nUxLvfrNnzWnWQ0NIqu1nH?=
 =?us-ascii?Q?Oxp2thmvjIneCc1bggM2rKTDopOhW2BB9fHH01jVXvI8D62r3Py4iiNOPOL+?=
 =?us-ascii?Q?41B4E1DCaeacV2Hy20TaqMpO2utWXbS0Dp3b3EfPKMG1zmi46p+SAbwNwPGu?=
 =?us-ascii?Q?7fK3iKlmKihneTlzg130Yo/9T5DLANmaoDjX0KGV9bYr75TAMmlXxnnupszl?=
 =?us-ascii?Q?DG13meGtne/YycQPkkCoSAShcK/dWQ6YXZGmCvKFhQcAsqtKxogTFtNSznZO?=
 =?us-ascii?Q?olF8gIZoOuD2sqhM//ycaHg81FQBlIwsM9xEjPyyU5SqgVgC7W+R32hKQFXE?=
 =?us-ascii?Q?soBThsVX49ZDJ0moZNO9lXR+Rm8WmTWNKBWjPgSWFdnmy3FbF4MfJ8zYzlFY?=
 =?us-ascii?Q?LqBrtc2B4x6AdJ75y1RMbEcebbTsmF9LiWEC7TApj67IGkWHbA+4TndqUeiX?=
 =?us-ascii?Q?vAKZgMo3IXkKAq2PMxAmhmAB2Xp3VnhURjc1ppDi/TJBOdLM9jr/mzP0wTib?=
 =?us-ascii?Q?RDsQWo29/O1qvzRygNceY2XQhLnSPEdgrAF5wjrn0ur7Te+MHPgVPYoOVoVZ?=
 =?us-ascii?Q?uW+fg9JxPFbz90Saed4hVDTWBnQBwzzRtPsXLi4N8QyC035CPj0ZLp67BArn?=
 =?us-ascii?Q?uIGgoPABepDidQNVbbZLzos2qHKH/sn+yIp6VNjUb4iRcJhbRB5iwLOIXKX7?=
 =?us-ascii?Q?IG+JZ1+focEkbFEn6uTo2I7G1GaZI/sIomBJuVZIf8UeXP5uTDVFcvCd7HE8?=
 =?us-ascii?Q?sGGKFAER4WOXVcRX4g/8eetn/CuNTSureHVZwwzihe1f9yN/rO5Vf265KjZa?=
 =?us-ascii?Q?EAogh3yUKAFmKzRYBCH1SRsHUK4kW9IPsf/Z4a93gmtjFiR4jMpGDm6wn7mT?=
 =?us-ascii?Q?WwK2dt29i442JFjb9SupAM60VlcB/5QaI99g4nQAbp1EablE38WZfg4K6UtT?=
 =?us-ascii?Q?bPZDaEDRDGAkoyyYMpmCy4lYXmZDVw3cJHueSjk7Y6o0+YnwGKskLy0xDzhk?=
 =?us-ascii?Q?0wvsEJ/cZipVsNtqugzCKTWoiNKeeDXazP82O2/hMc3Cq52xx/IK0FvhHOkz?=
 =?us-ascii?Q?xGHaWXMMi7tUiA9PTgrSxs10/KEcz3YRzimvMcu1qF+3sZHylpfxN58eD/x/?=
 =?us-ascii?Q?GrKU/SvZah6ory0bY8+3HSEjA1NJd2kIETWHbbAcRCvEiFcGlynWqCu8w9rN?=
 =?us-ascii?Q?+SX/N+6CFMRlMEKE3VUqjJXkvDWSnuTYfAiDL5a6nKnBKNqc2j9DNRarOFO1?=
 =?us-ascii?Q?k9DPxnFuwYsk8Fqum7dCfvn8cPJB8WQ4j/sz4Fjd8o3n1oWnTl7UCLmqzNK8?=
 =?us-ascii?Q?I+0pfGfLld/iSr2GGqL/3osL3PjHPQWjWAxa3C4livNqf3nmmgO9ZGHSfX9O?=
 =?us-ascii?Q?rWT1T8nCEEExYrC1lagkDiBmGB6gII5iAi0CwuIeH6jFSiGZZFwIBQhyeZwx?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YXD1J0S3vaUaI8ri7S12aQ8+y/e1vqNjvF6Sjpc7KFyRXgGeGSsp/enLEszwEsCpl1gWz2iV/EqmcC3bPI3pbKbbVFWKEu7L06gxMiUnwPfSnwe12jjYRDsqlnzH9Gs+DNB9YC+wDcEpMu4G5z7DfagFnET3cd4Uf2xUW5++fe8lyYNXMxhwzS9cnOsM3s27U7/WzFlEOBshV9BNCwFsPLnOhIFLkv4vIwABJL/9mEhofn2cQ9sy3OvkRgxJyfZyXljwG8w885EciVrHkpv9myDkp6F1BgKulbPD8yhAOi4xFXdIsSDbiScCn1YmIISKq+shy5nfXBz32W6F1IAbargoBJn8y2vLeZFIwXSzs29E5IT7G6zL+ed5cQquYw58dgHMS7Aoef9vSt/FIF5htaKjjUP170N2xLeR9G6eLV55Bw/ETJNU3Q8NWEKpFO7KF8tqHAG0NVJR6FxzCufy+fRI/+vtilJt1TTIbx/VeOdc0PSvWhyHFlvcnNV8clstyI+V3RY1mLnVFU03pvf5QW7ZUpFCF9z6qB2ZynVL5e7LSSm93xtgi7AMQCy293tXvWz3NTkKaSKdD+fxttJsRl33C18yVB7TjYucW0RnX9o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1bdf84-80cf-4312-e588-08dd12bf6566
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 10:52:20.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tTTqjVFBsCBjuuFnbJaqwf0OCvXBxQX9hmjK24AS9xKSWndNLS8Jk7yDCumOTyVyTW2TQCV4qAnIsiDZQkNO3LhBQlUGGkR2VUzkPT3fYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020095
X-Proofpoint-GUID: nGZMd7VC42b5mTJfAnZh0WD5sQ-URIe2
X-Proofpoint-ORIG-GUID: nGZMd7VC42b5mTJfAnZh0WD5sQ-URIe2

On Fri, Nov 08, 2024 at 02:28:14PM +0000, Lorenzo Stoakes wrote:
> On Wed, Oct 30, 2024 at 04:37:37PM +0000, Lorenzo Stoakes wrote:
> > On Mon, Oct 28, 2024 at 04:06:07PM +0000, Lorenzo Stoakes wrote:
> > > I guess I'll try to adapt that and respin a v7 when I get a chance.
> >
> > Hm looking at this draft patch, it seems like a total rework of pidfd's
> > across the board right (now all pidfd's will need to be converted to
> > pid_fd)? Correct me if I'm wrong.
> >
> > If only for the signal case, it seems like overkill to define a whole
> > pid_fd and to use this CLASS() wrapper just for this one instance.
> >
> > If the intent is to convert _all_ pidfd's to use this type, it feels really
> > out of scope for this series and I think we'd probably instead want to go
> > off and do that as a separate series and put this on hold until that is
> > done.
> >
> > If instead you mean that we ought to do something like this just for the
> > signal case, it feels like it'd be quite a bit of extra abstraction just
> > used in this one case but nowhere else, I think if you did an abstraction
> > like this it would _have_ to be across the board right?
> >
> > I agree that the issue is with this one signal case that pins only the fd
> > (rather than this pid) where this 'pinning' doesn't _necessary_ mess around
> > with reference counts.
> >
> > So we definitely must address this, but the issue you had with the first
> > approach was that I think (correct me if I'm wrong) I was passing a pointer
> > to a struct fd which is not permitted right?
> >
> > Could we pass the struct fd by value to avoid this? I think we'd have to
> > unfortunately special-case this and probably duplicate some code which is a
> > pity as I liked the idea of abstracting everything to one place, but we can
> > obviously do that.
> >
> > So I guess to TL;DR it, the options are:
> >
> > 1. Implement pid_fd everywhere, in which case I will leave off on
> >    this series and I guess, if I have time I could look at trying to
> >    implement that or perhaps you'd prefer to?
> >
> > 2. We are good for the sake of this series to special-case a pidfd_to_pid()
> >    implementation (used only by the pidfd_send_signal() syscall)
> >
> > 3. Something else, or I am misunderstanding your point :)
> >
> > Let me know how you want me to proceed on this as we're at v6 already and I
> > want to be _really_ sure I'm doing what you want here.
> >
> > Thanks!
>
> Hi Christian,
>
> Just a gentle nudge on this - as I need some guidance in order to know how
> to move the series forwards.
>
> Obviously no rush if your workload is high at the moment as this is pretty
> low priority, but just in case you missed it :)
>
> Thanks, Lorenzo

Hi Christian,

Just a ping on this now we're past the merge window and it's been over a
month.

It'd be good to at least get a polite ack to indicate you're aware even if
you don't have the time to respond right now.

If you'd prefer this series not to go ahead just let me know, but
unfortunately I really require your input to know how to move forward
otherwise I risk doing work that you might then reject.

Thanks, Lorenzo

