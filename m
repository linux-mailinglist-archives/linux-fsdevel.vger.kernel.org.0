Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D2172FB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 05:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgB1EQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 23:16:52 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:38229 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730586AbgB1EQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:16:52 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id D9474646B;
        Thu, 27 Feb 2020 23:16:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Feb 2020 23:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        aE2IYxZTehpip3xr3YzMaz8G54Fjh1Vf5hK0hWj6PNc=; b=DbCz0WOac8rw4TA6
        wB+zI5SzfARtJvhWm2f95dLSo0otr/j408lvwc2beEfrvzpE5G5QsD1gJvxUrHqD
        cKcurBRK+1nvjr/ZD6s2B8UrE2Up8QpP4Yt/s/C1k7NYOSRjhJ1aw1ixfboKgGQF
        ALI+5WtU0WL63yKqVq5hTdFsrGMlrRM5f0DksuSYOLKVptrS7icirMovGZijSt7L
        bAVuqMnKmZrPG0zUl9tOwQVd/M9Yn7lS72cVLPvMUyn/djrH1T2W5l3CrjJAB6fv
        PlB1rAb7zLXsQcaBwx+hAsccBk5gZzxXHE49DDxerI3EgEw5pXiAPgu8RUoOj6cV
        5o2B7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=aE2IYxZTehpip3xr3YzMaz8G54Fjh1Vf5hK0hWj6P
        Nc=; b=PSm463IY9wZU6tdLq9t1F4YjsMnJkbXzf7zDZprkGPvJKi/vVj/DcrcbG
        i5tze/VhMOPNKeUAdKCR5SLZqn+q0Fl9YLJpQqdnuT67Y5Zyu3G2R2VbJm/J7Nty
        Zc76K957Oc8mKOnu2sNJ/0oN4D3Vz3VfnirPQGQCnC1ok5ZQDtbdXrE2aaw27O2U
        pZ5oKmygNAGd5GPrxtEEresLPe7SQQcOuzKOJrbRU/JO41bmHfQ2YIQxlteDk6n+
        rG+fyZsKow1/Ubu/I+lG/hhFyYJtWqsb3EPqlxp0ZQMiaZ+tKYa3rC+UY//aIbQ3
        giF05/Qv7uxtnwwuS/7synkvPwpXQ==
X-ME-Sender: <xms:MJRYXtbOs51l8DszbXbPoxmI6GWko9fbQBpjX6Az5y4uyAcmZf5byQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleejgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dukedvrdeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:MJRYXrPHz4a-aKx_MVipDW_F7vj3ZkxFTh-Mbr_fnIX6hoVhfApDBw>
    <xmx:MJRYXhLNAfc9GCtBkkv9n_lytkwuiYZ9szl9DqiNX1G6xMr60YzwIQ>
    <xmx:MJRYXpbXsIbGC_jxTOFzMSrv-FCSluj1lObI3ahd8wutFpluuI2JzA>
    <xmx:MpRYXpgdUO3ZXewy5VW-RRxAklqN6SnOFpUfT-Cbr6AS-R_dL5gbeA>
Received: from mickey.themaw.net (unknown [118.209.182.91])
        by mail.messagingengine.com (Postfix) with ESMTPA id 69A473280059;
        Thu, 27 Feb 2020 23:16:43 -0500 (EST)
Message-ID: <769be2c66746ff199bf6be1db9101c60b372948d.camel@themaw.net>
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
Date:   Fri, 28 Feb 2020 12:16:39 +0800
In-Reply-To: <20200228033412.GD29971@bombadil.infradead.org>
References: <20200226161404.14136-1-longman@redhat.com>
         <20200226162954.GC24185@bombadil.infradead.org>
         <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
         <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
         <20200228033412.GD29971@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-27 at 19:34 -0800, Matthew Wilcox wrote:
> On Thu, Feb 27, 2020 at 05:55:43PM +0800, Ian Kent wrote:
> > Not all file systems even produce negative hashed dentries.
> > 
> > The most beneficial use of them is to improve performance of rapid
> > fire lookups for non-existent names. Longer lived negative hashed
> > dentries don't give much benefit at all unless they suddenly have
> > lots of hits and that would cost a single allocation on the first
> > lookup if the dentry ttl expired and the dentry discarded.
> > 
> > A ttl (say jiffies) set at appropriate times could be a better
> > choice all round, no sysctl values at all.
> 
> The canonical argument in favour of negative dentries is to improve
> application startup time as every application searches the library
> path
> for the same libraries.  Only they don't do that any more:
> 
> $ strace -e file cat /dev/null
> execve("/bin/cat", ["cat", "/dev/null"], 0x7ffd5f7ddda8 /* 44 vars
> */) = 0
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
> directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6",
> O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/usr/lib/locale/locale-archive",
> O_RDONLY|O_CLOEXEC) = 3
> openat(AT_FDCWD, "/dev/null", O_RDONLY) = 3
> 
> So, are they still useful?  Or should we, say, keep at most 100
> around?

Who knows how old apps will be on distros., ;)

But I don't think it matters.

The VFS will (should) work fine without a minimum negative hashed
dentry count (and hashed since unhashed negative dentries are
summarily executed on final dput()) and a ttl should keep frequently
used ones around long enough to satisfy this sort of thing should it
be needed.

Even the ttl value should be resilient to a large range of values,
just not so much very small ones.

Ian

