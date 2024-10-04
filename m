Return-Path: <linux-fsdevel+bounces-30979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B95990343
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC581F25359
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9921D7E22;
	Fri,  4 Oct 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Led8BLuU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NJEK+ra0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67A1D6DC6;
	Fri,  4 Oct 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045955; cv=fail; b=ZVDwIL+DWm5G2azzPs9D2WevB7Fb6amNemggnNM2p/aITt7S4035YbQaNuE2hPLwffpSdnfMMjyCN4FTYX1KhZwx5Dfptya8plEzgVX5lBS6xLTgRDy0AvAhg/KzgTv7RYXAI/2pDlKU6GLNt0y/E1fO57PeAvLCGz5xON077sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045955; c=relaxed/simple;
	bh=xfNU6UZPeIaanymycUYnMaT5aHzIJNSiU/Xttq/qV/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YoZIwoHXldOhza3MGv1i+kN8Y/9y4tojBI4x73pO4khN7G3Y7bKVeTJ0Az2j18C/RKPapB8CMPvPrLPNP+TshDQZxjNDVkjtyDOEs4LJ1FWVzZJ3Y3UtN6dOs6XHcMenO21SarOA+iIa79x9e/2bLeQ0hY5XKmm6MxthrE0Jj3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Led8BLuU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NJEK+ra0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494CMYe2028774;
	Fri, 4 Oct 2024 12:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Scq7y2gmt28BAa4uKQXGVR01PAeHa43TKfPcxjPToks=; b=
	Led8BLuUBqlXpXoATOXYoWW6vaS0KADIQgI7QIEaB6yVARddzvIahAsCSHjN/s33
	cs9O0ckSt2iupLxEG2lfjsduZRYTLXxxLrIp5vAr+bG2Ex7n/ruPS7tV5TQGU3FA
	xsfGS8lAwyvqXPr6I/QwqQ7ONW4pcIcbo2vLh0OKsZG0SAYnuyUOb4bRjwc8qlEk
	P3+WbAHESs/QcW83SRHatp7dC3FUiRaXQSV36Dt5x/brJQBUfZPOYdPQJAxfTbQy
	zjrIXx+tcmblUhkIKedGcml0tpsuVDnBZDjkhJ01ZVAEDmff5q/K0+YSB+53Ww36
	R3f8MTGDZXtRJUWBALEgpA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204gsg19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 12:45:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494BH1NF006011;
	Fri, 4 Oct 2024 12:45:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056fdbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 12:45:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOFHQuE7Yjmkh6AAk+5r0CEpioPasLM6xj68NtfR51OL7aoPl2cch35UE0a9cL13FYjhTTgi97rJaDK7GkHcXgOkHgEgg3iqVUiIvPLgaRgEw3jE27XDWp3QyMLwliSGFtDwRcGG7pR/ktzL+J7HCG0xmy9AWePF8BbhDDdTFzzHLVIMr2UaWLp7qWGMsWSKjyTjQpf7D2uJcXiIUvNT7Yf/cRQEKLnSKdJPiHUUpQvtBGmOMOP8nYfTuegK8SeZluHJlMSShuBx/VopRIwQdKBGEUMRqILOijkrcgPxPz8UtnjRWJWaOJmYIZuk2qK3ud6Bb2wQldxdCgDiQ+gTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Scq7y2gmt28BAa4uKQXGVR01PAeHa43TKfPcxjPToks=;
 b=m7g5iWBgcsD2Gy/dlQkQLw8NsRPElG7rqW6OJDXWvmR4b2TfLWCSYbXbWRhEJYAVz4UQYGO7ksGiLQKxnT6+Ksqr7iRAAZbgYw4KZNAEY8HWPKNwVvy046HEr8GB09nfYtgUvLFP+zB0RMzihPO32ofxuwtwrfN+qAc4YkjEvniJStAMURQFGU//1S28K2emwb4n7fw6zAzzINhmk2kmLlcvWWjuUqB8JSQlvUDsp48055d24O1y2MN7uEQ1efL0jZ8vRlX7/P/wgszlHI43mqG64v4+3m5mrzow+L2bpZXQSj7gzfHal+zIWwgyaOseIR4pEymJgi1b9O8eE7GEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Scq7y2gmt28BAa4uKQXGVR01PAeHa43TKfPcxjPToks=;
 b=NJEK+ra0UeyVzRl5/8B0R4x9AJjlKE4v83yOcc5WV9c3UDl6ILbflnkFeJTSj+4IZySgu/XIMSxCRFLgaJA+U2rzzNxtRG3xFmYFGdOZZVqrXSGXcSwB0gyYn/BoZFBUBPDPIwL4R5S4uAYgqCMPfN7FW99BrCppFkGHE3edvVc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6349.namprd10.prod.outlook.com (2603:10b6:a03:477::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 12:45:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 12:45:29 +0000
Message-ID: <741ce24b-646d-4ae0-8c0e-72dd9b4f81f7@oracle.com>
Date: Fri, 4 Oct 2024 13:45:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] fs/block: Check for IOCB_DIRECT in
 generic_atomic_write_valid()
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
        cem@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
 <20241004092254.3759210-4-john.g.garry@oracle.com>
 <20241004123410.GA19295@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241004123410.GA19295@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 00252e1c-dcca-4b2a-5ac7-08dce4726d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFQRkNQbW1WTTBWNkk4SFF1cjRMYzQxcDZScTQrbWpWYVFyMml1T0kzWlZx?=
 =?utf-8?B?b2lGY0podlNxbDlaRVRhbEpORWx6MWZSbWwxU1VxTjlYWlRpWkErRWh1Vk5U?=
 =?utf-8?B?eEVDK1BiVzQ2V1FpSFVVckNocjk1dGM5b2tjMkZLSUhTTFM5RFFXbU1ZRHEz?=
 =?utf-8?B?ZEJBL3d4MjEvVGxvaVJEM0JGUy9TNEVMdkR1Ynh4MkJNSFJrODlrU1RtaGZi?=
 =?utf-8?B?QTJhOXEwc0hHQkNjVUZkR0o5aVpBNU1XNnJlWXN6VVp2TmNEWGNMMEJyNEhm?=
 =?utf-8?B?SXIrTTExYlFYU05pWjdpalNMRWxpNzJJdnFzVmd6bExlMXlJVFJIaUNzTldD?=
 =?utf-8?B?aXFodnpJOTVZV0JFd2xsY21oSXFGOWxDaXR0OTNBR1V5SmlhSXJSRDEvcXow?=
 =?utf-8?B?TjRKNlNCSVBIVWYwYXhIN1dIOHhaWGtOQVFGSnhpNHBRQmhxUmg4bUF0bWs0?=
 =?utf-8?B?TnMxWSsxREJjbzJLdFRqMnNaMkFXZnpwZ3V4cGJob2ZCWlMzRVFraUxYd0xz?=
 =?utf-8?B?bE5DSGdwR1JtSUkxWWR6d3JCMTFqSGJBNnU1WTd5TTJHLzBIUmlWTnAvSmF5?=
 =?utf-8?B?blREc1lEUDRDekM5UTRwRCsvZVFvMzBPRkllQnRBQVE4Z2hERkRSMzQ5S09V?=
 =?utf-8?B?YXdieG80b09ORFNGMHBUSFA0YUZIYjBLeWRwWTQrSVNkUnVzRzhnUTlQMUVr?=
 =?utf-8?B?cGx3TnJZMU96MGx1UnMreS96RnA1RU5kbHphekExcWM3Q3l2bFJmcFExMVZk?=
 =?utf-8?B?K1JMKzdGeTlPUk5vN3RCeE4xZDVIeklxYk9EL1FNS0REN1FKTkZXRlhtR2FP?=
 =?utf-8?B?cVRzUTJnMVNleThXSUhOOGJLQlNBT0RpYzhVNUpWZTNJMlFuSDR2bm9INnE4?=
 =?utf-8?B?N2g2MU9SZUo0VnZJRlZJQnhuOUxKanZMMWJocE9zMTFXdktCVDdxYjVyNFhw?=
 =?utf-8?B?eFBFdE5CY2JQZEQzWE1lQXZZTk9ETGE0eWxSSEcrK0F6dUIrSzhxS04zYVAv?=
 =?utf-8?B?OG1EZHJjWW1OV1NZaHlyRk80d3FCYzMxcHFDb2tIOTgxY2k1QVhoZ3c0NmRY?=
 =?utf-8?B?NTBvNFZndGR3THd0aDdaRkVORTNqUU5nV28yam4yYUJuY0hPeEp4NHU4U2VW?=
 =?utf-8?B?bmFXU0xrd1d1UEMyT05FVXVaM1k1dkNKbDBnL2N0MjBJMlg2MDZ1K2hXdFVK?=
 =?utf-8?B?WXljRk53aEZTUFgyaHZGbFhnVzRpRmxLY09TSVBtOFdFT2xxLzlmVHdnaWVs?=
 =?utf-8?B?em1yNVQxSnU3S3ozcURvenZ4cE9SWExJcWFxdmp6R1pCZ01EQ0Z3K3RCaCs3?=
 =?utf-8?B?MkRNQndNRE9sSWdqT2dNOGhuWVFUcXhheXVlR2EvZVU0Wk5NaGREVG1FWDQw?=
 =?utf-8?B?dDNhOURGOGEwQWdLQk5jbXRZTExzQVVaYnczZnkvanJpQjJyeTA0blJ1cDJD?=
 =?utf-8?B?TXhLMWl3bEtvczZWbjFNY2VQQ1dvTkhaOWRxREdSUlUxSWxCNDUwUVg4eWln?=
 =?utf-8?B?TWcybU5kLzFEWkc5blQ5amNESXdKZTNjVk0yNnFGSmJoNHEzUG0rTXNHVUln?=
 =?utf-8?B?c1dOdUFnZEFjZFlRNlFDY0F5S0R6elh5VVdsbnBuRG1MRmIvdUpNK3V4NklX?=
 =?utf-8?B?TmR2a1U1Si90enlidjZ4UTk3YmZaVlgzdWlUbWtjTDlVUVdmOWNBdit0YWl3?=
 =?utf-8?B?bXd1djRMVEFHbm1FT0piNFJwb2FwRzI3SWpUdEl4VSsvZitFOU9NV3hBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXc3U1lNUnVlYnluUHh1ZTFTNXk5dEVCWHduZFE1UFk2QUdFZFhqYXh4R0pw?=
 =?utf-8?B?azluWXkyWXZiaUNMUDNkZHYwZW9sbGxreU1iVnpxV3FBeVQ2a0VYMktub3NB?=
 =?utf-8?B?V0c3OW5sT2xFYkJFVFZqK0NKQ252VDlJWXBOQnpwdWJwaVNnbGU4YzZxL1c4?=
 =?utf-8?B?aE1QOEM1cG1NdHh1ek1qNFQ1QUJQQm9iMnZPQ2RMNUl6cUV6ZWVQOGtOMGtU?=
 =?utf-8?B?OUpvN2dIODhhWDlHbVVjUFlldTdjSEZkZEJ2djBENzNvdEJVUytrdDI4Yjhh?=
 =?utf-8?B?V1ptUUp5MFNqcGZpRjNTZGJVODhkV2loZ2pWZUIwSWtVOVROOVliMUpOM09F?=
 =?utf-8?B?cmhlODg1aVJnL0l2OGtBYjVUM3MwR1k1b3o4QzhlaEZLek5EdDlEVFRCYWU5?=
 =?utf-8?B?SGxXZTN2MkNkMERUZk5zWC9sclNVanJWVTU0WlRVSTJ5d0VqeUsvVXMzeXdG?=
 =?utf-8?B?V2lhTU05TWJ6TkZVaU1DL1RIYnZCd1AwcHVEdUp4TFdmdWlHSitMMGhheG1y?=
 =?utf-8?B?K3hoU3FvdHA4NkNHMnlKUHpOaUh1bldJNlMza1dZNFMyeUtMTG9WVTZpcWE5?=
 =?utf-8?B?M093NGIzSFduMlY2WFRPSm8zVE51amFWUDE3c2REbUhaOVplRmtGNmZHalFn?=
 =?utf-8?B?dDVyZjVSZmhBSEdjQU5IRVFSa2FvZGxGbnk3MFh6Ynh6bWpHamtRUXVtVW96?=
 =?utf-8?B?bkhhLy9zemdCU0pBSVVyeTFpVFI5bTVNRW9Ba2ZXWEljd2R3RVpmT3JmVlpB?=
 =?utf-8?B?U1EzdjdJb1dTMDlaZi9yT2piWklMNVYyUnI2dlBpRGtrRFl1eS9jZ3lXcG5F?=
 =?utf-8?B?QnZJUUtPTGRraE0yR0M0Y1pmVVB6UWMyWTcyMHc2WXNpVEMrSHRBdTdaalBp?=
 =?utf-8?B?QSt0MkpGTEhwZzF3dS9GcFJ6dStHakZLOHhFWllOeHQ5M29zZS9NYnNSQXZv?=
 =?utf-8?B?ZW82QUdUbVYwNDVxTWJaUTVzYXlrdTJzZHNQWkJXOGkyeERIU2VCcWFyV3FB?=
 =?utf-8?B?VmdWRTVyTCthZVdQUWJvL3J4eG1xbmQyKzlWNFpidUtxZEdQOUdaalM5UGVw?=
 =?utf-8?B?Y3pFRTFwTTRGbFRNRGNSWFFyd2t1dGxKbXI4MDlBY05qY3lmZ2g4bVF1WnFp?=
 =?utf-8?B?YlpvbnNIb0svTTZVWDRmWnZWR1BJU05kR1UxYndsR29HY2t0bVlwR0hMU25w?=
 =?utf-8?B?UzhxeEplUHNDZzRkenZvUjJUV3dCQlNHVVB5L0RORVZ1Vm0xUGtVZWVWeklP?=
 =?utf-8?B?OXRCeXRJaTdvclFITGFaSTQ2S3RCQTA5ZGxzQVhSVS9udGRjaXlZaVVGL1Fu?=
 =?utf-8?B?czh6c2ZYMnNlaUJGa3FQajM4b3lpSFFBckVvNW05OW13Y2czblFxbERZaEhk?=
 =?utf-8?B?Zk1RbVNTbjYzRXJzbkhsNGZpL3Z3VVR3RlQ0VXBoazNPSU05bnBKKzI2Q0Jh?=
 =?utf-8?B?WmxWcjM3Y2ppejZGZC9pYWpoMDNCSzFmYjBIcXRCRysxdDJ4MEdzRUVCSHRj?=
 =?utf-8?B?MTZUMXZ0T1laejY1YUhWSzI4VzFWcE9UaGxQcWE0RmFhd0h6TE5OUnNRelIw?=
 =?utf-8?B?a3Y4d3FPWVVkSmM1dkQreXp6L2xwcGFLdGlwNUlwZURQTmJtaGNkaXlxczVX?=
 =?utf-8?B?V3Y2U2k0UWUwUyt4UTk3NUs3WWRScUZOWXk5R25VZnNiS2ZCcDdzaWpUbTNJ?=
 =?utf-8?B?YUxQdmx1RWxJK01YUGQ3b2dFZUxOdTQxWmVmazV5MEZXckFIdXlyUjZWMGFO?=
 =?utf-8?B?WGs4SkRLR3dSYndFbXZiSG9ha1J4RGpUVDZJdmpDSmFjbnFBdTJtbTNZR1lj?=
 =?utf-8?B?bEMwZ29pZzFnQzVhc05SVndna0piaGh3Qy9CTFlOaWc3bkRiT3dlbEZwcnJN?=
 =?utf-8?B?SFVYaXd5UXduODJLN2RVZC8wQVpkdlVsS1VWRm1ZZFpOOEhqb2pwRWdIUGhO?=
 =?utf-8?B?RVh5bENjSmRiN1lKQ2JMZ0lyb3JUc3BHYUhaNkZuNmhVamJ1WllYeXE2RzRs?=
 =?utf-8?B?TmJTL3NkRE1tL01WQ0NackNqVHgyejBXRkdwNi9sdDhjMXV4ZVJFS0Nadmo3?=
 =?utf-8?B?UG1QUm1FVkdwdFpYb1lmQWREbW9HWVJBdmQ1Qmo0WmtieEpPTHRRZDNiS2xa?=
 =?utf-8?B?cHlYRXR4OUE3WWZpaVNpYXI2ZHlBMGxlWEs3WFFoNUNORmNCdStldnNaSTlJ?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KvVSuFLPe2kUk4BIxgg2rggTQQICXBQxPJnrVPnS6GyuarEj5Las/CK5P8OAtWdM04XlLSGWfAFz+zTL0jO4CApmYf3hIUViBaMRks1v6HGrU9I2hRkb3KlSIEZ5ko/J10K0n7emvoJosTjXuEaCN+oxhg8XnvcGjE2T9/Utp/JJhZbmNEbeRNdtX1nfqmsr4+38by5z6Oil5CJORAlueV8mNonHaSpInNG/0xDRPe5T1mSWeksYIZkJZOm62Vv9iwRBR5hp8l8/f6xeNgra41OthK7+/KRNb52ADAhNsjZ+2reeoiaOw2csJkNiVt0DuakAQJqVNcC6Ivc6i3AiXJpZfFW1d2lD/uUWChYKpk39f84Ldo0AxqxEZ7uGOrA9GOKswidZCLoI6X6kXitAyhdOcEl8QvDz9Srg3O1t7Qst6QbVB7Jrf1RK2+yabFsvYO7m03iUY09s0sUdeHH0URSVJJbHQoXe9knz+QTneD7qLlnpPOfeeaosW/AXGj9KHSgPEoRNWeocIDg0vFnew/71UWyteZgbzFZJnFCzAI99YnkZpSwzpMRATrvyOMZuxxgWR7Tc8nKP4uB2EI/dMt8gEwSVNRRrjJkUDmoetIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00252e1c-dcca-4b2a-5ac7-08dce4726d2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:45:29.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkEQfiPYQKvjfuvq4pbqY/vQ+dwtPMQJ4HAGmXBm07vrBzj2PecGlCOVDs822sY7lvnvbmA2mvIOiBwsE96Wug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040093
X-Proofpoint-GUID: mqv-fUK3cb6-sJ-5aL0E68D7-httKnkW
X-Proofpoint-ORIG-GUID: mqv-fUK3cb6-sJ-5aL0E68D7-httKnkW

On 04/10/2024 13:34, Christoph Hellwig wrote:
> On Fri, Oct 04, 2024 at 09:22:49AM +0000, John Garry wrote:
>> Currently FMODE_CAN_ATOMIC_WRITE is set if the bdev can atomic write and
>> the file is open for direct IO. This does not work if the file is not
>> opened for direct IO, yet fcntl(O_DIRECT) is used on the fd later.
> 
> This sound like a bug fix for 6.12-rc?

The worse that can happen is that a RWF_ATOMIC would be rejected for 
scenario described (with using fcntl(O_DIRECT)).

But you are right, it is a fix really. I would need to add patch 1/8 as 
well, as it provides the iocb pointer needed.

I'll mark them both as fixes then.

> 
> The fix looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

cheers

> 


