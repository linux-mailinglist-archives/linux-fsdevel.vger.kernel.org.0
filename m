Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98B205839
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 19:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbgFWRFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 13:05:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38461 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732868AbgFWRFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592931903; x=1624467903;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pn9JizKPe31HLoolAah0q8bZRJY2HWWvirmSXRLNz5I=;
  b=QBEgr4qwURd2lbY75n/tsfjLgO+iQIVPlRdRLh4vYkQMK1143Pw9WRBW
   dP++QjB3vrcQQBi+rB7wqo9buKZY+Xl1nc74tUFIx+M8qIg9cSbaRLIMa
   HS00B6TD/uuKuf9+NV6UCbFJgVmIdzFuJcNAVLY4mPU+zznWYMMxwJWgv
   otOrnY2W0jRak27QoMStfYHxSoO3LtTpz7efR42Lkoh3GuVoFCiCSlOQt
   g1WfjYMwX7Vebwv0i/NbASW/QPtvCQvV0UYRXuschAfTrdGQupihIy/U2
   goiObnysB8pKUdoJJlXpd5bm8CHwqrSzJd1N01IeQNNkuFroY1SCIGmAY
   g==;
IronPort-SDR: tjYNQ20FN+LfnioKgHMmzfow+xk0sxEJ/Yv59xDCWV7eWvvaQ3uv/Ql6lNbguZaDhMBF8rn2ni
 zA+pdscoFhSCXvIYq+a09OtX+lxjfAWb0yIdolZOhNe/LuFbq/kAgXgw1OG6fe1ok3zv82UyRr
 ourkufxnIOEvDD6KBe4jI+e8qCI19SIxfUhFquCjLt5EE8rJE+Bfe6idNvTjDa2gjyI/oDW7hS
 66bOmKGJWg+rMEkBqbEQwj+VK1qGLhu4zX8wLs2nUW7Fy2G1y49tX0nUrnI/xbwQxSOe5M69hs
 0Ns=
X-IronPort-AV: E=Sophos;i="5.75,271,1589212800"; 
   d="scan'208";a="145041758"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 01:05:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIIPzPQVy/aEoPi1KKeW9JoxBqvbauG/ki5BfNX7XzQRbgv9x+fW+i3NyErIrztPkjUlcSHoH4hcZ2lQAZCAgXo2cq5vcEnvtWaXkMu4xM4AzBQ4cB45OQW2K+vpyUKZEXypaF7hWu/tEBwrJI1+HHN1f0KQcYfGWUlbMPCMGTVjwy9kMbC8+PRTv8Qy2zmYduRrqYoo7qhk9jY4bX8+UOjkfXYchjXtvZBUNgCobFO1GfwKx759NLhsfKHBvGn0rV8aUbOhcghmnV/jXvbjc5TzS3LNrUJfXEY/Rfy4aGpgIiGAxcT05A8LH2O44gibR8jO3h+Yq9TTBtCxPnFInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn9JizKPe31HLoolAah0q8bZRJY2HWWvirmSXRLNz5I=;
 b=LZVRzPiPOfIdADGIMMjjzrupt9x8ZEP8g+ojC421F0h0FOk3I/4qBj1VucAtt8AWybXLLS+mIHYO0iQLlKlHWrctkm5+jXEz8ZpCd6wXb+dR0mH9VXyR0WOqJp5yhdN0FVL7s1cd156U84JdmQpWpScSZthaE6plVD70xYBOnZYfQrvkhxcJXvnYQg1mmNxNm1VY2v04uWJrnNHT8jWIB8t0QopP5D7AoWd4UTfuipBkhgw/Eavt4uao762czrGoOk+mUpim4tAOUOre3y540O1cU5w9t3fo+z7CimyTtBbaOou7SzQ1NnhuLTAdpzPTG7cjwymvU5RHWz2aKUwnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn9JizKPe31HLoolAah0q8bZRJY2HWWvirmSXRLNz5I=;
 b=H6kb3mKPxm146on1d4viHQH2H1NNQ9XYUvwxOHNd5ypVfupO22FWT8hDYNgOJC+E3xZLJSc+1SLMQWKM3mZG8kRJdPiqlIfqWCIzV/WTuH6uu51oHYIQw3fiEEa7yYBl2Jj7ydSqLR9pDgIhH7UZOvYn4ockNCw9hVrK9e3JT7Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3887.namprd04.prod.outlook.com
 (2603:10b6:805:49::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 23 Jun
 2020 17:05:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 17:05:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "nstange@suse.de" <nstange@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 5/8] loop: be paranoid on exit and prevent new
 additions / removals
