Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE52309FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgG1M2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:28:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50770 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1M2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595939286; x=1627475286;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qjOA8RTZVb+X0iac4xC+obbBOFt0cOWqOhApliMuxMLtsknbcjNlCR8b
   tM3gpqyVfubqVIPYSiuk5k2iqpnkcGws5rrz4Ek+boDLXCkh8fR26dGSW
   iaYOkHP8KWMAdT2hbcEEtOQbNdtPXWHYLNoZc0pv8NkPrDnq+xLfk8NdD
   uyjKCyi4M/1OAiUoT/DtNd1NB8PZwQXUBUO5eNGqjm0E7UNfIqhsenQDO
   jG0Fyr9LfFgqLHyobT12VgtiGqWCs8Exq531I9VEHYja36l/4b8ClkG1i
   PldVpFUq64usntm0sgOfuArmOCc8SR2yXXPWpLWfnsvs+iu+61NX8pHaA
   A==;
IronPort-SDR: +nBTOLJtWBU5n6TwViwAvwNzOVLXNwy2MA34RkD7Y2ITtU/d9A0Extc0p9j1XNO4qCbki3OZ0U
 gNS5/m4vj0qVbDLjFtBGF4j02DmK9LwVaGHClCOSpc2AsvtgaP8KH8x9/KOUK2j40XzxiFkoK4
 jn79ufK3m3FeOtZkpOzLHCbkLARcRbuVz8LY0YipfGQa5cManGvyNYXP38ugP6CTWDV7hN2akP
 +rIIyIfR/QnHW92eMNuYpyQjOcGlTRAUjwkDzaAiQ2JFBGFU0fKx8qCKkGaca8XAyUUcUiujPF
 H3o=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="147860191"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 20:28:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnV9dxhpfpiBsVX6zR3NT9wBxgwhu8h+8Cl3tMzNn+fAj3oAit40Ei3bRTBQyftg+xRoMwyulGcezs6FzDi4t8+bnSFQd5ciksy4U+zqiAs4ijdHii6ssgkSE5VOOR22+f1cBYhpqj3YKofG/W9yMGNNjwHHlKkvFkBHmbJH2vr+Muv2Xem6htZd4qLfkb2SfJuzVaezS3pzv4FQu1IrInLf8FbByjJcLDNqoVxAi8u9OBUlSwhessgxO+I4vZD3WQLjdCTdhRnizAmR+Xgv9yTNErTEuuAFBxLK+KOlAKoEaf39O465IDde37aco2cgl6oW64FTad5yv2x9bTua4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=F3laAf1ClfDzwejH9rEAemLaN1C0owOXMJ7GUVFNDRwfqLlnEX0CZ7yVvtEzPtRke00mimiD8WPUOy8VFxZtw+mF727btXiilTm9jAEhee5Tnuin6NdBjcDx+VrHBHAz8po/PTA6e0WLIxcK7ptWo16icUj6T/8G8sZ+gAIlmPjhsgIV66VggzVZ/a8Gehf0T9gi8rn1HsKJQIL29c+x7HfCUSIrD9zwiXhPryicbZccArwbsgVLkOA+LpEhe8dSJNwisPNaiBkzvTHoaGY+9io+Q7n9ifmVYpmm2TI/1nwjV//TZEWOzVFBhaeHuJW6MdrJgrSP1L95Jxd+OqdiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jOtw0/6rR7XvwFQtRyb6KYDcvRrJqYeZdpYuR8pcdLBAjiVLr2+0KVEiyY1+ErHdSKTnOTBHC6SQgUs1vq3X8HUeQfYDCPxDpxnPPMUuo16VHzfwCy5YLuw2tv4rpUEWPzeNdsAoSV2uJVmToVg6jvjejQBQ1Bskux5LqjnCXSM=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3590.namprd04.prod.outlook.com (2603:10b6:4:78::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 12:28:03 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:28:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 11/14] mm: use SWP_SYNCHRONOUS_IO more intelligently
Thread-Topic: [PATCH 11/14] mm: use SWP_SYNCHRONOUS_IO more intelligently
Thread-Index: AQHWYYzqJua2R6QPAEmuD6xjWAKdKQ==
Date:   Tue, 28 Jul 2020 12:28:03 +0000
Message-ID: <DM5PR0401MB3591B4A5B0E425635B36F91F9B730@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200724073313.138789-1-hch@lst.de>
 <20200724073313.138789-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab54e55f-d034-4d54-1c2c-08d832f1ac80
x-ms-traffictypediagnostic: DM5PR0401MB3590:
x-microsoft-antispam-prvs: <DM5PR0401MB3590D32DFC3095F420E593869B730@DM5PR0401MB3590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GCPeAJbDGJbpp0o6wh4I9WwPHEiCWC3V/9/ks7tj3UKIhyHl+C591FUvQtUU2LsiJPtKhCPRAzDcrvP0oeMYlZYcpJf54ZHdSLcu+pgP9aJFAQusoPtKS21bH0GbPDnKfMlVYT70qKACckKH56KJsnGI0k/7GnOYTV0Ve4aXAWzSjzocqitzLHQB90bsgfKzgMhv7dLWQzDVVjlo58f2GZktYDb2BmQYTaNl4j7fBAVdLnGvaVUZFjLNkC1L8MU4WCiIHJJgPElr3oHxRZZSMxiwYeVafmfq+rlg2NpCsThW/BQ0n72glhN5P0Cbx9Mpj4HzR2oUVdBewPsTxLww7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(110136005)(54906003)(186003)(4270600006)(9686003)(8676002)(8936002)(71200400001)(86362001)(26005)(7416002)(478600001)(2906002)(4326008)(6506007)(33656002)(558084003)(52536014)(91956017)(19618925003)(76116006)(66446008)(316002)(66946007)(5660300002)(66476007)(66556008)(7696005)(64756008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xnX/3axcL9X+Aho4MTXh5QMQ/xTTSQwme2HDik2KRiFgXvR81qlZZbKRbnWnvOIDc14/Pr5Mwz2isfdsgmgC6caN1ihAZrR/i80TvxjmQCO9gmmOhBqHDRIklQ6PL//sKUpK4hzlm6CCuMyZVoz2mhdcKqjtlc4aVcTLPyN+hOMcKOOyNP2afvM6hUi9V/JOW2IwkAm942yKQCvBBY/CFrdrZEkgc7a8wp1GSKfi+VaM+CWy1AJ3/lFL4L8TavM0k8VLviUsWLHdZwGkLyZpcOkhl+DP7c13HFDU33aJxlhkCdM7dQSj2d8rsH2CZIa4gmYGDA/7QRnecx3ahYnS7zOvb+S7s7QlJBN2w2KHwPv/CaFUcO9W9Tf9gN+aWPUvaOc8bqw2HVumqN3n4k7suWsHphCf+5goP0bPVOluAS03CCZsoXD8VqEnnWTqgNeKzGxB2+iEwiOTKHHTDZBFVGFCidOBs3yTmG4CjAEGbS4gDdakq0lepNJ2+cSxlObV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab54e55f-d034-4d54-1c2c-08d832f1ac80
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:28:03.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5ptb+N7aJZj0iAIVVlxBdInqVVfjZVWdpH8cQ04P+1P+yEc5qDANSutpyX1VP+UCPaMNh3R5xd0PYtdPyD9VGgH4RdTXdk/VKjDaRw0wVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3590
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
