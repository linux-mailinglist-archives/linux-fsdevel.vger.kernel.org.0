Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C624C265AA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 09:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgIKHjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 03:39:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3302 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgIKHjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599809943; x=1631345943;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4lCn1IlDZFShRBtI7jau+APkVCJGSldnoTeVq6pIrF8=;
  b=QZdp65FWUSx6Xff/d6e1IxkOCKrYsRyAGVy3sjV26QMrg4iSyRo723Eo
   GJwYNYWiTZHnZ7FEY+7w2SFTtaErNrGb622t9sv1PCiyAxHjJmPy4T6kc
   fjdMWHXSDMK7kSUTXLcvWmXglFOiknzBHKPhqlrF3MLeijWXbuhS2Tf+N
   3DQ5Xu3YwkraGl3KctyzQKDCFMJXFGUIeI9LnqfxxP+7sNVxI0wPQpTBC
   y0QAJhAV5h2LjGJuqaxiRX5tfvVyUorOg5vifjTjQYTtQoQQl5kXzNeWK
   2VLL47qicDnDY2RAcZO8OgutKW2qri+TLyxcb84kqkzpdlOmw4j0n9X1o
   w==;
IronPort-SDR: BD6TGsh1Q1bb0epUl0WmfTWpLB4vzXjInrLJaSe+L8dehs9RqXLYNmqcqCy/1M/OsTukdb4XSG
 X+lRevc1ULrOAP2nxzx7OxD3fswaTxkDbvnROVfbVW38gwmyfvEObD3LP37T5+NLCARFOSMVHV
 Cit9L3m/ur28m2/947iTaBxU+8e6NwqKvzkFalUcRiC70BcmnBUYySwvAn/kRL2OPpNWzvIbfX
 NrED1BbNlzkkefqgF+KUOoIAf3UAX3AWDmzc4gfMygIVKHk271yuGUxIdDHyDqhE4hdik1kTS8
 F/8=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="148343404"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 15:39:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6P0UeZUIB60T2vdKiVRxz59x6YLJkd8mGr8OpIm/0KD0hxhXEYhhyFFbtXPPuOdGJO6Sw1xrpD2ZN8XH+QvUE6k0byI9Jvis8iWg6Vl/dHXbzHGb50NaAYVaqIad/Fn6CHaVse2elL8HyVEJD2qHw+kVzNBIg2duzsOMMKOEyG3SaqLBPNwEZadxxLZ3F5OKmxZfiRh+zPUcMqgBhQcIoB63dO4J5f8qbFtHKkO0XwhzxQ29efbAOnrCly5ThmqEyWIywd2ArwtEKc+tLo7sssFwn3LNZX+zktIUlcn/CK7YAgfYE+PT0XDtj/astapVw22h2EzM6+03ouigB3fNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH7EpBWDg91L9x7hd6KcQPQ/at8rKx/O56iDqQlmQa4=;
 b=dzAvNJRHsmLcsChuidjNhrRNmSZI3TmQbXd4jOTyyKjfSn4i02TCAfohxOWJVVOIV/aqNdxT6efO1tu1ALTm5EKq4Z2vWcRZsD2VUBHhLU+93zyBvfJgBSysYU1RdG4ovmt5047M2lm1313AMCz+bwt6AM1uXUEC+JpwCJ4fefQvkWWQtGfuvZC8DrOLMa9PUe28pro/UiYSfcu22G21TlIICGr6dUNm42/rROFXwWmwXKsnYwVWtDav+r5x6aOc8GS/hl28CdqTC6gkWQtCaxDck1NB2tb4vFZHeeM1O/AgR/i594b+8m7Jpw/UZ5bKTaNAhTVIxXC4gAyobgGWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH7EpBWDg91L9x7hd6KcQPQ/at8rKx/O56iDqQlmQa4=;
 b=Bbibea4+O8JbqpjDdx5YYQ5/PVFCxo7z6Y/x69R2FxdN2z3sFOlD1uy9K59P/SpKoTMcrsHF8wCnaNHGxVUBrX3e6kCIbaw9+oeMotT0LMFAeJcp5KpGG4FRtfrsneaJSSjBh4wM8s5SzY8U7SqG4vNrQd9J2Aqy9/b6LzfMLtc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5119.namprd04.prod.outlook.com
 (2603:10b6:805:9f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 07:39:00 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 07:39:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH v4 3/4] zonefs: open/close zone on file open/close
