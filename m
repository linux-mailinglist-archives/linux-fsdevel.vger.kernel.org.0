Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967522CA0DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 12:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgLALEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 06:04:45 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43828 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLALEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606820683; x=1638356683;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8V2cS4wYBTOXhHlzdzAa0Yy414SlZBJtC7xnHwLpus=;
  b=OMFM21EbZzh16pw5zPN3BK8winqlZiTOWV7cO0ripMkGau7S7eYyR3p6
   G2UPeKvZuoiWgC6tiFIUJmhCFP7EcfKL6MPDczL/hDrcvqwb0QFuk6Tt7
   2PngfTtQsXHNTC04VMa+I2RhPba7NhyPGVd2eoKdGJWDyCJ83p7/39PJs
   Px+m2SpRe3EuinoPMsR0DR3qhgpSPkHpuMGtu7EVLiT00+wjszOvw+8A4
   RYNfRy58FlbEzJVOWOsuk1hUzmIr66yPbeAw3qNX9DsVm2aM5NqO37u8z
   V1xpcD13F5H1y3/CJ99/mZqFoDVKFtvLmTW4BC7dI1FJnzcPtEWhqalgd
   w==;
IronPort-SDR: B1LjxdkOfPeVlqmJTJaXgMMk3lvf+jDexsDY1L/36oVE0ci/CxPRl23h7IcDmfCZ3rqmWMR50I
 dx2w3FfEBz+wJ5L1oIc0IKoxUUovhPFh/iarhluuur78RQggPmah3tOl0m4y2yQjqTIxpD/mR4
 jwgfPde47yTIB97b23EO0OsSS8ZCBpnYqr+GFHWHXwZBqMYJujR1ldXlrTl9IsokNOm61eezoy
 iDdYIqK7sznJEW8wOBulhcyAtF5/8l/bUo6Lb0xZc2eifI/eUADw/PIHIDr79SQWt31mNdfYMv
 /Wc=
X-IronPort-AV: E=Sophos;i="5.78,384,1599494400"; 
   d="scan'208";a="153844047"
