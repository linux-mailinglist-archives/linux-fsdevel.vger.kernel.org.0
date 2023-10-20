Return-Path: <linux-fsdevel+bounces-837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE87D1228
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190611C2100C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A61DA42;
	Fri, 20 Oct 2023 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="NrzMFzQI";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="BwLmwJRH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61581199BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 15:05:22 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 08:05:19 PDT
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A2D46
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=14197; q=dns/txt;
  s=iport; t=1697814319; x=1699023919;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4trdDcgCVIxmp2p82Dl+uFOa6U3O3LqSyK5+gJtxvKE=;
  b=NrzMFzQIGwfw2J6Ty0oslkstBOAgOtOOYrhjlzbOjeiQ3rOTWGQ8m++Q
   BlAesRH2wWyRV2FTaQjrKCKYvv29+iYXLYVp5J5/6JBJUk1QqVDuQXIWl
   lms+CA4q3Op6oixiatzplTLEbwXCyFm96dMtuqr9TuLvnt1Wfl3W+BfFb
   Y=;
X-CSE-ConnectionGUID: d2lzl9ldRPSDE9AvioKf7Q==
X-CSE-MsgGUID: MDmMEb03R+2261mB+FgI+A==
X-IPAS-Result: =?us-ascii?q?A0ABAwChlTJlmIQNJK1agQklgSqBZ1J4AlkqEkiIHgOFL?=
 =?us-ascii?q?YZAgiMDgRORRIskFIERA1YPAQEBDQEBNBAEAQGFBgKHFQImNAkOAQICAgEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUOECeFaA2GTAEBA?=
 =?us-ascii?q?QEDEgsKEwYBATcBDwIBCBUDHhAyJQIEDgUIGoJcAYJeAwEQp0sBgUACiih4g?=
 =?us-ascii?q?QEzgQGCCQEBBgQFSbIjCYFIiAoBigYnG4FJRIEVgTyBNzg+gmECAoFEGoYhI?=
 =?us-ascii?q?oN2hT0HMoIigy4qgRSCcYc2XiNHcBsDBwOBAxArBwQvGwcGCRYYFSUGUQQtJ?=
 =?us-ascii?q?AkTEj4EgWeBUQqBAz8PDhGCQyICBzY2GUuCWwkVDDRNdhAqBBQXgREEah8VH?=
 =?us-ascii?q?hIlERIXDQMIdh0CESM8AwUDBDQKFQ0LIQUUQwNHBkoLAwIcBQMDBIE2BQ0eA?=
 =?us-ascii?q?hAaBg4nAwMZTQIQFAMeHQMDBgMLMQMwgR4MWQNsHzYJPA8MHwIXA0QdQAN4P?=
 =?us-ascii?q?TUUG22dAQNtgkgZBxYZTAkKARMYgQUUawEbLiySfIJjAYwXomIKhAyMAZUfS?=
 =?us-ascii?q?QODa5NhkggumA6IZ4IdgmGGUoIfkVECBAIEBQIOAQEGgUUeOoFbcBWDIglJG?=
 =?us-ascii?q?Q+OOYNfhFGBRIlkdgswAgcLAQEDCYtKAQE?=
