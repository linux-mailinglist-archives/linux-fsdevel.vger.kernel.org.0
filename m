Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F057F2B8DB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 09:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKSIis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 03:38:48 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27373 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKSIir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605775638; x=1637311638;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ccj1224leVO7HC/33WyQz1b4xb/a6KWB5ZbpgE7RgCHS/GyO+N8EhgMd
   YkC8upFlXbpIcy3zC0z6quMS5v8GrvlrREMWTjA9L14DXs/+8HhXwpJVN
   TJzTudo3i7swbDkW54/MeGkddd8Efnn/BTElSmd52iPRrcRlyMJA/9fre
   Fo/oLu+I78pONkGLytcRr31adcynsuuRaUL2dpn0TvlHISKeJMi259K3E
   vzhKIf6jVluHtIIUMgoMSv0FyP5eHAVGf88S8ifWdPX9rsojPBCOACmFF
   EpRs/eV5QwLnAoxGlrd6oP14aKy9RIE0TXHIOLK0m5oueQQEOhh25Zvef
   g==;
IronPort-SDR: vAoAVeJm1/5MEtcMU/kFHtNBbrm5JShpR7BiZqP78Dha/TKDLv3ZCyYmdM+YVahaE7+p4jGq6D
 irSWb7OFiFT0ng9oh8j5mY4+80e3SIWSdTjOOvxPHG9dU8+bqaFoNAU7P8QoNyetXzhr3mdsKa
 SbHZIrsBDMNPmMKym3v9RujfhSvVjfv+oBT9BOmxe2QJgx7aS1OAsySwZ/QxLrFDCdkKoBdYdl
 i03cjz70h+etnh0VznvYAmwNo+yAj+susaHipAF3iyZu6pUiZ8MjAAqTLx3QJn9V03RUCZLns5
 /Oo=
X-IronPort-AV: E=Sophos;i="5.77,490,1596470400"; 
   d="scan'208";a="256563234"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 16:47:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTJNDjrOkjKEEtltr7Lp28AY44glVJvAntj68LzZ5QtfRJO0CTLu3ccAuX7W9p/dU+zB/8jQaBnjDCqLs3QEN3fvQ+WrINlkaZnGRYqrpOXCxillx8Xt0jh9KLG7YTGT3o9euhxaMe/89QU0pogtqD7HY61EPOoBvzkOheX+ogx/zRv+h3IxZtVS4AJhrFog8SZ2n4IbiB0EnSfKhzyyAWWT6Te5Lti7COYze1WgEQvBKvHqr8mb9ou0B2pdAkGHEmiOCbAMukicxR7l2y3ct92z8iKmN+CZ0XNY8L5N1QWmeYfDBM/w8aZ+YMW3eWvdEm7ZkCHU4M0RXKzz6Fgzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Rp0DYDQGL3aFvz3RrQmZfTVeyGU1Rhpt7+b4iT1/90mzpc9nFVGhPt8ZJdfyVjhdgCTeZ9wubcid0xPEfoMx/9DAGGzmLKOR6w+aI/GRVoJLDjcSf4IwlIrmWGlf4JP/YOE97Bi3xKQ6VbgernV98aWDs68IfYngGdPcmG1aSMmEep+p5O3wfEpUomvGuPipyJ+9+vOTaFi2KJ0+aG95DcT+zwnxEhBOzPYXs2fHQkot0miX6Je1e9zNx6EvkjeIxtx3D0NPh5rbcP70YEslMrqXsg9FXZ04eaabLDe4wMVcdPO4u53gNAWrT8zs9DxDWbCD4WZeeseAYcYK2QXyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WtU+DNkWcHHq9v+7vltlYxPAS3rs0uIjWexfEJj+xL69WFw+sQhns2/N3GWO7gySVSfBpEWOxdD1+E7Xv1u0LIDRg+MgDTplJstokIA9gPmHAIGY8QOmAVyPspI6oiBRFg9dRFtL3FXcn9sHHJL0NTsyerr3OHdquakuYrrqYZg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 08:38:43 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Thu, 19 Nov 2020
 08:38:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 09/20] init: cleanup match_dev_by_uuid and
 match_dev_by_label
