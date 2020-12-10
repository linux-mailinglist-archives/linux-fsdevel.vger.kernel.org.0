Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09042D5451
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 08:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbgLJHEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 02:04:16 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:22336 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732351AbgLJHEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 02:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607583854; x=1639119854;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DJa7mJ7MTphQaFRCfPgpE4ipPX0X/R66+J5xa+bKozA=;
  b=Czlbk3agaSq5VAFiIxMVvEviE8ccgC39DkY0RHoWjlkyxe6jXHS65Kdu
   XZ3H/3qPzh5W5FrtVmDn68SWQGSYdlSGDVUr6mPxFi3iud5GguBosTHw3
   Eg5r4OtbbiDrcaw5lHHGPVWaomkhjMO2e7asM1mmOr58F8S3PV1zj+8jY
   D7pKYUshdV081vKGnffHvGUSxACEvk4ziQ3+Id3FZtpC+5aoZznpUZrwQ
   sOy5RasfywAkNS0IOXoPwkFSqRYFeVnb22OIWiAZyig3Owi/EGRWjEzm5
   f8aAi04fjFyhbhl0kclXW9oHo08ZAD/Zw6/Ts8ZBJKYZKmrVZtUUyZ4kK
   A==;
IronPort-SDR: Prqz3Dadjt7xeb4ZJOn36OPzlwy/sYIETPlpzYzVATQmWEC79pvGqO9u9iIHsZPoyQfQ5mC/K1
 tmt6PCBvEIocmKMyRsPfwe1v9uQY9sOom9zBOML4yKc+O4AuzZVZA59toQ5FBWS04Zbe57yfcS
 GLV8kLenp49JyVzWjxWXukz8ClOAn3U5C3G7EbeWqgtfS0vIU2SD0PBLusUnh8ybJlw6ps+6BZ
 sN0pp5mWsIK7fr1kmdmrG2OCcp+3KWMsoMY79GUhF2a9bVxBxOvz4Mo3B2wgQiMAJARjb90Lmg
 RO8=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="154879985"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 15:03:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv84lM7Jj1WhTGNIxRGXF0aylt0R7kqcRE387WUb+Y3Fh9IyZnYAXKg+KZnTLnj206fVKCCJRSjLBk2LYY4RWhm1sN1Gzr9yXWvgCDJcmSHfvxHChlzglU+tCj+6gZ/hkm37kNdkA7RM0J/RzrF3HUsW/dWTBgNTOlk8OiHO2DTy8OsKbdC1VHQ3G6YgRf6x7YhC+v6W4oljpaT1FecysrC8zQqRdfhMMs0zNRcyzdi91MXdnEyKFmEzBWL1X5WBFVCHT4I4vzFGWRWBYgRDYC+3GDGs5oyLqj+KMdXIfdb3jqDeHbOGzFjAAjEhkQFd99uO3cyitUY0kii4Q1P4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2d/niMMyn/f6D9xTJ/2m5TOwPpJUnPhd1vViqLb5T8=;
 b=E1C5rojCx7vuE3a9HUVz8vzCh+12ZDXuzWNMP5pS2Vth5aAwFZG1X70MqpmzK5YOpCU6EkwsauALj9AKGbGgxK2WN+eyirMnCMJop2GYzV8HM1eSe3HQ6YkdJDtN0+DyYMteWtOQ2M+JXkBw+VxWRkeuhoJX1cGyuu8tNHdV28SO3GAWOhthb+HeCR20N1NSzOwcvRe4OIs1H+50SOOGvwpsIPVdKmY/IULGbqDHox3kEhkCvDDjWkwF3zgCw67+nvLckdi9oV9TPlu8XW1rX9AD+ZqIsrvNwd7EZcevjf1Wb/ksoigC0dMjVAfSnYV7MoSxYyOfS3PblI3XR0HcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2d/niMMyn/f6D9xTJ/2m5TOwPpJUnPhd1vViqLb5T8=;
 b=pENC9UYiaq6opbvOi+shlUZp0zefVbzSuy4Y28qTtwYHiKEvIeJgtwkqrSU/15RVlUmJ+ZZxkZeCJ5xvKh3B/iTBp5krTKFI59Fu3V6XOlRwY3qzAlrff3U6HxOwOi0qu+8Nc9f36u+3RG0xuh19Q7EPFoU/uHJQNkHrC2U2KyI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3517.namprd04.prod.outlook.com
 (2603:10b6:803:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 10 Dec
 2020 07:03:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Thu, 10 Dec 2020
 07:03:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] zonefs: fix page reference and BIO leak
