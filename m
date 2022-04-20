Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B275083EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 10:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbiDTIrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 04:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiDTIrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:47:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4303B2A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650444254; x=1681980254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=g1+5gcrfv+xOFfdMUEn5sV/VVD1TEWQ2KLw3di6LoWE=;
  b=nEEo/G6ZWnZp34vhif4CXz5OZwGsI8V5KPZbhT4QXSMFH4tAjHMkYpu0
   N+0U1+Zwrjueqd6+ZEJoVXxdCmKrmJzN7g9BN/XGkWWADbzUyO8jcguXN
   vdI/Sn8kM3UqRX62Y7gQIJ7f4Yd8LcoX97o+52hkkgGZEJX0m7YvsSyLX
   G/vw9BOf8a6SIkccT0taptfaPtI0QBrnupxAsCLbdMsBo9V53YLQiXA9X
   mYtPTPRCeb34RFJo9OUhBfcIwxYeF5Xe0oOGDF/aTARKj3z+uLFHAj+QX
   mnEHw/Oo+Sy1kiGHSTAV9QP4PyGIOcvpgjqOSRFWXxEmG/7oj2WB9ofua
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="310317345"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 16:44:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOGlwxx77ACOq7lf8Uo/1kd9CGGSwjGOLE70u4QpkhWGB3UovZoseh+C8NySxg3EdZ+AITznKlbEbBSTb9cw71Ldn0lwXMfZQ6AWFYN1YNYpQNyR1cx+2aRDT+JQcJBqYjA5sr0pgg98O0xY/yCkVrKzcM5FyWMLlMBdrEeNOuRTVfgiknSoM/IRo92L3KSS9R2a09g+V6BzV7dBXaER0k9ppMOix27d4H6nlyZMP907KR3LZjBpj1S5flPQvI/g2QzovAVYMIGwp8fa10NV2rQQzuU7Wua7fAAnbsvuEzz1fZf3ua9NAnCTlsQZ1KnNO02CJ8OJaMnocx6d3HQRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1+5gcrfv+xOFfdMUEn5sV/VVD1TEWQ2KLw3di6LoWE=;
 b=FFLyxVaA9VCvrwFMpich+9XTqoFtm9Y1OpCFrsIzzNVDmbVRuoAhcYFZae25m8UXSmhmyp/Fm2+nZ3I3gGk1QITcgx2SAAEJq2K5Fl8UHryN0X1lAfDw4c1uE1nVVuvKgBEAe+WLdlJ5BoglKLEq4H48XD5gv7EMDqgOWqLL2lzHjAJLWe4FHtA8zfsb9CfTqo3yec+RN4rDJd4I87YYqlBQpJilnw6i++7TS+CT5mk7Cz5FjsNve2bmNAZA36A//nm9sZ3/cnab/2Mrc/iUeJyb1ra6X41D6ps4BqdRRk3H5sBWkI3nAwCVrna6gSTQyXOBktTgYZUNXVpbAUBdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1+5gcrfv+xOFfdMUEn5sV/VVD1TEWQ2KLw3di6LoWE=;
 b=UnxrGBcw9fx82mQKok4XysQcF2YYm9gQLhFyrt2EoUoZ7jrFJT+jUmiqJNyoRPcVPq0Lajfog+ZmPkpWhJ0UK7ccRZK/BMmxSu8VPNAmd5PpRtB5kH0vTiPWBto+Mk19rJYKOSnc8ESpKUmfkUDZH5/BEBx6VrFA+l6RWxOza5U=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by DM6PR04MB7051.namprd04.prod.outlook.com (2603:10b6:5:244::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 08:44:12 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 08:44:12 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/8] zonefs: Fix management of open zones
