Return-Path: <linux-fsdevel+bounces-69126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ABDC70507
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B732B2F254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F43081DA;
	Wed, 19 Nov 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKNr8UQc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QcOizIbt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8E305E31;
	Wed, 19 Nov 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572036; cv=fail; b=dpUGVxF4zqYETtKHYbvmGBfGD7BJk5FBSF60gCClZKl1u2acuntMynAgPfSE2nkE2qcA1fOtGoG/cwIohzP40CrIDE0CU7uM/f5noDBWdcFOMCb+X9xoJeVG2bLrCUzhJ3R5ltsrCZartwRQUo1l54OUXtpGWaK760a9NWWrzu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572036; c=relaxed/simple;
	bh=EGf3ppCQz7hJDFKS37M3uFZakbazj997jeQQ6K5mP9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FaKvMudKiSzCwhK8fqTims2QGPuqrYcsUWF79sOiOUWiv35Z/wWdMcUu/V7p9YUhLAo3L6dDnKl5RVZO4Pk2w/UVCiC/PGYYAFRuH2g9xixcVI/lWv8jNgbkGn7lLPNn0PFm0dFWhvDUseYTKOGnoirP3kn/bSp9Kt1futZ9g9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKNr8UQc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QcOizIbt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJH1WSL031608;
	Wed, 19 Nov 2025 17:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EGf3ppCQz7hJDFKS37M3uFZakbazj997jeQQ6K5mP9k=; b=
	hKNr8UQc6u0Dhrce68RfhZVIqUtURIWwmMuQzkSzFWt7glOs0NtvZUhqniFmgj2g
	jULlVgsI+x9f1PlAgy3S7eqVa0hs0sprme8wx0npYpd6ssbcvRRSfW8dVJ7+THUG
	xyojnXNVb4c9+BPlJfCEZblqYTcsd3zorjdqeFUWN+glVTBH/D2EjP4ci/NukMPi
	eeYO47eZp4huno3LdkjckecQsXDkqX7/ykSoMvjH/3GN13uE450JVU6ydkjuwQyd
	iBQGKrUlrbUADSGRys4SaE8OrrLQnOEx4yza6P+k5gQ6JvWkVVj3w1NHKbU19zXN
	EvJJXJvpe/rT0/2PjymtwA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej907jrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 17:06:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJGJVnc009810;
	Wed, 19 Nov 2025 17:06:41 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyex7ug-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 17:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGfGoPF59/vhl73fDycgRU7ZH4dJF7Be7+kSdoUu5i7GEBLbniuxjwYS3U+mUHEC8qJLKeYZjJXNU7XAE4CSEaxWg+fDeEzMfWxpLY2uwZ6FQAdgP5c0gfLIckTQby7TdtZZv7mJVj8VT78HEL3JqsafO2Cg3yyGrDDykNBexKmIMxIFX+snJ2IPKJMJwJeqjc3DpEyhRKxwdOYKHLUP8CpNO29Cx2zK+D51nUCt34EPB91RsRV0xqlizKGugPpXFDLYrH7muvk3cRtO1hUMk+VRe+DQU+sYwsbg0I/RY9+XxkYs4kh4V6SSh7Zea37h4iUWEiE434AsmHCrFv1nfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGf3ppCQz7hJDFKS37M3uFZakbazj997jeQQ6K5mP9k=;
 b=F1Xe7OWPg4abfnWdJnCGhsfX9cAj9dbxrIWaY9S9yk8ib4H2sl5a8rdxjieiBQX/Xv7+yeWNM9PtsthF0FlKFrRSKmtZou05V5NcJltFoeiJIecuhzZmyedHtpnCvsYOS0XhCljSW8dY323sZse9VVEJS+MFXZUQQiUrmsrp87VrJis/U42+2V3BRafj0u7YTkD5kOOvF+F2ixJLfOAT2ybS2DQOTC9jI2+bTFAeHHOIaRZ/n7cMCoPR9A8oJBsuYKhwo6zKwG+P5Bj3vGw0xViMm+XqcZvxDB/RJKcjWiVfZ8NvxbxqH+rdl4E9OryJjRAIgHcUw6zHJ+0Iid+crQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGf3ppCQz7hJDFKS37M3uFZakbazj997jeQQ6K5mP9k=;
 b=QcOizIbtD8WnYVoxMTpk5ndpv/dkEqvav9LI18waJo6Q0vkR3uGpZPR2N7LWLggfevI1sS7bo2T4XvAp1m4eyH9d5vVhO4sRwUPHfdLvjbdCMwMRWx4Mq47xDwyx3ayJauQ2yuoXozl+lsqQ1yUPFcStHY7qPiz+Mp1FG0HmTVE=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 17:06:29 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 17:06:29 +0000
