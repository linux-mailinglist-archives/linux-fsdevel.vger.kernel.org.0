Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A539056710
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfFZKm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 06:42:58 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35821 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbfFZKm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:42:57 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 16F444F1;
        Wed, 26 Jun 2019 06:42:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 26 Jun 2019 06:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        DJMU2zwHUW3gzuEp2RRHl9iyNK7pBQ4EI0maafWdFjs=; b=jNmhJUVjbAaAI9V2
        KT5pFZgw+Chy7LckN54smOumJg6L7cHrL5/wZYVPMtSyrJwe5+XKC5rM8siBveeO
        MCFhoXD227UmN+ILZ4vI/NtXx6/AV4Cpbdl8cWR3VzCd87wY7jpFhIt7N07S7mxU
        sVL3Fxj+C3ZIRrdG0sqZY+s6ka9qaBfoI05REJa462rSJvpaN0MwF5JbrBmg8BoO
        JbSacm8i76TXl377m0F509cJ1zXH9jYIswhLxT+mjH4Bw+MNWBdcDRityZNZQE9p
        XcsGfG2dSGd32+z6TcwoY07wikP7wuQv72vf/j7hCeiyJlYHkPHheVL0KqXmf+7N
        BTUstA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=DJMU2zwHUW3gzuEp2RRHl9iyNK7pBQ4EI0maafWdF
        js=; b=J81cM/y5Qv8TJSHwgP6T98jMzz7CtJgo4bNqHzzbNiyJA2zAlHby2bYem
        rI5P3K9oWnwB+LO7bN/o4N+YWMR0r/jZ6ad+Bd5drPJNIIdpS6rg8M6QzC7/i8Hq
        NT4onCJEHO8lrmngSNBQ8dXTIqfLw1cFezOpkeCm8qdb8dD9H21Cpi3Ht9Z9Ymja
        SVqdN/g8eoe9EjhS83L0le+PeJXwzUC8fYkmwgAySg/FPZHy8yDN9B6wro5RuXvf
        +CnRYa0fxHwFKSP0nDQ4ycWyOMizXIscCRRXNxEZBcpXbOvP4pQPEdt1Pze35vaZ
        fOlrQnkObtYEcsds8mBpNTS+Meb9g==
X-ME-Sender: <xms:L0wTXQH-j6uhxRYmaBrSG_p9iQAdzKwZ8mU8QNLn9VHbMdYkvX-r4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    dujeefrdehfeenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:L0wTXYVt-fEVWhHPi3giRRym842XKjVeSxhlHwnuYb-qMDkIV2yaVw>
    <xmx:L0wTXSa325skPZn6UzAmn1dgOEW9ATMgoiHVR2kotGaDYccoRyNErg>
    <xmx:L0wTXec0k7O9wVNRQuXdqpRq9w6CNvcJGYK0Dr8YUb_pNQqBwLpIrg>
    <xmx:L0wTXbYWYqm8cpMlKggb4hcKErfy8-4svtiyFXsGH4_R4bYJHBjdAA>
Received: from pluto.themaw.net (unknown [118.208.173.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id B2B7B8005A;
        Wed, 26 Jun 2019 06:42:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 2F0081C014F;
        Wed, 26 Jun 2019 18:42:51 +0800 (AWST)
Message-ID: <cf0361c2d1fc09ad0097f0da1e981b97ad39ab07.camel@themaw.net>
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query
 syscall [ver #14]
From:   Ian Kent <raven@themaw.net>
To:     Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 Jun 2019 18:42:51 +0800
In-Reply-To: <20190626100525.irdehd24jowz5f75@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
         <20190626100525.irdehd24jowz5f75@brauner.io>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-06-26 at 12:05 +0200, Christian Brauner wrote:
> On Mon, Jun 24, 2019 at 03:08:45PM +0100, David Howells wrote:
> > Hi Al,
> > 
> > Here are a set of patches that adds a syscall, fsinfo(), that allows
> > attributes of a filesystem/superblock to be queried.  Attribute values are
> > of four basic types:
> > 
> >  (1) Version dependent-length structure (size defined by type).
> > 
> >  (2) Variable-length string (up to PAGE_SIZE).
> > 
> >  (3) Array of fixed-length structures (up to INT_MAX size).
> > 
> >  (4) Opaque blob (up to INT_MAX size).
> > 
> > Attributes can have multiple values in up to two dimensions and all the
> > values of a particular attribute must have the same type.
> > 
> > Note that the attribute values *are* allowed to vary between dentries
> > within a single superblock, depending on the specific dentry that you're
> > looking at.
> > 
> > I've tried to make the interface as light as possible, so integer/enum
> > attribute selector rather than string and the core does all the allocation
> > and extensibility support work rather than leaving that to the filesystems.
> > That means that for the first two attribute types, sb->s_op->fsinfo() may
> > assume that the provided buffer is always present and always big enough.
> > 
> > Further, this removes the possibility of the filesystem gaining access to
> > the
> > userspace buffer.
> > 
> > 
> > fsinfo() allows a variety of information to be retrieved about a filesystem
> > and the mount topology:
> > 
> >  (1) General superblock attributes:
> > 
> >       - The amount of space/free space in a filesystem (as statfs()).
> >       - Filesystem identifiers (UUID, volume label, device numbers, ...)
> >       - The limits on a filesystem's capabilities
> >       - Information on supported statx fields and attributes and IOC flags.
> >       - A variety single-bit flags indicating supported capabilities.
> >       - Timestamp resolution and range.
> >       - Sources (as per mount(2), but fsconfig() allows multiple sources).
> >       - In-filesystem filename format information.
> >       - Filesystem parameters ("mount -o xxx"-type things).
> >       - LSM parameters (again "mount -o xxx"-type things).
> > 
> >  (2) Filesystem-specific superblock attributes:
> > 
> >       - Server names and addresses.
> >       - Cell name.
> > 
> >  (3) Filesystem configuration metadata attributes:
> > 
> >       - Filesystem parameter type descriptions.
> >       - Name -> parameter mappings.
> >       - Simple enumeration name -> value mappings.
> > 
> >  (4) Mount topology:
> > 
> >       - General information about a mount object.
> >       - Mount device name(s).
> >       - Children of a mount object and their relative paths.
> > 
> >  (5) Information about what the fsinfo() syscall itself supports, including
> >      the number of attibutes supported and the number of capability bits
> >      supported.
> 
> Phew, this patchset is a lot. It's good of course but can we please cut
> some of the more advanced features such as querying by mount id,
> submounts etc. pp. for now?

Did you mean the "vfs: Allow fsinfo() to look up a mount object by ID"
patch?

We would need to be very careful what was dropped.

For example, I've found that the patch above is pretty much essential
for fsinfo() to be useful from user space.

> I feel this would help with review and since your interface is
> extensible it's really not a big deal if we defer fancy features to
> later cycles after people had more time to review and the interface has
> seen some exposure.
> 
> The mount api changes over the last months have honestly been so huge
> that any chance to make the changes smaller and easier to digest we
> should take. (I'm really not complaining. Good that the work is done and
> it's entirely ok that it's a lot of code.)
> 
> It would also be great if after you have dropped some stuff from this
> patchset and gotten an Ack we could stuff it into linux-next for some
> time because it hasn't been so far...
> 
> Christian

