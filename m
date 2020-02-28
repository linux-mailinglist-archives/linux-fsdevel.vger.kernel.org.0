Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD813172FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 05:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbgB1EgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 23:36:21 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52333 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730793AbgB1EgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:36:21 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3E6076573;
        Thu, 27 Feb 2020 23:36:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Feb 2020 23:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        3WY2k+wyv/F2CiLcUJNjhJJ2CbiLhEloXtegwZmGOs4=; b=cbWtCJyFrMFrhKmt
        YcCc/qBGZCPSKx03p6UXr8j5TAWMOyv9+dt5n904GQsWLm94mJzNOtFaZSpDrhhu
        vVnuL4ITDvbK8MBvlRL/Os0h7tTBWjqD0kn5OjhLQncRwZny3kfKcWvU9XPHEH85
        OgLZQKMgr8TYqKl6Gt/vdeIDNWUnB+aou4kYBOfjB0wo+XWqlB4EpoiZRL5EAclq
        USEt8nXuDwvCmdXi9Vt4volM9Sqys+B7ZVruWy7PXMRrxccAq9pXuD/HRzA54NIq
        M/vapExoBAcdKbMBgcroJ2RHuzoSurCVLOomFSFdmbU9EtUDPAQ4Jn4+acV5Ndl+
        VQo14w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=3WY2k+wyv/F2CiLcUJNjhJJ2CbiLhEloXtegwZmGO
        s4=; b=vdfhsT/6T1ESlW0AmTA5425oTjD28dxtD9MNv8TwHS6vuDzux16ikDEBu
        DTUb25AnlXL41rdd6Dzr47DZeO9lB/DK29CVUIqaGaqfepBE1Toexc+zwp0Rrnz+
        s42qSFRDIEHxUNi7SuD6d29OXornMBDBqIVKCteuyLjUl/l6rvs4thcrqD8ssxkt
        VsWBfkL8HsPXIY4Uz+Gsup2Oqw9cVQv7b/VHBrPG7liCqW6JPQI8eRDRTlcJeMGB
        XLXUc1cGXt6ag3V87ldlNNV4XTgFrFizedjniZ/6GMZOM8ioIdEKPeRhozpwvDtn
        AcIk3n/lNQ/tjG812XVv7Evpk9oVA==
X-ME-Sender: <xms:wphYXvdyASBnv7OJuMLVzpKtPSy69sNJUbtn8RDiV27TPO_IN0vJ6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleejgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dukedvrdeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:wphYXniBlbhAlIGV8ijL0T3ZBYWD99eVpeotS2cKjfomUcoFx00vbg>
    <xmx:wphYXnNNbXG4BQZBRgzRO-IzjyQcaIDihWOnX9YfRaji5H2tdRYGKg>
    <xmx:wphYXt5hUBj-JmJZvmhSlwoO75HgW8feYU7GRS2G1hWEg9YYkMWSfA>
    <xmx:xJhYXiX5GoGLTI08CYM_TmmP8z0p5A9Nv3WA8tMSXW55MWV7OFwlfw>
Received: from mickey.themaw.net (unknown [118.209.182.91])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE34A3280067;
        Thu, 27 Feb 2020 23:36:12 -0500 (EST)
Message-ID: <5598cd24defe490016479518c7344201f6dfa0eb.camel@themaw.net>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
From:   Ian Kent <raven@themaw.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Date:   Fri, 28 Feb 2020 12:36:09 +0800
In-Reply-To: <769be2c66746ff199bf6be1db9101c60b372948d.camel@themaw.net>
References: <20200226161404.14136-1-longman@redhat.com>
         <20200226162954.GC24185@bombadil.infradead.org>
         <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
         <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
         <20200228033412.GD29971@bombadil.infradead.org>
         <769be2c66746ff199bf6be1db9101c60b372948d.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-02-28 at 12:16 +0800, Ian Kent wrote:
> On Thu, 2020-02-27 at 19:34 -0800, Matthew Wilcox wrote:
> > On Thu, Feb 27, 2020 at 05:55:43PM +0800, Ian Kent wrote:
> > > Not all file systems even produce negative hashed dentries.
> > > 
> > > The most beneficial use of them is to improve performance of
> > > rapid
> > > fire lookups for non-existent names. Longer lived negative hashed
> > > dentries don't give much benefit at all unless they suddenly have
> > > lots of hits and that would cost a single allocation on the first
> > > lookup if the dentry ttl expired and the dentry discarded.
> > > 
> > > A ttl (say jiffies) set at appropriate times could be a better
> > > choice all round, no sysctl values at all.
> > 
> > The canonical argument in favour of negative dentries is to improve
> > application startup time as every application searches the library
> > path
> > for the same libraries.  Only they don't do that any more:
> > 
> > $ strace -e file cat /dev/null
> > execve("/bin/cat", ["cat", "/dev/null"], 0x7ffd5f7ddda8 /* 44 vars
> > */) = 0
> > access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file
> > or
> > directory)
> > openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> > openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6",
> > O_RDONLY|O_CLOEXEC) = 3
> > openat(AT_FDCWD, "/usr/lib/locale/locale-archive",
> > O_RDONLY|O_CLOEXEC) = 3
> > openat(AT_FDCWD, "/dev/null", O_RDONLY) = 3
> > 
> > So, are they still useful?  Or should we, say, keep at most 100
> > around?
> 
> Who knows how old apps will be on distros., ;)

Or what admins put in the PATH, I've seen oddness in that
a lot.

> 
> But I don't think it matters.

And I don't think I made my answer to the question clear.

I don't think setting a minimum matters but there are other
sources of a possibly significant number of lookups on
paths that don't exist. I've seen evidence recently
(although I suspect unfounded) that systemd can generate
lots of these lookups at times.

And let's not forget that file systems are the primary
source of these and not all create them on lookups.
I may be mistaken, but I think ext4 does not while xfs
definitely does.

The more important metric I think is calculating a sensible
maximum to be pruned to prevent getting bogged down as there
could be times when a lot of these are present. After all this
is meant to be an iterative pruning measure.

Ian