Message-ID: <f30bf78c-9bcf-4ed2-a73a-fe8854e19def@oracle.com>
Date: Wed, 19 Nov 2025 09:06:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Chuck Lever <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
 <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
 <20251119100526.GA25962@lst.de>
 <dc1e0443-5112-4a5d-9b3c-294e32ab7ed4@oracle.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <dc1e0443-5112-4a5d-9b3c-294e32ab7ed4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:217::18) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 13011859-b959-4a40-fb1a-08de278dfb3d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NVNaOE80Zm03VzVPTExxaVZMRHdCSjd1dTc5NEljM3hDa1NDOHROek5jRU1F?=
 =?utf-8?B?LzFKRWptV2k0Wk5JSmltSk9VSms0VU9Gd1hmcEJHUURaOG01VEx5SmxmSlRS?=
 =?utf-8?B?eFh3UUh1TjJwdU0vZVpqa3lPTzJKZm1pYkJZZ3BuOVN6MDJkYjI2MFlhZ0RJ?=
 =?utf-8?B?cnZiNXdmd2UvNnN2QUZtV3hPSWszN3pZcGh4bU52d0Z0Q0p1a2FUU3hOb1dV?=
 =?utf-8?B?eVdId0hTNldvelBxd3VzUVZSOGptSWlKa0V1WHgrV25jQXZRTnArVTVoNmpr?=
 =?utf-8?B?dVFReUIreHYrYlI4Z1BnZWF5bGJua3UxQ2FhamI0MXFzYnlWak5TaHdpRmRy?=
 =?utf-8?B?OFJyekhXL1RGY3dSZ0JKMnRBc29Wa1lhbG1uTW9FWE01WFpadFVEK0dwME1G?=
 =?utf-8?B?ZXZMTFVwMGxwdll5L0NVUGk5TlNub0l1djlyLytJLy9iNVF3Ty9ENUhyVG8w?=
 =?utf-8?B?RUN5ODNRejVoazlWOGV3YktGK1VjNkc1cVhOOGNoMlcvRGFRYWg0bmorUFFm?=
 =?utf-8?B?R0dmeUY2RmRIY1RGYzJheGlwZUU4N2NhUldHN1pGb0c1WENKcHUvZ1NCeDNo?=
 =?utf-8?B?YlErYmk3ekMxNC90dk9kcTJQU1BPK0t2aS9ocVVWSUhnYjlrMm4wUm9SS3Jr?=
 =?utf-8?B?MXJibWZVWXBQdlJmNFl4QTFqTmtPUXBIYzhoMDFoSDBOVEFPeTEzNzE2bDR2?=
 =?utf-8?B?dHRiZ3ByTStxM0p6TlVlQUJ1TzZTL1BwaGU3Rnl1QWY4ZXBsQWpGeVBscTBX?=
 =?utf-8?B?YjBFWFR0bTN6ZmxXREZjU1lOaEkzeEVwQS9vUDNLczIvYXRhcUk0MXd1M2U3?=
 =?utf-8?B?TEQ3clBNM2p5RndtT2dzTVZXeDRCdXdvL1AzU0FLdU90UVJoRE9pVEpIdWhP?=
 =?utf-8?B?K3RteVhnMThxOWlFcUwzUFVrakNNVzBoOGJ0Sk9weENVbFk1R1RsUHVrRXNp?=
 =?utf-8?B?OGNVK0tiZVFOOXZXd2g2TkRHbktXbG9YRlNTVHZrZlZHY0tqdTYxd0c0U2p2?=
 =?utf-8?B?TVBMa0dUejJwbEpFZ1BmdUNrSjk3VmNZSGFvbzBwZmgreC82ampoQ25DR3NC?=
 =?utf-8?B?UUU1M0ZXTHR4TGZUQ2ZXbXRLVUU3Nm9NTVpWR2Z2bEJlTXlUVkU4aGdUK0FN?=
 =?utf-8?B?eHBORkVKR2I2cVlLN1ppeVVNT0xmdlEzWGlpUDdkRExMRFlhdVoyQ25wMDJJ?=
 =?utf-8?B?VlBXTS90dUZXOWtuTUVSdlFrUTJaOTE5TDEyS2NFbjJBaU5QTnJISXVWbUVO?=
 =?utf-8?B?bW9UcFdjUmFtSE1qaWZmYWpseW42YzZNeGRwREtYajl2ZGEybGZLeFVic2s0?=
 =?utf-8?B?S255TmE2Q2V5d2VvZHFOSzl2UjFyLzBiUG5lU01nYXlxUjRvUlpnVXpnSXM0?=
 =?utf-8?B?c2JzZVRHT3IwSDZJS29VWStGWmp4ME9KRGRISldldHdheXVPQmYwT3JlWGpn?=
 =?utf-8?B?TkhoQTRMUGRGaG44Vnc2YVJuL1JjUDJtaWo2bHBZbzdGa2F3enNWN04wblps?=
 =?utf-8?B?VWZaQzBlUmUxcVhEWWNKSXVjWkMwbjB5RllQSVFPclMxS0E1bkJZUFhpanVB?=
 =?utf-8?B?dHFvU0d2SHZPaHlVcHcvYXFtRHRONzNRV2NScThzeWpIZ01pUElGTXp1eWZI?=
 =?utf-8?B?blc3a3V0UzdnVVhhcmZONG03ODdDUHhFOU9LZnVxeG5Ia0dNMEJRVi9tVWRE?=
 =?utf-8?B?RUhiWEZLK3laUkRnalB2Z1ljUjEyS1o2bktDTS9IRXNEWnZRMXJiT3owOHZx?=
 =?utf-8?B?ck9NZlovSlE3WU8wVW9LV0kyQzBMMmE0c2FQQWd0NmtoWnZ3Mm9Wd0Rtbysw?=
 =?utf-8?B?TVFnSXcvUjZhazlVMXI4L21aaVpnWWR3TmdMbUxuZ1lGajF3bXRTQVVYMWts?=
 =?utf-8?B?OHcva0daMXZPeGRQbzMyaEpFV2FScnNta21BU29FTlJ3K0ptaDF1TCtuTC9s?=
 =?utf-8?Q?1iW8l/ee78itp9eQ87YOjk+dCjPho4ra?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d3luVkErK2xmZFZZa0FLTGlpSjBKTURGY2Z3ZWttMjBJR01qZUJIQUJ1ZTV5?=
 =?utf-8?B?NWpIQWFIZzdwV0tBc29iMTBqM2JHa0hnS2VPUlhQVCt1ZXlKN09oQnhEMjFp?=
 =?utf-8?B?dmpYVmgxcU12Ylg1VGswZEFyUHJFc2swcWxrY20ybm1VZVM2RU51dmRVRjNz?=
 =?utf-8?B?TzRISGhZQSt1YWlqbWZIZFYyNmRQR1oyMTNWMnFuU0luYVd4NHBlOHpuWnVl?=
 =?utf-8?B?Q1k2eXA1QnF3ZjhtVzB2WUNyOThkcmxlZW9HUE9pYkJDcTVnQXcxN2NUaWR5?=
 =?utf-8?B?a2Z2YW5NK0drYkJhK3Z2MFJtZ1VaeDNlUUVrMXZYdjNjUVVNL1Z2ZlpPMXZy?=
 =?utf-8?B?dWt4UnZUZ3NaVFY1N2c2MnF6RytENUpaNmtJUURyV1VIS2prZHRkUWlXVUJm?=
 =?utf-8?B?Z0RtcjJ4ajhkTXpOZElPNHpzMDJvaW1aM1ZaYytsMXdqOVR1TFpaU3NiZVps?=
 =?utf-8?B?UmVpa3NlQmpIeWphMnJ6dGtPN0VBOTNlVEM4MjVhZ1BKOG5rWkZvSEN3VERJ?=
 =?utf-8?B?QjZockpJMWpucGZ1a01FaTF4SytiUEdiT0oyaDRqQUZTSGgxUTFJUnNUazhs?=
 =?utf-8?B?SHh3WE9ZZVVNRVlBVzRlL1dJY1c5QjlvRUdIQ2hycVpMSzJBa0JERkhMc0VM?=
 =?utf-8?B?S1lTMTQvdEFBV1ZwNlJ5SUFJL1ZBRWFjU2RXaHlFZ2hobFNtV1g4SXMrRHhV?=
 =?utf-8?B?MUhmY3AyYlJSRElXUjlvNGxNVTFZd29jUXBGai9LcVBnTGRjZk5rRHo0a1Vi?=
 =?utf-8?B?dGNzNHNLaHhFSnVPV0M4alVSRzFaaE5GNnRhbUsxY0h2SUloMWltTFlFbTln?=
 =?utf-8?B?MkhxRjNQZmEyNk5OVUZLSHJIWHhwMDhWS1NUVlJSZE1QY3VxSGdQWkNtUXI5?=
 =?utf-8?B?K0tnYldDS1B4QU9DQ3k4K2w1dC9CUnEzelFnTmJSUjlBc3lhdzdnS0ZuWWxt?=
 =?utf-8?B?VDdIRCt0SEVmcjVtb0NJY1ZvMzJIemFKb3UxT0hJWmFCSnRHQ3RrMWU1SXlv?=
 =?utf-8?B?NWtpLythZXRPaWtIcGc1WFdrZG1XNlNoODh6Vll0NG92UlhydDF6MEpZQzNP?=
 =?utf-8?B?ZWF5RUlrZEw3VkZSalRGNjFnTk0rcHJGbHJ5V1QzcXlrQ3dMSEtlK2RXOU5m?=
 =?utf-8?B?cXVvL3VES3FtWld3WXlESTRoVTlsSmtKQU10RXNjK3BDS0VFTHM0MjNGRHRi?=
 =?utf-8?B?aGpwempYVzBLS1VmNVp3TlJjUkR1N1duNHFCV1pySElsdVBzUmtwcitsTU5P?=
 =?utf-8?B?aERISkRaZlFTU2hwNWwwSW95OHprb2l3QnhVdWxBb2ZqZXRXL1dXTVU0NW5E?=
 =?utf-8?B?UEZBZ01SRUJkakpseUM3MjNCbitpTjhaRGxZQnh6K0RJeTlzSlptSmlNYzky?=
 =?utf-8?B?b0lJVmorcnMwSklwZUJId0FvV2lWUTNZTUpmZ3FmakR6L2hPcS84YUdKRjh3?=
 =?utf-8?B?UG85bkJETFVSMDZKRGw2U2JBbC9mSW43V1IzaElMTDRvZUZlVWpDRHdqS1JI?=
 =?utf-8?B?b0hiNFRkeGEycmQzMU5rZFMzNmJHUVZpclkzNHZ0Q0V6NWlQUHhQWlRMcTJL?=
 =?utf-8?B?aVlqQ0tKSXBBbmZnQUx3bnhqQzVkU2x6dDBvQ1RrZlFwTEFycFNZYVFEcHFk?=
 =?utf-8?B?K0JDSjNrWE9SbEVvZzM5L3VIMFBvY0p0M3J6b0E5M0cxZDB2VzZua2pobWVE?=
 =?utf-8?B?VW9QUFRoL2w2aW1GTVBHNUNtajVicU56cEpXb3RlVUdRelFCSlRZY21PbDhn?=
 =?utf-8?B?MFhmUDlxSzVjbktYT05GVjdDeHc0WGp3bHdTWHhnRGxNTFdPbzZQOU1Walo2?=
 =?utf-8?B?c2UwcTJaWmRQMmtJVk05TitieWlKb3VscUE0VkpOWUZjcEdVd2QxQkhhQTBo?=
 =?utf-8?B?R2xxRDZMclNVRDRJd1ZtZnJVUVBZME9YVjA5dk5aaWNWdVFWYjc2M2Vua2RQ?=
 =?utf-8?B?emxrYTcvZnRiRHJRUzJWa0lDbzdUZkVvUDkzaTVNQWliMk9CVitRNEtLUUZr?=
 =?utf-8?B?ZUtnUEprVGZhQWwybWN6TUlPMXk3OU5vRFNrbEFoVjZWbDV2dytBU3NBVXlo?=
 =?utf-8?B?MnpGTm15RDZLYkpYeEI0LzBVL2Y3ei8xRXBLZ0toRDNqVFNnek51MmQzc2Vz?=
 =?utf-8?Q?Rl8aTwTOwSdNSwGe0g2cG9E3h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L1x7r3R+zgAufybRslJDezXMd/QtvBz0D/Olq29EaSoQVtWTnWoLexlomYnBExSUvjCU0wW5D3LKPVfU18g5uMFiiptV1tTaCGsEzigJOY6lAc+AZEHGBbadSICJun2BlwDuhxpcMj7LzkVePIenT0O0gqQMrKsu0LXNQGpLzoeai3Z9CA4bO/5N+I5b5zTp9YThaj/heheTLMu/cUHInppiFEcmJ+k1d/RRqqLUiq85ke4+qJt+LfhQxc4uavZE9aby+NTVw2D3rS37Vka83N9u70z8+Y46PlFKmm8PwsKgiLWun7v5tZcPmk5BO8q5OeXvvoz/wE+buyNpGbJuJ0CbG5LETDW93dHbjR6skf/smTPoXHt+E6/wE8LYE3csNEvCYSv6gu9Ej5gHTA6iknWPsqP9VBHOim0cAyXVa11hGumpXWUZguLOcEfE5nBT8MJuOqZ3kMnYwyWrAFjv4//c8CW8OcG52Z97maiFk0h2CEoWTc/6IfCMyoTs/hoRZkKMfen6uOuQhL49XvNBEorlN0SgcbTEgCSGGxGhAdipg8K78FutD0Vy5C2Zcq8YhmbSDuUYsOTqEs2vACMy44WIoEC9Okko17+IZNjo0Xs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13011859-b959-4a40-fb1a-08de278dfb3d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:06:29.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJU2aW9OXFlkmi9NmQhYShAD/4PTTNIxBXmkje0CNHpvlm3cag7uzrJZvQlV/zxY6JcyZUYAh1pzKXgQjsCzsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190135
