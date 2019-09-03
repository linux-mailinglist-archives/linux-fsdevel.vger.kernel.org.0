Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B7A76C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 00:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfICWQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 18:16:15 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:37704
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfICWQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567548973; bh=fha3TjWoq7T+FaehvmjeV2B4PeIjuHcxcWYFtyVJWFE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Lx0my6aIH/Cg1sxMHPeI3XP/XUQJzSTqU0nXgkGK/gOh/yi/qmrs5AeEhcLlu3H8AxRNIM6Vk/F8QFy5oPWr0kOqE03bFr3QL9VMqGqX0boDFD8CliuOPA+HtuLL1FAQPUitGF0O1fbGQhaSZ/6ltXux9o8h/7Qri+k3Nu8DivxalB4zawKW/poiuCTshe7qn+7dEwcMZIZjq3oSiVMq/vz2CxLgtutuzaoEmVx9Vl+epO23HVOc7KRotP4Y2SxXBOcFPC4r4Vu7L2+C7ShoNM2kyLHjqGR7RQ9gLZIjWfx7X97p+vnqhbMG41v+Pj9DHR+ugmLzy94XeQoPXglLyQ==
X-YMail-OSG: TdI9FxgVM1nYGzUJuT5BfwvBPLfFq_R1rUEfbVcG3oHD6iiI.B99ULNdd_Lx5fK
 80mFchTSt6.8HD1fr2iMnmOXCVBsKlYqy8laJz0i2lh3sGIATZYlYLKH1cdwittUZgSE7UMhvC74
 ronJiEqp62ZRrkZ59n5S7_kCQ9DRkH.MsC3uM_iA55t_g3ioCOBItuuBhoZ0.kIQnn9oRW9YgyfM
 hY_y3g7jjz6aMzernUXCzxWTrqNj6D1b3QUe5ZrGvS3mbNxiavXjXQ.0rM7Rh410t7GnXTm3ZOrT
 EP_sOwe0hthexUVRBIHnRRj5GA5vnRIeUa_sFyLTmA0A77zzyS5KR04IE4k3368v1KqHSHFz0_6E
 7SfLuqWQntKKz6GoV_AyLp5osYnYr0zhdS1qXCM6BxJhXSCr_EPYVqYyUAxplSJBih5xmOkZU5Mn
 hOlXNI9vFhPN7zx7LAceTeVarI31vBviSsq2_Q3uF9XljGvLV1.Khunm5HMpMDxDZ8dpkVCvU0Bv
 2S1NKamu4jIQoZUkXrZjam6Ynl0.Iqk9jHFGFY8EXR3a1HU5juqjJXa6mNJNebfjhlX5r4Ky.K_W
 RNpIqYRO1q6uaejpt_edYfBz0aLW.DM1ONFB4FJGsnHWUqW.EMwCPLBbjvyukmK8_GJyKlwXYym4
 hR6zCm2D9ZGafE4aZgg05xpSUg5vzDz.EK0Ypve5r89ebOwUx4lZ6snJrGChU4DoT2JD3fDHCCn2
 BJPRO7hsNiIZqpv1cbCNoxSZG8gbw9YSG6qBpVAaYVF_ilKbY1Xp8FlRkKKfFmIVwP6e9n_FSWw1
 3l_xZXY15auhhzGcJ7vVYcPF0HzHrax7EHQuKmQ_6AP_pHfEMClbCxSwvgAOhXSQ93M3GG58O_WJ
 _LgVZ44oms9gNcpqdbOa.Ujg5m4BLbQ3YZYBecYQe_2SK_ygeKjqIo1fVnJwwRU8ftoF4CMIakXW
 wvsJYLi36mlpx7i5RqfF.DybSiLkMYpQLp0viEXvYNW8nS7.1sIt4gDk.pHSUkkIGcnqka1uP958
 ui3c7G3CXILYUoC5kaqot9zIcZdjEbG6lQ83Jq8dbtqZkaafimWjw7A9jXgNAXrqaF4hqgpSm9EL
 T2ctQko37V0lKVUb8yEzjdtHN.2ya9KoBIbI1XBzoFavR3OnaiXCrhghkoXXfCaQuAS8XA67jhpD
 VUZLmtV3TqeYSHJB5uQhMRTQv7PmjLb5TVKuu7lSz5EzMuSFRbCV58EDBNTWNCRLlTeSb4WJA7iK
 NNNB9lSOC.YRF7Lx3ryTqGM1dXJsC3i6e.64_mgIrM1iSirvmKd8qqbrBps2hjLyRwgZ9.LAWOW1
 AODHGOWewFj4ADTWnfHg2_cxAHjwR_gCrtP17YQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 3 Sep 2019 22:16:13 +0000
Received: by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 31589db2a53534d815576f1e840a33f6;
          Tue, 03 Sep 2019 22:16:09 +0000 (UTC)
Subject: Re: [PATCH 11/11] smack: Implement the watch_key and
 post_notification hooks [untested] [ver #7]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <87bf0363-af77-1e5a-961f-72730e39e3a6@schaufler-ca.com>
 <e36fa722-a300-2abf-ae9c-a0246fc66d0e@schaufler-ca.com>
 <156717343223.2204.15875738850129174524.stgit@warthog.procyon.org.uk>
 <156717352917.2204.17206219813087348132.stgit@warthog.procyon.org.uk>
 <4910.1567525310@warthog.procyon.org.uk>
 <11467.1567534014@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <23d61564-026e-b37a-8b16-ce68d5949f6c@schaufler-ca.com>
Date:   Tue, 3 Sep 2019 15:16:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <11467.1567534014@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/3/2019 11:06 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> Built from your tree.
> What branch?  keys-next?

I rebuilt with keys-next, updated the tests again, and now
the suite looks to be running trouble free. I do see a message
SKIP DUE TO DISABLED SELINUX which I take to mean that there
is an SELinux specific test.

>
>> keyctl move 483362336 1065401533 @s
>> keyctl_move: Operation not supported
> Odd.  That should be unconditional if you have CONFIG_KEYS and v5.3-rc1.  Can
> you try:
>
> 	keyctl supports
>
> or just:
>
> 	keyctl add user a a @s
>
> which will give you an id, say 1234, then:
>
> 	keyctl move 1234 @s @u
>
> see if that works.
>
> David
