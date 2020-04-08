Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90B1A1D6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 10:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDHI3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 04:29:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46112 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgDHI3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586334543; x=1617870543;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=crMcsQZbdBdMeZmrNWXza6Ba+MXOGHE3I8WwkbrKPI4=;
  b=p361CXNRZovWxTBybsZf0aX2fCFLHf0uwyGOZAdXwe+xnuaQ33HLn7We
   ZMp3Oc54AD4hNynsrTYU1f00fs0am/pkrViFMrNowNP2sqsm+w/RV5Pb7
   7Zcqu+NWlxygKkVjHbNylzapbl1AokBTScoGOfRgMZ/FoV9NBsMPc4fkH
   IyamQOl67mG96pXqimN3KM+QOiRDkvB3o/iXpEcQgaXEuKsuGq2WveCot
   70Q2oPllXvg0JwWCic2nCerggapyGRaIqNtzkBgL7gJlN3PrbKFsEKbJb
   6DeOq5NAVC+RoF/UvocdYY5MVhsXLZ1Lz5fXUBizSieyiEMFs7123xg6O
   g==;
IronPort-SDR: BCL8gMUYZNwP2XcTLK/tP/amQx5q+vLQmzHLahykLJsP4OvRyXnOYjuABQKHqliE1UYRVt+Gx7
 s70akKiLMjq7Ip6lbUsMKjqzKV0d0JvCI0xkIOPFvEUAt3rKxpSZAhTZMDkWuwFDqtVkzuYufr
 As7JTXlgkayaYcTRAyxiU4+0KH822uLSzYSpm7g+UYEbJs/5thJTt+XBTARjK15iF0d2CK0BjH
 8cpzv0Vag23AdDcpV27RZbSb50mAin1uXB6+TuofICyCcRkMvHF2EX3ibjMxeL3r90hXcy5EvP
 xxs=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; 
   d="scan'208";a="136298234"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 16:28:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aszzE93MXW1Oq2iis4fJ+Sj/Gdw5mOOlqT9qwEaUZLuvpUc7f3lZUqrYpiaRFWdzfNY2Md6YcWIzz7iRoM+mIQtNHwA+wysg9ZOthPR1zZx+Jo4ZPTNBkKfQy4cWae/Wl8aQN2kiB6uuqozzvRa1iQHIYnTOlfZAjRlYEKrgLuHFSEgOfp6q2h15nhpo/b+Ts159pmRDzkR+xVqmIdaN+IuhR3vbaCV/Uy03YrkuPlJu6D1tF8dxqYH3iqaMVx3BQr4iVCpLwGjJRmkuEyw/LJmkbmT2LJnDBVFQOzw+s6RJW5cioPcXQU+YckaYtjq1CW8PewWzyNpntmcUe1TiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crMcsQZbdBdMeZmrNWXza6Ba+MXOGHE3I8WwkbrKPI4=;
 b=TaP8uPgJlG4YM8m5gSq9mE4IAdov7MPp9UebIe/N/RKnmw583bzre68+8yvYFhafvfhBhfWc9hwKK/0fH4yc9WDIPFTr2kSmB+sTxqcn1O2eOFzrqYV3xwe4A+ZB9wpYCQf/OZBc3xA4vzZLOdh8S1IZVsP1aNibiBAkFpvjWEU1lK3cWKqEatgw6yryGMc9JQM6pIXSVJVgWHdwFnf2mHQ4MNqwiYwn0OXOh0dnpLlIqKRFg/bP8R4Obv7zHUsqAqAXcG+0eZJiptZ91ktISYTL+xZSubdfnwY0dEDJU9eVUwhV2o/5TcVKHH74OQ4x0eIdZCTY5JnsbdG9qynxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crMcsQZbdBdMeZmrNWXza6Ba+MXOGHE3I8WwkbrKPI4=;
 b=U4ctw+JCJrLoK93/L3Dzozt/tvSe+y7yfa5nIe2POJiI8BW4SFZ/Krqu5JJ3puvP+Q61zbn0hq+eitCiZg4FMvrn+J2xuPCJ6WrSszvj3R10Fnj5p6R8XzV/HbrDgEpFkpQ+PYIxIyOJtfFkDGZwysARkWsBabO6qmS7AR6r8n8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3616.namprd04.prod.outlook.com
 (2603:10b6:803:49::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Wed, 8 Apr
 2020 08:28:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 08:28:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] Introduce Zone Append for writing to zoned block
 devices
Thread-Topic: [PATCH v4 00/10] Introduce Zone Append for writing to zoned
 block devices
Thread-Index: AQHWCaB1i6xu40M4LEmYMmVWxMc/qg==
Date:   Wed, 8 Apr 2020 08:28:56 +0000
Message-ID: <SN4PR0401MB3598E05096AA5ECBFB17BD4E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200407164920.GB13893@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e82a7388-ae85-4644-b51c-08d7db96e133
x-ms-traffictypediagnostic: SN4PR0401MB3616:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3616ABE09A493C36CE6E43F49BC00@SN4PR0401MB3616.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(186003)(81156014)(478600001)(53546011)(26005)(52536014)(6506007)(558084003)(7696005)(66446008)(55016002)(76116006)(9686003)(86362001)(71200400001)(5660300002)(8936002)(316002)(2906002)(4326008)(81166007)(91956017)(6916009)(33656002)(66556008)(54906003)(64756008)(66476007)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sjck/Rwm37afoDCGYBHybfWlMCToW9BdpG3Dzvof4T8p5zcxa7FKtSRL8olC8IZmXyb1sToK+l0mimH9jDDw7vtjQR8I6dZnj4B+EaOksqPgmzPUxDPDuPFs8fFN+NhAC0R4P+NaxdxgYajmNBlG78Qb1FHganKRIFcJpehLgMZtW66j7ZS216MVvdvuKFanoT136EOQIOcmgHhDgC9NS6do2y1K4TOtfLE1h+uKerpeDV57KJLmBiN6116iBFRjrWAAn2pUnSBjDbkhYaEERYCspXgA8e9Vl0Oe+FeU2hXUh16eEgz7lLhFS+42ukRyGC0mY1RqlePmPK63rkWVI8dpV2km624iEiGQp9rrKnM6rNUtuSzsmUWY4/7YtoVhaOWN65/XeFKMcQ3JTCYEw+T6DkxS8mv+eSxbvHu0QZsWo/NWxUb2ZuxrY/BFFpE9
x-ms-exchange-antispam-messagedata: ybRWQq2vfkVPScB+/l5TPgZIRlPSbYXsU4f04slxbzA115huuKC5GJ8FuCTDWPLvRI5If7/lmeCXM/DiZr6pJyTzoyZrpOyQOYPLU/0JqqrZzIc0zq8+Q/5+UBHmk/xHYjrwnvMb9XbhyTypZUL3Pg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82a7388-ae85-4644-b51c-08d7db96e133
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 08:28:56.4285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVW5zPUag7IFl6MqyOuuAKWyoqH7NhnX0lWKXL6YuH68nUNXwSAjrET91e8F+jyVaRswtINAET7/4nN275eWydys+JFLmZ79HEjf0Udwqj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/04/2020 18:49, Christoph Hellwig wrote:=0A=
> Do you have a git tree available somewhere?=0A=
> =0A=
=0A=
Not at the moment, I'll provide one for the next iteration=0A=
