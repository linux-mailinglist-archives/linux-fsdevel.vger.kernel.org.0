Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC52A260E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 09:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgKBIYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 03:24:53 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51761 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBIYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604305492; x=1635841492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XExKqJhFVyXKK/hq+RVqi0g7JdzATrG4t4DyY0DurEw=;
  b=LBnK97xHClMwsfMkucrmgzPrMP5kNUbfmTohX99Lvezs1phF1MxfbwXb
   O3ZH/XVId+k0kn//kxxqY6aq0ATi3W7syZRzFpMGKWyChZpioHrNwQO5C
   VOAdDF3MVqKYCSD4TH4WSzdMD3CYPc0gMggxV53sG3lkRpygbLE6/qZWr
   afcYrbqSXIoUk13DzO9PhhCm7cOl3XttW8Yl3hmkLVDg/eCS8EAIWNsbv
   iiOm5vXw5lzEFoIVDbPwjIPC3Vt4xDVcJ7TagHUALnqc6i2VjwuYYwboy
   G6AZfqTSbkAap7TvbpRKizDJL5KDgY8BnkhlTBGBIo6BCxhY2bzJnZnQ7
   Q==;
IronPort-SDR: DBl3YZ2VHZsImheoDQbCW9oR/3q9CycEMxRO4w01fkuTCiy/vYknK53TtUIyqtq7LIlgE1cMt3
 b35lIslbt+q+KPdjE7Pzg6dX035cWPpmATRBQP+tQbkL32TI5BV22WdPWfJYeXTOn7m/sST1WG
 Ghuy0RGqFKt/Hj449fzy/D3BFUmoAtzTtIjH257No6F1csq5XfTnmPT8DS3XGdU2F4gxi+3oKu
 EIBGtkX7EvBHehHadLxt2xfXuBXL7FDN5YGCD+GAe0IrRm0JrzfRzeL6IBX6tONiCiWJNO0mlV
 Xrc=
X-IronPort-AV: E=Sophos;i="5.77,444,1596470400"; 
   d="scan'208";a="152740449"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2020 16:24:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7tUwXtsvXrzChYia1NQJ8hFyMZle9CMo2kS0fz5LOHAleF9Cte8ft+Sd3G0Nru4j1IS5b55pLooXWDE7V7Q//s4Wlh3eqApCzrCZ/gf7f9Vm0BP3mk7dFXK5FgNrSwLYthlf18frJn8RlHbaZp8VpkV52jbFSLDQyVr9XHF9VfHOoiAxy1xlCX1ibA2VAIv46aevwnQABNuA8qZ9cMAXfWFb+CFgGPMxFdFZw2bTelIldMbTMDBLJu8ouujyL5b90fdtgKdVBLHRY73KnN+i+oAcRSb36MbB/ltb56Us45QYzPJeMi0nY9D1Jg54fdKfOf67uaO33Te6/OOvYvKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Benz8kreer96CG9ICghOdmXh7A0K4Gbb+NEuS0icL8U=;
 b=JJbyFXc/x4cEywT6KRUPW9wJYsrJQQbHsZgnElZiZ10akFclLTSMOBZOll9ct+WgHEO+ImYunQzsH1Lwb5c5SAKNWjHwmZnHb9yTGfRbHElVKoTgZaxnfGgp4F63yhI3Grj0TaRJW1IOfx7wmxT5OiB4n69FYOMIZ6mCPqQcLsYzo8PLKbcSeETsI5TB/uG3OusJpzRq/wucnhQy8OglB+O7ukKNe+3xgtgycdPmQMRsMUffLuGRdT7aAOvynTPQhYAUwveyvUkx/3J5EAVTbuD6PMfF90LndfXXMJrR2cSp5vNpYjw5b8gt+eJaiSQVy8LUvguQeHt+FQnpu7U4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Benz8kreer96CG9ICghOdmXh7A0K4Gbb+NEuS0icL8U=;
 b=sDYC/Xt2EAnFxxqH8PmAQ5yIvHxikYWGH4Dbq8chIBudMGBSGnNuX4GfK3AwPNMDCxTTF5dvQiVWUH+VkDMB3+mFTrXUY9+d41bZDsBueWQNhUrEblZRVNXGL7BEWqQ3/r2zz/kWOGmw2oAT5w5owTe5q7F5Qc5O1QjkH8M5bA4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4925.namprd04.prod.outlook.com
 (2603:10b6:805:91::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 08:24:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 08:24:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 01/41] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v9 01/41] block: add bio_add_zone_append_page
