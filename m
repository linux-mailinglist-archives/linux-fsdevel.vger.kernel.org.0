Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958BF19EE73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgDEWwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 18:52:43 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:51617 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727254AbgDEWwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 18:52:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 66A9858013A;
        Sun,  5 Apr 2020 18:52:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 05 Apr 2020 18:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=euu86y6yACvCvstNFbv3DwBO9Kn
        QxP4jRh+eEX/Uz4E=; b=aWfcGa/g12RY6GgtiE4vbPeqndfFU5TauoaxI2sn/mk
        nSPdTiGGwqKZY5eH6mP0/5QnVVwdwJT91KjE8Yo0IiXVZKPvzwSvvxuRSLq8YaZs
        XcE9L7BSvZor3cZY1JEYNmy1I71P4ghowrUcuvJxMq4Dckhj6uHkRdSg0ZzkOJaf
        uM3YLFa4ZTDNyulM+BbWAOfTTUdN1oEbMeIwNHWmh0/7y4NPGesKQ7jutWt6POiX
        KU2Vwd6J6CVwXy1/IfGGRE6GcyWCGat9lp3810xCGBpRsj/I+DZjq3LBUR/P9gEl
        ufil6hnKfzU7gGfgjAHSzVqpFF6ylNsQusqXGRYBZFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=euu86y
        6yACvCvstNFbv3DwBO9KnQxP4jRh+eEX/Uz4E=; b=DLHnqaRdNucpqbnHm1V02h
        VvZajeUd3i21cHyA+Db+q5To2ahUXvySaDB14pwmjC6n6SN4J/h7uM4qhTVWnnt+
        TtkUaFOVP+/9qPPXFNMdcqZPuFodmM5mcyR0VB+e8kDVPUndmWBDUMzF5b19gMCF
        YH4g3VBkFQphkpZvAKDDU650xCEbTJvpfEo7bDmmWAlMrGmy0BWY7YIbwXkZEZQ7
        4y6kOk5oOpIs0LIEl2fX5apAjMQ2zEyykKmzB6D1nzTlE8kcrOQP2t5TvITsITW5
        pGypOMF+cd9fetOY1v1UJmVJsvIBraTSlnh+QkJOjeWOrp7y1AhV6AaSaHSpQMNg
        ==
X-ME-Sender: <xms:OWGKXscNy94fqLNfWljzjQBDrzE3de91hpXWMBfKHE9IKLKgSmTjMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghsse
    grnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:OWGKXl0DJATAJ95cUjLQbU_AVVMoaVKmZiXQ3lU2eZO6CQ95Bbkf0A>
    <xmx:OWGKXrL3f2zc6VTEg0VEj-eDytojIlGjhEE7Ed4R3PEewixZbD-gcQ>
    <xmx:OWGKXsEgq3L8WFv-h4XFjLOIspUCCLrYabvQios6LeAO3G9JuyS6MQ>
    <xmx:OmGKXtXN5JMmzMArvzsaUG8YESD0g0rqcAiIMBw1bNixBFfbhSSLXg>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A2FC328005A;
        Sun,  5 Apr 2020 18:52:41 -0400 (EDT)
Date:   Sun, 5 Apr 2020 15:52:40 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>, jlayton@redhat.com,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Mount and superblock notifications
Message-ID: <20200405225240.kofadjkmpigfzcfy@alap3.anarazel.de>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <1449543.1585579014@warthog.procyon.org.uk>
 <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2020-04-04 14:13:03 -0700, Linus Torvalds wrote:
> And it needs to be interesting and pressing enough that those people
> actually at least do a working prototype on top of a patch-set that
> hasn't made it into the kernel yet.
> 
> Now, I realize that other projects won't _upstream_ their support
> before the kernel has the infrastructure, so I'm not looking for
> _that_ kind of "yeah, look, project XYZ already does this and Red Hat
> ships it". No, I'm looking for those outside developers who say more
> than "this is a pet peeve of mine with the existing interface". I want
> to see some actual use - even if it's just in a development
> environment - that shows that it's (a) sufficient and (b) actually
> fixes problems.

FWIW, postgres remains interested in using the per-superblock events.

On 2020-03-30 15:36:54 +0100, David Howells wrote:
>  (2) Superblock notifications.
> 
>      This one is provided to allow systemd or the desktop to more easily
>      detect events such as I/O errors and EDQUOT/ENOSPC.  This would be of
>      interest to Postgres:
> 
> 	https://lore.kernel.org/linux-fsdevel/20200211005626.7yqjf5rbs3vbwagd@alap3.anarazel.de/
> 
>      But could also be used to indicate to systemd when a superblock has
>      had its configuration changed.

What prevents me from coming up with a prototype is that the error
handling pieces aren't complete, as far as I can tell:

On 2020-03-30 15:36:54 +0100, David Howells wrote:
>  (2) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
>      errors (not complete yet).

There's afaict no notify_sb_error() callers, making it hard for me to
actually test anything.

The important issue for us is I/O errors, but EDQUOT/ENOSPC could also
be useful (but is not urgent).

Greetings,

Andres Freund
