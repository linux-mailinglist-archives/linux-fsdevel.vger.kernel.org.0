Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA865777A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 02:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfF0Aip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 20:38:45 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:38397 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728920AbfF0Aio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:38:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2B4A473A;
        Wed, 26 Jun 2019 20:38:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 26 Jun 2019 20:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        ihe2qn6NE+dbP+hWMlfokm/JcFPS71JobWB9K4KtgEg=; b=bltSty7+CDPS15nf
        c8/dLStnwJjH2NiKy4QOWUFT9A+sNuK5buS60w06U6GqBAfGaMmkdD3SSj13Qdh1
        xyZ3IOYHsDCqVaHdu2QBIZyJUkvUR2+BrUA3B5ItPLCbBd5HQv12Gns89LPaSSNL
        c1ByuK51IU+sLMl5Z6dYFu8OkkRsf3NTje+rokUV9sNmufP7+tu3XfQkuXxfW3TK
        5VMg3VvcOQSc/Dvx7pFTBSS6H7TqSt8c1NL2jyHCFSag3Q55stGp8SSebqCJ8L2S
        vY/bQRdtLbp4C/CoJ9DVrXE+kz1UkS8W9cXItauqCXTDrzLU5ufdNIHDBHGg2Zlb
        fhJPFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=ihe2qn6NE+dbP+hWMlfokm/JcFPS71JobWB9K4Ktg
        Eg=; b=sL4w0IvwD3VR2WqVm1ezJJA78jXzqiLfGDSowz5eLKjBPWNo04mKaBYUZ
        G4/puI0sbPxvRBELpDERrk6jctUQ/iVpmMF+2NMhnKPYJdvBbyHtQ+U+NryO9LQO
        Tn6Pwjagdh82EEsxP0Q0wS0uihzuXNVwOtOWdle9xQAJySft2JJCin3fzBd1Y+Sj
        qQF5PajEfs5yKbbQXlHu0NZSWoXAE95HeqH+ORH44pU3Bg3OrWIu9S1y4Zqa1eb6
        XSLCGt952x9kxw8U5c09Jwv/1jotNWVd2yvPWOAaqZRkABWgwuRPHDs/lJEt3kJ7
        QE8Ly5pf64Exvef/mZecRXAVByP5w==
X-ME-Sender: <xms:EhAUXVi4U1pTNKiEm_sd60PRZJ6YABwrGoedFA7B7P1Jsh_ap1oiQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    dujeefrdehfeenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:EhAUXelumfsj5Io6oWJaTY0o0N2iPJsck6zWKm2a8lOdgYROj6aXuQ>
    <xmx:EhAUXQ-ArL1oaer84lmWcy7HoO8HQH6APgq9sYRffXPFPlM9sa2RCQ>
    <xmx:EhAUXW8wyKQIDL3k079GsD-vQmIkR2FLWJ4-gbWPNXfn6J29PRwwfw>
    <xmx:EhAUXaqScpSfHZTVBudsytkn_PQCgvLyX0pFnhFPAPTNz2DQ_2hfxg>
