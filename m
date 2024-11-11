Return-Path: <linux-fsdevel+bounces-34258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F6E9C420B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB99A1F23C58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1DA1A00D1;
	Mon, 11 Nov 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U3aS2enD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vALgTjwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1280034;
	Mon, 11 Nov 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339635; cv=fail; b=t3nnNUaCGMGSQ2tDduggJW8wGyM8bO9S/5LvE/NffQfco3hM3VBUwf2pFnVRYmsf/8nXaXaKvH42TdGb7Q3dQjIUBmE8ulsoAqyFS6NGfmftNjeFWvhk1sGzXYptHp9j+g18zPRCaVWDaAJABPp1MGylN9dPNealytp1QY5AxT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339635; c=relaxed/simple;
	bh=QgKnTe/P4QNfx/SkQUB23+HLkiwXAqZdpxo8aj2qirY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gfa3udl3ZDdyrj8mQjPaEbZg4KtkeJUKk6+UjqHEMeDrX1pXIGkl7LHZTKJOpq5ymp2FsX/9i0kuk2CGkz4Wxgmrsin0Nbf9WbI1FtM7P8MagTl5PI4oyFaNW7U2BNIaUHgAK7Rzzridtytzg7iFFGrtIlA+Toz09zS5cEcVxb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U3aS2enD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vALgTjwU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9smde002330;
	Mon, 11 Nov 2024 15:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QgKnTe/P4QNfx/SkQUB23+HLkiwXAqZdpxo8aj2qirY=; b=
	U3aS2enDIkuED2y1DVCQWfCb7wnkrxpUfRS9KgbH90yFD4qf9jYh+714qulpr0bE
	b2QFyIaW2LeghpKugnzCCYyk1gBNGmux/8oq0t2spFlVT8LQiXkqFzbUdTh3WRiV
	iykkQ0xD/plxDyiEXJcMfpKmPNp5PRgfbqQRXTVVv0Pz5XWfK1Uz0i9PJ//KMBjE
	vGoP80+77hYa9QpVtn3ebbR+qhB4PI5hFCBbcX99wT9N7tAlnzY8B53CERJGZNBV
	uGmJj18y55gJcqSNd7buOu/XpTTBJhrHfbQGXx13pfK7F6Th7/1LYiGofB0F59+/
	XD9NgW6NWs4OY2GIz7VGuw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hejnxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 15:34:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABElAbB037828;
	Mon, 11 Nov 2024 15:34:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx675bk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 15:34:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjm9uoZU4Ir/MVsTNRQZd/CgMRYSGb1TqiqpfTsMe3gn/VYIFMfmWg6fGa7RhEx8lSKMsJvGnei4ABmQ7ZEmIgPklAk4Xt+DT75R+HiBQSWg/lmX11q9utkKo9bni5/4tN/OKdwBNEJI8+Bxt2t3LPLqixaywInaYALN0vWX4Ks9le7OILwGGCB1/78G9ap5gO0EMyV1mZ6tHnxVTRnmAiSSluTZG7frrMs0x56ol6cAJ02jEBgQW0qRPohCNPh4RGlp7JKE7iKiC+GQGZI1lz2YdGdzRQqCS9hh4QnUwghqdPHwD995QlT1Lw2vNKaK8f8VsrM5LBRvLxtSbcxn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgKnTe/P4QNfx/SkQUB23+HLkiwXAqZdpxo8aj2qirY=;
 b=DBzCX5oGJ6xenjnyjojkujNVRywyt/qaQfmSGyWAvr+gY7Pjw4HM/2XH/+16icE59bX1VCiImVV0nf/G9xIyxSXDmEo2psn9C1XtwQ3AkiCvzwVEB1mTq0gnNVapDKb7hsXotEP40KT7YOkE1WYVCx+m7C/8yp8dzuBwMKnKFC2v2e1PsI6L2J/3Ldow0dVLKI9YRzppGBoohoKZlCX4tdvyVY6Fwjb5BSW7bNybHDGP4vjF6Sfev2tTnVKJqxnJ74ePi8Nu1Pi2ry1ex4FbD7J2n0z5a7tG4XKSKUK8udkJ3rRTYo8eclpdO3BN6VBbJ6T1jtfSWnSY/phw6T1J5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgKnTe/P4QNfx/SkQUB23+HLkiwXAqZdpxo8aj2qirY=;
 b=vALgTjwU90MD84bwf371N5RLhAlqT0d7cqTalN23WrpsY1tmE3tsXwjCBqTq+UsXctSegmnPIq69u2Un9N7xP/hSwoPbgbLbNGwsP93bHCAv7FAEtW62LRACG0aC08eGJ20AIyiizXCLZVpP5p/c9FXtgVlSTwPydCTgs7oky7I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Mon, 11 Nov
 2024 15:34:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 15:34:27 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: yangerkun <yangerkun@huaweicloud.com>
CC: Yu Kuai <yukuai1@huaweicloud.com>, Chuck Lever <cel@kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        "harry.wentland@amd.com"
	<harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
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
        "yukuai (C)"
	<yukuai3@huawei.com>
Subject: Re: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for
 offset dir
Thread-Topic: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for
 offset dir
Thread-Index: AQHbM9Qf5MGHjWzrD0e387x3Myz9zbKxXU4AgADJ6QCAAAuNgIAAA+kA
Date: Mon, 11 Nov 2024 15:34:27 +0000
Message-ID: <09F40EA2-9537-4C7A-A221-AA403ED3FF64@oracle.com>
References: <20241111005242.34654-1-cel@kernel.org>
 <20241111005242.34654-7-cel@kernel.org>
 <278433c2-611c-6c8e-7964-5c11977b68b7@huaweicloud.com>
 <96A93064-8DCE-4B78-9F2A-CF6E7EEABEB1@oracle.com>
 <73a05cb9-569c-9b3c-3359-824e76b14461@huaweicloud.com>
