Return-Path: <linux-fsdevel+bounces-47591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7355AA0A99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1474818BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE462D92CB;
	Tue, 29 Apr 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OW5qHzw5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GPxwYj/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97132D3234;
	Tue, 29 Apr 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927084; cv=fail; b=mS092Wn4rsuCdeIUuw0FHar3mOcKmjDhNBIRxojjOKzv23FOiaTcHeEFmw4CJBuk1iPVQNgq4S+PvuJlXgI0f6MgR4vgXd6WevRJCju5y50GJX2ZLCmoaK6YNQVlvAR+L6ChxdLLbX+VEjjIfyIkyXFXdZTU1pUNZQRSOvcuJ+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927084; c=relaxed/simple;
	bh=8sdMevESB89JLf2azxRD9OL2+ON2/bVzZWNxrcJXa2Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wtw37hZ4SJT7jWc/0FSrdYqJk7Ve+fVx2tpYwZA2ECVhOwheVR8UY8dhP2JLkEVJaeRkaKSXUJyUqhPhIy+woB0P+SU8RgTgT5rTpEXInAWX34Yo83qy9ljEQ//4Unr3NCNN9bjvMs9EOVpEo6aXkNPNhGmy0cQs7U4dvetNX1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OW5qHzw5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GPxwYj/D; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745927083; x=1777463083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8sdMevESB89JLf2azxRD9OL2+ON2/bVzZWNxrcJXa2Y=;
  b=OW5qHzw5AZw6wmyjvR0UxE44aM4Eitta/UcZ7t9q7R8K0Jj1JiV8vm0C
   dO9RL74qb+tZ46mp/NxhEy2yX3sdFaJSJ1p2fxcfSFyyGsgkpgiy1vvEv
   g2/5oRv3+kojz1Zk3MFEZQQwKZ+fUTMcjBm/scs/3KElnTL4YlU6Zz0pe
   eWnST+n7e/x6+0vwsefMWDDUfxl00JvAl+ezAnTjBxXhvXnXW4VoxT+Yp
   aFBZ5pgqkLBnM49EqX61LRdoPMDAbHWKAOcEGa8llRIax6KANdicqajJf
   ntbaRDUQmyG6FAfsypHI18N8pEHuWZE21loirk2j8Hzv3bmxvhOXyxnJ2
   A==;
