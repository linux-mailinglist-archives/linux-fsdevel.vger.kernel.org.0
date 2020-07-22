Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380662298E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbgGVNCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 09:02:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23288 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVNCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595422937; x=1626958937;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fGdST2IlJgZwpyUorU1ryFuOruLXN6Fxy5kH+uCvI5E=;
  b=kcSt6EiciIrcr4c1SmCO5LtlDjTgZjLF2NddullBSu6V9NAmfRae0JDk
   l9hf65qy7LiBPWl33n27+FtoZ/3gBsuc/JqfNTYhc5/29Q+dSgeUXDJV0
   zRLdfcON46YbqIVnEAVuUT0Xh7ZoI8Nh9Apeo0CremrpXRZIndSQdl1sz
   T8ZOXRLqoVo2Tw846feA8ofdpZVVXY3U2u/3t2ZZOOFLPQRsBHwqSK4/I
   jPO1/MlH3rfFqDBVFSg0lHaDxF5MPRwPHnteozj35CtBmFPpXU+5rI0kB
   ENf41ouWwDc7SWaFvNUD3sTZIIvO81Y9aw5Bnf/J5WC3dciVN3dwLz1kn
   A==;
IronPort-SDR: 0GQO0/rjAzLCRBCHCNzvY8P/8bzK8Dz7WC2qI2qBR6PwKZPnILMh7XrtnZbvv8l4OoWMUKtj5D
 n9gsnVy+LLTKbqlBPehEl+TaVP/Tj0jb9R36BaV4tuh9azKyQVxPnkwkfk8Jc+XPVLYvAW38ob
 E+ZBplhsyr1657nBByjLYiuE5qAb3LkPBCulUC0T6ydOMbpAf6g6X8n/w3/wP2T+a5/7v8i2Ca
 ZKDLI/1MROcxrjklidOJkC1QpcltRrTw7LVjYS1KE3HKaDV2Y52xB1MlgXcylyKV5D16ai7dzD
 EtU=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="147415326"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 21:02:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdtFm4a7mVxjXjxsovL8ezs88TJz2hl8YMlKuzElkcoRSld35E+D1/4gr7Z8daOk/zgn6Gd/PkS1G2pEsWHuI/HR6egSFAAOaAZlkWdSWm/iLh6hytJpjuGDMxR5ZtKSlBeMB6ad5hOp07S7YfB/dy7j14KV5y9hoMEW4k9Ls+/MtkSXBi6WHPzUAKsvDpqyeve8HVnaRDFxdj40z1rjyUhaV/BNjeQf9kTUOQUUhwK1bFqJYo0oZX/cRT5tBsPSwSruV//MxPsX0gBg/5tFft9P7Nkl74dB6nrJdUtTXcxEeiX71r+C1gAUpSLqq0AVqNWDeDLrQ7nvHF1VfPOqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY0/ZHJrRtcAW94HuHbq55AKpO46Yzs/dMXvJz/lcGU=;
 b=HhpEY93nmvdiV033Nt24XtZpDwZSgwdOtsmDFI6j0D62xkHemXwZK6PGPLppJAbQhrWi/ty8gzNMDqPlZRzlDETtlGZDYqasn8niHrjRrOiQ2IdlKPVM5EsY31JjKn9wjYpzvYQE5D66+/chMcf1583SMbgrvsmD+Q0er94V5dcQQ7+pLNOoHft+W26s0pA5QXKV7dT3xA2NqhwzZ8xky5vFna0XqlAtfXLsg96WQCFAq45Xu7WoczU6POsstHWm0zVDkx7vVjohk4fQv1Ta8jPT1mGNoygzU1uWEWMBaiZ1XW/DT64UfEwPLYg19xeNp34fs9ytXpOwu0RO6NGgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY0/ZHJrRtcAW94HuHbq55AKpO46Yzs/dMXvJz/lcGU=;
 b=A0cl1Gca7/5EFAsGw2Z9qqwKFuPtbFQ7z7s/Y/OsSD/8OPQKsi8eq+51kpIaaZN7MDwX0F4u21CFVDrsXTnxD+4tRBMjxZFoeCxoMuhlAyou+27f3wKNRC7Y1xqdgWBuo41Ej0KGnNNEPRdV5zTdrOIszyNBddOL4bSL14MEs6A=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1030.namprd04.prod.outlook.com (2603:10b6:910:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 22 Jul
 2020 13:02:14 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Wed, 22 Jul 2020
 13:02:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Topic: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Index: AQHWXpithxnH4YX78EmlwzCUDX/15g==
Date:   Wed, 22 Jul 2020 13:02:14 +0000
Message-ID: <CY4PR04MB375139CC436B04DDE02B8560E7790@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <20200720132118.10934-3-johannes.thumshirn@wdc.com>
 <20200720134549.GB3342@lst.de>
 <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200721055410.GA18032@infradead.org>
 <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9df2f3b0-d29b-4043-f2f6-08d82e3f7444
x-ms-traffictypediagnostic: CY4PR04MB1030:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1030E8D2092634FF03CEA3BFE7790@CY4PR04MB1030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UERRijvO+68XVZvrWrtbWVGmT9Ft3A+V6Twe+3uy8wJ6Mcn3V4wfc3ZlulMaRbNpWmRw4+8yCPM/x6XXzo9rEwEczJziapr78xm9tPdfqC/5dAccHjW+BsxFhQ1AXktzdbfQyr/aj+hl42V4GW6RsNNOa6JQaIEPciOIE0puJmrtryXgCS9XFub/37K81jn5YUKeeq9P+pQmV0YiOjGEws643odP1UiP52DGY5OI0BregOMyofz16nG54OK5M7WpFJg9+nl2UP3oaBbwWIY5HGtux0WUahMnUU7aAGfmOow+TkJy+C1+cCW5nige+NlpZs6V8zwLeHZmeFp0vjeNbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(7696005)(9686003)(2906002)(52536014)(55016002)(26005)(54906003)(83380400001)(71200400001)(5660300002)(66476007)(66556008)(64756008)(66946007)(91956017)(8936002)(316002)(110136005)(33656002)(4326008)(86362001)(186003)(76116006)(66446008)(6506007)(478600001)(8676002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: l2vYTR+Niin2fWvLyYBA8IzE2npgAHnqDpewV8j5up6wX/7/7gbo9otfkdNGVYl0fo1oe/CBjcaqYjG/bRPV23UogmANZs4aMUniXyrsClzk+sY4cgVR6+oieT9DO6TG/XOk4NzZm5/PJdkm+VxsitHMCFOetexplIcVKGvemsc16cazAr8+7wIMozwcYFGoHmhrBvdldMGQ//NZEvSAUHZxWakW7mViEXmPEpNVcc9wgOo4Zgj/nrbTGO10cPGWMnuFEVmQ9neiGNAfJ3wceWQS6UWcnXpxLbXfsWqu8dBpED0l4zWOLlAKOvqepfQ1kKqW0/Dm8Tdni5OOW0pwze/xC3euxVAhVFeAzVYjtExP7/zsaEi0ZDYyMNN2iYNT+RkATT5gEBYBC9icwd7VR/bkjnK+wsCzqHuIa5G8IG8x0hud6lQ5WoKiN+U+2szS7IAf0VWGmSYtT172VU8oMll4hKdjYNfaqyN8cesvPlHTPzZcAG1N8yG2N6twCSsu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df2f3b0-d29b-4043-f2f6-08d82e3f7444
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 13:02:14.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /71I49Sv6zaEDw1dTvye+i7Zplri99SmPU9X79kjV6WUwyNmuZFHnJXpVZQ1TaogvXNcY4c97h45OQAB58NFYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1030
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/22 21:43, Johannes Thumshirn wrote:=0A=
> On 21/07/2020 07:54, Christoph Hellwig wrote:=0A=
>> On Mon, Jul 20, 2020 at 04:48:50PM +0000, Johannes Thumshirn wrote:=0A=
>>> On 20/07/2020 15:45, Christoph Hellwig wrote:=0A=
>>>> On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:=0A=
>>>>> On a successful completion, the position the data is written to is=0A=
>>>>> returned via AIO's res2 field to the calling application.=0A=
>>>>=0A=
>>>> That is a major, and except for this changelog, undocumented ABI=0A=
>>>> change.  We had the whole discussion about reporting append results=0A=
>>>> in a few threads and the issues with that in io_uring.  So let's=0A=
>>>> have that discussion there and don't mix it up with how zonefs=0A=
>>>> writes data.  Without that a lot of the boilerplate code should=0A=
>>>> also go away.=0A=
>>>>=0A=
>>>=0A=
>>> OK maybe I didn't remember correctly, but wasn't this all around =0A=
>>> io_uring and how we'd report the location back for raw block device=0A=
>>> access?=0A=
>>=0A=
>> Report the write offset.  The author seems to be hell bent on making=0A=
>> it block device specific, but that is a horrible idea as it is just=0A=
>> as useful for normal file systems (or zonefs).=0A=
> =0A=
> After having looked into io_uring I don't this there is anything that=0A=
> prevents io_uring from picking up the write offset from ki_complete's=0A=
> res2 argument. As of now io_uring ignores the filed but that can be =0A=
> changed.=0A=
> =0A=
> The reporting of the write offset to user-space still needs to be =0A=
> decided on from an io_uring PoV.=0A=
> =0A=
> So the only thing that needs to be done from a zonefs perspective is =0A=
> documenting the use of res2 and CC linux-aio and linux-abi (including=0A=
> an update of the io_getevents man page).=0A=
> =0A=
> Or am I completely off track now?=0A=
=0A=
That is the general idea. But Christoph point was that reporting the effect=
ive=0A=
write offset back to user space can be done not only for zone append, but a=
lso=0A=
for regular FS/files that are open with O_APPEND and being written with AIO=
s,=0A=
legacy or io_uring. Since for this case, the aio->aio_offset field is ignor=
ed=0A=
and the kiocb pos is initialized with the file size, then incremented with =
size=0A=
for the next AIO, the user never actually sees the actual write offset of i=
ts=0A=
AIOs. Reporting that back for regular files too can be useful, even though=
=0A=
current application can do without this (or do not use O_APPEND because it =
is=0A=
lacking).=0A=
=0A=
Christoph, please loudly shout at me if I misunderstood you :)=0A=
=0A=
For the regular FS/file case, getting the written file offset is simple. On=
ly=0A=
need to use the kiocb->pos. That is not a per FS change.=0A=
=0A=
For the user interface, yes, I agree, res2 is the way to go. And we need to=
=0A=
decide for io_uring how to do it. That is an API change, bacward compatible=
 for=0A=
legacy AIO, but still a change. So linux-aio and linux-api lists should be=
=0A=
consulted. Ideally, for io_uring, something backward compatible would be ni=
ce=0A=
too. Not sure how to do it yet.=0A=
=0A=
Whatever the interface, plugging zonefs into it is the trivial part as you=
=0A=
already did the heavier lifting with writing the async zone append path.=0A=
=0A=
=0A=
> =0A=
> Thanks,=0A=
> 	Johannes=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