Thread-Topic: [PATCH v2 2/8] zonefs: Fix management of open zones
Thread-Index: AQHYVGAASxaA1b5YLk6BZXSnd8vnJ6z4fNyA
Date:   Wed, 20 Apr 2022 08:44:12 +0000
Message-ID: <20220420084411.GB26051@gsv>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82b1debe-c05a-4b05-583f-08da22a9f184
x-ms-traffictypediagnostic: DM6PR04MB7051:EE_
x-microsoft-antispam-prvs: <DM6PR04MB7051528F9083DA0217ACCC46EBF59@DM6PR04MB7051.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wstXeBqMqoETswwVl4MWG5A+FMjtmo4CAA8s3583UXZOEB3qAgm9KW/WGcf5jre+vBJz2+BNqJqs/E785nQw2ge4/RzXI4Zzf8q6yyOUmsQqMzbbfuu/NknHfYen6GKxg1zD4nsDiquyh+27z9f4/qoxaoqAh+Ql4qDS1i0DbZgRnae/9emwVp/3IJwowS768GtM/6pKxfcWITV4VjpJfc24/YSkL5p/ZZ/JCKXsbegEE8C/ZjK4xXhGZ5FJ0MMhIsjf0bClTCesDWo7I6d3/OsQoyMqHrhuoYlmuHA6ZaBTsxeKBiT9+nOTpn1sYeavo/5zRsTR559tEDA5HKl2FvKD2zmt+4RZXF5/IjIkbbFAyywlYQ3r/F94l6GZiQuhpUEdZR1ILe+GHiagCfQogk9jpz8yeJUNZ0P+4hCT8lqtTvbD5Kh+ASNRf9VTYbX2iMNfirt0vphyooCJRHFCWqK3vr/fINFFfxj7MHRhN/rmeaejE5hH+CPK1X6pZth0/nwTXV0gBMsXNJ6iIfHledInOnyDGvcThDH1qCN6xkzn+g81x+Ki36J8M0T9BtN+s2fMOlcWZkBIoNflSBLniiWyTSeJkcxZBD57axzrnJB/E/DsuT6NHAceFCmIUetfp7iM48wyUEkMx4myQzoZ6M28tgQwSKPPD7653p/a/8h06186TLtbytqTwsmYP63dd3JiDl+KBXyjupJjYICseA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6862004)(66946007)(508600001)(91956017)(66476007)(66446008)(64756008)(4326008)(8936002)(33656002)(5660300002)(66556008)(558084003)(1076003)(4270600006)(6486002)(71200400001)(33716001)(186003)(86362001)(2906002)(8676002)(76116006)(122000001)(82960400001)(54906003)(316002)(6506007)(38100700002)(26005)(6512007)(9686003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pEpmnxNQjFv4RYOQccyMG/cj9mWpSB7eNGkyEglKBWo+u3A19iv4pUXGDns/?=
 =?us-ascii?Q?nynM/Ws4bfKYxMOJPn/3a3YawD4AnWaTJgtcmZJZkvSDh0AZH7LC2IiEtss3?=
 =?us-ascii?Q?hc84iFZ5Xozf8ODUNSbnhmbBY2lWGJeAdn1wTMQTNG1xdtZZ8o5EQaz7XZqa?=
 =?us-ascii?Q?BLVPeSn9uN+//38jV11esgsq8TClu/t8d46Oj9R550381dpf8B3v8NDukmc0?=
 =?us-ascii?Q?f4nyrvfWcyRo36lAHi6IiUYRxClm8WGNNSOzaAXTR68goxrD2hTZXOBRj5HY?=
 =?us-ascii?Q?2pj22Bbi2ZB2o4I/UYmOBrG2892dpNv1zbz0/N7FnnX3ita4CeH7tlBUocIL?=
 =?us-ascii?Q?fiF4PmQa+t41GZ//KznLm3bOx/Yrev9nsDWRGG/TkOWhX3rqguulyhHtnXeq?=
 =?us-ascii?Q?T+oLAwffiXfWpELuklQZ8orIn52IdpMErJVYdNy1QMiJiNOptsqAxKxsBlMD?=
 =?us-ascii?Q?PZIbPbhzbFs7gFUB6TS+WXb/KJZETLzdiUxbu+TToyQ9RW0smdIJsbPq7zms?=
 =?us-ascii?Q?nbzfWFh0vXordvz6824Ns85ljeMt/8bx0oqIXtt2Qjndo2WGCgGe+0cw2TTc?=
 =?us-ascii?Q?2lOkE3/NscJ98q3ERTmdBrasxhe9gtSNQKMVPwKunrDtz8fCqFwgsAc+mYjm?=
 =?us-ascii?Q?ODGMs7OrKeSja0Z5DK6oAj6OsnUSu5HfWNytU/f3i1yWwP+rDzWubAA2qPrD?=
 =?us-ascii?Q?ZehiiLB60fukAVDWb9ILvaNQZRDfAMiunbl1QNuj0S1x1pQT86YTUDrQT5e1?=
 =?us-ascii?Q?FdFqH41JSzZ08wsiy/dmPLRCy1lq/vb3gutsvVw9CZ3ey179NbUPIsgyAApW?=
 =?us-ascii?Q?jZr+M0itYS7OlMR1/I2qLU0/ebBXjT30PV60OMd574PfZbvzMJjiJoEeTzvC?=
 =?us-ascii?Q?2Eu7ov9vlMzdSm39SmRyFQqICLxomh7i9iIqa20Jlt3dgRVFgc05G7Ec12k2?=
 =?us-ascii?Q?8P5vBLkCaBnO2hwYzwgvZtEkzsoczceQLODQZ8njhUccGr79KdLmShogIcMQ?=
 =?us-ascii?Q?hpLG8AoFw5GjhWFLgBo1xODMa+Py/e8WmTtb9rUmivLdKjfPdOv5eTb7eiL6?=
 =?us-ascii?Q?qh8ahe/dRtd71+SQx9nLFZOnorgamFJC9211tOagXoQk94SojPedduTLrYm6?=
 =?us-ascii?Q?o1wz+kOukS+frEApXeegdaRcllXpG6XoLrqbybQK2n/RzZIsML0Gu1aYJcOg?=
 =?us-ascii?Q?Aqtg+SKL0eNiW7UEB08ckSZHMXyH7hjzjGSldO/M4IrvorzJFI2VC+ehTulU?=
 =?us-ascii?Q?pbQMNYkWcXaBcOQpmvK1aIA6KSkueqXWmiZkZxS1KojGkv+WsykSNRBUUADb?=
 =?us-ascii?Q?PhGrGDCddbBa5tALWDkPNZ5Yc3XH5ckwxVO7eHfSdDvZZ5O3cl1ZfXGnwusS?=
 =?us-ascii?Q?ZxWbCm2pNBvErSpMEsZKrGJvEIqYdy4MAyFO2Ai7FO5PBMz//35tmcAznUf9?=
 =?us-ascii?Q?MzbCHowYmLh6/t41RmR5dmc6F31s6Lel1p1o1z3udv4s6uclXDeKZmmX9Xi/?=
 =?us-ascii?Q?s+kDLD2ubven1NA3I1rJhlexWYpxCdY0uCvb+dC3ziEBOV/+VNn7fd8QJqJn?=
 =?us-ascii?Q?Dku4zjtBJNAKsIWR650bZmBoM+WOpdrOnxglk4N8e5HcEqlSiovbNz0n2+5J?=
 =?us-ascii?Q?T5+QXySDyVCZ7bISyrIac8xxP6UhZnJ+viqk2SvAg9g1zUt4mdRAe0srsxV4?=
 =?us-ascii?Q?ojV2ElUkDWMc5Oc+RGCg03n3n4SK/Oerg20Vv0g1Ct7fckOhTOc40xljM/op?=
 =?us-ascii?Q?3HuCdWhLn07nzGgOpjnl+6Cj7EbpO48=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA58343C6528084EB9E3542AC92915EF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b1debe-c05a-4b05-583f-08da22a9f184
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 08:44:12.2990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHKoMMl2eQ0xL5yDj+vUnuOs4JmF1BHGUViXQsBhYuozJjIymzuY5U9w2sSQvq0qNoHvN93j5FGLM9pkK1+5NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7051
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me,
Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>=
