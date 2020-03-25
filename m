Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853871922C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYIdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 04:33:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43043 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgCYIdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585125201; x=1616661201;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OR8AWCPNs/a04ZjLN6mDCHtkVXNnDjUNNq6r+Y5r3XA=;
  b=I601pFaE3/SKLR099xdPC6bKLhgdVukBMiFsiINLl0gMwdgLjLRul6Fg
   h+5GUmEhrbP+/CFtA+uIf57NScSh0cKy6Vzgg2YC/vD9UuKdBpJ2oeHTN
   dzojgvy6cHATSyajc1h8Y3hbQu44a5iay/8T6NJg8lGKXI1CGGg8Zs43F
   TUae0//7+dFEcSS3E+C49eBt4Rx8j4/FwiSsz64F/bJKr7NWTEDmmc/dG
   DrVtUQmsr632Y0wu0Xyn5w8qG4/ZUvykskLlufyOZk8AgWK39B/rVIseO
   2PgW650OqIRIOsKGgz+dzrQuRBtSZJAsybCNf8YkBWbyuNXUVlcxngcov
   Q==;
IronPort-SDR: 5HwhMiOBPPajyBzZB7l3A3W+FzA/owNZHRYJNzIsfV4IN5Wt6gCZnYVZ7iMs1KnrLHYxaOiaqg
 LZN67DFOe+gcpw3L/9x0ojEDEtlnprt9k9S2Pglgj7G6vhYPMo0fkLN5+mAzS4CMxz9K5evfI8
 glznXSgkJUTrnMUce6QciJpF15Z71wihzQUv6Wgq8ehjWlq7APCsUxMS2nZ+Q4Q7A2Q6OU/Hv3
 bXe2qkgYA82tAOKS7tPXNums862AO4jo2jgHC+b3wBNOjmynqdBFM2BkFYsx7vo8fAqJ8cv5Jq
 fBE=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="235673278"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 16:33:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7//09IforcP32C8bWXKREkMRxCP2iOYDQH9/FOLf6+2K+oDoJazlzLItx/jiKPcvMKevv0DgmnpsZ6w/OYDTWKcC7rjhohPa4RQvccLGhNLAmQ6UE9AFA0aUH9/PO+NwPNH7SYm1QQhcEekZwYP5ZQ+li1kqXYnc81Yjt6ro8iS+P/C+zx+AmfW1VbeViSvr1r0JNkLlQy+GS5SQsPlFr4qYoMocbkYYdB+WYXd61wYyhkLT4TQhL7L4RBp2iwb88NiLpQNyx0FFFQJcCkrhn4TntxTMfgxdYyZv0Sf1RmQaxWrDoEm0AKl+Oh5RShd1yX8vnoYAm+Lj+URuEwbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lU9Wv/uEfTyig5EyfdFH5Wk8vte7YmiGhXNgc8OO98=;
 b=R/jpdyqu3RIIoztvXCluaRWzwP93d8UHrhThESuWb7MiMkf0cL7FxVgxe+o4d+RhAQE+o5YHK4KmVU+2zguGvQhPmR+Ilm/Tiv6lhJzthkTgjXmV9Q6KOgWFKVSIuz6IAxpBjNQg33m7Hb9LtYI1sMJlzUoIMyZL1A4Tly+S40fm2P6sMomwSWme8HBmYpa5KGsRrLk7q1yldA0PY80bBkuMn6eBtZRzY7w2hNAOhTEHHjTtYx6oS9pGp7jy484vHQOTl6rUrGeI9Y28HvjNR/ADTeDyg+kZtngxV9XOFegMTCeIU4nh6s2jPEiAIZpB2i8dh71eUt3WKuJdEn9kzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lU9Wv/uEfTyig5EyfdFH5Wk8vte7YmiGhXNgc8OO98=;
 b=zikubOFQ5JBehIXlPlOI2chmKwr2nkYGYXP6v8Q3QeBGi1JIU8JYq024vwyEBiYjxIsZ2zM/wsDb8JUE+slDuUpFk+mlQGorQzW8H4L4sU+gAaY//DPZaTGywi2XMrj9+/94dxf1ctjpTRgXaBdFDyqXkYA/0zjAQk3F06ZCVAo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3550.namprd04.prod.outlook.com
 (2603:10b6:803:46::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 08:32:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2835.017; Wed, 25 Mar 2020
 08:32:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Topic: [PATCH v2 10/11] iomap: Add support for zone append writes
Thread-Index: AQHWAfBwrmUQROWSvUa2jUG+SCcnLQ==
Date:   Wed, 25 Mar 2020 08:32:53 +0000
Message-ID: <SN4PR0401MB35982EA38F8E0485AD1E5AE89BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324224552.GI10737@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bc1d4b9-cb64-4879-ca99-08d7d0971cca
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3550A80E60F1869A4D6D41D69BCE0@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(8936002)(71200400001)(66476007)(66556008)(76116006)(64756008)(33656002)(66446008)(4326008)(66946007)(186003)(86362001)(91956017)(9686003)(55016002)(316002)(2906002)(26005)(5660300002)(7696005)(52536014)(6916009)(8676002)(478600001)(81156014)(54906003)(53546011)(6506007)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3550;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ErHmjT/vxDQs0UlTyoNeVWNiC/YszDqugmaTduCk4hUrnvDeAxVTxRZc9hgOXANITcoqlydrA7mCdQjIhcDkHGbEDtUMyUJLydyLRf2khRnoTlLIsBBl2QmuYhIaPfSiTt7Z6Zy/pRdXB+pCpN3aqDzWnaBaRZlCqr6CfGDNqfppBnJf4s/9d2R1hq06xYZs87czwKhLNCmAm8Md+BdoMz+nr1l+hf8C5GKxqj1OH3X7/FFrX8ZZUy4PGcXWvwPGFVIzyKPY1rCwJDhUHS5Ijq2suqOeMBQ/FhMi7CtENbkgOiGKSE1uYlm5wclK9SWc8G5JiumG696BVmnAtMOH+oywLpESvgtQGO0bl7eH8jrZ7sGKtPFBYCx8u1hC/4sxDdUjK89BMowYahBZvJMCcltl/bV0qxXyPiCVEqmdHZAAT8MRiGS/rx9NWjmtkbNZ
x-ms-exchange-antispam-messagedata: iavwLV+SD5oPKMrsUDPSfzzX6FptdUAC+33yoG1GlRKS61CqW+kQvSxMvSwWkqkUu91gxTLGNs9Bh2FLA81ip4y7b3L8GgMu4hvcdJJ6/R7Y7rICCQxIEl/Ankch3wxsf4QUwhW5nFer9Zvt2eNXyA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc1d4b9-cb64-4879-ca99-08d7d0971cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 08:32:53.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62Xu/XCZQkbLucS3rarmruCuWtlzt8jJ1B1O3IcFjIO4cZNR5d2lhwJYTFgKpQxB+scm7AJLYrX37tlZHOLdpJZ3lUNJCYaxz5m8gDFmA+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/03/2020 23:46, Dave Chinner wrote:=0A=
>> @@ -266,12 +290,28 @@ iomap_dio_bio_actor(struct inode *inode, loff_t po=
s, loff_t length,=0A=
>>   =0A=
>>   		bio =3D bio_alloc(GFP_KERNEL, nr_pages);=0A=
>>   		bio_set_dev(bio, iomap->bdev);=0A=
>> -		bio->bi_iter.bi_sector =3D iomap_sector(iomap, pos);=0A=
>> +		bio->bi_iter.bi_sector =3D iomap_dio_bio_sector(dio, iomap, pos);=0A=
>>   		bio->bi_write_hint =3D dio->iocb->ki_hint;=0A=
>>   		bio->bi_ioprio =3D dio->iocb->ki_ioprio;=0A=
>>   		bio->bi_private =3D dio;=0A=
>>   		bio->bi_end_io =3D iomap_dio_bio_end_io;=0A=
>>   =0A=
>> +		if (dio->flags & IOMAP_DIO_WRITE) {=0A=
>> +			bio->bi_opf =3D REQ_SYNC | REQ_IDLE;=0A=
>> +			if (zone_append)=0A=
>> +				bio->bi_opf |=3D REQ_OP_ZONE_APPEND;=0A=
>> +			else=0A=
>> +				bio->bi_opf |=3D REQ_OP_WRITE;=0A=
>> +			if (use_fua)=0A=
>> +				bio->bi_opf |=3D REQ_FUA;=0A=
>> +			else=0A=
>> +				dio->flags &=3D ~IOMAP_DIO_WRITE_FUA;=0A=
>> +		} else {=0A=
>> +			bio->bi_opf =3D REQ_OP_READ;=0A=
>> +			if (dio->flags & IOMAP_DIO_DIRTY)=0A=
>> +				bio_set_pages_dirty(bio);=0A=
>> +		}=0A=
> Why move all this code? If it's needed, please split it into a=0A=
> separate patchi to separate it from the new functionality...=0A=
> =0A=
=0A=
The code is moved as bio_iov_iter_get_pages() needs the correct bi_opf =0A=
set for zone append to be able to check the limits (see patch 03/11, =0A=
block: Introduce REQ_OP_ZONE_APPEND in this series).=0A=
=0A=
The call chain is:=0A=
bio_iov_iter_get_pages()=0A=
`-> bio_iov_iter_get_pages()=0A=
     `-> bio_full()=0A=
         `-> bio_can_zone_append()=0A=
=0A=
I'm not sure if separating this movement would make it clearer, apart =0A=
from a commit message?=0A=
