Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205EE2F2C93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404969AbhALKUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:20:53 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51013 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbhALKUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610446852; x=1641982852;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TrFQUm4MxkWdViAUmzzjxQKkRF4mjKQm3pLfoSvOY64=;
  b=gpgirs+EE+PseK9jJDYLK/NFCrt/sjTRaJ85KZj4/TIYJFa7MtsFq1Hv
   RdSrfGMRjqRLc6C2goG1sc+CsI5PeiBRcgZ44FgbyxctCy3hdLIRn2xkr
   UtXevs3yU8c8IYYIxlr15NBAW7NoyazfyN/yn+dtTca3xf+KjA5d6/B+p
   lfGLsLk1Q2my57KmqxDygFvxtQ9m73uGd/3+O7Z5EyQGGnpzZWaFUQRiF
   9o91Z02ljVnD2Q3MZjULbCFDnLQu0jBwOs1l0KAvfR5b2s/7JvtZdmbq+
   dXreyZJ1yCPNK3nAHVgVtg+rILVCETEQTbLc1o2UNAHISbA9Atrfhd7C6
   A==;
IronPort-SDR: bPzAV5BJCKAdaMdWgFVTWHnWXMbZoIXSF7/A3PMku6cruz+hpdw9vctrdML7MsIb6KEyyuYIkR
 6hyx7+EEOpFMOYS0uEoipbtfhkX1UjslMpFfa62nrb7Mj7s07B2xk0RhWysJZV97CxHou3iGEn
 ccJPW0VWgT5ztrRo2ve76EdWQnNvDwKvEyeQ9gfhBWz2e4uQInXUWlIaNSPRNIaMZm9VKmVKy5
 4adVair5dPoCvbmL0K2KKxVpRPYcTIcdzAV2MIgdQrNhZUer8y1h761mJx4oYYIPHf+oTiAnCj
 gMQ=
X-IronPort-AV: E=Sophos;i="5.79,341,1602518400"; 
   d="scan'208";a="161673285"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 18:19:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EttsN/zc2D3kI44yxOI1D3mQClk4rlZG8JmNnpE19j5gJCTHKiERojtKWDtzn7fk+ZcaE92AdFnqKQUwJgoIJLH/42yaWsnXQ47lV6D4O01ZbvXPeHiM3SGss5D4TKZJJryt2gtgbAklzdJpITei66mWZ8xtMixLd+9WOReOqLNb7S1nnXUhs5XhxwbAr2H5jo63Q9udi7E3ptRsSIpEWamgqqZfoKPWZih2LBjdL30c78+tgrcqDKdtBVNn7h6Mb41mCuwnUu+KFxmmHVbAHNl2cZucOM2ZkbRPF9cc/MNFRHBf8xo33JjMF1G+WgElj0BJJGpu5fn7mKs+phJAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx4vZY9bvYKbD9vsGucSUjxwr6P/Xi4O0rMwyegSKS0=;
 b=Pu3SDawnB7GqpivqO8G/ScFFKs6RbNeU2VJsSIvCqEyJM5TIv+i2/10MPkhwzYdeBl1EhdY010lxeRardesEwk26oHEiLawEts6LnC4q2pDgagghXVOZoReBURvZ48S4vrpCfWEG/4xl86vBDg1Ki6WCrB6vRCxEQoqJtqAIdJ6qitABeZ8XD/WFl8+1AvfAV2ssOJBduFsoRacW5P8C9OQYXBqkk3vHhygOQnfqW7d0j8lJJSBGJ1i59eg03EZYo4KqaE03FIhJSzxhNzcKF1XwOvrC7/OdTgy4i+DYTNsKDY+5rj/ZAQlf9GoctKIC869fxBh+JqWFwXjZFl/7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx4vZY9bvYKbD9vsGucSUjxwr6P/Xi4O0rMwyegSKS0=;
 b=XRd8RnIatmLXsSmCnzQA1HCYejLR8WW4+vpFoG+Vr4RpXvxfpJgLlEcEBTBRWTUCmdp5YgKkkAeCd278gr6O5CbCh7g6l8Dlaa7UvGhwgDiEmN/+egXjDM5zBfWnBH+9TfR9+aisN3UIoLLsA576L/rqE64rvg7tZ6zIkOFa8e4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7722.namprd04.prod.outlook.com
 (2603:10b6:806:14c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 10:19:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 10:19:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 07/40] btrfs: disallow fitrim in ZONED mode
Thread-Topic: [PATCH v11 07/40] btrfs: disallow fitrim in ZONED mode
Thread-Index: AQHW2BZUj8elrzLE9E2pgiUzqzWKBg==
Date:   Tue, 12 Jan 2021 10:19:44 +0000
Message-ID: <SN4PR0401MB3598E6D18F4CD8ECB2D8C9079BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <7e1a3b008e0ded5b0ea1a86ec842618c2bcac56a.1608608848.git.naohiro.aota@wdc.com>
 <3a4305f2-a3eb-7503-7c53-8c4039378f03@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:480d:3d08:9ab6:e110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99ef90e5-dc51-481b-5fda-08d8b6e394ed