IronPort-PHdr: A9a23:zkZaJB9/bFOMNP9uWO3oyV9kXcBvk7zwOghQ7YIolPcVNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqPA90LfnxE5X6hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49ALiJFrLLowzBaBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:v2UYwqLO04xYGrPvFE+RApUlxSXFcZb7ZxGr2PjKsXjdYENS0WAHn
 WUZCmzSPv2IYTDwfNl2aYq/o0tX7MPVx4QxSQAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZsCCea/0/xWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvW0
 T/Oi5eHYgT8g2Qsajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFaEc/K3DcHyzi/So42CXWmXtxNZgU3hjaOX0+s4vaY1P3
 fUcLDZIZReZiqfvmPSwS/JngYIoK8yD0IE34y47i2qHS699B8mYGc0m5vcAtNs0rslLHP3DY
 8MCQTFudx/HJRZIPz/7Dbpnxrjx2yigI20wRFS9gIYyxkXZlFdLk+K3boPQUJ+kSuQWtxPNz
 o7B1z2pXk5FXDCF8hKf72mww+HIh2b/WYQPBJWm+fNwxl6e3GoeDFsRT1TTif24jFOuHtxEJ
 0EK9y4Gs6c/7gqoQ8P7Uhn+p2SL1iPwQPJZF+k8rQqK0KeRul7fDWkfRTkHY9sj3CMredA0/
 lPTm8HtVDhjioWuZV/M36mVqhC8ZhFAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRGCYL
 9ei8XdWulkDsSIY//7gpAya2lpAsrCMH1FtuFSGNo6wxl4hDLNJcbBE/rQyARxoAIufUl6H1
 JTvs5fAtrlWZX1hedDkfQngNLit4/DAOzrGjBs2R98q9i+m/DioeoU4DNBCyKVBbJ5sldzBO
 RC7VeZtCHl7ZyvCgUhfON/ZNijS5fK8fekJr9iNBja0XrB/dRWc4AZlblOK0mbmnSAEyP9uZ
 sjHKZzwVCtAWMyLKQZaoc9DidfHIQhgnQvuqWzTlHxLLJLHPifOEOdZWLdwRrlgvfrsTPrpH
 yZ3bpvWlEo3vBzWaSjM+olbNkERMXU+HvjLRz9/KIa+zv5dMDh5UZf5mOp5E6Q8xvg9vrmTp
 BmVBBQHoGcTcFWac21mnFg5NuO2NXu+xFpmVRER0aGAgil4Pdn1tP5GK/Pav9APrYRe8BK9d
 NFcE+2oCfVUQTOB8DMYBaQRZqQ7HPh3rWpi5xaYXQU=
IronPort-HdrOrdr: A9a23:P7FAva24+jnQQw256wPT/AqjBc5xeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6KG90cm7LU819fZOkPAs1S/LZniphILaFvAT0WKE+UygJ8SezJ8T6U
 4ESdkdNDSeNykGsS+X2njeLz9k+qj4zEnKv5af854Od3AXV0gI1W4QYWjrdzwTeOAFP+tHKH
 P23Ls+m9PUQwVsUi3NPAh/YwGsnaysqLvWJTQ9K1oM7g6IgTm06Lj8PSS5834lOQ9n8PMJy0
 SAtxb2yJmCnpiApyM00VW9071m3P/ajvdTDs2FjcYYbh/2jByzWYhnU7qe+BgoveCG8j8R4Z
 vxiiZlG/42x2Laf2mzrxeo8RLnyiwS53jrzkLdqWf/oPb+WCkxB6N69Mdkm1rimg4dVeNHoe
 R2NlGixsNq5NT77XzADu3zJlZXf4yP0CEfeKAo/iZiuMAlGcxsRMQkjTFo+dE7bWHHAERNKp
 gzMCkaj8wmLG+yfjTXuHJiz8erWWl2FhCaQlIassjQyDROmmtlpnFojvD3s01wvK7VcaM0rN
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbJPHiJKVrqGakbMzaVwqSHrIkd9aWvYtgF3ZEykJ
 POXBdRsnMzYVvnDYmL0IdQ+h7ATW2hVXDmy91Y5ZJ+prrgLYCbfBGrWRQriY+tsv8fCsrUV7
 K6P49XGebqKS/0FYNAz2TFKtBvwLklIbsoU/oAKiWzS5jwW/jXX8TgAYLuGIY=
