Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE58274E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 00:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfHEWFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 18:05:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38111 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfHEWFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565042746; x=1596578746;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+QQj5AHS8MtCsHuZ1neGTnTBcyATll2y2SjS2ORs+pk=;
  b=qtpplYL1QL3XSlM7WnG3jObKkQjAYKvioA/fWOejN904ViA3362/ErfP
   chpyNyGp0OR/xotbY02GnE9+fRgLw3iu1Nt2XCGdy+v1AMDhcJKBT80ME
   0SKd71ua4ItEIZVArc0qKWXVmkI8vApsNI7o/jOLOYTz3Hzg8lXzhgDqR
   VbrK/h3HZUasU0j3WcPE9ixrOlTYoWcUnEtpfM0kOpV9scb/dqm/OMf5y
   30ud/nRioYB35vmKGkDEudNMZACt+SDNVuiUvUwlvQIsxVS/cl7X98DZQ
   DZJvTa49nBPEMyZws+x7YjXgYvqBLOrh/lzEGoPhZ8IztX1k/rAoavAcU
   g==;
IronPort-SDR: 5ot5zhRVy+hMfOuKh0apCb7vldmIkw0WZlSifplkF+R0ZKRGjva/QRfUEp/qIgmPIAwrIYQsiM
 usRvAOGyDYNLAi5wLvoQrsLIxgsly/Q3x8WC8zrILDrgaFcD4IAZA7qLW06Bvn7IPEaBFHhjHj
 qkh/301F+IkOIUMh7ZXDl0s1ZnNbucz/TWfEyAL0UUQWIVGd5fjrYvjZfsgC8U8Ho2jSG+jyTo
 HfEFCH8rzxsv0UVRHaXY3X60YgOLnnlmu6pmjhZS5hFbsJEGNYoxDafrUHBalWJnMo5ZIWRcPe
 9pc=
