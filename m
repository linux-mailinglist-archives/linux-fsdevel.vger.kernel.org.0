Return-Path: <linux-fsdevel+bounces-78294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBVOEavlnWlDSgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:53:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE118AC64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8887030B5606
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38093A9DA7;
	Tue, 24 Feb 2026 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BXkxL/3K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C753A7F6E;
	Tue, 24 Feb 2026 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955604; cv=fail; b=unyQ/AMMQUCS10xfBpBgJ2eYu2aDmnnsXB8vP00+yIJMCZVmiYoyq3nsfRjIGWjdgT5y0NFYcbT4lmJEs7vPK3s/nJB2fXgFxV9GAX/72pjaqs4x7TylLnNMQ5OswdgjtEY24JzgXNENpB733TlvAc3ORuelFZaUcSwf3+hhfZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955604; c=relaxed/simple;
	bh=faluw32Wai9XzmC1+GkRHG7D59EJU3WITMydordLMFU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=I0DntMc3I5rRHxM/CMCWztCGeeKZhBM5oK7286t3AUCgNeM3XjHON+TDVQmv0WrRAhiGe21jNR6sOSKxMLwaOdWot2ycURwB/n6u3swIN8l2kDvpUEdajs7rPflAMvh3kh4vZ0Fr60X5tywKpIg1GKbajdQKRQvBVPXmVZrNANA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BXkxL/3K; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OGDGdM1913564;
	Tue, 24 Feb 2026 17:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=faluw32Wai9XzmC1+GkRHG7D59EJU3WITMydordLMFU=; b=BXkxL/3K
	QZuojsz20NXSkQUnt6mcdDD4Q7m8yt3tPULiJf7u8fgfTerpU6+C8NfoRLYX9IYE
	jlfHeH3uvzdSpsq8bxiXBrR/8PKAFgTOdeCvbFKs0LhJI9n9z7E1e0XUmNe1VZJ1
	bF0Ie2GR6Mxx40ukKb1akE+sZDHwsz2DHUEKYm3ZWKVdzwuqUZxNPBySNFfcYcV1
	wXxA4tWQADJazOk13dHcZ95MoP+eN/VqzOnuzJI15YP2VlvVx50sAxV7j942XsYa
	ufyVC8oGI+gXH+pFW05c+ZmYyAsv8j7r649mxtkWDm0HtoME+NmST+X0IKZooDnL
	SEeLg9hqsWgELQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471vwj5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 17:53:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGi0+tE4nmloWl59WsBdOuZIDB396xwF9pbXtSq/9lC+9bwZrfilGAlMgl1kUEaHsHKy7azbosLVY1fhXhXLYCL3goRf9a8JApraS6JnTm5+J8H//YrHieylFHQV4e0HAxUQzCNoklNcdJE/Vx89TeCSh9AOxRY7hB7DJe3N9//X13pTw8Vb2Fi6o/iCkXqJrdzHQJkxILIwJPccb5zWe69HHgQUIO54a3K90iS5i4HEKDJfiJu5zSxI/DquAYDh/mTl68UeEhif+BXiAkuLc9YHroxy8IGCdOR2RhaZs55r6zTGck7rxK9WBI+Ey8C7DTndmDgSKREfjE8N21KXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faluw32Wai9XzmC1+GkRHG7D59EJU3WITMydordLMFU=;
 b=bPXu7T/z2BUXy6sP0oOC3/PjCYH8DN5WmRxQUmbb6yIUD166VkRtMR+QkvTZOPoQnEIatfuQM9QknKH2j+Xw6x/Dd0iHQNWa81VI08Qc0G9a9KaIMGS+OwkEXTFTYrLc3XCs0ZekBN15ENNMSviOFzpAWc+XdoTu9h3nYM8th1x87kC431D12+XzExKh6x9jrgCN/nIwQAvCi/v7u038L4ZxJla+3y+PALzSPn+rwU7w/gK7wHUYWTmVDnSQ8z9/Y9EqzwjDwquKLl8m4hB1dlrWTUohMv0tGwLKpCGz/5+jnfAf70QIPfpoP4BQv4e1mcLnRL7ZQavz17O9Mj6FqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV8PR15MB6415.namprd15.prod.outlook.com (2603:10b6:408:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 17:53:10 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 17:53:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "charmitro@posteo.net" <charmitro@posteo.net>,
        "kartikey406@gmail.com"
	<kartikey406@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v5] hfsplus: fix uninit-value by
 validating catalog record size
