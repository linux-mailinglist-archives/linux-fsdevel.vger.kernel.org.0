Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF7A613E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 08:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfICGVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 02:21:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12411 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfICGVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567491703; x=1599027703;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WoQWhxzDNCMLt+4kcl8pagPy/ak97GfCVJBCYr8nCNA=;
  b=iMRKdq+zjzTaYnjv6r0atfyYNcNvY5KhS+FBqCGDWfI1wnLDuOl15XFF
   gv2uyeERo9T8Bz7TRWuNXmDFCtFKbDxbyHC0tw2zi56PrFeDMI1Bf6IdP
   Peawf7pEhQZqfRlPD0pk92FnRqORIcQCcQPFs9ycVS0O2WRUWqsMhK842
   nbvEQFNmCpTBO9mDnGRH84RGkf4YK4QqcRjkechApb3FjRhrT6VsRN9wP
   RReqwZiEWiN0pcHNdWZ12Bt9q1oBH0PkcGGZzKYEWDEXySszl7By3Vv1n
   J5/+QBK5/7wSF9TVx3PVed4u8p3Tq+D7WI3tEB6Pg7eYb0yE8/mbm2Ut6
   g==;
IronPort-SDR: bYV8mMIW49eO8IXcRs65UPCg2Hq06/yLbGgBnewVaqBT1a013RuoeDfhmYwDxhN8pDTIkiKMTp
 Xbp9jLiP2rhSZCu9qVNJkJhLGTLSRF4rA3o5bl+y8xnn+1QswiSdoGugGDYPCDQaqoLyhxzimL
 tRFrJo4SqitC4cEXETVufMOi3YbF5+Kv560v//aLYWjGcQaZkeWT17AwHCzZbBme2qhAooqLyS
 1lPdG0V9mLUP/9VDc16LXcRNoIq+6exYBkSZpCZGhiqj/FkyB5T9yO5yjOBfRvqZmDB2WfIBCa
 KOI=
X-IronPort-AV: E=Sophos;i="5.64,462,1559491200"; 
   d="scan'208";a="121808923"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2019 14:21:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnz1sGzcRa1pFAXnbNrMDZ6GlPB2HekRnLUGzAZWSDRdxuOoIFmhCismQqPEQUfYekfCd92olof6YrKa9rDAifO8TaCnvHe4rWRhRhWACh/B0fDdSxs3Rlxng1pYWfU6HK73O0/tspwuTqVJVtq8BcAzD/rDmi5b9Nwi2aCtq1By159wCsFH6YqHdJfjtsFPF+DrhKqglJTV1PbYqGdAQNy6qkCJKBLISoSa1RCSgTu0VifpcNaKa5P5JyouZcUtjUE6Jy/3s5xoRC5Fb6gyTFnGRcyaIrhgW+wasdoHboxihw99uDrw+cGcJriy82nXMS5ZyIQMFW0NQca3BwTQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9W0COK9xRWhR6+GSzGHuhXG0Km7ObVk3kzodn1fxFQ=;
 b=Vii6nrMyjC0bRZgAQb1+mGXfhaxhUv/42e+iQ8l8zaDWwT+adr6E+oIbn/AIk7GluhwHQLFBxL+C9LlFuq2Us+tqGI4drCHdKCzzkYXQ5WW8dMFCFQWG16BI+XhBnofpCyr/mAWC92OLKzEvnhr4sqvgJj2tcM6bi6D6vyzZsqYGqHEGscBV2ttLCpuOQkME+rfbScR1qxrCZSolvlqfOWHU9qrUhmMnUKF/QaVPq6WetCG1dtmIcNyYAO0V3R43vWLuU3SS7N7jWSNDkLqwWyl1UhVHDEkLUn6WCHHMfHzBR5+a2lxaMtJSeuepxhQUYKe63FsKF+LY49HtdI7VqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9W0COK9xRWhR6+GSzGHuhXG0Km7ObVk3kzodn1fxFQ=;
 b=V3x/JtthpqVRYVz2hqXTOmSNuVgaBOXFSrO5eL2kcmPBa0giR/1Xwr5B9+z5PlY+4LI7XwDx4JUBMfeJpj1tvCmgZsHurOQnLRCEiVYMEPH1fOYdN1KrTyUOfThE7piyad/hAXQ7eFmzUW8rADg01AOWSDjJd2Av2Fxg2EmTivE=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3973.namprd04.prod.outlook.com (52.135.220.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Tue, 3 Sep 2019 06:21:39 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::b562:7791:5467:1672]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::b562:7791:5467:1672%6]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 06:21:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V4] fs: New zonefs file system
