Return-Path: <linux-fsdevel+bounces-24052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969BE938C10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176471F21A8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F016A955;
	Mon, 22 Jul 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BM37ZTH3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s4jyH17n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5616190C;
	Mon, 22 Jul 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640525; cv=fail; b=Yzh6jYy/y6PyvpwclwYyygTnLqdBx7K6PF2wKC8ecY3+/wm5DQj7wg1p6AW4zMoRpLtMAjDldTkSHDfKhvxSxLTWuvF0pyXOzXH1R6laz5XkoINzJtTr0iF4KZYv3LALmiMR/ShlT2REttsiqA8CsHUYsvcO48+QVFi1lDihA8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640525; c=relaxed/simple;
	bh=QzmmPUaPc+ZiuN0QoKOU8SODvMU8rA4RsVgH113r9cs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EyvJx0uKswh3Bt/sXMOGeFE/J0ncU7B2/riz5rZ9y/RG92ffU+glc1s5CesWnkwh9HSx79r6XRRhCv5Jy+b6JeXBp802JHi6HRhExATfmmk1/S7a3uqg8TBWOjV9+/BhVxXIhxFYmdWUsT4tIssy8ha5BmPloq9reDSzxFBOJwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BM37ZTH3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s4jyH17n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7cvje031933;
	Mon, 22 Jul 2024 09:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=3uVx08jD9hVMJA0TlBh+YSIDEuI6bL3dObUNFqHLEmo=; b=
	BM37ZTH3ymUUREq39dotXcau2Zgya/4kpxUyfprAc1/o2jLFuhwZZeYdHAf3MuVY
	YOynx4NlKCVUwDF984vW1TvXMfuaGsq9ZMtdRkFi3CYmaRRdP+KbaVYLlxYpJ9iw
	8EJsTzFNA+e1Ntoq1xpOdQsLMP00xYErw5LP1igFyet8+mxkEMZJNtwJUCUkgYSI
	PN+bx8gAvAReDNprzU9dtL13QxPCw5gJayczvVdPPOBPmOl9vBTFg5IVVM5T9q+y
	qvDG6VXwidC1sbLQh4/K7XF/RZPOSbiHNaFJSVohkBfEdLikREOzNkymCOHS0M1H
	NbRhGb5AKIeWCBRGO0+OQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxp92sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:28:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46M91jZg010124;
	Mon, 22 Jul 2024 09:28:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26jpv72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 09:28:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0sIWeUlRsYPKdfAO0PliRpRn03aV0el62MvGBB30ao/J8Pi6iuSEd+DJxpsLfHTF5L8SZlGgFr77aUTXkq3HBOCFSQl4PH8DJz1GAA8erZGiSf+djk3yG2b5qp43MI6YVTcJW+rKnmdeLHi0MewJsTSFoSmUGzz7TO6YCzeYLkS2BpVZx2eOiA2mcBBxpNSUpaz0nwyJKWYQaFCp/hzuMKnDe4AKDIsFgj36Bpb9TZ61THUKpfkaUITaKwJdA00yirjF5Zmf2E9rtA83z8/RmoCy/qrHOFjhHrCACWEQlq+hpPXNlKuaz8rjwvGATGeHmQP9l8jCog1uNW0oMvqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uVx08jD9hVMJA0TlBh+YSIDEuI6bL3dObUNFqHLEmo=;
 b=DylgL17HeUGI9fFM1vJNErz23NHEvM7UnQSFWeflupwRE2BhHuMTpWqkMJoomzuuRj4Uvwz0jGqu2FRMQv86PH7o+Ynm6l0MOfQgAIdnTQAzYm9QPn9HxglW22xx9k0fH2GhSOSsB8XVYIPXA7AH3hMgGYt8D+D49LCOfpYYgipt4EnNhr40IY3Wy3IchqXBvPWjgjaxaAPrxALccWIz7PRH8NBrL5PsP/2guESNg/hgD4SzQ6jrfdJtseAOUE5H//8yB0XuIb5WpDGJLlCzXjoUUmRO+IBAryF5HBmwfJHYHI1waIXxOgkQdTI8Ry4NJ+rQApYjOCPqkcbIVxn79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uVx08jD9hVMJA0TlBh+YSIDEuI6bL3dObUNFqHLEmo=;
 b=s4jyH17nLzcHY8WRIZDdwF/LcPpm+dQ6IHoeU+Oj3DUhmpnBUHPlC6uQ0uR5t0+9kCNbHx4DJC+zDMyslVGZP1JoUYZxwevPUvx/eVOZXJZu6TIRu7sHkb9HAP264ZOIshd/u8VuD0W2AONniVpUTjQ/Ma5Ny3CNaLS4yeipM+A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN4PR10MB5656.namprd10.prod.outlook.com (2603:10b6:806:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 09:28:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 09:28:33 +0000
Message-ID: <f20a786f-156a-4772-8633-66518bd09a02@oracle.com>
Date: Mon, 22 Jul 2024 10:28:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
To: Rich Felker <dalias@libc.org>, Jann Horn <jannh@google.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20200831153207.GO3265@brightrain.aerifal.cx>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20200831153207.GO3265@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN4PR10MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e3c31e-577b-4e86-1256-08dcaa30a829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3BZNWRZMkRQZmllZ3NlR0NmQ1FUVHVNSHFXcGNpSkNCOGQ0QUxEY1Y1cXpt?=
 =?utf-8?B?c1BpWXFobzlqcDZPRmROeUp6OTJzSndOSXdtbTI1VU9uempzOXpkNTA2dDhX?=
 =?utf-8?B?RHRCZklsUk9xTmN2SmV4eXVkRHpsTWNzYVpHc1lJRUgzZlQ0dlRHM3ZhZFMz?=
 =?utf-8?B?RkVabFVOMWp5RnRSTHRVNUlhdzVxWWFtR0xmUFJXaWRRcmxvcnFyaDAxYjNJ?=
 =?utf-8?B?blhvNDJEMmduWndjYVZ6V0V6NitkUFRkODZIVUxvdmFYekJTRlh0Q1dRN2Qr?=
 =?utf-8?B?dHVOTWNFM2M1bVFnODMwT0NGQTdNMk5xUS9TcFpablMwa3hqQ1pheTQ0V1Vt?=
 =?utf-8?B?b0N0NGJoYzZvUjdXcS9NU2RGWENnajlPN0JhQ1pxNytMMmp0Q3dldkhuQ0VG?=
 =?utf-8?B?L0txNFE4SzI1VFpkNm8xNXZWQkFhMjFndGVtUnZFSXJCaEsxNU9qQ054RXpx?=
 =?utf-8?B?NUE2WWNLSFNUMUx6UklCSU9LTzFZWFl0dWZRUlAwUVdPMVhXUVpvdXlaTy9S?=
 =?utf-8?B?SjBSSzNlSnBKZTVCbVkyWmhVR0o1THNPVTVzemt4U0x3bGpQa1kyZnBVK21I?=
 =?utf-8?B?RG1TQmVxbkloamJyRkRXNjZEN3Baa0FqRjNqakZDcjBUYW0vbjBmVkpQUlF5?=
 =?utf-8?B?VEd6L01KcUlobDB6TC9sZ2U0NXduR1g3VXpqWFR5NDBkWGF2Q2xMSWNoWWRG?=
 =?utf-8?B?by9sTTRRNUtWMDRtWDkySDRrSFVJSXZnVmZ1bHp6UXMzVmpzSlpFcTQ0ZHhz?=
 =?utf-8?B?ekttTGxiWUlTVWJzS21yeFZZbFNKQkwwU3BmbVpKK1BIZ0cvaFBrb1hsU00v?=
 =?utf-8?B?Ymo1V1dncXBnZTRVNU9EZzA2bUpRSlorZS9ZVys1Q2FRM0p5LzhIWEpCalkw?=
 =?utf-8?B?MWR1RUZTQXZ4b0xwTGVVaVFwQlNyeWpnK2ZvemZqc2tmOVd4NnZxRXdhbEFn?=
 =?utf-8?B?bEZ3VHBObzJSbSt3TDYxZ1FuZ1AraXpVd3RxMVBYS01lWXgvU0xKTGxXSjBm?=
 =?utf-8?B?TDloSEpmeTFZM0ZKZ256L3BUdWNEM1FVMld1TktScTg4MXhSVy9sUFJnVXpk?=
 =?utf-8?B?Q3FMTi95SXdXQnNCRmc4T0Z2c0tWUC8xckV4MHN4M1NHb1A2cFZxeVVrbGZp?=
 =?utf-8?B?M1NpdE1NL05hU1BRSFZva1F2ZFBmZitSMnhWOW1GRkdReDY5MkdwVXJjeTdT?=
 =?utf-8?B?UDFCcDBjcExTSnBCUlNMemwvYkxlYjNMaE85THAzQmpvQ2s0cUlFODFmeUFU?=
 =?utf-8?B?RGJRaUhQTGZ5djdjd3FHZmhybmxPajcxY2xzbEJxSGR2ZlNXa1N5dHY2TDZW?=
 =?utf-8?B?OGl3MktscWNtSUxsTlZSMGwyTU12T2IyeXRMaVlaRTlIYnBGWm1xMU8xVExC?=
 =?utf-8?B?SnJVbVFzbUJuZC92dW80alZyL2d3bGFWTnVZdUNZZVZnWXYvbUdIdWNoR0pG?=
 =?utf-8?B?WFNtMWxtSllNZ0xSVWJyWGF2dzZRTTJPOWo5MmJRVjBJaVZmbXJjM0FmZWhY?=
 =?utf-8?B?Tk0wMklXbGJlWFc0MVVXOHZyTFVTSnZaYkpDdUxkTFRyWndrd0R5RmlhUnZl?=
 =?utf-8?B?OTQvczdVVjFHV0hockdPV3Y3U2NLVGhRdGhjYk9wVFFnZ3U5NktGRWtsMzNU?=
 =?utf-8?B?NFhsSGFqeXZaWjdhTlBPRFF5cWw1OWtWVWJnNnJyMm4xTTBkeVhwRm5RSVRw?=
 =?utf-8?B?QlJoSk93QW9HOS9rRXlwVlFZdEk3bWswUHpnR3VHL0ZCSEw0NW93a0FjdDlZ?=
 =?utf-8?Q?cdrB4QM6U7o/MYhIc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTR1VkFWamJrc2pEa0VzZlB3TERvRlpZZUhrWFFYejNGRVFUdzE5aERQZVU1?=
 =?utf-8?B?Z0tsSEtxVXZSOVJLUFV4R29iM1UwSWRNZCtYdmRhaldvZGJIaCt0QWp2c2wy?=
 =?utf-8?B?OGwwb25KdzM5TDZiTVVZZmdsbGlLK3RDMGJVd0wveS9Pbm1HYzd5OTl1eWJC?=
 =?utf-8?B?am9XQVlmazIyQ3RIS1BCSk40WkxLc0tiYWlmclBxU0FvekVpc2dxc3pNR3ZP?=
 =?utf-8?B?YjNKMVBiQjlPenhFOXFtOUs4eFRGSTRkTzV0aGljY3NVVUxoMEkxUXpTV0ZB?=
 =?utf-8?B?OER6Y2dwSG1FYlBOR3hOdFd3V2lHcmZMZFZLMFJyN1hDallRRXg2alhDcWVX?=
 =?utf-8?B?ZVF1ODl6Z0EvTE5ReU1uVWtSeGRTamk2SDVTT3VaNXVnNFErRzBCMlA1Tjgy?=
 =?utf-8?B?bXpSMmJqQ1RGcEtTaXJpeERNOGtzZDFlNTkxQ1E5NWFnckxNZXl5b2F3SThm?=
 =?utf-8?B?b09BaEV0amJncnlVbnM5R0ZFeE1XL3pyUDcxWXNSRGtJRHRPazF3bzB5ZmQw?=
 =?utf-8?B?NnU3RWlTckg1YWhCWmJ1TzNyeCtvM3laSnFkOWhmbGJRcEFtUlNrTko4dlMx?=
 =?utf-8?B?OWdRdURKenE0dXVTaGRVUlR5ZWtrTjd0NCtJZUNSVG4xaHF1NnVKRjRhOTlO?=
 =?utf-8?B?VnMyVTA4OWVMOEYwdWROU25DaHBMMnUvSTRpNVJOVnljWGtGeXU4NjVoRGhm?=
 =?utf-8?B?c2M0UWdKRmxmNkh5WS9TWFNwTkJrRzFXeC9lMW56MFdqQUdPdjJ3YlQvb3VV?=
 =?utf-8?B?T3g1Q3dIaEl1ZnV5cXBiaHVSelVaV0dtZXFCbTZ5bk9RV0U4MzZOUlcvT1U3?=
 =?utf-8?B?Z1I3c3VuSDAvTU9KWGl6N25YcWFmM3ZsRXpKMDVlTXc4QTNhbG9FbVRLRmRP?=
 =?utf-8?B?ckczSjBDYTgwakwrV0FUZ2taSVQxS0ZJejgvNUo1TVpHdHNtSkxMNWVxa3dt?=
 =?utf-8?B?SnJIaUpxb2xXUkd2ekNDdEEyWDNhSWp5NXpBcFRXL2FZTGUzc3h6eVFtOFJT?=
 =?utf-8?B?MTJHUnMraDJuN3lIRDFMaDBSbDByK1A3RDk2Z3ArcFYwYkhMQTNieGNEbXcz?=
 =?utf-8?B?VTArdjg2c3ZPSDRHUW43dnBCUzNxOHIvU2x0YSt0OGdhVnk3dFd4cTFhNzVF?=
 =?utf-8?B?U0wwZGY0dEJuNHlTM050MTV1OG1vZGkzcjExM2wvakF3UnBxQVpUSlkxUnc0?=
 =?utf-8?B?OHplTk42UGFHdzhDczJMVFIyYVZjL3lRTVJzZDRrWXFQbnJualBvamJrNDlY?=
 =?utf-8?B?YkxySVZDZlN4YmEvejcyc05NWE1QNUtTNndkc0VlWGRBN1h2dm5RSVJSOHF2?=
 =?utf-8?B?T0RDQk5CUUswUW1iOWptN2lySEpyMW9KdW4xYVc5VFcxOXBhVm1XUzl0WmZ4?=
 =?utf-8?B?THNpSWVDcW5QY3BNV29heDZzYXhmUHF1TzBRUWo4dDZCclB4Y2ZXd0w5bkVt?=
 =?utf-8?B?eE1QK085aXlnVk9BUzJ2RmxydUJjdHlJQmZmT0o5U0JWcmpGbk1maGFxaWNT?=
 =?utf-8?B?VkZYcWVnSlRlQVN0QWNXTjlzaHl3Y2hBdGw2cEpXa3JpWmJMWFdpMGdzRlVO?=
 =?utf-8?B?WUxtMEZXeUpYYWxUNVcxOThRZWZPalJQYzVVZEtlU2JhcmtBZG44ZjZNd01q?=
 =?utf-8?B?U2c2ei9uOCtpWTlxdkpoWHM4NDlXaFM4VlhaaDJUSC9iNG9ucE5qR3RiYkx4?=
 =?utf-8?B?SnQ2UnA4QzNmaThhUEx3Q2duc0ttdjRxaHYxVnR1ZUxFRGtEYk95NmdLSC9O?=
 =?utf-8?B?V2JHbFV6R3hYOVpzM0theHBSRk9HeXUxemxTQ04ycHV6c01EVE0vcDhUVHdr?=
 =?utf-8?B?dEc2MDlORUF6aXhxOWEyVHE5TUpPUGxWdm14MlBpSDdpWVFnMnZ5cHk0UEtS?=
 =?utf-8?B?K1AxNWtKTWtRUTNxSjFFODVUaWhuVjcxMnRPRXY1engzRXBMQzJZUHJsNmlw?=
 =?utf-8?B?ck9OYXZBUTdpYUN6VGk2a1BnRzRrZHE0aDl0NkEyNXRsekh6emd5MHcwTTZk?=
 =?utf-8?B?UmI5MHl4dkx4QWd4VS90UDZZdkFQTElqeXhWbE11dExhaTBtWVhkNDdIWmpF?=
 =?utf-8?B?ckVFbG1IbmsxKzVuOG05NUZMK1BVSUY2VkZBUHU2aExXSzlFbDN1dFF5S0FT?=
 =?utf-8?Q?yLXfbaHWrjVjneNXXO7cQn1X4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sWufVLbxqmKoCtFJOKoQ4+0OtCL8GP35FRY1T6UqcQ72TANX9IOHDAhFmEW/vMdFHzE4RLzmdRJQkxGLWJvDk6L0pUVdf815ek8BBY1B+V6DD90Z+pfqh3KKWrjwrJQCrGq2o3sZvaLKsCWwSPwu6TeZ82eG+jXk5KnQxsD6Fc6K48FNn+CM2noakti4vR0qXNq486YZ9JLHMwbx/lSBy7enwE9qNnd01lHq5nj3mnJnjGwj0xundF1vadKJ2nrpqFFqcNF6UbqhL3VTbCcoYg5zZUUdhJdrBk2vFO4kXlZ+fk7eQoXr1ca3l6wJU+3IcaUBvFXx4UYzIjgmeOabsN53nGefyJ+w3wSL2fweRgWCzELSNlJrgr6fckEzaOJhl8A29Ulw/F7as7iXfWYI4JPI8x/PZh4nNDVwMLCi4Ct8DGrkY+5WibGhFbi1ZBhQmRit/0F3D2m1T0UE550TgeloxLkHRFESDqq1QWacclAhY5txW667oMAzqzXPU8zzs4sTjEt80XDYcHTRF/f903YORnnVZOvJP+pLxJMAAUHN+wbF1+ZcIqijrnOauZeQx8q0/pestXIrJ+OeDRqFmXrOmE83VBaTL2rJMxPxcwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e3c31e-577b-4e86-1256-08dcaa30a829
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 09:28:33.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApodtGQJKK6eBZOPCHh/SO82nJKwLZqpOO5yymGqSxPYGqgFpd8bOIPRMgRDuLbLqLNOCOXRO/6PLuhdS7v6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=992 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220072
X-Proofpoint-GUID: kH4KL5_eWHVjXFQIBNR9qMH86uJdvIpZ
X-Proofpoint-ORIG-GUID: kH4KL5_eWHVjXFQIBNR9qMH86uJdvIpZ

On 31/08/2020 16:32, Rich Felker wrote:
> The pwrite function, originally defined by POSIX (thus the "p"), is
> defined to ignore O_APPEND and write at the offset passed as its
> argument. However, historically Linux honored O_APPEND if set and
> ignored the offset. This cannot be changed due to stability policy,
> but is documented in the man page as a bug.
> 
> Now that there's a pwritev2 syscall providing a superset of the pwrite
> functionality that has a flags argument, the conforming behavior can
> be offered to userspace via a new flag. Since pwritev2 checks flag
> validity (in kiocb_set_rw_flags) and reports unknown ones with
> EOPNOTSUPP, callers will not get wrong behavior on old kernels that
> don't support the new flag; the error is reported and the caller can
> decide how to handle it.
> 
> Signed-off-by: Rich Felker <dalias@libc.org>

What about updating the linux man pages for this flag?

If someone gives me a description of RWF_NOAPPEND for 
rehttps://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man/man2/readv.2, 
then I can do it.

