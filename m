Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1331E3E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 02:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBRB32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 20:29:28 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56299 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhBRB30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 20:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613611765; x=1645147765;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9qH2YcBXObP3U7J9syAbJhGF6oEFdit3Uuies5zV6L0=;
  b=ktamL3gXCQpBp01M8ku8x9LGdatA5J/C4xvH7jWSNjYIuNBCWh1da9j0
   xq0vja3z2ttDRKmrq/FAkUc0weRlMtsDVx0nbholVeMJJiLzik0TpjtEB
   ZyJu83JT15yfIW24FJhM0BIAgLj6MAxveYNCdmqw8JIORzNCq1ow7kslN
   Qk3eDf6gPQu10xv3R80MEZn/IgxpJdmHldVwvGhJAc4AKF+HpTlxumh3g
   8RG9k/oPRPuUqvhv7yx+/ohSfbHUxjwPxuOOPAxcnVizyS+moyiZmrkM4
   +BxaRzafpONVaOA7HZuXrjmL6RL2CindiWAk4KbHqgAR+C+wc3oB1PITf
   w==;
IronPort-SDR: 4M88/9R/M4HR78hDDgozsqeLNcrKDcQhQIJmP9TXkmbtTPL6yPoZ1bM7xqHkXXxRFDDdTwigus
 mX5gd0CwlopugYCRTtOHQJopUAAsTISKaYaw4apfQyBsiluX3a4Rjf7VpS2Lf3x7MzVjK/nTdx
 djmGlB7C12dt0Rta8wMbhG6TZWfwu4HmiE1uxo6qqVm89CyfifeWMzkq23vWWRp6oFDDG6pKxJ
 IGK+ZbjuTPsRQYy55cOH0fLinw9UoYX1CD67RhnSXlGc+WYIAKau3aAnc6EaAEKVzmR4RuLma5
 7b0=
X-IronPort-AV: E=Sophos;i="5.81,185,1610380800"; 
   d="scan'208";a="160235283"