Thread-Index: AQHcpUEWViJxMhrGiU+Me3wZFaI5wbWRnSqAgACFM4A=
Date: Tue, 24 Feb 2026 17:53:10 +0000
Message-ID: <f2aeba13de5dc8ad493972ca1f8e35a251d97a93.camel@ibm.com>
References: <20260221061626.15853-1-kartikey406@gmail.com>
		<9f5701d8b45cba21a01baf5d2ce758e3a5a4a8b9.camel@ibm.com>
		<CADhLXY4Of=3ekg86ggi68_VEtYh6qDr-OtfP-D3=4mc9xm0i+Q@mail.gmail.com>
	 <87pl5ua2iv.fsf@posteo.net>
In-Reply-To: <87pl5ua2iv.fsf@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV8PR15MB6415:EE_
x-ms-office365-filtering-correlation-id: 95943c79-4edc-4593-a894-08de73cd931e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?emUrd3ZiUUJFUVdvVkNKZnVYcEFsUi9WVGpETXM5WU5ENTJMUHR3UDUwNGpR?=
 =?utf-8?B?aDM0V2R2MWNDc0t2UWJXNnBoRysvSXZyVG1FY0lUMHgrcnpOZnRoMGc2M2Mr?=
 =?utf-8?B?bTdrbVp0eVBSVnJNckZOYzcyYkRZRDdERkpTUnp2eDZhVUFpdDAxbFprMkdD?=
 =?utf-8?B?N3FHMUYyNHN0ZkNyV3hGMi9SY0twQzJBVHkveUp6QUlDZE5hbDFuWVJTWEZI?=
 =?utf-8?B?Q0dOaXZCODBMajNZVHNVcU92Uy9URG5lb1hYc25BT3NTdmlxOVMxWVB0MkNC?=
 =?utf-8?B?UVZ3bGVwY2NvTllOb1crTGhYRjZ2NTEwNzZ5QjJrZ2NZM0RxYktHS3VQa1Q2?=
 =?utf-8?B?QU15ejcxaytLU1dWWjNUenBzMWVjYWorTzJrQkVLZ0FtVnpPRHc2bE52dUxP?=
 =?utf-8?B?RUp5aElvZTl0ZHJoQU1ZYmlpaTcwR1ZxV2thVFR2amxvd3lnR1BUMUNpN2ZT?=
 =?utf-8?B?ZW1CSUNERU5FbVVXNmpuSUtGL2pJeHlCUFRCRzN2L3Z3ZnJnbWZCVSt6VnhO?=
 =?utf-8?B?M3FCZi84YlZEZzBuNHl5ajk1Y2NYS3dyRDd3ak5PSDFOeXlRNWptMVBTMnRJ?=
 =?utf-8?B?T1l6SC8wM0dFYVhzbDdnRnR2MnBkWUYrNWJoNGxzMjFNQXJrWXRUVXBnUzht?=
 =?utf-8?B?U1VoZHJLSVd3SEZnZmR4MVpqL21OZHFxUCtYVEJ2Z2o2SktvQVJrSm5rSkpT?=
 =?utf-8?B?NC9EU3gvMUZ6ejYyY3pnZjBKa3JzQk93Q1NHSXJwSHZldTNXbzlUaVZBRkR2?=
 =?utf-8?B?bkZZd3lqQ2tXVU9zRGpqNDRBY2IzaFJsVjlOSlh6c1MzUjlzYUFNT1BuQTZM?=
 =?utf-8?B?Z0tnUnlmV0hZOGlyaHQrVTJtbUdzVWtyRDFRdkxCUlZvOUtvWXhLRmdLTll5?=
 =?utf-8?B?VFVIYlRaZ0ZJYVN6SnlrdTNmaWlYcEEvUVNsTzBhVXZzdkhJbmhMVy9sazhI?=
 =?utf-8?B?SytQWXYrTmxodlJRRThZbEpRSW9JMUZlZ2dCWm9UWTJBSThTWXVPRUt6WFRW?=
 =?utf-8?B?aU91czRZcmVwNnBWUEFaSnpnbFpoVmZxTTlzb1Q5YlJ4Nit5aWdnSlh5bE5D?=
 =?utf-8?B?ekdJbHBrY2YxQXhmWElocXJGNkdwMkFQWjFSYTNLdHExaEs2NnZDVUUyVW5r?=
 =?utf-8?B?cllyQnlpdDh6QkFRSzBSU2llWjdybEpIK2hVMVhKbVM4SzhUVm91cnJBWTFt?=
 =?utf-8?B?eGVRTGN6bHVCcWVXMGJFcGlUNm94SmVCcW5hZ3pZUjhrUjRsSWtOcG5RejVk?=
 =?utf-8?B?b09EOFFNYW9VcVBtZ2NuYzNOUkJ1bUxZVzdxL3RRaFk4YjJxSk9KallpTk5q?=
 =?utf-8?B?VHJ5RFk3TmlSMWNyTmNFWmpiSk0zQWVselRPeXRJZWhWWEhTRTB0YUxIMi9B?=
 =?utf-8?B?dmxmTzRVZnZjd3VZb3RBcVEyMGNPaC9jZXNXWEU4bXp3dUVadlBGVDdzU2k3?=
 =?utf-8?B?a2VpazQ5eVNTL1lJL3FYQkFSSmpyV0hpcFY5eWY3aFpsOWdtSFBFOFYrbHA5?=
 =?utf-8?B?U0trZzBTM2dyakFhaDlGTVdFUWlhRXpoaVJ4aGRLWTNGbVdQM0VQTFFVYWRQ?=
 =?utf-8?B?K2I5ODgyYmxwT2pZc3BNVFhSdzhYYm1PRkp3azhuTzlpTlNaSW93OENKL2dQ?=
 =?utf-8?B?S3dWSUwybmU2WHA0Tk5ZdTZFYkRsSFdqYi9wb2RCWmx3MXA4SGoyeUl3RE9W?=
 =?utf-8?B?UW9UQSsvUkFvQVF0bS9xeEJuNURDaDhoYlc3SWIvUHJhRXN6ZzhJWlJPWlJB?=
 =?utf-8?B?ZlRyUkFXeUtpeE9nNVBDR3RkZ0FMelJrWHZ4TFAwVW1jNjNISnhyb05OM0FO?=
 =?utf-8?B?SzVDZjRpSkJBWWVBMlhCdCtWNUpjNlNUdWNVeXQ1MjNyWXhYL2xzTjM2RG80?=
 =?utf-8?B?Z2N0azM2b0dwcExpaUNtZEhzcnJYS2R1K1draEQ0K1RTcEtVS2hXUERQcUtX?=
 =?utf-8?B?VVhJTHJkTE5UTkN0Ulpja0RZTm9qTFllVlUxVksvMmtUdFBvb2hUNnAzUHBH?=
 =?utf-8?B?RENjWGQ1MDBrS0pHcHJBUkdxNHhCcDhBZm5ZZVBSNHViTyszeWIzaHc3cm9h?=
 =?utf-8?B?MVlsQjlUZkQreENVMFYxK3B4VlpLQzNxVE5RclBZNGtQdU1YZnp3ZXIrY3dz?=
 =?utf-8?B?cldtcmxYdTh4OXNnSEQ4Y2FVUkE4WGY0SFd6NktyUXJ1aG9YdGFJdFJrcCtH?=
 =?utf-8?Q?54HZ6gBKC9Rb2/7gWE7qheg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXY3NkFUeTNKSnBFZmNNQXFINjBCOTQ4NVJheStNZlE4dWNpQlQrUkxBeU1R?=
 =?utf-8?B?Zy80aUFrbkVhZGlzUEVXczZDZGhaMzVaeE8wdHhMU0ZzTHZXVmZzdU9IeVdH?=
 =?utf-8?B?Tnk0bDJDT0luZng1eHNOQ1dxWDlmakFPMCtUcDd3Q01ucmsxcG4wWCt4bjNT?=
 =?utf-8?B?djBabkJuNExwM1ZlWWVIczBRZUxzeWZmaXgvL3VUZXpDbEFCQmlkRFhaOHgz?=
 =?utf-8?B?TllhZE5hRENRT1JIejNBaGhDV2Mxc3NLL2FNNjh1cWlrOUhKTTY5T1ovQVAw?=
 =?utf-8?B?cjMzdGQ5WlkyUGZKeC9IWGZWTXBZZXBSRUJLU3FjeW84VWh5NTM4M0VrNDgz?=
 =?utf-8?B?VVlsRWFWNDVDT29GTUdCRjA5SXBIM2cyME5aRWhMcnhWUmhMcjUvNWM3Z0Vk?=
 =?utf-8?B?d3RaZ2VDZXNzaS9UczFmRG9zYm9TejVYSGlDRmxEak40cVdyTytkbThEd3J3?=
 =?utf-8?B?cVdqc1Y5ejNncGwvSHFJMFVjU2dMbWZ5MjBhY21CZjcxUmovazhrWFhZL3V2?=
 =?utf-8?B?anFlNHNVSW9tbmpyUWJMSmNOUjJJcmRhNk9FU0R2K0cwVTljeElEYndaV2xV?=
 =?utf-8?B?RDUrTHdTNG5qbTNKamE1cE5teHl2aExQQStQbnZlY204TGhZLy84dGhPWGN3?=
 =?utf-8?B?TzR1ajd2cDlXZHlOSlhTaFdUMno3d0hmdkJ4UmZmTVVweTl4OXJWVTJJYXBB?=
 =?utf-8?B?bW9SR3MrMFZNNHlOcU8zUlR4bTlsVjcvZHpHdXVnR0lZbHlBOUxaWW1hYjVp?=
 =?utf-8?B?aTR4THFmK1pTRVo5RFNXNlZEbnhIVFZ0b1FscFdYQjZaOTl4Q25KUnp5RitQ?=
 =?utf-8?B?c2dRbkJlSWJjUEtyQlRQUXhtMnlIY0E5Y2NUTC9wTkVaaEtpTC93U3pzVGsz?=
 =?utf-8?B?c25yQm1WdHE3c2dpTThGeS8zZzJzSERmUnczclZyNVJ4NWZBZnFTeFJrUmxN?=
 =?utf-8?B?ZXFFMFJLSXI3TVFzcWVFYkhUSDNyV3V1Y1JuR09MdHJrYjZEbEhjeWdrTDRl?=
 =?utf-8?B?RlBYUDVWOWpBaXdkMEUxQmpRNzVIYzM1WENPaHJPcjVyK3ltZUdNZ3E2ZkNz?=
 =?utf-8?B?dVVEZEs4azBkS0tNVGs1Vk9TaFRFZXF5d1NmWkpwSmU4YVM0c2NGVy8xSm1m?=
 =?utf-8?B?cHRaRjlxU01pbGtYZm8xY0xlY2UzYkdBaGk3T2U5NnY3L3JHcjRLeXdUMkl5?=
 =?utf-8?B?aHVvRS96U3FuN2ZLTytwUm1Hd0pBdmVhMXc3WmRZMXFtNllOVyt4OTZqZll5?=
 =?utf-8?B?V2IrQmhoYWx1RDhpaENyaVZGUjFsb0ZnYnFnOVBTdjZVVUJGMjNrTFBVWjV6?=
 =?utf-8?B?WXd0SVg4bnAwT2tHZmVIbUJ2NWpHUzBXTXBSZnJCTUFYRXlyc0dOdXhYaVNO?=
 =?utf-8?B?NXRQczJuRVJvRDhybFlUWWVWMk1OL1Y2TkhpUkxqMkhiQXJLYWQyeS9XeG5t?=
 =?utf-8?B?S1YwWlRxMlRDMDlaMDJod2c2cGR3dUhZeUxVcjJRUFFYRTJLYXczZlNqa0kr?=
 =?utf-8?B?YTNmRmZJRDlHa1gzUmxaUytMaElpK0x2R01HOUsreWtJb0hNYnJrUUY0OVM2?=
 =?utf-8?B?S1h3UW0xV0FvNFhjV2kzUk5IK1VGLzVtVU12b0tnMXFrR3NLKzg4K1REbCtU?=
 =?utf-8?B?SEtzWDR6Um9yUURadS9sRDlHMEVpSDRWd0JoeEQrS0JIb2Ywc25MUnJLNXZ4?=
 =?utf-8?B?UHpaamxCMjlyemx6VmNhS0VRWlBVLzVaRy8wcjBOTDJFOHVlcm5vVlBVWTZM?=
 =?utf-8?B?em9HczdJMzgyVVBNNDE5aG9JNUNxc0lZck9PRTZRd29tMi9jV1VuQng1ejdw?=
 =?utf-8?B?RzFGdWg0cFpISWdWN2k4T2VMM2FVbEJhcm5EOHFTTThidFkvTnYzZTRSam9P?=
 =?utf-8?B?VlN3Q1BpVy80V1UycmRHbTlBOVkxbXc5ZnVkN08zZUFMV2wzZnVhWjNBUm9h?=
 =?utf-8?B?RUVqMC9iNGgxSENrUk4zMDZpS2x0RUZ3UFVtcFhxeTdHd25Na3dvR3RmRmpR?=
 =?utf-8?B?cTU3OVZLUTNnTDdQSU5BZGFEeGlpQ0ZkLzVKdmV4TDhFWCswTU5LSThmU0FV?=
 =?utf-8?B?RDNTR0ZKUW4zVys3a1ZYVWJDbmhBTktXQXoyR1cxcm5RN29FbjgvNDBobVBV?=
 =?utf-8?B?Q1d1SzZMZnlRRldIVVRPYkNwQTF1QTF3MUxUQ0pVTC9zWnNEeE5KUUhrcVRO?=
 =?utf-8?B?em14Q3lTbk9lUi9IVW4zS2s3ZmMzNEdzWGszMThGaUI1TWZJdHFHK3RiZDhN?=
 =?utf-8?B?NmczS24rMGEzNFM3Y3ZDeG1vdU5tWmRUM1FFRWVSam9iRTBBNUVsVnZKNjJt?=
 =?utf-8?B?VWE0OXFVVytHR2R4ZXdJMW9MeTZjc3Jya1J6bzE4SDZYOUY1RmZCa3dSaVlk?=
 =?utf-8?Q?pMtHX9kkwXrZNRwtRZocC49vHQEIEYbLk8DjP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62FDAD742BCD164FAB12D25F04F81007@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95943c79-4edc-4593-a894-08de73cd931e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 17:53:10.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /h6+xk9NAgGRxLQrP8gWWMSVDmd0Zr859l+bocF627RJKbqN4PSTIfyltOK7Z1cWFQjb5JM9wiYfvJcq3Ak6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6415
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: fu8b2XDBRzpLFWdsvL0H5UaESBTlaElM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0OSBTYWx0ZWRfX383armsCvhf5
 rvN+sONjb+jBYN3VC9xWrkXOtXJRUbKyo8CVK61yzxo0y7OJpyHfaOeVznP6Vn6jk3GGeS8bwnU
 bd1HSjLQQg3uotFxStUPsy6McHuMv0fomkafXCjNuhJsSEQ9sY9mFlLzD1xwz+zvaRKrRAF/O8I
 yjFCj+A1xmFRuxMN6zXAAoknJ+n+G8MHPtSnC3UkpwQoR5FDVoUL5Sf+e5cF1V/SHyG6t0PNTmT
 tsTgK3wF/g81zPb9NBiZd1R2myqF8tsKfEelwOjrPw9NOA2caAkbljLSIOtzQWASBUT1LdH4TKo
 +00ARgPJ82ILRenjMRBICTGA6I539tOmeOqdMuHnnbDkNpOH1lOX05zq3gtRzQk5E0yk8m+SSNk
 KMyCEnyi5+fzc8rsOLJjqpOrtEXdzilfuF7r5KQGfYop8wprsxplrzNrjXVy2EoB9Q96cQ025Ql
 2q5a3kYMsHdT/vOsyag==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699de58a cx=c_pps
 a=EsAf7Oic3mfDXMJ3krB2BA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=ivx8gKdnBCTO4u5NxrUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -aspkOd9fo8PDhl34YS0448_4VgrR3tb