X-Talos-CUID: 9a23:PqB7T2NgSmNG/O5DVHNj5kpFHswfSkbx4Sb5PU6/Kmg2cejA
X-Talos-MUID: 9a23:6RaQowmf8yis2ocMmKKbdnpHGMJNzq72U3pOy89Y4syudgJ/GnS02WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-10.cisco.com ([173.36.13.132])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 15:04:16 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
	by alln-core-10.cisco.com (8.15.2/8.15.2) with ESMTPS id 39KF4GK8025355
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 15:04:16 GMT
X-CSE-ConnectionGUID: TQ90ocb3SyyVPqWwc6Wy5g==
X-CSE-MsgGUID: PrErCCqNSk6zv/uwluMlOw==
Authentication-Results: alln-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,239,1694736000"; 
   d="scan'208";a="729418"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by alln-opgw-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 15:04:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTzfhnLFeXEzA+b/UxNoE9O3g5S18IfUS/NcUI2uZBTwVQ8GL8z9FWCyPh7UzsqY9lidYs9MIgxDiQ2zfS7T37jooWdiXYdbzZjmr01eRpoRqWalHVc9dy9mUIEGTPhgSN9g+WjfLzUfV6ASuYSxf4Kun6oxNrLozvNhv1hYExYaXJVuYiHudzla11YoRtKm1eszWRAypSWAz74U7MTaLORWseS7cgS2RqXwrirrgfe0Jdbqtcnem1Z4tlGiRr53RqZIP0IiZqaFeA8soXuVrJnRCc9Qh4Ri656HPv3yqHJBL9y6MuMViPyE9ONRlaOHHZJ8ZJNB4DG2wtEF18JXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5sLx07phnxRfUWO74UHBzowAhWqZhGT784mxyc6e8Y=;
 b=Z0oNk1oL29zkcEaly9s2dIEGt5IV0xByO1d89Ho5Qov2hSHxg8I+diVBGO8QsyJoBjCqyvhX/23Z+VHxfqO+tGd8OCVUFFyRr/xRz9cR4/4Zxma4Vr8KxYyL1eNId14NxmtSnN9gE9LUZPvIEX+2DWoa2AWgLVuVcltoS0H72o7D4i8k4pbXeWQNWLA/ylzWuupt8AAYe9XQADV6oDa/HTPZ5aXa/Y4ImGerUQlO5g48Bm7BWsAGVjpX2UH1als5IDrH91Mv7LlHqKKyUnPizNWBKGALWyvv4+Q1NM1UGONcMpnMlTU2in6traTwX//6gOln+8FBy6aBhwrIB5G+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5sLx07phnxRfUWO74UHBzowAhWqZhGT784mxyc6e8Y=;
 b=BwLmwJRH+xZ6BxJtUGdVDV5Pq+M5wLPS2l6Juozc+rymI5VldOB+K7bhQIUqW6uvsQq9fRAOxVm3AjkKEeGICtBaNeSYT5/4zwzTONT8f2NxtCJ85tpjZwYF5tEquIUiQ8vvaPOFIp5zEqOSvT30w9At7hmd2FmjUluYeuYtYeI=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by CY8PR11MB7798.namprd11.prod.outlook.com (2603:10b6:930:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 15:04:13 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::6c6c:63b0:2c91:a8d9]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::6c6c:63b0:2c91:a8d9%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 15:04:13 +0000
From: "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet
	<kent.overstreet@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        Wedson
 Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 04/19] rust: fs: introduce `FileSystem::super_params`
