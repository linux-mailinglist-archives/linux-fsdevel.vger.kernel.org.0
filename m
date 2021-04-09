Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB8359947
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 11:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhDIJe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 05:34:27 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60049 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230181AbhDIJeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:34:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 87BCB5807FD;
        Fri,  9 Apr 2021 05:34:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Apr 2021 05:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        hBtRaiQhB1QP+JUImkrh6a9M4plqAYohWxovEdNy08w=; b=t1T99AMXBJ/GI+eC
        OaLpJKrc0OiDK5hruidkkwi6CsRhb5i1xEiO60fJpEfBlftTioe/QqbKWdmPAdZQ
        PjXsHF8/z3v+SpWQZ6ifd9tB8C5v+xTVNv4YBdd9z2zT36f8x2TJ80o1inVY8op6
        U57OXTKFK/P38cnB+sRWo5Fn0yqEQheaXkeKeCMbOZEpbbZk2PhxcG2g+FGjmYQh
        +7T2uJmZ/6IjmV7L8seLUgdf7FZD7PZ+ZUzTZKrmWQcMmztAGtxN2nSoIVYxO2F9
        F3CnE5cSP3gw8pcauNbAmYV0iR/k/9b3sB+upJIwY3CrdykWXuO2GzkcbULfKJkJ
        TR6J3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=hBtRaiQhB1QP+JUImkrh6a9M4plqAYohWxovEdNy0
        8w=; b=R8XECi7gJkbakTdVrlEPi/706WQOZEcto3kgGSSGMCMojWYzcnN6KzQmW
        f3zNqVkpwx7r0z/nzajNmuzgMIvH3Wv88wm7bPxwvnXmjRFpgH35oIeDtC8dw/hl
        U7uWky/d+VkLQao9K2kXEojmQLZ0TZsaGJY5IV4BjL6LcPDSZLvKe1BFythBR2op
        Z7IY/9L/XPtdkGV/4A59eQuAItbwAKDThuq2b+mZPO1FZ3Bj44ikWvRbzHB5ERHO
        rfqg2hl/Ca+T4oOjAX/C6oHJtBfgxh93WK2UQ3cwgODd8okkv/6Lj5y+wWov2pYy
        bRv+h2+iiE39dWSUbVRG/XOTo7OPA==
X-ME-Sender: <xms:kB9wYKIHaTz23wA1S8gi4t3tmaHRgRKi2hHx8gv0jmwEaf1cSaiYrg>
    <xme:kB9wYCLo4eIBfX7Ufbka2lRDn8MefboQxMSsmcfnVY-ZjrbhM9kTs3yDoIX41BfUK
    Os_yn_g589s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddvuddrgeegrddugeegrdduiedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:kB9wYKu6dgPKJKvlbjqgvzlf-QIoLnM2qOfIliSkvoIt39wsB2iokg>
    <xmx:kB9wYPaIysm4xzqDZbbmh1NSL_EfYVggVGSK4Go6PSONaYtCLTAqvA>
    <xmx:kB9wYBYZVbVmRrlx6maAqT6iSSD8CefNohTPqlTMis6qB75cPK6AmQ>
    <xmx:kx9wYN6-_UDQ29juUUvSMcQR7ICU1GGyMdfxaLeKbm1w4QMbqK0aMw>
Received: from mickey.themaw.net (unknown [121.44.144.161])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2FFCB1080054;
        Fri,  9 Apr 2021 05:34:04 -0400 (EDT)
Message-ID: <1a40a43a49c7966360465689a40d381bf8937c17.camel@themaw.net>
Subject: Re: [PATCH v3 2/4] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 09 Apr 2021 17:34:01 +0800
In-Reply-To: <e0331787cd2ab96deed8be162223585416ed4a97.camel@themaw.net>
References: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
         <161793090597.10062.4954029445418116308.stgit@mickey.themaw.net>
         <YG+vSdNLmgwXrwgJ@zeniv-ca.linux.org.uk>
         <e0331787cd2ab96deed8be162223585416ed4a97.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-04-09 at 16:26 +0800, Ian Kent wrote:
> On Fri, 2021-04-09 at 01:35 +0000, Al Viro wrote:
> > On Fri, Apr 09, 2021 at 09:15:06AM +0800, Ian Kent wrote:
> > > +		parent = kernfs_dentry_node(dentry->d_parent);
> > > +		if (parent) {
> > > +			const void *ns = NULL;
> > > +
> > > +			if (kernfs_ns_enabled(parent))
> > > +				ns = kernfs_info(dentry->d_parent-
> > > > d_sb)->ns;
> > 
> > 	For any dentry d, we have d->d_parent->d_sb == d->d_sb.  All
> > the time.
> > If you ever run into the case where that would not be true, you've
> > found
> > a critical bug.
> 
> Right, yes.
> 
> > > +			kn = kernfs_find_ns(parent, dentry-
> > > > d_name.name, ns);
> > > +			if (kn)
> > > +				goto out_bad;
> > > +		}
> > 
> > Umm...  What's to prevent a race with successful rename(2)?  IOW,
> > what's
> > there to stabilize ->d_parent and ->d_name while we are in that
> > function?
> 
> Indeed, glad you looked at this.
> 
> Now I'm wondering how kerfs_iop_rename() protects itself from
> concurrent kernfs_rename_ns() ... 

As I thought ... I haven't done an exhaustive search but I can't find
any file system that doesn't call back into kernfs from
kernfs_syscall_ops (if provided at kernfs root creation).

I don't see anything that uses kernfs that defines a .rename() op
but if there was one it would be expected to call back into kernfs
at which point it would block on kernfs_mutex (kernfs_rwsem) until
it's released.

So I don't think there can be changes in this case due to the lock
taken just above the code your questioning.

I need to think a bit about whether the dentry being negative (ie.
not having kernfs node) could allow bad things to happen ...

Or am I misunderstanding the race your pointing out here?

Ian

