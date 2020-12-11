Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A12D8115
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 22:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394782AbgLKV0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 16:26:08 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5480 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393269AbgLKV0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607721962; x=1639257962;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wxBE6fgK9dgVPCrmQ21Hg6mzcZuKxEAMVTPTvVguJlU=;
  b=FkX4xesOwtFDBlAQV6K+ti//c94/WxqkNvMBPYC5cG0tLPoWrBtj3z9x
   wGxu6MtBFMSc9RIUS7osrkS+w5eVapVMmBncKy1yCprZVxNVeiER3Pfih
   MVj1CKVuvNIJXjC7jypCQtExT2IuPw8J4K643nJlTZmcEmxfZjq0hFFbb
   hArHC73ELJ9ZYxOKHWKQpILuPoqqhQ9YNN+2zrQDFkJJVafcZUvZJXrmG
   oU2Jq6A1nAqcmjmN4vWnzqb4NfmULkt8MelrSycW6gnBX0krEMfsGynJI
   tWAHn4oQUd1ZovXY72FgzPqP3G5hKJeIkSJ2FuEhiIQtXJ3HtAS0QUdkL
   g==;
IronPort-SDR: n/p5swWOYchIQfMkoKnAFfDsO/kGqDDyxQcAATJIOciCGeiqeD50E4KN4H1cfMV90InZXJJJVe
 rTp8Zwf4sjWn5Tiwq3sn/SzhBLnmQmyhs/jEX2s9QHPIGG68Tg0XHl/cuFrmn69giI+Cqf57aR
 pCZkX3z3vn5k9QKBHA8vDKW2r6jIZ0cHF26K6yQrw4tTQnsbOyoimqCN9gb9bE4uQVCQ2EDqg8
 d/FbM3a9g6orakRXOCdZsS1l59NO/oDZjpyjkQCAUcld/YtJhvQSRNkFy98D21drLtsMMbAd2L
 pYY=
