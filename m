Return-Path: <linux-fsdevel+bounces-21492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A490488B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 03:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66814285510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1883763BF;
	Wed, 12 Jun 2024 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxQbkTrN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GOUD+sfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932AB667;
	Wed, 12 Jun 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156952; cv=fail; b=m6kr0QObtZzBVj1arKYZIOSeks8s0UszO6qNWLrh69Z9pN4FLGmV3fLvu1/ZFN/cvs2H0OUsCC1JrQBaHr2eQXvBl0Eq/L8wPXhG70U9MQf5dEDWKEtO9gaXectFav3LstDpEbfYzont9a/Q+n/ofSrR+Kqg6x1uU3Qb52MvjCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156952; c=relaxed/simple;
	bh=cLzgnUHlGD/ABm2tz6c17HnhmzW6JH4HuTMh76XwUvg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=pwkLmiKmVYudzbjj+9f53HQN6i3gc7o+GgATVZGEyACYKwErmli2sd8nfZbdeBufD2zn1DDWfo/vp8Zxbkn67eIX9/aLCjmdIkazbPHnlBUGYU3vZTCkB4oPgQ/cBI9bA3jRLyk11uyJm5QAPQYU8XVitcb8kSsS64QLSEpFXjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TxQbkTrN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GOUD+sfd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFeTDt004119;
	Wed, 12 Jun 2024 01:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=fFmHcDkU0fXrb5
	aGtfiJjpOpMnSxli5rTQaW5LVmFug=; b=TxQbkTrNEKOhIpmfemacGTJIlO0Lha
	ASLK9RpXnf2F8adlz2BHv2g9yYvKAbmG5zs2H1xhLLP6BDKn7lE0OsHv3cTElkV3
	HAdwkONhPrFM6fiZUq0mtIN9i8BZQoQnlA42mckdocfD49ck3DaAYb5v+fWDcqny
	yiO2gRYnsjKfxGzsInCEcVbSpA+hj6P20Oac4x7uQOkOT5mAUdvWRkzyoh8uX7ku
	wT2MlCmW8QNs1npe9nhEwOKrgfrbE3JCdbGxHYDgHOmERfX2IsoLzY6s6kfoVQIy
	beCAufdZ63vB4M0Swel9nwsq9badZBtGgaj4bdasECc4ZK2C9e/hy5uw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dp4h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 01:48:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45C0OFUd020262;
	Wed, 12 Jun 2024 01:48:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8y1dnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 01:48:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSp442ZhCUV676/PY09A8I0m5GGSErb0I2XcPzOOPEefykMXDsTveEZXysGT/V5h/TgDfXtX1A0E6BIn3dcqNihIVg/OhIYuNBaKn03wdlh8I50cbVdefZfzniANDhY0HNlQhPKcKDtadZ2a49HRD5KIMvD3pVPakzOSzJpe4vfTWFx97XIdRGroDxalcde9r956Nz//YyaGGqIB73P2UWhP/ux1jnFcAtQCiIDNqOsWd4cJQ67/sYQ2JFa9s5TBs1Zzi3WqbtyO4QtN1D8kmV2kvPxKoZbcA2zlYh4a6TyoYCSygWGI1bPx/XHzJJI751DiuS/sydk6P09l/sgABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFmHcDkU0fXrb5aGtfiJjpOpMnSxli5rTQaW5LVmFug=;
 b=S/KYJK1dIRA0kWLRsHZ8Cfxg7LNi4j5g+Da0L4SswwZi2LsRGmZYkbjCxdfVkcGjqe4JShCWJa0txiWD2Rqe9pd7PjxUUpAZtRANBVootUssEeJer9Jg27KxtLu6tziXeoz90TYa8NFlX9vjbfWsE12XZr84cqkCIIKlAIMt8B3kZBXnuOy7g/PYLqotwHKFful/jRkljczzjJZisV0ZW+mC3MHP2JbVL3M7apvyXiMT4ynA2Mk5dBLsbDWYdA/ueixFFKxfywAAJ+y7ytFO+rFl/k/nMhmbl4p+f1QCBaf/KfP84SdIJBr1hZ3SKGce+cy9TEwe4O5XnaUFr6d6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFmHcDkU0fXrb5aGtfiJjpOpMnSxli5rTQaW5LVmFug=;
 b=GOUD+sfdhfOQAUcELbSq0ynE9m6H/rZNX8qhGiqfoGKPS39W/YUXURywIqUwI21M2qS8hjkEpNuHBAvPAv0h7PlVjF/r1Pc/FcypULhmX3n0OUxHgrmz8OjUF7Jkt+wR5qV55qkA3QU3aTx8aqvRBvJq+hdP0Ee83P5xtxJVRtY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7301.namprd10.prod.outlook.com (2603:10b6:208:404::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 01:48:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 01:48:50 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Heusel <christian@heusel.eu>,
        Andy Shevchenko
 <andy.shevchenko@gmail.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Daejun Park
 <daejun7.park@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Damien
 Le Moal <dlemoal@kernel.org>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        regressions@lists.linux.dev
Subject: Re: [PATCH v9 11/19] scsi: sd: Translate data lifetime information
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <9dae2056-792a-4bd0-ab1d-6c545ec781b9@acm.org> (Bart Van Assche's
	message of "Tue, 11 Jun 2024 16:08:44 -0700")
Organization: Oracle Corporation
Message-ID: <yq11q53ylsw.fsf@ca-mkp.ca.oracle.com>
References: <20240130214911.1863909-1-bvanassche@acm.org>
	<20240130214911.1863909-12-bvanassche@acm.org>
	<Zmi6QDymvLY5wMgD@surfacebook.localdomain>
	<678af54a-2f5d-451d-8a4d-9af4d88bfcbb@heusel.eu>
	<9dae2056-792a-4bd0-ab1d-6c545ec781b9@acm.org>
Date: Tue, 11 Jun 2024 21:48:48 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0111.namprd02.prod.outlook.com
 (2603:10b6:208:35::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 442d7ab7-3385-42aa-4c0f-08dc8a81ce8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|1800799016|7416006|366008;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?udfnEImuv33dPG/kXAfFk4GmTqCBLFdVY/fMnG/ryHaSlm73KCQKZjR6Hueg?=
 =?us-ascii?Q?/66Z6ss6DbB/8puuuAAFZL2AFLXOMBx4nOaHBVT0YPSWWGIYm8OhwjSxqg3b?=
 =?us-ascii?Q?aLpOnsUKgKr0Y/aovt4y23Mv0Vcp4K3dsm9mFxIZdURrj0znlrVdrbbN2IEI?=
 =?us-ascii?Q?trDLWLDyy2fB4z8oRJGaJ+MJlFmpVDx+I7j5AXAyWLxgtJFT6x28nBtXW+t1?=
 =?us-ascii?Q?4s28jFE/tcSgwD7YpgwfIk64nvYBw5MEkNdzx5UWqWtyxVyAiB3DokgtWlmp?=
 =?us-ascii?Q?4Ov81RFRlM5G0wirN5ev2i3FczW2dW49V+DAF8RBY3BVeShpacnBCLVbO6LO?=
 =?us-ascii?Q?aNfXM1H3JR9yKRNKba6OUGPQ1AVnn/C+WM056O75F2eJ6m+WPCzogzVrEGzk?=
 =?us-ascii?Q?7HYprR26kH/mVvJeDHoRE2c932tXiAsc79iUHmXrIfsKTStLJul4FIHYH9Rx?=
 =?us-ascii?Q?CLWMS0f6+sQR10fhLpiCf5vgprgeBNhFS90U9JlsHWIIaakEbHMBCCBhZEM9?=
 =?us-ascii?Q?vRUon7kPyyr08Cpz246lPJpkcXMNEOJZ5TzHQh0cJ074JyiLjkb/ZA/lqNJj?=
 =?us-ascii?Q?WCFM0eJndSOHGXD9kjMIsaqMJpqCL2EUJMLGaCbkHMVEarYiEV19RQ5RD2hL?=
 =?us-ascii?Q?Ero5jJzjpQrSANoML1SUE6S1cKupl55l0ppUVX9uaAupfsMQ/fagcXi1oTaS?=
 =?us-ascii?Q?1/JGyygL4r8e7McaVzzxNQGFnsgkDFZPepH6sx3Vuis3ExIul2ZYgXAH7rBl?=
 =?us-ascii?Q?LNha6p1ZGgtvUSdlBiV1JWPEsap4swZbokSyiQGsBxlOJ9cJi/eq//d1SIxK?=
 =?us-ascii?Q?TgnWAB4JAHjyxH/tXo/ew5ZUfbhFPIGBa4SQO9vgmtMNqvTkAd82pm8niqDk?=
 =?us-ascii?Q?B8d//vQIEOiFjE2VhxpzQVE0URePVDGfUsUc9k7qjfkYsYH+cliir3A//T7N?=
 =?us-ascii?Q?SK5xcGrD5+iqB9BGQLVkDrOrLlnoD3Mpvv9mHCgfNgXUViDsujoXC/TMyIOw?=
 =?us-ascii?Q?Tpjq4PSsMDfFCFSmqK50EskxYrGJlnoRQ+BA2IxRx8j2SW9mTMP88D5JBLJa?=
 =?us-ascii?Q?GDnrI5DGPfgtxHuj+wNgRjlqaPtJaRorWJirocsW9aske3An0XQjyVgH1PAs?=
 =?us-ascii?Q?CnIrRK7I/7Z0ySSh6lrNDzeRSGDR7zgbYVILD5dEC8c1ZaI+sT7KDYtLy7aj?=
 =?us-ascii?Q?fKSh5Rcs/nssKWszcaNbEObfDUCULBR9aVbuQdWFQQeqkHxl3tMmJ+y0USwX?=
 =?us-ascii?Q?Duvx5k6d0TrWSU0ckZUvcW/Cs5sLWwae/p0R+pZwOH44TL18FKFpsjq6sXFa?=
 =?us-ascii?Q?9DPUfvD/OLaDvxaZ8IkWd+Ea?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(1800799016)(7416006)(366008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kHByuyoOARSSWV+QQutnCRO0JIkrghhFRwY0DdddvrQ7cIa8z5arsTYN/taq?=
 =?us-ascii?Q?86AsX1dBDXuw2+QT0/KgwEA8KnbVBgGWNHLfLhvtRWm4MZMuwjm5PmjUYJtq?=
 =?us-ascii?Q?HlgY6CJKajE/EB2V4BftuiWTEM1s/AMXSwAOSLJS2lPQy0QXc8ihL5S1OkrY?=
 =?us-ascii?Q?7movKcodfp6V3QxxQahXBq88r9MZyKY+D1DfYoaMjnVgXS/UhG5MMiI5F5Cp?=
 =?us-ascii?Q?1YUubxhuXFuubbDlYTUqjmH6G9Seb5lrdwObFKGtSFX7gAsFnQP/KtIemfaq?=
 =?us-ascii?Q?ek2oWIfE4DtluX9pollYv3LynQrYpQWtSANp9Sdmb86O9KV7HSSd2dAPoNal?=
 =?us-ascii?Q?hyHi+QgErVtMigmxLV2oMEZcVWULBrqehsCROBlgu/jRMi7cw5CmHCqE68sp?=
 =?us-ascii?Q?HSmX/6QYg4up+3OTyM0dBK0TJuEy3ZzWaCY8890Og91rqzMxo7M9d9FZDoqx?=
 =?us-ascii?Q?GmNApL0iwkhKjxorxrjtsmG79sJrzlIvekvgVlO8z0uAkdWikAhQuLjn92L4?=
 =?us-ascii?Q?Py+J64oEr90tZeGP6qJqlBRREG2t2cc27fNI/P5Reluk8Gdqu9dYQNn57gX7?=
 =?us-ascii?Q?jwu2ohHnPzGuUzB5TzRd5sK8FBMrKVyIK3cWrgvG0bu2n0eznq6w1xM4tDC/?=
 =?us-ascii?Q?bGL0aS9letej3FauNhtEhfT/ZtWOwKaL2y2Nt6xuqjqnWi1vnBZhNhJ1vLV9?=
 =?us-ascii?Q?dN21U1gLWKby4E7aNzCXoYr0r5DHupPXNWWh6Fw26v3lDhBA+gyAsEf/zvuM?=
 =?us-ascii?Q?30Ul315K/OON9r5Y9OCuuysAvCEXqTpwNTvY6sdMdbD9W5RTfVNg7XIvFa9Z?=
 =?us-ascii?Q?iYTEjWTDtuQrb2Qhv2MaVPSwFRTRhNw+de+NKUc0jKo0pFzT1vr/WNQKwut/?=
 =?us-ascii?Q?oe7ICcsetT8krN1jNbD4EDzXgin/oHZPK48ccPHwXElSrc2VvdJuZ1sXbeEm?=
 =?us-ascii?Q?nTLSXVhTHe3vtHVvPdkUJykd5/LstEcmyfD+pKNl1QAKP5sLxh60E1eEv8eM?=
 =?us-ascii?Q?L/EyV/uvXVJnPteMXiahsQPSmIJ9suAoRBND+DAa9bS4AnkeiouuNE+PR7fK?=
 =?us-ascii?Q?mE23VbupwiuOcVKgr9dIaiRd+SxXpc3PLq8k0g8P8x7F6at7Kazr5eDLzvge?=
 =?us-ascii?Q?ZDrAcsorwZ4iGMxXFmMC3m521OC0eAue6Z5yQzdYr8CmRIDfcA3vlLJFgtBK?=
 =?us-ascii?Q?TTSpmTBCnJ2C2xF171O5tnsTCneH5IRMn3ufC2dLaRMM6NDPWEH7ID/JfilQ?=
 =?us-ascii?Q?2vbOCWVAd+um3Ze0qtOTZYh5EWawbweQzHHBGt4deD1eW/cNoq/0bhmlUL/p?=
 =?us-ascii?Q?2bWNevRgCBPlG/IGbV/ncD9zUfwzOCLpMW5Eajduslj9ujgjO4keETVGUu5U?=
 =?us-ascii?Q?IdAJrsX+BhCDwyc4kVhxBchqAfzKv10EQ1uGx0ciwXZ7XIWMzzM/NjdxKBlt?=
 =?us-ascii?Q?zNV8r4cRjOEd7/kpIsF58o1Dt9LRNS9cxFBc1lvCBPVJCylBR4Wt96zwDOzH?=
 =?us-ascii?Q?JaXBOHMWTQpjgEwfMnn+QUIVpE11KTIWCE1v9e3LQCh5fvUfYlnsTy08ya55?=
 =?us-ascii?Q?3nAVZGxSMTnaRLay4k9ztCRnXTFvTLPM9gWbh30I80yvi0kXDveHSVHuSRxP?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Er1rv8oBqwMITXwUPbkPqQgEbiOe1Fs0mUASqgZVF7JNpHh9NZ+oDfXvuSUcD5kH/dnyrQwWwiXPpk8i4EAMxVqi9tJ3bAyHgBu0p+gR7EGQkIXASiZBOAM1JrPzqX6uqSOsAafEjADBn7yU9mAEqKSFO8XRghhz91KQt8rEY7B39H/cYhLaXJyT+XwsA+333Hdx3zfQ5RFXcszu71V5bLM32Vhr6Ws3r61bd7vY0VMRS5cXgU8qaF+yz6PWLOY6MBgZgSGkmnuSjDlfCJfzpB+9sFI3yDxyYrgGw9YDXdmjL3kOBJw/6MuTtvwdb+oedqSw4anmkcFgwCShwyMkLV11SxrXTlaM1ccamrgoXC1ldelEIE4yhXaDJGBy6jmdW17VQ59hVgGTfgXKGRoQjv7aEc2XKFQK6xCwSQhuevTpMfjH+OC9zs3mKjXx8BKZu77C4l41wTjLuit94GMVReL9HQ849p5RURQus4U4KoYz5+L677gKIQBfid9fUlU1RlgSten3DCkUA5owtrHBwee61UufTSYKKSAr8ZIIyhsU6cn5OxhW2W7a82AUR7G2CzIzAlvwX572ZoNTYye8syXVVeSWpZKbYmRphTTd6Gg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442d7ab7-3385-42aa-4c0f-08dc8a81ce8e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 01:48:50.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ns0ZMjj9bm0dyKLV7S0Dx9f6c/Pglal5zn5W8y1VdMQzwFepHZa92LiY7wo0u8sYcSlDe619HcNvQWcWgotcfPKwaCALezJSDtOTxPJpkic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_13,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406120010
X-Proofpoint-GUID: pwvcx6CSUj9D31uOyMlfNcyj91M4ULbx
X-Proofpoint-ORIG-GUID: pwvcx6CSUj9D31uOyMlfNcyj91M4ULbx


Hi Bart!

> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index b31464740f6c..9a7185c68872 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -79,6 +79,8 @@ static int slave_alloc (struct scsi_device *sdev)
>  	if (us->protocol == USB_PR_BULK && us->max_lun > 0)
>  		sdev->sdev_bflags |= BLIST_FORCELUN;
>
> +	sdev->sdev_bflags |= BLIST_SKIP_IO_HINTS;
> +

I suspect this is the safest approach and prefer it over the individual
device quirk.

-- 
Martin K. Petersen	Oracle Linux Engineering

