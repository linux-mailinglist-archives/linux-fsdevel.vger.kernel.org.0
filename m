Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF5C6398E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfGIQkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 12:40:14 -0400
Received: from mail-eopbgr720120.outbound.protection.outlook.com ([40.107.72.120]:35776
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfGIQkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:40:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acKShBbhxk0J5CGZDYxuRts+54UtF5ttCC2yVXYOJW+ZMD2G7dGELlgR/WpQ0X+xtzzX1RgaQQbirRvFY2dAyptNA+WJP+1KmtygHtUFeWt57Bmmvtv/z7+YBg3HMcW//nQAqZdZRtwpXWs7lXXwASN6cf7GbAVYr5xy/F9PE9hpAxKCUIbBeq5qx6zYer4nmGcYHP/RJrMRrYWpaumICeRflc1pefXI6K+tLXDqgB9601cAAPTKmz/5D73rTNG2tdzJa55mqReIN122PLztGzQ69fgsV08rNhGwwhtbjygLCc/c3gdjFBX0ApMAsE/p67ZFJIEP5uxkDv0rq0YFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZz5U4EYZGIEsslrLZ50Alrf3+pxAojYiMuhvEQpAHM=;
 b=APaYc5ltvVNx4RRKdWIKmWL4RQ6T88kAUiCOyPUypGpo96D/mkX9TLlGQBZxcDmgfL64e9WoYITj3zT73D8ts/pdbGjslCt39czovgSA12UtDuL2eQqCWCIc8nfSa5+OYJYlWIYO+AmF7kDbo5QmMscCmLcqh1g3RNm4bZsRmT2igRX4qtUGfNtIgXGzf5VqUChQXcNdNAd5MtRR/d03Zz9r4E/uPnsFpZGwk9nyob7fR18D5Osw+dGkHQd1W5XuqQjbSibaucLvVgIeWNfqTOjdNcihNrM8DIFBHVQIHxz4v5ftlK66schTid/YBKa9aKthHOFtAlJRsttBxWEkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZz5U4EYZGIEsslrLZ50Alrf3+pxAojYiMuhvEQpAHM=;
 b=LTsuo5odeN9C6bVkznvUdyWTO6L6nQ6AAxvCgr633THGipNgdSpOYws9C2uRAsnVV/3LwBwloA2LmTGT+RQ2Vx3W3ByZsTOA2WP39N3ZfQZwQjkXiedglph0Wx38zLcaPqhhgi8fmXnB9wh5SCygq9jlhsBMtIgILbhNvaOQ4sU=
Received: from SN6PR2101MB1072.namprd21.prod.outlook.com (52.132.115.21) by
 SN6PR2101MB1039.namprd21.prod.outlook.com (52.132.115.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Tue, 9 Jul 2019 16:39:31 +0000
Received: from SN6PR2101MB1072.namprd21.prod.outlook.com
 ([fe80::f9cc:1b2a:1b20:808b]) by SN6PR2101MB1072.namprd21.prod.outlook.com
 ([fe80::f9cc:1b2a:1b20:808b%8]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 16:39:31 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        =?windows-1257?Q?Valdis_Kl=E7tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
CC:     Sasha Levin <sashal@kernel.org>
Subject: RE: exfat filesystem
Thread-Topic: exfat filesystem
Thread-Index: AQHVNm3O4cwoiVd1wUyFaPLSrlI8N6bCfKmw
Date:   Tue, 9 Jul 2019 16:39:31 +0000
Message-ID: <SN6PR2101MB10726033399AEA1D0BD22067A0F10@SN6PR2101MB1072.namprd21.prod.outlook.com>
References: <21080.1562632662@turing-police> <20190709045020.GB23646@mit.edu>
 <20190709112136.GI32320@bombadil.infradead.org>
 <20190709153039.GA3200@mit.edu>
 <20190709154834.GJ32320@bombadil.infradead.org>
In-Reply-To: <20190709154834.GJ32320@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kys@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-09T16:39:29.1424552Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1d36c8d-2089-45f6-8656-02491b3ad9c5;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-originating-ip: [131.107.147.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8cffe00-255e-4b2d-3a6a-08d7048c0490
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1039;
x-ms-traffictypediagnostic: SN6PR2101MB1039:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR2101MB10396D77BF582592C9C20A9FA0F10@SN6PR2101MB1039.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(13464003)(66556008)(64756008)(66476007)(6436002)(966005)(73956011)(110136005)(8936002)(10090500001)(5660300002)(66946007)(229853002)(3480700005)(6306002)(55016002)(66446008)(4326008)(9686003)(33656002)(305945005)(25786009)(446003)(76116006)(11346002)(76176011)(476003)(8676002)(316002)(68736007)(81156014)(81166006)(7696005)(2201001)(71200400001)(22452003)(71190400001)(7736002)(99286004)(2501003)(186003)(66574012)(52536014)(86362001)(2906002)(2171002)(26005)(6246003)(6506007)(53546011)(478600001)(8990500004)(74316002)(7116003)(6116002)(66066001)(53936002)(10290500003)(102836004)(486006)(256004)(14454004)(221733001)(3846002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1039;H:SN6PR2101MB1072.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kGwTgC4VWgywyfifpQ1uwFyFk3Yolegvns+xQNinZ+t2gaJd0/HIVAcearqCLX28wpUm+yAZMckyUwVgILo2NQ+J/6GfVRGoYEYDDNvLwgQtiGxQig12Q5vsFSxIYBlOfbZFUH9pEF7V3AST3tjDo200keXJqw55ZiZTCK5QmmHz1y95pFZtgsP25Ol9s94+7B50Omt2t91bL4c12JnQW2xSbpsB8+pSppTgbw7P9q8W4Tg8rGtlI3BS8uaBAvAr8hPguLwQ9BILEVIL46cEZnLclt0ANs7vKEQuS8bgiTOuCJSLn11oiTVmmk7KyYAyIEMy7k8gPV5R3GLhWc8ASFLkLTUbSimLfhytX1PtzmKmJSMSs9qxYKG2d8VzdbskCwK4UVl8zEy6mt298r85qAltLndvcNdd9MkeFnbMSXU=
Content-Type: text/plain; charset="windows-1257"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cffe00-255e-4b2d-3a6a-08d7048c0490
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 16:39:31.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kys@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1039
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



-----Original Message-----
From: Matthew Wilcox <willy@infradead.org>=20
Sent: Tuesday, July 9, 2019 8:49 AM
To: Theodore Ts'o <tytso@mit.edu>; Valdis Kl=E7tnieks <valdis.kletnieks@vt.=
edu>; Alexander Viro <viro@zeniv.linux.org.uk>; Greg Kroah-Hartman <gregkh@=
linuxfoundation.org>; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kern=
el.org; devel@driverdev.osuosl.org; KY Srinivasan <kys@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Subject: exfat filesystem

On Tue, Jul 09, 2019 at 11:30:39AM -0400, Theodore Ts'o wrote:
> On Tue, Jul 09, 2019 at 04:21:36AM -0700, Matthew Wilcox wrote:
> > How does
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> > w.zdnet.com%2Farticle%2Fmicrosoft-open-sources-its-entire-patent-por
> > tfolio%2F&amp;data=3D02%7C01%7Ckys%40microsoft.com%7Cd73183ff28c94bbbf
> > 6dd08d70484f009%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6369828
> > 41322780798&amp;sdata=3DTCSgqe0h4FYaA5BBGVJl98WFBqbEHSo8B0FhlfTYVVA%3D
> > &amp;reserved=3D0
> > change your personal opinion?
>=20
> According to SFC's legal analysis, Microsoft joining the OIN doesn't=20
> mean that the eXFAT patents are covered, unless *Microsoft*=20
> contributes the code to the Linux usptream kernel.  That's because the=20
> OIN is governed by the Linux System Definition, and until MS=20
> contributes code which covered by the exFAT patents, it doesn't count.
>=20
> For more details:
>=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsfco
> nservancy.org%2Fblog%2F2018%2Foct%2F10%2Fmicrosoft-oin-exfat%2F&amp;da
> ta=3D02%7C01%7Ckys%40microsoft.com%7Cd73183ff28c94bbbf6dd08d70484f009%7C
> 72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636982841322780798&amp;sdat
> a=3Dy%2BhZFhjIXUrFVn5%2FN%2BRVxRQWzYs2QI5V1jM8SDPN2dg%3D&amp;reserved=3D0
>=20
> (This is not legal advice, and I am not a lawyer.)

>Interesting analysis.  It seems to me that the correct forms would be obse=
rved if someone suitably senior at Microsoft accepted the work from >Valdis=
 and submitted it with their sign-off.  KY, how about it?

Matthew,

Let me dig up the details here.

K. Y
