Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212BC8273A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 23:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHEV7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 17:59:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37459 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHEV7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565042343; x=1596578343;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DlfdwKoMonY8DToULTaBam+5H0MfNA/E6pDGNlddRKU=;
  b=PAhIf8H6VYErpr9IWuFXXwxQfavBq1Y5g33iDiFRIYQRzCs+0rCGKRTH
   je47PObmJPlgWurWweuKfMMumsayFURXw0IfMS0gul9okTgkdTPvBT8gN
   2TTM0HOJn3AxdcpyCXkQkP+DL6EWm8IGDgk9CFsUUzBu03w6zNmyk53dv
   Jbi7bOgD5LLjWdY80PM3cqeirjVpjPVjxVjhdJ+WLs95FBFfgGS7z5Xyx
   pFG5gWrhmnVE2ACUjPKK29q1CPnpoce12OTPQgPpkVSHI3B0szdviwIPF
   3NhCCsaaAtTSKnMVFyQ/U0qAYIyoKQhFZpBhG3neack7d7DeKFXEMeyIT
   w==;
IronPort-SDR: rQRfR+G1Cjh+d2hLC9j4Mky/IFly0M1WYjGjFvts48ni4/zW2MzSdIhgHAUlhThDffwudJ2M8t
 tI/S8rKM6IBuW28njSlIY1jbfVL6CsrNRX3zJeklpPshMP3oz4JI4rLVW6JadIGHDYbJ+k1Dz9
 siY8zbSOsFBcpyeTULmARfFB0stgaNNseLLsAwbDelOJ/4POuD9x1ZbhS9tb4oEMf5i5W0WQ2g
 gGp20ZQ+3UqO7dW5UlO8mWRGTGuqp+iYTVjJq+R0bZ7Ky6sKAPzSuMGcEPL33HKpD/GqVqDmL+
 jPk=
