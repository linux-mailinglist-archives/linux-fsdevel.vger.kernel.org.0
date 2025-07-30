Return-Path: <linux-fsdevel+bounces-56349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E0B164B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA21188A5BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAA2DCF69;
	Wed, 30 Jul 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pGiwxkBs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cVvqA363"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B54A78F4E;
	Wed, 30 Jul 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893064; cv=fail; b=QiSp+6xK/xBdDvvq9/NNvotshM7r9hjqaxRsFhkGtPGxazvM+7EyorOzqWaZqjuD8WB0wNruBvKz1o+6rtvRUZdM/4/X+/mBMJd8qRAzpeWstL1j4d0/koCZ2OTV+lq139ac3pN2EqVC7vpkyDJyzDhaXkb9T/IgZsWnqcK6tyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893064; c=relaxed/simple;
	bh=/2uih16hsttpWcArPbg7cgOAI4Gv5HXdDt619Mky/W8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sDVodkl+Cd0jUQfAW+naWdfQcD9pFL9rja9Iq7nC1TIEzvNS5KQNJCTdtaRkr8964LIfJ6kXda5rM4JyJhe6bFjnMbJ/EFB0dVmUG4zqoZ2Z5Na8zu7u0gHkNb1UdcUn3HYl8+JbCDjJ1KoQJWW7TaZmz/5AQsCUYHhKzJw4waQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pGiwxkBs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cVvqA363; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UGN3FR006647;
	Wed, 30 Jul 2025 16:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ftPv0CawkPzedMxKpBCHj8PTqsBddHpwYgEHfNPFuZI=; b=
	pGiwxkBsrsxHX/pwwWuNdDbA+MHVQnTsHrlZAfPnr4DFLs0OO69ZJR801w4bCkbY
	jnQYbVM76BTUGTYANSgSyDqNBg3PNJFvyyuHIw2g4oXf8KGiy/G7lmHRM5+dXeKf
	0TKmD0bCvv8DTzk5G4VaC070P5h7cUQmNIfDb+ynRUjY6ZsMUvZNE9LshrRQvaSH
	CFxEn0QTEoI9Un6qNI78wHU6kcVAAqN1e0SFAeiSV3HyVB5zXdyjUjevzYmQahqK
	a6SOLSoWurcEEUqY3Jx4tvCGrmaw8xi7cuojAm0x7uhPJ1UqUo4lrx2F+ZS2vQ9k
	lmZdXoor9eNprVt0d7L0MA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwtbw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 16:30:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UFp3tj037796;
	Wed, 30 Jul 2025 16:30:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfb5x1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 16:30:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpxUqf+J2vSlFGn32yNZBgaOXKSDky/q/1gsTzgKAqxwPlSHZumlUd6jUIALauyyFBcHsZSD0A7QxjkwFCH27EO8Wgp5H/iiOwQ4GNh3X6LURaZKdl9ktx8tyJS4anA7EMaXJfh5+VHdxPZeVVJ+zxS7ecfStP62eR+UfMu3qv8Jbm0zPJUM+iasqg/M52pKOXIYjlktqAhde+kU6yCN2Xy9cNHuwRsP/ZoblD6eqkMLk7hO0tA/XkLRnADTkHGBYC5GIyDRlKJPyPTe/48GKd6FJMtWgNMBAkqao+ge5RZRZecwAMqqBs9sZ6pmWNHdGSLYBQq1tgqw91AI83fqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftPv0CawkPzedMxKpBCHj8PTqsBddHpwYgEHfNPFuZI=;
 b=Ti8KKWF5OeQc5fDgJiCZsceUewaSYsZM7K+jxol/k7ePygCgj+ATyb7pxDSEzoHS6L10sdwmr/AEFXFg3qOqzbcG4N0K1+WL0ZySeUEIBSz62oMrWZ4GEZ47LNYLh9FYs4g4J9uZon7sdOqFV1URI+h/Jtncdmk0zU9dJEeiX4fCxZAb+bc5FinImIZatizq0BmpU+mvIBp31/KjSMfmBDHSM3AiSzF9epYWnOYYD0GLJVqaKKxzppUAY5649tPKOT3AVUQB3kjyeXRsvCLwMeF7uP7WEAMIGFC3EfWQcbTXbcJ/OSfMwBBkSMKokH2Goxw6ZQCOfZsjaU6GssFOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftPv0CawkPzedMxKpBCHj8PTqsBddHpwYgEHfNPFuZI=;
 b=cVvqA363HusnIUnGAUoDdFMg4E2pbJjk7wIr9BJIWxfp/A7dhAZUjdVNITHL2uvQtxcPPKfRGtU3ZEFVRMyZhoUUHxiRfLBDtrDo40+0YEumjAcT4S8y7rpv3iEr7WVIZhYfbwna4g7dQ0nuPjYsL/jpEnjj4gK3sP1P6hy8uqo=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MW4PR10MB6560.namprd10.prod.outlook.com (2603:10b6:303:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 30 Jul
 2025 16:30:51 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 16:30:51 +0000
Message-ID: <75cea20b-3f8c-4d66-8ab1-7719a90c7142@oracle.com>
Date: Wed, 30 Jul 2025 17:30:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: Fix broken data integrity guarantees for O_SYNC
 writes
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, stable@vger.kernel.org
References: <20250730102840.20470-2-jack@suse.cz>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250730102840.20470-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::15) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MW4PR10MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 685a3eca-6a7b-460c-69da-08ddcf867218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3ZaREVtZDFoWWFydURLcnY0QmFrT1ZxOXVzYm1MS2FVV3MyR3dPUlZUdTRG?=
 =?utf-8?B?L2pRQzRLU2VGNm9ydWFNZWtWOGFNTzkwbHBaYldPbFo0VEVqRWYySU5ZMHQr?=
 =?utf-8?B?NkZhZFNucUc0TDBCSGtPY0VYYnJROXZXeU1WMm03bGtlR1MrMFk2UTdxWDdL?=
 =?utf-8?B?bHlMc0VsbXo2YmxZZkcyQWpoUlZBRkxwZ1JKaVArVDJ6VytaeFhqNU1hVnVX?=
 =?utf-8?B?SWdJM0JadHZGTnRpVmNBZUdENHhpYkF6a1FGeHM2cUJrZ05BY0N3M0JBRDBj?=
 =?utf-8?B?VEUySHZFQmxBQXBRQ3d0a0w5dlUxb1dYZlgreXpiMlUzL2NTTTNsRWhCNDhJ?=
 =?utf-8?B?Si96cmMvYzFlTk5oMjNVcHRZekw0UXdsMGg0Q2hoYnd1VFpxVVh4VC9Dc1p1?=
 =?utf-8?B?bjhoeWVZOEU3dXk5UGc2bkgrRHdraTJiVSs5YjNHdnltc1VnbURaNjVRcjk5?=
 =?utf-8?B?TCtvaFh4amNQUmNWZ1c2QlFSQ0JCMEswSy9WbHVzOU9Qb29DRlNaNXpGNWhF?=
 =?utf-8?B?bzJxS0Jja1J6eDdabmIwaWZ6YXdQY05JZk0wTm4vKzBZdm4rYmxzNDdrWjZ6?=
 =?utf-8?B?cWN2UExpQU5WQ1JrSi9RYnlINXNha0FkTHdUR29rV1VsakU1ZTJZZmw2aHI1?=
 =?utf-8?B?dVV5bEdQeGRHQmVPMUkrb2plY1ZBTEI5NEZMTnh2Vm1xVGxWb3hQRzBWaTJo?=
 =?utf-8?B?QlVQeVNTWnlwNFNsYTQ2b1RyRHNaaUF5dkVBN2VUc0Qza1JJdEc3QkRyRFpw?=
 =?utf-8?B?ZTdsMjVjL1d6dko4MlloTS9Sb0h4dDhldm5XNmFWcG9sQWV6dTZpSEh6QUJN?=
 =?utf-8?B?SUpiYjVNdWpXSm55aXVDMFpPdGIxaEtCczVjRjJoZ0xaQ05SdXFJZ0ZVYU5V?=
 =?utf-8?B?Qmc0b2FDWk5JUHhXVlI0eVpncm5mMzBWdk01OGhTM0lCcVltV3REMGZwZ0tL?=
 =?utf-8?B?bjZ0TUZUV2FUZE1KaysyS0xuSk1vMWhQRStaNVV0TUFoM1RTbEhJM2JIck55?=
 =?utf-8?B?OVl3eWI3Tnc3S0dlME5kdWtHZDlMand2U3ZwZEtjOGt5WFd4TFhBdFhGSDE4?=
 =?utf-8?B?OWZueEpaR3RoWURDN0k1ZUZEcnk0emN6MFZMOGJIaFRxdXl0eFpwNVVWMThX?=
 =?utf-8?B?dWZyc1VtYjJIYmZYQ2N3VzNVckdwMzhQMlNlQ1B0Qlp5MDFhdkw2QTMxeVVD?=
 =?utf-8?B?Z0NqQkltZTIxcmpxRHY5L3lSWUduN3VLamlGajBRVWtTZHBxOGRBbUFzUW42?=
 =?utf-8?B?Y0RTbnJidUh5aC84RlJhVHZHSEVSaml3YXF1ZmgzMEpXakR3anFHQmlkV09M?=
 =?utf-8?B?bWhsUE50YUVpUGsrQWNVNTN4czh3VHp1RmlTS0w4bXUvUGw3dXVNcWErd1Mv?=
 =?utf-8?B?MTQ0VmRVaHozclRPNTJCWjJSQ1M5bDZXdG1Na0lWcEZDUDdHbmJranIwMjM4?=
 =?utf-8?B?K24xV1dMQ0tmd2k2R25sOWxidEd5YzhKU1poVzIrbTBucGdZRWJYRjQ1VTh1?=
 =?utf-8?B?NkdoeEF4a3pqZ3BNR0krdXU0dll0MU45bGR4K2g0aE5IdkhKd1B0a20rSjBD?=
 =?utf-8?B?bzdWZ3NnZm5OR1lzUCtRejRweFVJTnVtL2RHcjZqTVBISFlPRjBoc0lvMkF2?=
 =?utf-8?B?OWgyb3dBNjI1MnFocjdPVFhRWE0zK1hmeGxlZlZBNVN3d0NQd3VHMmhWamJQ?=
 =?utf-8?B?MVpoZm02ak52Nlc3czMvUjN1dkNqMmd6U1d0ZU9vR3FiQW1iWVlwMXZ5Y0Y4?=
 =?utf-8?B?MnMxa2xTdG5OWGJ0WDhGakwra3VoNmZxYytWNFUxUUZBb2lyVDhpb3pEbHpr?=
 =?utf-8?B?NlJvL1pCaXFkSUp4djRrbVFTUU85VElpY1JqdGJFbEozMHdwRk1yYTU0TnVR?=
 =?utf-8?B?SDd4aEw2bHZUWThIbFdNN1J4NmY0RWk1RktJY0xncDc5UnNNVU0wejhJWk5w?=
 =?utf-8?Q?/vvPmsdzx4U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVdma08xcjk1ZmFCQlVrWjBWc2p3MjdONGlWQzJLd2xCa0UzcU12R3Q1dE1x?=
 =?utf-8?B?c09BUHRnaWdBMy9NdEJ4alRhbmlrVlg2czIzZmdCWWNwN00vNGNCRU1oRG5z?=
 =?utf-8?B?Yml4c2VNSGNKZ05rYjQrbDdWcTFxT2RjbURVd2dZcG95VFBLMG13MDZ4VHpK?=
 =?utf-8?B?bFBIVi91Kzl3RzdSV2xEMGk4ZHRxQk1OY3ZQckpNTlZBak12UG9Cb2tMaWNl?=
 =?utf-8?B?YmgvazE0cHBQeWhaMU8xdzczSjhNRUhjaEhlMTNVOVJDd2NVM0cwbmY5ZWk1?=
 =?utf-8?B?a2NwdjRONGJZUmlDelFPWE9zU2RNU05WOEFhMVBQSTdsYm4yYU1OdVdRSmRQ?=
 =?utf-8?B?WTMyM3Q1UURCcHpqV2Q4c2NPUlRwNnhzWldoWFFHRDhaRTBsS2VIRlZ6WC9B?=
 =?utf-8?B?QjZCOXN6NWdNUDFQTGo2RGVUYVhHaVlwUW5jZE0vZThrQVZram50aEhkclJQ?=
 =?utf-8?B?UFFNNFZaeWpic3pCRmtsbmNUYi84L0dJUVNnaHE2RGg1cGpPbTBUTHpnWkVB?=
 =?utf-8?B?L2o0eWxZU0tzbXlUMnN0b09OU29nK1p6dVJ2bVVIaFNXS0hWUmFZSEtMd1Vj?=
 =?utf-8?B?bFY0TUd1aGFFMkw5L1N6RTdsU1ZrV1ZscCtPUkVybjhSZUl3M2dWQTFXL3d3?=
 =?utf-8?B?Y1NFeWJ1M0NhZjFzamlUK3ppMW5XbGRWVlZ2dllERE1SY2FUNU9QbFV4YmRk?=
 =?utf-8?B?bEhYaTVTNHB2R2E0bmlOT1NSenkxczFBdllSUVJ5Z0pCMFA3anZnbmFMaXpa?=
 =?utf-8?B?VHlEM2hGYWFFb0VwZy9KTTBCQWdjLy9jdldwL0RWTzhmN2pjck04YTI3Rm1Y?=
 =?utf-8?B?N1I1aFV0UGtyNUdBTzNmR0doc1ZqNEk2R0dxOVNpQWVoTUo1NmdONUUzelJj?=
 =?utf-8?B?dFM1MGovN0d4Y3ZXSXFzVkNJK3YwTkZaRnljc3IvemlpakZyVlhTOEZyUzRn?=
 =?utf-8?B?a0JwcFVGemkwR3FpdGlnTWVoK1NjMGNvQVgvdm5kdWhPZFBxUmloUWtHNE1B?=
 =?utf-8?B?aHJ4b1VJa0tINEpGMDEwQkw2MjJRMEZjMUpTRlFFUktzQnc3RzZIb1BHR21Q?=
 =?utf-8?B?MWErSVpkYlg0cFo4Vi95M3NPakw0Rk1rcms0NWdiL1BxbEVrKzI2bUJmQUVt?=
 =?utf-8?B?NGFzeENsNndDWUVEcUZORUQ5R2gzYVRPaTRMQjFMUkowd3Fnay8vNnVCMjl0?=
 =?utf-8?B?QkJxL1I0ZXRzY0tycGo0WnpwWjRxVVNURnhYajc2M1FickJJNUdvM216c2Yv?=
 =?utf-8?B?U2dJa1JSUlJhYWNQSDEvU0wzcWlEQjBQR0RZNmhoQVdtMitPVHgzd2s4V0l6?=
 =?utf-8?B?L3VtZDQzT1g2dmNxZTlHeElUaE8rbTZYMjJxamVZVFRZY3lSOHlMQnpRVmc0?=
 =?utf-8?B?MmliaUYvTEs4LzQ3M1ZBS0hPc3dtRkN1em5DRjZmR3JGbHBBY2V4TlJDN0FM?=
 =?utf-8?B?RUhFMi96bDhORVBrbmJJcTc2eXpiTXlkMTJqL0N1dnRiR1IyY1hkMmNOTS9a?=
 =?utf-8?B?SHJ1UVY4bHQxZmZHQW9uZVYrc0liWGlnSFhOcjI5M2tpYWsyMXhLRFZKRzlO?=
 =?utf-8?B?MUFRTHVtYm5ZY1U5b0JKMFdTSFYvMmRBaTZVTlVub0g2ZWpKVTZJUjdTTUdh?=
 =?utf-8?B?amowSktIcUZ1eVZkMURnemtMekg3Y08vVDBMTlVNc2NRcXdwVUhGd2pjYWVx?=
 =?utf-8?B?V0w4RGZFOURaaE5xbGo1aVF6Q0Q5Wi8vOW84MkRiVEZhM0oyZFVmWEt6WWFV?=
 =?utf-8?B?dVdLTE1QRTdRUDlzMWxQdXd6ZXE2MHhFY1dUVnBaZE9ldDFmN0JjamtnQ0Zm?=
 =?utf-8?B?azk4UVNGQlJ2VDcxaUtKT2FxcDAzbDRBK3p0MWlaMHdQQ2xTUHkycHRpT1JG?=
 =?utf-8?B?N1cwUjMzUUZzeiticW5yOGppSFcyN3JBNU5qbXRPKy9HMnh4bFV3TUpWdStP?=
 =?utf-8?B?SHgycitYaEhhSGh4UzRVaXB4VVlISEQ1dkcwbHliQzN5REJPeDBTRUlTcUVJ?=
 =?utf-8?B?WlhQeitvdGhsSDZFNEZJV2g0UjZPR0d1Wi9mbnB0dFZpQW8xSzJFQms0TFRV?=
 =?utf-8?B?cTVSb0hjUmVzNTYyVWZ1REpGdGVxc2E1emVFU2lEbWg5Mk1PTVFvSHhENzBn?=
 =?utf-8?Q?CPisUch61Ups4aLVxAfj8IPWA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eIbbh1Az6zlPHXb7kp7i6lQBNOQzpviEeVTu3M4BJr6Br0UtNUzYKaDVZs9eyRDGL4PQXdd6n16UKUWozPyHi+YTcs6j5KBETAeRBf7gybnfxib3hkL4dpPbflwgcvJ7pEtWl1uYiJwmJiyFeLFDqc7Aub4fFVR8PTKI0HzOloxFAi9GlVrDApXITgGLlN4YNsybOfXLC7qg4NOD+lGX3Eudj9z4aba1ABf0N4NUfPDAheJ9p6w8yVQQcyX2Ny9RKVV2UccJ1n86EMDocoJKxgsUx9ku93K+44gHQMLopTEfDjscwKuxmUJcSeDRF45t/H9YWlzRTk8PDT3o+nwF5m7EPgr/5VREvKH6kC7SFoDQR/D5r61G3cRzK8qdc32wX2qI4XnYrG3p8uUFC/6nj8+7lKwTuVhWDqVeH9A0qblExo728wSaKfcG2IVtPy7+tuZt0eBhxx7SoKv3wxCSqsPo9AgqGhKa0FoY+jFFIhS9qOPrpvc9WVZ0fEi955/5kIf9vD3DV7cl5mb1NBucz8e9Ebamem9EpsTHuPY1kCi40ArCYJsQzcOPoWs/H2npaPo60SBrUYdjkBsMlEjZoQ6fu3gGAlPDmVSW5U2RWlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a3eca-6a7b-460c-69da-08ddcf867218
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:30:51.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 695VGW4DcOvBpizQUtvbBUitwQob4sw3oxU6Rrnco6JwSZIBGpzTNSc3rEh6JhvHNnncPoC6sFoyp7jBmEeQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507300120
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=688a48bf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=Fuda4df3uBdRhY_nSYgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ALqaZJbxPHNjtjFghIaGsDGN-CD7QoAG
X-Proofpoint-ORIG-GUID: ALqaZJbxPHNjtjFghIaGsDGN-CD7QoAG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEyMCBTYWx0ZWRfX41PYxQLOcWcL
 36Du4tYQvzRyoGoqqpeQNSjrWZHjixwvDOzRFMc6Zb9jZOwSRmhnfimH3VPgIhNfcRvoTtWmxOr
 CIyZYK77RsHsJbFEqPW37N/hW3sFZPUKogWj3sn42XF1Q219mcnbp3vzoWv8fycOChAj7RfLtRT
 ki/Yeo5Yyot0MQHxooPldIfKYyBdC91EJySDKFbeuzn1Kuvjd52ey+IdmGpmFBb4rJ3V/lMUT/k
 PvEr8YteomPn2jDhvKcz/BxVqDVq7y0buOh7AEe0A0eXVxwyu66FVZsXG8vlNn5DUC8ngdNWipn
 MkoUKwT0JrXKZgmugk4WmqhYU1Pi6lC4KhkIAipHYUkS9f2n+oAxhLeoxqYgBM4C13QahtKtlzM
 gLJQXYs2UR1XZhjzzfQ2OutoYFuI8GXfO7VVFlRvm3CGYFjq5z5Jg0wPtqh/2L91FW40GsY9

On 30/07/2025 11:28, Jan Kara wrote:
> Commit d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()") has broken
> the logic in iomap_dio_bio_iter() in a way that when the device does
> support FUA (or has no writeback cache) and the direct IO happens to
> freshly allocated or unwritten extents, we will*not* issue fsync after
> completing direct IO O_SYNC / O_DSYNC write because the
> IOMAP_DIO_WRITE_THROUGH flag stays mistakenly set. Fix the problem by
> clearing IOMAP_DIO_WRITE_THROUGH whenever we do not perform FUA write as
> it was originally intended.
> 
> CC: John Garry<john.g.garry@oracle.com>
> CC: "Ritesh Harjani (IBM)"<ritesh.list@gmail.com>
> Fixes: d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()")
> CC:stable@vger.kernel.org
> Signed-off-by: Jan Kara<jack@suse.cz>

thanks

Reviewed-by: John Garry <john.g.garry@oracle.com>

