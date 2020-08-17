Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5841247593
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 21:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgHQTZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732025AbgHQTZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:25:12 -0400
X-Greylist: delayed 1039 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Aug 2020 12:25:11 PDT
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD6C061389;
        Mon, 17 Aug 2020 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=CIJRHx355gNSCr+djNZUa3YwUOfj5baupHLNqczQwkI=; b=SYqByI9pwq1dlpVLlp3gloDq+b
        nCykLXBu97LNWMWl+wfkSgqjOBYcveKWR4QhzUPWTrfSf79t30xNBkfyILCdm6f/EBO3rDLFzoGmK
        aJ3JTx9mrmP1tBjlJFzphvk2OS8SSRWnkxuRcg4Wu5HELLq6KJYdQI22nF6MpAAlyAlZu2czMWjKE
        cvh/rmtRllfdBscpciPs2gIsp/7lX+nhnUFAyZlmZrsfP7PV9gl3bv1H9KQnBmD3zIEB2egK92m9S
        AZ8AnroaxXhfmFGvZhIkVqVl3xxSHWxROBdozzjgYL+KgniiKF0cTV8zsqAe68npX++StWb4n98II
        LcjxaAHuLIPRtlmrWhfNo0d84y3JyTcPHqz3IaRhDeHqSqV7T39ctR0bSyvyUqjUpkV3FNjQyeAyx
        sG59QyhuRi/A+tV9Tx+ZR6BZZYxZLIERCxB7WTFBsKvp3iPwoUxa0xBWYtyhhT5OSTZhCz2lw/Bfx
        soqBKVojTBrXhsXpzdrTzMFu;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1k7kU0-0005ga-CN; Mon, 17 Aug 2020 19:07:48 +0000
Subject: Re: [GIT PULL] fscache rewrite -- please drop for now
To:     Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <447452.1596109876@warthog.procyon.org.uk>
 <1851200.1596472222@warthog.procyon.org.uk>
 <667820.1597072619@warthog.procyon.org.uk>
 <CAH2r5msKipj1exNUDaSUN7h0pjanOenhSg2=EWYMv_h15yKtxg@mail.gmail.com>
 <672169.1597074488@warthog.procyon.org.uk>
 <CALF+zO=DkGmNDrrr-WxU6L1Xw8MA4+NrqVbvNMctwSKjy0Yh_w@mail.gmail.com>
 <fecc577d696f9cd58bbb2fae437c8acea170f7bf.camel@redhat.com>
From:   Steven French <sfrench@samba.org>
Message-ID: <dfa2aede-3a42-2b04-1d31-93a670a785cc@samba.org>
Date:   Mon, 17 Aug 2020 14:07:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fecc577d696f9cd58bbb2fae437c8acea170f7bf.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/10/20 12:06 PM, Jeff Layton wrote:
> On Mon, 2020-08-10 at 12:35 -0400, David Wysochanski wrote:
>> On Mon, Aug 10, 2020 at 11:48 AM David Howells <dhowells@redhat.com> wrote:
>>> Steve French <smfrench@gmail.com> wrote:
>>>
>>>> cifs.ko also can set rsize quite small (even 1K for example, although
>>>> that will be more than 10x slower than the default 4MB so hopefully no
>>>> one is crazy enough to do that).
>>> You can set rsize < PAGE_SIZE?
>>>
>>>> I can't imagine an SMB3 server negotiating an rsize or wsize smaller than
>>>> 64K in today's world (and typical is 1MB to 8MB) but the user can specify a
>>>> much smaller rsize on mount.  If 64K is an adequate minimum, we could change
>>>> the cifs mount option parsing to require a certain minimum rsize if fscache
>>>> is selected.
>>> I've borrowed the 256K granule size used by various AFS implementations for
>>> the moment.  A 512-byte xattr can thus hold a bitmap covering 1G of file
>>> space.
>>>
>>>
>> Is it possible to make the granule size configurable, then reject a
>> registration if the size is too small or not a power of 2?  Then a
>> netfs using the API could try to set equal to rsize, and then error
>> out with a message if the registration was rejected.
>>
> ...or maybe we should just make fscache incompatible with an
> rsize that isn't an even multiple of 256k? You need to set mount options
> for both, typically, so it would be fairly trivial to check this at
> mount time, I'd think.


Yes - if fscache is specified on mount it would be easy to round rsize 
up (or down), at least for cifs.ko (perhaps simply in the mount.cifs 
helper so a warning could be returned to the user) to whatever boundary 
you prefer in fscache.   The default of 4MB (or 1MB for mounts to some 
older servers) should be fine.  Similarly if the user requested the 
default but the server negotiated an unusual size, not a multiple of 
256K, we could round try to round it down if possible (or fail the mount 
if not possible to round it down to 256K).