Thread-Topic: [PATCH V4] fs: New zonefs file system
Thread-Index: AQHVW9uc9S7B9ZIieUuwphG+VS4vgg==
Date:   Tue, 3 Sep 2019 06:21:38 +0000
Message-ID: <BYAPR04MB5816D246389AAFD484D600C0E7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190826065750.11674-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816E881D9881D5F559A3947E7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190903032601.GV5354@magnolia> <20190903061602.GB26583@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ba3a5d7-84b7-47e8-3635-08d73036faf2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3973;
x-ms-traffictypediagnostic: BYAPR04MB3973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3973457E6C3EFD300DA8DCA1E7B90@BYAPR04MB3973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(26005)(4326008)(7696005)(76176011)(476003)(7736002)(81156014)(81166006)(6246003)(486006)(6436002)(66946007)(5660300002)(86362001)(8676002)(64756008)(3846002)(6506007)(66446008)(53546011)(54906003)(71200400001)(446003)(52536014)(74316002)(305945005)(2906002)(53936002)(110136005)(66556008)(8936002)(256004)(66476007)(14444005)(55016002)(186003)(9686003)(6116002)(14454004)(71190400001)(316002)(99286004)(91956017)(102836004)(33656002)(478600001)(229853002)(76116006)(66066001)(4744005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3973;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7uJnAsJ0MZOtDby59cY87gJo045JErHW8Jldbx9Kni2sljOzWzmyalYtO8jEuAwT4SAVmPNZiraFvgAggQYSsnnF1NrXxFcQfU8KIPTdNsVHV5Jn0tHTRqYdOYIY7h2Rsd6VaWjp0u8VuSnObqV83+QDA5q0KXBqrCHuoJskZVsm24IYzBa8SKDEazWkwVyHj8RjFeK8gMwaFl4LoWQql2Pw1efhLRIaMLIHCrOM2nIwj0pl/UaNfDoCZZBYUG5dC/v4gvMNSWOBq/X5MueXGx5aTECZQCW52M9QqOhPz3pee7eFbD4pt2f278VtpfG+4ReD5cFKOrs7SKKoKcdnQhDb5PkPB23tgxGaLO/5FYJKcTBh1XHSlDXv7VVvYTA6k8akDHskhb9tvziOYD7iUeVDVUwi4jLlNfPNPKGp4No=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba3a5d7-84b7-47e8-3635-08d73036faf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 06:21:39.0000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +58yc/PJAUo/WBkTjlBBuFdGT6icWVKNMBJ+MqWQvsfB+nS/YS5uirVoYGGP2szB8wh4xCOMS75nG9SYstkpow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3973
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/09/03 15:16, Christoph Hellwig wrote:=0A=
> On Mon, Sep 02, 2019 at 08:26:01PM -0700, Darrick J. Wong wrote:=0A=
>>=0A=
>> Given that the merge window apparently won't close until Sept. 29, that=
=0A=
>> gives us more time to make any more minor tweaks.=0A=
> =0A=
> I think 5.3 final should be out at about Sep 15.  Isn't that the=0A=
> traditional definition of closing the merge window?=0A=
> =0A=
=0A=
If we have an rc8, yes, 5.3 final will be on Sep 15. And then the merge win=
dow=0A=
for 5.4 opens for 2 weeks until Sep 29, no ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
