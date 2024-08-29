Return-Path: <linux-fsdevel+bounces-27849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE080964788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF1EB2D21C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD191AD9FB;
	Thu, 29 Aug 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kvdBsfWo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WCDX9Ma1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DF1AD9ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939579; cv=fail; b=lmL0XbRVE8csQXVrGwot6N1jV/a9pwE26vaIMtzHoyYlGg3Saf2HJu+WsKAZGKOc4suhw4SnaV75jkSDS0makhfaKUdmLDhHHWb8yW5mReJXtcax5zB/58vjxPc3Zt/xXhgSiPurOLkig1YcRkpMbY87P2N1FopJgnhSVdEnUtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939579; c=relaxed/simple;
	bh=w8X3JQDRVoRLAz+9de3jRvXkuRAOX0YlY+KJNEzpkck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gm9V58JoyIomUcI4E2XdUDEt8Sk+/dZzukOpl233ZBiRD+nzA5hivvu2rFB0JGxygeojnnoVyoO0Z70rPFp0njNPX6aLizhxVpPIulsxh+4R4L5ud1y6+v+Gxy/OhYWhcqo+g20sQgEmTHNoeR0Yqga6YqbaXtp8i+4R6+obOPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kvdBsfWo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WCDX9Ma1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T95314017834;
	Thu, 29 Aug 2024 13:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=w8X3JQDRVoRLAz+9de3jRvXkuRAOX0YlY+KJNEzpk
	ck=; b=kvdBsfWoHQfGEC63rX2MticGK4HymbRUxx2sg9crlNA6SQRpJfJnubOxJ
	3t+uz3BlS//2uo7AJUSkviznfi2ABxsXsRes9RiS62U+EKHSceRAHakG/5LXwp3H
	ar7lAAj+cjublMvPV+YpGY/uinkudcZZByTCGWzQ1cajMFDl2uqolHSUTtcFoAfd
	kEWZO0bb2F3xuw3g/+ZXdf3gjSzD23ki8mwCRLELyzGGJhfbtS1P8qKaD13wEhfT
	A2uSd0iZ4Z5rJU7hplf5InLjc0+pwCtdJ8Uaxjwcxt+YPGItcxG53vUrAV7tfRCt
	iYFeKZbx/U2POQJ67yQfc3J+NwRXg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv46ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 13:52:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TDAlbO020212;
	Thu, 29 Aug 2024 13:52:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8qg1mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 13:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt70N1yj7HHbjL3zsWOk851mDOtlIt+Uu5y0yffpdSjq8i/2XOgDYIndO4J/4fBvgZ7MXZDtp5CidOIGCz1tieNY/qg5yFagb9fi1nPLjruaF3ixjtIqNVLyDd75mm0dO7r3uF+uWFLQ1eIrr7cNr5YjWlOkJEuVPClv/M9nAwoAQ2pBTYzofui4zuKyqlix6xLvlmuDBch5QBvemky533o7aQn/SiIipUuqygCRn4NbW2a80oWh+K5++tKTsIfQTM32/ETowvLNVPm5WYqWYKJMWY/X7nKNiRxTBlI7+0bMFpKgn3RaNz1TfDttHLdwilLZeN3Y4FlpN4tQ981X/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8X3JQDRVoRLAz+9de3jRvXkuRAOX0YlY+KJNEzpkck=;
 b=oWiI/KVwKgBsXHixZjoeH42InVYQ8iaBJwaFbiw3W7r6rs7jLd5iPTGR9JtlgFDUuFHVzl6W3iw1P31uIqtjODSEGJyDzNKLkqzXLaCa97JG6HAYjtdHZY/X+SvCcPRoc7o7jf6to7melxqBkWfIj9Gs11smL66Xpt3iAzrQ286GOKbUyfDYqIavqNr6scVf6bm2lPfyLmaE1qQY+BYNaO4P0U8w6MtTwAluscv8uk1uObtxZLD8wzNvPBRhnY1CwW8lHj7YpcV2/s8eq6tL/KTXBTLDqT5gYCGzvZ0yJufOTiGgq04PSRe8i9eqrYutUcjwEjlbrBMKbzIwOeEM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8X3JQDRVoRLAz+9de3jRvXkuRAOX0YlY+KJNEzpkck=;
 b=WCDX9Ma13z8yLbSaerlPfnMo0R7mn0ei4b0bTwf9FxEDWCEBF1w24OW6K+TWAwgYVW8+EM5uFEjeSD637DijBvlE+i8Vh/O5NeqwsaSVwIf5KSk1NshTeMxgxx1L5F1aFCG0Q0JbBF4dxcWzACOPyPuyoufK3+YLTPylkxYmmu0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 13:52:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 13:52:40 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>
