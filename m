Return-Path: <linux-fsdevel+bounces-75599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IzLIbHHeGmDtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:12:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCE956A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0541E3094609
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F893288C25;
	Tue, 27 Jan 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kiQbxLeC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OASdf7wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8F262FEC;
	Tue, 27 Jan 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522931; cv=fail; b=BaW9Yc4h7lxYbB1WGFGJagfglnIyGCOVk/SjFlMjMHxyhW3rreo9t3NL+33KfxrhUcVLzbt2bm4sqiALnHMUsTh3N3yyYelh1qAjw1RQ7IKXqCNs2SzN11+XuLsmh1FiSLpYxeFCGQMDznl62pGdB5L/Zkia7JSJR+FHk0Lx5Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522931; c=relaxed/simple;
	bh=+qvAHCe9ywNnJn3MfRstglFEsNwfVsW6fQYGFb1ZdJg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=P3H3eFKqY66keXT1WTEd0kYHJ457moST7iJ7sJ9OBdUEkHT6Mcz/W5gJe6zgqylzwHiT5gas2ZAc8HdDS0T/3/Diez3g6FHwcnFcZpS7pZy6CLu1ymKhPELxzqwXS+hVhkkmhgaE5y9zOJ9mua3dIDLPPJsxVraymTdG9YgMmaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kiQbxLeC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OASdf7wk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEIPn4055879;
	Tue, 27 Jan 2026 14:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=K007XUBl2T7PtO3GXm
	CMF2SwsvU3Tt2BBnHRNrKFXnE=; b=kiQbxLeCciYrlasGF4N4A2TBhozomQaqNZ
	/6ZVWT9ExlJXNcZs91AvaZaSbjtWl74M8/ayWiQJSaCx1vxthnzOS5eSWw0ishAF
	3/TFvZw8vLLdsicyQkmjLpazOP66LAbsRv2R2OqBvBoxz4e0dJ1X1BE1PVMw/nG8
	6yuYz1vFRB9oUX9cucudbN65RYYrtpd0IjsN5S9f2v6KZu0OnJmS2bwlHi7KZWig
	NBNVAEJO4+VBKInBCo2GtJc+b2HfGPE5TlNO9xEj+FCvCO9C1mNqlr9OlNcT1Ro8
	SYwALCqyXAoabMpM5Ffi4+DFtxMu44Jg3pDEUZ6Inpnu1SJtuB2Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpsc1ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:08:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE7OPq009958;
	Tue, 27 Jan 2026 14:08:38 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9ffh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tok7ARempVDDW7ujXkWBgi8NcbmYx9HUKHpg/g/CiAKRqgigJYfiYYmXSK+QWOUJjLVM9VppkLoD/rYLDUJadc296xCYRpEzErqmRFuSmyXSaYbA/R1Pysn+oIc2GwKKu1pC2HpSoIUhzG0GXBsC71/Pp2TzjN+xlieAY7FuezYZm6j/1N7nrFzl0m4rh2eWHW0xXmESkrHGEQYbfTvimkRk0GLI+3SEnagdkI7u+oY08sK2vk6lKggyu9spJKCN+/o9KDqEiMdbtpfUiWfj1gRm8X6HMvlN4FiDUTSfvub0X0HlaQ5izM99xgQed5OS3cxWrnHaRVVcpuGpHF+UOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K007XUBl2T7PtO3GXmCMF2SwsvU3Tt2BBnHRNrKFXnE=;
 b=wvShoK4SCNsNc9jJbwghYvR7SkSntt7edZAfPJcvITLIjZem1xMKmWcQYhkPQgz74AxyJG4LIPTvDlRFL3sITCUdY3fiSVu+Wg8iGNERswxFvxhnM40UrJFrEibgweuaDp/4f0qS1bVC4I8ZrnjDFnfv/1YVgd4TTZo2BiGR4ULwLozZkIuorLxT0jjBlUktcTFDVp2cXCwIPP826UipoVU4oymn/Tkv7JhY6GnvP2Vh1nYObsR2Wg9qKFfTcNfrQoInP6EeFaMiNEPRqruwNEuRZl3VrsqDL1edcJ+jds8WRqT84G1WYF4v2dkgVtNb0oZROrUFBuUL3aXGxkwjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K007XUBl2T7PtO3GXmCMF2SwsvU3Tt2BBnHRNrKFXnE=;
 b=OASdf7wkfYylnOdsVJiNYWgibXb305TYKo7lfSkxstqj08mbeu/MwV5T7I+wiJPyc//gM3uC4J5xd8WubfLEwLhUBKGkcXnXcQS7nxT7JV8QegRFuyh9dIcKB4+1WmiUM1bt012jQDIM6SSCZZNxlm2qV6Lmf4USI5f4aYVCT9k=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN6PR10MB8047.namprd10.prod.outlook.com (2603:10b6:208:4f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:08:33 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:08:33 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 02/15] block: factor out a bio_integrity_setup_default
 helper
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260121064339.206019-3-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 21 Jan 2026 07:43:10 +0100")
Organization: Oracle Corporation
Message-ID: <yq1sebrw3l7.fsf@ca-mkp.ca.oracle.com>
References: <20260121064339.206019-1-hch@lst.de>
	<20260121064339.206019-3-hch@lst.de>
