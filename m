Return-Path: <linux-fsdevel+bounces-42325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B96A4042E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 01:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170D170036F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 00:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2D3FB1B;
	Sat, 22 Feb 2025 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iq8vZnOf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HpmrfYQt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C98494;
	Sat, 22 Feb 2025 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184413; cv=fail; b=OFx0k6NB7umwE0QqQyUK3R6r4lcyP3f54peOTh05bn/Uk0B2IKQCKI1NUx/CkOYkebUGqwPsYeqOp+XOzxUq/0Sefd1BlyVyXKLhd4uBOUL8qzh4KxzvD3ALxwYFuugI6s+9XTsJzLstvOdc8Tbnhc0ut1l4cxZk3vzU3q2CKAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184413; c=relaxed/simple;
	bh=thoOxGa8AWh2tkon0AR4y1iC55r15ID5f1UzAlSCp+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QogH8XN6+rcyI8Ex//dnETPJB03AXcAJUoqqLa1kYbMzeXDgNdCI6rFAxpEGucASHZQkemiKHzv/ucK+6v1tpqYdtqE5UdaFGmozxoELrLrs5z5FwtLwHLs+tQ4gtSa6LgJiWZKS0pmYRkInxXO7DXO5GAR/2oNo2H55HP4VMHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iq8vZnOf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HpmrfYQt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51M0Bhjg025887;
	Sat, 22 Feb 2025 00:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jOZv6p1QP2W48CMsXuAYyJxtBcMcfANtTZchB92L5dg=; b=
	Iq8vZnOfV/xe2RDRbVXkKHZcfsQH/nlaVXwAyFdazcV4LqLN3xcVfEUvnaW3flIA
	LbvOvdL2A1E9X97xDK2DJdvsSrLTlCXcKKNhhN1tj3QSfc3UYoGxFpnqLZK8CbDI
	v3THh2S93UBqiackTn6/p0Y2V5GO8oSb/tCIoWqVY/PIvzVu41u0q80YFIHjopzO
	LVQTl34PL2IcIISk+oqitStj49x4KB640egRDuA5ZptHCcyo89RNXvDItd7Kamza
	rTJwGqYVw6P39I7wuM5/nELPPQwMlT6TtjKwI/qcfmBg2cCZKX7LbkYrWsbz4sBB
	uvipSevUYNdWlUqA2NA4mg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00nqahf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 00:32:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51M0Va1D025251;
	Sat, 22 Feb 2025 00:32:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w091bjcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 00:32:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VI7F/tXNId5qUQV1hcFyoNB0EyYixP+piuykCwvbwtFa+BJm5z1aEebeAU3Igdnpl/Jv5JTujeVtraJU/lmz2y+k/D0HYrqBdouO6QWyA9cfFnAxk1Grg4Q9i+G8SA9/8sDv+InXXYIkFnlr/7VYBtCZjHFSSm0h6FdxjoqzafoNK53g541cxmJJe7T124r2YeeY4o/qp1T5NWpMkG/hHa/4ouWZ9Xs8b7pgzVne5GXvF4krLrLn/LtVmOhmBBmJM/bqshiZNyJJ2K7XBBA5Q2FydD0a90iqLEH8F2tcJz7X73Zk69gq1XZLFoYTLJgordcpWsyJOr/kFqlbm6ewMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOZv6p1QP2W48CMsXuAYyJxtBcMcfANtTZchB92L5dg=;
 b=zVuCvPxDxh5O3BbxXe1lGp+YK3jICxPLeGKusBCPruJ6zAoP8Ll10DuCav8vm3cvc/rMc2UHSglSPqUhnMhAvdaZJOiXg9x/gCo/OhnEyHoQuK7FKymM0mLtrujLN4i0hop5ksF3Dse/0z5CRm5ItMMUWVJAUkUYcBJkwqW0oqTIV3pAUPN/h+io+QW1hfWDXEP+hyfKFOTEkPakmD3Ay1daTWDdbCX9srMeUSgIh1+TeRY8EBxdyvyqyzKFEQxwhRQ6n2m+ysXDIuaMnoCBjbh9COWSr+qOnP4LD5+IpGIJh7jozyNo9sqsKFwg79IwQKeUGajtbq4EtDtVF/Tuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOZv6p1QP2W48CMsXuAYyJxtBcMcfANtTZchB92L5dg=;
 b=HpmrfYQtc3L+4XzFIIjEMpG3W5U9ZHTOPxIcHusmJ6q0+V3shpWo4BaVxQPMngoB0r9my9Ru1LtK0Ms6pJSmf5/u8p9tad/PVKic5ZUDVb9Rdjw0H0IdVpsGnDFA9FM1b9NjkjzauK48QPu+RkpUfxPsOxw4lgx4KQZGJatuUXo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 00:32:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 00:32:45 +0000