Thread-Topic: [PATCH v2] zonefs: fix page reference and BIO leak
Thread-Index: AQHWzpUrpokN11k08kaowcuFJTiUbQ==
Date:   Thu, 10 Dec 2020 07:03:08 +0000
Message-ID: <SN4PR0401MB3598F92D83760E2A2D8749E59BCB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201210013828.417576-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f18ec123-cd18-4ed9-0aee-08d89cd9a65e
x-ms-traffictypediagnostic: SN4PR0401MB3517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35171F8D1A88EDFBAA525F049BCB0@SN4PR0401MB3517.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5NHlqoBk4Zvck+dluT/gpjBEp68e+sUGigJ8FiNHmKIeEeHj+PH+n8BSlAOgaWcU8rwl4i5VX9PJgEDyI62/xdUbI3Pi9jMMtBbIe9Lz+Bu4+K7szOxntgKOROoM+orNtOjdkYo5092zSjZ5PeXBvl4u/VG4PIG6NsdbQLPWM21BUOtH1EoXFlRCF+/E9/il8uY9IK2tgP2eD4GTqB8wHE2SI7W2rGDfXrLAHOweMys17nwwEUZDkYgzUmxwuA/e56upird5fWTZY7DnPwF1jo0Pik0680j0CA0LfUwONAfFNBm172Y/Y8NnrMXiiHMjYhEO70u5/3kmoy6bth7TpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(52536014)(91956017)(53546011)(66556008)(76116006)(4326008)(8936002)(6506007)(66476007)(86362001)(71200400001)(186003)(83380400001)(26005)(64756008)(7696005)(33656002)(110136005)(2906002)(66946007)(55016002)(508600001)(9686003)(5660300002)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sUCO7a8mBaKa07YLrMWIRwyEE8kKsMQO9oVsUbZxMvnc1OXtEIJ15g7YqZuT?=
 =?us-ascii?Q?CxbRwcBuhUu8nT5/zmt2Ipv+1rt0LlJQ/IIOs30d8k4FW6bjMQvrMuZLeZUG?=
 =?us-ascii?Q?DhQUI126i2iWJ01A/JBqmu7F0+ygC6b8mxHzy/wlogKtSLafDidNjISvu+qr?=
 =?us-ascii?Q?K9fGQnrHz+xZFcisXW4YN6mFx4XlRt/qPWOy6bZpOXnVi5/qM+g8eciAKpN5?=
 =?us-ascii?Q?mIYlVM98HUGUo+Is0orAfxjEkKXV0Ff5Gi5LLUJ0/5AoxSLJtUp0q7GOB2x4?=
 =?us-ascii?Q?mbRSyTmQx61FgfCefVUtq/FOjYPuxF3xT+IJX0gF3JhuWKNIC23Wz1egNiaQ?=
 =?us-ascii?Q?DFnIs99SIIk553pAbxA7K5+N0UwoXbyKM6cBe13ymisnbD8uvaozc41XhCg3?=
 =?us-ascii?Q?mhUUEh6g4MEjY89cHMvOVxD62I8kQQr674LaHYF0qA8VES3Ysqndci9ADVJh?=
 =?us-ascii?Q?djJcEEbjzDQBkSySUzsID0NWwMxREoRs1u3873+AVLPgVNYlZLchsmaTRcWi?=
 =?us-ascii?Q?1zn8v3z9nPtfgbaZPA1BKDuVUnulRZ08ed3Q9qijdT5AZQO0H8/0ohjPfEdS?=
 =?us-ascii?Q?GHS0oIrGsSyTSdoaDwMsqjuTtY54PFTBZRu4RLoDBeiHjgmOtn3a/uGb99nB?=
 =?us-ascii?Q?3ym4/pA6V3T5C9bb3tKRyfSfg/2PECfnx6XDQDZBzeQvDu3R2neuo44AXWO5?=
 =?us-ascii?Q?SA9FI+cVNqELinhw2u95dVc1/1PCw/slZUaccqKpBNS1MObERu/pQSHdb0Zg?=
 =?us-ascii?Q?8XO8zjd/0A0g11qXZURcxn4iCNIPPp3lKcyBvxBvwmYuTtKfMpi4EEf/NODm?=
 =?us-ascii?Q?f6MLB2/KE823r9mEd125jymNfxyWEoRYF+l0Srddi+8tF8Gcg2C1AoIQrcFn?=
 =?us-ascii?Q?RO4qu1B49k1SmOBE6fT9iQy++S3U1eGJy6yGT+8gORkPnjzksBtBEjVQHJY9?=
 =?us-ascii?Q?99xooi0Uvk/xDOdorI3oLCAbNS6Njl57IHOon52cuzH3fq0Xh4Zt29F0mjBv?=
 =?us-ascii?Q?zUuO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18ec123-cd18-4ed9-0aee-08d89cd9a65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 07:03:08.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvPLdrNh7Qxok/ubSGs4JsWr3o1/pswvopvg+qEMVsolFVxatq3fRQk76FJOMnlO28g7Du+b3pIGn+PBtVxMVwG21KoYnnZaRfNs0szXcYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3517
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/2020 02:38, Damien Le Moal wrote:=0A=
> In zonefs_file_dio_append(), the pages obtained using=0A=
> bio_iov_iter_get_pages() are not released on completion of the=0A=
> REQ_OP_APPEND BIO, nor when bio_iov_iter_get_pages() fails.=0A=
> Furthermore, a call to bio_put() is missing when=0A=
> bio_iov_iter_get_pages() fails.=0A=
> =0A=
> Fix these resource leaks by adding BIO resource release code (bio_put()i=
=0A=
> and bio_release_pages()) at the end of the function after the BIO=0A=
> execution and add a jump to this resource cleanup code in case of=0A=
> bio_iov_iter_get_pages() failure.=0A=
> =0A=
> While at it, also fix the call to task_io_account_write() to be passed=0A=
> the correct BIO size instead of bio_iov_iter_get_pages() return value.=0A=
> =0A=
> Reported-by: Christoph Hellwig <hch@lst.de>=0A=
> Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")=0A=
> Cc: stable@vger.kernel.org=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c | 14 ++++++++------=0A=
>  1 file changed, 8 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index ff5930be096c..bec47f2d074b 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -691,21 +691,23 @@ static ssize_t zonefs_file_dio_append(struct kiocb =
*iocb, struct iov_iter *from)=0A=
>  		bio->bi_opf |=3D REQ_FUA;=0A=
>  =0A=
>  	ret =3D bio_iov_iter_get_pages(bio, from);=0A=
> -	if (unlikely(ret)) {=0A=
> -		bio_io_error(bio);=0A=
> -		return ret;=0A=
> -	}=0A=
> +	if (unlikely(ret))=0A=
> +		goto out_release;=0A=
> +=0A=
>  	size =3D bio->bi_iter.bi_size;=0A=
> -	task_io_account_write(ret);=0A=
> +	task_io_account_write(size);=0A=
>  =0A=
>  	if (iocb->ki_flags & IOCB_HIPRI)=0A=
>  		bio_set_polled(bio, iocb);=0A=
>  =0A=
>  	ret =3D submit_bio_wait(bio);=0A=
>  =0A=
> +	zonefs_file_write_dio_end_io(iocb, size, ret, 0);=0A=
> +=0A=
> +out_release:=0A=
> +	bio_release_pages(bio, false);=0A=
>  	bio_put(bio);=0A=
>  =0A=
> -	zonefs_file_write_dio_end_io(iocb, size, ret, 0);=0A=
>  	if (ret >=3D 0) {=0A=
>  		iocb->ki_pos +=3D size;=0A=
>  		return size;=0A=
> =0A=
=0A=
Aren't we loosing bio->bi_status =3D BLK_STS_IOERR in case bio_iov_iter_get=
_pages() fails now?=0A=
