Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D945A1A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhKWLmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:42:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7141 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhKWLmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637667554; x=1669203554;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=evi0NnWOKew5c52fe6/PtYwRc6dAzDfZG5TEVRfFiqQ=;
  b=NGCNsmxZHe8WnJnNbBg5K6a4Y882NtJ63CGv98WqKI4LJhrnSBK4Rauu
   T+NfV8MIfSwtjvDwOEL5O9v1fd5IheindQEMgxi3QMk0lgYbHYqei5ELT
   BHO+C1lJsFz/uU9A//Z2fPOniiyw5ahqCzpfBawu0UdPHFYImmKNNB0/N
   rp7IoBm5/2D+R/aFFmiq8V/ReTuh8u+a4V2Pm+ux2XrAja7lqiakd0ddg
   MQkvshlVVZUFkrOMbi1dBTFgJYI7ZdmGHriA8uFqHn3TD4nEmRovbOYRq
   Uv3PYidoLT6RzFwQOGf7/XHdhP/LoC8UkR5ubEDfQazwxFMLnUqxbn17Y
   w==;
X-IronPort-AV: E=Sophos;i="5.87,257,1631548800"; 
   d="scan'208";a="290347587"
Received: from mail-bn8nam08lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2021 19:39:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghqMCb4hLIKUXR3XkYhJfDD8NBcBBansbQuFTqg+hhYHFbvvXRR2zBC5+DOTGtmrz889gMN5okI6N8fQ7CVL/6rENCKwdkumvbpMY8FFIFJip9dneKXouLskkW/ID0WoQbOBLNMGnzWHcBYH/N/5r4ApuWYr9zl1GxjAeJegKojFRh1fVFM8EM7N9Hjn/Ym/OifelvI89wGGFWtQ/NaDLUT0iQd3RsjYhxbkQ/e22dcMxYtywSCBT2pZTErjwyrXMHBQpDXoNsa+E6V0ZbnoTbPZWFDHrm0+K5IMsuJs2R89xOpvLRR/Co9+Fh0VWgt7NZ10SDD3gAy3JXRuWZAofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evi0NnWOKew5c52fe6/PtYwRc6dAzDfZG5TEVRfFiqQ=;
 b=T3ii/8KH76x387KeCxXUJcqObdzZRnh5HleqqoKiIr88lGS3W95sT3olHFgF45afOeM/23sSrAtjUdBQwE5Dy0KtVfyT5wHuOCeTtu7xuCwobGRHWKlR7p6J0wV17LyXvvHdjpyjrt7A4/Cx+Ipscqq/cMzezu7KZhhb4vSC8f1nHCoypJWMYDJQVdIJra7YbCrE49xr8P961kUaFdCMwZNrDpFT4wxXwsXkwVMrArN39gL+cxh9huagQNFcajSlR4U98IPs+/90ORbc7bpE9oXmJRfHcOvZ/JYax52pq7jlbhAeNBAaFmKj71Ilm1mV1cejmZFzcLjx4iNfvA0rLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evi0NnWOKew5c52fe6/PtYwRc6dAzDfZG5TEVRfFiqQ=;
 b=V0WwWSf9CukQx9TvgMoGTaBKQLsmMdiJSkp+yH+5jE8qMRjFmIY/F3E3a7l26lXb6JjnNsKBKBUmTdqS6SmXlrqpsXYgNKsA5fDbyM+IQdJYKePD1iXcEPUWw8vTkClXrt9Es1ZSlonPyvyHmlO3sVyv3lCSV+wXIgFaPTuVGc4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7269.namprd04.prod.outlook.com (2603:10b6:510:1c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 11:39:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%4]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 11:39:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Thread-Topic: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Thread-Index: AQHX4DWb7uOWhTA3AU6HTXic8besFg==
Date:   Tue, 23 Nov 2021 11:39:11 +0000
Message-ID: <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
 <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9238427-5fe0-4d6a-3ee4-08d9ae75de75