In-Reply-To: <73a05cb9-569c-9b3c-3359-824e76b14461@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7173:EE_
x-ms-office365-filtering-correlation-id: fb6b9a91-3c26-410d-5c5e-08dd02665414
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yyt1SUNZSHg3d2xLdlJhbk9YVEp2ZW1kMWNKOG4zYzZhTGRHaDgyVXAyRENE?=
 =?utf-8?B?Q0F6VE1rZXU2U3NKeDRZQllZVnduL1JaeWpoZ0RZaWVydnhPY2RDL1JhTnd3?=
 =?utf-8?B?RFA5dHN2cElOK00xRWRhb25HVGd1YkJ4WGJZeVpVSmkxTWJvdWtma0E1SVVp?=
 =?utf-8?B?NW11bWpVTFRtWmVoSXNoTEJwZUZyREwxTEVzZWhTRjdjNy9RVkxIR0FITXpX?=
 =?utf-8?B?MVc3VlhuWWRzVFo5ZFpVbGxvVG5jQ1NxUExmZnoyNG5iajc3ZHMzbnZqbXRz?=
 =?utf-8?B?cFlIT2NmSWpwMFBSNWRiWjBjcW9MenptTUNiMTdPOVlFSWw5WmR3Vm1WU0lk?=
 =?utf-8?B?NG1tUkl2RnhSS1pYUWJySGNSVVhtYjlEU255WUdVb1V3bHpoYjVmaGdTNjBU?=
 =?utf-8?B?S1BrajJ3MitMQmsvZ1IyQ3Y3ZDQrNVFaSmRobHBYSDQ4K25RalhLV0FHY0kz?=
 =?utf-8?B?RklSd0MzZjhxcTJIalVPdFAwbzlxRHZEUm1uUUtUbktUM1o0NnY0QzBWWTFw?=
 =?utf-8?B?a2Iwd2FpZmN5NWhhKzJvODd1Kys1WUhOOFRNaFRKWit3VGtwakN5Um1JSHNp?=
 =?utf-8?B?Z1hNSk5oZzBteUZpQnYyME9lM3hucUk1ZWhGTDNQNExyNk5DSDNuVFBobGtr?=
 =?utf-8?B?VnFqVHRpdWhZWEtyVEZYSVl6Z0VjYjBoajNhaVd2dmswQWRvYk5kYnd3Y2VY?=
 =?utf-8?B?ZEQ1cUoveU9NdlBHVUdzbUlmcTUrd0JLY1RHK21QRXgwYUJySDRDZENFamJh?=
 =?utf-8?B?YzNzMHU5UnBrQXBtU0xEVHl3V1FUQ1F2eW85SCtSU2p2dmQ1OERrRWdIQU0z?=
 =?utf-8?B?U2lORUl1a2E2V3pXN21JcmV1d3FXODdZSjNuZENGOUZxN1hkT2VzWjFHa0Fi?=
 =?utf-8?B?Vzd3NkFlRnZHeVNVUkppNzhnTXRwSk9Bc3ZsN21EU29mS3FWd1c2RThLT2dP?=
 =?utf-8?B?RWRWTnVSRDhwTW9DTVpVVGZxWWFDUkZWUkg1WFhhVGpCLzc5V2xPN2pkUGRp?=
 =?utf-8?B?bXhCSm1YR2JPanMxV1VXOFl5UE9uMC9kTjRlZXBORmtLcmFwTVV3UWhjTFRC?=
 =?utf-8?B?Vk0zRmhjMTVubE5zOHpzbTI4VnU4cXdubVMzSWc1SW5DWXlJMTlWTm5WYklQ?=
 =?utf-8?B?WVNEQ2Q3YnVudXM3dGVrOVBzTzlLZ0dkK2dZVFllMldNSDQ4R2NNSkovcUFF?=
 =?utf-8?B?MHpLcEdNYVNyUHl6dmlhOGE4dTlpN0pLU1E2MVdMekt4VTQ1T0pKWkNnTkIr?=
 =?utf-8?B?bDBCSGtWY1h0RWxyMkN1Mkp4N013QUFFK01vTUdJazFjd2t5dFFnN2cxZ2JF?=
 =?utf-8?B?a1M4Uzk4cjZMN3piWDRSKzFHNEdUaGozLytUNkxOUDh6Qk5QOU1wNk1RYmNw?=
 =?utf-8?B?TXdlVFZJUFRYVEVGTkM2b29GUGVSOG9oU01yTTJKUmxSdDlPdmZiRXBTRWFa?=
 =?utf-8?B?NUIyYTZ3L3ZVeFN1cS9LSzR4a3pQbER3SlZtSHMrYnNVZ1dQVmZ1ZFhwUUZz?=
 =?utf-8?B?ekdkRjlubmxURGRtTjc3UW05QnB5UU8yd21Yc0lEdHFIV3FCUGZ6NzRzWEhu?=
 =?utf-8?B?TVI5Y0pqSDAzMVlOLzk5blRxK2NuUWhUOTlidmNycUp2b0ZaNVErOGk1SzQr?=
 =?utf-8?B?VFEyMUpRWm5tYWEvUWpYWGRGV3pIanBMVzR6Y2tHS1NuZ3l1dEhZd2grRWtk?=
 =?utf-8?B?cDdNYkhmcUtmRFFMVWszY2JUSjFhbTBDa0FyQ1NXOEI1ZldiRjRWSWI2ZWlX?=
 =?utf-8?B?UXJtUWJoZkVBNWF6YzdXZkFlelBtZ2Fheml1VVpNQzF1RVFLT1FMaWtuNC9m?=
 =?utf-8?B?YllFZnpiazZQRVNrT0p5QjRVSW05MDNXZVVuMnZqVFNOU3V0Nld6a2diSGpw?=
 =?utf-8?Q?Z3pjQcX9phYhA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFhLZDNQa1ZLS2d1VEVLQlFUWkJtcjBMT05nQXJMYUdQclhMbHBzNncxaTNW?=
 =?utf-8?B?SlBuQm9oSC9VVDBBQnZnL0NHMk0yQ0pJZGg0UjVMOHNxcVNTYVlrNzlpV3k4?=
 =?utf-8?B?MVU0Vk9XN0hKM0VURFpnUFd0bGlsWjhnTFQwSDZqb0NVN0ZxbEhaWXpOSDBB?=
 =?utf-8?B?akRYSFdBOFU4TXpIcXVQbUxVV2trd3p4UXkwandzNXVGRVlmWFJ0eUprTGsy?=
 =?utf-8?B?Z2xTZlVkRW04blJINk5sUUpRRE5FMmoreHVyQ0ZZUHlsUHBwYXdONHRjWk5R?=
 =?utf-8?B?bHpmR29raWNHZkZDK0VhRm9XdUw0M3IxdjFVNlRjM2JDT3B6Zk94MklWbmpr?=
 =?utf-8?B?SmhxUkVQYngwWjFsV3A2cUNpMzN5OFZQdEhEWjc2NC9EUEVlcGZHWitIYzNF?=
 =?utf-8?B?SXQyYWZMZ0xybjB5Z0JmdFVOeXZxNTlmTzVneGtoOWpnRWEvbmVtajlGamda?=
 =?utf-8?B?NlZ4WjhVNUs3QWJRYldKWGhZQmdUbG9ZbkIxUHJZWVFXWnpNSVNKd0huUWtQ?=
 =?utf-8?B?SEYySTNBZXpJUUlsMXh2SC9pOTFuQXVHdXk5akovZzF3TnNJajhpaG5UZ1Zl?=
 =?utf-8?B?RlE4VVVVdVpyV1ZTR2RSNkFpRTRCc3REdTVBa0owTHp4QkxSR0hRU2I4R3N6?=
 =?utf-8?B?WWh2ZTN2dW5HSmNzT0lhb2U3clRkVVNEYVZXODRKcHhKVHZoZEttK3pMRnoz?=
 =?utf-8?B?d0FlR0JDVG9JTnY2ZzVzQUY2b0xCVXNSdTFkV1YxbS9tQ1FoU3pUY2pEMExa?=
 =?utf-8?B?VkV0Mnl6NW5HT3ExclAzZVFtQjNXS21SbEFMNU54Vk5aY2R4dmtpN3pWTU9x?=
 =?utf-8?B?SnZkMmVKU05QT2hPVFRobDRsTFRTdGNLWnNzdTFjWkluRGY2VzNqWGtkMzRi?=
 =?utf-8?B?S1M0cVhLSHBPYmo2UnNiTlN0RFlRUlV0ODJSamhWT1pzZEUvMkVicGVRUzFk?=
 =?utf-8?B?V1JsTXp1SHAzUVBkczJKMTA0am1ZL3psS1JUdkdsbUhqVWt6RmFnQmtJYU5M?=
 =?utf-8?B?VGVkbDMvVFE3eTJkdDBhbmdsWDBzWmVZNlFoZnFCdllLVjd1bVBzYjQvaUdG?=
 =?utf-8?B?akQ1clZQcEswT1IvNGFGcktUN0sxRmZKSGNaczdQbTN3dzhycDl2THFHRDhJ?=
 =?utf-8?B?RWl2NytFM1ZMbm42RnZmQ0RHTmdFSVFpdWdPR1NIaVU1cjV2SGQvYmRPY1R6?=
 =?utf-8?B?ZHZXV0tFNmFFQzZoTTJXUkd4bURHaVVrUy9vUkM1VTFyZ08xQlh4WUo4OS9U?=
 =?utf-8?B?cGpUSDFsRkZlMlIxME45SG8yK3hENTdOR2dONVJmTUhDR1Iyc3NOSmVKallO?=
 =?utf-8?B?R011NlAyR0tSYVkyMHAxWTJVL1QwQ2EzVk4vRFp1ck11MnU0Z2dRdmFiTWRx?=
 =?utf-8?B?dFBpWDV6NEJwQXg4WFE2UkNSb3lvL3RzZENFTGFYY1c4RUIvVytYMkJMRVlI?=
 =?utf-8?B?emhEWER5OGh3cEdxSjRXbGR3MXBZaTA3NnpCaUdqQXE2VlZuRU5hMDdtYnRt?=
 =?utf-8?B?ZTcrT0JIMzNycnVVUjZkU1B6bzBjeVlJRzNxVUJwaWRvcUFaTWxPREZ6bmI4?=
 =?utf-8?B?eGJlc0JjQ0paWXI0b282LzFsRkxMcjk0dldMZSt3RElHRUozN0wvY0hQakIr?=
 =?utf-8?B?d1BwdldmTDIrS2RJZXdCbmNXczlyVDJUSFhKNkJxeFdQbk9jS3IyVWJQU2NH?=
 =?utf-8?B?Wnh3YVhLd2VQd2kvNmdXQlNkb1FPQ0VMRGV4bzlqa21ZT1N1OHVaOW1VbW9Q?=
 =?utf-8?B?aUc3UW1yQTRMbWdueENLMXNIYW96NjJlb0FQWWdOdld2eTFicG05bEVGSkEr?=
 =?utf-8?B?K2dZaXVBU1pzRFRHZ25JQjQzSEppbXNmRVRWQWs3SlpkUmxlY3VYL1NzSG1P?=
 =?utf-8?B?RWhtQ0hxK0tTSS9LQnZhSEZQK2p1ZkxMdnpYMU4wWXk0bGNSN2lrSmtSZEhw?=
 =?utf-8?B?TlVkc0tiakphK3BlMktkL3FDMlRxYTlkZVh1QzdtdVdhYTdkWlAyT01pcEFw?=
 =?utf-8?B?RHpnWUgxTHBaZExMVGxPTWNka2U0YUxkbzM0MXluT3AwVTFmcHMzQWNZejNT?=
 =?utf-8?B?M3MvWTlBb255MVRFNWhxU2VLRUJwNUJ0ZFY0Q3k3NjdtaWs3NFh1bUUwb3dy?=
 =?utf-8?B?dzZJZFJMbnVsZEVxeHhaSjYzUEZsR0d6Q3hrWmcyLzdkM1pONkVMOFpzTnhr?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBCCF0EB9F14054B8C26C813586E3DE9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RDLlrX6NkohyRLCyFLhdaLvjnNvtH59JBe/JTuMvIOdICcD4cvPDIbLLO0rN4G29rG7IMXdBV1X0v7IoOF1BHm3R5wep00cB7lwljmL5571nDOWHQFLFzQTG1rXxgTcJLu4oPPW7NsKQ3tQPgO/yzjdAVP2NI+5ObvXe2EhpAACjRTWcd9lQzBhM0EtsY91XsQ4KWHbkz/bMuIy+ASHOsE6GjnAoE068719ojXzBuph6EEfjxsO18ANZLDYmSmXbWHja7Mq8SkUwAPnibU9mhFuek4w3pArUs/PUK4JRNzYX6uy12M8qrEwUsiJABqQSFWTaHAHFXxGkvafRznLoQNWl/OOkJhRz4WFLDOn9sNz6cjzEqzPKa4Kvsd36D8RKclOkyjX0XYXF85xqG/FZwDh5h26usLoSv2bJKoqutxDL/gioK+rPIXPIgsarZlDQIOLeELA1jpumXXzq2I00hHDi+LIrkQy0rkRmpYjQe9Zrm4D7zfmBDkjnGD0Hgk1GfWuLodbD6ziZ46VIxaU4xcIukyLNKvPkflkChXqPaH8kv8lIQFNSYcbT+x8urMBksgHrO9OETkH0JVhTP1xWzHg0MoJtKrMzvF2Q7pKpT4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6b9a91-3c26-410d-5c5e-08dd02665414
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 15:34:27.6474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7s7EqWcIXrCX1aDH2gNXC8sXer48e25N9Iv60uUHqeymvfVTVebe4vBIt8D+S52w7Z0L1SJilRo9kvZ7vmLjTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110128
X-Proofpoint-ORIG-GUID: 3QCSpYLb_eaO0Fy1O-N9FJBGY6VOdJxL
X-Proofpoint-GUID: 3QCSpYLb_eaO0Fy1O-N9FJBGY6VOdJxL