X-Authority-Analysis: v=2.4 cv=OMAqHCaB c=1 sm=1 tr=0 ts=691df921 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AXSJHUIW3yP0EtZ7tdMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13643
X-Proofpoint-ORIG-GUID: HNXkk7Yupw6klx_m4n1_97WBAsokCHre
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX5Kk5MDOBCrtT
 VY2lKwBQ7yWlkK++wUNg+4gRZ6u0VS+JoSgb4puPEKQ4oLbA/0Sn5bRxmrd/+PXqKiUpKSUa4lP
 2zlmvqP96ag6q94Pu5QH0n2XhG11eeTMOoKXNTMMqhDMxpLvxcuOueDXdKrswtBJpD2HnHzFH/8
 2oNcVd6GiOB/jR/aGsox7x5q4Re3a7Aofow80/99hl59E7Y6FXBp9pxlQBxaiDR3O24V/Z3yIkO
 zbQvtOftdfgaChto22AilNucCG4UBSRxF4WAbR+GRTjhbYCUPqCex2YsgCZ2MD236ft/MKJxpxn
 ofrQSvnwQvI9yeyZTayO0Mbcdiz0Sn9srp+GuMsCdbIMeN0tmh2TkTyMEVG1/x9eVs16t1RkEQ5
 0riuzd0RPDXwjfHpKb5lW8oI4N+qR/9okTk1vVsB/wrMepHqXF4=
