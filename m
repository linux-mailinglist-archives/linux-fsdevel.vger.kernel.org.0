Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD8723C310
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 03:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHEBd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 21:33:56 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:47787 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgHEBdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:33:55 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id ECBB9C6C;
        Tue,  4 Aug 2020 21:33:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Aug 2020 21:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        FgynrCS35t+Bb0YX8gjfGwWuq/yMZ4J2VELd+N8H7BI=; b=ETmZ1YajbBIgESVe
        Ua4pz7szM2WGYY5v4Cu+mrMf7ztyifMqPrdnjWj/LAAsF+8bsoj3Nn84EZDLrWIk
        L0ToE3TMG44ne4l1NiLSKISNJDM5pZeZMwKLJIiTl6hP5Cd5aABfslWSx6F+h6Ex
        r7zPEe8efX0kNHDh5D6wIg7xjbLAnynkN5968NzlkTP+jzIMwa7v5PW1kBJD3sUz
        de3icdVla3m1oJstQdU6VvNIvzUcPLspndSbQcGZ73ymkz158/goA4wlUgQSEd6Q
        Ny8GPVp3ca9KDxLeKn9CePrNn0SLmdoRc2n0xo3xlIvvmxyIdToE0xms5JF3GRPh
        bN1iEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=FgynrCS35t+Bb0YX8gjfGwWuq/yMZ4J2VELd+N8H7
        BI=; b=GC+il859d8TmcV47HgpBL9N46aRTHV+7XxGjkgOjmHOyIZkwNW57N/B75
        zUwplzERnMRetwNDh6YOT0NkH5zFSVU0vC6UlP6vlCUW3hy2f9+sNkfJL52+PNL2
        qELkH7mXxFa5CdH9DjZBNjqp0hhljEKgTFTbesHZFB+RNw+O3YUzN4zdS91cAx09
        bYLIJiQAQKP+dpTF1l4pLjF7Uu9Eg2Tghw5z7aCcw3iPgV1J/kqJsTmx1CKNTlVi
        GdQQEIV3OPiCuZ4iHPJtyMilAAsGnq4E/kJYN64976YSLNgWLAT0vn3FaKhFW3Ex
        KokPW+xvg5DusY8VuXPVWuONg/dBw==
X-ME-Sender: <xms:gAwqX-UW0uR18mHggpye3C_wfhKRRFmCObwRjQf3o87fOgkFhHrKSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeejgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecukfhp
    peehkedrjedrvdehhedrvddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:gAwqX6mZFyemB4mMthm_drtrXJiGpITbypQR-z9_UPav4djBuvZ3qA>
    <xmx:gAwqXyabRgY8ElTyvdSkiauLn7cG-wG6-u8M0wOpOdDaOqY-jSwqZA>
    <xmx:gAwqX1WfX1uY2Z9MVE-U0R3Rw9YXV2lmhbX23pc7ox9F-9gpbQBp5Q>
    <xmx:gQwqX1g_HyIOGI2h83NXPwX8rAu2TeVeYsGgmXvhMOrXLpQ8M0ZSoY6LdIU>
