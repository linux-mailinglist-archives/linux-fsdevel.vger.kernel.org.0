Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956DE25A66C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBHXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 03:23:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24135 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599031381; x=1630567381;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=i4dxWbJ+obtktLaomHm0EyoB2y2UBozipdDAqWEIrxwCLEEgGWOf4KBU
   6wk60oxC/+gxA2EVeygn2yT6keScJJi1JqGy5LV4WLf8lgidW/GYqtBHS
   ltNBtZJThn91xLwIokab6MlFSTmHgiVvlpz3QVKRBeewZRr2pAXWNuFnG
   41GRfQoUsj1YiTyEoMasYOJU3odXriyB9c0Mej4bTpLsEpJJXTEri2rdt
   9scGd0KagTBWGNMihWdV+MJrIx6GdmR+fI/cdQKs9k6epjy71CLzL+0Ub
   5I2tXHB43Nq1Fi6hXqs2PCdYTDySXhg40mhFwn+krFGz+wPjYPvfXg6ta
   Q==;
IronPort-SDR: 8nWJf5SKzh8l9jS3ehtfpt7qELFN9lGt3DUlabayDEiV7d6jkRdgNIopMBgMr9sdz8cM/K07Y9
 uLrLMolEgdhkfZ691cExFmbhYiKizx7EeDLVCPVj8DpMBj+tuOTRvsb4v1rMzrjEcrrkSN62cG
 PS9Gt1nlf/m3vCmoQaNLHmYBpUukHZ1CFFR/CXrDy2TzbanWuYT+hoI0weDL6nkH0RygZ4mv/7
 jho4JKUtP8x/mhAP0dqtiUeKNWHxPOHLUxNfzQFcUzaBVBoSIrIvMD8s/zAVD+D6Wa9W0vF999
 SP0=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="255918246"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:23:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0lhP+I45C5QSPCD+masmX3oPNdPj9kSDB6AARkBvm9xe4L6ag2xQlqTyLxAu2nqY81dpvLogOPKi59s/eqziRbpIspr0h/s4r0vE7dfltsxCCJgoqTHR/R06L8SRzTpbudHS+TPbfvvLhXdmqw7CNSasobtEc/BN0OVXZn4PzjpfKMhyGpR/e1a2E4B0heT2t2uizLrCEGkVrk3VpqCrLTLZ+qx+jk41bEQAWoYysEpIQ01UTWOKxzao3SMiuifAvH+dB5mNOBTjAn+HYyDZAWxjObyekpG/2WKaMTsrTXPUgN77jY6GRJU2KOGYMA3QHHjK5eWkI7gZSLmv+zwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iKycqFbjyHg5+aNNVEQ9rhUo7qV7oA2HppfqWLwPo3WMdo5iLyL9p0FpWSmRk1p6C+czEEf3okOo2iozOVXEQhbF9pKlW+H9LYkvjgyRZTICbGSf9fs04HMMdE211O2ma6CgvZDN0lH/LOxawSLwICu7ZuYM361xw68nA834QxoymD9hK44JH/jcMa7gR5WpJvr8PwkiU/YkkkrgFfw/VzYk589/4t3ABkC0yPDhlzvfDPo65t8/p8Mvv+j0kSoh5XMcptxreEUNtmEVIqwqRxkXS5sttOB5mmhd5N/9ewkqd3gEL/LJw0raIzn3kZVk04YKfJ8qHA49u+B/Ej54Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=vCyMrvJ2apASHQusWkLX9F7WQtecAk9iOy2jNoC5WbDKmVJfv28eqXgXkx/YqlGQ93szAlN3o2UqcYfaLMuwIUWD9BR4wqi/8d9G65ze1mv3pR27GQE0YLoxhSEBdmt9vVHuE2A0J9CXC6HBhw6t6++gBEQvBnB9CjsSrh0nT7E=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 07:22:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:22:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/9] Documentation/filesystems/locking.rst: remove an
 incorrect sentence
Thread-Topic: [PATCH 1/9] Documentation/filesystems/locking.rst: remove an
 incorrect sentence
Thread-Index: AQHWgHk2yUPrhJYVhEiAKhnkiuzfng==
Date:   Wed, 2 Sep 2020 07:22:57 +0000
Message-ID: <SN4PR0401MB35982F6AAAA2FD65805726B89B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6fe0160-fb24-4df5-d73c-08d84f110479
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB39668A5BDE006F6C8DDE92FD9B2F0@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yXAA4NG4OnO2CxpBkCQnV0qMiAsX4lYp4Ohnka8pqakaxTQlaHHASCmBpD1W4ZOBCaXUJ9/q/bT8moK1oXWTGPEKyMHbqwr/1wFZ/+FVxvPz4Qqp666p5onQ0jM5ZEhM2cqeiRwwW3WFLmpPSHgyxi3fu9KPc5j8NRia+7+ILkw/QMzXtmiLiO8Ikb7rK0sDDfCo+Ng7GLptStcMvf2eCV7NvoyeuwgqlaLw7oujjcC5k3UuA2LfBbxy8wQn7ZZLN8MCwEbetm0k4+UH2ml80G2cZM3HnALPrmk/1XbWbybldF7LvHw9bt1kkjCmoHJGTBFtjplyKui/MFio3pazsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(55016002)(4270600006)(8676002)(110136005)(54906003)(86362001)(8936002)(186003)(478600001)(2906002)(6506007)(19618925003)(7696005)(52536014)(316002)(558084003)(71200400001)(33656002)(66476007)(7416002)(66946007)(5660300002)(76116006)(9686003)(4326008)(66446008)(91956017)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FMWry4X3+TGbiY7HMQcyLdod4gQDB1ohRRBhbFcRSGf4oc6j26Fbvue/rn9K4gOvNzl76QTBo3wfwijRq13GY2XpKRDmIj2XJVrvU2oLpOYAldRb+NgOJBWxn+O3w4aIo/CG8Lno1V63u1kzDH4Hu4Lq5HkCc/Nbqkye152e3upcYSJiiYrvGZIgS+TX9m60+BVxbok9cyCGJOU5V7B0gfV0FqKN25gRyMHNB2SjVtEk4dpQkTmzl89MYOh/5aMQ0cYpJeG8AgsGyCCimRru/NbYMA5+Ynvvzkb8ndXlGsNB8KgcJXneNxDVyvIdxMdwgLLRQjfKSPcLASFQIuY0et7TCl0lBXk9ZldxQHaYDDBb7HvKEwNX5MJ7XbCj8dIDj38ISY9jmFicNiW6tereeCCKP+TrxPnwpz9iu54SsbD+pESFSU7oWqK3p8safrRl3He6Sf2nT0og5iZMF8zB7X/4CFfgrxvggQr9td/yK2IHfv5WYpnGGwcoefbW2voWcpUEiYPX72GDHjLc50q9EI/yO1Lh5I+hR3xGmqWRTSkRprVkXQVttGOtpWrwUDJzvn7/nWRtr3HSVCaYbnKBZdCGr/l5VgWJvhbeQeXguaA4RoIMp8jyXISROgui+J2nNXYrwVESqL8tCnPKG+yRWde0VWgQou01FFr04jlT1q1Fw0af5ZLeybSJpwUFBXszcpf5EkO1zYI9xMmVsVGUyQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fe0160-fb24-4df5-d73c-08d84f110479
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:22:57.9888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eI/r09PRmTG2+R/2Y67jd0XJyE4UBekRTypOsW7IgDRvPbIROAl8mibw152ovfpmVPF4yH29JF6oW33+eR2YPrxjuVbM2AB75nJUArOa9+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
