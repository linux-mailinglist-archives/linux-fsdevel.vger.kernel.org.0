Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DB25AF0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgIBPdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:33:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:18543 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgIBPdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599060803; x=1630596803;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6Qftzrl0VPw56qZqskhW8istca3MlMJ1x9GrYWocgfg=;
  b=DoXrzKyJEU8SU3yzgGI5DOiDcIylKnHeY8WNZaA2XHYM9xp3owGktSFw
   hnTNoCAhM9Pq08mfN+/mwhwWbTb/bo3my3VEy4wLLMvAumAJzWCJYLWQR
   VCxT3mnTVTtn7uU/JXrS06DEUpOYZon3PfmgT03V3IgfDOb1rGTXaTVfQ
   Ur1+qpzt7H7D+BYJt/bS1KAR3leIXwlSTWpOOS4MG53wA0GNxUwbhBtm4
   oIXy0mIUo5ksd8nELxrvKANFRa+5LIxNSGR/2cjCvf1jiVckuyVJMh11T
   OxtRTvnCfPHi0H5N9uk7QWL84jN/AZGHBom+aRRj1ZuQbZ4ie6QQez60n
   A==;
IronPort-SDR: KJhOtYNZKdrxb9b7I4pQl2bSmRui31Em0SxQ6CsOWkg2kdM4YhdlftUQ0b8vsK9tptfMIPqMex
 YqOgi0mR1l1U0TNfwPRsDCOZNVgpQmENUpDuMa5U/OuNGwoBWT0U+aDv67kZ/KLppa6ixEDDHT
 0SCFDlpGA6RenN4Jl+vE7tXBLG2jGdYg5O+A05HS7U0uorTMNUb2WJJ/7TYYMgEpC0Qu+zPS/o
 UHyy6sOfPB6+7YQgluscn5xCh2UjddzvtmG+vBSjphhXmmRmGncIiI7F0IEK8cI9NkXBcLGRL1
 P/Y=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="249682091"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:33:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA6ga4JEk5HvwfdpaOgL/jJ1PEfqkQm70/omqTofxa6efxFQ39czthtW6zZLxbZ7fs4lzfsS9wck6omDRw3FHw/ZBhWsLdh/VWey94l51fz3k0/mWhFb5r6+3+Sy6t5ArYZbVbep9dEdWDOWUPCn6N/JRz26y1ysnKEgAwrWq3P58Q43QxMRqHB6gy+9FvzwMggL8zZU9vPTRswfweowzJm3DJgsA+J0J9CNXF9t8IocZcHBHs0rZLUu5CYEYX3gpsMvelT0Xl8+VLLXcZ1F/LRviKYPDJHPhqoGE/ZOQ6y1dSBWVIlh/bGMRXuqtffuDI6xMQNG6Lws41UzFvFauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qftzrl0VPw56qZqskhW8istca3MlMJ1x9GrYWocgfg=;
 b=Dh7xTb5dNZYgF/f6IOcJMGnSc+92g4W+g5L8TfhoYln3o4NNN0oqXdBNCxu2S9Q83lTZxj/eeKuJCDGAJMGRzNbaFr8f8Bi9USUuvVXf8MeXUhilqqJmkbL82vdIWNjZ4kMq+O8w0zckm0dYJQ3wVz/PpDeurucC6L8UKB0qQeLxDadDHeGaAlKaIOkJ18HNOmTiZg7vyiKD3sYbtJLjEB5fZUYYbQL7kiPwGOHYcYrkvh4/pJTpE4BscZKBPU7AGh7IHh4pfnOmLtUYpKc9Hg5k3BetJzX1pdn0oRHHDM/GMAwHNHaFCA6TW7o7OsOin2DJeFdd8kIadtgYebqwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qftzrl0VPw56qZqskhW8istca3MlMJ1x9GrYWocgfg=;
 b=WDFg8wNvhWP3XFYhAbQJMoVcuCslwwrJVrew9ER7vUJkjaFaAgUBQZVOuDTjDpx9EcBNyNQ+m9Fnz1Cst0Otl3b2jbUEt9msBIyw0LOX3G2lIkv8gkqY+6fyfYs4TFZIPxh6qo9u03Olm1bUkL76UEbCt8FqNU7l6N+h646KMl8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4542.namprd04.prod.outlook.com
 (2603:10b6:805:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 15:33:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:33:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 06/19] swim: simplify media change handling
