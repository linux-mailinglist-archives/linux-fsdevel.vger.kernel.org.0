Return-Path: <linux-fsdevel+bounces-35725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC29D7858
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD398B22161
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 21:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963B1514CC;
	Sun, 24 Nov 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nuIotFjb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iE229rF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5031CD2C
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732483775; cv=fail; b=s3ZMbc9Zee7g0hpuKCXEJkk53tTaWpqRZGDzdFYUkCbnbLoFrV9o59znNeHibH35l6fXhSo9UpG/M/xnaEeyGgdKsKXK7KOz1Bc5AP1KAPeAI4Qyxn2P++soL92J2oLqW8WB+bw2EjkoF+LIXG+F/RF5/OBl01y/XHcHbmw+n6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732483775; c=relaxed/simple;
	bh=9WqhKRuKpD04kY35Is968MlTI4sS5GZFgbP5W+h7tuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cB4IIRwxaB3YIJSsYL0vbIy6VMd4TUb2uruNOl0rjZXhZJv9FvbGMQ/N+XhPM+V/dPvqAIwa0ZEOCVK56hPta4cTw+LvtwtwHDZVgv0qlPmUoCGk0lJUKEBXl3meeOMllshRAiMiJg+ltpw09yRY+0ANDa9FTNLjik+h9cl/oC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nuIotFjb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iE229rF5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOKZGO1008052;
	Sun, 24 Nov 2024 21:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9WqhKRuKpD04kY35Is968MlTI4sS5GZFgbP5W+h7tuM=; b=
	nuIotFjbFAafPF5iRGelwivzRWrbrzq4Thl0fDgKt/m8XtNGrMmaAfYge+JizQ09
	VKxFgPlPc/Etdc4sQo6xApe3DhCJ+7U+qgdf9u9cYSNKNJuXD8Xxdusmlu48m4Bm
	4uMORMwNiTL3XEaHxY5DQBTG3Ox+CiZKLhc+V99+FY7oUJSyssaDloknLq36wlWA
	tmomUbAwXULNNdr72DBw+BQZIoBxSkLrJsQCbCDY7GWlZ1N5ZOH/lWJps4NJM71d
	muKdocmZXuON2j6az4rVM1DkHBvCZJWFkH6vGcrOwV1B66RUWKqDHCKpQ2SIQFbL
	1bKjYAWkvmCdyoKAeGxJyw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433874a12w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Nov 2024 21:28:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOKvMVW023412;
	Sun, 24 Nov 2024 21:28:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g6s1d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Nov 2024 21:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvSZ7Rm7BSUj5CGDsEcr76wg5InRxTnzEEJEb/C1f5s201ImhK4izeEwJsTfUGlTjwZBWB4x79RsvKJVRqqBVz1yCLMCCHfbMEPz2DZ//bebSS2Zu5nb3v9G28vV9nyfWIiC4x3GhfIHTf2ctXyhC5EgWo4MEUAg0jNmWPOTQsVfLAMNbVZe9bwgDmLK0mj1KwrrKSor8/hadmcIghvI2vql857yDuYz7NhjPnfPe157BYVlCR1Hbi9dbNKZtx1RLKBHp+9wBGd6aVvvnIf49kNjgwrSDGMP4dtjEuAlMmIQEoJs1px5co1BSwSf3PSH6wfeu7qURMIUMg8JBRy+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WqhKRuKpD04kY35Is968MlTI4sS5GZFgbP5W+h7tuM=;
 b=jUvFtVUxxB/Btu9JMKLgc26lki0+Oux29S0+rOW+TaIGlg396GXYbs3NeMpacnj1WSNtnCOeG90kgR0o0mwQ74t9zLI0SeTL6IpEZ5/l7BCvTNth0sRDDgexGMO1xH0UUEKQzzTvnR9m+ytF/2iheL+PKjlbnysXQoZrRkZQaFG59bcmTWjszZ6DC91DiMvo/q1K9EMBsno3TrW3lKdX4OLhigbILZEsYiAmkw8/H3bAUBD/c37yY82w3+cNTI7Ps8RUm9C1we1C/U1DjDHNCLRn8RZFsin7tbQXJJENyY/8We5Y9NdCFDElzaygQeG+HHq7GCRFgkSoZPmTedkBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WqhKRuKpD04kY35Is968MlTI4sS5GZFgbP5W+h7tuM=;
 b=iE229rF5uaRqF/lg+kJJ6PSpzapa7lcjKVGvAGrpM+iJ6gkG+fgSeu1SUMNXkriyQGN5DQFKZ1BNs+60dwJdQBK7djxE4QEGjkfASAKP18otP4gMdQx6m9QgiDfx/LW7GTBTYsfI48dhZjC7brELrsKrnE4j7GuiLsmjGLLuMes=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB8101.namprd10.prod.outlook.com (2603:10b6:8:203::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Sun, 24 Nov
 2024 21:28:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8182.019; Sun, 24 Nov 2024
 21:28:54 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>,
        linux-mm
	<linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Hugh
 Dickens <hughd@google.com>, "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Thread-Topic: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Thread-Index:
 AQHbOTg5NlJ24GOTaUaIEolbfGmWZbK9drgAgAAP/ICAAlv8AIAAEmaAgAF4ugCAAGosAIABcdCAgAOzb4A=
Date: Sun, 24 Nov 2024 21:28:54 +0000
Message-ID: <3AA64C53-500F-4840-BDA5-B573310FBE51@oracle.com>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
 <20241120-abzocken-senfglas-8047a54f1aba@brauner>
 <Zz36xlmSLal7cxx4@tissot.1015granger.net>
 <20241121-lesebrille-giert-ea85d2eb7637@brauner>
 <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>
 <20241122-bauer-willst-2d418ff7ab32@brauner>
In-Reply-To: <20241122-bauer-willst-2d418ff7ab32@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB8101:EE_
x-ms-office365-filtering-correlation-id: 6208b0bd-79cb-4e90-0da3-08dd0cceffaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDYrZEJNSlJMQ2JwYW9naEFBNG1FYnk1OU1xUk9VN1BhUW15R3p5VEtpQ0Vw?=
 =?utf-8?B?ZmE4TVErMVVnWjV5MkdXcjVzUnRxUGJJdFljVnpZWUNqU2Y2VGhhVDMyYzYr?=
 =?utf-8?B?c1JPYUxDODMrYlFsZC82WTZTSW4xdkdVaHdOenlDaVh0RDJjOStIelJ6ZnVo?=
 =?utf-8?B?clBXWkVmMnpYcTB6L1N3empTTzlVaXloWFpFUXk2Wk1DNmFoS00zZFh1SE1j?=
 =?utf-8?B?NlR2TTNiOHc4c2l0QjJhakt4Um8rT1pPZ0NjMndYZ2Z0dGE2S21uNC9CMVdQ?=
 =?utf-8?B?WEhBZ1B0RjN6WnNiT2pJVVhLNkFGeU4vWXhxYTVOWVE1TlpWa1N5TWxGUVJi?=
 =?utf-8?B?UzY5OVFoeStuK0xLVUNUMEkyNjFzZUMrd0M2dURFTGFJMWRkSlErcDFiOVVZ?=
 =?utf-8?B?MXlWclEvQ1c4Mkw4NHhxSUlUNm5XQzRUQmVlWHF2eStaTmVpNnJzS2hmREdl?=
 =?utf-8?B?ZkxqVDUxVjI3alVIaGxoS1FOY2s4bGNRZkVtajVvRDJaR0pPa0Y3U0t4a1BP?=
 =?utf-8?B?c0pLYXB5aWs0VUVxKzBzMnhNZFVBcm1IajRCSEdBU3hoTGJQU2gxOVZEWHRa?=
 =?utf-8?B?ZGJtbEQ2UnkvVzk1WGs1Yjc1K0NqdThEd2pURWtuRHBxYTlvVTRVNjNhSEtS?=
 =?utf-8?B?d1pFdmhPUCtzR1lMSFhRdWprSUVkQWZtVGhiUjBpcmpJVWpxODJuRVhMUXkz?=
 =?utf-8?B?Vk1tTUUyS05NU1JUdjJwNTlpWTVETXo4b214WXFYZ1I3dlZUWThGbzN5LzY1?=
 =?utf-8?B?TG9WOFBsdkUrQWQ0TG90Zk54bnl0Uyt0cG1LWVpKbUlkVXFleGRvdFA2RDRN?=
 =?utf-8?B?L3pxZHdVVFUrRnZyQjFPTDF0RHplMlRuVEltY3pzalo0ZGxFZXRHZDV5R2E3?=
 =?utf-8?B?MGR1N005Ty9iU3QvR0I1QW92TjRqbWczWmVHTkhsUFpHR0xnRDJ5VGUzQjMw?=
 =?utf-8?B?YXpRSXBLKzVzM0p0MXlKSHZpcmw4ZVc3dVN4OHhOMHUrOVdqQWFpOEtPdW4x?=
 =?utf-8?B?UGtzNmFidHJtQmIrQ3h3UTRsVXRWZGZaNmR4OUVxM0VpbUJKTGF5M2h4djRH?=
 =?utf-8?B?YjBYcXpnSlJndHpienFqUVM0RDBXSEdubEhUSURTOTRYR3ZCSllwdldZbU42?=
 =?utf-8?B?SVRXL0JHY29VekVBSUorRGVzVFJqSlp2U1ZPcGg2SVU2YlpCcTA2dWpEbDV0?=
 =?utf-8?B?RG55anZyazRIYzlFOGRvQmgyVjlwYzB3UlR0T3RLalVQS0xRelV6dEhHY1Ev?=
 =?utf-8?B?VEtVL2dNc1FiOUhWUXhXV1VhcmwwUXVZd2RuRDdQMjk0REpOSFBtL2NYWkZN?=
 =?utf-8?B?MXNUbjVybzFNUURJM2RMWktRdE16Mzg0L1I2MEtaQ3dVclEzQXNIcEdGTG5m?=
 =?utf-8?B?c1Y5NWNiU2ZRMEx3YitTZ3lwbUo2V05raU55T2xLN204WHlhM05uTlhCN2d0?=
 =?utf-8?B?R2JsaHQyZlhFOEdCRHoxYWU2c0IwQWV0djZHTzRuM2pKSmQxNkdZTW1mS0ZX?=
 =?utf-8?B?TDM4YlVNQkVlTFRCdDhPeFB3TmIrZEZBZ2xrSnhFV20va1NLbHNkQnJxL1Z3?=
 =?utf-8?B?UE5tLzMyTUV4YjYxenBIY2U0UlhId2FHOFhCblZsUHNDL3ZJd2o0cys2aURk?=
 =?utf-8?B?T3d0ZXRTZFd0REl4MFp1MzFvWm1ISWE0ekNSaWxQZ2tod2krbzJYZjVrbkhr?=
 =?utf-8?B?ZUxtZ25KemgzMmpCZXE4dTdNMW1tcHIveDhydG0yeVl6NExXdmxna1JSK1Jj?=
 =?utf-8?B?UGRpeGlRSG5zUWdyb3g2dVBENXZ2UXhldlkyUXJHMnhUY1EvR0UxdThXc251?=
 =?utf-8?B?aWZ4a01wOWZ0TTRNaDZSeXNHWXNLdEROamdTSVRvSXd2V2IxZ3BEQm5wTCsw?=
 =?utf-8?B?ZWRDM2dNUTAwZ2NYTVBaeHBpNHhhR3pEeTJCVFl6WU1Xa3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVZvaXRHMUVRdE9JRnJDWWJwVG9MMFJRR3J2R2gvL1RSRnl1MGg1dFBNM1dN?=
 =?utf-8?B?UTFlb1hqdFlzNlF2cEI4bzBURUNPYTZrejRNSXo0NjkxQ3hQSGN4V1Zxa3Nl?=
 =?utf-8?B?WE82Wi8yZU05RElndDhuT24xdUNweU5Qdk81Z1lxdVlxdm1YTHBYMTNTQUtE?=
 =?utf-8?B?bUVDcWRqdkxNOUZIZ2twTDRMOC9GVUhNanJaSWNIeHh4YVRyU1NSQ3R0UE1O?=
 =?utf-8?B?K25HSU5ZVkI0Q3dwSU96aXlEZmowVXdJSEhGVlJTTVRxUWpOWTFYelZOMWor?=
 =?utf-8?B?Qk4rVjhUT0FYc0I0NW5senRiaUNCc050RG56SjdGK0tvWXdYVWtVcnVXOXB3?=
 =?utf-8?B?dFY2Y2FwdEFuOUp1eWQ2dFN5MTFQOGlBVmp5dFJ2aW9oY25ISjZXbE5Hdlo4?=
 =?utf-8?B?NlhSbkkxdGpqQ2lpelRJMHlDRlcrUHRDbzQ1elBrRTBGV091LzV2N3NFTmNr?=
 =?utf-8?B?eWVBWmMxUXh1Y0xLcHdnT05paGp5bGJyeUpuNFNwVGEwOWh6eWhiaUh6SG5w?=
 =?utf-8?B?SGZWS2ZWTWwrSXFKTkFZY3lkNlU2MEh3dk0zNTQ3aitaWFhJa1dROUtHYWM2?=
 =?utf-8?B?WlJYK0krWER4M29ocjZKWlFJdklMRFBIbVhhemNYUStGTzhjV2tyaHVQRDU4?=
 =?utf-8?B?Y2c5Rk14b0VETWRSaG9mZENyb2lsOTVIRTRNRksxZ2lQVk8zS29JZk1PZVBr?=
 =?utf-8?B?UTFhblNXb01XQThaVnZWTTlIbExDMHRBN3B0aWpLbGR0STVUT25WS2VzT3N3?=
 =?utf-8?B?SXg0UTBVVDdEcVB0Qzc4WnpHQ2U4Tjkwbk1rR1QrakpOQmR6N2puZ2lDMEE3?=
 =?utf-8?B?WjEvYnh5SWEydmdxdG1PT2pzekVrbUw3WnNsTER1ZFg3a2V2bTV0UXRLY3Qw?=
 =?utf-8?B?Z3pHbFBQQXpVYWc4R1hPT0JpWlZPaHB6dmhweUhIbi9QL2tTVHN2dlhxOU9N?=
 =?utf-8?B?RWZYbVNWanFaV25jdjI2R0dGa3BrYWNpTXFjUjFEelpCUUZOMEZ2S0RDeldv?=
 =?utf-8?B?ZVl1KzEzay9wWUlPMk9neFZmTGl3bU9LWGtwaitNRmEvNDNYSmlyT21KV3dv?=
 =?utf-8?B?bUF0ZjJSUVJUSTFrZ1VVMGVMVDcra3NnaG8vVXp2RTBMT0JNYnFud2k0a05o?=
 =?utf-8?B?Rm1VM2I0QmwwaXpLV25NRm9zZkJkSDBZU1lBWmNib0JSMVBOQUsyQm81TSs5?=
 =?utf-8?B?S25UbnlFL3lJL24vd1dXSHExV2E5elBLa2prcGtqR3dQbHRhSmlUWFNZVUZ5?=
 =?utf-8?B?T2xkbG1kR2tpczhYNHlkWEZKZVFsSHpOcGhWN1dZMDNoQXhPM0dmdFlwMStU?=
 =?utf-8?B?L1ZmYThHWWdGVFVZaUJWalNaOERWNllXU3JyRzFZSzFkc0V5RnpNVmRMKzFN?=
 =?utf-8?B?eHV6SFdYOW9ENjhkNVJ6QmpPYVRNSDAyRlR4U1hXRTVqbk5RTnA5WkJobG5r?=
 =?utf-8?B?VWJpRkdocG03SnhmSXFlR3NYV0tVR3pqMjJlU1FxcGl2YkdRWHpiT1hlQml1?=
 =?utf-8?B?aURPQnBMYk5iVEQrZm9wUW1IbEVpM2p1eFdOSjE2T2s4REkvUXNTMG10US9I?=
 =?utf-8?B?aUJxUGJmZEdDcEVveGlscXA5RWF2anU2NE4yVnNXZnVlZ2xyQjBTSjZyeGxz?=
 =?utf-8?B?NW5DRmxMVUg0OEttRkhzd2w4RjRES1JVcURNT1JzcEpYdkVSMTlqWUFjS2lv?=
 =?utf-8?B?Q0lvNVVaTjVaQmdkWUs5VDJEVnQwNmxQYTBkc21ZN3JvTG9Sb25yZTJQL0l2?=
 =?utf-8?B?dFJJQnAvU0lBVm1EWEIyNUErc2dxWTFQNFNJbG9iMGxDU2dVcmdYWGtQaHhJ?=
 =?utf-8?B?a2V0dTJoWUJ5VWYvMVJGeUc0YVlvbGQxazc5eXROOTZsUVFQNTAwUTltNEZz?=
 =?utf-8?B?MktUUFhlbzdHWEhQcDdsWWp4VkZrNzZ2UjlzT0IwUnNlbmZNWHJqS0pKa2RL?=
 =?utf-8?B?eTd2NGJEcU1hQjN0bHdUaFduTVdubnJVaUlTZGxSdUM5MjJKWlQ0OWFrTHBX?=
 =?utf-8?B?d2NNVGpFRDFJc3BEc3dFUGxzSTk5YjQ2OHZVWDRCOUVpM1A1cHpEYzZKaXg2?=
 =?utf-8?B?RlZGUG8yOEVVYjRNU3MvcHlEOEFzak1Xd0R1Q2N0QXhSUWZUTlppVlRmeTZV?=
 =?utf-8?B?UTBqWktLMW56Z3lSRHJxaU9BTFhuTmFySTk3Z1Y1UGQ2Y29md0cwWWNNQ2lY?=
 =?utf-8?B?Wnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EC4ACD8046DEC46836E2FE976A4EF98@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2f38ToSWPmWSCDoWkyxERT9MgYYczRHT4o7H7CTwy5gNSHPDGYvozrrcRcm/Noe+2kAUFDLPxNvfLynxtuXl0xvNO0w4w+KFUJwDSWVgPZGisTRYLsnlpKfcg08xknKQ48bb1ee1pnab3BKpoxBuUR2qyiSWhY5gH4FVc7eCZEywpBTSuyfSW16Vi1Zy0Jvve//Oq6fzkJzbF4S3PpdZfcM30FkW0kNeOMRwIQXHP5du2Xk7TjEWs6O7jcxusEvVZmFAnH03lsvoaReuXBA3e9Okc9aFNeBexf/YhbXQVVjhWkEmF8xKGyYTvdJT+C/R5ajlUzhi6fK2PkWHL+2FdUbmqEdbs1OdsddCLBDA4qf3Zzh/aFeAVuR5L4DGOq+mcd+z3RTrdtfk6R9YXNy3TBatBdsupc7Q9MNhn1hKPAXg4v+OXNgYnjcgZwDaIXHbiQw8U9p6GuyInDDYr9eTL67VcNdQ3/N8JLNSwtOXJuVZ1SFUC8v4nToVU3FvvpyuuYBg0rabyF+tAl9g03OqkEK1zHTRyiTlqXzDUXPMWSQK4m4gvRQxnyM/vqfSKwT80VZWSIyUvQdZVf5c7EMckNKQo9dKg0Q+4gHb3fHh3AY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6208b0bd-79cb-4e90-0da3-08dd0cceffaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2024 21:28:54.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kOu3r2V9/0k2RhVfOr0lzt2svOZBFbuanOps49A2KLMiBh58YVtFOnrzOTq4NV4FI/+z3H1/xrooD+1CQ5+Lug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-24_19,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=909 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411240191
X-Proofpoint-GUID: xJ-VoJE_3B5O8czdOHbxqxSjergsjKGL
X-Proofpoint-ORIG-GUID: xJ-VoJE_3B5O8czdOHbxqxSjergsjKGL

DQoNCj4gT24gTm92IDIyLCAyMDI0LCBhdCA3OjU34oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBOb3YgMjEsIDIwMjQgYXQg
MDI6NTQ6MTZQTSArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBP
biBOb3YgMjEsIDIwMjQsIGF0IDM6MzTigK9BTSwgQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJA
a2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4gT24gV2VkLCBOb3YgMjAsIDIwMjQgYXQgMTA6
MDU6NDJBTSAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4+IE9uIFdlZCwgTm92IDIwLCAy
MDI0IGF0IDA5OjU5OjU0QU0gKzAxMDAsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPj4+Pj4g
T24gTW9uLCBOb3YgMTgsIDIwMjQgYXQgMDM6NTg6MDlQTSAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3Jv
dGU6DQo+Pj4+Pj4gDQo+Pj4+Pj4gSSd2ZSBiZWVuIHRyeWluZyB0byBpbWFnaW5lIGEgc29sdXRp
b24gdGhhdCBkb2VzIG5vdCBkZXBlbmQgb24gdGhlDQo+Pj4+Pj4gcmFuZ2Ugb2YgYW4gaW50ZWdl
ciB2YWx1ZSBhbmQgaGFzIHNvbGlkbHkgZGV0ZXJtaW5pc3RpYyBiZWhhdmlvciBpbg0KPj4+Pj4+
IHRoZSBmYWNlIG9mIG11bHRpcGxlIGNoaWxkIGVudHJ5IGNyZWF0aW9ucyBkdXJpbmcgb25lIHRp
bWVyIHRpY2suDQo+Pj4+Pj4gDQo+Pj4+Pj4gV2UgY291bGQgcGFydGlhbGx5IHJlLXVzZSB0aGUg
bGVnYWN5IGN1cnNvci9saXN0IG1lY2hhbmlzbS4NCj4+Pj4+PiANCj4+Pj4+PiAqIFdoZW4gYSBj
aGlsZCBlbnRyeSBpcyBjcmVhdGVkLCBpdCBpcyBhZGRlZCBhdCB0aGUgZW5kIG9mIHRoZQ0KPj4+
Pj4+IHBhcmVudCdzIGRfY2hpbGRyZW4gbGlzdC4NCj4+Pj4+PiAqIFdoZW4gYSBjaGlsZCBlbnRy
eSBpcyB1bmxpbmtlZCwgaXQgaXMgcmVtb3ZlZCBmcm9tIHRoZSBwYXJlbnQncw0KPj4+Pj4+IGRf
Y2hpbGRyZW4gbGlzdC4NCj4+Pj4+PiANCj4+Pj4+PiBUaGlzIGluY2x1ZGVzIGNyZWF0aW9uIGFu
ZCByZW1vdmFsIG9mIGVudHJpZXMgZHVlIHRvIGEgcmVuYW1lLg0KPj4+Pj4+IA0KPj4+Pj4+IA0K
Pj4+Pj4+ICogV2hlbiBhIGRpcmVjdG9yeSBpcyBvcGVuZWQsIG1hcmsgdGhlIGN1cnJlbnQgZW5k
IG9mIHRoZSBkX2NoaWxkcmVuDQo+Pj4+Pj4gbGlzdCB3aXRoIGEgY3Vyc29yIGRlbnRyeS4gTmV3
IGVudHJpZXMgd291bGQgdGhlbiBiZSBhZGRlZCB0byB0aGlzDQo+Pj4+Pj4gZGlyZWN0b3J5IGZv
bGxvd2luZyB0aGlzIGN1cnNvciBkZW50cnkgaW4gdGhlIGRpcmVjdG9yeSdzDQo+Pj4+Pj4gZF9j
aGlsZHJlbiBsaXN0Lg0KPj4+Pj4+ICogV2hlbiBhIGRpcmVjdG9yeSBpcyBjbG9zZWQsIGl0cyBj
dXJzb3IgZGVudHJ5IGlzIHJlbW92ZWQgZnJvbSB0aGUNCj4+Pj4+PiBkX2NoaWxkcmVuIGxpc3Qg
YW5kIGZyZWVkLg0KPj4+Pj4+IA0KPj4+Pj4+IEVhY2ggY3Vyc29yIGRlbnRyeSB3b3VsZCBuZWVk
IHRvIHJlZmVyIHRvIGFuIG9wZW5kaXIgaW5zdGFuY2UNCj4+Pj4+PiAodXNpbmcsIHNheSwgYSBw
b2ludGVyIHRvIHRoZSAic3RydWN0IGZpbGUiIGZvciB0aGF0IG9wZW4pIHNvIHRoYXQNCj4+Pj4+
PiBtdWx0aXBsZSBjdXJzb3JzIGluIHRoZSBzYW1lIGRpcmVjdG9yeSBjYW4gcmVzaWRlIGluIGl0
cyBkX2NoaWxyZW4NCj4+Pj4+PiBsaXN0IGFuZCB3b24ndCBpbnRlcmZlcmUgd2l0aCBlYWNoIG90
aGVyLiBSZS11c2UgdGhlIGN1cnNvciBkZW50cnkncw0KPj4+Pj4+IGRfZnNkYXRhIGZpZWxkIGZv
ciB0aGF0Lg0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+ICogb2Zmc2V0X3JlYWRkaXIgZ2V0cyBp
dHMgc3RhcnRpbmcgZW50cnkgdXNpbmcgdGhlIG10cmVlL3hhcnJheSB0bw0KPj4+Pj4+IG1hcCBj
dHgtPnBvcyB0byBhIGRlbnRyeS4NCj4+Pj4+PiAqIG9mZnNldF9yZWFkZGlyIGNvbnRpbnVlcyBp
dGVyYXRpbmcgYnkgZm9sbG93aW5nIHRoZSAubmV4dCBwb2ludGVyDQo+Pj4+Pj4gaW4gdGhlIGN1
cnJlbnQgZGVudHJ5J3MgZF9jaGlsZCBmaWVsZC4NCj4+Pj4+PiAqIG9mZnNldF9yZWFkZGlyIHJl
dHVybnMgRU9EIHdoZW4gaXQgaGl0cyB0aGUgY3Vyc29yIGRlbnRyeSBtYXRjaGluZw0KPj4+Pj4+
IHRoaXMgb3BlbmRpciBpbnN0YW5jZS4NCj4+Pj4+PiANCj4+Pj4+PiANCj4+Pj4+PiBJIHRoaW5r
IGFsbCBvZiB0aGVzZSBvcGVyYXRpb25zIGNvdWxkIGJlIE8oMSksIGJ1dCBpdCBtaWdodCByZXF1
aXJlDQo+Pj4+Pj4gc29tZSBhZGRpdGlvbmFsIGxvY2tpbmcuDQo+Pj4+PiANCj4+Pj4+IFRoaXMg
d291bGQgYmUgYSBiaWdnZXIgcmVmYWN0b3Igb2YgdGhlIHdob2xlIHN0YWJsZSBvZmZzZXQgbG9n
aWMuIFNvDQo+Pj4+PiBldmVuIGlmIHdlIGVuZCB1cCBkb2luZyB0aGF0IEkgdGhpbmsgd2Ugc2hv
dWxkIHVzZSB0aGUgamlmZmllcyBzb2x1dGlvbg0KPj4+Pj4gZm9yIG5vdy4NCj4+Pj4gDQo+Pj4+
IEhvdyBzaG91bGQgSSBtYXJrIHBhdGNoZXMgc28gdGhleSBjYW4gYmUgcG9zdGVkIGZvciBkaXNj
dXNzaW9uIGFuZA0KPj4+PiBuZXZlciBhcHBsaWVkPyBUaGlzIHNlcmllcyBpcyBtYXJrZWQgUkZD
Lg0KPj4+IA0KPj4+IFRoZXJlJ3Mgbm8gcmVhc29uIHRvIG5vdCBoYXZlIGl0IHRlc3RlZC4NCj4+
IA0KPj4gMS8yIGlzIHJlYXNvbmFibGUgdG8gYXBwbHkuDQo+PiANCj4+IDIvMiBpcyB3b3JrLWlu
LXByb2dyZXNzLiBTbywgZmFpciBlbm91Z2gsIGlmIHlvdSBhcmUgYXBwbHlpbmcNCj4+IGZvciB0
ZXN0aW5nIHB1cnBvc2VzLg0KPj4gDQo+PiANCj4+PiBHZW5lcmFsbHkgSSBkb24ndCBhcHBseSBS
RkNzDQo+Pj4gYnV0IHRoaXMgY29kZSBoYXMgY2F1c2VkIHZhcmlvdXMgaXNzdWVzIG92ZXIgbXVs
dGlwbGUga2VybmVsIHJlbGVhc2VzIHNvDQo+Pj4gSSBsaWtlIHRvIHRlc3QgdGhpcyBlYXJseS4N
Cj4+IA0KPj4gVGhlIGJpZ2dlc3QgcHJvYmxlbSBoYXMgYmVlbiB0aGF0IEkgaGF2ZW4ndCBmb3Vu
ZCBhbg0KPj4gYXV0aG9yaXRhdGl2ZSBhbmQgY29tcHJlaGVuc2l2ZSBleHBsYW5hdGlvbiBvZiBo
b3cNCj4+IHJlYWRkaXIgLyBnZXRkZW50cyBuZWVkcyB0byBiZWhhdmUgYXJvdW5kIHJlbmFtZXMu
DQo+PiANCj4+IFRoZSBwcmV2aW91cyBjdXJzb3ItYmFzZWQgc29sdXRpb24gaGFzIGFsd2F5cyBi
ZWVuIGEgImJlc3QNCj4+IGVmZm9ydCIgaW1wbGVtZW50YXRpb24sIGFuZCBtb3N0IG9mIHRoZSBv
dGhlciBmaWxlIHN5c3RlbXMNCj4+IGhhdmUgaW50ZXJlc3RpbmcgZ2FwcyBhbmQgaGV1cmlzdGlj
cyBpbiB0aGlzIGFyZWEuIEl0J3MNCj4+IGRpZmZpY3VsdCB0byBwaWVjZSBhbGwgb2YgdGhlc2Ug
dG9nZXRoZXIgdG8gZ2V0IHRoZSBpZGVhbGl6ZWQNCj4+IGRlc2lnbiByZXF1aXJlbWVudHMsIGFu
ZCBhbHNvIGEgZ2V0IGEgc2Vuc2Ugb2Ygd2hlcmUNCj4+IGNvbXByb21pc2VzIGNhbiBiZSBtYWRl
Lg0KPj4gDQo+PiBBbnkgYWR2aWNlL2d1aWRhbmNlIGlzIHdlbGNvbWUuDQo+IA0KPiBJIGRpZG4n
dCBtZWFuIHRvIG1ha2UgaXQgc291bmQgbGlrZSB5b3UgZGlkIGFueXRoaW5nIHdyb25nIG9yIEkg
d2FzDQo+IGJsYW1pbmcgeW91LiBJIHdhcyBsaXRlcmFsbHkganVzdCB0cnlpbmcgdG8gc2F5IHdl
IGhhZCB3ZWlyZCBiZWhhdmlvciBpbg0KPiB0aGlzIGFyZWEgZm9yIGxlZ2l0aW1hdGUgcmVhc29u
cy4gUG9zaXggc3RhdGVzIHRoaXM6DQo+IA0KPiAgICBJZiBwb3NpeF9nZXRkZW50cygpIGlzIGNh
bGxlZCBjb25jdXJyZW50bHkgd2l0aCBhbiBvcGVyYXRpb24gdGhhdA0KPiAgICBhZGRzLCBkZWxl
dGVzLCBvciBtb2RpZmllcyBhIGRpcmVjdG9yeSBlbnRyeSwgdGhlIHJlc3VsdHMgZnJvbQ0KPiAg
ICBwb3NpeF9nZXRkZW50cygpIHNoYWxsIHJlZmxlY3QgZWl0aGVyIGFsbCBvZiB0aGUgZWZmZWN0
cyBvZiB0aGUNCj4gICAgY29uY3VycmVudCBvcGVyYXRpb24gb3Igbm9uZSBvZiB0aGVtLiBJZiBh
IHNlcXVlbmNlIG9mIGNhbGxzIHRvDQo+ICAgIHBvc2l4X2dldGRlbnRzKCkgaXMgbWFkZSB0aGF0
IHJlYWRzIGZyb20gb2Zmc2V0IHplcm8gdG8gZW5kLW9mLWZpbGUNCj4gICAgYW5kIGEgZmlsZSBp
cyByZW1vdmVkIGZyb20gb3IgYWRkZWQgdG8gdGhlIGRpcmVjdG9yeSBiZXR3ZWVuIHRoZQ0KPiAg
ICBmaXJzdCBhbmQgbGFzdCBvZiB0aG9zZSBjYWxscywgd2hldGhlciB0aGUgc2VxdWVuY2Ugb2Yg
Y2FsbHMgcmV0dXJucw0KPiAgICBhbiBlbnRyeSBmb3IgdGhhdCBmaWxlIGlzIHVuc3BlY2lmaWVk
Lg0KPiANCj4gV2hpY2ggdG8gbWUgYWxsIHJlYWRzIGxpa2Ugd2UncmUgcHJldHR5IG11Y2ggZnJl
ZSBpbiB3aGF0IHRvIGRvIGFzIGxvbmcNCj4gYXMgd2UgY2xlYXJseSBkb2N1bWVudCBpdC4NCg0K
QWdyZWVkLCBpdCdzIHRoYXQgZG9jdW1lbnRhdGlvbiB0aGF0IEknbSBzb3JlbHkgbWlzc2luZy4N
Cg0KDQo+Pj4+IEkgYW0gYWN0dWFsbHkgaGFsZi13YXkgdGhyb3VnaCBpbXBsZW1lbnRpbmcgdGhl
IGFwcHJvYWNoIGRlc2NyaWJlZA0KPj4+PiBoZXJlLiBJdCBpcyBub3QgYXMgYmlnIGEgcmUtd3Jp
dGUgYXMgeW91IG1pZ2h0IHRoaW5rLCBhbmQgYWRkcmVzc2VzDQo+Pj4+IHNvbWUgZnVuZGFtZW50
YWwgbWlzdW5kZXJzdGFuZGluZ3MgaW4gdGhlIG9mZnNldF9pdGVyYXRlX2RpcigpIGNvZGUuDQo+
Pj4gDQo+Pj4gT2ssIGdyZWF0IHRoZW4gbGV0J3Mgc2VlIGl0Lg0KPj4gDQo+PiBJJ20gZmluaXNo
aW5nIGl0IHVwIG5vdy4gVW5mb3J0dW5hdGVseSBJIGhhdmUgc2V2ZXJhbCBvdGhlcg0KPj4gKE5G
U0QgYW5kIG5vdCkgYnVncyBJJ20gd29ya2luZyB0aHJvdWdoLg0KPiANCj4gTm8gaHVycnkuDQoN
CldoYXQgaXMgbWFraW5nIHRoaXMgZGlmZmljdWx0IG9yIG1heWJlIGV2ZW4gaW1wb3NzaWJsZSBp
cw0KY29tbWl0IGRhNTQ5YmRkMTVjMiAoImRlbnRyeTogc3dpdGNoIHRoZSBsaXN0cyBvZiBjaGls
ZHJlbiB0bw0KaGxpc3QiKS4gV2hlbiBJIGxhc3Qgd29ya2VkIG9uIGxpYmZzLCBkX3N1YmRpcnMg
d2FzIGEgbm9ybWFsDQpsaXN0X2hlYWQuIE5vdywgYXMgYW4gaGxpc3QsIGRfY2hpbGRyZW4gaGFz
IG5vIHRhaWwgcG9pbnRlci4NCg0KSXQncyBubyBsb25nZXIgZWFzeSBvciBmYXN0IHRvIHdhbGsg
dGhlIGxpc3Qgb2YgY2hpbGRyZW4gZnJvbQ0Kb2xkZXN0IHRvIG5ld2VzdCwgc28gSSdsbCBoYXZl
IHRvIGZpbmQgYSBzb2x1dGlvbiB0aGF0DQpjb250aW51ZXMgdG8gdXNlIHRoZSBtdHJlZSBmb3Ig
aXRlcmF0aW5nIHRocm91Z2ggZGlyZWN0b3JpZXMuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

