Return-Path: <linux-fsdevel+bounces-37515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3A69F37D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 18:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508197A1EA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C672063E1;
	Mon, 16 Dec 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="axKegfnR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JW1krJdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE062063C4;
	Mon, 16 Dec 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371405; cv=fail; b=VttJm+A14D09WJ15C8Xoau3BHQwTmR1QKS5co8kZUogUNKqVNO2uI3L9P3omcAr5zb5v2cRHS21GHJvYhwUVzhs84Iydye7QwDi3JKIn7GnNFzHWFSYr4mCu7XPLz1IvUYCAE0iKDxP24VYebOVgoNlKByqpm7v/HBO/bqMnt8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371405; c=relaxed/simple;
	bh=v0zNYjlsZWZXKnbDNx09mvs75Yhb7GxYvNXdEFcu5z4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JLwL0BoaJnZ5/c0GyxWa/Ptt9rzviVTv+FDaWxZE01iZsXNlqJ6Xe2SW6eb5a+s34lwtFdqO+lXQ7hhCV8wLoRNtv67nUb20UGbXJZsJosesbaE20rjP11pRsTy7yDXAd3ZzNjUe18c0dYOpuTGy1VKQUBCkazJMIqVTY3Eu68A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=axKegfnR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JW1krJdM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQhME021715;
	Mon, 16 Dec 2024 17:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TYHpNmAE5Ygw2rAFVRgFQWfvtFvMxmTrn6EnHHoTh48=; b=
	axKegfnRlxEd2VLnFHV+Sr1yqgZY83jvENcpird9cqG+4e/qiwr46p9GkzRr/bmv
	Rnl3lIRa/XFHQRPRifBon1B156KhizKWSk6/a8k0JUfgqhtUogCuD3oXm52w5l9Q
	a7mGCDhc1968dkOWtwBdYFnvoYqkR5JlNA3NvUOdihs8UxiG3tUxpkhDt9kHjk+6
	uoXfHn7nHcHUZjXUojN4S5Zh3Op9qUyMbU0xn4EbB3XqbJyiaJMoagLP3wCYmdl0
	A4j/eBFdN913sG7DhjEC/wZeriXo030cIMJZxhhgjgzRzZqhRywhODqJJjOss5Vc
	yFbonhHDb5sCUdA8lRcLCw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj59rqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 17:49:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQrIg035391;
	Mon, 16 Dec 2024 17:49:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7cgd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 17:49:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgXkXeQj37LeyV/Jh0VggWYlNYV13iehpaREtkx2uoSFH41CDZIzozJLDbLxbafUnSF9gzpMcqXKjNNyEgL/SPGcpRboAgeCvazzE+jbf/tqCRYRzXR+0ksDaiQJ8LilDs4ARt6HkIeHDybkT7M/HtZVqUBQdLvCB1XERFef7axZsXkiBBNFg8kDgMaXeGQZrTVE3rSzjC5QuODtdRCLaJ1jjnePBbyYZdYt+pPjDwqRvglS30gonFZ4EjS6NiKDZPIE6hXH2g/UlrTYSJXDP0iBAmyzim2JHwzU6E/AR+044QTY7DYtxW1Nm3BMv6dcr5UFq3ucpAQYZf3w+DrVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYHpNmAE5Ygw2rAFVRgFQWfvtFvMxmTrn6EnHHoTh48=;
 b=tDOoLTLOLrzIhBW7o5GlTkN7qUWtd1x00nIw/TjvXhtxfDma8LnDTGJ0BQSe0eyqn4cvd1BMGExjiLqMEYMDke+RyUV+xCOqe5uB6zr2VAxk6ZUub0diPdmW2CwNIxPu/vA9qv/cXWfFthl+ejH9BB0hRnqDdvGN47e16YeOAFPQPnjAgMieYe46WJ88YzoOxLH0nzlN4xcnQaAk3JPaaPXLu6eeiQxOUemRmefAjF1LfIcREhlZf0gFCLAF1LnMBO4SiFg0mGRS8kQqjSOHO0oND4rJCSyOo2FRDtuIp96ywCW3vrclWYail9p6rWIcI+aXQHQr/EdAcjyHxlw8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYHpNmAE5Ygw2rAFVRgFQWfvtFvMxmTrn6EnHHoTh48=;
 b=JW1krJdMlG2uKFZZBvda2TIxTotnroQroGtGzA+R5uqI45u1PqLizRLc9UR+AdRCHN+zDxxp7BnGmO6GO9eBBthYcdyAeeTgTC7DmPYOPI0HUBUdSu815+QW1iWuliEiJ4vMWU7sp0aJyJYJ6blUYdyCh8B2QkUstwWMP1zOkAM=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by SA2PR10MB4761.namprd10.prod.outlook.com (2603:10b6:806:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 17:49:52 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:49:52 +0000
Message-ID: <f6a49469-cd5d-4aff-bc41-392db55a5828@oracle.com>
Date: Mon, 16 Dec 2024 09:49:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dax: Remove access to page->index
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang
 <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20241216155408.8102-1-willy@infradead.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20241216155408.8102-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0438.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::23) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|SA2PR10MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: b19ef79c-b6be-4633-b7f8-08dd1dfa0acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajQ5QjJaNVFrL0x3OXhYdTJzSXNwZ2FrNmFyRm9mbXZiTWdhR3p2ay8xaC8z?=
 =?utf-8?B?LzhRZFA4R3hCMHpmQ1VsL3ZZT0JTU0hBYXV3WVFpS2Y5YVZhelFmd0hwTHFi?=
 =?utf-8?B?Z29yeXBUbHR2MGZCeUlNNnlCT1VDWjF5dW5TSHZ1aXBkYTBZYnZ4Z0Y0K1d3?=
 =?utf-8?B?Y0R5QUJBWE0vdk13WHRyb1c5Y0VLN3lSYnlnU010VWVUdzNKN3AwOU5FS3Rv?=
 =?utf-8?B?SHBaZHVUUzJIelFSTnBkN24wQm5JcExPd3o3amRCcXJyQmpoc1ZNZ2JrbFdM?=
 =?utf-8?B?R3pON1phTEFSdElJVW1mU2lXU2hUQk5OWVkxbFpHL2dNNHppUTM0QTVtN3JB?=
 =?utf-8?B?UHF5M2Q0TmdhbjVobVJvSnk3bEd2K05XN0FKQkdoSmgycXFrTWZzWVJSaUg1?=
 =?utf-8?B?aHg4bUQ2NXZVdy9JdTlCR1o5Y2llMGg3czJXeThBSytxZWRIUTJRdXVtak16?=
 =?utf-8?B?VWJTVmN4ZlVuWkU4MUlWYmF5eHFpNlc1dWRvdzkyeHNsQTluWkdwa2dxSnk2?=
 =?utf-8?B?ekx6V01vZ1VLdkgzNUEvc3NJdEVLbFYyL0dIMHZ1V09UbE1LdjVmRW9nKyty?=
 =?utf-8?B?Y3VETW9nUUNXckxLVkE5eFlLN2xTUHlxeTBEUHVlelpqaWNTZFZtUlh1SVh6?=
 =?utf-8?B?cS9DRGJGL0NMRTY3ZUVHOTVBTGFLdVNzRkdQM3Jsc2ErREs4b25UT2g2aUpJ?=
 =?utf-8?B?dUhXQmlUdmxydUdzK2VWd3E1TzlQcXBPSVRVc3RpMVJhMHJoc3BxUWNaUUZz?=
 =?utf-8?B?WDQ4dEdxbkRqd3BrQUZqTFRVMWFsbHh4WGlWRGswUkxQRXE5b211anNIdmNH?=
 =?utf-8?B?bjhxaFllVlpwc1VRTGRTT3hndlErR2VETDdkdG5jYnZ5S2lkSTQzejc0K1kv?=
 =?utf-8?B?WmdobDRxeDVRcS9XRUNwMWI4Skl5WGY2ZzRweDZvc3drTC90UUxkOFp2WWd0?=
 =?utf-8?B?NS9GL3RxTSsrQjY5ZEVqTE51Mzhxb1BaYmlMSHcwR1gxV09iejBncStGcHgw?=
 =?utf-8?B?MFZYcmt3UVcvR3NMM3hHZHpWSjBSL2hKczJIbDJzeVQ5RWFNRnR0aTMrR3Nq?=
 =?utf-8?B?UmJrU1IvSWdrbi9WVUJyZGk1TldRQWZPZWhUVDhkTnNKT3ZkWUJCWUJUc2VT?=
 =?utf-8?B?SVMwenJnU3loa2dXRkE1S1oxemQ1QWlwZTIzaXh2VFpWSlMyc0NDSVYvby9P?=
 =?utf-8?B?TkIySkkvS05WVVVlSmxUaE9IR3J0VmZnTmhWemUvZnpyd0Nxd2p2VzNCQkdR?=
 =?utf-8?B?SjRMRzRHb2NCTkk1Z3BhSlBCNTlzRnJjajdMRkgwbUQ2TTdpdHJqbFdEWVly?=
 =?utf-8?B?bjFsay96VFpOaDRZMTM2Q3U3U2UrYStIWmJCMWpyZW1SdnJYNndoT01zSEtQ?=
 =?utf-8?B?WUJoWDFEWURGaFhLaGczd0hqc0lHNWhoc09Ia1hOQm5zYW0vSURRQTNZUHdq?=
 =?utf-8?B?bWp3MVlUMnJBcDZSVnRMc3A3b216bStmeWxoVVJqbm9xUER0QnRITkpVUmNm?=
 =?utf-8?B?azVFMkFHcG1Id1JsaWFaK3VKdEZsSjlsVEsrWXBpTGdPa0wxdnVHbVgrcWlw?=
 =?utf-8?B?TU1iYnVjU2RCOVBUM3hlS0pkdTZPRWlpOUNxdTQ4VEdXVExyM2UwQWNUM0FL?=
 =?utf-8?B?V2VRRzcrU0U2aW5NT1RNc2poSC9LM25OQ1JLUDAwSUhqMjI4bGdDcVR6a0VI?=
 =?utf-8?B?UXpVY09LczB4aUNUS3o1dmd0cWljVjdLUFhHODlCU3A3aFN0SFFMQTVqSkN0?=
 =?utf-8?B?UXZLVDJNT3JydEVyUGNsYkVXL0VXV2lLZWp2dzBzQTQ2alRZM28xZHhJdUJB?=
 =?utf-8?B?S25zai8wWDc2b3c1WEd6cUFKMktmWlY0K2Z2MWkvQU53YTd4Z1grbm1XanND?=
 =?utf-8?Q?vUZzBx/qasroL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0NNMWxvNDVZSzRDWnNZZjlTUUlrbkdrWk5meU0ySWZRdXV0RXgzVkpQNDRw?=
 =?utf-8?B?S3B6dVhpeXNjUXNwbER4N1ZWZ0xYSEhnNlRqdjl4NEJJTmd3RjJsb09PUnV1?=
 =?utf-8?B?bWM3VDRtWUlPMGZwNUdDWkpjbFZmcHEyYkRqU1NCT0xOYXo0QUpvY0h5c0JU?=
 =?utf-8?B?dHlRa1VzTXJ5TnZKSGtLUHhMalYvNVdnRE5lUENrNW5vWS95TlplZTRJcHFV?=
 =?utf-8?B?YlQ4TTZ0QnNLajVoN1hCdHlUVnFqNFhFUGtIaHR1WkVyWEFTRGU5dXZzUWhX?=
 =?utf-8?B?MXk1V1hJNVN2UUJvSjBsSXV4VVpFdzh0cXJjNk00RkVzaG44OE9mSjRFNUFn?=
 =?utf-8?B?Yk9ZTmpHeTJZWVhUTHZCYm9XbEhmRFpqQzhKZzFvTGE0cE1oSGdvUXlEWDJ0?=
 =?utf-8?B?eVg4SEE3VUdlMmZqSnZ0dlVVRzVNRW9GY25OZDQ1bUt3ZmEvc0pQSUNHdFpu?=
 =?utf-8?B?UE5hTkpLeXcxNUtwOUNEcGZhTkZTN1ZyQUFRMWtFbjQ5RjFXNEtWMmFSemtr?=
 =?utf-8?B?azI1bzBlNFBUd1VWeXdRN25GWHh4dGROOGRCZnBta2VuTXNUKy9ueW1IUTU2?=
 =?utf-8?B?dEhFMjFLWWRVU3pGMVlzOTNOTy9DNmcrb0lDR2lNbHU0bStLbFVkaGpIcFp4?=
 =?utf-8?B?Tk14M25qNVhBQkNhUkhUU1QvRzlHSjRJYWNEV2hERGpybUNFZE8vclVnMUhq?=
 =?utf-8?B?SDhVaHpWb2hla0h5Mk1aUHV5WmErNlpMYWZMOHBaMWUzSmRQcituNGxaemVW?=
 =?utf-8?B?SEhjL2MyMjRZTzhHZjVlWFR1eW10UWtzQzF6Y3R0UGZEVWp5MXpxVXViN1R2?=
 =?utf-8?B?UGxJVXZLWWEyTUdna3RqL2JxdXFSNGhReU83bzlvbHlUQTdxd0pKUlNpVkd6?=
 =?utf-8?B?OENzMWNNNVRwWGdNcDh3LzVrVyttbHlnbThobDY4eEp2dlVBenJlVmR5dWxj?=
 =?utf-8?B?c0paM3l3dkFXTVloano5Q0NsWC9EMEdQOGVQV1ZyR0E5VnM0MUorUFphMm9p?=
 =?utf-8?B?a2llcy8xS091N2J1amdMdVRiWU84ZGVoZ1ZFek4wRGFsamp6MnkzSERUcDgw?=
 =?utf-8?B?ckNXQUtZTzgxNzIwTkdWcDZma0M3NVVLZ1dRL2lSSTg5MHllYUVDRlBVVG1M?=
 =?utf-8?B?TVRudWxwWUhlMFgrV3J0YWN4T3JhbW1EbE0ya0haWUJvZmRmU2o2eXZEOXhh?=
 =?utf-8?B?eFdyNXBJUDlYaEhxTnpERGxTYjlpZjV0VlRPb0tJOThXWGYyM3RuMHhXWWMz?=
 =?utf-8?B?ZEErTGwvMEx6TXpFMDlaUC9Jd3VZODRBNUlzZGg1QzBqSGthS1FHLzJBRGNH?=
 =?utf-8?B?emk4dUpxM1VnNHVja1VNTnJFc0p1RTRRYjhnNVkyVzVjdThUOUVvb1lWWkdK?=
 =?utf-8?B?N0IvRHlaZy9uUS82VGhidmdSbE5lMnQzUXVBYTV3ZEVLa240UWhDbXFZVGZC?=
 =?utf-8?B?YzRGdTRUaE8vWVlFa3IxRGVXU2FqRkNoNCtvRnhvVmFHbDhPZ1RBVGpRczdN?=
 =?utf-8?B?NVJSL2dhbnhJdTBBdnJxcUQ2eERFeHdLMjB0NHJ2cjJDK0htbSt2UVBRaTdW?=
 =?utf-8?B?T1NvUnIrWTArSC9wNURDZ3VyaWNjZ3gwclNUMFJvWDF1d0JHS1hsMlErTmRM?=
 =?utf-8?B?ZTh0R1JFL2lOdGRISG5XUG5mUmtIMDB6MjdPMGtVdCtWZUcraGUzVU80VFhL?=
 =?utf-8?B?VTBuVzRoK3ZZVkVOcHd5bFlPd3BNR21uMk14QkpsY0RLYXNwN2cwZUh3QTdh?=
 =?utf-8?B?UWV2OGhnb2pXM3BVVlNvcHA4NVVLTmgxNitYYW1DQ1Jjdmdqc2ZHYmczSXdB?=
 =?utf-8?B?NDdDd1V0aVdmL1hmWWxRSS9TWit1ZmZUVzZ0OTJFZVd1M3NxNG9JbVREQm14?=
 =?utf-8?B?T2pRUDBkWU9hUnhxUlNSZlFyRGN5R3JWV3J5dTE2a1VJVktOOW55azdIQUc2?=
 =?utf-8?B?MCsyTEVoMGhUZEFxeHJTVnVYQ1FBM2hLRDg4OE9XWk1RMEhiSWg5Ri9ib1Vk?=
 =?utf-8?B?cG1sZFRkdCtId0JjazlGNGczc2VDcUgzcVJQenFmZWxFMmZXQUE3RnZqOGp6?=
 =?utf-8?B?bWJtd3hFd3J6MWFnUHlKdHoyU3F5SUVPdndZc0VOVDUzVkNVOWR2VGNmZngw?=
 =?utf-8?Q?BivXTbUu2te4Q8jAqlY0ON/K/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1w8dXWPpnMdbhHkrIi93WH8Z79GMp+DMRv6eIohUnE4IB7joqbOH2QZaqDh+lfA4MrLG1MJv2mAFJ3jUip/S8GCbqCczWg4gX9GLAIirWjvIj19L2iHYKO1kCm+yyBqrtynrNdp26H/A9M2XLu8b7E/a1G8hLfO6KztzruT+awdUfNSlZ1e7IqugZd2pFtERlVM0+DHaKKjjd2WYLnyBuL4F2k6ieAr63DpvB4lVqIr4jHKKGDYcZJKljOLd/3ZsJXitk/bArnj/LE+N4DIw5nDfQgvR1bhAeluTXi+D9MdEyvngvkDpMW4qOFIee8OtEfUvdOg2pZ1ZQ4UUYlciUbifiSwEw1tEiwoKbMeadU9q+H5vLmwueg7yg+RKqHqhNaGkGGranMKBx0TeEe/+DywRWu+TJOI18Z2rcLCfKFISJ0nYNbntrvXQXkoiX/fkZTCG/N1U7Jjht2l/BN9P1KJGQebqdTmu/UB1xzjckQD4GFKEJ0LExlj6eJNtZMvmgtZO1MUmd4T9XGY3BffDzyGv1bcGLeOEiwPDfWf6Y1zhHe6XnjEoSCOJlR/XVT2ZdUiEMJR6C7RBDEn103gnjSopSRpsBStdOQYiJUKNFxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19ef79c-b6be-4633-b7f8-08dd1dfa0acf
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:49:51.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G2jtOJz0/IQXdV3mMGMKuDbIS11+H2HPu+E7hkb2Sml5lJB1fjLakCxZRnZqdKBtX6xCSsdMA+mu2D8CC16yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160148
X-Proofpoint-GUID: t0NgMvBzG4RHXpGqDDcZASb6bRPpkca2
X-Proofpoint-ORIG-GUID: t0NgMvBzG4RHXpGqDDcZASb6bRPpkca2

On 12/16/2024 7:53 AM, Matthew Wilcox (Oracle) wrote:

> This looks like a complete mess (why are we setting page->index at page
> fault time?), but I no longer care about DAX, and there's no reason to
> let DAX hold us back from removing page->index.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   drivers/dax/device.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 6d74e62bbee0..bc871a34b9cd 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -89,14 +89,13 @@ static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
>   			ALIGN_DOWN(vmf->address, fault_size));
>   
>   	for (i = 0; i < nr_pages; i++) {
> -		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
> +		struct folio *folio = pfn_folio(pfn_t_to_pfn(pfn) + i);
>   
> -		page = compound_head(page);
> -		if (page->mapping)
> +		if (folio->mapping)
>   			continue;
>   
> -		page->mapping = filp->f_mapping;
> -		page->index = pgoff + i;
> +		folio->mapping = filp->f_mapping;
> +		folio->index = pgoff + i;
>   	}
>   }
>   

Looks good.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

-jane