Thread-Topic: [PATCH 06/19] swim: simplify media change handling
Thread-Index: AQHWgTgbhkHKD00fr0avvZS9oQWYVQ==
Date:   Wed, 2 Sep 2020 15:33:16 +0000
Message-ID: <SN4PR0401MB35984A7C3154CF8BD0CFFC3E9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 149e8721-7124-4e6c-1b52-08d84f558301
x-ms-traffictypediagnostic: SN6PR04MB4542:
x-microsoft-antispam-prvs: <SN6PR04MB45420C647F87531F891E4B2C9B2F0@SN6PR04MB4542.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ULllPZU1Y6PL8rAXfHCiYuXBgpGC5KqV8MOOo94Mxnunn7ctjvVKJPw29lc5UXq5O28r1N2rsiylaFmXhNIOHlOag7nbPhYneUCTcp0Mhq0rjrJ7JWoo1d2wBST4NDIFTH5tgXmHaPNaDN24ZftnocobVX2m12kVROamSb8uMqtDK4zhYhZTa/pOj9EXlmP777XdlGIHbg+Ww15NXEwUciIXGruP1fQRp6/3spcN0WZCGRg0cCwnaiux4Z/6TVQ9u7pVQbSZ8cOzc8wuAOzZsbXabAmmu3rS0NDUeE/U5cHCcUhIidGM7Z4qsv80/5Voa/JxK6yuHWNxrbQWLw5Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39850400004)(9686003)(86362001)(54906003)(316002)(186003)(4326008)(2906002)(71200400001)(478600001)(110136005)(52536014)(5660300002)(66556008)(33656002)(4270600006)(66476007)(55016002)(64756008)(76116006)(8936002)(66446008)(91956017)(558084003)(8676002)(6506007)(7416002)(66946007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Wh/LQi/W+XIBOAS/0dUoccaf7zlPqSEcap624k0kJYWsEUydUd5a7mnrvTz0RpaoGP6AgmABK3RKaqME5UR59eIE9X1CHICNAQVYFZ7/hOTb4x+u7TMr+/DYOsz8+zcdwaP8VJby2JesHGJzXhJ48GwrGurQVGgmHRTL9dwUXBmzWTahW4USekX2ZnXvPhxR5txRhp7PKPhh6+rSzc2uKUXbDgOi2qgHIhqoxKoiNQZ9BU0oNWzYuzOTACCIDD9jBJu32D+j43qhbhue7KG2JJvl5AG1uzJsP+a4cX6NfeooTrxjbmCrqCrqOKewI2Dt2MNf0epWNIe/BtYX+VydT9ma1o6fZHX+zEJ0J2VZ77KhvRJ2nTUnRFI4CA3y1mNf4bG92HkuzFBPdo10F0jf4O6CnbolfL2LZYEpa4OAkrkwz/qBLqQe0HWm/PblWCJXrBE43GnLDBIJRiUYgrSsZBYmNh1Jz8wr29kdBPkAOE7WyTD3wLhwcYzestj4/3WhH6OW4DjZLGgVY6+e4USaCuhIcrecAZLAJ+w8rA3/tiQo/VbB5ZbWcjgTMCvsw92wT4nhSAE75NONf6c3hLzWKBOC7lUseny2WTFlFd8syKNykRCKZv32GCzN6XGCmzoPN29MsSX5SXHNDIuZo6fB8558uHnSq4tFgvUoCbwsYqtqZ2LSsx7esA6w90WpJ9/tjwpMM68J6m8NBicgNvViYA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149e8721-7124-4e6c-1b52-08d84f558301
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:33:16.0518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: quxTftNwprJkztVIDXHxQLpAEjWie3PTl+s5FQF26b7taCEvhXLz3TAmVXGB4kJnRRV+/bxK/rAl3V6gRNxR9so9YspLiHKGMDwjKTbf5yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4542
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And down by one,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
