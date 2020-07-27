Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA122E43B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 05:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgG0DMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 23:12:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:8641 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgG0DMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 23:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595819579; x=1627355579;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8k1e9XHPJUXXH3NJh9IcTTD9qI64vtVgWBDdhpv4Feg=;
  b=iy/zMfIWAtdH8Nt39ZEsdKfsp0NE5BBlwYQ0OzQSJty+P0e02s8aEm+s
   Saisit+bml6L6NgAkKZ7qRmvZkoy3z693Zbwqq8n5CElTKwm1k8LcDL6F
   CRBeF9NQil6u0MtLmLIz+e2Eok85/uiWScgKOIJqgvlOYMuvhZAo7r45D
   l1NbklqL/BBwX7CRLxSpbhj6UAxY+ahPQBmMNxpstfWe4DA9c2HHyK4d2
   kLBG6SAJTmtfKhqbxm/4G6gMHFpfLSQ1nfN+j8tJFfvKDbkNolR9SPtLZ
   Rq/ihBX1q6Xpi4ZFSLq2XuED4+bB8WpZF3yOxqiCoRXjEkqjXYBkidSRn
   w==;
IronPort-SDR: NX4gks8+dNSE+BGmHMOjrkd9GE9YDOS7anfLxBeQKRSfTk3obfUw49gkMiulCAe5MUNooBNrN2
 2PFwIZ52vtRpKXYqLnzxdbaUUvU/0wHOIWSBKvPjVJfkN+TJ0GhWJ2ZatwtLSZ3K/4Gp5m+YBk
 DLOVO8Xn0N8gvhLqJC85JoW5183CPGLOcd/5CIWEU5tXMaBOAVnfzyn5eP7/off4tlDm6OaWE3
 7eBFP00H69EPSp6BVnSiEE4aunFEqNxJ9eDYMPo4MOQFq2ZlvonDIFzpMceSY8GlYeAATe00VL
 T2U=
