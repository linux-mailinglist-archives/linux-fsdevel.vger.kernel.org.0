Return-Path: <linux-fsdevel+bounces-65532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21465C07222
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B96465066E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CDB332EA3;
	Fri, 24 Oct 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dA26+ChX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MdmNhI/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D032D7F7;
	Fri, 24 Oct 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321863; cv=fail; b=W3PbcWCRfJTBOC1xzPRILFZrs39MuNsD5KEe5ujQWgp/LCYrEm2AGnFpHcnT6LkFiTJpfW9eUCwhu5j41Bvza4ODXwQDBSWqfkdSSawZnnEZzeAXCp3PcBA/JVM/uLh3XJuPBlPHeBwA+YA8WR96t2+pND0NnpjCqh9X1LTrr+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321863; c=relaxed/simple;
	bh=yr8tNYcD822MBIRFfmB83nZrJK3VRSdRRrSUcdEZ53g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JgRTPbR/BdbSMf9NgXxa50OX2Wlfkyc9IWzdUs3RmpKBiLI0/hQnjeFSST7gzJdN6sJpy7QUtXS2e79XUorcQkuOoVqoLHBfTdv5PFGGhmMP9RXx/OvkuMGI0omCICk8nx434O6vetaa6s3qS74a6a9Lq1gngAdwc/tzxtbYBSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dA26+ChX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MdmNhI/Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OEgMoE030462;
	Fri, 24 Oct 2025 15:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8IRoH9zlSdWUxDVwWL
	6L1SAiQ9tQ7QkpdiTy2TDM/vM=; b=dA26+ChXa5hVUCZhYyhIa0aiXTHRR1WXHu
	VRevK4RxXfEbB2SASHfa0cgDxSQFFdx+Q7SSKIbXNvTFUSOFi2eIxwwY4Y3SN4dR
	QgHRIqXfc/T4iti+WdePJmFEIKR1i63WJUittpQX2FMTihrCblWgh+lvepL5hx5z
	VChzKdWkAV7K2KyGRGuBBgsvE8H3KbmNHXlU7riUVKEEMjpkY4zFjljvBNnNflrw
	EFKhLRSe+b154zzb9i/fW0MZNEuAG48DtkygFZNRNrHyf+4CKQmyfRwjgg36TGWG
	O64UuqzYEpruB8SAAPpe5DdgfjEI6/N7zPbglRA6vJFNIqEKZJ/A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw4ant-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 15:58:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OFsVaU023295;
	Fri, 24 Oct 2025 15:58:36 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bh4qr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 15:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJlCFSqF5F3qVbFQQ1p7VHsDV21fzmloYDI9OAePbI5793tuDE5PGIVkXRTLAu5RftiwmtbEMLOlprSBPtlgLXpSZK1K6MnjCcJw8uhdnsnj9yTR8LPg7e/ut0lrkXYIQsSaJTmcstJenQPZjOj5/mYcb5Y/QG4kaW5hX04C/W/uVScasqr0b8p0+JG6xaUXwye9jnWRY0Y3f5CXnCNVmsWu+JI0L1LsgwzTanYtNND5aGwwbfvlJLcaLSCdygnGGvvBfBPGTISSeQMYZaj8WlqpfP3LNIDjxJCwvkv9XDtyrMbm7+oYHyayjXw2aRklKCM9SH4K9hgKzERo9vKfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IRoH9zlSdWUxDVwWL6L1SAiQ9tQ7QkpdiTy2TDM/vM=;
 b=u1JldPhb/HznS1dfxCEQd+kI2GTh4DorPRmREIlelr39O7hLV0s3ZlkIIW/HHIniiBnni/S1IlnB/ULeN2vDVRFXsrfKfAwkkDZ2lMq+15wHdPVYl85Z/HJB8727FEoBKrxEjjwmsZqURUOlVqWMXdILTvgVESvMNqOVs9nzxFXoqoCpGEhlLGUFHQ3kjgx/cYBVJBo2jIrqKPb4d8h/XnuNWpLWWzPnVxictweWjdp0AlCvGAdL9l6kf+MZKI9HehVHGBFKNd9vTqKi6pQmVvwPE+n/rMAEs2csVaGWcmMLQn6bLtrvbLPElNFzTQs4qadpBSK5Ny4iJlHBcwtelg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IRoH9zlSdWUxDVwWL6L1SAiQ9tQ7QkpdiTy2TDM/vM=;
 b=MdmNhI/YLOqHCIc3Cm952yzPdH9dFMsmXcubCLCm3b7mO8nZdXoY6NywFuXFzXu9SorAAeIw3ZgMFOlFFbcAlr3XG2HqPLZ0/4UeHTLZhZnRLSS4AejRG7kQ7iW8P5rncmjP6HsFoRd8WM2CFlZQ5lzFZyivw0lWpentVjIDO3k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:58:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:58:26 +0000
