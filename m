Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D571924D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCYJ7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 05:59:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65419 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCYJ7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585130364; x=1616666364;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DwJM7W+S5R/lJpKFTp1e3wA1oPKy14ehw/zx8rHlOfA=;
  b=Jv6pD/bQt7+P2uDS+GZlZy5N7BJ+sOTxqlhUHrxaq0FVDgx0iUn7Qodw
   +ViKrH5DhoJCk0kpckWLdURx67YIErGX1hHfHNG/quKVnsQrjYBcgcd/v
   bCQoHojWDRis/VGxZtg7sXeznTk3vyGDhJ7WUwa+bMRT28QpQ8SiLCC5A
   QKsvVUq9AQSTQcreGH5UkDM8KV4sposz0r1F+o7XrQrvpvbns1nFAWtmY
   2VU4b+W/vrL5l6FyJIB3BjYOBnJWjZD7zIFdQPqW8aqazD3ZAU3ltT0Z1
   mSZJhcKaKF3Wv8xrfjyXlnAs6E07qfvCcXdmdXjwEdd3EN6SVoauEWrQ6
   Q==;
IronPort-SDR: Z6g4t5meS4ZJHsPWR3DSQ4XQb9uaM9Un/jPLdMq6hpLt0eSWGtIjYi7h5lK1r7AGc3XqUk9oIK
 L3qr/cEMM+xTmYtuSwmGMAB6UbsOIT4Ja0STgAVnJjfvZy7lo5uSbrDq1aG9SNquKM1EzSOpyR
 EMH4Rs0J3zZqwC3CigsIIWrJ4mZpAb5afl47Uojh2AC9S0GjjcGOfyQ6WsCvfBqOL98ErxZA0y
 xdsu/VtpAI82/DUg/+pkaQP4Oy5XKnYW1127EbMt3miI2ex5FgVlBeZKQohkHWspKuNkmHmaGO
 yP4=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="241946530"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 17:59:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhH9mD6hkj9ppEyz+8ntViddoCH4clnx6cxZyAuZox2n5gEfx1RKlTHuxq48xN9vghsRVEweUfnMTsA2gjeoiES1sm8MqociaBdH/5UW5WrhssV5pIcVEQEe3eIuaUUZhYsCaWzi25uh/boHrtbLuaI0fKf3hY57Im0ug5PFxLeP4IaC5xlcPNnjD2VKenYzdxhzDIJIPpp/Ex1rUuG62YgzTYon+DMZnFo4aJbcT+UDYFX/lucAPx+oOfCTNymuf6BRqtdIySy8LzfPCb//eYP42BaxBlM6B/+xzAyE6ZEeuUX9JWnK3YkJzG/akqQ3cU1jqDQvH+WaE9lrQ4+8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8LhjpSKESMseDuxyZRg+Hou5KHqJNPd4N5FzAdpI8M=;
 b=Rw3jKL6sNr4OLjpj5gqS53MhJbt8vtRaamNaSgIc7SREOsxXRU3quCGlQX86UZHQIiTFqv0DemsmW+W2Mwkxbo+pofPjE1ysK50HkPEEz1T3r7t+I6kxgD+Jm8mS7PQa+W1ZcrUHuu4wdcH4JE0kYCodXiqWNOkalgMGHtCHULC8QgRDC05922qROhPH5Qw+gthcVSm9k58i7PRJypMjYEuPcG+fFpgo/x/qJxq9no97lv6dbDYcd1bDpFPTFKRupTuwkoeRWXuBTkQ2B16ROrFWqPP1F83G7Ankn4E7XVUj1sx0xe6wHovsmOjEbuz0DkmqCcudcTEmlcBZLac8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8LhjpSKESMseDuxyZRg+Hou5KHqJNPd4N5FzAdpI8M=;
 b=Owh9AjYqHk0+lwTaLdBU9FWl0vB6RloJKpFyQVj9UrenRZjOWVfYAU8KbsmeS44zOTgMmaO6//m/unqbHA6BOOHRw4/bGxOvEq6bNltm2ar3lfnrSTiLezpoJJv8wjZtGVmvUyYmJTc2NdhfuDHD++sEL38FDkJi2K29RdFfvSs=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2213.namprd04.prod.outlook.com (2603:10b6:102:a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 09:59:19 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 09:59:19 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Topic: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Index: AQHWAfBwIA62KDxQPU+QCf/8uspjMw==
