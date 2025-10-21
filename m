Return-Path: <linux-fsdevel+bounces-64968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48134BF79F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99985465E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7D347FF2;
	Tue, 21 Oct 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ofGSZYpN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FToOgR63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2732110E;
	Tue, 21 Oct 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063475; cv=fail; b=kiQPp2lHpIHKvl4Vm1ySY60qhvNsOdCZNdMpFjwa7GYQ1vxzwJXMyxjd74IAW9S7S86btVraohkzyn4kHdjrzFV9+XlsS80lf/+7+mku632koP4aaTxf9KnJPXWGj1fygRpNNoIBnBMxO21ujD9zgzpdOnYxqd6LrcK/rB7Wnvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063475; c=relaxed/simple;
	bh=nUL0nhKEyFrcJb9S6m/BogFIvXgp/g3CokMY5fiJLSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgAo11Rf6Uh4c76Do5FK4H0UqKEs8NlrVnRX53mUvYJTEqCQscil4ZASfCicR8a+13KhxTjVFGM8m1UDR8IIFWEE8YMW6laiiC2BfQq0yAV76ShyGSEteNlQ0oWJHrakvwwaYVIAoZmEyHlERoP5Bju33wcEfvPPpK6hepGyieM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ofGSZYpN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FToOgR63; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEIcvE001981;
	Tue, 21 Oct 2025 16:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fgNEYsAYAM2cuu3NgVXRYrzIFJxiS+XowSmjMJcOMbg=; b=
	ofGSZYpNNgqWyR6jnF5pAQ6WgSKk41a7r4lhkKy/hvy5zOU1hWvLRqqPfyt37tIZ
	erkcOaLPf8k+TU2baVH08BK0F3ObtsMg06FMS4t0PHQCeHkeeMbp7xOFIc3zd/1/
	V2NOg3HpRLqsRfpaASM3OQk9Y0G7pqClT6Ng+QKeWrOkIKzPlRJ36hZrTxZmOQeB
	SEEM5n4SN3NCgvSMxAOgbJ80L0WJpQ/Zxy4wXAb8IHyNY4/+GRcaz/dk2sTw0vb0
	pULsTaL5AJo6PzdHIb/mU8h+hc2sr8OHGc09vo9ZTdGbB5r5Wp6pGOl0ir+jmpoi
	vdyVMhRu7uZlOPmlpH5dXw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d5xe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 16:16:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LGBvgM007169;
	Tue, 21 Oct 2025 16:16:56 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc9rmg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 16:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3i8fmUsGmQyaI/SvRNEvyp4uNfUtJnde6XUeiZOpXGMkE6bN0TfR6MTVRWETCU9ahohyKXKwDt8Kk0ociBxW6+FDjvQWS0c2zYuumDRm3l1tCSpFxw2eQH42YNTBo63BCud8Hij9L4B5fUFzg2fm4hXr2xehoseqPfnk9Qp7N+UU1oYpq3DA/JJOA7/GEgTEKHRdUVTFIVNpWK30Sj1SyIRQLeNwjD5cn9p8gIxOSggM9YSfUJelzCgJs8rrZ+b5DPi/moq6Xms5zso35eDtVOt2StoYgNtpE6yM/26E3lIJ2SvRLDiBg+kYV50Cm080a260yaQ7YsGEVBh9xjv5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgNEYsAYAM2cuu3NgVXRYrzIFJxiS+XowSmjMJcOMbg=;
 b=Z7FGVW3alVoyBgzpN/of472VqDQSY1P+tCUt9Q99O0JxoekVgiD09zTR4ktb6dr5W20E28q9mpkJB4oLGJc0Y2RMxxyBK+mneDjuqx500gRTO++70Ul47gVayNoUiRfuSoHFOfqOkFT3Cmgb71xuyMdUTb/EYMKiN2F06TR6ASWWJH7ui6VKiU5I2G+3No6kfGSzjANagbOoeDYHrdFpfwkPn+WQChcfh6IhGQTSqO4txDHW53EPxL/pNHu/McL4ZDeYr4rb4fbbsplmt76ZgFzvKSkHyv0pL5BQ1WogjHzBK9MZEOTZ7DV2rjzYxn2hKcUizzJqcazIZFXBgO2P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgNEYsAYAM2cuu3NgVXRYrzIFJxiS+XowSmjMJcOMbg=;
 b=FToOgR632t0/mTyTqaAL6aGPqZXyNlnLwCj46A5RaF5y2XSe/ZVqjg7Zkrb0Mverx+njDNXn517SMBLtIyXalv2UTwryE7y1MCSmnT89D4+xeu8p1l/Ee0K7P1+qPl4XxKEadfnJMaw/Im1e+4LVSGw5UYIMO3MQvcMFLU0jTVc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ1PR10MB5929.namprd10.prod.outlook.com (2603:10b6:a03:48c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 16:16:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Tue, 21 Oct 2025
 16:16:49 +0000
Message-ID: <49ed9d32-7e15-4014-8ae3-98850895b02d@oracle.com>
Date: Tue, 21 Oct 2025 12:16:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] nfsd: wire up GET_DIR_DELEGATION handling
To: Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Alexander Aring <alex.aring@gmail.com>,
        Trond Myklebust
 <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Carlos Maiolino <cem@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, netfs@lists.linux.dev,
        ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, netdev@vger.kernel.org
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
 <20251021-dir-deleg-ro-v3-12-a08b1cde9f4c@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251021-dir-deleg-ro-v3-12-a08b1cde9f4c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:610:118::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ1PR10MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf52dd5-b6dc-4e2e-11ee-08de10bd3cc2
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NVd6UTNxYmdYSVlmaUowOG1zWGN4TFduMUdDc0EwWjl1alFsaTRXeHVzL3RD?=
 =?utf-8?B?QVRMazBzRk5lRTJlUlJBV2d3Q20vWVBsak0zKzhuZm1YRFlvUWdoQnVjS1Jo?=
 =?utf-8?B?amdOamN6MXh5NlJhY2cwTGpTZzhua3c1K3I4aDFWd3B6ZGt4VFZ6UVE5cnNu?=
 =?utf-8?B?VlBiVlptYlZKK2xUZE5yZThLYldtNDRHRlBCQlJIYkpRRTJMZ3A2Y1lSMGxp?=
 =?utf-8?B?Q1FZYUIvcXZVSjkwalpJZ1g1R3dPS3hkUzhzR293Y3ZqSWQrMzk2SGswRHpw?=
 =?utf-8?B?QVhITUM3SzdiYUNKem5zeGhuUGphajlLVDJmYzd6K0VPTGtxMEdwaGlxZXkx?=
 =?utf-8?B?KzM0RmlUeGpkbFA4TnBZclJNY05jbUFCVlhralh3UWZZUVd3bGl5ZDhFV0dN?=
 =?utf-8?B?TjRUdjdMOW1iQWw5QUlqeTNHbEs2c2NkMzRabFJ3dGE1VFJ0aGNlR1lDWEZs?=
 =?utf-8?B?emRDWU04U0x2c25KMkVIT0tlenJtTHVaT1JyUXcycnY0a2l2UHdNbVo4M2F0?=
 =?utf-8?B?RDFMY3FKQVQ0ZlZjV0huc1dMVWZydXFiZTJZUEZvdWVOZ1FWMXVSdkV4cTNp?=
 =?utf-8?B?eld5dHpMcDROUlFFQk9ROGZBR1FDOXZwbkFuWm5pTzUrTkM3VE9yTGFJdCtq?=
 =?utf-8?B?dnd4YjJpdTY2bHFDdEk0TzkvZXQ0VklHbDBPVjBNRVJyNFp3ZWhvSHB4SFNK?=
 =?utf-8?B?NTd4WmhmRFJJN3o3RXZkTm8xSVR3WktVeUV5NGFyYklxWWxJeEVMdlVSaEZr?=
 =?utf-8?B?dkNNZGFHeFlWdGRTZjF5SWNBT1hhN1JvVnhTQ0Y1NUlid0JRbUdRVyt5TmU5?=
 =?utf-8?B?SXB2aS9QU2hhVFB1dWd1bUx4U3crWlVBYmJzWHlCY3lEMFFvOSszME5od0NT?=
 =?utf-8?B?NDlCRHdaRjZSd3NYczZqTVpoREkyN21HdjNoVkRIMCtMd1lsMzMzVG9KQ2xn?=
 =?utf-8?B?cG1Oc2J4b1ptdE1ISjNaZDl0S2hDeDJET1lCc1JORm16a0RBeHZHWHJ2eW5R?=
 =?utf-8?B?ajZ5aUtueUZoQzZEVDZhSGhDZ2prTVlQYkY2NkFMbVhaaEJkemtSZlREWEdK?=
 =?utf-8?B?cTRRUkU5aXRXTkJrK0JVa1NvM0VPZ0RHRWcvSVFaSXhoVHo4Q203RGtaSEU2?=
 =?utf-8?B?bmpjUmRoR2JQYUVMS1psdmhaSjVvT01zZUtSMkd6ZXUvbG5kNzBDTWwzTHFh?=
 =?utf-8?B?M2RrcGl3UWo0TTRTYnl2YVhHVXJGMm1ydTFIV1FCV29taFFHNWlKSUc1NXNT?=
 =?utf-8?B?c2plRHBvT0JCMkNSRzFuSEZFVlZNK2J5U290WDFvbHBZZjRKUmtrMk1kTGcy?=
 =?utf-8?B?cnJQNTVrNnpOZER2bUh6WUc5V3dqL1FzTmRJVHlwazFUZFhjdzNUMXRQWWF5?=
 =?utf-8?B?MGFpUkJValVFaW5XY3c4akR2ZzJHcjVoSmg1TTJzM1BNenlkK210bmhYZmFC?=
 =?utf-8?B?cnlFeHljamVsL3J1QnFFVGYxa3ppMHVmMXFhRVM2TE5QQkZPYzQ3SlF0SGxu?=
 =?utf-8?B?RGxpYnd1aFc0NXRXQXdnTXhoV0xZd3dOOG5WV1NxbC93eExBOU1WRjFDckgy?=
 =?utf-8?B?VXZtVUs4WXA2ejN1MkdqZTQ2SjRlbGdveHNuUWtWVzRNdUxVdS92UTdjeHph?=
 =?utf-8?B?WGxMaElsN0Fnc3U4b0U3VFRodXV0NzhLd1R5NXUwQ1BVNVozaE16TlFKMDVi?=
 =?utf-8?B?eHlnUlgzbWRMVThXUUczcjFXeTdhQTArVS9XS21jU0huWS9pRjhMZU1QaVQ5?=
 =?utf-8?B?T0E3bWdjd24zQUtyT1pVQVNBN2l6MmhVVFBkUG92RmFxeVd6NENoNzJDR3JH?=
 =?utf-8?B?MkV5bElkcjlHWU02RWVnVUJwSXE0Y2lWdjZSTWJsMHBmNFpqUHlrVEh0NkVI?=
 =?utf-8?B?eUY2QldML3ZOeVZ2MXlYYlBDUmpLSVRCSWFxMTdmdnZWekNCenArZUo2Rklv?=
 =?utf-8?B?WDhNMU9keXZXR3Z5bjYzakR6QmRobXhvdnFETktXY0FCNjNlVlJMT2J1OEdP?=
 =?utf-8?Q?rotcn6j0GzhBQemXKvx6ZPMB1vP6RY=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UFRMZkRQWVJIOVZTY3dpb3V2TUVCVC93bzZ6RXQyS3owem1ZU2R5NDM3RGlI?=
 =?utf-8?B?Q3N6Q0tEQ2JKeTl0czV1bk5wcHFuOXh4NGRBZUNvSkJWcVJiNlQ5K3lFQmNs?=
 =?utf-8?B?MEFWRkw4ZzZ2c1hWZzV5WllNNlgzQ1dOd2FFOEd2VmVzME1PaXJDRnptaFdo?=
 =?utf-8?B?eWVUMGdEUVZDRklQaWkrMURnYm1OcS95QVp5WStsNFkzMmh2Z3RXYXAxWFI5?=
 =?utf-8?B?bkJrb2Z0bjI4Rm1MUkxXNno5aVNnSk41VWljZ1VqZ1NyQnZ2TGIwcGNuMHhr?=
 =?utf-8?B?Syt2WlE1NXdDSnAyOXlsTVlrdUNLWXdvWDUvZlE2ZFRXSVhmYXJhT0hDekF4?=
 =?utf-8?B?VTNkb3RPalBPUU5iSldwNmUwVzBFU0RDWW5oZ3d1SFZ4dCtvYm8yb2h1QkNj?=
 =?utf-8?B?NGRnYndlS0FIdnExdjErS2NJTjN1WWMvNlF6V3NZYmVvMlJxOUh0Yk85RzFF?=
 =?utf-8?B?VnVQU2pTOUx3UjExREhZcFFGNzBuUC9CT2QvdjlRemNiSm5jdjVMdS9idDhO?=
 =?utf-8?B?TW5UWnZXNC84R0haeUhLRFVKM2xZU3hjRVFUK2FKbzFtWXpwa0hodi9tVktE?=
 =?utf-8?B?cjdRRHJqS2xvMHRXS2hoQlRPUE1zaFpCS29FaCtOYzcrMFNBS2hLVUJ6MXQ4?=
 =?utf-8?B?Wkt6YXRtVXNQTVA0QVVlNUVmenBiZ2hyK3YrQjFHQUhBcEMwKzJodld6TnlT?=
 =?utf-8?B?TTBZZkxLYmNmeXVFanhUVHNxMFFaRE5SSjB5cEc0b2poTGVpLzNValJzcGQy?=
 =?utf-8?B?VUVaNkZaTk9WSUxoVVJJVTZyU05PNEZqVG5VVVNyZ1I4dExObWlwQnVCbm41?=
 =?utf-8?B?eU9aQlFyOSt0cWJmVjJHQVZBQ1QrT1M2RzlZMXk4UlhwWFRpaC9EYzdHRW1m?=
 =?utf-8?B?eFdUMm9FVm8zVzQ2YmRRSDNiTStabkVxNXlqREg1dStHNHI5TEJJK1k3eTZ0?=
 =?utf-8?B?VEVxaEZUVWpiNEE4em1jVHpORWIyYXVRZnYxdURkcTdENU1aUG84QU1jRmhp?=
 =?utf-8?B?c25Ed3VGMjBOSWRGV0REdVo0Zk5BNjQ1ZU5YQkpvazZCTW9HZXVWZ0tSTlox?=
 =?utf-8?B?OXBZbWtpaGtxQWY3V0pkRWNyeHh5MUwrWnpQR2VseGNsamptLzZNcFZsaDhJ?=
 =?utf-8?B?cWpzN3BTV04rUWkyNXByMTBuZFAwL1ZIVURYblJxbjNXbWM2eUMvT2pOWi9q?=
 =?utf-8?B?MGowd1k2WW1XZ0pLaVY2M3Q4TjBEQVZKbXFGZG1uRzRvYzNZRmZWVmc3Skdp?=
 =?utf-8?B?aUhZb1g2WTA1bUx5SlBDbGNaejY3SXV5Szcwdld0bFFJcDBrb3RCYTZsMVBB?=
 =?utf-8?B?Y0RFWUc2SklxZVFpMWpqVXFHa2lGOVJTUTRhUGEwMkc4RWw5THVBaHF6SDMr?=
 =?utf-8?B?Wi9oMkZYTEF3S3FpaFE1Q25RMys4TllyQWcvQ2Y2NnBRSmdhanF4US8vb01W?=
 =?utf-8?B?WFdqdVB1Q2pTMEp1UVljNXpJaEk1WlR6MUNzRFZCTGRFSmlSd2t4SE10UWdr?=
 =?utf-8?B?clNQL3EvaUxLYytyVDNETE1scENDaFlTRnlFR0dzbFlSdmNMY2RPRHZyb2xi?=
 =?utf-8?B?ZWdKMEQrL0lPdklPZlpldUJOWnd6RGlmTUhkSklUU2NVU2kxT2JKM1MrS0Uw?=
 =?utf-8?B?MjVSMTFnd0x4N0JXMTVTclpDZFZsRE5ISk16bHJMVlY2RFdCUFRXeWJaRU1w?=
 =?utf-8?B?ck5VVDhPUGVsOFdrSlVrdzZIWkVLcjB4c0VkUEZXY05nR0xNQWhRUjFnbGgw?=
 =?utf-8?B?TVdrRWtFZTZ3dUFWZ29WbmtyWlE2VDVYT1MvYWJyNXFqZGxyMUZXWDNZYm1X?=
 =?utf-8?B?RHhGRWZodmtFaG5pN2pkcWVFQkNKVXRPWDZZSkhQcVlXS2pMb0FDTy9rYW1Y?=
 =?utf-8?B?T0x6ZnpJK3VOZzYzdmpReXBjVEVaR1BlWXZQVFBtcnVTZmdoVk1nSy9xcVIw?=
 =?utf-8?B?TndXVEl0eDFUVms0bFlGWWYvcHYrUHk0UU9zaDFIbHIrK3MxSmJrWHA3VmJ3?=
 =?utf-8?B?NFh3RnNXWkl4QXFmZXdOQVlkWTVWbXRJZWxueWxncFhEbVUzYzdraWRNSHhG?=
 =?utf-8?B?V2E2dnVNQ01UblZsb2VrUE55UXNZVVFwclFNa3VMVWJieWc1N0ZDUm15Wkhv?=
 =?utf-8?Q?PTggNszdMO9J2SxrX4WqUaN5u?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BqGz/zHp27L2L4RGAlo252E6lEBQMwwHaKhcN40sx+JkQPmHMVxYl83414/Za8w6foSsG9ueB0a7zkAOvr+xGX7WZif2ToY97Utg8F7PmF++OVd4TWzk6NTKY6/YlUPRoBGkb3Bwxo03IaUxEsCcVVcneCXLJcutGaYb/1qsm5hxMOYW9vLYfgE56KBqLYnUPE/VrJsTtnGKlk43A0yj+NFS1RLJNMpQvulr5YF7y8PCZzQaHcU9tFA4OFmewLkz6uY6neUfIRSAYLJjiE3qLoWNxMKExnjsHdp+V4eqYxvjdCHqjSyjUDwpDb+IaOQ1ZzP48OK9ap4XomNqNH/A2fq/2I/jHwxpwScgqOs+U0X0RQdOtV2xSATEG/fGZSUPPkI+97OYDsZwg5eHQO5HGJaxkWoovwJ5jQATSzDi7tWqwz7h0V86JrQZu2yY8TTdSk90zDmipNednqaWLTVx1/lmbOiCQhzNXpSt59693GMy1rX02WmQX8txQqizcH3OaMED7HMh17l98X1SFKXWYR5ALQo5tdgUdmBj4cIFRG0sIBmmFg2D60NVURlQ0mIKmfwD2KUlIT45ghaHRN5I1ZM/o/5bO5kaTmStKUMQhrI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf52dd5-b6dc-4e2e-11ee-08de10bd3cc2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 16:16:48.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44CCdIVeraRdEYjJLJruvlcQC6Ud3gBVl9DXU7EgdW2m5qjGbgQe5mzEnZRuZZDtO6HwAWJ1vvRl3jjVg5dB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510210128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX5UfhW9bBZVOL
 kEw+LzILDV6EhFQqZR1wjYjIxuvjwoTXzFyO/T8cvRz40VZJcr4VdLYzhCQuIbePYMR5xjGpg0I
 8WG/uLqM1NbD3GoZvE1S1gNLPDurLtE7yMbE96vHZNA9Qq/CDdA7niPfYB/sj477wVAmrnxa3xT
 MY2QAKlNd21cgcf+hXmdxaongSkIuvdw58UWJ3xuE9DEznHhHTw2lMRjnyv7w7D9dQXFumCl+9z
 AkxmqP9Qbt2wmcJvIE/22whIyUueyN0QhvVGC71YtNm/PtuJHBSrA+if/y8aHIh+NpIQZ4Ey0ic
 n4HhBT+CMZfAWO6Gkexrv4/HFvT3DAXUuiZK210GpGRCAgLKCqDGzf9c06v3cGgE4PElRJLpp+D
 DXEzfWePmfXqNX/kbpkMNibtVy/BgQ==
