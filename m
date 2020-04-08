Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78B51A265C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgDHPxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 11:53:33 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57711 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgDHPxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586361214; x=1617897214;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5mMXUZEMbRkULPPuXHHvvLBG4vytDnW5nE+sLCrcpEQ=;
  b=AOy7YI5dCjmk4buCSd37/kkxIrvkSql/5WZkc1avJtf0M+5Qo49NBG1X
   DDgIEqJp4NC6AWPTcMMTStfJjy2+JSssgs1BzI6dq8ASXnfNp+pAYjLPU
   1iVkSUMjoC4pXGmOYu1FwCB4DI93n+8xp3ZJ3XlWzKKoCjlJR2jqO4HXe
   fOlBaYv0xY7MKnYVTft0SRytyxQ5OdKvv6/u2tYQDjvFsMO+XWUiTIMVd
   1f5hjnm2E0TcUG5Z6NkFD6W8xsK+PTHbA57nhbp9fjeWvdCCETHyn2L2m
   N/XZ/3LVPQ9WP6joHLCYws2fAke9kporXSNnD9rPp68gHCJbmHstLzQKb
   w==;
IronPort-SDR: GW/vTvhnuZGCyvbuPIe9wzpeHylkOBxJm5ktFkVdDjgtgUVDBLh0ZiBjng8swHpEbvTPX7dP2N
 TWxHmnM545ruOu/iYzh1WUHr366biGOgnX+Q2up7uRAFwSN4hOAieJBgM73O87iD+WdtwggSn8
 dCpGow+kxkqyewH9vAb1Rv9XrP523FtS2Gv9e+GvaMOjP/b2oB5H2z6TA4dT79pvYAR7d2OioM
 AbluIRWmeAi3f8KyKp1Hi5d1eNg+zG9ofgKslJPIUGSGmEtI9GdRKUhJGMkILCy/ucyilrVNpZ
 1Vs=
X-IronPort-AV: E=Sophos;i="5.72,359,1580745600"; 
   d="scan'208";a="139178756"
Received: from mail-sn1nam02lp2055.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.55])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 23:53:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnctMSBLUHvRQOCJIStqu770df2zgfEoYQQI1Y+Sm1rvS51k0GMkgyMdtZ3Wj4LH/GtjQwne2Y7qL4uVdrmG83fi/lgZd3SnmFdDCXe66PcIUno//afU2CXc/dhIpA9vYHtscg7UUfmoF5bJ+J9MaxOhzYCH/XrAI81lyF+kFHrv+er3JOB+USmcWY05//cuhDJ7K9IemU8zlA/q6KxAAOu3N8X10hZSKjLAobJuNHp6OeGx8EbMg8ffnKm3XZsx7IkwOs6kYpBO7Hro06Tke1cQW4N1OVHHokZ1z02DyyMrU+77krwYDdjbZXKLfjYyV1m1OtNag4Gex7OnetNlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mMXUZEMbRkULPPuXHHvvLBG4vytDnW5nE+sLCrcpEQ=;
 b=bKZwdiGle19NcJho+CIsiMK1RzjkJExFZdAnOEtTlNq6GSNZGuGn40QLNDLLe88HnUhJxgtliEqvvHPjSmjAtUf0b31e7qWsSbAtoZFLwmjJMQq6L+fOzay6E+M469nv80C9+L3M97PPqeuSTvi4J4BOV4ACEinwG30tU4ySNg9knsAoBMTh6+OFSZp8WRFttHEFNDePYvmmkfTUVMTxe6gIHMknkCf4bN+mfiKcPuusRLc0Yz0QFfUhDqucSdZ8iY7Gf1aY2SKvoRgrdkOe8IulxEP7VEvJ2LpV8TFRVXN65tEw8Kh2ZU8K4X6mSTgjb4r+JaFo3vyEnDA0gxoRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mMXUZEMbRkULPPuXHHvvLBG4vytDnW5nE+sLCrcpEQ=;
 b=zSINdLzy3UraH63HlXVi5Spwchf2Fh5M88tH7+kQJHKMNBvvVzDqlYm4y2ha9VO11nx73x4JKO+pPVYmk37L8uT29UQE/IYn8pC24SRgZ1gN2pghuAVbhLWx33EtpzpnOpvuAylDkb4OsjH9aNqW0cz6DT/jRn2X5CyWOr+bU+Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3647.namprd04.prod.outlook.com
 (2603:10b6:803:47::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Wed, 8 Apr
 2020 15:53:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 15:53:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v4 02/10] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWCaB3XVR5tZX3y0yqP4hTKj1cDg==
Date:   Wed, 8 Apr 2020 15:53:30 +0000
Message-ID: <SN4PR0401MB359889EA64A3979B413EC51E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-3-johannes.thumshirn@wdc.com>
 <20200408155100.GA29029@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed271ad8-3cd6-489d-565d-08d7dbd4fc5d
x-ms-traffictypediagnostic: SN4PR0401MB3647:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3647F18568934CD872F3351F9BC00@SN4PR0401MB3647.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(478600001)(71200400001)(9686003)(81156014)(55016002)(8936002)(5660300002)(91956017)(66446008)(52536014)(76116006)(53546011)(316002)(558084003)(66476007)(8676002)(33656002)(66556008)(86362001)(66946007)(64756008)(26005)(2906002)(54906003)(186003)(81166007)(7696005)(4326008)(6506007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFiosLAPUWkjzA1+3aqpcWKpE7Qwcl26BP76mEHNbHfYv9P8WrCO8FCeXs3vJgAk2Sfs4bI5/IcBMub1pdEu1xSsfFaKlJaiIGlpEugYEn8oUEFmGK9veM16S6qQJkEiLXshfD/GjOoDDUbwGDNVCg+52WZJTSur6L2sDc7zdgw4smr3iCMuB15t9FrPDRZWi7+OcFUsqc8XGGFGM4HlJDhM4sSHr4IVHwx3JjIf+FoDCefuhrHsKfEWlGLUZeK3PElWzX7Aa7JqiCTm/IinQwsNCxJs0xOeun9nFrdxsaN3xPGUNPY2ZxEvGWdktk0SKRUj3slcma4GHG5pN6vFlcFD9+9xcpEML+rTUO6Z9W2PmofTxJBScheGbpTdNFyF0bKL5NGAIANFu5fUoVGcKydRrtkoffqpWSUDKFQkB5gtqd7M9FZZFMPvqyAqwyER
x-ms-exchange-antispam-messagedata: t8FSiHha7m8/Byr8ZTx0Ae5HNSwjek2tLqa2GX/TqfmD16iDdBdkNW2d0mkIHWSlVzdcKxDwk3uKtpfAaJ1J4lFZbexXral+vb366sv5tcgA7beJVwBj5BqpQ/StUC8HQWiIFNJAFobu52U08lyNfA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed271ad8-3cd6-489d-565d-08d7dbd4fc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 15:53:30.8450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B03lRd4ws+Qja/3sQPoPvLT3xOfTd+eJYI/rjwsC8H4/Q63+Zqf3b/PusGWxmQqL2jZN27j8x/6aEzYwmm4t85RuKxXIe+LJh5ILS+OGTeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3647
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/04/2020 17:51, Christoph Hellwig wrote:=0A=
> Another nitpick - op is only used once in __bio_iov_iter_get_pages,=0A=
> we can just call bio_op there directly.=0A=
> =0A=
=0A=
Oops yeah, looks like a leftover form a different version. Removed=0A=