Date: Fri, 24 Oct 2025 16:58:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
        kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org,
        nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm/huge_memory: preserve PG_has_hwpoisoned if a
 folio is split to >0 order
Message-ID: <c09e3282-46aa-4b53-aade-f63324b66d3f@lucifer.local>
References: <20251022033531.389351-1-ziy@nvidia.com>
 <20251022033531.389351-2-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022033531.389351-2-ziy@nvidia.com>
X-ClientProxiedBy: LO2P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: ee227f6f-3930-4e2b-7fdf-08de13162ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nYFwuGMOgHCBKr/TuekU1JbyTCeejVfXHwbPFS6rFXyZVAWeMAlhE0iwwnmg?=
 =?us-ascii?Q?c/1MWnx/UvI6NUEiKoiucLUzejD+fvLW67gWkKDiEBYtSBD2P/PYwByzEaLL?=
 =?us-ascii?Q?KkHO0+Qo8fy7oSQ5QWdPfUfNhACCmcLBVv83RwpTe2vVgucA222/3yOiLYVB?=
 =?us-ascii?Q?URupNxFhluUp0yOguJCoUq7O15jpprrNEGzuXz84xHO/DFtjHg7MTm0xLnu9?=
 =?us-ascii?Q?He7XBXvQp6YMniPZJ1f55LwY3OHgEdSJhSl9x56l222LJHIU+KjHrrWfKap3?=
 =?us-ascii?Q?mg2exQDicBq0QZflDBt6yt1aBOdUS3PdH1ZK4bZcp5/2LLYo2gYG89evEH+U?=
 =?us-ascii?Q?ZeN6usIv1eKFWl59BGhh4DkRhSm7sgWP3cSmLddHOW3KPoXdVnidxP9Yncae?=
 =?us-ascii?Q?FzXwW9CH27PI2dBcOlOlgH+ney6asnCa+IpWRjBGLSeHH+ZGLp36t/lz4kN5?=
 =?us-ascii?Q?o3CafsdQMF0LrC2+c9Ak4avqVQgVddelUyklYpvd5IoSB4o8vaZKD/JlNs3e?=
 =?us-ascii?Q?H7NK9lwyrdN5nhSynQZRQLgkdVtzXmlTZwqePqBuhDLpe+SIpB4qMx75mpsz?=
 =?us-ascii?Q?r2dSWW0hOHX3y/4wKoncW3JtUP+KVfsZRElMTJ5ozqIX6kLaNgbBD5bWSp2j?=
 =?us-ascii?Q?xHmJOJjk+JFTgRO9+/lQW8C1iSdTX16Xfq6RaoYYQ+wxI2/7En/QkFp93W5j?=
 =?us-ascii?Q?8DKd79AJIz8uDtxprtEVtiZXMWXBl6sIrZq6qT2Yh2Sbc+/b8qPpIYtiyCGo?=
 =?us-ascii?Q?hoLl1CZNIGIr0dEQ9hPD33HI9AjGxYkh7zdEI4RcGur+bKwbD+gt/u2aY+wU?=
 =?us-ascii?Q?kTTUjLkBIj9C+/i02/WBeAmqbdFa+5jlR3VS670FFMLuvtga8x2vwvMdj9OX?=
 =?us-ascii?Q?aE2mjmWPX80gQ5lU5UpZCtumzMoqvfqQYHuxtToq1UaeIU8MEv1SZjLFyjxs?=
 =?us-ascii?Q?iJP8+NNz8qlzYR/kq/F7m5SY3mL4VeEKdbyEzbreBStVaPoqm5VOPAjazX9J?=
 =?us-ascii?Q?UgTzF9I/Pz4uavp7mymN2J36s2qMMSHJ5ivnDcN1W1GIGBRYqzUGV9as1EZy?=
 =?us-ascii?Q?/OrSuWRUo+CXWztefmMaYYSOE+fH8WtIfCf+YE7PENIke17fgTMyxp1scquY?=
 =?us-ascii?Q?ul6Skv5hC5MuMyRFZ5wknrtQAOQcQi/lzA1jG+RX7jk1xRGk2aKzhcIW9v1h?=
 =?us-ascii?Q?oGxM2uw6DpLzFag9XKBc0xsjtm0aME6OQkAQHSeQpWvEX9u0X+AITLL9qYiv?=
 =?us-ascii?Q?oQQLhXs7Y6nT+WEDpINdX8aFuRYQb2pSRTQNG0IO4pBW/15ZjKrdslD/0XHs?=
 =?us-ascii?Q?WHYED0v+5dNGN2FKopNZ59bhtmUoVDX9TGK1erTAhsWqXcxZG3ucnUIl4tJR?=
 =?us-ascii?Q?qIBrJgyfYWM1Hp11+PqitncivUVZNszxpHhx9JsLFsIJC7ukriYrAf9FfB3T?=
 =?us-ascii?Q?PMjNFOzcvGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ABnmRC9hhWUl/c0Z8Isfcf+wHT1pL0fa/Y5xPW4+bB7kpkUlcf4pbHuClcdQ?=
 =?us-ascii?Q?GnQ2wCah22ZT/I3/0oRunFJoL0gvcuRG+1uBMJ4MIrpCw4b7lbOPseN0aJO5?=
 =?us-ascii?Q?/c7QNah8yhDB9519srotnhWNXnmivFESRtRxzQpYgzN7nR8lG7ZOk2mbAnzj?=
 =?us-ascii?Q?qEhIrR3EvpW04l96Mcv1JjotA99hPNEKynDxr0EeJu8FPONDR/4H6SWgBeYQ?=
 =?us-ascii?Q?8WB6Ox56GuNPAXMlRVXdBHNEz2mhQuEqYaBZa9eG80mi3cMboxJCxCO7bx+B?=
 =?us-ascii?Q?Ube8RZDkWoZeQ+svHpc21l+lOOpRqj9aYt4H7zg/IIwtAvevl7DFXwqxFFsq?=
 =?us-ascii?Q?NL/k45KzCJXyBhKxfWOXWw8BGCG/l98HMMzO0bcjGSqYMvawSMmN2IpO6Sv3?=
 =?us-ascii?Q?QkmxAHC71kGWSmV9neRkGwUwCpVYw/Pif0jBEZ+Mj27l5KHEls8pFRtISLA6?=
 =?us-ascii?Q?DWiBZrCGJ6AUc+vdYwEAGjwWMJsjjy9s0DZCuJjYvT268QAXKFzOUd9ADqid?=
 =?us-ascii?Q?pPKVvUBNbbEh0zQ1qV04lEUERoPDDGwmwuP4+lA+hHSasbbyq7DEXJv+zAH6?=
 =?us-ascii?Q?GBrleYpLXxISnto+i9/thaW6QRAZ8CFTlzGLJ4n/QqnQVdBJTSdlqdeexvjs?=
 =?us-ascii?Q?LOK9nwmNmfkJb73CnDgy+cTkeLIwVrDMzRc/vIxicXuWHkya9DFcWyT5hi10?=
 =?us-ascii?Q?96Bi61LhBz3v4YYXQl9cCafu0gwSnbMzw9IILpbGjDsEdoovuznmClkKSiWM?=
 =?us-ascii?Q?DLDqKm1c8ybZ5JvfUkOo3A2ivuEfBXR1yXnuugUJd7G7ri2V6vsQzxVUeWEY?=
 =?us-ascii?Q?XphReau6+RRZp802QSHCd3Qfq40MkDAM6h5z7UPzyyC3jQfa/m+bvNOfg4tp?=
 =?us-ascii?Q?6ubnP9I7YIBunFPVyxJaIio4It/LSdQFd7KeVKXB58PzOX4QZoZ5vgYLaU0U?=
 =?us-ascii?Q?eITZbFiYdZ/J6MkireIxzSueRdTBRPVh2Ues48kdLnp4y0EOCzBfNcSO0xsq?=
 =?us-ascii?Q?mKBZxk+G2lhsDz9gn9VEC1JaLTj/SKRuZm9nIIZOeJvfap95VaCaaHoXrSKh?=
 =?us-ascii?Q?yGEFS0jUdSqgmjUPQ9eQt2Q9IedFE5RmZ7mRbwXd52MBYFmEaXdRELDYDAD7?=
 =?us-ascii?Q?d94aHE4lKHpak+4eYlo+29bRoC30KDYIIBc4aNet77UADN6BPzGkOwNXiwid?=
 =?us-ascii?Q?R/JJg1GYTUh3Ew/KmRWt7z8SW6l6wiZpj5QVUC44nhoZQfRaS8NH4ald4wOn?=
 =?us-ascii?Q?DqKiOpJJl0xsvE6lia9cZ7wy9trWqChZQ18OgutYy9J7Disoo6MuTxjaHB2M?=
 =?us-ascii?Q?wj63MTMF4+KJwFrjocvhvznxV/RxU3n/4C6NEwfJI2rYnoX66fQZCNTlvxxg?=
 =?us-ascii?Q?ke3fOLDFNvKQp2jM65Vi/it2UvgLJnk7eAfHZrAExRlTTgItk1QqHq4nrP56?=
 =?us-ascii?Q?4bG65EBCVenmId+5bnjBRVeVIg/DsHE645nUrLZIm6W02uSfzJ2UCmbtA7wU?=
 =?us-ascii?Q?5BIYulAZw1192U32wV8mAGLFfQ51ptemOzAvgVlrULX35yM+3AXLJldDgwId?=
 =?us-ascii?Q?osnpQfySlfivcY+T7N8N0apFo5HRE76FFusTKO1T5jvZYJqxgfzt0zmRiLOu?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lXfqxLvMrJZhy0+NPWz2gr9LJjTdaltUpYmB7v0WTcEgC834PTuRcBiQI7e3XgCw2zsgIEETkJ0k43oBfJ/KTlH3ZIDGO/zYIpF3LUzQjRkMYRDRk0aylPXH0jMhd7d8M+IKSNUI+j5msHIyVtDIMHews6FiQ7I4+A0hze7Ykeox4ekNdVXLMrDo9OczKQbZIBKBRV1Br1J/ImP0ePPJfrtjja4m/hYtYG1RlONNqmAcPC4NiQpJheUqMd/zxXmMnxyQ+Q7tfYht0EGxfllotjFrgHvOi1qA/sgC6uoZbRANJlQiLvCiqg8qRE8GNQgd4qOYSSNFuv2qpI92e+4OUXdKmrrFR33NIyNh+HT3a2LcdqDHsf0oQQ4rE/APqy9AJtCypf+kRrjpo32JuE5qzoURvmi4rgmPzhhywPrjBondFbHpPCpheBRgPqhsneRoESkDgoPBf1wnJ/Lo3lcMcX4seuaUcSRrmIFQ4v+0IV9hoPJ7d0pxEmR55Fdh1mBNn6HIMjnS+1qKZkDpw06fVArkF8dLC+Q0MgY/2FLStZVfphKcytrAmGuBKvzDn4CLIItex8osxlQJMOxDHIo0uJbJNrksU+vTVulHd85Pj6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee227f6f-3930-4e2b-7fdf-08de13162ab0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 15:58:26.0328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83c6W1+i7pXQ2xhOFeTz77nUDbl1iAczy+dA39tG3FE6tSt8pgeGJ2K5FG5JoJPYo3FgFwpOZrFi66HNxcoYxMAFEnxt5IKwu99Wq84avm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzX3P+b6815md
 dE6tX0NJzoGQ/VhJVinLm79xIf6YWctQ75EA9Falghk7zKB6WC2BHMWqeY3vvBt+5NEV0Mwe1e+
 y4ophvS2D4ng0BDg4oHkQDY94tOV7rMaUcfrRNtjiaZDsHR0XoLbNbNtLfEr+0dpkTg/PPocHzk
 OShyKcQshP9EthKCrnf3cKMSldyUjuwLzMWgcTT2/GruUtqUMYqP+yk36iXMpzz3Wnqi8xGbqFY
 6YL7KIQaHIikHHZz7PM6VR+AdzDikzW0YoOWOmj6d1dRibJ59MSJMr7+LdtrriZ4hRrQuy3AsnK
 c6lsO2lrEAoxHyAqo+mO8hW5LT9g0hSZUF7Nvmnwc8WKnLzccbQ2mtBvuXm+7uUxiOwiTK9Srpf
 b8fLA0k79Y75vpU75V7bDzFYQSfGrV5EdS+/8yQ2T4XJLnU8nCw=