Thread-Topic: [PATCH 09/20] init: cleanup match_dev_by_uuid and
 match_dev_by_label
Thread-Index: AQHWvYhocOE/KFj+qU6m8HXUxgOagg==
Date:   Thu, 19 Nov 2020 08:38:43 +0000
Message-ID: <SN4PR0401MB3598D6B584FD73A97E3681AE9BE00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:851e:5636:4e29:3e2e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d44d37f7-3e46-48b6-5716-08d88c668629
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-microsoft-antispam-prvs: <SN6PR04MB4862D36B009D3979BBCC93EC9BE00@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vhLfugirm/LBJVDQVEhG83CPym6FDM00kZxCXB0hqndJRE48vo97PGXQ0wPUx9XAR9SJuLVJkqdGd3lL8YCK8RsFy5SnF83vRnxC/BPusxZAymKlBel38EcuEHJd6QjR4Kz31sEMe8qcVSd+0pGApw2l9m3HbURdau7tZ5I+8kmOr7uz6LrzBSsU32UcSnrjD8NPYG4r3AjYWMwzhhnF9CWFdXCDOa75pHsYFCwWhQEiEghykYxLd31FfmTFusr5YAVD1qlZC+QwYG5Jzk/vfrdT6lyEsy02HCuPQIF0NisRD3YdoFcIqgD52iCiY6dIBwy7cq8NPlBxGYslflnbMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(8936002)(71200400001)(19618925003)(4326008)(33656002)(7416002)(9686003)(55016002)(66946007)(76116006)(478600001)(66476007)(66446008)(64756008)(86362001)(54906003)(66556008)(91956017)(52536014)(558084003)(2906002)(186003)(8676002)(4270600006)(7696005)(316002)(6506007)(110136005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 88nmOM5+EWcTP4MQ2A3An3tXN9wV0en98gGW/l7Mp26Nsg1CXZRXzntWhvD3UXdE2DUij2u+4u4xFcuRndUlxAcOr35K9aUPDmlpPNQa7Za++EWjmdrRWHK2XrtEDCBpLQ8L6IkVMFT0AMwdYTEZr9A5gDSg8RUWyranfcCvVniTCysKqWaaHxJQRK96f4bI47cNE5YSp8IRdG/MULgFkl3KmRpfZ8Xvixx+/KHvI5xqfppbc4Pntr+1RfwPW2m+xfgowibFPyX1IZcq5keRVL0Hz7kE/WYlLs4qSUhy8ftZSG8weuwSfm1XO6Biyn42XDb0QFRJOe0dMlqMQXHZUIQzFgRE4SzU2b4s1dgk+XZVZN6RryjfGOY7IcoNjR3ixggU6a4UEoMsoUyqh1dau7WWKWe0LiCziU3FfcvHXbI5U4hz2DSW751XQLOstKdXGhXGIVccGAL5wkmHvgBJ7PHjk0ucQ5ldk7kR2+HgOiVgffBl5cvXm2pHFHMINAtpOjP/Lj2oVE9To6fFpcn4F5xfNU1Bcy7VOiNoYphQXJOmzNc8qwkCRXYCmwZCUNG9WmuTMP2O+yDKDPtQ1r86gNh2p/1ADkfFWZJAS4BUFZqZL5gmi8uCA9K+hA4AHLCPQ/ieJtv35QDTih9HjWJ6uMm6CONTCswAkdnbbRo2SRl17wCd65388Ojf3tAmnrBHZ517A38ZiACklU367LG6iQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44d37f7-3e46-48b6-5716-08d88c668629
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 08:38:43.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lLmbh3EUsXFC6D744TZ/ixltcXZZdJdq/76z3I//Re4QhH9XcIZeGLJayetrzTUbYsWZPdAf1w6xEJPAXVxQz9sQiR9y892Xuadh57IlW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
