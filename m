Return-Path: <linux-fsdevel+bounces-77161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOT3AW9rj2mCQwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:20:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB8138E52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AB3F3034A2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0B27466A;
	Fri, 13 Feb 2026 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JaEVMvLp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pg9gg7HX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685A231842;
	Fri, 13 Feb 2026 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006821; cv=fail; b=ZXslQQ8miCxtCOqWxnAmasaCkT/l66Z+K9rsYjB0qBRuw5Z7Pg09TygCcTdcT1qmyx2z0N6aHDwPgY+i/y4LJgBRIwVImZQIXXmWFysMTOVKOhioMsCBqZFN70hTQnBsoU7t9Am4O8SVXlsqdHt/L1JrNEDgnVz07she+yamHA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006821; c=relaxed/simple;
	bh=Aw32f122z8/jA0ROcSms9NcHtUKFc1tkS4u8vg0pe68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FzpWUZX418xy+MykHRPYHpi09ai/fxHuO4P7pDwhL9eKEBxEOMc3CY9BAYbDezauPR2S8OqfkmwdO2jzzh07P9CTREIk7ZAtGG57aBRmS1U4ffFHpN6/kouTLOai3GhPymzFX2uzjha/+SuCtcdSudjMSZUKADAP2zVckvSfQHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JaEVMvLp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pg9gg7HX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DDbO0m3491021;
	Fri, 13 Feb 2026 18:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=A5GGIcpxE0LufpUzFcxETciXjKBrVOUaHQ1wb21XPJQ=; b=
	JaEVMvLpoD5+y9v9lLx4zoRhqYa9X+ChnaNAsoiC6RWjMLlBzNrsdCk5EJTwwy2o
	66G6pPm9zkJHiZUsT8NUlEL8szho+YNG5X226DVxYXo4Pwk4pl6vbVYR8/KEgulT
	JmYuFQp949vuO+KAzdP9/oWV43Elb3C6dTV//Vyv0mhV07QJNke3aMzwxu4e+USN
	f5vmboGiPM8OpQyE6oKY6ndZj9Adbtz0VccU6q7USZYs9Xyh5AB92B8bhWkLG139
	k+5FXmP20lH4PrWDQ1uhEjMackbS6nEzolhG1g8D0XKep+PkHXFttjhrvQOMJOwj
	7BtYRQsGCVseOP5w0Ded/A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c7rxu724u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 18:20:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61DHkU9l008564;
	Fri, 13 Feb 2026 18:20:04 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c8238vx91-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 18:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0bvm1ld1sLOukGY8RnNbUY52J1EjLO+Efgdj7Y0SgtJH06uKQCYUP/seGqCUzHEzVrIigVxzQsJ7MB35AWKrIpjnVTJvEsH+b2r9xpBHJbHCNVRiRy2IMA21DIQCZbXPz7rKU5kAxI+cdn2wpcsbwCKAk6DHuaT4wmVW/o21ZqMuVZzNM2d2NelqA7wuZbNDSyhyx++PCK3vy9VhF8OdY2FvIBxCbI8jp04RYaS2S1t3b9FjowiHV9+RcxGbjPGZVyO3NxQu8XgYzPFOIDXwEFGXvxEIoUjJRVe0NaIv/Et5wgC8zWui3ZxC4EbV5oJEPG9lo2PC+gLJz3DxJjzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5GGIcpxE0LufpUzFcxETciXjKBrVOUaHQ1wb21XPJQ=;
 b=kAoctncnAbeTVS8nELAhs+yQ5GV7TCbK31OEW44bp0ffsSdmSnfP0RHkKqRqhoHn4xWkdxqGDo3aDLsFt9DzyMAjyuuyQzuFsACdA5lbwdUduIEA4St2M9ymDIEPxQT0Acge+8vGD8o4RIACPZ47ST+jsu9Zrr8w81+LwsVh7cUXYKn7nIXoBX6hnr3Py7dWJ3O5fa4NGq9LXBMnjPNTUTmHHW7OSACXqswuDLSo0jBE2ecapFNiHlAU9EpzJ7fiYVw41bdlJUFJ6ri/H1zLu+fe6DZkuLp6MLGVcwVqqIFnv19NuRzf83I6hRYscxxGkHT54XBWu3CV5yManCjIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5GGIcpxE0LufpUzFcxETciXjKBrVOUaHQ1wb21XPJQ=;
 b=pg9gg7HXZd3qQMG9HN4Bjtm5RYL135GuxY9ug1plL6I6QRifJBFneFIzVZP9r4AUxoxrqrhrXfhheIV5pTE54HngNbHpJwSbY1BSq1khCNHkVy2otNgR9PD/x8UWjMWNyMosqXF5X8+lpau9+OVjw+OarLW86h4LOzUyrlFhN10=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by CYYPR10MB7569.namprd10.prod.outlook.com (2603:10b6:930:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 18:19:59 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::8386:1d11:46b2:b163%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 18:19:59 +0000
Message-ID: <67ffb195-aab2-4069-8eec-4aefbe03336b@oracle.com>
Date: Fri, 13 Feb 2026 10:19:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/1] NFSD: Enforce timeout on layout recall and
 integrate lease manager fencing
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@lst.de>, Alexander Aring <alex.aring@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20260213083101.3692692-1-dai.ngo@oracle.com>
 <95aba237-f068-4d0b-ae45-3a6db1176226@app.fastmail.com>