X-Proofpoint-ORIG-GUID: e07Ik1tvqFKu_q4OurL9FCBN337_QiAW
X-Proofpoint-GUID: e07Ik1tvqFKu_q4OurL9FCBN337_QiAW
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68fba22d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Ikd4Dj_1AAAA:8 a=IK7mdeaTXkNQ-_-jprUA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12091

On Tue, Oct 21, 2025 at 11:35:27PM -0400, Zi Yan wrote:
> folio split clears PG_has_hwpoisoned, but the flag should be preserved in
> after-split folios containing pages with PG_hwpoisoned flag if the folio is
> split to >0 order folios. Scan all pages in a to-be-split folio to
> determine which after-split folios need the flag.
>
> An alternatives is to change PG_has_hwpoisoned to PG_maybe_hwpoisoned to
> avoid the scan and set it on all after-split folios, but resulting false
> positive has undesirable negative impact. To remove false positive, caller
> of folio_test_has_hwpoisoned() and folio_contain_hwpoisoned_page() needs to
> do the scan. That might be causing a hassle for current and future callers
> and more costly than doing the scan in the split code. More details are
> discussed in [1].
>
> It is OK that current implementation does not do this, because memory
> failure code always tries to split to order-0 folios and if a folio cannot
> be split to order-0, memory failure code either gives warnings or the split
> is not performed.
>
> Link: https://lore.kernel.org/all/CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com/ [1]
> Signed-off-by: Zi Yan <ziy@nvidia.com>

