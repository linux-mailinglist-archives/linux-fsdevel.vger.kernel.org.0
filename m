Return-Path: <linux-fsdevel+bounces-44289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17022A66D97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646BC189357A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593E41F099B;
	Tue, 18 Mar 2025 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W1kCK/l2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n0Y98sLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A61E5211;
	Tue, 18 Mar 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285484; cv=fail; b=TKiBHtuW7p/gJIAfM+vAHRB1T8UTqShpxHnrMXVkwAQO0YE7s0cORIyBDdm55BEM3OmBwMGudGhPqnqbn3pGcvUNMWg0274l1oyWqUrdpQqeReRDa22bnk5MR4d7QBG7h+BsGnKNwG7ccK3AoLKLTg5F2U1Da3lotiXSt/pe+mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285484; c=relaxed/simple;
	bh=yBMXJ0wlxRM6EUEUTqY0tQ+0IGV+i7IoPjnElewKeQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=maYd1yjTRFkVmvxkfmSOPsqQ1N7vs8Sy5agQrVgza46OqYbmvUAV7Cz4c/xzz9zpkJ7TEnCU3UzdCDzwoHYp/X7p+yg1GUJD6cdp7idf68pdi/1hA+e6oZgNxXPaOkTJw+M8eIa3EvIiw9RarwwazytgwqXkuezTaxmIGZczObI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W1kCK/l2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n0Y98sLy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7tov0031297;
	Tue, 18 Mar 2025 08:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=YpmJr2ZlxxCd67xeQ4MGioG2w8mAr+iD9mJXdA1LYu4=; b=
	W1kCK/l2ggLSInbV8wXHn5avqseNzQ7decS0rn3JaI+3Y9DZa1Defl67vWnWC5x4
	L+cRJfYcD7DHmyzMXb4n66xCTMO9nMzKU7lhvdE/x83RFguTsWzmsik/l4+cViS4
	Ynaowl3bGmJKdvkUmdpl36jgRV//OBWkq9fVv84vzuzCRQGX6/IPBA1g6mJuldbE
	uaqTuRzqX03ls5Elflqc+OWFVhfLpxQSjLtwHk1ej5ICwL/DClj2eZt9sP2sY79B
	b5aEWRCC288Qf0vtIMp4ywcwy9ofo0+9fyJh2wI/4XdmMK92MPjnZOykgVKVEzIc
	H9ybC/hDMYUrHIsM9S7Fdw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8chnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:11:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52I80tYi009485;
	Tue, 18 Mar 2025 08:11:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxky9jdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh65pGWsUgMxA9RsInX/xgwz5HjP3Xj/Mps0OyADUGujHTJ6OZze0XREWyZCCY/BBxfPawGiKtXafg8TYCl+QHbCc5krpi8fiiZLQqTJ22JglugfIw5tv3WYkxhSy3w1utt/fgX5LDclEJ5bbgaAPffNFIwigELfIhXLv2Wowk2EPrQSz/9z8gK8h2xkNYfXf5VwFniDPAtYBhNv7vYHrVb+Hx9/FmAbPQC2jnaBPH/VWiS/4zL5Q1tQoFlr76nOh3HnLitvsndOmzM9csuC43j00wzfBDe5pm7bWFXA4jKrQEpyFwtTziMIWRz/vFnk0/zQWg+JQT6Rwqj+ayv6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpmJr2ZlxxCd67xeQ4MGioG2w8mAr+iD9mJXdA1LYu4=;
 b=UbSfOxNNB4YKTkhSEo7765g9pLoL6Lq916TbeVu/GZRtA9/cSIgcJvJahcpggd19JtxT4i7iT/UDKv0TB2otOoxE5Ft9SBVv/vvW83YL3fYC3C7ql+GL7UHn6WfVTAEGEv0YglX3hBg/P2ahWyljZoBol6beJJyM/JZvE0Ilx418NAORIVRX2qIp5k29KuQMPVZAnRa0uk5+gZ9QSfPGwj5X10IO5N+I8fNKUpnnzaMqr+bEkCSfu2cnc8ovgSKB1CvznBLN4JdQ+WyttSwA8c0muB0rMoraDiz12G9LzkUHANMiGnlJzNDtlq1JYvJ9sbqj/rP09y2zSUcsTG/tNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpmJr2ZlxxCd67xeQ4MGioG2w8mAr+iD9mJXdA1LYu4=;
 b=n0Y98sLyIP6t1wzbUBdGw+mxkW31ohYqj1GM8bHSIWIN06Xm3YEs5oSp/8Ft7pQIkXdgMt23WfODM0rXLGZs18tGjv8kuvAbi6iX6thTLsAETkUzUc/3fprZCeGjGlTxyD2oKs8TlHZYqky80y7b47rbsJ5EA68u5l+uEfYY+/8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7799.namprd10.prod.outlook.com (2603:10b6:408:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:11:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:11:01 +0000
Message-ID: <3c412fcd-12eb-4f91-9c18-5c3373c87573@oracle.com>
Date: Tue, 18 Mar 2025 08:11:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/13] iomap: rework IOMAP atomic flags
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-4-john.g.garry@oracle.com>
 <20250317061116.GC27019@lst.de>
 <87cf27a2-6bbb-4073-b150-c4d07e382032@oracle.com>
 <20250318053214.GA14470@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250318053214.GA14470@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0373.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ab6495-d57c-4f7e-c0d5-08dd65f46c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0JtZDRNZUU3UURMR3FJM3UwWjRGakpHTm9hTTRVc3VOcms3ckprSUhOUFVs?=
 =?utf-8?B?cGlTTWZjWUowNHJxaGFmL0tLY1BXR01uNEpGUWRFNHRiRVpVbXYveWM0Zm5O?=
 =?utf-8?B?M2ZGMEh3MDhBUjVjQmtVY1lFUDA2TkY0WTBmbVF3RzIyNE9ySHE4Nk03eFJD?=
 =?utf-8?B?WG1POHo4eTlCS1MycXA0WXIwKzBkTDFhd3QzN09PekM2dnJWYjR1d3NzNXZ0?=
 =?utf-8?B?MzlZLzRLYVdsRmU0VGYzS291NFpQNUJuL3N4WjJNNUJ6azAxcTJBdGhobWdr?=
 =?utf-8?B?S3YwVTdJRmNIYnd4YkNJODUyenRkWDduVkllN3FkdStLanlqNExHbEhEK05O?=
 =?utf-8?B?UCsxQUEyVFV3TEJnN1JxWm44UFFEQ1UxRW43TFFmVkIxbE9OeXRMeFJyS2Z4?=
 =?utf-8?B?dkxlVnI3cGhWMTdZZ0RRbmxHRkVjbmh3TUpvM1h6ZFhqeWVEYUZ1a1FrZmUr?=
 =?utf-8?B?eXZROE9ySlJ5Wk9nNlZRbmRyVllVRXUyUk1xaXhmQnBRTnNMWEhZNnNmb2o3?=
 =?utf-8?B?eFFOM3hCQ1M1MXI2Y2hsbVJZUUxKRGVickwwaERpUi9xR1VRMlZJbERrbGRK?=
 =?utf-8?B?TDl1YkJlUkg5YW9mbGpPRTBDK3hhbmtPTnVWandhZEY1V3ZucVI2QkFid1RC?=
 =?utf-8?B?R095Y2NxWkhoT1VHeGhac2s0eDZGQWpHMkdnZ2pUSThMUTUvZGtvZlZScHhj?=
 =?utf-8?B?eDhqU1ROTWhEbEVDdjlhYW8vN2ZtL1FaL2FvNWxIWEdTU0lENHlkQzNIc1JZ?=
 =?utf-8?B?SVI0SThxQXJ0amNDTnc3RGZDaTUvd3dJeis0K1p4Z1didTVTbStVY0hmTDRh?=
 =?utf-8?B?MHFUZ1VyczhBc2IwaG9ZdlQrN2tEM0FqbHd1ak5odWhKakxBelJCeENYNW5O?=
 =?utf-8?B?QmxHd1NFZGZ0Z0JjSXU2c3p3NkIzdHJMVGlBc1RnbjAxZEZaWEg2L1E5clFv?=
 =?utf-8?B?aVV3aXRSOXp3UlYzdk1ySitlOCtWZ2lCcW95OFFPdWthL2dNSWJsWitWWEdL?=
 =?utf-8?B?SGlRdkpkaUJHMVdUZExhOHdQQ0F0ZTFaNEhSVURjd0FCSHlKVXdDa1NvZFRC?=
 =?utf-8?B?VDhoUjhLOTB4NU9YSlhXMG80UFFJNWVmOWU2RlZQQ0xPTHFEVElGSzJOMk5a?=
 =?utf-8?B?WlRKQjJyTmFEL3k3NGVnZDczeWMwOGFXN3JYWVgxR3lnOFR5YmdnNUFrS01q?=
 =?utf-8?B?Vk1oQ1NjbS93dDRKeEF2dktJMlhiUHhXOFJLZmVCRWo2Z2ZHcDZIQ0VDVk9O?=
 =?utf-8?B?cVlHUzRFalpCY2RhcjBxR2QxM01BODExYzlJcmFSR1FCbXZvOXB2VG9OQy9w?=
 =?utf-8?B?LzdiNHphMFdGM054c2lQNGxuZ1R1aC9LejdPbEVmNE50VXVSVkUrYmlEaEgy?=
 =?utf-8?B?MVRPY2VHdWJ1QTNuV0V6d25yQlkyRUtqYzU2bFhBWTNoYmozWmFsV3pwaVVP?=
 =?utf-8?B?Z1RKZ3dUVVpub3V5aUpOdURnNDlHUDdJbHlqN20vYXYvUnJBbW5MbVdnS0U3?=
 =?utf-8?B?eGR0a0tJUDc5c01EdWRtZ3dkalhxaERORlZ3eVFQSnBRYndmRWNuTXRwMzgx?=
 =?utf-8?B?NFhxelkySEs2cEJqZkd2ZlJlbGVSVWx6S3pFUk9leE93dWdUZitvS2VpTENI?=
 =?utf-8?B?N0p3b29oeHBNM3dYaEQ5dm0zb3hQcGo1NkRlVlZsdGZlaEFRZFFNcFZpV3hK?=
 =?utf-8?B?K0FvK2ZhaXFxcFpac25BSXVPd1gyMEV4WFJtS2x6MEJUZW9aSzNMVjhQMkNC?=
 =?utf-8?B?V0RlcS8yODF3U1NGVUNVOVMvdy9xdlptczBhK2lTVkQ5cm1xOGdyZ3RnNTVv?=
 =?utf-8?B?Tjc4V1lmMjBNTmFlTGlFejQrc2RHMU9vSW8weXcwalZ2SWE3VnJkTXRYZVBn?=
 =?utf-8?Q?Dyn8+uycyoMY0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXV0eGVKUG0rd3ozZU4xc2dzbTVuM080NzlsdkZwS1lUL0lUeFNiWUhVd1A2?=
 =?utf-8?B?ZkxLZndPb0hJM2NROVlyeUQwQmtqK0UvTU5WYzdIMGZKdTByRUg4YXR2SDRU?=
 =?utf-8?B?S0luVy9wSnVMTnZZMDhMbTFURnpKMjJERnEzQlB3V1JLUmlJM05qVlkvdCtn?=
 =?utf-8?B?NytyeEloK2xCV2Q5WGRpeTMxK0NoUi9IWHBjVVVrUVVuZ0ErYXVTQXBIRUdx?=
 =?utf-8?B?MHBBYUx2SjRIdHIzWnlrYTNWK1lQVmVZRjVoU0loamp1bCtBclhrRHpkdlpL?=
 =?utf-8?B?QWd6bDQwbUM5Sm5CUy9UZ3JiemZ6RTdFNXdpN2VCTHVZa045YmEvQ3E2b2dF?=
 =?utf-8?B?RGZScW12QnQwc21sMUJSMjJ3RkpkQU9CdHFnZE1WeEtYZHRRcExpWlFJbFYv?=
 =?utf-8?B?UjZuTkZoTktTcmgyeVRRWEtkUnFtVmRuaHltbGhXUWlsZEFmTVVtUi81UHhC?=
 =?utf-8?B?ZUp1aUlUTHlSVDJSVHc3cTdtN0RROWU1QWJSTjZuVitaZDI0cEYyU1lvYnlJ?=
 =?utf-8?B?NUlGalJZNzBmN2VMK0hhZ3h5SVlHSGJyc3ZuNDZHQVlwK1F6M294eFpaUmpY?=
 =?utf-8?B?bWZpTnhIL0E5SGV1RTdKMFlZVVFhaWhaVWF5c3lWTVZNYjA4QmJzTmkrMm92?=
 =?utf-8?B?SHkyYjFZbWwwTWxLeXpOR3NkL1ZydmNmWVhycWZwcHkxa1hQTlBOS2lzNThp?=
 =?utf-8?B?OUFKRkYybVhVc1hXbGJkdzdYTE1JT0RXdDdaTXlaeGhGekNTOFkweVVzeDVU?=
 =?utf-8?B?L0gyZW94UXdmQTMzdnB6d1FHVlk4SjI1QkZtbUxrclo3N2lIL3MvME54UFRj?=
 =?utf-8?B?N2xYOXVTMFJhOGtjbVpwSTRCTjNqWGVOTWlrOVBVQWNXdnprNGtVMkdLMUhR?=
 =?utf-8?B?azFWNlhiZ2hQOTVqaFNmenJFZHNoT0RxaHNuQmNVUGNiVWJyaWtqTWxTNDVh?=
 =?utf-8?B?OE95MWRGNUFtenJqT0JramhLVzZ3TldyNmthWkwxMXcyRXp6WVo5SWhBU1k0?=
 =?utf-8?B?Tzkvamg4cnEwQm9XaysvZmJabmViZEZPRjZ6QWlXYzJLWWVQTkdFTnRaMmFG?=
 =?utf-8?B?bEJLWmd2em5QVmZvTnRFcGNEUHV3Z05Pd3IrOGswVEdkMnBTc2xzQk0vYmpD?=
 =?utf-8?B?OGV3K2JIYlFzZjFMbDNKeWplUkkrMUVNZlAxQk5KVWh5dnAvb1RXeFZKTVZ3?=
 =?utf-8?B?MGx5TmtFdW9FME9CZ21odVRLUDJHeXJVWVpZQ1Y4SXJsRXdsRndhQy9odDM2?=
 =?utf-8?B?N3BQOEkrbUNFbTNweWx2RVN1ZmtlSnl4SnN3SjBZT3VjWkVQamhjOE9CSDZq?=
 =?utf-8?B?dGtONE0zaHFPcGxkVzRMZHZNUGxFYjhtaEVPeHF5MnYySEFWd0FTMTBzcmI2?=
 =?utf-8?B?UVFUOWdBdUN5eDBuckxoKzFtRHo5RWVzeDMyY1JuRkpkQ1NpVmU5S0I1YjdF?=
 =?utf-8?B?UmMxMjJmcW5ZMDlmUm00Vld5TlYvcnQ4OUZrNmVIZHJpTDEwQ0Z3NjE1QjIx?=
 =?utf-8?B?SUdtVXVQQngwdTF0MFBDSENzV3VzSkVXV3luNis4MGZsQUFJMTA3TndlTmV1?=
 =?utf-8?B?ejZEWTJnQlNXL2pmYmVleXF1bThyTkh0aVlwNHhPeHZ4WFlFR2pOQUJXRWhu?=
 =?utf-8?B?RFZmV1AzQ1pxL09CREdKbUF3MzBsWVVUVTRVRW5OUXZ6Vjl6UXlKK2wySmJC?=
 =?utf-8?B?dlBuYUh6SGdhZ2VoNitjTEdsQWwzazRabE5FUk9VbHZkeGQrbjhvRXJobDZl?=
 =?utf-8?B?NGpLRmVXMGorQXFlVDI4cHJTa3ZZZ1lVRGorUm1GQlpYREtiM0RUeE1vQ2o1?=
 =?utf-8?B?R05PcVIzb1RMcTY4cHBlU2diVUVuWFRvZXRSVDlyK1ZJTDk5UEFsZjlaa0ZC?=
 =?utf-8?B?RzFmRmhSRmdMSTlqK1dibEpSY1hWUkp4NlJZZ25VU3duMFcxeDZLVmZHVWIz?=
 =?utf-8?B?elAvWUN2cmdZSzBSVVlSNU5jTUZjRkMyL0RCTFRqaSsrQTdYWFVIc0lIRXR1?=
 =?utf-8?B?OENTWFlCeVRIM083a1VXdWQrQnBDT1ZRTGdmV0RMQlFSYkFyUWpTcVRjK1hN?=
 =?utf-8?B?LzF2WDh2aWI0WGxxTlR4RUg1YTNTWkZ3M2VnNG1NTTBjVmtlM0R3dXFnajlt?=
 =?utf-8?B?QUJHRmNxeTQyVXYrOE93QWwrcE1xSEFxVFBaY3VHcS9LZkMxcDI1azZCdkFw?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bdxs93Py8Blatlv6/XkSEbjPWWcjC7aUL0+NUXa+rKJbiS7dOf//OeEmdS7Pg6gmpwsSX98aWcSHmMzfDeqniIDn6raMI6X6SOHW+Rzye7ovqawE7syh+npoFS8n9fp/kvfzscX+QrUgZWN9bdwsW/X2o1C7HNP8fvPyOkyFm0oLEby4SABYzbhmDUkThsirtb1xu5QweVrMJ5gw2WvQg0E26ktSjQG7A3Yf3HvQ04/+lMCrQanMFdMuW8UU6GKJzgeVkB/o0NEU1SJnytazFFvysSG6IfeLoWNkDc+IFo4zMDMhbEsL2MsvwhWwNap3MwT86/R/awVTL/oCFWJLY0Dpi0gGrtLvCRTeqovP0seerw8KPbMMdgtkAK31+vua/AihgLoimNFenTB/lNgKhZBd1kG5a5So3rGn9hRlb0mkwsp4xfFHY863qtPtCZKNawGX8v4bzvDeJ8XFP/hnucAOZisc13KkWaq9D8r/S+YlCo9GbvBHG1uwpnBGdQ4AbL100LLwc9qzBk6C94dyYL6IoOSYF4lwgkol1g8e2TB/iCsjc7HD8gUVSO18vGG80T5a1b0cJhPoKTPBY/l8sPM2pDxjuH+qWT/SgpTigj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ab6495-d57c-4f7e-c0d5-08dd65f46c08
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:11:01.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fvML0QMBFDG37oH8xvdxtVIQneVB6p8vIh1BpuPkbXlJjoyXtWiJ+1hMQEUk26urIkmzmjlXWBANxhRfxgbkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=900
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180057
X-Proofpoint-ORIG-GUID: Da0DbkF19nW0mUHnz_Y06sx7K4_udz0E
X-Proofpoint-GUID: Da0DbkF19nW0mUHnz_Y06sx7K4_udz0E

On 18/03/2025 05:32, Christoph Hellwig wrote:
> On Mon, Mar 17, 2025 at 09:05:39AM +0000, John Garry wrote:
>>> Same here (at least for now until it is changed later).
>> Please note that Christian plans on sending the earlier iomap changes
>> related to this work for 6.15. Those changes are also in the xfs queue. We
>> are kinda reverting those changes here, so I think that it would still make
>> sense for the iomap changes in this series to make 6.15
>>
>> The xfs changes in this series are unlikely to make 6.15
>>
>> As such, if we say that ext4 always uses hardware atomics, then we should
>> mention that xfs does also (until it doesn't).
> That's what I meant.

ok

> 
>> So, in the end, I'd rather not add those comments at all - ok?
> If I read through this code it would be kinda nice to figure out why
> we're instructing the iomap code to do it.  If you look at
> xfs_direct_write_iomap_begin it also generally comments on why we
> set specific flags.

understood

