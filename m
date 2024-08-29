Return-Path: <linux-fsdevel+bounces-27946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84C964E5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE58B21EE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD11B9B3B;
	Thu, 29 Aug 2024 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YI32fkpn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NPgR6Lgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7291B375A;
	Thu, 29 Aug 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958166; cv=fail; b=TIrTYAA2kKp0V5TZrU154Wx/dJQtIQ62lP42KoLuRhGfODLHLh7sOkeCcUzQ9F5T16WnXWkoYvbgKeGHQyFb7fthsK43Wh2lRkebO2Vm6roXQ6IN4OzoXrhkuV+3CvevZr/9BVGt8bSnvxwToY/XLrIH1lqiI/1fkGM6U0gbemw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958166; c=relaxed/simple;
	bh=HS99S7fHYhINzkGtWM7zQ7QszfmV+UGSQ5jvf3mH9Eg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MjYQgBT0CYNRRf+lGjuJVhBvq1DXYJ/XCadQ7i1KHgAAz8yTDnjsuIJAX2RNyWgZFL9Meh0rwihGnhDH0gypv5Zkm0kXEYQVkM2huOqwdC5tWY/UdlEynPEedNcu4M3E7dQeC0i/Owui/2bZTpt8ku5fR62xNcwbyWQVd6YLupU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YI32fkpn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NPgR6Lgb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIQTH6012244;
	Thu, 29 Aug 2024 19:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=HS99S7fHYhINzkGtWM7zQ7QszfmV+UGSQ5jvf3mH9
	Eg=; b=YI32fkpnH8mTyYE3bWBOaY21PAAYfGQXB20Naxgn164O94QsijTiysJ0Y
	W9/Tf3TvqTC1BUQ4tEGJAyAWQ3JoHHb+ZOKqAkMe8XpTM2EwRh+II6m8v7SpH2dU
	+X+GxDBN8JRCqYOVA+jbxbViqkovLTHY6WS9Lou6+HOgaDDrNs10TU44d4/N+kum
	NKlazESuyug+vckN3dyazMmF5e30zFEmWBSJ9vqxemlJVdNGYBSCbW5EYfjm4XFk
	g5ADihSAZiBGwt/jSw4bX3tk9dBsGSF+qOAUQ/CBX9q+qJdSJMuhd3G5dTJGveRp
	u7TweofvalYTQx+agvXRyu2veFEYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugw35b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 19:02:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIMUx0009922;
	Thu, 29 Aug 2024 19:02:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894r4rb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 19:02:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFLyoYh74GTrUeHIC7ua8szWb+xLLyBHPUkO24kBDL/813G2QSqGBJPvcJUbxwqFmWDEGiVCfO38Cd3QxGhIc0FQffTQS+sWF/L485maChtE+SYcT2nWVmMQuyM+wZ7rFGJqQ/N+2HJC3mkUTGtHviiArkLLj/EqLLwguucERNXsCMW/nOL1m6zK34mEZBILuDpVht5P6NK4oaWWO0Ak2Jra0Vnv1iZvkbIsrUhargOBxX2FKiHgX1aVF5Gk5PxaUho13UP1GHQAAxs6f9X9p7DgRIA65mkYuPotKx7EYrWdtG+vOwzGFI/tbcZpQERuFXaGLdxKL3rblXo2TOCdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS99S7fHYhINzkGtWM7zQ7QszfmV+UGSQ5jvf3mH9Eg=;
 b=TcwbLbE6fKpq43nUpW2pI02psGrxkkRoU+H2YzpBcmnhTDqSi3fwh7SDDacR8bs8oODR5ayXZlSzjW7Xi8J/gLvcRk3tgQkKx2APO6frp8jtk+0/AosCQGQ8VTgKkkGGwJ93VI6/6kk31fP7agLTNA1OYtqfecCHKLxSHNIsDe7C3oehSuezGufszB7niULNy+1pEOP9aDQ8UnQtNgvz0+h5gT6xJGJA7LubChNPDnNxugB3lcd9nM4314hEEXbGUIaNIbYqld9EaA9HBeNUMStRgnDLhcgOS+mQZBnH44JfPS/aZ8faT998zLEBdr6EIRRb1k9rmP2kImUy+WQ+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS99S7fHYhINzkGtWM7zQ7QszfmV+UGSQ5jvf3mH9Eg=;
 b=NPgR6LgbABQQ54goSzA4oIq2ZSHNuhUch+8d6uYRVCJTxTYV+viKzXGtJWTnyj8VlvOf30mPpP50Nm/lh+YVGX0RwJ8X1P6b7kbHAuNICZ/JwyHgvPmKIS5d3J3DfmV4iZfWis9jeU2aVf3YWdq9gaYXFiGxcyCdT4pGz/wTOoI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6656.namprd10.prod.outlook.com (2603:10b6:303:227::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 19:02:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 19:02:19 +0000
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
Subject: Re: [PATCH v3 08/13] nfs_common: make nfs4.h include generated
 nfs4_1.h
Thread-Topic: [PATCH v3 08/13] nfs_common: make nfs4.h include generated
 nfs4_1.h
Thread-Index: AQHa+hcn/cl+v2A+90ShF1r0jeNPj7I+V+uAgAA15ACAAAnmAA==
Date: Thu, 29 Aug 2024 19:02:19 +0000
Message-ID: <5DFBDAE5-9272-4335-95FD-AD4F00326E43@oracle.com>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-8-271c60806c5d@kernel.org>
 <ZtCQLVAaotGRxLN2@tissot.1015granger.net>
 <14302177e5fd485a9f72879e7c5366ffc31f4e1d.camel@kernel.org>
In-Reply-To: <14302177e5fd485a9f72879e7c5366ffc31f4e1d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB6656:EE_
x-ms-office365-filtering-correlation-id: c3c3fc15-c3d6-44b1-0802-08dcc85d1b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVNQdXJWaTV1VTdPcWR1ZlIxeWpBcTBsN3JLV1RoUTg2K2R3S1lkdWdYVXZW?=
 =?utf-8?B?UXM3VzZBaGVOclhRZ25GK3lHQVg3di9OaWN2QWFuQTBsbDAxUm1QcXNUYmFJ?=
 =?utf-8?B?KzdBRkN6dTZvcFBTazBIbXQ2eXY0UFdseEV4S3dEUVRFZEg4cWFEa3luMDBx?=
 =?utf-8?B?V3JhVmExZGxiTVdLK1FiYkFSeXZGMTN3WU43T1RhTEIxemZTRjhzSkRlVzli?=
 =?utf-8?B?M3RoMlNhL0F1bElEcmVFaTkrd0NQVVJxWGV1SUlNcDdBYmtaWlJaOHJoVHpF?=
 =?utf-8?B?c0dReHlERU94eXV2MlgxWVJqbkdWSHlKUkE0RTNZRGZSdXRQenJlU0JGWUFC?=
 =?utf-8?B?ZVh6UVdpUC8yZVI5d21yNjFsbjk1ZVFtWmNBdmpZTnBKN2xTUjIzTldwMmZm?=
 =?utf-8?B?MWxVOXBZMVRYVENTN0k1UWNDOEFTbWRSbU1GSUYxOWR2M01OTk51K3d0U3VW?=
 =?utf-8?B?T2I1dGIvSVQ2NGNueE0rSHlsWEg4TzlMSWJVb3Z2MGY0K2V0TmNQUGtnckFQ?=
 =?utf-8?B?STdmSmNhemNSaklHVE5oUHJrWUFWeVNpMFM4Qm8xeU03OEFnaG9TK3dEc09F?=
 =?utf-8?B?VHNBZFVCQXRxNC9ReW9XbG13YVlUVEYxT3Z1aW1sNzdjWTN4U2FBSU9VdlJo?=
 =?utf-8?B?ZVpNY2JNSFV5dWdlM1pwaDZCZ0Z3SGh3SHV3TmhwWCtEalB6NllvY0ttNWRi?=
 =?utf-8?B?TE1Vc05JSHRFQzRiMHA1NlBLajhGNnptOExPM1ZXemJxWjhKRFdwOC8wMERT?=
 =?utf-8?B?REZ4a3M3bVplM3ZId3EzMHFlcE5ueHppZTdOVmhEVzJ2eEljK0xpRXBMb1ZX?=
 =?utf-8?B?Q3VSZXdXdkUwQ2J6NlZESW9ldUgxQUdMVEZJK0I1SmhpbG1aS3ByQ3F3NXRZ?=
 =?utf-8?B?QzZHN2psVWJWcGlvbWF4c1pQWkFGUWw4c0pZYUdlWEhoVmNVRGc2TzRvMlV6?=
 =?utf-8?B?bUc5c0xRLzNlL1d5anJNQU9CMkQvK0JtRnVTUU0wcktJUlNBUXhLUU5yL05y?=
 =?utf-8?B?MU1XQnVFRkJMSFNpUTNaajlsNWxXRENaUzNUQ1Q3bStHYVlobnorUXlvQ2Ri?=
 =?utf-8?B?WExXaE1ZWG5jZWx2MDh3NzdNTmVaMHB4T3pKRHhvcTBBT1JOeVhIaFhhMk1Q?=
 =?utf-8?B?UEN1ZjhHdzA5cW5WOTNrYjhnbzQ2b0tkTVR6UlJ0VXJuTklxZWxoZWVEeTJX?=
 =?utf-8?B?akRJMjI1SG1Bd3p0bkN0LzY0V1A1Uk9uSmJUQTNOWUs3QjBYMkxueG5kUnIv?=
 =?utf-8?B?VGR5ajNWZWoxRThUOHRLekRTNzM2bGRmajdwZlJDSVM4UU92SmR6ZGFCSHlO?=
 =?utf-8?B?ZTFxeXBvZm9TYlMycUxkcStVNnFZM0JJUHB6SERGYnBMOFBkQXN3ZzU0VVph?=
 =?utf-8?B?cWZqTzlmRnBLME5CZEttNjJDaGh6c3VHcmpONStEczBBUTYwaGhWZWd3ZlZV?=
 =?utf-8?B?V0JadlhyNGRJeWR5Mld3a3I2cDB5dlZ2ekd3dDF4YXN3RkhFNS9sRlA5VW94?=
 =?utf-8?B?Nml6Y1ltWEoxdUtRZGZzMlE5UHNyTERraHp0Rnh4MjdWU05ORHIvR0c2eDZp?=
 =?utf-8?B?LzY4SERDRHlLSU5Tc0k3SGtBVmpkQVpuNmVqK3V2ZGpISnJNMmt4Tkx0cTlu?=
 =?utf-8?B?dFJtMkNQakxFR2xPSGZBNDZqUkF0OXA2SEdNWEV0SUE4L2psV201QWZOUXVw?=
 =?utf-8?B?cTZmNjJNZkYxcFdUL0NZRnUrZXBMS25pczBaWUd6VlR2UFJjUXM3OTAwOWUr?=
 =?utf-8?B?OWdHK1ZZMnA2WGd5RDdXbnJsSS9wNGt2TjVHekJXbjhHSXZ1UzlDYmFHREll?=
 =?utf-8?B?MkFUMVB6d3hMdlE5V2pTcFFXZ1FyVDRLbVZEY0o4UWVIMVgwb0RWc2ZvRGNy?=
 =?utf-8?B?eE1udlhlT2JCeUo3VnJmU1hGdnRLRkhtdGhwajBTWHBjWGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzFkelg2ci96NWFxQ2l1cnkvb29kYUE0dDNvYkFFbjBjRWtGaDdFdUF2RUxI?=
 =?utf-8?B?K1h1OXhudjdJbUV6VDY1S3lYNUlaMEQ2L3EyYzNuZzJXMjdiVlQ5NmV1L3lW?=
 =?utf-8?B?akxsQlFOb1k0clR3RXhWOEV6SkFtVFNmYXZHZzM4K2lDdE9KSnJGRnFoZml1?=
 =?utf-8?B?aFRLWVAxV05QZFZoays3Y0kvaHVpcE9Jcit6Q05kRnNFSWYzalQrVWF1VHBx?=
 =?utf-8?B?QllrWHdka1h5UXRYMHp5S212VHdHV0lFT2o4d0RVM3hNWnRpYjlPMkJKd3hq?=
 =?utf-8?B?ZHVEc24ycy9xY2VxSHl0K0htSnN3KzEyODBNN3A5VUo4Vy9xUFdteFpLWXZl?=
 =?utf-8?B?c3ZHWVJUbmFKUnVZVGtzUE5JeHFkdjJYZDVrWVBmK2xQWEtxMXE4VVNaMkVa?=
 =?utf-8?B?dHNlVUZTbnliTEFlV0QzMUloRjZtUlhjVFA0Nk5xOG1ET0dXT1dxYTIxSjNq?=
 =?utf-8?B?Uk55bkg3YjFBdGgrenNlRm05S3ZIallHS3BUT0p1bjZJK2RqNkpXaHhHR09Y?=
 =?utf-8?B?bEtWSzBON1RWcDlETHMwcHJMSGovd3dSY3dmTTlTS1BoZ0RpVHBCZDloV2Rn?=
 =?utf-8?B?a1ZMOUFjeHNQZDl1NjZ0amlmUzJFWjRNM2U2ejR4TE1SaGtaazIvZDYrZEhC?=
 =?utf-8?B?Vm9MMTlJTlNUaVI1b2svSXlCL0ZFNThjUHk4NUgrSjZrWkRLQ3FPcVB5Zkg0?=
 =?utf-8?B?OC9wanExTDlHVWRpeVVHMHpYY1VOZFQ2bnE4QmdkK1NKWE1naXpNSUIrZGcx?=
 =?utf-8?B?Z2ZCUlI5cDc2VTJ1RUF4bTdEYjNCdlNrTmM4T3N6Nyt4ZG01RWVmTlhjVHZE?=
 =?utf-8?B?a3l6R1MxSnN3RmhVc1JSUEhRS0JSZjFrMFNlQ0JTVkxla1dndnliU283OEVk?=
 =?utf-8?B?VlBIeG5Ocy9tTGV1ZHFxNUJWUnI2VnFxWDlRUUE0TEc4Njd3K0ZSbXlxcWE4?=
 =?utf-8?B?bWhDNnhwYlRJcW5Jc0N5SU1XbEpCRUM0MWZMeTBiWUpaTWNrYTMvWm9TV2Jm?=
 =?utf-8?B?ajRabGtib3BWOFpIaUhrUnc3VFBCMk84aDFScmkxd1FJMEU3WEJKckhBS0RE?=
 =?utf-8?B?eEtiQXdSVGMrTVd6YXFUMTZKRmxCL2t5UW5aWmVUTE84N2J5KzA4Ly95SnpG?=
 =?utf-8?B?clo4cGNyRFVJUmNrSUp6ZlhPU0hlbmN3LzcxbDVjVG9jNXBCbStaa0I2M0lR?=
 =?utf-8?B?NlVBUGlkenhabnc0WUh3M21RanpkODJvRFhjS3VJUnVWRC8wVGRNY2wyZ0lZ?=
 =?utf-8?B?YWtZSkVSZFJXeS9ncW02TzNDYkdIR25CSm42WXRQRXpCQ213bW1vaWNpWGFu?=
 =?utf-8?B?V0ZuY29YZDZYdDdETU5JTjhxT0xwakhCcHU2cmRacjE0MXpZZG1acmJKbTJX?=
 =?utf-8?B?RU9LRnhZWW14Tm9PVGErNFhoRVI2aERhaTB0bFJ1ZzRqN2w0ckdsWW53RElu?=
 =?utf-8?B?ems3V3FVcWhpNmxHRVJ4bmFlRzIvdXhPNWRPQmRzcjErVDJlS25Vb1RhZkF2?=
 =?utf-8?B?cW9pR1BZOG1GdmJZRnd1M3drUWlNODFhVDRlZXNuYno4MnAyQ2FrT3A4eHR3?=
 =?utf-8?B?RE9HY0lNUEhFTGxvRkQ0RW5LSWJnRFRpTkNvYUlSRUhmYWVlM0dBVWVWSzNP?=
 =?utf-8?B?M2FKci9wTVE0eDYvTXQ4OWZoZGZkUVNwK2o3UGViakNDMk1SWWtPMVgyUnNU?=
 =?utf-8?B?bmpNUUVGb3NjVzJLNnJvcTQ4c2xwUDYxbjZWYXlxWnMvRzUvUzE0bWgwMVJT?=
 =?utf-8?B?UjRhSjkrRndWK244Wm5vc0s5VFJyT2VZNWpYZkEreWZjbEZZVHZOdXRFU29S?=
 =?utf-8?B?d3prbkx2M2lKVENabEJGMnpudTVucndiMUY1WUF2aVExeHJZUUZJSWY1eHpU?=
 =?utf-8?B?Yk8zR1hnN3lLbGlsTW1ZTHE2b3dsNW5aKytpVEttck1DMC81RmtFQVpKZ0pt?=
 =?utf-8?B?c2ViSlVUc3JsZ0pJaHJvOUlCWitOYTZlSUd2a2wvdG5uNGRHcG9WdkJVeWN3?=
 =?utf-8?B?d2o5alRlYVFSbys1NHY3dXhJNFBTaFRyLzB5YmZsUTZrZEZjUGNHelB5QWkx?=
 =?utf-8?B?Vm9qd0FxMmVTRzFpbThyL1YxWUt3VTN4SVVFNVEvU1MyaG5FdzdBV1JXcXVq?=
 =?utf-8?B?ckRIUlhnaFo4SXh5VzNhVkJCMnFCRDBRM3pUK2pFaUt4L0VEUzdYaXMyNDFW?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFD52274D652614C9F451882289D9C5F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DhJmLvmlU41zAmyOe/Sab+GbTvAoz2+EVdgK7TuBjUzzNp1q916SIjTPcI9BY3XNchWRwFcrmbTn9l3iJ9ej3AiTtsiPPoytvMh5P7uf305NwF10jaJV49/J48TyYsATirq8bWRDd33ryqYpbfmTYJZl2JkA3a20mzMWYsWGI9Mho6f3GSo81QzHijQ8wxvdo7+m1eUp074kZ8kXkCp9ZG86CximPUdJDkyaT0IMTX+8sZW6M/iQQRCy59YCbym63nOGIsi6N0217u+MImTPD8g3a+SVrq1Em9dWiKzfiRcL3pX/5k3JTqUqJOeI1XhXYs/O7bqRsqD0qpMPvWr0ilAkGwKvPlvD+odiFPmuczU3sziD7ua8BIWFkPISMnfFmbDCuQJaDeXyd1C3ONn2T5jQGAYmc6h3NlpTMsiJ4H9XBUV+lM0exiLAy5c3ylyA6r36e3eWpysWf/a3h2Jg7/kYVXYsyyw/eBXXyZXveETfdHcFOs1NUtu4VCcWyUHPmzR2zEqmWDvxJHqk0aYkHg0RDTAti7GmLoqVoJRN0pfJpDx2NDg2GHfIqCCwIeRxmgY+ATWcaqHZahBwGKHuLXO4iQw4z9DVf+EJvyjRFoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c3fc15-c3d6-44b1-0802-08dcc85d1b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 19:02:19.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Uj41vYvqSoBIdTatG6Vh83pY0TuCoEWR9objX8ouYbFMw8AkPsFm4exIK5QWLN43X01qIyAB5nVZaRYQP8ENg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290136
X-Proofpoint-GUID: ig5QXGUDMByyuqHz3FhgrKy5TPYg4nH7
X-Proofpoint-ORIG-GUID: ig5QXGUDMByyuqHz3FhgrKy5TPYg4nH7

DQoNCj4gT24gQXVnIDI5LCAyMDI0LCBhdCAyOjI24oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTA4LTI5IGF0IDExOjEzIC0w
NDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDA5OjI2
OjQ2QU0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4gDQo+Pj4gQ3JlYXRlIGEgbmV3IGlu
Y2x1ZGUvbGludXgvc3VucnBjL3hkcmdlbiBkaXJlY3RvcnkgaW4gd2hpY2ggd2UgY2FuDQo+Pj4g
a2VlcCBhdXRvZ2VuZXJhdGVkIGhlYWRlciBmaWxlcy4NCj4+IA0KPj4gSSB0aGluayB0aGUgaGVh
ZGVyIGZpbGVzIHdpbGwgaGF2ZSBkaWZmZXJlbnQgY29udGVudCBmb3IgdGhlIGNsaWVudA0KPj4g
YW5kIHNlcnZlci4gRm9yIGV4YW1wbGUsIHRoZSBzZXJ2ZXItc2lkZSBoZWFkZXIgaGFzIGZ1bmN0
aW9uDQo+PiBkZWNsYXJhdGlvbnMgZm9yIHRoZSBwcm9jZWR1cmUgYXJndW1lbnQgYW5kIHJlc3Vs
dCBYRFIgZnVuY3Rpb25zLA0KPj4gdGhlIGNsaWVudCBkb2Vzbid0IChiZWNhdXNlIHRob3NlIGZ1
bmN0aW9ucyBhcmUgYWxsIHN0YXRpYyBvbiB0aGUNCj4+IGNsaWVudCBzaWRlKS4NCj4+IA0KPj4g
Tm90IHN1cmUgd2UncmUgcmVhZHkgZm9yIHRoaXMgbGV2ZWwgb2Ygc2hhcmluZyBiZXR3ZWVuIGNs
aWVudCBhbmQNCj4+IHNlcnZlci4NCj4+IA0KPiANCj4gRG9lcyB0aGF0IG1hdHRlciB0aG91Z2g/
DQoNCklNSE8gaXQgZG9lcy4gQ2xpZW50IGFuZCBzZXJ2ZXIgYXJlIHJhdGhlciBzZXBhcmF0ZQ0K
Y29kZSBiYXNlcywgYW5kIHdoZW4gd2UgaGF2ZSBhdHRlbXB0ZWQgdG8gc2hhcmUgdGhpbmdzDQpl
eHRlbnNpdmVseSBiZXR3ZWVuIHRoZW0gaW4gdGhlIHBhc3QsIGl0IGxvY2tzIHRoZSBvdGhlcg0K
c2lkZSBpbnRvIHNvbWV0aGluZyB0aGF0IGRvZXNuJ3QgZml0IHdlbGwuDQoNCkknZCByYXRoZXIg
YmUgZnVydGhlciBhbG9uZyB3aXRoIGNsaWVudCBzaWRlIGNvZGUNCmdlbmVyYXRpb24gYmVmb3Jl
IG1ha2luZyBkZWNpc2lvbnMgYWJvdXQgaG93IHRvIGZpdA0KdGhlc2UgcGllY2VzIHRvZ2V0aGVy
LiBXaGF0IEkndmUgdG95ZWQgd2l0aCBzbyBmYXINCnN1Z2dlc3RzIHRoZXJlIGFyZSBnb2luZyB0
byBiZSBhIGZldyBzdWJzdGFudGl2ZQ0KZGlmZmVyZW5jZXMgd2l0aCB0aGUgc2VydmVyIHNpZGUu
DQoNCg0KPiBUaGUgY29uc3RhbnQgYW5kIHR5cGUgZGVmaW5pdGlvbnMgYXJlIHRoZSBzYW1lIGJl
dHdlZW4gdGhlIGNsaWVudCBhbmQNCj4gc2VydmVyLiBJIHRoaW5rIHRoZXJlIGlzIHZhbHVlIGlu
IGhhdmluZyBhIHNpbmdsZSBzb3VyY2UgZm9yIHRoYXQsIGxpa2UNCj4gd2UgaGF2ZSB0b2RheSB3
aXRoIG5mczQuaC4NCj4gDQo+IElmIHdlIGRvIGRlY2lkZSB0aGF0IGl0J3MgYSBwcm9ibGVtLCB3
ZSBjYW4ganVzdCBzcGxpdCB0aGluZ3MgdXANCj4gZnVydGhlcjoNCg0KVGhlIHRvb2wgYWxyZWFk
eSBkb2VzIHRoYXQgbm93Og0KDQogIHhkcmdlbiBoZWFkZXIgLS1kZWZpbml0aW9ucw0KDQpnaXZl
cyB5b3UgdGhlIHByb3RvY29sIHBpZWNlcywgYW5kDQoNCiAgeGRyZ2VuIGhlYWRlciAtLWRlY2xh
cmF0aW9ucw0KDQpnaXZlcyB5b3UgdGhlIGZ1bmN0aW9uIGRlY2xhcmF0aW9ucy4gU3BlY2lmeSBi
b3RoDQp0b2dldGhlciBhbmQgeW91IGdldCB3aGF0IHlvdSBoYXZlIGluIG5mczR4ZHJfZ2VuLmgN
CnRvZGF5LiBJdCBtaWdodCBub3QgYmUgdGhlIG1vc3QgbmF0dXJhbCB3YXkgdG8gc3BsaXQNCnRo
ZXNlIHVwLCBidXQgPHNocnVnPi4NCg0KKE5vdGUgdGhhdCB0aGlzIGlzIGdvaW5nIHRvIGdldCB3
b3JzZSB3aGVuIFJ1c3QgaXMNCmludHJvZHVjZWQgaW50byB0aGUgbWl4KS4NCg0KDQo+IDEuIG9u
ZSBoZWFkZXIgZmlsZSB3aXRoIGNvbnN0YW50LCBzdHJ1Y3QgYW5kIHR5cGUgZGVmaW5pdGlvbnMN
Cj4gMi4gb25lIHdpdGggc2VydmVyLXNpZGUgZW5jb2RlL2RlY29kZSBwcm90b3R5cGVzIHRoYXQg
aW5jbHVkZXMgIzENCj4gMy4gb25lIHdpdGggY2xpZW50LXNpZGUgZW5jb2RlL2RlY29kZSBwcm90
b3R5cGVzIHRoYXQgaW5jbHVkZXMgIzENCg0KUmlnaHQsIHRoYXQncyBhbHJlYWR5IHRoZSBkaXJl
Y3Rpb24gSSdtIGdvaW5nIHdpdGgNCnhkcmdlbi4gSSB0aGluayB3ZSdyZSBvbiB0aGUgc2FtZSBw
YWdlIHdpdGggdGhhdC4NCg0KDQo+IGluY2x1ZGUvbGludXgvbmZzNC5oIGNvdWxkIHN0aWxsIGlu
Y2x1ZGUgIzEgYXMgd2VsbCwgYnV0IHRoZSBjbGllbnQgYW5kDQo+IHNlcnZlciBjb3VsZCBpbmNs
dWRlIHRoZSBhcHByb3ByaWF0ZSBoZWFkZXJzIGluc3RlYWQgb2Ygb3IgaW4gYWRkaXRpb24NCj4g
dG8gaXQuDQoNClRoYXQgc2hvdWxkIHdvcmsuDQoNCg0KPj4+IE1vdmUgdGhlIG5ldywgZ2VuZXJh
dGVkIG5mczR4ZHJfZ2VuLmggZmlsZSB0byBuZnM0XzEuaCBpbg0KPj4+IHRoYXQgZGlyZWN0b3J5
Lg0KPj4gDQo+PiBJJ2QgcmF0aGVyIGtlZXAgdGhlIGN1cnJlbnQgZmlsZSBuYW1lIHRvIGluZGlj
YXRlIHRoYXQgaXQncw0KPj4gZ2VuZXJhdGVkIGNvZGUuDQo+PiANCj4gDQo+IEkgZmlndXJlZCB0
aGUgInhkcmdlbiIgZGlyZWN0b3J5IG5hbWUgd291bGQgY29udmV5IHRoYXQuDQoNCkl0IGRvZXMg
b25seSBpZiB3ZSBtb3ZlIHRoZSBoZWFkZXIgZmlsZSB0bw0KaW5jbHVkZS9saW51eC9zdW5ycGMv
eGRyZ2VuLiBJJ20gbm90IHNvbGQgb24gdGhhdCBpZGVhIHlldA0KdGhvdWdoIEkgZ3Vlc3MgaXQg
d29ya3MgZm9yIHRoZSBwcm90b2NvbCBwaWVjZXMgdGhhdCB0aGUNCkxpbnV4IGNvbW11bml0eSBk
b2Vzbid0IGRpcmVjdGx5IGNvbnRyb2wgKGllIC0tZGVmaW5pdGlvbnMpLg0KDQoNCj4gVGhpcyBu
YW1pbmcgYWxzbyBtYWtlcyBpdCBjbGVhcmVyIHRoYXQgaXQncyBnZW5lcmF0ZWQgZnJvbQ0KPiBu
ZnM0XzEueC4NCg0KV2VsbCB0aGUgZ2VuZXJhdGVkIGJvaWxlcnBsYXRlIGNvdWxkIGNvbnRhaW4g
dGhlIHNwZWMgZmlsZQ0KbmFtZSAtLSBpdCBoYXMgdGhlIHNwZWMgZmlsZSdzIHRpbWVzdGFtcCBh
bHJlYWR5IGFzIGEga2luZA0Kb2YgamFua3kgdmVyc2lvbiBudW1iZXIuIENvbW1pdCBoYXNoIG1p
Z2h0IGJlIGJldHRlci4NCg0KTm90ZSB0aGF0IHRoZSBzcGVjIGF1dGhvcnMgZXhwZWN0IGltcGxl
bWVudGF0aW9ucyB0byBjYXRlbmF0ZQ0KYWxsIHRoZSBkaXNwYXJhdGUgLnggcGllY2VzIChpZSwg
YWxsIHRoZSBtaW5vciB2ZXJzaW9ucyBhbmQNCmFsbCB0aGUgcE5GUyBsYXlvdXQgdHlwZXMpIHRv
Z2V0aGVyIGludG8gYSBzaW5nbGUgYWxsLXNpbmdpbmctDQphbGwtZGFuY2luZyBuZnM0LnguIExv
b2tpbmcgYXQgaXQgbm93LCBJJ20gbm90IGNvbnZpbmNlZCB3ZQ0Kd2FudCB0byBzdGF5IHdpdGgg
dGhlIG5hbWUgbmZzNF8xLnguIEFsc28gdGhhdCdzIHdoeSBJIHVzZWQNCnRoZSBvdXRwdXQgZmls
ZSBuYW1lIG5mczR4ZHJfZ2VuLltjaF0uDQoNCg0KPiBUaGF0IHNhaWQsIEknbSBub3QgdG9vIHBh
cnRpY3VsYXIgaGVyZS4gQ2FuIHlvdSBsYXkgb3V0DQo+IGhvdyB5b3UgdGhpbmsgd2Ugb3VnaHQg
dG8gYXJyYW5nZSB0aGluZ3M/DQoNCkknbSBzdGlsbCBtdXNpbmcgYWJvdXQgaXQuIEknbGwgbW9j
ayBzb21ldGhpbmcgdXAgaW4gdGhlDQoyLzIgeGRyZ2VuIHBhdGNoIGZvciBtb3JlIGZlZWRiYWNr
Lg0KDQpOb3cgdGhhdCB3ZSd2ZSBnb3QgbW9zdCBvZiB0aGUgcmV2aWV3IG9mIExPQ0FMSU8gZG9u
ZSwgSSdsbA0KaGF2ZSBhIGJpdCBtb3JlIHRpbWUgdG8gaGVscCB5b3UgZ2V0IHhkcmdlbiByZWFk
eSBmb3Igc2VydmVyLQ0Kc2lkZSBkZWxzdGlkLiBJIHdpbGwgdHJ5IG5vdCB0byBob2xkIHlvdSB1
cC4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

