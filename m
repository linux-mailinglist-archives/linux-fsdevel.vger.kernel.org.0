Return-Path: <linux-fsdevel+bounces-28607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F396C5A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE441F2686F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862E1E2011;
	Wed,  4 Sep 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UZxjg80T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KMeGBbQO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E111E132C;
	Wed,  4 Sep 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471969; cv=fail; b=c5bgU0DexMuxnFq8ZB5Ra5JRDoFXuJbS3w65JRf34nfyx7HIBMweJoBX78RL/Ns/TF4xM1D4IU7ZM+nHE6F6CArr5vxRIX+7HtK825a3OyigV+BZTk5kuo2WBs0oe37TeiS+nA8bAp2HpiYoqCRf2ulETrfcqgcZHlfK+Mhbxdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471969; c=relaxed/simple;
	bh=4ryFkgnIfOTEa18Kis5KBqILFLNYI2OAQ+2ZejNcIP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t23Yk218hxEgbbqY97lhY4mPzFDNLISvpxSVsgyiKlGkUaqgXk1AAoN+FRNCo0X2VfiVxm/YshPrXzUmHBL92MItp9U9xydQ9ran9oa3jLFEGcxfLZmODBlvqjw3Lp4f8ARpIjyYlQb14BYEor9Ucas2nWtIqpT7NF4vlUOe3DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UZxjg80T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KMeGBbQO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484GtheG030622;
	Wed, 4 Sep 2024 17:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=4ryFkgnIfOTEa18Kis5KBqILFLNYI2OAQ+2ZejNcI
	P0=; b=UZxjg80TCliHfQsuCV24fkk4Y/3m60NV3MnVy2bDgjmwkPvRIsX3D7p+R
	onmPua59ZEOdbM/oVmEajResHKGhBTE/wg9e3oE9D4FbOA2z1CQYBU4+D6oYHmaJ
	zq+YNmrV5KnLECJzd1UC/wuR9mPLfiJLCZ7MvY2YJ35fUptNJKE7pC7W+pt1USou
	VNwcBmgDkaCsI5GpC1KuH0/wugyOi+FWOkDalib2TK2MH9iKknwVBYmutCY62oWy
	E73myX3Kce1qvm4QQRzsReluYJlUzkhpVQttjcd+xzwTMY4IaJ6Ia67NVvDuoPfP
	SbVsrkge6vZOVI1ox9PYIyY8tN+Mg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvu7c2vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 17:45:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484HGH5t036719;
	Wed, 4 Sep 2024 17:45:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmadjw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 17:45:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjqvF5p40gdw/OViEEzWUnxWbdRv7S7c5N4To4JeWTq8PKwZLdlG+8L96zLGfiak+WCDgiDaF9/bc9n3G3LOYIQty34OCn5J4DX2UkJ4KN0v45O66aAub/EV65jTS1SWpbq968j8OFDbv9xlagWLS4Tx41mWJKwtOXrpi7MiSFp+ltJoRqiU9Pw0RldlhHukREE4oOpsVefHS0yDQ9MECXJ/PSdx+rwmN7IdQuPfd4z/ZZP+DDm5dfDCQeCQUmKxTkuIb2f98SD/vnz2MnL0/U1FdClZ+fY3chZBiLi25UiL+SkKhXmzftiqWYK2zhsxxk9tJKoQeOqM6umVlcnCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ryFkgnIfOTEa18Kis5KBqILFLNYI2OAQ+2ZejNcIP0=;
 b=JuVvSEYUxEbgXKwWLoDI3ERUAM5tAxY8+0dhKPt4e8ul7yp0lRsV8+bcAr8mkdKaGsJVuCUQtAVS/JktW4RcgAPH1bwQCMRUsIj8YrrQPA/daYSZnRv+LAEpmGLNaEPCGJdd4D1luelGj586MwlxHixFP4VthbtucUeio4BNk6nBnWomkAM/A0lEgfRHljFj8cqcwVk9blW9ZVzPJsDb2MnQBv6V4WJHIlZ81oXRLuYjuXllI3rolal3i+WmdQKGnNa+RS3Ky80qteheFk2uf1fmcoez/N/B5sqeZR1aTqZMBgKMdF/u4rWnBS6Un3mQo3Od3enkr+PfdIsCjLtsJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ryFkgnIfOTEa18Kis5KBqILFLNYI2OAQ+2ZejNcIP0=;
 b=KMeGBbQOCfQnSdf10hqOTvKus8QLGYruI+TirRjP/Qi2twXUruUwBmrt/e3pxwg6v2Eh4IJukqq3pko//5Dsn5XCyK6a7iNraqBjg/iqZqCA4T7HuiJ/id2b0LutVMYabrZnz6sPLJ6L7lr+4SH/DMLa/ADDgoFs9Ckcq73yIBs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Wed, 4 Sep
 2024 17:45:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 17:45:49 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust
	<trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia
	<okorniev@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet
	<corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