X-IronPort-AV: E=Sophos;i="5.75,401,1589212800"; 
   d="scan'208";a="246513032"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2020 11:12:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTyuiNeOH0LwpMzR3k6YUYrQa+aPacw6LhGIu0hvuO5lDfQeV+RiWe+t/E9Xe7tlHXG0L57TqdVJltIJT8NgcanXeOZr0yDSzTN/r312fQzvrgtaklzKHMB3OIhqZqLeAOT2XuCnfieRajcEFEh3Ef42sxUmyt9WQOodM25Ov9kTpfX8HuMV5ujc2+YiOyYMpZV6YuSy6pc0DWf45UShZC+5McdzzP11/hvpwWmsr82yUN/eOzzkeUNFRg/b3uc77DuBkQzLi3Vv/YxCsPVuQPP20vbvh64Y3U/Wquq4PEfIbnho62Qayk289rStMvbFd73v2TzP6k9SeCon1p1Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q97meMl6zRb/eWLh295tvnx1ju/wv6qfOMmJxynzJd4=;
 b=ZO/sSJwqLUonuYNdRJnPDHKDKcSCTHTbCnlwXXl4i/UhqI6U7JK1kQJiFlp2j7N2vPFKKjcori0PdxYlY4xjR2bGd9DCbMhe6wtWZl80UDnKl+saQKELAqU8T49hySrWGtsAXUKW3SIFcqxQuHWXag8dyDC97Nisk+3NGfTrKvg0qZYcu29fDv89kkutFxtRqYMdHvND5dDt55tvvrvDiqX4MSuLm/UiVAT9pcTud4Zhx1vZ06t3Nim40gQhcBNP8dGOlv8ik1doK4IDNkS65NW9pTd7ejTrBM59kXw5VSzJKNCYdEVoX5elFWho6jRWdqS5kdfccJduc8C6Q7PtMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q97meMl6zRb/eWLh295tvnx1ju/wv6qfOMmJxynzJd4=;
 b=QLb8SaB02RpvkQ93t7PsjbJPiwUSSrJupCBUitPUBP9A11QTgvlitS8H2EtWP4xRaZBJREFjp9OsoBnGbkJ5BTr+XeOGpnjeikLt5w06Wu28CFP42H/x+XaxrxAYwcV0bcc2sqlc3Qs5JMW9wZHED3AhNf+QbPJHBW6wAtbPHsI=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3634.namprd04.prod.outlook.com (2603:10b6:910:8f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 03:12:47 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3216.026; Mon, 27 Jul 2020
 03:12:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Topic: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Index: AQHWXpithxnH4YX78EmlwzCUDX/15g==
Date:   Mon, 27 Jul 2020 03:12:47 +0000
Message-ID: <CY4PR04MB3751E2EEC19BD737F310327FE7720@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <20200720132118.10934-3-johannes.thumshirn@wdc.com>
 <20200720134549.GB3342@lst.de>
 <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200721055410.GA18032@infradead.org>
 <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200722145156.GA20266@lst.de>
 <CA+1E3rKBH=Pj+Do3p0zv+WPipgZKDLaHr20fb+WqLh55CQ7J6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1491c617-3573-477c-d1f8-08d831daf033
x-ms-traffictypediagnostic: CY4PR0401MB3634:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB36349765E918B115A0B8CFCEE7720@CY4PR0401MB3634.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VkTuLJ3pbDVuLRHTyJZZZDF9zjq28U8nWoVzygwDL4DE8b39+EFqiA57XuhlfY8F24WxoBzBvxmvjHB5m/TCosv35Egfigb7qKnyFV1Vu7B8EatjiLs0UABO4KZXHq2jRGMz4xig2r53+2AnSbpEHEkWiUOyal8iUL1RE3XjYPDB1KFISisnGuyTcEntSSpCujsb8mulXm6DlYit/GrdqJVSp+xZXCwY1de2CLnrnz0ZoIxqN0hhIMJztmO9XhF8bMhdvL0kppBhRxNM6JiSh4P0kQA1TXicc3W/ZnrEz8n9F055SckHbM1N76qWuidOtBxnACt5tQCfLybL/TSi7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(110136005)(54906003)(64756008)(83380400001)(316002)(8676002)(5660300002)(66446008)(66476007)(66556008)(9686003)(2906002)(7696005)(66946007)(26005)(6506007)(52536014)(478600001)(71200400001)(4326008)(53546011)(76116006)(91956017)(33656002)(186003)(86362001)(8936002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GEl9vbEdRVVB9L1tNy1lp3EbAWlydc9qjMnH+OGTTEloQonSfpmrIQPYVFJ72Xjr3VxcLrQpEnIL1D8mPaNwXPX08wHO+kgs4jwipSJxYKhdWDlhaRxyvhPIeGjECwSAwaKng84MvAU5xmI0RBhVP/6uveW4D//IqxJl9Y+8TXXfX1oGegh198KiqKV/94YTjMONDZcZmO1kRoV4gSdNQ0hCk+oeaMeoRLAt+ktmiTtEtawiOCYNAs40FoEjYqs/zqVbqRpBB+DnoonYLSfkwx9L7u8/k4d7UkPfv9PidWFYdBKsIQmVID6gBtvOwuZM6097Q8Y+OpU4cKkvqyh3e2yRGUK7lSe5iJQGi3LDM7f4mHBhfFV2Jbi9KMRJEBnXeW2dC6ql1nUDvvgsiHbqntTuBI0I3OUq5HNATxkQnRW2fIcyw5Xn4gn5xLIX/Z9pK02b1fFINHObCRFMdxYugkxOx7g33yNU71UWfapRutY2N4X76Of2MiHZShWwF59R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1491c617-3573-477c-d1f8-08d831daf033
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 03:12:47.3535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deybsp/rY0rU78EfrRig58vk9BGRpJgMfVU2YrX5+mEEt3ZX9HBGb+DkJ7Yrc8a+IQ9J/xUzCC2BVZ0/v6VMPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3634
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/24 22:58, Kanchan Joshi wrote:=0A=
> On Wed, Jul 22, 2020 at 8:22 PM Christoph Hellwig <hch@lst.de> wrote:=0A=
>>=0A=
>> On Wed, Jul 22, 2020 at 12:43:21PM +0000, Johannes Thumshirn wrote:=0A=
>>> On 21/07/2020 07:54, Christoph Hellwig wrote:=0A=
>>>> On Mon, Jul 20, 2020 at 04:48:50PM +0000, Johannes Thumshirn wrote:=0A=
>>>>> On 20/07/2020 15:45, Christoph Hellwig wrote:=0A=
>>>>>> On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:=
=0A=
>>>>>>> On a successful completion, the position the data is written to is=
=0A=
>>>>>>> returned via AIO's res2 field to the calling application.=0A=
>>>>>>=0A=
>>>>>> That is a major, and except for this changelog, undocumented ABI=0A=
>>>>>> change.  We had the whole discussion about reporting append results=
=0A=
>>>>>> in a few threads and the issues with that in io_uring.  So let's=0A=
>>>>>> have that discussion there and don't mix it up with how zonefs=0A=
>>>>>> writes data.  Without that a lot of the boilerplate code should=0A=
>>>>>> also go away.=0A=
>>>>>>=0A=
>>>>>=0A=
>>>>> OK maybe I didn't remember correctly, but wasn't this all around=0A=
>>>>> io_uring and how we'd report the location back for raw block device=
=0A=
>>>>> access?=0A=
>>>>=0A=
>>>> Report the write offset.  The author seems to be hell bent on making=
=0A=
>>>> it block device specific, but that is a horrible idea as it is just=0A=
>>>> as useful for normal file systems (or zonefs).=0A=
> =0A=
> Patchset only made the feature opt-in, due to the constraints that we=0A=
> had. ZoneFS was always considered and it fits as fine as block-IO.=0A=
> You already know that  we did not have enough room in io-uring, which=0A=
> did not really allow to think of other FS (any-size cached-writes).=0A=
> After working on multiple schemes in io_uring, now we have 64bits, and=0A=
> we will return absolute offset in bytes now (in V4).=0A=
> =0A=
> But still, it comes at the cost of sacrificing the ability to do=0A=
> short-write, which is fine for zone-append but may trigger=0A=
> behavior-change for regular file-append.=0A=
> Write may become short if=0A=
> - spanning beyond end-of-file=0A=
=0A=
For a O_APPEND/RWF_APPEND write, the file offset written is exactly *at* EO=
F.=0A=
There is no "write spanning EOF", the write is always completely beyond EOF=
.=0A=
This is not a problem, this is the normal behavior of append writes to regu=
lar=0A=
files.=0A=
=0A=
> - going beyond RLIMIT_FSIZE limit=0A=
> - probably for MAX_NON_LFS as well=0A=
=0A=
These limits apply to all write operations, regardless of zone append being=
 used=0A=
or not.=0A=
=0A=
> =0A=
> We need to fail all above cases if we extend the current model for=0A=
> regular FS. And that may break existing file-append users.=0A=
> Class of applications which just append without caring about the exact=0A=
> location - attempt was not to affect these while we try to enable the=0A=
> path for zone-append.=0A=
=0A=
It seems like you are confusing the interface semantic with its=0A=
implementation... For a regular POSIX compliant file system, the implementa=
tion=0A=
of asynchronous append IOs to a file has to comply to the posix defined=0A=
behavior, regardless of the underlying command used for issuing the writes =
to=0A=
the device. We have btrfs running in the lab using zone append for *all* fi=
le=0A=
data writes, and that does not change the behavior of any system call. xfst=
ests=0A=
still pass. (Note: patches coming soon).=0A=
=0A=
Implemented correctly, the written offset reporting change will also be bac=
kward=0A=
compatible for regular file systems: applications using O_APPEND/RWF_APPEND=
 AIOs=0A=
to regular files today will continue working. We should have io_uring inter=
face=0A=
backward compatible too. How to do that must first be flushed out: we need =
to=0A=
clarify the interface and its semantic first. Then the implementation will=
=0A=
naturally follow on solid ground.=0A=
=0A=
For the interface semantic, 3 cases must be considered:=0A=
=0A=
(1) Regular files: the only change is that the written *file offset* is ret=
urned=0A=
to the application in the completion path. No other change is needed. Form =
the=0A=
application perspective, the asynchronous append writes will still result i=
n the=0A=
same *file* data layout as before, that is, data is written sequentially at=
 the=0A=
end of the file, in the same order a AIOs are issued by the application.=0A=
=0A=
(2) zonefs: This is not a POSIX file system, that is, *file* data placement=
 is=0A=
directly dependent on device data placement. This means that for asynchrono=
us=0A=
append writes, we need different behaviors:=0A=
  (a) Writes at the end of the file without O_APPEND/RWF_APPEND: the data m=
ust=0A=
be written exactly at the application specified offset, which excludes the =
use=0A=
of zone append writes.=0A=
  (b) Append writes with O_APPEND/RWF_APPEND: The plan is to use zone appen=
d for=0A=
these, with the result that file data may not end up being written in the s=
ame=0A=
order as AIOs issuing order. The other semantic change is that if one AIO i=
s too=0A=
large, it will be failed. A write spanning the file zone capacity will be s=
hort=0A=
and any append write to a file with a zone already full will be failed (the=
 file=0A=
maximum size is already reached when the zone is full).=0A=
=0A=
(3) block device files: O_APPEND/RWF_APPEND is meaningless for these. So th=
e=0A=
problems start here: this needs to be enabled in a sensible way for zoned b=
lock=0A=
devices to mean "the application wants to do a zone append". There should n=
ot be=0A=
any change for regular block devices. From there, the IO behavior is the sa=
me as=0A=
for zonefs case (2b) above.=0A=
=0A=
Note: I may be forgetting some points in this list above. We need to comple=
te=0A=
this into a coherent specification, including io_uring interface, and get=
=0A=
linux-aio and linux-api ACK to proceed.=0A=
=0A=
> =0A=
> Patches use O/RWF_APPEND, but try to isolate appending-write=0A=
> (IOCB_APPEND) from appending-write-that-returns-location=0A=
> (IOCB_ZONE_APPEND - can be renamed when we actually have all that it=0A=
> takes to apply the feature in regular FS).=0A=
=0A=
And back to Christoph's point: this isolation is not necessary. For an appe=
nd=0A=
asynchronous write, we can return the written *file offset* location for al=
l cases.=0A=
=0A=
> Enabling block-IO and zoneFS now, and keeping regular-FS as future=0A=
> work - hope that does not sound too bad!=0A=
=0A=
Implementing the written offset reporting interface will be done in the gen=
eric=0A=
VFS upper layer, and that will naturally enable regular file systems too. T=
his=0A=
should not be a future work, especially if you consider zonefs, since that =
is a=0A=
file system (not a regular one, but the interface is the same as that of a=
=0A=
regular file system).=0A=
=0A=
>>> After having looked into io_uring I don't this there is anything that=
=0A=
>>> prevents io_uring from picking up the write offset from ki_complete's=
=0A=
>>> res2 argument. As of now io_uring ignores the filed but that can be=0A=
>>> changed.=0A=
> =0A=
> We use ret2 of ki_complete to collect append-offset in io_uring too.=0A=
> It's just that unlike aio it required some work to send it to user-space.=
=0A=
> =0A=
> =0A=
> --=0A=
> Kanchan Joshi=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
