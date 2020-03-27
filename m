Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1B195C19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgC0RN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:13:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4843 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0RN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585329237; x=1616865237;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2aW2Jvn/aHbWpbHtvfFNSSzRSsATzWVSffSB9vGDcw4=;
  b=c6dI0zM6Y3m4rT4hVJDgNScdYnIST09K+OLHXC5/j4ymIgxGig6jovPB
   JDlUsnvW4fnUnjRE4/7ANFSXQ62AsQldn0SmiI1rhAcMlZTZoy9jWL0nI
   gpes3WsCLnGYHVAFRUPmDqJFi6XEvm+GqIlUL+VrSVFiod6msPRuEQg2Z
   tCHgCnhdQZo6TaatK+ip7r6Fec1hr2XHyA0dPPKR5C0NhfuiPiYboSfIS
   w2oQEvrmPLA8UgpOtfWI9ChBW8gzq4AcIBZfE5rUBSPrtYC/YUA/yVO5b
   YsHErIMpOLl/A88pd7fhJvWIpdo7PcQa29JqcwIewv7GKrBAfXSgsCHyH
   A==;
IronPort-SDR: T3jkIWjrjKOumaQfcsFgWXJr1K1R964ra91in0HwJp+mU8lMfhVuqZYuGbyo89tiBQz3MeQgBY
 zJaGeL3lGXaHo7BI2KG7X416uVhCeGv5xcwaQEUaeoziqtV098LC+r213I63mYIo1DA2i3RNmF
 sUdXByhMwCH4ivvVLxUdk9jjlZt5YviZ2VrmpHcUBi4YxlnDOu59S1dp1HFc/V4mDX/d9okwCP
 ZQi2ufqVpVsrblpOydedhqcpPlqepJngwJ/gvgdwOUWMQYUbQ7q8UuONoBp8QKLAo8KiGBYaHz
 mIk=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242212168"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 01:13:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkhvAcL6JsbZtbVS4f5fIPwUgZBl7ZlbJJ0jlB2zGTiU4gR64TqC1E1dmiqlq5lBx0f+ePG2voMkIZ1zbUWsBFr5XrEoQNSBpzl2tg0gT0ZnLEYbHApuphnDnUZT59xV8MTozm89bSyq9E5itxbz21fCkILfnpNKAH491s1+SktyeIMnGfQkQ17tiB0xi8cHm3GR79XnJs0Iw+ARe/x5WM1sKrng/UmewUrrWXUXASGOJpvP5Sl8wRBpi8eZiHQF/M0X0jCajod5hpJJd5P1GmkBxErF/LLrJJP0Wf3/08fTi+3yxAt1dgqacZIC4zutnH2iRVL5q/Otr6ZCJzrRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SriTB4QRIQ1/f1BA3a7yWcxMUk1Q4WOMjrJFKFXJnOw=;
 b=Ff3uPVA7bHkVAtnVKBURI/wh590OXXMZFeoPPOy6ggWweEHUPfVcTuCCSt3JamO1QHhgnNGwaS1BIkMd7+9ihKIvW+NBqYCgfP8OQ+wD9QqGRZIhkDe45UtFBu9fdc2sP08o+pHGyQ7dzrRQ9SzaZCQmJEd5c42d084FL2AaI4gYaEcLIwOn2yMNmz6x1bty56SrqoSfoCHGHVjaUxwp5+5RfpUwSi13QFeU/IVATwRH2kXa+iYVooMI2imF0MXjrMk5f8e0M4kCzUwO/CinVQSL3M3he3J/70vYUNsaslMb/VkaQHbHbhiaOQAeCe6BVXYxwvVpcmB8KQ1wU1krHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SriTB4QRIQ1/f1BA3a7yWcxMUk1Q4WOMjrJFKFXJnOw=;
 b=Th4GkxY634abie7Qfjk6q6R5/jC6uPvy29E+IWeVa2bpg48rd8g/2AbIsslqKi3d0yuwmDTdkxoY5E6JMcI6OsysvSkOGX/X+TXtjzNzRyL76WTBU2AlvsZAfBD+PpEnyp1L9RFUr3F+cexPxYm5rrT36rl10Nryt6bccRw3Z5A=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3581.namprd04.prod.outlook.com
 (2603:10b6:803:46::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 17:13:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 17:13:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] block: export bio_release_pages and
 bio_iov_iter_get_pages
