Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54897282EAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 03:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgJEBqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 21:46:38 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:35295 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJEBqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 21:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601862398; x=1633398398;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jrsTXWvtcKh0dg5JxZRgTyxtJf58VJEvPAELy9fdAiw=;
  b=Ajwp5LrC+tBeP8pU7dTBKEJx1qaRUfDJlKRtGYZlUPTMbP/QWh5mKalV
   AbG/JYRAxzifrfzu0+xFeO2fOY8VuILc3EzPW9VWHB7oaoU6s+rxuCMU9
   mouGw1Pk3oBFITyJ1sIYbPe3uB7Xj1QelB3KosahkQ8NHWQY49oG1tG0o
   c+6+3sdrrwsfEO+NwHu9LyiP1p2Gc4dn2KXzno7AZ1tHqZZ7jQRADtOTe
   79g2nQc/vTFUxFJ6JsPAeDSGF0UCVbtFYvrfhJ9roZa4wykB9RL4uZdUD
   2mKz480zeBfzyck049MrjIg2CEbGglQlnxBg3biH/1631jOVVEpUzKEgy
   A==;
IronPort-SDR: YCkeUSUmmLALDUVdEL769tRxY9jyGcPBVxclP33ONQNX8csRxNuok2gK6j4yesH13odEP+QoPi
 ZLozSKfLVQv9yhrQJhBzBTGbdYA36lJADcWckXe+FCN5v/ynjGlgD721DXRVRm3Q52iZ+2M8uZ
 ShRLxjt04QcijTGUBWXnkyZYHzXFG8J0ImBOMRZ63W/nGQhNMihhR8dNlW3XdLk6EdNp0PZugk
 BEPs/tW/MAoaDYHZUDS5jmzgL5eMM0q5UvpaNHEtY/vz5wCSooLL5WyCcKMiwKZgUV7KbXSHEy
 nrk=
X-IronPort-AV: E=Sophos;i="5.77,337,1596470400"; 
   d="scan'208";a="150252644"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2020 09:46:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9BUXOjZqe5qd4sbnbxtnqWiy64t/9PrLABWiixk3Twu2EWUFi7p6kajT+VLD7B86+HaXNwg6ddcfgh9zYdeZIeHI/scm7yYEYeW95PHAYuZ0Y4Y+ttA+r2mjCUBNi2tVvJrc3Nd5KGiALF1ygh4h8A96ldN8/8oexdQciomc9fSXjwSk+yUmB936wE3XIdO0pvdCOIwZL8iELZk/oXMg7DOt6cQv3uLa451nNck8N6BNFXtb31oSJv3P5hDObZ7nFYn9rVjObJzliKKKs1SyeEetzIUXkFSWJRTS/+BZjtuzgkr28gUUOmKeMU63+IuiMDFL4D3vdFcqPDMdZCTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrsTXWvtcKh0dg5JxZRgTyxtJf58VJEvPAELy9fdAiw=;
 b=LLwKpU9L3McaeYm3jbbb4dDUZHR8u7BfMoH9Si2EmPOWbTAfbo4Pv+Ab2lKqXxd5bemDHzLw3Ofm2I+x5vNoA9THOGbxY9L/MH3S2BTHzFVYfMH4EDM5cTlpaYQKkQnR5v+uq12FH63zU1rkQ9ure5oPtDXyGZFetZPGE/G2IvFvYpS1uuy9VX6GBz9/zSD14ZGOfhW+kGAFwlZlNJC4cSuDe9x5IyM+xkD0gcpitg6LVBSZA+9TkCuJYwlji4YFLN6GNGjVCjcUn0YT8xqBvGaQsNEMSqRs3qrsBI3bX6CM5xAuvCvfJXGcW+pcfZuTt/CZGsIscMsvdOa6aLjiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrsTXWvtcKh0dg5JxZRgTyxtJf58VJEvPAELy9fdAiw=;
 b=EmnGacQcR8DI8aGMXHwUrdm/PzV9KRVOsHRN63KaNvmbfvR5IKWaio4lOLdodz6gl8U3HSG/93XwBubtq/PuZBIVHsl/xgFyVS6wp1vbeQAW2EE8acbdwHBoYzgh3nNl9qOz/EwG+boJC1uhaaUIix/nayt3EeQyvkgnkDlM+Bc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (10.172.142.14) by
 CY4PR0401MB3587.namprd04.prod.outlook.com (52.132.99.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.43; Mon, 5 Oct 2020 01:46:35 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 01:46:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v8 01/41] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v8 01/41] block: add bio_add_zone_append_page
Thread-Index: AQHWmCICMDDhRg8S9EGeqVQ0V4cAqg==
Date:   Mon, 5 Oct 2020 01:46:34 +0000
Message-ID: <CY4PR04MB3751168260AB3888599741D9E70C0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
 <yq1k0w8g3rw.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809a:93a5:8305:e8b2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd9c6c9c-3e66-4872-1e1e-08d868d07e07