X-IronPort-AV: E=Sophos;i="5.64,350,1559491200"; 
   d="scan'208";a="116036484"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 05:59:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0BLt7vHyq4/ZVU6Qshd2gqV4S5hEO1CU3ZSDS6wl7OQRwrOmW+jCWr3s69tssGePjl+agkiN6/IH6YmDYwcoKRu+86szggbFBf++ZPYoxmOD0s8XadRX8GJYAAUzjauH0W5OblnuKCnUVDbR2iYSij4vlPr0e48dFfRcq6HSneemRBz92N9o8QOKG4LQtdaVXk/RaMgW0fnL7Qlw5B1EmjMbVxhV9tAIrLe3nO9YBBSUrT9MK9xUR5LtV8E+E1GfT0Ub+vgd0E6ci6uM7DJNZX4uRj2xGOAKcMJCzPvKptPnL262lb6lChn+ftA2HUNY5QXPlG5+44xfDRq/ZVWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlfdwKoMonY8DToULTaBam+5H0MfNA/E6pDGNlddRKU=;
 b=CCIEfZMjmmHDVsomf3EUJ/Z1rPQSR10jOmcmeMR44DAhJ6zfbyOR6ik6xYtD1q7qzthzwgQYd1NntG88fPVBYxDaEgVJULXKkAxQFOD8jA07+TpXBca++43jC1y97aqmYC0StnFzPv9szr4AAC8YG/wsgKo2HtOCWojdLsebrzB1A5TIQ5F6U6QaWuD3JdSYU+5QrZInfReYXni0pBZdZHnkJW1qat9kxhvCn5j7noyILMbFz2TyGSs4r8hePzdct3NQ3B+HbL0QCyKRjVA0NL1mg4uN+9ILl1WAL250ruittzEC2nu+vpcFDz2Icv0NbNsTlKbn136EYs25diY+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlfdwKoMonY8DToULTaBam+5H0MfNA/E6pDGNlddRKU=;
 b=mdBC/JVrd+bYP5hgMoamIqtdqdRTox78UlUXmn0lMkEM9+dEsWeI7aC5EweOTlulDCnA2a2DqLduNxvSue6sKSqohVHK4S9fRABWnoYvmI9OKoq9FUvNwq748WBlnARMP9ZJxcTsIlJKhPcX/GSLHGaeF9WzVYqcDG0JBEhwmag=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5254.namprd04.prod.outlook.com (20.178.48.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Mon, 5 Aug 2019 21:59:00 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 21:59:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Mon, 5 Aug 2019 21:59:00 +0000
Message-ID: <BYAPR04MB581644536C6EAEA36E3B4912E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
 <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <f3f98663-8f92-c933-c7c0-8db6635e6112@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc74661b-6b66-4ff4-e28b-08d719f01f95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5254;
x-ms-traffictypediagnostic: BYAPR04MB5254:
x-microsoft-antispam-prvs: <BYAPR04MB52540B00DBC2ECFD55B72297E7DA0@BYAPR04MB5254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(51444003)(478600001)(3846002)(9686003)(6116002)(4326008)(66946007)(66476007)(66446008)(66556008)(68736007)(6436002)(81166006)(64756008)(26005)(81156014)(6246003)(76116006)(71190400001)(55016002)(186003)(53936002)(7736002)(486006)(8676002)(74316002)(71200400001)(33656002)(52536014)(476003)(102836004)(76176011)(5660300002)(229853002)(7696005)(446003)(53546011)(6506007)(316002)(110136005)(66066001)(86362001)(2906002)(14454004)(256004)(8936002)(305945005)(25786009)(54906003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5254;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2mj1MXHhKWLV5+SfCHOm12GoyGTWXmJ4Q52PRl9EmlQ45JB7srQ1hfzEfmhy22+G1fLaG7TFr6aRRz+VZoTEthSJn+BIjNsVbM0UnZDLQl3YePLB64ljTQKc8GQ5drtwepY95uDItU8jY7EAGP11nxnK6SCVpx+Dq/s7voPtgQNutqw2AnHCUHcSVPycP6NWQdVUAePPXdDYsWt3QQlt5hYufNsy/v8wmlisNyQTmPhG4VpPFxA2RhfDBnp1lDncO5kyMTWgZG3TbN6BjdhjQfJX2WNlYjfXpEFRiXx9L98XKf7P2HSnzpjOGweRtWtvI/a3SBO2d1tmJ9J5gMaQ18EfQJGkU51r+WiZEPBLvcQBShOLR2wHMrSOB2NursgYmvojknFVeawKyXxzJFjTxWE90nf4yi9BGQnwiJF6bUU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc74661b-6b66-4ff4-e28b-08d719f01f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 21:59:00.7717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5254
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/06 6:28, Jens Axboe wrote:=0A=
> On 8/5/19 2:27 PM, Damien Le Moal wrote:=0A=
>> On 2019/08/06 6:26, Jens Axboe wrote:=0A=
>>>> In any case, looking again at this code, it looks like there is a=0A=
>>>> problem with dio->size being incremented early, even for fragments=0A=
>>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in=0A=
>>>> blkdev_bio_end_io(). So an incorrect size can be reported to user=0A=
>>>> space in that case on completion (e.g. large asynchronous no-wait dio=
=0A=
>>>> that cannot be issued in one go).=0A=
>>>>=0A=
>>>> So maybe something like this ? (completely untested)=0A=
>>>=0A=
>>> I think that looks pretty good, I like not double accounting with=0A=
>>> this_size and dio->size, and we retain the old style ordering for the=
=0A=
>>> ret value.=0A=
>>=0A=
>> Do you want a proper patch with real testing backup ? I can send that=0A=
>> later today.=0A=
> =0A=
> Yeah that'd be great, I like your approach better.=0A=
> =0A=
=0A=
Looking again, I think this is not it yet: dio->size is being referenced af=
ter=0A=
submit_bio(), so blkdev_bio_end_io() may see the old value if the bio compl=
etes=0A=
before dio->size increment. So the use-after-free is still there. And since=
=0A=
blkdev_bio_end_io() processes completion to user space only when dio->ref=
=0A=
becomes 0, adding an atomic_inc/dec(&dio->ref) over the loop would not help=
 and=0A=
does not cover the single BIO case. Any idea how to address this one ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