Received: from mail-bn8nam08lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 09:28:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsvHQavf7uNlQ8d/3oXOF87+GvxVIS7rl+xPiEGXnHP+bBUzAqaNm79hvp6eEOelgsqnMdrw+/UPYXBqUqOTa5pnRU4tFNgDa9nLm4urO01I3oavRBVKe/vBSZY0cmZCNUfeMdAy448tzUkbPFZ+HA0L678ORN689HKD3GlNknbjj/aa/inu26GRcHgxm6ZoaTp4vnJIX0csxabEjE6nXT7No/iQFEwefWDC2u9zDR33iE8JiBL/QdUGhtOfICUkWaWMVhHbQwy1/JhuPajet2bj67dnvUlXiTo9kDSgmRpWiIUCJN5wOqA3M1VNKsXEe2jfnCtxL0fSMYuJw4vVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVXbQhzjMljenFFGdNZDlx1QlYnqBP6C3iQWXjZAeDQ=;
 b=D5Ytc/df2DjxEIjW1QryLJ4PGUbnB4Ea3TV4TMBIJJe8DPrtS7/fCrYYQqqU4ssKhfL6DXKyI+ZNIR6LwOebIgPjxKUsjt0VplzRsXrmumld0mbBvENF/awZ15Ok/IV6/9F9mTCXij7K1iD7W+Z0sFanabFIx+4VFlXzVHtIjaNPcKGT03ZluX8jLrza9njERNtaKgX2RI3q74SGBrf4x8krmb/G7SmtLcmpf9Z+p8jh5zsmy03qoXUJFM7u3O4PUmydrU65J49EK9YrYeUvGRQPEtmB28UyPJfcA10fq1voUzC4x1k0u63AqIPz8W0Gv9XhFgSoMRGCHlVRMjeeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVXbQhzjMljenFFGdNZDlx1QlYnqBP6C3iQWXjZAeDQ=;
 b=iMEzjUgowwL4XBlFMbTYGFc9RSs3LvDC4WW6RrbatNzS7M+z+PyPrjOSGE6fAOGm592UnzFD8A7h93qDIuXnq9uKDUbExBwysGUd8rs6aYwe7pKW6YjBYZL8YQshg3SnC3pqPIF1BU1dXdY1nP0og2xoM8Xmxfh5ANKbKh/4HrE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4759.namprd04.prod.outlook.com (2603:10b6:a03:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Thu, 18 Feb
 2021 01:28:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 01:28:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "shaggy@kernel.org" <shaggy@kernel.org>,
        "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "jth@kernel.org" <jth@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hare@suse.de" <hare@suse.de>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "alex.shi@linux.alibaba.com" <alex.shi@linux.alibaba.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>, "osandov@fb.com" <osandov@fb.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>
Subject: Re: [RFC PATCH 29/34] power/swap: use bio_new in hib_submit_io
Thread-Topic: [RFC PATCH 29/34] power/swap: use bio_new in hib_submit_io
Thread-Index: AQHW9UVtzcRBxm47UEq6Z+ZGJ3C99A==
Date:   Thu, 18 Feb 2021 01:28:03 +0000
Message-ID: <BYAPR04MB49652FAADFDCAA3DF72DDEE186859@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
 <20210128071133.60335-30-chaitanya.kulkarni@wdc.com>
 <20210217220257.GA10791@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ucw.cz; dkim=none (message not signed)
 header.d=none;ucw.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06721654-7df7-4cf0-a01b-08d8d3ac6fd8
x-ms-traffictypediagnostic: BYAPR04MB4759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB475955F370F81E8B007520E886859@BYAPR04MB4759.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RcRwgz6IM2A/u/TWxloQlzmC7jpW7IdpwapwE2srZFbILm7vBO1dKGMJs5xJorby8uToHqvtIxmTesokOK2N67DDeAojN22PAHvdQmSqNaSTDLBzH2qMKpFV1+WzWIVjxYMdCnh4jbF3SPjmDqwN/yIYFDFyk1EwDVJOfFLLMnaVxJAscRAP1ZFSZCNBzbges1ZNat9Mh1a+bsGirLXNwdSp2Afj7WrLg+DqkEDznkumbqbojWv2cikOO/w0aDpnRPnXREJ+NQdYMomG/M/yAnArKOyCvjTCoBmEv3pXZZerNQ1l33hI6zSUNjzJcTlPZ2+8e2cI2VO0+TzZ/hOuxZ06W2eFjAmeVDqVAaTFUCCfPrlmFghyrFtQzTvLF3BAta6ZiKq6LdIOocMNcqDB7SvM+Vy8jGmeQRmHkzsdJBhthIkjCGU/2Ujs3bqZtAIGKXyX+QheehpSxQ7dv8hPsjXXDBRnon9r6T5eMc3v1712HMeHqbj4g63qCPkU2S/O4NB5wD8r4YmNhCQ8vmr6qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(6916009)(33656002)(2906002)(55016002)(5660300002)(7406005)(9686003)(8676002)(4326008)(86362001)(8936002)(478600001)(71200400001)(7366002)(316002)(186003)(7416002)(52536014)(54906003)(76116006)(66556008)(66946007)(64756008)(7696005)(53546011)(6506007)(66446008)(66476007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FIItwhJNoqlHqrXr7ohF0LCXk2DS0EdG1yLZV0Z4VhMmvaysA9SgTmrClqIG?=
 =?us-ascii?Q?H3mrueUZG2rfqbYjvGN1Y1jpOkrI0tSChqG3PmuxYoz9EC8+CqA2NMt8YiG0?=
 =?us-ascii?Q?avib5faAAruYFRaTRBrtOZqj5Kae+D1MvohlzKuTpITQC0MUwI3xYA7RkXrc?=
 =?us-ascii?Q?sgn3HFfoZar+Qd1DoDBCAFo7j8O/MTD5eZZo9pgTs5AtwYk1hYbuFqmFZlpl?=
 =?us-ascii?Q?bSWSn/tV9sXNp9d/FpFzxvANMuy2h0Z4koAntonbxCVQWy4RXgZuCfKx8ihl?=
 =?us-ascii?Q?8ITpSwYLWRPvHfIrYc71WuBsdFzfr/s7nQZKVj5B6Oc/989Pk5sDFQTMhl8s?=
 =?us-ascii?Q?8d+5CSeJfjq/AR24QEulThpVLzLCKx9lznAAO1BPf9880E0vT+ocFYFXhz+T?=
 =?us-ascii?Q?2pCjGrPdpVJOwWMBa+WyzoiugWCSlCBlIQtpNUlB/QyBMx5eN5PUQsDN1btn?=
 =?us-ascii?Q?qlENDWj+45WaUXLdHYx6Ks+YpBEKLM2r1XMI5fdEEGkfwh7f7GqMUFbfOk0K?=
 =?us-ascii?Q?HIIBEvTq3oJXoFzib/yy596Ppl2fJiJGTDpXIdDPU/zN4dtzkkyv0VD085vR?=
 =?us-ascii?Q?0HkezDO7QBfwWpmkoV6OewO/RJOFoq5jNR/QJiiiqsPEzV7Z6T1Q95PJdvTP?=
 =?us-ascii?Q?PZuGAalpLyPcO7ms4hMFMo1U8+6XyfAmlkCrgWrtJieSu89xTLjPjcIurFvC?=
 =?us-ascii?Q?jufErXi6AIdXYhjfC7Qn3j6LJFeUffVyeQJ3yqz7aMaCXyh0N61ZHZ49g2hv?=
 =?us-ascii?Q?2SUpJ4MmLH7bSeIDLDUkJs9k1ufFvCwpfwdb3NBo6YxbGJPxFKXaR8idCCSb?=
 =?us-ascii?Q?QJNDgOlpvtM1yL3zcYDbkemuOABjcaDowGs8058X3FlzN1YAwF/CVtD0ThkW?=
 =?us-ascii?Q?zZNPs/x8dmVxzxocn+ZAXR+OsGnBy+YX/PRHIFYX90Am3Qbmfrzs+aJchYGK?=
 =?us-ascii?Q?zIm2tUM2jO4CTM7LW+UBFu8AJ0Cei4vmpe6L49QadsHoZuf5OahJLq6jE/j1?=
 =?us-ascii?Q?5pn6S4Byv5bclnFanhxBSiVv6JKQ6F5huJ3GY5KxMKvPj/X0TWWcX6uK0vq6?=
 =?us-ascii?Q?tHS/FYwrjHMEiMY+qErRsjEL30TJZlvtn9X9cKL0SUutNIDqZfNys6WxLiUX?=
 =?us-ascii?Q?oDsEk2EkVDQxEL/eb/QRixTUrTZcELUTddej0C3ypQcmIgJHJPhLB/8bzobn?=
 =?us-ascii?Q?RzpfPgCl6hVEWzSynB3Lqqljq5oh5VUFHrvF2iVFdEpMKWDlnBnVzKP1MoVY?=
 =?us-ascii?Q?+9+yJJYgYEJjcZPzXmUL4J2skzLncVRkrpGKxdRSLWhJrGgqm7HHSe67r4PW?=
 =?us-ascii?Q?BAQaAMKewt7oKQDpMEem1Qmz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06721654-7df7-4cf0-a01b-08d8d3ac6fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 01:28:03.6019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwT3NHWXg8QVXADRxHceCUGDm5QEez0FiJmRfbimNLUHwFL3p95byR8mLhVMJL3VGD62zPKA+aTh7kf1DD7ORrPoFj0oolcWym1ymC0x1KQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4759
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/17/21 14:03, Pavel Machek wrote:=0A=
> Hi!=0A=
>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c=0A=
>> index c73f2e295167..e92e36c053a6 100644=0A=
>> --- a/kernel/power/swap.c=0A=
>> +++ b/kernel/power/swap.c=0A=
>> @@ -271,13 +271,12 @@ static int hib_submit_io(int op, int op_flags, pgo=
ff_t page_off, void *addr,=0A=
>>  		struct hib_bio_batch *hb)=0A=
>>  {=0A=
>>  	struct page *page =3D virt_to_page(addr);=0A=
>> +	sector_t sect =3D page_off * (PAGE_SIZE >> 9);=0A=
>>  	struct bio *bio;=0A=
>>  	int error =3D 0;=0A=
>>  =0A=
>> -	bio =3D bio_alloc(GFP_NOIO | __GFP_HIGH, 1);=0A=
>> -	bio->bi_iter.bi_sector =3D page_off * (PAGE_SIZE >> 9);=0A=
>> -	bio_set_dev(bio, hib_resume_bdev);=0A=
>> -	bio_set_op_attrs(bio, op, op_flags);=0A=
>> +	bio =3D bio_new(hib_resume_bdev, sect, op, op_flags, 1,=0A=
>> +		      GFP_NOIO | __GFP_HIGH);=0A=
>>  =0A=
> C function with 6 arguments... dunno. Old version looks comparable or=0A=
> even more readable...=0A=
>=0A=
> Best regards,=0A=
> 							Pavel=0A=
The library functions that are in the kernel tree which are used=0A=
in different file-systems and fabrics drivers do take 6 arguments.=0A=
=0A=
Plus what is the point of duplicating code for mandatory=0A=
parameters all over the kernel ?=0A=
=0A=