x-ms-traffictypediagnostic: CY4PR0401MB3587:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB3587175A4715811CC3E412DEE70C0@CY4PR0401MB3587.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdPdCW92f2TdFGwd/CPW0TVDjB2XyZRxD2lkVJv8bZxStRDPRsf4XOGtohbMvC/qQ7j1QwnYfVLco/riuybqfBsRyQzOp9bxYF00CPvHr1OYpwx9tqsthGXeomRBRn9BpQicke4tZPg4+z0lFJocqSGWnd/UtH7C0PN6dzIULbt5geXgIZfUHC0s4sjz9zR8vekz0lZIsaCQ5lpI8AOKnpLNFoe4h9kV23dqemRRL1Ob9IShoaazCFl5+6DoSScsH6G5Eq3OOOIlC4oxosfp5JAk+4ne5eKHHkivx9ZAq60Bj6OTM7y7pn3GlKzEBUasDHtTTzN9+J1VvuQTwXzzyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(7696005)(33656002)(54906003)(8936002)(6636002)(110136005)(66556008)(64756008)(2906002)(53546011)(66476007)(66446008)(4326008)(66946007)(6506007)(76116006)(91956017)(8676002)(86362001)(71200400001)(55016002)(83380400001)(9686003)(478600001)(5660300002)(186003)(52536014)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TDWHODlP4NAWFw19ggZGF9ZygeP9hdO6W2H9tPWJmUAGOue9XEBt92RtK9QiBjErL9QgV/d087/bkkIMhKie7HF+3j+1n1PFzQtVYbGbogiWCJCp0JkUtuzg2Ic9o6/Ejv2W0m4IWsGxPy/jA5yocufiEPONpsO2omWO4zZCThClX8/Kt5e6vbi/UZZMfb6b0E5iODw44AgldOhzkBw2ei/E/UC3LKinq5MZR+JRmDPVxhRVAkeoQ0FCKKkl97u6nKtdgDOe1M3eCwAPUDcmftrmg13U083h0m1WsoiZfs7QAMEUkP8DfjgfJkgD3NfvWPaoGx0LXbzsK6sdj3hYTCfSF/DmbY+t0fDCAKM9CuLhA6r4dP3UR3FkuUwJTu8tVjos+3V3HWmC4+bktq65Ki5WP8uUkessInGdPn1Cd2gVcl1hdfsmnFuMTO6PnAClGeQKsgAh96s6m3JnCwVLmZ6LCXwfnLcYWRYIsTgLk23UZYczbJ+Wyo084nhlS56qoxl2UBZAUW82Qq7ADaCdRvEQXjW5io+U0TnklOsf7kYFR5WMk+nPJgsVfDVD5XRAh+pcuFkR/NeN97Ej31H+1WHYAVvzH8M1cVatFz0NJzYKH5+xMUKApDQgYCeqC20rU+lXWJ+F8KlSJwKXQ8m+VQyoQLfs33Nu8mdRYOtO0orS4kL9bKSUAVxQzGKDn+j6oPUb5wXsEIAAjl+H/b60RQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9c6c9c-3e66-4872-1e1e-08d868d07e07
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 01:46:34.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4/NE9acpNt3YTSmFjTFbzXYf4C7EOmA4DpFnD3AyN0/WBgrqrVxyDtOR62v8FhkXMtnyMdqE6RwFU8s4rngeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3587
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/02 22:39, Martin K. Petersen wrote:=0A=
> =0A=
> Naohiro/Johannes,=0A=
> =0A=
>> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which=
=0A=
>> is intended to be used by file systems that directly add pages to a bio=
=0A=
>> instead of using bio_iov_iter_get_pages().=0A=
> =0A=
> Why use the hardware limit? For filesystem I/O we generally use the=0A=
> queue soft limit to prevent I/Os getting too big which can lead to very=
=0A=
> unpredictable latency in mixed workloads.=0A=
=0A=
max_zone_append_sectors is already gated by max_hw_sectors, but it is not g=
ated=0A=
by max_sectors/BLK_DEF_MAX_SECTORS. If we add such gating to=0A=
blk_queue_max_zone_append_sectors(), max_zone_append_sectors would become a=
 soft=0A=
limit too. So should we have max_zone_append_sectors and=0A=
max_hw_zone_append_sectors ?=0A=
=0A=
Which also means that we should tweak queue_max_sectors_store() to gate=0A=
max_zone_append_sectors to that limit upon a user change.=0A=
=0A=
> =0A=
> max_zone_append_sectors also appears to be gated exclusively by hardware=
=0A=
> constraints. Is there user-controllable limit in place for append=0A=
> operations?=0A=
=0A=
No, none that I know of. At the HW level, max_zone_append_sectors is basica=
lly=0A=
max_hw_sectors. That is gated by the zone size in=0A=
blk_queue_max_zone_append_sectors(). If as mentioned above we tweak=0A=
queue_max_sectors_store() to change max_zone_append_sectors too if needed, =
we=0A=
would then have an indirect user-controllable limit. Or we could implement =
a=0A=
queue_zone_append_max_store() too I guess. Yet, having everything indirectl=
y=0A=
controlled through queue_max_sectors_store() is probably simpler I think.=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
