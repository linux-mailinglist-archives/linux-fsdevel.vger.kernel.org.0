Return-Path: <linux-fsdevel+bounces-48042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370EAA9090
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A283B4F5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D211FF1B3;
	Mon,  5 May 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="olAIsjxU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PlBC+GMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22871F2BAB;
	Mon,  5 May 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439520; cv=fail; b=GwIktrIXaBEqocCwwylRJfhdYNKkQKwb0CEmEHYXmCgrQVM2qwJg6yVnHbfZ/tKmOTAmb7mEv2JGNfAsEhIp+oMeV/97MgNXzV3nJKpdjkxM25FifpuhGlAReokBYZF15tDppW0J/N9OeG9sXm8u0kYW0fd7oX0j7MF1VG3npxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439520; c=relaxed/simple;
	bh=gP1LwUkOe/iCbaBwFmMc2sLxucTlB+SZcllJeQQKYX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEmr+OrSMstWl+ZPKEahQnD+acDxpgf0j2Oh0vZTUbN1cvbY/9UX6JryqM7BVyvel8J72t+mMV8tURNw+lz8l/uGyPtbYUmU7a05wqZO3ruYiIoWcEqj9HmvgJZlYBNODVdVIWfFu5kty9qgoKVT2/d55lEDNcYdQWFcTZklmrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=olAIsjxU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PlBC+GMQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5459mFg1014355;
	Mon, 5 May 2025 10:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/1Su864yhXHXy4b3G/gz8bKySjACH7YkHCIvocaDRug=; b=
	olAIsjxUO/7zUyM+uYc7lRDE2jSk0E0hmna0J9k74R2n3TM74lsO6r6sIOmNtMIr
	yqvKwWqwGqwVbsrMAzpxpXLl2OOmGYgiyEFfuLXPcvXQqqfBvoqdNta2WGWtEAmr
	XqdrgQj18R5bIClrSUaL7b1MWzZZcBrAEyPOi2tqvJpNKqSByQ9dvwQhwqMjo2PW
	/7bAHr3LkLXrBibYoO+xN9y2hRG0oNROyaPfuLCYRMXrJ0cLbnJE970lk4nytkLc
	mkG8LRY2qBYR+apkvgjubjlmB4Tmg43dhKXi3e9koNYUD1+Uyh7C3WcJ3JwtBxFl
	7wteEwcDmfBd2kciCzFlBw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46eu0fr11k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 10:05:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545845te035449;
	Mon, 5 May 2025 10:05:03 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kdr8cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 10:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1YTZungAsd60Mz3vMNWKBhsRfNSk1OR7/yk3ad2+HrtNfsDZzg89XPJ8ZgTOUoOP8dtNhtFnk50tOTE+nHYd53+udWbKXs74FjYfm6jMyWmlpXc8h6ODpcqPahjmfXtlWLDJm5rdcYLMc2DcPiH3pJCwpC7MdOcndedTs7fMgrInNhAirIKLsJJjQs4/oSekM0LoCFfoS9MsASsFqAXjuUs5p4W856UQWXvqJJz44yhnLveqcN/vl/UISKqBceyikkBIgGQdgueK74ey6jPIOGF4ldR9nXe3E1m8LS1AYEiKJYncpylcRLV17RgeuIOKNStKCTmv70rlEdIHkI/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1Su864yhXHXy4b3G/gz8bKySjACH7YkHCIvocaDRug=;
 b=TZzArquBONNRZFyrnXzsCNHpRpc7UQIPfUqTb2BjHXAPgajDUsbG/u1HKeejkB9n62dy61ZIZNVzQdbjNdmkbQFF/mx6453f2HarNiy09qaH7tDYZ6FQ/c97/qS8dycEuSoigPP2sUH5H+b4BTbEOnfZT2JFtyXynEv0MYsMNwoBVbaB8On0sOtaBu0Rlu0ox5fjSLfQ9b17eoAbsiA4kUqh+2NO0n22MDLmRKKugpmTNViHrfmn6KW2M3SLchW362NdaCMBDrQ+B06sykXU607qU8Zpli76St9HFyoVq9mc/Rrb3tqdxb9bP/CC9vA0xi0O2ulxbhHKxVhjCtQ7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1Su864yhXHXy4b3G/gz8bKySjACH7YkHCIvocaDRug=;
 b=PlBC+GMQTyTcpDYADzstpVoIryTVHFhQG/huSGIhp4S2f9oIJ8gy+Yp4TnKxvapKuHYf1LySJ4DRMuePTD9fzjppkHiXIe+ioW9TXy2wtffyYHF3WQUA4WVli46/XI2YMU0dE+6bP0xYpzLIyFSb4v6m7Tm/GqvXS3nyv/XkaBg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5150.namprd10.prod.outlook.com (2603:10b6:5:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 5 May
 2025 10:05:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 10:05:01 +0000
Message-ID: <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com>
Date: Mon, 5 May 2025 11:04:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        catherine.hoang@oracle.com, linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-3-john.g.garry@oracle.com>
 <20250505054031.GA20925@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250505054031.GA20925@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0058.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: f5da247d-1331-4c7d-1040-08dd8bbc4bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzAzVnNReFlDOFUzNDhpYkJXMTIvZ1dTMHJYYnh3YXgrUzRDdUZ1eldZV0kw?=
 =?utf-8?B?U1VaWkdra25sUjE5Y3lSOThwRkFUVFdHa1Q4Y1FDYmR6VnFabGVCUThUOXA2?=
 =?utf-8?B?RVhnSTRCbFl4aEMrbTNIOXM1Umt1cHdKZFNJS2xUazNVTUpmWjhKd1NyaURx?=
 =?utf-8?B?cU40UGFzSDkwZU9hdzRUNFFsbGI0TUUwRVdoMzNQSlpBNHFKc3ZEZWt2VmpF?=
 =?utf-8?B?MXJtNTlMTHEzVzF0R2xEeXJsdVdERXFpYmpiVU1IemIwTDQ5LzBwZHRkMS90?=
 =?utf-8?B?VXE2dHRERFEzQ2pla0tQTktudTZzUVZkdFhkYlJVMTZPWFJ1K1dnKzBmUThs?=
 =?utf-8?B?TmtLQkkwVWJNc1dtQnJra0lGK3E4U0NBa2Fkam9DTU1lN1B6aVdiWlpDZ3dT?=
 =?utf-8?B?ZkFPN05RQnJaUmx4T1hPTENsNldKSnZvc1lhc0ZId2FlUGtJMUhaUjdibTd6?=
 =?utf-8?B?NWY4OUNiR0pYV1d3Tmx6R2ZkRmYxaGJNaFozeHlwd3pxOHIzUEx4OVNUVFV1?=
 =?utf-8?B?M0xDTnJzKzNTK2VxRElYcTNkMVA5TXh1bDV5Ry9YSjhVV0c4T3JvL3ROMThx?=
 =?utf-8?B?YlhMVUJiblhYTzNFd2ZXV2ZoUjRkQk55YVBzQVd6R0VmOVRsekFNby9MaTZz?=
 =?utf-8?B?ZGVndW9sMWpkanl2eFF1aXlvUWdubXB1N0NLOW1aZk5zcHYxN0Y2eUFTOUZG?=
 =?utf-8?B?R3BzVUlTSzdKcnI2bGI2cW0rZktWZzUvS2hlQ0xtdGZYSmJMS0ZkSThUVG0z?=
 =?utf-8?B?Mmthcm5vWjUzMGFMT0ZmeDE5WkZKc0gxVkhBTlgyUjRKWXZyTCs3dkdXN05B?=
 =?utf-8?B?bElYeGhoYmV2TmZ6QVNmdXJ2L2YzdXB2YzhHdHNPa1VCYVhZZWkwZHVvaWJ5?=
 =?utf-8?B?UG1kSHd2UndJTHVKQTVueVRmS2VyN0ZQQStDL0NhREtwWmQ0YjJDM3BMV0hs?=
 =?utf-8?B?ZjZoOEJZQTZZb055K2x5RDdocm1RYXRScnhvajV0aHNteWE2b2QzT2dtd256?=
 =?utf-8?B?aS8vOFZkK0tIRVlSM25qWnVkdHl0V3RqbFF0dDdQRDlNZFpFR2gzeDdDaDIx?=
 =?utf-8?B?bHVoNVgxckt6bHlqQ2xGdzRIWW1VUDVLNW1hZEN0bllJYmtFMHUxZmd4aHpX?=
 =?utf-8?B?UWVDNzVOYURacG14RERPVmhFWlFlT0Q4R1JOVlFpNTFMd0NQRkx6dnZObGts?=
 =?utf-8?B?eFVCVVc1YkxOdmFnNlhDeWtUREpCOG1kVDN5dHhmZDhOSmNKM1IrZXFCYURF?=
 =?utf-8?B?ZERCYW1NQjlwem8wN0Nzc0tCeExpSFVwUm5DNGw0SWluTERDdVo4UnErbUxU?=
 =?utf-8?B?aC9MUzNZTGIxYnlNWnAwa1V1Tm1wQld0amtCQmxEb3J2SUU2L0Z4eUhjY2ZF?=
 =?utf-8?B?QzllakRpQjd1Y0U3a3RNeEQ3SEZHZEZFVmtEcG1WUGNkMTd1UVZGcEJiSGlD?=
 =?utf-8?B?L2FER2lyaHZVZXQ5dE12ZW5OQzFJbkQ0TzdJTC8xQmVSUU1UU1NEWDkvRURF?=
 =?utf-8?B?aWpzVzk0N0haNXlBVUwzei9YRFJtbXZYWE1kV3phRFFNNkF6THZwSTJ1cGhP?=
 =?utf-8?B?WXB1KzJVSjVKZSs3TVd1NTJOdjFNR1FLem5IVjlpWjhHb2M0ZGhIUEV2T0l4?=
 =?utf-8?B?V3pHNDB5bHZGNEJjL014bXhiejlUT1lrN3lzVWs2TU11SGx4dWM4NGtocndG?=
 =?utf-8?B?TnhQaVFPZ2p6Y0RsMFJJNVdxQ3lXYkg1Y2M4YVhlejkzckd4cy9qejVXY2Na?=
 =?utf-8?B?bWwyZ2tuSmx6bmhRWW5wRnhTMThQMVNxbThDb2JMSjVHRzR0bmdrL0krYVRF?=
 =?utf-8?B?OG5aQ0l1WEZoMzlxaTZoNHB1TTMwZlAxN1pLc250dWlweXZlaHpBM21Fbmx2?=
 =?utf-8?B?S0YvY2l1aTFoVkRaaDJTZ1hyeSt4ZzZGQUg4N0kyY3lJeFNLNXltdnJlZC9D?=
 =?utf-8?Q?8BpbDy6A7t8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2VNZHF2MjFZVzZpeVlOa1NQVEhtVVdUS0N4ejdxdVdCak10YUwvUWtLVHRS?=
 =?utf-8?B?UndoNzNiVTNBdmtiWGVOYURReHEvb3dNenJORFVldzByUkJMellheEM3a3RS?=
 =?utf-8?B?UVhUWVlWM0o0ZzViSDdLUFBzVlUxb3kxODlBTUt6MUxESXVNbFZSU0MxNXA5?=
 =?utf-8?B?MVJ4VE9iWml3TUppK0drdkJqRmQ0SjZzN0ZUblk1dk9mWlRwZjlDL0IrbWRC?=
 =?utf-8?B?akVGbkJWKzUzbEdIZVM3czNJaUxXODZPajMvaHRiVjkrZmN5VFpkREdVaGts?=
 =?utf-8?B?eXlFWlcxWkUybmxUVDV2SkR1OE0xckcvUndTaG5hMHBYWWdSN2pWcnhwSllN?=
 =?utf-8?B?Y1ROQ25RbVhKcTFsckF6aFpZb0h2YlBGNHpzcEhiMDNZTmx2VS9KZ01LK1VH?=
 =?utf-8?B?d2ErOHlyL1VVTTFEbXMyWXZmUWYwSVoyZE10ZEtRd0xPY0t2QVdqQzI4b1Jj?=
 =?utf-8?B?NHMwakJZRzEyZXN5RExsZVBrcTZHUEVxV043Y0JSYkNuTWlNOTEwZnB6bWI0?=
 =?utf-8?B?SVJzUlVLZ2M5SDF5bnIrTm5zbFhZZTVYV3VRVGg1R0NScnFjQkpxMk1WRnVV?=
 =?utf-8?B?c1JjQjFEVFJKYXRPRlJ6UEl3K3VVOU1DZjlDN0dNUWFIWUNZY0ozODhzVUc5?=
 =?utf-8?B?OXVtdEl1YnJRTWw3V2w4QnR2cmpZQUhhKzJZMkNud3ZIS2I0MHllYlNJZ0Z0?=
 =?utf-8?B?LzdsRGdqQ3hIUURPR0c4WXF4aVFsVGRFdGdVa2lKU1hxMW1jRjZEeWU0VmU5?=
 =?utf-8?B?SDQ2OTMycmJEMmhBRnU0VSsvTTJmOVFtZDBIMlo5NnBUVXlhR1Y5Q3VJMkFx?=
 =?utf-8?B?bSttZWRDNS9PQ1oxSm1ySW80YWVFa3FleGdMMElFSE5WcnVzQ2dNcHFYcCtx?=
 =?utf-8?B?ODZvZjB6aEZ1YXJ6NWVyeExsZHFLM3ZNdFY2QWhnb2ZFbTBCdzN4RGJQSmZR?=
 =?utf-8?B?Y1hETUJqbEtiOE1CODFrLzNrWURTS0lDRWxlMTlMS0FlZDR6QXpKRzEwQTl6?=
 =?utf-8?B?TlZPL2dWNkJpWDNjOGpTK3dIZjhRS0JsNFduR3U0amViSE1leWVkN1NiZ3I1?=
 =?utf-8?B?OXRPVG9iNko0dlBkMXdXdHR5UFBpMzI1M3N3SkRBLzFWWFVGaGhlbDdzTVBm?=
 =?utf-8?B?Tm9hYnVpcmZKeGR0MkFDeDFESGhtMVAxelJ2SW8rUXVTY01UNWtYdW9yUEdv?=
 =?utf-8?B?aDRZb2I5amhFeUZjeVdQbjcvemEvczhaVG4wbVJ6U0dRKzJ2SEp3ZGlSRkFa?=
 =?utf-8?B?cDNMUVlrQlI3WTFvbmw2Zk56dXI3UmZ4MWo5VjBsN0V1UlNZN3dadjg4OU9G?=
 =?utf-8?B?b1V6UGw0ckZSNFo4ZFp6OVVyQU1scXdxdnFRQVp2blFMMG84NTl4SncyVmoz?=
 =?utf-8?B?YWFUWHlHeVRZUjM4cHhPM0pyQ3FsOGc2a1lBcnE3b3VmbnJDMWdCOXcvU2lj?=
 =?utf-8?B?MVJMQ3JGWElmLzZOUWlZN2kvazRFdVlZU3RrVUUwamp5ajRnV0dUSVR3RzIw?=
 =?utf-8?B?c01hbEV6U1NYUGk3TmtURHRrVUtjamJOTDhXVnR6dXhKNGxzZzlrMEN4K2hM?=
 =?utf-8?B?VnUzZnRPT0JMTW1XY0FrOFpyQlNxK0xzZkFaSmxmcWIrS3g1STlYSDV0UGE0?=
 =?utf-8?B?bkJ2UTIxRHQwODVMY3dkdkxONDdBMVI2d0d0bGprZnoyTmFzTFlWOWN1blZv?=
 =?utf-8?B?Y0RleDRjbk9oT2FENUVwbEE2U2RWejNuM1BBU25JS3doRmdYUVB4VmNRWEIw?=
 =?utf-8?B?SStlc2E2L0dxMXU0cTMrRk13a0JENFRUcFkzWlJkRDgyREJLM2prQmtXTGVR?=
 =?utf-8?B?d2w4US9MZ0VyNmVWY3ZpWGdSMlc2ZkN0U0NqSVEwbjFINWpMcjcvNTkwTFR0?=
 =?utf-8?B?VlV4ZWM0bk5VOFRZT1ZjQ1BJUHJHQVpOOHhCcWc1NWVwdzB1R1BGcHdkaC9S?=
 =?utf-8?B?Vms3a2N4WENFNTdkMWZGcVNsQXc4NkF5UWVKbnB2MUhaTWhzQXB1dGk3a3B2?=
 =?utf-8?B?K1V4aVJHS2g3RTB4NDlnRVlraHV6a3FJVGtkeSswUTFFM2p3bTlyYXl5WlNF?=
 =?utf-8?B?aTI4dW9objRLRThXMjY1Z0o1RlFsaHpHZktIMy9wWGdndThQcVExVTkwcWdE?=
 =?utf-8?Q?aOsdsDBq9Yl4UG7c0RpRfjf9N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GLu6cBocyWHcbp8YCtTQwwPmQ3V7Qim3er5QfZ8Ml81/anZHCve30l1TgRsBH7bq0CPDbJWtK5d23rmkr+MGujs67x01wVll+mMM+79q/eo9RnQbfDziLxNPrjiwz+P4mKDNYyZFNRry+bqRO1azwc/Nqeao0f0HRzl+Kud5DwbOwY+ag1hHrub0YOzA8gmQpQR9iHT0x5YzBR0DhqndnoBPuMmW5R4C/0Zkjs1e9Ni8lRxyz6K8fMfurNmiFv+t2dMjMxh82R37ALmURCM13s071YWOHG1/n+8oopL1NWe7dqhc+Z7GQJCdTviIoLuP387t7iB9k3h60lCiwnuUlBb8eEk33Fs2aFuM0sMHdOUOzy/XAxjoSle/0ljMfN826AJ54uZhMGCVZ4xzWe3gCYwRBynb8Y4CNXRRJNs89ESxAjdFT1qhjtvGA22yBL9khZ7Mu+EWDX+GEUrCTdh1mGnvrHO7ca/05P2oFmeBzan7h/ZylC+ryk84c3fXlATd8WM3tNz4rulVVBWgjIiLGt5gkei8rsIskWTwYttH3yrlBTYLQvZ1YLzHoOZpXz/mKHNLWJvh4sSUoQZ4i3j3xdmrLdEHK8jGR2ARwChCksg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5da247d-1331-4c7d-1040-08dd8bbc4bf1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 10:05:00.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+y+fcsQoKUytIfhhuqprEfg+KAbxJjbr9vMTHGtbJW5FQp7zS5ugp2NfLHlGao5jvOobRPfrpkZ/f6/qMlJqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050095
X-Proofpoint-GUID: 3WKDZBJue8apjcfwt1bjxPpC7wwlV5XG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA5NSBTYWx0ZWRfX80ncl11S0ZcA G7E+FErAfNj5DM6z3x/Hv/8JaVo9ODSHSUWc2/GgiVTs96aotgZE4j5vtysP7ExNrsB9U4vwviI h178BImOy3uMh4WtlVNLxfxfyV+DvXm28gqJ9l0GGKQpZBKkol44cQughN5O9uPqjNeEE6X8X1k
 934g2bjFwPrMw8HrYrqHZLMBZrmgBMFo0st1YdDeq9FXk/GBui+GEwypBNrw/knOoDHe3Yt0AJV BXBeMsmtS0CSk8XshxiFF0VMwhYBhOBZm8IVRbeRaD3jIInrAdpgZJ0EDubSEmiswW5r7JESiUX GKdSegLy30pks+zGt7Ml68w2THGXR2lTzWc+byl0Jt3iksqoGu2y9uVzqaN/keicuft1w2V5019
 7nJvoVATvaP2+A5bpQGnuyTjHNjovj5dSr1ejK7x8zS6JzBjbea1/rkQnLOJj+UxdzDmjSCt
X-Authority-Analysis: v=2.4 cv=YpQPR5YX c=1 sm=1 tr=0 ts=68188d50 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=gmqn7mVWqg6dBbPJulUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: 3WKDZBJue8apjcfwt1bjxPpC7wwlV5XG

On 05/05/2025 06:40, Christoph Hellwig wrote:
>> +/*
>> + * Flush and invalidate all devices' pagecaches before reading any metadata
>> + * because XFS doesn't use the bdev pagecache.
>> + */
>> +STATIC int
>> +xfs_preflush_devices(
>> +	struct xfs_mount	*mp)
>> +{
>> +	int			error;
>> +
>> +	error = xfs_buftarg_sync(mp->m_ddev_targp);
>> +	if (error)
>> +		return error;
>> +
>> +	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
>> +		error = xfs_buftarg_sync(mp->m_ddev_targp);
>> +		if (error)
>> +			return error;
>> +	}
> Why does this duplicate all the logic instead of being folded into
> xfs_open_devices?

So you mean an additive change like:

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 64fbd089ef55..9fa538938e07 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -488,6 +488,9 @@ xfs_open_devices(
  	mp->m_ddev_targp = xfs_alloc_buftarg(mp, sb->s_bdev_file);
  	if (!mp->m_ddev_targp)
  		goto out_close_rtdev;
+	error = sync_blockdev(mp->m_ddev_targp->bt_bdev);
+	if (error)
+		goto out_close_rtdev;

  	if (rtdev_file) {
@@ -495,6 +498,9 @@ xfs_open_devices(
  		mp->m_rtdev_targp = xfs_alloc_buftarg(mp, rtdev_file);
  		if (!mp->m_rtdev_targp)
  			goto out_free_ddev_targ;
+		error = sync_blockdev(mp->m_rtdev_targp->bt_bdev);
+		if (error)
+			goto out_free_ddev_targ;
  	}

  	if (logdev_file && file_bdev(logdev_file) != ddev) {
@@ -503,6 +509,9 @@ xfs_open_devices(
  		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
  		if (!mp->m_logdev_targp)
  			goto out_free_rtdev_targ;
+		error = sync_blockdev(mp->m_logdev_targp->bt_bdev);
+		if (error)
+			goto out_free_rtdev_targ;
  	} else {
  		mp->m_logdev_targp = mp->m_ddev_targp;
  		/* Handle won't be used, drop it */


Right?