Thread-Index: AQHWrsPlMvbVgwDO5EWuAg6yg7PLwg==
Date:   Mon, 2 Nov 2020 08:24:45 +0000
Message-ID: <SN4PR0401MB359867C01FC69DB4125818029B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <a7ff7661-0a1d-a528-9b92-7b58b7c11e6b@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bea01220-7040-4cdc-d795-08d87f08c1d5
x-ms-traffictypediagnostic: SN6PR04MB4925:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB49259D5FAE456051BFF7C27C9B100@SN6PR04MB4925.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kK+g8neg33REzuBxTrdxZg6l0WNG4Cw6vBplXeJsO8mCwdEiEXAMJIcMhch/OaX+hdwNpShh+yrVJ5OgEEagiYzHJhe5jXHpS7dIEDRvysYXyjcsdGBiFHmHwDaFMq1kzCTvrNvn9pig0iVCmGdPmDO5S/1agbuQH2Xv0Dsz7zFUOJl7eN0+ZIn5rzHxjTrbGdCvtDNMlAgbAjTE7L4nGTTRV0JCJ8egWtzUEVPlwyeWLAaAMfxKFTwmal1FsP4SW+t8jy73C8ibhodBGN+yt+C9I+S2EWqlXpSodTidUK/29cCN3lq6A+hIwxbNFSWdMWPyrnke1u9pXdGIOk2ZTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(7696005)(6506007)(53546011)(4326008)(186003)(26005)(8936002)(478600001)(71200400001)(54906003)(110136005)(8676002)(33656002)(316002)(76116006)(91956017)(66946007)(66476007)(66556008)(66446008)(5660300002)(52536014)(64756008)(9686003)(83380400001)(86362001)(55016002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kcgGvEsaAgqSPfdFiv/I1l3mVwQJ4/w0sOyrwF1naBFeP+vDymAX2YZRfcPqWCKreMHWuDNihd3dRS6i+qDKoUr7vJG8DNS9GTyt6W98Me8g8hEEtCEHfhSxRMQveJEWdqwh7wP7q4J/DsgH8+tEF9YC1LdYMItOTuiGF9T6k9W85F3B1VebNoU8RoUDs7FXgFPWXbdqyi5exzdxuTILw+jw31+6sTLI4rnECx+Jx8Fy7yj4eigZ9R8rtXyTQyN9E71Fwpvt6yk/6ZrY1WG6WGfNY68RB8COWbyHk6olNzQninZyaHoiSoTauS25DYtXqDq1CohfQGpZer6kUF/2XkiSmDFXnBzxWyNdkqpWrVjRbaXB4K+aTKSd7+gPDSWJl9kGdOWgbSjV7sjPJH5wJeowNDExhc2b6eJ659EYUBpjyrzsMdu4XGkPy8nFYj7I5DW3HDSUh6K1zZeVO43McjKKv/sMOKUBWuqq1ROmwxMnUxpke1vUnpqHgX7v/xprbW+6V61T0wt2+Y1eYKuVIxjZNom3QeAspAlgdiA0uL4ysgJQi1Vl75jXXVyvGbA/SiFqkr2uZpzXV+TyPXInywvMaKXUl42l2xXeBBsmNrzLJ8/BWtiEGoo6/PzmoOHJeOU6I2laxNlvmEKEzzFRzA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea01220-7040-4cdc-d795-08d87f08c1d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 08:24:45.9766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmwFIeQhhg2D4SMyvB2NrAZE0l9Nq6OEnS/BLoX4sL5hTsS3vmASmS2swTE1/rUdH9KsRwmEUjcHrgqIyT/D4R2rPyBA5Ll5UnyK2Is0YYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4925
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31/10/2020 04:40, Jens Axboe wrote:=0A=
> On 10/30/20 7:51 AM, Naohiro Aota wrote:=0A=
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which=
=0A=
>> is intended to be used by file systems that directly add pages to a bio=
=0A=
>> instead of using bio_iov_iter_get_pages().=0A=
> =0A=
> Not sure what this is for, since I'm only on one patch in the series...=
=0A=
=0A=
Sorry, we'll Cc you on the whole series.=0A=
=0A=
> =0A=
>> +/**=0A=
>> + * bio_add_zone_append_page - attempt to add page to zone-append bio=0A=
>> + * @bio: destination bio=0A=
>> + * @page: page to add=0A=
>> + * @len: vec entry length=0A=
>> + * @offset: vec entry offset=0A=
>> + *=0A=
>> + * Attempt to add a page to the bio_vec maplist of a bio that will be s=
ubmitted=0A=
>> + * for a zone-append request. This can fail for a number of reasons, su=
ch as the=0A=
>> + * bio being full or the target block device is not a zoned block devic=
e or=0A=
>> + * other limitations of the target block device. The target block devic=
e must=0A=
>> + * allow bio's up to PAGE_SIZE, so it is always possible to add a singl=
e page=0A=
>> + * to an empty bio.=0A=
>> + */=0A=
> =0A=
> This should include a=0A=
> =0A=
> Return value:=0A=
> =0A=
> section, explaining how it returns number of bytes added (and why 0 is th=
us=0A=
> a failure case).=0A=
=0A=
=0A=
I'll update the comment to include the return value. It was just a copy and=
 paste=0A=
of bio_add_page() and it didn't have the return value documented, so this i=
s why=0A=
I missed it here.=0A=
=0A=
I'll probably should document the existing functions as well.=0A=
=0A=
>> +int bio_add_zone_append_page(struct bio *bio, struct page *page,=0A=
>> +			     unsigned int len, unsigned int offset)=0A=
> =0A=
> Should this return unsigned int? If not, how would it work if someone=0A=
> asked for INT_MAX + 4k.=0A=
> =0A=
=0A=
I don't think this is needed as we can't go over 2G anyways, can't we? bio_=
add_page() =0A=
also returns an int and I wanted to have a consistent interface here.=0A=
=0A=
