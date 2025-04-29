Return-Path: <linux-fsdevel+bounces-47588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FEAA09D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF7D7AA50B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D6F2C2AD0;
	Tue, 29 Apr 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qx75a7Vd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hc1mr+kB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E752C17B8;
	Tue, 29 Apr 2025 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926448; cv=fail; b=hgWJ2yer2bJYznOfqVtr/2Zpk7y/1alkPtNM4Iv+TGO9yLiv7zz1IMUU7xtLlKuWrdCuyPLNQu3W4Lkltnivk1pUzND5b214KanwBenlnM5j75uQIyTZEVNJRoaH2zqws8ea8t+G3dEgKTc3cdzqovVsItVwO3IeLgP/mBQM2bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926448; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QHwlQ1OS2N3wrodr7TQfuNWStwBQ74NNpiKr6qmIk4UYr2xCt2ISRlfC1//lsB0qHmFNRTax1bsmFcSJolan9e4X5sGW03Sf09kggY33Pftz9HgRa48u/KaJzHjsbmMM9qlXIDQLI0vZCW+yznqLNUyHRzDWrFQrImp7b7LSYt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Qx75a7Vd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hc1mr+kB; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745926447; x=1777462447;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Qx75a7VdpnRCQ8g9s/0hNT8CIBacg7869W/RM7K9SkNPjWVM1BjkOcsm
   rjauFk5N+63xqtOuwhzN2VSCqi645J9iLETKgaS2NODU9Emz+jC4hXzpI
   Ep6pXQhZNUEo6E7z72HV28p3LqgDJjwMWpZh7cpyi1E60CZUdv7+lD0Qp
   VuXtEnIRC6o4gW8AMTIqet5rQyu1OsN62ozO3DjPY2D+0qeTzGUApmnWU
   HMRjxlyIbCwMRK1N+Xkc2GBBxpkYKfDzWq6fR5jkezaji+7pjdnpRS36z
   njeEBXrKoIwk5/UHCFGViLeBZtW+e88sRUObZveKRJKGhHa6AGyhg2h9W
   Q==;
X-CSE-ConnectionGUID: 30jw+cSGRySRgJ0Kji5yxg==
X-CSE-MsgGUID: MtRnKnzATlCDiSI6obxnSg==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="83694433"
Received: from mail-westcentralusazlp17010006.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.6])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:34:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDgJo0gGvZgbJ8NTiaey9XZdbBfXtfh/oKSSyytEcbHnNcP8/dv1KYpD+getWXqm3243FeDWHwIVQRWv9iyDZt1fTdJuW+JCkmVYdO08eLKJ+QUKp0N8xPM2tcAFwJ6H3Tcy1QwABOY/rXFH5x8d6Zed+48jXBPwr5Y3YNMwp8nbEyFNibXKDxSq86a7Ta8vQG3zwdfIyHDmMxASSgszv/dWW7CYytL713J4PzSk5BIrncXBOdIjhvlwt5bYApeXPUG9+UoeeBGVSrcImbV6CAgD4HJWxOpEDaJzrL+ZYjZYtM+ynpYA3byZK8RMO+OpHwPDHqfcpxGx1TpDnC6/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Itf314QULCJZBlnIUSv4bm9hYj4AiNY60ku7LbV7V1J10gQBgegOcM1+MASQ6KCo51IJ4STk6N38KAdHR5inzGoHxLggGjrlzQFVsA8DyvUQh4oa050AD4tEpa1jKV0CxNmAzpZ9SnEAGuUxGaMOVH3G7kcncKAIk6CHtnJMY2md3CK/QOvvyQitBEakFJASVhDh7VsUViTNv1LioWfWphSfDw9SIdXQ+1svUn33082XH1ttwJnMRmy6Xf7QTbHDQKkvlqtSYBdEWJAchqftFGBk3tLWTo7QgDW1obN5Y+TTEncEYvN1FTOyExhvP04kZ6iD3mYVD+evIR3P1PYPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=hc1mr+kBQhJv8s7YGHAgi2iP4ujkWsktxARai8PSPRHimIBNeE9CcuGj342vyk3ClUtvHK4HKQsl54XfAB1KKgXcM0Ds0f5vaqUFrgBwrQJAGcWas8MDpWKs6wJQsB0h4cusulpextxz5CQqRbAH3lX5TnZs9Gvxm2gr/SU6zfQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9606.namprd04.prod.outlook.com (2603:10b6:8:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 11:34:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:34:02 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Md. Haris
 Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, Coly Li
	<colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, Carlos
 Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 09/17] dm-integrity: use bio_add_virt_nofail