X-Proofpoint-GUID: 5qasBpMgpFb9Yb1AwMt6yxdy4uIdvVeP
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f7b1f9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=_f52hmyKKtPQ7mZJ_noA:9 a=QEXdDO2ut3YA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: 5qasBpMgpFb9Yb1AwMt6yxdy4uIdvVeP

On 10/21/25 11:25 AM, Jeff Layton wrote:
> Add a new routine for acquiring a read delegation on a directory. These
> are recallable-only delegations with no support for CB_NOTIFY. That will
> be added in a later phase.
> 
> Since the same CB_RECALL/DELEGRETURN infrastructure is used for regular
> and directory delegations, a normal nfs4_delegation is used to represent
> a directory delegation.
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4proc.c  |  22 +++++++++++-
>  fs/nfsd/nfs4state.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/state.h     |   5 +++
>  3 files changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2222bb283baff35703b4035fa0fc593b54d8b937..4f0b1210702ecf4eaa20c74e548aabbee33b7fd1 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2342,6 +2342,13 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  			 union nfsd4_op_u *u)
>  {
>  	struct nfsd4_get_dir_delegation *gdd = &u->get_dir_delegation;
> +	struct nfs4_delegation *dd;
> +	struct nfsd_file *nf;
> +	__be32 status;
> +
> +	status = nfsd_file_acquire_dir(rqstp, &cstate->current_fh, &nf);
> +	if (status != nfs_ok)
> +		return status;
>  
>  	/*
>  	 * RFC 8881, section 18.39.3 says:
> @@ -2355,7 +2362,20 @@ nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
>  	 * return NFS4_OK with a non-fatal status of GDD4_UNAVAIL in this
>  	 * situation.
>  	 */
> -	gdd->gddrnf_status = GDD4_UNAVAIL;
> +	dd = nfsd_get_dir_deleg(cstate, gdd, nf);
> +	nfsd_file_put(nf);
> +	if (IS_ERR(dd)) {
> +		int err = PTR_ERR(dd);
> +
> +		if (err != -EAGAIN)
> +			return nfserrno(err);
> +		gdd->gddrnf_status = GDD4_UNAVAIL;
> +		return nfs_ok;
> +	}
> +
> +	gdd->gddrnf_status = GDD4_OK;
> +	memcpy(&gdd->gddr_stateid, &dd->dl_stid.sc_stateid, sizeof(gdd->gddr_stateid));
> +	nfs4_put_stid(&dd->dl_stid);
>  	return nfs_ok;
>  }
>  
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 8efa37055b21ca2202488e90377d5162613b9343..808c24fb5c9a0b432d3271c051b409fcb75970cd 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9367,3 +9367,103 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
>  	nfs4_put_stid(&dp->dl_stid);
>  	return status;
>  }
> +
> +/**
> + * nfsd_get_dir_deleg - attempt to get a directory delegation
> + * @cstate: compound state
> + * @gdd: GET_DIR_DELEGATION arg/resp structure
> + * @nf: nfsd_file opened on the directory
> + *
> + * Given a GET_DIR_DELEGATION request @gdd, attempt to acquire a delegation
> + * on the directory to which @nf refers. Note that this does not set up any
> + * sort of async notifications for the delegation.
> + */
> +struct nfs4_delegation *
> +nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
> +		   struct nfsd4_get_dir_delegation *gdd,
> +		   struct nfsd_file *nf)
> +{
> +	struct nfs4_client *clp = cstate->clp;
> +	struct nfs4_delegation *dp;
> +	struct file_lease *fl;
> +	struct nfs4_file *fp, *rfp;
> +	int status = 0;
> +
> +	fp = nfsd4_alloc_file();
> +	if (!fp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nfsd4_file_init(&cstate->current_fh, fp);
> +
> +	rfp = nfsd4_file_hash_insert(fp, &cstate->current_fh);
> +	if (unlikely(!rfp)) {
> +		put_nfs4_file(fp);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (rfp != fp) {
> +		put_nfs4_file(fp);
> +		fp = rfp;
> +	}
> +
> +	/* if this client already has one, return that it's unavailable */
> +	spin_lock(&state_lock);
> +	spin_lock(&fp->fi_lock);
> +	/* existing delegation? */
> +	if (nfs4_delegation_exists(clp, fp)) {
> +		status = -EAGAIN;
> +	} else if (!fp->fi_deleg_file) {
> +		fp->fi_deleg_file = nfsd_file_get(nf);
> +		fp->fi_delegees = 1;
> +	} else {
> +		++fp->fi_delegees;
> +	}
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&state_lock);
> +
> +	if (status) {
> +		put_nfs4_file(fp);
> +		return ERR_PTR(status);
> +	}
> +
> +	/* Try to set up the lease */
> +	status = -ENOMEM;
> +	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
> +	if (!dp)
> +		goto out_delegees;
> +
> +	fl = nfs4_alloc_init_lease(dp);
> +	if (!fl)
> +		goto out_put_stid;
> +
> +	status = kernel_setlease(nf->nf_file,
> +				 fl->c.flc_type, &fl, NULL);
> +	if (fl)
> +		locks_free_lease(fl);
> +	if (status)
> +		goto out_put_stid;
> +
> +	/*
> +	 * Now, try to hash it. This can fail if we race another nfsd task
> +	 * trying to set a delegation on the same file. If that happens,
> +	 * then just say UNAVAIL.
> +	 */
> +	spin_lock(&state_lock);
> +	spin_lock(&clp->cl_lock);
> +	spin_lock(&fp->fi_lock);
> +	status = hash_delegation_locked(dp, fp);
> +	spin_unlock(&fp->fi_lock);
> +	spin_unlock(&clp->cl_lock);
> +	spin_unlock(&state_lock);
> +
> +	if (!status)
> +		return dp;
> +
> +	/* Something failed. Drop the lease and clean up the stid */
> +	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
> +out_put_stid:
> +	nfs4_put_stid(&dp->dl_stid);
> +out_delegees:
> +	put_deleg_file(fp);
> +	return ERR_PTR(status);
> +}
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 1e736f4024263ffa9c93bcc9ec48f44566a8cc77..b052c1effdc5356487c610db9728df8ecfe851d4 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -867,4 +867,9 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>  
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>  		struct dentry *dentry, struct nfs4_delegation **pdp);
> +
> +struct nfsd4_get_dir_delegation;
> +struct nfs4_delegation *nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
> +						struct nfsd4_get_dir_delegation *gdd,
> +						struct nfsd_file *nf);
>  #endif   /* NFSD4_STATE_H */
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

