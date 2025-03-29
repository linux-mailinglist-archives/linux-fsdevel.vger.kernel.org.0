Return-Path: <linux-fsdevel+bounces-45276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2860A756DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA31B7A488A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F01D6DBC;
	Sat, 29 Mar 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SNBe9vX0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EbMl3HT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C92AE99;
	Sat, 29 Mar 2025 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743260312; cv=fail; b=S1U+mOkA9AFKvL/9QslIvOzh/hqSPPwavtLPiWgq3+3Ku8c8H0MZ2+/pmuna8ZcKffoniI0M2mMyNIZ8Auk+zM3BEMvTWQ+q9eOOB+014Qf9CBVYK5MY2yE/dTqay5fliQcHBqWfWKIBXPY1gFQRnhUvwAbsfxhAgre2YXRalo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743260312; c=relaxed/simple;
	bh=vxxchNlXMseGzuO2lkY4ZHgfGUm7mnXF3Ym5ms4I54w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+vjlH/wwsKdF3lqOLYj01NYqeObfKqSi0f6ZjNFTMNh+1dVti5a+Rs4ta+O5W8YjeazmqWphh+QpLYXjCh08FnXRhkv9I2cqy2T6eAyCaO2DAk/vvKP84dqVrVbQVNQrRF4bPAkF6IhQekbPTEGutwYq5n9HkzEE58YK4Erii4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SNBe9vX0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EbMl3HT9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52TCIVwK006881;
	Sat, 29 Mar 2025 14:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bToraf6jOv+U2eEyNfuT1UiNO86osNYiYOPFWlK2LL0=; b=
	SNBe9vX0MLin+P94YjX42KJ35APivIswE6/5pmgYL3JUAtvijnEilRNvLdFKDU25
	GIycm+BWI2ABryjQtDa2uPChOV5IoGMHZ74SynYp/WsL2+UnvR9pR18dkaeENw8u
	MD69V+Y5oaMU2u8yR23Zp8rZRC8M5hZu/t2H0SJzhOKEkQzjjWyJCgebooyFNNce
	I6aTDJ3lXXYn5RLwGWKLtvZMF1JG+bDUjTd14VymI1xsvW3HnKWEpfc/J0861ijO
	jiB+HE9RFO/UiPkIdRpxSR394UYLdvE7uSjHZ4TZB9jJP9yTS2AL/owk4AaI+z3j
	DxbQgrjiuk27rwFf3bJVJA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wc8ht6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Mar 2025 14:58:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52TDjSBx006576;
	Sat, 29 Mar 2025 14:58:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a65hrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Mar 2025 14:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toCxNvHZfMFYgTOpOt4QUa7ohvF6cy0OEK74KmZnCVYltZ4QSFaToFL+eTDByV4iSIuJEOeCf3OazoN2w5+dy+Ru302rNZPOazczqp/JVzeDY5+fTN+T7TFZbpNV30FrlqHJTLJGWWDDL0OHzQ29NxveNYbjbhn7EdOHJqAeSDA03eDGJ/OqgYBQcI4ul14afQRM7xZRQkE5ksLDGl88/aGuzuOWyiOR1Gvq4cLqXSMYW+ZTrmNTUKiDt+pmzKcY5TMV0Fy/fGYhwmNN8sR3C8vOZocB8q6ScNn1o2VdU1bF4n7W+E1ZZ6TsRiJTrPzafFekBd4hbcir3MkQ65t6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bToraf6jOv+U2eEyNfuT1UiNO86osNYiYOPFWlK2LL0=;
 b=WJjGkCrcMCyZXy16DJuwMXglMVqV1lVKtBO/aGPOxE1oy23WZbQb9/jBsOWwO8upznfixLY2ofz7cx62J+LyV7uybs/KuuuF/cCnxpH2H1L92cDR62vqw8HLezkj+bD7SUYphQfW+dsIA4/ISZnjEyC5Xq8nzpVG5bX6iEWgT33ts2kA+NlGpjJrRG3CbNoHhgUI2FGfq6+rPcfO4zub5qemrHGkQ/pk3uUhcfZ/+DttSKn+RXm4luKoCuDCcT8Sx853WQRDnhJhXrbYDEtZ1bi99U5tR9eg6eoSIg2kVI4CvObiAMZi1P/gQGrVJem0wmjiX7Cuwj/lrfM4nlL5UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bToraf6jOv+U2eEyNfuT1UiNO86osNYiYOPFWlK2LL0=;
 b=EbMl3HT9D4E7zMpLURhj+6yXK8Qvzvf3lGenz4AvxF7Mow3ShV8GZVLswfpke6Cksg01e8Kc3C5ABZKrumEt7EAOVZI8rzUaPnxkqQafRFjZ/WDnVeRyPz6qCgg0XEETr09dFTrqYQVJ7jNpo4l6j6gdcfyGLXd1ehZ6OVOpWXo=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by CH0PR10MB7535.namprd10.prod.outlook.com (2603:10b6:610:187::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Sat, 29 Mar
 2025 14:57:58 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%5]) with mapi id 15.20.8583.030; Sat, 29 Mar 2025
 14:57:58 +0000
