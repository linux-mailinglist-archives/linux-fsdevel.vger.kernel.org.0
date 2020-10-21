Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97064294A49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437452AbgJUJPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 05:15:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49448 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437448AbgJUJPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603271701; x=1634807701;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zwebdYZrn11HCQ9u+BpygYkYNN8TdeiDgzspZ7gAL28=;
  b=YlcUoW/z8BrOrTUvNnNTG36E6pLXR1luqvt/KPxUJp+BSXPog455ukun
   TyvUOvdfV4cOhRGC+BIz3BH+yDEg2N6uyW7BK6BxHRAVhPn71txAoXA5+
   /46LFarRf1G1eYjWsscVFeMZn+N3BgsBFyHUoIC9gwH7N5ULbnReR4KgP
   /Kx9PGOgTi9bPdSJttj/PRSX8BRKPO/m7TFykiMMk8M8c2jOyjlJdKlkJ
   bB9i1X7YqCeGUcHsg0UoQzD9KEDAs9VyZH8C2FOtIIOdxYoC3BBtQxtVb
   FBtJBOpujQ8ZQ/IFEsLsLSLMavd9n6Q2eYdrDhxmjrb4BTZyvrdiQXRcH
   w==;
IronPort-SDR: GBfYxlXX9HIqPVXopqLJYKu5KnST30ySZYGHClQIu86l59nIhniyhWkWQ4KONLok2UKbqPGkMs
 uGXuZphov3PL5sMfiuDxtU9UXJsprnJeMTXNkZTgRGvVxcZ9BA1WUGQ6Rer1+PGE/ip8U30xhe
 MDI7/afFkIqPBBbCoNaX+sfZEgzjEJod7wq88xmHfdSiEj8QqNWErsPQU8zT7CRFnxpZQosUEd
 LXBEmz1Wa6MjOsJBn3/kVd9t6p4xxoZMeZjPXxlRwAPfu5VMyNKRnDbSihM/nsiCaWdFk39Msn
 gZg=
X-IronPort-AV: E=Sophos;i="5.77,400,1596470400"; 
   d="scan'208";a="150588293"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 17:14:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epTczlV0IWrDJtW8eP021eoHSCtzmjj4TXgs+BS/JnT1IZAAdYwlga33UCrSvekufFtJbdh/u5Cch4wBrOihrIZNimbrCssckbSAwzrDeM7d6y1txb2lxNoMnqPQF/vIOV0HWaHIOWk1VBlouo8q1/uv+9Yp/mn3GJswsCGYi3nKsKQXzDFfgkiAdNrZnC45RLx4dFagP+8iCVdXF1Sz5ofDyg5Jtu8OyJtbPvh2SeI54Qr82nQhpTD3xYdNA4dHlN6yPSQ4kE/4OhDToQTkAZXsChSH6kToxJDtbJRlKee5FWxHySCQMhja542fBhs2oApXRg8EuLxd+ox62YRaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtuegUvIuQue9dzELzMpc3s64JoVkp5pqRgzGDDCv+g=;
 b=lFAcKeq9ReVTQKL+A6BE8SLeHkk28vZ5H1m0c6Rh4RHIwPM9NjUTYfYpB0zqz64fIsgbSiLCo+RpaWD30ZwNKL8UG90vvWLgk/lHE6dTqGprZ/nDttWB+9I4nKnhnWXkdQxAffObliafLdRQdDalsOffgms1DYG+J8jBSURWHpSByR6xNmd9YQkZ8riOpWBabDFfXYRQbfTW5WcVkdCNYbPFHSXNHyUVizEE4ijv81/9QkBOOhwJtJjLNZm2nCjzjR6k6W6lsgXULZHEczc7Y6dAUecfeYUD1yr8Csfpoqzvcejls7Sited3hfyC7BzAiwa1lucJEZZ9cjufHFgqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtuegUvIuQue9dzELzMpc3s64JoVkp5pqRgzGDDCv+g=;
 b=cO1uurt/iAnMLMZ+D+HM3aK9Af8ZpNO6f2IemY6lnoanr1DA6pQZurTzC6ZaEbw2CgnBMbq6miKC6T8BFVXHanfeVKwd8QUTajfCDxaBmYDyK3TfXd5Vb9ycokcRjCVofJlmYoscTW+2PGyx27RkCF7iJMEUKSAe4Wku88PqFLQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3885.namprd04.prod.outlook.com
 (2603:10b6:805:48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 09:14:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 09:14:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] Block layer filter - second version
