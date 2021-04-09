Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8C3590DB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 02:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhDIAYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 20:24:53 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39871 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232488AbhDIAYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 20:24:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DE5B35C00B1;
        Thu,  8 Apr 2021 20:24:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Apr 2021 20:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DwizxYbUSZgbLHoS13O2SZRiI4k
        eD3ogjhL/PTu6gv8=; b=TdyxN4BaM0HA0AYjUbIQlsNrj6enXIVLSfZ3e4k05Fy
        8T0pQ7UqL9dpUIUwaf5Dh46cGvfg5tjqtZ8P6wPMeb1bTcvlTO2+X12hX/8E9fWR
        pyI6KBWHr1CSsS9JYGXsjHG35z5KQxXYCekFP8qvi7HeY2BZ1LohR1s0/IFmcZsB
        dovPxMul0lPSEsyR+NVeEwAlh88X9i0JM2LkK+ms6GPXL4xE5czff363tn+JqsCT
        36wowZM6joLA2dkkH2958Q/jNh7YE+givMDMNzWJ8FVbq7ol/lBUsW3f7bpQ7l9t
        CXmczAiry/JXC8exc4RNMdk6SsXTQ7uzKEBZsf0Kk4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DwizxY
        bUSZgbLHoS13O2SZRiI4keD3ogjhL/PTu6gv8=; b=mKLIG4INCz2rV0Ot2SXu02
        OUT7xlwNKfQhzlG0NgGHBmh5n+WBR51fUg9j/Uxp89FBoZ3IEpAOmnuhd4DT/gZz
        6d1TovYyLI/SA2akboyiIPY3qMseU5Vbj/2P09fdHgdLisTYillWKLxhCSFfIg7g
        XYjdmD+qTl5dZRdjTBOEJ/siBWUpl3woUhIzid86oxeyQuQiuhb6cynOqU1ajYyV
        gt3l+/a6z2zOXzdW26VJiiWgKlNtPKQNVd7bIS69XBbpFjytScJUdzFsuuMpcUth
        mdi84YweLOFvrIf6UPz0zK8PDgTIKa/EYVRztaID5pSJpFORkqoItTyWFT4Clupg
        ==
X-ME-Sender: <xms:x55vYBxSdMN6pa45K4SiKmpQxku9iBatgb-yXc9EyQZQM684jhnieg>
    <xme:x55vYBQ6EvzV0Xwcth_IuF9ry1BMgYi3_VdUdhsJwGO0Dx4Vyi6IMAFNNrkYOUuvy
    iD4spKG4tDvQHe1xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudektddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpeeuuddvjeefffelgfeuveehfeegfeetfeetueduudfhudfhheev
    leetveduleehjeenucfkphepudeifedruddugedrudefvddrudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:x55vYLUKwY0k7axzmVJNoqLNsPieXvJFIy2mEIYf2WIdTdI2l6jnMg>
    <xmx:x55vYDiZj-Sl8u8CU0eTx4EwgksMSosX98L1OiN0Ce1ffDLIIvisXg>
    <xmx:x55vYDBRsGDYh9cY_KnaYygi_FZl7mNG1wc6469CFVj2NT1DW4-KwA>
    <xmx:yJ5vYF12SukpWkjBz328iON8Zi19szwH9HX4t9SC-ALe44Uty5WhNw>
Received: from dlxu-fedora-R90QNFJV (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 761B724005E;
        Thu,  8 Apr 2021 20:24:38 -0400 (EDT)
Date:   Thu, 8 Apr 2021 17:24:36 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 0/1] bpf: Add page cache iterator
Message-ID: <20210409002436.d4kpn6djrnecv2et@dlxu-fedora-R90QNFJV>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <20210408231332.GH22094@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408231332.GH22094@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:13:32PM -0700, Darrick J. Wong wrote:
> On Wed, Apr 07, 2021 at 02:46:10PM -0700, Daniel Xu wrote:
> > There currently does not exist a way to answer the question: "What is in
> > the page cache?". There are various heuristics and counters but nothing
> > that can tell you anything like:
> > 
> >   * 3M from /home/dxu/foo.txt
> >   * 5K from ...
> 
> 5K?  That's an extraordinary Weird Machine(tm).

Just typing random numbers :)

> >   * etc.
> > 
> > The answer to the question is particularly useful in the stacked
> > container world. Stacked containers implies multiple containers are run
> > on the same physical host. Memory is precious resource on some (if not
> > most) of these systems. On these systems, it's useful to know how much
> > duplicated data is in the page cache. Once you know the answer, you can
> > do something about it. One possible technique would be bind mount common
> > items from the root host into each container.
> 
> Um, are you describing a system that uses BPF to deduplicating the page
> cache by using bind mounts?  Can the containers scribble on these files
> and thereby mess up the other containers?  What happens if the container
> wants to update itself and clobbers the root host's copy instead?  How
> do you deal with a software update process failing because the root host
> fights back against the container trying to change its files?

No, the BPF progs are not intended to modify the pages. This is just for
read only observability.

> Also, I thought we weren't supposed to share resources across security
> boundaries anymore?

I can't speak to this, but bpf progs can pretty much be attached to
anywhere so this iterator doesn't expose anything new.

<...>

Thanks,
Daniel
