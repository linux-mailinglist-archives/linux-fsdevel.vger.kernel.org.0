Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC0226136
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGTNnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 09:43:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16507 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGTNnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595252625; x=1626788625;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sRH11lJKENEI96fQNPfw1Wqxu5Ws/eIyQwzBJfV0YCU=;
  b=GVoFJBo5Rq/R360i3q3nKJp9GyNilHv0UGf/ybklc2xgjLgkpvqY1plD
   VIKR/05HP2uC5zJDhtPcZWCoRiz05PO6NZ7SWxRlIQLiDhfbW1uuqKHEm
   msURnJ6qWQoJbK0aGMvON6f7YAZzTaEtehmnJ5bB2Pyc3+q7PZxgRg5SJ
   VD2YMaEJCkNK9iMKgd02I4oTSjFe9lTa8BVBuVQKpUvtnMb4KxiMPfvs9
   JP0SIAJM6uD1YCC9ismOygdoY9D8RlQID2G0+Kz8znJGxCkmip6OP6C9u
   fajlCocKhrDcequdH8o7Gck3w8jzXG33Xe/Q8q6z8+8raVFwfI9pR79c/
   w==;
IronPort-SDR: 4kIxgYxWpAnPIdPAqYvCQxYFApayD91k2fCvUr3TQdmN3XhGczNMvxYFzIEK51CR88lxq4YFWg
 L/xTXXnx8WDwIRGjwd6AQseSJA4UnuozkyxyEN3q51TOKIICOCNcoteXqmPMNGVMu1cpaG/Fb0
 SiESoWwMVkHMw+e/1mPb5NXusZ2WOoN7VOjov711K3na0PGK8JIfRdjs0sx/nAgom8Fk2MxKgD
 ZeFtajZ/jyWQLoyUod9R8zO/p7wdKlA/VPfWGAdDkLOKqcvs9WBlG/XKOUHookcMq9j8hCmhZb
 jU8=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="142917822"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 21:43:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5eCZ2If1p+LIBxAJMXS2efrLjQP84KiZsvkU02ZV69dNfBj6cOTJf9iVzmYRihtY6dXWOPwxDaR3tolk/HKXeX1lMfkLGlkVXjG+8g2/T7S6+7PIAJSNkNjVPmZgybG8IFm+Q5KozsbHeIpslIBgQ9a7bK3Xh6GQeLEY69R6JxuOwwT1mPu8OC7hv8CYXxg2l/E9KKMjF2/XbCfaGZPh4gC3sGtS+Ti2VQPGCnM0gse7a+a0P24eiq3iV8FWGGTngGtvTETk7JmKc95ZdlmQm4zZZTBuXHlqB/d58U6lo3dtw+cm+IOsZX6Q7g4iQZEAahxdsrcY3K+O+O6RelxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEq405UsV5uhmftDGWuYz3UO3xo50aouK6+WRv2AG/k=;
 b=SfpsdRyhDu8JVlpDQ9zxoDzUCjE7wuwsLD6kj5z9zKJWUeWCt6Ikc1ixmlW9jfrtH8AZ5E7rY0frVwAl+QieSEp8wU10xdIwcgvW+QOGQ1HcrEMz7lPdPK0hy5AdpllDstVSpfk8pXzhSUJzMj43Ay4WRelLkWEI/9zhasn4Vw6Kp+0ASRiJXHzusRyngt6RiLVYIT2EUNjhGV6iorS+fbV0rnw91z5FQviMPH+ovpZgqZK8YPNMWDiwt4XmvoQ4MQD+/+qRmMcDuQbsJ6kxMqNjmmsvZmT5qMnJeNCNGUrps8qGyqcbM+LMhKOv+HBVUJdh2o6AEXH8A+vFy6HUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEq405UsV5uhmftDGWuYz3UO3xo50aouK6+WRv2AG/k=;
 b=P/aTZK2o956Y+DbCmEkn0ghj7W/mcf1DQ+P+rTVzldJMzpk4L+jFSponrY9yOHsxDnHSYMDfSz1fHeuAiZEJIpUJj/RBbupSWj2aS5Z0x94I9XJum+4KmN42y8qGKcCVm8V/XnHp4J1ivoqsyFgu1GgOVBT/yxotbZB5eYdyPfc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 13:43:43 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 13:43:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: fix kiocb ki_complete interface
