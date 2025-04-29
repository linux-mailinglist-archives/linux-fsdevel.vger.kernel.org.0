Return-Path: <linux-fsdevel+bounces-47586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD6AA09A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69B53AA0AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EEE2C1E32;
	Tue, 29 Apr 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AAAp2QVu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k5ORPUun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A2627604B;
	Tue, 29 Apr 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926368; cv=fail; b=NT88hvUQNJtUDTnY2dtHHauapLihSyTEBE4HZoy5NNpKTacTmaLS+s+UKmEHLOLN+izbdw4OWL3zsysdSYfOn/O2a0gnL3Hw8bkvX3Mn3wkJXUu0XRDt666V7svJUV/W5pH6bzuQS+DdAKGaPoBWOXlimjIKIi1EemS9+saxPzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926368; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pT46k6oDbAY/3taRD9nZOmHdI7RbL8mB0HW6EOCdAb48t9/rjnuipR+T6gJz1wxdBAMZSFavOIus0CKsQiIRukCTVK1OIKpTsiM7kwT9OIzcEdDYyIDDb6nCOhaIPAa6CWf3cPOLZc8KzuX5zdB8sZDaJoIeD46i478b79j2exU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=AAAp2QVu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=k5ORPUun; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745926367; x=1777462367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=AAAp2QVu11rUt1kTzapDK5JuSGmHQ5jB/BUG8kLHzDnuFHQ/MXkdE7Sc
   V8Luoz0tWJYacgTl0E8Y9HRd0j3fxCUHWVnpzLTHG50QZ/RZHu0Hv8qzi
   0lVKjzwzhgYLnOq6wZIWj6rc5ec00A74k3hiG7FMlI3BZ8xurQs/uH5Ao
   DvccIVWrq0yWdaWu19fKkkxnWug81yqeN9IROgLVjaFIXuLmqwV4/xuGf
   bsbJBN8F3l0UoA3irYWmcs79c8a3RhdKkl9KiRFuO4AE9kndnKceJy0RK
   9Qe7zb/WnHnGppoIK8KgSrVkWuc1W8TE3cU3ioMfL2XCgaAYJG1WCoDoX
   Q==;
