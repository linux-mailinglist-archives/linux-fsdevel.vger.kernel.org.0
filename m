Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241012291E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgGVHPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:15:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12138 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgGVHO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595402099; x=1626938099;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0sTY9vMtHUqxctAYaAW2HR5t5lGYIpvoNy/R9HnUrqI=;
  b=B1slpBwKZ4iFuNw1ZS/JufeRaYwUZhxERxL1vBS2ykB0LuRt2YenGDJi
   F7BJaE5eAJPPVQ9ibwObt/7yufKwox3OEYEaOmcFt0Nv3XXdLYtmCR9AH
   7MQqV6PKU1YQw+sD8DAA+WNbbOH5ySiKrU0XlhExhTrfiudQGu5QibqH9
   aETtkjvgQL4vP3bKQbEWkW4YaReqW2eitDloDdSCWDlDk27yuo/g0GJcj
   TZ7k4kExAdYqmJOIfF+9HpEw4YFkDUlgWxy1qG8t2tlbAYC+ckaUIiozE
   pu460ZmiRT4Ufoi94HYv1HAViVbZAjis8XU+qqi4/YUS6/7UKQhKNRDbZ
   g==;
IronPort-SDR: pc2/WjcuxvrFclU6NValPJXDB0tgAaoRuqe2a+akGKibVY8bjGEfmNLWnxt5SVoaTy2WAZDcbA
 Zh2ZnrZKvLbKxy2dQ7Ya99pwdBOjYQHa+9HMDxcv8AbJ1+50jFP9+F7ysipB0/fmlU4DJ9lRtp
 bqfPkL6x6T5nWhiw6z8PjhbdAffuA/MHghrwQXEm+y6lWNeOP2ilpzbePVaAoP9uHL6NmLXpkK
 gdtXW4UVq681ekeMP9Kx7xwrfPikLhKD92uMaTYHtygdGT8xaS9buJ+cdE36VFPeRhTDZ8QKo0
 hhI=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="143183408"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 15:14:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMHan6by5xNyU8AeXiRjmc+qK7wW2PyjSN/EUkRJtITc3HmDDCzeZf9DmdVcatqKQTW8o18dEGvLZsW8rGuNVVKYQR7NtWxMqmi7o9LEGdDsVD002rFgkF5ta1G32MeqFXBAYGKmL3H9KPrQSInmAnYaukmWC0rw4ohDS6NQtkx3mxfeIEH+DW6VDU0115o8GXD2cj8ibVAlnxy6pdneV+M+w6bt7q7+3ebWu4IDhTl9sfCGlHDsu3KyL65fiAVzBNnqh8qwUp+ASho9KivZA/cflJfvzDIIZK7ySLImR1pVUv0mvLkJTspf/pz7Gz6MT/1g7+Q1S4Z5SO2XGje9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sTY9vMtHUqxctAYaAW2HR5t5lGYIpvoNy/R9HnUrqI=;
 b=KM21kB9Wf1jHGJ1WxGW+l+xro1e5QM84WYBfM1EuiXLFbb/zmqww1mTY6HfEouTGJefcyM0rI7M13dXZei1SoaBTJmnX6rf2WMCO2VV/Ypss7Qdf1zyuWQqDfMi5B2iwK+tYXfG7j8TcF5g2DId1QyPIVCUh2LT2xBqCwnyCKiD4AuaP/dQS5hTKVdMSJShWPIzzHE9+gWZjWjsuP+N+L1R0O/yu/gUnU/XMPDOLVPifMa7F0OXyG4RoGZDMRldwrATHpwHAYSdPg4yXJ0sRIzjSLJWXEpKLmGIsE0aor2nJHUX/cA9RJaBScRXijCt94I9PvwbWMAmHt2YHfbrVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sTY9vMtHUqxctAYaAW2HR5t5lGYIpvoNy/R9HnUrqI=;
 b=q+Kitj/nvxZOwuDcHmNLboHS3yizg/9iwswsbyTYsOqNMv+neZhr8nQhFYtJfHDQ1fGSUtCULvINoox382lnBbr+f4xNb84n3olK1iO2FspP5aS7IbyxkJOQqKt/WBcKXCn2eradsdqvfxGdQnPdrlGvNbYveuBS5U+YdkrG/Bo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Wed, 22 Jul
 2020 07:14:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:14:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
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
Subject: Re: [PATCH 02/14] drbd: remove dead code in device_to_statistics
Thread-Topic: [PATCH 02/14] drbd: remove dead code in device_to_statistics
Thread-Index: AQHWX/FEcddsN2HZWUefz5cntVZ8LA==
Date:   Wed, 22 Jul 2020 07:14:55 +0000
Message-ID: <SN4PR0401MB3598CBAC629556AA70E000CF9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722062552.212200-1-hch@lst.de>
 <20200722062552.212200-3-hch@lst.de>
 <SN4PR0401MB3598495DA5AF46CAF019BDC69B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200722070703.GA25590@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2330670a-c853-4a70-2c1f-08d82e0eefd1
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-microsoft-antispam-prvs: <SN6PR04MB48621C8B02F4B850406FCB339B790@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pl5JYcJ56Wm2GMn+ffg1yHsy/s18KiEfnhdruTshRVNiwwg68IxDuiZV2Xg85sAfinfSW2+6PJC/qt41JtX0B0MTRa+h6YEQHJRISjc7LZ/+H9RBUt2d6tUqVTnt7GkU38pmptlA35TSrZOBsh38/RAcWgcC4bZQ0igoqrX/GuKgJz9eexHX+2WFpOBeFO5hd5npmsOMRGgouluo1Q3YL16sZBAvs5tXKoUIYEeSd+nph4DjaimjKCQg5g7HQuJnesW1Xm3VLr+GOINK0obhrY44uCKKBOu1xeD9AK5SGuMR3kfHaJIrUMGaUwRA16JXLytT22rIRdU+mIIHx47uEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(5660300002)(86362001)(54906003)(6916009)(55016002)(316002)(52536014)(7416002)(8936002)(76116006)(91956017)(66476007)(6506007)(66556008)(8676002)(33656002)(64756008)(66446008)(558084003)(71200400001)(53546011)(478600001)(26005)(7696005)(66946007)(4326008)(186003)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HbBu7kpOiyx58MreNuqYGSs2WVDhCUOo5SGzo1ZwtaBXoDfkWv3trHEuQKK3mi1fcthYbNcAcWgfsMV1KMw3jQ2dm4EXbz/hUiYu/GOParcJf9cWiKb0rK4FFJ79CC6/6K3NPxCkr6aBqkav83mNQWFBPkDyaGb8xcUi1imTIzTkEefMO8sAmGX9Qst1ZwQeDron5FI1eWplmASeDD9u3G56RlcVJ9Pil6KMyGY4rYBvcC5pW0zjZwxfYmqM3Fxrxi3x6ftbTXFU5eQo4nCd3eAhXf/qp7WgMXYOxaqTkpsY3FM6hvNFA2mUUrK027X7/ntGunnWq8hE63cKGob3G5yGRW77mTQd3zc8UHVg3MjeVdIaNpd41IlYn/a/sRnQeH7zJwU4AvFuQ6634FO3v1pMMbQ8Iyvo7ayUidy1U8op9JtKnBIDRt26qWg7iLumeAc5ivsBsbFL9SAdCCn2ZmZ0fZps0YLLPB0kFO1VUIfxLkYwZIApnrJoM+ldYufX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2330670a-c853-4a70-2c1f-08d82e0eefd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:14:56.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZP9tVVSQvpKEEiq4mwZWTQ/AfOFicHsKPAtUdZt1XAzhvm9CZ7ZqCQ7JH9RJZOv4MtTHxsV6Pk0j5r+2QDbgxeBB6q5QrZl/cYw5OoIsdGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/07/2020 09:07, Christoph Hellwig wrote:=0A=
> As far as I can tell this is a netlink user ABI.=0A=
> =0A=
=0A=
I guess it has to stay then=0A=
