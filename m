Return-Path: <linux-fsdevel+bounces-34243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E649C4123
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF7AB21D0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED8E1A0BC3;
	Mon, 11 Nov 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UETr5i/W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="brynVWOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9B19F10A;
	Mon, 11 Nov 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336024; cv=fail; b=NQPhontwWbHy/7o8xHoDyAibV8Vfci4+Cmwj3piVhkuAnatocyz9Ev8N3Hs/3rgkwEEq2AZIhb+K9QerKKMctGFV535oSsKW8PgYKYvSpWbvirGkY4i77xCgNG5lkiK/JeRUfdTlubgZKFdT2VXCuYfWgERxbBQS7yYPcW+iqgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336024; c=relaxed/simple;
	bh=OSuCFDsiCbzn/u0sGeYn7XJM/NsPdN9piLhT0QaCi1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F3xB6mrFRABbMcOqhrj79DvPy7L/ap73gcMYG+44wui9GRUS0G+Q1LgEe/6iboEDBBf+0Qa8xkxCzXPdIalOutKk6FqrHllw1tIxWM7Y/qsMRfjV1lskSaEen0z26bTlwHP8uJnRgYu2xu4XB7sSZv/ns93mEspWIJO7lr8A3Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UETr5i/W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=brynVWOB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9t00f032534;
	Mon, 11 Nov 2024 14:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OSuCFDsiCbzn/u0sGeYn7XJM/NsPdN9piLhT0QaCi1U=; b=
	UETr5i/WlL4eZX7bhWfY87WhC/b9yf1M7uKD5AYMJI0QlIuSzimaQT7o1Zj/0nG8
	hKJvtUR/WaWcdL5IU7Am0QNl4AtgPkx9G5YLhvoNKOUCQ1vrLuKt9itfC9dvAADn
	LfeHzZFjDKpnHarFxAmgtQNY4UBtRsyB3ol/mnpdTW4NNcvUR5R2Lb4CWwedlqki
	PGJncoF0xJ7vhG9JRrncqFp2oSbcRp1yNvo3PPUsIKKRJmGNPiMcHDbv8pTEM+7X
	xTKHOdC5PcJRXMJ/kH2uZkKPhzdZSPutBLQ2Uw2piDWjenkInXsgBa0/NFmcVO2P
	+eyLpVY1B8hJWTpWTJZvsw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwjhkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 14:39:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABE1efp024274;
	Mon, 11 Nov 2024 14:39:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx66uq07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 14:39:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0ubw75i9QmRfFal/EAXVZAbfrqjKMbOmdQkVUpKaa4M08j5whLzOAh+zMLYlOfbPArICRR03BqVVFn9WT++D8BwLS4os4xfTIR8EsEl9OMfpxVa3le6O1OtXYv9NT8tfzQwJE8d2KBDzarvq723YDLW01MuGpPFyBYOZa2Lslm+vaaRhruispTVYC9uP9W4929REGCfqPpEy20ceJ9P1or2jMCXlMuHIMjYK85UYTolgGEN+H5+4sZY6HAcqeh1lBZdg1Y9hy7kRh7PVyojhpQ3RpuYwWzBjNwgQRuL+Siev8E9RkdqgCWbkdQfFLis4VhPIDnI9aKScCkdIzD0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSuCFDsiCbzn/u0sGeYn7XJM/NsPdN9piLhT0QaCi1U=;
 b=PBflLrvZ0f3x/Sjx3JmIz1ZL9ANtyLDMQHM7u1i3Wvlk5ALfQHOpmSl1DejiLT7R7sFIlzxey39J8Gssq3JLHHEJL+gZ+jeLoc4Zpe8n2CdKISOg/y1Yw+pR/kGcvglRGDlTFIAFg9x0S2P/+gwDezMZFVwHfRrnaQ2p3htg9ZcM03vVAr2DjU7Y63MFXboN5AKjpCT4z14Y0Jg10WqQ3Oqb9fUW28+LA2GFcfEhWXIrGHSSShYpt3KK35BP/tuYZKF1uruB8za6OFnM6qKTaO6IO4Zx0HUEOtdvzddvQBUBze2+J5pox2lbgHStkj4QNgH41nKqM5lFBP3dM/bgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSuCFDsiCbzn/u0sGeYn7XJM/NsPdN9piLhT0QaCi1U=;
 b=brynVWOBjfCuszwmmbWTD8Rz6fyrvq8xtFqCYULJE7o11zWj6ec3d+JS7tdtZK5ToQB8a7I7nlYig3Wc7irCDXpuw+O7W4yKet2gFK3a5n00GjKYrzp1E07IJA3wbWpwdR6qkyiVj6Arao0MiUtZpLr+JBRdLZdr6xLDIgCYkT4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5161.namprd10.prod.outlook.com (2603:10b6:610:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 14:39:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 14:39:07 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
CC: Chuck Lever <cel@kernel.org>, linux-stable <stable@vger.kernel.org>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com"
	<sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com"
	<Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Daniel Vetter
	<daniel@ffwll.ch>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox
 (Oracle)" <willy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, Sasha
 Levin <sashal@kernel.org>,
        "srinivasan.shanmugam@amd.com"
	<srinivasan.shanmugam@amd.com>,
        "chiahsuan.chung@amd.com"
	<chiahsuan.chung@amd.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        "maple-tree@lists.infradead.org"
	<maple-tree@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        yangerkun
	<yangerkun@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for
 offset dir
Thread-Topic: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for
 offset dir
Thread-Index: AQHbM9Qf5MGHjWzrD0e387x3Myz9zbKxXU4AgADJ6QA=
Date: Mon, 11 Nov 2024 14:39:07 +0000
Message-ID: <96A93064-8DCE-4B78-9F2A-CF6E7EEABEB1@oracle.com>
References: <20241111005242.34654-1-cel@kernel.org>
 <20241111005242.34654-7-cel@kernel.org>
 <278433c2-611c-6c8e-7964-5c11977b68b7@huaweicloud.com>
In-Reply-To: <278433c2-611c-6c8e-7964-5c11977b68b7@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5161:EE_
x-ms-office365-filtering-correlation-id: 833046c1-5431-4337-0511-08dd025e98da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjJDQU1hRFFtZVFSUEN5OHpkbDJtOFhpaFZubkxVYlcwK1ZsaXlSNzR0aFNN?=
 =?utf-8?B?ZDhFbWI2Q2lhYnl3MWdoMEpuV1NTVVZQVlhmcWpGVko2K3dXU0o1NTRmUnlG?=
 =?utf-8?B?VmZDTGRmU0R4bG0wWTdSQko3UU1kVE9CMTMzc2NyZ1RPeW10UUROUkJvZDI0?=
 =?utf-8?B?MkhyekxvUENvZjhNWWVHK2ZQZWpMNndCdHRtTkV5QkZIMm80Zmx6aWdwcEVz?=
 =?utf-8?B?UFNWK2MrckU3ZEhodmFlUnJhYlZtNk5YRWd0bmUrUHdKait0TGdmZWVsTGJH?=
 =?utf-8?B?bkU0MkROcmRsWXhXMU9POTF5c3EyTFVqT0VOYVpSUXo4ejZUMWRHWk52Y1R1?=
 =?utf-8?B?Z2R2SzBTWmdGZkNxU2hRcGdGdE1mL2R2UTYyVzV2OVh1bm1lVnUzK0hEeFMv?=
 =?utf-8?B?TnJoM09oRGdyVzlSVUZ3Q0dYTXM0RXE1bHYwOXpWZ2g3SFRGVGRTYmNITTFD?=
 =?utf-8?B?OEtlMjNPTUIwbkdIK21YRVU0bGdoajFKMytoU1Z0UjB1V3F2NTRhS1VFeHAw?=
 =?utf-8?B?S290UHRvQm5ORnBOczdSY0c4bzNCR2kya09IZGVRMWI2VHRyZXZKY0VtQzJz?=
 =?utf-8?B?WHJiYWx3Qk1OVzFSbEwydzJQWVpUWTRhWXFoU0FuOURXVStzMnlkVXh5TlpN?=
 =?utf-8?B?YU9vZEk2RmROVlg4aklMQTVPYWFUenhxbVcvY0ZVblpkVWpiWWs1Vms2c2Nl?=
 =?utf-8?B?ZEptQWlvNndGM0FqVEdFY1lFS1A2YVM4VmQ1TmFGVjNxZmJ4Rk9idGJqWWVz?=
 =?utf-8?B?MmNuUGhObDAyMU8ySWQxb0w0bjBwbUFhSXNaNGdiVEI5Q0NucGpRMHFqa2xm?=
 =?utf-8?B?VmRzbmxZcXduaUhYYXNKZXBYQUJCN2VlQ2grUnJQZUoxa1FYNWpPdjhMbUxr?=
 =?utf-8?B?MWQwRXBLZkJtU3l4N2QyQ0d2VXdwa3pNd2t6TGJqU0dTdXN1OXpkWCs4bzNN?=
 =?utf-8?B?NkpDOGgxaEt3NjBsbFJtRnliUFQwRWhQUlZ2eTFMVDVnYXVnYjBlei9lV3A5?=
 =?utf-8?B?U2gyWDFSdUlvSFo2OUdZMzhoYTZmdkVJcGI3ekYxMVB2VDNidE8vLzJIa1NF?=
 =?utf-8?B?K2txUGJjUDZsSFc0bmQzQkc0elkwanVPUzJSQ2ZOdDBiVkw1emNVOG9JVkpO?=
 =?utf-8?B?YXJhc2dtQThjWmcwUTlHU1E1bGxDbUJna01FY05WaVNHUEI3VG13UW4vekdv?=
 =?utf-8?B?Rlc3QyttRE41clpyUk5xbnp6NjIyMTVJcGdUTGpuMEJmOVgxbGVMTnlHZWpo?=
 =?utf-8?B?dm50UUgrTGFBNjhXd2tnVlhMQnM3TWlEakhLdUhsZXNldkhYL2crWmIyOERI?=
 =?utf-8?B?Nk9DZDErWFVHYjR6ZDBUWWxYMmJUdUdBYmsyeFV1TXBVQ2k0b2paMi95MjFI?=
 =?utf-8?B?K0liak9MakVDN004TldJcGZLUDkxWUJmRWlaNDgwSEhRVzVMM3Z3UWx2MW1S?=
 =?utf-8?B?UTRwbldreU1mMjlIMFNIQUlRZUtiZTYzVmF5SHNENWx3N1dHUThaQnl2YTF5?=
 =?utf-8?B?OHpsMHRZNHZPejJhRENNUmhEazNQbGczS2srT1c4Vm9sbUh2TmxnWFo4RWpM?=
 =?utf-8?B?T1QxYzVQeThCQnBLZzhidWpyM2cxK2xaNGk5cXRUVW10YmxjQ2VFRFBFOUVn?=
 =?utf-8?B?RWJlSFFSVmppRDhlNTgybm93RytJcTdISVVYMU9MLzkwdHpXWUEyaTIwTTdq?=
 =?utf-8?B?OVdHdEtkS2o5SW1ES2k1SmE5Z0RDUU85ZUROQ0xaUXBSdEYyK2JDY2REcHJY?=
 =?utf-8?B?Y0lTN1E4L1duOHZjanVoamJYQ1ZWaVhDaFprQXFMRnFkWVJ2MTNIZTBvM2ls?=
 =?utf-8?B?Tzk1ZHdQR3dHbTF5cXZTZjkzME5MdldBdzFkTzI1b2RXWlBNYnRCM1dBNlAx?=
 =?utf-8?Q?EXS8OhcYN+qMu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnk0MWpBcFZIaC9ZTk12M2NhcHBIbXVhZGpjOFp0YVNtZUk1U2R5a0tteGE3?=
 =?utf-8?B?M0JMalgwblZvM1hYdW9SZXlkRlJoVDd5ZVk4aFlUR2liQWtYSXdCbmdpK2Z6?=
 =?utf-8?B?RWJkQ0tDYUE2Z2NiOEpYLzFkRk5uMjEzMFFDMk1XeG1PZ0l5SE56c3BGNUJv?=
 =?utf-8?B?Rm5MeS95c01BQW1lOXNxa0huczJTdkFlY1lmVkxSTUR1KytKMnh3T3lOMEtE?=
 =?utf-8?B?L0hZSit2NmxsVWx2ZmVrb3dnUUs0VE9yT2Y1SEttTlRjcDZ4dmRkYnR6YVFI?=
 =?utf-8?B?S3AzMmpBQitsVTZwOEpjdDRzY1Z2TDdld056UlV2dlpBa3ZLR1M1T3l0a29Q?=
 =?utf-8?B?Y0lOa1FLTC9vM2lvUC9Ec0VkTW1mcGt6ZVpNQmxHWXhwTTBiV3RZd21zOHl2?=
 =?utf-8?B?WW5udGFEKzZSNFc0TXJ3MDA4RzMzc0YrWlVMQmtreW53SDNjOVR1bUppekxj?=
 =?utf-8?B?SzlEVGVhaDF2VGN1SkRraXJvRklkL05yZzR3KzZNcnBaV0YvTmVWekV6SElJ?=
 =?utf-8?B?RUJ1OVBqb2I4ZmJFV3NjcEhXdDA2QzNuN1NHVHU3THVVNzhuMDNBNmhESi94?=
 =?utf-8?B?MHNRNUZrQUZOSjlKWEZPbXZTcjh5b0NxeFEvQm9kRmRnc0Z1dGxVUUFlRW5W?=
 =?utf-8?B?OCtnTWJxY0ZTRXhTZEJBQzk4a2lhT3hURlZjbmJHRlpSRXJTcno5RGYxbG1T?=
 =?utf-8?B?Q0lWWldoMXEvVnBQVGxZVkVaeHNVZVF2cXUwYU9wTDBiQmlNYUM5WFhma1F1?=
 =?utf-8?B?bjk4ZFZrckdVcWE5VENaWnV1RHlycEp0anNHb2o1N2R1YXRyMGc0dndKQS94?=
 =?utf-8?B?WUxGVnFBSldZT1BxVE5Gc21pcE8zc3dJVVpMMWJscUh1S2RGdEVpdFZEWUxz?=
 =?utf-8?B?YXl1NE9FRVltS0JyMVRtU0QzNE1wMUhldTR4dWJhOU5BWWlQUmU0WDVncThp?=
 =?utf-8?B?aHBQODFQTEhHUTJ6d2hOWWZzQ2dUU1lxaEYxU0c5b1VjOFZMT0Z0dFpnV0Fp?=
 =?utf-8?B?UWRWTmhzUDJENUxkNTdjU0lCaEtlY28zcDd1eDZzU0dWbStzUitkb241M2FN?=
 =?utf-8?B?ZWdVNXEzOXVGUWJGZEVuYVprRWJmQ1VvOHRja0trNGpHYjZ2VStUaExUK2Zw?=
 =?utf-8?B?TnN1WlRZcGk3T01JU1BXM0xhZ2owQnBHbXRzUkhLM0FsRE1pOE04eHh1bDc3?=
 =?utf-8?B?aHg4YTNEdU1rY1NEWUpKU1JjVkNQUUgvTkNHVXlZY1VJQWlGK0RGNTlxeC9Z?=
 =?utf-8?B?anhwcnNtZEVESXRGZmppd08ydDd1bjBJVUgrbjBCN0FWODcwdzZpaVc0emtS?=
 =?utf-8?B?ZFJlekI4L2UrZlRWYlVJZHVkZWVKQ2YyS0QxNDE3Rk5iTVhUVERpUG9xcmxH?=
 =?utf-8?B?WmwvdFc5U2RkdTJsN2k3cFFzRHJ6empOYVhreVI4TzR1akUzRHdiWUNCTEQr?=
 =?utf-8?B?THhsS283M21VZXRGdkdrL2s0MUVoR0l0Q1F4UlExTXYvMVJqNkpBSDJMNEJu?=
 =?utf-8?B?QkRRZDFoeUJnZFJiU2paalNTNUtZNFMxV05iYXh3NGh0MURKZ3BlUXZ5dlpq?=
 =?utf-8?B?V3AxeC96RGQxS0ZpZ2RtV0tsVDNwY2lZckdtRDFkSHU4ckxlNEJqWnBGblNB?=
 =?utf-8?B?dHgwNGwya0JvMWFsZmtlK1JiQTI2Ri9XWmxBRUl2YlZsWVRNdUtybE1RclVP?=
 =?utf-8?B?ZFhtaUVmRnNYelR0ZkJiMHF1VVhyWWs3QXNLMHpFU3kyNmN1Sno4VnB1OERD?=
 =?utf-8?B?SWMvMXozMVE5Z3hTQ3JqS2l0M1FWa09wcFN5ckRHemtXdGJQRTNUVjNqMmlJ?=
 =?utf-8?B?cUs3eHVuMHIrR21YNUlINVoycDJTZUhCYTU0aVA3WVN6amJIMW8vT2ozVGxY?=
 =?utf-8?B?cFdVMDdLNzV1M3RQak0zNUlaTklTTm16cGlmdFVwekoxNkx6UCtzakI5RW5J?=
 =?utf-8?B?STZvNTJEMktITUx1QXhQb0U5cjJhaFdMZlZMeitTaGJuNlhOVFBlNmZ6ZktJ?=
 =?utf-8?B?M1hGc1NKOXRBQzNIcDY4Zk96QzlnR1VJMUxRcTg3NnRUbndXYzdId3dTblJV?=
 =?utf-8?B?T0J3eW1mR1VCdFVqMU1BVGpXUm9mcXRCNDNIekd2K042c3FNVWc3UGF2SkIw?=
 =?utf-8?B?YUxwSk10YzZiVTRqaHRJZkgwOU1HTWU5bmkwWm9HMWZ1QXlDSVJxRk04Y0ZI?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3C7E2DC71CF1245885F6200D94FA6B1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	92p/nzCXnS3m7pdZnZCa1GNoI6JmybDleRV8A7qv1dS9NIwZK/gL3EsnWa3FNBvyX33UZMHtDZEvQOrJvoXuL4FBNSJI2+Eitsf9GP9sLX1KozeyTZI+8qMSjZFQX6TqZ3PwReTzQs7DTSGBvr9QK3OIX8vA1rd2jKEshh+7nAkve4/U92kXbyYSZs54zYBsRyFa/xBlvRnBSCtWfxf0S43VZq5SFxOlwyh7fqhZQfeIAgME0tX2hOCa80rSQYCG4N5aE32xdYxcGltqjVCAX8K0Yuvmdv4odp2ksaFxO+aoPwqX73PgOywr+laOQSG/jiNu8oj93ozd0ez2c4rZd29X8Db3C8IGJLcSqhsE+eo/OR9FMtJBSjU7GAAAb4KDVsShi/BuQWVH/cL0Hi7SiBIdZ0a7JyuXc8Fav0dMlFRTDJIXWgb8H7fX1LsnRr521V1wWMuAgaZILikZ4hNzS3l/1Yf2eZLrO/5lkyMz2QSVMiu0UsnlRSawXdzPw5PGcZOl2ve3hXXrOqn7FTxtKcBhLibi0m9etLTqzSFO8C8vjoDJ1XewaCRpnK5xU7t8u8xCcUWJpl8L3YLIXgPlDeOrEK2b3QMoOQ08iWCgBr8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833046c1-5431-4337-0511-08dd025e98da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 14:39:07.0582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkYm/jnKwArj7ylJZ1MU65xZ/84L2XRx26cPpuCF0KpNb4FAjXXH8xDHv5dIrmj5/I4vqEJdKTRo0rIFuCXWTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411110121
X-Proofpoint-GUID: uWpy5zaipnskZPOitCMtKjxoqaE_xKVl
X-Proofpoint-ORIG-GUID: uWpy5zaipnskZPOitCMtKjxoqaE_xKVl

DQoNCj4gT24gTm92IDEwLCAyMDI0LCBhdCA5OjM24oCvUE0sIFl1IEt1YWkgPHl1a3VhaTFAaHVh
d2VpY2xvdWQuY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4g5ZyoIDIwMjQvMTEvMTEgODo1
MiwgY2VsQGtlcm5lbC5vcmcg5YaZ6YGTOg0KPj4gRnJvbTogeWFuZ2Vya3VuIDx5YW5nZXJrdW5A
aHVhd2VpLmNvbT4NCj4+IFsgVXBzdHJlYW0gY29tbWl0IDY0YTdjZTc2ZmI5MDFiZjlmOWMzNmNm
NWQ2ODEzMjhmYzBmZDRiNWEgXQ0KPj4gQWZ0ZXIgd2Ugc3dpdGNoIHRtcGZzIGRpciBvcGVyYXRp
b25zIGZyb20gc2ltcGxlX2Rpcl9vcGVyYXRpb25zIHRvDQo+PiBzaW1wbGVfb2Zmc2V0X2Rpcl9v
cGVyYXRpb25zLCBldmVyeSByZW5hbWUgaGFwcGVuZWQgd2lsbCBmaWxsIG5ldyBkZW50cnkNCj4+
IHRvIGRlc3QgZGlyJ3MgbWFwbGUgdHJlZSgmU0hNRU1fSShpbm9kZSktPmRpcl9vZmZzZXRzLT5t
dCkgd2l0aCBhIGZyZWUNCj4+IGtleSBzdGFydGluZyB3aXRoIG9jdHgtPm5ld3hfb2Zmc2V0LCBh
bmQgdGhlbiBzZXQgbmV3eF9vZmZzZXQgZXF1YWxzIHRvDQo+PiBmcmVlIGtleSArIDEuIFRoaXMg
d2lsbCBsZWFkIHRvIGluZmluaXRlIHJlYWRkaXIgY29tYmluZSB3aXRoIHJlbmFtZQ0KPj4gaGFw
cGVuZWQgYXQgdGhlIHNhbWUgdGltZSwgd2hpY2ggZmFpbCBnZW5lcmljLzczNiBpbiB4ZnN0ZXN0
cyhkZXRhaWwgc2hvdw0KPj4gYXMgYmVsb3cpLg0KPj4gMS4gY3JlYXRlIDUwMDAgZmlsZXMoMSAy
IDMuLi4pIHVuZGVyIG9uZSBkaXINCj4+IDIuIGNhbGwgcmVhZGRpcihtYW4gMyByZWFkZGlyKSBv
bmNlLCBhbmQgZ2V0IG9uZSBlbnRyeQ0KPj4gMy4gcmVuYW1lKGVudHJ5LCAiVEVNUEZJTEUiKSwg
dGhlbiByZW5hbWUoIlRFTVBGSUxFIiwgZW50cnkpDQo+PiA0LiBsb29wIDJ+MywgdW50aWwgcmVh
ZGRpciByZXR1cm4gbm90aGluZyBvciB3ZSBsb29wIHRvbyBtYW55DQo+PiAgICB0aW1lcyh0bXBm
cyBicmVhayB0ZXN0IHdpdGggdGhlIHNlY29uZCBjb25kaXRpb24pDQo+PiBXZSBjaG9vc2UgdGhl
IHNhbWUgbG9naWMgd2hhdCBjb21taXQgOWIzNzhmNmFkNDhjZiAoImJ0cmZzOiBmaXggaW5maW5p
dGUNCj4+IGRpcmVjdG9yeSByZWFkcyIpIHRvIGZpeCBpdCwgcmVjb3JkIHRoZSBsYXN0X2luZGV4
IHdoZW4gd2Ugb3BlbiBkaXIsIGFuZA0KPj4gZG8gbm90IGVtaXQgdGhlIGVudHJ5IHdoaWNoIGlu
ZGV4ID49IGxhc3RfaW5kZXguIFRoZSBmaWxlLT5wcml2YXRlX2RhdGENCj4gDQo+IFBsZWFzZSBu
b3RpY2UgdGhpcyByZXF1aXJlcyBsYXN0X2luZGV4IHNob3VsZCBuZXZlciBvdmVyZmxvdywgb3Ro
ZXJ3aXNlDQo+IHJlYWRkaXIgd2lsbCBiZSBtZXNzZWQgdXAuDQoNCkl0IHdvdWxkIGhlbHAgeW91
ciBjYXVzZSBpZiB5b3UgY291bGQgYmUgbW9yZSBzcGVjaWZpYw0KdGhhbiAibWVzc2VkIHVwIi4N
Cg0KDQo+PiBub3cgdXNlZCBpbiBvZmZzZXQgZGlyIGNhbiB1c2UgZGlyZWN0bHkgdG8gZG8gdGhp
cywgYW5kIHdlIGFsc28gdXBkYXRlDQo+PiB0aGUgbGFzdF9pbmRleCB3aGVuIHdlIGxsc2VlayB0
aGUgZGlyIGZpbGUuDQo+PiBGaXhlczogYTJlNDU5NTU1YzVmICgic2htZW06IHN0YWJsZSBkaXJl
Y3Rvcnkgb2Zmc2V0cyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiB5YW5nZXJrdW4gPHlhbmdlcmt1bkBo
dWF3ZWkuY29tPg0KPj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDczMTA0
MzgzNS4xODI4Njk3LTEteWFuZ2Vya3VuQGh1YXdlaS5jb20NCj4+IFJldmlld2VkLWJ5OiBDaHVj
ayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IFticmF1bmVyOiBvbmx5IHVwZGF0
ZSBsYXN0X2luZGV4IGFmdGVyIHNlZWsgd2hlbiBvZmZzZXQgaXMgemVybyBsaWtlIEphbiBzdWdn
ZXN0ZWRdDQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJu
ZWwub3JnPg0KPj4gTGluazogaHR0cHM6Ly9udmQubmlzdC5nb3YvdnVsbi9kZXRhaWwvQ1ZFLTIw
MjQtNDY3MDENCj4+IFsgY2VsOiBhZGp1c3RlZCB0byBhcHBseSB0byBvcmlnaW4vbGludXgtNi42
LnkgXQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5j
b20+DQo+PiAtLS0NCj4+ICBmcy9saWJmcy5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkNCj4+IGRpZmYgLS1naXQgYS9mcy9saWJmcy5jIGIvZnMvbGliZnMuYw0KPj4g
aW5kZXggYTg3MDA1Yzg5NTM0Li5iNTlmZjBkZmVhMWYgMTAwNjQ0DQo+PiAtLS0gYS9mcy9saWJm
cy5jDQo+PiArKysgYi9mcy9saWJmcy5jDQo+PiBAQCAtNDQ5LDYgKzQ0OSwxNCBAQCB2b2lkIHNp
bXBsZV9vZmZzZXRfZGVzdHJveShzdHJ1Y3Qgb2Zmc2V0X2N0eCAqb2N0eCkNCj4+ICAgeGFfZGVz
dHJveSgmb2N0eC0+eGEpOw0KPj4gIH0NCj4+ICArc3RhdGljIGludCBvZmZzZXRfZGlyX29wZW4o
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpDQo+PiArew0KPj4gKyBzdHJ1
Y3Qgb2Zmc2V0X2N0eCAqY3R4ID0gaW5vZGUtPmlfb3AtPmdldF9vZmZzZXRfY3R4KGlub2RlKTsN
Cj4+ICsNCj4+ICsgZmlsZS0+cHJpdmF0ZV9kYXRhID0gKHZvaWQgKiljdHgtPm5leHRfb2Zmc2V0
Ow0KPj4gKyByZXR1cm4gMDsNCj4+ICt9DQo+IA0KPiBMb29rcyBsaWtlIHhhcnJheSBpcyBzdGls
bCB1c2VkLg0KDQpUaGF0J3Mgbm90IGdvaW5nIHRvIGNoYW5nZSwgYXMgc2V2ZXJhbCBmb2xrcyBo
YXZlIGFscmVhZHkNCmV4cGxhaW5lZC4NCg0KDQo+IEknbSBpbiB0aGUgY2MgbGlzdCAsc28gSSBh
c3N1bWUgeW91IHNhdyBteSBzZXQsIHRoZW4gSSBkb24ndCBrbm93IHdoeQ0KPiB5b3UncmUgaWdu
b3JpbmcgbXkgY29uY2VybnMuDQoNCj4gMSkgbmV4dF9vZmZzZXQgaXMgMzItYml0IGFuZCBjYW4g
b3ZlcmZsb3cgaW4gYSBsb25nLXRpbWUgcnVubmluZw0KPiBtYWNoaW5lLg0KPiAyKSBPbmNlIG5l
eHRfb2Zmc2V0IG92ZXJmbG93cywgcmVhZGRpciB3aWxsIHNraXAgdGhlIGZpbGVzIHRoYXQgb2Zm
c2V0DQo+IGlzIGJpZ2dlci4NCg0KSW4gdGhhdCBjYXNlLCB0aGF0IGVudHJ5IHdvbid0IGJlIHZp
c2libGUgdmlhIGdldGRlbnRzKDMpDQp1bnRpbCB0aGUgZGlyZWN0b3J5IGlzIHJlLW9wZW5lZCBv
ciB0aGUgcHJvY2VzcyBkb2VzIGFuDQpsc2VlayhmZCwgMCwgU0VFS19TRVQpLg0KDQpUaGF0IGlz
IHRoZSBwcm9wZXIgYW5kIGV4cGVjdGVkIGJlaGF2aW9yLiBJIHN1c3BlY3QgeW91DQp3aWxsIHNl
ZSBleGFjdGx5IHRoYXQgYmVoYXZpb3Igd2l0aCBleHQ0IGFuZCAzMi1iaXQNCmRpcmVjdG9yeSBv
ZmZzZXRzLCBmb3IgZXhhbXBsZS4NCg0KRG9lcyB0aGF0IG5vdCBkaXJlY3RseSBhZGRyZXNzIHlv
dXIgY29uY2Vybj8gT3IgZG8geW91DQptZWFuIHRoYXQgRXJrdW4ncyBwYXRjaCBpbnRyb2R1Y2Vz
IGEgbmV3IGlzc3VlPw0KDQpJZiB0aGVyZSBpcyBhIHByb2JsZW0gaGVyZSwgcGxlYXNlIGNvbnN0
cnVjdCBhIHJlcHJvZHVjZXINCmFnYWluc3QgdGhpcyBwYXRjaCBzZXQgYW5kIHBvc3QgaXQuDQoN
Cg0KPiBUaGFua3MsDQo+IEt1YWkNCj4gDQo+PiArDQo+PiAgLyoqDQo+PiAgICogb2Zmc2V0X2Rp
cl9sbHNlZWsgLSBBZHZhbmNlIHRoZSByZWFkIHBvc2l0aW9uIG9mIGEgZGlyZWN0b3J5IGRlc2Ny
aXB0b3INCj4+ICAgKiBAZmlsZTogYW4gb3BlbiBkaXJlY3Rvcnkgd2hvc2UgcG9zaXRpb24gaXMg
dG8gYmUgdXBkYXRlZA0KPj4gQEAgLTQ2Miw2ICs0NzAsOSBAQCB2b2lkIHNpbXBsZV9vZmZzZXRf
ZGVzdHJveShzdHJ1Y3Qgb2Zmc2V0X2N0eCAqb2N0eCkNCj4+ICAgKi8NCj4+ICBzdGF0aWMgbG9m
Zl90IG9mZnNldF9kaXJfbGxzZWVrKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgb2Zmc2V0LCBp
bnQgd2hlbmNlKQ0KPj4gIHsNCj4+ICsgc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGUtPmZfaW5v
ZGU7DQo+PiArIHN0cnVjdCBvZmZzZXRfY3R4ICpjdHggPSBpbm9kZS0+aV9vcC0+Z2V0X29mZnNl
dF9jdHgoaW5vZGUpOw0KPj4gKw0KPj4gICBzd2l0Y2ggKHdoZW5jZSkgew0KPj4gICBjYXNlIFNF
RUtfQ1VSOg0KPj4gICBvZmZzZXQgKz0gZmlsZS0+Zl9wb3M7DQo+PiBAQCAtNDc1LDggKzQ4Niw5
IEBAIHN0YXRpYyBsb2ZmX3Qgb2Zmc2V0X2Rpcl9sbHNlZWsoc3RydWN0IGZpbGUgKmZpbGUsIGxv
ZmZfdCBvZmZzZXQsIGludCB3aGVuY2UpDQo+PiAgIH0NCj4+ICAgICAvKiBJbiB0aGlzIGNhc2Us
IC0+cHJpdmF0ZV9kYXRhIGlzIHByb3RlY3RlZCBieSBmX3Bvc19sb2NrICovDQo+PiAtIGZpbGUt
PnByaXZhdGVfZGF0YSA9IE5VTEw7DQo+PiAtIHJldHVybiB2ZnNfc2V0cG9zKGZpbGUsIG9mZnNl
dCwgVTMyX01BWCk7DQo+PiArIGlmICghb2Zmc2V0KQ0KPj4gKyBmaWxlLT5wcml2YXRlX2RhdGEg
PSAodm9pZCAqKWN0eC0+bmV4dF9vZmZzZXQ7DQo+PiArIHJldHVybiB2ZnNfc2V0cG9zKGZpbGUs
IG9mZnNldCwgTE9OR19NQVgpOw0KPj4gIH0NCj4+ICAgIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpv
ZmZzZXRfZmluZF9uZXh0KHN0cnVjdCB4YV9zdGF0ZSAqeGFzKQ0KPj4gQEAgLTUwNSw3ICs1MTcs
NyBAQCBzdGF0aWMgYm9vbCBvZmZzZXRfZGlyX2VtaXQoc3RydWN0IGRpcl9jb250ZXh0ICpjdHgs
IHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4+ICAgICBpbm9kZS0+aV9pbm8sIGZzX3Vtb2RlX3Rv
X2R0eXBlKGlub2RlLT5pX21vZGUpKTsNCj4+ICB9DQo+PiAgLXN0YXRpYyB2b2lkICpvZmZzZXRf
aXRlcmF0ZV9kaXIoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgp
DQo+PiArc3RhdGljIHZvaWQgb2Zmc2V0X2l0ZXJhdGVfZGlyKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBkaXJfY29udGV4dCAqY3R4LCBsb25nIGxhc3RfaW5kZXgpDQo+PiAgew0KPj4gICBz
dHJ1Y3Qgb2Zmc2V0X2N0eCAqc29fY3R4ID0gaW5vZGUtPmlfb3AtPmdldF9vZmZzZXRfY3R4KGlu
b2RlKTsNCj4+ICAgWEFfU1RBVEUoeGFzLCAmc29fY3R4LT54YSwgY3R4LT5wb3MpOw0KPj4gQEAg
LTUxNCwxNyArNTI2LDIxIEBAIHN0YXRpYyB2b2lkICpvZmZzZXRfaXRlcmF0ZV9kaXIoc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpDQo+PiAgIHdoaWxlICh0cnVl
KSB7DQo+PiAgIGRlbnRyeSA9IG9mZnNldF9maW5kX25leHQoJnhhcyk7DQo+PiAgIGlmICghZGVu
dHJ5KQ0KPj4gLSByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCj4+ICsgcmV0dXJuOw0KPj4gKw0K
Pj4gKyBpZiAoZGVudHJ5Mm9mZnNldChkZW50cnkpID49IGxhc3RfaW5kZXgpIHsNCj4+ICsgZHB1
dChkZW50cnkpOw0KPj4gKyByZXR1cm47DQo+PiArIH0NCj4+ICAgICBpZiAoIW9mZnNldF9kaXJf
ZW1pdChjdHgsIGRlbnRyeSkpIHsNCj4+ICAgZHB1dChkZW50cnkpOw0KPj4gLSBicmVhazsNCj4+
ICsgcmV0dXJuOw0KPj4gICB9DQo+PiAgICAgZHB1dChkZW50cnkpOw0KPj4gICBjdHgtPnBvcyA9
IHhhcy54YV9pbmRleCArIDE7DQo+PiAgIH0NCj4+IC0gcmV0dXJuIE5VTEw7DQo+PiAgfQ0KPj4g
ICAgLyoqDQo+PiBAQCAtNTUxLDIyICs1NjcsMTkgQEAgc3RhdGljIHZvaWQgKm9mZnNldF9pdGVy
YXRlX2RpcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCkNCj4+
ICBzdGF0aWMgaW50IG9mZnNldF9yZWFkZGlyKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgZGly
X2NvbnRleHQgKmN0eCkNCj4+ICB7DQo+PiAgIHN0cnVjdCBkZW50cnkgKmRpciA9IGZpbGUtPmZf
cGF0aC5kZW50cnk7DQo+PiArIGxvbmcgbGFzdF9pbmRleCA9IChsb25nKWZpbGUtPnByaXZhdGVf
ZGF0YTsNCj4+ICAgICBsb2NrZGVwX2Fzc2VydF9oZWxkKCZkX2lub2RlKGRpciktPmlfcndzZW0p
Ow0KPj4gICAgIGlmICghZGlyX2VtaXRfZG90cyhmaWxlLCBjdHgpKQ0KPj4gICByZXR1cm4gMDsN
Cj4+ICAtIC8qIEluIHRoaXMgY2FzZSwgLT5wcml2YXRlX2RhdGEgaXMgcHJvdGVjdGVkIGJ5IGZf
cG9zX2xvY2sgKi8NCj4+IC0gaWYgKGN0eC0+cG9zID09IERJUl9PRkZTRVRfTUlOKQ0KPj4gLSBm
aWxlLT5wcml2YXRlX2RhdGEgPSBOVUxMOw0KPj4gLSBlbHNlIGlmIChmaWxlLT5wcml2YXRlX2Rh
dGEgPT0gRVJSX1BUUigtRU5PRU5UKSkNCj4+IC0gcmV0dXJuIDA7DQo+PiAtIGZpbGUtPnByaXZh
dGVfZGF0YSA9IG9mZnNldF9pdGVyYXRlX2RpcihkX2lub2RlKGRpciksIGN0eCk7DQo+PiArIG9m
ZnNldF9pdGVyYXRlX2RpcihkX2lub2RlKGRpciksIGN0eCwgbGFzdF9pbmRleCk7DQo+PiAgIHJl
dHVybiAwOw0KPj4gIH0NCj4+ICAgIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgc2ltcGxl
X29mZnNldF9kaXJfb3BlcmF0aW9ucyA9IHsNCj4+ICsgLm9wZW4gPSBvZmZzZXRfZGlyX29wZW4s
DQo+PiAgIC5sbHNlZWsgPSBvZmZzZXRfZGlyX2xsc2VlaywNCj4+ICAgLml0ZXJhdGVfc2hhcmVk
ID0gb2Zmc2V0X3JlYWRkaXIsDQo+PiAgIC5yZWFkID0gZ2VuZXJpY19yZWFkX2RpciwNCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