X-IronPort-AV: E=Sophos;i="5.78,412,1599494400"; 
   d="scan'208";a="156180516"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 05:24:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axRGOmhSil2pNFStgXGTUFDJaEonR1dnDVRUO2CAKBTKBPE90QT7/nOxBA5viCrvU+2nC1MAWd3RZZpZCA9wUWDm4y60UDS+S1W0bIFnS3CMnOm1/LRGTXfUJ3azBuwjJjzb/A9C977CPI6v3mRSksLxt7bawM1vNizL0QY6mug+CYDOk6qp+VRAmZOvDipB7NN33i63nao63wNeewl96W5Z9kGRN+WtZzgxKO3vKpiEvPq5PZFJyWi9nVJltilKnhncAP10sjMFiHkIJROnEXmRqKsQeGxOD4/blb3OojDS8BN/pJPPJjbFpENewxNJhdz4j1OGS1BRi6ho2ia1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBchebFa6moIbDxe9JfxuMKdk8NAQkNOjUGQ49MZVU0=;
 b=f/UbL/vyKbr7+/5+aLi6ygjfqTrnayMZ0eQZMC4G5FeEgsdXLZPoLd+j5KRVGwNwPoEa+SoEnl5TOC7kJ90YbEkog3A/TplyHsv3lspIOXf1rd692kNsziXilhMnmYziGHAqHklI5bxra4uwRmmyq1A20zf2/1HxxN1T7zvTYUl3FoemPwF7MWygoH3d/FquMCZEYAzQ28LRTunR7BIS8TN57aDNXloWanWwL7mFvyskqs21iVJ5jbJfuKbat4XCdi7yN78ZOUZ6+9HmhHJMxXrc/HkBIzGNeMgcSkrFkVgfFFIcAPyHQQO5+8eI0tS6BXCavHiX13OrO/24qGdVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBchebFa6moIbDxe9JfxuMKdk8NAQkNOjUGQ49MZVU0=;
 b=I6w1zhxpWFDzhENIZs3yORsrPgdXhflYA6AEMkVgwA/WevEQFWlMVfMlBd9M6TRbJVk9GlIxt564FqG5zu+aAAlYBQD2YGEAm3LLu9w+mswVfXj+ZUnpWrgROFnnTS2/JzNglwzsXNuXvdPI3oli++j7+qjftlJc2hLUvhQ3JUI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4983.namprd04.prod.outlook.com (2603:10b6:a03:41::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Fri, 11 Dec
 2020 21:24:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Fri, 11 Dec 2020
 21:24:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHWt1SlO/zngH/YLUi4yDhghKjSIw==
Date:   Fri, 11 Dec 2020 21:24:51 +0000
Message-ID: <BYAPR04MB496530C502E8EF5A2B538A4286CA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201209093138.GA3970@infradead.org>
 <SN4PR0401MB3598A4DA5A6E8F67DFB070859BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201209101030.GA14302@infradead.org>
 <SN4PR0401MB35980273F346A1B2685D1D0F9BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB35987F45DC6237FC6680CCB49BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <SN4PR0401MB35982E109738ABE8A093315C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45eb4fee-642c-4d49-75ff-08d89e1b3256
x-ms-traffictypediagnostic: BYAPR04MB4983:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49838BDDDB9AAFCCA62BD6C286CA0@BYAPR04MB4983.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/5H6MwPO1mK3E5lkmGVQl+83kng4N2l5M/O1QR/IoFHZwmF23ZIhnON9xSQBGJ+Ss+DEz0ZBhZfBK3gMY7AvzwJBR0SIBfrNtLZ1g4sALU2rxbKI2c4aadgSIe7SO72QudZqWUzZH5fqj/Y3i6m8KuwW7DrDLt8PZSl5KbUbzleGM/vjCeHsefed1Jnkon5ThL+TR9NBRnnTcPSfSEv7SHaZNAxn2TJF5ZcI1S+P1yQWtiE97sESawnlh1VkRiWxKWavZP0GoZx5WAExuQAjYiQgLa1U9yghGu9wlpbCDCBeNJwOOdgifJVOhEIBjLLxfXT1Ejdjw2cu69LG0plaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(83380400001)(26005)(55016002)(8936002)(86362001)(8676002)(2906002)(9686003)(5660300002)(6506007)(7696005)(508600001)(66556008)(64756008)(66946007)(66446008)(4326008)(186003)(71200400001)(110136005)(66476007)(52536014)(76116006)(53546011)(33656002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?l/Ufc1MoGiYa59uacBSZlcszBmmw1OuL9Y3B1116wJ9qv/vkycs50mEOrZHY?=
 =?us-ascii?Q?BojJXRWDbN6UK4cZgfjObI2CemZ6B0BU9Op0rDIi5jT6OSsLPNFl+EncE9Uj?=
 =?us-ascii?Q?TGMA0xboMTsDgZ4HhptjW4WAwapKqUhRZ3kQhiad9BuCRrKaPI+B/OCS9Yfr?=
 =?us-ascii?Q?B7hqVkSum4+1OLJjlDSbRxDoU63jqPU36YCRo+pvGzOCYm/PKSu1qa4ZaH+D?=
 =?us-ascii?Q?snzNK2byHJ346iqYPCdDZiPr+st7WerYR+P7jcI6ZapybMbycT3/XE/Mhnh8?=
 =?us-ascii?Q?Vzk+SxDo0PFonq8Lclfw9dzvoFpv82s4NcUCM+LgnKt3HAzwFQQ04dA3GdFL?=
 =?us-ascii?Q?p7J1dVIxaRpeUVKsNL6/YoQbDSrla6646m4+C5CMoGIyea7ek9gjuSwPZOOk?=
 =?us-ascii?Q?k1kmxDg0ohH31nT/NCpVYSiFQRyn/8dcnhgMJZ//Nmk0ja6pGG22xk1j3TFR?=
 =?us-ascii?Q?Ixh3ZM+q4pgLwPoPhG6fmnIKpF5FxVLUILiWf/k0q6Qe0VMS1bSO2zvemA40?=
 =?us-ascii?Q?iwFIf+LGHxQPSQQoD/vH7jY2DJzdILd8z+Q5JdcYkAwxI3+OZY9e2HMBgpze?=
 =?us-ascii?Q?Hgoin2y6KX2K2S9qLcDB1xG5GwkIOIyB3wR/SBIIsVyP0aR83SuQ4NoyrNx2?=
 =?us-ascii?Q?g7aMQvXnthSRiL6v8ISJgaH0L8bpl7G6OrqjeKP29jUhKv83cPcqC+xat8W0?=
 =?us-ascii?Q?D8AnVH5pgGnKQBHBuTueMZvFr275YV4zyDeVLsn+3UOwfpJSdLm/HbjyZj08?=
 =?us-ascii?Q?MujSpz06zy/0t02ZvMj3FrbmXQdAxWAalHZCIxA+wAdns/GeG5Fy53RI+fOP?=
 =?us-ascii?Q?k7feIU+ygLrXUfvnbzpevi/AAy4rji/G8lXnn+T4AhMbhjFTwIIaxE4iqudF?=
 =?us-ascii?Q?hk+/OWYMVfOyDbcvwTBiTGnk6LS7eDkMMvL01J0y3Qgg5LilBeLuYChYBgKa?=
 =?us-ascii?Q?BgMBr6WuYeSFgLj0WuR17dG5imIL+6Q3pBCcja117QTrWggYIHx//4dzQCcB?=
 =?us-ascii?Q?4qNj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45eb4fee-642c-4d49-75ff-08d89e1b3256
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 21:24:51.7348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hf9E2TguJXHFEU6VMozEfbE+SGNA0xAAoAY6c8h1iqjaLWxt4XSezWv5EL9DKW+GqYjpUvvsjdrZ8ehL/goEwsxRCmPSLjWyct/mtkhUdIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4983
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johhanes/Christoph,=0A=
=0A=
On 12/10/20 23:30, Johannes Thumshirn wrote:=0A=
> On 09/12/2020 14:41, Johannes Thumshirn wrote:=0A=
>> On 09/12/2020 11:18, Johannes Thumshirn wrote:=0A=
>>> On 09/12/2020 11:10, hch@infradead.org wrote:=0A=
>>>> On Wed, Dec 09, 2020 at 10:08:53AM +0000, Johannes Thumshirn wrote:=0A=
>>>>> On 09/12/2020 10:34, Christoph Hellwig wrote:=0A=
>>>>>> Btw, another thing I noticed:=0A=
>>>>>>=0A=
>>>>>> when using io_uring to submit a write to btrfs that ends up using Zo=
ne=0A=
>>>>>> Append we'll hit the=0A=
>>>>>>=0A=
>>>>>> 	if (WARN_ON_ONCE(is_bvec))=0A=
>>>>>> 		return -EINVAL;=0A=
>>>>>>=0A=
>>>>>> case in bio_iov_iter_get_pages with the changes in this series.=0A=
>>>>> Yes this warning is totally bogus. It was in there from the beginning=
 of the=0A=
>>>>> zone-append series and I have no idea why I didn't kill it.=0A=
>>>>>=0A=
>>>>> IIRC Chaitanya had a patch in his nvmet zoned series removing it.=0A=
=0A=
Even though that patch is not needed I've tested that with the NVMeOF=0A=
backend to build bios from bvecs with bio_iov_iter_get_pages(), I can still=
=0A=
send that patch, please confirm.=0A=
=0A=