x-ms-traffictypediagnostic: SA2PR04MB7722:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB7722BEF25CF976D580DE29D89BAA0@SA2PR04MB7722.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FoXAw1DtodJkoXbYkE7f2cpUODOwuM+rXVqRUvz6HW4eD/V76aJq9iwIpgWJMx9dcXKQhKSqFaBD+v+l86JaNyM62YVyLAzNUlT8/RsCCjwIcDSzLazUleKXRdXm9xxxw6EGepic9ZhaD8KupuW6/ZNen+T3C0M24MwSanYQ6lLHarIeyMm28QCJZ/hklWS5alNZkZR5jDf9S8jOKMNg+1lwRZDDrmTxttb8ZVOYnLxj5Ug2AQoniOlSEvNG7inUS7HBPeIfC2YcC7sJtMHb1xezhqD7N2hpqVYqsVcpDACbesocJ79UK2wbe0vbNDI9GKHmX4xtPkgdDDDBpyNl0IzMMn/V1zDBN2jVxPHjMC2D/sc0pUem9ffSdK1kHv68/V95wsELQC99G8e5j8ztgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(52536014)(5660300002)(186003)(66476007)(54906003)(86362001)(2906002)(33656002)(53546011)(558084003)(55016002)(71200400001)(8936002)(4326008)(9686003)(110136005)(64756008)(66556008)(66446008)(498600001)(76116006)(6506007)(66946007)(8676002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Y3ptu33LA+bvoPxmNDLI8iCm4sAFcCYlhTe6wEPnKh+hgZcvCXpACtJkvn5X?=
 =?us-ascii?Q?E2JEfxmI2VEShGB2nOJ/17sDEwJPXqYd1+wgBjY47XjNIT2BAovVCHTTdquT?=
 =?us-ascii?Q?tQ3H5ONm/ZCCyToJieAi6gbyCxJQoQQdaWvBNzwNmpIvaY/AE40+qzQf2XCm?=
 =?us-ascii?Q?8J4YdMy0H48B32tUaxk+zs30aCofo6kQfJsf8R4xZcT9pkkPmrW6jLSTz+pR?=
 =?us-ascii?Q?LQjSmyjhQJhK8FQsrNOpXYl5ny/9FX91qf2h2HjDyMnXFtK7oGqUqmgcL61i?=
 =?us-ascii?Q?NOLqcGM7Sk+SH5j1LUpX5P0nbo3cMSjEUDfBotW9PUGwY0gcrJoHAsTyMdeC?=
 =?us-ascii?Q?iZsypSDodX7ItZ6hk9t6l3ZKemO5JbknWQm1Q2JxUKrfcok2xBkxXLGxcPuq?=
 =?us-ascii?Q?+4n4ewsRHrF9+cIro5j5szau9j+N8Uckx/eDjbQYYUPQ08GvTDdUFp8xolRg?=
 =?us-ascii?Q?lZRqdGZdCJJcuarQ3y6KXrXmBCZ54wQf49uYpYREd0e1PJ0Rl/hUEotLCgpo?=
 =?us-ascii?Q?dWf/HrVS0MJAUnCaPCWCWwtUJt9mVcDS1GX1ondRxvGxifpPEfJ39OYX2jiJ?=
 =?us-ascii?Q?domaH71oUlt8T7ModieaC2ma1SAzIpjQKIFoRJEm+OEYiaBEw/UcxSpdPmoG?=
 =?us-ascii?Q?5Ppx7bMN4nxDVSk4rVnTgk6zcDzdXMtK2dG3ZC1ICL3YobygIX2JsMz09lr+?=
 =?us-ascii?Q?RZx3G4b53NLaTWbexFl7MroQ7vCyWPXQnvACvLKplkEUGLHD/6J5yYUjJglK?=
 =?us-ascii?Q?WVsdYW7YLAfvYMiNaaA5NFYi7xrBJcH7NA02vZqoMKmLt5HFodEx4ad6FcGW?=
 =?us-ascii?Q?GPp1IxobGFPn5e3RXEha195QtiMiZrw1bfWS0hHXZP9GKR7g8yJirlZYKjD5?=
 =?us-ascii?Q?sI+Entpwjv+1pZaWu93Z6F9NJT0cqBYj4LiOVM4AVNZGGKAAgYebAhVowAl1?=
 =?us-ascii?Q?KPY7NNEQnKgVZwKZ2XItcAPAse/HDGsXu02lrfymKASCF6KPP1PFELbvEAJ4?=
 =?us-ascii?Q?uAnj6T3BLyXMM44GVw1NpsHRbCIsl1JNW7nFm+kE/Wumz3tHml0YctCVerQk?=
 =?us-ascii?Q?07ldMeY8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ef90e5-dc51-481b-5fda-08d8b6e394ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 10:19:44.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAo0Ij0Q4qG/4cvEBTGRPb+e9DsTeP5X79JUvsdUxSEBOmH1xFFKTCV2CQUBIB1buuxcbyRWur7asEwPzRvrWVCr/mUVbgXf/I0VXDftBtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7722
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/01/2021 21:13, Josef Bacik wrote:=0A=
>> +	if (fs_info->zoned)=0A=
> Should be btrfs_is_zoned(fs_info);=0A=
=0A=
=0A=
Fixed=0A=