Thread-Topic: [RFC PATCH 04/19] rust: fs: introduce `FileSystem::super_params`
Thread-Index: AQHaA2av/TEkpBW4pEet5MpMfUpJTQ==
Date: Fri, 20 Oct 2023 15:04:13 +0000
Message-ID: <zafiacccjlm6rhjrewkz24mmxcpiav52gpg3zzyaj4zntqj4es@yoespfphvwm4>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-5-wedsonaf@gmail.com>
In-Reply-To: <20231018122518.128049-5-wedsonaf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|CY8PR11MB7798:EE_
x-ms-office365-filtering-correlation-id: 209cf5c1-7248-4ddc-af9a-08dbd17dd253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4OJSz7Ahjjhvvcw1KRSbeEzNHgzh45AfuIkC0NbzJ9ishg4nh8KTucX9Pom2bG5B8dThcmxxaAD8XPQT9WVaeJQPM3DCNgvBPVYJlwLWXtCQeWeAEI3dks1/aCrZJDiNH+DKxTmURbkGGLpXGCR/+fddIfD5UbzWEL86ycyojcAfGeDpGp11ubJTnXug7yCW68OtFN/fRVcZ53lgqiPvhUlMZ21U8aMM1pa34qYqUG1vD7fD+p2yOfdr8vouCJ+GUWSkE/TU3fMF3LyXbEx4rLXm/OdFub/iyQHviWwh60Gcr5ldVsdSHT7/T4TCWNInb9j1m9KLSzF8SbZqWK2GpvqYaB9bUVoUWw2Zumxw91wsgDsbQcOFxkCjo/0gnjGgTOXkjeFgpspTpOaBhXIALCnyaM5RSIyE2J+0wVi42BN7WvzlfcmJiY/4ldPkko2cua89gu2hxm93lN8h9bZE8suyLABDy+8OtdInCIpBQRwVxRDEX7/E+OxCoNftVYRxTiUT31oPVut3oNu/lMfOda5kes36rHcFcBEBhnDKR4HO4Fio3j66ePJ0vZycMQrLJTGAbKcYiWB8Qud01qaMs1QdD6rajnSqLNLZfnpnxz43urB1QgQFs7n453L5GMUM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(41300700001)(86362001)(8936002)(5660300002)(8676002)(4326008)(38100700002)(83380400001)(2906002)(30864003)(64756008)(66446008)(66946007)(66556008)(316002)(66476007)(6916009)(122000001)(38070700009)(26005)(33716001)(6512007)(9686003)(54906003)(91956017)(71200400001)(76116006)(6506007)(6486002)(478600001)(966005)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MhGasR2zylGDf7WP8vjMO/tCUs44X+EJjJ/1a276SmjGrrIy6EOxAeyC1Ujz?=
 =?us-ascii?Q?xUgBBqmjMbu+KZH+o/q+lNv4OalcfXtAH2xoq7QCrgX1qjHQQSib8cRmUUDe?=
 =?us-ascii?Q?UwGyl2okO/Z7DamH/WzjQO6DmX2IFR0SvxRGjCveWmsrjznza7Ys74hOrKKY?=
 =?us-ascii?Q?2wP2jy2Ci5W0xNXLWfxADAnZuifMinOfUIcHMxe3ymWhkSKzpN3YaOP4U20F?=
 =?us-ascii?Q?X/yXLOZrbd/CbwzVANWSo/RKN3Q/zo7xknZtVjb0zsgbLNr9XEcTHB17foDl?=
 =?us-ascii?Q?SD8497eGVREnm21SVFWasM7bYfhaTJWnTttIPUZoH2aMm7pkB/zvaz4o0J1S?=
 =?us-ascii?Q?Mze1X+dCZR9yZhwFVRFZ46vjh3o8tgFo1r71cfXm/NJpga7h6xZb0NzHL5wR?=
 =?us-ascii?Q?Hbch6dRhZFXelFz7ijC63P3aUJwphre0UcZVDHhvtNeOjBobcdMPssTqnkwZ?=
 =?us-ascii?Q?l+kspuDilXAsF3HOBA75v5XfGs4+Y3km5w6LJNfAXjG1/K3VagLpGD0wxMrA?=
 =?us-ascii?Q?EeVqssF21khmGGyf7cg3s4mz69uBxnpwl8EAy002icUb4dAvoQlvDghAm5tN?=
 =?us-ascii?Q?KprEqhclXbdlaQ2GIGM0T9XAlbP47Of5o3JkTEq0jTrZG2XXh+02v2MnVtyL?=
 =?us-ascii?Q?CBJfQVy/uScdRn2s3rCEKYRI6R7BZ1zClmOUkfTI4eJ5NbdvH1+icurCe/A5?=
 =?us-ascii?Q?1Zl2wNZcqGQ50Ft27rmW+55CHoAK1a94PYhyxMWJRtzDJqULspnf0KcEkL5F?=
 =?us-ascii?Q?bWqz4wMiR2Mc9QL4eTDHLdCcrl8DvtwnBdvyascnr0BNKMwLglZoGpiRZzeK?=
 =?us-ascii?Q?0GbTFanZRqM/LniqT/mr2S1Yk/xrRSeOXBPrbJ7EwZKk/NmGJ7LorLB6RT3d?=
 =?us-ascii?Q?JBPyFRWfKqFLhrTzDHpDNNBcls2SpfsVwzpeKCQTAhl3i5ys//SZ0zJOyfRl?=
 =?us-ascii?Q?Dnv2Ru12ZsOLgX0tuNTNvlKiQEX1iuHl9yaDC3SuEgAoTutMWT2KKvKKieEE?=
 =?us-ascii?Q?nkqmIOGqFZ8fKHD7/KufXLaQoiJoDqPrxrrYUz8EkKGFzIpxy4uAIGVpze4/?=
 =?us-ascii?Q?kDJUolTNBtk8Po0tCDHI6ZId/+czZIqsx3Tn0i8h9RXpQdhndtzjbxxJICn/?=
 =?us-ascii?Q?wfFFfdXXYKeCx6ggotTXk3EFf38oMHCSTW3mKt1WL8qex/CIz2GAMc6bYTm5?=
 =?us-ascii?Q?AL2N3rxWlE27SGpUFi7yrlfCgZsLorwKILcNM3zO7jLf2ArOnq0WdywIjcxj?=
 =?us-ascii?Q?+0sQ2ywU/kmU6lezDcFNKCMQGNbAf9mR2e71RU4rbBQvrlTTNuDG20fvQqFk?=
 =?us-ascii?Q?moGOtSg53B972wE9nOcX+1+xBelxFMv+EO03MpeZeZr0GIP5spU6FVKOg22m?=
 =?us-ascii?Q?cbpkRPOyn3wZILoQ/Td04j1pQ+HQ+uBT7QM8h8sp7mbheeq6W6nF8hWybPIa?=
 =?us-ascii?Q?Xq55GvA+9raU6R/ZDW/wdhGEtTaMqiK56v0UgXNpeEvqGsMGzWelI0Y7uN9K?=
 =?us-ascii?Q?Kk3XxvOdA1nOkH3rAleQzwFMzwchmOTFk/oEnmSCdkIC/NX1MBHODnnWBlEv?=
 =?us-ascii?Q?1zI+ePOGkuWeKtIZ5CSk183FsWw4dmo3QjS2XjZs?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6CED192BD78A2A4DBF4CB12DA6DC82C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209cf5c1-7248-4ddc-af9a-08dbd17dd253
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 15:04:13.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i21/TVDo2gPNWEEWgoLofvB6x48iJObnBqAxvQRSRFU4xofEFTGgB72J/QtPlxRlnymsbh4+HtqA+k0ITpUTOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7798
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: alln-core-10.cisco.com

