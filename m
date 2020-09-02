Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F71C25A680
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIBHXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 03:23:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24211 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599031419; x=1630567419;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=nfW+3cTNWUVE8cN3Te21d31lGMuOSidmtE5L6onJ7eWk+YoPZmsczkZo
   JHQ8OiRodHiwTjfFt00VMXeWGBQoZ/VIW/4fuWJbfhpd77EsFmsFburBI
   dY7kWQplHdRLerDCnCHHt0fcK7MxeZNyw5q9pRY/gh0h1LsUzSyj/6fVg
   NGmKirmf7U/LClUyGo3FBxGX5fWqn3g4App25sEm/QwS2x0Nvzg1T1sJw
   f4V89SXA9muDiuCSU1O3Ye9UuPNwq4S7UusKNqRVlT5YDYMI0O+wHfJLK
   X4SXPA+mL9jvL4wcHB7bXJO6zGsOeRikLEa8o4MbTMuuJOrCsbFfTtOqD
   Q==;
IronPort-SDR: Cwx4g1CTg2IeQchW+p8iZspbzLam5Ls2gDQoq+b33eWNErJBjSVJv+pYAz+JVNykTvC4gg5wcW
 QMS8zVPI6HP+C6s49YTpnAeWdnSD3/eM/AUFmdAmXCEP8lqmbYW2H5ckgX/hSYPiXyEWsaFviG
 +bjCbx2dYdpZpjZ3ms2pzKHY+0Y6fYm2lQ9No8N6ZNIKKOdFxiML0t4jBlGOuRXk08yQhK7K26
 FufD9jW2kiXPk7/DvrzWg/3vXKD4brLSHNXXEww+BDURGs2u1SMo4LqBfBH2fulBI3qesyLps6
 OYI=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="255918296"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:23:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP9Dj6N1mezn8GxU5tZXXlVOuCgyr9hly/haLsQQK20DiTRTgJMfg/fVo9k8KKtyixL0aQr84CBTjrgNWgMpI9NE0hYA7odP/DF4DyPnXC07krPD6RQ49OMLGfBcWBWpAM6Z4cMaeZAbRfCCQHP/ieVyYRKqP0qdYtNkIgSj2ts1oYZyZXglB2NVkD2JjAbnhpdjezuZPQoGTbeq4l3mHz1g2ODhu8awQbzx+E0hAZiNpY/vmNJsmc97Kvznncg0YrmMrwuZY44SrimMd9DixwKCU455EqrjqVl4lQ/6DB0BuqlWdeWlZZLpfikIewZYairZGId6yIMNrpJbY06K1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EgAigTXxKK/fbRVRc7J4yhM4WCkGA6P4EtAnm45UZh7AvqeltUBF/Ios5+8DPgJEaUB9F0Rpo7es/uLmlfmay15QVvoaa0oU/CkMprsufX3esF5PxmHz1Jjh1QMJOU2VlwzhTKq4iwnQuvAXf8E8EctzMQvnZHqQuLVw0uj3C3EUhOcuxVL0HDalplLy6Q3R9P6HZWHgk06JSPmOfVMt0gFNIJJcknUVviZc17j83uyfzw5kaMin0lPDCAVVFWtE0lY20yelk2bVYjCnq6Kodeb9iQ8SXyl/CSG6YFFFlCbkLiQgYVjaup/iLn1JGaqMrYPNWJzPwsdH7jhTfMYpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=a0CG+qyTlkm0v+lBfyXExhpdfnZqklTax2Mv3n9nuWgmrhW8junaq4o8iPgcy43RZnYFXa2JPvs1ZwEQaHTkSochv71oOLj4Fw6Sy0D1gTrzvj9GBpyB5nVcOJ59Q8NQQj89QjqaZ1U9As1ZqkISd4IKXiwycYWpqsHiPZMXksk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 07:23:36 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:23:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/9] block: use revalidate_disk_size in
 set_capacity_revalidate_and_notify
Thread-Topic: [PATCH 5/9] block: use revalidate_disk_size in
 set_capacity_revalidate_and_notify
Thread-Index: AQHWgHjE05l6FVr+70GNhORFziJQhA==
Date:   Wed, 2 Sep 2020 07:23:36 +0000
Message-ID: <SN4PR0401MB35987F80C36AB409503DC0059B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6de1b2e0-f78c-452f-b4a5-08d84f111b69
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB39668F869286235937E9DE549B2F0@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lu4rznRnSXAWn/mRhvJdRylBVYy9k6gJLexdA2XG7czJBvRnncbiLSge2QR7Iw8nMyTzDthReYZBSyOiLKqK3CBLqn+YeUxZVg0UGM4pKJ/sKj9UQbwdYKajzH0fuYIet3fQRgP9CqqRonpkHi64nDnQGHdH+AQ7Jf8JArva3ApNf2HPLcehsQoy5FsmaJKdzCDQpsClP5m0WbC0sLQsCDOAVJ7s2V2WFiMcflJYSDXzARtU8wbvwO0DQBuCbViaPQK1B0Q8q6kXw+l2drbeahJtTzGPkLPNnnZ9bzBNJTRNSJUYiGk8mJTe3CovNBrQQVNx+n6LHzbiLOKzgBWKxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(55016002)(4270600006)(8676002)(110136005)(54906003)(86362001)(8936002)(186003)(478600001)(2906002)(6506007)(19618925003)(7696005)(52536014)(316002)(558084003)(71200400001)(33656002)(66476007)(7416002)(66946007)(5660300002)(76116006)(9686003)(4326008)(66446008)(91956017)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4+yMaX1z5FtIl8wxSD4U0mvnRUN8c3FW/o+aDrLkW+NY5j4rucRJ9VHZx72B/AVP0x5TanHtAVxI+lJkBsUdfX/EHKg2hyFaVEd9e3MQmsCRuwpXALo5/BvHzJ0ng+OnQ0iHcNkXxNVDfzGhnez0WoDF/NFVhk+hTfoF+eeehY0eZwaWl3awGYM4c6O+k9iQjJ0z+3lDlQJlJiEfP211c5XGdTskHdLzyLNxYeu580OGy2sYfH3ksK1hLXTxk8rbWdGusun3VtrwJBVwkJ6jr/KReNYVkiViQqPHvu/bsGJ6uKTkqab+CHsw//uHuQJcRLL6fBIIutY6TMjy7YB/27DGNNz25mb/O7hDU5zYqgL6fmGjJyIxAoPCPGrKPwSqYFyJxjnO4Iw4pVo05nGnCzP5r3B9c1x97wUtFdUVq8vp6Oo9rmkrJUzLh+rjGtK2rRpuGPUMIcfCFu9SfbJ1v02Vhmwmjjo9eXEFt93ildNGrc5PzmCR4IVGS72sCRem66g3JZpBuMlQfUZLv2okM34Pz313BYpb/DIU9fOKws7WZfpos3tci136D3hjpbq9kOZWONIaop8J4gQIW4MtFdT9XLudZY9NOKH0ck1+SDqALn1Qq74Ele9dBqbupIMBQVRRvBRoMjYprPW5HSDG0kTcIOsnHUsBovWyUip5XnGS1IIniOuaPZ2bADQYr7n8s2ZYv78qpRLxJXSIniNBnQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de1b2e0-f78c-452f-b4a5-08d84f111b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:23:36.4386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1q8Bz+9jP6wkq7Rp1bTVJgrygj3CR45cOjuSlB7UWuFZC8p4T6RoR/BtLuEdd1cqIWUzyStoPvVm/saG9xrLhnutI9A4To9YD5ib2HncMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
