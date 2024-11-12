Return-Path: <linux-fsdevel+bounces-34473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 386139C5C33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5481F235B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424B20262E;
	Tue, 12 Nov 2024 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndIQYEGQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IBxexDRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3331201266;
	Tue, 12 Nov 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426268; cv=fail; b=KqoPvxb1M8Xui0GYIQzcGOYx0OKW/uCcjD72FNInI0SvuwzdlN7cKKxXvaaVBPDJ9x1mzsNFACPzpmg7zn7fsQU10Ig0AY7X5vg8nL294lIueAGGZJttvdlMI1uChPg0Jk+jCdTZ6U+I+Fc06je0z/mkHat2fvZfC2XZjz1Zb70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426268; c=relaxed/simple;
	bh=DPQ849vxdg0tMaUXMm/X0hjIHk98A3vrACmb1/ckn0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qS5u3AD84CcGd0GIQJATXuTuxmCTj6GsNMkwfWpixPOi2j6D4bHb01dHQtsy/4lAI9p4GeA2DjunfVBvq3jGraQ6BcFjjI3fhpJlQePGq9EpJJ2hA7qT9SeZa7OxtjpdDdLNr9bgYZ6D1jnNceApbNTvCile2YDdKZkcypkNR0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ndIQYEGQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IBxexDRR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFNaDi015029;
	Tue, 12 Nov 2024 15:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DPQ849vxdg0tMaUXMm/X0hjIHk98A3vrACmb1/ckn0I=; b=
	ndIQYEGQ4R6AdDVWsTYQm4q+7bsi48aD450q0EGVv3lZHWKpgkqsPMzVe6yHZTFf
	ROyoKvMV7SUam64qd37FQ+4R4dGbpKXtlduhee47ESEZ4ykTKe+Q8td6AR4tomix
	XY/9FeBd6EP4Ol7Au6F5+8HmqnA/NygmO6l5LfNlMzT1z0hdfbP3fQVhoB1BiYdy
	dVqSoy4brrmhk2HEHnmyoULprnBA0/1aOzBSaMw8ZwjNLrSrjtVii7OtW1TirPQP
	YeZcruOE1seyE8KylK5yV/5H1Y2ZubDsde9or25GGqDhiu7+iW6291DKPP9Uk2US
	QYUKP+7ZfTTYQgCsuoQpJQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbvpqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 15:37:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEVXvg036004;
	Tue, 12 Nov 2024 15:37:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx681tbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 15:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kewmpRFJnnjsU62Fzk4kJYD+eqKfxsq8EN2VPpCzsfhkFzjlnW5yqaxacy3ktL6nKQWl3WV8DeoyoK+tnGM/n3Vrk/icAaVg9kVM8bXJdvdB8woYrzSCnhn/JX3dQmFoZ/qxPolEoGBsGUUxSRM+m+jh47m6vuM7j/PBPFebJIRZoPnMSSFIZU+gqu+oaIz0ByBkZEnZpaZDou1bNDYeormGGSnEyaPGvDvVCmnXf82NvdOwp+kYpuz9B5FcnS8x9D3sMDLgsv8DNZzIk65E3vs7diz/YHwKvje1EXt2GW7o8CzPmwGvBcSc+yVP7iQ8calcLj+4uhYmqdjOfWKAkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPQ849vxdg0tMaUXMm/X0hjIHk98A3vrACmb1/ckn0I=;
 b=j3GQfc5BAOUylvxm9oUAhZlpjcVnCJJag5EgS01ySmkryhiSuxKHwzR5bPinnCpdJQUlGBVSEkPNfjJ2zPCggVGYL6xMGvvuE8XZDd+jX3LsKfnNL2HIv5117QsegMenfGLsUiHPt8ZgDxCUeN/qREDV1ALLyTrbvYf+6CvL228Y4Eq/+/A24XRC79mJlovtd/EmpBcXdJ71Zfj3r5srxYpXx+V0HlSSf6A9vawc7eup5vcJKJFyN5X8adI9VQb6cOVginmPyM5D0AL4LWN7R9YbsaFoIU35ajQp/KdUA+0UGMtkkfR0wFcNnztcOWutFti9UL9bYKXyG542+96y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPQ849vxdg0tMaUXMm/X0hjIHk98A3vrACmb1/ckn0I=;
 b=IBxexDRRKgEGik1s2K0sOmwAUJvXcVepMmHXvBrvqoacfei/8gkyaY2aSjFaMgJ87n/JSCTYBE2S3ZXMw8/AjRdR8knHggZ0pg9w+lX/1ph/4rvawVBLG4m/eMkQS8DEtzdPVV4XkZGgnkrJExBE7gmxL1cCMpYI7AloBWq8vrs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA6PR10MB8160.namprd10.prod.outlook.com (2603:10b6:806:43f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 15:37:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:37:29 +0000
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
Thread-Index:
 AQHbM9Qf5MGHjWzrD0e387x3Myz9zbKxXU4AgADJ6QCAAAuNgIAAA+kAgADL1YCAAMdYAA==
Date: Tue, 12 Nov 2024 15:37:29 +0000
Message-ID: <C4E2D262-4864-45FD-A985-9C9F64EF83B5@oracle.com>
References: <20241111005242.34654-1-cel@kernel.org>
 <20241111005242.34654-7-cel@kernel.org>
 <278433c2-611c-6c8e-7964-5c11977b68b7@huaweicloud.com>
 <96A93064-8DCE-4B78-9F2A-CF6E7EEABEB1@oracle.com>
 <73a05cb9-569c-9b3c-3359-824e76b14461@huaweicloud.com>
 <09F40EA2-9537-4C7A-A221-AA403ED3FF64@oracle.com>
 <dd6bd7f5-cf2e-3123-3017-c209d81ab290@huaweicloud.com>
In-Reply-To: <dd6bd7f5-cf2e-3123-3017-c209d81ab290@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA6PR10MB8160:EE_
x-ms-office365-filtering-correlation-id: a2fd88c3-5b9e-44eb-cebf-08dd032feabb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RnZ5VHRWN0dWc0JDTmljQWZRLzV5ejNORjRVbG5XdnlwYWc3M2w3RFZaaU1N?=
 =?utf-8?B?c3pEUW1vbW9WZDh0WkJLYXhBNU9WT0ZOM0dBc3NVZy9naXRuMlE1WWFoSDFI?=
 =?utf-8?B?Q3dqRkcrUXJYTSsxNlNma0xjcG9yUkJmRXBnN0lOTzBHdFNnSTdqeXhBTzhS?=
 =?utf-8?B?UVBTa1ZoOUIyOTl1SmVDTENYT1RLWEwvR3RTb3V3b0szamgyNEgwN2lEeFFL?=
 =?utf-8?B?U3J3eEM2ZlZud0NUcXB4d3FFR1h0dmxrM1l4VDhEVnhhZlZ1dllLUzdtRW9v?=
 =?utf-8?B?TVluRjFqNVprK0JHa255dWhtTUpMWVp2cXBFL2E1VXBuUjkxNmE0OTJ6U1hC?=
 =?utf-8?B?NmlNbkcrUFdNQXhjOFQ1eUszTTBjM0lIaHV6eG44ZmorVFdqYXFDUWUrTERP?=
 =?utf-8?B?aHI1dlBhSHRLc0pXdTBoUjNIYjMrSmRsZ0w4TmxWZFJOd24wbHZTeGtlVXFL?=
 =?utf-8?B?NlluU0RVRFo2cU5jZ1pRSk4rVXp1VDBFdW83L2YvMHRxc3UwSVRKWHgxcWls?=
 =?utf-8?B?aXNvYWRCMjZSK1F0T1U1dGdTaXVMUVNSem1rejQ3bDRBRjlNMXBXanJpZXJC?=
 =?utf-8?B?NmJPSkpXeWpzd2o2QXo1NG9QZ1pJTVJxZlVVOVB4eHhWM3VLMWRpTnBTczRB?=
 =?utf-8?B?UU9YVHQyOUF2SVN0RnJCbjk5ejJHWVJhZEc4YTE5aHpXR3Y3WHpTMjVTUnRt?=
 =?utf-8?B?NytQcjlXTldTbVE2bVZBTEcrM1AvZU9LTVY1Y3NvT0pUU1JTeUp6aHlMY1R0?=
 =?utf-8?B?VzNIcmxWSGhoMDdETHBPQ3FlY256dlZDYTYrMUtDU0lhNFFxQ3VBVVF1eldZ?=
 =?utf-8?B?T3V1T0ExWE5tYW16Z0JFcStOZWhFVGpabGg1ZGFJQWQ5TzI2RFk2dVVEYXFp?=
 =?utf-8?B?V2JSeGRqYWt0NGw5TUx3S0JFRDdsN2NlSVBaNjZpbG1hb2lhSHZtL29WanFK?=
 =?utf-8?B?Uy9CVGRyNkpBVGlpM1dqZUhPcEhNakdyZXlsekxKcXR0eWxmV0hOT3FrUUVt?=
 =?utf-8?B?K1hyY3BpcG9mb0p4ZlR1OUwvM0Y4YitPTjV3bXgrOTJ1UnUxNVJmSXpaWDVk?=
 =?utf-8?B?UDlhVlJVMTJkUEQxN0wvZ09mWlp0cGF5SndZQWJUOVRFZUJSMTQ3N3ZFSVpB?=
 =?utf-8?B?QlRjOE9BOUhoVEo1Z0pYZDRvTFRVM3kxT2t0RFFnQ2xHMW5MVWtRd0tQMmZq?=
 =?utf-8?B?akpCblVCQ2NLcEFQS3FYWWFSN2ZiL3hiNDcxMVFSV1pvM0lXRktGa3ZyeHJM?=
 =?utf-8?B?cWlLRENpYW10OW9ibEVIMFlJejhxVE1KYzFOYTcrVzR0TUVZYndxaUxWMmRX?=
 =?utf-8?B?VlcwTTVzTmxnR3Q3Rk1sMVFHUlNoeXVyQ2hMdEluenJtUnRXdC8xTUZkb3Ro?=
 =?utf-8?B?cXhNUmsyRlRkS2NZYUJyeVlQY1JiZGUxSjRRQnc5UXo3Sk5hdEhyc0hrZ0dn?=
 =?utf-8?B?anpjQnk5aGpwYWppZG5sK0Z5NnB3cEdpMEpVNnU2ZlAyeURxdmFzYUxJaVEy?=
 =?utf-8?B?d2U5eU5zblgvZmpKME1admNObzN3dnRkWTcwT0dRRjVvcDhPa2kxaHhRYU1t?=
 =?utf-8?B?UXlESE5LcmR3V1BSZG9ZdmMvUHdNbzhQWEZNVmtsZDlnTXhGbTZwQ3MvQnZQ?=
 =?utf-8?B?NkIvc3RRTE5RY3hTZWdZYmZyVFIrZTRQbXNPdlcvMzJESHE3cWs3RERsNUI4?=
 =?utf-8?B?NXVkanhXWks2MS9PVlZreW4xWTdMQlZLTSs5TWwzd0VkRWtVbGlJNFFzZnpN?=
 =?utf-8?B?ZnBQYVNEVWpmN2lzYjVWNkFCUkJFNmdSNHVKWWpTZDVxTjAwU3Z6V0hnV2x5?=
 =?utf-8?B?ZWVmcnNFSThmWkF4RU5HMlJWVTA2WGFEN3R2aW1jZGNmVFZTMUp6VDM3R25v?=
 =?utf-8?Q?X1fG2+cjdQnu/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUVid3hmVmFnMEdQY3gyZUkxSDBwWkpnbWtmVGFVNVJrVnFDejYrU1FCSzgz?=
 =?utf-8?B?RnpnQ2o2LzZWNDZGQjJVMFF3cVdCL0s4c0x5a1JBK0FkRXFqQ2lPNlp1Sml1?=
 =?utf-8?B?bVRTd3NLSXo2MjZtWnhiTCtvaU9nMFVWNy9RWEdkVENBWHBpSFh0VTYxN2hJ?=
 =?utf-8?B?Nzk5anUzVmNDQ0pTakdMY2pYY0RYN0FNQks1S0wvS2FBbHhJWnlsSGQwLzJq?=
 =?utf-8?B?ZEJCSzlyZFpXNlNuOHhtM2dGMzN5bE1tQ3ZEZnQwblZrMVRHYlZWbUFvWVNk?=
 =?utf-8?B?bVlXSUpyRWRpczF5S1FGNWF6QkR1cWFzVmM1S1FIMXpLR09Cdjk1aFZnZ0ll?=
 =?utf-8?B?ZERJUWJvdWpJVGRJMm12UDJGYUNGaDl1TitkWVZDa2N2Qk5wNmdsbzlhOU1S?=
 =?utf-8?B?c0Z0OEFNTFg1ZW54T3VVOElhRWlpSWlvajdPa3RISml1VkJUQlQxNTdDajhu?=
 =?utf-8?B?ZkdxdE5FTlRVMHZQeThRaC9uVk44Y1haNmgxK1krR2dtckk5MVFJVHQxMXp0?=
 =?utf-8?B?R2JiZWlXYWYzTEkxajlPaGZMNnpKSXI4UmJHbzhCTkhsZjg2cytiWEFzWFVy?=
 =?utf-8?B?VGpHS1I5OXo2a1dLZ0d2U3h1OVZGRUxtRmRDcDA4MmJjL0lvZjdEemtwNzNI?=
 =?utf-8?B?WFBIL0UrL2ZZUjZRVzRjVmU0ZG42eEpoaXprZEFOcTc2MFFCYlhUOXZqeE91?=
 =?utf-8?B?S2F0Y05vUW1tRFZsYkVnZ2wrUyt4ZHUycytoY25aem5mZDhMUzVDeitKVzJW?=
 =?utf-8?B?VFkxNnh2cWhiUTRxeHNuZzVuTWRHcDcwZndCRml5djk3S0pteEQwajJyYUcz?=
 =?utf-8?B?ZmNWN3VFWG9qRkJybnVIaDBMdXFvVTB6cGxpYUc1OERFZ0pxdnl0Y05FTW9u?=
 =?utf-8?B?TEpCNGl4M3NCRyt4eGJnN1U0Q1pvVEdzbnFYOU5rSnhNc1RTc1B1K0JlS3k5?=
 =?utf-8?B?UmNpWmxKZFhld2lJRlc4TzcwUGZpczR0ZTVDeFBzYmRzb2RlaWFiM21pamhH?=
 =?utf-8?B?UHd4VHFvUWphb0FCS0tGSXdCSkluZE5Nd0V5UU9uTGk5VFMxQUh6b0pNRzhB?=
 =?utf-8?B?clBOZVBkYlZsOGpsZWY1aWkwanNoWGw2bTdhSFk2R21yZ3J6QzVjREpNbDk5?=
 =?utf-8?B?UjVkTFYrcnYvQmxaeXZoSW1CUEo2QWNTeWRJZkVmK2pxOHZZRTNkNmhZMEIr?=
 =?utf-8?B?L3piMjVkbFhJUFdsYmEwQXo0NGFsbnlIZmVYOWhPVEtDaXhTVFhod2RRRjh1?=
 =?utf-8?B?eCtjUzIvVi9vdEwwVVlqdG84L0J0OGJqOHZIV1JWWEZnaFJJQnJGck92OHQ0?=
 =?utf-8?B?R2JGUExwTFZZQzNxN1VjM3R4NFJDZUVVSFQ3L05EV3Y1cGZpZUFnNlc3VUxv?=
 =?utf-8?B?UDVHcVBsM3NYNk1jYktEOXB6SGxwV1Bnbk54NE9sbi9ZTE9QQ0pNK0dlWnhk?=
 =?utf-8?B?R2tYK3RrclNEdjdpWmhrYkliRC9BQVhFYzU1cWZYUmlvejFrSnhwaDdLc2Jo?=
 =?utf-8?B?KzlkbTdkOXNveTgrZmNYLzJ0MGhyeWx5dEtaclVIckd1Y1BwZnlhS1o0RzV2?=
 =?utf-8?B?ckRUSmRSdnRWMCs2ZVFRMWF0VEVWNkF5YWpiSDJhTDh3TDJyVEJEcEtoZWNP?=
 =?utf-8?B?UEJ2bnd6Q3JMYVJqanBhTExOcEFuQ2hsVEcwSTJsOEZ2OHdIMDFVWm9aTnY3?=
 =?utf-8?B?SDBxK25KTGIwckJ1bUVRb1pwMXRJbnlaRzh6WldMSzZqSmdyNG1UUVBnVGRR?=
 =?utf-8?B?aUtMWnNBa2NYM1NmRWYveXpmcHJrS0hqTjg1VEY0ZVJrYkZEZ1lEVDFyTFl3?=
 =?utf-8?B?dFB6RHp5Q054STV4NDY4Z2QySEt0NzJPMEdkclVXNmJIOHNaRGZ3SzdJWFFE?=
 =?utf-8?B?eGgycHE5S3ZGcTNyVitIR0pUUDdvSnpMSFZvV0xnMkFqdGdCSU02eXU0cnY2?=
 =?utf-8?B?Ymxad0lya3hjQjNSQzZXYVM4QmlkV2ZDeXZ4OE1TSGVBdHhIaDIrbUp5eXZX?=
 =?utf-8?B?aG9UcVJKSFl1cjZTVFZLQW1sdWZTQTd0cUtucGZQbjY0eVl0bHlvZmxGU1JR?=
 =?utf-8?B?dWRUOXlBdnZxV2RlbnNtaGlETXlEVW1SKzNRU1NzOWtmdzZYUnRGZ1V0U0pS?=
 =?utf-8?B?ZDh1UTR1dS81Mm42VkI1MWttL2tYYzZWRE1GL2hJdks5RHd6Q29lR3hKMGE3?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F19CD34336413408DD49B36EA7174FC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HFsd406hxmxwWaL4rECTSSZd7yjvq2a2zBYaShp0iQjsohoVEGeRVFQg3PXg+G+C/w2twQx/psnxfPuPBjY50xKoAqaGlmKE5vRxWHv7rpmU+5BVlhMwetd6R95+ocKF2A7J7PUR9HdQI30tnXE3yn9bFCrGKWxTXe4U3aFTkyZ2nEwzt+jr1wg9Qc8vgDj7I4dG9A8jIhXEOcssf5I1XGb1tkoXJkEVO0cmtbttIJ0K3jGlj/wQcFiIEaXUGHYzHYhDBRpxEZ14cpxl3odhnvizI7feNDTyJCMBUwfG5PeLGirum/KvDOad2iHoasMyqFHiFixhrwy+CoVsFG7MXM6/sNeU4JoJnMO9NcsomcFVOGGakc+oDB3z+na6+5soJqTjC1N4czVuj/9S9HmAmGGfOCsms9sVe6TEQpQjCxtRhcxMZBbht2E4ib+NZurp3O9ysA0ObUIqMim3ontoFiRBltg+Ayu5CCgu03FpyDMpghvUrIpJ0/oATuUGL/fdQouDBMNPVOGbxCdTBA03T/JzM5QS9IMwcQHjSTbA9rCHl8lKKT21wJXmner5QL9168UoisXnxCG5OQEkBR/I/cT4kDIayO0evJo+PTA1b6w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fd88c3-5b9e-44eb-cebf-08dd032feabb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 15:37:29.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H04D900JfgJDeannQrnXPoQkxH+8hMGiB/6XZbmw2X6cZlFxkkcSM000V5V7aHJyzyozKiU7MIrULKBVk6UXHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_05,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411120124
X-Proofpoint-GUID: lFTcqopYsXGg58vN5Zlfl7GI0Dw4dn2a
X-Proofpoint-ORIG-GUID: lFTcqopYsXGg58vN5Zlfl7GI0Dw4dn2a

DQoNCj4gT24gTm92IDExLCAyMDI0LCBhdCAxMDo0M+KAr1BNLCB5YW5nZXJrdW4gPHlhbmdlcmt1
bkBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiDlnKggMjAyNC8xMS8xMSAy
MzozNCwgQ2h1Y2sgTGV2ZXIgSUlJIOWGmemBkzoNCj4+PiBPbiBOb3YgMTEsIDIwMjQsIGF0IDEw
OjIw4oCvQU0sIHlhbmdlcmt1biA8eWFuZ2Vya3VuQGh1YXdlaWNsb3VkLmNvbT4gd3JvdGU6DQo+
Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4g5ZyoIDIwMjQvMTEvMTEgMjI6MzksIENodWNrIExldmVyIElJ
SSDlhpnpgZM6DQo+Pj4+PiBPbiBOb3YgMTAsIDIwMjQsIGF0IDk6MzbigK9QTSwgWXUgS3VhaSA8
eXVrdWFpMUBodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+PiBIaSwNCj4+Pj4+
IA0KPj4+Pj4g5ZyoIDIwMjQvMTEvMTEgODo1MiwgY2VsQGtlcm5lbC5vcmcg5YaZ6YGTOg0KPj4+
Pj4+IEZyb206IHlhbmdlcmt1biA8eWFuZ2Vya3VuQGh1YXdlaS5jb20+DQo+Pj4+Pj4gWyBVcHN0
cmVhbSBjb21taXQgNjRhN2NlNzZmYjkwMWJmOWY5YzM2Y2Y1ZDY4MTMyOGZjMGZkNGI1YSBdDQo+
Pj4+Pj4gQWZ0ZXIgd2Ugc3dpdGNoIHRtcGZzIGRpciBvcGVyYXRpb25zIGZyb20gc2ltcGxlX2Rp
cl9vcGVyYXRpb25zIHRvDQo+Pj4+Pj4gc2ltcGxlX29mZnNldF9kaXJfb3BlcmF0aW9ucywgZXZl
cnkgcmVuYW1lIGhhcHBlbmVkIHdpbGwgZmlsbCBuZXcgZGVudHJ5DQo+Pj4+Pj4gdG8gZGVzdCBk
aXIncyBtYXBsZSB0cmVlKCZTSE1FTV9JKGlub2RlKS0+ZGlyX29mZnNldHMtPm10KSB3aXRoIGEg
ZnJlZQ0KPj4+Pj4+IGtleSBzdGFydGluZyB3aXRoIG9jdHgtPm5ld3hfb2Zmc2V0LCBhbmQgdGhl
biBzZXQgbmV3eF9vZmZzZXQgZXF1YWxzIHRvDQo+Pj4+Pj4gZnJlZSBrZXkgKyAxLiBUaGlzIHdp
bGwgbGVhZCB0byBpbmZpbml0ZSByZWFkZGlyIGNvbWJpbmUgd2l0aCByZW5hbWUNCj4+Pj4+PiBo
YXBwZW5lZCBhdCB0aGUgc2FtZSB0aW1lLCB3aGljaCBmYWlsIGdlbmVyaWMvNzM2IGluIHhmc3Rl
c3RzKGRldGFpbCBzaG93DQo+Pj4+Pj4gYXMgYmVsb3cpLg0KPj4+Pj4+IDEuIGNyZWF0ZSA1MDAw
IGZpbGVzKDEgMiAzLi4uKSB1bmRlciBvbmUgZGlyDQo+Pj4+Pj4gMi4gY2FsbCByZWFkZGlyKG1h
biAzIHJlYWRkaXIpIG9uY2UsIGFuZCBnZXQgb25lIGVudHJ5DQo+Pj4+Pj4gMy4gcmVuYW1lKGVu
dHJ5LCAiVEVNUEZJTEUiKSwgdGhlbiByZW5hbWUoIlRFTVBGSUxFIiwgZW50cnkpDQo+Pj4+Pj4g
NC4gbG9vcCAyfjMsIHVudGlsIHJlYWRkaXIgcmV0dXJuIG5vdGhpbmcgb3Igd2UgbG9vcCB0b28g
bWFueQ0KPj4+Pj4+ICAgIHRpbWVzKHRtcGZzIGJyZWFrIHRlc3Qgd2l0aCB0aGUgc2Vjb25kIGNv
bmRpdGlvbikNCj4+Pj4+PiBXZSBjaG9vc2UgdGhlIHNhbWUgbG9naWMgd2hhdCBjb21taXQgOWIz
NzhmNmFkNDhjZiAoImJ0cmZzOiBmaXggaW5maW5pdGUNCj4+Pj4+PiBkaXJlY3RvcnkgcmVhZHMi
KSB0byBmaXggaXQsIHJlY29yZCB0aGUgbGFzdF9pbmRleCB3aGVuIHdlIG9wZW4gZGlyLCBhbmQN
Cj4+Pj4+PiBkbyBub3QgZW1pdCB0aGUgZW50cnkgd2hpY2ggaW5kZXggPj0gbGFzdF9pbmRleC4g
VGhlIGZpbGUtPnByaXZhdGVfZGF0YQ0KPj4+Pj4gDQo+Pj4+PiBQbGVhc2Ugbm90aWNlIHRoaXMg
cmVxdWlyZXMgbGFzdF9pbmRleCBzaG91bGQgbmV2ZXIgb3ZlcmZsb3csIG90aGVyd2lzZQ0KPj4+
Pj4gcmVhZGRpciB3aWxsIGJlIG1lc3NlZCB1cC4NCj4+Pj4gSXQgd291bGQgaGVscCB5b3VyIGNh
dXNlIGlmIHlvdSBjb3VsZCBiZSBtb3JlIHNwZWNpZmljDQo+Pj4+IHRoYW4gIm1lc3NlZCB1cCIu
DQo+Pj4+Pj4gbm93IHVzZWQgaW4gb2Zmc2V0IGRpciBjYW4gdXNlIGRpcmVjdGx5IHRvIGRvIHRo
aXMsIGFuZCB3ZSBhbHNvIHVwZGF0ZQ0KPj4+Pj4+IHRoZSBsYXN0X2luZGV4IHdoZW4gd2UgbGxz
ZWVrIHRoZSBkaXIgZmlsZS4NCj4+Pj4+PiBGaXhlczogYTJlNDU5NTU1YzVmICgic2htZW06IHN0
YWJsZSBkaXJlY3Rvcnkgb2Zmc2V0cyIpDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogeWFuZ2Vya3Vu
IDx5YW5nZXJrdW5AaHVhd2VpLmNvbT4NCj4+Pj4+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjQwNzMxMDQzODM1LjE4Mjg2OTctMS15YW5nZXJrdW5AaHVhd2VpLmNvbQ0KPj4+
Pj4+IFJldmlld2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+
Pj4+PiBbYnJhdW5lcjogb25seSB1cGRhdGUgbGFzdF9pbmRleCBhZnRlciBzZWVrIHdoZW4gb2Zm
c2V0IGlzIHplcm8gbGlrZSBKYW4gc3VnZ2VzdGVkXQ0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+DQo+Pj4+Pj4gTGluazogaHR0cHM6
Ly9udmQubmlzdC5nb3YvdnVsbi9kZXRhaWwvQ1ZFLTIwMjQtNDY3MDENCj4+Pj4+PiBbIGNlbDog
YWRqdXN0ZWQgdG8gYXBwbHkgdG8gb3JpZ2luL2xpbnV4LTYuNi55IF0NCj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+Pj4+PiAtLS0N
Cj4+Pj4+PiAgZnMvbGliZnMuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0NCj4+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEyIGRlbGV0
aW9ucygtKQ0KPj4+Pj4+IGRpZmYgLS1naXQgYS9mcy9saWJmcy5jIGIvZnMvbGliZnMuYw0KPj4+
Pj4+IGluZGV4IGE4NzAwNWM4OTUzNC4uYjU5ZmYwZGZlYTFmIDEwMDY0NA0KPj4+Pj4+IC0tLSBh
L2ZzL2xpYmZzLmMNCj4+Pj4+PiArKysgYi9mcy9saWJmcy5jDQo+Pj4+Pj4gQEAgLTQ0OSw2ICs0
NDksMTQgQEAgdm9pZCBzaW1wbGVfb2Zmc2V0X2Rlc3Ryb3koc3RydWN0IG9mZnNldF9jdHggKm9j
dHgpDQo+Pj4+Pj4gICB4YV9kZXN0cm95KCZvY3R4LT54YSk7DQo+Pj4+Pj4gIH0NCj4+Pj4+PiAg
K3N0YXRpYyBpbnQgb2Zmc2V0X2Rpcl9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBm
aWxlICpmaWxlKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gKyBzdHJ1Y3Qgb2Zmc2V0X2N0eCAqY3R4ID0g
aW5vZGUtPmlfb3AtPmdldF9vZmZzZXRfY3R4KGlub2RlKTsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyBm
aWxlLT5wcml2YXRlX2RhdGEgPSAodm9pZCAqKWN0eC0+bmV4dF9vZmZzZXQ7DQo+Pj4+Pj4gKyBy
ZXR1cm4gMDsNCj4+Pj4+PiArfQ0KPj4+Pj4gDQo+Pj4+PiBMb29rcyBsaWtlIHhhcnJheSBpcyBz
dGlsbCB1c2VkLg0KPj4+PiBUaGF0J3Mgbm90IGdvaW5nIHRvIGNoYW5nZSwgYXMgc2V2ZXJhbCBm
b2xrcyBoYXZlIGFscmVhZHkNCj4+Pj4gZXhwbGFpbmVkLg0KPj4+Pj4gSSdtIGluIHRoZSBjYyBs
aXN0ICxzbyBJIGFzc3VtZSB5b3Ugc2F3IG15IHNldCwgdGhlbiBJIGRvbid0IGtub3cgd2h5DQo+
Pj4+PiB5b3UncmUgaWdub3JpbmcgbXkgY29uY2VybnMuDQo+Pj4+PiAxKSBuZXh0X29mZnNldCBp
cyAzMi1iaXQgYW5kIGNhbiBvdmVyZmxvdyBpbiBhIGxvbmctdGltZSBydW5uaW5nDQo+Pj4+PiBt
YWNoaW5lLg0KPj4+Pj4gMikgT25jZSBuZXh0X29mZnNldCBvdmVyZmxvd3MsIHJlYWRkaXIgd2ls
bCBza2lwIHRoZSBmaWxlcyB0aGF0IG9mZnNldA0KPj4+Pj4gaXMgYmlnZ2VyLg0KPj4+IA0KPj4+
IEknbSBzb3JyeSwgSSdtIGEgbGl0dGxlIGJ1c3kgdGhlc2UgZGF5cywgc28gSSBoYXZlbid0IHJl
c3BvbmRlZCB0byB0aGlzDQo+Pj4gc2VyaWVzIG9mIGVtYWlscy4NCj4+PiANCj4+Pj4gSW4gdGhh
dCBjYXNlLCB0aGF0IGVudHJ5IHdvbid0IGJlIHZpc2libGUgdmlhIGdldGRlbnRzKDMpDQo+Pj4+
IHVudGlsIHRoZSBkaXJlY3RvcnkgaXMgcmUtb3BlbmVkIG9yIHRoZSBwcm9jZXNzIGRvZXMgYW4N
Cj4+Pj4gbHNlZWsoZmQsIDAsIFNFRUtfU0VUKS4NCj4+PiANCj4+PiBZZXMuDQo+Pj4gDQo+Pj4+
IFRoYXQgaXMgdGhlIHByb3BlciBhbmQgZXhwZWN0ZWQgYmVoYXZpb3IuIEkgc3VzcGVjdCB5b3UN
Cj4+Pj4gd2lsbCBzZWUgZXhhY3RseSB0aGF0IGJlaGF2aW9yIHdpdGggZXh0NCBhbmQgMzItYml0
DQo+Pj4+IGRpcmVjdG9yeSBvZmZzZXRzLCBmb3IgZXhhbXBsZS4NCj4+PiANCj4+PiBFbW0uLi4N
Cj4+PiANCj4+PiBGb3IgdGhpcyBjYXNlIGxpa2UgdGhpczoNCj4+PiANCj4+PiAxLiBta2RpciAv
dG1wL2RpciBhbmQgdG91Y2ggL3RtcC9kaXIvZmlsZTEgL3RtcC9kaXIvZmlsZTINCj4+PiAyLiBv
cGVuIC90bXAvZGlyIHdpdGggZmQxDQo+Pj4gMy4gcmVhZGRpciBhbmQgZ2V0IC90bXAvZGlyL2Zp
bGUxDQo+Pj4gNC4gcm0gL3RtcC9kaXIvZmlsZTINCj4+PiA1LiB0b3VjaCAvdG1wL2Rpci9maWxl
Mg0KPj4+IDQuIGxvb3AgNH41IGZvciAyXjMyIHRpbWVzDQo+Pj4gNS4gcmVhZGRpciAvdG1wL2Rp
ciB3aXRoIGZkMQ0KPj4+IA0KPj4+IEZvciB0bXBmcyBub3csIHdlIG1heSBzZWUgbm8gL3RtcC9k
aXIvZmlsZTIsIHNpbmNlIHRoZSBvZmZzZXQgaGFzIGJlZW4gb3ZlcmZsb3csIGZvciBleHQ0IGl0
IGlzIG9rLi4uIFNvIHdlIHRoaW5rIHRoaXMgd2lsbCBiZSBhIHByb2JsZW0uDQo+Pj4gDQo+Pj4+
IERvZXMgdGhhdCBub3QgZGlyZWN0bHkgYWRkcmVzcyB5b3VyIGNvbmNlcm4/IE9yIGRvIHlvdQ0K
Pj4+PiBtZWFuIHRoYXQgRXJrdW4ncyBwYXRjaCBpbnRyb2R1Y2VzIGEgbmV3IGlzc3VlPw0KPj4+
IA0KPj4+IFllcywgdG8gYmUgaG9uZXN0LCBteSBwZXJzb25hbCBmZWVsaW5nIGlzIGEgcHJvYmxl
bS4gQnV0IGZvciA2NGJpdCwgaXQgbWF5IG5ldmVyIGJlZW4gdHJpZ2dlci4NCj4+IFRoYW5rcyBm
b3IgY29uZmlybWluZy4NCj4+IEluIHRoYXQgY2FzZSwgdGhlIHByZWZlcnJlZCB3YXkgdG8gaGFu
ZGxlIGl0IGlzIHRvIGZpeA0KPj4gdGhlIGlzc3VlIGluIHVwc3RyZWFtLCBhbmQgdGhlbiBiYWNr
cG9ydCB0aGF0IGZpeCB0byBMVFMuDQo+PiBEZXBlbmRlbmNlIG9uIDY0LWJpdCBvZmZzZXRzIHRv
IGF2b2lkIGEgZmFpbHVyZSBjYXNlDQo+PiBzaG91bGQgYmUgY29uc2lkZXJlZCBhIHdvcmthcm91
bmQsIG5vdCBhIHJlYWwgZml4LCBJTUhPLg0KPiANCj4gWWVzLg0KPiANCj4+IERvIHlvdSBoYXZl
IGEgZmV3IG1vbWVudHMgdG8gYWRkcmVzcyBpdCwgb3IgaWYgbm90IEkNCj4+IHdpbGwgc2VlIHRv
IGl0Lg0KPiANCj4gWW91IGNhbiB0cnkgdG8gZG8gdGhpcywgZm9yIHRoZSByZWFzb24gSSBhbSBx
dWl0ZSBidXN5IG5vdyB1bnRpbCBlbmQgb2YgdGhpcyBtb250aC4uLiBTb3JyeS4NCg0KTm8gd29y
cmllcyENCg0KDQo+PiBJIHRoaW5rIHJlZHVjaW5nIHRoZSB4YV9saW1pdCBpbiBzaW1wbGVfb2Zm
c2V0X2FkZCgpIHRvLA0KPj4gc2F5LCAyLi4xNiB3b3VsZCBtYWtlIHRoZSByZXByb2R1Y2VyIGZp
cmUgYWxtb3N0DQo+PiBpbW1lZGlhdGVseS4NCj4gDQo+IFllcy4NCj4gDQo+Pj4+IElmIHRoZXJl
IGlzIGEgcHJvYmxlbSBoZXJlLCBwbGVhc2UgY29uc3RydWN0IGEgcmVwcm9kdWNlcg0KPj4+PiBh
Z2FpbnN0IHRoaXMgcGF0Y2ggc2V0IGFuZCBwb3N0IGl0Lg0KPj4+Pj4gVGhhbmtzLA0KPj4+Pj4g
S3VhaQ0KPj4+Pj4gDQo+Pj4+Pj4gKw0KPj4+Pj4+ICAvKioNCj4+Pj4+PiAgICogb2Zmc2V0X2Rp
cl9sbHNlZWsgLSBBZHZhbmNlIHRoZSByZWFkIHBvc2l0aW9uIG9mIGEgZGlyZWN0b3J5IGRlc2Ny
aXB0b3INCj4+Pj4+PiAgICogQGZpbGU6IGFuIG9wZW4gZGlyZWN0b3J5IHdob3NlIHBvc2l0aW9u
IGlzIHRvIGJlIHVwZGF0ZWQNCj4+Pj4+PiBAQCAtNDYyLDYgKzQ3MCw5IEBAIHZvaWQgc2ltcGxl
X29mZnNldF9kZXN0cm95KHN0cnVjdCBvZmZzZXRfY3R4ICpvY3R4KQ0KPj4+Pj4+ICAgKi8NCj4+
Pj4+PiAgc3RhdGljIGxvZmZfdCBvZmZzZXRfZGlyX2xsc2VlayhzdHJ1Y3QgZmlsZSAqZmlsZSwg
bG9mZl90IG9mZnNldCwgaW50IHdoZW5jZSkNCj4+Pj4+PiAgew0KPj4+Pj4+ICsgc3RydWN0IGlu
b2RlICppbm9kZSA9IGZpbGUtPmZfaW5vZGU7DQo+Pj4+Pj4gKyBzdHJ1Y3Qgb2Zmc2V0X2N0eCAq
Y3R4ID0gaW5vZGUtPmlfb3AtPmdldF9vZmZzZXRfY3R4KGlub2RlKTsNCj4+Pj4+PiArDQo+Pj4+
Pj4gICBzd2l0Y2ggKHdoZW5jZSkgew0KPj4+Pj4+ICAgY2FzZSBTRUVLX0NVUjoNCj4+Pj4+PiAg
IG9mZnNldCArPSBmaWxlLT5mX3BvczsNCj4+Pj4+PiBAQCAtNDc1LDggKzQ4Niw5IEBAIHN0YXRp
YyBsb2ZmX3Qgb2Zmc2V0X2Rpcl9sbHNlZWsoc3RydWN0IGZpbGUgKmZpbGUsIGxvZmZfdCBvZmZz
ZXQsIGludCB3aGVuY2UpDQo+Pj4+Pj4gICB9DQo+Pj4+Pj4gICAgIC8qIEluIHRoaXMgY2FzZSwg
LT5wcml2YXRlX2RhdGEgaXMgcHJvdGVjdGVkIGJ5IGZfcG9zX2xvY2sgKi8NCj4+Pj4+PiAtIGZp
bGUtPnByaXZhdGVfZGF0YSA9IE5VTEw7DQo+Pj4+Pj4gLSByZXR1cm4gdmZzX3NldHBvcyhmaWxl
LCBvZmZzZXQsIFUzMl9NQVgpOw0KPj4+Pj4+ICsgaWYgKCFvZmZzZXQpDQo+Pj4+Pj4gKyBmaWxl
LT5wcml2YXRlX2RhdGEgPSAodm9pZCAqKWN0eC0+bmV4dF9vZmZzZXQ7DQo+Pj4+Pj4gKyByZXR1
cm4gdmZzX3NldHBvcyhmaWxlLCBvZmZzZXQsIExPTkdfTUFYKTsNCj4+Pj4+PiAgfQ0KPj4+Pj4+
ICAgIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpvZmZzZXRfZmluZF9uZXh0KHN0cnVjdCB4YV9zdGF0
ZSAqeGFzKQ0KPj4+Pj4+IEBAIC01MDUsNyArNTE3LDcgQEAgc3RhdGljIGJvb2wgb2Zmc2V0X2Rp
cl9lbWl0KHN0cnVjdCBkaXJfY29udGV4dCAqY3R4LCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+
Pj4+Pj4gICAgIGlub2RlLT5pX2lubywgZnNfdW1vZGVfdG9fZHR5cGUoaW5vZGUtPmlfbW9kZSkp
Ow0KPj4+Pj4+ICB9DQo+Pj4+Pj4gIC1zdGF0aWMgdm9pZCAqb2Zmc2V0X2l0ZXJhdGVfZGlyKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQ0KPj4+Pj4+ICtzdGF0
aWMgdm9pZCBvZmZzZXRfaXRlcmF0ZV9kaXIoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRp
cl9jb250ZXh0ICpjdHgsIGxvbmcgbGFzdF9pbmRleCkNCj4+Pj4+PiAgew0KPj4+Pj4+ICAgc3Ry
dWN0IG9mZnNldF9jdHggKnNvX2N0eCA9IGlub2RlLT5pX29wLT5nZXRfb2Zmc2V0X2N0eChpbm9k
ZSk7DQo+Pj4+Pj4gICBYQV9TVEFURSh4YXMsICZzb19jdHgtPnhhLCBjdHgtPnBvcyk7DQo+Pj4+
Pj4gQEAgLTUxNCwxNyArNTI2LDIxIEBAIHN0YXRpYyB2b2lkICpvZmZzZXRfaXRlcmF0ZV9kaXIo
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpDQo+Pj4+Pj4gICB3
aGlsZSAodHJ1ZSkgew0KPj4+Pj4+ICAgZGVudHJ5ID0gb2Zmc2V0X2ZpbmRfbmV4dCgmeGFzKTsN
Cj4+Pj4+PiAgIGlmICghZGVudHJ5KQ0KPj4+Pj4+IC0gcmV0dXJuIEVSUl9QVFIoLUVOT0VOVCk7
DQo+Pj4+Pj4gKyByZXR1cm47DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgaWYgKGRlbnRyeTJvZmZzZXQo
ZGVudHJ5KSA+PSBsYXN0X2luZGV4KSB7DQo+Pj4+Pj4gKyBkcHV0KGRlbnRyeSk7DQo+Pj4+Pj4g
KyByZXR1cm47DQo+Pj4+Pj4gKyB9DQo+Pj4+Pj4gICAgIGlmICghb2Zmc2V0X2Rpcl9lbWl0KGN0
eCwgZGVudHJ5KSkgew0KPj4+Pj4+ICAgZHB1dChkZW50cnkpOw0KPj4+Pj4+IC0gYnJlYWs7DQo+
Pj4+Pj4gKyByZXR1cm47DQo+Pj4+Pj4gICB9DQo+Pj4+Pj4gICAgIGRwdXQoZGVudHJ5KTsNCj4+
Pj4+PiAgIGN0eC0+cG9zID0geGFzLnhhX2luZGV4ICsgMTsNCj4+Pj4+PiAgIH0NCj4+Pj4+PiAt
IHJldHVybiBOVUxMOw0KPj4+Pj4+ICB9DQo+Pj4+Pj4gICAgLyoqDQo+Pj4+Pj4gQEAgLTU1MSwy
MiArNTY3LDE5IEBAIHN0YXRpYyB2b2lkICpvZmZzZXRfaXRlcmF0ZV9kaXIoc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpDQo+Pj4+Pj4gIHN0YXRpYyBpbnQgb2Zm
c2V0X3JlYWRkaXIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQ0K
Pj4+Pj4+ICB7DQo+Pj4+Pj4gICBzdHJ1Y3QgZGVudHJ5ICpkaXIgPSBmaWxlLT5mX3BhdGguZGVu
dHJ5Ow0KPj4+Pj4+ICsgbG9uZyBsYXN0X2luZGV4ID0gKGxvbmcpZmlsZS0+cHJpdmF0ZV9kYXRh
Ow0KPj4+Pj4+ICAgICBsb2NrZGVwX2Fzc2VydF9oZWxkKCZkX2lub2RlKGRpciktPmlfcndzZW0p
Ow0KPj4+Pj4+ICAgICBpZiAoIWRpcl9lbWl0X2RvdHMoZmlsZSwgY3R4KSkNCj4+Pj4+PiAgIHJl
dHVybiAwOw0KPj4+Pj4+ICAtIC8qIEluIHRoaXMgY2FzZSwgLT5wcml2YXRlX2RhdGEgaXMgcHJv
dGVjdGVkIGJ5IGZfcG9zX2xvY2sgKi8NCj4+Pj4+PiAtIGlmIChjdHgtPnBvcyA9PSBESVJfT0ZG
U0VUX01JTikNCj4+Pj4+PiAtIGZpbGUtPnByaXZhdGVfZGF0YSA9IE5VTEw7DQo+Pj4+Pj4gLSBl
bHNlIGlmIChmaWxlLT5wcml2YXRlX2RhdGEgPT0gRVJSX1BUUigtRU5PRU5UKSkNCj4+Pj4+PiAt
IHJldHVybiAwOw0KPj4+Pj4+IC0gZmlsZS0+cHJpdmF0ZV9kYXRhID0gb2Zmc2V0X2l0ZXJhdGVf
ZGlyKGRfaW5vZGUoZGlyKSwgY3R4KTsNCj4+Pj4+PiArIG9mZnNldF9pdGVyYXRlX2RpcihkX2lu
b2RlKGRpciksIGN0eCwgbGFzdF9pbmRleCk7DQo+Pj4+Pj4gICByZXR1cm4gMDsNCj4+Pj4+PiAg
fQ0KPj4+Pj4+ICAgIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgc2ltcGxlX29mZnNldF9k
aXJfb3BlcmF0aW9ucyA9IHsNCj4+Pj4+PiArIC5vcGVuID0gb2Zmc2V0X2Rpcl9vcGVuLA0KPj4+
Pj4+ICAgLmxsc2VlayA9IG9mZnNldF9kaXJfbGxzZWVrLA0KPj4+Pj4+ICAgLml0ZXJhdGVfc2hh
cmVkID0gb2Zmc2V0X3JlYWRkaXIsDQo+Pj4+Pj4gICAucmVhZCA9IGdlbmVyaWNfcmVhZF9kaXIs
DQo+Pj4+IC0tDQo+Pj4+IENodWNrIExldmVyDQo+PiAtLQ0KPj4gQ2h1Y2sgTGV2ZXINCg0KDQot
LQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

