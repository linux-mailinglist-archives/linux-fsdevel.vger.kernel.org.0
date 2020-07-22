Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF10229303
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgGVIHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 04:07:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10033 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVIHL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595405231; x=1626941231;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H5IRuauk3wKNMN2xGdt/GL+SPEeRy6xypWV629C8r8U=;
  b=rzzQJGt9O78EoaASVJwxgadQ77gQh6UTAzqjkC5UKD5aayoVwPkj6911
   qfMkZpSN/Zcns7bcTa/cd3MRqcbUhKT2ny2kbfDEd47zVtH6Df2N3wGWD
   BXm3naugH0zReU5R94melUXKH7KHQunrkC3uMlEhkHenhMEw0gUvjuaCS
   uz8Hpo0IdUPcESoRQzWtL+Z76vt18lU4GDF975eoM74VkMgQYpkez2196
   PY0NXiks+ilob9G0Fr5WfqCDxUlqAFFPcIyx3O2SE2ceT0HUqVbgWQhS4
   rqApQTuNW8DMcGfhmIC7FMOj962/wDJRfHTKOYCKlCZ2/Q7RnHE8eIuUa
   g==;
IronPort-SDR: VAUV0yuL+Eyze0HgTY05NS08c/OzuCf/PuOiGj9xZRHmwyZ8eLwLXCTW4/I4fgStRR4g94KIpd
 LEHKQxR+OeROTDU0RirG4/lClNYDVTqEGMYPoPTnoWaTAy4rHJuAttOOEzbmhSzTFK/Ddn05pe
 EyoabPTlaOj+8PjO17BgUpqM8a2H4+KJeRPPs8ApEi6na1+WUjTylrEdIGARypeIy+biio9K4q
 pPPe/+6Z3TTohf0NYAwg7IS/azybKw4QybwRjUQes2RukrHmO4EaWQeZxkx4+a5E6nBrLrtI2D
 kRo=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="252379186"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 16:07:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggqexvLDqruinSUInxzbSUz9jyeo9XOepIIboMZPRlWN2g+3NY3Q9JsY6NCfNvgoJZVk33LXYIHop9eIPzQ9cfFd9Tq5NPbHYm+bNnrWElUtB2gmtC5lVycs5I0DAEXWUkSiZfEi7RDF9KJP6uJaZ0dmGvMmR7Gtpe6SdD31sK7HeKeMxLQG6sDM+TM9c1muhgwE4ftCIZlROb0mXFhE0GKKAwQWwWZJ8uVQJx3pr+mvcE0lkkExAuep5tjPJATbHmc7uqKg0+9Dw8KMostPJo/knJ/fJabdEosOwbBtLf7z5ifF+pnbHRpm6uNiq47CIrlM4VnpBxUyKFMuNn/rfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BrL2k+wwRCB31klmGphafUnzdb+0Hj90fpv20fT5bA=;
 b=ejGZDLjo58r53iw4jMPGFxCWEDAbGL7AxmQj3FP2Q1cSHK05SJzhnW9Q8TNDcOElw1tsdqr+68zuhS0Z9u/Qy2cg+YUGtI3TqoG4gZKmHMU3orNmPgnc1aWzoHYVkvYm8gI7Q5nKAdUCfDoW4+oou83mfZnoVjEP4lMo6XU9msNshhrFplHM3MnQDOzZxKk5D3EYZYxKJOKNhDe4xOXJ5/Z0QMAkXIs59g49GBZbXsLjPAPosrz8DKnQpvrrudTCWlKPynEbYlxodZUCYKFSVtyTJpeSu3e0uQTpvgNrtfSEYKSFRrc2CjUVKSw+1iFYPgiksv/l765aK9HVeiZyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BrL2k+wwRCB31klmGphafUnzdb+0Hj90fpv20fT5bA=;
 b=MX3UD1xFNAUTrx/o22hvREj+IeoAcuYW8x6PzeAW5qzFdZboJcSbTQQbH+Rxx/3RaeEx5+heuVpZ3wCJOJfAs5Ew8+GKDFGTrdJeJu0nsnD/bcENz58XuCL2/NUNkAfSXpXnMSc/68WOJ7DGczeH8qzkm0HWAJ6t+syMW190aOk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3586.namprd04.prod.outlook.com (2603:10b6:910:8e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Wed, 22 Jul
 2020 08:07:08 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Wed, 22 Jul 2020
 08:07:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] zonefs: add support zone capacity support