Content-Language: en-US
From: Dai Ngo <dai.ngo@oracle.com>
In-Reply-To: <95aba237-f068-4d0b-ae45-3a6db1176226@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::23) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|CYYPR10MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c549cb-67a3-417a-ffe2-08de6b2c7f29
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UE9DcERXNzltc1Qwa2JyMEEyUWZ4N2IrZFBWUnNRd1ovRTNCak5MYTlEYkp6?=
 =?utf-8?B?RUVycWVLTkZJRG85ejVKSmFOL0R6RUpLeG5MeXNpcU1vNi8wVjZQZ3N4WUVM?=
 =?utf-8?B?eU5PS3Noc25udk1XdU1DMFFURmtyOEZHUGhkVU45UDVYSTlJdUFrcU5pY2x3?=
 =?utf-8?B?QVY0SWowUy9QZmNlNHhTblJqVG0vZ2h3eEd6OXJhZXorcnZ2TEtWZkROUmx2?=
 =?utf-8?B?c2pGOXJ4M0VuWFVzbjVhTjczOWtpV1NkQ0hld0I1b2U4bk1BOXZ2YzhmMFJn?=
 =?utf-8?B?M3R3Zk9temFOM0c4YWVrU0hUQzhNVHpiN2Y1TmdjNDNWUTNSQTVSeXcyVk1R?=
 =?utf-8?B?MFpsZ2wrM052ZDBHNTV1bVJYL3NPNEU5ME92TlJ6b3puMTNIWmh1VFdMcW94?=
 =?utf-8?B?UzBqYWZEVjdRNWF1RU9SMUI3YzltZUhENURSWmt2NVo2WkNsSHVXRnhsYWVl?=
 =?utf-8?B?R2lPZ1Frd09vYlFML0EzVDcvUzFQZThxbjM4SUJscExYQ05TcWt5Nktqa3h4?=
 =?utf-8?B?a28vSzN2MWU0TUo1VStJaFdGc1Q0enR3ZEZQblordEJQL2NVeGY3RWVSNkMr?=
 =?utf-8?B?RzU1L1NvaDlVRk42RjNQbVlPSUFmajlTVjI2N2dvZTZqS0xySFQrRkUvejNS?=
 =?utf-8?B?cVIzVXVNWFJBSnZkd0dQdy9Da3kxVEZqbFNlVU8vblVwTklqRHBtUy9ndUxS?=
 =?utf-8?B?eUZzUTc3TGsvajIrNXBBWVVRQ1BGeEcreG9CaHNFTzh3YWlDTmM2Q1R1TzI0?=
 =?utf-8?B?bUNBM0FReXdBYVNqcTRtVENJblplb0xUdGIzbUVlUEVUUXhXRUNHSlpNbEFp?=
 =?utf-8?B?N21aNVE3RGFMaWNPNCtlbEU4RTdBL2h3SVpOMEdIbGtWL0Ntbyt0b1gwVlFL?=
 =?utf-8?B?OGluYzVhdHEwTTBRZUxMckF5aS93UUkxcmtYVTdiY2FMTndZZ250WEJOMG5j?=
 =?utf-8?B?eFY2bm1Pd3hYRThqMFRha0I3Wjd3bGVQOTBCR0JqVEMyM3gxS2VRT09uMkRT?=
 =?utf-8?B?aUFURzkxYmVYN1RWY2FjQWNua1NhZFdOc2ZiQUxvMCs3MVArZXE5OWs4V0RG?=
 =?utf-8?B?cTFqemNOcnlrTC9tOXA2L3RCYUg5b3N5ZHZFZDgra1dFU3lXRHpMRkFENzBF?=
 =?utf-8?B?RmI2cEE4OG1rc1ZOTU5MK1RKcDdjbUJnelh6NzYwRGZERkRWdGVjQ0dEMlZu?=
 =?utf-8?B?NWliRzhXeWVYMUpZNUNKM2lqNDhpUFliV2F0eHhnS2hROWJOTXZKUWpXWUVO?=
 =?utf-8?B?ZFlpK2x2eC80V1ovSFRReVduMHF2RGJ2WFVYZ1hhRGFuTGdnUE1nbkVSbFdT?=
 =?utf-8?B?M1A3bDY3aVBlWkZaOUZQYkN1WWVCK2RUWFRMS2tsY25KS2hsRnZ2S2hyOExy?=
 =?utf-8?B?aU1talFKYW56NVJGK1VNc0pwbFBPUi9ZaDhIc0wvMXBJcWJ4VjY0eUY0ZEpq?=
 =?utf-8?B?UjRDQjRwVEY2anRySjB4SjRtd3RNdDY4c3ZkMkxTNVEydi9TYzJ2amRHSjZG?=
 =?utf-8?B?a0JMTGVhZVJoVmtOQjk0SmI2Z0lIOWtwcHYzVlpYWEd2aGFKMldxcjhPSTY3?=
 =?utf-8?B?TUJhbGM1TGdEWElPS2x4Nm5aTzI2QjE5RTRtZXVSVFg4Z2pnZ2VBMUVWLzd2?=
 =?utf-8?B?dkNKT2dmOUZXdmFDNE1aSGRCZmxNV0Z6YzFEcm9OR1RvNlYyQUkzMVFXYlE0?=
 =?utf-8?B?QlRCRGsrNzA4N3U5NVhRMEF6M1VGa3ZsVHRWSXVVem4xbnBic1RMK1ZNTVhE?=
 =?utf-8?B?UmozR2F1UVRtK2FkTlEyN2lzUElIUHhOMjRUeFBPTU9MQzJNbE1kVFAvK3Ry?=
 =?utf-8?B?bUsvR0dIL2NsbCszZmVlczJmSEFHcGtWaTRuRjc1eGtvMUgxM25uZjRJNjNH?=
 =?utf-8?B?ZEMyOVdLM3hNb1FpNTJsSFBKcnQ4bTVyR2NFQ2E2UVdwQU9NdTZwYk45UXQz?=
 =?utf-8?B?ejBoMGplK0tOb01YZ1JsUVB6K2xpb3VLY2Rpc1V0c3RmbllPcncvUGZWd2hm?=
 =?utf-8?B?aTZ1ZnljTTRaeGliVmVaRVI5OWVqR0VrNGUzTzRjYnIyMzIwcURuSTRxSWNp?=
 =?utf-8?B?dzdyUlBad3ZKeUZjZDFJSyt4YzNWbytEZVlLTS9QTURsVmoxZzRPbUJSNG9X?=
 =?utf-8?B?dzRDRjQxNGtGQ0x1ZkFySUJRRmtPZ3k1d3BEWjJsaExIT0NzZk1QUjVrMzJs?=
 =?utf-8?B?dlE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VHRzTXE2VzdoMHV5dEp5emVwNHkrMGg4cU5pbnBOaGlIb2NUNHVuWitvczVT?=
 =?utf-8?B?WitLVFVQMjhpMkI1R3VLemQxVmtoRGMrbzdmMFExZmRyMmdwenVuRlMwUjBT?=
 =?utf-8?B?Y2Z1dEVGMGllZ3FaTHJSS2U3eXNvdnFiUk1FYndJb25JWVNxNURrNFdaTUxh?=
 =?utf-8?B?dkV5TGx6S1Vlb3pLL1QzTWt4TlMrczdvaktuaEJMTFAzR29STGxKTTJLYmVh?=
 =?utf-8?B?NHc3TTBkalVML1BJZTRkdU9GVVNzTGM2SU5pVmdMeExvZ3UvckRYL1VJa3Z2?=
 =?utf-8?B?TnRaamc2bUtVMi85VmxweElHL1JOaTZJd29WV1plNTZnZDlRL1p4cmZlOHA1?=
 =?utf-8?B?YkpVRG9Ja3FDTVhHdHdtbXpQcE1UMDJ5MFRJcVE0SlRKZTQ3V3RacG9BRm54?=
 =?utf-8?B?anBGYWtCVjlycjh0NlNwaTBydXVhYTNVeHRBc1lab0xkNGI4YWZBakhXcTBi?=
 =?utf-8?B?RDZHTmEwSjk0ZjVmRUtVZHpISmdtTGJYcXUzUDZXa2JHdDlhSGZiS3lsd0dK?=
 =?utf-8?B?bzM1R0I2TnJkTzl5YWR4OVp4WTlQRytWc2hPYU9ybU1lSDhhZEdiQkdIeFVl?=
 =?utf-8?B?SWJPUXpsOU1VNHVCam1MV0lWQUN5V0ZFMU5mci9XQlRvK1ltUlRJcE1WOE5C?=
 =?utf-8?B?cHR1ZjVpUGd4SU9oT1ZaN3g1cjhweU5PQlQvZkFsSFpMelFmbS9BM1JKcml0?=
 =?utf-8?B?RVR2eXZZTE45N3VpRkl6RXRzbUVMWjRqbTEzcWlvMWFNYlJuSGdSa1hLYTQ4?=
 =?utf-8?B?MDVSL0RYN005UDlqT0NtMXJiaVdRYUtyTi8rcWhzbjdlVEFGRGxiZzVCTmpB?=
 =?utf-8?B?WHJPcGU3RjJpSjR3Z1dHZXd6K3laNVlSSW1nelp3TWFFY1NpN0gzdzViSkJN?=
 =?utf-8?B?MnUva2tnWUFyNHVYemlHTFBCUWZtWmxVVTEzREhFNzg4d083VUNaa1RybkJY?=
 =?utf-8?B?NzlJejViSlB0ZUcxcSsycDVhR0JxaEdsSFB6UnNXQlUxeVF4R2YxYnBqd25y?=
 =?utf-8?B?b09idXdWSTk2My9nVVh2TFM4NTY5N3IxSW1KM2Z5Yzd1dlNUUDdlTVFjcExa?=
 =?utf-8?B?UnhWQ0U3dmRMcEoyVUJVaDdxeWsxQWM4VngwWVVJbWprTVJ1M00wRzZZeVRt?=
 =?utf-8?B?R3pLbTJuNXhlamV4U3JYSXFrNkJEYUVOK3VRVC9mSDIzSG03K0tHckhiaVFr?=
 =?utf-8?B?Mk5qc2NadnBTeGdEYVdwWUcwWERwcTJGdTM1ZnU4OGJxV0Ezd2h4NFBtQVNJ?=
 =?utf-8?B?aE9JRW8wUGY0SXZCRHRVWi9LZytJM204c0x2bGxQZXRsdFIwNWNtQkwxZVlu?=
 =?utf-8?B?eklXNGpTOUZCTjEyTEtWcXRUbGppMjcrTUpKeVhjbGQ3ak9TbTUyeWVFdC9D?=
 =?utf-8?B?eW1UdXdJRDhzUk0vUDA5UVBscTdLR0JCWS9lVHpFMVdLQUVvOE16TzdRVHE0?=
 =?utf-8?B?TkE0d2E2a0Y2RnhRc0R0Y1RQNytqd3F4MW94SysrWVBxcmhPajRqbko0d1Ez?=
 =?utf-8?B?WUh3U0gzRVpscGZEOXdSNzA1Tk9oeEVoUWVIYjN6cUFEMWF5L1dmM1dDdDRU?=
 =?utf-8?B?NDRSZG5HK01PdFVMQTVEZ2EzanlHOU8yem9vOEwrUURvMW1ORDNSRnN2UGxI?=
 =?utf-8?B?RUt0MEFPakJaZGhGbnVoVkxKN0ZVQW9mYllTL0w2VXg1VGZLK08zTGNYNkxX?=
 =?utf-8?B?UmJsQ0RCaUR4WXRPZ0huQXdRK0hDZVZqQm94bGg4a0w4ZUNRbmFuOEcra0Zx?=
 =?utf-8?B?OFpHTDFHWUN0WHlnR0JWTWN5T1pSeDJSdWx1elQ5KzVzTnNZOXdBVnFlQXBr?=
 =?utf-8?B?L1laVGxsdlpCRnI1WHl5QmxIOHp1anhwMHhtdnhZLzFNcTFmdXhjRC9KLyt2?=
 =?utf-8?B?SC9ZeUFMMSt6SG9Hc001UVIrcVZFYzFqSWFTNU8yVVVVN2VlczNOdVZPbWsr?=
 =?utf-8?B?bG10b3JLTUs2RlhVSDFlZXl5U1c4N3ZRVFVJZ3U1MUprbytyV29iRUtTNmNE?=
 =?utf-8?B?bEhXSFB5alRLU2V3TnFlaFNsWURGZTRxUWNIVGNOdGFzaG9KZzBZOTlSai9s?=
 =?utf-8?B?MWRGMk1TUUwrQ3d0Smk4dC9lekl2N3oxTDRmMTFSZFRNeXNyU2pFUFkzNUNU?=
 =?utf-8?B?QmdOS1dMZW9SSGd6TGxoYjZoekRrRUdCSnVDNDBudkhFMGJMcFVvM1pYRmR6?=
 =?utf-8?B?eGxuYjVXRjhVanFhK0hjYkhsVGMwN3N3bVJ4SDFDd1hicGp0REpXSUxIWkJY?=
 =?utf-8?B?S2gyOXRxRVdNeDg3bDVYOUgwT3pLMmZEZzNCZlVPYm5NWTN6M3AvSHFOR2dt?=
 =?utf-8?B?Y25uQUJqTnRtQlF4cDFUQmJOVTRlOHFTY2hJZUNlUmorZUxvZGlEQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s2SkrZJRcfSUp3J9nlr/AXwSQAV2gyC9o6atxNxdY9ps8KwM9uL2XouMZSDX2ACPquZlAcfqOOlbSlbEgGkm7EaNcFqjxOHH8fMjZiwm/8djnHVP639Qym32GelT8MBHmHUuoTKuyM4O/mesCkTnVNnqbPxK0wUi1hfytiTuC8jSrZljhpb8IqGYKTNkMK1vnKr7BmxK0JDn3sEpTrzOSE6++odjSblNRORnMlzMRg1IEAfTSGT08m99ifblFHLRrh8/VZqDfRvUcBQdg2JGPEoZjYE3HJfwNqGvBFT8z3vOcdtR2uXHhEWZGn3waes+DBUKHFmNi+2V1xcAZbJ4nYaabIQVWX0wcX694gWpiXsktV2l09qJwEpQv7c0aUXcDP2eCaEla2Yja3Sj4LAW9UGyLk6qO5paU7IDFCIEiOSbXsip82AD0HbvgDyT8vpvw6RV67ph9Ctjq1SaANpx3AxGVZoxcTgyo79lmCsS3i698cdYBxTU0wujOTfhhBpgT66Hz35omNszBdzEX3BD7DWfumMT5lPy+x9VvvpFrgh0o1R3eaJk4HU3h5xliRieF3hiwULgOukTH8iYP5MG1S1G4TT9aPcq3lK55Dd76So=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c549cb-67a3-417a-ffe2-08de6b2c7f29
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 18:19:59.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k70S2Te/ow3vbH8OwgCxsybhTeSjsOdFErlkCH0cE6001DLBGanRc6dXf691DXJIURJIvQ5RkMXvCv8UoU9MAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602130141
X-Proofpoint-GUID: pA-Ujta2IlRtYmM50zSfJpZXZNfuIgdd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDE0MSBTYWx0ZWRfXz8PeCPG6tOnF
 /6yMWlbrcVueoOr+VhUd4fkNd9nDSJPDc/DU+kKh/zfuZ4wxyhS0Jon9ap6mK5PxMhrgru1okrL
 zK9wwEbBG2xbyLDJmvwFMU3qZtAcd/LPOgJy14SI1IeopWXIB+cNi66ssmT8ku9Nut6C4at3yOR
 +lYyvBMU6/mSjRnAepmYfFqdEB2d8VkmW5A26AasP1GlPQPGo/q9r+UqCkIjoLyp3e90Mwp6aFx
 CwTEevpzSccDYwN1m17qjh9ZGzMHcqO7cbQJirCtCxquu0Lk7IMPfNtMu87dyduYpkd/BpSyLGd
 xo5tFO3CTT8/COiH3eUIyxwzGMyYOudwIz++nF+MIhwFD4vO9VRYaDexUGe8rTz2FSWJCJ257M/
 Bug/Cu+jGJfYb43bMNuigPBnsGnKRkLrRm94TdhYLDPBJoOw8LKoojxH+8E81YbtnM//K5QaoGl
 s3lWHzUinSivq6wUSbA==