CC: Matthew Wilcox <willy@infradead.org>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Darrick
 Wong <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Thread-Topic: VFS caching of file extents
Thread-Index: AQHa+YFET0z5DFUZKEiuNX9dRa3ms7I9erEAgAAiZQCAAKVHgA==
Date: Thu, 29 Aug 2024 13:52:40 +0000
Message-ID: <63DF6C8E-FB1A-4F32-BF4A-7D91A2BBA545@oracle.com>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org>
 <20240829015750.GB6216@frogsfrogsfrogs> <20240829040056.GA4142@lst.de>
In-Reply-To: <20240829040056.GA4142@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB7694:EE_
x-ms-office365-filtering-correlation-id: e77ad1af-696b-4028-5e9d-08dcc831d910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVhCZUhuK0FCSzV1cnNSOE1zbWY1OVBESzhWS2hFaEN0czFJR0dPYjZDT1Ft?=
 =?utf-8?B?Uk52ZzdjdDJCajdDOWJKczR2NmN2ZGU4SEkrTnY0VFFmZHNEakNIeWNMU0dZ?=
 =?utf-8?B?MkNTRmJsdVo3dXhJTWdORXBnRFk1NEFnZVVLWVNwZnBQRUlaUUpwdklBWGxS?=
 =?utf-8?B?SVZmckJqVEs5Zks2NkpNQ3VPdlJUSFI3dll4a1dLamsyQ1M1SzJSVmVtL3Yr?=
 =?utf-8?B?UGthcFd1VjdwVXFyUWJuWElVWkt0UCtTSU5aTHROeXJwYlJhMWMxbVhGODRw?=
 =?utf-8?B?SmpOMHBUSUxQZ2MrYXJJWE8wK0pzY3BpOHJaSy9SQXlLczI1YjNOVjRiS1ow?=
 =?utf-8?B?NHg3QW95ekRrNytTS0pXS1FraHF4aFBNaGs1czRmZGZzc1h2OUp5TTliZUI3?=
 =?utf-8?B?dWVLTjV2aFZFbHFieVZ0eXJNQ3hBNG1CWDhEVVBpYVVTeGN0RWc2RWxEK09x?=
 =?utf-8?B?NGEwWGlQUkwrOURKaGhYb1k4bWd5VzlJR1lRZHNGSExheVdFVE5BUFN0dlJQ?=
 =?utf-8?B?cmdldVJPYmIxMmxCQ2d0YmUvTnpyRVJwMURGRS93aEpyemZBVm0vQmpBd3hX?=
 =?utf-8?B?TWpLbjY1WEJmdGlnZDRTdHptTDV4ZjhSelRyb3cvdGNwczJEcm5yNkdla1h4?=
 =?utf-8?B?TEtiY2dVcFNSaW1mcHMrcyt3VFRtWUZXUWlwWVd4LzlzclMxYnJZQ1FRV0o0?=
 =?utf-8?B?a0ZsNVFnbmhqMDcvNXNPWi9wM2M0aVFxZ1hxUk9hR0J0enIxNU5EdVB5UGtF?=
 =?utf-8?B?NlZhME5vYVFvSm9PbEZnNHhZa1ZpMnpuME5BRFlFaHNlK0R6WCs1Ni9jZ0Yw?=
 =?utf-8?B?VkI2dU5oZEd3QzVYVFdwM3dYelpmYkU5UWV5K3IrS0pHaWV2QTZ1L2VaNnZU?=
 =?utf-8?B?R2hUQU5oajA2ckRQemdzMldvN1pmUEU2KzhjT0J0ZnhHd3NleEtiWnZ5ZWxx?=
 =?utf-8?B?V3lFWEwzZnpnUXl2WkJSUUlidk5mMVgvWnNKVXRqSlR5ai9mdTJQbTJ6T2ZX?=
 =?utf-8?B?YUJDejYySjdQS2daWjBOMWM5SEVnUWVBRHRON2ExRS9vVzJQK1VtUloxMTc0?=
 =?utf-8?B?OS95RUdBenlPdXB1YjZoamM4YTAvODNqOFpiMDQ3Q2dvMFVQZlJ0L2c2SnMw?=
 =?utf-8?B?T25LY2daY20wek13WGx2dFRMdU4wU0VYUkcveW1yOFlsbDBlanJYT29Da1Bo?=
 =?utf-8?B?NHdNNWlwQitYZmpkaVBLS2NGcUdEVVErK0krV3NTSlFyWENKTHg2MjdLcGx3?=
 =?utf-8?B?Z1BSUTZCZUlIcTcvVjgrejltejBTSXJtQWlDMFhSeDRrMTVYYTUvbTZucG9G?=
 =?utf-8?B?WEZqaWdYdmJFallEVTB1S0VHRTUwVys4VUx0YmdqUkJuQXZXd1dCakJSUmtY?=
 =?utf-8?B?RjFkRjNSMzVJNzV4N2RCYWhZL08xY1lueHh5QlJ6aVptVmFhQ0hsTVlZdnVs?=
 =?utf-8?B?Ty9EalI3TTcveTNORGN6NGxsdWtBWG84c2pPQjh3OUdjTE01OXhzTEtSQzE2?=
 =?utf-8?B?c0JBeGFabW9wVGZXczRKN3RKYjljK0NkM1NpNmJzMEdMZHNzMDF6czlhbTli?=
 =?utf-8?B?bHg5K2N0OUc1R1ZCaXdWQjlLV1BDSmJXc21CRmJEY1NMRnR3QmlPeEl3S3BP?=
 =?utf-8?B?RVFVdHpzaVQyVERpTCsyNTlPVkZWRTJJZk1kUkZMSFhFa2RCdGdXYWlDcEU0?=
 =?utf-8?B?OHYrd01LajhkMVNCcVEzT2RIcGFrVUxYU1U5dHB4LzJhKzJ5NklaL3NVTWdY?=
 =?utf-8?B?eFluK1ZyYkNBdkhxbERGQUcwWExXMHVjeVJjeGZjbllpaG5uRWZ3WlNZblBt?=
 =?utf-8?B?OVpOcnlOQ0pvdFpXeTEvTVhwa05lM1hqNkJQTmNodnRGeHhkVnZGdkVuVFlN?=
 =?utf-8?B?RCtDUTFlU2QyRzV1R3pIRnhQRGo3dTNuYm9ueDJ6aVFJU0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVo2c3B2MVJ4N1o0MDVYOThDUG12KytaOE1RNHVmMU04QTRKWlgxOXFadmMv?=
 =?utf-8?B?eGlzS05LcE83WlNYeFI4TEZvWTBSbGlRQlF0Z3dwYmxGa0xwRmFjbHhoUEpK?=
 =?utf-8?B?WVFmbjBxcFNNK0JjU3VSMXorUnF5c2NqMTVENDJQc3g5NmJNM0dyZFdpUDJ3?=
 =?utf-8?B?WnI5c3FuNzdIekEvdFAzcXRGU1hZdHRkdjlSYnVYUFQ0Wi9FcGpHY2FhNlJx?=
 =?utf-8?B?ZDJLR2FPQjNFNXpGcW9Pd2ZaSlh6aWhobk44blBvVGZFSnUrSTBEbVd3cU92?=
 =?utf-8?B?R21lMFF4N1JVMVdkcmZEbC8zdDc1YTZGK1VMTEVqazVOZ2dlNHdxUk5YdW5N?=
 =?utf-8?B?SEY1blF0ZXNmUlNCNmhNdVY3Mm9Ya1BZZWNKYXVta1hmR0d1cklEWE0vWlgw?=
 =?utf-8?B?VzBvdmNlL042Y3hIMWZ0cmdJQjJZSE03bTdueTgxUVpkSzZSc1ZQSDdOWXlH?=
 =?utf-8?B?bXRaV0J6aEZlUFRqL0lLMzh4eE1lRldsRmNISmQ0cG5zQzBaUEM0L3FqT0Nm?=
 =?utf-8?B?MndqeEttTnN6bEZMekEwNEdER3RkS1JUOW9XM29kWnlzQ1Y2TGQxWk9wVzNk?=
 =?utf-8?B?cTlzaFhHSmJ5ZklCdnEwekxqblpOSzVaSG5KdXg3ekNodlFGYjI3dkJwekpI?=
 =?utf-8?B?QXRqQzBjakdGOUk5RGRPcGlzUHZVVVlTbllBRXRMWUVyS0thN055aHFLYkpv?=
 =?utf-8?B?ZDhMNVdUN0Q1YmdzWHpIVnBBeVR1TlBIcUpQRlFrV0loN0E0dXRnUjRvT1F4?=
 =?utf-8?B?d2NteDlBbytyczJVMCtMUUVMbFUvb3UxT3k2V3hqZlRNMzNnbjJxdkh6dnJ5?=
 =?utf-8?B?UnBTZTVuWUZMV0E3YlhoVVBDZ3B1bFNiRzU5SkN2T3ZKaFNwR1RheCtXV3o1?=
 =?utf-8?B?clEram53c0ZVRk1sbkZISktxcTZqbkR5WDlPN3l3OUxhWVJNeEphaVNxbUVX?=
 =?utf-8?B?ODhucTFBMW1PV3pqVTRJOGRjVy9JaUVQOHhsVVN1aW5Tcy9ITDZUeHl3dG80?=
 =?utf-8?B?V0pIeEd5dmtWM0xlUk9YN2JwUGZnOUtuOVczbFJtK3dWWVVvQ0ZGSFZhM3ZM?=
 =?utf-8?B?ZmdaaU5ZWTZreFpQdW9ZcUN1dmlJQVJlNUI0UlZhWFFNeHFvejgxTWNRQjJS?=
 =?utf-8?B?VTJNMmRtTEkrU1hHMEdEMWxnM1FBWVdkVkx4ZkpwTEVtOEpaak5FVWxwekEx?=
 =?utf-8?B?V0xReEp6ak5PZXh3TlFKazdUZERINnYrM1JFRVNDb0lSOXBTNFNmTnNZZENk?=
 =?utf-8?B?enNyQ3lzTkI1TXhhWnZ5ZUVWSjBmS0ZYM0wySDk1VzJISlJGSW9nUkRpRnl0?=
 =?utf-8?B?RHEwUmVYdklzWWpGd2lwUVVFVHk5YS9CeVJVdkI1OWN3MlpISVJZN09DZGxD?=
 =?utf-8?B?aUh3Nis0VEljLzNLcU90VG9TV0FMY1JiakI3U0NUcVV5Z0t2ZFhiRXNyaVp5?=
 =?utf-8?B?RjgyU01FWGRvU0F3YjVYeWpodkFlKzVNeDR2NU5uenFBNUF2K0xaZTd5SXVX?=
 =?utf-8?B?WWdHWjEzL1lCZDhWYUJKNW80bkZzNW1yYStqTytyQTE3SWxFamRJRmhuN3BR?=
 =?utf-8?B?d0wvM2pkRHV5WHZJRTNjWUdRZFJEY3RCV3dkb0lETXZqQzVSUWFBMURsYjN6?=
 =?utf-8?B?dFRmOVRUZklGZThJaEYrU3p0TmlkOTZHUGdUYUs0Ri9ZbkdvT21RWUVHZnRi?=
 =?utf-8?B?MXpMQ3FLb25uTkF4aXBJQUxJVkNKcllMNTl5OENqWm00bitrRkNvQ0pPWEVZ?=
 =?utf-8?B?SVo4RWNXU0NyeFhEUDVEcmRKcEp6d0tWVFJnV2hmY2dHWDRNN0xyQ3J4eWRF?=
 =?utf-8?B?NXU5akRQY2oyMUExQmx0NlBoUTgvV2lINmNCQncvZ1kyQmluaU9oTkhLdWR2?=
 =?utf-8?B?ODI2eGN0WVdxRG9pVlB4TlJYSHV6L0pRSXQrZWNLa0lOQmI1U2ZuVnVnOStv?=
 =?utf-8?B?Tno2eE03MExXNTA1bFVHKzlnSHNQcXRDcVI4NXhHNWErNk9UYnFsYVVNM2hE?=
 =?utf-8?B?NzRycURJSVYwYXNjUURSRktEdjJsVmorRWM0S0lobjhSY2xudDlJbkZaY1I1?=
 =?utf-8?B?bjBsbGFLZFhTR2NZZkdnRDBVRk5vbjkzZ2ZYRXZnak1OYWlJdVIrYURvcWxl?=
 =?utf-8?B?M2dObFpyMElWQnBPTStQdzZCdHJmVlp4SGFwK05PeUVGUUsyLzZKWmNPTGw2?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEB487992D60E748ACC43DE23399E765@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kSulPzp65plNsq7XftbLcvq/YXwwveYrDW4ikJs8v4cuRpUXKyGG6hMQaAvgMbI7jf7hWKON2whYWRzNCIY2hTQhay5gUGCEHqbftF/5rtgOiU1AY7Ppy71F/otGjlpx+mmaDE1MtmEqH+gLL4FDEX2+lQ6+VLeCz42kVKeszPQ3Mxepi35DI2BGqjq9dd52ODL4EZXJ29iCK3c4UJHfkwL87/sZZ2djAKVOKn6WzgmulBy+gacQzNlReN/ECDrpRWJv0W6tev6m7Bt3UAT6hNHKHDFAGiu+9nj/pgmN1KP9lum1dL7rF6IOdkbWzyg9rP0X27X2MHhAXOpeUGv4bgfzOMq8sql75/+xsD9QI32kegdCj7tFtQoXnFLYMOpFNJhDNfWBvetkbnYrzAa/rSnSmrrC7kWIgyowtcHLDpWRAjuUr9D8tBPG81VwVqT9zWZGX5LUP1r0fKhcErmH3V4aPB0lKvCzBJ+4LU7ipmyopFa+bchlrLP4MHaQlmPy2wso+c4VAne2eIdi4jyLqc+jkxLarv2g1eZYmkz6PwDABTX7WhSaJMQiFxkoLH16D6Mj8rwrBJ6et9NcfYTvZITMWMHJujNkmPJ+0GKa4HM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77ad1af-696b-4028-5e9d-08dcc831d910
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 13:52:40.0305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJitmrTN4pMLyduWMaH8CRte6bOr0eih0kMKtisYrGhECPu4avA8vNxXIuRH6tSgME8BkV6uN3ZzaroJlq8Puw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=912
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408290095
X-Proofpoint-GUID: 9oosCBKmiFefIGlG2Zz06_8GivyQFH6q
X-Proofpoint-ORIG-GUID: 9oosCBKmiFefIGlG2Zz06_8GivyQFH6q