Message-ID: <01a3f184-940c-494e-ade2-775e3441fc4e@oracle.com>
Date: Fri, 21 Feb 2025 19:32:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] VFS: Change vfs_mkdir() to return the dentry.
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
        netfs@lists.linux.dev
References: <20250220234630.983190-1-neilb@suse.de>
 <20250220234630.983190-7-neilb@suse.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250220234630.983190-7-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:32::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: d581c3e8-bc3f-4af3-3741-08dd52d86cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QllTVTh4MkN4VFNyWk1TUHZsQmhKTzF3dnhIZEV3L1dlSzZGOVJTTHNXMnNO?=
 =?utf-8?B?MXhKM05xZjViKytEdWJna2hwREhoVFdEb0Fjb1l4QlhWNnNBajdXMS9ENVNx?=
 =?utf-8?B?SUtneUE0UWxXbFcyUjNmOGJOR1VwQXpkcFkvcVdEb1FNM1BFWDRoaGoxbFo4?=
 =?utf-8?B?clFnZ00xbnZzZ0dwZlh0QXRJYzJWa2F5dTE4YkFKdUVJTDBWMHRFMnV1Ujdl?=
 =?utf-8?B?aksrZVJabUM5OWQ5aUpsZmpodHVMU3pIZTFla09WR0l2YWpRRmxjZmRlQS9I?=
 =?utf-8?B?a1NGTFF4Y0huV1FQNWtaaTdIWUJvV1YrWk5xT3BrTnltelBiZVRKNm5kUExx?=
 =?utf-8?B?dXdCZklrM2ZaZlhWdHJzUDh5c25Kb3hxOGVEKzh3TlhSL2JQYVB6alNDY2dn?=
 =?utf-8?B?c1RZTWNGandpU3RwMDRSWjArT2JGTG02a1FBeEJQSnpPbVpwVjNPU3V2Mi95?=
 =?utf-8?B?Ri9FTVJWK0Mzdm5YQnVrSXJHOGdNdUFUajB5Zm1DbzFvTnZCZjhuL0NjQ3h4?=
 =?utf-8?B?Y2VWRkFnV1pvc3ZpSkpiRzA1Zzd2Q1VWeHZLSm13SGxFTHJ5R0Erc0VBTnpK?=
 =?utf-8?B?bTVlTklINWpQZWN3Z1pnT0ZCN2YzMUhxVmY4Ryt0S2l2elpTajJxZVpEQnRU?=
 =?utf-8?B?MkhNakR0WU5mTzNUWDZoY0FPZkcyT1BzbnZZK3ZsQlkxWktleXhDVWMrbUps?=
 =?utf-8?B?RmhBLzZMNHQzeGtKQ05CaGxwb0Y4WmFlYktUTTNsNHVUUlIrbTBjT1BkcHBv?=
 =?utf-8?B?bWo0QUlwOE9xTXNmRTNTVjZWTzU3Q0ZMcmwwTHNnR0dBTjN0eHBKZ2xMZCti?=
 =?utf-8?B?SitFS0twRkxlZTNkaEd1NUNGQ2tXcUdVSFZoRXVUY04xMW1rU21JR2lDc3Zi?=
 =?utf-8?B?WEx1blpkQkRWMkdDdEhQSDFMWEFKai80c2I3Nzc0ZUxMTEpZWWxOWXkyVlNU?=
 =?utf-8?B?NE9jQjNOem9uc0FoTUpBOUh1NXhFcmdUM2p2SHc4eGh4Z2dnZVJDdUdKWTVv?=
 =?utf-8?B?TlBpWHBGeVB4TmZ2L2hTci8yUmcxakhpM1p3ZzF1aDJOTm51NjlORitmNlFJ?=
 =?utf-8?B?Vlowa2IzeEdsWTBydEg0OThxQTZaV0Q5T3RnRm9EcStUbndURDhCZlhsTXpn?=
 =?utf-8?B?KzIyQ3FjRWZ5RStsTVh3a3pQRWo3bFB0YXgycXNML1l3bGM1QkQ5S3BIdWdP?=
 =?utf-8?B?dzZQM3pKQTFZY1BsbTVKblNoRjRTS0ttWXUwYkNDYTJOKy8rajhNWlhEYWlm?=
 =?utf-8?B?cFVpOWRSd01RUXpxUExDVVc0SDhFSzlicEJ5QkVCTlN5N1FZd0NkNVFaZzlo?=
 =?utf-8?B?eWlSSVpreFA3OGhGWFh3N0MvQVE0bGttVGdzRGN3eXNYTjJPdDdqK0NpZCtD?=
 =?utf-8?B?N1dmd3NKRXBTZVBFOWpuSnhiNkh3cTI5S0U1aFlEa0FkZkRMazE3Zzl1S3VO?=
 =?utf-8?B?bytLUXNUZEVqMlNRMEJRMU5TRUNVNGtUcU5VRFpmM0JjSURYSk9IU1dsd09N?=
 =?utf-8?B?UUlzd2owT2w0Um1WMFZ2SjViVDI1YnVJSHN2K3JWbjNvQmVmL3hpQWtpN01i?=
 =?utf-8?B?cy82MG9haDdDZWVWcDVRYTUrL0hYVXVMYzNCUlFpODVXSG5oTmNHTzlrdUlS?=
 =?utf-8?B?YW0vYTB4OXczTTRIbTExSEpOWjBWUUFhTnN5UnNGWTlGa3k3RS9aSGR1WXN1?=
 =?utf-8?B?WDd1UTUwQjgvUE9zR2VlRTQvSXFQZmV6SHpobm9VZXVDRkxmTjhZNDU5K0Z2?=
 =?utf-8?B?Mmc2Z3ljREQ3VGtjc1BOZVJuajI3aHBVbHovRldCTHcrMnozdjNSRkEvOXFD?=
 =?utf-8?B?WVlOY2F2bUVnenU2NnNVM0c5NVM5ODJXaUkxME5wblZoaEFua0dQTmJIakVj?=
 =?utf-8?B?ejBrTWFzZDBqTkx3M1ZHSXhQR09PakZuMGk1SU8vR1dDTzNLdUcrdGNiVkNp?=
 =?utf-8?Q?fw/JfrOpxek=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTREU1ZNUWQzQmpIbU5uNmtTSGtmRFl4QVlKNHgrY0dJZjJPSVJaNDEyVjZT?=
 =?utf-8?B?RDBpSGZWcVJTaWt4UjQzV2FuOWl6dUJOa0VOelpWQncwem9QM3U0Y084eGl0?=
 =?utf-8?B?QUtCN3BFd2ZEM1N2ZWNsMFkxSVl0bGluZDMrWGhIZVBqbnNCSk1lQjZCbHNa?=
 =?utf-8?B?OTJhQ2xYdlVmYy9weVU4WnJVeDA0K0ppWEg0V3llQ0xKdXNncGRGSWtodzhY?=
 =?utf-8?B?aHdxRURKQWhKaEZPVy9KNHdVdWp0K0dKY21KWkFrV3FoWDQ2ditUVWVacTQ2?=
 =?utf-8?B?SVF3Z0RVdVN1ajI3a1g0VWdzV3J5Y3dkV2NmS2I0SEVFNmEwWmROTkNRaDIw?=
 =?utf-8?B?Z095aEJ2Mnhpd0FCUXFzc3lZK1psYzQrYXpRU09lTUpWa1VSa2tXY1hIdEc1?=
 =?utf-8?B?TGEzMWpKU2ZyTzgwYU9UaVpLOGsya1NUbDlBQmpMcjJGem9QU1FKL0wyalg5?=
 =?utf-8?B?bmgxcmVSOXQyL0RaMTlPcXcyNlEvb2FqWkxPdzFDdjdTSVpBTFNLcjFyVDY5?=
 =?utf-8?B?WWJNa0VuZnF6a05kWUgxUzZPNUswQUNpbE9UeStvNzZkeTUwVFFkSWZEZkxL?=
 =?utf-8?B?QjNhQnhGTjNqb0FuSFB1VWNabmVtWkgvdlR0eDJJbElrUFFtOHJ3V1dGR2pK?=
 =?utf-8?B?eVBMUjNxWWxQVGFTNW4wOTRlb1VGdzZTUnpOaGlYdFlhWXBLTVFINnFkbkdL?=
 =?utf-8?B?RHJaeHRSKzR3NlVBQ3RBeEFOME4rWjVIRkVZSXhDalo5d0RWbjlsT254U0Rw?=
 =?utf-8?B?UTNRV2xZQjREMHZaeXFrWXVveTA2YmtLdFZPb09LN2pRN2F0Y3pRbGxiL0ds?=
 =?utf-8?B?UUhyekl3QUwyRE5UdUdWTTFXSU1jeTNpaG4yYnZMVHFuWXI0RTlUWk5QRXVP?=
 =?utf-8?B?a0c5WmlSMEN6UXE5ZXR5a0cvVnVXWFRnZC9MMTk3YTlpZWJOYm15bnNPM2hT?=
 =?utf-8?B?SzcrYTIvMC9aSnZSQ3hzSjRyYVYrdTMxd0Z0d0g4UnNtelZKaHYvNWJWb01M?=
 =?utf-8?B?Y1c4RlpVVFFTcFdFWHJrZjNqc0s0dU1tMnZRS0hLRVExY0xCTlorR1BER1Rl?=
 =?utf-8?B?L2d1cGJydStHMDRyUDZpUWJpeVVlU2x5cUlQMnd5dVhRNHRMdXBCMlRHRDFn?=
 =?utf-8?B?STRKZWs0eHRscmgvVTlwaVc5dzJuTkxBaDRKblROYy84N2NkUjM0aTNCd2p1?=
 =?utf-8?B?QTJuWkFDdHoyRk9QaGZScWp1ckV6ZFJ4L1YxNTBnbUYrVzZJUTVjN1F2UHcz?=
 =?utf-8?B?OUNQSGJjYkJWYmpFNUNLNm8xQ01sZWNIdldTWm5qdEJwdU5YQWwzWkI0amFm?=
 =?utf-8?B?RHZQb0lSWUtUOC9FYnJGcFh5Q0preUliSXdYbDk3N0FZTWd0RGFIa1AvTXh0?=
 =?utf-8?B?VUlJSEtPTktwalNTQnJzRkRKTlFpRFZSMlBQQk0zem04S3FyVmVuOEdFaW5V?=
 =?utf-8?B?SXdRRUZoa2JpLzFpbEVlN0J6ZUdzQ0kxU2tSWmwyTnRBVncvczVxSWJ1VUxO?=
 =?utf-8?B?andRUkRnTWlJU3hPelVyR2hHT2V2V0Y1Q1lnbUxHdmpGTGtlWEhTaUhGSGx2?=
 =?utf-8?B?WHdadE9vbmhmQTQzV1VLK0NFK085Y0pPMDdObGllTGxGSFM2L3J3NGJuWXZ2?=
 =?utf-8?B?YkNtd2F2OUJSSXlpdFlxeEtWaEFmbkJobFljcnQ3SkxrbmtiRHh2Yk93R1RF?=
 =?utf-8?B?MFRaazlUTWpGNURLOUNPaWRvWXlZeWRjQzRqWExHekNzU1BzdEZjUVdLQlhF?=
 =?utf-8?B?Zk1lc21ScFlzc2d2QUtnSlJmNW9RRDR6SUhPODl5aXJRa0ZTZTlCL0NvaG1j?=
 =?utf-8?B?TVo4S3c0bnZXZUNTTVVVdXBYdXJUNVBwTVhDK1F4YW9uV1REYnpSamc0aURB?=
 =?utf-8?B?QmhYdnJzQlFpSzFCOEw1LzlhRFpYY1FrT1B2RW5JTzlhd2sxOEdOMG84SFBH?=
 =?utf-8?B?c3k1d1drcERDMmxWczV2OENzUDNUNmo0Yk0zS2JOYmJTck5lZjFnb0hId3R1?=
 =?utf-8?B?allBUVgrOTRVQUZjMXZvOWx5WkFRU3FMNndOckp6Vk44SFhLY3NtNW5sakpt?=
 =?utf-8?B?MzRWMmRsNTN1bmVWNmkzQzU0OUtWdHJSZTNta0VuKzRPVUkxSmtwT2VOMGwx?=
 =?utf-8?Q?dDaqAuatKRizh+snpG9qjYCjt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pv8hiClUeacxl3ZnMZLLR26NB35jg1sjf3VGV5AfPY/kWvZF0WAnKuPI+9kcgZMWPjDGJY92Cvgg9haaUjI23JZgMOMpOV459cjVF7Z+DOfNhDsCvNj/jly3UOj0a3h1vhsFS4FULYflgGDISZrwfDyCl/QhFpkJ1J117jOvLQQxzuqtI1cZwddAG3JTBPcNCO/cXWUNED4zIHzY28kRn4vfls4gERfK1E3TfSc1DhFNGFRF/aK7GntCmi8GZp5hM2Yl9zmex8gvl68jHNbtFUDb/bsEvFjepPYbd8/VgFyACoTEdkawLTSHeZOyU9PAR0ISs3Rwls1uh0m3jERkQMh5f2dML59UNMgmufKU8Pkp0y3WSTnQdvod60qgsSKFv/OZQysqjBRJPcJGN4Hs71wR+orF40B6EfZMvanY+BPZwQmATsPRo5zuk05/UKLqD7YdDeL/RaCm+TErqbqHRZzD7bAHIylO+67HygK478QXFZG4NfuUzPPRKR3nUp8ZW4HXLVDjRJo1Dme2qIDEI9RbQ1+qKCRpDK7AdgakN3CpqSYHZdLlIehqCi3P1zanuz2iv8UV1N8J0l2icUPAu+klip1knuZ+SBvv8TmBBi4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d581c3e8-bc3f-4af3-3741-08dd52d86cc9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 00:32:45.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5Le8kHnNAgfeHJLHL7duOlVARF3jC26oQ44znkPZA8VB9rACfgztkr4kyRR7COdq0EZQxenJBGF1fqmdq3zfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502220002
