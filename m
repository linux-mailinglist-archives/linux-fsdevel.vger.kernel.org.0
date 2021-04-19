Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36F363E9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhDSJgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 05:36:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20182 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237771AbhDSJgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618824941; x=1650360941;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jRHAbdA4mx9WO24xHUfkbr4wGF5F6ZIa1Be8kGe92yE=;
  b=X2+fp5+LAOr5G1UuGo0cchF1I41J7bUN3LEwSjcz5Q47Q0uH8iR/K3qq
   PeHjO5zbc3amqUI+DAUNCae0/6Hz0BW2B/PnVMnMwLVDmfx0QlF9Dn4Kr
   knAPzciRrBiZNSe0c9uPIdRdxygQ1mLdDIkpNM8ekcZ95uEsHnlJBzkPX
   cA1s10LKLWFYqoU4Rv5KwvnzRdO0G9YyvCDtEXqTW6whyKg+kx9nb7syT
   ejDfieHuLCt3MYaOgK+gH71Lgm/Hfi547ickcjDe1pcyZ90sBFoxwv2HL
   iozhoa2IIVI1gqWQpjZXO/ghAPja9uvLISLkecU1Hfa8msNm11EZVvJvd
   w==;
IronPort-SDR: hplLCupomygUW4XTFwNVLOjXkk4yTxAxaOIh1xpcIKHDBJ6vAMJyG8+D2kRVYawTCTtaTmGE3E
 SbY/6H2Q8vCl0KdOkI0fxicthTy23/TzzsKxT+sQhUH53BXxlpKRWx6L58/6EKJpVVFtK5gsxG
 AF/6lgA6AP4sbwIJEygtYxNJQLU84iiP7I6lS5uzHaC/Fwh/D+wC9XKhLmwsXWEZbYSwfKrCvA
 +5Rs8n7Q91H/hp+lNuTJUEL1VnPqRVbRqglMt/vX0qcT1hcI2CNzm2YW07qXaD0uscFXJcddYe
 MJU=
