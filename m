Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DED2B005D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 08:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKLHf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 02:35:26 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30356 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgKLHfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605167670; x=1636703670;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ufyNQB4tmhBlz5KwgFSjRQCK1RbOx3cE7/g3LBGyKsY=;
  b=QPRriJszN2HqIWaQHmeeK8Rx+Dg+8q25Lh+YxSIfVn+/PVgMGG0Bqy/p
   c5FeaRe5PNkX2+zJpyQXIBFYjABEu4cTfJlnumsjlD0iC5y407vQTLmYS
   pQdR91buZ5/0qjfQ3TUsXEKC+ARNPxb831OeVuI7m8dZKKtLmkXh8qLd7
   nOH73wwNGoXWuyDg9dKHCRtal0gFFDde5pqXFM9YUkCWvfadCie9NAuE/
   mH5WwLO1JBB8RPHZrEyQZMVP4Slx57rzEtej4hzl8HMb8ZNoAtjXZm1wa
   HhNbK/bUgU52DsPUZBvYzLuhYW8KgXiy6cCrlaNKvO0PREvBwrRP+lcms
   A==;
IronPort-SDR: /B1VT/VRN8lunF07GiR8c48O5tbLKcGdDkJbTUBtJCSwHYtbOBy23PSdHZAFl3pi727CBfXSvW
 snn+tHvt7XQNx4CoznA5qDEGPymmWho1Mfs7080RAkaWP551Ltm0FnqGObh0IxTdIDUrVO1fF3
 fdWZQDuqkUjZOv3I2XVcudIrHT37XwLo0aoKEG4/xnHPHw2z/LSaKfsrmNjHj5+XhbvLIGsu+B
 3QmVnj8DtLbifJccRn5qUsQ+YrBVL6pMEA8w2Hs7/NfybtsBJM0Gd2/Sv02C1ee/7WTNtC/XfC
 Z3U=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="256028018"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 15:54:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3bd8vVmYbW3UuTQYq8KhPtacNmtu1Aos1645BYqZLJ9jkbuTmbTczENeTpGDguZ9lh8DzPlmglCav1BG4kLdTg2kq6gz/fOsPG1X4Lbii+/PMlCEsV+8vLaHe0dIAEHxSHmib3mHJbatPZB18/wrZlTePPlVh/i79PC6LQ6E7RE7WbiiZE4QiFTARdOIM5jnyox4eSKV2fIUQLgngrqs/Xvzf7VTt/L4mFAneV3rWtPrEqg4kXDtEwS9J8KAzTwLxt3b5S5ocyeLLiDzbCdzd8RwjrJcoO9RUvuDGKLx1QfVfqiG4SWpN2m0pPM2Ye9DrMbyB9OIh2F4xe7g1n+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjyxzZ+tBL461uv2B9g/u8CHM/nLZZGEiYrYGaCXNvw=;
 b=HxG0x9dCH6AYOjfYL7b5d2KNo2TK86I+m42K4dLk3orzB6SC6t3Qhpmytf1L5gZY2xYtYEmBR7beMzdIMyUjFGV3YJDIqw49DKYzW7A6goWmnI0kDBNKNBMFiIE3R/aPWkfFNokn4ZeB8g1AzTXPlkyJ11BqDCkBdrT8QANJHeJ4Lw+OuKKFJ6czS/4w20kh/Q76mcp5kIXHxKG371uGo2wxwj0YRgVvaxZPJ9ZwuxD+s5XSdbGw4lhpQNvtXLXpDgR+I/YpirTOiDZjc1DHwvMaAXkuW1Uhw3zRMRkzDESCdZBGvngWZ1c+8elgesFPezmVieUg9TOea39/+rQJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjyxzZ+tBL461uv2B9g/u8CHM/nLZZGEiYrYGaCXNvw=;
 b=n5/nLwLcslpFUzGKPeOlhXSSq4OxJF2933Prbd5YFGELD0L24HB8BH47sFtbwmCygIpAcjOTXkJzbSCW3NJl0rhzIMwl4eh2kSh3cga+j6b7vhxkjOFMz7t/AF5piGC01mhYYGLgtSewffXE3GJi0TZOhsyFkWGhwz3SG5H5TCs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2319.namprd04.prod.outlook.com
 (2603:10b6:804:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 07:35:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 07:35:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Thread-Topic: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Thread-Index: AQHWt1SikzZ873WBFUWuepbyYg7vfw==
Date:   Thu, 12 Nov 2020 07:35:22 +0000
Message-ID: <SN4PR0401MB35981D84D03C4D54A3EF627F9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:dc5c:505:f80d:76bc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ec8fb4b-f0fc-493b-86c5-08d886dd83a5
x-ms-traffictypediagnostic: SN2PR04MB2319:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB23196F6E6037566845257A459BE70@SN2PR04MB2319.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0RjKoEyM7Wco7D56kD3sqctTEUSsqssZiggKb9EXIDHZu+U+f6rwu7fjE6K53wFrctfZxQUcsGDDkY2yql/YhI7Am28Ui/y3D6FfNHvTIev1JwRiptMWgyo75yuhCc2gsR97+kp9bbED6jgyHR7tN1lxsbExiFJFd6QFkJYa8wo9KN1LUoKL+Ovcdi9yneHRsRyrLl6FSy0UViOasn/Se0gpBcH5zEE5yvgD/F29E/rXyrBU0h52hukX9Izm53pji8fzHA57Lao3T6/864Htmfo/daGcHL4GtWEZ7UioAn+ZFGnr9+uGyxx8xzAUjiMUL77rH6IpCMuCaWaGUigVPkqv3shYJbI00MmBOYpH2tA52mJvSpXMxWfBw4hn6t7U4xAO2Gs8iI21nUwa47Tvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(4744005)(53546011)(91956017)(76116006)(316002)(110136005)(7696005)(33656002)(54906003)(8676002)(83380400001)(186003)(6506007)(64756008)(66446008)(66946007)(52536014)(86362001)(71200400001)(8936002)(5660300002)(66556008)(478600001)(66476007)(966005)(2906002)(9686003)(4326008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: e4jLTaJ+FDMw99HTm4ocfQTQiiAoPOkzRS/He7R27S7AMT3KRIy19IUGiV8JBASoQBM7KPqZyr5cbhPtyrl/CQ7VRcff69EUx3Na3I5OLMD9LSx0rs0bDNCiwtDrH/3LQbnpKj2HguukDdNwGOxCSXpRutkOd7crPAYGUTwtK4w5PtlESdHDQh4hLQ1eTutq/i8NKGvSmB5Q6AgHV8nJ1rGVs7WDZvZeElPsHksmByeRXXbuhndPqu2D+Ad6dz3+8350mnbIqnZUbQJzJc+RiUZjsUhhowAzaCKJMTQDEnvchMR9+JbpfJKQRy9ckFUjMBLiilpPjPHBTINnALqGerWOptjywx/e6FzTMpVb+xV5YGPpjGXPMUC5jdZY78ZB7EdUOuXgksXyIfHKBlFIzdZDAw2cofuF5/6BS4dzwBJU06qzxVFJQwe1xQ5YAO0Z2eN4wLqBVRQXPEkFKenzhAsBISD128zaUONoaZ83LaXUNgc71UYINtiXUOqk4OnxDnNyDIaWzR82So1LxqKC3kFPHRxh+OTyq5vaR+wJ7mjqrQ8t5WhsvBSLTybvqLMjprZEfB0Qtw710qkyf7xASLg2SxwqSbQoIDmpVGlie23MCMtj9cWoV46E/RxfcxCrDo363B9pmwlea2Mw41/OON+HdjbIkIkM1tegcMEKjEfMrXE6ShICMHReQiDp38v0gyDL0BKZZ4jQG1z7prrYPQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec8fb4b-f0fc-493b-86c5-08d886dd83a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 07:35:22.6429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06++NTYi7Cq+ZasMi4u1elNBPLuaq71kyP6t4v6YxFbuvvs+f2bRa7olMHqpmOpdhDl026LiO+x9UPRRa1cnpJ49u5nImTzo+yG7umpbsWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2319
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/2020 08:00, Anand Jain wrote:=0A=
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c=0A=
>> index 8840a4fa81eb..ed55014fd1bd 100644=0A=
>> --- a/fs/btrfs/super.c=0A=
>> +++ b/fs/btrfs/super.c=0A=
>> @@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)=0A=
>>   #endif=0A=
>>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY=0A=
>>   			", ref-verify=3Don"=0A=
>> +#endif=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>> +			", zoned=3Dyes"=0A=
>> +#else=0A=
>> +			", zoned=3Dno"=0A=
>>   #endif=0A=
> IMO, we don't need this, as most of the generic kernel will be compiled=
=0A=
> with the CONFIG_BLK_DEV_ZONED defined.=0A=
> For review purpose we may want to know if the mounted device=0A=
> is a zoned device. So log of zone device and its type may be useful=0A=
> when we have verified the zoned devices in the open_ctree().=0A=
> =0A=
=0A=
David explicitly asked for this in [1] so we included it.=0A=
=0A=
[1] https://lore.kernel.org/linux-btrfs/20201013155301.GE6756@twin.jikos.cz=
=0A=
