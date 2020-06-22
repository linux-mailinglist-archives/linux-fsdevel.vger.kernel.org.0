Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC120334F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgFVJ1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:27:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8083 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFVJ1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592818073; x=1624354073;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=K3O6GslyGctxyNUdJ6wjmrY9YfVARh2CRCMfMyn2BuPPBRETE7reNlCE
   uKSOs6aK8Tfbh7uXtut8rR85wj0Jkd9K/0jPXBDnoMjTjmQ8E29jlNBCl
   /CqaZg9xEr59byw4TvPqQtGKe+eRDT5jsjjWgArbwZq+bNrhUAvP7im14
   XvsWw4UKSMOQUkVN/+mWJuoVaDYSRcaD5oW+VcS4pEDwkrNwuzyZ/ti5Y
   WhgNIXxItuswvngAc3bCphQNxYp3OXIvvTktf17b9ul+AentEqv3Udkk4
   efA+VkmL84SVfGL5WKurYc2MQaGYiqib+UjWVRPirfGjlGdxh337RXL7n
   w==;
IronPort-SDR: 5LYhldSt8a6aQxAXm0nDykJ3atwG0vcxgd2j/UyBzZtGDoOgqkjsd/Po0vrMce1SnmRnfMFPGg
 z1XCsKVcw9asgAgDBcvvsu6myKt1w4TuIxIVSLFSL/UDcoTe8DqSTOeCFPsue5VIpfP3UXjfLZ
 hhIQVzEhefIs+NVh8FSp0mO8r9MpmXjs/A4+ON0IEqVNFjSGF4hz0H4VmiCx6l0Ve4PzNk2OPX
 hVd29gbvzoDiLhioFIxmXDTxxggvloYQUcLXrDj51nsF6l3M8KTxbOBfNG5l2nhi9EodOYOuHw
 YMQ=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="140839681"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 17:27:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmtP7eCuwHNUVmFhfcu/rTvYBNWcFIZTapyXt8xQzWgc+q9CeH0O8yRUsnLJKaSmfunNq+1wbL1wTDyB6gO3nDVRbWCIDYMWgByk5h9WlFDZv20hHYq7tS/Zm9OtmDT6tYJqmY6S/Gx1GuECx/zdrzpn/172kAlpfnK1oRdyS3cfMQgIwNvkbzfNeXcboEiR9ILxJWbBRjd1w5q0EFWGrAbcd0s/msGI+3bWM+BGgrJF8oGIejIv0GjVt8a9gcFjEaW8h4KQdiVLT+GkP1DB9E+S56CCRTR9L/jEDos6gJ3HYs2sOiFCb9GOQJfq89uvz7fGzyRq4OTZSUXfCkjh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RIkrZGCrw3U59vzP0jNlgQ9eNBLevVNuuppHAlCnraj0QrP4Z0RxTMNl0t8T+SPEk8uoUGw0oW9xtS/lxhTJHQfxaQAG6IpkZbtlvzxN7WLju/LFdxSyBM7WayhPzIER33Mf2PgTd0/U5oAbbBMIrhV0F1c0+L2Jv2zPO4cV3xcasCwtd5nZqAGjkNSprckJGcfw1I8L33KaGrQN+Me1hyWZoAR5vGiRm7SmyEse3iljytNS/ZIpdzbVelAy6i3X/3O7aPFWyQ1DdMQUstzWdUjAjWEIEVL13pPLSNNQUDw58oDPyo5PgYkLsH67r4Z7o35wnBjM1xRN2TOyOWmYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BQnFsvhbN6yItHpfPAbE48SlxoZwA63H+jV/735aDzoLlv2ZxeOhkIEeSY3mnR37/MHdXI2tfhClvAtMg7tmbl1r+RHAug31oW8D8EBgzsyExGNrzubvTLxNClDqvKTz0ihNwX1atYRgtMtyYOLMNABiBoyJJHbz3UdHOZ+BzF4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4400.namprd04.prod.outlook.com
 (2603:10b6:805:39::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 09:27:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 09:27:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] block: simplify sb_is_blkdev_sb
Thread-Topic: [PATCH 06/10] block: simplify sb_is_blkdev_sb
Thread-Index: AQHWRtLf4x63MmkTG0SMepHCfcXZ6g==
Date:   Mon, 22 Jun 2020 09:27:50 +0000
Message-ID: <SN4PR0401MB35984F063818E0BD65D475439B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 524b16ff-de87-47fa-3678-08d8168e88aa
x-ms-traffictypediagnostic: SN6PR04MB4400:
x-microsoft-antispam-prvs: <SN6PR04MB44003F093AC8F9DB44B1D1399B970@SN6PR04MB4400.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/PFv2H/lWohY6Y00FH3sL9ZaHK1MXGCr0ONGgxcy/HJj7cOVaggHLJB+ziVECqA6B+wc00Q6h4tJibG/yeI8zomQuRTzXkfpD0RrUMgSOp9MUnTxmQwIB+TML0kknd40ajnFOBzsgbGe09xYoxvqlGmdsw4VCrw908u/V/3nabVmOhAiB2p2BNz2Ay+5brOIH/ZekWJXBLIrsOEF/gCqfqu8lzkRxjePZJohEZTch+aSNQMalAExW44B5dD8l8KY1KIaari5PWCwn6fsq4sf1G0eQPToFiTjg7l3b5iM0mm7wvENMNQm9EA+Bp+t1gZhluq0X8iZl2xKfey4Nawpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(7696005)(66946007)(186003)(8676002)(8936002)(6506007)(4326008)(33656002)(19618925003)(4270600006)(86362001)(9686003)(5660300002)(55016002)(76116006)(54906003)(91956017)(558084003)(52536014)(110136005)(66556008)(66476007)(66446008)(478600001)(316002)(64756008)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OvoOb5wAvaA9OUcpcvb0KsuI9Nutui1J6vHrz/PoHTnj8Qjuy26+o7rfBN/l2sAMgCsUGiYaxubNSBb9Q7ZIWxq3m8g8PnGLgWmcBvNBckwZJrmP61uE1Gzqq/gIwR25aK6IqccW18qE5V5lc+DC8vEG2MhUpnPZv4motfPErs1a1W7OuLHtyjRkhpoZEsqrZ1MIiuNM13qk9bZMigKCeNhTgE/7CIoFAgVhPPrg+e8BeRfnnKK7YWCwvk9dhWk+8CiS29KivjI3ZfE9DcMvvG8Z//Tw0Aa4zzb8qZFtWANCUup/rWg6J96BC6h5tf8/z5BWrHWmvYy5Ogs9VvGXYfnMW0Y20HUQq3/vO0gy5/Qb2F6Yxnv0qGjSQ5UMqesrqIwKzbuG1vi9ynHVjQFWXFkATtCRN4pzD/TeE0WdaK3y4EAQ65vJHLODmxu39/YgnWII2zCO1YlRwzyU5OIplZA9TZk0ohZDbvTVcqye3tgYX2NCobfsLXz+TXhm8qXPhMYCyu/LWvbuxvXQX4VA7Bk++9Hi4M9WFPt75mqQQSSCVYy/pHCHJNDcXeAs2dgY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524b16ff-de87-47fa-3678-08d8168e88aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 09:27:50.5900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zshfANwsCqVY/uiGl2SROrC2WWzFC49/qnOe62huTUj65CKjJb6FbPbTUB/GuXYvCSL+BTlSG1WV/61p5oFSKR4y/DC2URSeDw0sR8RJ+yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4400
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