Message-ID: <445aeb83-5d84-4b4b-8d87-e7f17c97e6bf@oracle.com>
Date: Sat, 29 Mar 2025 10:57:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Chrome and VSCode breakage with the commit
 b9b588f22a0c
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
References: <874j0lvy89.wl-tiwai@suse.de> <87wmc83uaf.wl-tiwai@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87wmc83uaf.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:610:53::20) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|CH0PR10MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: b17bee7a-750b-442e-ca91-08dd6ed217d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGd0cXl2YzlnSk5GTzVtNVRzbWt3dUxGK3FoM01UMHRkMU9BMWM0S1BkbmZC?=
 =?utf-8?B?NTU3di9zQUF3Snc2Z1piQmJ6dU8zMThIVGVEKzVINkF1c2VwOG8rSmZVWkMw?=
 =?utf-8?B?OXUzZC9YL0sxYU5iQitJWXZqem51MTJjYUdtVmNOT2hGeW8wTU5FMjErT2dm?=
 =?utf-8?B?OUpXM3NaTGhja3FaZXpsQTM5QmEyODFjVnpPUEY2VEdTOVVRNkxkeUtyL2pp?=
 =?utf-8?B?Y2VDbFJMci9oU3lTa3hHUldUUm9VR1JSSmF1YnREU08rYzlxVUo3SHRsRkdP?=
 =?utf-8?B?L1M2c2ZkRnpSLzBQQm5SbU92NTlrVVF3TzAxbVBOYXJSYmNsSkMwMktLd1NR?=
 =?utf-8?B?UzJSWkE2cEFBOFZ1clZLSVlXcDdsMDZhOGgraVA3dWU2c2pCam94N2dMRTdD?=
 =?utf-8?B?dE1yRy9idVlOYmJOYVNqQXRSVGJpeEtPcWVvZThWMWlwbHBnU3B1NXp2aXlS?=
 =?utf-8?B?Qk8ybFp3SzdCR3ptbXpXK3FQdGdWZUk0ZjZCOHpkR25LVkI1bko5MjNaSno3?=
 =?utf-8?B?Tmw5bGtpR3ZWYVgwblpEdkR5Vzd3MEZLNE5HSktPTFVvb3RnWHdWRWhWYjRt?=
 =?utf-8?B?Q3UrTE1pbitTYnVMdzBxa1ExMHd6NnU3bjZsSVBQTEVvbFA1cVNLTW5XcWxL?=
 =?utf-8?B?YVdFN3hic010dUhaL1cxeGlZRlRNS0hvSUVUZVJQY0JMTWhLTUxvNHQ2Qnk0?=
 =?utf-8?B?Qyt0Yk55ODBJdHZkaFV0TlpXUTRwKytKU2hyQU1DeWxWc0tReWsvSHc0TE1h?=
 =?utf-8?B?ZGczK1lGRCs0eXQrVGQ4cXl6Q2tLeVk0QndMaEYwK3MvblNFM2xuYVpoNXRo?=
 =?utf-8?B?dTFGNXVERmxkZlI0eHZpWE9wcy9hTEVpY0VCQUhjNlZ5K1dmSmJDWjFKWkl3?=
 =?utf-8?B?bnVlcEJhVno1cVhtVlMvMkNpeXJVVXlaNmszY05obXdaVkgydk5LbW4wdmpK?=
 =?utf-8?B?NkRKS0NTT1pjR0RlY0RyOWZUTndLVXhzU3g5Z3hBbUlXQkxqKzVFQ0dXWVZa?=
 =?utf-8?B?dTBOalROazFVZC8vUi9kTXBQVWZheGtxT2FVOGpuNFFtT0ZveTVzSkd2ZDI5?=
 =?utf-8?B?VXFQa0RNdEg3OGRoazhvdFFENG9lWUFBNmx1Z1pKR09jcVBkOWJUelA2Z2Ix?=
 =?utf-8?B?ei9tbHMvQWtGN0l4QVVPUC8yMHl5SitRemRzNnowNThXZXZkNE5PcC9yZFVJ?=
 =?utf-8?B?NWtzd2ZuUmpjMGFxbnhZVkpZUzUzSy85R1hkVXdXS3FCcG43U2dONkdQNThi?=
 =?utf-8?B?M05PWTRSeFc5eHNmdUZVT1RvVk4ySVFSQVZ6S3JicUh0RXZlSFMwWkY2YTJk?=
 =?utf-8?B?RmtBUjJYOHNScm5MckVIN0NUZmVjSnE0eHhKbnF5bnorU2gzd1Vxa1hqWnZ2?=
 =?utf-8?B?N2lhWnhVNnEzZHNTcUJWdXZjRFVlMHcxWmhqS1hab2NzMWZHNVlJZ1N5NldO?=
 =?utf-8?B?eklTaXFrdFJSYkxDVkZLNHZ3TDdOdVppcTBhOGIvMERhZS9iaTBiaVpVdEcv?=
 =?utf-8?B?VFBTTVNmeitINzBNNFU5MzQ3RlFNRFkwSWxlZG9wVXpoa3QrbWhveWM4dEVz?=
 =?utf-8?B?cjFNVHU5Ykk3NDBzSTlLcHNQV0lnRUxaZ1FzSm9hN2t1NHhtQVc3cER1WDdz?=
 =?utf-8?B?SzdoWTFrVzE0dUxTRm5EMVVic1IxY0xEbU5LNjE0bkxaOGFZeXRNN2ljMjd5?=
 =?utf-8?B?NTdKNitQc3NnVzEzYmFzTTkwejkrTnc3ZEYrRDFkNlFuZEFQSXU1VHhQRDRV?=
 =?utf-8?B?QXZPUEgzdytKZVZHYW1keVYyRTBXTGR1OHhiL2NZMk9STS83OG9vVEhTU2h2?=
 =?utf-8?B?L0diTkdNTk1vTU84KzlLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amtXaHdwb3hTSTF2NUx2eVZDUGw5QkRhMnFEV1RoNmk2bVMrWFRhZjhZa3JV?=
 =?utf-8?B?b2MrVEpid0ZuYndDZWlsNjNPWHBWaHpnc2JacGpicFYvL1FrajJlOGp2S2do?=
 =?utf-8?B?azRWRk5POGlUV1JXdDBhc2RUOTRxODZiZDFjdi94T2liZTFvWTVQTzVTcDBu?=
 =?utf-8?B?bmwrOVQ1c2lBZEZiY3ZSMndZWkdXeGxHYTVueHJmY29zc0NUTW5TekkwbDN1?=
 =?utf-8?B?MDJuL0thWDk2SVdKRUdWQU1IdGViWXhzL0V2QkZrbGl0d3o0dG1INC9sUnZ3?=
 =?utf-8?B?REJobi9sSXJhSXB0MDRDOHNuQ0RZOXc1M0plVmtRZSszcWxEQmhOaDdNRXZx?=
 =?utf-8?B?bmc2SS9pMURnOUhyZXNVaS8vMVA5VEhNRFU1ZCtyekF0TzgrY09CWVlVRlFn?=
 =?utf-8?B?bEhWWnZ5SUdyQUtoK0NCOWtjZlVUcUtjejVZLytsd0gwSUtZOTVFK2FpYVZR?=
 =?utf-8?B?a1JnSTRybEpoMHdWK292N0plNE4zQUpQUUNzTmJyaWt0NG9RT2lOUnNxblFs?=
 =?utf-8?B?UGk0Y3g5Nm9CRVZmL3U2TVNWdERta0F6djVvRVVhRm5wQTNodVVEcmh2ekY2?=
 =?utf-8?B?MlpSRkRXUFVhY25nSlliTXQzNEk3VGRkTXB5b2xhdFVRMUcrSVNKNGwzUTlL?=
 =?utf-8?B?eE1OY1NQRktOSW5POC9McVM0SHd3WDZhbkU5UmZWVXVmc2YwTHljSEMvZGt0?=
 =?utf-8?B?eFVpZWIyYmZwSEl2N2luVWs1ejRLcEl3RElJRkxOYXZyN1ErdFJUTWtLUjU2?=
 =?utf-8?B?OThXSk9rM1FlRTdIUzdVRkJWdGlKbHY4aUhZVUJnamluWFZ2TjVTSmxGdVJj?=
 =?utf-8?B?cnppa2NURHVlelpRS1VZSDlQUjBTQ2xQa1RkTVYrTjFiS05EcmU0Uk9HL2F1?=
 =?utf-8?B?OEV4YjhTektmWWZZN1htUmI3S2pvOW5EZWRwVWdTQmtFSEs4NHVJVWsxU1E4?=
 =?utf-8?B?dzljVFZJOFgvQUtGUHpKUngwNkFDK201bGg3OFJFckwzZUR0U1VndlRLREhs?=
 =?utf-8?B?T1FDUytjbGQrS25wUittNHF4b1BHWS9VdU9zU3lUZVoxSmVUdTVJVS9ZQlJo?=
 =?utf-8?B?S0lnQWtjTllZWlNsRjN6a21kZDJUMVBkQTBUcVovWFI3R0xlWnZsdTF5dHZk?=
 =?utf-8?B?RmlPbE9HUHJmTGtTMUp4QVZ5K1VoaGtRWUV0VVpUaGUzY3lpanV5TW5LSlVX?=
 =?utf-8?B?cnQ2NkdodERsMlJDZmszQ0x5dHd3RnEvOTQ0RElXckVTWGxCTGRBMXIrZlh4?=
 =?utf-8?B?Z1FXVFAwQVMyNVpoeFp4TXNVcStJL1FKL1IzWEMrNTFWNXdTNlptSGlRaCtx?=
 =?utf-8?B?TEY0QUc0ZFB4UUFzM0t2aFlEa1RRd2FiQmYweHNMMWxBL2x0RURzcnl4eGQ1?=
 =?utf-8?B?bW9QSGsxbGJra0sxLzBSMlBLMlIxd00rUndOcUdLNC8vdHJnM0hERk1FWWE1?=
 =?utf-8?B?UGplcitHUmtobGVGVmUzZTNjbGtBNS9JVTBucisvNDJPZ0IxN25sQUh6ZVlU?=
 =?utf-8?B?cW00aXRLWlI3WHMyLzJMSnhPc29hL09pMS8xREhINEljaDU2YWsvbTJSWUs4?=
 =?utf-8?B?N0l6K2V1VXZoMWtkWnZhMWtPNmMxRlRVbUNCcDFxc0lMZEd6Smd2YlBPdWZn?=
 =?utf-8?B?RXNMM3d1ZHlVMVlSRys4RlhJcUVBVGZVZ2tWSDRXdFVSZnBZOVhkcXpMb2J0?=
 =?utf-8?B?dU5rTS9ocWt4bDdhaktNRVNUajFjU1Z4SzlCWHZXUHZteW9GcHduS3NqWlNO?=
 =?utf-8?B?eTRnRkU3NEVTdjlPUWc0b2hhcG9TUzQvL29nQkZ4QjlCZDZGN1NFeDVqckEy?=
 =?utf-8?B?NUErTjlVamdpNGNpZUg4WU5sNFJCWnhONHFObWg1QUp2MFZ4SjlybndXRTVB?=
 =?utf-8?B?a3pvKy9hZ2ZTenF3ZjB6U1BtRTY0SEhIYVF2UGo4U3BNZWhtVWpSS2RzMk9O?=
 =?utf-8?B?bDJWYm5wU3ZVSWtkbDBjTXh2ZUJhUUQ5NTFOUllKNlB1NVFMZ3ByUnlJRVpp?=
 =?utf-8?B?WGtKWWpMeFM2T3RpZFUxV1FvblczbjZwZXRBSm5GR1QrQVZyM0hXL0MvRG1C?=
 =?utf-8?B?dEZJTDAwWmpJMFZ5UzdtWGpLbld4VWVDQkx6WUp3SXp6dzcwd3BSWmlvZng4?=
 =?utf-8?Q?sjSDqXZSNNaiJmpnTEJRdfq5a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1t84P6+oUdQKLivRrwNdHdMTLU5xTV1N8O5BKRM4JQjwnXN8tbQfAVjjGWrDI10VStgQ4vW1TEll7F+cOJS8D+w271pSqYIIldafE8JnYfl3uocMgboEskxSLnK3H92V0c9Gse7glXyMHzsZtFmxoQfDW+U2KuQAnrbRYPuYULKi4giRcq1fZwtfPqYxrV/CALOlvgOqOj3DlwTAOiZNjjxQDjZZCKUv/AQgIjXqqlR8B7L5a9oF8RaZF1AjjvH3i4mGTK9bLYuk2akSLonujrNTrZ4hMJTks2K6rP3dX6EIspwtquEyTSgHQLYAZ+Amy10d71N6YBWD50DDpJdlYlbFe05FVQHg1lQBcn/e5j+FhKp3atQRG/G7YVQXyO8FeMioOsQkK7diUaTA6TjiPbq+ZDeSAubkUT7Wu3c0H2SqG6dJP19uMv/5XmlN/YnzkpHzDwIORX/bhwrO2jIBc/b+P3q8Dkkso/agZK7zDQ2JGG9s2CQ72lKavLZh+H0jtBuM/FCLpUGx7DShsYibciEECCbkha4dqz91Zye3cNAl3oTrd7+0/t8JDo8ScQnj0K6TlsBV42GvzlOAN8/3IciIsMvig53zpVtVF0fVOZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17bee7a-750b-442e-ca91-08dd6ed217d6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2025 14:57:58.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtF6qxAiaderLR7WhigOzrNJY306CZlr9uDes6AZnrcTMHvg0LD1slNVRm/FERsEmKjThLIEYm+YPNf5RIEGzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503290108