Thread-Topic: [PATCH 09/17] dm-integrity: use bio_add_virt_nofail
Thread-Index: AQHbs5MdJjRlMysiJkKkFKY/dEw2MrO6jg8A
Date: Tue, 29 Apr 2025 11:34:02 +0000
Message-ID: <2462a34e-9ef1-4242-ae27-e661ff55401b@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-10-hch@lst.de>
In-Reply-To: <20250422142628.1553523-10-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9606:EE_
x-ms-office365-filtering-correlation-id: 6e87c7d9-4736-4a32-47b0-08dd8711be0d
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkVESGdUN29CWmRzdHRJQ3pxdk9LdStqVy9vb00wYzJpUE15SVlkNCtrbXVw?=
 =?utf-8?B?YmFRaDJHeU5RSjUzU2x5OWhpb3E4TzgxMlR2R3Z2R2hEQllTLy9JanN5SDZs?=
 =?utf-8?B?NThiVkF0ODh0KzU1eTI5QTdRMUtmaTM1V0ZmVnpTeEZRbHQxYkRTUkwraEtv?=
 =?utf-8?B?WmlOb25sUms1TFIrNVRRbWwxSi80Q3BnZC9EQUMyMm0zSDhvdUdzRVZtVEtt?=
 =?utf-8?B?bm1ZTjhZdEN5emhSOHIxNEJsbGVqOERhYnBjVURIaFRzVVgxb3JEdFZpSnRy?=
 =?utf-8?B?dmZ3MTF3TTIyYStxSGZhRHBxcFpyNExkWlY0cUdhNFpCWFJ5MGVuZ2w3LzFQ?=
 =?utf-8?B?MytRSTFWR1RRWUZNYktMZlVDN09lN3ZTdWRGMy96RWViZ1ZkQ3pMZDJNMVJs?=
 =?utf-8?B?SFAyN2tJY3BaSnVlSWorZU9OMm5PY1BKblV6RzBWdkJrQTRrd2NtNXA5Y0hR?=
 =?utf-8?B?UDBPR3lZaldFa1dhNkVPS0J4UVdNekJhV21sb3ZpSTZzOXhFT1FJYUdXRkJ6?=
 =?utf-8?B?bEVOdEs3SU5wbHpsdTZwSTZJY0RUcVhoSzlOMERHcHhlREUyWGlKTFRRcDV5?=
 =?utf-8?B?d0x0dGZLendDRUVOY0dMNUlhZkw0SE0rZ0doQkFyU0hIWDFBZEhDK2FMNm43?=
 =?utf-8?B?b3huWTdZVlBvcE5DcFo1enZuTTV4NXV5TVJIcjAvZ3YvUTlRSHdicmdjU21V?=
 =?utf-8?B?d2VVVkEzS3ErUEhyWVRoZlF0cVVEZmQrb1dsMm1EVXJEZVJkZ0dFZTJPYTMz?=
 =?utf-8?B?ZHFTenlldTJJa1VuL1BINjhOV0xlL3VUMG9BRmJKbXBFbUJhSFRIQStjK1dJ?=
 =?utf-8?B?aFd1a1ZZeUF1ak9HZCtpWXV6KzJXV1o2dW84TVpLU1NuUDBZdk85blJ1STZV?=
 =?utf-8?B?K2tacHBQcXJISVZsKzVCT0lFZnErcnhTUWVTL2s4SXlmNkZKdDFvbXJvL2ND?=
 =?utf-8?B?amZXenRUdmNOT0FGakpLcy8ySUJncDI5TEJOblZxL2pPVktxajZGeXZlRFpC?=
 =?utf-8?B?K3ZzVEZCSVZxV3hqd1FDTjhTZytpU0E3Qk41OG5yWnNMMWhaVzlBTlgzeWJ2?=
 =?utf-8?B?aDh1UURjeEtwYlN1cFZ0WUdDN2NHL3lTSVYxTnZSM0t1Um9EL1RwRytPbFBx?=
 =?utf-8?B?UnJWT1hGRngwVXBvK24ra1NkL1ZxMk1GME5pbHJoSjhGeU0zcGFiTjlSb0JM?=
 =?utf-8?B?cjVwR01ZZ1RrMUZhTGNHSzhhTHIwV3lQUURwZnFlZGRTTGZyZ3ZMVnBKblpq?=
 =?utf-8?B?bTF6ckVzMEV5SXovUVZLSkNSYndVUGxrTFBVN3EzVGplRk9CbFhBNXBuNnF4?=
 =?utf-8?B?M0FaVUVSc3Z1WTUwV2F0T052NnFxOHpZSXVwTFQxNEx0Q2VCUzJvaDBYKyti?=
 =?utf-8?B?RXlEZmVNVmJHM0lxVHgreWUrRmFGczI1MzkxYlVqUW1ydmZRcDJPblArWlQ0?=
 =?utf-8?B?ZTlmenExUTZZOGF5NGdlVFZYWkxVVmRjQnFYNW9tVlo3RVBXNlFwZGpGaWZJ?=
 =?utf-8?B?eWUvSW1mbDNzQmF3aitkbWhReE1rdDZJTWhzd1ZRZE1OMFRQdmdMSk5VOFQ4?=
 =?utf-8?B?a2hrSWl4RUtJck1mL3dkUmZEZy84R2pEeDNIMWFUT1FUSXJXanZwcUwwTU5u?=
 =?utf-8?B?RDkxa21jbSsweXVhTFFUcmRKYkQvTlBHQytUSjI0bmRUcnNkK1poTlowL0xi?=
 =?utf-8?B?a1VOd1EzbE1KaXJxSEpWQXhmVjltRzZDeG1qclVBTDAya2FGNHIvMTVJUkRG?=
 =?utf-8?B?WU1aVlRWcEpQK3l2a25sRmZXYmQ5RHVEcjlHTGp4NEFjdXRNdlR5V3VUUEN4?=
 =?utf-8?B?dzFZYWR4aDZ4ZFd6TXRrVnBnOGw2ckRsTno3ZU83NlJuVkFhZDVJMENjOU03?=
 =?utf-8?B?UlJUYzJXZVhLYTVFSmg2OFlWYlpIalFmUXFSSEVHektwMWx3d1p0YlJYZ0R0?=
 =?utf-8?B?YTd3L09BQmZzWTZQeFpnejI0ZFdQMW9GUEVWRWxYWmt0cjBrS0NVUEtIRzR5?=
 =?utf-8?B?eGhVTi9Ha3VBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGt4Q2EyODdZaEhLSkRNSmFwM1JrSkJsRXhMT3A4NE81Z2x6NGE2VS9qQ1B6?=
 =?utf-8?B?YlE3aXo4cG5MWVdwVEV4Q2x1VmlyWjhJV21qSDRhRnpWU0J4R1A3WFRGQzdP?=
 =?utf-8?B?UDBBcXFEL21EYUVkL0JMbjhMTWZiVjN4a2xrSkd6YndIRlNVbEtPSEg2d1NP?=
 =?utf-8?B?MVBQaG9oM2FxeUZMWlI5aVZqRU1pS1ZNTC81S0c0RW90WjZTdUp3dVR0SUV1?=
 =?utf-8?B?UTIyc3NXcDhSb2J1UWRJN3NWQ3FqdjZmd2J3cXFIRmprMytTMk5iUlZodmNi?=
 =?utf-8?B?OEVVMWRnUUZ2UnhIRGFqTVE4b0Z3U1dhR3QwdUpJSXluODRVU0VleDhkQVQy?=
 =?utf-8?B?MXJHU29yWU1WTm04ajhyek93dDIrNSt0VTBnczNCYVdERjhwU3dod0xWVW5T?=
 =?utf-8?B?YkcvWDV3ek5aWjlNeFhQelZKejB5RWFqWEpZZFVMc1VNdkRSUnMwTzNEZVE5?=
 =?utf-8?B?Sy93UmVmREJCRHJjVytkVU1NZjB4Q0d5NisxclY5azNWcHhrdUVWVFdLTkkz?=
 =?utf-8?B?RXVxcnovRDNjRW05SHdiVzUzdWwxbGh0VUthbER3MWtoMkt4RnVBeG5iUXda?=
 =?utf-8?B?eGk4RGVRbTVsRU42ZWx2N3dzcDVUak44bmdIYWlReFJwWG1zaXhsMStraCtE?=
 =?utf-8?B?V2c2VThtWkVpaDhEMmlCVlNobWhyZzlOdFc1NWhXWXd0THZVSHlTL2l5MTVG?=
 =?utf-8?B?c0R2eXZSYVkxanZ6cWJ5ejFKRmZBMWFWOVhNUnduRGFxeG8xR2RVMWpLOTNT?=
 =?utf-8?B?Y1FZT2xwSURza1ZvUU9tbmxNbC8ycVBwY2x4eHh0YkJ2SlpUazdzWVBmL3pV?=
 =?utf-8?B?TTlYOUg1Ni90Qk5Qb0plWUtMRkQyWDJwT0wrV3FMNnRlRGs1NGJRdEk1ekw3?=
 =?utf-8?B?QkNGT0wvKzMwbm9TMGlMOUFyamRxc09LSXRteEF6S3lvSlltaW1STVp6STdl?=
 =?utf-8?B?TkdlMVhNcXY0TjFtQVdGSnExTGZHUlI1akpGeXpjSGhYMEFlcTNhZ0Z5Q0la?=
 =?utf-8?B?dExiaDBPZ1VFRkUvcUNwTDFZZ3prQ2orRTR5djFFMTc5MThHdUY4QlkwbHor?=
 =?utf-8?B?bjVNYkdzZjFFb2lOMHNqdzRrcmRVQ3RDWG1FWWMvcXQxMERpQ0RVemc5ZmhH?=
 =?utf-8?B?OEN4dDlMWVg3SXRuem40clc1KzhGc3N3VlllVHVIZDBHcXp6TWtaV29tRTMw?=
 =?utf-8?B?V2RCY3I4MGoyT3Q4UmJkMjhobFNCOHZXcHEwOVYzaXVTVnBHTDI3YjB0SlNS?=
 =?utf-8?B?SVN0d3JhaFZjZ24wVTZlZDY2NGYzVzg2anNuVFlkdEZJM0ZwV0VOcE1pNUR4?=
 =?utf-8?B?eUNKUmx5TkpDZVNPWmd4NTRmZmFQRnhjZ2kzdm9pOUY4WGdnRG1DMUpCUE9J?=
 =?utf-8?B?RHB1Sy9EL0xYYnczMU9YQWwreFoycCtSSUNRVjFMdytNNGFKMUtUTlNWOEI2?=
 =?utf-8?B?Tlk3TzBGbkpqRTA4VGY2TDFIajhnTVdLVG4yWnEwNjgzcXNzTGY2dmhQcXl4?=
 =?utf-8?B?OEVQLys0Y1hhZDFPUGZsemtrMXo1T1J4K3cyUnJVTUNrdGVheXp2ZGlxSmkv?=
 =?utf-8?B?UUJRMTd2SU1hbFdiTktyeFJGTjJYRmZiaVZzcWhQVTBwOFJtZDlSek0zYzdw?=
 =?utf-8?B?NkQ1YTNNQS9YWjF1a0hubjRTaTJhaWxXQmorY2N6UDFPUGN6U1FINE1HVjRF?=
 =?utf-8?B?R2hSaG1KVWFCV2tDOXJnR0xxdG5NdG51WEhrRnNiTFppWUdUblUzLzVSOTFK?=
 =?utf-8?B?S2pqRmZlM3NuSUU2Y0dFSzFHaG04aDdVNFhMNFIvaFNUSVZoR0pEUDA5VE85?=
 =?utf-8?B?dkxkVzBBaXVEenBidUNkdHp5ZDc4YzdCSDZDNzhGeE4rdTQyUWY5NW01NVZ4?=
 =?utf-8?B?UWRzRE9MSmp4dmR4Yk9LbmtRSnFjMEJPNnk4UUtTM3FWcWdNQjRxVWpXT3Nm?=
 =?utf-8?B?TVFYK2ZVR3JpOFZrQTJtSFN2aExLNlZQVUI1TzZDNlloWGZHYjhjOXhXc2dz?=
 =?utf-8?B?UHo4VkhtK3hGbkxzQk1Tb3ZRSGR6TVJXR2R5Q0hEek9RNWx4a3dEWXM5NVJU?=
 =?utf-8?B?dStSdWx2czNzdFI4R1R0Mkh5WUl3SHJ2dXdXQnMwdkdYc3UwRTB6djJwOXVZ?=
 =?utf-8?B?dWx1MUNkSnZ5K3R3Zm5IVllJYjhPT2tEQ2ZQVDJZaE5VUTducjV3SUdJdUx2?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE9CB8B54A0A924FA7B9638A4B6FD5DA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bSfuMCpxCY+CRXQ450lK59GyhOAftyJ1p4JQ73578DYEvPEs+XLAtXjWyKXzlLIh0HbM93aClkWoYcAamhiWdCQ1PXq4dMP96qGK9eo4bpoBThdbI1vR3stAlA2yRMZ5gqjq7xOzVTIn85ctNdDgRUjwiRu+dMNCmwmfzVw02yZBL1NXiW9qep/lvOyKUCOiX4eELoUNeNYslkwFI4A7+5v8y+tOlpbBNplJolPbQbQKTDCpdVUHah2Hz8aax9FqpIzCukhGzxmJ/+9Gu16vY6pq/NbAUBAlDU3R0wnIoJ32LsP9oPQSNQZGBIUAATTOU5URWj6NBhjAKhFTksG9UfKDzm+MKB7Mu3yjmVNQErwfp/pjUmdB4Gdg/SiPfgUl/5MUD/uoDnyZCf9X6K4tz1BNs+WhLxL3EUzBbRV8iRnpXk+lPtDmQEoMLjITA8cOOxdBFyYeNU6aRgEU3tH1I299hujK9YnS4JNPdLa7OhRDTVE24atm052Xln0ls3ivRLDLAAPJfl3xmjGymoUQc2yfWB9/waw4BkpCL7y2/2HMS885BYcwrTCMMN6IIh6vD4OstMfP5JmenwAf67Q3XAVMuVo2gokYX5tSQKhG+XS21JK/4YwLrhK029Pgwjju
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e87c7d9-4736-4a32-47b0-08dd8711be0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:34:02.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7iUN5qEMMH8wYkJn8VpITNC6xa13QMaDdDhkDdJGIiQ4vJKKpFgB5sv7TZoJY8O5cWFvae0LZ/ZfzZb+jvFL8YSgtj8xSKjP6jEUYJWec8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9606

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