Thread-Topic: [PATCH v3 03/13] nfsd: drop the ncf_cb_bmap field
Thread-Index: AQHa+hcisJ+uiYoVSkuSYBhTQHnQ87JHx6IAgAAbjwCAAAhggIAAAxWAgAABrAA=
Date: Wed, 4 Sep 2024 17:45:48 +0000
Message-ID: <59DF9B68-4D5F-4E2D-A208-B8EE86D61A85@oracle.com>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-3-271c60806c5d@kernel.org>
 <Zth6oPq1GV2iiypL@tissot.1015granger.net>
 <82b17019fb334973a74adf88e3eb255df4091f12.camel@kernel.org>
 <52C563DF-88D1-4AAC-B441-9B821A7B32FF@oracle.com>
 <2ae8b2d1e2f22fba5acb88c3f12cef9716f28a62.camel@kernel.org>
In-Reply-To: <2ae8b2d1e2f22fba5acb88c3f12cef9716f28a62.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4809:EE_
x-ms-office365-filtering-correlation-id: fc8e78a1-a275-4fa6-a5e1-08dccd096998
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGdidi9NVU1BNVNBeU1wU1hubXU2Slp3Z3dJRkErdUQvNTJ6R0lUbi9LY2RJ?=
 =?utf-8?B?TmNEeE1KTjJTZERGaGJWQS9xNjRlSlRLUEltcW5sS0tXd09oSURXTzNVNGk2?=
 =?utf-8?B?bEJteVRVNjFBa3drTlAzSUdNQWJLc0JTcVM2OWFMRnpmTkJEQWV5bFA5Ykhu?=
 =?utf-8?B?ZkNUSWhXRi9nUzU0c1RWODRrc0N4YmRiaDA2cnQrcGl4bDdMdkNRbWhuRjFm?=
 =?utf-8?B?cEF0OVdjcml5QzM1Y3ZTRGtOZEJXTXBTeU45T0xBSm5GVFpwdHR0YlFoSG5M?=
 =?utf-8?B?UG45c3d2b1RCQlR2WU9uZjJwcjFwSEVrZmZQbkowMXJGMWFINTQwZjMwYTFx?=
 =?utf-8?B?cVdJMkdGWjQ5Y0JqWFNYcGZJbU5sRHNSR2RwNFBlNjIwalNIaUJJNEdyYjFz?=
 =?utf-8?B?VVBVdUduaUFxdEZhYlIrdnVqdHY2UjJzaDFtSG04cGs4YXFRRFZxbEFRQTht?=
 =?utf-8?B?RW5SZmtXQjJVMlhsckg0c1lqVncwWUxJMHBkQ1dMc3R5Nm1oa1FkMlhPZ0hH?=
 =?utf-8?B?YTVyc2pZSlBkQjNYNlZnWXVDQWVoWkRlZVZKMEI2M2piTm1IT2FjUUJQVm9r?=
 =?utf-8?B?azR5SWJyS2Z5SnpGSVpsMlY5a2xDaFRXOHVtcnh4RlhPMGRSaFJOWDY2cVpS?=
 =?utf-8?B?UXFUUUZKbytPc3RuNDdRdW9QVzZxTXNZVkQzaGVFWjJYV0xOclg0S1F1ZFpy?=
 =?utf-8?B?bUZDNDBkcytGVlJDUGZYZWJiTGIyeUJ0TWxsajNONTVzZ1l3bGV4UVZXSDIw?=
 =?utf-8?B?Z3lMeWVsL3UvdnN2Nk5sVHJkZmxrYUt1RzJ0dVJEM0tGeDVaalg2ZEMzTVdp?=
 =?utf-8?B?RGNhUTJicksvTTJHSVZvTnE0KzJ2UzVSK0E0WEdBNnF0Y0tNUEpoUHo0MWEv?=
 =?utf-8?B?UXhLL3VudUJ3a1VOSFNJc09SYWgwZU9jRklPK1dpM3g3cmk0QVNrSlVNOTkw?=
 =?utf-8?B?MER6WnYyQTlsajRUVXZ4c3dsYVptQWZ0VUpYRU8rY2pKMTR2Z1lmNlhPQjRG?=
 =?utf-8?B?NWhVdEw5QTJzT0h5NGhvRFpRcUtydHRnWkFNM1BFczFKaFlwMEdWc0tMejJF?=
 =?utf-8?B?aDNCT1FiOHBxbDd0M3EzUE5YOVBuT0dIQTRjdUl1ZGJmMUhRUmJJRjFjUU5W?=
 =?utf-8?B?b0pWVW9iYmFVUnZIMGwvaDNWZ1hXWS9KdEZYZmxRcXhXTmFrLzJNUmdGK3g2?=
 =?utf-8?B?MFVMWVVadTgySkJBZlhDT3c4SVlvNmQ3UHhsdFJNdVB0c05XR1p2bnFqRTA4?=
 =?utf-8?B?bUdWcWt3WGprS1VaNHBSdFFQckNLNTVsRWpWTlJMZ0FhdVlCd1JCWCs0Y1NT?=
 =?utf-8?B?TWhTajhVMlc1K1VSbEgxb1Mzbmk0REFSZ1F6VmVrMDUzUy9uNUxlaUFtZkxz?=
 =?utf-8?B?aFpFVzZOSDRCT1IwbmdMMDNKWC83ZGZ5NlFQcmpxR1A2Nmd4c0NWMVRHNnJO?=
 =?utf-8?B?cmRxTzd2ZWdDdzhMdHZTOVBqRS95RDdReGVXWndzWEI1VnlzN1RMQWlNOTNO?=
 =?utf-8?B?a3lia1l0b3E0dlhPcEY0dTFnM2l3VkZhY1Z5QS8yNkVVYmt0dkczWHBldnVu?=
 =?utf-8?B?aHNwbS9ZeGpiazJoMFpVVXNhaDBrSWYzSzFIVC9ZM3gyQlpJTitxQnBhcGNr?=
 =?utf-8?B?dGEyZXlSclhaYmtlUVc3RHB6UE90L0srcE8xWVNEQnNZSGdsSC9sSnQvcVNP?=
 =?utf-8?B?NFJ3S083cjJnV0JzVU9kbVNmcytMQmZnK1RCYkhIQmU1QmwyZk1qdFBLeS8r?=
 =?utf-8?B?VEw5S3d4UkVSM1RQQUw3eG44YnFwbFU5N1NNbnVIcUZ1RmhUUDN5WVVVVFh5?=
 =?utf-8?B?b2hFcEU0MFZXYjFObUpXQjNUTGQ5K1RLZjVXVy9xbWhJdGJ2Y0lMYWNMaXlk?=
 =?utf-8?B?bkNnOUJEVnhyL1E5VTlwZWUrRmdGaXRzTnhZV1RxV0xDRmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SndiakptRHFSTkVHQU82bEtYWUNLNjhIbmcwSEZWYXMvWlRjU1F2QTE1M0FV?=
 =?utf-8?B?dU9JMC9zV3YxQkhqK1ZuZ0xYY3pFZFEweVY4UXRjaU95YjhxQk5IU3paNjRi?=
 =?utf-8?B?Nk84RThEU3plVGNWVHdIbEJrSm9wdjFOc0xtOGxqSzhnb0lmcURYNHJuNjlJ?=
 =?utf-8?B?dEd6MFZadHNvOTY4ODdwUnhMS3VSdE96YzRCUkFWMnRWcVJIU1N3WHBsQTd3?=
 =?utf-8?B?RC8yeVpSeUxJVUlKUEU0RWVPbnJiN1FSVnB0ajhNamxwTTQrTW5mZ0p4bWNm?=
 =?utf-8?B?a2Z3N2h5YXRCQUtEVWIvZ001QlNxbHhDVDFGeWtjdmtsbmdaZXp4eHg3Vkg1?=
 =?utf-8?B?bWsrZTAvaDVhZmRPZmlPVkFzenM3SVFhWmdNcDlFaERSOGFVUGRTKzkxT1dG?=
 =?utf-8?B?SkVySTgwK21rZURYT1RSNXRjV1lUTWlhMlRTK24xVmFpUzBtUFF3bXR3MkpF?=
 =?utf-8?B?TGxhbk8vdzV2bDY2SW1QVmdOZ0NsTUZ5eHRoZlF2TTVZeUYrUHV5S1FGdys2?=
 =?utf-8?B?OEwyNkZ3ZW4zbmxkWkM4dEhSMFg4eXp5QVdxaDF0Ri9sRU5mRW5qTXhWNnV3?=
 =?utf-8?B?UCtDYmlBSzdTMmxSdU9RS0JlYk5HWVlKcCs2VXJQekhIREJpTWVnN1I2M1dj?=
 =?utf-8?B?T1NqdWZIbE9MQUxOSUxodkhwRmlYa0U4RmRsS05tYllhSlJTWm9rRW5FbWJr?=
 =?utf-8?B?RnRWb3QwMU9ycklSOGUrYWdPdDQvREFSLy9wRG43QTZ2RFdaVWlIZ0pwME96?=
 =?utf-8?B?cWlaMzNzUmJOVWlITWRJamRmLzdEOW5uZ0dHY0FDZXpiV0daQVMzNXU4T3Qv?=
 =?utf-8?B?b2YzbkFaTlpPcGVyVkoxb3ZOQUgzVHY3UmkveGdqZXBXOWZhK3NRbXhyeWxL?=
 =?utf-8?B?SnFTYzV2OVMxMFhLNTBXYmxNeGNGNEFaRTVoR01kUVNxcDZhRGRMeDNKSTNz?=
 =?utf-8?B?UERnM2hDRXBzKzU4SzZhc2l2bU16WURHN1FyM0VFdm81Z1JkVExmSUFtWXJR?=
 =?utf-8?B?ak42aCtlV1lzemRlT09uQUNjSHpPOUV4ZnM0S1VKK2NVTXBNMDJyM2lJZzE2?=
 =?utf-8?B?MnY2dmZLOGVzV0cyUGowdzNCUXBVcWd3SmFrYXd1bHQ3TVN3dy84NHJEWFVX?=
 =?utf-8?B?WlFNalZMbThEcG1hWjBqbStzVGMrQ0ZqaTNKb1lZa1NVUjJhc0lUSEdoR3VO?=
 =?utf-8?B?ZjlBWU5maW9OK2I2WUV1anlsblE4ZUpKVkNjTEVmRE5pbGRCdGE5WndYWWRM?=
 =?utf-8?B?OVpJSUs4Ky8xUHh2Yk8rUVphMmpmVUdkNDUwZFV6TGVncXJDaTVjY1F1ZThL?=
 =?utf-8?B?bElNaG5hTnY4Nzg4SkJ6dmJCbENGTFNHUUNmZ3VJcVdCY3dhRnNpOGZualVv?=
 =?utf-8?B?WTdjc0xyZmt0M1JTTWRjODdSS0gwWElsZW5IazF6UnlmZXdHYi8wRkNueTdJ?=
 =?utf-8?B?eTVLelZtSUFJQmIzMXZVaTFaY29QMndUYjBiRHBkMmVNcXdUYVkxUm5RQWxD?=
 =?utf-8?B?SmFQQnQ4aVdpSjJoQU9OZ1RoWldaeXhWM1ZONnh6OHl5THdrNEgzdTlGTUNW?=
 =?utf-8?B?SmdtNmJwOTNWaERVcGVWdU1ranVWalV3a2J3MHBERHRSYWpzM2czbW9aazNy?=
 =?utf-8?B?OXRwSkd1SndWUUNqUjdNYXdkaFFkRE83ekZ6cmVYcnh1aUVEd0lsbXUvdVdD?=
 =?utf-8?B?WVFzSWExT0c1NnNuL1JzM0R1MkRiZnpMNG1ESWI0bDkydEdTQ0FBWWxhYUVL?=
 =?utf-8?B?dWpRMWxpQk5rdTlPK2VyQmRtYzV3aGhRZ3I3c1Jyc2o4aExrUjlRLzMwLzFH?=
 =?utf-8?B?UlBVa0w3MzJsbEhjR3FkRkJGK0wzVVE0MFpDNXNyNHlVWDFiakM0a2Z5S3hr?=
 =?utf-8?B?SkJ0SUFyREw0eC9OQitSQUJocDJEaTBUL2NDa2d6Wjk2QlUvSWVjMFJtbHI3?=
 =?utf-8?B?MzNwRkd0cFdjZGRaVTl2VHlNYjIwd2ljaG1DTnpzdHU1cnNtbXkrVDBRS1NM?=
 =?utf-8?B?d0N4M2JsMGNtVFIxc2xzd25tT1NSQmZhOUFsUnoxTTh6TmgzSDNqM29OS3lB?=
 =?utf-8?B?c2RuMXB4cW40T1kzUnRGNi9tcGMrZWZnM0dpcTZ0MWFPdFQrTGlwNzZUK3VG?=
 =?utf-8?B?TmRjaHlEelVOcTZET0VEYURjNm9wekVqWnR0TUZ1ZnBkSXZPNGNWRHpVZVlH?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDFEC72E71F2F04EAB605C0F7E08D2E0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ov7lrZA1JpTQDhdyeb2vUbRmjHoUutwuCwndvv7SpLRsVfuoOO4z3MEOTWl9iXL7MyZIplyA3HQYOPkRrbYJCre3n8JEusW8hDa8dkpRfEqraTZF8XVqXiUeHm7ffLUz/B+Q6YpZgyTKTghbu7vYOJ7NiixkuMP572gYcfKGBTAuBw9HlMarp0hc5hsPe/Ae0SdQTZrmm6S+FuD+XbvhlXiGfQu/klnQ1tCIc0pCCGZWS0RbnHoqJQi3wYCAYVvwcLGGiOoLGXKPN6nbqJ/+womUXCJpphmgk82KqLaw1GbVpW7t96cwtdqFGedrkzfVfs0bh8WCbS8XjjTmML8R+XGiPpTWiPcDGB0Zk8jqffSLtlb0a+RQ6yevpoWDHgIgO9/wWO5x0Gv9u5B6VFoH4TW9SP6Wh4mQ4zD/1aqzEmDOCpdosjhkvHQU5woxdhYCeUlBh8jNAPvIpD151Ha5fPJgngCdfQp0BhoP3AxoqCTihI0K8enzWVEeGVDHrKnkzMXnFS1Zt8t6dSVo8t5InjY9cY1uBWVzmZDbdzKFFyk0wOU2qYbnTPoQDhKdtRE0DqeiNRfBw/i5i/+FLYsQMiX3h5uYWJ7xyW4o6LF7SaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8e78a1-a275-4fa6-a5e1-08dccd096998
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 17:45:48.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQoepIJT0tRKyFP4y5HrdhXTtfaFRaVudA93Ts07gOegsU9A+PGBm/usIM06yjuuVQ+We4MtRcKVreppMx43lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_15,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040134
X-Proofpoint-ORIG-GUID: 4HDNc770CQ3gIgVvo296WeQz6JHtbJrd
X-Proofpoint-GUID: 4HDNc770CQ3gIgVvo296WeQz6JHtbJrd