Thread-Topic: [PATCH 1/2] fs: fix kiocb ki_complete interface
Thread-Index: AQHWXpirVrFImcfIxEezjBnXvTCsBA==
Date:   Mon, 20 Jul 2020 13:43:43 +0000
Message-ID: <CY4PR04MB375119332AF668A4A0368DF9E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <20200720132118.10934-2-johannes.thumshirn@wdc.com>
 <20200720133849.GA3342@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c603bab-b12f-4dc9-e36c-08d82cb2eb1c
x-ms-traffictypediagnostic: CY4PR04MB0567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB05677FA9BC7D52DE35F71A9FE77B0@CY4PR04MB0567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ImPde5DTQnYXTz0cNsbgsP4YDFYOG7pR27Vrll5nWXnHlmUA1Ano5QJHWxSyTXqkfZi59KaH8W/N1sIHobKqTR+bwY6WCkQYU/RFfT9QU0p1NRy2ZTzKE0fa0UhiN1cwVg/YqcJB2WiDGLcumi+bKYe9Pi6q6RBHh4H2cSeFHwhaCouEPJomGA8UhZGVViULjf5p8Nv2Esbcyep1BKSNWOdNIBXNINV6SU2KvtvqBu7oCoSJNPmiJj0UeBX3ERm0ugWq3EKsWAc0TORhCf2i7H5s+By+Ae3PzgcfRfy3lAYUOqxT/ITi1EUgN61813tw6Q+9AjINGIbHtPnL7A+Oiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(53546011)(71200400001)(86362001)(6506007)(33656002)(8936002)(316002)(8676002)(26005)(5660300002)(52536014)(6636002)(2906002)(186003)(7696005)(4326008)(66476007)(66556008)(64756008)(66446008)(54906003)(91956017)(66946007)(9686003)(110136005)(76116006)(55016002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nPxqozsENHtYQnkKWNe/NLEk+qGKw2wD6J73JiKqUHuZ973gMPonxppKNUgFGSQjns4GVlFiiDnRzX+KkRinV1oC+m9aMBgcyPkG/27CIJCvPM/M2LuQXKwPyY9bCCSQk9eUieterZtAp83SQBh4MirFqQQa/uatqcixPwA6zbrwtlwoGM5NCBt8+32CLOJbbW4GY+YJeBcbvsA9a8MGEATCYFVf6cI9ueMfqng8Kd5LsrmwC1+9oxUMDaS9wjrZvbBMsgaLlk024WglC1UuEtYDGucHcwlPKgJ/xwDGDBBFwA+Sv03Io1J2UK242w0AabMEO4RbH4Lu2gqP4I5wG0DffS+Uk5knZER/nIzh+y9WuMAKrkt6nUj2bwnmPV7+mpOMSnctfr9v4eTrlPqmuN283VZTbEAyzkniVxvVbvXJbBH0rGsx9+OIQFhgGVAs4gBSANmgvBX/jgbcsA19ieVw70UwKtn9bhpGtjl7pSKOb7tzMV5vgiCYieV/iJGJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c603bab-b12f-4dc9-e36c-08d82cb2eb1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 13:43:43.2205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytlTvV2O9lSVdsY3D9XY7L4PewQxWUdGTwWWVghO9hIXT48X3Y9pLHEpYAiYq5g+YomoZb94w9Mx07kJqCUXCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0567
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/20 22:38, Christoph Hellwig wrote:=0A=
> On Mon, Jul 20, 2020 at 10:21:17PM +0900, Johannes Thumshirn wrote:=0A=
>> From: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>=0A=
>> The res and res2 fields of struct io_event are signed 64 bits values=0A=
>> (__s64 type). Allow the ki_complete method of struct kiocb to set 64=0A=
>> bits values in these fields by changin its interface from the long type=
=0A=
>> to long long.=0A=
> =0A=
> Which doesn't help if the consumers can't deal with these values.=0A=
> But that shouldn't even be required for using zone append anyway..=0A=
> =0A=
=0A=
Not sure what you mean...=0A=
=0A=
res2 is used to pass back to the user the written file offset, 64bits Bytes=
=0A=
value, for aio case (io_submit()/io_getevent()). The change does not break =
user=0A=
interface at all, no changes needed to any system call. The patch  just ena=
bles=0A=
passing that 64bit byte offset. The consumer of it would be the user=0A=
application, and yes, it does need to know what it is doing. But if it is u=
sing=0A=
zonefs, likely, the application knows.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