DQoNCj4gT24gQXVnIDI5LCAyMDI0LCBhdCAxMjowMOKAr0FNLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4gd3JvdGU6DQo+IA0KPj4gV291bGRuJ3QgcmVhZHBsdXMgKGFuZCBtYXliZSBh
IHNwYXJzZSBjb3B5IHByb2dyYW0pIHJhdGhlciBoYXZlDQo+PiBzb21ldGhpbmcgdGhhdCBpcyAi
U0VFS19EQVRBLCBmaWxsIHRoZSBidWZmZXIgd2l0aCBkYXRhIGZyb20gdGhhdCBmaWxlDQo+PiBw
b3NpdGlvbiwgYW5kIHRlbGwgbWUgd2hhdCBwb3MgdGhlIGRhdGEgY2FtZSBmcm9tIj8NCj4gDQo+
IE9yIHJhdGhlciBhIHJlYWQgb3BlcmF0aW9uIHRoYXQgcmV0dXJucyBhIGxlbmd0aCBidXQgbm8g
ZGF0YSBpZiB0aGVyZQ0KPiBpcyBhIGhvbGUuDQoNClRoYXQgaXMgZXNzZW50aWFsbHkgd2hhdCBS
RUFEX1BMVVMgZG9lcy4gVGhlICJIT0xFIiBhcnJheQ0KbWVtYmVycyBhcmUgYSBsZW5ndGguIFRo
ZSByZWNlaXZpbmcgY2xpZW50IGlzIHRoZW4gZnJlZQ0KdG8gcmVwcmVzZW50IHRoYXQgaG9sZSBp
biB3aGF0ZXZlciB3YXkgaXMgbW9zdCBjb252ZW5pZW50Lg0KDQpORlNEIGNhbiBjZXJ0YWlubHkg
aW1wbGVtZW50IFJFQURfUExVUyBzbyB0aGF0IGl0IHJldHVybnMNCm9ubHkgYSBzaW5nbGUgYXJy
YXkgZWxlbWVudCAtLSBhbmQgdGhhdCBlbGVtZW50IHdvdWxkIGJlDQplaXRoZXIgQ09OVEVOVCBv
ciBIT0xFIC0tIGluIGEgcG9zc2libHkgc2hvcnQgcmVhZCByZXN1bHQuDQooVGhhdCBtaWdodCBi
ZSB3aGF0IGl0IGlzIGRvaW5nIGFscmVhZHksIGNvbWUgdG8gdGhpbmsgb2YNCml0KS4NCg0KVGhl
IHByb2JsZW0gd2l0aCBTRUVLX0RBVEEgQUlVSSBpcyB0aGF0IFJFQURfUExVUyB3YW50cw0KYSBz
bmFwc2hvdCBvZiB0aGUgZmlsZSdzIHN0YXRlLiBTRUVLX0RBVEEgaXMgYSBzZXBhcmF0ZQ0Kb3Bl
cmF0aW9uLCBzbyBzb21lIGtpbmQgb2Ygc2VyaWFsaXphdGlvbiB3b3VsZCBiZQ0KbmVjZXNzYXJ5
IHRvIHByZXZlbnQgZmlsZSBjaGFuZ2VzIGJldHdlZW4gcmVhZHMgYW5kIHNlZWtzLg0KDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg==