DQoNCj4gT24gU2VwIDQsIDIwMjQsIGF0IDE6MznigK9QTSwgSmVmZiBMYXl0b24gPGpsYXl0b25A
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDIwMjQtMDktMDQgYXQgMTc6MjggKzAw
MDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4+IE9uIFNlcCA0LCAyMDI0LCBhdCAx
Mjo1OOKAr1BNLCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBXZWQsIDIwMjQtMDktMDQgYXQgMTE6MjAgLTA0MDAsIENodWNrIExldmVyIHdyb3Rl
Og0KPj4+PiBPbiBUaHUsIEF1ZyAyOSwgMjAyNCBhdCAwOToyNjo0MUFNIC0wNDAwLCBKZWZmIExh
eXRvbiB3cm90ZToNCj4+Pj4+IFRoaXMgaXMgYWx3YXlzIHRoZSBzYW1lIHZhbHVlLCBhbmQgaW4g
YSBsYXRlciBwYXRjaCB3ZSdyZSBnb2luZyB0byBuZWVkDQo+Pj4+PiB0byBzZXQgYml0cyBpbiBX
T1JEMi4gV2UgY2FuIHNpbXBsaWZ5IHRoaXMgY29kZSBhbmQgc2F2ZSBhIGxpdHRsZSBzcGFjZQ0K
Pj4+Pj4gaW4gdGhlIGRlbGVnYXRpb24gdG9vLiBKdXN0IGhhcmRjb2RlIHRoZSBiaXRtYXAgaW4g
dGhlIGNhbGxiYWNrIGVuY29kZQ0KPj4+Pj4gZnVuY3Rpb24uDQo+Pj4+PiANCj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+Pj4+IA0KPj4+PiBP
SywgbHVyY2hpbmcgZm9yd2FyZCBvbiB0aGlzIDstKQ0KPj4+PiANCj4+Pj4gLSBUaGUgZmlyc3Qg
cGF0Y2ggaW4gdjMgd2FzIGFwcGxpZWQgdG8gdjYuMTEtcmMuDQo+Pj4+IC0gVGhlIHNlY29uZCBw
YXRjaCBpcyBub3cgaW4gbmZzZC1uZXh0Lg0KPj4+PiAtIEkndmUgc3F1YXNoZWQgdGhlIHNpeHRo
IGFuZCBlaWdodGggcGF0Y2hlcyBpbnRvIG5mc2QtbmV4dC4NCj4+Pj4gDQo+Pj4+IEknbSByZXBs
eWluZyB0byB0aGlzIHBhdGNoIGJlY2F1c2UgdGhpcyBvbmUgc2VlbXMgbGlrZSBhIHN0ZXANCj4+
Pj4gYmFja3dhcmRzIHRvIG1lOiB0aGUgYml0bWFwIHZhbHVlcyBhcmUgaW1wbGVtZW50YXRpb24t
ZGVwZW5kZW50LA0KPj4+PiBhbmQgdGhpcyBjb2RlIHdpbGwgZXZlbnR1YWxseSBiZSBhdXRvbWF0
aWNhbGx5IGdlbmVyYXRlZCBiYXNlZCBvbmx5DQo+Pj4+IG9uIHRoZSBwcm90b2NvbCwgbm90IHRo
ZSBsb2NhbCBpbXBsZW1lbnRhdGlvbi4gSU1PLCBhcmNoaXRlY3R1cmFsbHksDQo+Pj4+IGJpdG1h
cCB2YWx1ZXMgc2hvdWxkIGJlIHNldCBhdCB0aGUgcHJvYyBsYXllciwgbm90IGluIHRoZSBlbmNv
ZGVycy4NCj4+Pj4gDQo+Pj4+IEkndmUgZ29uZSBiYWNrIGFuZCBmb3J0aCBvbiB3aGV0aGVyIHRv
IGp1c3QgZ28gd2l0aCBpdCBmb3Igbm93LCBidXQNCj4+Pj4gSSB0aG91Z2h0IEknZCBtZW50aW9u
IGl0IGhlcmUgdG8gc2VlIGlmIHRoaXMgY2hhbmdlIGlzIHRydWx5DQo+Pj4+IG5lY2Vzc2FyeSBm
b3Igd2hhdCBmb2xsb3dzLiBJZiBpdCBjYW4ndCBiZSByZXBsYWNlZCwgSSB3aWxsIHN1Y2sgaXQN
Cj4+Pj4gdXAgYW5kIGZpeCBpdCB1cCBsYXRlciB3aGVuIHRoaXMgZW5jb2RlciBpcyBjb252ZXJ0
ZWQgdG8gYW4geGRyZ2VuLQ0KPj4+PiBtYW51ZmFjdHVyZWQgb25lLg0KPj4+IA0KPj4+IEl0J3Mg
bm90IHRydWx5IG5lY2Vzc2FyeSwgYnV0IEkgZG9uJ3Qgc2VlIHdoeSBpdCdzIGltcG9ydGFudCB0
aGF0IHdlDQo+Pj4ga2VlcCBhIHJlY29yZCBvZiB0aGUgZnVsbC1ibG93biBiaXRtYXAgaGVyZS4g
VGhlIG5jZl9jYl9ibWFwIGZpZWxkIGlzIGENCj4+PiBmaWVsZCBpbiB0aGUgZGVsZWdhdGlvbiBy
ZWNvcmQsIGFuZCBpdCBoYXMgdG8gYmUgY2FycmllZCBhcm91bmQgaW4NCj4+PiBwZXJwZXR1aXR5
LiBUaGlzIHZhbHVlIGlzIGFsd2F5cyBzZXQgYnkgdGhlIHNlcnZlciBhbmQgdGhlcmUgYXJlIG9u
bHkgYQ0KPj4+IGZldyBsZWdpdCBiaXQgY29tYmluYXRpb25zIHRoYXQgY2FuIGJlIHNldCBpbiBp
dC4NCj4+PiANCj4+PiBXZSBjZXJ0YWlubHkgY2FuIGtlZXAgdGhpcyBiaXRtYXAgYXJvdW5kLCBi
dXQgYXMgSSBzYWlkIGluIHRoZQ0KPj4+IGRlc2NyaXB0aW9uLCB0aGUgZGVsc3RpZCBkcmFmdCBn
cm93cyB0aGlzIGJpdG1hcCB0byAzIHdvcmRzLCBhbmQgaWYgd2UNCj4+PiB3YW50IHRvIGJlIGEg
cHVyaXN0cyBhYm91dCBzdG9yaW5nIGEgYml0bWFwLA0KPj4gDQo+PiBGd2l3LCBpdCBpc24ndCBw
dXJpc20gYWJvdXQgc3RvcmluZyB0aGUgYml0bWFwLCBpdCdzDQo+PiBwdXJpc20gYWJvdXQgYWRv
cHRpbmcgbWFjaGluZS1nZW5lcmF0ZWQgWERSIG1hcnNoYWxpbmcvDQo+PiB1bm1hcnNoYWxpbmcg
Y29kZS4gVGhlIHBhdGNoIGFkZHMgbm9uLW1hcnNoYWxpbmcgbG9naWMNCj4+IGluIHRoZSBlbmNv
ZGVyLiBFaXRoZXIgd2UnbGwgaGF2ZSB0byBhZGQgYSB3YXkgdG8gaGFuZGxlDQo+PiB0aGF0IGlu
IHhkcmdlbiBldmVudHVhbGx5LCBvciB3ZSdsbCBoYXZlIHRvIGV4Y2x1ZGUgdGhpcw0KPj4gZW5j
b2RlciBmcm9tIG1hY2hpbmUgZ2VuZXJhdGlvbi4gKFRoaXMgaXMgYSB3YXlzIGRvd24gdGhlDQo+
PiByb2FkLCBvZiBjb3Vyc2UpDQo+PiANCj4gDQo+IFVuZGVyc3Rvb2QuIEknbGwgbm90ZSB0aGF0
IHRoaXMgZnVuY3Rpb24gd29ya3Mgd2l0aCBhIG5mczRfZGVsZWdhdGlvbg0KPiBwb2ludGVyIHRv
bywgd2hpY2ggaXMgbm90IHBhcnQgb2YgdGhlIHByb3RvY29sIHNwZWMuDQo+IA0KPiBPbmNlIHdl
IG1vdmUgdG8gYXV0b2dlbmVyYXRlZCBjb2RlLCB3ZSB3aWxsIGFsd2F5cyBoYXZlIGEgaGFuZC1y
b2xsZWQNCj4gImdsdWUiIGxheWVyIHRoYXQgbW9ycGhzIG91ciBpbnRlcm5hbCByZXByZXNlbnRh
dGlvbiBvZiB0aGVzZSBzb3J0cyBvZg0KPiBvYmplY3RzIGludG8gYSBmb3JtIHRoYXQgdGhlIHhk
cmdlbiBjb2RlIHJlcXVpcmVzLiBTdG9yaW5nIHRoaXMgaW5mbyBhcw0KPiBhIGZsYWcgaW4gdGhl
IGRlbGVnYXRpb24gbWFrZXMgbW9yZSBzZW5zZSB0byBtZSwgYXMgdGhlIGdsdWUgbGF5ZXINCj4g
c2hvdWxkIG1hc3NhZ2UgdGhhdCBpbnRvIHRoZSBuZWVkZWQgZm9ybS4NCg0KTXkgdGhvdWdodCB3
YXMgdGhlIGV4aXN0aW5nIHByb2MgZnVuY3Rpb25zIHdvdWxkIGRvDQp0aGUgbWFzc2FnaW5nIGZv
ciB1cy4gQnV0IHRoYXQncyBhbiBhYnN0cmFjdCwNCmFyY2hpdGVjdHVyYWwga2luZCBvZiB0aG91
Z2h0LiBJJ20ganVzdCBzdGFydGluZyB0bw0KaW50ZWdyYXRlIHRoaXMgaWRlYSBpbnRvIGxvY2tk
Lg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