X-IronPort-AV: E=Sophos;i="5.82,233,1613404800"; 
   d="scan'208";a="165974672"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2021 17:35:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J89rXZtl5wqZ57b+bbp8AhWVlUyvVaDAp8W8Z33526IoRlTINiqbHIJhuhEgKeRRDRhO+HgyBpMH8e6eLQlpqiSPUZJ7VZavZs12IedWNw45JyIkU7f4N5tUjXCB4Bk+J57U1JTgG1iVZF3kCZ91BK1MosDkMIBfHLsOjXSkoXYMZEH2wm89N7/ENkY9mjwGkMehOuENXIzHnPpN6fJ2KXbH6u793q+hNuEwgCGI92tUyftD+okkdxFqJe2LG07wCPIwRpwiVbqYfe6GJjFrq4hHnk90lxQ+iiMS4f8110YqCEMpm4RG1yQbcQ4vQodgyb26Q5GB8Oitlz81ibAjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCHTx9lwi/EL3YhPVpgIPjcvrNGy71wy43zMZ6Rwa4E=;
 b=m2NvNyW6zUpU7wWKqG/tjturFdzW2qwroLoObf8ycgHBgxd1Asv+IUevMzMy6V3/ie895TKO8AS5kQwdkn9SixEQLs98ljnPokkyEsaNIG9MIQKzSKe5iJtoKhIvPQeCq81p6rZtRxNRpkrTvADXD3JAymOMJKMAdLUzMBks2xkrEnOubSlGaIq29aL0AoMWdHoXtVMOXyNJ/D4OZPAVjjWqg3gh9EqCJsjBKvQA/P/mkSVLR4hyK+lGo+wtjrrjznokqH4Wc7Q59iTvgUXZafTMU5VT+7aqwjt444dIqktpJdyMh3sv20HryTYE6NC+5Q9iaRk86680r7AZxPD5KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCHTx9lwi/EL3YhPVpgIPjcvrNGy71wy43zMZ6Rwa4E=;
 b=j71iE+Ue3IH3m0LcS3xI4oOPIRgV/2cYocnp3aFV6U7tUjF08csT3ApStz04w9zh0o/zSQuaQgDbwZeu8r0Ch8mbdKQGzSIYbPLFuOdpdoiD/eWxFAE67Qo/JVZfs0RIjRG2cUevZTqeV0ZrYBVKH5L8cRjq3l/1zBGTwhMJ520=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (52.135.46.87) by
 MN2PR04MB7039.namprd04.prod.outlook.com (10.186.147.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.18; Mon, 19 Apr 2021 09:35:37 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 09:35:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Thread-Topic: [PATCH 3/4] btrfs: zoned: fail mount if the device does not
 support zone append
Thread-Index: AQHXMm1j7e+Wo1nHt0KL4N4KN5ZXHw==
Date:   Mon, 19 Apr 2021 09:35:37 +0000
Message-ID: <BL0PR04MB651459AE484861FD4EA20669E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-4-damien.lemoal@wdc.com>
 <20210416161720.GA7604@twin.jikos.cz>
 <20210419092855.GA3223318@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:d019:11b6:a627:87d8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b539474-0490-4a3a-d5bd-08d903167d20
x-ms-traffictypediagnostic: MN2PR04MB7039:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB703970456CCF5EC78D38EFCAE7499@MN2PR04MB7039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RvnMZB6zkIDWqR3vM7k6GER72fv5eyeHwoTWklKHOwa3NoxPNVKWRoc+H0dDr93XpKNYBEwTQplEVfBWnWKjRBcJueg+JjGqO+Y/7yZgPAPlUj26xr+hIYIiUdiMEEtrtvqbdgJ7RY5EGSE9Tvd0euEWyh5DNCtqo1TqwllxgbkK5BdwKEKKSU0eGEeS3NH2mJLjDJAjs5iUb9t+zGppIz6lM1AmT4mPVvNO+9fTHtmgzgDOJbIxRkL93ClBDreovnivOKtLpRdduupBGaZHX55nLAkIH7UA+yGUt6/qvNlOSk9pH9IL3JM3CaE+OrNSl4kQFXruycduQeB5d1kYPsmeqwU6NNySDT80oHir/0M/rO/KDfz1B6LVeOGtNbYcwk4txuzGdfFHxdwM71oyyouLTLvT9iQDpYOqmfnGTL8P06WSafzXdoVySCTyP+zZlp8g+TVrT+FSfgJTUKwZBY8C5ZpSdO0wGUbHDAGy1lEn/HnlB+frnzqgl7okCEVrVMzUwXKofS+ULEvoEH574LZyLHBct7vY2vIEUyZGnONH9unQ2UOa8IbugAs9NPgDS+ahj399+QBX88Z0ycCd5lHbB4pk6Nfo1VqnIFaFtQnLBPl9QbRePYq26f90+AjphdBtvwz7QYtS65neSB4O1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(6636002)(76116006)(86362001)(91956017)(55016002)(33656002)(66556008)(9686003)(8936002)(66946007)(186003)(316002)(478600001)(110136005)(8676002)(66446008)(2906002)(66476007)(64756008)(71200400001)(921005)(5660300002)(38100700002)(122000001)(6506007)(7696005)(52536014)(53546011)(83380400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6EsK1XpSP/s9Xf0QvzFihInUqZOFsscYGSIegwkk9kxKSTjp9ShaUepGtY3W?=
 =?us-ascii?Q?flVfiSbyih6PDa7mF1X5C2ceV7LXE/T1XGxg59C/l/mfV/dd2WYUKhSif9t2?=
 =?us-ascii?Q?k5nF70AC+MmFq8mw0MJds9XqZnUsH99BSbJ1n4Y5JiRoN438p4sMRVb2DicK?=
 =?us-ascii?Q?ke8xi8kkVmhee+VzYo9Z02TO7hT6TlCv1G+mYi2V9mnoKdedHx2rnZh4jX4G?=
 =?us-ascii?Q?fFodD29TVXgtHDwEfvmwqKGi5ZEhFJeIr3lr3D49WzzM0y7myFIri8IjuqwD?=
 =?us-ascii?Q?KH8YGVZT0SBdO+dLVlrI7ShGy7N/xfuzoEg3lqrkWReSd0p2rQQw/EWEEelr?=
 =?us-ascii?Q?rW2uf8L2ecP99+S1prkWIDRHAs4HEnfemYz/f4cTAbuosOnzT4/45JvzVvNX?=
 =?us-ascii?Q?O7Hois6GrWYzFphaMYB4o9XVlbfjsH50T/v3w1IN8Bi58ptwGRSlnUI7EeL5?=
 =?us-ascii?Q?m7521W82zINAErzt6sP9ikwyhR66HmsEUY2ICHvIeVtmkf6vGwMscHGYzNjj?=
 =?us-ascii?Q?R8JHoIt+lJPNpTjM7NrgJywkJ/lVHI4z4zgOqPmrnXbb8dZs+I9/njJwJvcj?=
 =?us-ascii?Q?De/O7DH5xc7xm3evjLmT66P5S9/kXZiVyYZtKkj2M7CuBLNIXMK+nlVLKA7l?=
 =?us-ascii?Q?z4WW89R0ARv3r7Gb44PkHiQ1xJBYJBO2ZehVBDBKJkBqmqUhRpde8RXWDi7g?=
 =?us-ascii?Q?D8N4ltf3PlSGOdTGXNPpDkBeYfMU63OtcXK+R9rHTGEDuY3bCPuwCwVX9fMe?=
 =?us-ascii?Q?c6/2DfiMhm0TdWAZvUTAY8tQje4lfhP0gI/BOu//4StFOT0h+CDqQiYPYMuO?=
 =?us-ascii?Q?gMJX0WalRgl+LC3rK9TI6Y/WP4DWjr7l1awendABzWKwOtluCgmZjEOEca6n?=
 =?us-ascii?Q?mQftdQ8yryb0hNvrkTyq0Sd8CzjONjhU/i7Z3EmZ1v6almlZQe+iwZ6eOt2p?=
 =?us-ascii?Q?wt9ntpGmnBYCGJGQxh7C5ucsX1382Xw/MY53ltOLplG8ycwL4V9nK6owUTTZ?=
 =?us-ascii?Q?MdkjIymtJC+wI318fyGTMTuyXbiVMCZwMhVw7/7UHcqMI1V714GWdWbaoyMB?=
 =?us-ascii?Q?ie3xfmXy7ldFvg5Cr0fuA9B/qog2tD7D1EIhzLtv6bbFdz0N9ro/xtfVlL0U?=
 =?us-ascii?Q?UO99jqbAxsHmibnINUdswBBYoO09jaaiMQskTBvy3zJwREPlYPJKcOZniKTr?=
 =?us-ascii?Q?RVyV9NJvMvTICh73AV6HyOQ6hhicecup73jPG5P6yWzEpIgzo+HiCyCZPiqG?=
 =?us-ascii?Q?dqxf1TqOM4sm+lxsbvdMEXee+w7kxQFPiMdsGdVpR2X30qfi9axTVy5NqU0O?=
 =?us-ascii?Q?m3vrnuyKgKQo1ijmPHyls1uEnF2ty9pSLp4JQEWIBdhymHAX5V3+ABIUUUHD?=
 =?us-ascii?Q?3bbfK7EJ9tUWxTTUripDdME7KylLjsaANqZXDvPL66DifrqBNw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b539474-0490-4a3a-d5bd-08d903167d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 09:35:37.2396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5JPWFb4AFdDQmXWyS6K+qq8CYaeYTtmRHrm9VLi7mmkVvFXlEzeDe5gL9XMzmlL6bl3kcF6OTCQLI4SiPu89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7039
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/19 18:29, Christoph Hellwig wrote:=0A=
> On Fri, Apr 16, 2021 at 06:17:21PM +0200, David Sterba wrote:=0A=
>> On Fri, Apr 16, 2021 at 12:05:27PM +0900, Damien Le Moal wrote:=0A=
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>>> For zoned btrfs, zone append is mandatory to write to a sequential writ=
e=0A=
>>> only zone, otherwise parallel writes to the same zone could result in=
=0A=
>>> unaligned write errors.=0A=
>>>=0A=
>>> If a zoned block device does not support zone append (e.g. a dm-crypt=
=0A=
>>> zoned device using a non-NULL IV cypher), fail to mount.=0A=
>>>=0A=
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>=0A=
>> Added to misc-next, thanks. I'll queue it for 5.13, it's not an urgent=
=0A=
>> fix for 5.12 release but i'll tag it as stable so it'll apear in 5.12.x=
=0A=
>> later.=0A=
> =0A=
> Please don't.  Zone append is a strict requirement for zoned devices,=0A=
> no need to add cargo cult code like this everywhere.=0A=
=0A=
This is only to avoid someone from running zoned-btrfs on top of dm-crypt.=
=0A=
Without this patch, mount will be OK and file data writes will also actuall=
y be=0A=
OK. But all reads will miserably fail... I would rather have this patch in =
than=0A=
deal with the "bug reports" about btrfs failing to read files. No ?=0A=
=0A=
Note that like you, I dislike having to add such code. But it was my oversi=
ght=0A=
when I worked on getting dm-crypt to work on zoned drives. Zone append was=
=0A=
overlooked at that time... My bad, really.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