Received: from mail-bn8nam08lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 19:03:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHzBEKjouLCnxYwW8czufK9cUB7JwnxLzNnQTFLr1BfMOS7x8cBLTQDE0WiYtSdmFW6Bm4jFSHAp2VGFU0W41tCmZRwzMzNZAn73w6IQyaCzAeSDmw8c/+n7KsTZPRv1PjKrr95E77F7ER06gHS7NHxvTHYm6QsJFeFxEWHxizdFrZ0lrDr72LYGbWFgAWx47OtK/Valwbs0Qouhr0dpF5hng3jbg7L00YxnTaUvFgPns07dyo5NHojtiQ/8d1wveRzmFaLVLLc8OG5PbtZmwpbjOrUDJK6lbiL37T/tiC2QoRr6Yh1cwY9gxZvV4d8jfygEzL0SZEX0ch4MDSOdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHPjIXqrn8/GaJR8QVlBpVPKyJcIC/Y69JwmaXfxXNI=;
 b=YLjcMrEa+eSP9+aEUsbljcffCbWNiZfqoAs644XDEYY7YIkXcmlZi1icpIEoZlG9+MnqdfBpa8i+j2TOWi0SM4pOfRLPtHQk+1lgaujrm400l7dT/Su5w+bOBMz91MZLurSgkERUSbMObw5PNjKtl+fUDhE1VfN+nUsjKyxtEAdHD7YhRW/3MubZ/uUbNjt4i7XCrLsjG5lKfNMMZIXblKreP0C94BJ302+zQpAIjUDveejFHWRZ9XRiqWTh6rxY3oRtdH1fKpkHnCrtJJhgI8leYuKdaacN+jxsJ+G03btqT22aUxHz5fodOVseF/RZCExonyVwbuxY2bHnAZl2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHPjIXqrn8/GaJR8QVlBpVPKyJcIC/Y69JwmaXfxXNI=;
 b=oW7uzD2NsVmEOn+I3VigpiemI4xnDh6x9qpQgQDWqhQIXTpOauTwKUbJO7zsdnf0E+8doISwVax7eS4L6mTjEJtauLjt2AZA1/fRMpXFuNfZDNaqztbTmJ4gF0rn9RJ5U0ayAa+05W2NKdO0w/HSz51LayK+Q1RrgyZkQALaUb0=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6726.namprd04.prod.outlook.com (2603:10b6:610:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Tue, 1 Dec
 2020 11:03:35 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 11:03:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Thread-Topic: [PATCH v10 05/41] btrfs: check and enable ZONED mode
Thread-Index: AQHWt1SX6TBkGrIRlEa+5WXQUx+StA==
Date:   Tue, 1 Dec 2020 11:03:35 +0000
Message-ID: <CH2PR04MB6522151758FE8FD0ECBCB09EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <104218b8d66fec2e4121203b90e7673ddac19d6a.1605007036.git.naohiro.aota@wdc.com>
 <51c91510-6014-0dee-a456-b50648f48156@oracle.com>
 <20201127184439.GB6430@twin.jikos.cz>
 <e3d212c1-057e-a761-6dc2-767f1e82c748@oracle.com>
 <CH2PR04MB6522A370F9D092A42E22527BE7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <4a784d16-b325-bf32-5ce5-0718c6bce252@oracle.com>
 <CH2PR04MB65221794BF271B9A0E76388EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <1dc43899-82de-564f-6e52-bd5b990f3887@cobb.uk.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cobb.uk.net; dkim=none (message not signed)
 header.d=none;cobb.uk.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3a89302-af2e-4806-b7e3-08d895e8bfaf
x-ms-traffictypediagnostic: CH2PR04MB6726:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB67263F6C5B4390375825C875E7F40@CH2PR04MB6726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SxkTPOGSs2BwyjL7pYD2KnO8k8uLXno75rDJspK1wLYx1r9gYxXNap+M/p7olCdGecgI42J2m8ChsJY7p07znigMGVwFC6zl9QL1WFIrcTLNhQOHHEPtlNs5rYQnYXvzzTgH8uWm84rDH5MqBHP2RmMnObzu+yCYRoYlrxXRa0LO14RlHnRg08bKdT3ZrB8EL3TlSdbqs1LhBjVXsTTP5Dqp2zrWbuExXx+eCYwHIJEVW782FcKKYvfeyuQ3LoaIsMOdfXrHb+LybpbOJGbONfCOWkiYdq+Eslc6Xf5bGZ4wJnMI93+RefXanOvKeR4L/uTHCOEx99Mh4VyCUMXYu8Nx5M/ePIxViLCm5+yfEk3heYlykS9pKpn21qo2HMt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(9686003)(110136005)(7416002)(55016002)(33656002)(71200400001)(86362001)(478600001)(7696005)(2906002)(8676002)(5660300002)(26005)(83380400001)(52536014)(66446008)(921005)(186003)(91956017)(6506007)(76116006)(66476007)(8936002)(66556008)(316002)(53546011)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tsCvbttu1GQikjt1Svlh/v7G9oFNA88fpTNtsySfwhit8Q1Py+PgcwQ/yIXj?=
 =?us-ascii?Q?1m+1hWoqmuY7Ro17qioDyeAU4a4wA2v7Mj6axUM3cHyvH4ukD8qv/txYxbia?=
 =?us-ascii?Q?8TTCEzSCUxTM1vRpHB+c8jwkK36uCJIzumJk0TUivDZ5dFJf5IH008FnA2XM?=
 =?us-ascii?Q?LVKPy/9jExn/2UTpFFX7vDi/kbwQOv7nwv7Zdz/WGZtBlmNA3XDY2M5fn0Hs?=
 =?us-ascii?Q?PizXv1sHxzOyGAOel+X/JB1WSBb93rn25xP+Rh97nDcE90+SC9ruUgjnPXJt?=
 =?us-ascii?Q?8qsy+lynV/WcviXrNQSudV/YT7bIU/7vl6aOGLa1D6WDZPOwYuDhjmEqoyLy?=
 =?us-ascii?Q?qwb3ICtuPAtpvwFeKfQRwWH16xmU5aoq0MXuqv0+eIWnnhqvvo+pvHvVBy+i?=
 =?us-ascii?Q?fw/s6WWHLkP4Pg+/th9KbLGGJuedwcww12vr2UGH6rjX8SSi2Z1I0AmD8KHy?=
 =?us-ascii?Q?Wi+QHVfwaS6lWzAN/Wy5t/Kv2dFBykJZlmb1RaN5sjYSwM75vZg2GlC9p5d6?=
 =?us-ascii?Q?DWMrdHEVEL4459CwcfEpiYZACR5XK8QRTl3dJbUOj//Cr84TJ/+JMhp7wF06?=
 =?us-ascii?Q?EPmI8I5/pLrCgbwM9dh70+FYfOSYhCNknQMze7ZCf723RqH1eWxioP/E6Lxn?=
 =?us-ascii?Q?xpP9oheJs7Xop6s+t4LDcBdCFYYSO1cxifJB1tsalCRAhGGsdQD3VrZ+ZPcB?=
 =?us-ascii?Q?wgVS9S5W39iUpcbL1+KMNPxTIeKugj9bj+3n49qSOglFFyNTwNnoAP7Hp5GU?=
 =?us-ascii?Q?/u5AqCjHiV94fETeVOHIgRLjUBeLtJzFg5/vKR3BL2S+aNblfRSheY0bRQzf?=
 =?us-ascii?Q?sABcpaxx8SwKiQQfHFuEyzfSDUYa5vI/T5nfV0D6BZg4MAaWHC12GsV7Gi5D?=
 =?us-ascii?Q?ZxPKYT6OQE/VacgTgEpebVkXoZUIUdmQ0jXHkyJYrznFs2duyqXGJ6oHUbdx?=
 =?us-ascii?Q?QqQoM2hq9t43e3n6qr8bZs3yvwjTnbHmP0qefhqO4bSvKUWI6YiO9AwFeUfz?=
 =?us-ascii?Q?8pRd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a89302-af2e-4806-b7e3-08d895e8bfaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 11:03:35.2984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdCjDjRajl9RSKGb4y4OGd1iwtcN5O9UfRw+rCEjqpGf5ISN7j/r68kjJtpkdjWerqcdpYC2eSSFR9qGi2/KLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6726
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/12/01 19:45, Graham Cobb wrote:=0A=
> On 01/12/2020 02:29, Damien Le Moal wrote:=0A=
>> Yes. These drives are fully backward compatible and accept random writes=
=0A=
>> anywhere. Performance however is potentially a different story as the dr=
ive will=0A=
>> eventually need to do internal garbage collection of some sort, exactly =
like an=0A=
>> SSD, but definitely not at SSD speeds :)=0A=
>>=0A=
>>>   Are we ok to replace an HM device with a HA device? Or add a HA devic=
e =0A=
>>> to a btrfs on an HM device.=0A=
>>=0A=
>> We have a choice here: we can treat HA drives as regular devices or trea=
t them=0A=
>> as HM devices. Anything in between does not make sense. I am fine either=
 way,=0A=