DQoNCj4gT24gTm92IDExLCAyMDI0LCBhdCAxMDoyMOKAr0FNLCB5YW5nZXJrdW4gPHlhbmdlcmt1
bkBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiDlnKggMjAyNC8xMS8xMSAy
MjozOSwgQ2h1Y2sgTGV2ZXIgSUlJIOWGmemBkzoNCj4+PiBPbiBOb3YgMTAsIDIwMjQsIGF0IDk6
MzbigK9QTSwgWXUgS3VhaSA8eXVrdWFpMUBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPj4+IA0K
Pj4+IEhpLA0KPj4+IA0KPj4+IOWcqCAyMDI0LzExLzExIDg6NTIsIGNlbEBrZXJuZWwub3JnIOWG
memBkzoNCj4+Pj4gRnJvbTogeWFuZ2Vya3VuIDx5YW5nZXJrdW5AaHVhd2VpLmNvbT4NCj4+Pj4g
WyBVcHN0cmVhbSBjb21taXQgNjRhN2NlNzZmYjkwMWJmOWY5YzM2Y2Y1ZDY4MTMyOGZjMGZkNGI1
YSBdDQo+Pj4+IEFmdGVyIHdlIHN3aXRjaCB0bXBmcyBkaXIgb3BlcmF0aW9ucyBmcm9tIHNpbXBs
ZV9kaXJfb3BlcmF0aW9ucyB0bw0KPj4+PiBzaW1wbGVfb2Zmc2V0X2Rpcl9vcGVyYXRpb25zLCBl
dmVyeSByZW5hbWUgaGFwcGVuZWQgd2lsbCBmaWxsIG5ldyBkZW50cnkNCj4+Pj4gdG8gZGVzdCBk
aXIncyBtYXBsZSB0cmVlKCZTSE1FTV9JKGlub2RlKS0+ZGlyX29mZnNldHMtPm10KSB3aXRoIGEg
ZnJlZQ0KPj4+PiBrZXkgc3RhcnRpbmcgd2l0aCBvY3R4LT5uZXd4X29mZnNldCwgYW5kIHRoZW4g
c2V0IG5ld3hfb2Zmc2V0IGVxdWFscyB0bw0KPj4+PiBmcmVlIGtleSArIDEuIFRoaXMgd2lsbCBs
ZWFkIHRvIGluZmluaXRlIHJlYWRkaXIgY29tYmluZSB3aXRoIHJlbmFtZQ0KPj4+PiBoYXBwZW5l
ZCBhdCB0aGUgc2FtZSB0aW1lLCB3aGljaCBmYWlsIGdlbmVyaWMvNzM2IGluIHhmc3Rlc3RzKGRl
dGFpbCBzaG93DQo+Pj4+IGFzIGJlbG93KS4NCj4+Pj4gMS4gY3JlYXRlIDUwMDAgZmlsZXMoMSAy
IDMuLi4pIHVuZGVyIG9uZSBkaXINCj4+Pj4gMi4gY2FsbCByZWFkZGlyKG1hbiAzIHJlYWRkaXIp
IG9uY2UsIGFuZCBnZXQgb25lIGVudHJ5DQo+Pj4+IDMuIHJlbmFtZShlbnRyeSwgIlRFTVBGSUxF
IiksIHRoZW4gcmVuYW1lKCJURU1QRklMRSIsIGVudHJ5KQ0KPj4+PiA0LiBsb29wIDJ+MywgdW50
aWwgcmVhZGRpciByZXR1cm4gbm90aGluZyBvciB3ZSBsb29wIHRvbyBtYW55DQo+Pj4+ICAgIHRp
bWVzKHRtcGZzIGJyZWFrIHRlc3Qgd2l0aCB0aGUgc2Vjb25kIGNvbmRpdGlvbikNCj4+Pj4gV2Ug
Y2hvb3NlIHRoZSBzYW1lIGxvZ2ljIHdoYXQgY29tbWl0IDliMzc4ZjZhZDQ4Y2YgKCJidHJmczog
Zml4IGluZmluaXRlDQo+Pj4+IGRpcmVjdG9yeSByZWFkcyIpIHRvIGZpeCBpdCwgcmVjb3JkIHRo
ZSBsYXN0X2luZGV4IHdoZW4gd2Ugb3BlbiBkaXIsIGFuZA0KPj4+PiBkbyBub3QgZW1pdCB0aGUg
ZW50cnkgd2hpY2ggaW5kZXggPj0gbGFzdF9pbmRleC4gVGhlIGZpbGUtPnByaXZhdGVfZGF0YQ0K
Pj4+IA0KPj4+IFBsZWFzZSBub3RpY2UgdGhpcyByZXF1aXJlcyBsYXN0X2luZGV4IHNob3VsZCBu
ZXZlciBvdmVyZmxvdywgb3RoZXJ3aXNlDQo+Pj4gcmVhZGRpciB3aWxsIGJlIG1lc3NlZCB1cC4N
Cj4+IEl0IHdvdWxkIGhlbHAgeW91ciBjYXVzZSBpZiB5b3UgY291bGQgYmUgbW9yZSBzcGVjaWZp
Yw0KPj4gdGhhbiAibWVzc2VkIHVwIi4NCj4+Pj4gbm93IHVzZWQgaW4gb2Zmc2V0IGRpciBjYW4g
dXNlIGRpcmVjdGx5IHRvIGRvIHRoaXMsIGFuZCB3ZSBhbHNvIHVwZGF0ZQ0KPj4+PiB0aGUgbGFz
dF9pbmRleCB3aGVuIHdlIGxsc2VlayB0aGUgZGlyIGZpbGUuDQo+Pj4+IEZpeGVzOiBhMmU0NTk1
NTVjNWYgKCJzaG1lbTogc3RhYmxlIGRpcmVjdG9yeSBvZmZzZXRzIikNCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogeWFuZ2Vya3VuIDx5YW5nZXJrdW5AaHVhd2VpLmNvbT4NCj4+Pj4gTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDczMTA0MzgzNS4xODI4Njk3LTEteWFuZ2Vya3VuQGh1
YXdlaS5jb20NCj4+Pj4gUmV2aWV3ZWQtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFj
bGUuY29tPg0KPj4+PiBbYnJhdW5lcjogb25seSB1cGRhdGUgbGFzdF9pbmRleCBhZnRlciBzZWVr
IHdoZW4gb2Zmc2V0IGlzIHplcm8gbGlrZSBKYW4gc3VnZ2VzdGVkXQ0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBDaHJpc3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3JnPg0KPj4+PiBMaW5rOiBo
dHRwczovL252ZC5uaXN0Lmdvdi92dWxuL2RldGFpbC9DVkUtMjAyNC00NjcwMQ0KPj4+PiBbIGNl
bDogYWRqdXN0ZWQgdG8gYXBwbHkgdG8gb3JpZ2luL2xpbnV4LTYuNi55IF0NCj4+Pj4gU2lnbmVk
LW9mZi1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+Pj4+IC0tLQ0K
Pj4+PiAgZnMvbGliZnMuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0NCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMo
LSkNCj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL2xpYmZzLmMgYi9mcy9saWJmcy5jDQo+Pj4+IGluZGV4
IGE4NzAwNWM4OTUzNC4uYjU5ZmYwZGZlYTFmIDEwMDY0NA0KPj4+PiAtLS0gYS9mcy9saWJmcy5j
DQo+Pj4+ICsrKyBiL2ZzL2xpYmZzLmMNCj4+Pj4gQEAgLTQ0OSw2ICs0NDksMTQgQEAgdm9pZCBz
aW1wbGVfb2Zmc2V0X2Rlc3Ryb3koc3RydWN0IG9mZnNldF9jdHggKm9jdHgpDQo+Pj4+ICAgeGFf
ZGVzdHJveSgmb2N0eC0+eGEpOw0KPj4+PiAgfQ0KPj4+PiAgK3N0YXRpYyBpbnQgb2Zmc2V0X2Rp
cl9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPj4+PiArew0K
Pj4+PiArIHN0cnVjdCBvZmZzZXRfY3R4ICpjdHggPSBpbm9kZS0+aV9vcC0+Z2V0X29mZnNldF9j
dHgoaW5vZGUpOw0KPj4+PiArDQo+Pj4+ICsgZmlsZS0+cHJpdmF0ZV9kYXRhID0gKHZvaWQgKilj
dHgtPm5leHRfb2Zmc2V0Ow0KPj4+PiArIHJldHVybiAwOw0KPj4+PiArfQ0KPj4+IA0KPj4+IExv
b2tzIGxpa2UgeGFycmF5IGlzIHN0aWxsIHVzZWQuDQo+PiBUaGF0J3Mgbm90IGdvaW5nIHRvIGNo
YW5nZSwgYXMgc2V2ZXJhbCBmb2xrcyBoYXZlIGFscmVhZHkNCj4+IGV4cGxhaW5lZC4NCj4+PiBJ
J20gaW4gdGhlIGNjIGxpc3QgLHNvIEkgYXNzdW1lIHlvdSBzYXcgbXkgc2V0LCB0aGVuIEkgZG9u
J3Qga25vdyB3aHkNCj4+PiB5b3UncmUgaWdub3JpbmcgbXkgY29uY2VybnMuDQo+Pj4gMSkgbmV4
dF9vZmZzZXQgaXMgMzItYml0IGFuZCBjYW4gb3ZlcmZsb3cgaW4gYSBsb25nLXRpbWUgcnVubmlu
Zw0KPj4+IG1hY2hpbmUuDQo+Pj4gMikgT25jZSBuZXh0X29mZnNldCBvdmVyZmxvd3MsIHJlYWRk
aXIgd2lsbCBza2lwIHRoZSBmaWxlcyB0aGF0IG9mZnNldA0KPj4+IGlzIGJpZ2dlci4NCj4gDQo+
IEknbSBzb3JyeSwgSSdtIGEgbGl0dGxlIGJ1c3kgdGhlc2UgZGF5cywgc28gSSBoYXZlbid0IHJl
c3BvbmRlZCB0byB0aGlzDQo+IHNlcmllcyBvZiBlbWFpbHMuDQo+IA0KPj4gSW4gdGhhdCBjYXNl
LCB0aGF0IGVudHJ5IHdvbid0IGJlIHZpc2libGUgdmlhIGdldGRlbnRzKDMpDQo+PiB1bnRpbCB0
aGUgZGlyZWN0b3J5IGlzIHJlLW9wZW5lZCBvciB0aGUgcHJvY2VzcyBkb2VzIGFuDQo+PiBsc2Vl
ayhmZCwgMCwgU0VFS19TRVQpLg0KPiANCj4gWWVzLg0KPiANCj4+IFRoYXQgaXMgdGhlIHByb3Bl
ciBhbmQgZXhwZWN0ZWQgYmVoYXZpb3IuIEkgc3VzcGVjdCB5b3UNCj4+IHdpbGwgc2VlIGV4YWN0
bHkgdGhhdCBiZWhhdmlvciB3aXRoIGV4dDQgYW5kIDMyLWJpdA0KPj4gZGlyZWN0b3J5IG9mZnNl
dHMsIGZvciBleGFtcGxlLg0KPiANCj4gRW1tLi4uDQo+IA0KPiBGb3IgdGhpcyBjYXNlIGxpa2Ug
dGhpczoNCj4gDQo+IDEuIG1rZGlyIC90bXAvZGlyIGFuZCB0b3VjaCAvdG1wL2Rpci9maWxlMSAv
dG1wL2Rpci9maWxlMg0KPiAyLiBvcGVuIC90bXAvZGlyIHdpdGggZmQxDQo+IDMuIHJlYWRkaXIg
YW5kIGdldCAvdG1wL2Rpci9maWxlMQ0KPiA0LiBybSAvdG1wL2Rpci9maWxlMg0KPiA1LiB0b3Vj
aCAvdG1wL2Rpci9maWxlMg0KPiA0LiBsb29wIDR+NSBmb3IgMl4zMiB0aW1lcw0KPiA1LiByZWFk
ZGlyIC90bXAvZGlyIHdpdGggZmQxDQo+IA0KPiBGb3IgdG1wZnMgbm93LCB3ZSBtYXkgc2VlIG5v
IC90bXAvZGlyL2ZpbGUyLCBzaW5jZSB0aGUgb2Zmc2V0IGhhcyBiZWVuIG92ZXJmbG93LCBmb3Ig
ZXh0NCBpdCBpcyBvay4uLiBTbyB3ZSB0aGluayB0aGlzIHdpbGwgYmUgYSBwcm9ibGVtLg0KPiAN
Cj4+IERvZXMgdGhhdCBub3QgZGlyZWN0bHkgYWRkcmVzcyB5b3VyIGNvbmNlcm4/IE9yIGRvIHlv
dQ0KPj4gbWVhbiB0aGF0IEVya3VuJ3MgcGF0Y2ggaW50cm9kdWNlcyBhIG5ldyBpc3N1ZT8NCj4g
DQo+IFllcywgdG8gYmUgaG9uZXN0LCBteSBwZXJzb25hbCBmZWVsaW5nIGlzIGEgcHJvYmxlbS4g
QnV0IGZvciA2NGJpdCwgaXQgbWF5IG5ldmVyIGJlZW4gdHJpZ2dlci4NCg0KVGhhbmtzIGZvciBj
b25maXJtaW5nLg0KDQpJbiB0aGF0IGNhc2UsIHRoZSBwcmVmZXJyZWQgd2F5IHRvIGhhbmRsZSBp
dCBpcyB0byBmaXgNCnRoZSBpc3N1ZSBpbiB1cHN0cmVhbSwgYW5kIHRoZW4gYmFja3BvcnQgdGhh
dCBmaXggdG8gTFRTLg0KRGVwZW5kZW5jZSBvbiA2NC1iaXQgb2Zmc2V0cyB0byBhdm9pZCBhIGZh
aWx1cmUgY2FzZQ0Kc2hvdWxkIGJlIGNvbnNpZGVyZWQgYSB3b3JrYXJvdW5kLCBub3QgYSByZWFs
IGZpeCwgSU1ITy4NCg0KRG8geW91IGhhdmUgYSBmZXcgbW9tZW50cyB0byBhZGRyZXNzIGl0LCBv
ciBpZiBub3QgSQ0Kd2lsbCBzZWUgdG8gaXQuDQoNCkkgdGhpbmsgcmVkdWNpbmcgdGhlIHhhX2xp
bWl0IGluIHNpbXBsZV9vZmZzZXRfYWRkKCkgdG8sDQpzYXksIDIuLjE2IHdvdWxkIG1ha2UgdGhl
IHJlcHJvZHVjZXIgZmlyZSBhbG1vc3QNCmltbWVkaWF0ZWx5Lg0KDQoNCj4+IElmIHRoZXJlIGlz
IGEgcHJvYmxlbSBoZXJlLCBwbGVhc2UgY29uc3RydWN0IGEgcmVwcm9kdWNlcg0KPj4gYWdhaW5z
dCB0aGlzIHBhdGNoIHNldCBhbmQgcG9zdCBpdC4NCj4+PiBUaGFua3MsDQo+Pj4gS3VhaQ0KPj4+
IA0KPj4+PiArDQo+Pj4+ICAvKioNCj4+Pj4gICAqIG9mZnNldF9kaXJfbGxzZWVrIC0gQWR2YW5j
ZSB0aGUgcmVhZCBwb3NpdGlvbiBvZiBhIGRpcmVjdG9yeSBkZXNjcmlwdG9yDQo+Pj4+ICAgKiBA
ZmlsZTogYW4gb3BlbiBkaXJlY3Rvcnkgd2hvc2UgcG9zaXRpb24gaXMgdG8gYmUgdXBkYXRlZA0K
Pj4+PiBAQCAtNDYyLDYgKzQ3MCw5IEBAIHZvaWQgc2ltcGxlX29mZnNldF9kZXN0cm95KHN0cnVj
dCBvZmZzZXRfY3R4ICpvY3R4KQ0KPj4+PiAgICovDQo+Pj4+ICBzdGF0aWMgbG9mZl90IG9mZnNl
dF9kaXJfbGxzZWVrKHN0cnVjdCBmaWxlICpmaWxlLCBsb2ZmX3Qgb2Zmc2V0LCBpbnQgd2hlbmNl
KQ0KPj4+PiAgew0KPj4+PiArIHN0cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlLT5mX2lub2RlOw0K
Pj4+PiArIHN0cnVjdCBvZmZzZXRfY3R4ICpjdHggPSBpbm9kZS0+aV9vcC0+Z2V0X29mZnNldF9j
dHgoaW5vZGUpOw0KPj4+PiArDQo+Pj4+ICAgc3dpdGNoICh3aGVuY2UpIHsNCj4+Pj4gICBjYXNl
IFNFRUtfQ1VSOg0KPj4+PiAgIG9mZnNldCArPSBmaWxlLT5mX3BvczsNCj4+Pj4gQEAgLTQ3NSw4
ICs0ODYsOSBAQCBzdGF0aWMgbG9mZl90IG9mZnNldF9kaXJfbGxzZWVrKHN0cnVjdCBmaWxlICpm
aWxlLCBsb2ZmX3Qgb2Zmc2V0LCBpbnQgd2hlbmNlKQ0KPj4+PiAgIH0NCj4+Pj4gICAgIC8qIElu
IHRoaXMgY2FzZSwgLT5wcml2YXRlX2RhdGEgaXMgcHJvdGVjdGVkIGJ5IGZfcG9zX2xvY2sgKi8N
Cj4+Pj4gLSBmaWxlLT5wcml2YXRlX2RhdGEgPSBOVUxMOw0KPj4+PiAtIHJldHVybiB2ZnNfc2V0
cG9zKGZpbGUsIG9mZnNldCwgVTMyX01BWCk7DQo+Pj4+ICsgaWYgKCFvZmZzZXQpDQo+Pj4+ICsg
ZmlsZS0+cHJpdmF0ZV9kYXRhID0gKHZvaWQgKiljdHgtPm5leHRfb2Zmc2V0Ow0KPj4+PiArIHJl
dHVybiB2ZnNfc2V0cG9zKGZpbGUsIG9mZnNldCwgTE9OR19NQVgpOw0KPj4+PiAgfQ0KPj4+PiAg
ICBzdGF0aWMgc3RydWN0IGRlbnRyeSAqb2Zmc2V0X2ZpbmRfbmV4dChzdHJ1Y3QgeGFfc3RhdGUg
KnhhcykNCj4+Pj4gQEAgLTUwNSw3ICs1MTcsNyBAQCBzdGF0aWMgYm9vbCBvZmZzZXRfZGlyX2Vt
aXQoc3RydWN0IGRpcl9jb250ZXh0ICpjdHgsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4+Pj4g
ICAgIGlub2RlLT5pX2lubywgZnNfdW1vZGVfdG9fZHR5cGUoaW5vZGUtPmlfbW9kZSkpOw0KPj4+
PiAgfQ0KPj4+PiAgLXN0YXRpYyB2b2lkICpvZmZzZXRfaXRlcmF0ZV9kaXIoc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpDQo+Pj4+ICtzdGF0aWMgdm9pZCBvZmZz
ZXRfaXRlcmF0ZV9kaXIoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRpcl9jb250ZXh0ICpj
dHgsIGxvbmcgbGFzdF9pbmRleCkNCj4+Pj4gIHsNCj4+Pj4gICBzdHJ1Y3Qgb2Zmc2V0X2N0eCAq
c29fY3R4ID0gaW5vZGUtPmlfb3AtPmdldF9vZmZzZXRfY3R4KGlub2RlKTsNCj4+Pj4gICBYQV9T
VEFURSh4YXMsICZzb19jdHgtPnhhLCBjdHgtPnBvcyk7DQo+Pj4+IEBAIC01MTQsMTcgKzUyNiwy
MSBAQCBzdGF0aWMgdm9pZCAqb2Zmc2V0X2l0ZXJhdGVfZGlyKHN0cnVjdCBpbm9kZSAqaW5vZGUs
IHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQ0KPj4+PiAgIHdoaWxlICh0cnVlKSB7DQo+Pj4+ICAg
ZGVudHJ5ID0gb2Zmc2V0X2ZpbmRfbmV4dCgmeGFzKTsNCj4+Pj4gICBpZiAoIWRlbnRyeSkNCj4+
Pj4gLSByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCj4+Pj4gKyByZXR1cm47DQo+Pj4+ICsNCj4+
Pj4gKyBpZiAoZGVudHJ5Mm9mZnNldChkZW50cnkpID49IGxhc3RfaW5kZXgpIHsNCj4+Pj4gKyBk
cHV0KGRlbnRyeSk7DQo+Pj4+ICsgcmV0dXJuOw0KPj4+PiArIH0NCj4+Pj4gICAgIGlmICghb2Zm
c2V0X2Rpcl9lbWl0KGN0eCwgZGVudHJ5KSkgew0KPj4+PiAgIGRwdXQoZGVudHJ5KTsNCj4+Pj4g
LSBicmVhazsNCj4+Pj4gKyByZXR1cm47DQo+Pj4+ICAgfQ0KPj4+PiAgICAgZHB1dChkZW50cnkp
Ow0KPj4+PiAgIGN0eC0+cG9zID0geGFzLnhhX2luZGV4ICsgMTsNCj4+Pj4gICB9DQo+Pj4+IC0g
cmV0dXJuIE5VTEw7DQo+Pj4+ICB9DQo+Pj4+ICAgIC8qKg0KPj4+PiBAQCAtNTUxLDIyICs1Njcs
MTkgQEAgc3RhdGljIHZvaWQgKm9mZnNldF9pdGVyYXRlX2RpcihzdHJ1Y3QgaW5vZGUgKmlub2Rl
LCBzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCkNCj4+Pj4gIHN0YXRpYyBpbnQgb2Zmc2V0X3JlYWRk
aXIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQ0KPj4+PiAgew0K
Pj4+PiAgIHN0cnVjdCBkZW50cnkgKmRpciA9IGZpbGUtPmZfcGF0aC5kZW50cnk7DQo+Pj4+ICsg
bG9uZyBsYXN0X2luZGV4ID0gKGxvbmcpZmlsZS0+cHJpdmF0ZV9kYXRhOw0KPj4+PiAgICAgbG9j
a2RlcF9hc3NlcnRfaGVsZCgmZF9pbm9kZShkaXIpLT5pX3J3c2VtKTsNCj4+Pj4gICAgIGlmICgh
ZGlyX2VtaXRfZG90cyhmaWxlLCBjdHgpKQ0KPj4+PiAgIHJldHVybiAwOw0KPj4+PiAgLSAvKiBJ
biB0aGlzIGNhc2UsIC0+cHJpdmF0ZV9kYXRhIGlzIHByb3RlY3RlZCBieSBmX3Bvc19sb2NrICov
DQo+Pj4+IC0gaWYgKGN0eC0+cG9zID09IERJUl9PRkZTRVRfTUlOKQ0KPj4+PiAtIGZpbGUtPnBy
aXZhdGVfZGF0YSA9IE5VTEw7DQo+Pj4+IC0gZWxzZSBpZiAoZmlsZS0+cHJpdmF0ZV9kYXRhID09
IEVSUl9QVFIoLUVOT0VOVCkpDQo+Pj4+IC0gcmV0dXJuIDA7DQo+Pj4+IC0gZmlsZS0+cHJpdmF0
ZV9kYXRhID0gb2Zmc2V0X2l0ZXJhdGVfZGlyKGRfaW5vZGUoZGlyKSwgY3R4KTsNCj4+Pj4gKyBv
ZmZzZXRfaXRlcmF0ZV9kaXIoZF9pbm9kZShkaXIpLCBjdHgsIGxhc3RfaW5kZXgpOw0KPj4+PiAg
IHJldHVybiAwOw0KPj4+PiAgfQ0KPj4+PiAgICBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25z
IHNpbXBsZV9vZmZzZXRfZGlyX29wZXJhdGlvbnMgPSB7DQo+Pj4+ICsgLm9wZW4gPSBvZmZzZXRf
ZGlyX29wZW4sDQo+Pj4+ICAgLmxsc2VlayA9IG9mZnNldF9kaXJfbGxzZWVrLA0KPj4+PiAgIC5p
dGVyYXRlX3NoYXJlZCA9IG9mZnNldF9yZWFkZGlyLA0KPj4+PiAgIC5yZWFkID0gZ2VuZXJpY19y
ZWFkX2RpciwNCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoN
Cg==