X-CSE-ConnectionGUID: ij9bhUjqSneoicOHagyPhA==
X-CSE-MsgGUID: 9lepr/SLRR21u1mm5QLATA==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="78105772"
Received: from mail-southcentralusazlp17012013.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.13])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:32:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zN9IOlxdVHhJCND/HPrROnqI6RlraEXmBv2caR6fFpibwICdH2p8qYGGEC4Fd/PfpxMNOqSEDUJHEiH8sfpvoB3Vwt8vYf25we/aE1FUDzZg/mRRoMzCqPUjmLpKUg/d6T3f53iYOPHKLETbbzAo5C5vVE8wdSUTGRKugQUGeiu0izha2uaEY3ffsPjIzklAUQA7SiLy9sUuBXStG0UzxIdoYXqXKSJxHUKM4tQGEFBPLijF9VsAuZbKzmh8MSMDbvbV5cXWyeXq6o1Sus/Rr3nqKUFw+HZPvzAslswZ/PEHD9em50uYh/NWXYLTauGHr9tWlhxz//B8wdzrpOpovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XuUYPM8eIbIDMbv3VLoJ13JJG+Nc3PsK9tr0W01lMLnaoGIbkhgWZFZCTTnd8sh1+K6K2PfriENSwdPc9RaemBbq2A/Jf//5wSSJAYh3qcbm2hMZEzj8miBxhJveZMidMC365ng7whWh6rwf+7yxze+/0KqYSkiDNM+0595p0ER3lqQTiZtYYNjSJXaWIBYFcWLIzgXr3v29eikItVYe1gFoGxu3XVQKlH9WbW3f1g+J305eFDl5sHtWP/PDq6hkA8uSC8AQDxkfwNbNHN5WToJo4wrFqFEcKZLK2YHYkbhAtavvdHoEuBbMOy90Sm7/D0PldcruHnuSUOBU/WvPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=k5ORPUunyNcJhdYP5rlle3QWq5eJ8VJO0LC5hOS79Gcu/6Q+0owKHbWZZFdWduZDawI3u51pHchODLY9QN/1zpv+g8bna1wYbyMoRRHuhXj9HJb1Mrn6ZYd0dn3iPlEQn6pg5oyKwNkY8/Z3LnigsNMsNKqCiNrQyvRn+YGI9/Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9606.namprd04.prod.outlook.com (2603:10b6:8:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 11:32:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:32:42 +0000
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
Subject: Re: [PATCH 07/17] bcache: use bio_add_virt_nofail
Thread-Topic: [PATCH 07/17] bcache: use bio_add_virt_nofail
Thread-Index: AQHbs5MQRxbJxWDhlkKawoHiq7JvHLO6jbAA
Date: Tue, 29 Apr 2025 11:32:42 +0000
Message-ID: <ee54c9d7-392d-493a-8c18-55d94a6759a3@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-8-hch@lst.de>
In-Reply-To: <20250422142628.1553523-8-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9606:EE_
x-ms-office365-filtering-correlation-id: a7c25e06-9b6e-4f54-6d92-08dd87118e45
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a29UR3RKdkNoSUtsMjBpZ0dPRmVUdTVzWjhydkRvQm9ZRFduYmFoWkduQ2Zk?=
 =?utf-8?B?K1hBTGpkQWdEbE45M2gxcGQ4Uko4MWphV0FTWFJ3UHNoN1l0SG1IakNFRzF6?=
 =?utf-8?B?WjRtbG5CTERSbm9kNmM2amFDK0RKL1JtZFlaMjRBNVVuczlaa05TZlVWSTFT?=
 =?utf-8?B?eGxhc1l4WnFyOXpKYW96bDk0SWtZS3BxNWtQMkh0Q0NPdG9iRG9vZWNvWlVV?=
 =?utf-8?B?c0ZMVllJRm5QMVM3Rmk0MTN5NHRxQ1RRcWgxczNTbHJ3YUpUTmo2VHBRVzda?=
 =?utf-8?B?L1dad0drL285OFlMUTFtc0xxUjRqVjM4WUFrRVNiR1hEa2sydTFMeUw0ejQ1?=
 =?utf-8?B?QUN0NjVmb3YxcHBGUXBUUnQxTlB0cWxRd0E2OEkwZnFUcnlWV3RWNi8xc3I3?=
 =?utf-8?B?WTZVM25aUHpVSGtKc3BSM1p1NUFnSjM1Yld0UWJEcTMwVmV5ZVZUZjBIUi80?=
 =?utf-8?B?QnlNZE1ab2crb2JSdFFPMFdEU0JLckhWdlZOdHhVM3hONG5yUWhnWm9qU2pV?=
 =?utf-8?B?SFIzU1pBbFh0THMxUTBEMHR4UjRKU3lhUnRqN0lYdVNrWVd5alZhTnBDN0h6?=
 =?utf-8?B?Q0t2OWdneWorelpRMVBKYzlDTWZmTjZXaTQ3bDM5dGh4WERQQjhwRmVUYkpt?=
 =?utf-8?B?U3FKMFUwNFpNUVBwZXlBSUxIYVNsb0ZSTUVvK1dmZTRQQ3N3UkNNek1KblRR?=
 =?utf-8?B?andjQVJqVGE2VHpYK2w2ejd6MXNxR0xBcHlDaGYzTUVxMEV3SktrZkRPblBa?=
 =?utf-8?B?K3ozSWpPMXVEL3paUFA0dnYxWllsREdQYmxLQUdOWTBTSHZxMUhLQ1Uzb292?=
 =?utf-8?B?L3BmcHhJSGk0WEsyOHp4aitscmJmVkt0TUVSZjVTeGc1Z3c0NzAzTGhvb1pl?=
 =?utf-8?B?MzBlck9iTGFzcGpSNlhFd0pIeE1Cd08xUGpDZ0tuT1VrWXRNaDhqcW9FRGhi?=
 =?utf-8?B?YWpRNVh4Y2wwUVh3NWpvOHZ0VXQwUXptSG5Cak9iM0VqaUVjNnhjQUw3MTQ0?=
 =?utf-8?B?NjJzVWZkbTN6YTJRTHNYd2ExRE1hd2JyN1pTci9OeUl5YzBISGxhbTNITXBO?=
 =?utf-8?B?SHVkYkg0MTdIMkxmYUZCRkEramxFakZUbnRVZ1UveE85UjdHamNTQjlZbkpx?=
 =?utf-8?B?VDB4bktkODRGMFNUa3pmYkdWK2tCK1NCVEZCVjZLNnFJUE4wNlA3dWtielM1?=
 =?utf-8?B?dW5pYlE4T2EwL09oMlNGNnp0NTFKOEFES0ZycW1hNlIyVVVFRndHYUlzamdZ?=
 =?utf-8?B?c2VBZ0FaS2duWHU0bGF5VWpTQU1ScWU2NGw3MEtCWjU3ZGU1ZE9wWHNSMzRx?=
 =?utf-8?B?b1BaSWdRUmJ6MCtLK0hZUUtYSjBGMHkyYVJacEpFTlNzTnhmZzZWZVhLYWNp?=
 =?utf-8?B?ZFBPZFFJdWNiVjlYb0hXUkpaSi93dlM5eXRxNkRMbUp5MDFWVnZqQjE5QTRN?=
 =?utf-8?B?bm5hTnpMWjIzYjYwWjJqNDBQdmJUR3BWN1ErNnZjaW40bDFWYTRpdG56Z3Zs?=
 =?utf-8?B?aFlaTDRBRmZnSVNuUFJLUlMzb1VSbmdyZjRTZkV1S0hFSnhFY0NNSDdwUzkr?=
 =?utf-8?B?WFhhR2NWOEZmczFiR1BVaUhZOXYyOWtUYzBKWkVlMTdZUFByOGVISm5ReGxw?=
 =?utf-8?B?WkJxd241a1ZncHlLTTUyTE1vYTFseUNGUS82aGRhWXRrdGZSWDJ5VmN0NnZZ?=
 =?utf-8?B?L1VndVl4MTRqdTJBaFdvdGl0RFd0c2ZwUFZRcS9QNEMwNkpGVlY0bU9oa015?=
 =?utf-8?B?RVZzRWgxRnE2Mit2dkxLcTg1bEg2UkhBQ29nVFJaNm5iaFZYUHJXNUdqNlQ4?=
 =?utf-8?B?dVptaFIvVDhqYnAzVVN4V2tTaHRrQ21QM1ZScGltbkNxVUhZdDVMNkNCOUpt?=
 =?utf-8?B?YzJ1WFVXbFFQR2djZjR5VUVtckp5Z2xlbkdxbUhSSGp0MkVIaWtQd002UDhH?=
 =?utf-8?B?SldWYzcwKzAxZ2FSWkhWbkV0eG9jakUrVUpLSWgyNW1YZXRhcW5oVjlMeUFk?=
 =?utf-8?B?ZXNoTTdiVVVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eVE3S29rVGdrdlh1Sm1mM3gyTktlbFRMbTREOTZ3UkJoTWMrTFpKODZUM1I1?=
 =?utf-8?B?d05uUkJkQ0NubWs0WHpDRjhGVVpVdllKN3RyQ0FVSDN4U2k3VWZJckRqRTZS?=
 =?utf-8?B?d20zV2lNOGExTjZUZVFrWXlOdEtocEJmNER6azI3WTJIczVJWGJZVFJWQUQv?=
 =?utf-8?B?Q3h0YzhvZyt4d3JrdTE2ZGU3TWozY2syNXJqWXk2enZ5QkFzUi9MSDFKVmZR?=
 =?utf-8?B?WFRLclFRWVdZUmlGbEhhdWNiWHUwREdkVjAwVUUrRUw0OXB5SlpSKzR6MkNR?=
 =?utf-8?B?WUVNRmF2eUJLcUtIdUV5Yy9raDYrUFZybHNIM3orUWNIS1Bvb0NLd2VyOVUv?=
 =?utf-8?B?aVd1ZEZrLzVubEY5RG00VFQ0RzkyZzlac2JxbGdWbTE5cFdUYWVXN3E4L28v?=
 =?utf-8?B?Rk9qQU84ODhuV3Q4U3NmWStIZWJuTlZTbTRYT3VhYkhscmdDOFRGMkJCQ2lw?=
 =?utf-8?B?VXJtemlqTCt1c09uSzkzZzN3MWptNmJQQy9UUWlSM1hxYU9oOVdlWG5aMEZy?=
 =?utf-8?B?RTMrMTIwalZLcUJ1Q1Z5ZldpYUwrd3BwenMzZUpPdzRlN21HNGxRbDAzbnB3?=
 =?utf-8?B?K1pXWWdNdUZDODliK3JkaHhyWVJpaER6SnhqRDVaUXM4NVBTMmwrdWhhU28x?=
 =?utf-8?B?Z3MwVllNQk91cmlkZEFPODJLY01zRmZFcndvOEdTNDgwV1dOMUhWdS9OaFcx?=
 =?utf-8?B?WEdsR2xneWlidkR0MmtTR1Z5dExZbXF2WjR1WTZyaUFOWDlGVVhjMEpRaU1Y?=
 =?utf-8?B?UlFvdjJDY2duY0pzS0p6SmFaR0tpVFFaQnR6THpVUC9QK2ZxS3o1VGJoSkxI?=
 =?utf-8?B?QUk1UzNzTDVUWmkzMFJxWmhsMW1qTzRJZ0EyYTkwVTZYMzhET05uSDRJYnJT?=
 =?utf-8?B?c1VjZkNOdVM5R1hkV0ROMHpzZ0hJTE9pS3p4YmdLdnBoRFpEblNmNExxS01S?=
 =?utf-8?B?YTR3TFA5V2N0a2w3WEk1aW5uMkdYRVZJWnJkbythWW93N21OVTQxcU9Td29k?=
 =?utf-8?B?QURmSUVldVcxZjIyS3IzeFBZemN2R2ptZUNlZzBFSm1rdi91cFdLanBzb2w1?=
 =?utf-8?B?T0xHTUZYRlZIT1c2MFA1Rlg3QmtrdlZJd0R6c1ZJSm92Tk5taU1kamxURjZ1?=
 =?utf-8?B?ZFIvZ3ZRTWN0UVdZMFhHZ01XbEJRUzhSZEVPazdITThNOEx5ckNHNjZMdm5w?=
 =?utf-8?B?MW5LUVZ2Q2Jxcit3UlYvUDlCWjNEc3BmWUl4RHFoUXZsL1N0by9zL29mdHVI?=
 =?utf-8?B?OGUzdE9CTVNCdW5SQzNVREhha2x3ZHN3SFVTaGNQOFY1L3RHejF3eUMrVHF0?=
 =?utf-8?B?Q0JiRW1Wa3Q4WG5rdWJaZHg3ZTY5YnRHbERPSGpuQzVGeDVReTI2T2d6TDBL?=
 =?utf-8?B?WGtHWHh5ckFNZndZUUxoZjM3c2IvZGdTWWVxbFdSWGN6R2FCWCtjVGNrWmRL?=
 =?utf-8?B?aXBTNSt4aWtVYWJCd0FtbVJScVkyb2tyS3FtS0tPbEZzOWRBSDNxclNTdEQv?=
 =?utf-8?B?blFFRFl5SjBTV2g3VndQRGNBUTBOb2xpWXNPSklnYUg0MHR2K1p6MzNyZGlu?=
 =?utf-8?B?S0FSc3hubDhoQ0tXWVNnL1JQeFBPWUplaVVUdGp5NnhXYXAvMXM2akQrTCto?=
 =?utf-8?B?SG1FZHdKRHRyUDJOQ0pTZkxEM3ZobjZmMFhMc2lUR0htbFBEdTlpbGl5eTlV?=
 =?utf-8?B?V0RuM2pSSHg4SlFjSFpuN2pzallQWkxBeGh3R200RmdKbDNpdzZjaFpQeTc1?=
 =?utf-8?B?QjJDZUZqSzZBb0d5QkhNbEMvZzNwYnBwVDQ4MFhUWlExS1hieFR6b1JZakdQ?=
 =?utf-8?B?YWJFNnp3cjkvc3Y3OEQ2cEJpcGdUdlNVclphOGg1Q1FTN0VZczlsY25Qdmx6?=
 =?utf-8?B?SDI5TTJ1c3VnV2xoRUVvR1FVZVMzT0pLbFVaT0ZoTExZS1RQSHVpM0xhNFdX?=
 =?utf-8?B?VkZWMjNCWGdLN1dTSk90cFg1eUxmRVRKR0ppZ0R6SldmZlc0N2RTdW5nemlQ?=
 =?utf-8?B?OTNCQ3BVMkZmS2ZCV1N4MnlPczQ5d1o3ZEdFQ2JvVUxkZjF0UjZKbVdRWm4v?=
 =?utf-8?B?WUU1eFlzQWluL1U4UkdRZmdCZ3lFNVJoZkEyR0pXYk5qT1lTQWgvTHZxY3o4?=
 =?utf-8?B?T1ZNSW5wQ1dMLzU0SWEvcUxaczZPWUFMR21RbUlzbnlUdzAvNWJvL3I3SENF?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E165D614957074CB87297F670AB614A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xdIJ0XivRuvDVB1k+HhsOCuZGqPSAT21Dyesc20xeksXerPqosMJO+ldJHXLOBsT/r9//U3hgbadQNw2JvG+WJBPdzcqxsrpvinTO0gVnpSJe9Bz14+whhIEb7MUFKfeqBG6mDeAnqM66Mhhmhu3L8kJ1CYXCSWyOCfi9BHp4xyvFveISf7VIG1/abVcA5KhCntcdN50OfTLtQIvDbxzOyYTDdluaKSP6SiXS9qEwHUhaBy9EGVXDutAO+CpvHZfAEAxSa7OPQarCYZhmNZFwalpp8XEdvkpdRLlneBzpkQkeVDSvi4O/g7cUH/fRpRTNqQOuu55GNGhqCpI3GShgMjk5qzvAHpR3JLuY8Y4U9CqsSjagBy4Dcwe9xTktTdUoa7JXiT0wGM6vOyIVuiNQkq1gbI7wJ5tYrQ8IJVjawx337fXfRV3lVu5P5fQMy154k5tI1EvJ2MKpaMlXjy/5FYUpPqYESRPt2e0UElW7l60w41NTvBWJ904tQfQK+wWBpyCVK/DC2rvyjtF37u3UDFkDas9teWo9AXpw1O/TYYtiF8qXxJeD/nGxl9W8c9T/E5tTcrF/t2hic2PTpUswACJiZ2gygndHhaI9aqK/MsJ4Lsr44x/ifD0bRmkdMgW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c25e06-9b6e-4f54-6d92-08dd87118e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:32:42.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9sQuX8+tiH9FEDp6aTL4Ycpk+6sRNE6s0Zx3jdM+MFtJftJMstd8qJ3598EtO/22BDh+rrtXALoe4TS/IuBKUAdHH52p8eMdnPYJgmnTJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9606

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

