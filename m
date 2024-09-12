Return-Path: <linux-fsdevel+bounces-29178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D91976B68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 16:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E214AB20BC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9041AD9FD;
	Thu, 12 Sep 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P1oG6c3f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R2bZ7oyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE01A0BDC;
	Thu, 12 Sep 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149738; cv=fail; b=AwitJlFJ7+VAzf4wub0i45IeMYXNK1lKwIHLEy3efPLW3L518KLgOtBq5PoMO4va9vAKQHKM/6LVvyT99uCm2KaF309TOD/C2My3cUQsAlPGwcjgsCwLcvsYazD+BgDD1nqOYxA3zC0TYDM/TR59e9nMaa9tiJv2kdIMi072iv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149738; c=relaxed/simple;
	bh=wtF9A6V1qV72UxrxvJisf93qf8rw7PWHq8IGrx87Eis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SVtu4QoJPHcS6I2B9Nyg9ahiqakz2s4KD0Ck70SyEk1ojNEjaCKp7iIs1flx0VHGo5ftHxSUVfk/hmluwZlRn7GD7bTD4w++i91sZW+y44KrHdWxp+wsyKYOp4Ql0nycu/qpVQWDOe1qr75vKVWRz8b+yuLfDP4MJsjGt4wJstI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P1oG6c3f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R2bZ7oyq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CDtxTh007136;
	Thu, 12 Sep 2024 14:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=wtF9A6V1qV72UxrxvJisf93qf8rw7PWHq8IGrx87E
	is=; b=P1oG6c3fUyHgBUWVngnw3oun66+/ErqANd7Y+KpRn9mB+6nOYZ0mMXla4
	MywmEMfMZlE/dE/JL+DUQhXKXJ07l2vv/nVBCIJ53O7fdda6jdjV2QnAx0IzR/rN
	e4c90/q41OI1DLvn50duLWZmTC6PUsmsb70W/0Bl+Oans0AduxSMAef32bKCPRU2
	MP4DEd5yWDO1Q0MdeySlRSpphmP8nKD4FT7xorg9tBsTqBKV80LbXvjSp1uLVzcw
	1A3Lf5Yph+ZHXK4gv2FLEYiJlgjcWPxExZ7mINRwEUp548+E8IGnWuovpupbtFsq
	Kba/DC6REbtGqZdieVB7ysrPjj54w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrbaydv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 14:01:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48CE1OX1040956;
	Thu, 12 Sep 2024 14:01:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9cxt0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 14:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ45B14EX39o0+W/KQ1+k/SfEh7L9Ah7MytYKpZ1PzukFMJiPomBi7OtmOfa6YoiqodljZKSXQxwDHtLPSs9GvSGSHQi+OPFnf/jaZEjSx8ivyl3RFwfe+i0ViQ0wPsqWqsyE+rbJ64C7aDTOVn6ZaaRoQIn63wyYMorzQ4f78NB4VWJc8Vsn2e1xA7oca5dnvjIGYWUbSjAbOlSWgIIuKEIj16gzpWKZHABIGXy0AK0t+/020MFQqMNpsc/FxqgvsMlyMpXhaGPAxVVyNdNmF0sf8c36knz/IW6d2sIjyV3URVg3fgOTX5drOtvWq4pYehjYhrP8NT37V1/YCu1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtF9A6V1qV72UxrxvJisf93qf8rw7PWHq8IGrx87Eis=;
 b=SjofuK0eByZdyR+IFJsqhdRfaLeZzaegVMKU85hQn3Zr5AbvfHtLPbqST1HiUcovr8UwWn6ByuNkezPBxqeQ6qzynLWloFvaX3a6abIfw0lE+tznLnRc938D66YRyV/iEFKsKwyewNXtzNjTX1eiF+tFfnhDFSmPCzf0HbdVWY37Etu1i4E0ZGL8/iACDvc19bC8qXz6SoR3UNtrqriieZcbxgJb2YSMKE8pwbhqJ8sPeWA4LQ8jdqxCcVTwGWOPx+xO9ZXgtYa65CXftnsmQzUrnfeE//WWuf4g0tq4f9sGJcBIXH0JbvH82zwZd8VYBLNsz+Q5udVPP5eNJ0JTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtF9A6V1qV72UxrxvJisf93qf8rw7PWHq8IGrx87Eis=;
 b=R2bZ7oyq2l2qT7rXSp3hu2Bz/gSFD9aS6hOduQSXm1U6tlKfE1IkVTnEP3kCNVSD9NiarsOJIvXrVrTvMjLM0PTXchBp00TA4s/8aaFqKb0mqi6rkm7rDfMuDYA08fnuTHMcYOXxmIq7JIJ3e07DFC14fsxJMdKbL4TH2VIKrg8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4888.namprd10.prod.outlook.com (2603:10b6:408:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.8; Thu, 12 Sep
 2024 14:01:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.003; Thu, 12 Sep 2024
 14:01:27 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>,
        Christian Brauner
	<brauner@kernel.org>
CC: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
        Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
        Anna
 Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andreas
 Gruenbacher <agruenba@redhat.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker
	<jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Al Viro
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Alexander Ahring Oder
 Aring <aahringo@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>,
        "gfs2@lists.linux.dev"
	<gfs2@lists.linux.dev>,
        "ocfs2-devel@lists.linux.dev"
	<ocfs2-devel@lists.linux.dev>
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Thread-Topic: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Thread-Index: AQHbBILbIkQ42h8MOEqBVgYVsg2/vbJUL3IA
Date: Thu, 12 Sep 2024 14:01:27 +0000
Message-ID: <244954CF-C177-406C-9CAC-6F62D65C94DE@oracle.com>
References: <cover.1726083391.git.bcodding@redhat.com>
In-Reply-To: <cover.1726083391.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB4888:EE_
x-ms-office365-filtering-correlation-id: d64ea8d7-01f6-4337-e923-08dcd333652c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlVqb0lmNm9iUmxYTUtHS1g3bld1a0owYVRSVGdsamVSV2k4aG5KWHB4bDNR?=
 =?utf-8?B?STNyYWorNGd3dVArUUhtcWNFU2lOZVozYnhHUVhMd3JWUDdoM3p1ZFhSSnBi?=
 =?utf-8?B?MWtoVlRQNDduS1hReElIc2VrMXB5ZVZ5U3VsUnNzMzdLQUsrY0g1UWxacEtT?=
 =?utf-8?B?Q1llNDh2YnJ2cVFCaFlLZTkxRmVhUmw3YTVueUNTNWpVYUI2dzhyeUpVQ2Zk?=
 =?utf-8?B?dEtHL3NZWGNFY25kcVQyYzlBWkNHUCthdGg3S0lMaGRDRS92VEpTcFpscVh4?=
 =?utf-8?B?QW5zbU5aRDVHank3bHhDZDhwYURuVnRKb25NZzNMZXBXa3dURTBWWWN4ckJM?=
 =?utf-8?B?WXhoUHhqSWdEWlFaWVBscTVMRXRUUFdKeDZFYUtHaHl5VXVMWFQ5b1hKbmpS?=
 =?utf-8?B?SWlBdFExeUgyaFVXOHRocnhMOWZ4cEQyUDQyeDZJMTB4eEp6czlMckZTNVpL?=
 =?utf-8?B?QUZ5WWI1ZUppUlIvem50aGYwb0x1MjFJTWJPcmE2OFdlWWlLTEpkdXpaUUFU?=
 =?utf-8?B?YWM4anNuRXAxeHloV3A5cDZtakhxV2F3b21qbHJXQTlvR2g0N040dEdUdndw?=
 =?utf-8?B?ck8yQVFDa1dnUnBZVGdYRURoYVVseFB6NDg1MGJaNUk1aEkzYlB6WncrdWNo?=
 =?utf-8?B?WTl3YmVVMGFLZ0hFaEdESXNaVWRNNlk2amlERFFmWjk5V3NJVmt0N1pVenNm?=
 =?utf-8?B?TWpYMmJFbHE5MXVlSWtEdGZpdTFKeURaZm5PbFNDclU0Y3hkRUFrYlZibkc5?=
 =?utf-8?B?NFg5ak5xT3BPcU53SHBQK0V1VzkwODNMWUthMm5CRzFMams4WXV5akkwaG5k?=
 =?utf-8?B?RzF4bmh1UnIzQ3lDYllZMXkyUllTWG85K045d3FIcFJpa0c4QUR2YnRYb3Zv?=
 =?utf-8?B?ZkhWTXR1UXJXQnFITk9la3BXTXVETGZCS3VFUjNneTRpczlQb1c0SDUzS2JJ?=
 =?utf-8?B?ZzFvU0dwUTZTQnh6OWdsT0hXajBWZ2pHa0NNMm5TR2FJVVA4bFRncFFOKzE5?=
 =?utf-8?B?Z2xrNG0zcFN3bFFJdFpYV2RFTWJlL0ZEdVcwR0tIeUhaTWZkVFh3eEwvNTc1?=
 =?utf-8?B?ckxJS1E4UCs5d1lUUGR3Y2h1aTlpUlpRbC9EQ3NCRStwVjhzTVRDQWFEUGVX?=
 =?utf-8?B?TnNybnhKemswdUUxYnc1VEtSRW5FS1dHK0FqVFkra3FoRkFQejBiM1lJbDZl?=
 =?utf-8?B?S1BxWEYwUjltUzBRaHlycVViRVJXRDliVE5QeXJsVFFQaWRFODZadkZWdHly?=
 =?utf-8?B?SUg3WXRPWXYxTmlRZjhDNVQ1bkFFcldQblJiSGp3R2RTaXN2a216RlhIWUNr?=
 =?utf-8?B?UHMvWE9PZ0wrVGFIQmFSZjRRb1liVFVNWW5sNVN2NEVRUUpabUZGU3JtRFRi?=
 =?utf-8?B?ZkZvbW9CZXd6OGtzTXBZQmRDQWNyajQ3VEp3NGZscVlJQk9URFROdTJDb2k2?=
 =?utf-8?B?WTJ5R0ppNnNMc2FBS1RudlhtRUQ1elhSRG1USXQrVXhsVGNlRmpRc0tIYlR5?=
 =?utf-8?B?YlcyVHV6cVBhMW1FVjZFd1FEKzBYU3FkUlZicklCUFN5K1dPMmIrRnltZTMy?=
 =?utf-8?B?ek1wV1Rrak9PT0h4aTR5TWpVbDd6QkhyOGZGYnRRc3lxNW9nSkkxM0pmWVYz?=
 =?utf-8?B?eHVZYTRzaWt0aU1QWDdYdi8wR1phOEF2L3M2U2Q4SnNGZFJrMnNJMElwM1Z5?=
 =?utf-8?B?cStNelltek0zYUpDaDJaa1hGKzlzNEFaQWFuV2tuNHdsZ2dXSjNlb2JZWnBY?=
 =?utf-8?B?NUZNL0gxbFp4VHNPUEtYTHlWQjJqMEphVllDRVBGVFVTN2w5Ujd0VU44MHZX?=
 =?utf-8?B?cTBIN0NDNkVtT3JiTi83RiswdFUxZEhpaitzSld1N0FXd1BkRnl2UXkwYktM?=
 =?utf-8?B?bDZGQ1J0SlRLLzZncEFuK3Rpa21jUXlERE1IbGFDZEowUFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVJhWmMzeVY4SFdoMUxobThjbkpTNFBqemZhajUwY0JOSitpOEIzNWdXc0pJ?=
 =?utf-8?B?L21Xem1XV0VuR2daTEJTNHBYbXBvbTBiZ1FYNndQSVJjSThtQmJtaVRPWWla?=
 =?utf-8?B?ZGQyS2M5S1lBNmZhZWJmUWpOTXYxc3l5QTFUSGgyb0NBUDZnVnVHRkh0TGp0?=
 =?utf-8?B?VHlWYyt4WVRteUhZNlZudnp1TEJRd0hEQ1hPZ3Y5WVozSmJuQnZXVHhKVndR?=
 =?utf-8?B?SzFzU0VVcWlsSWNHKzRGOG9jN24vVW0zUlJlQW5NU1g1eE41ejRUVW5HQjVO?=
 =?utf-8?B?TksyMFlnM2dHR0VrM0hBMkxuYjlHUzlMOWRyUlVmL2pCdUJuc2FJQTNqSnBK?=
 =?utf-8?B?MFhlQUh3d1RpS1hJUzdSSVd2M3YrWUJLOUY3clUyYnRQUXg0ekxUMHhvMkpW?=
 =?utf-8?B?Y2RCQVhkaS9tbkppQ3psV2RMbW5aTVNJQ1NJd25SZzNGMTAzNU1qdDhYM09p?=
 =?utf-8?B?RmpMYnU3Yk5xc3F4b2RrbUVNeWV0eUFjblFQekZIMkVONmNtQk1qUFZmV1NR?=
 =?utf-8?B?STNLcFhUSkd5ZWdtbmttcStrcExXdWd5MFpRRW5KTk1QSnRQUHlGYW9ycW5G?=
 =?utf-8?B?QmticlFtc1VYbm9FaGMyMGNmRjMxczBhSjFUbUhoQ1JBZUFTdVpWQUJQWm9X?=
 =?utf-8?B?eThxbjhDRUZOUDdwUmYwcEd2OVFYd0dMRllBTjUvcERObm9IV0hUWFp2bE1t?=
 =?utf-8?B?eUJZaWJXS0M4WWFNYWV3V2JXaHVYVjY5anFpYlhtVTdSNEVyakx2dHZCUS84?=
 =?utf-8?B?TVFQdm9idkFRazBtcVVMS2poZFllSmNNanJmRUJEVmlqNGo1YkJYeXFJNHV2?=
 =?utf-8?B?ME16UmQ2OFJXZlJ2WWJEZ2UraUFtSytPRThoejdJNmFEK2JFaUliS0RPY1FX?=
 =?utf-8?B?aFIwNzNWNGI3Q3FUbDJ3cTBTcFRVc2h6VnV2clo3RURDLzdCcmc5dXlYcnJB?=
 =?utf-8?B?SzE5d0hYRkU0UXlkREhLWUsvQjFQS3Z3YkJJN0RKQWpLNTVIQWg2T3RxNW9z?=
 =?utf-8?B?d0IxdGV2MTJqVzh4NDlsZDdlVitrOTd6ZXM2R0E2Uno5U0VwdW00RGlhZEhV?=
 =?utf-8?B?amh0K3dxS3h4VDNIOEdLZW1sVS9mWHV5bjFOZGZsMmo5THRoUDZVYk5OL0FY?=
 =?utf-8?B?ODFScnloWVhvWFZKMUdQeUwzc2Z0WVJ1VXdDb2pGVFR5bGx5T0UvVHJmclBC?=
 =?utf-8?B?dFBrcnhIa0NpRjFDZyt3T3BWRVpZcERaZEo0K3pGUFZ0Ymp5dXllbzJkK0Zo?=
 =?utf-8?B?NmgyS1NsK0hDaGVvdjlTUXhJaEJ0RWpPZERSYkREOUpCSVM3Wk83Q1B3QlpG?=
 =?utf-8?B?VUZrNTRnYVEvbDEzTDNNdS9aTURTUk9GaFlGcTc0eUovTG0yNXp2YkpNai9M?=
 =?utf-8?B?Q0xJSWYreVpHZFlsc0VqQmdIbUxEZVIyZ3ZXa2R0bmYvc3plZHllejhUaWh3?=
 =?utf-8?B?QzAwUVIwTDFaSjlnYWwzTGRjR1ZXQzlIZ2YyWUhlSmwxYldaZ2NGUFk5dzcx?=
 =?utf-8?B?eTRkMmZaU1NkT2RTOVhYZ1BXek4wcmhLZUk2SERUWU1UZjczVGlNTFRmUXdn?=
 =?utf-8?B?YUZXL1p5NnN0eGx3MnMwMTc0dHJKVmhra0RnNkVoUis1SnovUnZjWVVHcUxW?=
 =?utf-8?B?MnlOeGhPY05QQjdrdGdZYldOTmk5cUpBK3Q3RDh6SmpKMmliMXJpTGRkZW9W?=
 =?utf-8?B?N1drRm9YdGRJRXFJeFV0cTdhUHBxRFBCUXU4L01LNHRtRnN0a2JVM0NxR2xz?=
 =?utf-8?B?OGhWNkJtU0NLRkZ6Y2Y4b2JseWtiSFVhM21OZHhHMGNtKytOMlhURklTd3I2?=
 =?utf-8?B?WVY2SFZHNGd3MUMrSHE0TllFOXBWTkZGTVplQmhzMzJMYnBTTlB2R1duUG1m?=
 =?utf-8?B?cFFiNEtjeHRwaEc4VmpOc2V1aWZobXVSQmRjOSt1Z2s2Qk93Q0YrYldsSUlp?=
 =?utf-8?B?T3BKRmJVUXo1MG9YMk5JS2FIRHd3aVZGRVJjRXMzbWk1SGRkcFVqZktrTnRW?=
 =?utf-8?B?aGwya2ZrVmlTTHhHVjdHcWdjT09rSkVJcXRENlkwbElCVVNVNmJHc3d5SW1K?=
 =?utf-8?B?cHFNTFZhNEpBcXhuM3RUSlpTYklwNVY1N3pMMWFZRE1rb1MraXh1K0VabXJC?=
 =?utf-8?B?TDB6TWJXcyswRElJdTc5aVJGYzd3bjkxMGl2b2ZRcmxUUk9BekJHVWdyNTVW?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <626DD2499A07A349BCE9BE7394144920@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IhPOJb2tmT13ZHnq0rhrpvxCM6cavx0UK9gfexH0CaDaV8GJHBoXA/ArqlQZixxhf+q44NLHBMnuV43iw8S93pKiNYYnUsUXGXpu0wRot/jks/yvkUBOz7ll7FWN1VrS0pwiQ1vd+NbPpykRi5br1Yr0BdgTnIdJ1VOKCYp/1a7bHP2GZrfl6fHH24OmfNOqJS1oobQaPHapkbphi7rxgmTje/vmHLNfhVj9i8f52zHco/m9DCA4DSzCVcAoQxF9PK69VRWmExeml0XJD33msktaHbO27O1bbcZaz2e0MgQfFhdmfOLMRJvg1xHijlaq1xROOkMUpizlTgmEcTFc/sdY12RHe1jEtncjxbuuRxJbSe4JL+l8vp51UaLgDJGDnNnjZKyAuheAXHk1YAndhBX1DKbg2Rghmf+q4zdCAKENXRzuSzcECijP22vFRWT1sb23SFJRg5hGD5Yt7Kf80UUmm/F70B5BrF/ZTWlgSSazB5yXixMfrMy4rRBFBj7zZecghbEN7WfiIN75rPGrprwUbfhLr4LsphopaZF0W5wJ5/w84XQI6NfYGtxTFs8KpVXyXxwv2FgC6UaQSb2KZwFj5XTP2aNGhstjBA8TjhM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64ea8d7-01f6-4337-e923-08dcd333652c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 14:01:27.3783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ak45rL6aIZNlGq/RRaiUzWmeeaJEClG1i9uEXCoXf2091Y1YZtdHzbFxzKYNHIwOhW+ypiA3URDqzDcPO+qD1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_03,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120101
X-Proofpoint-ORIG-GUID: R20baNV52hgzh8W0Ep9gYW609svOwxXH
X-Proofpoint-GUID: R20baNV52hgzh8W0Ep9gYW609svOwxXH

DQoNCj4gT24gU2VwIDExLCAyMDI0LCBhdCAzOjQy4oCvUE0sIEJlbmphbWluIENvZGRpbmd0b24g
PGJjb2RkaW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gTGFzdCB5ZWFyIGJvdGggR0ZTMiBh
bmQgT0NGUzIgaGFkIHNvbWUgd29yayBkb25lIHRvIG1ha2UgdGhlaXIgbG9ja2luZyBtb3JlDQo+
IHJvYnVzdCB3aGVuIGV4cG9ydGVkIG92ZXIgTkZTLiAgVW5mb3J0dW5hdGVseSwgcGFydCBvZiB0
aGF0IHdvcmsgY2F1c2VkIGJvdGgNCj4gTkxNIChmb3IgTkZTIHYzIGV4cG9ydHMpIGFuZCBrTkZT
RCAoZm9yIE5GU3Y0LjErIGV4cG9ydHMpIHRvIG5vIGxvbmdlciBzZW5kDQo+IGxvY2sgbm90aWZp
Y2F0aW9ucyB0byBjbGllbnRzLg0KPiANCj4gVGhpcyBpbiBpdHNlbGYgaXMgbm90IGEgaHVnZSBw
cm9ibGVtIGJlY2F1c2UgbW9zdCBORlMgY2xpZW50cyB3aWxsIHN0aWxsDQo+IHBvbGwgdGhlIHNl
cnZlciBpbiBvcmRlciB0byBhY3F1aXJlIGEgY29uZmxpY3RlZCBsb2NrLCBidXQgbm93IHRoYXQg
SSd2ZQ0KPiBub3RpY2VkIGl0IEkgY2FuJ3QgaGVscCBidXQgdHJ5IHRvIGZpeCBpdCBiZWNhdXNl
IHRoZXJlIGFyZSBiaWcgYWR2YW50YWdlcw0KPiBmb3Igc2V0dXBzIHRoYXQgbWlnaHQgZGVwZW5k
IG9uIHRpbWVseSBsb2NrIG5vdGlmaWNhdGlvbnMsIGFuZCB3ZSd2ZQ0KPiBzdXBwb3J0ZWQgdGhh
dCBhcyBhIGZlYXR1cmUgZm9yIGEgbG9uZyB0aW1lLg0KPiANCj4gSXRzIGltcG9ydGFudCBmb3Ig
TkxNIGFuZCBrTkZTRCB0aGF0IHRoZXkgZG8gbm90IGJsb2NrIHRoZWlyIGtlcm5lbCB0aHJlYWRz
DQo+IGluc2lkZSBmaWxlc3lzdGVtJ3MgZmlsZV9sb2NrIGltcGxlbWVudGF0aW9ucyBiZWNhdXNl
IHRoYXQgY2FuIHByb2R1Y2UNCj4gZGVhZGxvY2tzLiAgV2UgdXNlZCB0byBtYWtlIHN1cmUgb2Yg
dGhpcyBieSBvbmx5IHRydXN0aW5nIHRoYXQNCj4gcG9zaXhfbG9ja19maWxlKCkgY2FuIGNvcnJl
Y3RseSBoYW5kbGUgYmxvY2tpbmcgbG9jayBjYWxscyBhc3luY2hyb25vdXNseSwNCj4gc28gdGhl
IGxvY2sgbWFuYWdlcnMgd291bGQgb25seSBzZXR1cCB0aGVpciBmaWxlX2xvY2sgcmVxdWVzdHMg
Zm9yIGFzeW5jDQo+IGNhbGxiYWNrcyBpZiB0aGUgZmlsZXN5c3RlbSBkaWQgbm90IGRlZmluZSBp
dHMgb3duIGxvY2soKSBmaWxlIG9wZXJhdGlvbi4NCj4gDQo+IEhvd2V2ZXIsIHdoZW4gR0ZTMiBh
bmQgT0NGUzIgZ3JldyB0aGUgY2FwYWJpbGl0eSB0byBjb3JyZWN0bHkNCj4gaGFuZGxlIGJsb2Nr
aW5nIGxvY2sgcmVxdWVzdHMgYXN5bmNocm9ub3VzbHksIHRoZXkgc3RhcnRlZCBzaWduYWxsaW5n
IHRoaXMNCj4gYmVoYXZpb3Igd2l0aCBFWFBPUlRfT1BfQVNZTkNfTE9DSywgYW5kIHRoZSBjaGVj
ayBmb3IgYWxzbyB0cnVzdGluZw0KPiBwb3NpeF9sb2NrX2ZpbGUoKSB3YXMgaW5hZHZlcnRlbnRs
eSBkcm9wcGVkLCBzbyBub3cgbW9zdCBmaWxlc3lzdGVtcyBubw0KPiBsb25nZXIgcHJvZHVjZSBs
b2NrIG5vdGlmaWNhdGlvbnMgd2hlbiBleHBvcnRlZCBvdmVyIE5GUy4NCj4gDQo+IEkgdHJpZWQg
dG8gZml4IHRoaXMgYnkgc2ltcGx5IGluY2x1ZGluZyB0aGUgb2xkIGNoZWNrIGZvciBsb2NrKCks
IGJ1dCB0aGUNCj4gcmVzdWx0aW5nIGluY2x1ZGUgbWVzcyBhbmQgbGF5ZXJpbmcgdmlvbGF0aW9u
cyB3YXMgbW9yZSB0aGFuIEkgY291bGQgYWNjZXB0Lg0KPiBUaGVyZSdzIGEgbXVjaCBjbGVhbmVy
IHdheSBwcmVzZW50ZWQgaGVyZSB1c2luZyBhbiBmb3BfZmxhZywgd2hpY2ggd2hpbGUNCj4gcG90
ZW50aWFsbHkgZmxhZy1ncmVlZHksIGdyZWF0bHkgc2ltcGxpZmllcyB0aGUgcHJvYmxlbSBhbmQg
Z3Jvb21zIHRoZQ0KPiB3YXkgZm9yIGZ1dHVyZSB1c2VzIGJ5IGJvdGggZmlsZXN5c3RlbXMgYW5k
IGxvY2sgbWFuYWdlcnMgYWxpa2UuDQo+IA0KPiBDcml0aWNpc20gd2VsY29tZWQsDQo+IEJlbg0K
PiANCj4gQmVuamFtaW4gQ29kZGluZ3RvbiAoNCk6DQo+ICBmczogSW50cm9kdWNlIEZPUF9BU1lO
Q19MT0NLDQo+ICBnZnMyL29jZnMyOiBzZXQgRk9QX0FTWU5DX0xPQ0sNCj4gIE5MTS9ORlNEOiBG
aXggbG9jayBub3RpZmljYXRpb25zIGZvciBhc3luYy1jYXBhYmxlIGZpbGVzeXN0ZW1zDQo+ICBl
eHBvcnRmczogUmVtb3ZlIEVYUE9SVF9PUF9BU1lOQ19MT0NLDQo+IA0KPiBEb2N1bWVudGF0aW9u
L2ZpbGVzeXN0ZW1zL25mcy9leHBvcnRpbmcucnN0IHwgIDcgLS0tLS0tLQ0KPiBmcy9nZnMyL2V4
cG9ydC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgLQ0KPiBmcy9nZnMyL2ZpbGUu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKysNCj4gZnMvbG9ja2Qvc3ZjbG9j
ay5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrLS0tDQo+IGZzL25mc2QvbmZzNHN0
YXRlLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAxOSArKysrLS0tLS0tLS0tLS0tLS0tDQo+
IGZzL29jZnMyL2V4cG9ydC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSAtDQo+IGZz
L29jZnMyL2ZpbGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArKw0KPiBpbmNs
dWRlL2xpbnV4L2V4cG9ydGZzLmggICAgICAgICAgICAgICAgICAgIHwgMTMgLS0tLS0tLS0tLS0t
LQ0KPiBpbmNsdWRlL2xpbnV4L2ZpbGVsb2NrLmggICAgICAgICAgICAgICAgICAgIHwgIDUgKysr
KysNCj4gaW5jbHVkZS9saW51eC9mcy5oICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsr
DQo+IDEwIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQ0K
PiANCj4gLS0gDQo+IDIuNDQuMA0KPiANCg0KRm9yIHRoZSBORlNEIGFuZCBleHBvcnRmcyBodW5r
czoNCg0KQWNrZWQtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tIDxtYWls
dG86Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4+DQoNCiJsb2NrZDogaW50cm9kdWNlIHNhZmUgYXN5
bmMgbG9jayBvcCIgaXMgaW4gdjYuMTAuIERvZXMgdGhpcw0Kc2VyaWVzIG5lZWQgdG8gYmUgYmFj
a3BvcnRlZCB0byB2Ni4xMC55ID8gU2hvdWxkIHRoZSBzZXJpZXMNCmhhdmUgIkZpeGVzOiAyZGQx
MGRlOGU2YmMgKCJsb2NrZDogaW50cm9kdWNlIHNhZmUgYXN5bmMgbG9jaw0KIG9wIikiID8NCg0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

