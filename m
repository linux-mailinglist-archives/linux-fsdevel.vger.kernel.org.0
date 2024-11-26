Return-Path: <linux-fsdevel+bounces-35930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10149D9BF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 18:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806E72830D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCD91DB350;
	Tue, 26 Nov 2024 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrBpricG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="boCuPdIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED9D26D
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640402; cv=fail; b=HTad/cxmytE9LWZGLVH0ltV5YNvSKR0g0QHniU/fSDRUQNHp4+LVcmReR3gcHzO3F9g2Igq1pawc7pEiBwLNg0U0e+W6+goOu3epKSVEPFMEwMgiCKI8y/e7/P/7TfNPmWBkzfI7+42xgbPV6wjVZzv/avLexn0hKfcCdY+6Sr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640402; c=relaxed/simple;
	bh=GNjgpAlX5o+rKQ+DL0aVSnI8lIH+0OBhInjm/waTWHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=otj6SMlDrXA5/kNMdvOFATRPcsThEhLwaufwkxq5ylr/1Hzkid48ct9iayCcxc4Z7tMltfe+81C103FmkaXAQkIi1MsIjnT2c2sE6VZ7tQLS1eD6nUj9WCWIL7c5CRYaBwAtg6c4s2OOikkSMRTDxuTDfaGjU82Xo0NtrdZ+yiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FrBpricG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=boCuPdIi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQDLXHR013529;
	Tue, 26 Nov 2024 16:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GNjgpAlX5o+rKQ+DL0aVSnI8lIH+0OBhInjm/waTWHE=; b=
	FrBpricGBT4WU80aRWSe0cC9r76iGi+ZcFrOIVb1YfPOk1eifFj5iF5QkDOMcfey
	1fzwB/Ake5ySh9jLXYutimvl9kLkQgXNIIv7XZ9L7Pz4FQiacSVX6ne2r5m7hcv5
	RZwNicf24lPEKVJZ+rmJZBEVHajVIx3hnQFM1k134lzoMJWVubeCGwM2dFksoHMW
	sweGBHx6V97Q0y6r/WxCE2+MwNTxasuBt0Aj8gTpCHA/Ykh8IZyMGBcvS+mga0pz
	YWMQhowBmAhNnXnSzp94eGsoZki/S3ZtJcT1pgGo/3asQceqk2IlbRIIpHizDyIb
	HXWgrasbyPSO3ij/tkLC6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384awype-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 16:59:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQGnx09023673;
	Tue, 26 Nov 2024 16:59:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g98896-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 16:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cotoeWmOKbfKOjepf0+vpifhYDGs100I/DTWX3HfFSGgKE4WS9TvFL90JHt22bH/bmiuvrJTZS+yweCZavE5H4UAF5jbbYL3z0Rw+0FiHqHw1ziRNbJE9tvz/6B2jCvNa3NYxAGJvwgrlHgr7qNCHnsxbZrDSoTZdJNyS1UIXShEbFYCMtDiqolnJTJlcj8zIEvEDW5IB9z/s0qsbX8Z8GknxI2iHLJuRV6VKDR3lHVWT/JBcRpziUHK4OzMmyvjngXiUTA7xGWmoQ6k9JNdeLROh0iy2J2hXDYnrOh5ELsSU4My/rFq1qisrNPTeBp7I/VfJEh1gy9mQuJNB0/Sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNjgpAlX5o+rKQ+DL0aVSnI8lIH+0OBhInjm/waTWHE=;
 b=LZbT0ISwwHn9xhnbh74OAeCDSzDKWj+XKXkqr4sL6X8C61zZnsmwa8tFkojOLklGWmCarZx0hFz7srpYlVsNU569qFgdGi0e6gd8er+v8oItaIlkrbot0RK4Jn5iO7knMEaGY0NZh6JlPrPWIN4gLcDlOZ4bxjOf0NDPbdQGVXiVXknJXwRCuuabb1BR+DnQDU8SfksN15sqrZSJBpqUfid1a4dqVXj23hxnhi6tj1ZcpLdhVxXI867JeDX8V6FFShng/otFEFq5Doc3n5h1Kgpt7owkAusJ7/2i1Zm7K5Zfsl8HZGJYxcfg9wt3PpepCjsyphFSQrOHin+h5FatKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNjgpAlX5o+rKQ+DL0aVSnI8lIH+0OBhInjm/waTWHE=;
 b=boCuPdIi5mpvxR83qP2vX8gzTa6WIcPiU1NCY4/rr3gVs8kpMIek+KAHd34HsC3I7S/i/vwDoE//TpXo38AetKbcTBRM3pl4B4/LdYzEnB74FSVUNkEyq2noUSzEbSMg9Ra6meSVWAHp+WTCuiTLnvNg6gRQ//tI5qSwP7PFIGo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 16:59:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 16:59:29 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: Chuck Lever <cel@kernel.org>, Hugh Dickens <hughd@google.com>,
        Christian
 Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS
 Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, "yukuai
 (C)" <yukuai3@huawei.com>,
        "yangerkun@huaweicloud.com"
	<yangerkun@huaweicloud.com>
