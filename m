Return-Path: <linux-fsdevel+bounces-48023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA45AA8BD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 07:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AE53A7FD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 05:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17A1B6D06;
	Mon,  5 May 2025 05:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qBnndwyq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MAPAEImI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82721A937;
	Mon,  5 May 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746423958; cv=fail; b=A4SSna8p+/dM3v2LV7n9LNEU/rIQrpiw+GojNfX5X8BXqfIfkzkNGTyTv0YNuWPfmDKnXg4QVn4QPLuF4zmrRiq8hzOZgVCMVEABdLTg8JYzwG8+JRD4HKSrI24OGP4GgAWM3PkRPvPZ0petGlOvF1k/mFlL75kZMGj+eIm/+fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746423958; c=relaxed/simple;
	bh=RSkICFMv1fg1LYQ8N1e+zB6BQJQfkZVBiwHb9bsGuwI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VQ+5Fnp4aSvAShU31jGzGzgmdDXH/yCpIerGi/HAQkq0jDjErQL7hK8QDvit97TnlniLTOrz5pXikWygkvfswy5w5knk5gEMSi8fEJqI/Ah1Cl8jUd+E1urGaDmhI/aP4s+esBohJ4Es4ED1T6FgoyRTtc6qIX6CSuteijTfvoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qBnndwyq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MAPAEImI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5453trfC004245;
	Mon, 5 May 2025 05:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zkn20XFGid8Wq5LSf5bJzvK7jHKimwyFYa5zgF+1hZQ=; b=
	qBnndwyqAPFRT0I5OxTuwoY2ND/3sglQvYsSlhasSPXr/CZ81LDPK2kI5m0X2lsB
	EF+9uKa7qVOLnp0uk3L5Es8LJxV91ETrq0tsf+HEGojWQw6vcNY/2H+b8SQdGsoi
	R9XZMcNwW5itTeaeLXwSWYsnQ6tFJ3ZNBmD2mLGW7O+qzM57BEnKV0Z/173vdXX3
	TRaOFDSHnAk5yb6q2phWiiHDGMHMwTErI9InY0vdOQHUkpIKEipHHrHGH95Rtp54
	C/sQTnmBio9vQmjzPyIgJ9Mmg6BXW/m0iRbd9dk37sZ2Ggv5w0hrlh1+yAoYkQ70
	8Ut0fLhNyBDyDMaGEuuT0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46en9p85ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 05:45:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5455j7Bi037616;
	Mon, 5 May 2025 05:45:38 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012054.outbound.protection.outlook.com [40.93.20.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k71ewg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 05:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKcv7NtLp62FladaCBe2V7eB1Gh5BP8Pc+Zil6YMgEdRbePpZQ++wZPcdZ7QFp7t2wDrx6GiUZlA49U+z+eXnR2gvzoaZ6zXEgkWr+0AW1vrerGWvTnrEqwXhQ/+YjVjaJxiSsjJnYFSobm6x13upUIjFDqaF8Q99uSjJejX9dAK2yCBjji8jwgSvcJ/8wTrD4t9x2FpbWB4pSYSC3yJ7Zp1WVQakqC7I3y1n0OLRlaevCaebfUJccKPVwJKVhK9RrK6FxzBFlpxKYdx+GP47DU3dn8EDiHT73N/xUcWUzJgrDTvVSmjw9FZdB0ZwM3HX0eyJFV4h9StPpFMBfk4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkn20XFGid8Wq5LSf5bJzvK7jHKimwyFYa5zgF+1hZQ=;
 b=O1R2m+iG5WxtHqBnB9Ri0FYNYymghElX9WtlDuoaJm935QpOXi7xsBLGjS13/JQDTvEDrPXgdMGOY8PtqwbRDZa2uz9jBxXf2q93TKUNkBMa4lr44CHW2qnkS6C0OMu1BAaY3HUma5x6OOF/ie4e2q6HzOMRSJJsMeeObYgvSfWiMaNW9Ua5mvHl8tvkptEgPMbiS/8ueAzgpT+sYzuZ5/B3pGxz9HECQfP+YPAJfugzlA8hfbmS5Xnjxu2bev7yRnOhjvybE2hWdWVk3uRyUdXgIqwfzlVCzRwwWPdtkAXLmauBfQIqSoG6+kAEdcVBRNnvO87eYib8A1iDdZWUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkn20XFGid8Wq5LSf5bJzvK7jHKimwyFYa5zgF+1hZQ=;
 b=MAPAEImIEYeL5eKVsXc4zRNoituGfbQ2235JYGb0METEuW62DEqTVIbE5IjmwkCWMfdYA9qpQm7PkT9QrHqICVW/Hq4KscTP3dmD6b8nlCeMh2US4+/8VhkDUsF93pyYo9rsqUDFFabmT43I7M5TlS8Wp6XfzRHjOFqMiIO/KC4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ1PR10MB6004.namprd10.prod.outlook.com (2603:10b6:a03:45d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 05:45:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 05:45:33 +0000
Message-ID: <1d0e85d5-5e5c-4a8c-ae97-d90092c2c296@oracle.com>
Date: Mon, 5 May 2025 06:45:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/16] xfs: ignore HW which cannot atomic write a
 single block
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        catherine.hoang@oracle.com, linux-api@vger.kernel.org
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-7-john.g.garry@oracle.com>
 <20250505054310.GB20925@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250505054310.GB20925@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ1PR10MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: a187f266-a9b6-4110-1d1c-08dd8b980d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlF0YWM3eGpFWmg0a3FXY1l3WExkOXdMaXl1TGJPMjdnTDdYSkxMR1gvVlZV?=
 =?utf-8?B?aERMcXdyeW1kWlZkUGVTc3RSTmZES1Q0YW5Kc3piSER5R3Rsa3lhVzlFS3JT?=
 =?utf-8?B?dE5OVHlIWGc0alR1WlkrZnppd0NzY2pTeHJvdUdqTEJFRitXWWVrOENwRzlm?=
 =?utf-8?B?cUFLOVkxVmNrbUxBalFSQUpsbHZSNjhiZDU2anZubU5SYWljd3FLZ3NwNTV6?=
 =?utf-8?B?QTFEUVJtdnBwVlQrZEgwYWJlMzR6NUQraFpFSjV3Nm5HeEovaUY5dWd6T3lj?=
 =?utf-8?B?elZwdkgveTBXeEk2RkJNYlhYY200akxGZVNVa2h4MDFnY2Y4ajVveGI5ZlRX?=
 =?utf-8?B?YXA5bzhOSWkxWlM2a0NqSTlUVEtDdkZpejZCSzJPeTZ5Vzl5U3lodXJQb1p1?=
 =?utf-8?B?bVVhbHJHNlRJVFBmZkFRNXV4SDdHTTdENUhjMm1xM0VSakxWS0ZhSHE1dXRN?=
 =?utf-8?B?ZGxRVW1iekdUYVZpcHhaVWp4d3o5ZUQvOWpmOWdEL2R1VE8wcGJnY1hkVGZm?=
 =?utf-8?B?MVBtZ3ZqWmJLTUp0Z0JUbkhIWFZ1a2R2SFUzVHI3TmcwcXoyZytrdVpsc05v?=
 =?utf-8?B?YjFRdG81bUV3ZDY4U3E5OWFVNFFNZVRFempwWlN6Zm4zV2dacnUwRWFMSmIr?=
 =?utf-8?B?dmlKWmkzVDl5NXlzVk5kaWhnUDBqSDkyMmJEU2h4dlRGM2tFSHlPK2N1eVcw?=
 =?utf-8?B?Z3N6MFhDeS9sT1FSYkdWSmxYTW1zemlDZDI4aHgweHVRc3J6LzlhUGF5WEZ1?=
 =?utf-8?B?TDdKb001L1d5SXRsVHlHUGRPbVZnVmNPSVNuWVl0dm5oUGNIYml5cTFoOEll?=
 =?utf-8?B?eDVzbFM0bUN6bjY0d25WcjNtYXhvSy9qUFJtYUhtdTZtVHJQeVpCNGFaUEpa?=
 =?utf-8?B?V05iMUNENi9yeDRxeWFVN3JnM2U5ekRZM2kxMXQ1M0ppS3hpZ3FhV1dpNEwy?=
 =?utf-8?B?Y2ZLSWVJUlJITWYxT2RJQ0VrU3lRbDd4NkZwK0g1Mnc0dlh4ZHM2MldKVWRi?=
 =?utf-8?B?SWJVU1dpaWY5Ty9CZy9ab2dQOXFwbU5ydDkyRW5USnkwbFlQeWlodFRqTWNX?=
 =?utf-8?B?N2JmRnczVG9BS2tZcE5IM2lxT2EwbGZOSTl1OHE2R2MrOTZnZmV1akRxWUI1?=
 =?utf-8?B?YWlYVGFwU2pvRE5yazZaNU5sZ09DK25ZNVFnWXhWMGVQUys4K00vUm5UbVRm?=
 =?utf-8?B?Ry9ieGZWbnhQbkt3ajJjMGNvaWdNdkFzSlpkY3dpV09LeCtHTjhQZ1hIdmRK?=
 =?utf-8?B?YnF5eklLdVFTbjc2VFlRNGl4L0VWVzBkbXZpV1hsT3Q1bUEyVEVrWE5xMlU3?=
 =?utf-8?B?WFk4blhoWFViL1BXWHVGbEJkcWpXaTN4QUlLV3J4S3MyajllYzB3eVlWOVVi?=
 =?utf-8?B?Uk9jMEtQVEh6QlBKZmE2T2U0NzgvY0Flam1mOFYrcHMwUjNINlFES2F0RW5T?=
 =?utf-8?B?T3NySk9ycXZ2UnIzVFFmYjRkUlkyQTRWcjN6Z2Q2ZXVvaW15UVpaRmhiTnFF?=
 =?utf-8?B?VHMvbElOMEdNQjlSVUFPdTA5ejYxdXh2RFFldGtETG9IcTE4OURvc29PclZN?=
 =?utf-8?B?RGF6eVp3eDNWcThUTFdoRTVxTUtzN1p6bmQ3cVlGNGU4NHRuZFpsZ3VpcFBU?=
 =?utf-8?B?TDFmTjR2N09SWS9oNE9nejNHSHRxaHJ4WWFYRXFLMFhYc3U4eW9GbVJHcHQr?=
 =?utf-8?B?TzhCTWkyeC96SlpGckNBUFI2a1AwS08xRnhKby9pdXpXWkYweWRPYnFUUHEz?=
 =?utf-8?B?ckdDbHZuUU1NamhpMGlEMVZHMFZOVmVvNTZ2Z0xBTUkvNWFUanRPaDZZOEJw?=
 =?utf-8?B?bk42VFcvdzVCaEduS1RCRlFna0lsa0lTcDdpSkk1MEFnOHFIMDVLVmxyemV6?=
 =?utf-8?B?MFVPUlYzakRmT2ZGc3JkTEdSaU9ld1FobVpMRGwvTHdzZ2lURGJ6S3lmN2xt?=
 =?utf-8?Q?SIuxcgw+LRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qy92SFNIS3A1b0dSd3NNZEpLekVqNWk0eE5HL0tTOUVuZUxFVFY3R0hKT0o3?=
 =?utf-8?B?djJmY1lkMlA2ek1ydnRqbGtqcmorRzRJc2h2NEVxQklWOWpsWmlscGxxMExr?=
 =?utf-8?B?am1CNHBwRHFMZ21JVTJudFlYNFNkb21XZTVLUHdaUlQwKzZtK1NMdWRkdllS?=
 =?utf-8?B?VzFqVVo2Y3k4QzF2S09hWHNKMXFTN3p4d1A4aG1FTVkzVlhiZVFucW9oL05h?=
 =?utf-8?B?ME1LMW15bmtFdkJKeXExbFdqMDNrL2c2NUx0Tzl0SDJ4cUpJSHFNQ2ZFNmNn?=
 =?utf-8?B?c2g5TlAvMzdnNHpiYkVMY0V2dGIvQVYzWFJsNlpqNG1hTVpkODZ0Qm1leGpQ?=
 =?utf-8?B?RzVKaklrN3NEbk1NV0U0Y0t6NGZTc0VTV1dEVGwzV1JZRVFoREdqd3M1YnNy?=
 =?utf-8?B?WXQwQk44RlhxbWhMbDBLV3lJNzdoZk9XbkI3bnJyRGRtWDh6cmVyT09FZGV4?=
 =?utf-8?B?bUtMdVZnR3Fid0ZjYjJHbGZyT3U0eUlrWlhUeXhoTFdHRktPN0ZWUW1icHZY?=
 =?utf-8?B?NG8rYU10UnlqNUszRFVlQmNwQVFyL29hSkl5STV6VmU5RmR3dkZoejB3Z01w?=
 =?utf-8?B?empCckM3Nmw3bVFEd3VGRUxUdys1Yk96ZlhFU3k2MEljNTN2TFo3RnVuenp3?=
 =?utf-8?B?Nzg3RDJxWEhlNVRxRzZ3d0owMFczRXREaGhOUW45bTJUWVpTVUlUWUhtbEth?=
 =?utf-8?B?R3p0TzBtV0todnpZcWQ4UFl5QjhyOEZ5V0k4Qm9ZZzhVSU9VeHhneXRvaVFj?=
 =?utf-8?B?WmU0cjZMeUt0REFYK0NXb0J4eXpHVkRqU0pRejFPbXFYYnJPZ0YxRzVzakpr?=
 =?utf-8?B?b2JhSThlU2pJYnFsTHYwOXVsVWNidmxIVDNLNzlMM1F2aGlnMm9HbFhETDZX?=
 =?utf-8?B?K3NPS2h0TDhsdE9JR2ZTSTFNTTJSNkZWRHlMK0tadlYzS2V6Qm5DUndWR0FT?=
 =?utf-8?B?T3dlQzFCNlB3RXdqT3FLNytWNGRHT093eElhMWF2dEZjbnJVNkR2R1htc0Nn?=
 =?utf-8?B?YjU4bTNYVXJ0cjFYOENPYU9wZGI2ODdvRVY2dTZWT0liMTUwUlV6OThWUncy?=
 =?utf-8?B?T2g1bHZzWjlmT0RHaUhjN1gybjVJdXJONDdTSy9sZUN3VCtEMTVxWEFTbU9H?=
 =?utf-8?B?VnJ6TDZVVVV0ZXJaeCtTZWdVVjJjeGdNRGVqd3E2ZEZzbG85aUJyU2RTN0wv?=
 =?utf-8?B?MUlsQ1FycUQzQjdTZFNGRUl0K0hkNFozSmJZS1J1emhMUlRqeEFKTEkvVlFD?=
 =?utf-8?B?WGxnblZJVnVSNytLbG03MkRzcFpDcTdzWFV0SnBra1pnTjJNWUFPNkZ0b2Y5?=
 =?utf-8?B?WXRZcHNVM1BJMHVMRk9MTVJYejZSTW5iaEpNeUJObVRqS1I0YkorUHd2SUdK?=
 =?utf-8?B?VmcvQTJRajMxTzRiNnpDbzRUU1NDRmtydnE3emEwNGRCSERyWW0xUHVyNW1F?=
 =?utf-8?B?bWZJUmpEMDRic1Bic0dTNysxNTloakgwQ0U1ek4xVll4cmp3aFFIZHhFeCs4?=
 =?utf-8?B?TTQ5ZjhRWFpEYTk4TEVhbUhOVktWY0d1QktQdEdzSENBSW9oN3lkRGJWeXVI?=
 =?utf-8?B?ZE9DUjYzN1kzTXdzeEFsRi9pOGVWVGxTeUdHL21wdm5FZmhnMWYxQjJoUFV1?=
 =?utf-8?B?bmxUdjUxYVI4VFhSU05GdWdJL0JFQkVyUWlXemVmcGoyb0o4amRsd01lcExY?=
 =?utf-8?B?MkRCZnhxWmEySkwrQmZWUFA3TlNpcFV2TjNOZXpoT0drKzBPcnMyVVFNTXpH?=
 =?utf-8?B?UVVMbDkxM0Qwc1g3Y2RDU2MzWG5OUXFucWhXSG9OUTdvclJXV2dSeTB4UGVJ?=
 =?utf-8?B?OXFDWFBBMDQvRFhNUGE3R280eFc1Qm10MDRoTkIrVVdNRkZnL2dCUTlqMk1x?=
 =?utf-8?B?b1B6bUVvb0poNzR6WTJteko5VXdNNlZIM0xBMUN6Snc5ZWRMdkczdktCampU?=
 =?utf-8?B?a2dGUU1UT2NpVW8xTTArOWJydHpUdDBYWW9ZU2dZMi93YXZFdkFTZXBEZVg2?=
 =?utf-8?B?cEYxc0dEWE1ZRC9OVGQyeVFzMVZ0RDJWT3ZUamdzWG1YUFUweXNIK0tDTzBJ?=
 =?utf-8?B?dUZpd1hOaWtIeDM1Q3RTSEJac0crSHkyU1RqS0tYNVU5MEVUOFVHaXJYWjRS?=
 =?utf-8?B?SWlhWE0veThvUTFOSWNadEhPcEttZFh5MWMzeHVHNWc1dkt2MlpWTjk1MmZZ?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	owNYwrvZFz/LoCMtKJW/GRoWdEQ9siKb5Fl5B0QsE1RvJ29VFB7uSd2pe9pqyd6eCS9+toT5Dea6fsP2x5FeI1ox1hDJQdGfdj2Ua1YzLqtslhmyEvEywpND62aQX1+V5/EhZaKG6Z9Ok5vPHhIF6Jwv2HrsUj87uWIXP/FL4Nd4pdazDtts/H/+RSSc+MJ8qaqw1RaOJPYUZXTGoWlsZp2t8dIoN1R6coSDb8RRsryly7rMmdLc6eNf9dwwBkRWS5N91fYRABujjVGnZdsxMVQDjuukUYTw4T/PUk+qFjY8xZ2SdZGLks2wPX5l/oia3ClyU5UoCwO5/9mnhGzWuReNKMznlX0nAtqG63uhpSl7l5o+I9Cq9+L+IvfEUdL6PHYhZBUfVDfj0T8V3loXoNnjsGEY2RbBy/YRweEck+I00NqERPCNP6izRBRI4GR7Q5DuK9PelVvh3b37RF4VtI6+MTO7M+trgsnkJM99dI8n8xrAK7jj8E5yTVxVHPrdwDWBA/DzyOJbZDtlc9lEWvqy7djK+dE+RaI01VTLe7Dxfje/IMFPCr2UxWz02+pnU5f3tJ/o6Mpo2qkkTnCV+oDMyYiQXnJx1wblRNIUiN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a187f266-a9b6-4110-1d1c-08dd8b980d20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 05:45:33.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LACwW3CAthxm1eE1GsWpAmm4G31Tf2fW6Mwbx/UTTBuvKmrbEBU/EdyrdgerRG31cvuSF84DwyU9he6w09leIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050051
X-Proofpoint-GUID: m910Q89DV9d83WTpTg77bpud3xexw6aa
X-Authority-Analysis: v=2.4 cv=FMgbx/os c=1 sm=1 tr=0 ts=68185083 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=tRTZdF1qF44rBJXxvUsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA1MSBTYWx0ZWRfX/VDJiuooBtR7 LHjcEzf/+S6YkDhBO4HiNb5YyMLLDQCmLvCzxLiKzilfsq4x4waOsgo73g1PZJ9wwx51jYXmvi5 tzaol21Sy8oY7IgNhi2gXzAJa/HudR18OWhle3XGlA3fyDGBdlOEnvbbDuQEUW4H8Cjs26UF1Hv
 1zSiL9XoBLc5cqELp1V2eAb+/vqjn95MAyBo6VEwP7fnxGDoeQGSv4SwWQFUOOpFfJsnteJhYPm rQikelaoe4bZv/0nvLKf7O8vWTSVJY8DAOHbd2KipR3BKzC0f39CGnLrmtDG1C7erWyFsc4isWi ApNhVJ2t8LxymWVTupAGfs8ulJRVGDnLafu61g40uBvcnhg6goZ3u1F24JQOJIE3f1Mg8kacCVX
 2S3QjbfZsScRWtYnFM4RHnZNPtgyO+e1TK4X7siKfWOZStEjO98wWVSzCUvnVs0C7J+yta1o
X-Proofpoint-ORIG-GUID: m910Q89DV9d83WTpTg77bpud3xexw6aa

On 05/05/2025 06:43, Christoph Hellwig wrote:
> I think this subject line here is left from an earlier version and
> doesn't quite seem to summarize what this patch is doing now?
> 
>> +extern int xfs_configure_buftarg(struct xfs_buftarg *, unsigned int);
> 
> Please drop the extern and spell out the parameter name while you're at
> it.

I can fix all this, if Darrick does not beat me to it.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


cheers

