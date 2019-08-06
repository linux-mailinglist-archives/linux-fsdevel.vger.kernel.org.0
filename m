Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBBD830B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfHFLcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 07:32:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10129 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfHFLcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565091143; x=1596627143;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eJKpsHb0zJGjVTgnDwyeUewbFbtThbtUk7pRowtdDXM=;
  b=MGV5pEg2F0IJsHOzobU4DrvVb1bLXbZEjsr4s/jRcYfbgcWMaX+i+rZP
   wY8FNU7d5HfqFWyPCs7nQBxJHv6Yc3LVU95eOo5NmJ3nXf8bwb/9Dj31L
   QTo9UK9GkYV67U1PEO/hHvNQDf9+9rGiupN2ldZz5s3mX+A08vIHx1/jW
   qBOfSA3aSkIfZBXw8CyA8CGZqSwQYvtAa3Zzv1ggA4wj1MR6MFkXnxkRP
   6/M8JoS/g9Y/QYaPWNuQc//OZv0oUMSYgBaKdAwTxhVAqRtmrpJgvbDNe
   60uF+IIgB+mkzLnN+bwOdMdE28wti/khRFqKMqph9xXgJ3V3GmaiNOlqb
   A==;
IronPort-SDR: sPg6Q/rGfrINq8epTZoY49wrI5MMuTltFzuUjCCTT1RUNk8H5hJ0Ax6V9v3tS6yKdFl3W8k9d8
 5Y+wlsI5ph0qtVCTvRQS6w7HlkDqQy2sr2sX8nktviGPQsK6kEyBDzWxX2mLM3omruCDd0Q7MD
 kFkYvHy/TDCdWl2MmkAUIH3czLukBg5sGYKeMvriB8KeNkqSF66d5c1DeeHqXQkAgKzrbOrXSv
 /VNp3AsAXkdmwSKXoz9wDTG3YvmTbx9mHIZt1T/ts0RIV9n2KSb9GjM0xJNWZ9y/swTgac7URg
 /HU=
