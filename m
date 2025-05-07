Return-Path: <linux-fsdevel+bounces-48394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3F3AAE44C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 17:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05173521D09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7105B28AB0E;
	Wed,  7 May 2025 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lnttX7on";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QXqEnLoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A128A729;
	Wed,  7 May 2025 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630918; cv=fail; b=FB0S6lzkJXBekgIxhbF5rPJV2f1ZqthmTpv8vV3rXO5dNGILZItOSge8/iX8dDmaURFTSH7yR6W0yoZQFJiBsMfixoIl5aMfSJfcFxbB/JtEM1pUOYQNE6tDfHlBI/9ZOwMnyAMr1T5NVmc/sCbTh8YqQBKPjWFRHi0MZPlEPVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630918; c=relaxed/simple;
	bh=JzUYi+4Z7tyfR6RVCfYVGQkZae4fBGvMZel2d4MZQ4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XIn5ItXa0lXqromf+UiKU1eW8+NuuUWoZTr4BtKGcV7ZedPTUyPNsGfssUXGvR44HhHqtM24w5DtKUwHx+obBBJ43BS1Adb56aeLPwPVvx9SZdl1/skYgSZHn6o6biGHCuLGZm5oCdR3OB9vC8B8mlcJjvG4KLXYJK32elhGB1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lnttX7on; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QXqEnLoU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547F2iAo008776;
	Wed, 7 May 2025 15:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V4XYxJacSv43BAD0bHk7AOs8Bjm1bS1bpInR9RFwjlw=; b=
	lnttX7onrg/rnj17tsmGUyr5ZXhCm6YfCL7WFKkHwXY2n4fs0/uzg1QsVtIalUZ7
	sJ5kp7bqcPITOkiWkw/POa1pxx0jt0Xd69d8jAZnA/mqe58nVACp9zs5E2lk5I0j
	RVRY9atlCU0wUrPFJ0S6dhKoYsca5Bv3SoXCUyq28UanGe0IcLJTOWUrHJLNKFCl
	OmrKE3TOeMtMJAv8S2Qo5vYm60TdxIFb8FN5GbYCee6Lg/2jIV/lJMRXsuk5NMe1
	hDcECOb+KWeSzoW5eMbGRM67mRB5jChWEOqpHvuV7h6oYE7r/LgeDfNLGK++ZkBU
	qe6zupGcbxQkgX1DR6SIlw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g9t7r1d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 15:15:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547E3AU8007326;
	Wed, 7 May 2025 15:15:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46fms94jyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 15:15:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYMGIvCeaVaBcy2T98scdoEJtxhxzrUs2dqZ29pPfceUzkUEQ1lgvn8zr4fbCSwDBCvFJa18VHhvY4hOed/LT6mReiLeRS9J1lPbP/kL3WCv/n4TCO9tCScFnw42g2v0wdc9+g3XC+t/NvWjWfvBE1FD8wS4GfBSMHuJZE2p+RHMrC2lzGk4DSJVqZUvbwoL9CIAeK1a0ErQrmQ52AV0beqBh+Ge+41AdwegPTqkz0QlnH2Q9mfSdgfUaBeDj1N6P/odr++TKtFut9NJ4TDLq6I1lFOFBIUJrckH6RGOP61I1hji4HTpij/WC2Wtyh8VF2LrT/i2Bpd/p5dHO3JPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4XYxJacSv43BAD0bHk7AOs8Bjm1bS1bpInR9RFwjlw=;
 b=L/W9xiicPZvgwmkTeINpdJxBV20ZK1wVody41Wjq4R622b3F6aIJXYJLyK5fIT211xYsPfQT1ImdAYJzI7OI5dnde/YnghyHhZiD54/Czju41e47oZiNX3B2WiINB314hQJH30mve6qN51+FkRJxM7ucIw/GZ5+dmWdoqU3VTs3UGilj4RYQReeBi2N8+QRStz1/E4tMxPMew5lq7/myPJbVXsiKk3wNXCXqiboo6PpiGuWYu691l54757/I4SiZ9osKcc2gquBe2+hjdmuy+VD/2V78i7FTuyugo3R3D6RhXYCjLQI51rT5gPg7TIv5nNS/J2njCBSFcYhfguY1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4XYxJacSv43BAD0bHk7AOs8Bjm1bS1bpInR9RFwjlw=;
 b=QXqEnLoULsEV33V1pfBDjaEgUM5dF8VQ6b7BL+E7TX4eLLUNMdIRnhplBeHIPld10WYefKHmgHMfATuxrxjQCXj7JnTw88HwXALssBxcHqS9bxAISWhJC93BLM26ZRL/siJIe/Mhs/U2lSL800SECQhAD9pd78cICa0rq4z4+yQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8066.namprd10.prod.outlook.com (2603:10b6:208:50b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 15:14:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:14:56 +0000
Message-ID: <ef7cec58-9347-46ac-9e1e-e49125940596@oracle.com>
Date: Wed, 7 May 2025 16:14:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/17] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
 <20250506090427.2549456-18-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250506090427.2549456-18-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bed6cb-76ad-4475-e4ff-08dd8d79ec80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHRRK3R4OHptNzhWR0JtZ0hONzM0SWplNitPbGpCSVhieWJHc1g0WndaMjdU?=
 =?utf-8?B?am1VeHRNMW5LN0MyZ3FrSEcya2haenRLSFNiU0QrS3RBU0lBek5FMWN2aTBU?=
 =?utf-8?B?NlhGNWJhMDFpU3J2Y2YvbFRMSnRxOUpFZUM3bFZoK2tiWGlkM1lHSVQ1U3V0?=
 =?utf-8?B?RXIvb0I0TXA1bGwxRElSNVQrbXpKVWFBUkZGVkZCa3B4eFdiVFpqcXhrZVhv?=
 =?utf-8?B?TXd6RVo0SkhTQSszMTBpbkx2L3FvcGFJVmlLZHlCMEtIMXlTNnd5MktNRExY?=
 =?utf-8?B?Y3VLK011akxvUjlCcnFjdDdCT3AwU25CS1ZxZkp6N1ZIWDFQa2t2SzBaZkRG?=
 =?utf-8?B?NXA0VWc1ZU5ZTEQyZWJ2VkJuUUFVYjlZUTNCZUtVa3BzVElodEphdFc3VTU1?=
 =?utf-8?B?bG9mOUoyNXIzOWNJdXlsU1Q3R2hacXZhclpqc1luTmt4ZnQrUGFiVUdCWE9a?=
 =?utf-8?B?aEpGRFFxaFNFNld0d09xUlVXbVpNeG5uc1lNZkFGTHJyUk9GRzVhaDFYdDIw?=
 =?utf-8?B?bU83VjFqVkNPSys1MGY1SHU4K3gya1FjU2NlbUlsM2E3NmtlQTJmdUtOTzVC?=
 =?utf-8?B?U2xhcXh3WUhGbGExUnhyaEUxcmpDdVdhbFArY0xraGtjcUg1bllQMk5UNFhM?=
 =?utf-8?B?VXV2SWh4MHpIN2FibThjQTBsU1N2UEtPWmdNYmtPc3pNcm55OXdzZGxCK1dP?=
 =?utf-8?B?aDZqTmE4bEZqd0g1TWRHaE1SSGRVQ1NYdzJLaTVOUElqVnpLbGQ3ZUg2bmNJ?=
 =?utf-8?B?VE9hQVpsdkhUS1FqR2IyUXY4VUt2WWdiUCtUU1FtTEU0WjhaTG8yaktSL3Bo?=
 =?utf-8?B?QmlIY2FvVUFjRWFGd2RIWUlUaDZxM016OExySU5hNVpEdkF6VTlteHc0a0xC?=
 =?utf-8?B?MFQ0WTZDb2IzdXdUNlYzK0lycmNERkZMNGR0bmkvZ1Vab2JUWHUxUlRjdWF0?=
 =?utf-8?B?V0JJZnFRSEx4U2tPSFBYeTJ4NWlRQ010MjFiSzRCVXYxNzVuWmp5Z1lSOXpn?=
 =?utf-8?B?SElyaE9sWFE5MGNKQzA4RUhaR3dTZDdsQTAxeTJjQWlXdXk0dXo2SURaYnkw?=
 =?utf-8?B?ZENuQVdEQTJ2dE9lRVgzbXFxOWUzNXBkRVAxdTk3UTgwWXgyZTYzdkd5K0ZY?=
 =?utf-8?B?WDduV0hXdjcySEk1MHJWZHBMalFwZkxYVy9ySEVNYTBuOWZPcld1MktTbE1D?=
 =?utf-8?B?UDVDY25Cb05tbjNYeStJdTE5OE9nNlduWWF6b1BydGdJNUN4L2c2bEFpdlpY?=
 =?utf-8?B?MlU0aVNPWERSZUh3Y0QzMlRzN1l4ZXJTZjR1S08vRXZDVnNiYnMrRVZEeWFK?=
 =?utf-8?B?N1FVYjQvOUhSLzE3UmNXMGpuKzhVZks2UDhGY0JjYWxEWXFUeDVpNXg5YlRG?=
 =?utf-8?B?eWxPT1NQNTBSbXFyajhaNGNGMlJKU0ZlWVFHVE9QZW1HNTNrdENHQTBoSWFL?=
 =?utf-8?B?T3EvY3JFNE5XWGpNOElWeUpKdFZPczVnclQrN3dJUEswcFIvVjBGOUd6ck94?=
 =?utf-8?B?OU93ZG5UY1pjZ2d3SHVDSzJPMTNPZldVSll2WVJjbFd4YzVITmJ4cVZ2NXAz?=
 =?utf-8?B?K2U2RmZob1dmVjhqd3o4ak9BTVhWS1MzL3ZXZXlrSC8zLytrLzR2Nk1ydnhP?=
 =?utf-8?B?aDR6U001MzBkQk9aZ1d0OUdIdUlzL0FyN3JNT0thUTEvSUNyTHZJa1VmVko5?=
 =?utf-8?B?QVNOV3ZZaEFZQzJ1dlh6RFNzTlpsVDhwbHdXeDhJbXBqRXNGajJ2a2poUWM5?=
 =?utf-8?B?ajB0QkN1NmFYQWZGSVVocmhoZ0VMZE9sU3RsYVVyZ2lya21tZThoT01WcFJv?=
 =?utf-8?B?WmpUVDRNUVlJZW04YjAvMzBhVFIxSVpqaE9FQlVIZFN0N3J3WmFrMzd2dmtD?=
 =?utf-8?B?c0hYMGd5L1J0am5ZL1dtcUVoVnNGQ3huQkJFMzZkeVd0TmhOYU5YRnl5VG1Q?=
 =?utf-8?Q?UsA/O3OTXrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDhZblREVitvU1FUaWs1VXNwQ1pQdURwZWErRTRYbzRENkNMUDlYVENXNEJu?=
 =?utf-8?B?aUVNbzNJcnhOVEdXejVHTXl1SHQybDd2dmY5ZTN3Qk1aZ2duamt6SERwajlT?=
 =?utf-8?B?YlJGSDAxcFFiR015UlNBRlpYbzM4ZHkrK1NvNUh2T3pBZ0lzM1dNZ002WTdM?=
 =?utf-8?B?WFZabktOL1YyeS9vOVBISXRWalE1U0RuR3M2WVVweS8xNVd3REsyZXJYOG5X?=
 =?utf-8?B?YXdMRkdqSjVVcjhDcStDRlhSRC9PSzlKWWVCZmRQQnlnenZIdXJlc3NXcnQw?=
 =?utf-8?B?bEN3ZGlPcnB5SVNTSHprTDNtamE3ZzRZY2o2cndzamRyUzlKMkFtQlJMN0lM?=
 =?utf-8?B?Nk9LMHMycENmUnZ4bXJmSThoaDMrV1czWXVEenNXdGVMYi9aNDF0ckZNK2tS?=
 =?utf-8?B?YTZDNDhrc3VLUVJnaVdNampYbE5RcEFieDk2WU1rSWJ0Z1N0ZXMxVTU1MGc1?=
 =?utf-8?B?aW5xVUlpS2JrRjY0OEI5UGtUNjYwMEFwZHhHZVVxUUV6K0xHd0JieGFpQk5Z?=
 =?utf-8?B?VUkrU0t4LzJsRXJmOVArTk4rQWRKNzJWdm5UWHQzYzNnMlJxYldEa2QyRVJr?=
 =?utf-8?B?TEdnY2dZZzZpV3B2RVNkbEVnc3Q3K0x3b0pCaVJsRkNoeDZBSTd5NFprWTlj?=
 =?utf-8?B?bm5xOXBkNjY0RjN3V2dBOTBEQnNQOGtDclFLTVpWSFZJZGcyUDJtYnFpSW9W?=
 =?utf-8?B?RkMra0VnbTVxTmlPMjlGdEFxdmo2bVRTQWE4ekJzajZwZkhLQjlMUllrOWpP?=
 =?utf-8?B?SDFqN0lQOWVRVVdjSzNpMTJ3YzVId2FFVFlxTWNENEZsRlF2MXA4M2hScUFC?=
 =?utf-8?B?N21WZlVUMFhyM3p6ZVk3eU9hMThFZXZCK3lIemdlUm0rUmx4ZG9Rc1VvV0Zp?=
 =?utf-8?B?c3hLUVNNVU9vRzgrU1d0ZGlNcWlUcXRyZFVLMXZxSDBrREJ6YU5vSzhmZjk4?=
 =?utf-8?B?dkhmbkF4aG5zUzlBaE9tUlJMeUR6Vm1hNENZVy9tWXdOVTBJemRvbVBXd0I3?=
 =?utf-8?B?TFg1NkNVVHNydlhaYVJnV0V5SWJ0RWtMSkFHdTFwS2l0d1hkcTBGRUhlcFI5?=
 =?utf-8?B?RlJadE4wQTRnU1pldkpoQWpCVDdyTFF5TlRrU01TclM3eUxONjV1WDJ4bUpD?=
 =?utf-8?B?YjYzMkRDMFFTUG5pckFRK0xDRkdab0lRRlNrRVV1RkRKQ1RZWDNTWU1od094?=
 =?utf-8?B?UXZ3WVBQS0N3VzdIZmowRXRRbjJWcENORmVqREVGK0l6ZzI3S0xPSks5NzAv?=
 =?utf-8?B?RGZUbTlOTU9qMVRuS0RtZWpZamdZUHdudHpjRmZDSzVTZldNQjNuaGlycEVJ?=
 =?utf-8?B?U3A3NEc1TUVSUXdESjkyam8vNGV0Uk5Jb3habGZBbVBXQ1U3bVR2VFppR2Fp?=
 =?utf-8?B?cElSdUVXWjlIRzNJY1hYSlRMVWw5VFI4UEUvL0pnbHZ4ZExadXB5aUpHUDhI?=
 =?utf-8?B?dlI3aDYzY3ZTa1J1NCtGcjcwNkR4TlVBWUtneFAwb3hHak9xZGtocTN1Nm1x?=
 =?utf-8?B?ZEl6aHY5bWJ0QkdUb3psRHlKMUlYQi9UMU1JMnZmeG5DOXZsQm1pU3hoZjJG?=
 =?utf-8?B?emdvYTlnTXRTd0J3dTdhZnY5MmhaWVFxd0pDOCswYTk5bG5sREhoNmc5WjRI?=
 =?utf-8?B?WmRpUGlyZGdqQzVqQXRZZlRPcTNyU3ZzM2tEZndVZ2Z3RzVTdWpBRUZZL0hK?=
 =?utf-8?B?UmdXSU9raS84eThQS3I1cDNPYXVOdm42MXlxM3FGa2pWcUN1ak9ZVG1Zd1lp?=
 =?utf-8?B?ZXgzdXEzWDNKREk3L3IxVFY1RklGWW95TmEzaHpIS3A4TmJ3R096NkI0TXlG?=
 =?utf-8?B?TnVwcFZNMVdJUlZlM05NSDNNQkZDRlgxUThyK3VQTjNGWFdoUGVpQ3M1Tlox?=
 =?utf-8?B?Nys4SDNKNnNwWHhOMUFlMTFJZWU2ZlEzdVlDZFZWWGNyM0lNenB1anRZT0dT?=
 =?utf-8?B?UW9SQVdnRGJzb0NVSDY1dmlncGlJM3V3dDU2emg1bm5QWVdQbWg5eW1sL2J0?=
 =?utf-8?B?ZkRRRUJ5anJxc25HS2g3MHFUWFNld1Z5eUZmMmFCdjU1SDBFWW92SktibnB2?=
 =?utf-8?B?ODZ1QkNCWVduSkxTNzFoOVZua3NXdE8vL1hxSkpiSU5VY0hldm91Nk9ZdTVu?=
 =?utf-8?B?ZGt0d3pOSWJUVjRrQ2F3c3pKUjc1Vnd2WHJEcWI4R3dGN0pnK0tGQWY5ekpO?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h26byMYBwVGFGpQNrTqP1oh8Xb1QOpPF2jCf9SjL9re3YpA5UE78EaU45er6RDteVN70vNcqSjGnrfJ1p9N0QyGLotZo0aMlHfXVW6QhSwMCn+L8m/2aUQKcIsyt414Zty6ftaEzVhZkkFuPCmNTWzau7AwjBWLl+AMyjTDjsuNAM9JiKAwC0ttZzMxaGY6x1zaCJF/nwIHfKNKUKq9slkPiev+9N/YFjRyZb2Sz6AvcDoCYw6nGZLGy40oV2+H+2GCfd3PRwyqfL1DBHuVILf+J92dvH9enRS2POgqDvryx5xcnCEy1ekI6HtuByGEEb/qWYiu+F48oDqtkGw/Wbp+sKk088XzjE2uPKiqh21eoSIcdMn+ZD6QZusmBnQaxe26E9i/sgyYDbUj+teEkrhqc6GY0d1nGTn+svzANUwRxAwjFZZaujhqA0ZvGGaIhbUOMF7RWTG2A13WAy5NdsMepqjzf27B3ViatvboV1YMIREpE4O3v/nlHk/KCNlQTNjsAQhXdi2LhTtkercTFIWSurZtBwjQWqlLFoS84K3VIMJKC4/6aGsPIcr7RKTEXxOwELOhZtOTaPWnLX71mhM1drmDm+Ah5d5xOa6vx7D8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bed6cb-76ad-4475-e4ff-08dd8d79ec80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:14:55.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Eq1vyLimU5032QFiC25Tg/MIr+a7vPu8UUlD0f2lxy2zZwK0a5uNtuMrnT+GW531+QdIoH2k2Jo7iCNrpoFqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_04,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070143