Received: from mickey.themaw.net (58-7-255-220.dyn.iinet.net.au [58.7.255.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id E351930600B2;
        Tue,  4 Aug 2020 21:33:47 -0400 (EDT)
Message-ID: <dd1a41a129cd6e8d13525a14807e6dc65b52e0bf.camel@themaw.net>
Subject: Re: [GIT PULL] Filesystem Information
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 09:33:44 +0800
In-Reply-To: <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
References: <1842689.1596468469@warthog.procyon.org.uk>
         <1845353.1596469795@warthog.procyon.org.uk>
         <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
         <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
         <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-04 at 16:36 +0200, Miklos Szeredi wrote:
> On Tue, Aug 4, 2020 at 4:15 AM Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2020-08-03 at 18:42 +0200, Miklos Szeredi wrote:
> > > On Mon, Aug 3, 2020 at 5:50 PM David Howells <dhowells@redhat.com
> > > >
> > > wrote:
> > > > Hi Linus,
> > > > 
> > > > Here's a set of patches that adds a system call, fsinfo(), that
> > > > allows
> > > > information about the VFS, mount topology, superblock and files
> > > > to
> > > > be
> > > > retrieved.
> > > > 
> > > > The patchset is based on top of the mount notifications
> > > > patchset so
> > > > that
> > > > the mount notification mechanism can be hooked to provide event
> > > > counters
> > > > that can be retrieved with fsinfo(), thereby making it a lot
> > > > faster
> > > > to work
> > > > out which mounts have changed.
> > > > 
> > > > Note that there was a last minute change requested by Miklós:
> > > > the
> > > > event
> > > > counter bits got moved from the mount notification patchset to
> > > > this
> > > > one.
> > > > The counters got made atomic_long_t inside the kernel and __u64
> > > > in
> > > > the
> > > > UAPI.  The aggregate changes can be assessed by comparing pre-
> > > > change tag,
> > > > fsinfo-core-20200724 to the requested pull tag.
> > > > 
> > > > Karel Zak has created preliminary patches that add support to
> > > > libmount[*]
> > > > and Ian Kent has started working on making systemd use these
> > > > and
> > > > mount
> > > > notifications[**].
> > > 
> > > So why are you asking to pull at this stage?
> > > 
> > > Has anyone done a review of the patchset?
> > 
> > I have been working with the patch set as it has evolved for quite
> > a
> > while now.
> > 
> > I've been reading the kernel code quite a bit and forwarded
> > questions
> > and minor changes to David as they arose.
> > 
> > As for a review, not specifically, but while the series implements
> > a
> > rather large change it's surprisingly straight forward to read.
> > 
> > In the time I have been working with it I haven't noticed any
> > problems
> > except for those few minor things that I reported to David early on
> > (in
> > some cases accompanied by simple patches).
> > 
> > And more recently (obviously) I've been working with the mount
> > notifications changes and, from a readability POV, I find it's the
> > same as the fsinfo() code.
> > 
> > > I think it's obvious that this API needs more work.  The
> > > integration
> > > work done by Ian is a good direction, but it's not quite the full
> > > validation and review that a complex new API needs.
> > 
> > Maybe but the system call is fundamental to making notifications
> > useful
> > and, as I say, after working with it for quite a while I don't fell
> > there's missing features (that David hasn't added along the way)
> > and
> > have found it provides what's needed for what I'm doing (for mount
> > notifications at least).
> 
> Apart from the various issues related to the various mount ID's and
> their sizes, my general comment is (and was always): why are we
> adding
> a multiplexer for retrieval of mostly unrelated binary structures?
> 
> <linux/fsinfo.h> is 345 lines.  This is not a simple and clean API.
> 
> A simple and clean replacement API would be:
> 
> int get_mount_attribute(int dfd, const char *path, const char
> *attr_name, char *value_buf, size_t buf_size, int flags);
> 
> No header file needed with dubiously sized binary values.
> 
> The only argument was performance, but apart from purely synthetic
> microbenchmarks that hasn't been proven to be an issue.
> 
> And notice how similar the above interface is to getxattr(), or the
> proposed readfile().  Where has the "everything is  a file"
> philosophy
> gone?

Maybe, but that philosophy (in a roundabout way) is what's resulted
in some of the problems we now have. Granted it's blind application
of that philosophy rather than the philosophy itself but that is
what happens.

I get that your comments are driven by the way that philosophy should
be applied which is more of a "if it works best doing it that way then
do it that way, and that's usually a file".

In this case there is a logical division of various types of file
system information and the underlying suggestion is maybe it's time
to move away from the "everything is a file" hard and fast rule,
and get rid of some of the problems that have resulted from it.

The notifications is an example, yes, the delivery mechanism is
a "file" but the design of the queueing mechanism makes a lot of
sense for the throughput that's going to be needed as time marches
on. Then there's different sub-systems each with unique information
that needs to be deliverable some other way because delivering "all"
the information via the notification would be just plain wrong so
a multi-faceted information delivery mechanism makes the most
sense to allow specific targeted retrieval of individual items of
information.

But that also supposes your at least open to the idea that "maybe
not everything should be a file".

> 
> I think we already lost that with the xattr API, that should have
> been
> done in a way that fits this philosophy.  But given that we  have "/"
> as the only special purpose char in filenames, and even repetitions
> are allowed, it's hard to think of a good way to do that.  Pity.
> 
> Still I think it would be nice to have a general purpose attribute
> retrieval API instead of the multiplicity of binary ioctls, xattrs,
> etc.
> 
> Is that totally crazy?  Nobody missing the beauty in recently
> introduced APIs?
> 
> Thanks,
> Miklos

