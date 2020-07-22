Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6807B229194
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgGVHD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:03:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29404 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGVHD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595401408; x=1626937408;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZqCO4R8P2m+FkHvzzK+0WLPWNYU1gTTyLCkQh9L/ClY=;
  b=FV9iWlFrsaGdJQ+IfJO3N6bQq0NfcCJ3eGSNHy3bLlmecJ3reGShP4x8
   A7JDOEXxOtlae+OmccsRPACCcBcAI2p1xKQlSz7q7NKxmc7Xg6TiVDnhg
   IFSIphJJDOqLLqPIGjjJo4InUHsls+8MtbPTmjAz+SdHo26JTS5GTOvPs
   hWyrc6kk9Y9C2Mu4At9IZkod/+3svYq90FrvxwoeUYLmsaLAq/6qxCrSF
   gsEeyJATwXjAv7RU//UkLkJxURCE8AkSujMhrYUBVb6c6eR4jwxeqsq9K
   WBvL/bg9TXOl0qaayCiRMA73ed1Cj4zSA7t4LyOKFdAd0fYr4NjulnhMM
   g==;
IronPort-SDR: M11R3nnCHYvP6eLcDVDQ7lvFZuWGlt7OxOcsv8q+8ZkPvcEL6hUQJU1I+aN3i2RfgfWpZGQFqC
 4eYoAApKszoFbzO3wQoqpfN/0O78U1AzVyvYRn9xUNKpLoaB2QivOEc49KN3DXKGgDJcUTS44v
 ytxNLH5NkqXRsd4Ro6VfP6Q8ddeTk11Wyn/IXwYA4ypK9v0Tlfa5WFnVqIc/c0SEQKTfOXzCve
 ivd/NtSWCV+6Fzem4XKhDo9XTt2iDhHoBEw+ZfbEL8z9zlfdjEFFm3lyLHqk71hMAaNBemz2dX
 XwU=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="246134845"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 15:03:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEfNLJYacGgFOBnORUv6uHIBj6mOnyQV+XLN6jq7E4wlHxxeGJTRGy0iKyLaieFNCvvaHRs22b8yuAt9SW5yGtqK18C2wzSl7gFz4BVEtq0+fOiiGqsK5SI6Skf9H5tUr1fSC8uFllLsE8IfJT8Q/aTtSL28K5bYTyL2CvCx3IYXKvR1cEYMdUPdV1xrWlCjE2ulnnkLPXuGV1nKy2fwUVJ7uOEZW2LIaS0528nXi5sSgSjk/tpWcSnN0ahPNJLQjeur7rVKkcVeTLC479ubtYEBcaQ4LJaWSasSQAP58Guj7okzq9Qe8rLOao1eFnPVxTVgQCUe6Logj0HyoNZq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yNciJ0MaHm33mYwu8p1ho4mWYWj3E5JhuQT3rAgcYw=;
 b=e50Y+R/3zvr0VNBRA4FVD7aC/1cit5lpMXsseChLBQ1yzbrMeZpoy992OMkgoT5cWDYL+X1sxJoro94dOHhqLZgS5KtQmsGQHbHpYY0FrBPnH9GKlRkwwAKw/K5odJvuOeNYaUdHoHpgG9Ff/h5IHDZ2tQqStLgnm68a55yR2xY9bvpGO5jPIgggvdU/NkJb5VSpfNvwxISiM0PL5b1v8HbC30owLxz5Hctv/huGkRwgLyDGcN4oBG8D4CqraYcIYEkAKvFy81BAT0+IR/vpBcWNNN9Gi7bM9iEGjRV0l2dtXHAZpRJGJhPIZNtAjM1n6V65l2kjLH/l3QJ9pON3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yNciJ0MaHm33mYwu8p1ho4mWYWj3E5JhuQT3rAgcYw=;
 b=riN3AATdn2VdnUvTtx+Jxsa8oOVx2L47gR+4ErUs73lb/BQkjxGpdrh3G5/19MNGVR5G3IVbBiEUPge+wCVtYtBmNkGYpjsth1C6XV423KU8zY3ZrxAJiKesB3ytaQpnlI1qITX/MR66s1WobqyWp/TJciC7t/XRpAnnQCV9+SQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2239.namprd04.prod.outlook.com
 (2603:10b6:804:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 22 Jul
 2020 07:03:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:03:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 02/14] drbd: remove dead code in device_to_statistics
