Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD08E28453A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 07:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFFML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 01:12:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14814 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFFML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 01:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601961130; x=1633497130;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EI1ySS5O4hHNuL3SSLfFd27W6kFu52cM8TjhY69zy6U=;
  b=MQmcHhZS/fnNzwuR/m5lb3kCxb48yNaSD2lNvwctoh+5P81w1nic6Q85
   OOjeh3oyZWGsNPYbMYjX1h/Wu06vxxk1wHXjpGfZHWGfNSte8r+YcIgfQ
   UWpxi/5OkMoGTQPoqfJgRWZU16+mjU/vygb8cc3rRyGjVffnwr8d8aYcR
   0BvpJFIOG69T1MNW4ep4DyM245n4BIzSg6Cl74ATipQLUJa1HpZrhyKSN
   MB9EQD//n35XKU4aghk9XpfhqVAvpkYU40HAb3SZPrgWy9mP8IZFi+NNU
   XEmvIvhKtrdRtEdRONps9BbHWGFIJuawvbVDFocCDsna0nFPy8tUiiY37
   A==;
IronPort-SDR: T7NEAbToYXILWG3vKD+bTfZxHhfJIavTTvf63yhRQf1x049kyx4xBj2oNA6H55IdA56aMhILCs
 20oxhHUdMFRNzCQquyKgJ8XlvxJVKaTPrupeWrFF523ryHemRcyNWT18fmsyPnhre9bGY3jvo3
 x/FSOAH7b+rDOXfyqMUPVaUKdxUYZXk0MM8HnNYkG74bLwpimRtN8Aftu3maTKDvk9HCx0zcIP
 EKdPV7bkUiVeV0e0YeIf9ZAmg2I6UDCF8BReYCGM7kiUej9h1LIvM/K1OSqHT9W53ntsv/YZjT
 yGQ=
X-IronPort-AV: E=Sophos;i="5.77,342,1596470400"; 
   d="scan'208";a="258922402"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 13:12:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IB+n1B+ymDbPdWdcfVQ7rjeZfPWhRMGmGt8fp8+uAPY1uAR41Us5xxaQPwvR0SZKW7/WKnVmSmOu2UBuEq842BwJt7sRn6bAKcKsWEnJHbGdyl+bKeY0VGf4SPokm0jDjS+zcjeeU1AMYMf9ImBFVXlWEi/eXVr0tKr4fyD9vns9+2PqKWpomnx9pwLT4blVWw8YBehM08IyiowhtYFT3y7sorBPpTms4nAeybdtpHE13ILZywUG8Zmd4J7dIBK+VHgvu02BqoMOd2n421HZrlR1R+2w29uhP84jzZDk1IORbt2tYW5jI5EUkSG6QIUexPw107X2L199/zF+9Avxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI29J8PpyOHg9/4YmqwixZfCzeidkRsdCqDO12WBico=;
 b=kPLHGe3R+hupS9SMPf+w5jAFRBXGxTrBV/UbI6sTXRyqobVvoUqFjMmvwQJQ3WQXcg17vCwJkyotGiVn2KUsoTeZ8tQdmMtK+Ulz/HSZ4VQ20Wu7Jd2/n3ZXTfeb/PGWdcrF6LfTaQrqYq5bjf/W1PHtXXx6SLazKH6nOh55rWwUHTBpQ9mMEFhz1MaK8Mfz//6HiqMTIDJWyHTIP5ziQ4Dl7c+1vjozjTrFzX7DjG24KMDr6BiOTjw8O4arCyLJAp2AGUpu/YwQwfut7+8Henek4IuDxmj8EO656zEfWX1LwXvZKQ5baDsNXOL9pw3CTn5rkPM7A8jc4FqjG2AeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI29J8PpyOHg9/4YmqwixZfCzeidkRsdCqDO12WBico=;
 b=n73+VCwf3tFG1qtk+QZD0OOOQG2P4r7h5CWTi64lgC3t8Q6GDQYhYt8cgo9mVidLixqUzP9sG16Gx2TprEOwn6Wxks2LV/vQHv4DeujKqOD67ZbUB6Mz2rmL5vEXlnM+iTUWRJzrRTIip13A20AeTdYMMTCmbrppJd/sadiHaMg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0968.namprd04.prod.outlook.com (2603:10b6:910:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.43; Tue, 6 Oct
 2020 05:12:09 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 05:12:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v8 01/41] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v8 01/41] block: add bio_add_zone_append_page
Thread-Index: AQHWmCICMDDhRg8S9EGeqVQ0V4cAqg==
Date:   Tue, 6 Oct 2020 05:12:08 +0000
Message-ID: <CY4PR04MB37514819134C6D19C216A3BFE70D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <dece91bca322ce44bed19f2b0f460fa5ded2e512.1601574234.git.naohiro.aota@wdc.com>
 <yq1k0w8g3rw.fsf@ca-mkp.ca.oracle.com> <20201005134319.GA11537@infradead.org>
 <yq1v9fo87tz.fsf@ca-mkp.ca.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1d8:5f02:9c5c:7c1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 639d718a-9838-4af7-6da1-08d869b6600f