X-CSE-ConnectionGUID: 4Zh6hLs2R76AleLX4pt9rA==
X-CSE-MsgGUID: bR1EW2hwRqKUTV7ZqdjI1w==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="78106706"
Received: from mail-southcentralusazlp17011029.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.14.29])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:44:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcvjg50Xud/sd2ko76jjIMUOXARX3Ble1G8EJMpO+lw35EfD9QasL77W9VXwl0nrLPaeKnmZSzHMgIM7f/6PQ+X8/2nZYNZCG1Qq5JH0tIi29B/4JyxUW13nYqgQ7NgNiuGFzVfGfEWTKehp1q/9zEEMytpo1QQ4o9BBNmoTSkM2Jz5ypGjUCMyxmBpjsZHV6hr6taMBTxeWT89QyF3rRlIRRPDXmpn2myZdSOQKZVvmPXDNrgBEh8XcdXChNmL00ZJtVQbxmKWoFX22CSAjVqbClI7sUk/gvX0LCaav3KZ9BE/SGtId8/rVDJxboAfZT4SXQHgi1b/ya3up2OlHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sdMevESB89JLf2azxRD9OL2+ON2/bVzZWNxrcJXa2Y=;
 b=j8VFLN3V4IHIPOrdMXjshtieXtcNoid2WBVe+QXfSaCwBMG6cBcEtm3Y+gnQfeIGrIFuo+/1GfEUCanW8Uek9IK4nSPRQBm/TGfCz3NUDki21Z4lLGt8KIDbBZYwE5Hy1bWBU6OR8VeGsBmM/cQwKlPeJt+uPPsMLOYEiQI30gLoVpm00aI4XlimPkYEjPKyrMyzDiHesu+Y22djnpZGuDKKIxK6ilDC5SBxG8LRpKFhxfyG84IX93RvFfxV5rNLhENvcid1D9kyI5s5MRwxuiC80qCcE80jbmv2/0rZlYJoqJCBDxUJ7qn6DBsTsHf4IeH+VCWeAewNpNfAVEGNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sdMevESB89JLf2azxRD9OL2+ON2/bVzZWNxrcJXa2Y=;
 b=GPxwYj/DYR9HS4YmGgbijabrC2CsT7+zmGGzT62Yx6IQzSoBoSZNZmmpq6k43wanZvWfC+PzYls8R/WrG8uvCC8bR6oDiHS6sB5FlqJFzQDCbgYuY0gyHvXW3+bAbAg/XHpv4F22o1Y33XPqph57C8CDa5gFd5O7HlksV7nrsaU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7749.namprd04.prod.outlook.com (2603:10b6:8:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 11:44:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:44:37 +0000
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
Subject: Re: [PATCH 16/17] zonefs: use bdev_rw_virt in zonefs_read_super
Thread-Topic: [PATCH 16/17] zonefs: use bdev_rw_virt in zonefs_read_super
Thread-Index: AQHbs5NCsApnumLUj0qUhg7QHMkuhbO6kQSA
Date: Tue, 29 Apr 2025 11:44:37 +0000
Message-ID: <1116a2c2-9f33-4a2a-8d59-6b1d0a644949@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-17-hch@lst.de>
In-Reply-To: <20250422142628.1553523-17-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7749:EE_
x-ms-office365-filtering-correlation-id: ebdc82bb-8aac-415e-3569-08dd87133889
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WndKN3dzb0VGOUF4OGQzcCsycHhkeG1kclJLTnh6bmF3THVJdVNZMmFJNlh1?=
 =?utf-8?B?ZGhJV0hCUVcxWENwOExPWGEvVmQrQkliMTNDTU5ERnZmRFI5M1ltcTJYNkJ2?=
 =?utf-8?B?WnlsRmpZOUJ5L0djakQ1eG5DWHRDUHB1SkZMTEF5M3ZQREpIcWdlWnlJQ3RG?=
 =?utf-8?B?SFNWVDBpRUJPYWFWbGJwZ1ArVWlmTUhEQVJocjd4UnZObmdwbXIxMG4vOUFP?=
 =?utf-8?B?SVRCNlNuOWR2akNpVndRUzdQZG9ZV2FRKzl5UUdQVXVZTllFR3FiUnBBQk1J?=
 =?utf-8?B?dnFueEJUR0xPalFVRXh5QVlQVXdwaVFSc2svbCtySlRWYS84cHhlbW1WQXJC?=
 =?utf-8?B?bnREWE9sYW0yMStkN09xbnh4OFhHUm53eXNscEZxYzhpN01SSmtGOXpiVkNk?=
 =?utf-8?B?TmJpNEJJUHhZbGRhNkRBQTFzM3hnQTZXczB3aFRZaHRTNkptclRITmhsbFF6?=
 =?utf-8?B?TnNxQWtaeEJTS0JyVUxscFBFb2VlNm5Eb0NPR0ZMOGFJejYyVUxNWGJDRzdk?=
 =?utf-8?B?bktYYjg1a1NncWprc09QMVpMaWJxcTdLNGhTRitaT3o0NldwUFJXczlTVWd1?=
 =?utf-8?B?c0JxalE0dUw4aytMQ2tWUnpMamp2bXpiMGQ2MjlCL0pFdzVOWnhod2xWVEoy?=
 =?utf-8?B?UmZEbGUwUTFlRW85YXVNUll4cU45YkFSaytURitzMllMcURWMWlsMC9OM2Rj?=
 =?utf-8?B?OHBBQUFOcTQwcUYrSkVHQkw0eFlaK1ZMaU1samRCSEU4RHBSb3BnWnNrWldJ?=
 =?utf-8?B?RFdwSkdrTERWSmhPeGxveFg5WGZBRllNUGlEOGZ5NUNwYU02UnBiMTMyZkFk?=
 =?utf-8?B?YVRhSzNPdkRMalJjYlhnaG14dkdvYXgyUUc0Vk1xTzlKZi9FVkQ4elBQSXRh?=
 =?utf-8?B?Z2pOWmp2VWZyUXJjVW5mb1pPMndiQyt2R3Q0TEFueEd6NDAwSXMySVAwNUpS?=
 =?utf-8?B?eTJ2dEk1VVVHdVVVZmFGcU16am5KMHkvVEVuT2JYZ1YxNkFkZFp1UVA2aWV2?=
 =?utf-8?B?QXZUMm1nZUdrS05oUTdSWjlWRS9zUk5OTVRlcU1yamtWd1hVcU5vanVaNjBw?=
 =?utf-8?B?dHYwUVBHZXkxVmYxTE1vUjZNaGJPN1pjc1d4UEx1YVE4ZWx1THZIK09ERWFL?=
 =?utf-8?B?MjdwcHJwYlVROUhqRDlyRFY4UVRqUGhiM3VjZ3gvTGp2OTEyUDFaK0IydHJG?=
 =?utf-8?B?TWNkMHZtWlZIRTA2ZE9jaXFCRmJkS3kwVFFsbWs5LzBCZzJPNU5VWUF2RmhO?=
 =?utf-8?B?cGVTV1E4MWlwQ3N1K0JsVWhKN0d4TEFqT0ZUUGVnd3V6TE5XNUM0UHBUME52?=
 =?utf-8?B?emJJZDJoWGlGUnJYSHVtYkREd2J1TUgvN0Y0V0doL25EMVk4SDhSYnIzRFpu?=
 =?utf-8?B?Nm5jY1M0U1A3Ly9QWDg0eGFHdGhqdzdaajFnckp6aUkyZ0RhMGdtZll2UTBj?=
 =?utf-8?B?WlhQaTJKVHlEbFpTcHdIbkpRRTU1bm1NajNmNkpCZzNwWnZ1TkY0eDEzQU9S?=
 =?utf-8?B?L2M3czhtM3lUSkxFL1pOSkxiUGVueG82NCtVUll0ZG9oN3dORmhKMS9PUXpz?=
 =?utf-8?B?TjFIL0MwbmE4TmllcXVZMGdkaFIvNVdnd25sUjIrYTBxSml3UTR5TjZEMDha?=
 =?utf-8?B?aGd0T2hpTHdqVGk0UnEzbXRvMWE3TTkvTXNlVkhEMTB6aWRqSjNIZE4vTzdx?=
 =?utf-8?B?VTd3c3BpWVlVNGp0bmMvdnFQc0dOT1Z4dmJUYXQ5a0JtZE1ZTFBCODMzNmVE?=
 =?utf-8?B?QlorR1VsRzhXQUtZZzJyOCtXRTgxT1Z3QlRQd2VNQWRsV1JrTHQzaVF4QTBj?=
 =?utf-8?B?Y3VYRWJqQ0Z3RFo5cEZaTmx2Z1pkTGlvU0NLWnZPSTFURUl6aytzeHJyd1RT?=
 =?utf-8?B?ZlQxRzRteXNQWjV3c0hva0xYQ0QyalNmQ1JFdVlDTHRvOGRXVzBHY1IyUGM0?=
 =?utf-8?B?N0QvanlhengzRGdGRTNjQWFtTkllWUVoQ2xyMnJKQ1gzbXZlcWlGcE9NY1hV?=
 =?utf-8?B?Y1ZzcVJ3NG13PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlZnUnhFeVdNV0ZNcStMbjBHSWU4NkJobk9rMWI3Q3FZYUNyR2lnbjNxWmZN?=
 =?utf-8?B?bHpRU2l5UUM4UzlXYXF3a2JXUXYrM2o5c0hGRFNDMXJhRUltUGtMTms1Sjds?=
 =?utf-8?B?T0dtaTczaUUwYnVBZXNybVJKbWVFaU9yY1pvK0RUQ1dTZU5xbnptWVF3dEF3?=
 =?utf-8?B?RmVyenFaNmF6OUcwMEJKS2U3RTBXanlBV25oTXVISEpZdDdCRHgzVjM0NFR5?=
 =?utf-8?B?QmZUZ2t6YXhmYmFZalVReUN2U2NFSWlteEcyMEYvU3Y4Ym1KemFnMTVnby9q?=
 =?utf-8?B?OXdaYWhobmduRyt3emVDYVhzSzNJU3BrcWRuS2wxbmNGTW1JYVdsckZFUm8r?=
 =?utf-8?B?WUtPclpQUU5hOFNkSVJHM2ZxTCtmZFpZZnM4SnFIMTdGVHR5Z0dCNFYwWlE5?=
 =?utf-8?B?UW5QajYxRk83WjFmWWpaRStvblBhU3h6NmRtNjhyYzNZK0lMTnF2UWFlZ3Uz?=
 =?utf-8?B?bjZqcisxeGNwZzhBUmo4MGJSSjN4YnFFSFdyN2NsemJrZzl1U3lzWG84d0xP?=
 =?utf-8?B?NjVYTk9XdjlpUm9NNGczeWt1MGZpYlZUZXE2SjF3c1d2amhOY0xyRnhOMGd0?=
 =?utf-8?B?SERZYW5PUThJUTJRNUpucDBuZ3QzS2NOTjE0TUFYQ0dYNTB3WmNta1g5Q2lq?=
 =?utf-8?B?RGtneVJzc3JrclRqTEJEN3YvbnVaVUVNbk5GUGRlM1hrVWxYYUVTbVNtZlBG?=
 =?utf-8?B?ajduenV3T2V5VGdaekF6ZHpPdy9qcmU0SFRUeUFNb3NiUXJtdkJ3YjU3a3Uz?=
 =?utf-8?B?VWZqMjNkUGVITEJ2cTBBS0FvV3BKWjZNbDVKajFwR1AvSmQwVWpSVlRzR3Ry?=
 =?utf-8?B?dDFMWTN1STlKZ3dmRkZLc1hrcnhnMXI3NXY0NFMvYnpKd1JyMTNQMU1QOGIv?=
 =?utf-8?B?UmFaczJmYmhnMmE4NjcyUWhaR2FaYURhRXlPVjBqZ1JiUTNpYUIzeExZbDBu?=
 =?utf-8?B?Z1BjT3FsdFNxdk85VlZkQVdyZnpGRTRSSGVhdkhyVldiR0gybDFHQUhxZjVY?=
 =?utf-8?B?VFJsU3hjU0pqY0Y3dVRvZmhFeGNUM1ZzQlRRa2xpeTk4VVBIY1VJTktkTktP?=
 =?utf-8?B?S3o0bkVOOTJ6dzBRUTNpeTRpTzIxYjlsdU5uYyszU09yZFNpOTFmbCtIRmF0?=
 =?utf-8?B?cU5DSlI0OVFIVU5jTFcvUXhqbFlydGtoSDVZYnJzTTFGMkxacW9LSHNlK3hZ?=
 =?utf-8?B?eUJaM1k1RHBkbEROYW1wZlZseFppUVBwMkNuaHc0MXdxNXRSWXNFZmdLRys4?=
 =?utf-8?B?bnI5VnJteDYyM2FJajJEK21XRUZLRElvYVcwd01tTFZseVJ2VmMvTWNPaXA3?=
 =?utf-8?B?NHAyc0VxQUk5UkRKZUwvY2JxZEpxeWpwSytnS3BqOWcrVzRVQkh5TFpzSWRE?=
 =?utf-8?B?MU51ejliNHRiUnlrbHl2MjJLeFNjWEhEcUFFYTQ5NTZxNGdOL01xa29KdEo4?=
 =?utf-8?B?VXI0c2drWXRHUlZlVUNlbHpaK0pzTi90amlpRytjNUVJQVNXNHp3RWw3Yk95?=
 =?utf-8?B?b21wWVhwOE1PdDloUUVJY2pxWmpZNzk5L1UyN25ob1YyellDcGExWDBDVjY0?=
 =?utf-8?B?MVhvRWZNVlY0Y0YrSlQwS2t3MXp2VzBTSUxmcFFOc3JaTENvSy85dll3VjYv?=
 =?utf-8?B?ZXhFMG1sSE5NQlgzVEd5Vmt1OUxWVDlibnpWVWN1L05DTUVjcTFhcHdMRGNG?=
 =?utf-8?B?bkg2cjg3bHBEcWZ1MFJyRGVuTU9PU0dHbFlJYnRVS2owUC9QV1lEbWMyMTB5?=
 =?utf-8?B?OGVRQXJ0R2tzc05kZ2Y3SmoxRGV1Y2hWdHJZSmRTYTJVbVE0WC81TkRIQ0ZI?=
 =?utf-8?B?THpuQ3F0RVkwSUtZcU9JeHh0L0EyQk1GU3V5U0lSY0FlV3JFNXJxR2F3SzJr?=
 =?utf-8?B?eVZjREhsbUxyWXFudU81eUpCcW56OHBPSkJxcjduVVlzYk1jakpOMEdQUHBK?=
 =?utf-8?B?d0MyR01tV2RsZVhHeUxNVEN3b3hZdG94Ni8rYzZOaDZjTmVLSlNaTExwT2xC?=
 =?utf-8?B?RHIvc0Y4alhSRFkrUDlSK0tHenBLcWZSNEdrQUgwNUxLMVBwWTlqclRsM0J4?=
 =?utf-8?B?Y2EySCsrZUI0UjVtOHF2QzZZUDFuOEdCM1o4T09PVnM0d1VCem04eFc1UUQ5?=
 =?utf-8?B?Q2tYc3ROeS9hVGlnTERYd0NnVVR6Z2RxS1o0am9CVENJclBYeWlXamsvVGxY?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C684BA9B5255494AA0B5BF1342170F98@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EqP8qL1JyXBw5DwRaikVWPYMVTiuhZkeFFwimmYbgGsJ1UfjxW9A/EbYJppJnKKF9Zzz/jg75dsRMbtdh9E51wldz9lTIeqbQAZNO4JLgcJ9sXzW0glpZn1thgwiAS2UR91IdTyZn1lEIBA+vMbB6VLSfy544j73F7RjC/UGi/shAskzwI+FJDVu1glp5uJh+Pro+clij1cF3JxpH6L0gyuRlVwDfCWgE67rHISNWek/vuJmA/T2WncGreswaCm7zabzHxUniYvhHIcYV5i8G3mfA8z5dm9LCip8z2Jpp2an21Yt3rJ4htSYb/txVleSN/rSy/zu3RcWwevLPjdv4vRoNLK/QA4tA/H4stoZ/Te+Q3noiqhDO/af9nVoQWR5yj3YymOoGDEtwC0Kumb7VIwFfzra2uyuYK+12h8VcQY1yl5Un4YiIvL5aWQH8DL9xWY5It8rVN7K3elZks5Ue8XnPayKF+RZ2Qoar/J8dStFB62cOKgAjMyYsVqgGaaKvTKCZzaOCQwXDQsXV29h6HVL3mMvJNxptWLBPsrgqJD3Gv2pNPRLkt36Pk64xOVIKLDEGu8Sdu8EIbvl7sEcYuZC6i9YzlzF4iGJneFz7eFi/Hn68wjLTuMhRFu7d/mi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdc82bb-8aac-415e-3569-08dd87133889
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:44:37.8768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eox5SgAh/uhA7u+e+0JM7+OoPqjLbEmKFB/Zdd1BcgrcMiP+Zz5H0qdOB77XFRLUvoJJV7DW4DMSo66+LU2THitU9T5fz/6bHFlMlKaihh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7749

T24gMjIuMDQuMjUgMTY6MzEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArCXN1cGVyID0g
a21hbGxvYyhQQUdFX1NJWkUsIEdGUF9LRVJORUwpOw0KPiArCWlmICghc3VwZXIpDQoNClsuLi5d
DQoNCj4gKwlyZXQgPSBiZGV2X3J3X3ZpcnQoc2ItPnNfYmRldiwgMCwgc3VwZXIsIFBBR0VfU0la
RSwgUkVRX09QX1JFQUQpOw0KDQpDYW4gd2UgY2hhbmdlIHRoZXNlIHR3byBQQUdFX1NJWkUgaW50
byBaT05FRlNfU1VQRVJfU0laRSB3aGljaCBpcyANCnNlbWFudGljYWxseSBtb3JlIGNvcnJlY3Q/
DQoNCk90aGVyIHRoYW4gdGhhdCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

