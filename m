Return-Path: <linux-fsdevel+bounces-32881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 961949B023A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C9E280C03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4F52038A2;
	Fri, 25 Oct 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AIRdFDfg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0PqLHVNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4461E1A39;
	Fri, 25 Oct 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859045; cv=fail; b=ccqmCOnn/Zum6d+GYYwdXnIRycYcNVjOYsep5yXCGzhtK3yLkMunZUWLEFGaybzhn2z8vPcpyNLRvQr4yZs8iT5Hd3OEzAotqaDkgdsrXbTSHivni2ou8yCLCH3xgllLRgwMjLQ6DCF9SHIDy8vPq8KR3BDK5vKVKpnY5M7m40k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859045; c=relaxed/simple;
	bh=NOeewAZDXv/x5+jdBa+9punpb0eGwvRxPw7/lxfNNGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xnw9XS4t0a+0smNsYB6fuFZC/BWWxGW0opODtJhQtk19b0V4fV9H9n5bZ363TeYsL9J23hj/C5lPT90TrAyD0i/tls0+bn6ILM95IfsYOwbadAh4BipXS3WslpmZLUbac4siBl9qx/G+lb56ZPRun4htQ+wnw1SnuiLlk7QDv/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AIRdFDfg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0PqLHVNC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8CIMa001897;
	Fri, 25 Oct 2024 12:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Q/7dgF+euItslbIjLCim5Mq3blZn7aScrsipJBmViis=; b=
	AIRdFDfg9xjg2cSYx4oSo8AFLonEkkl3ELIYyiKPF9DSI+wzB2S4pMYzQMzdv0TB
	Z86nnXpIFkLeBLhjOoukMlHT5FNiqi8n2fz/1Xn1GEbXyFdb8yXgSxTIISum7neh
	XFAMqYdg5noAt2khjIosuLtg9aEWqMewaTMPaW0314lfGxeyTjxw5L0Vte9wmEjE
	/2bQf0Iws6PR59dx5lsUvWcoEcXBRSj+8tiNC8POBd6OC6qSzRAGb0+a2m7idWRQ
	WqXyHVPoARkhixfk5eydldTNq7k2KlMg/3IwUbwp3jwXHWLkP6g+jhMjDzMKotfG
	gZIPotaSe+WKfTHZDdmXKA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr42s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:23:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PC9OvE036870;
	Fri, 25 Oct 2024 12:23:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh58gcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYuwzqKY+AsXejCCNLMjovTmS1iqK2B9iNR1B1a06r/EV52LIM0IrFCJAdayAEtcV31n1XtmJDlW0ZAt4HY+cHOLKAg2jezTrgNXCEWYwtwtLqU0z2KY/43oELBoZx6rWuBEyZFU4h97yMP7YV7WcVyBBZ575bPh8vXHSNU+e3Q2Z5Q/z50U8LlepKtgakA+vckE5edn9dsZ0svdimO90P2Debk4By5NgU5kulr3BUB9C9LoLv1B0qPCvTt7SzCKJBlzVN1h98ZqI2lkiHlFngRZYfPVrrFM6BfLRNVKS2SlSAdacOMffscE5oI5aIitHUR9XVCna0GK1A7iAAipWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/7dgF+euItslbIjLCim5Mq3blZn7aScrsipJBmViis=;
 b=UD5H4AtFJ1h2m/nG6kHtLyNmhesL5tV9pWg8mS2TmG0tsjKjZyyYuDWJmhhdI3Nvgab92/Fmhos04CfAzJGTMAoF5ZkJLYWEmUfb3tW5d8+WeU1WchC3Tei7hgFZDfHZfDBw2spiFGAsV62AasdaDk8MsPDsapvszvTPhI+fL5nC8uGSNO8567rm6zj6wNMTPMZYFltKGhjP6PqRdU2Zerm0Mp8DJRYQeqASvF76EkiXucC+0PQw9UUzcn9juVcOqhQ55e1cwSU7kE+vTTcOZ2ZcyPHD43ZMv7ushegbT/Y3dYHre7W4XG8JkGHHPNfsSbrNTd0oj8OI+Wz0FYIRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/7dgF+euItslbIjLCim5Mq3blZn7aScrsipJBmViis=;
 b=0PqLHVNCf9MDd+a9QEKwCj6gxp3ios2qO/oBvtonizytVyZjGj1+MthFYKAKPy5jom95gyVN28d6TVGWfoKVrOa1XmSuHU+VPe2BaqOuLhMeGzlnf/6vIaP1m/eVMqaKF7ffdi+M5u41bWzC8gEihU8MY8IQza4TFPxSgYqBUyE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6751.namprd10.prod.outlook.com (2603:10b6:8:136::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 12:23:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 12:23:32 +0000
Message-ID: <7aea00d4-3914-414d-a18f-586a303868c1@oracle.com>
Date: Fri, 25 Oct 2024 13:23:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iomap: Lift blocksize restriction on atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729825985.git.ritesh.list@gmail.com>
 <f5bd55d32031b49bdd9e2c6d073787d1ac4b6d78.1729825985.git.ritesh.list@gmail.com>
 <1efb8d6d-ba2e-499d-abc5-e4f9a1e54e89@oracle.com> <87zfmsmsvc.fsf@gmail.com>
 <fc6fddee-2707-4cca-b0b7-983c8dd17e16@oracle.com> <87v7xgmpwo.fsf@gmail.com>
 <7e322989-c6e0-424a-94bd-3ad6ce5ffee9@oracle.com> <87ttd0mnuo.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87ttd0mnuo.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 7287aa1d-9db3-4769-1fbe-08dcf4efd6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2MrYVF2MC9BM2V3Qk0zeUlmVVlENGNCUXRIR2N2bDJ3ODVzU2xTbjc3VzVo?=
 =?utf-8?B?WmpmcXY4Qm9SMXZMZ0F2RDYxdmg4WWtxZFRKSjJtQXRONHNpdTFnWGwrbXlX?=
 =?utf-8?B?SDlqOHhHWHRLdWFpakJNeWRmaHoxQldYaXd1R0htbEU1MnByN0Z4U291blhw?=
 =?utf-8?B?RE50c1FxRXY2cjEvclRyQXVIL0ZGSEFlMkV2eWpXQ2FkaXBEODBnNllHZ3Zq?=
 =?utf-8?B?ZmhFeGR2c0tuS2Q0N0tUN2hYZitKZlh5V05lWVFCRUdlZmNzcVd4NGJHWS83?=
 =?utf-8?B?Q2hBUFhDWU0zZUVpR2YyVnBrM1c1dDBHSHlHdkdPS1VRMmYwb0VSVTJXcnJt?=
 =?utf-8?B?TWdNSW50NTRoTXpjTWNIUmkxNlYzcmswdldKV2JDbjN0NitoQkZJMHR1by9w?=
 =?utf-8?B?UmMrU3pSUEt0dmhmSWJFbDM2cko3aURvVzFyUlVGUyt5dktuRHZQbnJJcEt5?=
 =?utf-8?B?NlRvUlhTclp2S1FZV3lmY1pvR3VUQjVuNFJ1SlZxS0lvaHZpTUpmVFlENHNR?=
 =?utf-8?B?RzBFYnN6VDMzalc5QWMzcWpOa2xSblZGMDh0WFB4RFJOL2d4MUVHdHl2RmxE?=
 =?utf-8?B?QXhETndSZEk4S3g2VXJjMDR1RDBhcmlBa05lOWZZTVlGT2QwM0ZHZ2dteEV6?=
 =?utf-8?B?M1cyNklvSi9INzFWRmJYdTRORHppbDhRdHo1QlFWelJXTXRaOTlyTUdYVDFX?=
 =?utf-8?B?M3ptRWpJaG0rVjU5Mm1MU0ZBOXZ0bzZ5ZWRUanVDNUllVFRtUysrMmduakRE?=
 =?utf-8?B?VlRkZVgxMy9MOG9TRi9hM0duWkRDTUdNSUpRNERUUnhZaW02UE9YOUNWQ3ZY?=
 =?utf-8?B?L0ZHdEVvZU9yWjU2MUROekEzcXRoNW55SWhVeU1jUW9yRlBhWEhSMnovYVU4?=
 =?utf-8?B?MTlTOEZlNE9kYmV1d2dIZ2o4V3pBL09SM1pycHBZdWJ6bjhTYnBtaTdRbGpu?=
 =?utf-8?B?VHpVb1FSR0FSRGpSa3JZRTdzSHBuS2JRdUJzOXBvU1IxS1k4VWgzcjU1NEFV?=
 =?utf-8?B?UXRKZ09WbklpUnBwYzBPNUN3ekI0eCsyUXRncEI0TDh2RmJRQmlQeUFhd0tN?=
 =?utf-8?B?QUo4azRscGNIWXVmSE5oeW1xelpkU2NoaFZoV1YxejhIQ29jZXpPZWVpKzAw?=
 =?utf-8?B?eUFNVnBoS3k2MU82bDlYZ001K3FFRXZManlhZlJOLzJ5RFNCRGVSeUNibExD?=
 =?utf-8?B?L2JKNU1ES1VIM3dxMW5oNTNtQ1pGQ01kcEZzTmdYem5WRGU5cFova2o3VTJ0?=
 =?utf-8?B?SzlIaG9TK3BmU2xWTFNuVUdDRUREK0I0cWlvTUR1WkFHZS9lcVh6YXAzMHZJ?=
 =?utf-8?B?cXVNQUhjVWs1cHZ6bFhEblpsV2lTMjRYUDduY3QvOFhSdG5pbmI5ZEFvVEMx?=
 =?utf-8?B?MDIzOVgxQWFKMll3bFJwU052T0x0VWxXd0IyV3VIR25DRXhzRlhOTkFIWXJK?=
 =?utf-8?B?bDdyQnFWbFVsY1hUNEFDR2ZKdU8ybUV0eDY0c1krL3g4T0pWa1pFM2lBN0tp?=
 =?utf-8?B?SE5QZDMzSlVNSFdyVmhvcTFTdnE1NFkwS2xvUGZQZE5ZZjV4djE4T3I0a0g4?=
 =?utf-8?B?TFhsVExDMFJoQkRJUWYrd0xaVCt2OVMxUVBuZmNyaVlGdXhWQzZJWHFESDlx?=
 =?utf-8?B?YjhZbFA2MDNwRmtNVE5PalBVTldSRktIS0NobC9PcU1lY3psQjFmdkt3WXFI?=
 =?utf-8?B?ZFY1R0pBdHFycHBIOHpXaVdSakRmNUFrdnEwUzNIazlsV2kva0pvZ1d5RU00?=
 =?utf-8?Q?5HwZo5nXpkxaAxQi1PCQtq61aUSSMVujaDFzG4d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkovUzF5N3FWQkszNnZTNlpVcjNQV0dJc2JuZXJuL25SVEN5b3A2OTVNNGlH?=
 =?utf-8?B?R0xFSjFCQi9kVGJqbVBlYzQ2U0Y5cENzcDdFVzZkZzM5SjB4NVZ4TUxJamRB?=
 =?utf-8?B?R2wyMEY2QzRoUzFPSTV3SlVDZHFjbmtEZTVmaHBCN1ArcUI5VWtQRkRKdm8w?=
 =?utf-8?B?UTVkWGVmRHJzZVlZSTNacXVyQnZsNjBNaVA3YWZGaGJxNkJzeXRYblVSNFF3?=
 =?utf-8?B?Tm94ZGJld2lVSUdPVjJ2dHREb0NTR0NUdWhtMi9sYlRxYUhMcTRScTB5VURx?=
 =?utf-8?B?Q0ZvUDNzc1VvWHZ2amdVTXQzaTNLRE9lM2l0a0xiZksrSGFjMGFyQm9HZzdk?=
 =?utf-8?B?Smg3cng0eEJvWVpBWHloaHFid3hUNlpGQWJRWmtVOVArMW5SOGM5YVZzNTgr?=
 =?utf-8?B?ay9zOHVabnFyWmJDVDIvRHpqQ2xrUDZnZmFMTE5TTnpZMHFsalpxeGUvS25x?=
 =?utf-8?B?Z1RYRXZKdXl3SndmWi9EOTJHaC9nN3Q1SUVZTjFRNUgwWVZGY210ZGtsK3Bw?=
 =?utf-8?B?VWZnQlRQcmpoWTd3Qm53ZGtkeDI3dzFlUkVHOUE2OFVNNmZ5OWR5VXBhejFm?=
 =?utf-8?B?aXMrT2RPM25XUkNDWDBTK0hvVmJ1Y0hJL1Vqb2I5UWM4WXBldXVjcnpVN3R4?=
 =?utf-8?B?VCtEUnVOMWYvMUpYU2wrUy9FMDF3ZGVpQ0FBTEFuMDBlUE9QQTBZUmI2ajdC?=
 =?utf-8?B?bVMzRTc1VXVYUzRmVFUxZ0g2S2RwQTZnM1FLak9BMkYvcDVLd1lOajdqWFdl?=
 =?utf-8?B?OCs3TFV0a1ZWMUJ2dFNlUlNUZ2FDQmhFeW1FNWxUTHRjRk5GQzY1ek43ZjhU?=
 =?utf-8?B?ZzdVbXBtV0szWUw4VEJnbEtFOFU2LzByWXNiNUswektERFBCMUt2eFIxRmxY?=
 =?utf-8?B?bTNGaW1SaHo0MzJzUE5NbG84SGc4Wi9hRHEwYXllUlJ6Rk9sQ1FLMkFHcXRs?=
 =?utf-8?B?TkVKWW1tNVBueWZnNUxLdVZ3S3oxY0lsTkxBYi9VUGlzdUs4dlp1NWdQcDJV?=
 =?utf-8?B?dTU2OGRnUWZRa1RCMTVJSm1SaGFVOEFMY3lSWm0vYkJnMzc3UWZlT1NnMkhL?=
 =?utf-8?B?TmdxUlVyWkt4OHhQN1ZNSEkvd1dGem5YVGZXVko0U3JDVkxNTVMxMVZ2NFN6?=
 =?utf-8?B?WXF6Y295cUJrc0pNYmRCYjRoUWdtMnRIWHRBMzJuZ0lhOUNIZ3FGVUZaaENI?=
 =?utf-8?B?SWpKUXJvdFdkS2NGdElQd2o2Ui9ZQ0tsdHExalZxZnBYczI2NWh4Mzlwa1NX?=
 =?utf-8?B?SDBpZ216cHFEOVFPcVVydllDU1lkRU1rVjVRaFZ6T21UM21TUVBZSFRLYmRo?=
 =?utf-8?B?dWk1dE04cHlXcFRMZmpJczhQbFU5Y1lpN2QrTGM1WHZoT1RiNFY2VUdRUEw0?=
 =?utf-8?B?cXg4bEh0K3BqMXdXSzNrV0NuMjhTVS9mZGJIYTk1dHl2QnhiODFPd1plV3Zw?=
 =?utf-8?B?UDRheVdTR2tINGxJVCtHcGU4VTVFN2l2WGhhYlpsMC9IVXNLR1VqY21LZDZn?=
 =?utf-8?B?TkJyVFNyRVdHU3VRS3pTVWtuTkJrTi9haDdZSVl3Y2dWMjNsZmNIdVFjY2lr?=
 =?utf-8?B?NUE4M0xYT1l6Qkt4N2xBL2t3WlZ6eDJWQ21tbjdacjFWTlUyVDVoK1Mra3Z0?=
 =?utf-8?B?VFNjekdrTk9QdEN0RGJXeXBrMU15UlBuQS9VTU0wYlVoRG1oLzd3VTYxaDN6?=
 =?utf-8?B?WTN0OVZ3M28zTEdqOU9pcXNtMHlHS3JhQy9IUFlZb3lzUElNSWtORURhZkJZ?=
 =?utf-8?B?MXk2K0crdWx0ZDV3TVNVamFPcDNNeVVWWnVFajhDYXFLUk1qSWRUemFNSlVk?=
 =?utf-8?B?MEZobUtXdHBVSlk0Q01BemhJS2tRZWhVMUtFbkxRcFprTjlvNDNvTmdDbEg1?=
 =?utf-8?B?NnUwOEs2YWo5K3FCNVpHY2FKUzRFZ21sWUZDbTYvYkJoOGorVWZZaHNla2dJ?=
 =?utf-8?B?RmhBWXF6V0g1WE90SHB2ZDVoWXIxUmJ5QUluM09Va2pPMVFTT1JHYVdrei8r?=
 =?utf-8?B?a2drY25ESFBoNmZRQlpsZDRiRkVpNkxmS3VKMWxTTDFtWlZXVWl4K3phS21R?=
 =?utf-8?B?d1gwYzcxcmpYVE4wMUFUR3lCQlZsZkRNZHMrUWp6NHVSait5SzF5VFZ5RVpa?=
 =?utf-8?B?N3BlbEF4ZU85ZEZ0RXVCQVZSNFg4ZTZDRW03RnFhbjNxRmlhOTZaYlhhYy9j?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xPGfDd2loJAPkwTozlLbdiSbjqX+2GvyJpXxl17AcKdSe5fZJhJs8R8OWNsF3avQUoA5Liw40Pygk0qOxN+50jHujiY6wueM2G++bBNg22nuEMjP5EwIMDhhC8fdSMReAJp86jjwzpTVi2xXJli9ZZ1zZPm2g1lP6tXWbDHEnYEvP/vhg/RIBDek4KLzqNF8BxzNwe12KlQkfFJc4RG/jIUgT2C8ayUOoqIC1dnMjQoTetTWB6xCMkTqVKYqKy0GNQ43V71rsqAHqJduLslK5E19krgmlqm8KSo7dGRfIAzWpNZUKhh4uXGgwQ6IKqnhX9AVSSeZvgrSsC5tcG2e/1bpvTwy6UNizS1T5kSx8KgqxrHcOe2qhJODyyysv+1wfbbEA//oHLT2OMsCv1Pvy++YAfkhCRFcbNuOPPKweA7sp5yAY4FO7cy3FykViHEs866HOf8p/XF7GpmP6/A3gCN4sIuXMwvlUzq5b3ke3noJaSBWUOyvYVsMGEuzeApYUXQ80yN9Oh+YAfO4R9vDgkHiBpEFZHNi7tqbLBz867lP3bPmNm2JK1HvJcFaE3CktndqdKxfSHuH/ciS+ikubyLRQ+Z7z2OdXJyjFMSoFWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7287aa1d-9db3-4769-1fbe-08dcf4efd6db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:23:32.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buM1BgaW9owAzrSoAeQ3+UjhxuNiGtslJ/PuUM4sLKSh9HkzUrHIMd8wUkiNzmyufuaxLoOoNM5Z0+PuQe90vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250095
X-Proofpoint-GUID: i50r-32Arws9bJsUgaxmxw0xJEadji1X
X-Proofpoint-ORIG-GUID: i50r-32Arws9bJsUgaxmxw0xJEadji1X

On 25/10/2024 12:19, Ritesh Harjani (IBM) wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
>> On 25/10/2024 11:35, Ritesh Harjani (IBM) wrote:
>>>>> Same as mentioned above. We can't have atomic writes to get split.
>>>>> This patch is just lifting the restriction of iomap to allow more than
>>>>> blocksize but the mapped length should still meet iter->len, as
>>>>> otherwise the writes can get split.
>>>> Sure, I get this. But I wonder why would we be getting multiple
>>>> mappings? Why cannot the FS always provide a single mapping?
>>> FS can decide to split the mappings when it couldn't allocate a single
>>> large mapping of the requested length. Could be due to -
>>> - already allocated extent followed by EOF,
>>> - already allocated extent followed by a hole
>>> - already mapped extent followed by an extent of different type (e.g. written followed by unwritten or unwritten followed by written)
>>
>> This is the sort of scenario which I am concerned with. This issue has
>> been discussed at length for XFS forcealign support for atomic writes.
> 
> extsize and forcealign is being worked for ext4 as well where we can
> add such support, sure.
> 
>>
>> So far, the user can atomic write a single FS block regardless of
>> whether the extent in which it would be part of is in written or
>> unwritten state.
>>
>> Now the rule will be to write multiple FS blocks atomically, all blocks
>> need to be in same written or unwritten state.
> 
> FS needs to ensure that the writes does not get torned. So for whatever reason
> FS splits the mapping then we need to return an -EINVAL error to not
> allow such writes to get torned. This patch just does that.
> 
> But I get your point. More below.
> 
>>
>> This oddity at least needs to be documented.
> 
> Got it. Yes, we can do that.
> 
>>
>> Better yet would be to not have this restriction.
>>
> 
> I haven't thought of a clever way where we don't have to zero out the
> rest of the unwritten mapping. With ext4 bigalloc since the entire
> cluster is anyway reserved - I was thinking if we can come up with a
> clever way for doing atomic writes to the entire user requested size w/o
> zeroing out.

This following was main method which was being attempted:

https://lore.kernel.org/linux-fsdevel/20240429174746.2132161-15-john.g.garry@oracle.com/

There were other ideas in different versions of the forcelign/xfs block 
atomic writes series.

> 
> Zeroing out the other unwritten extent is also a cost penalty to the
> user anyways.

Sure, unless we have a special inode flag to say "pre-zero the extent".

> So user will anyway will have to be made aware of not to
> attempt writes of fashion which can cause them such penalties.
> 
> As patch-6 mentions this is a base support for bs = ps systems for
> enabling atomic writes using bigalloc. For now we return -EINVAL when we
> can't allocate a continuous user requested mapping which means it won't
> support operations of types 8k followed by 16k.
> 

That's my least-preferred option.

I think better would be reject atomic writes that cover unwritten 
extents always - but that boat is about to sail...

Thanks,
John


