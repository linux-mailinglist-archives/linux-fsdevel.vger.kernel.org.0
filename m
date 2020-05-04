Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2405A1C349E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgEDIik (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 04:38:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51636 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDIij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 04:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588581518; x=1620117518;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/y2r486KCKo1S8I5b7nBrSucNxCA+ZHXZb6xI0D+wDs=;
  b=c5G0BnC0LKKDFI4VVz73gAf/9kZ/qpmMdAF4I/IAioROhtrqFKCLfWGU
   rjM0DY5P9JowblLGalS/er2hSbWR6U9p6nY7rqFQLVud7BmdLyOb6jiO+
   PnrbIIulDY9Sj+YEL6LZfyrCeuUvD+AgOOe3/TYKRwZYQ43BcE25jQEVd
   UJ6KfnazFrEwjk9vU/AT4DlJiarTi5nO2jdPSE4LCp5TVNdX3wbCCRcZq
   5iAegDhrY5ZKQPArPUu8uzVLQYfSuTuIqVzoY9kIOnJsi9cU2UTlK0mg5
   yqechrS/cQU8I4SY+dCBVUB0JezNGwRkc7CymqropXP0eqpaZXyrVxNYs
   w==;
IronPort-SDR: AHJLqaKSfTCi1DI3AmsfeXv0OEkASDDNBQPhHz6zWl+J23RolvBxHJNTdd5Wy/su7Hh34lRUxK
 wT7OcI+7NfW79sHFu0oLw8SzZR6IUiur0Ehc8IEyqiMYnhJhsyaas6G12kfRYeyqISc1dMCbdE
 BFnTQ+h7OapmRlFGy475Vr9UdW5w7tQzdpfEXS317QKIRR+spLuq1aCHSKMhhgFcYARP63nVEE
 tUnJXsOrV8qN7qQzNdZRRYAOXNU2biFC1F1wBd5OT1Ca/AHju3+XnyMOcgEnpoMffkrPWu0QqJ
 VsM=
X-IronPort-AV: E=Sophos;i="5.73,351,1583164800"; 
   d="scan'208";a="245695726"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2020 16:38:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg4yiRvgMvAPDQZ3BwRJ+fQU3ZQCakhb1NCefu4NCWR7X42RhE5DnF4decWX4uBKgt7WbXsdjQXogg5/EZDhzdbZgrRDHV50YktQDIVP2GSwLlwENDy126k8z1x/arze/sRKdb/nhgslbShDy9TlGqe99HJ3Y+4p1zXAh+7wL8hNv67/dX+5EbFffGY8EZD5mshwsG7fxJ1cqk+W9O26EmHpT+zwzaQGNNNR1UPdt7xrNrAd8ygmSZoxORaWPZYYpOJYnA1U9uwxtltC0jIZ6gIp5JT+omYOBYPQOxcDpZh6Sjytz4KRvpaxRA10dtSP2kdHgJ3bSUtXdaheV1wIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkeWlw5J6E1secvvwPmpqDICUYC/gIq0hp9/LjmlIyc=;
 b=PQuGiF/yDfHPK6Z6fRi1yoUU4zIxPifY5T/Zw7a4+jVz+NI6seL/W+dxwlJu80FtN0SbIbGTXZnANLkzCqfoCHTC2oklLID8wGVmuzG5qfOJu7nzVqia0hVbG8FGfuH5O0Kg77rvLLTELFSwO5YJx6Wgh1hJ8+81bcTBrinsO2pJQXBzIlq7mm63wR+BY8AIF32Cp4gHx2sF04CLoLDXSNnZpo8AYQqfPZljNNzaQy1usgD2CfBzKzcizvjoz+gEO53J4ofQUiheQ48zkN0KVCcESUFZmXtFIMUSUnQqnDDN7LFttHoA3YSIhiYt6s8QumDnXffTY6R8o72ZOnLRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkeWlw5J6E1secvvwPmpqDICUYC/gIq0hp9/LjmlIyc=;
 b=r0JyTTF0CwDyCIT2zoYokCW+gOVac3i1FUIO92W9NhrV81VaKVEtth63Gmsat8rv+z1BeccB4tTGEck4s2x9qZwq4yOM1o5Hk4BuC7SjGQBvp/VF5g+5UOZuS6yQd4lMoHAm0k8x8UoD1zOwiNy72HnfNHhqSb8TdlRwlqW9QrQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3519.namprd04.prod.outlook.com
 (2603:10b6:803:46::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Mon, 4 May
 2020 08:38:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 08:38:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Thread-Topic: [PATCH v2 1/2] btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzQ==
Date:   Mon, 4 May 2020 08:38:36 +0000
Message-ID: <SN4PR0401MB35988C0D697D9900C411F1C09BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <20200501063043.GE1003@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7dcbd8d6-cea0-4fc8-ca8a-08d7f0068a03
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-microsoft-antispam-prvs: <SN4PR0401MB351944F4D26508533FD6A80E9BA60@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uuU6QI9LXgxaaRPnyJjlA4rc2jdF+bUhOP77+D4sJvnj4Dz+ImRoIKYeAOFM4P74N0+/iq8ckbFjETo+yYMHeB/8IFCyJTpvW3QGTnbPOLiicRFigD8TTW83VzsC5R1SjVi48KVLhdvIxjKKdyIlF23JKP+71LWXBCgSxC+FuAE0/aHC04KtJPVWfbG6UDgNOvJ8NWlnOk2deyqoxRhJU1KpD0hx/Y41olxmBK33lhpW9Fmzd44YYpxz/rxJguba2JNapFMyFe8Xy4ZM6G7FFzq5pUOythP8Wj8xzmvYN7JvJZUT/ldCo9DilsEeWZMe3jrPaiIflzhniKliIW06DkXDoQ4WPpOWmobvN1G2iNvSqcFAqVwsY1vfTxHJCLG/i37NwIeACKx1b8wCEBlP7FF56SkdviSl+56ocRExq1GV8Nu4Koz/Yt3z0LKylCpl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(86362001)(8676002)(71200400001)(4326008)(9686003)(4744005)(54906003)(110136005)(55016002)(316002)(53546011)(186003)(26005)(91956017)(52536014)(478600001)(7696005)(66446008)(66556008)(76116006)(64756008)(66946007)(66476007)(6506007)(2906002)(5660300002)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: g8VezCtuYnyOeMqaDhwx73uSmjBfz26yhv6kpXbrifygJaL42c/450CfwniN+uJQH1cie12payOcIITgsK0/rzwJqOgQvHIvA6voKeYi6xQkpM41C3/ZOiNqFejn5SPK4voEGG+OBc/WZ6cDUxhwgxT/Kv1kCf706chX2Jfp6aAhymLoO5cnpaHNhWCpt1pUf0GWaOrCytyIGlz1/ba8T6U4eGKx5T3/RFSLuIQ9IuVEwD93FEVPsA5GzyAXohXjLRdKZjAN8C0nm7suA3SI5puZowlva7Za7rowC5aHPk+JszLrVNIMI8pLUhstnG0cdHwQaPLC0qkFhhXvFODb0ex8DJnmw8GylnC+49sJtq1OivX0CNsQKJ0D0prASupMV5xqc1IHR7ObkeE+IViOCCJgwRaD1eyIrZcC5j8HtI6CMDzDN2oiBZOwUzYoS3QQAcmuvrDh6dwbFmqtEqlWZ9jgQqGu5SwluQawhStMddRUfINnaiqLhseNWuPwfSLdl0ueLesJ2ct5tUjZZitjOAtDjRpCo0d+aDwRbt/LdBnzLEgWItXmE4bqo4l2fKoHp09NmVvTvw+T3FJeKGs751NNEuyILul22ziGrTmGb+X9kvotVji+XNvMf10S5M+jmrYWhAcYuNrY/5JslBtBHf7Z3Ze6x6uWaN2B0S5NBHQE+CzIJ5BkJqUAyDKje18LlMcLLppKi4b/4uklsfYFTf0qcpYnvX2NVTI1ixPu287bWu3NiEVesuXYB8TKIzHIM8ajOsxIbn9BAa5abM41IjoJqKBhXoUafnWBK0GrM2c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcbd8d6-cea0-4fc8-ca8a-08d7f0068a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 08:38:37.0159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXuPE64i50pUIKC4RoHpqkz/py2X0K/FlHn+Yr7GPNeXjv/EcIf+MsY5HKuuSRqiTcYaFSXTmylFfKt+ovhZDMdk0mm/zFVBWrjWIx6X12Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/05/2020 08:30, Eric Biggers wrote:=0A=
> btrfs also has an inode flag BTRFS_INODE_NODATASUM, which looks scary as =
it=0A=
> results in the file being unauthenticated.  Presumably the authentication=
 of the=0A=
> filesystem metadata is supposed to prevent this flag from being malicious=
ly=0A=
> cleared?  It might be a good idea to forbid this flag if the filesystem i=
s using=0A=
> the authentication feature.=0A=
=0A=
Yes indeed, authentication and nodatasum must be mutually exclusive.=0A=
=0A=
Thanks for spotting.=0A=