Subject: RE: [PATCH v5] hfsplus: fix uninit-value by validating catalog record
 size
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240149
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78294-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[posteo.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B4DE118AC64
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTI0IGF0IDA5OjU2ICswMDAwLCBDaGFyYWxhbXBvcyBNaXRyb2RpbWFz
IHdyb3RlOg0KPiBEZWVwYW5zaHUgS2FydGlrZXkgPGthcnRpa2V5NDA2QGdtYWlsLmNvbT4gd3Jp
dGVzOg0KPiANCj4gPiBPbiBUdWUsIEZlYiAyNCwgMjAyNiBhdCAxMjoyOOKAr0FNIFZpYWNoZXNs
YXYgRHViZXlrbw0KPiA+IDxTbGF2YS5EdWJleWtvQGlibS5jb20+IHdyb3RlOg0KPiA+ID4gDQo+
ID4gDQo+ID4gPiA+ICsgICAgIGNhc2UgSEZTUExVU19GSUxFX1RIUkVBRDoNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAvKiBFbnN1cmUgd2UgaGF2ZSBhdCBsZWFzdCB0aGUgZml4ZWQgZmllbGRzIGJl
Zm9yZSByZWFkaW5nIG5vZGVOYW1lLmxlbmd0aCAqLw0KPiA+ID4gPiArICAgICAgICAgICAgIGlm
IChmZC0+ZW50cnlsZW5ndGggPCBvZmZzZXRvZihzdHJ1Y3QgaGZzcGx1c19jYXRfdGhyZWFkLCBu
b2RlTmFtZSkgKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICBvZmZzZXRvZihzdHJ1Y3QgaGZz
cGx1c191bmlzdHIsIHVuaWNvZGUpKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBw
cl9lcnIoInRocmVhZCByZWNvcmQgdG9vIHNob3J0IChnb3QgJXUpXG4iLCBmZC0+ZW50cnlsZW5n
dGgpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU87DQo+ID4gPiA+
ICsgICAgICAgICAgICAgfQ0KPiA+IA0KPiA+IFRoZSBjaGVjayBpcyBpbiB0aGUgSEZTUExVU19G
T0xERVJfVEhSRUFEL0hGU1BMVVNfRklMRV9USFJFQUQgY2FzZSBpbg0KPiA+IGhmc3BsdXNfYnJl
Y19yZWFkX2NhdCgpIGZ1bmN0aW9uIChmcy9oZnNwbHVzL2JmaW5kLmMpOg0KPiA+IA0KPiA+IFRo
aXMgdmFsaWRhdGVzIHRoYXQgd2UgaGF2ZSBhdCBsZWFzdCB0aGUgbWluaW11bSBieXRlcyBuZWVk
ZWQgYmVmb3JlDQo+ID4gY2FsbGluZyBoZnNwbHVzX2NhdF90aHJlYWRfc2l6ZSgpIHdoaWNoIHJl
YWRzIG5vZGVOYW1lLmxlbmd0aC4NCj4gDQo+IEhpLA0KPiANCj4gU28uLi4geWVzLCB3aGlsZSB0
aGlzIGlzIGVzc2VudGlhbGx5IHdoYXQgSSByZWNvbW1lbmRlZCwganVzdCBjaGVja2luZw0KPiBl
bnRyeWxlbmd0aCBhZ2FpbnN0IEhGU1BMVVNfTUlOX1RIUkVBRF9TWiB3aWxsIHlpZWxkIHRoZSBz
YW1lIHJlc3VsdHMsDQo+IGJlY2F1c2U6DQo+IA0KPiBIRlNQTFVTX01JTl9USFJFQURfU1ogaXMg
YWxyZWFkeSBkZWZpbmVkIDEwLCB0aGUgc2FtZSB2YWx1ZSBhcyB0aGUNCj4gb2Zmc2V0b2YgY2hh
aW4uIGhmc3BsdXNfcmVhZGRpcigpIGFscmVhZHkgdXNlcyBpdCBmb3IgdGhlIHNhbWUNCj4gZ3Vh
cmQuIEl0J3Mgc2hvcnRlciwgY29uc2lzdGVudCB3aXRoIG90aGVyIHBsYWNlcyBhbmQgdGhlIGlu
dGVudCBpcw0KPiBpbW1lZGlhdGVseSBjbGVhciAoZWFzaWVyIHRvIHJlYWQpLg0KPiANCj4gDQoN
Ckl0IHdhcyBteSBleHBlY3RhdGlvbiB0byBzZWUgdGhlIGNoZWNrIHdpdGggSEZTUExVU19NSU5f
VEhSRUFEX1NaIGNvbnN0YW50LiBBbmQNCml0IHdhcyB0aGUgcmVhc29uIG9mIG15IGNvbmZ1c2lv
bi4gOikgSSBjb21wbGV0ZWx5IGFncmVlIHdpdGggdGhlIHBvaW50LiBJdCBpcw0KdmVyeSBpbXBv
cnRhbnQgdG8gaGF2ZSB0aGUgY2xlYW4sIHNpbXBsZSBhbmQgZWFzeSB1bmRlcnN0YW5kYWJsZSBj
b2RlLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