X-Proofpoint-GUID: HNXkk7Yupw6klx_m4n1_97WBAsokCHre


On 11/19/25 6:09 AM, Chuck Lever wrote:
> On 11/19/25 5:05 AM, Christoph Hellwig wrote:
>> On Mon, Nov 17, 2025 at 11:40:22AM -0800, Dai Ngo wrote:
>>>> If a .fence_client callback is optional for a layout to provide,
>>>> timeouts for such layout types won't trigger any fencing action. I'm not
>>>> certain yet that's good behavior.
>>> Some layout implementation is in experimental state such as block
>>> layout and should not be used in production environment. I don't
>>> know what should we do for that case. Does adding a trace point to
>>> warn the user sufficient?
>> The block layout isn't really experimental, but really a broken protocol
>> because there is no way to even fence a client except when there is
>> a side channel mapping between the client identities for NFS and the
>> storage protocol.

Up until at least 6.15-rc6, this is in xfs_fs_get_uuid:

xfs_warn_experimental(mp, XFS_EXPERIMENTAL_PNFS);

> Is the protocol broken, or just incomplete, assuming that other
> (unspecified) protocols are necessary to be provided?
>
>
>> I'd be all in favour of deprecating the support ASAP and then removing
>> it aggressively.
> If we can say with some certainty that there are no users of the pNFS
> block layout type, and there is no way of addressing the fencing issue,
> then I'm willing to consider removing it.

I'm all for removing this too. With the latest upstream code, I can't
even configure the systems to use block layout anymore. I think this is
due to a recent change regarding device id but I don't have the exact
detail and the commit hash.

-Dai

>
>

