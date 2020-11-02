Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDF2A31C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgKBRjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:39:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32071 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBRjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604338748; x=1635874748;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dX2nglVKDO2DF3nOIB0zWDHD7eMI/nCi9qf6n6jELZM=;
  b=OGphKMiPbxhWnaMS0mSox8bswwo5RiGTPd4AxZ2sTymr1B88pV5+4BoO
   lOv7snZrp9E1juHdxErrEKbsjUTlOetgaEpYflbATFoe3LJ7cABOl6pRC
   LoO8UD6x143UasGxJYvX/m90RS8U3F35b0rl3+xvZHhL2nb9ju4onWg1I
   Jj5zSM69hsCKg92ZwQLqTLmFOihaxAnr4p8ANcDeJqRddDig34htXUswp
   lYDRqGdwEmnrwBQ58DffjaVLe2KDEqCFArkc5cnY1xaP40/LpIPKCU0Ly
   Qe1lX6nY1TzgKtq7y8nHsrFCCqBm+bELVJLcRIHJp4NnjuXqZ/Evt/cYX
   A==;
IronPort-SDR: KLz42KXcrw6Tn1UI4h2bV2ShuLuT6Ag/L2+OxU0ewLBRwJZaUfIxyEZsOxnLg9sv/uPJfkbE1a
 nHk0pG4mXrC9u/PtJ1LxS+v6yF0BGc3s+KDJpUU72fAwl7gSL0Kcnj4pB7GiyDIt64Ra/V+HO+
 e2fbV1OXun2jLMOSC+gFIx31G6A7JWZSfJS+j7i/Y12IzSVoq7DyZBZ+AY3Vj3H6qn0ohs690+
 c4Lj7t3dcAzAVp5kZIlYhxufe26Z/Qgb4cUUqK6GmGwvIT6r4lFtl1BM69fsOs2wTXqzIlHeqY
 doc=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="151469030"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 01:39:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYgykEq0vjaG3HVEuWl43X4ziOL7JzSMZobAbKQrA7DWN7Qn+cN15w2g2I1mg4bRsdnl0KaPZ6j31TH/z+7UJZvBv/9D2Ccm8UHic/kP759fwhuTGDSJhYbA6Ud3Qjf9Gig0EApIctQGdzepAx+1cnkXpsF2OBT1WLexpq7wWYZAlJvFb8Wd+NPycnBtpwFs6iqnG01+7vOjmPBO7iB5RX5+C5zaL/zEIsU9KRFYYU6Dd6j6nqcILbR29sfGGGbNV6gCP2KORAKHy5lWjUlnFSEbAfPNVXIs8ulbC6j2AHxSuA/pRG83CFXpAlL+Vd8rA9zNjgi2wOqc7gJ80ThDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX2nglVKDO2DF3nOIB0zWDHD7eMI/nCi9qf6n6jELZM=;
 b=kXD0CxVZN/Sy5MtTa1ARgTNLzFq0A1AOIbLqzbMOG0wHJDaQU/q2XYKdJN0GU1RDmwOWqmzgUQi8hbfcercugN/ngdMPc6xeu69ZrndjwYrX04srg0gCVPWKS0nh/IbkqrJ95CtlH+X24sW1IiKQ/tN8WR5I5tiwfFcHZ25Hisxi+Nxx0mXCtPOawP8hdkeaJdyBTRMYGJN9j35n2PvchMkFJzdmtBSicvg9n/sAMsk7wSuw5F3l/9b0e3TnhGzohVnOcVBtIvT1c9Tfyb3LpNbNc5DzXJogbLaKh6KgmztszQNM69xyZ7khgJkeag4NBkArdOyonatu0/BZKUdlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX2nglVKDO2DF3nOIB0zWDHD7eMI/nCi9qf6n6jELZM=;
 b=aNxe7YOqRJcgmPDarLhw9KQ/WJ6IMu7uUcdKoszMv673UTgJnjZUHS9Z70G5lB5K8bR5wE97GKnARhPhsVos7FJpjxnEwqR5ytMqVT7N3rctOTObqflV2RWSoOlKJlHvopKeS04+d6irrVBirdUvWj/FkWyFm6rrSbQ5g1QMWOs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4686.namprd04.prod.outlook.com
 (2603:10b6:805:b0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 17:39:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 17:39:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v9 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v9 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHWrsQvkXsfd1KoB0aviZWNwhsa1g==
Date:   Mon, 2 Nov 2020 17:39:05 +0000
Message-ID: <SN4PR0401MB35981FB3BD32C8C2200BA3169B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <cb409918a22b8f15ec20d7efad2281cb4c99d18c.1604065694.git.naohiro.aota@wdc.com>
 <20201102165502.GA7123@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be73e225-6184-4ab1-1f50-08d87f5631fa
x-ms-traffictypediagnostic: SN6PR04MB4686:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4686AC708CCE6411D57AB2029B100@SN6PR04MB4686.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2z/ZaJliOhx9LWCW/w5Z30kTcprgPtfH6dOnrYEPsCRlPKGcufASqgvMzf7VDnZsV5RJ/0L9zzEFolO9wKEdG1mKFhS2HwlnEl1aJspXXKBa4VRZ/wLaXihD88guKgPQuGGxggCxw+kyqCIf46KyXTyDyvyd86wQo6K/smaqcyWWGYYerKYEzQMF1iGmrstl9ZcYyjKvFbMCGsQK9eh4QkWmqU+3Rd8o5gTed6LsVUDi5V6XL/jMEGa7WG800rSm+/ujGEdZj/L4ArCsJ3D1Dt/+kdd/PlYDnBX2pETws0iGGzCIXf720LVd69dRepUwWEqlqsbbo7K3fwrp+TP2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(110136005)(54906003)(66446008)(4326008)(64756008)(8676002)(8936002)(66946007)(86362001)(66556008)(66476007)(316002)(76116006)(91956017)(55016002)(2906002)(478600001)(53546011)(6506007)(7696005)(26005)(71200400001)(558084003)(6636002)(33656002)(52536014)(9686003)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eEtMVuDxg7WAghPg5JbcV6UI72g2/33chgBOlFUBVS2levUgL6qXeKIt+EQ7nbrn68I320WFBJ2mM3ZkU+H5XxcvvqFBnxcoc/hKPL6w47Cf+FiMs191/ht6iS0DkgTZFuj01g0TmhZS/Lvw4iTkf6ACXTaaRacRfxbk5JDbibP0CghXXQrMTSfU9nkOXWzJqo4Hgssuu+UqXcnwzHiEytzqmY8Wzp8vGx6fSLsAqcxdtYN8/JOP+Ri3VpABGws1HHDoga+E6T/+KB80bsE+z33Ewm2jbbNXfvP6k8ZR3NhMCq9brblGEiI9uGTU2r4SFYuia1n8+Q4wN08Gc6GtKx6ETp3AcKvPzEKNANCOihirsDwT0nrlKGuHgmMCKczuz5KuqIg+KDTn73j+BKaCTwoxqcbMTMNacdJUyvl9s8BiScnN/j9I0tSQ9tKfuwJGGEbuPGHnVJgEpxmn9U/m1IKjC98+PtePtdgd77R+SLV5F4exKXA1rkcsS/blhFdvTaryNTM320VvD5NXtH4/hSq/DGp4iHbbEaGOS1f//NiRxACqSfNgD0XsXysgZGReOloyYbCFVaFZ3fDqHSXm3JQTBxXfV27h2sTVQSbyQbGoypRoZj0pRiF09w14KIDYVLiDepR5tTwIDo9WnZaUlA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be73e225-6184-4ab1-1f50-08d87f5631fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 17:39:05.4287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/OIs40p0go0HmziupnQB723uDh9GK2NyTmpzUCGP2vLAJzZ9Ykj1qwZHUf0m54YU8KjOI8bVEeBOQj4q76VM+cKsMBhYF4qZZ14bdyfjUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4686
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/11/2020 17:55, Darrick J. Wong wrote:=0A=
> Also, I think this should be hoisted into a separate helper to return=0A=
> bi_opf rather than making iomap_dio_bio_actor even longer...=0A=
=0A=
=0A=
Fixed up, thanks.=0A=
=0A=
(Speaking for Naohiro here)=0A=