Date: Tue, 27 Jan 2026 09:08:32 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN6PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 496a57cb-093b-484d-f3c6-08de5dad8e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWoU+eEipVRvMicfMrr+pDuBhsthvW/E5kyon7A1LJ2zDuxZCShTo+u6blFZ?=
 =?us-ascii?Q?NRPym3LwfcdHh3bb1+PssQLiL4p8w4wVDLWPOhfh+c4WHTmWWcFLKVfDi6dS?=
 =?us-ascii?Q?odEwgAVZ4qFKkawViIcRL6kEwDThWZ50q9FjiZOmPCr+g7eQa/It72cyClxu?=
 =?us-ascii?Q?pHVLsRRMcoktoSIbiww93xsyblOf5L5Bov2Z+AH/alIbtQch7GH5WNcEVwx9?=
 =?us-ascii?Q?8ylAOKKxB5Lg4OmNHgwKdaEYq1S0Cm1Iq/6sWMYscE/Zfl1SZMiRmayl+ezq?=
 =?us-ascii?Q?rYMQymlsAyM31sUzxGq2mPkaV2r1piPA7hJ9fOskaJzD3H+VuYnu+wDDXCDl?=
 =?us-ascii?Q?u7qsYIlupfMwTNsgdIbgSs7OXmh0TDJ3fxO2WY0SZfLR3NS073XAZCalMBmT?=
 =?us-ascii?Q?71hLxVSeSNL2LnlVmON00Xt/S6wnZwMb+LB1XzapndCTQPWLspL0Bu2lDgwR?=
 =?us-ascii?Q?T+79EeDb7CnFzn4TvgKzT/Vm9mctBhLrLLZ4l/57/LlbPJXtDuXRBXMkCBaY?=
 =?us-ascii?Q?rg+uEpSV1cPGObVHUjoZnXztjAiXrjbynQxbUuORQXkFnlH2C3s4W3Cskx8V?=
 =?us-ascii?Q?3bmYlG7OtzDYgHOpj99l4/zM+Il6eBTq1ZTH0rngfbh65PCLvnGiXJxV1A4Z?=
 =?us-ascii?Q?ErF7t0SLwelXRIAMcT9SQ4QQkSTraqnP0A7C2tPuqEZwVvbBZ7n2Y2UQJIt8?=
 =?us-ascii?Q?aQNlv3MaDLfbOZl09pGj2RUxeJFklP679D9izgWHTP8nbjx1H1xRRFKddIp6?=
 =?us-ascii?Q?jLPCcZKIPEQ1FAWsG1WlylKwcVQUCXHG6IAYi3aUO2aDtbnrOakvedFPRN6S?=
 =?us-ascii?Q?hlPKSaDJGKxy/IQotJNXk0cNl44ARxxNQgZB2+fyYzfHoPsabiL/HFnP/618?=
 =?us-ascii?Q?7KV6/qafLOnUTcoYZkfyEhkvkGOta3Ly+iKxH5zcSXtrUojd7EiwPZ7Ouj28?=
 =?us-ascii?Q?gi+xFVhYUqRYxaivhFk8Pn9pdPSH6LVn9XV6UKJMwSuZvSfpR0u3nLfNp5tj?=
 =?us-ascii?Q?u7R5U5M+Dtmj0mi+N3j0Na/eavyS2Zj7BSYbdtW6sZEhWhC1U2xiNb8GF786?=
 =?us-ascii?Q?kZM/cW+ej63XDFGGv7Gypxx2qvGjVjZakcBTa7RNofaP9RP8rgkTocgp2+s9?=
 =?us-ascii?Q?u8sTJFEbLDIXvJ0F/r2OOkO155A73NLP3CtHa7kUdCQZfiXGsfAGJtUNeHiD?=
 =?us-ascii?Q?/jsUC5bLLIwTEqCtIEmeT5Irb7J9Sg7E9UGDUPS/c19iCB3aFG0pNWz4aU2U?=
 =?us-ascii?Q?ukTl8M1r9L/TPIiNb+aIKZnhugHrFBsVtoiijz/2FVqoyIE80f/kV97eFq4c?=
 =?us-ascii?Q?nMfNYmtjJrVkDbZfKzeZFPSdKvbMiHykNhAEV010o2nxcxiRLXigKf6daeGx?=
 =?us-ascii?Q?K6k2XMltGcPyomj24pHthsxs9d/9UV2gYRHTYMR0DuSoW4SEQQ2rA+Olk3ba?=
 =?us-ascii?Q?ew0oYFs1VkpEOUlF58xtx5f/jxXkSmRowHJN/PTMTZoacNDo1yuoptx+SdBo?=
 =?us-ascii?Q?Jl3fptNgqiFjeEBJdcWJyIIt4GehPes9vDKc0gReTIOkxc9ZteDLJuoDxlr2?=
 =?us-ascii?Q?glxKtY7NWr7RPCwopuY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RQrWHdLiQuiJYffMD7FQV2ibhgi7waGcFc9U/344ruq0xicu04aw28tz6zMN?=
 =?us-ascii?Q?ma7o8Ty6eOUcgSbyOYU+vtRJOIl9u9xfGUxeq2oKPChhYhhRSpHUxYjJCykt?=
 =?us-ascii?Q?Ae/1gRnqgdXFuTBmPkyU5s9TW+aNK5Y2W88JdpgXSX2L++lGNXIT8JzAjd+g?=
 =?us-ascii?Q?GaGY7rpneX0KTa1DHBpRuK6HHIbNRJP49yJWcOlLIXWzcuxd/JtzJfzAyGyp?=
 =?us-ascii?Q?7m8UquIVybPETuRtAuqTU5qpaNz+9wY5eFKVW/Xeiz2Jr9WLYLmdktqLR+df?=
 =?us-ascii?Q?vUb2HMLLsPLVJtX3SZXKFh78ef3NY+M70QRLY4mBEm22pg2uHkN8TaCSCc1N?=
 =?us-ascii?Q?MkvUJX//99zLHzvEvxTZgUjRwjo+rQL1Cn8le1ys4uL9rbiaThDuU6HAZqlL?=
 =?us-ascii?Q?NXCIyZf3lWR3QHz3OjE3copD2drBWFCXdepuR3cb+MJQ22Q2E+eD+CGuCiIR?=
 =?us-ascii?Q?qq9dMVnNr++rqEYQeqZp5kVZYzkWxpjKtYkB2i3xw4F5Hldlf5nzJlbl4ktR?=
 =?us-ascii?Q?g0zK9aqYJ7xyV0fYLOrXrDpIECqLHPppyC9X7AwXV66hkzgMtb8ct7EBZnOu?=
 =?us-ascii?Q?o7qcnOrqb7u4HcwAxiUuyjwCF3KwIj/mb3xSNHy3mkTeFi0SedGkbgNE5dVf?=
 =?us-ascii?Q?64ZwRuuuinZc8rzmg6Mj0oYgzWhhDovEnkLYUESKnXWerRIVBhtsYP+rDLTH?=
 =?us-ascii?Q?VBKnocVcTH0pj56luE+7lWIOTJBf9c0c/sOsZ/szyUCc6DxdYn2aA+xfMMpv?=
 =?us-ascii?Q?J3Jvlfwvezo+17+feSBD3AvKlx/X2TokvpHKbe1zs3zsC+5yNYnzgaROYV+L?=
 =?us-ascii?Q?XueXuKBUp+N5Gd7SbDmB43OzMNKTWGlgBbUS4N9RYgm7y+mWiUyk7CxxOO7K?=
 =?us-ascii?Q?HvZ4tj0itU0+THyyO0xr+v1TvJU8g7pwNqwF5q+4rAGojZtG6lUXqghoUyqA?=
 =?us-ascii?Q?W4SbdAGXfqcl7lCz+szasFG0BLJ1us1cTQ2AVdy4t0G9deAsaoRV9FCCqAHg?=
 =?us-ascii?Q?tXJq2dDHUf81rQGAgDSXSf1KdtRL3TjFu89bWRJneZx4XfJxn10/yGhrbmLk?=
 =?us-ascii?Q?GKQmL2sm6ENoYb6jM76lgpsi4ot7PHFh0cZz13RseCGBJTVZIj6RZ3yvdrtj?=
 =?us-ascii?Q?2aRoc1ykHbAoRL7wesr7CxF2hxrMoxkNCErOkWA63IMciNAaMF/6m6drMKjT?=
 =?us-ascii?Q?LEUPDmMFyUbt4cQgtDkYBEeTnYDSwwKCyN/NggnD61/6zfpMcNV/sukgXCSC?=
 =?us-ascii?Q?8oaMbOwRaonxwXScJ8Mw4PJoycaHQ1tBsP+KhV/i5W+XVhZvM660VBN68eMl?=
 =?us-ascii?Q?rhghlal4Qgssufgmm/1H9fPQ5K7T+7zsWpg7iREBBuMZHpa4xh8K49Bwv6eC?=
 =?us-ascii?Q?Z6vuUU90NPNMYusnbBUcHE0YVrF6kHcKf6OMwnDIjmYwLvnQ3YbUgcxU2KMZ?=
 =?us-ascii?Q?dDy04LSqHYhnhla3ey/ma+1e4XkwWtS1Ono2rV9iuau8ZAy6ehXFCFZRfjt0?=
 =?us-ascii?Q?guJd9m9apL9gvAbg/4EsrzBTAguvjZ7H/NyvAzuGXNJRmr63Q2BZEZapmfpF?=
 =?us-ascii?Q?Ianbjo395K5E1OsDYnzbQ8zURmOBhTofpHlre6RcwylUGiwk2NCNiqc9u4RO?=
 =?us-ascii?Q?uci+LdRQV9RaEeLTBsQZjYAuIceNRmjvxcRjKDKVzTDxS80myBfUdntHi03s?=
 =?us-ascii?Q?Eny4UJNd/JuWbvz2aFvxEX2uETw2A8UPaUmWHnw3dKBmIldcCclBdDe1ZjBA?=
 =?us-ascii?Q?hVkh+aGpew+uSlw/5zW4FTh75XPf1Ok=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r2IzSTd4oKQDmB6G7dA4Eqm2edptnSsSZQ+J38220voo57BgNC67y1S+nee+Wx4W6sJzqLnKYmHRKho7hj+Dsv214+RMlP+eHZybFvApQxuaQSLzcMlx0OPj2DaKo6uxkRMJItuN+UkhwMDqTg1J0X7JCT+1/8lHcwpK42m6ywADmksYM1hRYXgn7cJJjmHhGRI/5ctZ0wM54jT129bVconkwl7ImrXVXcS2Tat4iifdlcJAHxMqSDi2yhc4lQ8qrUItwopvh6gD21jASyvsSh1ghxu9LgXif+1K4B4GorQ1/p3cOvfqXhWzwQ2NN4HMIc11GdxL8MbDLCMM+A0jm89Kshw7wT+Iuq1CJproCbg4G2h3BrYOkhW6K0OecezFllmJ1ZWVLbv62WHewHkK5UKlDm5ViLOdLriDb10kCyuG0c8kd3cvJl2YdWMJR+MGkCQyf9bkE//4aSsuYT1G07BYxjcw9L21UGJL1Yvu5drGCcYZlAtpRbKLmGGv9uxA/pzDRxdthub2y1hM7I+DGQHCy7bnUB0xQNkX3/pbEt0Z/CUNClmd1P/fNTR+D1ZbaGKjwXOTvc+nJLIQHQhDZ8FqBm44FFE3ItSBc8GomsY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496a57cb-093b-484d-f3c6-08de5dad8e86
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:08:33.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMZe0JzZ0qaeSp/sB8vNeyFzGARjCGmuByxSeV0KKcksCrlQNXtVP/wrFrdhYecsTpyHEiUcvzLx2jao+jsZvKp9yRK7SXcUmX2rwqyAG48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8047
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270116
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=6978c6e7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=IP2dUct5LAiURywwtssA:9
X-Proofpoint-GUID: QilYLveLbrUtCSJ5lckHBjee0zXhcLQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNSBTYWx0ZWRfXwe6lJrsnpjgX
 Q0EaoeQnKuvHHT55JtXlqbnW5caJQo7khKBBMJpxa6KtXabBd+LR/83rMFcCwtNJquc1BawOPnz
 ZOoOvO7Lf6YlQH/ktE6ERDOub1uOIqb4vwLM3mrfqxnbWt7C+pk2jKV4jfdyVGDY6ccdUJ1M+Hp
 3+MhfwzF7O5D5CdqiNxPaB3TC7OU3B6xdWNsKS++CwgFjmmrdZ0kqhWElp69zoy+dP/Ki9MXeDB
 lFLpV5PNMqv8uNz/EsceczehX+IVj5cd3VKByNzlAhWdcectYIomd/dzhc1bPzmG7whtmAZZnjv
 lEsMVEkPJTlGwqlyh8x1OuQh0rQx35iMTC390jBuYBpOLuu+rSGrjDcZ/rRllFFLbr17AJ6ZCbA
 DXVaXLBjVod5q5B+H5omZPC69UAXCu6MskYF+nRNyu5a5yvhuI/iqaOHvMidUeYYIj3Tz+Bx3jm
 ybjL+r0jGJ70VGVAYUw==
X-Proofpoint-ORIG-GUID: QilYLveLbrUtCSJ5lckHBjee0zXhcLQ_
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75599-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ca-mkp.ca.oracle.com:mid,oracle.onmicrosoft.com:dkim];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EBBCE956A4
X-Rspamd-Action: no action


Christoph,

> Add a helper to set the seed and check flag based on useful defaults
> from the profile.
>
> Note that this includes a small behavior change, as we ow only sets
> the seed if any action is set, which is fine as nothing will look at
> it.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