X-IronPort-AV: E=Sophos;i="5.64,350,1559491200"; 
   d="scan'208";a="116036933"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 06:05:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdJyVpbc2ixAsVRigoX6i9UN6ywmnReXpgQdi1SMPAnqllPKI6JBJJCI2eQpoMdldJPycQgkm/HT0WqsLstXpaIYYiVJt46JpT/+vJSlNk02By90ixhoAa8+eXaXTQIYpcNaGCINSIQAbg/BwkN86kPiW8uO39v8HxPRIq6+YbtpIZZueBP5dZg27Nh0XL1JmVtVtHDjvNAg6ra35EueBwBuzQ8N9PJkwU3VFYaOio44Ft5v6/+pGNWRrJGExGJBCYYsq0lBf+MFuAUcd4vKq9fO6z+eAGTUMA0rf5AokNu2QOSNT2j23OF2xGhSP9yZ95Jt1G9c+Q9rEUntylcChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/gQ3r4V5TFugDTQThFClhHVupW3YK05U1XEgO3mrZc=;
 b=HmoDKaUlaeX+oPwKhXbEFOK89IXr7VcZItUFQIN+RUjTExXR1wqAZPBdcQwSlQXGto33DbP6RBrC9D2VGW8rDVQ8MXeW3zund3VtaMURbq5I7F8Sv0YgQDOr2scBQ7SFxaa3sPEm2yUX+YkH9NNJna2fIo/M8kHCFEJwoupWsVLbG1tx8OqeQ5QwTxAW01paDP3zyBOAUiVkYsf6Jo+Oq/bhPiOMDaYkdOb24vjCEd8ZFbkREGGodXzbTzqjpbk+k34Tw9+4P8i2TaQbxn0Z1GyDDGAfba+t5sgX02mbE8fvs3H98TBaKgykZ4fGOhrR0uJMZPx/0PocP3QdmycVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/gQ3r4V5TFugDTQThFClhHVupW3YK05U1XEgO3mrZc=;
 b=0FDTjqjhjlWwDShX7oczbRG3iHu2eLbO7BJPXLKmVXJ+4TQbgT7PrOdD584bEXEDzTnyyaQmJl+YkkIjO5n+6S9StrudJF7WZ/tTz0OTbOQXqykTSl3r8TyXJ38ejZF3PbODU6iJKhbeIRZPtzRNVAJfwBXM01qZtBm0KdyGUS8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5672.namprd04.prod.outlook.com (20.179.57.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 22:05:44 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 22:05:44 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Mon, 5 Aug 2019 22:05:44 +0000
Message-ID: <BYAPR04MB5816C7D04915AF7B656F900BE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
 <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <f3f98663-8f92-c933-c7c0-8db6635e6112@kernel.dk>
 <BYAPR04MB581644536C6EAEA36E3B4912E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df86536c-10b4-4356-c61d-08d719f11039
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5672;
x-ms-traffictypediagnostic: BYAPR04MB5672:
x-microsoft-antispam-prvs: <BYAPR04MB56722036D2CF15BF2D6E6DD1E7DA0@BYAPR04MB5672.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(51444003)(68736007)(8936002)(102836004)(53546011)(76176011)(186003)(26005)(33656002)(6506007)(81166006)(81156014)(8676002)(486006)(446003)(7736002)(256004)(305945005)(6116002)(110136005)(99286004)(54906003)(476003)(7696005)(5660300002)(14454004)(3846002)(71200400001)(2906002)(71190400001)(52536014)(66476007)(66556008)(64756008)(66446008)(74316002)(76116006)(66946007)(316002)(25786009)(6246003)(478600001)(229853002)(4326008)(86362001)(66066001)(9686003)(6436002)(55016002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5672;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cSL7FxL2hKKN3GiZ+rGzeq+ZC29PcKc/R1w3tnxKyotQNu0lw0VN1zRoYVlYHQ5LdeVTItdNjto5pQ0+u59xEB6vY+K7JoJ4f1ruJPNzfxGJ02UAyv+GRipaX1NdMzw6DiGicA9TWW70hb4tyIwa+I+tjwL6hSD866f2opKtUcQaLi98ev8emEAO7NQ92K8zOe4PIPvATHQ/9qbqTlf3BPOEOEgh2vZjdtzAqSr+rTRbkbjNVUw0M25UNc9FAHr/+rWIp/A9cvSw8nzu1Hb0EbF7wji8IFPQxvYiIGJJGZSSo/z/5T7wCq75+/QtH4uUD0FstHwxZphQRu4nuG9Vy8cKwwiXcbJsyHG0ljhg3NnupvuJbHqhS4E3ArN7wn3b6VbL3dnZN80MH11KHFnU5VTGnBcBg/iEbUxemxa3v2E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df86536c-10b4-4356-c61d-08d719f11039
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 22:05:44.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5672
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/06 6:59, Damien Le Moal wrote:=0A=
> On 2019/08/06 6:28, Jens Axboe wrote:=0A=
>> On 8/5/19 2:27 PM, Damien Le Moal wrote:=0A=
>>> On 2019/08/06 6:26, Jens Axboe wrote:=0A=
>>>>> In any case, looking again at this code, it looks like there is a=0A=
>>>>> problem with dio->size being incremented early, even for fragments=0A=
>>>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in=0A=
>>>>> blkdev_bio_end_io(). So an incorrect size can be reported to user=0A=
>>>>> space in that case on completion (e.g. large asynchronous no-wait dio=
=0A=
>>>>> that cannot be issued in one go).=0A=
>>>>>=0A=
>>>>> So maybe something like this ? (completely untested)=0A=
>>>>=0A=
>>>> I think that looks pretty good, I like not double accounting with=0A=
>>>> this_size and dio->size, and we retain the old style ordering for the=
=0A=
>>>> ret value.=0A=
>>>=0A=
>>> Do you want a proper patch with real testing backup ? I can send that=
=0A=
>>> later today.=0A=
>>=0A=
>> Yeah that'd be great, I like your approach better.=0A=
>>=0A=
> =0A=
> Looking again, I think this is not it yet: dio->size is being referenced =
after=0A=
> submit_bio(), so blkdev_bio_end_io() may see the old value if the bio com=
pletes=0A=
> before dio->size increment. So the use-after-free is still there. And sin=
ce=0A=
> blkdev_bio_end_io() processes completion to user space only when dio->ref=
=0A=
> becomes 0, adding an atomic_inc/dec(&dio->ref) over the loop would not he=
lp and=0A=
> does not cover the single BIO case. Any idea how to address this one ?=0A=
> =0A=
=0A=
May be add a bio_get/put() over the 2 places that do submit_bio() would wor=
k,=0A=
for all cases (single/multi BIO, sync & async). E.g.:=0A=
=0A=
+                       bio_get(bio);=0A=
                        qc =3D submit_bio(bio);=0A=
                        if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
                                if (!dio->size)=0A=
                                        ret =3D -EAGAIN;=0A=
+                               bio_put(bio);=0A=
                                goto error;=0A=
                        }=0A=
                        dio->size +=3D bio_size;=0A=
+                       bio_put(bio);=0A=
=0A=
Thoughts ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