Thread-Index: AQHWh3/4KEy6K/+s50OeUCR3ExukVw==
Date:   Fri, 11 Sep 2020 07:39:00 +0000
Message-ID: <SN4PR0401MB3598940B9EC43330631FA2009B240@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
 <20200910143744.17295-4-johannes.thumshirn@wdc.com>
 <CY4PR04MB375116B70163C393E7F058D8E7240@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:f81a:38dd:93b0:f1b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff3f4f2a-e77f-48de-e34e-08d85625bff3
x-ms-traffictypediagnostic: SN6PR04MB5119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5119D5B6F64B8F74EAE9DFA39B240@SN6PR04MB5119.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bkSPXSW4qtS5X6Sd0UmfdZ1kczs3MUo5fvO6Zi5SnoDquzyfoIMfsBCHlNd2s4Hl0lRuqMGW8QFea63BJW+xuue/DkhOjA2RUkENN9IrA3OoCgxBxXM+g3t04xvYn8xCURWvG+hLiRPwfBiD9FcBinH8OhGDdfelKHRkr4yil2Io077DBKVKy0R46Hz3GRF3YkgKOFXchOh+DjtcgI+9Kl6BonZHHjRWe6ZXa+z8x2fpE0/o/DEcvMIYvfs6balomzkJ8Bq50AdcvhotXOsXqNmBq4OzUWEwyZT2TUsYZXr5XWVd3lydjixTn02scxTS7qnKF+30elmYt36edX3qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(64756008)(53546011)(9686003)(86362001)(55016002)(66556008)(4744005)(6862004)(71200400001)(91956017)(478600001)(66446008)(33656002)(66946007)(66476007)(76116006)(6506007)(5660300002)(8676002)(186003)(8936002)(316002)(52536014)(7696005)(6636002)(2906002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pjlL4Rc4eZydRqy8JXhVoRla+vBss4M0UwORAOFZq/eFRQTJtR/rgNAfxlL/BBJ6m0zN/3CY//kKBJjy4+4OdrD6O41YHldqyKUP5fMaXGWQJsrnsg1nXhxPRKmncNliyUvjx+K0TnGjsEdBx9VVGYMHaHH6gD4UpeAdY7sSWzlag1FXlRvl0YA1jKlRkOOpaOgNlVv11t2v6SqDL6QkCIWXDPk9FYI2lHf5Ky1UEQ3zsxxLeCMvQHbRHIM4ucHEVp1GGa789X9MqEPNGWRYf2ZORpawGH1Bf4ZIIojYutbtsxSpA/NrL74FDUzM4Tedxnb/0XAXNhPgqpA+PtcqZPKvaugmUT8V4uid3Sf1UfmZtoABO6OfQtR4s8wbV+gCxs6PRO7fS4zz/0ceORRQw8yC0bl6RrZzjqYIk1Vl3GXfs7NW8aTYpem/jI1WGwC+3tKheng/8uYbeD1vFZ+m/Gj87PvnN0KcblYxQKdCLCKG/DS0I23dIEKzgma2OP78WikkWV3vQancR0kyeQUMy7iPLp3xI0vvtQw54MzzeBsIrX0lHNPZeM/UU4C84HPzCerVz9WtlkDpQ02GsA+bJS8by6aOsVw1xXJmb0Z68usKIcVs4VqivJ4JbtMZgU9snc7e+A4AVf20jN5+g4HHAq/3RMc6E4ALo9H3lZUEcZDmI79VPUOm3xNKwzgRFXWvUlnrzTSkge2myFZ4HML+OQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3f4f2a-e77f-48de-e34e-08d85625bff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 07:39:00.5646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzxW6YwNnV8oXRpL2crb8gK7iE0tR/jBZFl1LxczLKsw4BM0ey00oD6kAJiiB8eOTrmSHJw0XUwqKKMEZUgFd10KRxQmeYhcwJybWS7ls2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5119
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/09/2020 07:11, Damien Le Moal wrote:=0A=
> I do not think it is about loosing data. If this type of error is repeate=
d with=0A=
> the open zones left as is, you can end up with only these zones being wri=
table=0A=
> and everything else read-only. So better take action and use the remount=
=0A=
> read-only big hammer right away rather than ending up in a weird FS state=
. So=0A=
> may be something like:=0A=
> =0A=
> 			/*=0A=
> 			 * Leaving zones explicitly open may lead to a state=0A=
> 			 * where most zones cannot be written (zone resources=0A=
> 			 * exhausted). So take preventive action by remounting=0A=
> 			 * read-only.=0A=
> 			 */=0A=
=0A=
=0A=
Fixed=0A=
