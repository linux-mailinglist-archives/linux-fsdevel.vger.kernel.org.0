Return-Path: <linux-fsdevel+bounces-38865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA3A08FE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 13:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAF8188D71E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 12:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A520C48E;
	Fri, 10 Jan 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a0FFiZz2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cXhKr6Id"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74720C46A;
	Fri, 10 Jan 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510400; cv=fail; b=ZBqeBP8iAKh5v+AIVNl8480ihkh8iJ9CppyGzuAgIj/SMCUPhK/bpDdNGTvnRrlvBuV5V5yIo1xg184OGjivjBLowVi7h3Fk/IvHZaAILG/3m25JQNnLN8Wmh1JFUH3/c60yTSlpk/ioRwdzMyu71eXrq4Q+CbhozKlDCxmtkHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510400; c=relaxed/simple;
	bh=RlZE7EodEFuyQ3Q1UbpH0hsAxhwuYh3cbU1n2WRh118=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tdi43KSrhEVn2IMxGv/esQ+YTcmT22OXDbqn4oxi7Jg46MbWTTtA3Wywgp9WpRfN7N0NbX4bBUp8Qx3pc8qChXqWbQw7qnp8tSi3F0xMYQudBpaMrUTNTyGpNUifAfad2DO0RNBkHVtpTBrteNuwf6JMGWO4AkZXXv7OEGjwUXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a0FFiZz2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cXhKr6Id; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9BnV2026350;
	Fri, 10 Jan 2025 11:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EFE9JOMwwxVnT0NmO26/xlaTfVlBaOSR4U8kt6/erY8=; b=
	a0FFiZz2vFsJqzDUx+6Aa/u7Kg8Ynz0eXPws54DRKTQBaPZW5g5cufLLdhtB8WYv
	Tl/V1JWFltHKr0p/LSw+dIKiMA5l3rkqZKIL0BNdBRdquQPaYmXl+Bt4XnnBbY7b
	RbdxioqUzu1yxdvQwRbBwMmIYJnYPTTIBNIA4yHoquyMXWaM3LqrC1RpC7pVn0Q8
	NnXutTf8sZmZ8kOewK5yC9KT0MTRksuY9gvDVKnvAVJBMFvA7u4I8eyWTFcYDx55
	lYUrOxo+bZ2R5I7pZ3xyEdLYMlTG8tregREfdkV3wmTV5bZi0y/PWLhCFO1Fcvot
	mSLrYqdDsRUSVfuvt59tiw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudcb2c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 11:59:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9p0Ua027466;
	Fri, 10 Jan 2025 11:59:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xueckqfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 11:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph37zFFJFPNfdhdt0v96jR+l4T3YBbUuKsR++ieWnr3cbF6n/VGteuOXgRnCa16vWRG0kk2Eb2knJz8wNLo7qd1ut+qRY+1gqw61LNgwszsu5X2Gerdyw1w44isMW169wAwtq2j1RM9eXbSvjLqZIFhHnG2tpy33VzPKRAKZ9Gp8GljtXeUYcevWdxxg/xZ/mTWi635xeDBKCY3B2czcbDjHAzM9Lvi4spdgCIL7p0pIKr6dvkd3+laf/gf53ApCtP8V9sI5FU3+sa+MjZmownZnFwtJfM17wX9670dcdAWX7J19Nu/4NUAc0GK0RPAsw1OlBG8noG6Huws53EanMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFE9JOMwwxVnT0NmO26/xlaTfVlBaOSR4U8kt6/erY8=;
 b=BLiK+4UlKptA5bxKwUMrS5mUP0i35RiGyBOyAP6jHT3EOnw34SsJF/ObCj7jUfhs4Jlgb6apjcgp0nR1WoSNSUJKyQG2Am9PhlQ6MsUFW068Ea0mDIoiF+M+91j+57Y+UMl6HmMtnhcp2Qj/TNIKPmJ85OBiTj92ljLfGefYeLokMXgxDZjgFtYNxj2ASzpTwYokSjhPxRAi6dFbGEA4YTi2DKqrsJbEXR5QDvsL6rzVYkAYmJYPjnXf6qFHwT3iGpjBfwibIC5dayFo0jzPrRh4xNkAuDY0M2RVxc6m88lDziQ9ceh/2ytGU9GtYAYUzmppBAH70FNOhK81o1400g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFE9JOMwwxVnT0NmO26/xlaTfVlBaOSR4U8kt6/erY8=;
 b=cXhKr6IdQCU29L4JFR15JwMutgnzuQ4lJzqoFDy4jxw1KrAg5wugBNSoHZd0jRB7R8Juy54Q84O5bg06+JZQAGcHr288QZKDbscWXuv4rhjkj30tohJF8A6ys+u9ysGWvx/cEcKb/7fqLhhV5+VZY5m1k02sj9xaQyO3uPBllg0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7477.namprd10.prod.outlook.com (2603:10b6:8:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 11:59:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 11:59:35 +0000
Message-ID: <bbf6ee5b-77f1-4bd8-ad7d-92532512e133@oracle.com>
Date: Fri, 10 Jan 2025 11:59:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com,
        ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com
References: <20241210125737.786928-1-john.g.garry@oracle.com>
 <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
 <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
 <20241212204007.GL6678@frogsfrogsfrogs> <20241213144740.GA17593@lst.de>
 <20241214005638.GJ6678@frogsfrogsfrogs> <20241217070845.GA19358@lst.de>
 <93eecf38-272b-426f-96ec-21939cd3fbc5@oracle.com>
 <20250108012636.GE1306365@frogsfrogsfrogs> <20250109075412.GA19081@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250109075412.GA19081@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c593a0a-8bc5-40d3-a18b-08dd316e406a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVRjTUlTSzFhc2JaYkl5bUcxQU9HTVVLNUlENk5xQmJDUmVua0tzUzJpalpr?=
 =?utf-8?B?TGtQcmlrMXQ0MmJKMkptUGRWWmpZTXhpV3pLNytJWlFhR1FOOXpiMXRmSTgr?=
 =?utf-8?B?djRybEtmV1VlWHhqRnNBenlMZENLNTBPMmFmdmY0TnVlbzlXdFZoWkt6cEsv?=
 =?utf-8?B?RlZrY2dUK1hCc2t5bXVRTFhyeDRNSG45WURQZmw1QjBYMS85REJqeGh5emZj?=
 =?utf-8?B?TmFjK2ZkQXlEcS9XNnVoQmhEWXB3WHE0TnpjQ294TTQrUDQxSmhOMUFtSXZW?=
 =?utf-8?B?eS80VGNHaG10d0tXeWZGRjlPMHVlUHBJeThJV0ZzeHRFMFpJSFZpNlRWZUoy?=
 =?utf-8?B?N05iVy83MENoK2NqUTVHZE82Tk1tUVJWVW5DUVE1Y0pnYU9wQjczOHJkaGk3?=
 =?utf-8?B?SGlVbk1CL1lnWjN0Nkc5K1JxYXNnang5cUI1eWhLRnZSbStSdXIvalp5emMx?=
 =?utf-8?B?VTRRMEEyQnR5K0EwRXpGaWZ0VWkxRjhPVVJLMUs2WTQrYTloS2NrZnpiNkRy?=
 =?utf-8?B?dis0MGpTS1NQdlJwUW5RYXp0YVQwdHZ1bVhqTllIU3BTdlprQ0hqK3RtcG02?=
 =?utf-8?B?S1J2bmdPS2k2WTBEa0R3WVNiWnA0TkNCUlpFRFUrSU1aSUpjcENONXAyb1Fy?=
 =?utf-8?B?ZzZuVXhFWU1QYS9YR1VuQlVDR3R2Y3E3YlZRa091UmNYODhzWXp4T2tab0RS?=
 =?utf-8?B?dFVSWmQ0YWxPa3ZTWCtVSWE0b21oS2pYejhFN2xKS1F2SVhZUGZrRkhidnRu?=
 =?utf-8?B?M25HdS9hMk90UEFadmVPRC9Bbk5xcEZ4L1UxaEpyV21JcDlUZDJBNUVORVBL?=
 =?utf-8?B?dk1jdi83dGZucHl5YUd6Ry9id3oxMHI3L3JET2h4NStBSVJka3JXbnAvcHRN?=
 =?utf-8?B?OThHd0ZtSlVXenorQStiWW4rVjMwT01XNVY2cUd2SzcyNG1Ma0RjdmJwc3Zi?=
 =?utf-8?B?Tm00ejV3d2krVzhzY1hrT1VRd0dXMUp0ZGJ6Y0ZRYTBrcEF5ZS9yT0tyb2tV?=
 =?utf-8?B?WlhNZjFMUUhkdEZLYnRGS0VSR2YyN3J2NW1LMXgrN0svVzNpY1gwaGZpeW1M?=
 =?utf-8?B?eDdMUExCSVNyUlMvdWJZUnBQbXgva09WeU92TndkbTQrSnpTOU9hOVBTaHVM?=
 =?utf-8?B?THlhcVVJVDljaVpmNkZ6MTRYd3dBTS9SSHljV0NFV2dOeHRkU2VBeC9XVHRs?=
 =?utf-8?B?THFCK2ZmZjdESU5tdUdsN2VhZTFCUVVOK3ZqR3lmcDBBc1JSSTVjNStNclgr?=
 =?utf-8?B?RmZxZDZ0aEk3b05hYVQ0OTlnVU0vU2czMUNMTDFwdVZIay8zWjlFR2lDRFI5?=
 =?utf-8?B?NFBST2lMOTZhMTNiTXVjcVQzWDNmaGxscnJLK1c3NFpBVUFqTENvd0N0V24x?=
 =?utf-8?B?d1JWTVJwRlJqUHJxdlhnMloxRm56UEZxQ0dmdEdCTGlBdnliWW8xbjl2ZzFv?=
 =?utf-8?B?YVI2VkcxRmVHMEdnWVZ0ckhwWkNIOUxhaWdXZmJqdXVGb29oMXkvVnpUa0NB?=
 =?utf-8?B?blZvZnJzU2g5RW9lcThCNUVoTkxyMHRNN25ERzVkMWxrN1FDUUkvQXBxd1dQ?=
 =?utf-8?B?ekQ1OXlhWnlwRnJZOVJzbUUyZTNlM3hvSWxEVU9qZmxjRTZHTEMwaEZ4ZlY2?=
 =?utf-8?B?Z3ZzM0o1Ri9OL2h4SytkRUZVYkl1dmdQR1pYVWN5aVdFUktCSDIzeGdlNHpJ?=
 =?utf-8?B?cWNKS2tMMzN2Z1c1TzBxRmh5cnZTM3pjY2xZZElnR2Fyc1dBbENoZHpFeVk5?=
 =?utf-8?B?aG9vRXZmLzVGYm1JWFFIMFVCYWJyYll1STdWVGdLRE1DQWZFUlhNVkYyNTd6?=
 =?utf-8?B?dy9DbzFaaHBOcUFyVURkeUw2UjZVUHBzaE4rc2lJRkhyWURMemFrMDlTRzNV?=
 =?utf-8?Q?/MzEJjuEkwLLh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emJiY1lsblltWmtabUlydE43TTU0dU9TazdlMjAwSk9kNFlpclVBUncxOVpv?=
 =?utf-8?B?czFCSTFvVCtBMUdJc3B6RmtlbHFTbXc3d05LUjNGOEVRc0JaRWJoVmR3QlNj?=
 =?utf-8?B?M2EvVUVuNVIxOE9LTTBKT0JGcy9kS1pmaDVWdEhIRkdQVTNYMmFSaWpCNnJE?=
 =?utf-8?B?aFcrS0xuMEswUWJQNGhNSmduRk1WN04yem5kVzJsK1ZCY3RaQVpROWNRT3lO?=
 =?utf-8?B?M3Q3VERRdVlLOVlMZXltR1Z1bG92SDhrQzExOE44d3pJN1Z1YkRVUm45REZV?=
 =?utf-8?B?U2Z3K3VobXB4amQ0MmpZZ29iek9UcUlpeCs2S1F3VDFUOExvN09rVUtyY2Fr?=
 =?utf-8?B?MUVEUDVPa2M4SVk1Q2JBRlZySGYrVUFWaXQzL3FaNWY5N3FPY0VTOGFFNmp1?=
 =?utf-8?B?TUN2N0V3VXZTRkVKOWRpdDFPV0NYVlpvbkxxL3d0LzhjNzg5Y1AzV0plU3lS?=
 =?utf-8?B?Y1FWaDlrYjNxYUZDUkxUVERBN3diZkI2Yld1aXhwSUkwcjQ4WEMyMW5iTzYz?=
 =?utf-8?B?bEhienVDVzRnSHBZR3JPVXM3clpFZ3pLL1UvQVBYYmVWeVAvSXVjZFBhS2Ix?=
 =?utf-8?B?SVczSXpHQjVtZzlXQUtTNXRRdkZWeW9aaVAvS0hvSjAyY2RRVVVkSWEyNzE0?=
 =?utf-8?B?NDRIVWt5Z0VrVmx2eWE0bjhvckN2YmcyejNRak14dXd2Q3J5WnlNWWVab1lP?=
 =?utf-8?B?K3V4TTJVUjBsOUJzM0F0cmtiR2JkVFE5ZUUyMHpJaVJSQ3lnbi90N2dPV3lD?=
 =?utf-8?B?bWplMGFaaG5PdWtjVVNHWWxiUEJNOTZ0Zm5KU1IrT3pVY3BsWXlqdzA2emxH?=
 =?utf-8?B?ektYUVNsQklHYWxOTjNBKzViN0dDYkc1Ty8vWjZ5bnNYR3dsN3dENjEzMXFi?=
 =?utf-8?B?NHo4UUtiQ25KUkZQTzJwQjduSGx6UU80djlzZDRrNUxCVVA4aTB5OExNMXpl?=
 =?utf-8?B?b1d0VlRGWDgrWVlETVc1R3R0ayt5Z2drbUVQakdIaWlkc3lFV3JaV2JhU2Q3?=
 =?utf-8?B?K1l1d2NMNDEzbTVucWRGNktoazRaYXBtMGJRRGI5Uldjc0tDQjVUNENlTUsz?=
 =?utf-8?B?SC9BdFVMVWcxTXJpakJqRFppblJxQjVkZU90ZlVaaDgrbkFuZXRqSjJxWDR2?=
 =?utf-8?B?Y3Q4UDZudzRrOHE3SE05Ym5JL3h1KzlSUEJTUUZBZkJ2RDJEZlk3NFBrNW9W?=
 =?utf-8?B?YWZHZS9kcVJ5bHQrbkQzMER1bmNYell6OGl4OFgvOFNWZEJvUUxlb3BoV3Vh?=
 =?utf-8?B?Z3BwcGJvM2hkbG51SkNWa0I1eTM3cW1JWVFhQWw2RHNzWGR0UXR1TmNRa1lB?=
 =?utf-8?B?dkhlNmFGd1JOc1pIY2xFU254YzZsZHdKY2ZUZzJES2lJMDdRMEhkQlNmbjR4?=
 =?utf-8?B?aVorZHVtSzhDV21KaDk1Y3YrTk1qb2wySFNoaGpjSzNhRW5ISEFNUTFpbUhz?=
 =?utf-8?B?cGZweUVsNHk1eDRMaDlJUjVwcGRtNmwxSENjZ0gxb1VWRFg0WVdhbDBLN3Nz?=
 =?utf-8?B?b1dQUE1jejd1WHVlRGhDSnBIdU1SSUJkSmlHdUZ0NlhBRkFGbEtzWWVjeVc4?=
 =?utf-8?B?Ums3SjJhR0FjV21XL2xTZ2E1eVAvQ2JQeHg2MVRLQWhFRGJhbHJaZ3QxVU5K?=
 =?utf-8?B?R2pPaUZReFZ6ZC9HRUhRM0VHQXduMWc4dlp6NnJxZ3Zldm1Pakx0TDFTZUtW?=
 =?utf-8?B?Z0swZlhvbHVVVGNXRWw5RmFHaUxwUlFnQnY5dDRBOU9tUkx0OGlMMGhBVVRV?=
 =?utf-8?B?VzRSYVpQcmYxSGJBVTFSRkwrOTBaam1IbzFUN1ZOWkNoUXV1akxlV2JZTFVR?=
 =?utf-8?B?Q3BKVkgxUDg2ZCtRK0ZmL3AweVYwd0gyT3U2WWtpWlIvWUVHc0VYWDR0a3Z3?=
 =?utf-8?B?RDkxVlMzUEhyYUs5bjBLaGZ6Mnc4c0NuekZVUTg1REowSGt5SzBzdFY2djNY?=
 =?utf-8?B?Rld5TVg5VTdCcXZsRVcxSzQ0ZWM2Z1FKb0d5U0JUNCtZRlF1cGkvM1N4SFVQ?=
 =?utf-8?B?RlZYUGJlUWRlRWRrMUM3UW5wdkphUEcwLzNVOXdGeVpTdTFuWWtmSjRIYVEx?=
 =?utf-8?B?YjR5OGIvK1k0bWtEeXJ0ejE1R2VQRHFETGRYU1RxS2pWbHhIb1hyZU5YbUcy?=
 =?utf-8?B?REZ5TEd2Z2ZRdmt4WVh6dnVzQjJlVmdQTlJucjQvZlJWMDdMRTdZWCtTWDk4?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5JvVzORA/wGdT6ZCKRl79E9q+khmvXAcj3Tu/IvDJ5CzuXTC0Hjb5ww8z/y6pGH+XgRAXewTzKZkZ9gBVXwqPf0faxT60uYSSgY4dQPvU+Fdh2okTaL7Qhhvw3TI1+roF0onwasohwHhM42ngUEHZE28qCZfZ6LPbBmOQ+os3DJtg7BHjqvEbtzUJCW9Ajbmmm+QYgkJeKg1gRsln8rk12XbT8Qi7REoHGGWH4Ujg6Fxhw6g8Da1nhR/9DXeavZNOmuep87uGTkV5mlsSYarl4JqSY9bCnzzytOyiUDmbU8cRxmY5emBolYpmXPbe1OBsn4WqrdEe6v/zIo5ZtAJ503sGay0Gjdn8Bc67qp6PyNHryP4ZGRqUq+lqKIBgF36qfiQUK6YK6D1kzokN5SK/qtjCtHDlxHm2nbleHKKqFAC3qzUNXMWAxjHMedv3L6FRlbI+J7PedUHyzwNHkmw51NIDjV4GxAlA+oaciGGeXw6mUhgmc/vuU7Ul5QKqyKKylSf1qrZUkbkj4GykKLS16Mcmluunz4gcdLfD/GzpmvsBJwm1Vqwh1bzgvencpHMlA0qxTgbjZc+N3V1bkx3H7JAotD5P3ufFUcGDfxXG/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c593a0a-8bc5-40d3-a18b-08dd316e406a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 11:59:35.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUfZR3fboLdDFqwXejwuJ0/UzObHO+MQPwamI6bzVoxXn3AeIB25HDcCXUDh5/VCTAVy2m/0pW0KxBTf4xrT9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_05,2025-01-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100093
X-Proofpoint-ORIG-GUID: y1-ageGjuyUvLTiAiUuqCW4aY-OK8Jc8
X-Proofpoint-GUID: y1-ageGjuyUvLTiAiUuqCW4aY-OK8Jc8

On 09/01/2025 07:54, Christoph Hellwig wrote:
> On Tue, Jan 07, 2025 at 05:26:36PM -0800, Darrick J. Wong wrote:
>> "I think we should wire it up as a new FALLOC_FL_WRITE_ZEROES mode,
>> document very vigorously that it exists to facilitate pure overwrites
>> (specifically that it returns EOPNOTSUPP for always-cow files), and not
>> add more ioctls."
>>
>> If we added this new fallocate mode to set up written mappings, would it
>> be enough to write in the programming manuals that applications should
>> use it to prepare a file for block-untorn writes?  Perhaps we should
>> change the errno code to EMEDIUMTYPE for the mixed mappings case.
>>
>> Alternately, maybe we/should/ let programs open a lease-fd on a file
>> range, do their untorn writes through the lease fd, and if another
>> thread does something to break the lease, then the lease fd returns EIO
>> until you close it.
> This still violates the "no unexpected errors" paradigm.  The whole
> FALLOC_FL_WRITE_ZEROES (I hate that name btw) model would only work
> if we had a software fallback that make the operations slower but
> still work in case of an unexpected change to the extent mapping.

Christoph, Do you have any other suggestion on what that software 
fallback would look like? I thought that what I had in this series was a 
decent approach, i.e. auto-zero unwritten extents, but it seems not.

cheers