X-Proofpoint-GUID: hnXtngdzUWE0UcdOtinH-XtmAnON7Osc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0MyBTYWx0ZWRfX2l9Ej3vNzMQG xwA1+oDb1fsTM5OJt6khu4BhuRFKh54AVEntVaAq28EPSmxFcjKcimyOUxOJmXJ+PTybJtqr8J5 k5pMWBVxsXmZuaSmBp18ymEy1jOGRRtTqIngDhzzPl8k7f8uAaZCa+hnh1wREOyqlAKZHLtE6Le
 G2dCCtR24YL7nUxVpwBfiL1rb0BDq1i9VXyP0FdBSxXB5ZcKKKbhRrL9j3+k4ndAK1t5+TKCy+p XOHcFR2RLwSh8IbMY1m2FrxcbwYQEzbTf8EE8sRWq5dzXs81geWMV1rcRyEa52H6kAbsmYqdP1h u5nuwkP7Dc64F++++nwDZGjHSB/81t7bf+QWy7AAx0sTs5OIJ8XGVllwmbLgBtz6tMPecie70DL
 MrIdO+Am0kkv2K5d4UnBZ/zRLTk+4LG1S727hmb4sFWHUvjkoKixJcTTG6s6Dak335oFQDer
X-Proofpoint-ORIG-GUID: hnXtngdzUWE0UcdOtinH-XtmAnON7Osc
X-Authority-Analysis: v=2.4 cv=ItEecK/g c=1 sm=1 tr=0 ts=681b78f7 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6UZXv-ldAKGtQyAug74A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf awl=host:14694

On 06/05/2025 10:04, John Garry wrote:
> From: "Darrick J. Wong"<djwong@kernel.org>
> 
> Introduce a mount option to allow sysadmins to specify the maximum size
> of an atomic write.  If the filesystem can work with the supplied value,
> that becomes the new guaranteed maximum.
> 
> The value mustn't be too big for the existing filesystem geometry (max
> write size, max AG/rtgroup size).  We dynamically recompute the
> tr_atomic_write transaction reservation based on the given block size,
> check that the current log size isn't less than the new minimum log size
> constraints, and set a new maximum.
> 
> The actual software atomic write max is still computed based off of
> tr_atomic_ioend the same way it has for the past few commits.  Note also
> that xfs_calc_atomic_write_log_geometry is non-static because mkfs will
> need that.
> 
> Signed-off-by: Darrick J. Wong<djwong@kernel.org>
> Signed-off-by: John Garry<john.g.garry@oracle.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