X-IronPort-AV: E=Sophos;i="5.64,353,1559491200"; 
   d="scan'208";a="115115847"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 19:32:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIpq/WIHnWgck8BaR0+syNAORzU1+Wu60n5htP1Ojr6oVyHnMo5ij5ZZt765UV4iCOZooYPFPj3lXqyE42IeH9pwhdQfJ2mqiBr0NYVAYQ4dlF8E1eJZHZDQaWrrE6NCM61n+WjpjgUu1pmyVxNFsttPLH0dAV7YErt+lTlJ2evHrss42OP7SQQ4PoOyGEyONEQupoeVZID3t4Z+6YpIoezgMfoz8MQIJX8eeGBGTkl5kcFSNw7MOGKHU/pDERG61lZUAaHGWiKE4+NvBTl8ACOz0X7oQk0tYJK9t1HIrHk0sxHDtFIVPAGMk6u+dLKGP1ruTpXhZThX4byt7c7Iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxb/OQaChj1W0oumlZviea9tdMPw08U1Y3T7T29EllQ=;
 b=PANtROc80fY0jU9CLqiDyCGx7Hi/2EEveE1gZtv5D0ETtviBXkwhBnUHyxogZ7F17h5yO8n5vAmUTloiaH7HQc5wcVocXIHyV4KLQ8QhxnrZaYc2v4Hq1cO7vnYZm2R6u6bc6gWSVqcPrG5Jidtkp9Tm5I0rmLmOfKshkVpgnyO9KDS1ZxgXvGzoh52UhX9jtNxZp+gCk8Lu1zDu+V6+K5cUXLrKUjUK4hZxr1tZ2M08tkFMhH0h7Ucl9XUE7SlmpT2uIjvTp64rDIbRy+l/3rCdSCkYgQLZJBgiYEpkVU89R/UcCxnB6xzve1MQZXBZ+yTYMlK20HaCpmgwQDLZAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxb/OQaChj1W0oumlZviea9tdMPw08U1Y3T7T29EllQ=;
 b=FGN8C/ODDdcL20PWgvm7EmXT0GJG5nfKBGPFfrq9gPj+60lT/HAU2OEwOvoV7NxMy2K1cw03UHmhBBL0uQz48v+kvKSV7eJUAYMLk83jh2jSgVKL/n4lPByGpxId6ZbK2a/wDcpcBR21AU5ozVnpzYQLa6Lz31I+dcqLvAW3ZeE=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4694.namprd04.prod.outlook.com (52.135.240.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 11:32:21 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 11:32:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Tue, 6 Aug 2019 11:32:21 +0000
Message-ID: <BYAPR04MB5816841E346E2FAA6A8ED7E2E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
 <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <f3f98663-8f92-c933-c7c0-8db6635e6112@kernel.dk>
 <BYAPR04MB581644536C6EAEA36E3B4912E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816C7D04915AF7B656F900BE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816D1AB6B586FAD664F8D79E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190806002353.GC7777@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f03846f7-6e17-49f6-fb21-08d71a61bef5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4694;
x-ms-traffictypediagnostic: BYAPR04MB4694:
x-microsoft-antispam-prvs: <BYAPR04MB4694F2372620E96E1B29FCAAE7D50@BYAPR04MB4694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(199004)(189003)(51444003)(52536014)(53936002)(478600001)(6436002)(55016002)(102836004)(3846002)(71190400001)(6116002)(71200400001)(81156014)(81166006)(33656002)(74316002)(7736002)(9686003)(53546011)(66446008)(8676002)(229853002)(2906002)(305945005)(66476007)(66556008)(64756008)(66946007)(476003)(256004)(14454004)(446003)(66066001)(54906003)(4326008)(7696005)(86362001)(486006)(6506007)(25786009)(76116006)(68736007)(6916009)(186003)(8936002)(5660300002)(76176011)(316002)(6246003)(26005)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4694;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6AjV2O9amoTNeLV5i3d7/FTeXRSc3yKdktcGjPt4tT6d1/4diRsbimefCnxPBcdZCqnKv9d8C8EvGFJdDvIWI6g9xFWw9/TaCMOysq0smg4i2hcZyw3mo6dGtFrPIVmYGcO+k1eCv/dpna4eOX89KPM18tHRx+g2b3IC+iPC8rR60eSK1WP/1J9nr3KFGP7FABHEertsS1JekEzWMkRV0Dof0CdcqmcaCGRlA1u8B18NqYusE7z6hZTmrModhStvPfNVJs19GNIpf40Q5o0QQkvXH9iSP34JsUD1lrOMg2HSCYRNFMmh0tJpHJ4rm9CUn1hSOJRtfxyIk+vYc/sQrHrE6iQ7ud5NT1j57XWF0zqn9Ntk7KyAiSEoc4rPcsqS10S3BZda3tx2X62Y8B8jkQQWHt77exc5dRFeawPsz9s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03846f7-6e17-49f6-fb21-08d71a61bef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 11:32:21.3066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4694
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/06 9:25, Dave Chinner wrote:=0A=
> On Tue, Aug 06, 2019 at 12:05:51AM +0000, Damien Le Moal wrote:=0A=
>> On 2019/08/06 7:05, Damien Le Moal wrote:=0A=
>>> On 2019/08/06 6:59, Damien Le Moal wrote:=0A=
>>>> On 2019/08/06 6:28, Jens Axboe wrote:=0A=
>>>>> On 8/5/19 2:27 PM, Damien Le Moal wrote:=0A=
>>>>>> On 2019/08/06 6:26, Jens Axboe wrote:=0A=
>>>>>>>> In any case, looking again at this code, it looks like there is a=
=0A=
>>>>>>>> problem with dio->size being incremented early, even for fragments=
=0A=
>>>>>>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in=0A=
>>>>>>>> blkdev_bio_end_io(). So an incorrect size can be reported to user=
=0A=
>>>>>>>> space in that case on completion (e.g. large asynchronous no-wait =
dio=0A=
>>>>>>>> that cannot be issued in one go).=0A=
>>>>>>>>=0A=
>>>>>>>> So maybe something like this ? (completely untested)=0A=
>>>>>>>=0A=
>>>>>>> I think that looks pretty good, I like not double accounting with=
=0A=
>>>>>>> this_size and dio->size, and we retain the old style ordering for t=
he=0A=
>>>>>>> ret value.=0A=
>>>>>>=0A=
>>>>>> Do you want a proper patch with real testing backup ? I can send tha=
t=0A=
>>>>>> later today.=0A=
>>>>>=0A=
>>>>> Yeah that'd be great, I like your approach better.=0A=
>>>>>=0A=
>>>>=0A=
>>>> Looking again, I think this is not it yet: dio->size is being referenc=
ed after=0A=
>>>> submit_bio(), so blkdev_bio_end_io() may see the old value if the bio =
completes=0A=
>>>> before dio->size increment. So the use-after-free is still there. And =
since=0A=
>>>> blkdev_bio_end_io() processes completion to user space only when dio->=
ref=0A=
>>>> becomes 0, adding an atomic_inc/dec(&dio->ref) over the loop would not=
 help and=0A=
>>>> does not cover the single BIO case. Any idea how to address this one ?=
=0A=
>>>>=0A=
>>>=0A=
>>> May be add a bio_get/put() over the 2 places that do submit_bio() would=
 work,=0A=
>>> for all cases (single/multi BIO, sync & async). E.g.:=0A=
>>>=0A=
>>> +                       bio_get(bio);=0A=
>>>                         qc =3D submit_bio(bio);=0A=
>>>                         if (qc =3D=3D BLK_QC_T_EAGAIN) {=0A=
>>>                                 if (!dio->size)=0A=
>>>                                         ret =3D -EAGAIN;=0A=
>>> +                               bio_put(bio);=0A=
>>>                                 goto error;=0A=
>>>                         }=0A=
>>>                         dio->size +=3D bio_size;=0A=
>>> +                       bio_put(bio);=0A=
>>>=0A=
>>> Thoughts ?=0A=
>>>=0A=
>>=0A=
>> That does not work since the reference to dio->size in blkdev_bio_end_io=
()=0A=
>> depends on atomic_dec_and_test(&dio->ref) which counts the BIO fragments=
 for the=0A=
>> dio (+1 for async multi-bio case). So completion of the last bio can sti=
ll=0A=
>> reference the old value of dio->size.=0A=
> =0A=
> Didn't we fix this same use-after-free in iomap_dio_rw() in commit=0A=
> 4ea899ead278 ("iomap: fix a use after free in iomap_dio_rw")?=0A=
=0A=
Not so similar in this case with raw block device dio. But I will look more=
 into=0A=
it for inspiration. Thank you for the pointer.=0A=
=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Dave.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