Date:   Wed, 25 Mar 2020 09:59:19 +0000
Message-ID: <CO2PR04MB2343F14FFF07D76BF7CE9D10E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324154131.GA32087@infradead.org>
 <SN4PR0401MB35980056EFCD6D0003463F939BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200325094828.GA20415@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b45c727-7877-470d-3a58-08d7d0a32fcc
x-ms-traffictypediagnostic: CO2PR04MB2213:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2213C73868F57572137B7BAAE7CE0@CO2PR04MB2213.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(54906003)(110136005)(81156014)(316002)(81166006)(76116006)(26005)(91956017)(66556008)(64756008)(66476007)(66946007)(71200400001)(8936002)(5660300002)(66446008)(86362001)(186003)(52536014)(478600001)(53546011)(8676002)(2906002)(7696005)(4326008)(4744005)(33656002)(9686003)(6506007)(55016002)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2213;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lf7blOrQfPNfpJFW99DJKoONbUCi6ExuTAWv6dTyura6rgEW1KscmzvOKjI7rnl1e/aCcjK5/NTpTFaU10p141tvfAZQITZWFLVzcGABJu3u2marYGaHD/mjvk9turdSCv+NzutK8f8KaOkG2GD3AtC0F6Q/0SHfSjEIu3iUFJm6yDVxLrCL9kzAFttWbfiW5Qwqqvm2UIgM9JnxDNxk5xAjIv4rA8lGADn16XbIPMuteboGRFFVgdzeNw920DuaB+olBy6QZXKemyiKjuzvxyRxRQcg+m4Ky7Rbbfts3CV4V8qjw+wSBLjIqWhn8LUgJQmSvMPAtY855Mc/djeLokuniVYk5v0iS1eDAYyAj5cSBvbeXZyKt280Vc6Scj5ck4KUPLOw1tzneDCvv0JiNw0hoVcxzzBHg7/l5A4gHGe6OQUe+ZA6p2Eq05KBD+kJ
x-ms-exchange-antispam-messagedata: pg07mnkhrMGlJMi8WkE+fTNW1Inhtj6yGgkmXA4lpxo6vUJKOVinm1OQjwxTGhLSxWhxXH/cBg5QebvaLGJZYyyzlXoEf4ZXgr3nC+ZqbFoqiuipTVzQ0o+jac5Ov0f7UyfgnQvzjQw0eD7CmHvmaw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b45c727-7877-470d-3a58-08d7d0a32fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 09:59:19.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1u7w/cS2zWs/Pho7DMUVdsby/qn+M7nKec89nXQl0aC6CgyYJu4UeG+6FrbkU+mW8CFcgZLGsPGWI3WgyodWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2213
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/03/25 18:48, hch@infradead.org wrote:=0A=
> On Wed, Mar 25, 2020 at 09:45:39AM +0000, Johannes Thumshirn wrote:=0A=
>>=0A=
>> Can you please elaborate on that? Why doesn't this hold true for a =0A=
>> normal file system? If we split the DIO write into multiple BIOs with =
=0A=
>> zone-append, there is nothing which guarantees the order of the written =
=0A=
>> data (at least as far as I can see).=0A=
> =0A=
> Of course nothing gurantees the order.  But the whole point is that the=
=0A=
> order does not matter.  =0A=
> =0A=
=0A=
The order does not matter at the DIO level since iomap dio end callback wil=
l=0A=
allow the FS to add an extent mapping the written data using the drive indi=
cated=0A=
write location. But that callback is for the entire DIO, not per BIO fragme=
nt of=0A=
the DIO. So if the BIO fragments of a large DIO get reordered, as Johannes =
said,=0A=
we will get data corruption in the FS extent. No ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