X-Proofpoint-ORIG-GUID: FCgkpFlgBQlnkXgJkoYfyLx5R1ggbzc9
X-Proofpoint-GUID: FCgkpFlgBQlnkXgJkoYfyLx5R1ggbzc9

On 2/20/25 6:36 PM, NeilBrown wrote:
> vfs_mkdir() does not guarantee to leave the child dentry hashed or make
> it positive on success, and in many such cases the filesystem had to use
> a different dentry which it can now return.
> 
> This patch changes vfs_mkdir() to return the dentry provided by the
> filesystems which is hashed and positive when provided.  This reduces
> the number of cases where the resulting dentry is not positive to a
> handful which don't deserve extra efforts.
> 
> The only callers of vfs_mkdir() which are interested in the resulting
> inode are in-kernel filesystem clients: cachefiles, nfsd, smb/server.
> The only filesystems that don't reliably provide the inode are:
> - kernfs, tracefs which these clients are unlikely to be interested in
> - cifs in some configurations would need to do a lookup to find the
>   created inode, but doesn't.  cifs cannot be exported via NFS, is
>   unlikely to be used by cachefiles, and smb/server only has a soft
>   requirement for the inode, so this is unlikely to be a problem in
>   practice.
> - hostfs, nfs, cifs may need to do a lookup (rarely for NFS) and it is
>   possible for a race to make that lookup fail.  Actual failure
>   is unlikely and providing callers handle negative dentries graceful
>   they will fail-safe.
> 
> So this patch removes the lookup code in nfsd and smb/server and adjusts
> them to fail safe if a negative dentry is provided:
> - cache-files already fails safe by restarting the task from the
>   top - it still does with this change, though it no longer calls
>   cachefiles_put_directory() as that will crash if the dentry is
>   negative.
> - nfsd reports "Server-fault" which it what it used to do if the lookup
>   failed. This will never happen on any file-systems that it can actually
>   export, so this is of no consequence.  I removed the fh_update()
>   call as that is not needed and out-of-place.  A subsequent
>   nfsd_create_setattr() call will call fh_update() when needed.
> - smb/server only wants the inode to call ksmbd_smb_inherit_owner()
>   which updates ->i_uid (without calling notify_change() or similar)
>   which can be safely skipping on cifs (I hope).
> 
> If a different dentry is returned, the first one is put.  If necessary
> the fact that it is new can be determined by comparing pointers.  A new
> dentry will certainly have a new pointer (as the old is put after the
> new is obtained).
> Similarly if an error is returned (via ERR_PTR()) the original dentry is
> put.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/base/devtmpfs.c  |  7 +++---
>  fs/cachefiles/namei.c    | 16 ++++++++------
>  fs/ecryptfs/inode.c      | 14 ++++++++----
>  fs/init.c                |  7 ++++--
>  fs/namei.c               | 46 ++++++++++++++++++++++++++--------------
>  fs/nfsd/nfs4recover.c    |  7 ++++--
>  fs/nfsd/vfs.c            | 34 ++++++++++-------------------
>  fs/overlayfs/dir.c       | 37 ++++----------------------------
>  fs/overlayfs/overlayfs.h | 15 ++++++-------
>  fs/overlayfs/super.c     |  7 +++---
>  fs/smb/server/vfs.c      | 32 +++++++++-------------------
>  fs/xfs/scrub/orphanage.c |  9 ++++----
>  include/linux/fs.h       |  4 ++--
>  13 files changed, 105 insertions(+), 130 deletions(-)
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 7a101009bee7..6dd1a8860f1c 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -175,18 +175,17 @@ static int dev_mkdir(const char *name, umode_t mode)
>  {
>  	struct dentry *dentry;
>  	struct path path;
> -	int err;
>  
>  	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	err = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
> -	if (!err)
> +	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(path.dentry), dentry, mode);
> +	if (!IS_ERR(dentry))
>  		/* mark as kernel-created inode */
>  		d_inode(dentry)->i_private = &thread;
>  	done_path_create(&path, dentry);
> -	return err;
> +	return PTR_ERR_OR_ZERO(dentry);
>  }
>  
>  static int create_path(const char *nodepath)
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 7cf59713f0f7..83a60126de0f 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -128,18 +128,19 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  		ret = security_path_mkdir(&path, subdir, 0700);
>  		if (ret < 0)
>  			goto mkdir_error;
> -		ret = cachefiles_inject_write_error();
> -		if (ret == 0)
> -			ret = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> -		if (ret < 0) {
> +		subdir = ERR_PTR(cachefiles_inject_write_error());
> +		if (!IS_ERR(subdir))
> +			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> +		ret = PTR_ERR(subdir);
> +		if (IS_ERR(subdir)) {
>  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
>  						   cachefiles_trace_mkdir_error);
>  			goto mkdir_error;
>  		}
>  		trace_cachefiles_mkdir(dir, subdir);
>  
> -		if (unlikely(d_unhashed(subdir))) {
> -			cachefiles_put_directory(subdir);
> +		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
> +			dput(subdir);
>  			goto retry;
>  		}
>  		ASSERT(d_backing_inode(subdir));
> @@ -195,7 +196,8 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
>  
>  mkdir_error:
>  	inode_unlock(d_inode(dir));
> -	dput(subdir);
> +	if (!IS_ERR(subdir))
> +		dput(subdir);
>  	pr_err("mkdir %s failed with error %d\n", dirname, ret);
>  	return ERR_PTR(ret);
>  
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 6315dd194228..51a5c54eb740 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -511,10 +511,16 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	struct inode *lower_dir;
>  
>  	rc = lock_parent(dentry, &lower_dentry, &lower_dir);
> -	if (!rc)
> -		rc = vfs_mkdir(&nop_mnt_idmap, lower_dir,
> -			       lower_dentry, mode);
> -	if (rc || d_really_is_negative(lower_dentry))
> +	if (rc)
> +		goto out;
> +
> +	lower_dentry = vfs_mkdir(&nop_mnt_idmap, lower_dir,
> +				 lower_dentry, mode);
> +	rc = PTR_ERR(lower_dentry);
> +	if (IS_ERR(lower_dentry))
> +		goto out;
> +	rc = 0;
> +	if (d_unhashed(lower_dentry))
>  		goto out;
>  	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
>  	if (rc)
> diff --git a/fs/init.c b/fs/init.c
> index e9387b6c4f30..eef5124885e3 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -230,9 +230,12 @@ int __init init_mkdir(const char *pathname, umode_t mode)
>  		return PTR_ERR(dentry);
>  	mode = mode_strip_umask(d_inode(path.dentry), mode);
>  	error = security_path_mkdir(&path, dentry, mode);
> -	if (!error)
> -		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> +	if (!error) {
> +		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
>  				  dentry, mode);
> +		if (IS_ERR(dentry))
> +			error = PTR_ERR(dentry);
> +	}
>  	done_path_create(&path, dentry);
>  	return error;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 63fe4dc29c23..bd5eec2c0af4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4125,7 +4125,8 @@ EXPORT_SYMBOL(kern_path_create);
>  
>  void done_path_create(struct path *path, struct dentry *dentry)
>  {
> -	dput(dentry);
> +	if (!IS_ERR(dentry))
> +		dput(dentry);
>  	inode_unlock(path->dentry->d_inode);
>  	mnt_drop_write(path->mnt);
>  	path_put(path);
> @@ -4271,7 +4272,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
>  }
>  
>  /**
> - * vfs_mkdir - create directory
> + * vfs_mkdir - create directory returning correct dentry if possible
>   * @idmap:	idmap of the mount the inode was found from
>   * @dir:	inode of the parent directory
>   * @dentry:	dentry of the child directory
> @@ -4284,9 +4285,15 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
>   * care to map the inode according to @idmap before checking permissions.
>   * On non-idmapped mounts or if permission checking is to be performed on the
>   * raw inode simply pass @nop_mnt_idmap.
> + *
> + * In the event that the filesystem does not use the *@dentry but leaves it
> + * negative or unhashes it and possibly splices a different one returning it,
> + * the original dentry is dput() and the alternate is returned.
> + *
> + * In case of an error the dentry is dput() and an ERR_PTR() is returned.
>   */
> -int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -	      struct dentry *dentry, umode_t mode)
> +struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> +			 struct dentry *dentry, umode_t mode)
>  {
>  	int error;
>  	unsigned max_links = dir->i_sb->s_max_links;
> @@ -4294,31 +4301,36 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  
>  	error = may_create(idmap, dir, dentry);
>  	if (error)
> -		return error;
> +		goto err;
>  
> +	error = -EPERM;
>  	if (!dir->i_op->mkdir)
> -		return -EPERM;
> +		goto err;
>  
>  	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
>  	error = security_inode_mkdir(dir, dentry, mode);
>  	if (error)
> -		return error;
> +		goto err;
>  
> +	error = -EMLINK;
>  	if (max_links && dir->i_nlink >= max_links)
> -		return -EMLINK;
> +		goto err;
>  
>  	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	error = PTR_ERR(de);
>  	if (IS_ERR(de))
> -		return PTR_ERR(de);
> +		goto err;
>  	if (de) {
> -		fsnotify_mkdir(dir, de);
> -		/* Cannot return de yet */
> -		dput(de);
> -	} else {
> -		fsnotify_mkdir(dir, dentry);
> +		dput(dentry);
> +		dentry = de;
>  	}
> +	fsnotify_mkdir(dir, dentry);
> +	return dentry;
>  
> -	return 0;
> +err:
> +	dput(dentry);
> +
> +	return ERR_PTR(error);
>  }
>  EXPORT_SYMBOL(vfs_mkdir);
>  
> @@ -4338,8 +4350,10 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  	error = security_path_mkdir(&path, dentry,
>  			mode_strip_umask(path.dentry->d_inode, mode));
>  	if (!error) {
> -		error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
> +		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
>  				  dentry, mode);
> +		if (IS_ERR(dentry))
> +			error = PTR_ERR(dentry);
>  	}
>  	done_path_create(&path, dentry);
>  	if (retry_estale(error, lookup_flags)) {
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 28f4d5311c40..c1d9bd07285f 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -233,9 +233,12 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  		 * as well be forgiving and just succeed silently.
>  		 */
>  		goto out_put;
> -	status = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
> +	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
> +	if (IS_ERR(dentry))
> +		status = PTR_ERR(dentry);
>  out_put:
> -	dput(dentry);
> +	if (!status)
> +		dput(dentry);
>  out_unlock:
>  	inode_unlock(d_inode(dir));
>  	if (status == 0) {
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29cb7b812d71..34d7aa531662 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1461,7 +1461,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	struct inode	*dirp;
>  	struct iattr	*iap = attrs->na_iattr;
>  	__be32		err;
> -	int		host_err;
> +	int		host_err = 0;
>  
>  	dentry = fhp->fh_dentry;
>  	dirp = d_inode(dentry);
> @@ -1488,28 +1488,15 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  			nfsd_check_ignore_resizing(iap);
>  		break;
>  	case S_IFDIR:
> -		host_err = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> -		if (!host_err && unlikely(d_unhashed(dchild))) {
> -			struct dentry *d;
> -			d = lookup_one_len(dchild->d_name.name,
> -					   dchild->d_parent,
> -					   dchild->d_name.len);
> -			if (IS_ERR(d)) {
> -				host_err = PTR_ERR(d);
> -				break;
> -			}
> -			if (unlikely(d_is_negative(d))) {
> -				dput(d);
> -				err = nfserr_serverfault;
> -				goto out;
> -			}
> +		dchild = vfs_mkdir(&nop_mnt_idmap, dirp, dchild, iap->ia_mode);
> +		if (IS_ERR(dchild)) {
> +			host_err = PTR_ERR(dchild);
> +		} else if (d_is_negative(dchild)) {
> +			err = nfserr_serverfault;
> +			goto out;
> +		} else if (unlikely(dchild != resfhp->fh_dentry)) {
>  			dput(resfhp->fh_dentry);
> -			resfhp->fh_dentry = dget(d);
> -			err = fh_update(resfhp);

Hi Neil, why is this fh_update() call no longer necessary?


> -			dput(dchild);
> -			dchild = d;
> -			if (err)
> -				goto out;
> +			resfhp->fh_dentry = dget(dchild);
>  		}
>  		break;
>  	case S_IFCHR:
> @@ -1530,7 +1517,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	err = nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
>  
>  out:
> -	dput(dchild);
> +	if (!IS_ERR(dchild))
> +		dput(dchild);
>  	return err;
>  
>  out_nfserr:
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 21c3aaf7b274..fe493f3ed6b6 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -138,37 +138,6 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
>  	goto out;
>  }
>  
> -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
> -		   struct dentry **newdentry, umode_t mode)
> -{
> -	int err;
> -	struct dentry *d, *dentry = *newdentry;
> -
> -	err = ovl_do_mkdir(ofs, dir, dentry, mode);
> -	if (err)
> -		return err;
> -
> -	if (likely(!d_unhashed(dentry)))
> -		return 0;
> -
> -	/*
> -	 * vfs_mkdir() may succeed and leave the dentry passed
> -	 * to it unhashed and negative. If that happens, try to
> -	 * lookup a new hashed and positive dentry.
> -	 */
> -	d = ovl_lookup_upper(ofs, dentry->d_name.name, dentry->d_parent,
> -			     dentry->d_name.len);
> -	if (IS_ERR(d)) {
> -		pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
> -			dentry, err);
> -		return PTR_ERR(d);
> -	}
> -	dput(dentry);
> -	*newdentry = d;
> -
> -	return 0;
> -}
> -
>  struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>  			       struct dentry *newdentry, struct ovl_cattr *attr)
>  {
> @@ -191,7 +160,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>  
>  		case S_IFDIR:
>  			/* mkdir is special... */
> -			err =  ovl_mkdir_real(ofs, dir, &newdentry, attr->mode);
> +			newdentry =  ovl_do_mkdir(ofs, dir, newdentry, attr->mode);
> +			err = PTR_ERR_OR_ZERO(newdentry);
>  			break;
>  
>  		case S_IFCHR:
> @@ -219,7 +189,8 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
>  	}
>  out:
>  	if (err) {
> -		dput(newdentry);
> +		if (!IS_ERR(newdentry))
> +			dput(newdentry);
>  		return ERR_PTR(err);
>  	}
>  	return newdentry;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0021e2025020..6f2f8f4cfbbc 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -241,13 +241,14 @@ static inline int ovl_do_create(struct ovl_fs *ofs,
>  	return err;
>  }
>  
> -static inline int ovl_do_mkdir(struct ovl_fs *ofs,
> -			       struct inode *dir, struct dentry *dentry,
> -			       umode_t mode)
> +static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
> +					  struct inode *dir,
> +					  struct dentry *dentry,
> +					  umode_t mode)
>  {
> -	int err = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> -	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
> -	return err;
> +	dentry = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
> +	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(dentry));
> +	return dentry;
>  }
>  
>  static inline int ovl_do_mknod(struct ovl_fs *ofs,
> @@ -838,8 +839,6 @@ struct ovl_cattr {
>  
>  #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
>  
> -int ovl_mkdir_real(struct ovl_fs *ofs, struct inode *dir,
> -		   struct dentry **newdentry, umode_t mode);
>  struct dentry *ovl_create_real(struct ovl_fs *ofs,
>  			       struct inode *dir, struct dentry *newdentry,
>  			       struct ovl_cattr *attr);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 61e21c3129e8..b63474d1b064 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -327,9 +327,10 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
>  			goto retry;
>  		}
>  
> -		err = ovl_mkdir_real(ofs, dir, &work, attr.ia_mode);
> -		if (err)
> -			goto out_dput;
> +		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> +		err = PTR_ERR(work);
> +		if (IS_ERR(work))
> +			goto out_err;
>  
>  		/* Weird filesystem returning with hashed negative (kernfs)? */
>  		err = -EINVAL;
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index fe29acef5872..8554aa5a1059 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -206,8 +206,8 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
>  {
>  	struct mnt_idmap *idmap;
>  	struct path path;
> -	struct dentry *dentry;
> -	int err;
> +	struct dentry *dentry, *d;
> +	int err = 0;
>  
>  	dentry = ksmbd_vfs_kern_path_create(work, name,
>  					    LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
> @@ -222,27 +222,15 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
>  
>  	idmap = mnt_idmap(path.mnt);
>  	mode |= S_IFDIR;
> -	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> -	if (!err && d_unhashed(dentry)) {
> -		struct dentry *d;
> -
> -		d = lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
> -			       dentry->d_name.len);
> -		if (IS_ERR(d)) {
> -			err = PTR_ERR(d);
> -			goto out_err;
> -		}
> -		if (unlikely(d_is_negative(d))) {
> -			dput(d);
> -			err = -ENOENT;
> -			goto out_err;
> -		}
> -
> -		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
> -		dput(d);
> -	}
> +	d = dentry;
> +	dentry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
> +	if (IS_ERR(dentry))
> +		err = PTR_ERR(dentry);
> +	else if (d_is_negative(dentry))
> +		err = -ENOENT;
> +	if (!err && dentry != d)
> +		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(dentry));
>  
> -out_err:
>  	done_path_create(&path, dentry);
>  	if (err)
>  		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index c287c755f2c5..3537f3cca6d5 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -167,10 +167,11 @@ xrep_orphanage_create(
>  	 * directory to control access to a file we put in here.
>  	 */
>  	if (d_really_is_negative(orphanage_dentry)) {
> -		error = vfs_mkdir(&nop_mnt_idmap, root_inode, orphanage_dentry,
> -				0750);
> -		if (error)
> -			goto out_dput_orphanage;
> +		orphanage_dentry = vfs_mkdir(&nop_mnt_idmap, root_inode,
> +					     orphanage_dentry, 0750);
> +		error = PTR_ERR(orphanage_dentry);
> +		if (IS_ERR(orphanage_dentry))
> +			goto out_unlock_root;
>  	}
>  
>  	/* Not a directory? Bail out. */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8f4fbecd40fc..eaad8e31c0d4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1971,8 +1971,8 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
>   */
>  int vfs_create(struct mnt_idmap *, struct inode *,
>  	       struct dentry *, umode_t, bool);
> -int vfs_mkdir(struct mnt_idmap *, struct inode *,
> -	      struct dentry *, umode_t);
> +struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
> +			 struct dentry *, umode_t);
>  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
>                umode_t, dev_t);
>  int vfs_symlink(struct mnt_idmap *, struct inode *,


-- 
Chuck Lever

