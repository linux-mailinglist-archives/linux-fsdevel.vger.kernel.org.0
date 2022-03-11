Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147364D5C75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347248AbiCKHkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347242AbiCKHkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:40:22 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C79762133
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 23:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646984357; x=1678520357;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zks+LcQgLgFnsycj932aQmZKs+2Atp/BmYrHQzR+Vug=;
  b=Gi5oDeryRMxdQNgM6WAUAOtT+nhSw5ZEynCLT44ZjQpqREuLPBZGsm22
   sCmN5zs7Gq+6pCgBxjH1iMi0hMBaA7wL6FcbNNn9zBy78p6Ga+4hrhpWf
   B50BDwTIzVKhogIIPbdUArF+mi6s0VnhlJjcQ80ksdspvmuflZBWY8N3O
   UOCMWDs44GEJ/7zIEzsFXMvvg3xhVC58kPhNUWlNKXvCFUxDCy4mDpKxW
   R3cV+HgPTmXbjwrYmo/9fig1qdToeUzDoiWWelVboFTr+B8L3lorMArKH
   xt3c097FC/DsAIWU7H5h9ZPPv3UkY2x1/jEQ8/bSWGmotaKWhf728ZsU0
   A==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643644800"; 
   d="scan'208";a="199899228"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2022 15:39:16 +0800
IronPort-SDR: 6RMenpHH0S/TiFW5K1E+KOnxAOmFOpPkskx/6Ftt585ZZcnlbZl+avUm3IU2edLtf5OUcSr5G0
 2olp36PpM/K67OyypYhLGy7VPiaZ9s4iS8/++9Gg4CfppTj0CL8knZxiblR7KFKEyhi7fGXFNs
 yL3v1MbrV0aiv6rCXuUD90/KYSmngbqcR/SSCAGmp8tuwe7+LkQSEVmZdja1dFj7quz37HAa5y
 uH3UANpJOd7/wbF3K+k0M4Ou0V7NLB0FKmwS3Fpxzk/EgrjbKxppr8GTP1/Cj7YRIxMZCc9yAm
 vT+kpkE+6WYYtmfQjyffVWNw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:10:30 -0800
IronPort-SDR: xUTtIkTnSUvBL3mRwPdMI0Poug4KCfegevuHX43GrZ45EPterVFuUnQr/AATceqB0l5AVz0J46
 hxw3pkJGD1T8VcusGE3U/tmeYO9kKYLrt1Wv6YW60juk1y/mBephhcoi67cQTJ+tiAPnSZgm7H
 ktV4vnxi5LLoYPkq/1VQ7aG83B9iAqYHCwXHuURwTrEWr/lGeBzKagtvBCu55o1Md+LY1CaX/P
 Xooy05YnAZw8fprJBMyBOiDT51qbdxD+BW8nGhm6lrDMr7/KRqDOZfnaRc1NaEi9VmKv2LmDNW
 di0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 23:39:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFHr51kmxz1SVp3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 23:39:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646984356; x=1649576357; bh=Zks+LcQgLgFnsycj932aQmZKs+2Atp/BmYr
        HQzR+Vug=; b=PbLBRBOue05Grp2Rhg2SQiIl2g6/F/BNft6b7yVswR8+3VZoiwc
        qvilCXrFzv3mJIfG6X0gtPE/UINZUFIdepEg9LFFjFkjv2q5T/Wo79yxyTQwPQxH
        YV+D5iZGv5Z2kNEmUjotpnYKHUyOAlIDyXQEJqrxgV5iAea5JGawdsoO3tXrKABJ
        zR+Xrge6aIKf3hIw8SuTVhLWNtaPWvyfso+4vjxhrTh72LYrt+rZo6Clg5a6rrDw
        HN7Mt58nl1rHn8CdrUT7Rp9wgTyyF8T/gkIlcyeicZ4AwTDzRw4xBYickokb10wo
        C9m9rIEbW0amtAyfvWW/6Y8uwfHTqsh0O+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P5oeAUzIN3L5 for <linux-fsdevel@vger.kernel.org>;
        Thu, 10 Mar 2022 23:39:16 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFHr13f4Wz1Rvlx;
        Thu, 10 Mar 2022 23:39:13 -0800 (PST)
Message-ID: <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
Date:   Fri, 11 Mar 2022 16:39:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
 <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/11/22 16:21, Javier Gonz=C3=A1lez wrote:
> On 08.03.2022 05:42, Damien Le Moal wrote:
>> On 3/8/22 00:15, Keith Busch wrote:
>>> On Mon, Mar 07, 2022 at 03:35:12PM +0100, Javier Gonz=C3=A1lez wrote:
>>>> As I mentioned in the last reply to to Dave, the main concern for me
>>>> at the moment is supporting arbitrary zone sizes in the kernel. If w=
e
>>>> can agree on a path towards that, we can definitely commit to focus =
on
>>>> ZoneFS and implement support for it on the different places we
>>>> maintain in user-space.
>>>
>>> FWIW, the block layer doesn't require pow2 chunk_sectors anymore, so =
it
>>> looks like that requirement for zone sizes can be relaxed, too.
>>
>> As long as:
>> 1) Userspace does not break (really not sure about that one...)
>> 2) No performance regression: the overhead of using multiplications &
>> divisions for sector to zone conversions must be acceptable for ZNS (i=
t
>> will not matter for SMR HDDs)
>=20
> Good. The emulation patches we sent should cover this.
>=20
>> All in kernel users of zoned devices will need some patching (zonefs,
>> btrfs, f2fs). Some will not work anymore (e.g. f2fs) and others will
>> need different constraints (btrfs needs 64K aligned zones). Not all
>> zoned devices will be usable anymore, and I am not sure if this
>> degradation in the support provided is acceptable.
>=20
> We will do the work for btrfs (already have a prototype) and for zonefs
> (we need to look into it). F2FS will use the emulation layer for now;
> only !PO2 devices will pay the price. We will add a knob in the block
> layer so that F2FS can force enable the emulation.

No. The FS has no business changing the device.


--=20
Damien Le Moal
Western Digital Research
