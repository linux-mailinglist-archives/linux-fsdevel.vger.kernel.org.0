Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784714D08A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiCGUn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 15:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiCGUnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:43:24 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B89BCA8
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 12:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646685747; x=1678221747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a9KkmnYg+qtCP9c5Y2vbS7iLEvKGk6xBE2kfTjwUYRM=;
  b=bx1dqAIBZ0rVJVY2QW6AOF69IrgHq57S1bZ0GgzTxZ2ZsNed15ugZ5df
   IYhVbeAebuAS5U0qpg1gyd0F3NRCwxTIJ8wwfRy8Cv06g8/DtBNZR9+Ux
   0PniIweGkz2ZNez+5ZlQWU7dlPY6h0JHRjtIc9JwG/5lXGvV/Uz/aEdiU
   KTvn6sNhi1UBxyMNu7DwNGpFw4WBf2RsMmKPEbGY6WXtDsl2Ce3qIOHgq
   jK+b59eFJLUsUns8DqKCyZNFgTJ8dbijqgLCqWq7Wek6oZ5B95kNJYhx7
   redYjNQ9XqALf2BrxcDqD83K5/IwFBCuQLmjovW9+MTV6Zj0c9o/mrUuj
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643644800"; 
   d="scan'208";a="194697558"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2022 04:42:25 +0800
IronPort-SDR: JBV05U6haUAnlh306w8xgtFK6GqEAfvZgwvmsjFdt5v0iy97INeuJCzkrbK9uUMy7ot7Bm32KT
 F9t46LuVXwsjdv5oFj/j1R9IBIht7fDYX4MH4pMV3RnSGBpv0otcEYoKxBvRqpN2s3gGI5nk4e
 C3PX0SEuac4/Dd3N/mxoRagyW5/oJmh08rJxPV9tSUaS68sLhDbJbt30yl+QinVf3EYn4D4gku
 xIN5mAKTETwKXDHTFDczrDhzxqEZJTkSUeykC7pWPVJ44skNKPKL8eRsIdhLs+3HYgo4M9mcfx
 z/cfmKh6+IjDjD4Wjj/MN1A4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:14:45 -0800
IronPort-SDR: Q9d6LkkgQapqoIARyOU469B1n5b0KzhvGA1AjZQL0Yq3vxtoyM9q2l6Q3T41qdASgfL59Vl9nm
 yEQ8Vnqr8DoDych6TrKPnOH7tzFdAUJw4LidvkGIbx1lm/YlJde/63HkpaWgHJgFh/+T+k2HpR
 7G4k/H6Kp/cIFFgNRhcnDRxhcPT6laYrShKUrp2XHUPEooxntjGdHuuumtyQ2RKwZqKq4YojZn
 jrIjX34q4r53fpxNZqfkH2CfCTi9WO3I7k4Y7Wp+gjXxvLLa10wSEiJWda8GFozP0D4/VBxajF
 FYI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:42:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KC9PZ74SNz1SHwl
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 12:42:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646685746; x=1649277747; bh=a9KkmnYg+qtCP9c5Y2vbS7iLEvKGk6xBE2k
        fTjwUYRM=; b=Mai0Co33QzM/xljOXYV0/746SueNTGZsSb7yDtKzkljbWJBxeVX
        JNB6gaiCxBy/Khjgd2tUn+ngnlNPG8PSudKExf8dGEjvGNTtnmlAdX1ZhRQ7n/iJ
        2hSg57TpuEMb91xZ18ljWQa3oLWVMXQFekpGiSrdU6Y+iLO0YGKFXIdLEBW8s9GW
        5vQVzTd+m+Fh+ig4QyO6HD1IP6P/s+Pl6EGj3i6lw9lGPsd+8WiIn6tVfK+yQLmr
        MiVqUg8LAfRoS6r8t9d5x2del87sVepJcMGthpRUWuKZvxzvibUBU/qPI68shoX4
        xVAac5rR7olM8TIF6Hkh8jaBqH8or0qIxUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YhRkqkqhGtng for <linux-fsdevel@vger.kernel.org>;
        Mon,  7 Mar 2022 12:42:26 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KC9PW0f18z1Rvlx;
        Mon,  7 Mar 2022 12:42:22 -0800 (PST)
Message-ID: <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
Date:   Tue, 8 Mar 2022 05:42:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
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
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/8/22 00:15, Keith Busch wrote:
> On Mon, Mar 07, 2022 at 03:35:12PM +0100, Javier Gonz=C3=A1lez wrote:
>> As I mentioned in the last reply to to Dave, the main concern for me
>> at the moment is supporting arbitrary zone sizes in the kernel. If we
>> can agree on a path towards that, we can definitely commit to focus on
>> ZoneFS and implement support for it on the different places we
>> maintain in user-space.=20
>=20
> FWIW, the block layer doesn't require pow2 chunk_sectors anymore, so it
> looks like that requirement for zone sizes can be relaxed, too.

As long as:
1) Userspace does not break (really not sure about that one...)
2) No performance regression: the overhead of using multiplications &
divisions for sector to zone conversions must be acceptable for ZNS (it
will not matter for SMR HDDs)

All in kernel users of zoned devices will need some patching (zonefs,
btrfs, f2fs). Some will not work anymore (e.g. f2fs) and others will
need different constraints (btrfs needs 64K aligned zones). Not all
zoned devices will be usable anymore, and I am not sure if this
degradation in the support provided is acceptable.

--=20
Damien Le Moal
Western Digital Research
