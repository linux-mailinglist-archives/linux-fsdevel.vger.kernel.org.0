Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779EF64E5BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLPBoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 20:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLPBoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:44:12 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B991BE94
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 17:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671155051; x=1702691051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XXXd/KGEnlY9M5D8rYxoFlOUBugtdt/fm6g3o8GolGQ=;
  b=iwrGADQFvFCCvctfkZmnMx5LhgfMvJBRJHaro1kW6N+F+z85DyN0case
   B6jfcek+3v031dMr+Ve1i/aWCwQ3Qsy4ua+pcDc8bfgLWLOE0L4klE/RQ
   /DHBp2pH568Kc2GK5AucscyZiLk0s6zjh2VHPbaPOyikbe7wDe9+uyV1B
   EfDRqmoYZR2qY+e/YHlHAjxFgLYtwASudCYfpzdkfRVT6dNRUBn3Nc2ZM
   IFFJmxejrFkqM69y1vRr7hmHLXv3FchNVv7ZmwvVI3i2RbhOownklu3Dr
   xtkTps4ws9fWI8CElersdUqyw767diK/Aqf1qkzwCq2shL5FTql+Wn4VY
   A==;
X-IronPort-AV: E=Sophos;i="5.96,248,1665417600"; 
   d="scan'208";a="330883179"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Dec 2022 09:44:10 +0800
IronPort-SDR: LhiFEo3dAK2RBSvtgozzG5RSEsDx7ZhpV60mgIXwnE8cS3Hh/TlTYlGjnxHHtkCAnggZKZkt/M
 WzDWAu0diO81q3U6vRbsEUGa1G8PP9lOZIunMjn7hITCFIN4zHJ+k/QkyM7ewnhrsNI36LQDOu
 Mi8C8VDbjU4GXZs07sqtuaFRwmsOwnNunFsTW5mKR3BQMxd1MNyJd87Ph+3c77gxU4L+Jk3nuS
 zpm5uwNhgD6sDLJ4fog3bkdhmvUi+XLmv1Nb8e3zXPariUa4DoysKoQikehqz1EG5e9nL0aVRQ
 USI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 17:02:30 -0800
IronPort-SDR: g9bdTVsJ/VD+3mJ1n3pS53RlNHDjhSvRC27sHgZQTHlvj0hUsQv+uSiPQkW8ICagYzuhx/elon
 mJCpGk7sDpNVTpP94vLBVFvdFkIRtIgnb3UfeJW4spIgYTIfIvLyuCRdnAHNaujcalHSptWV0Q
 +VAPdvBYy4L5PkmUX1+G7SYBK0g1oz4Behq2rR1SmY6yldQCET87N/naK4agmJ4A7R5yJSS1/G
 ctym7+va+RaG6Wa0zYJfAPJDuYKBix3I8iH38g3KvpG8iyJRWdXTBqY/16yOO/G7pvS3lprjXS
 1q8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2022 17:44:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NYBj52TKtz1RwtC
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 17:44:09 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671155048; x=1673747049; bh=XXXd/KGEnlY9M5D8rYxoFlOUBugtdt/fm6g
        3o8GolGQ=; b=KVR4Bx7YrZm6o+smURIYHhA6xc07ZJaWCKPlYfODRnGv1N7bRqw
        XgkR+fB+gkAXZubmyqTplGEjiP85DPUbw18TjMvdKulq9TaMk2rBQSBEqAsHucA2
        QNdnojjan9ZI3smk9ExywRUz5qLu8d0bHAaaSp4WtQsGmUaHoTNccXbFDbSR94V9
        y9o/qnmle7HLKmwAzMozSFvpEU9BvdxFemXD3XXFkc/cviM/3YaLBfNz/dwnJaSF
        B+0j7bWRuuHIv0mqGJQlwauXJlnfThvcwAQQLy2wQ5ypYa9h7/jzIlPp3NUkMvYS
        Faaz4DuTsgHNFGDAdE6046TyyPIgr9VoFBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uc8t0o_1db2K for <linux-fsdevel@vger.kernel.org>;
        Thu, 15 Dec 2022 17:44:08 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NYBj31vP0z1RvLy;
        Thu, 15 Dec 2022 17:44:07 -0800 (PST)
Message-ID: <80dc24c5-2c4c-b8da-5017-31aae65a4dfa@opensource.wdc.com>
Date:   Fri, 16 Dec 2022 10:44:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: possible deadlock in __ata_sff_interrupt
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Wei Chen <harperchen1110@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
References: <CAO4mrfcX8J73DWunmdYjf_SK5TyLfp9W9rmESTj57PCkG2qkBw@mail.gmail.com>
 <5eff70b8-04fc-ee87-973a-2099a65f6e29@opensource.wdc.com>
 <Y5s7F/4WKe8BtftB@ZenIV>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y5s7F/4WKe8BtftB@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/16/22 00:19, Al Viro wrote:
> On Thu, Dec 15, 2022 at 06:48:20PM +0900, Damien Le Moal wrote:
> 
>> The problem is here: sg_rq_end_io() calling kill_fasync(). But at a quick
>> glance, this is not the only driver calling kill_fasync() with a spinlock
>> held with irq disabled... So there may be a fundamental problem with
>> kill_fasync() function if drivers are allowed to do that, or the reverse,
>> all drivers calling that function with a lock held with irq disabled need
>> to be fixed.
>>
>> Al, Chuck, Jeff,
>>
>> Any thought ?
> 
> What is the problem with read_lock_irqsave() called with irqs disabled?
> read_lock_irq() would have been a bug in such conditions, of course, but
> that's not what we use...

The original & complete lockdep splat is in the report email here:

https://marc.info/?l=linux-ide&m=167094379710177&w=2

It looks like a spinlock is taken for the fasync stuff without irq
disabled and that same spinlock is needed in kill_fasync() which is
itself called (potentially) with IRQ disabled. Hence the splat. In any
case, that is how I understand the issue. But as mentioned above, given
that I can see many drivers calling kill_fasync() with irq disabled, I
wonder if this is a genuine potential problem or a false negative.

-- 
Damien Le Moal
Western Digital Research

