Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12D72033C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgFVJm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:42:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7681 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgFVJmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592818998; x=1624354998;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RieI8deHi707fPsUXcK6S6S8d7ougmTcM/fmGb80O+Q=;
  b=JYDbyZSD9lMg7Qv6QRxwo9SJIR5pogdtEC5+FW3HDHgUd7juraR3VpZL
   2bV/HbHQ1tg+cUbp8tUjK9X3nPbFeXMg/X9lkmIcu57uUag5uXhZ1Ga7S
   Xg0Mx9BsxYvTmEOIs+OyhPWcpZDCTwa8rI1qSXm3Qh1H++evb09qEL6Ko
   5pN23uWo2s0F/MNyuduQA9fe3enh05RygxlnMT2PFhVkgmacE0CpAFaGB
   YQsEScgCne2JcfNfuk1sIHVUoMTIBXPJlm6deo1Gsom3WAbmRG0yIcd3i
   Di30JpnZakrUrH/BTy+nKmVwS+1A5HdjJxRLkwM9QXDuGX+KO/a0Pm3vI
   Q==;
IronPort-SDR: RTf3jwyxSaCdTeXxkgtKkT2bvnT3a5YfL8bprs+mJxDGQqYbkVAmeSLkCHR5NxI0GHorsxWrmh
 ah6pbOlKETde/LV5/vL0W/WJPbZh30SUvH7YXyCtqB9khjJa3wMmTj3SP32zIzaihnpd4MCeg4
 6rRq4BJZkkaVTySI5IXKYMaiPTDxzvfvI1GVpIJFnE9tjeFobxuKB3hC748UlH91lgIwtxDdiM
 gRt8H6ayCmj3UHDBuj+Ivq138ldulj9MAOoTcuztYK/O82w/TnPbQW7bdqnhRLRDRAYI0bJjy8
 7bM=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="243584462"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 17:43:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgkC1Ce8AizFvZGSAwd+imBD7jbCgNHtaz4/TWoHwCalQSVDG3324fCt04t1LRoZH94qrfhO9LMUJIjFyUyZ0KZFFjCczdD9uIEZ5yuYSoG17tGd8bP/XaBVdaJRgyXO+D6t+oGKSEuP5OTdGImkrKZP3BCpZqZXXgoJbKTpELRsilgreZjDnzLSo4Q3Vl8eQ0L6cX8xDtvCn/K1cqfZLUguGxlVAH2CR1seM/7PvKDdfiLKH16b5rI6mpJ1AA+zYz9g6SUFhwEcmMfoB0oiDXmwIQuevIuTjKdVSJT6x4yycligDPvuonETErr6dQ7im8mVCFgyMtOVli3jYNF93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RieI8deHi707fPsUXcK6S6S8d7ougmTcM/fmGb80O+Q=;
 b=mgFL9KS/XeSH8hvsLVlDwr+yILHpPDwag3TKw6StbvplJEyk35PfEWkrb6VchMgfAZdjFLcGRO983/ZiJRMypi8gQ0IlBcfto5H+32FMnJ3VQVfd81wDEwi7lz8mI1ZsbNIvlL/3+UgHKuxNkgKUOvqe8wqGDXHmFCjH4k2/oPn9tqkp9qw/SYO+N1YD++58L5tAVEDWOErKk06R9jJQQcJqNwHd57rT5x5UOZT7IqVsP5WsJlBxuF1xhiYpHbFV9KD9uW564sWzReHjNSExwGozdLAQoEYXAjTW96nciep3ECA1n+2DR8Ffvnua5FVJh0+WKcwipJYJX90SoNdtxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RieI8deHi707fPsUXcK6S6S8d7ougmTcM/fmGb80O+Q=;
 b=R9o8jbbFoj7zAr4QmY2HRJghRu0dnf9JY2QA8eXXzWJjNrEZgqWbEZCDvozKIVltbwzqBQ66HpUcbR5flIpIAFFivh2/K1Eg+Bz5GCSn479N503zVxzwHqT+ioFtRktjQdiGF2mlII6RWaeij/wpkuySzUyuj/CPsThtOzm9Uv0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3678.namprd04.prod.outlook.com
 (2603:10b6:803:47::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 09:42:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 09:42:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] block: move struct block_device to blk_types.h
Thread-Topic: [PATCH 10/10] block: move struct block_device to blk_types.h
Thread-Index: AQHWRtLb17aMVeh+okuBhSvh09nNrQ==
Date:   Mon, 22 Jun 2020 09:42:53 +0000
Message-ID: <SN4PR0401MB3598EB4A1577B5253D8147439B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e7cf5dc-7d72-4a93-19bf-08d81690a295
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB36787E838D876AB717ADBCE89B970@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VRA/HCtQG2/7jom4lhxm6UU85ZAO0AYP9oCIfnhxcgXAiv8dhV7+rZGadznvtJXYxVBtSu3pQuxBLPeNk9WIQPDMVeaVWupTtPr5b7h7SvzNeF8gPB5ZXhfi5WTJm7h2L02DGyUa7UJTOdbqULNlIMMwoKEP/TzX4/TcS1VtC7tnKg92N2JyehGQfpA726Dfxg1VAdULvaU2OsT6pZioLrgFJRe2hvgjvLl3+CDUBZBiLP9Kt7HP3A9jF30z22GoKoZq5gLruhaf2G4rmRprxpEM8mj6LL0a+wYqNY7z9V4TAWphAfVUSLun0upQrNeA/7Q023mL6ierjmikSIbp0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(5660300002)(52536014)(8676002)(91956017)(66446008)(110136005)(54906003)(66946007)(76116006)(8936002)(316002)(66476007)(66556008)(64756008)(558084003)(4326008)(9686003)(86362001)(186003)(478600001)(33656002)(83380400001)(6506007)(7696005)(55016002)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MJFXab3iUYfTBvt2XU/QJ/xvUVovrsg5gHfyAqJUS85kegc9fPuxJ2POhie6IcElCApGGzqSKlLdfmiCqnO0YOnWz+AYEPV2rxg3J0ZRKgULMFoUE2rHxQA3zZbHklf57+Ep0mLlEnCe9o3uj5ohzfC6JtH37eli5EbTw2mIzQ4TFN2iSMfmEslLpFs5jGUp4SE3AAeeWCDl4MBQxx0fM2K91cSnMep1Dy5lOrpZAUEvAYZVXp6x4r+oyTS8ocT76+0hrYNbRrqrwcwuey2SyoZxB4M5+SKRsgsS/CN0JAiPkZcXBfCQintER3ikD3FTOhfdlya5aXGoCn6Q3Sgy1SnvvOfibHB4hh5ghCnvs2se92asEQUTmyexY/cpSeGr6QAQNxTM4BmBSPJ+8YKlBYvr9HF+KMN9ukO1tmT56/iw+ygbrWKhUYq/X2d1yu9v7kPtP+XKAYtcygGvyqmeIKY8/KoxlUWjJfrjYfW7QLZ+hplkZ1nnu3PIePnVLL49kM0eEqI/1eUldREbHH8ZaAJkzFC/OxdTAzDwQuQdWFV+f5FoEPH3B9t2DhqsmsHm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7cf5dc-7d72-4a93-19bf-08d81690a295
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 09:42:53.0080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jki7XCsl5BJ6VgCwvMvG9xqgw/8mQkJdxo14lPMrqaLyadY4pnrhqvHUBOl3H9cZQh3CCw5J93AJLlpG4uQa/42FN/kcO3cT3DknvvmBP20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that I finally remebered where struct block_device lives...=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
