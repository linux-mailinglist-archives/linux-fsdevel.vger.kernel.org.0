Return-Path: <linux-fsdevel+bounces-42832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510FA49265
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 08:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C848A3B625A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 07:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEC11CAA74;
	Fri, 28 Feb 2025 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P8fRvx6p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dgZyE8gl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0E8C0B;
	Fri, 28 Feb 2025 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728776; cv=fail; b=iaUFhm+QHr+bfqDEGxdLc5ypjECGFObCx9uCCSqNkJTtu6GdgOD1EQ0GXTSgsgKhHo+cc9Tjva0gl89GvregDoCA+c3QqSJvxJ7c7/FkeIDRu4U/OxRrilw95UIRxHfQYeg715EnDov7YHTVIV2BFSofRpySdmzZgRNrvGt+IrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728776; c=relaxed/simple;
	bh=ZMmdqIfJMQzm/eq8gksDtTMqgjod9gVshY3DzoPHsuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bEeErKd1r7QmVX+1aOJOK2VJWCgeG2OTaxRy/nfE38W/BgaZgo8h/8Qty+vjPwYFTOKH1kCjmlHUdVG179SGFS+8LzXzB4VFfWXsIk5ujdU/B7OfmanyT/dzTHSwvtWiB3mm81FpUcOafLg4W3z6xRqBl5KT4swABWHWzlMR57Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P8fRvx6p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dgZyE8gl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1BoSN032637;
	Fri, 28 Feb 2025 07:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eqwVuoZBTrHbEAP/yR0Vaf4PhHSxXc9rvsQ2b9KCVkg=; b=
	P8fRvx6p39E8IAC/cqbO3anjmYKP//S0DBYHbmwJBvKyBSwrzEX5oZkdj2SKv6UC
	b7v8jLXL7+bM7xCipmXiaeC3M+HfymMjp1Aq18UY7HO7Dzpz98afczbRr8Upvtlj
	qQYg1xpZRKXAfbP8WgY1RGps9tuOKedaBdl6EXVv+nwdHkJgB54Dv1AFVmLysqIZ
	J1NSzAooPoz89BK5Vke7nTgckTWmGG/SU07SxBFcChgvXV2XQ8NuKn5ezEPAdIRZ
	G5ht9VF0d5b/M5iazLMxSpiDhTnRLWMTmqV46WD+mYj8AHPBcU5QaFTanRoYg0TK
	RJSODPI0BhBIWTA2BTIryg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf52dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 07:46:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S5n2ut012589;
	Fri, 28 Feb 2025 07:46:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ehhqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 07:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giWqId1lNFGZpENIJeQzq72jzk9HlGKSzkTpcSlBUxJ0JExcb748YaB8MwES5EzBDvj4PjF8T2nAhvRWjwOP0IXXYYS7hOpGvohWtInJQf1GXHJAi2720iL+PmjWtTdK5nFgYWsRGSkDB6lxx1EbxhjUk79OkK8r5QmSWXEKtav8j2TSVmB/M+mwtS2kFOTlATnG1zorKz0M2ju4wJc4u80Mbed76lO8m2pqvZLne4vPF6JjwTYQiU8/+kHMVF8aPWYze7B2FBYE/iN0UGRfpATbYfo2GJy4nD57rpz0MuZKubUaAcgtar2JosHfcLtGAWbR1f9Pu7512tq+rUIeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqwVuoZBTrHbEAP/yR0Vaf4PhHSxXc9rvsQ2b9KCVkg=;
 b=b0AjRIwT91EpJN5ElKFyaodAHPlJNe1JzwFfS2aNJOzhQnIC3wvDaX65shRMoFumZuC9IBxAMjJowqf19hlFzGPcsZHqykbyEc0N84hCvaJDQbpVhxROewv2koAHW4J7X8L0vs9hnJ9yYY1+HLXvYmb+ueRQbwRgz6eIFvuauob2d9aeYo68eReFhKv5EiTtzET5dMIquYZM5KABALfaaQQDGrbDoLlpnY/uLFGdxIED5mKhNKHfFFOhtIGMuMQFgf+7ntE2KM6hja/080ZgCMD4ecfH1VXsBO4l+iCAjVbirWTQ7C8+MmWmTEO21st50Ele2o0Scl044ti9erd1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqwVuoZBTrHbEAP/yR0Vaf4PhHSxXc9rvsQ2b9KCVkg=;
 b=dgZyE8gl5J0CWzgRMMnGWpqaWvP1oVyl0d8HQEUxW5sH4o8TtIwEa+gbtm2+KSPVeO+VHxBPxtGB4TvxX2nSBt8gNIXCldxiZqkHZSyAhIsY/ACi66eWRUsnRfwvwB2MqWpvJs1UX+EfJfK/XyoeaQusJ0MuNmYCxw8n8NGxNEE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5727.namprd10.prod.outlook.com (2603:10b6:303:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 07:46:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 07:46:02 +0000
Message-ID: <903c3d2d-8f31-457c-b29d-45cc14a2b851@oracle.com>
Date: Fri, 28 Feb 2025 07:45:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] xfs: Add xfs_file_dio_write_atomic()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, tytso@mit.edu, linux-ext4@vger.kernel.org
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
 <20250227180813.1553404-10-john.g.garry@oracle.com>
 <20250228011913.GD1124788@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250228011913.GD1124788@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:10:be::47) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: c893e275-7f2a-4364-996b-08dd57cbf2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEUyMUJJaW9hWldMS0laRkJOemFPcjVtN2pKekZkV2RmTmlJbHdTVlNZeHBL?=
 =?utf-8?B?ZERNUStFZlE1Tmh1TzUydDAwZmZtWjVyRjhJYkZIWnZYVjVDeUdjeFRDL0Uz?=
 =?utf-8?B?K0VCek9xdlZTZm1ZcmZpYTNScEl4ZE1SY3BPR0ZxYW5uYW81Q1VuVCtTY3FJ?=
 =?utf-8?B?eDlhb2d4aUtNTUY1VDdWclNianMyenladjdQeHlGMlowZ2M1a0E2K1pCeUZs?=
 =?utf-8?B?NVR0cUZ1SHg4d1JSVkNoMk9iZHBtU1BBN2Z1cTNCYUxTQW1kV1REM1BJeW9h?=
 =?utf-8?B?c2VEcUdHekV6SHpSVDZLZmMrL0FhWWpCVWVaeURtQWg3V2xYM3k1U1FEeTNR?=
 =?utf-8?B?clluS1NqK2k4d1hvcjB1MXRPdGc0akxKYkZvK3hmaU1jU1JtNDJ6ZFhDSXRS?=
 =?utf-8?B?dWxCSDhWVnR3SmVPUHVGd3FYTktTNk5CakEvMEVmNHlPQU9tRWtKN0dGaklx?=
 =?utf-8?B?cnAwbGo3cUdnWSs1bEsyRDkyekkxS0VsTjlCVXlsbW5MS21TTUN1aUpMbTJL?=
 =?utf-8?B?aHFSZ3VSWENLOEdOSWlSN3hybndQK1NCMXRwK3B5d2loMHVIMTU2UTlZaTJQ?=
 =?utf-8?B?RjBiTkQ5UktGakdsWS9xNEFrYldFUGQ0T21UZHBlRmpxb1pERmwwSTNESGJU?=
 =?utf-8?B?cm1JbFNtek5hdEo2WEEwZGVBWTFXTWhINTNGMlZWNU9vc2JIQ25WOFBoWDRr?=
 =?utf-8?B?SHNLNGE4T0ZZb2hXVXVwdWtPVDFmakJST2FjOEhSWFZGOFNaZXNBcEZmb1RE?=
 =?utf-8?B?OVJJUzJIV0l2YktkNWhzT0pHeVYvS01hNUhDM2RnTHdqY2IxNzlhTVZyVmhy?=
 =?utf-8?B?NE5TMDVkYkQvcDAraWVpUkJhUjdUcVR3azAxMVdzWkVURTdUTk55T0c3Vkc4?=
 =?utf-8?B?OUdqd3p6TWFHN1Q1bnhTOWt5TjFxbWJPTWRDSWdwc3dVUHhaQmx4UTd4Z3dq?=
 =?utf-8?B?YXJLMXUraXVkV2taUk1Nb3p0b295UHp4MU9tWkdrMjkvUlplVVVpTE9OcGVh?=
 =?utf-8?B?bkxEQ3FDQjRhSWwxZklFR1BhTHZqMTV2Q25RekgwdHRoSzRXZVlQbXd1QVlC?=
 =?utf-8?B?SDhKempGSWxRMzExWDBLL0lHbkRvQXFOVnRNT2k5RHZDaHRlREVHZmtVTzNE?=
 =?utf-8?B?NHQxK0NMOVk3bE16VHIyd2cvb3VCQUVJL2gwQzh2Tm5Qc01lbVdwaTJqY3py?=
 =?utf-8?B?UHZ1VHhMVTJpWFdIa0JnbjcxZ2ZTd2ZBcTZtU0tDMVZmbWl2bVR2MS9rYklN?=
 =?utf-8?B?Z0lOaFplM0VySnpNaW9iNFEyK2NTNXdDRytRbVJQVVlYV2pIZHczNUdISXBZ?=
 =?utf-8?B?MUR1cW1tZUQ0QXlMcXh5NHN5QzZGRXY1THJLejFDTkl1T3pyUjBLMXBGeGEv?=
 =?utf-8?B?ZTUvY3pnRlBzRGc1bVJjT3JYeWRWT1NQa1A3OEkvakJqREM4Z29NSEF3WFFs?=
 =?utf-8?B?bU1wdFlvVTNRWURDbHhNQ002My9ZcHFSdHFEaytVSUlDbjJyRHdGNzBoVUY1?=
 =?utf-8?B?bmJvVm0vNmRQM3VUbWgyVGxjK25OWm9uNGxVeWxnM0pZYytyQlQ0RFNRZHNB?=
 =?utf-8?B?cnlYbTFERzV4N2t0WDg2SEcvT1FaaHF4U3hwU0VoSFB3c3JjaFl6VUZVWWJl?=
 =?utf-8?B?RVJIbmMrME5tajZXZ0lrWWdOeDF2eWd3VzdJb1NlUlpvZHIvTi9vYk5MaUIr?=
 =?utf-8?B?T09ZeG9jb2FQOWV0ZkNBZGxhL2tVdUpIVzE3ZzNrUmJkTzFjWXBrSExqUUdz?=
 =?utf-8?B?M0VxR0k0UjRLOHBQMkNFWUV2UjZiVmRraitjUUpmWm1ONHlKT253TkUydzZH?=
 =?utf-8?B?dDBWTXMydHBPZW4xZ1F0QmxaYnhzb0pTN1BJT3NYckdtUEg0RmEwcTlJMTM0?=
 =?utf-8?Q?9Jw9IfrOtQMbv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RElTcmg0cjZTb25yWUl1RE9TTnc2SjlUNmRGaG9SVnZBai9OOWtaQkRnM1Vu?=
 =?utf-8?B?ZWplWGd4dDRuMHEvQXRsZi9qUWRTR3JneFlwbDE3QmZyZFBFdWN2bXQzbW1o?=
 =?utf-8?B?Z2F5clhBVHpmZjIwcUlSQjdXZ0lwblRrLzFVWm1HQk4xbnZCMm9FeUlBNnhB?=
 =?utf-8?B?STM1dEkvQlhNdGNmZWlYemxCODd0dEdoSVZqYlVxVWdDR0JBamNEb2JMUWhl?=
 =?utf-8?B?b3RyU1RtbG9vZDVyNGRyazIzRW8yZWZiVTFCRVhRcllnYlFHOWhUZ1FqOWxY?=
 =?utf-8?B?NGhVYi9hTExxVFdrM1BnbkJISm5scWdXa2p4SUxLTWd2U3ZWSTdDUnpsSm1a?=
 =?utf-8?B?RmgzK3VjMWswT0VKSkZvemt1M1B1SndnTk9MTkduVG5CNjZHd0kvamhvMW9s?=
 =?utf-8?B?c3FkcmV1YktaNHhsd2ZuaW1HSGk5UW9TVVVIQVI0NVFoaldZZGNMVUFsemhx?=
 =?utf-8?B?b1JQbnFBS1RzVkxSeDF3a05zdnZ3WTZ2bkFod29RVi94RmExbXhKTVpQMnI5?=
 =?utf-8?B?UWMzT041WDYvaWxzcnJPcGgyYWVUdnJyOFAwNTZEMlFPalN1R2g3dWsrUFJJ?=
 =?utf-8?B?MWNVTDIzRjhBeDhSQ1Bob2ZjbW0yVkZ5OWF5NW1aNmpwTngwa01xSmhuMXhx?=
 =?utf-8?B?UUpuY2ZHcmZrN2E0M1Z3aFVrNzJYUFlmbWFjbUxJcUt5UXJrMVZvL2NPcUd5?=
 =?utf-8?B?bTVDWStPdGJNYmFvWVFXZXE5bHpzUXlQa3ZvV3pSdTZsaDg5Q3FVcFpnTnRL?=
 =?utf-8?B?b2lXUVhJaklXei9LWU83SnBpT1VkV0IvZ2FQQmhjSi9DOFRQazV1LzRqMGlz?=
 =?utf-8?B?QW5qY0k3RzUvelZlNnRLSHA4S0JZQ3BzdHpJL2hhc3VQQUFISGdDanlZUmh1?=
 =?utf-8?B?TUYyMCtydjNUOHFwN1lSRzUwRjlhajhUeXZVZGVqdUlwbXh1RFJQZ1FtQTFH?=
 =?utf-8?B?U2M4YXdESTZYVWo3S1pabmo1b2FTRnRJMko1U0hna3p6cnlkb0FLbWZRYmJN?=
 =?utf-8?B?ZGRHNi96a2dUSkpqdVFsVTJTcWRDSlRwS1dGcEZRVFBTOTQrR0hUU0RMVTJ1?=
 =?utf-8?B?TDY4OW5NajlmWTRMdU9xeWFiNFJFR216c3JFMnkyRU85YzdscVljUjdNd0U1?=
 =?utf-8?B?eWhxU1hhanRFT2RZYjMyQjNjYm9tNHZ5NVBsR3AyWjAzMVV2ZnhTWVVUd2Ri?=
 =?utf-8?B?cFZGTGtvSXRDRHRxaXE5TXRjNUMrdUhDVStaV0w4V2pQUm9WWllFM0tSWkFz?=
 =?utf-8?B?R3VWWjFLQVgxaDBDWXpFcWZMSG5ZRnNPUjZkbzZKdHlBaitXekFYQW90dmxz?=
 =?utf-8?B?TngxbWpDVDZoclVKemFsUE8yYTVKNS9HeUhBMEI3b3hmbG5ZZGczUFphY3da?=
 =?utf-8?B?YjZRS3Q5Ym1xQVBsT3d6cHNaY3JGVFZydmtHdDhDRTJMRHRLL3RzbjVva1l0?=
 =?utf-8?B?Mm96QWhkY04wMkZKSkFCekJtMlBrWnJWYVJmaGRZRTd1UzN1ZUJVRkEwcGJU?=
 =?utf-8?B?d1lQNlVuMHFSdEZIUFZrL2gvdHlJblBUZ3Q2K2Z6cER1ZFFudFNuMDdVTHhz?=
 =?utf-8?B?NFVGS09MeU1qSEpoZWg0VStJNVEwMndQTk9XRmJDMTEyazB5RkpNT1Qybjcy?=
 =?utf-8?B?TmVjNDlja3hzajNmVDg3KzY2QjVJcDYyQ0U3SGJaT2d5S3hGYXZmVEp0RjA2?=
 =?utf-8?B?bjVVdWwraXluRDlGYnNMV2YzRmhzOVVXd0tsTERqU0tCSWttaWF2RGJ5Sjl4?=
 =?utf-8?B?MHN4c1E2RjhudUZrdHkvWFhCbWo1SVl4YWFOazNmdWVqM3l2eHJnVUlwdHAx?=
 =?utf-8?B?Z1hUay9yZ1k0cVNlMXY0MUpibVIyRzBTWC84ZlZEZVliSlFKTy92elhxUXpN?=
 =?utf-8?B?dDBlamVUUG10SFoveW1oWGlVV2cyWnVJU001VGJOb3U4anVJVTNBK2RRRi8w?=
 =?utf-8?B?RHRRT3BxNFRadDJXTW9Gb3BibGxIZkd5Q2hCRmIxZWpaREtlZEtSaklldWV2?=
 =?utf-8?B?M0VNWTI4NXJOK3RrSFdmMVNWVk5sYm42S3M3Z1ZSdmVGMHhpc2gyTnFTM2Y3?=
 =?utf-8?B?OWNSKy92Nm1sQjk3dWFUbTVaTE9pb1UyWFBmd3h1L002Tlh0T3RET0RlYkpC?=
 =?utf-8?B?d0d4NEUzZzV1UEtxdTZKK1ZpQkxCd3ViNTlhKzkvRmxHWEY3RDNvMGZzT0hF?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TEXHUZN9Do+EqbgFLJ689jCqnCQycpsogxmX7tATwxtWdSA5SVoFni2WnST/qQfKiESuUWcFHFBDCXVkW+MvJ0ks/OgRc/te0EPUS1kC1t2UcB20+PVk//mexkZyMVbsOyMzAgIo1lt4vZE5PGzzTU1p9SBEFZamuHe+gF4X8Sz3ZrWY4S6Jm+p+u4c/rbtln4VgNgPSe/Q892ICve5cCjbHhTD1NZvNNY+twwltYZWBlRsNMvqxr5/dr3Rvlr3u2U4l2JP+my9U/FnMws9MyXhL2usm2szi/mLx/lBOMX65joQ1sgzRJ/CwaumBSni+YdTPHkWjFfzQAIehi9jTvY22AoQTBwR2+rhq/CWQ6DwxsJSUlb0Izmoe5hGC40PjuepHIlel2MYsxSaM/JhbG0jqocf1wD1nEdqS4nmGCrmqlBARQNIC0xBIglUOvxWaOq02A/UMnfVEcHabQUqyY88DQqdSZ/iz47AUsOYjjAXSwMvPLKFfWuUPNxNqzIMYhKcqfA0EUBXY8NvJ9VfCwvv3bWD5NN4/SiTPBtz7L/2TrGlnjk9sl1iU0bLBBmAvZqz6ezNY0VPUF5x2QCsHkWdLAmbXphpNJAzougc81bU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c893e275-7f2a-4364-996b-08dd57cbf2c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 07:46:02.2662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /60/N+uJUB8uA0WkbZRwkvJDdmRk10cHhDrA0U0GKInoj8S5wGsiXVEZ3fcC5iTjDunyCHKH/FoGz0cvkV7qMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_01,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280054
X-Proofpoint-ORIG-GUID: 6yyvxy-nUcGIcWouW09x-orxpxeuv_HP
X-Proofpoint-GUID: 6yyvxy-nUcGIcWouW09x-orxpxeuv_HP

On 28/02/2025 01:19, Darrick J. Wong wrote:
>> +	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
>> +	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
>> +		xfs_iunlock(ip, iolock);
>> +		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
> One last little nit here: if the filesystem doesn't have reflink, you
> can't use copy on write as a fallback.
> 
> 		/*
> 		 * The atomic write fallback uses out of place writes
> 		 * implemented with the COW code, so we must fail the
> 		 * atomic write if that is not supported.
> 		 */
> 		if (!xfs_has_reflink(ip->i_mount))
> 			return -EOPNOTSUPP;
> 		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
> 

Currently the awu max is limited to 1x FS block if no reflink, and then 
we check the write length against awu max in xfs_file_write_iter() for 
IOCB_ATOMIC. And the xfs iomap would not request a SW-based atomic write 
for 1x FS block. So in a around-about way we are checking it.

So let me know if you would still like that additional check - it seems 
sensible to add it.

Cheers,
John