Thread-Topic: [PATCH 02/14] drbd: remove dead code in device_to_statistics
Thread-Index: AQHWX/FEcddsN2HZWUefz5cntVZ8LA==
Date:   Wed, 22 Jul 2020 07:03:21 +0000
Message-ID: <SN4PR0401MB3598495DA5AF46CAF019BDC69B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722062552.212200-1-hch@lst.de>
 <20200722062552.212200-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f03f427f-96e1-4bfc-9150-08d82e0d51eb
x-ms-traffictypediagnostic: SN2PR04MB2239:
x-microsoft-antispam-prvs: <SN2PR04MB2239054EBC0DF37D3B353C339B790@SN2PR04MB2239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ur+KZmKpBcIPSPWe6QDshqRorQKKgiz4i4dCc2w/Mgbz7W2X8PzWs1JO/Ez/ayfUEGw7CHVyXvb51qPcJ/kYmyK6xIPgf2SVdVkkEstU8iam13w0F19SCf+eRj8nVQ7ykmFe7EozElGPGGESfemi2PLGcEgC0mVW4fTDIhGyMZgyGwP4zS1wKMeg3C57CvkDQFN7jyuHN+vgk3urX8A/Wi8gCKLZQZrgjx14F3Zx1SW48pdzZRYPdlQGi9tBKYXg5C8HGeWUW9xIE3kfLD9WBGjMYnHQrmpbQ8aVDTfpr2TSjasQN8B5kkmY1HTqdVzR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(52536014)(4326008)(478600001)(9686003)(7416002)(55016002)(5660300002)(83380400001)(33656002)(558084003)(8676002)(8936002)(76116006)(66476007)(64756008)(66446008)(66556008)(66946007)(26005)(54906003)(86362001)(6506007)(53546011)(316002)(2906002)(71200400001)(110136005)(91956017)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KbceinDNyzPx6xtboINYdGToiwTAz1b1sqcy4JMns4vDK+CdiytP5ixaX99sg79HGXhTLQN3MRmxAwmHKIEG38IzyJGlFE8ozXaaL1e/+m0CGSTRzMP8kMAtzmhmMVJKgysTJbuOKs/MeLW8PsA3hEQ+IEE7fVp/RLmjBbyUk0CCYT8Xqfwoerkk3t/Zv+Ihqxe/EOSksfJnc18Bo3nq4COV2/J4z1nf96a8H9OJulfoicgWRWF9wAQ8u7c1qV4qTgcYRNOW4NpwdG0errMx/hEziY6zvUYvbNdMl6J0zw5/FH5HTLIiajqWMa33TvanO0rqZP5WYz1GE2mJmvA0L9Atb71q48ThckFf1X+YiTdWkUHaXhBEDPbByN2TTEd5o/HTdEWbUmGwnUWQ9ZoSYbuFckiZEPmEPMgfsAIXg3WwNYyQqUuTL155JwDDs3jxbQPmU5eqmHnqvSVjUejd7JnbKGgslKZGcM4upqYN/jjEKVBuuWS7oAnYQCIuw4MI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03f427f-96e1-4bfc-9150-08d82e0d51eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:03:21.5601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/WE4dczctIGgSYMUR9eZ1R2NyNqbmbwZ/KCyUEJyhcSUO1QWSOT8jiIfxsQMNl1m8YItrC0n0JPgZFdEJWubhU05Q4/a2Blj9MUKK38nfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2239
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/07/2020 08:28, Christoph Hellwig wrote:=0A=
> Ever since the switch to blk-mq, a lower device not use by VM=0A=
                                           in-use/used? ~^=0A=
=0A=
Also this looks like the last user of 'dev_lower_blocked' so it could=0A=
be removed from device_statistics if it's not an ABI (not sure with this=0A=
netlink stuff).=0A=