>> the main reason being that there are no HA drive on the market today tha=
t I know=0A=
>> of (this model did not have a lot of success due to the potentially very=
=0A=
>> unpredictable performance depending on the use case).=0A=
> =0A=
> So there will be no testing against HA drives? And no btrfs developers=0A=
> will have one? And they have very different timing and possibly failure=
=0A=
> modes from "normal" disks when they do GC?=0A=
> =0A=
> I think there is no option but to disallow them. If HA drives start to=0A=
> appear in significant numbers then that would be easy enough to change,=
=0A=
> after suitable testing.=0A=
=0A=
Works for me. Even simpler :)=0A=
=0A=
> =0A=
>> Of note is that a host-aware drive will be reported by the block layer a=
s=0A=
>> BLK_ZONED_HA only as long as the drive does not have any partition. If i=
t does,=0A=
>> then the block layer will treat the drive as a regular disk.=0A=
> =0A=
> That is a bit of a shame. With that unfortunate decision in the block=0A=
> layer, system managers need to realise that partitioning an HA disk=0A=
> means they may be entering territory untested by their filesystem.=0A=
=0A=
Well, not really. HA drives, per specifications, are backward compatible. I=
f=0A=
they are partitioned, the block layer will force a regular drive mode use,=
=0A=
hiding their zoned interface, which is completely optional to use in the fi=
rst=0A=
place.=0A=
=0A=
If by "untested territory" you mean the possibility of hitting drive FW bug=
s=0A=
coming from the added complexity of internal GC, then I would argue that th=
is is=0A=
a common territory for any FS on any drive, especially SSDs: device FW bugs=
 do=0A=
exist and show up from time to time, even on the simplest of drives.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