Subject: Re: [RFC PATCH v2 0/5] Improve simple directory offset wrap behavior
Thread-Topic: [RFC PATCH v2 0/5] Improve simple directory offset wrap behavior
Thread-Index: AQHbQBuRvQNcpkCIikS66Jrbe6DvCbLJvx0AgAAJvIA=
Date: Tue, 26 Nov 2024 16:59:29 +0000
Message-ID: <06324349-4C36-427C-AEFB-70ABC1DF4E7D@oracle.com>
References: <20241126155444.2556-1-cel@kernel.org>
 <Z0X2PAZy04JGjjFN@infradead.org>
In-Reply-To: <Z0X2PAZy04JGjjFN@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV8PR10MB7726:EE_
x-ms-office365-filtering-correlation-id: fcf2f1bb-4b29-4c87-535a-08dd0e3bb16c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnRyY3c0eHI4SUR0U3l2TUZqYk02ZGpIQUl6YnRxaXZzNEkyUmY1UFp5SEFv?=
 =?utf-8?B?NGtqYUFrazIxbE9hQUdMa0JkV1BJUjc4bjhsQWRnNlh3T01vOHlZdDV0aElU?=
 =?utf-8?B?ZWJja3BXakNzK21QTlVGRzJOSFBxeXo0cWxxOHYzMVRVMDJIZk9peHlXOW1W?=
 =?utf-8?B?UjBNYXR6VTFpdGJGY0ZLUGlpbHJwQmtMK05JVGVBa2lXU0QxSmNBanF5TU1y?=
 =?utf-8?B?WXdKdGtRNlo3Y0U0RjFqYklsV0RKV0h4RHRiQjR6TFFkVUZOU3Zld1pTZUxq?=
 =?utf-8?B?NVo0bndPUG9VVEZnM0tleW4rOXZaaDc5UXkzeGlyZXFBQkVuRG56TkVjeDd0?=
 =?utf-8?B?cElCVzAyeGtYY3BhMEFuZ0Vvb2kyWk9Zbm9zM3djdjkyMml0aDFZNmpnbXB3?=
 =?utf-8?B?RmdxbDBabVd4eWMvMnpNSG40eWdwSUVmUmRkLzlpRmorSVBGdTJpMkkxb2o2?=
 =?utf-8?B?ZWRjQlI1RjNyZ0h0NEI3ZUJ4bERYcUdLZHpoT3pUeFRyZG9Yb2JtV0x0SVp1?=
 =?utf-8?B?b2h2NXludmp0KzRFK1VaVDJueElrL1o0NkhFNFZFc2hoaVUzNWZROVRLcVJK?=
 =?utf-8?B?clJpbEZSMDNVaHhyZG9UNCt3VmE5K1lJSThKdEptVGd5UFIwcHBiRDhQbXhj?=
 =?utf-8?B?eE9rTUh4Yyt5S0FyYW1nK25GL2lNYXVmczliYXBXaDMwdWRJQWozY2o0Szhu?=
 =?utf-8?B?ZFZidGVRTWY2OUZaa3VuRmhRVE9HSkZZWmtsSzRWMXZleG1QTlFGclUwRW1P?=
 =?utf-8?B?Y1ArUUR6NysvaTlOWkRnMFdZU0xucmVYQVA5MmdDOEdndnEyQ2lRM0psT2ZE?=
 =?utf-8?B?Umg4bXFERHF6MkRiZVdZc3ZYUTFZTmVCNUEyd3FFaUp6TjA1eEFpWFIycDY3?=
 =?utf-8?B?czU0TTRsTEdTdkVwa0N0Zml5ZjNKazZLVzVvZkF2QnR6SkpYVjV4bkQreGxz?=
 =?utf-8?B?Rk9HMm9CN2hQUVo4WXd5eWFyWm5CU1JRNWtTZStWODZmUHAvNmdBSlVUNzdG?=
 =?utf-8?B?S00rODBidjB1cEJDNEZFZEdwVWp1d2FidkJ6SHZxK0o1ZFVQazRJajVCZXcx?=
 =?utf-8?B?RXZzMFNObEZtZEdZN1JqbzZsdUdMOU8zOXdGdFQ3bTd2Rnk2US9iUHk2a2F1?=
 =?utf-8?B?VDR4MXJsUDR4akQ3WVZsS3g1WkcvQWQvd0NMN3c4VGpvMS9nSWNLZjZva3Vo?=
 =?utf-8?B?b0dpa05QYjVqM2hFZXNsZW1wdzBWSkhnOWsrbFFtczdqUEtZMkxFa1p5cjdP?=
 =?utf-8?B?blZ5U1MxWGJWL29GT0craEpEbGVoajN4RUI0cGtldjFxNkk1UnY2dEUwcVhS?=
 =?utf-8?B?cXY3Z1M1Rkc4SFhFMno4WjFqR1pOczBHOEtGM0JQNXZpblh6cFdZa2NDdVla?=
 =?utf-8?B?U3ZoT1AwNmdlY2lkWWRRNC9ERHV0NVBkRzRaY0tjR3Ywajk1S0RSZUx6ZHg1?=
 =?utf-8?B?ZmRwamtaaDgvK2xKM0xNdEdQejlJWXpyakVtY3p3VVVpL1lxa29pNlJiM2Vo?=
 =?utf-8?B?Ny80MDNvdmpOVGZwTWVqWm9MVXVhdWRnUnVIY3d5SXRsM0pkRnZtOUwvRS9E?=
 =?utf-8?B?N1ZyQzB4dElGZkhlQmJnRTRJT091NjM4QlFrcnJEVThYcnNyNlptTWNrZ3pE?=
 =?utf-8?B?Yko0MmpQUm5MTDFNZ2dvK2tjRDJtNUFBSHU2WEJscXljQXFzTjB5Znl6a3hN?=
 =?utf-8?B?Y25MRmdBMktpTE5WWGNoakNPKzU5eXh2Z3VZeEliVUFEMFd0VGFNVkU1WFZU?=
 =?utf-8?B?N0RJWk1aOTJMYU5QcVdYMlV0T2dNZTFYbzZRQzIrOG92V1h4dnNlcHk4bTNn?=
 =?utf-8?B?YXlMa2w2SGtpdHluQjRjTU8xNlVZTjNNM005UnM1Wm1yRGpCN2pDU2dPeEdF?=
 =?utf-8?B?TkhmQUJ1UU1ZNnpLd0ZVUk1jNVZxaFZKY2NDWXp3RGZnbWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW54TWJnbXlLakR4TWx2eWlCUkt0Ty8wZnA3ODhMSDJILzkzL0EvSmlWWllS?=
 =?utf-8?B?NkZiYWZlaU1ianorSkdKZEg3aXBvR2M4RHliTklMOVpBK2RLcVhMSXVIMU45?=
 =?utf-8?B?RGxHMGtsNlYzcTBYNmJ5TmdWd2pBL0hWSE9zZzVYaWNTOEx2Q3NONnhLUllB?=
 =?utf-8?B?MDNEdUkzeXlDNWRVc1BlU282ZCs2QlQwdnJ3dndDZVJYaE1FNWRhVVBmL3dk?=
 =?utf-8?B?K0pSa09TemtaamhOTDZla2EzdmNZU0ljUUJzbVhLVStxcXJQaFRFTTdwODlQ?=
 =?utf-8?B?Y0xhNXJmck1nd1orYVFzeVF3QytpeFJieUNienJVUnpCd3UyOFJnY1FpekFh?=
 =?utf-8?B?bnZCVDVKdVIyQ29GUzc3cGxDUHlsc2dJMUFWK3Jsa0F1NzZtekwzb0czeDNC?=
 =?utf-8?B?cVBaWnBCU3Bsbng2bEM5ZmF6RFlKdWZSSFVDYS9nSnkzYTZ5R1hCOXIxWDNn?=
 =?utf-8?B?NWthUC9uTWRQb3Z1aXV0QnRudnRoNytBODlJZVltZklRY3g2VDk3VHJDZ21r?=
 =?utf-8?B?VDFzRFkydHNZMmJBaUxWRWpuSlVJSWthaFV4NmM4UVNLY25ZUHpXRlhtWmtk?=
 =?utf-8?B?bmwzY1VyaFM0UkdoclUyYnhwanZzci9QeWZMNUIwSzlYQ1BXcWhFRk1FWjJV?=
 =?utf-8?B?Rk9CQ09GQnF3b2tOY3pUcmxhNUlIMFg3alJCaEJNMUJSTlFHVkpiV2ZJam9y?=
 =?utf-8?B?dFd6b29RMDlzNUdKT0xaY0tLSUwxV1RpTUZ6SHdDOEZmVVZZSng1VS84Q1dT?=
 =?utf-8?B?NEZxQ1JHZXAvNy9BNUhWN3k4WnFsMWJkVVo5Y0hBakl5MWpMZFg3NnZybWdQ?=
 =?utf-8?B?SEhxMWhqQk9HeDZnWldLVm9ydStNbmNjbU80bmhkUk5iQ3VCUEFPYjRkNDky?=
 =?utf-8?B?emZmZWFDNHY2UHBmRllRbTh4V0trb2dmVFJSSkl0aWY4Z25yeUhDYkFyNkYx?=
 =?utf-8?B?dm0relRJbCtzbVdUMm1DT2lSeittMnRwK0x3dzYrTDgxS1FMRHhjbXRlS2lS?=
 =?utf-8?B?ZnNBdzdEekZ1Nll0empvLzhaN2ZXOXIyaXpqM3VldHo1TWJhUEluOU8xN09Z?=
 =?utf-8?B?aG1iYzA4V3VGWGVqWDE5blRKUTRDd1RxZ2dBNUNQbHVqNElKZFMxRGUrd01G?=
 =?utf-8?B?SStzdXFka0xZOEJ6SzdsSFFsRTBWRG1KNm5tSkNhbDNRWjl4NjNTMlVpNE9J?=
 =?utf-8?B?VmhpSGxkYnpVR1hScVRwRzRQMU5LYXIyWXlMdnBUT3hDczBBT2psOWpIL25q?=
 =?utf-8?B?MkZZTWVmUUZZQ0NtV0hQNjNzOTJpSWFEYjAveUJhQW1oQWZCenNsZWVXZU1o?=
 =?utf-8?B?cXNFLzJuZCtYZlNoczNvQkpSWTlvNmIxUktKQUJMUVRCVUdVZ3RkLzVsTm0v?=
 =?utf-8?B?SFJWeVJXRFUraHhXbjRIS1ovOHlXTko3V2ZndDRyVmJ1dmVyUDl2UC95WkxM?=
 =?utf-8?B?RDhZTytucDM4RXVNb3N5a2FRTTNvRmdpanRlRUF5cDNPR0V0RVNRM09ydVBq?=
 =?utf-8?B?eXl0Mkl2T2VrYzJBN0RJNzRMNjBwaHprR29MUy93bXhzTzVqc0VESHJhY0hZ?=
 =?utf-8?B?ekFqK2F0RzZpbUpFVXp3cUUwVjMvbjRSWlJnNHJvYWNkN1IrbDRDbXg4WDlw?=
 =?utf-8?B?OW5FaDZ4Q0hZakhnMTFLMXllUGs0Sld6L3hya2VaM0ZtQ3hUYWUvR05wclU1?=
 =?utf-8?B?YURhVkZPV2hBWWE3b3F0azNhQ2w0bXJzR042R0tLczg5a2tTTkFva1hpVTd5?=
 =?utf-8?B?VUlsUkRLQjI5a1ZXRXJOZnphQjJFSHpUSFU0elh4TTFmWGIwc2J0TDFzbE5y?=
 =?utf-8?B?Mk9UVE1XNFQ5eDN5Wml6cGYzUXhCdmNsNHIyM25aVVZEeWhyRG5GQS90S3Bh?=
 =?utf-8?B?a3BCMEhCUk5yS1c3VlNtS2UrcVlJZ0p2aGd3ZlJjR3dlMjVueDNSdHVEMm92?=
 =?utf-8?B?ZG80QzdkcmhCMUZMRGtDUElKZ3BFWnc4a0ozcFgwY3IyUnlOSFRqWGdrM3pW?=
 =?utf-8?B?M2N3Rk8yM2ZaS0FQbmhydlBqaTRGMU82RjBQOEIzYUZuNEpDdGRHaEVnVW9N?=
 =?utf-8?B?ZmM2UFh5ZFEreEVRblk0VmFsUXU4dHZzQmg1UVNpdzlQZXJRMnJvTGZMOGxQ?=
 =?utf-8?B?enRoM3RYd3IxWlBTalBLUzZHYXFacDFaK0tJWnpzcUgzNXlXVlNvcUZGcWxr?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFA15BCD1EF96D43B7562DD7C00EB4B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UQgT9RuINuVhv/c6xuMa/liI3nuA1DOXs8Y36JAtHTZn8H054tEttPbyPcEWGFKipRsildcew4YNwYzBECcp8ipZvfmlMb3sbSFdtCYPCRZsUgMJsJcfjPK89JTYiyfOjRinYN1OQGlEngblLs+FD0AZZhfYLKhi8k2F4ZNY0Kb2FPH4Mn6RC8Jw7jKGaA+J30H2HoEQBExHfuMIHcgdLf+v6w/WUMsOqbmn2CVkmnw5VxfTlLHhodDWkHk/zqhaL0EFqtrIGYLzJ1IjPItFBm81YGMhHGjZSCSdWEaS6fzKJuPJPnaWy+RLdxlHWEkF92TdBSNSmWbb+1mUnxO66bNIXz+vj0SF/Y+GtsmnLXhD/Vn8VnPL7B8G7Xl44yPsiE/mXUSCWs+hk1ek+SZLI2HPngGhKD4Jw0vF57JbqNoHXR4A3Clh/ENaQDxvMWgrVgT+2iu6W2JJB9wXbaroDpuOHsSD7ItlQ55HWbfL+EB0wfQYExff/r391+4XbQQ4u0DbjRzGk/LAg1VjL61l4RoloVPh0PnuYZ4dKSjeaT7hAU4pzEMFhHeDXNOHoVKzkZQr787EU1rbYmLLVTxQBlKNmwnD1b+J8PiNjTWtCYY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf2f1bb-4b29-4c87-535a-08dd0e3bb16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 16:59:29.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckNmgfXL3bu5/9TOvgFsR/rt1BwYnbj7sLCjh87H30MPRWMx95VtXzeDUnDPwXAD3gzLQQIiRioqT/uWFOqiQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_14,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=933 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411260136