Thread-Topic: [PATCH v3 09/10] block: export bio_release_pages and
 bio_iov_iter_get_pages
Thread-Index: AQHWBFfaQ4zF+g4aQ0WlR0YuAT3fbg==
Date:   Fri, 27 Mar 2020 17:13:55 +0000
Message-ID: <SN4PR0401MB35981511B1C7A22E055F80F29BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-10-johannes.thumshirn@wdc.com>
 <20200327170716.GA11524@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2ab24f9-9170-4937-51ea-08d7d2723af7
x-ms-traffictypediagnostic: SN4PR0401MB3581:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB358199002FF19DA81DB224899BCC0@SN4PR0401MB3581.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(53546011)(6506007)(71200400001)(66946007)(66556008)(64756008)(7696005)(478600001)(66446008)(86362001)(316002)(66476007)(76116006)(52536014)(5660300002)(54906003)(91956017)(2906002)(4744005)(9686003)(33656002)(81156014)(8676002)(186003)(81166006)(55016002)(6916009)(8936002)(26005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oWuT4nsxLKq0gT+viAJmIFlW1Pm2gXoVyhtDA6rVuFjiENYqvOSb1L8TBFdTv5XJkhYR5SIN8+9SdJy97miNnYEjvB3lcArzb3F0Zd3w353nxPRR6Q9QTXMED+Kbb1objCrnpyg82IkPEIJdWBcHbhCCtyMIbreaxgLSE2IWqTEYTgzgMHWIFntESdnrVk6Dtmg6IRWJe0OeVWzRLEFdH3nwbRVnGQMR5da09L6CXrewqQStWhhbYIeI+TDZNIzo2uWyvlf/curSfTR6xuipx4bMzC9SkfZBY6NXkGIZynjjKATVyfYEAiljtJY6FwbKbgzdkVg1DezUbuFph/h0GzUWxZVzZyJQSNk8PmBy8Ns6laWZlzZGQ0Z/tBGnU6mlUZL8sls3G8Kr395DyTIl2tIoWz7Y0Y48sJi23ly9e/EOLinoXc0VtrtIsc4WIRR/
x-ms-exchange-antispam-messagedata: YwE0axh84Cehu2obYq+taYrzWtrgzRdsVSvXebNyTkbrppDVK/F+8rv6Ze54fTzsz2W1Bz2hENKvoJNqEvba3VVS/fbyfEiwagOQVsaPr4W7puQ7PB/b+flWoyGbxJx6HJfPWrQ8U+sniR+hZl4pNA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ab24f9-9170-4937-51ea-08d7d2723af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 17:13:55.2766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sytMe2mgxt6gczC8T9czE78BEShI9r5+uhzC8ZZyMDgHXYEJoj4IWqfIjAv78c99C17gL/266w9+1vbFGH7NZv5tEFtfJ+PPFVEcvEo4BTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3581
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/03/2020 18:07, Christoph Hellwig wrote:=0A=
> On Sat, Mar 28, 2020 at 01:50:11AM +0900, Johannes Thumshirn wrote:=0A=
>> +EXPORT_SYMBOL(bio_release_pages);=0A=
>>   =0A=
>>   static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *=
iter)=0A=
>>   {=0A=
>> @@ -1111,6 +1112,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct=
 iov_iter *iter)=0A=
>>   		bio_set_flag(bio, BIO_NO_PAGE_REF);=0A=
>>   	return bio->bi_vcnt ? 0 : ret;=0A=
>>   }=0A=
>> +EXPORT_SYMBOL(bio_iov_iter_get_pages);=0A=
> =0A=
> EXPORT_SYMBOL_GPL, please.=0A=
> =0A=
=0A=
Sure, only for bio_iov_iter_get_pages or bio_release_pages as well?=0A=
=0A=
I couldn't find a clear pattern in block/bio.c, it's _GPL 7 times vs 28 =0A=
times without _GPL.=0A=
=0A=
-- =0A=
Johannes Thumshirn=0A=
System Software Group=0A=
=0A=
Western Digital=AE=0A=