x-ms-traffictypediagnostic: CY4PR04MB0968:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0968EE279B7AD92783D8C924E70D0@CY4PR04MB0968.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vEJTUwi89xQsRnaqRZEi1ghmTtXwWuYu62VqBbFZv9l1f0ANQIqpQOWaHHk5bO822vNeEeTtvz/sMMtdTSCC1mxTZWup9EnUX11EX9YoMrU8Io0/s19iL5hmHdnIMz6wa0c5MFpHrpjYkvKpJist0KJoSQyzK5Zp3jRedPIRzEovqJlcNgc1h1rZERD5kwQ5rqr3CXYBA5SagIKyJqnM7qWVVuvO+ZEXWJzS8eomeRJ1vX68zjdm9YJfMIyqiB8liaVj2FaApo07CsLWSva8A+kBZqXUY4Z2T01pWJMxo/DVHbfl+ed4RERPjvSQiBl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(2906002)(8676002)(86362001)(9686003)(316002)(83380400001)(54906003)(64756008)(76116006)(66476007)(66556008)(91956017)(66446008)(186003)(66946007)(110136005)(55016002)(7696005)(4326008)(53546011)(6506007)(8936002)(71200400001)(478600001)(5660300002)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 04/c0oizfq8AkOS1dd3VPHCg770yCTALvoePxaJJpLIxvf5aYga3hFeCQK83yhPBX3QIWQ54EGpsP7cPqtnatOMSxWvewq6Iu1sFGn8h3kT1wCqhu+28AjrBHJsIuU04C/6iF4E4sDYMIDAFYPPIEGNRHnhFvpivGt/m8SYrYVNfvAbcHnDo8S3PiDXpE4mPKklW9A9TSF+mq3i8jz5U1c1uc2eKshRzNf+cZbTqwkfupSKus/1j9pOWmbULIRUve7OGj0mDoNiQTZPvFpUvCEPjnrohJCss1G+fYmdzZcCfVszDOxOtrs0UCxRrnqTnAqBm/O+rFuKOAg66dy83++hcXD7syxEZDhR25XX8nuTvkF1XPOpByXhthpqeliOw5ZGyPcrCRwsQGDsSYfIvlXtKcyqF/SJAqqOObPQXUGcmMmqgRZ/HFNKTWEJiq6RCiINu3rdIqzW4kAJXaAAG1REYFvWskKCEosxHosEjDSXlVhVRDQ0YXwAT43mdx04X07MFn84ldu0APGHPbz4QR8ZthRvK6N6EdH+/a0Y8LuN8np0q00ilFjR2w4u3lKbtWWMyWk2ia8mnk112Uc3FpMLsOXXcmh4CYnl71ZT/aiqLAtrSTmnvjA2QddRrPgbnfz1HJ56RMqUf8+0dwS5+VSxVbGznW/J6WFBiYm9J31E6/4AAna9+wESUhmh3f0aEXK9J/jjw8d7lMBhe+IA78Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639d718a-9838-4af7-6da1-08d869b6600f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 05:12:08.8183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODzbCreHGbeVvUAUm54MuNKvvwgdhHG4WQhn8R7omprBCu+f129eRKVfYLNLh6Q5qyrK2oxbQFZ7afJE/wfmXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0968
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/06 10:27, Martin K. Petersen wrote:=0A=
> =0A=
> Christoph,=0A=
> =0A=
>>> max_zone_append_sectors also appears to be gated exclusively by hardwar=
e=0A=
>>> constraints. Is there user-controllable limit in place for append=0A=
>>> operations?=0A=
>>=0A=
>> Zone Append operations can't be split, as they return the first written=
=0A=
>> LBA to the caller.  If you'd split it you'd now need to return multiple=
=0A=
>> start LBA values.=0A=
> =0A=
> Yep, this limit would have to be enforced at the top.=0A=
> =0A=
> Anyway, not sure how important this is given modern drives. I just know=
=0A=
> that for our workloads the soft limit is something we almost always end=
=0A=
> up tweaking.=0A=
=0A=
We can fix the max_zone_append_sectors limit independently of this btrfs se=
ries.=0A=
Right now, this attribute represents the hardware limit but we can easily r=
ename=0A=
it to max_hw_zone_append_sectors and define a soft max_zone_append_sectors =
which=0A=
would be min(max_sectors, max_hw_zone_append_sectors). That will result in=
=0A=
similar soft limit control as for regular writes & max_sectors/max_hw_secto=
rs.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