I guess this was split out to [0]? :)

[0]: https://lore.kernel.org/linux-mm/44310717-347c-4ede-ad31-c6d375a449b9@linux.dev/

> ---
>  mm/huge_memory.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fc65ec3393d2..f3896c1f130f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3455,6 +3455,17 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>  					caller_pins;
>  }
>
> +static bool page_range_has_hwpoisoned(struct page *first_page, long nr_pages)
> +{
> +	long i;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		if (PageHWPoison(first_page + i))
> +			return true;
> +
> +	return false;
> +}
> +
>  /*
>   * It splits @folio into @new_order folios and copies the @folio metadata to
>   * all the resulting folios.
> @@ -3462,22 +3473,32 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
>  static void __split_folio_to_order(struct folio *folio, int old_order,
>  		int new_order)
>  {
> +	/* Scan poisoned pages when split a poisoned folio to large folios */
> +	bool check_poisoned_pages = folio_test_has_hwpoisoned(folio) &&
> +				    new_order != 0;
>  	long new_nr_pages = 1 << new_order;
>  	long nr_pages = 1 << old_order;
>  	long i;
>
> +	folio_clear_has_hwpoisoned(folio);
> +
> +	/* Check first new_nr_pages since the loop below skips them */
> +	if (check_poisoned_pages &&
> +	    page_range_has_hwpoisoned(folio_page(folio, 0), new_nr_pages))
> +		folio_set_has_hwpoisoned(folio);
>  	/*
>  	 * Skip the first new_nr_pages, since the new folio from them have all
>  	 * the flags from the original folio.
>  	 */
>  	for (i = new_nr_pages; i < nr_pages; i += new_nr_pages) {
>  		struct page *new_head = &folio->page + i;
> -
>  		/*
>  		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
>  		 * Don't pass it around before clear_compound_head().
>  		 */
>  		struct folio *new_folio = (struct folio *)new_head;
> +		bool poisoned_new_folio = check_poisoned_pages &&
> +			page_range_has_hwpoisoned(new_head, new_nr_pages);
>
>  		VM_BUG_ON_PAGE(atomic_read(&new_folio->_mapcount) != -1, new_head);
>
> @@ -3514,6 +3535,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  				 (1L << PG_dirty) |
>  				 LRU_GEN_MASK | LRU_REFS_MASK));
>
> +		if (poisoned_new_folio)
> +			folio_set_has_hwpoisoned(new_folio);
> +
>  		new_folio->mapping = folio->mapping;
>  		new_folio->index = folio->index + i;
>
> @@ -3600,8 +3624,6 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  	int start_order = uniform_split ? new_order : old_order - 1;
>  	int split_order;
>
> -	folio_clear_has_hwpoisoned(folio);
> -
>  	/*
>  	 * split to new_order one order at a time. For uniform split,
>  	 * folio is split to new_order directly.
> --
> 2.51.0
>