On 23/10/18 09:25AM, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Allow Rust file systems to initialise superblocks, which allows them
> to be mounted (though they are still empty).
>=20
> Some scaffolding code is added to create an empty directory as the root.
> It is replaced by proper inode creation in a subsequent patch in this
> series.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/bindings/bindings_helper.h |   5 +
>  rust/bindings/lib.rs            |   4 +
>  rust/kernel/fs.rs               | 176 ++++++++++++++++++++++++++++++--
>  samples/rust/rust_rofs.rs       |  10 ++
>  4 files changed, 189 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 9c23037b33d0..ca1898ce9527 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
>  #include <kunit/test.h>
>  #include <linux/errname.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
> @@ -22,3 +23,7 @@ const gfp_t BINDINGS___GFP_ZERO =3D __GFP_ZERO;
>  const slab_flags_t BINDINGS_SLAB_RECLAIM_ACCOUNT =3D SLAB_RECLAIM_ACCOUN=
T;
>  const slab_flags_t BINDINGS_SLAB_MEM_SPREAD =3D SLAB_MEM_SPREAD;
>  const slab_flags_t BINDINGS_SLAB_ACCOUNT =3D SLAB_ACCOUNT;
> +
> +const unsigned long BINDINGS_SB_RDONLY =3D SB_RDONLY;
> +
> +const loff_t BINDINGS_MAX_LFS_FILESIZE =3D MAX_LFS_FILESIZE;
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 6a8c6cd17e45..426915d3fb57 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -55,3 +55,7 @@ mod bindings_helper {
>  pub const SLAB_RECLAIM_ACCOUNT: slab_flags_t =3D BINDINGS_SLAB_RECLAIM_A=
CCOUNT;
>  pub const SLAB_MEM_SPREAD: slab_flags_t =3D BINDINGS_SLAB_MEM_SPREAD;
>  pub const SLAB_ACCOUNT: slab_flags_t =3D BINDINGS_SLAB_ACCOUNT;
> +
> +pub const SB_RDONLY: core::ffi::c_ulong =3D BINDINGS_SB_RDONLY;
> +
> +pub const MAX_LFS_FILESIZE: loff_t =3D BINDINGS_MAX_LFS_FILESIZE;
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 1df54c234101..31cf643aaded 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -6,16 +6,22 @@
>  //!
>  //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
> =20
> -use crate::error::{code::*, from_result, to_result, Error};
> +use crate::error::{code::*, from_result, to_result, Error, Result};
>  use crate::types::Opaque;
>  use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule=
};
>  use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin};
>  use macros::{pin_data, pinned_drop};
> =20
> +/// Maximum size of an inode.
> +pub const MAX_LFS_FILESIZE: i64 =3D bindings::MAX_LFS_FILESIZE;
> +
>  /// A file system type.
>  pub trait FileSystem {
>      /// The name of the file system type.
>      const NAME: &'static CStr;
> +
> +    /// Returns the parameters to initialise a super block.
> +    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams>;
>  }
> =20
>  /// A registration of a file system.
> @@ -49,7 +55,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static Thi=
sModule) -> impl PinInit<
>                  let fs =3D unsafe { &mut *fs_ptr };
>                  fs.owner =3D module.0;
>                  fs.name =3D T::NAME.as_char_ptr();
> -                fs.init_fs_context =3D Some(Self::init_fs_context_callba=
ck);
> +                fs.init_fs_context =3D Some(Self::init_fs_context_callba=
ck::<T>);
>                  fs.kill_sb =3D Some(Self::kill_sb_callback);
>                  fs.fs_flags =3D 0;
> =20
> @@ -60,13 +66,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static T=
hisModule) -> impl PinInit<
>          })
>      }
> =20
> -    unsafe extern "C" fn init_fs_context_callback(
> -        _fc_ptr: *mut bindings::fs_context,
> +    unsafe extern "C" fn init_fs_context_callback<T: FileSystem + ?Sized=
>(
> +        fc_ptr: *mut bindings::fs_context,
>      ) -> core::ffi::c_int {
> -        from_result(|| Err(ENOTSUPP))
> +        from_result(|| {
> +            // SAFETY: The C callback API guarantees that `fc_ptr` is va=
lid.
> +            let fc =3D unsafe { &mut *fc_ptr };
> +            fc.ops =3D &Tables::<T>::CONTEXT;
> +            Ok(0)
> +        })
>      }
> =20
> -    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_=
block) {}
> +    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_b=
lock) {
> +        // SAFETY: In `get_tree_callback` we always call `get_tree_nodev=
`, so `kill_anon_super` is
> +        // the appropriate function to call for cleanup.
> +        unsafe { bindings::kill_anon_super(sb_ptr) };
> +    }
>  }
> =20
>  #[pinned_drop]
> @@ -79,6 +94,151 @@ fn drop(self: Pin<&mut Self>) {
>      }
>  }
> =20
> +/// A file system super block.
> +///
> +/// Wraps the kernel's `struct super_block`.
> +#[repr(transparent)]
> +pub struct SuperBlock<T: FileSystem + ?Sized>(Opaque<bindings::super_blo=
ck>, PhantomData<T>);
> +
> +/// Required superblock parameters.
> +///
> +/// This is returned by implementations of [`FileSystem::super_params`].
> +pub struct SuperParams {
> +    /// The magic number of the superblock.
> +    pub magic: u32,
> +
> +    /// The size of a block in powers of 2 (i.e., for a value of `n`, th=
e size is `2^n`).
> +    pub blocksize_bits: u8,
> +
> +    /// Maximum size of a file.
> +    ///
> +    /// The maximum allowed value is [`MAX_LFS_FILESIZE`].
> +    pub maxbytes: i64,
> +
> +    /// Granularity of c/m/atime in ns (cannot be worse than a second).
> +    pub time_gran: u32,
> +}
> +
> +/// A superblock that is still being initialised.
> +///
> +/// # Invariants
> +///
> +/// The superblock is a newly-created one and this is the only active po=
inter to it.
> +#[repr(transparent)]
> +pub struct NewSuperBlock<T: FileSystem + ?Sized>(bindings::super_block, =
PhantomData<T>);

How about using the state type parameter [1] instead of using a separate
struct for each state? I think Andreas Hindborg mentioned this during
Kangrejos [2].

The gist of it is that you define a trait and implement it for the two
states of the superblock: NewSuperBlockState and
InitializedSuperblockState:
```
pub trait SuperBlockState {}
/// A superblock that is still being initialised.
pub enum NewSuperBlockState {}

/// An initialized superblock
pub enum InitializedSuperBlockState {}

impl SuperBlockState for NewSuperBlockState {}
impl SuperBlockState for InitializedSuperBlockState {}
```

Then add another generic parameter (the state) to the SuperBlock:
```
#[repr(transparent)]
pub struct SuperBlock<T: FileSystem + ?Sized, S: SuperBlockState>(Opaque<bi=
ndings::super_block>, PhantomData<T>, PhantomData<S>);
```

Now you implement the functions separately on each variant of the
generic instead of implementing them on separate structs:
```
impl<T: FileSystem + ?Sized> SuperBlock<T, NewSuperBlockState> {
...
impl<T: FileSystem + ?Sized> SuperBlock<T, InitializedSuperBlockState> {
...
```

I think this pattern makes it clearer that there's only one SuperBlock
object which can be in different states, and it more clearly conveys
that the Typestate pattern is being used (we could find shorter names
for the states).

See [3] for the complete example.

Cheers,
Ariel

[1] https://cliffle.com/blog/rust-typestate/#variation-state-type-parameter
[2] https://kangrejos.com/
[3] https://github.com/ariel-miculas/linux/commit/655607228ff4ac9e56295ddd7=
4fff8910dfbef14#diff-9b893393ed2a537222d79f6e2fceffb7e9d8967791c2016962be31=
71c446210f
> +
> +struct Tables<T: FileSystem + ?Sized>(T);
> +impl<T: FileSystem + ?Sized> Tables<T> {
> +    const CONTEXT: bindings::fs_context_operations =3D bindings::fs_cont=
ext_operations {
> +        free: None,
> +        parse_param: None,
> +        get_tree: Some(Self::get_tree_callback),
> +        reconfigure: None,
> +        parse_monolithic: None,
> +        dup: None,
> +    };
> +
> +    unsafe extern "C" fn get_tree_callback(fc: *mut bindings::fs_context=
) -> core::ffi::c_int {
> +        // SAFETY: `fc` is valid per the callback contract. `fill_super_=
callback` also has
> +        // the right type and is a valid callback.
> +        unsafe { bindings::get_tree_nodev(fc, Some(Self::fill_super_call=
back)) }
> +    }
> +
> +    unsafe extern "C" fn fill_super_callback(
> +        sb_ptr: *mut bindings::super_block,
> +        _fc: *mut bindings::fs_context,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The callback contract guarantees that `sb_ptr` is=
 a unique pointer to a
> +            // newly-created superblock.
> +            let sb =3D unsafe { &mut *sb_ptr.cast() };
> +            let params =3D T::super_params(sb)?;
> +
> +            sb.0.s_magic =3D params.magic as _;
> +            sb.0.s_op =3D &Tables::<T>::SUPER_BLOCK;
> +            sb.0.s_maxbytes =3D params.maxbytes;
> +            sb.0.s_time_gran =3D params.time_gran;
> +            sb.0.s_blocksize_bits =3D params.blocksize_bits;
> +            sb.0.s_blocksize =3D 1;
> +            if sb.0.s_blocksize.leading_zeros() < params.blocksize_bits.=
into() {
> +                return Err(EINVAL);
> +            }
> +            sb.0.s_blocksize =3D 1 << sb.0.s_blocksize_bits;
> +            sb.0.s_flags |=3D bindings::SB_RDONLY;
> +
> +            // The following is scaffolding code that will be removed in=
 a subsequent patch. It is
> +            // needed to build a root dentry, otherwise core code will B=
UG().
> +            // SAFETY: `sb` is the superblock being initialised, it is v=
alid for read and write.
> +            let inode =3D unsafe { bindings::new_inode(&mut sb.0) };
> +            if inode.is_null() {
> +                return Err(ENOMEM);
> +            }
> +
> +            // SAFETY: `inode` is valid for write.
> +            unsafe { bindings::set_nlink(inode, 2) };
> +
> +            {
> +                // SAFETY: This is a newly-created inode. No other refer=
ences to it exist, so it is
> +                // safe to mutably dereference it.
> +                let inode =3D unsafe { &mut *inode };
> +                inode.i_ino =3D 1;
> +                inode.i_mode =3D (bindings::S_IFDIR | 0o755) as _;
> +
> +                // SAFETY: `simple_dir_operations` never changes, it's s=
afe to reference it.
> +                inode.__bindgen_anon_3.i_fop =3D unsafe { &bindings::sim=
ple_dir_operations };
> +
> +                // SAFETY: `simple_dir_inode_operations` never changes, =
it's safe to reference it.
> +                inode.i_op =3D unsafe { &bindings::simple_dir_inode_oper=
ations };
> +            }
> +
> +            // SAFETY: `d_make_root` requires that `inode` be valid and =
referenced, which is the
> +            // case for this call.
> +            //
> +            // It takes over the inode, even on failure, so we don't nee=
d to clean it up.
> +            let dentry =3D unsafe { bindings::d_make_root(inode) };
> +            if dentry.is_null() {
> +                return Err(ENOMEM);
> +            }
> +
> +            sb.0.s_root =3D dentry;
> +
> +            Ok(0)
> +        })
> +    }
> +
> +    const SUPER_BLOCK: bindings::super_operations =3D bindings::super_op=
erations {
> +        alloc_inode: None,
> +        destroy_inode: None,
> +        free_inode: None,
> +        dirty_inode: None,
> +        write_inode: None,
> +        drop_inode: None,
> +        evict_inode: None,
> +        put_super: None,
> +        sync_fs: None,
> +        freeze_super: None,
> +        freeze_fs: None,
> +        thaw_super: None,
> +        unfreeze_fs: None,
> +        statfs: None,
> +        remount_fs: None,
> +        umount_begin: None,
> +        show_options: None,
> +        show_devname: None,
> +        show_path: None,
> +        show_stats: None,
> +        #[cfg(CONFIG_QUOTA)]
> +        quota_read: None,
> +        #[cfg(CONFIG_QUOTA)]
> +        quota_write: None,
> +        #[cfg(CONFIG_QUOTA)]
> +        get_dquots: None,
> +        nr_cached_objects: None,
> +        free_cached_objects: None,
> +        shutdown: None,
> +    };
> +}
> +
>  /// Kernel module that exposes a single file system implemented by `T`.
>  #[pin_data]
>  pub struct Module<T: FileSystem + ?Sized> {
> @@ -105,6 +265,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>  ///
>  /// ```
>  /// # mod module_fs_sample {
> +/// use kernel::fs::{NewSuperBlock, SuperParams};
>  /// use kernel::prelude::*;
>  /// use kernel::{c_str, fs};
>  ///
> @@ -119,6 +280,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>  /// struct MyFs;
>  /// impl fs::FileSystem for MyFs {
>  ///     const NAME: &'static CStr =3D c_str!("myfs");
> +///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams> =
{
> +///         todo!()
> +///     }
>  /// }
>  /// # }
>  /// ```
> diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
> index 1c00b1da8b94..9878bf88b991 100644
> --- a/samples/rust/rust_rofs.rs
> +++ b/samples/rust/rust_rofs.rs
> @@ -2,6 +2,7 @@
> =20
>  //! Rust read-only file system sample.
> =20
> +use kernel::fs::{NewSuperBlock, SuperParams};
>  use kernel::prelude::*;
>  use kernel::{c_str, fs};
> =20
> @@ -16,4 +17,13 @@
>  struct RoFs;
>  impl fs::FileSystem for RoFs {
>      const NAME: &'static CStr =3D c_str!("rust-fs");
> +
> +    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams> {
> +        Ok(SuperParams {
> +            magic: 0x52555354,
> +            blocksize_bits: 12,
> +            maxbytes: fs::MAX_LFS_FILESIZE,
> +            time_gran: 1,
> +        })
> +    }
>  }
> --=20
> 2.34.1
> =