Thread-Topic: [PATCH v4 0/2] zonefs: add support zone capacity support
Thread-Index: AQHWX1fx+5ePxu1HFkKb2SEyBxXVpg==
Date:   Wed, 22 Jul 2020 08:07:08 +0000
Message-ID: <CY4PR04MB375184892CA80B0485E48E04E7790@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200721121027.23451-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: daf09b2d-fc02-484d-99af-08d82e163b20
x-ms-traffictypediagnostic: CY4PR0401MB3586:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB358685BEC239CE1033337A91E7790@CY4PR0401MB3586.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PENyz5n6+W1F24ej/RQgJMf/d9yJJCGqlvybi8WYaj/f0vGfmVTw4ROaLk9QsOaWcGweOUNlhMeXCjstb6xDTEINVNwBI1xuyyRdMvzpaxldWznQpEYzi4uIqRMgJmVa4XdJfsmWZIqgptOjAxBwPaRtrRXXG0toRF3OvzgbPJwSihEfllpAFLPnfoElAUYYFFK+zCNuDawa5guFitcGUTh1c60a7NRJOgYqnVsyOr6SfZSfq5x6sHm4u7SZBAZVkreJcFQk8vhx2oTXvxxUSqefoARskHB0PWKWBKV/kxpFfw+CRhZIOFXHa5ioENHY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(2906002)(8676002)(55016002)(86362001)(53546011)(66946007)(316002)(4744005)(76116006)(6506007)(52536014)(91956017)(64756008)(66556008)(66476007)(26005)(66446008)(71200400001)(83380400001)(5660300002)(7696005)(33656002)(8936002)(9686003)(478600001)(6636002)(4326008)(186003)(6862004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8QBEPYKI0cH4MDXsszDe6QFRTo298YiENwnZXgZ/lMBYfCY1f1Sav/omrI76/5++6QO8Ui6psZoAR3kjPRMy3NladUfQkZnxXv1k7QLaeoomUtyatxLBU+4UaA/6Og0j6Q4L4F0XXKjB1zJILlBwhhgmnw8tJCLCTPWSpwKbv6k20NqbxVo2nhGtc9VNUSul5c5B3p9hfiyxdclL3qosEDEj9xSAtQ/1PWMvdpHQYEKuK1dxDH1JdjUvY0hHo00P+2gmGIbjLlmzT+BI3MTUQaW9sHWX1F1MWU8GNPep+PrMW45KNvOJTDZsoXUwfpVnGE1uh055K8z06g0aEHBqPc7dGWbE/Q0MQdkP2FD3VocNp6qBhgB41K9utZ1sqrqOm8gkXUx+o3aSFOQiUJTVAUyfHKpjqpdz83Xz/dr9RdouZq+0xlPEc75cLtrGaCAU67VpumRDqNTHkhEXWBSGdSsGj/kKMRYGjA0J2J9s7LEYTszM1qGqrF0x77ZKphoC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf09b2d-fc02-484d-99af-08d82e163b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 08:07:08.8196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j45kETOXAibuaWPPy3tWFe6h/Y3a2h0vHyzLGgkoH4KUq6Uzrx1QX1JyJ14bMSxlmRT/KnU7sXIpvsfTSl86nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3586
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/21 21:10, Johannes Thumshirn wrote:=0A=
> Add support for zone capacity to zonefs. For devices which expose a zone =
capacity=0A=
> that is different to the zone's size, the maximum zonefs file size will b=
e set=0A=
> to the zone's (usable) capacity, not the zone size.=0A=
> =0A=
> Changes to v3:=0A=
> - Fix error handling of aggr_cnv case=0A=
> =0A=
> Changes to v2:=0A=
> - Update aggr_cnv case=0A=
> - Fixup changelog=0A=
> =0A=
> Changes to v1:=0A=
> - Fix zone size calculation for aggregated conventional zones =0A=
> =0A=
> Johannes Thumshirn (2):=0A=
>   zonefs: add zone-capacity support=0A=
>   zonefs: update documentation to reflect zone size vs capacity=0A=
> =0A=
>  Documentation/filesystems/zonefs.rst | 22 ++++++++++++----------=0A=
>  fs/zonefs/super.c                    | 16 ++++++++++++----=0A=
>  fs/zonefs/zonefs.h                   |  3 +++=0A=
>  3 files changed, 27 insertions(+), 14 deletions(-)=0A=
> =0A=
=0A=
Applied to for-5.9. Thanks !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