X-Proofpoint-ORIG-GUID: zZwGCvbLWNrMcX_uL3OOXwN9MevRSShv
X-Proofpoint-GUID: zZwGCvbLWNrMcX_uL3OOXwN9MevRSShv

DQoNCj4gT24gTm92IDI2LCAyMDI0LCBhdCAxMToyNOKAr0FNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBOb3YgMjYsIDIwMjQgYXQg
MTA6NTQ6MzlBTSAtMDUwMCwgY2VsQGtlcm5lbC5vcmcgd3JvdGU6DQo+PiBGcm9tOiBDaHVjayBM
ZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+IA0KPj4gVGhpcyBzZXJpZXMgYXR0ZW1w
dHMgdG8gbmFycm93IHNvbWUgZ2FwcyBpbiB0aGUgY3VycmVudCB0bXBmcw0KPj4gZGlyZWN0b3J5
IG9mZnNldCBtZWNoYW5pc20gdGhhdCByZWxhdGUgdG8gbWlzYmVoYXZpb3JzIHJlcG9ydGVkIGJ5
DQo+PiBZdSBLdWFpIDx5dWt1YWkzQGh1YXdlaS5jb20+IGFuZCBZYW5nIEVya3VuIDx5YW5nZXJr
dW5AaHVhd2VpLmNvbT4uDQo+IA0KPiBBbnkgY2hhbmNlIHlvdSBjb3VsZCB3cml0ZSB4ZnN0ZXN0
cyB0ZXN0IGNhc2VzIHRvIGV4ZXJjaXNlIHRoZXNlDQo+IGNvcm5lciBjYXNlcz8NCg0KZ2VuZXJp
Yy83MzYgZXhlcmNpc2VzIHRoZSByZWFkZGlyIGxvb3AgYWZ0ZXIgcmVuYW1lLg0KDQpLdWFpJ3Mg
dGVzdCByZXF1aXJlcyBrZXJuZWwgY29kZSBjaGFuZ2VzIHRvIHJlZHVjZSB0aGUNCnJhbmdlIG9m
IGRpcmVjdG9yeSBvZmZzZXQgdmFsdWVzIHRoYXQgdG1wZnMgY2FuIGFzc2lnbi4NClRyaWdnZXJp
bmcgYW4gb2Zmc2V0IHZhbHVlIHdyYXAgd2l0aCB0aGUgbXRyZWUgb2Zmc2V0DQphbGxvY2F0b3Ig
aXMgbm90IHBvc3NpYmxlIGluIG1pbGxpb25zIG9mIHllYXJzLg0KDQpJJ2xsIGhhdmUgdG8gdGhp
bmsgYWJvdXQgaG93IHRoYXQgY2FuIGJlIG1hZGUgaW50byBhbg0KYXV0b21hdGlibGUgdGVzdC4N
Cg0KLS0NCkNodWNrIExldmVyDQoNCg0K

