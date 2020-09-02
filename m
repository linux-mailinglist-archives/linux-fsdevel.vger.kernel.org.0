Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6141925AFD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgIBPph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:45:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26414 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgIBPpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061502; x=1630597502;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dqFgKByicwuZK2yvvgaV4HLUnZEArMrEQTPKHAG7U16334qp6J3tgf7y
   M9/6dqx1NWeB+CQzaLIKQ2kjhnmhxpPMAOjLPgr7772xOwaL3MGOw6rtf
   6xwc4ZdJGmYkO8qWHLlZrlgiHOacGaDootJ0mvSe72QN5KhVipLZ6PsbO
   aYytZARIxk3zhA2nFdZuLZHbe5NCNh5htXjV8EwKSGZT8xRucocq949bu
   L0zr87DxOYgbrWqCh0XKo5I7HoHi+zVYMs0UaVvzOh4S/vryfJhK0jvNw
   9EMA8Z0K//zJ4zfVapDCCh/MKnlU85MK9ktWO0UVjlfz908c0+grYC73C
   g==;
IronPort-SDR: aKQDqp6LwlYd9VVgToyuntSjaDpu/xjt9jl3zGGBwsQfFc8vGqwYrZl055JuX7/PDrkgjV/ppB
 HgApYEQAAj2Qn+p8ZWWTDg4GyEaOIKmmvi231ROE5nqDL88qS1FbfDgbX4ZYZsCL6gAN6FZgDm
 w3Znj6dPfnhgpQAuDY7ESwOfSqNfjUtKgyndYq+twdQEnqgX4M/Xi5PSHraIG7+qJyTGSNBR57
 sUPIcktoB//OoFRm8Jd0uQXT615qxZR9xX5a773f5UUsR2byjnqXeggP0z5paJ6V540R/ox9Sy
 qm8=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="255953363"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:44:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsxswkAxtW2jicR5iNvz7tuvLVeGQ6NGCIEZEPqHq5QmZcQW4yZfkYSFs2mVVfuSZIet+yWG7ZHbbZ+pXoOT7Erf1H9cLOY4ahuSjiffSOLWWeJ1cxIVL1Qt/RAoVQ2akVLaz70S0Vqw6+ccaFiyD6VUe3U2Aal9v5haTOSnWI9LklpEXbyDKA3pCyQJdM16PdQM2wdBI/WnTBcdYcxTLIrwbnKDOK36q2y8zNf59tcoZzcwFp7rBw19Ydd9v6grMRfJdtdipGWJLEbluLcrK0nIZa4W6eEJNZ4D/OXgN1iSvQIPAfJ0ww+8gTs57J7iW7ZUjyIhAp/R+ebdh+Kang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CO/h+hrvyZBQ4Neh1Tp35STSPGmAohsO+ALoizmcMGKFiZUpVCv9x5bXTBk2QEJwvD2Tjgj88hqc8SAj5rimS/sE7qOgmgHXPfLRD9eOd6jT8edmD6nVJ1ibRZEdTBOrLzR/C0QBZaV2VgYywlo5QJ5rBflEjOLRFvT9n3d8XfPPomY1r7YOpW5cXmB/npJbxRGjgSAHAUyxBUu7dajKLsinc1MBUuEuBtisCh+gktl11sRviK/mdFF0fY1nMhzr5DJ5LdvCiAzFxcp6YVGG8onDRhi7aI3v3t9FTww0Zxp0NLWTRgnUFDsPgjAnC1JHg3QaRZF5UdCi7yn4DS0xZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IQ9YvJAL1QKJWloGorSfgPJCLOCoOBv/At8AAHqxO1gfvrDo21ZZJeMMVnF98XqMVeTsHrTojVZasjHCPSTbzDa5mxlwOqPuTFa7QvRF9xOwqbkEQv7rzydEXqb4gFbFr3/tdJEcH1m8+YFVvzJXR/t47SuCRnsFHNd2AVLkNUk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 15:44:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:44:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 11/19] gdrom: use bdev_check_media_change
Thread-Topic: [PATCH 11/19] gdrom: use bdev_check_media_change
Thread-Index: AQHWgTNOeedM/+DMc0eDlPBuSQgWrg==
Date:   Wed, 2 Sep 2020 15:44:46 +0000
Message-ID: <SN4PR0401MB3598FE94BA85C20DFB48A8229B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7567157-626e-4959-701d-08d84f571ebd
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB36802A2DA32AA2990255DE369B2F0@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bheRkqXyhGzyrmje6s96OnUUWDeU5bvuYBAZeXohergZwIguk0K+QtZ/hGnu1wmRLmvgcls6QXr7H0bXW1ayvKApc0dbio8HnBkrnK5n3gaFGvyg2JG7RJlYuq+XNnaBgFh7Ozx16GWr0tMvSF7KmrLIkfz0PN1oNFIBzLtI4IEq0J4ecHzi97hzSTOupn+N88LHmAkgd8anYiRrq9U9baxmeI+h+O+rUtqrVWLHt7q6ajXykVzlD9rsoBMTPN/hkqn+0+A8GeFNpJ6495w52A+yOiRAMD2iTOef0vHnWpJQ42KY11wUiBYDHLnYyDroPuBH6eiaqHMrWpeYozzfBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39850400004)(86362001)(558084003)(55016002)(8676002)(19618925003)(9686003)(4270600006)(5660300002)(478600001)(2906002)(8936002)(33656002)(7416002)(186003)(54906003)(316002)(66556008)(66446008)(71200400001)(7696005)(52536014)(4326008)(64756008)(76116006)(66946007)(91956017)(66476007)(6506007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KqYjTWP78wmmXeGu/XX+4rBnUgMb9XeJRpXz+eqRK7xYZESIG6ZHICCn7niBfOjf9BdIucRVJFL4CvXw2TPebvcwHgRlBd3ESTEqhfnO/uFwhUE6oR/SKOEc7RTOp3bv+8fzPfYFKxb0CvLMnB9EEW1RMT5O2MJYlGY5uMiz6QSAmhjLJcpiGbplPOzMVIbbo49/CL3U733ql2MeV+ZrNaMf8msEZXuXi295TNpMBxf6N8n6TW7IdFYxEJaMW7yExc170TdSzlogFuDeUf/lg/yoOQArkzpsc6LhPHzha7m9ItpMObtDjYkSCnPdsmSMOK1AuEKfjPQFcRfeY6YcjBdp8kxliFolCi2ogVardAoiszFtYDZDeLiVhd8fGYF1DdBoFkYFHudlBdOaEg5wWDtsJ7FsCIPz7dlPDzn/Gm3VfnEWMzRD3ebQsfES3/jDVJABq0BL39rWPRhvydWC/2NMBsZ/19v8TfheguszzTPR9JuQ1FFBvc1Yx8pwoxfCfwmzbHc7n3Hgid48P47jpGEsdrUOyJjg9okPh5QIyTOReE/07BQ4OmUcp2W61fp6Bw5S01GvbF+TFrY2SO9ZFqYt95ii1idyoB4HE9S+8pktSZvegXwMVwJdNO9jse854Q5rARamS9QSxXVuz28DTzkTUchPfCdHofaltWoVyB/sfR1samyDJ9e2E36fy6AHhAlDEUoaid/5kXHkTefRvw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7567157-626e-4959-701d-08d84f571ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:44:46.8226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l3UqEjxv7u7ytOYL9RpJXasnuOhmWCBGIJYSbrJvytcMHH8pKPXa0Nt3HgHnsbk79KVMeHAnaQr0RM3PMeQck32SKjSxCh2jv1kWZNmdVm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