Thread-Topic: [PATCH 1/2] Block layer filter - second version
Thread-Index: AQHWp4k5CXnJGcQARUyusr8QOJA1cg==
Date:   Wed, 21 Oct 2020 09:14:56 +0000
Message-ID: <SN4PR0401MB3598185077055334ADE1BB159B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: veeam.com; dkim=none (message not signed)
 header.d=none;veeam.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9bd8372-86a8-4c8d-686f-08d875a1c6ff
x-ms-traffictypediagnostic: SN6PR04MB3885:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB388596BF151C6FE8954DF3A19B1C0@SN6PR04MB3885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2387oY2YDYa/2zN2N8T6ZDIzxkqP4yzC+NTP4FWDxFiCSNEFEoJpcxSA44PFzuO5xpvCpNInLPIWYvi4PtsuVLNqWuqzONpP0uAGnrg3xFM6H3gK+hTwRipDaEc0OZ4WVnGjNOYwSzgZOkvefnGJ9XYzSTNbVqk4RMtoH6vIOn5CXbC+GQRhBI05icBEDsVZEsLE8iMIZU1pAFW22rHQtGrR/TKa+blJwa7doI+0hu0eLipm1wL4wjANlKS5MyCDWrbcc41Pb4uYbJRdecsxRHN2wDJY3RD5ySFgzR/5M0iUumPB6eqNcYEn6LnRWEk7o/cz1Kv1bdNr7IzsFTmOOCWstrvGzATChR2iu+t376hZXZCh1mhkkw1cBQK8LxF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(66556008)(66946007)(2906002)(53546011)(91956017)(8936002)(478600001)(71200400001)(76116006)(66446008)(64756008)(316002)(110136005)(8676002)(7696005)(186003)(52536014)(4744005)(55016002)(66476007)(7416002)(26005)(6506007)(83380400001)(5660300002)(9686003)(33656002)(86362001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EJmRbXtNHin3RlI9WH5C9MRP3SCaZLVdTIU5yD5IeG517h0o9d8imQbXCzGSj6T2KUJPpB4hHvWomBUvrXq+7pPWICusQ1cDxeoWT51mwZFsx9cE3nAg8Ek42DIROIDbfYBKrQD0g3SRmZ6j8M5U8uNBIdDY09TSAubbANTSmUVc+9m54+yWocDC7bIlt1rciGJcU7tWJuXER7/nkIrmZOhd1WJchq8pXyCE8Dh4cYwHt36KLEmbizLSPLHRb867o6VLIE/xJE21VKzV2bYBK2oSuen6ZZIFxJmQeJdWkUXJSu6rwvLDlAfzhYLrhUEzfJl0D4dfvHN2wdyUytGrKQweHCp1hiV6/TFCzKYRQd/BL3mn0JS325pkLbSfIoK9IEevI4wyjFQS5Afv0vhhdd71fOWwBKr7MFIkSJUoPHuHVXm9BrcnnkF/usglaPc3Pm6x+Tx4zpPdhRUvzXHsdqs9xPEDWy1nFyx0hVmYzllti1u+B9iIXAxbh3Vj6l5sumvQVHagJhP03QsMDP9K9tziHxF0UABmFg8vmWj9OIz13U2arCRmk+siKVwqgZPc0Bf0F0kMDMObDXXukRBTOeMK9vXjxpLcOktQm73gxV3rMsFEibUUcikEc7UlmrnpJl5QJexN/cHRqRZ8tpOibw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bd8372-86a8-4c8d-686f-08d875a1c6ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 09:14:56.0467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAUB5GTtTU80pKVWjQUI7RSr6wiQbgOWY1opyT4q0zKDLNks+XYT7ADrw9tXKbKpEBfF6yBRnVjlxqkUNtwX/tGEys+SSU/Jpbq1XL8dj/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3885
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/10/2020 11:04, Sergei Shtepa wrote:=0A=
> +	help=0A=
> +	  Enabling this lets third-party kernel modules intercept=0A=
> +	  bio requests for any block device. This allows them to implement=0A=
=0A=
The "third-party kernel modules" part sounds a bit worrisome to me. Especia=
lly=0A=
as this functionality is based on EXPORT_SYMBOL()s without the GPL suffix.=
=0A=
=0A=
I read it as a "allow a proprietary module to mess with bios", which is a b=
ig =0A=
no-no to me.=0A=
=0A=
Not providing any sort of changelog doesn't help much either.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
