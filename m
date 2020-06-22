Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41B20326A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 10:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgFVIsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 04:48:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:55364 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFVIsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592815710; x=1624351710;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=T9v7eyd3dMGRfJMFzXtRUDAM6UgOjwQBI+1TxpmFlIc2SPuvJR24TKTk
   e/one1r1m0SYPCyVxfDCpmEFg6MKhBvnmyI97uOAMbdfzuw6sOKKuT/Sb
   FvC9dpNWT+C42aVWWXSWR39cTR2I50YOhUMYU9bF30lVCI9rEI+HEJDC0
   r2y75beocpZxqJ0vENUMMXxw1gf8mO90t9GR0EGza/jY53ez94uNghlUX
   l3IVEjgTsB9irctXkcnRlv+5tMUDQ26uS3zB6Gs9JzAHADecnHLuf0O2Y
   suVnWKw9UyXi4ehiwGAnyZ+JlwKMZ5WbgnUK6x/h6fEhBtlaMxlJpP/P0
   Q==;
IronPort-SDR: QC8QhPu0yYxW112j9/fXRI78NMalzKXGFzbTG9o776XBzuKaiq3ZgBO0l/FwoLMAS2QG2aDgmQ
 YGtvoNIrJwi2OgkiBjoQhUXP7mrNBl+UtHB2oz8cTFIkWsosqgn2RLAEHKQF4Ea3JfHayDCWnB
 /riuTt6dmH1Pn3+8+xArwnXL89Ievzc/W8iatmxbJ22m+cAKoC504X50jfiRh78Tc52vUS286i
 Ik1E+zvJJbMSYx3KuVYg4xpwyGLQxM5B+qlPadDJVU9S+nu04fUndptRMXyS0udONbaf90ZdG6
 avc=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="141967735"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 16:48:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grdYkAuzwHNdpJ8Aeb9YZvLniI2nKSIXYWbqV5XTcQBKM0fd/rH0O3F3O/nqZI3cBCQFqhYHNnf5iSiG6VTR8tZZTlffE3YQ1aqwjyjT3uS00kACIZprqGl72DT+6knNn8H9xhFJNZt4CU3VcIy9ALN2Sk4hX35jibpP18sfvUafHFQ4SIlI/aeSj3/IDg0fJQAGn2zMtgHmJbOvQC7Vjf4fT6imWHts00YWWQldmtVCQadmx2OnSjzyfGkBnKKDsADwDRg6LpYC2bBXIgWXZBb9kFmdsehWlz2d9x5TLsuC4w6KdU5unOJLyYBueHyHgoE8Cu+3N/ApbYQPbKbU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Nu9zBMm5o7Vw/x5s7r+XOL3Trj68VJqPiZtLP/Pv2/S0FN7flHVXVTt7eBl46qpw1AONumLTczNhzOAV1mPymsj7Ah+YN2yL73Zfhd6M3LXXhbUDv0ML1jdAX8cQM5pGHbKgzUDWidv0URaC7LQspum9jJoXXHGEDnDa91v7PyTgCKOcMxCZSM+Cps/YB1upscyYvXkaf/lTuw1/PcLZeMbTZsKC1LYJxx8ZSWYNVTJjHlYlM1UTmfA1Lx84XYOPucJCvoE7o5x53rH17Fjk4a5bA97Kbd56xMylSXV2QgtAv7wDqBdVhME2koF+RVZEG9nC4KRskGiyyyNaaKkTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=pvWRUjgNkiAHzONJQmR+5WFW8AZ2lNEoHmAEhMYOACJ1JH8qU/LqYzegnitOgLFaBAnMHFR8E0dfMISFMG6DbBjKrMJvrT+XfZ3jaWhxAWIM/JiBOQOUPY1HaSzUt9GaC+OuP0fibO5sgGuH/bZAltlRaMD6nX5jrju37OKUX04=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5117.namprd04.prod.outlook.com
 (2603:10b6:805:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 08:48:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 08:48:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] tty/sysrq: emergency_thaw_all does not depend on
 CONFIG_BLOCK
Thread-Topic: [PATCH 01/10] tty/sysrq: emergency_thaw_all does not depend on
 CONFIG_BLOCK
Thread-Index: AQHWRtLphugdjNLhv0apVJxBOmyRIw==
Date:   Mon, 22 Jun 2020 08:48:27 +0000
Message-ID: <SN4PR0401MB3598E7924C3F8B9BFC308EC89B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d042d5c-1ace-4c6c-a342-08d816890840
x-ms-traffictypediagnostic: SN6PR04MB5117:
x-microsoft-antispam-prvs: <SN6PR04MB5117DD8537A53CD9136919739B970@SN6PR04MB5117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tx240AA/fVMH5RJpTYLwGLGr6ksBjovkVx9cMZVHpvcMZjdXjPxIuUDaCrRLXq/Uz803Ep4sSYhvdz6G0txNBa7td8oBpucvZH/SerJ7j//nu5lqF2abvj7K0rt/R6srwDOa1svAhQNxUXfadkcxGQ/FUvV9JjHnE0Q5o4yBkUEXk9y/ZT2zxxwZhMqAPqYc8+tMf7sBowoy6qpmnQBUDckTZUw/uP6i0a3SE2h10LUyGSmJ4zko9KaoiFEcD6DBpZScTYoy92O+xK/w+H5fDMxFYIuD5Ts9ZizssgawvoEhzwI8RawWZ3/zIkhU5NThoQtA5bdd5mZqshH0QNYarA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(478600001)(5660300002)(52536014)(76116006)(8676002)(91956017)(54906003)(66446008)(66946007)(8936002)(110136005)(19618925003)(4270600006)(316002)(66556008)(64756008)(66476007)(558084003)(9686003)(4326008)(33656002)(86362001)(186003)(6506007)(55016002)(2906002)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UOHRoKh9hbTP+1fwhGOT1ENPYQBUKB9e387M7uxvnhcZEimzyqwMSmnMfMaEeqTnMZKdDf9giJ0+OsEpcSp2pUAx9uvx7RbadrFa1coXBY714mtuRE5OSA0d78GnvbfveiVDp8S6tbMMHE0u8bHdD4SAxx5pITUMAlIGF7bdxwgXWrFto1qehvZCNAhH0i20vITAwPB6DYGiNVxXTd+rZfocXrj86WH2h669YmBEdYCM9JRd1Iq3FwYsxHs+cyo2D4Acs2XpbJpr6vVwDLmZr2vcJAtNyM5Pggp2syb8ygYZnIpqf5IwqkpBTu419DhmbUp0C2Kjd9cAzzkcB8eGaHXnkvNDoZvm1aLv7sIrs5nn9Rnf2SRJozyuIn4Zu7tCs2UHMnKiJ6qlcas8EXFwK6w8ItiuEGMN0Mlk9QIQgA2YLHd276t3fwbBCX+M93K1dRrLqZRhBRxdVIorj4uEqAoJQM3wIcsOuw+7eiKpYFIcOcFAUH5KlF59O2Ca2UW2Sk7F4PyQaOW+ffs+6rePVPGZ3Dj4rAf5qWtdHeis/3hdFHq9KSGAON0rRnK7iqPk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d042d5c-1ace-4c6c-a342-08d816890840
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 08:48:27.6292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZVuU19LJnpUy0wfhbZPS2solwhXXGNkTRNcjUjAmInmqv1LzhIiSbO/OceLzZCoYLLjG6V7E2o+nV3GPNEGOCWde5WfNHU+UJ8wbWH3on0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