X-Proofpoint-ORIG-GUID: pA-Ujta2IlRtYmM50zSfJpZXZNfuIgdd
X-Authority-Analysis: v=2.4 cv=Y6f1cxeN c=1 sm=1 tr=0 ts=698f6b55 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=6IcKfa4xIT5FJe8K7dsA:9
 a=QEXdDO2ut3YA:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77161-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dai.ngo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A7BB8138E52
X-Rspamd-Action: no action


On 2/13/26 7:43 AM, Chuck Lever wrote:
> On Fri, Feb 13, 2026, at 3:30 AM, Dai Ngo wrote:
>
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 46f229f740c8..42ae59eda068 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -1660,8 +1672,12 @@ int __break_lease(struct inode *inode, unsigned
>> int flags)
>>   restart:
>>   	fl = list_first_entry(&ctx->flc_lease, struct file_lease, c.flc_list);
>>   	break_time = fl->fl_break_time;
>> -	if (break_time != 0)
>> -		break_time -= jiffies;
>> +	if (break_time != 0) {
>> +		if (time_after(jiffies, break_time))
>> +			break_time = jiffies + lease_break_time * HZ;
> break_time is set to an absolute jiffies value.

This should be:
       break_time = lease_break_time * HZ;
Fix in v12.

>
>
>> +		else
>> +			break_time -= jiffies;
> break_time is set to a relative offset.
>
>
>> +	}
>>   	if (break_time == 0)
>>   		break_time++;
>>   	locks_insert_block(&fl->c, &new_fl->c, leases_conflict);
> Now, further down in __break_lease(), break_time is passed to
> wait_event_interruptible_timeout(), whose third argument expects
> a relative timeout in jiffies.
>
> Passing an absolute value produces a wait on the order of
> billions of jiffies rather than lease_break_time seconds.
>
>
>> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
>> index ad7af8cfcf1f..b35ae83da0b1 100644
>> --- a/fs/nfsd/nfs4layouts.c
>> +++ b/fs/nfsd/nfs4layouts.c
>> @@ -782,10 +793,133 @@ nfsd4_layout_lm_open_conflict(struct file *filp, int arg)
>>   	return 0;
>>   }
>>
>> +static void
>> +nfsd4_layout_fence_worker(struct work_struct *work)
>> +{
>> +	struct delayed_work *dwork = to_delayed_work(work);
>> +	struct nfs4_layout_stateid *ls = container_of(dwork,
>> +			struct nfs4_layout_stateid, ls_fence_work);
>> +	struct nfsd_file *nf;
>> +	struct block_device *bdev;
>> +	struct nfs4_client *clp;
>> +	struct nfsd_net *nn;
>> +	LIST_HEAD(dispose);
> Nit: "dispose" is unused.

Ah, I missed this. Fix in v12.

>
>
>> +
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +dispose:
>> +		/* unlock the lease so that tasks waiting on it can proceed */
>> +		nfsd4_close_layout(ls);
>> +
>> +		ls->ls_fenced = true;
>> +		nfs4_put_stid(&ls->ls_stid);
>> +		return;
>> +	}
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	rcu_read_lock();
>> +	nf = nfsd_file_get(ls->ls_file);
>> +	rcu_read_unlock();
>> +	if (!nf)
>> +		goto dispose;
>> +
>> +	clp = ls->ls_stid.sc_client;
>> +	nn = net_generic(clp->net, nfsd_net_id);
>> +	bdev = nf->nf_file->f_path.mnt->mnt_sb->s_bdev;
>> +	if (nfsd4_layout_ops[ls->ls_layout_type]->fence_client(ls, nf)) {
>> +		/* fenced ok */
>> +		nfsd_file_put(nf);
>> +		pr_warn("%s: FENCED client[%pISpc] clid[%d] to device[%s]\n",
>> +			__func__, (struct sockaddr *)&clp->cl_addr,
>> +			clp->cl_clientid.cl_id - nn->clientid_base,
>> +			bdev->bd_disk->disk_name);
>> +		goto dispose;
>> +	}
>> +	/* fence failed */
>> +	nfsd_file_put(nf);
>> +
>> +	if (!clp->cl_fence_retry_warn) {
>> +		pr_warn("%s: FENCE failed client[%pISpc] clid[%d] device[%s]\n",
>> +			__func__, (struct sockaddr *)&clp->cl_addr,
>> +			clp->cl_clientid.cl_id - nn->clientid_base,
>> +			bdev->bd_disk->disk_name);
>> +		clp->cl_fence_retry_warn = true;
>> +	}
>> +	/*
>> +	 * The fence worker retries the fencing operation indefinitely to
>> +	 * prevent data corruption. The admin needs to take the following
>> +	 * actions to restore access to the file for other clients:
>> +	 *
>> +	 *  . shutdown or power off the client being fenced.
>> +	 *  . manually expire the client to release all its state on the server;
>> +	 *    echo 'expire' > /proc/fs/nfsd/clients/clid/ctl'.
>> +	 *
>> +	 *    Where:
>> +	 *
>> +	 *    clid: is the unique client identifier displayed in
>> +	 *          the warning message above.
>> +	 */
>> +	if (!ls->ls_fence_delay)
>> +		ls->ls_fence_delay = HZ;
>> +	else if (ls->ls_fence_delay < MAX_FENCE_DELAY)
>> +		ls->ls_fence_delay <<= 1;
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, ls->ls_fence_delay);
>> +}
>> +
>> +/**
>> + * nfsd4_layout_lm_breaker_timedout - The layout recall has timed out.
>> + * @fl: file to check
>> + *
>> + * If the layout type supports a fence operation, schedule a worker to
>> + * fence the client from accessing the block device.
>> + *
>> + * This function runs under the protection of the spin_lock flc_lock.
>> + * At this time, the file_lease associated with the layout stateid is
>> + * on the flc_list. A reference count is incremented on the layout
>> + * stateid to prevent it from being freed while the fence worker is
>> + * executing. Once the fence worker finishes its operation, it releases
>> + * this reference.
>> + *
>> + * The fence worker continues to run until either the client has been
>> + * fenced or the layout becomes invalid. The layout can become invalid
>> + * as a result of a LAYOUTRETURN or when the CB_LAYOUT recall callback
>> + * has completed.
>> + *
>> + * Return true if the file_lease should be disposed of by the caller;
>> + * otherwise, return false.
>> + */
>> +static bool
>> +nfsd4_layout_lm_breaker_timedout(struct file_lease *fl)
>> +{
>> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
>> +
>> +	if ((!nfsd4_layout_ops[ls->ls_layout_type]->fence_client) ||
>> +			ls->ls_fenced)
>> +		return true;
>> +	if (delayed_work_pending(&ls->ls_fence_work))
>> +		return false;
>> +	/*
>> +	 * Make sure layout has not been returned yet before
>> +	 * taking a reference count on the layout stateid.
>> +	 */
>> +	spin_lock(&ls->ls_lock);
>> +	if (list_empty(&ls->ls_layouts)) {
>> +		spin_unlock(&ls->ls_lock);
>> +		return true;
>> +	}
>> +	refcount_inc(&ls->ls_stid.sc_count);
> Wondering if ^^^^ should be refcount_inc_not_zero()?

I think the ls_layouts list can not be not empty and the
layout stateid is 0 at the same time. But I will make this
change anyway just to be on the safe side.

Thanks,
-Dai

>
> refcount_inc() on a zero refcount triggers a WARN and still
> increments, then mod_delayed_work() re-queues the fence
> worker. Once the destructor completes and frees the layout
> stateid via kmem_cache_free(), the re-queued fence worker
> operates on freed memory.
>
> Using refcount_inc_not_zero() and returning true on failure
> would handle this race.
>
>
>> +	spin_unlock(&ls->ls_lock);
>> +
>> +	mod_delayed_work(system_dfl_wq, &ls->ls_fence_work, 0);
>> +	return false;
>> +}
>> +
>>   static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>>   	.lm_break		= nfsd4_layout_lm_break,
>>   	.lm_change		= nfsd4_layout_lm_change,
>>   	.lm_open_conflict	= nfsd4_layout_lm_open_conflict,
>> +	.lm_breaker_timedout	= nfsd4_layout_lm_breaker_timedout,
>>   };
>>
>>   int
>