Thread-Topic: [PATCH v7 5/8] loop: be paranoid on exit and prevent new
 additions / removals
Thread-Index: AQHWRnrpoqa46jyoHkuzQr78h5o56w==
Date:   Tue, 23 Jun 2020 17:05:01 +0000
Message-ID: <SN4PR0401MB35982B3522B95FADDD06DC4C9B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200619204730.26124-1-mcgrof@kernel.org>
 <20200619204730.26124-6-mcgrof@kernel.org>
 <7e76d892-b5fd-18ec-c96e-cf4537379eba@acm.org>
 <20200622122742.GU11244@42.do-not-panic.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c32a78fc-c7ee-4e1e-773d-08d8179790e8
x-ms-traffictypediagnostic: SN6PR04MB3887:
x-microsoft-antispam-prvs: <SN6PR04MB388720C98D3AA5CB7809D7709B940@SN6PR04MB3887.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7SRzUoD5MSBTHEwkU5ZMpPwEAXOABbbCn+1GtAVIm2MYnN94se/cuuufrufdHHbiXUbu49IcxQ4I9wGO71rQjo8TFHY5ekCAZjcpJJZ1/Rc8Dh6NBVKtTnkoBojzW2+xopaAfZprhr1PvgwG8FkeAOiOGDQwnrqQInpWmT5NMxL9F0kYjonIhAtLp2hjn9NGBka9MJMqwaMAMJz+UTHDDtLHwLDaLnncbEmjYXXQcjrslTmevpjdm+lX9Z6zoJVl9ywqfNpchpNBXGvQKYorYCkiDnohCy1Hsjkb8t+NlLhp1M+RUOmTmJacT0OUO29K3xJsic6FUxSkpGYuIQs76ZYoayKMzvmIIj+U2LKXRho8EVDFpKlFG5mFfQ+apY3VJr3qVR4k3RicJurlVMNaxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(71200400001)(26005)(6506007)(186003)(7696005)(52536014)(54906003)(53546011)(33656002)(91956017)(66946007)(8936002)(8676002)(110136005)(66556008)(66446008)(64756008)(76116006)(66476007)(4744005)(9686003)(7416002)(55016002)(4326008)(966005)(498600001)(83380400001)(86362001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ge+oPKMAo3XavSJyoDqZV9iOp/I6gfB6EItcBpYG6ptRVO6Zqo3QHjfsCrHKMUBem7LR293QnZmz4MarjlhcFJEUEpgqWKF1PvHLuFZoZtWVj5OjGrvqPmHDSdRHo/CEcn580aSjjfHbSucqJqHuie2ujLphyb81AlwEW5L2fWCnGvUy+XBxYtR8K4P561p7ALTgzAvhzsBaUUpcsGFaeCTFn53sWJ8yxPDPVhfTcwUk7RTdQKi/4gWLm8HpszhOtiW4Ij5jmo1pafsD/f/XsJobG+vBbqbOLCSuYjY4ZGjxto49afGOOogI3C8IR4rDDT5IbLZ3HoQqW4fZYOxd1gz1+bN/a2ibifDD4I8YOC7klJ3cS02eWp45Il9y6nsuZv6hv3PHvmGsjdDiPYmuzBUABhw9flY/HxeyUkBDxtya0LmFHuWel7DbjrRDiwbHrNIF/OzmH2vzz3oV/2C4wy5tXH7b46aJ+CNcAhKA/Yb9t9HLmi4abbWak6eYZwtf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32a78fc-c7ee-4e1e-773d-08d8179790e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 17:05:01.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3uiIexeHZm/kZ4Xv0P4IpmtArwCdVr5oJx4k1D2jWGSqu1RSqNkqxP2DwtE0CmhKCTvNOj/2E0vnDyM5xlsnIk+Fw8uLeRLAXlN7cxqzXNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3887
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/06/2020 14:27, Luis Chamberlain wrote:=0A=
[...]> If you run run_0004.sh from break-blktrace [0]. Even with all my pat=
ches=0A=
> merged we still run into this. And so the bug lies within the block=0A=
> layer or on the driver. I haven't been able to find the issue yet.=0A=
> =0A=
> [0] https://github.com/mcgrof/break-blktrace=0A=
=0A=
Would it be a good idea to merge this into blktests? Maybe start a blktrace=
 =0A=
section for it, which could host other regression test for blktrace.=0A=
=0A=
Thoughts?=0A=