Received: from pluto.themaw.net (unknown [118.208.173.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id B76EC380083;
        Wed, 26 Jun 2019 20:38:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 4415D1C0064;
        Thu, 27 Jun 2019 08:38:37 +0800 (AWST)
Message-ID: <c9f8a840e7555648bc79a34512dbbbdb834e6ba3.camel@themaw.net>
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query
 syscall [ver #14]
From:   Ian Kent <raven@themaw.net>
To:     Christian Brauner <christian@brauner.io>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        mszeredi@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 27 Jun 2019 08:38:37 +0800
In-Reply-To: <20190626104704.dwjd4urpsmuheirc@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
         <20190626100525.irdehd24jowz5f75@brauner.io>
         <cf0361c2d1fc09ad0097f0da1e981b97ad39ab07.camel@themaw.net>
         <20190626104704.dwjd4urpsmuheirc@brauner.io>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-06-26 at 12:47 +0200, Christian Brauner wrote:
> On Wed, Jun 26, 2019 at 06:42:51PM +0800, Ian Kent wrote:
> > On Wed, 2019-06-26 at 12:05 +0200, Christian Brauner wrote:
> > > On Mon, Jun 24, 2019 at 03:08:45PM +0100, David Howells wrote:
> > > > Hi Al,
> > > > 
> > > > Here are a set of patches that adds a syscall, fsinfo(), that allows
> > > > attributes of a filesystem/superblock to be queried.  Attribute values
> > > > are
> > > > of four basic types:
> > > > 
> > > >  (1) Version dependent-length structure (size defined by type).
> > > > 
> > > >  (2) Variable-length string (up to PAGE_SIZE).
> > > > 
> > > >  (3) Array of fixed-length structures (up to INT_MAX size).
> > > > 
> > > >  (4) Opaque blob (up to INT_MAX size).
> > > > 
> > > > Attributes can have multiple values in up to two dimensions and all the
> > > > values of a particular attribute must have the same type.
> > > > 
> > > > Note that the attribute values *are* allowed to vary between dentries
> > > > within a single superblock, depending on the specific dentry that you're
> > > > looking at.
> > > > 
> > > > I've tried to make the interface as light as possible, so integer/enum
> > > > attribute selector rather than string and the core does all the
> > > > allocation
> > > > and extensibility support work rather than leaving that to the
> > > > filesystems.
> > > > That means that for the first two attribute types, sb->s_op->fsinfo()
> > > > may
> > > > assume that the provided buffer is always present and always big enough.
> > > > 
> > > > Further, this removes the possibility of the filesystem gaining access
> > > > to
> > > > the
> > > > userspace buffer.
> > > > 
> > > > 
> > > > fsinfo() allows a variety of information to be retrieved about a
> > > > filesystem
> > > > and the mount topology:
> > > > 
> > > >  (1) General superblock attributes:
> > > > 
> > > >       - The amount of space/free space in a filesystem (as statfs()).
> > > >       - Filesystem identifiers (UUID, volume label, device numbers, ...)
> > > >       - The limits on a filesystem's capabilities
> > > >       - Information on supported statx fields and attributes and IOC
> > > > flags.
> > > >       - A variety single-bit flags indicating supported capabilities.
> > > >       - Timestamp resolution and range.
> > > >       - Sources (as per mount(2), but fsconfig() allows multiple
> > > > sources).
> > > >       - In-filesystem filename format information.
> > > >       - Filesystem parameters ("mount -o xxx"-type things).
> > > >       - LSM parameters (again "mount -o xxx"-type things).
> > > > 
> > > >  (2) Filesystem-specific superblock attributes:
> > > > 
> > > >       - Server names and addresses.
> > > >       - Cell name.
> > > > 
> > > >  (3) Filesystem configuration metadata attributes:
> > > > 
> > > >       - Filesystem parameter type descriptions.
> > > >       - Name -> parameter mappings.
> > > >       - Simple enumeration name -> value mappings.
> > > > 
> > > >  (4) Mount topology:
> > > > 
> > > >       - General information about a mount object.
> > > >       - Mount device name(s).
> > > >       - Children of a mount object and their relative paths.
> > > > 
> > > >  (5) Information about what the fsinfo() syscall itself supports,
> > > > including
> > > >      the number of attibutes supported and the number of capability bits
> > > >      supported.
> > > 
> > > Phew, this patchset is a lot. It's good of course but can we please cut
> > > some of the more advanced features such as querying by mount id,
> > > submounts etc. pp. for now?
> > 
> > Did you mean the "vfs: Allow fsinfo() to look up a mount object by ID"
> > patch?
> > 
> > We would need to be very careful what was dropped.
> 
> Not dropped as in never implement but rather defer it by one merge
> window to give us a) more time to review and settle the interface while
> b) not stalling the overall patch.

Sure, and I'm not saying something like what you recommend shouldn't
be done.

I'm working on user space mount table improvements that I want to
get done ahead of the merge.

Well, I would be but there's still mount-api conversions that need
to be done so that fsinfo() patches don't end up with endless merge
conflicts. The fsinfo() super block method will result in changes
in the same area as the mount-api changes.

The mount-api changes are proving to be a bit of a challenge.

Anyway, the plan is to use the mount table handling improvements to
try and
locate bugs and missing or not quite right functionality.

> 
> > For example, I've found that the patch above is pretty much essential
> > for fsinfo() to be useful from user space.
> 
> Yeah, but that interface is not clearly defined yet as can be seen from
> the commit message and that's what's bothering me most.

Yeah, but updating my cloned branch hasn't been difficult.

There's a certain amount of functionality that I'd like to see
retained for when I get back to the user space development.

Using the notifications changes are something I'm not likely
to get to for quite some time so breaking those out into a
separate branch (like they were not so long ago) would be
more sensible IMHO.

There may be some other bits that David can identify too.

Ian