X-Proofpoint-GUID: guJuWOdCMUxWwsm0ffobQsA7OOvKM7Ti
X-Proofpoint-ORIG-GUID: guJuWOdCMUxWwsm0ffobQsA7OOvKM7Ti

On 3/29/25 8:17 AM, Takashi Iwai wrote:
> On Sun, 23 Feb 2025 09:53:10 +0100,
> Takashi Iwai wrote:
>>
>> [ resent due to a wrong address for regression reporting, sorry! ]
>>
>> Hi,
>>
>> we received a bug report showing the regression on 6.13.1 kernel
>> against 6.13.0.  The symptom is that Chrome and VSCode stopped working
>> with Gnome Scaling, as reported on openSUSE Tumbleweed bug tracker
>>   https://bugzilla.suse.com/show_bug.cgi?id=1236943
>>
>> Quoting from there:
>> """
>> I use the latest TW on Gnome with a 4K display and 150%
>> scaling. Everything has been working fine, but recently both Chrome
>> and VSCode (installed from official non-openSUSE channels) stopped
>> working with Scaling.
>> ....
>> I am using VSCode with:
>> `--enable-features=UseOzonePlatform --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto` and for Chrome, I select `Preferred Ozone platform` == `Wayland`.
>> """
>>
>> Surprisingly, the bisection pointed to the backport of the commit
>> b9b588f22a0c049a14885399e27625635ae6ef91 ("libfs: Use d_children list
>> to iterate simple_offset directories").
>>
>> Indeed, the revert of this patch on the latest 6.13.4 was confirmed to
>> fix the issue.  Also, the reporter verified that the latest 6.14-rc
>> release is still affected, too.
>>
>> For now I have no concrete idea how the patch could break the behavior
>> of a graphical application like the above.  Let us know if you need
>> something for debugging.  (Or at easiest, join to the bugzilla entry
>> and ask there; or open another bug report at whatever you like.)
>>
>> BTW, I'll be traveling tomorrow, so my reply will be delayed.
>>
>>
>> thanks,
>>
>> Takashi
>>
>> #regzbot introduced: b9b588f22a0c049a14885399e27625635ae6ef91
>> #regzbot monitor: https://bugzilla.suse.com/show_bug.cgi?id=1236943
> 
> After all, this seems to be a bug in Chrome and its variant, which was
> surfaced by the kernel commit above: as the commit changes the
> directory enumeration, it also changed the list order returned from
> libdrm drmGetDevices2(), and it screwed up the application that worked
> casually beforehand.  That said, the bug itself has been already
> present.  The Chrome upstream tracker:
>   https://issuetracker.google.com/issues/396434686
> 
> #regzbot invalid: problem has always existed on Chrome and related code
> 
> 
> Takashi

Thank you very much for your report and for chasing this to conclusion.


-- 
Chuck Lever

