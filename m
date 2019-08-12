Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB29E89FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfHLNoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 09:44:25 -0400
Received: from sonic302-20.consmr.mail.ir2.yahoo.com ([87.248.110.83]:34480
        "EHLO sonic302-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbfHLNoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1565617462; bh=IKD8fqee9Pkwsyly3oXyun7y3x91jx5H7c7WHcfuCuE=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=bENXl1Fp38lsKpOGZRpgVzkTInMCXZMxyWikw+pnir0KPzbJ8p8IizBEG752z61dKUeFC08tx/PwNWYwdHrcl7NqAP7hQfmm3EOumVndvabMgmxQTNw4+NQChqjx1wGXIkxAwmpVdiIFhEGUPGxvJv/3GSMlu/62Q5Yk8+Dy4yPIhEXxaFqCY9x+u8UYQBbuwYAb3fFIJG2hEomtDRS58vQ/5fnj27ZGM5HDlL7kTcKu+c+mo7LCZAgP231IlndI+OHb57tBONv3JQS/uQ23sqT5yeVCc56zZeg5lNbv3weHrRR9IdV1XTvlsgYWrdE53vdGguKNeLZiHIDq7fMUcw==
X-YMail-OSG: mc_hmYwVM1laWbWsweExAexslMxMIqWYBT8M4i70mTAq0IsTbGgC9hMIdl0DZrS
 l7LAFIVWGXyEE20UIHSMUKKvqbJcE_XZsxDwbnDi_sEScZnyFUAJdND8o1zL1BrRfHmtVmvUw3lE
 m4klpGQyRG3W6Uz6OBr40XZbqQe2Vd.QFv5gSiHIzGqLkIPeq7Fw8QlJVn3396VyXHziCSsX_B0f
 cTjYzr7fbeFPlI1wZ6V3sdLkIqHTlFWjHKDB.RqpIm_G52.slXadOf_pfXRZOiJjWY2d49SJQ40Y
 GBQ2Z6wjs_XLBGDLmF3EYGazyHKXPz5vKbKgOMfoGUrowtWHbsTf_R4xHIJL9Sb.0o6SMhiQMigQ
 ZKj.18WCguSI_wjxmOSFQ5.5_8hisAwIvjRI43bl04mjWBiU1yEK8xxzSwa3Ejxd.TtcLHSfrU5R
 1DHDK4mRjgKnJGnQldd876AJ1EudUMlleVwu_lIrb.DvuYCzwldiwXE0Aaa.zyTif7dDTv2VLpFi
 .PmIxXTEup3O_kdySj7RzMGWpxi92PKRR7EiSeVgww5TDYKQiQxwu7aE5I64KQHiZ4BhrGOP1O.h
 7ZZDo4kiTBFqa18vCziZUGQxvel0YjqfaTLqqx4a0BMEaRVCP3oTtrLOWbu9ldNXrdIbck3Vt3GO
 Zwadu.k6lRDW5UIFVR4453wB8gN35oZHVAk_rsLNk7HibqJAV_pz5AfXpqfNuYUiYDnM5qTADQ3y
 0ChRZQ_FJOasNSVzgXZwRH0wn9nOSvX3fqmMsYHqhQ4K1nfWszD0W0vZCm9v5L6zo7QjmHmIDY5D
 bJGXrnoB8SZ6c.0vQdV4rlfYJ14f8GuR09Yd8Lg0UnMCzEyeq2NCaD_kpGvNWo4OZV45hr2cg_Bs
 nVngZyNvTTB5I6P_NIUJNONxu3oLIowQ.CM5MCygG_uYiejVnefYiBGnWw_zebJAamlKCAOIUadG
 AHfoQiFXJGPiasuiorEXM3QQ5q50KgD9lMzux_x8R.C0AVq6AQbqgqUi96ma2twsjSLaJozRx.T4
 GdqFawisp61xd8K8KeU8gTSXAZ6LLZwSRJRe9uVmqQhox1KOmHIx_l3rYcFAzbJf3BVoiihmoUZT
 Aloz6gp9xJKP9wSFN_IBXy1HT32encKGWSBYZfBBabCo58paPscIeYOcAzAgvQnmeaTlKO6E4f_Z
 QOvhqdlOZV6B9Uo_RLnpT66bvtYPoBJiC7EHMf0t1BBE6rHeNQtBNxsaMC8XSjsFkL2BOxUYCH0H
 g4y_QjTESJMvIUpU3cWwtPjoCpQ2N
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Mon, 12 Aug 2019 13:44:22 +0000
Received: by smtp417.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 175b84ba26d2a92c65d82a13951bcb3e;
          Mon, 12 Aug 2019 13:44:19 +0000 (UTC)
Date:   Mon, 12 Aug 2019 21:44:05 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190812134358.GA357@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com>
 <20190811074348.GA13485@infradead.org>
 <20190811075042.GA6308@kroah.com>
 <20190812112247.GA21901@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812112247.GA21901@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 04:22:47AM -0700, Christoph Hellwig wrote:
> On Sun, Aug 11, 2019 at 09:50:42AM +0200, Greg Kroah-Hartman wrote:
> > Lustre was a mistake.  erofs is better in that there are active
> > developers working to get it out of staging.  We would also need that
> > here for this to be successful.
> 
> I think erofs could have been handled much easier with a bunch of
> iterations of normal submissions.  Bet yes, the biggest problem was
> lustre.

(I am trying...to add some word on this...)

As a new opensource file system, an unavoidable thing is trying to get
people opinions on this... It could be better to prove that's an interesting /
useful stuff for community so that we can do more actively with fun...
(Hopefully we got some attentions and no silence at first... thanks to
 Richard Weinberger, Pavel Machek, Joey Pabalinas... [1] p.s. I have no
 idea whether Richard still has some interest in it... but EROFS is
 ready now...)

At first, I submitted EROFS to linuxfs mailing list at the very early
stage, although the on-disk format is almost fixed, but I have to admit
that there were still stuffes needing to be done (Note that I updated
LZ4 (lib/lz4) later as well [2].)

we weren't quite sure that such an unclean/incomplete stuff was quite
good for better review at that time, and it was also lack of implementation
of some core runtime concepts such as decompression inplace (which was
only in my mind without real code) But we think this direction is
practical and we want to do iterations by time.

Also, we noticed there are many new stuffs such as fscontext, XArray,
multi-page bvec, which were introduced by time, we hope to keep up
with the mainline kernel...

Staging seems to be such a place for an incomplete but workable stuff
after I noticed what zram did before, therefore I took a try and
thanks Greg as well...

Thanks to merging into staging, many checkpatch/styling/functional
issues have been fixed by contributers... we can also have chance
to test in linux-next for many linux versions... and it's much
easier for us to do latest EROFS backport to 4.19LTS for our products...

On the other hand, since I have a paid job for a commerical company,
I need to apply EROFS unpainfully to our products. And I got many
useful running logs from our internal beta users, which helps us
make EROFS stable... Nowadays, almost all on-service HUAWEI mobile
phones on the market have been integrated with EROFS...

Now EROFS is ready for review, and the main code of EROFS is about
7KLOC... Sadly, it still haven't gotten some explicit external
ACKs till now... we don't know how we should do next to make a
difference... perhaps I thought it is relatively long thus I spilted
into 24 individual patches...

We really hope that it can be merged into fs/ in 5.4 so that we
can improve it even further and gain more users...

Thanks,
Gao Xiang

[1] https://lore.kernel.org/lkml/1670077.cnVahIradn@blindfold/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/lib/lz4