x-ms-traffictypediagnostic: PH0PR04MB7269:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <PH0PR04MB7269A31A836B201A0FAB4FA49B609@PH0PR04MB7269.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vb+bLAFUQVz46qAhkrPg22QNuXGL7vm9JIwRKOgKuevmJSLLFEJ1UzSxc/jF39EXzZb38sLMuUahLW741L42u1uqp2v2kWP2dULr6fGKb3LHq6CJNRTcGP7XUM4BtarCT61RE4BdalvWunWDke5os1jDmErtb0KQRZPdsgnRQKnuiyZOjvIeJrEhnsruBjIVlv2RtaYzXahK/0ZfjtUJaIO8aTKkEE6i2W4sxN2pkINW+EJs3gu8KpM682KB7CGVPMb4vp3cV1LrMN5o4lIrrLDQ10d5NdCPi6/JHeM8+6MU+ytTWW0CBZuGNWfTPG5dxEhcqhI6LTaFGkQPc8YbZmBo19OF/PGXTvjw6SMqK/v0Cc1JqLqPebJvStYtnBbpjMx39BfPleeGLqok7fxHAFSPHFMeinUhotfNTSl8zXgYa7eRaCqzWkXAM05QxELg8wKcmQnexuLyMlLrlYn8yJ/GUjwixQtBFvUt8L7lY8u2eXEoCzzkhYk13OQLDuvXFhokg8Niq+LXwKe8kNRZZKq8huZ337mR9H3tI+wY3ll0eiYqIcXNEV8BrufPJOu/p/xXnEczYl2KYgwYUyJt6taFVWjImNcpUj8Ps2XShFtpNZzAg/GAjsh4D4YpOKyVEUcJ3TCzYdBLharMlpu6dlnWQASbDKCRue1s7feJYRCHT5H9XTjv0frtXvaaUblpFk8+Qhvndczodn+UryHPxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(26005)(53546011)(86362001)(6506007)(52536014)(38100700002)(38070700005)(2906002)(186003)(122000001)(5660300002)(4326008)(83380400001)(82960400001)(508600001)(54906003)(8676002)(316002)(9686003)(110136005)(76116006)(91956017)(7696005)(33656002)(64756008)(66446008)(66946007)(66556008)(71200400001)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?85jhfB7nnSNHPVW7+ZRdyK78XP3SEumdGjMHRSKDrxOZ2i0rYcbJUayGoYMu?=
 =?us-ascii?Q?4LYWLgEwrcCx1b4qqxt1xihrkKJZ2RoMeO3qSzghi5VA5Lav/3p/xLbAp9Tn?=
 =?us-ascii?Q?stTgh2LVWk5JEfuDDtsWQcdce36sULusXQIW3ReCRvtITN5dp3W1nyW0AvIp?=
 =?us-ascii?Q?gyFRnWA9xi6DR6O58+AaIL1X5y69HPqc40PgPO0oiE0eaWz4GEB2KpUTmUTc?=
 =?us-ascii?Q?yspC/PEndpjRtrqRFMgXmLbqmSkT6iwIviu1U8NOwx5WXXuw012Zhl9NPpkd?=
 =?us-ascii?Q?+NvGa75iUb36TERO6OCkWgL/w/WzoIE1eTH+t8xSoJ1CBXuDutbNN0O7hPvV?=
 =?us-ascii?Q?tO02pKTn9LkuUZc0xxSR65EXHoEnop+FYTjii2MyspqnVXYSvrHifaBrV1Zq?=
 =?us-ascii?Q?0gTtxbFTNQsieEQK7OGy3o/kDbuVbYhvvnNYYbrG7ETQnws43ZcRtxT2SLCH?=
 =?us-ascii?Q?ups76JQiiIoGdbRa5eOhtSAhgCkcS6srR5dGDjf+cXME08yUL2StJhLer4OR?=
 =?us-ascii?Q?Gnw4QkyYSxgBM4X5BWrf0VpLTKbT2aWowDIL8FRdYcZX/jUjCrtPAfo4or1d?=
 =?us-ascii?Q?CA/PXWLfJcVmX4HHh3+dUJ2ON/vEq++EjlJa7OlgHIG3HpVOiBLaFk7lMIaN?=
 =?us-ascii?Q?4CqkOgZouZ0wPcDFpjAq/AI1FGmBezudYoegU7xm7l9hRjR8SNUFzkS3lk9H?=
 =?us-ascii?Q?oG6tCzGMgVtuvL/a387+HP1LVKIbZqC53cMH34YSQ1gONk72BWPfQcdZxcRL?=
 =?us-ascii?Q?wyPeOOov3C3D4R9n3jeofpOmdn1LL6OdpWlsmz8AYHlksAVuWjfn336ad95M?=
 =?us-ascii?Q?Re7t5yfcR5iv4bZ02KwrdF3KWahgjEbK7dBkUkmBp3QMrOs30IA1oJDEN0cI?=
 =?us-ascii?Q?VXsF/7nvmP8FNT8W1p/boO59kwqUISj56/XOLbCaBjmE0lhh1TN42nlDpnrt?=
 =?us-ascii?Q?+Ib4Kmlch2M3V5DU+MJTL7sk2AnXxGQ8+u555e1QqepBjkDyF1su9C4F2llP?=
 =?us-ascii?Q?R4Y20SKQikFXz4Nq2gKZKU5n98aZQb1gytYICzoiiESq4Ix2uRIubWsnELab?=
 =?us-ascii?Q?GZylsKVdNY3YAz/ud8DQbXumj0YDeMnPP6lg5utpAo02hooDfaUHVBwaNJlU?=
 =?us-ascii?Q?BBE6HaW5rl+lSuHkADHCbtvWiXc/JlvBD9yMRuXSDvWgm7QQj6LV6jRCiZkv?=
 =?us-ascii?Q?9r3tr/6BRcDLxxwbkFPDrBeGCNnm/JA65tN/RnppnqIrtLXpYlFb7cFoNPZM?=
 =?us-ascii?Q?o36GMnTiVvjGiOdAt+b9CiUERNq+4jPjOHZUmLWOeZQr2Tdfa7vgsXX4M9gn?=
 =?us-ascii?Q?9TQTqj61hsRSaFDnOjHYMaQujq+ifQjLqcODm1Vw1XPua6UL8IlJqNJfBPnt?=
 =?us-ascii?Q?+kVRu2ev8Ph5DMnlK3j96UJVorFvVgcrCT4paRFBLTS1Y3NGlJnJCy8w8OIf?=
 =?us-ascii?Q?xhkJA8ZIVppHQ2V7cEXLwbNY74phdYIt0MaWhFKFr+yZc3BOlXDZ8zemdauv?=
 =?us-ascii?Q?QPG+fySgYvXhknfcKaKevZLekRrrceyEJu2qMXkivfz9v45I7KNmuKqmlAcX?=
 =?us-ascii?Q?RQ9iyFF3GZrczZA46RRKOfSRkVFz0xfZ0sLKQpcRiCTdg/nS4Co49CKNDdWK?=
 =?us-ascii?Q?w7DsWkoYck0QAHfnYQpMD0AD9Tr18GITn2ruTjk5eDbYKyTU1OzEPrKRR8Sc?=
 =?us-ascii?Q?4yDOYUV0MsEOgBUkNtn6HYIU56M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9238427-5fe0-4d6a-3ee4-08d9ae75de75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 11:39:11.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEAvvAbabcGd45NM8ISwvxKT+gPxQrVVGt/EvQARxCvbGHB9hy8DjknJJ05hyQcKAZQyWN/q/lCEVyr1RMKCb2h8uIo6lyDtf0YadW/AeGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7269
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/11/2021 12:09, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/11/23 16:13, Christoph Hellwig wrote:=0A=
>> On Tue, Nov 23, 2021 at 04:10:35PM +0800, Qu Wenruo wrote:=0A=
>>> Without bio_chain() sounds pretty good, as we can still utilize=0A=
>>> bi_end_io and bi_private.=0A=
>>>=0A=
>>> But this also means, we're now responsible not to release the source bi=
o=0A=
>>> since it has the real bi_io_vec.=0A=
>>=0A=
>> Just call bio_inc_remaining before submitting the cloned bio, and then=
=0A=
>> call bio_endio on the root bio every time a clone completes.=0A=
>>=0A=
> Yeah, that sounds pretty good for regular usage.=0A=
> =0A=
> But there is another very tricky case involved.=0A=
> =0A=
> For btrfs, it supports zoned device, thus we have special calls sites to=
=0A=
> switch between bio_add_page() and bio_add_zoned_append_page().=0A=
> =0A=
> But zoned write can't not be split, nor there is an easy way to directly=
=0A=
> convert a regular bio into a bio with zoned append pages.=0A=
> =0A=
> Currently if we go the slow path, by allocating a new bio, then add=0A=
> pages from original bio, and advance the original bio, we're able to do=
=0A=
> the conversion from regular bio to zoned append bio.=0A=
> =0A=
> Any idea on this corner case?=0A=
=0A=
I think we have to differentiate two cases here:=0A=
A "regular" REQ_OP_ZONE_APPEND bio and a RAID stripe REQ_OP_ZONE_APPEND=0A=
bio. The 1st one (i.e. the regular REQ_OP_ZONE_APPEND bio) can't be split=
=0A=
because we cannot guarantee the order the device writes the data to disk. =
=0A=
For the RAID stripe bio we can split it into the two (or more) parts that=
=0A=
will end up on _different_ devices. All we need to do is a) ensure it =0A=
doesn't cross the device's zone append limit and b) clamp all =0A=
bi_iter.bi_sector down to the start of the target zone, a.k.a sticking to=
=0A=
the rules of REQ_OP_ZONE_APPEND.=0A=
